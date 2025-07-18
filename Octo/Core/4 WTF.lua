--[[
Главный модуль аддона для управления данными персонажей и их сбросом
Содержит функции для работы с базами данных, обработки событий и управления временными сбросами
]]

-- Получаем глобальное имя аддона и основную таблицу из внешнего контекста
local GlobalAddonName, E = ...

-- Создаем фрейм для обработки игровых событий
local Octo_EventFrame_WTF = CreateFrame("FRAME")
Octo_EventFrame_WTF:Hide() -- Сразу скрываем фрейм, он будет показан при необходимости

----------------------------------------------------------------
-- Вспомогательные функции
----------------------------------------------------------------

--[[
Рекурсивно заменяет нулевые или указанные значения в таблице на nil
@param tbl - таблица для обработки
@param smth - значение или шаблон для поиска (может быть число, строка или таблица)
@return обработанная таблица с удаленными значениями
]]
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
-- Основные функции работы с базой данных
----------------------------------------------------------------

--[[
Переносит данные между таблицами в базе данных
Выполняет реструктуризацию старых форматов данных в новые
]]
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
							print(CurrencyID, value)
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

--[[
Очищает базу данных от нулевых и неиспользуемых значений
]]
function Octo_EventFrame_WTF:DatabaseClear()
	local enable = false -- Флаг включения/отключения очистки
	if not enable then return end

	if Octo_ToDo_DB_Levels then
		-- Удаляем значения по шаблону "^0/"
		replaceZeroWithNil(Octo_ToDo_DB_Levels, "^0/")

		-- Очищаем валютные данные персонажей
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.MASLENGO and CharInfo.MASLENGO.CurrencyID_Total then
				replaceZeroWithNil(CharInfo.MASLENGO.CurrencyID_Total, "anynumber")
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

--[[
Инициализирует основную таблицу данных персонажей
Содержит информацию об уровнях, валютах, репутации и других характеристиках
]]
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
		className = E.className, -- Имя класса
		classFilename = E.classFilename, -- Техническое имя класса
		GUID = "curGUID", -- Идентификатор персонажа
		classColor = E.classColor, -- Цвет класса
		curServer = E.curServer, -- Текущий сервер
		guildName = "", -- Название гильдии
		guildRankName = "", -- Ранг в гильдии
		curServerShort = E:func_CurServerShort(E.curServer), -- Короткое имя сервера
		Faction = "Horde", -- Фракция
		BattleTag = E.BattleTag, -- BattleTag
		BattleTagLocal = E.BattleTagLocal, -- Локальный BattleTag
		buildVersion = E.buildVersion, -- Версия сборки игры
		buildNumber = E.buildNumber, -- Номер сборки
		buildDate = E.buildDate, -- Дата сборки
		interfaceVersion = E.interfaceVersion, -- Версия интерфейса
		currentTier = E.currentTier, -- Текущий игровой тир
		Name = "E.curCharName", -- Имя персонажа
		classColorHex = E.classColorHexCurrent, -- Цвет класса в HEX
		loginDate = currentDateTime, -- Дата входа
		loginDay = currentDate, -- День входа
		loginHour = currentTime, -- Время входа
		isShownPLAYER = true, -- Флаг отображения
	}

	-- Стандартные значения для MASLENGO таблицы
	local MASLENGO_DEFAULTS = {
		Reputation = {}, -- Данные репутации
		Currency = {}, -- Данные валют
		UniversalQuest = {}, -- Универсальные квесты
		OctoTable_QuestID = {}, -- Квесты по ID
		ListOfQuests = {}, -- Список квестов
		professions = { -- Профессии
			[1] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[2] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[3] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[4] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0},
			[5] = {skillLine = 0, skillLevel = 0, maxSkillLevel = 0}
		},
		ItemsInBag = {}, -- Предметы в сумках
		GreatVault = {}, -- Данные Великого Хранилища
		CovenantAndAnima = { -- Ковенанты и анима
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
		},
		journalInstance = {}, -- Инстансы из журнала
		SavedWorldBoss = {}, -- Сохраненные мировые боссы
		LFGInstance = {}, -- Данные LFG
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

		-- Устанавливаем временные метки
		PlayerData.time = PlayerData.time or PlayerData.tmstp_Daily or ServerTime
		PlayerData.MoneyOnLogin = PlayerData.MoneyOnLogin or PlayerData.Money

		-- Заполняем MASLENGO значениями по умолчанию
		for k, v in next, (MASLENGO_DEFAULTS) do
			if MASLENGO[k] == nil then
				MASLENGO[k] = type(v) == "table" and CopyTable(v) or v
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

