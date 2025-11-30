local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 10

E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[currentSTATE].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
	2122,
	2118,
	2003,
	2245,
	2594,
	-- (УСТАРЕЛО АСПЕКТЫ 2812, 2809, 2807, 2806)
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {
	209856,
	207002,
	210254,
	213089,
	211516,
	211515,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
	-- header = {icon = E.OctoTable_Expansions[currentSTATE].icon, name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name.."|r",},
	-- ["Dragonflight"] = {
	2507, --name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
	2574, --name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
	2511, --name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
	2564, --name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
	2503, --name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
	2510, --name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
	----------------------------------------------------------------
	2550, --name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
	2544, --name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
	2553, --name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
	2518, --name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
	2517, --name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
	----------------------------------------------------------------
	2568, --name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
	----------------------------------------------------------------
	2615, --name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
	----------------------------------------------------------------
	2593, --name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
	2526, --name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
	{
		sorted = false,
		showTooltip = true,
		textleft = L["World Boss"],
		name_save = "WorldBoss",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{69927, forcedText = {npcID = 193532}, addText = {mapID = 2024},}, -- Базуал <Чудовищное Пламя> 193532 (Лазурный Простор)
			{69928, forcedText = {npcID = 193533}, addText = {mapID = 2025},}, -- Лисканот <Крах Мироздания> 193533 (Будущее воинов стихий)
			{69929, forcedText = {npcID = 193534}, addText = {mapID = 2023},}, -- Струнраан <Бедствие Небес> 193534 (Равнины Он'ары)
			{69930, forcedText = {npcID = 193535}, addText = {mapID = 2022},}, -- Базрикрон <Каменное Крыло> 193535 (Берега Пробуждения)
			{nil},
			{74892, addText = {mapID = 2133},}, -- Старейшины закали (Пещера Заралек)
			{nil},
			{76367, forcedText = {npcID = 209574}, addText = {mapID = 2200},}, -- Ауростор <Пережидающий Зиму> 209574 Изумрудный Сон  (6).
		},
		forcedMaxQuest = 3,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": ".."Events",
		name_save = "ZaralekCavernEvents",
		reset = "Daily",
		desc = currentSTATE,
		quests = {
			{75612},
			{75471},
			{75455},
			{75664},
			{75611},
			{75478},
			{75451},
			{75461},
			{75705},
			{75454},
			{75450},
			{75222},
			{75370},
			{75494},
			{75441},
			{75156},
			{75624},
			{74352},
		},
		-- forcedMaxQuest = 18,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": ".."Rares",
		name_save = "ZaralekCavernRares",
		reset = "Daily",
		desc = currentSTATE,
		quests = {
			{75271},
			{75285},
			{75298},
			{75326},
			{75576},
			{75314},
			{75296},
			{75353},
			{75358},
			{75274},
			{75366},
			{75336},
			{75269},
			{75334},
			{75322},
			{75267},
			{75476},
			{75276},
			{75342},
			{75338},
			{75340},
			{75360},
			{75292},
			{75349},
			{75364},
		},
		-- forcedMaxQuest = 25,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": "..E.func_questName(75665),
		name_save = "ZaralekCavernAWorthyAllyLoammNiffen",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{75665},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": "..L["Sniffenseeking"],
		name_save = "ZaralekCavernSniffenseeking",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{75459},
			{76027},
			{75621},
			{75397},
			{75517},
			{75619},
			{76014},
			{75620},
			{76081},
			{75390},
			{75234},
			{75516},
			{75996},
			{76016},
			{75393},
			{76015},
			{76084},
		},
		-- forcedMaxQuest = 17,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": "..L["Sniffenseeking (items)"],
		name_save = "ZaralekCavernSniffenseekingItems",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{75771},
			{75772},
			{75767},
			{75768},
			{75765},
			{75936},
			{75766},
			{75769},
			{75770},
			{75998},
			{75773},
			{76004},
		},
		-- forcedMaxQuest = 12,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2133)..": "..E.func_questName(74906).." "..E.Timers.DF_ResearchersUnderFire(),
		name_save = "ResearchersUnderFire",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{75630, forcedText = {text = MAW_BUFF_QUALITY_STRING_EPIC}},
			{75629, forcedText = {text = MAW_BUFF_QUALITY_STRING_RARE}},
			{75628, forcedText = {text = MAW_BUFF_QUALITY_STRING_UNCOMMON}},
			{75627, forcedText = {text = MAW_BUFF_QUALITY_STRING_COMMON}},
		},
		-- forcedMaxQuest = 4,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2151)..": ".."Rares", -- Запретный край.
		name_save = "TheForbiddenReachRares",
		reset = "Daily",
		desc = currentSTATE,
		quests = {
			{74331},
			{74347},
			{74345},
			{74336},
			{74337},
			{74342},
			{74321},
			{74343},
			{74338},
			{74329},
			{74307},
			{74325},
			{74346},
			{74344},
			{74332},
			{74306},
			{74333},
			{74341},
			{74305},
			{74339},
			{74300},
			{74349},
			{74322},
			{74330},
			{74328},
		},
		-- forcedMaxQuest = 25,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_CommunityFeast()..L["Community Feast"],
		name_save = "CommunityFeast",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{70893},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"],
		name_save = "DragonbaneKeep",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{70866},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_GrandHunts()..L["Grand Hunt"],
		name_save = "TheGrandHunt",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{70906},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_PrimalStorms()..L["The Storm's Fury"],
		name_save = "StormsFury",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{73162},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(66133),
		name_save = "KeysofLoyalty",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{66133},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "StormBoundChest",
		name_save = "StormBoundChest",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{74567},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "FyrakkAssaults",
		name_save = "FyrakkAssaults",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{74501},
			{75280},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "DiscipleofFyrakk",
		name_save = "DiscipleofFyrakk",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{75467},
		},
		-- forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(70750),
		name_save = "AidingtheAccord",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{70750},
			{72068},
			{72374},
			{77976},
			{75861},
			{72373},
			{72375},
			{77254},
			{75860},
			{75859},
			{75259},
			{78446},
			{78447},
			{80385},
			{80386},
			{80388},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_mapName(2025)..": "..L["Time Rift"].." "..E.Timers.DF_TimeRift(),
		name_save = L["Time Rift"],
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{77836},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_Dreamsurges()..E.func_questName(77414),
		name_save = "DreamsurgeInvestigation",
		reset = "Once",
		desc = currentSTATE,
		quests = {
			{77414},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(77251),
		name_save = "ShapingtheDreamsurge",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{77251},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(77236),
		name_save = "WhenTimeNeedsMending",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{77236},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "TemporalAcquisitionsSpecialist",
		name_save = "TemporalAcquisitionsSpecialist",
		reset = "Once",
		desc = currentSTATE,
		quests = {
			{76406},
			{76547},
			{76521},
			{76404},
			{76548},
			{76379},
			{76459},
			{76362},
			{76546},
			{76453},
			{76544},
			{76449},
			{76351},
			{76533},
		},
		forcedMaxQuest = 14,
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	{
		showTooltip = true,
		textleft = E.func_questName(78444),
		name_save = "EmeraldDream_AWorthyAllyDreamWardens",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{78444},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(78821),
		name_save = "EmeraldDream_BloomingDreamseeds",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{78821},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = E.Timers.DF_Flower()..E.func_questName(78319),
		name_save = "EmeraldDream_TheSuperbloom",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{78319},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "EmeraldDream_Rares",
		name_save = "EmeraldDream_Rares",
		reset = "Daily",
		desc = currentSTATE,
		quests = {
			{77942},
			{77867},
			{77862},
			{77878},
			{78015},
			{77846},
			{77982},
			{77944},
			{77864},
			{77989},
			{78211},
			{78213},
			{77941},
			{77943},
			{78210},
			{77940},
			{77570},
			{77890},
			{78212},
			{77863},
			{78263},
			{77994},
			{77990},
			{78214},
			{78039},
			{77859},
			{77856},
		},
		forcedMaxQuest = 27,
	},
	{
		showTooltip = true,
		textleft = "EmeraldDream_Treasures",
		name_save = "EmeraldDream_Treasures",
		reset = "Once",
		desc = currentSTATE,
		quests = {
			{77872},
			{77950},
			{78005},
			{78107},
			{78359},
			{77858},
			{78120},
			{78006},
			{78360},
			{78361},
			{78550},
			{78551},
			{78547},
			{78552},
			{78831},
			{78911},
			{78833},
			{78834},
			{78835},
		},
		forcedMaxQuest = 19,
	},
	{
		showTooltip = true,
		textleft = E.func_questName(78381),
		name_save = "EmeraldDream_DreamsUnified",
		reset = "Once",
		desc = currentSTATE,
		quests = {
			{78381},
		},
		forcedMaxQuest = 1,
	},
	{
		showTooltip = true,
		textleft = "EmeraldDream_Seeds",
		name_save = "EmeraldDream_Seeds",
		reset = "Weekly",
		desc = currentSTATE,
		quests = {
			{77350},
			{77353},
			{77354},
		},
		forcedMaxQuest = 5,
	},
	{
		showTooltip = true,
		textleft = "TheGilneasReclamation_Storylines",
		name_save = "TheGilneasReclamation_Storylines",
		reset = "Once",
		desc = currentSTATE,
		quests = {
			{78178},
			{78180},
			{78181},
			{78182},
			{78183},
			{78184},
			{78185},
			{78186},
			{78187},
			{78188},
			{78189},
			{78597},
			{79137},
		},
		forcedMaxQuest = 13,
	},
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {

}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------