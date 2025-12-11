local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 12
local expansionID = 3
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
		{id = 241, defS = true,}, -- Champion's Seal
		{id = 61, defS = false,}, -- Dalaran Jewelcrafter's Token
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 45087, defS = true,},
		-- {id = 47556, defS = true,},
		{id = 49908, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 1156, defS = true,}, --name = "Пепельный союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1156]
		{id = 1119, defS = true,}, --name = "Сыны Ходира", side = "-", category = "Wrath of the Lich King", }, --[faction=1119]
		{id = 1106, defS = true,}, --name = "Серебряный Авангард", side = "-", category = "Wrath of the Lich King", }, --[faction=1106]
		{id = 1098, defS = true,}, --name = "Рыцари Черного Клинка", side = "-", category = "Wrath of the Lich King", }, --[faction=1098]
		{id = 1091, defS = true,}, --name = "Драконий союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1091]
		{id = 1090, defS = true,}, --name = "Кирин-Тор", side = "-", category = "Wrath of the Lich King", }, --[faction=1090]
		{id = 1073, defS = true,}, --name = "Калу'ак", side = "-", category = "Wrath of the Lich King", }, --[faction=1073]
		----------------------------------------------------------------
		{id = 1117, defS = true,}, --name = "Низина Шолазар", side = "-", category = "Wrath of the Lich King", }, --[faction=1117]
		{id = 1105, defS = true,}, --name = "Оракулы", side = "-", category = "Низина Шолазар", }, --[faction=1105]
		{id = 1104, defS = true,}, --name = "Племя Бешеного Сердца", side = "-", category = "Низина Шолазар", }, --[faction=1104]
		----------------------------------------------------------------
		{id = 1052, defS = false,}, --name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052] -- ОРДА
		----------------------------------------------------------------
		{id = 1124, defS = false,}, --name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
		{id = 1085, defS = false,}, --name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
		{id = 1067, defS = false,}, --name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
		{id = 1064, defS = false,}, --name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
		----------------------------------------------------------------
		{id = 1037, defS = false,}, --name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037] -- АЛЬЯНС
		----------------------------------------------------------------
		{id = 1094, defS = false,}, --name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
		{id = 1126, defS = false,}, --name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
		{id = 1068, defS = false,}, --name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
		{id = 1050, defS = false,}, --name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_questName(24748, false)
			end,
			name_save = "Shadowmourne",
			defS = true,
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
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)