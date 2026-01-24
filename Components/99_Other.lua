local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 99
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = OTHER
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 137642, defS = false,}, -- Mark of Honor
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		--     {
		--         sorted = false,
		--         TextLeft = function()
		--             return RAIDS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
		--         end,
		--         showTooltip = true,
		--         name_save = "Raid",
		--         defS = false,
		--         reset = "Weekly",
		--         desc = categoryKey, -- "HolidaysTimewalk",
		--         quests = {
		--             {47523, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC (A Burning Path Through Time)
		--             {50316, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK (A Frozen Path Through Time)
		--             {57637, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
		--             -- {82817}, -- Added in patch 11.0.5 "20th Anniversary Celebration"
		--         },
		--         forcedMaxQuest = 1,
		--     },
		--     {
		--         sorted = false,
		--         TextLeft = function()
		--             return DUNGEONS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
		--         end,
		--         showTooltip = true,
		--         name_save = "Dungeons",
		--         defS = false,
		--         reset = "Weekly",
		--         desc = categoryKey, -- "HolidaysTimewalk",
		--         quests = {
		--             {nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = "Bonus Event Holiday Quests"},},
		--             {86731, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC (An Original Path Through Time)
		--             {83363, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC (A Burning Path Through Time)
		--             {83365, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK (A Frozen Path Through Time)
		--             {83359, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
		--             {83362, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA (A Shrouded Path Through Time)
		--             {83364, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR (A Savage Path Through Time)
		--             {83360, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION (A Fel Path Through Time)
		--             {88805, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA (A Scarred Path Through Time)
		--             {92649, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL (Темный путь сквозь время)
		--             {nil},
		--             {nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Weekend Event"]},},
		--             -- NORMAL TIMEWALK
		--             {85947, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC
		--             {85948, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC
		--             {85949, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK
		--             {86556, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm
		--             {86560, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA
		--             {86563, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR
		--             {86564, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION
		--             {88808, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA
		--             {92647, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL
		--         },
		--         forcedMaxQuest = 2,
		--     },










		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return "Проходки"
		-- 	end,
		-- 	name_save = "Prohodki",
		-- 	defS = true,
		-- 	reset = "Regular",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		----------------------------------------------------------------
		-- 		{nil, forcedText = {text = E.func_FormatExpansion(6, "LEFT", true)}}, -- 6 DRAENOR
		-- 		-- Blackrock Foundry (Дренор)
		-- 		{37029}, -- Normal
		-- 		{37030}, -- Heroic
		-- 		{37031}, -- Mythic
		-- 		-- Hellfire Citadel (Дренор)
		-- 		{39499}, --  Normal
		-- 		{39500}, --  Heroic
		-- 		{39501}, --  Mythic
		-- 		{39502}, -- Normal
		-- 		{39504}, -- Heroic
		-- 		{39505}, -- Mythic
		-- 		----------------------------------------------------------------
		-- 		-- The Emerald Nightmare
		-- 		{nil},
		-- 		{nil, forcedText = {text = E.func_FormatExpansion(7, "LEFT", true)}}, -- 7 LEGION
		-- 		{44283}, --  Normal
		-- 		{44284}, --  Heroic
		-- 		{44285}, --  Mythic
		-- 		-- The Nighthold
		-- 		{45381}, --  Normal
		-- 		{45382}, --  Heroic
		-- 		{45383}, --  Mythic
		-- 		-- Tomb of Sargeras
		-- 		{47725}, --  Normal
		-- 		{47726}, --  Heroic
		-- 		{47727}, --  Mythic
		-- 		-- Antorus, the Burning Throne
		-- 		{49133}, --  Normal
		-- 		{49134}, --  Heroic
		-- 		{49135}, --  Mythic
		-- 		{49032}, --  Normal
		-- 		{49075}, --  Heroic
		-- 		{49076}, --  Mythic
		-- 		----------------------------------------------------------------
		-- 		-- Ny'alotha, the Waking City
		-- 		{nil},
		-- 		{nil, forcedText = {text = E.func_FormatExpansion(8, "LEFT", true)}}, -- 8 BFA
		-- 		{58373}, --  Normal
		-- 		{58374}, --  Heroic
		-- 		{58375}, --  Mythic
		-- 		----------------------------------------------------------------
		-- 		-- Castle Nathria
		-- 		{nil},
		-- 		{nil, forcedText = {text = E.func_FormatExpansion(9, "LEFT", true)}}, -- 9 SL
		-- 		{62054}, --  Normal
		-- 		{62055}, --  Heroic
		-- 		{62056}, --  Mythic
		-- 		-- Sanctum of Domination
		-- 		{64597}, --  Normal
		-- 		{64598}, --  Heroic
		-- 		{64599}, --  Mythic
		-- 		-- Sepulcher of the First Ones
		-- 		{65764}, --  Normal
		-- 		{65763}, --  Heroic
		-- 		{65762}, --  Mythic
		-- 		----------------------------------------------------------------
		-- 		-- Vault of the Incarnates
		-- 		{nil},
		-- 		{nil, forcedText = {text = E.func_FormatExpansion(10, "LEFT", true)}}, -- 10 DF
		-- 		{71018}, --  Normal
		-- 		{71019}, --  Heroic
		-- 		{71020}, --  Mythic
		-- 		-- Aberrus, the Shadowed Crucible
		-- 		{76083}, --  Normal
		-- 		{76085}, --  Heroic
		-- 		{76086}, --  Mythic
		-- 		{78600}, --  Normal
		-- 		{78601}, --  Heroic
		-- 		{78602}, --  Mythic
		-- 		----------------------------------------------------------------
		-- 	},
		-- 	-- forcedMaxQuest = 45,
		-- }



	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
		{id = "ListOfQuests", defS = true,},
		{id = "LFGInstance", defS = true,},
		{id = "AllItems", defS = true,},
		{id = "Professions", defS = false,},
		{id = "ItemLevel", defS = true,},
		{id = "Money", defS = true,},
		{id = "LastOnline", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
