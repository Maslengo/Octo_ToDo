local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 15
E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[7].icon
E.OctoTables_Vibor[currentSTATE].name = "PVP"
local function localfunc()
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
		1792,
		1602,
		1191,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_questName(47148),
			name_save = "SomethingDifferent",
			reset = "Weekly",
			desc = currentSTATE,
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
	E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {
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
