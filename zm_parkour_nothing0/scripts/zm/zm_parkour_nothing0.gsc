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
#insert scripts\zm\_zm_powerups.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_perks;
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
#using scripts\zm\_zm_perk_mule_lick;

//Westchief596
#using scripts\zm\_community_perk_collection;
#using scripts\zm\_community_perk_collection_setup;

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
#precache( "fx", "void_campfire_light" );
#precache( "fx", "fire/fx_fire_line_sm_evb" );
#precache( "fx", "endgame_arrow_light" );
#precache( "fx", "ambient_light" );
#precache( "model", "p7_zm_vending_packapunch_on" );

// The safety-circle teleport uses the Giant's teleporter overlay; overlays must be registered during system init
REGISTER_SYSTEM( "zm_parkour_nothing0", &safety_overlay_init, undefined )

function safety_overlay_init()
{
	visionset_mgr::register_info( "overlay", "zm_factory_teleport", VERSION_SHIP, 61, 1, true );

	// Pack-a-Punch powerup: a shrunken PaP machine; in the regular drop pool, so as likely as an Insta-Kill
	zm_powerups::register_powerup( "pap_powerup", &grab_pap_powerup, &setup_pap_powerup );
	zm_powerups::add_zombie_powerup( "pap_powerup", "p7_zm_vending_packapunch_on", undefined, &zm_powerups::func_should_always_drop, POWERUP_ONLY_AFFECTS_GRABBER, !POWERUP_ANY_TEAM, !POWERUP_ZOMBIE_GRABBABLE );
}

function setup_pap_powerup()
{
	self SetScale( 0.2 );
}

// Pack-a-Punches whatever the collector is holding
function grab_pap_powerup( player )
{
	weapon = player GetCurrentWeapon();
	if ( !zm_weapons::can_upgrade_weapon( weapon ) || zm_weapons::is_weapon_upgraded( weapon ) )
	{
		return;
	}

	upgraded = zm_weapons::get_upgrade_weapon( weapon );
	player TakeWeapon( weapon );
	player zm_weapons::weapon_give( upgraded, true, false, true, true );
	player GiveMaxAmmo( upgraded );
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

	// 3x the stock spawn limits (24 zombies alive, 31 AI actors); the endgame raises them to 6x.
	// The engine has its own AI cap, so very high values just stop at whatever it allows.
	level.zombie_ai_limit = 24 * 3;
	level.zombie_actor_limit = 31 * 3;

	// No perk limit (stock is 4); _zm_perks sets it during system init, so this overrides it
	level.perk_purchase_limit = 99;

	level.pathdist_type = PATHDIST_ORIGINAL;

	zombie_utility::set_zombie_var( "zombie_spawn_delay", 2.0, true );
	zombie_utility::set_zombie_var( "zombie_between_round_time", 10 );
	level.round_prestart_func = &wait_for_map_entrance;	// round 1 starts when the $0 spawn debris is bought
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
	level._effect["walkway_fire"] = "fire/fx_fire_line_sm_evb";
	level._effect["void_campfire_light"] = "void_campfire_light";	// stock flicker light at 80%
	level thread void_pole();
	level thread void_campfires();

	level thread walkway_trap();

	level thread dogs_match_zombie_health();
	level thread void_door_dogs();
	level thread perk_bottles();
	if ( isdefined( level.zombie_powerups["fire_sale"] ) )
	{
		level.zombie_powerups["fire_sale"].func_should_drop_with_regular_powerups = &fire_sale_can_drop;

		// Drops cycle through level.zombie_powerup_array (one entry per powerup): two more entries = 3x as likely
		level.zombie_powerup_array[level.zombie_powerup_array.size] = "fire_sale";
		level.zombie_powerup_array[level.zombie_powerup_array.size] = "fire_sale";
		level.zombie_powerup_array = array::randomize( level.zombie_powerup_array );
	}

	level._effect["ambient_light"] = "ambient_light";
	level thread ambient_light_switch();

	level thread godmode_switch();	// TESTING ONLY

	level flag::init( "endgame_started" );
	level._effect["endgame_arrow_light"] = "endgame_arrow_light";
	level thread endgame_exit();
	zm::register_player_damage_callback( &endgame_exit_no_fall_damage );

	level flag::init( "lighthouse_reached" );
	level thread safety_circles_init();
	level thread lighthouse_reached_watch();
	level thread safety_sign();
	callback::on_spawned( &safety_player_think );

	// Falling below the paths leaves every zone volume; stock would laugh and kill the player 0.5 s later
	// (_zm.gsc player_out_of_playable_area_monitor). The safety circles and the bottom-of-sky down handle
	// falling instead, and the endgame exit platform is outside every zone too.
	level.player_out_of_playable_area_monitor_callback = &allow_out_of_playable_area;
}

