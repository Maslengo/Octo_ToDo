local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 99
-- local expansionID =
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
		{id = 3139, defS = false,}, -- Награбленное
		{id = 2032, defS = false,}, -- Торг Жетон
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
		{id = "ListOfQuests", defS = false,},
		{id = "LFGInstance", defS = true,},
		{id = "AllItems", defS = false,},
		{id = "Professions", defS = false,},
		{id = "ItemLevel", defS = true,},
		{id = "Money", defS = true,},
		{id = "WasOnline", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)