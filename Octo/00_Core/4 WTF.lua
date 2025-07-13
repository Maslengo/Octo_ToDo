local GlobalAddonName, E = ...
local Octo_EventFrame_WTF = CreateFrame("FRAME")
Octo_EventFrame_WTF:Hide()
-- Локальные функции для часто используемых операций
local function InitTable(tbl)
	return tbl or {}
end
local function InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
local function InitSubTable(tbl, field)
	if tbl[field] == nil then
		tbl[field] = {}
	end
end


local function replaceZeroWithNil(tbl, what)
	if not tbl or type(tbl) ~= "table" or not what then
		return tbl
	end

	local whatSet = type(what) == "table" and {} or what

	if type(what) == "table" then
		for _, w in ipairs(what) do
			whatSet[w] = true
		end
	end

	for k, value in pairs(tbl) do
		if (type(what) == "table" and whatSet[value]) or value == what then
			print(k, E.Yellow_Color .. tostring(value) .. "|r")
			tbl[k] = nil
		elseif type(value) == "table" then
			replaceZeroWithNil(value, what)
		end
	end

	return tbl
end

-- local function replaceZeroWithNil(tbl, smth)
-- 	if tbl and smth then
-- 		if type(tbl) ~= "table" then return tbl end

-- 		if type(smth) == "table" then
-- 			for q, w in ipairs(smth) do
-- 				for k, value in pairs(tbl) do
-- 					if value == w then
-- 						print (k, E.Yellow_Color..tostring(value).."|r")
-- 						tbl[k] = nil
-- 					elseif type(value) == "table" then
-- 						replaceZeroWithNil(value, w)
-- 					end
-- 				end
-- 				return tbl
-- 			end
-- 		else
-- 			for k, value in pairs(tbl) do
-- 				if value == smth then
-- 					print (k, E.Purple_Color..tostring(value).."|r")
-- 					tbl[k] = nil
-- 				elseif type(value) == "table" then
-- 					replaceZeroWithNil(value, smth)
-- 				end
-- 			end
-- 			return tbl
-- 		end
-- 	end
-- end


function Octo_EventFrame_WTF:DatabaseTransfer()
	if Octo_ToDo_DB_Levels then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			CharInfo.PlayerData = CharInfo.PlayerData or {}
			for k, value in pairs(CharInfo) do
				if type(value) ~= "table" then
					print (E.Red_Color..k.."|r", value)
					CharInfo.PlayerData[k] = value
					CharInfo[k] = nil
				end
			end
		end

	end

	replaceZeroWithNil(Octo_ToDo_DB_Levels, {false, 0})
	-- replaceZeroWithNil(Octo_ToDo_DB_Vars, {false, 0})
	replaceZeroWithNil(Octo_ToDo_DB_Other, {false, 0})
	replaceZeroWithNil(Octo_ToDo_DB_Minecraft, {false, 0})
	replaceZeroWithNil(Octo_Achievements_DB, {false, 0})
	replaceZeroWithNil(Octo_AddonsTable, {false, 0})
	replaceZeroWithNil(Octo_AddonsManager_DB, {false, 0})
	replaceZeroWithNil(Octo_DEBUG, {false, 0})
	replaceZeroWithNil(Octo_QuestsChangedDB, {false, 0})
end






