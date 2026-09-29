#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\animation_shared; 
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\gametypes\_globallogic_score;

#using scripts\zm\_community_perk_collection;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_powerups.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_community_perk_collection.gsh;

//-----Lighting Fx-----
#precache ("fx", COMMON_MODEL_BUCKET_FX);

//Abnormal202
#precache ("fx", "west/perks/abnormal202_perk_cryo_light");
#precache ("fx", "west/perks/abnormal202_perk_wind_light");

//BetiroVal
#precache ("fx", "west/perks/betiroval_fx_perk_blazephase_light");
#precache ("fx", "west/perks/betiroval_fx_perk_slurpentine_light");
#precache ("fx", "west/perks/betiroval_fx_perk_timeslip_light");

//HarryBo21
#precache ("fx", "west/perks/harry_fx_perk_daiquiri_light");
#precache ("fx", "west/perks/harry_fx_perk_doubletap_light");
#precache ("fx", "west/perks/harry_fx_perk_electric_cherry_light");
#precache ("fx", "west/perks/harry_fx_perk_elemental_pop_light");
#precache ("fx", "west/perks/harry_fx_perk_juggernaut_light");
//#precache ("fx", "west/perks/harry_fx_perk_mule_kick_light");
#precache ("fx", "west/perks/harry_fx_perk_quick_revive_light");
#precache ("fx", "west/perks/harry_fx_perk_sleight_of_hand_light");
#precache ("fx", "west/perks/harry_fx_perk_stamin_up_light");
#precache ("fx", "west/perks/harry_fx_perk_tombstone_light");
#precache ("fx", "west/perks/harry_fx_perk_vulture_aid_light");
#precache ("fx", "west/perks/harry_fx_perk_widows_wine_light");

//Holofya
#precache ("fx", "west/perks/holofya_glitch_perk_light");

//Kaizokuroof
#precache ("fx", "west/perks/kaizokuroof_fx_perk_atomic_liqueur_light");

//Khel Mho
#precache ("fx", "west/perks/km_fx_perk_vigor_rush_zmb");

//Logical
#precache ("fx", "west/perks/logical_double_dew");
#precache ("fx", "west/perks/logical_fighterfizz_light");
#precache ("fx", "west/perks/logical_icu_light");
#precache ("fx", "west/perks/logical_muscle_milk_light");
#precache ("fx", "west/perks/logical_tactiquilla_sangria_light");

//Mikey Ray
#precache ("fx", "west/perks/mikey_ray_phd_flopper_light");

//Sphynx
#precache ("fx", "west/perks/sphynx_fx_perk_death_perception_light");


//-----Gameplay Fx-----
#precache ("fx", BRAWLSTAR_PUNCH_BLOWBACK_FX);
#precache ("fx", BRAWLSTAR_PUNCH_HIT_FX);

#precache ("fx", BRIMSTONE_BRAMBLE_EXPLOSION_FX_FILE);

#precache ("fx", BULL_ICE_BLAST_SLAM_ICE_BREAK_FX);
#precache ("fx", BULL_ICE_BLAST_SLAM_ICE_IDLE_FX);
#precache ("fx", BULL_ICE_BLAST_SLAM_ICE_IMPACT_FX);

#precache ("material", DEATH_PERCEPTION_DANGER_ICON);
#precache ("material", DEATH_PERCEPTION_KEYLINE_MAT);

#precache ("fx", ELECTRIC_CHERRY_FX_EXPLODE_FILE);

#precache ("scriptbundle", 	"magnet_mule_machine_anims_fml");
#precache ("anim", 			"magnet_mule_anim_power_init_off");
#precache ("anim", 			"magnet_mule_anim_power_init");
#precache ("anim", 			"magnet_mule_anim_power_loop");
#using_animtree ( 			"magnet_mule");

#precache ("fx", MUSCLE_MILK_SHOCK_FX_FILE);

#precache ("fx", POWER_AID_PUNCH_HIT_LOC_FX);

#precache ("fx", TOMBSTONE_SODA_POWERUP_FX);
#precache ("fx", TOMBSTONE_SODA_POWERUP_GRAB_FX);
#precache ("model", TOMBSTONE_SODA_POWERUP_MODEL);


//-----Machine Models-----
#precache ("model", AMMO_AMERICANO_MACHINE_ACTIVE_MODEL);
#precache ("model", AMMO_AMERICANO_MACHINE_DISABLED_MODEL);
#precache ("model", ASTRO_ALE_MACHINE_ACTIVE_MODEL);
#precache ("model", ASTRO_ALE_MACHINE_DISABLED_MODEL);
#precache ("model", ATOMIC_LIQUEUR_MACHINE_ACTIVE_MODEL);
#precache ("model", ATOMIC_LIQUEUR_MACHINE_DISABLED_MODEL);
#precache ("model", BANANA_COLADA_MACHINE_ACTIVE_MODEL);
#precache ("model", BANANA_COLADA_MACHINE_DISABLED_MODEL);
#precache ("model", BANDOLIER_BANDIT_MACHINE_ACTIVE_MODEL);
#precache ("model", BANDOLIER_BANDIT_MACHINE_DISABLED_MODEL);
#precache ("model", BLAZE_PHASE_MACHINE_ACTIVE_MODEL);
#precache ("model", BLAZE_PHASE_MACHINE_DISABLED_MODEL);
#precache ("model", BLEEDING_MACHINE_ACTIVE_MODEL);
#precache ("model", BLEEDING_MACHINE_DISABLED_MODEL);
#precache ("model", BLOOD_WOLF_MACHINE_ACTIVE_MODEL);
#precache ("model", BLOOD_WOLF_MACHINE_DISABLED_MODEL);
#precache ("model", BRAWLSTAR_PUNCH_MACHINE_ACTIVE_MODEL);
#precache ("model", BRAWLSTAR_PUNCH_MACHINE_DISABLED_MODEL);
#precache ("model", BRIMSTONE_BRAMBLE_MACHINE_ACTIVE_MODEL);
#precache ("model", BRIMSTONE_BRAMBLE_MACHINE_DISABLED_MODEL);
#precache ("model", BULL_ICE_BLAST_MACHINE_ACTIVE_MODEL);
#precache ("model", BULL_ICE_BLAST_MACHINE_DISABLED_MODEL);
#precache ("model", CRACK_SHOT_MACHINE_ACTIVE_MODEL);
#precache ("model", CRACK_SHOT_MACHINE_DISABLED_MODEL);
#precache ("model", CRUSADERS_ALE_MACHINE_ACTIVE_MODEL);
#precache ("model", CRUSADERS_ALE_MACHINE_DISABLED_MODEL);
#precache ("model", CRYO_SLIDE_MACHINE_ACTIVE_MODEL);
#precache ("model", CRYO_SLIDE_MACHINE_DISABLED_MODEL);
#precache ("model", DEATH_PERCEPTION_MACHINE_ACTIVE_MODEL);
#precache ("model", DEATH_PERCEPTION_MACHINE_DISABLED_MODEL);
#precache ("model", DIVINE_ALE_MACHINE_ACTIVE_MODEL);
#precache ("model", DIVINE_ALE_MACHINE_DISABLED_MODEL);
#precache ("model", DOUBLE_DEW_MACHINE_ACTIVE_MODEL);
#precache ("model", DOUBLE_DEW_MACHINE_DISABLED_MODEL);
#precache ("model", DOUBLETAP1_MACHINE_ACTIVE_MODEL);
#precache ("model", DOUBLETAP1_MACHINE_DISABLED_MODEL);
#precache ("model", DOUBLETAP3_MACHINE_ACTIVE_MODEL);
#precache ("model", DOUBLETAP3_MACHINE_DISABLED_MODEL);
#precache ("model", DYING_WISH_MACHINE_ACTIVE_MODEL);
#precache ("model", DYING_WISH_MACHINE_DISABLED_MODEL);
#precache ("model", ELECTRIC_CHERRY_MACHINE_ACTIVE_MODEL);
#precache ("model", ELECTRIC_CHERRY_MACHINE_DISABLED_MODEL);
#precache ("model", ELEMENTAL_POP_MACHINE_ACTIVE_MODEL);
#precache ("model", ELEMENTAL_POP_MACHINE_DISABLED_MODEL);
#precache ("model", ETHEREAL_RAZOR_MACHINE_ACTIVE_MODEL);
#precache ("model", ETHEREAL_RAZOR_MACHINE_DISABLED_MODEL);
#precache ("model", FIGHTERS_FIZZ_MACHINE_ACTIVE_MODEL);
#precache ("model", FIGHTERS_FIZZ_MACHINE_DISABLED_MODEL);
#precache ("model", GAMBLERS_GIBSON_MACHINE_ACTIVE_MODEL);
#precache ("model", GAMBLERS_GIBSON_MACHINE_DISABLED_MODEL);
#precache ("model", GLITCHING_GIN_MACHINE_ACTIVE_MODEL);
#precache ("model", GLITCHING_GIN_MACHINE_DISABLED_MODEL);
#precache ("model", ICU_MACHINE_ACTIVE_MODEL);
#precache ("model", ICU_MACHINE_DISABLED_MODEL);
#precache ("model", MADGAZ_MOONSHINE_MACHINE_ACTIVE_MODEL);
#precache ("model", MADGAZ_MOONSHINE_MACHINE_DISABLED_MODEL);
#precache ("model", MAGNET_MACHINE_ACTIVE_MODEL);
#precache ("model", MAGNET_MACHINE_DISABLED_MODEL);
#precache ("model", MASOCHIST_MACHINE_ACTIVE_MODEL);
#precache ("model", MASOCHIST_MACHINE_DISABLED_MODEL);
#precache ("model", MEDUSAS_MAURESQUE_MACHINE_ACTIVE_MODEL);
#precache ("model", MEDUSAS_MAURESQUE_MACHINE_DISABLED_MODEL);
#precache ("model", MUSCLE_MILK_MACHINE_ACTIVE_MODEL);
#precache ("model", MUSCLE_MILK_MACHINE_DISABLED_MODEL);
#precache ("model", PHD_FLOPPER_MACHINE_ACTIVE_MODEL);
#precache ("model", PHD_FLOPPER_MACHINE_DISABLED_MODEL);
#precache ("model", PHD_SLIDER_MACHINE_ACTIVE_MODEL);
#precache ("model", PHD_SLIDER_MACHINE_DISABLED_MODEL);
#precache ("model", PICKPOCKET_PALOMA_MACHINE_ACTIVE_MODEL);
#precache ("model", PICKPOCKET_PALOMA_MACHINE_DISABLED_MODEL);
#precache ("model", POWER_AID_PUNCH_MACHINE_ACTIVE_MODEL);
#precache ("model", POWER_AID_PUNCH_MACHINE_DISABLED_MODEL);
#precache ("model", PRICKLING_PROSECCO_MACHINE_ACTIVE_MODEL);
#precache ("model", PRICKLING_PROSECCO_MACHINE_DISABLED_MODEL);
#precache ("model", ROULETTE_MACHINE_ACTIVE_MODEL);
#precache ("model", ROULETTE_MACHINE_DISABLED_MODEL);
#precache ("model", REBATE_ROSE_MACHINE_ACTIVE_MODEL);
#precache ("model", REBATE_ROSE_MACHINE_DISABLED_MODEL);
#precache ("model", SALVAGE_SHAKE_MACHINE_ACTIVE_MODEL);
#precache ("model", SALVAGE_SHAKE_MACHINE_DISABLED_MODEL);
#precache ("model", SAMURAIS_SPIRIT_MACHINE_ACTIVE_MODEL);
#precache ("model", SAMURAIS_SPIRIT_MACHINE_DISABLED_MODEL);
#precache ("model", SIDE_STEP_MACHINE_ACTIVE_MODEL);
#precache ("model", SIDE_STEP_MACHINE_DISABLED_MODEL);
#precache ("model", SLIP_AWAY_MACHINE_ACTIVE_MODEL);
#precache ("model", SLIP_AWAY_MACHINE_DISABLED_MODEL);
#precache ("model", SLURPENTINE_MACHINE_ACTIVE_MODEL);
#precache ("model", SLURPENTINE_MACHINE_DISABLED_MODEL);
#precache ("model", SLURPENTINE_MODEL_FLUID);
#precache ("model", SNAILS_PACE_MACHINE_ACTIVE_MODEL);
#precache ("model", SNAILS_PACE_MACHINE_DISABLED_MODEL);
#precache ("model", SPACE_CADET_MACHINE_ACTIVE_MODEL);
#precache ("model", SPACE_CADET_MACHINE_DISABLED_MODEL);
#precache ("model", SPECTRAL_SHAKE_MACHINE_ACTIVE_MODEL);
#precache ("model", SPECTRAL_SHAKE_MACHINE_DISABLED_MODEL);
#precache ("model", STONE_COLD_MACHINE_ACTIVE_MODEL);
#precache ("model", STONE_COLD_MACHINE_DISABLED_MODEL);
#precache ("model", TACTIQUILLA_MACHINE_ACTIVE_MODEL);
#precache ("model", TACTIQUILLA_MACHINE_DISABLED_MODEL);
#precache ("model", TIME_OUT_MACHINE_ACTIVE_MODEL);
#precache ("model", TIME_OUT_MACHINE_DISABLED_MODEL);
#precache ("model", TIMESLIP_MACHINE_ACTIVE_MODEL);
#precache ("model", TIMESLIP_MACHINE_DISABLED_MODEL);
#precache ("model", TOMBSTONE_SODA_MACHINE_ACTIVE_MODEL);
#precache ("model", TOMBSTONE_SODA_MACHINE_DISABLED_MODEL);
#precache ("model", VERRUCKT_JUG_MACHINE_ACTIVE_MODEL);
#precache ("model", VERRUCKT_JUG_MACHINE_DISABLED_MODEL);
#precache ("model", VICTORIOUS_TORTOISE_MACHINE_ACTIVE_MODEL);
#precache ("model", VICTORIOUS_TORTOISE_MACHINE_DISABLED_MODEL);
#precache ("model", VIGOR_RUSH_MACHINE_ACTIVE_MODEL);
#precache ("model", VIGOR_RUSH_MACHINE_DISABLED_MODEL);
#precache ("model", WALL_POWER_MACHINE_ACTIVE_MODEL);
#precache ("model", WALL_POWER_MACHINE_DISABLED_MODEL);
#precache ("model", WIDOWS_WINE_MACHINE_ACTIVE_MODEL);
#precache ("model", WIDOWS_WINE_MACHINE_DISABLED_MODEL);
#precache ("model", WINDRUNNER_MACHINE_ACTIVE_MODEL);
#precache ("model", WINDRUNNER_MACHINE_DISABLED_MODEL);
#precache ("model", WINTERS_WAIL_MACHINE_ACTIVE_MODEL);
#precache ("model", WINTERS_WAIL_MACHINE_DISABLED_MODEL);
#precache ("model", ZOMBSHELL_MACHINE_ACTIVE_MODEL);
#precache ("model", ZOMBSHELL_MACHINE_DISABLED_MODEL);


//-----Bucket Models-----
#precache ("model", AMMO_AMERICANO_MODEL_BUCKET);
#precache ("model", ASTRO_ALE_MODEL_BUCKET);
#precache ("model", ATOMIC_LIQUEUR_MODEL_BUCKET);
#precache ("model", BANANA_COLADA_MODEL_BUCKET);
#precache ("model", BANDOLIER_BANDIT_MODEL_BUCKET);
#precache ("model", BLAZE_PHASE_MODEL_BUCKET);
#precache ("model", BLEEDING_MODEL_BUCKET);
#precache ("model", BLOOD_WOLF_MODEL_BUCKET);
#precache ("model", BRAWLSTAR_PUNCH_MODEL_BUCKET);
#precache ("model", BRIMSTONE_BRAMBLE_MODEL_BUCKET);
#precache ("model", BULL_ICE_BLAST_MODEL_BUCKET);
#precache ("model", CRACK_SHOT_MODEL_BUCKET);
#precache ("model", CRUSADERS_ALE_MODEL_BUCKET);
#precache ("model", CRYO_SLIDE_MODEL_BUCKET);
#precache ("model", DEATH_PERCEPTION_MODEL_BUCKET);
#precache ("model", DIVINE_ALE_MODEL_BUCKET);
#precache ("model", DOUBLE_DEW_MODEL_BUCKET);
#precache ("model", DOUBLETAP1_MODEL_BUCKET);
#precache ("model", DOUBLETAP3_MODEL_BUCKET);
#precache ("model", DYING_WISH_MODEL_BUCKET);
#precache ("model", ELECTRIC_CHERRY_MODEL_BUCKET);
#precache ("model", ELEMENTAL_POP_MODEL_BUCKET);
#precache ("model", ETHEREAL_RAZOR_MODEL_BUCKET);
#precache ("model", FIGHTERS_FIZZ_MODEL_BUCKET);
#precache ("model", GAMBLERS_GIBSON_MODEL_BUCKET);
#precache ("model", GLITCHING_GIN_MODEL_BUCKET);
#precache ("model", ICU_MODEL_BUCKET);
#precache ("model", MADGAZ_MOONSHINE_MODEL_BUCKET);
#precache ("model", MAGNET_MODEL_BUCKET);
#precache ("model", MASOCHIST_MODEL_BUCKET);
#precache ("model", MEDUSAS_MAURESQUE_MODEL_BUCKET);
#precache ("model", MUSCLE_MILK_MODEL_BUCKET);
#precache ("model", PHD_FLOPPER_MODEL_BUCKET);
#precache ("model", PHD_SLIDER_MODEL_BUCKET);
#precache ("model", PICKPOCKET_PALOMA_MODEL_BUCKET);
#precache ("model", POWER_AID_PUNCH_MODEL_BUCKET);
#precache ("model", PRICKLING_PROSECCO_MODEL_BUCKET);
#precache ("model", ROULETTE_MODEL_BUCKET);
#precache ("model", REBATE_ROSE_MODEL_BUCKET);
#precache ("model", SALVAGE_SHAKE_MODEL_BUCKET);
#precache ("model", SAMURAIS_SPIRIT_MODEL_BUCKET);
#precache ("model", SIDE_STEP_MODEL_BUCKET);
#precache ("model", SLIP_AWAY_MODEL_BUCKET);
#precache ("model", SLURPENTINE_MODEL_BUCKET);
#precache ("model", SNAILS_PACE_MODEL_BUCKET);
#precache ("model", SPACE_CADET_MODEL_BUCKET);
#precache ("model", SPECTRAL_SHAKE_MODEL_BUCKET);
#precache ("model", STONE_COLD_MODEL_BUCKET);
#precache ("model", TACTIQUILLA_MODEL_BUCKET);
#precache ("model", TIME_OUT_MODEL_BUCKET);
#precache ("model", TIMESLIP_MODEL_BUCKET);
#precache ("model", TOMBSTONE_SODA_MODEL_BUCKET);
#precache ("model", VERRUCKT_JUG_MODEL_BUCKET);
#precache ("model", VICTORIOUS_TORTOISE_MODEL_BUCKET);
#precache ("model", VIGOR_RUSH_MODEL_BUCKET);
#precache ("model", WALL_POWER_MODEL_BUCKET);
#precache ("model", WIDOWS_WINE_MODEL_BUCKET);
#precache ("model", WINDRUNNER_MODEL_BUCKET);
#precache ("model", WINTERS_WAIL_MODEL_BUCKET);
#precache ("model", ZOMBSHELL_MODEL_BUCKET);


//-----Trig Strings-----
#precache ("triggerstring", AMMO_AMERICANO_TRIG_STRING, AMMO_AMERICANO_COST_STRING);
#precache ("triggerstring", ASTRO_ALE_TRIG_STRING, ASTRO_ALE_COST_STRING);
#precache ("triggerstring", ATOMIC_LIQUEUR_TRIG_STRING, ATOMIC_LIQUEUR_COST_STRING);
#precache ("triggerstring", BANANA_COLADA_TRIG_STRING, BANANA_COLADA_COST_STRING);
#precache ("triggerstring", BANDOLIER_BANDIT_TRIG_STRING, BANDOLIER_BANDIT_COST_STRING);
#precache ("triggerstring", BLAZE_PHASE_TRIG_STRING, BLAZE_PHASE_COST_STRING);
#precache ("triggerstring", BLEEDING_TRIG_STRING, BLEEDING_COST_STRING);
#precache ("triggerstring", BLOOD_WOLF_TRIG_STRING, BLOOD_WOLF_COST_STRING);
#precache ("triggerstring", BRAWLSTAR_PUNCH_TRIG_STRING, BRAWLSTAR_PUNCH_COST_STRING);
#precache ("triggerstring", BRIMSTONE_BRAMBLE_TRIG_STRING, BRIMSTONE_BRAMBLE_COST_STRING);
#precache ("triggerstring", BULL_ICE_BLAST_TRIG_STRING, BULL_ICE_BLAST_COST_STRING);
#precache ("triggerstring", CRACK_SHOT_TRIG_STRING, CRACK_SHOT_COST_STRING);
#precache ("triggerstring", CRUSADERS_ALE_TRIG_STRING, CRUSADERS_ALE_COST_STRING);
#precache ("triggerstring", CRYO_SLIDE_TRIG_STRING, CRYO_SLIDE_COST_STRING);
#precache ("triggerstring", DEATH_PERCEPTION_TRIG_STRING, DEATH_PERCEPTION_COST_STRING);
#precache ("triggerstring", DIVINE_ALE_TRIG_STRING, DIVINE_ALE_COST_STRING);
#precache ("triggerstring", DOUBLE_DEW_TRIG_STRING, DOUBLE_DEW_COST_STRING);
#precache ("triggerstring", DOUBLETAP1_TRIG_STRING, DOUBLETAP1_COST_STRING);
#precache ("triggerstring", DOUBLETAP3_TRIG_STRING, DOUBLETAP3_COST_STRING);
#precache ("triggerstring", DYING_WISH_TRIG_STRING, DYING_WISH_COST_STRING);
#precache ("triggerstring", ELECTRIC_CHERRY_TRIG_STRING, ELECTRIC_CHERRY_COST_STRING);
#precache ("triggerstring", ELEMENTAL_POP_TRIG_STRING, ELEMENTAL_POP_COST_STRING);
#precache ("triggerstring", ETHEREAL_RAZOR_TRIG_STRING, ETHEREAL_RAZOR_COST_STRING);
#precache ("triggerstring", FIGHTERS_FIZZ_TRIG_STRING, FIGHTERS_FIZZ_COST_STRING);
#precache ("triggerstring", GAMBLERS_GIBSON_TRIG_STRING, GAMBLERS_GIBSON_COST_STRING);
#precache ("triggerstring", GLITCHING_GIN_TRIG_STRING, GLITCHING_GIN_COST_STRING);
#precache ("triggerstring", ICU_TRIG_STRING, ICU_COST_STRING);
#precache ("triggerstring", MADGAZ_MOONSHINE_TRIG_STRING, MADGAZ_MOONSHINE_COST_STRING);
#precache ("triggerstring", MAGNET_TRIG_STRING, MAGNET_COST_STRING);
#precache ("triggerstring", MASOCHIST_TRIG_STRING, MASOCHIST_COST_STRING);
#precache ("triggerstring", MEDUSAS_MAURESQUE_TRIG_STRING, MEDUSAS_MAURESQUE_COST_STRING);
#precache ("triggerstring", MUSCLE_MILK_TRIG_STRING, MUSCLE_MILK_COST_STRING);
#precache ("triggerstring", PHD_FLOPPER_TRIG_STRING, PHD_FLOPPER_COST_STRING);
#precache ("triggerstring", PHD_SLIDER_TRIG_STRING, PHD_SLIDER_COST_STRING);
#precache ("triggerstring", PICKPOCKET_PALOMA_TRIG_STRING, PICKPOCKET_PALOMA_COST_STRING);
#precache ("triggerstring", POWER_AID_PUNCH_TRIG_STRING, POWER_AID_PUNCH_COST_STRING);
#precache ("triggerstring", PRICKLING_PROSECCO_TRIG_STRING, PRICKLING_PROSECCO_COST_STRING);
#precache ("triggerstring", ROULETTE_TRIG_STRING, ROULETTE_COST_STRING);
#precache ("triggerstring", REBATE_ROSE_TRIG_STRING, REBATE_ROSE_COST_STRING);
#precache ("triggerstring", SALVAGE_SHAKE_TRIG_STRING, SALVAGE_SHAKE_COST_STRING);
#precache ("triggerstring", SAMURAIS_SPIRIT_TRIG_STRING, SAMURAIS_SPIRIT_COST_STRING);
#precache ("triggerstring", SIDE_STEP_TRIG_STRING, SIDE_STEP_COST_STRING);
#precache ("triggerstring", SLIP_AWAY_TRIG_STRING, SLIP_AWAY_COST_STRING);
#precache ("triggerstring", SLURPENTINE_TRIG_STRING, SLURPENTINE_COST_STRING);
#precache ("triggerstring", SNAILS_PACE_TRIG_STRING, SNAILS_PACE_COST_STRING);
#precache ("triggerstring", SPACE_CADET_TRIG_STRING, SPACE_CADET_COST_STRING);
#precache ("triggerstring", SPECTRAL_SHAKE_TRIG_STRING, SPECTRAL_SHAKE_COST_STRING);
#precache ("triggerstring", STONE_COLD_TRIG_STRING, STONE_COLD_COST_STRING);
#precache ("triggerstring", TACTIQUILLA_TRIG_STRING, TACTIQUILLA_COST_STRING);
#precache ("triggerstring", TIME_OUT_TRIG_STRING, TIME_OUT_COST_STRING);
#precache ("triggerstring", TIMESLIP_TRIG_STRING, TIMESLIP_COST_STRING);
#precache ("triggerstring", TOMBSTONE_SODA_TRIG_STRING, TOMBSTONE_SODA_COST_STRING);
#precache ("triggerstring", VERRUCKT_JUG_TRIG_STRING, VERRUCKT_JUG_COST_STRING);
#precache ("triggerstring", VICTORIOUS_TORTOISE_TRIG_STRING, VICTORIOUS_TORTOISE_COST_STRING);
#precache ("triggerstring", VIGOR_RUSH_TRIG_STRING, VIGOR_RUSH_COST_STRING);
#precache ("triggerstring", WALL_POWER_TRIG_STRING, WALL_POWER_COST_STRING);
#precache ("triggerstring", WIDOWS_WINE_TRIG_STRING, WIDOWS_WINE_COST_STRING);
#precache ("triggerstring", WINDRUNNER_TRIG_STRING, WINDRUNNER_COST_STRING);
#precache ("triggerstring", WINTERS_WAIL_TRIG_STRING, WINTERS_WAIL_COST_STRING);
#precache ("triggerstring", ZOMBSHELL_TRIG_STRING, ZOMBSHELL_COST_STRING);

#namespace community_perk_collection;

REGISTER_SYSTEM("zm_community_perk_collection_setup", &setup_init, undefined)

// ======================================================================================================
// Setup
// ======================================================================================================

function setup_init()
{
	//SELF == LEVEL
	
	if (IsDefined (level.mod_force_enable_west_perk) && level.mod_force_enable_west_perk.size > 0)
	{
		level.west_melee_perks = [];
	
		foreach (perk_alias in level.mod_force_enable_west_perk)
		{
			if (perk_alias == AMMO_AMERICANO_ALIAS)
				enable_ammo_americano_for_level();
				
			else if (perk_alias == ASTRO_ALE_ALIAS)
				enable_astro_ale_for_level();
				
			else if (perk_alias == ATOMIC_LIQUEUR_ALIAS)
				enable_atomic_liqueur_for_level();
				
			else if (perk_alias == BANANA_COLADA_ALIAS)
				enable_banana_colada_for_level();
				
			else if (perk_alias == BANDOLIER_BANDIT_ALIAS)
				enable_bandolier_bandit_for_level();
				
			else if (perk_alias == BLAZE_PHASE_ALIAS)	
				enable_blaze_phase_for_level();
				
			else if (perk_alias == BLEEDING_ALIAS)	
				enable_bleeding_for_level();
				
			else if (perk_alias == BLOOD_WOLF_ALIAS)
				enable_blood_wolf_for_level();
				
			else if (perk_alias == BRAWLSTAR_PUNCH_ALIAS)
				enable_brawlstar_punch_for_level();
				
			else if (perk_alias == BRIMSTONE_BRAMBLE_ALIAS)
				enable_brimstone_bramble_for_level();
				
			else if (perk_alias == BULL_ICE_BLAST_ALIAS)
				enable_bull_ice_blast_for_level();
				
			else if (perk_alias == CRACK_SHOT_ALIAS)
				enable_crack_shot_for_level();
				
			else if (perk_alias == CRUSADERS_ALE_ALIAS)	
				enable_crusaders_ale_for_level();
				
			else if (perk_alias == CRYO_SLIDE_ALIAS)	
				enable_cryo_slide_for_level();
				
			else if (perk_alias == DEATH_PERCEPTION_ALIAS)
				enable_death_perception_for_level();
				
			else if (perk_alias == DIVINE_ALE_ALIAS)
				enable_divine_ale_for_level();
				
			else if (perk_alias == DOUBLE_DEW_ALIAS)
				enable_double_dew_for_level();
				
			else if (perk_alias == DOUBLETAP1_ALIAS)
				enable_doubletap1_for_level();
				
			else if (perk_alias == DOUBLETAP3_ALIAS)
				enable_doubletap3_for_level();
				
			else if (perk_alias == DYING_WISH_ALIAS)	
				enable_dying_wish_for_level();
				
			else if (perk_alias == ELECTRIC_CHERRY_ALIAS)
				enable_electric_cherry_for_level();
				
			else if (perk_alias == ELEMENTAL_POP_ALIAS)
				enable_elemental_pop_for_level();
				
			else if (perk_alias == ETHEREAL_RAZOR_ALIAS)
				enable_ethereal_razor_for_level();
				
			else if (perk_alias == FIGHTERS_FIZZ_ALIAS)	
				enable_fighters_fizz_for_level();
				
			else if (perk_alias == GAMBLERS_GIBSON_ALIAS)
				enable_gamblers_gibson_for_level();
				
			else if (perk_alias == GLITCHING_GIN_ALIAS)
				enable_glitching_gin_for_level();
				
			else if (perk_alias == ICU_ALIAS)	
				enable_icu_for_level();
				
			else if (perk_alias == MADGAZ_MOONSHINE_ALIAS)
				enable_madgaz_moonshine_for_level();
				
			else if (perk_alias == MAGNET_ALIAS)
				enable_magnet_for_level();
				
			else if (perk_alias == MASOCHIST_ALIAS)
				enable_masochist_for_level();
				
			else if (perk_alias == MEDUSAS_MAURESQUE_ALIAS)	
				enable_medusas_mauresque_for_level();
				
			else if (perk_alias == MUSCLE_MILK_ALIAS)
				enable_muscle_milk_for_level();
				
			else if (perk_alias == PHD_FLOPPER_ALIAS)
				enable_phd_flopper_for_level();
				
			else if (perk_alias == PHD_SLIDER_ALIAS)
				enable_phd_slider_for_level();
				
			else if (perk_alias == PICKPOCKET_PALOMA_ALIAS)
				enable_pickpocket_paloma_for_level();
				
			else if (perk_alias == POWER_AID_PUNCH_ALIAS)	
				enable_power_aid_punch_for_level();
				
			else if (perk_alias == PRICKLING_PROSECCO_ALIAS)
				enable_prickling_prosecco_for_level();
				
			else if (perk_alias == ROULETTE_ALIAS)
				enable_roulette_for_level();
				
			else if (perk_alias == REBATE_ROSE_ALIAS)
				enable_rebate_rose_for_level();
				
			else if (perk_alias == SALVAGE_SHAKE_ALIAS)
				enable_salvage_shake_for_level();
				
			else if (perk_alias == SAMURAIS_SPIRIT_ALIAS)
				enable_samurais_spirit_for_level();
				
			else if (perk_alias == SIDE_STEP_ALIAS)
				enable_side_step_for_level();
				
			else if (perk_alias == SLIP_AWAY_ALIAS)
				enable_slip_away_for_level();
				
			else if (perk_alias == SLURPENTINE_ALIAS)
				enable_slurpentine_for_level();
				
			else if (perk_alias == SNAILS_PACE_ALIAS)
				enable_snails_pace_for_level();
				
			else if (perk_alias == SPACE_CADET_ALIAS)
				enable_space_cadet_for_level();
				
			else if (perk_alias == SPECTRAL_SHAKE_ALIAS)
				enable_spectral_shake_for_level();
				
			else if (perk_alias == STONE_COLD_ALIAS)
				enable_stone_cold_for_level();
				
			else if (perk_alias == TACTIQUILLA_ALIAS)
				enable_tactiquilla_for_level();
				
			else if (perk_alias == TIME_OUT_ALIAS)
				enable_time_out_for_level();
				
			else if (perk_alias == TIMESLIP_ALIAS)
				enable_timeslip_for_level();
				
			else if (perk_alias == TOMBSTONE_SODA_ALIAS)
				enable_tombstone_soda_for_level();	
				
			else if (perk_alias == VERRUCKT_JUG_ALIAS)
				enable_verruckt_jug_for_level();
				
			else if (perk_alias == VICTORIOUS_TORTOISE_ALIAS)
				enable_victorious_tortoise_for_level();
				
			else if (perk_alias == VIGOR_RUSH_ALIAS)	
				enable_vigor_rush_for_level();
				
			else if (perk_alias == WALL_POWER_ALIAS)
				enable_wall_power_for_level();
				
			else if (perk_alias == WIDOWS_WINE_ALIAS)	
				enable_widows_wine_for_level();
				
			else if (perk_alias == WINDRUNNER_ALIAS)	
				enable_windrunner_for_level();
				
			else if (perk_alias == WINTERS_WAIL_ALIAS)
				enable_winters_wail_for_level();
				
			else if (perk_alias == WUNDERFIZZ_ALIAS)
				enable_wunderfizz_for_level();
				
			else if (perk_alias == ZOMBSHELL_ALIAS)
				enable_zombshell_for_level();
		}
	}
	
	else if (ENABLE_COMMUNITY_PERK_COLLECTION == 1)
	{
		level.west_melee_perks = [];
	
		if (AMMO_AMERICANO_LEVEL_USE_PERK == 1)
			enable_ammo_americano_for_level();
			
		if (ASTRO_ALE_LEVEL_USE_PERK == 1)
			enable_astro_ale_for_level();
			
		if (ATOMIC_LIQUEUR_LEVEL_USE_PERK == 1)
			enable_atomic_liqueur_for_level();
			
		if (BANANA_COLADA_LEVEL_USE_PERK == 1)
			enable_banana_colada_for_level();
			
		if (BANDOLIER_BANDIT_LEVEL_USE_PERK == 1)
			enable_bandolier_bandit_for_level();
			
		if (BLAZE_PHASE_LEVEL_USE_PERK == 1)	
			enable_blaze_phase_for_level();
			
		if (BLEEDING_LEVEL_USE_PERK == 1)	
			enable_bleeding_for_level();
			
		if (BLOOD_WOLF_LEVEL_USE_PERK == 1)
			enable_blood_wolf_for_level();
			
		if (BRAWLSTAR_PUNCH_LEVEL_USE_PERK == 1)
			enable_brawlstar_punch_for_level();
			
		if (BRIMSTONE_BRAMBLE_LEVEL_USE_PERK == 1)
			enable_brimstone_bramble_for_level();
			
		if (BULL_ICE_BLAST_LEVEL_USE_PERK == 1)		
			enable_bull_ice_blast_for_level();
			
		if (CRACK_SHOT_LEVEL_USE_PERK == 1)
			enable_crack_shot_for_level();
			
		if (CRUSADERS_ALE_LEVEL_USE_PERK == 1)
			enable_crusaders_ale_for_level();
			
		if (CRYO_SLIDE_LEVEL_USE_PERK == 1)
			enable_cryo_slide_for_level();
			
		if (DEATH_PERCEPTION_LEVEL_USE_PERK == 1)
			enable_death_perception_for_level();
			
		if (DIVINE_ALE_LEVEL_USE_PERK == 1)
			enable_divine_ale_for_level();
			
		if (DOUBLE_DEW_LEVEL_USE_PERK == 1)
			enable_double_dew_for_level();
			
		if (DOUBLETAP1_LEVEL_USE_PERK == 1)
			enable_doubletap1_for_level();
			
		if (DOUBLETAP3_LEVEL_USE_PERK == 1)
			enable_doubletap3_for_level();
			
		if (DYING_WISH_LEVEL_USE_PERK == 1)	
			enable_dying_wish_for_level();
			
		if (ELECTRIC_CHERRY_LEVEL_USE_PERK == 1)
			enable_electric_cherry_for_level();
		
		if (ELEMENTAL_POP_LEVEL_USE_PERK == 1)
			enable_elemental_pop_for_level();
			
		if (ETHEREAL_RAZOR_LEVEL_USE_PERK == 1)
			enable_ethereal_razor_for_level();
			
		if (FIGHTERS_FIZZ_LEVEL_USE_PERK == 1)
			enable_fighters_fizz_for_level();
			
		if (GAMBLERS_GIBSON_LEVEL_USE_PERK == 1)
			enable_gamblers_gibson_for_level();
			
		if (GLITCHING_GIN_LEVEL_USE_PERK == 1)
			enable_glitching_gin_for_level();
			
		if (ICU_LEVEL_USE_PERK == 1)
			enable_icu_for_level();
			
		if (MADGAZ_MOONSHINE_LEVEL_USE_PERK == 1)
			enable_madgaz_moonshine_for_level();
			
		if (MAGNET_LEVEL_USE_PERK == 1)
			enable_magnet_for_level();
			
		if (MASOCHIST_LEVEL_USE_PERK == 1)
			enable_masochist_for_level();
			
		if (MEDUSAS_MAURESQUE_LEVEL_USE_PERK == 1)
			enable_medusas_mauresque_for_level();
			
		if (MUSCLE_MILK_LEVEL_USE_PERK == 1)		
			enable_muscle_milk_for_level();
			
		if (PHD_FLOPPER_LEVEL_USE_PERK == 1)
			enable_phd_flopper_for_level();
			
		if (PHD_SLIDER_LEVEL_USE_PERK == 1)
			enable_phd_slider_for_level();
			
		if (PICKPOCKET_PALOMA_LEVEL_USE_PERK == 1)
			enable_pickpocket_paloma_for_level();
			
		if (POWER_AID_PUNCH_LEVEL_USE_PERK == 1)	
			enable_power_aid_punch_for_level();
			
		if (PRICKLING_PROSECCO_LEVEL_USE_PERK == 1)
			enable_prickling_prosecco_for_level();
			
		if (ROULETTE_LEVEL_USE_PERK == 1)
			enable_roulette_for_level();
			
		if (REBATE_ROSE_LEVEL_USE_PERK == 1)
			enable_rebate_rose_for_level();
			
		if (SALVAGE_SHAKE_LEVEL_USE_PERK == 1)
			enable_salvage_shake_for_level();
			
		if (SAMURAIS_SPIRIT_LEVEL_USE_PERK == 1)
			enable_samurais_spirit_for_level();
			
		if (SIDE_STEP_LEVEL_USE_PERK == 1)
			enable_side_step_for_level();
			
		if (SLIP_AWAY_LEVEL_USE_PERK == 1)
			enable_slip_away_for_level();
			
		if (SLURPENTINE_LEVEL_USE_PERK == 1)
			enable_slurpentine_for_level();
			
		if (SNAILS_PACE_LEVEL_USE_PERK == 1)
			enable_snails_pace_for_level();
			
		if (SPACE_CADET_LEVEL_USE_PERK == 1)
			enable_space_cadet_for_level();
			
		if (SPECTRAL_SHAKE_LEVEL_USE_PERK == 1)
			enable_spectral_shake_for_level();
			
		if (STONE_COLD_LEVEL_USE_PERK == 1)
			enable_stone_cold_for_level();
			
		if (TACTIQUILLA_LEVEL_USE_PERK == 1)	
			enable_tactiquilla_for_level();
			
		if (TIME_OUT_LEVEL_USE_PERK == 1)
			enable_time_out_for_level();
			
		if (TIMESLIP_LEVEL_USE_PERK == 1)
			enable_timeslip_for_level();
			
		if (TOMBSTONE_SODA_LEVEL_USE_PERK == 1)
			enable_tombstone_soda_for_level();	
			
		if (VERRUCKT_JUG_LEVEL_USE_PERK == 1)
			enable_verruckt_jug_for_level();
			
		if (VICTORIOUS_TORTOISE_LEVEL_USE_PERK == 1)
			enable_victorious_tortoise_for_level();
			
		if (VIGOR_RUSH_LEVEL_USE_PERK == 1)	
			enable_vigor_rush_for_level();
			
		if (WALL_POWER_LEVEL_USE_PERK == 1)
			enable_wall_power_for_level();
			
		if (WIDOWS_WINE_LEVEL_USE_PERK == 1)
			enable_widows_wine_for_level();
			
		if (WINDRUNNER_LEVEL_USE_PERK == 1)	
			enable_windrunner_for_level();
			
		if (WINTERS_WAIL_LEVEL_USE_PERK == 1)
			enable_winters_wail_for_level();
			
		if (WUNDERFIZZ_LEVEL_USE == 1)
			enable_wunderfizz_for_level();
			
		if (ZOMBSHELL_LEVEL_USE_PERK == 1)
			enable_zombshell_for_level();
	}
}


