#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_powerups;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm_weapons;

//Perks
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_mule_lick;


//Westchief596
#using scripts\zm\_community_perk_collection_setup;


//Powerups
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;

//Traps
#using scripts\zm\_zm_trap_electric;

#using scripts\zm\zm_usermap;

// Safety-circle teleport: the Giant's teleporter overlay (server registers the same name)
REGISTER_SYSTEM( "zm_parkour_nothing0", &safety_overlay_init, undefined )

function safety_overlay_init()
{
	visionset_mgr::register_overlay_info_style_postfx_bundle( "zm_factory_teleport", VERSION_SHIP, 1, "pstfx_zm_der_teleport" );

	// Pack-a-Punch powerup (server registers the same name)
	zm_powerups::include_zombie_powerup( "pap_powerup" );
	zm_powerups::add_zombie_powerup( "pap_powerup" );
}

function main()
{
	LuiLoad( "ui.uieditor.menus.HUD.hud_t7" );
	zm_usermap::main();

	include_weapons();
	
	util::waitforclient( 0 );
}

function include_weapons()
{
	zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_parkour_nothing0_weapons.csv", 1);
}
