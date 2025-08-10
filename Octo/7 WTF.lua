local GlobalAddonName, E = ...
----------------------------------------------------------------
local Octo_EventFrame_WTF = CreateFrame("FRAME")
Octo_EventFrame_WTF:Hide()
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки

----------------------------------------------------------------
function Octo_EventFrame_WTF:func_CreateDataCacheAtStart()
	----------------------------------------------------------------
	-- local tblCurrencies = {}
	local tblQuests = {}
	local tblItems = {}
	-- local tblSpells = {}

	for _, v in ipairs(E.OctoTables_DataOtrisovka) do
		for _, currencyID in ipairs(v.Currencies) do
			local currency =  E:func_currencyName(currencyID) -- "AllCurrencies"
		end
		for _, itemID in ipairs(v.Items) do
			if type(itemID) == "number" then
				tblItems[itemID] = true
				-- local item = E:func_itemName(itemID) -- "AllItems"
			end
		end
	end
	----------------------------------------------------------------
	for _, currencyID in ipairs(E.OctoTable_Currencies) do
		local currency = E:func_currencyName(currencyID) -- "AllCurrencies"
	end
	----------------------------------------------------------------
	for _, expansionID in ipairs(E.OctoTable_Reputations) do
		for k, v in next, (expansionID) do
			local reputation = E:func_reputationName(v.id) -- "AllReputations"
		end
	end
	E.Collect_All_Reputations()
	----------------------------------------------------------------
	for _, questID in ipairs(E.OctoTable_QuestID) do
		tblQuests[questID] = true
	end
	for _, questID in ipairs(E.OctoTable_QuestID_Paragon) do
		tblQuests[questID] = true
	end
	for _, data in ipairs(E.OctoTable_UniversalQuest) do
		if not data.quests then
			break -- Пропускаем записи без квестов
		end
		for _, questData in ipairs(data.quests) do
			tblQuests[questData[1]] = true
			if questData.forcedText and questData.forcedText.npcID then
				local npc = E:func_npcName(questData.forcedText.npcID) -- "AllNPCs"
			end
		end
	end
	for i = 1, C_QuestLog.GetNumQuestLogEntries() do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			tblQuests[info.questID] = true
		end
	end

	local promise = LibThingsLoad:QuestsByKey(tblQuests)
	promise:AddItemsByKey(tblItems)
	-- promise:Then(function()
	-- 	print ("THEN")
	-- end)

	promise:ThenForAllWithCached(function(promise, id, type)
			if type == "quest" then
				local quest = E:func_questName(id) -- "AllQuests"
			elseif type == "item" then
				local item = E:func_itemName(id)
				local qw = C_Item.GetItemQualityByID(id)
			end
			-- if Octo_MainFrame_ToDo:IsShown() then
			-- 	E:func_TODO_CreateDataProvider() -- Обновляем данные после загрузки
			-- end
	end)
	-- promise:FailWithChecked(function(promise, id, type)
	-- 	if type == "quest" then
	-- 		print (id)
	-- 	end
	-- end)
	----------------------------------------------------------------
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:DatabaseTransfer()
	local enable = false -- Флаг для включения/отключения переноса
	if not enable then return end
	-- Обрабатываем основную таблицу персонажей
	if Octo_ToDo_DB_Levels then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- Инициализируем таблицу данных игрока
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
				print(k, E.WOW_WoWToken_Color..tostring(value).."|r")
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
function Octo_EventFrame_WTF:CleaningIdenticalCharacters()
	if not Octo_ToDo_DB_Levels then return end

	-- Получаем данные текущего игрока
	local currentGUID = E.curGUID
	local currentName = E.curCharName
	local currentRealm = E.curServer
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
function Octo_EventFrame_WTF:DatabaseClear()
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
		-- Очищаем другие таблицы БД от нулевых и ложных значений
		-- replaceZeroWithNil(Octo_ToDo_DB_Other, {false, 0})
		-- replaceZeroWithNil(Octo_Minecraft_DB, {false, 0})
		-- replaceZeroWithNil(Octo_Achievements_DB, {false, 0})
		-- replaceZeroWithNil(Octo_AddonsTable_DB, {false, 0})
		-- replaceZeroWithNil(Octo_AddonsManager_DB, {false, 0})
		-- replaceZeroWithNil(Octo_Debug_DB, {false, 0})
		-- replaceZeroWithNil(Octo_ToDo_DB_Vars, {false, 0})
		-- replaceZeroWithNil(Octo_QuestsChanged_DB, {false, 0})
		-- replaceZeroWithNil(Octo_Cache_DB, {false, 0})
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_ToDo_DB_Levels()
	-- Получаем GUID текущего игрока
	local curGUID = UnitGUID("player")
	-- Инициализируем основную таблицу данных
	Octo_ToDo_DB_Levels = E:func_InitTable(Octo_ToDo_DB_Levels)
	Octo_ToDo_DB_Levels[curGUID] = E:func_InitTable(Octo_ToDo_DB_Levels[curGUID])
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
		CurrentRegion = E:func_GetCurrentRegion(),
		CurrentRegionName = E:func_GetCurrentRegionName(),
		curServer = E.curServer, -- Текущий сервер
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
		Currency = {}, -- Данные валют
		CovenantAndAnima = { -- Ковенанты и анима
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
		},
		garrisonType = {},
		GarrisonFollowers = {},
		HasGarrison = {},
		GARRISON = {},
		GreatVault = {}, -- Данные Великого Хранилища
		ItemsInBag = {}, -- Предметы в сумках
		journalInstance = {}, -- Инстансы из журнала
		LFGInstance = {}, -- Данные LFG
		ListOfQuests = {}, -- Список квестов
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
		E:func_InitSubTable(CharInfo, "MASLENGO")
		local MASLENGO = CharInfo.MASLENGO
		E:func_InitSubTable(CharInfo, "PlayerData")
		local PlayerData = CharInfo.PlayerData



		-- Заполняем стандартные значения
		for k, v in next, (defaults) do
			E:func_InitField(PlayerData, k, v)
		end
		-- Заполняем MASLENGO значениями по умолчанию
		for k, v in next, (MASLENGO_DEFAULTS) do
			if MASLENGO[k] == nil then
				MASLENGO[k] = type(v) == "table" and CopyTable(v) or v
			end
		end


		for garrisonType, id in next, (Enum.GarrisonType) do
			MASLENGO.garrisonType[id] = MASLENGO.garrisonType[id] or {}
			-- MASLENGO.HasGarrison[id] = MASLENGO.HasGarrison[id] or false
			E:func_InitField(MASLENGO, "HasGarrison", false)
		end


		for i, v in ipairs(E.OctoTable_followerTypeIDs) do
			local name = v.name
			MASLENGO.GarrisonFollowers[name] = MASLENGO.GarrisonFollowers[name] or {}
		end

		-- Заполняем стандартные значения
		for k, v in next, (GARRISON_default) do
			E:func_InitField(MASLENGO.GARRISON, k, v)
		end
		-- Устанавливаем временные метки
		PlayerData.time = PlayerData.time or PlayerData.tmstp_Daily or ServerTime
		PlayerData.MoneyOnLogin = PlayerData.MoneyOnLogin or PlayerData.Money
		-- Заполняем GARRISON значениями по умолчанию
		for k, v in next, (GARRISON_DEFAULTS) do
			if MASLENGO.GARRISON[k] == nil then
				MASLENGO.GARRISON[k] = type(v) == "table" and CopyTable(v) or v
			end
		end

		-- Инициализируем данные репутации
		for _, tbl in ipairs(E.OctoTable_Reputations) do
			for _, v in ipairs(tbl) do
				MASLENGO.Reputation[v.id] = MASLENGO.Reputation[v.id] or "0#0###"
			end
		end
		-- Инициализируем данные LFG инстансов
		for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
			MASLENGO.LFGInstance[dungeonID] = E:func_InitTable(MASLENGO.LFGInstance[dungeonID])
			E:func_InitField(MASLENGO.LFGInstance[dungeonID], "D_name", name)
			MASLENGO.LFGInstance[dungeonID].donetoday = MASLENGO.LFGInstance[dungeonID].donetoday or nil
		end
	end
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = E:func_InitTable(Octo_ToDo_DB_Vars)
	-- Настройки отладки
	local debugDefaults = {
		addonFontSize = 11,
		DebugButton = false, -- Отладка кнопок
		DebugEvent = false, -- Отладка событий
		DebugFunction = false, -- Отладка функций
		DebugIDs = false, -- Отладка ID
		DebugInfo = false, -- Отладка информации
		editorFontSize = 12,
		editorTabSpaces = 4,
		editorTheme = "Twilight",
	}
	for k, v in next, (debugDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars, k, v)
		E[k] = Octo_ToDo_DB_Vars[k] -- Копируем в глобальную таблицу
	end
	-- Настройки функций аддона
	local featureDefaults = {
		Config_ADDON_HEIGHT = 20,
		Config_AlphaOnDrag = 0.8, -- Альфа при перетаскивании
		Config_AchievementShowCompleted = true, -- Показывать завершенные достижения
		Config_Auto_ChatClearing = false, -- Автоочистка чата
		Config_Auto_CinematicCanceler = true, -- Пропуск заставок
		Config_Auto_CinematicFastSkip = true, -- Быстрый пропуск заставок
		Config_Auto_Gossip = true, -- Автопропуск диалогов
		Config_Auto_InputDelete = true, -- Автоочистка ввода
		Config_Auto_OpenItems = true, -- Автооткрытие предметов
		Config_Auto_Repair = true, -- Авторемонт
		Config_Auto_Screenshot = true, -- Автоскриншоты
		Config_Auto_SellGrey = true, -- Автопродажа серых предметов
		Config_Auto_TurnQuests = true, -- Автосдача квестов
		Config_ClampedToScreen = true, -- Не привязывать к границам экрана
		Config_Hide_ActionStatusText = true, -- Скрыть текст статуса действий
		Config_Hide_BossBanner = true, -- Скрыть баннер босса
		Config_Hide_Bug = true, -- Скрыть баг-репортер
		Config_Hide_CheckListText = true, -- Скрыть текст чеклиста
		Config_Hide_CovenantChoiceToast = true, -- Скрыть тост выбора ковенанта
		Config_Hide_CovenantRenownToast = true, -- Скрыть тост ковенанта
		Config_Hide_ErrorMessages = true, -- Скрыть сообщения об ошибках
		Config_Hide_EventToastManagerFrame = true, -- Скрыть тосты событий
		Config_Hide_MainStatusTrackingBarContainer = true, -- Скрыть главную полосу отслеживания
		Config_Hide_MajorFactionsRenownToast = true, -- Скрыть тост репутации фракций
		Config_Hide_OrderHallCommandBar = true, -- Скрыть панель команд
		Config_Hide_PrivateRaidBossEmoteFrameAnchor = true, -- Скрыть якорь эмоций
		Config_Hide_PTRReporter = true, -- Скрыть PTR репортер
		Config_Hide_PTRIssueReporter = true, -- Скрыть репортер проблем
		Config_Hide_PTRIssueReporterAlertFrame = true, -- Скрыть алерт репортера
		Config_Hide_PVPArenaTextString = true, -- Скрыть текст арены
		Config_Hide_RaidBossEmoteFrame = true, -- Скрыть эмоции боссов
		Config_Hide_RaidWarningFrame = true, -- Скрыть предупреждения рейда
		Config_Hide_SecondaryStatusTrackingBarContainer = true, -- Скрыть вторую полосу отслеживания
		Config_Hide_SplashFrame = true, -- Скрыть заставку
		Config_Hide_SubscriptionInterstitialFrame = true, -- Скрыть фрейм подписки
		Config_Hide_SubZoneTextFrame = true, -- Скрыть текст подзоны
		Config_Hide_SubZoneTextString = true, -- Скрыть строку подзоны
		Config_Hide_TalkingHeadFrame = true, -- Скрыть говорящую голову
		Config_Hide_UIWidgetTopCenterContainerFrame = true, -- Скрыть верхний центр виджетов
		Config_Hide_WeeklyRewardExpirationWarningDialog = true, -- Скрыть предупреждение о наградах
		Config_Hide_ZoneTextFrame = true, -- Скрыть текст зоны
		Config_Hide_ZoneTextString = true, -- Скрыть строку зоны
		Config_LevelToShow = 1, -- Минимальный уровень для отображения
		Config_LevelToShowMAX = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT), -- Макс. уровень
		Config_prefix = 1, -- Префикс
		Currencies = true, -- Квесты
		Currency = true, -- Валюта
		CVar = true, -- CVar настройки
		Dungeons = true, -- Подземелья
		Config_FontFlags = "OUTLINE",
		Config_FontSize = 11,
		Config_FontStyle = "|cffd177ffO|r|cffac86f5c|r|cff8895eat|r|cff63A4E0o|r",
		Config_Texture = "Blizzard Raid Bar",




		Gold = true, -- Золото
		Holidays = true, -- Праздники
		ItemLevel = true, -- Уровень предметов
		Items = true, -- Предметы
		OnlyCurrentFaction = false, -- Только текущая фракция
		Professions = true, -- Профессии
		QC_Quests = true, -- Квесты
		QC_Vignettes = false, -- Вигнеты
		Quests = true, -- Квесты
		QuestsShowAllways = false, -- Всегда показывать квесты
		Reputations = false, -- Репутация
		SellFrame = true,
		ShowIDS = true, -- Показывать ID
		ShowOnlyCurrentRegion = false, -- Только текущий BattleTag
		ShowOnlyCurrentServer = false, -- Только текущий сервер
		-- TalentTreeTweaks = true, -- Настройки дерева талантов
		-- TalentTreeTweaks_Alpha = 1, -- Прозрачность дерева
		-- TalentTreeTweaks_Scale = 1, -- Масштаб дерева
		-- TWW_Delve_Weekly = true, -- Еженедельные исследования
		-- TWW_DungeonQuest_Weekly = true, -- Еженедельные квесты подземелий
		-- UIErrorsFramePosition = true, -- Позиция фрейма ошибок
		Config_WasOnline = true, -- Был в сети
		-- WorldBoss_Weekly = true, -- Еженедельные мировые боссы
	}
	-- Устанавливаем значения по умолчанию
	for k, v in next, (featureDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars, k, v)
	end
	-- Инициализируем таблицы настроек
	E:func_InitField(Octo_ToDo_DB_Vars, "AchievementToShow", {[92] = true})
	E:func_InitField(Octo_ToDo_DB_Vars, "ExpansionToShow", {[11] = true})
	-- Настройки фрейма скорости
	E:func_InitSubTable(Octo_ToDo_DB_Vars, "SpeedFrame")
	local speedFrameDefaults = {
		Shown = true, -- Показывать фрейм
		point = "BOTTOM", -- Точка привязки
		relativePoint = "BOTTOM", -- Относительная точка
		xOfs = 129, -- Смещение по X
		yOfs = 67 -- Смещение по Y
	}
	for k, v in next, (speedFrameDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars.SpeedFrame, k, v)
	end
	-- Настройки позиционного фрейма
	E:func_InitSubTable(Octo_ToDo_DB_Vars, "PosFrame")
	local posFrameDefaults = {
		Shown = true, -- Показывать фрейм
		point = "BOTTOM", -- Точка привязки
		relativePoint = "BOTTOM", -- Относительная точка
		xOfs = 129, -- Смещение по X
		yOfs = 67, -- Смещение по Y
	}
	for k, v in next, (posFrameDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars.PosFrame, k, v)
	end
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_ToDo_DB_Other()
	Octo_ToDo_DB_Other = E:func_InitTable(Octo_ToDo_DB_Other)
	-- Инициализация таблицы денег аккаунта
	E:func_InitSubTable(Octo_ToDo_DB_Other, "AccountMoney")
	E:func_InitField(Octo_ToDo_DB_Other.AccountMoney, E.CurrentRegionName, 0)
	-- Инициализация таблиц настроек
	-- E:func_InitSubTable(Octo_ToDo_DB_Other, "CVar")
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_Cache_DB()
	Octo_Cache_DB = E:func_InitTable(Octo_Cache_DB)
	E:func_InitField(Octo_Cache_DB, "lastBuildNumber", 1)
	E:func_InitField(Octo_Cache_DB, "lastFaction", UNKNOWN)
	E:func_InitField(Octo_Cache_DB, "lastLocaleLang", UNKNOWN)
	-- Инициализация подтаблиц
	E:func_InitSubTable(Octo_Cache_DB, "AllItems")
	E:func_InitSubTable(Octo_Cache_DB, "AllCurrencies")
	E:func_InitSubTable(Octo_Cache_DB, "AllNPCs")
	E:func_InitSubTable(Octo_Cache_DB, "AllQuests")
	E:func_InitSubTable(Octo_Cache_DB, "AllReputations")
	E:func_InitSubTable(Octo_Cache_DB, "AllSpells")

	E:func_InitSubTable(Octo_Cache_DB, "watchedMovies")


