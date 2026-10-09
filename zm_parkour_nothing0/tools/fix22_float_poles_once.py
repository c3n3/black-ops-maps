"""Design 22 correction: the lighthouse grounds' 16 pole lights float just off the island's edge instead of standing
on it -- each pole (brushes, lamp, shade, light) moves 72 straight outward: south row y 19272 -> 19200, north row
20024 -> 20096, east/west columns x +-376 -> +-448 (48 clear of the edge at x +-400 / y 19248, 20048)."""

import re
import sys

from maplib import *

OUT = 72
m = Map(sys.argv[1])


def shift_for(x, y):
    """The outward shift for a pole at (x, y), or None if it isn't one of the 16."""
    if abs(y - 19272) < 1 and abs(x) < 300:
        return (0, -OUT)
    if abs(y - 20024) < 1 and abs(x) < 300:
        return (0, OUT)
    if abs(abs(x) - 376) < 1 and 19300 < y < 20000:
        return (OUT if x > 0 else -OUT, 0)
    return None


moved_b = 0
for i, b in enumerate(m.ws_brushes):
    (x0, y0, z0), (x1, y1, z1) = bounds(b)
    if "t7_metal_worn_iron_dark" not in b or not ((abs(x1 - x0 - 6) < 0.1 and abs(z1 - 160) < 0.1) or (abs(x1 - x0 - 12) < 0.1 and abs(z1 - 8) < 0.1)):
        continue
    s = shift_for((x0 + x1) / 2, (y0 + y1) / 2)
    if s and abs(z0) < 0.1:
        def mv(mt):
            return f"( {num(float(mt.group(1)) + s[0])} {num(float(mt.group(2)) + s[1])} {mt.group(3)} )"
        m.ws_brushes[i] = re.sub(r"\( (\S+) (\S+) (\S+) \)", mv, b)
        moved_b += 1

moved_e = 0
for i in range(1, len(m.ents)):
    k = m.kv(i)
    if k.get("model") in ("p7_zm_der2_light_hurricane_lamp", "p7_zm_der_light_shade") or k.get("classname") == "light":
        x, y, z = map(float, k.get("origin", "0 0 0").split())
        s = shift_for(x, y)
        if s and z > 150:
            m.ents[i] = m.ents[i].replace(f'"origin" "{k["origin"]}"', f'"origin" "{origin(x + s[0], y + s[1], z)}"')
            moved_e += 1

assert moved_b == 32 and moved_e == 48, (moved_b, moved_e)   # 16 x (pole + base plate), 16 x (lamp, shade, light)
m.save()
print(f"moved {moved_b} brushes and {moved_e} entities outward by {OUT}")
