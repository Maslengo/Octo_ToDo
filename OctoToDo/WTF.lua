local GlobalAddonName, E = ...
local OctoToDo_EventFrame_WTF = CreateFrame("FRAME")
OctoToDo_EventFrame_WTF:Hide()


function OctoToDo_EventFrame_WTF:OctoToDo_DB_Levels()
	if OctoToDo_DB_Levels == nil then OctoToDo_DB_Levels = {} end
	if OctoToDo_DB_Levels[E.curGUID] == nil then OctoToDo_DB_Levels[E.curGUID] = {} end
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		----------------------------------------------------------------
		CharInfo.ReloadCount = CharInfo.ReloadCount or 0
		CharInfo.avgItemLevel = CharInfo.avgItemLevel or 1
		CharInfo.avgItemLevelEquipped = CharInfo.avgItemLevelEquipped or 1
		CharInfo.azeriteEXP = CharInfo.azeriteEXP or 0
		CharInfo.azeriteLVL = CharInfo.azeriteLVL or 0
		CharInfo.avgItemLevelPvp = CharInfo.avgItemLevelPvp or 1
		CharInfo.className = CharInfo.className or E.className
		CharInfo.classFilename = CharInfo.classFilename or E.classFilename
		CharInfo.GUID = CharInfo.GUID or GUID
		CharInfo.cloak_lvl = CharInfo.cloak_lvl or 0
		CharInfo.cloak_res = CharInfo.cloak_res or 0
		CharInfo.classId = CharInfo.classId or 1
		CharInfo.classColor = CharInfo.classColor or E.classColor
		CharInfo.curServer = CharInfo.curServer or E.curServer
		CharInfo.guildName = CharInfo.guildName or ""
		CharInfo.guildRankName = CharInfo.guildRankName or ""
		CharInfo.guildRankIndex = CharInfo.guildRankIndex or 0
		CharInfo.curServerShort = CharInfo.curServerShort or E.func_CurServerShort(E.curServer)
		CharInfo.Faction = CharInfo.Faction or "Horde"
		CharInfo.BattleTag = CharInfo.BattleTag or E.BattleTag
		CharInfo.BattleTagLocal = CharInfo.BattleTagLocal or E.BattleTagLocal
		CharInfo.IsPublicBuild = CharInfo.IsPublicBuild or E.IsPublicBuild
		CharInfo.Chromie_canEnter = CharInfo.Chromie_canEnter or false
		CharInfo.Chromie_UnitChromieTimeID = CharInfo.Chromie_UnitChromieTimeID or 0
		CharInfo.GameLimitedMode_IsActive = CharInfo.GameLimitedMode_IsActive or E.GameLimitedMode_IsActive
		CharInfo.buildVersion = CharInfo.buildVersion or E.buildVersion
		CharInfo.buildNumber = CharInfo.buildNumber or E.buildNumber
		CharInfo.buildDate = CharInfo.buildDate or E.buildDate
		CharInfo.interfaceVersion = CharInfo.interfaceVersion or E.interfaceVersion
		CharInfo.currentTier = CharInfo.currentTier or E.currentTier
		CharInfo.IsAccountSecured = CharInfo.IsAccountSecured or E.IsAccountSecured
		CharInfo.GetRestrictedAccountData_rLevel = CharInfo.GetRestrictedAccountData_rLevel or E.GetRestrictedAccountData_rLevel
		CharInfo.GetRestrictedAccountData_rMoney = CharInfo.GetRestrictedAccountData_rMoney or E.GetRestrictedAccountData_rMoney
		CharInfo.GetRestrictedAccountData_profCap = CharInfo.GetRestrictedAccountData_profCap or E.GetRestrictedAccountData_profCap
		CharInfo.IsTrialAccount = CharInfo.IsTrialAccount or E.IsTrialAccount
		CharInfo.IsVeteranTrialAccount = CharInfo.IsVeteranTrialAccount or E.IsVeteranTrialAccount
		CharInfo.PlayerDurability = CharInfo.PlayerDurability or 100
		CharInfo.maxNumQuestsCanAccept = CharInfo.maxNumQuestsCanAccept or 0
		CharInfo.Name = CharInfo.Name or E.curCharName
		CharInfo.numQuests = CharInfo.numQuests or 0
		CharInfo.RaceLocal = CharInfo.RaceLocal or 0
		CharInfo.RaceEnglish = CharInfo.RaceEnglish or 0
		CharInfo.raceID = CharInfo.raceID or 0
		CharInfo.classColorHex = CharInfo.classColorHex or E.classColorHexCurrent
		CharInfo.currentXP = CharInfo.currentXP or 0
		CharInfo.UnitXPMax = CharInfo.UnitXPMax or 0
		CharInfo.UnitXPPercent = CharInfo.UnitXPPercent or 0
		CharInfo.realTotalTime = CharInfo.realTotalTime or 0
		CharInfo.TodayTimePlayed = CharInfo.TodayTimePlayed or 0
		CharInfo.realLevelTime = CharInfo.realLevelTime or 0
		CharInfo.Possible_Anima = CharInfo.Possible_Anima or 0
		CharInfo.Possible_CatalogedResearch = CharInfo.Possible_CatalogedResearch or 0
		CharInfo.numShownEntries = CharInfo.numShownEntries or 0
		CharInfo.loginDate = CharInfo.loginDate or date("%d.%m.%Y %H:%M:%S")
		CharInfo.loginDay = CharInfo.loginDay or date("%d.%m.%Y")
		CharInfo.loginHour = CharInfo.loginHour or date("%H:%M")
		CharInfo.time = CharInfo.time or time()
		CharInfo.UnitLevel = CharInfo.UnitLevel or 1
		CharInfo.Money = CharInfo.Money or 0
		CharInfo.MoneyOnLogin = CharInfo.Money
		CharInfo.totalSlots = CharInfo.totalSlots or 0
		CharInfo.usedSlots = CharInfo.usedSlots or 0
		CharInfo.BindLocation = CharInfo.BindLocation or 0
		CharInfo.CurrentLocation = CharInfo.CurrentLocation or 0
		CharInfo.WarMode = CharInfo.WarMode or false
		CharInfo.CurrentKey = CharInfo.CurrentKey or 0
		CharInfo.CurrentKeyName = CharInfo.CurrentKeyName or 0
		CharInfo.CurrentKeyLevel = CharInfo.CurrentKeyLevel or 0
		CharInfo.hasMail = CharInfo.hasMail or false -- ОСТАВИТЬ
		CharInfo.levelCapped20 = CharInfo.levelCapped20 or false
		CharInfo.PlayerCanEarnExperience = CharInfo.PlayerCanEarnExperience or true
		CharInfo.needResetDaily = CharInfo.needResetDaily or false
		CharInfo.needResetWeekly = CharInfo.needResetWeekly or false
		CharInfo.needResetMonth = CharInfo.needResetMonth or false
		CharInfo.HasAvailableRewards = CharInfo.HasAvailableRewards or false
		CharInfo.isShownPLAYER = CharInfo.isShownPLAYER or true
		CharInfo.Chromie_name = CharInfo.Chromie_name or nil
		CharInfo.RIO_Score = CharInfo.RIO_Score or 0
		CharInfo.RIO_weeklyBest = CharInfo.RIO_weeklyBest or 0
		----------------------------------------------------------------
		if CharInfo.MASLENGO == nil then CharInfo.MASLENGO = {} end
		if CharInfo.MASLENGO.reputationFULL == nil then CharInfo.MASLENGO.reputationFULL = {} end
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			for i, v in ipairs(tbl) do
				CharInfo.MASLENGO.reputationFULL[v.id] = CharInfo.MASLENGO.reputationFULL[v.id] or {}
			end
		end
		if CharInfo.MASLENGO.CurrencyID == nil then CharInfo.MASLENGO.CurrencyID = {} end
		if CharInfo.MASLENGO.CurrencyID_totalEarned == nil then CharInfo.MASLENGO.CurrencyID_totalEarned = {} end
		if CharInfo.MASLENGO.CurrencyID_Total == nil then CharInfo.MASLENGO.CurrencyID_Total = {} end
		if CharInfo.MASLENGO.UniversalQuest == nil then CharInfo.MASLENGO.UniversalQuest = {} end
		for _, v in next, (E.OctoTable_UniversalQuest) do
			CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] or nil
		end
		if CharInfo.MASLENGO.OctoTable_QuestID == nil then CharInfo.MASLENGO.OctoTable_QuestID = {} end
		if CharInfo.MASLENGO.Quests == nil then CharInfo.MASLENGO.Quests = {} end
		if CharInfo.MASLENGO.professions == nil then CharInfo.MASLENGO.professions = {} end
		for i = 1, 5 do
			CharInfo.MASLENGO.professions[i] = CharInfo.MASLENGO.professions[i] or {}
			CharInfo.MASLENGO.professions[i].skillLine = CharInfo.MASLENGO.professions[i].skillLine or 0
			CharInfo.MASLENGO.professions[i].skillLevel = CharInfo.MASLENGO.professions[i].skillLevel or 0
			CharInfo.MASLENGO.professions[i].maxSkillLevel = CharInfo.MASLENGO.professions[i].maxSkillLevel or 0
		end
		if CharInfo.MASLENGO.ItemsInBag == nil then CharInfo.MASLENGO.ItemsInBag = {} end
		----------------------------------------------------------------
		if CharInfo.PIZDALISHE == nil then CharInfo.PIZDALISHE = {} end
		CharInfo.PIZDALISHE.islandBfA = CharInfo.PIZDALISHE.islandBfA or nil -- ТУТ НИЛ
		CharInfo.PIZDALISHE.GreatVault = CharInfo.PIZDALISHE.GreatVault or {} -- ПОФИКСИТЬ
		for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
			CharInfo.PIZDALISHE.GreatVault[i] = CharInfo.PIZDALISHE.GreatVault[i] or {}
			CharInfo.PIZDALISHE.GreatVault[i].progress = CharInfo.PIZDALISHE.GreatVault[i].progress or 0
			CharInfo.PIZDALISHE.GreatVault[i].threshold = CharInfo.PIZDALISHE.GreatVault[i].threshold or 0
			CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING = CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING or 0
			CharInfo.PIZDALISHE.GreatVault[i].type = CharInfo.PIZDALISHE.GreatVault[i].type or ""
		end
		if CharInfo.PIZDALISHE.CovenantAndAnima == nil then CharInfo.PIZDALISHE.CovenantAndAnima = {} end -- ПОФИКСИТЬ / ПЕРЕДЕЛАТЬ В НЕ ЧЕРЕЗ k i
		if CharInfo.PIZDALISHE.CovenantAndAnima.curCovID == nil then CharInfo.PIZDALISHE.CovenantAndAnima.curCovID = 0 end
		for k = 1, 2 do
			for i = 1, 4 do
				CharInfo.PIZDALISHE.CovenantAndAnima[i] = CharInfo.PIZDALISHE.CovenantAndAnima[i] or {}
				CharInfo.PIZDALISHE.CovenantAndAnima[i][k] = CharInfo.PIZDALISHE.CovenantAndAnima[i][k] or 0
			end
		end
		----------------------------------------------------------------
		if CharInfo.PIZDALISHE.journalInstance == nil then CharInfo.PIZDALISHE.journalInstance = {} end
		local ServerTime = GetServerTime()
		for instanceID, tbl in next, (CharInfo.PIZDALISHE.journalInstance) do
			if instanceID then
				for difficultyID, w in next, (tbl) do
					for e, r in next, (w) do
						if e == "instanceReset" then
							if ServerTime >= r then
								CharInfo.PIZDALISHE.journalInstance[instanceID] = {}
							end
						end
					end
				end
			end
		end
		CharInfo.PIZDALISHE.SavedWorldBoss = CharInfo.PIZDALISHE.SavedWorldBoss or {}
		if CharInfo.PIZDALISHE.LFGInstance == nil then CharInfo.PIZDALISHE.LFGInstance = {} end
		for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
			if CharInfo.PIZDALISHE.LFGInstance[dungeonID] == nil then CharInfo.PIZDALISHE.LFGInstance[dungeonID] = {} end
			CharInfo.PIZDALISHE.LFGInstance[dungeonID].D_name = CharInfo.PIZDALISHE.LFGInstance[dungeonID].D_name or name
			CharInfo.PIZDALISHE.LFGInstance[dungeonID].donetoday = CharInfo.PIZDALISHE.LFGInstance[dungeonID].donetoday or nil
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
	end
