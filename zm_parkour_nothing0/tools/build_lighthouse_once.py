"""One-off: replace the distant white disc with a brush lighthouse + nuke switch (design ai/5.md)."""

import re
import sys
import uuid

MAP = sys.argv[1]
YC = 24576  # centred on the existing lights at y 24565.5 / 24581.5
WALL = "testmap_white_240"
WOOD = "t7_wood_planks_damaged_teak"

text = open(MAP, encoding="utf-8", newline="").read()
assert "\r\n" not in text
header, rest = text.split("// entity 0\n", 1)
blocks = re.split(r"(?m)^// entity \d+\n", "// entity 0\n" + rest)[1:]


def guid():
    return "{" + str(uuid.uuid4()).upper() + "}"


def fmt(v):
    return str(int(v)) if v == int(v) else repr(v)


def box(x0, x1, y0, y1, z0, z1, mat):
    tex = f"{mat} 64 64 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0"
    faces = [  # same winding as the axis-aligned brush 3 in this map
        ((x0, y0, z0), (x1, y0, z0), (x1, y1, z0)),
        ((x0, y1, z1), (x1, y1, z1), (x1, y0, z1)),
        ((x0, y0, z0), (x0, y0, z1), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y0, z0), (x1, y0, z1)),
        ((x1, y1, z0), (x1, y1, z1), (x0, y1, z1)),
        ((x0, y1, z1), (x0, y0, z1), (x0, y0, z0)),
    ]
    body = f' guid "{guid()}"\n'
    for f in faces:
        body += " " + " ".join(f"( {fmt(a)} {fmt(b)} {fmt(c)} )" for a, b, c in f) + f" {tex}\n"
    return body


def y(v):
    return YC + v


# --- worldspawn: drop the white disc, add the lighthouse ---
ws = blocks[0]
brushes = re.findall(r"(?ms)^// brush \d+\n\{\n.*?^\}\n", ws)
head = ws[: ws.index(brushes[0])]
assert ws == head + "".join(brushes) + "}\n"
disc = [b for b in brushes if "testmap_white_240 0.5 0.5" in b]
assert len(disc) == 1
brushes.remove(disc[0])
bodies = [re.sub(r"(?s)^// brush \d+\n\{\n(.*)\}\n$", r"\1", b) for b in brushes]

bodies += [
    box(-256, 256, y(-256), y(256), -64, 0, WOOD),        # island
    box(-96, 96, y(80), y(96), 0, 400, WALL),             # north wall (switch side)
    box(80, 96, y(-80), y(80), 0, 400, WALL),             # east wall
    box(-96, -80, y(-80), y(80), 0, 400, WALL),           # west wall
    box(-96, -32, y(-96), y(-80), 0, 400, WALL),          # south wall, left of door
    box(32, 96, y(-96), y(-80), 0, 400, WALL),            # south wall, right of door
    box(-32, 32, y(-96), y(-80), 112, 400, WALL),         # over the door
    box(-128, 128, y(-128), y(128), 400, 416, WOOD),      # gallery floor / tower ceiling
    box(80, 96, y(80), y(96), 416, 544, WALL),            # lantern posts
    box(-96, -80, y(80), y(96), 416, 544, WALL),
    box(80, 96, y(-96), y(-80), 416, 544, WALL),
    box(-96, -80, y(-96), y(-80), 416, 544, WALL),
    box(-112, 112, y(-112), y(112), 544, 560, WOOD),      # lantern roof
    box(-48, 48, y(-48), y(48), 560, 608, WALL),          # cap
]
ws = head + "".join(f"// brush {i}\n{{\n{b}}}\n" for i, b in enumerate(bodies)) + "}\n"
blocks[0] = ws

# --- nuke switch on the inside of the north wall (power switch models, own trigger) ---
sy = y(80)  # wall face; at angles 0 the stock switch has its wall on +y
new = [
    "{\n"
    f'guid "{guid()}"\n"classname" "misc_model"\n"model" "p7_zm_der_pswitch_body"\n'
    f'"origin" "0 {fmt(sy + 2)} -1"\n"modelscale" "1"\n"static" "1"\n'
    '"lightingstate1" "1"\n"lightingstate2" "1"\n"lightingstate3" "1"\n"lightingstate4" "1"\n}\n',
    "{\n"
    f'guid "{guid()}"\n"classname" "script_model"\n"angles" "0 0 90"\n"model" "p7_zm_der_pswitch_handle"\n'
    f'"origin" "-1 {fmt(sy - 7)} 45"\n"targetname" "lighthouse_switch_handle"\n"client_server" "ServerSide"\n'
    '"lightingstate1" "1"\n"lightingstate2" "1"\n"lightingstate3" "1"\n"lightingstate4" "1"\n"modelscale" "1"\n}\n',
    "{\n"
    f'guid "{guid()}"\n"classname" "trigger_use"\n"targetname" "lighthouse_switch"\n"cursorhint" "HINT_ACTIVATE"\n'
    f"// brush 0\n{{\n{box(-24, 24, sy - 40, sy - 4, 16, 72, 'trigger')}}}\n}}\n",
]

out = header
for i, b in enumerate(blocks):
    out += f"// entity {i}\n" + b
for j, b in enumerate(new):
    out += f"// entity {len(blocks) + j}\n" + b
open(MAP, "w", encoding="utf-8", newline="").write(out)
print(f"removed disc, worldspawn now {len(bodies)} brushes, added {len(new)} switch entities")
