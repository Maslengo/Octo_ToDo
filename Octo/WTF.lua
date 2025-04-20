local GlobalAddonName, E = ...
local Octo_EventFrame_WTF = CreateFrame("FRAME")
Octo_EventFrame_WTF:Hide()


function Octo_EventFrame_WTF:Octo_ToDo_DB_Levels()
	if Octo_ToDo_DB_Levels == nil then Octo_ToDo_DB_Levels = {} end
	if Octo_ToDo_DB_Levels[E.curGUID] == nil then Octo_ToDo_DB_Levels[E.curGUID] = {} end
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
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


		if CharInfo.Chromie_canEnter == nil then CharInfo.Chromie_canEnter = false end
		if CharInfo.time == nil then CharInfo.time = time() end
		if CharInfo.UnitLevel == nil then CharInfo.UnitLevel = 1 end
		if CharInfo.Money == nil then CharInfo.Money = 0 end
		if CharInfo.MoneyOnLogin == nil then CharInfo.MoneyOnLogin = CharInfo.Money end
		if CharInfo.totalSlots == nil then CharInfo.totalSlots = 0 end
		if CharInfo.usedSlots == nil then CharInfo.usedSlots = 0 end
		if CharInfo.BindLocation == nil then CharInfo.BindLocation = 0 end
		if CharInfo.CurrentLocation == nil then CharInfo.CurrentLocation = 0 end
		if CharInfo.WarMode == nil then CharInfo.WarMode = false end
		if CharInfo.CurrentKey == nil then CharInfo.CurrentKey = 0 end
		if CharInfo.CurrentKeyName == nil then CharInfo.CurrentKeyName = 0 end
		if CharInfo.CurrentKeyLevel == nil then CharInfo.CurrentKeyLevel = 0 end
		if CharInfo.hasMail == nil then CharInfo.hasMail = false end -- ОСТАВИТЬ
		if CharInfo.levelCapped20 == nil then CharInfo.levelCapped20 = false end
		if CharInfo.PlayerCanEarnExperience == nil then CharInfo.PlayerCanEarnExperience = true end
		if CharInfo.needResetDaily == nil then CharInfo.needResetDaily = false end
		if CharInfo.needResetWeekly == nil then CharInfo.needResetWeekly = false end
		if CharInfo.needResetMonth == nil then CharInfo.needResetMonth = false end
		if CharInfo.HasAvailableRewards == nil then CharInfo.HasAvailableRewards = false end
		if CharInfo.isShownPLAYER == nil then CharInfo.isShownPLAYER = false end
		-- if CharInfo.Chromie_name == nil then CharInfo.Chromie_name = 0 end = CharInfo.Chromie_name or nil
		if CharInfo.RIO_Score == nil then CharInfo.RIO_Score = 0 end
		if CharInfo.RIO_weeklyBest == nil then CharInfo.RIO_weeklyBest = 0 end
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


