"""Rework:
- cut zones z6-z9 and slide the Void and everything north of it 4928 units south
- safety circles 10x smaller
- brighter fires under the Void signs
- remove 1/8 of the campfires
"""

import itertools
import math
import re
import sys

from maplib import *

CUT_START, CUT_END = 6720, 11700     # z5 content ends ~6704; the Void's door/signs start ~11728
SHIFT = -4 * 1232                   # four zones
YC_OLD = 24576
YC = YC_OLD + SHIFT                 # lighthouse after the slide (19648)

m = Map(sys.argv[1])
assert m.find(targetname="z9"), "zones z6-z9 already cut"

NL = chr(10)
PT = re.compile(r"\( (\S+) (\S+) (\S+) \)")


def planes_of(brush_text):
    pts = [tuple(map(float, p)) for p in PT.findall(brush_text)]
    out = []
    for i in range(0, len(pts), 3):
        a, b, c = pts[i:i + 3]
        u = (b[0] - a[0], b[1] - a[1], b[2] - a[2])
        v = (c[0] - a[0], c[1] - a[1], c[2] - a[2])
        n = (u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0])
        l = math.sqrt(sum(x * x for x in n))
        n = tuple(x / l for x in n)
        out.append((n, sum(n[k] * a[k] for k in range(3))))
    return out


def y_range(brush_text):
    """Real vertex y-extent of a convex brush."""
    pl = planes_of(brush_text)
    ys = []
    for (n1, d1), (n2, d2), (n3, d3) in itertools.combinations(pl, 3):
        cx = lambda a, b: (a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0])
        det = sum(n1[k] * cx(n2, n3)[k] for k in range(3))
        if abs(det) < 1e-9:
            continue
        x = tuple((d1 * cx(n2, n3)[k] + d2 * cx(n3, n1)[k] + d3 * cx(n1, n2)[k]) / det for k in range(3))
        if all(sum(n[k] * x[k] for k in range(3)) >= dd - 1e-2 for n, dd in pl):
            ys.append(x[1])
    return min(ys), max(ys)


def axis_aligned(brush_text):
    return all(max(abs(c) for c in n) > 0.9999 for n, _ in planes_of(brush_text))


def shift_all(text):
    return PT.sub(lambda g: f"( {g.group(1)} {num(float(g.group(2)) + SHIFT)} {g.group(3)} )", text)


def shift_north_points(text):
    """Move only the points north of the cut, one face at a time. Moving some of a face's 3 points along y can
    reverse their winding (flipping the face inside-out), so swap points 2 and 3 back when that happens."""
    def fix_line(line):
        pts = [tuple(map(float, p)) for p in PT.findall(line)]
        if len(pts) != 3:
            return line
        moved = [(x, y + SHIFT if y >= CUT_END else y, z) for x, y, z in pts]

        def normal(a, b, c):
            u = [b[k] - a[k] for k in range(3)]
            v = [c[k] - a[k] for k in range(3)]
            return (u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0])

        before, after = normal(*pts), normal(*moved)
        if sum(before[k] * after[k] for k in range(3)) < 0:
            moved = [moved[0], moved[2], moved[1]]
        new_pts = " ".join(f"( {num(x)} {num(y)} {num(z)} )" for x, y, z in moved)
        spans = [g.span() for g in PT.finditer(line)]
        return line[: spans[0][0]] + new_pts + line[spans[-1][1]:]

    return NL.join(fix_line(l) for l in text.split(NL))


def classify(lo, hi):
    if hi < CUT_START:
        return "keep"
    if lo >= CUT_END:
        return "shift"
    if CUT_START <= lo < CUT_END:      # starts inside the cut (z9's volume reaches into the Void entrance)
        return "cut"
    return "span"


stats = {"keep": 0, "shift": 0, "cut": 0, "span": 0, "span_skipped": 0}


def move_brush(b):
    lo, hi = y_range(b)
    c = classify(lo, hi)
    stats[c] += 1
    if c == "keep":
        return b
    if c == "cut":
        return None
    if c == "shift":
        return shift_all(b)
    if axis_aligned(b):
        return shift_north_points(b)
    stats["span_skipped"] += 1        # a non-axis brush reaching across the cut (the start area's long plank)
    return b


# --- worldspawn brushes ---
m.ws_brushes = [b for b in (move_brush(b) for b in m.ws_brushes) if b is not None]

