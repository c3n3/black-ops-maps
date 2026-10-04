"""Design 17 corrections: the new Void back wall (y 9986..10018) is one centre wall the length of one of the old
side segments (544): x -272..272. Removes whatever back-wall brushes are there (the two side halves, or an earlier
centre wall; they all lie inside y 9958..10046 apart from the octagons, which reach outside it) and rebuilds it."""

import sys

from maplib import *
from stage17_once import void_wall, CLIP_PLAYER

Y0, Y1 = 9986, 10018
X = 272
m = Map(sys.argv[1])
old = []
for i, b in enumerate(m.ws_brushes):
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if y0 >= 9958 and y1 <= 10046 and x1 > -830 and x0 < 830:
        old.append(i)
assert old, "no back wall found"
m.ws_brushes = [b for i, b in enumerate(m.ws_brushes) if i not in old]
m.add_world(box(-X, X, Y0, Y1, 0, 96, WOOD), box(-X, X, Y0, Y1, 96, 288, CLIP_PLAYER), *void_wall(-X, X, Y0, Y1))
m.save()
print(f"removed {len(old)} old back-wall brushes; centre wall x -{X}..{X} built")
