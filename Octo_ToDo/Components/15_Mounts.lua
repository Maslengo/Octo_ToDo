local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = false
if not enable then return end
----------------------------------------------------------------
local categoryKey = 15
local expansionID = 1
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = MOUNTS
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {

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

	}
	----------------------------------------------------------------
	if E.ebanieMounti then
		E.ebanieMounti(categoryKey)
	end
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)