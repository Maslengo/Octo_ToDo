local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 4
local expansionID = 10
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 2122, defS = true,},
		{id = 2118, defS = true,},
		{id = 2003, defS = true,},
		{id = 2245, defS = true,},
		{id = 2594, defS = true,},

		{id = 2812, defS = true,}, -- (УСТАРЕЛО АСПЕКТЫ )
		{id = 2809, defS = true,}, -- (УСТАРЕЛО АСПЕКТЫ )
		{id = 2807, defS = true,}, -- (УСТАРЕЛО АСПЕКТЫ )
		{id = 2806, defS = true,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- Dragonflight
		-- https://warcraft.wiki.gg/wiki/Catalyst
		{id = 2912, defS = true,}, -- Renascent Awakening ()
		{id = 2796, defS = true,}, -- Renascent Dream (Season 3)
		{id = 2533, defS = true,}, -- Renascent Shadowflame (Season 2)
		{id = 2167, defS = true,}, -- Catalyst Charges (Season 1)
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 209856, defS = true,},
		{id = 207002, defS = true,},
		{id = 210254, defS = true,},
		{id = 213089, defS = true,},
		{id = 211516, defS = true,},
		{id = 211515, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
		-- ["Dragonflight"] = {
		{id = 2507, defS = true,}, --name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
		{id = 2574, defS = true,}, --name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
		{id = 2511, defS = true,}, --name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
		{id = 2564, defS = true,}, --name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
		{id = 2503, defS = true,}, --name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
		{id = 2510, defS = true,}, --name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
		----------------------------------------------------------------
		{id = 2550, defS = true,}, --name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
		{id = 2544, defS = true,}, --name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
		{id = 2553, defS = true,}, --name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
		{id = 2518, defS = true,}, --name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
		{id = 2517, defS = true,}, --name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
		----------------------------------------------------------------
		{id = 2568, defS = true,}, --name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
		----------------------------------------------------------------
		{id = 2615, defS = true,}, --name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
		----------------------------------------------------------------
		{id = 2593, defS = true,}, --name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
		{id = 2526, defS = true,}, --name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			TextLeft = L["World Boss"],
			name_save = "WorldBoss",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{69927, forcedText = {npcID = 193532}, addText = {mapID = 2024},}, -- Базуал <Чудовищное Пламя> 193532 (Лазурный Простор)
				{69928, forcedText = {npcID = 193533}, addText = {mapID = 2025},}, -- Лисканот <Крах Мироздания> 193533 (Будущее воинов стихий)
				{69929, forcedText = {npcID = 193534}, addText = {mapID = 2023},}, -- Струнраан <Бедствие Небес> 193534 (Равнины Он'ары)
				{69930, forcedText = {npcID = 193535}, addText = {mapID = 2022},}, -- Базрикрон <Каменное Крыло> 193535 (Берега Пробуждения)
				{nil},
				{74892, addText = {mapID = 2133},}, -- Старейшины закали (Пещера Заралек)
				{nil},
				{76367, forcedText = {npcID = 209574}, addText = {mapID = 2200},}, -- Ауростор <Пережидающий Зиму> 209574 Изумрудный Сон (6).
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			TextLeft = E.func_mapName(2133)..": ".."Events",
			name_save = "ZaralekCavernEvents",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2133)..": ".."Rares",
			name_save = "ZaralekCavernRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2133)..": "..E.func_questName(75665, false),
			name_save = "ZaralekCavernAWorthyAllyLoammNiffen",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75665},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_mapName(2133)..": "..L["Sniffenseeking"],
			name_save = "ZaralekCavernSniffenseeking",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2133)..": "..L["Sniffenseeking (items)"],
			name_save = "ZaralekCavernSniffenseekingItems",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2133)..": "..E.func_questName(74906, false).." "..E.Timers.DF_ResearchersUnderFire(),
			name_save = "ResearchersUnderFire",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2151)..": ".."Rares", -- Запретный край.
			name_save = "TheForbiddenReachRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = E.Timers.DF_CommunityFeast()..L["Community Feast"],
			name_save = "CommunityFeast",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70893},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"],
			name_save = "DragonbaneKeep",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70866},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.Timers.DF_GrandHunts()..L["Grand Hunt"],
			name_save = "TheGrandHunt",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70906},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.Timers.DF_PrimalStorms()..L["The Storm's Fury"],
			name_save = "StormsFury",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{73162},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(66133, false),
			name_save = "KeysofLoyalty",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{66133},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "StormBoundChest",
			name_save = "StormBoundChest",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{74567},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "FyrakkAssaults",
			name_save = "FyrakkAssaults",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{74501},
				{75280},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "DiscipleofFyrakk",
			name_save = "DiscipleofFyrakk",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75467},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(70750, false),
			name_save = "AidingtheAccord",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.func_mapName(2025)..": "..L["Time Rift"].." "..E.Timers.DF_TimeRift(),
			name_save = L["Time Rift"],
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77836},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.Timers.DF_Dreamsurges()..E.func_questName(77414, false),
			name_save = "DreamsurgeInvestigation",
			defS = true,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{77414},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(77251, false),
			name_save = "ShapingtheDreamsurge",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77251},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(77236, false),
			name_save = "WhenTimeNeedsMending",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77236},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "TemporalAcquisitionsSpecialist",
			name_save = "TemporalAcquisitionsSpecialist",
			defS = true,
			reset = "Once",
			desc = categoryKey,
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
			TextLeft = E.func_questName(78444, false),
			name_save = "EmeraldDream_AWorthyAllyDreamWardens",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78444},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(78821, false),
			name_save = "EmeraldDream_BloomingDreamseeds",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78821},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.Timers.DF_Flower()..E.func_questName(78319, false),
			name_save = "EmeraldDream_TheSuperbloom",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78319},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "EmeraldDream_Rares",
			name_save = "EmeraldDream_Rares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = "EmeraldDream_Treasures",
			name_save = "EmeraldDream_Treasures",
			defS = true,
			reset = "Once",
			desc = categoryKey,
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
			TextLeft = E.func_questName(78381, false),
			name_save = "EmeraldDream_DreamsUnified",
			defS = true,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{78381},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "EmeraldDream_Seeds",
			name_save = "EmeraldDream_Seeds",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77350},
				{77353},
				{77354},
			},
			forcedMaxQuest = 5,
		},
		{
			showTooltip = true,
			TextLeft = "TheGilneasReclamation_Storylines",
			name_save = "TheGilneasReclamation_Storylines",
			defS = true,
			reset = "Once",
			desc = categoryKey,
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
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka

end

table.insert(E.Components, tempFunction)

