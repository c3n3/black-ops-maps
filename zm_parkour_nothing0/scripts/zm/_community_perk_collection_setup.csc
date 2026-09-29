#using scripts\codescripts\struct;

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

#using scripts\zm\_zm;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;

#insert scripts\shared\duplicaterender.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\zm\_community_perk_collection.gsh;

//-----Lighting Fx-----
#precache ("client_fx", COMMON_MODEL_BUCKET_FX);

//Abnormal202
#precache ("client_fx", "west/perks/abnormal202_perk_cryo_light");
#precache ("client_fx", "west/perks/abnormal202_perk_wind_light");

//BetiroVal
#precache ("client_fx", "west/perks/betiroval_fx_perk_blazephase_light");
#precache ("client_fx", "west/perks/betiroval_fx_perk_slurpentine_light");
#precache ("client_fx", "west/perks/betiroval_fx_perk_timeslip_light");

//HarryBo21
#precache ("client_fx", "west/perks/harry_fx_perk_daiquiri_light");
#precache ("client_fx", "west/perks/harry_fx_perk_doubletap_light");
#precache ("client_fx", "west/perks/harry_fx_perk_electric_cherry_light");
#precache ("client_fx", "west/perks/harry_fx_perk_elemental_pop_light");
#precache ("client_fx", "west/perks/harry_fx_perk_juggernaut_light");
//#precache ("client_fx", "west/perks/harry_fx_perk_mule_kick_light");
#precache ("client_fx", "west/perks/harry_fx_perk_quick_revive_light");
#precache ("client_fx", "west/perks/harry_fx_perk_sleight_of_hand_light");
#precache ("client_fx", "west/perks/harry_fx_perk_stamin_up_light");
#precache ("client_fx", "west/perks/harry_fx_perk_tombstone_light");
#precache ("client_fx", "west/perks/harry_fx_perk_vulture_aid_light");
#precache ("client_fx", "west/perks/harry_fx_perk_widows_wine_light");

//Holofya
#precache ("client_fx", "west/perks/holofya_glitch_perk_light");

//Kaizokuroof
#precache ("client_fx", "west/perks/kaizokuroof_fx_perk_atomic_liqueur_light");

//Khel Mho
#precache ("client_fx", "west/perks/km_fx_perk_vigor_rush_zmb");

//Logical
#precache ("client_fx", "west/perks/logical_double_dew");
#precache ("client_fx", "west/perks/logical_fighterfizz_light");
#precache ("client_fx", "west/perks/logical_icu_light");
#precache ("client_fx", "west/perks/logical_muscle_milk_light");
#precache ("client_fx", "west/perks/logical_tactiquilla_sangria_light");

//Mikey Ray
#precache ("client_fx", "west/perks/mikey_ray_phd_flopper_light");

//Sphynx
#precache ("client_fx", "west/perks/sphynx_fx_perk_death_perception_light");

//-----Gameplay Fx-----
#precache ("client_fx", DIVINE_ALE_WEAPON_GLOW_FX);

#precache ("client_fx", ELECTRIC_CHERRY_FX_DEATH_FILE);
#precache ("client_fx", ELECTRIC_CHERRY_FX_EXPLODE_FILE);
#precache ("client_fx", ELECTRIC_CHERRY_FX_SHOCK_FILE);
#precache ("client_fx", ELECTRIC_CHERRY_FX_SHOCK_EYES_FILE);
#precache ("client_fx", ELECTRIC_CHERRY_FX_TRAIL_FILE);

#precache ("client_fx", GLITCHING_GIN_GRENADE_AOE_EXPLODE);
#precache ("client_fx", GLITCHING_GIN_GRENADE_EXPLODE);
#precache ("client_fx", GLITCHING_GIN_GRENADE_IMPACT);

#precache ("client_fx", SLURPENTINE_FX_POISON_EYES);

#precache ("client_fx", SNAILS_PACE_ZOMBIE_EYE_FX);

#precache ("client_fx", WIDOWS_WINE_FX_WEB_1P);
#precache ("client_fx", WIDOWS_WINE_FX_WRAP);

#precache ("client_fx", WUNDERFIZZ_FX_GREEN);
#precache ("client_fx", WUNDERFIZZ_FX_LOCATION);
#precache ("client_fx", WUNDERFIZZ_FX_RED);

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
	zm_perks::register_perk_clientfields( 				AMMO_AMERICANO_PERK, &ammo_americano_client_field_func, &ammo_americano_callback_func);
	zm_perks::register_perk_effects( 					AMMO_AMERICANO_PERK, AMMO_AMERICANO_PERK);
	zm_perks::register_perk_init_thread( 				AMMO_AMERICANO_PERK, &ammo_americano_init);
}

function ammo_americano_init()
{
	level._effect [AMMO_AMERICANO_PERK]					= AMMO_AMERICANO_MACHINE_LIGHT_FX;
}

