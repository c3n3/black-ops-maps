"""Randomize the cookie scroll (flicker rate) of every candle light in the map source.

A candle is a light entity whose cookie `def` contains "flicker" and that is not
scriptable ("scriptable" "1", e.g. main_light). Every run re-rolls every candle.

The flicker comes from `def_scroll "x y"`: the time in seconds for the cookie to
travel its full width / height (smaller = faster, negative = reversed). With the
tiny `def_tile` the candles use, the light samples a sliver of the cookie, so the
scroll speed is the flicker rate.

Close Radiant first (or reload the map afterwards), since saving in Radiant
overwrites the file.

    uv run zm_parkour_nothing0/tools/randomize_candle_flicker.py
"""

import random
import re
import shutil
from pathlib import Path

MAP_NAME = Path(__file__).resolve().parents[1].name
BO3_ROOT = Path(__file__).resolve().parents[3]
MAP_FILE = BO3_ROOT / "map_source" / "zm" / f"{MAP_NAME}.map"
BACKUP_FILE = MAP_FILE.with_name(MAP_FILE.name + ".pre_flicker.bak")

# Ranges around the hand-tuned candle values already in the map
SCROLL_X = (0.07, 0.22)
SCROLL_Y = (0.002, 0.02)

ENTITY_HEADER = re.compile(r"^// entity \d+[ \t]*\r?$", re.MULTILINE)
KVP = re.compile(r'^"([^"]+)" "([^"]*)"', re.MULTILINE)
DEF_SCROLL = re.compile(r'^"def_scroll" "[^"]*"', re.MULTILINE)
DEF = re.compile(r'^"def" "[^"]*"[^\n]*\n', re.MULTILINE)


def is_candle(kvps):
    return (
        kvps.get("classname") == "light"
        and "flicker" in kvps.get("def", "")
        and kvps.get("scriptable") != "1"
    )


def random_scroll():
    x = random.uniform(*SCROLL_X) * random.choice((1, -1))
    y = random.uniform(*SCROLL_Y) * random.choice((1, -1))
    return f"{x:.3f} {y:.3f}"


def randomize(entity):
    scroll = f'"def_scroll" "{random_scroll()}"'
    if DEF_SCROLL.search(entity):
        return DEF_SCROLL.sub(scroll, entity, count=1), scroll
    # No scroll yet: add it straight after the cookie def, keeping the file's line ending
    match = DEF.search(entity)
    eol = "\r\n" if match.group(0).endswith("\r\n") else "\n"
    return entity[: match.end()] + scroll + eol + entity[match.end() :], scroll


def main():
    # newline="" keeps the file's line endings untouched
    with open(MAP_FILE, encoding="utf-8", newline="") as f:
        text = f.read()

    # Split into [preamble, header, body, header, body, ...] so the file rejoins exactly
    parts = re.split(f"({ENTITY_HEADER.pattern})", text, flags=re.MULTILINE)
    changed = 0
    for i in range(2, len(parts), 2):
        kvps = dict(KVP.findall(parts[i]))
        if not is_candle(kvps):
            continue
        parts[i], scroll = randomize(parts[i])
        changed += 1
        print(f"{parts[i - 1].strip():<12} origin {kvps.get('origin', '?'):<18} {scroll}")

    if not changed:
        print("No candle lights found, map left unchanged")
        return

    shutil.copyfile(MAP_FILE, BACKUP_FILE)
    with open(MAP_FILE, "w", encoding="utf-8", newline="") as f:
        f.write("".join(parts))
    print(f"Randomized {changed} candle lights in {MAP_FILE}")
    print(f"Backup: {BACKUP_FILE}")


if __name__ == "__main__":
    main()
