local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки
----------------------------------------------------------------
function EventFrame:func_CacheGameData()
	----------------------------------------------------------------
	local tblCurrencies = E.ALL_Currencies
	-- local E.ALL_Quests = E.ALL_Quests
	-- local E.ALL_Items = E.ALL_Items
	local tblSpells = {}
	----------------------------------------------------------------
	E.func_TableConcat(E.ALL_Quests, E.OctoTable_QuestID_Paragon)
	E.func_TableConcat(E.ALL_Quests, E.OctoTable_QuestID)
	E.func_TableConcat(E.ALL_Quests, E.OctoTable_RemixInfinityResearch)
	----------------------------------------------------------------
	for id in next,(E.ALL_Currencies) do -- for id = 42, 4000 do -- 42, 3372
		local name = E.func_GetCurrencyName(id)
	end
	-- for id in next,(E.ALL_Items) do
	-- local name = E.func_GetItemName(id)
	-- end
	for id in next,(E.ALL_Reputations) do
		local name = E.func_GetReputationName(id) -- "AllReputations"
	end
	-- for id in next,(E.ALL_Quests) do
	-- local name = E.func_GetQuestName(id)
	-- end
	for _, id in next,(E.OctoTable_NPC) do
		local name = E.func_GetNPCName(id)
	end
	----------------------------------------------------------------
	-- E.Collect_All_Reputations()
	----------------------------------------------------------------
	for i = 1, C_QuestLog.GetNumQuestLogEntries() do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			E.ALL_Quests[info.questID] = true
		end
	end
	for _, CharInfo in next, Octo_ToDo_DB_Levels do
		local MASLENGO = CharInfo.MASLENGO
		if MASLENGO then
			-- Квесты
			local questList = MASLENGO.ListOfQuests
			if questList then
				for questID in next,(questList) do
					E.ALL_Quests[questID] = true
				end
			end
			local ItemsInBag = MASLENGO.ItemsInBag
			if ItemsInBag then
				for itemID in next,(ItemsInBag) do
					E.ALL_Items[itemID] = true
				end
			end
		end
	end
	local promise = LibThingsLoad:QuestsByKey(E.ALL_Quests)
	promise:AddItemsByKey(E.ALL_Items)
	-- promise:Then(function()
	-- print ("THEN")
	-- end)
	promise:ThenForAllWithCached(function(promise, ID, type)
			if type == "quest" then
				local quest = E.func_GetQuestName(ID) -- "AllQuests"
			elseif type == "item" then
				local item = E.func_GetItemName(ID)
				local qw = C_Item.GetItemQualityByID(ID)
			end
			-- if Octo_MainFrame_ToDo:IsShown() then
			-- E.func_TODO_CreateDataProvider() -- Обновляем данные после загрузки
			-- end
	end)
	-- promise:FailWithChecked(function(promise, ID, type)
	-- if type == "quest" then
	-- print (ID)
	-- end
	-- end)
	----------------------------------------------------------------
end
----------------------------------------------------------------
function EventFrame:func_RemoveDuplicateCharacters()
	if not Octo_ToDo_DB_Levels then return end
	-- Получаем данные текущего игрока
	local currentGUID = E.curGUID
	local currentName = E.curCharName
	local currentRealm = E.func_GetPlayerRealm()
	local foundDuplicates = false
	-- Проходим по всем записям
	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			-- Проверяем совпадение имени и сервера
			if CharInfo.PlayerData.Name and CharInfo.PlayerData.curServer and
			CharInfo.PlayerData.Name == currentName and
			CharInfo.PlayerData.curServer == currentRealm then
				-- Если это НЕ текущий игрок - отмечаем найденный дубликат
				if GUID ~= currentGUID then
					foundDuplicates = true
					break
				end
			end
		end
	end
	-- Если дубликаты найдены - выполняем очистку
	if foundDuplicates then
		for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
			if CharInfo.PlayerData then
				if CharInfo.PlayerData.Name and CharInfo.PlayerData.curServer and
				CharInfo.PlayerData.Name == currentName and
				CharInfo.PlayerData.curServer == currentRealm then
					if GUID ~= currentGUID then
						print(L["Removing duplicate: "], CharInfo.PlayerData.Name.."-"..CharInfo.PlayerData.curServer, "GUID:", GUID)
						Octo_ToDo_DB_Levels[GUID] = nil
					else
						print(L["Keeping current: "], CharInfo.PlayerData.Name.."-"..CharInfo.PlayerData.curServer, "GUID:", GUID)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
