local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local dropdownOrder = 11
local expansionID = 4
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[dropdownOrder].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].name
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {
	391, -- Tol Barad Commendation
	416, -- Mark of the World Tree
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
	52078,
	69237,
	71998,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {
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
E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
}