end


function OctoToDo_EventFrame_WTF:OctoToDo_DB_Config()
	if OctoToDo_DB_Config == nil then OctoToDo_DB_Config = {} end
	if OctoToDo_DB_Config.CurrencyDB == nil then OctoToDo_DB_Config.CurrencyDB = {} end
	for currencyID, v in next, (E.OctoTable_Currencies) do
		OctoToDo_DB_Config.CurrencyDB[currencyID] = OctoToDo_DB_Config.CurrencyDB[currencyID] or false
	end
	if OctoToDo_DB_Config.ReputationDB == nil then OctoToDo_DB_Config.ReputationDB = {} end

	for index, tbl in ipairs(E.OctoTable_Reputations) do
		for i, v in ipairs(tbl) do
			OctoToDo_DB_Config.ReputationDB[v.id] = OctoToDo_DB_Config.ReputationDB[v.id] or false
		end
	end
end


function OctoToDo_EventFrame_WTF:OctoToDo_DB_Vars()
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
end


function OctoToDo_EventFrame_WTF:OctoToDo_DB_Other()
	if OctoToDo_DB_Other == nil then OctoToDo_DB_Other = {} end
	if OctoToDo_DB_Other.AccountMoney == nil then OctoToDo_DB_Other.AccountMoney = {} end
	if OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] == nil then OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] = 0 end
	if OctoToDo_DB_Other.CVar == nil then OctoToDo_DB_Other.CVar = {} end
	if OctoToDo_DB_Other.Items == nil then OctoToDo_DB_Other.Items = {} end
	if OctoToDo_DB_Other.Holiday == nil then OctoToDo_DB_Other.Holiday = {} end
