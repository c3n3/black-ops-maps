"""Design 11: build the Mule Lick perk's assets from the DEVRAW Dew machine and the CYO perk template.

- machine: DEVRAW Dew's model reused through skinOverride, textures colour-filtered dark red, the machine's
  "DEVRAW" sign re-lettered "MULE LICK" (the sign itself is the logo and is left un-filtered)
- bottle: the template's BO4 bottle, tints shifted to dark red, our Mule Lick icon on the label
- HUD shader, machine FX (red), sounds (DEVRAW Dew's for now), localized string, zone package

Run from anywhere:  uv run --with pillow --with numpy build_mule_lick_assets.py
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
ICON = MAP / "images" / "mule_lick_icon.png"

OUT = BO3 / "model_export" / "_zm_parkour_nothing0" / "mulelick"
IMG = OUT / "_images"
SRC_IMG = DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "_images"
SIGN_TEXT_BOX = (1585, 1992, 1855, 2037)          # "DEVRAW" on the machine's base textures (2048x2048)
SIGN_AREA = (1500, 1850, 1950, 2048)


def dark_red(rgb):
    """Colour filter: keep each pixel's luminance, make it dark red."""
    lum = rgb[..., 0] * 0.299 + rgb[..., 1] * 0.587 + rgb[..., 2] * 0.114
    return np.stack([lum * 0.85, lum * 0.07, lum * 0.06], axis=-1)


def sign_mask(color_rgb):
    """The cream sign on the base colour map, including its ragged darker edge (left un-filtered: it's the logo)."""
    x0, y0, x1, y1 = SIGN_AREA
    reg = color_rgb[y0:y1, x0:x1]
    cream = (reg.mean(axis=2) > 60) & (reg[..., 0] > reg[..., 2] + 3)
    grow = Image.fromarray(np.uint8(cream) * 255).filter(ImageFilter.MaxFilter(15)).filter(ImageFilter.MinFilter(9))
    m = np.zeros(color_rgb.shape[:2], bool)
    m[y0:y1, x0:x1] = np.array(grow) > 0
    tx0, ty0, tx1, ty1 = SIGN_TEXT_BOX
    m[ty0 - 4:ty1 + 4, tx0 - 4:tx1 + 4] = True     # the lettering sits inside the sign
    return m


def reletter(img, ink):
    """Paint out "DEVRAW" (only its letter strokes, filled from a blur of the sign around them), then write "MULE LICK"."""
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
    d = ImageDraw.Draw(img)
    size = 60
    while True:
        font = ImageFont.truetype(r"C:/Windows/Fonts/bahnschrift.ttf", size)
        try:
            font.set_variation_by_name("Bold")
        except Exception:
            pass
        l, t, r, b = d.textbbox((0, 0), "MULE LICK", font=font)
        if r - l <= (x1 - x0) and b - t <= (y1 - y0) or size <= 10:
            break
        size -= 1
    d.text((x0 + ((x1 - x0) - (r - l)) / 2 - l, y0 + ((y1 - y0) - (b - t)) / 2 - t), "MULE LICK", font=font, fill=ink)
    return img


