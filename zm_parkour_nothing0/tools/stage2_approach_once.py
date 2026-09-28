"""Stage 2 (design 7): zones z11-z16 after the Void, the approach platforms, the walkway and its trap."""

import re
import sys

from maplib import *

PITCH = 1232
ZONES = range(11, 17)
PERKS = {11: "vending_juggernaut_struct", 12: "vending_revive_struct", 13: "vending_sleight_struct",
         14: "vending_doubletap_struct", 15: "vending_marathon_struct", 16: "vending_additionalprimaryweapon_struct"}
GUNS = {11: "t6_m8a1", 13: "t6_scar-h", 15: "t6_mk48"}
BOXES = {12: 5, 14: 6, 16: 7}
YC = 24576                                  # lighthouse
WALK_Y0, WALK_Y1 = 23776, 24112             # walkway; the island's south edge is at y 24176
APPROACH = (22896, 23152, 23408, 23632)     # normal platforms between z16 and the walkway

m = Map(sys.argv[1])
assert not m.find(targetname="z11"), "stage 2 is already in this map"


def dy_for(k):
    return (k + 1) * PITCH                   # z11 starts where the Void ends (y 15664)


def shift(block, dy):
    block = re.sub(r'guid "\{[^}]+\}"', lambda _: f'guid "{guid()}"', block)
    block = re.sub(r"\( (\S+) (\S+) (\S+) \)", lambda g: f"( {g.group(1)} {num(float(g.group(2)) + dy)} {g.group(3)} )", block)
    for key in ("origin", "clickedPlane05"):
        block = re.sub(rf'(?m)^"{key}" "(\S+) (\S+) (\S+)"', lambda g: f'"{key}" "{g.group(1)} {num(float(g.group(2)) + dy)} {g.group(3)}"', block)
    return block


def setkv(block, **kvs):
    for k, v in kvs.items():
        block, c = re.subn(rf'(?m)^"{k}" "[^"]*"', f'"{k}" "{v}"', block)
        assert c == 1, k
    return block


def one(**want):
    found = m.find(**want)
    assert len(found) == 1, (want, len(found))
    return m.ents[found[0]]


away, trig = one(targetname="debris0_away"), one(targetname="zombie_debris", target="debris0")
parts = [m.ents[i] for i in m.find(targetname="debris0")]
floats = [m.ents[i] for i in m.find(classname="misc_prefab", model="_prefabs/caden/cool_float.map")
          if kv(m.ents[i])["origin"].split()[1] in ("1248", "1472", "1696")]
risers = [m.ents[i] for i in m.find(targetname="z1_spawners") if kv(m.ents[i]).get("script_noteworthy") == "riser_location"]
zvol, probe = one(targetname="z1"), one(classname="reflection_probe", origin="20 1108 36")
assert len(parts) == 5 and len(floats) == 6 and len(risers) == 5

new, world = [], []
for k in ZONES:
    dy = dy_for(k)
    d_ = f"debris{k - 1}"
    new.append(prefab("_prefabs/caden/cool_float.map", 0, 720 + dy))                   # door octagon
    new.append(setkv(shift(away, dy), targetname=f"{d_}_away"))
    for p in parts:
        b = setkv(shift(p, dy), targetname=d_)
        new.append(setkv(b, target=f"{d_}_away") if "target" in kv(b) else b)
    new.append(setkv(shift(trig, dy), target=d_, script_flag=f"enter_z{k}", zombie_cost=str(750 * k)))
    new.append(prefab("_prefabs/caden/cool_float.map", 0, 976 + dy))                   # entry octagon
    new += [shift(f, dy) for f in floats]
    new.append(prefab("_prefabs/caden/cool_float_spooky.map", -272, 1696 + dy))
    new.append(prefab("_prefabs/caden/cool_float_spooky.map", 256, 1696 + dy))
    new.append(prefab(f"_prefabs/zm/zm_core/{PERKS[k]}.map", 336, 1696 + dy, angles="0 270 0"))
    if k in BOXES:
        new.append(prefab(f"_prefabs/zm/mystery_box_locations/magic_box_location_{BOXES[k]}.map", -349.75, 1696.25 + dy, angles="0 90 0"))
    else:
        world.append(box(-352, -336, 1664 + dy, 1728 + dy, 0, 128, WOOD))
        new.append(prefab(f"_prefabs/zm/skye_prefabs/{GUNS[k]}_wallbuy.map", -334, 1696 + dy, angles="0 270 0"))
    new += [setkv(shift(r, dy), targetname=f"z{k}_spawners") for r in risers]
    new.append(setkv(shift(zvol, dy), target=f"z{k}_spawners", targetname=f"z{k}"))
    new.append(shift(probe, dy))

# --- approach: normal platforms, then the narrow walkway (jump on and jump off) ---
for y in APPROACH:
    new.append(prefab("_prefabs/caden/cool_float.map", 0, y))
world.append(box(-24, 24, WALK_Y0, WALK_Y1, -16, 0, WOOD))

# the lighthouse zone: approach, walkway and island; opens with z16
Z16_END = 880 + dy_for(16) + PITCH
new.append(volume("lighthouse", -660, 660, Z16_END, YC + 660, z1=900))
for (x, y) in ((0, 23152), (0, 23408), (-340, YC), (340, YC), (0, YC + 340)):
    new.append(riser(x, y, "lighthouse"))

# trap switch on the island's south edge, right where the walkway lands; backing post behind it
TRAP = (96, 24236)
world.append(box(TRAP[0] - 16, TRAP[0] + 16, TRAP[1] + 4, TRAP[1] + 12, 0, 72, IRON))
new += switch(TRAP[0], TRAP[1] + 4, "walkway_trap_handle")
new.append(struct(0, (WALK_Y0 + WALK_Y1) / 2, 0, targetname="walkway_trap", script_noteworthy=f"{WALK_Y0} {WALK_Y1}"))

# AI walk floor: the new zones and approach, plus a narrow strip over the walkway's two gaps
world.append(box(-384, 384, 880 + dy_for(11), 23712, -16, 0, CLIP_AI))
world.append(box(-24, 24, 23712, 24176, -16, 0, CLIP_AI))

m.add_world(*world)
m.add(*new)
m.save()
print(f"stage 2: {len(world)} brushes, {len(new)} entities; z16 ends at y {Z16_END}")
