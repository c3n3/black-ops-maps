"""Design 12: red glowing see-through material for the endgame path.

Makes texture_assets/zm_parkour_nothing0/endgame_path_red.tif (RGBA) and adds image i_endgame_path_red and
material mtl_endgame_path_red (lit_emissive_transparent, cloned from a skye weapon-pack material) to
source_data/zm_parkour_nothing0.gdt. Run from the BO3 root: uv run --with pillow python <this>
"""

import re

from PIL import Image

GDT = "source_data/zm_parkour_nothing0.gdt"
TEMPLATE_GDT = "source_data/skye_t6_storm_psr.gdt"
TIF = "texture_assets/zm_parkour_nothing0/endgame_path_red.tif"
IMAGE, MATERIAL = "i_endgame_path_red", "mtl_endgame_path_red"

# 256 tile, one even see-through red (the texture repeats every 64 units, so borders would draw seams across the strip)
img = Image.new("RGBA", (256, 256), (255, 36, 24, 140))
img.save(TIF, compression="tiff_lzw")

gdt = open(GDT, encoding="utf-8", newline="").read()
assert f'"{MATERIAL}"' not in gdt, "already added"
src = open(TEMPLATE_GDT, encoding="utf-8", newline="").read()


def block(text, name, kind):
    return re.search(rf'(?ms)^\t"{name}" \( "{kind}" \)\r?\n\t\{{\r?\n.*?^\t\}}\r?\n', text).group(0)


def setkey(body, key, value):
    body, n = re.subn(rf'(?m)^(		"{key}" )"[^"]*"', lambda m: m.group(1) + '"' + value + '"', body)
    assert n == 1, key
    return body


mat = block(src, "mtl_t6_attach_scanner_burn", "material.gdf").replace('"mtl_t6_attach_scanner_burn"', f'"{MATERIAL}"')
for k, v in (("colorMap", IMAGE), ("colorMap00", IMAGE), ("usage", "tools"), ("locale_zombie", "1"), ("locale_tools", "1")):
    mat = setkey(mat, k, v)

img_block = block(src, "i_t6_attach_scanner_burn_c", "image.gdf").replace('"i_t6_attach_scanner_burn_c"', f'"{IMAGE}"')
img_block = setkey(img_block, "baseImage", TIF.replace("/", "\\\\"))

nl = "\r\n" if "\r\n" in gdt else "\n"
img_block, mat = (b.replace("\r\n", "\n").replace("\n", nl) for b in (img_block, mat))
end = gdt.rstrip().rfind("}")
gdt = gdt[:end] + img_block + mat + gdt[end:]
open(GDT, "w", encoding="utf-8", newline="").write(gdt)
print("added", IMAGE, MATERIAL)