function EventFrame:func_DatabaseClear()
	local enable = true -- Флаг включения/отключения очистки
	if not enable then return end
	if Octo_ToDo_DB_Levels then
		-- Удаляем значения по шаблону "^0/"
		E.func_RemoveZeroValues(Octo_ToDo_DB_Levels, "^0/")
		-- Очищаем валютные данные персонажей
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.MASLENGO and CharInfo.MASLENGO.CurrencyID_Total then
				E.func_RemoveZeroValues(CharInfo.MASLENGO.CurrencyID_Total, "anynumber")
			end
			if string.find(CharInfo.PlayerData.Name, "^WTF:") then
				print ("Remove: ", CharInfo.PlayerData.Name)
				Octo_ToDo_DB_Levels[GUID] = nil
			end
		end
	end
	local rules = {
		zero = true, -- удалять значения == 0
		emptyString = true, -- удалять ""
		falseValue = false, -- удалять false (обычно не надо)
		values = { -- точное совпадение
			"Done",
			"0/0",
			0,
		},
		strings = { -- подстроки / паттерны
			"|cff", -- цветовой мусор
			"|r",
			"#%d+/", -- если ты где-то оставил прогресс в строке
		},
		-- (необязательно, но полезно)
		keepKeys = { -- НИКОГДА не удалять ключ
			"PlayerData",
			"CharInfo",
		}
	}
	E.func_CleanDeepTable(Octo_profileKeys, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Levels, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Vars, rules)
	E.func_CleanDeepTable(Octo_Cache_DB, rules)
	E.func_CleanDeepTable(Octo_DevTool_DB, rules)
