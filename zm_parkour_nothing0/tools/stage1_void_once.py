"""Stage 1 (design 7): The Void, zone z10, north of z9."""

import random
import re
import sys

from maplib import *

PITCH = 1232
Y0, Y1, XW = 11968, 15664, 1140      # 3x a normal zone: 2280 wide x 3696 long
ROW0, ROW_DY, COL_DX = 12080, 228, 264
ROWS = 15
APOTHEM = 96                          # normal octagons are 80
CENTER = (0, ROW0 + 8 * ROW_DY)       # row 8 is an even row, so it has an x = 0 platform
DOOR_DY = 9 * PITCH                   # door pattern offset for the door into z10

m = Map(sys.argv[1])
assert not m.find(targetname="debris9_away"), "the Void is already in this map"

# --- door into the Void: copy of debris0 on a door octagon at the end of z9 ---
def shift(block, dy):
    block = re.sub(r'guid "\{[^}]+\}"', lambda _: f'guid "{guid()}"', block)
    block = re.sub(r"\( (\S+) (\S+) (\S+) \)", lambda g: f"( {g.group(1)} {num(float(g.group(2)) + dy)} {g.group(3)} )", block)
    return re.sub(r'(?m)^"origin" "(\S+) (\S+) (\S+)"', lambda g: f'"origin" "{g.group(1)} {num(float(g.group(2)) + dy)} {g.group(3)}"', block)


def setkv(block, **kvs):
    for k, v in kvs.items():
        block, c = re.subn(rf'(?m)^"{k}" "[^"]*"', f'"{k}" "{v}"', block)
        assert c == 1, k
    return block


away = m.find(targetname="debris0_away")
parts = m.find(targetname="debris0")
trig = m.find(targetname="zombie_debris", target="debris0")
assert len(away) == 1 and len(parts) == 5 and len(trig) == 1
new = [prefab("_prefabs/caden/cool_float.map", 0, 720 + DOOR_DY)]
new.append(setkv(shift(m.ents[away[0]], DOOR_DY), targetname="debris9_away"))
for i in parts:
    b = setkv(shift(m.ents[i], DOOR_DY), targetname="debris9")
    if 'target' in kv(b):
        b = setkv(b, target="debris9_away")
    new.append(b)
new.append(setkv(shift(m.ents[trig[0]], DOOR_DY), target="debris9", script_flag="enter_z10", zombie_cost="7500"))

# --- blood signs either side of the door: "V" on the left, "void" on the right (as seen walking north) ---
DOOR_Y = 720 + DOOR_DY
BOARD_Y = DOOR_Y + 16                 # board front face
world = []


def sign(xc, width, strokes):
    world.append(box(xc - width / 2, xc + width / 2, BOARD_Y, BOARD_Y + 8, 48, 144, IRON))   # board
    world.append(box(xc - 4, xc + 4, BOARD_Y + 2, BOARD_Y + 6, -64, 48, IRON))               # stand
    for (x0, z0, x1, z1) in strokes:
        world.append(stroke_xz(BOARD_Y - 2, xc + x0, z0, xc + x1, z1, 8, 2, BLOOD))
    # fire bowl in front of the stand
    by = BOARD_Y - 28
    world.append(box(xc - 18, xc + 18, by - 18, by + 18, -4, 0, IRON))
    for bx0, bx1, by0, by1 in ((-18, 18, -18, -15), (-18, 18, 15, 18), (-18, -15, -15, 15), (15, 18, -15, 15)):
        world.append(box(xc + bx0, xc + bx1, by + by0, by + by1, 0, 14, IRON))
    world.append(box(xc - 3, xc + 3, by + 18, BOARD_Y + 2, -4, 2, IRON))                     # arm to the stand
    new.append(fx("fire/fx_fire_barrel_30x30", xc, by, 2))
    new.append(fx("light/fx_light_barrel_fire_factory_zmb", xc, by, 24))


# letters: segments in board-local x (centre 0) and z, 64 tall between z 64 and 128
sign(-176, 96, [(-24, 128, 0, 64), (24, 128, 0, 64)])
v, o, i_, dd = -72, -24, 24, 72       # letter centres for "void"
sign(200, 208, [
    (v - 18, 128, v, 64), (v + 18, 128, v, 64),                                           # v
    (o - 18, 64, o - 18, 128), (o + 18, 64, o + 18, 128), (o - 18, 128, o + 18, 128), (o - 18, 64, o + 18, 64),  # o
    (i_, 64, i_, 110), (i_, 120, i_, 128),                                                # i
    (dd + 18, 64, dd + 18, 136), (dd - 18, 64, dd - 18, 104), (dd - 18, 104, dd + 18, 104), (dd - 18, 64, dd + 18, 64),  # d
])

# --- platforms: larger octagons, closer together, no candles or posts ---
rng = random.Random(7)
platforms = []
for r in range(ROWS):
    y = ROW0 + r * ROW_DY
    xs = range(-1056, 1057, COL_DX) if r % 2 == 0 else range(-924, 925, COL_DX)
    for c, x in enumerate(xs):
        platforms.append((r, c, x, y))
for (r, c, x, y) in platforms:
    if (x, y) == CENTER:
        world.append(octagon(x, y, 128, -16, 0, WOOD))
    else:
        world.append(octagon(x, y, APOTHEM, -16, 0, WOOD))

# campfires on about half the platforms (checkerboard), never on the centre or the entry/exit platforms
campfires = [(x, y) for (r, c, x, y) in platforms
             if (r + c) % 2 == 0 and (x, y) != CENTER and not (x == 0 and r in (0, ROWS - 1))]
for (x, y) in campfires:
    new.append(struct(x, y, 0, targetname="void_campfire"))
    for k in range(6):
        a = 60 * k + rng.uniform(-8, 8)
        dx, dy, _ = d(a)
        new.append(model("p7_debris_rockychunks_small_07", x + dx * 30, y + dy * 30, 0, angles=f"0 {num(rng.uniform(0, 360))} 0"))

# zombie risers spread over platforms without fires
free = [(x, y) for (r, c, x, y) in platforms if (x, y) not in campfires and (x, y) != CENTER]
for (x, y) in free[::5]:
    new.append(riser(x, y, "z10"))

# --- central light pole: off until its switch is pulled; sparks at the wires all the time ---
cx, cy = CENTER
world.append(octagon(cx, cy, 6, 0, 420, IRON))
world.append(box(cx - 16, cx + 16, cy - 16, cy + 16, 420, 432, IRON))
new += switch(cx, cy - 6, "void_pole_switch_handle")
new.append(struct(cx, cy, 410, targetname="void_pole_light"))
new.append(model("p7_wires_electrical_rubber_04", cx + 22, cy + 6, 0, angles="0 20 0"))
new.append(model("p7_wires_electrical_rubber_04", cx - 20, cy + 14, 0, angles="0 160 0"))
new.append(fx("electrical_spark", cx + 12, cy + 10, 6))

# --- AI walk floor and zone volume ---
world.append(box(-XW, XW, Y0, Y1, -16, 0, CLIP_AI))
new.append(volume("z10", -XW - 60, XW + 60, Y0, Y1))

m.add_world(*world)
m.add(*new)
m.save()
print(f"void: {len(platforms)} platforms, {len(campfires)} campfires, {len(free[::5])} risers, "
      f"{len(world)} brushes, {len(new)} entities")
