local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 3
local expansionID = 11
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

		{id = 1191, defS = true,},

		-- https://warcraft.wiki.gg/wiki/Catalyst
		-- The War Within
		-- (Season 4)
		{id = 3269, defS = true,}, -- (Season 3)
		{id = 3116, defS = false,}, -- Essence of Kaja'mite (Season 2)
		{id = 2813, defS = false,}, -- Harmonized Silk (Season 1)


		{id = 2815, defS = true,}, -- Resonance Crystals
		{id = 3226, defS = true,}, -- Market Research
		{id = 3056, defS = true,}, -- Kej
		{id = 3218, defS = true,}, -- Empty Kaja'Cola Can
		{id = 3303, defS = true,}, --
		{id = 3090, defS = true,}, -- Flame-Blessed Iron
		{id = 3055, defS = true,}, --
		{id = 3089, defS = true,}, --
		{id = 3149, defS = true,}, -- Displaced Corrupted Mementos
		{id = 3220, defS = true,}, --
		{id = 3093, defS = true,}, --
		{id = 3223, defS = true,}, --
		-- {id = 2839, defS = true,}, -- [DNT] Awakening Currency
		{id = 3216, defS = true,}, --



		-- {id = 3056, defS = true,},
		-- season 3
		{id = 3356, defS = false,}, -- Untainted Mana-Crystals
		{id = 3290, defS = false,}, -- Gilded Ethereal Crest
		{id = 3288, defS = false,}, -- Runed Ethereal Crest
		{id = 3286, defS = false,}, -- Carved Ethereal Crest
		{id = 3284, defS = false,}, -- Weathered Ethereal Crest
		{id = 3141, defS = false,}, -- Starlight Spark Dust
		{id = 3028, defS = false,}, -- Restored Coffer Key
		{id = 3008, defS = false,}, -- Valorstones
		{id = 2803, defS = false,}, -- Undercoin

		{id = 3110, defS = false,}, -- Gilded Undermine Crest
		{id = 3109, defS = false,}, -- Runed Undermine Crest
		{id = 3108, defS = false,}, -- Carved Undermine Crest
		{id = 3107, defS = false,}, -- Weathered Undermine Crest

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 180653, defS = true,}, -- НОВЫЙ КЛЮЧ, НО ПЕРЕДЕЛАЛ В CurrentKey
		-- {id = 138019, defS = true,}, -- СТАРЫЕ КЛЮЧИ
		-- {id = 158923, defS = true,}, -- СТАРЫЕ КЛЮЧИ
		-- {id = 151086, defS = true,}, -- СТАРЫЕ КЛЮЧИ
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
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
		{id = 2653, defS = true,}, --name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
		{id = 2640, defS = true,}, --name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
		{id = 2600, defS = true,}, --name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
		{id = 2594, defS = true,}, --name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
		{id = 2590, defS = true,}, --name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
		{id = 2570, defS = true,}, --name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
		----------------------------------------------------------------
		{id = 2607, defS = true,}, --name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
		{id = 2605, defS = true,}, --name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
		{id = 2601, defS = true,}, --name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
		----------------------------------------------------------------
		{id = 2685, defS = true,}, --name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
		{id = 2677, defS = true,}, --name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
		{id = 2675, defS = true,}, --name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
		{id = 2673, defS = true,}, --name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
		{id = 2671, defS = true,}, --name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
		{id = 2669, defS = true,}, --name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]
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
			TextLeft = E.func_mapName(2371)..": ".."Rares",
			name_save = "Rares2371",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{90587, forcedText = {npcID = 232098}, addText = {mapID = 2472},},
				{90696, forcedText = {npcID = 241956}, addText = {mapID = 2472},},
				{90698, forcedText = {npcID = 238540}, addText = {mapID = 2472},},
				{nil, forcedText = {npcID = 235104}, addText = {mapID = 2472},},
				{86464, forcedText = {npcID = 235087}, addText = {mapID = 2472, mount = 2602},}, -- Devoured Energy-Pod -- 91435, _, 91311, 91289
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2255)..": ".."Rares", -- Azj-Kahet
			name_save = "Rares2255",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2215)..": ".."Rares", -- Hallowfall
			name_save = "Rares2215",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2248)..": ".."Rares", -- Isle of Dorn
			name_save = "Rares2248",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2214)..": ".."Rares", -- Ringing Deeps
			name_save = "Rares2214",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2369)..": ".."Rares", -- Siren Isle
			name_save = "Rares2369",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2346)..": ".."Rares", -- Undermine
			name_save = "Rares2346",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2248)..": ".."Treasures", -- isle_of_dorn
			name_save = "Treasures2248",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2369)..": ".."Treasures",
			name_save = "Treasures2369",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2346)..": ".."Treasures", -- undermine
			name_save = "Treasures2346",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2214)..": ".."Treasures", -- ringing_deeps (2214)
			name_save = "Treasures2214",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2255)..": ".."Treasures", -- azj_kahet (2255)
			name_save = "Treasures2255",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2215)..": ".."Treasures", -- hallowfall (2215)
			name_save = "Treasures2215",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_mapName(2346)..": ".."Treasure", -- undermine (2346)
			name_save = "Treasure2346",
			defS = true,
			reset = "Once", -- "Daily",
			desc = categoryKey,
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
		{
			showTooltip = true,
			TextLeft = E.func_questName(84370, false),
			name_save = "TheKeytoSuccess",
			defS = true,
			reset = "Daily", -- "Once", ???
			desc = categoryKey,
			quests = {
				{84370},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(82449, false),
			name_save = "TheCalloftheWorldsoul",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "Archives",
			name_save = "Archives",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{82678},
				{82679},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "Delves",
			name_save = "Delves",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.Timers.TWW_BeledarCycle()..E.func_questName(83240, false),
			name_save = "TheTheaterTroupe",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83240},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(76586, false),
			name_save = "SpreadingtheLight",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{76586},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = E.func_questName(83333, false),
			name_save = "GearingUpforTrouble",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83333},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "SpecialAssignments",
			name_save = "SpecialAssignments",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = E.func_questName(82946, false),
			name_save = "RollinDownintheDeeps",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{82946},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "BiergothDungeonQuest",
			name_save = "BiergothDungeonQuest",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "TWWProfessionWeeklies",
			name_save = "TWWProfessionWeeklies",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "TWWAlgariTreatise",
			name_save = "TWWAlgariTreatise",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "AnniversaryRestoredCofferKey",
			name_save = "AnniversaryRestoredCofferKey",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{86202},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "SirenIsleWeekly",
			name_save = "SirenIsleWeekly",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "MajorKeyflames",
			name_save = "MajorKeyflames",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "MinorKeyflames",
			name_save = "MinorKeyflames",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = L["Delver's Call"],
			name_save = "DelversCall",
			defS = true,
			reset = "Once",
			desc = categoryKey,
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
			TextLeft = "tww-weekly-cache",
			name_save = "tww-weekly-cache",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-lesser-keyflame",
			name_save = "tww-lesser-keyflame",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-brawl-weekly",
			name_save = "tww-brawl-weekly",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{47148},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-pvp-weekly",
			name_save = "tww-pvp-weekly",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-pvp-world",
			name_save = "tww-pvp-world",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-the-severed-threads",
			name_save = "tww-the-severed-threads",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{80670}, -- Eyes of the Weaver
				{80671}, -- Blade of the General
				{80672}, -- Hand of the Vizier
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			TextLeft = "tww-the-call-of-the-worldsoul",
			name_save = "tww-the-call-of-the-worldsoul",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-archives",
			name_save = "tww-archives",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82679}, -- Archives: Seeking History
				{82678}, -- Archives: The First Disc
			},
			forcedMaxQuest = 2,
		},
		{
			showTooltip = true,
			TextLeft = "tww-delves",
			name_save = "tww-delves",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-the-theater-trope",
			name_save = "tww-the-theater-trope",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{83240},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-spreading-the-light",
			name_save = "tww-spreading-the-light",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{76586},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-gearing-up-for-trouble",
			name_save = "tww-gearing-up-for-trouble",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{83333},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-special-assignments",
			name_save = "tww-special-assignments",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-rollin-down-in-the-deeps",
			name_save = "tww-rollin-down-in-the-deeps",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{82946},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-biergoth-dungeon-quest",
			name_save = "tww-biergoth-dungeon-quest",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-the-key-to-success",
			name_save = "tww-the-key-to-success",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{84370},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-services-requested",
			name_save = "tww-services-requested",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-algari-treatise",
			name_save = "tww-algari-treatise",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-anniversary-restored-coffer-key",
			name_save = "tww-anniversary-restored-coffer-key",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{86202},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-siren-isle-weekly",
			name_save = "tww-siren-isle-weekly",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-free-chett-list",
			name_save = "tww-free-chett-list",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{87296},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-chett-list",
			name_save = "tww-chett-list",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-delvers-bounty",
			name_save = "tww-delvers-bounty",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{86371},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-nightfall-scenario",
			name_save = "tww-nightfall-scenario",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
			quests = {
				{91173},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = "tww-nightfall-daily",
			name_save = "tww-nightfall-daily",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
			TextLeft = "tww-karesh-warrants",
			name_save = "tww-karesh-warrants",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = "tww-weekly-cache_S3",
			name_save = "tww-weekly-cache_S3",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- STORYLINE
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
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
		{id = "CurrentKey", defS = true,},
		{id = "GreatVault", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)