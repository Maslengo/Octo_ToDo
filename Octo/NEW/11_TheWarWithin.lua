local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheWarWithin = {}
E.OctoTables_DataOtrisovka.TheWarWithin.Text = {E.OctoTable_Expansions[11].color..E.OctoTable_Expansions[11].name.."|r"}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheWarWithin.Currencies = {
	-- 3056, 2815,
	-- season 3
	3356, 3290, 3288, 3286, 3284, 3141, 3028, 3008, 2803,
	-- 3149, 3226, 3218, 3090, 3028, 2803, 3116, 2815, 3056, 3008, 3110, 3109, 3108, 3107,

	-- https://warcraft.wiki.gg/wiki/Catalyst
	-- The War Within
	-- (Season 4)
	3269, -- (Season 3)
	3116, -- Essence of Kaja'mite (Season 2)
	-- 2813, -- Harmonized Silk (Season 1)
	-- Dragonflight
	-- 2912, -- Renascent Awakening ()
	-- 2796, -- Renascent Dream (Season 3)
	-- 2533, -- Renascent Shadowflame (Season 2)
	-- 2167, -- Catalyst Charges (Season 1)
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheWarWithin.Items = {
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheWarWithin.Reputations = {
	-- header = {icon = E.OctoTable_Expansions[11].icon, name = E.OctoTable_Expansions[11].color..E.OctoTable_Expansions[11].name.."|r",},
	-- ["The War Within"] = {
	-- { id = 2688,},
	-- { id = 2653,},
	-- { id = 2570,},
	-- { id = 2590,},
	-- { id = 2594,},
	-- { id = 2600,},
	-- { id = 2640,},
	-- { id = 2658,},
	-- { id = 2667,},
	-- { id = 2736,},
	-- { id = 2689,},
	-- { id = 2693,},
	-- { id = 2683,},
	-- { id = 2596,},
	-- { id = 2739,}, -- INACTIVE
	-- { id = 2611,},
	-- { id = 2612,},
	-- { id = 2722,},
	-- { id = 2644,},
	-- { id = 2613,},
	-- { id = 2659,},
	-- { id = 2645,},
	-- { id = 2669,},
	-- { id = 2685,},
	-- { id = 2677,},
	-- { id = 2673,},
	-- { id = 2675,},
	-- { id = 2671,},
	-- { id = 2668,},
	-- { id = 2684,},
	-- { id = 2670,},
	-- { id = 2674,},
	-- { id = 2676,},
	-- { id = 2672,},
	-- { id = 2601,},
	-- { id = 2607,},
	-- { id = 2605,},
	-- { id = 2647,},
	-- { id = 2648,},
	-- { id = 2649,},
	-- { id = 2658, },
	2653, --name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
	2640, --name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
	2600, --name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
	2594, --name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
	2590, --name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
	2570, --name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
	----------------------------------------------------------------
	2607, --name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
	2605, --name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
	2601, --name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
	----------------------------------------------------------------
	2685, --name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
	2677, --name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
	2675, --name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
	2673, --name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
	2671, --name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
	2669, --name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.TheWarWithin.UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{81630, forcedText = {npcID = 221084}, addText = {mapID = 2248},}, -- Кордак (221084) Остров Дорн
				{82653, addText = {mapID = 2214},}, -- Гулкие глубины.
				{81653, forcedText = {npcID = 221224}, addText = {mapID = 2215},}, -- Шуррай (221224) Тайносводье
				{81624, forcedText = {npcID = 221067}, addText = {mapID = 2213},}, -- Орта (221067) Город Нитей
				{85088, forcedText = {npcID = 231821}, addText = {mapID = 2346},}, -- Гоблионе (231821) Нижняя Шахта
				{nil},
				{87354, forcedText = {npcID = 238319}, addText = {mapID = 2371},}, -- Reshanor (238319) К'ареш
			},
			forcedMaxQuest = 2,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2371)..": ".."Rares",
			name_save = "Rares2371",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{90587, forcedText = {npcID = 232098}, addText = {mapID = 2472},},
				{90696, forcedText = {npcID = 241956}, addText = {mapID = 2472},},
				{90698, forcedText = {npcID = 238540}, addText = {mapID = 2472},},
				{nil,   forcedText = {npcID = 235104}, addText = {mapID = 2472},},
				{86464,   forcedText = {npcID = 235087}, addText = {mapID = 2472, mount = 2602},}, -- Devoured Energy-Pod -- 91435, _, 91311, 91289
				{nil},
				{91276, forcedText = {npcID = 245998}, },
				{91275, forcedText = {npcID = 245997}, },
				{90687, forcedText = {npcID = 238144}, },
				{90689, forcedText = {npcID = 238536}, },
				{90692, forcedText = {npcID = 241920}, },
				{90694, forcedText = {npcID = 238384}, },
				{nil},
				{nil, addText = {spellID = 1214374},},
				{90596, forcedText = {npcID = 232128}, },
				{90586, forcedText = {npcID = 232077}, },
				{90594, forcedText = {npcID = 231981}, },
				{90588, forcedText = {npcID = 232108}, },
				{90595, forcedText = {npcID = 232127}, },
				{90590, forcedText = {npcID = 232182}, }, -- 90679 вместе с ним
				{90591, forcedText = {npcID = 232189}, },
				{90585, forcedText = {npcID = 232006}, },
				{90583, forcedText = {npcID = 232129}, },
				{90592, forcedText = {npcID = 232193}, },
				{91293, forcedText = {npcID = 234845}, },
				{90589, forcedText = {npcID = 232111}, },
				{90593, forcedText = {npcID = 232195}, },
				{90584, forcedText = {npcID = 232199}, },
			},
			-- forcedMaxQuest = 3,
		},
		-- ========================
		-- Azj-Kahet
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2255)..": ".."Rares",
			name_save = "Rares2255",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{81695, forcedText = {npcID = 216031}, },
				{78905, forcedText = {npcID = 214151}, },
				{81704, forcedText = {npcID = 216042}, },
				{81634, forcedText = {npcID = 216038}, },
				{82077, forcedText = {npcID = 222624}, },
				{81707, forcedText = {npcID = 216045}, },
				{81699, forcedText = {npcID = 216041}, },
				{82036, forcedText = {npcID = 216050}, },
				{82034, forcedText = {npcID = 216048}, },
			},
		},
		-- ========================
		-- Hallowfall
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2215)..": ".."Rares",
			name_save = "Rares2215",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{81763, forcedText = {npcID = 207802}, },
				{82558, forcedText = {npcID = 206514}, },
				{82560, forcedText = {npcID = 214757}, },
				{82559, forcedText = {npcID = 206184}, },
				{81880, forcedText = {npcID = 221753}, },
				{80011, forcedText = {npcID = 218458}, },
				{82562, forcedText = {npcID = 221179}, },
				{82564, forcedText = {npcID = 207780}, },
				{81881, forcedText = {npcID = 221767}, },
				{81761, forcedText = {npcID = 221551}, },
			},
		},
		-- ========================
		-- Isle of Dorn
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2248)..": ".."Rares",
			name_save = "Rares2248",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{82196, forcedText = {npcID = 219281}, },
				{81893, forcedText = {npcID = 219264}, },
				{81920, forcedText = {npcID = 221128}, },
				{81895, forcedText = {npcID = 219265}, },
				{81907, forcedText = {npcID = 219266}, },
				{81905, forcedText = {npcID = 219279}, },
				{81899, forcedText = {npcID = 219268}, },
				{81902, forcedText = {npcID = 219270}, },
				{81921, forcedText = {npcID = 220890}, },
				{81897, forcedText = {npcID = 219267}, },
			},
		},
		-- ========================
		-- Ringing Deeps
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2214)..": ".."Rares",
			name_save = "Rares2214",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{81674, forcedText = {npcID = 220265}, },
				{80557, forcedText = {npcID = 220274}, },
				{80505, forcedText = {npcID = 220276}, },
				{81562, forcedText = {npcID = 220267}, },
				{81511, forcedText = {npcID = 220266}, },
				{80560, forcedText = {npcID = 220269}, },
				{81566, forcedText = {npcID = 220272}, },
				{80003, forcedText = {npcID = 218393}, },
				{80536, forcedText = {npcID = 220286}, },
				{81648, forcedText = {npcID = 221199}, },
			},
		},
		-- ========================
		-- Siren Isle
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2369)..": ".."Rares",
			name_save = "Rares2369",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{85672, forcedText = {npcID = 229982}, },
				{85669, forcedText = {npcID = 228201}, },
				{85437, forcedText = {npcID = 229992}, },
				{84801, forcedText = {npcID = 228601}, },
				{84807, forcedText = {npcID = 228605}, },
				{84804, forcedText = {npcID = 228603}, },
				{84810, forcedText = {npcID = 228609}, },
				{84813, forcedText = {npcID = 228612}, },
			},
		},
		-- ========================
		-- Undermine
		-- ========================
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2346)..": ".."Rares",
			name_save = "Rares2346",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{84917, forcedText = {npcID = 230931}, },
				{84918, forcedText = {npcID = 230934}, },
				{84919, forcedText = {npcID = 230940}, },
				{84920, forcedText = {npcID = 230946}, },
				{84921, forcedText = {npcID = 230951}, },
				{84922, forcedText = {npcID = 230979}, },
				{84926, forcedText = {npcID = 230995}, },
				{84927, forcedText = {npcID = 231012}, },
			},
		},
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		-- ========================
		-- isle_of_dorn (2248)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2248)..": ".."Treasures",
			name_save = "Treasures2248",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{82715},
				{82714},
				{82287},
				{82325},
				{83243},
				{83246},
				{83245},
				{83244},
				{82326},
				{82246},
				{83242},
				{83094},
				{83840},
			},
		},
		-- ========================
		-- secrets_of_azeroth (71)
		-- ========================
		-- ========================
		-- siren_isle (2369)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2369)..": ".."Treasures",
			name_save = "Treasures2369",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{87446},
				{86764},
				{86767},
				{86766},
				{86732},
				{85716},
				{84547},
				{84839},
				{86765},
				{84529},
				{84527},
			},
		},
		-- ========================
		-- ratts_revenge (78)
		-- ========================
		-- ========================
		-- undermine (2346)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2346)..": ".."Treasures",
			name_save = "Treasures2346",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{85683},
				{85698},
				{85814},
				{85426},
				{85422},
				{85424},
				{85425},
				{85492},
				{85495},
				{85494},
				{85496},
				{86487},
			},
		},
		-- ========================
		-- ringing_deeps (2214)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2214)..": ".."Treasures",
			name_save = "Treasures2214",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{82230},
				{82239},
				{82820},
				{82464},
				{82819},
				{80485},
				{82235},
				{82818},
				{83030},
				{79308},
			},
		},
		-- ========================
		-- azj_kahet (2255)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2255)..": ".."Treasures",
			name_save = "Treasures2255",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{82520},
				{82718},
				{82722},
				{82720},
				{82529},
				{82721},
				{82719},
				{82727},
				{82527},
				{82525},
			},
		},
		-- ========================
		-- hallowfall (2215)
		-- ========================
		-- Treasures
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2215)..": ".."Treasures",
			name_save = "Treasures2215",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{83298},
				{83263},
				{83284},
				{81468},
				{81971},
				{81978},
				{81972},
				{82005},
				{83273},
				{79275},
				{80687},
				{81518},
			},
		},
		-- ========================
		-- delves (2250)
		-- ========================
		-- ========================
		-- undermine (2346)
		-- ========================
		-- Treasure
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(2346)..": ".."Treasure",
			name_save = "Treasure2346",
			reset = "Once", -- "Daily",
			desc = "TheWarWithin",
			quests = {
				{85683},
				{85698},
				{85814},
				{85426},
				{85422},
				{85424},
				{85425},
				{85492},
				{85495},
				{85494},
				{85496},
				{86487},
				{86630},
				{85781},
				{85785},
				{86773},
				{85787},
				{86772},
				{85786},
				{86771},
				{85788},
				{86774},
				{87007},
				{85072},
				{85116},
				{85117},
				{85114},
				{85115},
			},
		},
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		{
			showTooltip = true,
			textleft = E.func_questName(84370),
			name_save = "TheKeytoSuccess",
			reset = "Daily", -- "Once", ???
			desc = "TheWarWithin",
			quests = {
				{84370},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_questName(82449),
			name_save = "TheCalloftheWorldsoul",
			reset = "Weekly",
			desc = "TheWarWithin",
			-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
			quests = {
				-- 87424,
				-- 87423,
				-- 87422,
				-- 87419,
				-- 87417,
				-- 82659,
				-- 82516,
				-- 82512,
				-- 82511,
				-- 82510,
				-- 82509,
				-- 82508,
				-- 82507,
				-- 82506,
				-- 82505,
				-- 82504,
				-- 82503,
				-- 82502,
				-- 82501,
				-- 82500,
				-- 82499,
				-- 82498,
				-- 82497,
				-- 82496,
				-- 82495,
				-- 82494,
				-- 82493,
				-- 82492,
				-- 82491,
				-- 82490,
				-- 82489,
				-- 82488,
				-- 82487,
				-- 82486,
				-- 82485,
				-- 82483,
				-- 82482,
				-- 82453,
				-- 82452,
				-- 82321,
				-- 82286,
				-- 82285,
				-- 82263,
				-- 82260,
				-- 82207,
				-- 82164,
				-- 81985,
				{82482}, -- Worldsoul: Snuffling
				{82516}, -- Worldsoul: Forging a Pact
				{82483}, -- Worldsoul: Spreading the Light
				{82453}, -- Worldsoul: Encore!
				{82489}, -- Worldsoul: The Dawnbreaker
				{82659}, -- Worldsoul: Nerub-ar Palace
				{87417}, -- Worldsoul: Dungeons
				{87419}, -- Worldsoul: Delves
				{82490}, -- Worldsoul: Priory of the Sacred Flame
				{82491}, -- Worldsoul: Ara-Kara, City of Echoes
				{82492}, -- Worldsoul: City of Threads
				{82493}, -- Worldsoul: The Dawnbreaker
				{82494}, -- Worldsoul: Ara-Kara, City of Echoes
				{82496}, -- Worldsoul: City of Threads
				{82497}, -- Worldsoul: The Stonevault
				{82498}, -- Worldsoul: Darkflame Cleft
				{82499}, -- Worldsoul: Priory of the Sacred Flame
				{82500}, -- Worldsoul: The Rookery
				{82501}, -- Worldsoul: The Dawnbreaker
				{82502}, -- Worldsoul: Ara-Kara, City of Echoes
				{82503}, -- Worldsoul: Cinderbrew Meadery
				{82504}, -- Worldsoul: City of Threads
				{82505}, -- Worldsoul: The Stonevault
				{82506}, -- Worldsoul: Darkflame Cleft
				{82507}, -- Worldsoul: Priory of the Sacred Flame
				{82508}, -- Worldsoul: The Rookery
				{82509}, -- Worldsoul: Nerub-ar Palace
				{82510}, -- Worldsoul: Nerub-ar Palace
				{82511}, -- Worldsoul: Awakening Machine
				{89514}, -- Worldsoul: Horrific Visions Revisited
				{82512}, -- Worldsoul: World Boss
				{87423}, -- Worldsoul: Undermine Explorer
				{87424}, -- Worldsoul: World Bosses
				{82488}, -- Worldsoul: Darkflame Cleft
				{82487}, -- Worldsoul: The Stonevault
				{82486}, -- Worldsoul: The Rookery
				{82485}, -- Worldsoul: Cinderbrew Meadery
				{82452}, -- Worldsoul: World Quests
				{87422}, -- Worldsoul: Undermine World Quests
				{82495}, -- Worldsoul: Cinderbrew Meadery
				{89502}, -- Worldsoul: Nightfall
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "Archives",
			name_save = "Archives",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{82678},
				{82679},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "Delves",
			name_save = "Delves",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{82708},
				{82707},
				{82706},
				{82709},
				{82710},
				{82711},
				{82712},
				{82746},
				-- {39020},
				{39033},
				-- {40792},
				{39042},
				-- {39021},
				{39034},
				{39040},
				{39041},
				{44174},
				{64970},
				-- {72719},
				-- {72724},
				-- {72725},
				-- {72726},
				-- {83365},
				-- {72727},
				-- {83363},
				{72810},
				{83345},
				{84776},
				{83347},
				{83358},
				{83357},
				{83366},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.Timers.TWW_BeledarCycle()..E.func_questName(83240),
			name_save = "TheTheaterTroupe",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{83240},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_questName(76586),
			name_save = "SpreadingtheLight",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{76586},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_questName(83333),
			name_save = "GearingUpforTrouble",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{83333},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "SpecialAssignments",
			name_save = "SpecialAssignments",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{82355},
				{81649},
				{81691},
				{83229},
				{82852},
				{82787},
				{82414},
				{82531},
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = E.func_questName(82946),
			name_save = "RollinDownintheDeeps",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{82946},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "BiergothDungeonQuest",
			name_save = "BiergothDungeonQuest",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{83432},
				{83436},
				{83443},
				{83457},
				{83458},
				{83459},
				{83465},
				{83469},
				{83460},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "TWWProfessionWeeklies",
			name_save = "TWWProfessionWeeklies",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{84127},
				{84128},
				{84129},
				{84130},
				{84131},
				{84132},
				{84133},
				{83103},
				{83102},
				{83104},
				{83106},
				{83105},
				{83097},
				{83100},
				{82993},
				{83098},
				{82992},
				{84086},
				{84084},
				{84085},
				{82970},
				{82962},
				{82965},
				{82958},
				{82916},
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = "TWWAlgariTreatise",
			name_save = "TWWAlgariTreatise",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{83725},
				{83726},
				{83727},
				{83728},
				{83729},
				{83730},
				{83731},
				{83732},
				{83733},
				{83734},
				{83735},
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = "AnniversaryRestoredCofferKey",
			name_save = "AnniversaryRestoredCofferKey",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{86202},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "SirenIsleWeekly",
			name_save = "SirenIsleWeekly",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{84852},
				{84680},
				{83932},
				{84432},
				{84248},
				{84222},
				{84851},
				{83753},
				{84299},
				{84619},
				{83827},
				{84001},
				{84850},
				{85589},
				{84430},
				{85051},
				{84627},
			},
			forcedMaxQuest = 6,
		},
		{
			showTooltip = true,
			textleft = "MajorKeyflames",
			name_save = "MajorKeyflames",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{79471},
				{79470},
				{79469},
				{79380},
				{79329},
				{78657},
				{78590},
				{76338},
			},
			forcedMaxQuest = 8,
		},
		{
			showTooltip = true,
			textleft = "MinorKeyflames",
			name_save = "MinorKeyflames",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{81632},
				-- 81574,
				-- 80562,
				{80004},
				-- 79346,
				-- 79216,
				{79173},
				-- 79158,
				{78972},
				-- 78933,
				-- 78915,
				{78656},
				{76997},
				-- 76733,
				{76600},
				{76394},
				-- 76169,
				-- SAVEDINSTANCE
				-- 76169, -- Glow in the Dark
				-- 76394, -- Shadows of Flavor
				-- 76600, -- Right Between the Gyros-Optics
				-- 76733, -- Tater Trawl
				-- 76997, -- Lost in Shadows
				-- 78656, -- Hose It Down
				-- 78915, -- Squashing the Threat
				-- 78933, -- The Sweet Eclipse
				-- 78972, -- Harvest Havoc
				-- 79158, -- Seeds of Salvation
				-- 79173, -- Supply the Effort
				-- 79216, -- Web of Manipulation
				-- 79346, -- Chew On That
				-- 80004, -- Crab Grab
				-- 80562, -- Blossoming Delight
				-- 81574, -- Sporadic Growth
				-- 81632, -- Lizard Looters
			},
			forcedMaxQuest = 8,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = L["Delver's Call"],
			name_save = "DelversCall",
			reset = "Once",
			desc = "TheWarWithin",
			quests = {
				{nil, addText = {mapID = 2248},}, -- Isle of Dorn
				{85648},
				{83759},
				{83758},
				{nil},
				{nil, addText = {mapID = 2215},}, -- Hallowfall
				{83768},
				{85664},
				{83767},
				{83769},
				{nil},
				{nil, addText = {mapID = 2214},}, -- The Ringing Deeps (Гулкие глубины.)
				{85649},
				{83766},
				{nil},
				{nil, addText = {mapID = 2255},}, -- Azj-Kahet
				{83770},
				{83771},
				{85667},
				{85666},
			},
			-- forcedMaxQuest = 13,
		},
		{
			showTooltip = true,
			textleft = "tww-weekly-cache",
			name_save = "tww-weekly-cache",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{84736},
				{84737},
				{84738},
				{84739},
			},
			forcedMaxQuest = 4,
		},
		{
			showTooltip = true,
			textleft = "tww-lesser-keyflame",
			name_save = "tww-lesser-keyflame",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{76169}, -- Glow in the Dark
				{76394}, -- Shadows of Flavor
				{76600}, -- Right Between the Gyros-Optics
				{76733}, -- Tater Trawl
				{76997}, -- Lost in Shadows
				{78656}, -- Hose It Down
				{78915}, -- Squashing the Threat
				{78933}, -- The Sweet Eclipse
				{78972}, -- Harvest Havoc
				{79158}, -- Seeds of Salvation
				{79173}, -- Supply the Effort
				{79216}, -- Web of Manipulation
				{79346}, -- Chew On That
				{80004}, -- Crab Grab
				{80562}, -- Blossoming Delight
				{81574}, -- Sporadic Growth
				{81632}, -- Lizard Looters
			},
			forcedMaxQuest = 8,
		},
		{
			showTooltip = true,
			textleft = "tww-brawl-weekly",
			name_save = "tww-brawl-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{47148},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-pvp-weekly",
			name_save = "tww-pvp-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{80184}, -- Preserving in Battle
				{80185}, -- Preserving Solo
				{80186}, -- Preserving in War
				{80187}, -- Preserving in Skirmishes
				{80188}, -- Preserving in Arenas
				{80189}, -- Preserving Teamwork
			},
			forcedMaxQuest = 6, -- ОДИН?
		},
		{
			showTooltip = true,
			textleft = "tww-pvp-world",
			name_save = "tww-pvp-world",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{81793}, -- Sparks of War: Isle of Dorn
				{81794}, -- Sparks of War: The Ringing Deeps
				{81795}, -- Sparks of War: Hallowfall
				{81796}, -- Sparks of War: Azj-Kahet
				{86853}, -- Sparks of War: Undermine
			},
			forcedMaxQuest = 5, -- ОДИН?
		},
		{
			showTooltip = true,
			textleft = "tww-the-severed-threads",
			name_save = "tww-the-severed-threads",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{80670}, -- Eyes of the Weaver
				{80671}, -- Blade of the General
				{80672}, -- Hand of the Vizier
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			textleft = "tww-the-call-of-the-worldsoul",
			name_save = "tww-the-call-of-the-worldsoul",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82482}, -- Worldsoul: Snuffling
				{82516}, -- Worldsoul: Forging a Pact
				{82483}, -- Worldsoul: Spreading the Light
				{82453}, -- Worldsoul: Encore!
				{82489}, -- Worldsoul: The Dawnbreaker
				{82659}, -- Worldsoul: Nerub-ar Palace
				{87417}, -- Worldsoul: Dungeons
				{87419}, -- Worldsoul: Delves
				{82490}, -- Worldsoul: Priory of the Sacred Flame
				{82491}, -- Worldsoul: Ara-Kara, City of Echoes
				{82492}, -- Worldsoul: City of Threads
				{82493}, -- Worldsoul: The Dawnbreaker
				{82494}, -- Worldsoul: Ara-Kara, City of Echoes
				{82496}, -- Worldsoul: City of Threads
				{82497}, -- Worldsoul: The Stonevault
				{82498}, -- Worldsoul: Darkflame Cleft
				{82499}, -- Worldsoul: Priory of the Sacred Flame
				{82500}, -- Worldsoul: The Rookery
				{82501}, -- Worldsoul: The Dawnbreaker
				{82502}, -- Worldsoul: Ara-Kara, City of Echoes
				{82503}, -- Worldsoul: Cinderbrew Meadery
				{82504}, -- Worldsoul: City of Threads
				{82505}, -- Worldsoul: The Stonevault
				{82506}, -- Worldsoul: Darkflame Cleft
				{82507}, -- Worldsoul: Priory of the Sacred Flame
				{82508}, -- Worldsoul: The Rookery
				{82509}, -- Worldsoul: Nerub-ar Palace
				{82510}, -- Worldsoul: Nerub-ar Palace
				{82511}, -- Worldsoul: Awakening Machine
				{89514}, -- Worldsoul: Horrific Visions Revisited
				{82512}, -- Worldsoul: World Boss
				{87423}, -- Worldsoul: Undermine Explorer
				{87424}, -- Worldsoul: World Bosses
				{82488}, -- Worldsoul: Darkflame Cleft
				{82487}, -- Worldsoul: The Stonevault
				{82486}, -- Worldsoul: The Rookery
				{82485}, -- Worldsoul: Cinderbrew Meadery
				{82452}, -- Worldsoul: World Quests
				{87422}, -- Worldsoul: Undermine World Quests
				{82495}, -- Worldsoul: Cinderbrew Meadery
				{89502}, -- Worldsoul: Nightfall
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-archives",
			name_save = "tww-archives",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82679}, -- Archives: Seeking History
				{82678}, -- Archives: The First Disc
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = "tww-delves",
			name_save = "tww-delves",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82708}, -- Delves: Nerubian Menace
				{82707}, -- Delves: Earthen Defense
				{82706}, -- Delves: Worldwide Research
				{82709}, -- Delves: Percussive Archaeology
				{82710}, -- Delves: Empire-ical Exploration
				{82711}, -- Delves: Lost and Found
				{82712}, -- Delves: Trouble Up and Down Khaz Algar
				{82746}, -- Delves: Breaking Tough to Loot Stuff
			},
			forcedMaxQuest = 8,
		},
		{
			showTooltip = true,
			textleft = "tww-the-theater-trope",
			name_save = "tww-the-theater-trope",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{83240},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-spreading-the-light",
			name_save = "tww-spreading-the-light",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{76586},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-gearing-up-for-trouble",
			name_save = "tww-gearing-up-for-trouble",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{83333},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-special-assignments",
			name_save = "tww-special-assignments",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{82355}, -- Special Assignment: Cinderbee Surge (Completing)
				{81647}, -- Special Assignment: Titanic Resurgence (Completing)
				{81649}, -- Special Assignment: Titanic Resurgence (Completing)
				{81650}, -- Special Assignment: Titanic Resurgence (Completing)
				{81691}, -- Special Assignment: Shadows Below (Completing)
				{83229}, -- Special Assignment: When the Deeps Stir (Completing)
				{82852}, -- Special Assignment: Lynx Rescue (Completing)
				{82787}, -- Special Assignment: Rise of the Colossals (Completing)
				{82414}, -- Special Assignment: A Pound of Cure (Completing)
				{82531}, -- Special Assignment: Bombs from Behind (Completing)
				{85487}, -- Special Assignment: Boom! Headshot! (Completing)
				{85488}, -- Special Assignment: Security Detail (Completing)
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			textleft = "tww-rollin-down-in-the-deeps",
			name_save = "tww-rollin-down-in-the-deeps",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{82946},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-biergoth-dungeon-quest",
			name_save = "tww-biergoth-dungeon-quest",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{83432}, -- The Rookery
				{83436}, -- Cinderbrew Meadery
				{83443}, -- Darkflame Cleft
				{83457}, -- The Stonevault
				{83458}, -- Priory of the Sacred Flame
				{83459}, -- The Dawnbreaker
				{83465}, -- Ara-Kara, City of Echoes
				{83469}, -- City of Threads
				{86203}, -- Operation: Floodgate
			},
			forcedMaxQuest = 1, -- "any"
		},
		{
			showTooltip = true,
			textleft = "tww-the-key-to-success",
			name_save = "tww-the-key-to-success",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{84370},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-services-requested",
			name_save = "tww-services-requested",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{84127}, -- Blacksmithing Services Requested
				{84128}, -- Engineering Services Requested
				{84129}, -- Inscription Services Requested
				{84130}, -- Jewelcrafting Services Requested
				{84131}, -- Leatherworking Services Requested
				{84132}, -- Tailoring Services Requested
				{84133}, -- Alchemy Services Requested
				{83103}, -- Acquiring Aqirite
				{83102}, -- Bismuth is Business
				{83104}, -- Identifying Ironclaw
				{83106}, -- Null Pebble Excavation
				{83105}, -- Rush-order Requisition
				{83097}, -- Cinder and Storm
				{83100}, -- Cracking the Shell
				{82993}, -- From Shadows
				{83098}, -- Snap and Crackle
				{82992}, -- Stormcharged Goods
				{84086}, -- A Rare Necessity
				{84084}, -- Just a Pinch
				{84085}, -- The Power of Potential
				{82970}, -- A Bloom and A Blossom
				{82962}, -- A Handful of Luredrops
				{82965}, -- Light and Shadow
				{82958}, -- Little Blessings
				{82916}, -- When Fungi Bloom
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = "tww-algari-treatise",
			name_save = "tww-algari-treatise",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{83725}, -- Algari Treatise on Alchemy
				{83726}, -- Algari Treatise on Blacksmithing
				{83727}, -- Algari Treatise on Enchanting
				{83728}, -- Algari Treatise on Engineering
				{83729}, -- Algari Treatise on Herbalism
				{83730}, -- Algari Treatise on Inscription
				{83731}, -- Algari Treatise on Jewelcrafting
				{83732}, -- Algari Treatise on Leatherworking
				{83733}, -- Algari Treatise on Mining
				{83734}, -- Algari Treatise on Skinning
				{83735}, -- Algari Treatise on Tailoring
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			textleft = "tww-anniversary-restored-coffer-key",
			name_save = "tww-anniversary-restored-coffer-key",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{86202},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-siren-isle-weekly",
			name_save = "tww-siren-isle-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				-- Vrykul invasion
				{84852}, -- Legacy of the Vrykul
				{84680}, -- Rock 'n Stone Revival
				{83932}, -- Historical Documents
				{84432}, -- Longship Landing
				{84248}, -- A Ritual of Runes
				{84222}, -- Secure the Perimeter
				-- Pirate invasion
				{84851}, -- Tides of Greed
				{83753}, -- Cannon Karma
				{84299}, -- Pirate Plunder
				{84619}, -- Ooker Dooker Literature Club
				{83827}, -- Silence the Song
				{84001}, -- Cart Blanche
				-- Naga invasion
				{84850}, -- Serpent's Wrath
				{85589}, -- Ruffled Pages
				{84430}, -- Crystal Crusade
				{85051}, -- Beach Comber
				{84627}, -- Three Heads of the Deep
			},
			forcedMaxQuest = 6,
		},
		{
			showTooltip = true,
			textleft = "tww-free-chett-list",
			name_save = "tww-free-chett-list",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{87296},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-chett-list",
			name_save = "tww-chett-list",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{86915}, -- Side with a Cartel
				{86917}, -- Ship Right
				{86918}, -- Reclaimed Scrap
				{86919}, -- Side Gig
				{86920}, -- War Mode Violence
				{86923}, -- Go Fish
				{86924}, -- Gotta Catch at Least a Few
				{87302}, -- Rare Rivals
				{87303}, -- Clean the Sidestreets
				{87304}, -- Time to Vacate
				{87305}, -- Desire to D.R.I.V.E.
				{87306}, -- Kaja Cruising
				{87307}, -- Garbage Day
			},
			forcedMaxQuest = 4,
		},
		{
			showTooltip = true,
			textleft = "tww-delvers-bounty",
			name_save = "tww-delvers-bounty",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{86371},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-nightfall-scenario",
			name_save = "tww-nightfall-scenario",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{91173},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-nightfall-daily",
			name_save = "tww-nightfall-daily",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{87475}, -- Sureki Incursion: Hold the Wall
				{87477}, -- Sureki Incursion: Southern Swarm
				{87480}, -- Sureki Incursion: The Eastern Assault
				{88711}, -- Radiant Incursion: Toxins and Pheromones
				{88916}, -- Radiant Incursion: Sureki's End
				{88945}, -- Radiant Incursion: Rak-Zakaz
			},
			forcedMaxQuest = 3,
		},
		----------------------------------------------------------------
		{
			showTooltip = true,
			textleft = "tww-karesh-warrants",
			name_save = "tww-karesh-warrants",
			reset = "Weekly",
			desc = "TheWarWithin",
			quests = {
				{90122}, -- Eliminate Xy'vox the Twisted
				{90123}, -- Eliminate Hollowbane
				{90124}, -- Eliminate Shatterpulse
				{90125}, -- Eliminate Purple Peat
				{90126}, -- Eliminate Grubber
				{90127}, -- Eliminate Arcana-Monger So'zer
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = "tww-weekly-cache_S3",
			name_save = "tww-weekly-cache_S3",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			quests = {
				{91175},
				{91176},
				{91177},
				{91178},
			},
			forcedMaxQuest = 4,
		},
}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka.TheWarWithin.Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka.TheWarWithin.Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka.TheWarWithin.Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka.TheWarWithin.UniversalQuests)

E.func_TableConcat(E.OctoTables_Vibor, E.OctoTables_DataOtrisovka.TheWarWithin.Text)