#using scripts\codescripts\struct;

#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;

#insert scripts\zm\_zm_perks.gsh;

// MULE LICK (design 9): client side. No perk-bar clientfield (the server draws its own icon);
// the machine light is Juggernog's red one, which the Juggernog script already loads.

#define PERK_MULE_LICK					"specialty_tombstone"
#define MULE_LICK_MACHINE_LIGHT_FX		"jugger_light"

#namespace zm_perk_mule_lick;

REGISTER_SYSTEM( "zm_perk_mule_lick", &__init__, undefined )

function __init__()
{
	zm_perks::register_perk_clientfields( PERK_MULE_LICK, &mule_lick_client_field_func, &mule_lick_code_callback_func );
	zm_perks::register_perk_effects( PERK_MULE_LICK, MULE_LICK_MACHINE_LIGHT_FX );
}

function mule_lick_client_field_func()
{
}

function mule_lick_code_callback_func()
{
}
