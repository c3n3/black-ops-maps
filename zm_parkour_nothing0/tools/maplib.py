"""Helpers for editing zm_parkour_nothing0.map (BO3 iwmap 4, LF line endings)."""

import itertools
import math
import re
import uuid

WOOD = "t7_wood_planks_damaged_teak"
WHITE = "testmap_white_240"
IRON = "t7_metal_worn_iron_dark"
CAULK = "caulk"
BLOOD = "t7_decal_blood_smear_01"
GREEN = "t7_glass_green_opaque_01"
CLIP_AI = "clip_ai"
VOLUME = "volume"
TRIGGER = "trigger"

LIGHTSTATES = '"lightingstate1" "1"\n"lightingstate2" "1"\n"lightingstate3" "1"\n"lightingstate4" "1"\n'


class Map:
    def __init__(self, path):
        self.path = path
        text = open(path, encoding="utf-8", newline="").read()
        assert "\r\n" not in text
        self.header, rest = text.split("// entity 0\n", 1)
        self.ents = re.split(r"(?m)^// entity \d+\n", "// entity 0\n" + rest)[1:]
        ws = self.ents[0]
        self.ws_brushes = re.findall(r"(?ms)^// brush \d+\n\{\n.*?^\}\n", ws)
        self.ws_head = ws[: ws.index(self.ws_brushes[0])]
        assert ws == self.ws_head + "".join(self.ws_brushes) + "}\n"
        self.ws_brushes = [re.sub(r"(?s)^// brush \d+\n\{\n(.*)\}\n$", r"\1", b) for b in self.ws_brushes]

    def kv(self, i):
        return kv(self.ents[i])

    def find(self, **want):
        return [i for i in range(len(self.ents)) if all(self.kv(i).get(k) == v for k, v in want.items())]

    def add_world(self, *bodies):
        self.ws_brushes += bodies

    def add(self, *ents):
        self.ents += ents

    def save(self, path=None):
        ws = self.ws_head + "".join(f"// brush {i}\n{{\n{b}}}\n" for i, b in enumerate(self.ws_brushes)) + "}\n"
        out = self.header + f"// entity 0\n{ws}"
        for i, e in enumerate(self.ents[1:], 1):
            out += f"// entity {i}\n" + e
        open(path or self.path, "w", encoding="utf-8", newline="").write(out)


def kv(block):
    return dict(re.findall(r'(?m)^"([^"]+)" "([^"]*)"', block))


def guid():
    return "{" + str(uuid.uuid4()).upper() + "}"


def num(v):
    v = round(v, 4)
    return str(int(v)) if v == int(v) else repr(v)


def _sub(a, b):
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])


def _add(a, b, s=1.0):
    return (a[0] + b[0] * s, a[1] + b[1] * s, a[2] + b[2] * s)


def _cross(a, b):
    return (a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0])


def _dot(a, b):
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2]


def _norm(a):
    l = math.sqrt(_dot(a, a))
    return (a[0] / l, a[1] / l, a[2] / l)


def d(deg):
    r = math.radians(deg)
    return (math.cos(r), math.sin(r), 0.0)


def brush(planes, mat):
    """planes: [(point, inward normal[, material])]. This map's convention: (p2-p1) x (p3-p1) points into the brush.
    Validates that the result is a closed convex solid with every plane used."""
    body = f' guid "{guid()}"\n'
    solved = []
    for pl in planes:
        p, n = pl[0], _norm(pl[1])
        m = pl[2] if len(pl) > 2 else mat
        u = _norm(_cross(n, (0, 0, 1)) if abs(n[2]) < 0.9 else _cross(n, (1, 0, 0)))
        v = _cross(n, u)
        pts = (p, _add(p, u, 256), _add(p, v, 256))
        body += " " + " ".join(f"( {num(a)} {num(b)} {num(c)} )" for a, b, c in pts)
        body += f" {m} 64 64 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0\n"
        # re-derive from the rounded points, exactly as the compiler will
        r = [tuple(round(c, 4) for c in q) for q in pts]
        nn = _norm(_cross(_sub(r[1], r[0]), _sub(r[2], r[0])))
        solved.append((nn, _dot(nn, r[0])))
    _validate(solved)
    return body


