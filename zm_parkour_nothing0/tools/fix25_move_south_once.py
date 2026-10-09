"""Design 25 correction: zombies were stuck on the far octagons -- the walkway met the zone at y = the door, straight
into design 17's entrance (slanted wall half x -382..-104, its floor strip, and the clip box closing the wall end at
x -422..-382). Everything moves 200 south (octagon, risers, extra volume), and the clip_ai walkway is rebuilt to
overlap the zone's AI floor (x -1000..-250) instead of just touching its edge at x -384."""

import math
import re
import sys

from maplib import *

X, DY = -1000, -200
DOORS = {"z1": 2009, "z2": 3241, "z3": 4473, "z4": 5705, "z5": 6937,
         "z11": 11865, "z12": 13097, "z13": 14329, "z14": 15561, "z15": 16793, "z16": 18025}

m = Map(sys.argv[1])
ys = set(DOORS.values())

# old walkways: clip_ai x -1000..-384, y door +-32
keep, gone = [], 0
for b in m.ws_brushes:
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if "clip_ai" in b and abs(x0 - X) < 1 and abs(x1 + 384) < 1 and round((y0 + y1) / 2) in ys:
        gone += 1
        continue
    keep.append(b)
assert gone == len(DOORS), gone
m.ws_brushes = keep

moved = {"prefab": 0, "riser": 0, "volume": 0}
for i in range(1, len(m.ents)):
    k = m.kv(i)
    e = m.ents[i]
    if k.get("model") == "_prefabs/caden/cool_float.map" and k.get("origin") in {origin(X, y, 0) for y in ys}:
        x, y, z = map(float, k["origin"].split())
        m.ents[i] = e.replace(f'"origin" "{k["origin"]}"', f'"origin" "{origin(x, y + DY, z)}"')
        moved["prefab"] += 1
    elif k.get("script_noteworthy") == "riser_location" and k.get("origin") in {origin(X + dx, y, 0) for y in ys for dx in (-35, 35)}:
        x, y, z = map(float, k["origin"].split())
        m.ents[i] = e.replace(f'"origin" "{k["origin"]}"', f'"origin" "{origin(x, y + DY, z)}"')
        moved["riser"] += 1
    elif k.get("classname") == "info_volume" and k.get("targetname") in DOORS:
        bs = [b for b in re.findall(r"(?ms)^\{\n(.*?)^\}\n", e) if "(" in b]
        (x0, y0, z0), (x1, y1, z1) = bounds(bs[0])
        if abs(x0 - (X - 100)) < 1 and abs(x1 + 382) < 1:
            m.ents[i] = volume(k["targetname"], X - 100, -382, y0 + DY, y1 + DY)
            moved["volume"] += 1
assert moved == {"prefab": 11, "riser": 22, "volume": 11}, moved

for zone, y in DOORS.items():
    m.add_world(box(X, -250, y + DY - 32, y + DY + 32, -16, 0, CLIP_AI))
m.save()
print(f"removed {gone} old walkways; moved {moved}; new walkways x {X}..-250 at door y {DY}")
