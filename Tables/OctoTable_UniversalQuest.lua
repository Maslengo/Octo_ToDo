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
	{
		name_save = "NoCrateLeftBehind", -- Octopussy_Timewalk_NoCrateLeftBehind_Weekly
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			83794,
			85574,
			84624,
			84470,
			83931,
			84426,
			84767,
			85523,
			84773,
			84625,
			84909,
		},
		max = 11
	},
	{
		name_save = "CrateInsuranceAgent", -- Octopussy_Timewalk_CrateInsuranceAgent_Weekly
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			85523,
			84773,
			84625,
			84470,
			83931,
			85574,
			84909,
			84767,
			84624,
			84426,
			83794,
		},
		max = 11
	},
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
			82452, -- Worldsoul: World Quests
			82512, -- Worldsoul: World Boss
			82487, -- Worldsoul: The Stonevault
			82497, -- Worldsoul: The Stonevault
			82505, -- Worldsoul: The Stonevault
			82508, -- Worldsoul: The Rookery
			82486, -- Worldsoul: The Rookery
			82500, -- Worldsoul: The Rookery
			82489, -- Worldsoul: The Dawnbreaker
			82493, -- Worldsoul: The Dawnbreaker
			82501, -- Worldsoul: The Dawnbreaker
			82483, -- Worldsoul: Spreading the Light
			82482, -- Worldsoul: Snuffling
			82490, -- Worldsoul: Priory of the Sacred Flame
			82499, -- Worldsoul: Priory of the Sacred Flame
			82507, -- Worldsoul: Priory of the Sacred Flame
			82659, -- Worldsoul: Nerub-ar Palace
			82509, -- Worldsoul: Nerub-ar Palace
			82510, -- Worldsoul: Nerub-ar Palace
			82516, -- Worldsoul: Forging a Pact
			82453, -- Worldsoul: Encore!
			82488, -- Worldsoul: Darkflame Cleft
			82506, -- Worldsoul: Darkflame Cleft
			82498, -- Worldsoul: Darkflame Cleft
			82492, -- Worldsoul: City of Threads
			82496, -- Worldsoul: City of Threads
			82504, -- Worldsoul: City of Threads
			82485, -- Worldsoul: Cinderbrew Meadery
			82495, -- Worldsoul: Cinderbrew Meadery
			82503, -- Worldsoul: Cinderbrew Meadery
			82511, -- Worldsoul: Awakening Machine
			82491, -- Worldsoul: Ara-Kara, City of Echoes
			82494, -- Worldsoul: Ara-Kara, City of Echoes
			82502, -- Worldsoul: Ara-Kara, City of Echoes
			81985, -- Worldsoul Memory: The Worldcarvers
			82164, -- Worldsoul Memory: Reign of the Old Gods
			82260, -- Worldsoul Memory: Primal Predators
			82286, -- Worldsoul Memory: Old Gods Forsaken
			82263, -- Worldsoul Memory: Elemental Fury
			82207, -- Worldsoul Memory: Descendant of Distant Waters
			82321, -- Worldsoul Memory: Ancient Explorers
			82285, -- Worldsoul Memory: A Wounded Soul
			82449, -- The Call of the Worldsoul
		},
		max = 43
	},
}

