local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Midnight_available = E.func_Is_Midnight_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Midnight_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 12
local expansionID = 12
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
		-- фиол
		{id = 3400, defS = true,},
		{id = 3379, defS = true,},
		-- синий
		{id = 3394, defS = true,},
		{id = 3392, defS = true,},
		{id = 3376, defS = true,},
		{id = 3352, defS = true,},
		{id = 3265, defS = true,},
		-- зелень
		{id = 3385, defS = true,},
		{id = 3377, defS = true,},
		{id = 3373, defS = true,},
		{id = 3319, defS = true,}, -- MIDNIGHT PREPATCH
		-- белый
		{id = 3316, defS = true,},
		-- {id = 3349, defS = true,},
		-- {id = 3266, defS = true,},
		-- {id = 3264, defS = true,},
		-- {id = 3263, defS = true,},
		-- {id = 3262, defS = true,},
		-- {id = 3261, defS = true,},
		-- {id = 3260, defS = true,},
		-- {id = 3259, defS = true,},
		-- {id = 3258, defS = true,},
		-- {id = 3257, defS = true,},
		-- {id = 3256, defS = true,},



		{id = 1166, defS = false,}, -- Timewarped Badge
		-- {id = 3139, defS = false,}, -- Plunder
		{id = 2032, defS = false,}, -- Trader's Tender
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 137642, defS = false,}, -- Mark of Honor


		-- {id = 245586, defS = false,}, -- ironwood-lumber
		-- {id = 242691, defS = false,}, -- olemba-lumber
		-- {id = 251762, defS = false,}, -- coldwind-lumber
		-- {id = 251764, defS = false,}, -- ashwood-lumber
		-- {id = 251763, defS = false,}, -- bamboo-lumber
		-- {id = 251766, defS = false,}, -- shadowmoon-lumber
		-- {id = 251767, defS = false,}, -- fel-touched-lumber
		-- {id = 251768, defS = false,}, -- darkpine-lumber
		-- {id = 251772, defS = false,}, -- arden-lumber
		-- {id = 251773, defS = false,}, -- dragonpine-lumber
		-- {id = 248012, defS = false,}, -- dornic-fir-lumber
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		{id = 1308, defS = true,}, -- March on Quel'Danas
		{id = 1307, defS = true,}, -- The Voidspire
		{id = 1314, defS = true,}, -- The Dreamrift
		-- {id = 1312, defS = true,}, -- Midnight -- WB
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 2696, defS = true,}, -- Amani Tribe (Племя Амани)
		{id = 2699, defS = true,}, -- The Singularity (Сингулярность)
		{id = 2704, defS = true,}, -- Hara'ti (Хара'ти)
		{id = 2710, defS = true,}, -- Silvermoon Court (Двор Луносвета)
		{id = 2770, defS = false,}, -- Slayer's Duellum
		{id = 2744, defS = false,}, -- Valeera Sanguinar
		{id = 2714, defS = false,}, -- Shades of the Row
		{id = 2712, defS = false,}, -- Blood Knights
		{id = 2711, defS = false,}, -- Magisters
		{id = 2713, defS = false,}, -- Farstriders
		{id = 2742, defS = false,}, -- Delves: Season 1
		-- {id = 2764, defS = false,}, -- Preyseeker's Journey
		-- {id = 2700, defS = false,}, -- DEPRECATED Fungarian Fighting Ring
		-- {id = 2774, defS = false,}, -- Slayer's Duellum (Paragon)
		-- {id = 2727, defS = false,}, -- Silvermoon Court (Paragon)
		-- {id = 2726, defS = false,}, -- Hara'ti (Paragon)
		-- {id = 2725, defS = false,}, -- The Singularity (Paragon)
		-- {id = 2705, defS = false,}, -- Amani Tribe (Paragon)
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		-- MIDNIGHT PREPATCH (27 JANUARY)
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(241)..": "..E.func_GetQuestName(90764, false) -- Twilight Highlands -- "PREPATCH: "..
		-- 	end,
		-- 	name_save = "TheCultWithin",
		-- 	defS = true,
		-- 	reset = "Regular",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		{90759, FactionOrClass = {Alliance = true,}, }, -- The Cult Within
		-- 		{90764, FactionOrClass = {Horde = true,}, }, -- The Cult Within
		-- 		{90760, FactionOrClass = {Alliance = true,}, },
		-- 		{90761, FactionOrClass = {Horde = true,}, },
		-- 		{90762, FactionOrClass = {Alliance = true,}, },
		-- 		{90763, FactionOrClass = {Horde = true,}, },
		-- 		{90765},
		-- 		{90766},
		-- 		{90767},
		-- 		{90768},
		-- 	},
		-- 	-- forcedMaxQuest = 1,
		-- },







		-- -- MIDNIGHT PREPATCH (27 JANUARY)
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(241)..": "..E.func_GetQuestName(87308, false) -- Twilight Highlands -- "PREPATCH: "..
		-- 	end,
		-- 	name_save = "TwilightsDawn",
		-- 	defS = true,
		-- 	reset = "Weekly",
		-- 	isAccount = true,
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		{87308},
		-- 	},
		-- 	-- forcedMaxQuest = 1,
		-- },

		-- -- MIDNIGHT PREPATCH (27 JANUARY)
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(241)..": "..E.func_GetQuestName(91795, false) -- Twilight Highlands -- "PREPATCH: "..
		-- 	end,
		-- 	name_save = "DisrupttheCall",
		-- 	defS = true,
		-- 	reset = "Weekly",
		-- 	isAccount = true,
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		{91795},
		-- 	},
		-- 	-- forcedMaxQuest = 1,
		-- },
		-- -- MIDNIGHT PREPATCH (27 JANUARY)
		-- {
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(241)..": ".."Rares" -- Twilight Highlands -- "PREPATCH: "..
		-- 	end,
		-- 	name_save = "THRares",
		-- 	defS = true,
		-- 	reset = "Daily", -- Daily !ПОФИКСИТЬ
		-- 	isAccount = false,
		-- 	desc = categoryKey,
		-- 	quests = {

		-- 		--
		-- 		{86695, FactionOrClass = {Horde = true,}, forcedText = {npcID = 237853,}, }, -- 49507, 93476, 91468, 93481,      (СКОРЕЙ ВСЕГО 49507)
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 237853,}, }, -- 49507, 93476, 91468, 93481,

		-- 		{91470, FactionOrClass = {Horde = true,}, forcedText = {npcID = 237997,}, }, -- корла
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 237997,}, },

		-- 		{91471, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246272,}, }, -- ПРАВИЛЬНО Horde
		-- 		{91471, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246272,}, }, -- ПРАВИЛЬНО Alliance

		-- 		{94506, FactionOrClass = {Horde = true,}, forcedText = {npcID = 253378,}, }, -- Глас Затмения 91468 94505почему было? 94506
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 253378,}, }, -- Глас Затмения 91468

		-- 		{94509, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246565,}, }, -- Густаван
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246565,}, }, -- Густаван

		-- 		{94510, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246578,}, }, -- Коготь
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246578,}, }, -- Коготь

		-- 		{94511, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246566,}, }, -- Зеркалвайз
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246566,}, }, -- Зеркалвайз

		-- 		{94512, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246558,}, }, -- Салигрум
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246558,}, }, -- Салигрум

		-- 		{94513, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246572,}, }, -- Красноглаз
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246572,}, }, -- Красноглаз

		-- 		{94514, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246844,}, }, -- Таавихан
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246844,}, }, -- Таавихан

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246462,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246462,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246343,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246343,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246460,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246460,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246471,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246471,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246840,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246840,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246478,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246478,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246577,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246577,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246549,}, },
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246549,}, },

		-- 		{nil, FactionOrClass = {Horde = true,}, forcedText = {npcID = 246559,}, }, -- 94729, 95166, 94714
		-- 		{nil, FactionOrClass = {Alliance = true,}, forcedText = {npcID = 246559,}, },

		-- 	},
		-- 	forcedMaxQuest = 19,
		-- },
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