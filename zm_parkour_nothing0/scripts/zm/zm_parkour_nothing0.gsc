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
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_ai_dogs;
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

#precache( "fx", "lighthouse_beam" );
#precache( "fx", "void_pole_light" );
#precache( "fx", "fire/fx_fire_ground_rubble_sm_50x50" );
#precache( "fx", "light/fx_light_fire_flicker_noshad_small" );

// The safety-circle teleport uses the Giant's teleporter overlay; overlays must be registered during system init
REGISTER_SYSTEM( "zm_parkour_nothing0", &safety_overlay_init, undefined )

function safety_overlay_init()
{
	visionset_mgr::register_info( "overlay", "zm_factory_teleport", VERSION_SHIP, 61, 1, true );
}

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

	level thread lighthouse_switch();

	level._effect["lighthouse_beam"] = "lighthouse_beam";
	level thread lighthouse_beam();

	level._effect["void_pole_light"] = "void_pole_light";
	level._effect["void_campfire"] = "fire/fx_fire_ground_rubble_sm_50x50";
	level._effect["void_campfire_light"] = "light/fx_light_fire_flicker_noshad_small";
	level thread void_pole();
	level thread void_campfires();

	level thread walkway_trap();

	level flag::init( "lighthouse_reached" );
	level thread safety_circles_init();
	level thread lighthouse_reached_watch();
	level thread safety_sign();
	callback::on_spawned( &safety_player_think );
}

// Green circles under the paths: falling or downed players shoot one to teleport to safety
function safety_circles_init()
{
	foreach ( disc in GetEntArray( "safety_circle", "targetname" ) )
	{
		disc NotSolid();
	}

	level.safety_circles = struct::get_array( "safety_circle_center", "targetname" );
	level.safety_dests = [];
	foreach ( dest in struct::get_array( "safety_dest", "targetname" ) )
	{
		level.safety_dests[dest.script_noteworthy] = dest;
	}
}

// Before anyone reaches the lighthouse island, circles send players to spawn; after, to the lighthouse
function lighthouse_reached_watch()
{
	while ( 1 )
	{
		foreach ( player in GetPlayers() )
		{
			if ( Distance2DSquared( player.origin, ( 0, 24576, 0 ) ) < 400 * 400 && player.origin[2] > -40 )
			{
				level flag::set( "lighthouse_reached" );
				return;
			}
		}
		wait 0.5;
	}
}

function safety_sign()
{
	sign = struct::get( "safety_sign", "targetname" );
	if ( !isdefined( sign ) )
	{
		return;
	}

	level flag::wait_till( "initial_blackscreen_passed" );
	make_use_trigger( sign.origin, 72, 96, "shoot the green circles for 'safety'." );
}

function safety_player_think()
{
	self notify( "safety_player_think" );
	self endon( "safety_player_think" );
	self endon( "disconnect" );

	self thread safety_bottom_watch();

	while ( 1 )
	{
		self waittill( "weapon_fired" );
		if ( IS_TRUE( self.safety_teleporting ) || !isdefined( level.safety_circles ) )
		{
			continue;
		}

		if ( isdefined( self safety_circle_aimed_at() ) )
		{
			self thread safety_teleport();
		}
	}
}

// Ray from the eye along the aim, against each circle's plane; only counts from below (the discs only draw underneath)
function safety_circle_aimed_at()
{
	eye = self GetPlayerCameraPos();
	dir = AnglesToForward( self GetPlayerAngles() );
	if ( dir[2] <= 0.05 )
	{
		return undefined;
	}

	foreach ( circle in level.safety_circles )
	{
		if ( eye[2] >= circle.origin[2] )
		{
			continue;
		}

		hit = eye + dir * ( ( circle.origin[2] - eye[2] ) / dir[2] );
		radius = Float( circle.radius );
		if ( Distance2DSquared( hit, circle.origin ) <= radius * radius )
		{
			return circle;
		}
	}
	return undefined;
}

// Hitting the bottom of the sky always downs the player, whatever their perks; they can still shoot a circle while downed
function safety_bottom_watch()
{
	self endon( "safety_player_think" );
	self endon( "disconnect" );

	while ( 1 )
	{
		wait 0.1;
		if ( self.origin[2] < -2500 && IsAlive( self ) && self.sessionstate == "playing" && !self laststand::player_is_in_laststand() )
		{
			self DoDamage( self.health + 1000, self.origin, undefined, undefined, "none", "MOD_UNKNOWN" );
			wait 1;
		}
	}
}

