"""One-off: lighthouse fog + island Pack-a-Punch (design ai/6.md)."""

import re
import sys
import uuid

MAP = sys.argv[1]
YC = 24576
FOG_Y0 = YC - 3000   # lighthouse fog box: 6000 x 6000 around the lighthouse

text = open(MAP, encoding="utf-8", newline="").read()
assert "\r\n" not in text
header, rest = text.split("// entity 0\n", 1)
blocks = re.split(r"(?m)^// entity \d+\n", "// entity 0\n" + rest)[1:]


def guid():
    return "{" + str(uuid.uuid4()).upper() + "}"


def once(s, a, b):
    assert s.count(a) == 1, (a, s.count(a))
    return s.replace(a, b)


def box_faces(x0, x1, y0, y1, z0, z1, mat):
    tex = f"{mat} 64 64 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0"
    faces = [  # same winding as the axis-aligned brush 3 in this map
        ((x0, y0, z0), (x1, y0, z0), (x1, y1, z0)),
        ((x0, y1, z1), (x1, y1, z1), (x1, y0, z1)),
        ((x0, y0, z0), (x0, y0, z1), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y0, z0), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y1, z1), (x0, y1, z1)),
        ((x0, y1, z1), (x0, y0, z1), (x0, y0, z0)),
    ]
    return "".join(" " + " ".join(f"( {a} {b} {c} )" for a, b, c in f) + f" {tex}\n" for f in faces)


fog = [i for i, b in enumerate(blocks) if '"classname" "volume_litfog"' in b]
assert len(fog) == 1
fi = fog[0]

# 1. stretch the platform fog north until it meets the lighthouse fog
blocks[fi] = once(blocks[fi], "( -486 20568 -544 ) ( -550 20568 -544 ) ( -550 20568 -608 )",
                  f"( -486 {FOG_Y0} -544 ) ( -550 {FOG_Y0} -544 ) ( -550 {FOG_Y0} -608 )")

# 2. same fog settings in a wide box around the lighthouse (covers the lantern and beam origin at z ~620)
keys = blocks[fi][: blocks[fi].index("// brush 0")]
keys = re.sub(r'guid "\{[^}]+\}"', lambda m: f'guid "{guid()}"', keys)
new = [
    keys + f'// brush 0\n{{\n guid "{guid()}"\n'
    + box_faces(-3000, 3000, FOG_Y0, YC + 3000, -864, 1500, "litfog_volume") + "}\n}\n",
    # 3. second Pack-a-Punch, on the island south-west of the lighthouse door, same facing as z9's
    "{\n"
    f'guid "{guid()}"\n"classname" "misc_prefab"\n"angles" "0 270 0"\n'
    f'"model" "_prefabs/zm/zm_core/vending_weapon_upgrade_spawnable.map"\n"origin" "-130 {YC - 360} 0"\n}}\n',
]

out = header
for i, b in enumerate(blocks + new):
    out += f"// entity {i}\n" + b
open(MAP, "w", encoding="utf-8", newline="").write(out)
print(f"fog extended to y {FOG_Y0}, added lighthouse fog + island PaP ({len(blocks)} -> {len(blocks) + len(new)} entities)")
