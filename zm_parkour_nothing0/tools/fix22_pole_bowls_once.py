"""Design 22 correction: a fire bowl (the Void signs' bowl: 36x36 iron, 14-tall rim, fx_fire_barrel_30x30 +
fx_light_barrel_fire_factory_zmb_strong) hangs under each of the 16 floating pole lights, rim top just under the
pole's base plate (z 0), plus a player clip box around the whole bowl + pole + lamp so nobody can land on it."""

import sys

from maplib import *

CLIP_PLAYER = "clip"
POLES = []
for t in (-282, -94, 94, 282):
    POLES += [(t, 19200), (t, 20096)]
for y in (19366, 19554, 19742, 19930):
    POLES += [(448, y), (-448, y)]

m = Map(sys.argv[1])
assert not any('"fxdef" "fire/fx_fire_barrel_30x30"' in e and '"origin" "448 19366 ' in e for e in m.ents), "bowls already added"
world, ents = [], []
for (x, y) in POLES:
    top = -4                                                   # rim top, just under the pole's base plate (z 0..8)
    world.append(box(x - 18, x + 18, y - 18, y + 18, top - 18, top - 14, IRON))                 # bowl floor
    for bx0, bx1, by0, by1 in ((-18, 18, -18, -15), (-18, 18, 15, 18), (-18, -15, -15, 15), (15, 18, -15, 15)):
        world.append(box(x + bx0, x + bx1, y + by0, y + by1, top - 14, top, IRON))           # rim
    world.append(box(x - 26, x + 26, y - 26, y + 26, top - 26, 240, CLIP_PLAYER))           # bowl, pole and lamp
    ents += [fx("fire/fx_fire_barrel_30x30", x, y, top - 12), fx("light/fx_light_barrel_fire_factory_zmb_strong", x, y, top + 10)]
m.add_world(*world)
m.add(*ents)
m.save()
print(f"{len(POLES)} pole bowls added")
