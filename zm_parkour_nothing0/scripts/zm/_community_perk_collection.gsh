// ======================================================================================================
// Global Perk Settings
// ======================================================================================================
#define ENABLE_COMMUNITY_PERK_COLLECTION							1 //Should your level run this pack's logic

#define USE_BUCKET_MODEL											0 //Use Bucket models instead of machines
#define COMMON_MODEL_BUCKET_FX										"west/perks/logical_bucket_fx"

#define COMMON_CLIENTFIELD_SIZE										1 //Number of bits used for perk icon, Min = 1
																	//2 is recommended for icon effects like Power Off or Recharging
																	//Using more bits means less space for other things like custom AI
																	//NOTE: You will not be able to run all perks using 2+ bits

#define USE_SPARE_CHANGE											1 //Adds spare change when proning at perk machines

#define ALLOW_AI_PERK_JINGLES										1 //Allows Jingles with AI elements to play
																	//Only Affects BO4 Perks, Divine Ale, and Electric Cherry
																	//Minus Death Perception and PhD Slider as they use their normal jingles

// ======================================================================================================
// Perk Return Settings
// ======================================================================================================
#define PERK_RETURN_LEVEL_USE										1 //Allow Players to refund their perk purchases
																		
#define PERK_RETURN_REFUND_POINTS									0 //Refund Points on perk removal
#define PERK_RETURN_REFUND_PERCENT									25 //Percent of original price to refund

#define PERK_RETURN_LOSE_QR_USE_ON_REFUND							0 //Lose a QR use when refunding QR

#define PERK_RETURN_STRING_REFUND									"Hold ^3[{+activate}]^7 to Refund Perk"
#define PERK_RETURN_STRING_REMOVE									"Hold ^3[{+activate}]^7 to Remove Perk"


// ======================================================================================================
// Cooldown Bar Settings
// ======================================================================================================
#define SHOW_COOLDOWN_BARS											1 //Shows cooldown bars for perks with cooldown abilities

#define COOLDOWN_ALIGN_X											"left"
#define COOLDOWN_ALIGN_Y											"bottom"

#define COOLDOWN_BAR_X_START										150
#define COOLDOWN_BAR_X_MOVE_OVER									18
#define COOLDOWN_BAR_Y_START										-10
#define COOLDOWN_BAR_HEIGHT											50
#define COOLDOWN_BAR_WIDTH											8

#define COOLDOWN_ICON_X_START										146
#define COOLDOWN_ICON_Y_START										-65
#define COOLDOWN_ICON_X_Y											16


// ======================================================================================================
// Enable Perks for Map
// ======================================================================================================
//-----Treyarch-----
#define WUNDERFIZZ_LEVEL_USE										1

//BO1
#define DOUBLETAP1_LEVEL_USE_PERK									0 //Double Tap 1 and 3 use the same specialty
#define PHD_FLOPPER_LEVEL_USE_PERK									1 //Only one of them should be used at a time

//BO2
#define TOMBSTONE_SODA_LEVEL_USE_PERK								1
#define ELECTRIC_CHERRY_LEVEL_USE_PERK								1

//BO3
#define WIDOWS_WINE_LEVEL_USE_PERK									1 //Glitching Gin conflicts with Widows Wine
																	  //if is set to use the Lethal slot
//BO4
#define BANDOLIER_BANDIT_LEVEL_USE_PERK								1
#define BLAZE_PHASE_LEVEL_USE_PERK									1
#define BLOOD_WOLF_LEVEL_USE_PERK									1
#define DEATH_PERCEPTION_LEVEL_USE_PERK								1
#define DYING_WISH_LEVEL_USE_PERK									1
#define ETHEREAL_RAZOR_LEVEL_USE_PERK								1
#define PHD_SLIDER_LEVEL_USE_PERK									1
#define STONE_COLD_LEVEL_USE_PERK									1
#define TIMESLIP_LEVEL_USE_PERK										1
#define VICTORIOUS_TORTOISE_LEVEL_USE_PERK							1
#define WINTERS_WAIL_LEVEL_USE_PERK									1
#define ZOMBSHELL_LEVEL_USE_PERK									1

//CW
#define ELEMENTAL_POP_LEVEL_USE_PERK								1

//-----Customs-----
//Abnormal202
#define CRYO_SLIDE_LEVEL_USE_PERK									1
#define SNAILS_PACE_LEVEL_USE_PERK									1
#define WINDRUNNER_LEVEL_USE_PERK									1

//Holofya
#define BRAWLSTAR_PUNCH_LEVEL_USE_PERK								1
#define GLITCHING_GIN_LEVEL_USE_PERK								1 //Glitching Gin conflicts with Widows Wine
#define SPACE_CADET_LEVEL_USE_PERK									1 //if is set to use the Lethal slot

//ItsBrodes
#define SLURPENTINE_LEVEL_USE_PERK									1

//Kaizokuroof
#define ATOMIC_LIQUEUR_LEVEL_USE_PERK								1
#define SALVAGE_SHAKE_LEVEL_USE_PERK								1

//Khel Mho
#define VIGOR_RUSH_LEVEL_USE_PERK									1

//KillJoy
#define DIVINE_ALE_LEVEL_USE_PERK									1

//Logical
#define DOUBLE_DEW_LEVEL_USE_PERK									1
#define FIGHTERS_FIZZ_LEVEL_USE_PERK								1
#define ICU_LEVEL_USE_PERK											1
#define MUSCLE_MILK_LEVEL_USE_PERK									1
#define TACTIQUILLA_LEVEL_USE_PERK									1

//Madgaz
#define BANANA_COLADA_LEVEL_USE_PERK								1
#define BULL_ICE_BLAST_LEVEL_USE_PERK								1
#define CRUSADERS_ALE_LEVEL_USE_PERK								1
#define MADGAZ_MOONSHINE_LEVEL_USE_PERK								1
#define POWER_AID_PUNCH_LEVEL_USE_PERK								1

//Westchief596
#define AMMO_AMERICANO_LEVEL_USE_PERK								1
#define ASTRO_ALE_LEVEL_USE_PERK									1
#define BLEEDING_LEVEL_USE_PERK										1
#define BRIMSTONE_BRAMBLE_LEVEL_USE_PERK							1
#define CRACK_SHOT_LEVEL_USE_PERK									1
#define DOUBLETAP3_LEVEL_USE_PERK									1 //Double Tap 1 and 3 use the same specialty
#define GAMBLERS_GIBSON_LEVEL_USE_PERK								1 //Only one of them should be used at a time
#define MAGNET_LEVEL_USE_PERK										1
#define MASOCHIST_LEVEL_USE_PERK									1
#define MEDUSAS_MAURESQUE_LEVEL_USE_PERK							1
#define PICKPOCKET_PALOMA_LEVEL_USE_PERK							1
#define PRICKLING_PROSECCO_LEVEL_USE_PERK							1
#define ROULETTE_LEVEL_USE_PERK										1
#define REBATE_ROSE_LEVEL_USE_PERK									1
#define SAMURAIS_SPIRIT_LEVEL_USE_PERK								1
#define SIDE_STEP_LEVEL_USE_PERK									1
#define SLIP_AWAY_LEVEL_USE_PERK									1
#define SPECTRAL_SHAKE_LEVEL_USE_PERK								1
#define TIME_OUT_LEVEL_USE_PERK										1
#define VERRUCKT_JUG_LEVEL_USE_PERK									1
#define WALL_POWER_LEVEL_USE_PERK									1


// ======================================================================================================
// Add Perks to Wunderfizz
// ======================================================================================================
#define WUNDERFIZZ_INCLUDE_ALL_PERKS								1 //Ignores the below checks and includes all perks loaded
#define WUNDERFIZZ_INCLUDE_DEFAULT_PERKS							0 //Includes the 7 Default Perks

#define AMMO_AMERICANO_INCLUDE_IN_WUNDERFIZZ						1
#define ASTRO_ALE_INCLUDE_IN_WUNDERFIZZ								1
#define ATOMIC_LIQUEUR_INCLUDE_IN_WUNDERFIZZ						1
#define BANANA_COLADA_INCLUDE_IN_WUNDERFIZZ							1
#define BANDOLIER_BANDIT_INCLUDE_IN_WUNDERFIZZ						1
#define BLAZE_PHASE_INCLUDE_IN_WUNDERFIZZ							1
#define BLEEDING_INCLUDE_IN_WUNDERFIZZ								1
#define BLOOD_WOLF_INCLUDE_IN_WUNDERFIZZ							1
#define BRAWLSTAR_PUNCH_INCLUDE_IN_WUNDERFIZZ						1
#define BRIMSTONE_BRAMBLE_INCLUDE_IN_WUNDERFIZZ						1
#define BULL_ICE_BLAST_INCLUDE_IN_WUNDERFIZZ						1
#define CRACK_SHOT_INCLUDE_IN_WUNDERFIZZ							1
#define CRUSADERS_ALE_INCLUDE_IN_WUNDERFIZZ							1
#define CRYO_SLIDE_INCLUDE_IN_WUNDERFIZZ							1
#define DEATH_PERCEPTION_INCLUDE_IN_WUNDERFIZZ						1
#define DIVINE_ALE_INCLUDE_IN_WUNDERFIZZ							1
#define DOUBLE_DEW_INCLUDE_IN_WUNDERFIZZ							1
#define DOUBLETAP1_INCLUDE_IN_WUNDERFIZZ							1
#define DOUBLETAP3_INCLUDE_IN_WUNDERFIZZ							1
#define DYING_WISH_INCLUDE_IN_WUNDERFIZZ							1
#define ELECTRIC_CHERRY_INCLUDE_IN_WUNDERFIZZ						1
#define ELEMENTAL_POP_INCLUDE_IN_WUNDERFIZZ							1
#define ETHEREAL_RAZOR_INCLUDE_IN_WUNDERFIZZ						1
#define FIGHTERS_FIZZ_INCLUDE_IN_WUNDERFIZZ							1
#define GAMBLERS_GIBSON_INCLUDE_IN_WUNDERFIZZ						1
#define GLITCHING_GIN_INCLUDE_IN_WUNDERFIZZ							1
#define ICU_INCLUDE_IN_WUNDERFIZZ									1
#define MADGAZ_MOONSHINE_INCLUDE_IN_WUNDERFIZZ						1
#define MAGNET_INCLUDE_IN_WUNDERFIZZ								1
#define MASOCHIST_INCLUDE_IN_WUNDERFIZZ								1
#define MEDUSAS_MAURESQUE_INCLUDE_IN_WUNDERFIZZ						1
#define MUSCLE_MILK_INCLUDE_IN_WUNDERFIZZ							1
#define PHD_FLOPPER_INCLUDE_IN_WUNDERFIZZ							1
#define PHD_SLIDER_INCLUDE_IN_WUNDERFIZZ							1
#define PICKPOCKET_PALOMA_INCLUDE_IN_WUNDERFIZZ						1
#define POWER_AID_PUNCH_INCLUDE_IN_WUNDERFIZZ						1
#define PRICKLING_PROSECCO_INCLUDE_IN_WUNDERFIZZ					1
#define ROULETTE_INCLUDE_IN_WUNDERFIZZ								1
#define REBATE_ROSE_INCLUDE_IN_WUNDERFIZZ							1
#define SALVAGE_SHAKE_INCLUDE_IN_WUNDERFIZZ							1
#define SAMURAIS_SPIRIT_INCLUDE_IN_WUNDERFIZZ						1
#define SIDE_STEP_INCLUDE_IN_WUNDERFIZZ								1
#define SLIP_AWAY_INCLUDE_IN_WUNDERFIZZ								1
#define SLURPENTINE_INCLUDE_IN_WUNDERFIZZ							1
#define SNAILS_PACE_INCLUDE_IN_WUNDERFIZZ							1
#define SPACE_CADET_INCLUDE_IN_WUNDERFIZZ							1
#define SPECTRAL_SHAKE_INCLUDE_IN_WUNDERFIZZ						1
#define STONE_COLD_INCLUDE_IN_WUNDERFIZZ							1
#define TACTIQUILLA_INCLUDE_IN_WUNDERFIZZ							1
#define TIME_OUT_INCLUDE_IN_WUNDERFIZZ								1
#define TIMESLIP_INCLUDE_IN_WUNDERFIZZ								1
#define TOMBSTONE_SODA_INCLUDE_IN_WUNDERFIZZ						1
#define VERRUCKT_JUG_INCLUDE_IN_WUNDERFIZZ							1
#define VICTORIOUS_TORTOISE_INCLUDE_IN_WUNDERFIZZ					1
#define VIGOR_RUSH_INCLUDE_IN_WUNDERFIZZ							1
#define WALL_POWER_INCLUDE_IN_WUNDERFIZZ							1
#define WIDOWS_WINE_INCLUDE_IN_WUNDERFIZZ							1
#define WINDRUNNER_INCLUDE_IN_WUNDERFIZZ							1
#define WINTERS_WAIL_INCLUDE_IN_WUNDERFIZZ							1
#define ZOMBSHELL_INCLUDE_IN_WUNDERFIZZ								1


// ======================================================================================================
// Ammo Americano
// ======================================================================================================
#define AMMO_AMERICANO_COST											3000
#define AMMO_AMERICANO_RADIANT_MACHINE_NAME							"vending_ammo_americano"
#define AMMO_AMERICANO_ALIAS										"ammo_americano"
#define AMMO_AMERICANO_SCRIPT_STRING								"ammo_americano_perk"
#define AMMO_AMERICANO_JINGLE										"ammo_americano_jingle"
#define AMMO_AMERICANO_STING										"ammo_americano_sting"
#define AMMO_AMERICANO_CLIENTFIELD									"hudItems.perks.ammo_americano"

#define AMMO_AMERICANO_BOTTLE_WEAPON								"ammo_americano_perk_bottle_wpn"
#define AMMO_AMERICANO_MACHINE_ACTIVE_MODEL							"ammo_americano_model"
#define AMMO_AMERICANO_MACHINE_DISABLED_MODEL						"ammo_americano_model"
#define AMMO_AMERICANO_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_tombstone_light"
#define AMMO_AMERICANO_MODEL_BUCKET									"ammo_americano_model_bucket"

#define AMMO_AMERICANO_PERK											"specialty_nottargetedbysentry"
#define AMMO_AMERICANO_USE_SECONDARY_PERKS							0
#define AMMO_AMERICANO_SECONDARY_PERKS								array ("")

#define AMMO_AMERICANO_COST_STRING									"3000"
#define AMMO_AMERICANO_TRIG_STRING									"Hold ^3[{+activate}]^7 for Ammo Americano [Cost: &&1]\nWeapons Autofill Their Clip From Stock"

#define AMMO_AMERICANO_AMMO_GIVE									1 	//Amount of ammo to give per cycle
#define AMMO_AMERICANO_GIVE_MULTIPIER								1	//Multiply ammo given per cycle
#define AMMO_AMERICANO_HIGH_CLIPSIZE_SIZE							300 //Minimum clipsize before "give_ammo" bonus is applied
#define AMMO_AMERICANO_HIGH_CLIPSIZE_BONUS							2 	//Amount to multiply "give_ammo" for high capacity clips

//Formula for determining weapon cycle time
#define AMMO_AMERICANO_WAIT_FORMULA									2 / (avg_clipsize / 4) 
#define AMMO_AMERICANO_MAX_WAIT_PER_CYCLE							2 	//Most time a weapon cycle takes
#define AMMO_AMERICANO_MIN_WAIT_PER_CYCLE							.2 	//Shortest time a weapon cycle takes - Must be greater than .05

//Weapons to exclude from ammo transfer action
#define AMMO_AMERICANO_WEAPON_EXLUSION_LIST							array ("xmas_gun", "xmas_gun_up")


// ======================================================================================================
// Astro Ale
// ======================================================================================================
#define ASTRO_ALE_COST												1500
#define ASTRO_ALE_RADIANT_MACHINE_NAME								"vending_astro_ale"	
#define ASTRO_ALE_ALIAS												"astro_ale"
#define ASTRO_ALE_SCRIPT_STRING										"astro_ale_perk"
#define ASTRO_ALE_JINGLE											"astro_ale_jingle"
#define ASTRO_ALE_STING												"astro_ale_sting"
#define ASTRO_ALE_CLIENTFIELD										"hudItems.perks.astro_ale"

#define ASTRO_ALE_BOTTLE_WEAPON										"astro_ale_perk_bottle_wpn"
#define ASTRO_ALE_MACHINE_ACTIVE_MODEL								"astro_ale_model"
#define ASTRO_ALE_MACHINE_DISABLED_MODEL							"astro_ale_model"
#define ASTRO_ALE_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_tombstone_light"
#define ASTRO_ALE_MODEL_BUCKET										"astro_ale_model_bucket"

#define ASTRO_ALE_COST_STRING										"1500"
#define ASTRO_ALE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Astro Ale [Cost: &&1]\nGain an Additional Jump, Lowers Gravity"

#define ASTRO_ALE_PERK												"specialty_lowgravity"
#define ASTRO_ALE_USE_SECONDARY_PERKS								0
#define ASTRO_ALE_SECONDARY_PERKS									array ("")

#define ASTRO_ALE_DOUBLE_JUMP_ADD_VELOCITY							300	//Velocity added to Z-axis


// ======================================================================================================
// Atomic Liqueur
// ======================================================================================================
#define ATOMIC_LIQUEUR_COST											3000
#define ATOMIC_LIQUEUR_RADIANT_MACHINE_NAME							"vending_atomic_liqueur"	
#define ATOMIC_LIQUEUR_ALIAS										"atomic_liqueur"
#define ATOMIC_LIQUEUR_SCRIPT_STRING								"atomic_liqueur_perk"
#define ATOMIC_LIQUEUR_JINGLE										"atomic_liqueur_jingle"
#define ATOMIC_LIQUEUR_STING										"atomic_liqueur_sting"
#define ATOMIC_LIQUEUR_CLIENTFIELD									"hudItems.perks.atomic_liqueur"

#define ATOMIC_LIQUEUR_BOTTLE_WEAPON								"atomic_liqueur_perk_bottle_wpn"
#define ATOMIC_LIQUEUR_MACHINE_ACTIVE_MODEL							"atomic_liqueur_model_on"
#define ATOMIC_LIQUEUR_MACHINE_DISABLED_MODEL						"atomic_liqueur_model_off"
#define ATOMIC_LIQUEUR_MACHINE_LIGHT_FX								"west/perks/kaizokuroof_fx_perk_atomic_liqueur_light"		
#define ATOMIC_LIQUEUR_MODEL_BUCKET									"atomic_liqueur_model_bucket"

#define ATOMIC_LIQUEUR_COST_STRING									"3000"
#define ATOMIC_LIQUEUR_TRIG_STRING									"Hold ^3[{+activate}]^7 for Atomic Liqueur [Cost: &&1]\nMelee to Create a Localized Blast, Killing Nearby Zombies"

#define ATOMIC_LIQUEUR_ICON											"atomic_liqueur_perk_icon_hud"
#define ATOMIC_LIQUEUR_PERK											"specialty_immunenvthermal"
#define ATOMIC_LIQUEUR_USE_SECONDARY_PERKS							0
#define ATOMIC_LIQUEUR_SECONDARY_PERKS								array ("")

#define ATOMIC_LIQUEUR_SOUND_ACTIVATE								"atomic_knife_explode"
#define ATOMIC_LIQUEUR_SOUND_READY									"atomic_knife_ready"

