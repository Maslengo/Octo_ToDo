local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 11
local expansionID = 4
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[categoryKey] = {}
E.OctoTables_Vibor[categoryKey] = {}
E.OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(categoryKey)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {
		391, -- Tol Barad Commendation
		416, -- Mark of the World Tree
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
		52078,
		69237,
		71998,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {
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
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
end

table.insert(E.Components, tempFunction)