"""Lighthouse perks: Space Cadet where the Verrueckt Jugg was (north wall, next to Jugg), and Winter's Wail on the
tower's west wall (the side with no perks), mirroring the east wall's Elemental Pop (same prefab layout) at the Mule Lick y (the SCAR-H wall buy stays in
the middle of that wall)."""

import sys

from maplib import *

m = Map(sys.argv[1])
assert not m.find(model="_prefabs/zm/west/perks/vending_space_cadet_struct.map"), "already placed"
assert not m.find(model="_prefabs/zm/west/perks/vending_winters_wail_struct.map"), "already placed"
m.add(entity([("classname", "misc_prefab"), ("angles", "0 179.999 0"),
              ("model", "_prefabs/zm/west/perks/vending_space_cadet_struct.map"), ("origin", "-103.997 19949.5 0")]),
      entity([("classname", "misc_prefab"), ("angles", "0 270 0"),
              ("model", "_prefabs/zm/west/perks/vending_winters_wail_struct.map"), ("origin", "-304.25 19746.6 0")]))
m.save()
print("space cadet + winters wail placed")
