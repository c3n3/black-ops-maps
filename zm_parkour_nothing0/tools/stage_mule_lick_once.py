"""Design 9: the Mule Lick machine on the spawn deck (north side, facing the spawn points)."""

import sys

from maplib import *

m = Map(sys.argv[1])
assert not m.find(model="_prefabs/caden/vending_mule_lick_struct.map"), "Mule Lick is already in this map"
# deck: x -208..216, y -336..64, top z 16. At angles 0 the machine's front (and buy side) faces -y.
m.add(prefab("_prefabs/caden/vending_mule_lick_struct.map", 30, 30, 16))
m.save()
print("Mule Lick machine at (30, 30, 16)")
