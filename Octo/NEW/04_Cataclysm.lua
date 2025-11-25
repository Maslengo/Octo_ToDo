local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 4
E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[currentSTATE].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
			391, -- Tol Barad Commendation
			416, -- Mark of the World Tree
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {
			52078,
			69237,
			71998,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[currentSTATE].icon, name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name.."|r",},
		-- ["Cataclysm"] = {
	1204, --name = "Хиджальские мстители", side = "-", category = "Cataclysm", }, --[faction=1204]
	1173, --name = "Рамкахены", side = "-", category = "Cataclysm", }, --[faction=1173]
	1171, --name = "Теразан", side = "-", category = "Cataclysm", }, --[faction=1171]
	1158, --name = "Стражи Хиджала", side = "-", category = "Cataclysm", }, --[faction=1158]
	1135, --name = "Служители Земли", side = "-", category = "Cataclysm", }, --[faction=1135]
		----------------------------------------------------------------
	1178, --name = "Батальон Адского Крика", side = "Horde", category = "Cataclysm", }, --[faction=1178]
	1172, --name = "Клан Драконьей Пасти", side = "Horde", category = "Cataclysm", }, --[faction=1172]
		----------------------------------------------------------------
	1177, --name = "Защитники Тол Барада", side = "Alliance", category = "Cataclysm", }, --[faction=1177]
	1174, --name = "Клан Громового Молота", side = "Alliance", category = "Cataclysm", }, --[faction=1174]
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka[currentSTATE].Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka[currentSTATE].Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka[currentSTATE].Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests)