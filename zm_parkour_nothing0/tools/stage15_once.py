"""Design 15: remove the start sign (help text replaces it), Speed Cola in z1, community perks in place of the
duplicate zone perks (Electric Cherry, Widow's Wine, Death Perception, Dying Wish)."""

import sys

from maplib import *

m = Map(sys.argv[1])

# --- start sign: board, stand, blood decal and red lettering (x 124..180, y -4..8), its fire + flicker fx, and the hint struct ---
sign = []
for i, b in enumerate(m.ws_brushes):
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if x0 >= 120 and x1 <= 184 and y0 >= -4 and y1 <= 10 and z0 >= 14 and z1 <= 96:
        sign.append(i)
assert len(sign) == 6, sign      # board, stand, blood decal, 3 red letter strokes
m.ws_brushes = [b for i, b in enumerate(m.ws_brushes) if i not in sign]

drop = [i for i in range(1, len(m.ents)) if m.kv(i).get("targetname") == "safety_sign"
        or (m.kv(i).get("classname") == "fx" and m.kv(i).get("origin", "").startswith("152 -12 "))]
assert len(drop) == 3, [m.kv(i) for i in drop]
m.ents = [e for i, e in enumerate(m.ents) if i not in drop]

# --- zone perks (same spot and angles, different prefab) ---
CORE, WEST = "_prefabs/zm/zm_core/", "_prefabs/zm/west/perks/"
SWAPS = {
    "336 1696 0":  (CORE + "vending_marathon_struct.map",  CORE + "vending_sleight_struct.map"),          # z1: Speed Cola
    "336 4160 0":  (CORE + "vending_sleight_struct.map",   WEST + "vending_electric_cherry_struct.map"),  # z3
    "336 12784 0": (CORE + "vending_revive_struct.map",    WEST + "vending_widows_wine_struct.map"),     # z12
    "336 14016 0": (CORE + "vending_sleight_struct.map",   WEST + "vending_death_perception_struct.map"),  # z13
    "336 15248 0": (CORE + "vending_doubletap_struct.map", WEST + "vending_dying_wish_struct.map"),      # z14
}
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
print(f"start sign removed ({len(sign)} brushes, {len(drop)} ents); {done} zone perks swapped")