// Same look as the Giant's teleporters; downed players stay downed
function safety_teleport()
{
	self endon( "disconnect" );
	self.safety_teleporting = true;

	dest = level.safety_dests["spawn"];
	if ( level flag::get( "lighthouse_reached" ) )
	{
		dest = level.safety_dests["lighthouse"];
	}

	// Hold them in the air while the effect plays
	anchor = Spawn( "script_origin", self.origin );
	self LinkTo( anchor );
	self FreezeControls( true );
	visionset_mgr::activate( "overlay", "zm_factory_teleport", self );

	wait 1.5;

	self Unlink();
	anchor Delete();
	self SetOrigin( dest.origin );
	self SetPlayerAngles( dest.angles );
	self SetVelocity( ( 0, 0, 0 ) );
	visionset_mgr::deactivate( "overlay", "zm_factory_teleport", self );
	self FreezeControls( false );
	self ShellShock( "electrocution", 2 );

	self.safety_teleporting = false;
}

// Walkway trap: 5000 sets the walkway on fire for 2 minutes (kills zombies, burns players), then a 1 minute cooldown
function walkway_trap()
{
	handle = GetEnt( "walkway_trap_handle", "targetname" );
	area = struct::get( "walkway_trap", "targetname" );
	if ( !isdefined( handle ) || !isdefined( area ) )
	{
		return;
	}

	tokens = StrTok( area.script_noteworthy, " " );
	y0 = Float( tokens[0] );
	y1 = Float( tokens[1] );

	level flag::wait_till( "initial_blackscreen_passed" );

	trig = make_use_trigger( handle.origin - ( 0, 24, 45 ), 40, 80, "" );
	while ( 1 )
	{
		trig SetHintString( "Hold ^3[{+activate}]^7 to set the walkway on fire [Cost: 5000]" );
		trig waittill( "trigger", player );
		if ( player.score < 5000 )
		{
			player zm_audio::create_and_play_dialog( "general", "outofmoney" );
			continue;
		}
		player zm_score::minus_to_player_score( 5000 );

		trig SetHintString( "The walkway is on fire" );
		handle RotateRoll( -90, 0.3 );

		fires = [];
		for ( y = y0; y <= y1; y += 42 )
		{
			fires[fires.size] = play_loop_fx( "void_campfire", ( 0, y, 0 ) );
		}

		end_time = GetTime() + 120000;
		while ( GetTime() < end_time )
		{
			foreach ( zombie in GetAITeamArray( level.zombie_team ) )
			{
				if ( IsAlive( zombie ) && on_walkway( zombie.origin, y0, y1 ) )
				{
					zombie DoDamage( zombie.health + 666, zombie.origin );
				}
			}

			foreach ( player in GetPlayers() )
			{
				if ( IsAlive( player ) && !player laststand::player_is_in_laststand() && on_walkway( player.origin, y0, y1 ) )
				{
					player DoDamage( 10, player.origin );
				}
			}
			wait 0.5;
		}

		foreach ( fire in fires )
		{
			fire Delete();
		}

		trig SetHintString( "The trap is cooling down" );
		handle RotateRoll( 90, 0.3 );
		wait 60;
	}
}

function on_walkway( origin, y0, y1 )
{
	return Abs( origin[0] ) < 40 && origin[1] >= y0 - 16 && origin[1] <= y1 + 16 && origin[2] > -40 && origin[2] < 120;
}

// Spawns a use trigger players can see, with a raw hint string
function make_use_trigger( origin, radius, height, hint )
{
	trig = Spawn( "trigger_radius_use", origin, 0, radius, height );
	trig TriggerIgnoreTeam();
	trig SetVisibleToAll();
	trig SetCursorHint( "HINT_NOICON" );
	trig SetHintString( hint );
	return trig;
}

// Plays a looping fx on a tag_origin at origin; returns the model so it can be cleaned up
function play_loop_fx( fx_name, origin )
{
	fx_model = Spawn( "script_model", origin );
	fx_model SetModel( "tag_origin" );
	util::wait_network_frame();
	PlayFXOnTag( level._effect[fx_name], fx_model, "tag_origin" );
	return fx_model;
}

// The Void's centre pole: dark until its switch is pulled, then a faulty flickering light forever
function void_pole()
{
	handle = GetEnt( "void_pole_switch_handle", "targetname" );
	lamp = struct::get( "void_pole_light", "targetname" );
	if ( !isdefined( handle ) || !isdefined( lamp ) )
	{
		return;
	}

	level flag::wait_till( "initial_blackscreen_passed" );

	trig = make_use_trigger( handle.origin - ( 0, 24, 45 ), 40, 80, "Hold ^3[{+activate}]^7 to turn on the light" );
	trig waittill( "trigger" );
	trig Delete();

	handle RotateRoll( -90, 0.3 );
	handle waittill( "rotatedone" );

	play_loop_fx( "void_pole_light", lamp.origin );
}

