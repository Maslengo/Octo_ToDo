local GlobalAddonName, E = ...
local Octo_EventFrame_WTF = CreateFrame("FRAME")
Octo_EventFrame_WTF:Hide()

-- Локальные функции для часто используемых операций
local function InitTable(tbl) return tbl or {} end
local function InitField(tbl, field, default) if tbl[field] == nil then tbl[field] = default end end
local function InitSubTable(tbl, field) if tbl[field] == nil then tbl[field] = {} end end
local wipe = wipe

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
		ReloadCount = 0,
		avgItemLevel = 1,
		avgItemLevelEquipped = 1,
		avgItemLevelPvp = 1,
		azeriteEXP = 0,
		azeriteLVL = 0,
		className = E.className,
		classFilename = E.classFilename,
		GUID = curGUID, -- Используем текущий GUID вместо параметра
		cloak_lvl = 0,
		cloak_res = 0,
		classId = 1,
		classColor = E.classColor,
		curServer = E.curServer,
		guildName = "",
		guildRankName = "",
		guildRankIndex = 0,
		curServerShort = E.func_CurServerShort(E.curServer),
		Faction = "Horde",
		BattleTag = E.BattleTag,
		BattleTagLocal = E.BattleTagLocal,
		IsPublicBuild = E.IsPublicBuild,
		Chromie_UnitChromieTimeID = 0,
		GameLimitedMode_IsActive = E.GameLimitedMode_IsActive,
		buildVersion = E.buildVersion,
		buildNumber = E.buildNumber,
		buildDate = E.buildDate,
		interfaceVersion = E.interfaceVersion,
		currentTier = E.currentTier,
		IsAccountSecured = E.IsAccountSecured,
		GetRestrictedAccountData_rLevel = E.GetRestrictedAccountData_rLevel,
		GetRestrictedAccountData_rMoney = E.GetRestrictedAccountData_rMoney,
		GetRestrictedAccountData_profCap = E.GetRestrictedAccountData_profCap,
		IsTrialAccount = E.IsTrialAccount,
		IsVeteranTrialAccount = E.IsVeteranTrialAccount,
		PlayerDurability = 100,
		maxNumQuestsCanAccept = 0,
		Name = E.curCharName,
		numQuests = 0,
		RaceLocal = 0,
		RaceEnglish = 0,
		raceID = 0,
		classColorHex = E.classColorHexCurrent,
		currentXP = 0,
		UnitXPMax = 0,
		UnitXPPercent = 0,
		realTotalTime = 0,
		TodayTimePlayed = 0,
		realLevelTime = 0,
		Possible_Anima = 0,
		Possible_CatalogedResearch = 0,
		numShownEntries = 0,
		loginDate = currentDateTime,
		loginDay = currentDate,
		loginHour = currentTime,
		Chromie_canEnter = false,
		time = ServerTime,
		UnitLevel = 1,
		Money = 0,
		totalSlots = 0,
		usedSlots = 0,
		BindLocation = 0,
		CurrentLocation = 0,
		WarMode = false,
		CurrentKey = 0,
		CurrentKeyName = 0,
		CurrentKeyLevel = 0,
		hasMail = false,
		levelCapped20 = false,
		PlayerCanEarnExperience = true,
		needResetDaily = false,
		needResetWeekly = false,
		needResetMonth = false,
		HasAvailableRewards = false,
		isShownPLAYER = true,
		RIO_Score = 0,
		RIO_weeklyBest = 0
	}

	-- Оптимизация: предварительно инициализируем таблицы
	local MASLENGO_DEFAULTS = {
		reputationFULL = {},
		CurrencyID = {},
		CurrencyID_totalEarned = {},
		CurrencyID_Total = {},
		UniversalQuest = {},
		OctoTable_QuestID = {},
		Quests = {},
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
			[1] = {[1] = 0, [2] = 0},
			[2] = {[1] = 0, [2] = 0},
			[3] = {[1] = 0, [2] = 0},
			[4] = {[1] = 0, [2] = 0}
		},
		journalInstance = {},
		SavedWorldBoss = {},
		LFGInstance = {}
	}

	-- Инициализация GreatVault
	for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
		MASLENGO_DEFAULTS.GreatVault[i] = {
			progress = 0,
			threshold = 0,
			hyperlink_STRING = 0,
			type = ""
		}
	end

	-- Инициализация CovenantAndAnima
	MASLENGO_DEFAULTS.CovenantAndAnima.curCovID = 0

	-- Обработка всех персонажей
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Установка значений по умолчанию
		for k, v in next, (defaults) do
			InitField(CharInfo, k, v)
		end
		CharInfo.GUID = GUID -- Перезаписываем GUID для текущего персонажа

		-- Инициализация MoneyOnLogin
		CharInfo.MoneyOnLogin = CharInfo.MoneyOnLogin or CharInfo.Money

		-- Инициализация MASLENGO таблиц
		InitSubTable(CharInfo, "MASLENGO")
		local MASLENGO = CharInfo.MASLENGO

		-- Применяем предопределенные значения для MASLENGO
		for k, v in next, (MASLENGO_DEFAULTS) do
			if MASLENGO[k] == nil then
				MASLENGO[k] = type(v) == "table" and CopyTable(v) or v
			end
		end

		-- Инициализация репутаций
		for _, tbl in ipairs(E.OctoTable_Reputations) do
			for _, v in ipairs(tbl) do
				MASLENGO.reputationFULL[v.id] = InitTable(MASLENGO.reputationFULL[v.id])
			end
		end

		-- Инициализация UniversalQuest
		for _, v in next, (E.OctoTable_UniversalQuest) do
			local key = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
			MASLENGO.UniversalQuest[key] = MASLENGO.UniversalQuest[key] or nil
		end

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
	end
