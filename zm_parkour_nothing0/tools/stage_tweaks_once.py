"""Tweaks: circles 3x bigger, solid red VOID letters, smaller start sign with a little fire, ambient light switch."""

import sys

from maplib import *

m = Map(sys.argv[1])
assert not m.find(targetname="ambient_light_handle"), "already applied"

# --- safety circles: radius 25 -> 75 ---
circles, keep = {}, []
for e in m.ents:
    k = kv(e)
    if k.get("targetname") == "safety_circle_center":
        circles[k["script_noteworthy"]] = tuple(float(c) for c in k["origin"].split())
        continue
    if k.get("targetname") == "safety_circle" or k.get("_color") == "0.2 1 0.3":
        continue
    keep.append(e)
m.ents = keep
assert set(circles) == {"spawn", "center", "lighthouse"}
R = 75
for name, (x, y, zc) in circles.items():
    z = zc + 6
    m.add(entity([("classname", "script_brushmodel"), ("targetname", "safety_circle")]
                 + [(f"lightingstate{i}", "1") for i in range(1, 5)],
                 [ngon(x, y, R, 16, z - 6, z + 6, CAULK, bottom=GREEN)]))
    m.add(struct(x, y, zc, targetname="safety_circle_center", script_noteworthy=name, radius=str(R)))
    m.add(light(x, y, z - 60, "0.2 1 0.3", 7, 200))

# --- VOID letters: the smear decal only covers part of each stroke, use a solid red paint ---
n_letters = 0
for i, b in enumerate(m.ws_brushes):
    if " t7_decal_blood_smear_01 " in b:
        m.ws_brushes[i] = b.replace(" t7_decal_blood_smear_01 ", " t7_acrylic_red_flake ")
        n_letters += 1

# --- start sign: remove the old board / stand / splatter, build a smaller one with a little fire under it ---
old = []
for i, b in enumerate(m.ws_brushes):
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if x0 >= 100 and x1 <= 204 and y0 >= -4 and y1 <= 10 and z0 >= 14 and z1 <= 122:
        old.append(i)
assert len(old) == 3, old
m.ws_brushes = [b for i, b in enumerate(m.ws_brushes) if i not in old]
SX = 152
m.add_world(
    box(SX - 28, SX + 28, 0, 8, 48, 92, IRON),                                                    # board 56 x 44
    box(SX - 4, SX + 4, 2, 6, 16, 48, IRON),                                                      # stand
    box(SX - 24, SX + 24, -2, 0, 52, 88, CAULK, faces={"-y": "t7_decal_blood_splatter_01"}),     # blood
)
m.add(fx("fire/fx_fire_ground_rubble_sm_50x50", SX, -12, 16))
m.add(fx("light/fx_light_fire_flicker_noshad_small", SX, -12, 36))

# --- ambient light switch: east edge of the spawn deck, facing west (players stand on -x) ---
AX, AY, TOP = 200, -140, 16
m.add_world(box(AX + 4, AX + 12, AY - 16, AY + 16, TOP, TOP + 80, IRON))                       # backing post
m.add(model("p7_zm_der_pswitch_body", AX + 2, AY, TOP - 1, angles="0 270 0"))
m.add(entity([("classname", "script_model"), ("angles", "0 270 90"), ("model", "p7_zm_der_pswitch_handle"),
              ("origin", origin(AX - 7, AY + 1, TOP + 45)), ("targetname", "ambient_light_handle"),
              ("client_server", "ServerSide"), ("modelscale", "1")] + [(f"lightingstate{i}", "1") for i in range(1, 5)]))

m.save()
print(f"circles r={R}; {n_letters} letter strokes repainted; start sign rebuilt; ambient switch at {(AX, AY, TOP)}")
