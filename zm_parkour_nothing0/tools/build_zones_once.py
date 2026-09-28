"""One-off: add zones z2-z9 to zm_parkour_nothing0.map by cloning z1's layout north (design ai/4.md)."""

import re
import sys
import uuid

MAP = sys.argv[1]
PITCH = 1232  # y distance between zones (z1 spans y 880..2112 after the fix)
ZONES = range(2, 10)

PERKS = {
    2: "vending_revive_struct",
    3: "vending_sleight_struct",
    4: "vending_bgb_struct",
    5: "vending_doubletap_struct",
    6: "vending_deadshot_struct",
    7: "vending_additionalprimaryweapon_struct",
    8: "vending_juggernaut_struct",
    9: "vending_weapon_upgrade_spawnable",
}
GUNS = {3: "t6_mp5", 5: "t6_remington_870_mcs", 7: "t6_galil", 9: "t6_hamr"}

text = open(MAP, encoding="utf-8", newline="").read()
assert "\r\n" not in text

header, rest = text.split("// entity 0\n", 1)
blocks = re.split(r"(?m)^// entity \d+\n", "// entity 0\n" + rest)[1:]
ents = {i: b for i, b in enumerate(blocks)}
assert len(ents) == 117


def guid():
    return "{" + str(uuid.uuid4()).upper() + "}"


def once(s, a, b):
    assert s.count(a) == 1, (a, s.count(a))
    return s.replace(a, b)


def shift_y(block, dy):
    block = re.sub(r"\( (\S+) (\S+) (\S+) \)", lambda m: f"( {m.group(1)} {fmt(float(m.group(2)) + dy)} {m.group(3)} )", block)
    block = re.sub(r'(?m)^"origin" "(\S+) (\S+) (\S+)"', lambda m: f'"origin" "{m.group(1)} {fmt(float(m.group(2)) + dy)} {m.group(3)}"', block)
    block = re.sub(r'(?m)^"clickedPlane05" "(\S+) (\S+) (\S+)"', lambda m: f'"clickedPlane05" "{m.group(1)} {fmt(float(m.group(2)) + dy)} {m.group(3)}"', block)
    return block


def fmt(v):
    return str(int(v)) if v == int(v) else repr(v)


def clone(n, dy, **kv):
    b = re.sub(r'guid "\{[^}]+\}"', lambda m: f'guid "{guid()}"', ents[n])
    b = shift_y(b, dy)
    for k, v in kv.items():
        b, c = re.subn(rf'(?m)^"{k}" "[^"]*"', f'"{k}" "{v}"', b)
        assert c == 1, (n, k)
    return b


def prefab(model, x, y, angles=None):
    lines = [f'guid "{guid()}"', '"classname" "misc_prefab"']
    if angles:
        lines.append(f'"angles" "{angles}"')
    lines += [f'"model" "{model}"', f'"origin" "{fmt(x)} {fmt(y)} 0"']
    return "{\n" + "\n".join(lines) + "\n}\n"


def box_brush(n, x0, x1, y0, y1, z0, z1, mat="t7_wood_planks_damaged_teak"):
    tex = f"{mat} 64 64 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0"
    faces = [  # same winding as the axis-aligned brush 3 in this map
        ((x0, y0, z0), (x1, y0, z0), (x1, y1, z0)),
        ((x0, y1, z1), (x1, y1, z1), (x1, y0, z1)),
        ((x0, y0, z0), (x0, y0, z1), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y0, z0), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y1, z1), (x0, y1, z1)),
        ((x0, y1, z1), (x0, y0, z1), (x0, y0, z0)),
    ]
    out = f'// brush {n}\n{{\n guid "{guid()}"\n'
    for f in faces:
        out += " " + " ".join(f"( {fmt(a)} {fmt(b)} {fmt(c)} )" for a, b, c in f) + f" {tex}\n"
    return out + "}\n"


