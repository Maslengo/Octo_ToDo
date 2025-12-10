local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 97
-- local expansionID =
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = PVP_OPTIONS -- BUG_CATEGORY14
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 2123, defS = true,},
		{id = 1792, defS = true,},
		{id = 1602, defS = true,},
		{id = 391, defS = true,},
		{id = 2797, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			TextLeft = E.func_questName(47148, false),
			name_save = "SomethingDifferent",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{47148,},
			},
			forcedMaxQuest = 1,
		},
		-- wowhead.com/ptr-2/ru/quest=90781
		-- wowhead.com/ptr-2/ru/quest=80186
		-- wowhead.com/ptr-2/ru/quest=80189
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)