function ammo_americano_client_field_func() 
{
	clientfield::register ("clientuimodel", AMMO_AMERICANO_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function ammo_americano_callback_func() {}


// ======================================================================================================
// Astro Ale
// ======================================================================================================

function enable_astro_ale_for_level()
{
	zm_perks::register_perk_clientfields( 				ASTRO_ALE_PERK, &astro_ale_client_field_func, &astro_ale_callback_func);
	zm_perks::register_perk_effects( 					ASTRO_ALE_PERK, ASTRO_ALE_PERK);
	zm_perks::register_perk_init_thread( 				ASTRO_ALE_PERK, &astro_ale_init);
}

function astro_ale_init()
{
	level._effect [ASTRO_ALE_PERK]						= ASTRO_ALE_MACHINE_LIGHT_FX;
}

function astro_ale_client_field_func() 
{
	clientfield::register ("clientuimodel", ASTRO_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function astro_ale_callback_func() {}


// ======================================================================================================
// Atomic Liqueur
// ======================================================================================================

function enable_atomic_liqueur_for_level()
{
	zm_perks::register_perk_clientfields( 				ATOMIC_LIQUEUR_PERK, &atomic_liqueur_client_field_func, &atomic_liqueur_callback_func);
	zm_perks::register_perk_effects( 					ATOMIC_LIQUEUR_PERK, ATOMIC_LIQUEUR_PERK);
	zm_perks::register_perk_init_thread( 				ATOMIC_LIQUEUR_PERK, &atomic_liqueur_init);
}

function atomic_liqueur_init()
{
	level._effect [ATOMIC_LIQUEUR_PERK]					= ATOMIC_LIQUEUR_MACHINE_LIGHT_FX;
}

function atomic_liqueur_client_field_func() 
{
	clientfield::register ("clientuimodel", ATOMIC_LIQUEUR_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function atomic_liqueur_callback_func() {}


// ======================================================================================================
// Banana Colada
// ======================================================================================================

function enable_banana_colada_for_level()
{
	zm_perks::register_perk_clientfields (		BANANA_COLADA_PERK, &banana_colada_client_field_func, &banana_colada_callback_func);
	zm_perks::register_perk_effects (			BANANA_COLADA_PERK, BANANA_COLADA_PERK);
	zm_perks::register_perk_init_thread (		BANANA_COLADA_PERK, &banana_colada_init);
}

function banana_colada_init()
{
	level._effect [BANANA_COLADA_PERK] 			= BANANA_COLADA_MACHINE_LIGHT_FX;
}

function banana_colada_client_field_func() 
{
	clientfield::register ("clientuimodel", BANANA_COLADA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function banana_colada_callback_func() {}


// ======================================================================================================
// Bandolier Bandit
// ======================================================================================================

function enable_bandolier_bandit_for_level()
{
	zm_perks::register_perk_clientfields( 				BANDOLIER_BANDIT_PERK, &bandolier_bandit_client_field_func, &bandolier_bandit_callback_func);
	zm_perks::register_perk_effects( 					BANDOLIER_BANDIT_PERK, BANDOLIER_BANDIT_PERK);
	zm_perks::register_perk_init_thread( 				BANDOLIER_BANDIT_PERK, &bandolier_bandit_init);
}

function bandolier_bandit_init()
{
	level._effect [BANDOLIER_BANDIT_PERK]				= BANDOLIER_BANDIT_MACHINE_LIGHT_FX;
}

function bandolier_bandit_client_field_func() 
{
	clientfield::register ("clientuimodel", BANDOLIER_BANDIT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function bandolier_bandit_callback_func() {}


// ======================================================================================================
// Blaze Phase
// ======================================================================================================

function enable_blaze_phase_for_level()
{
	zm_perks::register_perk_clientfields (		BLAZE_PHASE_PERK, &blaze_phase_client_field_func, &blaze_phase_callback_func);
	zm_perks::register_perk_effects (			BLAZE_PHASE_PERK, BLAZE_PHASE_PERK);
	zm_perks::register_perk_init_thread (		BLAZE_PHASE_PERK, &blaze_phase_init);
}

function blaze_phase_init()
{
	level._effect [BLAZE_PHASE_PERK] 			= BLAZE_PHASE_MACHINE_LIGHT_FX;
}

function blaze_phase_client_field_func() 
{
	clientfield::register ("clientuimodel", BLAZE_PHASE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function blaze_phase_callback_func() {}


// ======================================================================================================
// Bleeding Bloody Mary
// ======================================================================================================

function enable_bleeding_for_level()
{
	zm_perks::register_perk_clientfields( 				BLEEDING_PERK, &bleeding_client_field_func, &bleeding_callback_func);
	zm_perks::register_perk_effects( 					BLEEDING_PERK, BLEEDING_PERK);
	zm_perks::register_perk_init_thread( 				BLEEDING_PERK, &bleeding_init);
}

function bleeding_init()
{
	level._effect [BLEEDING_PERK]						= BLEEDING_MACHINE_LIGHT_FX;
}

function bleeding_client_field_func() 
{
	clientfield::register ("clientuimodel", BLEEDING_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function bleeding_callback_func() {}


// ======================================================================================================
// Blood Wolf Bite
// ======================================================================================================

function enable_blood_wolf_for_level()
{
	zm_perks::register_perk_clientfields( 				BLOOD_WOLF_PERK, &blood_wolf_client_field_func, &blood_wolf_callback_func);
	zm_perks::register_perk_effects( 					BLOOD_WOLF_PERK, BLOOD_WOLF_PERK);
	zm_perks::register_perk_init_thread( 				BLOOD_WOLF_PERK, &blood_wolf_init);
}

function blood_wolf_init()
{
	level._effect [BLOOD_WOLF_PERK]						= BLOOD_WOLF_MACHINE_LIGHT_FX;
}

function blood_wolf_client_field_func() 
{
	clientfield::register ("actor", "LUNA", VERSION_SHIP, 1, "int", &zm_luna_name_caller, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("clientuimodel", BLOOD_WOLF_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function blood_wolf_callback_func() {}

function zm_luna_name_caller (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	//SELF == LUNA

	if (newVal)
		self SetDrawName ("^7LUNA" , true);
}


// ======================================================================================================
// Brawlstar Punch
// ======================================================================================================

function enable_brawlstar_punch_for_level()
{
	zm_perks::register_perk_clientfields( 				BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_client_field_func, &brawlstar_punch_callback_func);
	zm_perks::register_perk_effects( 					BRAWLSTAR_PUNCH_PERK, BRAWLSTAR_PUNCH_PERK);
	zm_perks::register_perk_init_thread( 				BRAWLSTAR_PUNCH_PERK, &brawlstar_punch_init);
}

function brawlstar_punch_init()
{
	level._effect [BRAWLSTAR_PUNCH_PERK]				= BRAWLSTAR_PUNCH_MACHINE_LIGHT_FX;
}

function brawlstar_punch_client_field_func() 
{
	clientfield::register ("clientuimodel", BRAWLSTAR_PUNCH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function brawlstar_punch_callback_func() {}


// ======================================================================================================
// Brimstone Bramble
// ======================================================================================================

function enable_brimstone_bramble_for_level()
{
	zm_perks::register_perk_clientfields( 				BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_client_field_func, &brimstone_bramble_callback_func);
	zm_perks::register_perk_effects( 					BRIMSTONE_BRAMBLE_PERK, BRIMSTONE_BRAMBLE_PERK);
	zm_perks::register_perk_init_thread( 				BRIMSTONE_BRAMBLE_PERK, &brimstone_bramble_init);
}

function brimstone_bramble_init()
{
	level._effect[ BRIMSTONE_BRAMBLE_PERK ]				= BRIMSTONE_BRAMBLE_MACHINE_LIGHT_FX;
}

function brimstone_bramble_client_field_func() 
{
	clientfield::register ("clientuimodel", BRIMSTONE_BRAMBLE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function brimstone_bramble_callback_func() {}


// ======================================================================================================
// Bull Ice Blast
// ======================================================================================================

function enable_bull_ice_blast_for_level()
{
	zm_perks::register_perk_clientfields( 				BULL_ICE_BLAST_PERK, &bull_ice_blast_client_field_func, &bull_ice_blast_callback_func);
	zm_perks::register_perk_effects( 					BULL_ICE_BLAST_PERK, BULL_ICE_BLAST_PERK);
	zm_perks::register_perk_init_thread( 				BULL_ICE_BLAST_PERK, &bull_ice_blast_init);
}

function bull_ice_blast_init()
{
	level._effect [BULL_ICE_BLAST_PERK]					= BULL_ICE_BLAST_MACHINE_LIGHT_FX;
}

function bull_ice_blast_client_field_func() 
{
	clientfield::register ("clientuimodel", BULL_ICE_BLAST_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function bull_ice_blast_callback_func() {}


// ======================================================================================================
// Crack Shot Cremat
// ======================================================================================================

function enable_crack_shot_for_level()
{
	zm_perks::register_perk_clientfields( 				CRACK_SHOT_PERK, &crack_shot_client_field_func, &crack_shot_callback_func);
	zm_perks::register_perk_effects( 					CRACK_SHOT_PERK, CRACK_SHOT_PERK);
	zm_perks::register_perk_init_thread( 				CRACK_SHOT_PERK, &crack_shot_init);
}

function crack_shot_init()
{
	level._effect[ CRACK_SHOT_PERK ]					= CRACK_SHOT_MACHINE_LIGHT_FX;
}

function crack_shot_client_field_func() 
{
	clientfield::register ("clientuimodel", CRACK_SHOT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function crack_shot_callback_func() {}


// ======================================================================================================
// Crusader's Ale
// ======================================================================================================

function enable_crusaders_ale_for_level()
{
	zm_perks::register_perk_clientfields (		CRUSADERS_ALE_PERK, &crusaders_ale_client_field_func, &crusaders_ale_callback_func);
	zm_perks::register_perk_effects (			CRUSADERS_ALE_PERK, CRUSADERS_ALE_PERK);
	zm_perks::register_perk_init_thread (		CRUSADERS_ALE_PERK, &crusaders_ale_init);
}

function crusaders_ale_init()
{
	level._effect [CRUSADERS_ALE_PERK] 			= CRUSADERS_ALE_MACHINE_LIGHT_FX;
}

function crusaders_ale_client_field_func() 
{
	clientfield::register ("clientuimodel", CRUSADERS_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function crusaders_ale_callback_func() {}


// ======================================================================================================
// Cryo-Slide Soda
// ======================================================================================================

function enable_cryo_slide_for_level()
{
	zm_perks::register_perk_clientfields( 				CRYO_SLIDE_PERK, &cryo_slide_client_field_func, &cryo_slide_callback_func);
	zm_perks::register_perk_effects( 					CRYO_SLIDE_PERK, CRYO_SLIDE_PERK);
	zm_perks::register_perk_init_thread( 				CRYO_SLIDE_PERK, &cryo_slide_init);
}

function cryo_slide_init()
{
	level._effect [CRYO_SLIDE_PERK]						= CRYO_SLIDE_MACHINE_LIGHT_FX;
}

function cryo_slide_client_field_func() 
{
	clientfield::register ("clientuimodel", CRYO_SLIDE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function cryo_slide_callback_func() {}


// ======================================================================================================
// Death Perception
// ======================================================================================================

function enable_death_perception_for_level()
{
	zm_perks::register_perk_clientfields( 				DEATH_PERCEPTION_PERK, &death_perception_client_field_func, &death_perception_callback_func);
	zm_perks::register_perk_effects( 					DEATH_PERCEPTION_PERK, DEATH_PERCEPTION_PERK);
	zm_perks::register_perk_init_thread( 				DEATH_PERCEPTION_PERK, &death_perception_init);
}

function death_perception_init()
{
	level._effect [DEATH_PERCEPTION_PERK]				= DEATH_PERCEPTION_MACHINE_LIGHT_FX;
}

function death_perception_client_field_func() 
{
	clientfield::register ("toplayer", DEATH_PERCEPTION_PERK_TOPLAYER_CF, VERSION_SHIP, 1, "int", &perk_death_perception_visuals, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("clientuimodel", DEATH_PERCEPTION_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	duplicate_render::set_dr_filter_offscreen ("death_perception", 30, "death_perception_active", undefined, DR_TYPE_OFFSCREEN, DEATH_PERCEPTION_KEYLINE_MAT, DR_CULL_NEVER);
}

function death_perception_callback_func() {}

function player_spawn_death_perception (localClientNum)
{
	self thread OED_SitRepScan_OnSpawned (localClientNum);
}

function private OED_SitRepScan_OnSpawned (localClientNum)
{
	self endon ("entityshutdown");
	self endon ("disconnect");
	self endon ("death");
	self endon ("bled_out");

	self notify ("OED_SitRepScan_OnSpawned");
	self endon ("OED_SitRepScan_OnSpawned");

	while (IsDefined (self) && IsAlive (self))
	{
		self OED_SitRepScan_Enable (3);
        self OED_SitRepScan_SetOutline (1);
        self OED_SitRepScan_SetSolid (0);
        self OED_SitRepScan_SetLineWidth (1.5);
        self OED_SitRepScan_SetRadius (1400);
        self OED_SitRepScan_SetFalloff (1);
        self OED_SitRepScan_SetDesat (0);

		WAIT_CLIENT_FRAME;
	}
}

function perk_death_perception_visuals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (IsSpectating (localclientnum))
		return;
		
	if (newval && (!(IsDefined (level.var_dc60105c) && level.var_dc60105c)) && !IsIGCActive (localclientnum))
	{
		level.var_1c1febec [localclientnum] = true;
		a_ai = function_793a9f3d(localclientnum);
		
		foreach (ai in a_ai)
			ai thread function_731d83de (localclientnum);
			
		self thread function_fff5377e (localclientnum);
	}
	
	else
	{
		level.var_1c1febec [localclientnum] = false;
		a_ai = function_793a9f3d (localclientnum);
		
		foreach (ai in a_ai)
			ai function_5d482e78 (localclientnum);
			
		self notify (#"hash_45ed6efeef67b773");
	}
}

function function_731d83de (localclientnum)
{
	if(level.var_1c1febec [localclientnum] && self.team == "axis")
	{
		self function_bf9d3071 (localclientnum);
		
		while(IsDefined (self) && IsAlive(self))
			WAIT_CLIENT_FRAME;

		self function_5d482e78 (localclientnum);
	}
}

function function_5d482e78 (localclientnum)
{
	self duplicate_render::update_dr_flag (localclientnum, "death_perception_active", 0);
}

function function_bf9d3071 (localclientnum)
{
	self duplicate_render::update_dr_flag (localclientnum, "death_perception_active", 1);
}


function function_fff5377e (localclientnum)
{
	self endon ("death");
	self endon (#"hash_45ed6efeef67b773");
	
	for(;;)
	{
		if (!(IsDefined (level.var_dc60105c) && level.var_dc60105c) && !IsIGCActive (localclientnum))
		{
			a_ai = function_793a9f3d (localclientnum);
			var_8475afc1 = AnglesToForward (self.angles);
			
			foreach (ai in a_ai)
			{
				if (!IsDefined (ai.var_1c1febed))
					ai.var_1c1febed = [];

				if (IsDefined (ai) && IsAlive (ai))
				{
					if ((VectorDot (var_8475afc1, VectorNormalize (ai.origin - self.origin) ) < .35 ) && DistanceSquared (self.origin, ai.origin) <= 10000)
					{
						if (!IS_TRUE(ai.var_1c1febed [localclientnum]))
						{
							var_f2c7b8b0 = ai.origin;
							
							if (ai.type === "vehicle")
								var_f2c7b8b0 = (ai.origin[0], ai.origin[1], self.origin[2]);
								
							self thread death_perception_indicator_cooldown (localclientnum, ai);
							self AddAwarenessIndicator (var_f2c7b8b0, DEATH_PERCEPTION_DANGER_ICON);
						}
					}
				}
			}
		}
		
		WAIT_CLIENT_FRAME;
	}
}

function death_perception_indicator_cooldown (localclientnum, ai)
{
	ai.var_1c1febed [localclientnum] = true;
	self util::waittill_any_ex (2, ai, "death");

	if (IsDefined (ai))
		ai.var_1c1febed [localclientnum] = false;
}

function private function_793a9f3d (localclientnum)
{
	a_ai = GetEntArrayByType (localclientnum, ET_ACTOR);
	a_vh = GetEntArrayByType (localclientnum, ET_VEHICLE);
	a_ai = ArrayCombine (a_ai, a_vh, false, false);
	
	if (a_ai.size)
		a_ai = array::filter (a_ai, 0, &function_6a5f77);
		
	return a_ai;
}

function function_6a5f77(val)
{
	return val.team == "axis";
}

function function_25410869(localclientnum)
{
	if (self == GetLocalPlayer (localclientnum))
	{
		value = self clientfield::get_to_player ("perk_death_perception_visuals");
		self perk_death_perception_visuals (localclientnum, undefined, value, undefined, undefined, undefined, undefined);
	}
}

function function_dd6c1a8b (localclientnum, b_igc_active)
{
	self function_25410869 (localclientnum);
}


// ======================================================================================================
// Divine Ale
// ======================================================================================================

function enable_divine_ale_for_level()
{
	zm_perks::register_perk_clientfields( 	DIVINE_ALE_PERK, &divine_ale_client_field_func, &divine_ale_callback_func);
	zm_perks::register_perk_effects( 		DIVINE_ALE_PERK, DIVINE_ALE_PERK);
	zm_perks::register_perk_init_thread( 	DIVINE_ALE_PERK, &divine_ale_init);
}

function divine_ale_init()
{
	level._effect [DIVINE_ALE_PERK]			= DIVINE_ALE_MACHINE_LIGHT_FX;
}

function divine_ale_client_field_func() 
{
	clientfield::register ("clientuimodel", DIVINE_ALE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("toplayer", "divine_ale_fx_view", VERSION_SHIP, 1, "int", &divine_ale_fx_view, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("allplayers", "divine_ale_fx_world",  VERSION_SHIP, 1, "int", &divine_ale_fx_world, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function divine_ale_callback_func() {}

function divine_ale_fx_view (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	//SELF == PLAYER
	
    if (newVal)
    {
        if (IsDefined (self.divine_ale_glow_fx_view))
            KillFx (localClientNum, self.divine_ale_glow_fx_view);
			
		self.divine_ale_glow_fx_view = PlayViewmodelFx (localclientnum, DIVINE_ALE_WEAPON_GLOW_FX, "tag_weapon");
    }
	
    else
    {
        if (IsDefined (self.divine_ale_glow_fx_view))
        {
            KillFx (localClientNum, self.divine_ale_glow_fx_view);
            self.divine_ale_glow_fx_view = undefined;
        }
    }
}

function divine_ale_fx_world (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	//SELF == PLAYER
	
    if (newVal)
    {
        curr_player = GetLocalPlayer (localClientNum);

        if (IsDefined (self.divine_ale_glow_fx_world))
            KillFx (localClientNum, self.divine_ale_glow_fx_world);

        if (curr_player != self)
			self.divine_ale_glow_fx_world = PlayFxOnTag (localClientNum, DIVINE_ALE_WEAPON_GLOW_FX, self, "tag_weapon");
    }
	
    else
    {
        if (IsDefined (self.divine_ale_glow_fx_world))
        {
            KillFx (localClientNum, self.divine_ale_glow_fx_world);
            self.divine_ale_glow_fx_world = undefined;
        }
    }
}


// ======================================================================================================
// Double Dew
// ======================================================================================================

function enable_double_dew_for_level()
{
	zm_perks::register_perk_clientfields( 				DOUBLE_DEW_PERK, &double_dew_client_field_func, &double_dew_callback_func);
	zm_perks::register_perk_effects( 					DOUBLE_DEW_PERK, DOUBLE_DEW_PERK);
	zm_perks::register_perk_init_thread( 				DOUBLE_DEW_PERK, &double_dew_init);
}

function double_dew_init()
{
	level._effect[ DOUBLE_DEW_PERK ]					= DOUBLE_DEW_MACHINE_LIGHT_FX;
}

function double_dew_client_field_func() 
{
	clientfield::register ("clientuimodel", DOUBLE_DEW_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function double_dew_callback_func() {}


// ======================================================================================================
// Double Tap 1.0
// ======================================================================================================

function enable_doubletap1_for_level()
{
	zm_perks::register_perk_clientfields( 				DOUBLETAP1_PERK, &doubletap1_client_field_func, &doubletap1_callback_func);
	zm_perks::register_perk_effects( 					DOUBLETAP1_PERK, DOUBLETAP1_PERK);
	zm_perks::register_perk_init_thread( 				DOUBLETAP1_PERK, &doubletap1_init);
}

function doubletap1_init()
{
	level._effect[ DOUBLETAP1_PERK ]					= DOUBLETAP1_MACHINE_LIGHT_FX;
}

function doubletap1_client_field_func() 
{
	clientfield::register ("clientuimodel", DOUBLETAP1_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function doubletap1_callback_func() {}


// ======================================================================================================
// Double Tap 3.0
// ======================================================================================================

function enable_doubletap3_for_level()
{
	zm_perks::register_perk_clientfields( 				DOUBLETAP3_PERK, &doubletap3_client_field_func, &doubletap3_callback_func);
	zm_perks::register_perk_effects( 					DOUBLETAP3_PERK, DOUBLETAP3_PERK);
	zm_perks::register_perk_init_thread( 				DOUBLETAP3_PERK, &doubletap3_init);
}

function doubletap3_init()
{
	level._effect [DOUBLETAP3_PERK]						= DOUBLETAP3_MACHINE_LIGHT_FX;
}

function doubletap3_client_field_func() 
{
	clientfield::register ("clientuimodel", DOUBLETAP3_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function doubletap3_callback_func() {}


// ======================================================================================================
// Dying Wish
// ======================================================================================================

function enable_dying_wish_for_level()
{
	zm_perks::register_perk_clientfields( 			DYING_WISH_PERK, &dying_wish_client_field_func, &dying_wish_callback_func);
	zm_perks::register_perk_effects( 				DYING_WISH_PERK, DYING_WISH_PERK);
	zm_perks::register_perk_init_thread( 			DYING_WISH_PERK, &dying_wish_init);
	
	visionset_mgr::register_visionset_info ("dying_wish_berserk", 1, 31, undefined, "zm_bgb_in_plain_sight");
	visionset_mgr::register_overlay_info_style_postfx_bundle ("dying_wish_berserk", 1, 1, "pstfx_zm_bgb_in_plain_sight");
}

function dying_wish_init()
{
	level._effect [DYING_WISH_PERK]					= DYING_WISH_MACHINE_LIGHT_FX;
}

function dying_wish_client_field_func() 
{
	clientfield::register ("clientuimodel", DYING_WISH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function dying_wish_callback_func() {}


// ======================================================================================================
// Electric Cherry
// ======================================================================================================

function enable_electric_cherry_for_level()
{
	zm_perks::register_perk_clientfields( 				ELECTRIC_CHERRY_PERK, &electric_cherry_client_field_func, &electric_cherry_callback_func);
	zm_perks::register_perk_effects( 					ELECTRIC_CHERRY_PERK, ELECTRIC_CHERRY_PERK);
	zm_perks::register_perk_init_thread( 				ELECTRIC_CHERRY_PERK, &electric_cherry_init);
}

function electric_cherry_init()
{
	level._effect [ELECTRIC_CHERRY_PERK]				= ELECTRIC_CHERRY_MACHINE_LIGHT_FX;
	
	// Register Clientfields
	RegisterClientField ("allplayers", 	"electric_cherry_fx_reload",	VERSION_SHIP, 2, "int", &electric_cherry_reload_attack_fx, false);
	clientfield::register ("actor", 	"electric_cherry_fx_tesla_death", VERSION_SHIP, 1, "int", &tesla_death_fx_callback, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register ("vehicle", 	"electric_cherry_fx_tesla_death_vehicle", VERSION_TU10, 1, "int", &tesla_death_fx_callback, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT); // Leave at VERSION_TU10
	clientfield::register ("actor", 	"electric_cherry_fx_tesla_shock_eyes", VERSION_SHIP, 1, "int", &tesla_shock_eyes_fx_callback, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("vehicle", 	"electric_cherry_fx_tesla_shock_eyes_vehicle", VERSION_TU10, 1, "int", &tesla_shock_eyes_fx_callback, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT); // Leave at VERSION_TU10

	// Load FX	
	level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME]		= ELECTRIC_CHERRY_FX_EXPLODE_FILE;
	level._effect [ELECTRIC_CHERRY_FX_TRAIL_NAME]		= ELECTRIC_CHERRY_FX_TRAIL_FILE;
	level._effect [ELECTRIC_CHERRY_FX_DEATH_NAME]		= ELECTRIC_CHERRY_FX_DEATH_FILE;
	level._effect [ELECTRIC_CHERRY_FX_SHOCK_EYES_NAME]	= ELECTRIC_CHERRY_FX_SHOCK_EYES_FILE;
	level._effect [ELECTRIC_CHERRY_FX_SHOCK_NAME]		= ELECTRIC_CHERRY_FX_SHOCK_FILE;
}

function electric_cherry_client_field_func() 
{
	clientfield::register ("clientuimodel", ELECTRIC_CHERRY_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function electric_cherry_callback_func() {}

function electric_cherry_reload_attack_fx (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{	
	if (IsDefined (self.electric_cherry_reload_fx))
		StopFX (localClientNum, self.electric_cherry_reload_fx);			
	
	if (newVal == 1)
		self.electric_cherry_reload_fx = PlayFXOnTag (localClientNum, level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME], self, "tag_origin");

	else if (newVal == 2)
		self.electric_cherry_reload_fx = PlayFXOnTag (localClientNum, level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME], self, "tag_origin");

	else if (newVal == 3)
		self.electric_cherry_reload_fx = PlayFXOnTag (localClientNum, level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME], self, "tag_origin");

	else
	{
		if (IsDefined (self.electric_cherry_reload_fx))
			StopFX (localClientNum, self.electric_cherry_reload_fx);			
		
		self.electric_cherry_reload_fx = undefined;
	}
}

function tesla_death_fx_callback (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) // self = zombie
{
	if (newVal == 1)
	{
		str_tag = "J_SpineUpper";

		if( IsDefined (self.str_tag_tesla_death_fx))
			str_tag = self.str_tag_tesla_death_fx;

		else if (IS_TRUE(self.isdog))
			str_tag = "J_Spine1";
		
		self.n_death_fx = PlayFXOnTag (localClientNum, level._effect[ELECTRIC_CHERRY_FX_DEATH_NAME], self, str_tag);
		SetFXIgnorePause (localClientNum, self.n_death_fx, true);
	}
	
	else
	{
		if (IsDefined (self.n_death_fx))
			DeleteFx (localClientNum, self.n_death_fx, true);

		self.n_death_fx = undefined;
	}		
}

function tesla_shock_eyes_fx_callback (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump) // self = zombie
{
	if (newVal == 1)
	{
		str_tag = "J_SpineUpper";

		if (IsDefined (self.str_tag_tesla_shock_eyes_fx))
			str_tag = self.str_tag_tesla_shock_eyes_fx;

		else if (IS_TRUE(self.isdog))
			str_tag = "J_Spine1";

		self.n_shock_eyes_fx = PlayFXOnTag (localClientNum, level._effect [ELECTRIC_CHERRY_FX_SHOCK_EYES_NAME], self, "J_Eyeball_LE");
		SetFXIgnorePause (localClientNum, self.n_shock_eyes_fx, true);
		
		self.n_shock_fx = PlayFXOnTag (localClientNum, level._effect [ELECTRIC_CHERRY_FX_DEATH_NAME], self, str_tag);
		SetFXIgnorePause (localClientNum, self.n_shock_fx, true);
	}
	
	else
	{
		if (IsDefined (self.n_shock_eyes_fx))
		{
			DeleteFx (localClientNum, self.n_shock_eyes_fx, true);
			self.n_shock_eyes_fx = undefined;		
		}
		
		if (IsDefined (self.n_shock_fx))
		{
			DeleteFx (localClientNum, self.n_shock_fx, true);
			self.n_shock_fx = undefined;
		}
	}		
}


// ======================================================================================================
// Elemental Pop
// ======================================================================================================

function enable_elemental_pop_for_level()
{
	zm_perks::register_perk_clientfields( 				ELEMENTAL_POP_PERK, &elemental_pop_client_field_func, &elemental_pop_callback_func);
	zm_perks::register_perk_effects( 					ELEMENTAL_POP_PERK, ELEMENTAL_POP_PERK);
	zm_perks::register_perk_init_thread( 				ELEMENTAL_POP_PERK, &elemental_pop_init);
}

function elemental_pop_init()
{
	level._effect [ELEMENTAL_POP_PERK]					= ELEMENTAL_POP_MACHINE_LIGHT_FX;
}

function elemental_pop_client_field_func() 
{
	clientfield::register ("clientuimodel", ELEMENTAL_POP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function elemental_pop_callback_func() {}


// ======================================================================================================
// Ethereal Razor
// ======================================================================================================

function enable_ethereal_razor_for_level()
{
	zm_perks::register_perk_clientfields( 				ETHEREAL_RAZOR_PERK, &ethereal_razor_client_field_func, &ethereal_razor_callback_func);
	zm_perks::register_perk_effects( 					ETHEREAL_RAZOR_PERK, ETHEREAL_RAZOR_PERK);
	zm_perks::register_perk_init_thread( 				ETHEREAL_RAZOR_PERK, &ethereal_razor_init);
}

function ethereal_razor_init()
{
	level._effect [ETHEREAL_RAZOR_PERK]					= ETHEREAL_RAZOR_MACHINE_LIGHT_FX;
}

function ethereal_razor_client_field_func() 
{
	clientfield::register ("clientuimodel", ETHEREAL_RAZOR_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function ethereal_razor_callback_func() {}


// ======================================================================================================
// Fighter's Fizz
// ======================================================================================================

function enable_fighters_fizz_for_level()
{
	zm_perks::register_perk_clientfields( 				FIGHTERS_FIZZ_PERK, &fighters_fizz_client_field_func, &fighters_fizz_callback_func);
	zm_perks::register_perk_effects( 					FIGHTERS_FIZZ_PERK, FIGHTERS_FIZZ_PERK);
	zm_perks::register_perk_init_thread( 				FIGHTERS_FIZZ_PERK, &fighters_fizz_init);
}

function fighters_fizz_init()
{
	level._effect [FIGHTERS_FIZZ_PERK]					= FIGHTERS_FIZZ_MACHINE_LIGHT_FX;
}

function fighters_fizz_client_field_func() 
{
	clientfield::register ("clientuimodel", FIGHTERS_FIZZ_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function fighters_fizz_callback_func() {}


// ======================================================================================================
// Gambler's Gibson
// ======================================================================================================

function enable_gamblers_gibson_for_level()
{
	zm_perks::register_perk_clientfields( 				GAMBLERS_GIBSON_PERK, &gamblers_gibson_client_field_func, &gamblers_gibson_callback_func);
	zm_perks::register_perk_effects( 					GAMBLERS_GIBSON_PERK, GAMBLERS_GIBSON_PERK);
	zm_perks::register_perk_init_thread( 				GAMBLERS_GIBSON_PERK, &gamblers_gibson_init);
}

function gamblers_gibson_init()
{
	level._effect [GAMBLERS_GIBSON_PERK]				= GAMBLERS_GIBSON_MACHINE_LIGHT_FX;
}

function gamblers_gibson_client_field_func() 
{
	clientfield::register ("clientuimodel", GAMBLERS_GIBSON_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function gamblers_gibson_callback_func() {}


// ======================================================================================================
// Glitching Gin
// ======================================================================================================

function enable_glitching_gin_for_level()
{
	zm_perks::register_perk_clientfields( 				GLITCHING_GIN_PERK, &glitching_gin_client_field_func, &glitching_gin_callback_func);
	zm_perks::register_perk_effects( 					GLITCHING_GIN_PERK, GLITCHING_GIN_PERK);
	zm_perks::register_perk_init_thread( 				GLITCHING_GIN_PERK, &glitching_gin_init);
}

function glitching_gin_init()
{
	level._effect [GLITCHING_GIN_PERK]					= GLITCHING_GIN_MACHINE_LIGHT_FX;
	level._effect ["glitch_grenade_aoe_explode"] 		= GLITCHING_GIN_GRENADE_AOE_EXPLODE;
	level._effect ["glitch_grenade_explode"] 			= GLITCHING_GIN_GRENADE_EXPLODE;
	level._effect ["glitch_grenade_impact"] 			= GLITCHING_GIN_GRENADE_IMPACT;
}

function glitching_gin_client_field_func() 
{
	clientfield::register ("clientuimodel", GLITCHING_GIN_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("scriptmover", "glitch_grenade_fx", VERSION_SHIP, 2, "int", &glitch_grenade_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function glitching_gin_callback_func() {}

function glitch_grenade_fx (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	self endon("entityshutdown");

	if(newVal == 3)
	{
		self.explode_aoe_fx = PlayFX(localClientNum, level._effect["glitch_grenade_aoe_explode"], self.origin, (1, 1, 0), (0, 0, 1));
	}
	
	else if(newVal == 2)
	{
		self.explode_fx = PlayFX(localClientNum, level._effect["glitch_grenade_explode"], self.origin, (1, 1, 0), (0, 0, 1));
	}
	
	else if(newVal == 1)
	{
		self.impact_fx = PlayFX(localClientNum, level._effect["glitch_grenade_impact"], self.origin, (1, 1, 0), (0, 0, 1));
	}
	
	else
	{
		if(IsDefined(self.impact_fx))
		{
			StopFX(localClientNum, self.impact_fx);
			self.impact_fx = undefined;
		}

		if(IsDefined(self.explode_fx))
		{
			StopFX(localClientNum, self.explode_fx);
			self.explode_fx = undefined;
		}

		if(IsDefined(self.explode_aoe_fx))
		{
			StopFX(localClientNum, self.explode_aoe_fx);
			self.explode_aoe_fx = undefined;
		}
	}
}


// ======================================================================================================
// I.C.U.
// ======================================================================================================

function enable_icu_for_level()
{
	zm_perks::register_perk_clientfields( 				ICU_PERK, &icu_client_field_func, &icu_callback_func);
	zm_perks::register_perk_effects( 					ICU_PERK, ICU_PERK);
	zm_perks::register_perk_init_thread( 				ICU_PERK, &icu_init);
}

function icu_init()
{
	level._effect [ICU_PERK]							= ICU_MACHINE_LIGHT_FX;
}

function icu_client_field_func() 
{
	clientfield::register ("clientuimodel", ICU_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function icu_callback_func() {}


// ======================================================================================================
// Madgaz Moonshine
// ======================================================================================================

function enable_madgaz_moonshine_for_level()
{
	zm_perks::register_perk_clientfields (		MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_client_field_func, &madgaz_moonshine_callback_func);
	zm_perks::register_perk_effects (			MADGAZ_MOONSHINE_PERK, MADGAZ_MOONSHINE_PERK);
	zm_perks::register_perk_init_thread (		MADGAZ_MOONSHINE_PERK, &madgaz_moonshine_init);
}

function madgaz_moonshine_init()
{
	level._effect [MADGAZ_MOONSHINE_PERK] 		= MADGAZ_MOONSHINE_MACHINE_LIGHT_FX;
}

function madgaz_moonshine_client_field_func() 
{
	clientfield::register ("clientuimodel", MADGAZ_MOONSHINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function madgaz_moonshine_callback_func() {}


// ======================================================================================================
// Magnet Mule
// ======================================================================================================

function enable_magnet_for_level()
{
	zm_perks::register_perk_clientfields( 		MAGNET_PERK, &magnet_client_field_func, &magnet_callback_func );
	zm_perks::register_perk_effects( 			MAGNET_PERK, MAGNET_PERK );
	zm_perks::register_perk_init_thread( 		MAGNET_PERK, &magnet_init );
}

function magnet_init()
{
	level._effect[ MAGNET_PERK ] = MAGNET_MACHINE_LIGHT_FX;
}

function magnet_client_field_func() 
{
	clientfield::register( "clientuimodel", MAGNET_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function magnet_callback_func() {}


// ======================================================================================================
// Masochist's Malecon
// ======================================================================================================

function enable_masochist_for_level()
{
	zm_perks::register_perk_clientfields( 				MASOCHIST_PERK, &masochist_client_field_func, &masochist_callback_func);
	zm_perks::register_perk_effects( 					MASOCHIST_PERK, MASOCHIST_PERK);
	zm_perks::register_perk_init_thread( 				MASOCHIST_PERK, &masochist_init);
}

function masochist_init()
{
	level._effect [MASOCHIST_PERK]						= MASOCHIST_MACHINE_LIGHT_FX;
}

function masochist_client_field_func() 
{
	clientfield::register ("clientuimodel", MASOCHIST_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function masochist_callback_func() {}


// ======================================================================================================
// Medusa's Mauresque
// ======================================================================================================

function enable_medusas_mauresque_for_level()
{
	zm_perks::register_perk_clientfields( 		MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_client_field_func, &medusas_mauresque_callback_func);
	zm_perks::register_perk_effects( 			MEDUSAS_MAURESQUE_PERK, MEDUSAS_MAURESQUE_PERK);
	zm_perks::register_perk_init_thread( 		MEDUSAS_MAURESQUE_PERK, &medusas_mauresque_init);
}

function medusas_mauresque_init()
{
	level._effect [MEDUSAS_MAURESQUE_PERK]		= MEDUSAS_MAURESQUE_MACHINE_LIGHT_FX;
}

function medusas_mauresque_client_field_func() 
{
	clientfield::register ("clientuimodel", MEDUSAS_MAURESQUE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function medusas_mauresque_callback_func() {}


// ======================================================================================================
// Muscle Milk
// ======================================================================================================

function enable_muscle_milk_for_level()
{
	zm_perks::register_perk_clientfields( 				MUSCLE_MILK_PERK, &muscle_milk_client_field_func, &muscle_milk_callback_func);
	zm_perks::register_perk_effects( 					MUSCLE_MILK_PERK, MUSCLE_MILK_PERK);
	zm_perks::register_perk_init_thread( 				MUSCLE_MILK_PERK, &muscle_milk_init);
}

function muscle_milk_init()
{
	level._effect [MUSCLE_MILK_PERK]					= MUSCLE_MILK_MACHINE_LIGHT_FX;
}

function muscle_milk_client_field_func() 
{
	clientfield::register ("clientuimodel", MUSCLE_MILK_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function muscle_milk_callback_func() {}


// ======================================================================================================
// PhD Flopper
// ======================================================================================================

function enable_phd_flopper_for_level()
{
	zm_perks::register_perk_clientfields( 				PHD_FLOPPER_PERK, &phd_flopper_client_field_func, &phd_flopper_callback_func);
	zm_perks::register_perk_effects( 					PHD_FLOPPER_PERK, PHD_FLOPPER_PERK);
	zm_perks::register_perk_init_thread( 				PHD_FLOPPER_PERK, &phd_flopper_init);
}

function phd_flopper_init()
{
	level._effect [PHD_FLOPPER_PERK]					= PHD_FLOPPER_MACHINE_LIGHT_FX;
}

function phd_flopper_client_field_func() 
{
	clientfield::register ("clientuimodel", PHD_FLOPPER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function phd_flopper_callback_func() {}


// ======================================================================================================
// PhD Slider
// ======================================================================================================

function enable_phd_slider_for_level()
{
	zm_perks::register_perk_clientfields( 				PHD_SLIDER_PERK, &phd_slider_client_field_func, &phd_slider_callback_func);
	zm_perks::register_perk_effects( 					PHD_SLIDER_PERK, PHD_SLIDER_PERK);
	zm_perks::register_perk_init_thread( 				PHD_SLIDER_PERK, &phd_slider_init);
}

function phd_slider_init()
{
	level._effect [PHD_SLIDER_PERK]						= PHD_SLIDER_MACHINE_LIGHT_FX;
}

function phd_slider_client_field_func() 
{
	clientfield::register ("clientuimodel", PHD_SLIDER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function phd_slider_callback_func() {}


// ======================================================================================================
// Pickpocket Paloma
// ======================================================================================================

function enable_pickpocket_paloma_for_level()
{
	zm_perks::register_perk_clientfields( 				PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_client_field_func, &pickpocket_paloma_callback_func);
	zm_perks::register_perk_effects( 					PICKPOCKET_PALOMA_PERK, PICKPOCKET_PALOMA_PERK);
	zm_perks::register_perk_init_thread( 				PICKPOCKET_PALOMA_PERK, &pickpocket_paloma_init);
}

function pickpocket_paloma_init()
{
	level._effect[ PICKPOCKET_PALOMA_PERK ]				= PICKPOCKET_PALOMA_MACHINE_LIGHT_FX;
}

function pickpocket_paloma_client_field_func() 
{
	clientfield::register ("clientuimodel", PICKPOCKET_PALOMA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function pickpocket_paloma_callback_func() {}


// ======================================================================================================
// Power Aid Punch
// ======================================================================================================

function enable_power_aid_punch_for_level()
{
	zm_perks::register_perk_clientfields( 				POWER_AID_PUNCH_PERK, &power_aid_punch_client_field_func, &power_aid_punch_callback_func);
	zm_perks::register_perk_effects( 					POWER_AID_PUNCH_PERK, POWER_AID_PUNCH_PERK);
	zm_perks::register_perk_init_thread( 				POWER_AID_PUNCH_PERK, &power_aid_punch_init);
}

function power_aid_punch_init()
{
	level._effect[ POWER_AID_PUNCH_PERK ]				= POWER_AID_PUNCH_MACHINE_LIGHT_FX;
}

function power_aid_punch_client_field_func() 
{
	clientfield::register ("clientuimodel", POWER_AID_PUNCH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function power_aid_punch_callback_func() {}


// ======================================================================================================
// Prickling Prosecco
// ======================================================================================================

function enable_prickling_prosecco_for_level()
{
	zm_perks::register_perk_clientfields( 				PRICKLING_PROSECCO_PERK, &prickling_prosecco_client_field_func, &prickling_prosecco_callback_func);
	zm_perks::register_perk_effects( 					PRICKLING_PROSECCO_PERK, PRICKLING_PROSECCO_PERK);
	zm_perks::register_perk_init_thread( 				PRICKLING_PROSECCO_PERK, &prickling_prosecco_init);
}

function prickling_prosecco_init()
{
	level._effect [PRICKLING_PROSECCO_PERK]				= PRICKLING_PROSECCO_MACHINE_LIGHT_FX;
}

function prickling_prosecco_client_field_func() 
{
	clientfield::register ("clientuimodel", PRICKLING_PROSECCO_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function prickling_prosecco_callback_func() {}


// ======================================================================================================
// Reaper's Roulette
// ======================================================================================================

function enable_roulette_for_level()
{
	zm_perks::register_perk_clientfields( 		ROULETTE_PERK, &roulette_client_field_func, &roulette_callback_func);
	zm_perks::register_perk_effects( 			ROULETTE_PERK, ROULETTE_PERK);
	zm_perks::register_perk_init_thread( 		ROULETTE_PERK, &roulette_init);
}

function roulette_init()
{
	level._effect [ROULETTE_PERK]				= ROULETTE_MACHINE_LIGHT_FX;
}

function roulette_client_field_func() 
{
	clientfield::register ("clientuimodel", ROULETTE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function roulette_callback_func() {}


// ======================================================================================================
// Rebate Rosé
// ======================================================================================================

function enable_rebate_rose_for_level()
{
	zm_perks::register_perk_clientfields( 		REBATE_ROSE_PERK, &rebate_rose_client_field_func, &rebate_rose_callback_func);
	zm_perks::register_perk_effects( 			REBATE_ROSE_PERK, REBATE_ROSE_PERK);
	zm_perks::register_perk_init_thread( 		REBATE_ROSE_PERK, &rebate_rose_init);
}

function rebate_rose_init()
{
	level._effect [REBATE_ROSE_PERK]			= REBATE_ROSE_MACHINE_LIGHT_FX;
}

function rebate_rose_client_field_func() 
{
	clientfield::register ("clientuimodel", REBATE_ROSE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function rebate_rose_callback_func() {}


// ======================================================================================================
// Salvage Shake
// ======================================================================================================

function enable_salvage_shake_for_level()
{
	zm_perks::register_perk_clientfields( 		SALVAGE_SHAKE_PERK, &salvage_shake_client_field_func, &salvage_shake_callback_func);
	zm_perks::register_perk_effects( 			SALVAGE_SHAKE_PERK, SALVAGE_SHAKE_PERK);
	zm_perks::register_perk_init_thread( 		SALVAGE_SHAKE_PERK, &salvage_shake_init);
}

function salvage_shake_init()
{
	level._effect [SALVAGE_SHAKE_PERK]			= SALVAGE_SHAKE_MACHINE_LIGHT_FX;
}

function salvage_shake_client_field_func() 
{
	clientfield::register ("clientuimodel", SALVAGE_SHAKE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function salvage_shake_callback_func() {}


// ======================================================================================================
// Samurai's Spirit
// ======================================================================================================

function enable_samurais_spirit_for_level()
{
	zm_perks::register_perk_clientfields(		SAMURAIS_SPIRIT_PERK, &samurais_spirit_client_field_func, &samurais_spirit_callback_func);
	zm_perks::register_perk_effects( 			SAMURAIS_SPIRIT_PERK, SAMURAIS_SPIRIT_PERK);
	zm_perks::register_perk_init_thread( 		SAMURAIS_SPIRIT_PERK, &samurais_spirit_init);
}

function samurais_spirit_init()
{
	level._effect[ SAMURAIS_SPIRIT_PERK ]		= SAMURAIS_SPIRIT_MACHINE_LIGHT_FX;
}

function samurais_spirit_client_field_func() 
{
	clientfield::register ("clientuimodel", SAMURAIS_SPIRIT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function samurais_spirit_callback_func() {}


// ======================================================================================================
// Side-Steppin' Shandy
// ======================================================================================================

function enable_side_step_for_level()
{
	zm_perks::register_perk_clientfields (		SIDE_STEP_PERK, &side_step_client_field_func, &side_step_callback_func);
	zm_perks::register_perk_effects (			SIDE_STEP_PERK, SIDE_STEP_PERK);
	zm_perks::register_perk_init_thread (		SIDE_STEP_PERK, &side_step_init);
}

function side_step_init()
{
	level._effect [SIDE_STEP_PERK] 				= SIDE_STEP_MACHINE_LIGHT_FX;
}

function side_step_client_field_func() 
{
	clientfield::register ("clientuimodel", SIDE_STEP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function side_step_callback_func() {}


// ======================================================================================================
// Slip-Away Slushee
// ======================================================================================================

function enable_slip_away_for_level()
{
	zm_perks::register_perk_clientfields (		SLIP_AWAY_PERK, &slip_away_client_field_func, &slip_away_callback_func);
	zm_perks::register_perk_effects (			SLIP_AWAY_PERK, SLIP_AWAY_PERK);
	zm_perks::register_perk_init_thread (		SLIP_AWAY_PERK, &slip_away_init);
}

function slip_away_init()
{
	level._effect [SLIP_AWAY_PERK] 				= SLIP_AWAY_MACHINE_LIGHT_FX;
}

function slip_away_client_field_func() 
{
	clientfield::register ("clientuimodel", SLIP_AWAY_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function slip_away_callback_func() {}


// ======================================================================================================
// Slurpentine
// ======================================================================================================

function enable_slurpentine_for_level()
{
	zm_perks::register_perk_clientfields (		SLURPENTINE_PERK, &slurpentine_client_field_func, &slurpentine_callback_func);
	zm_perks::register_perk_effects (			SLURPENTINE_PERK, SLURPENTINE_PERK);
	zm_perks::register_perk_init_thread (		SLURPENTINE_PERK, &slurpentine_init);
}

function slurpentine_init()
{
	level._effect [SLURPENTINE_PERK] 			= SLURPENTINE_MACHINE_LIGHT_FX;
}

function slurpentine_client_field_func() 
{
	clientfield::register ("clientuimodel", SLURPENTINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("actor", "slurpentine_zombie_eye_change", VERSION_SHIP, 1, "int", &slurpentine_zombie_eye_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function slurpentine_callback_func() {}

function slurpentine_zombie_eye_fx (n_local_client_num, n_old_value, n_new_value, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump)
{
	self zm::deleteZombieEyes (n_local_client_num);
	
	if (n_new_value == 1)
	{
		if (IsDefined (self._eyeglow_fx_override))
			self._eyeglow_fx_override_old = self._eyeglow_fx_override;
			
		self._eyeglow_fx_override = SLURPENTINE_FX_POISON_EYES;
		self zm::createZombieEyes (n_local_client_num);
	}
	
	else if (n_new_value == 0)
	{
		if (IsDefined (self._eyeglow_fx_override_old))
			self._eyeglow_fx_override = self._eyeglow_fx_override_old;
			
		else
			self._eyeglow_fx_override = undefined;
			
		self zm::createZombieEyes (n_local_client_num);
	}
}


// ======================================================================================================
// Snail's Pace Slurpee
// ======================================================================================================

function enable_snails_pace_for_level()
{
	zm_perks::register_perk_clientfields( 		SNAILS_PACE_PERK, &snails_pace_client_field_func, &snails_pace_callback_func);
	zm_perks::register_perk_effects( 			SNAILS_PACE_PERK, SNAILS_PACE_PERK);
	zm_perks::register_perk_init_thread( 		SNAILS_PACE_PERK, &snails_pace_init);
}

function snails_pace_init()
{
	level._effect [SNAILS_PACE_PERK]			= SNAILS_PACE_MACHINE_LIGHT_FX;
}

function snails_pace_client_field_func() 
{
	clientfield::register ("clientuimodel", SNAILS_PACE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("actor", "snails_pace_zombie_eye_change", VERSION_SHIP, 1, "int", &snails_pace_change_eye_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function snails_pace_callback_func() {}

function snails_pace_change_eye_fx (n_local_client_num, n_old_value, n_new_value, b_new_ent, b_initial_snap, str_field_name, b_was_time_jump)
{
	self zm::deleteZombieEyes (n_local_client_num);
	
	if (n_new_value == 1)
	{
		if (IsDefined (self._eyeglow_fx_override))
			self._eyeglow_fx_override_old = self._eyeglow_fx_override;
			
		self._eyeglow_fx_override = SNAILS_PACE_ZOMBIE_EYE_FX;
		self zm::createZombieEyes (n_local_client_num);
	}
	
	else if (n_new_value == 0)
	{
		if (IsDefined (self._eyeglow_fx_override_old))
			self._eyeglow_fx_override = self._eyeglow_fx_override_old;
			
		else
			self._eyeglow_fx_override = undefined;
			
		self zm::createZombieEyes (n_local_client_num);
	}
}


// ======================================================================================================
// Space Cadet Cola
// ======================================================================================================

function enable_space_cadet_for_level()
{
	zm_perks::register_perk_clientfields( 		SPACE_CADET_PERK, &space_cadet_client_field_func, &space_cadet_callback_func);
	zm_perks::register_perk_effects( 			SPACE_CADET_PERK, SPACE_CADET_PERK);
	zm_perks::register_perk_init_thread( 		SPACE_CADET_PERK, &space_cadet_init);
	
	visionset_mgr::register_visionset_info ("space_cadet_hidden", 1, 31, undefined, "zombie_noire");
	visionset_mgr::register_overlay_info_style_postfx_bundle ("space_cadet_hidden", 1, 1, "pstfx_zm_screen_warp");
}

function space_cadet_init()
{
	level._effect [SPACE_CADET_PERK]			= SPACE_CADET_MACHINE_LIGHT_FX;
}

function space_cadet_client_field_func() 
{
	clientfield::register ("clientuimodel", SPACE_CADET_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function space_cadet_callback_func() {}


// ======================================================================================================
// Spectral Shake
// ======================================================================================================

function enable_spectral_shake_for_level()
{
	zm_perks::register_perk_clientfields( 				SPECTRAL_SHAKE_PERK, &spectral_shake_client_field_func, &spectral_shake_callback_func);
	zm_perks::register_perk_effects( 					SPECTRAL_SHAKE_PERK, SPECTRAL_SHAKE_PERK);
	zm_perks::register_perk_init_thread( 				SPECTRAL_SHAKE_PERK, &spectral_shake_init);
	
	visionset_mgr::register_visionset_info ("spectral_shake_hidden", 1, 31, undefined, "zombie_noire");
	visionset_mgr::register_overlay_info_style_postfx_bundle ("spectral_shake_hidden", 1, 1, "pstfx_zm_screen_warp");
}

function spectral_shake_init()
{
	level._effect [SPECTRAL_SHAKE_PERK]					= SPECTRAL_SHAKE_MACHINE_LIGHT_FX;
}

function spectral_shake_client_field_func() 
{
	clientfield::register ("clientuimodel", SPECTRAL_SHAKE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function spectral_shake_callback_func() {}


// ======================================================================================================
// Stone Cold Stronghold
// ======================================================================================================

function enable_stone_cold_for_level()
{
	zm_perks::register_perk_clientfields (		STONE_COLD_PERK, &stone_cold_client_field_func, &stone_cold_callback_func);
	zm_perks::register_perk_effects (			STONE_COLD_PERK, STONE_COLD_PERK);
	zm_perks::register_perk_init_thread (		STONE_COLD_PERK, &stone_cold_init);
}

function stone_cold_init()
{
	level._effect [STONE_COLD_PERK] 			= STONE_COLD_MACHINE_LIGHT_FX;
}

function stone_cold_client_field_func() 
{
	clientfield::register ("clientuimodel", STONE_COLD_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function stone_cold_callback_func() {}


// ======================================================================================================
// Tactiquilla Sangria
// ======================================================================================================

function enable_tactiquilla_for_level()
{
	zm_perks::register_perk_clientfields( 				TACTIQUILLA_PERK, &tactiquilla_client_field_func, &tactiquilla_callback_func);
	zm_perks::register_perk_effects( 					TACTIQUILLA_PERK, TACTIQUILLA_PERK);
	zm_perks::register_perk_init_thread( 				TACTIQUILLA_PERK, &tactiquilla_init);
}

function tactiquilla_init()
{
	level._effect [TACTIQUILLA_PERK]					= TACTIQUILLA_MACHINE_LIGHT_FX;
}

function tactiquilla_client_field_func() 
{
	clientfield::register ("clientuimodel", TACTIQUILLA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function tactiquilla_callback_func() {}


// ======================================================================================================
// Time Out Tequila
// ======================================================================================================

function enable_time_out_for_level()
{
	zm_perks::register_perk_clientfields( 		TIME_OUT_PERK, &time_out_client_field_func, &time_out_callback_func);
	zm_perks::register_perk_effects( 			TIME_OUT_PERK, TIME_OUT_PERK);
	zm_perks::register_perk_init_thread( 		TIME_OUT_PERK, &time_out_init);
	
	visionset_mgr::register_visionset_info ("time_out_hidden", 1, 31, undefined, "zombie_noire");
	visionset_mgr::register_overlay_info_style_postfx_bundle ("time_out_hidden", 1, 1, "pstfx_zm_screen_warp");
}

function time_out_init()
{
	level._effect [TIME_OUT_PERK]				= TIME_OUT_MACHINE_LIGHT_FX;
}

function time_out_client_field_func() 
{
	clientfield::register ("clientuimodel", TIME_OUT_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function time_out_callback_func() {}


// ======================================================================================================
// Timeslip
// ======================================================================================================

function enable_timeslip_for_level()
{
	zm_perks::register_perk_clientfields( 		TIMESLIP_PERK, &timeslip_client_field_func, &timeslip_callback_func);
	zm_perks::register_perk_effects( 			TIMESLIP_PERK, TIMESLIP_PERK);
	zm_perks::register_perk_init_thread( 		TIMESLIP_PERK, &timeslip_init);
}

function timeslip_init()
{
	level._effect[ TIMESLIP_PERK ]				= TIMESLIP_MACHINE_LIGHT_FX;
}

function timeslip_client_field_func() 
{
	clientfield::register ("clientuimodel", TIMESLIP_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function timeslip_callback_func() {}


// ======================================================================================================
// Tombstone Soda
// ======================================================================================================

function enable_tombstone_soda_for_level()
{
	zm_perks::register_perk_clientfields( 			TOMBSTONE_SODA_PERK, &tombstone_soda_client_field_func, &tombstone_soda_callback_func);
	zm_perks::register_perk_effects( 				TOMBSTONE_SODA_PERK, TOMBSTONE_SODA_PERK);
	zm_perks::register_perk_init_thread( 			TOMBSTONE_SODA_PERK, &tombstone_soda_init);
}

function tombstone_soda_init()
{
	level._effect [TOMBSTONE_SODA_PERK]				= TOMBSTONE_SODA_MACHINE_LIGHT_FX;
}

function tombstone_soda_client_field_func() 
{
	clientfield::register ("clientuimodel", TOMBSTONE_SODA_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function tombstone_soda_callback_func() {}


// ======================================================================================================
// Verruckt Juggernog
// ======================================================================================================

function enable_verruckt_jug_for_level()
{
	zm_perks::register_perk_clientfields( 			VERRUCKT_JUG_PERK, &verruckt_jug_client_field_func, &verruckt_jug_callback_func);
	zm_perks::register_perk_effects( 				VERRUCKT_JUG_PERK, VERRUCKT_JUG_PERK);
	zm_perks::register_perk_init_thread( 			VERRUCKT_JUG_PERK, &verruckt_jug_init);
}

function verruckt_jug_init()
{
	level._effect [VERRUCKT_JUG_PERK]				= VERRUCKT_JUG_MACHINE_LIGHT_FX;
}

function verruckt_jug_client_field_func() 
{
	clientfield::register ("clientuimodel", VERRUCKT_JUG_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function verruckt_jug_callback_func() {}


// ======================================================================================================
// Victorious Tortoise
// ======================================================================================================

function enable_victorious_tortoise_for_level()
{
	zm_perks::register_perk_clientfields( 			VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_client_field_func, &victorious_tortoise_callback_func);
	zm_perks::register_perk_effects( 				VICTORIOUS_TORTOISE_PERK, VICTORIOUS_TORTOISE_PERK);
	zm_perks::register_perk_init_thread( 			VICTORIOUS_TORTOISE_PERK, &victorious_tortoise_init);
}

function victorious_tortoise_init()
{
	level._effect [VICTORIOUS_TORTOISE_PERK]				= VICTORIOUS_TORTOISE_MACHINE_LIGHT_FX;
}

function victorious_tortoise_client_field_func() 
{
	clientfield::register ("clientuimodel", VICTORIOUS_TORTOISE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function victorious_tortoise_callback_func() {}


// ======================================================================================================
// Vigor Rush
// ======================================================================================================

function enable_vigor_rush_for_level()
{
	zm_perks::register_perk_clientfields( 			VIGOR_RUSH_PERK, &vigor_rush_client_field_func, &vigor_rush_callback_func);
	zm_perks::register_perk_effects( 				VIGOR_RUSH_PERK, VIGOR_RUSH_PERK);
	zm_perks::register_perk_init_thread( 			VIGOR_RUSH_PERK, &vigor_rush_init);
}

function vigor_rush_init()
{
	level._effect [VIGOR_RUSH_PERK]					= VIGOR_RUSH_MACHINE_LIGHT_FX;
}

function vigor_rush_client_field_func() 
{
	clientfield::register ("clientuimodel", VIGOR_RUSH_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function vigor_rush_callback_func() {}


// ======================================================================================================
// Wall Power
// ======================================================================================================

function enable_wall_power_for_level()
{
	zm_perks::register_perk_clientfields( 			WALL_POWER_PERK, &wall_power_client_field_func, &wall_power_callback_func);
	zm_perks::register_perk_effects( 				WALL_POWER_PERK, WALL_POWER_PERK);
	zm_perks::register_perk_init_thread( 			WALL_POWER_PERK, &wall_power_init);
}

function wall_power_init()
{
	level._effect [WALL_POWER_PERK]					= WALL_POWER_MACHINE_LIGHT_FX;
}

function wall_power_client_field_func() 
{
	clientfield::register ("clientuimodel", WALL_POWER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function wall_power_callback_func() {}


// ======================================================================================================
// Widows Wine
// ======================================================================================================

function enable_widows_wine_for_level()
{
	zm_perks::register_perk_clientfields( 			WIDOWS_WINE_PERK, &widows_wine_client_field_func, &widows_wine_callback_func);
	zm_perks::register_perk_effects( 				WIDOWS_WINE_PERK, WIDOWS_WINE_PERK);
	zm_perks::register_perk_init_thread( 			WIDOWS_WINE_PERK, &widows_wine_init);
	
	zm_powerups::include_zombie_powerup (WIDOWS_WINE_POWERUP_ALIAS);
	zm_powerups::add_zombie_powerup (WIDOWS_WINE_POWERUP_ALIAS);
}

function widows_wine_init()
{
	level._effect [WIDOWS_WINE_PERK]				= WIDOWS_WINE_MACHINE_LIGHT_FX;
}

function widows_wine_client_field_func() 
{
	clientfield::register ("clientuimodel", WIDOWS_WINE_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("actor", "widows_wine_wrapping", VERSION_SHIP, 1, "int", &widows_wine_wrap_cb, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
	clientfield::register ("vehicle", "widows_wine_wrapping", VERSION_SHIP, 1, "int", &widows_wine_wrap_cb, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);	
	clientfield::register ("toplayer", "widows_wine_1p_contact_explosion", VERSION_SHIP, 1, "counter", &widows_wine_1p_contact_explosion, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function widows_wine_callback_func() {}

function widows_wine_wrap_cb (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	if (newVal)
	{
		if (IsDefined (self) && IsAlive (self))
		{
			if (!IsDefined (self.fx_widows_wine_wrap) && (IsDefined (self GetTagOrigin ("j_spineupper"))))
				self.fx_widows_wine_wrap = PlayFxOnTag (localClientNum, WIDOWS_WINE_FX_WRAP, self, "j_spineupper");
			
			if (!IsDefined (self.sndWidowsWine))
			{
				self PlaySound (0, "wpn_wwgrenade_cocoon_imp");
				self.sndWidowsWine = self PlayLoopSound ("wpn_wwgrenade_cocoon_lp", .1);
			}
		}
	}
	
	else
	{
		if (IsDefined (self.fx_widows_wine_wrap))
		{
			StopFX (localClientNum, self.fx_widows_wine_wrap);
			self.fx_widows_wine_wrap = undefined;
		}
		
		if (IsDefined (self.sndWidowsWine))
		{
			self PlaySound (0, "wpn_wwgrenade_cocoon_stop");
			self StopLoopSound (self.sndWidowsWine, .1);
		}
	}
}

function widows_wine_1p_contact_explosion (localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump)
{
	owner = self GetOwner (localClientNum);
	
	if (IsDefined (owner) && owner == GetLocalPlayer (localClientNum))
		thread widows_wine_1p_contact_explosion_play (localClientNum);
	
}

function widows_wine_1p_contact_explosion_play (localClientNum)
{
	tag = "tag_flash";

	if (!ViewModelHasTag (localClientNum, tag))
	{
		tag = "tag_weapon";
		
		if (!ViewModelHasTag (localClientNum, tag))
			return;
	}

	fx_contact_explosion = PlayViewModelFx (localClientNum, WIDOWS_WINE_FX_WEB_1P, tag);
	
	wait 2;
	
	DeleteFx (localClientNum, fx_contact_explosion, 1);
}


// ======================================================================================================
// Windrunner Whiskey
// ======================================================================================================

function enable_windrunner_for_level()
{
	zm_perks::register_perk_clientfields( 			WINDRUNNER_PERK, &windrunner_client_field_func, &windrunner_callback_func);
	zm_perks::register_perk_effects( 				WINDRUNNER_PERK, WINDRUNNER_PERK);
	zm_perks::register_perk_init_thread( 			WINDRUNNER_PERK, &windrunner_init);
}

function windrunner_init()
{
	level._effect [WINDRUNNER_PERK]					= WINDRUNNER_MACHINE_LIGHT_FX;
}

function windrunner_client_field_func() 
{
	clientfield::register ("clientuimodel", WINDRUNNER_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function windrunner_callback_func() {}


// ======================================================================================================
// Winter's Wail
// ======================================================================================================

function enable_winters_wail_for_level()
{
	zm_perks::register_perk_clientfields (		WINTERS_WAIL_PERK, &winters_wail_client_field_func, &winters_wail_callback_func);
	zm_perks::register_perk_effects (			WINTERS_WAIL_PERK, WINTERS_WAIL_PERK);
	zm_perks::register_perk_init_thread (		WINTERS_WAIL_PERK, &winters_wail_init);
}

function winters_wail_init()
{
	level._effect [WINTERS_WAIL_PERK] 			= WINTERS_WAIL_MACHINE_LIGHT_FX;
}

function winters_wail_client_field_func() 
{
	clientfield::register ("clientuimodel", WINTERS_WAIL_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function winters_wail_callback_func() {}


// ======================================================================================================
// Wunderfizz
// ======================================================================================================

function enable_wunderfizz_for_level()
{
	clientfield::register ("zbarrier", "wunderfizz_set_client_light_state", 5000, 2, "int", &set_light_state, 0, 0);
	clientfield::register ("zbarrier", "wunderfizz_init_perk_random_machine", 5000, 1, "int", &perk_random_machine_init, 0, 0);
	clientfield::register ("zbarrier", "wunderfizz_client_stone_emmissive_blink", 5000, 1, "int", &perk_random_machine_rock_emissive, 0, 0);
	//clientfield::register ("scriptmover", "wunderfizz_turn_active_perk_light_green", 5000, 1, "int", &turn_on_active_light_green, 0, 0);
	//clientfield::register ("scriptmover", "wunderfizz_turn_on_location_indicator", 5000, 1, "int", &turn_on_location_indicator, 0, 0);
	clientfield::register ("zbarrier", "wunderfizz_lightning_bolt_FX_toggle", 10000, 1, "int", &lightning_bolt_fx_toggle, 0, 0);
	//clientfield::register ("scriptmover", "wunderfizz_turn_active_perk_ball_light", 5000, 1, "int", &turn_on_active_ball_light, 0, 0);
	//clientfield::register ("scriptmover", "wunderfizz_zone_captured", 5000, 1, "int", &zone_captured_cb, 0, 0);
}

function init_animtree()
{
}

function turn_on_location_indicator (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

function lightning_bolt_fx_toggle (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (IsDemoPlaying() && GetDemoVersion() < 17)
		return;
		
	self notify ("lightning_bolt_fx_toggle" + localclientnum);
	self endon ("lightning_bolt_fx_toggle" + localclientnum);
	
	player = GetLocalPlayer (localclientnum);
	player endon ("entityshutdown");
	
	if (!IsDefined (self._location_indicator))
		self._location_indicator = [];
		
	for (;;)
	{
		if (newval == 1 && !IsIGCActive (localclientnum))
		{
			if (!IsDefined (self._location_indicator [localclientnum]))
				self._location_indicator [localclientnum] = PlayFx (localclientnum, WUNDERFIZZ_FX_LOCATION, self.origin);
		}
		
		else if (IsDefined (self._location_indicator [localclientnum]))
		{
			StopFx (localclientnum, self._location_indicator [localclientnum]);
			
			self._location_indicator [localclientnum] = undefined;
		}
		
		wait 1;
	}
}

function zone_captured_cb (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (!IsDefined (self.mapped_const))
	{
		self MapShaderConstant (localclientnum, 1, "ScriptVector0");
		self.mapped_const = 1;
	}
	
	if (newval != 1)
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 0;
		
		self SetShaderConstant (localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}

function perk_random_machine_rock_emissive (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (newval == 1)
	{
		piece = self ZbarrierGetPiece (3);
		piece.blinking = 1;
		piece thread rock_emissive_think (localclientnum);
	}
	
	else if (newval == 0)
		self.blinking = 0;
}

function rock_emissive_think (localclientnum)
{
	level endon ("demo_jump");
	
	while (IsDefined (self.blinking) && self.blinking)
	{
		self rock_emissive_fade (localclientnum, 8, 0);
		self rock_emissive_fade (localclientnum, 0, 8);
	}
}

function rock_emissive_fade (localclientnum, n_max_val, n_min_val)
{
	n_start_time = GetTime();
	n_end_time = n_start_time + (0.5 * 1000);
	
	b_is_updating = 1;
	
	while (b_is_updating)
	{
		n_time = GetTime();
		
		if (n_time >= n_end_time)
		{
			n_shader_value = MapFloat (n_start_time, n_end_time, n_min_val, n_max_val, n_end_time);
			b_is_updating = 0;
		}
		
		else
			n_shader_value = MapFloat(n_start_time, n_end_time, n_min_val, n_max_val, n_time);
		
		if (IsDefined (self))
		{
			self MapShaderConstant (localclientnum, 0, "scriptVector2", n_shader_value, 0, 0);
			self MapShaderConstant (localclientnum, 0, "scriptVector0", 0, n_shader_value, 0);
			self MapShaderConstant (localclientnum, 0, "scriptVector0", 0, 0, n_shader_value);
		}
		
		wait .01;
	}
}

function private perk_random_machine_init (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (IsDefined (self.perk_random_machine_fx))
		return;
		
	if (!IsDefined (self))
		return;
		
	self.perk_random_machine_fx = [];
	self.perk_random_machine_fx ["tag_animate" + 1] = [];
	self.perk_random_machine_fx ["tag_animate" + 2] = [];
	self.perk_random_machine_fx ["tag_animate" + 3] = [];
}

function set_light_state (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_n_piece_indices = array (1, 2, 3);
	
	foreach (n_piece_index in a_n_piece_indices)
	{
		if (newval == 0)
		{
			perk_random_machine_play_fx (localclientnum, n_piece_index, "tag_animate", undefined);
			
			continue;
		}
		
		if (newval == 3)
		{
			perk_random_machine_play_fx (localclientnum, n_piece_index, "tag_animate", WUNDERFIZZ_FX_RED);
			
			continue;
		}
		
		if(newval == 1)
		{
			perk_random_machine_play_fx (localclientnum, n_piece_index, "tag_animate", WUNDERFIZZ_FX_GREEN);
			
			continue;
		}
	}
}

function private perk_random_machine_play_fx (localclientnum, piece_index, tag, fx, deleteimmediate = 1)
{
	piece = self ZbarrierGetPiece (piece_index);
	
	if (IsDefined (self.perk_random_machine_fx [tag + piece_index] [localclientnum]))
	{
		DeleteFx (localclientnum, self.perk_random_machine_fx [tag + piece_index] [localclientnum], deleteimmediate);
		self.perk_random_machine_fx [tag + piece_index] [localclientnum] = undefined;
	}
	
	if (IsDefined (fx))
		self.perk_random_machine_fx [tag + piece_index] [localclientnum] = PlayFxOnTag (localclientnum, fx, piece, tag);
}

function turn_on_active_light_green (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (newval == 1)
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 0.7;
		self SetShaderConstant (localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}

function turn_on_active_ball_light (localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if (newval == 1)
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 1;
		self SetShaderConstant (localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}


// ======================================================================================================
// Zombshell
// ======================================================================================================

function enable_zombshell_for_level()
{
	zm_perks::register_perk_clientfields( 			ZOMBSHELL_PERK, &zombshell_client_field_func, &zombshell_callback_func);
	zm_perks::register_perk_effects( 				ZOMBSHELL_PERK, ZOMBSHELL_PERK);
	zm_perks::register_perk_init_thread( 			ZOMBSHELL_PERK, &zombshell_init);
}

function zombshell_init()
{
	level._effect [ZOMBSHELL_PERK]					= ZOMBSHELL_MACHINE_LIGHT_FX;
}

function zombshell_client_field_func() 
{
	clientfield::register ("clientuimodel", ZOMBSHELL_CLIENTFIELD, VERSION_SHIP, COMMON_CLIENTFIELD_SIZE, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT);
}

function zombshell_callback_func() {}