// Returning false stops the stock out-of-playable-area kill. Anyone below the paths is falling (or on the
// exit platform); the rest of the map is inside zone volumes, so this only ever skips those cases.
function allow_out_of_playable_area()
{
	return self.origin[2] > -24;
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
			if ( Distance2DSquared( player.origin, ( 0, 19648, 0 ) ) < 400 * 400 && player.origin[2] > -40 )
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
		self campfire_shot_check();

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
	level.walkway_trap_fires = [];
	level thread walkway_trap_endgame_shutdown( trig );
	level endon( "walkway_trap_disabled" );
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

		for ( y = y0; y <= y1; y += 32 )
		{
			level.walkway_trap_fires[level.walkway_trap_fires.size] = play_loop_fx( "walkway_fire", ( 0, y, 0 ) );
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

		walkway_trap_put_out();

		trig SetHintString( "The trap is cooling down" );
		handle RotateRoll( 90, 0.3 );
		wait 60;
	}
}

function walkway_trap_put_out()
{
	foreach ( fire in level.walkway_trap_fires )
	{
		if ( isdefined( fire ) )
		{
			fire Delete();
		}
	}
	level.walkway_trap_fires = [];
}

// The endgame puts the walkway fire out and the trap can't be used again
function walkway_trap_endgame_shutdown( trig )
{
	level flag::wait_till( "endgame_started" );
	level notify( "walkway_trap_disabled" );
	walkway_trap_put_out();
	trig SetHintString( "The trap is disabled" );
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

	level.void_campfires = struct::get_array( "void_campfire", "targetname" );
	foreach ( fire in level.void_campfires )
	{
		fire thread void_campfire_think();
	}
}

// Lit by using it or by shooting it (see campfire_shot_check)
function void_campfire_think()
{
	trig = make_use_trigger( self.origin, 48, 64, "Hold ^3[{+activate}]^7 to light the fire" );
	trig thread campfire_use_relay( self );
	self waittill( "light_campfire" );
	self.lit = true;
	if ( isdefined( trig ) )
	{
		trig Delete();
	}

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

function campfire_use_relay( fire )
{
	self endon( "death" );
	self waittill( "trigger" );
	fire notify( "light_campfire" );
}

// A shot landing within 40 units of an unlit campfire lights it (self = the player who fired)
function campfire_shot_check()
{
	if ( !isdefined( level.void_campfires ) )
	{
		return;
	}

	eye = self GetPlayerCameraPos();
	hit = BulletTrace( eye, eye + AnglesToForward( self GetPlayerAngles() ) * 8000, false, self )["position"];
	foreach ( fire in level.void_campfires )
	{
		if ( !IS_TRUE( fire.lit ) && DistanceSquared( hit, fire.origin ) < 40 * 40 )
		{
			fire notify( "light_campfire" );
		}
	}
}

// Spot light on the lighthouse lamp, sweeping a full circle every 20 seconds
function lighthouse_beam()
{
	level flag::wait_till( "initial_blackscreen_passed" );

	beam = Spawn( "script_model", ( 0, 19648, 620 ) );
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

	instant_nuke( player );
	start_endgame( player );
}

// Endgame: 4x faster spawning and every zone spawns zombies
function start_endgame( player )
{
	level.endgame_active = true;
	level flag::set( "endgame_started" );

	// Everyone heads back to spawn for the exit
	IPrintLnBold( "Now go back" );

	// From now on, dead players respawn at the lighthouse (just outside its door)
	level.check_valid_spawn_override = &endgame_respawn_at_lighthouse;
	level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]]( zm::get_round_number() );

	// Open every remaining door for free (the force arg skips the cost), which also enables their zones
	foreach ( trig in GetEntArray( "zombie_debris", "targetname" ) )
	{
		trig notify( "trigger", player, true );
	}

	// Every enabled zone counts as occupied, so all of them are active for spawning
	level.zone_occupied_func = &endgame_zone_occupied;

	// 6x the stock spawn limits
	level.zombie_ai_limit = 24 * 6;
	level.zombie_actor_limit = 31 * 6;

	level thread endgame_dogs();	// 100-dog wave with zombie spawns paused, then dogs at 1/3 the zombie rate
}

