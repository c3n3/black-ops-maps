#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

// VODKA (design 14)
// Pays the player money per drink instead of costing any (scaled by round, see vodka_payout(), plus 15% per Vodka
// already drunk, up to 10), and can be bought 10 times per game (not per life). Every drink up to 10 makes the player drunker: a pulsing
// blur and a swaying view, and from 5 drinks a darkness closing in from the edges until only a clear circle 15% of
// the screen width in radius (18%) is left at 10. A player is cut off after 10. From the 3rd drink the Vodka jingle loops in
// the drinker's head (only they hear it), louder with every drink up to 10.
// Kept through downs, lost on a full death; on respawn the player gets back half the level they died at (rounded up). Needs power. Free perks and the Wunderfizz never give it.
// The stock machine trigger refuses a perk you already have, so it's disabled and Vodka uses its own trigger.
// It borrows the engine perk "specialty_showenemyequipment" (an MP-only effect no zombies script uses).

#define PERK_VODKA							"specialty_showenemyequipment"
#define VODKA_MAX_LEVEL						10
#define VODKA_VIGNETTE_START				5		// darkness closes in from this many drinks
#define VODKA_JINGLE_START					3		// the jingle loops for the drinker from this many drinks
#define VODKA_JINGLE_CLIENTFIELD			"vodka_jingle"
#define VODKA_PLAYER_SCALE					0.08	// payout -8% for every player past the first
#define VODKA_BONUS_PER_DRINK				0.15	// payout bonus per Vodka already drunk (up to VODKA_MAX_LEVEL)
#define VODKA_CLIENTFIELD					"hudItems.perks.vodka"
#define VODKA_BOTTLE_WEAPON					"zombie_perk_bottle_vodka"
#define VODKA_MACHINE_OFF_MODEL				"vodka_machine_off"
#define VODKA_MACHINE_ON_MODEL				"vodka_machine_on"
#define VODKA_RADIANT_MACHINE_NAME			"vending_vodka"
#define VODKA_MACHINE_LIGHT_FX				"vodka_light"
#define VODKA_FX_FILE						"zm_parkour_nothing0/vodka"
#define VODKA_JINGLE						"mus_perks_vodka_jingle"
#define VODKA_STING							"mus_perks_vodka_sting"

#precache( "string", "VODKA_PERK_VODKA_STRING" );
#precache( "string", "ZOMBIE_NEED_POWER" );
#precache( "fx", VODKA_FX_FILE );
#precache( "material", "vodka_vignette_5" );
#precache( "material", "vodka_vignette_6" );
#precache( "material", "vodka_vignette_7" );
#precache( "material", "vodka_vignette_8" );
#precache( "material", "vodka_vignette_9" );
#precache( "material", "vodka_vignette_10" );

#namespace zm_perk_vodka;

REGISTER_SYSTEM( "zm_perk_vodka", &__init__, undefined )

function __init__()
{
	zm_perks::register_perk_basic_info( PERK_VODKA, "vodka", 0, &"VODKA_PERK_VODKA_STRING", GetWeapon( VODKA_BOTTLE_WEAPON ) );
	zm_perks::register_perk_precache_func( PERK_VODKA, &vodka_precache );
	zm_perks::register_perk_clientfields( PERK_VODKA, &vodka_register_clientfield, &vodka_set_clientfield );
	zm_perks::register_perk_machine( PERK_VODKA, &vodka_machine_setup );
	zm_perks::register_perk_threads( PERK_VODKA, &give_vodka, &take_vodka );
	zm_perks::register_perk_host_migration_params( PERK_VODKA, VODKA_RADIANT_MACHINE_NAME, VODKA_MACHINE_LIGHT_FX );

	clientfield::register( "toplayer", VODKA_JINGLE_CLIENTFIELD, VERSION_SHIP, 4, "int" );	// drinks 0..10 (0 = silent)

	level.vodka_perk = PERK_VODKA;	// the map script leaves it out of free perks and the Wunderfizz
	zm_perks::register_perk_damage_override_func( &vodka_damage_override );	// damage reduction, see vodka_damage_override()
	callback::on_spawned( &vodka_on_spawned );
	level thread vodka_machine_trigger();
}