def build_images():
    IMG.mkdir(parents=True, exist_ok=True)
    (IMG / "_shaders").mkdir(exist_ok=True)

    base_c = Image.open(SRC_IMG / "log_pm_devrawdew_base_c.png").convert("RGB")
    mask = sign_mask(np.array(base_c).astype(float))
    base_c = reletter(base_c, (12, 10, 8))
    arr = np.array(base_c).astype(float)
    arr[~mask] = dark_red(arr[~mask])
    Image.fromarray(np.uint8(np.clip(arr, 0, 255))).save(IMG / "mulelick_machine_base_c.png")

    base_e = Image.open(SRC_IMG / "log_pm_devrawdew_base_e.png").convert("RGB")
    base_e = reletter(base_e, (0, 0, 0))
    arr = np.array(base_e).astype(float)
    arr[~mask] = dark_red(arr[~mask])
    Image.fromarray(np.uint8(np.clip(arr, 0, 255))).save(IMG / "mulelick_machine_base_e.png")

    alt = np.array(Image.open(SRC_IMG / "log_pm_devrawdew_alt_c.png").convert("RGBA")).astype(float)
    alt[..., :3] = dark_red(alt[..., :3])
    Image.fromarray(np.uint8(np.clip(alt, 0, 255)), "RGBA").save(IMG / "mulelick_machine_alt_c.png")

    for part in ("base", "alt"):                   # normal/gloss/occlusion/spec: unchanged copies under our names
        for ch in ("n", "g", "o", "s"):
            shutil.copyfile(SRC_IMG / f"log_pm_devrawdew_{part}_{ch}.png", IMG / f"mulelick_machine_{part}_{ch}.png")

    icon = Image.open(ICON).convert("RGBA").resize((512, 512), Image.LANCZOS)
    icon.save(IMG / "mulelick_paper.png")                       # bottle label
    icon.save(IMG / "_shaders" / "mulelick_shader_bo3.png")     # HUD perk icon


def red_tint(value):
    parts = value.split()
    r, g, b = (float(x) for x in parts[:3])
    v, lo = max(r, g, b), min(r, g, b)
    if v == 0 or (v - lo) / v < 0.3:              # greys stay grey
        return value
    return " ".join(f"{c:.6g}" for c in (v * 0.75, v * 0.06, v * 0.05)) + (" " + parts[3] if len(parts) > 3 else "")


def build_gdt():
    src = (DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "logical_perks_devrawdew.gdt").read_text(encoding="utf-8")
    src = re.sub(r'\t"logical_pm_devrawdew_hat" \( "xmodel\.gdf" \)\n\t\{\n.*?\n\t\}\n', "", src, flags=re.S)   # the hat isn't needed
    s = src
    for a, b in (("logical_pm_devrawdew_on", "mulelick_machine_on"), ("logical_pm_devrawdew_off", "mulelick_machine_off"),
                 ("log_pm_devrawdew_", "mulelick_machine_"), ("_logical/_perks/devrawdew", "_zm_parkour_nothing0/mulelick"),
                 ("_logical\\\\_perks\\\\devrawdew", "_zm_parkour_nothing0\\\\mulelick"), ("devrawdew", "mulelick"),
                 ('"displayName" "DEVRAW DEW"', '"displayName" "MULE LICK"')):
        s = s.replace(a, b)
    # the model file still names DEVRAW's materials internally: swap them for ours
    def override(name, base_mat):
        pat = re.compile(rf'(\t"{name}" \( "xmodel\.gdf" \)\n\t\{{\n.*?\n\t\}})', re.S)
        body = pat.search(s).group(1)
        new = f'\t\t"skinOverride" "log_pm_devrawdew_base {base_mat}\\r\\nlog_pm_devrawdew_alt mulelick_machine_alt\\r\\n"'
        if '"skinOverride"' in body:
            body2 = re.sub(r'\t\t"skinOverride" "[^"]*"', new.replace("\\", "\\\\"), body)
        else:
            body2 = body.replace('\t\t"type" "rigid"', new + '\n\t\t"type" "rigid"')
        return s.replace(body, body2)
    s = override("mulelick_machine_on", "mulelick_machine_base")
    s = override("mulelick_machine_off", "mulelick_machine_base_off")
    s = re.sub(r'"((?:spec)?[cC]olorTint\d?)" "([^"]+)"', lambda m: f'"{m.group(1)}" "{red_tint(m.group(2))}"', s)
    assert "devrawdew" not in s.replace("log_pm_devrawdew_base", "").replace("log_pm_devrawdew_alt", "")
    (OUT / "mulelick_perk.gdt").write_text(s, encoding="utf-8", newline="")
    shutil.copyfile(DEVRAW / "model_export" / "_logical" / "_perks" / "devrawdew" / "log_pm_devrawdew_fb.xmodel_bin",
                    OUT / "mulelick_machine_fb.xmodel_bin")


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
        return f"{m.group(1)}{t:g} {v:g} {v * 0.06:g} {v * 0.05:g}"

    def graph(m):
        return re.sub(r"(\t+)(\S+ \S+ \S+ \S+)(?=\n)", knot, m.group(0))
    s = re.sub(r"\tcolorGraph [^\n]*\n\t\{\n.*?\n\t\};", graph, s, flags=re.S)
    s = re.sub(r"(\t\t\t_color )[^\n]*", r"\g<1>1 0.06 0.05", s)
    out = BO3 / "share" / "raw" / "fx" / "zm_parkour_nothing0"
    out.mkdir(parents=True, exist_ok=True)
    (out / "mulelick.efx").write_text(s, encoding="utf-8", newline="")