// Endgame: the odd dog mixed into the horde, from the dog locations of every (now active) zone
function endgame_dogs()
{
	zones = array( "z10", "z11", "z12", "z13", "z14", "z15", "z16" );

	// Zombie spawning paused (stock "spawn_zombies" flag) while 100 dogs come in at the zombie spawn rate
	level flag::clear( "spawn_zombies" );
	spawned = 0;
	while ( spawned < 100 )
	{
		if ( spawn_one_dog( zones ) )
		{
			spawned++;
		}
		wait level.zombie_vars["zombie_spawn_delay"];
	}
	level flag::set( "spawn_zombies" );

	// Afterwards: dogs keep coming at a third of the zombie spawn rate
	while ( 1 )
	{
		wait level.zombie_vars["zombie_spawn_delay"] * 3;
		spawn_one_dog( zones );
	}
}

// Dogs have the same health as a zombie of the current round.
// Stock: a dog spawns with level.dog_health * scr_dog_health_walk_multiplier (default 4); dog rounds (which ramp
// level.dog_health) are off in this map, so keep it in step with the zombie health and drop the multiplier.
function dogs_match_zombie_health()
{
	SetDvar( "scr_dog_health_walk_multiplier", "1" );
	while ( 1 )
	{
		if ( isdefined( level.zombie_health ) )
		{
			level.dog_health = level.zombie_health;
		}
		wait 1;
	}
}

// Opening the Void (debris9 sets enter_z10) lets loose 5 dogs
function void_door_dogs()
{
	level flag::wait_till( "initial_blackscreen_passed" );	// zone flags exist by now
	level flag::wait_till( "enter_z10" );
	spawn_dogs_now( 10, array( "z10" ) );
}

// Endgame exit: a green arrow off the spawn deck's west edge, a drop platform ~1000 below it and a $500 ending.
// None of it exists until the endgame starts.
function endgame_exit()
{
	arrow = GetEnt( "endgame_arrow", "targetname" );
	platform = GetEnt( "endgame_platform", "targetname" );
	models = GetEntArray( "endgame_ending_model", "targetname" );
	ending = struct::get( "endgame_ending", "targetname" );
	lamp = struct::get( "endgame_arrow_light", "targetname" );
	if ( !isdefined( arrow ) || !isdefined( platform ) || !isdefined( ending ) )
	{
		return;
	}

	// Platform bounds for the no-fall-damage check: "x0 x1 y0 y1"
	tokens = StrTok( ending.script_noteworthy, " " );
	level.endgame_exit_bounds = array( Float( tokens[0] ), Float( tokens[1] ), Float( tokens[2] ), Float( tokens[3] ) );
	level.endgame_exit_z = ending.origin[2];

	foreach ( ent in array( arrow, platform ) )
	{
		ent Hide();
		ent NotSolid();
	}
	foreach ( model in models )
	{
		model Hide();
	}

	level flag::wait_till( "endgame_started" );

	foreach ( ent in array( arrow, platform ) )
	{
		ent Show();
		ent Solid();
	}
	foreach ( model in models )
	{
		model Show();
	}
	if ( isdefined( lamp ) )
	{
		level thread play_loop_fx( "endgame_arrow_light", lamp.origin );
	}

	trig = make_use_trigger( ending.origin, 48, 96, "Hold ^3[{+activate}]^7 to end the game [Cost: 500]" );
	while ( 1 )
	{
		trig waittill( "trigger", player );
		if ( player.score < 500 )
		{
			player zm_audio::create_and_play_dialog( "general", "outofmoney" );
			continue;
		}

		player zm_score::minus_to_player_score( 500 );
		trig Delete();
		foreach ( model in models )
		{
			if ( model.script_noteworthy === "handle" )
			{
				model RotateRoll( -90, 0.3 );
			}
		}
		wait 0.5;
		level notify( "end_game" );
		return;
	}
}

// Switch on the east side of the spawn deck: 100 per pull, toggles one huge steady light high over the middle
// of the map (just under the sky box ceiling; 2 stops, radius 11000, no falloff).
function ambient_light_switch()
{
	handle = GetEnt( "ambient_light_handle", "targetname" );
	if ( !isdefined( handle ) )
	{
		return;
	}

	level flag::wait_till( "initial_blackscreen_passed" );

	// this switch faces west, so players stand on its -x side
	trig = make_use_trigger( handle.origin + ( 0, 24, -45 ), 40, 80, "Hold ^3[{+activate}]^7 to Prefer light and avoid cool ambience [Cost: 100]" );
	lamp = undefined;
	while ( 1 )
	{
		trig waittill( "trigger", player );
		if ( player.score < 100 )
		{
			player zm_audio::create_and_play_dialog( "general", "outofmoney" );
			continue;
		}
		player zm_score::minus_to_player_score( 100 );

		if ( !isdefined( lamp ) )
		{
			handle RotateRoll( -90, 0.3 );
			lamp = play_loop_fx( "ambient_light", ( 0, 19648, 1000 ) );
		}
		else
		{
			handle RotateRoll( 90, 0.3 );
			lamp Delete();
			lamp = undefined;
		}
		wait 0.5;
	}
}

