local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 11
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
		-- https://warcraft.wiki.gg/wiki/Catalyst
		-- The War Within
		-- (Season 4)
		{id = 3278, defS = true,}, -- Астальные нити
		{id = 3269, defS = true,}, -- (Season 3)
		{id = 3028, defS = true,}, -- Restored Coffer Key
		{id = 3310, defS = false,}, -- SEASON 2
		{id = 2815, defS = true,}, -- Resonance Crystals
		{id = 3218, defS = false,}, -- Empty Kaja'Cola Can
		{id = 3090, defS = true,}, -- Flame-Blessed Iron
		{id = 3056, defS = true,}, -- Kej
		{id = 2803, defS = true,}, -- Undercoin

		{id = 3290, defS = true,}, -- Gilded Ethereal Crest -- 3-й сезон
		{id = 3288, defS = true,}, -- Runed Ethereal Crest -- 3-й сезон
		{id = 3286, defS = false,}, -- Carved Ethereal Crest -- 3-й сезон
		{id = 3284, defS = false,}, -- Weathered Ethereal Crest -- 3-й сезон
		{id = 3008, defS = false,}, -- Valorstones



		{id = 3116, defS = false,}, -- Essence of Kaja'mite (Season 2)
		{id = 2813, defS = false,}, -- Harmonized Silk (Season 1)
		{id = 1191, defS = false,},
		{id = 3226, defS = false,}, -- Market Research
		{id = 3303, defS = false,}, --
		{id = 3055, defS = false,}, --
		{id = 3089, defS = false,}, --
		{id = 3149, defS = false,}, -- Displaced Corrupted Mementos
		{id = 3220, defS = false,}, --
		{id = 3093, defS = false,}, --
		{id = 3223, defS = false,}, --
		-- {id = 2839, defS = false,}, -- [DNT] Awakening Currency
		{id = 3216, defS = false,}, --
		-- season 3
		-- {id = 3291, defS = false,}, -- Hidden
		-- {id = 3289, defS = false,}, -- Hidden
		-- {id = 3287, defS = false,}, -- Hidden
		-- {id = 3285, defS = false,}, -- Hidden
		{id = 3356, defS = false,}, -- Untainted Mana-Crystals
		{id = 3141, defS = false,}, -- Starlight Spark Dust
		-- {id = 3110, defS = false,}, -- Gilded Undermine Crest
		-- {id = 3109, defS = false,}, -- Runed Undermine Crest
		-- {id = 3108, defS = false,}, -- Carved Undermine Crest
		-- {id = 3107, defS = false,}, -- Weathered Undermine Crest
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 180653, defS = true,}, -- НОВЫЙ КЛЮЧ, НО ПЕРЕДЕЛАЛ В CurrentKey
		-- {id = 138019, defS = true,}, -- СТАРЫЕ КЛЮЧИ
		-- {id = 158923, defS = true,}, -- СТАРЫЕ КЛЮЧИ
		-- {id = 151086, defS = true,}, -- СТАРЫЕ КЛЮЧИ
		{id = 246771, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
		-- ["The War Within"] = {
		-- { id = 2653,},
		-- { id = 2570,},
		-- { id = 2590,},
		-- { id = 2594,},
		-- { id = 2600,},
		-- { id = 2640,},
		-- { id = 2667,},
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
		{id = 2736, defS = true,},
		{id = 2658, defS = true,},
		{id = 2688, defS = true,},



		{id = 2653, defS = false,}, --name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
		{id = 2640, defS = false,}, --name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
		{id = 2600, defS = false,}, --name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
		{id = 2594, defS = false,}, --name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
		{id = 2590, defS = false,}, --name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
		{id = 2570, defS = false,}, --name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
		----------------------------------------------------------------
		{id = 2607, defS = false,}, --name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
		{id = 2605, defS = false,}, --name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
		{id = 2601, defS = false,}, --name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
		----------------------------------------------------------------
		{id = 2685, defS = false,}, --name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
		{id = 2677, defS = false,}, --name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
		{id = 2675, defS = false,}, --name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
		{id = 2673, defS = false,}, --name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
		{id = 2671, defS = false,}, --name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
		{id = 2669, defS = false,}, --name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]

		{id = 2663, defS = false,}, -- Мира
		{id = 2665, defS = false,}, -- Лиллистраза
		{id = 2666, defS = false,}, -- Байки за чашкой
		{id = 2664, defS = false,}, -- Флинн Фэйрвинд
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
			TextLeft = function()
				return E.func_GetMapName(2371)..": ".."Rares"
			end,
			name_save = "Rares2371",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2255)..": ".."Rares" -- Azj-Kahet
			end,
			name_save = "Rares2255",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2215)..": ".."Rares" -- Hallowfall
			end,
			name_save = "Rares2215",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2248)..": ".."Rares" -- Isle of Dorn
			end,
			name_save = "Rares2248",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2214)..": ".."Rares" -- Ringing Deeps
			end,
			name_save = "Rares2214",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2369)..": ".."Rares" -- Siren Isle
			end,
			name_save = "Rares2369",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2346)..": ".."Rares" -- Undermine
			end,
			name_save = "Rares2346",
			defS = false,
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
			TextLeft = function()
				return E.func_GetMapName(2248)..": ".."Treasures" -- isle_of_dorn
			end,
			name_save = "Treasures2248",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{82715, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{82714, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{82287, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{82325, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{83243, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{83246, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{83245, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{83244, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{82326, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{82246, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{83242, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
				{83094, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 12"},},
				{83840, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 13"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2369)..": ".."Treasures"
			end,
			name_save = "Treasures2369",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{87446, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{86764, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{86767, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{86766, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{86732, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{85716, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{84547, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{84839, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{86765, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{84529, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{84527, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2346)..": ".."Treasures" -- undermine
			end,
			name_save = "Treasures2346",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{85683, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{85698, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{85814, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{85426, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{85422, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{85424, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{85425, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{85492, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{85495, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{85494, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{85496, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
				{86487, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 12"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2214)..": ".."Treasures" -- ringing_deeps
			end,
			name_save = "Treasures2214",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{82230, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{82239, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{82820, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{82464, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{82819, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{80485, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{82235, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{82818, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{83030, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{79308, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2255)..": ".."Treasures" -- azj_kahet
			end,
			name_save = "Treasures2255",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{82520, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{82718, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{82722, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{82720, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{82529, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{82721, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{82719, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{82727, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{82527, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{82525, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2215)..": ".."Treasures" -- hallowfall
			end,
			name_save = "Treasures2215",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{83298, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{83263, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{83284, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{81468, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{81971, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{81978, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{81972, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{82005, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{83273, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{79275, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{80687, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
				{81518, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 12"},},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2346)..": ".."Treasures" -- undermine
			end,
			name_save = "Treasure2346",
			defS = false,
			reset = "Once", -- "Daily",
			desc = categoryKey,
			quests = {
				{85683, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{85698, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{85814, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{85426, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{85422, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{85424, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{85425, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{85492, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{85495, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{85494, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{85496, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
				{86487, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 12"},},
				{86630, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 13"},},
				{85781, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 14"},},
				{85785, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 15"},},
				{86773, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 16"},},
				{85787, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 17"},},
				{86772, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 18"},},
				{85786, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 19"},},
				{86771, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 20"},},
				{85788, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 21"},},
				{86774, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 22"},},
				{87007, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 23"},},
				{85072, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 24"},},
				{85116, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 25"},},
				{85117, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 26"},},
				{85114, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 27"},},
				{85115, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 28"},},
			},
		},
		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = L["Delver's Call"],
			name_save = "DelversCall",
			defS = false,
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
		----------------------------------------------------------------




		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(84776, false) -- (Зов вылазок) Пройдите 5 вылазок в Каз Алгаре.
			end,
			name_save = "A Call to Delves",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{84776},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(83366, false) -- (Мир ждет) Выполните 10 локальных заданий в Каз Алгаре.
			end,
			name_save = "The World Awaits",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83366},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(83347, false) -- (Посланник войны) Пройдите 4 подземелья в эпохальном режиме.
			end,
			name_save = "Emissary of War",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83347},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(83345, false) -- (Призыв к бою) Одержите победу на 4 полях боя.
			end,
			name_save = "A Call to Battle",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83345},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["TWW Weekly Cache"]
			end,
			name_save = "TWW Weekly Cache",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{84736, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["First Cache"]},},
				{84737, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Second Cache"]},},
				{84738, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Third Cache"]},},
				{84739, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Fourth Cache"]},},
			},
			-- forcedMaxQuest = 1, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["TWW Weekly Cache"].." S3"
			end,
			name_save = "TWW Weekly Cache S3",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{91175, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["First Cache"]},},
				{91176, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Second Cache"]},},
				{91177, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Third Cache"]},},
				{91178, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Fourth Cache"]},},
			},
			-- forcedMaxQuest = 1, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "Delver's Bounty" -- E.func_GetQuestName(86371, false)
			end,
			name_save = "Delver's Bounty",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{86371},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "Lesser Keyflame" -- MinorKeyflames
			end,
			name_save = "Lesser Keyflame",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- SAVEDINSTANCE
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
				-- {nil},
				-- -- МОЁ
				-- {81632},
				-- -- 81574,
				-- -- 80562,
				-- {80004},
				-- -- 79346,
				-- -- 79216,
				-- {79173},
				-- -- 79158,
				-- {78972},
				-- -- 78933,
				-- -- 78915,
				-- {78656},
				-- {76997},
				-- -- 76733,
				-- {76600},
				-- {76394},
				-- -- 76169,
			},
			forcedMaxQuest = 8,
		},
		{
			showTooltip = true,
			TextLeft = "Major Keyflames",
			name_save = "Major Keyflames",
			defS = false,
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
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(47148, false)
			end,
			name_save = "Brawl Weekly",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{47148},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "PvP Weekly"
			end,
			name_save = "PvP Weekly",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{80184}, -- Preserving in Battle
				{80185}, -- Preserving Solo
				{80186}, -- Preserving in War
				{80187}, -- Preserving in Skirmishes
				{80188}, -- Preserving in Arenas
				{80189}, -- Preserving Teamwork
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "World PvP Weekly"
			end,
			name_save = "World PvP Weekly",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{81793}, -- Sparks of War: Isle of Dorn
				{81794}, -- Sparks of War: The Ringing Deeps
				{81795}, -- Sparks of War: Hallowfall
				{81796}, -- Sparks of War: Azj-Kahet
				{86853}, -- Sparks of War: Undermine
				{90781}, -- Sparks of War: K'aresh?
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "The Severed Threads"
			end,
			name_save = "The Severed Threads",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{80670}, -- Eyes of the Weaver
				{80671}, -- Blade of the General
				{80672}, -- Hand of the Vizier
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "The Call of the Worldsoul"
			end,
			name_save = "The Call of the Worldsoul",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82482}, -- Worldsoul: Snuffling
				{82516}, -- Worldsoul: Forging a Pact
				{82483}, -- Worldsoul: Spreading the Light
				{82453}, -- Worldsoul: Encore!
				{82489}, -- Worldsoul: The Dawnbreaker
				{82659}, -- Worldsoul: Nerub-ar Palace
				{87417}, -- Worldsoul: Dungeons
				{91052}, -- Worldsoul: Overcharged Delves
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
				{89514}, -- Worldsoul: Horrific Visions Revisited
				{87424}, -- Worldsoul: World Bosses
				{82511}, -- Worldsoul: Awakening Machine
				{82512}, -- Worldsoul: World Boss
				{89492}, -- Worldsoul: Dastardly Duos in the Dome!
				{87423}, -- Worldsoul: Undermine Explorer
				{82488}, -- Worldsoul: Darkflame Cleft
				{91855}, -- Worldsoul: K'aresh World Quests
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
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "Archives"
			end,
			name_save = "Archives",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				{82679}, -- Archives: Seeking History
				{82678}, -- Archives: The First Disc
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(82706, false) -- DELVES_LABEL
			end,
			name_save = "Delves",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				-- {82708}, -- Delves: Nerubian Menace (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				-- {82707}, -- Delves: Earthen Defense (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				{82706}, -- Delves: Worldwide Research
				-- {82709}, -- Delves: Percussive Archaeology (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				-- {82710}, -- Delves: Empire-ical Exploration (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				-- {82711}, -- Delves: Lost and Found (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				-- {82712}, -- Delves: Trouble Up and Down Khaz Algar (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
				-- {82746}, -- Delves: Breaking Tough to Loot Stuff (This quest was marked obsolete by Blizzard and cannot be obtained or completed.)
			},
			forcedMaxQuest = 1, -- 8? НАДО УТОЧНИТЬ
		},



		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.Timers.TWW_BeledarCycle()..E.func_GetQuestName(83240, false)
			end,
			name_save = "The Theater Troupe",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83240},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(76586, false)
			end,
			name_save = "Spreading the Light",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{76586},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(83333, false)
			end,
			name_save = "Gearing Up for Trouble",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83333},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "Special Assignments"
			end,
			name_save = "Special Assignments",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
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
				{89294}, -- Special Assignment: Aligned Views (Completing)
				{89293}, -- Special Assignment: Overshadowed (Completing)
			},
			forcedMaxQuest = 4, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(82946, false)
			end,
			name_save = "Rollin' Down in the Deeps",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{82946},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "Biergoth Dungeon Quest"
			end,
			name_save = "Biergoth Dungeon Quest",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
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
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(84370, false)
			end,
			name_save = "The Key to Success",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{84370},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "TWW Profession Weeklies"
			end,
			name_save = "TWW Profession Weeklies",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
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
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "TWW Algari Treatise"
			end,
			name_save = "TWW Algari Treatise",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{83725}, -- = L["Algari Treatise on Alchemy"],
				{83726}, -- = L["Algari Treatise on Blacksmithing"],
				{83727}, -- = L["Algari Treatise on Enchanting"],
				{83728}, -- = L["Algari Treatise on Engineering"],
				{83729}, -- = L["Algari Treatise on Herbalism"],
				{83730}, -- = L["Algari Treatise on Inscription"],
				{83731}, -- = L["Algari Treatise on Jewelcrafting"],
				{83732}, -- = L["Algari Treatise on Leatherworking"],
				{83733}, -- = L["Algari Treatise on Mining"],
				{83734}, -- = L["Algari Treatise on Skinning"],
				{83735}, -- = L["Algari Treatise on Tailoring"],
			},
			forcedMaxQuest = 2, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "Anniversary Restored Coffer Key" --E.func_GetQuestName(86202, false)
			end,
			name_save = "Anniversary Restored Coffer Key",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{86202},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "Siren Isle Weekly"
			end,
			name_save = "Siren Isle Weekly",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{nil, forcedText = {text = E.COLOR_SKYBLUE..E.TEXT_SPACE.."Vrykul invasion|r"},},
				{84852}, -- Legacy of the Vrykul
				{84680}, -- Rock 'n Stone Revival
				{83932}, -- Historical Documents
				{84432}, -- Longship Landing
				{84248}, -- A Ritual of Runes
				{84222}, -- Secure the Perimeter
				{nil},
				{nil, forcedText = {text = E.COLOR_STEELBLUE..E.TEXT_SPACE.."Pirate invasion|r"},},
				{84851}, -- Tides of Greed
				{83753}, -- Cannon Karma
				{84299}, -- Pirate Plunder
				{84619}, -- Ooker Dooker Literature Club
				{83827}, -- Silence the Song
				{84001}, -- Cart Blanche
				{nil},
				{nil, forcedText = {text = E.COLOR_SLATEGRAY..E.TEXT_SPACE.."Naga invasion|r"},},
				{84850}, -- Serpent's Wrath
				{85589}, -- Ruffled Pages
				{84430}, -- Crystal Crusade
				{85051}, -- Beach Comber
				{84627}, -- Three Heads of the Deep
			},
			forcedMaxQuest = 6, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "Free C.H.E.T.T. List"
			end,
			name_save = "Free C.H.E.T.T. List",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{87296},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "C.H.E.T.T. List"
			end,
			name_save = "C.H.E.T.T. List",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{86915}, -- = L["Side with a Cartel"],
				{86917}, -- = L["Ship Right"],
				{86918}, -- = L["Reclaimed Scrap"],
				{86919}, -- = L["Side Gig"],
				{86920}, -- = L["War Mode Violence"],
				{86923}, -- = L["Go Fish"],
				{86924}, -- = L["Gotta Catch at Least a Few"],
				{87302}, -- = L["Rare Rivals"],
				{87303}, -- = L["Clean the Sidestreets"],
				{87304}, -- = L["Time to Vacate"],
				{87305}, -- = L["Desire to D.R.I.V.E."],
				{87306}, -- = L["Kaja Cruising"],
				{87307}, -- = L["Garbage Day"],
			},
			forcedMaxQuest = 4, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(86775, false)
			end,
			name_save = "Urge to Surge",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{86775},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(85869, false)
			end,
			name_save = "Many Jobs, Handle It!",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{85869},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(85879, false)
			end,
			name_save = "Reduce, Reuse, Resell",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{85879},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(91173, false) -- tww-nightfall-scenario
			end,
			name_save = "The Flame Burns Eternal",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{91173},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return "Nightfall Daily"
			end,
			name_save = "Nightfall Daily",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{87475}, -- Sureki Incursion: Hold the Wall
				{87477}, -- Sureki Incursion: Southern Swarm
				{87480}, -- Sureki Incursion: The Eastern Assault
				{nil},
				{88711}, -- Radiant Incursion: Toxins and Pheromones
				{88916}, -- Radiant Incursion: Sureki's End
				{88945}, -- Radiant Incursion: Rak-Zakaz
			},
			forcedMaxQuest = 3, -- НАДО УТОЧНИТЬ
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(91093, false)
			end,
			name_save = "More Than Just a Phase",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{91093},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(85460, false)
			end,
			name_save = "Ecological Succession",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{85460},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "K'aresh Warrants"
			end,
			name_save = "K'aresh Warrants",
			defS = false,
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