function Octo_EventFrame_WTF:Octo_ToDo_DB_Vars()
	if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
	if Octo_ToDo_DB_Vars.DebugIDs == nil then Octo_ToDo_DB_Vars.DebugIDs = false end
	E.DebugIDs = Octo_ToDo_DB_Vars.DebugIDs
	if Octo_ToDo_DB_Vars.DebugInfo == nil then Octo_ToDo_DB_Vars.DebugInfo = false end
	E.DebugInfo = Octo_ToDo_DB_Vars.DebugInfo
	if Octo_ToDo_DB_Vars.DebugEvent == nil then Octo_ToDo_DB_Vars.DebugEvent = false end
	E.DebugEvent = Octo_ToDo_DB_Vars.DebugEvent
	if Octo_ToDo_DB_Vars.DebugFunction == nil then Octo_ToDo_DB_Vars.DebugFunction = false end
	E.DebugFunction = Octo_ToDo_DB_Vars.DebugFunction
	if Octo_ToDo_DB_Vars.DebugButton == nil then Octo_ToDo_DB_Vars.DebugButton = false end
	E.DebugButton = Octo_ToDo_DB_Vars.DebugButton
	if Octo_ToDo_DB_Vars.AddonHeight == nil then Octo_ToDo_DB_Vars.AddonHeight = 20 end
	if Octo_ToDo_DB_Vars.AddonLeftFrameWeight == nil then Octo_ToDo_DB_Vars.AddonLeftFrameWeight = 220 end
	if Octo_ToDo_DB_Vars.AddonCentralFrameWeight == nil then Octo_ToDo_DB_Vars.AddonCentralFrameWeight = 110 end
	if Octo_ToDo_DB_Vars.MainFrameDefaultLines == nil then Octo_ToDo_DB_Vars.MainFrameDefaultLines = 30 end
	if Octo_ToDo_DB_Vars.SFDropDownWeight == nil then Octo_ToDo_DB_Vars.SFDropDownWeight = 100 end
	if Octo_ToDo_DB_Vars.PortalsButtons == nil then Octo_ToDo_DB_Vars.PortalsButtons = true end
	if Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable == nil then Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable = true end
	if Octo_ToDo_DB_Vars.color == nil then Octo_ToDo_DB_Vars.color = {1, 1, 1} end
	if Octo_ToDo_DB_Vars.AchievementShowCompleted == nil then Octo_ToDo_DB_Vars.AchievementShowCompleted = true end
	if Octo_ToDo_DB_Vars.AchievementToShow == nil then Octo_ToDo_DB_Vars.AchievementToShow = {[92] = true} end
	if Octo_ToDo_DB_Vars.AidingtheAccord == nil then Octo_ToDo_DB_Vars.AidingtheAccord = true end
	if Octo_ToDo_DB_Vars.AnotherAddonsCasual == nil then Octo_ToDo_DB_Vars.AnotherAddonsCasual = true end
	if Octo_ToDo_DB_Vars.AnotherAddonsDUNG == nil then Octo_ToDo_DB_Vars.AnotherAddonsDUNG = true end
	if Octo_ToDo_DB_Vars.AnotherAddonsRAID == nil then Octo_ToDo_DB_Vars.AnotherAddonsRAID = true end
	if Octo_ToDo_DB_Vars.Auto_ChatClearing == nil then Octo_ToDo_DB_Vars.Auto_ChatClearing = false end
	if Octo_ToDo_DB_Vars.Auto_CinematicCanceler == nil then Octo_ToDo_DB_Vars.Auto_CinematicCanceler = true end
	if Octo_ToDo_DB_Vars.Auto_CinematicFastSkip == nil then Octo_ToDo_DB_Vars.Auto_CinematicFastSkip = true end
	if Octo_ToDo_DB_Vars.Auto_Gossip == nil then Octo_ToDo_DB_Vars.Auto_Gossip = true end
	if Octo_ToDo_DB_Vars.Auto_Screenshot == nil then Octo_ToDo_DB_Vars.Auto_Screenshot = true end
	if Octo_ToDo_DB_Vars.AutoGossip == nil then Octo_ToDo_DB_Vars.AutoGossip = true end
	if Octo_ToDo_DB_Vars.AutoOpen == nil then Octo_ToDo_DB_Vars.AutoOpen = true end
	if Octo_ToDo_DB_Vars.AutoRepair == nil then Octo_ToDo_DB_Vars.AutoRepair = true end
	if Octo_ToDo_DB_Vars.AutoSellGrey == nil then Octo_ToDo_DB_Vars.AutoSellGrey = true end
	if Octo_ToDo_DB_Vars.AutoTurnQuests == nil then Octo_ToDo_DB_Vars.AutoTurnQuests = true end
	if Octo_ToDo_DB_Vars.BeledarCycle == nil then Octo_ToDo_DB_Vars.BeledarCycle = true end
	if Octo_ToDo_DB_Vars.CarvedHarbingerCrest == nil then Octo_ToDo_DB_Vars.CarvedHarbingerCrest = true end
	if Octo_ToDo_DB_Vars.ChallengesKeystoneFrame == nil then Octo_ToDo_DB_Vars.ChallengesKeystoneFrame = true end
	if Octo_ToDo_DB_Vars.CinematicCanceler == nil then Octo_ToDo_DB_Vars.CinematicCanceler = true end
	if Octo_ToDo_DB_Vars.Currency == nil then Octo_ToDo_DB_Vars.Currency = true end
	if Octo_ToDo_DB_Vars.CurrencyShowAllways == nil then Octo_ToDo_DB_Vars.CurrencyShowAllways = false end
	if Octo_ToDo_DB_Vars.CVar == nil then Octo_ToDo_DB_Vars.CVar = true end
	if Octo_ToDo_DB_Vars.Dungeons == nil then Octo_ToDo_DB_Vars.Dungeons = true end
	if Octo_ToDo_DB_Vars.EmeraldDream_Dreamseeds == nil then Octo_ToDo_DB_Vars.EmeraldDream_Dreamseeds = true end
	if Octo_ToDo_DB_Vars.EmeraldDream_Rares == nil then Octo_ToDo_DB_Vars.EmeraldDream_Rares = true end
	if Octo_ToDo_DB_Vars.EmeraldDream_Sparks == nil then Octo_ToDo_DB_Vars.EmeraldDream_Sparks = true end
	if Octo_ToDo_DB_Vars.EmeraldDream_WB == nil then Octo_ToDo_DB_Vars.EmeraldDream_WB = true end
	if Octo_ToDo_DB_Vars.Event == nil then Octo_ToDo_DB_Vars.Event = true end
	if Octo_ToDo_DB_Vars.ExpansionToShow == nil then Octo_ToDo_DB_Vars.ExpansionToShow = {[11] = true} end
	if Octo_ToDo_DB_Vars.FrameScale == nil then Octo_ToDo_DB_Vars.FrameScale = 1 end
	if Octo_ToDo_DB_Vars.GameMenuFrameScale == nil then Octo_ToDo_DB_Vars.GameMenuFrameScale = .8 end
	if Octo_ToDo_DB_Vars.GildedHarbingerCrest == nil then Octo_ToDo_DB_Vars.GildedHarbingerCrest = true end
	if Octo_ToDo_DB_Vars.Gold == nil then Octo_ToDo_DB_Vars.Gold = true end
	if Octo_ToDo_DB_Vars.Professions == nil then Octo_ToDo_DB_Vars.Professions = true end
	if Octo_ToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI == nil then Octo_ToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI = true end
	if Octo_ToDo_DB_Vars.Hide_Boss_Banner == nil then Octo_ToDo_DB_Vars.Hide_Boss_Banner = true end
	if Octo_ToDo_DB_Vars.Hide_Covenant == nil then Octo_ToDo_DB_Vars.Hide_Covenant = true end
	if Octo_ToDo_DB_Vars.Hide_Error_Messages == nil then Octo_ToDo_DB_Vars.Hide_Error_Messages = true end
	if Octo_ToDo_DB_Vars.Hide_ObjectivesInInstance == nil then Octo_ToDo_DB_Vars.Hide_ObjectivesInInstance = true end
	if Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar == nil then Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar = true end
	if Octo_ToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame == nil then Octo_ToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame = true end
	if Octo_ToDo_DB_Vars.Hide_RaidWarningFrame == nil then Octo_ToDo_DB_Vars.Hide_RaidWarningFrame = true end
	if Octo_ToDo_DB_Vars.Hide_Talking_Head_Frame == nil then Octo_ToDo_DB_Vars.Hide_Talking_Head_Frame = true end
	if Octo_ToDo_DB_Vars.Hide_Zone_Text == nil then Octo_ToDo_DB_Vars.Hide_Zone_Text = true end
	if Octo_ToDo_DB_Vars.InputDelete == nil then Octo_ToDo_DB_Vars.InputDelete = true end
	if Octo_ToDo_DB_Vars.ItemLevel == nil then Octo_ToDo_DB_Vars.ItemLevel = true end
	if Octo_ToDo_DB_Vars.Items == nil then Octo_ToDo_DB_Vars.Items = true end
	if Octo_ToDo_DB_Vars.ItemsShowAllways == nil then Octo_ToDo_DB_Vars.ItemsShowAllways = false end
	if Octo_ToDo_DB_Vars.ItemsUsable == nil then Octo_ToDo_DB_Vars.ItemsUsable = false end
	if Octo_ToDo_DB_Vars.LastUpdate == nil then Octo_ToDo_DB_Vars.LastUpdate = true end
	if Octo_ToDo_DB_Vars.LevelToShow == nil then Octo_ToDo_DB_Vars.LevelToShow = 1 end
	if Octo_ToDo_DB_Vars.LevelToShowMAX == nil then Octo_ToDo_DB_Vars.LevelToShowMAX = E.currentMaxLevel end
	if Octo_ToDo_DB_Vars.LootFrame == nil then Octo_ToDo_DB_Vars.LootFrame = true end
	if Octo_ToDo_DB_Vars.MajorKeyflames == nil then Octo_ToDo_DB_Vars.MajorKeyflames = true end
	if Octo_ToDo_DB_Vars.MinorKeyflames == nil then Octo_ToDo_DB_Vars.MinorKeyflames = true end
	if Octo_ToDo_DB_Vars.MP_MythicKeystone == nil then Octo_ToDo_DB_Vars.MP_MythicKeystone = true end
	if Octo_ToDo_DB_Vars.prefix == nil then Octo_ToDo_DB_Vars.prefix = 1 end

	if Octo_ToDo_DB_Vars.interface == nil then Octo_ToDo_DB_Vars.interface = {} end


	if Octo_ToDo_DB_Vars.interface.Octo_background == nil then Octo_ToDo_DB_Vars.interface.Octo_background = "None" end
	if Octo_ToDo_DB_Vars.interface.Octo_border == nil then Octo_ToDo_DB_Vars.interface.Octo_border = "None" end
	if Octo_ToDo_DB_Vars.interface.Octo_statusbar == nil then Octo_ToDo_DB_Vars.interface.Octo_statusbar = "Blizzard" end
	if Octo_ToDo_DB_Vars.interface.Octo_font == nil then Octo_ToDo_DB_Vars.interface.Octo_font = "Friz Quadrata TT" end
	if Octo_ToDo_DB_Vars.interface.Octo_sound == nil then Octo_ToDo_DB_Vars.interface.Octo_sound = "None" end



	if Octo_ToDo_DB_Vars.Quests == nil then Octo_ToDo_DB_Vars.Quests = true end
	if Octo_ToDo_DB_Vars.QuestsShowAllways == nil then Octo_ToDo_DB_Vars.QuestsShowAllways = false end
	if Octo_ToDo_DB_Vars.Reputations == nil then Octo_ToDo_DB_Vars.Reputations = false end
	if Octo_ToDo_DB_Vars.OnlyCurrentFaction == nil then Octo_ToDo_DB_Vars.OnlyCurrentFaction = true end
	if Octo_ToDo_DB_Vars.ResetAllChars == nil then Octo_ToDo_DB_Vars.ResetAllChars = true end
	if Octo_ToDo_DB_Vars.RunedHarbingerCrest == nil then Octo_ToDo_DB_Vars.RunedHarbingerCrest = true end
	if Octo_ToDo_DB_Vars.ShowIDS == nil then Octo_ToDo_DB_Vars.ShowIDS = true end
	if Octo_ToDo_DB_Vars.SpeedFrame == nil then Octo_ToDo_DB_Vars.SpeedFrame = {} end
	if Octo_ToDo_DB_Vars.SpeedFrame.Shown == nil then Octo_ToDo_DB_Vars.SpeedFrame.Shown = true end
	if Octo_ToDo_DB_Vars.SpeedFrame.point == nil then Octo_ToDo_DB_Vars.SpeedFrame.point = "BOTTOM" end
	if Octo_ToDo_DB_Vars.SpeedFrame.relativePoint == nil then Octo_ToDo_DB_Vars.SpeedFrame.relativePoint = "BOTTOM" end
	if Octo_ToDo_DB_Vars.SpeedFrame.xOfs == nil then Octo_ToDo_DB_Vars.SpeedFrame.xOfs = 129 end
	if Octo_ToDo_DB_Vars.SpeedFrame.yOfs == nil then Octo_ToDo_DB_Vars.SpeedFrame.yOfs = 67 end
	if Octo_ToDo_DB_Vars.PosFrame == nil then Octo_ToDo_DB_Vars.PosFrame = {} end
	if Octo_ToDo_DB_Vars.PosFrame.Shown == nil then Octo_ToDo_DB_Vars.PosFrame.Shown = true end
	if Octo_ToDo_DB_Vars.PosFrame.point == nil then Octo_ToDo_DB_Vars.PosFrame.point = "BOTTOM" end
	if Octo_ToDo_DB_Vars.PosFrame.relativePoint == nil then Octo_ToDo_DB_Vars.PosFrame.relativePoint = "BOTTOM" end
	if Octo_ToDo_DB_Vars.PosFrame.xOfs == nil then Octo_ToDo_DB_Vars.PosFrame.xOfs = 129 end
	if Octo_ToDo_DB_Vars.PosFrame.yOfs == nil then Octo_ToDo_DB_Vars.PosFrame.yOfs = 67 end
	if Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag == nil then Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag = false end
	if Octo_ToDo_DB_Vars.ShowOnlyCurrentServer == nil then Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = true end
	if Octo_ToDo_DB_Vars.ShowTime70 == nil then Octo_ToDo_DB_Vars.ShowTime70 = true end
	if Octo_ToDo_DB_Vars.SORTING == nil then Octo_ToDo_DB_Vars.SORTING = true end
	if Octo_ToDo_DB_Vars.StaticPopup1Button1 == nil then Octo_ToDo_DB_Vars.StaticPopup1Button1 = true end
	if Octo_ToDo_DB_Vars.TalentTreeTweaks == nil then Octo_ToDo_DB_Vars.TalentTreeTweaks = true end
	if Octo_ToDo_DB_Vars.TalentTreeTweaks_Alpha == nil then Octo_ToDo_DB_Vars.TalentTreeTweaks_Alpha = 1 end
	if Octo_ToDo_DB_Vars.TalentTreeTweaks_Scale == nil then Octo_ToDo_DB_Vars.TalentTreeTweaks_Scale = 1 end
	if Octo_ToDo_DB_Vars.Timewalk == nil then Octo_ToDo_DB_Vars.Timewalk = true end
	if Octo_ToDo_DB_Vars.TWW_Delve_Weekly == nil then Octo_ToDo_DB_Vars.TWW_Delve_Weekly = true end
	if Octo_ToDo_DB_Vars.TWW_DungeonQuest_Weekly == nil then Octo_ToDo_DB_Vars.TWW_DungeonQuest_Weekly = true end
	if Octo_ToDo_DB_Vars.WorldBoss_Weekly == nil then Octo_ToDo_DB_Vars.WorldBoss_Weekly = true end
	if Octo_ToDo_DB_Vars.UIErrorsFramePosition == nil then Octo_ToDo_DB_Vars.UIErrorsFramePosition = true end
	if Octo_ToDo_DB_Vars.WasOnline == nil then Octo_ToDo_DB_Vars.WasOnline = true end
	if Octo_ToDo_DB_Vars.WeatheredHarbingerCrest == nil then Octo_ToDo_DB_Vars.WeatheredHarbingerCrest = true end