function Octo_EventFrame_WTF:Octo_ToDo_DB_Levels()
	local curGUID = UnitGUID("player")
	Octo_ToDo_DB_Levels = InitTable(Octo_ToDo_DB_Levels)
	Octo_ToDo_DB_Levels[curGUID] = InitTable(Octo_ToDo_DB_Levels[curGUID])
	local ServerTime = GetServerTime()
	local currentDate = date("%d.%m.%Y")
	local currentTime = date("%H:%M")
	local currentDateTime = date("%d.%m.%Y %H:%M:%S")
	-- Предварительно вычисляем часто используемые значения
	local defaults = {
		className = E.className,
		classFilename = E.classFilename,
		GUID = curGUID,
		classColor = E.classColor,
		curServer = E.curServer,
		guildName = "",
		guildRankName = "",
		curServerShort = E.func_CurServerShort(E.curServer),
		Faction = "Horde",
		BattleTag = E.BattleTag,
		BattleTagLocal = E.BattleTagLocal,
		buildVersion = E.buildVersion,
		buildNumber = E.buildNumber,
		buildDate = E.buildDate,
		interfaceVersion = E.interfaceVersion,
		currentTier = E.currentTier,
		Name = "E.curCharName",
		classColorHex = E.classColorHexCurrent,
		loginDate = currentDateTime,
		loginDay = currentDate,
		loginHour = currentTime,





		-- GetRestrictedAccountData_rLevel = E.GetRestrictedAccountData_rLevel,
		-- GetRestrictedAccountData_rMoney = E.GetRestrictedAccountData_rMoney,
		-- PlayerDurability = 100,

		-- ReloadCount = 0,
		-- azeriteEXP = 0,
		-- azeriteLVL = 0,
		-- cloak_lvl = 0,
		-- cloak_res = 0,
		-- guildRankIndex = 0,
		-- Chromie_UnitChromieTimeID = 0,
		-- maxNumQuestsCanAccept = 0,
		-- numQuests = 0,
		-- RaceLocal = 0,
		-- RaceEnglish = 0,
		-- raceID = 0,
		-- currentXP = 0,
		-- UnitXPMax = 0,
		-- UnitXPPercent = 0,
		-- realTotalTime = 0,
		-- TodayTimePlayed = 0,
		-- realLevelTime = 0,
		-- Possible_Anima = 0,
		-- Possible_CatalogedResearch = 0,
		-- numShownEntries = 0,
		-- Money = 0,
		-- totalSlots = 0,
		-- usedSlots = 0,
		-- BindLocation = 0,
		-- curLocation = 0,
		-- CurrentKey = 0,
		-- CurrentKeyName = 0,
		-- CurrentKeyLevel = 0,
		-- RIO_Score = 0,
		-- RIO_weeklyBest = 0,

		-- avgItemLevel = 1,
		-- avgItemLevelEquipped = 1,
		-- avgItemLevelPvp = 1,
		-- classId = 1,
		-- UnitLevel = 1,


		-- hasMail = false,
		-- levelCapped20 = false,
		-- GameLimitedMode_IsActive = E.GameLimitedMode_IsActive,
		-- IsRestrictedAccount
		-- Chromie_inChromieTime
		-- IsVeteranTrialAccount = E.IsVeteranTrialAccount,
		-- Chromie_canEnter = false,
		-- IsPublicBuild = E.IsPublicBuild,
		-- HasAvailableRewards = false,

		-- IsTrialAccount = E.IsTrialAccount,
		-- IsAccountSecured = E.IsAccountSecured,
		-- needResetDaily = false,
		-- needResetWeekly = false,
		-- needResetMonth = false,
		-- WarMode = false,
		-- PlayerCanEarnExperience = true,


		isShownPLAYER = true,





	}
	-- Оптимизация: предварительно инициализируем таблицы
	local MASLENGO_DEFAULTS = {
		reputationNEW = {},
		CurrencyID = {},
		CurrencyID_totalEarned = {},
		CurrencyID_Total = {},
		UniversalQuest = {},
		OctoTable_QuestID = {},
		ListOfQuests = {}, -- Quests
		professions = {
			[1] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[2] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[3] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[4] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[5] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0}
		},
		ItemsInBag = {},
		GreatVault = {},
		CovenantAndAnima = {
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
		},
		journalInstance = {},
		SavedWorldBoss = {},
		LFGInstance = {},
	}
	-- Инициализация GreatVault
	for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
		MASLENGO_DEFAULTS.GreatVault[i] = {
			-- progress = 0,
			-- threshold = 0,
			-- hyperlink_STRING = 0,
			-- type = "",
		}
	end
	-- Инициализация CovenantAndAnima
	MASLENGO_DEFAULTS.CovenantAndAnima.curCovID = nil
	-- Обработка всех персонажей
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do

		InitSubTable(CharInfo, "MASLENGO")
		local MASLENGO = CharInfo.MASLENGO

		InitSubTable(CharInfo, "PlayerData")
		local PlayerData = CharInfo.PlayerData
		for k, v in next, (defaults) do
			InitField(PlayerData, k, v)
		end
		PlayerData.time = PlayerData.time or PlayerData.tmstp_Daily or ServerTime
		PlayerData.MoneyOnLogin = PlayerData.MoneyOnLogin or PlayerData.Money


		-- Применяем предопределенные значения для MASLENGO
		for k, v in next, (MASLENGO_DEFAULTS) do
			if MASLENGO[k] == nil then
				MASLENGO[k] = type(v) == "table" and CopyTable(v) or v
			end
		end
		-- Инициализация репутаций
		for _, tbl in ipairs(E.OctoTable_Reputations) do
			for _, v in ipairs(tbl) do
				MASLENGO.reputationNEW[v.id] = MASLENGO.reputationNEW[v.id] or "####"
			end
		end
		-- Инициализация UniversalQuest
		-- for _, v in next, (E.OctoTable_UniversalQuest) do
		-- 	local key = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
		-- 	MASLENGO.UniversalQuest[key] = MASLENGO.UniversalQuest[key] or nil
		-- 	if type(MASLENGO.UniversalQuest[key]) == "string" then
		-- 		MASLENGO.UniversalQuest[key] = nil
		-- 	end
		-- end


		-- Инициализация LFGInstance
		for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
			MASLENGO.LFGInstance[dungeonID] = InitTable(MASLENGO.LFGInstance[dungeonID])
			InitField(MASLENGO.LFGInstance[dungeonID], "D_name", name)
			MASLENGO.LFGInstance[dungeonID].donetoday = MASLENGO.LFGInstance[dungeonID].donetoday or nil
		end
		-- Очистка устаревших данных журнала
		for instanceID, tbl in next, (MASLENGO.journalInstance) do
			if instanceID then
				for difficultyID, w in next, (tbl) do
					if w.instanceReset and ServerTime >= w.instanceReset then
						MASLENGO.journalInstance[instanceID] = {}
					end
				end
			end
		end
		-- Перенос и очистка данных
		local tablesToProcess = {
			ItemsInBag = {cleanZeros = true},
			LFGInstance = {cleanZeros = false},
			GreatVault = {cleanZeros = false},
			PVP = {cleanZeros = false},
			journalInstance = {cleanZeros = false},
			CurrencyID = {cleanZeros = true},
			CurrencyID_Total = {cleanZeros = true},
			CurrencyID_totalEarned = {cleanZeros = true},
			professions = {cleanZeros = false},
			OctoTable_QuestID = {cleanZeros = false},
		}
		for tableName, options in next, (tablesToProcess) do
			local sourceTable = CharInfo[tableName]
			if sourceTable then
				-- Переносим таблицу
				MASLENGO[tableName] = sourceTable
				CharInfo[tableName] = nil
				-- Обработка специальных случаев
				if options.specialHandler then
					-- options.specialHandler(sourceTable, MASLENGO)
					-- MASLENGO[tableName] = nil -- Удаляем после обработки, если нужно
				elseif options.cleanZeros and type(sourceTable) == "table" then
					for k, v in next, (sourceTable) do
						if type(v) == "number" and v == 0 then
							sourceTable[k] = nil
						end
					end
				end
			end
		end
		if CharInfo.reputationID then
			for k, v in pairs(CharInfo.reputationID) do
				if v and v ~= "" and v ~= 0 then
					if v == "|cff4FFF79Done|r" then
						CharInfo.MASLENGO.reputationNEW[k] = "1#1#"..E.DONE.."#"..E.Green_Color.."#"
					else
						local color = v:match("c%x%x%x%x%x%x%x%x")
						local vivod, FIRST, SECOND, standingTEXT = v:gsub("|c%x%x%x%x%x%x%x%x", ""):match("((%d+)/(%d+)) ?%(?(.*)%)?")-- "|cffFFF371"
						CharInfo.MASLENGO.reputationNEW[k] = FIRST.."#"..SECOND.."#"..vivod.."#"..color.."#"..standingTEXT
					end
				end
			end
			CharInfo.reputationID = nil
		end
		if CharInfo.MASLENGO.reputationFULL and CharInfo.MASLENGO.reputationNEW then
			for k, v in pairs(CharInfo.MASLENGO.reputationFULL) do
				local FIRST = v.FIRST or 0
				local SECOND = v.SECOND or 0
				local vivod = v.vivod or "-QWEQWEQWE"
				local color = v.color or "|cffFF0000"
				local standingTEXT = v.standingTEXT or ""
				CharInfo.MASLENGO.reputationNEW[k] = FIRST.."#"..SECOND.."#"..vivod.."#"..color.."#"..standingTEXT
			end
			CharInfo.MASLENGO.reputationFULL = nil
		end
		for k, v in next, (CharInfo) do
			if type(v) ~= "table" then
				-- if k and strfind(k, "Octopussy_", 1, true) then
				if k and k:find("Octopussy_", 1, true) then -- это используется для МЕЧИНГА (4ый параметр true не учитывает регулярные выражения для ускорения поиска)
					CharInfo[k] = nil
				end
			end
		end
		local tablesToDelete = {
			"bounty_BfA2_questID",
			"bounty_BfA1_end",
			"bounty_BfA3_icon",
			"bounty_Legion2_icon",
			"bounty_Legion1_end",
			"bounty_BfA3_questID",
			"bounty_BfA2_end",
			"bounty_BfA1_questID",
			"bounty_BfA3_end",
			"bounty_BfA2_icon",
			"bounty_Legion3",
			"bounty_Legion1",
			"bounty_Legion3_icon",
			"bounty_Legion2",
			"bounty_Legion1_icon",
			"bounty_BfA2",
			"bounty_Legion1_questID",
			"bounty_Legion3_questID",
			"bounty_Legion2_end",
			"bounty_BfA1_icon",
			"bounty_BfA3",
			"bounty_BfA1",
			"bounty_Legion3_end",
			"bounty_Legion2_questID",
			"CurrencyID_trackedQuantity",
			"STARTWEEK",
			"DreamsurgeInvestigation",
		}
		for _, key in ipairs(tablesToDelete) do
			if CharInfo[key] ~= nil then
				CharInfo[key] = nil
			end
		end
		-- CharInfo.MASLENGO.CovenantAndAnima = {
		-- [1] = {[1] = 5, [2] = 5},
		-- [2] = {[1] = 5, [2] = 5},
		-- [3] = {[1] = 5, [2] = 5},
		-- [4] = {[1] = 5, [2] = 5},
		-- }
		if CharInfo.curCovID and CharInfo.MASLENGO.CovenantAndAnima and CharInfo.MASLENGO.CovenantAndAnima.curCovID ~= CharInfo.curCovID then
			CharInfo.MASLENGO.CovenantAndAnima.curCovID = CharInfo.curCovID
			CharInfo.curCovID = nil
		end
		-- CreateTable/TableCreate -- ПОГУГЛИТЬ ПОФИКСИТЬ
		if CharInfo.Shadowland then
			CharInfo.MASLENGO.CovenantAndAnima[1] = {CharInfo.Shadowland[1], CharInfo.Shadowland[2]}
			CharInfo.MASLENGO.CovenantAndAnima[2] = {CharInfo.Shadowland[3], CharInfo.Shadowland[4]}
			CharInfo.MASLENGO.CovenantAndAnima[3] = {CharInfo.Shadowland[5], CharInfo.Shadowland[6]}
			CharInfo.MASLENGO.CovenantAndAnima[4] = {CharInfo.Shadowland[7], CharInfo.Shadowland[8]}
			CharInfo.Shadowland = nil
		end


	end
