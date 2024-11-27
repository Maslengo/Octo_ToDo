local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
E.OctoTable_UniversalQuest = {
	{
		name_save = "500Currency",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			83285, -- |A:Recurringavailablequesticon:14:14:0:0|a Древний свиток
			64710, -- |A:Recurringavailablequesticon:14:14:0:0|a Шепчущий кристалл пламени Скверны
			55499, -- |A:Recurringavailablequesticon:14:14:0:0|a Мерцающий кристалл
			55498, -- |A:Recurringavailablequesticon:14:14:0:0|a Мерцающий кристалл
			45563, -- |A:Recurringavailablequesticon:14:14:0:0|a Затуманенная монета
			40787, -- |A:Recurringavailablequesticon:14:14:0:0|a Тлеющий уголек
			40786, -- |A:Recurringavailablequesticon:14:14:0:0|a Тлеющий уголек
			40173, -- |A:Recurringavailablequesticon:14:14:0:0|a Нестабильная призма
			40168, -- |A:Recurringavailablequesticon:14:14:0:0|a Бурлящий фиал
		},
		max = 1
	},
	{
		name_save = "Raid",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			82817,
			57637,
			50316,
			47523,
		},
		max = 1
	},
	{
		name_save = "Dungeons",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			85949,
			85948,
			85947,
			83365,
			83363,
			83274,
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
		name_save = "CelebrateGoodFun",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			84616,
		},
		max = 1
	},
	{
		name_save = "ChromiesCodex",
		reset = "Weekly",
		desc = "Timewalk",
		questID = {
			82783,
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
		name_save = "TheTheaterTroupe",
		reset = "Weekly",
		desc = "TWW",
		questID = {
			83240,
		},
		max = 1
	},
	{
		name_save = "DungeonQuest",
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
		name_save = "Delve",
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
		name_save = "MajorKeyflames",
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
		name_save = "MinorKeyflames",
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
		name_save = "Worldsoul",
		reset = "Weekly",
		desc = "TWW",
		questID = {
			82659,
			82516,
			82512,
			82511,
			82510,
			82509,
			82508,
			82507,
			82506,
			82505,
			82504,
			82503,
			82502,
			82501,
			82500,
			82499,
			82498,
			82497,
			82496,
			82495,
			82494,
			82493,
			82492,
			82491,
			82490,
			82489,
			82488,
			82487,
			82486,
			82485,
			82483,
			82482,
			82453,
			82452,
			82321,
			82286,
			82285,
			82263,
			82260,
			82207,
			82164,
			81985,
		},
		max = 42
	},
	{
		name_save = "ISavedthePartyandAllIGotWereTheseLousyHats",
		reset = "Once",
		desc = "Timewalk",
		questID = {
			84143,
			84144,
			84419,
			84393,
			84363,
			84521,
			84868,
			84236,
			84237,
			84278,
			84296,
			84334,
			84336,
			84563,
			85024,
			84588,
			85025,
			84755,
			85042,
			84756,
			85043,
			85047,
			85060,
			85208,
			85195,
			85475,
			85476,
			85502,
			85503,
		},
		max = 29
	},
}