end
----------------------------------------------------------------
function EventFrame:Octo_ToDo_DB_Levels()
	-- Получаем GUID текущего игрока
	local curGUID = UnitGUID("player")
	if not curGUID then return end
	-- Инициализируем основную таблицу данных
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	Octo_ToDo_DB_Levels[curGUID] = Octo_ToDo_DB_Levels[curGUID] or {}
	-- Получаем текущее серверное время и дату
	local ServerTime = GetServerTime()
	local currentDate = date("%d.%m.%Y")
	local currentTime = date("%H:%M")
	local currentDateTime = date("%d.%m.%Y %H:%M:%S")
	-- Стандартные значения для данных игрока
	local defaults = {
		BattleTag = E.BattleTag, -- BattleTag
		BattleTagLocal = E.BattleTagLocal, -- Локальный BattleTag
		buildDate = E.buildDate, -- Дата сборки
		buildNumber = E.buildNumber, -- Номер сборки
		buildVersion = E.buildVersion, -- Версия сборки игры
		classColor = E.classColor, -- Цвет класса
		classColorHex = E.classColorHexCurrent, -- Цвет класса в HEX
		className = E.className, -- Имя класса
		classFilename = E.classFilename, -- Техническое имя класса
		CurrentRegion = E.func_GetCurrentRegion(),
		CurrentRegionName = E.CurrentRegionName,
		curServer = E.func_GetPlayerRealm(), -- Текущий сервер
		curServerShort = E.curServerShort, -- Короткое имя сервера
		currentTier = E.currentTier, -- Текущий игровой тир
		Faction = "Horde", -- Фракция
		GUID = "curGUID", -- Идентификатор персонажа
		guildName = "", -- Название гильдии
		guildRankName = "", -- Ранг в гильдии
		interfaceVersion = E.interfaceVersion, -- Версия интерфейса
		isShownPlayer = true, -- Флаг отображения
		loginDate = currentDateTime, -- Дата входа
		loginDay = currentDate, -- День входа
		loginHour = currentTime, -- Время входа
		Name = "WTF:"..E.curCharName, -- Имя персонажа
		PlayerDurability = 100,
	}
	-- Стандартные значения для MASLENGO таблицы
	local MASLENGO_DEFAULTS = {
		CovenantAndAnima = { -- Ковенанты и анима
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
		},
		Currency = {}, -- Данные валют
		GARRISON = {},
		LegionRemixData = {},
		GreatVault = {}, -- Данные Великого Хранилища
		ItemsInBag = {}, -- Предметы в сумках
		journalInstance = {}, -- Инстансы из журнала
		LFGInstance = {}, -- Данные LFG
		ListOfQuests = {}, -- Список квестов
		ListOfParagonQuests = {}, -- Список квестов парагона
		OctoTable_QuestID = {}, -- Квесты по ID
		professions = { -- Профессии
			-- [1] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			-- [2] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			-- [3] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			-- [4] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			-- [5] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0}
		},
		Reputation = {}, -- Данные репутации
		SavedWorldBoss = {}, -- Сохраненные мировые боссы
		UniversalQuest = {}, -- Универсальные квесты
	}
	-- Стандартные значения для данных игрока
	local GARRISON_default = {
		cacheSize = 0,
		curRes = 0,
		lastCacheTime = 0,
	}
	-- Стандартные значения для GARRISON таблицы
	local GARRISON_DEFAULTS = {
		buids = {
		},
		summary = {
			inProgress = {},
		},
	}
	-- Инициализация GreatVault
	for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
		MASLENGO_DEFAULTS.GreatVault[i] = {}
	end
	-- Устанавливаем текущий ID ковенанта
	MASLENGO_DEFAULTS.CovenantAndAnima.curCovID = nil
	-- Обрабатываем всех персонажей в базе
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Инициализируем подтаблицы
		E.func_InitSubTable(CharInfo, "MASLENGO")
		local MASLENGO = CharInfo.MASLENGO
		E.func_InitSubTable(CharInfo, "PlayerData")
		local PlayerData = CharInfo.PlayerData
		-- Заполняем стандартные значения
		for k, v in next, (defaults) do
			E.func_InitField(PlayerData, k, v)
		end
		-- Заполняем MASLENGO значениями по умолчанию
		for k, v in next, (MASLENGO_DEFAULTS) do
			if MASLENGO[k] == nil then
				MASLENGO[k] = type(v) == "table" and CopyTable(v) or v
			end
		end
		-- Заполняем стандартные значения
		for k, v in next, (GARRISON_default) do
			E.func_InitField(MASLENGO.GARRISON, k, v)
		end
		-- Устанавливаем временные метки
		PlayerData.time = PlayerData.time or PlayerData.tmstp_Daily or ServerTime
		PlayerData.MoneyOnLogin = PlayerData.MoneyOnLogin or PlayerData.Money
		PlayerData.MoneyOnDaily = PlayerData.MoneyOnDaily or PlayerData.Money
		PlayerData.MoneyOnWeekly = PlayerData.MoneyOnWeekly or PlayerData.Money
		-- Заполняем GARRISON значениями по умолчанию
		for k, v in next, (GARRISON_DEFAULTS) do
			if MASLENGO.GARRISON[k] == nil then
				MASLENGO.GARRISON[k] = type(v) == "table" and CopyTable(v) or v
			end
		end
		-- Инициализируем данные репутации
		for ID in next,(E.ALL_Reputations) do
			MASLENGO.Reputation[ID] = MASLENGO.Reputation[ID] or "0#0###"
		end
		-- Инициализируем данные LFG инстансов
		for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
			MASLENGO.LFGInstance[dungeonID] = MASLENGO.LFGInstance[dungeonID] or {}
			E.func_InitField(MASLENGO.LFGInstance[dungeonID], "D_name", name)
			MASLENGO.LFGInstance[dungeonID].donetoday = MASLENGO.LFGInstance[dungeonID].donetoday or nil
		end
	end