def _validate(planes):
    verts = []
    for (n1, d1), (n2, d2), (n3, d3) in itertools.combinations(planes, 3):
        det = _dot(n1, _cross(n2, n3))
        if abs(det) < 1e-9:
            continue
        x = tuple((d1 * _cross(n2, n3)[i] + d2 * _cross(n3, n1)[i] + d3 * _cross(n1, n2)[i]) / det for i in range(3))
        if all(_dot(n, x) >= dd - 1e-2 for n, dd in planes):
            verts.append(x)
    assert len(verts) >= 4, "open brush"
    for n, dd in planes:
        assert sum(1 for v in verts if abs(_dot(n, v) - dd) < 1e-2) >= 3, "unused plane"


def solid(faces, mat):
    """Convex brush from faces given as 3 points each (any winding); normals are turned toward the centroid."""
    pts = [p for f in faces for p in f]
    c = tuple(sum(p[i] for p in pts) / len(pts) for i in range(3))
    planes = []
    for a, b, e in faces:
        n = _norm(_cross(_sub(b, a), _sub(e, a)))
        if _dot(n, _sub(c, a)) < 0:
            n = (-n[0], -n[1], -n[2])
        planes.append((a, n))
    return brush(planes, mat)


def slab(z0, z1, top=None, bottom=None):
    return [((0, 0, z0), (0, 0, 1)) + ((bottom,) if bottom else ()), ((0, 0, z1), (0, 0, -1)) + ((top,) if top else ())]


def box(x0, x1, y0, y1, z0, z1, mat, faces=None):
    """Axis box. faces: optional {'-x','+x','-y','+y','-z','+z': material}."""
    f = faces or {}
    return brush([((x0, 0, 0), (1, 0, 0), f.get("-x", mat)), ((x1, 0, 0), (-1, 0, 0), f.get("+x", mat)),
                  ((0, y0, 0), (0, 1, 0), f.get("-y", mat)), ((0, y1, 0), (0, -1, 0), f.get("+y", mat)),
                  ((0, 0, z0), (0, 0, 1), f.get("-z", mat)), ((0, 0, z1), (0, 0, -1), f.get("+z", mat))], mat)


def ngon(cx, cy, apothem, sides, z0, z1, mat, top=None, bottom=None, side=None, rot=0.0):
    """Regular prism with flat faces at angles rot + k*360/sides."""
    planes = []
    for k in range(sides):
        dx, dy, _ = d(rot + 360 * k / sides)
        planes.append(((cx + apothem * dx, cy + apothem * dy, 0), (-dx, -dy, 0), side or mat))
    planes.append(((0, 0, z0), (0, 0, 1), bottom or mat))
    planes.append(((0, 0, z1), (0, 0, -1), top or mat))
    return brush(planes, mat)


def octagon(cx, cy, apothem, z0, z1, mat, **kw):
    return ngon(cx, cy, apothem, 8, z0, z1, mat, **kw)


def stroke_xz(y_front, x0, z0, x1, z1, width, depth, front, rest=CAULK):
    """A letter stroke on a board facing -y: segment (x0,z0)-(x1,z1) in the xz plane, `width` wide, `depth` thick."""
    ux, uz = x1 - x0, z1 - z0
    l = math.hypot(ux, uz)
    ux, uz = ux / l, uz / l
    px, pz = -uz, ux  # perpendicular in xz
    h = width / 2
    planes = [
        ((0, y_front, 0), (0, 1, 0), front),                       # front face (seen from -y)
        ((0, y_front + depth, 0), (0, -1, 0), rest),               # back, against the board
        ((x0 + px * h, 0, z0 + pz * h), (-px, 0, -pz), rest),      # the two long sides
        ((x0 - px * h, 0, z0 - pz * h), (px, 0, pz), rest),
        ((x0 - ux * h * 0.5, 0, z0 - uz * h * 0.5), (ux, 0, uz), rest),  # ends, extended a little so joints overlap
        ((x1 + ux * h * 0.5, 0, z1 + uz * h * 0.5), (-ux, 0, -uz), rest),
    ]
    return brush(planes, rest)


