"""Perk swaps (same spots and angles, prefab model only):
glitching gin (lighthouse) -> magnet mule; z3 electric cherry -> speed cola; z1 speed cola -> muscle milk;
spawn verruckt jug -> quick revive; z2 quick revive -> winter's wail."""

import sys

from maplib import *

CORE, WEST = "_prefabs/zm/zm_core/", "_prefabs/zm/west/perks/"
SWAPS = {
    "186.685 19525.6 512": (WEST + "vending_glitching_gin_struct.map", WEST + "vending_magnet_struct.map"),
    "336 4160 0": (WEST + "vending_electric_cherry_struct.map", CORE + "vending_sleight_struct.map"),
    "336 1696 0": (CORE + "vending_sleight_struct.map", WEST + "vending_muscle_milk_struct.map"),
    "192.25 -188.25 0": (WEST + "vending_verruckt_jug_struct.map", CORE + "vending_revive_struct.map"),
    "336 2928 0": (CORE + "vending_revive_struct.map", WEST + "vending_winters_wail_struct.map"),
}
m = Map(sys.argv[1])
done = 0
for i in range(1, len(m.ents)):
    k = m.kv(i)
    if k.get("classname") == "misc_prefab" and k.get("origin") in SWAPS:
        old, new = SWAPS[k["origin"]]
        assert k["model"] == old, (k["origin"], k["model"])
        m.ents[i] = m.ents[i].replace(f'"model" "{old}"', f'"model" "{new}"')
        done += 1
assert done == len(SWAPS), done
m.save()
print(f"{done} perk machines swapped")
