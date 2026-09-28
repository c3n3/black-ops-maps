"""Design 8: endgame exit west of spawn - green arrow, drop platform ~1000 below, $500 ending. All hidden until the endgame."""

import math
import sys

from maplib import *

DECK_WEST = -208                 # spawn deck (brush 3) spans x -208..216, y -336..64, top z 16
PLAT = (-720, -208, -396, 116)   # 512 x 512 right under the deck's west edge
PLAT_Z = -1000
Y = -140                         # middle of the deck

m = Map(sys.argv[1])
assert not m.find(targetname="endgame_platform"), "the endgame exit is already in this map"


def v(*a):
    return tuple(a)


def add(a, b, s=1.0):
    return (a[0] + b[0] * s, a[1] + b[1] * s, a[2] + b[2] * s)


# arrow: 3D (square shaft + pyramid head) so it reads from any side, pointing down and away (west) at 45 degrees
u = (-math.sqrt(0.5), 0, -math.sqrt(0.5))       # along the arrow
w = (-math.sqrt(0.5), 0, math.sqrt(0.5))        # perpendicular to u in the xz plane
yv = (0, 1, 0)
start = (DECK_WEST - 60, Y, 190)                # tail, beside and above the deck edge
SHAFT, HEAD, T, HW = 150, 90, 12, 44            # shaft length, head length, shaft half-thickness, head half-width


def square(center, h):
    return [add(add(center, w, sx * h), yv, sy * h) for sx, sy in ((1, 1), (-1, 1), (-1, -1), (1, -1))]


s0, s1 = square(start, T), square(add(start, u, SHAFT), T)
shaft_faces = [(s0[0], s0[1], s0[2]), (s1[0], s1[1], s1[2])] + [(s0[i], s0[(i + 1) % 4], s1[i]) for i in range(4)]
hb = square(add(start, u, SHAFT - 4), HW)       # head base overlaps the shaft end slightly
tip = add(start, u, SHAFT + HEAD)
head_faces = [(hb[0], hb[1], hb[2])] + [(hb[i], hb[(i + 1) % 4], tip) for i in range(4)]
arrow = [solid(shaft_faces, GREEN), solid(head_faces, GREEN)]

new = [
    entity([("classname", "script_brushmodel"), ("targetname", "endgame_arrow")]
           + [(f"lightingstate{i}", "1") for i in range(1, 5)], arrow),
    struct(*add(start, u, SHAFT / 2), targetname="endgame_arrow_light"),
    entity([("classname", "script_brushmodel"), ("targetname", "endgame_platform")]
           + [(f"lightingstate{i}", "1") for i in range(1, 5)],
           [box(PLAT[0], PLAT[1], PLAT[2], PLAT[3], PLAT_Z - 16, PLAT_Z, WOOD)]),
]

# the ending: power-switch models (script models so they can stay hidden), trigger spawned in script
ex, ey = (PLAT[0] + PLAT[1]) / 2, (PLAT[2] + PLAT[3]) / 2 + 40
new.append(entity([("classname", "script_model"), ("model", "p7_zm_der_pswitch_body"), ("origin", origin(ex, ey + 2, PLAT_Z - 1)),
                   ("targetname", "endgame_ending_model"), ("client_server", "ServerSide"), ("modelscale", "1")]
                  + [(f"lightingstate{i}", "1") for i in range(1, 5)]))
new.append(entity([("classname", "script_model"), ("angles", "0 0 90"), ("model", "p7_zm_der_pswitch_handle"),
                   ("origin", origin(ex - 1, ey - 7, PLAT_Z + 45)), ("targetname", "endgame_ending_model"),
                   ("script_noteworthy", "handle"), ("client_server", "ServerSide"), ("modelscale", "1")]
                  + [(f"lightingstate{i}", "1") for i in range(1, 5)]))
new.append(struct(ex, ey - 24, PLAT_Z, targetname="endgame_ending", script_noteworthy=" ".join(num(c) for c in PLAT)))

m.add(*new)
m.save()
print(f"endgame exit: arrow from {tuple(round(c) for c in start)} to {tuple(round(c) for c in tip)}, platform {PLAT} at z {PLAT_Z}")
