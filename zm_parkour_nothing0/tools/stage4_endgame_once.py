"""Stage 4 (design 7): dog spawner, dog locations in every zone, Warden locations (Warden AI is deferred)."""

import sys

from maplib import *

PITCH = 1232
YC = 24576
VOID_POLE = (0, 12080 + 8 * 228)

m = Map(sys.argv[1])
assert not m.find(targetname="warden_location"), "stage 4 is already in this map"
new = []


def dog(x, y, zone):
    return entity([("classname", "script_struct"), ("origin", origin(x, y, 0)), ("script_noteworthy", "dog_location"),
                   ("targetname", f"{zone}_spawners"), ("_color", "1 0 0")])


def warden(x, y, zone):
    return entity([("classname", "script_struct"), ("angles", "0 270 0"), ("origin", origin(x, y, 0)),
                   ("script_noteworthy", zone), ("targetname", "warden_location"), ("_color", "1 0 1")])


# normal zones reuse z1's grid: dogs on the two outer front octagons, the Warden on the inner middle one
for k in list(range(1, 10)) + list(range(11, 17)):
    dy = (k - 1) * PITCH if k < 10 else (k + 1) * PITCH
    new += [dog(-256, 1248 + dy, f"z{k}"), dog(256, 1248 + dy, f"z{k}"), warden(128, 1472 + dy, f"z{k}")]

# the Void: dogs on four fire-free outer platforms; the Warden next to the light pole
for (x, y) in ((-792, 12536), (792, 12536), (-792, 14816), (792, 14816)):
    new.append(dog(x, y, "z10"))
new.append(warden(VOID_POLE[0] + 64, VOID_POLE[1], "z10"))

# lighthouse island and spawn
new += [dog(-300, YC - 200, "lighthouse"), dog(300, YC + 200, "lighthouse"), warden(-340, YC, "lighthouse")]
new.append(warden(0, -100, "start_zone"))

# the dog spawner (dogs are placed at a dog_location when they spawn), same setup as the Giant's
new.append(entity([("classname", "actor_spawner_zm_factory_zombie_dog"), ("ALERTONSPAWN", "0"), ("MAKEROOM", "1"),
                   ("angles", "0 90 0"), ("export", "3"), ("origin", origin(-150, -200, 16)), ("script_forcespawn", "1"),
                   ("script_noteworthy", "zombie_dog_spawner"), ("targetname", "special_dog_spawner"), ("SPAWNER", "1"),
                   ("_color", "1 0.25 0"), ("count", "1"), ("engageMaxDist", "768"), ("engageMinDist", "256"),
                   ("model", "zombie_wolf"), ("script_dropammo", "1"), ("sm_active_count_max", "3"),
                   ("sm_active_count_min", "3"), ("spawnflags", "3")]))

m.add(*new)
m.save()
print(f"stage 4: {len(new)} entities")
