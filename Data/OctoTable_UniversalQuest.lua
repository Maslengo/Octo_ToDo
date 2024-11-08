local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
E.Octo_Table.OctoTable_UniversalQuest = {
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
		name_save = "SoldierofTime",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			57300,
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
}
