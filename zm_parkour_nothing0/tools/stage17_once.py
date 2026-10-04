"""Design 17: ranch-style entrances at the 10 zone doors (not the Void's), decorated Void walls (the user's 4 plus a
new cross wall two octagon rows before the exit), and octagon-wood floor strips under every wall so none float.

Entrance (door centre y = yd, door octagon centred yd-57):
  - two gate columns (x 80..104 each side) and a crossbeam with a small sign board, ranch-gate style
  - a fire at the foot of each column on the approach (south) side
  - a slanted dividing wall (zone width, 256 tall, leaning 15 deg north) from the columns out to x 382, decorated with
    posts, a top cap and an iron band, and two lamps on top (the octagons' lamp: post, hurricane lamp, shade, lights)
  - an octagon-wood floor strip under the wall halves (not in the doorway, so the jump over the gap is unchanged)
  - player clip above the doorway, above the walls, and closing off the wall ends
"""

import math
import sys

from maplib import *

CHERRY = "t7_wood_varnished_clean_cherry_light"
CLIP_PLAYER = "clip"                     # the player clip the user's Void walls use
DOORS = [777, 2009, 3241, 4473, 5705, 11865, 13097, 14329, 15561, 16793]   # debris0-4, debris11-15 (door centre y)
SKY_Z = 1056
H = 256                                  # wall height
LEAN = math.tan(math.radians(15)) * H    # top shifted north by this much
T = 24                                   # wall thickness
X_COL0, X_COL1 = 80, 104                 # gate column, each side (doorway 160 = the octagon width)
X_END = 382                              # zone width


def sheared(x0, x1, y0, y1, z0, z1, mat, lean=LEAN, h=H):
    """A box whose y shifts north by lean * z / h (follows the wall's slant)."""
    def p(x, y, z):
        return (x, y + lean * z / h, z)
    v = {(i, j, k): p(x, y, z) for i, x in enumerate((x0, x1)) for j, y in enumerate((y0, y1)) for k, z in enumerate((z0, z1))}
    faces = [
        (v[0, 0, 0], v[1, 0, 0], v[1, 1, 0]),  # bottom
        (v[0, 0, 1], v[1, 0, 1], v[1, 1, 1]),  # top
        (v[0, 0, 0], v[0, 1, 0], v[0, 1, 1]),  # -x
        (v[1, 0, 0], v[1, 1, 0], v[1, 1, 1]),  # +x
        (v[0, 0, 0], v[1, 0, 0], v[1, 0, 1]),  # south (slanted)
        (v[0, 1, 0], v[1, 1, 0], v[1, 1, 1]),  # north (slanted)
    ]
    return solid(faces, mat)


LIGHT_KEYS = [
    [("PRIMARY_TYPE", "PRIMARY_SPOT"), ("_color", "1 0.6863 0.2353"), ("def", "gobo_smoke_01"), ("def_scroll", "0.1 0.002"),
     ("def_tile", "0.001 0.001"), ("falloffdistance", "30"), ("far_edge", "1"), ("fov_outer", "120"), ("roundness", "1"),
     ("stops", "3"), ("volumetric", "1"), ("volumetricIntensityBoost", "1")],
    [("PRIMARY_TYPE", "PRIMARY_SPOT"), ("_color", "0.9709 1 0.7255"), ("def", "cookie_flicker02"), ("def_scroll", "0.12 -0.011"),
     ("def_tile", "0.001 0.001"), ("falloffdistance", "6"), ("far_edge", "1"), ("fov_outer", "125"), ("roundness", "1"),
     ("stops", "2"), ("volumetric", "1"), ("volumetricCookies", "1")],
]
COMMON_LIGHT = [("ENABLE_FALLOFF", "1"), ("PRIMARY_NOSHADOWMAP", "1"), ("bake_intensity_scale", "1"), ("client_server", "ClientSide"),
                ("excludeDedicated", "Off"), ("penumbraRadius", "1.5"), ("radius", "100"), ("shadowUpdate", "Never"),
                ("shadowmapScale", "1"), ("superellipse", "0.75 1 0.75 1"), ("volumetricSampleCount", "8"), ("spawnflags", "84")]
n_lights = 0


def lamp(x, y, z):
    """The octagons' lamp: 8x8 post (48 tall), hurricane lamp on top, shade, the same two lights."""
    global n_lights
    out_brushes = [box(x - 4, x + 4, y - 4, y + 4, z, z + 48, CHERRY)]
    ents = [model("p7_zm_der2_light_hurricane_lamp", x, y, z + 48), model("p7_zm_der_light_shade", x, y, z + 72)]
    for keys in LIGHT_KEYS:
        n_lights += 1
        ents.append(entity([("classname", "light")] + keys + [("name", f"light_d17_{n_lights}"), ("origin", origin(x, y, z + 68))]
                           + COMMON_LIGHT + [(f"lightingstate{i}", "1") for i in range(1, 5)]))
    return out_brushes, ents


