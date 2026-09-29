"""Design 10 (map side)."""

import math
import random
import re
import sys

from maplib import *

YC = 19648                                   # lighthouse centre (after the zone cut)
VOID_ROW0, ROW_DY, ROWS = 7152, 228, 15      # the Void after the zone cut
VOID_Y0, VOID_Y1, VOID_XW = 7040, 10736, 1140
VOID_CENTER = (0, VOID_ROW0 + 8 * ROW_DY)
RED = "t7_acrylic_red_flake"
BRICK = "t7_brick_worn_red"
rng = random.Random(100)

m = Map(sys.argv[1])
assert not m.find(targetname="debris_start"), "design 10 is already in this map"


def drop(pred):
    before = len(m.ents)
    m.ents = [m.ents[0]] + [e for e in m.ents[1:] if not pred(kv(e), e)]
    return before - len(m.ents)


def xyz(k):
    return tuple(float(c) for c in k["origin"].split())


def set_key(i, key, value):
    k = kv(m.ents[i])
    m.ents[i] = m.ents[i].replace(f'"{key}" "{k[key]}"', f'"{key}" "{value}"')


report = {}

# --- more dog spawn sites in the Void (fire-free platforms, spread out) ---
fires = {(round(xyz(kv(e))[0]), round(xyz(kv(e))[1])) for e in m.ents if kv(e).get("targetname") == "void_campfire"}
dogs = {(round(xyz(kv(e))[0]), round(xyz(kv(e))[1])) for e in m.ents
        if kv(e).get("targetname") == "z10_spawners" and kv(e).get("script_noteworthy") == "dog_location"}
free = []
for r in range(ROWS):
    y = VOID_ROW0 + r * ROW_DY
    for x in (range(-1056, 1057, 264) if r % 2 == 0 else range(-924, 925, 264)):
        if (x, y) not in fires and (x, y) not in dogs and (x, y) != VOID_CENTER:
            free.append((x, y))