#define ATOMIC_LIQUEUR_NUKE_COOLDOWN								30	//In seconds, cooldown between uses
#define ATOMIC_LIQUEUR_NUKE_KILL_LIMIT								64	//Max zombies that can die per use
#define ATOMIC_LIQUEUR_NUKE_MAX_RANGE								196	//In game inches from player.origin


// ======================================================================================================
// Banana Colada
// ======================================================================================================
#define BANANA_COLADA_COST											2000
#define BANANA_COLADA_RADIANT_MACHINE_NAME							"vending_banana_colada"	
#define BANANA_COLADA_ALIAS											"banana_colada"
#define BANANA_COLADA_SCRIPT_STRING									"banana_colada_perk"
#define BANANA_COLADA_JINGLE										"banana_colada_jingle"
#define BANANA_COLADA_STING											"banana_colada_sting"
#define BANANA_COLADA_CLIENTFIELD									"hudItems.perks.banana_colada"

#define BANANA_COLADA_BOTTLE_WEAPON									"banana_colada_perk_bottle_wpn"
#define BANANA_COLADA_MACHINE_ACTIVE_MODEL							"banana_colada_model_on"
#define BANANA_COLADA_MACHINE_DISABLED_MODEL						"banana_colada_model_off"
#define BANANA_COLADA_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_doubletap_light"
#define BANANA_COLADA_MODEL_BUCKET									"banana_colada_model_bucket"

#define BANANA_COLADA_COST_STRING									"2000"
#define BANANA_COLADA_TRIG_STRING									"Hold ^3[{+activate}]^7 for Banana Colada [Cost: &&1]\nSliding Will Leave a Trail of Slime, Zombies Can Slip and Take Damage"

#define BANANA_COLADA_PERK											"specialty_decoy"
#define BANANA_COLADA_USE_SECONDARY_PERKS							0
#define BANANA_COLADA_SECONDARY_PERKS								array ("")

#define BANANA_COLADA_SLIDE_SOUND									"banana_colada_slide_squish"
#define BANANA_COLADA_SLIDE_FX										"west/perks/madgaz_banana_colada_slime"

#define BANANA_COLADA_ANIM_CRAWL_SLIP_FAST							"banana_colada_anim_ai_zombie_crawl_slipslide_fast"
#define BANANA_COLADA_ANIM_CRAWL_SLIP_RECOV							"banana_colada_anim_ai_zombie_crawl_slipslide_recover"
#define BANANA_COLADA_ANIM_CRAWL_SLIP_SLOW							"banana_colada_anim_ai_zombie_crawl_slipslide_slow"
#define BANANA_COLADA_ANIM_RUN_SLIP									"banana_colada_anim_ai_zombie_run_slipslide"
#define BANANA_COLADA_ANIM_RUN_SLIP_A								"banana_colada_anim_ai_zombie_run_slipslide_a"
#define BANANA_COLADA_ANIM_SLIP_COLLAPSE							"banana_colada_anim_ai_zombie_slipslide_collapse"
#define BANANA_COLADA_ANIM_SPRINT_SLIP								"banana_colada_anim_ai_zombie_sprint_slipslide"
#define BANANA_COLADA_ANIM_SPRINT_SLIP_A							"banana_colada_anim_ai_zombie_sprint_slipslide_a"
#define BANANA_COLADA_ANIM_STAND_SLIP_RECOV							"banana_colada_anim_ai_zombie_stand_slipslide_recover"
#define BANANA_COLADA_ANIM_WALK_SLIP								"banana_colada_anim_ai_zombie_walk_slipslide"
#define BANANA_COLADA_ANIM_WALK_SLIP_A								"banana_colada_anim_ai_zombie_walk_slipslide_a"
#define BANANA_COLADA_ANIM_SOUND_NOTE								"fly_zmb_goo_fall"

#define BANANA_COLADA_SLIDE_BOOST									400
#define BANANA_COLADA_SLIME_DAMAGE									500 //AI Damage per tick in the Slime
#define BANANA_COLADA_SLIME_FALL_CHANCE								25 //Percent chance for AI to fall over when in the Slime
#define BANANA_COLADA_SLIME_RANGE									32
#define BANANA_COLADA_SLIME_TIME									5


// ======================================================================================================
// Bandolier Bandit
// ======================================================================================================
#define BANDOLIER_BANDIT_COST										3000
#define BANDOLIER_BANDIT_RADIANT_MACHINE_NAME						"vending_bandolier_bandit"	
#define BANDOLIER_BANDIT_ALIAS										"bandolier_bandit"
#define BANDOLIER_BANDIT_SCRIPT_STRING								"bandolier_bandit_perk"
#define BANDOLIER_BANDIT_JINGLE										"bandolier_bandit_jingle"
#define BANDOLIER_BANDIT_STING										"bandolier_bandit_sting"
#define BANDOLIER_BANDIT_CLIENTFIELD								"hudItems.perks.bandolier_bandit"

#define BANDOLIER_BANDIT_BOTTLE_WEAPON								"bandolier_bandit_perk_bottle_wpn"
#define BANDOLIER_BANDIT_MACHINE_ACTIVE_MODEL						"bandolier_bandit_model"
#define BANDOLIER_BANDIT_MACHINE_DISABLED_MODEL						"bandolier_bandit_model"
#define BANDOLIER_BANDIT_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_stamin_up_light"
#define BANDOLIER_BANDIT_MODEL_BUCKET								"bandolier_bandit_model_bucket"	

#define BANDOLIER_BANDIT_COST_STRING								"3000"
#define BANDOLIER_BANDIT_TRIG_STRING								"Hold ^3[{+activate}]^7 for Bandolier Bandit [Cost: &&1]\nCarry Additional Ammo for All Weapons"

#define BANDOLIER_BANDIT_PERK										"specialty_disarmexplosive"
#define BANDOLIER_BANDIT_USE_SECONDARY_PERKS						0
#define BANDOLIER_BANDIT_SECONDARY_PERKS							array ("")

#define BANDOLIER_BANDIT_AMMO_MULTIPLIER							2 	//Additional Stock is this number of clips

#define BANDOLIER_BANDIT_DRAW_AMMO_STOCK							1	//Draw Bandolier stock on screen
#define BANDOLIER_BANDIT_AMMO_ALIGN_X								"right"
#define BANDOLIER_BANDIT_AMMO_ALIGN_Y								"bottom"
#define BANDOLIER_BANDIT_AMMO_X										-145
#define BANDOLIER_BANDIT_AMMO_Y										-2


// ======================================================================================================
// Blaze Phase
// ======================================================================================================
#define BLAZE_PHASE_COST											2000
#define BLAZE_PHASE_RADIANT_MACHINE_NAME							"vending_blaze_phase"	
#define BLAZE_PHASE_ALIAS											"blaze_phase"
#define BLAZE_PHASE_SCRIPT_STRING									"blaze_phase_perk"
#define BLAZE_PHASE_JINGLE											"blaze_phase_jingle"
#define BLAZE_PHASE_STING											"blaze_phase_sting"
#define BLAZE_PHASE_CLIENTFIELD										"hudItems.perks.blaze_phase"

#define BLAZE_PHASE_BOTTLE_WEAPON									"blaze_phase_perk_bottle_wpn"
#define BLAZE_PHASE_MACHINE_ACTIVE_MODEL							"blaze_phase_model"
#define BLAZE_PHASE_MACHINE_DISABLED_MODEL							"blaze_phase_model"
#define BLAZE_PHASE_MACHINE_LIGHT_FX								"west/perks/betiroval_fx_perk_blazephase_light"
#define BLAZE_PHASE_MODEL_BUCKET									"blaze_phase_model_bucket"

#define BLAZE_PHASE_COST_STRING										"2000"
#define BLAZE_PHASE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Blaze Phase [Cost: &&1]\nCrouch then Uncrouch to Dash Through Enemies in a Blaze of Fire\nStay Crouched to Charge for More Distance, Press Change Stance to Cancel"

#define BLAZE_PHASE_ICON											"blaze_phase_perk_icon_hud"
#define BLAZE_PHASE_PERK											"specialty_jetcharger"
#define BLAZE_PHASE_USE_SECONDARY_PERKS								0
#define BLAZE_PHASE_SECONDARY_PERKS									array ("")

#define BLAZE_PHASE_FX_EXPLOSION									"west/perks/3arc_aat_blast_furnace_zmb"
#define BLAZE_PHASE_FX_FIRE											"west/perks/3arc_bgb_burned_out_fire_torso_zmb"

#define BLAZE_PHASE_COOLDOWN										60
#define BLAZE_PHASE_MAX_CHARGE										8

#define BLAZE_PHASE_RANGE											128
#define BLAZE_PHASE_BOOST											1200


// ======================================================================================================
// Bleeding Bloody Mary
// ======================================================================================================
#define BLEEDING_COST												2000
#define BLEEDING_RADIANT_MACHINE_NAME								"vending_bleeding"	
#define BLEEDING_ALIAS												"bleeding"
#define BLEEDING_SCRIPT_STRING										"bleeding_perk"
#define BLEEDING_JINGLE												"bleeding_bloody_mary_jingle"
#define BLEEDING_STING												"bleeding_bloody_mary_sting"
#define BLEEDING_CLIENTFIELD										"hudItems.perks.bleeding"

#define BLEEDING_BOTTLE_WEAPON										"bleeding_perk_bottle_wpn"
#define BLEEDING_MACHINE_ACTIVE_MODEL								"bleeding_model"
#define BLEEDING_MACHINE_DISABLED_MODEL								"bleeding_model"
#define BLEEDING_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_sleight_of_hand_light"		
#define BLEEDING_MODEL_BUCKET										"bleeding_model_bucket"

#define BLEEDING_COST_STRING										"2000"
#define BLEEDING_TRIG_STRING										"Hold ^3[{+activate}]^7 for Bleeding Bloody Mary [Cost: &&1]\nWhen Low Health, Deal Impressive Damage"

#define BLEEDING_PERK												"specialty_bulletdamage"
#define BLEEDING_USE_SECONDARY_PERKS								0
#define BLEEDING_SECONDARY_PERKS									array ("")

																		// Normal: Zombies Deal 45 damage, Player Max Health is 100 or 200 with Jug
#define BLEEDING_LOW_HEALTH_PERCENTAGE								50	// Percentage of Max Health the player must be at or below to trigger damage buff
#define BLEEDING_DAMAGE_MULTIPLIER									10	// Amount to multiply damage when below low health threshold


// ======================================================================================================
// Blood Wolf Bite
// ======================================================================================================
#define BLOOD_WOLF_COST												3000
#define BLOOD_WOLF_RADIANT_MACHINE_NAME								"vending_blood_wolf"	
#define BLOOD_WOLF_ALIAS											"blood_wolf"
#define BLOOD_WOLF_SCRIPT_STRING									"blood_wolf_perk"
#define BLOOD_WOLF_JINGLE											"blood_wolf_jingle"
#define BLOOD_WOLF_STING											"blood_wolf_sting"
#define BLOOD_WOLF_CLIENTFIELD										"hudItems.perks.blood_wolf"

#define BLOOD_WOLF_BOTTLE_WEAPON									"blood_wolf_perk_bottle_wpn"
#define BLOOD_WOLF_LUNA_MODEL										"blood_wolf_luna_model"
#define BLOOD_WOLF_MACHINE_ACTIVE_MODEL								"blood_wolf_model"
#define BLOOD_WOLF_MACHINE_DISABLED_MODEL							"blood_wolf_model"
#define BLOOD_WOLF_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_doubletap_light"
#define BLOOD_WOLF_MODEL_BUCKET										"blood_wolf_model_bucket"

#define BLOOD_WOLF_COST_STRING										"3000"
#define BLOOD_WOLF_TRIG_STRING										"Hold ^3[{+activate}]^7 for Blood Wolf Bite [Cost: &&1]\nDealing a Lot of Damage Spawns a Friendly Wolf"

#define BLOOD_WOLF_ICON												"blood_wolf_perk_icon_hud"
#define BLOOD_WOLF_PERK												"specialty_immuneemp"
#define BLOOD_WOLF_USE_SECONDARY_PERKS								0
#define BLOOD_WOLF_SECONDARY_PERKS									array ("")

#define BLOOD_WOLF_DAMAGE_TO_START									2000 //Damage Required to Deal For Wolf to Spawn
#define BLOOD_WOLF_ACTIVE_TIME										60	//How Long Wolf is Alive For
#define BLOOD_WOLF_COOLDOWN_TIME									120	//How Long to Cooldown


// ======================================================================================================
// Brawlstar Punch
// ======================================================================================================
#define BRAWLSTAR_PUNCH_COST										5000
#define BRAWLSTAR_PUNCH_RADIANT_MACHINE_NAME						"vending_brawlstar_punch"
#define BRAWLSTAR_PUNCH_ALIAS										"brawlstar_punch"
#define BRAWLSTAR_PUNCH_SCRIPT_STRING								"brawlstar_punch_perk"
#define BRAWLSTAR_PUNCH_JINGLE										"brawlstar_punch_jingle"
#define BRAWLSTAR_PUNCH_STING										"brawlstar_punch_sting"
#define BRAWLSTAR_PUNCH_CLIENTFIELD									"hudItems.perks.brawlstar_punch"

#define BRAWLSTAR_PUNCH_BOTTLE_WEAPON								"brawlstar_punch_perk_bottle_wpn"
#define BRAWLSTAR_PUNCH_MACHINE_ACTIVE_MODEL						"brawlstar_punch_model"
#define BRAWLSTAR_PUNCH_MACHINE_DISABLED_MODEL						"brawlstar_punch_model"
#define BRAWLSTAR_PUNCH_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_stamin_up_light"
#define BRAWLSTAR_PUNCH_MODEL_BUCKET								"brawlstar_punch_model_bucket"

#define BRAWLSTAR_PUNCH_COST_STRING									"5000"
#define BRAWLSTAR_PUNCH_TRIG_STRING									"Hold ^3[{+activate}]^7 for Brawlstar Punch [Cost: &&1]\nTake on the Might of the Horde With Your Bare Fists\nPress ^3[{+actionslot 4}]^7 to Activate"

#define BRAWLSTAR_PUNCH_ICON										"brawlstar_punch_perk_icon_hud"
#define BRAWLSTAR_PUNCH_PERK										"specialty_proximityprotection"
#define BRAWLSTAR_PUNCH_USE_SECONDARY_PERKS							0
#define BRAWLSTAR_PUNCH_SECONDARY_PERKS								array ("")

#define BRAWLSTAR_PUNCH_WEAPON_FISTS								"brawlstar_punch_bare_hands_melee"

#define BRAWLSTAR_PUNCH_FIRST_SOUND									"brawlstar_punch_first_activate"
#define BRAWLSTAR_PUNCH_PLAY_FIRST_SOUND							1

#define BRAWLSTAR_PUNCH_BLOWBACK_FX									"west/perks/holofya_fx_dragon_head_fire_breath_short"
#define BRAWLSTAR_PUNCH_HIT_FX										"west/perks/holofya_fx_exp_smk_tendril_sm_os_evb"

#define BRAWLSTAR_PUNCH_TYPE										"pers" //Whether or not the perk gets taken after the effect has been used, valid values are "one-shot" or "pers"

#define BRAWLSTAR_PUNCH_DURATION									30 //The duration of Brawlstar Mode
#define BRAWLSTAR_PUNCH_COOLDOWN_TIME								180 //The duration of Brawlstar Mode's cooldown, only works when the type is "pers"

#define BRAWLSTAR_PUNCH_BLOWBACK_CHANCE								25 //Percent chance to activate Blowback
#define BRAWLSTAR_PUNCH_BLOWBACK_MIN_Z								75 //Min Z value applied to ragdoll launch
#define BRAWLSTAR_PUNCH_BLOWBACK_MAX_Z								150 //Max Z value applied to ragdoll launch
#define BRAWLSTAR_PUNCH_BLOWBACK_RANGE								240 //The range in which zombies are flung

#define BRAWLSTAR_PUNCH_VAPORIZE_CHANCE								25 //Percent chance to activate Vaporize
#define BRAWLSTAR_PUNCH_VAPORIZE_RANGE								240 //Zombie vaporization range

#define BRAWLSTAR_PUNCH_USE_FIRE_OVERLAY							1


// ======================================================================================================
// Brimstone Bramble
// ======================================================================================================
#define BRIMSTONE_BRAMBLE_COST										3000
#define BRIMSTONE_BRAMBLE_RADIANT_MACHINE_NAME						"vending_brimstone_bramble"	
#define BRIMSTONE_BRAMBLE_ALIAS										"brimstone_bramble"
#define BRIMSTONE_BRAMBLE_SCRIPT_STRING								"brimstone_bramble_perk"
#define BRIMSTONE_BRAMBLE_JINGLE									"brimstone_bramble_jingle"
#define BRIMSTONE_BRAMBLE_STING										"brimstone_bramble_sting"
#define BRIMSTONE_BRAMBLE_CLIENTFIELD								"hudItems.perks.brimstone_bramble"

#define BRIMSTONE_BRAMBLE_BOTTLE_WEAPON								"brimstone_bramble_perk_bottle_wpn"
#define BRIMSTONE_BRAMBLE_MACHINE_ACTIVE_MODEL						"brimstone_bramble_model"
#define BRIMSTONE_BRAMBLE_MACHINE_DISABLED_MODEL					"brimstone_bramble_model"
#define BRIMSTONE_BRAMBLE_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_tombstone_light"
#define BRIMSTONE_BRAMBLE_MODEL_BUCKET								"brimstone_bramble_model_bucket"

#define BRIMSTONE_BRAMBLE_PERK										"specialty_fireproof"
#define BRIMSTONE_BRAMBLE_USE_SECONDARY_PERKS						0
#define BRIMSTONE_BRAMBLE_SECONDARY_PERKS							array ("")

#define BRIMSTONE_BRAMBLE_COST_STRING								"3000"
#define BRIMSTONE_BRAMBLE_TRIG_STRING								"Hold ^3[{+activate}]^7 for Brimstone Bramble [Cost: &&1]\nImmune to Fire Damage\nDeal Constant Damage to Nearby Enemies"

#define BRIMSTONE_BRAMBLE_EXPLOSION_FX            					"brimstone_fire_fx" 						//level._effect for explosion
#define BRIMSTONE_BRAMBLE_EXPLOSION_FX_FILE       					"west/perks/km_fx_vigor_rush_exp" //"west/perks/3arc_fx_fire_ai_human_torso_os" //FX File for explosion

#define BRIMSTONE_BRAMBLE_CYCLE_TIME								1
#define BRIMSTONE_BRAMBLE_FIRE_RADIUS								256
#define BRIMSTONE_BRAMBLE_FIRE_PERCENT								.05 //Percent of Enemy Health Dealt Per Second
#define BRIMSTONE_BRAMBLE_MINIMUM_DAMAGE							10


// ======================================================================================================
// Bull Ice Blast
// ======================================================================================================
#define BULL_ICE_BLAST_COST											4500
#define BULL_ICE_BLAST_RADIANT_MACHINE_NAME							"vending_bull_ice_blast"	
#define BULL_ICE_BLAST_ALIAS										"bull_ice_blast"
#define BULL_ICE_BLAST_SCRIPT_STRING								"bull_ice_blast_perk"
#define BULL_ICE_BLAST_JINGLE										"bull_ice_blast_jingle"
#define BULL_ICE_BLAST_STING										"bull_ice_blast_sting"
#define BULL_ICE_BLAST_CLIENTFIELD									"hudItems.perks.bull_ice_blast"