end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_Achievements_DB()
	Octo_Achievements_DB = E:func_InitTable(Octo_Achievements_DB)
	-- Настройки отображения достижений
	E:func_InitField(Octo_Achievements_DB, "Config_AchievementShowCompleted", true)
	E:func_InitField(Octo_Achievements_DB, "AchievementToShow", {[92] = true})
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_AddonsManager_DB()
	Octo_AddonsManager_DB = E:func_InitTable(Octo_AddonsManager_DB)
	-- Инициализация подтаблиц
	E:func_InitSubTable(Octo_AddonsManager_DB, "collapsedAddons")
	E:func_InitSubTable(Octo_AddonsManager_DB, "profiles")
	E:func_InitSubTable(Octo_AddonsManager_DB.profiles, "forceload")
	-- Настройка принудительной загрузки текущего аддона
	E:func_InitField(Octo_AddonsManager_DB.profiles.forceload, GlobalAddonName, true)
	-- Настройки конфигурации
	E:func_InitSubTable(Octo_AddonsManager_DB, "config")
	local configDefaults = {
		addonListStyle = "tree", -- Стиль списка как дерево
		autofocusSearch = nil, -- Автофокус в поиске
		fullName = nil, -- Полное имя
		hookMenuButton = nil, -- Хук кнопки меню
		localizeCategoryName = nil, -- Локализовать имена категорий
		minimaphide = nil, -- Скрыть на миникарте
		profilingcpuShowAverage = nil, -- Показывать среднюю нагрузку
		profilingcpuShowCurrent = nil, -- Показывать текущую нагрузку CPU
		profilingcpuShowEncounter = nil, -- Показывать нагрузку в бою
		profilingcpuShowPeak = nil, -- Показывать пиковую нагрузку
		profilingcpuUpdate = nil, -- Обновление профилирования CPU
		showIcons = nil, -- Показывать иконки
		showIconsQuestionMark = nil, -- Показывать знаки вопроса у иконок
		showIndex = nil, -- Показывать индекс
		showMemoryInBrokerTtp = nil, -- Показывать память в брокере
		showSecureAddons = nil, -- Показывать защищенные аддоны
		showTocCategory = nil, -- Показывать категории TOC
		showTocXCategory = nil, -- Показывать категории TOC
		showVersion = nil, -- Показывать версию
		showVersions = nil, -- Показывать версии
		sorting = "title", -- Сортировка по названию
		sortingCpu = nil, -- Сортировка по CPU
	}
	-- Устанавливаем значения по умолчанию
	for k, v in next, (configDefaults) do
		E:func_InitField(Octo_AddonsManager_DB.config, k, v)
	end
	-- Дополнительные настройки
	E:func_InitField(Octo_AddonsManager_DB, "isCategoryFrameVisible", true)
	E:func_InitSubTable(Octo_AddonsManager_DB, "lock")
	E:func_InitSubTable(Octo_AddonsManager_DB.lock, "addons")
	E:func_InitField(Octo_AddonsManager_DB.lock.addons, E.MainAddonName, true)
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_AddonsTable_DB()
	Octo_AddonsTable_DB = E:func_InitTable(Octo_AddonsTable_DB)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_Debug_DB()
	Octo_Debug_DB = E:func_InitTable(Octo_Debug_DB)
	E:func_InitSubTable(Octo_Debug_DB, "Functions")

	if not Octo_Debug_DB then return end
	Octo_Debug_DB.profileKeys = Octo_Debug_DB.profileKeys or {}

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local currentKey = CharInfo.PlayerData.Name.." - "..CharInfo.PlayerData.curServer
			Octo_Debug_DB.profileKeys[currentKey] = "OctoUI"
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_LoadAddons_DB()
	Octo_LoadAddons_DB = E:func_InitTable(Octo_LoadAddons_DB)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_Minecraft_DB()
	Octo_Minecraft_DB = E:func_InitTable(Octo_Minecraft_DB)
	-- Настройки цвета переднего плана
	E:func_InitSubTable(Octo_Minecraft_DB, "ColorFG")
	E:func_InitField(Octo_Minecraft_DB.ColorFG, "r", 1) -- Красный
	E:func_InitField(Octo_Minecraft_DB.ColorFG, "g", 1) -- Зеленый
	E:func_InitField(Octo_Minecraft_DB.ColorFG, "b", 1) -- Синий
	E:func_InitField(Octo_Minecraft_DB.ColorFG, "a", 1) -- Альфа
	-- Настройки цвета фона
	E:func_InitSubTable(Octo_Minecraft_DB, "ColorBG")
	E:func_InitField(Octo_Minecraft_DB.ColorBG, "r", 1) -- Красный
	E:func_InitField(Octo_Minecraft_DB.ColorBG, "g", 1) -- Зеленый
	E:func_InitField(Octo_Minecraft_DB.ColorBG, "b", 1) -- Синий
	E:func_InitField(Octo_Minecraft_DB.ColorBG, "a", 1) -- Альфа
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_Moduls_DB()
	Octo_Moduls_DB = E:func_InitTable(Octo_Moduls_DB)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Octo_QuestsChanged_DB()
	Octo_QuestsChanged_DB = E:func_InitTable(Octo_QuestsChanged_DB)
	-- Инициализация подтаблиц
	E:func_InitSubTable(Octo_QuestsChanged_DB, "QC_Quests")
	E:func_InitSubTable(Octo_QuestsChanged_DB, "QC_Vignettes")
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:Daily_Reset()
	if E:func_IsRetail() then
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
				for _, data in ipairs(E.OctoTable_UniversalQuest) do
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
			end
		end
	end
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Weekly_Reset()
	if E:func_IsRetail() then
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
				for _, data in ipairs(E.OctoTable_UniversalQuest) do
					if data.reset == "Weekly" then
						local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						CharInfo.MASLENGO.UniversalQuest[questKey] = nil
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
function Octo_EventFrame_WTF:Month_Reset()
	if E:func_IsRetail() then
		local tmstp_Month = E:func_tmstpDayReset(365/12)
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- Проверяем нужно ли выполнить сброс
			if (CharInfo.PlayerData.tmstp_Month or 0) < GetServerTime() then
				-- Устанавливаем новую временную метку
				CharInfo.PlayerData.tmstp_Month = tmstp_Month
				CharInfo.PlayerData.needResetMonth = true
				-- Сбрасываем ежемесячные квесты
				for _, data in ipairs(E.OctoTable_UniversalQuest) do
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
local MyEventsTable = {
	"ADDON_LOADED", -- Событие загрузки аддона
	"VARIABLES_LOADED", -- Событие загрузки переменных
	"PLAYER_LOGIN",
}
----------------------------------------------------------------
E:func_RegisterMyEventsToFrames(Octo_EventFrame_WTF, MyEventsTable)
------------------------------------------------------------
----------------------------------------------------------------
function Octo_EventFrame_WTF:ADDON_LOADED(addonName)
	-- Проверяем что загрузился наш аддон
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end


