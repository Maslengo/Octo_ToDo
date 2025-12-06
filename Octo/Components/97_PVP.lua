local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local dropdownOrder = 97
-- local expansionID =
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.ICON_EMPTY
E.OctoTables_Vibor[dropdownOrder].name = PVP_OPTIONS -- BUG_CATEGORY14
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(dropdownOrder)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {
		1792,
		1602,
		1191,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_questName(47148),
			name_save = "SomethingDifferent",
			reset = "Weekly",
			desc = dropdownOrder,
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
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
	}
end

table.insert(E.Components, tempFunction)