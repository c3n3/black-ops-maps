"""Design 18 (map part):
- the 10 zone entrances' loose fires become fires in iron bowls (like the Void entrance's), on a short pedestal,
  with player clip around each so nobody can stand in or on them
- 10 more Void campfires (same build as the others: struct + 6 rocks + 3 crossed planks), on free octagons away from
  every wall, prop and spawner, never on the entry/exit platform
- wall buys: Void back HAMR -> SVU; z5 Remington 870 -> KAP-40; spawn KAP-40 -> M14 (same spots and angles)
"""

import math
import random
import sys

from maplib import *

CLIP_PLAYER = "clip"
DOORS = [777, 2009, 3241, 4473, 5705, 11865, 13097, 14329, 15561, 16793]
VOID_Y0, VOID_Y1 = 7040, 10736
WALLS = [(-800, -256, 8960, 8992), (256, 800, 8960, 8992), (772, 804, 7120, 7664), (-812, -780, 7108, 7652),
         (-272, 272, 9986, 10018)]
SWAPS = {   # misc_prefab origin -> (old model, new model)
    "86.9997 10641 0": ("t6_hamr_wallbuy.map", "t6_svu-as_wallbuy.map"),
    "-334 6624 0": ("t6_remington_870_mcs_wallbuy.map", "t6_kap-40_wallbuy.map"),
    "-191 -96 16": ("t6_kap-40_wallbuy.map", "t6_m14_wallbuy.map"),
}

m = Map(sys.argv[1])
rng = random.Random(18)

# --- entrance fires -> bowls ---
loose = [i for i in range(1, len(m.ents)) if m.kv(i).get("classname") == "fx"
         and m.kv(i).get("fxdef") in ("fire/fx_fire_ground_rubble_sm_50x50", "light/fx_light_fire_flicker_noshad_small")
         and any(abs(float(m.kv(i)["origin"].split()[1]) - (yd - 40)) < 1 and abs(abs(float(m.kv(i)["origin"].split()[0])) - 140) < 1
                 for yd in DOORS)]
assert len(loose) == 40, len(loose)   # 10 doors x 2 sides x (fire + light)
m.ents = [e for i, e in enumerate(m.ents) if i not in loose]

world, ents = [], []
for yd in DOORS:
    for s in (-1, 1):
        x, y = s * 140, yd - 40
        world.append(box(x - 8, x + 8, y - 8, y + 8, 0, 32, IRON))                    # pedestal
        world.append(box(x - 18, x + 18, y - 18, y + 18, 32, 36, IRON))                # bowl floor
        for bx0, bx1, by0, by1 in ((-18, 18, -18, -15), (-18, 18, 15, 18), (-18, -15, -15, 15), (15, 18, -15, 15)):
            world.append(box(x + bx0, x + bx1, y + by0, y + by1, 36, 50, IRON))       # bowl rim
        world.append(box(x - 22, x + 22, y - 22, y + 22, 0, 128, CLIP_PLAYER))       # can't stand in / on it
        ents += [fx("fire/fx_fire_barrel_30x30", x, y, 38), fx("light/fx_light_barrel_fire_factory_zmb_strong", x, y, 60)]

# --- 10 more Void campfires ---
octs = []
for b in m.ws_brushes:
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if VOID_Y0 < y0 and y1 < VOID_Y1 and abs(z0 + 16) < 1 and abs(z1) < 1 and 180 < x1 - x0 < 200 and 180 < y1 - y0 < 200 \
            and "t7_wood_planks_damaged_teak" in b:
        octs.append(((x0 + x1) / 2, (y0 + y1) / 2))
fires = [tuple(map(float, kv(e)["origin"].split()[:2])) for e in m.ents if kv(e).get("targetname") == "void_campfire"]
props = []
for e in m.ents[1:]:
    k = kv(e)
    if k.get("origin") and k.get("targetname") != "void_campfire" and k.get("model") not in (
            "p7_debris_rockychunks_small_07", "p7_plank_wood_broken_2x4x64"):
        x, y, z = map(float, k["origin"].split())
        if VOID_Y0 - 100 < y < VOID_Y1 + 100 and -50 < z < 200:
            props.append((x, y))


def wall_dist(x, y):
    return min(math.hypot(max(x0 - x, 0, x - x1), max(y0 - y, 0, y - y1)) for x0, x1, y0, y1 in WALLS)


free = sorted([(x, y) for (x, y) in octs
               if not (x == 0 and (y < VOID_Y0 + 200 or y > VOID_Y1 - 500))                   # entry / exit platforms
               and all(math.hypot(x - fx_, y - fy) > 60 for fx_, fy in fires)
               and all(math.hypot(x - px, y - py) > 110 for px, py in props)
               and wall_dist(x, y) > 70], key=lambda p: (p[1], p[0]))
assert len(free) >= 10, len(free)
picks = [free[int(i * len(free) / 10)] for i in range(10)]
for (x, y) in picks:
    ents.append(struct(x, y, 0, targetname="void_campfire"))
    for k in range(6):
        dx, dy, _ = d(60 * k + rng.uniform(-8, 8))
        ents.append(model("p7_debris_rockychunks_small_07", x + dx * 30, y + dy * 30, 0, angles=f"0 {num(rng.uniform(0, 360))} 0"))
    for k, yaw in enumerate((0, 60, 120)):
        ents.append(model("p7_plank_wood_broken_2x4x64", x, y, 1 + k, angles=f"0 {num(yaw + rng.uniform(-10, 10))} 0", scale=0.4))

# --- wall buy swaps ---
done = 0
for i in range(1, len(m.ents)):
    k = m.kv(i)
    if k.get("classname") == "misc_prefab" and k.get("origin") in SWAPS:
        old, new = SWAPS[k["origin"]]
        assert k["model"].endswith(old), (k["origin"], k["model"])
        m.ents[i] = m.ents[i].replace(old, new)
        done += 1
assert done == len(SWAPS), done

m.add_world(*world)
m.add(*ents)
m.save()
print(f"bowls at {len(DOORS) * 2} entrance fires; campfires {len(fires)} -> {len(fires) + len(picks)} (new at {picks}); "
      f"{done} wall buys swapped")