// ======================================================================================================
// Ammo Americano
// ======================================================================================================

function enable_ammo_americano_for_level()
{	
	zm_perks::register_perk_basic_info( 						AMMO_AMERICANO_PERK, AMMO_AMERICANO_ALIAS, AMMO_AMERICANO_COST, AMMO_AMERICANO_TRIG_STRING, GetWeapon (AMMO_AMERICANO_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 						AMMO_AMERICANO_PERK, &ammo_americano_precache);
	zm_perks::register_perk_clientfields( 						AMMO_AMERICANO_PERK, &ammo_americano_register_clientfield, &ammo_americano_set_clientfield);
	zm_perks::register_perk_machine( 							AMMO_AMERICANO_PERK, &ammo_americano_machine_setup);
	zm_perks::register_perk_threads( 							AMMO_AMERICANO_PERK, &ammo_americano_give_perk, &ammo_americano_take_perk);
	zm_perks::register_perk_host_migration_params( 				AMMO_AMERICANO_PERK, AMMO_AMERICANO_RADIANT_MACHINE_NAME, AMMO_AMERICANO_PERK);
}

function ammo_americano_precache()
{
	level.machine_assets [AMMO_AMERICANO_PERK]	 				= SpawnStruct();
	level.machine_assets [AMMO_AMERICANO_PERK].weapon 			= GetWeapon (AMMO_AMERICANO_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [AMMO_AMERICANO_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [AMMO_AMERICANO_PERK].off_model 	= AMMO_AMERICANO_MODEL_BUCKET;
		level.machine_assets [AMMO_AMERICANO_PERK].on_model 	= AMMO_AMERICANO_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [AMMO_AMERICANO_PERK]						= AMMO_AMERICANO_MACHINE_LIGHT_FX;
		level.machine_assets [AMMO_AMERICANO_PERK].off_model 	= AMMO_AMERICANO_MACHINE_DISABLED_MODEL;
		level.machine_assets [AMMO_AMERICANO_PERK].on_model 	= AMMO_AMERICANO_MACHINE_ACTIVE_MODEL;	
	}
}

function ammo_americano_register_clientfield() 
{
	clientfield::register ("clientuimodel", AMMO_AMERICANO_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function ammo_americano_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (AMMO_AMERICANO_CLIENTFIELD, state);
}

function ammo_americano_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= AMMO_AMERICANO_JINGLE;
	use_trigger.script_string 									= AMMO_AMERICANO_SCRIPT_STRING;
	use_trigger.script_label 									= AMMO_AMERICANO_STING;
	use_trigger.target 											= AMMO_AMERICANO_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= AMMO_AMERICANO_SCRIPT_STRING;
	perk_machine.targetname 									= AMMO_AMERICANO_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= AMMO_AMERICANO_SCRIPT_STRING;
}

function ammo_americano_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + AMMO_AMERICANO_ALIAS);
	
	self notify (AMMO_AMERICANO_PERK + "_start");	
	
	if (AMMO_AMERICANO_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < AMMO_AMERICANO_SECONDARY_PERKS.size; i++)
			self SetPerk (AMMO_AMERICANO_SECONDARY_PERKS [i]);
			
	self.west_hasperk_ammo_americano = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = AMMO_AMERICANO_PERK;
	self notify ("west_perk_purchased");
}

function ammo_americano_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + AMMO_AMERICANO_ALIAS);
	self notify (AMMO_AMERICANO_PERK + "_stop");
	
	if (AMMO_AMERICANO_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < AMMO_AMERICANO_SECONDARY_PERKS.size; i++)
			self UnsetPerk (AMMO_AMERICANO_SECONDARY_PERKS [i]);
			
	self.west_hasperk_ammo_americano = 0;
}

function ammo_americano_host_migration_func()
{
	a_ammo_americano_machines = GetEntArray (AMMO_AMERICANO_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_ammo_americano_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == AMMO_AMERICANO_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (AMMO_AMERICANO_ALIAS);
		}
	}
}


// ======================================================================================================
// Astro Ale
// ======================================================================================================

function enable_astro_ale_for_level()
{	
	zm_perks::register_perk_basic_info( 				ASTRO_ALE_PERK, ASTRO_ALE_ALIAS, ASTRO_ALE_COST, ASTRO_ALE_TRIG_STRING, GetWeapon (ASTRO_ALE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ASTRO_ALE_PERK, &astro_ale_precache);
	zm_perks::register_perk_clientfields( 				ASTRO_ALE_PERK, &astro_ale_register_clientfield, &astro_ale_set_clientfield);
	zm_perks::register_perk_machine( 					ASTRO_ALE_PERK, &astro_ale_machine_setup);
	zm_perks::register_perk_threads( 					ASTRO_ALE_PERK, &astro_ale_give_perk, &astro_ale_take_perk);
	zm_perks::register_perk_host_migration_params( 		ASTRO_ALE_PERK, ASTRO_ALE_RADIANT_MACHINE_NAME, ASTRO_ALE_PERK);
}

function astro_ale_precache()
{
	level.machine_assets[ASTRO_ALE_PERK] 				= SpawnStruct();
	level.machine_assets[ASTRO_ALE_PERK].weapon 		= GetWeapon (ASTRO_ALE_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ASTRO_ALE_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ASTRO_ALE_PERK].off_model 	= ASTRO_ALE_MODEL_BUCKET;
		level.machine_assets [ASTRO_ALE_PERK].on_model 		= ASTRO_ALE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ASTRO_ALE_PERK]						= ASTRO_ALE_MACHINE_LIGHT_FX;
		level.machine_assets [ASTRO_ALE_PERK].off_model 	= ASTRO_ALE_MACHINE_DISABLED_MODEL;
		level.machine_assets [ASTRO_ALE_PERK].on_model 		= ASTRO_ALE_MACHINE_ACTIVE_MODEL;	
	}
}

function astro_ale_register_clientfield() 
{
	clientfield::register ("clientuimodel", ASTRO_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function astro_ale_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ASTRO_ALE_CLIENTFIELD, state);
}

function astro_ale_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= ASTRO_ALE_JINGLE;
	use_trigger.script_string 							= ASTRO_ALE_SCRIPT_STRING;
	use_trigger.script_label 							= ASTRO_ALE_STING;
	use_trigger.target 									= ASTRO_ALE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ASTRO_ALE_SCRIPT_STRING;
	perk_machine.targetname 							= ASTRO_ALE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ASTRO_ALE_SCRIPT_STRING;
}

function astro_ale_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ASTRO_ALE_ALIAS);
	
	self notify (ASTRO_ALE_PERK + "_start");
		
	if (ASTRO_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ASTRO_ALE_SECONDARY_PERKS.size; i++)
			self SetPerk (ASTRO_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_astro = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ASTRO_ALE_PERK;
	self notify ("west_perk_purchased");
}

function astro_ale_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ASTRO_ALE_ALIAS);
	self notify (ASTRO_ALE_PERK + "_stop");
	
	if (ASTRO_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ASTRO_ALE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ASTRO_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_astro = 0;
}

function astro_ale_host_migration_func()
{
	a_astro_ale_machines = GetEntArray (ASTRO_ALE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_astro_ale_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ASTRO_ALE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ASTRO_ALE_ALIAS);
		}
	}
}


// ======================================================================================================
// Atomic Liqueur
// ======================================================================================================

function enable_atomic_liqueur_for_level()
{	
	zm_perks::register_perk_basic_info( 				ATOMIC_LIQUEUR_PERK, ATOMIC_LIQUEUR_ALIAS, ATOMIC_LIQUEUR_COST, ATOMIC_LIQUEUR_TRIG_STRING, GetWeapon (ATOMIC_LIQUEUR_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ATOMIC_LIQUEUR_PERK, &atomic_liqueur_precache);
	zm_perks::register_perk_clientfields( 				ATOMIC_LIQUEUR_PERK, &atomic_liqueur_register_clientfield, &atomic_liqueur_set_clientfield);
	zm_perks::register_perk_machine( 					ATOMIC_LIQUEUR_PERK, &atomic_liqueur_machine_setup);
	zm_perks::register_perk_threads( 					ATOMIC_LIQUEUR_PERK, &atomic_liqueur_give_perk, &atomic_liqueur_take_perk);
	zm_perks::register_perk_host_migration_params( 		ATOMIC_LIQUEUR_PERK, ATOMIC_LIQUEUR_RADIANT_MACHINE_NAME, ATOMIC_LIQUEUR_PERK);

	level.west_melee_perks [level.west_melee_perks.size] = ATOMIC_LIQUEUR_ALIAS;
}

function atomic_liqueur_precache()
{
	level.machine_assets [ATOMIC_LIQUEUR_PERK] 				= SpawnStruct();
	level.machine_assets [ATOMIC_LIQUEUR_PERK].weapon 		= GetWeapon (ATOMIC_LIQUEUR_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ATOMIC_LIQUEUR_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ATOMIC_LIQUEUR_PERK].off_model 	= ATOMIC_LIQUEUR_MODEL_BUCKET;
		level.machine_assets [ATOMIC_LIQUEUR_PERK].on_model 	= ATOMIC_LIQUEUR_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ATOMIC_LIQUEUR_PERK]						= ATOMIC_LIQUEUR_MACHINE_LIGHT_FX;
		level.machine_assets [ATOMIC_LIQUEUR_PERK].off_model 	= ATOMIC_LIQUEUR_MACHINE_DISABLED_MODEL;
		level.machine_assets [ATOMIC_LIQUEUR_PERK].on_model 	= ATOMIC_LIQUEUR_MACHINE_ACTIVE_MODEL;	
	}
}

function atomic_liqueur_register_clientfield() 
{
	clientfield::register ("clientuimodel", ATOMIC_LIQUEUR_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function atomic_liqueur_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ATOMIC_LIQUEUR_CLIENTFIELD, state);
}

function atomic_liqueur_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= ATOMIC_LIQUEUR_JINGLE;
	use_trigger.script_string 							= ATOMIC_LIQUEUR_SCRIPT_STRING;
	use_trigger.script_label 							= ATOMIC_LIQUEUR_STING;
	use_trigger.target 									= ATOMIC_LIQUEUR_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ATOMIC_LIQUEUR_SCRIPT_STRING;
	perk_machine.targetname 							= ATOMIC_LIQUEUR_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ATOMIC_LIQUEUR_SCRIPT_STRING;
}

function atomic_liqueur_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ATOMIC_LIQUEUR_ALIAS);
	
	self notify (ATOMIC_LIQUEUR_PERK + "_start");	
	
	if (ATOMIC_LIQUEUR_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ATOMIC_LIQUEUR_SECONDARY_PERKS.size; i++)
			self SetPerk (ATOMIC_LIQUEUR_SECONDARY_PERKS [i]);
			
	self.west_hasperk_atomic_liqueur = 1;
	
	self.atomic_liqueur_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ATOMIC_LIQUEUR_PERK;
	self notify ("west_perk_purchased");
}

function atomic_liqueur_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ATOMIC_LIQUEUR_ALIAS);
	self notify (ATOMIC_LIQUEUR_PERK + "_stop");
	
	if (ATOMIC_LIQUEUR_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ATOMIC_LIQUEUR_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ATOMIC_LIQUEUR_SECONDARY_PERKS [i]);
			
	self.west_hasperk_atomic_liqueur = 0;
	
	self.atomic_liqueur_cooldown = 0;
	
	if (IsDefined (self.atomic_bar))
		self.atomic_bar Destroy();
		
	if (IsDefined (self.atomic_icon))
		self.atomic_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function atomic_liqueur_host_migration_func()
{
	a_atomic_liqueur_machines = GetEntArray (ATOMIC_LIQUEUR_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_atomic_liqueur_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ATOMIC_LIQUEUR_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ATOMIC_LIQUEUR_ALIAS);
		}
	}
}


// ======================================================================================================
// Blaze Phase
// ======================================================================================================

function enable_banana_colada_for_level()
{	
	zm_perks::register_perk_basic_info( 					BANANA_COLADA_PERK, BANANA_COLADA_ALIAS, BANANA_COLADA_COST, BANANA_COLADA_TRIG_STRING, GetWeapon (BANANA_COLADA_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 					BANANA_COLADA_PERK, &banana_colada_precache);
	zm_perks::register_perk_clientfields( 					BANANA_COLADA_PERK, &banana_colada_register_clientfield, &banana_colada_set_clientfield);
	zm_perks::register_perk_machine( 						BANANA_COLADA_PERK, &banana_colada_machine_setup);
	zm_perks::register_perk_threads( 						BANANA_COLADA_PERK, &banana_colada_give_perk, &banana_colada_take_perk);
	zm_perks::register_perk_host_migration_params( 			BANANA_COLADA_PERK, BANANA_COLADA_RADIANT_MACHINE_NAME, BANANA_COLADA_PERK);
}

function banana_colada_precache()
{
	level.machine_assets [BANANA_COLADA_PERK] 				= SpawnStruct();
	level.machine_assets [BANANA_COLADA_PERK].weapon 		= GetWeapon (BANANA_COLADA_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BANANA_COLADA_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BANANA_COLADA_PERK].off_model = BANANA_COLADA_MODEL_BUCKET;
		level.machine_assets [BANANA_COLADA_PERK].on_model 	= BANANA_COLADA_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BANANA_COLADA_PERK]					= BANANA_COLADA_MACHINE_LIGHT_FX;
		level.machine_assets [BANANA_COLADA_PERK].off_model	= BANANA_COLADA_MACHINE_DISABLED_MODEL;
		level.machine_assets [BANANA_COLADA_PERK].on_model 	= BANANA_COLADA_MACHINE_ACTIVE_MODEL;	
	}
}

function banana_colada_register_clientfield() 
{
	clientfield::register ("clientuimodel", BANANA_COLADA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function banana_colada_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BANANA_COLADA_CLIENTFIELD, state);
}

function banana_colada_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 								= BANANA_COLADA_JINGLE;
	use_trigger.script_string 								= BANANA_COLADA_SCRIPT_STRING;
	use_trigger.script_label 								= BANANA_COLADA_STING;
	use_trigger.target 										= BANANA_COLADA_RADIANT_MACHINE_NAME;
	perk_machine.script_string 								= BANANA_COLADA_SCRIPT_STRING;
	perk_machine.targetname 								= BANANA_COLADA_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 							= BANANA_COLADA_SCRIPT_STRING;
}

function banana_colada_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BANANA_COLADA_ALIAS);
	
	self notify (BANANA_COLADA_PERK + "_start");	
	
	if (BANANA_COLADA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BANANA_COLADA_SECONDARY_PERKS.size; i++)
			self SetPerk (BANANA_COLADA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_banana_colada = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BANANA_COLADA_PERK;
	self notify ("west_perk_purchased");
}

function banana_colada_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BANANA_COLADA_ALIAS);
	self notify (BANANA_COLADA_PERK + "_stop");
	
	if (BANANA_COLADA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BANANA_COLADA_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BANANA_COLADA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_banana_colada = 0;
}

function banana_colada_host_migration_func()
{
	a_banana_colada_machines = GetEntArray (BANANA_COLADA_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_banana_colada_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BANANA_COLADA_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BANANA_COLADA_ALIAS);
		}
	}
}


// ======================================================================================================
// Bandolier Bandit
// ======================================================================================================

function enable_bandolier_bandit_for_level()
{	
	zm_perks::register_perk_basic_info( 				BANDOLIER_BANDIT_PERK, BANDOLIER_BANDIT_ALIAS, BANDOLIER_BANDIT_COST, BANDOLIER_BANDIT_TRIG_STRING, GetWeapon (BANDOLIER_BANDIT_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BANDOLIER_BANDIT_PERK, &bandolier_bandit_precache);
	zm_perks::register_perk_clientfields( 				BANDOLIER_BANDIT_PERK, &bandolier_bandit_register_clientfield, &bandolier_bandit_set_clientfield);
	zm_perks::register_perk_machine( 					BANDOLIER_BANDIT_PERK, &bandolier_bandit_machine_setup);
	zm_perks::register_perk_threads( 					BANDOLIER_BANDIT_PERK, &bandolier_bandit_give_perk, &bandolier_bandit_take_perk);
	zm_perks::register_perk_host_migration_params( 		BANDOLIER_BANDIT_PERK, BANDOLIER_BANDIT_RADIANT_MACHINE_NAME, BANDOLIER_BANDIT_PERK);
}

function bandolier_bandit_precache()
{
	level.machine_assets [BANDOLIER_BANDIT_PERK] 				= SpawnStruct();
	level.machine_assets [BANDOLIER_BANDIT_PERK].weapon 		= GetWeapon (BANDOLIER_BANDIT_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BANDOLIER_BANDIT_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BANDOLIER_BANDIT_PERK].off_model 	= BANDOLIER_BANDIT_MODEL_BUCKET;
		level.machine_assets [BANDOLIER_BANDIT_PERK].on_model 	= BANDOLIER_BANDIT_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BANDOLIER_BANDIT_PERK]					= BANDOLIER_BANDIT_MACHINE_LIGHT_FX;
		level.machine_assets [BANDOLIER_BANDIT_PERK].off_model 	= BANDOLIER_BANDIT_MACHINE_DISABLED_MODEL;
		level.machine_assets [BANDOLIER_BANDIT_PERK].on_model 	= BANDOLIER_BANDIT_MACHINE_ACTIVE_MODEL;	
	}
}

function bandolier_bandit_register_clientfield() 
{
	clientfield::register ("clientuimodel", BANDOLIER_BANDIT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function bandolier_bandit_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BANDOLIER_BANDIT_CLIENTFIELD, state);
}

function bandolier_bandit_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= BANDOLIER_BANDIT_JINGLE;
		use_trigger.script_label 						= BANDOLIER_BANDIT_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}

	use_trigger.script_string 							= BANDOLIER_BANDIT_SCRIPT_STRING;
	use_trigger.target 									= BANDOLIER_BANDIT_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= BANDOLIER_BANDIT_SCRIPT_STRING;
	perk_machine.targetname 							= BANDOLIER_BANDIT_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= BANDOLIER_BANDIT_SCRIPT_STRING;
}

function bandolier_bandit_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BANDOLIER_BANDIT_ALIAS);
	
	self notify (BANDOLIER_BANDIT_PERK + "_start");	
	
	if (BANDOLIER_BANDIT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BANDOLIER_BANDIT_SECONDARY_PERKS.size; i++)
			self SetPerk (BANDOLIER_BANDIT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bandolier_bandit = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BANDOLIER_BANDIT_PERK;
	self notify ("west_perk_purchased");
}

function bandolier_bandit_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BANDOLIER_BANDIT_ALIAS);
	self notify (BANDOLIER_BANDIT_PERK + "_stop");
	
	if (BANDOLIER_BANDIT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BANDOLIER_BANDIT_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BANDOLIER_BANDIT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bandolier_bandit = 0;
	
	if (IsDefined (self.bandolier_bandit_hud))
		self.bandolier_bandit_hud Destroy();
}

function bandolier_bandit_host_migration_func()
{
	a_bandolier_bandit_machines = GetEntArray (BANDOLIER_BANDIT_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_bandolier_bandit_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BANDOLIER_BANDIT_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BANDOLIER_BANDIT_ALIAS);
		}
	}
}


// ======================================================================================================
// Blaze Phase
// ======================================================================================================

function enable_blaze_phase_for_level()
{	
	zm_perks::register_perk_basic_info( 				BLAZE_PHASE_PERK, BLAZE_PHASE_ALIAS, BLAZE_PHASE_COST, BLAZE_PHASE_TRIG_STRING, GetWeapon (BLAZE_PHASE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BLAZE_PHASE_PERK, &blaze_phase_precache);
	zm_perks::register_perk_clientfields( 				BLAZE_PHASE_PERK, &blaze_phase_register_clientfield, &blaze_phase_set_clientfield);
	zm_perks::register_perk_machine( 					BLAZE_PHASE_PERK, &blaze_phase_machine_setup);
	zm_perks::register_perk_threads( 					BLAZE_PHASE_PERK, &blaze_phase_give_perk, &blaze_phase_take_perk);
	zm_perks::register_perk_host_migration_params( 		BLAZE_PHASE_PERK, BLAZE_PHASE_RADIANT_MACHINE_NAME, BLAZE_PHASE_PERK);
}

function blaze_phase_precache()
{
	level.machine_assets [BLAZE_PHASE_PERK] 			= SpawnStruct();
	level.machine_assets [BLAZE_PHASE_PERK].weapon 		= GetWeapon (BLAZE_PHASE_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BLAZE_PHASE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BLAZE_PHASE_PERK].off_model 	= BLAZE_PHASE_MODEL_BUCKET;
		level.machine_assets [BLAZE_PHASE_PERK].on_model 	= BLAZE_PHASE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BLAZE_PHASE_PERK]					= BLAZE_PHASE_MACHINE_LIGHT_FX;
		level.machine_assets [BLAZE_PHASE_PERK].off_model 	= BLAZE_PHASE_MACHINE_DISABLED_MODEL;
		level.machine_assets [BLAZE_PHASE_PERK].on_model 	= BLAZE_PHASE_MACHINE_ACTIVE_MODEL;	
	}
}

function blaze_phase_register_clientfield() 
{
	clientfield::register ("clientuimodel", BLAZE_PHASE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function blaze_phase_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BLAZE_PHASE_CLIENTFIELD, state);
}

function blaze_phase_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= BLAZE_PHASE_JINGLE;
		use_trigger.script_label 						= BLAZE_PHASE_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= BLAZE_PHASE_SCRIPT_STRING;
	use_trigger.target 									= BLAZE_PHASE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= BLAZE_PHASE_SCRIPT_STRING;
	perk_machine.targetname 							= BLAZE_PHASE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= BLAZE_PHASE_SCRIPT_STRING;
}

function blaze_phase_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BLAZE_PHASE_ALIAS);
	
	self notify (BLAZE_PHASE_PERK + "_start");	
	
	if (BLAZE_PHASE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLAZE_PHASE_SECONDARY_PERKS.size; i++)
			self SetPerk (BLAZE_PHASE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_blaze_phase = 1;
	
	self.blaze_phase_charging = 0;
	self.blaze_phase_on_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BLAZE_PHASE_PERK;
	self notify ("west_perk_purchased");
}

function blaze_phase_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BLAZE_PHASE_ALIAS);
	self notify (BLAZE_PHASE_PERK + "_stop");
	
	if (BLAZE_PHASE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLAZE_PHASE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BLAZE_PHASE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_blaze_phase = 0;
	
	if (self.blaze_phase_charging == 1)
	{
		self clientfield::set ("burn", 0);
		self StopLoopSound (1);
	}
	
	self.blaze_phase_charging = 0;
	self.blaze_phase_on_cooldown = 0;
	
	if (IsDefined (self.blaze_phase_bar))
		self.blaze_phase_bar Destroy();
			
	if (IsDefined (self.blaze_phase_icon))
		self.blaze_phase_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function blaze_phase_host_migration_func()
{
	a_blaze_phase_machines = GetEntArray (BLAZE_PHASE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_blaze_phase_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BLAZE_PHASE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BLAZE_PHASE_ALIAS);
		}
	}
}


// ======================================================================================================
// Bleeding Bloody Mary
// ======================================================================================================

function enable_bleeding_for_level()
{	
	zm_perks::register_perk_basic_info( 				BLEEDING_PERK, BLEEDING_ALIAS, BLEEDING_COST, BLEEDING_TRIG_STRING, GetWeapon (BLEEDING_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BLEEDING_PERK, &bleeding_precache);
	zm_perks::register_perk_clientfields( 				BLEEDING_PERK, &bleeding_register_clientfield, &bleeding_set_clientfield);
	zm_perks::register_perk_machine( 					BLEEDING_PERK, &bleeding_machine_setup);
	zm_perks::register_perk_threads( 					BLEEDING_PERK, &bleeding_give_perk, &bleeding_take_perk);
	zm_perks::register_perk_host_migration_params( 		BLEEDING_PERK, BLEEDING_RADIANT_MACHINE_NAME, BLEEDING_PERK);
}

function bleeding_precache()
{
	level.machine_assets [BLEEDING_PERK] 				= SpawnStruct();
	level.machine_assets [BLEEDING_PERK].weapon 		= GetWeapon (BLEEDING_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BLEEDING_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BLEEDING_PERK].off_model 	= BLEEDING_MODEL_BUCKET;
		level.machine_assets [BLEEDING_PERK].on_model 	= BLEEDING_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BLEEDING_PERK]					= BLEEDING_MACHINE_LIGHT_FX;
		level.machine_assets [BLEEDING_PERK].off_model 	= BLEEDING_MACHINE_DISABLED_MODEL;
		level.machine_assets [BLEEDING_PERK].on_model 	= BLEEDING_MACHINE_ACTIVE_MODEL;	
	}
}

function bleeding_register_clientfield() 
{
	clientfield::register ("clientuimodel", BLEEDING_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function bleeding_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BLEEDING_CLIENTFIELD, state);
}

function bleeding_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= BLEEDING_JINGLE;
	use_trigger.script_string 							= BLEEDING_SCRIPT_STRING;
	use_trigger.script_label 							= BLEEDING_STING;
	use_trigger.target 									= BLEEDING_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= BLEEDING_SCRIPT_STRING;
	perk_machine.targetname 							= BLEEDING_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= BLEEDING_SCRIPT_STRING;
}

function bleeding_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BLEEDING_ALIAS);
	
	self notify (BLEEDING_PERK + "_start");	
	
	if (BLEEDING_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLEEDING_SECONDARY_PERKS.size; i++)
			self SetPerk (BLEEDING_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bleeding = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BLEEDING_PERK;
	self notify ("west_perk_purchased");
}

function bleeding_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BLEEDING_ALIAS);
	self notify (BLEEDING_PERK + "_stop");
	
	if (BLEEDING_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLEEDING_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BLEEDING_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bleeding = 0;
}

function bleeding_host_migration_func()
{
	a_bleeding_machines = GetEntArray (BLEEDING_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_bleeding_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BLEEDING_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BLEEDING_ALIAS);
		}
	}
}


// ======================================================================================================
// Blood Wolf Bite
// ======================================================================================================

function enable_blood_wolf_for_level()
{	
	zm_perks::register_perk_basic_info( 				BLOOD_WOLF_PERK, BLOOD_WOLF_ALIAS, BLOOD_WOLF_COST, BLOOD_WOLF_TRIG_STRING, GetWeapon (BLOOD_WOLF_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BLOOD_WOLF_PERK, &blood_wolf_precache);
	zm_perks::register_perk_clientfields( 				BLOOD_WOLF_PERK, &blood_wolf_register_clientfield, &blood_wolf_set_clientfield);
	zm_perks::register_perk_machine( 					BLOOD_WOLF_PERK, &blood_wolf_machine_setup);
	zm_perks::register_perk_threads( 					BLOOD_WOLF_PERK, &blood_wolf_give_perk, &blood_wolf_take_perk);
	zm_perks::register_perk_host_migration_params( 		BLOOD_WOLF_PERK, BLOOD_WOLF_RADIANT_MACHINE_NAME, BLOOD_WOLF_PERK);
}

function blood_wolf_precache()
{
	level.machine_assets [BLOOD_WOLF_PERK] 					= SpawnStruct();
	level.machine_assets [BLOOD_WOLF_PERK].weapon 			= GetWeapon (BLOOD_WOLF_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BLOOD_WOLF_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BLOOD_WOLF_PERK].off_model 	= BLOOD_WOLF_MODEL_BUCKET;
		level.machine_assets [BLOOD_WOLF_PERK].on_model 	= BLOOD_WOLF_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BLOOD_WOLF_PERK]						= BLOOD_WOLF_MACHINE_LIGHT_FX;
		level.machine_assets [BLOOD_WOLF_PERK].off_model 	= BLOOD_WOLF_MACHINE_DISABLED_MODEL;
		level.machine_assets [BLOOD_WOLF_PERK].on_model 	= BLOOD_WOLF_MACHINE_ACTIVE_MODEL;	
	}
}

function blood_wolf_register_clientfield() 
{
	clientfield::register ("actor", "LUNA", VERSION_SHIP, 1, "int");
	clientfield::register ("clientuimodel", BLOOD_WOLF_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function blood_wolf_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BLOOD_WOLF_CLIENTFIELD, state);
}

function blood_wolf_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= BLOOD_WOLF_JINGLE;
		use_trigger.script_label 						= BLOOD_WOLF_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= BLOOD_WOLF_SCRIPT_STRING;
	use_trigger.target 									= BLOOD_WOLF_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= BLOOD_WOLF_SCRIPT_STRING;
	perk_machine.targetname 							= BLOOD_WOLF_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= BLOOD_WOLF_SCRIPT_STRING;
}

function blood_wolf_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BLOOD_WOLF_ALIAS);
	
	self notify (BLOOD_WOLF_PERK + "_start");	
	
	if (BLOOD_WOLF_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLOOD_WOLF_SECONDARY_PERKS.size; i++)
			self SetPerk (BLOOD_WOLF_SECONDARY_PERKS [i]);
			
	self.west_hasperk_blood_wolf = 1;
	
	self.blood_wolf_active = 0;
	self.blood_wolf_on_cooldown = 0;
	self.blood_wolf_current_damage = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BLOOD_WOLF_PERK;
	self notify ("west_perk_purchased");
}

function blood_wolf_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BLOOD_WOLF_ALIAS);
	self notify (BLOOD_WOLF_PERK + "_stop");
	
	if (BLOOD_WOLF_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BLOOD_WOLF_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BLOOD_WOLF_SECONDARY_PERKS [i]);
			
	self.west_hasperk_blood_wolf = 0;
	
	self.blood_wolf_active = 0;
	self.blood_wolf_on_cooldown = 0;
	self.blood_wolf_current_damage = 0;
	
	if (IsDefined (self.blood_wolf_bar))
		self.blood_wolf_bar Destroy();
			
	if (IsDefined (self.blood_wolf_icon))
		self.blood_wolf_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function blood_wolf_host_migration_func()
{
	a_blood_wolf_machines = GetEntArray (BLOOD_WOLF_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_blood_wolf_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BLOOD_WOLF_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BLOOD_WOLF_ALIAS);
		}
	}
}


// ======================================================================================================
// Brawlstar Punch
// ======================================================================================================

