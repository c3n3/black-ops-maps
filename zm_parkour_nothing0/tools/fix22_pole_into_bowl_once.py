"""Design 22 correction: each floating lighthouse pole rises out of the centre of its fire bowl -- the pole brush
(6x6 iron, z 0..160) now starts on the bowl floor (z -18), and the base plates (12x12, z 0..8) are removed."""

import sys

from maplib import *

POLES = set()
for t in (-282, -94, 94, 282):
    POLES |= {(t, 19200), (t, 20096)}
for y in (19366, 19554, 19742, 19930):
    POLES |= {(448, y), (-448, y)}

m = Map(sys.argv[1])
keep, poles, plates = [], 0, 0
for b in m.ws_brushes:
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    c = (round((x0 + x1) / 2), round((y0 + y1) / 2))
    if c in POLES and "t7_metal_worn_iron_dark" in b:
        if abs(x1 - x0 - 12) < 0.1 and abs(z0) < 0.1 and abs(z1 - 8) < 0.1:
            plates += 1
            continue                                    # base plate: gone
        if abs(x1 - x0 - 6) < 0.1 and abs(z0) < 0.1 and abs(z1 - 160) < 0.1:
            keep.append(box(c[0] - 3, c[0] + 3, c[1] - 3, c[1] + 3, -18, 160, IRON))
            poles += 1
            continue
    keep.append(b)
assert poles == 16 and plates == 16, (poles, plates)
m.ws_brushes = keep
m.save()
print(f"{poles} poles now start on their bowl floor; {plates} base plates removed")
