local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local dropdownOrder = 2
local expansionID = 12
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
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {
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
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
	}
end

table.insert(E.Components, tempFunction)