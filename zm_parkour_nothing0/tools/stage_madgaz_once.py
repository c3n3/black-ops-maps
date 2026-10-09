"""Madgaz Moonshine (west pack, specialty_flakjacket) next to Winter's Wail on the lighthouse tower's west wall:
the wall's south end, mirroring the east wall's Elemental Pop (same prefab layout); the SCAR-H wall buy stays
between them mid-wall."""

import sys

from maplib import *

m = Map(sys.argv[1])
assert not m.find(model="_prefabs/zm/west/perks/vending_madgaz_moonshine_struct.map"), "already placed"
m.add(entity([("classname", "misc_prefab"), ("angles", "0 270 0"),
              ("model", "_prefabs/zm/west/perks/vending_madgaz_moonshine_struct.map"), ("origin", "-304.25 19555.8 0")]))
m.save()
print("madgaz moonshine placed")
