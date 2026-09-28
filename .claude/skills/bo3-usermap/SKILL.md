---
name: bo3-usermap
description: Layout, conventions and known recipes for BO3 custom zombies maps in this usermaps repo. Read before implementing any <map>/ai/*.md design.
---

# BO3 usermaps — quick reference

## Layout
- Each top-level folder is a map (e.g. `zm_parkour_nothing0`). Work on one at a time.
- Designs: `<map>/ai/<n>.md`. Stamp top with time (`September 27 2026 9:41pm`), ask Q/A first, append `# Q/A` / `# Corrections` at bottom.
- Main script: `<map>/scripts/zm/<map>.gsc` (client: `.csc`). `function main()` calls `zm_usermap::main()` first; add map logic after it.
- `zone/`, `zone_source/`, `sound/` are build outputs — don't edit. No build/test is run from here; the user compiles in Mod Tools.

## Already imported in the stock map gsc
`zombie_utility` (`scripts\shared\ai\zombie_utility`), `flag_shared`, `util_shared`, `_zm_utility`, `_zm_zonemgr`, perks/powerups. Check the `#using` list before adding one.

## Recipes
### Endless round (implemented in zm_parkour_nothing0, design 0.md)
In `main()` after `zm_usermap::main()`:
```
zombie_utility::set_zombie_var( "zombie_spawn_delay", 2.0, true );   // base spawn delay (float)
zombie_utility::set_zombie_var( "zombie_between_round_time", 10 );
level thread endless_spawning();
```
`endless_spawning()` loops `wait 15; level.zombie_total = 115;`.
- The refill stops the stock round from ever ending, so the round number stays at 1. Correction: `endless_round_advance()` counts new spawns through `spawner::add_archetype_spawn_function( "zombie", fn )` (needs `#using scripts\shared\spawner_shared;`). Respawns are excluded by subtracting the growth of `level.zombie_total_subtract`, which stock bumps on every re-queue except `zombie_faller_delete` in `_zm_ai_faller.gsc`. Once new spawns reach 1.5× `zm::get_zombie_count_for_round( level.round_number, level.players.size )`, rounded up with `Int( ( n * 3 + 1 ) / 2 )`, `endless_next_round()` makes the stock `round_think` updates in place: move speed, `zm::set_round_number`, `SetRoundsPlayed`, `level.func_get_zombie_spawn_delay`, `zombie_utility::ai_calculate_health`.
- Spawn delay: the stock `get_zombie_spawn_delay` uses a base that depends on player count (2.0/1.5/0.89/0.67). It overrides `zombie_spawn_delay` from round 2 on. To keep the 2.0 base, set `level.func_get_zombie_spawn_delay = &endless_get_zombie_spawn_delay;` in `main()` after `zm_usermap::main()`. Stock `zm::init()` assigns it during that call. The replacement is 2.0 × 0.95^(round-1), min 0.1, with the round capped at 60.
- Speed ramp: `zombie_move_speed_multiplier` set to 10 (stock 4; easy stays 2). `level.zombie_move_speed = round * mult`, and each zombie rolls [speed, speed+35]: <=35 walk, <=70 run, else sprint. `endless_update_move_speed()` uses the NEW round number (stock uses the one that ended) and is also called in `main()` because round 1 speed is set during `zm::init()`.
- Grenade refill: stock gives it at round start with `zm::award_grenades_for_survivors()` (_zm.gsc ~4564; +2 lethals, max 4, skipped if in last stand or `level.headshots_only`). `endless_next_round()` calls it.
- Stock round source to check: `share/raw/scripts/zm/_zm.gsc` (`round_think` ~4335, `round_spawning` ~3678).
- `set_zombie_var( zvar, value, is_float, column, is_team_based )` — `column` defaults internally; omit it.
- Long loops must be threaded (`level thread fn();`) so `main()` doesn't block.

## Lights (checked against docs_modtools/Lighting_Parameters.pdf, FX_Lights.pdf, bo3_scriptapifunctions.htm)
- WARNING: bo3_scriptapifunctions.htm lists functions that do NOT exist in BO3. `GetLightIntensity` failed at load with "Unresolved external". No stock script uses any Get/SetLight* function, so treat them all as unverified. Prefer functions that stock scripts in share/raw/scripts use. The game exe stores function names as hashes, so grepping binaries doesn't help.
- A Radiant light entity has NO exploder field. Options for toggling one:
  - `PRIMARY_SCRIPTABLE` (Lighting Type) plus a targetname exposes the light to `GetEnt`, but the Get/SetLight* functions are unverified (see above).
  - Lighting states (up to 4 per map; toggles on each light) are switched with `level util::set_lighting_state( n )`. The usermap starts in state 1 (`zm_usermap.gsc:110`). Lights meant to be always on must be ticked in every state used.
  - Exploders only hold FX lights (an .efx with a Dynamic Light element): Exploder Manager, then RMB "Create New Exploder from selection".
- SCRIPT LIGHTING STATES ARE 0-BASED: `set_lighting_state( 0 )` = Radiant lighting state 1 and `( 1 )` = Radiant state 2 (see zm_giant.gsc:571, which uses 0). The usermap starts in script 1, which is Radiant state 2. Script 2 (Radiant 3) turned lights off, probably because that state wasn't baked, so stick to Radiant states 1 and 2.
- Implemented in zm_parkour_nothing0 (design 1.md): in Radiant, `main_light` has lightingstate1 = 1 and lightingstate2 = 0. `power_light()` waits for `level flag::wait_till( "power_on" )` and then calls `level util::set_lighting_state( 0 )`. Every other light in the .map already has lightingstate1-4 = 1.
- To check Radiant edits, grep `map_source/zm/<map>.map` for the KVPs (`"targetname"`, `"lightingstate1"`...). The user must save the map before compiling.
- Candle flicker (design 2.md): the flicker rate is the cookie's `def_scroll "x y"` (seconds per full travel; smaller = faster, negative = reversed; candles use `def_tile "0.001 0.001"` on `cookie_flicker02`). This is baked, not scriptable. The tool is `uv run zm_parkour_nothing0/tools/randomize_candle_flicker.py`, run from usermaps. It re-rolls every light whose `def` contains "flicker" and that isn't `"scriptable" "1"`, using x ±0.07–0.22 and y ±0.002–0.02. It adds def_scroll when missing, keeps line endings and writes `<map>.map.pre_flicker.bak`. Radiant must be closed (check with `Get-Process *radiant*`). Each candle also has a `gobo_smoke_01` light, which the tool leaves alone.
- Map source layout: `// entity N` header, then `{`, then `"key" "value"` lines, then `}`. Worldspawn (entity 0) holds `// brush` blocks.
- FX (design 3.md): the effects live in `share/raw/fx/**.efx` (text, `iwfx 3`). There are 825 stock effects to copy formats from. A Radiant-placed fx entity (`"classname" "fx"`, `"fxdef" "<path without .efx>"`) is packaged automatically; check for `fx,<name>` in `zone_source/all/assetlist/<map>.csv`. Each element is a `{ }` block whose type is the last keyword: `billboardSprite`, `line`, `tail`, `model`, `dynamicLight`/`dynamicLight2` (the light, e.g. template `"gfx_dlight_gen_omni"`), `runner` (spawns another effect: `runner { "electric/fx_..." };`). "a b" pairs appear to be base + random, e.g. `lifeSpanMsec 180 80`. Stock randomizes loop timing with `spawnDelayMsec 0 N` on a looping runner. The default "New effect" is an empty `billboardSprite { };`, which renders nothing.
- FX light brightness: `lightIntensityGraph <scale>` is linear, and intensity = 2^stops (Treyarch's `fx_light_zm_fire_*` match exactly: 7.97 stops → 251). `lightRadiusGraph <scale>` is in world units. The graph curves (0–1) multiply the scale. The template KVPs (`stops`, `radius`) inside `dynamicLight2` are overridden by the graphs, per FX_Lights.pdf. For a big radius, also raise the element's `spawnFrustumCullRadius` and the header's `efBoundingBoxMin/Max`, or the light pops off when its origin leaves the screen. Stock effects can't be changed per instance, so copy one to a new .efx to change it.
- `electrical_spark.efx` is a looping runner (`spawnLooping 1500 2500`, `spawnLoopingSpawnCount 2 2`, `spawnDelayMsec 0 400`, `lifeSpanMsec 2000 0`) of `electrical_spark_burst.efx`, a copy of the stock `electric/fx_elec_sparks_burst_xsm_omni_blue_os` whose `light_blue` is changed to intensity 2 (1 stop), radius 500, cull radius 500 and a ±500 bbox. The burst has a blue dynamicLight2, sparks, sound and smoke. The backup is `electrical_spark.efx.bak`. `fx/electric/` holds stock spark effects, including orange `_orange_os` variants.
- Stock power sets `level flag "power_on"` (`_zm_power.gsc` `turn_power_on_and_open_doors`) and doesn't touch lights.
- API docs: `docs_modtools/bo3_scriptapifunctions.htm`. Strip the tags with sed and grep it.

## Style
Tabs, Allman braces, `//` comments, spaces inside parens for calls.
