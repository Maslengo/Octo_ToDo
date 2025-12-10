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
function EventFrame:func_CreateDataCacheAtStart()
	----------------------------------------------------------------
	-- local tblCurrencies = {}
	local tblQuests = {}
	local tblItems = {}
	-- local tblSpells = {}
	----------------------------------------------------------------
	-- for currencyID = 42, 4000 do -- 42, 3372
	for currencyID in next,(E.ALL_Currencies) do
		local currencyName = E.func_currencyName(currencyID)
	end
	----------------------------------------------------------------
	for _, ID in ipairs(E.ALL_Reputations) do
		local reputation = E.func_reputationName(ID) -- "AllReputations"
	end
	E.Collect_All_Reputations()
	----------------------------------------------------------------
	for _, questID in ipairs(E.OctoTable_QuestID) do
		tblQuests[questID] = true
	end
	for _, questID in ipairs(E.OctoTable_QuestID_Paragon) do
		tblQuests[questID] = true
	end
	for i = 1, C_QuestLog.GetNumQuestLogEntries() do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			tblQuests[info.questID] = true
		end
	end
	for _, CharInfo in next, Octo_ToDo_DB_Levels do
		local MASLENGO = CharInfo.MASLENGO
		if MASLENGO then
			-- Квесты
			local questList = MASLENGO.ListOfQuests
			if questList then
				for questID in next, questList do
					tblQuests[questID] = true
					-- totalQuests = totalQuests + 1
				end
			end
			local ItemsInBag = MASLENGO.ItemsInBag
			if ItemsInBag then
				for itemID, itemCount in next, (MASLENGO.ItemsInBag) do
					tblItems[itemID] = true
				end
			end
		end
	end
	local promise = LibThingsLoad:QuestsByKey(tblQuests)
	promise:AddItemsByKey(tblItems)
	-- promise:Then(function()
	-- print ("THEN")
	-- end)
	promise:ThenForAllWithCached(function(promise, ID, type)
			if type == "quest" then
				local quest = E.func_questName(ID) -- "AllQuests"
			elseif type == "item" then
				local item = E.func_itemName(ID)
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
function EventFrame:DatabaseTransfer()
	local enable = false -- Флаг для включения/отключения переноса
	if not enable then return end
	-- Обрабатываем основную таблицу персонажей
	if Octo_ToDo_DB_Levels then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- Инициализируем таблицу данных игрока
			-- GUID = GUID or {}
			CharInfo.PlayerData = CharInfo.PlayerData or {}
			-- Переносим простые поля в PlayerData
			for k, value in pairs(CharInfo) do
				if type(value) ~= "table" then
					print(E.Red_Color..k.."|r", value)
					CharInfo.PlayerData[k] = value
					CharInfo[k] = nil -- Удаляем перенесенное значение
				end
			end
			-- Обрабатываем валютные данные
			if CharInfo.MASLENGO then
				-- Переносим данные CurrencyID в новую структуру
				if CharInfo.MASLENGO.CurrencyID then
					for CurrencyID, value in next, (CharInfo.MASLENGO.CurrencyID) do
						if type(value) == "number" then
							CharInfo.MASLENGO.Currency[CurrencyID] =
							CharInfo.MASLENGO.Currency[CurrencyID] or {}
							CharInfo.MASLENGO.Currency[CurrencyID].quantity = value
						end
					end
					CharInfo.MASLENGO.CurrencyID = nil -- Удаляем старую таблицу
				end
				-- Аналогично для других валютных таблиц
				if CharInfo.MASLENGO.CurrencyID_Total then
					for CurrencyID, value in next, (CharInfo.MASLENGO.CurrencyID_Total) do
						if type(value) == "number" then
							CharInfo.MASLENGO.Currency[CurrencyID] =
							CharInfo.MASLENGO.Currency[CurrencyID] or {}
							CharInfo.MASLENGO.Currency[CurrencyID].maxQuantity = value
						end
					end
					CharInfo.MASLENGO.CurrencyID_Total = nil
				end
				if CharInfo.MASLENGO.CurrencyID_totalEarned then
					for CurrencyID, value in next, (CharInfo.MASLENGO.CurrencyID_totalEarned) do
						if type(value) == "number" then
							CharInfo.MASLENGO.Currency[CurrencyID] =
							CharInfo.MASLENGO.Currency[CurrencyID] or {}
							CharInfo.MASLENGO.Currency[CurrencyID].totalEarned = value
						end
					end
					CharInfo.MASLENGO.CurrencyID_totalEarned = nil
				end
			end
		end
	end
end
----------------------------------------------------------------
local function replaceZeroWithNil(tbl, smth)
	-- Проверка входных параметров
	if not tbl or not smth or type(tbl) ~= "table" then return end
	-- Обработка случая когда smth - таблица значений для удаления
	if type(smth) == "table" then
		for q, w in ipairs(smth) do
			for k, value in pairs(tbl) do
				if value == w then -- Точное совпадение значения
					print(k, E.Yellow_Color..tostring(value).."|r")
					tbl[k] = nil -- Удаляем значение
				elseif type(value) == "table" then
					replaceZeroWithNil(value, w) -- Рекурсия для вложенных таблиц
				end
			end
			return tbl
		end
		-- Обработка числовых значений для удаления
	elseif type(smth) == "number" then
		for k, value in pairs(tbl) do
			if value == smth then
				print(k, E.Purple_Color..tostring(value).."|r")
				tbl[k] = nil
			elseif type(value) == "table" then
				replaceZeroWithNil(value, smth) -- Рекурсия
			end
		end
		return tbl
		-- Обработка строковых шаблонов
	elseif type(smth) == "string" then
		for k, value in pairs(tbl) do
			-- Специальный случай для любых числовых значений
			if value and smth == "anynumber" and type(value) == "number" then
				print(k, E.COLOR_WOW_TOKEN..tostring(value).."|r")
				tbl[k] = nil
			else
				replaceZeroWithNil(value, smth)
			end
			-- Поиск по строковому шаблону
			if value and type(value) == "string" then
				if string.find(value, smth) then
					print(k, E.Magenta_Color..tostring(value).."|r")
					tbl[k] = nil
				end
			else
				replaceZeroWithNil(value, smth)
			end
		end
		return tbl
	end
end
----------------------------------------------------------------
function EventFrame:CleaningIdenticalCharacters()
	if not Octo_ToDo_DB_Levels then return end
	-- Получаем данные текущего игрока
	local currentGUID = E.curGUID
	local currentName = E.curCharName
	local currentRealm = E.func_GetRealmName()
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
function EventFrame:DatabaseClear()
	local enable = true -- Флаг включения/отключения очистки
	if not enable then return end
	if Octo_ToDo_DB_Levels then
		-- Удаляем значения по шаблону "^0/"
		replaceZeroWithNil(Octo_ToDo_DB_Levels, "^0/")
		-- Очищаем валютные данные персонажей
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.MASLENGO and CharInfo.MASLENGO.CurrencyID_Total then
				replaceZeroWithNil(CharInfo.MASLENGO.CurrencyID_Total, "anynumber")
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

	E.func_DeepClean(Octo_profileKeys, rules)
	E.func_DeepClean(Octo_ToDo_DB_Levels, rules)
	E.func_DeepClean(Octo_ToDo_DB_Vars, rules)
	E.func_DeepClean(Octo_ToDo_DB_Other, rules)
	E.func_DeepClean(Octo_Cache_DB, rules)
	E.func_DeepClean(Octo_DevTool_DB, rules)

end
----------------------------------------------------------------
----------------------------------------------------------------
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
		curServer = E.func_GetRealmName(), -- Текущий сервер
		curServerShort = E.curServerShort, -- Короткое имя сервера
		currentTier = E.currentTier, -- Текущий игровой тир
		Faction = "Horde", -- Фракция
		GUID = "curGUID", -- Идентификатор персонажа
		guildName = "", -- Название гильдии
		guildRankName = "", -- Ранг в гильдии
		interfaceVersion = E.interfaceVersion, -- Версия интерфейса
		isShownPLAYER = true, -- Флаг отображения
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
		HasGarrison = {},
		ItemsALL = { -- ПОФИКСИТЬ -> itemID = {bank = 1, bag = 2}
			Bags = {},
			Bank = {},
			Void = {},
			-- БАНК ОТРЯДА НА ВЕСЬ АКК
		},
		ItemsInBag = {}, -- Предметы в сумках
		journalInstance = {}, -- Инстансы из журнала
		LFGInstance = {}, -- Данные LFG
		ListOfQuests = {}, -- Список квестов
		ListOfParagonQuests = {}, -- Список квестов парагона
		OctoTable_QuestID = {}, -- Квесты по ID
		professions = { -- Профессии
			[1] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[2] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[3] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[4] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[5] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0}
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
		for _, ID in ipairs(E.ALL_Reputations) do
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
		Config_ADDON_HEIGHT = 20,
		Config_AlphaOnDrag = 0.7, -- Альфа при перетаскивании
		Config_AchievementShowCompleted = true, -- Показывать завершенные достижения
		Config_ClampedToScreen = false, -- Не привязывать к границам экрана
		Config_LevelToShow = 1, -- Минимальный уровень для отображения
		Config_LevelToShowMAX = 90, -- GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT), -- Макс. уровень
		Config_numberFormatMode = 1, -- по умолчанию универсальный
		Config_GameMenuFrame = 1,
		Currencies = true, -- Квесты
		Config_Texture = "Blizzard Raid Bar",
		OnlyCurrentFaction = false, -- Только текущая фракция
		ShowOnlyCurrentRegion = true, -- Только текущий BattleTag
		ShowOnlyCurrentServer = false, -- Только текущий сервер
		-- SettingsEnabled = false,
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
	E.func_InitField(Octo_ToDo_DB_Vars, "ExpansionToShow", {[7] = true})
	Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle or  "|cffd177ffO|r|cffac86f5c|r|cff8895eat|r|cff63A4E0o|r" -- "|cffd177ffN|r|cffb682f7a|r|cff9a8ef0o|r|cff7f99e8w|r|cff63A4E0h|r"
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or 11
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags or "OUTLINE"
end
----------------------------------------------------------------
function EventFrame:Octo_ToDo_DB_Other()
	Octo_ToDo_DB_Other = Octo_ToDo_DB_Other or {}
	-- Инициализация таблицы денег аккаунта
	E.func_InitSubTable(Octo_ToDo_DB_Other, "AccountMoney")
	E.func_InitField(Octo_ToDo_DB_Other.AccountMoney, E.CurrentRegionName, 0)
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
		CVar = false, -- CVar настройки
		SPAM_TIME = 2,
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
	----------------------------------------------------------------
	--
	----------------------------------------------------------------
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	E.func_InitField(db, "GlobalProfile", "Default")
	E.CurrentProfile = "Default"
	E.func_InitField(db, "useGlobalProfile", false) -- все персонажи игнорируют profileKeys
	E.func_InitField(db, "SettingsEnabled", false) -- только для режима настройки
	E.func_InitSubTable(db, "profileKeys")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, "Default")
	E.func_InitSubTable(db.profiles.Default, "Currencies")
	E.func_InitSubTable(db.profiles.Default, "Items")
	E.func_InitSubTable(db.profiles.Default, "Reputations")
	E.func_InitSubTable(db.profiles.Default, "UniversalQuests")
	E.func_InitSubTable(db.profiles.Default, "Additionally")
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
	-- Развлетвление таблиц для оптимизации
	----------------------------------------------------------------
	-- local OctoTables_Vibor = {} -- func_LoadComponents
	-- local OctoTables_DataOtrisovka = {}

	local defaultProfile = Octo_profileKeys.profiles.Default
	for _, func in next,(E.Components) do
		local one, two = func()
		for i, categoryKey in next,(one) do
			E.OctoTables_Vibor[i] = E.OctoTables_Vibor[i] or categoryKey
		end
		for i, categoryKey in next,(two) do
			E.OctoTables_DataOtrisovka[i] = E.OctoTables_DataOtrisovka[i] or categoryKey
		end
	end
	-- opde(E.OctoTables_DataOtrisovka)
	----------------------------------------------------------------
	-- Заполнение дефолтных настроек
	----------------------------------------------------------------
	E.DataProvider_Otrisovka = {}

	for categoryKey, v in next,(E.OctoTables_DataOtrisovka) do
		for dataType, w in next,(v) do
			E.DataProvider_Otrisovka[categoryKey] = E.DataProvider_Otrisovka[categoryKey] or {}
			E.DataProvider_Otrisovka[categoryKey][dataType] = E.DataProvider_Otrisovka[categoryKey][dataType] or {}
			if dataType ~= "UniversalQuests" then
				for i, z in next,(w) do
					tinsert(E.DataProvider_Otrisovka[categoryKey][dataType], z.id)

					defaultProfile[dataType][z.id] = defaultProfile[dataType][z.id] or z.defS -- nil
					-- defaultProfile[dataType][z.id] = defaultProfile[dataType][z.id] or z.defS -- nil
					if dataType == "Currencies"		then E.ALL_Currencies[z.id] = true		end	-- /run opde(E.ALL_Currencies)
					if dataType == "Items"			then tinsert(E.ALL_Items, z.id)			end	-- /run opde(E.ALL_Items)
					if dataType == "Reputations"	then tinsert(E.ALL_Reputations, z.id)	end	-- /run opde(E.ALL_Reputations)
					if dataType == "Additionally"	then tinsert(E.ALL_Additionally, z.id)	end	-- /run opde(E.ALL_Additionally)
				end
			else
				for _, z in next,(w) do
					tinsert(E.DataProvider_Otrisovka[categoryKey][dataType], z)
					tinsert(E.ALL_UniversalQuests, z)

					local questKey = E.UNIVERSAL..z.desc.."_"..z.name_save.."_"..z.reset
					defaultProfile[dataType][questKey] = defaultProfile[dataType][questKey] or z.defS -- nil
					-- defaultProfile[dataType][questKey] = defaultProfile[dataType][questKey] or z.defS -- nil
				end
			end
		end
	end
	-- opde(E.DataProvider_Otrisovka)
	----------------------------------------------------------------
	--
	----------------------------------------------------------------
	E.func_TableConcat(E.ALL_Items, E.OctoTable_itemID_ALL) -- Octo_Cache_DB.AllItems
	for reputationID in next,(E.OctoTable_ReputationsDB) do
		tinsert(E.ALL_Reputations, reputationID)
	end
	-- wipe(E.ALL_Items)
	-- wipe(E.ALL_Reputations)
	-- wipe(E.ALL_UniversalQuests)
	-- wipe(E.ALL_Additionally)
	----------------------------------------------------------------
	--
	----------------------------------------------------------------
	-- E.OctoTables_Vibor[categoryKey] = E.OctoTables_Vibor[categoryKey] or {}
	-- opde(OctoTables_Vibor)
	-- opde(OctoTables_DataOtrisovka)
