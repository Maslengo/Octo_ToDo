local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local dropdownOrder = 97
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[7].icon
E.OctoTables_Vibor[dropdownOrder].name = "PVP"
local function localfunc()
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function localfunc2()
	return
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
tinsert(E.newOTRISOVKA, localfunc)
tinsert(E.newOTRISOVKA2, localfunc2)