--[[
Инициализирует таблицу переменных аддона
Содержит настройки интерфейса, флаги функций и другие параметры
]]
function Octo_EventFrame_WTF:Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = E:func_InitTable(Octo_ToDo_DB_Vars)

	-- Настройки размеров интерфейса
	local uiDefaults = {
		AddonHeight = 20, -- Высота аддона
		AddonLeftFrameWeight = 256, -- Ширина левой панели
		AddonCentralFrameWeight = 128, -- Ширина центральной панели
		MainFrameDefaultLines = 30, -- Количество строк по умолчанию
		SFDropDownWeight = 100, -- Ширина выпадающих списков
		MaxNumCharacters = 10, -- Макс. число отображаемых персонажей
		FrameScale = 1, -- Масштаб фрейма
		GameMenuFrameScale = 0.8, -- Масштаб меню игры
		LevelToShow = 1, -- Минимальный уровень для отображения
		LevelToShowMAX = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT), -- Макс. уровень
		prefix = 1, -- Префикс
		DontSavePosition = true, -- Не сохранять позицию
		ClampedToScreen = false, -- Не привязывать к границам экрана
	}

	-- Устанавливаем значения по умолчанию
	for k, v in next, (uiDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars, k, v)
	end

	-- Настройки отладки
	local debugDefaults = {
		DebugIDs = false, -- Отладка ID
		DebugInfo = false, -- Отладка информации
		DebugEvent = false, -- Отладка событий
		DebugFunction = false, -- Отладка функций
		DebugButton = false, -- Отладка кнопок
	}

	for k, v in next, (debugDefaults) do
		E:func_InitField(Octo_ToDo_DB_Vars, k, v)
		E[k] = Octo_ToDo_DB_Vars[k] -- Копируем в глобальную таблицу
	end

	-- Настройки функций аддона
	local featureDefaults = {
		Auto_SellGrey = false, -- Автопродажа серых предметов
		Auto_Repair = false, -- Авторемонт
		Auto_InputDelete = false, -- Автоочистка ввода
		Auto_OpenItems = false, -- Автооткрытие предметов
		Auto_Gossip = false, -- Автопропуск диалогов
		Auto_TurnQuests = false, -- Автосдача квестов
		Auto_ChatClearing = false, -- Автоочистка чата
		Auto_Screenshot = false, -- Автоскриншоты
		Auto_CinematicCanceler = false, -- Пропуск заставок
		Auto_CinematicFastSkip = false, -- Быстрый пропуск заставок
		Hide_CheckListText = false, -- Скрыть текст чеклиста
		Hide_SubscriptionInterstitialFrame = false, -- Скрыть фрейм подписки
		Hide_ActionStatusText = false, -- Скрыть текст статуса действий
		Hide_SecondaryStatusTrackingBarContainer = false, -- Скрыть вторую полосу отслеживания
		Hide_MainStatusTrackingBarContainer = false, -- Скрыть главную полосу отслеживания
		Hide_WeeklyRewardExpirationWarningDialog = false, -- Скрыть предупреждение о наградах
		Hide_MajorFactionsRenownToast = false, -- Скрыть тост репутации фракций
		Hide_UIWidgetTopCenterContainerFrame = false, -- Скрыть верхний центр виджетов
		Hide_BossBanner = false, -- Скрыть баннер босса
		Hide_RaidWarningFrame = false, -- Скрыть предупреждения рейда
		Hide_RaidBossEmoteFrame = false, -- Скрыть эмоции боссов
		Hide_PrivateRaidBossEmoteFrameAnchor = false, -- Скрыть якорь эмоций
		Hide_SplashFrame = false, -- Скрыть заставку
		Hide_PTRReporter = false, -- Скрыть PTR репортер
		Hide_PTRIssueReporter = false, -- Скрыть репортер проблем
		Hide_PTRIssueReporterAlertFrame = false, -- Скрыть алерт репортера
		Hide_Bug = false, -- Скрыть баг-репортер
		Hide_CovenantRenownToast = false, -- Скрыть тост ковенанта
		Hide_CovenantChoiceToast = false, -- Скрыть тост выбора ковенанта
		Hide_ZoneTextFrame = false, -- Скрыть текст зоны
		Hide_SubZoneTextFrame = false, -- Скрыть текст подзоны
		Hide_PVPArenaTextString = false, -- Скрыть текст арены
		Hide_ZoneTextString = false, -- Скрыть строку зоны
		Hide_SubZoneTextString = false, -- Скрыть строку подзоны
		Hide_OrderHallCommandBar = false, -- Скрыть панель команд
		Hide_ErrorMessages = false, -- Скрыть сообщения об ошибках
		Hide_TalkingHeadFrame = false, -- Скрыть говорящую голову
		Hide_EventToastManagerFrame = false, -- Скрыть тосты событий
		AchievementShowCompleted = true, -- Показывать завершенные достижения
		AidingtheAccord = true, -- Помощь Согласию
		AnotherAddonsCasual = true, -- Другие аддоны (обычные)
		AnotherAddonsDUNG = true, -- Другие аддоны (подземелья)
		AnotherAddonsRAID = true, -- Другие аддоны (рейды)
		BeledarCycle = true, -- Цикл Беледара
		ChallengesKeystoneFrame = true, -- Фрейм ключей
		Currency = true, -- Валюта
		CVar = true, -- CVar настройки
		EmeraldDream_Dreamseeds = true, -- Сны Изумрудного Сна
		EmeraldDream_Rares = true, -- Рейры Изумрудного Сна
		EmeraldDream_Sparks = true, -- Искры Изумрудного Сна
		EmeraldDream_WB = true, -- Мировые боссы Изумрудного Сна
		LastUpdate = true, -- Последнее обновление
		LootFrame = true, -- Фрейм лута
		MajorKeyflames = true, -- Основные ключевые пламена
		MinorKeyflames = true, -- Второстепенные ключевые пламена
		MP_MythicKeystone = true, -- М+ ключи
		PortalsButtons = true, -- Кнопки порталов
		PortalsButtonsOnlyAvailable = true, -- Только доступные порталы
		QC_Quests = true, -- Квесты
		ShowIDS = true, -- Показывать ID
		StaticPopup1Button1 = true, -- Кнопка попапа
		TalentTreeTweaks = true, -- Настройки дерева талантов
		TalentTreeTweaks_Alpha = 1, -- Прозрачность дерева
		TalentTreeTweaks_Scale = 1, -- Масштаб дерева
		TWW_Delve_Weekly = true, -- Еженедельные исследования
		TWW_DungeonQuest_Weekly = true, -- Еженедельные квесты подземелий
		UIErrorsFramePosition = true, -- Позиция фрейма ошибок
		WorldBoss_Weekly = true, -- Еженедельные мировые боссы
		Quests = true, -- Квесты
		Holidays = true, -- Праздники
		Dungeons = true, -- Подземелья
		Items = true, -- Предметы
		Professions = true, -- Профессии
		Gold = true, -- Золото
		ItemLevel = true, -- Уровень предметов
		WasOnline = true, -- Был в сети
		Reputations = false, -- Репутация
		CurrencyShowAllways = false, -- Всегда показывать валюту
		ItemsShowAllways = false, -- Всегда показывать предметы
		ItemsUsable = false, -- Только используемые предметы
		OnlyCurrentFaction = false, -- Только текущая фракция
		QuestsShowAllways = false, -- Всегда показывать квесты
		QC_Vignettes = false, -- Вигнеты
		ShowOnlyCurrentBattleTag = false, -- Только текущий BattleTag
		ShowOnlyCurrentServer = false, -- Только текущий сервер
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

--[[
Инициализирует таблицу других данных
Содержит информацию о деньгах аккаунта, CVar настройках и праздниках
]]
function Octo_EventFrame_WTF:Octo_ToDo_DB_Other()
	Octo_ToDo_DB_Other = E:func_InitTable(Octo_ToDo_DB_Other)

	-- Инициализация таблицы денег аккаунта
	E:func_InitSubTable(Octo_ToDo_DB_Other, "AccountMoney")
	E:func_InitField(Octo_ToDo_DB_Other.AccountMoney, E.BattleTagLocal, 0)

	-- Инициализация таблиц настроек
	E:func_InitSubTable(Octo_ToDo_DB_Other, "CVar")
	E:func_InitSubTable(Octo_ToDo_DB_Other, "Items")
	E:func_InitSubTable(Octo_ToDo_DB_Other, "Holiday")
	E:func_InitSubTable(Octo_ToDo_DB_Other, "professions")
end

--[[
Инициализирует таблицу Minecraft данных
Содержит настройки цветов для Minecraft-стиля
]]
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

--[[
Инициализирует таблицу достижений
Содержит настройки отображения достижений
]]
function Octo_EventFrame_WTF:Octo_Achievements_DB()
	Octo_Achievements_DB = E:func_InitTable(Octo_Achievements_DB)

	-- Настройки отображения достижений
	E:func_InitField(Octo_Achievements_DB, "AchievementShowCompleted", true)
	E:func_InitField(Octo_Achievements_DB, "AchievementToShow", {[92] = true})
end

--[[
Инициализирует таблицу аддонов
Пустая таблица для хранения информации о аддонах
]]
function Octo_EventFrame_WTF:Octo_AddonsTable_DB()
	Octo_AddonsTable_DB = E:func_InitTable(Octo_AddonsTable_DB)
end

--[[
Инициализирует таблицу менеджера аддонов
Содержит настройки управления аддонами
]]
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
		sorting = "title", -- Сортировка по названию
		addonListStyle = "tree", -- Стиль списка как дерево
		profilingcpuUpdate = nil, -- Обновление профилирования CPU
		showIconsQuestionMark = nil, -- Показывать знаки вопроса у иконок
		profilingcpuShowCurrent = nil, -- Показывать текущую нагрузку CPU
		profilingcpuShowEncounter = nil, -- Показывать нагрузку в бою
		profilingcpuShowPeak = nil, -- Показывать пиковую нагрузку
		profilingcpuShowAverage = nil, -- Показывать среднюю нагрузку
		localizeCategoryName = nil, -- Локализовать имена категорий
		showVersions = nil, -- Показывать версии
		autofocusSearch = nil, -- Автофокус в поиске
		showSecureAddons = nil, -- Показывать защищенные аддоны
		showTocXCategory = nil, -- Показывать категории TOC
		showTocCategory = nil, -- Показывать категории TOC
		showMemoryInBrokerTtp = nil, -- Показывать память в брокере
		fullName = nil, -- Полное имя
		showIcons = nil, -- Показывать иконки
		showVersion = nil, -- Показывать версию
		showIndex = nil, -- Показывать индекс
		minimaphide = nil, -- Скрыть на миникарте
		hookMenuButton = nil, -- Хук кнопки меню
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
	E:func_InitField(Octo_AddonsManager_DB.lock.addons, E.GlobalAddonName, true)
end

--[[
Инициализирует таблицу отладки
Пустая таблица для хранения отладочной информации
]]
function Octo_EventFrame_WTF:Octo_Debug_DB()
	Octo_Debug_DB = E:func_InitTable(Octo_Debug_DB)
end

--[[
Инициализирует кэш-таблицу
Содержит кэшированные данные о валютах и репутациях
]]
function Octo_EventFrame_WTF:Octo_Cache_DB()
	Octo_Cache_DB = E:func_InitTable(Octo_Cache_DB)

	-- Инициализация подтаблиц
	E:func_InitSubTable(Octo_Cache_DB, "AllCurrencies")
	E:func_InitSubTable(Octo_Cache_DB, "AllReputations")

	-- Обновляем кэш валют и репутаций
	if not Octo_Cache_DB.buildNumber then
		Octo_Cache_DB.buildNumber = 1
		if Octo_Cache_DB.buildNumber < tonumber(E.buildNumber) then
			E:func_CurrencyCaching()
			E:func_ReputationsCaching()
			Octo_Cache_DB.buildNumber = E.buildNumber
		end
	end
end

--[[
Кэширует данные о валютах
Заполняет таблицу AllCurrencies актуальными данными
]]
function E:func_CurrencyCaching()
	-- Проверяем все возможные ID валют
	for CurrencyID = 4000, 1, -1 do
		local name = C_AccountStore.GetCurrencyInfo(CurrencyID).name
		if name and name ~= "" then
			-- Если валюта новая - добавляем в кэш
			if not Octo_Cache_DB.AllCurrencies[CurrencyID] then
				print(E.Green_Color.."FIND NEW CurrencyID|r", E.Red_Color..CurrencyID.."|r", name)
				Octo_Cache_DB.AllCurrencies[CurrencyID] = name
			end
		end
	end
end

--[[
Кэширует данные о репутациях
Заполняет таблицу AllReputations актуальными данными
]]
function E:func_ReputationsCaching()
	for reputationID = 4000, 1, -1 do
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		if repInfo then
			local name = repInfo.name

			if name and name ~= "" then
				-- Если репутация новая - добавляем в кэш
				if not Octo_Cache_DB.AllReputations[reputationID] then
					print(E.Green_Color.."FIND NEW reputationID|r", E.Red_Color..reputationID.."|r", name)
					Octo_Cache_DB.AllReputations[reputationID] = name .." id:".. tostring(reputationID)
				end
			end
		end
	end
end

--[[
Инициализирует таблицу измененных квестов
Содержит данные о изменениях в квестах
]]
function Octo_EventFrame_WTF:Octo_QuestsChanged_DB()
	Octo_QuestsChanged_DB = E:func_InitTable(Octo_QuestsChanged_DB)

	-- Инициализация подтаблиц
	E:func_InitSubTable(Octo_QuestsChanged_DB, "QC_Quests")
	E:func_InitSubTable(Octo_QuestsChanged_DB, "QC_Vignettes")
end

--[[
Выполняет ежедневный сброс данных
Очищает ежедневные квесты и другие временные данные
]]
function Octo_EventFrame_WTF:Daily_Reset()
	local ServerTime = GetServerTime()

	-- Обрабатываем всех персонажей
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Проверяем нужно ли выполнить сброс
		if (CharInfo.PlayerData.tmstp_Daily or 0) < ServerTime then
			-- Устанавливаем новую временную метку
			CharInfo.PlayerData.tmstp_Daily = E:func_tmstpDayReset(1)
			CharInfo.PlayerData.needResetDaily = true

			-- Сбрасываем ежедневные квесты
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Daily" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Daily"] = nil
				end
			end

			-- Очищаем данные LFG
			wipe(CharInfo.MASLENGO.LFGInstance)
			for _, v in ipairs (E.OctoTable_LFGDungeons) do
				CharInfo.MASLENGO.LFGInstance[v] = CharInfo.MASLENGO.LFGInstance[v] or {}
				CharInfo.MASLENGO.LFGInstance[v].donetoday = nil
			end

			-- Очищаем отладочные данные профессий
			Octo_ToDo_DB_Other.professions.DEBUG = nil
		end
	end