end
----------------------------------------------------------------
function EventFrame:Daily_Reset()
	if E.func_IsRetail() then
		local ServerTime = GetServerTime()
		local SecondsUntilDailyReset = C_DateAndTime.GetSecondsUntilDailyReset()
		-- Обрабатываем всех персонажей
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
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
			end
		end
	end
end
----------------------------------------------------------------
function EventFrame:Weekly_Reset()
	if E.func_IsRetail() then
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
end
----------------------------------------------------------------
function EventFrame:Month_Reset()
	if E.func_IsRetail() then
		local tmstp_Month = E.func_tmstpDayReset(365/12)
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
end

----------------------------------------------------------------
function E.func_CheckAll()
	-- Чистка персонажей при старте
	EventFrame:CleaningIdenticalCharacters()
	-- EventFrame:DatabaseClear() -- ОЧЕНЬ ДОЛГАЯ
	-- Инициализация всех компонентов
	EventFrame:Octo_Cache_DB() -- Кэш данных
	EventFrame:DatabaseTransfer() -- Перенос данных
	EventFrame:Octo_ToDo_DB_Levels() -- Данные персонажей
	EventFrame:Octo_ToDo_DB_Vars() -- Настройки
	EventFrame:Octo_ToDo_DB_Other() -- Другие данные
	EventFrame:Octo_DevTool_DB()
	-- Применяем старые изменения
	E.func_setOldChanges()
	-- Очистка и сброс данных
	EventFrame:Daily_Reset()
	EventFrame:Weekly_Reset()
	EventFrame:Month_Reset()
