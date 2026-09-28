"""One-off: rebuild the lighthouse as a tapered octagon with spiral stairs, top wall buy and endgame switch (design ai/5.md corrections)."""

import math
import re
import sys
import uuid

MAP = sys.argv[1]
YC = 24576
WALL = "testmap_white_240"
WOOD = "t7_wood_planks_damaged_teak"

# Tower: outer apothem 288 at the base tapering to 192 at the top of the walls
Z_WALL = 496          # walls stop under the gallery floor
Z_GAL = 512           # gallery floor top = last stair
A_BASE, A_TOP, THICK = 288, 192, 24
SLOPE = (A_BASE - A_TOP) / Z_WALL
DOOR_HALF, DOOR_H = 40, 128
A_GAL, A_HATCH = 256, 168
STEP_H, R_IN = 16, 56
N_STEPS = Z_GAL // STEP_H
STAIR_START, STAIR_END = 292.5, 247.5 + 360   # clockwise gap left free over the door
HATCH_WEDGES = (180, 225)                     # gallery floor removed over the last steps
Z_LANTERN = 672
LAMP_Z = 600

text = open(MAP, encoding="utf-8", newline="").read()
assert "\r\n" not in text
header, rest = text.split("// entity 0\n", 1)
blocks = re.split(r"(?m)^// entity \d+\n", "// entity 0\n" + rest)[1:]


def guid():
    return "{" + str(uuid.uuid4()).upper() + "}"


def num(v):
    v = round(v, 4)
    return str(int(v)) if v == int(v) else repr(v)


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2])


def add(a, b, s=1.0):
    return (a[0] + b[0] * s, a[1] + b[1] * s, a[2] + b[2] * s)


def cross(a, b):
    return (a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0])


def norm(a):
    l = math.sqrt(a[0] ** 2 + a[1] ** 2 + a[2] ** 2)
    return (a[0] / l, a[1] / l, a[2] / l)


def d(deg, z=0.0):
    r = math.radians(deg)
    return (math.cos(r), math.sin(r), z)


def brush(planes, mat):
    """planes: [(point, inward normal)]. This map's convention: (p2-p1) x (p3-p1) points into the brush."""
    tex = f"{mat} 64 64 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0"
    body = f' guid "{guid()}"\n'
    for p, n in planes:
        n = norm(n)
        u = norm(cross(n, (0, 0, 1)) if abs(n[2]) < 0.9 else cross(n, (1, 0, 0)))
        v = cross(n, u)
        p = add(p, (0, YC, 0))
        pts = (p, add(p, u, 256), add(p, v, 256))
        got = norm(cross(sub(pts[1], pts[0]), sub(pts[2], pts[0])))
        assert all(abs(got[i] - n[i]) < 1e-6 for i in range(3))
        body += " " + " ".join(f"( {num(a)} {num(b)} {num(c)} )" for a, b, c in pts) + f" {tex}\n"
    return body


def floor_ceiling(z0, z1):
    return [((0, 0, z0), (0, 0, 1)), ((0, 0, z1), (0, 0, -1))]


def octagon(apothem, z0, z1, mat):
    planes = [(tuple(apothem * c for c in d(45 * k)), tuple(-c for c in d(45 * k))) for k in range(8)]
    return brush(planes + floor_ceiling(z0, z1), mat)


def side_planes(a_lo, a_hi):
    """Vertical planes through the tower axis keeping angles between a_lo and a_hi."""
    lo, hi = math.radians(a_lo), math.radians(a_hi)
    return [((0, 0, 0), (-math.sin(lo), math.cos(lo), 0)), ((0, 0, 0), (math.sin(hi), -math.cos(hi), 0))]


def tapered(phi, a):
    """Plane x.d + SLOPE*z = a (the tapered wall faces)."""
    dx, dy, _ = d(phi)
    return (a * dx, a * dy, 0), (dx, dy, SLOPE)


