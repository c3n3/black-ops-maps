"""Design 25: a far zombie-spawn octagon for z1-z5 and z11-z16.

Per zone: a normal cool_float octagon at (-1000, y of the zone's exit door) -- 1000 left of the door (facing the
lighthouse), on the zone's own side of it; two zombie risers on it (the zone's <zone>_spawners, find_flesh); an
AI-only clip_ai walkway (players fall through) from it to the zone's AI floor at x -384; and an extra volume for the
zone over the octagon + walkway, so zombies out there still count as in the zone. z16 has no door: its spot is the
same distance from its end (y 18128 - 103).
"""

import math
import re
import sys

from maplib import *

X = -1000
ZONES = {"z1": 2009, "z2": 3241, "z3": 4473, "z4": 5705, "z5": 6937,
         "z11": 11865, "z12": 13097, "z13": 14329, "z14": 15561, "z15": 16793, "z16": 18025}

m = Map(sys.argv[1])
assert not m.find(model="_prefabs/caden/cool_float.map", origin=origin(X, ZONES["z1"], 0)), "design 25 is already in this map"

# nothing already out there
for zone, y in ZONES.items():
    for e in m.ents[1:]:
        k = kv(e)
        if k.get("origin"):
            ex, ey, ez = map(float, k["origin"].split())
            assert not (math.hypot(ex - X, ey - y) < 150 and -100 < ez < 300), (zone, k)
    for b in m.ws_brushes:
        (x0, y0, z0), (x1, y1, z1) = bounds(b)
        if x1 - x0 < 3000 and y1 - y0 < 3000:
            assert not (x0 < X + 100 and x1 > X - 100 and y0 < y + 100 and y1 > y - 100 and z1 > -20 and z0 < 300), (zone, bounds(b))

world, ents = [], []
for zone, y in ZONES.items():
    ents.append(prefab("_prefabs/caden/cool_float.map", X, y, 0))
    for dx in (-35, 35):
        ents.append(entity([("classname", "script_struct"), ("angles", "0 0 0"), ("origin", origin(X + dx, y, 0)),
                            ("script_noteworthy", "riser_location"), ("script_string", "find_flesh"),
                            ("targetname", f"{zone}_spawners"), ("_color", "1 0 0")]))
    world.append(box(X, -384, y - 32, y + 32, -16, 0, CLIP_AI))
    ents.append(volume(zone, X - 100, -382, y - 100, y + 100))
m.add_world(*world)
m.add(*ents)
m.save()
print(f"{len(ZONES)} far spawn octagons at x {X}: " + ", ".join(f"{z}@{y}" for z, y in ZONES.items()))