end


function Octo_EventFrame_WTF:Octo_ToDo_DB_Other()
	if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
	if Octo_ToDo_DB_Other.AccountMoney == nil then Octo_ToDo_DB_Other.AccountMoney = {} end
	if Octo_ToDo_DB_Other.AccountMoney[E.BattleTagLocal] == nil then Octo_ToDo_DB_Other.AccountMoney[E.BattleTagLocal] = 0 end
	if Octo_ToDo_DB_Other.CVar == nil then Octo_ToDo_DB_Other.CVar = {} end
	if Octo_ToDo_DB_Other.Items == nil then Octo_ToDo_DB_Other.Items = {} end
	if Octo_ToDo_DB_Other.Holiday == nil then Octo_ToDo_DB_Other.Holiday = {} end
end


function Octo_EventFrame_WTF:Octo_Achievements_DB()
	if Octo_Achievements_DB == nil then Octo_Achievements_DB = {} end
	if Octo_Achievements_DB.AchievementShowCompleted == nil then Octo_Achievements_DB.AchievementShowCompleted = true end
	if Octo_Achievements_DB.AchievementToShow == nil then Octo_Achievements_DB.AchievementToShow = {[92] = true} end
end


function Octo_EventFrame_WTF:Octo_AddonsTable()
	if Octo_AddonsTable == nil then Octo_AddonsTable = {} end
