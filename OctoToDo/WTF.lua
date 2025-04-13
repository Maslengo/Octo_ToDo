local GlobalAddonName, E = ...
local OctoToDo_EventFrame_WTF = CreateFrame("FRAME")
OctoToDo_EventFrame_WTF:Hide()
----------------------------------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_WTF, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_WTF:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil

		if OctoToDo_DB_Config == nil then OctoToDo_DB_Config = {} end
		if OctoToDo_DB_Levels == nil then OctoToDo_DB_Levels = {} end
		if OctoToDo_DB_Other == nil then OctoToDo_DB_Other = {} end
		if OctoToDo_DB_Config.CurrencyDB == nil then OctoToDo_DB_Config.CurrencyDB = {} end
		if OctoToDo_DB_Config.ReputationDB == nil then OctoToDo_DB_Config.ReputationDB = {} end
		if OctoToDo_DB_Other.AccountMoney == nil then OctoToDo_DB_Other.AccountMoney = {} end
		if OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] == nil then OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] = 0 end
		if OctoToDo_DB_Other.CVar == nil then OctoToDo_DB_Other.CVar = {} end
		if OctoToDo_DB_Other.Items == nil then OctoToDo_DB_Other.Items = {} end
		if OctoToDo_DB_Other.LFGInstance == nil then OctoToDo_DB_Other.LFGInstance = {} end
		-- if OctoToDo_DB_Other.Holiday == nil then OctoToDo_DB_Other.Holiday = {} end
		if OctoToDo_DB_Vars == nil then OctoToDo_DB_Vars = {} end
		if OctoToDo_DB_Vars.DebugIDs == nil then OctoToDo_DB_Vars.DebugIDs = false end
		E.DebugIDs = OctoToDo_DB_Vars.DebugIDs
		if OctoToDo_DB_Vars.DebugInfo == nil then OctoToDo_DB_Vars.DebugInfo = false end
		E.DebugInfo = OctoToDo_DB_Vars.DebugInfo
		if OctoToDo_DB_Vars.DebugEvent == nil then OctoToDo_DB_Vars.DebugEvent = false end
		E.DebugEvent = OctoToDo_DB_Vars.DebugEvent
		if OctoToDo_DB_Vars.DebugFunction == nil then OctoToDo_DB_Vars.DebugFunction = false end
		E.DebugFunction = OctoToDo_DB_Vars.DebugFunction
		if OctoToDo_DB_Vars.DebugButton == nil then OctoToDo_DB_Vars.DebugButton = false end
		E.DebugButton = OctoToDo_DB_Vars.DebugButton


		if OctoToDo_DB_Vars.AddonHeight == nil then OctoToDo_DB_Vars.AddonHeight = 20 end
		if OctoToDo_DB_Vars.AddonLeftFrameWeight == nil then OctoToDo_DB_Vars.AddonLeftFrameWeight = 200 end
		if OctoToDo_DB_Vars.AddonCentralFrameWeight == nil then OctoToDo_DB_Vars.AddonCentralFrameWeight = 90 end
		if OctoToDo_DB_Vars.MainFrameDefaultLines == nil then OctoToDo_DB_Vars.MainFrameDefaultLines = 30 end
		if OctoToDo_DB_Vars.SFDropDownWeight == nil then OctoToDo_DB_Vars.SFDropDownWeight = 100 end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- if OctoToDo_DB_Vars.AddonHeight then
		-- 	AddonHeight = OctoToDo_DB_Vars.AddonHeight
		-- end
		-- if OctoToDo_DB_Vars.AddonLeftFrameWeight then
		-- 	AddonLeftFrameWeight = OctoToDo_DB_Vars.AddonLeftFrameWeight
		-- end
		-- if OctoToDo_DB_Vars.AddonCentralFrameWeight then
		-- 	AddonCentralFrameWeight = OctoToDo_DB_Vars.AddonCentralFrameWeight
		-- end
		-- if OctoToDo_DB_Vars.MainFrameDefaultLines then
		-- 	MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
		-- end
		-- if OctoToDo_DB_Vars.SFDropDownWeight then
		-- 	SFDropDownWeight = OctoToDo_DB_Vars.SFDropDownWeight
		-- end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if OctoToDo_DB_Vars.PortalsButtons == nil then OctoToDo_DB_Vars.PortalsButtons = true end
		if OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable == nil then OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable = true end
		if OctoToDo_DB_Vars.color == nil then OctoToDo_DB_Vars.color = {1, 1, 1} end
		if OctoToDo_DB_Vars.AchievementShowCompleted == nil then OctoToDo_DB_Vars.AchievementShowCompleted = true end
		if OctoToDo_DB_Vars.AchievementToShow == nil then OctoToDo_DB_Vars.AchievementToShow = {[92] = true} end
		if OctoToDo_DB_Vars.AidingtheAccord == nil then OctoToDo_DB_Vars.AidingtheAccord = true end
		if OctoToDo_DB_Vars.AnotherAddonsCasual == nil then OctoToDo_DB_Vars.AnotherAddonsCasual = true end
		if OctoToDo_DB_Vars.AnotherAddonsDUNG == nil then OctoToDo_DB_Vars.AnotherAddonsDUNG = true end
		if OctoToDo_DB_Vars.AnotherAddonsRAID == nil then OctoToDo_DB_Vars.AnotherAddonsRAID = true end
		if OctoToDo_DB_Vars.Auto_ChatClearing == nil then OctoToDo_DB_Vars.Auto_ChatClearing = false end
		if OctoToDo_DB_Vars.Auto_CinematicCanceler == nil then OctoToDo_DB_Vars.Auto_CinematicCanceler = true end
		if OctoToDo_DB_Vars.Auto_CinematicFastSkip == nil then OctoToDo_DB_Vars.Auto_CinematicFastSkip = true end
		if OctoToDo_DB_Vars.Auto_Gossip == nil then OctoToDo_DB_Vars.Auto_Gossip = true end
		if OctoToDo_DB_Vars.Auto_Screenshot == nil then OctoToDo_DB_Vars.Auto_Screenshot = true end
		if OctoToDo_DB_Vars.AutoGossip == nil then OctoToDo_DB_Vars.AutoGossip = true end
		if OctoToDo_DB_Vars.AutoOpen == nil then OctoToDo_DB_Vars.AutoOpen = true end
		if OctoToDo_DB_Vars.AutoRepair == nil then OctoToDo_DB_Vars.AutoRepair = true end
		if OctoToDo_DB_Vars.AutoSellGrey == nil then OctoToDo_DB_Vars.AutoSellGrey = true end
		if OctoToDo_DB_Vars.AutoTurnQuests == nil then OctoToDo_DB_Vars.AutoTurnQuests = true end
		if OctoToDo_DB_Vars.BeledarCycle == nil then OctoToDo_DB_Vars.BeledarCycle = true end
		if OctoToDo_DB_Vars.CarvedHarbingerCrest == nil then OctoToDo_DB_Vars.CarvedHarbingerCrest = true end
		if OctoToDo_DB_Vars.ChallengesKeystoneFrame == nil then OctoToDo_DB_Vars.ChallengesKeystoneFrame = true end
		if OctoToDo_DB_Vars.CinematicCanceler == nil then OctoToDo_DB_Vars.CinematicCanceler = true end
		if OctoToDo_DB_Vars.Currency == nil then OctoToDo_DB_Vars.Currency = true end
		if OctoToDo_DB_Vars.CurrencyShowAllways == nil then OctoToDo_DB_Vars.CurrencyShowAllways = false end
		if OctoToDo_DB_Vars.CVar == nil then OctoToDo_DB_Vars.CVar = true end
		if OctoToDo_DB_Vars.Dungeons == nil then OctoToDo_DB_Vars.Dungeons = true end
		if OctoToDo_DB_Vars.EmeraldDream_Dreamseeds == nil then OctoToDo_DB_Vars.EmeraldDream_Dreamseeds = true end
		if OctoToDo_DB_Vars.EmeraldDream_Rares == nil then OctoToDo_DB_Vars.EmeraldDream_Rares = true end
		if OctoToDo_DB_Vars.EmeraldDream_Sparks == nil then OctoToDo_DB_Vars.EmeraldDream_Sparks = true end
		if OctoToDo_DB_Vars.EmeraldDream_WB == nil then OctoToDo_DB_Vars.EmeraldDream_WB = true end
		if OctoToDo_DB_Vars.Event == nil then OctoToDo_DB_Vars.Event = true end
		if OctoToDo_DB_Vars.ExpansionToShow == nil then OctoToDo_DB_Vars.ExpansionToShow = {[1] = true} end
		if OctoToDo_DB_Vars.FrameScale == nil then OctoToDo_DB_Vars.FrameScale = 1 end
		if OctoToDo_DB_Vars.GameMenuFrameScale == nil then OctoToDo_DB_Vars.GameMenuFrameScale = .8 end
		if OctoToDo_DB_Vars.GildedHarbingerCrest == nil then OctoToDo_DB_Vars.GildedHarbingerCrest = true end
		if OctoToDo_DB_Vars.Gold == nil then OctoToDo_DB_Vars.Gold = true end
		if OctoToDo_DB_Vars.Professions == nil then OctoToDo_DB_Vars.Professions = true end
		if OctoToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI == nil then OctoToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI = true end
		if OctoToDo_DB_Vars.Hide_Boss_Banner == nil then OctoToDo_DB_Vars.Hide_Boss_Banner = true end
		if OctoToDo_DB_Vars.Hide_Covenant == nil then OctoToDo_DB_Vars.Hide_Covenant = true end
		if OctoToDo_DB_Vars.Hide_Error_Messages == nil then OctoToDo_DB_Vars.Hide_Error_Messages = true end
		if OctoToDo_DB_Vars.Hide_ObjectivesInInstance == nil then OctoToDo_DB_Vars.Hide_ObjectivesInInstance = true end
		if OctoToDo_DB_Vars.Hide_OrderHallCommandBar == nil then OctoToDo_DB_Vars.Hide_OrderHallCommandBar = true end
		if OctoToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame == nil then OctoToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame = true end
		if OctoToDo_DB_Vars.Hide_RaidWarningFrame == nil then OctoToDo_DB_Vars.Hide_RaidWarningFrame = true end
		if OctoToDo_DB_Vars.Hide_Talking_Head_Frame == nil then OctoToDo_DB_Vars.Hide_Talking_Head_Frame = true end
		if OctoToDo_DB_Vars.Hide_Zone_Text == nil then OctoToDo_DB_Vars.Hide_Zone_Text = true end
		if OctoToDo_DB_Vars.InputDelete == nil then OctoToDo_DB_Vars.InputDelete = true end
		if OctoToDo_DB_Vars.ItemLevel == nil then OctoToDo_DB_Vars.ItemLevel = true end
		if OctoToDo_DB_Vars.itemLevelToShow == nil then OctoToDo_DB_Vars.itemLevelToShow = 1 end
		if OctoToDo_DB_Vars.Items == nil then OctoToDo_DB_Vars.Items = true end
		if OctoToDo_DB_Vars.ItemsShowAllways == nil then OctoToDo_DB_Vars.ItemsShowAllways = false end
		if OctoToDo_DB_Vars.ItemsUsable == nil then OctoToDo_DB_Vars.ItemsUsable = false end
		if OctoToDo_DB_Vars.LastUpdate == nil then OctoToDo_DB_Vars.LastUpdate = true end
		if OctoToDo_DB_Vars.LevelToShow == nil then OctoToDo_DB_Vars.LevelToShow = 1 end
		if OctoToDo_DB_Vars.LevelToShowMAX == nil then OctoToDo_DB_Vars.LevelToShowMAX = E.currentMaxLevel end
		if OctoToDo_DB_Vars.LootFrame == nil then OctoToDo_DB_Vars.LootFrame = true end
		if OctoToDo_DB_Vars.MajorKeyflames == nil then OctoToDo_DB_Vars.MajorKeyflames = true end
		if OctoToDo_DB_Vars.MinorKeyflames == nil then OctoToDo_DB_Vars.MinorKeyflames = true end
		if OctoToDo_DB_Vars.MP_MythicKeystone == nil then OctoToDo_DB_Vars.MP_MythicKeystone = true end
		if OctoToDo_DB_Vars.prefix == nil then OctoToDo_DB_Vars.prefix = 1 end
		if OctoToDo_DB_Vars.Quests == nil then OctoToDo_DB_Vars.Quests = true end
		if OctoToDo_DB_Vars.QuestsShowAllways == nil then OctoToDo_DB_Vars.QuestsShowAllways = false end
		if OctoToDo_DB_Vars.Reputations == nil then OctoToDo_DB_Vars.Reputations = true end
		if OctoToDo_DB_Vars.ReputationsShowAllways == nil then OctoToDo_DB_Vars.ReputationsShowAllways = false end
		if OctoToDo_DB_Vars.ResetAllChars == nil then OctoToDo_DB_Vars.ResetAllChars = true end
		if OctoToDo_DB_Vars.RunedHarbingerCrest == nil then OctoToDo_DB_Vars.RunedHarbingerCrest = true end
		if OctoToDo_DB_Vars.ShowIDS == nil then OctoToDo_DB_Vars.ShowIDS = true end
		if OctoToDo_DB_Vars.SpeedFrame == nil then OctoToDo_DB_Vars.SpeedFrame = {} end
		if OctoToDo_DB_Vars.SpeedFrame.Shown == nil then OctoToDo_DB_Vars.SpeedFrame.Shown = true end
		if OctoToDo_DB_Vars.SpeedFrame.point == nil then OctoToDo_DB_Vars.SpeedFrame.point = "BOTTOM" end
		if OctoToDo_DB_Vars.SpeedFrame.relativePoint == nil then OctoToDo_DB_Vars.SpeedFrame.relativePoint = "BOTTOM" end
		if OctoToDo_DB_Vars.SpeedFrame.xOfs == nil then OctoToDo_DB_Vars.SpeedFrame.xOfs = 129 end
		if OctoToDo_DB_Vars.SpeedFrame.yOfs == nil then OctoToDo_DB_Vars.SpeedFrame.yOfs = 67 end
		if OctoToDo_DB_Vars.PosFrame == nil then OctoToDo_DB_Vars.PosFrame = {} end
		if OctoToDo_DB_Vars.PosFrame.Shown == nil then OctoToDo_DB_Vars.PosFrame.Shown = true end
		if OctoToDo_DB_Vars.PosFrame.point == nil then OctoToDo_DB_Vars.PosFrame.point = "BOTTOM" end
		if OctoToDo_DB_Vars.PosFrame.relativePoint == nil then OctoToDo_DB_Vars.PosFrame.relativePoint = "BOTTOM" end
		if OctoToDo_DB_Vars.PosFrame.xOfs == nil then OctoToDo_DB_Vars.PosFrame.xOfs = 129 end
		if OctoToDo_DB_Vars.PosFrame.yOfs == nil then OctoToDo_DB_Vars.PosFrame.yOfs = 67 end
		if OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag == nil then OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = false end
		if OctoToDo_DB_Vars.ShowOnlyCurrentServer == nil then OctoToDo_DB_Vars.ShowOnlyCurrentServer = true end
		if OctoToDo_DB_Vars.ShowTime70 == nil then OctoToDo_DB_Vars.ShowTime70 = true end
		if OctoToDo_DB_Vars.SORTING == nil then OctoToDo_DB_Vars.SORTING = true end
		if OctoToDo_DB_Vars.StaticPopup1Button1 == nil then OctoToDo_DB_Vars.StaticPopup1Button1 = true end
		if OctoToDo_DB_Vars.TalentTreeTweaks == nil then OctoToDo_DB_Vars.TalentTreeTweaks = true end
		if OctoToDo_DB_Vars.TalentTreeTweaks_Alpha == nil then OctoToDo_DB_Vars.TalentTreeTweaks_Alpha = 1 end
		if OctoToDo_DB_Vars.TalentTreeTweaks_Scale == nil then OctoToDo_DB_Vars.TalentTreeTweaks_Scale = 1 end
		if OctoToDo_DB_Vars.Timewalk == nil then OctoToDo_DB_Vars.Timewalk = true end
		if OctoToDo_DB_Vars.TWW_Delve_Weekly == nil then OctoToDo_DB_Vars.TWW_Delve_Weekly = true end
		if OctoToDo_DB_Vars.TWW_DungeonQuest_Weekly == nil then OctoToDo_DB_Vars.TWW_DungeonQuest_Weekly = true end
		if OctoToDo_DB_Vars.WorldBoss_Weekly == nil then OctoToDo_DB_Vars.WorldBoss_Weekly = true end
		if OctoToDo_DB_Vars.UIErrorsFramePosition == nil then OctoToDo_DB_Vars.UIErrorsFramePosition = true end
		if OctoToDo_DB_Vars.WasOnline == nil then OctoToDo_DB_Vars.WasOnline = true end
		if OctoToDo_DB_Vars.WeatheredHarbingerCrest == nil then OctoToDo_DB_Vars.WeatheredHarbingerCrest = true end

		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------




	if OctoToDo_AddonsManager == nil then OctoToDo_AddonsManager = {} end
	if OctoToDo_AddonsManager.collapsedAddons == nil then OctoToDo_AddonsManager.collapsedAddons = {} end
	if OctoToDo_AddonsManager.profiles == nil then OctoToDo_AddonsManager.profiles = {} end
	if OctoToDo_AddonsManager.profiles.forceload == nil then OctoToDo_AddonsManager.profiles.forceload = {[GlobalAddonName] = true,} end
	if OctoToDo_AddonsManager.config == nil then OctoToDo_AddonsManager.config = {} end
	if OctoToDo_AddonsManager.config.defaultAddonList == nil then OctoToDo_AddonsManager.config.defaultAddonList = false end
	if OctoToDo_AddonsManager.config.showOnlyLoaded == nil then OctoToDo_AddonsManager.config.showOnlyLoaded = false end
	if OctoToDo_AddonsManager.config.fullName == nil then OctoToDo_AddonsManager.config.fullName = false end
	if OctoToDo_AddonsManager.config.showIcons == nil then OctoToDo_AddonsManager.config.showIcons = false end
	if OctoToDo_AddonsManager.config.showIconsQuestionMark == nil then OctoToDo_AddonsManager.config.showIconsQuestionMark = true end
	if OctoToDo_AddonsManager.config.showVersion == nil then OctoToDo_AddonsManager.config.showVersion = false end
	if OctoToDo_AddonsManager.config.showIndex == nil then OctoToDo_AddonsManager.config.showIndex = false end
	if OctoToDo_AddonsManager.config.minimaphide == nil then OctoToDo_AddonsManager.config.minimaphide = false end
	if OctoToDo_AddonsManager.config.hookMenuButton == nil then OctoToDo_AddonsManager.config.hookMenuButton = false end
	if OctoToDo_AddonsManager.config.sortingCpu == nil then OctoToDo_AddonsManager.config.sortingCpu = false end
	if OctoToDo_AddonsManager.config.profilingcpuShowCurrent == nil then OctoToDo_AddonsManager.config.profilingcpuShowCurrent = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowEncounter == nil then OctoToDo_AddonsManager.config.profilingcpuShowEncounter = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowPeak == nil then OctoToDo_AddonsManager.config.profilingcpuShowPeak = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowAverage == nil then OctoToDo_AddonsManager.config.profilingcpuShowAverage = true end
	if OctoToDo_AddonsManager.config.profilingcpuUpdate == nil then OctoToDo_AddonsManager.config.profilingcpuUpdate = 0 end
	if OctoToDo_AddonsManager.config.localizeCategoryName == nil then OctoToDo_AddonsManager.config.localizeCategoryName = true end
	if OctoToDo_AddonsManager.config.showVersions == nil then OctoToDo_AddonsManager.config.showVersions = true end
	if OctoToDo_AddonsManager.config.autofocusSearch == nil then OctoToDo_AddonsManager.config.autofocusSearch = true end
	if OctoToDo_AddonsManager.config.sorting == nil then OctoToDo_AddonsManager.config.sorting = "title" end
	if OctoToDo_AddonsManager.config.showSecureAddons == nil then OctoToDo_AddonsManager.config.showSecureAddons = true end
	if OctoToDo_AddonsManager.config.addonListStyle == nil then OctoToDo_AddonsManager.config.addonListStyle = "tree" end
	if OctoToDo_AddonsManager.config.showTocXCategory == nil then OctoToDo_AddonsManager.config.showTocXCategory = true end
	if OctoToDo_AddonsManager.config.showTocCategory == nil then OctoToDo_AddonsManager.config.showTocCategory = true end
	if OctoToDo_AddonsManager.config.showMemoryInBrokerTtp == nil then OctoToDo_AddonsManager.config.showMemoryInBrokerTtp = true end
	if OctoToDo_AddonsManager.isCategoryFrameVisible == nil then OctoToDo_AddonsManager.isCategoryFrameVisible = true end
	if OctoToDo_AddonsManager.lock == nil then OctoToDo_AddonsManager.lock = {} end
	if OctoToDo_AddonsManager.lock.addons == nil then OctoToDo_AddonsManager.lock.addons = {} end
	if OctoToDo_AddonsManager.lock.addons[E.GlobalAddonName] == nil then OctoToDo_AddonsManager.lock.addons[E.GlobalAddonName] = true end



		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------

	if OctoToDo_OCTOREP == nil then OctoToDo_OCTOREP = {} end
	if OctoToDo_OCTOREP.TrackedRepID == nil then OctoToDo_OCTOREP.TrackedRepID = 369 end


		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame_WTF:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
		----------------------------------------------------------------
		if OctoToDo_DB_Vars.CVar then
			E.LoadCVars()
		end
		----------------------------------------------------------------
	end
end