end

function Octo_EventFrame_WTF:Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = InitTable(Octo_ToDo_DB_Vars)

	-- Настройки отладки
	local debugDefaults = {
		DebugIDs = false,
		DebugInfo = false,
		DebugEvent = false,
		DebugFunction = false,
		DebugButton = false
	}

	for k, v in next, (debugDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
		E[k] = Octo_ToDo_DB_Vars[k]
	end

	-- Размеры и параметры интерфейса
	local uiDefaults = {
		AddonHeight = 20,
		AddonLeftFrameWeight = 220,
		AddonCentralFrameWeight = 110,
		MainFrameDefaultLines = 30,
		SFDropDownWeight = 100,
		MaxNumCharacters = 10,
		FrameScale = 1,
		GameMenuFrameScale = 0.8,
		LevelToShow = 1,
		LevelToShowMAX = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT),
		prefix = 1
	}

	for k, v in next, (uiDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
	end

	-- Настройки функций
	local featureDefaults = {
		AchievementShowCompleted = true,
		AidingtheAccord = true,
		AnotherAddonsCasual = true,
		AnotherAddonsDUNG = true,
		AnotherAddonsRAID = true,
		Auto_ChatClearing = false,
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
		CurrencyShowAllways = false,
		CVar = true,
		Dungeons = true,
		EmeraldDream_Dreamseeds = true,
		EmeraldDream_Rares = true,
		EmeraldDream_Sparks = true,
		EmeraldDream_WB = true,
		Event = true,
		Gold = true,
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
		Holidays = false,
		InputDelete = true,
		ItemLevel = true,
		Items = true,
		ItemsShowAllways = false,
		ItemsUsable = false,
		LastUpdate = true,
		LootFrame = true,
		MajorKeyflames = true,
		MinorKeyflames = true,
		MP_MythicKeystone = true,
		OnlyCurrentFaction = false,
		PortalsButtons = true,
		PortalsButtonsOnlyAvailable = true,
		Professions = true,
		Quests = true,
		QuestsShowAllways = false,
		Reputations = false,
		ResetAllChars = true,
		ShowIDS = true,
		ShowOnlyCurrentBattleTag = false,
		ShowOnlyCurrentServer = false,
		ShowTime70 = true,
		SORTING = true,
		StaticPopup1Button1 = true,
		TalentTreeTweaks = true,
		TalentTreeTweaks_Alpha = 1,
		TalentTreeTweaks_Scale = 1,
		TWW_Delve_Weekly = true,
		TWW_DungeonQuest_Weekly = true,
		UIErrorsFramePosition = true,
		WasOnline = true,
		WorldBoss_Weekly = true
	}

	for k, v in next, (featureDefaults) do
		InitField(Octo_ToDo_DB_Vars, k, v)
	end

	-- Таблицы по умолчанию
	InitField(Octo_ToDo_DB_Vars, "color", {1, 1, 1})
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
		yOfs = 67
	}

	for k, v in next, (posFrameDefaults) do
		InitField(Octo_ToDo_DB_Vars.PosFrame, k, v)
	end

	-- Настройки интерфейса
	InitSubTable(Octo_ToDo_DB_Vars, "interface")
	local interfaceDefaults = {
		Octo_background = "None",
		Octo_border = "None",
		Octo_statusbar = "Blizzard",
		Octo_font = "Friz Quadrata TT",
		Octo_sound = "None"
	}

	for k, v in next, (interfaceDefaults) do
		InitField(Octo_ToDo_DB_Vars.interface, k, v)
	end