function enable_brawlstar_punch_for_level()
{	
	zm_perks::register_perk_basic_info( 				BRAWLSTAR_PUNCH_PERK, BRAWLSTAR_PUNCH_ALIAS, BRAWLSTAR_PUNCH_COST, BRAWLSTAR_PUNCH_TRIG_STRING, GetWeapon (BRAWLSTAR_PUNCH_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_precache);
	zm_perks::register_perk_clientfields( 				BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_register_clientfield, &brawlstar_punch_set_clientfield);
	zm_perks::register_perk_machine( 					BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_machine_setup);
	zm_perks::register_perk_threads( 					BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_give_perk, &brawlstar_punch_take_perk);
	zm_perks::register_perk_host_migration_params( 		BRAWLSTAR_PUNCH_PERK, BRAWLSTAR_PUNCH_RADIANT_MACHINE_NAME, BRAWLSTAR_PUNCH_PERK);
}

function brawlstar_punch_precache()
{
	level._effect [BRAWLSTAR_PUNCH_BLOWBACK_FX]			= BRAWLSTAR_PUNCH_BLOWBACK_FX;
	level._effect [BRAWLSTAR_PUNCH_HIT_FX]				= BRAWLSTAR_PUNCH_HIT_FX;
	
	level.machine_assets[BRAWLSTAR_PUNCH_PERK] 			= SpawnStruct();
	level.machine_assets[BRAWLSTAR_PUNCH_PERK].weapon 	= GetWeapon (BRAWLSTAR_PUNCH_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BRAWLSTAR_PUNCH_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BRAWLSTAR_PUNCH_PERK].off_model 	= BRAWLSTAR_PUNCH_MODEL_BUCKET;
		level.machine_assets [BRAWLSTAR_PUNCH_PERK].on_model 	= BRAWLSTAR_PUNCH_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BRAWLSTAR_PUNCH_PERK]					= BRAWLSTAR_PUNCH_MACHINE_LIGHT_FX;
		level.machine_assets [BRAWLSTAR_PUNCH_PERK].off_model 	= BRAWLSTAR_PUNCH_MACHINE_DISABLED_MODEL;
		level.machine_assets [BRAWLSTAR_PUNCH_PERK].on_model 	= BRAWLSTAR_PUNCH_MACHINE_ACTIVE_MODEL;	
	}
}

function brawlstar_punch_register_clientfield() 
{
	clientfield::register ("clientuimodel", BRAWLSTAR_PUNCH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function brawlstar_punch_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BRAWLSTAR_PUNCH_CLIENTFIELD, state);
}

function brawlstar_punch_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= BRAWLSTAR_PUNCH_JINGLE;
	use_trigger.script_string 							= BRAWLSTAR_PUNCH_SCRIPT_STRING;
	use_trigger.script_label 							= BRAWLSTAR_PUNCH_STING;
	use_trigger.target 									= BRAWLSTAR_PUNCH_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= BRAWLSTAR_PUNCH_SCRIPT_STRING;
	perk_machine.targetname 							= BRAWLSTAR_PUNCH_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= BRAWLSTAR_PUNCH_SCRIPT_STRING;
}

function brawlstar_punch_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BRAWLSTAR_PUNCH_ALIAS);
	
	self notify (BRAWLSTAR_PUNCH_PERK + "_start");	
	
	if (BRAWLSTAR_PUNCH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BRAWLSTAR_PUNCH_SECONDARY_PERKS.size; i++)
			self SetPerk (BRAWLSTAR_PUNCH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_brawlstar = 1;
	
	self.brawlstar_punch_active = false;
	self.brawlstar_punch_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BRAWLSTAR_PUNCH_PERK;
	self notify ("west_perk_purchased");
}

function brawlstar_punch_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BRAWLSTAR_PUNCH_ALIAS);
	self notify (BRAWLSTAR_PUNCH_PERK + "_stop");
	
	if (BRAWLSTAR_PUNCH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BRAWLSTAR_PUNCH_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BRAWLSTAR_PUNCH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_brawlstar = 0;
			
	self.brawlstar_punch_active = false;
	self.brawlstar_punch_cooldown = 0;
		
	if (IsDefined (self.brawlstar_punch_bar))
		self.brawlstar_punch_bar Destroy();
		
	if (IsDefined (self.brawlstar_punch_icon))
		self.brawlstar_punch_icon Destroy();
	
	self notify ("cooldown_bar_update");
}

function brawlstar_punch_host_migration_func()
{
	a_brawlstar_punch_machines = GetEntArray (BRAWLSTAR_PUNCH_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_brawlstar_punch_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BRAWLSTAR_PUNCH_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BRAWLSTAR_PUNCH_ALIAS);
		}
	}
}


// ======================================================================================================
// Brimstone Bramble
// ======================================================================================================

function enable_brimstone_bramble_for_level()
{	
	zm_perks::register_perk_basic_info( 			BRIMSTONE_BRAMBLE_PERK, BRIMSTONE_BRAMBLE_ALIAS, BRIMSTONE_BRAMBLE_COST, BRIMSTONE_BRAMBLE_TRIG_STRING, GetWeapon (BRIMSTONE_BRAMBLE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 			BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_precache);
	zm_perks::register_perk_clientfields( 			BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_register_clientfield, &brimstone_bramble_set_clientfield);
	zm_perks::register_perk_machine( 				BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_machine_setup);
	zm_perks::register_perk_threads( 				BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_give_perk, &brimstone_bramble_take_perk);
	zm_perks::register_perk_host_migration_params(	BRIMSTONE_BRAMBLE_PERK, BRIMSTONE_BRAMBLE_RADIANT_MACHINE_NAME, BRIMSTONE_BRAMBLE_PERK);
}

function brimstone_bramble_precache()
{
	level._effect [BRIMSTONE_BRAMBLE_EXPLOSION_FX] 				= BRIMSTONE_BRAMBLE_EXPLOSION_FX_FILE;
	
	level.machine_assets [BRIMSTONE_BRAMBLE_PERK] 				= SpawnStruct();
	level.machine_assets [BRIMSTONE_BRAMBLE_PERK].weapon 		= GetWeapon (BRIMSTONE_BRAMBLE_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BRIMSTONE_BRAMBLE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BRIMSTONE_BRAMBLE_PERK].off_model = BRIMSTONE_BRAMBLE_MODEL_BUCKET;
		level.machine_assets [BRIMSTONE_BRAMBLE_PERK].on_model 	= BRIMSTONE_BRAMBLE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BRIMSTONE_BRAMBLE_PERK]					= BRIMSTONE_BRAMBLE_MACHINE_LIGHT_FX;
		level.machine_assets [BRIMSTONE_BRAMBLE_PERK].off_model = BRIMSTONE_BRAMBLE_MACHINE_DISABLED_MODEL;
		level.machine_assets [BRIMSTONE_BRAMBLE_PERK].on_model 	= BRIMSTONE_BRAMBLE_MACHINE_ACTIVE_MODEL;	
	}
}

function brimstone_bramble_register_clientfield() 
{
	clientfield::register ("clientuimodel", BRIMSTONE_BRAMBLE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function brimstone_bramble_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BRIMSTONE_BRAMBLE_CLIENTFIELD, state);
}

function brimstone_bramble_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= BRIMSTONE_BRAMBLE_JINGLE;
	use_trigger.script_string 									= BRIMSTONE_BRAMBLE_SCRIPT_STRING;
	use_trigger.script_label 									= BRIMSTONE_BRAMBLE_STING;
	use_trigger.target 											= BRIMSTONE_BRAMBLE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= BRIMSTONE_BRAMBLE_SCRIPT_STRING;
	perk_machine.targetname 									= BRIMSTONE_BRAMBLE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= BRIMSTONE_BRAMBLE_SCRIPT_STRING;
}

function brimstone_bramble_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BRIMSTONE_BRAMBLE_ALIAS);
	
	self notify (BRIMSTONE_BRAMBLE_PERK + "_start");	
	
	if (BRIMSTONE_BRAMBLE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BRIMSTONE_BRAMBLE_SECONDARY_PERKS.size; i++)
			self SetPerk (BRIMSTONE_BRAMBLE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_brimstone = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BRIMSTONE_BRAMBLE_PERK;
	self notify ("west_perk_purchased");
}

function brimstone_bramble_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BRIMSTONE_BRAMBLE_ALIAS);
	self notify (BRIMSTONE_BRAMBLE_PERK + "_stop");
	
	if (BRIMSTONE_BRAMBLE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BRIMSTONE_BRAMBLE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BRIMSTONE_BRAMBLE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_brimstone = 0;
}

function brimstone_bramble_host_migration_func()
{
	a_brimstone_bramble_machines = GetEntArray (BRIMSTONE_BRAMBLE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_brimstone_bramble_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BRIMSTONE_BRAMBLE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BRIMSTONE_BRAMBLE_ALIAS);
		}
	}
}


// ======================================================================================================
// Bull Ice Blast
// ======================================================================================================

function enable_bull_ice_blast_for_level()
{	
	zm_perks::register_perk_basic_info( 				BULL_ICE_BLAST_PERK, BULL_ICE_BLAST_ALIAS, BULL_ICE_BLAST_COST, BULL_ICE_BLAST_TRIG_STRING, GetWeapon (BULL_ICE_BLAST_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				BULL_ICE_BLAST_PERK, &bull_ice_blast_precache);
	zm_perks::register_perk_clientfields( 				BULL_ICE_BLAST_PERK, &bull_ice_blast_register_clientfield, &bull_ice_blast_set_clientfield);
	zm_perks::register_perk_machine( 					BULL_ICE_BLAST_PERK, &bull_ice_blast_machine_setup);
	zm_perks::register_perk_threads( 					BULL_ICE_BLAST_PERK, &bull_ice_blast_give_perk, &bull_ice_blast_take_perk);
	zm_perks::register_perk_host_migration_params( 		BULL_ICE_BLAST_PERK, BULL_ICE_BLAST_RADIANT_MACHINE_NAME, BULL_ICE_BLAST_PERK);
	
	zm_utility::register_slowdown ("bull_ice_blast_slowdown", BULL_ICE_BLAST_ZOMBIE_SLOWDOWN_RATE, 1.0);
	
	level._effect["bull_ice_slam_break"] 						= BULL_ICE_BLAST_SLAM_ICE_BREAK_FX;
	level._effect["bull_ice_slam_idle"] 						= BULL_ICE_BLAST_SLAM_ICE_IDLE_FX;
	level._effect["bull_ice_slam_impact"] 						= BULL_ICE_BLAST_SLAM_ICE_IMPACT_FX;
}

function bull_ice_blast_precache()
{
	level.machine_assets[BULL_ICE_BLAST_PERK] 					= SpawnStruct();
	level.machine_assets[BULL_ICE_BLAST_PERK].weapon 			= GetWeapon (BULL_ICE_BLAST_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [BULL_ICE_BLAST_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [BULL_ICE_BLAST_PERK].off_model 	= BULL_ICE_BLAST_MODEL_BUCKET;
		level.machine_assets [BULL_ICE_BLAST_PERK].on_model 	= BULL_ICE_BLAST_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [BULL_ICE_BLAST_PERK]						= BULL_ICE_BLAST_MACHINE_LIGHT_FX;
		level.machine_assets [BULL_ICE_BLAST_PERK].off_model 	= BULL_ICE_BLAST_MACHINE_DISABLED_MODEL;
		level.machine_assets [BULL_ICE_BLAST_PERK].on_model 	= BULL_ICE_BLAST_MACHINE_ACTIVE_MODEL;	
	}
}

function bull_ice_blast_register_clientfield() 
{
	clientfield::register ("clientuimodel", BULL_ICE_BLAST_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function bull_ice_blast_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (BULL_ICE_BLAST_CLIENTFIELD, state);
}

function bull_ice_blast_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= BULL_ICE_BLAST_JINGLE;
	use_trigger.script_string 									= BULL_ICE_BLAST_SCRIPT_STRING;
	use_trigger.script_label 									= BULL_ICE_BLAST_STING;
	use_trigger.target 											= BULL_ICE_BLAST_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= BULL_ICE_BLAST_SCRIPT_STRING;
	perk_machine.targetname 									= BULL_ICE_BLAST_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= BULL_ICE_BLAST_SCRIPT_STRING;
}

function bull_ice_blast_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + BULL_ICE_BLAST_ALIAS);
	
	self notify (BULL_ICE_BLAST_PERK + "_start");
		
	if (BULL_ICE_BLAST_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BULL_ICE_BLAST_SECONDARY_PERKS.size; i++)
			self SetPerk (BULL_ICE_BLAST_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bull_ice_blast = 1;
	self.bull_ice_blast_is_slamming = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = BULL_ICE_BLAST_PERK;
	self notify ("west_perk_purchased");
}

function bull_ice_blast_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + BULL_ICE_BLAST_ALIAS);
	self notify (BULL_ICE_BLAST_PERK + "_stop");
	
	if (BULL_ICE_BLAST_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < BULL_ICE_BLAST_SECONDARY_PERKS.size; i++)
			self UnsetPerk (BULL_ICE_BLAST_SECONDARY_PERKS [i]);
			
	self.west_hasperk_bull_ice_blast = 0;
	self.bull_ice_blast_is_slamming = 0;
}

function bull_ice_blast_host_migration_func()
{
	a_bull_ice_blast_machines = GetEntArray (BULL_ICE_BLAST_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_bull_ice_blast_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == BULL_ICE_BLAST_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (BULL_ICE_BLAST_ALIAS);
		}
	}
}


// ======================================================================================================
// Crack Shot Cremat
// ======================================================================================================

function enable_crack_shot_for_level()
{	
	zm_perks::register_perk_basic_info( 				CRACK_SHOT_PERK, CRACK_SHOT_ALIAS, CRACK_SHOT_COST, CRACK_SHOT_TRIG_STRING, GetWeapon (CRACK_SHOT_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				CRACK_SHOT_PERK, &crack_shot_precache);
	zm_perks::register_perk_clientfields( 				CRACK_SHOT_PERK, &crack_shot_register_clientfield, &crack_shot_set_clientfield);
	zm_perks::register_perk_machine( 					CRACK_SHOT_PERK, &crack_shot_machine_setup);
	zm_perks::register_perk_threads( 					CRACK_SHOT_PERK, &crack_shot_give_perk, &crack_shot_take_perk);
	zm_perks::register_perk_host_migration_params( 		CRACK_SHOT_PERK, CRACK_SHOT_RADIANT_MACHINE_NAME, CRACK_SHOT_PERK);
}

function crack_shot_precache()
{
	level.machine_assets [CRACK_SHOT_PERK] 				= SpawnStruct();
	level.machine_assets [CRACK_SHOT_PERK].weapon 		= GetWeapon (CRACK_SHOT_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [CRACK_SHOT_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [CRACK_SHOT_PERK].off_model 	= CRACK_SHOT_MODEL_BUCKET;
		level.machine_assets [CRACK_SHOT_PERK].on_model 	= CRACK_SHOT_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [CRACK_SHOT_PERK]						= CRACK_SHOT_MACHINE_LIGHT_FX;
		level.machine_assets [CRACK_SHOT_PERK].off_model 	= CRACK_SHOT_MACHINE_DISABLED_MODEL;
		level.machine_assets [CRACK_SHOT_PERK].on_model 	= CRACK_SHOT_MACHINE_ACTIVE_MODEL;	
	}
}

function crack_shot_register_clientfield() 
{
	clientfield::register ("clientuimodel", CRACK_SHOT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function crack_shot_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (CRACK_SHOT_CLIENTFIELD, state);
}

function crack_shot_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= CRACK_SHOT_JINGLE;
	use_trigger.script_string 							= CRACK_SHOT_SCRIPT_STRING;
	use_trigger.script_label 							= CRACK_SHOT_STING;
	use_trigger.target 									= CRACK_SHOT_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= CRACK_SHOT_SCRIPT_STRING;
	perk_machine.targetname 							= CRACK_SHOT_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= CRACK_SHOT_SCRIPT_STRING;
}

function crack_shot_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + CRACK_SHOT_ALIAS);
	
	self notify (CRACK_SHOT_PERK + "_start");	
	
	if (CRACK_SHOT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRACK_SHOT_SECONDARY_PERKS.size; i++)
			self SetPerk (CRACK_SHOT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_crack_shot = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = CRACK_SHOT_PERK;
	self notify ("west_perk_purchased");
}

function crack_shot_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + CRACK_SHOT_ALIAS);
	self notify (CRACK_SHOT_PERK + "_stop");
	
	if (CRACK_SHOT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRACK_SHOT_SECONDARY_PERKS.size; i++)
			self UnsetPerk (CRACK_SHOT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_crack_shot = 0;
}

function crack_shot_host_migration_func()
{
	a_crack_shot_machines = GetEntArray (CRACK_SHOT_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_crack_shot_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == CRACK_SHOT_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (CRACK_SHOT_ALIAS);
		}
	}
}


// ======================================================================================================
// Crusader's Ale
// ======================================================================================================

function enable_crusaders_ale_for_level()
{	
	zm_perks::register_perk_basic_info( 				CRUSADERS_ALE_PERK, CRUSADERS_ALE_ALIAS, CRUSADERS_ALE_COST, CRUSADERS_ALE_TRIG_STRING, GetWeapon (CRUSADERS_ALE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				CRUSADERS_ALE_PERK, &crusaders_ale_precache);
	zm_perks::register_perk_clientfields( 				CRUSADERS_ALE_PERK, &crusaders_ale_register_clientfield, &crusaders_ale_set_clientfield);
	zm_perks::register_perk_machine( 					CRUSADERS_ALE_PERK, &crusaders_ale_machine_setup);
	zm_perks::register_perk_threads( 					CRUSADERS_ALE_PERK, &crusaders_ale_give_perk, &crusaders_ale_take_perk);
	zm_perks::register_perk_host_migration_params( 		CRUSADERS_ALE_PERK, CRUSADERS_ALE_RADIANT_MACHINE_NAME, CRUSADERS_ALE_PERK);
}

function crusaders_ale_precache()
{
	level.machine_assets [CRUSADERS_ALE_PERK] 				= SpawnStruct();
	level.machine_assets [CRUSADERS_ALE_PERK].weapon 		= GetWeapon (CRUSADERS_ALE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [CRUSADERS_ALE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [CRUSADERS_ALE_PERK].off_model = CRUSADERS_ALE_MODEL_BUCKET;
		level.machine_assets [CRUSADERS_ALE_PERK].on_model 	= CRUSADERS_ALE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [CRUSADERS_ALE_PERK]					= CRUSADERS_ALE_MACHINE_LIGHT_FX;
		level.machine_assets [CRUSADERS_ALE_PERK].off_model = CRUSADERS_ALE_MACHINE_DISABLED_MODEL;
		level.machine_assets [CRUSADERS_ALE_PERK].on_model 	= CRUSADERS_ALE_MACHINE_ACTIVE_MODEL;	
	}
}

function crusaders_ale_register_clientfield() 
{
	clientfield::register ("clientuimodel", CRUSADERS_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function crusaders_ale_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (CRUSADERS_ALE_CLIENTFIELD, state);
}

function crusaders_ale_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 								= CRUSADERS_ALE_JINGLE;
	use_trigger.script_string 								= CRUSADERS_ALE_SCRIPT_STRING;
	use_trigger.script_label 								= CRUSADERS_ALE_STING;
	use_trigger.target 										= CRUSADERS_ALE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 								= CRUSADERS_ALE_SCRIPT_STRING;
	perk_machine.targetname 								= CRUSADERS_ALE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 							= CRUSADERS_ALE_SCRIPT_STRING;
}

function crusaders_ale_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + CRUSADERS_ALE_ALIAS);
	
	self notify (CRUSADERS_ALE_PERK + "_start");	
	
	if (CRUSADERS_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRUSADERS_ALE_SECONDARY_PERKS.size; i++)
			self SetPerk (CRUSADERS_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_crusaders_ale = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = CRUSADERS_ALE_PERK;
	self notify ("west_perk_purchased");
}

function crusaders_ale_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + CRUSADERS_ALE_ALIAS);
	self notify (CRUSADERS_ALE_PERK + "_stop");
	
	if (CRUSADERS_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRUSADERS_ALE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (CRUSADERS_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_crusaders_ale = 0;
}

function crusaders_ale_host_migration_func()
{
	a_crusaders_ale_machines = GetEntArray (CRUSADERS_ALE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_crusaders_ale_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == CRUSADERS_ALE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (CRUSADERS_ALE_ALIAS);
		}
	}
}


// ======================================================================================================
// Cryo-Slide Soda
// ======================================================================================================

function enable_cryo_slide_for_level()
{	
	zm_perks::register_perk_basic_info( 				CRYO_SLIDE_PERK, CRYO_SLIDE_ALIAS, CRYO_SLIDE_COST, CRYO_SLIDE_TRIG_STRING, GetWeapon (CRYO_SLIDE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				CRYO_SLIDE_PERK, &cryo_slide_precache);
	zm_perks::register_perk_clientfields( 				CRYO_SLIDE_PERK, &cryo_slide_register_clientfield, &cryo_slide_set_clientfield);
	zm_perks::register_perk_machine( 					CRYO_SLIDE_PERK, &cryo_slide_machine_setup);
	zm_perks::register_perk_threads( 					CRYO_SLIDE_PERK, &cryo_slide_give_perk, &cryo_slide_take_perk);
	zm_perks::register_perk_host_migration_params( 		CRYO_SLIDE_PERK, CRYO_SLIDE_RADIANT_MACHINE_NAME, CRYO_SLIDE_PERK);
	
	zm_utility::register_slowdown ("cryo_slide_freeze", CRYO_SLIDE_FROZEN_RATE, 1.0);
	zm_utility::register_slowdown ("cryo_slide_thaw", CRYO_SLIDE_THAWING_RATE, 1.0);
	
	level.west_melee_perks [level.west_melee_perks.size] 	= CRYO_SLIDE_ALIAS;
}

function cryo_slide_precache()
{
	level.machine_assets [CRYO_SLIDE_PERK] 					= SpawnStruct();
	level.machine_assets [CRYO_SLIDE_PERK].weapon 			= GetWeapon (CRYO_SLIDE_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [CRYO_SLIDE_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [CRYO_SLIDE_PERK].off_model 	= CRYO_SLIDE_MODEL_BUCKET;
		level.machine_assets [CRYO_SLIDE_PERK].on_model 	= CRYO_SLIDE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [CRYO_SLIDE_PERK]						= CRYO_SLIDE_MACHINE_LIGHT_FX;
		level.machine_assets [CRYO_SLIDE_PERK].off_model 	= CRYO_SLIDE_MACHINE_DISABLED_MODEL;
		level.machine_assets [CRYO_SLIDE_PERK].on_model 	= CRYO_SLIDE_MACHINE_ACTIVE_MODEL;	
	}
}

function cryo_slide_register_clientfield() 
{
	clientfield::register ("clientuimodel", CRYO_SLIDE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function cryo_slide_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (CRYO_SLIDE_CLIENTFIELD, state);
}

function cryo_slide_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 								= CRYO_SLIDE_JINGLE;
	use_trigger.script_string 								= CRYO_SLIDE_SCRIPT_STRING;
	use_trigger.script_label 								= CRYO_SLIDE_STING;
	use_trigger.target 										= CRYO_SLIDE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 								= CRYO_SLIDE_SCRIPT_STRING;
	perk_machine.targetname 								= CRYO_SLIDE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 							= CRYO_SLIDE_SCRIPT_STRING;
}

function cryo_slide_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + CRYO_SLIDE_ALIAS);
	
	self notify (CRYO_SLIDE_PERK + "_start");	
	
	if (CRYO_SLIDE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRYO_SLIDE_SECONDARY_PERKS.size; i++)
			self SetPerk (CRYO_SLIDE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_cryo_slide = 1;
	self.cryo_slide_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = CRYO_SLIDE_PERK;
	self notify ("west_perk_purchased");
}

function cryo_slide_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + CRYO_SLIDE_ALIAS);
	self notify (CRYO_SLIDE_PERK + "_stop");
	
	if (CRYO_SLIDE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < CRYO_SLIDE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (CRYO_SLIDE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_cryo_slide = 0;
	self.cryo_slide_cooldown = 0;
	
	if (IsDefined (self.cryo_slide_bar))
		self.cryo_slide_bar Destroy();
		
	if (IsDefined (self.cryo_slide_icon))
		self.cryo_slide_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function cryo_slide_host_migration_func()
{
	a_cryo_slide_machines = GetEntArray (CRYO_SLIDE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_cryo_slide_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == CRYO_SLIDE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (CRYO_SLIDE_ALIAS);
		}
	}
}


// ======================================================================================================
// Death Perception
// ======================================================================================================

function enable_death_perception_for_level()
{	
	zm_perks::register_perk_basic_info( 					DEATH_PERCEPTION_PERK, DEATH_PERCEPTION_ALIAS, DEATH_PERCEPTION_COST, DEATH_PERCEPTION_TRIG_STRING, GetWeapon (DEATH_PERCEPTION_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 					DEATH_PERCEPTION_PERK, &death_perception_precache);
	zm_perks::register_perk_clientfields( 					DEATH_PERCEPTION_PERK, &death_perception_register_clientfield, &death_perception_set_clientfield);
	zm_perks::register_perk_machine( 						DEATH_PERCEPTION_PERK, &death_perception_machine_setup);
	zm_perks::register_perk_threads( 						DEATH_PERCEPTION_PERK, &death_perception_give_perk, &death_perception_take_perk);
	zm_perks::register_perk_host_migration_params( 			DEATH_PERCEPTION_PERK, DEATH_PERCEPTION_RADIANT_MACHINE_NAME, DEATH_PERCEPTION_PERK);
}

function death_perception_precache()
{
	level.machine_assets [DEATH_PERCEPTION_PERK] 			= SpawnStruct();
	level.machine_assets [DEATH_PERCEPTION_PERK].weapon 	= GetWeapon (DEATH_PERCEPTION_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DEATH_PERCEPTION_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DEATH_PERCEPTION_PERK].off_model 	= DEATH_PERCEPTION_MODEL_BUCKET;
		level.machine_assets [DEATH_PERCEPTION_PERK].on_model 	= DEATH_PERCEPTION_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DEATH_PERCEPTION_PERK]					= DEATH_PERCEPTION_MACHINE_LIGHT_FX;
		level.machine_assets [DEATH_PERCEPTION_PERK].off_model 	= DEATH_PERCEPTION_MACHINE_DISABLED_MODEL;
		level.machine_assets [DEATH_PERCEPTION_PERK].on_model 	= DEATH_PERCEPTION_MACHINE_ACTIVE_MODEL;	
	}
}

function death_perception_register_clientfield() 
{
	clientfield::register ("toplayer", DEATH_PERCEPTION_PERK_TOPLAYER_CF, VERSION_SHIP, 1, "int");
	clientfield::register ("clientuimodel", DEATH_PERCEPTION_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function death_perception_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DEATH_PERCEPTION_CLIENTFIELD, state);
}

function death_perception_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= DEATH_PERCEPTION_JINGLE;
	use_trigger.script_string 							= DEATH_PERCEPTION_SCRIPT_STRING;
	use_trigger.script_label 							= DEATH_PERCEPTION_STING;
	use_trigger.target 									= DEATH_PERCEPTION_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DEATH_PERCEPTION_SCRIPT_STRING;
	perk_machine.targetname 							= DEATH_PERCEPTION_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DEATH_PERCEPTION_SCRIPT_STRING;
}

function death_perception_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DEATH_PERCEPTION_ALIAS);
	
	self notify (DEATH_PERCEPTION_PERK + "_start");	
	
	if (DEATH_PERCEPTION_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DEATH_PERCEPTION_SECONDARY_PERKS.size; i++)
			self SetPerk (DEATH_PERCEPTION_SECONDARY_PERKS [i]);
			
	self.west_hasperk_death_perception = 1;
	
	self clientfield::set_to_player (DEATH_PERCEPTION_PERK_TOPLAYER_CF, 1);
			
	self.west_perk_purchase [self.west_perk_purchase.size] = DEATH_PERCEPTION_PERK;
	self notify ("west_perk_purchased");
}

function death_perception_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DEATH_PERCEPTION_ALIAS);
	self notify (DEATH_PERCEPTION_PERK + "_stop");
	
	if (DEATH_PERCEPTION_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DEATH_PERCEPTION_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DEATH_PERCEPTION_SECONDARY_PERKS [i]);
			
	self.west_hasperk_death_perception = 0;
	
	self clientfield::set_to_player (DEATH_PERCEPTION_PERK_TOPLAYER_CF, 0);
}

function death_perception_host_migration_func()
{
	a_death_perception_machines = GetEntArray (DEATH_PERCEPTION_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_death_perception_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DEATH_PERCEPTION_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DEATH_PERCEPTION_ALIAS);
		}
	}
}


// ======================================================================================================
// Divine Ale
// ======================================================================================================

function enable_divine_ale_for_level()
{	
	zm_perks::register_perk_basic_info( 			DIVINE_ALE_PERK, DIVINE_ALE_ALIAS, DIVINE_ALE_COST, DIVINE_ALE_TRIG_STRING, GetWeapon (DIVINE_ALE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 			DIVINE_ALE_PERK, &divine_ale_precache);
	zm_perks::register_perk_clientfields( 			DIVINE_ALE_PERK, &divine_ale_register_clientfield, &divine_ale_set_clientfield);
	zm_perks::register_perk_machine( 				DIVINE_ALE_PERK, &divine_ale_machine_setup);
	zm_perks::register_perk_threads( 				DIVINE_ALE_PERK, &divine_ale_give_perk, &divine_ale_take_perk);
	zm_perks::register_perk_host_migration_params( 	DIVINE_ALE_PERK, DIVINE_ALE_RADIANT_MACHINE_NAME, DIVINE_ALE_PERK);
}

function divine_ale_precache()
{
	level.machine_assets [DIVINE_ALE_PERK] 					= SpawnStruct();
	level.machine_assets [DIVINE_ALE_PERK].weapon 			= GetWeapon (DIVINE_ALE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DIVINE_ALE_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DIVINE_ALE_PERK].off_model 	= DIVINE_ALE_MODEL_BUCKET;
		level.machine_assets [DIVINE_ALE_PERK].on_model 	= DIVINE_ALE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DIVINE_ALE_PERK]						= DIVINE_ALE_MACHINE_LIGHT_FX;
		level.machine_assets [DIVINE_ALE_PERK].off_model 	= DIVINE_ALE_MACHINE_DISABLED_MODEL;
		level.machine_assets [DIVINE_ALE_PERK].on_model 	= DIVINE_ALE_MACHINE_ACTIVE_MODEL;	
	}
}

function divine_ale_register_clientfield() 
{
	clientfield::register ("clientuimodel", DIVINE_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
	clientfield::register ("toplayer", "divine_ale_fx_view", VERSION_SHIP, 1, "int");
    clientfield::register ("allplayers", "divine_ale_fx_world", VERSION_SHIP, 1, "int");
}

function divine_ale_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DIVINE_ALE_CLIENTFIELD, state);
}

function divine_ale_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= DIVINE_ALE_JINGLE;
		use_trigger.script_label 						= DIVINE_ALE_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= DIVINE_ALE_SCRIPT_STRING;
	use_trigger.target 									= DIVINE_ALE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DIVINE_ALE_SCRIPT_STRING;
	perk_machine.targetname 							= DIVINE_ALE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DIVINE_ALE_SCRIPT_STRING;
}

function divine_ale_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DIVINE_ALE_ALIAS);
	
	self notify (DIVINE_ALE_PERK + "_start");	
	
	if (DIVINE_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DIVINE_ALE_SECONDARY_PERKS.size; i++)
			self SetPerk (DIVINE_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_divine_ale = 1;
	self.divine_ale_double_damage = 0;
	self.divine_ale_double_points = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = DIVINE_ALE_PERK;
	self notify ("west_perk_purchased");
}

function divine_ale_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DIVINE_ALE_ALIAS);
	self notify (DIVINE_ALE_PERK + "_stop");
	
	if (DIVINE_ALE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DIVINE_ALE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DIVINE_ALE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_divine_ale = 0;
	self.divine_ale_double_damage = 0;
	self.divine_ale_double_points = 0;
}

function divine_ale_host_migration_func()
{
	a_divine_ale_machines = GetEntArray (DIVINE_ALE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_divine_ale_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DIVINE_ALE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DIVINE_ALE_ALIAS);
		}
	}
}


// ======================================================================================================
// Double Dew
// ======================================================================================================

function enable_double_dew_for_level()
{	
	zm_perks::register_perk_basic_info( 				DOUBLE_DEW_PERK, DOUBLE_DEW_ALIAS, DOUBLE_DEW_COST, DOUBLE_DEW_TRIG_STRING, GetWeapon (DOUBLE_DEW_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				DOUBLE_DEW_PERK, &double_dew_precache);
	zm_perks::register_perk_clientfields( 				DOUBLE_DEW_PERK, &double_dew_register_clientfield, &double_dew_set_clientfield);
	zm_perks::register_perk_machine( 					DOUBLE_DEW_PERK, &double_dew_machine_setup);
	zm_perks::register_perk_threads( 					DOUBLE_DEW_PERK, &double_dew_give_perk, &double_dew_take_perk);
	zm_perks::register_perk_host_migration_params( 		DOUBLE_DEW_PERK, DOUBLE_DEW_RADIANT_MACHINE_NAME, DOUBLE_DEW_PERK);
}

function double_dew_precache()
{
	level.machine_assets [DOUBLE_DEW_PERK] 				= SpawnStruct();
	level.machine_assets [DOUBLE_DEW_PERK].weapon 		= GetWeapon (DOUBLE_DEW_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DOUBLE_DEW_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DOUBLE_DEW_PERK].off_model 	= DOUBLE_DEW_MODEL_BUCKET;
		level.machine_assets [DOUBLE_DEW_PERK].on_model 	= DOUBLE_DEW_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DOUBLE_DEW_PERK]						= DOUBLE_DEW_MACHINE_LIGHT_FX;
		level.machine_assets [DOUBLE_DEW_PERK].off_model 	= DOUBLE_DEW_MACHINE_DISABLED_MODEL;
		level.machine_assets [DOUBLE_DEW_PERK].on_model 	= DOUBLE_DEW_MACHINE_ACTIVE_MODEL;	
	}
}

function double_dew_register_clientfield() 
{
	clientfield::register ("clientuimodel", DOUBLE_DEW_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function double_dew_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DOUBLE_DEW_CLIENTFIELD, state);
}

function double_dew_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= DOUBLE_DEW_JINGLE;
	use_trigger.script_string 							= DOUBLE_DEW_SCRIPT_STRING;
	use_trigger.script_label 							= DOUBLE_DEW_STING;
	use_trigger.target 									= DOUBLE_DEW_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DOUBLE_DEW_SCRIPT_STRING;
	perk_machine.targetname 							= DOUBLE_DEW_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DOUBLE_DEW_SCRIPT_STRING;
}

function double_dew_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DOUBLE_DEW_ALIAS);
	
	self notify (DOUBLE_DEW_PERK + "_start");	
	
	if (DOUBLE_DEW_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLE_DEW_SECONDARY_PERKS.size; i++)
			self SetPerk (DOUBLE_DEW_SECONDARY_PERKS [i]);
			
	self.west_hasperk_double_dew = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = DOUBLE_DEW_PERK;
	self notify ("west_perk_purchased");
}

function double_dew_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DOUBLE_DEW_ALIAS);
	self notify (DOUBLE_DEW_PERK + "_stop");
	
	if (DOUBLE_DEW_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLE_DEW_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DOUBLE_DEW_SECONDARY_PERKS [i]);
			
	self.west_hasperk_double_dew = 0;
}

function double_dew_host_migration_func()
{
	a_double_dew_machines = GetEntArray (DOUBLE_DEW_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_double_dew_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DOUBLE_DEW_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DOUBLE_DEW_ALIAS);
		}
	}
}


// ======================================================================================================
// Double Tap 1.0
// ======================================================================================================

