"""Design 26: 10 final-stretch dog spots in z2, on its octagons. Their own targetname (not part of any zone's
<zone>_spawners), so nothing spawns there until the final stretch's script starts using them."""

import sys

from maplib import *

SPOTS = [(-40, 2208), (40, 2208), (-40, 2500), (-256, 2520), (290, 2450),
         (150, 2740), (-110, 2740), (0, 2928), (0, 3150), (-240, 2960)]

m = Map(sys.argv[1])
assert not m.find(targetname="final_stretch_dog_spot"), "already added"
for (x, y) in SPOTS:
    m.add(entity([("classname", "script_struct"), ("angles", "0 270 0"), ("origin", origin(x, y, 0)),
                  ("script_noteworthy", "dog_location"), ("targetname", "final_stretch_dog_spot"), ("_color", "1 0 0")]))
m.save()
print(f"{len(SPOTS)} final stretch dog spots in z2")