end

function Octo_EventFrame_WTF:Octo_ToDo_DB_Other()
	Octo_ToDo_DB_Other = InitTable(Octo_ToDo_DB_Other)
	InitSubTable(Octo_ToDo_DB_Other, "AccountMoney")
	InitField(Octo_ToDo_DB_Other.AccountMoney, E.BattleTagLocal, 0)
	InitSubTable(Octo_ToDo_DB_Other, "CVar")
	InitSubTable(Octo_ToDo_DB_Other, "Items")
	InitSubTable(Octo_ToDo_DB_Other, "Holiday")
	InitSubTable(Octo_ToDo_DB_Other, "ActiveHoliday")
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
		fullName = false,
		showIcons = false,
		showIconsQuestionMark = true,
		showVersion = false,
		showIndex = false,
		minimaphide = false,
		hookMenuButton = false,
		sortingCpu = false,
		profilingcpuShowCurrent = true,
		profilingcpuShowEncounter = true,
		profilingcpuShowPeak = true,
		profilingcpuShowAverage = true,
		profilingcpuUpdate = 0,
		localizeCategoryName = true,
		showVersions = true,
		autofocusSearch = true,
		sorting = "title",
		showSecureAddons = true,
		addonListStyle = "tree",
		showTocXCategory = true,
		showTocCategory = true,
		showMemoryInBrokerTtp = true
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
	InitSubTable(Octo_DEBUG, "Reputations")
	InitSubTable(Octo_DEBUG, "Octo_MplusButton")
	InitSubTable(Octo_DEBUG, "UniversalQuest")
end

function Octo_EventFrame_WTF:Daily_Reset()
	local ServerTime = GetServerTime()

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (CharInfo.tmstp_Daily or 0) < ServerTime then
			CharInfo.tmstp_Daily = E.func_tmstpDayReset(1)
			CharInfo.needResetDaily = true

			-- Сброс ежедневных квестов
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Daily" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Daily"] = nil
				end
			end

			CharInfo.STARTTODAY = 0
			wipe(CharInfo.MASLENGO.LFGInstance)
			for _, v in ipairs (E.OctoTable_LFGDungeons) do
				CharInfo.MASLENGO.LFGInstance[v] = CharInfo.MASLENGO.LFGInstance[v] or {}
				CharInfo.MASLENGO.LFGInstance[v].donetoday = nil
			end
			Octo_ToDo_DB_Other.Holiday = nil
			Octo_ToDo_DB_Other.professions.DEBUG = nil
			Octo_ToDo_DB_Other.ActiveHoliday = nil
		end
	end
end

function Octo_EventFrame_WTF:Weekly_Reset()
	local ServerTime = GetServerTime()

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (CharInfo.tmstp_Weekly or 0) < ServerTime then
			-- Проверка награды из Великого Хранилища
			for i = 1, #CharInfo.MASLENGO.GreatVault do
				if CharInfo.MASLENGO.GreatVault[i] and CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING ~= 0 then
					CharInfo.HasAvailableRewards = true
					break
				end
			end

			-- Сброс данных
			CharInfo.tmstp_Weekly = E.func_tmstpDayReset(7)
			CharInfo.needResetWeekly = true
			CharInfo.CurrentKey = 0
			CharInfo.CurrentKeyName = 0
			CharInfo.CurrentKeyLevel = 0
			CharInfo.MASLENGO.journalInstance = {}
			CharInfo.MASLENGO.SavedWorldBoss = {}
			CharInfo.RIO_weeklyBest = 0
			CharInfo.MASLENGO.GreatVault = {}
			CharInfo.STARTWEEK = 0

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
		if (CharInfo.tmstp_Month or 0) < ServerTime then
			CharInfo.tmstp_Month = E.func_tmstpDayReset(30)
			CharInfo.needResetMonth = true
			CharInfo.STARTMONTH = 0

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

		-- Инициализация всех баз данных
		self:Octo_ToDo_DB_Levels()
		self:Octo_ToDo_DB_Vars()
		self:Octo_ToDo_DB_Other()
		self:Octo_ToDo_DB_Minecraft()
		self:Octo_Achievements_DB()
		self:Octo_AddonsTable()
		self:Octo_AddonsManager_DB()
		self:Octo_DEBUG()

		-- Сброс данных по времени
		self:Daily_Reset()
		self:Weekly_Reset()
		self:Month_Reset()
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