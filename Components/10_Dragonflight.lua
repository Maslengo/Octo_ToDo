local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 10
local expansionID = 10
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_Vibor = {}
	-- wipe(OctoTables_Vibor)

	local OctoTables_DataOtrisovka = {}
	-- wipe(OctoTables_DataOtrisovka)

	OctoTables_DataOtrisovka[categoryKey] = {}
	-- wipe(OctoTables_DataOtrisovka[categoryKey])


	OctoTables_Vibor[categoryKey] = {}
	-- wipe(OctoTables_Vibor[categoryKey])

	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 2122, defS = true,},
		{id = 2118, defS = true,},
		{id = 2003, defS = true,},
		{id = 2245, defS = true,},
		{id = 2594, defS = true,},

		-- {id = 2812, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2809, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2807, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2806, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
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
		{id = 2507, defS = false,}, --name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
		{id = 2574, defS = false,}, --name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
		{id = 2511, defS = false,}, --name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
		{id = 2564, defS = false,}, --name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
		{id = 2503, defS = false,}, --name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
		{id = 2510, defS = false,}, --name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
		----------------------------------------------------------------
		{id = 2550, defS = false,}, --name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
		{id = 2544, defS = false,}, --name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
		{id = 2553, defS = false,}, --name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
		{id = 2518, defS = false,}, --name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
		{id = 2517, defS = false,}, --name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
		----------------------------------------------------------------
		{id = 2568, defS = false,}, --name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
		----------------------------------------------------------------
		{id = 2615, defS = false,}, --name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
		----------------------------------------------------------------
		{id = 2593, defS = false,}, --name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
		{id = 2526, defS = false,}, --name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
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
			TextLeft = function()
				return E.func_GetMapName(2133)..": ".."Events"
			end,
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
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": ".."Rares"
			end,
			name_save = "ZaralekCavernRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{75271, forcedText = {npcID = 203468},},
				{75285, forcedText = {npcID = 203515},},
				{75298, forcedText = {npcID = 203593},},
				{75326, forcedText = {npcID = 203621},},
				{75576, forcedText = {npcID = 204096},}, --WHAT?
				{75314, forcedText = {npcID = 203611},},
				{75296, forcedText = {npcID = 203592},},
				{75353, forcedText = {npcID = 203646},},
				{75358, forcedText = {npcID = 203660},},
				{75274, forcedText = {npcID = 203477},},
				{75366, forcedText = {npcID = 201029},},
				{75336, forcedText = {npcID = 203627},},
				{75269, forcedText = {npcID = 203466},},
				{75334, forcedText = {npcID = 203625},},
				{75322, forcedText = {npcID = 203618},},
				{75267, forcedText = {npcID = 203462},},
				{75476, forcedText = {npcID = 204093},},
				{75276, forcedText = {npcID = 203480},},
				{75342, forcedText = {npcID = 203642},},
				{75338, forcedText = {npcID = 203630},},
				{75340, forcedText = {npcID = 200111},},
				{75360, forcedText = {npcID = 203662},},
				{75292, forcedText = {npcID = 203521},},
				{75349, forcedText = {npcID = 203643},},
				{75364, forcedText = {npcID = 203664},},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..E.func_GetQuestName(75665, false)
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..L["Sniffenseeking"]
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..L["Sniffenseeking (items)"]
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..E.func_GetQuestName(74906, false).." "..E.Timers.DF_ResearchersUnderFire()
			end,
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
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2151)..": ".."Rares" -- Запретный край.
			end,
			name_save = "TheForbiddenReachRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{74331, forcedText = {npcID = 200740},},
				{74347, forcedText = {npcID = 201013},},
				{74345, forcedText = {npcID = 200904},},
				{74336, forcedText = {npcID = 200584},},
				{74337, forcedText = {npcID = 200537},},
				{74342, forcedText = {npcID = 200717},},
				{74321, forcedText = {npcID = 200722},},
				{74343, forcedText = {npcID = 200721},},
				{74338, forcedText = {npcID = 200579},},
				{74329, forcedText = {npcID = 200738},},
				{74307, forcedText = {npcID = 200622},},
				{74325, forcedText = {npcID = 200730},},
				{74346, forcedText = {npcID = 201181},},
				{74344, forcedText = {npcID = 200885},},
				{74332, forcedText = {npcID = 200742},},
				{74306, forcedText = {npcID = 200621},},
				{74333, forcedText = {npcID = 200743},},
				{74341, forcedText = {npcID = 200681},},
				{74305, forcedText = {npcID = 200620},},
				{74339, forcedText = {npcID = 200600},},
				{74300, forcedText = {npcID = 200619},},
				{74349, forcedText = {npcID = 200956},},
				{74322, forcedText = {npcID = 200725},},
				{74330, forcedText = {npcID = 200739},},
				{74328, forcedText = {npcID = 200737},},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_CommunityFeast()..L["Community Feast"]
			end,
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
			TextLeft = function()
				return E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"]
			end,
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
			TextLeft = function()
				return E.Timers.DF_GrandHunts()..L["Grand Hunt"]
			end,
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
			TextLeft = function()
				return E.Timers.DF_PrimalStorms()..L["The Storm's Fury"]
			end,
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
			TextLeft = function()
				return E.func_GetQuestName(66133, false)
			end,
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
			TextLeft = function()
				return E.func_GetQuestName(70750, false)
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2025)..": "..L["Time Rift"].." "..E.Timers.DF_TimeRift()
			end,
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
			TextLeft = function()
				return E.Timers.DF_Dreamsurges()..E.func_GetQuestName(77414, false)
			end,
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
			TextLeft = function()
				return E.func_GetQuestName(77251, false)
			end,
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
			TextLeft = function()
				return E.func_GetQuestName(77236, false)
			end,
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
			TextLeft = function()
				return E.func_GetQuestName(78444, false)
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.func_GetQuestName(78821, false)
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.Timers.DF_Flower()..E.func_GetQuestName(78319, false)
			end,
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
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."Rares"
			end,
			name_save = "EmeraldDream_Rares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{77942, forcedText = {npcID = 210050},},
				{77867, forcedText = {npcID = 209898},},
				{77862, forcedText = {npcID = 209909},},
				{77878, forcedText = {npcID = 209929},},
				{78015, forcedText = {npcID = 209893},},
				{77846, forcedText = {npcID = 209913},},
				{77982, forcedText = {npcID = 209936},},
				{77944, forcedText = {npcID = 210075},},
				{77864, forcedText = {npcID = 209620},},
				{77989, forcedText = {npcID = 209919},},
				{78211, forcedText = {npcID = 210046},},
				{78213, forcedText = {npcID = 210051},},
				{77941, forcedText = {npcID = 208658},},
				{77943, forcedText = {npcID = 210064},},
				{78210, forcedText = {npcID = 210045},},
				{77940, forcedText = {npcID = 210070},},
				{77570, forcedText = {npcID = 209113},},
				{77890, forcedText = {npcID = 210161},},
				{78212, forcedText = {npcID = 210047},},
				{77863, forcedText = {npcID = 209365},},
				{78263, forcedText = {npcID = 210111},},
				{77994, forcedText = {npcID = 209902},},
				{77990, forcedText = {npcID = 209911},},
				{78214, forcedText = {npcID = 210508},},
				{78039, forcedText = {npcID = 210559},},
				{77859, forcedText = {npcID = 209912},},
				{77856, forcedText = {npcID = 209915},},
			},
			forcedMaxQuest = 27,
		},
		{
			showTooltip = true,

			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."Treasures"
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.func_GetQuestName(78381, false)
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."Seeds"
			end,
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
			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."TheGilneasReclamation_Storylines"
			end,
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