function enable_doubletap1_for_level()
{	
	zm_perks::register_perk_basic_info( 				DOUBLETAP1_PERK, DOUBLETAP1_ALIAS, DOUBLETAP1_COST, DOUBLETAP1_TRIG_STRING, GetWeapon (DOUBLETAP1_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				DOUBLETAP1_PERK, &doubletap1_precache);
	zm_perks::register_perk_clientfields( 				DOUBLETAP1_PERK, &doubletap1_register_clientfield, &doubletap1_set_clientfield);
	zm_perks::register_perk_machine( 					DOUBLETAP1_PERK, &doubletap1_machine_setup);
	zm_perks::register_perk_threads( 					DOUBLETAP1_PERK, &doubletap1_give_perk, &doubletap1_take_perk);
	zm_perks::register_perk_host_migration_params( 		DOUBLETAP1_PERK, DOUBLETAP1_RADIANT_MACHINE_NAME, DOUBLETAP1_PERK);
}

function doubletap1_precache()
{
	level.machine_assets [DOUBLETAP1_PERK] 					= SpawnStruct();
	level.machine_assets [DOUBLETAP1_PERK].weapon 			= GetWeapon (DOUBLETAP1_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DOUBLETAP1_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DOUBLETAP1_PERK].off_model 	= DOUBLETAP1_MODEL_BUCKET;
		level.machine_assets [DOUBLETAP1_PERK].on_model 	= DOUBLETAP1_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DOUBLETAP1_PERK]						= DOUBLETAP1_MACHINE_LIGHT_FX;
		level.machine_assets [DOUBLETAP1_PERK].off_model 	= DOUBLETAP1_MACHINE_DISABLED_MODEL;
		level.machine_assets [DOUBLETAP1_PERK].on_model 	= DOUBLETAP1_MACHINE_ACTIVE_MODEL;	
	}
}

function doubletap1_register_clientfield() 
{
	clientfield::register ("clientuimodel", DOUBLETAP1_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function doubletap1_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DOUBLETAP1_CLIENTFIELD, state);
}

function doubletap1_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= DOUBLETAP1_JINGLE;
	use_trigger.script_string 							= DOUBLETAP1_SCRIPT_STRING;
	use_trigger.script_label 							= DOUBLETAP1_STING;
	use_trigger.target 									= DOUBLETAP1_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DOUBLETAP1_SCRIPT_STRING;
	perk_machine.targetname 							= DOUBLETAP1_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DOUBLETAP1_SCRIPT_STRING;
}

function doubletap1_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DOUBLETAP1_ALIAS);
	
	self notify (DOUBLETAP1_PERK + "_start");	
	
	if (DOUBLETAP1_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLETAP1_SECONDARY_PERKS.size; i++)
			self SetPerk (DOUBLETAP1_SECONDARY_PERKS [i]);
			
	self.west_hasperk_doubletap1 = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = DOUBLETAP1_PERK;
	self notify ("west_perk_purchased");
}

function doubletap1_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DOUBLETAP1_ALIAS);
	self notify (DOUBLETAP1_PERK + "_stop");
	
	if (DOUBLETAP1_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLETAP1_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DOUBLETAP1_SECONDARY_PERKS [i]);
			
	self.west_hasperk_doubletap1 = 0;
}

function doubletap1_host_migration_func()
{
	a_doubletap1_machines = GetEntArray (DOUBLETAP1_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_doubletap1_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DOUBLETAP1_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DOUBLETAP1_ALIAS);
		}
	}
}


// ======================================================================================================
// Double Tap 3.0
// ======================================================================================================

function enable_doubletap3_for_level()
{	
	zm_perks::register_perk_basic_info( 				DOUBLETAP3_PERK, DOUBLETAP3_ALIAS, DOUBLETAP3_COST, DOUBLETAP3_TRIG_STRING, GetWeapon (DOUBLETAP3_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				DOUBLETAP3_PERK, &doubletap3_precache);
	zm_perks::register_perk_clientfields( 				DOUBLETAP3_PERK, &doubletap3_register_clientfield, &doubletap3_set_clientfield);
	zm_perks::register_perk_machine( 					DOUBLETAP3_PERK, &doubletap3_machine_setup);
	zm_perks::register_perk_threads( 					DOUBLETAP3_PERK, &doubletap3_give_perk, &doubletap3_take_perk);
	zm_perks::register_perk_host_migration_params( 		DOUBLETAP3_PERK, DOUBLETAP3_RADIANT_MACHINE_NAME, DOUBLETAP3_PERK);
}

function doubletap3_precache()
{
	level.machine_assets [DOUBLETAP3_PERK] 					= SpawnStruct();
	level.machine_assets [DOUBLETAP3_PERK].weapon 			= GetWeapon (DOUBLETAP3_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DOUBLETAP3_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DOUBLETAP3_PERK].off_model 	= DOUBLETAP3_MODEL_BUCKET;
		level.machine_assets [DOUBLETAP3_PERK].on_model 	= DOUBLETAP3_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DOUBLETAP3_PERK]						= DOUBLETAP3_MACHINE_LIGHT_FX;
		level.machine_assets [DOUBLETAP3_PERK].off_model 	= DOUBLETAP3_MACHINE_DISABLED_MODEL;
		level.machine_assets [DOUBLETAP3_PERK].on_model 	= DOUBLETAP3_MACHINE_ACTIVE_MODEL;	
	}	
}

function doubletap3_register_clientfield() 
{
	clientfield::register ("clientuimodel", DOUBLETAP3_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function doubletap3_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DOUBLETAP3_CLIENTFIELD, state);
}

function doubletap3_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= DOUBLETAP3_JINGLE;
	use_trigger.script_string 							= DOUBLETAP3_SCRIPT_STRING;
	use_trigger.script_label 							= DOUBLETAP3_STING;
	use_trigger.target 									= DOUBLETAP3_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DOUBLETAP3_SCRIPT_STRING;
	perk_machine.targetname 							= DOUBLETAP3_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DOUBLETAP3_SCRIPT_STRING;
}

function doubletap3_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DOUBLETAP3_ALIAS);
	
	self notify (DOUBLETAP3_PERK + "_start");	
	
	if (DOUBLETAP3_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLETAP3_SECONDARY_PERKS.size; i++)
			self SetPerk (DOUBLETAP3_SECONDARY_PERKS [i]);
			
	self.west_hasperk_doubletap3 = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = DOUBLETAP3_PERK;
	self notify ("west_perk_purchased");
}

function doubletap3_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DOUBLETAP3_ALIAS);
	self notify (DOUBLETAP3_PERK + "_stop");
	
	if (DOUBLETAP3_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DOUBLETAP3_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DOUBLETAP3_SECONDARY_PERKS [i]);
			
	self.west_hasperk_doubletap3 = 0;
}

function doubletap3_host_migration_func()
{
	a_doubletap3_machines = GetEntArray (DOUBLETAP3_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_doubletap3_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DOUBLETAP3_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DOUBLETAP3_ALIAS);
		}
	}
}


// ======================================================================================================
// Dying Wish
// ======================================================================================================

function enable_dying_wish_for_level()
{	
	zm_perks::register_perk_basic_info( 				DYING_WISH_PERK, DYING_WISH_ALIAS, DYING_WISH_COST, DYING_WISH_TRIG_STRING, GetWeapon (DYING_WISH_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				DYING_WISH_PERK, &dying_wish_precache);
	zm_perks::register_perk_clientfields( 				DYING_WISH_PERK, &dying_wish_register_clientfield, &dying_wish_set_clientfield);
	zm_perks::register_perk_machine( 					DYING_WISH_PERK, &dying_wish_machine_setup);
	zm_perks::register_perk_threads( 					DYING_WISH_PERK, &dying_wish_give_perk, &dying_wish_take_perk);
	zm_perks::register_perk_host_migration_params( 		DYING_WISH_PERK, DYING_WISH_RADIANT_MACHINE_NAME, DYING_WISH_PERK);
	//zm_perks::register_perk_machine_power_override( 	DYING_WISH_PERK, &dying_wish_host_migration_func);
	
	visionset_mgr::register_info ("visionset", "dying_wish_berserk", 1, 110, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	visionset_mgr::register_info ("overlay", "dying_wish_berserk", 1, 110, 1, 1);
}

function dying_wish_precache()
{
	level.machine_assets [DYING_WISH_PERK] 				= SpawnStruct();
	level.machine_assets [DYING_WISH_PERK].weapon 		= GetWeapon (DYING_WISH_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [DYING_WISH_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [DYING_WISH_PERK].off_model 	= DYING_WISH_MODEL_BUCKET;
		level.machine_assets [DYING_WISH_PERK].on_model 	= DYING_WISH_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [DYING_WISH_PERK]						= DYING_WISH_MACHINE_LIGHT_FX;
		level.machine_assets [DYING_WISH_PERK].off_model 	= DYING_WISH_MACHINE_DISABLED_MODEL;
		level.machine_assets [DYING_WISH_PERK].on_model 	= DYING_WISH_MACHINE_ACTIVE_MODEL;	
	}
}

function dying_wish_register_clientfield() 
{
	clientfield::register ("clientuimodel", DYING_WISH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function dying_wish_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (DYING_WISH_CLIENTFIELD, state);
}

function dying_wish_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= DYING_WISH_JINGLE;
		use_trigger.script_label 						= DYING_WISH_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= DYING_WISH_SCRIPT_STRING;
	use_trigger.target 									= DYING_WISH_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= DYING_WISH_SCRIPT_STRING;
	perk_machine.targetname 							= DYING_WISH_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= DYING_WISH_SCRIPT_STRING;
}

function dying_wish_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + DYING_WISH_ALIAS);
	
	self notify (DYING_WISH_PERK + "_start");	
	
	if (DYING_WISH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DYING_WISH_SECONDARY_PERKS.size; i++)
			self SetPerk (DYING_WISH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_dying_wish = 1;
			
	self.dying_wish_active = 0;
	self.dying_wish_on_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = DYING_WISH_PERK;
	self notify ("west_perk_purchased");
}

function dying_wish_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self notify ("perk_lost", str_perk);
	self notify ("lost_" + DYING_WISH_ALIAS);
	self notify (DYING_WISH_PERK + "_stop");
	
	if (DYING_WISH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < DYING_WISH_SECONDARY_PERKS.size; i++)
			self UnsetPerk (DYING_WISH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_dying_wish = 0;
	
	if (IsDefined (self.dying_wish_active) && self.dying_wish_active == 1)
	{
		visionset_mgr::deactivate ("visionset", "dying_wish_berserk", self);
		visionset_mgr::deactivate ("overlay", "dying_wish_berserk", self);
		
		if (DYING_WISH_PLAY_SOUNDS == 1)
		{
			self StopLoopSound (1);
			self PlaySound ("zmb_bgb_plainsight_end");
		}
	}
	
	self.dying_wish_active = 0;
	self.dying_wish_on_cooldown = 0;
	
	if (IsDefined (self.dying_wish_bar))
		self.dying_wish_bar Destroy();
		
	if (IsDefined (self.dying_wish_icon))
		self.dying_wish_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function dying_wish_host_migration_func()
{
	a_dying_wish_machines = GetEntArray (DYING_WISH_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_dying_wish_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == DYING_WISH_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (DYING_WISH_ALIAS);
		}
	}
}


// ======================================================================================================
// Electric Cherry
// ======================================================================================================

function enable_electric_cherry_for_level()
{	
	zm_perks::register_perk_basic_info( 				ELECTRIC_CHERRY_PERK, ELECTRIC_CHERRY_ALIAS, ELECTRIC_CHERRY_COST, ELECTRIC_CHERRY_TRIG_STRING, GetWeapon (ELECTRIC_CHERRY_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ELECTRIC_CHERRY_PERK, &electric_cherry_precache);
	zm_perks::register_perk_clientfields( 				ELECTRIC_CHERRY_PERK, &electric_cherry_register_clientfield, &electric_cherry_set_clientfield);
	zm_perks::register_perk_machine( 					ELECTRIC_CHERRY_PERK, &electric_cherry_machine_setup);
	zm_perks::register_perk_threads( 					ELECTRIC_CHERRY_PERK, &electric_cherry_give_perk, &electric_cherry_take_perk);
	zm_perks::register_perk_host_migration_params( 		ELECTRIC_CHERRY_PERK, ELECTRIC_CHERRY_RADIANT_MACHINE_NAME, ELECTRIC_CHERRY_PERK);
}

function electric_cherry_precache()
{
	level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME]		= ELECTRIC_CHERRY_FX_EXPLODE_FILE;
	
	level.machine_assets[ELECTRIC_CHERRY_PERK] 			= SpawnStruct();
	level.machine_assets[ELECTRIC_CHERRY_PERK].weapon 	= GetWeapon (ELECTRIC_CHERRY_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ELECTRIC_CHERRY_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ELECTRIC_CHERRY_PERK].off_model 	= ELECTRIC_CHERRY_MODEL_BUCKET;
		level.machine_assets [ELECTRIC_CHERRY_PERK].on_model 	= ELECTRIC_CHERRY_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ELECTRIC_CHERRY_PERK]					= ELECTRIC_CHERRY_MACHINE_LIGHT_FX;
		level.machine_assets [ELECTRIC_CHERRY_PERK].off_model 	= ELECTRIC_CHERRY_MACHINE_DISABLED_MODEL;
		level.machine_assets [ELECTRIC_CHERRY_PERK].on_model 	= ELECTRIC_CHERRY_MACHINE_ACTIVE_MODEL;	
	}
	
	// Perk specific Client Fields
	clientfield::register ("allplayers", 	"electric_cherry_fx_reload", VERSION_SHIP, 2, "int");
	clientfield::register ("actor", 		"electric_cherry_fx_tesla_death", VERSION_SHIP, 1, "int");
	clientfield::register ("vehicle", 		"electric_cherry_fx_tesla_death_vehicle", VERSION_TU10, 1, "int"); // Leave at VERSION_TU10
	clientfield::register ("actor", 		"electric_cherry_fx_tesla_shock_eyes", VERSION_SHIP, 1, "int");
	clientfield::register ("vehicle", 		"electric_cherry_fx_tesla_shock_eyes_vehicle", VERSION_TU10, 1, "int"); // Leave at VERSION_TU10
}

function electric_cherry_register_clientfield() 
{
	clientfield::register ("clientuimodel", ELECTRIC_CHERRY_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function electric_cherry_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ELECTRIC_CHERRY_CLIENTFIELD, state);
}

function electric_cherry_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= ELECTRIC_CHERRY_JINGLE;
		use_trigger.script_label 						= ELECTRIC_CHERRY_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= ELECTRIC_CHERRY_SCRIPT_STRING;
	use_trigger.target 									= ELECTRIC_CHERRY_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ELECTRIC_CHERRY_SCRIPT_STRING;
	perk_machine.targetname 							= ELECTRIC_CHERRY_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ELECTRIC_CHERRY_SCRIPT_STRING;
}

function electric_cherry_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ELECTRIC_CHERRY_ALIAS);
	
	self notify (ELECTRIC_CHERRY_PERK + "_start");	
	
	if (ELECTRIC_CHERRY_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ELECTRIC_CHERRY_SECONDARY_PERKS.size; i++)
			self SetPerk (ELECTRIC_CHERRY_SECONDARY_PERKS [i]);
			
	self.west_hasperk_electric_cherry = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ELECTRIC_CHERRY_PERK;
	self notify ("west_perk_purchased");
}

function electric_cherry_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ELECTRIC_CHERRY_ALIAS);
	self notify (ELECTRIC_CHERRY_PERK + "_stop");
	
	if (ELECTRIC_CHERRY_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ELECTRIC_CHERRY_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ELECTRIC_CHERRY_SECONDARY_PERKS [i]);
	
	if (!self laststand::player_is_in_laststand() && "playing" == self.sessionstate)
		self.west_hasperk_electric_cherry = 0;
}

function electric_cherry_host_migration_func()
{
	a_electric_cherry_machines = GetEntArray (ELECTRIC_CHERRY_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_electric_cherry_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ELECTRIC_CHERRY_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ELECTRIC_CHERRY_ALIAS);
		}
	}
}


// ======================================================================================================
// Elemental Pop
// ======================================================================================================

function enable_elemental_pop_for_level()
{	
	zm_perks::register_perk_basic_info( 				ELEMENTAL_POP_PERK, ELEMENTAL_POP_ALIAS, ELEMENTAL_POP_COST, ELEMENTAL_POP_TRIG_STRING, GetWeapon (ELEMENTAL_POP_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ELEMENTAL_POP_PERK, &elemental_pop_precache);
	zm_perks::register_perk_clientfields( 				ELEMENTAL_POP_PERK, &elemental_pop_register_clientfield, &elemental_pop_set_clientfield);
	zm_perks::register_perk_machine( 					ELEMENTAL_POP_PERK, &elemental_pop_machine_setup);
	zm_perks::register_perk_threads( 					ELEMENTAL_POP_PERK, &elemental_pop_give_perk, &elemental_pop_take_perk);
	zm_perks::register_perk_host_migration_params( 		ELEMENTAL_POP_PERK, ELEMENTAL_POP_RADIANT_MACHINE_NAME, ELEMENTAL_POP_PERK);
}

function elemental_pop_precache()
{
	level.machine_assets[ELEMENTAL_POP_PERK] 					= SpawnStruct();
	level.machine_assets[ELEMENTAL_POP_PERK].weapon 			= GetWeapon (ELEMENTAL_POP_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ELEMENTAL_POP_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ELEMENTAL_POP_PERK].off_model 	= ELEMENTAL_POP_MODEL_BUCKET;
		level.machine_assets [ELEMENTAL_POP_PERK].on_model 		= ELEMENTAL_POP_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ELEMENTAL_POP_PERK]						= ELEMENTAL_POP_MACHINE_LIGHT_FX;
		level.machine_assets [ELEMENTAL_POP_PERK].off_model 	= ELEMENTAL_POP_MACHINE_DISABLED_MODEL;
		level.machine_assets [ELEMENTAL_POP_PERK].on_model 		= ELEMENTAL_POP_MACHINE_ACTIVE_MODEL;	
	}
}

function elemental_pop_register_clientfield() 
{
	clientfield::register ("clientuimodel", ELEMENTAL_POP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function elemental_pop_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ELEMENTAL_POP_CLIENTFIELD, state);
}

function elemental_pop_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= ELEMENTAL_POP_JINGLE;
	use_trigger.script_string 							= ELEMENTAL_POP_SCRIPT_STRING;
	use_trigger.script_label 							= ELEMENTAL_POP_STING;
	use_trigger.target 									= ELEMENTAL_POP_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ELEMENTAL_POP_SCRIPT_STRING;
	perk_machine.targetname 							= ELEMENTAL_POP_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ELEMENTAL_POP_SCRIPT_STRING;
}

function elemental_pop_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ELEMENTAL_POP_ALIAS);
	
	self notify (ELEMENTAL_POP_PERK + "_start");
		
	if (ELEMENTAL_POP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ELEMENTAL_POP_SECONDARY_PERKS.size; i++)
			self SetPerk (ELEMENTAL_POP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_elemental_pop = 1;
	self.elemental_pop_on_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ELEMENTAL_POP_PERK;
	self notify ("west_perk_purchased");
}

function elemental_pop_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ELEMENTAL_POP_ALIAS);
	self notify (ELEMENTAL_POP_PERK + "_stop");
	
	if (ELEMENTAL_POP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ELEMENTAL_POP_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ELEMENTAL_POP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_elemental_pop = 0;
	self.elemental_pop_on_cooldown = 0;
	
	if (IsDefined (self.elemental_pop_bar))
		self.elemental_pop_bar Destroy();
		
	if (IsDefined (self.elemental_pop_icon))
		self.elemental_pop_icon Destroy();
}

function elemental_pop_host_migration_func()
{
	a_elemental_pop_machines = GetEntArray (ELEMENTAL_POP_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_elemental_pop_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ELEMENTAL_POP_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ELEMENTAL_POP_ALIAS);
		}
	}
}


// ======================================================================================================
// Ethereal Razor
// ======================================================================================================

function enable_ethereal_razor_for_level()
{	
	zm_perks::register_perk_basic_info( 			ETHEREAL_RAZOR_PERK, ETHEREAL_RAZOR_ALIAS, ETHEREAL_RAZOR_COST, ETHEREAL_RAZOR_TRIG_STRING, GetWeapon (ETHEREAL_RAZOR_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 			ETHEREAL_RAZOR_PERK, &ethereal_razor_precache);
	zm_perks::register_perk_clientfields( 			ETHEREAL_RAZOR_PERK, &ethereal_razor_register_clientfield, &ethereal_razor_set_clientfield);
	zm_perks::register_perk_machine( 				ETHEREAL_RAZOR_PERK, &ethereal_razor_machine_setup);
	zm_perks::register_perk_threads( 				ETHEREAL_RAZOR_PERK, &ethereal_razor_give_perk, &ethereal_razor_take_perk);
	zm_perks::register_perk_host_migration_params( 	ETHEREAL_RAZOR_PERK, ETHEREAL_RAZOR_RADIANT_MACHINE_NAME, ETHEREAL_RAZOR_PERK);

	zm_utility::register_melee_weapon_for_level (ETHEREAL_RAZOR_KNIFE_WEAPON);
	level.ethereal_razor_knife = GetWeapon (ETHEREAL_RAZOR_KNIFE_WEAPON);
}

function ethereal_razor_precache()
{
	level.machine_assets [ETHEREAL_RAZOR_PERK] 			= SpawnStruct();
	level.machine_assets [ETHEREAL_RAZOR_PERK].weapon 	= GetWeapon (ETHEREAL_RAZOR_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ETHEREAL_RAZOR_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ETHEREAL_RAZOR_PERK].off_model 	= ETHEREAL_RAZOR_MODEL_BUCKET;
		level.machine_assets [ETHEREAL_RAZOR_PERK].on_model 	= ETHEREAL_RAZOR_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ETHEREAL_RAZOR_PERK]						= ETHEREAL_RAZOR_MACHINE_LIGHT_FX;
		level.machine_assets [ETHEREAL_RAZOR_PERK].off_model 	= ETHEREAL_RAZOR_MACHINE_DISABLED_MODEL;
		level.machine_assets [ETHEREAL_RAZOR_PERK].on_model 	= ETHEREAL_RAZOR_MACHINE_ACTIVE_MODEL;	
	}
}

function ethereal_razor_register_clientfield() 
{
	clientfield::register ("clientuimodel", ETHEREAL_RAZOR_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function ethereal_razor_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ETHEREAL_RAZOR_CLIENTFIELD, state);
}

function ethereal_razor_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= ETHEREAL_RAZOR_JINGLE;
		use_trigger.script_label 						= ETHEREAL_RAZOR_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= ETHEREAL_RAZOR_SCRIPT_STRING;
	use_trigger.target 									= ETHEREAL_RAZOR_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ETHEREAL_RAZOR_SCRIPT_STRING;
	perk_machine.targetname 							= ETHEREAL_RAZOR_RADIANT_MACHINE_NAME;
	
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ETHEREAL_RAZOR_SCRIPT_STRING;
}

function ethereal_razor_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ETHEREAL_RAZOR_ALIAS);
	
	self notify (ETHEREAL_RAZOR_PERK + "_start");	
	
	if (ETHEREAL_RAZOR_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ETHEREAL_RAZOR_SECONDARY_PERKS.size; i++)
			self SetPerk (ETHEREAL_RAZOR_SECONDARY_PERKS [i]);
			
	self.west_hasperk_ethereal = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ETHEREAL_RAZOR_PERK;
	self notify ("west_perk_purchased");
}

function ethereal_razor_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ETHEREAL_RAZOR_ALIAS);
	self notify (ETHEREAL_RAZOR_PERK + "_stop");
	
	if (ETHEREAL_RAZOR_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ETHEREAL_RAZOR_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ETHEREAL_RAZOR_SECONDARY_PERKS [i]);
			
	self.west_hasperk_ethereal = 0;
	
	if (self zm_utility::get_player_melee_weapon() == GetWeapon (ETHEREAL_RAZOR_KNIFE_WEAPON))
	{
		self zm_weapons::weapon_take (GetWeapon (ETHEREAL_RAZOR_KNIFE_WEAPON));
		
		WAIT_SERVER_FRAME;
		
		self zm_weapons::weapon_give (level.weaponBaseMelee);
		self zm_utility::set_player_melee_weapon (level.weaponBaseMelee);	
	}
}

function ethereal_razor_host_migration_func()
{
	a_ethereal_razor_machines = GetEntArray (ETHEREAL_RAZOR_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_ethereal_razor_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ETHEREAL_RAZOR_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ETHEREAL_RAZOR_ALIAS);
		}
	}
}


// ======================================================================================================
// Fighter's Fizz
// ======================================================================================================

function enable_fighters_fizz_for_level()
{	
	zm_perks::register_perk_basic_info( 						FIGHTERS_FIZZ_PERK, FIGHTERS_FIZZ_ALIAS, FIGHTERS_FIZZ_COST, FIGHTERS_FIZZ_TRIG_STRING, GetWeapon (FIGHTERS_FIZZ_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 						FIGHTERS_FIZZ_PERK, &fighters_fizz_precache);
	zm_perks::register_perk_clientfields( 						FIGHTERS_FIZZ_PERK, &fighters_fizz_register_clientfield, &fighters_fizz_set_clientfield);
	zm_perks::register_perk_machine( 							FIGHTERS_FIZZ_PERK, &fighters_fizz_machine_setup);
	zm_perks::register_perk_threads( 							FIGHTERS_FIZZ_PERK, &fighters_fizz_give_perk, &fighters_fizz_take_perk);
	zm_perks::register_perk_host_migration_params( 				FIGHTERS_FIZZ_PERK, FIGHTERS_FIZZ_RADIANT_MACHINE_NAME, FIGHTERS_FIZZ_PERK);
}

function fighters_fizz_precache()
{
	level.machine_assets [FIGHTERS_FIZZ_PERK] 					= SpawnStruct();
	level.machine_assets [FIGHTERS_FIZZ_PERK].weapon 			= GetWeapon (FIGHTERS_FIZZ_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [FIGHTERS_FIZZ_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [FIGHTERS_FIZZ_PERK].off_model 	= FIGHTERS_FIZZ_MODEL_BUCKET;
		level.machine_assets [FIGHTERS_FIZZ_PERK].on_model 		= FIGHTERS_FIZZ_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [FIGHTERS_FIZZ_PERK]						= FIGHTERS_FIZZ_MACHINE_LIGHT_FX;
		level.machine_assets [FIGHTERS_FIZZ_PERK].off_model 	= FIGHTERS_FIZZ_MACHINE_DISABLED_MODEL;
		level.machine_assets [FIGHTERS_FIZZ_PERK].on_model 		= FIGHTERS_FIZZ_MACHINE_ACTIVE_MODEL;	
	}
}

function fighters_fizz_register_clientfield() 
{
	clientfield::register ("clientuimodel", FIGHTERS_FIZZ_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function fighters_fizz_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (FIGHTERS_FIZZ_CLIENTFIELD, state);
}

function fighters_fizz_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= FIGHTERS_FIZZ_JINGLE;
	use_trigger.script_string 									= FIGHTERS_FIZZ_SCRIPT_STRING;
	use_trigger.script_label 									= FIGHTERS_FIZZ_STING;
	use_trigger.target 											= FIGHTERS_FIZZ_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= FIGHTERS_FIZZ_SCRIPT_STRING;
	perk_machine.targetname 									= FIGHTERS_FIZZ_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= FIGHTERS_FIZZ_SCRIPT_STRING;
}

function fighters_fizz_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + FIGHTERS_FIZZ_ALIAS);
	
	self notify (FIGHTERS_FIZZ_PERK + "_start");	
	
	if (FIGHTERS_FIZZ_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < FIGHTERS_FIZZ_SECONDARY_PERKS.size; i++)
			self SetPerk (FIGHTERS_FIZZ_SECONDARY_PERKS [i]);
			
	self.west_hasperk_fighters_fizz = 1;
	
	level zm_utility::increment_no_end_game_check();
	
	self.west_perk_purchase [self.west_perk_purchase.size] = FIGHTERS_FIZZ_PERK;
	self notify ("west_perk_purchased");
}

function fighters_fizz_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + FIGHTERS_FIZZ_ALIAS);
	self notify (FIGHTERS_FIZZ_PERK + "_stop");
	
	if (FIGHTERS_FIZZ_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < FIGHTERS_FIZZ_SECONDARY_PERKS.size; i++)
			self UnsetPerk (FIGHTERS_FIZZ_SECONDARY_PERKS [i]);
			
	if (!self laststand::player_is_in_laststand() && "playing" == self.sessionstate)
		self.west_hasperk_fighters_fizz = 0;
}

function fighters_fizz_host_migration_func()
{
	a_fighters_fizz_machines = GetEntArray (FIGHTERS_FIZZ_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_fighters_fizz_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == FIGHTERS_FIZZ_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (FIGHTERS_FIZZ_ALIAS);
		}
	}
}


// ======================================================================================================
// Gambler's Gibson
// ======================================================================================================

function enable_gamblers_gibson_for_level()
{	
	zm_perks::register_perk_basic_info( 			GAMBLERS_GIBSON_PERK, GAMBLERS_GIBSON_ALIAS, GAMBLERS_GIBSON_COST, GAMBLERS_GIBSON_TRIG_STRING, GetWeapon (GAMBLERS_GIBSON_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 			GAMBLERS_GIBSON_PERK, &gamblers_gibson_precache);
	zm_perks::register_perk_clientfields( 			GAMBLERS_GIBSON_PERK, &gamblers_gibson_register_clientfield, &gamblers_gibson_set_clientfield);
	zm_perks::register_perk_machine( 				GAMBLERS_GIBSON_PERK, &gamblers_gibson_machine_setup);
	zm_perks::register_perk_threads( 				GAMBLERS_GIBSON_PERK, &gamblers_gibson_give_perk, &gamblers_gibson_take_perk);
	zm_perks::register_perk_host_migration_params( 	GAMBLERS_GIBSON_PERK, GAMBLERS_GIBSON_RADIANT_MACHINE_NAME, GAMBLERS_GIBSON_PERK);
}

function gamblers_gibson_precache()
{
	level.machine_assets [GAMBLERS_GIBSON_PERK] 				= SpawnStruct();
	level.machine_assets [GAMBLERS_GIBSON_PERK].weapon 			= GetWeapon (GAMBLERS_GIBSON_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [GAMBLERS_GIBSON_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [GAMBLERS_GIBSON_PERK].off_model 	= GAMBLERS_GIBSON_MODEL_BUCKET;
		level.machine_assets [GAMBLERS_GIBSON_PERK].on_model 	= GAMBLERS_GIBSON_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [GAMBLERS_GIBSON_PERK]					= GAMBLERS_GIBSON_MACHINE_LIGHT_FX;
		level.machine_assets [GAMBLERS_GIBSON_PERK].off_model 	= GAMBLERS_GIBSON_MACHINE_DISABLED_MODEL;
		level.machine_assets [GAMBLERS_GIBSON_PERK].on_model 	= GAMBLERS_GIBSON_MACHINE_ACTIVE_MODEL;	
	}
}

function gamblers_gibson_register_clientfield() 
{
	clientfield::register ("clientuimodel", GAMBLERS_GIBSON_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function gamblers_gibson_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (GAMBLERS_GIBSON_CLIENTFIELD, state);
}

function gamblers_gibson_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= GAMBLERS_GIBSON_JINGLE;
	use_trigger.script_string 									= GAMBLERS_GIBSON_SCRIPT_STRING;
	use_trigger.script_label 									= GAMBLERS_GIBSON_STING;
	use_trigger.target 											= GAMBLERS_GIBSON_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= GAMBLERS_GIBSON_SCRIPT_STRING;
	perk_machine.targetname 									= GAMBLERS_GIBSON_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= GAMBLERS_GIBSON_SCRIPT_STRING;
}

function gamblers_gibson_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + GAMBLERS_GIBSON_ALIAS);
	
	self notify (GAMBLERS_GIBSON_PERK + "_start");	
	
	if (GAMBLERS_GIBSON_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < GAMBLERS_GIBSON_SECONDARY_PERKS.size; i++)
			self SetPerk (GAMBLERS_GIBSON_SECONDARY_PERKS [i]);
			
	self.west_hasperk_gamblers = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = GAMBLERS_GIBSON_PERK;
	self notify ("west_perk_purchased");
}

function gamblers_gibson_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + GAMBLERS_GIBSON_ALIAS);
	self notify (GAMBLERS_GIBSON_PERK + "_stop");
	
	if (GAMBLERS_GIBSON_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < GAMBLERS_GIBSON_SECONDARY_PERKS.size; i++)
			self UnsetPerk (GAMBLERS_GIBSON_SECONDARY_PERKS [i]);
			
	self.west_hasperk_gamblers = 0;
}

function gamblers_gibson_host_migration_func()
{
	a_gamblers_gibson_machines = GetEntArray (GAMBLERS_GIBSON_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_gamblers_gibson_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == GAMBLERS_GIBSON_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (GAMBLERS_GIBSON_ALIAS);
		}
	}
}


// ======================================================================================================
// Glitching Gin
// ======================================================================================================
function enable_glitching_gin_for_level()
{	
	zm_perks::register_perk_basic_info( 				GLITCHING_GIN_PERK, GLITCHING_GIN_ALIAS, GLITCHING_GIN_COST, GLITCHING_GIN_TRIG_STRING, GetWeapon (GLITCHING_GIN_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				GLITCHING_GIN_PERK, &glitching_gin_precache);
	zm_perks::register_perk_clientfields( 				GLITCHING_GIN_PERK, &glitching_gin_register_clientfield, &glitching_gin_set_clientfield);
	zm_perks::register_perk_machine( 					GLITCHING_GIN_PERK, &glitching_gin_machine_setup);
	zm_perks::register_perk_threads( 					GLITCHING_GIN_PERK, &glitching_gin_give_perk, &glitching_gin_take_perk);
	zm_perks::register_perk_host_migration_params( 		GLITCHING_GIN_PERK, GLITCHING_GIN_RADIANT_MACHINE_NAME, GLITCHING_GIN_PERK);
}

function glitching_gin_precache()
{
	level.machine_assets[GLITCHING_GIN_PERK] 			= SpawnStruct();
	level.machine_assets[GLITCHING_GIN_PERK].weapon		= GetWeapon (GLITCHING_GIN_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [GLITCHING_GIN_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [GLITCHING_GIN_PERK].off_model = GLITCHING_GIN_MODEL_BUCKET;
		level.machine_assets [GLITCHING_GIN_PERK].on_model 	= GLITCHING_GIN_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [GLITCHING_GIN_PERK]					= GLITCHING_GIN_MACHINE_LIGHT_FX;
		level.machine_assets [GLITCHING_GIN_PERK].off_model = GLITCHING_GIN_MACHINE_DISABLED_MODEL;
		level.machine_assets [GLITCHING_GIN_PERK].on_model 	= GLITCHING_GIN_MACHINE_ACTIVE_MODEL;	
	}
}

function glitching_gin_register_clientfield() 
{
	clientfield::register ("clientuimodel", GLITCHING_GIN_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
	clientfield::register("scriptmover", "glitch_grenade_fx", VERSION_SHIP, 2, "int");
}

function glitching_gin_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (GLITCHING_GIN_CLIENTFIELD, state);
}

function glitching_gin_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= GLITCHING_GIN_JINGLE;
	use_trigger.script_string 							= GLITCHING_GIN_SCRIPT_STRING;
	use_trigger.script_label 							= GLITCHING_GIN_STING;
	use_trigger.target 									= GLITCHING_GIN_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= GLITCHING_GIN_SCRIPT_STRING;
	perk_machine.targetname 							= GLITCHING_GIN_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= GLITCHING_GIN_SCRIPT_STRING;
}

function glitching_gin_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + GLITCHING_GIN_ALIAS);
	
	self notify (GLITCHING_GIN_PERK + "_start");	
	
	if (GLITCHING_GIN_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < GLITCHING_GIN_SECONDARY_PERKS.size; i++)
			self SetPerk (GLITCHING_GIN_SECONDARY_PERKS [i]);
			
	self.west_hasperk_glitching_gin = 1;
	
	//If Glitching Gin uses Lethal slot, remove Widows Wine
	if ((IsDefined (self.west_hasperk_widows_wine) && self.west_hasperk_widows_wine == 1) && GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		self widows_wine_take_perk (false, WIDOWS_WINE_PERK + "_stop", WIDOWS_WINE_PERK + "_stop");
			
	self.west_perk_purchase [self.west_perk_purchase.size] = GLITCHING_GIN_PERK;
	self notify ("west_perk_purchased");
}