function vodka_precache()
{
	level.machine_assets[PERK_VODKA] = SpawnStruct();
	level.machine_assets[PERK_VODKA].weapon = GetWeapon( VODKA_BOTTLE_WEAPON );
	level.machine_assets[PERK_VODKA].off_model = VODKA_MACHINE_OFF_MODEL;
	level.machine_assets[PERK_VODKA].on_model = VODKA_MACHINE_ON_MODEL;
	level._effect[VODKA_MACHINE_LIGHT_FX] = VODKA_FX_FILE;
}

// HUD perk icon: hud_t7.lua maps "vodka" to perk_shader_vodka
function vodka_register_clientfield()
{
	clientfield::register( "clientuimodel", VODKA_CLIENTFIELD, VERSION_SHIP, 2, "int" );
}

function vodka_set_clientfield( state )
{
	self clientfield::set_player_uimodel( VODKA_CLIENTFIELD, state );
}

function vodka_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
	use_trigger.script_sound = VODKA_JINGLE;
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = VODKA_STING;
	use_trigger.target = VODKA_RADIANT_MACHINE_NAME;
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = VODKA_RADIANT_MACHINE_NAME;
	if ( isdefined( bump_trigger ) )
	{
		bump_trigger.script_string = "tap_perk";
	}
}

function give_vodka()
{
	if ( !isdefined( self._retain_perks_array ) )
	{
		self._retain_perks_array = [];
	}
	self._retain_perks_array[PERK_VODKA] = true;	// downs don't take it

	if ( !isdefined( self.vodka_level ) || self.vodka_level < 1 )
	{
		self.vodka_level = 1;
	}
	if ( !IS_TRUE( self.vodka_drunk ) )
	{
		self thread vodka_drunk_effect();
	}
}

function take_vodka( b_pause, str_perk, str_result )
{
	if ( isdefined( self.vodka_level ) && self.vodka_level > 0 )
	{
		self.vodka_lost_level = self.vodka_level;	// given back (halved) on respawn
	}
	self vodka_reset();
}

// Every spawn starts sober; a respawn after a death gives back half the level the player died at, rounded up (10 -> 5,
// 9 -> 5, 1 -> 1). Doesn't count as a purchase.
function vodka_on_spawned()
{
	self endon( "disconnect" );

	died_at = 0;
	if ( isdefined( self.vodka_lost_level ) )
	{
		died_at = self.vodka_lost_level;
	}
	if ( isdefined( self.vodka_level ) && self.vodka_level > died_at )
	{
		died_at = self.vodka_level;	// the perk wasn't taken through take_vodka
	}
	self.vodka_lost_level = undefined;
	self vodka_reset();

	n = Int( ( Min( died_at, VODKA_MAX_LEVEL ) + 1 ) / 2 );
	if ( n < 1 )
	{
		return;
	}
	wait 1;	// let the spawn finish
	if ( self.sessionstate != "playing" || self HasPerk( PERK_VODKA ) )
	{
		return;
	}
	self zm_perks::give_perk( PERK_VODKA, false );	// give_vodka: level 1
	self.vodka_level = n;
	self vodka_update_vignette();
	self vodka_update_jingle();
}

// A full death (or anything that really removes the perk) sobers the player up
function vodka_reset()
{
	self notify( "vodka_sober" );
	self.vodka_drunk = false;
	self.vodka_level = 0;
	self vodka_update_jingle();
	if ( isdefined( self.vodka_vignette ) )
	{
		self.vodka_vignette Destroy();
	}
	if ( isdefined( self._retain_perks_array ) )
	{
		self._retain_perks_array[PERK_VODKA] = undefined;
	}
	self SetBlur( 0, 0.5 );
}

//*****************************************************************************
// The machine: our own trigger in place of the stock one, so it can be drunk again
//*****************************************************************************