// Campfires on the Void platforms: free to light, stay lit, burn anyone standing in them
function void_campfires()
{
	level flag::wait_till( "initial_blackscreen_passed" );

	foreach ( fire in struct::get_array( "void_campfire", "targetname" ) )
	{
		fire thread void_campfire_think();
	}
}

function void_campfire_think()
{
	trig = make_use_trigger( self.origin, 48, 64, "Hold ^3[{+activate}]^7 to light the fire" );
	trig waittill( "trigger" );
	trig Delete();

	play_loop_fx( "void_campfire", self.origin );
	play_loop_fx( "void_campfire_light", self.origin + ( 0, 0, 24 ) );

	while ( 1 )
	{
		foreach ( player in GetPlayers() )
		{
			if ( !IsAlive( player ) || player laststand::player_is_in_laststand() )
			{
				continue;
			}

			// Standing in the fire: within the stone ring, on the platform
			if ( Distance2DSquared( player.origin, self.origin ) < 32 * 32 && Abs( player.origin[2] - self.origin[2] ) < 40 )
			{
				player DoDamage( 10, self.origin );
			}
		}
		wait 0.5;
	}
}

// Spot light on the lighthouse lamp, sweeping a full circle every 20 seconds
function lighthouse_beam()
{
	level flag::wait_till( "initial_blackscreen_passed" );

	beam = Spawn( "script_model", ( 0, 24576, 620 ) );
	beam SetModel( "tag_origin" );
	beam.angles = ( 2, 270, 0 );	// facing the map (south), 2 degrees down
	util::wait_network_frame();
	PlayFXOnTag( level._effect["lighthouse_beam"], beam, "tag_origin" );

	while ( 1 )
	{
		beam RotateYaw( 360, 20 );
		beam waittill( "rotatedone" );
	}
}

// Switch inside the lighthouse: pulling it sets off a nuke and starts the endgame, once per game
function lighthouse_switch()
{
	trig = GetEnt( "lighthouse_switch", "targetname" );
	if ( !isdefined( trig ) )
	{
		return;
	}

	handle = GetEnt( "lighthouse_switch_handle", "targetname" );

	trig SetCursorHint( "HINT_NOICON" );
	trig SetHintString( "Hold ^3[{+activate}]^7 to Start endgame" );
	trig waittill( "trigger", player );
	trig Delete();

	// Same throw as the stock power switch handle
	if ( isdefined( handle ) )
	{
		handle RotateRoll( -90, 0.3 );
		handle waittill( "rotatedone" );
	}

	nuke_origin = SpawnStruct();
	nuke_origin.origin = player.origin;
	level thread zm_powerup_nuke::nuke_powerup( nuke_origin, player.team );

	start_endgame( player );
}

// Endgame: 4x faster spawning and every zone spawns zombies
function start_endgame( player )
{
	level.endgame_active = true;
	level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]]( zm::get_round_number() );

	// Open every remaining door for free (the force arg skips the cost), which also enables their zones
	foreach ( trig in GetEntArray( "zombie_debris", "targetname" ) )
	{
		trig notify( "trigger", player, true );
	}

	// Every enabled zone counts as occupied, so all of them are active for spawning
	level.zone_occupied_func = &endgame_zone_occupied;

	level thread endgame_dogs();
}

// Endgame: the odd dog mixed into the horde, from the dog locations of every (now active) zone
function endgame_dogs()
{
	while ( 1 )
	{
		wait RandomFloatRange( 10, 20 );
		zm_ai_dogs::special_dog_spawn( 1 );
	}
}

function endgame_zone_occupied( zone_name )
{
	return true;
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

	if ( IS_TRUE( level.endgame_active ) )
	{
		n_delay /= 4;
	}

	return n_delay;
}

function usermap_test_zone_init()
{
	level flag::init( "always_on" );
	level flag::set( "always_on" );

	// Linear chain north: the debris door into zN sets enter_zN
	zm_zonemgr::add_adjacent_zone( "start_zone", "z1", "enter_z1" );
	for ( i = 2; i <= 16; i++ )
	{
		zm_zonemgr::add_adjacent_zone( "z" + ( i - 1 ), "z" + i, "enter_z" + i );
	}

	// Approach, walkway and island: no door of its own, it opens with z16
	zm_zonemgr::add_adjacent_zone( "z16", "lighthouse", "enter_z16" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

