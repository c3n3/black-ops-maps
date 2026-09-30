"""Design 14: the Vodka machine on the spawn deck, east of the power switch (0,-320), facing north.

x 128 sits between the initial spawn points at x 64 and 192; the machine backs onto the deck's south edge (y -336).
"""

import sys

from maplib import *

PREFAB = "_prefabs/caden/vending_vodka_struct.map"

m = Map(sys.argv[1])
assert not m.find(model=PREFAB), "the Vodka machine is already in this map"
m.add(prefab(PREFAB, 128, -300, 16, angles="0 180 0"))
m.save()
print("vodka machine at (128, -300, 16)")