def box(x0, x1, y0, y1, z0, z1, mat):
    return brush([((x0, 0, 0), (1, 0, 0)), ((x1, 0, 0), (-1, 0, 0)),
                  ((0, y0, 0), (0, 1, 0)), ((0, y1, 0), (0, -1, 0))] + floor_ceiling(z0, z1), mat)


new_brushes = []
new_brushes.append(octagon(400, -64, 0, WOOD))                      # island
new_brushes.append(octagon(56, 0, Z_WALL, WALL))                     # central column
for k in range(8):                                                   # tapered walls
    phi = 45 * k
    op, on = tapered(phi, A_BASE)
    ip, inn = tapered(phi, A_BASE - THICK)
    outer = (op, tuple(-c for c in on))
    inner = (ip, inn)
    lo, hi = side_planes(phi - 22.5, phi + 22.5)
    if phi != 270:
        new_brushes.append(brush([outer, inner, lo, hi] + floor_ceiling(0, Z_WALL), WALL))
        continue
    # south wall: door opening x -40..40, z 0..128
    new_brushes.append(brush([outer, inner, lo, ((-DOOR_HALF, 0, 0), (-1, 0, 0))] + floor_ceiling(0, Z_WALL), WALL))
    new_brushes.append(brush([outer, inner, hi, ((DOOR_HALF, 0, 0), (1, 0, 0))] + floor_ceiling(0, Z_WALL), WALL))
    new_brushes.append(brush([outer, inner, ((-DOOR_HALF, 0, 0), (1, 0, 0)), ((DOOR_HALF, 0, 0), (-1, 0, 0))]
                             + floor_ceiling(DOOR_H, Z_WALL), WALL))
for k in range(8):                                                   # gallery floor, hatch over the stair top
    phi = 45 * k
    lo, hi = side_planes(phi - 22.5, phi + 22.5)
    ring_out = (tuple(A_GAL * c for c in d(phi)), tuple(-c for c in d(phi)))
    ring_in = (tuple(A_HATCH * c for c in d(phi)), d(phi))
    new_brushes.append(brush([ring_out, ring_in, lo, hi] + floor_ceiling(Z_WALL, Z_GAL), WOOD))
    if phi not in HATCH_WEDGES:
        inner_edge = (tuple(A_HATCH * c for c in d(phi)), tuple(-c for c in d(phi)))
        new_brushes.append(brush([inner_edge, lo, hi] + floor_ceiling(Z_WALL, Z_GAL), WOOD))
step_deg = (STAIR_END - STAIR_START) / N_STEPS
half = math.radians(step_deg / 2)
for i in range(1, N_STEPS + 1):                                      # spiral stairs
    t0 = STAIR_START + (i - 1) * step_deg
    t1 = t0 + step_deg
    mid = d((t0 + t1) / 2)
    z = i * STEP_H
    r_out = (A_BASE - THICK) - SLOPE * z - 2                         # stays inside the tapered inner wall
    planes = side_planes(t0, t1) + [
        (tuple(R_IN * math.cos(half) * c for c in mid), mid),
        (tuple(r_out * math.cos(half) * c for c in mid), tuple(-c for c in mid)),
    ] + floor_ceiling(z - STEP_H, z)
    new_brushes.append(brush(planes, WOOD))
for k in range(8):                                                   # lantern posts at the gallery corners
    cx, cy, _ = d(22.5 + 45 * k)
    cx, cy = cx * 236, cy * 236
    new_brushes.append(box(cx - 8, cx + 8, cy - 8, cy + 8, Z_GAL, Z_LANTERN, WALL))
new_brushes.append(octagon(272, Z_LANTERN, Z_LANTERN + 16, WOOD))    # lantern roof
new_brushes.append(octagon(96, Z_LANTERN + 16, Z_LANTERN + 80, WALL))  # cap
new_brushes.append(box(-64, 64, 200, 216, Z_GAL, Z_GAL + 128, WALL))  # wall for the LSAT, north side of the gallery

