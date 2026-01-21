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
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {

		-- фиол
		{id = 3400, defS = true,},
		{id = 3379, defS = true,},

		-- синий
		{id = 3394, defS = true,},
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
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		{id = 1308, defS = true,}, -- March on Quel'Danas
		{id = 1307, defS = true,}, -- The Voidspire
		{id = 1314, defS = true,}, -- The Dreamrift
		-- {id = 1312, defS = true,}, -- Midnight -- WB
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

		{id = 2742, defS = false,}, -- Delves: Season 1

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
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)