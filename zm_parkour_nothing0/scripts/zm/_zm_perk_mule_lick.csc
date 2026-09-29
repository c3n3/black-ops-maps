#using scripts\codescripts\struct;

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_zm_perks;

#insert scripts\zm\_zm_perks.gsh;

// MULE LICK (design 11): client side. HUD icon clientfield (hud_t7.lua key "mule_lick") and the red machine glow.

#define PERK_MULE_LICK					"specialty_whoswho"
#define MULE_LICK_CLIENTFIELD			"hudItems.perks.mule_lick"
#define MULE_LICK_MACHINE_LIGHT_FX		"mulelick_light"
#define MULE_LICK_FX_FILE				"zm_parkour_nothing0/mulelick"

#precache( "client_fx", MULE_LICK_FX_FILE );

#namespace zm_perk_mule_lick;

REGISTER_SYSTEM( "zm_perk_mule_lick", &__init__, undefined )

function __init__()
{
	zm_perks::register_perk_clientfields( PERK_MULE_LICK, &mule_lick_client_field_func, &mule_lick_code_callback_func );
	zm_perks::register_perk_effects( PERK_MULE_LICK, MULE_LICK_MACHINE_LIGHT_FX );
	level._effect[MULE_LICK_MACHINE_LIGHT_FX] = MULE_LICK_FX_FILE;
}

function mule_lick_client_field_func()
{
	clientfield::register( "clientuimodel", MULE_LICK_CLIENTFIELD, VERSION_SHIP, 2, "int", undefined, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function mule_lick_code_callback_func()
{
}