#define BULL_ICE_BLAST_BOTTLE_WEAPON								"bull_ice_blast_perk_bottle_wpn"
#define BULL_ICE_BLAST_MACHINE_ACTIVE_MODEL							"bull_ice_blast_model_on"
#define BULL_ICE_BLAST_MACHINE_DISABLED_MODEL						"bull_ice_blast_model"
#define BULL_ICE_BLAST_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_quick_revive_light"
#define BULL_ICE_BLAST_MODEL_BUCKET									"bull_ice_blast_model_bucket"

#define BULL_ICE_BLAST_COST_STRING									"4500"
#define BULL_ICE_BLAST_TRIG_STRING									"Hold ^3[{+activate}]^7 for Bull Ice Blast [Cost: &&1]\nImmune to Fall Damage\nGain an Additional Jump, Press Change Stance While in Air to Slam Blast Zombies into Ice"

#define BULL_ICE_BLAST_PERK											"specialty_fallheight"
#define BULL_ICE_BLAST_USE_SECONDARY_PERKS							0
#define BULL_ICE_BLAST_SECONDARY_PERKS								array ("")

#define BULL_ICE_BLAST_SLAM_ICE_BLOCK								"bull_ice_blast_ice_chunk"
#define BULL_ICE_BLAST_SLAM_ICE_BREAK_FX							"west/perks/madgaz_bull_ice_break_fx"
#define BULL_ICE_BLAST_SLAM_ICE_IDLE_FX								"west/perks/madgaz_bull_ice_idle_fx"
#define BULL_ICE_BLAST_SLAM_ICE_IMPACT_FX							"west/perks/madgaz_bull_ice_impact_fx"

#define BULL_ICE_BLAST_SOUND_FREEZE									"bull_ice_blast_freeze_"
#define BULL_ICE_BLAST_SOUND_FREEZE_COUNT							3
#define BULL_ICE_BLAST_SOUND_IMPACT									"bull_ice_blast_impact_"
#define BULL_ICE_BLAST_SOUND_IMPACT_COUNT							4
#define BULL_ICE_BLAST_SOUND_SHATTER								"bull_ice_blast_shatter_"
#define BULL_ICE_BLAST_SOUND_SHATTER_COUNT							3

#define BULL_ICE_BLAST_DOUBLE_JUMP_ADD_VELOCITY						500	//Velocity added to Z-axis
#define BULL_ICE_BLAST_SLAM_RANGE									196
#define BULL_ICE_BLAST_SLAM_SPEED									-750 //Velocity added to Z-axis when slamming

#define BULL_ICE_BLAST_ZOMBIE_SLOWDOWN_RATE							0.1
#define BULL_ICE_BLAST_ZOMBIE_SLOWDOWN_TIME							20.0


// ======================================================================================================
// Crack Shot Cremat
// ======================================================================================================
#define CRACK_SHOT_COST												2500
#define CRACK_SHOT_RADIANT_MACHINE_NAME								"vending_crack_shot"
#define CRACK_SHOT_ALIAS											"crack_shot"
#define CRACK_SHOT_SCRIPT_STRING									"crack_shot_perk"
#define CRACK_SHOT_JINGLE											"crack_shot_jingle"
#define CRACK_SHOT_STING											"crack_shot_sting"
#define CRACK_SHOT_CLIENTFIELD										"hudItems.perks.crack_shot"

#define CRACK_SHOT_BOTTLE_WEAPON									"crack_shot_perk_bottle_wpn"
#define CRACK_SHOT_MACHINE_ACTIVE_MODEL								"crack_shot_model"
#define CRACK_SHOT_MACHINE_DISABLED_MODEL							"crack_shot_model"
#define CRACK_SHOT_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_quick_revive_light"
#define CRACK_SHOT_MODEL_BUCKET										"crack_shot_model_bucket"

#define CRACK_SHOT_COST_STRING										"2500"
#define CRACK_SHOT_TRIG_STRING										"Hold ^3[{+activate}]^7 for Crack Shot Cremat [Cost: &&1]\nHeadshot Kills Award Ammo"

#define CRACK_SHOT_PERK												"specialty_immunetriggershock"
#define CRACK_SHOT_USE_SECONDARY_PERKS								0
#define CRACK_SHOT_SECONDARY_PERKS									array ("")

#define CRACK_SHOT_HEADSHOT_AMMO_GIVE								2 //Ammo to award for getting a headshot


// ======================================================================================================
// Crusader's Ale
// ======================================================================================================
#define CRUSADERS_ALE_COST											3000
#define CRUSADERS_ALE_RADIANT_MACHINE_NAME							"vending_crusaders_ale"	
#define CRUSADERS_ALE_ALIAS											"crusaders_ale"
#define CRUSADERS_ALE_SCRIPT_STRING									"crusaders_ale_perk"
#define CRUSADERS_ALE_JINGLE										"crusaders_ale_jingle"
#define CRUSADERS_ALE_STING											"crusaders_ale_sting"
#define CRUSADERS_ALE_CLIENTFIELD									"hudItems.perks.crusaders_ale"

#define CRUSADERS_ALE_BOTTLE_WEAPON									"crusaders_ale_perk_bottle_wpn"
#define CRUSADERS_ALE_MACHINE_ACTIVE_MODEL							"crusaders_ale_model_on"
#define CRUSADERS_ALE_MACHINE_DISABLED_MODEL						"crusaders_ale_model"
#define CRUSADERS_ALE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_juggernaut_light"
#define CRUSADERS_ALE_MODEL_BUCKET									"crusaders_ale_model_bucket"	

#define CRUSADERS_ALE_COST_STRING									"3000"
#define CRUSADERS_ALE_TRIG_STRING									"Hold ^3[{+activate}]^7 for Crusader's Ale [Cost: &&1]\nIncreased Melee Damage, Melee Kills Reward Bonus Points, Shield Repairs Each Round"

#define CRUSADERS_ALE_PERK											"specialty_flashprotection"
#define CRUSADERS_ALE_USE_SECONDARY_PERKS							0
#define CRUSADERS_ALE_SECONDARY_PERKS								array ("")

#define CRUSADERS_ALE_MELEE_MULTIPLIER								8
#define CRUSADERS_ALE_MELEE_POINTS									130


// ======================================================================================================
// Cryo-Slide Soda
// ======================================================================================================
#define CRYO_SLIDE_COST												3000
#define CRYO_SLIDE_RADIANT_MACHINE_NAME								"vending_cryo_slide"	
#define CRYO_SLIDE_ALIAS											"cryo_slide"
#define CRYO_SLIDE_SCRIPT_STRING									"cryo_slide_perk"
#define CRYO_SLIDE_JINGLE											"cryo_slide_jingle"
#define CRYO_SLIDE_STING											"cryo_slide_sting"
#define CRYO_SLIDE_CLIENTFIELD										"hudItems.perks.cryo_slide"

#define CRYO_SLIDE_BOTTLE_WEAPON									"cryo_slide_perk_bottle_wpn"
#define CRYO_SLIDE_MACHINE_ACTIVE_MODEL								"cryo_slide_model"
#define CRYO_SLIDE_MACHINE_DISABLED_MODEL							"cryo_slide_model"
#define CRYO_SLIDE_MACHINE_LIGHT_FX									"west/perks/abnormal202_perk_cryo_light"		
#define CRYO_SLIDE_MODEL_BUCKET										"cryo_slide_model_bucket"

#define CRYO_SLIDE_COST_STRING										"3000"
#define CRYO_SLIDE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Cryo-Slide Soda [Cost: &&1]\nSliding or Knifing Will Freeze Nearby Zombies, Frozen Zombies Thaw to a Walking Speed"

#define CRYO_SLIDE_ICON												"cryo_slide_perk_icon_hud"
#define CRYO_SLIDE_PERK												"specialty_stunprotection"
#define CRYO_SLIDE_USE_SECONDARY_PERKS								0
#define CRYO_SLIDE_SECONDARY_PERKS									array ("")

#define CRYO_SLIDE_FX_ACTIVATE										"west/perks/abnormal202_cryo_slide_freeze"
#define CRYO_SLIDE_FX_IDLE											"west/perks/madgaz_bull_ice_idle_fx"
#define CRYO_SLIDE_FX_FROZEN_ZOMBIE_KILL							"west/perks/abnormal202_cryo_freeze_impact"

#define CRYO_SLIDE_PLAY_SOUNDS										1 //Allow sounds to play
#define CRYO_SLIDE_SOUND_ACTIVATE									"cryo_slide_freeze"
#define CRYO_SLIDE_SOUND_READY										"cryo_slide_ready"

#define CRYO_SLIDE_COOLDOWN											12
#define CRYO_SLIDE_MAX_FREEZE										64
#define CRYO_SLIDE_RANGE											200

#define CRYO_SLIDE_FROZEN_DURATION									5.0
#define CRYO_SLIDE_FROZEN_RATE										.1
#define CRYO_SLIDE_THAWING_DURATION									10.0
#define CRYO_SLIDE_THAWING_RATE										.75

#define CRYO_SLIDE_USE_FROZEN_ZOMBIE_MODEL							0
#define CRYO_SLIDE_ZOMBIE_FROZEN_MODEL								"cryo_slide_zombie_body_frozen_model"


// ======================================================================================================
// Death Perception
// ======================================================================================================
#define DEATH_PERCEPTION_COST										2000
#define DEATH_PERCEPTION_RADIANT_MACHINE_NAME						"vending_death_perception"
#define DEATH_PERCEPTION_ALIAS										"death_perception"
#define DEATH_PERCEPTION_SCRIPT_STRING								"death_perception_perk"
#define DEATH_PERCEPTION_JINGLE										"death_perception_jingle"
#define DEATH_PERCEPTION_STING										"death_perception_sting"
#define DEATH_PERCEPTION_CLIENTFIELD								"hudItems.perks.death_perception"

#define DEATH_PERCEPTION_BOTTLE_WEAPON								"death_perception_perk_bottle_wpn"
#define DEATH_PERCEPTION_MACHINE_ACTIVE_MODEL						"death_perception_model"
#define DEATH_PERCEPTION_MACHINE_DISABLED_MODEL						"death_perception_model_off"
#define DEATH_PERCEPTION_MACHINE_LIGHT_FX							"west/perks/sphynx_fx_perk_death_perception_light"
#define DEATH_PERCEPTION_MODEL_BUCKET								"death_perception_model_bucket"

#define DEATH_PERCEPTION_COST_STRING								"2000"
#define DEATH_PERCEPTION_TRIG_STRING								"Hold ^3[{+activate}]^7 for Death Perception [Cost: &&1]\nSee Enemies Through Objects and Walls"

#define DEATH_PERCEPTION_PERK										"specialty_tracker"
#define DEATH_PERCEPTION_USE_SECONDARY_PERKS						0
#define DEATH_PERCEPTION_SECONDARY_PERKS							array ("")

#define DEATH_PERCEPTION_DANGER_ICON								"death_perception_noncombat_danger"
#define DEATH_PERCEPTION_KEYLINE_MAT								"mc/death_perception_keyline_mat"
#define DEATH_PERCEPTION_PERK_TOPLAYER_CF							"death_perception_perk_toplayer"


// ======================================================================================================
// Divine Ale
// ======================================================================================================
#define DIVINE_ALE_COST												3000
#define DIVINE_ALE_RADIANT_MACHINE_NAME								"vending_divine_ale"	
#define DIVINE_ALE_ALIAS											"divine_ale"
#define DIVINE_ALE_SCRIPT_STRING									"divine_ale_perk"
#define DIVINE_ALE_JINGLE											"divine_ale_jingle"
#define DIVINE_ALE_STING											"divine_ale_sting"
#define DIVINE_ALE_CLIENTFIELD										"hudItems.perks.divine_ale"

#define DIVINE_ALE_BOTTLE_WEAPON									"divine_ale_perk_bottle_wpn"
#define DIVINE_ALE_MACHINE_ACTIVE_MODEL								"divine_ale_model_on"
#define DIVINE_ALE_MACHINE_DISABLED_MODEL							"divine_ale_model_off"
#define DIVINE_ALE_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_widows_wine_light"
#define DIVINE_ALE_MODEL_BUCKET										"divine_ale_model_bucket"	

#define DIVINE_ALE_COST_STRING										"3000"
#define DIVINE_ALE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Divine Ale [Cost: &&1]\nWeapons in Your First Weapon Slot Become Divine\nDivine Weapons Receive Max Ammo Every Round, Deal Double Damage During Double Points, and Earn Double Points During Insta-Kill"

#define DIVINE_ALE_PERK												"specialty_immunetriggerc4"
#define DIVINE_ALE_USE_SECONDARY_PERKS								0
#define DIVINE_ALE_SECONDARY_PERKS									array ("")

#define DIVINE_ALE_WEAPON_GLOW_FX									"west/perks/killjoy_divine_ale_weapon_fx"

#define DIVINE_ALE_DAMAGE_MULTIPLIER								2
#define DIVINE_ALE_POINTS_MULTIPLIER								2
#define DIVINE_ALE_POINTS_HEADSHOT									100
#define DIVINE_ALE_POINTS_MELEE										130
#define DIVINE_ALE_POINTS_NORMAL									60


// ======================================================================================================
// Double Dew
// ======================================================================================================
#define DOUBLE_DEW_COST												4000
#define DOUBLE_DEW_RADIANT_MACHINE_NAME								"vending_double_dew"
#define DOUBLE_DEW_ALIAS											"double_dew"
#define DOUBLE_DEW_SCRIPT_STRING									"double_dew_perk"
#define DOUBLE_DEW_JINGLE											"double_dew_jingle"
#define DOUBLE_DEW_STING											"double_dew_sting"
#define DOUBLE_DEW_CLIENTFIELD										"hudItems.perks.double_dew"

#define DOUBLE_DEW_BOTTLE_WEAPON									"double_dew_perk_bottle_wpn"
#define DOUBLE_DEW_MACHINE_ACTIVE_MODEL								"double_dew_model_on"
#define DOUBLE_DEW_MACHINE_DISABLED_MODEL							"double_dew_model_off"
#define DOUBLE_DEW_MACHINE_LIGHT_FX									"west/perks/logical_double_dew"
#define DOUBLE_DEW_MODEL_BUCKET										"double_dew_model_bucket"

#define DOUBLE_DEW_COST_STRING										"4000"
#define DOUBLE_DEW_TRIG_STRING										"Hold ^3[{+activate}]^7 for Double Dew [Cost: &&1]\nKills Award Bonus Points"

#define DOUBLE_DEW_PERK												"specialty_immunemms"
#define DOUBLE_DEW_USE_SECONDARY_PERKS								0
#define DOUBLE_DEW_SECONDARY_PERKS									array ("")

#define DOUBLE_DEW_BONUS_FOR_HEADSHOT								100 //Bonus points for getting a headshot
#define DOUBLE_DEW_BONUS_FOR_MELEE									130 //Bonus points for getting a headshot
#define DOUBLE_DEW_BONUS_FOR_NORMAL									60 //Bonus points for getting a headshot


// ======================================================================================================
// Double Tap 1
// ======================================================================================================
#define DOUBLETAP1_COST												2000
#define DOUBLETAP1_RADIANT_MACHINE_NAME								"vending_doubletap1"	
#define DOUBLETAP1_ALIAS											"doubletap1"
#define DOUBLETAP1_SCRIPT_STRING									"doubletap1_perk"
#define DOUBLETAP1_JINGLE											"doubletap_jingle"
#define DOUBLETAP1_STING											"doubletap_sting"
#define DOUBLETAP1_CLIENTFIELD										"hudItems.perks.doubletap1"

#define DOUBLETAP1_BOTTLE_WEAPON									"doubletap1_perk_bottle_wpn"
#define DOUBLETAP1_MACHINE_ACTIVE_MODEL								"doubletap1_model"
#define DOUBLETAP1_MACHINE_DISABLED_MODEL							"doubletap1_model"
#define DOUBLETAP1_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_doubletap_light"
#define DOUBLETAP1_MODEL_BUCKET										"doubletap1_model_bucket"	

#define DOUBLETAP1_COST_STRING										"2000"
#define DOUBLETAP1_TRIG_STRING										"Hold ^3[{+activate}]^7 for Double Tap Root Beer [Cost: &&1]\nIncreases Weapon Rate of Fire"

#define DOUBLETAP1_PERK												"specialty_rof"
#define DOUBLETAP1_USE_SECONDARY_PERKS								0
#define DOUBLETAP1_SECONDARY_PERKS									array ("")


// ======================================================================================================
// Double Tap 3
// ======================================================================================================
#define DOUBLETAP3_COST												3500
#define DOUBLETAP3_RADIANT_MACHINE_NAME								"vending_doubletap3"	
#define DOUBLETAP3_ALIAS											"doubletap3"
#define DOUBLETAP3_SCRIPT_STRING									"doubletap3_perk"
#define DOUBLETAP3_JINGLE											"doubletap_jingle"
#define DOUBLETAP3_STING											"doubletap_sting"
#define DOUBLETAP3_CLIENTFIELD										"hudItems.perks.doubletap3"

#define DOUBLETAP3_BOTTLE_WEAPON									"doubletap3_perk_bottle_wpn"
#define DOUBLETAP3_MACHINE_ACTIVE_MODEL								"doubletap3_model"
#define DOUBLETAP3_MACHINE_DISABLED_MODEL							"doubletap3_model"
#define DOUBLETAP3_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_doubletap_light"
#define DOUBLETAP3_MODEL_BUCKET										"doubletap3_model_bucket"

#define DOUBLETAP3_COST_STRING										"3500"
#define DOUBLETAP3_TRIG_STRING										"Hold ^3[{+activate}]^7 for Double Tap 3.0 [Cost: &&1]\nWeapon Fire Rate Increase, Triples All Damage Dealt"

#define DOUBLETAP3_PERK												"specialty_rof"
#define DOUBLETAP3_USE_SECONDARY_PERKS								0
#define DOUBLETAP3_SECONDARY_PERKS									array ("")

#define DOUBLETAP3_DAMAGE_BUFF_MULTIPLIER							3 //Damage buff for every attack


// ======================================================================================================
// Dying Wish
// ======================================================================================================
#define DYING_WISH_COST												4000
#define DYING_WISH_RADIANT_MACHINE_NAME								"vending_dying_wish"	
#define DYING_WISH_ALIAS											"dying_wish"
#define DYING_WISH_SCRIPT_STRING									"dying_wish_perk"
#define DYING_WISH_JINGLE											"dying_wish_jingle"
#define DYING_WISH_STING											"dying_wish_sting"
#define DYING_WISH_CLIENTFIELD										"hudItems.perks.dying_wish"

#define DYING_WISH_BOTTLE_WEAPON									"dying_wish_perk_bottle_wpn"
#define DYING_WISH_MACHINE_ACTIVE_MODEL								"dying_wish_model"
#define DYING_WISH_MACHINE_DISABLED_MODEL							"dying_wish_model"
#define DYING_WISH_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_doubletap_light"
#define DYING_WISH_MODEL_BUCKET										"dying_wish_model_bucket"		

