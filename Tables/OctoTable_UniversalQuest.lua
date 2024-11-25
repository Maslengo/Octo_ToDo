local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
E.OctoTable_UniversalQuest = {
	{
		name_save = "500Currency",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			83285, -- Древний свиток
			64710, -- Шепчущий кристалл пламени Скверны
			55499, -- Мерцающий кристалл
			55498, -- Мерцающий кристалл
			45563, -- Затуманенная монета
			40787, -- Тлеющий уголек
			40786, -- Тлеющий уголек
			40173, -- Нестабильная призма
			40168, -- Бурлящий фиал
		},
		max = 1
	},
	{
		name_save = "Raid",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			82817, -- Обнаружен источник помех: глубины Черной горы
			57637, -- Обнаружен источник помех: Огненные Просторы
			50316, -- Обнаружен источник помех: Ульдуар
			47523, -- Обнаружен источник помех: Черный храм
		},
		max = 1
	},
	{
		name_save = "Dungeons",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			85948, -- Пылающий путь сквозь время
			85947, -- Первозданный путь сквозь время
			83365, -- Замерзший путь сквозь время
			83363, -- Пылающий путь сквозь время
			83274, -- Первозданный путь сквозь время
			40792,
			39021,
			39020,
		},
		max = 1
	},
	{
		name_save = "ATimetoReflect",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			43461,
			43323,
		},
		max = 1
	},
	{
		name_save = "CelebrateGoodFun", -- Octopussy_Timewalk_CelebrateGoodFun_Weekly
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			84616,
		},
		max = 1
	},
	{
		name_save = "ChromiesCodex", -- Octopussy_Timewalk_ChromiesCodex_Weekly
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			82783,
		},
		max = 1
	},
	{
		name_save = "SoldierofTime", -- Octopussy_Timewalk_SoldierofTime_Weekly
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			57300,
		},
		max = 1
	},
	-- {
	-- 	name_save = "NoCrateLeftBehind", -- Octopussy_Timewalk_NoCrateLeftBehind_Weekly
	-- 	reset = "Weekly",
	-- 	desc = "Timewalk",
	-- 	questID = {
	-- 		83794,
	-- 		85574,
	-- 		84624,
	-- 		84470,
	-- 		83931,
	-- 		84426,
	-- 		84767,
	-- 		85523,
	-- 		84773,
	-- 		84625,
	-- 		84909,
	-- 	},
	-- 	max = 11
	-- },
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	{
		name_save = "WorldBoss",
		reset = "Weekly",
		desc = "TWW",
		questID = {
			82653,
			81653,
			81624,
			81630,
		},
		max = 1
	},
	{
		name_save = "TheTheaterTroupe", -- Octopussy_TWW_TheTheaterTroupe_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
			83240,
		},
		max = 1
	},
	{
		name_save = "DungeonQuest", -- Octopussy_TWW_DungeonQuest_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
			83443,
			83457,
			83458,
			83459,
			83460,
			83465,
			83469,
		},
		max = 1
	},
	{
		name_save = "Delve", -- Octopussy_TWW_Delve_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
			39020,
			39033,
			40792,
			39042,
			39021,
			39034,
			39040,
			39041,
			44174,
			64970,
			72719,
			72724,
			72725,
			72726,
			83365,
			72727,
			83363,
			72810,
			83363,
			83345,
			84776,
			83365,
			83347,
			83358,
			83357,
			83366,
		},
		max = 1
	},
	{
		name_save = "MajorKeyflames", -- Octopussy_TWW_MajorKeyflames_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
			79471,
			79470,
			79469,
			79380,
			79329,
			78657,
			78590,
			76338,
		},
		max = 8
	},
	{
		name_save = "MinorKeyflames", -- Octopussy_TWW_MinorKeyflames_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
			76600,
			79158,
			76733,
			79216,
			79173,
			76997,
			81574,
			78972,
			78915,
			78933,
			76394,
			78656,
			79346,
			81632,
			76169,
			80004,
			80562,
		},
		max = 8
	},
	{
		name_save = "Worldsoul", -- Octopussy_TWW_Worldsoul_Weekly
		reset = "Weekly",
		desc = "TWW",
		questID = {
				82659, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Неруб'арский дворец
				82516, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: заключение пакта
				82512, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: босс вне подземелья
				82511, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Машина пробуждения
				82510, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Неруб'арский дворец
				82509, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Неруб'арский дворец
				82508, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Гнездовье
				82507, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: приорат Священного Пламени
				82506, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: расселина Темного Пламени
				82505, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Каменный Свод
				82504, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Город Нитей
				82503, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Искроварня
				82502, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Ара-Кара, Город Отголосков
				82501, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: "Сияющий Рассвет"
				82500, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Гнездовье
				82499, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: приорат Священного Пламени
				82498, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: расселина Темного Пламени
				82497, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Каменный Свод
				82496, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Город Нитей
				82495, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Искроварня
				82494, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Ара-Кара, Город Отголосков
				82493, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: "Сияющий Рассвет"
				82492, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Город Нитей
				82491, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Ара-Кара, Город Отголосков
				82490, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: приорат Священного Пламени
				82489, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: "Сияющий Рассвет"
				82488, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: расселина Темного Пламени
				82487, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Каменный Свод
				82486, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Гнездовье
				82485, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Искроварня
				82483, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: благодать Света
				82482, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: разнюхивание
				82453, -- |A:Wrapperavailablequesticon:14:14:0:0|a Воспоминание души мира: на бис!
				82452, -- |A:Wrapperavailablequesticon:14:14:0:0|a Воспоминание души мира: локальные задания
				-- 82449, -- |A:Wrapperavailablequesticon:14:14:0:0|a Зов души мира
				82321, -- Воспоминание души мира: древние исследователи
				82286, -- Воспоминание души мира: отвергнутые Древние боги
				82285, -- Воспоминание души мира: раненая душа
				82263, -- Воспоминание души мира: неистовство стихий
				82260, -- Воспоминание души мира: первобытные охотники
				82207, -- Воспоминание души мира: наследник дальних морей
				82164, -- Воспоминание души мира: правление Древних богов
				81985, -- Воспоминание души мира: великие резчики

		},
		max = 42
	},
}