function glitching_gin_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + GLITCHING_GIN_ALIAS);
	self notify (GLITCHING_GIN_PERK + "_stop");
	
	if (GLITCHING_GIN_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < GLITCHING_GIN_SECONDARY_PERKS.size; i++)
			self UnsetPerk (GLITCHING_GIN_SECONDARY_PERKS [i]);
			
	self.west_hasperk_glitching_gin = 0;
	
	if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		current_grenade = self zm_utility::get_player_tactical_grenade();
		
	else
		current_grenade = self zm_utility::get_player_lethal_grenade();
	
	if (IsDefined (current_grenade))
		self zm_weapons::weapon_take (current_grenade);
	
	WAIT_SERVER_FRAME;

	if (IsDefined (self.w_glitching_gin_prev))
	{
		self zm_weapons::weapon_give (self.w_glitching_gin_prev, false, false, true, false);
		
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			self.lsgsar_tactical = self.w_glitching_gin_prev;
			self zm_utility::set_player_tactical_grenade (self.w_glitching_gin_prev);
			grenade = self zm_utility::get_player_tactical_grenade();
		}
			
		else
		{
			self.lsgsar_lethal = self.w_glitching_gin_prev;
			self zm_utility::set_player_lethal_grenade (self.w_glitching_gin_prev);
			grenade = self zm_utility::get_player_lethal_grenade();
		}
	}
	
	else
	{
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			self zm_weapons::weapon_give (level.zombie_tactical_grenade_player_init, false, false, true, false);
			self.lsgsar_tactical = level.zombie_tactical_grenade_player_init;
			self zm_utility::set_player_tactical_grenade (level.zombie_tactical_grenade_player_init);
			grenade = self zm_utility::get_player_tactical_grenade();
		}
			
		else
		{
			self zm_weapons::weapon_give (level.zombie_lethal_grenade_player_init, false, false, true, false);
			self.lsgsar_lethal = level.zombie_lethal_grenade_player_init;
			self zm_utility::set_player_lethal_grenade (level.zombie_lethal_grenade_player_init);
			grenade = self zm_utility::get_player_lethal_grenade();
		}
	}	
	
	if (IsDefined (grenade))
		self GiveStartAmmo (grenade);
}

function glitching_gin_host_migration_func()
{
	a_glitching_gin_machines = GetEntArray (GLITCHING_GIN_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_glitching_gin_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == GLITCHING_GIN_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (GLITCHING_GIN_ALIAS);
		}
	}
}


// ======================================================================================================
// I.C.U.
// ======================================================================================================

function enable_icu_for_level()
{	
	zm_perks::register_perk_basic_info( 				ICU_PERK, ICU_ALIAS, ICU_COST, ICU_TRIG_STRING, GetWeapon (ICU_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ICU_PERK, &icu_precache);
	zm_perks::register_perk_clientfields( 				ICU_PERK, &icu_register_clientfield, &icu_set_clientfield);
	zm_perks::register_perk_machine( 					ICU_PERK, &icu_machine_setup);
	zm_perks::register_perk_threads( 					ICU_PERK, &icu_give_perk, &icu_take_perk);
	zm_perks::register_perk_host_migration_params( 		ICU_PERK, ICU_RADIANT_MACHINE_NAME, ICU_PERK);
}

function icu_precache()
{
	level.machine_assets [ICU_PERK] 					= SpawnStruct();
	level.machine_assets [ICU_PERK].weapon 				= GetWeapon (ICU_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ICU_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ICU_PERK].off_model 		= ICU_MODEL_BUCKET;
		level.machine_assets [ICU_PERK].on_model 		= ICU_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ICU_PERK]						= ICU_MACHINE_LIGHT_FX;
		level.machine_assets [ICU_PERK].off_model 		= ICU_MACHINE_DISABLED_MODEL;
		level.machine_assets [ICU_PERK].on_model 		= ICU_MACHINE_ACTIVE_MODEL;	
	}
}

function icu_register_clientfield() 
{
	clientfield::register ("clientuimodel", ICU_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function icu_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ICU_CLIENTFIELD, state);
}

function icu_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= ICU_JINGLE;
	use_trigger.script_string 							= ICU_SCRIPT_STRING;
	use_trigger.script_label 							= ICU_STING;
	use_trigger.target 									= ICU_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ICU_SCRIPT_STRING;
	perk_machine.targetname 							= ICU_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ICU_SCRIPT_STRING;
}

function icu_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ICU_ALIAS);
	
	self notify (ICU_PERK + "_start");	
	
	if (ICU_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ICU_SECONDARY_PERKS.size; i++)
			self SetPerk (ICU_SECONDARY_PERKS [i]);
			
	self.west_hasperk_icu = 1;
	self.icu_invincible = 0;
	self.icu_should_boost = 0;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = ICU_PERK;
	self notify ("west_perk_purchased");
}

function icu_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ICU_ALIAS);
	self notify (ICU_PERK + "_stop");
	
	if (ICU_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ICU_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ICU_SECONDARY_PERKS [i]);
			
	self.west_hasperk_icu = 0;
	self.icu_invincible = 0;
	self.icu_should_boost = 0;
}

function icu_host_migration_func()
{
	a_icu_machines = GetEntArray (ICU_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_icu_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ICU_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ICU_ALIAS);
		}
	}
}


// ======================================================================================================
// Madgaz Moonshine
// ======================================================================================================

function enable_madgaz_moonshine_for_level()
{	
	zm_perks::register_perk_basic_info( 				MADGAZ_MOONSHINE_PERK, MADGAZ_MOONSHINE_ALIAS, MADGAZ_MOONSHINE_COST, MADGAZ_MOONSHINE_TRIG_STRING, GetWeapon (MADGAZ_MOONSHINE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_precache);
	zm_perks::register_perk_clientfields( 				MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_register_clientfield, &madgaz_moonshine_set_clientfield);
	zm_perks::register_perk_machine( 					MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_machine_setup);
	zm_perks::register_perk_threads( 					MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_give_perk, &madgaz_moonshine_take_perk);
	zm_perks::register_perk_host_migration_params( 		MADGAZ_MOONSHINE_PERK, MADGAZ_MOONSHINE_RADIANT_MACHINE_NAME, MADGAZ_MOONSHINE_PERK);
}

function madgaz_moonshine_precache()
{
	level.machine_assets [MADGAZ_MOONSHINE_PERK] 				= SpawnStruct();
	level.machine_assets [MADGAZ_MOONSHINE_PERK].weapon 		= GetWeapon (MADGAZ_MOONSHINE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [MADGAZ_MOONSHINE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [MADGAZ_MOONSHINE_PERK].off_model 	= MADGAZ_MOONSHINE_MODEL_BUCKET;
		level.machine_assets [MADGAZ_MOONSHINE_PERK].on_model 	= MADGAZ_MOONSHINE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [MADGAZ_MOONSHINE_PERK]					= MADGAZ_MOONSHINE_MACHINE_LIGHT_FX;
		level.machine_assets [MADGAZ_MOONSHINE_PERK].off_model 	= MADGAZ_MOONSHINE_MACHINE_DISABLED_MODEL;
		level.machine_assets [MADGAZ_MOONSHINE_PERK].on_model 	= MADGAZ_MOONSHINE_MACHINE_ACTIVE_MODEL;	
	}
}

function madgaz_moonshine_register_clientfield() 
{
	clientfield::register ("clientuimodel", MADGAZ_MOONSHINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function madgaz_moonshine_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (MADGAZ_MOONSHINE_CLIENTFIELD, state);
}

function madgaz_moonshine_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= MADGAZ_MOONSHINE_JINGLE;
	use_trigger.script_string 									= MADGAZ_MOONSHINE_SCRIPT_STRING;
	use_trigger.script_label 									= MADGAZ_MOONSHINE_STING;
	use_trigger.target 											= MADGAZ_MOONSHINE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= MADGAZ_MOONSHINE_SCRIPT_STRING;
	perk_machine.targetname 									= MADGAZ_MOONSHINE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= MADGAZ_MOONSHINE_SCRIPT_STRING;
}

function madgaz_moonshine_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + MADGAZ_MOONSHINE_ALIAS);
	
	self notify (MADGAZ_MOONSHINE_PERK + "_start");	
	
	if (MADGAZ_MOONSHINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MADGAZ_MOONSHINE_SECONDARY_PERKS.size; i++)
			self SetPerk (MADGAZ_MOONSHINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_madgaz_moonshine = 1;
	self.madgaz_moonshine_explosion_count = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = MADGAZ_MOONSHINE_PERK;
	self notify ("west_perk_purchased");
}

function madgaz_moonshine_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + MADGAZ_MOONSHINE_ALIAS);
	self notify (MADGAZ_MOONSHINE_PERK + "_stop");
	
	if (MADGAZ_MOONSHINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MADGAZ_MOONSHINE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (MADGAZ_MOONSHINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_madgaz_moonshine = 0;
	self.madgaz_moonshine_explosion_count = 0;
}

function madgaz_moonshine_host_migration_func()
{
	a_madgaz_moonshine_machines = GetEntArray (MADGAZ_MOONSHINE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_madgaz_moonshine_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == MADGAZ_MOONSHINE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (MADGAZ_MOONSHINE_ALIAS);
		}
	}
}


// ======================================================================================================
// Magnet Mule
// ======================================================================================================

function enable_magnet_for_level()
{
	zm_perks::register_perk_basic_info( 				MAGNET_PERK, MAGNET_ALIAS, MAGNET_COST, MAGNET_TRIG_STRING, GetWeapon (MAGNET_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				MAGNET_PERK, &magnet_precache);
	zm_perks::register_perk_clientfields( 				MAGNET_PERK, &magnet_register_clientfield, &magnet_set_clientfield);
	zm_perks::register_perk_machine( 					MAGNET_PERK, &magnet_machine_setup);
	zm_perks::register_perk_threads( 					MAGNET_PERK, &magnet_give_perk, &magnet_take_perk);
	zm_perks::register_perk_host_migration_params( 		MAGNET_PERK, MAGNET_RADIANT_MACHINE_NAME, 	MAGNET_PERK);
	//zm_perks::register_perk_machine_power_override( 	MAGNET_PERK, &magnet_host_migration_func);
}

function magnet_precache()
{
	level.machine_assets [MAGNET_PERK] 							= SpawnStruct();
	level.machine_assets [MAGNET_PERK].weapon 					= GetWeapon (MAGNET_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [MAGNET_PERK]								= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [MAGNET_PERK].off_model 			= MAGNET_MODEL_BUCKET;
		level.machine_assets [MAGNET_PERK].on_model 			= MAGNET_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [MAGNET_PERK]								= MAGNET_MACHINE_LIGHT_FX;
		level.machine_assets [MAGNET_PERK].off_model 			= MAGNET_MACHINE_DISABLED_MODEL;
		level.machine_assets [MAGNET_PERK].on_model 			= MAGNET_MACHINE_ACTIVE_MODEL;
		level.machine_assets [MAGNET_PERK].power_on_callback 	= &magnet_perk_power_on_cb;
		level.machine_assets [MAGNET_PERK].power_off_callback 	= &magnet_perk_power_off_cb;		
	}
}

function magnet_perk_power_off_cb()
{
	//SELF == PERK MACHINE
	
	self UseAnimTree( #animtree);
	self animation::first_frame (MAGNET_MACHINE_ANIM_OFF);
}

function magnet_perk_power_on_cb()
{
	//SELF == PERK MACHINE
	
	self UseAnimTree( #animtree);
	self thread animation::play (MAGNET_MACHINE_ANIM_INIT, undefined, undefined, undefined, 1, .75);
	wait GetAnimLength (MAGNET_MACHINE_ANIM_INIT);
	self thread animation::play (MAGNET_MACHINE_ANIM_LOOP);
}

function magnet_register_clientfield() 
{
	clientfield::register( "clientuimodel", MAGNET_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function magnet_set_clientfield( state ) 
{
	self clientfield::set_player_uimodel( MAGNET_CLIENTFIELD, state);
}

function magnet_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 					= MAGNET_JINGLE;
	use_trigger.script_string 					= MAGNET_SCRIPT_STRING;
	use_trigger.script_label 					= MAGNET_STING;
	use_trigger.target 							= MAGNET_RADIANT_MACHINE_NAME;
	perk_machine.script_string 					= MAGNET_SCRIPT_STRING;
	perk_machine.targetname 					= MAGNET_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 				= MAGNET_SCRIPT_STRING;
	
}

function magnet_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + MAGNET_ALIAS);
	
	self notify(MAGNET_PERK + "_start");	
	
	if (MAGNET_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MAGNET_SECONDARY_PERKS.size; i++)
			self SetPerk (MAGNET_SECONDARY_PERKS [i]);
			
	self.west_hasperk_magnet = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = MAGNET_PERK;
	
	self notify ("west_perk_purchased");
}

function magnet_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + MAGNET_ALIAS);
	self notify (MAGNET_PERK + "_stop");
	
	if (MAGNET_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MAGNET_SECONDARY_PERKS.size; i++)
			self UnsetPerk (MAGNET_SECONDARY_PERKS [i]);
			
	self.west_hasperk_magnet = 0;
}

function magnet_host_migration_func()
{
	a_magnet_machines = GetEntArray( MAGNET_RADIANT_MACHINE_NAME, "targetname");
	
	foreach ( perk_machine in a_magnet_machines )
	{
		if ( IsDefined ( perk_machine.model ) && perk_machine.model == MAGNET_MACHINE_ACTIVE_MODEL )
		{
			perk_machine zm_perks::perk_fx( undefined, 1);
			perk_machine thread zm_perks::perk_fx( MAGNET_ALIAS);
		}
	}
}


// ======================================================================================================
// Masochist's Malecon
// ======================================================================================================

function enable_masochist_for_level()
{	
	zm_perks::register_perk_basic_info( 				MASOCHIST_PERK, MASOCHIST_ALIAS, MASOCHIST_COST, MASOCHIST_TRIG_STRING, GetWeapon (MASOCHIST_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				MASOCHIST_PERK, &masochist_precache);
	zm_perks::register_perk_clientfields( 				MASOCHIST_PERK, &masochist_register_clientfield, &masochist_set_clientfield);
	zm_perks::register_perk_machine( 					MASOCHIST_PERK, &masochist_machine_setup);
	zm_perks::register_perk_threads( 					MASOCHIST_PERK, &masochist_give_perk, &masochist_take_perk);
	zm_perks::register_perk_host_migration_params( 		MASOCHIST_PERK, MASOCHIST_RADIANT_MACHINE_NAME, MASOCHIST_PERK);
}

function masochist_precache()
{
	level.machine_assets [MASOCHIST_PERK] 				= SpawnStruct();
	level.machine_assets [MASOCHIST_PERK].weapon 		= GetWeapon (MASOCHIST_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [MASOCHIST_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [MASOCHIST_PERK].off_model 	= MASOCHIST_MODEL_BUCKET;
		level.machine_assets [MASOCHIST_PERK].on_model 		= MASOCHIST_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [MASOCHIST_PERK]						= MASOCHIST_MACHINE_LIGHT_FX;
		level.machine_assets [MASOCHIST_PERK].off_model 	= MASOCHIST_MACHINE_DISABLED_MODEL;
		level.machine_assets [MASOCHIST_PERK].on_model 		= MASOCHIST_MACHINE_ACTIVE_MODEL;	
	}
}

function masochist_register_clientfield() 
{
	clientfield::register ("clientuimodel", MASOCHIST_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function masochist_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (MASOCHIST_CLIENTFIELD, state);
}

function masochist_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= MASOCHIST_JINGLE;
	use_trigger.script_string 							= MASOCHIST_SCRIPT_STRING;
	use_trigger.script_label 							= MASOCHIST_STING;
	use_trigger.target 									= MASOCHIST_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= MASOCHIST_SCRIPT_STRING;
	perk_machine.targetname 							= MASOCHIST_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= MASOCHIST_SCRIPT_STRING;
}

function masochist_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + MASOCHIST_ALIAS);
	
	self notify (MASOCHIST_PERK + "_start");	
	
	if (MASOCHIST_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MASOCHIST_SECONDARY_PERKS.size; i++)
			self SetPerk (MASOCHIST_SECONDARY_PERKS [i]);
			
	self.west_hasperk_masochist = 1;
	self.masochist_should_boost = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = MASOCHIST_PERK;
	self notify ("west_perk_purchased");
}

function masochist_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + MASOCHIST_ALIAS);
	self notify (MASOCHIST_PERK + "_stop");
	
	if (MASOCHIST_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MASOCHIST_SECONDARY_PERKS.size; i++)
			self UnsetPerk (MASOCHIST_SECONDARY_PERKS [i]);
			
	self.west_hasperk_masochist = 0;
	self.masochist_should_boost = 0;
}

function masochist_host_migration_func()
{
	a_masochist_machines = GetEntArray (MASOCHIST_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_masochist_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == MASOCHIST_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (MASOCHIST_ALIAS);
		}
	}
}


// ======================================================================================================
// Medusa's Mauresque
// ======================================================================================================

function enable_medusas_mauresque_for_level()
{	
	zm_perks::register_perk_basic_info( 				MEDUSAS_MAURESQUE_PERK, MEDUSAS_MAURESQUE_ALIAS, MEDUSAS_MAURESQUE_COST, MEDUSAS_MAURESQUE_TRIG_STRING, GetWeapon (MEDUSAS_MAURESQUE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_precache);
	zm_perks::register_perk_clientfields( 				MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_register_clientfield, &medusas_mauresque_set_clientfield);
	zm_perks::register_perk_machine( 					MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_machine_setup);
	zm_perks::register_perk_threads( 					MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_give_perk, &medusas_mauresque_take_perk);
	zm_perks::register_perk_host_migration_params( 		MEDUSAS_MAURESQUE_PERK, MEDUSAS_MAURESQUE_RADIANT_MACHINE_NAME, MEDUSAS_MAURESQUE_PERK);
	
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_1", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 49, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_2", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 48, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_3", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 47, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_4", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 46, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_5", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 45, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_6", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 44, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_7", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 43, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_8", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 42, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_9", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 41, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_10", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 40, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_11", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 39, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_12", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 38, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_13", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 37, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_14", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 36, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_15", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 35, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_16", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 34, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_17", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 33, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_18", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 32, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_19", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 31, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_20", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 30, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_21", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 29, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_22", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 28, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_23", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 27, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_24", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 26, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_25", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 25, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_26", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 24, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_27", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 23, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_28", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 22, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_29", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 21, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_30", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 20, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_31", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 19, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_32", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 18, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_33", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 17, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_34", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 16, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_35", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 15, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_36", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 14, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_37", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 13, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_38", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 12, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_39", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 11, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_40", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 10, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_41", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 9, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_42", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 8, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_43", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 7, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_44", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 6, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_45", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 5, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_46", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 4, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_47", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 3, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_48", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE * 2, 1.0);
	zm_utility::register_slowdown ("medusas_mauresque_slowdown_49", MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE, 1.0);
}

function medusas_mauresque_precache()
{
	level.machine_assets [MEDUSAS_MAURESQUE_PERK] 					= SpawnStruct();
	level.machine_assets [MEDUSAS_MAURESQUE_PERK].weapon 			= GetWeapon (MEDUSAS_MAURESQUE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [MEDUSAS_MAURESQUE_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [MEDUSAS_MAURESQUE_PERK].off_model 	= MEDUSAS_MAURESQUE_MODEL_BUCKET;
		level.machine_assets [MEDUSAS_MAURESQUE_PERK].on_model 		= MEDUSAS_MAURESQUE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [MEDUSAS_MAURESQUE_PERK]						= MEDUSAS_MAURESQUE_MACHINE_LIGHT_FX;
		level.machine_assets [MEDUSAS_MAURESQUE_PERK].off_model 	= MEDUSAS_MAURESQUE_MACHINE_DISABLED_MODEL;
		level.machine_assets [MEDUSAS_MAURESQUE_PERK].on_model 		= MEDUSAS_MAURESQUE_MACHINE_ACTIVE_MODEL;	
	}
}

function medusas_mauresque_register_clientfield() 
{
	clientfield::register ("clientuimodel", MEDUSAS_MAURESQUE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function medusas_mauresque_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (MEDUSAS_MAURESQUE_CLIENTFIELD, state);
}

function medusas_mauresque_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= MEDUSAS_MAURESQUE_JINGLE;
	use_trigger.script_string 							= MEDUSAS_MAURESQUE_SCRIPT_STRING;
	use_trigger.script_label 							= MEDUSAS_MAURESQUE_STING;
	use_trigger.target 									= MEDUSAS_MAURESQUE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= MEDUSAS_MAURESQUE_SCRIPT_STRING;
	perk_machine.targetname 							= MEDUSAS_MAURESQUE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= MEDUSAS_MAURESQUE_SCRIPT_STRING;
}

function medusas_mauresque_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + MEDUSAS_MAURESQUE_ALIAS);
	
	self notify (MEDUSAS_MAURESQUE_PERK + "_start");	
	
	if (MEDUSAS_MAURESQUE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MEDUSAS_MAURESQUE_SECONDARY_PERKS.size; i++)
			self SetPerk (MEDUSAS_MAURESQUE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_medusas_mauresque = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = MEDUSAS_MAURESQUE_PERK;
	self notify ("west_perk_purchased");
}

function medusas_mauresque_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + MEDUSAS_MAURESQUE_ALIAS);
	self notify (MEDUSAS_MAURESQUE_PERK + "_stop");
	
	if (MEDUSAS_MAURESQUE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MEDUSAS_MAURESQUE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (MEDUSAS_MAURESQUE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_medusas_mauresque = 0;
}

function medusas_mauresque_host_migration_func()
{
	a_medusas_mauresque_machines = GetEntArray (MEDUSAS_MAURESQUE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_medusas_mauresque_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == MEDUSAS_MAURESQUE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (MEDUSAS_MAURESQUE_ALIAS);
		}
	}
}


// ======================================================================================================
// Muscle Milk
// ======================================================================================================

function enable_muscle_milk_for_level()
{	
	zm_perks::register_perk_basic_info( 				MUSCLE_MILK_PERK, MUSCLE_MILK_ALIAS, MUSCLE_MILK_COST, MUSCLE_MILK_TRIG_STRING, GetWeapon (MUSCLE_MILK_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				MUSCLE_MILK_PERK, &muscle_milk_precache);
	zm_perks::register_perk_clientfields( 				MUSCLE_MILK_PERK, &muscle_milk_register_clientfield, &muscle_milk_set_clientfield);
	zm_perks::register_perk_machine( 					MUSCLE_MILK_PERK, &muscle_milk_machine_setup);
	zm_perks::register_perk_threads( 					MUSCLE_MILK_PERK, &muscle_milk_give_perk, &muscle_milk_take_perk);
	zm_perks::register_perk_host_migration_params( 		MUSCLE_MILK_PERK, MUSCLE_MILK_RADIANT_MACHINE_NAME, MUSCLE_MILK_PERK);

	level.west_melee_perks [level.west_melee_perks.size] = MUSCLE_MILK_ALIAS;
	
	level._effect [MUSCLE_MILK_SHOCK_FX_NAME]			= MUSCLE_MILK_SHOCK_FX_FILE;

	zombie_utility::set_zombie_var ("muscle_milk_arc_travel_time",		MUSCLE_MILK_ARC_TRAVEL_TIME, true);
	zombie_utility::set_zombie_var ("muscle_milk_head_gib_chance",		MUSCLE_MILK_HEAD_GIB_CHANCE);
	zombie_utility::set_zombie_var ("muscle_milk_max_arcs",				MUSCLE_MILK_MAX_ARCS);
	zombie_utility::set_zombie_var ("muscle_milk_max_enemies_killed", 	MUSCLE_MILK_MAX_KILLS);
	zombie_utility::set_zombie_var ("muscle_milk_kills_for_powerup",	MUSCLE_MILK_MIN_KILLS_FOR_POWERUP);
	zombie_utility::set_zombie_var ("muscle_milk_min_fx_distance",		MUSCLE_MILK_MIN_FX_DISTANCE);
	zombie_utility::set_zombie_var ("muscle_milk_network_death_choke",	MUSCLE_MILK_NETWORK_DEATH_CHOKE);
	zombie_utility::set_zombie_var ("muscle_milk_radius_decay",			MUSCLE_MILK_RADIUS_DECAY);
	zombie_utility::set_zombie_var ("muscle_milk_radius_start",			MUSCLE_MILK_RADIUS_START);
	
	level.muscle_milk_lightning_params = lightning_chain::create_lightning_chain_params (
		level.zombie_vars ["muscle_milk_max_arcs"],
		level.zombie_vars ["muscle_milk_max_enemies_killed"],
		level.zombie_vars ["muscle_milk_radius_start"],
		level.zombie_vars ["muscle_milk_radius_decay"],
		level.zombie_vars ["muscle_milk_head_gib_chance"],
		level.zombie_vars ["muscle_milk_arc_travel_time"],
		level.zombie_vars ["muscle_milk_kills_for_powerup"],
		level.zombie_vars ["muscle_milk_min_fx_distance"],
		level.zombie_vars ["muscle_milk_network_death_choke"],
		undefined,
		undefined,
		"wpn_tesla_bounce");
}

function muscle_milk_precache()
{
	level.machine_assets [MUSCLE_MILK_PERK] 				= SpawnStruct();
	level.machine_assets [MUSCLE_MILK_PERK].weapon 			= GetWeapon (MUSCLE_MILK_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [MUSCLE_MILK_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [MUSCLE_MILK_PERK].off_model 	= MUSCLE_MILK_MODEL_BUCKET;
		level.machine_assets [MUSCLE_MILK_PERK].on_model 	= MUSCLE_MILK_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [MUSCLE_MILK_PERK]					= MUSCLE_MILK_MACHINE_LIGHT_FX;
		level.machine_assets [MUSCLE_MILK_PERK].off_model 	= MUSCLE_MILK_MACHINE_DISABLED_MODEL;
		level.machine_assets [MUSCLE_MILK_PERK].on_model 	= MUSCLE_MILK_MACHINE_ACTIVE_MODEL;	
	}
}

function muscle_milk_register_clientfield() 
{
	clientfield::register ("clientuimodel", MUSCLE_MILK_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function muscle_milk_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (MUSCLE_MILK_CLIENTFIELD, state);
}

function muscle_milk_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= MUSCLE_MILK_JINGLE;
	use_trigger.script_string 							= MUSCLE_MILK_SCRIPT_STRING;
	use_trigger.script_label 							= MUSCLE_MILK_STING;
	use_trigger.target 									= MUSCLE_MILK_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= MUSCLE_MILK_SCRIPT_STRING;
	perk_machine.targetname 							= MUSCLE_MILK_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= MUSCLE_MILK_SCRIPT_STRING;
}

function muscle_milk_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + MUSCLE_MILK_ALIAS);
	
	self notify (MUSCLE_MILK_PERK + "_start");	
	
	if (MUSCLE_MILK_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MUSCLE_MILK_SECONDARY_PERKS.size; i++)
			self SetPerk (MUSCLE_MILK_SECONDARY_PERKS [i]);
			
	self.west_hasperk_muscle_milk = 1;
	self.muscle_milk_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = MUSCLE_MILK_PERK;
	self notify ("west_perk_purchased");
}

function muscle_milk_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + MUSCLE_MILK_ALIAS);
	self notify (MUSCLE_MILK_PERK + "_stop");
	
	if (MUSCLE_MILK_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < MUSCLE_MILK_SECONDARY_PERKS.size; i++)
			self UnsetPerk (MUSCLE_MILK_SECONDARY_PERKS [i]);
			
	self.west_hasperk_muscle_milk = 0;
	self.muscle_milk_cooldown = 0;
	
	if (IsDefined (self.muscle_milk_bar))
		self.muscle_milk_bar Destroy();
		
	if (IsDefined (self.muscle_milk_icon))
		self.muscle_milk_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function muscle_milk_host_migration_func()
{
	a_muscle_milk_machines = GetEntArray (MUSCLE_MILK_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_muscle_milk_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == MUSCLE_MILK_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (MUSCLE_MILK_ALIAS);
		}
	}
}


// ======================================================================================================
// PhD Flopper
// ======================================================================================================

function enable_phd_flopper_for_level()
{	
	zm_perks::register_perk_basic_info( 				PHD_FLOPPER_PERK, PHD_FLOPPER_ALIAS, PHD_FLOPPER_COST, PHD_FLOPPER_TRIG_STRING, GetWeapon (PHD_FLOPPER_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				PHD_FLOPPER_PERK, &phd_flopper_precache);
	zm_perks::register_perk_clientfields( 				PHD_FLOPPER_PERK, &phd_flopper_register_clientfield, &phd_flopper_set_clientfield);
	zm_perks::register_perk_machine( 					PHD_FLOPPER_PERK, &phd_flopper_machine_setup);
	zm_perks::register_perk_threads( 					PHD_FLOPPER_PERK, &phd_flopper_give_perk, &phd_flopper_take_perk);
	zm_perks::register_perk_host_migration_params( 		PHD_FLOPPER_PERK, PHD_FLOPPER_RADIANT_MACHINE_NAME, PHD_FLOPPER_PERK);
}

function phd_flopper_precache()
{
	level.machine_assets [PHD_FLOPPER_PERK] 				= SpawnStruct();
	level.machine_assets [PHD_FLOPPER_PERK].weapon 			= GetWeapon (PHD_FLOPPER_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [PHD_FLOPPER_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [PHD_FLOPPER_PERK].off_model 	= PHD_FLOPPER_MODEL_BUCKET;
		level.machine_assets [PHD_FLOPPER_PERK].on_model 	= PHD_FLOPPER_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [PHD_FLOPPER_PERK]					= PHD_FLOPPER_MACHINE_LIGHT_FX;
		level.machine_assets [PHD_FLOPPER_PERK].off_model 	= PHD_FLOPPER_MACHINE_DISABLED_MODEL;
		level.machine_assets [PHD_FLOPPER_PERK].on_model 	= PHD_FLOPPER_MACHINE_ACTIVE_MODEL;	
	}
}

function phd_flopper_register_clientfield() 
{
	clientfield::register ("clientuimodel", PHD_FLOPPER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function phd_flopper_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (PHD_FLOPPER_CLIENTFIELD, state);
}

function phd_flopper_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= PHD_FLOPPER_JINGLE;
	use_trigger.script_string 							= PHD_FLOPPER_SCRIPT_STRING;
	use_trigger.script_label 							= PHD_FLOPPER_STING;
	use_trigger.target 									= PHD_FLOPPER_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= PHD_FLOPPER_SCRIPT_STRING;
	perk_machine.targetname 							= PHD_FLOPPER_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= PHD_FLOPPER_SCRIPT_STRING;
}

function phd_flopper_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + PHD_FLOPPER_ALIAS);
	
	self notify (PHD_FLOPPER_PERK + "_start");	
	
	if (PHD_FLOPPER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PHD_FLOPPER_SECONDARY_PERKS.size; i++)
			self SetPerk (PHD_FLOPPER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_phd_flopper = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = PHD_FLOPPER_PERK;
	self notify ("west_perk_purchased");
}

function phd_flopper_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + PHD_FLOPPER_ALIAS);
	self notify (PHD_FLOPPER_PERK + "_stop");
	
	if (PHD_FLOPPER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PHD_FLOPPER_SECONDARY_PERKS.size; i++)
			self UnsetPerk (PHD_FLOPPER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_phd_flopper = 0;
}

function phd_flopper_host_migration_func()
{
	a_phd_flopper_machines = GetEntArray (PHD_FLOPPER_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_phd_flopper_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == PHD_FLOPPER_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (PHD_FLOPPER_ALIAS);
		}
	}
}


// ======================================================================================================
// PhD Slider
// ======================================================================================================

function enable_phd_slider_for_level()
{	
	zm_perks::register_perk_basic_info( 				PHD_SLIDER_PERK, PHD_SLIDER_ALIAS, PHD_SLIDER_COST, PHD_SLIDER_TRIG_STRING, GetWeapon (PHD_SLIDER_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				PHD_SLIDER_PERK, &phd_slider_precache);
	zm_perks::register_perk_clientfields( 				PHD_SLIDER_PERK, &phd_slider_register_clientfield, &phd_slider_set_clientfield);
	zm_perks::register_perk_machine( 					PHD_SLIDER_PERK, &phd_slider_machine_setup);
	zm_perks::register_perk_threads( 					PHD_SLIDER_PERK, &phd_slider_give_perk, &phd_slider_take_perk);
	zm_perks::register_perk_host_migration_params( 		PHD_SLIDER_PERK, PHD_SLIDER_RADIANT_MACHINE_NAME, PHD_SLIDER_PERK);
}

function phd_slider_precache()
{
	level.machine_assets [PHD_SLIDER_PERK] 				= SpawnStruct();
	level.machine_assets [PHD_SLIDER_PERK].weapon 		= GetWeapon (PHD_SLIDER_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [PHD_SLIDER_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [PHD_SLIDER_PERK].off_model 	= PHD_SLIDER_MODEL_BUCKET;
		level.machine_assets [PHD_SLIDER_PERK].on_model 	= PHD_SLIDER_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [PHD_SLIDER_PERK]						= PHD_SLIDER_MACHINE_LIGHT_FX;
		level.machine_assets [PHD_SLIDER_PERK].off_model 	= PHD_SLIDER_MACHINE_DISABLED_MODEL;
		level.machine_assets [PHD_SLIDER_PERK].on_model 	= PHD_SLIDER_MACHINE_ACTIVE_MODEL;	
	}
}

function phd_slider_register_clientfield() 
{
	clientfield::register ("clientuimodel", PHD_SLIDER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function phd_slider_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (PHD_SLIDER_CLIENTFIELD, state);
}

function phd_slider_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= PHD_SLIDER_JINGLE;
	use_trigger.script_string 							= PHD_SLIDER_SCRIPT_STRING;
	use_trigger.script_label 							= PHD_SLIDER_STING;
	use_trigger.target 									= PHD_SLIDER_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= PHD_SLIDER_SCRIPT_STRING;
	perk_machine.targetname 							= PHD_SLIDER_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= PHD_SLIDER_SCRIPT_STRING;
}

function phd_slider_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + PHD_SLIDER_ALIAS);
	
	self notify (PHD_SLIDER_PERK + "_start");	
	
	if (PHD_SLIDER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PHD_SLIDER_SECONDARY_PERKS.size; i++)
			self SetPerk (PHD_SLIDER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_phd_slider = 1;
	
	self.phd_slider_on_cooldown = 0;
	self.phd_slider_power = PHD_SLIDER_MAX_POWER;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = PHD_SLIDER_PERK;
	self notify ("west_perk_purchased");
}

function phd_slider_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + PHD_SLIDER_ALIAS);
	self notify (PHD_SLIDER_PERK + "_stop");
	
	if (PHD_SLIDER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PHD_SLIDER_SECONDARY_PERKS.size; i++)
			self UnsetPerk (PHD_SLIDER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_phd_slider = 0;
	
	self.phd_slider_on_cooldown = 0;
	self.phd_slider_power = 0;
	
	if (IsDefined (self.phd_slider_bar))
		self.phd_slider_bar Destroy();
			
	if (IsDefined (self.phd_slider_icon))
		self.phd_slider_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function phd_slider_host_migration_func()
{
	a_phd_slider_machines = GetEntArray (PHD_SLIDER_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_phd_slider_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == PHD_SLIDER_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (PHD_SLIDER_ALIAS);
		}
	}
}


// ======================================================================================================
// Pickpocket Paloma
// ======================================================================================================

