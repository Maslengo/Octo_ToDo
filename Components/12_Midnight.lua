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
	OctoTables_Vibor[categoryKey].color = E.OctoTable_Expansions[expansionID] and E.OctoTable_Expansions[expansionID].color or E.COLOR_BLACK
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 3028, defS = true,}, -- season 1
		-- фиол
		{id = 3400, defS = true,},
		{id = 3379, defS = true,},
		-- синий
		-- {id = 3394, defS = true,}, -- УДАЛЁН
		{id = 3392, defS = true,},
		{id = 3376, defS = true,},
		{id = 3352, defS = true,},
		{id = 3265, defS = true,},
		-- зелень
		{id = 3385, defS = true,},
		{id = 3377, defS = true,},
		{id = 3373, defS = true,},
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

		-- https://www.wowhead.com/currencies/season-1#0+1+3

		{id = 3347, defS = true,}, --  276-289
		{id = 3345, defS = true,}, --  263-276
		{id = 3343, defS = true,}, --  250-263
		{id = 3341, defS = true,}, --  237-250
		{id = 3383, defS = true,}, --  224-237

		{id = 3212, defS = false,},
		{id = 3378, defS = false,},
		{id = 3310, defS = false,},

		{id = 3319, defS = false,}, -- MIDNIGHT PREPATCH
		-- {id = 3356, defS = false,},
		-- {id = 3028, defS = false,},
		-- {id = 2803, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		-- Raid
		{id = 2913, defS = true,}, -- March on Quel'Danas
		{id = 2912, defS = true,}, -- The Voidspire
		{id = 2939, defS = true,}, -- The Dreamrift
		-- Dungeon
		-- {id = 2874, defS = true,}, -- Maisara Caverns
		-- {id = 1209, defS = true,}, -- Skyreach
		-- {id = 1753, defS = true,}, -- Seat of the Triumvirate
		-- {id = 2526, defS = true,}, -- Algeth'ar Academy
		-- {id = 2825, defS = true,}, -- Den of Nalorakk
		-- {id = 2923, defS = true,}, -- Voidscar Arena
		-- {id = 2811, defS = true,}, -- Magisters' Terrace
		-- {id = 2859, defS = true,}, -- The Blinding Vale
		-- {id = 658, defS = true,}, -- Pit of Saron
		-- {id = 2805, defS = true,}, -- Windrunner Spire
		-- {id = 2813, defS = true,}, -- Murder Row
		-- {id = 2915, defS = true,}, -- Nexus-Point Xenas
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
		{id = 2742, defS = true,}, -- Delves: Season 1
		{id = 2764, defS = true,}, -- Prey: Season 1
		-- {id = 2722, defS = true,}, -- C_DelvesUI.GetDelvesFactionForSeason() для миднайта криво работает
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
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				-- Луносвет
				-- return E.func_GetMapName(241)..": "..E.func_GetQuestName(95245, false) -- Луносвет
				return E.func_GetQuestName(95245, false) -- Луносвет
			end,
			name_save = "MidnightWorldTour",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{95245},
			},
			-- forcedMaxQuest = 1,
		},


		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				-- Луносвет
				-- return E.func_GetMapName(241)..": "..E.func_GetQuestName(93744, false) -- Луносвет
				return E.func_GetQuestName(93744, false) -- Луносвет
			end,
			name_save = "UnityAgainsttheVoid",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93744},
			},
			-- forcedMaxQuest = 1,
		},

		-- https://www.wowhead.com/quest=89507/








		-- { -- MIDNIGHT PREPATCH (27 JANUARY)
		--     sorted = false,
		--     showTooltip = true,
		--     TextLeft = function()
		--         return E.func_GetMapName(241)..": "..E.func_GetQuestName(90764, false) -- Twilight Highlands -- "PREPATCH: "..
		--     end,
		--     name_save = "TheCultWithin",
		--     defS = true,
		--     reset = "Regular",
		--     desc = categoryKey,
		--     quests = {
		--         {90759, FactionOrClass = {Alliance = true,}, }, -- The Cult Within
		--         {90764, FactionOrClass = {Horde = true,}, }, -- The Cult Within
		--         {90760, FactionOrClass = {Alliance = true,}, },
		--         {90761, FactionOrClass = {Horde = true,}, },
		--         {90762, FactionOrClass = {Alliance = true,}, },
		--         {90763, FactionOrClass = {Horde = true,}, },
		--         {90765},
		--         {90766},
		--         {90767},
		--         {90768},
		--     },
		--     -- forcedMaxQuest = 1,
		-- },
		-- { -- MIDNIGHT PREPATCH (27 JANUARY)
		--     sorted = false,
		--     showTooltip = true,
		--     TextLeft = function()
		--         return E.func_GetMapName(241)..": "..E.func_GetQuestName(87308, false) -- Twilight Highlands -- "PREPATCH: "..
		--     end,
		--     name_save = "TwilightsDawn",
		--     defS = true,
		--     reset = "Weekly",
		--     isAccount = false,
		--     desc = categoryKey,
		--     quests = {
		--         {87308},
		--     },
		--     -- forcedMaxQuest = 1,
		-- },
		-- { -- MIDNIGHT PREPATCH (27 JANUARY)
		--     sorted = false,
		--     showTooltip = true,
		--     TextLeft = function()
		--         return E.func_GetMapName(241)..": "..E.func_GetQuestName(91795, false) -- Twilight Highlands -- "PREPATCH: "..
		--     end,
		--     name_save = "DisrupttheCall",
		--     defS = true,
		--     reset = "Weekly",
		--     isAccount = false,
		--     desc = categoryKey,
		--     quests = {
		--         {91795},
		--     },
		--     -- forcedMaxQuest = 1,
		-- },
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)