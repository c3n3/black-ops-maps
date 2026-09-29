#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\_burnplayer;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\_zm_weap_thundergun;
#using scripts\zm\_zm_zonemgr;

#using scripts\zm\gametypes\_globallogic_score;

#using scripts\zm\_community_perk_collection_setup;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_community_perk_collection.gsh;

#precache ("material", ATOMIC_LIQUEUR_ICON);

#precache ("fx", BANANA_COLADA_SLIDE_FX);

#precache ("fx", BLAZE_PHASE_FX_EXPLOSION);
#precache ("fx", BLAZE_PHASE_FX_FIRE);
#precache ("material", BLAZE_PHASE_ICON);

#precache ("material", BLOOD_WOLF_ICON);

#precache ("fx", BRAWLSTAR_PUNCH_BLOWBACK_FX);
#precache ("fx", BRAWLSTAR_PUNCH_HIT_FX);
#precache ("material", BRAWLSTAR_PUNCH_ICON);

#precache ("fx", BRIMSTONE_BRAMBLE_EXPLOSION_FX_FILE);

#precache ("model", BULL_ICE_BLAST_SLAM_ICE_BLOCK);

#precache ("fx", CRYO_SLIDE_FX_ACTIVATE);
#precache ("fx", CRYO_SLIDE_FX_IDLE);
#precache ("fx", CRYO_SLIDE_FX_FROZEN_ZOMBIE_KILL);
#precache ("model", CRYO_SLIDE_ZOMBIE_FROZEN_MODEL);
#precache ("material", CRYO_SLIDE_ICON);

#precache ("material", DYING_WISH_ICON);

#precache ("fx", ELECTRIC_CHERRY_FX_EXPLODE_FILE);

#precache ("material", ELEMENTAL_POP_ICON);

#precache ("fx", MADGAZ_MOONSHINE_EXPLOSION_FX);

#precache ("material", MUSCLE_MILK_ICON);

#precache ("fx", PHD_FLOPPER_FX_EXPLOSION);

#precache ("fx", PHD_SLIDER_FX_EXPLOSION);
#precache ("fx", PHD_SLIDER_FX_FIRE);
#precache ("material", PHD_SLIDER_ICON);

#precache ("fx", POWER_AID_PUNCH_HIT_LOC_FX);

#precache ("fx", SLURPENTINE_FX_VENOM);

#precache ("material", SPACE_CADET_ICON);

#precache ("material", SPECTRAL_SHAKE_ICON);

#precache ("fx", STONE_COLD_RING_FX);
#precache ("material", STONE_COLD_ICON);

#precache ("material", TIME_OUT_ICON);

#precache ("fx", TOMBSTONE_SODA_POWERUP_FX);
#precache ("fx", TOMBSTONE_SODA_POWERUP_GRAB_FX);
#precache ("model", TOMBSTONE_SODA_POWERUP_MODEL);

#precache ("fx", VIGOR_RUSH_EXPLOSION_FX_FILE);

#precache ("fx", WINDRUNNER_PLAYER_RUNNING_FX);
#precache ("fx", WINDRUNNER_IMPACT_FX);
#precache ("material", WINDRUNNER_ICON);

#precache ("fx", WINTERS_WAIL_EXPLOSION_FX);
#precache ("fx", WINTERS_WAIL_ZOMBIE_FREEZE_FX);
#precache ("material", WINTERS_WAIL_ICON);
#precache ("material", WINTERS_WAIL_ICON_SNOWFLAKE);

#precache ("fx", ZOMBSHELL_FIELD_START_FX);
#precache ("material", ZOMBSHELL_ICON);

#namespace community_perk_collection;

REGISTER_SYSTEM("zm_community_perk_collection", &init, undefined)


// ======================================================================================================
// Shared Functions
// ======================================================================================================

function init()
{
	//SELF == LEVEL
	
	if (IsDefined (level.mod_force_enable_west_perk) && level.mod_force_enable_west_perk.size > 0)
	{
		if (IsInArray (level.mod_force_enable_west_perk, BRAWLSTAR_PUNCH_ALIAS))
			level.brawlstar_punch_fists = GetWeapon (BRAWLSTAR_PUNCH_WEAPON_FISTS);
		
		if (IsInArray (level.mod_force_enable_west_perk, GLITCHING_GIN_ALIAS))
		{
			if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
			{
				zm_utility::register_tactical_grenade_for_level (GLITCHING_GIN_GRENADE_TACTICAL);
				level.w_glitching_gin_grenade = GetWeapon (GLITCHING_GIN_GRENADE_TACTICAL);
			}
			
			else
			{
				zm_utility::register_lethal_grenade_for_level (GLITCHING_GIN_GRENADE_LETHAL);
				level.w_glitching_gin_grenade = GetWeapon (GLITCHING_GIN_GRENADE_LETHAL);
			}
		}
		
		if (IsInArray (level.mod_force_enable_west_perk, MEDUSAS_MAURESQUE_ALIAS))
			level thread medusas_mauresque_think();
		
		if (IsInArray (level.mod_force_enable_west_perk, REBATE_ROSE_ALIAS))
			level thread global_check_for_purchases();
			
		if (IsInArray (level.mod_force_enable_west_perk, SLIP_AWAY_ALIAS))
			level thread slip_away_setup_spawn_points();
		
		if (IsInArray (level.mod_force_enable_west_perk, TIMESLIP_ALIAS))
			level thread timeslip_trap_cooldown(); //Timeslip Trap Cooldown
			
		if (IsInArray (level.mod_force_enable_west_perk, WUNDERFIZZ_ALIAS))
			level thread wunderfizz_main();
			
		//AI Damage Taken Callback -- Only run callback if one of the perks using it are enabled
		if (IsInArray (level.mod_force_enable_west_perk, BLEEDING_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, BLOOD_WOLF_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, BRAWLSTAR_PUNCH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, BULL_ICE_BLAST_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, CRACK_SHOT_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, CRUSADERS_ALE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, CRYO_SLIDE_ALIAS) || 
			IsInArray (level.mod_force_enable_west_perk, DOUBLE_DEW_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, DOUBLETAP3_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, DYING_WISH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, ELEMENTAL_POP_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, MADGAZ_MOONSHINE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, POWER_AID_PUNCH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, ROULETTE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, REBATE_ROSE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SAMURAIS_SPIRIT_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, VIGOR_RUSH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WIDOWS_WINE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, ZOMBSHELL_ALIAS))
		{
			zm::register_actor_damage_callback (&callback_zombie_damage_override);
			zm::register_vehicle_damage_callback (&callback_vehicle_damage_override);
		}
		
		//AI Response to Damage Callback, DO NOT OVERRIDE DAMAGE HERE
		if (IsInArray (level.mod_force_enable_west_perk, VIGOR_RUSH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WIDOWS_WINE_ALIAS))
			zm_spawner::register_zombie_damage_callback (&callback_zombie_damage_response);
		
		//AI Death Callback -- Only run callback if one of the perks using it are enabled
		if (IsInArray (level.mod_force_enable_west_perk, SPACE_CADET_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, FIGHTERS_FIZZ_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WIDOWS_WINE_ALIAS))
			zm_spawner::register_zombie_death_event_callback (&callback_ai_death);
		
		//Player Damage Taken Callback -- Only run callback if one of the perks using it are enabled
		if (IsInArray (level.mod_force_enable_west_perk, BRAWLSTAR_PUNCH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, BULL_ICE_BLAST_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, DYING_WISH_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, GLITCHING_GIN_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, PHD_FLOPPER_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, PHD_SLIDER_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, PICKPOCKET_PALOMA_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, PRICKLING_PROSECCO_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SIDE_STEP_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SLIP_AWAY_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SLURPENTINE_ALIAS) || 
			IsInArray (level.mod_force_enable_west_perk, STONE_COLD_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WIDOWS_WINE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WINTERS_WAIL_ALIAS))
			zm_perks::register_perk_damage_override_func (&callback_player_damage_override);
			
		//Laststand Handling -- Only run callback if one of the perks using it are enabled
		if (IsInArray (level.mod_force_enable_west_perk, ELECTRIC_CHERRY_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, FIGHTERS_FIZZ_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, TIME_OUT_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, TOMBSTONE_SODA_ALIAS))
			callback::on_laststand (&callback_player_laststand);
			
		//Callback for Special Death Anims - Only run if perks that use it are enabled
		if (IsInArray (level.mod_force_enable_west_perk, MUSCLE_MILK_ALIAS))
			zm_spawner::register_zombie_death_animscript_callback (&callback_zombie_death_response);
			
		callback::on_connect (&callback_player_connect);
	}
	
	else if (ENABLE_COMMUNITY_PERK_COLLECTION == 1)
	{
		if (BRAWLSTAR_PUNCH_LEVEL_USE_PERK == 1)
			level.brawlstar_punch_fists = GetWeapon (BRAWLSTAR_PUNCH_WEAPON_FISTS);
		
		if (GLITCHING_GIN_LEVEL_USE_PERK == 1)
		{
			if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
			{
				zm_utility::register_tactical_grenade_for_level (GLITCHING_GIN_GRENADE_TACTICAL);
				level.w_glitching_gin_grenade = GetWeapon (GLITCHING_GIN_GRENADE_TACTICAL);
			}
			
			else
			{
				zm_utility::register_lethal_grenade_for_level (GLITCHING_GIN_GRENADE_LETHAL);
				level.w_glitching_gin_grenade = GetWeapon (GLITCHING_GIN_GRENADE_LETHAL);
			}
		}
		
		if (MEDUSAS_MAURESQUE_LEVEL_USE_PERK == 1)
			level thread medusas_mauresque_think();
		
		if (REBATE_ROSE_LEVEL_USE_PERK == 1)
			level thread global_check_for_purchases();
			
		if (SLIP_AWAY_LEVEL_USE_PERK == 1)
			level thread slip_away_setup_spawn_points();
		
		if (TIMESLIP_LEVEL_USE_PERK == 1)
			level thread timeslip_trap_cooldown(); //Timeslip Trap Cooldown
			
		if (WUNDERFIZZ_LEVEL_USE == 1)
			level thread wunderfizz_main();
			
		//AI Damage Taken Callback -- Only run callback if one of the perks using it are enabled
		if (BLEEDING_LEVEL_USE_PERK == 1 ||
			BLOOD_WOLF_LEVEL_USE_PERK == 1 ||
			BRAWLSTAR_PUNCH_LEVEL_USE_PERK == 1 ||
			BULL_ICE_BLAST_LEVEL_USE_PERK == 1 ||
			CRACK_SHOT_LEVEL_USE_PERK == 1 ||
			CRUSADERS_ALE_LEVEL_USE_PERK == 1 ||
			CRYO_SLIDE_LEVEL_USE_PERK == 1 ||
			DOUBLE_DEW_LEVEL_USE_PERK == 1 ||
			DOUBLETAP3_LEVEL_USE_PERK == 1 ||
			DYING_WISH_LEVEL_USE_PERK == 1 ||
			ELEMENTAL_POP_LEVEL_USE_PERK == 1 ||
			MADGAZ_MOONSHINE_LEVEL_USE_PERK == 1 ||
			POWER_AID_PUNCH_LEVEL_USE_PERK == 1 ||
			ROULETTE_LEVEL_USE_PERK == 1 ||
			REBATE_ROSE_LEVEL_USE_PERK == 1 ||
			SAMURAIS_SPIRIT_LEVEL_USE_PERK == 1 ||
			VIGOR_RUSH_LEVEL_USE_PERK == 1 ||
			WIDOWS_WINE_LEVEL_USE_PERK == 1 ||
			ZOMBSHELL_LEVEL_USE_PERK == 1)
		{
			zm::register_actor_damage_callback (&callback_zombie_damage_override);
			zm::register_vehicle_damage_callback (&callback_vehicle_damage_override);
		}
		
		//AI Response to Damage Callback, DO NOT OVERRIDE DAMAGE HERE
		if (VIGOR_RUSH_LEVEL_USE_PERK == 1 || WIDOWS_WINE_LEVEL_USE_PERK == 1)
			zm_spawner::register_zombie_damage_callback (&callback_zombie_damage_response);
		
		//AI Death Callback -- Only run callback if one of the perks using it are enabled
		if (SPACE_CADET_LEVEL_USE_PERK == 1 || 
			FIGHTERS_FIZZ_LEVEL_USE_PERK == 1 ||
			WIDOWS_WINE_LEVEL_USE_PERK == 1)
			zm_spawner::register_zombie_death_event_callback (&callback_ai_death);
		
		//Player Damage Taken Callback -- Only run callback if one of the perks using it are enabled
		if (BRAWLSTAR_PUNCH_LEVEL_USE_PERK == 1 ||
			BULL_ICE_BLAST_LEVEL_USE_PERK == 1 ||
			DYING_WISH_LEVEL_USE_PERK == 1 ||
			GLITCHING_GIN_LEVEL_USE_PERK == 1 ||
			PICKPOCKET_PALOMA_LEVEL_USE_PERK == 1 ||
			PHD_FLOPPER_LEVEL_USE_PERK == 1 ||
			PHD_SLIDER_LEVEL_USE_PERK == 1 ||
			PRICKLING_PROSECCO_LEVEL_USE_PERK == 1 ||
			SLIP_AWAY_LEVEL_USE_PERK == 1 ||
			SLURPENTINE_LEVEL_USE_PERK == 1 ||
			SIDE_STEP_LEVEL_USE_PERK == 1 ||
			STONE_COLD_LEVEL_USE_PERK == 1 ||
			WIDOWS_WINE_LEVEL_USE_PERK == 1 ||
			WINTERS_WAIL_LEVEL_USE_PERK == 1)
			zm_perks::register_perk_damage_override_func (&callback_player_damage_override);
		
		//Laststand Handling -- Only run callback if one of the perks using it are enabled
		if (ELECTRIC_CHERRY_LEVEL_USE_PERK == 1 ||
			FIGHTERS_FIZZ_LEVEL_USE_PERK == 1 ||
			TIME_OUT_LEVEL_USE_PERK == 1 ||
			TOMBSTONE_SODA_LEVEL_USE_PERK == 1)
			callback::on_laststand (&callback_player_laststand);
			
		//Callback for Special Death Anims - Only run if perks that use it are enabled
		if (MUSCLE_MILK_LEVEL_USE_PERK == 1)
			zm_spawner::register_zombie_death_animscript_callback (&callback_zombie_death_response);
			
		callback::on_connect (&callback_player_connect);
	}
	
	//Allow flags to init
	wait 1;
	
	if (level flag::exists ("initial_blackscreen_passed"))
		level flag::wait_till ("initial_blackscreen_passed");
		
	if (PERK_RETURN_LEVEL_USE == 1)
	{
		vending_triggers = GetEntArray ("zombie_vending", "targetname");
		array::thread_all (vending_triggers, &war_perk_return_spawn);
	}
	
	if (USE_SPARE_CHANGE == 1)
		level thread spare_change();
}

function callback_player_connect()
{
	//SELF == PLAYER

	level endon ("end_game");
	level endon ("game_over");
    level endon ("intermission");
	self endon ("disconnect");
	
	if (PERK_RETURN_LEVEL_USE == 1)
		if (!IsDefined (self.perks_active))
			self.perks_active = [];
	
	if (!IsDefined (self.init_specialty_stats))
	{
		self.init_specialty_stats = 1;
		self thread init_specialty_stats();
	}
	
	if (SHOW_COOLDOWN_BARS == 1)
		self thread handle_cooldown_bars();
		
	if (IsDefined (level.mod_force_enable_west_perk) && level.mod_force_enable_west_perk.size > 0)
	{
		if (IsInArray (level.mod_force_enable_west_perk, BRAWLSTAR_PUNCH_ALIAS))
		{
			if (!IsDefined (self.brawlstar_punch_first_active))
				self.brawlstar_punch_first_active = false;
		
			self.brawlstar_punch_active = false;
		}
		
		if (IsInArray (level.mod_force_enable_west_perk, ICU_ALIAS) || 
			IsInArray (level.mod_force_enable_west_perk, MASOCHIST_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SLURPENTINE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, SPECTRAL_SHAKE_ALIAS))
			self thread common_speed_function();
			
		if (IsInArray (level.mod_force_enable_west_perk, BANANA_COLADA_ALIAS) || 
			IsInArray (level.mod_force_enable_west_perk, PHD_SLIDER_ALIAS))
			self thread common_slide_boost();
			
		if (IsInArray (level.mod_force_enable_west_perk, ASTRO_ALE_ALIAS) || 
			IsInArray (level.mod_force_enable_west_perk, BULL_ICE_BLAST_ALIAS))
			self thread common_multi_jump();
			
		if (IsInArray (level.mod_force_enable_west_perk, ATOMIC_LIQUEUR_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, CRYO_SLIDE_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, MUSCLE_MILK_ALIAS))
			self thread common_melee_handler();
			
		if (IsInArray (level.mod_force_enable_west_perk, PHD_FLOPPER_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, POWER_AID_PUNCH_ALIAS))	
			self thread common_grenade_thrown_watch();
			
		if (IsInArray (level.mod_force_enable_west_perk, ETHEREAL_RAZOR_ALIAS) ||
			IsInArray (level.mod_force_enable_west_perk, WIDOWS_WINE_ALIAS))
			self thread common_track_melee_weapon();
	}
	
	else
	{
		if (BRAWLSTAR_PUNCH_LEVEL_USE_PERK == 1)
		{
			if (!IsDefined (self.brawlstar_punch_first_active))
				self.brawlstar_punch_first_active = false;
		
			self.brawlstar_punch_active = false;
		}
		
		if (ICU_LEVEL_USE_PERK == 1 || 
			MASOCHIST_LEVEL_USE_PERK == 1 || 
			SLURPENTINE_LEVEL_USE_PERK == 1 ||
			SPECTRAL_SHAKE_LEVEL_USE_PERK == 1)
			self thread common_speed_function();
			
		if (BANANA_COLADA_LEVEL_USE_PERK == 1 || PHD_SLIDER_LEVEL_USE_PERK == 1)
			self thread common_slide_boost();
			
		if (ASTRO_ALE_LEVEL_USE_PERK == 1 || BULL_ICE_BLAST_LEVEL_USE_PERK == 1)
			self thread common_multi_jump();
			
		if (ATOMIC_LIQUEUR_LEVEL_USE_PERK == 1 ||
			CRYO_SLIDE_LEVEL_USE_PERK == 1 ||
			MUSCLE_MILK_LEVEL_USE_PERK == 1)
			self thread common_melee_handler();
			
		if (PHD_FLOPPER_LEVEL_USE_PERK == 1 ||
			POWER_AID_PUNCH_LEVEL_USE_PERK == 1)
			self thread common_grenade_thrown_watch();
			
		if (ETHEREAL_RAZOR_LEVEL_USE_PERK == 1 ||
			WIDOWS_WINE_LEVEL_USE_PERK == 1)
			self thread common_track_melee_weapon();
	}
	
	self.west_perk_purchase = [];
	
	for (;;)
	{
		self waittill ("west_perk_purchased");
		
		if (IsDefined (self.west_perk_purchase) && self.west_perk_purchase.size > 0)
		{
			for (i = 0; i < self.west_perk_purchase.size; i++)
			{
				if (self.west_perk_purchase [i] == AMMO_AMERICANO_PERK)
					self thread ammo_americano_weapon_check();
					
				else if (self.west_perk_purchase [i] == BANANA_COLADA_PERK)	
					self thread banana_colada_think();
					
				else if (self.west_perk_purchase [i] == BANDOLIER_BANDIT_PERK)				
					self thread bandolier_bandit_logic();
					
				else if (self.west_perk_purchase [i] == BLAZE_PHASE_PERK)				
					self thread blaze_phase_logic();
					
				else if (self.west_perk_purchase [i] == BLOOD_WOLF_PERK)				
					self thread blood_wolf_damage_monitor();
					
				else if (self.west_perk_purchase [i] == BRAWLSTAR_PUNCH_PERK)
					self thread brawlstar_punch_think();
				
				else if (self.west_perk_purchase [i] == BRIMSTONE_BRAMBLE_PERK)
					self thread brimstone_zombie_array();
					
				else if (self.west_perk_purchase [i] == BULL_ICE_BLAST_PERK)
					self thread bull_ice_blast_think();
					
				else if (self.west_perk_purchase [i] == CRUSADERS_ALE_PERK)
					self thread crusaders_ale_shield_refresh();
					
				else if (self.west_perk_purchase [i] == CRYO_SLIDE_PERK)
					self thread cryo_slide_think();
					
				else if (self.west_perk_purchase [i] == DIVINE_ALE_PERK)
					self thread divine_ale_think();	
					
				else if (self.west_perk_purchase [i] == ELECTRIC_CHERRY_PERK)
					self thread electric_cherry_reload_attack();
					
				else if (self.west_perk_purchase [i] == ETHEREAL_RAZOR_PERK)
					self thread ethereal_razor_think();
				
				else if (self.west_perk_purchase [i] == FIGHTERS_FIZZ_PERK)
					self thread fighters_fizz_weapon_change_check();
				
				else if (self.west_perk_purchase [i] == GAMBLERS_GIBSON_PERK)
					self thread gamblers_box_check();
				
				else if (self.west_perk_purchase [i] == GLITCHING_GIN_PERK)
					self thread glitching_gin_think();
					
				else if (self.west_perk_purchase [i] == ICU_PERK)
					self thread icu_think();
					
				else if (self.west_perk_purchase [i] == MADGAZ_MOONSHINE_PERK)
					self thread madgaz_moonshine_think();
					
				else if (self.west_perk_purchase [i] == MASOCHIST_PERK)	
					self thread masochist_speed_function();
				
				else if (self.west_perk_purchase [i] == MAGNET_PERK)
					self thread powerup_magnet();
					
				else if (self.west_perk_purchase [i] == PHD_FLOPPER_PERK)
					self thread phd_flopper_watch_for_fall();
					
				else if (self.west_perk_purchase [i] == PHD_SLIDER_PERK)
					self thread phd_slider_think();
					
				else if (self.west_perk_purchase [i] == SALVAGE_SHAKE_PERK)
					self thread salvage_shake_think();
					
				else if (self.west_perk_purchase [i] == SLURPENTINE_PERK)
					self thread slurpentine_speed_function();
					
				else if (self.west_perk_purchase [i] == SNAILS_PACE_PERK)
					self thread snails_pace_logic();
				
				else if (self.west_perk_purchase [i] == SPACE_CADET_PERK)
					self thread space_cadet_main();
					
				else if (self.west_perk_purchase [i] == SPECTRAL_SHAKE_PERK)
					self thread spectral_shake_think();
					
				else if (self.west_perk_purchase [i] == STONE_COLD_PERK)
					self thread stone_cold_think();
					
				else if (self.west_perk_purchase [i] == TACTIQUILLA_PERK)
					self thread tactiquilla_think();	
				
				else if (self.west_perk_purchase [i] == TIME_OUT_PERK)
					self thread time_out_reviver();
				
				else if (self.west_perk_purchase [i] == VERRUCKT_JUG_PERK)
					self thread verruckt_jug_health_regen();
				
				else if (self.west_perk_purchase [i] == WALL_POWER_PERK)
					self thread wall_power_upgrade_weapon();
					
				else if (self.west_perk_purchase [i] == WIDOWS_WINE_PERK)
					self thread widows_wine_think();
					
				else if (self.west_perk_purchase [i] == WINDRUNNER_PERK)
					self thread windrunner_logic();
					
				else if (self.west_perk_purchase [i] == WINTERS_WAIL_PERK)
					self thread winters_wail_think();
					
				//self IPrintLnBold (self.west_perk_purchase [i]);
			}
				
			self.west_perk_purchase = [];
		}
	}
}

function init_specialty_stats()
{
	//SELF == PLAYER
	
	//Perks
	self globallogic_score::initpersstat (AMMO_AMERICANO_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ASTRO_ALE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ATOMIC_LIQUEUR_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BANANA_COLADA_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BANDOLIER_BANDIT_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BLAZE_PHASE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BLOOD_WOLF_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BLEEDING_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BRAWLSTAR_PUNCH_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BRIMSTONE_BRAMBLE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (BULL_ICE_BLAST_PERK + "_drank", 0);
	self globallogic_score::initpersstat (CRACK_SHOT_PERK + "_drank", 0);
	self globallogic_score::initpersstat (CRUSADERS_ALE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (CRYO_SLIDE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DEATH_PERCEPTION_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DIVINE_ALE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DOUBLE_DEW_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DOUBLETAP1_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DOUBLETAP3_PERK + "_drank", 0);
	self globallogic_score::initpersstat (DYING_WISH_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ELECTRIC_CHERRY_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ELEMENTAL_POP_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ETHEREAL_RAZOR_PERK + "_drank", 0);
	self globallogic_score::initpersstat (FIGHTERS_FIZZ_PERK + "_drank", 0);
	self globallogic_score::initpersstat (GAMBLERS_GIBSON_PERK + "_drank", 0);
	self globallogic_score::initpersstat (GLITCHING_GIN_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ICU_PERK + "_drank", 0);
	self globallogic_score::initpersstat (MADGAZ_MOONSHINE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (MAGNET_PERK + "_drank", 0);
	self globallogic_score::initpersstat (MASOCHIST_PERK + "_drank", 0);
	self globallogic_score::initpersstat (MEDUSAS_MAURESQUE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (MUSCLE_MILK_PERK + "_drank", 0);
	self globallogic_score::initpersstat (PHD_FLOPPER_PERK + "_drank", 0);
	self globallogic_score::initpersstat (PHD_SLIDER_PERK + "_drank", 0);
	self globallogic_score::initpersstat (PICKPOCKET_PALOMA_PERK + "_drank", 0);
	self globallogic_score::initpersstat (POWER_AID_PUNCH_PERK + "_drank", 0);
	self globallogic_score::initpersstat (PRICKLING_PROSECCO_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ROULETTE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (REBATE_ROSE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SALVAGE_SHAKE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SAMURAIS_SPIRIT_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SIDE_STEP_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SLIP_AWAY_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SLURPENTINE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SNAILS_PACE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SPACE_CADET_PERK + "_drank", 0);
	self globallogic_score::initpersstat (SPECTRAL_SHAKE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (STONE_COLD_PERK + "_drank", 0);
	self globallogic_score::initpersstat (TACTIQUILLA_PERK + "_drank", 0);
	self globallogic_score::initpersstat (TIME_OUT_PERK + "_drank", 0);
	self globallogic_score::initpersstat (TIMESLIP_PERK + "_drank", 0);
	self globallogic_score::initpersstat (TOMBSTONE_SODA_PERK + "_drank", 0);
	self globallogic_score::initpersstat (VERRUCKT_JUG_PERK + "_drank", 0);
	self globallogic_score::initpersstat (VICTORIOUS_TORTOISE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (VIGOR_RUSH_PERK + "_drank", 0);
	self globallogic_score::initpersstat (WALL_POWER_PERK + "_drank", 0);
	self globallogic_score::initpersstat (WIDOWS_WINE_PERK + "_drank", 0);
	self globallogic_score::initpersstat (WINDRUNNER_PERK + "_drank", 0);
	self globallogic_score::initpersstat (WINTERS_WAIL_PERK + "_drank", 0);
	self globallogic_score::initpersstat (ZOMBSHELL_PERK + "_drank", 0);
	
	//Powerups
	self globallogic_score::initpersstat (WIDOWS_WINE_POWERUP_ALIAS + "_pickedup", false);
}

//AI Damage Taken Callback
function callback_zombie_damage_override (inflictor, attacker, damage, flags, sMeansOfDeath, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType)
{
	//SELF == AI
	//ATTACKER == PLAYER
	
	//AI is dead or isnt defined
	if (!IsDefined (self) || !IsAI (self) || !IsAlive (self))
		return -1;
	
	//Attacker isnt defined or a player
	if (!IsDefined (attacker) || !IsPlayer (attacker))
		return -1;
		
	//Friendly fire not cause by myself
	if ((IsDefined (self.team) && self.team == "allies") && self != attacker)
		return -1;
		
	//No damage value defined
	if (!IsDefined (damage))
		return -1;
		
	old_damage = damage;
	
	if (IsDefined (self.bull_ice_blast_frozen) && self.bull_ice_blast_frozen == 1)
	{
		PlayFX (level._effect ["bull_ice_slam_break"], self.origin + (0, 0, 35));
		PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_SHATTER + RandomIntRange (0, BULL_ICE_BLAST_SOUND_SHATTER_COUNT), self.origin);
		
		if (IsDefined (self.bull_ice_blast_freeze_fx))
			self.bull_ice_blast_freeze_fx Delete();
		
		if (IsDefined (self.bull_ice_blast_freeze_model))
			self.bull_ice_blast_freeze_model Delete();
		
		self ASMSetAnimationRate (1.0);
	}
	
	if (IsDefined (self.cryo_slide_freeze) && self.cryo_slide_freeze == 1)
	{
		PlayFX (CRYO_SLIDE_FX_FROZEN_ZOMBIE_KILL, self.origin + (0, 0, 50));
		PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_SHATTER + RandomIntRange (0, BULL_ICE_BLAST_SOUND_SHATTER_COUNT), self.origin);
		
		if (IsDefined (self.cryo_slide_freeze_fx))
			self.cryo_slide_freeze_fx Delete();
		
		self ASMSetAnimationRate (1.0);
	}
	
	if ((IsDefined (attacker.west_hasperk_brawlstar) && attacker.west_hasperk_brawlstar == 1) &&
		(IsDefined (attacker.brawlstar_punch_active) && attacker.brawlstar_punch_active) &&
		(IsDefined (weapon) && IsDefined (level.brawlstar_punch_fists) && weapon == level.brawlstar_punch_fists) &&
		(IsDefined (sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE"))
	{
		//If AI is NOT protected from Brawlstar Punch
		if (!IsDefined (self.ai_too_op_for_brawlstar_punch) || self.ai_too_op_for_brawlstar_punch == 0)
		{
			self brawlstar_punch_special_deaths (attacker, vpoint);
			damage = self.health + 666;
		}
		
		if (old_damage > damage)
			damage = old_damage;
		
		if ((IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1) && damage > self.health)
			attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_MELEE);
			
		if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
			if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
				self thread zombshell_think (attacker);
		
		if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
			if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) && 
				(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
				attacker notify ("blood_wolf_damage", damage);
		
		self ASMSetAnimationRate (1.0);
		
		return damage;
	}
	
	if (IsDefined (sMeansOfDeath))
	{
		if (sMeansOfDeath == "MOD_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET")
		{
			if (IsDefined (attacker.west_hasperk_roulette) && attacker.west_hasperk_roulette == 1)
			{
				if (!IsDefined (self.ai_too_op_for_reapers_roulette) || self.ai_too_op_for_reapers_roulette == 0) //If AI is NOT protected from Reaper's Roulette
				{
					bullet_insta = RandomIntRange (1, 101);
				
					if (bullet_insta <= ROULETTE_INSTA_PERCENT)
					{
						damage = self.maxhealth + 666;
				
						if (old_damage > damage)
							damage = old_damage;
							
						if (IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1)
						{
							//Is headshot?
							if (IsDefined (weapon) && IsDefined (sHitLoc) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
								attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_HEADSHOT);
				
							//Normal kill
							else
								attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_NORMAL);
						}
						
						if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
							if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
								self thread zombshell_think (attacker);
						
						if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
							if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) &&
								(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
								attacker notify ("blood_wolf_damage", damage);
						
						self ASMSetAnimationRate (1.0);
						
						return damage;
					}
				}
			}
			
			if (IsDefined (attacker.west_hasperk_madgaz_moonshine) && attacker.west_hasperk_madgaz_moonshine == 1)
				if ((!IsDefined (self.is_burning) || !self.is_burning) &&
					RandomIntRange (1, 101) <= MADGAZ_MOONSHINE_FIRE_CHANCE)
					self DoDamage (1, self.origin, attacker, attacker, 0, "MOD_BURNED");
			
			if (IsDefined (attacker.west_hasperk_vigor_rush) && attacker.west_hasperk_vigor_rush == 1)
			{
				//If AI is NOT protected from Vigor Rush
				if (!IsDefined (self.ai_too_op_for_vigor_rush) || self.ai_too_op_for_vigor_rush == 0)
				{
					damage *= VIGOR_RUSH_DAMAGE_MULTIPLIER;
				
					if (VIGOR_RUSH_ALLOW_EXPLOSION_FX == 1 && IsDefined (sHitLoc))
						self thread vigor_rush_explosion (sHitLoc, attacker);
				
					if (old_damage > damage)
						damage = old_damage;
				}
			}
			
			if (IsDefined (attacker.west_hasperk_power_aid_punch) && attacker.west_hasperk_power_aid_punch == 1)
			{
				 //If AI is NOT protected from Power Aid Punch
				if (!IsDefined (self.ai_too_op_for_power_aid_punch) || self.ai_too_op_for_power_aid_punch == 0)
				{
					damage *= POWER_AID_PUNCH_DAMAGE_BULLET;
				
					if (POWER_AID_PUNCH_ALLOW_HIT_LOC_FX == 1 && IsDefined (sHitLoc))
						self thread power_aid_punch_impact_fx (sHitLoc, attacker);
				
					if (old_damage > damage)
						damage = old_damage;
				}
			}
		}
		
		else if (sMeansOfDeath == "MOD_EXPLOSIVE" || sMeansOfDeath == "MOD_EXPLOSIVE_SPLASH" ||
				sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" ||
				sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH")
		{
			if (IsDefined (attacker.west_hasperk_power_aid_punch) && attacker.west_hasperk_power_aid_punch == 1)
			{
				 //If AI is NOT protected from Power Aid Punch
				if (!IsDefined (self.ai_too_op_for_power_aid_punch) || self.ai_too_op_for_power_aid_punch == 0)
				{
					damage *= POWER_AID_PUNCH_DAMAGE_EXPLOSIVE;
					
					if (old_damage > damage)
						damage = old_damage;
				}
			}
		}
		
		else if (sMeansOfDeath == "MOD_MELEE")
		{
			if ((IsDefined (attacker.west_hasperk_dying_wish) && attacker.west_hasperk_dying_wish == 1) && 
				IsDefined (attacker.dying_wish_active) && attacker.dying_wish_active == 1 &&
				IsDefined (attacker.dying_wish_on_cooldown) && attacker.dying_wish_on_cooldown == 0)
			{
				//If AI is NOT protected from Dying Wish
				if (!IsDefined (self.ai_too_op_for_dying_wish) || self.ai_too_op_for_dying_wish == 0)
				{
					dying_wish_damage = (self.maxhealth * DYING_WISH_BERSERK_MULTIPLIER) + 1;
					
					if (!IsInt (dying_wish_damage))
						dying_wish_damage = Int (dying_wish_damage);
						
					damage += dying_wish_damage;
					
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
		
			if (IsDefined (attacker.west_hasperk_samurai) && attacker.west_hasperk_samurai == 1)
			{
				//If AI is NOT protected from Samurai's Spirit
				if (!IsDefined (self.ai_too_op_for_samurais_spirit) || self.ai_too_op_for_samurais_spirit == 0)
				{
					damage *= attacker.samurai_melee_multiplier;
			
					if (damage >= self.health && damage < self.maxhealth * SAMURAIS_SPIRIT_DAMAGE_LIMIT)
						attacker.samurai_melee_multiplier *= SAMURAIS_SPIRIT_DAMAGE_INCREASE;
			
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
			
			if (IsDefined (attacker.west_hasperk_crusaders_ale) && attacker.west_hasperk_crusaders_ale == 1)
			{
				//If AI is NOT protected from Crusader's Ale
				if (!IsDefined (self.ai_too_op_for_crusaders_ale) || self.ai_too_op_for_crusaders_ale == 0)
				{
					damage *= CRUSADERS_ALE_MELEE_MULTIPLIER;
			
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
			
			attacker notify ("west_perks_melee_used", self);
		}
	}
	
	if ((IsDefined (attacker.west_hasperk_stone_cold) && attacker.west_hasperk_stone_cold == 1) &&
		(IsDefined (attacker.stone_cold_armor) && attacker.stone_cold_armor > 0))
	{
		//If AI is NOT protected from Stone Cold Stronghold
		if (!IsDefined (self.ai_too_op_for_stone_cold) || self.ai_too_op_for_stone_cold == 0)
		{
			multiplier = attacker.stone_cold_armor / 100;
		
			damage *= (1 + multiplier);
		
			if (old_damage > damage)
				damage = old_damage;
			
			else
				old_damage = damage;
		}
	}
		
	if (IsDefined (attacker.west_hasperk_doubletap3) && attacker.west_hasperk_doubletap3 == 1)
	{
		//If AI is NOT protected from Double Tap 3.0
		if (!IsDefined (self.ai_too_op_for_doubletap3) || self.ai_too_op_for_doubletap3 == 0)
		{
			damage *= DOUBLETAP3_DAMAGE_BUFF_MULTIPLIER;
		
			if (old_damage > damage)
				damage = old_damage;
			
			else
				old_damage = damage;
		}
	}
	
	if (IsDefined (attacker.west_hasperk_bleeding) && attacker.west_hasperk_bleeding == 1)
	{
		//If AI is NOT protected from Bleeding Bloody Mary
		if (!IsDefined (self.ai_too_op_for_bleeding_bloody_mary) || self.ai_too_op_for_bleeding_bloody_mary == 0)
		{
			if (attacker.health <= attacker.maxhealth * (BLEEDING_LOW_HEALTH_PERCENTAGE / 100))
			{
				damage *= BLEEDING_DAMAGE_MULTIPLIER;
				
				if (old_damage > damage)
					damage = old_damage;
				
				else
					old_damage = damage;
			}
		}
	}
	
	if (IsDefined (self.zombshell_within_range) && self.zombshell_within_range == 1)
	{
		//If AI is NOT protected from Zombshell
		if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0)
		{
			damage *= ZOMBSHELL_FIELD_DAMAGE;
			
			if (old_damage > damage)
				damage = old_damage;
				
			else
				old_damage = damage;
		}
	}
	
	if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
		(IsDefined (attacker.divine_ale_double_damage) && attacker.divine_ale_double_damage == 1))
	{
		if (IsDefined (weapon))
		{
			weapon_primaries = attacker GetWeaponsListPrimaries();
			
			if (IsDefined (weapon_primaries [0]))
			{
				if (weapon == weapon_primaries [0])
				{
					//If AI is NOT protected from Divine Ale
					if (!IsDefined (self.ai_too_op_for_divine_ale) || self.ai_too_op_for_divine_ale == 0)
					{
						damage *= DIVINE_ALE_DAMAGE_MULTIPLIER;
						
						if (old_damage > damage)
							damage = old_damage;
							
						else
							old_damage = damage;
					}
				}
			}
		}
	}
	
	ai_will_die = 0;
	
	//Zombie should die from this
	if (damage >= self.health)
		ai_will_die = 1;
		
	if (IsDefined (attacker.team) && 
		(IsDefined (level.zombie_vars [attacker.team]["zombie_insta_kill"]) && level.zombie_vars [attacker.team]["zombie_insta_kill"] == 1))
		ai_will_die = 1;
	
	if (ai_will_die)
	{
		self ASMSetAnimationRate (1.0);
		
		if (IsDefined (attacker.west_hasperk_crack_shot) && attacker.west_hasperk_crack_shot == 1)
			//Is headshot?
			if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
				attacker thread common_give_ammo (weapon, CRACK_SHOT_HEADSHOT_AMMO_GIVE);
				
		if (IsDefined (attacker.west_hasperk_crusaders_ale) && attacker.west_hasperk_crusaders_ale == 1)
			//Is melee?
			if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
				(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
				attacker thread common_give_points (CRUSADERS_ALE_MELEE_POINTS);
		
		if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
			(IsDefined (attacker.divine_ale_double_points) && attacker.divine_ale_double_points == 1))
		{
			if (IsDefined (weapon))
			{
				weapon_primaries = attacker GetWeaponsListPrimaries();
				
				if (IsDefined (weapon_primaries [0]))
				{
					if (weapon == weapon_primaries [0])
					{
						//Is headshot?
						if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
							attacker thread common_give_points (DIVINE_ALE_POINTS_HEADSHOT * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
							
						//Is melee?
						else if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
								(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
							attacker thread common_give_points (DIVINE_ALE_POINTS_MELEE * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
							
						//Normal kill
						else
							attacker thread common_give_points (DIVINE_ALE_POINTS_NORMAL * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
					}
				}
			}
		}
		
		if (IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1)
		{
			//Is headshot?
			if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_HEADSHOT);
				
			//Is melee?
			else if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
					(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_MELEE);
				
			//Normal kill
			else
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_NORMAL);
		}
		
		if (IsDefined (attacker.west_hasperk_rebate_rose) && attacker.west_hasperk_rebate_rose == 1)
			attacker thread rebate_rose_give_bonus_for_kill();
				
		if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
			if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
				self thread zombshell_think (attacker);
	}
	
	else
	{
		if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
			(IsDefined (attacker.divine_ale_double_points) && attacker.divine_ale_double_points == 1))
		{
			if (IsDefined (weapon))
			{
				weapon_primaries = attacker GetWeaponsListPrimaries();
				
				if (IsDefined (weapon_primaries [0]))
					if (weapon == weapon_primaries [0])
						attacker thread common_give_points (10 * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
			}
		}
	}
	
	if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
		if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) &&
			(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
			attacker notify ("blood_wolf_damage", damage);
			
	if ((IsDefined (attacker.west_hasperk_elemental_pop) && attacker.west_hasperk_elemental_pop == 1) &&
		(IsDefined (attacker.elemental_pop_on_cooldown) && attacker.elemental_pop_on_cooldown == 0))
		if (!IsDefined (self.ai_too_op_for_elemental_pop) || self.ai_too_op_for_elemental_pop == 0) //If AI is NOT protected from Elemental Pop
			if (IsDefined (weapon) && IsDefined (sMeansOfDeath))
				attacker thread elemental_pop_think (self, ai_will_die, weapon, sMeansOfDeath);
				
	return damage;
}

//Vehicle AI Damage Taken
function callback_vehicle_damage_override (inflictor, attacker, damage, flags, sMeansOfDeath, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType)
{
	//SELF == AI
	//ATTACKER == PLAYER
	
	//AI is dead or isnt defined
	if (!IsDefined (self) || !IsAI (self) || !IsAlive (self))
		return damage;
	
	//Attacker isnt defined or a player
	if (!IsDefined (attacker) || !IsPlayer (attacker))
		return damage;
		
	//Friendly fire not cause by myself
	if ((IsDefined (self.team) && self.team == "allies") && self != attacker)
		return damage;
		
	//No damage value defined
	if (!IsDefined (damage))
		return damage;
	
	old_damage = damage;
	
	if (IsDefined (self.bull_ice_blast_frozen) && self.bull_ice_blast_frozen == 1)
	{
		PlayFX (level._effect ["bull_ice_slam_break"], self.origin + (0, 0, 35));
		PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_SHATTER + RandomIntRange (0, BULL_ICE_BLAST_SOUND_SHATTER_COUNT), self.origin);
		
		if (IsDefined (self.bull_ice_blast_freeze_fx))
			self.bull_ice_blast_freeze_fx Delete();
		
		if (IsDefined (self.bull_ice_blast_freeze_model))
			self.bull_ice_blast_freeze_model Delete();
		
		self ASMSetAnimationRate (1.0);
	}
	
	if (IsDefined (self.cryo_slide_freeze) && self.cryo_slide_freeze == 1)
	{
		PlayFX (CRYO_SLIDE_FX_FROZEN_ZOMBIE_KILL, self.origin + (0, 0, 50));
		PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_SHATTER + RandomIntRange (0, BULL_ICE_BLAST_SOUND_SHATTER_COUNT), self.origin);
		
		if (IsDefined (self.cryo_slide_freeze_fx))
			self.cryo_slide_freeze_fx Delete();
		
		self ASMSetAnimationRate (1.0);
	}
	
	if ((IsDefined (attacker.west_hasperk_brawlstar) && attacker.west_hasperk_brawlstar == 1) &&
		(IsDefined (attacker.brawlstar_punch_active) && attacker.brawlstar_punch_active) &&
		(IsDefined (weapon) && IsDefined (level.brawlstar_punch_fists) && weapon == level.brawlstar_punch_fists) &&
		(IsDefined (sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE"))
	{
		//If AI is NOT protected from Brawlstar Punch
		if (!IsDefined (self.ai_too_op_for_brawlstar_punch) || self.ai_too_op_for_brawlstar_punch == 0)
		{
			self brawlstar_punch_special_deaths (attacker, vpoint);
			damage = self.health + 666;
		}
		
		if (old_damage > damage)
			damage = old_damage;
		
		if ((IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1) && damage > self.health)
			attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_MELEE);
			
		if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
			if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
				self thread zombshell_think (attacker);
		
		if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
			if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) && 
				(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
				attacker notify ("blood_wolf_damage", damage);
		
		self ASMSetAnimationRate (1.0);
		
		return damage;
	}
	
	if (IsDefined (sMeansOfDeath))
	{
		if (sMeansOfDeath == "MOD_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET")
		{
			if (IsDefined (attacker.west_hasperk_roulette) && attacker.west_hasperk_roulette == 1)
			{
				if (!IsDefined (self.ai_too_op_for_reapers_roulette) || self.ai_too_op_for_reapers_roulette == 0) //If AI is NOT protected from Reaper's Roulette
				{
					bullet_insta = RandomIntRange (1, 101);
				
					if (bullet_insta <= ROULETTE_INSTA_PERCENT)
					{
						damage = self.maxhealth + 666;
				
						if (old_damage > damage)
							damage = old_damage;
							
						if (IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1)
						{
							//Is headshot?
							if (IsDefined (weapon) && IsDefined (sHitLoc) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
								attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_HEADSHOT);
				
							//Normal kill
							else
								attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_NORMAL);
						}
						
						if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
							if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
								self thread zombshell_think (attacker);
						
						if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
							if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) &&
								(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
								attacker notify ("blood_wolf_damage", damage);
						
						self ASMSetAnimationRate (1.0);
						
						return damage;
					}
				}
			}
			
			if (IsDefined (attacker.west_hasperk_madgaz_moonshine) && attacker.west_hasperk_madgaz_moonshine == 1)
				if ((!IsDefined (self.is_burning) || !self.is_burning) &&
					RandomIntRange (1, 101) <= MADGAZ_MOONSHINE_FIRE_CHANCE)
					self DoDamage (1, self.origin, attacker, attacker, 0, "MOD_BURNED");
			
			if (IsDefined (attacker.west_hasperk_vigor_rush) && attacker.west_hasperk_vigor_rush == 1)
			{
				//If AI is NOT protected from Vigor Rush
				if (!IsDefined (self.ai_too_op_for_vigor_rush) || self.ai_too_op_for_vigor_rush == 0)
				{
					damage *= VIGOR_RUSH_DAMAGE_MULTIPLIER;
				
					if (VIGOR_RUSH_ALLOW_EXPLOSION_FX == 1 && IsDefined (sHitLoc))
						self thread vigor_rush_explosion (sHitLoc, attacker);
				
					if (old_damage > damage)
						damage = old_damage;
				}
			}
			
			if (IsDefined (attacker.west_hasperk_power_aid_punch) && attacker.west_hasperk_power_aid_punch == 1)
			{
				 //If AI is NOT protected from Power Aid Punch
				if (!IsDefined (self.ai_too_op_for_power_aid_punch) || self.ai_too_op_for_power_aid_punch == 0)
				{
					damage *= POWER_AID_PUNCH_DAMAGE_BULLET;
				
					if (POWER_AID_PUNCH_ALLOW_HIT_LOC_FX == 1 && IsDefined (sHitLoc))
						self thread power_aid_punch_impact_fx (sHitLoc, attacker);
				
					if (old_damage > damage)
						damage = old_damage;
				}
			}
		}
		
		else if (sMeansOfDeath == "MOD_EXPLOSIVE" || sMeansOfDeath == "MOD_EXPLOSIVE_SPLASH" ||
				sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" ||
				sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH")
		{
			if (IsDefined (attacker.west_hasperk_power_aid_punch) && attacker.west_hasperk_power_aid_punch == 1)
			{
				 //If AI is NOT protected from Power Aid Punch
				if (!IsDefined (self.ai_too_op_for_power_aid_punch) || self.ai_too_op_for_power_aid_punch == 0)
				{
					damage *= POWER_AID_PUNCH_DAMAGE_EXPLOSIVE;
					
					if (old_damage > damage)
						damage = old_damage;
				}
			}
		}
		
		else if (sMeansOfDeath == "MOD_MELEE")
		{
			if ((IsDefined (attacker.west_hasperk_dying_wish) && attacker.west_hasperk_dying_wish == 1) && 
				IsDefined (attacker.dying_wish_active) && attacker.dying_wish_active == 1 &&
				IsDefined (attacker.dying_wish_on_cooldown) && attacker.dying_wish_on_cooldown == 0)
			{
				//If AI is NOT protected from Dying Wish
				if (!IsDefined (self.ai_too_op_for_dying_wish) || self.ai_too_op_for_dying_wish == 0)
				{
					dying_wish_damage = (self.maxhealth * DYING_WISH_BERSERK_MULTIPLIER) + 1;
					
					if (!IsInt (dying_wish_damage))
						dying_wish_damage = Int (dying_wish_damage);
						
					damage += dying_wish_damage;
					
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
		
			if (IsDefined (attacker.west_hasperk_samurai) && attacker.west_hasperk_samurai == 1)
			{
				//If AI is NOT protected from Samurai's Spirit
				if (!IsDefined (self.ai_too_op_for_samurais_spirit) || self.ai_too_op_for_samurais_spirit == 0)
				{
					damage *= attacker.samurai_melee_multiplier;
			
					if (damage >= self.health && damage < self.maxhealth * SAMURAIS_SPIRIT_DAMAGE_LIMIT)
						attacker.samurai_melee_multiplier *= SAMURAIS_SPIRIT_DAMAGE_INCREASE;
			
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
			
			if (IsDefined (attacker.west_hasperk_crusaders_ale) && attacker.west_hasperk_crusaders_ale == 1)
			{
				//If AI is NOT protected from Crusader's Ale
				if (!IsDefined (self.ai_too_op_for_crusaders_ale) || self.ai_too_op_for_crusaders_ale == 0)
				{
					damage *= CRUSADERS_ALE_MELEE_MULTIPLIER;
			
					if (old_damage > damage)
						damage = old_damage;
					
					else
						old_damage = damage;
				}
			}
			
			attacker notify ("west_perks_melee_used", self);
		}
	}
	
	if ((IsDefined (attacker.west_hasperk_stone_cold) && attacker.west_hasperk_stone_cold == 1) &&
		(IsDefined (attacker.stone_cold_armor) && attacker.stone_cold_armor > 0))
	{
		//If AI is NOT protected from Stone Cold Stronghold
		if (!IsDefined (self.ai_too_op_for_stone_cold) || self.ai_too_op_for_stone_cold == 0)
		{
			multiplier = attacker.stone_cold_armor / 100;
		
			damage *= (1 + multiplier);
		
			if (old_damage > damage)
				damage = old_damage;
			
			else
				old_damage = damage;
		}
	}
		
	if (IsDefined (attacker.west_hasperk_doubletap3) && attacker.west_hasperk_doubletap3 == 1)
	{
		//If AI is NOT protected from Double Tap 3.0
		if (!IsDefined (self.ai_too_op_for_doubletap3) || self.ai_too_op_for_doubletap3 == 0)
		{
			damage *= DOUBLETAP3_DAMAGE_BUFF_MULTIPLIER;
		
			if (old_damage > damage)
				damage = old_damage;
			
			else
				old_damage = damage;
		}
	}
	
	if (IsDefined (attacker.west_hasperk_bleeding) && attacker.west_hasperk_bleeding == 1)
	{
		//If AI is NOT protected from Bleeding Bloody Mary
		if (!IsDefined (self.ai_too_op_for_bleeding_bloody_mary) || self.ai_too_op_for_bleeding_bloody_mary == 0)
		{
			if (attacker.health <= attacker.maxhealth * (BLEEDING_LOW_HEALTH_PERCENTAGE / 100))
			{
				damage *= BLEEDING_DAMAGE_MULTIPLIER;
				
				if (old_damage > damage)
					damage = old_damage;
				
				else
					old_damage = damage;
			}
		}
	}
	
	if (IsDefined (self.zombshell_within_range) && self.zombshell_within_range == 1)
	{
		//If AI is NOT protected from Zombshell
		if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0)
		{
			damage *= ZOMBSHELL_FIELD_DAMAGE;
			
			if (old_damage > damage)
				damage = old_damage;
				
			else
				old_damage = damage;
		}
	}
	
	if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
		(IsDefined (attacker.divine_ale_double_damage) && attacker.divine_ale_double_damage == 1))
	{
		if (IsDefined (weapon))
		{
			weapon_primaries = attacker GetWeaponsListPrimaries();
			
			if (IsDefined (weapon_primaries [0]))
			{
				if (weapon == weapon_primaries [0])
				{
					//If AI is NOT protected from Divine Ale
					if (!IsDefined (self.ai_too_op_for_divine_ale) || self.ai_too_op_for_divine_ale == 0)
					{
						damage *= DIVINE_ALE_DAMAGE_MULTIPLIER;
						
						if (old_damage > damage)
							damage = old_damage;
							
						else
							old_damage = damage;
					}
				}
			}
		}
	}
	
	ai_will_die = 0;
	
	//Zombie should die from this
	if (damage >= self.health)
		ai_will_die = 1;
		
	if (IsDefined (attacker.team) && 
		(IsDefined (level.zombie_vars [attacker.team]["zombie_insta_kill"]) && level.zombie_vars [attacker.team]["zombie_insta_kill"] == 1))
		ai_will_die = 1;
	
	if (ai_will_die)
	{
		self ASMSetAnimationRate (1.0);
		
		if (IsDefined (attacker.west_hasperk_crack_shot) && attacker.west_hasperk_crack_shot == 1)
			//Is headshot?
			if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
				attacker thread common_give_ammo (weapon, CRACK_SHOT_HEADSHOT_AMMO_GIVE);
				
		if (IsDefined (attacker.west_hasperk_crusaders_ale) && attacker.west_hasperk_crusaders_ale == 1)
			//Is melee?
			if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
				(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
				attacker thread common_give_points (CRUSADERS_ALE_MELEE_POINTS);
		
		if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
			(IsDefined (attacker.divine_ale_double_points) && attacker.divine_ale_double_points == 1))
		{
			if (IsDefined (weapon))
			{
				weapon_primaries = attacker GetWeaponsListPrimaries();
				
				if (IsDefined (weapon_primaries [0]))
				{
					if (weapon == weapon_primaries [0])
					{
						//Is headshot?
						if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
							attacker thread common_give_points (DIVINE_ALE_POINTS_HEADSHOT * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
							
						//Is melee?
						else if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
								(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
							attacker thread common_give_points (DIVINE_ALE_POINTS_MELEE * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
							
						//Normal kill
						else
							attacker thread common_give_points (DIVINE_ALE_POINTS_NORMAL * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
					}
				}
			}
		}
		
		if (IsDefined (attacker.west_hasperk_double_dew) && attacker.west_hasperk_double_dew == 1)
		{
			//Is headshot?
			if (IsDefined (weapon) && IsDefined (sHitLoc) && IsDefined (sMeansOfDeath) && zm_utility::is_headshot (weapon, sHitLoc, sMeansOfDeath))
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_HEADSHOT);
				
			//Is melee?
			else if ((IsDefined (weapon) && zm_utility::is_melee_weapon (weapon)) || 
					(IsDefined (sMeansOfDeath) &&(sMeansOfDeath == "MOD_MELEE")))
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_MELEE);
				
			//Normal kill
			else
				attacker thread common_give_points (DOUBLE_DEW_BONUS_FOR_NORMAL);
		}
		
		if (IsDefined (attacker.west_hasperk_rebate_rose) && attacker.west_hasperk_rebate_rose == 1)
			attacker thread rebate_rose_give_bonus_for_kill();
				
		if (IsDefined (attacker.west_hasperk_zombshell) && attacker.west_hasperk_zombshell == 1)
			if (!IsDefined (self.ai_too_op_for_zombshell) || self.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
				self thread zombshell_think (attacker);
	}
	
	else
	{
		if ((IsDefined (attacker.west_hasperk_divine_ale) && attacker.west_hasperk_divine_ale == 1) &&
			(IsDefined (attacker.divine_ale_double_points) && attacker.divine_ale_double_points == 1))
		{
			if (IsDefined (weapon))
			{
				weapon_primaries = attacker GetWeaponsListPrimaries();
				
				if (IsDefined (weapon_primaries [0]))
					if (weapon == weapon_primaries [0])
						attacker thread common_give_points (10 * (DIVINE_ALE_POINTS_MULTIPLIER - 1));
			}
		}
		
		if (IsDefined (attacker.west_hasperk_widows_wine) && attacker.west_hasperk_widows_wine == 1)
		{
			//If AI is NOT protected from Widows Wine
			if (!IsDefined (self.ai_too_op_for_widows_wine) || self.ai_too_op_for_widows_wine == 0)
			{
				if (IsDefined (weapon) && (IsDefined (level.w_widows_wine_wpn_grenade) && weapon == level.w_widows_wine_wpn_grenade))
				{
					if (!IsDefined (self.widows_wine_cocoon) || self.widows_wine_cocoon == 0)
					{
						self.widows_wine_cocoon = 1;
						
						self thread widows_wine_vehicle_behavior (attacker, weapon);
					}
				}
				
				else if (IsDefined (sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE")
				{
					if (!IsDefined (self.widows_wine_cocoon) || self.widows_wine_cocoon == 0)
					{
						if (RandomIntRange (1, 101) < WIDOWS_WINE_COCOON_MELEE)
						{
							self.widows_wine_cocoon = 1;
							
							self thread widows_wine_vehicle_behavior (attacker, weapon);
						}
					}
				}
			}
		}
	}
	
	if (IsDefined (attacker.west_hasperk_blood_wolf) && attacker.west_hasperk_blood_wolf == 1)
		if ((IsDefined (attacker.blood_wolf_active) && attacker.blood_wolf_active == 0) &&
			(IsDefined (attacker.blood_wolf_on_cooldown) && attacker.blood_wolf_on_cooldown == 0))
			attacker notify ("blood_wolf_damage", damage);
			
	if ((IsDefined (attacker.west_hasperk_elemental_pop) && attacker.west_hasperk_elemental_pop == 1) &&
		(IsDefined (attacker.elemental_pop_on_cooldown) && attacker.elemental_pop_on_cooldown == 0))
		if (!IsDefined (self.ai_too_op_for_elemental_pop) || self.ai_too_op_for_elemental_pop == 0) //If AI is NOT protected from Elemental Pop
			if (IsDefined (weapon) && IsDefined (sMeansOfDeath))
				attacker thread elemental_pop_think (self, ai_will_die, weapon, sMeansOfDeath);
				
	return damage;
}

//AI Response to Damage Callback, DO NOT OVERRIDE DAMAGE HERE
function callback_zombie_damage_response (sMeansOfDeath, sHitLoc, hit_origin, player, damage, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)
{
	//SELF == AI
	
	if (IsDefined (player.west_hasperk_vigor_rush) && player.west_hasperk_vigor_rush == 1)
		if (IsDefined (sMeansOfDeath) && IsDefined (hit_origin))
			if (sMeansOfDeath == "MOD_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET")
				RadiusDamage (hit_origin, VIGOR_RUSH_EXPLOSION_RADIUS, damage, 0, player, "MOD_EXPLOSIVE");
				
	if (IsDefined (player.west_hasperk_widows_wine) && player.west_hasperk_widows_wine == 1)
	{
		//If AI is NOT protected from Widows Wine
		if (!IsDefined (self.ai_too_op_for_widows_wine) || self.ai_too_op_for_widows_wine == 0)
		{
			if (IsDefined (weapon) && (IsDefined (level.w_widows_wine_wpn_grenade) && weapon == level.w_widows_wine_wpn_grenade))
			{
				if (IsDefined (hit_origin))
				{
					exp_zombie_dist = Distance (hit_origin, self.origin);
					
					if (exp_zombie_dist <= WIDOWS_WINE_COCOON_RANGE)
						self thread widows_wine_cocoon_zombie (player);
					
					else
						self thread widows_wine_slow_zombie (player);
				}
			
				else
					self thread widows_wine_slow_zombie (player);
			}
				
			else if (IsDefined (sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE")
			{
				if (RandomIntRange (1, 101) < WIDOWS_WINE_COCOON_MELEE)
					self thread widows_wine_cocoon_zombie (player);
			}
		}
	}
	
	return false;
}

//AI Death Callback
function callback_ai_death (attacker)
{
	//SELF == AI
	//ATTACKER == PLAYER
	
	if (!IsDefined (self) || !IsDefined (attacker))
		return false;
		
	self ASMSetAnimationRate (1.0);
	
	if (IsDefined (attacker.west_hasperk_fighters_fizz) && attacker.west_hasperk_fighters_fizz == 1)
		attacker notify ("ffyl_killed_zombie");
	
	if ((IsDefined (attacker.west_hasperk_space_cadet) && attacker.west_hasperk_space_cadet == 1) &&
		(IsDefined (attacker.space_cadet_still_need_kills) && attacker.space_cadet_still_need_kills == 1))
		attacker notify ("space_cadet_ai_killed");
		
	if (IsDefined (attacker.west_hasperk_widows_wine) && attacker.west_hasperk_widows_wine == 1)
	{
		if (((IsDefined (self.widows_wine_cocoon) && self.widows_wine_cocoon == 1) ||
			(IsDefined (self.widows_wine_slowed) && self.widows_wine_slowed == 1)) &&
			(!IsDefined (self.b_widows_wine_no_powerup) || self.b_widows_wine_no_powerup == 0))
		{
			if (RandomInt (100) < WIDOWS_WINE_POWERUP_CHANCE)
			{
				self.no_powerups = 1;
				
				level._powerup_timeout_override = &widows_wine_powerup_timeout;
				level thread zm_powerups::specific_powerup_drop ("ww_grenade", self.origin, undefined, undefined, undefined, self.attacker);
				
				level._powerup_timeout_override = undefined;
			}
		}
	}
	
	return false;
}

//Player Damage Taken Callback
function callback_player_damage_override (inflictor, attacker, damage, flags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	//SELF == PLAYER
	//ATTACKER == AI
	
	if (!IsPlayer (self) || !IsDefined (attacker))
		return damage;		
		
	if ((IsDefined (self.west_hasperk_brawlstar) && self.west_hasperk_brawlstar == 1) && 
		(IsDefined (self.brawlstar_punch_active) && self.brawlstar_punch_active))
		damage = 0;
		
	if ((IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1) && 
		(IsDefined (self.dying_wish_active) && self.dying_wish_active))
		damage = 0;
		
	if ((IsDefined (self.west_hasperk_icu) && self.west_hasperk_icu == 1) && 
		(IsDefined (self.icu_invincible) && self.icu_invincible == 1))
		damage = 0;
		
	if (IsDefined (weapon) && (IsDefined (level.w_widows_wine_wpn_grenade) && weapon == level.w_widows_wine_wpn_grenade))
		damage = 0;
		
	if ((IsDefined (self.west_hasperk_side_step) && self.west_hasperk_side_step == 1) && self != attacker)
		if (!IsDefined (sMeansOfDeath) || sMeansOfDeath != "MOD_FALLING")
			if (RandomIntRange (1, 101) <= SIDE_STEP_DODGE_CHANCE)
				damage = 0;
	
	if (IsDefined (attacker.slurpentine_is_poisoned) && attacker.slurpentine_is_poisoned == 1)
		damage *= SLURPENTINE_POISON_DAMAGE_RESIST;
	
	if (IsDefined (sMeansOfDeath))
	{
		if ((IsDefined (self.west_hasperk_phd_flopper) && self.west_hasperk_phd_flopper == 1) ||
			(IsDefined (self.west_hasperk_phd_slider) && self.west_hasperk_phd_slider == 1))
		{
			if (self == attacker)
			{
				if (sMeansOfDeath == "MOD_EXPLOSIVE" ||
					sMeansOfDeath == "MOD_EXPLOSIVE_SPLASH" ||
					sMeansOfDeath == "MOD_FALLING" ||
					sMeansOfDeath == "MOD_GRENADE" ||
					sMeansOfDeath == "MOD_GRENADE_SPLASH" ||
					sMeansOfDeath == "MOD_PROJECTILE" ||
					sMeansOfDeath == "MOD_PROJECTILE_SPLASH" ||
					sMeansOfDeath == "MOD_SUICIDE")
					damage = 0;
			}
		}
		
		if (IsDefined (self.west_hasperk_bull_ice_blast) && self.west_hasperk_bull_ice_blast == 1)
			if (sMeansOfDeath == "MOD_FALLING")
				damage = 0;
				
		if (IsDefined (self.west_hasperk_brimstone) && self.west_hasperk_brimstone == 1)
			if (sMeansOfDeath == "MOD_BURNED")
				damage = 0;
	
		if (sMeansOfDeath == "MOD_MELEE")
		{
			if ((IsDefined (self.west_hasperk_pickpocket) && self.west_hasperk_pickpocket == 1) && self != attacker)
			{
				pick_reward = RandomIntRange (1,(PICKPOCKET_CHOOSE_AMMO_RANGE + PICKPOCKET_CHOOSE_POINTS_RANGE + PICKPOCKET_CHOOSE_POWERUPS_RANGE) + 1);
			
				if (pick_reward > (PICKPOCKET_CHOOSE_POWERUPS_RANGE + PICKPOCKET_CHOOSE_POINTS_RANGE))
					self thread pickpocket_give_ammo();
			
				else if (pick_reward <= (PICKPOCKET_CHOOSE_POWERUPS_RANGE + PICKPOCKET_CHOOSE_POINTS_RANGE) && pick_reward > PICKPOCKET_CHOOSE_POWERUPS_RANGE)
					self thread pickpocket_give_points();
			
				else if (pick_reward <= PICKPOCKET_CHOOSE_POWERUPS_RANGE)
					self thread pickpocket_give_powerup (attacker);
			}
			
			if ((IsDefined (self.west_hasperk_prickling) && self.west_hasperk_prickling == 1) && self != attacker)
			{
				if (!IsDefined (attacker.ai_too_op_for_prickling_prosecco) || attacker.ai_too_op_for_prickling_prosecco == 0) //If AI is NOT protected from Prickling Prosecco
				{
					AIdamage = (attacker.maxhealth * (PRICKLING_PROSECCO_DAMAGE_PERCENT / 100)) + 1;
					
					if (!IsInt (AIdamage))
						AIdamage = Int (AIdamage);
	
					if ((attacker.health <= AIdamage) || (level.zombie_vars[self.team]["zombie_insta_kill"] == 1))
						attacker DoDamage (AIdamage, attacker.origin, self, self, 0, "MOD_UNKNOWN");
			
					else
					{
						attacker.health -= AIdamage;
						
						if (IsDefined (self.west_hasperk_blood_wolf) && self.west_hasperk_blood_wolf == 1)
							self notify ("blood_wolf_damage", AIdamage);
							
						if ((IsDefined (self.west_hasperk_elemental_pop) && self.west_hasperk_elemental_pop == 1) &&
							(IsDefined (self.elemental_pop_on_cooldown) && self.elemental_pop_on_cooldown == 0))
							if (!IsDefined (attacker.ai_too_op_for_elemental_pop) || attacker.ai_too_op_for_elemental_pop == 0) //If AI is NOT protected from Elemental Pop
								self thread elemental_pop_think (attacker, 0, self GetCurrentWeapon(), "MOD_UNKNOWN");
							
						self thread common_give_points (10);
					}
				}
			}
			
			if ((IsDefined (self.west_hasperk_slurpentine) && self.west_hasperk_slurpentine == 1) && self != attacker)
			{
				//AI is NOT protected from Slurpentine
				if (!IsDefined (attacker.ai_too_op_for_slurpentine) || attacker.ai_too_op_for_slurpentine == 0)
				{
					attacker.slurpentine_is_poisoned = 1;
					
					attacker thread slurpentine_poison (self, 0);
				}
				
				if (self IsSprinting ())
					damage *= SLURPENTINE_SPRINT_DAMAGE_RESIST;
					
				self.slurpentine_boost_time = SLURPENTINE_SPRINT_BOOST_DURATION;
			}
			
			if ((IsDefined (self.west_hasperk_widows_wine) && self.west_hasperk_widows_wine == 1) && self != attacker)
			{
				if (self.current_lethal_grenade == level.w_widows_wine_wpn_grenade && 
					self GetWeaponAmmoClip (self.current_lethal_grenade) >= 1 && 
					damage > 0)
					self thread widows_wine_contact_explosion ();
			}
			
			if ((IsDefined (self.west_hasperk_glitching_gin) && self.west_hasperk_glitching_gin == 1) && self != attacker)
			{
				if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
				{
					if (self.current_tactical_grenade == level.w_glitching_gin_grenade && 
						self GetWeaponAmmoClip (self.current_tactical_grenade) > GLITCHING_GIN_CONTACT_EXPLOSION_COUNT && 
						self.health < self.maxHealth &&
						damage > 0)
						self thread glitching_gin_contact_explosion ();
				}
				
				else
				{				
					if (self.current_lethal_grenade == level.w_glitching_gin_grenade && 
						self GetWeaponAmmoClip (self.current_lethal_grenade) > GLITCHING_GIN_CONTACT_EXPLOSION_COUNT && 
						self.health < self.maxHealth &&
						damage > 0)
						self thread glitching_gin_contact_explosion ();
				}
			}
		}
	}
	
	if (damage > 0)
	{
		if ((IsDefined (self.west_hasperk_stone_cold) && self.west_hasperk_stone_cold == 1) &&
			(IsDefined (self.stone_cold_armor) && self.stone_cold_armor > 0))
		{
			self.stone_cold_armor -= damage;
			
			if (self.stone_cold_armor < 0)
				self.stone_cold_armor = 0;
				
			damage = 0;
		}
		
		if ((IsDefined (self.west_hasperk_winters_wail) && self.west_hasperk_winters_wail == 1) &&
			(IsDefined (self.winters_wail_charges) && self.winters_wail_charges > 0) && 
			(self.health < self.maxhealth) && damage > 0 && self != attacker)
			self thread winters_wail_blast();
	
		if (damage >= self.health)
		{
			if ((IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1) && 
				IsDefined (self.dying_wish_active) && self.dying_wish_active == 0 &&
				IsDefined (self.dying_wish_on_cooldown) && self.dying_wish_on_cooldown == 0)
			{
				self.dying_wish_active = 1;
				self.dying_wish_on_cooldown = 0;
				
				self thread dying_wish_startup();
				
				return 0;
			}
			
			if (IsDefined (self.west_hasperk_slip_away) && self.west_hasperk_slip_away == 1)
			{
				self thread slip_away_teleport_player();
				
				return 0;
			}
		}
		
		//Space Cadet Notify
		if (damage > 0)
			self notify ("space_cadet_ai_damage_taken");
	}
	
	if (!IsInt (damage))
		damage = Int (damage);
	
	return damage;
}

function callback_player_laststand ()
{	
	//SELF = PLAYER
	
	self endon ("bled_out");
	
	if (IsDefined (self.west_hasperk_fighters_fizz) && self.west_hasperk_fighters_fizz == 1)
		self thread fighters_fizz_laststand();
	
	if (IsDefined (self.west_hasperk_electric_cherry) && self.west_hasperk_electric_cherry == 1)
		self thread electric_cherry_laststand();
		
	if (IsDefined (self.west_hasperk_tombstone) && self.west_hasperk_tombstone == 1)
		self thread tombstone_laststand();
	
	self waittill ("player_revived", reviver);
	
	if ((IsDefined (self.west_hasperk_time_out) && self.west_hasperk_time_out == 1) ||
		(IsDefined (reviver.west_hasperk_time_out) && reviver.west_hasperk_time_out == 1))
		self thread time_out_laststand();
}

function callback_zombie_death_response()
{
	//SELF == AI

	if (IsDefined (self.tesla_death) && self.tesla_death)
		return true;
	
	return false;
}

function common_give_ammo (weapon, ammo_to_give, fill_clip)
{
	//SELF == PLAYER
	
	if (!IsDefined (weapon) || !IsDefined (ammo_to_give) || ammo_to_give <= 0)
		return;
		
	if (!IsDefined (fill_clip))
		fill_clip = true;
		
	//Is Clip defined?
	if ((IsDefined (weapon.clipsize) && weapon.clipsize > 0) && fill_clip == true)
	{
		now_clip = self GetWeaponAmmoClip (weapon);
	
		//Check for dual wield weapon
		if (IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone && IsDefined (weapon.dualwieldweapon.clipsize))
			now_clipdw = self GetWeaponAmmoClip (weapon.dualwieldweapon);
		
		//Check if weapon Clip is full
		if (weapon.clipsize - now_clip > 0)
		{
			//Set Clip to full
			if (now_clip + ammo_to_give >= weapon.clipsize)
			{
				self SetWeaponAmmoClip (weapon, weapon.clipsize);
				
				ammo_to_give = now_clip + ammo_to_give - weapon.clipsize;
			}
			
			//Give ammo
			else
			{
				self SetWeaponAmmoClip (weapon, now_clip + ammo_to_give);
				
				ammo_to_give = 0;
			}
		}
		
		//If filling left weapon, right weapon bugs and goes to max. Set right back to what it had beforehand
		if (IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone && IsDefined (weapon.dualwieldweapon.clipsize))
			if (self GetWeaponAmmoClip (weapon.dualwieldweapon) != now_clipdw)
				self SetWeaponAmmoClip (weapon.dualwieldweapon, now_clipdw);
	}
	
	//Is Stock defined?
	if ((IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0) && ammo_to_give > 0)
	{
		now_stock = self GetWeaponAmmoStock (weapon);
		
		//Weapon Stock is not full
		if (weapon.maxAmmo - now_stock > 0)
		{
			//Set Stock to full
			if (now_stock + ammo_to_give >= weapon.maxAmmo)
			{
				self SetWeaponAmmoStock (weapon, weapon.maxAmmo);
				
				ammo_to_give = now_stock + ammo_to_give - weapon.maxAmmo;
			}
			
			//Give ammo
			else
			{
				self SetWeaponAmmoStock (weapon, now_stock + ammo_to_give);
				
				ammo_to_give = 0;
			}
		}
	}
	
	//Check for Bandolier Stock Availability
	if ((IsDefined (self.west_hasperk_bandolier_bandit) && self.west_hasperk_bandolier_bandit == 1) &&
		(IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]) && self.bandolier_bandit_ammo_watch [weapon.name] >= 0) &&
		ammo_to_give > 0)
	{
		bandolier_max = bandolier_bandit_get_stocksize (weapon);
			
		//Bandolier Stock is not full
		if (bandolier_max - self.bandolier_bandit_ammo_watch [weapon.name] > 0)
		{
			//Set Bandolier Stock to full
			if (self.bandolier_bandit_ammo_watch [weapon.name] + ammo_to_give >= bandolier_max)
			{
				self.bandolier_bandit_ammo_watch [weapon.name] = bandolier_max;
				
				ammo_to_give = self.bandolier_bandit_ammo_watch [weapon.name] + ammo_to_give - bandolier_max;
			}
			
			//Give ammo
			else
			{
				self.bandolier_bandit_ammo_watch [weapon.name] += ammo_to_give;
				
				ammo_to_give = 0;
			}
		}
	}
}

function common_give_points (points)
{
	//SELF == PLAYER
	
	//Take Double Points into account
	self zm_score::add_to_player_score (level.zombie_vars [self.team] ["zombie_point_scalar"] * points);
}

function common_speed_function ()
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	
	icu_used = 0;
	masochist_used = 0;
	slurpentine_used = 0;
	spectral_shake_used = 0;
	
	for (;;)
	{
		while ((IsDefined (self.west_hasperk_icu) && self.west_hasperk_icu == 1) || 
				(IsDefined (self.west_hasperk_masochist) && self.west_hasperk_masochist == 1) ||
				(IsDefined (self.west_hasperk_slurpentine) && self.west_hasperk_slurpentine == 1) ||
				(IsDefined (self.west_hasperk_spectral_shake) && self.west_hasperk_spectral_shake == 1))
		{
			while ((IsDefined (self.icu_should_boost) && self.icu_should_boost == 1) ||
					(IsDefined (self.masochist_should_boost) && self.masochist_should_boost == 1) ||
					(IsDefined (self.slurpentine_should_boost) && self.slurpentine_should_boost == 1) ||
					(IsDefined (self.spectral_shake_should_boost) && self.spectral_shake_should_boost == 1))
			{
				icu_used = 0;
				masochist_used = 0;
				slurpentine_used = 0;
				spectral_shake_used = 0;
				
				speed_scale = self GetMoveSpeedScale();
					
				if (IsDefined (self.icu_should_boost) && self.icu_should_boost == 1)
				{
					speed_scale += ICU_SPEED_BOOST;
					icu_used = 1;
				}
				
				if (IsDefined (self.masochist_should_boost) && self.masochist_should_boost == 1)
				{
					masochist_calc = MASOCHIST_SPEED_BUFF_FORMULA;
					masochist_boost_100 = zm_utility::round_up_score (masochist_calc, 1);
					masochist_boost = masochist_boost_100 / 100;
					
					speed_scale += masochist_boost;
					masochist_used = 1;
				}
				
				if (IsDefined (self.slurpentine_should_boost) && self.slurpentine_should_boost == 1)
				{
					speed_scale += SLURPENTINE_SPRINT_SPEED_INCREASE;
					slurpentine_used = 1;
				}
				
				if (IsDefined (self.spectral_shake_should_boost) && self.spectral_shake_should_boost == 1)
				{
					speed_scale += SPECTRAL_SHAKE_SPEED_BOOST;
					spectral_shake_used = 1;
				}
				
				self SetMoveSpeedScale (speed_scale);
				
				//self IPrintLnBold (self GetMoveSpeedScale());
				
				WAIT_SERVER_FRAME;
					
				speed_scale = self GetMoveSpeedScale();
				
				if (icu_used == 1)
					speed_scale -= ICU_SPEED_BOOST;
				
				if (masochist_used == 1)
					speed_scale -= masochist_boost;
				
				if (slurpentine_used == 1)
					speed_scale -= SLURPENTINE_SPRINT_SPEED_INCREASE;
				
				if (spectral_shake_used == 1)
					speed_scale -= SPECTRAL_SHAKE_SPEED_BOOST;
				
				self SetMoveSpeedScale (speed_scale);
			}
			
			icu_used = 0;
			masochist_used = 0;
			slurpentine_used = 0;
			spectral_shake_used = 0;
			
			if (IsDefined (level.west_player_movement_multiplier) && level.west_player_movement_multiplier >= 0)
			{
				if (self GetMoveSpeedScale() != level.west_player_movement_multiplier)
					self SetMoveSpeedScale (level.west_player_movement_multiplier);
			}
			
			else
			{
				if (self GetMoveSpeedScale() != 1)
					self SetMoveSpeedScale (1);
			}
			
			WAIT_SERVER_FRAME;
		}
		
		WAIT_SERVER_FRAME;
	}
}

function common_slide_boost ()
{
	//SELF == PLAYER
	
	self endon ("disconnect");

	for (;;)
	{
		if (self IsOnSlide())
		{
			while (self IsOnSlide())
			{
				slide_boost = 0;
			
				if (IsDefined (self.west_hasperk_banana_colada) && self.west_hasperk_banana_colada == 1)
					slide_boost += BANANA_COLADA_SLIDE_BOOST;
				
				if (IsDefined (self.west_hasperk_phd_slider) && self.west_hasperk_phd_slider == 1)
					slide_boost += PHD_SLIDER_SLIDE_BOOST;
				
				if (slide_boost > 0)
				{
					angles = self GetPlayerAngles();
					angles_forward = AnglesToForward (angles);
					push = VectorScale (angles_forward, slide_boost);
					
					self SetVelocity (push);
				}
				
				WAIT_SERVER_FRAME;
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function common_multi_jump()
{
	//SELF == PLAYER

	self endon ("disconnect");
	
	astro_jump_used = 0;
	bull_ice_blast_jump_used = 0;
	
	off_ground_threshold = .35;
	time_in_air = 0;

	for (;;)
	{
		if (!self IsOnGround())
		{
			while (!self IsOnGround())
			{
				if (self JumpButtonPressed() && time_in_air >= off_ground_threshold &&
					(!IsDefined (self.bull_ice_blast_is_slamming) || self.bull_ice_blast_is_slamming == 0))
				{
					if ((IsDefined (self.west_hasperk_astro) && self.west_hasperk_astro == 1) && astro_jump_used == 0)
					{
						astro_jump_used = 1;
						time_in_air = 0;
						self.west_perks_double_jumped = 1;
						off_ground_threshold *= 2;
						
						self SetVelocity (self GetVelocity() + (0, 0, ASTRO_ALE_DOUBLE_JUMP_ADD_VELOCITY));
					}
					
					else if ((IsDefined (self.west_hasperk_bull_ice_blast) && self.west_hasperk_bull_ice_blast == 1) && bull_ice_blast_jump_used == 0)
					{
						bull_ice_blast_jump_used = 1;
						time_in_air = 0;
						self.west_perks_double_jumped = 1;
						off_ground_threshold *= 2;
						
						self SetVelocity (self GetVelocity() + (0, 0, BULL_ICE_BLAST_DOUBLE_JUMP_ADD_VELOCITY));
					}
				}
				
				WAIT_SERVER_FRAME;
			
				time_in_air += 0.05;
			}
			
			astro_jump_used = 0;
			bull_ice_blast_jump_used = 0;
			self.west_perks_double_jumped = 0;
			off_ground_threshold = .35;
			
			time_in_air = 0;
		}
			
		WAIT_SERVER_FRAME;
	}
}

function common_melee_handler ()
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	
	for (;;)
	{
		self waittill ("west_perks_melee_used", zombie);
		
		melee_perks = array::randomize (level.west_melee_perks);
		
		ability_used = 0;
		
		for (i = 0; i < melee_perks.size; i++)
		{
			if (melee_perks [i] == ATOMIC_LIQUEUR_ALIAS)
			{
				if ((IsDefined (self.west_hasperk_atomic_liqueur) && self.west_hasperk_atomic_liqueur == 1) &&
					(IsDefined (self.atomic_liqueur_cooldown) && self.atomic_liqueur_cooldown == 0))
				{
					self thread atomic_liqueur_nuke();
					
					break;
				}
			}
			
			if (melee_perks [i] == CRYO_SLIDE_ALIAS)
			{
				if ((IsDefined (self.west_hasperk_cryo_slide) && self.west_hasperk_cryo_slide == 1) &&
					(IsDefined (self.cryo_slide_cooldown) && self.cryo_slide_cooldown == 0))
				{
					self thread cryo_slide_freeze();
					
					break;
				}
			}
			
			if (melee_perks [i] == MUSCLE_MILK_ALIAS)
			{
				if ((IsDefined (self.west_hasperk_muscle_milk) && self.west_hasperk_muscle_milk == 1) &&
					(IsDefined (self.muscle_milk_cooldown) && self.muscle_milk_cooldown == 0))
				{
					self thread muscle_milk_lightning (zombie);
					
					break;
				}
			}
		}
	}
}

function handle_cooldown_bars ()
{
	//SELF == PLAYER

	self endon ("disconnect");

	for (;;)
	{
		self waittill ("cooldown_bar_update");
		
		i = 1;
		
		if (IsDefined (self.west_hasperk_atomic_liqueur) && self.west_hasperk_atomic_liqueur == 1)
		{
			if (IsDefined (self.atomic_bar))
				self.atomic_bar Destroy();
			
			if (IsDefined (self.atomic_icon))
				self.atomic_icon Destroy();
				
			if (IsDefined (self.atomic_liqueur_cooldown) && self.atomic_liqueur_cooldown == 1)
			{
				self.atomic_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.7, .7, .7));
				self.atomic_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, ATOMIC_LIQUEUR_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
		
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_blaze_phase) && self.west_hasperk_blaze_phase == 1)
		{
			if (IsDefined (self.blaze_phase_bar))
				self.blaze_phase_bar Destroy();
			
			if (IsDefined (self.blaze_phase_icon))
				self.blaze_phase_icon Destroy();
				
			if ((IsDefined (self.blaze_phase_charging) && self.blaze_phase_charging == 1) ||
				(IsDefined (self.blaze_phase_on_cooldown) && self.blaze_phase_on_cooldown == 1))
			{
				self.blaze_phase_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1, 0, 0));
				self.blaze_phase_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, BLAZE_PHASE_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
		
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_blood_wolf) && self.west_hasperk_blood_wolf == 1)
		{
			if (IsDefined (self.blood_wolf_bar))
				self.blood_wolf_bar Destroy();
			
			if (IsDefined (self.blood_wolf_icon))
				self.blood_wolf_icon Destroy();
				
			if ((IsDefined (self.blood_wolf_active) && self.blood_wolf_active == 1) ||
				(IsDefined (self.blood_wolf_on_cooldown) && self.blood_wolf_on_cooldown == 1))
			{
				self.blood_wolf_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1, .5, .31));
				self.blood_wolf_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, BLOOD_WOLF_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
		
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_brawlstar) && self.west_hasperk_brawlstar == 1)
		{
			if (IsDefined (self.brawlstar_punch_bar))
				self.brawlstar_punch_bar Destroy();
			
			if (IsDefined (self.brawlstar_punch_icon))
				self.brawlstar_punch_icon Destroy();
					
			if ((IsDefined (self.brawlstar_punch_active) && self.brawlstar_punch_active) ||
				(IsDefined (self.brawlstar_punch_cooldown) && self.brawlstar_punch_cooldown == 1))
			{
				self.brawlstar_punch_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1, .1, .1));
				self.brawlstar_punch_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, BRAWLSTAR_PUNCH_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_cryo_slide) && self.west_hasperk_cryo_slide == 1)
		{
			if (IsDefined (self.cryo_slide_bar))
				self.cryo_slide_bar Destroy();
			
			if (IsDefined (self.cryo_slide_icon))
				self.cryo_slide_icon Destroy();
				
			if (IsDefined (self.cryo_slide_cooldown) && self.cryo_slide_cooldown == 1)
			{
				self.cryo_slide_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.2, .2, 1));
				self.cryo_slide_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, CRYO_SLIDE_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1)
		{
			if (IsDefined (self.dying_wish_bar))
				self.dying_wish_bar Destroy();
			
			if (IsDefined (self.dying_wish_icon))
				self.dying_wish_icon Destroy();
					
			if ((IsDefined (self.dying_wish_active) && self.dying_wish_active == 1) ||
				(IsDefined (self.dying_wish_on_cooldown) && self.dying_wish_on_cooldown == 1))
			{
				self.dying_wish_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.3, .6, 1));
				self.dying_wish_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, DYING_WISH_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_elemental_pop) && self.west_hasperk_elemental_pop == 1)
		{
			if (IsDefined (self.elemental_pop_bar))
				self.elemental_pop_bar Destroy();
			
			if (IsDefined (self.elemental_pop_icon))
				self.elemental_pop_icon Destroy();
				
			if (IsDefined (self.elemental_pop_on_cooldown) && self.elemental_pop_on_cooldown == 1)
			{
				self.elemental_pop_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1, .6, .85));
				self.elemental_pop_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, ELEMENTAL_POP_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_muscle_milk) && self.west_hasperk_muscle_milk == 1)
		{
			if (IsDefined (self.muscle_milk_bar))
				self.muscle_milk_bar Destroy();
			
			if (IsDefined (self.muscle_milk_icon))
				self.muscle_milk_icon Destroy();
				
			if (IsDefined (self.muscle_milk_cooldown) && self.muscle_milk_cooldown == 1)
			{
				self.muscle_milk_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.4, .4, 1));
				self.muscle_milk_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, MUSCLE_MILK_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_phd_slider) && self.west_hasperk_phd_slider == 1)
		{
			if (IsDefined (self.phd_slider_bar))
				self.phd_slider_bar Destroy();
			
			if (IsDefined (self.phd_slider_icon))
				self.phd_slider_icon Destroy();
					
			if (IsDefined (self.phd_slider_on_cooldown) && self.phd_slider_on_cooldown == 1)
			{
				self.phd_slider_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1,.1,.1));
				self.phd_slider_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, PHD_SLIDER_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_space_cadet) && self.west_hasperk_space_cadet == 1)
		{
			if (IsDefined (self.space_cadet_bar_kills))
				self.space_cadet_bar_kills Destroy();
				
			if (IsDefined (self.space_cadet_bar_time))
				self.space_cadet_bar_time Destroy();
			
			if (IsDefined (self.space_cadet_icon))
				self.space_cadet_icon Destroy();
				
			if ((IsDefined (self.space_cadet_activated) && self.space_cadet_activated == 1) ||
				(IsDefined (self.space_cadet_on_cooldown) && self.space_cadet_on_cooldown == true) ||
				(IsDefined (self.space_cadet_still_need_kills) && self.space_cadet_still_need_kills == 1))
			{
				self.space_cadet_bar_kills = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.5, 0, .5));
				self.space_cadet_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i) + (COOLDOWN_BAR_X_MOVE_OVER / 2), COOLDOWN_ICON_Y_START, 1, SPACE_CADET_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
				
				i++;
				
				self.space_cadet_bar_time = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.5, 0, .5));
			
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_spectral_shake) && self.west_hasperk_spectral_shake == 1)
		{
			if (IsDefined (self.spectral_shake_bar))
				self.spectral_shake_bar Destroy();
			
			if (IsDefined (self.spectral_shake_icon))
				self.spectral_shake_icon Destroy();
					
			if ((IsDefined (self.spectral_shake_active) && self.spectral_shake_active == 1) ||
				(IsDefined (self.spectral_shake_cooldown) && self.spectral_shake_cooldown == 1))
			{
				self.spectral_shake_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.8, .8, .8));
				self.spectral_shake_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, SPECTRAL_SHAKE_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_stone_cold) && self.west_hasperk_stone_cold == 1)
		{
			if (IsDefined (self.stone_cold_bar))
				self.stone_cold_bar Destroy();
			
			if (IsDefined (self.stone_cold_icon))
				self.stone_cold_icon Destroy();
				
			if (IsDefined (self.stone_cold_armor) && self.stone_cold_armor > 0)
			{
				self.stone_cold_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (0, 0, 1));
				self.stone_cold_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, STONE_COLD_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
		
				i++;
			}
		}
		
		if (IsDefined (self.time_out_active) && self.time_out_active == 1)
		{
			if (IsDefined (self.time_out_bar))
				self.time_out_bar Destroy();
			
			if (IsDefined (self.time_out_icon))
				self.time_out_icon Destroy();
					
			self.time_out_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (1, .45, 0));
			self.time_out_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, TIME_OUT_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
			i++;
		}
		
		if (IsDefined (self.west_hasperk_windrunner) && self.west_hasperk_windrunner == 1)
		{
			if (IsDefined (self.windrunner_bar))
				self.windrunner_bar Destroy();
			
			if (IsDefined (self.windrunner_icon))
				self.windrunner_icon Destroy();
					
			if (IsDefined (self.windrunner_on_cooldown) && self.windrunner_on_cooldown == 1)
			{
				self.windrunner_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.9, 1, .2));
				self.windrunner_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, WINDRUNNER_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_winters_wail) && self.west_hasperk_winters_wail == 1)
		{
			if (IsDefined (self.winters_wail_bar))
				self.winters_wail_bar Destroy();
			
			if (IsDefined (self.winters_wail_icon))
				self.winters_wail_icon Destroy();
					
			if (IsDefined (self.winters_wail_charges) && self.winters_wail_charges < WINTERS_WAIL_MAX_CHARGES)
			{
				self.winters_wail_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.05, 1, .8));
				self.winters_wail_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, WINTERS_WAIL_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
				i++;
			}
		}
		
		if (IsDefined (self.west_hasperk_zombshell) && self.west_hasperk_zombshell == 1)
		{
			if (IsDefined (self.zombshell_bar))
				self.zombshell_bar Destroy();
			
			if (IsDefined (self.zombshell_icon))
				self.zombshell_icon Destroy();
					
			if ((IsDefined (self.zombshell_field_active) && self.zombshell_field_active == 1) ||
				(IsDefined (self.zombshell_on_cooldown) && self.zombshell_on_cooldown == 1))
			{
				self.zombshell_bar = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_BAR_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_BAR_Y_START, 1, "white", COOLDOWN_BAR_WIDTH, 1, (.5, 0, .8));
				self.zombshell_icon = self reap_create_hud_icon (COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ALIGN_X, COOLDOWN_ALIGN_Y, COOLDOWN_ICON_X_START + (COOLDOWN_BAR_X_MOVE_OVER * i), COOLDOWN_ICON_Y_START, 1, ZOMBSHELL_ICON, COOLDOWN_ICON_X_Y, COOLDOWN_ICON_X_Y, (1, 1, 1));
			
				i++;
			}
		}
	}
}

//W to Reaper
function reap_create_hud_icon (aligX, aligY, horzAlin, vertAlin, x, y, alp, icon, icon_x, icon_y, color)
{
	hud = undefined;
	
	if (self == level)
		hud = newHudElem();
		
	else
		hud = NewClientHudElem (self);
		
	hud.alignX = aligX; 
	hud.alignY = aligY;
	hud.horzAlign = horzAlin; 
	hud.vertAlign = vertAlin;
	hud.x = x;
	hud.y = y;
	hud.alpha = alp;
	hud.color = color;
	hud SetShader (icon, icon_x, icon_y);
	
	return hud;
}

function reap_create_hud_text (aligX, aligY, horzAlin, vertAlin, x, y, alp, color, text, size)
{
	hud = undefined;
	
	if (self == level)
		hud = newHudElem();
		
	else
		hud = NewClientHudElem (self);
		
	hud.alignX = aligX; 
	hud.alignY = aligY;
	hud.horzAlign = horzAlin; 
	hud.vertAlign = vertAlin;
	hud.x = x;
	hud.y = y;
	hud.alpha = alp;
	hud.color = color;
	hud.fontScale = size;
	hud setText (text);
	
	return hud;
}

function bullet_impact_get_tag_location (sHitLoc)
{
	switch (sHitLoc)
	{
		case "helmet":
		case "head":
			return "j_head";
		case "torso_upper":
			return "j_spine4";
		case "torso_mid":
			return "j_spineupper";
		case "torso_lower":
			return "j_spinelower";
		case "left_arm_upper":
			return "j_shoulder_le";
		case "right_arm_upper":
			return "j_shoulder_ri";
		case "left_arm_lower":
			return "j_elbow_le";
		case "right_arm_lower":
			return "j_elbow_ri";
		case "left_hand":
			return "j_wrist_le";
		case "right_hand":
			return "j_wrist_ri";
		case "left_leg_upper":
			return "j_hiptwist_le";
		case "right_leg_upper":
			return "j_hiptwist_ri";
		case "left_leg_lower":
			return "j_knee_le";
		case "right_leg_lower":
			return "j_knee_ri";
		case "left_foot":
			return "j_ankle_le";
		case "right_foot":
			return "j_ankle_ri";
		default:
			return "j_spine4";
	}
	
	return undefined;
}

function player_can_see_me (player)
{
	//SELF == AI
	
    v_player_angles = player GetPlayerAngles();
    v_player_forward = AnglesToForward (v_player_angles);
    v_player_to_self = self.origin - player GetOrigin();
    v_player_to_self = VectorNormalize (v_player_to_self);
    n_dot = VectorDot (v_player_forward, v_player_to_self);
	
	//FOV Angle Check
    if (n_dot < .8) //.766 <-->.85
        return false;
		
	return true;
}

function common_grenade_thrown_watch ()
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("grenade_fire", grenade, weapon);
		
		if (IsDefined (grenade.phd_flopper_split) && grenade.phd_flopper_split == 1)
			continue;
			
		if (IsDefined (grenade.power_aid_punch_split) && grenade.power_aid_punch_split == 1)
			continue;
			
		if (IsDefined (level.w_glitching_gin_grenade) && weapon == level.w_glitching_gin_grenade)
			continue;
			
		if (IsDefined (self.west_hasperk_phd_flopper) && self.west_hasperk_phd_flopper == 1)
		{
			//Only split Lethal Grenade
			if (weapon == self zm_utility::get_player_lethal_grenade())
			{	
				grenade.phd_flopper_split = 1;
				
				self thread phd_flopper_grenade_split (grenade, weapon);
			}
		}
		
		if (IsDefined (self.west_hasperk_power_aid_punch) && self.west_hasperk_power_aid_punch == 1)
		{
			//Only split Lethal Grenade
			if (weapon == self zm_utility::get_player_lethal_grenade())
			{	
				grenade.power_aid_punch_split = 1;
				
				self thread power_aid_punch_grenade_split (grenade, weapon);
			}
		}
	}
}

function common_track_melee_weapon()
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.west_melee_owned_bowie = 0;
	
	for (;;)
	{
		wait .25;
		
		//Taking knife while Brawlstar is active will glitch out Brawlstar
		if (IsDefined (self.west_hasperk_brawlstar) && self.west_hasperk_brawlstar == 1)
		{
			if (IsDefined (self.brawlstar_punch_active) && self.brawlstar_punch_active == true)
				continue;
		}
		
		//Do not try and take knife if player is actively meleeing
		if (self IsMeleeing())
			while (self IsMeleeing())
				WAIT_SERVER_FRAME;
						
		melee_weapon = self zm_utility::get_player_melee_weapon();
		
		if (IsDefined (self.west_hasperk_ethereal) && self.west_hasperk_ethereal == 1)
		{
			if (!IsDefined (melee_weapon))
			{
				self zm_weapons::weapon_give (level.ethereal_razor_knife);
				self zm_utility::set_player_melee_weapon (level.ethereal_razor_knife);
			}
			
			else if (melee_weapon == GetWeapon ("bowie_knife") || melee_weapon == GetWeapon ("sickle_knife"))
				self.west_melee_owned_bowie = 1;
			
			if (IsDefined (melee_weapon) && melee_weapon != level.ethereal_razor_knife)
			{
				self zm_weapons::weapon_take (melee_weapon);
				
				WAIT_SERVER_FRAME;
				
				self zm_weapons::weapon_give (level.ethereal_razor_knife);
				self zm_utility::set_player_melee_weapon (level.ethereal_razor_knife);
			}
		}
		
		else if (IsDefined (self.west_hasperk_widows_wine) && self.west_hasperk_widows_wine == 1)
		{
			if (!IsDefined (melee_weapon))
			{
				if (IsDefined (self.west_melee_owned_bowie) && self.west_melee_owned_bowie == 1)
				{
					self zm_weapons::weapon_give (level.w_widows_wine_wpn_knife_bowie);
					self zm_utility::set_player_melee_weapon (level.w_widows_wine_wpn_knife_bowie);
				}
				
				else
				{
					self zm_weapons::weapon_give (level.w_widows_wine_wpn_knife);
					self zm_utility::set_player_melee_weapon (level.w_widows_wine_wpn_knife);
				}
			}
			
			else if (melee_weapon == GetWeapon ("bowie_knife") || melee_weapon == GetWeapon ("sickle_knife"))
			{
				self.west_melee_owned_bowie = 1;
				
				self zm_weapons::weapon_take (melee_weapon);
				
				WAIT_SERVER_FRAME;
				
				self zm_weapons::weapon_give (level.w_widows_wine_wpn_knife_bowie);
				self zm_utility::set_player_melee_weapon (level.w_widows_wine_wpn_knife_bowie);
			}
			
			else if (melee_weapon != level.w_widows_wine_wpn_knife && melee_weapon != level.w_widows_wine_wpn_knife_bowie)
			{
				self zm_weapons::weapon_take (melee_weapon);
				
				WAIT_SERVER_FRAME;
				
				if (IsDefined (self.west_melee_owned_bowie) && self.west_melee_owned_bowie == 1)
				{
					self zm_weapons::weapon_give (level.w_widows_wine_wpn_knife_bowie);
					self zm_utility::set_player_melee_weapon (level.w_widows_wine_wpn_knife_bowie);
				}
				
				else
				{
					self zm_weapons::weapon_give (level.w_widows_wine_wpn_knife);
					self zm_utility::set_player_melee_weapon (level.w_widows_wine_wpn_knife);
				}
			}
		}
		
		else if ((melee_weapon != GetWeapon ("bowie_knife") && melee_weapon != GetWeapon ("sickle_knife")) &&
				(IsDefined (self.west_melee_owned_bowie) && self.west_melee_owned_bowie == 1))
		{
			self zm_weapons::weapon_take (melee_weapon);
			
			WAIT_SERVER_FRAME;
			
			self zm_weapons::weapon_give (GetWeapon ("bowie_knife"));
			self zm_utility::set_player_melee_weapon (GetWeapon ("bowie_knife"));
		}
	}
}
	
	
// ======================================================================================================
// Ammo Americano
// ======================================================================================================

function ammo_americano_weapon_check()
{
	//SELF == PLAYER
	
	self endon (AMMO_AMERICANO_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	if (!IsPlayer (self))
		return;
		
	for (;;)
	{
		WAIT_SERVER_FRAME;
		
		weapList = self GetWeaponsList (1);
		
		foreach (weapon in weapList)
			if ((IsDefined (weapon.clipsize) && weapon.clipsize > 0) &&
				(IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0) &&
				!zm_utility::is_offhand_weapon (weapon))
				self thread ammo_americano_weapon_reload (weapon);
		
		self util::waittill_any_return ("weapon_give", "weapon_take");
		self notify ("americano_stop_tracking");
	}
}

function ammo_americano_weapon_reload (weapon)
{
	//SELF == PLAYER
	
	self endon (AMMO_AMERICANO_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("americano_stop_tracking");
	
	exclude = false;
	
	if (IsDefined (AMMO_AMERICANO_WEAPON_EXLUSION_LIST) && AMMO_AMERICANO_WEAPON_EXLUSION_LIST.size > 0)
	{
		for (i = 0; i < AMMO_AMERICANO_WEAPON_EXLUSION_LIST.size; i++)
			if (weapon.name == AMMO_AMERICANO_WEAPON_EXLUSION_LIST[i])
				exclude = true;
	}
	
	if (exclude == false)
	{
		full_clip = weapon.clipsize;
		
		if (IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone)
		{
			full_clipdw = weapon.dualwieldweapon.clipsize;
			avg_clipsize = (full_clip + full_clipdw) / 2;
		}
		
		else
			avg_clipsize = full_clip;
			
		if (avg_clipsize >= AMMO_AMERICANO_HIGH_CLIPSIZE_SIZE)
			give_ammo = AMMO_AMERICANO_AMMO_GIVE * AMMO_AMERICANO_HIGH_CLIPSIZE_BONUS;
		
		else
			give_ammo = AMMO_AMERICANO_AMMO_GIVE;	
			
		give_ammo *= AMMO_AMERICANO_GIVE_MULTIPIER;
	
		wait_time = AMMO_AMERICANO_WAIT_FORMULA;
	
		if (wait_time < AMMO_AMERICANO_MIN_WAIT_PER_CYCLE)
			wait_time = AMMO_AMERICANO_MIN_WAIT_PER_CYCLE;
			
		else if (wait_time > AMMO_AMERICANO_MAX_WAIT_PER_CYCLE)
			wait_time = AMMO_AMERICANO_MAX_WAIT_PER_CYCLE;

		while (self HasWeapon (weapon, true))
		{
			wait wait_time;
			
			if ((IsDefined (self.west_hasperk_brawlstar) && self.west_hasperk_brawlstar == 1) &&
				(IsDefined (self.brawlstar_punch_active) && self.brawlstar_punch_active))
				continue;
		
			now_stock = self GetWeaponAmmoStock (weapon);
		
			if (now_stock > 0)
			{
				now_clip = self GetWeaponAmmoClip (weapon);
				
				if (IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone)
				{
					now_clipdw = self GetWeaponAmmoClip (weapon.dualwieldweapon);
					
					if (now_clip < full_clip)
					{
						if ((now_clip + give_ammo) > full_clip)
						{
							clip_difference = full_clip - now_clip;
							
							self SetWeaponAmmoClip(weapon, full_clip);
							self SetWeaponAmmoStock(weapon, (now_stock - clip_difference));
							
							//Electric Cherry Fix, Weapon is reloaded
							if (IsDefined (self.wait_on_reload) && IsInArray (self.wait_on_reload, weapon))
							{
								ArrayRemoveValue (self.wait_on_reload, weapon);
								self notify ("weapon_reload_complete_" + weapon.name);
							}
						}
						
						else
						{
							if ((now_clip + give_ammo) == full_clip)
								self SetWeaponAmmoClip(weapon, full_clip);
				
							else
								self SetWeaponAmmoClip(weapon, (now_clip + give_ammo));
			
							self SetWeaponAmmoStock(weapon, (now_stock - give_ammo));
						}
					}	
					
					now_stock = self GetWeaponAmmoStock (weapon);
					
					if (now_stock > 0)
					{
						if (now_clipdw < full_clipdw)
						{
							if ((now_clipdw + give_ammo) > full_clipdw)
							{
								clip_differencedw = full_clipdw - now_clipdw;
							
								self SetWeaponAmmoClip(weapon, full_clipdw);
								self SetWeaponAmmoStock(weapon, (now_stock - clip_differencedw));
							}
						
							else
							{
								if ((now_clipdw + give_ammo) == full_clipdw)
									self SetWeaponAmmoClip(weapon.dualwieldweapon, full_clipdw);
				
								else
									self SetWeaponAmmoClip(weapon.dualwieldweapon, (now_clipdw + give_ammo));
			
								self SetWeaponAmmoStock(weapon.dualwieldweapon, (now_stock - give_ammo));
							}
						}
					}
					
					else
						self SetWeaponAmmoClip(weapon.dualwieldweapon, now_clipdw);
				}
		
				else if (now_clip < full_clip)
				{
					if ((now_clip + give_ammo) > full_clip)
					{
						clip_difference = full_clip - now_clip;
							
						self SetWeaponAmmoClip(weapon, full_clip);
						self SetWeaponAmmoStock(weapon, (now_stock - clip_difference));
					}
						
					else
					{
						if ((now_clip + give_ammo) == full_clip)
							self SetWeaponAmmoClip(weapon, full_clip);
				
						else
							self SetWeaponAmmoClip(weapon, (now_clip + give_ammo));
			
						self SetWeaponAmmoStock(weapon, (now_stock - give_ammo));
					}
				}
			}
		}
	}
}


// ======================================================================================================
// Atomic Liqueur
// ======================================================================================================

function atomic_liqueur_nuke ()
{
	//SELF == PLAYER
	
	self PlaySoundToPlayer (ATOMIC_LIQUEUR_SOUND_ACTIVATE, self);
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, ATOMIC_LIQUEUR_NUKE_MAX_RANGE);
		
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
		{
			for (i = 0; i < ATOMIC_LIQUEUR_NUKE_KILL_LIMIT; i++)
			{
				//Zombie is undefined
				if (!IsDefined (zoms_in_range[i]))
					continue;
				
				//Zombies is Not AI or Dead
				if (!IsAI (zoms_in_range[i]) || !IsAlive (zoms_in_range[i]))
					continue;
			
				//Too OP for Atomic Liqueur - Boss
				if (IsDefined (zoms_in_range[i].ai_too_op_for_atomic_liqueur) && zoms_in_range[i].ai_too_op_for_atomic_liqueur == 1) //If AI is protected from Atomic Liqueur
					continue;
					
				//Kill the Zombie
				GibServerUtils::Annihilate (zoms_in_range[i]);
				zoms_in_range[i] DoDamage (zoms_in_range[i].health + 666, self.origin, self, self, 0, "MOD_EXPLOSIVE");
			}
		}
	}
	
	self thread atomic_liqueur_cooldown();
}

function atomic_liqueur_cooldown ()
{
	self endon (ATOMIC_LIQUEUR_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.atomic_liqueur_cooldown = 1;

	self notify ("cooldown_bar_update");
	WAIT_SERVER_FRAME;
	
	time = 0;
	
	while (time < ATOMIC_LIQUEUR_NUKE_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / ATOMIC_LIQUEUR_NUKE_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.atomic_bar))
			self.atomic_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}

	self.atomic_liqueur_cooldown = 0;
	
	self notify ("cooldown_bar_update");
	
	self PlaySoundToPlayer (ATOMIC_LIQUEUR_SOUND_READY, self);
}


// ======================================================================================================
// Banana Colada
// ======================================================================================================

function banana_colada_think ()
{
	//SELF == PLAYER

	self endon (BANANA_COLADA_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (self IsOnSlide())
		{
			self PlayLocalSound (BANANA_COLADA_SLIDE_SOUND);
			
			while (self IsOnSlide())
			{			
				PlayFx (BANANA_COLADA_SLIDE_FX, self.origin + (0, 0, 1));
				
				self thread banana_colada_watch_zombie (self.origin);
				
				WAIT_SERVER_FRAME;
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function banana_colada_watch_zombie (player_origin)
{
	//SELF == PLAYER
	
	time = BANANA_COLADA_SLIME_TIME;
	
	while (time > 0)
	{
		zoms = GetAITeamArray (level.zombie_team);
		
		if (IsDefined (zoms) && zoms.size > 0)
		{
			zoms_in_range = util::get_array_of_closest (player_origin, zoms, undefined, undefined, BANANA_COLADA_SLIME_RANGE);
			
			if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
				foreach (zom in zoms_in_range)
					//If AI is NOT protected from Banana Colada
					if (!IsDefined (zom.ai_too_op_for_banana_colada) || zom.ai_too_op_for_banana_colada == 0)
						if ((!IsDefined (zom.sliding_on_goo) || zom.sliding_on_goo == 0) &&
							(IsDefined (zom.animname) && (zom.animname == "zombie" || zom.animname == "napalm_zombie" || zom.animname == "sonic_zombie")))
							self thread banana_colada_slip_zombie (zom);
		}
		
		time -= .05;
		
		WAIT_SERVER_FRAME;
	}
}

function banana_colada_slip_zombie (zom)
{
	//SELF == PLAYER
	
	zom.sliding_on_goo = 1;
	zombie_animname = zom.animname;
	
	anim_choice = RandomInt (2);
	
	if (IsDefined (zom.missingLegs) && IS_TRUE(zom.missingLegs))
	{
		if (anim_choice == 0)
			anim_to_play = BANANA_COLADA_ANIM_CRAWL_SLIP_RECOV;
			
		else
		{
			if (IsDefined (zom.zombie_move_speed) && (zom.zombie_move_speed == "run" || zom.zombie_move_speed == "sprint"))
				anim_to_play = BANANA_COLADA_ANIM_CRAWL_SLIP_FAST;
				
			else
				anim_to_play = BANANA_COLADA_ANIM_CRAWL_SLIP_SLOW;
		}
	}
	
	else
	{	
		if (anim_choice == 0)
			anim_to_play = BANANA_COLADA_ANIM_STAND_SLIP_RECOV;
				
		else
		{
			anim_choice = RandomInt (2);
		
			if (IsDefined (zom.zombie_move_speed) && zom.zombie_move_speed == "sprint")
			{
				if (anim_choice == 0)
					anim_to_play = BANANA_COLADA_ANIM_SPRINT_SLIP_A;
					
				else	
					anim_to_play = BANANA_COLADA_ANIM_SPRINT_SLIP;
			}
			
			else if (IsDefined (zom.zombie_move_speed) && zom.zombie_move_speed == "run" )
			{
				if (anim_choice == 0)
					anim_to_play = BANANA_COLADA_ANIM_RUN_SLIP_A;
					
				else
					anim_to_play = BANANA_COLADA_ANIM_RUN_SLIP;
			}
			
			else
			{
				if (anim_choice == 0)
					anim_to_play = BANANA_COLADA_ANIM_WALK_SLIP_A;
					
				else
					anim_to_play = BANANA_COLADA_ANIM_WALK_SLIP;
			}
		}
		
		end_pos = zom zombie_utility::getAnimEndPos (anim_to_play);
		
		if (IsDefined (end_pos))
		{
			trace_pos = PlayerPhysicsTrace (zom.origin, end_pos);
			
			if (IsDefined (trace_pos))
			{
				fall_down = RandomInt (100);
				
				if (fall_down <= BANANA_COLADA_SLIME_FALL_CHANCE || zom.health <= BANANA_COLADA_SLIME_DAMAGE || end_pos != trace_pos)
					anim_to_play = BANANA_COLADA_ANIM_SLIP_COLLAPSE;
			}
		}
	}
	
	anim_time = GetAnimLength (anim_to_play);
	
	if (IsDefined (anim_time))
	{
		self thread banana_colada_fall_sounds (anim_to_play, anim_time, zom);
		
		zom thread scene::play (anim_to_play, zom);
		
		wait anim_time;
		
		if (IsDefined (zom) && IsAlive (zom))
			zom thread scene::stop (anim_to_play);
	}
	
	if (IsDefined (zom) && IsAlive (zom))
	{
		zom.sliding_on_goo = 0;
		zom.animname = zombie_animname;
	}
}

function banana_colada_fall_sounds (anim_to_play, anim_time, zom)
{
	//SELF == PLAYER
	
	fall_note_times = GetNoteTrackTimes (anim_to_play, BANANA_COLADA_ANIM_SOUND_NOTE);
		
	if (IsDefined (fall_note_times [0]))
		delay = fall_note_times [0] * anim_time;
		
	else
		delay = anim_time / 2;
	
	wait delay;
	
	if (zom.health <= BANANA_COLADA_SLIME_DAMAGE)
	{
		zom StartRagdoll();
		
		wait .1;
		
		zom DoDamage (BANANA_COLADA_SLIME_DAMAGE, zom.origin, self, self, "none");
	}
	
	else 
		zom DoDamage (BANANA_COLADA_SLIME_DAMAGE, zom.origin, self, self, "none");
}


// ======================================================================================================
// Bandolier Bandit
// ======================================================================================================

function bandolier_bandit_logic()
{
	//SELF == PLAYER
	
	self endon (BANDOLIER_BANDIT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.bandolier_bandit_ammo_watch = [];
	
	self thread bandolier_bandit_weapon_purchase_watch();
	self thread bandolier_bandit_weapon_ammo_purchase_watch();
	self thread bandolier_bandit_max_ammo_watch();
	self thread bandolier_bandit_weapon_take_watch();
	
	for (;;)
	{
		weapon = self GetCurrentWeapon();
		
		if (((IsDefined (weapon.clipsize) && weapon.clipsize > 0) || (IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0)) &&
			!zm_utility::is_offhand_weapon (weapon))
		{
			if (!IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]))
				if (!IsDefined (weapon.unlimitedAmmo) || !weapon.unlimitedAmmo)
					self.bandolier_bandit_ammo_watch [weapon.name] = bandolier_bandit_get_stocksize (weapon);
			
			if (IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]))
			{
				if (IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0)
				{
					stock = self GetWeaponAmmoStock (weapon);
					
					if (stock < weapon.maxAmmo)
					{
						add_to_stock = weapon.maxAmmo - stock;
						
						if (self.bandolier_bandit_ammo_watch [weapon.name] < add_to_stock)
							add_to_stock = self.bandolier_bandit_ammo_watch [weapon.name];
							
						self.bandolier_bandit_ammo_watch [weapon.name] -= add_to_stock;
						self SetWeaponAmmoStock (weapon, stock + add_to_stock);
					}
				}
				
				else if (IsDefined (weapon.clipsize) && weapon.clipsize > 0)
				{
					clip = self GetWeaponAmmoClip (weapon);
					
					if (clip < weapon.clipsize)
					{
						add_to_clip = weapon.clipsize - clip;
						
						if (self.bandolier_bandit_ammo_watch [weapon.name] < add_to_clip)
							add_to_clip = self.bandolier_bandit_ammo_watch [weapon.name];
							
						self.bandolier_bandit_ammo_watch [weapon.name] -= add_to_clip;
						self SetWeaponAmmoClip (weapon, clip + add_to_clip);	
					}
				}
				
				if (self.bandolier_bandit_ammo_watch [weapon.name] > 0)
				{
					if (BANDOLIER_BANDIT_DRAW_AMMO_STOCK == 1)
					{
						if (!IsDefined (self.bandolier_bandit_hud))
							self.bandolier_bandit_hud = reap_create_hud_text (BANDOLIER_BANDIT_AMMO_ALIGN_X, BANDOLIER_BANDIT_AMMO_ALIGN_Y, BANDOLIER_BANDIT_AMMO_ALIGN_X, BANDOLIER_BANDIT_AMMO_ALIGN_Y, BANDOLIER_BANDIT_AMMO_X, BANDOLIER_BANDIT_AMMO_Y, .8, (0.05, 1, .8), "+" + self.bandolier_bandit_ammo_watch [weapon.name], 2);
						
						self.bandolier_bandit_hud SetText ("+" + self.bandolier_bandit_ammo_watch [weapon.name]);
					}
				}
				
				else
					if (IsDefined (self.bandolier_bandit_hud))
						self.bandolier_bandit_hud Destroy();
			}
			
			else
				if (IsDefined (self.bandolier_bandit_hud))
					self.bandolier_bandit_hud Destroy();
		}
		
		wait 1;
	}
}

function bandolier_bandit_get_stocksize (weapon)
{
	if (zm_utility::is_offhand_weapon (weapon))
		return 0;

	if (IsDefined (weapon.clipsize) && weapon.clipsize > 0)
	{
		if ((IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone) && 
			(IsDefined (weapon.dualwieldweapon.clipsize) && weapon.dualwieldweapon.clipsize > 0))
		{	
			clip_sum = weapon.clipsize + weapon.dualwieldweapon.clipsize;
			
			return clip_sum * BANDOLIER_BANDIT_AMMO_MULTIPLIER;
		}
	
		return weapon.clipsize * BANDOLIER_BANDIT_AMMO_MULTIPLIER;
	}
	
	else if (IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0)
		return weapon.maxAmmo;

	return 0;
}


function bandolier_bandit_weapon_purchase_watch()
{
	//SELF == PLAYER

	self endon (BANDOLIER_BANDIT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_give", weapon);
		
		WAIT_SERVER_FRAME;
		
		if (IsDefined (self.bandolier_bandit_set_stock))
		{
			self.bandolier_bandit_ammo_watch [weapon.name] = self.bandolier_bandit_set_stock;
			self.bandolier_bandit_set_stock = undefined;
		}
		
		else if (IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]))
			self.bandolier_bandit_ammo_watch [weapon.name] = undefined;			
	}
}

function bandolier_bandit_weapon_ammo_purchase_watch()
{
	//SELF == PLAYER

	self endon (BANDOLIER_BANDIT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_ammo_restocked", weapon);
		
		WAIT_SERVER_FRAME;
		
		if (IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]))
			self.bandolier_bandit_ammo_watch [weapon.name] = undefined;
	}
}

function bandolier_bandit_max_ammo_watch()
{
	//SELF == PLAYER

	self endon (BANDOLIER_BANDIT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("zmb_max_ammo");
		
		WAIT_SERVER_FRAME;
		
		self.bandolier_bandit_ammo_watch = [];
	}
}

function bandolier_bandit_weapon_take_watch()
{
	//SELF == PLAYER

	self endon (BANDOLIER_BANDIT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_take", weapon);
		
		WAIT_SERVER_FRAME;
		
		if (IsDefined (self.bandolier_bandit_ammo_watch [weapon.name]))
			self.bandolier_bandit_ammo_watch [weapon.name] = undefined;
	}
}

// ======================================================================================================
// Blaze Phase
// ======================================================================================================

function blaze_phase_logic ()
{
	//SELF == PLAYER
	
	self endon (BLAZE_PHASE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	charge = 0;
	hit_threshold = 0;
	
	for (;;)
	{
		if (self GetStance() == "crouch" && self IsOnSlide() == false && self.blaze_phase_on_cooldown == 0)
		{
			while (charge < 2)
			{
				wait .1;
			
				if (self GetStance() != "crouch" || self IsOnSlide() == true)
					break;
					
				charge += .1;				
			}
			
			if (charge < 2)
				charge = 0;

			if (charge >= 2 && hit_threshold == 0)
			{
				hit_threshold = 1;
				self.blaze_phase_charging = 1;
				
				self notify ("cooldown_bar_update");
				
				self clientfield::set ("burn", 1);
				self PlayLoopSound ("chr_burn_loop_overlay");
				
				bar_height = (charge / BLAZE_PHASE_MAX_CHARGE) * COOLDOWN_BAR_HEIGHT;
				
				if (bar_height < 1)
					bar_height = 1;
					
				else if (bar_height > COOLDOWN_BAR_HEIGHT)
					bar_height = COOLDOWN_BAR_HEIGHT;
					
				if (!IsInt (bar_height))
					bar_height = Int (bar_height);
					
				if (IsDefined (self.blaze_phase_bar))
					self.blaze_phase_bar ScaleOverTime (.05, COOLDOWN_BAR_WIDTH, bar_height);
			}
			
			if (charge >= BLAZE_PHASE_MAX_CHARGE)
				charge = BLAZE_PHASE_MAX_CHARGE;

			else
				charge += .1;
			
			bar_height = (charge / BLAZE_PHASE_MAX_CHARGE) * COOLDOWN_BAR_HEIGHT;
			
			if (bar_height < 1)
				bar_height = 1;
				
			else if (bar_height > COOLDOWN_BAR_HEIGHT)
				bar_height = COOLDOWN_BAR_HEIGHT;
				
			if (!IsInt (bar_height))
				bar_height = Int (bar_height);
				
			if (IsDefined (self.blaze_phase_bar))
				self.blaze_phase_bar ScaleOverTime (.1, COOLDOWN_BAR_WIDTH, bar_height);
		}
		
		if (charge > 0 && self StanceButtonPressed())
		{
			charge = 0;
			hit_threshold = 0;
			
			self clientfield::set ("burn", 0);
			self StopLoopSound (1);
			
			self.blaze_phase_charging = 0;
				
			self notify ("cooldown_bar_update");
		}
		
		if (charge >= 2 && self GetStance() == "stand")
		{
			self.blaze_phase_charging = 0;
			self.blaze_phase_on_cooldown = 1;
		
			self thread blaze_phase_fling (charge);
			
			charge = 0;
			hit_threshold = 0;
		}
		
		wait .1;
	}
}

function blaze_phase_fling (charge)
{
	//SELF == PLAYER
	
	self endon (BLAZE_PHASE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	player_angles = self GetPlayerAngles();
	angles_forward = AnglesToForward (player_angles);
	angles = (0,(player_angles[1]),0);
	push = VectorScale (angles_forward, BLAZE_PHASE_BOOST);
	point = self.origin - (0, 0, 100);
	
	PlayFx (BLAZE_PHASE_FX_EXPLOSION, self.origin, self.angles);
	
	while (Distance (point, self.origin) > 30 && charge > 0)
	{
		point = self.origin;
		
		if (charge - .1 < 0)
			charge = 0;
			
		else
			charge -= .1;
			
		bar_height = (charge / BLAZE_PHASE_MAX_CHARGE) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.blaze_phase_bar))
			self.blaze_phase_bar ScaleOverTime (.05, COOLDOWN_BAR_WIDTH, bar_height);
		
		self SetVelocity (push);
		
		zoms = GetAITeamArray (level.zombie_team);
		
		if (IsDefined (zoms) && zoms.size > 0)
		{
			zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, BLAZE_PHASE_RANGE);
			
			if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
			{
				foreach (zom in zoms_in_range)
				{
					//If AI is NOT protected from Blaze Phase
					if (!IsDefined (zom.ai_too_op_for_blaze_phase) || zom.ai_too_op_for_blaze_phase == 0)
					{
						zom zombie_utility::gib_random_parts();		
						zom zombie_utility::gib_random_parts();		
						GibServerUtils::Annihilate (zom);								
						zom zm_spawner::zombie_explodes_intopieces (false);
						
						if (IsDefined (zom GetTagOrigin ("j_spineupper")))
							PlayFxOnTag (PHD_SLIDER_FX_FIRE, zom, "j_spineupper");
						
						zom DoDamage (zom.maxhealth + 666, zom.origin, self, self, "none", "MOD_BURNED");
					}
				}
			}
		}
		
		WAIT_SERVER_FRAME; 
	}
	
	PlayFx (BLAZE_PHASE_FX_EXPLOSION, self.origin, self.angles);
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, BLAZE_PHASE_RANGE);
		
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
		{
			foreach (zom in zoms_in_range)
			{
				//If AI is NOT protected from Blaze Phase
				if (!IsDefined (zom.ai_too_op_for_blaze_phase) || zom.ai_too_op_for_blaze_phase == 0)
				{
					zom zombie_utility::gib_random_parts();		
					zom zombie_utility::gib_random_parts();		
					GibServerUtils::Annihilate (zom);								
					zom zm_spawner::zombie_explodes_intopieces (false);
					
					if (IsDefined (zom GetTagOrigin ("j_spineupper")))
						PlayFxOnTag (PHD_SLIDER_FX_FIRE, zom, "j_spineupper");
					
					zom DoDamage (zom.maxhealth + 666, zom.origin, self, self, "none", "MOD_BURNED");
				}
			}
		}
	}
	
	self clientfield::set ("burn", 0);
	self StopLoopSound (1);
	
	self thread charge_blaze_phase();
}

function charge_blaze_phase ()
{
	//SELF == PLAYER
	
	self endon (BLAZE_PHASE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	timer = 0;
	
	while (timer < BLAZE_PHASE_COOLDOWN)
	{
		wait .5;
		timer += .5;
		
		bar_height = (timer / BLAZE_PHASE_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.blaze_phase_bar))
			self.blaze_phase_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
	
	self.blaze_phase_on_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Blood Wolf Bite
// ======================================================================================================

function blood_wolf_damage_monitor ()
{
	//SELF == PLAYER

	self endon (BLOOD_WOLF_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("blood_wolf_damage", damage);
		
		if (IsDefined (damage) && damage > 0)
		{
			self.blood_wolf_current_damage += damage;
			
			if (self.blood_wolf_current_damage >= BLOOD_WOLF_DAMAGE_TO_START && 
				self.blood_wolf_active == 0 &&
				self.blood_wolf_on_cooldown == 0)
				self thread do_luna_spawn();
		}
	}
}

function do_luna_spawn()
{
	//SELF == PLAYER
	
	spawner = GetEnt ("zombie_luna", "script_noteworthy");
	
	if (IsDefined (spawner))
	{
		self.blood_wolf_active = 1;
	
		luna = zombie_utility::spawn_zombie (spawner);
		
		if (IsDefined (luna))
		{
			self notify ("cooldown_bar_update");
		
			luna thread make_luna (self);
			self thread blood_wolf_cooldown();
			
			self waittill ("blood_wolf_spawned");
			
			time = BLOOD_WOLF_ACTIVE_TIME;
			
			while (IsDefined (luna) && time > 0)
			{
				time -= .5;
				
				bar_height = (time / BLOOD_WOLF_ACTIVE_TIME) * COOLDOWN_BAR_HEIGHT;
				
				if (bar_height < 1)
					bar_height = 1;
					
				else if (bar_height > COOLDOWN_BAR_HEIGHT)
					bar_height = COOLDOWN_BAR_HEIGHT;
					
				if (!IsInt (bar_height))
					bar_height = Int (bar_height);
					
				if (IsDefined (self.blood_wolf_bar))
					self.blood_wolf_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
				
				wait .5;
			}
			
			if (IsDefined (luna))
			{
				luna thread clientfield::set ("LUNA", 0);
			
				luna.allowDeath = true;
				luna Hide();
				
				PlayFX (level._effect ["dog_gib"], luna.origin);
				PlaySoundAtPosition ("zmb_hellhound_explode", luna.origin);
				
				luna DoDamage (luna.health + 666, luna.origin);
				luna Delete();
			}
			
			self notify ("blood_wolf_cooldown");
		}
		
		else
			self.blood_wolf_active = 0;
	}
}

function blood_wolf_cooldown ()
{
	//SELF == PLAYER
	
	self endon (BLOOD_WOLF_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self waittill ("blood_wolf_cooldown");
	
	self.blood_wolf_active = 0;
	self.blood_wolf_on_cooldown = 1;
	
	time = 0;
	
	while (time < BLOOD_WOLF_COOLDOWN_TIME)
	{
		time += .5;
		
		bar_height = (time / BLOOD_WOLF_COOLDOWN_TIME) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.blood_wolf_bar))
			self.blood_wolf_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
			
		wait .5;
	}
		
	self.blood_wolf_on_cooldown = 0;
	self.blood_wolf_current_damage = 0;
	
	self notify ("cooldown_bar_update");
}

function make_luna (owner)
{
	//SELF == WOLF
	//OWNER == PLAYER
	
	self thread clientfield::set ("LUNA", 1);
	
	self SetModel (BLOOD_WOLF_LUNA_MODEL);
	
	WAIT_SERVER_FRAME;
	
	self.script_string = "riser";
	
	WAIT_SERVER_FRAME;
	
	self notify ("no_rise");
	
	WAIT_SERVER_FRAME;
	
	self StopAnimScripted();
	self ForceTeleport ((self.origin[0], self.origin[1], self.origin[2] + 40));
	
	self thread zm_spawner::zombie_complete_emerging_into_playable_area();
	self thread zm_spawner::zombie_setup_attack_properties();
	
	self.goalRadius = 32;
	self.in_the_ground = undefined;
	
	owner_pos = owner.origin;
	
	Playfx (level._effect ["lightning_dog_spawn"], owner_pos);
	PlaySoundAtPosition ("zmb_hellhound_prespawn", owner_pos);
	wait 1.5;
	PlaySoundAtPosition ("zmb_hellhound_bolt", owner_pos);
	
	self ForceTeleport (owner_pos);
	self.targetname = "zombie_dog";
	self.script_noteworthy = undefined;
	self.animname = "zombie_dog"; 		
	self.maxhealth = 999;
	self.health = 999;
	self.team = "allies";
	self.aat_turned = true;
	self.allowDeath = false;
	self.allowpain = false;
	self.no_gib = true; 
	self.disableArrivals = true; 
	self.disableExits = true;
	self.zombie_move_speed = "sprint";
	self.n_aat_turned_zombie_kills = 0;
	
	owner notify ("blood_wolf_spawned");
	
	while (IsDefined (self))
	{
		if (Distance (owner.origin, self.origin) > 3000)
			self ForceTeleport (owner.origin);
			
		else if (Distance (owner.origin, self.origin) > 200 && !IsDefined (self.favoriteenemy))
			self SetGoal (owner.origin);
		
		else if (Distance (owner.origin, self.origin) < 200 && !IsDefined (self.favoriteenemy))
			self SetGoal (self.origin);
			
		WAIT_SERVER_FRAME;
	}
}


// ======================================================================================================
// Brawlstar Punch
// ======================================================================================================

function brawlstar_punch_think()
{
	//SELF == PLAYER

	self endon (BRAWLSTAR_PUNCH_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	if (BRAWLSTAR_PUNCH_TYPE == "pers")
	{
		for (;;)
		{
			self brawlstar_punch_effect();
			self thread brawlstar_punch_effect_cooldown();
			self waittill ("brawlstar_punch_cooldown");
		}
	}
	
	else if (BRAWLSTAR_PUNCH_TYPE == "one-shot")
	{
		self brawlstar_punch_effect();
			
		self community_perk_collection::brawlstar_punch_take_perk (false, BRAWLSTAR_PUNCH_PERK);
	}
}

function brawlstar_punch_effect()
{
	//self endon (BRAWLSTAR_PUNCH_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self thread brawlstar_activation_watch();
	self thread brawlstar_disconnect_watch();
	
	self waittill ("brawlstar_punch_activate");
	
	if ((IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1)	&& 
		(IsDefined (self.dying_wish_active) && self.dying_wish_active))
		self notify ("dying_wish_cooldown");
	
	if (self GetCurrentWeapon() == level.zombie_powerup_weapon ["minigun"])
	{
		level zm_powerups::weapon_powerup_remove (self, "minigun_time_over", "minigun", true );
		self waittill ("weapon_change");
	}
	
	if (BRAWLSTAR_PUNCH_PLAY_FIRST_SOUND == 1 && !self.brawlstar_punch_first_active)
	{
		self.brawlstar_punch_first_active = true;
		
		self PlaySoundToPlayer (BRAWLSTAR_PUNCH_FIRST_SOUND, self);
		self FreezeControls (true);
		
		wait 6;
		
		self FreezeControls (false);
	}

	self brawlstar_startup();
	self thread wait_for_brawlstar_effect();
	
	if (BRAWLSTAR_PUNCH_USE_FIRE_OVERLAY == 1)
	{
		self clientfield::set ("burn", 1);
		self PlayLoopSound ("chr_burn_loop_overlay");
	}
	
	self waittill ("brawlstar_punch_deactivate");
	
	if (BRAWLSTAR_PUNCH_USE_FIRE_OVERLAY == 1)
	{
		self clientfield::set ("burn", 0);
		self StopLoopSound (1);
	}
	
	self brawlstar_shutdown();
}

function brawlstar_punch_effect_cooldown()
{
	self endon (BRAWLSTAR_PUNCH_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.brawlstar_punch_cooldown = 1;
	
	WAIT_SERVER_FRAME;

	time = 0;

	while (time < BRAWLSTAR_PUNCH_COOLDOWN_TIME)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / BRAWLSTAR_PUNCH_COOLDOWN_TIME) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.brawlstar_punch_bar))
			self.brawlstar_punch_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}

	self notify ("brawlstar_punch_cooldown");
	
	self.brawlstar_punch_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}

function brawlstar_disconnect_watch()
{
	self endon(BRAWLSTAR_PUNCH_PERK + "_stop");
	level endon ("end_game");
	level endon ("game_over");

	self waittill("disconnect");

	players = GetPlayers();
	players = array::exclude(players, self);

	foreach (player in players)
		if(zm_utility::is_player_valid(player))
			player zm_utility::decrement_ignoreme();
}

function brawlstar_activation_watch()
{
	self endon (BRAWLSTAR_PUNCH_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		if (IsDefined (self.brawlstar_punch_active) && !self.brawlstar_punch_active && self ActionSlotFourButtonPressed())
		{
			self notify ("brawlstar_punch_activate");
			self.brawlstar_punch_active = true;
			
			self notify ("cooldown_bar_update");
			break;
		}

		wait .1;
	}
}

function brawlstar_startup()
{
	a_weapons = self GetWeaponsListPrimaries();

	if (IsDefined (a_weapons) && a_weapons.size > 0)
	{
		self.brawlstar_weapon_taken = self GetCurrentWeapon();
		self.brawlstar_weapon_taken.clip = self GetWeaponAmmoClip (self GetCurrentWeapon());
		self.brawlstar_weapon_taken.stock = self GetWeaponAmmoStock (self GetCurrentWeapon());

		if (IsDefined (self.brawlstar_weapon_taken.dualWieldWeapon) && self.brawlstar_weapon_taken.dualWieldWeapon != level.weaponnone)
			self.brawlstar_weapon_taken.clip2 = self GetWeaponAmmoClip (self.brawlstar_weapon_taken.dualWieldWeapon);

		weapon_alt = self GetCurrentWeapon().altWeapon;
		
		if (IsDefined (weapon_alt))
		{
			self.brawlstar_weapon_taken.alt_clip = self GetWeaponAmmoClip (weapon_alt);
			self.brawlstar_weapon_taken.alt_stock = self GetWeaponAmmoStock (weapon_alt);
		}

		self zm_weapons::weapon_take (self GetCurrentWeapon());
		self thread brawlstar_maxammo_watch();
	}

	self zm_weapons::weapon_give (level.brawlstar_punch_fists, false, false, true, true);
	self.brawlstar_punch_old_melee = self zm_utility::get_player_melee_weapon();
	self zm_utility::set_player_melee_weapon (level.brawlstar_punch_fists);

	self zm_utility::increment_is_drinking();

	players = GetPlayers();
	
	if (players.size > 1)
	{
		players = array::exclude (players, self);
	
		foreach (player in players)
			if (zm_utility::is_player_valid (player))
				player zm_utility::increment_ignoreme();
	}
}

function brawlstar_maxammo_watch()
{
	self endon ("disconnect");
	level endon ("end_game");

	self waittill ("zmb_max_ammo");
	self.brawlstar_max_gotten = true;
}

function wait_for_brawlstar_effect()
{
	self endon ("brawlstar_punch_deactivate");
	self endon ("disconnect");

	time = 0;

	while (time < BRAWLSTAR_PUNCH_DURATION)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / BRAWLSTAR_PUNCH_DURATION) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.brawlstar_punch_bar))
			self.brawlstar_punch_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
	}
	
	self.brawlstar_punch_active = false;
	
	self notify ("brawlstar_punch_deactivate");
}

function brawlstar_shutdown()
{
	self endon ("disconnect");

	self zm_weapons::weapon_take (level.brawlstar_punch_fists);
	self zm_utility::set_player_melee_weapon (self.brawlstar_punch_old_melee);
	self.brawlstar_punch_old_melee = undefined;

	if (IsDefined (self.brawlstar_weapon_taken) && !(IsDefined (self.brawlstar_max_gotten) && self.brawlstar_max_gotten))
	{
		weapon = self zm_weapons::weapon_give (self.brawlstar_weapon_taken, false, false, true, true);
		self SetWeaponAmmoClip (weapon, self.brawlstar_weapon_taken.clip);
		self SetWeaponAmmoStock (weapon, self.brawlstar_weapon_taken.stock);

		if (IsDefined (weapon.dualWieldWeapon) && weapon.dualWieldWeapon != level.weaponnone)
		{
			weapon_dw = weapon.dualWieldWeapon;
			self SetWeaponAmmoClip(weapon_dw, self.brawlstar_weapon_taken.clip2);
		}

		weapon_alt = weapon.altWeapon;
		
		if (IsDefined (weapon_alt))
		{
			self SetWeaponAmmoClip (weapon_alt, self.brawlstar_weapon_taken.alt_clip);
			self SetWeaponAmmoStock (weapon_alt, self.brawlstar_weapon_taken.alt_stock);
		}
	}
	
	else if (IsDefined (self.brawlstar_weapon_taken) && (IsDefined (self.brawlstar_max_gotten) && self.brawlstar_max_gotten))
	{
		weapon = self zm_weapons::weapon_give (self.brawlstar_weapon_taken, false, false, true, true);
		self SetWeaponAmmoClip (weapon, self.brawlstar_weapon_taken.clip);

		if (IsDefined (weapon.dualWieldWeapon) && weapon.dualWieldWeapon != level.weaponnone)
		{
			weapon_dw = weapon.dualWieldWeapon;
			self SetWeaponAmmoClip (weapon_dw, self.brawlstar_weapon_taken.clip2);
		}

		weapon_alt = weapon.altWeapon;
		
		if (IsDefined (weapon_alt))
			self SetWeaponAmmoClip (weapon_alt, self.brawlstar_weapon_taken.alt_clip);
		
		self.brawlstar_max_gotten = undefined;
	}

	self.brawlstar_weapon_taken = undefined;

	self zm_utility::clear_is_drinking();

	players = GetPlayers();
	
	if (players.size > 1)
	{
		players = array::exclude (players, self);
	
		foreach (player in players)
			if (zm_utility::is_player_valid (player))
				player zm_utility::decrement_ignoreme();
	}
}

function brawlstar_punch_special_deaths (attacker, vpoint)
{
	//SELF == AI
	//ATTACKER == PLAYER
	
	chance = RandomInt (101);
	
	//Vaporize
	if (chance <= BRAWLSTAR_PUNCH_VAPORIZE_CHANCE)
		attacker thread brawlstar_punch_vaporize (self, vpoint);
		
	//Blowback
	else if (chance <= BRAWLSTAR_PUNCH_VAPORIZE_CHANCE + BRAWLSTAR_PUNCH_BLOWBACK_CHANCE)
		attacker thread brawlstar_punch_blowback (self, vpoint);
}

function brawlstar_punch_vaporize (original_ai, vpoint)
{
	//SELF == PLAYER
	
	player_angles = self GetPlayerAngles();
	player_pos = self.origin;
	forward_view_angles = AnglesToForward (player_angles);
	end_pos = player_pos + (forward_view_angles * 40);
	end_pos = (end_pos [0], end_pos [1], self.origin [2]);
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zombies = util::get_array_of_closest (end_pos, zoms, undefined, undefined, BRAWLSTAR_PUNCH_VAPORIZE_RANGE);
		
		if (IsDefined (zombies) && zombies.size > 0)
		{
			if (IsDefined (vpoint))
				PlayFX (level._effect [BRAWLSTAR_PUNCH_HIT_FX], (vpoint - (0, 0, 15)));
				
			foreach (zombie in zombies)
			{
				//If AI is NOT protected from Brawlstar Punch
				if (!IsDefined (self.ai_too_op_for_brawlstar_punch) || self.ai_too_op_for_brawlstar_punch == 0)
				{
					zombie zombie_utility::gib_random_parts();
					zombie zombie_utility::gib_random_parts();
					GibServerUtils::Annihilate (zombie);
					zombie zm_spawner::zombie_explodes_intopieces (false);
					
					if (zombie != original_ai)
						zombie DoDamage (zombie.health + 666, zombie.origin, self, self, 0, "MOD_UNKNOWN", 0, level.brawlstar_punch_fists);
				}
			}
		}
	}
}

function brawlstar_punch_blowback (original_ai, vpoint)
{
	//SELF == PLAYER
	
	player_angles = self GetPlayerAngles();
	player_pos = self.origin;
	forward_view_angles = AnglesToForward (player_angles);
	end_pos = player_pos + (forward_view_angles * 40);
	end_pos = (end_pos [0], end_pos [1], self.origin [2]);
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zombies = util::get_array_of_closest (end_pos, zoms, undefined, undefined, BRAWLSTAR_PUNCH_BLOWBACK_RANGE);
		
		if (IsDefined (zombies) && zombies.size > 0)
		{
			if (IsDefined (vpoint))
				PlayFx (level._effect [BRAWLSTAR_PUNCH_BLOWBACK_FX], vpoint, self GetWeaponForwardDir());
			
			foreach (zombie in zombies)
			{
				//If AI is NOT protected from Brawlstar Punch
				if (!IsDefined (self.ai_too_op_for_brawlstar_punch) || self.ai_too_op_for_brawlstar_punch == 0)
				{
					angles_forward = AnglesToForward (zombie.angles);
					velocity = VectorScale (-angles_forward, 100);
					
					if (zombie != original_ai)
						zombie DoDamage (zombie.health + 666, zombie.origin, self, self, 0, "MOD_UNKNOWN", 0, level.brawlstar_punch_fists);
						
					zombie StartRagdoll(); 
					zombie LaunchRagdoll (velocity + (0, 0, RandomIntRange (BRAWLSTAR_PUNCH_BLOWBACK_MIN_Z, BRAWLSTAR_PUNCH_BLOWBACK_MAX_Z)));
				}
			}
		}
	}
}


// ======================================================================================================
// Brimstone Bramble
// ======================================================================================================

function brimstone_zombie_array()
{
	//SELF == PLAYER
	
	self endon (BRIMSTONE_BRAMBLE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		zoms = GetAITeamArray (level.zombie_team);
		
		if (IsDefined (zoms) && zoms.size > 0)
		{
			zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, BRIMSTONE_BRAMBLE_FIRE_RADIUS);
			
			if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
				foreach (zom in zoms_in_range)
					if (!IsDefined (zom.ai_too_op_for_brimstone_bramble) || zom.ai_too_op_for_brimstone_bramble == 0) //If AI is NOT protected from Brimstone Bramble
						zom thread brimstone_deal_fire (self);
		}
		
		wait BRIMSTONE_BRAMBLE_CYCLE_TIME;
	}
}

function brimstone_deal_fire (player)
{
	//SELF == AI
	
	if (!IsDefined (self) || !IsAlive (self) || !IsDefined (self.health) || !IsDefined (self.maxhealth))
		return;
		
	if (self.health > 0)
	{
		damage = (BRIMSTONE_BRAMBLE_FIRE_PERCENT * self.maxhealth) + 1;
		
		if (damage < BRIMSTONE_BRAMBLE_MINIMUM_DAMAGE)
			damage = BRIMSTONE_BRAMBLE_MINIMUM_DAMAGE;
			
		if (!IsInt (damage))
			damage = Int (damage);
			
		if ((damage >= self.health) || 
			(IsDefined (level.zombie_vars [player.team]["zombie_insta_kill"]) && level.zombie_vars [player.team]["zombie_insta_kill"] == 1))
			self DoDamage (damage, player.origin, player, player, "torso_lower", "MOD_BURNED");
			
		else
		{
			self.health -= damage;
			
			if (IsDefined (player.west_hasperk_blood_wolf) && player.west_hasperk_blood_wolf == 1)
				player notify ("blood_wolf_damage", damage);
				
			if ((IsDefined (player.west_hasperk_elemental_pop) && player.west_hasperk_elemental_pop == 1) &&
				(IsDefined (player.elemental_pop_on_cooldown) && player.elemental_pop_on_cooldown == 0))
				if (!IsDefined (self.ai_too_op_for_elemental_pop) || self.ai_too_op_for_elemental_pop == 0) //If AI is NOT protected from Elemental Pop
					player thread elemental_pop_think (self, 0, player GetCurrentWeapon(), "MOD_BURNED");
			
			player thread common_give_points (10);
		}
		
		if (IsDefined (self GetTagOrigin ("j_spineupper")))
			PlayFXOnTag (level._effect [BRIMSTONE_BRAMBLE_EXPLOSION_FX], self, "j_spineupper");
	}
}


// ======================================================================================================
// Bull Ice Blast
// ======================================================================================================

function bull_ice_blast_think ()
{
	//SELF == PLAYER
	
	self endon (BULL_ICE_BLAST_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (!self IsOnGround())
		{
			if (self StanceButtonPressed() && self.west_perks_double_jumped == 1)
			{
				if (self.bull_ice_blast_is_slamming == 0)
				{
					self.bull_ice_blast_is_slamming = 1;
					
					self thread bull_ice_blast_slam();
				}
				
				while (!self IsOnGround())
					WAIT_SERVER_FRAME;
			}
			
			self.bull_ice_blast_is_slamming = 0;
		}
			
		WAIT_SERVER_FRAME;
	}
}

function bull_ice_blast_slam ()
{
	//SELF == PLAYER
	
	self SetVelocity (self GetVelocity() + (0, 0, BULL_ICE_BLAST_SLAM_SPEED));
	
	while (!self IsOnGround())
		WAIT_SERVER_FRAME;
		
	Earthquake (.25, 3, self.origin, 50);
	PlayFX (level._effect ["bull_ice_slam_impact"], self.origin);
	PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_IMPACT + RandomIntRange (0, BULL_ICE_BLAST_SOUND_IMPACT_COUNT), self.origin);
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, BULL_ICE_BLAST_SLAM_RANGE);
		
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
			foreach (zom in zoms_in_range)
				if (!IsDefined (zom.ai_too_op_for_bull_ice_blast) || zom.ai_too_op_for_bull_ice_blast == 0) //If AI is NOT protected from Bull Ice Blast
					zom thread bull_ice_blast_freeze();
	}
	
	WAIT_SERVER_FRAME;
	
	self SetStance ("stand");
}

function bull_ice_blast_freeze ()
{
	//SELF == AI
	
	self notify ("bull_ice_blast_freeze_function");
	self endon ("bull_ice_blast_freeze_function");
	
	self.bull_ice_blast_frozen = 1;
	
	if (!IsDefined (self.bull_ice_blast_old_health))
		self.bull_ice_blast_old_health = self.health;
	
	self.health = 1;
	
	if (!IsDefined (self.bull_ice_blast_freeze_fx))
	{
		if (IsDefined (self GetTagOrigin ("j_spineupper")))
			freeze_fx = Spawn ("script_model", self GetTagOrigin ("j_spineupper"));
			
		else
			freeze_fx = Spawn ("script_model", self.origin + (0, 0, 35));
			
		freeze_fx SetModel ("tag_origin");
		freeze_fx EnableLinkTo();
		freeze_fx LinkTo (self);
		
		PlayFXOnTag (level._effect ["bull_ice_slam_idle"], freeze_fx, "tag_origin");
		
		self.bull_ice_blast_freeze_fx = freeze_fx;
	}
	
	if (!IsDefined (self.bull_ice_blast_freeze_model))
	{
		block = Spawn ("script_model", self.origin + (0, 0, 35));
		block SetModel (BULL_ICE_BLAST_SLAM_ICE_BLOCK);
		block EnableLinkTo();
		block LinkTo (self);
		
		self.bull_ice_blast_freeze_model = block;
	}
	
	PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_FREEZE + RandomIntRange (0, BULL_ICE_BLAST_SOUND_FREEZE_COUNT), self.origin);
	
	self.bull_ice_blast_freeze_time = 0;
	
	while (self.bull_ice_blast_freeze_time < BULL_ICE_BLAST_ZOMBIE_SLOWDOWN_TIME)
	{
		self thread zm_utility::slowdown_ai ("bull_ice_blast_slowdown");
		
		wait .5;
		
		if (!IsDefined (self) || !IsAlive (self))
			break;
			
		self.bull_ice_blast_freeze_time += .5;
	}
		
	if (IsDefined (self) && IsAlive (self))
	{
		self.bull_ice_blast_frozen = 0;
		
		if (IsDefined (self.bull_ice_blast_old_health))
			self.health = self.bull_ice_blast_old_health;
		
		PlayFX (level._effect ["bull_ice_slam_break"], self.origin + (0, 0, 35));
		PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_SHATTER + RandomIntRange (0, BULL_ICE_BLAST_SOUND_SHATTER_COUNT), self.origin);
	}
	
	if (IsDefined (self.bull_ice_blast_freeze_fx))
		self.bull_ice_blast_freeze_fx Delete();
	
	if (IsDefined (self.bull_ice_blast_freeze_model))
		self.bull_ice_blast_freeze_model Delete();
}


// ======================================================================================================
// Crusader's Ale
// ======================================================================================================

function crusaders_ale_shield_refresh ()
{
	//SELF == PLAYER
	
	self endon (CRUSADERS_ALE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		level waittill ("start_of_round");
		
		weapon_list = self GetWeaponsList (1);
		
		if (IsDefined (weapon_list) && weapon_list.size > 0)
		{
			foreach (weapon in weapon_list)
			{
				if (IsDefined (weapon.isriotshield) && weapon.isriotshield)
				{
					shieldHealth = self DamageRiotShield (level.zombie_vars ["riotshield_hit_points"] * -1);
					
					if (shieldHealth > level.zombie_vars ["riotshield_hit_points"])
						self DamageRiotShield (shieldHealth - level.zombie_vars ["riotshield_hit_points"]);
						
					self GiveMaxAmmo (weapon);
					
					if (IsDefined (self.player_shield_reset_health))
						self [[self.player_shield_reset_health]]();
				}
			}
		}
	}
}


// ======================================================================================================
// Cryo-Slide Soda
// ======================================================================================================

function cryo_slide_think ()
{
	//SELF == PLAYER
	
	self endon (CRYO_SLIDE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (self IsOnSlide())
		{	
			while (self IsOnSlide())		
				WAIT_SERVER_FRAME;
				
			if (IsDefined (self.cryo_slide_cooldown) && self.cryo_slide_cooldown == 0)
				self thread cryo_slide_freeze();
		}
		
		WAIT_SERVER_FRAME;
	}
}

function cryo_slide_freeze()
{
	//SELF == PLAYER
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, CRYO_SLIDE_RANGE);
		
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
		{
			if (CRYO_SLIDE_PLAY_SOUNDS == 1)
				self PlaySoundToPlayer (CRYO_SLIDE_SOUND_ACTIVATE, self);
	
			PlayFx (CRYO_SLIDE_FX_ACTIVATE, self.origin);
		
			for (i = 0; i < CRYO_SLIDE_MAX_FREEZE; i++)
			{
				//Zombie is undefined
				if (!IsDefined (zoms_in_range[i]))
					continue;
				
				//Zombie is Not AI or Dead
				if (!IsAI (zoms_in_range[i]) || !IsAlive (zoms_in_range[i]))
					continue;
			
				//Too OP for Atomic Liqueur - Boss
				if (IsDefined (zoms_in_range[i].ai_too_op_for_cryo_slide) && zoms_in_range[i].ai_too_op_for_cryo_slide == 1) //If AI is protected from Cryo-Slide Soda
					continue;
					
				zoms_in_range[i] thread cryo_slide_freeze_effect();
			}
			
			self thread cryo_slide_cooldown();
		}
	}
}

function cryo_slide_freeze_effect ()
{
	//SELF == AI
	
	self notify ("cryo_slide_freeze_effect");
	self endon ("cryo_slide_freeze_effect");
	
	self.cryo_slide_freeze = 1;
	
	if (!IsDefined (self.cryo_slide_old_health))
		self.cryo_slide_old_health = self.health;
	
	self.health = 1;
	
	if (!IsDefined (self.cryo_slide_freeze_fx))
	{
		if (IsDefined (self GetTagOrigin ("j_spineupper")))
			freeze_fx = Spawn ("script_model", self GetTagOrigin ("j_spineupper"));
			
		else
			freeze_fx = Spawn ("script_model", self.origin + (0, 0, 35));
			
		freeze_fx SetModel ("tag_origin");
		freeze_fx EnableLinkTo();
		freeze_fx LinkTo (self);
		
		PlayFXOnTag (CRYO_SLIDE_FX_IDLE, freeze_fx, "tag_origin");
		
		self.cryo_slide_freeze_fx = freeze_fx;
	}
	
	if (CRYO_SLIDE_USE_FROZEN_ZOMBIE_MODEL == 1)
		self SetModel (CRYO_SLIDE_ZOMBIE_FROZEN_MODEL);
	
	PlaySoundAtPosition (BULL_ICE_BLAST_SOUND_FREEZE + RandomIntRange (0, BULL_ICE_BLAST_SOUND_FREEZE_COUNT), self.origin);
	
	self zombie_utility::set_zombie_run_cycle ("walk");
	
	self.cryo_slide_freeze_time = 0;
	
	while (self.cryo_slide_freeze_time < CRYO_SLIDE_FROZEN_DURATION)
	{
		self thread zm_utility::slowdown_ai ("cryo_slide_freeze");
		
		wait .5;
		self.cryo_slide_freeze_time += .5;
		
		if (!IsDefined (self) || !IsAlive (self))
			break;
	}
	
	if (IsDefined (self) && IsAlive (self))
	{
		self.cryo_slide_freeze_time = 0;
		
		while (self.cryo_slide_freeze_time < CRYO_SLIDE_THAWING_DURATION)
		{
			self thread zm_utility::slowdown_ai ("cryo_slide_thaw");
			
			wait .5;
			self.cryo_slide_freeze_time += .5;
			
			if (!IsDefined (self) || !IsAlive (self))
				break;
		}
		
		if (IsDefined (self) && IsAlive (self))
		{
			self.cryo_slide_freeze = 0;
			
			if (IsDefined (self.cryo_slide_old_health))
				self.health = self.cryo_slide_old_health;
		}
	}
	
	if (IsDefined (self.cryo_slide_freeze_fx))
		self.cryo_slide_freeze_fx Delete();
}

function cryo_slide_cooldown ()
{
	self endon (CRYO_SLIDE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.cryo_slide_cooldown = 1;

	self notify ("cooldown_bar_update");
	WAIT_SERVER_FRAME;
	
	time = 0;
	
	while (time < CRYO_SLIDE_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / CRYO_SLIDE_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.cryo_slide_bar))
			self.cryo_slide_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}

	self.cryo_slide_cooldown = 0;
	
	self notify ("cooldown_bar_update");
	
	if (CRYO_SLIDE_PLAY_SOUNDS == 1)
		self PlaySoundToPlayer (CRYO_SLIDE_SOUND_READY, self);
}


// ======================================================================================================
// Divine Ale
// ======================================================================================================

function divine_ale_think ()
{
	//SELF == PLAYER
	
	self thread divine_ale_ammo_refresh();
	self thread divine_ale_double_points_watch();
	self thread divine_ale_insta_kill_watch();
	self thread divine_ale_weapon_glow();
}

function divine_ale_ammo_refresh ()
{
	//SELF == PLAYER
	
	self endon (DIVINE_ALE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		level waittill ("start_of_round");
		
		weapons = self GetWeaponsListPrimaries();
		
		if (IsDefined (weapons [0]))
		{
			if (IsDefined (weapons [0].clipsize) && weapons [0].clipsize > 0)
			{
				self SetWeaponAmmoClip (weapons [0], weapons [0].clipsize);
				
				if ((IsDefined (weapons [0].dualwieldweapon) && weapons [0].dualwieldweapon != level.weaponnone) &&
					(IsDefined (weapons [0].dualwieldweapon.clipsize) && weapons [0].dualwieldweapon.clipsize > 0))
					self SetWeaponAmmoClip (weapons [0].dualwieldweapon, weapons [0].dualwieldweapon.clipsize);
			}
			
			//Is Stock defined?
			if (IsDefined (weapons [0].maxAmmo) && weapons [0].maxAmmo > 0)
				self SetWeaponAmmoStock (weapons [0], weapons [0].maxAmmo);
				
			if ((IsDefined (self.west_hasperk_bandolier_bandit) && self.west_hasperk_bandolier_bandit == 1) &&
				IsDefined (self.bandolier_bandit_ammo_watch [weapons [0].name]))
				self.bandolier_bandit_ammo_watch [weapons [0].name] = bandolier_bandit_get_stocksize (weapons [0]);
		}
	}
}

function divine_ale_double_points_watch ()
{
	//SELF == PLAYER
	
	self endon (DIVINE_ALE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		level waittill ("powerup points scaled_" + self.team);
		
		//Check for not 1 to account for custom values
		if (level.zombie_vars [self.team]["zombie_point_scalar"] != 1)
		{
			while (level.zombie_vars [self.team]["zombie_point_scalar"] != 1)
			{
				if (!IsDefined (self.divine_ale_double_damage) || self.divine_ale_double_damage == 0)
					self.divine_ale_double_damage = 1;
				
				WAIT_SERVER_FRAME;
			}
		}
		
		if (IsDefined (self.divine_ale_double_damage) && self.divine_ale_double_damage == 1)
			self.divine_ale_double_damage = 0;
	}
}

function divine_ale_insta_kill_watch ()
{
	//SELF == PLAYER
	
	self endon (DIVINE_ALE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		level waittill ("powerup instakill_" + self.team);
		
		//Check for not 0 to account for custom values
		if (level.zombie_vars [self.team]["zombie_insta_kill"] != 0)
		{
			while (level.zombie_vars [self.team]["zombie_insta_kill"] != 0)
			{
				if (!IsDefined (self.divine_ale_double_points) || self.divine_ale_double_points == 0)
					self.divine_ale_double_points = 1;
				
				WAIT_SERVER_FRAME;
			}
		}
		
		if (IsDefined (self.divine_ale_double_points) && self.divine_ale_double_points == 1)
			self.divine_ale_double_points = 0;
	}
}

function divine_ale_weapon_glow ()
{
	//SELF == PLAYER
	
	self endon (DIVINE_ALE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		weapon = self GetCurrentWeapon();
		weapon_primaries = self GetWeaponsListPrimaries();
		
		if (IsDefined (weapon_primaries [0]) && IsDefined (weapon))
		{
			if (weapon == weapon_primaries [0])
			{
				self clientfield::set_to_player ("divine_ale_fx_view", 1);
				self clientfield::set ("divine_ale_fx_world", 1);
			}
			
			else
			{
				self clientfield::set_to_player ("divine_ale_fx_view", 0);
				self clientfield::set ("divine_ale_fx_world", 0);
			}
		}
		
		self util::waittill_any_return ("weapon_give", "weapon_take", "weapon_change");
	}
}


// ======================================================================================================
// Dying Wish
// ======================================================================================================

function dying_wish_startup ()
{
	//SELF == PLAYER
	
	self endon ("dying_wish_cooldown");
	
	self thread dying_wish_cooldown();
	
	self notify ("cooldown_bar_update");
	
	WAIT_SERVER_FRAME;
	
	if (DYING_WISH_PLAY_SOUNDS == 1)
	{
		self PlaySound (DYING_WISH_SOUND_START);
		self PlayLoopSound (DYING_WISH_SOUND_LOOP, 1);
	}
	
	visionset_mgr::activate ("visionset", "dying_wish_berserk", self, 0.5, 9, 0.5);
	visionset_mgr::activate ("overlay", "dying_wish_berserk", self);
	
	time = 0;
	
	while (time < DYING_WISH_BERSERK_TIME)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / DYING_WISH_BERSERK_TIME) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.dying_wish_bar))
			self.dying_wish_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
		
		self.health = 1;
		self notify ("damage", 0, undefined, undefined, undefined, "MOD_UNKNOWN");
	}
	
	self notify ("dying_wish_cooldown");
}

function dying_wish_cooldown ()
{
	self endon (DYING_WISH_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	self waittill ("dying_wish_cooldown");
	
	visionset_mgr::deactivate ("visionset", "dying_wish_berserk", self);
	visionset_mgr::deactivate ("overlay", "dying_wish_berserk", self);
	
	if (DYING_WISH_PLAY_SOUNDS == 1)
	{
		self StopLoopSound (1);
		self PlaySound (DYING_WISH_SOUND_END);
	}
	
	self.dying_wish_active = 0;
	self.dying_wish_on_cooldown = 1;
	
	time = 0;
	
	while (time < DYING_WISH_BERSERK_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / DYING_WISH_BERSERK_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.dying_wish_bar))
			self.dying_wish_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
	
	self.dying_wish_on_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Electric Cherry
// ======================================================================================================

function electric_cherry_laststand()
{	
	//SELF == PLAYER
	
	self.west_hasperk_electric_cherry = 0;
	
	PlayFX (level._effect [ELECTRIC_CHERRY_FX_EXPLODE_NAME], self.origin);
	self PlaySound (ELECTRIC_CHERRY_SOUND_ATTACK);
	self notify ("electric_cherry_start");
		
	//time for notify to go out
	WAIT_SERVER_FRAME;
			
	a_zombies = zombie_utility::get_round_enemy_array();
	
	if (IsDefined (a_zombies))
	{
		a_zombies_closest = util::get_array_of_closest (self.origin, a_zombies, undefined, undefined, ELECTRIC_CHERRY_DOWNED_ATTACK_RADIUS);
		
		if (IsDefined (a_zombies_closest) && a_zombies_closest.size > 0)
		{
			for (i = 0; i < a_zombies_closest.size; i++)
			{
				if (IsAlive (self) && IsAlive (a_zombies_closest [i]))
				{
					if (a_zombies_closest [i].health <= ELECTRIC_CHERRY_DOWNED_ATTACK_DAMAGE)
					{
						a_zombies_closest [i] thread electric_cherry_death_fx();
							
						//for achievement tracking
						if( IsDefined ( self.cherry_kills ) )
							self.cherry_kills++;
					}
						
					else
					{
						//If AI is NOT protected from Electric Cherry
						if (!IsDefined (a_zombies_closest [i].ai_too_op_for_electric_cherry) || a_zombies_closest [i].ai_too_op_for_electric_cherry == 0)
						{
							a_zombies_closest [i] thread electric_cherry_stun();
							a_zombies_closest [i] thread electric_cherry_shock_fx();
						}
					}
					
					wait 0.1;
						
					a_zombies_closest [i] DoDamage (ELECTRIC_CHERRY_DOWNED_ATTACK_DAMAGE, self.origin, self, self, "none");
				}
			}
		}
	}
		
	self notify ("electric_cherry_end");
}

function electric_cherry_death_fx()  //self = zombie
{
	//SELF == AI

	self endon ("death");
	
	self PlaySound ("zmb_elec_jib_zombie");
	
	if (!IS_TRUE(self.head_gibbed))
	{
		if (IsVehicle (self))
			self clientfield::set ("electric_cherry_fx_tesla_shock_eyes_vehicle", 1);
			
		else
			self clientfield::set ("electric_cherry_fx_tesla_shock_eyes", 1);
	}
	
	else
	{
		if (IsVehicle (self))
			self clientfield::set ("electric_cherry_fx_tesla_death_vehicle", 1);
			
		else
			self clientfield::set ("electric_cherry_fx_tesla_death", 1);
	}		
}

function electric_cherry_shock_fx()  //self = zombie
{
	//SELF == AI

	self endon ("death");
	
	if (IsVehicle (self))
		self clientfield::set ("electric_cherry_fx_tesla_shock_eyes_vehicle", 1);

	else
		self clientfield::set ("electric_cherry_fx_tesla_shock_eyes", 1);
	
	self PlaySound ("zmb_elec_jib_zombie");
	
	self waittill ("stun_fx_end");	

	if (IsVehicle (self))
		self clientfield::set ("electric_cherry_fx_tesla_shock_eyes_vehicle", 0);

	else
		self clientfield::set ("electric_cherry_fx_tesla_shock_eyes", 0);
}


function electric_cherry_stun()  
{
	//SELF == AI

	self endon("death");

	self notify ("stun_zombie");
	self endon ("stun_zombie");

	if (self.health <= 0)
		return;
	
	//only stun the zombie if they are not in the find_flesh state
	if (self.ai_state !== "zombie_think")
		return;	
	
	// This immobilizes zombies because they're being shocked by electricity
	self.zombie_tesla_hit = true;		
	self.ignoreall = true;

	wait ELECTRIC_CHERRY_STUN_CYCLES; // wait time for stun to hold.

	if (IsDefined (self))
	{	
		//set them back on course
		self.zombie_tesla_hit = false;		
		self.ignoreall = false;
		
		self notify ("stun_fx_end");	
	}
}

function electric_cherry_reload_attack()
{
	//SELF == PLAYER

	self endon (ELECTRIC_CHERRY_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	self.wait_on_reload = [];
	
	for (;;)
	{
		self waittill ("reload_start");
		
		current_weapon = self GetCurrentWeapon();
		
		// Don't use the perk if the weapon is waiting to be reloaded
		if (IsInArray (self.wait_on_reload, current_weapon))
			continue;	
		
		// Add this weapon to the list so we know it needs to be reloaded before the perk can be used for again
		self.wait_on_reload [self.wait_on_reload.size] = current_weapon;
		
		// Get the percentage of bullets left in the clip at the time the weapon is reloaded
		n_clip_max = current_weapon.clipsize;
		n_clip_current = self GetWeaponAmmoClip (current_weapon);
		n_fraction = n_clip_current/n_clip_max;
	
		perk_radius = math::linear_map (n_fraction, 1.0, 0.0, ELECTRIC_CHERRY_RELOAD_ATTACK_MIN_RADIUS, ELECTRIC_CHERRY_RELOAD_ATTACK_MAX_RADIUS);
		perk_dmg = math::linear_map (n_fraction, 1.0, 0.0, ELECTRIC_CHERRY_RELOAD_ATTACK_MIN_DAMAGE, ELECTRIC_CHERRY_RELOAD_ATTACK_MAX_DAMAGE);
		
		// Kick off a thread that will tell us when the weapon has been reloaded.
		self thread check_for_reload_complete (current_weapon);
			
		// Start the Cooldown Timer
		self thread electric_cherry_cooldown_timer (current_weapon);
			
		self thread electric_cherry_reload_fx (n_fraction);
		self notify ("electric_cherry_start");
		self PlaySound (ELECTRIC_CHERRY_SOUND_ATTACK);
			
		a_zombies = zombie_utility::get_round_enemy_array();
		a_zombies = util::get_array_of_closest (self.origin, a_zombies, undefined, undefined, perk_radius);
			
		for (i = 0; i < a_zombies.size; i++)
		{
			if (IsAlive (self) && IsAlive (a_zombies [i]))
			{		
				if (a_zombies [i].health <= perk_dmg)
				{
					a_zombies [i] thread electric_cherry_death_fx();
						
					//for achievement tracking
					if (IsDefined (self.cherry_kills))
						self.cherry_kills++;
				}
				
				else
				{
					//If AI is NOT protected from Electric Cherry
					if (!IsDefined (a_zombies [i].ai_too_op_for_electric_cherry) || a_zombies [i].ai_too_op_for_electric_cherry == 0)
					{
						a_zombies [i] thread electric_cherry_stun();
						a_zombies [i] thread electric_cherry_shock_fx();
					}
				}
					
				wait 0.1;
					
				if (IsDefined (a_zombies [i]) && IsAlive (a_zombies [i])) // need to check again since we're post-wait
					a_zombies [i] DoDamage (perk_dmg, self.origin, self, self, "none");
			}
		}
		
		self notify ("electric_cherry_end");
	}
}

function electric_cherry_cooldown_timer (current_weapon) // self = player
{
	self notify ("electric_cherry_cooldown_started");
	
	self endon ("electric_cherry_cooldown_started");
	self endon ("death");
	self endon ("disconnect");
	
	// Start the timer when the player reloads (when electric cherry attack starts)
	// Cooldown time is equal to the weapon's reload time plus the global cooldown
	//n_reload_time = WeaponReloadTime (current_weapon); // TODO
	n_reload_time = 0.25;
	
	if (self HasPerk ("specialty_fastreload"))
		n_reload_time *= GetDvarFloat ("perk_weapReloadMultiplier");
	
	wait n_reload_time;
}

function check_for_reload_complete (weapon) // self = player
{
	self endon ("death");
	self endon ("disconnect");
	self endon ("player_lost_weapon_" + weapon.name);
	
	// Thread to watch for the case where this weapon gets replaced
	self thread weapon_replaced_monitor (weapon);
	
	for (;;)
	{
		// Wait for the player to complete a reload
		self waittill ("reload");
		
		// If the weapon that just got reloaded is the same as the one that was used for the electric cherry perk
		// Kill off this thread and remove this weapon's name from the player's wait_on_reload list
		// This allows the player to use the Electric Cherry Reload Attack with this weapon again!
		current_weapon = self GetCurrentWeapon();
		
		if (current_weapon == weapon)
		{
			ArrayRemoveValue (self.wait_on_reload, weapon);
			self notify ("weapon_reload_complete_" + weapon.name);
			break;
		}
	}
}

function weapon_replaced_monitor (weapon) // self = player
{
	self endon ("death");
	self endon ("disconnect");
	self endon ("weapon_reload_complete_" + weapon.name);
	
	for (;;)
	{
		// Wait for the player to change weapons (swap weapon, wall buy, magic box, etc.)
		self waittill ("weapon_change");
		
		// If the weapon that we previously used for the Electric Cherry Reload Attack is no longer equipped
		// Kill off this thread and remove this weapon's name from the player's wait_on_reload list
		// This handles the case when a player cancels a reload, then replaces this weapon
		// Ensures that when the player re-aquires the weapon, he has a fresh start and can use the Electric Cherry perk immediately.
		primaryWeapons = self GetWeaponsListPrimaries();
		
		if (!IsInArray (primaryWeapons, weapon))
		{
			self notify ("player_lost_weapon_" + weapon.name);
			ArrayRemoveValue (self.wait_on_reload, weapon);
			break;
		}
	}
}

function electric_cherry_reload_fx (n_fraction)
{
	if (n_fraction >= 0.67)
		CodeSetClientField (self, "electric_cherry_fx_reload", 1);	

	else if ((n_fraction >= 0.33) && (n_fraction < 0.67))
		CodeSetClientField (self, "electric_cherry_fx_reload", 2);	

	else
		CodeSetClientField (self, "electric_cherry_fx_reload", 3);	

	wait 1;
	
	CodeSetClientField (self, "electric_cherry_fx_reload", 0);
}


// ======================================================================================================
// Elemental Pop
// ======================================================================================================

function elemental_pop_think (enemy_ai, enemy_will_die, weapon, sMeansOfDeath)
{
	//SELF == PLAYER
	
	if (!IsDefined (enemy_will_die))
		enemy_will_die = 0;
	
	if (IsDefined (level.aat) && level.aat.size > 0)
	{
		if (RandomIntRange (1, 101) <= ELEMENTAL_POP_ACTIVATION_CHANCE)
		{
			for (;;)
			{
				random_aat = array::random (GetArrayKeys (level.aat));
				
				if (random_aat == "none")
					while (random_aat == "none")
						random_aat = array::random (GetArrayKeys (level.aat));
						
				if (random_aat == "zm_aat_fire_works" &&
					(!IsDefined (weapon) || zm_utility::is_offhand_weapon (weapon) ||
					(IsDefined (weapon.isPerkBottle) && weapon.isPerkBottle) ||
					(sMeansOfDeath != "MOD_BULLET" || sMeansOfDeath != "MOD_PISTOL_BULLET" || sMeansOfDeath != "MOD_RIFLE_BULLET")))
					continue;
			
				if (enemy_will_die && !level.aat [random_aat].occurs_on_death)
					continue;
					
				else
					break;
			}
					
			enemy_ai thread [[level.aat [random_aat].result_func]] (enemy_will_die, self, sMeansOfDeath, weapon);
			
			self PlaySoundToPlayer (ELEMENTAL_POP_ACTIVATE_SOUND, self);
			
			self.elemental_pop_on_cooldown = 1;
			
			self thread elemental_pop_cooldown();
		}
	}
}

function elemental_pop_cooldown ()
{
	//SELF == PLAYER
	
	self endon (ELEMENTAL_POP_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	self notify ("cooldown_bar_update");
	
	time = 0;
	
	while (time < ELEMENTAL_POP_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / ELEMENTAL_POP_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.elemental_pop_bar))
			self.elemental_pop_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}

	self.elemental_pop_on_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Ethereal Razor
// ======================================================================================================

function ethereal_razor_think()
{
	//SELF == PLAYER

	self endon (ETHEREAL_RAZOR_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (self IsMeleeing())
			self ethereal_razor_arc();
			
		while (self IsMeleeing()) 
			WAIT_SERVER_FRAME;
			
		WAIT_SERVER_FRAME;
	}
}

function ethereal_razor_arc()
{
	//SELF == PLAYER

	player_angles = self GetPlayerAngles();
	player_pos = self.origin;
	forward_view_angles = AnglesToForward (player_angles);
	end_pos = player_pos + (forward_view_angles * 40);
	end_pos = (end_pos[0], end_pos[1], self.origin[2]);
	
	n_zombies_hit = 0;	
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		a_zombies = util::get_array_of_closest (end_pos, zoms, undefined, undefined, ETHEREAL_RAZOR_RANGE);
		
		if (IsDefined (a_zombies) && a_zombies.size > 0)
		{
			b_zombies = util::get_array_of_closest (player_pos, a_zombies);
			
			if (IsDefined (b_zombies) && b_zombies.size > 0)
			{
				for (i = 0; i < b_zombies.size; i++)
				{
					if (IsAlive (self) && IsAlive (b_zombies [i]))
					{
						if (n_zombies_hit < ETHEREAL_RAZOR_MAX_SWIPE)
							n_zombies_hit++;
							
						else
							break;

						b_zombies[i] DoDamage (ETHEREAL_RAZOR_DAMAGE, self.origin, self, self, "none", "MOD_MELEE");
						
						self thread ethereal_razor_heal();
					}
				}	
			}
		}
	}
}

function ethereal_razor_heal()
{
	//SELF == PLAYER

	if (self.health < self.maxhealth)
	{
		dif = self.maxhealth - self.health;
		
		if (dif < ETHEREAL_RAZOR_HEAL)
			self.health = self.maxhealth;
			
		else
			self.health += ETHEREAL_RAZOR_HEAL;
			
		if (self.health == self.maxhealth)
			self notify("clear_red_flashing_overlay");
	}
}


// ======================================================================================================
// Fighter's Fizz
// ======================================================================================================

function fighters_fizz_laststand ()
{
	//SELF == PLAYER
	
	self fighters_fizz_perk_check();
	self fighters_fizz_downed_logic();
	
	self.west_hasperk_fighters_fizz = 0;
	
	wait 1;
	
	level zm_utility::decrement_no_end_game_check();
}

function fighters_fizz_perk_check()
{
	//SELF == PLAYER

	perk_array = [];
	
	//Handle custom perks
	if (IsDefined (level._custom_perks) && level._custom_perks.size > 0)
	{
		a_keys = GetArrayKeys (level._custom_perks);
		
	    for (i = 0; i < a_keys.size; i++)
			if (self HasPerk (a_keys [i]) && a_keys [i] != FIGHTERS_FIZZ_PERK)
				perk_array [perk_array.size] = a_keys [i];

		if (perk_array.size > 0)
			self.perks_array = perk_array;
	}
}

function fighters_fizz_downed_logic ()
{
	//SELF == Player
	
	self endon ("disconnect");
	self endon ("player_suicide");
	level endon ("game_over");
		
	wait .5;
	
	if (IsDefined (self.fighters_fizz_laststand_weapon))
	{
		self zm_weapons::weapon_take (self.laststandpistol);
		self zm_weapons::weapon_give (self.fighters_fizz_laststand_weapon);
		
		if (IsDefined (self.fighters_fizz_laststand_weapon.clipdw))
			self SetWeaponAmmoClip (self.fighters_fizz_laststand_weapon, self.fighters_fizz_laststand_weapon.clipdw);
		
		if (IsDefined (self.fighters_fizz_laststand_weapon.clip))
			self SetWeaponAmmoClip (self.fighters_fizz_laststand_weapon, self.fighters_fizz_laststand_weapon.clip);
			
		if (IsDefined (self.fighters_fizz_laststand_weapon.stock))
			self SetWeaponAmmoStock (self.fighters_fizz_laststand_weapon, self.fighters_fizz_laststand_weapon.stock);
			
		self SwitchToWeapon (self.fighters_fizz_laststand_weapon);
	}
	
	ffyl_notify = self util::waittill_any_return ("bled_out", "player_revived", "ffyl_killed_zombie");

	if (ffyl_notify == "ffyl_killed_zombie")
    {        
        self thread zm_laststand::auto_revive (self, 0);

        wait .5;

        if (IsDefined (self.perks_array) && IsArray (self.perks_array))
			foreach (perk in self.perks_array)
				self zm_perks::give_perk (perk);
				
        wait 1;

        self.lives++;
    }
	
	else if (ffyl_notify == "bled_out")
		if (level flag::get ("solo_game") || (!level flag::get("solo_game") && level.activeplayers == 0 && self fighters_fizz_any_player_with_perk()))
			level notify ("end_game");
}

function fighters_fizz_any_player_with_perk()
{
	//SELF == PLAYER
	
	foreach (player in GetPlayers())
	{
		if (player == self)
			continue;
			
		if (IsDefined (player.west_hasperk_fighters_fizz) && player.west_hasperk_fighters_fizz == 1)
			return true;
	}
	
	return false;
}

function fighters_fizz_weapon_change_check ()
{
	//SELF == PLAYER
	
	self endon (FIGHTERS_FIZZ_PERK + "_stop");
	self endon ("disconnect");
	self endon ("death");
	level endon ("game_over");
	
	weapon = self GetCurrentWeapon();
		
	if (!IsDefined (self.has_specific_powerup_weapon) &&
		!self zm_utility::is_player_tactical_grenade (weapon) &&
		!self zm_utility::is_player_lethal_grenade (weapon) &&
		!zm_utility::is_offhand_weapon (weapon) &&
		!zm_utility::is_melee_weapon (weapon))
	{
		if ((IsDefined (weapon.blocksprone) && weapon.blocksprone) ||
			(IsDefined (weapon.isPerkBottle) && weapon.isPerkBottle))
		{
			weapon_list = self GetWeaponsListPrimaries();
			
			foreach (weap in weapon_list)
			{
				if (weap == weapon)
					continue;
				
				if (IsDefined (weap.blocksprone) && weap.blocksprone)
					continue;
					
				if (IsDefined (weap.isPerkBottle) && weap.isPerkBottle)
					continue;
					
				self.fighters_fizz_laststand_weapon = weap;
				
				break;
			}
		}
		
		else
			self.fighters_fizz_laststand_weapon = weapon;
		
		if (IsDefined (self.fighters_fizz_laststand_weapon))
		{
			if (IsDefined (self.fighters_fizz_laststand_weapon.clipsize) && self.fighters_fizz_laststand_weapon.clipsize > 0)
				self.fighters_fizz_laststand_weapon.clip = self GetWeaponAmmoClip (self.fighters_fizz_laststand_weapon);
				
			if (IsDefined (self.fighters_fizz_laststand_weapon.dualwieldweapon) && self.fighters_fizz_laststand_weapon.dualwieldweapon != level.weaponnone &&
				IsDefined (self.fighters_fizz_laststand_weapon.dualwieldweapon.clipsize) && self.fighters_fizz_laststand_weapon.dualwieldweapon.clipsize > 0)
				self.fighters_fizz_laststand_weapon.clipdw = self GetWeaponAmmoClip (self.fighters_fizz_laststand_weapon.dualwieldweapon);
				
			if (IsDefined (self.fighters_fizz_laststand_weapon.maxAmmo) && self.fighters_fizz_laststand_weapon.maxAmmo > 0)
				self.fighters_fizz_laststand_weapon.stock = self GetWeaponAmmoStock (self.fighters_fizz_laststand_weapon);
		}
	}

	for (;;)
	{
		self util::waittill_any_return ("weapon_fired", "weapon_give", "weapon_take", "weapon_change");
		
		if (IsDefined (self.has_specific_powerup_weapon) &&
			((IsDefined (self.has_specific_powerup_weapon ["minigun"]) && self.has_specific_powerup_weapon ["minigun"]) ||
			(IsDefined (self.has_specific_powerup_weapon ["tesla"]) && self.has_specific_powerup_weapon ["tesla"])))
			continue;
	
		weapon = self GetCurrentWeapon();
		
		if (self zm_utility::is_player_tactical_grenade (weapon) || self zm_utility::is_player_lethal_grenade (weapon) ||
			zm_utility::is_offhand_weapon (weapon) || zm_utility::is_melee_weapon (weapon))
			continue;
			
		if (IsDefined (weapon.isPerkBottle) && weapon.isPerkBottle)
			continue;
		
		if (IsDefined (weapon.blocksprone) && weapon.blocksprone)
		{
			weapon_list = self GetWeaponsListPrimaries();
			
			foreach (weap in weapon_list)
			{
				if (weap == weapon)
					continue;
				
				if (IsDefined (weap.blocksprone) && weap.blocksprone)
					continue;
					
				if (IsDefined (weapon.isPerkBottle) && weapon.isPerkBottle)
					continue;
					
				self.fighters_fizz_laststand_weapon = weap;
				
				break;
			}
		}
		
		else
			self.fighters_fizz_laststand_weapon = weapon;
		
		if (IsDefined (self.fighters_fizz_laststand_weapon))
		{
			if (IsDefined (self.fighters_fizz_laststand_weapon.clipsize) && self.fighters_fizz_laststand_weapon.clipsize > 0)
				self.fighters_fizz_laststand_weapon.clip = self GetWeaponAmmoClip (self.fighters_fizz_laststand_weapon);
				
			if (IsDefined (self.fighters_fizz_laststand_weapon.dualwieldweapon) && self.fighters_fizz_laststand_weapon.dualwieldweapon != level.weaponnone &&
				IsDefined (self.fighters_fizz_laststand_weapon.dualwieldweapon.clipsize) && self.fighters_fizz_laststand_weapon.dualwieldweapon.clipsize > 0)
				self.fighters_fizz_laststand_weapon.clipdw = self GetWeaponAmmoClip (self.fighters_fizz_laststand_weapon.dualwieldweapon);
				
			if (IsDefined (self.fighters_fizz_laststand_weapon.maxAmmo) && self.fighters_fizz_laststand_weapon.maxAmmo > 0)
				self.fighters_fizz_laststand_weapon.stock = self GetWeaponAmmoStock (self.fighters_fizz_laststand_weapon);
		}
	}
}


// ======================================================================================================
// Gambler's Gibson
// ======================================================================================================

function gamblers_box_check()
{
	//SELF == PLAYER
	
	self endon (GAMBLERS_GIBSON_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	if (!IsPlayer (self))
		return;
		
	for (;;) 
	{
		self waittill ("gamblers_gibson_weapon_grabbed", l_weapon);

		if (IsDefined (l_weapon))
		{
			box_luck = RandomIntRange (1, 101);
			
			if (box_luck <= GAMBLERS_GIBSON_PAP_CHANCE)
			{
				w_weapon = zm_weapons::get_upgrade_weapon (l_weapon, false);
				
				if (IsDefined (w_weapon))
				{
					WAIT_SERVER_FRAME;
					
					self zm_weapons::weapon_take (l_weapon);
					
					WAIT_SERVER_FRAME;
					
					self zm_weapons::weapon_give (w_weapon);
				}
			}
		}
	}
}


// ======================================================================================================
// Glitching Gin
// ======================================================================================================

function glitching_gin_contact_explosion ()
{
	if (IsDefined (self.west_hasperk_tactiquilla) && self.west_hasperk_tactiquilla == 1)
	{
		exclude = 0;
	
		if (TACTIQUILLA_WEAPON_EXLUSION_LIST.size > 0)
		{
			if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
			{
				for (i = 0; i < TACTIQUILLA_WEAPON_EXLUSION_LIST.size; i++)
					if (self.current_tactical_grenade.name == TACTIQUILLA_WEAPON_EXLUSION_LIST [i])
						exclude = 1;
				
			}
			
			else
			{
				for (i = 0; i < TACTIQUILLA_WEAPON_EXLUSION_LIST.size; i++)
					if (self.current_lethal_grenade.name == TACTIQUILLA_WEAPON_EXLUSION_LIST [i])
						exclude = 1;
			}
		}
				
		if (exclude == 0)
		{
			if (RandomIntRange (1, 101) > TACTIQUILLA_REGAIN_AMMO_CHANCE)
			{
				if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
					self SetWeaponAmmoClip (self.current_tactical_grenade, self GetWeaponAmmoClip (self.current_tactical_grenade) - 1);
					
				else
					self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
			}
		}
		
		else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
			self SetWeaponAmmoClip (self.current_tactical_grenade, self GetWeaponAmmoClip (self.current_tactical_grenade) - 1);
			
		else
			self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
	}
	
	else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		self SetWeaponAmmoClip (self.current_tactical_grenade, self GetWeaponAmmoClip (self.current_tactical_grenade) - 1);
		
	else
		self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
		
	self thread glitch_warp_player ();
}

function glitch_warp_player ()
{
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	warp_spot = self get_valid_warp_spot (GLITCHING_GIN_CONTACT_MOVE_DIST);

	if (!IsDefined (warp_spot))
		return; //unable to warp

	self thread glitch_warp_player_away (warp_spot);
}

function get_valid_warp_spot (n_distance)
{
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	a_check_spots = [];

	for (i = 1; i >= -1; i -= 0.25)
		a_check_spots[a_check_spots.size] = (self.origin + (0, 0, 48) + VectorScale((i, (1 - Abs(i)), 0), n_distance));

	for (i = 0.75; i > -1; i -= 0.25)
		a_check_spots[a_check_spots.size] = (self.origin + (0, 0, 48) + VectorScale((i, -(1 - Abs(i)), 0), n_distance));

	a_check_spots = array::randomize (a_check_spots);
	v_spot = undefined;

	for(i = 0; i < 16 && !IsDefined (v_spot); i++)
	{
		a_close_ents = array::get_all_closest (a_check_spots[i], GetAITeamArray (level.zombie_team), undefined, 3, GLITCHING_GIN_CONTACT_MOVE_DIST);

		if (IsDefined (a_close_ents) && IsDefined (a_close_ents[0]))
			continue;

		if (!zm_utility::is_point_inside_enabled_zone (a_check_spots[i]))
			continue;

		if (!IsPointOnNavMesh (a_check_spots[i], self))
			continue;

		if (!SightTracePassed(self.origin + (0, 0, 48), a_check_spots[i], false, self))
			continue;

		v_spot = a_check_spots[i];
	}

	if (!IsDefined (v_spot))
		v_spot = self get_valid_warp_spot (n_distance + GLITCHING_GIN_CONTACT_MOVE_DIST);
	
	return v_spot;
}

function glitch_warp_player_away (warp_spot)
{
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	m_start = Spawn ("script_model", self.origin + (0, 0, 48));
	m_start SetModel ("tag_origin");
	m_start clientfield::set ("glitch_grenade_fx", 2);
	m_finish = Spawn ("script_model", warp_spot);
	m_finish SetModel ("tag_origin");
	m_finish clientfield::set ("glitch_grenade_fx", 2);

	PlaySoundAtPosition (GLITCHING_GIN_SOUND_PLAYER_TP_FRACTURE, m_start.origin);
	PlaySoundAtPosition (GLITCHING_GIN_SOUND_PLAYER_TP_FRACTURE, m_finish.origin);
	m_start PlaySoundToTeam (GLITCHING_GIN_SOUND_WARP_PLAYER_OUT_THIRD, "allies", self);
	m_finish PlaySoundToTeam (GLITCHING_GIN_SOUND_WARP_PLAYER_IN_THIRD, "allies", self);
	self SetOrigin (warp_spot);
	self PlaySoundToPlayer (GLITCHING_GIN_SOUND_WARP_PLAYER, self);

	wait(4);

	m_start clientfield::set ("glitch_grenade_fx", 0);
	m_finish clientfield::set ("glitch_grenade_fx", 0);

	WAIT_SERVER_FRAME;

	m_start Delete();
	m_finish Delete();
}

function glitching_gin_think()
{
	//SELF == PLAYER
	
	if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
	{
		if (level.w_glitching_gin_grenade == self zm_utility::get_player_tactical_grenade())
			return;
			
		self.w_glitching_gin_prev = self zm_utility::get_player_tactical_grenade();
		
		self zm_weapons::weapon_take (self.w_glitching_gin_prev);
		self zm_weapons::weapon_give (level.w_glitching_gin_grenade, false, false, true, false);
		self zm_utility::set_player_tactical_grenade (level.w_glitching_gin_grenade);
	}
	
	else
	{
		if (level.w_glitching_gin_grenade == self zm_utility::get_player_lethal_grenade())
			return;
			
		self.w_glitching_gin_prev = self zm_utility::get_player_lethal_grenade();
		
		self zm_weapons::weapon_take (self.w_glitching_gin_prev);
		self zm_weapons::weapon_give (level.w_glitching_gin_grenade, false, false, true, false);
		self zm_utility::set_player_lethal_grenade (level.w_glitching_gin_grenade);
	}
	
	self thread glitching_gin_watch_for_purchase();
	self thread glitch_grenade_bounce_monitor();
	self thread glitch_grenade_regen_check();
}

function glitching_gin_watch_for_purchase ()
{
	//SELF == PLAYER
	
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_give", weapon);
		
		if (!IsDefined (weapon))
			continue;
			
		if (!zm_utility::is_tactical_grenade (weapon) && !zm_utility::is_lethal_grenade (weapon))
			continue;
		
		//Tactical
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			if (level.w_glitching_gin_grenade == self zm_utility::get_player_tactical_grenade())
				continue;
				
			self zm_weapons::weapon_take (self zm_utility::get_player_tactical_grenade());
			self zm_weapons::weapon_give (level.w_glitching_gin_grenade, false, false, true, false);
			self zm_utility::set_player_tactical_grenade (level.w_glitching_gin_grenade);
		}
		
		//Lethal
		else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		{
			if (level.w_glitching_gin_grenade == self zm_utility::get_player_lethal_grenade())
				continue;
				
			self zm_weapons::weapon_take (self zm_utility::get_player_lethal_grenade());
			
			WAIT_SERVER_FRAME;
			
			self zm_weapons::weapon_give (level.w_glitching_gin_grenade, false, false, true, false);
			self zm_utility::set_player_lethal_grenade (level.w_glitching_gin_grenade);
		}
		
		self notify ("glitching_gin_kill_regen");
	}
}

function glitch_grenade_bounce_monitor()
{
	//SELF == PLAYER
	
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("grenade_fire", e_grenade);

		if (IsDefined (e_grenade.weapon) && e_grenade.weapon == level.w_glitching_gin_grenade)
			e_grenade thread glitch_grenade_bounce (self);
	}
}

function glitch_grenade_bounce (owner)
{
	//SELF == GRENADE
	
	self endon ("explode");

	self waittill ("grenade_bounce", pos, normal, e_target, surface);

	PlaySoundAtPosition (GLITCHING_GIN_SOUND_GRENADE_IMPACT, pos);

	if (!IsDefined (e_target))
		self thread glitch_grenade_collision ("geo", owner, pos, normal, e_target, surface);

	else
		self thread glitch_grenade_collision ("ent", owner, pos, normal, e_target, surface);

}

function glitch_grenade_collision (s_type, owner, pos, normal, e_target, surface)
{
	owner endon ("disconnect");
	
	e_fake_grenade = Spawn ("script_model", pos);
	e_fake_grenade SetModel (self.model);
	e_fake_grenade clientfield::set ("glitch_grenade_fx", 1);
	e_fake_grenade.angles = self.angles;
	
	self Delete();
	
	if (s_type == "ent")
	{
		e_fake_grenade.angles = (normal[0], normal[1], -90);
		v_move = (normal[0], normal[1], 0);
	}
	
	else
	{
		e_fake_grenade.angles = VectorToAngles(normal);

		if ((Abs (normal[0]) + Abs (normal[1])) > Abs (normal[2]))
			v_move = (normal[0], normal[1], 0);

		else
			v_move = (0, 0, normal[2]);
	}

	e_fake_grenade MoveTo (VectorScale (v_move, 48) + pos, GLITCHING_GIN_GRENADE_TRIGGER_TIME);
	e_fake_grenade RotateVelocity ((0, 0, -500), GLITCHING_GIN_GRENADE_TRIGGER_TIME);
	e_fake_grenade PlaySoundOnTag (GLITCHING_GIN_SOUND_GRENADE_WINDUP, "tag_origin");
	
	WAIT_SERVER_FRAME;
	
	e_fake_grenade clientfield::set ("glitch_grenade_fx", 0);
	
	wait GLITCHING_GIN_GRENADE_TRIGGER_TIME;

	if(!zm_utility::is_point_inside_enabled_zone (e_fake_grenade.origin))
	{
		thread grenade_stolen_by_sam (e_fake_grenade);
		return;
	}

	e_fake_grenade clientfield::set ("glitch_grenade_fx", 2);
	e_fake_grenade glitch_player_to_grenade (s_type, owner);
	
	WAIT_SERVER_FRAME;
	
	e_fake_grenade Hide();

	wait(4);

	e_fake_grenade clientfield::set ("glitch_grenade_fx", 0);
	
	WAIT_SERVER_FRAME;
	
	e_fake_grenade Delete();
}

function grenade_stolen_by_sam (ent_model)
{
	if (!IsDefined (ent_model))
		return;
	
	direction = ent_model.origin;
	direction = (direction[1], direction[0], 0);
 
	if (direction[1] < 0 || (direction[0] > 0 && direction[1] > 0))
		direction = (direction[0], direction[1] * -1, 0);

	else if (direction[0] < 0)
		direction = (direction[0] * -1, direction[1], 0);
	
	players = GetPlayers();

	for (i = 0; i < players.size; i++)
		if (IsAlive (players[i]))
			players[i] PlayLocalSound (level.zmb_laugh_alias);

	if (IsDefined (ent_model GetTagOrigin ("tag_origin")))
		PlayFXOnTag (level._effect["grenade_samantha_steal"], ent_model, "tag_origin");
	
	ent_model MoveZ (60, 1.0, 0.25, 0.25);

	ent_model Vibrate (direction, 1.5, 2.5, 1.0);
	ent_model waittill ("movedone");
	
	ent_model Delete();
}

function glitch_player_to_grenade (s_type, owner)
{
	self thread glitch_annihilate_zoms (owner);
	
	PlaySoundAtPosition (GLITCHING_GIN_SOUND_GRENADE_EXPLODE, self.origin);
	PlaySoundAtPosition (GLITCHING_GIN_SOUND_PLAYER_TP_FRACTURE, self.origin);
	PlaySoundAtPosition (GLITCHING_GIN_SOUND_PLAYER_TP_FRACTURE, owner.origin);
	self PlaySoundToTeam (GLITCHING_GIN_SOUND_WARP_PLAYER_IN_THIRD, "allies", owner);
	
	owner SetVelocity ((0, 0, 0));
	owner SetOrigin (self.origin - (0, 0, 20));
	owner PlaySoundToPlayer (GLITCHING_GIN_SOUND_WARP_PLAYER, owner);
}

function glitch_annihilate_zoms (owner)
{
	self endon ("death");
	
	v_point = PlayerPhysicsTrace (self.origin, self.origin + VectorScale((0, 0, -1), 500));
	a_close_ents = array::get_all_closest (v_point, GetAITeamArray(level.zombie_team), undefined, undefined, GLITCHING_GIN_CONTACT_MOVE_DIST);
	
	if (IsDefined (a_close_ents) && a_close_ents.size > 0)
	{
		m_point = Spawn ("script_model", v_point + (0, 0, 5));
		m_point SetModel ("tag_origin");
		m_point clientfield::set ("glitch_grenade_fx", 3);
		PlaySoundAtPosition (GLITCHING_GIN_SOUND_GRENADE_KILL_ZOMBIES, m_point.origin);
		
		for (i = 0; i < a_close_ents.size; i++)
		{
			if (i % 4 == 0)
			{
				WAIT_SERVER_FRAME;
				WAIT_SERVER_FRAME;
			}
			
			
			if (!IsDefined (a_close_ents[i].ai_too_op_for_glitching_gin) || a_close_ents[i].ai_too_op_for_glitching_gin == 0) //If AI is NOT protected from Glitching Gin
			{
				a_close_ents[i].no_powerups = true;
				GibServerUtils::Annihilate (a_close_ents[i]);
				a_close_ents[i] DoDamage (a_close_ents[i].health + 1000, a_close_ents[i].origin, owner, self, 0, "MOD_EXPLOSIVE", 0, level.w_glitching_gin_grenade);
			}
		}

		wait 3;

		m_point clientfield::set("glitch_grenade_fx", 0);
		
		WAIT_SERVER_FRAME;
		
		m_point Delete();
	}
}

function glitch_grenade_regen_check ()
{
	//SELF == PLAYER
	
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		do_regen = 0;
		
		//Tactical
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			if (self GetWeaponAmmoClip (self.current_tactical_grenade) < 4)
				do_regen = 1;
		}
		
		//Lethal
		else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		{
			if (self GetWeaponAmmoClip (self.current_lethal_grenade) < 4)
				do_regen = 1;
		}
		
		if (do_regen == 0)
		{
			self waittill ("grenade_fire", e_grenade);
			
			if (IsDefined (e_grenade.weapon) && e_grenade.weapon == level.w_glitching_gin_grenade)
				self glitch_grenade_regen_timer();
		}
		
		else
			self glitch_grenade_regen_timer();
	}
}

function glitch_grenade_regen_timer ()
{
	//SELF == PLAYER
	
	self endon (GLITCHING_GIN_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("zmb_max_ammo");
	self endon ("glitching_gin_kill_regen");
	
	give_grenade = 1;
	time = 0;
	
	while (time < GLITCHING_GIN_GRENADE_REGEN_TIME)
	{
		wait .5;
		time += .5;
		
		//Tactical
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			if (self GetWeaponAmmoClip (self.current_tactical_grenade) > 3)
			{
				give_grenade = 0;
				
				break;
			}
		}
		
		//Lethal
		else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		{
			if (self GetWeaponAmmoClip (self.current_lethal_grenade) > 3)
			{
				give_grenade = 0;
				
				break;
			}
		}
	}
	
	if (give_grenade == 1)
	{
		//Tactical
		if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 0)
		{
			if (GLITCHING_GIN_PLAY_SOUNDS == 1)
				self PlaySoundToPlayer (GLITCHING_GIN_SOUND_GRENADE_REGEN, self);
				
			self SetWeaponAmmoClip (self.current_tactical_grenade, self GetWeaponAmmoClip (self.current_tactical_grenade) + 1);
		}
		
		//Lethal
		else if (GLITCHING_GIN_TACTICAL_OR_LETHAL == 1)
		{
			if (GLITCHING_GIN_PLAY_SOUNDS == 1)
				self PlaySoundToPlayer (GLITCHING_GIN_SOUND_GRENADE_REGEN, self);
				
			self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) + 1);
		}
	}
}


// ======================================================================================================
// I.C.U.
// ======================================================================================================

function icu_think ()
{
	//SELF == PLAYER

	self thread icu_health_regen();
	self thread icu_invincibility();
	self thread icu_speed_function();
}

function icu_health_regen ()
{
	//SELF == PLAYER
	
	self endon (ICU_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		self waittill ("damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel);
	
		while (self.health < self.maxhealth)
		{
			if (IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1 && 
				IsDefined (self.dying_wish_active) && self.dying_wish_active == 1 &&
				IsDefined (self.dying_wish_on_cooldown) && self.dying_wish_on_cooldown == 0)
				break;
		
			if ((self.maxhealth - self.health) > ICU_HEALTH_REGEN_AMOUNT)
				self.health = self.health + ICU_HEALTH_REGEN_AMOUNT;
	
			else
				self.health = self.maxhealth;

			wait (ICU_HEALTH_REGEN_CYCLE_TIME);
		}
		
		self notify ("clear_red_flashing_overlay");
	}
}

function icu_invincibility ()
{
	//SELF == PLAYER
	
	self endon (ICU_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		if (IsDefined (self.is_drinking) && IS_DRINKING(self.is_drinking))
		{
			self.icu_invincible = 1;
			
			while (IS_DRINKING(self.is_drinking))
				WAIT_SERVER_FRAME;
				
			self.icu_invincible = 0;
		}

		if (self GetCurrentWeapon() == level.weaponReviveTool)
		{
			self.icu_invincible = 1;
			
			while (self GetCurrentWeapon() == GetWeapon ("syrette"))
				WAIT_SERVER_FRAME;
				
			self.icu_invincible = 0;
		}

		if (self GetCurrentWeapon() == GetWeapon ("zombie_knuckle_crack"))
		{
			self.icu_invincible = 1;
			
			while (self GetCurrentWeapon() == GetWeapon ("zombie_knuckle_crack"))
				WAIT_SERVER_FRAME;
				
			self.icu_invincible = 0;
		}
		
		if (self GetCurrentWeapon() == GetWeapon ("zombie_builder"))
		{
			self.icu_invincible = 1;
			
			while (self GetCurrentWeapon() == GetWeapon ("zombie_builder"))
				WAIT_SERVER_FRAME;
				
			self.icu_invincible = 0;
		}
		
		WAIT_SERVER_FRAME;
	}
}

function icu_speed_function ()
{
	//SELF == PLAYER
	
	self endon (ICU_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel);
		
		if (self.health <= ICU_HEALTH_THRESHOLD)
		{
			while (self.health <= ICU_HEALTH_THRESHOLD)
			{
				if (!IsDefined (self.icu_should_boost) || self.icu_should_boost == 0)
					self.icu_should_boost = 1;
				
				WAIT_SERVER_FRAME;
			}
		}
		
		if (IsDefined (self.icu_should_boost) && self.icu_should_boost == 1)
			self.icu_should_boost = 0;
		
		WAIT_SERVER_FRAME;
	}
}


// ======================================================================================================
// Madgaz Moonshine
// ======================================================================================================

function madgaz_moonshine_think ()
{
	//SELF == PLAYER
	
	self endon (MADGAZ_MOONSHINE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self thread madgaz_moonshine_refresh();
	
	for (;;)
	{
		if (self IsOnSlide())
		{	
			while (self IsOnSlide())
				WAIT_SERVER_FRAME;
				
			if (IsDefined (self.madgaz_moonshine_explosion_count) && self.madgaz_moonshine_explosion_count < MADGAZ_MOONSHINE_MAX_EXPLOSIONS)
				if ((!IsDefined (self.west_hasperk_cryo_slide) || self.west_hasperk_cryo_slide == 0) ||
					(!IsDefined (self.cryo_slide_cooldown) || self.cryo_slide_cooldown == 1))
					self thread madgaz_moonshine_explosion();
		}
		
		WAIT_SERVER_FRAME;
	}
}

function madgaz_moonshine_refresh ()
{
	//SELF == PLAYER
	
	self endon (MADGAZ_MOONSHINE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		level waittill ("start_of_round");
		
		if (IsDefined (self.madgaz_moonshine_explosion_count))
			self.madgaz_moonshine_explosion_count = 0;
	}
}

function madgaz_moonshine_explosion ()
{
	//SELF == PLAYER
	
	zoms = GetAITeamArray (level.zombie_team);
		
	if (IsDefined (zoms) && zoms.size > 0)
	{
		a_zombies = util::get_array_of_closest (self.origin, zoms, undefined, undefined, MADGAZ_MOONSHINE_RANGE);
	
		if (IsDefined (a_zombies) && a_zombies.size > 0)
		{
			self.madgaz_moonshine_explosion_count++;
			
			self PlaySound (MADGAZ_MOONSHINE_EXPLOSION_SOUND);
			PlayFx (MADGAZ_MOONSHINE_EXPLOSION_FX, self.origin);
			PlayFx (PHD_SLIDER_FX_EXPLOSION, self.origin, self.angles);
				
			foreach (zombie in a_zombies)
			{
				if (IsAlive (zombie) && (!IsDefined (zombie.ai_too_op_for_madgaz_moonshine) || zombie.ai_too_op_for_madgaz_moonshine == 0)) //If AI is NOT protected from Madgaz Moonshine
				{
					angles_forward = AnglesToForward (zombie.angles);
					velocity = VectorScale (-angles_forward, 100);
				
					zombie zombie_utility::gib_random_parts();
					zombie zombie_utility::gib_random_parts();
					GibServerUtils::Annihilate (zombie);
					zombie zm_spawner::zombie_explodes_intopieces (false);
						
					zombie DoDamage (zombie.health + 666, zombie.origin, self, self, "none", "MOD_BURNED");
					zombie StartRagdoll(); 
					zombie LaunchRagdoll (velocity + (0, 0, 40));
				}
			}
		}
	}
}


// ======================================================================================================
// Magnet Mule
// ======================================================================================================

function powerup_magnet()
{
	//SELF == PLAYER
	
	self endon (MAGNET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	magnet_powerups_exclude = [];
	i = 0;
	
	if (MAGNET_GRAB_NUKE != 1)
	{
		magnet_powerups_exclude[i] = "nuke";
		i++;
	}
	
	if (MAGNET_GRAB_DOUBLE != 1)
	{
		magnet_powerups_exclude[i] = "double_points";
		i++;
	}
	
	if (MAGNET_GRAB_INSTA != 1)
	{
		magnet_powerups_exclude[i] = "insta_kill";
		i++;
	}
	
	if (MAGNET_GRAB_CARPENTER != 1)
	{
		magnet_powerups_exclude[i] = "carpenter";
		i++;
	}
	
	if (MAGNET_GRAB_MAX != 1)
	{
		magnet_powerups_exclude[i] = "full_ammo";
		i++;
	}
	
	if (MAGNET_GRAB_DEATHMACHINE != 1)
	{
		magnet_powerups_exclude[i] = "minigun";
		i++;
	}
	
	if (MAGNET_GRAB_FIRESALE != 1)
	{
		magnet_powerups_exclude[i] = "fire_sale";
		i++;
	}
	
	if (MAGNET_GRAB_FREE_PERK != 1)
	{
		magnet_powerups_exclude[i] = "free_perk";
		i++;
	}

	if (MAGNET_GRAB_CUSTOM_POWERUP != 1)
	{
		magnet_powerups_exclude[i] = "custom_powerup";
		i++;
	}
	
    for (;;)
    {
        WAIT_SERVER_FRAME;

        foreach (powerup in level.active_powerups)
        {
            if (IsDefined (powerup) && !IS_TRUE(powerup.b_magnet_threaded))
            {   
                if (IsDefined (powerup.powerup_name) && IsInArray (magnet_powerups_exclude, powerup.powerup_name))
                {
					powerup.b_magnet_threaded = true;
					continue;
				}
                
				powerup.closest_player = undefined;
				powerup.b_magnet_threaded = true;
				powerup thread _powerup_check_valid_players();
				powerup thread _powerup_watch_magnet();
            }
        }
    }
}

function _powerup_watch_magnet()
{
	//SELF == POWERUP

    self endon ("death");
    self endon ("hacked");
    self endon ("powerup_grabbed");
    self endon ("powerup_timedout");
	level endon ("end_game");
	level endon ("game_over");

    while (IsDefined (self))
    {
        WAIT_SERVER_FRAME;

        self notify ("movedone");
		
		self MoveTo (self.origin, .05);

        if (!IsDefined (self.closest_player))
			continue;
        
        else 
			dist_to_player = Distance (self.origin, (self.closest_player.origin));		
			
		if (dist_to_player > (MAGNET_RANGE / 8) * 7)
			self MoveTo (self.closest_player.origin + (0, 0, 30), MAGNET_PULL_SPEED_FAR);
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 6)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .75));
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 5)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .5));
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 4)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .25));
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 3)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .1875));
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 2)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .125));
			
		else if (dist_to_player > (MAGNET_RANGE / 8) * 1)
			self MoveTo (self.closest_player.origin + (0, 0, 30), (MAGNET_PULL_SPEED_FAR * .0625));
			
		else
			self MoveTo (self.origin, .05);
    }
}

function _powerup_check_valid_players()
{
	//SELF == POWERUP

    self endon ("death");
    self endon ("hacked");
    self endon ("powerup_grabbed");
    self endon ("powerup_timedout");
	level endon ("end_game");
	level endon ("game_over");

    if (IsDefined (self.powerup_player))
	{
		self thread _powerup_check_valid_player_solo();
		return;
	}

    while (IsDefined (self))
    {
        WAIT_SERVER_FRAME;

        a_valids = [];
        foreach (player in level.players)
        {
            WAIT_SERVER_FRAME;

            if (zm_utility::is_player_valid (player, false, true) && (IsDefined (player.west_hasperk_magnet) && player.west_hasperk_magnet == 1))
				a_valids[a_valids.size] = player;
        }

        if (a_valids.size < 1)
        {
            self.closest_player = undefined;
            continue;
        }

        else 
			self.closest_player = ArrayGetClosest (self.origin, a_valids, MAGNET_RANGE);
    }
}

function _powerup_check_valid_player_solo()
{
	//SELF == POWERUP

    self endon ("death");
    self endon ("hacked");
    self endon ("powerup_grabbed");
    self endon ("powerup_timedout");
	level endon ("end_game");
	level endon ("game_over");
    
    while (IsDefined (self))
    {
        WAIT_SERVER_FRAME;

        if ((IsDefined (self.powerup_player.west_hasperk_magnet) && self.powerup_player.west_hasperk_magnet == 1) &&
			zm_utility::is_player_valid (self.powerup_player, false, true))
		{
			if (!IsDefined (self.closest_player))
				self.closest_player = self.powerup_player;
				
			else if (self.closest_player != self.powerup_player)
				self.closest_player = self.powerup_player;
		}
        
        else 
			self.closest_player = undefined;
    }
}


// ======================================================================================================
// Masochist's Malecon
// ======================================================================================================

function masochist_speed_function ()
{
	//SELF == PLAYER
	
	self endon (ICU_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel);
		
		if (self.health < MASOCHIST_HEALTH_THRESHOLD)
		{
			while (self.health < MASOCHIST_HEALTH_THRESHOLD)
			{
				if (!IsDefined (self.masochist_should_boost) || self.masochist_should_boost == 0)
					self.masochist_should_boost = 1;
				
				WAIT_SERVER_FRAME;
			}
		}
		
		if (IsDefined (self.masochist_should_boost) && self.masochist_should_boost == 1)
			self.masochist_should_boost = 0;
		
		WAIT_SERVER_FRAME;
	}
}


// ======================================================================================================
// Medusa's Mauresque
// ======================================================================================================

function medusas_mauresque_think()
{
	//SELF == LEVEL
	
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		zoms = GetAITeamArray (level.zombie_team);
		players = GetPlayers();
		
		if ((IsDefined (zoms) && zoms.size > 0) && (IsDefined (players) && players.size > 0))
		{
			foreach (zom in zoms)
			{
				//If AI is protected from Medusa's Mauresque
				if (IsDefined (zom.ai_too_op_for_medusas_mauresque) && zom.ai_too_op_for_medusas_mauresque == 1)
					continue;
					
				zom.medusas_mauresque_seen = 0;
				zom.medusas_mauresque_players = [];
				
				foreach (player in players)
				{
					//AI Sees Me & I See AI
					if ((zom CanSee (player) && zom player_can_see_me (player)) &&
						(IsDefined (player.west_hasperk_medusas_mauresque) && player.west_hasperk_medusas_mauresque == 1))
					{
						zom.medusas_mauresque_players [zom.medusas_mauresque_players.size] = player;
						
						if (zom.medusas_mauresque_seen == 0)
						{
							if (!IsDefined (zom.medusas_mauresque_count) || zom.medusas_mauresque_count == 0)
								zom.medusas_mauresque_count = 1;
								
							else
								zom.medusas_mauresque_count++;
								
							zom.medusas_mauresque_seen = 1;
						}
					}
				}
				
				if (zom.medusas_mauresque_seen == 1 && zom.medusas_mauresque_players.size > 0)
					zom thread medusas_mauresque_deal_damage (zom.medusas_mauresque_players);
				
				else if (zom.medusas_mauresque_seen == 0 && (IsDefined (zom.medusas_mauresque_count) && zom.medusas_mauresque_count != 0))
					zom.medusas_mauresque_count = 0;
			}
		}
		
		wait MEDUSAS_MAURESQUE_CYCLE_TIME;
	}
}

function medusas_mauresque_deal_damage (players)
{
	//SELF == AI
	
	if (!IsDefined (self) || !IsAlive (self) || !IsDefined (self.health) || !IsDefined (self.maxhealth))
		return;
		
	if (self.medusas_mauresque_count > 49)
		self thread zm_utility::slowdown_ai ("medusas_mauresque_slowdown_49");
		
	else
		self thread zm_utility::slowdown_ai ("medusas_mauresque_slowdown_" + self.medusas_mauresque_count);
		
	if (self.health > 0)
	{
		damage = ((MEDUSAS_MAURESQUE_DAMAGE_INCREASE * self.medusas_mauresque_count) * self.maxhealth) + 1;
		
		if (self.medusas_mauresque_players.size > 1)
			damage *= 1 + (.25 * (self.medusas_mauresque_players.size - 1));
		
		if (!IsInt (damage))
			damage = Int (damage);
			
		ai_will_die = 0;
			
		if (damage >= self.health)
			ai_will_die = 1;
		
		foreach (player in players)
			if (IsDefined (level.zombie_vars [player.team]["zombie_insta_kill"]) && level.zombie_vars [player.team]["zombie_insta_kill"] == 1)
				ai_will_die = 1;
		 
		if (ai_will_die)
		{
			foreach (player in players)
				self DoDamage (damage, player.origin, player, player, "torso_lower", "MOD_UNKNOWN");
		}
			
		else
		{
			self.health -= damage;
			
			foreach (player in players)
			{
				if (IsDefined (player.west_hasperk_blood_wolf) && player.west_hasperk_blood_wolf == 1)
					player notify ("blood_wolf_damage", damage);
					
				if ((IsDefined (player.west_hasperk_elemental_pop) && player.west_hasperk_elemental_pop == 1) &&
					(IsDefined (player.elemental_pop_on_cooldown) && player.elemental_pop_on_cooldown == 0))
					if (!IsDefined (self.ai_too_op_for_elemental_pop) || self.ai_too_op_for_elemental_pop == 0) //If AI is NOT protected from Elemental Pop
						player thread elemental_pop_think (self, 0, player GetCurrentWeapon(), "MOD_UNKNOWN");
				
				player thread common_give_points (5);
			}
		}
		
		//foreach (player in players)
			//player IPrintLnBold (damage);
	}
}


// ======================================================================================================
// Muscle Milk
// ======================================================================================================

function muscle_milk_lightning (zombie)
{
	//SELF == PLAYER
	
	if (IsDefined (zombie.zombie_tesla_hit) && zombie.zombie_tesla_hit)
		return; //Can happen if an enemy is marked for tesla death and player hits again with the tesla gun
		
	self thread muscle_milk_cooldown();
	
	self.tesla_enemies = undefined;
	self.tesla_enemies_hit = 1;
	self.tesla_powerup_dropped = false;
	self.tesla_arc_count = 0;
	self.tesla_firing = 1;
	
	zombie lightning_chain::arc_damage (zombie, self, 1, level.muscle_milk_lightning_params);
	
	if (self.tesla_enemies_hit >= 4)
		self thread muscle_milk_killstreak_sound();

	self.tesla_enemies_hit = 0;
	self.tesla_firing = 0;
}

function muscle_milk_killstreak_sound ()
{
	//SELF == PLAYER

	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	//TUEY Play some dialog if you kick ass with the Tesla gun
	self zm_audio::create_and_play_dialog ("kill", "tesla");
	
	wait 3.5;
	
	level util::clientNotify ("TGH");
}

function muscle_milk_cooldown ()
{
	//SELF == PLAYER
	
	self endon (MUSCLE_MILK_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self.muscle_milk_cooldown = 1;

	self notify ("cooldown_bar_update");
	
	time = 0;
	
	while (time < MUSCLE_MILK_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / MUSCLE_MILK_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.muscle_milk_bar))
			self.muscle_milk_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}

	self.muscle_milk_cooldown = 0;
	
	self notify ("cooldown_bar_update");
	
	self PlaySoundToPlayer (MUSCLE_MILK_SOUND_READY, self);
}


// ======================================================================================================
// PhD Flopper
// ======================================================================================================

function phd_flopper_watch_for_fall ()
{
	//SELF == PLAYER
	
	self endon (PHD_FLOPPER_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (!self IsOnGround())
		{
			while (!self IsOnGround())
			{
				player_velocity = self GetVelocity();
				
				if (player_velocity [2] < 0)
				{
					starting_z = self.origin [2];
					
					if (!IsInt (starting_z))
						starting_z = Int (starting_z);
						
					break;
				}
				
				WAIT_SERVER_FRAME;
			}
			
			restart = 0;
			
			while (!self IsOnGround())
			{
				player_velocity = self GetVelocity();
				
				if (player_velocity [2] > 0)
				{
					//Player Double Jumped
					restart = 1;
					
					break;
				}
				
				WAIT_SERVER_FRAME;
			}
			
			//Player Double Jumped
			if (restart == 1)
				continue;
				
			ending_z = self.origin [2];
			
			if (!IsInt (ending_z))
				ending_z = Int (ending_z);
				
			fall_distance = starting_z - ending_z;
			
			if (fall_distance > PHD_FLOPPER_FALL_DIST)
			{
				PlaySoundAtPosition ("wpn_grenade_explode", self.origin);
				PlayFx (PHD_FLOPPER_FX_EXPLOSION, self.origin, self.angles);
				Earthquake (.42, 1, self.origin, PHD_FLOPPER_FALL_RANGE);
				RadiusDamage (self.origin, PHD_FLOPPER_FALL_RANGE, PHD_FLOPPER_FALL_MAX_DAMAGE, PHD_FLOPPER_FALL_MIN_DAMAGE, self, "MOD_EXPLOSIVE");
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function phd_flopper_grenade_split (grenade, weapon)
{
	//SELF == PLAYER
	
	self endon ("grenade_dud");
	self endon ("explode");
	
	grenade thread phd_flopper_grenade_timeout();
	
	grenade util::waittill_any_return ("grenade_bounce", "grenade_stuck", "detonate", "stationary", "explode", "phd_flopper_timeout");
	
	if (IsDefined (grenade))
	{
		if (IsDefined (grenade.threwBack) && grenade.threwBack)
			return;
			
		self thread phd_flopper_spawn_grenades (grenade.origin, weapon);
	}
}

function phd_flopper_spawn_grenades (split_spawn_point, weapon)
{
	//SELF == PLAYER
	
	amount_to_spawn = RandomIntRange (PHD_FLOPPER_GRENADE_SPLIT_MIN, PHD_FLOPPER_GRENADE_SPLIT_MAX + 1);
	
	for (i = 0; i < amount_to_spawn; i++)
	{
		if (IsDefined (weapon))
		{
			vector_x = RandomIntRange (-PHD_FLOPPER_GRENADE_SPLIT_X, PHD_FLOPPER_GRENADE_SPLIT_X + 1);
			vector_y = RandomIntRange (-PHD_FLOPPER_GRENADE_SPLIT_Y, PHD_FLOPPER_GRENADE_SPLIT_Y + 1);
			vector_z = RandomIntRange (-PHD_FLOPPER_GRENADE_SPLIT_Z, PHD_FLOPPER_GRENADE_SPLIT_Z + 1);
			
			split_grenade = self MagicGrenadeType (weapon, split_spawn_point, VectorScale ((vector_x, vector_y, vector_z), 100), PHD_FLOPPER_GRENADE_FUSE_TIME);
			
			if (IsDefined (split_grenade))
			{
				split_grenade.phd_flopper_split = 1;
				
				if (IsDefined (level.w_glitching_gin_grenade) && weapon == level.w_glitching_gin_grenade)
					split_grenade thread glitch_grenade_bounce (self);
			}
		}
		
		wait .15;
	}
}

function phd_flopper_grenade_timeout ()
{
	//SELF == GRENADE
	
	self endon ("grenade_dud");
	self endon ("explode");
	
	wait PHD_FLOPPER_GRENADE_SPLIT_DELAY;
	
	if (IsDefined (self))
		self notify ("phd_flopper_timeout");
}


// ======================================================================================================
// PhD Slider
// ======================================================================================================

function phd_slider_think ()
{
	//SELF == PLAYER
	
	self endon (PHD_SLIDER_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (self IsOnSlide())
		{
			if (self.phd_slider_power == PHD_SLIDER_MAX_POWER)
				self check_for_slider_impact();
			
			while (self IsOnSlide())
			{
				self.phd_slider_power += PHD_SLIDER_GAIN_PER_TICK;
				
				if (self.phd_slider_power > PHD_SLIDER_MAX_POWER)
					self.phd_slider_power = PHD_SLIDER_MAX_POWER;
					
				WAIT_SERVER_FRAME;
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function check_for_slider_impact ()
{
	//SELF == PLAYER
	
	ready_to_explode = 1;

	while (self IsOnSlide())
	{
		angles = self GetPlayerAngles();
		angles_forward = AnglesToForward (angles);
		push = vectorScale (angles_forward, PHD_SLIDER_SLIDE_BOOST);
		
		self SetVelocity (push);
		
		if (ready_to_explode == 1)
		{
			zoms = GetAITeamArray (level.zombie_team);
		
			if (IsDefined (zoms) && zoms.size > 0)
			{
				a_zombies = util::get_array_of_closest (self.origin, zoms, undefined, undefined, PHD_SLIDER_RANGE_MAX);
			
				if (IsDefined (a_zombies) && a_zombies.size > 0)
				{
					if (Distance (a_zombies[0].origin, self.origin) <= PHD_SLIDER_RANGE_MIN &&
						(!IsDefined (a_zombies[0].ai_too_op_for_phd_slider) || a_zombies[0].ai_too_op_for_phd_slider == 0))
					{
						ready_to_explode = 0;
						
						self.phd_slider_power = 0;
						self thread slider_recharge_bar();
						
						PlayFx (PHD_SLIDER_FX_EXPLOSION, self.origin, self.angles);
						
						foreach (zombie in a_zombies)
						{
							if (IsDefined (zombie) && IsAlive (zombie))
							{
								zombie zombie_utility::gib_random_parts();		
								zombie zombie_utility::gib_random_parts();		
								GibServerUtils::Annihilate (zombie);			
								zombie zm_spawner::zombie_explodes_intopieces (false);
								
								if (IsDefined (zombie GetTagOrigin ("j_spineupper")))
									PlayFxOnTag (PHD_SLIDER_FX_FIRE, zombie, "j_spineupper");
								
								zombie DoDamage (zombie.health + 666, zombie.origin, self, self, "none", "MOD_BURNED");
							}
						}
					}
				}
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function slider_recharge_bar()
{
	//SELF == PLAYER
	
	self.phd_slider_on_cooldown = 1;
	
	self notify ("cooldown_bar_update");
	
	while (self.phd_slider_power < PHD_SLIDER_MAX_POWER)
	{
		bar_height = (self.phd_slider_power / PHD_SLIDER_MAX_POWER) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.phd_slider_bar))
			self.phd_slider_bar ScaleOverTime (.1, COOLDOWN_BAR_WIDTH, bar_height);
		
		wait .1;
	}
	
	self.phd_slider_on_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Pickpocket Paloma
// ======================================================================================================

function pickpocket_give_ammo ()
{
	//SELF == PLAYER

	weapon = self GetCurrentWeapon();
	
	// Check to see if ammo belongs to a primary weapon
	if (IsDefined (weapon) && !zm_utility::is_offhand_weapon (weapon))
	{
		clip_size = 0;
		give_ammo = 0;
		
		if (IsDefined (weapon.clipsize) && weapon.clipsize > 0)
			clip_size += weapon.clipsize;
			
		if ((IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone) &&
			(IsDefined (weapon.dualwieldweapon.clipsize) && weapon.dualwieldweapon.clipsize > 0))
			clip_size += weapon.dualwieldweapon.clipsize;
		
		if (clip_size > 0)
		{
			if (clip_size < PICKPOCKET_AMMO_CLIP_LOW)
				give_ammo = PICKPOCKET_AMMO_GIVE_LOW;
		
			else if (clip_size >= PICKPOCKET_AMMO_CLIP_LOW && clip_size < PICKPOCKET_AMMO_CLIP_HIGH)
				give_ammo = PICKPOCKET_AMMO_GIVE_MID;
				
			else if (clip_size >= PICKPOCKET_AMMO_CLIP_HIGH)
				give_ammo = PICKPOCKET_AMMO_GIVE_HIGH;
				
			give_ammo *= PICKPOCKET_AMMO_GIVE_MULTIPLIER;
			
			self thread common_give_ammo (weapon, give_ammo);
			
			self PlaySoundToPlayer (PICKPOCKET_PICKUP_SOUND, self);
		}
		
		else
			self thread pickpocket_give_points();
	}
	
	else
		self thread pickpocket_give_points();
}

function pickpocket_give_points ()
{
	//SELF == PLAYER

	points = RandomIntRange (PICKPOCKET_POINTS_RANGE_LOW, (PICKPOCKET_POINTS_RANGE_HIGH + 1));
	points *= PICKPOCKET_POINTS_GIVE_MULTIPLIER;
	
	self thread common_give_points (points);
	
	self PlaySoundToPlayer (PICKPOCKET_PICKUP_SOUND, self);
}

function pickpocket_give_powerup (attacker)
{
	//SELF == PLAYER
	//ATTACKER == AI
	
	drop_point = attacker.origin;

	for (i = 0; i < PICKPOCKET_POWERUP_GIVE_MULTIPLIER; i++)
	{
		if (PICKPOCKET_POWERUP_RESTRICT == 1)
		{
			PlayFx (level._effect ["lightning_dog_spawn"], drop_point);
			PlaySoundAtPosition ("zmb_hellhound_prespawn", drop_point);
			wait 1.5;
			PlaySoundAtPosition ("zmb_hellhound_bolt", drop_point);

			Earthquake (0.5, 0.75, drop_point, 1000);
			PlaySoundAtPosition ("zmb_hellhound_spawn", drop_point);
			
			zm_powerups::specific_powerup_drop (array::random (PICKPOCKET_POWERUP_RESTRICT_LIST), drop_point);
		}
		
		else
			zm_powerups::special_powerup_drop (drop_point);
	}
}


// ======================================================================================================
// Power Aid Punch
// ======================================================================================================

function power_aid_punch_grenade_split (grenade, weapon)
{
	//SELF == PLAYER
	
	self endon ("grenade_dud");
	self endon ("explode");
	
	grenade thread power_aid_punch_grenade_timeout();
	
	grenade util::waittill_any_return ("grenade_bounce", "grenade_stuck", "detonate", "stationary", "explode", "power_aid_punch_timeout");
	
	if (IsDefined (grenade))
	{
		if (IsDefined (grenade.threwBack) && grenade.threwBack)
			return;
			
		self thread power_aid_punch_spawn_grenades (grenade.origin, weapon);
	}
}

function power_aid_punch_spawn_grenades (split_spawn_point, weapon)
{
	//SELF == PLAYER
	
	for (i = 0; i < POWER_AID_PUNCH_GRENADE_SPLIT_COUNT; i++)
	{
		if (IsDefined (weapon))
		{
			vector_x = RandomIntRange (-POWER_AID_PUNCH_GRENADE_SPLIT_X, POWER_AID_PUNCH_GRENADE_SPLIT_X + 1);
			vector_y = RandomIntRange (-POWER_AID_PUNCH_GRENADE_SPLIT_Y, POWER_AID_PUNCH_GRENADE_SPLIT_Y + 1);
			vector_z = RandomIntRange (-POWER_AID_PUNCH_GRENADE_SPLIT_Z, POWER_AID_PUNCH_GRENADE_SPLIT_Z + 1);
			
			split_grenade = self MagicGrenadeType (weapon, split_spawn_point, VectorScale ((vector_x, vector_y, vector_z), 100), POWER_AID_PUNCH_GRENADE_FUSE_TIME);
			
			if (IsDefined (split_grenade))
			{
				split_grenade.power_aid_punch_split = 1;
				
				PlayFxOnTag (POWER_AID_PUNCH_HIT_LOC_FX, split_grenade, "tag_origin");
				
				if (IsDefined (level.w_glitching_gin_grenade) && weapon == level.w_glitching_gin_grenade)
					split_grenade thread glitch_grenade_bounce (self);
			}
		}
		
		wait .15;
	}
}

function power_aid_punch_grenade_timeout ()
{
	//SELF == GRENADE
	
	self endon ("grenade_dud");
	self endon ("explode");
	
	wait POWER_AID_PUNCH_GRENADE_SPLIT_DELAY;
	
	if (IsDefined (self))
		self notify ("power_aid_punch_timeout");
}

function power_aid_punch_impact_fx (sHitLoc, attacker)
{
	//SELF == AI
	//ATTACKER == PLAYER
		
	tag_for_fx = bullet_impact_get_tag_location (sHitLoc);
	
	if (IsDefined (self GetTagOrigin (tag_for_fx)))
	{
		PlayFXOnTag (POWER_AID_PUNCH_HIT_LOC_FX, self, tag_for_fx);
		PlaySoundAtPosition (POWER_AID_PUNCH_HIT_LOC_SOUND, self GetTagOrigin (tag_for_fx));
	}
}


// ======================================================================================================
// Rebate Rosé
// ======================================================================================================

function global_check_for_purchases()
{
    self endon ("game_over");
    self endon ("end_game");
    self endon ("intermission");
	
    self notify ("kill_purchase_check");
    self endon ("kill_purchase_check");
	
    for (;;)
    {
		level waittill ("spent_points", player, n_points);
		
		if (IsDefined (player.west_hasperk_rebate_rose) && player.west_hasperk_rebate_rose == 1)
			player thread rebate_rose_give_rebate (n_points);
    }
}

function rebate_rose_give_rebate (spent_points)
{
	//SELF = PLAYER
	
	rebate_points = spent_points * REBATE_ROSE_PERCENT_TO_REBATE;
	
	if (!IsInt (rebate_points))
		rebate_points = Int (rebate_points);
		
	wait 1;
	
	self thread common_give_points (rebate_points);
}

function rebate_rose_give_bonus_for_kill ()
{
	//SELF == PLAYER
	
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	if (!IsPlayer (self))
		return;
	
	bonus_points = zm_utility::round_up_to_ten (REBATE_ROSE_BONUS_POINTS);
	
	while (bonus_points > 0)
	{
		wait .1;
		
		self thread common_give_points (10);
		
		bonus_points -= 10;
	}
}


// ======================================================================================================
// Salvage Shake
// ======================================================================================================

function salvage_shake_think()
{
	//SELF == PLAYER
	
	self endon (SALVAGE_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	if (!IsPlayer (self))
		return;
		
	for (;;)
	{
		list_of_weapons = self GetWeaponsList (1);
		current_weapon = self GetCurrentWeapon();
		
		foreach (weapon in list_of_weapons)
			if (weapon != zm_weapons::get_base_weapon (current_weapon) && !zm_utility::is_offhand_weapon (weapon))
				self thread salvage_shake_ammo_calc (weapon);
		
		self util::waittill_any_return ("weapon_give", "weapon_take", "weapon_change");
		self notify ("salvage_shake_stop_tracking");
	}
}

function salvage_shake_ammo_calc (weapon)
{
	//SELF == PLAYER
	
	self endon (SALVAGE_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("salvage_shake_stop_tracking");
	
	full_clip = 0;
	full_stock = 0;
	
	if (IsDefined (weapon.clipsize) && weapon.clipsize > 0)
		full_clip = weapon.clipsize;
	
	if (IsDefined (weapon.maxAmmo) && weapon.maxAmmo > 0)
		full_stock = weapon.maxAmmo;
		
	stockpile_sum = full_clip + full_stock;
	
	if (IsDefined (weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone)
	{
		full_clipdw = weapon.dualwieldweapon.clipsize;
		
		stockpile_sum += full_clipdw;
	}
	
	//Include Bandolier Stocksize in Calc
	if (IsDefined (self.west_hasperk_bandolier_bandit) && self.west_hasperk_bandolier_bandit == 1)
		stockpile_sum += bandolier_bandit_get_stocksize (weapon);
	
	//Only give ammo if weapon has a stock capacity
	if (stockpile_sum > 0)
	{
		ammo_per_cycle = (stockpile_sum * SALVAGE_SHAKE_PERCENT) + 1;
		
		//Apply a penalty to wonder weapons
		if (SALVAGE_SHAKE_NERF_WW == 1 && zm_weapons::is_wonder_weapon (weapon))
			ammo_per_cycle *= SALVAGE_SHAKE_NERF_WW_PERCENT;
		
		if (ammo_per_cycle < 1)
			ammo_per_cycle = 1;
			
		if (!IsInt (ammo_per_cycle))
			ammo_per_cycle = Int (ammo_per_cycle);	
		
		for (;;)
		{
			wait SALVAGE_SHAKE_INTERVAL;
			
			//Check if still holding weapon, can be lost without notify
			if (self HasWeapon (weapon, true) && self GetCurrentWeapon() != weapon)
				common_give_ammo (weapon, ammo_per_cycle, false);
				
			else
				break;
		}
	}
}


// ======================================================================================================
// Slip-Away Slushee
// ======================================================================================================

function slip_away_setup_spawn_points ()
{
	//SELF == LEVEL
	
	level endon ("end_game");
	level endon ("game_over");
	
	//Wait for zones and flags to be setup
	wait 1;
	
	perk_machine_structs = struct::get_array ("zm_perk_machine", "targetname");
	
	//Remove Slip-Away Slushee from custom perk array if no perk machines are on the map
	if (!IsDefined (perk_machine_structs) || perk_machine_structs.size < 1)
	{
		level._custom_perks = Array::remove_index (level._custom_perks, SLIP_AWAY_PERK, 1);
		
		return;
	}
	
	level.slip_away_spawn_points = [];
	
	foreach (machine_struct in perk_machine_structs)
	{
		position = machine_struct.origin + (SLIP_AWAY_TELE_DISTANCE_FROM_PERK * Sin (machine_struct.angles [1]), SLIP_AWAY_TELE_DISTANCE_FROM_PERK * -Cos (machine_struct.angles [1]), SLIP_AWAY_TELE_HEIGHT);
		
		zone = zm_zonemgr::get_zone_from_position (position, true);
			
		if (IsDefined (zone))
			level.slip_away_spawn_points [level.slip_away_spawn_points.size] = position;
	}
}

function slip_away_teleport_player ()
{
	//SELF == PLAYER
	
	if (level.slip_away_spawn_points.size < 1)
	{
		self IPrintLnBold ("Slip Away: No Valid Spawn Points");
			
		return;
	}
	
	player_teleported = 0;
	
	zoms = GetAITeamArray (level.zombie_team);
	
	preferred_spawns = [];
	
	for (i = 0; i < level.slip_away_spawn_points.size; i++)
	{
		zone = zm_zonemgr::get_zone_from_position (level.slip_away_spawn_points [i], false);
			
		if (!IsDefined (zone))
			continue;
		
		if (Distance (self.origin, level.slip_away_spawn_points [i]) > SLIP_AWAY_TELE_PREF_DIST_AWAY)
		{		
			if (PositionWouldTelefrag (level.slip_away_spawn_points [i]))
				continue;
				
			if (!PlayerPositionValid (level.slip_away_spawn_points [i]))
				continue;
				
			preferred_spawns [preferred_spawns.size] = level.slip_away_spawn_points [i];
		}
	}
	
	if (preferred_spawns.size > 0)
	{
		self SetOrigin (preferred_spawns [RandomIntRange (0, preferred_spawns.size)]);
		self SetVelocity ((0, 0, 0));
		
		player_teleported = 1;
	}
	
	//No spawns are ideal
	else
	{
		less_than_ideal_spawns = [];
		
		for (i = 0; i < level.slip_away_spawn_points.size; i++)
		{
			zone = zm_zonemgr::get_zone_from_position (level.slip_away_spawn_points [i], false);
				
			if (!IsDefined (zone))
				continue;
				
			if (PositionWouldTelefrag (level.slip_away_spawn_points [i]))
				continue;
				
			if (!PlayerPositionValid (level.slip_away_spawn_points [i]))
				continue;
				
			less_than_ideal_spawns [less_than_ideal_spawns.size] = level.slip_away_spawn_points [i];
		}
		
		if (less_than_ideal_spawns.size > 0)
		{
			if (SLIP_AWAY_PLAY_SOUNDS == 1)
				PlaySoundAtPosition (SLIP_AWAY_TELEPORT_OUT_SOUND, self.origin);
			
			self SetOrigin (less_than_ideal_spawns [RandomIntRange (0, less_than_ideal_spawns.size)]);
			self SetVelocity ((0, 0, 0));
			
			player_teleported = 1;
		}
	}
	
	if (player_teleported == 1)
	{
		self thread community_perk_collection::slip_away_take_perk (false, SLIP_AWAY_PERK + "_stop", SLIP_AWAY_PERK + "_stop");
		
		if (SLIP_AWAY_PLAY_SOUNDS == 1)
			self PlaySound (SLIP_AWAY_TELEPORT_IN_SOUND);
			
		if (IsDefined (zoms) && zoms.size > 0)
		{
			a_zombies = util::get_array_of_closest (self.origin, zoms, undefined, undefined, SLIP_AWAY_ZOMBIE_RANGE);
		
			if (IsDefined (a_zombies) && a_zombies.size > 0)
			{
				if (SLIP_AWAY_PLAY_SOUNDS == 1)
					self PlaySound (MADGAZ_MOONSHINE_EXPLOSION_SOUND);
					
				PlayFx (MADGAZ_MOONSHINE_EXPLOSION_FX, self.origin);
				
				foreach (zombie in a_zombies)
				{
					if (!IsAlive (zombie))
						continue;
						
					//If AI is NOT protected from Slip-Away Slushee
					if (!IsDefined (zombie.ai_too_op_for_slip_away) || zombie.ai_too_op_for_slip_away == 0)
					{
						angles_forward = AnglesToForward (zombie.angles);
						velocity = VectorScale (-angles_forward, 100);
					
						zombie zombie_utility::gib_random_parts();
						zombie zombie_utility::gib_random_parts();
						GibServerUtils::Annihilate (zombie);
						zombie zm_spawner::zombie_explodes_intopieces (false);
							
						zombie DoDamage (zombie.health + 666, zombie.origin, self, self, "none", "MOD_BURNED");
						zombie StartRagdoll(); 
						zombie LaunchRagdoll (velocity + (0, 0, 40));
					}
				}
			}
		}
	}
}


// ======================================================================================================
// Slurpentine
// ======================================================================================================

function slurpentine_speed_function ()
{
	//SELF == PLAYER
	
	self endon (SLURPENTINE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if (IsDefined (self.slurpentine_boost_time) && self.slurpentine_boost_time > 0)
		{
			while (IsDefined (self.slurpentine_boost_time) && self.slurpentine_boost_time > 0)
			{
				if (!IsDefined (self.slurpentine_should_boost) || self.slurpentine_should_boost == 0)
					self.slurpentine_should_boost = 1;
					
				self.slurpentine_boost_time -= .05;
				
				if (self.slurpentine_boost_time < 0)
					self.slurpentine_boost_time = 0;
					
				WAIT_SERVER_FRAME;
			}
		}
		
		if (IsDefined (self.slurpentine_should_boost) && self.slurpentine_should_boost == 1)
			self.slurpentine_should_boost = 0;
		
		WAIT_SERVER_FRAME;
	}
}

function slurpentine_poison (player, shield_did_poison)
{
	//SELF == AI
	
	level endon ("end_game");
	level endon ("game_over");
	
	self notify ("slurpentine_poison_function");
	self endon ("slurpentine_poison_function");
	
	state = self clientfield::get ("slurpentine_zombie_eye_change");
	
	if (IsDefined (state) && state != 1)
		self clientfield::set ("slurpentine_zombie_eye_change", 1);
		
	PlaySoundAtPosition (SLURPENTINE_SOUND_VENOM_START, self.origin);
	
	if (!IsDefined (self.slurpentine_poison_fx))
	{
		if (IsDefined (self GetTagOrigin ("j_spineupper")))
			poison_fx = Spawn ("script_model", self GetTagOrigin ("j_spineupper"));
			
		else
			poison_fx = Spawn ("script_model", self.origin + (0, 0, 35));
			
		poison_fx SetModel ("tag_origin");
		poison_fx EnableLinkTo();
		poison_fx LinkTo (self, "tag_origin");
		
		PlayFXOnTag (SLURPENTINE_FX_VENOM, poison_fx, "tag_origin");
		
		self.slurpentine_poison_fx = poison_fx;
	}
	
	self.slurpentine_poison_time = SLURPENTINE_POISON_DURATION;
		
	while (self.slurpentine_poison_time > 0)
	{
		if (!IsDefined (self) || 
			!IsAlive (self) || 
			!IsDefined (self.health) || 
			!IsDefined (self.maxhealth))
			break;
		
		if (shield_did_poison == 0)
			damage = (self.maxhealth * SLURPENTINE_POISON_TICK_DAMAGE) + 1;
			
		else
			damage = (self.maxhealth * SLURPENTINE_POISON_TICK_SHIELD) + 1;
		
		if (!IsInt (damage))
			damge = Int (damage);
		
		self DoDamage (damage, self.origin, player, player, "none", "MOD_GAS");
		
		PlaySoundAtPosition (SLURPENTINE_SOUND_VENOM_TICK, self.origin);
		
		self.slurpentine_poison_time -= SLURPENTINE_POISON_TICK_CYCLE;
		
		wait SLURPENTINE_POISON_TICK_CYCLE;
	}
	
	if (IsDefined (self) && IsAlive (self))
	{
		state = self clientfield::get ("slurpentine_zombie_eye_change");
		
		if (IsDefined (state) && state != 0)
			self clientfield::set ("slurpentine_zombie_eye_change", 0);
			
		if (IsDefined (self.slurpentine_is_poisoned) && self.slurpentine_is_poisoned == 1)
			self.slurpentine_is_poisoned = 0;
	}
	
	if (IsDefined (self.slurpentine_poison_fx))
		self.slurpentine_poison_fx Delete();
}


// ======================================================================================================
// Snail's Pace Slurpee
// ======================================================================================================

function snails_pace_logic ()
{
	//SELF == PLAYER
	
	self endon (SNAILS_PACE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		zoms = GetAITeamArray (level.zombie_team);
		
		if (IsDefined (zoms) && zoms.size > 0)
		{
			foreach (zom in zoms)
			{
				state = zom clientfield::get ("snails_pace_zombie_eye_change");
			
				if (Distance (self.origin, zom.origin) <= SNAILS_PACE_RANGE_MAX &&
					Distance (self.origin, zom.origin) >= SNAILS_PACE_RANGE_MIN &&
					(!IsDefined (zom.ai_too_op_for_snails_pace) || zom.ai_too_op_for_snails_pace == 0)) //If AI is NOT protected from Snail's Pace Slurpee
				{
					zom thread zm_utility::slowdown_ai ("snails_pace_slowdown");
					
					if (IsDefined (state) && state != 1)
						zom clientfield::set ("snails_pace_zombie_eye_change", 1);
				}
					
				else
					if (IsDefined (state) && state != 0)
						zom clientfield::set ("snails_pace_zombie_eye_change", 0);
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}


// ======================================================================================================
// Space Cadet Cola
// ======================================================================================================

function space_cadet_main()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self thread space_cadet_cooldown_complete ();
	self thread space_count_kills ();

	for (;;)
	{
		old_num_nades = self GetWeaponAmmoClip (self.current_lethal_grenade);
		
        self waittill ("space_cadet_ai_damage_taken");
		
		num_zombies = (zombie_utility::get_current_zombie_count() + level.zombie_total);
		
		if (self.space_cadet_on_cooldown || self.space_cadet_still_need_kills == 1)
			continue;
		
		else if (num_zombies < SPACE_CADET_NO_HIT_TRIG)
			continue;
		
		else if ((self HasPerk (PERK_WIDOWS_WINE) || self HasPerk (PERK_WIDOWS_WINE)) && widows_glitching_triggered (old_num_nades))
			continue;
		
		else
			self space_check_number_hits ();
	}
}

function space_cadet_cooldown_complete ()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("space_cadet_activated");
		self waittill ("space_cadet_cooldown_start");
		
		self thread space_cadet_cooldown_bar();
	
		while (self.space_cadet_on_cooldown == true || self.space_cadet_still_need_kills == 1)
			wait 1;
			
		if (SPACE_CADET_PLAY_SOUNDS == 1)
			self PlaySoundToPlayer (SPACE_CADET_SOUND_COOLDOWN_OVER, self); // Perk cooldown finish noise
		
		self notify ("cooldown_bar_update");
	}
}

function space_count_kills()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("space_cadet_ai_killed");
		
		if (self.space_cadet_kills_count < SPACE_CADET_KILLS_NEEDED)
			self.space_cadet_kills_count++;
		
		else
			self.space_cadet_still_need_kills = 0;
	}
}

function space_cadet_cooldown_bar()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	while (self.space_cadet_kills_count < SPACE_CADET_KILLS_NEEDED || self.space_cadet_on_cooldown == true)
	{
		if (IsDefined (self.space_cadet_bar_kills))
		{
			bar_height_kills = (self.space_cadet_kills_count / SPACE_CADET_KILLS_NEEDED) * COOLDOWN_BAR_HEIGHT;
			
			if (bar_height_kills < 1)
				bar_height_kills = 1;
				
			else if (bar_height_kills > COOLDOWN_BAR_HEIGHT)
				bar_height_kills = COOLDOWN_BAR_HEIGHT;
				
			if (!IsInt (bar_height_kills))
				bar_height_kills = Int (bar_height_kills);
				
			self.space_cadet_bar_kills ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height_kills);
		}
		
		if (IsDefined (self.space_cadet_bar_time))
		{
			bar_height_time = (self.space_cadet_cooldown_time / SPACE_CADET_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
			
			if (bar_height_time < 1)
				bar_height_time = 1;
				
			else if (bar_height_time > COOLDOWN_BAR_HEIGHT)
				bar_height_time = COOLDOWN_BAR_HEIGHT;
				
			if (!IsInt (bar_height_time))
				bar_height_time = Int (bar_height_time);
				
			self.space_cadet_bar_time ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height_time);
		}
	
		wait .5;
	}
}

function widows_glitching_triggered (old_num_nades)
{
	//SELF == PLAYER

	new_num_nades = self GetWeaponAmmoClip (self.current_lethal_grenade);
	
	if (old_num_nades + new_num_nades > 0)
		return true;
	
	else
		return false;
}

function space_check_number_hits ()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("space_cadet_timer_end"); // Stop execution if the timer runs out
	
	if (!self HasPerk (PERK_JUGGERNOG) || (!IsDefined (self.west_hasperk_verruckt_jug) || self.west_hasperk_verruckt_jug == 0))
	{
		if (SPACE_CADET_NO_JUGG_HITS > 1)
		{
			for (i = 1; i < SPACE_CADET_NO_JUGG_HITS; i++)
			{
				self thread space_cadet_counter (SPACE_CADET_HIT_TIME);
				self waittill ("space_cadet_ai_damage_taken");
			}
			
			self thread activate_space_time ();
		}
		
		else
			self thread activate_space_time ();
	}
	
	else
	{
		if (SPACE_CADET_JUGG_HITS > 1)
		{
			for (i = 1; i < SPACE_CADET_JUGG_HITS; i++)
			{
				self thread space_cadet_counter (SPACE_CADET_HIT_TIME);
				self waittill ("space_cadet_ai_damage_taken");
			}
			
			self thread activate_space_time ();
		}
		
		else
			self thread activate_space_time ();
	}
}

function activate_space_time ()
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self notify ("space_cadet_activated");
	
	self zm_utility::increment_ignoreme();
	
	self.space_cadet_activated = 1;
	
	self notify ("cooldown_bar_update");
	
	if (SPACE_CADET_PLAY_SOUNDS == 1)
		self PlaySoundToPlayer (SPACE_CADET_SOUND_ACTIVATE, self);
	
	self space_wait_effect_done (SPACE_CADET_EFFECT_DURATION);
	
	self thread space_cadet_cooldown ();
}

function space_wait_effect_done (time)
{
	//SELF == PLAYER

	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	visionset_mgr::activate ("visionset", "space_cadet_hidden", self, 0.5, 30, 0.5);
	visionset_mgr::activate ("overlay", "space_cadet_hidden", self);

	while (time > 0)
	{
		wait .5;
		time -= .5;
		
		bar_height = (time / SPACE_CADET_EFFECT_DURATION) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.space_cadet_bar_kills))
			self.space_cadet_bar_kills ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
		
		if (IsDefined (self.space_cadet_bar_time))
			self.space_cadet_bar_time ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
	
	visionset_mgr::deactivate ("visionset", "space_cadet_hidden", self);
	visionset_mgr::deactivate ("overlay", "space_cadet_hidden", self);
	
	self zm_utility::decrement_ignoreme();
	
	self notify ("space_cadet_cooldown_start");
}

function space_cadet_cooldown ()
{
	//SELF == PLAYER
	
	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	if (SPACE_CADET_PLAY_SOUNDS == 1)
		self PlaySoundToPlayer (SPACE_CADET_SOUND_COOLDOWN_START, self);
	
	self.space_cadet_kills_count = 0;
	self.space_cadet_on_cooldown = true;
	self.space_cadet_still_need_kills = 1;
	self.space_cadet_activated = 0;
	self.space_cadet_cooldown_time = SPACE_CADET_COOLDOWN;
	
	while (self.space_cadet_cooldown_time > 0)
	{
		wait .5;
		self.space_cadet_cooldown_time -= .5;
	}
	
	self.space_cadet_on_cooldown = false;
}

function space_cadet_counter (time)
{
	self endon (SPACE_CADET_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("space_cadet_ai_damage_taken");
	
	for (i = 0; i < time; i++)
		wait 1;
		
	self notify ("space_cadet_timer_end");
}


// ======================================================================================================
// Spectral Shake
// ======================================================================================================

function spectral_shake_think ()
{
	//SELF == PLAYER
	
	self thread spectral_shake_activate_watcher();
	self thread spectral_shake_speed_boost();
}

function spectral_shake_activate_watcher ()
{
	//SELF == PLAYER
	
	self endon (SPECTRAL_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	charge = 0;
	
	for (;;)
	{
		if ((IsDefined (self.spectral_shake_active) && self.spectral_shake_active == 0) && 
			(IsDefined (self.spectral_shake_cooldown) && self.spectral_shake_cooldown == 0) && 
			self GetStance() == "prone")
		{
			while ((IsDefined (self.spectral_shake_active) && self.spectral_shake_active == 0) && 
					(IsDefined (self.spectral_shake_cooldown) && self.spectral_shake_cooldown == 0) && 
					self GetStance() == "prone")
			{
				WAIT_SERVER_FRAME;
				charge += .05;
					
				if (charge >= SPECTRAL_SHAKE_ACTIVATION_TIME)
				{
					self.spectral_shake_active = 1;
					
					self thread spectral_shake_activate();
					self thread spectral_shake_cooldown();
					self thread spectral_shake_watch_for_stand();
					
					break;
				}
			}
			
			charge = 0;
		}
		
		WAIT_SERVER_FRAME;
	}
}

function spectral_shake_activate ()
{
	//SELF == PLAYER
	
	self endon (SPECTRAL_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("spectral_shake_start_cooldown");
	
	self notify ("cooldown_bar_update");
	
	self zm_utility::increment_ignoreme();
	
	if (SPECTRAL_SHAKE_PLAY_SOUNDS == 1)
	{
		self PlaySound (SPECTRAL_SHAKE_SOUND_START);
		self PlayLoopSound (SPECTRAL_SHAKE_SOUND_LOOP, 1);
	}
	
	visionset_mgr::activate ("visionset", "spectral_shake_hidden", self, 0.5, 30, 0.5);
	visionset_mgr::activate ("overlay", "spectral_shake_hidden", self);
	
	time = 0;

	while (time < SPECTRAL_SHAKE_DURATION)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / SPECTRAL_SHAKE_DURATION) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
		
		if (IsDefined (self.spectral_shake_bar))
			self.spectral_shake_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
	}
	
	self notify ("spectral_shake_start_cooldown");
}

function spectral_shake_watch_for_stand ()
{
	//SELF == PLAYER
	
	self endon (SPECTRAL_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self endon ("spectral_shake_start_cooldown");
	
	time = 0;

	for (;;)
	{
		if (self GetStance() == "stand")
			break;
			
		WAIT_SERVER_FRAME;
	}
	
	self notify ("spectral_shake_start_cooldown");
}

function spectral_shake_cooldown ()
{
	//SELF == PLAYER
	
	self endon (SPECTRAL_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self waittill ("spectral_shake_start_cooldown");
	
	self.spectral_shake_active = 0;
	self.spectral_shake_cooldown = 1;
	
	self notify ("cooldown_bar_update");
	
	if (SPECTRAL_SHAKE_PLAY_SOUNDS == 1)
	{
		self StopLoopSound (1);
		self PlaySound (SPECTRAL_SHAKE_SOUND_END);
	}
	
	visionset_mgr::deactivate ("visionset", "spectral_shake_hidden", self);
	visionset_mgr::deactivate ("overlay", "spectral_shake_hidden", self);
	
	self zm_utility::decrement_ignoreme();
	
	time = 0;
	
	while (time < SPECTRAL_SHAKE_COOLDOWN_TIME)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / SPECTRAL_SHAKE_COOLDOWN_TIME) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.spectral_shake_bar))
			self.spectral_shake_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
	
	self.spectral_shake_cooldown = 0;
}

function spectral_shake_speed_boost ()
{
	//SELF == PLAYER
	
	self endon (SPECTRAL_SHAKE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		if ((self GetStance() == "crouch" && self IsOnSlide() == false) || (self GetStance() == "prone"))
		{
			while ((self GetStance() == "crouch" && self IsOnSlide() == false) || (self GetStance() == "prone"))
			{
				if (!IsDefined (self.spectral_shake_should_boost) || self.spectral_shake_should_boost == 0)
					self.spectral_shake_should_boost = 1;
				
				WAIT_SERVER_FRAME;					
			}
			
			if (IsDefined (self.spectral_shake_should_boost) && self.spectral_shake_should_boost == 1)
				self.spectral_shake_should_boost = 0;
		}
		
		WAIT_SERVER_FRAME;
	}
}


// ======================================================================================================
// Stone Cold Stronghold
// ======================================================================================================

function stone_cold_think ()
{
	//SELF == PLAYER
	
	self endon (STONE_COLD_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	stand_still_stage = 0;
	
	self.center_fx = undefined;
	self.ring_fx = undefined;
	
	for (;;)
	{
		if (!IsDefined (self.center_fx))
		{
			self.center_fx = Spawn ("script_model", self.origin + (0, 0, 5));
			self.center_fx SetModel ("tag_origin");
		}
		
		else
		{
			if (stand_still_stage < 2)
			{
				if (Distance (self.center_fx.origin, self.origin) < 10)
					stand_still_stage += 1;
				
				else
				{
					stand_still_stage = 0;
					self.center_fx delete();
				}
			}
			
			if (stand_still_stage == 2)
			{
				self.ring_fx = Spawn ("script_model", self.origin + (0, 0, 5));
				self.ring_fx SetModel ("tag_origin");
				self.ring_fx.angles = self.angles + (-90, 0, 0);
				
				PlayFxOnTag (STONE_COLD_RING_FX, self.ring_fx, "tag_origin");
			
				if (!IsDefined (self.stone_cold_armor) || self.stone_cold_armor <= 0)
					self.stone_cold_armor = STONE_COLD_ARMOR_PER_CYCLE;
					
				self thread stone_cold_progress_bar();
				
				while (Distance (self.center_fx.origin, self.origin) < STONE_COLD_RANGE && self.stone_cold_armor > 0)
				{
					if (self.stone_cold_armor != STONE_COLD_MAX_ARMOR)
					{
						if (self.stone_cold_armor + STONE_COLD_ARMOR_PER_CYCLE < STONE_COLD_MAX_ARMOR)
							self.stone_cold_armor += STONE_COLD_ARMOR_PER_CYCLE;
						
						else if (self.stone_cold_armor + STONE_COLD_ARMOR_PER_CYCLE > STONE_COLD_MAX_ARMOR)
							self.stone_cold_armor = STONE_COLD_MAX_ARMOR;
					}
					
					wait STONE_COLD_CYCLE_TIME;
				}
				
				if (IsDefined (self.center_fx))
					self.center_fx delete();
				
				if (IsDefined (self.ring_fx))
					self.ring_fx delete();
				
				self.stone_cold_armor = 0;
				stand_still_stage = 0;
				
				wait STONE_COLD_COOLDOWN;
			}
		}
		
		wait 1;
	}
}

function stone_cold_progress_bar ()
{
	//SELF == PLAYER
	
	self endon (STONE_COLD_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self notify ("cooldown_bar_update");

	while (IsDefined (self.stone_cold_armor) && self.stone_cold_armor > 0)
	{
		bar_height = (self.stone_cold_armor / STONE_COLD_MAX_ARMOR) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
		
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.stone_cold_bar))
			self.stone_cold_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
			
		wait .5;
	}
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Tactiquilla Sangria
// ======================================================================================================

function tactiquilla_think ()
{
	//SELF == PLAYER
	
	self thread tactiquilla_regain_ammo ();
	self thread tactiquilla_regain_grenades ();	
}

function tactiquilla_regain_ammo ()
{
	//SELF == PLAYER

	self endon (TACTIQUILLA_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_fired", weapon);
		
		exclude = 0;
		
		if (TACTIQUILLA_WEAPON_EXLUSION_LIST.size > 0)
			for (i = 0; i < TACTIQUILLA_WEAPON_EXLUSION_LIST.size; i++)
				if (weapon.name == TACTIQUILLA_WEAPON_EXLUSION_LIST [i])
					exclude = 1;
					
		if (exclude == 1)
			continue;
		
		if (RandomIntRange (1, 101) <= TACTIQUILLA_REGAIN_AMMO_CHANCE)
			common_give_ammo (weapon, TACTIQUILLA_AMMO_TO_GIVE);
	}
}

function tactiquilla_regain_grenades ()
{
	//SELF == PLAYER

	self endon (TACTIQUILLA_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("grenade_fire", grenade, weapon);
		
		if (IsDefined (grenade.phd_flopper_split) && grenade.phd_flopper_split == 1)
			continue;
			
		if (IsDefined (grenade.power_aid_punch_split) && grenade.power_aid_punch_split == 1)
			continue;
	
		exclude = 0;
		
		if (TACTIQUILLA_WEAPON_EXLUSION_LIST.size > 0)
			for (i = 0; i < TACTIQUILLA_WEAPON_EXLUSION_LIST.size; i++)
				if (weapon.name == TACTIQUILLA_WEAPON_EXLUSION_LIST [i])
					exclude = 1;
					
		if (exclude == 1)
			continue;
					
		if (RandomIntRange (1, 101) <= TACTIQUILLA_REGAIN_AMMO_CHANCE && 
			(self zm_utility::is_player_tactical_grenade (weapon) || self zm_utility::is_player_lethal_grenade (weapon)))
			common_give_ammo (weapon, TACTIQUILLA_AMMO_TO_GIVE);
	}
}


// ======================================================================================================
// Time Out Tequila
// ======================================================================================================

function time_out_laststand()
{
	// SELF = PLAYER
	// I Was Revived

	self endon ("bled_out");

	self.west_hasperk_time_out = 0;
	
	self.time_out_active = 1;
	
	self zm_utility::increment_ignoreme();
	
	visionset_mgr::activate ("visionset", "time_out_hidden", self, 0.5, 30, 0.5);
	visionset_mgr::activate ("overlay", "time_out_hidden", self);
	
	self notify ("cooldown_bar_update");
	WAIT_SERVER_FRAME;
		
	self PlaySoundToPlayer (TIME_OUT_ACTIVE_SOUND, self);
	
	time = 0;
	
	while (time < TIME_OUT_HIDDEN_TIME)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / TIME_OUT_HIDDEN_TIME) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
		
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
		
		if (IsDefined (self.time_out_bar))
			self.time_out_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
	}
		
	self.time_out_active = 0;
	
	if (IsDefined (self.time_out_bar_back))
		self.time_out_bar_back Destroy();
			
	if (IsDefined (self.time_out_bar))
		self.time_out_bar Destroy();
			
	if (IsDefined (self.time_out_icon))
		self.time_out_icon Destroy();
		
	self notify ("cooldown_bar_update");
		
	self zm_utility::decrement_ignoreme();
	
	visionset_mgr::deactivate ("visionset", "time_out_hidden", self);
	visionset_mgr::deactivate ("overlay", "time_out_hidden", self);
}

function time_out_reviver()
{
	// SELF = PLAYER
	// I Revived You
	
	self endon (TIME_OUT_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("player_did_a_revive", revivee);
		
		self.time_out_active = 1;
		
		self zm_utility::increment_ignoreme();
		
		visionset_mgr::activate ("visionset", "time_out_hidden", self, 0.5, 30, 0.5);
		visionset_mgr::activate ("overlay", "time_out_hidden", self);
		
		self notify ("cooldown_bar_update");
		WAIT_SERVER_FRAME;

		self PlaySoundToPlayer (TIME_OUT_ACTIVE_SOUND, self);
		
		time = 0;
		
		while (time < TIME_OUT_HIDDEN_TIME)
		{
			wait .5;
			time += .5;
			
			bar_height = (time / TIME_OUT_HIDDEN_TIME) * COOLDOWN_BAR_HEIGHT;
			
			if (bar_height < 1)
				bar_height = 1;
				
			else if (bar_height > COOLDOWN_BAR_HEIGHT)
				bar_height = COOLDOWN_BAR_HEIGHT;
				
			if (!IsInt (bar_height))
				bar_height = Int (bar_height);
			
			if (IsDefined (self.time_out_bar))
				self.time_out_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
		}
		
		self.time_out_active = 0;
		
		if (IsDefined (self.time_out_bar_back))
			self.time_out_bar_back Destroy();
			
		if (IsDefined (self.time_out_bar))
			self.time_out_bar Destroy();
			
		if (IsDefined (self.time_out_icon))
			self.time_out_icon Destroy();
		
		self notify ("cooldown_bar_update");
		
		self zm_utility::decrement_ignoreme();
		
		visionset_mgr::deactivate ("visionset", "time_out_hidden", self);
		visionset_mgr::deactivate ("overlay", "time_out_hidden", self);
	}
}


// ======================================================================================================
// Timeslip
// ======================================================================================================

function timeslip_trap_cooldown ()
{
	//SELF == LEVEL

	for (;;)
	{
		level waittill ("trap_activate", trap);

		if (IsDefined (trap.activated_by_player.west_hasperk_timeslip) && trap.activated_by_player.west_hasperk_timeslip == 1)
			trap._trap_cooldown_time /= TIMESLIP_TRAP_RECHARGE_DIVIDE;
	}
}


// ======================================================================================================
// Tombstone Soda
// ======================================================================================================

function tombstone_laststand()
{	
	//SELF == PLAYER
	
	level endon ("end_game");
	level endon ("game_over");

	self.west_hasperk_tombstone = 0;
	
	e_tombstone = Spawn ("script_model", self.origin + VectorScale ((0, 0, 1), 20));
	e_tombstone.angles = self.angles;
	e_tombstone SetModel (TOMBSTONE_SODA_POWERUP_MODEL);
	e_tombstone.script_noteworthy = "player_tombstone_model";
	e_tombstone.player = self;
	
	e_tombstone thread tombstone_wobble();
	e_tombstone thread tombstone_watch_for_reviving (self);
	
	PlaySoundAtPosition (TOMBSTONE_SODA_SOUND_POWERUP_SPAWN, self.origin);
	e_tombstone PlayLoopSound (TOMBSTONE_SODA_SOUND_POWERUP_LOOP);
	
	e_tombstone.loadout = self tombstone_get_loadout (array (TOMBSTONE_SODA_PERK));
	
	current_perk_list = array::randomize (zm_perks::get_perk_array());
	
	result = self util::waittill_any_return ("player_revived", "spawned_player", "disconnect", "ffyl_killed_zombie");
	
	if (result == "player_revived" || result == "disconnect" || result == "ffyl_killed_zombie")
	{
		if (result == "player_revived")
		{
			if ((IsDefined (current_perk_list) && current_perk_list.size > 0))
			{
				for (i = 0; i < current_perk_list.size; i++)
				{
					//Don't Return Tombstone or Quick Revive in Solo
					if ((current_perk_list [i] == TOMBSTONE_SODA_PERK) ||
						(current_perk_list [i] == PERK_QUICK_REVIVE && zm_perks::use_solo_revive()))
						continue;
						
					self zm_perks::give_perk (current_perk_list [i], 0);
				}
			}
		}
		
		e_tombstone notify ("tombstone_timedout");
		e_tombstone Delete();
		
		return;
	}
	
	e_tombstone thread tombstone_timeout();
	e_tombstone thread tombstone_grab();
	e_tombstone thread tombstone_obtained_or_disconnect (self);
}

function tombstone_watch_for_reviving (player)
{
	//SELF == POWERUP

	self endon ("tombstone_timedout");
	player endon ("disconnect");
	
	shown = 1;
	
	while (IsDefined (self) && IsDefined (player))
	{
		if (IsDefined (player.revivetrigger) && IsDefined (player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived)
		{
			if (IS_TRUE(shown))
			{
				shown = 0;
				self Hide();
			}
		}
		
		else
		{
			if (!IS_TRUE(shown))
			{
				shown = 1;
				self Show();
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function tombstone_grab()
{
	//SELF == POWERUP

	self endon ("tombstone_timedout");
	self endon ("tombstone_grabbed");
	
	wait 1;
	
	while (IsDefined (self))
	{
		players = GetPlayers();
		
		for (i = 0; i < players.size; i++)
		{
			if (IS_TRUE(players [i].is_zombie) || players [i] laststand::player_is_in_laststand() || "playing" != players [i].sessionstate)
				continue;
			
			if (IsDefined (self.player) && players [i] == self.player)
			{
				dist = Distance (players [i].origin, self.origin);
				
				if (dist < 64)
				{
					PlayFx (level._effect [TOMBSTONE_SODA_POWERUP_GRAB], self.origin);
					players [i] tombstone_give_loadout (self.loadout, 1, 0, 0, array (TOMBSTONE_SODA_PERK));
					
					PlaySoundAtPosition (TOMBSTONE_SODA_SOUND_POWERUP_GRAB, self.origin );
					
					self StopLoopSound();
					
					self Delete();
					
					players [i] notify ("dance_on_my_grave");
					self notify ("tombstone_grabbed");
				}
			}
		}
		
		WAIT_SERVER_FRAME;
	}
}

function tombstone_wobble()
{
	//SELF == POWERUP

	self endon ("tombstone_grabbed");
	self endon ("tombstone_timedout");
	
	if (IsDefined (self))
	{
		PlayFxOnTag (TOMBSTONE_SODA_POWERUP_FX, self, "tag_origin");
		PlaySoundAtPosition (TOMBSTONE_SODA_SOUND_POWERUP_SPAWN, self.origin);
		self PlayLoopSound (TOMBSTONE_SODA_SOUND_POWERUP_LOOP);
	}
	
	while (IsDefined (self))
	{
		self RotateYaw (360, 3);
		wait 2.9;
	}
}

function tombstone_timeout()
{
	//SELF == POWERUP

	self endon ("tombstone_grabbed");
	
	if (!IS_TRUE(TOMBSTONE_SODA_POWERUP_USE_TIMEOUT))
		return;
	
	wait (TOMBSTONE_SODA_POWERUP_TIMEOUT);
	
	i = 0;
	
	while (i < 40)
	{
		if (i % 2)
			self Ghost();
			
		else
			self Show();
		
		if (i < 15)
		{
			wait .5;
			i++;
			continue;
		}
		
		else if (i < 25)
		{
			wait .25;
			i++;
			continue;
		}
		
		else
			wait .1;
		
		i++;
	}
	
	self notify ("tombstone_timedout");
	
	self StopLoopSound();
	self Delete();
}

function tombstone_obtained_or_disconnect (e_player)
{
	//SELF == POWERUP

	self endon ("tombstone_grabbed");
	
	e_player util::waittill_any ("tombstone_obtained", "disconnect");
	
	self notify ("tombstone_timedout");
	
	self StopLoopSound();
	self Delete();
}

function tombstone_get_loadout (a_exclude_perks = [])
{
	//SELF == PLAYER

	loadout = spawnStruct(); 
	loadout.w_current_weapon = (self GetCurrentWeapon() != level.weaponNone && IsWeapon (self getCurrentWeapon()) && !zm_utility::is_offhand_weapon (self GetCurrentWeapon()) ? ( self getCurrentWeapon() ) : undefined );
	loadout.w_stowed_weapon = ( self getStowedWeapon() != level.weaponNone && IsWeapon (self getStowedWeapon()) ? (self GetStowedWeapon()) : undefined);
	loadout.a_all_weapons = [];
	loadout.n_score = ( IsDefined ( self.score ) ? self.score : 0 );
	
	if ( self hasRiotShield() )
	{
		loadout.n_shield_health = self damageRiotShield( 0 );
		loadout.w_shield = self.weaponRiotshield;
	}
	
	a_all_weapons = self getWeaponsList();
	for ( i = 0; i < a_all_weapons.size; i++ )
		if ( IsDefined ( a_all_weapons[ i ] ) && a_all_weapons[ i ] != level.weaponNone && zm_weapons::is_weapon_included( a_all_weapons[ i ] ) || zm_weapons::is_weapon_upgraded( a_all_weapons[ i ] ) )
			array::add( loadout.a_all_weapons, zm_weapons::get_player_weapondata( self, a_all_weapons[ i ] ), 0 );
	
	loadout.a_perks = array::exclude( ( ( IsDefined ( self zm_perks::get_perk_array() ) ) ? self zm_perks::get_perk_array() : [] ), a_exclude_perks );
	loadout.a_disabled_perks = ( IsDefined ( self.disabled_perks ) && isArray( self.disabled_perks ) ? self.disabled_perks : [] );
	loadout.a_additional_primary_weapons_lost = self.a_additional_primary_weapons_lost;
	loadout.w_melee_weapon = self zm_utility::get_player_melee_weapon();
	loadout.w_lethal_grenade_weapon = self zm_utility::get_player_lethal_grenade();
	loadout.w_lethal_grenade_ammo = ( IsDefined ( loadout.w_lethal_grenade_weapon ) ? self getAmmoCount( loadout.w_lethal_grenade_weapon ) : 0 );
	loadout.w_tactical_grenade_weapon = self zm_utility::get_player_tactical_grenade();
	loadout.w_tactical_grenade_ammo = ( IsDefined ( loadout.w_tactical_grenade_weapon ) ? self getAmmoCount( loadout.w_tactical_grenade_weapon ) : 0 );
	loadout.w_mine_weapon = self zm_utility::get_player_placeable_mine();
	loadout.w_mine_ammo = ( IsDefined ( loadout.w_mine_weapon ) ? self getAmmoCount( loadout.w_mine_weapon ) : 0 );
	loadout.w_hero_weapon = self zm_utility::get_player_hero_weapon();
	loadout.w_hero_weapon_charge = self gadgetPowerGet( 0 );
	
	return loadout; 
}

function tombstone_give_loadout (loadout, b_remove_player_weapons = 1, b_immediate_weapon_switch = 0, b_remove_player_perks = 0, a_exclude_perks = [], a_exclude_guns = [])
{
	//SELF == PLAYER

	DEFAULT( self.disabled_perks, [] );
	
	if ( IS_TRUE( b_remove_player_weapons ) )
		self takeAllWeapons();
	if ( IS_TRUE( b_remove_player_perks ) )
	{
		a_player_current_perks = ( ( IsDefined ( self zm_perks::get_perk_array() ) && isArray( self zm_perks::get_perk_array() ) ) ? self zm_perks::get_perk_array() : [] );
		a_player_current_perks = arrayCombine( a_player_current_perks, self.disabled_perks, 0, 1 );
		a_loadout_perks = arrayCombine( loadout.a_perks, loadout.a_disabled_perks, 0, 1 );
		a_perks_to_take = array::exclude( a_loadout_perks, a_player_current_perks );
		
		for ( i = 0; i < a_perks_to_take.size; i++ )
		{	
			self notify( a_perks_to_take[ i ] + "_stop" );
		}
	}
	
	a_perks = ( ( IsDefined ( loadout.a_perks ) ) ? loadout.a_perks : [] );
	if ( IsDefined ( loadout.a_disabled_perks ) && isArray( loadout.a_disabled_perks ) && loadout.a_disabled_perks.size > 0 )
		for ( i = 0; i < loadout.a_disabled_perks.size; i++ )
			if ( IsDefined ( loadout.a_disabled_perks[ i ] ) )
			{
				if ( !isInArray( a_perks, loadout.a_disabled_perks[ i ] ) )
					a_perks[ loadout.a_disabled_perks[ i ] ] = 1;
			}
	
	for ( i = 0; i < a_perks.size; i++ )
	{
		if ( isInArray( a_exclude_perks, a_perks[ i ] ) )
			continue;
		
		if ( level flag::exists( "solo_game" ) && level flag::exists( "solo_revive" ) && level flag::get( "solo_game" ) && !level flag::get( "solo_revive" ) && a_perks[ i ] == "specialty_quickrevive" )
			level.solo_lives_given--;
		
		if ( a_perks[ i ] == "specialty_additionalprimaryweapon" && !self HasPerk ("specialty_additionalprimaryweapon"))
		{
			a_additional_primary_weapons_lost = ( IsDefined ( self.a_additional_primary_weapons_lost ) && isArray( self.a_additional_primary_weapons_lost ) ? self.a_additional_primary_weapons_lost : loadout.a_additional_primary_weapons_lost );
			self.a_additional_primary_weapons_lost = undefined;
			self zm_perks::give_perk( a_perks[ i ] );
			self.a_additional_primary_weapons_lost = a_additional_primary_weapons_lost;
		}
		
		else
			self zm_perks::give_perk (a_perks [i]);
	}
	
	for ( i = 0; i < loadout.a_all_weapons.size; i++ )
		if ( IsDefined ( loadout.a_all_weapons[ i ][ "weapon" ] ) && !isInArray( a_exclude_guns, loadout.a_all_weapons[ i ][ "weapon" ].name ) && ( zm_utility::is_offhand_weapon( loadout.a_all_weapons[ i ][ "weapon" ] ) || self getWeaponsListPrimaries().size < zm_utility::get_player_weapon_limit( self ) ) )
			self zm_weapons::weapondata_give( loadout.a_all_weapons[ i ] );
	
	if ( IsDefined ( loadout.w_stowed_weapon ) && self hasWeapon( loadout.w_stowed_weapon ) )
		self setStowedWeapon( loadout.w_stowed_weapon );
	
	ptr_weapon_switch = ( IS_TRUE( b_immediate_weapon_switch ) ? &switchToWeaponImmediate : &switchToWeapon );
	if ( !IsDefined ( loadout.w_current_weapon ) )
		self [ [ ptr_weapon_switch ] ]();
	else
		self [ [ ptr_weapon_switch ] ]( loadout.w_current_weapon );
	
	if ( IsDefined ( loadout.n_shield_health ) )
	{
		n_shield_health = self damageRiotShield( loadout.w_shield.weaponStartHitPoints - loadout.n_shield_health );
		self riotshield::player_set_shield_health( n_shield_health, loadout.w_shield.weaponStartHitPoints );
	}
	
	if ( IsDefined ( loadout.w_melee_weapon ) )
	{
		self zm_weapons::weapon_give( loadout.w_melee_weapon );
		self zm_utility::set_player_melee_weapon( loadout.w_melee_weapon );
	}
	
	if ( IsDefined ( loadout.w_lethal_grenade_weapon ) )
	{
		self zm_weapons::weapon_give( loadout.w_lethal_grenade_weapon );
		self zm_utility::set_player_lethal_grenade( loadout.w_lethal_grenade_weapon );
		self setWeaponAmmoClip( loadout.w_lethal_grenade_weapon, loadout.w_lethal_grenade_ammo );
	}
	
	if ( IsDefined ( loadout.w_tactical_grenade_weapon ) )
	{
		self zm_weapons::weapon_give( loadout.w_tactical_grenade_weapon );
		self zm_utility::set_player_tactical_grenade( loadout.w_tactical_grenade_weapon );
		self setWeaponAmmoClip( loadout.w_tactical_grenade_weapon, loadout.w_tactical_grenade_ammo );
	}
	
	if ( IsDefined ( loadout.w_mine_weapon ) )
	{
		self zm_weapons::weapon_give( loadout.w_mine_weapon );
		self zm_utility::set_player_placeable_mine( loadout.w_mine_weapon );
		self setWeaponAmmoClip( loadout.w_mine_weapon, loadout.w_mine_ammo );
		self clientfield::set_player_uimodel( "hudItems.showDpadRight", 1 );
	}
	
	if ( IsDefined ( loadout.w_hero_weapon ) )
	{
		self zm_weapons::weapon_give( loadout.w_hero_weapon );
		self zm_utility::set_player_hero_weapon( loadout.w_hero_weapon );
		if ( IsDefined ( loadout.w_hero_weapon_charge ) )
		{
			self gadgetPowerSet( 0, loadout.w_hero_weapon_charge );
			if ( self gadgetPowerGet( 0 ) == 100 )
				self zm_hero_weapon::set_hero_weapon_state( 0, 2 );
			else
				self zm_hero_weapon::set_hero_weapon_state( 0, 1 );
			
		}
	}
}


// ======================================================================================================
// Verruckt Juggernog
// ======================================================================================================

function verruckt_jug_health_regen()
{
	// SELF == PLAYER
	
	self endon (VERRUCKT_JUG_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	if (!IsPlayer(self))
		return;

	for (;;)
	{
		self waittill ("damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargeLevel);
	
		while (self.health < self.maxhealth)
		{
			if (IsDefined (self.west_hasperk_dying_wish) && self.west_hasperk_dying_wish == 1 && 
				IsDefined (self.dying_wish_active) && self.dying_wish_active == 1 &&
				IsDefined (self.dying_wish_on_cooldown) && self.dying_wish_on_cooldown == 0)
				break;
		
			if ((self.maxhealth - self.health) > VERRUCKT_PLAYER_HEALTH_REGEN)
				self.health = self.health + VERRUCKT_PLAYER_HEALTH_REGEN;
	
			else
				self.health = self.maxhealth;

			wait (VERRUCKT_PLAYER_REGEN_CYCLE_TIME);
		}
		
		self notify ("clear_red_flashing_overlay");
	}
}


// ======================================================================================================
// Victorious Tortoise
// ======================================================================================================

function victorious_shield_explode()
{
	//SELF == PLAYER
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, VICTORIOUS_TORTOISE_SHIELD_EXPLOSION_RANGE);
		
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
		{
			foreach (zom in zoms_in_range)
			{
				if (IsDefined (zom) && IsAI (zom) && IsAlive (zom))
				{
					zom zombie_utility::gib_random_parts();
					GibServerUtils::Annihilate (zom);
					zom zm_spawner::zombie_explodes_intopieces (false);
					
					zom DoDamage (zom.health + 666, self.origin, self, self, "none", "MOD_EXPLOSIVE");
				}
			}	
		}
	}
}


// ======================================================================================================
// Vigor Rush
// ======================================================================================================

function vigor_rush_explosion (sHitLoc, attacker)
{
	//SELF == AI
	//ATTACKER == PLAYER
	
	tag_for_fx = bullet_impact_get_tag_location (sHitLoc);
	
	if (IsDefined (self GetTagOrigin (tag_for_fx)))
	{
		PlayFXOnTag (level._effect [VIGOR_RUSH_EXPLOSION_FX], self, tag_for_fx);
		PlaySoundAtPosition (VIGOR_RUSH_EXPLOSION_SOUND, self GetTagOrigin (tag_for_fx));
	}
}


// ======================================================================================================
// Wall Power
// ======================================================================================================

function wall_power_upgrade_weapon ()
{
	//SELF = PLAYER
	
	self endon (WALL_POWER_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		weapon_list = self GetWeaponsList (1);
		
		if (IsDefined (weapon_list) && weapon_list.size > 0)
		{
			foreach (l_weapon in weapon_list)
			{
				if (zm_weapons::is_wallbuy (l_weapon))
				{
					w_weapon = zm_weapons::get_upgrade_weapon (l_weapon, false);
					
					if (IsDefined (w_weapon) && !self HasWeapon (w_weapon, true))
					{
						self zm_weapons::weapon_take (l_weapon);
						self zm_weapons::weapon_give (w_weapon);
					}
				}
			}
		}
		
		self util::waittill_any_return ("weapon_give", "player_given");
	}
}


// ======================================================================================================
// Widows Wine
// ======================================================================================================

function widows_wine_think()
{
	//SELF == PLAYER
	
	if (level.w_widows_wine_wpn_grenade == self zm_utility::get_player_lethal_grenade())
		return;
		
	self.w_widows_wine_prev = self zm_utility::get_player_lethal_grenade();
	
	if (IsDefined (self.w_widows_wine_prev))
		self zm_weapons::weapon_take (self.w_widows_wine_prev);
	
	WAIT_SERVER_FRAME;
	
	self zm_weapons::weapon_give (level.w_widows_wine_wpn_grenade, false, false, true, false);
	self zm_utility::set_player_lethal_grenade (level.w_widows_wine_wpn_grenade);
	
	self thread widows_wine_watch_for_purchase();
	//self thread glitch_grenade_bounce_monitor();
}

function widows_wine_watch_for_purchase ()
{
	//SELF == PLAYER
	
	self endon (WIDOWS_WINE_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;)
	{
		self waittill ("weapon_give", weapon);
		
		if (!IsDefined (weapon))
			continue;
			
		if (!zm_utility::is_lethal_grenade (weapon))
			continue;
			
		if (level.w_widows_wine_wpn_grenade == self zm_utility::get_player_lethal_grenade())
			continue;
			
		self zm_weapons::weapon_take (self zm_utility::get_player_lethal_grenade());
		
		WAIT_SERVER_FRAME;
		
		self zm_weapons::weapon_give (level.w_widows_wine_wpn_grenade, false, false, true, false);
		self zm_utility::set_player_lethal_grenade (level.w_widows_wine_wpn_grenade);
	}
}

function widows_wine_contact_explosion ()
{
	//SELF == PLAYER
	
	if (IsDefined (self.west_hasperk_tactiquilla) && self.west_hasperk_tactiquilla == 1)
	{
		exclude = 0;
	
		if (TACTIQUILLA_WEAPON_EXLUSION_LIST.size > 0)
		{
			for (i = 0; i < TACTIQUILLA_WEAPON_EXLUSION_LIST.size; i++)
				if (self.current_lethal_grenade.name == TACTIQUILLA_WEAPON_EXLUSION_LIST [i])
					exclude = 1;
		}
				
		if (exclude == 0)
		{
			if (RandomIntRange (1, 101) > TACTIQUILLA_REGAIN_AMMO_CHANCE)
				self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
		}
		
		else
			self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
	}
	
	else
		self SetWeaponAmmoClip (self.current_lethal_grenade, self GetWeaponAmmoClip (self.current_lethal_grenade) - 1);
	
	self MagicGrenadeType (self.current_lethal_grenade, self.origin + (0, 0, 48), (0, 0, 0), 0.0);
	self clientfield::increment_to_player ("widows_wine_1p_contact_explosion", 1);
}

function widows_wine_cocoon_zombie (player)
{
	//SELF == AI
	
	self notify ("widows_wine_slowdown");
	self notify ("widows_wine_cocoon");
	self endon ("widows_wine_cocoon");
	
	if (IsDefined (self.kill_on_wine_coccon) && self.kill_on_wine_coccon)
		self Kill();
		
	if (IsDefined (self.widows_wine_slowed) && self.widows_wine_slowed == 1)
		self.widows_wine_slowed = 0;
	
	if (!IsDefined (self.widows_wine_cocoon) || self.widows_wine_cocoon == 0)
	{
		self.widows_wine_cocoon = 1;
		self clientfield::set ("widows_wine_wrapping", 1);
	}
	
	self thread widows_wine_zombie_score (player);
	
	time = WIDOWS_WINE_COCOON_DURATION;
	
	while (time > 0)
	{
		wait .5;
		time -= .5;
		
		if (IsDefined (self) && IsAlive (self))
			self thread zm_utility::slowdown_ai ("widows_wine_cocoon");
			
		else
			break;
	}

	if (IsDefined (self))
	{
		self.widows_wine_cocoon = 0;
		self clientfield::set ("widows_wine_wrapping", 0);
	}
}

function widows_wine_slow_zombie (player)
{
	//SELF == AI
	
	self notify ("widows_wine_slowdown");
	self endon ("widows_wine_slowdown");
	
	if (IsDefined (self.widows_wine_cocoon) && self.widows_wine_cocoon == 1)
	{
		self thread widows_wine_cocoon_zombie (player);
		
		return;
	}
	
	if (!IsDefined (self.widows_wine_slowed) || self.widows_wine_slowed == 0)
	{
		self.widows_wine_slowed = 1;
		self clientfield::set ("widows_wine_wrapping", 1);
	}
	
	self thread widows_wine_zombie_score (player);
	
	time = WIDOWS_WINE_SLOW_DURATION;
	
	while (time > 0)
	{
		wait .5;
		time -= .5;
		
		if (IsDefined (self) && IsAlive (self))
			self thread zm_utility::slowdown_ai ("widows_wine_slowdown");
			
		else
			break;
	}
	
	wait 1;

	if (IsDefined (self) && IsAlive (self))
	{
		self.widows_wine_slowed = 0;
		self clientfield::set ("widows_wine_wrapping", 0);
	}
}

function widows_wine_vehicle_behavior (attacker, weapon)
{
	//SELF == AI
	
	self endon ("death");
	
	self thread widows_wine_zombie_score (attacker);
	
	if (IsDefined (self.archetype))
	{
		if (self.archetype == "raps")
		{
			self clientfield::set ("widows_wine_wrapping", 1);
			self._override_raps_combat_speed = 5;
			
			wait 6;
			
			self DoDamage (self.health + 666, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, weapon);
		}
		
		else if (self.archetype == "parasite")
		{
			WAIT_SERVER_FRAME;
			
			self DoDamage (self.maxhealth + 666, self.origin);
		}
	}
}

function widows_wine_zombie_score (player)
{
	//SELF == AI
	
	self notify ("widows_wine_cocoon_zombie_score");
	self endon ("widows_wine_cocoon_zombie_score");
	
	if (IsDefined (self.widows_wine_cocoon) && self.widows_wine_cocoon == 1)
	{
		while (self.widows_wine_cocoon == 1)
		{
			wait 1;
			
			if (!IsDefined (self) || !IsAlive (self))
				break;
				
			player thread common_give_points (10);
		}
	}
	
	else if (IsDefined (self.widows_wine_slowed) && self.widows_wine_slowed == 1)
	{
		while (self.widows_wine_slowed == 1)
		{
			wait 1;
			
			if (!IsDefined (self) || !IsAlive (self))
				break;
				
			player thread common_give_points (10);
		}
	}
}

function widows_wine_powerup_timeout()
{
	//SELF == POWERUP
	
	self endon ("death");
	self endon ("powerup_grabbed");
	self endon ("powerup_reset");
	
	self zm_powerups::powerup_show (1);
	
	wait_time = 1;
	
	if (IsDefined (level._powerup_timeout_custom_time))
	{
		time = [[level._powerup_timeout_custom_time]] (self);
		
		if (time == 0)
			return;
		
		wait_time = time;
	}
	
	wait wait_time;

	for (i = 20; i > 0; i--)
	{
		if (i % 2)
			self zm_powerups::powerup_show (0);
			
		else
			self zm_powerups::powerup_show (1);

		if (i > 15)
			wait .3;
			
		if (i > 10)
			wait .25;
			
		else if (i > 5)
			wait .15;
			
		else
			wait .1;
	}
	
	self notify ("powerup_timedout");
	
	self zm_powerups::powerup_delete();
}


// ======================================================================================================
// Windrunner Whiskey
// ======================================================================================================

function windrunner_logic ()
{
	//SELF == PLAYER
	
	self endon (WINDRUNNER_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	charge_time = 0;
	charge_sound_played = 0;
	
	for (;;)
	{
		if (self IsSprinting() && self.windrunner_on_cooldown == 0)
		{
			if (WINDRUNNER_PLAY_SOUNDS == 1)
				self PlaySound (WINDRUNNER_CHARGE_SOUND);
		
			while (self IsSprinting())
			{
				charge_time += .05;	
				
				if (charge_time >= WINDRUNNER_CHARGE_TIME)
				{
					if (charge_sound_played == 0)
					{
						charge_sound_played = 1;
						
						if (WINDRUNNER_PLAY_SOUNDS == 1)
							self PlaySound (WINDRUNNER_RUNNING_SOUND);
						
						fxorg = util::spawn_model ("tag_origin", self.origin);
						fxorg EnableLinkTo();
						fxorg LinkTo (self, "tag_origin");
						PlayFXOnTag (WINDRUNNER_PLAYER_RUNNING_FX, fxorg, "tag_origin");
					}
					
					zoms = GetAITeamArray (level.zombie_team);
		
					if (IsDefined (zoms) && zoms.size > 0)
					{
						zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, WINDRUNNER_BLAST_DISTANCE);
		
						if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
							foreach (zom in zoms_in_range)
								if (!IsDefined (zom.ai_too_op_for_windrunner_whiskey) || zom.ai_too_op_for_windrunner_whiskey == 0) //If AI is NOT protected from Windrunner Whiskey
									zom thread zombie_wind_blast (self);
					}
				}
				
				WAIT_SERVER_FRAME;
			}
			
			if (charge_time >= WINDRUNNER_CHARGE_TIME)
			{
				charge_sound_played = 0;
				self.windrunner_on_cooldown = 1;
				
				self notify ("cooldown_bar_update");
				
				if (IsDefined (fxorg))
				{
					fxorg Unlink();
					fxorg Delete();
				}
				
				self windrunner_cooldown();
				
				self.windrunner_on_cooldown = 0;
				
				self notify ("cooldown_bar_update");
			}
			
			charge_time = 0;
		}
		
		WAIT_SERVER_FRAME;
	}
}

function zombie_wind_blast (player)
{
	//SELF == AI
	
	if (WINDRUNNER_PLAY_SOUNDS == 1)
		self PlaySound (WINDRUNNER_IMPACT_SOUND);
	
	fxorg = util::spawn_model ("tag_origin", self.origin+ (0, 0, 40));
	PlayFXOnTag (WINDRUNNER_IMPACT_FX, fxorg, "tag_origin");
	
	launch_vector = (VectorNormalize (self.origin - player.origin) * RandomIntRange (175, 225)) + (0, 0, RandomIntRange (150, 225));
	
	self DoDamage (self.health + 666, player.origin, player, player, "none", "MOD_UNKNOWN");
	
	self StartRagdoll();
	self LaunchRagdoll (launch_vector);
	
	wait 1;
	
	fxorg Delete();
}

function windrunner_cooldown ()
{
	//SELF == PLAYER
	
	self endon (WINDRUNNER_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	time = 0;
	
	while (time < WINDRUNNER_BLAST_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / WINDRUNNER_BLAST_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.windrunner_bar))
			self.windrunner_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
}


// ======================================================================================================
// Winter's Wail
// ======================================================================================================

function winters_wail_think ()
{
	//SELF == PLAYER
	
	if (WINTERS_WAIL_DRAW_CHARGES == 1)
		self thread winters_wail_charge_display();
		
	self thread winters_wail_recharge();
	self thread winters_wail_recharge_after_round();
	self thread winters_wail_recharge_after_max();
}

function winters_wail_blast ()
{
	//SELF == PLAYER
	
	self.winters_wail_charges -= 1;
	
	self notify ("winters_wail_blast");
	
	frost_origin = Spawn ("script_model", self.origin + (0, 0, 30));
	frost_origin SetModel ("tag_origin");
	PlayFxOnTag (WINTERS_WAIL_EXPLOSION_FX, frost_origin, "tag_origin");
	
	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
	{
		zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, WINTERS_WAIL_RANGE);
	
		if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
		{
			foreach (zom in zoms_in_range)
			{
				//If AI is protected from Winter's Wail
				if (IsDefined (zom.ai_too_op_for_winters_wail) && zom.ai_too_op_for_winters_wail == 1)
					continue;
					
				if (Distance (self.origin, zom.origin) <= WINTERS_WAIL_RANGE / 4)
					type = 0;
				
				else if (Distance (self.origin, zom.origin) <= WINTERS_WAIL_RANGE / 2)
					type = 1;
				
				else
					type = 2;
					
				zom thread winters_wail_slowdown (type);
				zom thread winters_wail_freeze_fx();
			}
		}
	}
	
	//wait 1;
	
	frost_origin Delete();
}

function winters_wail_slowdown (slowdown_type)
{
	//SELF == AI
	
	level endon ("end_game");
	level endon ("game_over");
	
	time = 0;
	
	while (time < WINTERS_WAIL_FROZEN_DURATION)
	{	
		self thread zm_utility::slowdown_ai ("winters_wail_freeze_" + slowdown_type);
		
		wait .5;
		time += .5;
		
		if (!IsDefined (self) || !IsAlive(self))
			break;
	}
}

function winters_wail_freeze_fx ()
{
	//SELF == AI
	
	level endon ("end_game");
	level endon ("game_over");
	
	self notify ("winters_wail_activate");
	self endon ("winters_wail_activate");
	
	//Fx plays for 4 sec so stop check 4 sec before
	if (WINTERS_WAIL_FROZEN_DURATION - 4 <= 0)
	{
		if (IsDefined (self GetTagOrigin ("j_spineupper")))
			PlayFxOnTag (WINTERS_WAIL_ZOMBIE_FREEZE_FX, self, "j_spineupper");
			
		else
			PlayFX (WINTERS_WAIL_ZOMBIE_FREEZE_FX, self.origin + (0, 0, 35));
	}
	
	else
	{
		time = 0;
		
		//Fx plays for 4 sec so stop check 4 sec before
		while (time <= WINTERS_WAIL_FROZEN_DURATION - 4)
		{
			if (!IsDefined (self) || !IsAlive(self))
				break;
			
			if (IsDefined (self GetTagOrigin ("j_spineupper")))
				PlayFxOnTag (WINTERS_WAIL_ZOMBIE_FREEZE_FX, self, "j_spineupper");
				
			else
				PlayFX (WINTERS_WAIL_ZOMBIE_FREEZE_FX, self.origin + (0, 0, 35));
				
			wait 1;
			time += 1;
		}
	}
}

function winters_wail_charge_display()
{
	//SELF == PLAYER

	self.winters_wail_hud_icon = self reap_create_hud_icon (WINTERS_WAIL_SNOWFLAKE_ALIGN_X, WINTERS_WAIL_SNOWFLAKE_ALIGN_Y, WINTERS_WAIL_SNOWFLAKE_ALIGN_X, WINTERS_WAIL_SNOWFLAKE_ALIGN_Y, WINTERS_WAIL_SNOWFLAKE_X, WINTERS_WAIL_SNOWFLAKE_Y, 1, WINTERS_WAIL_ICON_SNOWFLAKE, 25, 25, (1, 1, 1));	
	self.winters_wail_hud_icon_text = reap_create_hud_text (WINTERS_WAIL_TEXT_ALIGN_X, WINTERS_WAIL_TEXT_ALIGN_Y, WINTERS_WAIL_TEXT_ALIGN_X, WINTERS_WAIL_TEXT_ALIGN_Y, WINTERS_WAIL_TEXT_X, WINTERS_WAIL_TEXT_Y, .8, (1,1,1), self.winters_wail_charges, 1.2);
	
	while (IsDefined (self.west_hasperk_winters_wail) && self.west_hasperk_winters_wail == 1)
	{
		self.winters_wail_hud_icon_text SetText (self.winters_wail_charges);
		
		if (self.winters_wail_charges <= 0)
			self.winters_wail_hud_icon.color = (1, 0, 0);
			
		else
			self.winters_wail_hud_icon.color = (1, 1, 1);
			
		wait 1;
	}
	
	if (IsDefined (self.winters_wail_hud_icon))
		self.winters_wail_hud_icon Destroy();
		
	if (IsDefined (self.winters_wail_hud_icon_text))
		self.winters_wail_hud_icon_text Destroy();
}

function winters_wail_recharge()
{
	//SELF == PLAYER
	
	self endon (WINTERS_WAIL_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	for (;;) 
	{
		self waittill ("winters_wail_blast");
		
		self notify ("cooldown_bar_update");
		
		while (self.winters_wail_charges < WINTERS_WAIL_MAX_CHARGES)
		{
			time = 0;
			
			while (time < WINTERS_WAIL_RECHARGE_TIME)
			{
				wait 1;
				time++;
				
				bar_height = (time / WINTERS_WAIL_RECHARGE_TIME) * COOLDOWN_BAR_HEIGHT;
				
				if (bar_height < 1)
					bar_height = 1;
					
				else if (bar_height > COOLDOWN_BAR_HEIGHT)
					bar_height = COOLDOWN_BAR_HEIGHT;
					
				if (!IsInt (bar_height))
					bar_height = Int (bar_height);
					
				if (IsDefined (self.winters_wail_bar))
					self.winters_wail_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
			
				if (self.winters_wail_charges == WINTERS_WAIL_MAX_CHARGES)
					break;
			}
			
			if (self.winters_wail_charges < WINTERS_WAIL_MAX_CHARGES)
				self.winters_wail_charges++;
		}
		
		self notify ("cooldown_bar_update");
		
		wait 1;
	}
}

function winters_wail_recharge_after_round()
{
	//SELF == PLAYER
	
	self endon (WINTERS_WAIL_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		level waittill ("start_of_round");
		
		self.winters_wail_charges = WINTERS_WAIL_MAX_CHARGES;
	}
}

function winters_wail_recharge_after_max()
{
	//SELF == PLAYER
	
	self endon (WINTERS_WAIL_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");

	for (;;)
	{
		self waittill ("zmb_max_ammo");
		
		self.winters_wail_charges = WINTERS_WAIL_MAX_CHARGES;
	}
}


// ======================================================================================================
// Wunderfizz
// ======================================================================================================

function wunderfizz_main ()
{
	//SELF == LEVEL
	
	if (!IsDefined (level.perk_random_machine_count))
		level.perk_random_machine_count = 1;
		
	if (!IsDefined (level.perk_random_machine_state_func))
		level.perk_random_machine_state_func = &process_perk_random_machine_state;
		
	level thread include_perks_in_wunderfizz();
	level thread setup_perk_random_machines();
}

function private setup_perk_random_machines ()
{
	//SELF == LEVEL
	
	WAIT_SERVER_FRAME;
	
	level.perk_bottle_weapon_array = ArrayCombine (level.machine_assets, level._custom_perks, 0, 1);
	
	level.perk_random_machines = GetEntArray ("perk_random_machine", "targetname");
	level.perk_random_machine_count = level.perk_random_machines.size;
	
	perk_random_machine_init();
}

function perk_random_machine_init ()
{
	//SELF == LEVEL
	
	foreach (machine in level.perk_random_machines)
	{
		if (!IsDefined (machine.cost))
		{
			if (!IsDefined (level._random_zombie_perk_cost))
				level._random_zombie_perk_cost = WUNDERFIZZ_COST;
			
			machine.cost = level._random_zombie_perk_cost;
		}
		
		machine.current_perk_random_machine = 0;
		machine.uses_at_current_location = 0;
		machine create_perk_random_machine_unitrigger_stub();
		machine clientfield::set ("wunderfizz_init_perk_random_machine", 1);
		
		wait .5;
		
		machine thread set_perk_random_machine_state ("power_off");
	}
	
	level.perk_random_machines = array::randomize (level.perk_random_machines);
	
	init_starting_perk_random_machine_location();
}

function private init_starting_perk_random_machine_location ()
{
	//SELF == LEVEL
	
	starting_machine_found = 0;
	
	for (i = 0; i < level.perk_random_machines.size; i++)
	{
		if (IsDefined (level.perk_random_machines [i].script_noteworthy) && IsSubStr (level.perk_random_machines[i].script_noteworthy, "start_perk_random_machine") && (!(IsDefined (starting_machine_found) && starting_machine_found)))
		{
			level.perk_random_machines [i].current_perk_random_machine = 1;
			level.perk_random_machines [i] thread perk_random_machine_think();
			level.perk_random_machines [i] thread set_perk_random_machine_state ("initial");
			
			starting_machine_found = 1;
			
			continue;
		}
		
		level.perk_random_machines [i] thread perk_random_wait_for_power();
	}
}

function create_perk_random_machine_unitrigger_stub ()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self.unitrigger_stub = SpawnStruct();
	self.unitrigger_stub.script_width = 70;
	self.unitrigger_stub.script_height = 30;
	self.unitrigger_stub.script_length = 40;
	self.unitrigger_stub.origin = (self.origin + (AnglesToRight (self.angles) * self.unitrigger_stub.script_length)) + (AnglesToUp (self.angles) * (self.unitrigger_stub.script_height / 2));
	self.unitrigger_stub.angles = self.angles;
	self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	self.unitrigger_stub.trigger_target = self;
	
	zm_unitrigger::unitrigger_force_per_player_triggers (self.unitrigger_stub, 1);
	
	self.unitrigger_stub.prompt_and_visibility_func = &perk_random_machine_trigger_update_prompt;
	self.unitrigger_stub.script_int = self.script_int;
	
	thread zm_unitrigger::register_static_unitrigger (self.unitrigger_stub, &perk_random_unitrigger_think);
}

function perk_random_machine_trigger_update_prompt (player)
{
	//SELF == WUNDERFIZZ UNITRIGGER
	
	can_use = self perk_random_machine_stub_update_prompt (player);
	
	if (IsDefined (self.hint_string))
	{
		if (IsDefined (self.hint_parm1))
			self sethintstring (self.hint_string, self.hint_parm1);
			
		else
			self sethintstring (self.hint_string);
	}
	
	return can_use;
}

function perk_random_machine_stub_update_prompt (player)
{
	//SELF == WUNDERFIZZ UNITRIGGER
	
	self SetCursorHint ("HINT_NOICON");
	
	if (!self trigger_visible_to_player (player))
		return false;
		
	self.hint_parm1 = undefined;
	
	power_on = perk_random_is_power_on (self.stub.script_int);
	
	if (!power_on)
	{
		self.hint_string = &"ZOMBIE_NEED_POWER";
		
		return false;
	}
	
	if (self.stub.trigger_target.state == "idle" || self.stub.trigger_target.state == "vending")
	{
		wunderfizz_perk_limit = player zm_utility::get_player_perk_purchase_limit();
		
		if (!player zm_utility::can_player_purchase_perk())
		{
			self.hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
			
			if (IsDefined (wunderfizz_perk_limit))
				self.hint_parm1 = wunderfizz_perk_limit;
				
			return false;
		}
		
		if (IsDefined (self.stub.trigger_target.machine_user))
		{
			if (IsDefined (self.stub.trigger_target.grab_perk_hint) && self.stub.trigger_target.grab_perk_hint)
			{
				self.hint_string = &"ZOMBIE_RANDOM_PERK_PICKUP";
				
				return true;
			}
			
			self.hint_string = "";
			
			return false;
		}
		
		wunderfizz_perk_limit = player zm_utility::get_player_perk_purchase_limit();
		
		if (!player zm_utility::can_player_purchase_perk())
		{
			self.hint_string = &"ZOMBIE_RANDOM_PERK_TOO_MANY";
			
			if (IsDefined (wunderfizz_perk_limit))
				self.hint_parm1 = wunderfizz_perk_limit;
				
			return false;
		}
		
		self.hint_string = &"ZOMBIE_RANDOM_PERK_BUY";
		self.hint_parm1 = level._random_zombie_perk_cost;
		
		return true;
	}
	
	self.hint_string = &"ZOMBIE_RANDOM_PERK_ELSEWHERE";
	
	return false;
}

function trigger_visible_to_player (player)
{
	//SELF == WUNDERFIZZ UNITRIGGER
	
	self SetInvisibleToPlayer (player);
	
	visible = 1;
	
	if (IsDefined (self.stub.trigger_target.machine_user))
	{
		if (player != self.stub.trigger_target.machine_user)
			visible = 0;
			
		else if (IsDefined (self.stub.trigger_target.machine_user GetCurrentWeapon()) && zm_utility::is_placeable_mine (self.stub.trigger_target.machine_user GetCurrentWeapon()))
			visible = 0;
	}
	
	else if (!player perk_random_can_buy_perk())
		visible = 0;
		
	if (!visible || player player_has_all_available_perks())
		return false;
		
	self SetVisibleToPlayer (player);
	
	return true;
}

function player_has_all_available_perks()
{
	//SELF == PLAYER
	
	for (i = 0; i < level._random_perk_machine_perk_list.size; i++)
		if (!self HasPerk (level._random_perk_machine_perk_list [i]))
			return false;
			
	return true;
}

function perk_random_can_buy_perk()
{
	//SELF == PLAYER
	
	if (IsDefined (self.is_drinking) && self.is_drinking > 0)
		return false;
		
	current_weapon = self GetCurrentWeapon();
	
	if (!IsDefined (current_weapon))
		return false;
		
	if (zm_utility::is_placeable_mine (current_weapon) || zm_equipment::is_equipment_that_blocks_purchase (current_weapon))
		return false;
		
	if (self zm_utility::in_revive_trigger())
		return false;
		
	if (current_weapon == level.weaponnone)
		return false;
		
	return true;
}

function perk_random_unitrigger_think (player)
{
	self endon ("kill_trigger");
	
	for (;;)
	{
		self waittill ("trigger", player);
		
		self.stub.trigger_target notify ("trigger", player);
	}
}

function perk_random_machine_think()
{
	//SELF == WUNDERFIZZ MACHINE
	
	level notify ("machine_think");
	level endon ("machine_think");
	
	self.num_time_used = 0;
	self.num_til_moved = RandomIntRange (WUNDERFIZZ_USE_TIMES_MIN, WUNDERFIZZ_USE_TIMES_MAX + 1);
	
	if (self.state !== "initial" || "idle")
	{
		self thread set_perk_random_machine_state ("arrive");
		
		self waittill ("arrived");
		
		self thread set_perk_random_machine_state ("initial");
		
		wait 1;
	}
	
	if (IsDefined (level.zm_custom_perk_random_power_flag))
		level flag::wait_till (level.zm_custom_perk_random_power_flag);
		
	else
		while (!perk_random_is_power_on (self.script_int))
			wait 1;
			
	self thread set_perk_random_machine_state ("idle");
	
	if (IsDefined (level.bottle_spawn_location))
		level.bottle_spawn_location delete();
		
	level.bottle_spawn_location = Spawn ("script_model", self.origin);
	level.bottle_spawn_location SetModel ("tag_origin");
	level.bottle_spawn_location.angles = self.angles;
	level.bottle_spawn_location.origin = level.bottle_spawn_location.origin + VectorScale ((0, 0, 1), 65);
	
	for (;;)
	{
		self waittill ("trigger", player);
		
		level flag::clear ("machine_can_reset");
		
		if (!player zm_score::can_player_purchase (level._random_zombie_perk_cost))
		{
			self PlaySound ("evt_perk_deny");
			
			continue;
		}
		
		self.machine_user = player;
		self.num_time_used++;
		
		player zm_stats::increment_client_stat ("use_perk_random");
		player zm_stats::increment_player_stat ("use_perk_random");
		player zm_score::minus_to_player_score (level._random_zombie_perk_cost);
		
		self thread set_perk_random_machine_state ("vending");
		
		if (IsDefined (level.perk_random_vo_func_usemachine) && IsDefined (player))
			player thread [[level.perk_random_vo_func_usemachine]]();
			
		for (;;)
		{
			random_perk = get_weighted_random_perk (player);
			
			self PlaySound ("wunderfizz_start");
			self PlayLoopSound ("wunderfizz_loop", 1);
			
			self notify ("bottle_spawned");
			
			self thread start_perk_bottle_cycling();
			self thread perk_bottle_motion (player);
			
			perk_bottle = get_perk_weapon_model (random_perk);
			
			if (IsDefined (player.west_hasperk_timeslip) && player.west_hasperk_timeslip == 1)
				wait WUNDERFIZZ_TIME_BOTTLE_READY / TIMESLIP_WUNDERFIZZ_DIVIDE;
				
			else
				wait WUNDERFIZZ_TIME_BOTTLE_READY;
			
			self notify ("done_cycling");
			
			if (self.num_time_used > self.num_til_moved && level.perk_random_machine_count > 1)
			{
				level.bottle_spawn_location SetModel (WUNDERFIZZ_BOTTLE_MODEL);
				self StopLoopSound (.5);
				
				self thread set_perk_random_machine_state ("leaving");
				
				self PlaySound ("wunderfizz_leave");
				
				wait 3;
				
				player zm_score::add_to_player_score (level._random_zombie_perk_cost);
				
				level.bottle_spawn_location SetModel ("tag_origin");
				
				self thread perk_random_machine_selector();
				
				self clientfield::set ("wunderfizz_lightning_bolt_FX_toggle", 0);
				
				self.machine_user = undefined;
				
				break;
			}
			
			else
				level.bottle_spawn_location SetModel (perk_bottle);
				
			self PlaySound ("wunderfizz_bottle");
			self.grab_perk_hint = 1;
			
			self thread grab_check (player, random_perk);
			self thread time_out_check();
			
			self util::waittill_either ("grab_check", "time_out_check");
			
			self.grab_perk_hint = 0;
			self PlaySound ("wunderfizz_stop");
			
			self StopLoopSound (.5);
			
			self.machine_user = undefined;
			level.bottle_spawn_location SetModel ("tag_origin");
			
			self thread set_perk_random_machine_state ("idle");
			
			break;
		}
		
		level flag::wait_till ("machine_can_reset");
	}
}

function grab_check (player, random_perk)
{
	//SELF == WUNDERFIZZ MACHINE
	self endon ("time_out_check");
	
	perk_is_bought = 0;
	
	while (!perk_is_bought)
	{
		self waittill ("trigger", e_triggerer);
		
		if (e_triggerer == player)
		{
			if (IsDefined (player.is_drinking) && player.is_drinking > 0)
			{
				wait .1;
				
				continue;
			}
			
			if (player zm_utility::can_player_purchase_perk())
				perk_is_bought = 1;
				
			else
			{
				self PlaySound ("evt_perk_deny");
				self notify ("time_out_or_perk_grab");
				
				return;
			}
		}
	}
	
	player zm_stats::increment_client_stat ("grabbed_from_perk_random");
	player zm_stats::increment_player_stat ("grabbed_from_perk_random");
	
	player thread monitor_when_player_acquires_perk();
	
	self notify ("grab_check");
	self notify ("time_out_or_perk_grab");
	
	player notify ("perk_purchased", random_perk);
	
	gun = player zm_perks::perk_give_bottle_begin (random_perk);
	evt = player util::waittill_any_ex ("fake_death", "death", "player_downed", "weapon_change_complete", self, "time_out_check");
	
	if (evt == "weapon_change_complete")
		player thread zm_perks::wait_give_perk (random_perk, 1);
		
	player zm_perks::perk_give_bottle_end (gun, random_perk);
	
	if (!(IsDefined (player.has_drunk_wunderfizz) && player.has_drunk_wunderfizz))
		player.has_drunk_wunderfizz = 1;
}

function monitor_when_player_acquires_perk()
{
	//SELF == PLAYER
	
	self util::waittill_any ("perk_acquired", "death_or_disconnect", "player_downed");
	
	level flag::set ("machine_can_reset");
}

function time_out_check()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self endon ("grab_check");
	
	wait WUNDERFIZZ_USE_TIMEOUT;
	
	self notify ("time_out_check");
	
	level flag::set ("machine_can_reset");
}

function perk_random_wait_for_power()
{
	//SELF == WUNDERFIZZ MACHINE
	
	if (IsDefined (self.script_int))
	{
		str_wait = "power_on" + self.script_int;
		level flag::wait_till (str_wait);
	}
	
	else
	{
		if (IsDefined (level.zm_custom_perk_random_power_flag))
			level flag::wait_till(level.zm_custom_perk_random_power_flag);
			
		else
			level flag::wait_till ("power_on");
	}
	
	self thread set_perk_random_machine_state ("away");
}

function perk_random_machine_selector()
{
	//SELF == WUNDERFIZZ MACHINE
	
	if (level.perk_random_machines.size == 1)
	{
		new_machine = level.perk_random_machines [0];
		new_machine thread perk_random_machine_think();
	}
	
	else
	{
		do
		{
			new_machine = level.perk_random_machines [RandomInt (level.perk_random_machines.size)];
		}
			
		while (new_machine.current_perk_random_machine == 1);
		
		new_machine.current_perk_random_machine = 1;
		self.current_perk_random_machine = 0;
		
		wait 10;
		
		new_machine thread perk_random_machine_think();
	}
}

function include_perk_in_random_rotation (perk)
{
	//SELF == LEVEL
	
	if (!IsDefined (level._random_perk_machine_perk_list))
		level._random_perk_machine_perk_list = [];
		
	else if (!IsArray (level._random_perk_machine_perk_list))
		level._random_perk_machine_perk_list = Array (level._random_perk_machine_perk_list);
		
	//Skip if already included
	if (level._random_perk_machine_perk_list.size > 0)
	{
		foreach (key in level._random_perk_machine_perk_list)
			if (key == perk)
				return;
	}
	
	//Only include if perk has gone through perk setup
	if (IsDefined (level._custom_perks) && level._custom_perks.size > 0)
	{
		a_keys = GetArrayKeys (level._custom_perks);
		
		foreach (key in a_keys)
			if (key == perk)
				level._random_perk_machine_perk_list [level._random_perk_machine_perk_list.size] = perk;
	}
}

function get_weighted_random_perk (player)
{
	//SELF == WUNDERFIZZ MACHINE
	
	keys = array::randomize (GetArrayKeys (level._random_perk_machine_perk_list));
	
	if (IsDefined (level.custom_random_perk_weights))
		keys = player [[level.custom_random_perk_weights]]();
	
	for (i = 0; i < keys.size; i++)
	{
		if (player HasPerk (level._random_perk_machine_perk_list [keys [i]]))
			continue;
			
		return level._random_perk_machine_perk_list [keys [i]];
	}
	
	return level._random_perk_machine_perk_list [keys [0]];
}

function perk_bottle_motion (player)
{
	//SELF == WUNDERFIZZ MACHINE
	
	put_out_time = WUNDERFIZZ_TIME_BOTTLE_READY;
	put_back_time = WUNDERFIZZ_USE_TIMEOUT;
	
	if (IsDefined (player.west_hasperk_timeslip) && player.west_hasperk_timeslip == 1)
		put_out_time = WUNDERFIZZ_TIME_BOTTLE_READY / TIMESLIP_WUNDERFIZZ_DIVIDE;
	
	v_float = (AnglesToForward (self.angles - (0, 90, 0))) * 10;
	
	level.bottle_spawn_location.origin = self.origin + (0, 0, 53);
	level.bottle_spawn_location.angles = self.angles;
	level.bottle_spawn_location.origin = level.bottle_spawn_location.origin - v_float;
	level.bottle_spawn_location MoveTo (level.bottle_spawn_location.origin + v_float, put_out_time, put_out_time * .5);
	level.bottle_spawn_location.angles = level.bottle_spawn_location.angles + (0, 0, 10);
	level.bottle_spawn_location RotateYaw (720, put_out_time, put_out_time * .5);
	
	self waittill ("done_cycling");
	
	level.bottle_spawn_location.angles = self.angles;
	level.bottle_spawn_location MoveTo (level.bottle_spawn_location.origin - v_float, put_back_time, put_back_time * .5);
	level.bottle_spawn_location RotateYaw (90, put_back_time, put_back_time * .5);
}

function start_perk_bottle_cycling()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self endon ("done_cycling");
	
	array_key = GetArrayKeys (level.perk_bottle_weapon_array);
	
	for (;;)
	{
		for (i = 0; i < array_key.size; i++)
		{
			if (IsDefined (level.perk_bottle_weapon_array [array_key [i]].weapon))
				model = get_weapon_model (level.perk_bottle_weapon_array [array_key [i]].weapon);
				
			else
				model = get_weapon_model (level.perk_bottle_weapon_array [array_key [i]].perk_bottle_weapon);
				
			level.bottle_spawn_location SetModel (model);
			
			wait .2;
		}
	}
}

function get_perk_weapon_model (perk)
{
	//SELF == WUNDERFIZZ MACHINE
	
	weapon = level.machine_assets [perk].weapon;
	
	if (IsDefined (level._custom_perks [perk]) && IsDefined (level._custom_perks [perk].perk_bottle_weapon))
		weapon = level._custom_perks [perk].perk_bottle_weapon;
		
	return get_weapon_model (weapon);
}

function perk_random_vending()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self clientfield::set ("wunderfizz_client_stone_emmissive_blink", 1);
	
	self thread perk_random_loop_anim (5, "opening", "opening");
	self thread perk_random_loop_anim (3, "closing", "closing");
	self thread perk_random_vend_sfx();
	
	self notify ("vending");
	self waittill ("bottle_spawned");
	
	self SetZbarrierPieceState (4, "opening");
}

function perk_random_loop_anim (n_piece, s_anim_1, s_anim_2)
{
	//SELF == WUNDERFIZZ MACHINE
	
	self endon ("zbarrier_state_change");
	
	current_state = self.state;
	
	while (self.state == current_state)
	{
		self SetZbarrierPieceState (n_piece, s_anim_1);
		
		while (self GetZbarrierPieceState (n_piece) == s_anim_1)
			WAIT_SERVER_FRAME;
			
		self SetZbarrierPieceState (n_piece, s_anim_2);
		
		while (self GetZbarrierPieceState (n_piece) == s_anim_2)
			WAIT_SERVER_FRAME;
	}
}

function perk_random_vend_sfx()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self PlayLoopSound ("wunderfizz_sparks");
	level.bottle_spawn_location PlayLoopSound ("wunderfizz_vortex");
	
	self waittill ("zbarrier_state_change");
	
	self StopLoopSound();
	level.bottle_spawn_location StopLoopSound();
}

function perk_random_initial()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self SetZbarrierPieceState (3, "opening");
}

function perk_random_idle()
{
	//SELF == WUNDERFIZZ MACHINE
	
	self clientfield::set ("wunderfizz_client_stone_emmissive_blink", 0);
	
	if (IsDefined (level.perk_random_idle_effects_override))
		self [[level.perk_random_idle_effects_override]]();
		
	else
	{
		self clientfield::set ("wunderfizz_lightning_bolt_FX_toggle", 1);
		
		while (self.state == "idle")
			WAIT_SERVER_FRAME;
			
		self clientfield::set ("wunderfizz_lightning_bolt_FX_toggle", 0);
	}
}

function perk_random_arrive()
{
	//SELF == WUNDERFIZZ MACHINE
	
	while(self GetZbarrierPieceState (0) == "opening")
		WAIT_SERVER_FRAME;
		
	self notify ("arrived");
}

function perk_random_leaving()
{
	//SELF == WUNDERFIZZ MACHINE
	
	while (self GetZbarrierPieceState (0) == "closing")
		WAIT_SERVER_FRAME;
		
	WAIT_SERVER_FRAME;
	
	self thread set_perk_random_machine_state ("away");
}

function set_perk_random_machine_state(state)
{
	//SELF == WUNDERFIZZ MACHINE
	
	wait .1;
	
	for (i = 0; i < self GetNumZbarrierPieces(); i++)
		self HideZbarrierPiece (i);
		
	self notify ("zbarrier_state_change");
	
	self [[level.perk_random_machine_state_func]] (state);
}

function process_perk_random_machine_state (state)
{
	//SELF == WUNDERFIZZ MACHINE
	
	switch (state)
	{
		case "arrive":
		{
			self ShowZbarrierPiece (0);
			self ShowZbarrierPiece (1);
			self SetZbarrierPieceState (0, "opening");
			self SetZbarrierPieceState (1, "opening");
			
			self clientfield::set("wunderfizz_set_client_light_state", 1);
			
			self thread perk_random_arrive();
			
			self.state = "arrive";
			
			break;
		}
		
		case "idle":
		{
			self ShowZbarrierPiece (5);
			self ShowZbarrierPiece (2);
			self SetZbarrierPieceState (2, "opening");
			
			self clientfield::set ("wunderfizz_set_client_light_state", 1);
			
			self.state = "idle";
			
			self thread perk_random_idle();
			
			break;
		}
		
		case "power_off":
		{
			self ShowZbarrierPiece (2);
			self SetZbarrierPieceState (2, "closing");
			
			self clientfield::set ("wunderfizz_set_client_light_state", 0);
			
			self.state = "power_off";
			
			break;
		}
		
		case "vending":
		{
			self ShowZbarrierPiece (5);
			self ShowZbarrierPiece (3);
			self ShowZbarrierPiece (4);
			
			self clientfield::set ("wunderfizz_set_client_light_state", 1);
			
			self.state = "vending";
			
			self thread perk_random_vending();
			
			break;
		}
		
		case "leaving":
		{
			self ShowZbarrierPiece (1);
			self ShowZbarrierPiece (0);
			self SetZbarrierPieceState (0, "closing");
			self SetZbarrierPieceState (1, "closing");
			
			self clientfield::set ("wunderfizz_set_client_light_state", 3);
			
			self thread perk_random_leaving();
			
			self.state = "leaving";
			
			break;
		}
		
		case "away":
		{
			self ShowZbarrierPiece (2);
			self SetZbarrierPieceState (2, "closing");
			
			self clientfield::set ("wunderfizz_set_client_light_state", 3);
			
			self.state = "away";
			
			break;
		}
		
		case "initial":
		{
			self ShowZbarrierPiece (3);
			self SetZbarrierPieceState (3, "opening");
			self ShowZbarrierPiece (5);
			
			self clientfield::set ("wunderfizz_set_client_light_state", 0);
			
			self.state = "initial";
			
			break;
		}
		
		default:
		{
			if (IsDefined (level.custom_perk_random_state_handler))
				self [[level.custom_perk_random_state_handler]] (state);
				
			break;
		}
	}
}

function get_weapon_model (weapon)
{
	//SELF == LEVEL
	
	return weapon.worldmodel;
}

function perk_random_is_power_on (n_power_index)
{
	if (IsDefined (n_power_index))
	{
		str_power = "power_on" + n_power_index;
		n_power_on = level flag::get (str_power);
	}
	
	else
	{
		if (IsDefined (level.zm_custom_perk_random_power_flag))
			n_power_on = level flag::get (level.zm_custom_perk_random_power_flag);
			
		else
			n_power_on = level flag::get ("power_on");
	}
	
	return n_power_on;
}

function include_perks_in_wunderfizz ()
{
	//SELF == LEVEL
	
	if (WUNDERFIZZ_INCLUDE_ALL_PERKS == 1)
	{
		if (IsDefined (level._custom_perks) && level._custom_perks.size > 0)
		{
			a_keys = GetArrayKeys (level._custom_perks);
			
			foreach (perk in a_keys)
				include_perk_in_random_rotation (perk);
		}
	}
	
	else
	{
		if (WUNDERFIZZ_INCLUDE_DEFAULT_PERKS == 1)
		{
			include_perk_in_random_rotation (PERK_ADDITIONAL_PRIMARY_WEAPON);
			include_perk_in_random_rotation (PERK_DEAD_SHOT);
			include_perk_in_random_rotation (PERK_DOUBLETAP2);
			include_perk_in_random_rotation (PERK_JUGGERNOG);
			include_perk_in_random_rotation (PERK_QUICK_REVIVE);
			include_perk_in_random_rotation (PERK_SLEIGHT_OF_HAND);
			include_perk_in_random_rotation (PERK_STAMINUP);
		}
		
		if (AMMO_AMERICANO_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (AMMO_AMERICANO_PERK);
			
		if (ASTRO_ALE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ASTRO_ALE_PERK);
			
		if (ATOMIC_LIQUEUR_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ATOMIC_LIQUEUR_PERK);
			
		if (BANANA_COLADA_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BANANA_COLADA_PERK);
			
		if (BANDOLIER_BANDIT_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BANDOLIER_BANDIT_PERK);
			
		if (BLAZE_PHASE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BLAZE_PHASE_PERK);
			
		if (BLEEDING_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BLEEDING_PERK);
			
		if (BLOOD_WOLF_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BLOOD_WOLF_PERK);
			
		if (BRAWLSTAR_PUNCH_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BRAWLSTAR_PUNCH_PERK);
			
		if (BRIMSTONE_BRAMBLE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BRIMSTONE_BRAMBLE_PERK);
			
		if (BULL_ICE_BLAST_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (BULL_ICE_BLAST_PERK);
			
		if (CRACK_SHOT_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (CRACK_SHOT_PERK);
			
		if (CRUSADERS_ALE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (CRUSADERS_ALE_PERK);
			
		if (CRYO_SLIDE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (CRYO_SLIDE_PERK);
			
		if (DEATH_PERCEPTION_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DEATH_PERCEPTION_PERK);
			
		if (DIVINE_ALE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DIVINE_ALE_PERK);
			
		if (DOUBLE_DEW_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DOUBLE_DEW_PERK);
			
		if (DOUBLETAP1_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DOUBLETAP1_PERK);
			
		if (DOUBLETAP3_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DOUBLETAP3_PERK);
			
		if (DYING_WISH_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (DYING_WISH_PERK);
			
		if (ELECTRIC_CHERRY_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ELECTRIC_CHERRY_PERK);
			
		if (ELEMENTAL_POP_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ELEMENTAL_POP_PERK);
			
		if (ETHEREAL_RAZOR_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ETHEREAL_RAZOR_PERK);
			
		if (FIGHTERS_FIZZ_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (FIGHTERS_FIZZ_PERK);
			
		if (GAMBLERS_GIBSON_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (GAMBLERS_GIBSON_PERK);
			
		if (GLITCHING_GIN_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (GLITCHING_GIN_PERK);
			
		if (ICU_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ICU_PERK);
			
		if (MADGAZ_MOONSHINE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (MADGAZ_MOONSHINE_PERK);
			
		if (MAGNET_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (MAGNET_PERK);
			
		if (MASOCHIST_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (MASOCHIST_PERK);
			
		if (MEDUSAS_MAURESQUE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (MEDUSAS_MAURESQUE_PERK);
			
		if (MUSCLE_MILK_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (MUSCLE_MILK_PERK);
			
		if (PHD_FLOPPER_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (PHD_FLOPPER_PERK);
			
		if (PHD_SLIDER_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (PHD_SLIDER_PERK);
			
		if (PICKPOCKET_PALOMA_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (PICKPOCKET_PALOMA_PERK);
			
		if (POWER_AID_PUNCH_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (POWER_AID_PUNCH_PERK);
			
		if (PRICKLING_PROSECCO_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (PRICKLING_PROSECCO_PERK);
			
		if (ROULETTE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ROULETTE_PERK);
			
		if (REBATE_ROSE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (REBATE_ROSE_PERK);
			
		if (SALVAGE_SHAKE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SALVAGE_SHAKE_PERK);
			
		if (SAMURAIS_SPIRIT_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SAMURAIS_SPIRIT_PERK);
			
		if (SIDE_STEP_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SIDE_STEP_PERK);
			
		if (SLIP_AWAY_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SLIP_AWAY_PERK);
			
		if (SLURPENTINE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SLURPENTINE_PERK);
			
		if (SNAILS_PACE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SNAILS_PACE_PERK);
			
		if (SPACE_CADET_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SPACE_CADET_PERK);
			
		if (SPECTRAL_SHAKE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (SPECTRAL_SHAKE_PERK);
			
		if (STONE_COLD_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (STONE_COLD_PERK);
			
		if (TACTIQUILLA_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (TACTIQUILLA_PERK);
			
		if (TIME_OUT_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (TIME_OUT_PERK);
			
		if (TIMESLIP_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (TIMESLIP_PERK);
			
		if (TOMBSTONE_SODA_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (TOMBSTONE_SODA_PERK);
			
		if (VERRUCKT_JUG_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (VERRUCKT_JUG_PERK);
			
		if (VICTORIOUS_TORTOISE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (VICTORIOUS_TORTOISE_PERK);
			
		if (VIGOR_RUSH_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (VIGOR_RUSH_PERK);
			
		if (WALL_POWER_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (WALL_POWER_PERK);
			
		if (WIDOWS_WINE_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (WIDOWS_WINE_PERK);
			
		if (WINDRUNNER_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (WINDRUNNER_PERK);
			
		if (WINTERS_WAIL_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (WINTERS_WAIL_PERK);
			
		if (ZOMBSHELL_INCLUDE_IN_WUNDERFIZZ == 1)
			include_perk_in_random_rotation (ZOMBSHELL_PERK);
	}
}


// ======================================================================================================
// Zombshell
// ======================================================================================================

function zombshell_think (player)
{
	//SELF == AI
	
	if (IsDefined (player.zombshell_field_active) && player.zombshell_field_active == 0 &&
		IsDefined (player.zombshell_on_cooldown) && player.zombshell_on_cooldown == 0)
		if (RandomIntRange (1, 101) <= ZOMBSHELL_FIELD_START)
			self thread zombshell_start (player);
}

function zombshell_start (player)
{
	//SELF == AI
	
	player endon (ZOMBSHELL_PERK + "_stop");
	level endon ("end_game");
	level endon ("game_over");
	
	player.zombshell_field_active = 1;
	
	player notify ("cooldown_bar_update");
	
	WAIT_SERVER_FRAME;
	
	field_orb = Spawn ("script_model", self.origin + (0, 0, 30));
	field_orb SetModel ("tag_origin");
	field_orb.angles = self.angles + (-90, 0, 0);
	
	field_orb thread zombshell_field_logic (player);
	
	field_orb_fx = PlayFxOnTag (ZOMBSHELL_FIELD_START_FX, field_orb, "tag_origin");
	PlaySoundAtPosition ("ZOMBSHELL_FIELD_START_SOUND", self.origin);
}

function zombshell_field_logic (player)
{
	//SELF == FX

	player endon (ZOMBSHELL_PERK + "_stop");
	level endon ("end_game");
	level endon ("game_over");
	
	player thread zombshell_cooldown();
	
	time = 0;
	
	while (time < ZOMBSHELL_FIELD_ACTIVE && (IsDefined (player.west_hasperk_zombshell) && player.west_hasperk_zombshell == 1))
	{
		zoms = GetAITeamArray (level.zombie_team);
	
		if (IsDefined (zoms) && zoms.size > 0)
		{
			zoms_in_range = util::get_array_of_closest (self.origin, zoms, undefined, undefined, ZOMBSHELL_FIELD_RANGE);
		
			if (IsDefined (zoms_in_range) && zoms_in_range.size > 0)
			{
				foreach (zom in zoms)
				{
					if (Distance (self.origin, zom.origin) <= ZOMBSHELL_FIELD_RANGE)
						zom.zombshell_within_range = 1;
						
					else
						zom.zombshell_within_range = 0;
				}
				
				foreach (zom in zoms_in_range)
					if (!IsDefined (zom.ai_too_op_for_zombshell) || zom.ai_too_op_for_zombshell == 0) //If AI is NOT protected from Zombshell
						zom thread zm_utility::slowdown_ai ("zombshell_field");
			}
		}
				
		wait .5;
		time += .5;
		
		bar_height = (time / ZOMBSHELL_FIELD_ACTIVE) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (player.zombshell_bar))
			player.zombshell_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, COOLDOWN_BAR_HEIGHT - bar_height);
	}
	
	player.zombshell_field_active = 0;
	player.zombshell_on_cooldown = 1;

	zoms = GetAITeamArray (level.zombie_team);
	
	if (IsDefined (zoms) && zoms.size > 0)
		foreach (zom in zoms)
			zom.zombshell_within_range = 0;
		
	
	player notify ("zombshell_cooldown");
	
	self Delete();
}

function zombshell_cooldown ()
{
	//SELF == PLAYER

	self endon (ZOMBSHELL_PERK + "_stop");
	self endon ("disconnect");
	level endon ("end_game");
	level endon ("game_over");
	
	self waittill ("zombshell_cooldown");
	
	time = 0;
	
	while (time < ZOMBSHELL_FIELD_COOLDOWN)
	{
		wait .5;
		time += .5;
		
		bar_height = (time / ZOMBSHELL_FIELD_COOLDOWN) * COOLDOWN_BAR_HEIGHT;
		
		if (bar_height < 1)
			bar_height = 1;
			
		else if (bar_height > COOLDOWN_BAR_HEIGHT)
			bar_height = COOLDOWN_BAR_HEIGHT;
			
		if (!IsInt (bar_height))
			bar_height = Int (bar_height);
			
		if (IsDefined (self.zombshell_bar))
			self.zombshell_bar ScaleOverTime (.5, COOLDOWN_BAR_WIDTH, bar_height);
	}
	
	self.zombshell_on_cooldown = 0;
	
	self notify ("cooldown_bar_update");
}


// ======================================================================================================
// Perk Return Functions
// ======================================================================================================

function war_perk_return_spawn()
{
	//SELF == PERK MACHINE TRIGS

	if (level flag::exists ("initial_blackscreen_passed"))
		level flag::wait_till ("initial_blackscreen_passed");

	self war_perk_return_unitrigger_think (self.script_noteworthy);
}

function war_perk_return_unitrigger_think (str_perk)
{
	//SELF == PERK RETURN TRIGS

	self endon ("kill_trigger");

	self create_unitrigger (undefined, 80, &war_perk_return_visibility_and_update_prompt, str_perk);

	while (IsDefined (self))
	{
		self waittill ("trigger_activated", player);

		removed_perk = player war_remove_perk (str_perk);

		if (PERK_RETURN_REFUND_POINTS == 1 && PERK_RETURN_REFUND_PERCENT > 0)
		{
			return_amount = level._custom_perks [str_perk].cost;
			
			//Fix for solo QR providing zero points for some reason
			if ((zm_perks::use_solo_revive() && str_perk == "specialty_quickrevive") || return_amount <= 0)
				return_amount = 500;
				
			return_amount = zm_utility::round_up_score ((return_amount * PERK_RETURN_REFUND_PERCENT) / 100, 10);
			
			player common_give_points (return_amount);
		}
	}
}

function war_perk_return_visibility_and_update_prompt (player)
{
	can_use = self war_perk_return_visibility_unitrigger (player);

	if (IsDefined (self.hint_string))
		self SetHintString (self.hint_string);

	return can_use;
}

function war_perk_return_visibility_unitrigger (player)
{
	if (array::contains (player.perks_active, self.stub.str_perk))
	{
		//if (!IS_TRUE(self.stub.related_parent.power_on))
			//self.stub.related_parent SetInvisibleToPlayer (player, true); //Disable vending_trigger if power is off

		if (PERK_RETURN_REFUND_POINTS == 1)
			self.hint_string = PERK_RETURN_STRING_REFUND;
			
		else
			self.hint_string = PERK_RETURN_STRING_REMOVE;

		self SetInvisibleToPlayer (player, false);
		
		return true;
	}
	
	else
	{
		//Re-enable vending_trigger after return is done
		self.stub.related_parent SetInvisibleToPlayer (player, false);
		self SetInvisibleToPlayer (player, true);
		self.hint_string = "";
		
		return false;
	}
}

function war_remove_perk (perk)
{
	//SELF == PLAYER

	if (!IsDefined (perk) || !self HasPerk (perk))
		return;

	perk_str = perk + "_stop";
	self notify (perk_str);
	
	if (PERK_RETURN_LOSE_QR_USE_ON_REFUND == 1)
		if (zm_perks::use_solo_revive() && perk == "specialty_quickrevive")
			self.lives--;
			
	return perk;
}

function create_unitrigger (str_hint, n_radius = 32, func_prompt_and_visibility = &zm_unitrigger::unitrigger_prompt_and_visibility, str_perk = undefined, func_unitrigger_logic =  &zm_unitrigger::unitrigger_logic, s_trigger_type = "unitrigger_radius_use")
{
	//SELF == PERK RETURN TRIGS

	self.s_unitrigger = SpawnStruct();
	self.s_unitrigger.origin = self.origin;
	self.s_unitrigger.angles = self.angles;
	self.s_unitrigger.script_unitrigger_type = s_trigger_type;
	self.s_unitrigger.cursor_hint = "HINT_NOICON";
	self.s_unitrigger.hint_string = str_hint;
	self.s_unitrigger.require_look_at = 1;
	self.s_unitrigger.related_parent = self;
	self.s_unitrigger.radius = n_radius;
	self.s_unitrigger.script_width = n_radius;
	self.s_unitrigger.script_height = n_radius;
	self.s_unitrigger.script_length = n_radius;

	//Set up str_perk variable for war_perk_return_visibility_unitrigger() 
	self.s_unitrigger.str_perk = str_perk;

	zm_unitrigger::unitrigger_force_per_player_triggers (self.s_unitrigger, 1);
	self.s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
	zm_unitrigger::register_static_unitrigger (self.s_unitrigger, func_unitrigger_logic);
}


// ======================================================================================================
// Spare Change
// ======================================================================================================

function spare_change (str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle")
{
	//SELF == LEVEL
	
	bump_triggers = GetEntArray (str_trigger, "targetname");
	
	if (IsDefined (bump_triggers) && bump_triggers.size > 0)
		foreach (trig in bump_triggers)
			if (trig.script_sound === str_sound)
				trig thread check_for_change();
}

function check_for_change()
{
	//SELF == TRIGGER
	
	self endon ("death");
	
	for (;;)
	{
		self waittill ("trigger", player);
		
		if (player GetStance() == "prone")
		{
			player thread common_give_points (100);
			zm_utility::play_sound_at_pos ("purchase", player.origin);
			
			break;
		}
		
		wait .1;
	}
}