# --- entities ---
out = [m.ents[0]]
for e in m.ents[1:]:
    brushes = re.findall(r"(?ms)^// brush \d+\n\{\n.*?^\}\n", e)
    k = kv(e)
    if brushes:
        head = e[: e.index(brushes[0])]
        tail = e[e.index(brushes[-1]) + len(brushes[-1]):]
        ranges = [y_range(b) for b in brushes]
        c = classify(min(r[0] for r in ranges), max(r[1] for r in ranges))
        if c == "cut":
            stats["cut"] += 1
            continue
        moved = [move_brush(b) for b in brushes]
        e = head + "".join(moved) + tail
        if "origin" in k and c == "shift":
            x, y, z = k["origin"].split()
            e = e.replace(f'"origin" "{k["origin"]}"', f'"origin" "{x} {num(float(y) + SHIFT)} {z}"')
    elif "origin" in k:
        x, y, z = k["origin"].split()
        c = classify(float(y), float(y))
        stats[c] += 1
        if c == "cut":
            continue
        if c == "shift":
            e = e.replace(f'"origin" "{k["origin"]}"', f'"origin" "{x} {num(float(y) + SHIFT)} {z}"')
            if "clickedPlane05" in k:
                cx_, cy_, cz_ = k["clickedPlane05"].split()
                e = e.replace(f'"clickedPlane05" "{k["clickedPlane05"]}"', f'"clickedPlane05" "{cx_} {num(float(cy_) + SHIFT)} {cz_}"')
    out.append(e)
m.ents = out

# values stored as text
trap = m.find(targetname="walkway_trap")
assert len(trap) == 1
y0, y1 = kv(m.ents[trap[0]])["script_noteworthy"].split()
m.ents[trap[0]] = m.ents[trap[0]].replace(f'"script_noteworthy" "{y0} {y1}"',
                                          f'"script_noteworthy" "{num(float(y0) + SHIFT)} {num(float(y1) + SHIFT)}"')

for gone in ("z6", "z7", "z8", "z9", "debris5", "debris8_away"):
    assert not m.find(targetname=gone), gone
assert m.find(targetname="debris9") and m.find(targetname="z10") and m.find(targetname="lighthouse_switch_handle") is not None

# --- safety circles: 10x smaller (radius 250 -> 25) ---
circles = {}
keep = []
for e in m.ents:
    k = kv(e)
    if k.get("targetname") == "safety_circle_center":
        circles[k["script_noteworthy"]] = tuple(float(c) for c in k["origin"].split())
        continue
    if k.get("targetname") == "safety_circle" or k.get("_color") == "0.2 1 0.3":
        continue
    keep.append(e)
m.ents = keep
assert set(circles) == {"spawn", "center", "lighthouse"}, circles
R = 25
for name, (x, y, zc) in circles.items():
    z = zc + 6       # disc centre
    disc = ngon(x, y, R, 16, z - 6, z + 6, CAULK, bottom=GREEN)
    m.add(entity([("classname", "script_brushmodel"), ("targetname", "safety_circle")]
                 + [(f"lightingstate{i}", "1") for i in range(1, 5)], [disc]))
    m.add(struct(x, y, z - 6, targetname="safety_circle_center", script_noteworthy=name, radius=str(R)))
    m.add(light(x, y, z - 40, "0.2 1 0.3", 6, 110))

# --- Void signs: stronger bowl light, plus a warm light on each board ---
signs = []
for i, e in enumerate(m.ents):
    k = kv(e)
    if k.get("fxdef") == "light/fx_light_barrel_fire_factory_zmb" and abs(float(k["origin"].split()[1]) - (11796 + SHIFT)) < 1:
        m.ents[i] = e.replace('"fxdef" "light/fx_light_barrel_fire_factory_zmb"', '"fxdef" "light/fx_light_barrel_fire_factory_zmb_strong"')
        signs.append(float(k["origin"].split()[0]))
assert len(signs) == 2, signs
board_front = 11808 + 16 + SHIFT
for xc in signs:
    m.add(light(xc, board_front - 48, 110, "1 0.62 0.32", 7, 220))

# --- remove every 8th campfire (with its stones and wood) ---
fires = [i for i in range(len(m.ents)) if kv(m.ents[i]).get("targetname") == "void_campfire"]
drop = [tuple(float(c) for c in kv(m.ents[i])["origin"].split()[:2]) for i in fires[4::8]]   # 8 of 65 = 1/8
removed = 0
keep = []
for e in m.ents:
    k = kv(e)
    if k.get("targetname") == "void_campfire" or k.get("model") in ("p7_debris_rockychunks_small_07", "p7_plank_wood_broken_2x4x64"):
        x, y = (float(c) for c in k["origin"].split()[:2])
        if any(math.hypot(x - dx, y - dy) < 40 for dx, dy in drop):
            removed += 1
            continue
    keep.append(e)
m.ents = keep

m.save()
print(stats)
print(f"lighthouse now at y {YC}; circles r={R} at {circles}; sign fires x {signs}; campfires removed {len(drop)} ({removed} entities)")