# --- worldspawn: swap the old lighthouse brushes for the new ones ---
ws = blocks[0]
brushes = re.findall(r"(?ms)^// brush \d+\n\{\n.*?^\}\n", ws)
head = ws[: ws.index(brushes[0])]
assert ws == head + "".join(brushes) + "}\n"


def near_lighthouse(b):
    ys = [float(y) for y in re.findall(r"\( \S+ (\S+) \S+ \)", b)]
    return all(YC - 300 <= y <= YC + 300 for y in ys)


old = [b for b in brushes if near_lighthouse(b)]
assert len(old) == 14, len(old)
bodies = [re.sub(r"(?s)^// brush \d+\n\{\n(.*)\}\n$", r"\1", b) for b in brushes if not near_lighthouse(b)]
bodies += new_brushes
blocks[0] = head + "".join(f"// brush {i}\n{{\n{b}}}\n" for i, b in enumerate(bodies)) + "}\n"

# --- entities: drop the old switch, raise the lamp lights into the new lantern ---
def kv(b):
    return dict(re.findall(r'(?m)^"([^"]+)" "([^"]*)"', b))


kept = []
dropped = 0
for b in blocks:
    k = kv(b)
    if k.get("targetname") in ("lighthouse_switch", "lighthouse_switch_handle") or (
        k.get("model") == "p7_zm_der_pswitch_body" and abs(float(k["origin"].split()[1]) - YC) < 300
    ):
        dropped += 1
        continue
    if k.get("classname") == "light" and k.get("origin") in ("0 24565.5 487", "0 24581.5 499"):
        x, y, z = k["origin"].split()
        b = b.replace(f'"origin" "{k["origin"]}"', f'"origin" "{x} {y} {LAMP_Z + (int(z) - 487)}"')
    kept.append(b)
assert dropped == 3, dropped
assert sum(1 for b in kept if kv(b).get("classname") == "light" and kv(b)["origin"].split()[2] in (str(LAMP_Z), str(LAMP_Z + 12))) == 2

# --- endgame switch against the inside of the north wall, under the stairs ---
sy = (A_BASE - THICK) - SLOPE * 45 - 1   # inner wall face at handle height
lights = '"lightingstate1" "1"\n"lightingstate2" "1"\n"lightingstate3" "1"\n"lightingstate4" "1"\n'
new = [
    "{\n"
    f'guid "{guid()}"\n"classname" "misc_model"\n"model" "p7_zm_der_pswitch_body"\n'
    f'"origin" "0 {num(YC + sy + 2)} -1"\n"modelscale" "1"\n"static" "1"\n{lights}}}\n',
    "{\n"
    f'guid "{guid()}"\n"classname" "script_model"\n"angles" "0 0 90"\n"model" "p7_zm_der_pswitch_handle"\n'
    f'"origin" "-1 {num(YC + sy - 7)} 45"\n"targetname" "lighthouse_switch_handle"\n"client_server" "ServerSide"\n'
    f'{lights}"modelscale" "1"\n}}\n',
    "{\n"
    f'guid "{guid()}"\n"classname" "trigger_use"\n"targetname" "lighthouse_switch"\n"cursorhint" "HINT_ACTIVATE"\n'
    f"// brush 0\n{{\n{box(-24, 24, sy - 40, sy - 4, 16, 72, 'trigger')}}}\n}}\n",
    # LSAT: wall on +y, so rotate 180 (at angles 0 the wall sits 2 units on -y)
    "{\n"
    f'guid "{guid()}"\n"classname" "misc_prefab"\n"angles" "0 180 0"\n'
    f'"model" "_prefabs/zm/skye_prefabs/t6_lsat_wallbuy.map"\n"origin" "8 {YC + 198} {Z_GAL}"\n}}\n',
]

out = header
for i, b in enumerate(kept + new):
    out += f"// entity {i}\n" + b
open(MAP, "w", encoding="utf-8", newline="").write(out)
print(f"lighthouse: -{len(old)} +{len(new_brushes)} brushes, -{dropped} +{len(new)} entities, {N_STEPS} steps of {step_deg:.2f} deg")
