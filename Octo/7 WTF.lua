local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
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

	E.func_LoadComponents(true)
	for _, v in ipairs(E.OctoTables_DataOtrisovka) do
		-- for _, currencyID in ipairs(v.Currencies) do
		-- local currencyName = E.func_currencyName(currencyID) -- "AllCurrencies"
		-- end
		if v and v.Items then
			for _, itemID in ipairs(v.Items) do
				if type(itemID) == "number" then
					tblItems[itemID] = true
					-- local item = E.func_itemName(itemID) -- "AllItems"
				end
			end
		end
	end
	----------------------------------------------------------------
	for currencyID = 42, 4000 do -- 42, 3372
		local currencyName = E.func_currencyName(currencyID) -- "AllCurrencies"
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
	for _, data in next,(E.ALL_UniversalQuests) do
		if not data.quests then
			break -- Пропускаем записи без квестов
		end
		for _, questData in ipairs(data.quests) do
			if questData[1] then
				tblQuests[questData[1]] = true
				if questData.forcedText and questData.forcedText.npcID then
					local npc = E.func_npcName(questData.forcedText.npcID) -- "AllNPCs"
				end
			end
		end
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
		Config_AlphaOnDrag = 0.8, -- Альфа при перетаскивании
		Config_AchievementShowCompleted = true, -- Показывать завершенные достижения
		Config_ClampedToScreen = false, -- Не привязывать к границам экрана
		Config_LevelToShow = 1, -- Минимальный уровень для отображения
		Config_LevelToShowMAX = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT), -- Макс. уровень
		Config_prefix = 1, -- Префикс
		Config_numberFormatMode = 1, -- по умолчанию универсальный
		Config_GameMenuFrame = 1,
		Currencies = true, -- Квесты
		Config_Texture = "Blizzard Raid Bar",
		OnlyCurrentFaction = false, -- Только текущая фракция
		ShowIDS = true, -- Показывать ID
		ShowOnlyCurrentRegion = false, -- Только текущий BattleTag
		ShowOnlyCurrentServer = false, -- Только текущий сервер
		SettingsEnabled = false,
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
	E.func_InitField(Octo_ToDo_DB_Vars, "ExpansionToShow", {[11] = true})
	Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = "|cffd177ffO|r|cffac86f5c|r|cff8895eat|r|cff63A4E0o|r"
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = 11
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = "OUTLINE"
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


----------------------------------------------------------------
function EventFrame:Octo_ToDo_DB_VisualUserSettings()

	Octo_ToDo_DB_VisualUserSettings = Octo_ToDo_DB_VisualUserSettings or {}
	Octo_ToDo_DB_VisualUserSettings.Items = Octo_ToDo_DB_VisualUserSettings.Items or {}
	Octo_ToDo_DB_VisualUserSettings.SettingsEnabled = false
	Octo_ToDo_DB_VisualUserSettings.Currencies = Octo_ToDo_DB_VisualUserSettings.Currencies or {}
	Octo_ToDo_DB_VisualUserSettings.Reputations = Octo_ToDo_DB_VisualUserSettings.Reputations or {}
	Octo_ToDo_DB_VisualUserSettings.UniversalQuests = Octo_ToDo_DB_VisualUserSettings.UniversalQuests or {}
	Octo_ToDo_DB_VisualUserSettings.Additionally = Octo_ToDo_DB_VisualUserSettings.Additionally or {}
	Octo_ToDo_DB_VisualUserSettings.Other = Octo_ToDo_DB_VisualUserSettings.Other or {}

	wipe(E.ALL_Currencies)
	wipe(E.ALL_Items)
	wipe(E.ALL_Reputations)
	wipe(E.ALL_UniversalQuests)
	wipe(E.ALL_Additionally)

	E.func_LoadComponents(true)
	for dropdownOrder, value in next,(E.OctoTables_Vibor) do
		E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka[dropdownOrder].Currencies)
		E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka[dropdownOrder].Items)
		E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka[dropdownOrder].Reputations)
		E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests)
		E.func_TableConcat(E.ALL_Additionally, E.OctoTables_DataOtrisovka[dropdownOrder].Additionally)
	end
	-- E.func_TableConcat(E.ALL_Currencies, E.OctoTable_itemID_ALL) -- Octo_Cache_DB.AllCurrencies
	E.func_TableConcat(E.ALL_Items, E.OctoTable_itemID_ALL) -- Octo_Cache_DB.AllItems
	for reputationID in next,(E.OctoTable_ReputationsDB) do
		tinsert(E.ALL_Reputations, reputationID)
	end

	-- E.func_TableConcat(E.ALL_UniversalQuests, E.ALL_Items)
	-- E.func_TableConcat(E.ALL_Additionally, E.ALL_Items)
	-- ----------------------------------------------------------------
	for _, ID in next,(E.ALL_Currencies) do
		if type(ID) == "table" then
			for _, subID in ipairs(ID) do
				if Octo_ToDo_DB_VisualUserSettings.Currencies[subID] == nil then
					Octo_ToDo_DB_VisualUserSettings.Currencies[subID] = true
				end
			end
		else
			if Octo_ToDo_DB_VisualUserSettings.Currencies[ID] == nil then
				Octo_ToDo_DB_VisualUserSettings.Currencies[ID] = true
			end
		end
	end
	----------------------------------------------------------------
	for _, ID in next,(E.ALL_Items) do
		if type(ID) == "table" then
			for _, subID in ipairs(ID) do
				if Octo_ToDo_DB_VisualUserSettings.Items[subID] == nil then
					Octo_ToDo_DB_VisualUserSettings.Items[subID] = true
				end
			end
		else
			if Octo_ToDo_DB_VisualUserSettings.Items[ID] == nil then
				Octo_ToDo_DB_VisualUserSettings.Items[ID] = true
			end
		end
	end
	----------------------------------------------------------------
	for _, ID in next,(E.ALL_Reputations) do
		if type(ID) == "table" then
			for _, subID in ipairs(ID) do
				if Octo_ToDo_DB_VisualUserSettings.Reputations[subID] == nil then
					Octo_ToDo_DB_VisualUserSettings.Reputations[subID] = true
				end
			end
		else
			if Octo_ToDo_DB_VisualUserSettings.Reputations[ID] == nil then
				Octo_ToDo_DB_VisualUserSettings.Reputations[ID] = true
			end
		end
	end
	----------------------------------------------------------------
	for _, data in next,(E.ALL_UniversalQuests) do
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		if Octo_ToDo_DB_VisualUserSettings.UniversalQuests[questKey] == nil then
			Octo_ToDo_DB_VisualUserSettings.UniversalQuests[questKey] = true
		end
	end
	----------------------------------------------------------------
	for _, ID in next,(E.ALL_Additionally) do
		if type(ID) == "table" then
			for _, subID in ipairs(ID) do
				if Octo_ToDo_DB_VisualUserSettings.Additionally[subID] == nil then
					Octo_ToDo_DB_VisualUserSettings.Additionally[subID] = true
				end
			end
		else
			if Octo_ToDo_DB_VisualUserSettings.Additionally[ID] == nil then
				Octo_ToDo_DB_VisualUserSettings.Additionally[ID] = true
			end
		end
	end
	----------------------------------------------------------------
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
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
	OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	E.func_CheckAll()
end
function EventFrame:VARIABLES_LOADED()
	E.func_CheckAll()
end
function EventFrame:PLAYER_LOGIN()
	self:Octo_ToDo_DB_VisualUserSettings() --Настройка отображения игроков
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