end


function OctoToDo_EventFrame_WTF:OctoToDo_Achievements()
	if OctoToDo_Achievements == nil then OctoToDo_Achievements = {} end
	if OctoToDo_Achievements.AchievementShowCompleted == nil then OctoToDo_Achievements.AchievementShowCompleted = true end
	if OctoToDo_Achievements.AchievementToShow == nil then OctoToDo_Achievements.AchievementToShow = {[92] = true} end
end


function OctoToDo_EventFrame_WTF:OctoSimpleList()
	if OctoSimpleList == nil then OctoSimpleList = {} end
end


function OctoToDo_EventFrame_WTF:OctoToDo_AddonsTable()
	if OctoToDo_AddonsTable == nil then OctoToDo_AddonsTable = {} end
end


function OctoToDo_EventFrame_WTF:OctoToDo_AddonsManager()
	if OctoToDo_AddonsManager == nil then OctoToDo_AddonsManager = {} end
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
end


function OctoToDo_EventFrame_WTF:OctoToDo_OCTOREP()
	if OctoToDo_OCTOREP == nil then OctoToDo_OCTOREP = {} end
	if OctoToDo_OCTOREP.TrackedRepID == nil then OctoToDo_OCTOREP.TrackedRepID = 369 end
end


function OctoToDo_EventFrame_WTF:OctoToDo_TrashCan()
	if OctoToDo_TrashCan == nil then OctoToDo_TrashCan = {} end
	if OctoToDo_TrashCan.Reputations == nil then OctoToDo_TrashCan.Reputations = {} end
	if OctoToDo_TrashCan.OctoToDo_MplusButton == nil then OctoToDo_TrashCan.OctoToDo_MplusButton = {} end
	if OctoToDo_TrashCan.UniversalQuest == nil then OctoToDo_TrashCan.UniversalQuest = {} end
	if OctoToDo_TrashCan.Holiday == nil then OctoToDo_TrashCan.Holiday = {} end
	if OctoToDo_TrashCan.HolidayCollectAll == nil then OctoToDo_TrashCan.HolidayCollectAll = {} end





