local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local dropdownOrder = 6
local expansionID = 8
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[dropdownOrder].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].name
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(dropdownOrder)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {
		1560,
		1721,
		1803,
		1755,
		1719,
		1710,
		1716,
		1717,
		1718,
		1580,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[dropdownOrder].icon, name = E.OctoTable_Expansions[dropdownOrder].color..E.OctoTable_Expansions[dropdownOrder].name.."|r",},
		-- ["Battle for Azeroth"] = {
		2164, --name = "Защитники Азерот", side = "-", category = "Battle for Azeroth", }, --[faction=2164]
		2415, --name = "Раджани", side = "-", category = "Battle for Azeroth", }, --[faction=2415]
		2391, --name = "Ржавоболтское сопротивление", side = "-", category = "Battle for Azeroth", }, --[faction=2391]
		2163, --name = "Тортолланские искатели", side = "-", category = "Battle for Azeroth", }, --[faction=2163]
		2417, --name = "Ульдумский союз", side = "-", category = "Battle for Azeroth", }, --[faction=2417]
		2427, --name = "Молодой акир", side = "-", category = "Battle for Azeroth", }, --[faction=2427]
		2157, --name = "Армия Чести", side = "Horde", category = "Battle for Azeroth", }, --[faction=2157]
		2373, --name = "Освобожденные", side = "Horde", category = "Battle for Azeroth", }, --[faction=2373]
		2158, --name = "Жители Вол'дуна", side = "Horde", category = "Battle for Azeroth", }, --[faction=2158]
		2103, --name = "Империя Зандалари", side = "Horde", category = "Battle for Azeroth", }, --[faction=2103]
		2156, --name = "Экспедиция Таланджи", side = "-", category = "Battle for Azeroth", }, --[faction=2156]
		2233, --name = "Dino Training - Pterrodax", side = "Horde", category = "Battle for Azeroth", }, --[faction=2233]
		2370, --name = "Обучение динозавров – Дикорог", side = "-", category = "Battle for Azeroth", }, --[faction=2370]
		2390, --name = "Вим Соленодух", side = "Horde", category = "Battle for Azeroth", }, --[faction=2390]
		2389, --name = "Нери Остроерш", side = "Horde", category = "Battle for Azeroth", }, --[faction=2389]
		2388, --name = "Поэн Солежабрик", side = "Horde", category = "Battle for Azeroth", }, --[faction=2388]
		2159, --name = "7-й легион", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2159]
		2160, --name = "Адмиралтейство Праудмуров", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2160]
		2400, --name = "Клинки Волн", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2400]
		2162, --name = "Орден Возрождения Шторма", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2162]
		2161, --name = "Орден Пылающих Углей", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2161]
		2395, --name = "Улей Медокрылов", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2395]
		2398, --name = "Фуражир из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2398]
		2397, --name = "Пчеломатка улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2397]
		2396, --name = "Трутень из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2396]
		2376, --name = "Оракул Ори", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2376]
		2375, --name = "Мастер охоты Акана", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2375]
		2377, --name = "Мастер клинка Иновари", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2377]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{nil},
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
			textleft = E.func_questName(C_IslandsQueue.GetIslandsWeeklyQuestID() or (E.curFaction == "Horde" and 53435 or 53436)),
			name_save = "AzeriteForTheFaction",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				-- {C_IslandsQueue.GetIslandsWeeklyQuestID()},
				{53435, faction = "Horde",}, -- /dump C_QuestLog.IsOnQuest(53435)
				{53436, faction = "Alliance",}, -- /dump C_QuestLog.IsOnQuest(53436)
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.Timers.BfA_Invasion(),
			name_save = "InvasionQuests",
			reset = "Daily",
			desc = dropdownOrder,
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
			textleft = E.Timers.BfA_Assault().."AssaultTheBlackEmpire",
			name_save = "AssaultTheBlackEmpire",
			reset = "Weekly",
			desc = dropdownOrder,
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
			textleft = "miniVision",
			name_save = "miniVision",
			reset = "Daily",
			desc = dropdownOrder,
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
			-- sorted = true,
			showTooltip = true,
			textleft = "Warfront",
			name_save = "Warfront",
			reset = "Weekly",
			desc = dropdownOrder,
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
			textleft = "Darkshore: Rares",
			name_save = "DarkshoreRares",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				-- Alash'anir
				{54695, faction = "Alliance", forcedText = {npcID = 148787},},
				{54696, faction = "Horde", forcedText = {npcID = 148787},},
				-- Aman
				{54405, faction = "Alliance",forcedText = {npcID = 147966},},
				{54406, faction = "Horde", forcedText = {npcID = 147966},},
				-- Amberclaw
				{54285, faction = "Alliance",forcedText = {npcID = 147744},},
				{54286, faction = "Horde", forcedText = {npcID = 147744},},
				-- Athrikus Narassin
				{54278, faction = "Alliance",forcedText = {npcID = 147708},},
				{54279, faction = "Horde", forcedText = {npcID = 147708},},
				-- Commander Ral'esh
				{54426, faction = "Alliance",forcedText = {npcID = 148025},},
				{54427, faction = "Horde", forcedText = {npcID = 148025},},
				-- Conflagros
				{54232, faction = "Alliance",forcedText = {npcID = 147260},},
				{54233, faction = "Horde", forcedText = {npcID = 147260},},
				-- Cyclarus
				{54229, faction = "Alliance",forcedText = {npcID = 147241},},
				{54230, faction = "Horde", forcedText = {npcID = 147241},},
				-- Glimmerspine
				{54884, faction = "Alliance", forcedText = {npcID = 149654},},
				{54885, faction = "Horde", forcedText = {npcID = 149654},},
				-- Granokk
				{54234, faction = "Alliance",forcedText = {npcID = 147261},},
				{54235, faction = "Horde", forcedText = {npcID = 147261},},
				-- Gren Tornfur
				{54428, faction = "Alliance",forcedText = {npcID = 148031},},
				{54429, faction = "Horde", forcedText = {npcID = 148031},},
				-- Hydrath
				{54227, faction = "Alliance",forcedText = {npcID = 147240},},
				{54228, faction = "Horde", forcedText = {npcID = 147240},},
				-- Madfeather
				{54887, faction = "Alliance",forcedText = {npcID = 149657},},
				{54888, faction = "Horde", forcedText = {npcID = 149657},},
				-- Mrggr'marr
				{54408, faction = "Alliance",forcedText = {npcID = 147970},},
				{54409, faction = "Horde", forcedText = {npcID = 147970},},
				-- Scalefiend
				{54893, faction = "Alliance",forcedText = {npcID = 149665},},
				{54894, faction = "Horde", forcedText = {npcID = 149665},},
				-- Shattershard
				{54289, faction = "Alliance", forcedText = {npcID = 147751},},
				{54290, faction = "Horde", forcedText = {npcID = 147751},},
				-- Soggoth the Slitherer
				{54320, faction = "Alliance",forcedText = {npcID = 147897},},
				{54321, faction = "Horde", forcedText = {npcID = 147897},},
				-- Stonebinder Ssra'vess
				{54247, faction = "Alliance",forcedText = {npcID = 147332},},
				{54248, faction = "Horde", forcedText = {npcID = 147332},},
				-- Twilight Prophet Graemeа
				{54397, faction = "Alliance",forcedText = {npcID = 147942},},
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
		-- 	textleft = "Mechagon: "..E.func_questName(54088),
		-- 	name_save = "TheMechagonianThreat",
		-- 	reset = "Once",
		-- 	desc = dropdownOrder,
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
			textleft = "Mechagon: Rares",
			name_save = "MechagonRares",
			reset = "Daily",
			desc = dropdownOrder,
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
			showTooltip = true,
			textleft = "Mechagon: Treasures",
			name_save = "MechagonTREASURE",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{55547},
				{55548},
				{55549},
				{55550},
				{55551},
				{55552},
				{55553},
				{55554},
				{55555},
				{55556},
			},
			forcedMaxQuest = 10,
		},
		-- {
		-- showTooltip = true,
		-- textleft = "MechagonTREASURE_MISCELLANEOUS",
		-- name_save = "MechagonTREASURE_MISCELLANEOUS",
		-- reset = "Daily",
		-- desc = dropdownOrder,
		-- quests = {
		-- {55743},
		-- {56117},
		-- {57134},
		-- },
		-- forcedMaxQuest = 3,
		-- },
		-- {
		-- showTooltip = true,
		-- textleft = "MechagonLOCKED_CHESTS1",
		-- name_save = "MechagonLOCKED_CHESTS1",
		-- reset = "Daily",
		-- desc = dropdownOrder,
		-- quests = {
		-- {56907},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		-- {
		-- showTooltip = true,
		-- textleft = "MechagonLOCKED_CHESTS2",
		-- name_save = "MechagonLOCKED_CHESTS2",
		-- reset = "Daily",
		-- desc = dropdownOrder,
		-- quests = {
		-- {57133},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- textleft = "UNLOCKING MECHAGON PART 1 ALLIANCE",
		-- name_save = "UNLOCKING MECHAGON PART 1 ALLIANCE",
		-- reset = "Once",
		-- desc = dropdownOrder,
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
		-- textleft = "UNLOCKING MECHAGON PART 2",
		-- name_save = "UNLOCKING MECHAGON PART 2",
		-- reset = "Once",
		-- desc = dropdownOrder,
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
			textleft = "Mechagon: Dailies Visitor Quests",
			name_save = "DAILY_VISITOR_QUESTS",
			reset = "Daily",
			desc = dropdownOrder,
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
			textleft = "Mechagon: Daily WQ",
			name_save = "MechagonDAILYWQ",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{56139}, -- WQ
				{56141}, -- WQ
				{55901}, -- WQ
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "Mechagon: Secret Fish",
			name_save = "MechagonSecretFish",
			reset = "Daily",
			desc = dropdownOrder,
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
			textleft = "Mechagon: Making a Mount",
			name_save = "MechagonMakingAMount",
			reset = "Once",
			desc = dropdownOrder,
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
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
	}
	----------------------------------------------------------------
end

table.insert(E.Components, tempFunction)


local function localfunc2()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then
		if Octo_ToDo_DB_Vars.Items then
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", nil, nil, nil, false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[158075] then
						textCENT = CharInfo.PlayerData.azeriteLVL and E.Green_Color..CharInfo.PlayerData.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.PlayerData.azeriteEXP.."|r" or E.Orange_Color.."in bank|r"
					end
					----------------------------------------------------------------
					textLEFT = E.func_itemName(158075)
					colorLEFT = E.OctoTable_Expansions[dropdownOrder].color
					settingsType = "Items#"..158075
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", nil, nil, nil, false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[169223] then
						if CharInfo.PlayerData.cloak_lvl then
							textCENT = E.Cyan_Color..AZERITE_ESSENCE_RANK:format(CharInfo.PlayerData.cloak_lvl).."|r"
						else
							textCENT = E.Orange_Color.."in bank|r"
						end
					end
					----------------------------------------------------------------
					textLEFT = E.func_itemName(169223)
					colorLEFT = E.OctoTable_Expansions[dropdownOrder].color
					settingsType = "Items#"..169223
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", nil, nil, nil, false, nil, nil
					tooltipKey = "BfA_mechagonItems"
					textCENT = E.Gray_Color..ITEMS.."|r"
					----------------------------------------------------------------
					textLEFT = "МЕХАГОН"
					colorLEFT = E.OctoTable_Expansions[dropdownOrder].color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end