#define DYING_WISH_COST_STRING										"4000"
#define DYING_WISH_TRIG_STRING										"Hold ^3[{+activate}]^7 for Dying Wish [Cost: &&1]\nInstead of Entering Last Stand, Enter Berserk Mode\nWhile Berserk, Player is Invincible and Deals Massive Melee Damage"

#define DYING_WISH_ICON												"dying_wish_perk_icon_hud"
#define DYING_WISH_PERK												"specialty_immunerangefinder"
#define DYING_WISH_USE_SECONDARY_PERKS								0
#define DYING_WISH_SECONDARY_PERKS									array ("")

#define DYING_WISH_BERSERK_TIME										9	//How long Berserk mode lasts for
#define DYING_WISH_BERSERK_COOLDOWN									180	//How long is the cooldown
#define DYING_WISH_BERSERK_MULTIPLIER								1	//Percent of AI's max health to deal when meleeing during Berserk

#define DYING_WISH_PLAY_SOUNDS										1
#define DYING_WISH_SOUND_START										"zmb_bgb_plainsight_start"
#define DYING_WISH_SOUND_LOOP										"zmb_bgb_plainsight_loop"
#define DYING_WISH_SOUND_END										"zmb_bgb_plainsight_end"


// ======================================================================================================
// Electric Cherry
// ======================================================================================================
#define ELECTRIC_CHERRY_COST										2000
#define ELECTRIC_CHERRY_RADIANT_MACHINE_NAME						"vending_electric_cherry"	
#define ELECTRIC_CHERRY_ALIAS										"electric_cherry"
#define ELECTRIC_CHERRY_SCRIPT_STRING								"electric_cherry_perk"
#define ELECTRIC_CHERRY_JINGLE										"electric_cherry_jingle"
#define ELECTRIC_CHERRY_STING										"electric_cherry_sting"
#define ELECTRIC_CHERRY_CLIENTFIELD									"hudItems.perks.electric_cherry"

#define ELECTRIC_CHERRY_BOTTLE_WEAPON								"electric_cherry_perk_bottle_wpn"
#define ELECTRIC_CHERRY_MACHINE_ACTIVE_MODEL						"electric_cherry_model"
#define ELECTRIC_CHERRY_MACHINE_DISABLED_MODEL						"electric_cherry_model"
#define ELECTRIC_CHERRY_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_electric_cherry_light"
#define ELECTRIC_CHERRY_MODEL_BUCKET								"electric_cherry_model_bucket"

#define ELECTRIC_CHERRY_COST_STRING									"2000"
#define ELECTRIC_CHERRY_TRIG_STRING									"Hold ^3[{+activate}]^7 for Electric Cherry [Cost: &&1]\nReloading Creates a Ring of Electricity Around the Player"

#define ELECTRIC_CHERRY_PERK										"specialty_electriccherry"
#define ELECTRIC_CHERRY_USE_SECONDARY_PERKS							0
#define ELECTRIC_CHERRY_SECONDARY_PERKS								array ("")

#define ELECTRIC_CHERRY_FX_DEATH_NAME								"electric_cherry_tesla_death"
#define ELECTRIC_CHERRY_FX_DEATH_FILE								"west/perks/3arc_fx_tesla_shock_zmb"
#define ELECTRIC_CHERRY_FX_EXPLODE_NAME								"electric_cherry_explode"
#define ELECTRIC_CHERRY_FX_EXPLODE_FILE								"west/perks/3arc_fx_castle_electric_cherry_down"
#define ELECTRIC_CHERRY_FX_SHOCK_NAME								"electric_cherry_tesla_shock"
#define ELECTRIC_CHERRY_FX_SHOCK_FILE								"west/perks/3arc_fx_bmode_shock_os_zod_zmb"
#define ELECTRIC_CHERRY_FX_SHOCK_EYES_NAME							"electric_cherry_tesla_shock_eyes"
#define ELECTRIC_CHERRY_FX_SHOCK_EYES_FILE							"west/perks/3arc_fx_tesla_shock_eyes_zmb"
#define ELECTRIC_CHERRY_FX_TRAIL_NAME								"electric_cherry_trail"
#define ELECTRIC_CHERRY_FX_TRAIL_FILE								"west/perks/3arc_fx_castle_electric_cherry_trail"

#define ELECTRIC_CHERRY_SOUND_ATTACK								"electric_cherry_attack"

#define ELECTRIC_CHERRY_STUN_CYCLES									4

#define ELECTRIC_CHERRY_DOWNED_ATTACK_RADIUS						200
#define ELECTRIC_CHERRY_DOWNED_ATTACK_DAMAGE						2000

#define ELECTRIC_CHERRY_RELOAD_ATTACK_MIN_RADIUS					32
#define ELECTRIC_CHERRY_RELOAD_ATTACK_MAX_RADIUS					196
#define ELECTRIC_CHERRY_RELOAD_ATTACK_MIN_DAMAGE					250
#define ELECTRIC_CHERRY_RELOAD_ATTACK_MAX_DAMAGE					1045


// ======================================================================================================
// Elemental Pop
// ======================================================================================================
#define ELEMENTAL_POP_COST											6000
#define ELEMENTAL_POP_RADIANT_MACHINE_NAME							"vending_elemental_pop"	
#define ELEMENTAL_POP_ALIAS											"elemental_pop"
#define ELEMENTAL_POP_SCRIPT_STRING									"elemental_pop_perk"
#define ELEMENTAL_POP_JINGLE										"elemental_pop_jingle"
#define ELEMENTAL_POP_STING											"elemental_pop_sting"
#define ELEMENTAL_POP_CLIENTFIELD									"hudItems.perks.elemental_pop"

#define ELEMENTAL_POP_BOTTLE_WEAPON									"elemental_pop_perk_bottle_wpn"
#define ELEMENTAL_POP_MACHINE_ACTIVE_MODEL							"elemental_pop_model_on"
#define ELEMENTAL_POP_MACHINE_DISABLED_MODEL						"elemental_pop_model_off"
#define ELEMENTAL_POP_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_elemental_pop_light"
#define ELEMENTAL_POP_MODEL_BUCKET									"elemental_pop_model_bucket"

#define ELEMENTAL_POP_COST_STRING									"6000"
#define ELEMENTAL_POP_TRIG_STRING									"Hold ^3[{+activate}]^7 for Elemental Pop [Cost: &&1]\nAttacks Can Trigger Random AATs"

#define ELEMENTAL_POP_ICON											"elemental_pop_perk_icon_hud"
#define ELEMENTAL_POP_PERK											"specialty_combat_efficiency"
#define ELEMENTAL_POP_USE_SECONDARY_PERKS							0
#define ELEMENTAL_POP_SECONDARY_PERKS								array ("")

#define ELEMENTAL_POP_ACTIVATE_SOUND								"elemental_pop_activate"

#define ELEMENTAL_POP_ACTIVATION_CHANCE								5 //Percent chance an attack will trigger an AAT
#define ELEMENTAL_POP_COOLDOWN										30


// ======================================================================================================
// Ethereal Razor
// ======================================================================================================
#define ETHEREAL_RAZOR_COST											5000
#define ETHEREAL_RAZOR_RADIANT_MACHINE_NAME							"vending_ethereal_razor"
#define ETHEREAL_RAZOR_ALIAS										"ethereal_razor"
#define ETHEREAL_RAZOR_SCRIPT_STRING								"ethereal_razor_perk"
#define ETHEREAL_RAZOR_JINGLE										"ethereal_razor_jingle"
#define ETHEREAL_RAZOR_STING										"ethereal_razor_sting"
#define ETHEREAL_RAZOR_CLIENTFIELD									"hudItems.perks.ethereal_razor"

#define ETHEREAL_RAZOR_BOTTLE_WEAPON								"ethereal_razor_perk_bottle_wpn"
#define ETHEREAL_RAZOR_KNIFE_WEAPON									"ethereal_razor_knife_wpn"
#define ETHEREAL_RAZOR_MACHINE_ACTIVE_MODEL							"ethereal_razor_model"
#define ETHEREAL_RAZOR_MACHINE_DISABLED_MODEL						"ethereal_razor_model"
#define ETHEREAL_RAZOR_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_juggernaut_light"
#define ETHEREAL_RAZOR_MODEL_BUCKET									"ethereal_razor_model_bucket"

#define ETHEREAL_RAZOR_FX_FLESH_HIT									"west/perks/logistical_reaper_razor_knife_flesh_hit"
#define ETHEREAL_RAZOR_FX_KNIFE_TRAIL								"west/perks/logistical_reaper_razor_knife_trail"

#define ETHEREAL_RAZOR_COST_STRING									"5000"
#define ETHEREAL_RAZOR_TRIG_STRING									"Hold ^3[{+activate}]^7 for Ethereal Razor [Cost: &&1]\nIncreased Melee Damage, Swipe Multiple Zombies, Regain Health After Each Swing"

#define ETHEREAL_RAZOR_PERK											"specialty_immunesmoke"
#define ETHEREAL_RAZOR_USE_SECONDARY_PERKS							0
#define ETHEREAL_RAZOR_SECONDARY_PERKS								array ("")

#define ETHEREAL_RAZOR_DAMAGE										7000 //Damage to deal per melee attack
#define ETHEREAL_RAZOR_HEAL											10 //Amount to Heal for each Zombie hit with Melee
#define ETHEREAL_RAZOR_MAX_SWIPE									4 //Max # of Zombies that can be hit per melee swipe
#define ETHEREAL_RAZOR_RANGE										48 //Max Range of Swipe


// ======================================================================================================
// Fighter's Fizz
// ======================================================================================================
#define FIGHTERS_FIZZ_COST											3500
#define FIGHTERS_FIZZ_RADIANT_MACHINE_NAME							"vending_fighters_fizz"	
#define FIGHTERS_FIZZ_ALIAS											"fighters_fizz"
#define FIGHTERS_FIZZ_SCRIPT_STRING									"fighters_fizz_perk"
#define FIGHTERS_FIZZ_JINGLE										"fighters_fizz_jingle"
#define FIGHTERS_FIZZ_STING											"fighters_fizz_sting"
#define FIGHTERS_FIZZ_CLIENTFIELD									"hudItems.perks.fighters_fizz"

#define FIGHTERS_FIZZ_BOTTLE_WEAPON									"fighters_fizz_perk_bottle_wpn"
#define FIGHTERS_FIZZ_MACHINE_ACTIVE_MODEL							"fighters_fizz_model_on"
#define FIGHTERS_FIZZ_MACHINE_DISABLED_MODEL						"fighters_fizz_model_off"
#define FIGHTERS_FIZZ_MACHINE_LIGHT_FX								"west/perks/logical_fighterfizz_light"
#define FIGHTERS_FIZZ_MODEL_BUCKET									"fighters_fizz_model_bucket"	

#define FIGHTERS_FIZZ_COST_STRING									"3500"
#define FIGHTERS_FIZZ_TRIG_STRING									"Hold ^3[{+activate}]^7 for Fighter's Fizz [Cost: &&1]\nKeep Your Gun After Downing and Get a Kill to Revive Yourself and Keep Perks"

#define FIGHTERS_FIZZ_PERK											"specialty_jetquiet"
#define FIGHTERS_FIZZ_USE_SECONDARY_PERKS							0
#define FIGHTERS_FIZZ_SECONDARY_PERKS								array ("")


// ======================================================================================================
// Gambler's Gibson
// ======================================================================================================
#define GAMBLERS_GIBSON_COST										3500
#define GAMBLERS_GIBSON_RADIANT_MACHINE_NAME						"vending_gamblers_gibson"
#define GAMBLERS_GIBSON_ALIAS										"gamblers_gibson"
#define GAMBLERS_GIBSON_SCRIPT_STRING								"gamblers_gibson_perk"
#define GAMBLERS_GIBSON_JINGLE										"gamblers_gibson_jingle"
#define GAMBLERS_GIBSON_STING										"gamblers_gibson_sting"
#define GAMBLERS_GIBSON_CLIENTFIELD									"hudItems.perks.gamblers_gibson"

#define GAMBLERS_GIBSON_BOTTLE_WEAPON								"gamblers_gibson_perk_bottle_wpn"
#define GAMBLERS_GIBSON_MACHINE_ACTIVE_MODEL						"gamblers_gibson_model"
#define GAMBLERS_GIBSON_MACHINE_DISABLED_MODEL						"gamblers_gibson_model"
#define GAMBLERS_GIBSON_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_tombstone_light"
#define GAMBLERS_GIBSON_MODEL_BUCKET								"gamblers_gibson_model_bucket"	

#define GAMBLERS_GIBSON_COST_STRING									"3500"
#define GAMBLERS_GIBSON_TRIG_STRING									"Hold ^3[{+activate}]^7 for Gambler's Gibson [Cost: &&1]\nChance to Get PaP Weapons From the Mystery Box"

#define GAMBLERS_GIBSON_PERK										"specialty_showenemyvehicles"
#define GAMBLERS_GIBSON_USE_SECONDARY_PERKS							0
#define GAMBLERS_GIBSON_SECONDARY_PERKS								array ("")

#define GAMBLERS_GIBSON_PAP_CHANCE									50 //1-100% Chance to Get PaP Weapon From Box


// ======================================================================================================
// Glitching Gin
// ======================================================================================================
#define GLITCHING_GIN_COST											4000
#define GLITCHING_GIN_RADIANT_MACHINE_NAME							"vending_glitching_gin"
#define GLITCHING_GIN_ALIAS											"glitching_gin"
#define GLITCHING_GIN_SCRIPT_STRING									"glitching_gin_perk"
#define GLITCHING_GIN_JINGLE										"glitching_gin_jingle"
#define GLITCHING_GIN_STING											"glitching_gin_sting"
#define GLITCHING_GIN_CLIENTFIELD									"hudItems.perks.glitching_gin"

#define GLITCHING_GIN_BOTTLE_WEAPON									"glitching_gin_perk_bottle_wpn"
#define GLITCHING_GIN_MACHINE_ACTIVE_MODEL							"glitching_gin_model_on"
#define GLITCHING_GIN_MACHINE_DISABLED_MODEL						"glitching_gin_model_off"
#define GLITCHING_GIN_MACHINE_LIGHT_FX								"west/perks/holofya_glitch_perk_light"
#define GLITCHING_GIN_MODEL_BUCKET									"glitching_gin_model_bucket"

#define GLITCHING_GIN_SOUND_GRENADE_EXPLODE							"glitching_gin_grenade_explode"
#define GLITCHING_GIN_SOUND_GRENADE_IMPACT							"glitching_gin_grenade_impact"
#define GLITCHING_GIN_SOUND_GRENADE_KILL_ZOMBIES					"glitching_gin_grenade_kill_zombies"
#define GLITCHING_GIN_SOUND_GRENADE_REGEN							"glitching_gin_grenade_regen"
#define GLITCHING_GIN_SOUND_GRENADE_WINDUP							"glitching_gin_grenade_windup"
#define GLITCHING_GIN_SOUND_PLAYER_TP_FRACTURE						"glitching_gin_player_tp_fracture"
#define GLITCHING_GIN_SOUND_WARP_PLAYER								"glitching_gin_warp_player"
#define GLITCHING_GIN_SOUND_WARP_PLAYER_IN_THIRD					"glitching_gin_warp_player_in_third"
#define GLITCHING_GIN_SOUND_WARP_PLAYER_OUT_THIRD					"glitching_gin_warp_player_out_third"

#define GLITCHING_GIN_GRENADE_LETHAL								"glitching_gin_grenade_wpn_lethal"
#define GLITCHING_GIN_GRENADE_TACTICAL								"glitching_gin_grenade_wpn_tactical"

#define GLITCHING_GIN_GRENADE_AOE_EXPLODE							"west/perks/holofya_glitch_trigger_aoe_cubes"
#define GLITCHING_GIN_GRENADE_EXPLODE								"west/perks/holofya_glitch_trigger_cubes"
#define GLITCHING_GIN_GRENADE_IMPACT								"west/perks/holofya_glitch_grenade_impact_burst"

#define GLITCHING_GIN_COST_STRING									"4000"
#define GLITCHING_GIN_TRIG_STRING									"Hold ^3[{+activate}]^7 for Glitching Gin [Cost: &&1]\nTaking Damage While Injured Warps You a Short Distance\nReceieve Teleport Grenades"

#define GLITCHING_GIN_PERK											"specialty_overcharge"
#define GLITCHING_GIN_USE_SECONDARY_PERKS							0
#define GLITCHING_GIN_SECONDARY_PERKS								array ("")

#define GLITCHING_GIN_CONTACT_EXPLOSION_COUNT						0	//X < Required number of grenades per explosion
#define GLITCHING_GIN_CONTACT_MOVE_DIST								100
#define GLITCHING_GIN_GRENADE_TRIGGER_TIME							1
#define GLITCHING_GIN_GRENADE_REGEN_TIME							60	//Time to regenerate an additional Glitchin Gin grenade

#define GLITCHING_GIN_TACTICAL_OR_LETHAL							0	//0 = Tactical, 1 = Lethal

#define GLITCHING_GIN_PLAY_SOUNDS									1	//Plays sounds not related to throwing / using glitching grenades


// ======================================================================================================
// I.C.U.
// ======================================================================================================
#define ICU_COST													2500
#define ICU_RADIANT_MACHINE_NAME									"vending_icu"	
#define ICU_ALIAS													"icu"
#define ICU_SCRIPT_STRING											"icu_perk"
#define ICU_JINGLE													"icu_jingle"
#define ICU_STING													"icu_sting"
#define ICU_CLIENTFIELD												"hudItems.perks.icu"

#define ICU_BOTTLE_WEAPON											"icu_perk_bottle_wpn"
#define ICU_MACHINE_ACTIVE_MODEL									"icu_model_on"
#define ICU_MACHINE_DISABLED_MODEL									"icu_model_off"
#define ICU_MACHINE_LIGHT_FX										"west/perks/logical_icu_light"
#define ICU_MODEL_BUCKET											"icu_model_bucket"	

#define ICU_COST_STRING												"2500"
#define ICU_TRIG_STRING												"Hold ^3[{+activate}]^7 for I.C.U. [Cost: &&1]\nConstant Health Regen, Speed Boost on Low Health, Invincible While Performing Actions"

#define ICU_PERK													"specialty_immunecounteruav"
#define ICU_USE_SECONDARY_PERKS										0
#define ICU_SECONDARY_PERKS											array ("")

//Health Regen
#define ICU_HEALTH_REGEN_AMOUNT										5
#define ICU_HEALTH_REGEN_CYCLE_TIME									.3

//Speed Boost
#define ICU_HEALTH_THRESHOLD										self.maxhealth / 2
#define ICU_SPEED_BOOST												1.5


// ======================================================================================================
// Madgaz Moonshine
// ======================================================================================================
#define MADGAZ_MOONSHINE_COST										3000
#define MADGAZ_MOONSHINE_RADIANT_MACHINE_NAME						"vending_madgaz_moonshine"	
#define MADGAZ_MOONSHINE_ALIAS										"madgaz_moonshine"
#define MADGAZ_MOONSHINE_SCRIPT_STRING								"madgaz_moonshine_perk"
#define MADGAZ_MOONSHINE_JINGLE										"madgaz_moonshine_jingle"
#define MADGAZ_MOONSHINE_STING										"madgaz_moonshine_sting"
#define MADGAZ_MOONSHINE_CLIENTFIELD								"hudItems.perks.madgaz_moonshine"