end


function OctoToDo_EventFrame_WTF:Daily_Reset() -- ПОФИКСИТЬ (ПОВЕСИТЬ НЕ НА ПЕРСА)
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if (CharInfo.tmstp_Daily or 0) < GetServerTime() then
			CharInfo.tmstp_Daily = E.func_tmstpDayReset(1)
			CharInfo.needResetDaily = true
			for _, v in next, (E.OctoTable_UniversalQuest) do
				for q, w in next, (v) do
					if w == "Daily" then
						CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Daily"] = nil
					end
				end
			end
			CharInfo.STARTTODAY = 0
			CharInfo.PIZDALISHE.LFGInstance = {}
		end
	end
end


function OctoToDo_EventFrame_WTF:Weekly_Reset()
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
			for i = 1, #CharInfo.PIZDALISHE.GreatVault do
				if CharInfo.PIZDALISHE.GreatVault[i] and CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING ~= 0 then
					CharInfo.HasAvailableRewards = true
					CharInfo.PIZDALISHE.GreatVault = {}
					break
				end
			end
		end
		if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.MASLENGO.UniversalQuest.Octopussy_DF_Weekly_CommunityFeast_count == E.DONE then
			CharInfo.Octopussy_DF_Weekly_CommunityFeast_count = nil
		end
		if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
			CharInfo.tmstp_Weekly = E.func_tmstpDayReset(7)
			CharInfo.needResetWeekly = true
			CharInfo.CurrentKey = 0
			CharInfo.CurrentKeyName = 0
			CharInfo.CurrentKeyLevel = 0
			CharInfo.PIZDALISHE.journalInstance = {}
			CharInfo.PIZDALISHE.SavedWorldBoss = {}
			CharInfo.RIO_weeklyBest = 0
			CharInfo.PIZDALISHE.GreatVault = {}
			CharInfo.STARTWEEK = 0
			for i = 1, #CharInfo.PIZDALISHE.GreatVault do
				if CharInfo.PIZDALISHE.GreatVault[i] then
					CharInfo.PIZDALISHE.GreatVault[i] = {}
					CharInfo.PIZDALISHE.GreatVault[i].progress = 0
					CharInfo.PIZDALISHE.GreatVault[i].threshold = 0
					CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING = 0
				end
			end
			for _, v in next, (E.OctoTable_UniversalQuest) do
				for q, w in next, (v) do
					if w == "Weekly" then
						CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Weekly"] = nil
					end
				end
			end
		end
	end
