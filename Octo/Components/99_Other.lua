local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local dropdownOrder = 99
-- local expansionID =
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.ICON_EMPTY
E.OctoTables_Vibor[dropdownOrder].name = OTHER
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
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
		"ListOfQuests",
		"LFGInstance",
		"AllItems",
		"Professions",
		"ItemLevel",
		"Money",
		"WasOnline",
	}
end

table.insert(E.Components, tempFunction)