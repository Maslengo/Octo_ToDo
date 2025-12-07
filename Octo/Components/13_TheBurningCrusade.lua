local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 13
local expansionID = 2
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[categoryKey] = {}
E.OctoTables_Vibor[categoryKey] = {}
E.OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].name
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(categoryKey)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
		23572,
		30183,
		32428,
		34664,


		-- {24581, 24579},
		24581, -- HORDE
		24579, -- ALLIANCE
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {
		1038, --name = "Огри'ла", side = "-", category = "The Burning Crusade", }, --[faction=1038]
		1015, --name = "Крылья Пустоты", side = "-", category = "The Burning Crusade", }, --[faction=1015]
		1012, --name = "Пеплоусты-служители", side = "-", category = "The Burning Crusade", }, --[faction=1012]
		990, --name = "Песчаная Чешуя", side = "-", category = "The Burning Crusade", }, --[faction=990]
		989, --name = "Хранители Времени", side = "-", category = "The Burning Crusade", }, --[faction=989]
		970, --name = "Спореггар", side = "-", category = "The Burning Crusade", }, --[faction=970]
		967, --name = "Аметистовое Око", side = "-", category = "The Burning Crusade", }, --[faction=967]
		942, --name = "Кенарийская экспедиция", side = "-", category = "The Burning Crusade", }, --[faction=942]
		933, --name = "Консорциум", side = "-", category = "The Burning Crusade", }, --[faction=933]
		922, --name = "Транквиллион", side = "-", category = "The Burning Crusade", }, --[faction=922]
		----------------------------------------------------------------
		936, --name = "Город Шаттрат", side = "-", category = "The Burning Crusade", }, --[faction=936]
		----------------------------------------------------------------
		1077, --name = "Армия Расколотого Солнца", side = "-", category = "Город Шаттрат", }, --[faction=1077]
		1031, --name = "Стражи небес Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=1031]
		1011, --name = "Нижний Город", side = "-", category = "Город Шаттрат", }, --[faction=1011]
		935, --name = "Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=935]
		934, --name = "Провидцы", side = "-", category = "Город Шаттрат", }, --[faction=934]
		932, --name = "Алдоры", side = "-", category = "Город Шаттрат", }, --[faction=932]
		----------------------------------------------------------------
		947, --name = "Траллмар", side = "-", category = "The Burning Crusade", }, --[faction=947] -- ОРДА
		941, --name = "Маг'хары", side = "-", category = "The Burning Crusade", }, --[faction=941] -- ОРДА
		----------------------------------------------------------------
		946, --name = "Оплот Чести", side = "-", category = "The Burning Crusade", }, --[faction=946] -- АЛЬЯНС
		978, --name = "Куренай", side = "-", category = "The Burning Crusade", }, --[faction=978] -- АЛЬЯНС
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
end

table.insert(E.Components, tempFunction)