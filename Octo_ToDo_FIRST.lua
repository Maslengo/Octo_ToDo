
function Octo_ToDo_FIRST_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") and not InCombatLockdown() then
		-- НАЧАЛО
		if OctoPlayer == nil then OctoPlayer = {} end
		if Octo_ToDo_DB_Config == nil then Octo_ToDo_DB_Config = {} end
		if Octo_ToDo_DB_Players == nil then Octo_ToDo_DB_Players = {} end
		if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_ToDo_DB_Artifact == nil then Octo_ToDo_DB_Artifact = {} end
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
		if Octo_ToDo_DB_Players_LIST == nil then Octo_ToDo_DB_Players_LIST = {} end
		if Octo_ToDo_Movies == nil then Octo_ToDo_Movies = {} end
		if Octo_ToDo_DB_Config.CurrencyDB == nil then Octo_ToDo_DB_Config.CurrencyDB = {} end
		if Octo_ToDo_DB_Config.ItemDB == nil then Octo_ToDo_DB_Config.ItemDB = {} end
		if Octo_ToDo_DB_Config.QuestsDB == nil then Octo_ToDo_DB_Config.QuestsDB = {} end
		if Octo_ToDo_DB_Config.ReputationDB == nil then Octo_ToDo_DB_Config.ReputationDB = {} end
		if Octo_ToDo_DB_Other.AccountMoney == nil then Octo_ToDo_DB_Other.AccountMoney = {} end
		if Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] == nil then Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] = 0 end
		if Octo_ToDo_DB_Other.CVar == nil then Octo_ToDo_DB_Other.CVar = {} end
		if Octo_ToDo_DB_Other.Holiday == nil then Octo_ToDo_DB_Other.Holiday = {} end
		if Octo_ToDo_DB_Other.Holiday.Active == nil then Octo_ToDo_DB_Other.Holiday.Active = {} end
		if Octo_ToDo_DB_Other.Holiday.Collect == nil then Octo_ToDo_DB_Other.Holiday.Collect = {} end
		if Octo_ToDo_DB_Other.Items == nil then Octo_ToDo_DB_Other.Items = {} end
		if Octo_ToDo_DB_Other.Items.Consumable == nil then Octo_ToDo_DB_Other.Items.Consumable = {} end
		if Octo_ToDo_DB_Other.LFGInstance == nil then Octo_ToDo_DB_Other.LFGInstance = {} end
		if Octo_ToDo_DB_Vars.config == nil then Octo_ToDo_DB_Vars.config = {} end
		if Octo_ToDo_DB_Vars.config.curWidthCentral == nil then Octo_ToDo_DB_Vars.config.curWidthCentral = 90 end
		if Octo_ToDo_DB_Vars.config.curWidthCentral ~= nil then E.curWidthCentral = Octo_ToDo_DB_Vars.config.curWidthCentral end
		if Octo_ToDo_DB_Vars.config.Addon_Height == nil then Octo_ToDo_DB_Vars.config.Addon_Height = 600 end
		if Octo_ToDo_DB_Vars.config.Addon_Height ~= nil then E.Addon_Height = Octo_ToDo_DB_Vars.config.Addon_Height end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST ~= nil then E.Octo_debug_BUTTONS_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND ~= nil then E.Octo_debug_BUTTONS_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST ~= nil then E.Octo_debug_Event_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND ~= nil then E.Octo_debug_Event_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST = false end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST ~= nil then E.Octo_debug_Function_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND = false end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND ~= nil then E.Octo_debug_Function_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND end
		if Octo_ToDo_DB_Vars.config.curHeight == nil then Octo_ToDo_DB_Vars.config.curHeight = 20 end
		if Octo_ToDo_DB_Vars.config.curHeight ~= nil then E.curHeight = Octo_ToDo_DB_Vars.config.curHeight end
		if Octo_ToDo_DB_Vars.config.curWidthTitle == nil then Octo_ToDo_DB_Vars.config.curWidthTitle = 200 end
		if Octo_ToDo_DB_Vars.config.curWidthTitle ~= nil then E.curWidthTitle = Octo_ToDo_DB_Vars.config.curWidthTitle end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement == nil then Octo_ToDo_DB_Vars.config.curWidthTitleAchievement = 300 end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement ~= nil then E.curWidthTitleAchievement = Octo_ToDo_DB_Vars.config.curWidthTitleAchievement end
		if Octo_ToDo_DB_Vars.config.Achievements == nil then Octo_ToDo_DB_Vars.config.Achievements = true end
		if Octo_ToDo_DB_Vars.config.AchievementShowCompleted == nil then Octo_ToDo_DB_Vars.config.AchievementShowCompleted = true end
		if Octo_ToDo_DB_Vars.config.AchievementToShow == nil then Octo_ToDo_DB_Vars.config.AchievementToShow = 92 end
		if Octo_ToDo_DB_Vars.config.AdditionalButtons == nil then Octo_ToDo_DB_Vars.config.AdditionalButtons = true end
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == nil then Octo_ToDo_DB_Vars.config.AidingtheAccord = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsCasual == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsCasual = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsRAID == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsRAID = true end
		if Octo_ToDo_DB_Vars.config.AntiqueBronzeBullion == nil then Octo_ToDo_DB_Vars.config.AntiqueBronzeBullion = true end
		if Octo_ToDo_DB_Vars.config.Auto_ChatClearing == nil then Octo_ToDo_DB_Vars.config.Auto_ChatClearing = false end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler = true end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip = true end
		if Octo_ToDo_DB_Vars.config.Auto_Gossip == nil then Octo_ToDo_DB_Vars.config.Auto_Gossip = true end
		if Octo_ToDo_DB_Vars.config.Auto_Screenshot == nil then Octo_ToDo_DB_Vars.config.Auto_Screenshot = true end
		if Octo_ToDo_DB_Vars.config.AutoGossip == nil then Octo_ToDo_DB_Vars.config.AutoGossip = true end
		if Octo_ToDo_DB_Vars.config.AutoOpen == nil then Octo_ToDo_DB_Vars.config.AutoOpen = true end
		if Octo_ToDo_DB_Vars.config.AutoRepair == nil then Octo_ToDo_DB_Vars.config.AutoRepair = true end
		if Octo_ToDo_DB_Vars.config.AutoSellGrey == nil then Octo_ToDo_DB_Vars.config.AutoSellGrey = true end
		if Octo_ToDo_DB_Vars.config.AutoTurnQuests == nil then Octo_ToDo_DB_Vars.config.AutoTurnQuests = true end
		if Octo_ToDo_DB_Vars.config.BeledarCycle == nil then Octo_ToDo_DB_Vars.config.BeledarCycle = true end
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.CatalystCharges == nil then Octo_ToDo_DB_Vars.config.CatalystCharges = true end
		if Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame == nil then Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame = true end
		if Octo_ToDo_DB_Vars.config.CinematicCanceler == nil then Octo_ToDo_DB_Vars.config.CinematicCanceler = true end
		if Octo_ToDo_DB_Vars.config.CommunityFeast == nil then Octo_ToDo_DB_Vars.config.CommunityFeast = true end
		if Octo_ToDo_DB_Vars.config.Crests_Heroic == nil then Octo_ToDo_DB_Vars.config.Crests_Heroic = true end
		if Octo_ToDo_DB_Vars.config.Crests_LFR == nil then Octo_ToDo_DB_Vars.config.Crests_LFR = true end
		if Octo_ToDo_DB_Vars.config.Crests_Mythic == nil then Octo_ToDo_DB_Vars.config.Crests_Mythic = true end
		if Octo_ToDo_DB_Vars.config.Crests_Normal == nil then Octo_ToDo_DB_Vars.config.Crests_Normal = true end
		if Octo_ToDo_DB_Vars.config.Currency == nil then Octo_ToDo_DB_Vars.config.Currency = true end
		if Octo_ToDo_DB_Vars.config.CurrencyShowAllways == nil then Octo_ToDo_DB_Vars.config.CurrencyShowAllways = false end
		if Octo_ToDo_DB_Vars.config.CVar == nil then Octo_ToDo_DB_Vars.config.CVar = true end
		if Octo_ToDo_DB_Vars.config.DilatedTimePod == nil then Octo_ToDo_DB_Vars.config.DilatedTimePod = true end
		if Octo_ToDo_DB_Vars.config.DreamsurgeCoalescence == nil then Octo_ToDo_DB_Vars.config.DreamsurgeCoalescence = true end
		if Octo_ToDo_DB_Vars.config.DreamsurgeCocoon == nil then Octo_ToDo_DB_Vars.config.DreamsurgeCocoon = true end
		if Octo_ToDo_DB_Vars.config.Dreamsurges == nil then Octo_ToDo_DB_Vars.config.Dreamsurges = true end
		if Octo_ToDo_DB_Vars.config.Dungeons == nil then Octo_ToDo_DB_Vars.config.Dungeons = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_DreamWardens == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_DreamWardens = true end -- REPUTATION
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Rares == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Rares = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Superbloom == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Superbloom = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_WB == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_WB = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamAWorthyAllyDreamWardens == nil then Octo_ToDo_DB_Vars.config.EmeraldDreamAWorthyAllyDreamWardens = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamBloomingDreamseeds == nil then Octo_ToDo_DB_Vars.config.EmeraldDreamBloomingDreamseeds = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamDreamsUnified == nil then Octo_ToDo_DB_Vars.config.EmeraldDreamDreamsUnified = true end
		if Octo_ToDo_DB_Vars.config.EncapsulatedDestiny == nil then Octo_ToDo_DB_Vars.config.EncapsulatedDestiny = true end
		if Octo_ToDo_DB_Vars.config.Event == nil then Octo_ToDo_DB_Vars.config.Event = true end
		if Octo_ToDo_DB_Vars.config.ExpansionToShow == nil then Octo_ToDo_DB_Vars.config.ExpansionToShow = LibOctopussy:func_CurrentExpansion() end
		if Octo_ToDo_DB_Vars.config.FieldOfView == nil then Octo_ToDo_DB_Vars.config.FieldOfView = false end
		if Octo_ToDo_DB_Vars.config.Flightstones == nil then Octo_ToDo_DB_Vars.config.Flightstones = true end
		if Octo_ToDo_DB_Vars.config.FoV_bottom == nil then Octo_ToDo_DB_Vars.config.FoV_bottom = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_left == nil then Octo_ToDo_DB_Vars.config.FoV_left = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_right == nil then Octo_ToDo_DB_Vars.config.FoV_right = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_top == nil then Octo_ToDo_DB_Vars.config.FoV_top = 0 end
		if Octo_ToDo_DB_Vars.config.FrameScale == nil then Octo_ToDo_DB_Vars.config.FrameScale = 1 end
		if Octo_ToDo_DB_Vars.config.GameMenuFrameScale == nil then Octo_ToDo_DB_Vars.config.GameMenuFrameScale = .8 end
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.GildedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.GlobalFadePersist == nil then Octo_ToDo_DB_Vars.config.GlobalFadePersist = true end
		if Octo_ToDo_DB_Vars.config.glowColor == nil then Octo_ToDo_DB_Vars.config.glowColor = 1 end
		if Octo_ToDo_DB_Vars.config.glowType == nil then Octo_ToDo_DB_Vars.config.glowType = 1 end
		if Octo_ToDo_DB_Vars.config.Gold == nil then Octo_ToDo_DB_Vars.config.Gold = true end
		if Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI == nil then Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI = true end
		if Octo_ToDo_DB_Vars.config.Hide_Boss_Banner == nil then Octo_ToDo_DB_Vars.config.Hide_Boss_Banner = true end
		if Octo_ToDo_DB_Vars.config.Hide_Covenant == nil then Octo_ToDo_DB_Vars.config.Hide_Covenant = true end
		if Octo_ToDo_DB_Vars.config.Hide_Error_Messages == nil then Octo_ToDo_DB_Vars.config.Hide_Error_Messages = true end
		if Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance == nil then Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance = true end
		if Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar == nil then Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar = true end
		if Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame == nil then Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Zone_Text == nil then Octo_ToDo_DB_Vars.config.Hide_Zone_Text = true end
		if Octo_ToDo_DB_Vars.config.Holiday == nil then Octo_ToDo_DB_Vars.config.Holiday = true end
		if Octo_ToDo_DB_Vars.config.InputDelete == nil then Octo_ToDo_DB_Vars.config.InputDelete = true end
		if Octo_ToDo_DB_Vars.config.ItemLevel == nil then Octo_ToDo_DB_Vars.config.ItemLevel = true end
		if Octo_ToDo_DB_Vars.config.itemLevelToShow == nil then Octo_ToDo_DB_Vars.config.itemLevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.Items == nil then Octo_ToDo_DB_Vars.config.Items = true end
		if Octo_ToDo_DB_Vars.config.ItemsDelete == nil then Octo_ToDo_DB_Vars.config.ItemsDelete = false end
		if Octo_ToDo_DB_Vars.config.ItemsShowAllways == nil then Octo_ToDo_DB_Vars.config.ItemsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.ItemsUsable == nil then Octo_ToDo_DB_Vars.config.ItemsUsable = false end
		if Octo_ToDo_DB_Vars.config.LastUpdate == nil then Octo_ToDo_DB_Vars.config.LastUpdate = true end
		if Octo_ToDo_DB_Vars.config.LevelToShow == nil then Octo_ToDo_DB_Vars.config.LevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.LevelToShow == nil then Octo_ToDo_DB_Vars.config.LevelToShow = 60 end
		if Octo_ToDo_DB_Vars.config.LevelToShowMAX == nil then Octo_ToDo_DB_Vars.config.LevelToShowMAX = 120 end
		if Octo_ToDo_DB_Vars.config.LevelToShowMAX == nil then Octo_ToDo_DB_Vars.config.LevelToShowMAX = 70 end
		if Octo_ToDo_DB_Vars.config.LootFrame == nil then Octo_ToDo_DB_Vars.config.LootFrame = true end
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == nil then Octo_ToDo_DB_Vars.config.MajorKeyflames = true end
		if Octo_ToDo_DB_Vars.config.Minecraft == nil then Octo_ToDo_DB_Vars.config.Minecraft = false end
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == nil then Octo_ToDo_DB_Vars.config.MinorKeyflames = true end
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == nil then Octo_ToDo_DB_Vars.config.MP_MythicKeystone = true end
		if Octo_ToDo_DB_Vars.config.ParacausalFlakes == nil then Octo_ToDo_DB_Vars.config.ParacausalFlakes = true end
		if Octo_ToDo_DB_Vars.config.PortalsButtons == nil then Octo_ToDo_DB_Vars.config.PortalsButtons = true end
		if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == nil then Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent = false end
		if Octo_ToDo_DB_Vars.config.prefix == nil then Octo_ToDo_DB_Vars.config.prefix = 1 end
		if Octo_ToDo_DB_Vars.config.Professions == nil then Octo_ToDo_DB_Vars.config.Professions = true end
		if Octo_ToDo_DB_Vars.config.Quests == nil then Octo_ToDo_DB_Vars.config.Quests = true end
		if Octo_ToDo_DB_Vars.config.QuestsShowAllways == nil then Octo_ToDo_DB_Vars.config.QuestsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.Reputations == nil then Octo_ToDo_DB_Vars.config.Reputations = true end
		if Octo_ToDo_DB_Vars.config.ReputationsShowAllways == nil then Octo_ToDo_DB_Vars.config.ReputationsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.ResearchersUnderFire == nil then Octo_ToDo_DB_Vars.config.ResearchersUnderFire = true end
		if Octo_ToDo_DB_Vars.config.ResearchersUnderFire_Weekly == nil then Octo_ToDo_DB_Vars.config.ResearchersUnderFire_Weekly = true end
		if Octo_ToDo_DB_Vars.config.ResetAllChars == nil then Octo_ToDo_DB_Vars.config.ResetAllChars = true end
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.RunedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.ShowIDS == nil then Octo_ToDo_DB_Vars.config.ShowIDS = true end
		if Octo_ToDo_DB_Vars.config.SellFrame == nil then Octo_ToDo_DB_Vars.config.SellFrame = true end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag = true end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm = true end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = true end
		if Octo_ToDo_DB_Vars.config.ShowTime70 == nil then Octo_ToDo_DB_Vars.config.ShowTime70 = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeAll == nil then Octo_ToDo_DB_Vars.config.ShowTimeAll = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == nil then Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL = true end
		if Octo_ToDo_DB_Vars.config.ShowTotalMoney == nil then Octo_ToDo_DB_Vars.config.ShowTotalMoney = true end
		if Octo_ToDo_DB_Vars.config.SORTING == nil then Octo_ToDo_DB_Vars.config.SORTING = true end
		if Octo_ToDo_DB_Vars.config.SparkofAwakening == nil then Octo_ToDo_DB_Vars.config.SparkofAwakening = true end
		if Octo_ToDo_DB_Vars.config.SplinteredSparkofAwakening == nil then Octo_ToDo_DB_Vars.config.SplinteredSparkofAwakening = true end
		if Octo_ToDo_DB_Vars.config.StaticPopup1Button1 == nil then Octo_ToDo_DB_Vars.config.StaticPopup1Button1 = true end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks = true end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha = 1 end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale = 1 end
		if Octo_ToDo_DB_Vars.config.TheBigDig == nil then Octo_ToDo_DB_Vars.config.TheBigDig = true end
		if Octo_ToDo_DB_Vars.config.TheBigDig_REPUTATION == nil then Octo_ToDo_DB_Vars.config.TheBigDig_REPUTATION = true end
		if Octo_ToDo_DB_Vars.config.THIRD == nil then Octo_ToDo_DB_Vars.config.THIRD = true end
		if Octo_ToDo_DB_Vars.config.TimeRift == nil then Octo_ToDo_DB_Vars.config.TimeRift = true end
		if Octo_ToDo_DB_Vars.config.Timewalk == nil then Octo_ToDo_DB_Vars.config.Timewalk = true end
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly = true end
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition == nil then Octo_ToDo_DB_Vars.config.UIErrorsFramePosition = true end
		if Octo_ToDo_DB_Vars.config.WasOnline == nil then Octo_ToDo_DB_Vars.config.WasOnline = true end
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest = true end
		-- КОНЕЦ
		for classFilename, v in pairs(E.OctoTable_CLASS_ARTIFACT_DATA) do
			for itemID in pairs(E.OctoTable_CLASS_ARTIFACT_DATA[classFilename]) do
				local artifactData = E.OctoTable_CLASS_ARTIFACT_DATA[classFilename][itemID]
				-- local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
				for index, data in pairs(artifactData.sets) do
					local appearanceID = data.appearanceID
					local sourceID = data.sourceID
					local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
					local visualID = sourceInfo.visualID
					if Octo_ToDo_DB_Artifact == nil then
						Octo_ToDo_DB_Artifact = {}
					end
					if Octo_ToDo_DB_Artifact[classFilename] == nil then
						Octo_ToDo_DB_Artifact[classFilename] = {}
					end
					if Octo_ToDo_DB_Artifact[classFilename][itemID] == nil then
						Octo_ToDo_DB_Artifact[classFilename][itemID] = {}
					end
					if Octo_ToDo_DB_Artifact[classFilename][itemID][visualID] == nil then
						Octo_ToDo_DB_Artifact[classFilename][itemID][visualID] = {}
					end
					setmetatable(Octo_ToDo_DB_Artifact[classFilename][itemID][visualID], Meta_Table_0)
				end
			end
		end
		ConcatAtStart()
		O_otrisovka_FIRST()
		for i, func in next, (E.Modules) do
			func()
		end
		local MinimapName = GlobalAddonName.."Octo_ToDo_FIRST_Minimap"
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.AddonTexture_1,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							main_frame_toggle()
						end
						if OctoToDo_SECOND_MainFramePIZDA and OctoToDo_SECOND_MainFramePIZDA:IsShown() then
							OctoToDo_SECOND_MainFramePIZDA:Hide()
						end
					else
						if OctoToDo_FIRST_MainFramePIZDA and OctoToDo_FIRST_MainFramePIZDA:IsShown() then
							OctoToDo_FIRST_MainFramePIZDA:Hide()
						end
						if OctoToDo_SECOND_MainFramePIZDA and OctoToDo_SECOND_MainFramePIZDA:IsShown() then
							OctoToDo_SECOND_MainFramePIZDA:Hide()
						end
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(E.AddonTitle, true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, LibOctopussy:func_Gradient(GlobalAddonName, E.Addon_Left_Color, E.Addon_Right_Color).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_FIRST = Octo_ToDo_DB_Vars.minimap_FIRST or {}
		Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos = Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos or 244
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(E.AddonVersion)
		LibDBIcon:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_FIRST)
		LibDBIcon:Show(MinimapName)
	end
	if (event == "PLAYER_LOGIN") and not InCombatLockdown() then
		C_WowTokenPublic.UpdateMarketPrice()
		Octo_ToDo_DB_Players[curGUID] = Octo_ToDo_DB_Players[curGUID] or {}
		for GUID, CharInfo in next, (Octo_ToDo_DB_Players) do
			checkCharInfo(CharInfo)
		end
		Collect_ALL_PlayerInfo()
		Collect_All_Currency()
		Collect_ALL_GreatVault()
		Collect_ALL_ItemLevel()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_ALL_LoginTime()
		Collect_ALL_Mail()
		Collect_ALL_MoneyOnLogin()
		Collect_ALL_MoneyUpdate()
		Collect_All_Professions()
		Collect_All_Quests()
		Collect_All_Reputations()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_All_journalInstance()
		Collect_Player_Level()
		Collect_WarMode()
		RequestTimePlayed()
		Octo_ToDo_FIRST_CreateAltFrame()
		Hide_trash_frames()
	end
	if (event == "PLAYER_TARGET_CHANGED") then
		Hide_trash_frames()
	end
	if (event == "SHOW_SUBSCRIPTION_INTERSTITIAL") then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			ChatFrame1:AddMessage(LibOctopussy:func_Gradient("Hide trash frames: ", E.Addon_Left_Color, E.Addon_Right_Color).."SubscriptionInterstitialFrame")
		end
	end
	if (event == "MAJOR_FACTION_RENOWN_LEVEL_CHANGED" or event == "MAJOR_FACTION_UNLOCKED") then
		if MajorFactionsRenownToast then
			MajorFactionsRenownToast:SetScript("OnEvent", nil)
			ChatFrame1:AddMessage(LibOctopussy:func_Gradient("Hide trash frames: ", E.Addon_Left_Color, E.Addon_Right_Color).."MajorFactionsRenownToast")
		end
	end
	if (event == "SKILL_LINES_CHANGED") and not InCombatLockdown() then
		Collect_All_Professions()
	end
	if event == "PLAYER_XP_UPDATE" then
		Collect_Player_Level()
	end
	if (event == "QUEST_ACCEPTED" or event == "QUEST_COMPLETE" or event == "QUEST_FINISHED" or event == "QUEST_LOG_UPDATE" or event == "QUEST_REMOVED" or event == "QUEST_TURNED_IN" or event == "QUEST_LOOT_RECEIVED") then
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
		Hide_trash_frames()
	end
	if (event == "PLAYER_MONEY" or event == "ACCOUNT_MONEY") and not InCombatLockdown() then
		Collect_ALL_MoneyUpdate()
	end
	if (event == "CURRENCY_DISPLAY_UPDATE") and not InCombatLockdown() then
		Collect_All_Currency()
		Hide_trash_frames()
	end
	if (event == "PLAYER_EQUIPMENT_CHANGED") and not InCombatLockdown() then
		Collect_ALL_ItemLevel()
	end
	if (event == "PLAYER_LEAVING_WORLD") and not InCombatLockdown() then
		Collect_ALL_GreatVault()
		Collect_ALL_LoginTime()
	end
	if (event == "PLAYER_LOGIN" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "AZERITE_ITEM_EXPERIENCE_CHANGED") and not InCombatLockdown() then
		OLD_Collect_BfA_Azerite()
		OLD_Collect_BfA_Cloaklvl()
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGOUT") and not InCombatLockdown() then
		OLD_Collect_ALL_PVPRaitings()
	end
	if (event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
		OLD_Collect_All_Legion_Transmoge()
	end
	if (event == "PLAYER_ENTERING_WORLD"
		or event == "CALENDAR_OPEN_EVENT"
		or event == "LFG_COMPLETION_REWARD"
		or event == "LFG_UPDATE_RANDOM_INFO"
		or event == "CALENDAR_UPDATE_EVENT_LIST"
		or event == "CALENDAR_UPDATE_EVENT"
		or event == "CALENDAR_CLOSE_EVENT"
		or event == "CALENDAR_NEW_EVENT"
	) and not InCombatLockdown() then
		OLD_Collect_All_Holiday()
	end
	if (event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
		Collect_ALL_LoginTime()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_All_journalInstance()
		Hide_trash_frames()
		Collect_All_PlayerDurability()
		OLD_Collect_All_Legion_Transmoge()
		-- OLD_Collect_All_Legion_TransmogeNEW()
		GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or .8)
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "BN_FRIEND_LIST_SIZE_CHANGED" or event == "BN_FRIEND_INFO_CHANGED" or event == "BN_FRIEND_INVITE_LIST_INITIALIZED" or event == "BN_FRIEND_INVITE_ADDED" or event == "BN_FRIEND_INVITE_REMOVED" or event == "BN_CUSTOM_MESSAGE_CHANGED" or event == "BN_CUSTOM_MESSAGE_LOADED" or event == "BN_BLOCK_LIST_UPDATED" or event == "BN_CONNECTED" or event == "BN_DISCONNECTED" or event == "BN_INFO_CHANGED" or event == "BN_REQUEST_FOF_SUCCEEDED" or event == "BN_DISCONNECTED") then
		TryToLoadBattleTag()
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "COVENANT_CHOSEN" or event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED") and not InCombatLockdown() then
		Collect_All_Covenant()
	end
	-- if event == "COMBAT_LOG_EVENT_UNFILTERED" then
	-- Octo_ToDo_FIRST_CreateAltFrame()
	-- end
	if (event == "PLAYER_DEAD" or event == "UPDATE_INVENTORY_DURABILITY") and not InCombatLockdown() then
		Collect_All_PlayerDurability()
	end
	if (event == "PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED") and not InCombatLockdown() then
		Collect_ALL_ItemsInBag()
	end
	if (event == "BAG_UPDATE_DELAYED" and BankFrame:IsShown() ) and not InCombatLockdown() then
		Collect_ALL_ItemsInBag()
	end
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "ITEM_COUNT_CHANGED" or event == "MAIL_SEND_SUCCESS") and not InCombatLockdown() then
		C_Timer.After(2, function()
				if not InCombatLockdown() then
					Collect_ALL_ItemsInBag()
				end
		end)
	end
	if (event == "PLAYER_SPECIALIZATION_CHANGED") and not InCombatLockdown() then
		Collect_ALL_PlayerInfo()
	end
	if (event == "HEARTHSTONE_BOUND" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
		Collect_ALL_Locations()
	end
	if (event == "SPELLS_CHANGED") and not InCombatLockdown() then
		C_Timer.After(2, function()
				Collect_WarMode()
		end)
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "MAIL_INBOX_UPDATE" or event == "MAIL_SHOW" or event == "UPDATE_PENDING_MAIL") and not InCombatLockdown() then
		Collect_ALL_Mail()
	end
	if event == "PLAYER_REGEN_DISABLED" or InCombatLockdown() then
		if OctoToDo_FIRST_MainFrame and OctoToDo_FIRST_MainFrame:IsShown() then
			OctoToDo_FIRST_MainFrame:Hide()
		end
	end
	if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM") and not InCombatLockdown() then
		LibOctopussy:func_PlaySoundFile_whisper(...)
	end
	if (event == "READY_CHECK") and not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
	if event == "ENCOUNTER_END" then
		C_Timer.After(1, function()
				Collect_All_journalInstance()
		end)
	end
	if event == "TIME_PLAYED_MSG" then
		Collect_Played(...)
	end