function enable_pickpocket_paloma_for_level()
{	
	zm_perks::register_perk_basic_info( 					PICKPOCKET_PALOMA_PERK, PICKPOCKET_PALOMA_ALIAS, PICKPOCKET_PALOMA_COST, PICKPOCKET_PALOMA_TRIG_STRING, GetWeapon (PICKPOCKET_PALOMA_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 					PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_precache);
	zm_perks::register_perk_clientfields( 					PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_register_clientfield, &pickpocket_paloma_set_clientfield);
	zm_perks::register_perk_machine( 						PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_machine_setup);
	zm_perks::register_perk_threads( 						PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_give_perk, &pickpocket_paloma_take_perk);
	zm_perks::register_perk_host_migration_params( 			PICKPOCKET_PALOMA_PERK, PICKPOCKET_PALOMA_RADIANT_MACHINE_NAME, PICKPOCKET_PALOMA_PERK);
}

function pickpocket_paloma_precache()
{
	level.machine_assets [PICKPOCKET_PALOMA_PERK] 			= SpawnStruct();
	level.machine_assets [PICKPOCKET_PALOMA_PERK].weapon 	= GetWeapon (PICKPOCKET_PALOMA_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [PICKPOCKET_PALOMA_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [PICKPOCKET_PALOMA_PERK].off_model 	= PICKPOCKET_PALOMA_MODEL_BUCKET;
		level.machine_assets [PICKPOCKET_PALOMA_PERK].on_model 		= PICKPOCKET_PALOMA_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [PICKPOCKET_PALOMA_PERK]						= PICKPOCKET_PALOMA_MACHINE_LIGHT_FX;
		level.machine_assets [PICKPOCKET_PALOMA_PERK].off_model 	= PICKPOCKET_PALOMA_MACHINE_DISABLED_MODEL;
		level.machine_assets [PICKPOCKET_PALOMA_PERK].on_model 		= PICKPOCKET_PALOMA_MACHINE_ACTIVE_MODEL;	
	}
}

function pickpocket_paloma_register_clientfield() 
{
	clientfield::register ("clientuimodel", PICKPOCKET_PALOMA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function pickpocket_paloma_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (PICKPOCKET_PALOMA_CLIENTFIELD, state);
}

function pickpocket_paloma_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= PICKPOCKET_PALOMA_JINGLE;
	use_trigger.script_string 							= PICKPOCKET_PALOMA_SCRIPT_STRING;
	use_trigger.script_label 							= PICKPOCKET_PALOMA_STING;
	use_trigger.target 									= PICKPOCKET_PALOMA_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= PICKPOCKET_PALOMA_SCRIPT_STRING;
	perk_machine.targetname 							= PICKPOCKET_PALOMA_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= PICKPOCKET_PALOMA_SCRIPT_STRING;
}

function pickpocket_paloma_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + PICKPOCKET_PALOMA_ALIAS);
	
	self notify (PICKPOCKET_PALOMA_PERK + "_start");	
	
	if (PICKPOCKET_PALOMA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PICKPOCKET_PALOMA_SECONDARY_PERKS.size; i++)
			self SetPerk (PICKPOCKET_PALOMA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_pickpocket = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = PICKPOCKET_PALOMA_PERK;
	self notify ("west_perk_purchased");
}

function pickpocket_paloma_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + PICKPOCKET_PALOMA_ALIAS);
	self notify (PICKPOCKET_PALOMA_PERK + "_stop");
	
	if (PICKPOCKET_PALOMA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PICKPOCKET_PALOMA_SECONDARY_PERKS.size; i++)
			self UnsetPerk (PICKPOCKET_PALOMA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_pickpocket = 0;
}

function pickpocket_paloma_host_migration_func()
{
	a_pickpocket_paloma_machines = GetEntArray (PICKPOCKET_PALOMA_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_pickpocket_paloma_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == PICKPOCKET_PALOMA_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (PICKPOCKET_PALOMA_ALIAS);
		}
	}
}


// ======================================================================================================
// Power Aid Punch
// ======================================================================================================

function enable_power_aid_punch_for_level()
{	
	zm_perks::register_perk_basic_info( 				POWER_AID_PUNCH_PERK, POWER_AID_PUNCH_ALIAS, POWER_AID_PUNCH_COST, POWER_AID_PUNCH_TRIG_STRING, GetWeapon (POWER_AID_PUNCH_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				POWER_AID_PUNCH_PERK, &power_aid_punch_precache);
	zm_perks::register_perk_clientfields( 				POWER_AID_PUNCH_PERK, &power_aid_punch_register_clientfield, &power_aid_punch_set_clientfield);
	zm_perks::register_perk_machine( 					POWER_AID_PUNCH_PERK, &power_aid_punch_machine_setup);
	zm_perks::register_perk_threads( 					POWER_AID_PUNCH_PERK, &power_aid_punch_give_perk, &power_aid_punch_take_perk);
	zm_perks::register_perk_host_migration_params( 		POWER_AID_PUNCH_PERK, POWER_AID_PUNCH_RADIANT_MACHINE_NAME, POWER_AID_PUNCH_PERK);
}

function power_aid_punch_precache()
{
	level.machine_assets [POWER_AID_PUNCH_PERK] 				= SpawnStruct();
	level.machine_assets [POWER_AID_PUNCH_PERK].weapon 			= GetWeapon (POWER_AID_PUNCH_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [POWER_AID_PUNCH_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [POWER_AID_PUNCH_PERK].off_model 	= POWER_AID_PUNCH_MODEL_BUCKET;
		level.machine_assets [POWER_AID_PUNCH_PERK].on_model 	= POWER_AID_PUNCH_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [POWER_AID_PUNCH_PERK]					= POWER_AID_PUNCH_MACHINE_LIGHT_FX;
		level.machine_assets [POWER_AID_PUNCH_PERK].off_model 	= POWER_AID_PUNCH_MACHINE_DISABLED_MODEL;
		level.machine_assets [POWER_AID_PUNCH_PERK].on_model 	= POWER_AID_PUNCH_MACHINE_ACTIVE_MODEL;	
	}
}

function power_aid_punch_register_clientfield() 
{
	clientfield::register ("clientuimodel", POWER_AID_PUNCH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function power_aid_punch_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (POWER_AID_PUNCH_CLIENTFIELD, state);
}

function power_aid_punch_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= POWER_AID_PUNCH_JINGLE;
	use_trigger.script_string 							= POWER_AID_PUNCH_SCRIPT_STRING;
	use_trigger.script_label 							= POWER_AID_PUNCH_STING;
	use_trigger.target 									= POWER_AID_PUNCH_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= POWER_AID_PUNCH_SCRIPT_STRING;
	perk_machine.targetname 							= POWER_AID_PUNCH_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= POWER_AID_PUNCH_SCRIPT_STRING;
}

function power_aid_punch_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + POWER_AID_PUNCH_ALIAS);
	
	self notify (POWER_AID_PUNCH_PERK + "_start");	
	
	if (POWER_AID_PUNCH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < POWER_AID_PUNCH_SECONDARY_PERKS.size; i++)
			self SetPerk (POWER_AID_PUNCH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_power_aid_punch = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = POWER_AID_PUNCH_PERK;
	self notify ("west_perk_purchased");
}

function power_aid_punch_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + POWER_AID_PUNCH_ALIAS);
	self notify (POWER_AID_PUNCH_PERK + "_stop");
	
	if (POWER_AID_PUNCH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < POWER_AID_PUNCH_SECONDARY_PERKS.size; i++)
			self UnsetPerk (POWER_AID_PUNCH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_power_aid_punch = 0;
}

function power_aid_punch_host_migration_func()
{
	a_power_aid_punch_machines = GetEntArray (POWER_AID_PUNCH_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_power_aid_punch_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == POWER_AID_PUNCH_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (POWER_AID_PUNCH_ALIAS);
		}
	}
}


// ======================================================================================================
// Prickling Prosecco
// ======================================================================================================

function enable_prickling_prosecco_for_level()
{	
	zm_perks::register_perk_basic_info( 				PRICKLING_PROSECCO_PERK, PRICKLING_PROSECCO_ALIAS, PRICKLING_PROSECCO_COST, PRICKLING_PROSECCO_TRIG_STRING, GetWeapon (PRICKLING_PROSECCO_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				PRICKLING_PROSECCO_PERK, &prickling_prosecco_precache);
	zm_perks::register_perk_clientfields( 				PRICKLING_PROSECCO_PERK, &prickling_prosecco_register_clientfield, &prickling_prosecco_set_clientfield);
	zm_perks::register_perk_machine( 					PRICKLING_PROSECCO_PERK, &prickling_prosecco_machine_setup);
	zm_perks::register_perk_threads( 					PRICKLING_PROSECCO_PERK, &prickling_prosecco_give_perk, &prickling_prosecco_take_perk);
	zm_perks::register_perk_host_migration_params( 		PRICKLING_PROSECCO_PERK, PRICKLING_PROSECCO_RADIANT_MACHINE_NAME, PRICKLING_PROSECCO_PERK);
}

function prickling_prosecco_precache()
{
	level.machine_assets [PRICKLING_PROSECCO_PERK] 					= SpawnStruct();
	level.machine_assets [PRICKLING_PROSECCO_PERK].weapon 			= GetWeapon (PRICKLING_PROSECCO_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [PRICKLING_PROSECCO_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [PRICKLING_PROSECCO_PERK].off_model 	= PRICKLING_PROSECCO_MODEL_BUCKET;
		level.machine_assets [PRICKLING_PROSECCO_PERK].on_model 	= PRICKLING_PROSECCO_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [PRICKLING_PROSECCO_PERK]						= PRICKLING_PROSECCO_MACHINE_LIGHT_FX;
		level.machine_assets [PRICKLING_PROSECCO_PERK].off_model 	= PRICKLING_PROSECCO_MACHINE_DISABLED_MODEL;
		level.machine_assets [PRICKLING_PROSECCO_PERK].on_model 	= PRICKLING_PROSECCO_MACHINE_ACTIVE_MODEL;	
	}
}

function prickling_prosecco_register_clientfield() 
{
	clientfield::register ("clientuimodel", PRICKLING_PROSECCO_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function prickling_prosecco_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (PRICKLING_PROSECCO_CLIENTFIELD, state);
}

function prickling_prosecco_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= PRICKLING_PROSECCO_JINGLE;
	use_trigger.script_string 							= PRICKLING_PROSECCO_SCRIPT_STRING;
	use_trigger.script_label 							= PRICKLING_PROSECCO_STING;
	use_trigger.target 									= PRICKLING_PROSECCO_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= PRICKLING_PROSECCO_SCRIPT_STRING;
	perk_machine.targetname 							= PRICKLING_PROSECCO_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= PRICKLING_PROSECCO_SCRIPT_STRING;
}

function prickling_prosecco_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + PRICKLING_PROSECCO_ALIAS);
	
	self notify (PRICKLING_PROSECCO_PERK + "_start");	
	
	if (PRICKLING_PROSECCO_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PRICKLING_PROSECCO_SECONDARY_PERKS.size; i++)
			self SetPerk (PRICKLING_PROSECCO_SECONDARY_PERKS [i]);
			
	self.west_hasperk_prickling = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = PRICKLING_PROSECCO_PERK;
	self notify ("west_perk_purchased");
}

function prickling_prosecco_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + PRICKLING_PROSECCO_ALIAS);
	self notify (PRICKLING_PROSECCO_PERK + "_stop");
	
	if (PRICKLING_PROSECCO_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < PRICKLING_PROSECCO_SECONDARY_PERKS.size; i++)
			self UnsetPerk (PRICKLING_PROSECCO_SECONDARY_PERKS [i]);
			
	self.west_hasperk_prickling = 0;
}

function prickling_prosecco_host_migration_func()
{
	a_prickling_prosecco_machines = GetEntArray (PRICKLING_PROSECCO_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_prickling_prosecco_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == PRICKLING_PROSECCO_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (PRICKLING_PROSECCO_ALIAS);
		}
	}
}


// ======================================================================================================
// Reaper's Roulette
// ======================================================================================================

function enable_roulette_for_level()
{	
	zm_perks::register_perk_basic_info( 				ROULETTE_PERK, ROULETTE_ALIAS, ROULETTE_COST, ROULETTE_TRIG_STRING, GetWeapon (ROULETTE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ROULETTE_PERK, &roulette_precache);
	zm_perks::register_perk_clientfields( 				ROULETTE_PERK, &roulette_register_clientfield, &roulette_set_clientfield);
	zm_perks::register_perk_machine( 					ROULETTE_PERK, &roulette_machine_setup);
	zm_perks::register_perk_threads( 					ROULETTE_PERK, &roulette_give_perk, &roulette_take_perk);
	zm_perks::register_perk_host_migration_params( 		ROULETTE_PERK, ROULETTE_RADIANT_MACHINE_NAME, ROULETTE_PERK);
}

function roulette_precache()
{
	level.machine_assets [ROULETTE_PERK] 				= SpawnStruct();
	level.machine_assets [ROULETTE_PERK].weapon 		= GetWeapon (ROULETTE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ROULETTE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ROULETTE_PERK].off_model 	= ROULETTE_MODEL_BUCKET;
		level.machine_assets [ROULETTE_PERK].on_model 	= ROULETTE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ROULETTE_PERK]					= ROULETTE_MACHINE_LIGHT_FX;
		level.machine_assets [ROULETTE_PERK].off_model 	= ROULETTE_MACHINE_DISABLED_MODEL;
		level.machine_assets [ROULETTE_PERK].on_model 	= ROULETTE_MACHINE_ACTIVE_MODEL;	
	}
}

function roulette_register_clientfield() 
{
	clientfield::register ("clientuimodel", ROULETTE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function roulette_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ROULETTE_CLIENTFIELD, state);
}

function roulette_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= ROULETTE_JINGLE;
	use_trigger.script_string 							= ROULETTE_SCRIPT_STRING;
	use_trigger.script_label 							= ROULETTE_STING;
	use_trigger.target 									= ROULETTE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ROULETTE_SCRIPT_STRING;
	perk_machine.targetname 							= ROULETTE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ROULETTE_SCRIPT_STRING;
}

function roulette_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ROULETTE_ALIAS);
	
	self notify (ROULETTE_PERK + "_start");	
	
	if (ROULETTE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ROULETTE_SECONDARY_PERKS.size; i++)
			self SetPerk (ROULETTE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_roulette = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ROULETTE_PERK;
	self notify ("west_perk_purchased");
}

function roulette_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ROULETTE_ALIAS);
	self notify (ROULETTE_PERK + "_stop");
	
	if (ROULETTE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ROULETTE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ROULETTE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_roulette = 0;
}

function roulette_host_migration_func()
{
	a_roulette_machines = GetEntArray (ROULETTE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_roulette_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ROULETTE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ROULETTE_ALIAS);
		}
	}
}


// ======================================================================================================
// Rebate Rosé
// ======================================================================================================

function enable_rebate_rose_for_level()
{	
	zm_perks::register_perk_basic_info( 				REBATE_ROSE_PERK, REBATE_ROSE_ALIAS, REBATE_ROSE_COST, REBATE_ROSE_TRIG_STRING, GetWeapon (REBATE_ROSE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				REBATE_ROSE_PERK, &rebate_rose_precache);
	zm_perks::register_perk_clientfields( 				REBATE_ROSE_PERK, &rebate_rose_register_clientfield, &rebate_rose_set_clientfield);
	zm_perks::register_perk_machine( 					REBATE_ROSE_PERK, &rebate_rose_machine_setup);
	zm_perks::register_perk_threads( 					REBATE_ROSE_PERK, &rebate_rose_give_perk, &rebate_rose_take_perk);
	zm_perks::register_perk_host_migration_params( 		REBATE_ROSE_PERK, REBATE_ROSE_RADIANT_MACHINE_NAME, REBATE_ROSE_PERK);
}

function rebate_rose_precache()
{
	level.machine_assets [REBATE_ROSE_PERK] 				= SpawnStruct();
	level.machine_assets [REBATE_ROSE_PERK].weapon 			= GetWeapon (REBATE_ROSE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [REBATE_ROSE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [REBATE_ROSE_PERK].off_model 	= REBATE_ROSE_MODEL_BUCKET;
		level.machine_assets [REBATE_ROSE_PERK].on_model 	= REBATE_ROSE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [REBATE_ROSE_PERK]					= REBATE_ROSE_MACHINE_LIGHT_FX;
		level.machine_assets [REBATE_ROSE_PERK].off_model 	= REBATE_ROSE_MACHINE_DISABLED_MODEL;
		level.machine_assets [REBATE_ROSE_PERK].on_model 	= REBATE_ROSE_MACHINE_ACTIVE_MODEL;	
	}
}

function rebate_rose_register_clientfield() 
{
	clientfield::register ("clientuimodel", REBATE_ROSE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function rebate_rose_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (REBATE_ROSE_CLIENTFIELD, state);
}

function rebate_rose_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= REBATE_ROSE_JINGLE;
	use_trigger.script_string 							= REBATE_ROSE_SCRIPT_STRING;
	use_trigger.script_label 							= REBATE_ROSE_STING;
	use_trigger.target 									= REBATE_ROSE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= REBATE_ROSE_SCRIPT_STRING;
	perk_machine.targetname 							= REBATE_ROSE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= REBATE_ROSE_SCRIPT_STRING;
}

function rebate_rose_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + REBATE_ROSE_ALIAS);
	
	self notify (REBATE_ROSE_PERK + "_start");	
	
	if (REBATE_ROSE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < REBATE_ROSE_SECONDARY_PERKS.size; i++)
			self SetPerk (REBATE_ROSE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_rebate_rose = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = REBATE_ROSE_PERK;
	self notify ("west_perk_purchased");
}

function rebate_rose_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + REBATE_ROSE_ALIAS);
	self notify (REBATE_ROSE_PERK + "_stop");
	
	if (REBATE_ROSE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < REBATE_ROSE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (REBATE_ROSE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_rebate_rose = 0;
}

function rebate_rose_host_migration_func()
{
	a_rebate_rose_machines = GetEntArray (REBATE_ROSE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_rebate_rose_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == REBATE_ROSE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (REBATE_ROSE_ALIAS);
		}
	}
}


// ======================================================================================================
// Salvage Shake
// ======================================================================================================

function enable_salvage_shake_for_level()
{	
	zm_perks::register_perk_basic_info (SALVAGE_SHAKE_PERK, SALVAGE_SHAKE_ALIAS, SALVAGE_SHAKE_COST, SALVAGE_SHAKE_TRIG_STRING, GetWeapon (SALVAGE_SHAKE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (SALVAGE_SHAKE_PERK, &salvage_shake_precache);
	zm_perks::register_perk_clientfields (SALVAGE_SHAKE_PERK, &salvage_shake_register_clientfield, &salvage_shake_set_clientfield);
	zm_perks::register_perk_machine (SALVAGE_SHAKE_PERK, &salvage_shake_machine_setup);
	zm_perks::register_perk_threads (SALVAGE_SHAKE_PERK, &salvage_shake_give_perk, &salvage_shake_take_perk);
	zm_perks::register_perk_host_migration_params (SALVAGE_SHAKE_PERK, SALVAGE_SHAKE_RADIANT_MACHINE_NAME, SALVAGE_SHAKE_PERK);
	//zm_perks::register_perk_machine_power_override (SALVAGE_SHAKE_PERK, &salvage_shake_host_migration_func);
}

function salvage_shake_precache()
{
	level.machine_assets [SALVAGE_SHAKE_PERK] 				= SpawnStruct();
	level.machine_assets [SALVAGE_SHAKE_PERK].weapon 		= GetWeapon (SALVAGE_SHAKE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SALVAGE_SHAKE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SALVAGE_SHAKE_PERK].off_model = SALVAGE_SHAKE_MODEL_BUCKET;
		level.machine_assets [SALVAGE_SHAKE_PERK].on_model 	= SALVAGE_SHAKE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SALVAGE_SHAKE_PERK]					= SALVAGE_SHAKE_MACHINE_LIGHT_FX;
		level.machine_assets [SALVAGE_SHAKE_PERK].off_model = SALVAGE_SHAKE_MACHINE_DISABLED_MODEL;
		level.machine_assets [SALVAGE_SHAKE_PERK].on_model 	= SALVAGE_SHAKE_MACHINE_ACTIVE_MODEL;	
	}
}

function salvage_shake_register_clientfield() 
{
	clientfield::register ("clientuimodel", SALVAGE_SHAKE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function salvage_shake_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SALVAGE_SHAKE_CLIENTFIELD, state);
}

function salvage_shake_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SALVAGE_SHAKE_JINGLE;
	use_trigger.script_string 							= SALVAGE_SHAKE_SCRIPT_STRING;
	use_trigger.script_label 							= SALVAGE_SHAKE_STING;
	use_trigger.target 									= SALVAGE_SHAKE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SALVAGE_SHAKE_SCRIPT_STRING;
	perk_machine.targetname 							= SALVAGE_SHAKE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SALVAGE_SHAKE_SCRIPT_STRING;
}

function salvage_shake_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SALVAGE_SHAKE_ALIAS);
	
	self notify (SALVAGE_SHAKE_PERK + "_start");	
	
	if (SALVAGE_SHAKE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SALVAGE_SHAKE_SECONDARY_PERKS.size; i++)
			self SetPerk (SALVAGE_SHAKE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_salvage = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SALVAGE_SHAKE_PERK;
	self notify ("west_perk_purchased");
}

function salvage_shake_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SALVAGE_SHAKE_ALIAS);
	self notify (SALVAGE_SHAKE_PERK + "_stop");
	
	if (SALVAGE_SHAKE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SALVAGE_SHAKE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SALVAGE_SHAKE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_salvage = 0;
}

function salvage_shake_host_migration_func()
{
	a_salvage_shake_machines = GetEntArray (SALVAGE_SHAKE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_salvage_shake_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SALVAGE_SHAKE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SALVAGE_SHAKE_ALIAS);
		}
	}
}


// ======================================================================================================
// Samurai's Spirit
// ======================================================================================================

function enable_samurais_spirit_for_level()
{	
	zm_perks::register_perk_basic_info( 				SAMURAIS_SPIRIT_PERK, SAMURAIS_SPIRIT_ALIAS, SAMURAIS_SPIRIT_COST, SAMURAIS_SPIRIT_TRIG_STRING, GetWeapon (SAMURAIS_SPIRIT_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				SAMURAIS_SPIRIT_PERK, &samurais_spirit_precache);
	zm_perks::register_perk_clientfields( 				SAMURAIS_SPIRIT_PERK, &samurais_spirit_register_clientfield, &samurais_spirit_set_clientfield);
	zm_perks::register_perk_machine( 					SAMURAIS_SPIRIT_PERK, &samurais_spirit_machine_setup);
	zm_perks::register_perk_threads( 					SAMURAIS_SPIRIT_PERK, &samurais_spirit_give_perk, &samurais_spirit_take_perk);
	zm_perks::register_perk_host_migration_params( 		SAMURAIS_SPIRIT_PERK, SAMURAIS_SPIRIT_RADIANT_MACHINE_NAME, SAMURAIS_SPIRIT_PERK);
}

function samurais_spirit_precache()
{
	level.machine_assets [SAMURAIS_SPIRIT_PERK] 				= SpawnStruct();
	level.machine_assets [SAMURAIS_SPIRIT_PERK].weapon 			= GetWeapon (SAMURAIS_SPIRIT_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SAMURAIS_SPIRIT_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SAMURAIS_SPIRIT_PERK].off_model 	= SAMURAIS_SPIRIT_MODEL_BUCKET;
		level.machine_assets [SAMURAIS_SPIRIT_PERK].on_model	= SAMURAIS_SPIRIT_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SAMURAIS_SPIRIT_PERK]					= SAMURAIS_SPIRIT_MACHINE_LIGHT_FX;
		level.machine_assets [SAMURAIS_SPIRIT_PERK].off_model 	= SAMURAIS_SPIRIT_MACHINE_DISABLED_MODEL;
		level.machine_assets [SAMURAIS_SPIRIT_PERK].on_model 	= SAMURAIS_SPIRIT_MACHINE_ACTIVE_MODEL;	
	}
}

function samurais_spirit_register_clientfield() 
{
	clientfield::register ("clientuimodel", SAMURAIS_SPIRIT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function samurais_spirit_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SAMURAIS_SPIRIT_CLIENTFIELD, state);
}

function samurais_spirit_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SAMURAIS_SPIRIT_JINGLE;
	use_trigger.script_string 							= SAMURAIS_SPIRIT_SCRIPT_STRING;
	use_trigger.script_label 							= SAMURAIS_SPIRIT_STING;
	use_trigger.target 									= SAMURAIS_SPIRIT_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SAMURAIS_SPIRIT_SCRIPT_STRING;
	perk_machine.targetname 							= SAMURAIS_SPIRIT_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SAMURAIS_SPIRIT_SCRIPT_STRING;
}

function samurais_spirit_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SAMURAIS_SPIRIT_ALIAS);
	
	self notify (SAMURAIS_SPIRIT_PERK + "_start");	
	
	if (SAMURAIS_SPIRIT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SAMURAIS_SPIRIT_SECONDARY_PERKS.size; i++)
			self SetPerk (SAMURAIS_SPIRIT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_samurai = 1;
			
	if (!IsDefined (self.samurai_melee_multiplier))
		self.samurai_melee_multiplier = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SAMURAIS_SPIRIT_PERK;
	self notify ("west_perk_purchased");
}

function samurais_spirit_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SAMURAIS_SPIRIT_ALIAS);
	self notify (SAMURAIS_SPIRIT_PERK + "_stop");
	
	if (SAMURAIS_SPIRIT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SAMURAIS_SPIRIT_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SAMURAIS_SPIRIT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_samurai = 0;
}

function samurais_spirit_host_migration_func()
{
	a_samurais_spirit_machines = GetEntArray (SAMURAIS_SPIRIT_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_samurais_spirit_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SAMURAIS_SPIRIT_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SAMURAIS_SPIRIT_ALIAS);
		}
	}
}


// ======================================================================================================
// Side-Steppin' Shandy
// ======================================================================================================

function enable_side_step_for_level()
{	
	zm_perks::register_perk_basic_info (SIDE_STEP_PERK, SIDE_STEP_ALIAS, SIDE_STEP_COST, SIDE_STEP_TRIG_STRING, GetWeapon (SIDE_STEP_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (SIDE_STEP_PERK, &side_step_precache);
	zm_perks::register_perk_clientfields (SIDE_STEP_PERK, &side_step_register_clientfield, &side_step_set_clientfield);
	zm_perks::register_perk_machine (SIDE_STEP_PERK, &side_step_machine_setup);
	zm_perks::register_perk_threads (SIDE_STEP_PERK, &side_step_give_perk, &side_step_take_perk);
	zm_perks::register_perk_host_migration_params (SIDE_STEP_PERK, SIDE_STEP_RADIANT_MACHINE_NAME, SIDE_STEP_PERK);
	//zm_perks::register_perk_machine_power_override (SIDE_STEP_PERK, &side_step_host_migration_func);
}

function side_step_precache()
{
	level.machine_assets [SIDE_STEP_PERK] 				= SpawnStruct();
	level.machine_assets [SIDE_STEP_PERK].weapon 		= GetWeapon (SIDE_STEP_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SIDE_STEP_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SIDE_STEP_PERK].off_model = SIDE_STEP_MODEL_BUCKET;
		level.machine_assets [SIDE_STEP_PERK].on_model	= SIDE_STEP_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SIDE_STEP_PERK]					= SIDE_STEP_MACHINE_LIGHT_FX;
		level.machine_assets [SIDE_STEP_PERK].off_model = SIDE_STEP_MACHINE_DISABLED_MODEL;
		level.machine_assets [SIDE_STEP_PERK].on_model 	= SIDE_STEP_MACHINE_ACTIVE_MODEL;	
	}
}

function side_step_register_clientfield() 
{
	clientfield::register ("clientuimodel", SIDE_STEP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function side_step_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SIDE_STEP_CLIENTFIELD, state);
}

function side_step_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SIDE_STEP_JINGLE;
	use_trigger.script_string 							= SIDE_STEP_SCRIPT_STRING;
	use_trigger.script_label 							= SIDE_STEP_STING;
	use_trigger.target 									= SIDE_STEP_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SIDE_STEP_SCRIPT_STRING;
	perk_machine.targetname 							= SIDE_STEP_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SIDE_STEP_SCRIPT_STRING;
}

function side_step_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SIDE_STEP_ALIAS);
	
	self notify (SIDE_STEP_PERK + "_start");	
	
	if (SIDE_STEP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SIDE_STEP_SECONDARY_PERKS.size; i++)
			self SetPerk (SIDE_STEP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_side_step = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SIDE_STEP_PERK;
	self notify ("west_perk_purchased");
}

function side_step_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SIDE_STEP_ALIAS);
	self notify (SIDE_STEP_PERK + "_stop");
	
	if (SIDE_STEP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SIDE_STEP_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SIDE_STEP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_side_step = 0;
}

function side_step_host_migration_func()
{
	a_side_step_machines = GetEntArray (SIDE_STEP_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_side_step_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SIDE_STEP_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SIDE_STEP_ALIAS);
		}
	}
}


// ======================================================================================================
// Slip-Away Slushee
// ======================================================================================================

function enable_slip_away_for_level()
{	
	zm_perks::register_perk_basic_info (SLIP_AWAY_PERK, SLIP_AWAY_ALIAS, SLIP_AWAY_COST, SLIP_AWAY_TRIG_STRING, GetWeapon (SLIP_AWAY_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (SLIP_AWAY_PERK, &slip_away_precache);
	zm_perks::register_perk_clientfields (SLIP_AWAY_PERK, &slip_away_register_clientfield, &slip_away_set_clientfield);
	zm_perks::register_perk_machine (SLIP_AWAY_PERK, &slip_away_machine_setup);
	zm_perks::register_perk_threads (SLIP_AWAY_PERK, &slip_away_give_perk, &slip_away_take_perk);
	zm_perks::register_perk_host_migration_params (SLIP_AWAY_PERK, SLIP_AWAY_RADIANT_MACHINE_NAME, SLIP_AWAY_PERK);
	//zm_perks::register_perk_machine_power_override (SLIP_AWAY_PERK, &slip_away_host_migration_func);
}

function slip_away_precache()
{
	level.machine_assets [SLIP_AWAY_PERK] 				= SpawnStruct();
	level.machine_assets [SLIP_AWAY_PERK].weapon 		= GetWeapon (SLIP_AWAY_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SLIP_AWAY_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SLIP_AWAY_PERK].off_model = SLIP_AWAY_MODEL_BUCKET;
		level.machine_assets [SLIP_AWAY_PERK].on_model	= SLIP_AWAY_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SLIP_AWAY_PERK]					= SLIP_AWAY_MACHINE_LIGHT_FX;
		level.machine_assets [SLIP_AWAY_PERK].off_model = SLIP_AWAY_MACHINE_DISABLED_MODEL;
		level.machine_assets [SLIP_AWAY_PERK].on_model 	= SLIP_AWAY_MACHINE_ACTIVE_MODEL;	
	}
}

function slip_away_register_clientfield() 
{
	clientfield::register ("clientuimodel", SLIP_AWAY_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function slip_away_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SLIP_AWAY_CLIENTFIELD, state);
}

function slip_away_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SLIP_AWAY_JINGLE;
	use_trigger.script_string 							= SLIP_AWAY_SCRIPT_STRING;
	use_trigger.script_label 							= SLIP_AWAY_STING;
	use_trigger.target 									= SLIP_AWAY_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SLIP_AWAY_SCRIPT_STRING;
	perk_machine.targetname 							= SLIP_AWAY_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SLIP_AWAY_SCRIPT_STRING;
}

function slip_away_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SLIP_AWAY_ALIAS);
	
	self notify (SLIP_AWAY_PERK + "_start");	
	
	if (SLIP_AWAY_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SLIP_AWAY_SECONDARY_PERKS.size; i++)
			self SetPerk (SLIP_AWAY_SECONDARY_PERKS [i]);
			
	self.west_hasperk_slip_away = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SLIP_AWAY_PERK;
	self notify ("west_perk_purchased");
}

function slip_away_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SLIP_AWAY_ALIAS);
	self notify (SLIP_AWAY_PERK + "_stop");
	
	if (SLIP_AWAY_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SLIP_AWAY_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SLIP_AWAY_SECONDARY_PERKS [i]);
			
	self.west_hasperk_slip_away = 0;
}

function slip_away_host_migration_func()
{
	a_slip_away_machines = GetEntArray (SLIP_AWAY_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_slip_away_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SLIP_AWAY_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SLIP_AWAY_ALIAS);
		}
	}
}


// ======================================================================================================
// Slurpentine
// ======================================================================================================

function enable_slurpentine_for_level()
{	
	zm_perks::register_perk_basic_info (SLURPENTINE_PERK, SLURPENTINE_ALIAS, SLURPENTINE_COST, SLURPENTINE_TRIG_STRING, GetWeapon (SLURPENTINE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (SLURPENTINE_PERK, &slurpentine_precache);
	zm_perks::register_perk_clientfields (SLURPENTINE_PERK, &slurpentine_register_clientfield, &slurpentine_set_clientfield);
	zm_perks::register_perk_machine (SLURPENTINE_PERK, &slurpentine_machine_setup);
	zm_perks::register_perk_threads (SLURPENTINE_PERK, &slurpentine_give_perk, &slurpentine_take_perk);
	zm_perks::register_perk_host_migration_params (SLURPENTINE_PERK, SLURPENTINE_RADIANT_MACHINE_NAME, SLURPENTINE_PERK);
	//zm_perks::register_perk_machine_power_override (SLURPENTINE_PERK, &slurpentine_host_migration_func);
}

function slurpentine_precache()
{
	level.machine_assets [SLURPENTINE_PERK] 				= SpawnStruct();
	level.machine_assets [SLURPENTINE_PERK].weapon 		= GetWeapon (SLURPENTINE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SLURPENTINE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SLURPENTINE_PERK].off_model = SLURPENTINE_MODEL_BUCKET;
		level.machine_assets [SLURPENTINE_PERK].on_model	= SLURPENTINE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SLURPENTINE_PERK]					= SLURPENTINE_MACHINE_LIGHT_FX;
		level.machine_assets [SLURPENTINE_PERK].off_model 	= SLURPENTINE_MACHINE_DISABLED_MODEL;
		level.machine_assets [SLURPENTINE_PERK].on_model 	= SLURPENTINE_MACHINE_ACTIVE_MODEL;
		
		level.machine_assets [SLURPENTINE_PERK].power_on_callback 	= &slurpentine_perk_power_on_cb;
		level.machine_assets [SLURPENTINE_PERK].power_off_callback 	= &slurpentine_perk_power_off_cb;
	}
}

function slurpentine_perk_power_on_cb()
{
	//SELF == PERK MACHINE
	
	self Attach (SLURPENTINE_MODEL_FLUID, "tag_origin", true);
	self scene::play (SLURPENTINE_MODEL_ANIM_BUNDLE, self);
}

function slurpentine_perk_power_off_cb()
{
	//SELF == PERK MACHINE
	
	self scene::stop (SLURPENTINE_MODEL_ANIM_BUNDLE, self);
}

function slurpentine_register_clientfield() 
{
	clientfield::register ("clientuimodel", SLURPENTINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
	clientfield::register ("actor", "slurpentine_zombie_eye_change", VERSION_SHIP, 1, "int");
}

function slurpentine_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SLURPENTINE_CLIENTFIELD, state);
}

function slurpentine_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SLURPENTINE_JINGLE;
	use_trigger.script_string 							= SLURPENTINE_SCRIPT_STRING;
	use_trigger.script_label 							= SLURPENTINE_STING;
	use_trigger.target 									= SLURPENTINE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SLURPENTINE_SCRIPT_STRING;
	perk_machine.targetname 							= SLURPENTINE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SLURPENTINE_SCRIPT_STRING;		
}

