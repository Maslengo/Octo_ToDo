local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 15

E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[7].icon
E.OctoTables_Vibor[currentSTATE].name = "PVP"
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
----------------------------------------------------------------
function E.func_Otrisovka_15_PVP()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Universal(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Otrisovka_REPUTATION(OctoTable_Otrisovka_textCENT, currentSTATE)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end