// TESTING ONLY: switch on the spawn deck. Whoever uses it gets god mode, 500k points, every perk in the map
// and three Pack-a-Punched guns (Thundergun, LSAT, SCAR-H). Reusable.
function godmode_switch()
{
	handle = GetEnt( "godmode_switch_handle", "targetname" );
	if ( !isdefined( handle ) )
	{
		return;
	}

	level flag::wait_till( "initial_blackscreen_passed" );

	trig = make_use_trigger( handle.origin - ( 0, 24, 45 ), 40, 80, "Hold ^3[{+activate}]^7 for GOD MODE (testing)" );
	while ( 1 )
	{
		trig waittill( "trigger", player );

		handle RotateRoll( -90, 0.3 );
		player thread godmode_give();
		wait 1;
		handle RotateRoll( 90, 0.3 );
	}
}

function godmode_give()
{
	self endon( "disconnect" );

	self EnableInvulnerability();
	self zm_score::add_to_player_score( 500000 );
	set_round( 20 );

	// Every perk registered in this map (Mule Kick first so the third gun fits)
	perks = GetArrayKeys( level._custom_perks );
	if ( !self HasPerk( "specialty_additionalprimaryweapon" ) && isdefined( level._custom_perks["specialty_additionalprimaryweapon"] ) )
	{
		self zm_perks::give_perk( "specialty_additionalprimaryweapon", false );
	}
	foreach ( perk in perks )
	{
		if ( !self HasPerk( perk ) )
		{
			self zm_perks::give_perk( perk, false );
		}
	}

	// Swap the primaries for three Pack-a-Punched guns
	foreach ( weapon in self GetWeaponsListPrimaries() )
	{
		self TakeWeapon( weapon );
	}
	foreach ( name in array( "t6_scarh_up", "t6_lsat_up", "thundergun_upgraded" ) )
	{
		weapon = GetWeapon( name );
		self zm_weapons::weapon_give( weapon, true, false, true, true );
		self GiveMaxAmmo( weapon );
	}
}

// Jump straight to round n (only ever forward): same updates as a normal round change
function set_round( n )
{
	while ( zm::get_round_number() < n )
	{
		endless_next_round();
	}
	endless_reset_spawn_count();
}

// Respawn override: returns a spot with .origin/.angles (the safety circles' lighthouse destination)
function endgame_respawn_at_lighthouse( player )
{
	return level.safety_dests["lighthouse"];
}

// Landing on the exit platform never hurts, whatever the height
function endgame_exit_no_fall_damage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if ( sMeansOfDeath !== "MOD_FALLING" || !level flag::get( "endgame_started" ) || !isdefined( level.endgame_exit_bounds ) )
	{
		return -1;
	}

	b = level.endgame_exit_bounds;
	o = self.origin;
	if ( o[0] >= b[0] && o[0] <= b[1] && o[1] >= b[2] && o[1] <= b[3] && Abs( o[2] - level.endgame_exit_z ) < 64 )
	{
		return 0;
	}
	return -1;
}

function endgame_zone_occupied( zone_name )
{
	if ( zm_zonemgr::any_player_in_zone( zone_name ) )
	{
		return true;
	}
	return zone_order( zone_name ) < endgame_front();
}

// Spawn -> lighthouse order of the zone chain
function zone_order( zone_name )
{
	if ( !isdefined( level.zone_chain ) )
	{
		level.zone_chain = array( "start_zone", "z1", "z2", "z3", "z4", "z5", "z10", "z11", "z12", "z13", "z14", "z15", "z16", "lighthouse" );
	}
	for ( i = 0; i < level.zone_chain.size; i++ )
	{
		if ( level.zone_chain[i] == zone_name )
		{
			return i;
		}
	}
	return -1;
}

// The furthest zone any player is still in: everything before it (toward spawn) stays active
function endgame_front()
{
	front = -1;
	foreach ( player in GetPlayers() )
	{
		zone = player zm_zonemgr::get_player_zone();
		if ( isdefined( zone ) && zone_order( zone ) > front )
		{
			front = zone_order( zone );
		}
	}
	return front;
}