#define MADGAZ_MOONSHINE_BOTTLE_WEAPON								"madgaz_moonshine_perk_bottle_wpn"
#define MADGAZ_MOONSHINE_MACHINE_ACTIVE_MODEL						"madgaz_moonshine_model_on"
#define MADGAZ_MOONSHINE_MACHINE_DISABLED_MODEL						"madgaz_moonshine_model"
#define MADGAZ_MOONSHINE_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_doubletap_light"
#define MADGAZ_MOONSHINE_MODEL_BUCKET								"madgaz_moonshine_model_bucket"	

#define MADGAZ_MOONSHINE_COST_STRING								"3000"
#define MADGAZ_MOONSHINE_TRIG_STRING								"Hold ^3[{+activate}]^7 for Madgaz Moonshine [Cost: &&1]\nFire Incendiary Bullets\nCreate an Explosion at the End of Your Slide, Limit of 25 Explosions Per Round"

#define MADGAZ_MOONSHINE_PERK										"specialty_flakjacket"
#define MADGAZ_MOONSHINE_USE_SECONDARY_PERKS						0
#define MADGAZ_MOONSHINE_SECONDARY_PERKS							array ("")

#define MADGAZ_MOONSHINE_EXPLOSION_FX								"west/perks/madgaz_moonshine_explode"
#define MADGAZ_MOONSHINE_EXPLOSION_SOUND							"madgaz_moonshine_explode"

#define MADGAZ_MOONSHINE_FIRE_CHANCE								12 //Chance to set enemy on fire
#define MADGAZ_MOONSHINE_RANGE										128
#define MADGAZ_MOONSHINE_MAX_EXPLOSIONS								25


// ======================================================================================================
// Magnet Mule
// ======================================================================================================
#define MAGNET_COST													2000
#define MAGNET_RADIANT_MACHINE_NAME									"vending_magnet"	
#define MAGNET_ALIAS												"magnet"
#define MAGNET_SCRIPT_STRING										"magnet_perk"
#define MAGNET_JINGLE												"magnet_mule_jingle"
#define MAGNET_STING												"magnet_mule_sting"
#define MAGNET_CLIENTFIELD											"hudItems.perks.magnet"

#define MAGNET_BOTTLE_WEAPON										"magnet_mule_perk_bottle_wpn"
#define MAGNET_MACHINE_ACTIVE_MODEL									"magnet_mule_model"
#define MAGNET_MACHINE_DISABLED_MODEL								"magnet_mule_model_off"
#define MAGNET_MACHINE_LIGHT_FX										"west/perks/harry_fx_perk_daiquiri_light"
#define MAGNET_MODEL_BUCKET											"magnet_mule_model_bucket"

#define MAGNET_MACHINE_SCRIPTBUNDLE									"magnet_mule_machine_anims_fml"
#define MAGNET_MACHINE_ANIM_OFF										"magnet_mule_anim_power_init_off"
#define MAGNET_MACHINE_ANIM_INIT									"magnet_mule_anim_power_init"
#define MAGNET_MACHINE_ANIM_LOOP									"magnet_mule_anim_power_loop"
#define MAGNET_MACHINE_ANIMTREE										"magnet_mule"

#define MAGNET_COST_STRING											"2000"
#define MAGNET_TRIG_STRING											"Hold ^3[{+activate}]^7 for Magnet Mule [Cost: &&1]\nAttract Nearby Powerups"

#define MAGNET_PERK													"specialty_loudenemies"
#define MAGNET_USE_SECONDARY_PERKS									0
#define MAGNET_SECONDARY_PERKS										array ("")

#define MAGNET_RANGE												720	//How far should Magnet Mule be able to attract powerups?
#define MAGNET_PULL_SPEED_FAR										10	//Time it takes to travel to you from max distance
#define MAGNET_STOP_DISTANCE										128 //Distance away from player that powerups don't come closer

//Choose which powerups you want Magnet Mule to grab - 1 = Yes, 0 = No
#define MAGNET_GRAB_NUKE											1
#define MAGNET_GRAB_DOUBLE											1
#define MAGNET_GRAB_INSTA											1
#define MAGNET_GRAB_CARPENTER										1
#define MAGNET_GRAB_MAX												1
#define MAGNET_GRAB_DEATHMACHINE									1
#define MAGNET_GRAB_FIRESALE										1
#define MAGNET_GRAB_FREE_PERK										1

/*
-----To add a custom powerup to the Exclusion List-----
1. 	Change the below "define" to something memorable
2. 	Open "_community_perk_collection.gsc"
3. 	Find 
		if (MAGNET_GRAB_CUSTOM_POWERUP != 1)
		{
			a_exclude_array[i] = "custom_powerup";
			i++;
		}
3. 	Change "MAGNET_GRAB_CUSTOM_POWERUP" to what you changed it to before
	Change "custom_powerup" to the name of your powerup
	
	Copy and paste as many as you need
*/
#define MAGNET_GRAB_CUSTOM_POWERUP									1


// ======================================================================================================
// Masochist Malecon
// ======================================================================================================
#define MASOCHIST_COST												2000
#define MASOCHIST_RADIANT_MACHINE_NAME								"vending_masochist"	
#define MASOCHIST_ALIAS												"masochist"
#define MASOCHIST_SCRIPT_STRING										"masochist_perk"
#define MASOCHIST_JINGLE											"masochist_jingle"
#define MASOCHIST_STING												"masochist_sting"
#define MASOCHIST_CLIENTFIELD										"hudItems.perks.masochist"

#define MASOCHIST_BOTTLE_WEAPON										"masochist_malecon_perk_bottle_wpn"
#define MASOCHIST_MACHINE_ACTIVE_MODEL								"masochist_malecon_model"
#define MASOCHIST_MACHINE_DISABLED_MODEL							"masochist_malecon_model"
#define MASOCHIST_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_juggernaut_light"
#define MASOCHIST_MODEL_BUCKET										"masochist_malecon_model_bucket"

#define MASOCHIST_COST_STRING										"2000"
#define MASOCHIST_TRIG_STRING										"Hold ^3[{+activate}]^7 for Masochist's Malecon [Cost: &&1]\nTaking Damage Increases Movement Speed"

#define MASOCHIST_PERK												"specialty_nottargetedbyairsupport"
#define MASOCHIST_USE_SECONDARY_PERKS								0
#define MASOCHIST_SECONDARY_PERKS									array ("")

//Will divide by 100 to get percent boost after this
#define MASOCHIST_HEALTH_THRESHOLD									self.maxhealth
#define MASOCHIST_SPEED_BUFF_FORMULA								(self.maxhealth - self.health) / 2


// ======================================================================================================
// Medusa's Mauresque
// ======================================================================================================
#define MEDUSAS_MAURESQUE_COST										5000
#define MEDUSAS_MAURESQUE_RADIANT_MACHINE_NAME						"vending_medusas_mauresque"	
#define MEDUSAS_MAURESQUE_ALIAS										"medusas_mauresque"
#define MEDUSAS_MAURESQUE_SCRIPT_STRING								"medusas_mauresque_perk"
#define MEDUSAS_MAURESQUE_JINGLE									"medusas_mauresque_jingle"
#define MEDUSAS_MAURESQUE_STING										"medusas_mauresque_sting"
#define MEDUSAS_MAURESQUE_CLIENTFIELD								"hudItems.perks.medusas_mauresque"

#define MEDUSAS_MAURESQUE_BOTTLE_WEAPON								"medusas_mauresque_perk_bottle_wpn"
#define MEDUSAS_MAURESQUE_MACHINE_ACTIVE_MODEL						"medusas_mauresque_model"
#define MEDUSAS_MAURESQUE_MACHINE_DISABLED_MODEL					"medusas_mauresque_model"
#define MEDUSAS_MAURESQUE_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_doubletap_light"
#define MEDUSAS_MAURESQUE_MODEL_BUCKET								"medusas_mauresque_model_bucket"

#define MEDUSAS_MAURESQUE_COST_STRING								"5000"
#define MEDUSAS_MAURESQUE_TRIG_STRING								"Hold ^3[{+activate}]^7 for Medusa's Mauresque [Cost: &&1]\nObserved Enemies Slow Down and Take Damage Over Time"

#define MEDUSAS_MAURESQUE_PERK										"specialty_showscorestreakicons"
#define MEDUSAS_MAURESQUE_USE_SECONDARY_PERKS						0
#define MEDUSAS_MAURESQUE_SECONDARY_PERKS							array ("")

																	/*
																	Please don't change the below settings.
																	I'm working on a better way to handle
																	custom values.
																	*/
#define MEDUSAS_MAURESQUE_CYCLE_TIME								.5
#define MEDUSAS_MAURESQUE_DAMAGE_INCREASE							.001 //Percent to increase damage per cycle
#define MEDUSAS_MAURESQUE_SLOWDOWN_INCREASE							.02 //Percent to increase slowdown per cycle


// ======================================================================================================
// Muscle Milk
// ======================================================================================================
#define MUSCLE_MILK_COST											3000
#define MUSCLE_MILK_RADIANT_MACHINE_NAME							"vending_muscle_milk"	
#define MUSCLE_MILK_ALIAS											"muscle_milk"
#define MUSCLE_MILK_SCRIPT_STRING									"muscle_milk_perk"
#define MUSCLE_MILK_JINGLE											"muscle_milk_jingle"
#define MUSCLE_MILK_STING											"muscle_milk_sting"
#define MUSCLE_MILK_CLIENTFIELD										"hudItems.perks.muscle_milk"

#define MUSCLE_MILK_BOTTLE_WEAPON									"muscle_milk_perk_bottle_wpn"
#define MUSCLE_MILK_MACHINE_ACTIVE_MODEL							"muscle_milk_model_on"
#define MUSCLE_MILK_MACHINE_DISABLED_MODEL							"muscle_milk_model_off"
#define MUSCLE_MILK_MACHINE_LIGHT_FX								"west/perks/logical_muscle_milk_light"		
#define MUSCLE_MILK_MODEL_BUCKET									"muscle_milk_model_bucket"

#define MUSCLE_MILK_COST_STRING										"3000"
#define MUSCLE_MILK_TRIG_STRING										"Hold ^3[{+activate}]^7 for Muscle Milk [Cost: &&1]\nMelee to Send a Shock of Electricity that Spreads to Nearby Zombies"

#define MUSCLE_MILK_ICON											"muscle_milk_perk_icon_hud"
#define MUSCLE_MILK_PERK											"specialty_fastmantle"
#define MUSCLE_MILK_USE_SECONDARY_PERKS								0
#define MUSCLE_MILK_SECONDARY_PERKS									array ("")

#define MUSCLE_MILK_SHOCK_FX_FILE									"west/perks/3arc_fx_tesla_shock_eyes_zmb"
#define MUSCLE_MILK_SHOCK_FX_NAME									"muscle_milk_tesla_shock_eyes"

#define MUSCLE_MILK_SOUND_READY										"muscle_milk_ready"

#define MUSCLE_MILK_ARC_TRAVEL_TIME									.08
#define MUSCLE_MILK_COOLDOWN										15
#define MUSCLE_MILK_HEAD_GIB_CHANCE									75
#define MUSCLE_MILK_MAX_ARCS										4
#define MUSCLE_MILK_MAX_KILLS										8
#define MUSCLE_MILK_MIN_FX_DISTANCE									128
#define MUSCLE_MILK_MIN_KILLS_FOR_POWERUP							8
#define MUSCLE_MILK_NETWORK_DEATH_CHOKE								4
#define MUSCLE_MILK_RADIUS_DECAY									18
#define MUSCLE_MILK_RADIUS_START									250


// ======================================================================================================
// PhD Flopper
// ======================================================================================================
#define PHD_FLOPPER_COST											2000
#define PHD_FLOPPER_RADIANT_MACHINE_NAME							"vending_phd_flopper"	
#define PHD_FLOPPER_ALIAS											"phd_flopper"
#define PHD_FLOPPER_SCRIPT_STRING									"phd_flopper_perk"
#define PHD_FLOPPER_JINGLE											"phd_flopper_jingle"
#define PHD_FLOPPER_STING											"phd_flopper_sting"
#define PHD_FLOPPER_CLIENTFIELD										"hudItems.perks.phd_flopper"

#define PHD_FLOPPER_BOTTLE_WEAPON									"phd_flopper_perk_bottle_wpn"
#define PHD_FLOPPER_MACHINE_ACTIVE_MODEL							"phd_flopper_model_on"
#define PHD_FLOPPER_MACHINE_DISABLED_MODEL							"phd_flopper_model"
#define PHD_FLOPPER_MACHINE_LIGHT_FX								"west/perks/mikey_ray_phd_flopper_light"
#define PHD_FLOPPER_MODEL_BUCKET									"phd_flopper_model_bucket"

#define PHD_FLOPPER_FX_EXPLOSION									"west/perks/3arc_fx_exp_grenade_default"

#define PHD_FLOPPER_COST_STRING										"2000"
#define PHD_FLOPPER_TRIG_STRING										"Hold ^3[{+activate}]^7 for PhD Flopper [Cost: &&1]\nImmune to Self-Inflicted Explosive and Fall Damage\nFalling From Great Heights Creates an Explosion\nLethal Grenades Split on Impact"

#define PHD_FLOPPER_PERK											"specialty_phdflopper"
#define PHD_FLOPPER_USE_SECONDARY_PERKS								0
#define PHD_FLOPPER_SECONDARY_PERKS									array ("")

#define PHD_FLOPPER_FALL_DIST										96
#define PHD_FLOPPER_FALL_RANGE										300
#define PHD_FLOPPER_FALL_MAX_DAMAGE									5000
#define PHD_FLOPPER_FALL_MIN_DAMAGE									1000
#define PHD_FLOPPER_GRENADE_FUSE_TIME								2
#define PHD_FLOPPER_GRENADE_SPLIT_MAX								8
#define PHD_FLOPPER_GRENADE_SPLIT_MIN								4
#define PHD_FLOPPER_GRENADE_SPLIT_DELAY								2
#define PHD_FLOPPER_GRENADE_SPLIT_X									2	//RandomInt between + & - of this value applied to this axis' vector
#define PHD_FLOPPER_GRENADE_SPLIT_Y									2	//RandomInt between + & - of this value applied to this axis' vector
#define PHD_FLOPPER_GRENADE_SPLIT_Z									2	//RandomInt between + & - of this value applied to this axis' vector


// ======================================================================================================
// PhD Slider
// ======================================================================================================
#define PHD_SLIDER_COST												4000
#define PHD_SLIDER_RADIANT_MACHINE_NAME								"vending_phd_slider"	
#define PHD_SLIDER_ALIAS											"phd_slider"
#define PHD_SLIDER_SCRIPT_STRING									"phd_slider_perk"
#define PHD_SLIDER_JINGLE											"phd_flopper_jingle"
#define PHD_SLIDER_STING											"phd_flopper_sting"
#define PHD_SLIDER_CLIENTFIELD										"hudItems.perks.phd_slider"

#define PHD_SLIDER_BOTTLE_WEAPON									"phd_slider_perk_bottle_wpn"
#define PHD_SLIDER_MACHINE_ACTIVE_MODEL								"phd_slider_model"
#define PHD_SLIDER_MACHINE_DISABLED_MODEL							"phd_slider_model"
#define PHD_SLIDER_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_stamin_up_light"
#define PHD_SLIDER_MODEL_BUCKET										"phd_slider_model_bucket"

#define PHD_SLIDER_FX_EXPLOSION										"west/perks/3arc_aat_blast_furnace_zmb"
#define PHD_SLIDER_FX_FIRE											"west/perks/3arc_bgb_burned_out_fire_torso_zmb"

#define PHD_SLIDER_COST_STRING										"4000"
#define PHD_SLIDER_TRIG_STRING										"Hold ^3[{+activate}]^7 for PhD Slider [Cost: &&1]\nImmune to Self-Inflicted Explosive and Fall Damage\nCreate Explosions by Sliding into Zombies, Slide to Recharge"

#define PHD_SLIDER_ICON												"phd_slider_perk_icon_hud"
#define PHD_SLIDER_PERK												"specialty_jetnoradar"
#define PHD_SLIDER_USE_SECONDARY_PERKS								0
#define PHD_SLIDER_SECONDARY_PERKS									array ("")

#define PHD_SLIDER_GAIN_PER_TICK									1.5
#define PHD_SLIDER_MAX_POWER										100
#define PHD_SLIDER_RANGE_MIN										50
#define PHD_SLIDER_RANGE_MAX										350
#define PHD_SLIDER_SLIDE_BOOST										400


// ======================================================================================================
// Pickpocket Paloma
// ======================================================================================================
#define PICKPOCKET_PALOMA_COST										2500
#define PICKPOCKET_PALOMA_RADIANT_MACHINE_NAME						"vending_pickpocket_paloma"	
#define PICKPOCKET_PALOMA_ALIAS										"pickpocket_paloma"
#define PICKPOCKET_PALOMA_SCRIPT_STRING								"pickpocket_paloma_perk"
#define PICKPOCKET_PALOMA_JINGLE									"pickpocket_paloma_jingle"
#define PICKPOCKET_PALOMA_STING										"pickpocket_paloma_sting"
#define PICKPOCKET_PALOMA_CLIENTFIELD								"hudItems.perks.pickpocket_paloma"

#define PICKPOCKET_PALOMA_BOTTLE_WEAPON								"pickpocket_paloma_perk_bottle_wpn"
#define PICKPOCKET_PALOMA_MACHINE_ACTIVE_MODEL						"pickpocket_paloma_model"
#define PICKPOCKET_PALOMA_MACHINE_DISABLED_MODEL					"pickpocket_paloma_model"
#define PICKPOCKET_PALOMA_MACHINE_LIGHT_FX							"west/perks/betiroval_fx_perk_blazephase_light"
#define PICKPOCKET_PALOMA_MODEL_BUCKET								"pickpocket_paloma_model_bucket"

#define PICKPOCKET_PALOMA_COST_STRING								"2500"
#define PICKPOCKET_PALOMA_TRIG_STRING								"Hold ^3[{+activate}]^7 for Pickpocket Paloma [Cost: &&1]\nSprint for Longer, Pickpocket Meleeing Zombies For Ammo, Points, and Powerups!"

#define PICKPOCKET_PALOMA_PERK										"specialty_longersprint"
#define PICKPOCKET_PALOMA_USE_SECONDARY_PERKS						0
#define PICKPOCKET_PALOMA_SECONDARY_PERKS							array ("")

#define PICKPOCKET_PICKUP_SOUND										"pickpocket_paloma_hit"

//Determines reward by picking a number between 1 and the sum of the below. Can be any number above 1.
#define PICKPOCKET_CHOOSE_AMMO_RANGE								35
#define PICKPOCKET_CHOOSE_POINTS_RANGE								60
#define PICKPOCKET_CHOOSE_POWERUPS_RANGE							5

//Ammo given to Player per clip category, reference below for sizes
#define PICKPOCKET_AMMO_GIVE_LOW									1
#define PICKPOCKET_AMMO_GIVE_MID									2
#define PICKPOCKET_AMMO_GIVE_HIGH									4
#define PICKPOCKET_AMMO_GIVE_MULTIPLIER								1

//Gives additional ammo based on clip size. Check whether size is below LOW, between LOW and HIGH, and above HIGH
#define PICKPOCKET_AMMO_CLIP_LOW									10
#define PICKPOCKET_AMMO_CLIP_HIGH									40

//Points to give Player. Best to have ranges divisible by 10
#define PICKPOCKET_POINTS_RANGE_LOW									10
#define PICKPOCKET_POINTS_RANGE_HIGH								100
#define PICKPOCKET_POINTS_GIVE_MULTIPLIER							1

//Gives Powerup to Player
#define PICKPOCKET_POWERUP_RESTRICT									0 //Only drops powerups from the list below
#define PICKPOCKET_POWERUP_RESTRICT_LIST							array ("carpenter", "double_points", "fire_sale", "full_ammo", "insta_kill", "minigun", "nuke", "free_perk")
#define PICKPOCKET_POWERUP_GIVE_MULTIPLIER							1


// ======================================================================================================
// Power Aid Punch
// ======================================================================================================
#define POWER_AID_PUNCH_COST										3000
#define POWER_AID_PUNCH_RADIANT_MACHINE_NAME						"vending_power_aid_punch"	
#define POWER_AID_PUNCH_ALIAS										"power_aid_punch"
#define POWER_AID_PUNCH_SCRIPT_STRING								"power_aid_punch_perk"
#define POWER_AID_PUNCH_JINGLE										"power_aid_punch_jingle"
#define POWER_AID_PUNCH_STING										"power_aid_punch_sting"
#define POWER_AID_PUNCH_CLIENTFIELD									"hudItems.perks.power_aid_punch"

#define POWER_AID_PUNCH_BOTTLE_WEAPON								"power_aid_punch_perk_bottle_wpn"
#define POWER_AID_PUNCH_MACHINE_ACTIVE_MODEL						"power_aid_punch_model"
#define POWER_AID_PUNCH_MACHINE_DISABLED_MODEL						"power_aid_punch_model"
#define POWER_AID_PUNCH_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_quick_revive_light"
#define POWER_AID_PUNCH_MODEL_BUCKET								"power_aid_punch_model_bucket"

#define POWER_AID_PUNCH_COST_STRING									"3000"
#define POWER_AID_PUNCH_TRIG_STRING									"Hold ^3[{+activate}]^7 for Power Aid Punch [Cost: &&1]\nBullets and Explosives Deal Increased Damage\nLethal Grenades Split on Impact"

#define POWER_AID_PUNCH_PERK										"specialty_twogrenades"
#define POWER_AID_PUNCH_USE_SECONDARY_PERKS							0
#define POWER_AID_PUNCH_SECONDARY_PERKS								array ("")

#define POWER_AID_PUNCH_DAMAGE_BULLET								1.3  //damage multiplier for bullet weapons
#define POWER_AID_PUNCH_DAMAGE_EXPLOSIVE							1.5  //damage multiplier for explosive weapons
#define POWER_AID_PUNCH_GRENADE_FUSE_TIME							2
#define POWER_AID_PUNCH_GRENADE_SPLIT_COUNT							3
#define POWER_AID_PUNCH_GRENADE_SPLIT_DELAY							2
#define POWER_AID_PUNCH_GRENADE_SPLIT_X								2	//RandomInt between + & - of this value applied to this axis' vector
#define POWER_AID_PUNCH_GRENADE_SPLIT_Y								2	//RandomInt between + & - of this value applied to this axis' vector
#define POWER_AID_PUNCH_GRENADE_SPLIT_Z								2	//RandomInt between + & - of this value applied to this axis' vector

#define POWER_AID_PUNCH_ALLOW_HIT_LOC_FX							1
#define POWER_AID_PUNCH_HIT_LOC_FX									"west/perks/logistical_reaper_power_aid_bullet_impact"
#define POWER_AID_PUNCH_HIT_LOC_SOUND								"power_aid_punch_zap"


// ======================================================================================================
// Prickling Prosecco
// ======================================================================================================
#define PRICKLING_PROSECCO_COST										2000
#define PRICKLING_PROSECCO_RADIANT_MACHINE_NAME						"vending_prickling_prosecco"	
#define PRICKLING_PROSECCO_ALIAS									"prickling_prosecco"
#define PRICKLING_PROSECCO_SCRIPT_STRING							"prickling_prosecco_perk"
#define PRICKLING_PROSECCO_JINGLE									"prickling_prosecco_jingle"
#define PRICKLING_PROSECCO_STING									"prickling_prosecco_sting"
#define PRICKLING_PROSECCO_CLIENTFIELD								"hudItems.perks.prickling_prosecco"

#define PRICKLING_PROSECCO_BOTTLE_WEAPON							"prickling_prosecco_perk_bottle_wpn"
#define PRICKLING_PROSECCO_MACHINE_ACTIVE_MODEL						"prickling_prosecco_model"
#define PRICKLING_PROSECCO_MACHINE_DISABLED_MODEL					"prickling_prosecco_model"
#define PRICKLING_PROSECCO_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_widows_wine_light"
#define PRICKLING_PROSECCO_MODEL_BUCKET								"prickling_prosecco_model_bucket"

#define PRICKLING_PROSECCO_COST_STRING								"2000"
#define PRICKLING_PROSECCO_TRIG_STRING								"Hold ^3[{+activate}]^7 for Prickling Prosecco [Cost: &&1]\nDeal Thorns Damage to Meleeing Zombies"

#define PRICKLING_PROSECCO_PERK										"specialty_teflon"
#define PRICKLING_PROSECCO_USE_SECONDARY_PERKS						0
#define PRICKLING_PROSECCO_SECONDARY_PERKS							array ("")

#define PRICKLING_PROSECCO_DAMAGE_PERCENT							60  //1-100 percent of attacker.maxhealth to deal in return
#define PRICKLING_PROSECCO_DAMAGE_SHIELD							21  //1-100 percent of attacker.maxhealth to deal in return when holding shield


// ======================================================================================================
// Reaper's Roulette
// ======================================================================================================
#define ROULETTE_COST												2000
#define ROULETTE_RADIANT_MACHINE_NAME								"vending_roulette"	
#define ROULETTE_ALIAS												"roulette"
#define ROULETTE_SCRIPT_STRING										"roulette_perk"
#define ROULETTE_JINGLE												"roulette_jingle"
#define ROULETTE_STING												"roulette_sting"
#define ROULETTE_CLIENTFIELD										"hudItems.perks.roulette"

#define ROULETTE_BOTTLE_WEAPON										"roulette_perk_bottle_wpn"
#define ROULETTE_MACHINE_ACTIVE_MODEL								"roulette_model"
#define ROULETTE_MACHINE_DISABLED_MODEL								"roulette_model"
#define ROULETTE_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_vulture_aid_light"
#define ROULETTE_MODEL_BUCKET										"roulette_model_bucket"

#define ROULETTE_COST_STRING										"2000"
#define ROULETTE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Reaper's Roulette [Cost: &&1]\nBullets Have a Small Chance to Instantly Kill Any Zombie They Hit"

#define ROULETTE_PERK												"specialty_sengrenjammer"
#define ROULETTE_USE_SECONDARY_PERKS								0
#define ROULETTE_SECONDARY_PERKS									array ("")

#define ROULETTE_INSTA_PERCENT										5 	//1-100 Percent chance for each bullet impact to insta kill


// ======================================================================================================
// Rebate Rosé
// ======================================================================================================
#define REBATE_ROSE_COST											2000
#define REBATE_ROSE_RADIANT_MACHINE_NAME							"vending_rebate_rose"	
#define REBATE_ROSE_ALIAS											"rebate_rose"
#define REBATE_ROSE_SCRIPT_STRING									"rebate_rose_perk"
#define REBATE_ROSE_JINGLE											"rebate_rose_jingle"
#define REBATE_ROSE_STING											"rebate_rose_sting"
#define REBATE_ROSE_CLIENTFIELD										"hudItems.perks.rebate_rose"

#define REBATE_ROSE_BOTTLE_WEAPON									"rebate_rose_perk_bottle_wpn"
#define REBATE_ROSE_MACHINE_ACTIVE_MODEL							"rebate_rose_model"
#define REBATE_ROSE_MACHINE_DISABLED_MODEL							"rebate_rose_model"
#define REBATE_ROSE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_vulture_aid_light"
#define REBATE_ROSE_MODEL_BUCKET									"rebate_rose_model_bucket"

#define REBATE_ROSE_COST_STRING										"2000"
#define REBATE_ROSE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Rebate Rosé [Cost: &&1]\nReceive Rebates on All Purchases and Bonus Points for Kills"

#define REBATE_ROSE_PERK											"specialty_grenadepulldeath"
#define REBATE_ROSE_USE_SECONDARY_PERKS								0
#define REBATE_ROSE_SECONDARY_PERKS									array ("")

#define REBATE_ROSE_PERCENT_TO_REBATE								.20	//Percent to rebate each purchase
#define REBATE_ROSE_BONUS_POINTS									30 //Points to give per kill


// ======================================================================================================
// Salvage Shake
// ======================================================================================================
#define SALVAGE_SHAKE_COST											4000
#define SALVAGE_SHAKE_RADIANT_MACHINE_NAME							"vending_salvage_shake"	
#define SALVAGE_SHAKE_ALIAS											"salvage_shake"
#define SALVAGE_SHAKE_SCRIPT_STRING									"salvage_shake_perk"
#define SALVAGE_SHAKE_JINGLE										"salvage_shake_jingle"
#define SALVAGE_SHAKE_STING											"salvage_shake_sting"
#define SALVAGE_SHAKE_CLIENTFIELD									"hudItems.perks.salvage_shake"

#define SALVAGE_SHAKE_BOTTLE_WEAPON									"salvage_shake_perk_bottle_wpn"
#define SALVAGE_SHAKE_MACHINE_ACTIVE_MODEL							"salvage_shake_model"
#define SALVAGE_SHAKE_MACHINE_DISABLED_MODEL						"salvage_shake_model"
#define SALVAGE_SHAKE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_tombstone_light"
#define SALVAGE_SHAKE_MODEL_BUCKET									"salvage_shake_model_bucket"

#define SALVAGE_SHAKE_COST_STRING									"4000"
#define SALVAGE_SHAKE_TRIG_STRING									"Hold ^3[{+activate}]^7 for Salvage Shake [Cost: &&1]\nStowed Weapons Regenerate Ammo Over Time"

#define SALVAGE_SHAKE_PERK											"specialty_nottargetedbyaitank"
#define SALVAGE_SHAKE_USE_SECONDARY_PERKS							0
#define SALVAGE_SHAKE_SECONDARY_PERKS								array ("")

#define SALVAGE_SHAKE_INTERVAL										5	//How many seconds between cycles, resets on weapon swap
#define SALVAGE_SHAKE_PERCENT										.05	//Percent of the total ammo capacity of a weapon to give

#define SALVAGE_SHAKE_NERF_WW										1	//Reduce amount given to wonder weapons
#define SALVAGE_SHAKE_NERF_WW_PERCENT								50	//Percent to reduce ammo given to wonder weapons


// ======================================================================================================
// Samurai's Spirit
// ======================================================================================================
#define SAMURAIS_SPIRIT_COST										2000
#define SAMURAIS_SPIRIT_RADIANT_MACHINE_NAME						"vending_samurais_spirit"	
#define SAMURAIS_SPIRIT_ALIAS										"samurais_spirit"
#define SAMURAIS_SPIRIT_SCRIPT_STRING								"samurais_spirit_perk"
#define SAMURAIS_SPIRIT_JINGLE										"samurais_spirit_jingle"
#define SAMURAIS_SPIRIT_STING										"samurais_spirit_sting"
#define SAMURAIS_SPIRIT_CLIENTFIELD									"hudItems.perks.samurais_spirit"

#define SAMURAIS_SPIRIT_BOTTLE_WEAPON								"samurais_spirit_perk_bottle_wpn"
#define SAMURAIS_SPIRIT_MACHINE_ACTIVE_MODEL						"samurais_spirit_model"
#define SAMURAIS_SPIRIT_MACHINE_DISABLED_MODEL						"samurais_spirit_model"
#define SAMURAIS_SPIRIT_MACHINE_LIGHT_FX							"west/perks/harry_fx_perk_widows_wine_light"
#define SAMURAIS_SPIRIT_MODEL_BUCKET								"samurais_spirit_model_bucket"

#define SAMURAIS_SPIRIT_COST_STRING									"2000"
#define SAMURAIS_SPIRIT_TRIG_STRING									"Hold ^3[{+activate}]^7 for Samurai's Spirit [Cost: &&1]\nMove Faster, Melee Kills Increase Melee Damage"

#define SAMURAIS_SPIRIT_PERK										"specialty_movefaster"
#define SAMURAIS_SPIRIT_USE_SECONDARY_PERKS							0
#define SAMURAIS_SPIRIT_SECONDARY_PERKS								array ("")

#define SAMURAIS_SPIRIT_DAMAGE_INCREASE								1.075	//Percent damage buff after each kill
#define SAMURAIS_SPIRIT_DAMAGE_LIMIT								1.05	//Most Damage Player Can Deal in Relation to Zombie.MaxHealth


// ======================================================================================================
// Side-Steppin' Shandy
// ======================================================================================================
#define SIDE_STEP_COST												2000
#define SIDE_STEP_RADIANT_MACHINE_NAME								"vending_side_step"	
#define SIDE_STEP_ALIAS												"side_step"
#define SIDE_STEP_SCRIPT_STRING										"side_step_perk"
#define SIDE_STEP_JINGLE											"side_step_jingle"
#define SIDE_STEP_STING												"side_step_sting"
#define SIDE_STEP_CLIENTFIELD										"hudItems.perks.side_step"

#define SIDE_STEP_BOTTLE_WEAPON										"side_step_perk_bottle_wpn"
#define SIDE_STEP_MACHINE_DISABLED_MODEL							"side_step_model"
#define SIDE_STEP_MACHINE_ACTIVE_MODEL								"side_step_model"
#define SIDE_STEP_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_stamin_up_light"
#define SIDE_STEP_MODEL_BUCKET										"side_step_model_bucket"

#define SIDE_STEP_COST_STRING										"2000"
#define SIDE_STEP_TRIG_STRING										"Hold ^3[{+activate}]^7 for Side-Steppin' Shandy [Cost: &&1]\nHigh Chance to Dodge Enemy Attacks"

#define SIDE_STEP_PERK												"specialty_earnmoremomentum"
#define SIDE_STEP_USE_SECONDARY_PERKS								0
#define SIDE_STEP_SECONDARY_PERKS									array ("")

#define SIDE_STEP_DODGE_CHANCE										50 //1-100 percent chance to negate enemy attack damage
#define SIDE_STEP_DODGE_CHANCE_SHIELD								21 //1-100 percent chance to negate enemy attack damage when holding shield


// ======================================================================================================
// Slip-Away Slushee
// ======================================================================================================
#define SLIP_AWAY_COST												2500
#define SLIP_AWAY_RADIANT_MACHINE_NAME								"vending_slip_away"	
#define SLIP_AWAY_ALIAS												"slip_away"
#define SLIP_AWAY_SCRIPT_STRING										"slip_away_perk"
#define SLIP_AWAY_JINGLE											"slip_away_jingle"
#define SLIP_AWAY_STING												"slip_away_sting"
#define SLIP_AWAY_CLIENTFIELD										"hudItems.perks.slip_away"

#define SLIP_AWAY_BOTTLE_WEAPON										"slip_away_perk_bottle_wpn"
#define SLIP_AWAY_MACHINE_DISABLED_MODEL							"slip_away_model"
#define SLIP_AWAY_MACHINE_ACTIVE_MODEL								"slip_away_model"
#define SLIP_AWAY_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_stamin_up_light"
#define SLIP_AWAY_MODEL_BUCKET										"slip_away_model_bucket"

#define SLIP_AWAY_COST_STRING										"2500"
#define SLIP_AWAY_TRIG_STRING										"Hold ^3[{+activate}]^7 for Slip-Away Slushee [Cost: &&1]\nInstead of Entering Last Stand, Teleport to a Perk Machine"

#define SLIP_AWAY_PERK												"specialty_jetpack"
#define SLIP_AWAY_USE_SECONDARY_PERKS								0
#define SLIP_AWAY_SECONDARY_PERKS									array ("")

#define SLIP_AWAY_TELE_DISTANCE_FROM_PERK							96
#define SLIP_AWAY_TELE_HEIGHT										48
#define SLIP_AWAY_TELE_PREF_DIST_AWAY								960

#define SLIP_AWAY_ZOMBIE_RANGE										480

#define SLIP_AWAY_PLAY_SOUNDS										1
#define SLIP_AWAY_EXPLOSION_SOUND									
#define SLIP_AWAY_TELEPORT_IN_SOUND									"zmb_bgb_abh_teleport_in"
#define SLIP_AWAY_TELEPORT_OUT_SOUND								"zmb_bgb_abh_teleport_out"


// ======================================================================================================
// Slurpentine
// ======================================================================================================
#define SLURPENTINE_COST											4000
#define SLURPENTINE_RADIANT_MACHINE_NAME							"vending_slurpentine"	
#define SLURPENTINE_ALIAS											"slurpentine"
#define SLURPENTINE_SCRIPT_STRING									"slurpentine_perk"
#define SLURPENTINE_JINGLE											"slurpentine_jingle"
#define SLURPENTINE_STING											"slurpentine_sting"
#define SLURPENTINE_CLIENTFIELD										"hudItems.perks.slurpentine"

#define SLURPENTINE_BOTTLE_WEAPON									"slurpentine_perk_bottle_wpn"
#define SLURPENTINE_MACHINE_ACTIVE_MODEL							"slurpentine_model"
#define SLURPENTINE_MACHINE_DISABLED_MODEL							"slurpentine_model"
#define SLURPENTINE_MACHINE_LIGHT_FX								"west/perks/betiroval_fx_perk_slurpentine_light"
#define SLURPENTINE_MODEL_BUCKET									"slurpentine_model_bucket"

#define SLURPENTINE_COST_STRING										"4000"
#define SLURPENTINE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Slurpentine Energy [Cost: &&1]\nAfter Taking a Hit, Gain a Speed Boost and Poison the Attacker\nPoisoned Enemies Take Damage Over Time and Deal Less Damage\nReceive Less Damage While Sprinting"

#define SLURPENTINE_PERK											"specialty_microwaveprotection"
#define SLURPENTINE_USE_SECONDARY_PERKS								0
#define SLURPENTINE_SECONDARY_PERKS									array ("")

#define SLURPENTINE_SPRINT_DAMAGE_RESIST							.825 //Incoming Damage Multiplier When Sprinting
#define SLURPENTINE_SPRINT_BOOST_DURATION							3
#define SLURPENTINE_SPRINT_SPEED_INCREASE							.25 //This added to SetMoveSpeedScale
#define SLURPENTINE_POISON_DAMAGE_RESIST							.775 //Incoming Damage Multiplier From Poisoned AI
#define SLURPENTINE_POISON_DURATION									10
#define SLURPENTINE_POISON_TICK_CYCLE								1 //Time between each cycle
#define SLURPENTINE_POISON_TICK_DAMAGE								.05 //Percent damage a poisoned enemy will take
#define SLURPENTINE_POISON_TICK_SHIELD								.02 //Percent damage a poisoned enemy will take when holding shield

#define SLURPENTINE_FX_POISON_EYES									"west/perks/frost_iceforge_green_zombie_eyes"
#define SLURPENTINE_FX_VENOM										"west/perks/betiroval_fx_slurpentine_venom"

#define SLURPENTINE_MODEL_ANIM_BUNDLE								"slurpentine_model_auger_anim_bundle"
#define SLURPENTINE_MODEL_FLUID										"slurpentine_model_fluid"

#define SLURPENTINE_SOUND_VENOM_START								"slurpentine_venom_start"
#define SLURPENTINE_SOUND_VENOM_TICK								"slurpentine_venom_tick"


// ======================================================================================================
// Snail's Pace Slurpee
// ======================================================================================================
#define SNAILS_PACE_COST											3000
#define SNAILS_PACE_RADIANT_MACHINE_NAME							"vending_snails_pace"	
#define SNAILS_PACE_ALIAS											"snails_pace"
#define SNAILS_PACE_SCRIPT_STRING									"snails_pace_perk"
#define SNAILS_PACE_JINGLE											"snails_pace_jingle"
#define SNAILS_PACE_STING											"snails_pace_sting"
#define SNAILS_PACE_CLIENTFIELD										"hudItems.perks.snails_pace"

#define SNAILS_PACE_BOTTLE_WEAPON									"snails_pace_perk_bottle_wpn"
#define SNAILS_PACE_MACHINE_ACTIVE_MODEL							"snails_pace_model"
#define SNAILS_PACE_MACHINE_DISABLED_MODEL							"snails_pace_model"
#define SNAILS_PACE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_tombstone_light"
#define SNAILS_PACE_MODEL_BUCKET									"snails_pace_model_bucket"

#define SNAILS_PACE_COST_STRING										"3000"
#define SNAILS_PACE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Snail's Pace Slurpee [Cost: &&1]\nNearby Enemies Are Slowed, Enemies Return to Normal if They Get Too Close or Far"

#define SNAILS_PACE_PERK											"specialty_gpsjammer"
#define SNAILS_PACE_USE_SECONDARY_PERKS								0
#define SNAILS_PACE_SECONDARY_PERKS									array ("")

#define SNAILS_PACE_ZOMBIE_EYE_FX									"west/perks/abnormal202_snails_pace_zombie_eyes"

#define SNAILS_PACE_RANGE_MAX										110	//Max distance from center zombies will be affected
#define SNAILS_PACE_RANGE_MIN										70 //Damage multiplier for zombies affected by field

#define SNAILS_PACE_ZOMBIE_SLOWDOWN_RATE							0.62
#define SNAILS_PACE_ZOMBIE_SLOWDOWN_TIME							0.1


// ======================================================================================================
// Space Cadet Cola
// ======================================================================================================
#define SPACE_CADET_COST											3500
#define SPACE_CADET_RADIANT_MACHINE_NAME							"vending_space_cadet"
#define SPACE_CADET_ALIAS											"space_cadet"
#define SPACE_CADET_SCRIPT_STRING									"space_cadet_perk"
#define SPACE_CADET_JINGLE											"space_cadet_jingle"
#define SPACE_CADET_STING											"space_cadet_sting"
#define SPACE_CADET_CLIENTFIELD										"hudItems.perks.space_cadet"

#define SPACE_CADET_BOTTLE_WEAPON									"space_cadet_cola_perk_bottle_wpn"
#define SPACE_CADET_MACHINE_ACTIVE_MODEL							"space_cadet_cola_model"
#define SPACE_CADET_MACHINE_DISABLED_MODEL							"space_cadet_cola_model_off"
#define SPACE_CADET_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_stamin_up_light"
#define SPACE_CADET_MODEL_BUCKET									"space_cadet_cola_model_bucket"

#define SPACE_CADET_PLAY_SOUNDS										1
#define SPACE_CADET_SOUND_ACTIVATE									"space_cadet_effect_trigger"
#define SPACE_CADET_SOUND_COOLDOWN_START							"space_cadet_cooldown_start"
#define SPACE_CADET_SOUND_COOLDOWN_OVER								"space_cadet_cooldown_over"

#define SPACE_CADET_COST_STRING										"3500"
#define SPACE_CADET_TRIG_STRING										"Hold ^3[{+activate}]^7 for Space Cadet Cola [Cost: &&1]\nAfter Taking Enough Damage, Become Invisible to Zombies For a Short Time\nWait and Kill Zombies to Recharge"

#define SPACE_CADET_ICON											"space_cadet_cola_perk_icon_hud"
#define SPACE_CADET_PERK											"specialty_quieter"
#define SPACE_CADET_USE_SECONDARY_PERKS								0
#define SPACE_CADET_SECONDARY_PERKS									array ("")

#define SPACE_CADET_EFFECT_DURATION									9 	// Duration of invisible effect
#define SPACE_CADET_COOLDOWN										180	// Cooldown Part 1 - Cooldown duration
#define SPACE_CADET_KILLS_NEEDED									100	// Cooldown Part 2 - Number of kills necessary to recharge effect

#define SPACE_CADET_HIT_TIME										2 	// Maximum time between hits that the perk's effect can be triggered
#define SPACE_CADET_NO_HIT_TRIG										1 	// Don't trigger the effect if there are less than this amount of zombies

#define SPACE_CADET_NO_JUGG_HITS									2 	// If the player does not have Jug/Verruckt Jug, require this amount of hits to trigger perk effect
#define SPACE_CADET_JUGG_HITS										2 	// If the player has Jug/Verruckt Jug, require this amount of hits to trigger perk effect


// ======================================================================================================
// Spectral Shake
// ======================================================================================================
#define SPECTRAL_SHAKE_COST											1500
#define SPECTRAL_SHAKE_RADIANT_MACHINE_NAME							"vending_spectral_shake"
#define SPECTRAL_SHAKE_ALIAS										"spectral_shake"
#define SPECTRAL_SHAKE_SCRIPT_STRING								"spectral_shake_perk"
#define SPECTRAL_SHAKE_JINGLE										"spectral_shake_jingle"
#define SPECTRAL_SHAKE_STING										"spectral_shake_sting"
#define SPECTRAL_SHAKE_CLIENTFIELD									"hudItems.perks.spectral_shake"

#define SPECTRAL_SHAKE_BOTTLE_WEAPON								"spectral_shake_perk_bottle_wpn"
#define SPECTRAL_SHAKE_MACHINE_ACTIVE_MODEL							"spectral_shake_model"
#define SPECTRAL_SHAKE_MACHINE_DISABLED_MODEL						"spectral_shake_model"
#define SPECTRAL_SHAKE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_quick_revive_light"
#define SPECTRAL_SHAKE_MODEL_BUCKET									"spectral_shake_model_bucket"

#define SPECTRAL_SHAKE_COST_STRING									"1500"
#define SPECTRAL_SHAKE_TRIG_STRING									"Hold ^3[{+activate}]^7 for Spectral Shake [Cost: &&1]\nHold Prone to Hide in Plain Sight, Stay Crouched or Prone to Stay Hidden\nMove Faster While Crouched and Prone"

#define SPECTRAL_SHAKE_ICON											"spectral_shake_perk_icon_hud"
#define SPECTRAL_SHAKE_PERK											"specialty_holdbreath"
#define SPECTRAL_SHAKE_USE_SECONDARY_PERKS							0
#define SPECTRAL_SHAKE_SECONDARY_PERKS								array ("")

#define SPECTRAL_SHAKE_PLAY_SOUNDS									1
#define SPECTRAL_SHAKE_SOUND_START									"zmb_bgb_idleeyes_start"
#define SPECTRAL_SHAKE_SOUND_LOOP									"zmb_bgb_idleeyes_loop"
#define SPECTRAL_SHAKE_SOUND_END									"zmb_bgb_idleeyes_end"

#define SPECTRAL_SHAKE_ACTIVATION_TIME								2 //Time player must hold prone to activate
#define SPECTRAL_SHAKE_COOLDOWN_TIME								180 //Cooldown time
#define SPECTRAL_SHAKE_DURATION										30 //Invisibility duration

#define SPECTRAL_SHAKE_SPEED_BOOST									1


// ======================================================================================================
// Stone Cold Stronghold
// ======================================================================================================
#define STONE_COLD_COST												2500
#define STONE_COLD_RADIANT_MACHINE_NAME								"vending_stone_cold"	
#define STONE_COLD_ALIAS											"stone_cold"
#define STONE_COLD_SCRIPT_STRING									"stone_cold_perk"
#define STONE_COLD_JINGLE											"stone_cold_jingle"
#define STONE_COLD_STING											"stone_cold_sting"
#define STONE_COLD_CLIENTFIELD										"hudItems.perks.stone_cold"

#define STONE_COLD_BOTTLE_WEAPON									"stone_cold_perk_bottle_wpn"
#define STONE_COLD_MACHINE_DISABLED_MODEL							"stone_cold_model"
#define STONE_COLD_MACHINE_ACTIVE_MODEL								"stone_cold_model"
#define STONE_COLD_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_tombstone_light"
#define STONE_COLD_MODEL_BUCKET										"stone_cold_model_bucket"

#define STONE_COLD_COST_STRING										"2500"
#define STONE_COLD_TRIG_STRING										"Hold ^3[{+activate}]^7 for Stone Cold Stronghold [Cost: &&1]\nStanding Your Ground Creates a Defensive Circle Which Boosts Armor Over Time\nDamage Output Scales With Armor"

#define STONE_COLD_ICON												"stone_cold_perk_icon_hud"
#define STONE_COLD_PERK												"specialty_finalstand"
#define STONE_COLD_USE_SECONDARY_PERKS								0
#define STONE_COLD_SECONDARY_PERKS									array ("")

#define STONE_COLD_RING_FX											"west/perks/logistical_reaper_stone_cold_ring"

#define STONE_COLD_ARMOR_PER_CYCLE									5	//Armor Generated per Cycle
#define STONE_COLD_COOLDOWN											5	//Time to wait after losing all armor or leaving ring
#define STONE_COLD_CYCLE_TIME										1	//Regens Armor every this amount of time
#define STONE_COLD_MAX_ARMOR										200 //Maximum Armor a Player can have at once
#define STONE_COLD_RANGE											75	//Max Distance away from ring center before destroying ring


// ======================================================================================================
// Tactiquilla Sangria
// ======================================================================================================
#define TACTIQUILLA_COST											2000
#define TACTIQUILLA_RADIANT_MACHINE_NAME							"vending_tactiquilla"	
#define TACTIQUILLA_ALIAS											"tactiquilla"
#define TACTIQUILLA_SCRIPT_STRING									"tactiquilla_perk"
#define TACTIQUILLA_JINGLE											"tactiquilla_jingle"
#define TACTIQUILLA_STING											"tactiquilla_sting"
#define TACTIQUILLA_CLIENTFIELD										"hudItems.perks.tactiquilla"

#define TACTIQUILLA_BOTTLE_WEAPON									"tactiquilla_perk_bottle_wpn"
#define TACTIQUILLA_MACHINE_DISABLED_MODEL							"tactiquilla_model"
#define TACTIQUILLA_MACHINE_ACTIVE_MODEL							"tactiquilla_model"
#define TACTIQUILLA_MACHINE_LIGHT_FX								"west/perks/logical_tactiquilla_sangria_light"
#define TACTIQUILLA_MODEL_BUCKET									"tactiquilla_model_bucket"

#define TACTIQUILLA_COST_STRING										"2000"
#define TACTIQUILLA_TRIG_STRING										"Hold ^3[{+activate}]^7 for Tactiquilla Sangria [Cost: &&1]\nChance to Regain Fired Munitions"

#define TACTIQUILLA_PERK											"specialty_extraammo"
#define TACTIQUILLA_USE_SECONDARY_PERKS								0
#define TACTIQUILLA_SECONDARY_PERKS									array ("")

//Weapons to exclude from regaining ammo
#define TACTIQUILLA_WEAPON_EXLUSION_LIST							array ("")

#define TACTIQUILLA_REGAIN_AMMO_CHANCE								15 //Percent chance to regain ammo after firing
#define TACTIQUILLA_AMMO_TO_GIVE									1 //Amount of ammo to give after firing


// ======================================================================================================
// Time Out Tequila
// ======================================================================================================
#define TIME_OUT_COST												1500
#define TIME_OUT_RADIANT_MACHINE_NAME								"vending_time_out"	
#define TIME_OUT_ALIAS												"time_out"
#define TIME_OUT_SCRIPT_STRING										"time_out_perk"
#define TIME_OUT_JINGLE												"time_out_jingle"
#define TIME_OUT_STING												"time_out_sting"
#define TIME_OUT_CLIENTFIELD										"hudItems.perks.time_out"

#define TIME_OUT_BOTTLE_WEAPON										"time_out_perk_bottle_wpn"
#define TIME_OUT_MACHINE_DISABLED_MODEL								"time_out_model"
#define TIME_OUT_MACHINE_ACTIVE_MODEL								"time_out_model"
#define TIME_OUT_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_daiquiri_light"
#define TIME_OUT_MODEL_BUCKET										"time_out_model_bucket"

#define TIME_OUT_ACTIVE_SOUND										"time_out_activate"

#define TIME_OUT_COST_STRING										"1500"
#define TIME_OUT_TRIG_STRING										"Hold ^3[{+activate}]^7 for Time Out Tequila [Cost: &&1]\nAfter Being Revived or Reviving Another\nBecome Invisible to Zombies for a Short Time"

#define TIME_OUT_ICON												"time_out_perk_icon_hud"
#define TIME_OUT_PERK												"specialty_trackerjammer"
#define TIME_OUT_USE_SECONDARY_PERKS								0
#define TIME_OUT_SECONDARY_PERKS									array ("")

#define TIME_OUT_HIDDEN_TIME										10	//In seconds, time the player(s) hidden for after revive


// ======================================================================================================
// Timeslip
// ======================================================================================================
#define TIMESLIP_COST												1500
#define TIMESLIP_RADIANT_MACHINE_NAME								"vending_timeslip"	
#define TIMESLIP_ALIAS												"timeslip"
#define TIMESLIP_SCRIPT_STRING										"timeslip_perk"
#define TIMESLIP_JINGLE												"timeslip_jingle"
#define TIMESLIP_STING												"timeslip_sting"
#define TIMESLIP_CLIENTFIELD										"hudItems.perks.timeslip"

#define TIMESLIP_BOTTLE_WEAPON										"timeslip_perk_bottle_wpn"
#define TIMESLIP_MACHINE_ACTIVE_MODEL								"timeslip_model"
#define TIMESLIP_MACHINE_DISABLED_MODEL								"timeslip_model"
#define TIMESLIP_MACHINE_LIGHT_FX									"west/perks/betiroval_fx_perk_timeslip_light"
#define TIMESLIP_MODEL_BUCKET										"timeslip_model_bucket"

#define TIMESLIP_COST_STRING										"1500"
#define TIMESLIP_TRIG_STRING										"Hold ^3[{+activate}]^7 for Timeslip [Cost: &&1]\nUse the Mystery Box, Pack-a-Punch, and Wunderfizz Faster\nTraps Recharge Faster"

#define TIMESLIP_PERK												"specialty_anteup"
#define TIMESLIP_USE_SECONDARY_PERKS								0
#define TIMESLIP_SECONDARY_PERKS									array ("")

#define TIMESLIP_MYSTERY_BOX_CYCLE_DIVIDE							3 //Number to divide box weapon cycling by, default cycles is 40
#define TIMESLIP_PAP_WAIT											1 //Time PaP will wait before spitting gun back out
#define TIMESLIP_TRAP_RECHARGE_DIVIDE								2 //Number to divide trap recharge time by
#define TIMESLIP_WUNDERFIZZ_DIVIDE									2


// ======================================================================================================
// Tombstone Soda
// ======================================================================================================
#define TOMBSTONE_SODA_COST											2000
#define TOMBSTONE_SODA_RADIANT_MACHINE_NAME							"vending_tombstone_soda"	
#define TOMBSTONE_SODA_ALIAS										"tombstone_soda"
#define TOMBSTONE_SODA_SCRIPT_STRING								"tombstone_soda_perk"
#define TOMBSTONE_SODA_JINGLE										"tombstone_soda_jingle"
#define TOMBSTONE_SODA_STING										"tombstone_soda_sting"
#define TOMBSTONE_SODA_CLIENTFIELD									"hudItems.perks.tombstone_soda"

#define TOMBSTONE_SODA_BOTTLE_WEAPON								"tombstone_perk_bottle_wpn"
#define TOMBSTONE_SODA_MACHINE_ACTIVE_MODEL							"tombstone_model"
#define TOMBSTONE_SODA_MACHINE_DISABLED_MODEL						"tombstone_model"
#define TOMBSTONE_SODA_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_tombstone_light"
#define TOMBSTONE_SODA_MODEL_BUCKET									"tombstone_model_bucket"

#define TOMBSTONE_SODA_COST_STRING									"2000"
#define TOMBSTONE_SODA_TRIG_STRING									"Hold ^3[{+activate}]^7 for Tombstone Soda [Cost: &&1]\nDowning Will Spawn a Tombstone Powerup, Respawn and Grab it to Claim Your Loadout\nUpon Revival, Get Back All of Your Perks"

#define TOMBSTONE_SODA_PERK											"specialty_tombstone"
#define TOMBSTONE_SODA_USE_SECONDARY_PERKS							0
#define TOMBSTONE_SODA_SECONDARY_PERKS								array ("")

#define TOMBSTONE_SODA_SOUND_POWERUP_GRAB							"tombstone_soda_powerup_grab"
#define TOMBSTONE_SODA_SOUND_POWERUP_LOOP							"tombstone_soda_powerup_looper"
#define TOMBSTONE_SODA_SOUND_POWERUP_SPAWN							"tombstone_soda_powerup_spawn"

#define TOMBSTONE_SODA_POWERUP_USE_TIMEOUT							1
#define TOMBSTONE_SODA_POWERUP_TIMEOUT								60
#define TOMBSTONE_SODA_POWERUP_MODEL								"tombstone_powerup_model"
#define TOMBSTONE_SODA_POWERUP_FX									"west/perks/3arc_fx_powerup_on_green_zmb"
#define TOMBSTONE_SODA_POWERUP_GRAB									"tombstone_powerup_grab"
#define TOMBSTONE_SODA_POWERUP_GRAB_FX								"west/perks/3arc_fx_powerup_grab_green_zmb"


// ======================================================================================================
// Verruckt Juggernog
// ======================================================================================================
#define VERRUCKT_JUG_COST											3500
#define VERRUCKT_JUG_RADIANT_MACHINE_NAME							"vending_verruckt_jug"	
#define VERRUCKT_JUG_ALIAS											"verruckt_jug"
#define VERRUCKT_JUG_SCRIPT_STRING									"verruckt_jug_perk"
#define VERRUCKT_JUG_JINGLE											"verruckt_juggernog_jingle"
#define VERRUCKT_JUG_STING											"verruckt_juggernog_sting"
#define VERRUCKT_JUG_CLIENTFIELD									"hudItems.perks.verruckt_jug"

#define VERRUCKT_JUG_BOTTLE_WEAPON									"verruckt_juggernog_perk_bottle_wpn"
#define VERRUCKT_JUG_MACHINE_ACTIVE_MODEL							"verruckt_juggernog_model"
#define VERRUCKT_JUG_MACHINE_DISABLED_MODEL							"verruckt_juggernog_model"
#define VERRUCKT_JUG_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_juggernaut_light"
#define VERRUCKT_JUG_MODEL_BUCKET									"verruckt_juggernog_model_bucket"