picks = free[3::max(1, len(free) // 8)][:8]
for (x, y) in picks:
    m.add(entity([("classname", "script_struct"), ("origin", origin(x, y, 0)), ("script_noteworthy", "dog_location"),
                  ("targetname", "z10_spawners"), ("_color", "1 0 0")]))
report["void dog spots"] = len(dogs) + len(picks)

# --- safety circles 15% smaller: radius 75 -> 64 ---
circles = {}
for e in m.ents:
    k = kv(e)
    if k.get("targetname") == "safety_circle_center":
        circles[k["script_noteworthy"]] = xyz(k)
drop(lambda k, e: k.get("targetname") in ("safety_circle", "safety_circle_center") or k.get("_color") == "0.2 1 0.3")
R = 64
for name, (x, y, zc) in circles.items():
    z = zc + 6
    m.add(entity([("classname", "script_brushmodel"), ("targetname", "safety_circle")]
                 + [(f"lightingstate{i}", "1") for i in range(1, 5)], [ngon(x, y, R, 16, z - 6, z + 6, CAULK, bottom=GREEN)]))
    m.add(struct(x, y, zc, targetname="safety_circle_center", script_noteworthy=name, radius=str(R)))
    m.add(light(x, y, z - 60, "0.2 1 0.3", 7, 180))
report["circle radius"] = R

# --- copies of every wall gun on the lighthouse's outside faces (the south-west face is left for the PaP) ---
guns = sorted({kv(e)["model"] for e in m.ents if kv(e).get("model", "").endswith("_wallbuy.map")})
faces = [(270, -80), (315, 0), (0, 0), (45, 0), (90, 0), (135, 0), (180, 0)]   # (face angle, offset along the face)
assert len(guns) <= len(faces), guns
for gun, (phi, off) in zip(guns, faces):
    dx, dy, _ = d(phi)
    tx, ty = -dy, dx                                   # along the face
    dist = 288 - 0.1935 * 54 + 2                       # 2 units off the tapered wall at chalk height (z ~54)
    m.add(prefab(gun, dx * dist + tx * off, YC + dy * dist + ty * off, 0, angles=f"0 {num((phi - 90) % 360)} 0"))
report["lighthouse wall guns"] = [g.split("/")[-1] for g in guns]

# --- island Pack-a-Punch: turned 90 degrees to face south, pushed to the island's south-west edge ---
pap = [i for i, e in enumerate(m.ents) if kv(e).get("model", "").endswith("vending_weapon_upgrade_spawnable.map")
       and abs(xyz(kv(e))[1] - YC) < 450]
assert len(pap) == 1, pap
set_key(pap[0], "origin", origin(-110, YC - 386, 0))
set_key(pap[0], "angles", "0 0 0")

# --- lighthouse lamp: the bright non-spot light (15 stops) is washing everything out ---
lamp = [i for i, e in enumerate(m.ents) if kv(e).get("classname") == "light" and kv(e).get("origin") == f"0 {num(YC + 5.5)} 612"]
assert len(lamp) == 1, lamp
set_key(lamp[0], "stops", "6")

# --- $0 debris across the spawn deck's north edge: a line of barrels; buying it starts round 1 ---
m.add(struct(0, 400, 400, targetname="debris_start_away"))
for x in range(-192, 193, 48):
    m.add(entity([("classname", "script_model"), ("model", "p7_barrel_metal_55gal_blue"), ("origin", origin(x, 84, 16)),
                  ("angles", f"0 {num(rng.uniform(0, 360))} 0"), ("target", "debris_start_away"), ("targetname", "debris_start"),
                  ("_color", "1 0 0"), ("client_server", "ServerSide"), ("modelscale", "1"), ("shadow_casting", "1")]
                 + [(f"lightingstate{i}", "1") for i in range(1, 5)]))
m.add(entity([("classname", "script_brushmodel"), ("DYNAMICPATH", "1"), ("script_noteworthy", "clip"), ("targetname", "debris_start"),
              ("_color", "0 0.5 0.8"), ("spawnflags", "1")] + [(f"lightingstate{i}", "1") for i in range(1, 5)],
             [box(-216, 224, 66, 104, 16, 240, "clip")]))
m.add(entity([("classname", "trigger_use_touch"), ("script_flag", "map_entrance_open"), ("target", "debris_start"),
              ("targetname", "zombie_debris"), ("zombie_cost", "0"), ("_color", "0.3 0.5 0.8"), ("cursorhint", "HINT_ACTIVATE")],
             [box(-208, 216, 40, 66, 16, 120, TRIGGER)]))

# --- lighthouse body in red brick (the tower walls and central column, not the lantern) ---
n_brick = 0
for i, b in enumerate(m.ws_brushes):
    if " testmap_white_240 " in b:
        (x0, y0, z0), (x1, y1, z1) = bounds(b)
        if x0 > -320 and x1 < 320 and y0 > YC - 320 and y1 < YC + 320 and z1 <= 496.5:
            m.ws_brushes[i] = b.replace(" testmap_white_240 ", f" {BRICK} ")
            n_brick += 1
report["brick brushes"] = n_brick

# --- no zombie/dog spawns on the island (the approach platforms keep theirs) ---
report["island spawns removed"] = drop(lambda k, e: k.get("targetname") == "lighthouse_spawners"
                                       and math.hypot(xyz(k)[0], xyz(k)[1] - YC) < 420)

# --- swap switches: power switch to the spawn light pole; global light switch to the old power switch spot ---
pw = [i for i, e in enumerate(m.ents) if kv(e).get("model") == "_prefabs/zm/zm_core/power_switch.map"]
assert len(pw) == 1
set_key(pw[0], "origin", origin(30, -322, 16))            # angles 0 180 0 kept: wall on -y, players on the deck side
m.add_world(box(22, 38, -330, -322, 16, 96, IRON))         # backing post beside the pole
old_ambient = [b for b in m.ws_brushes if bounds(b)[0][0] > 203 and bounds(b)[1][0] < 213 and bounds(b)[0][1] > -160 and bounds(b)[1][1] < -120]
assert len(old_ambient) == 1
m.ws_brushes.remove(old_ambient[0])
drop(lambda k, e: k.get("targetname") == "ambient_light_handle" or (k.get("model") == "p7_zm_der_pswitch_body" and k.get("origin") == "202 -140 15"))
m.add(model("p7_zm_der_pswitch_body", 0, -818, -1, angles="0 180 0"))   # the old power switch's plank (y -832..-816) is behind it
m.add(entity([("classname", "script_model"), ("angles", "0 180 90"), ("model", "p7_zm_der_pswitch_handle"),
              ("origin", origin(1, -809, 45)), ("targetname", "ambient_light_handle"), ("client_server", "ServerSide"),
              ("modelscale", "1")] + [(f"lightingstate{i}", "1") for i in range(1, 5)]))

# --- red "I" on the start sign (board front at y 0, blood decal at y -2..0) ---
SX = 152
m.add_world(stroke_xz(-4, SX, 58, SX, 82, 8, 2, RED),
            stroke_xz(-4, SX - 8, 82, SX + 8, 82, 6, 2, RED),
            stroke_xz(-4, SX - 8, 58, SX + 8, 58, 6, 2, RED))

# --- fire under the Void: denser and more sporadic ---
report["old fires removed"] = drop(lambda k, e: k.get("fxdef") == "fire/fx_fire_line_sm_evb")
n = 0
x = -VOID_XW + 60
while x < VOID_XW:
    y = VOID_Y0 + 60
    while y < VOID_Y1:
        if rng.random() > 0.18:
            m.add(fx("fire/fx_fire_line_sm_evb", x + rng.uniform(-90, 90), y + rng.uniform(-90, 90), rng.uniform(-530, -470),
                     angles=f"0 {num(rng.uniform(0, 360))} 0"))
            n += 1
        y += 190
    x += 190
for _ in range(60):
    m.add(fx("fire/fx_fire_ground_rubble_50x50", rng.uniform(-VOID_XW, VOID_XW), rng.uniform(VOID_Y0, VOID_Y1), rng.uniform(-520, -480)))
report["void fires"] = f"{n} big + 60 small"

m.save()
for k, v in report.items():
    print(f"{k}: {v}")