end


function Octo_EventFrame_WTF:Octo_AddonsManager_DB()
	if Octo_AddonsManager_DB == nil then Octo_AddonsManager_DB = {} end
	if Octo_AddonsManager_DB == nil then Octo_AddonsManager_DB = {} end
	if Octo_AddonsManager_DB.collapsedAddons == nil then Octo_AddonsManager_DB.collapsedAddons = {} end
	if Octo_AddonsManager_DB.profiles == nil then Octo_AddonsManager_DB.profiles = {} end
	if Octo_AddonsManager_DB.profiles.forceload == nil then Octo_AddonsManager_DB.profiles.forceload = {[GlobalAddonName] = true,} end
	if Octo_AddonsManager_DB.config == nil then Octo_AddonsManager_DB.config = {} end
	if Octo_AddonsManager_DB.config.fullName == nil then Octo_AddonsManager_DB.config.fullName = false end
	if Octo_AddonsManager_DB.config.showIcons == nil then Octo_AddonsManager_DB.config.showIcons = false end
	if Octo_AddonsManager_DB.config.showIconsQuestionMark == nil then Octo_AddonsManager_DB.config.showIconsQuestionMark = true end
	if Octo_AddonsManager_DB.config.showVersion == nil then Octo_AddonsManager_DB.config.showVersion = false end
	if Octo_AddonsManager_DB.config.showIndex == nil then Octo_AddonsManager_DB.config.showIndex = false end
	if Octo_AddonsManager_DB.config.minimaphide == nil then Octo_AddonsManager_DB.config.minimaphide = false end
	if Octo_AddonsManager_DB.config.hookMenuButton == nil then Octo_AddonsManager_DB.config.hookMenuButton = false end
	if Octo_AddonsManager_DB.config.sortingCpu == nil then Octo_AddonsManager_DB.config.sortingCpu = false end
	if Octo_AddonsManager_DB.config.profilingcpuShowCurrent == nil then Octo_AddonsManager_DB.config.profilingcpuShowCurrent = true end
	if Octo_AddonsManager_DB.config.profilingcpuShowEncounter == nil then Octo_AddonsManager_DB.config.profilingcpuShowEncounter = true end
	if Octo_AddonsManager_DB.config.profilingcpuShowPeak == nil then Octo_AddonsManager_DB.config.profilingcpuShowPeak = true end
	if Octo_AddonsManager_DB.config.profilingcpuShowAverage == nil then Octo_AddonsManager_DB.config.profilingcpuShowAverage = true end
	if Octo_AddonsManager_DB.config.profilingcpuUpdate == nil then Octo_AddonsManager_DB.config.profilingcpuUpdate = 0 end
	if Octo_AddonsManager_DB.config.localizeCategoryName == nil then Octo_AddonsManager_DB.config.localizeCategoryName = true end
	if Octo_AddonsManager_DB.config.showVersions == nil then Octo_AddonsManager_DB.config.showVersions = true end
	if Octo_AddonsManager_DB.config.autofocusSearch == nil then Octo_AddonsManager_DB.config.autofocusSearch = true end
	if Octo_AddonsManager_DB.config.sorting == nil then Octo_AddonsManager_DB.config.sorting = "title" end
	if Octo_AddonsManager_DB.config.showSecureAddons == nil then Octo_AddonsManager_DB.config.showSecureAddons = true end
	if Octo_AddonsManager_DB.config.addonListStyle == nil then Octo_AddonsManager_DB.config.addonListStyle = "tree" end
	if Octo_AddonsManager_DB.config.showTocXCategory == nil then Octo_AddonsManager_DB.config.showTocXCategory = true end
	if Octo_AddonsManager_DB.config.showTocCategory == nil then Octo_AddonsManager_DB.config.showTocCategory = true end
	if Octo_AddonsManager_DB.config.showMemoryInBrokerTtp == nil then Octo_AddonsManager_DB.config.showMemoryInBrokerTtp = true end
	if Octo_AddonsManager_DB.isCategoryFrameVisible == nil then Octo_AddonsManager_DB.isCategoryFrameVisible = true end
	if Octo_AddonsManager_DB.lock == nil then Octo_AddonsManager_DB.lock = {} end
	if Octo_AddonsManager_DB.lock.addons == nil then Octo_AddonsManager_DB.lock.addons = {} end
	if Octo_AddonsManager_DB.lock.addons[E.GlobalAddonName] == nil then Octo_AddonsManager_DB.lock.addons[E.GlobalAddonName] = true end
