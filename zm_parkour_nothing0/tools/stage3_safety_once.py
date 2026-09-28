"""Stage 3 (design 7): green safety circles under the paths, teleport destinations and the start sign."""

import sys

from maplib import *

YC = 24576
CIRCLE_Z = -206          # just below the paths (octagon bottoms are at -16, candle posts reach -44, the island -64)
RADIUS = 250             # ~500 wide
CIRCLES = {"spawn": (0, -160), "center": (0, (-160 + YC) // 2), "lighthouse": (0, YC)}

m = Map(sys.argv[1])
assert not m.find(targetname="safety_circle"), "stage 3 is already in this map"
new = []

for name, (x, y) in CIRCLES.items():
    # 16-sided disc: only the underside is drawn (neon green), every other face is caulk; made non-solid in script
    disc = ngon(x, y, RADIUS, 16, CIRCLE_Z - 6, CIRCLE_Z + 6, CAULK, bottom=GREEN)
    new.append(entity([("classname", "script_brushmodel"), ("targetname", "safety_circle")]
                      + [(f"lightingstate{i}", "1") for i in range(1, 5)], [disc]))
    new.append(struct(x, y, CIRCLE_Z - 6, targetname="safety_circle_center", script_noteworthy=name, radius=str(RADIUS)))
    # neon: a bright green light under the disc, plus a ring of softer ones along its rim
    new.append(light(x, y, CIRCLE_Z - 90, "0.2 1 0.3", 8, 420))
    for k in range(6):
        dx, dy, _ = d(60 * k)
        new.append(light(x + dx * 200, y + dy * 200, CIRCLE_Z - 40, "0.2 1 0.3", 6, 160))

# where a saved player lands
new.append(struct(0, -160, 40, targetname="safety_dest", script_noteworthy="spawn", angles="0 90 0"))
new.append(struct(0, 24210, 8, targetname="safety_dest", script_noteworthy="lighthouse", angles="0 90 0"))

# start sign on the spawn deck: blood-splattered board facing the players; its text is a look-at hint in script
world = [
    box(104, 200, 0, 8, 40, 120, IRON),                                   # board
    box(148, 156, 2, 6, 16, 40, IRON),                                    # stand
    box(108, 196, -2, 0, 44, 116, CAULK, faces={"-y": "t7_decal_blood_splatter_01"}),
]
new.append(struct(152, -24, 16, targetname="safety_sign"))

m.add_world(*world)
m.add(*new)
m.save()
print(f"stage 3: {len(world)} brushes, {len(new)} entities; circles at {CIRCLES}")
