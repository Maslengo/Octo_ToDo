local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = false
if not enable then return end
----------------------------------------------------------------
local categoryKey = 2
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
		{id = 3316, defS = true,},
		{id = 3379, defS = true,},
		{id = 3377, defS = true,},
		{id = 3376, defS = true,},
		{id = 3392, defS = true,},
		{id = 3265, defS = true,},
		{id = 3394, defS = true,},
		{id = 3400, defS = true,},
		{id = 3352, defS = true,},
		{id = 3385, defS = true,},
		{id = 3373, defS = true,},


		-- {id = 3262, defS = true,},
		-- {id = 3258, defS = true,},
		-- {id = 3260, defS = true,},
		-- {id = 3261, defS = true,},
		-- {id = 3266, defS = true,},
		-- {id = 3257, defS = true,},
		-- {id = 3264, defS = true,},
		-- {id = 3263, defS = true,},
		-- {id = 3259, defS = true,},
		-- {id = 3256, defS = true,},

		-- {id = 3349, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 2770, defS = true,},
		{id = 2710, defS = true,},
		{id = 2704, defS = true,},
		{id = 2696, defS = true,},
		{id = 2699, defS = true,},
		{id = 2744, defS = true,},

		{id = 2714, defS = true,},
		{id = 2712, defS = true,},
		{id = 2711, defS = true,},
		{id = 2713, defS = true,},

		--[[NONAME]] {id = 2764, defS = false,},
		--[[NONAME]] {id = 2742, defS = false,},
		--[[NONAME]] {id = 2700, defS = false,},

		-- {id = 2774, defS = true,}, -- Slayer's Duellum (Paragon)
		-- {id = 2727, defS = true,}, -- Silvermoon Court (Paragon)
		-- {id = 2726, defS = true,}, -- Hara'ti (Paragon)
		-- {id = 2725, defS = true,}, -- The Singularity (Paragon)
		-- {id = 2705, defS = true,}, -- Amani Tribe (Paragon)
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