function vodka_machine_trigger()
{
	// This starts from __init__, before zm::init has created the flag: waiting on a flag that doesn't exist yet
	// kills the thread, which left the stock machine running (cost 0, and the pack's "Remove Perk" prompt)
	while ( !level flag::exists( "initial_blackscreen_passed" ) )
	{
		WAIT_SERVER_FRAME;
	}
	level flag::wait_till( "initial_blackscreen_passed" );

	// Every Vodka machine in the map (there can be several): wait for the stock triggers, then take each one over
	stocks = [];
	for ( i = 0; i < 100 && !stocks.size; i++ )	// the stock perk triggers may still be spawning
	{
		wait 0.1;
		foreach ( trig in GetEntArray( "zombie_vending", "targetname" ) )
		{
			if ( trig.script_noteworthy === PERK_VODKA )
			{
				stocks[stocks.size] = trig;
			}
		}
	}
	if ( !stocks.size )
	{
		return;	// no Vodka machine in the map
	}
	foreach ( stock in stocks )
	{
		stock thread vodka_take_over();
	}
}

// One Vodka machine: disable its stock trigger (and the pack's Remove Perk prompt) and run our own trigger there
function vodka_take_over()
{
	stock = self;
	stock TriggerEnable( false );
	stock thread vodka_no_perk_return();

	trig = Spawn( "trigger_radius_use", stock.origin, 0, 40, 80 );
	trig TriggerIgnoreTeam();
	trig SetVisibleToAll();
	trig SetCursorHint( "HINT_NOICON" );
	trig SetHintString( &"ZOMBIE_NEED_POWER" );

	level flag::wait_till( "power_on" );
	trig thread vodka_hint_follows_round();

	while ( 1 )
	{
		trig waittill( "trigger", player );

		if ( !zm_perks::vending_trigger_can_player_use( player ) )
		{
			wait 0.1;
			continue;
		}

		if ( !isdefined( player.vodka_bought ) )
		{
			player.vodka_bought = 0;
		}
		if ( player.vodka_bought >= VODKA_MAX_LEVEL || ( player HasPerk( PERK_VODKA ) && player.vodka_level >= VODKA_MAX_LEVEL ) )
		{
			trig PlaySound( "evt_perk_deny" );
			player IPrintLnBold( "You're cut off, comrade. No more Vodka." );
			wait 1;
			continue;
		}

		player.vodka_bought++;	// 10 per game, deaths don't reset it
		PlaySoundAtPosition( "evt_bottle_dispense", trig.origin );
		player PlaySoundToPlayer( "zmb_cha_ching", player );
		player zm_score::add_to_player_score( vodka_player_payout( player ) );
		PlaySoundAtPosition( VODKA_STING, trig.origin );

		player thread vodka_drink();
	}
}

// The machine's payout this round for this many players (before the per-drink bonus): the round value
// below, -8% per extra player (2 players x0.92, 3 x0.84, 4 x0.76), rounded to $50
function vodka_payout()
{
	scale = 1 - VODKA_PLAYER_SCALE * ( GetPlayers().size - 1 );
	v = vodka_round_value() * Max( scale, 0 );
	return Int( Floor( v / 50 + 0.5 ) ) * 50;
}

// Payout by round: straight lines between these points, rounded to $50, capped at 15000
//   round  1:   750
//   round 10:  3250   (~278 a round)
//   round 18:  9750   (~813 a round; round 10 x3, as before)
//   round 25: 15000   (750 a round), and 15000 from then on
function vodka_round_value()
{
	round = level.round_number;
	if ( !isdefined( round ) || round < 1 )
	{
		round = 1;
	}
	rounds = array( 1, 10, 18, 25 );
	points = array( 750, 3250, 9750, 15000 );

	if ( round <= rounds[0] )
	{
		return points[0];
	}
	for ( i = 1; i < rounds.size; i++ )
	{
		if ( round <= rounds[i] )
		{
			f = Float( round - rounds[i - 1] ) / Float( rounds[i] - rounds[i - 1] );
			v = points[i - 1] + f * ( points[i] - points[i - 1] );
			return Int( Floor( v / 50 + 0.5 ) ) * 50;
		}
	}
	return points[points.size - 1];
}

