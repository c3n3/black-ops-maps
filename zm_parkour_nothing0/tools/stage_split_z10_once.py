"""Split the Void zone z10 into z10p0 (south half, spawn side) and z10p5 (north half), straight down the middle.

The old z10 volume spanned x -1200..1200, y 7040..10736, z -520..424 (in Radiant it had become an empty misc_prefab
with no brush, so it's rebuilt here from those bounds). Each z10_spawners struct is retargeted to the half it's in.
"""

import sys

from maplib import *

X0, X1, Y0, Y1 = -1200, 1200, 7040, 10736
MID = (Y0 + Y1) / 2          # 8888

m = Map(sys.argv[1])
old = [i for i in range(1, len(m.ents)) if m.kv(i).get("targetname") == "z10"]
assert len(old) == 1, old
assert not m.find(targetname="z10p0") and not m.find(targetname="z10p5"), "already split"
m.ents = [e for i, e in enumerate(m.ents) if i not in old]

moved = {"z10p0_spawners": 0, "z10p5_spawners": 0}
for i in range(1, len(m.ents)):
    k = m.kv(i)
    if k.get("targetname") == "z10_spawners":
        name = "z10p0_spawners" if float(k["origin"].split()[1]) < MID else "z10p5_spawners"
        m.ents[i] = m.ents[i].replace('"targetname" "z10_spawners"', f'"targetname" "{name}"')
        moved[name] += 1

m.add(volume("z10p0", X0, X1, Y0, MID), volume("z10p5", X0, X1, MID, Y1))
m.save()
print(f"z10 split at y {MID:g}; spawner structs: {moved}")