end
Octo_ToDo_FIRST_OnLoad()
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	debugprofilestart()
	if not InCombatLockdown() then
		main_frame_toggle()
	end
	ChatFrame1:AddMessage ("debug timer: "..LibOctopussy:func_Gradient(tostringall(debugprofilestop()), E.Addon_Left_Color, E.Addon_Right_Color).." ms.")
end
local editFrame, editBox
if interfaceVersion > 20000 then
	editFrame = CreateFrame("FRAME", GlobalAddonName.."EditFrame", UIParent, "MyAddonEditFrameTemplate")
	editFrame:ClearAllPoints()
	editFrame:SetPoint("TOPLEFT", (UIParent:GetWidth() - editFrame:GetWidth()) / 2, -100)
	editBox = editFrame.editFrame
end
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	ChatFrame1:AddMessage (LibOctopussy:func_Gradient("GSEARCH: ", E.Addon_Left_Color, E.Addon_Right_Color) .. msg)
	local str = ""
	local list = {}
	for i, n in next, (_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..LibOctopussy:func_Gradient(i, E.Addon_Left_Color, E.Addon_Right_Color).. " - ".. n .."\n"
		end
	end
	editBox:SetText(str)
	editFrame:Show()
end
SlashCmdList["RELOAD"] = LibOctopussy:ReloadUI()
SLASH_RELOAD1 = "/rl"
-- fpde(E.Movies)
SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function(msg)
	if not C_AddOns.IsAddOnLoaded("Blizzard_DebugTools") then C_AddOns.LoadAddOn("Blizzard_DebugTools") end
	local showHidden, showRegions, showAnchors = (msg == "true"), true, true
	FrameStackTooltip_Toggle(showHidden, showRegions, showAnchors)
end


