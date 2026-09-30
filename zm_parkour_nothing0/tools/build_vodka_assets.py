"""Design 14: build the Vodka perk's assets from the DEVRAW Dew machine and the CYO perk template.

- machine: DEVRAW Dew's model reused through skinOverride, textures whitewashed, the "DEVRAW" sign repainted as a
  dark plaque lettered "VODKA" in white (the letters glow: they're written into the emissive map too)
- art: a drawn clear vodka bottle (HUD perk icon and bottle label), no downloads
- bottle: the template's BO4 bottle, tints turned white/clear, the vodka art on the label
- HUD shader, machine FX (white), sounds (DEVRAW Dew's for now), localized string, zone package

Run from anywhere:  uv run --with pillow --with numpy build_vodka_assets.py
"""

import re
import shutil
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

BO3 = Path(r"C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III")
DEVRAW = Path(r"C:\Users\ccade\Downloads\DEVRAW Dew-20260929T115735Z-1-001\DEVRAW Dew")
CYO = Path(r"C:\Users\ccade\Downloads\CYO Perk-20260929T115413Z-1-001\CYO Perk")
MAP = BO3 / "usermaps" / "zm_parkour_nothing0"
ICON = MAP / "images" / "vodka_icon.png"

OUT = BO3 / "model_export" / "_zm_parkour_nothing0" / "vodka"
IMG = OUT / "_images"
SRC_IMG = DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "_images"
SIGN_TEXT_BOX = (1585, 1992, 1855, 2037)          # "DEVRAW" on the machine's base textures (2048x2048)
SIGN_AREA = (1500, 1850, 1950, 2048)
FONT = r"C:/Windows/Fonts/bahnschrift.ttf"


def whitewash(rgb):
    """Colour filter: keep each pixel's shading, lift it to a slightly cool off-white."""
    lum = rgb[..., 0] * 0.299 + rgb[..., 1] * 0.587 + rgb[..., 2] * 0.114
    v = 196 + lum * 0.23
    return np.stack([v * 0.97, v * 0.99, v], axis=-1)


def plaque(rgb):
    """The sign, repainted near-black but keeping its grain."""
    lum = rgb[..., 0] * 0.299 + rgb[..., 1] * 0.587 + rgb[..., 2] * 0.114
    v = 10 + lum * 0.12
    return np.stack([v, v, v * 1.05], axis=-1)


def sign_mask(color_rgb):
    """The cream sign on the base colour map, including its ragged darker edge."""
    x0, y0, x1, y1 = SIGN_AREA
    reg = color_rgb[y0:y1, x0:x1]
    cream = (reg.mean(axis=2) > 60) & (reg[..., 0] > reg[..., 2] + 3)
    grow = Image.fromarray(np.uint8(cream) * 255).filter(ImageFilter.MaxFilter(15)).filter(ImageFilter.MinFilter(9))
    m = np.zeros(color_rgb.shape[:2], bool)
    m[y0:y1, x0:x1] = np.array(grow) > 0
    tx0, ty0, tx1, ty1 = SIGN_TEXT_BOX
    m[ty0 - 4:ty1 + 4, tx0 - 4:tx1 + 4] = True     # the lettering sits inside the sign
    return m


def erase_letters(img):
    """Paint out "DEVRAW" (only its letter strokes, filled from a blur of the sign around them)."""
    x0, y0, x1, y1 = SIGN_TEXT_BOX
    pad = 24
    box = (x0 - pad, y0 - pad, min(x1 + pad, img.width), min(y1 + pad, img.height))
    reg = np.array(img.crop(box)).astype(float)
    letters = reg.mean(axis=2) < 70
    letters[:pad - 4, :] = False
    letters = np.array(Image.fromarray(np.uint8(letters) * 255).filter(ImageFilter.MaxFilter(5))) > 0
    keep = (~letters).astype(float)
    filled = reg.copy()
    for radius in (6, 14, 30):                     # normalized-convolution inpaint: widen until every hole is covered
        w = np.array(Image.fromarray(np.uint8(keep * 255)).filter(ImageFilter.GaussianBlur(radius))).astype(float) / 255
        for ch in range(3):
            num = np.array(Image.fromarray(np.uint8(np.clip(reg[..., ch] * keep, 0, 255))).filter(ImageFilter.GaussianBlur(radius))).astype(float)
            est = np.where(w > 0.02, num / np.maximum(w, 1e-6), filled[..., ch])
            filled[..., ch] = np.where(letters & (w > 0.02), est, filled[..., ch])
    img.paste(Image.fromarray(np.uint8(np.clip(filled, 0, 255))), box[:2])
    return img


