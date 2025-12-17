local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Midnight_available = E.func_Is_Midnight_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Midnight_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
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
		{id = 3316, defS = false,},
		{id = 3379, defS = false,},
		{id = 3377, defS = false,},
		{id = 3376, defS = false,},
		{id = 3392, defS = false,},
		{id = 3265, defS = false,},
		{id = 3394, defS = false,},
		{id = 3400, defS = false,},
		{id = 3352, defS = false,},
		{id = 3385, defS = false,},
		{id = 3373, defS = false,},
		-- {id = 3262, defS = false,},
		-- {id = 3258, defS = false,},
		-- {id = 3260, defS = false,},
		-- {id = 3261, defS = false,},
		-- {id = 3266, defS = false,},
		-- {id = 3257, defS = false,},
		-- {id = 3264, defS = false,},
		-- {id = 3263, defS = false,},
		-- {id = 3259, defS = false,},
		-- {id = 3256, defS = false,},
		-- {id = 3349, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 2770, defS = false,},
		{id = 2710, defS = false,},
		{id = 2704, defS = false,},
		{id = 2696, defS = false,},
		{id = 2699, defS = false,},
		{id = 2744, defS = false,},
		{id = 2714, defS = false,},
		{id = 2712, defS = false,},
		{id = 2711, defS = false,},
		{id = 2713, defS = false,},
		--[[NONAME]] {id = 2764, defS = false,},
		--[[NONAME]] {id = 2742, defS = false,},
		--[[NONAME]] {id = 2700, defS = false,},
		-- {id = 2774, defS = false,}, -- Slayer's Duellum (Paragon)
		-- {id = 2727, defS = false,}, -- Silvermoon Court (Paragon)
		-- {id = 2726, defS = false,}, -- Hara'ti (Paragon)
		-- {id = 2725, defS = false,}, -- The Singularity (Paragon)
		-- {id = 2705, defS = false,}, -- Amani Tribe (Paragon)
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)