function slurpentine_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SLURPENTINE_ALIAS);
	
	self notify (SLURPENTINE_PERK + "_start");	
	
	if (SLURPENTINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SLURPENTINE_SECONDARY_PERKS.size; i++)
			self SetPerk (SLURPENTINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_slurpentine = 1;
	self.slurpentine_should_boost = 0;
	self.slurpentine_boost_time = 0;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = SLURPENTINE_PERK;
	self notify ("west_perk_purchased");
}

function slurpentine_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SLURPENTINE_ALIAS);
	self notify (SLURPENTINE_PERK + "_stop");
	
	if (SLURPENTINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SLURPENTINE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SLURPENTINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_slurpentine = 0;
	self.slurpentine_should_boost = 0;
	self.slurpentine_boost_time = 0;
}

function slurpentine_host_migration_func()
{
	a_slurpentine_machines = GetEntArray (SLURPENTINE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_slurpentine_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SLURPENTINE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SLURPENTINE_ALIAS);
		}
	}
}


// ======================================================================================================
// Snail's Pace Slurpee
// ======================================================================================================

function enable_snails_pace_for_level()
{	
	zm_perks::register_perk_basic_info (SNAILS_PACE_PERK, SNAILS_PACE_ALIAS, SNAILS_PACE_COST, SNAILS_PACE_TRIG_STRING, GetWeapon (SNAILS_PACE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (SNAILS_PACE_PERK, &snails_pace_precache);
	zm_perks::register_perk_clientfields (SNAILS_PACE_PERK, &snails_pace_register_clientfield, &snails_pace_set_clientfield);
	zm_perks::register_perk_machine (SNAILS_PACE_PERK, &snails_pace_machine_setup);
	zm_perks::register_perk_threads (SNAILS_PACE_PERK, &snails_pace_give_perk, &snails_pace_take_perk);
	zm_perks::register_perk_host_migration_params (SNAILS_PACE_PERK, SNAILS_PACE_RADIANT_MACHINE_NAME, SNAILS_PACE_PERK);
	//zm_perks::register_perk_machine_power_override (SNAILS_PACE_PERK, &snails_pace_host_migration_func);
	
	zm_utility::register_slowdown ("snails_pace_slowdown", SNAILS_PACE_ZOMBIE_SLOWDOWN_RATE, SNAILS_PACE_ZOMBIE_SLOWDOWN_TIME);
}

function snails_pace_precache()
{
	level.machine_assets [SNAILS_PACE_PERK] 				= SpawnStruct();
	level.machine_assets [SNAILS_PACE_PERK].weapon 			= GetWeapon (SNAILS_PACE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SNAILS_PACE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SNAILS_PACE_PERK].off_model 	= SNAILS_PACE_MODEL_BUCKET;
		level.machine_assets [SNAILS_PACE_PERK].on_model 	= SNAILS_PACE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SNAILS_PACE_PERK]					= SNAILS_PACE_MACHINE_LIGHT_FX;
		level.machine_assets [SNAILS_PACE_PERK].off_model 	= SNAILS_PACE_MACHINE_DISABLED_MODEL;
		level.machine_assets [SNAILS_PACE_PERK].on_model 	= SNAILS_PACE_MACHINE_ACTIVE_MODEL;	
	}
}

function snails_pace_register_clientfield() 
{
	clientfield::register ("clientuimodel", SNAILS_PACE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
	clientfield::register ("actor", "snails_pace_zombie_eye_change", VERSION_SHIP, 1, "int");
}

function snails_pace_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SNAILS_PACE_CLIENTFIELD, state);
}

function snails_pace_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 								= SNAILS_PACE_JINGLE;
	use_trigger.script_string 								= SNAILS_PACE_SCRIPT_STRING;
	use_trigger.script_label 								= SNAILS_PACE_STING;
	use_trigger.target 										= SNAILS_PACE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 								= SNAILS_PACE_SCRIPT_STRING;
	perk_machine.targetname 								= SNAILS_PACE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 							= SNAILS_PACE_SCRIPT_STRING;
}

function snails_pace_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SNAILS_PACE_ALIAS);
	
	self notify (SNAILS_PACE_PERK + "_start");	
	
	if (SNAILS_PACE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SNAILS_PACE_SECONDARY_PERKS.size; i++)
			self SetPerk (SNAILS_PACE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_snails_pace = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SNAILS_PACE_PERK;
	self notify ("west_perk_purchased");
}

function snails_pace_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SNAILS_PACE_ALIAS);
	self notify (SNAILS_PACE_PERK + "_stop");
	
	if (SNAILS_PACE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SNAILS_PACE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SNAILS_PACE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_snails_pace = 0;
}

function snails_pace_host_migration_func()
{
	a_snails_pace_machines = GetEntArray (SNAILS_PACE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_snails_pace_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SNAILS_PACE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SNAILS_PACE_ALIAS);
		}
	}
}


// ======================================================================================================
// Space Cadet Cola
// ======================================================================================================

function enable_space_cadet_for_level()
{	
	zm_perks::register_perk_basic_info( 				SPACE_CADET_PERK, SPACE_CADET_ALIAS, SPACE_CADET_COST, SPACE_CADET_TRIG_STRING, GetWeapon (SPACE_CADET_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				SPACE_CADET_PERK, &space_cadet_precache);
	zm_perks::register_perk_clientfields( 				SPACE_CADET_PERK, &space_cadet_register_clientfield, &space_cadet_set_clientfield);
	zm_perks::register_perk_machine( 					SPACE_CADET_PERK, &space_cadet_machine_setup);
	zm_perks::register_perk_threads( 					SPACE_CADET_PERK, &space_cadet_give_perk, &space_cadet_take_perk);
	zm_perks::register_perk_host_migration_params( 		SPACE_CADET_PERK, SPACE_CADET_RADIANT_MACHINE_NAME, SPACE_CADET_PERK);
	
	visionset_mgr::register_info ("visionset", "space_cadet_hidden", 1, 112, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	visionset_mgr::register_info ("overlay", "space_cadet_hidden", 1, 112, 1, 1);
}

function space_cadet_precache()
{
	level.machine_assets[SPACE_CADET_PERK] 				= SpawnStruct();
	level.machine_assets[SPACE_CADET_PERK].weapon 		= GetWeapon (SPACE_CADET_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SPACE_CADET_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SPACE_CADET_PERK].off_model 	= SPACE_CADET_MODEL_BUCKET;
		level.machine_assets [SPACE_CADET_PERK].on_model	= SPACE_CADET_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SPACE_CADET_PERK]					= SPACE_CADET_MACHINE_LIGHT_FX;
		level.machine_assets [SPACE_CADET_PERK].off_model 	= SPACE_CADET_MACHINE_DISABLED_MODEL;
		level.machine_assets [SPACE_CADET_PERK].on_model 	= SPACE_CADET_MACHINE_ACTIVE_MODEL;	
	}
}

function space_cadet_register_clientfield() 
{
	clientfield::register ("clientuimodel", SPACE_CADET_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function space_cadet_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SPACE_CADET_CLIENTFIELD, state);
}

function space_cadet_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SPACE_CADET_JINGLE;
	use_trigger.script_string 							= SPACE_CADET_SCRIPT_STRING;
	use_trigger.script_label 							= SPACE_CADET_STING;
	use_trigger.target 									= SPACE_CADET_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SPACE_CADET_SCRIPT_STRING;
	perk_machine.targetname 							= SPACE_CADET_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SPACE_CADET_SCRIPT_STRING;
}

function space_cadet_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SPACE_CADET_ALIAS);
	
	self notify (SPACE_CADET_PERK + "_start");
	
	if (SPACE_CADET_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SPACE_CADET_SECONDARY_PERKS.size; i++)
			self SetPerk (SPACE_CADET_SECONDARY_PERKS [i]);
			
	self.west_hasperk_space_cadet = 1;
			
	self.space_cadet_on_cooldown = false;
	self.space_cadet_kills_count = 0;
	self.space_cadet_still_need_kills = 0;
	self.space_cadet_activated = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SPACE_CADET_PERK;
	self notify ("west_perk_purchased");
}

function space_cadet_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SPACE_CADET_ALIAS);
	self notify (SPACE_CADET_PERK + "_stop");
	
	if (SPACE_CADET_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SPACE_CADET_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SPACE_CADET_SECONDARY_PERKS [i]);
			
	self.west_hasperk_space_cadet = 0;
	
	if (IsDefined (self.space_cadet_activated) && self.space_cadet_activated == 1)
	{
		visionset_mgr::deactivate ("visionset", "space_cadet_hidden", self);
		visionset_mgr::deactivate ("overlay", "space_cadet_hidden", self);
		
		self zm_utility::decrement_ignoreme();
	}
	
	self.space_cadet_kills_count = 0;
	self.space_cadet_on_cooldown = false;
	self.space_cadet_still_need_kills = 0;
	self.space_cadet_activated = 0;
	
	if (IsDefined (self.space_cadet_bar_kills))
		self.space_cadet_bar_kills Destroy();
		
	if (IsDefined (self.space_cadet_bar_time))
		self.space_cadet_bar_time Destroy();
	
	if (IsDefined (self.space_cadet_icon))
		self.space_cadet_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function space_cadet_host_migration_func()
{
	a_space_cadet_machines = GetEntArray (SPACE_CADET_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_space_cadet_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SPACE_CADET_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SPACE_CADET_ALIAS);
		}
	}
}


// ======================================================================================================
// Spectral Shake
// ======================================================================================================

function enable_spectral_shake_for_level()
{	
	zm_perks::register_perk_basic_info( 				SPECTRAL_SHAKE_PERK, SPECTRAL_SHAKE_ALIAS, SPECTRAL_SHAKE_COST, SPECTRAL_SHAKE_TRIG_STRING, GetWeapon (SPECTRAL_SHAKE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				SPECTRAL_SHAKE_PERK, &spectral_shake_precache);
	zm_perks::register_perk_clientfields( 				SPECTRAL_SHAKE_PERK, &spectral_shake_register_clientfield, &spectral_shake_set_clientfield);
	zm_perks::register_perk_machine( 					SPECTRAL_SHAKE_PERK, &spectral_shake_machine_setup);
	zm_perks::register_perk_threads( 					SPECTRAL_SHAKE_PERK, &spectral_shake_give_perk, &spectral_shake_take_perk);
	zm_perks::register_perk_host_migration_params( 		SPECTRAL_SHAKE_PERK, SPECTRAL_SHAKE_RADIANT_MACHINE_NAME, SPECTRAL_SHAKE_PERK);
	
	visionset_mgr::register_info ("visionset", "spectral_shake_hidden", 1, 112, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	visionset_mgr::register_info ("overlay", "spectral_shake_hidden", 1, 112, 1, 1);
}

function spectral_shake_precache()
{
	level.machine_assets [SPECTRAL_SHAKE_PERK] 					= SpawnStruct();
	level.machine_assets [SPECTRAL_SHAKE_PERK].weapon 			= GetWeapon (SPECTRAL_SHAKE_BOTTLE_WEAPON);

	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [SPECTRAL_SHAKE_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [SPECTRAL_SHAKE_PERK].off_model 	= SPECTRAL_SHAKE_MODEL_BUCKET;
		level.machine_assets [SPECTRAL_SHAKE_PERK].on_model 	= SPECTRAL_SHAKE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [SPECTRAL_SHAKE_PERK]						= SPECTRAL_SHAKE_MACHINE_LIGHT_FX;
		level.machine_assets [SPECTRAL_SHAKE_PERK].off_model 	= SPECTRAL_SHAKE_MACHINE_DISABLED_MODEL;
		level.machine_assets [SPECTRAL_SHAKE_PERK].on_model 	= SPECTRAL_SHAKE_MACHINE_ACTIVE_MODEL;	
	}
}

function spectral_shake_register_clientfield() 
{
	clientfield::register ("clientuimodel", SPECTRAL_SHAKE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function spectral_shake_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (SPECTRAL_SHAKE_CLIENTFIELD, state);
}

function spectral_shake_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= SPECTRAL_SHAKE_JINGLE;
	use_trigger.script_string 							= SPECTRAL_SHAKE_SCRIPT_STRING;
	use_trigger.script_label 							= SPECTRAL_SHAKE_STING;
	use_trigger.target 									= SPECTRAL_SHAKE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= SPECTRAL_SHAKE_SCRIPT_STRING;
	perk_machine.targetname 							= SPECTRAL_SHAKE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= SPECTRAL_SHAKE_SCRIPT_STRING;
}

function spectral_shake_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + SPECTRAL_SHAKE_ALIAS);
	
	self notify (SPECTRAL_SHAKE_PERK + "_start");	
	
	if (SPECTRAL_SHAKE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SPECTRAL_SHAKE_SECONDARY_PERKS.size; i++)
			self SetPerk (SPECTRAL_SHAKE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_spectral_shake = 1;
	
	self.spectral_shake_active = 0;
	self.spectral_shake_cooldown = 0;
	self.spectral_shake_should_boost = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = SPECTRAL_SHAKE_PERK;
	self notify ("west_perk_purchased");
}

function spectral_shake_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + SPECTRAL_SHAKE_ALIAS);
	self notify (SPECTRAL_SHAKE_PERK + "_stop");
	
	if (SPECTRAL_SHAKE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < SPECTRAL_SHAKE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (SPECTRAL_SHAKE_SECONDARY_PERKS [i]);
			
	if (IsDefined (self.spectral_shake_active) && self.spectral_shake_active == 1)
	{
		visionset_mgr::deactivate ("visionset", "spectral_shake_hidden", self);
		visionset_mgr::deactivate ("overlay", "spectral_shake_hidden", self);
		
		if (SPECTRAL_SHAKE_PLAY_SOUNDS == 1)
		{
			self StopLoopSound (1);
			self PlaySound ("zmb_bgb_idleeyes_end");
		}
		
		self zm_utility::decrement_ignoreme();
	}
	
	self.west_hasperk_spectral_shake = 0;
	
	self.spectral_shake_active = 0;
	self.spectral_shake_cooldown = 0;
	self.spectral_shake_should_boost = 0;
		
	if (IsDefined (self.spectral_shake_bar))
		self.spectral_shake_bar Destroy();
		
	if (IsDefined (self.spectral_shake_icon))
		self.spectral_shake_icon Destroy();
	
	self notify ("cooldown_bar_update");
}

function spectral_shake_host_migration_func()
{
	a_spectral_shake_machines = GetEntArray (SPECTRAL_SHAKE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_spectral_shake_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == SPECTRAL_SHAKE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (SPECTRAL_SHAKE_ALIAS);
		}
	}
}


// ======================================================================================================
// Stone Cold Stronghold
// ======================================================================================================

function enable_stone_cold_for_level()
{	
	zm_perks::register_perk_basic_info (STONE_COLD_PERK, STONE_COLD_ALIAS, STONE_COLD_COST, STONE_COLD_TRIG_STRING, GetWeapon (STONE_COLD_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (STONE_COLD_PERK, &stone_cold_precache);
	zm_perks::register_perk_clientfields (STONE_COLD_PERK, &stone_cold_register_clientfield, &stone_cold_set_clientfield);
	zm_perks::register_perk_machine (STONE_COLD_PERK, &stone_cold_machine_setup);
	zm_perks::register_perk_threads (STONE_COLD_PERK, &stone_cold_give_perk, &stone_cold_take_perk);
	zm_perks::register_perk_host_migration_params (STONE_COLD_PERK, STONE_COLD_RADIANT_MACHINE_NAME, STONE_COLD_PERK);
	//zm_perks::register_perk_machine_power_override (STONE_COLD_PERK, &stone_cold_host_migration_func);
}

function stone_cold_precache()
{
	level.machine_assets [STONE_COLD_PERK] 					= SpawnStruct();
	level.machine_assets [STONE_COLD_PERK].weapon 			= GetWeapon (STONE_COLD_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [STONE_COLD_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [STONE_COLD_PERK].off_model 	= STONE_COLD_MODEL_BUCKET;
		level.machine_assets [STONE_COLD_PERK].on_model		= STONE_COLD_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [STONE_COLD_PERK]						= STONE_COLD_MACHINE_LIGHT_FX;
		level.machine_assets [STONE_COLD_PERK].off_model 	= STONE_COLD_MACHINE_DISABLED_MODEL;
		level.machine_assets [STONE_COLD_PERK].on_model 	= STONE_COLD_MACHINE_ACTIVE_MODEL;	
	}
}

function stone_cold_register_clientfield() 
{
	clientfield::register ("clientuimodel", STONE_COLD_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function stone_cold_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (STONE_COLD_CLIENTFIELD, state);
}

function stone_cold_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= STONE_COLD_JINGLE;
		use_trigger.script_label 						= STONE_COLD_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= STONE_COLD_SCRIPT_STRING;
	use_trigger.target 									= STONE_COLD_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= STONE_COLD_SCRIPT_STRING;
	perk_machine.targetname 							= STONE_COLD_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= STONE_COLD_SCRIPT_STRING;
}

function stone_cold_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + STONE_COLD_ALIAS);
	
	self notify (STONE_COLD_PERK + "_start");	
	
	if (STONE_COLD_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < STONE_COLD_SECONDARY_PERKS.size; i++)
			self SetPerk (STONE_COLD_SECONDARY_PERKS [i]);
			
	self.west_hasperk_stone_cold = 1;
	self.stone_cold_armor = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = STONE_COLD_PERK;
	self notify ("west_perk_purchased");
}

function stone_cold_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + STONE_COLD_ALIAS);
	self notify (STONE_COLD_PERK + "_stop");
	
	if (STONE_COLD_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < STONE_COLD_SECONDARY_PERKS.size; i++)
			self UnsetPerk (STONE_COLD_SECONDARY_PERKS [i]);
			
	self.west_hasperk_stone_cold = 0;
	self.stone_cold_armor = 0;
	
	if (IsDefined (self.center_fx))
		self.center_fx delete();
		
	if (IsDefined (self.ring_fx))
		self.ring_fx delete();
		
	if (IsDefined (self.stone_cold_bar))
		self.stone_cold_bar Destroy();
	
	if (IsDefined (self.stone_cold_icon))
		self.stone_cold_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function stone_cold_host_migration_func()
{
	a_stone_cold_machines = GetEntArray (STONE_COLD_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_stone_cold_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == STONE_COLD_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (STONE_COLD_ALIAS);
		}
	}
}


// ======================================================================================================
// Tactiquilla Sangria
// ======================================================================================================

function enable_tactiquilla_for_level()
{	
	zm_perks::register_perk_basic_info( 				TACTIQUILLA_PERK, TACTIQUILLA_ALIAS, TACTIQUILLA_COST, TACTIQUILLA_TRIG_STRING, GetWeapon (TACTIQUILLA_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				TACTIQUILLA_PERK, &tactiquilla_precache);
	zm_perks::register_perk_clientfields( 				TACTIQUILLA_PERK, &tactiquilla_register_clientfield, &tactiquilla_set_clientfield);
	zm_perks::register_perk_machine( 					TACTIQUILLA_PERK, &tactiquilla_machine_setup);
	zm_perks::register_perk_threads( 					TACTIQUILLA_PERK, &tactiquilla_give_perk, &tactiquilla_take_perk);
	zm_perks::register_perk_host_migration_params( 		TACTIQUILLA_PERK, TACTIQUILLA_RADIANT_MACHINE_NAME, TACTIQUILLA_PERK);
	//zm_perks::register_perk_machine_power_override( 	TACTIQUILLA_PERK, &tactiquilla_host_migration_func);
}

function tactiquilla_precache()
{
	level.machine_assets [TACTIQUILLA_PERK] 				= SpawnStruct();
	level.machine_assets [TACTIQUILLA_PERK].weapon 			= GetWeapon (TACTIQUILLA_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [TACTIQUILLA_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [TACTIQUILLA_PERK].off_model 	= TACTIQUILLA_MODEL_BUCKET;
		level.machine_assets [TACTIQUILLA_PERK].on_model	= TACTIQUILLA_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [TACTIQUILLA_PERK]					= TACTIQUILLA_MACHINE_LIGHT_FX;
		level.machine_assets [TACTIQUILLA_PERK].off_model 	= TACTIQUILLA_MACHINE_DISABLED_MODEL;
		level.machine_assets [TACTIQUILLA_PERK].on_model 	= TACTIQUILLA_MACHINE_ACTIVE_MODEL;	
	}
}

function tactiquilla_register_clientfield() 
{
	clientfield::register ("clientuimodel", TACTIQUILLA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function tactiquilla_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (TACTIQUILLA_CLIENTFIELD, state);
}

function tactiquilla_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 								= TACTIQUILLA_JINGLE;
	use_trigger.script_string 								= TACTIQUILLA_SCRIPT_STRING;
	use_trigger.script_label 								= TACTIQUILLA_STING;
	use_trigger.target 										= TACTIQUILLA_RADIANT_MACHINE_NAME;
	perk_machine.script_string 								= TACTIQUILLA_SCRIPT_STRING;
	perk_machine.targetname 								= TACTIQUILLA_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 							= TACTIQUILLA_SCRIPT_STRING;
}

function tactiquilla_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self endon ("disconnect");
	self endon ("lost_" + TACTIQUILLA_ALIAS);	
	
	self notify (TACTIQUILLA_PERK + "_start");	
	
	if (TACTIQUILLA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TACTIQUILLA_SECONDARY_PERKS.size; i++)
			self SetPerk (TACTIQUILLA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_tactiquilla = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = TACTIQUILLA_PERK;
	self notify ("west_perk_purchased");
}

function tactiquilla_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + TACTIQUILLA_ALIAS);
	self notify (TACTIQUILLA_PERK + "_stop");
	
	if (TACTIQUILLA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TACTIQUILLA_SECONDARY_PERKS.size; i++)
			self UnsetPerk (TACTIQUILLA_SECONDARY_PERKS [i]);
			
	self.west_hasperk_tactiquilla = 0;
}

function tactiquilla_host_migration_func()
{
	a_tactiquilla_machines = GetEntArray (TACTIQUILLA_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_tactiquilla_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == TACTIQUILLA_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (TACTIQUILLA_ALIAS);
		}
	}
}


// ======================================================================================================
// Time Out Tequila
// ======================================================================================================

function enable_time_out_for_level()
{	
	zm_perks::register_perk_basic_info( 				TIME_OUT_PERK, TIME_OUT_ALIAS, TIME_OUT_COST, TIME_OUT_TRIG_STRING, GetWeapon (TIME_OUT_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				TIME_OUT_PERK, &time_out_precache);
	zm_perks::register_perk_clientfields( 				TIME_OUT_PERK, &time_out_register_clientfield, &time_out_set_clientfield);
	zm_perks::register_perk_machine( 					TIME_OUT_PERK, &time_out_machine_setup);
	zm_perks::register_perk_threads( 					TIME_OUT_PERK, &time_out_give_perk, &time_out_take_perk);
	zm_perks::register_perk_host_migration_params( 		TIME_OUT_PERK, TIME_OUT_RADIANT_MACHINE_NAME, TIME_OUT_PERK);
	
	visionset_mgr::register_info ("visionset", "time_out_hidden", 1, 112, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	visionset_mgr::register_info ("overlay", "time_out_hidden", 1, 112, 1, 1);
}

function time_out_precache()
{
	level.machine_assets [TIME_OUT_PERK] 				= SpawnStruct();
	level.machine_assets [TIME_OUT_PERK].weapon 		= GetWeapon (TIME_OUT_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [TIME_OUT_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [TIME_OUT_PERK].off_model 	= TIME_OUT_MODEL_BUCKET;
		level.machine_assets [TIME_OUT_PERK].on_model	= TIME_OUT_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [TIME_OUT_PERK]					= TIME_OUT_MACHINE_LIGHT_FX;
		level.machine_assets [TIME_OUT_PERK].off_model 	= TIME_OUT_MACHINE_DISABLED_MODEL;
		level.machine_assets [TIME_OUT_PERK].on_model 	= TIME_OUT_MACHINE_ACTIVE_MODEL;	
	}
}

function time_out_register_clientfield() 
{
	clientfield::register ("clientuimodel", TIME_OUT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function time_out_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (TIME_OUT_CLIENTFIELD, state);
}

function time_out_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= TIME_OUT_JINGLE;
	use_trigger.script_string 							= TIME_OUT_SCRIPT_STRING;
	use_trigger.script_label 							= TIME_OUT_STING;
	use_trigger.target 									= TIME_OUT_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= TIME_OUT_SCRIPT_STRING;
	perk_machine.targetname 							= TIME_OUT_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= TIME_OUT_SCRIPT_STRING;
}

function time_out_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + TIME_OUT_ALIAS);
	
	self notify (TIME_OUT_PERK + "_start");	
	
	if (TIME_OUT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TIME_OUT_SECONDARY_PERKS.size; i++)
			self SetPerk (TIME_OUT_SECONDARY_PERKS [i]);
			
	self.west_hasperk_time_out = 1;
	
	self.time_out_active = 0;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = TIME_OUT_PERK;
	self notify ("west_perk_purchased");
}

function time_out_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + TIME_OUT_ALIAS);
	self notify (TIME_OUT_PERK + "_stop");
	
	if (TIME_OUT_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TIME_OUT_SECONDARY_PERKS.size; i++)
			self UnsetPerk (TIME_OUT_SECONDARY_PERKS [i]);
			
	if (!self laststand::player_is_in_laststand() && "playing" == self.sessionstate)
	{
		self.west_hasperk_time_out = 0;
		self.time_out_active = 0;
	}
}

function time_out_host_migration_func()
{
	a_time_out_machines = GetEntArray (TIME_OUT_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_time_out_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == TIME_OUT_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (TIME_OUT_ALIAS);
		}
	}
}


// ======================================================================================================
// Timeslip
// ======================================================================================================

function enable_timeslip_for_level()
{	
	zm_perks::register_perk_basic_info( 				TIMESLIP_PERK, TIMESLIP_ALIAS, TIMESLIP_COST, TIMESLIP_TRIG_STRING, GetWeapon (TIMESLIP_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				TIMESLIP_PERK, &timeslip_precache);
	zm_perks::register_perk_clientfields( 				TIMESLIP_PERK, &timeslip_register_clientfield, &timeslip_set_clientfield);
	zm_perks::register_perk_machine( 					TIMESLIP_PERK, &timeslip_machine_setup);
	zm_perks::register_perk_threads( 					TIMESLIP_PERK, &timeslip_give_perk, &timeslip_take_perk);
	zm_perks::register_perk_host_migration_params( 		TIMESLIP_PERK, TIMESLIP_RADIANT_MACHINE_NAME, TIMESLIP_PERK);
}

function timeslip_precache()
{
	level.machine_assets [TIMESLIP_PERK] 				= SpawnStruct();
	level.machine_assets [TIMESLIP_PERK].weapon 		= GetWeapon (TIMESLIP_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [TIMESLIP_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [TIMESLIP_PERK].off_model 	= TIMESLIP_MODEL_BUCKET;
		level.machine_assets [TIMESLIP_PERK].on_model	= TIMESLIP_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [TIMESLIP_PERK]					= TIMESLIP_MACHINE_LIGHT_FX;
		level.machine_assets [TIMESLIP_PERK].off_model 	= TIMESLIP_MACHINE_DISABLED_MODEL;
		level.machine_assets [TIMESLIP_PERK].on_model 	= TIMESLIP_MACHINE_ACTIVE_MODEL;	
	}
}

function timeslip_register_clientfield() 
{
	clientfield::register ("clientuimodel", TIMESLIP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function timeslip_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (TIMESLIP_CLIENTFIELD, state);
}

function timeslip_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= TIMESLIP_JINGLE;
		use_trigger.script_label 						= TIMESLIP_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= TIMESLIP_SCRIPT_STRING;
	use_trigger.target 									= TIMESLIP_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= TIMESLIP_SCRIPT_STRING;
	perk_machine.targetname 							= TIMESLIP_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= TIMESLIP_SCRIPT_STRING;
}

function timeslip_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + TIMESLIP_ALIAS);
	
	self notify (TIMESLIP_PERK + "_start");	
	
	if (TIMESLIP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TIMESLIP_SECONDARY_PERKS.size; i++)
			self SetPerk (TIMESLIP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_timeslip = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = TIMESLIP_PERK;
	self notify ("west_perk_purchased");
}

function timeslip_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + TIMESLIP_ALIAS);
	self notify (TIMESLIP_PERK + "_stop");
	
	if (TIMESLIP_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TIMESLIP_SECONDARY_PERKS.size; i++)
			self UnsetPerk (TIMESLIP_SECONDARY_PERKS [i]);
			
	self.west_hasperk_timeslip = 0;
}

function timeslip_host_migration_func()
{
	a_timeslip_machines = GetEntArray (TIMESLIP_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_timeslip_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == TIMESLIP_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (TIMESLIP_ALIAS);
		}
	}
}


// ======================================================================================================
// Tombstone Soda
// ======================================================================================================

function enable_tombstone_soda_for_level()
{	
	zm_perks::register_perk_basic_info( 				TOMBSTONE_SODA_PERK, TOMBSTONE_SODA_ALIAS, TOMBSTONE_SODA_COST, TOMBSTONE_SODA_TRIG_STRING, GetWeapon (TOMBSTONE_SODA_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				TOMBSTONE_SODA_PERK, &tombstone_soda_precache);
	zm_perks::register_perk_clientfields( 				TOMBSTONE_SODA_PERK, &tombstone_soda_register_clientfield, &tombstone_soda_set_clientfield);
	zm_perks::register_perk_machine( 					TOMBSTONE_SODA_PERK, &tombstone_soda_machine_setup);
	zm_perks::register_perk_threads( 					TOMBSTONE_SODA_PERK, &tombstone_soda_give_perk, &tombstone_soda_take_perk);
	zm_perks::register_perk_host_migration_params( 		TOMBSTONE_SODA_PERK, TOMBSTONE_SODA_RADIANT_MACHINE_NAME, TOMBSTONE_SODA_PERK);
}

function tombstone_soda_precache()
{
	level._effect [TOMBSTONE_SODA_POWERUP_GRAB]			= TOMBSTONE_SODA_POWERUP_GRAB_FX;
	
	level.machine_assets [TOMBSTONE_SODA_PERK] 			= SpawnStruct();
	level.machine_assets [TOMBSTONE_SODA_PERK].weapon 	= GetWeapon (TOMBSTONE_SODA_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [TOMBSTONE_SODA_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [TOMBSTONE_SODA_PERK].off_model 	= TOMBSTONE_SODA_MODEL_BUCKET;
		level.machine_assets [TOMBSTONE_SODA_PERK].on_model		= TOMBSTONE_SODA_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [TOMBSTONE_SODA_PERK]						= TOMBSTONE_SODA_MACHINE_LIGHT_FX;
		level.machine_assets [TOMBSTONE_SODA_PERK].off_model 	= TOMBSTONE_SODA_MACHINE_DISABLED_MODEL;
		level.machine_assets [TOMBSTONE_SODA_PERK].on_model 	= TOMBSTONE_SODA_MACHINE_ACTIVE_MODEL;	
	}
}

function tombstone_soda_register_clientfield() 
{
	clientfield::register ("clientuimodel", TOMBSTONE_SODA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function tombstone_soda_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (TOMBSTONE_SODA_CLIENTFIELD, state);
}

function tombstone_soda_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= TOMBSTONE_SODA_JINGLE;
	use_trigger.script_string 							= TOMBSTONE_SODA_SCRIPT_STRING;
	use_trigger.script_label 							= TOMBSTONE_SODA_STING;
	use_trigger.target 									= TOMBSTONE_SODA_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= TOMBSTONE_SODA_SCRIPT_STRING;
	perk_machine.targetname 							= TOMBSTONE_SODA_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= TOMBSTONE_SODA_SCRIPT_STRING;
}

function tombstone_soda_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + TOMBSTONE_SODA_ALIAS);
	
	self notify (TOMBSTONE_SODA_PERK + "_start");	
	
	if (TOMBSTONE_SODA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TOMBSTONE_SODA_SECONDARY_PERKS.size; i++)
			self SetPerk (TOMBSTONE_SODA_SECONDARY_PERKS [i]);
			
	self notify ("tombstone_obtained");
	self.west_hasperk_tombstone = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = TOMBSTONE_SODA_PERK;
	self notify ("west_perk_purchased");
}

function tombstone_soda_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + TOMBSTONE_SODA_ALIAS);
	self notify (TOMBSTONE_SODA_PERK + "_stop");
	
	if (TOMBSTONE_SODA_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < TOMBSTONE_SODA_SECONDARY_PERKS.size; i++)
			self UnsetPerk (TOMBSTONE_SODA_SECONDARY_PERKS [i]);
	
	if (!self laststand::player_is_in_laststand() && "playing" == self.sessionstate)
		self.west_hasperk_tombstone = 0;
}

function tombstone_soda_host_migration_func()
{
	a_tombstone_soda_machines = GetEntArray (TOMBSTONE_SODA_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_tombstone_soda_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == TOMBSTONE_SODA_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (TOMBSTONE_SODA_ALIAS);
		}
	}
}


// ======================================================================================================
// Verruckt Juggernog
// ======================================================================================================

function enable_verruckt_jug_for_level()
{	
	zm_perks::register_perk_basic_info( 				VERRUCKT_JUG_PERK, VERRUCKT_JUG_ALIAS, VERRUCKT_JUG_COST, VERRUCKT_JUG_TRIG_STRING, GetWeapon (VERRUCKT_JUG_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				VERRUCKT_JUG_PERK, &verruckt_jug_precache);
	zm_perks::register_perk_clientfields( 				VERRUCKT_JUG_PERK, &verruckt_jug_register_clientfield, &verruckt_jug_set_clientfield);
	zm_perks::register_perk_machine( 					VERRUCKT_JUG_PERK, &verruckt_jug_machine_setup);
	zm_perks::register_perk_threads( 					VERRUCKT_JUG_PERK, &verruckt_jug_give_perk, &verruckt_jug_take_perk);
	zm_perks::register_perk_host_migration_params( 		VERRUCKT_JUG_PERK, VERRUCKT_JUG_RADIANT_MACHINE_NAME, VERRUCKT_JUG_PERK);
	//zm_perks::register_perk_machine_power_override( 	VERRUCKT_JUG_PERK, &verruckt_jug_host_migration_func);
}

function verruckt_jug_precache()
{
	level.machine_assets [VERRUCKT_JUG_PERK] 				= SpawnStruct();
	level.machine_assets [VERRUCKT_JUG_PERK].weapon 		= GetWeapon (VERRUCKT_JUG_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [VERRUCKT_JUG_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [VERRUCKT_JUG_PERK].off_model 	= VERRUCKT_JUG_MODEL_BUCKET;
		level.machine_assets [VERRUCKT_JUG_PERK].on_model	= VERRUCKT_JUG_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [VERRUCKT_JUG_PERK]					= VERRUCKT_JUG_MACHINE_LIGHT_FX;
		level.machine_assets [VERRUCKT_JUG_PERK].off_model 	= VERRUCKT_JUG_MACHINE_DISABLED_MODEL;
		level.machine_assets [VERRUCKT_JUG_PERK].on_model 	= VERRUCKT_JUG_MACHINE_ACTIVE_MODEL;	
	}
}

function verruckt_jug_register_clientfield() 
{
	clientfield::register ("clientuimodel", VERRUCKT_JUG_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function verruckt_jug_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (VERRUCKT_JUG_CLIENTFIELD, state);
}

function verruckt_jug_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= VERRUCKT_JUG_JINGLE;
	use_trigger.script_string 							= VERRUCKT_JUG_SCRIPT_STRING;
	use_trigger.script_label 							= VERRUCKT_JUG_STING;
	use_trigger.target 									= VERRUCKT_JUG_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= VERRUCKT_JUG_SCRIPT_STRING;
	perk_machine.targetname 							= VERRUCKT_JUG_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= VERRUCKT_JUG_SCRIPT_STRING;
}

function verruckt_jug_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self endon ("disconnect");
	self endon ("lost_" + VERRUCKT_JUG_ALIAS);	
	
	self notify (VERRUCKT_JUG_PERK + "_start");	
	
	if (VERRUCKT_JUG_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VERRUCKT_JUG_SECONDARY_PERKS.size; i++)
			self SetPerk (VERRUCKT_JUG_SECONDARY_PERKS [i]);
			
	self.west_hasperk_verruckt_jug = 1;

	self.maxhealth = level.zombie_vars ["player_base_health"] + VERRUCKT_PLAYER_INCREASE_HEALTH;
	
	if (self HasPerk ("specialty_armorvest"))
		self.maxhealth += level.zombie_vars ["zombie_perk_juggernaut_health"];
		
	self.health = self.maxhealth;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = VERRUCKT_JUG_PERK;
	self notify ("west_perk_purchased");
}

function verruckt_jug_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + VERRUCKT_JUG_ALIAS);
	self notify (VERRUCKT_JUG_PERK + "_stop");
	
	if (VERRUCKT_JUG_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VERRUCKT_JUG_SECONDARY_PERKS.size; i++)
			self UnsetPerk (VERRUCKT_JUG_SECONDARY_PERKS [i]);
			
	self.west_hasperk_verruckt_jug = 0;
	
	if (self HasPerk ("specialty_armorvest"))
		self zm_perks::perk_set_max_health_if_jugg ("specialty_armorvest", true, false);
	
	else
		self.maxhealth = level.zombie_vars ["player_base_health"];
}

