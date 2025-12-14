local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 4
local expansionID = 4
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

		{id = 361, defS = true,}, --
		{id = 416, defS = true,}, -- Mark of the World Tree
		{id = 614, defS = true,}, --
		{id = 615, defS = true,}, --
		-- {id = 391, defS = true,}, -- Tol Barad Commendation
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 52078, defS = true,},
		-- {id = 69237, defS = true,},
		-- {id = 71998, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 1204, defS = false,}, --name = "Хиджальские мстители", side = "-", category = "Cataclysm", }, --[faction=1204]
		{id = 1173, defS = false,}, --name = "Рамкахены", side = "-", category = "Cataclysm", }, --[faction=1173]
		{id = 1171, defS = false,}, --name = "Теразан", side = "-", category = "Cataclysm", }, --[faction=1171]
		{id = 1158, defS = false,}, --name = "Стражи Хиджала", side = "-", category = "Cataclysm", }, --[faction=1158]
		{id = 1135, defS = false,}, --name = "Служители Земли", side = "-", category = "Cataclysm", }, --[faction=1135]
		----------------------------------------------------------------
		{id = 1178, defS = false,}, --name = "Батальон Адского Крика", side = "Horde", category = "Cataclysm", }, --[faction=1178]
		{id = 1172, defS = false,}, --name = "Клан Драконьей Пасти", side = "Horde", category = "Cataclysm", }, --[faction=1172]
		----------------------------------------------------------------
		{id = 1177, defS = false,}, --name = "Защитники Тол Барада", side = "Alliance", category = "Cataclysm", }, --[faction=1177]
		{id = 1174, defS = false,}, --name = "Клан Громового Молота", side = "Alliance", category = "Cataclysm", }, --[faction=1174]
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