end

--[[
Выполняет еженедельный сброс данных
Очищает еженедельные квесты и другие временные данные
]]
function Octo_EventFrame_WTF:Weekly_Reset()
	local ServerTime = GetServerTime()

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Проверяем нужно ли выполнить сброс
		if (CharInfo.PlayerData.tmstp_Weekly or 0) < ServerTime then
			-- Проверяем есть ли награды в Великом Хранилище
			for i = 1, #CharInfo.MASLENGO.GreatVault do
				if CharInfo.MASLENGO.GreatVault[i] and
				CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING and
				CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING ~= 0 then
					CharInfo.PlayerData.HasAvailableRewards = true
					break
				end
			end

			-- Устанавливаем новую временную метку
			CharInfo.PlayerData.tmstp_Weekly = E:func_tmstpDayReset(7)
			CharInfo.PlayerData.needResetWeekly = true

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
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Weekly" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Weekly"] = nil
				end
			end
		end
	end
end

--[[
Выполняет ежемесячный сброс данных
Очищает ежемесячные квесты и другие временные данные
]]
function Octo_EventFrame_WTF:Month_Reset()
	local ServerTime = GetServerTime()

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- Проверяем нужно ли выполнить сброс
		if (CharInfo.PlayerData.tmstp_Month or 0) < ServerTime then
			-- Устанавливаем новую временную метку
			CharInfo.PlayerData.tmstp_Month = E:func_tmstpDayReset(365/12)
			CharInfo.PlayerData.needResetMonth = true

			-- Сбрасываем ежемесячные квесты
			for _, v in next, (E.OctoTable_UniversalQuest) do
				if v.reset == "Month" then
					CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_Month"] = nil
				end
			end
		end
	end
end

-- Регистрируем события для фрейма
local MyEventsTable = {
	"ADDON_LOADED", -- Событие загрузки аддона
	"VARIABLES_LOADED", -- Событие загрузки переменных
}

-- Регистрируем события в фрейме
E:func_RegisterMyEventsToFrames(Octo_EventFrame_WTF, MyEventsTable)

----------------------------------------------------------------
-- Обработчики событий
----------------------------------------------------------------

--[[
Обработчик события ADDON_LOADED
Выполняет инициализацию аддона при его загрузке
]]
function Octo_EventFrame_WTF:ADDON_LOADED(addonName)
	-- Проверяем что загрузился наш аддон
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil

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
		self:Octo_QuestsChanged_DB() -- Изменения квестов

		-- Очистка и сброс данных
		self:DatabaseClear()
		self:Daily_Reset()
		self:Weekly_Reset()
		self:Month_Reset()

		-- Применяем старые изменения
		E:setOldChanges()
	end
end

--[[
Обработчик события VARIABLES_LOADED
Выполняет завершающие действия после загрузки переменных
]]
function Octo_EventFrame_WTF:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
	end
end