local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 2
local expansionID = 12
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[categoryKey] = {}
E.OctoTables_Vibor[categoryKey] = {}
E.OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(categoryKey)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {
		3316,
		3379,
		3377,
		3376,
		3392,
		3265,
		3394,
		3262,
		3258,
		3260,
		3400,
		3261,
		3352,
		3385,
		3266,
		3257,
		3349,
		3373,
		3264,
		3263,
		3259,
		3256,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {
		2770,
		2764,
		2710,
		-- 2774, -- Slayer's Duellum (Paragon)
		2704,
		-- 2727, -- Silvermoon Court (Paragon)
		2696,
		-- 2726, -- Hara'ti (Paragon)
		-- 2725, -- The Singularity (Paragon)
		2742,
		2699,
		-- 2705, -- Amani Tribe (Paragon)
		2700,
		2744,

		2714, 2712, 2711, 2713,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
end

table.insert(E.Components, tempFunction)