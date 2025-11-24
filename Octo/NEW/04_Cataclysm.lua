local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Cataclysm = {}
E.OctoTables_DataOtrisovka.Cataclysm.Text = {E.OctoTable_Expansions[4].color..E.OctoTable_Expansions[4].name.."|r"}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Cataclysm.Currencies = {

			391, -- Tol Barad Commendation
			416, -- Mark of the World Tree
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Cataclysm.Items = {

			52078,
			69237,
			71998,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka.Cataclysm.Reputations = {
		-- header = {icon = E.OctoTable_Expansions[4].icon, name = E.OctoTable_Expansions[4].color..E.OctoTable_Expansions[4].name.."|r",},
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
E.OctoTables_DataOtrisovka.Cataclysm.UniversalQuests = {

}
----------------------------------------------------------------

E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka.Cataclysm.Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka.Cataclysm.Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka.Cataclysm.Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka.Cataclysm.UniversalQuests)

E.func_TableConcat(E.OctoTables_Vibor, E.OctoTables_DataOtrisovka.Cataclysm.Text)