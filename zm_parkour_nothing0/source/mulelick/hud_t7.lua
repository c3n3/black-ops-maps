-- The Giant Hud Base, Rebuilt from the ground up by the D3V Team

require("ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer")
require("ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmoContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_Score.ZMScr")
require("ui.uieditor.widgets.DynamicContainerWidget")
require("ui.uieditor.widgets.Notifications.Notification")
require("ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotifBGB_ContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_CursorHint.ZMCursorHint")
require("ui.uieditor.widgets.HUD.CenterConsole.CenterConsole")
require("ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate")
require("ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr")
require("ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown")
require("ui.uieditor.widgets.Scoreboard.CP.ScoreboardWidgetCP")
require("ui.uieditor.widgets.HUD.ZM_TimeBar.ZM_BeastmodeTimeBarWidget")
require("ui.uieditor.widgets.ZMInventory.RocketShieldBluePrint.RocketShieldBlueprintWidget")
require("ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer")
require("ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame")

require("ui.utils.CoreUtil")
require("ui.utils.T7FontLoader")

CoD.Zombie.CommonHudRequire()

local PreLoadFunc = function(self, controller)
	FontLoader(self, { "" }) -- Load fonts here; "folder/font"
	CoD.Zombie.CommonPreLoadHud(self, controller)
end	

local PostLoadFunc = function(self, controller)
    CoD.Zombie.CommonPostLoadHud(self, controller)
end

LUI.createMenu.T7Hud_zm_factory = function(controller)
    local self = CoD.Menu.NewForUIEditor("T7Hud_zm_factory")
    
    if PreLoadFunc then
        PreLoadFunc(self, controller)
    end

	if not CoD.ZMPerksFactory then
		CoD.ZMPerksFactory =
		{
			quick_revive = "$blacktransparent",
			doubletap2 = "$blacktransparent",
			juggernaut = "$blacktransparent",
			sleight_of_hand = "$blacktransparent",
			dead_shot = "$blacktransparent",
			phdflopper = "$blacktransparent",
			marathon = "$blacktransparent",
			additional_primary_weapon = "$blacktransparent",
			widows_wine = "$blacktransparent",
			tombstone = "$blacktransparent",
			vultureaid	= "$blacktransparent",
			whoswho	= "$blacktransparent",

			ammo_americano							="perk_icon_ammo_americano",
			astro_ale							="perk_icon_astro_ale",
			atomic_liqueur 							="perk_icon_atomic_liqueur",
			banana_colada							="perk_icon_banana_colada",
			bandolier_bandit						="perk_icon_bandolier_bandit",
			blaze_phase							="perk_icon_blaze_phase",
			bleeding							="perk_icon_bleeding",
			blood_wolf							="perk_icon_blood_wolf",
			brawlstar_punch							="perk_icon_brawlstar_punch",
			brimstone_bramble						="perk_icon_brimstone_bramble",
			bull_ice_blast							="perk_icon_bull_ice_blast",
			crack_shot							="perk_icon_crack_shot",
			crusaders_ale							="perk_icon_crusaders_ale",
			cryo_slide							="perk_icon_cryo_slide",
			death_perception						="perk_icon_death_perception",
			divine_ale							="perk_icon_divine_ale",
			double_dew							="perk_icon_double_dew",
			doubletap1 							="perk_icon_doubletap1",
			doubletap3 							="perk_icon_doubletap3",
			dying_wish							="perk_icon_dying_wish",
			electric_cherry							="perk_icon_electric_cherry",
			elemental_pop							="perk_icon_elemental_pop",
			ethereal_razor							="perk_icon_ethereal_razor",
			fighters_fizz							="perk_icon_fighters_fizz",
			gamblers_gibson							="perk_icon_gamblers_gibson",
			glitching_gin							="perk_icon_glitching_gin",
			icu								="perk_icon_icu",
			madgaz_moonshine						="perk_icon_madgaz_moonshine",
			magnet 								="perk_icon_magnet_mule",
			masochist 							="perk_icon_masochist_malecon",
			medusas_mauresque						="perk_icon_medusas_mauresque",
			muscle_milk							="perk_icon_muscle_milk",
			phd_slider							="perk_icon_phd_slider",
			pickpocket_paloma 						="perk_icon_pickpocket_paloma",
			power_aid_punch							="perk_icon_power_aid_punch",
			prickling_prosecco						="perk_icon_prickling_prosecco",
			roulette							="perk_icon_roulette",
			rebate_rose							="perk_icon_rebate_rose",
			salvage_shake							="perk_icon_salvage_shake",
			samurais_spirit							="perk_icon_samurais_spirit",
			side_step							="perk_icon_side_step",
			slip_away							="perk_icon_slip_away",
			slurpentine							="perk_icon_slurpentine",
			snails_pace							="perk_icon_snails_pace",
			space_cadet							="perk_icon_space_cadet_cola",
			spectral_shake							="perk_icon_spectral_shake",
			stone_cold							="perk_icon_stone_cold",
			tactiquilla							="perk_icon_tactiquilla",
			time_out							="perk_icon_time_out",
			timeslip							="perk_icon_timeslip",
			tombstone_soda							="perk_icon_tombstone",
			verruckt_jug 							="perk_icon_verruckt_juggernog",
			victorious_tortoise						="perk_icon_victorious_tortoise",
			vigor_rush		 					="perk_icon_vigor_rush",
			wall_power 							="perk_icon_wall_power",
			windrunner							="perk_icon_windrunner",
			winters_wail							="perk_icon_winters_wail",
			zombshell							="perk_icon_zombshell",
			mule_lick							="perk_shader_mulelick"


		}
	end
	
	require("ui.uieditor.widgets.hud.customperksfactory")
    
    self.soundSet = "HUD"
    self:setOwner(controller)
    self:setLeftRight(true, true, 0, 0)
    self:setTopBottom(true, true, 0, 0)
    self:playSound("menu_open", controller)
    self.buttonModel = Engine.CreateModel(Engine.GetModelForController(controller), "T7Hud_zm_factory.buttonPrompts")
    self.anyChildUsesUpdateState = true
    
    self.PerksWidget = CoD.ZMPerksContainerFactory.new(self, controller)
    self.PerksWidget:setLeftRight(true, false, 130, 281)
    self.PerksWidget:setTopBottom(false, true, -62, -26)
    self:addElement(self.PerksWidget)
    self.ZMPerksContainerFactory = self.PerksWidget
    
    self.RoundCounter = CoD.ZmRndContainer.new(self, controller)
    self.RoundCounter:setLeftRight(true, false, -32, 192)
    self.RoundCounter:setTopBottom(false, true, -174, 18)
    self.RoundCounter:setScale(0.8)
    self:addElement(self.RoundCounter)
    self.Rounds = self.RoundCounter
    
    self.AmmoWidget = CoD.ZmAmmoContainerFactory.new(self, controller)
    self.AmmoWidget:setLeftRight(false, true, -427.000000, 3.000000)
    self.AmmoWidget:setTopBottom(false, true, -232.000000, 0.000000)
    self:addElement(self.AmmoWidget)
    self.Ammo = self.AmmoWidget
    
    self.ScoreWidget = CoD.ZMScr.new(self, controller)
    self.ScoreWidget:setLeftRight(true, false, 30.000000, 164.000000)
    self.ScoreWidget:setTopBottom(false, true, -256.000000, -128.000000)
    self.ScoreWidget:setYRot(30.000000)
    self:addElement(self.ScoreWidget)
    self.Score = self.ScoreWidget

    self.Score.StateTable = {
		{
			stateName = "HudStart",
			condition = function(self, ItemRef, UpdateTable)
				local condition = IsModelValueTrue(controller, "hudItems.playerSpawned")
				if condition then
					if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) then
						condition = not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE)
					else
						condition = false
					end
				end
				return condition
			end
		}
	}
	self.Score:mergeStateConditions(self.Score.StateTable)

    SubscribeToModelAndUpdateState(controller, self, self.Score, "hudItems.playerSpawned")

    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_GAME_ENDED)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IN_KILLCAM)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_UI_ACTIVE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IS_SCOPED)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IN_VEHICLE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.Score, Enum.UIVisibilityBit.BIT_EMP_ACTIVE)
    
    self.fullscreenContainer = CoD.DynamicContainerWidget.new(self, controller)
	self.fullscreenContainer:setLeftRight(false, false, -640, 640)
	self.fullscreenContainer:setTopBottom(false, false, -360, 360)
	self:addElement(self.fullscreenContainer)
	
	self.Notifications = CoD.Notification.new(self, controller)
	self.Notifications:setLeftRight(true, true, 0, 0)
	self.Notifications:setTopBottom(true, true, 0, 0)
	self:addElement(self.Notifications)
	
	self.ZmNotifBGBContainerFactory = CoD.ZmNotifBGB_ContainerFactory.new(self, controller)
	self.ZmNotifBGBContainerFactory:setLeftRight(false, false, -156, 156)
	self.ZmNotifBGBContainerFactory:setTopBottom(true, false, -6, 247)
	self.ZmNotifBGBContainerFactory:setScale(0.75)
	self:addElement(self.ZmNotifBGBContainerFactory)
	
	self.ZmNotifBGBContainerFactory:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if IsParamModelEqualToString(ModelRef, "zombie_bgb_token_notification") then
			AddZombieBGBTokenNotification(self, self.ZmNotifBGBContainerFactory, controller, ModelRef)
		elseif IsParamModelEqualToString(ModelRef, "zombie_bgb_notification") then
			AddZombieBGBNotification(self, self.ZmNotifBGBContainerFactory, ModelRef)
		elseif IsParamModelEqualToString(ModelRef, "zombie_notification") then
			AddZombieNotification(self, self.ZmNotifBGBContainerFactory, ModelRef)
		end
	end)
    
    self.CursorHint = CoD.ZMCursorHint.new(self, controller)
	self.CursorHint:setLeftRight(false, false, -250, 250)
	self.CursorHint:setTopBottom(true, false, 522, 616)
	self:addElement(self.CursorHint)
	
	self.CursorHint.StateTable = {
		{
			stateName = "Active_1x1",
			condition = function(self, ItemRef, UpdateTable)
				local condition = IsCursorHintActive(controller)
				if condition then
					if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(controller), "cursorHintIconRatio")) ~= 1 then
						condition = false
					else
						condition = true
					end
				end
				return condition
			end
		},
		{
			stateName = "Active_2x1",
			condition = function(self, ItemRef, UpdateTable)
				local condition = IsCursorHintActive(controller)
				if condition then
					if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(controller), "cursorHintIconRatio")) ~= 2 then
						condition = false
					else
						condition = true
					end
				end
				return condition
			end
		},
		{
			stateName = "Active_4x1",
			condition = function(self, ItemRef, UpdateTable)
				local condition = IsCursorHintActive(controller)
				if condition then
					if Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(controller), "cursorHintIconRatio")) ~= 4 then
						condition = false
					else
						condition = true
					end
				end
				return condition
			end
		},
		{
			stateName = "Active_NoImage",
			condition = function(self, ItemRef, UpdateTable)
				local condition = IsCursorHintActive(controller)
				if condition then
					if not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
						condition = IsModelValueEqualTo(controller, "hudItems.cursorHintIconRatio", 0)
					else
						condition = false
					end
				end
				return condition
			end
		}
	}
	self.CursorHint:mergeStateConditions(self.CursorHint.StateTable)

    SubscribeToModelAndUpdateState(controller, self, self.CursorHint, "hudItems.showCursorHint")
    SubscribeToModelAndUpdateState(controller, self, self.CursorHint, "hudItems.cursorHintIconRatio")

    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_HUD_VISIBLE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_HUD_HARDCORE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_UI_ACTIVE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK)
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING)
    
    self.ConsoleCenter = CoD.CenterConsole.new(self, controller)
	self.ConsoleCenter:setLeftRight(false, false, -370, 370)
	self.ConsoleCenter:setTopBottom(true, false, 68.5, 166.5)
	self:addElement(self.ConsoleCenter)
	
	self.DeadSpectate = CoD.DeadSpectate.new(self, controller)
	self.DeadSpectate:setLeftRight(false, false, -150, 150)
	self.DeadSpectate:setTopBottom(false, true, -180, -120)
	self:addElement(self.DeadSpectate)
	
	self.MPScore = CoD.MPScr.new(self, controller)
	self.MPScore:setLeftRight(false, false, -50, 50)
	self.MPScore:setTopBottom(true, false, 233.5, 258.5)
	self:addElement(self.MPScore)
	
	self.MPScore:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(ModelRef)
		if IsParamModelEqualToString(ModelRef, "score_event") and PropertyIsTrue(self, "menuLoaded") then
			PlayClipOnElement(self, {
				elementName = "MPScore",
				clipName = "NormalScore"
			}, controller)
			SetMPScoreText(self, self.MPScore, controller, ModelRef)
		end
	end)
    
    self.ZMPrematchCountdown0 = CoD.ZM_PrematchCountdown.new(self, controller)
	self.ZMPrematchCountdown0:setLeftRight(false, false, -640, 640)
	self.ZMPrematchCountdown0:setTopBottom(false, false, -360, 360)
	self:addElement(self.ZMPrematchCountdown0)
	
	self.ScoreboardWidget = CoD.ScoreboardWidgetCP.new(self, controller)
	self.ScoreboardWidget:setLeftRight(false, false, -503, 503)
	self.ScoreboardWidget:setTopBottom(true, false, 247, 773)
	self:addElement(self.ScoreboardWidget)
	
	self.ZMBeastBar = CoD.ZM_BeastmodeTimeBarWidget.new(self, controller)
	self.ZMBeastBar:setLeftRight(false, false, -242.5, 321.5)
	self.ZMBeastBar:setTopBottom(false, true, -174, -18)
	self.ZMBeastBar:setScale(0.7)
	self:addElement(self.ZMBeastBar)
	
	self.RocketShieldBlueprintWidget = CoD.RocketShieldBlueprintWidget.new(self, controller)
	self.RocketShieldBlueprintWidget:setLeftRight(true, false, -36.5, 277.5)
	self.RocketShieldBlueprintWidget:setTopBottom(true, false, 104, 233)
	self.RocketShieldBlueprintWidget:setScale(0.8)
	self:addElement(self.RocketShieldBlueprintWidget)
	
	self.RocketShieldBlueprintWidget.StateTable = {
		{
			stateName = "Scoreboard",
			condition = function(self, ItemRef, UpdateTable)
				local condition = Engine.IsVisibilityBitSet(controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
				if condition then
					condition = AlwaysFalse()
				end

				return condition
			end
		}
	}
	self.RocketShieldBlueprintWidget:mergeStateConditions(self.RocketShieldBlueprintWidget.StateTable)

    SubscribeToModelAndUpdateState(controller, self, self.CursorHint, "zmInventory.widget_shield_parts")
    SubscribeToVisibilityBitAndUpdateElementState(controller, self, self.CursorHint, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)

    
    self.IngameChatClientContainer = CoD.IngameChatClientContainer.new(self, controller)
	self.IngameChatClientContainer:setLeftRight(true, false, 0, 360)
	self.IngameChatClientContainer:setTopBottom(true, false, -2.5, 717.5)
	self:addElement(self.IngameChatClientContainer)
	
	self.IngameChatClientContainer0 = CoD.IngameChatClientContainer.new(self, controller)
	self.IngameChatClientContainer0:setLeftRight(true, false, 0, 360)
	self.IngameChatClientContainer0:setTopBottom(true, false, -2.5, 717.5)
	self:addElement(self.IngameChatClientContainer0)
	
	self.BubbleGumPackInGame = CoD.BubbleGumPackInGame.new(self, controller)
	self.BubbleGumPackInGame:setLeftRight(false, false, -184, 184)
	self.BubbleGumPackInGame:setTopBottom(true, false, 36, 185)
	self:addElement(self.BubbleGumPackInGame)
	
	self.Score.navigation = {
		up = self.ScoreboardWidget,
		right = self.ScoreboardWidget
	}
	self.ScoreboardWidget.navigation = {
		left = self.Score,
		down = self.Score
	}
	CoD.Menu.AddNavigationHandler(self, self, controller)
    
    self:registerEventHandler("menu_loaded", function(element, Event)
		SizeToSafeArea(element, controller)
		SetProperty(self, "menuLoaded", true)
		return element:dispatchEventToChildren(Event)
	end)

	self.Score.id = "Score"
	self.ScoreboardWidget.id = "ScoreboardWidget"

	self:processEvent({
		name = "menu_loaded",
		controller = controller
	})
	self:processEvent({
		name = "update_state",
		menu = self
	})

	if not self:restoreState() then
		self.ScoreboardWidget:processEvent({
			name = "gain_focus",
			controller = controller
		})
	end
    
    LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
		element.ZMPerksContainerFactory:close()
		element.Rounds:close()
		element.Ammo:close()
		element.Score:close()
		element.fullscreenContainer:close()
		element.Notifications:close()
		element.ZmNotifBGBContainerFactory:close()
		element.CursorHint:close()
		element.ConsoleCenter:close()
		element.DeadSpectate:close()
		element.MPScore:close()
		element.ZMPrematchCountdown0:close()
		element.ScoreboardWidget:close()
		element.ZMBeastBar:close()
		element.RocketShieldBlueprintWidget:close()
		element.IngameChatClientContainer:close()
		element.IngameChatClientContainer0:close()
		element.BubbleGumPackInGame:close()

		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(controller), "T7Hud_zm_factory.buttonPrompts"))
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller)
	end

	return self
end