# --- fixes to existing entities ---
# AI walk floor (worldspawn brush 10): extend north edge to cover every zone
ents[0] = once(ents[0], "( 512 2944 112 ) ( -256 2944 112 ) ( -256 2944 -16 )",
               f"( 512 {880 + 9 * PITCH} 112 ) ( -256 {880 + 9 * PITCH} 112 ) ( -256 {880 + 9 * PITCH} -16 )")
# start_zone volume stops where z1 starts
ents[19] = once(ents[19], "( -3616 1872 896 ) ( -3632 1872 896 ) ( -3632 1872 768 )",
                "( -3616 880 896 ) ( -3632 880 896 ) ( -3632 880 768 )")
# z1 volume runs up to z2 (covers z2's door octagon)
ents[112] = once(ents[112], "( -310 1880 8 ) ( -350 1880 8 ) ( -350 1880 -8 )",
                 f"( -310 {880 + PITCH} 8 ) ( -350 {880 + PITCH} 8 ) ( -350 {880 + PITCH} -8 )")
# debris0 opens z1
ents[76] = once(ents[76], '"script_flag" ""', '"script_flag" "enter_z1"')

# --- new zones ---
new = []
wall_brushes = []
n_brush = len(re.findall(r"(?m)^// brush ", ents[0]))
for k in ZONES:
    dy = (k - 1) * PITCH
    d = f"debris{k - 1}"
    # debris door into zone k, on a door octagon at the end of zone k-1
    new.append(prefab("_prefabs/caden/cool_float.map", 0, 720 + dy))
    new.append(clone(74, dy, targetname=f"{d}_away"))
    new.append(clone(75, dy, targetname=d))
    new.append(clone(76, dy, target=d, script_flag=f"enter_z{k}", zombie_cost=750 * k))
    for n in (77, 78, 79, 80):
        new.append(clone(n, dy, target=f"{d}_away", targetname=d))
    # zone k floor: entry octagon + z1's cool_float grid
    new.append(prefab("_prefabs/caden/cool_float.map", 0, 976 + dy))
    for n in (81, 82, 83, 84, 85, 86):
        new.append(clone(n, dy))
    # spooky octagons for the perk and the box / wall gun
    new.append(prefab("_prefabs/caden/cool_float_spooky.map", -272, 1696 + dy))
    new.append(prefab("_prefabs/caden/cool_float_spooky.map", 256, 1696 + dy))
    new.append(prefab(f"_prefabs/zm/zm_core/{PERKS[k]}.map", 336, 1696 + dy, "0 270 0"))
    if k % 2 == 0:
        new.append(prefab(f"_prefabs/zm/mystery_box_locations/magic_box_location_{k // 2}.map", -349.75, 1696.25 + dy, "0 90 0"))
    else:
        # wall on the octagon's west edge, chalk 2 units in front of it facing east
        wall_brushes.append(box_brush(n_brush, -352, -336, 1664 + dy, 1728 + dy, 0, 128))
        n_brush += 1
        new.append(prefab(f"_prefabs/zm/skye_prefabs/{GUNS[k]}_wallbuy.map", -334, 1696 + dy, "0 270 0"))
    # zombie risers, zone volume, reflection probe
    for n in (111, 113, 114, 115, 116):
        new.append(clone(n, dy, targetname=f"z{k}_spawners"))
    new.append(clone(112, dy, target=f"z{k}_spawners", targetname=f"z{k}"))
    new.append(clone(97, dy))

# worldspawn ends with "}\n" after its last brush
assert ents[0].endswith("}\n}\n")
ents[0] = ents[0][:-2] + "".join(wall_brushes) + "}\n"

out = header
for i in range(len(ents)):
    out += f"// entity {i}\n" + ents[i]
for j, b in enumerate(new):
    out += f"// entity {len(ents) + j}\n" + b
open(MAP, "w", encoding="utf-8", newline="").write(out)
print(f"added {len(new)} entities and {len(wall_brushes)} wall brushes")