// Damage reduction by drinks, straight lines from 1 drink 5% to 5 drinks 35% (+7.5% per drink), then to 10 drinks
// 80% (+9% per drink): 1: 5%, 2: 12.5%, 3: 20%, 4: 27.5%, 5: 35%, 6: 44%, 7: 53%, 8: 62%, 9: 71%, 10: 80%
// It's a stock perk damage override: those chain (each gets the damage the previous ones left), so it stacks with
// the other perks' reductions instead of replacing them. The map's own scripted downs/kills (MOD_UNKNOWN, e.g. the
// bottom-of-the-sky down) and suicide / hurt volumes are left alone.
function vodka_damage_override( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if ( !self HasPerk( PERK_VODKA ) || !isdefined( self.vodka_level ) || self.vodka_level < 1 || iDamage <= 0 )
	{
		return undefined;
	}
	if ( sMeansOfDeath === "MOD_UNKNOWN" || sMeansOfDeath === "MOD_SUICIDE" || sMeansOfDeath === "MOD_TRIGGER_HURT" )
	{
		return undefined;
	}
	damage = Int( iDamage * ( 1 - vodka_damage_reduction( self.vodka_level ) ) + 0.5 );
	return Int( Max( damage, 1 ) );
}

function vodka_damage_reduction( drinks )
{
	d = Min( Max( drinks, 1 ), VODKA_MAX_LEVEL );
	if ( d <= 5 )
	{
		return 0.05 + ( d - 1 ) * ( 0.35 - 0.05 ) / 4;
	}
	return 0.35 + ( d - 5 ) * ( 0.80 - 0.35 ) / ( VODKA_MAX_LEVEL - 5 );
}

// The round's payout plus 15% for every Vodka this player has already drunk (counted up to 10: at most x2.5)
function vodka_player_payout( player )
{
	drunk = 0;
	if ( player HasPerk( PERK_VODKA ) && isdefined( player.vodka_level ) )
	{
		drunk = Int( Min( player.vodka_level, VODKA_MAX_LEVEL ) );
	}
	v = vodka_payout() * ( 1 + VODKA_BONUS_PER_DRINK * drunk );
	return Int( Floor( v / 50 + 0.5 ) ) * 50;
}

// The machine's hint shows the current round's base payout (the per-drink bonus is in the hint text)
function vodka_hint_follows_round()
{
	shown = -1;
	while ( isdefined( self ) )
	{
		payout = vodka_payout();
		if ( payout != shown )
		{
			self SetHintString( &"VODKA_PERK_VODKA_STRING", payout );
			shown = payout;
		}
		wait 1;
	}
}

// The community perk pack puts a "Remove Perk" prompt (a unitrigger) on every stock perk trigger; not on Vodka's
function vodka_no_perk_return()
{
	for ( i = 0; i < 100 && !isdefined( self.s_unitrigger ); i++ )
	{
		wait 0.1;
	}
	self notify( "kill_trigger" );
	if ( isdefined( self.s_unitrigger ) )
	{
		zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
	}
}

// The bottle animation; the drink counts once it's down
function vodka_drink()
{
	self endon( "disconnect" );
	self endon( "perk_abort_drinking" );

	gun = self zm_perks::perk_give_bottle_begin( PERK_VODKA );
	evt = self util::waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect" );

	if ( evt == "weapon_change_complete" )
	{
		if ( self HasPerk( PERK_VODKA ) )
		{
			self.vodka_level = Int( Min( self.vodka_level + 1, VODKA_MAX_LEVEL ) );
			self thread zm_perks::give_perk_presentation( PERK_VODKA );
			self vodka_update_vignette();
			self vodka_update_jingle();
		}
		else
		{
			self thread zm_perks::wait_give_perk( PERK_VODKA, true );	// first drink: the perk itself, level 1
		}
	}

	self zm_perks::perk_give_bottle_end( gun, PERK_VODKA );
}

