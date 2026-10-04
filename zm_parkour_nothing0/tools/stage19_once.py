"""Design 19: wall-buy progression before the Void is M14 (spawn) -> KAP-40 (z3) -> PDW-57 (z5). Same spots/angles."""

import sys

from maplib import *

SWAPS = {
    "-334 4160 0": ("t6_mp5_wallbuy.map", "t6_kap-40_wallbuy.map"),        # z3
    "-334 6624 0": ("t6_kap-40_wallbuy.map", "t6_pdw-57_wallbuy.map"),     # z5
}
m = Map(sys.argv[1])
done = 0
for i in range(1, len(m.ents)):
    k = m.kv(i)
    if k.get("classname") == "misc_prefab" and k.get("origin") in SWAPS:
        old, new = SWAPS[k["origin"]]
        assert k["model"].endswith(old), (k["origin"], k["model"])
        m.ents[i] = m.ents[i].replace(old, new)
        done += 1
assert done == len(SWAPS), done
m.save()
print(f"{done} wall buys swapped")