function Octo_EventFrame_WTF:VARIABLES_LOADED()
	-- Чистка персонажей при старте
	self:CleaningIdenticalCharacters()
	-- self:DatabaseClear() -- ОЧЕНЬ ДОЛГАЯ
	-- Инициализация всех компонентов
	self:Octo_Cache_DB() -- Кэш данных
	self:DatabaseTransfer() -- Перенос данных
	self:Octo_ToDo_DB_Levels() -- Данные персонажей
	self:Octo_ToDo_DB_Vars() -- Настройки
	self:Octo_ToDo_DB_Other() -- Другие данные
	self:Octo_Minecraft_DB() -- Minecraft стиль
	self:Octo_Achievements_DB() -- Достижения
	self:Octo_AddonsTable_DB() -- Таблица аддонов
	self:Octo_AddonsManager_DB() -- Менеджер аддонов
	self:Octo_Debug_DB() -- Отладка
	self:Octo_LoadAddons_DB()
	self:Octo_Moduls_DB()
	self:Octo_QuestsChanged_DB() -- Изменения квестов
	-- Применяем старые изменения
	E:setOldChanges()

	if not E.func_ConcatAtStart_UniversalQuestQWE then
		E.func_ConcatAtStart_UniversalQuestQWE = true
		E:func_Universal_91_Concat()
	end

	-- Очистка и сброс данных
	self:Daily_Reset()
	self:Weekly_Reset()
	self:Month_Reset()

	-- local fontFile, height, flags = E.OctoFont11:GetFont() -- "Interface\\Addons\\"..E.MainAddonName.."\\Media\\02_Fonts\\Octo.TTF"
	-- if Octo_ToDo_DB_Vars.Config_FontStyle and Octo_ToDo_DB_Vars.Config_FontStyle ~= "" then
	-- fontFile = Octo_ToDo_DB_Vars.Config_FontStyle
	-- end
	E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.Config_FontStyle), Octo_ToDo_DB_Vars.Config_FontSize, Octo_ToDo_DB_Vars.Config_FontFlags)
	-- E.OctoFont11:SetFont(Octo_ToDo_DB_Vars.Config_FontStyle, Octo_ToDo_DB_Vars.Config_FontSize, Octo_ToDo_DB_Vars.Config_FontFlags)
	-- E.OctoFont11:SetFont(fontFile, Octo_ToDo_DB_Vars.Config_FontSize, Octo_ToDo_DB_Vars.Config_FontFlags)

	-- E.LINES_MAX =  Octo_ToDo_DB_Vars.Config_MainFrameDefaultLines
	-- E.GLOBAL_LINE_HEIGHT = Octo_ToDo_DB_Vars.AddonHeight
	-- E.GLOBAL_LINE_WIDTH_LEFT = Octo_ToDo_DB_Vars.AddonLeftFrameWeight
	-- E.GLOBAL_LINE_WIDTH_RIGHT = Octo_ToDo_DB_Vars.AddonCentralFrameWeight
end


function Octo_EventFrame_WTF:PLAYER_LOGIN()
	-- Обновляем кэш
	-- if Octo_Cache_DB.lastBuildNumber ~= E.buildNumber or Octo_Cache_DB.lastFaction ~= E.curFaction or Octo_Cache_DB.lastLocaleLang ~= E.curLocaleLang then
		self:func_CreateDataCacheAtStart()
		Octo_Cache_DB.lastBuildNumber = E.buildNumber
		Octo_Cache_DB.lastFaction = E.curFaction
		Octo_Cache_DB.lastLocaleLang = E.curLocaleLang





		Octo_ToDo_DB_Vars.DebugButton = E.DebugButton -- Отладка кнопок
		Octo_ToDo_DB_Vars.DebugEvent = E.DebugEvent -- Отладка событий
		Octo_ToDo_DB_Vars.DebugFunction = E.DebugFunction -- Отладка функций
		Octo_ToDo_DB_Vars.DebugIDs = E.DebugIDs  -- Отладка ID
		Octo_ToDo_DB_Vars.DebugInfo = E.DebugInfo -- Отладка информации



	-- end
end