function verruckt_jug_host_migration_func()
{
	a_verruckt_jug_machines = GetEntArray (VERRUCKT_JUG_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_verruckt_jug_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == VERRUCKT_JUG_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (VERRUCKT_JUG_ALIAS);
		}
	}
}


// ======================================================================================================
// Victorious Tortoise
// ======================================================================================================

function enable_victorious_tortoise_for_level()
{	
	zm_perks::register_perk_basic_info( 				VICTORIOUS_TORTOISE_PERK, VICTORIOUS_TORTOISE_ALIAS, VICTORIOUS_TORTOISE_COST, VICTORIOUS_TORTOISE_TRIG_STRING, GetWeapon (VICTORIOUS_TORTOISE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_precache);
	zm_perks::register_perk_clientfields( 				VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_register_clientfield, &victorious_tortoise_set_clientfield);
	zm_perks::register_perk_machine( 					VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_machine_setup);
	zm_perks::register_perk_threads( 					VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_give_perk, &victorious_tortoise_take_perk);
	zm_perks::register_perk_host_migration_params( 		VICTORIOUS_TORTOISE_PERK, VICTORIOUS_TORTOISE_RADIANT_MACHINE_NAME, VICTORIOUS_TORTOISE_PERK);
	//zm_perks::register_perk_machine_power_override( 	VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_host_migration_func);
}

function victorious_tortoise_precache()
{
	level.machine_assets [VICTORIOUS_TORTOISE_PERK] 			= SpawnStruct();
	level.machine_assets [VICTORIOUS_TORTOISE_PERK].weapon 		= GetWeapon (VICTORIOUS_TORTOISE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [VICTORIOUS_TORTOISE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [VICTORIOUS_TORTOISE_PERK].off_model 	= VICTORIOUS_TORTOISE_MODEL_BUCKET;
		level.machine_assets [VICTORIOUS_TORTOISE_PERK].on_model	= VICTORIOUS_TORTOISE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [VICTORIOUS_TORTOISE_PERK]					= VICTORIOUS_TORTOISE_MACHINE_LIGHT_FX;
		level.machine_assets [VICTORIOUS_TORTOISE_PERK].off_model 	= VICTORIOUS_TORTOISE_MACHINE_DISABLED_MODEL;
		level.machine_assets [VICTORIOUS_TORTOISE_PERK].on_model 	= VICTORIOUS_TORTOISE_MACHINE_ACTIVE_MODEL;	
	}
}

function victorious_tortoise_register_clientfield() 
{
	clientfield::register ("clientuimodel", VICTORIOUS_TORTOISE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function victorious_tortoise_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (VICTORIOUS_TORTOISE_CLIENTFIELD, state);
}

function victorious_tortoise_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= VICTORIOUS_TORTOISE_JINGLE;
		use_trigger.script_label 						= VICTORIOUS_TORTOISE_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= VICTORIOUS_TORTOISE_SCRIPT_STRING;
	use_trigger.target 									= VICTORIOUS_TORTOISE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= VICTORIOUS_TORTOISE_SCRIPT_STRING;
	perk_machine.targetname 							= VICTORIOUS_TORTOISE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= VICTORIOUS_TORTOISE_SCRIPT_STRING;
}

function victorious_tortoise_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self endon ("disconnect");
	self endon ("lost_" + VICTORIOUS_TORTOISE_ALIAS);	
	
	self notify (VICTORIOUS_TORTOISE_PERK + "_start");	
	
	if (VICTORIOUS_TORTOISE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VICTORIOUS_TORTOISE_SECONDARY_PERKS.size; i++)
			self SetPerk (VICTORIOUS_TORTOISE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_victorious = 1;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = VICTORIOUS_TORTOISE_PERK;
	self notify ("west_perk_purchased");
}

function victorious_tortoise_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + VICTORIOUS_TORTOISE_ALIAS);
	self notify (VICTORIOUS_TORTOISE_PERK + "_stop");
	
	if (VICTORIOUS_TORTOISE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VICTORIOUS_TORTOISE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (VICTORIOUS_TORTOISE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_victorious = 0;
}

function victorious_tortoise_host_migration_func()
{
	a_victorious_tortoise_machines = GetEntArray (VICTORIOUS_TORTOISE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_victorious_tortoise_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == VICTORIOUS_TORTOISE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (VICTORIOUS_TORTOISE_ALIAS);
		}
	}
}


// ======================================================================================================
// Vigor Rush
// ======================================================================================================

function enable_vigor_rush_for_level()
{	
	zm_perks::register_perk_basic_info( 				VIGOR_RUSH_PERK, VIGOR_RUSH_ALIAS, VIGOR_RUSH_COST, VIGOR_RUSH_TRIG_STRING, GetWeapon (VIGOR_RUSH_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				VIGOR_RUSH_PERK, &vigor_rush_precache);
	zm_perks::register_perk_clientfields( 				VIGOR_RUSH_PERK, &vigor_rush_register_clientfield, &vigor_rush_set_clientfield);
	zm_perks::register_perk_machine( 					VIGOR_RUSH_PERK, &vigor_rush_machine_setup);
	zm_perks::register_perk_threads( 					VIGOR_RUSH_PERK, &vigor_rush_give_perk, &vigor_rush_take_perk);
	zm_perks::register_perk_host_migration_params( 		VIGOR_RUSH_PERK, VIGOR_RUSH_RADIANT_MACHINE_NAME, VIGOR_RUSH_PERK);
}

function vigor_rush_precache()
{
	level._effect [VIGOR_RUSH_EXPLOSION_FX] 			= VIGOR_RUSH_EXPLOSION_FX_FILE;
	
	level.machine_assets [VIGOR_RUSH_PERK] 				= SpawnStruct();
	level.machine_assets [VIGOR_RUSH_PERK].weapon 		= GetWeapon (VIGOR_RUSH_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [VIGOR_RUSH_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [VIGOR_RUSH_PERK].off_model 	= VIGOR_RUSH_MODEL_BUCKET;
		level.machine_assets [VIGOR_RUSH_PERK].on_model		= VIGOR_RUSH_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [VIGOR_RUSH_PERK]						= VIGOR_RUSH_MACHINE_LIGHT_FX;
		level.machine_assets [VIGOR_RUSH_PERK].off_model 	= VIGOR_RUSH_MACHINE_DISABLED_MODEL;
		level.machine_assets [VIGOR_RUSH_PERK].on_model 	= VIGOR_RUSH_MACHINE_ACTIVE_MODEL;	
	}
}

function vigor_rush_register_clientfield() 
{
	clientfield::register ("clientuimodel", VIGOR_RUSH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function vigor_rush_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (VIGOR_RUSH_CLIENTFIELD, state);
}

function vigor_rush_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= VIGOR_RUSH_JINGLE;
	use_trigger.script_string 							= VIGOR_RUSH_SCRIPT_STRING;
	use_trigger.script_label 							= VIGOR_RUSH_STING;
	use_trigger.target 									= VIGOR_RUSH_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= VIGOR_RUSH_SCRIPT_STRING;
	perk_machine.targetname 							= VIGOR_RUSH_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= VIGOR_RUSH_SCRIPT_STRING;
}

function vigor_rush_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + VIGOR_RUSH_ALIAS);
	
	self notify (VIGOR_RUSH_PERK + "_start");	
	
	if (VIGOR_RUSH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VIGOR_RUSH_SECONDARY_PERKS.size; i++)
			self SetPerk (VIGOR_RUSH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_vigor_rush = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = VIGOR_RUSH_PERK;
	self notify ("west_perk_purchased");
}

function vigor_rush_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + VIGOR_RUSH_ALIAS);
	self notify (VIGOR_RUSH_PERK + "_stop");
	
	if (VIGOR_RUSH_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < VIGOR_RUSH_SECONDARY_PERKS.size; i++)
			self UnsetPerk (VIGOR_RUSH_SECONDARY_PERKS [i]);
			
	self.west_hasperk_vigor_rush = 0;
}

function vigor_rush_host_migration_func()
{
	a_vigor_rush_machines = GetEntArray (VIGOR_RUSH_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_vigor_rush_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == VIGOR_RUSH_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (VIGOR_RUSH_ALIAS);
		}
	}
}


// ======================================================================================================
// Wall Power
// ======================================================================================================

function enable_wall_power_for_level()
{	
	zm_perks::register_perk_basic_info( 				WALL_POWER_PERK, WALL_POWER_ALIAS, WALL_POWER_COST, WALL_POWER_TRIG_STRING, GetWeapon (WALL_POWER_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				WALL_POWER_PERK, &wall_power_precache);
	zm_perks::register_perk_clientfields( 				WALL_POWER_PERK, &wall_power_register_clientfield, &wall_power_set_clientfield);
	zm_perks::register_perk_machine( 					WALL_POWER_PERK, &wall_power_machine_setup);
	zm_perks::register_perk_threads( 					WALL_POWER_PERK, &wall_power_give_perk, &wall_power_take_perk);
	zm_perks::register_perk_host_migration_params( 		WALL_POWER_PERK, WALL_POWER_RADIANT_MACHINE_NAME, WALL_POWER_PERK);
	//zm_perks::register_perk_machine_power_override( 	WALL_POWER_PERK, &wall_power_host_migration_func);
}

function wall_power_precache()
{
	level.machine_assets [WALL_POWER_PERK] 					= SpawnStruct();
	level.machine_assets [WALL_POWER_PERK].weapon 			= GetWeapon (WALL_POWER_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [WALL_POWER_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [WALL_POWER_PERK].off_model 	= WALL_POWER_MODEL_BUCKET;
		level.machine_assets [WALL_POWER_PERK].on_model		= WALL_POWER_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [WALL_POWER_PERK]						= WALL_POWER_MACHINE_LIGHT_FX;
		level.machine_assets [WALL_POWER_PERK].off_model 	= WALL_POWER_MACHINE_DISABLED_MODEL;
		level.machine_assets [WALL_POWER_PERK].on_model 	= WALL_POWER_MACHINE_ACTIVE_MODEL;	
	}
}

function wall_power_register_clientfield() 
{
	clientfield::register ("clientuimodel", WALL_POWER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function wall_power_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (WALL_POWER_CLIENTFIELD, state);
}

function wall_power_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= WALL_POWER_JINGLE;
	use_trigger.script_string 							= WALL_POWER_SCRIPT_STRING;
	use_trigger.script_label 							= WALL_POWER_STING;
	use_trigger.target 									= WALL_POWER_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= WALL_POWER_SCRIPT_STRING;
	perk_machine.targetname 							= WALL_POWER_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= WALL_POWER_SCRIPT_STRING;
}

function wall_power_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + WALL_POWER_ALIAS);
	
	self notify (WALL_POWER_PERK + "_start");	
	
	if (WALL_POWER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WALL_POWER_SECONDARY_PERKS.size; i++)
			self SetPerk (WALL_POWER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_wall_power = 1;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = WALL_POWER_PERK;
	self notify ("west_perk_purchased");
}

function wall_power_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self notify ("perk_lost", str_perk);
	self notify ("lost_" + WALL_POWER_ALIAS);
	self notify (WALL_POWER_PERK + "_stop");
	
	if (WALL_POWER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WALL_POWER_SECONDARY_PERKS.size; i++)
			self UnsetPerk (WALL_POWER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_wall_power = 0;
}

function wall_power_host_migration_func()
{
	a_wall_power_machines = GetEntArray (WALL_POWER_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_wall_power_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == WALL_POWER_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (WALL_POWER_ALIAS);
		}
	}
}


// ======================================================================================================
// Widows Wine
// ======================================================================================================

function enable_widows_wine_for_level()
{	
	zm_perks::register_perk_basic_info( 				WIDOWS_WINE_PERK, WIDOWS_WINE_ALIAS, WIDOWS_WINE_COST, WIDOWS_WINE_TRIG_STRING, GetWeapon (WIDOWS_WINE_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				WIDOWS_WINE_PERK, &widows_wine_precache);
	zm_perks::register_perk_clientfields( 				WIDOWS_WINE_PERK, &widows_wine_register_clientfield, &widows_wine_set_clientfield);
	zm_perks::register_perk_machine( 					WIDOWS_WINE_PERK, &widows_wine_machine_setup);
	zm_perks::register_perk_threads( 					WIDOWS_WINE_PERK, &widows_wine_give_perk, &widows_wine_take_perk);
	zm_perks::register_perk_host_migration_params( 		WIDOWS_WINE_PERK, WIDOWS_WINE_RADIANT_MACHINE_NAME, WIDOWS_WINE_PERK);
	//zm_perks::register_perk_machine_power_override( 	WIDOWS_WINE_PERK, &widows_wine_host_migration_func);
	
	zm_utility::register_slowdown ("widows_wine_cocoon", WIDOWS_WINE_COCOON_SLOWDOWN, 1.0);
	zm_utility::register_slowdown ("widows_wine_slowdown", WIDOWS_WINE_SLOW_SLOWDOWN, 1.0);
	
	zm_utility::register_lethal_grenade_for_level (WIDOWS_WINE_WPN_GRENADE);
	level.w_widows_wine_wpn_grenade = GetWeapon (WIDOWS_WINE_WPN_GRENADE);
	
	zm_utility::register_melee_weapon_for_level (WIDOWS_WINE_WPN_KNIFE);
	level.w_widows_wine_wpn_knife = GetWeapon (WIDOWS_WINE_WPN_KNIFE);
	
	zm_utility::register_melee_weapon_for_level (WIDOWS_WINE_WPN_KNIFE_BOWIE);
	level.w_widows_wine_wpn_knife_bowie = GetWeapon (WIDOWS_WINE_WPN_KNIFE_BOWIE);
	
	zm_powerups::register_powerup (WIDOWS_WINE_POWERUP_ALIAS, &grab_widows_wine_grenade);
	zm_powerups::add_zombie_powerup (WIDOWS_WINE_POWERUP_ALIAS, WIDOWS_WINE_POWERUP_MODEL, &"ZOMBIE_POWERUP_WW_GRENADE", &zm_powerups::func_should_never_drop, POWERUP_ONLY_AFFECTS_GRABBER, !POWERUP_ANY_TEAM, !POWERUP_ZOMBIE_GRABBABLE);
	zm_powerups::powerup_set_player_specific (WIDOWS_WINE_POWERUP_ALIAS, POWERUP_FOR_SPECIFIC_PLAYER);
}

function widows_wine_precache()
{
	level.machine_assets [WIDOWS_WINE_PERK] 				= SpawnStruct();
	level.machine_assets [WIDOWS_WINE_PERK].weapon 			= GetWeapon (WIDOWS_WINE_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [WIDOWS_WINE_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [WIDOWS_WINE_PERK].off_model 	= WIDOWS_WINE_MODEL_BUCKET;
		level.machine_assets [WIDOWS_WINE_PERK].on_model	= WIDOWS_WINE_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [WIDOWS_WINE_PERK]					= WIDOWS_WINE_MACHINE_LIGHT_FX;
		level.machine_assets [WIDOWS_WINE_PERK].off_model 	= WIDOWS_WINE_MACHINE_DISABLED_MODEL;
		level.machine_assets [WIDOWS_WINE_PERK].on_model 	= WIDOWS_WINE_MACHINE_ACTIVE_MODEL;	
	}
}

function widows_wine_register_clientfield() 
{
	clientfield::register ("clientuimodel", WIDOWS_WINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
	clientfield::register ("toplayer", "widows_wine_1p_contact_explosion", VERSION_SHIP, 1, "counter");
	clientfield::register ("actor", "widows_wine_wrapping", VERSION_SHIP, 1, "int");
	clientfield::register ("vehicle", "widows_wine_wrapping", VERSION_SHIP, 1, "int");
}

function widows_wine_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (WIDOWS_WINE_CLIENTFIELD, state);
}

function widows_wine_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 							= WIDOWS_WINE_JINGLE;
	use_trigger.script_string 							= WIDOWS_WINE_SCRIPT_STRING;
	use_trigger.script_label 							= WIDOWS_WINE_STING;
	use_trigger.target 									= WIDOWS_WINE_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= WIDOWS_WINE_SCRIPT_STRING;
	perk_machine.targetname 							= WIDOWS_WINE_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= WIDOWS_WINE_SCRIPT_STRING;
}

function widows_wine_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + WIDOWS_WINE_ALIAS);
	
	self notify (WIDOWS_WINE_PERK + "_start");	
	
	if (WIDOWS_WINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WIDOWS_WINE_SECONDARY_PERKS.size; i++)
			self SetPerk (WIDOWS_WINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_widows_wine = 1;
	
	//If Glitching Gin uses Lethal slot, remove Glitching Gin
	if ((IsDefined (self.west_hasperk_glitching_gin) && self.west_hasperk_glitching_gin == 1) && GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		self glitching_gin_take_perk (false, GLITCHING_GIN_PERK + "_stop", GLITCHING_GIN_PERK + "_stop");
		
	self.west_perk_purchase [self.west_perk_purchase.size] = WIDOWS_WINE_PERK;
	self notify ("west_perk_purchased");
}

function widows_wine_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self notify ("perk_lost", str_perk);
	self notify ("lost_" + WIDOWS_WINE_ALIAS);
	self notify (WIDOWS_WINE_PERK + "_stop");
	
	if (WIDOWS_WINE_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WIDOWS_WINE_SECONDARY_PERKS.size; i++)
			self UnsetPerk (WIDOWS_WINE_SECONDARY_PERKS [i]);
			
	self.west_hasperk_widows_wine = 0;
	
	current_grenade = self zm_utility::get_player_lethal_grenade();
	
	if (IsDefined (current_grenade))
		self zm_weapons::weapon_take (current_grenade);
		
	WAIT_SERVER_FRAME;

	if (IsDefined (self.w_widows_wine_prev))
	{
		self zm_weapons::weapon_give (self.w_widows_wine_prev, false, false, true, false);
		
		self.lsgsar_lethal = self.w_widows_wine_prev;
		self zm_utility::set_player_lethal_grenade (self.w_widows_wine_prev);
		grenade = self zm_utility::get_player_lethal_grenade();
	}
	
	else
	{
		self zm_weapons::weapon_give (level.zombie_lethal_grenade_player_init, false, false, true, false);
		self.lsgsar_lethal = level.zombie_lethal_grenade_player_init;
		self zm_utility::set_player_lethal_grenade (level.zombie_lethal_grenade_player_init);
		grenade = self zm_utility::get_player_lethal_grenade();
	}	
	
	if (IsDefined (grenade))
		self GiveStartAmmo (grenade);
}

function widows_wine_host_migration_func()
{
	a_widows_wine_machines = GetEntArray (WIDOWS_WINE_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_widows_wine_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == WIDOWS_WINE_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (WIDOWS_WINE_ALIAS);
		}
	}
}

function grab_widows_wine_grenade (player)
{	
	player thread zm_powerups::powerup_vo ("bonus_points_solo");
	
	if (IsDefined (player.west_hasperk_widows_wine) && player.west_hasperk_widows_wine == 1)
		if (!player laststand::player_is_in_laststand() && !(player.sessionstate == "spectator"))
			player thread community_perk_collection::common_give_ammo (player.current_lethal_grenade, WIDOWS_WINE_POWERUP_GIVE);
}


// ======================================================================================================
// Windrunner Whiskey
// ======================================================================================================

function enable_windrunner_for_level()
{	
	zm_perks::register_perk_basic_info( 						WINDRUNNER_PERK, WINDRUNNER_ALIAS, WINDRUNNER_COST, WINDRUNNER_TRIG_STRING, GetWeapon (WINDRUNNER_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 						WINDRUNNER_PERK, &windrunner_precache);
	zm_perks::register_perk_clientfields( 						WINDRUNNER_PERK, &windrunner_register_clientfield, &windrunner_set_clientfield);
	zm_perks::register_perk_machine( 							WINDRUNNER_PERK, &windrunner_machine_setup);
	zm_perks::register_perk_threads( 							WINDRUNNER_PERK, &windrunner_give_perk, &windrunner_take_perk);
	zm_perks::register_perk_host_migration_params( 				WINDRUNNER_PERK, WINDRUNNER_RADIANT_MACHINE_NAME, WINDRUNNER_PERK);
}

function windrunner_precache()
{
	level.machine_assets [WINDRUNNER_PERK]	 				= SpawnStruct();
	level.machine_assets [WINDRUNNER_PERK].weapon 			= GetWeapon (WINDRUNNER_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [WINDRUNNER_PERK]						= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [WINDRUNNER_PERK].off_model 	= WINDRUNNER_MODEL_BUCKET;
		level.machine_assets [WINDRUNNER_PERK].on_model 	= WINDRUNNER_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [WINDRUNNER_PERK]						= WINDRUNNER_MACHINE_LIGHT_FX;
		level.machine_assets [WINDRUNNER_PERK].off_model 	= WINDRUNNER_MACHINE_DISABLED_MODEL;
		level.machine_assets [WINDRUNNER_PERK].on_model 	= WINDRUNNER_MACHINE_ACTIVE_MODEL;	
	}
}

function windrunner_register_clientfield() 
{
	clientfield::register ("clientuimodel", WINDRUNNER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function windrunner_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (WINDRUNNER_CLIENTFIELD, state);
}

function windrunner_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound 									= WINDRUNNER_JINGLE;
	use_trigger.script_string 									= WINDRUNNER_SCRIPT_STRING;
	use_trigger.script_label 									= WINDRUNNER_STING;
	use_trigger.target 											= WINDRUNNER_RADIANT_MACHINE_NAME;
	perk_machine.script_string 									= WINDRUNNER_SCRIPT_STRING;
	perk_machine.targetname 									= WINDRUNNER_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 								= WINDRUNNER_SCRIPT_STRING;
}

function windrunner_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + WINDRUNNER_ALIAS);
	
	self notify (WINDRUNNER_PERK + "_start");	
	
	if (WINDRUNNER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WINDRUNNER_SECONDARY_PERKS.size; i++)
			self SetPerk (WINDRUNNER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_windrunner = 1;
	self.windrunner_on_cooldown = 0;
	
	self.west_perk_purchase [self.west_perk_purchase.size] = WINDRUNNER_PERK;
	self notify ("west_perk_purchased");
}

function windrunner_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + WINDRUNNER_ALIAS);
	self notify (WINDRUNNER_PERK + "_stop");
	
	if (WINDRUNNER_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WINDRUNNER_SECONDARY_PERKS.size; i++)
			self UnsetPerk (WINDRUNNER_SECONDARY_PERKS [i]);
			
	self.west_hasperk_windrunner = 0;
	self.windrunner_on_cooldown = 0;
	
	if (IsDefined (self.windrunner_bar))
		self.windrunner_bar Destroy();
		
	if (IsDefined (self.windrunner_icon))
		self.windrunner_icon Destroy();
	
	self notify ("cooldown_bar_update");
}

function windrunner_host_migration_func()
{
	a_windrunner_machines = GetEntArray (WINDRUNNER_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_windrunner_machines )
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == WINDRUNNER_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (WINDRUNNER_ALIAS);
		}
	}
}


// ======================================================================================================
// Winter's Wail
// ======================================================================================================

function enable_winters_wail_for_level()
{	
	zm_perks::register_perk_basic_info (WINTERS_WAIL_PERK, WINTERS_WAIL_ALIAS, WINTERS_WAIL_COST, WINTERS_WAIL_TRIG_STRING, GetWeapon (WINTERS_WAIL_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func (WINTERS_WAIL_PERK, &winters_wail_precache);
	zm_perks::register_perk_clientfields (WINTERS_WAIL_PERK, &winters_wail_register_clientfield, &winters_wail_set_clientfield);
	zm_perks::register_perk_machine (WINTERS_WAIL_PERK, &winters_wail_machine_setup);
	zm_perks::register_perk_threads (WINTERS_WAIL_PERK, &winters_wail_give_perk, &winters_wail_take_perk);
	zm_perks::register_perk_host_migration_params (WINTERS_WAIL_PERK, WINTERS_WAIL_RADIANT_MACHINE_NAME, WINTERS_WAIL_PERK);
	//zm_perks::register_perk_machine_power_override (WINTERS_WAIL_PERK, &winters_wail_host_migration_func);

	zm_utility::register_slowdown ("winters_wail_freeze_0", WINTERS_WAIL_FROZEN_RATE_CLOSE, 1.0);
	zm_utility::register_slowdown ("winters_wail_freeze_1", WINTERS_WAIL_FROZEN_RATE_MID, 1.0);
	zm_utility::register_slowdown ("winters_wail_freeze_2", WINTERS_WAIL_FROZEN_RATE_FAR, 1.0);
}

function winters_wail_precache()
{
	level.machine_assets [WINTERS_WAIL_PERK] 			= SpawnStruct();
	level.machine_assets [WINTERS_WAIL_PERK].weapon 	= GetWeapon (WINTERS_WAIL_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [WINTERS_WAIL_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [WINTERS_WAIL_PERK].off_model 	= WINTERS_WAIL_MODEL_BUCKET;
		level.machine_assets [WINTERS_WAIL_PERK].on_model	= WINTERS_WAIL_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [WINTERS_WAIL_PERK]					= WINTERS_WAIL_MACHINE_LIGHT_FX;
		level.machine_assets [WINTERS_WAIL_PERK].off_model 	= WINTERS_WAIL_MACHINE_DISABLED_MODEL;
		level.machine_assets [WINTERS_WAIL_PERK].on_model 	= WINTERS_WAIL_MACHINE_ACTIVE_MODEL;	
	}
}

function winters_wail_register_clientfield() 
{
	clientfield::register ("clientuimodel", WINTERS_WAIL_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function winters_wail_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (WINTERS_WAIL_CLIENTFIELD, state);
}

function winters_wail_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= WINTERS_WAIL_JINGLE;
		use_trigger.script_label 						= WINTERS_WAIL_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= WINTERS_WAIL_SCRIPT_STRING;
	use_trigger.target 									= WINTERS_WAIL_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= WINTERS_WAIL_SCRIPT_STRING;
	perk_machine.targetname 							= WINTERS_WAIL_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= WINTERS_WAIL_SCRIPT_STRING;
}

function winters_wail_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + WINTERS_WAIL_ALIAS);
	
	self notify (WINTERS_WAIL_PERK + "_start");	
	
	if (WINTERS_WAIL_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WINTERS_WAIL_SECONDARY_PERKS.size; i++)
			self SetPerk (WINTERS_WAIL_SECONDARY_PERKS [i]);
			
	self.west_hasperk_winters_wail = 1;
	self.winters_wail_charges = WINTERS_WAIL_MAX_CHARGES;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = WINTERS_WAIL_PERK;
	self notify ("west_perk_purchased");
}

function winters_wail_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER

	self notify ("perk_lost", str_perk);
	self notify ("lost_" + WINTERS_WAIL_ALIAS);
	self notify (WINTERS_WAIL_PERK + "_stop");
	
	if (WINTERS_WAIL_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < WINTERS_WAIL_SECONDARY_PERKS.size; i++)
			self UnsetPerk (WINTERS_WAIL_SECONDARY_PERKS [i]);
			
	self.west_hasperk_winters_wail = 0;
	self.winters_wail_charges = 0;
	
	if (IsDefined (self.winters_wail_bar))
		self.winters_wail_bar Destroy();
		
	if (IsDefined (self.winters_wail_icon))
		self.winters_wail_icon Destroy();
		
	if (IsDefined (self.winters_wail_hud_icon))
		self.winters_wail_hud_icon Destroy();
		
	if (IsDefined (self.winters_wail_hud_icon_text))
		self.winters_wail_hud_icon_text Destroy();
		
	self notify ("cooldown_bar_update");
}

function winters_wail_host_migration_func()
{
	a_winters_wail_machines = GetEntArray (WINTERS_WAIL_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_winters_wail_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == WINTERS_WAIL_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (WINTERS_WAIL_ALIAS);
		}
	}
}


// ======================================================================================================
// Wunderfizz
// ======================================================================================================

function enable_wunderfizz_for_level()
{	
	level._random_zombie_perk_cost = WUNDERFIZZ_COST;
	
	clientfield::register ("zbarrier", "wunderfizz_set_client_light_state", 5000, 2, "int");
	clientfield::register ("zbarrier", "wunderfizz_client_stone_emmissive_blink", 5000, 1, "int");
	clientfield::register ("zbarrier", "wunderfizz_init_perk_random_machine", 5000, 1, "int");
	//clientfield::register ("scriptmover", "wunderfizz_turn_active_perk_light_green", 5000, 1, "int");
	//clientfield::register ("scriptmover", "wunderfizz_turn_on_location_indicator", 5000, 1, "int");
	clientfield::register ("zbarrier", "wunderfizz_lightning_bolt_FX_toggle", 10000, 1, "int");
	//clientfield::register ("scriptmover", "wunderfizz_turn_active_perk_ball_light", 5000, 1, "int");
	//clientfield::register ("scriptmover", "wunderfizz_zone_captured", 5000, 1, "int");
	
	level flag::init ("machine_can_reset");
}


// ======================================================================================================
// Zombshell
// ======================================================================================================

function enable_zombshell_for_level()
{	
	zm_perks::register_perk_basic_info( 				ZOMBSHELL_PERK, ZOMBSHELL_ALIAS, ZOMBSHELL_COST, ZOMBSHELL_TRIG_STRING, GetWeapon (ZOMBSHELL_BOTTLE_WEAPON));
	zm_perks::register_perk_precache_func( 				ZOMBSHELL_PERK, &zombshell_precache);
	zm_perks::register_perk_clientfields( 				ZOMBSHELL_PERK, &zombshell_register_clientfield, &zombshell_set_clientfield);
	zm_perks::register_perk_machine( 					ZOMBSHELL_PERK, &zombshell_machine_setup);
	zm_perks::register_perk_threads( 					ZOMBSHELL_PERK, &zombshell_give_perk, &zombshell_take_perk);
	zm_perks::register_perk_host_migration_params( 		ZOMBSHELL_PERK, ZOMBSHELL_RADIANT_MACHINE_NAME, ZOMBSHELL_PERK);
	//zm_perks::register_perk_machine_power_override( 	ZOMBSHELL_PERK, &zombshell_host_migration_func);
	
	zm_utility::register_slowdown ("zombshell_field", ZOMBSHELL_ZOMBIE_SLOWDOWN_RATE, ZOMBSHELL_ZOMBIE_SLOWDOWN_TIME);
}

function zombshell_precache()
{
	level.machine_assets[ZOMBSHELL_PERK] 				= SpawnStruct();
	level.machine_assets[ZOMBSHELL_PERK].weapon 		= GetWeapon (ZOMBSHELL_BOTTLE_WEAPON);
	
	if (USE_BUCKET_MODEL == 1)
	{
		level._effect [ZOMBSHELL_PERK]					= COMMON_MODEL_BUCKET_FX;
		level.machine_assets [ZOMBSHELL_PERK].off_model = ZOMBSHELL_MODEL_BUCKET;
		level.machine_assets [ZOMBSHELL_PERK].on_model	= ZOMBSHELL_MODEL_BUCKET;
	}
	
	else
	{
		level._effect [ZOMBSHELL_PERK]					= ZOMBSHELL_MACHINE_LIGHT_FX;
		level.machine_assets [ZOMBSHELL_PERK].off_model = ZOMBSHELL_MACHINE_DISABLED_MODEL;
		level.machine_assets [ZOMBSHELL_PERK].on_model 	= ZOMBSHELL_MACHINE_ACTIVE_MODEL;	
	}
}

function zombshell_register_clientfield() 
{
	clientfield::register ("clientuimodel", ZOMBSHELL_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int");
}

function zombshell_set_clientfield (state) 
{
	self clientfield::set_player_uimodel (ZOMBSHELL_CLIENTFIELD, state);
}

function zombshell_machine_setup (use_trigger, perk_machine, bump_trigger, collision)
{
	if (ALLOW_AI_PERK_JINGLES == 1)
	{
		use_trigger.script_sound 						= ZOMBSHELL_JINGLE;
		use_trigger.script_label 						= ZOMBSHELL_STING;
	}
	
	else
	{
		use_trigger.script_sound 						= "none";
		use_trigger.script_label 						= "none";
	}
	
	use_trigger.script_string 							= ZOMBSHELL_SCRIPT_STRING;
	use_trigger.target 									= ZOMBSHELL_RADIANT_MACHINE_NAME;
	perk_machine.script_string 							= ZOMBSHELL_SCRIPT_STRING;
	perk_machine.targetname 							= ZOMBSHELL_RADIANT_MACHINE_NAME;
	if (IsDefined (bump_trigger))
		bump_trigger.script_string 						= ZOMBSHELL_SCRIPT_STRING;
}

function zombshell_give_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	self endon ("lost_" + ZOMBSHELL_ALIAS);
	
	self notify (ZOMBSHELL_PERK + "_start");	
	
	if (ZOMBSHELL_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ZOMBSHELL_SECONDARY_PERKS.size; i++)
			self SetPerk (ZOMBSHELL_SECONDARY_PERKS [i]);
			
	self.west_hasperk_zombshell = 1;
			
	self.zombshell_field_active = 0;
	self.zombshell_on_cooldown = 0;
			
	self.west_perk_purchase [self.west_perk_purchase.size] = ZOMBSHELL_PERK;
	self notify ("west_perk_purchased");
}

function zombshell_take_perk (b_pause, str_perk, str_result)
{
	//SELF == PLAYER
	
	self notify ("perk_lost", str_perk);
	self notify ("lost_" + ZOMBSHELL_ALIAS);
	self notify (ZOMBSHELL_PERK + "_stop");
	
	if (ZOMBSHELL_USE_SECONDARY_PERKS == 1)
		for (i = 0; i < ZOMBSHELL_SECONDARY_PERKS.size; i++)
			self UnsetPerk (ZOMBSHELL_SECONDARY_PERKS [i]);
			
	self.west_hasperk_zombshell = 0;
	
	self.zombshell_field_active = 0;
	self.zombshell_on_cooldown = 0;
		
	if (IsDefined (self.zombshell_bar))
		self.zombshell_bar Destroy();
		
	if (IsDefined (self.zombshell_icon))
		self.zombshell_icon Destroy();
		
	self notify ("cooldown_bar_update");
}

function zombshell_host_migration_func()
{
	a_zombshell_machines = GetEntArray (ZOMBSHELL_RADIANT_MACHINE_NAME, "targetname");
	
	foreach (perk_machine in a_zombshell_machines)
	{
		if (IsDefined (perk_machine.model) && perk_machine.model == ZOMBSHELL_MACHINE_ACTIVE_MODEL)
		{
			perk_machine zm_perks::perk_fx (undefined, 1);
			perk_machine thread zm_perks::perk_fx (ZOMBSHELL_ALIAS);
		}
	}
}
