local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 12
local expansionID = 3
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
		241, -- Champion's Seal
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
		45087,
		47556,
		49908,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {
		1156, --name = "Пепельный союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1156]
		1119, --name = "Сыны Ходира", side = "-", category = "Wrath of the Lich King", }, --[faction=1119]
		1106, --name = "Серебряный Авангард", side = "-", category = "Wrath of the Lich King", }, --[faction=1106]
		1098, --name = "Рыцари Черного Клинка", side = "-", category = "Wrath of the Lich King", }, --[faction=1098]
		1091, --name = "Драконий союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1091]
		1090, --name = "Кирин-Тор", side = "-", category = "Wrath of the Lich King", }, --[faction=1090]
		1073, --name = "Калу'ак", side = "-", category = "Wrath of the Lich King", }, --[faction=1073]
		----------------------------------------------------------------
		1117, --name = "Низина Шолазар", side = "-", category = "Wrath of the Lich King", }, --[faction=1117]
		1105, --name = "Оракулы", side = "-", category = "Низина Шолазар", }, --[faction=1105]
		1104, --name = "Племя Бешеного Сердца", side = "-", category = "Низина Шолазар", }, --[faction=1104]
		----------------------------------------------------------------
		1052, --name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052] -- ОРДА
		----------------------------------------------------------------
		1124, --name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
		1085, --name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
		1067, --name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
		1064, --name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
		----------------------------------------------------------------
		1037, --name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037] -- АЛЬЯНС
		----------------------------------------------------------------
		1094, --name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
		1126, --name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
		1068, --name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
		1050, --name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			showTooltip = true,
			TextLeft = E.func_questName(24748),
			name_save = "Shadowmourne",
			reset = "Once",
			desc = categoryKey,
			quests = {
				{24545},
				{24743},
				{24547},
				{24749},
				{24756},
				{24757},
				{24548},
				{24549},
				{24748},
			},
			forcedMaxQuest = 9,
		},
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
end

table.insert(E.Components, tempFunction)