// From 3 drinks the client loops the jingle for this player only, louder per drink (see _zm_perk_vodka.csc)
function vodka_update_jingle()
{
	n = 0;
	if ( isdefined( self.vodka_level ) && self.vodka_level >= VODKA_JINGLE_START )
	{
		n = Int( Min( self.vodka_level, VODKA_MAX_LEVEL ) );
	}
	self clientfield::set_to_player( VODKA_JINGLE_CLIENTFIELD, n );
}

// From 5 drinks: a black vignette with a clear circle that shrinks each drink (vodka_vignette_5..10, drawn by
// tools/build_vodka_assets.py: radius 40% of the screen width at 5 down to 18% at 10). Crossfades over a second.
function vodka_update_vignette()
{
	if ( self.vodka_level < VODKA_VIGNETTE_START )
	{
		return;
	}
	old = self.vodka_vignette;

	hud = NewClientHudElem( self );
	hud.x = 0;
	hud.y = 0;
	hud.horzAlign = "fullscreen";
	hud.vertAlign = "fullscreen";
	hud.foreground = true;
	hud.sort = 1000;
	hud SetShader( "vodka_vignette_" + self.vodka_level, 640, 480 );
	hud.alpha = 0;
	hud FadeOverTime( 1 );
	hud.alpha = 1;
	self.vodka_vignette = hud;

	if ( isdefined( old ) )
	{
		old thread vodka_vignette_retire();
	}
}

function vodka_vignette_retire()
{
	self FadeOverTime( 1 );
	self.alpha = 0;
	wait 1;
	if ( isdefined( self ) )
	{
		self Destroy();
	}
}

//*****************************************************************************
// Drunk: a pulsing blur plus a swaying view, both scaled by the drink count (1..10)
//*****************************************************************************

function vodka_drunk_effect()
{
	self endon( "disconnect" );
	self endon( "vodka_sober" );
	self.vodka_drunk = true;

	// per level 1..10: blur peak, sway yaw (degrees), sway speed (cycles per second)
	// levels 1-5 are the first version's blur and sway x1.15; 6-10 keep climbing; blur then x1.1 across the board
	blur = array( 0.64, 1.4, 2.28, 3.54, 5.7, 6.71, 7.7, 8.69, 9.68, 10.78 );
	yaw = array( 0.92, 1.84, 2.99, 4.6, 8.63, 10.5, 12.5, 14.5, 16.8, 19.5 );
	speed = array( 0.25, 0.3, 0.36, 0.42, 0.55, 0.61, 0.67, 0.74, 0.82, 0.9 );

	t = 0;
	w = 0;
	prev = ( 0, 0, 0 );
	while ( self HasPerk( PERK_VODKA ) )
	{
		i = Int( Min( Max( self.vodka_level, 1 ), VODKA_MAX_LEVEL ) ) - 1;
		t += 0.05;
		w += 360 * speed[i] * 0.05;	// phase accumulates, so a new speed doesn't jerk the view

		// slow side-to-side drift with a lazier, smaller bob; only the change is applied so the player can still aim
		offset = ( yaw[i] * 0.45 * Sin( w * 1.3 ), yaw[i] * Sin( w ), yaw[i] * 0.2 * Sin( w * 0.7 ) );
		if ( self.sessionstate == "playing" )
		{
			self SetPlayerAngles( self GetPlayerAngles() + ( offset - prev ) );
		}
		prev = offset;

		if ( Int( t * 20 ) % 2 == 0 )
		{
			self SetBlur( blur[i] * ( 0.55 + 0.45 * Sin( w * 2 ) ), 0.1 );
		}
		WAIT_SERVER_FRAME;
	}

	self SetBlur( 0, 0.5 );
	self.vodka_drunk = false;
}