end
function Octo_EventFrame_WTF:Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = InitTable(Octo_ToDo_DB_Vars)
	-- Размеры и параметры интерфейса
	local uiDefaults = {
		AddonHeight = 20,
		AddonLeftFrameWeight = 256,
		AddonCentralFrameWeight = 128,
		MainFrameDefaultLines = 30,
		SFDropDownWeight = 100,
		MaxNumCharacters = 10,
		FrameScale = 1,
		GameMenuFrameScale = 0.8,
		LevelToShow = 1,
		LevelToShowMAX = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT),
		prefix = 1,
	}
	for k, v in next, (uiDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
	end
	-- Настройки отладки
	local debugDefaults = {
		DebugIDs = false,
		DebugInfo = false,
		DebugEvent = false,
		DebugFunction = false,
		DebugButton = false,
	}
	for k, v in next, (debugDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
		E[k] = Octo_ToDo_DB_Vars[k]
	end
	-- Настройки функций
	local featureDefaults = {
		AchievementShowCompleted = true,
		AidingtheAccord = true,
		AnotherAddonsCasual = true,
		AnotherAddonsDUNG = true,
		AnotherAddonsRAID = true,
		Auto_CinematicCanceler = true,
		Auto_CinematicFastSkip = true,
		Auto_Gossip = true,
		Auto_Screenshot = true,
		AutoOpen = true,
		AutoRepair = true,
		AutoSellGrey = true,
		AutoTurnQuests = true,
		BeledarCycle = true,
		ChallengesKeystoneFrame = true,
		Currency = true,
		CVar = true,
		EmeraldDream_Dreamseeds = true,
		EmeraldDream_Rares = true,
		EmeraldDream_Sparks = true,
		EmeraldDream_WB = true,
		Hide_AzeriteEmpoweredItemUI = true,
		Hide_Boss_Banner = true,
		Hide_Covenant = true,
		Hide_Error_Messages = true,
		Hide_ObjectivesInInstance = true,
		Hide_OrderHallCommandBar = true,
		Hide_Raid_Boss_Emote_Frame = true,
		Hide_RaidWarningFrame = true,
		Hide_Talking_Head_Frame = true,
		Hide_Zone_Text = true,
		InputDelete = true,
		LastUpdate = true,
		LootFrame = true,
		MajorKeyflames = true,
		MinorKeyflames = true,
		MP_MythicKeystone = true,
		PortalsButtons = true,
		PortalsButtonsOnlyAvailable = true,
		QC_Quests = true,
		ShowIDS = true,
		StaticPopup1Button1 = true,
		TalentTreeTweaks = true,
		TalentTreeTweaks_Alpha = 1,
		TalentTreeTweaks_Scale = 1,
		TWW_Delve_Weekly = true,
		TWW_DungeonQuest_Weekly = true,
		UIErrorsFramePosition = true,
		WorldBoss_Weekly = true,



		-- Event = true,
		Quests = true,
		Holidays = true,
		Dungeons = true,
		Items = true,
		Professions = true,
		Gold = true,
		ItemLevel = true,
		WasOnline = true,

		Auto_ChatClearing = false,
		Reputations = false,
		CurrencyShowAllways = false,
		ItemsShowAllways = false,
		ItemsUsable = false,
		OnlyCurrentFaction = false,
		QuestsShowAllways = false,
		QC_Vignettes = false,
		ShowOnlyCurrentBattleTag = false,
		ShowOnlyCurrentServer = false,
	}
	for k, v in next, (featureDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
	end
	-- Таблицы по умолчанию
	-- InitField(Octo_ToDo_DB_Vars, "color", {1, 1, 1})
	InitField(Octo_ToDo_DB_Vars, "AchievementToShow", {[92] = true})
	InitField(Octo_ToDo_DB_Vars, "ExpansionToShow", {[11] = true})
	-- Настройки позиционирования
	InitSubTable(Octo_ToDo_DB_Vars, "SpeedFrame")
	local speedFrameDefaults = {
		Shown = true,
		point = "BOTTOM",
		relativePoint = "BOTTOM",
		xOfs = 129,
		yOfs = 67
	}
	for k, v in next, (speedFrameDefaults) do
		InitField(Octo_ToDo_DB_Vars.SpeedFrame, k, v)
	end
	InitSubTable(Octo_ToDo_DB_Vars, "PosFrame")
	local posFrameDefaults = {
		Shown = true,
		point = "BOTTOM",
		relativePoint = "BOTTOM",
		xOfs = 129,
		yOfs = 67,
	}
	for k, v in next, (posFrameDefaults) do
		InitField(Octo_ToDo_DB_Vars.PosFrame, k, v)
	end
end
function Octo_EventFrame_WTF:Octo_ToDo_DB_Other()
	Octo_ToDo_DB_Other = InitTable(Octo_ToDo_DB_Other)
	InitSubTable(Octo_ToDo_DB_Other, "AccountMoney")
	InitField(Octo_ToDo_DB_Other.AccountMoney, E.BattleTagLocal, 0)
	InitSubTable(Octo_ToDo_DB_Other, "CVar")
	InitSubTable(Octo_ToDo_DB_Other, "Items")
	InitSubTable(Octo_ToDo_DB_Other, "Holiday")
	-- InitSubTable(Octo_ToDo_DB_Other, "ActiveHoliday")
	InitSubTable(Octo_ToDo_DB_Other, "professions")
end
function Octo_EventFrame_WTF:Octo_ToDo_DB_Minecraft()
	Octo_ToDo_DB_Minecraft = InitTable(Octo_ToDo_DB_Minecraft)
	InitSubTable(Octo_ToDo_DB_Minecraft, "ColorFG")
	InitField(Octo_ToDo_DB_Minecraft.ColorFG, "r", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorFG, "g", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorFG, "b", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorFG, "a", 1)
	InitSubTable(Octo_ToDo_DB_Minecraft, "ColorBG")
	InitField(Octo_ToDo_DB_Minecraft.ColorBG, "r", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorBG, "g", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorBG, "b", 1)
	InitField(Octo_ToDo_DB_Minecraft.ColorBG, "a", 1)
end
function Octo_EventFrame_WTF:Octo_Achievements_DB()
	Octo_Achievements_DB = InitTable(Octo_Achievements_DB)
	InitField(Octo_Achievements_DB, "AchievementShowCompleted", true)
	InitField(Octo_Achievements_DB, "AchievementToShow", {[92] = true})
end
function Octo_EventFrame_WTF:Octo_AddonsTable()
	Octo_AddonsTable = InitTable(Octo_AddonsTable)
end
function Octo_EventFrame_WTF:Octo_AddonsManager_DB()
	Octo_AddonsManager_DB = InitTable(Octo_AddonsManager_DB)
	InitSubTable(Octo_AddonsManager_DB, "collapsedAddons")
	InitSubTable(Octo_AddonsManager_DB, "profiles")
	InitSubTable(Octo_AddonsManager_DB.profiles, "forceload")
	InitField(Octo_AddonsManager_DB.profiles.forceload, GlobalAddonName, true)
	InitSubTable(Octo_AddonsManager_DB, "config")
	local configDefaults = {
		sorting = "title",
		addonListStyle = "tree",

		profilingcpuUpdate = nil, -- 0

		showIconsQuestionMark = nil,
		profilingcpuShowCurrent = nil,
		profilingcpuShowEncounter = nil,
		profilingcpuShowPeak = nil,
		profilingcpuShowAverage = nil,
		localizeCategoryName = nil,
		showVersions = nil,
		autofocusSearch = nil,
		showSecureAddons = nil,
		showTocXCategory = nil,
		showTocCategory = nil,
		showMemoryInBrokerTtp = nil,

		fullName = nil,
		showIcons = nil,
		showVersion = nil,
		showIndex = nil,
		minimaphide = nil,
		hookMenuButton = nil,
		sortingCpu = nil,
	}
	for k, v in next, (configDefaults) do
		InitField(Octo_AddonsManager_DB.config, k, v)
	end
	InitField(Octo_AddonsManager_DB, "isCategoryFrameVisible", true)
	InitSubTable(Octo_AddonsManager_DB, "lock")
	InitSubTable(Octo_AddonsManager_DB.lock, "addons")
	InitField(Octo_AddonsManager_DB.lock.addons, E.GlobalAddonName, true)
end
function Octo_EventFrame_WTF:Octo_DEBUG()
	Octo_DEBUG = InitTable(Octo_DEBUG)
end
function Octo_EventFrame_WTF:Octo_QuestsChangedDB()
	Octo_QuestsChangedDB = InitTable(Octo_QuestsChangedDB)
	InitSubTable(Octo_QuestsChangedDB, "QC_Quests")
	InitSubTable(Octo_QuestsChangedDB, "QC_Vignettes")
end
function Octo_EventFrame_WTF:Daily_Reset()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (CharInfo.PlayerData.tmstp_Daily or 0) < ServerTime then
			CharInfo.PlayerData.tmstp_Daily = E.func_tmstpDayReset(1)
			CharInfo.PlayerData.needResetDaily = true
			-- Сброс ежедневных квестов
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Daily" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Daily"] = nil
				end
			end
			wipe(CharInfo.MASLENGO.LFGInstance)
			for _, v in ipairs (E.OctoTable_LFGDungeons) do
				CharInfo.MASLENGO.LFGInstance[v] = CharInfo.MASLENGO.LFGInstance[v] or {}
				CharInfo.MASLENGO.LFGInstance[v].donetoday = nil
			end
			Octo_ToDo_DB_Other.professions.DEBUG = nil
			-- Octo_ToDo_DB_Other.ActiveHoliday = nil
		end
	end
end
function Octo_EventFrame_WTF:Weekly_Reset()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (CharInfo.PlayerData.tmstp_Weekly or 0) < ServerTime then
			-- Проверка награды из Великого Хранилища
			for i = 1, #CharInfo.MASLENGO.GreatVault do
				if CharInfo.MASLENGO.GreatVault[i] and CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING then
					CharInfo.PlayerData.HasAvailableRewards = true
					break
				end
			end
			-- Сброс данных
			CharInfo.PlayerData.tmstp_Weekly = E.func_tmstpDayReset(7)
			CharInfo.PlayerData.needResetWeekly = true
			CharInfo.PlayerData.CurrentKey = nil
			CharInfo.PlayerData.CurrentKeyName = nil
			CharInfo.PlayerData.CurrentKeyLevel = nil
			CharInfo.PlayerData.RIO_weeklyBest = nil
			CharInfo.MASLENGO.journalInstance = {}
			CharInfo.MASLENGO.SavedWorldBoss = {}
			CharInfo.MASLENGO.GreatVault = {}
			-- Сброс еженедельных квестов
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Weekly" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Weekly"] = nil
				end
			end
		end
	end
end
function Octo_EventFrame_WTF:Month_Reset()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (CharInfo.PlayerData.tmstp_Month or 0) < ServerTime then
			CharInfo.PlayerData.tmstp_Month = E.func_tmstpDayReset(365/12)
			CharInfo.PlayerData.needResetMonth = true
			-- Сброс ежемесячных квестов
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Month" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Month"] = nil
				end
			end
		end
	end
end
-- Регистрация событий
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
}
E.RegisterMyEventsToFrames(Octo_EventFrame_WTF, MyEventsTable)
function Octo_EventFrame_WTF:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		-- Перенос старой базы
		self:DatabaseTransfer()
		-- Инициализация всех баз данных
		self:Octo_ToDo_DB_Levels()
		self:Octo_ToDo_DB_Vars()
		self:Octo_ToDo_DB_Other()
		self:Octo_ToDo_DB_Minecraft()
		self:Octo_Achievements_DB()
		self:Octo_AddonsTable()
		self:Octo_AddonsManager_DB()
		self:Octo_DEBUG()
		self:Octo_QuestsChangedDB()
		-- Сброс данных по времени
		self:Daily_Reset()
		self:Weekly_Reset()
		self:Month_Reset()
		E:setOldChanges()
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