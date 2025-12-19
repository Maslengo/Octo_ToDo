local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_WorldofWarcraft_available = E.func_Is_WorldofWarcraft_available()
----------------------------------------------------------------
if not enable then return end
if not Is_WorldofWarcraft_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
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
		{id = 1166, defS = false,}, -- Timewarped Badge
		-- {id = 3139, defS = false,}, -- Plunder
		{id = 2032, defS = false,}, -- Trader's Tender
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 137642, defS = false,}, -- Mark of Honor
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Raids = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Dungeons = {
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
		{id = "AllItems", defS = true,},
		{id = "Professions", defS = false,},
		{id = "ItemLevel", defS = true,},
		{id = "Money", defS = true,},
		{id = "WasOnline", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)