end


function Octo_EventFrame_WTF:Octo_TrashCan_DB()
	if Octo_TrashCan_DB == nil then Octo_TrashCan_DB = {} end
	if Octo_TrashCan_DB.Reputations == nil then Octo_TrashCan_DB.Reputations = {} end
	if Octo_TrashCan_DB.Octo_MplusButton == nil then Octo_TrashCan_DB.Octo_MplusButton = {} end
	if Octo_TrashCan_DB.UniversalQuest == nil then Octo_TrashCan_DB.UniversalQuest = {} end
	if Octo_TrashCan_DB.Holiday == nil then Octo_TrashCan_DB.Holiday = {} end
	if Octo_TrashCan_DB.HolidayCollectAll == nil then Octo_TrashCan_DB.HolidayCollectAll = {} end





end


function Octo_EventFrame_WTF:Daily_Reset() -- ПОФИКСИТЬ (ПОВЕСИТЬ НЕ НА ПЕРСА)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
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


function Octo_EventFrame_WTF:Weekly_Reset()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
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


function Octo_EventFrame_WTF:Month_Reset()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
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
	E.RegisterMyEventsToFrames(Octo_EventFrame_WTF, MyEventsTable, E.func_DebugPath())
end

function Octo_EventFrame_WTF:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		self:Octo_ToDo_DB_Levels()
		self:Octo_ToDo_DB_Vars()
		self:Octo_ToDo_DB_Other()
		self:Octo_Achievements_DB()
		self:Octo_AddonsTable()
		self:Octo_AddonsManager_DB()
		self:Octo_TrashCan_DB()
		----------------------------------------------------------------
		self:Daily_Reset()
		self:Weekly_Reset()
		self:Month_Reset()
		----------------------------------------------------------------
	end
end


function Octo_EventFrame_WTF:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
		if Octo_ToDo_DB_Vars.CVar then
			E.LoadCVars()
		end
	end
end