end
local function GetSecondsUntilReset()
	if C_DateAndTime and C_DateAndTime.GetSecondsUntilDailyReset then
		return C_DateAndTime.GetSecondsUntilDailyReset()
	else
		return GetQuestResetTime()
	end
end
function EventFrame:ScheduleNextReset()
	local seconds = GetSecondsUntilReset()
	if seconds and seconds > 0 then
		-- На случай, если уже был таймер — отменим
		if timerHandle then
			timerHandle:Cancel()
		end
		-- Запускаем новый
		timerHandle = C_Timer.NewTimer(seconds + 4, function()
				E.func_CheckAll()
				E.func_Collect_All()
				EventFrame:ScheduleNextReset() -- Планируем следующий ресет
		end)
	end
end


local function func_UpdateGlobals()
	if Octo_ToDo_DB_Vars then
		if Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT then
			E.GLOBAL_LINE_HEIGHT = Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT
			E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2 -- Высота заголовка
			E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
			E.ddMenuButtonHeight = E.GLOBAL_LINE_HEIGHT
		end
		if Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle then
			E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle), Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize, Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags)
		end
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
		E.SPAM_TIME = Octo_DevTool_DB.SPAM_TIME
	end
end

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	----------------------------------------------------------------
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
	OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	E.func_CheckAll()
	EventFrame:Octo_profileKeys()
	----------------------------------------------------------------
	func_UpdateGlobals()
	----------------------------------------------------------------
