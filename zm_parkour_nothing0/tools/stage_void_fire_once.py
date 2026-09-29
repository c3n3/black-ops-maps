"""Void: a layer of fire ~500 below the platforms, and wood in the middle of every campfire."""

import random
import sys

from maplib import *

X0, X1, Y0, Y1 = -1140, 1140, 11968, 15664    # the Void (z10)
FIRE_Z = -500
STEP = 280

m = Map(sys.argv[1])
assert not m.find(fxdef="fire/fx_fire_line_sm_evb"), "the Void fire layer is already in this map"
new = []

# fire sheet: a grid of the largest stock ground fire (~170x160 each), jittered so it doesn't read as rows
rng = random.Random(10)
n_fire = 0
x = X0 + STEP / 2
while x < X1:
    y = Y0 + STEP / 2
    while y < Y1:
        new.append(fx("fire/fx_fire_line_sm_evb", x + rng.uniform(-40, 40), y + rng.uniform(-40, 40), FIRE_Z,
                      angles=f"0 {num(rng.uniform(0, 360))} 0"))
        n_fire += 1
        y += STEP
    x += STEP

# orange glow from the fire, lighting the platforms' undersides
n_light = 0
for lx in (-760, 0, 760):
    for ly in range(12300, 15400, 740):
        new.append(light(lx, ly, FIRE_Z + 20, "1 0.45 0.15", 7, 700))
        n_light += 1

# wood in the middle of each campfire: three broken planks crossed, scaled down to fit inside the stone ring
fires = [kv(e)["origin"].split() for e in m.ents if kv(e).get("targetname") == "void_campfire"]
assert len(fires) == 65, len(fires)
for (fx_, fy, fz) in fires:
    for k, yaw in enumerate((0, 60, 120)):
        new.append(model("p7_plank_wood_broken_2x4x64", float(fx_), float(fy), float(fz) + 1 + k,
                         angles=f"0 {num(yaw + rng.uniform(-10, 10))} 0", scale=0.4))

m.add(*new)
m.save()
print(f"void fire: {n_fire} fires, {n_light} glow lights, wood in {len(fires)} campfires ({len(new)} entities)")
