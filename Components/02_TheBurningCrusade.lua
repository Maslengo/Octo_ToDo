local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_TheBurningCrusade_available = E.func_Is_TheBurningCrusade_available()
----------------------------------------------------------------
if not enable then return end
if not Is_TheBurningCrusade_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local categoryKey = 2
local expansionID = 2
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
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 23572, defS = true,},
		{id = 30183, defS = true,},
		{id = 32428, defS = true,},
		{id = 34664, defS = true,},


		{id = 24581, defS = true,}, -- HORDE
		{id = 24579, defS = true,}, -- ALLIANCE
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 1038, defS = true,}, --name = "Огри'ла", side = "-", category = "The Burning Crusade", }, --[faction=1038]
		{id = 1015, defS = true,}, --name = "Крылья Пустоты", side = "-", category = "The Burning Crusade", }, --[faction=1015]
		{id = 1012, defS = true,}, --name = "Пеплоусты-служители", side = "-", category = "The Burning Crusade", }, --[faction=1012]
		{id = 990, defS = true,}, --name = "Песчаная Чешуя", side = "-", category = "The Burning Crusade", }, --[faction=990]
		{id = 989, defS = true,}, --name = "Хранители Времени", side = "-", category = "The Burning Crusade", }, --[faction=989]
		{id = 970, defS = true,}, --name = "Спореггар", side = "-", category = "The Burning Crusade", }, --[faction=970]
		{id = 967, defS = true,}, --name = "Аметистовое Око", side = "-", category = "The Burning Crusade", }, --[faction=967]
		{id = 942, defS = true,}, --name = "Кенарийская экспедиция", side = "-", category = "The Burning Crusade", }, --[faction=942]
		{id = 933, defS = true,}, --name = "Консорциум", side = "-", category = "The Burning Crusade", }, --[faction=933]
		{id = 922, defS = true,}, --name = "Транквиллион", side = "-", category = "The Burning Crusade", }, --[faction=922]
		----------------------------------------------------------------
		{id = 936, defS = true,}, --name = "Город Шаттрат", side = "-", category = "The Burning Crusade", }, --[faction=936]
		----------------------------------------------------------------
		{id = 1077, defS = true,}, --name = "Армия Расколотого Солнца", side = "-", category = "Город Шаттрат", }, --[faction=1077]
		{id = 1031, defS = true,}, --name = "Стражи небес Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=1031]
		{id = 1011, defS = true,}, --name = "Нижний Город", side = "-", category = "Город Шаттрат", }, --[faction=1011]
		{id = 935, defS = true,}, --name = "Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=935]
		{id = 934, defS = true,}, --name = "Провидцы", side = "-", category = "Город Шаттрат", }, --[faction=934]
		{id = 932, defS = true,}, --name = "Алдоры", side = "-", category = "Город Шаттрат", }, --[faction=932]
		----------------------------------------------------------------
		{id = 947, defS = true,}, --name = "Траллмар", side = "-", category = "The Burning Crusade", }, --[faction=947] -- ОРДА
		{id = 941, defS = true,}, --name = "Маг'хары", side = "-", category = "The Burning Crusade", }, --[faction=941] -- ОРДА
		----------------------------------------------------------------
		{id = 946, defS = true,}, --name = "Оплот Чести", side = "-", category = "The Burning Crusade", }, --[faction=946] -- АЛЬЯНС
		{id = 978, defS = true,}, --name = "Куренай", side = "-", category = "The Burning Crusade", }, --[faction=978] -- АЛЬЯНС
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