end
function EventFrame:VARIABLES_LOADED()


	-- if E.func_IsPTR() then
	-- print ("SECRET ON")
	-- C_Timer.After(0, function()
	-- SetCVar("addonChatRestrictionsForced", "1")
	-- SetCVar("secretAurasForced", "1")
	-- SetCVar("secretCooldownsForced", "1")
	-- SetCVar("secretUnitIdentityForced", "1")
	-- SetCVar("secretSpellcastsForced", "1")
	-- SetCVar("secretUnitPowerForced", "1")
	-- SetCVar("secretUnitPowerMaxForced", "1")
	-- SetCVar("secretUnitComparisonForced", "1")
	-- end)
	-- end
	if Octo_DevTool_DB and Octo_DevTool_DB.CVar then
		E.func_LoadCVars()
	end
	E.func_CheckAll()
end
function EventFrame:PLAYER_LOGOUT()
	-- if E.func_IsPTR() then
	-- 	SetCVar("addonChatRestrictionsForced", "0")
	-- 	SetCVar("secretAurasForced", "0")
	-- 	SetCVar("secretCooldownsForced", "0")
	-- 	SetCVar("secretUnitIdentityForced", "0")
	-- 	SetCVar("secretSpellcastsForced", "0")
	-- 	SetCVar("secretUnitPowerForced", "0")
	-- 	SetCVar("secretUnitPowerMaxForced", "0")
	-- 	SetCVar("secretUnitComparisonForced", "0")
	-- end

end
function EventFrame:PLAYER_LOGIN()
	-- Обновляем кэш
	-- if Octo_Cache_DB.lastBuildNumber ~= E.buildNumber or Octo_Cache_DB.lastFaction ~= E.curFaction or Octo_Cache_DB.lastLocaleLang ~= E.curLocaleLang then
	EventFrame:func_CreateDataCacheAtStart()
	Octo_Cache_DB.lastBuildNumber = E.buildNumber
	Octo_Cache_DB.lastFaction = E.curFaction
	Octo_Cache_DB.lastLocaleLang = E.curLocaleLang
	-- end
	self:ScheduleNextReset()
	E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle), Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize, Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags)
	if GameMenuFrame and Octo_ToDo_DB_Vars.Config_GameMenuFrame then
		GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.Config_GameMenuFrame)
	end
	E.Cache_All_EventNames_Year()
end