"""Design 22 (map part):
- a spot light on the lighthouse's south wall, above the door, aimed down the walkway (walkway x +-24, y 18848..19184)
- 16 pole lights evenly spaced around the edge of the lighthouse grounds (island floor x -400..400, y 19248..20048):
  4 per side, 188 apart, corners left empty, none in the walkway's entrance
"""

import math
import sys

from maplib import *

X0, X1, Y0, Y1 = -400, 400, 19248, 20048
INSET = 24
POLE_H = 160

m = Map(sys.argv[1])
assert not m.find(targetname="lighthouse_walkway_spot"), "design 22 lights are already in this map"
world, ents = [], []

# --- spot light: fixture on the wall above the door, light just in front, aimed at the walkway's middle ---
SX, SY, SZ = 0, 19365, 455
aim = (0, (18848 + 19184) / 2, 0)
pitch = math.degrees(math.atan2(SZ - aim[2], SY - aim[1]))
world.append(box(-12, 12, SY + 4, 19385, SZ - 11, SZ + 11, IRON))
ents.append(entity([("classname", "light"), ("PRIMARY_TYPE", "PRIMARY_SPOT"), ("_color", "1 0.95 0.85"),
                    ("angles", f"{num(round(pitch, 2))} 270 0"), ("origin", origin(SX, SY, SZ)), ("radius", "1000"),
                    ("stops", "7"), ("fov_outer", "45"), ("fov_inner", "30"), ("ENABLE_FALLOFF", "1"),
                    ("falloffdistance", "30"), ("PRIMARY_NOSHADOWMAP", "1"), ("client_server", "ClientSide"),
                    ("excludeDedicated", "Off"), ("shadowUpdate", "Never"), ("name", "lighthouse_walkway_spot"),
                    ("targetname", "lighthouse_walkway_spot")] + [(f"lightingstate{i}", "1") for i in range(1, 5)]))

# --- pole lights ---
poles = []
for j in range(4):
    t = 94 + 188 * j
    poles += [(X0 + INSET + t, Y0 + INSET), (X1 - INSET, Y0 + INSET + t), (X1 - INSET - t, Y1 - INSET), (X0 + INSET, Y1 - INSET - t)]
for (x, y) in poles:
    world.append(box(x - 3, x + 3, y - 3, y + 3, 0, POLE_H, IRON))                 # pole
    world.append(box(x - 6, x + 6, y - 6, y + 6, 0, 8, IRON))                      # base plate
    ents.append(model("p7_zm_der2_light_hurricane_lamp", x, y, POLE_H))
    ents.append(model("p7_zm_der_light_shade", x, y, POLE_H + 24))
    ents.append(light(x, y, POLE_H + 18, "1 0.78 0.45", 4, 320))

m.add_world(*world)
m.add(*ents)
m.save()
print(f"walkway spot at {(SX, SY, SZ)} pitch {pitch:.1f}; {len(poles)} pole lights")