// Instant nuke: flash, every zombie dies at once, 400 points each, and spawning isn't held back afterwards
function instant_nuke( player )
{
	level thread zm_powerup_nuke::nuke_flash( player.team );
	foreach ( zombie in GetAITeamArray( level.zombie_team ) )
	{
		if ( IsAlive( zombie ) && !IS_TRUE( zombie.ignore_nuke ) )
		{
			zombie DoDamage( zombie.health + 666, zombie.origin );
		}
	}
	foreach ( p in GetPlayers( player.team ) )
	{
		p zm_score::player_add_points( "nuke_powerup", 400 );
	}
}

// Spawns n dogs at once at the dog spots of the given zones (bypasses the stock one-at-a-time, 9-dog special spawn)
function spawn_dogs_now( n, zones )
{
	if ( !isdefined( level.dog_spawners ) || !level.dog_spawners.size )
	{
		return;
	}

	spots = [];
	foreach ( zone in zones )
	{
		foreach ( s in struct::get_array( zone + "_spawners", "targetname" ) )
		{
			if ( s.script_noteworthy === "dog_location" )
			{
				spots[spots.size] = s;
			}
		}
	}
	if ( !spots.size )
	{
		return;
	}

	spots = array::randomize( spots );
	for ( i = 0; i < n; i++ )
	{
		spawn_dog_at( spots[i % spots.size] );
	}
}

// One dog at a random dog spot of the given zones; false if it couldn't spawn (e.g. at the AI limit)
function spawn_one_dog( zones )
{
	spots = [];
	foreach ( zone in zones )
	{
		foreach ( s in struct::get_array( zone + "_spawners", "targetname" ) )
		{
			if ( s.script_noteworthy === "dog_location" )
			{
				spots[spots.size] = s;
			}
		}
	}
	if ( !spots.size )
	{
		return false;
	}
	return spawn_dog_at( array::random( spots ) );
}

function spawn_dog_at( spot )
{
	if ( !isdefined( level.dog_spawners ) || !level.dog_spawners.size )
	{
		return false;
	}
	dog = zombie_utility::spawn_zombie( level.dog_spawners[0] );
	if ( !isdefined( dog ) )
	{
		return false;
	}
	dog.favoriteenemy = zm_ai_dogs::get_favorite_enemy();
	spot thread zm_ai_dogs::dog_spawn_fx( dog, spot );
	return true;
}

function wait_for_map_entrance()
{
	level flag::wait_till( "initial_blackscreen_passed" );
	level flag::wait_till( "map_entrance_open" );
	wait 2;
}

// Free Perk bottles that never time out: two in the Void's spawn-side corners, one at the top of the lighthouse
function perk_bottles()
{
	level flag::wait_till( "initial_blackscreen_passed" );
	foreach ( spot in array( ( -1001, 7152, 0 ), ( 1001, 7152, 0 ), ( 130, 19518, 512 ) ) )
	{
		level thread zm_powerups::specific_powerup_drop( "free_perk", spot, undefined, undefined, undefined, undefined, true );
	}

	// z2's middle gap: equidistant (~148) from the octagons at (0,2480) and (+-128,2704), over empty air
	level thread zm_powerups::specific_powerup_drop( "pap_powerup", ( 0, 2629, 24 ), undefined, undefined, undefined, undefined, true );
}

// Fire sale can drop even before the box has moved (stock needs at least one box move)
function fire_sale_can_drop()
{
	return !IS_TRUE( level.zombie_vars["zombie_powerup_fire_sale_on"] );
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
	for ( i = 2; i <= 5; i++ )
	{
		zm_zonemgr::add_adjacent_zone( "z" + ( i - 1 ), "z" + i, "enter_z" + i );
	}

	// z6-z9 were cut: the Void (z10) follows z5 (its door, debris9, still sets enter_z10)
	zm_zonemgr::add_adjacent_zone( "z5", "z10", "enter_z10" );
	for ( i = 11; i <= 16; i++ )
	{
		zm_zonemgr::add_adjacent_zone( "z" + ( i - 1 ), "z" + i, "enter_z" + i );
	}

	// Approach, walkway and island: no door of its own, it opens with z16
	zm_zonemgr::add_adjacent_zone( "z16", "lighthouse", "enter_z16" );
}	

function custom_add_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_parkour_nothing0_weapons.csv", 1);
}