end
----------------------------------------------------------------
function EventFrame:Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	-- Настройки отладки
	-- Настройки функций аддона
	local featureDefaults = {
		Config_SPAM_TIME = 3,
		Config_ADDON_HEIGHT = 20,
		Config_AlphaOnTheMove = 1, -- Альфа в движении
		Config_AchievementShowCompleted = true, -- Показывать завершенные достижения
		Config_ClampedToScreen = false, -- Не привязывать к границам экрана
		Config_LevelToShow = 1, -- Минимальный уровень для отображения
		Config_LevelToShowMAX = 90, -- GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT), -- Макс. уровень
		Config_numberFormatMode = 1, -- по умолчанию универсальный
		Currencies = true, -- Квесты
		Config_Texture = "Blizzard Raid Bar",
		isOnlyCurrentFaction = false, -- Только текущая фракция
		ShowOnlyCurrentRegion = true, -- Только текущий BattleTag
		isOnlyCurrentServer = false, -- Только текущий сервер
		-- isSettingsEnabled = false,
		-- TalentTreeTweaks = true, -- Настройки дерева талантов
		-- TalentTreeTweaks_Alpha = 1, -- Прозрачность дерева
		-- TalentTreeTweaks_Scale = 1, -- Масштаб дерева
		-- TWW_Delve_Weekly = true, -- Еженедельные исследования
		-- TWW_DungeonQuest_Weekly = true, -- Еженедельные квесты подземелий
		-- UIErrorsFramePosition = true, -- Позиция фрейма ошибок
		-- WorldBoss_Weekly = true, -- Еженедельные мировые боссы
	}
	-- Устанавливаем значения по умолчанию
	for k, v in next, (featureDefaults) do
		E.func_InitField(Octo_ToDo_DB_Vars, k, v)
	end
	-- Octo_ToDo_DB_Vars.font = Octo_ToDo_DB_Vars.font or {}
	-- Octo_ToDo_DB_Vars.font[E.curLocaleLang] = Octo_ToDo_DB_Vars.font[E.curLocaleLang] or {}
	-- Octo_ToDo_DB_Vars.font[E.curLocaleLang].Config_FontStyle = "|cffd177ffO|r|cffac86f5c|r|cff8895eat|r|cff63A4E0o|r"
	-- Octo_ToDo_DB_Vars.font[E.curLocaleLang].Config_FontSize = 11
	-- Octo_ToDo_DB_Vars.font[E.curLocaleLang].Config_FontFlags = "OUTLINE"
	-- Инициализируем таблицы настроек
	E.func_InitField(Octo_ToDo_DB_Vars, "ExpansionToShow", {
			[7] = true, -- Legion
			[98] = true,
			[99] = true
	})
	Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle or "|cffd177ffO|r|cffac86f5c|r|cff8895eat|r|cff63A4E0o|r" -- "|cffd177ffN|r|cffb682f7a|r|cff9a8ef0o|r|cff7f99e8w|r|cff63A4E0h|r"
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or 11
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags or "OUTLINE"
end
----------------------------------------------------------------
function EventFrame:Octo_Cache_DB()
	Octo_Cache_DB = Octo_Cache_DB or {}
	E.func_InitField(Octo_Cache_DB, "lastBuildNumber", 1)
	E.func_InitField(Octo_Cache_DB, "lastFaction", UNKNOWN)
	E.func_InitField(Octo_Cache_DB, "lastLocaleLang", UNKNOWN)
	-- Инициализация подтаблиц
	E.func_InitSubTable(Octo_Cache_DB, "AllItems")
	E.func_InitSubTable(Octo_Cache_DB, "AllCurrencies")
	E.func_InitSubTable(Octo_Cache_DB, "AllNPCs")
	E.func_InitSubTable(Octo_Cache_DB, "AllQuests")
	E.func_InitSubTable(Octo_Cache_DB, "AllReputations")
	E.func_InitSubTable(Octo_Cache_DB, "AllSpells")
	E.func_InitSubTable(Octo_Cache_DB, "AllAchievements")
	E.func_InitSubTable(Octo_Cache_DB, "AllVignettes")
	E.func_InitSubTable(Octo_Cache_DB, "AllEvents")
	E.func_InitSubTable(Octo_Cache_DB, "AllProfessions")
	E.func_InitSubTable(Octo_Cache_DB, "watchedMovies")