def build_sounds_strings_zone():
    for folder in (("share", "raw", "english", "localizedstrings"), ("share", "raw", "sound", "aliases"), ("share", "zone_source")):
        BO3.joinpath(*folder).mkdir(parents=True, exist_ok=True)
    snd = BO3 / "sound_assets" / "zm_parkour_nothing0" / "mulelick"
    snd.mkdir(parents=True, exist_ok=True)
    for f in ("jingle.wav", "sting.wav"):          # DEVRAW Dew's for now: replace these two files to use your own
        shutil.copyfile(DEVRAW / "sound_assets" / "_logical" / "perks" / "devrawdew" / f, snd / f)
    aliases = (DEVRAW / "share" / "raw" / "sound" / "aliases" / "devrawdew_perk_sounds.csv").read_text(encoding="utf-8")
    aliases = aliases.replace("mus_perks_devrawdew_", "mus_perks_mulelick_").replace(
        "_logical\\perks\\devrawdew\\", "zm_parkour_nothing0\\mulelick\\").replace("DEVRAWDEW", "MULE LICK")
    (BO3 / "share" / "raw" / "sound" / "aliases" / "mulelick_perk_sounds.csv").write_text(aliases, encoding="utf-8", newline="")

    (BO3 / "share" / "raw" / "english" / "localizedstrings" / "mulelick_perk.str").write_text(
        'VERSION             "1"\r\nCONFIG              "C:\\projects\\cod\\t7\\bin\\StringEd.cfg"\r\nFILENOTES           ""\r\n\r\n'
        'REFERENCE           MULE_LICK_STRING\r\n'
        'LANG_ENGLISH     \t"Hold ^3[{+activate}]^7 for Mule Lick [Cost: &&1]\\n^1-1 gun slot. Your next perk is never lost."\r\n\r\n'
        'ENDMARKER\r\n', encoding="utf-8", newline="")

    (BO3 / "share" / "zone_source" / "mulelick_perk.zpkg").write_text(
        "// LOCALIZED STRINGS\r\nlocalize,mulelick_perk\r\n\r\n"
        "// MULE LICK PERK\r\n"
        "scriptparsetree,scripts/zm/_zm_perk_mule_lick.gsc\r\n"
        "scriptparsetree,scripts/zm/_zm_perk_mule_lick.csc\r\n\r\n"
        "image,perk_shader_mulelick\t\t\t\t// HUD perk icon\r\n"
        "fx,zm_parkour_nothing0/mulelick\t\t\t// machine glow\r\n"
        "xmodel,mulelick_machine_on\t\t\t\t// machine, power on\r\n"
        "xmodel,mulelick_machine_off\t\t\t\t// machine, power off\r\n"
        "weapon,zombie_perk_bottle_mulelick\t\t// perk bottle\r\n", encoding="utf-8", newline="")


if __name__ == "__main__":
    build_bottle_base()
    build_images()
    build_gdt()
    build_fx()
    build_sounds_strings_zone()
    print("Mule Lick assets built in", OUT)
