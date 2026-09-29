#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

// MULE LICK (design 9)
// 500 points. -1 gun slot. The next perk gained after it (by any means) is bound to it: Mule Lick and that perk
// are never lost to downs or deaths for the rest of the game. One binding per player, irreversible.
// Mule Kick + Mule Lick = the normal 2 guns.
// Design 11: a full custom perk (CYO template layout). Machine: DEVRAW Dew's model re-textured dark red with a
// "MULE LICK" sign; bottle: BO4 bottle with the Mule Lick label; HUD icon via hud_t7.lua (mule_lick).
// It borrows the engine perk "specialty_whoswho" (the community perk collection's Tombstone Soda uses
// specialty_tombstone, so Mule Lick can't).

#define PERK_MULE_LICK						"specialty_whoswho"
#define MULE_LICK_COST						500
#define MULE_LICK_ALIAS						"mule_lick"						// hud_t7.lua perk list key
#define MULE_LICK_CLIENTFIELD				"hudItems.perks.mule_lick"
#define MULE_LICK_BOTTLE_WEAPON				"zombie_perk_bottle_mulelick"
#define MULE_LICK_MACHINE_OFF_MODEL			"mulelick_machine_off"
#define MULE_LICK_MACHINE_ON_MODEL			"mulelick_machine_on"
#define MULE_LICK_RADIANT_MACHINE_NAME		"vending_mulelick"
#define MULE_LICK_MACHINE_LIGHT_FX			"mulelick_light"
#define MULE_LICK_FX_FILE					"zm_parkour_nothing0/mulelick"
#define MULE_LICK_JINGLE					"mus_perks_mulelick_jingle"
#define MULE_LICK_STING						"mus_perks_mulelick_sting"

#precache( "string", "MULELICK_PERK_MULE_LICK_STRING" );
#precache( "fx", MULE_LICK_FX_FILE );

#namespace zm_perk_mule_lick;

REGISTER_SYSTEM( "zm_perk_mule_lick", &__init__, undefined )

function __init__()
{
	zm_perks::register_perk_basic_info( PERK_MULE_LICK, "mulelick", MULE_LICK_COST, &"MULELICK_PERK_MULE_LICK_STRING", GetWeapon( MULE_LICK_BOTTLE_WEAPON ) );
	zm_perks::register_perk_precache_func( PERK_MULE_LICK, &mule_lick_precache );
	zm_perks::register_perk_clientfields( PERK_MULE_LICK, &mule_lick_register_clientfield, &mule_lick_set_clientfield );
	zm_perks::register_perk_machine( PERK_MULE_LICK, &mule_lick_machine_setup );
	zm_perks::register_perk_threads( PERK_MULE_LICK, &give_mule_lick, &take_mule_lick );
	zm_perks::register_perk_host_migration_params( PERK_MULE_LICK, MULE_LICK_RADIANT_MACHINE_NAME, MULE_LICK_MACHINE_LIGHT_FX );

	level.get_player_weapon_limit = &mule_lick_weapon_limit;
	callback::on_spawned( &mule_lick_restore_on_spawn );
}

function mule_lick_precache()
{
	level.machine_assets[PERK_MULE_LICK] = SpawnStruct();
	level.machine_assets[PERK_MULE_LICK].weapon = GetWeapon( MULE_LICK_BOTTLE_WEAPON );
	level.machine_assets[PERK_MULE_LICK].off_model = MULE_LICK_MACHINE_OFF_MODEL;
	level.machine_assets[PERK_MULE_LICK].on_model = MULE_LICK_MACHINE_ON_MODEL;
	level._effect[MULE_LICK_MACHINE_LIGHT_FX] = MULE_LICK_FX_FILE;
}

// HUD perk icon: hud_t7.lua maps "mule_lick" to perk_shader_mulelick
function mule_lick_register_clientfield()
{
	clientfield::register( "clientuimodel", MULE_LICK_CLIENTFIELD, VERSION_SHIP, 2, "int" );
}

function mule_lick_set_clientfield( state )
{
	self clientfield::set_player_uimodel( MULE_LICK_CLIENTFIELD, state );
}

function mule_lick_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
	use_trigger.script_sound = MULE_LICK_JINGLE;
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = MULE_LICK_STING;
	use_trigger.target = MULE_LICK_RADIANT_MACHINE_NAME;
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = MULE_LICK_RADIANT_MACHINE_NAME;
	if ( isdefined( bump_trigger ) )
	{
		bump_trigger.script_string = "tap_perk";
	}
}

// Base 2 guns, 3 with Mule Kick, one fewer with Mule Lick (so Mule Kick + Mule Lick = 2)
function mule_lick_weapon_limit( player )
{
	limit = 2;
	if ( player HasPerk( PERK_ADDITIONAL_PRIMARY_WEAPON ) )
	{
		limit = level.additionalprimaryweapon_limit;
	}
	if ( player HasPerk( PERK_MULE_LICK ) )
	{
		limit--;
	}
	return limit;
}

function give_mule_lick()
{
	if ( !isdefined( self._retain_perks_array ) )
	{
		self._retain_perks_array = [];
	}
	self._retain_perks_array[PERK_MULE_LICK] = true;

	self drop_extra_guns();

	if ( !IS_TRUE( self.mule_lick_owned ) )
	{
		self.mule_lick_owned = true;
		self thread mule_lick_bind_next_perk();
	}
}

// Mule Lick is never lost (it is retained), so this only runs if something force-removes it
function take_mule_lick( b_pause, str_perk, str_result )
{
}

// Over the slot limit: take guns that aren't in hand until it fits
function drop_extra_guns()
{
	limit = mule_lick_weapon_limit( self );
	primaries = self GetWeaponsListPrimaries();
	current = self GetCurrentWeapon();
	for ( i = primaries.size - 1; i >= 0 && primaries.size > limit; i-- )
	{
		if ( primaries[i] != current )
		{
			self TakeWeapon( primaries[i] );
			ArrayRemoveValue( primaries, primaries[i] );
		}
	}
}

// The next perk gained after Mule Lick, by any means, is kept for good; one binding per game
function mule_lick_bind_next_perk()
{
	self endon( "disconnect" );

	before = [];
	if ( isdefined( self.perks_active ) )
	{
		before = ArrayCopy( self.perks_active );
	}

	while ( !isdefined( self.mule_lick_bound ) )
	{
		self waittill( "perk_acquired" );
		foreach ( perk in self.perks_active )
		{
			if ( perk != PERK_MULE_LICK && !IsInArray( before, perk ) )
			{
				self.mule_lick_bound = perk;
				self._retain_perks_array[perk] = true;
				self IPrintLnBold( "Mule Lick: this perk is yours for good" );
				break;
			}
		}
	}
}

// Downs never take retained perks, but a respawn starts clean: give Mule Lick and its bound perk back
function mule_lick_restore_on_spawn()
{
	self endon( "disconnect" );

	if ( !IS_TRUE( self.mule_lick_owned ) )
	{
		return;
	}

	util::wait_network_frame();
	foreach ( perk in array( PERK_MULE_LICK, self.mule_lick_bound ) )
	{
		if ( isdefined( perk ) && !self HasPerk( perk ) )
		{
			self zm_perks::give_perk( perk, false );
		}
	}
}
