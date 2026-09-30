#using scripts\codescripts\struct;

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;

#insert scripts\zm\_zm_perks.gsh;

// VODKA (design 14): client side. HUD icon clientfield (hud_t7.lua key "vodka"), the white machine glow, and the
// jingle that loops in a drunk player's head (3+ drinks), louder with every drink up to 10.

#define PERK_VODKA						"specialty_showenemyequipment"
#define VODKA_CLIENTFIELD			"hudItems.perks.vodka"
#define VODKA_MACHINE_LIGHT_FX		"vodka_light"
#define VODKA_JINGLE_CLIENTFIELD	"vodka_jingle"
#define VODKA_JINGLE_LOOP			"mus_perks_vodka_jingle_lp"
#define VODKA_FX_FILE				"zm_parkour_nothing0/vodka"

#precache( "client_fx", VODKA_FX_FILE );

#namespace zm_perk_vodka;

REGISTER_SYSTEM( "zm_perk_vodka", &__init__, undefined )

function __init__()
{
	zm_perks::register_perk_clientfields( PERK_VODKA, &vodka_client_field_func, &vodka_code_callback_func );
	zm_perks::register_perk_effects( PERK_VODKA, VODKA_MACHINE_LIGHT_FX );
	level._effect[VODKA_MACHINE_LIGHT_FX] = VODKA_FX_FILE;
	clientfield::register( "toplayer", VODKA_JINGLE_CLIENTFIELD, VERSION_SHIP, 4, "int", &vodka_jingle, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
}

// newVal = drinks (3..10), 0 = stop. Volume 0.35 at 3 drinks up to 1.0 at 10.
function vodka_jingle( localClientNum, oldVal, newVal, bNewEnt, bInitialSnap, fieldName, bWasTimeJump )
{
	if ( !newVal )
	{
		if ( isdefined( self.vodka_jingle_id ) )
		{
			self StopLoopSound( self.vodka_jingle_id );
			self.vodka_jingle_id = undefined;
		}
		return;
	}

	if ( !isdefined( self.vodka_jingle_id ) )
	{
		self.vodka_jingle_id = self PlayLoopSound( VODKA_JINGLE_LOOP, 1 );
	}
	volume = 0.35 + 0.65 * ( newVal - 3 ) / 7.0;
	SetSoundVolumeRate( self.vodka_jingle_id, 0.5 );
	SetSoundVolume( self.vodka_jingle_id, volume );
}

function vodka_client_field_func()
{
	clientfield::register( "clientuimodel", VODKA_CLIENTFIELD, VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function vodka_code_callback_func()
{
}