def entrance(yd):
    world, ents = [], []
    y0, y1 = yd - T / 2, yd + T / 2
    for s in (-1, 1):
        lo, hi = sorted((s * X_COL1, s * X_END))
        # slanted wall half, its posts (both faces), top cap and iron band
        world.append(sheared(lo, hi, y0, y1, 0, H, WOOD))
        for px in (X_COL1 + 2, 200, 296, X_END - 10):
            a, b = sorted((s * px, s * (px + 12)))
            world.append(sheared(a, b, y0 - 4, y1 + 4, 0, H, CHERRY))
        world.append(sheared(lo, hi, y0 - 6, y1 + 6, H - 14, H, CHERRY))
        world.append(sheared(lo, hi, y0 - 3, y1 + 3, 108, 124, IRON))
        # floor strip under this wall half (octagon wood), not in the doorway
        world.append(box(lo, hi, yd - 64, yd + 96, -16, 0, WOOD))
        # gate column
        c0, c1 = sorted((s * X_COL0, s * X_COL1))
        world.append(box(c0, c1, yd - 14, yd + 14, 0, 320, WOOD))
        # fire at its foot, approach side
        ents += [fx("fire/fx_fire_ground_rubble_sm_50x50", s * 140, yd - 40, 0),
                 fx("light/fx_light_fire_flicker_noshad_small", s * 140, yd - 40, 20)]
        # two lamps on the wall top
        b2, e2 = lamp(s * 240, yd + LEAN, H)
        world += b2
        ents += e2
        # clip: above the wall half, and closing the wall end
        world.append(box(lo, hi, yd - 40, yd + 110, 120, SKY_Z, CLIP_PLAYER))
        a, b = sorted((s * X_END, s * (X_END + 40)))
        world.append(box(a, b, yd - 80, yd + 120, -16, SKY_Z, CLIP_PLAYER))
    # crossbeam + sign board, clip above the doorway
    world.append(box(-136, 136, yd - 14, yd + 14, 292, 316, WOOD))
    world.append(box(-60, 60, yd - 18, yd - 14, 248, 284, CHERRY))
    world.append(box(-X_COL1, X_COL1, yd - 40, yd + 40, 292, SKY_Z, CLIP_PLAYER))
    return world, ents


def void_wall(x0, x1, y0, y1):
    """Decorate a Void wall (96 tall): cap, posts every ~136 on both faces, iron band, and an octagon-wood floor
    strip under it so it doesn't float over the gaps."""
    world = [box(x0 - 4, x1 + 4, y0 - 4, y1 + 4, 96, 104, CHERRY),
             box(x0, x1, y0 - 2, y1 + 2, 40, 52, IRON),
             box(x0 - 24, x1 + 24, y0 - 24, y1 + 24, -16, 0, WOOD)]
    along_x = (x1 - x0) >= (y1 - y0)
    a0, a1 = (x0, x1) if along_x else (y0, y1)
    n = max(2, int((a1 - a0) / 136) + 1)
    for i in range(n):
        c = a0 + (a1 - a0) * i / (n - 1)
        c = min(max(c, a0 + 6), a1 - 6)
        if along_x:
            world.append(box(c - 6, c + 6, y0 - 4, y1 + 4, 0, 96, CHERRY))
        else:
            world.append(box(x0 - 4, x1 + 4, c - 6, c + 6, 0, 96, CHERRY))
    return world


if __name__ == "__main__":
    m = Map(sys.argv[1])
    assert not any("light_d17_" in e for e in m.ents), "design 17 is already in this map"

    world, ents = [], []
    for yd in DOORS:
        w, e = entrance(yd)
        world += w
        ents += e

    # The user's Void walls (96 tall wood, clip to 288) + a new cross wall two octagon rows before the exit
    NEW = [(-272, 272, 9986, 10018)]   # one centre wall, the length of one old side segment (correction)
    for x0, x1, y0, y1 in NEW:
        world += [box(x0, x1, y0, y1, 0, 96, WOOD), box(x0, x1, y0, y1, 96, 288, CLIP_PLAYER)]
    for x0, x1, y0, y1 in [(-800, -256, 8960, 8992), (256, 800, 8960, 8992), (772, 804, 7120, 7664), (-812, -780, 7108, 7652)] + NEW:
        world += void_wall(x0, x1, y0, y1)

    m.add_world(*world)
    m.add(*ents)
    m.save()
    print(f"{len(DOORS)} entrances, {len(NEW)} new Void wall halves; {len(world)} brushes, {len(ents)} entities, {n_lights} lights")