def entity(keys, brushes=()):
    """keys: list of (k, v) in order."""
    out = "{\n" + f'guid "{guid()}"\n' + "".join(f'"{k}" "{v}"\n' for k, v in keys)
    for i, b in enumerate(brushes):
        out += f"// brush {i}\n{{\n{b}}}\n"
    return out + "}\n"


def origin(x, y, z):
    return f"{num(x)} {num(y)} {num(z)}"


def prefab(model, x, y, z=0, angles=None):
    keys = [("classname", "misc_prefab")]
    if angles:
        keys.append(("angles", angles))
    return entity(keys + [("model", model), ("origin", origin(x, y, z))])


def model(name, x, y, z, angles=None, scale=1):
    keys = [("classname", "misc_model")]
    if angles:
        keys.append(("angles", angles))
    return entity(keys + [("model", name), ("origin", origin(x, y, z)), ("modelscale", num(scale)), ("static", "1")]
                  + [(f"lightingstate{i}", "1") for i in range(1, 5)])


def struct(x, y, z, **keys):
    return entity([("classname", "script_struct"), ("origin", origin(x, y, z))] + list(keys.items()) + [("_color", "1 0 0")])


def riser(x, y, zone):
    return entity([("classname", "script_struct"), ("angles", "0 360 0"), ("origin", origin(x, y, 0)),
                   ("script_noteworthy", "riser_location"), ("script_string", "find_flesh"),
                   ("targetname", f"{zone}_spawners"), ("_color", "1 0 0")])


def fx(fxdef, x, y, z, angles=None):
    keys = [("classname", "fx")]
    if angles:
        keys.append(("angles", angles))
    return entity(keys + [("delay", "-15017"), ("fxdef", fxdef), ("origin", origin(x, y, z))]
                  + [(f"fxstate{i}", "1") for i in range(1, 5)] + [("primaryLightFraction", "1"), ("timescale", "1")])


def light(x, y, z, color, stops, radius, primary="PRIMARY_OMNI", **extra):
    keys = [("classname", "light"), ("PRIMARY_TYPE", primary), ("_color", color), ("origin", origin(x, y, z)),
            ("radius", num(radius)), ("stops", num(stops)), ("ENABLE_FALLOFF", "1"), ("falloffdistance", "30"),
            ("PRIMARY_NOSHADOWMAP", "1"), ("client_server", "ClientSide"), ("excludeDedicated", "Off"),
            ("shadowUpdate", "Never"), ("name", "light"), ("fov_outer", "90")]
    keys += list(extra.items()) + [(f"lightingstate{i}", "1") for i in range(1, 5)]
    return entity(keys)


def volume(name, x0, x1, y0, y1, z0=-520, z1=424):
    return entity([("classname", "info_volume"), ("script_noteworthy", "player_volume"),
                   ("target", f"{name}_spawners"), ("targetname", name)],
                  [box(x0, x1, y0, y1, z0, z1, VOLUME)])


def switch(x, y, handle_name, z=0):
    """Stock power-switch models without the power trigger. At angles 0 the wall is on +y; player stands on -y.
    The trigger is spawned in script from the handle's position."""
    return [
        model("p7_zm_der_pswitch_body", x, y + 2, z - 1),
        entity([("classname", "script_model"), ("angles", "0 0 90"), ("model", "p7_zm_der_pswitch_handle"),
                ("origin", origin(x - 1, y - 7, z + 45)), ("targetname", handle_name), ("client_server", "ServerSide"),
                ("modelscale", "1")] + [(f"lightingstate{i}", "1") for i in range(1, 5)]),
    ]