def bold(size):
    font = ImageFont.truetype(FONT, size)
    try:
        font.set_variation_by_name("Bold")
    except Exception:
        pass
    return font


def letter(img, text, ink):
    """Write `text` centred in the sign's text box, as large as fits."""
    x0, y0, x1, y1 = SIGN_TEXT_BOX
    d = ImageDraw.Draw(img)
    size = 60
    while True:
        font = bold(size)
        l, t, r, b = d.textbbox((0, 0), text, font=font)
        if r - l <= (x1 - x0) and b - t <= (y1 - y0) or size <= 10:
            break
        size -= 1
    d.text((x0 + ((x1 - x0) - (r - l)) / 2 - l, y0 + ((y1 - y0) - (b - t)) / 2 - t), text, font=font, fill=ink)
    return img


def draw_icon():
    """512x512 perk icon: a clear vodka bottle (silver cap, white label) on a dark round badge with a white rim."""
    S = 4                                          # draw at 4x, then downsample for smooth edges
    W = 512 * S
    img = Image.new("RGBA", (W, W), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    c = W / 2
    d.ellipse((8 * S, 8 * S, W - 8 * S, W - 8 * S), fill=(235, 240, 245, 255))                # rim
    d.ellipse((30 * S, 30 * S, W - 30 * S, W - 30 * S), fill=(18, 26, 40, 255))              # badge

    def rr(box, r, **kw):
        d.rounded_rectangle(tuple(v * S for v in box), radius=r * S, **kw)

    glass, edge = (200, 225, 240, 255), (240, 250, 255, 255)
    rr((176, 196, 336, 452), 34, fill=glass, outline=edge, width=5 * S)                         # body
    d.polygon([(c - 80 * S, 230 * S), (c - 26 * S, 150 * S), (c + 26 * S, 150 * S), (c + 80 * S, 230 * S)], fill=glass)  # shoulders
    rr((230, 96, 282, 176), 10, fill=glass, outline=edge, width=4 * S)                          # neck
    rr((224, 62, 288, 108), 8, fill=(170, 176, 186, 255), outline=(225, 230, 238, 255), width=3 * S)  # cap
    for y in (74, 86, 98):
        d.line((228 * S, y * S, 284 * S, y * S), fill=(130, 136, 146, 255), width=2 * S)
    d.rectangle((196 * S, 202 * S, 208 * S, 440 * S), fill=(255, 255, 255, 120))              # glass highlight
    rr((186, 272, 326, 392), 6, fill=(250, 250, 250, 255), outline=(200, 30, 36, 255), width=4 * S)  # label
    d.rectangle((186 * S, 282 * S, 326 * S, 292 * S), fill=(200, 30, 36, 255))
    font = bold(46 * S)
    l, t, r, b = d.textbbox((0, 0), "VODKA", font=font)
    d.text((c - (r - l) / 2 - l, 336 * S - (b - t) / 2 - t), "VODKA", font=font, fill=(200, 30, 36, 255))
    img = img.resize((512, 512), Image.LANCZOS)
    ICON.parent.mkdir(parents=True, exist_ok=True)
    img.save(ICON)
    return img


def build_images():
    IMG.mkdir(parents=True, exist_ok=True)
    (IMG / "_shaders").mkdir(exist_ok=True)

    base_c = Image.open(SRC_IMG / "log_pm_devrawdew_base_c.png").convert("RGB")
    mask = sign_mask(np.array(base_c).astype(float))
    base_c = erase_letters(base_c)
    arr = np.array(base_c).astype(float)
    arr[~mask] = whitewash(arr[~mask])
    arr[mask] = plaque(arr[mask])
    base_c = letter(Image.fromarray(np.uint8(np.clip(arr, 0, 255))), "VODKA", (250, 250, 250))
    base_c.save(IMG / "vodka_machine_base_c.png")

    base_e = Image.open(SRC_IMG / "log_pm_devrawdew_base_e.png").convert("RGB")
    arr = np.array(base_e).astype(float)
    lum = arr[..., 0] * 0.299 + arr[..., 1] * 0.587 + arr[..., 2] * 0.114
    arr = np.stack([lum, lum, lum], axis=-1)       # glow turns white
    arr[mask] = 0                                  # the plaque doesn't glow ...
    base_e = letter(Image.fromarray(np.uint8(np.clip(arr, 0, 255))), "VODKA", (255, 255, 255))   # ... its letters do
    base_e.save(IMG / "vodka_machine_base_e.png")

    alt = np.array(Image.open(SRC_IMG / "log_pm_devrawdew_alt_c.png").convert("RGBA")).astype(float)
    alt[..., :3] = whitewash(alt[..., :3])
    Image.fromarray(np.uint8(np.clip(alt, 0, 255)), "RGBA").save(IMG / "vodka_machine_alt_c.png")

    for part in ("base", "alt"):                   # normal/gloss/occlusion/spec: unchanged copies under our names
        for ch in ("n", "g", "o", "s"):
            shutil.copyfile(SRC_IMG / f"log_pm_devrawdew_{part}_{ch}.png", IMG / f"vodka_machine_{part}_{ch}.png")

    icon = draw_icon()
    icon.save(IMG / "vodka_paper.png")                        # bottle label
    icon.save(IMG / "_shaders" / "vodka_shader_bo3.png")      # HUD perk icon


def white_tint(value):
    parts = value.split()
    r, g, b = (float(x) for x in parts[:3])
    v, lo = max(r, g, b), min(r, g, b)
    if v == 0 or (v - lo) / v < 0.3:              # greys stay grey
        return value
    return " ".join(f"{c:.6g}" for c in (v * 0.92, v * 0.96, v)) + (" " + parts[3] if len(parts) > 3 else "")


def build_gdt():
    src = (DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "logical_perks_devrawdew.gdt").read_text(encoding="utf-8")
    src = re.sub(r'\t"logical_pm_devrawdew_hat" \( "xmodel\.gdf" \)\n\t\{\n.*?\n\t\}\n', "", src, flags=re.S)   # the hat isn't needed
    s = src
    for a, b in (("logical_pm_devrawdew_on", "vodka_machine_on"), ("logical_pm_devrawdew_off", "vodka_machine_off"),
                 ("log_pm_devrawdew_", "vodka_machine_"), ("_logical/_perks/devrawdew", "_zm_parkour_nothing0/vodka"),
                 ("_logical\\\\_perks\\\\devrawdew", "_zm_parkour_nothing0\\\\vodka"), ("devrawdew", "vodka"),
                 ('"displayName" "DEVRAW DEW"', '"displayName" "VODKA"')):
        s = s.replace(a, b)
    # the model file still names DEVRAW's materials internally: swap them for ours
    def override(name, base_mat):
        pat = re.compile(rf'(\t"{name}" \( "xmodel\.gdf" \)\n\t\{{\n.*?\n\t\}})', re.S)
        body = pat.search(s).group(1)
        new = f'\t\t"skinOverride" "log_pm_devrawdew_base {base_mat}\\r\\nlog_pm_devrawdew_alt vodka_machine_alt\\r\\n"'
        if '"skinOverride"' in body:
            body2 = re.sub(r'\t\t"skinOverride" "[^"]*"', new.replace("\\", "\\\\"), body)
        else:
            body2 = body.replace('\t\t"type" "rigid"', new + '\n\t\t"type" "rigid"')
        return s.replace(body, body2)
    s = override("vodka_machine_on", "vodka_machine_base")
    s = override("vodka_machine_off", "vodka_machine_base_off")
    s = re.sub(r'"((?:spec)?[cC]olorTint\d?)" "([^"]+)"', lambda m: f'"{m.group(1)}" "{white_tint(m.group(2))}"', s)
    assert "devrawdew" not in s.replace("log_pm_devrawdew_base", "").replace("log_pm_devrawdew_alt", "")
    (OUT / "vodka_perk.gdt").write_text(s, encoding="utf-8", newline="")
    shutil.copyfile(DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "log_pm_devrawdew_fb.xmodel_bin",
                    OUT / "vodka_machine_fb.xmodel_bin")


def build_bottle_base():
    """The tutorial's 'drag into root' BO4 bottle, if it isn't installed yet."""
    dst = BO3 / "model_export" / "_black_ops_4" / "_bo4_perk_bottles"
    if not dst.exists():
        shutil.copytree(CYO / "DRAG INTO ROOT" / "model_export" / "_black_ops_4" / "_bo4_perk_bottles", dst)


def build_fx():
    s = (DEVRAW / "share" / "raw" / "fx" / "_logical" / "perks" / "devrawdew" / "devrawdew.efx").read_text(encoding="utf-8").replace("\r\n", "\n")

    def knot(m):
        t, r, g, b = (float(x) for x in m.group(2).split())
        v = max(r, g, b)
        return f"{m.group(1)}{t:g} {v * 0.92:g} {v * 0.96:g} {v:g}"

    def graph(m):
        return re.sub(r"(\t+)(\S+ \S+ \S+ \S+)(?=\n)", knot, m.group(0))
    s = re.sub(r"\tcolorGraph [^\n]*\n\t\{\n.*?\n\t\};", graph, s, flags=re.S)
    s = re.sub(r"(\t\t\t_color )[^\n]*", r"\g<1>0.92 0.96 1", s)
    out = BO3 / "share" / "raw" / "fx" / "zm_parkour_nothing0"
    out.mkdir(parents=True, exist_ok=True)
    (out / "vodka.efx").write_text(s, encoding="utf-8", newline="")


def build_sounds_strings_zone():
    for folder in (("share", "raw", "english", "localizedstrings"), ("share", "raw", "sound", "aliases"), ("share", "zone_source")):
        BO3.joinpath(*folder).mkdir(parents=True, exist_ok=True)
    snd = BO3 / "sound_assets" / "zm_parkour_nothing0" / "vodka"
    snd.mkdir(parents=True, exist_ok=True)
    for f in ("jingle.wav", "sting.wav"):          # DEVRAW Dew's for now: replace these two files to use your own
        shutil.copyfile(DEVRAW / "sound_assets" / "_logical" / "perks" / "devrawdew" / f, snd / f)
    aliases = (DEVRAW / "share" / "raw" / "sound" / "aliases" / "devrawdew_perk_sounds.csv").read_text(encoding="utf-8")
    aliases = aliases.replace("mus_perks_devrawdew_", "mus_perks_vodka_").replace(
        "_logical\\perks\\devrawdew\\", "zm_parkour_nothing0\\vodka\\").replace("DEVRAWDEW", "VODKA")
    # the jingle again as a 2D loop: a drunk player (3+ drinks) hears it in their head, louder with every drink
    rows = aliases.splitlines()
    header = rows[0].split(",")
    jingle = next(r for r in rows if r.startswith("mus_perks_vodka_jingle,")).split(",")
    jingle[0] = "mus_perks_vodka_jingle_lp"
    jingle[header.index("Looping")] = "looping"
    jingle[header.index("PanType")] = "2d"
    eol = "\r\n" if "\r\n" in aliases else "\n"
    aliases = aliases.rstrip("\r\n") + eol + ",".join(jingle) + eol
    (BO3 / "share" / "raw" / "sound" / "aliases" / "vodka_perk_sounds.csv").write_text(aliases, encoding="utf-8", newline="")

    # Placeholder hint (the user asked for one): edit the second line to put a Nikolai quote in
    (BO3 / "share" / "raw" / "english" / "localizedstrings" / "vodka_perk.str").write_text(
        'VERSION             "1"\r\nCONFIG              "C:\\projects\\cod\\t7\\bin\\StringEd.cfg"\r\nFILENOTES           ""\r\n\r\n'
        'REFERENCE           VODKA_STRING\r\n'
        'LANG_ENGLISH     \t"Hold ^3[{+activate}]^7 for Vodka [^2+$&&1^7, +15% per Vodka drunk]\\n^7Drink up, comrade."\r\n\r\n'
        'ENDMARKER\r\n', encoding="utf-8", newline="")

    (BO3 / "share" / "zone_source" / "vodka_perk.zpkg").write_text(
        "// LOCALIZED STRINGS\r\nlocalize,vodka_perk\r\n\r\n"
        "// VODKA PERK\r\n"
        "scriptparsetree,scripts/zm/_zm_perk_vodka.gsc\r\n"
        "scriptparsetree,scripts/zm/_zm_perk_vodka.csc\r\n\r\n"
        "image,perk_shader_vodka\t\t\t\t\t// HUD perk icon\r\n"
        "fx,zm_parkour_nothing0/vodka\t\t\t\t// machine glow\r\n"
        "xmodel,vodka_machine_on\t\t\t\t\t// machine, power on\r\n"
        "xmodel,vodka_machine_off\t\t\t\t// machine, power off\r\n"
        "weapon,zombie_perk_bottle_vodka\t\t\t// perk bottle\r\n"
        + "".join(f"material,vodka_vignette_{n}\t\t\t// drunk tunnel vision, {n} drinks\r\n" for n in VIGNETTE_RADII),
        encoding="utf-8", newline="")


VIGNETTE_RADII = {5: 0.40, 6: 0.34, 7: 0.29, 8: 0.25, 9: 0.21, 10: 0.18}   # clear circle radius, fraction of screen width
GDT = BO3 / "source_data" / "zm_parkour_nothing0.gdt"


def build_vignettes():
    """Drunk tunnel vision, drinks 5..10: black with a soft clear circle in the middle. 16:9 so it's round on a
    16:9 screen (the HUD element is stretched fullscreen). Images + 2d_blend materials (cloned from mule_lick_icon)
    go into source_data/zm_parkour_nothing0.gdt; rerunning replaces them."""
    W, H = 1024, 576
    yy, xx = np.mgrid[0:H, 0:W].astype(float)
    dist = np.hypot(xx - (W - 1) / 2, yy - (H - 1) / 2) / W        # in screen widths
    tex = BO3 / "texture_assets" / "zm_parkour_nothing0"
    tex.mkdir(parents=True, exist_ok=True)

    gdt = GDT.open(encoding="utf-8", newline="").read()        # keep its CRLF line endings
    nl = "\r\n" if "\r\n" in gdt else "\n"
    gdt = gdt.replace("\r\n", "\n")

    def block(name, kind):
        return re.search(rf'(?ms)^\t"{name}" \( "{kind}" \)\n\t\{{\n.*?^\t\}}\n', gdt)

    img_tpl, mat_tpl = block("i_mule_lick_icon", "image.gdf").group(0), block("mule_lick_icon", "material.gdf").group(0)
    add = ""
    for n, r in VIGNETTE_RADII.items():
        feather = max(0.04, r * 0.35)
        t = np.clip((dist - r) / feather, 0, 1)
        alpha = t * t * (3 - 2 * t)                                   # smoothstep: clear inside r, black past r + feather
        rgba = np.zeros((H, W, 4), np.uint8)
        rgba[..., 3] = np.uint8(np.round(alpha * 255))
        Image.fromarray(rgba, "RGBA").save(tex / f"vodka_vignette_{n}.tif", compression="tiff_lzw")

        for name, kind in ((f"i_vodka_vignette_{n}", "image.gdf"), (f"vodka_vignette_{n}", "material.gdf")):
            old = block(name, kind)
            if old:
                gdt = gdt.replace(old.group(0), "")
        img = img_tpl.replace('"i_mule_lick_icon"', f'"i_vodka_vignette_{n}"').replace("mule_lick_icon.tif", f"vodka_vignette_{n}.tif")
        mat = mat_tpl.replace('"mule_lick_icon"', f'"vodka_vignette_{n}"').replace('"i_mule_lick_icon"', f'"i_vodka_vignette_{n}"')
        add += img + mat
    end = gdt.rstrip().rfind("}")
    gdt = gdt[:end] + add + gdt[end:]
    GDT.write_text(gdt.replace("\n", nl), encoding="utf-8", newline="")


if __name__ == "__main__":
    build_bottle_base()
    build_images()
    build_gdt()
    build_fx()
    build_sounds_strings_zone()
    build_vignettes()
    print("Vodka assets built in", OUT)