end
----------------------------------------------------------------
function EventFrame:Octo_DevTool_DB()
	Octo_DevTool_DB = Octo_DevTool_DB or {}
	-- EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	----------------------------------------------------------------
	local defaultOptions = {
		Config_DebugID_ALL = false,
		Config_DebugID_Items = false, --E.debugInfo_Items(id)
		Config_DebugID_Currencies = false, --E.debugInfo_Currencies(id)
		Config_DebugID_NPCs = false, --E.debugInfo_NPCs(id)
		Config_DebugID_Quests = false, --E.debugInfo_Quests(id)
		Config_DebugID_Reputations = false, --E.debugInfo_Reputations(id)
		Config_DebugID_Spells = false, --E.debugInfo_Spells(id)
		Config_DebugID_Achievements = false, --E.debugInfo_Achievements(id)
		Config_DebugID_Mounts = false, --E.debugInfo_Mounts(mountID)
		Config_DebugID_Maps = false, --E.debugInfo_Maps(id)
		Config_DebugID_Events = false, --E.debugInfo_Events(id)
		Config_DebugID_Professions = false, --E.debugInfo_Professions(id)
		Config_DebugID_instanceID = false, --E.debugInfo_instanceID(id) ПОФИКСИТЬ
		Config_DebugID_worldBossID = false, --E.debugInfo_worldBossID(id) ПОФИКСИТЬ
		DebugCharacterInfo = false,
		DebugEvent = false,
		DebugFunction = false,
		DebugButton = false,
		DebugGossip = false,
		DebugCache = false,
		DebugQC_Vignettes = false,
		DebugQC_Quests = false,
		DebugUniversal = false,
		editorFontSize = 12, -- for i = 10, 16 do
		editorTabSpaces = 4, -- for _, v in ipairs({0, 2, 3, 4}) do
		editorTheme = "Twilight", -- for name in next, E.editorThemes do
	}
	for k, v in next, (defaultOptions) do
		E.func_InitField(Octo_DevTool_DB, k, v)
		E[k] = Octo_DevTool_DB[k] -- Копируем в глобальную таблицу
	end
	E.func_InitField(Octo_DevTool_DB, "lastFaction", UNKNOWN)
	E.func_InitField(Octo_DevTool_DB, "lastLocaleLang", UNKNOWN)
	-- Инициализация подтаблиц
	E.func_InitSubTable(Octo_DevTool_DB, "AllItems")
	E.func_InitSubTable(Octo_DevTool_DB, "AllCurrencies")
	E.func_InitSubTable(Octo_DevTool_DB, "AllNPCs")
	E.func_InitSubTable(Octo_DevTool_DB, "AllQuests")
	E.func_InitSubTable(Octo_DevTool_DB, "AllReputations")
	E.func_InitSubTable(Octo_DevTool_DB, "AllSpells")
	E.func_InitSubTable(Octo_DevTool_DB, "AllAchievements")
	E.func_InitSubTable(Octo_DevTool_DB, "AllVignettes")
	E.func_InitSubTable(Octo_DevTool_DB, "AllEvents")
	E.func_InitSubTable(Octo_DevTool_DB, "AllProfessions")
	E.func_InitSubTable(Octo_DevTool_DB, "watchedMovies")
	----------------------------------------------------------------
	if Octo_DevTool_DB.profileKeys and type(Octo_DevTool_DB.profileKeys) ~= "table" then
		Octo_DevTool_DB.profileKeys = {}
	end
	Octo_DevTool_DB.profileKeys = Octo_DevTool_DB.profileKeys or {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local currentKey = CharInfo.PlayerData.Name.." - "..CharInfo.PlayerData.curServer
			Octo_DevTool_DB.profileKeys[currentKey] = "OctoUI"
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
function EventFrame:Octo_profileKeys()
	local db = Octo_profileKeys
	----------------------------------------------------------------
	----------------------------------------------------------------
	E.func_CreateNewProfile("Default")
	----------------------------------------------------------------
	--
	----------------------------------------------------------------
	for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
		E.ALL_Items[itemID] = true
	end
	for reputationID in next,(E.OctoTable_ReputationsDB) do
		E.ALL_Reputations[reputationID] = true
	end
	----------------------------------------------------------------
	if not Octo_ToDo_DB_Levels then return end
	----------------------------------------------------------------
	for GUID, CharInfo in next,(Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		if pd and pd.Name and pd.curServer then
			local key = pd.Name .. " - " .. pd.curServer
			db.profileKeys[key] = db.profileKeys[key] or "Default"
		end
	end
	----------------------------------------------------------------
	-- E.OctoTables_Vibor[categoryKey] = E.OctoTables_Vibor[categoryKey] or {}
	-- opde(OctoTables_Vibor)
	-- opde(OctoTables_DataOtrisovka)
end
----------------------------------------------------------------
function EventFrame:func_Daily_Reset()
	local ServerTime = GetServerTime()
	local SecondsUntilDailyReset = C_DateAndTime.GetSecondsUntilDailyReset()
	-- /dump E.func_SecondsToClock(C_DateAndTime.GetSecondsUntilDailyReset(), true)
	-- Обрабатываем всех персонажей
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do

		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO



		-- Проверяем нужно ли выполнить сброс
		if CharInfo.PlayerData.tmstp_Daily and CharInfo.PlayerData.tmstp_Daily < ServerTime then
			-- Устанавливаем новую временную метку вне зависимости от региона
			CharInfo.PlayerData.tmstp_Daily = CharInfo.PlayerData.tmstp_Daily + 86400
			CharInfo.PlayerData.needResetDaily = true
			-- Сбрасываем ежедневные квесты
			for _, data in next,(E.ALL_UniversalQuests) do
				if data.reset == "Daily" then
					local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
					CharInfo.MASLENGO.UniversalQuest[questKey] = nil
				end
			end


			for instanceID, v in next, (cm.journalInstance) do
				if v then
					for difficultyID, w in next, (v) do
						if w and w.instanceReset and w.instanceReset < time() then -- 1765512000
							cm.journalInstance[instanceID][difficultyID] = nil
							-- print (w.instanceName, "NEEDRESET")
						end
					end
				end
			end
			for dungeonID, v in next, (cm.LFGInstance) do
				if v then
					if cm.LFGInstance[dungeonID].donetoday then
						print (cm.LFGInstance[dungeonID].donetoday)
					end
				end
			end
			for worldBossID, v in next, (cm.SavedWorldBoss) do
				if v then
					print (cm.SavedWorldBoss.reset)
				end
			end












			-- print (CharInfo.PlayerData.Name)
			-- Очищаем данные LFG
			wipe(CharInfo.MASLENGO.LFGInstance)
			for _, v in ipairs (E.OctoTable_LFGDungeons) do
				CharInfo.MASLENGO.LFGInstance[v] = CharInfo.MASLENGO.LFGInstance[v] or {}
				CharInfo.MASLENGO.LFGInstance[v].donetoday = nil
			end
			-- Сбрасываем деньги
			if CharInfo.PlayerData.MoneyOnDaily and CharInfo.PlayerData.Money then
				CharInfo.PlayerData.MoneyOnDaily = CharInfo.PlayerData.Money
			end
			-- Сбрасываем LegionRemixResearch
			if CharInfo.MASLENGO.LegionRemixData and CharInfo.MASLENGO.LegionRemixData.barValue and CharInfo.MASLENGO.LegionRemixData.barMax then
				if CharInfo.MASLENGO.LegionRemixData.barValue > 3 then
					CharInfo.MASLENGO.LegionRemixData.barValue = CharInfo.MASLENGO.LegionRemixData.barValue - 3 -- либо 6, хз как затрекать (ПОФИКСИТЬ)
				end
			end
		end
	end
end
----------------------------------------------------------------
function EventFrame:func_Weekly_Reset()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Проверяем нужно ли выполнить сброс
		if CharInfo.PlayerData.tmstp_Weekly and CharInfo.PlayerData.tmstp_Weekly < ServerTime then
			-- Устанавливаем новую временную метку вне зависимости от региона
			CharInfo.PlayerData.tmstp_Weekly = CharInfo.PlayerData.tmstp_Weekly + 86400*7
			CharInfo.PlayerData.needResetWeekly = true
			-- Проверяем есть ли награды в Великом Хранилище
			for i = 1, #CharInfo.MASLENGO.GreatVault do
				if CharInfo.MASLENGO.GreatVault[i] and
				CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING and
				CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING ~= 0 then
					CharInfo.PlayerData.HasAvailableRewards = true
					break
				end
			end
			-- Сбрасываем данные ключей
			CharInfo.PlayerData.CurrentKey = nil
			CharInfo.PlayerData.CurrentKeyName = nil
			CharInfo.PlayerData.CurrentKeyLevel = nil
			CharInfo.PlayerData.RIO_weeklyBest = nil
			-- Очищаем временные данные
			CharInfo.MASLENGO.journalInstance = {}
			CharInfo.MASLENGO.SavedWorldBoss = {}
			CharInfo.MASLENGO.GreatVault = {}
			-- Сбрасываем еженедельные квесты
			for _, data in next,(E.ALL_UniversalQuests) do
				if data.reset == "Weekly" then
					local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
					CharInfo.MASLENGO.UniversalQuest[questKey] = nil
				end
			end
			-- Сбрасываем деньги
			if CharInfo.PlayerData.MoneyOnWeekly and CharInfo.PlayerData.Money then
				CharInfo.PlayerData.MoneyOnWeekly = CharInfo.PlayerData.Money
			end
		end
	end
end
----------------------------------------------------------------
function EventFrame:func_Month_Reset()
	local tmstp_Month = E.func_GetNextResetTime(365/12)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Проверяем нужно ли выполнить сброс
		if (CharInfo.PlayerData.tmstp_Month or 0) < GetServerTime() then
			-- Устанавливаем новую временную метку
			CharInfo.PlayerData.tmstp_Month = tmstp_Month
			CharInfo.PlayerData.needResetMonth = true
			-- Сбрасываем ежемесячные квесты
			for _, data in next,(E.ALL_UniversalQuests) do
				if data.reset == "Month" then
					local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
					CharInfo.MASLENGO.UniversalQuest[questKey] = nil
				end
			end
		end
	end
end
----------------------------------------------------------------
function EventFrame:func_CheckAll()
	-- Чистка персонажей при старте
	EventFrame:func_RemoveDuplicateCharacters()
	-- EventFrame:func_DatabaseClear() -- ОЧЕНЬ ДОЛГАЯ
	-- Инициализация всех компонентов
	EventFrame:Octo_Cache_DB() -- Кэш данных
	EventFrame:Octo_ToDo_DB_Levels() -- Данные персонажей
	EventFrame:Octo_ToDo_DB_Vars() -- Настройки
	EventFrame:Octo_DevTool_DB()
	-- Применяем старые изменения
	E.func_setOldChanges()
	-- Очистка и сброс данных
	EventFrame:func_Daily_Reset()
	EventFrame:func_Weekly_Reset()
	EventFrame:func_Month_Reset()
end
function EventFrame:func_ScheduleResetTimer()
	local seconds = E.func_GetTimeToReset()
	if seconds and seconds > 0 then
		-- На случай, если уже был таймер — отменим
		if timerHandle then
			timerHandle:Cancel()
		end
		-- Запускаем новый
		timerHandle = C_Timer.NewTimer(seconds + 4, function()
				EventFrame:func_CheckAll()
				E.func_Collect_All()
				EventFrame:func_ScheduleResetTimer() -- Планируем следующий ресет
		end)
	end
end
function EventFrame:func_UpdateGlobals()
	if Octo_ToDo_DB_Vars then
		if Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT then
			E.GLOBAL_LINE_HEIGHT = Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT
			E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2 -- Высота заголовка
			E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
			E.ddMenuButtonHeight = E.GLOBAL_LINE_HEIGHT
		end
		if Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle then
			E.func_UpdateFont()
		end
		E.SPAM_TIME = Octo_ToDo_DB_Vars.Config_SPAM_TIME
	end
	if Octo_DevTool_DB then
		E.DebugButton = Octo_DevTool_DB.DebugButton
		E.DebugEvent = Octo_DevTool_DB.DebugEvent
		E.DebugFunction = Octo_DevTool_DB.DebugFunction
		E.Config_DebugID_ALL = Octo_DevTool_DB.Config_DebugID_ALL
		E.DebugCharacterInfo = Octo_DevTool_DB.DebugCharacterInfo
		E.DebugGossip = Octo_DevTool_DB.DebugGossip
		E.DebugCache = Octo_DevTool_DB.DebugCache
		E.DebugQC_Vignettes = Octo_DevTool_DB.DebugQC_Vignettes
		E.DebugQC_Quests = Octo_DevTool_DB.DebugQC_Quests
		E.DebugUniversal = Octo_DevTool_DB.DebugUniversal
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	----------------------------------------------------------------
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
	OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	EventFrame:func_CheckAll()
	EventFrame:Octo_profileKeys()
	----------------------------------------------------------------
	EventFrame:func_UpdateGlobals()
	----------------------------------------------------------------
end
function EventFrame:VARIABLES_LOADED()
	EventFrame:func_CheckAll()
end

function EventFrame:PLAYER_LOGIN()
	-- Обновляем кэш
	-- if Octo_Cache_DB.lastBuildNumber ~= E.buildNumber or Octo_Cache_DB.lastFaction ~= E.FACTION_CURRENT or Octo_Cache_DB.lastLocaleLang ~= E.curLocaleLang then
	EventFrame:func_CacheGameData()
	Octo_Cache_DB.lastBuildNumber = E.buildNumber
	Octo_Cache_DB.lastFaction = E.FACTION_CURRENT
	Octo_Cache_DB.lastLocaleLang = E.curLocaleLang
	-- end
	self:func_ScheduleResetTimer()
	E.Cache_All_EventNames_Year()
end