end


function OctoToDo_EventFrame_WTF:Month_Reset()
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if (CharInfo.tmstp_Month or 0) < GetServerTime() then
			CharInfo.tmstp_Month = E.func_tmstpDayReset(30)
			CharInfo.needResetMonth = true
			CharInfo.STARTMONTH = 0
			for _, v in next, (E.OctoTable_UniversalQuest) do
				for q, w in next, (v) do
					if w == "Month" then
						CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Month"] = nil
					end
				end
			end
		end
	end
end

do
	local MyEventsTable = {
		"ADDON_LOADED",
		"VARIABLES_LOADED",
	}
	E.RegisterMyEventsToFrames(OctoToDo_EventFrame_WTF, MyEventsTable, E.func_DebugPath())
end

function OctoToDo_EventFrame_WTF:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		self:OctoToDo_DB_Levels()
		self:OctoToDo_DB_Config()
		self:OctoToDo_DB_Vars()
		self:OctoToDo_DB_Other()
		self:OctoToDo_Achievements()
		self:OctoSimpleList()
		self:OctoToDo_AddonsTable()
		self:OctoToDo_AddonsManager()
		self:OctoToDo_OCTOREP()
		self:OctoToDo_TrashCan()
		----------------------------------------------------------------
		self:Daily_Reset()
		self:Weekly_Reset()
		self:Month_Reset()
		----------------------------------------------------------------
	end
end


function OctoToDo_EventFrame_WTF:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
		if OctoToDo_DB_Vars.CVar then
			E.LoadCVars()
		end
	end
end