local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_BattleforAzeroth_available = E.func_Is_BattleforAzeroth_available()
----------------------------------------------------------------
if not enable then return end
if not Is_BattleforAzeroth_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local categoryKey = 8
local expansionID = 8
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
		{id = 1560, defS = true,},
		{id = 1721, defS = true,},
		{id = 1803, defS = true,},
		{id = 1755, defS = true,},
		{id = 1719, defS = true,},
		{id = 1710, defS = true,},
		{id = 1716, defS = true,},
		{id = 1717, defS = true,},
		{id = 1718, defS = false,},
		{id = 1580, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			{id = 1180, defS = true,}, -- Ny'alotha, the Waking City
			{id = 1179, defS = true,}, -- The Eternal Palace
			{id = 1177, defS = true,}, -- Crucible of Storms
			{id = 1176, defS = true,}, -- Battle of Dazar'alor
			{id = 1031, defS = true,}, -- Uldir
			-- {id = 1028, defS = true,}, -- Azeroth
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
		-- ["Battle for Azeroth"] = {
		{id = 2164, defS = true,}, --name = "Защитники Азерот", side = "-", category = "Battle for Azeroth", }, --[faction=2164]
		{id = 2415, defS = true,}, --name = "Раджани", side = "-", category = "Battle for Azeroth", }, --[faction=2415]
		{id = 2391, defS = true,}, --name = "Ржавоболтское сопротивление", side = "-", category = "Battle for Azeroth", }, --[faction=2391]
		{id = 2163, defS = true,}, --name = "Тортолланские искатели", side = "-", category = "Battle for Azeroth", }, --[faction=2163]
		{id = 2417, defS = true,}, --name = "Ульдумский союз", side = "-", category = "Battle for Azeroth", }, --[faction=2417]
		{id = 2427, defS = true,}, --name = "Молодой акир", side = "-", category = "Battle for Azeroth", }, --[faction=2427]
		{id = 2157, defS = false,}, --name = "Армия Чести", side = "Horde", category = "Battle for Azeroth", }, --[faction=2157]
		{id = 2373, defS = false,}, --name = "Освобожденные", side = "Horde", category = "Battle for Azeroth", }, --[faction=2373]
		{id = 2158, defS = false,}, --name = "Жители Вол'дуна", side = "Horde", category = "Battle for Azeroth", }, --[faction=2158]
		{id = 2103, defS = false,}, --name = "Империя Зандалари", side = "Horde", category = "Battle for Azeroth", }, --[faction=2103]
		{id = 2156, defS = false,}, --name = "Экспедиция Таланджи", side = "-", category = "Battle for Azeroth", }, --[faction=2156]
		-- {id = 2233, defS = false,}, --name = "Dino Training - Pterrodax", side = "Horde", category = "Battle for Azeroth", }, --[faction=2233]
		-- {id = 2370, defS = false,}, --name = "Обучение динозавров – Дикорог", side = "-", category = "Battle for Azeroth", }, --[faction=2370]
		{id = 2390, defS = true,}, --name = "Вим Соленодух", side = "Horde", category = "Battle for Azeroth", }, --[faction=2390]
		{id = 2389, defS = true,}, --name = "Нери Остроерш", side = "Horde", category = "Battle for Azeroth", }, --[faction=2389]
		{id = 2388, defS = true,}, --name = "Поэн Солежабрик", side = "Horde", category = "Battle for Azeroth", }, --[faction=2388]
		{id = 2159, defS = false,}, --name = "7-й легион", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2159]
		{id = 2160, defS = false,}, --name = "Адмиралтейство Праудмуров", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2160]
		{id = 2400, defS = false,}, --name = "Клинки Волн", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2400]
		{id = 2162, defS = false,}, --name = "Орден Возрождения Шторма", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2162]
		{id = 2161, defS = false,}, --name = "Орден Пылающих Углей", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2161]
		{id = 2395, defS = false,}, --name = "Улей Медокрылов", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2395]
		{id = 2398, defS = false,}, --name = "Фуражир из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2398]
		{id = 2397, defS = false,}, --name = "Пчеломатка улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2397]
		{id = 2396, defS = false,}, --name = "Трутень из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2396]
		{id = 2376, defS = true,}, --name = "Оракул Ори", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2376]
		{id = 2375, defS = true,}, --name = "Мастер охоты Акана", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2375]
		{id = 2377, defS = true,}, --name = "Мастер клинка Иновари", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2377]
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
				{52196, addText = {mapID = 864}, }, -- Занесенные песком кости (Вол'дун)
				{52169, addText = {mapID = 862}, }, -- Матриарх (Дикие земли)
				{52181, addText = {mapID = 863}, }, -- Дым и тени (Назмир)
				{52166, addText = {mapID = 942}, }, -- Безликий глашатай (Долина Штормов)
				{52163, addText = {mapID = 895}, }, -- Крылатый тайфун (Тирагардское поморье)
				{52157, addText = {mapID = 896}, }, -- Леденящая встреча (Друствар)
				{nil},
				{52848, addText = {mapID = 14}, faction = "Horde"}, -- "Львиный рык" (Нагорье Арати)
				{52847, addText = {mapID = 14}, faction = "Alliance"}, -- "Гибельный вой" (Нагорье Арати)
				{54896, addText = {mapID = 62}, faction = "Horde"}, -- Ивус Лесной Властелин (Темные берега)
				{54895, addText = {mapID = 62}, faction = "Alliance"}, -- Ивус Трухлявый (Темные берега)
				{nil},
				{58705, addText = {mapID = 390}, }, -- Великая императрица Шек'зара (Вечноцветущий дол)
				{55466, addText = {mapID = 1527}, }, -- Вук'лаз Землелом (Ульдум)
				{nil},
				{56057, addText = {mapID = 1355}, forcedText = {npcID = 152697},}, -- Страж душ (Назжатар)
				{56056, addText = {mapID = 1355}, }, -- Глубинный ужас (Назжатар)
			},
			forcedMaxQuest = 4,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(C_IslandsQueue.GetIslandsWeeklyQuestID() or (E.FACTION_CURRENT == "Horde" and 53435 or 53436), false)
			end,
			name_save = "AzeriteForTheFaction",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- {C_IslandsQueue.GetIslandsWeeklyQuestID()},
				{53435, faction = "Horde",}, -- /dump C_QuestLog.IsOnQuest(53435)
				{53436, faction = "Alliance",}, -- /dump C_QuestLog.IsOnQuest(53436)
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.BfA_Invasion()
			end,
			name_save = "InvasionQuests",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{54134},
				{54136},
				{53711},
				{53701},
				{54138},
				{51982},
				{53883},
				{54137},
				{53885},
				{53939},
				{54135},
				{54132},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.Timers.BfA_Assault()..WORLD_MAP_THREATS
			end,
			name_save = "bfa-nzoth-assault",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{57157}, -- _Uldum
				{56308}, -- _Uldum
				{55350}, -- _Uldum
				{56064}, -- Vale of Eternal Blossoms
				{57728}, -- Vale of Eternal Blossoms
				{57008}, -- Vale of Eternal Blossoms
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			TextLeft = L["Lesser Visions of N'Zoth"],
			name_save = "miniVision",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{58168},
				{58155},
				{58151},
				{58167},
				{58156},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = SPLASH_BATTLEFORAZEROTH_8_3_0_FEATURE1_TITLE,
			name_save = "Horrific Vision",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{57848, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear + 5 Masks"},},
				{57844, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear + 4 Masks"},},
				{57847, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear + 3 Masks"},},
				{57843, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear + 2 Masks"},},
				{57846, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear + 1 Masks"},},
				{57842, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Full Clear No Masks"},},
				{57845, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Vision Boss + 2 Bonus Objectives"},},
				{57841, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Vision Boss Only"},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			-- sorted = true,
			showTooltip = true,
			TextLeft = L["Warfront"],
			name_save = "Warfront",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{53416, faction = "Horde"},
				{53414, faction = "Alliance"},
				{53955, faction = "Horde"},
				{53992, faction = "Alliance"},
				{56137, faction = "Horde"},
				{57959, faction = "Horde"},
				{56136, faction = "Alliance"},
				{57960, faction = "Alliance"},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(62)..": ".."Rares"
			end,
			name_save = "DarkshoreRares",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				-- Alash'anir
				{54695, faction = "Alliance", forcedText = {npcID = 148787},},
				{54696, faction = "Horde", forcedText = {npcID = 148787},},
				-- Aman
				{54405, faction = "Alliance", forcedText = {npcID = 147966},},
				{54406, faction = "Horde", forcedText = {npcID = 147966},},
				-- Amberclaw
				{54285, faction = "Alliance", forcedText = {npcID = 147744},},
				{54286, faction = "Horde", forcedText = {npcID = 147744},},
				-- Athrikus Narassin
				{54278, faction = "Alliance", forcedText = {npcID = 147708},},
				{54279, faction = "Horde", forcedText = {npcID = 147708},},
				-- Commander Ral'esh
				{54426, faction = "Alliance", forcedText = {npcID = 148025},},
				{54427, faction = "Horde", forcedText = {npcID = 148025},},
				-- Conflagros
				{54232, faction = "Alliance", forcedText = {npcID = 147260},},
				{54233, faction = "Horde", forcedText = {npcID = 147260},},
				-- Cyclarus
				{54229, faction = "Alliance", forcedText = {npcID = 147241},},
				{54230, faction = "Horde", forcedText = {npcID = 147241},},
				-- Glimmerspine
				{54884, faction = "Alliance", forcedText = {npcID = 149654},},
				{54885, faction = "Horde", forcedText = {npcID = 149654},},
				-- Granokk
				{54234, faction = "Alliance", forcedText = {npcID = 147261},},
				{54235, faction = "Horde", forcedText = {npcID = 147261},},
				-- Gren Tornfur
				{54428, faction = "Alliance", forcedText = {npcID = 148031},},
				{54429, faction = "Horde", forcedText = {npcID = 148031},},
				-- Hydrath
				{54227, faction = "Alliance", forcedText = {npcID = 147240},},
				{54228, faction = "Horde", forcedText = {npcID = 147240},},
				-- Madfeather
				{54887, faction = "Alliance", forcedText = {npcID = 149657},},
				{54888, faction = "Horde", forcedText = {npcID = 149657},},
				-- Mrggr'marr
				{54408, faction = "Alliance", forcedText = {npcID = 147970},},
				{54409, faction = "Horde", forcedText = {npcID = 147970},},
				-- Scalefiend
				{54893, faction = "Alliance", forcedText = {npcID = 149665},},
				{54894, faction = "Horde", forcedText = {npcID = 149665},},
				-- Shattershard
				{54289, faction = "Alliance", forcedText = {npcID = 147751},},
				{54290, faction = "Horde", forcedText = {npcID = 147751},},
				-- Soggoth the Slitherer
				{54320, faction = "Alliance", forcedText = {npcID = 147897},},
				{54321, faction = "Horde", forcedText = {npcID = 147897},},
				-- Stonebinder Ssra'vess
				{54247, faction = "Alliance", forcedText = {npcID = 147332},},
				{54248, faction = "Horde", forcedText = {npcID = 147332},},
				-- Twilight Prophet Graemeа
				{54397, faction = "Alliance", forcedText = {npcID = 147942},},
				{54398, faction = "Horde", forcedText = {npcID = 147942},},
				-- Athil Dewfire
				{54431, faction = "Horde", forcedText = {npcID = 148037},}, -- УБИЛ ОРДОЙ 54892
				-- Blackpaw
				{54890, faction = "Horde", forcedText = {npcID = 149660},}, -- УБИЛ ОРДОЙ
				-- Grimhorn
				{54891, faction = "Horde", forcedText = {npcID = 149662},},
				-- Onu
				{54291, faction = "Horde", forcedText = {npcID = 147758},}, -- УБИЛ ОРДОЙ 54892
				-- Sapper Odette
				{54452, faction = "Horde", forcedText = {npcID = 148103},}, -- УБИЛ ОРДОЙ 54892
				-- Shadowclaw
				{54892, faction = "Horde", forcedText = {npcID = 149663},}, -- УБИЛ ОРДОЙ 54892
				-- Thelar Moonstrike
				{54252, faction = "Horde", forcedText = {npcID = 147435},},
				-- Agathe Wyrmwood
				{54883, faction = "Alliance", forcedText = {npcID = 149517},},
				-- Burninator Mark V
				{54768, faction = "Alliance", forcedText = {npcID = 149141},},
				-- Commander Drald
				{54309, faction = "Alliance", forcedText = {npcID = 147845},},
				-- Croz Bloodrage
				{54886, faction = "Alliance", forcedText = {npcID = 149655},},
				-- Moxo the Beheader
				{54277, faction = "Alliance", forcedText = {npcID = 147701},},
				-- Orwell Stevenson
				{54889, faction = "Alliance", forcedText = {npcID = 149659},}, -- 149664
				-- Zim'kaga
				{54274, faction = "Alliance", forcedText = {npcID = 147664},},
			},
			-- forcedMaxQuest = 25,
		},
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
			-- TextLeft = function()
			-- 	return E.func_GetMapName(1462)..": "..E.func_GetQuestName(54088, false)
			-- end,
		-- 	name_save = "TheMechagonianThreat",
		-- defS = true,
		-- 	reset = "Once",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		-- Только для Альянса
		-- 		{54088, faction = "Alliance"},
		-- 		{55040, faction = "Alliance"},
		-- 		{54945, faction = "Alliance"},
		-- 		{54087, faction = "Alliance"},
		-- 		{54946, faction = "Alliance"},
		-- 		{54947, faction = "Alliance"},
		-- 		{54992, faction = "Alliance"},
		-- 		{55645, faction = "Alliance"},
		-- 		-- Только для Орды
		-- 		{55646, faction = "Horde"},
		-- 		{55647, faction = "Horde"},
		-- 		{55648, faction = "Horde"},
		-- 		{55630, faction = "Horde"},
		-- 		{55632, faction = "Horde"},
		-- 		{55649, faction = "Horde"},
		-- 		{55650, faction = "Horde"},
		-- 		{55651, faction = "Horde"},
		-- 		{55652, faction = "Horde"},
		-- 		{55685, faction = "Horde"},
		-- 		-- Общие квесты
		-- 		{55730},
		-- 		{55731},
		-- 		{55995},
		-- 		{55734},
		-- 		{55096},
		-- 		{55736},
		-- 		-- {55609}, -- Операция мехагон
		-- 	},
		-- },
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": Rares"
			end,
			name_save = "MechagonRares",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{55512, forcedText = {npcID = 151934}, addText = {mount = 1229},}, -- RARE ELITE 154342 -- MOUNT
				{55539, forcedText = {npcID = 151308},},
				{55857, forcedText = {npcID = 153200},},
				{55537, forcedText = {npcID = 152001},},
				{56368, forcedText = {npcID = 154739},},
				{55812, forcedText = {npcID = 149847},}, -- 152569
				{55514, forcedText = {npcID = 151569},},
				{55814, forcedText = {npcID = 150342},},
				{56207, forcedText = {npcID = 154153},},
				{55513, forcedText = {npcID = 151202},},
				{55367, forcedText = {npcID = 151884},},
				{55852, forcedText = {npcID = 153228},},
				{55855, forcedText = {npcID = 153205},},
				{56367, forcedText = {npcID = 154701},},
				{55399, forcedText = {npcID = 151684},},
				{55369, forcedText = {npcID = 152007},},
				{55544, forcedText = {npcID = 151933},},
				{55207, forcedText = {npcID = 151124},},
				{55386, forcedText = {npcID = 151672},},
				{55859, forcedText = {npcID = 151627},},
				{55853, forcedText = {npcID = 153206},}, -- RARE
				{55515, forcedText = {npcID = 151296},}, -- +QUEST 55918
				{55856, forcedText = {npcID = 152764},},
				{55405, forcedText = {npcID = 151702},},
				{55368, forcedText = {npcID = 150575},},
				{55811, forcedText = {npcID = 152182}, addText = {mount = 1248},}, -- MOUNT
				{56737, forcedText = {npcID = 155583},},
				{55545, forcedText = {npcID = 150937},},
				{55810, forcedText = {npcID = 153000},},
				{55854, forcedText = {npcID = 153226},},
				{56419, forcedText = {npcID = 155060},},
				{55858, forcedText = {npcID = 152113},},
				{56182, forcedText = {npcID = 154225},},
				{55364, forcedText = {npcID = 151623},}, -- 151625
				{55538, forcedText = {npcID = 151940},},
				{55546, forcedText = {npcID = 150394},}, -- 154968
				{56298, forcedText = {npcID = 152290}, addText = {mount = 1257},}, -- MOUNT NEW???? https://wago.io/G7SoF6Zix
			},
			-- forcedMaxQuest = 36+1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": Treasures"
			end,
			name_save = "MechagonTREASURE",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{55547, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{55548, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{55549, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{55550, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{55551, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{55552, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{55553, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{55554, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{55555, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{55556, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
			},
			forcedMaxQuest = 10,
		},
		-- {
		-- showTooltip = true,
		-- TextLeft = "MechagonTREASURE_MISCELLANEOUS",
		-- name_save = "MechagonTREASURE_MISCELLANEOUS",
		-- defS = true,
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {55743},
		-- {56117},
		-- {57134},
		-- },
		-- forcedMaxQuest = 3,
		-- },
		-- {
		-- showTooltip = true,
		-- TextLeft = "MechagonLOCKED_CHESTS1",
		-- name_save = "MechagonLOCKED_CHESTS1",
		-- defS = true,
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {56907},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		-- {
		-- showTooltip = true,
		-- TextLeft = "MechagonLOCKED_CHESTS2",
		-- name_save = "MechagonLOCKED_CHESTS2",
		-- defS = true,
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {57133},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = "UNLOCKING MECHAGON PART 1 ALLIANCE",
		-- name_save = "UNLOCKING MECHAGON PART 1 ALLIANCE",
		-- defS = true,
		-- reset = "Once",
		-- desc = categoryKey,
		-- -- forcedMaxQuest = "all",
		-- quests = {
		-- {56031, faction = "Alliance"},
		-- {56043, faction = "Alliance"},
		-- {55095, faction = "Alliance"},
		-- {54969, faction = "Alliance"},
		-- {56640, faction = "Alliance"},
		-- {56641, faction = "Alliance"},
		-- {56642, faction = "Alliance"},
		-- {56643, faction = "Alliance"},
		-- {56644, faction = "Alliance"},
		-- {55175, faction = "Alliance"},
		-- {54972, faction = "Alliance"},
		-- {56030, faction = "Horde"},
		-- {56044, faction = "Horde"},
		-- {55054, faction = "Horde"},
		-- {54018, faction = "Horde"},
		-- {54021, faction = "Horde"},
		-- {54012, faction = "Horde"},
		-- {55092, faction = "Horde"},
		-- {56063, faction = "Horde"},
		-- {54015, faction = "Horde"},
		-- {56429, faction = "Horde"},
		-- {55094, faction = "Horde"},
		-- {55053, faction = "Horde"},
		-- },
		-- },
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = "UNLOCKING MECHAGON PART 2",
		-- name_save = "UNLOCKING MECHAGON PART 2",
		-- defS = true,
		-- reset = "Once",
		-- desc = categoryKey,
		-- -- forcedMaxQuest = "all",
		-- quests = {
		-- {55851},
		-- {55533},
		-- {55374},
		-- {55400},
		-- {55407},
		-- {55425},
		-- {55497},
		-- {55618},
		-- {57010},
		-- {56162, faction = "Alliance"},
		-- {56350, faction = "Alliance"},
		-- {55361, faction = "Alliance"},
		-- {55363, faction = "Alliance"},
		-- {56156, faction = "Alliance"},
		-- {56161, faction = "Horde"},
		-- {55481, faction = "Horde"},
		-- {55384, faction = "Horde"},
		-- {55385, faction = "Horde"},
		-- {55500, faction = "Horde"},
		-- },
		-- -- forcedMaxQuest = "all",
		-- },
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": Dailies Visitor Quests"
			end,
			name_save = "DAILY_VISITOR_QUESTS",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{55463},
				{55658},
				{55688}, -- https://www.wowhead.com/ru/quest=55658/
				{55718},
				{55765},
				{55885},
				{56053},
				{55813},
				{56301},
				{56142},
				{55528},
				{56365},
				{56552, faction = "Horde",},
				{56558, faction = "Alliance"},
				{56572},
				{56501},
				{56493},
				{55575},
				{55672}, -- https://www.wowhead.com/ru/quest=55658/
				{55717}, -- https://www.wowhead.com/ru/quest=55658/
				{56049}, -- https://www.wowhead.com/ru/quest=55658/
				{56469},
				{55816},
				{55905},
				{56184},
				{56306},
				{54090},
				{56355},
				{56523},
				{56410},
				{56508},
				{56471},
				{56405},
			},
			-- forcedMaxQuest = 32,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": Daily WQ"
			end,
			name_save = "MechagonDAILYWQ",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{56139}, -- WQ
				{56141}, -- WQ
				{55901}, -- WQ
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": "..E.func_GetAchievementName(13489)
			end,
			name_save = "MechagonSecretFish",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{55309},
				{55299},
				{55310},
				{55306},
				{55307},
				{55313},
				{55308},
				{55312},
				{55305},
				{55311},
			},
			forcedMaxQuest = 10,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1462)..": "..E.func_GetAchievementName(13791)
			end,
			name_save = "MechagonMakingAMount",
			defS = false,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{55608},
				{54086},
				{54929},
				{55373},
				{55697},
				{54922},
				{56168},
				{54083},
				{56175},
				{55696},
				{55753},
				{55622},
			},
			-- forcedMaxQuest = 10,
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
local function localfunc2()
	local OctoTable_Otrisovka_TextCenter = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
		if Octo_ToDo_DB_Vars.Items then
			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
					----------------------------------------------------------------
					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.Items.Bags[158075] then
						TextCenter = CharInfo.PlayerData.azeriteLVL and E.COLOR_GREEN..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.COLOR_GRAY..CharInfo.PlayerData.azeriteEXP.."|r" or E.COLOR_ORANGE.."in bank|r"
					end
					----------------------------------------------------------------
					TextLeft = E.func_GetItemName(158075)
					ColorLeft = E.OctoTable_Expansions[categoryKey].color
					SettingsType = "Items#"..158075
					----------------------------------------------------------------
					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
					----------------------------------------------------------------
					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.Items.Bags[169223] then
						if CharInfo.PlayerData.cloak_lvl then
							TextCenter = E.COLOR_CYAN..AZERITE_ESSENCE_RANK:format(CharInfo.PlayerData.cloak_lvl).."|r"
						else
							TextCenter = E.COLOR_ORANGE.."in bank|r"
						end
					end
					----------------------------------------------------------------
					TextLeft = E.func_GetItemName(169223)
					ColorLeft = E.OctoTable_Expansions[categoryKey].color
					SettingsType = "Items#"..169223
					----------------------------------------------------------------
					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
					----------------------------------------------------------------
					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
					TooltipKey = "BfA_mechagonItems"
					TextCenter = E.COLOR_GRAY..ITEMS.."|r"
					----------------------------------------------------------------
					TextLeft = "МЕХАГОН"
					ColorLeft = E.OctoTable_Expansions[categoryKey].color
					----------------------------------------------------------------
					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
					----------------------------------------------------------------
			end)
		end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_TextCenter
end