#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\shared\spawner_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#using scripts\shared\ai\zombie_utility;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;

//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
//#using scripts\zm\_zm_powerup_weapon_minigun;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

//*****************************************************************************
// MAIN
//*****************************************************************************

function main()
{
	zm_usermap::main();
	
	level._zombie_custom_add_weapons =&custom_add_weapons;
	
	//Setup the levels Zombie Zone Volumes
	level.zones = [];
	level.zone_manager_init_func =&usermap_test_zone_init;
	init_zones[0] = "start_zone";
	level thread zm_zonemgr::manage_zones( init_zones );

	level.dog_rounds_allowed = false;

	level.pathdist_type = PATHDIST_ORIGINAL;

	zombie_utility::set_zombie_var( "zombie_spawn_delay", 2.0, true );
	zombie_utility::set_zombie_var( "zombie_between_round_time", 10 );
	level.func_get_zombie_spawn_delay = &endless_get_zombie_spawn_delay;

	// Faster speed ramp than stock (x4): round * 10, where 0-35 walk, 36-70 run, 71+ sprint
	zombie_utility::set_zombie_var( "zombie_move_speed_multiplier", 10 );
	endless_update_move_speed();

	level thread endless_spawning();
	level thread endless_round_advance();

	level thread power_light();
}

// Script lighting states are 0-based: script 0 = Radiant lighting state 1, script 1 = Radiant lighting state 2.
// The usermap starts in script 1 (Radiant 2), where main_light is unticked, so it stays off until the power is turned on.
function power_light()
{
	level flag::wait_till( "power_on" );

	level util::set_lighting_state( 0 );
}

// Keeps refilling the round's zombie queue so the round never ends
function endless_spawning()
{
	while ( 1 )
	{
		wait 15;
		level.zombie_total = 115;
	}
}

// Advances the round in place once 1.5x the stock round size worth of new zombies has spawned
function endless_round_advance()
{
	level flag::wait_till( "start_zombie_round_logic" );

	endless_reset_spawn_count();
	spawner::add_archetype_spawn_function( "zombie", &endless_on_zombie_spawned );

	while ( 1 )
	{
		// 1.5x the stock count, rounded up
		n_round_size = zm::get_zombie_count_for_round( level.round_number, level.players.size );
		n_spawns_needed = Int( ( n_round_size * 3 + 1 ) / 2 );
		while ( endless_new_spawn_count() < n_spawns_needed )
		{
			level waittill( "endless_zombie_spawned" );
		}

		endless_reset_spawn_count();
		endless_next_round();
	}
}

function endless_on_zombie_spawned()
{
	level.endless_round_spawns++;
	level notify( "endless_zombie_spawned" );
}

// Stock bumps zombie_total_subtract whenever a zombie is put back in the queue to be respawned,
// so taking that growth off the raw spawn count leaves only brand-new zombies
function endless_new_spawn_count()
{
	return level.endless_round_spawns - ( level.zombie_total_subtract - level.endless_round_requeues_start );
}

function endless_reset_spawn_count()
{
	level.endless_round_spawns = 0;
	level.endless_round_requeues_start = level.zombie_total_subtract;
}

// Same difficulty updates the stock round_think does between rounds, without ending the round
function endless_next_round()
{
	zm::set_round_number( 1 + zm::get_round_number() );
	SetRoundsPlayed( zm::get_round_number() );
	endless_update_move_speed();

	level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]]( zm::get_round_number() );
	zombie_utility::ai_calculate_health( zm::get_round_number() );

	if ( !IS_TRUE( level.headshots_only ) )
	{
		level thread zm::award_grenades_for_survivors();
	}
}

// Uses the current round (stock uses the round that just ended)
function endless_update_move_speed()
{
	if ( level.gamedifficulty == 0 )
	{
		level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
	}
	else
	{
		level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
	}
}

// Stock spawn delay decay, but always from a 2.0 base regardless of player count
function endless_get_zombie_spawn_delay( n_round )
{
	if ( n_round > 60 )
	{
		n_round = 60;
	}

	n_delay = 2.0;
	for ( i = 1; i < n_round; i++ )
	{
		n_delay *= 0.95;

		if ( n_delay <= 0.1 )
		{
			n_delay = 0.1;
			break;
		}
	}

	return n_delay;
}

function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