#define VERRUCKT_JUG_COST_STRING									"3500"
#define VERRUCKT_JUG_TRIG_STRING									"Hold ^3[{+activate}]^7 for Verruckt Juggernog [Cost: &&1]\nSmall Health Increase, Constant Health Regeneration"

#define VERRUCKT_JUG_PERK											"specialty_healthregen"
#define VERRUCKT_JUG_USE_SECONDARY_PERKS							0
#define VERRUCKT_JUG_SECONDARY_PERKS								array ("")

#define VERRUCKT_PLAYER_INCREASE_HEALTH								20	//Amount of health to increase Max HP by
#define VERRUCKT_PLAYER_HEALTH_REGEN								30	//How much HP the player regens each cycle
#define VERRUCKT_PLAYER_REGEN_CYCLE_TIME							.25	//How long, in seconds, between each regen cycle


// ======================================================================================================
// Victorious Tortoise
// ======================================================================================================
#define VICTORIOUS_TORTOISE_COST									2500
#define VICTORIOUS_TORTOISE_RADIANT_MACHINE_NAME					"vending_victorious_tortoise"	
#define VICTORIOUS_TORTOISE_ALIAS									"victorious_tortoise"
#define VICTORIOUS_TORTOISE_SCRIPT_STRING							"victorious_tortoise_perk"
#define VICTORIOUS_TORTOISE_JINGLE									"victorious_tortoise_jingle"
#define VICTORIOUS_TORTOISE_STING									"victorious_tortoise_sting"
#define VICTORIOUS_TORTOISE_CLIENTFIELD								"hudItems.perks.victorious_tortoise"

#define VICTORIOUS_TORTOISE_BOTTLE_WEAPON							"victorious_tortoise_perk_bottle_wpn"
#define VICTORIOUS_TORTOISE_MACHINE_ACTIVE_MODEL					"victorious_tortoise_model"
#define VICTORIOUS_TORTOISE_MACHINE_DISABLED_MODEL					"victorious_tortoise_model"
#define VICTORIOUS_TORTOISE_MACHINE_LIGHT_FX						"west/perks/harry_fx_perk_sleight_of_hand_light"
#define VICTORIOUS_TORTOISE_MODEL_BUCKET							"victorious_tortoise_model_bucket"

#define VICTORIOUS_TORTOISE_COST_STRING								"2500"
#define VICTORIOUS_TORTOISE_TRIG_STRING								"Hold ^3[{+activate}]^7 for Victorious Tortoise [Cost: &&1]\nShield Blocks All Damage When Held\nCreates an Explosion upon Breakage"

#define VICTORIOUS_TORTOISE_PERK									"specialty_delayexplosive"
#define VICTORIOUS_TORTOISE_USE_SECONDARY_PERKS						0
#define VICTORIOUS_TORTOISE_SECONDARY_PERKS							array ("")

#define VICTORIOUS_TORTOISE_SHIELD_REDUCE							.5	//Shield damage taken multiplier
#define VICTORIOUS_TORTOISE_SHIELD_EXPLOSION_RANGE					250	//Range of shield destruction explosion


// ======================================================================================================
// Vigor Rush
// ======================================================================================================
#define VIGOR_RUSH_COST												3000
#define VIGOR_RUSH_RADIANT_MACHINE_NAME								"vending_vigor_rush"	
#define VIGOR_RUSH_ALIAS											"vigor_rush"
#define VIGOR_RUSH_SCRIPT_STRING									"vigor_rush_perk"
#define VIGOR_RUSH_JINGLE											"vigor_rush_jingle"
#define VIGOR_RUSH_STING											"vigor_rush_sting"
#define VIGOR_RUSH_CLIENTFIELD										"hudItems.perks.vigor_rush"

#define VIGOR_RUSH_BOTTLE_WEAPON									"vigor_rush_perk_bottle_wpn"
#define VIGOR_RUSH_MACHINE_ACTIVE_MODEL								"vigor_rush_model_on"
#define VIGOR_RUSH_MACHINE_DISABLED_MODEL							"vigor_rush_model_off"
#define VIGOR_RUSH_MACHINE_LIGHT_FX									"west/perks/km_fx_perk_vigor_rush_zmb"
#define VIGOR_RUSH_MODEL_BUCKET										"vigor_rush_model_bucket"

#define VIGOR_RUSH_NAME												"Vigor Rush"
#define VIGOR_RUSH_DESC												"Deal Increased Bullet Damage"

#define VIGOR_RUSH_COST_STRING										"3000"
#define VIGOR_RUSH_TRIG_STRING										"Hold ^3[{+activate}]^7 for Vigor Rush [Cost: &&1]\nFire Explosive Bullets"

#define VIGOR_RUSH_PERK												"specialty_directionalfire"
#define VIGOR_RUSH_USE_SECONDARY_PERKS								0
#define VIGOR_RUSH_SECONDARY_PERKS									array ("")

#define VIGOR_RUSH_ALLOW_EXPLOSION_FX								1
#define VIGOR_RUSH_EXPLOSION_FX           							"vigor_rush_explosion" //level._effect for explosion
#define VIGOR_RUSH_EXPLOSION_FX_FILE       							"west/perks/km_fx_vigor_rush_exp" //FX File for explosion
#define VIGOR_RUSH_EXPLOSION_SOUND									"vigor_rush_wpn_exp"

#define VIGOR_RUSH_DAMAGE_MULTIPLIER								1.5 //Amount to multiply damage by
#define VIGOR_RUSH_EXPLOSION_RADIUS									48


// ======================================================================================================
// Wall Power
// ======================================================================================================
#define WALL_POWER_COST												8000
#define WALL_POWER_RADIANT_MACHINE_NAME								"vending_wall_power"	
#define WALL_POWER_ALIAS											"wall_power"
#define WALL_POWER_SCRIPT_STRING									"wall_power_perk"
#define WALL_POWER_JINGLE											"wall_power_jingle"
#define WALL_POWER_STING											"wall_power_sting"
#define WALL_POWER_CLIENTFIELD										"hudItems.perks.wall_power"

#define WALL_POWER_BOTTLE_WEAPON									"wall_power_perk_bottle_wpn"
#define WALL_POWER_MACHINE_ACTIVE_MODEL								"wall_power_model"
#define WALL_POWER_MACHINE_DISABLED_MODEL							"wall_power_model"
#define WALL_POWER_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_sleight_of_hand_light"
#define WALL_POWER_MODEL_BUCKET										"wall_power_model_bucket"

#define WALL_POWER_COST_STRING										"8000"
#define WALL_POWER_TRIG_STRING										"Hold ^3[{+activate}]^7 for Wall Power [Cost: &&1]\nWall Weapons Come Pack-a-Punched"

#define WALL_POWER_PERK												"specialty_detectexplosive"
#define WALL_POWER_USE_SECONDARY_PERKS								0
#define WALL_POWER_SECONDARY_PERKS									array ("")


// ======================================================================================================
// Widows Wine
// ======================================================================================================
#define WIDOWS_WINE_COST											3000
#define WIDOWS_WINE_RADIANT_MACHINE_NAME							"vending_widows_wine"	
#define WIDOWS_WINE_ALIAS											"widows_wine"
#define WIDOWS_WINE_SCRIPT_STRING									"widows_wine_perk"
#define WIDOWS_WINE_JINGLE											"widows_wine_jingle"
#define WIDOWS_WINE_STING											"widows_wine_sting"
#define WIDOWS_WINE_CLIENTFIELD										"hudItems.perks.widows_wine"

#define WIDOWS_WINE_BOTTLE_WEAPON									"widows_wine_perk_bottle_wpn"
#define WIDOWS_WINE_MACHINE_ACTIVE_MODEL							"widows_wine_model"
#define WIDOWS_WINE_MACHINE_DISABLED_MODEL							"widows_wine_model"
#define WIDOWS_WINE_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_widows_wine_light"
#define WIDOWS_WINE_MODEL_BUCKET									"widows_wine_model_bucket"

#define WIDOWS_WINE_COST_STRING										"3000"
#define WIDOWS_WINE_TRIG_STRING										"Hold ^3[{+activate}]^7 for Widows Wine [Cost: &&1]\nTaking Damage Creates a Spider Web Explosion, Sticking Zombies in Place\nReceieve Web Grenades"

#define WIDOWS_WINE_PERK											"specialty_widowswine"
#define WIDOWS_WINE_USE_SECONDARY_PERKS								0
#define WIDOWS_WINE_SECONDARY_PERKS									array ("")

#define WIDOWS_WINE_FX_WEB_1P										"west/perks/3arc_fx_widows_exp_1p_zmb"
#define WIDOWS_WINE_FX_WRAP											"west/perks/3arc_fx_widows_wrap_torso_zmb"

#define WIDOWS_WINE_WPN_GRENADE										"sticky_grenade_widows_wine"
#define WIDOWS_WINE_WPN_KNIFE										"knife_widows_wine"
#define WIDOWS_WINE_WPN_KNIFE_BOWIE									"bowie_knife_widows_wine"

#define WIDOWS_WINE_COCOON_DURATION									16
#define WIDOWS_WINE_COCOON_MELEE									50
#define WIDOWS_WINE_COCOON_RANGE									100
#define WIDOWS_WINE_COCOON_SLOWDOWN									.1
#define WIDOWS_WINE_SLOW_DURATION									12
#define WIDOWS_WINE_SLOW_SLOWDOWN									.7

#define WIDOWS_WINE_POWERUP_ALIAS									"ww_grenade"
#define WIDOWS_WINE_POWERUP_CHANCE									15
#define WIDOWS_WINE_POWERUP_GIVE									1
#define WIDOWS_WINE_POWERUP_MODEL									"p7_zm_power_up_widows_wine"


// ======================================================================================================
// Windrunner Whiskey
// ======================================================================================================
#define WINDRUNNER_COST												2000
#define WINDRUNNER_RADIANT_MACHINE_NAME								"vending_windrunner"	
#define WINDRUNNER_ALIAS											"windrunner"
#define WINDRUNNER_SCRIPT_STRING									"windrunner_perk"
#define WINDRUNNER_JINGLE											"windrunner_jingle"
#define WINDRUNNER_STING											"windrunner_sting"
#define WINDRUNNER_CLIENTFIELD										"hudItems.perks.windrunner"

#define WINDRUNNER_BOTTLE_WEAPON									"windrunner_perk_bottle_wpn"
#define WINDRUNNER_MACHINE_ACTIVE_MODEL								"windrunner_model"
#define WINDRUNNER_MACHINE_DISABLED_MODEL							"windrunner_model"
#define WINDRUNNER_MACHINE_LIGHT_FX									"west/perks/abnormal202_perk_wind_light"
#define WINDRUNNER_MODEL_BUCKET										"windrunner_model_bucket"

#define WINDRUNNER_COST_STRING										"2000"
#define WINDRUNNER_TRIG_STRING										"Hold ^3[{+activate}]^7 for Windrunner Whiskey [Cost: &&1]\nFire While Sprinting, Sprint to Charge a Gust of Wind and Plow Through Enemies"

#define WINDRUNNER_ICON												"windrunner_perk_icon_hud"
#define WINDRUNNER_PERK												"specialty_sprintfire"
#define WINDRUNNER_USE_SECONDARY_PERKS								0
#define WINDRUNNER_SECONDARY_PERKS									array ("")

#define WINDRUNNER_PLAYER_RUNNING_FX								"west/perks/abnormal202_wind_running_impact"
#define WINDRUNNER_IMPACT_FX										"west/perks/abnormal202_wind_running_player_fx"

#define WINDRUNNER_PLAY_SOUNDS										1 //Allow sounds to play
#define WINDRUNNER_CHARGE_SOUND										"windrunner_charge"
#define WINDRUNNER_IMPACT_SOUND										"windrunner_impact"
#define WINDRUNNER_RUNNING_SOUND									"windrunner_running"

#define WINDRUNNER_CHARGE_TIME										1 //Time to charge air while sprinting
#define WINDRUNNER_BLAST_DISTANCE									50 //Range of sprint attack
#define WINDRUNNER_BLAST_COOLDOWN									12 //Sprint charge cooldown
#define WINDRUNNER_JUMP_BLAST_MIN_HEIGHT							50 //Distance Player must fall to activate slam
#define WINDRUNNER_SLAM_DISTANCE									300 //Range of slam attack


// ======================================================================================================
// Winter's Wail
// ======================================================================================================
#define WINTERS_WAIL_COST											3000
#define WINTERS_WAIL_RADIANT_MACHINE_NAME							"vending_winters_wail"	
#define WINTERS_WAIL_ALIAS											"winters_wail"
#define WINTERS_WAIL_SCRIPT_STRING									"winters_wail_perk"
#define WINTERS_WAIL_JINGLE											"winters_wail_jingle"
#define WINTERS_WAIL_STING											"winters_wail_sting"
#define WINTERS_WAIL_CLIENTFIELD									"hudItems.perks.winters_wail"

#define WINTERS_WAIL_BOTTLE_WEAPON									"winters_wail_perk_bottle_wpn"
#define WINTERS_WAIL_MACHINE_ACTIVE_MODEL							"winters_wail_model"
#define WINTERS_WAIL_MACHINE_DISABLED_MODEL							"winters_wail_model"
#define WINTERS_WAIL_MACHINE_LIGHT_FX								"west/perks/harry_fx_perk_widows_wine_light"
#define WINTERS_WAIL_MODEL_BUCKET									"winters_wail_model_bucket"

#define WINTERS_WAIL_COST_STRING									"3000"
#define WINTERS_WAIL_TRIG_STRING									"Hold ^3[{+activate}]^7 for Winter's Wail [Cost: &&1]\nBeeing Meleed While Not at Full Health Creates a Frost Blast That Freezes Enemies\nStore Up to 3 Charges"

#define WINTERS_WAIL_ICON											"winters_wail_perk_icon_hud"
#define WINTERS_WAIL_ICON_SNOWFLAKE									"winters_wail_perk_icon_hud_snowflake"
#define WINTERS_WAIL_PERK											"specialty_detectnearbyenemies"
#define WINTERS_WAIL_USE_SECONDARY_PERKS							0
#define WINTERS_WAIL_SECONDARY_PERKS								array ("")

#define WINTERS_WAIL_EXPLOSION_FX									"west/perks/logistical_reaper_winters_wail_blast"
#define WINTERS_WAIL_ZOMBIE_FREEZE_FX								"west/perks/logistical_reaper_winters_wail_zombie"

#define WINTERS_WAIL_FROZEN_DURATION								16	//How long the zombie is frozen for
#define WINTERS_WAIL_FROZEN_RATE_CLOSE								0.1
#define WINTERS_WAIL_FROZEN_RATE_MID								0.4
#define WINTERS_WAIL_FROZEN_RATE_FAR								0.8

#define WINTERS_WAIL_MAX_CHARGES									3	//Max Charges Player can hold
#define WINTERS_WAIL_RANGE											240	//Range of Frost Explosion
#define WINTERS_WAIL_RECHARGE_TIME									60	//Time to recharge a single charge

#define WINTERS_WAIL_DRAW_CHARGES									1	//Draw charge display on screen
#define WINTERS_WAIL_SNOWFLAKE_ALIGN_X								"right"
#define WINTERS_WAIL_SNOWFLAKE_ALIGN_Y								"bottom"
#define WINTERS_WAIL_SNOWFLAKE_X									-180
#define WINTERS_WAIL_SNOWFLAKE_Y									-5
#define WINTERS_WAIL_TEXT_ALIGN_X									"right"
#define WINTERS_WAIL_TEXT_ALIGN_Y									"bottom"
#define WINTERS_WAIL_TEXT_X											-205
#define WINTERS_WAIL_TEXT_Y											-5


// ======================================================================================================
// Wunderfizz
// ======================================================================================================
#define WUNDERFIZZ_COST												1500
#define WUNDERFIZZ_ALIAS											"wunderfizz"

#define WUNDERFIZZ_BOTTLE_MODEL										"wunderfizz_perk_bottle_wpn_world"

#define WUNDERFIZZ_FX_GREEN											"west/perks/3arc_fx_wonder_fizz_light_green"
#define WUNDERFIZZ_FX_LOCATION										"west/perks/3arc_fx_wonder_fizz_lightning_all"
#define WUNDERFIZZ_FX_RED											"west/perks/3arc_fx_wonder_fizz_light_red"

#define WUNDERFIZZ_TIME_BOTTLE_READY								3
#define WUNDERFIZZ_USE_TIMEOUT										10
#define WUNDERFIZZ_USE_TIMES_MIN									3
#define WUNDERFIZZ_USE_TIMES_MAX									6


// ======================================================================================================
// Zombshell
// ======================================================================================================
#define ZOMBSHELL_COST												4000
#define ZOMBSHELL_RADIANT_MACHINE_NAME								"vending_zombshell"	
#define ZOMBSHELL_ALIAS												"zombshell"
#define ZOMBSHELL_SCRIPT_STRING										"zombshell_perk"
#define ZOMBSHELL_JINGLE											"zombshell_jingle"
#define ZOMBSHELL_STING												"zombshell_sting"
#define ZOMBSHELL_CLIENTFIELD										"hudItems.perks.zombshell"

#define ZOMBSHELL_BOTTLE_WEAPON										"zombshell_perk_bottle_wpn"
#define ZOMBSHELL_MACHINE_ACTIVE_MODEL								"zombshell_model"
#define ZOMBSHELL_MACHINE_DISABLED_MODEL							"zombshell_model"
#define ZOMBSHELL_MACHINE_LIGHT_FX									"west/perks/harry_fx_perk_juggernaut_light"
#define ZOMBSHELL_MODEL_BUCKET										"zombshell_model_bucket"

#define ZOMBSHELL_COST_STRING										"4000"
#define ZOMBSHELL_TRIG_STRING										"Hold ^3[{+activate}]^7 for Zombshell [Cost: &&1]\nZombies Have a Chance to Explode When Killed\nCreating a Localized Field That Slows Enemies and Increases Damage Dealt"

#define ZOMBSHELL_ICON												"zombshell_perk_icon_hud"
#define ZOMBSHELL_PERK												"specialty_immunetriggerbetty"
#define ZOMBSHELL_USE_SECONDARY_PERKS								0
#define ZOMBSHELL_SECONDARY_PERKS									array ("")

#define ZOMBSHELL_FIELD_START_FX									"west/perks/logistical_reaper_zombshell"
#define ZOMBSHELL_FIELD_START_SOUND									"zombshell_field_start"

#define ZOMBSHELL_FIELD_START										5	//Percent chance a zombie starts the field
#define ZOMBSHELL_FIELD_ACTIVE										12	//How long is field active for
#define ZOMBSHELL_FIELD_COOLDOWN									60	//How long to cooldown
#define ZOMBSHELL_FIELD_RANGE										350	//Max distance from center zombies will be affected
#define ZOMBSHELL_FIELD_DAMAGE										1.75 //Damage multiplier for zombies affected by field

#define ZOMBSHELL_ZOMBIE_SLOWDOWN_RATE								0.7
#define ZOMBSHELL_ZOMBIE_SLOWDOWN_TIME								2.0