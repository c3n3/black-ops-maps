"""Lighthouse ground-floor lights and red sparks at the endgame switch."""

import sys

from maplib import *

YC = 19648
m = Map(sys.argv[1])
assert not m.find(fxdef="endgame_spark"), "already applied"

# warm lights around the central column on the ground floor (inside the tower, below the first turn of the stairs)
for a in (30, 150, 270):
    dx, dy, _ = d(a)
    m.add(light(dx * 170, YC + dy * 170, 90, "1 0.72 0.45", 5, 260))

# red sparks at the endgame switch, a little to the side of the lever
h = [kv(e) for e in m.ents if kv(e).get("targetname") == "lighthouse_switch_handle"]
assert len(h) == 1
x, y, z = (float(c) for c in h[0]["origin"].split())
m.add(fx("endgame_spark", x - 18, y + 4, 40))
m.save()
print("lighthouse lights: 3; endgame sparks at", (x - 18, y + 4, 40))
