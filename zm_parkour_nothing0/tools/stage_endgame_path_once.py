"""Design 12: glowing red see-through path along the centre line from the spawn deck to the lighthouse doorway.

One script_brushmodel `endgame_path`, 48 wide (x -24..24), 1 thick, its bottom 0.5 above the floor it lies on:
the spawn deck (top z 16) from just north of the power switch to the deck's north edge, then everything else
(floats, Void, walkway, island: top z 0) up to the lighthouse doorway. Solid across every gap except the Void (z10). Script hides it
and makes it non-solid until the endgame. No clip_ai / zone, so it adds nothing for zombies.
"""

import sys

from maplib import *

MAT = "mtl_endgame_path_red"
HW = 24
SEGMENTS = [          # (y0, y1, floor top z)
    (-280, 64, 16),   # spawn deck, north of the power switch at (0,-320)
    (64, 7040, 0),    # floats .. the Void door (z10 starts at y 7040)
    (10736, 19420, 0),  # z11 .. lighthouse doorway (its central column starts at y 19592); no road over the Void
]

m = Map(sys.argv[1])
for i in m.find(targetname="endgame_path"):      # rebuild: drop an older version
    m.ents[i] = ""
m.ents = [e for e in m.ents if e]

brushes = [box(-HW, HW, y0, y1, z + 0.5, z + 1.5, MAT) for y0, y1, z in SEGMENTS]
m.add(entity([("classname", "script_brushmodel"), ("targetname", "endgame_path")]
             + [(f"lightingstate{i}", "1") for i in range(1, 5)], brushes))
m.save()
print("endgame path:", SEGMENTS)
