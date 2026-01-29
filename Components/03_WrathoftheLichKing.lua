local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_WrathoftheLichKing_available = E.func_Is_WrathoftheLichKing_available()
----------------------------------------------------------------
if not enable then return end
if not Is_WrathoftheLichKing_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 3
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
		{id = 45087, defS = false,},
		{id = 47556, defS = false,},
		{id = 49908, defS = true,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			{id = 761, defS = true,}, -- The Ruby Sanctum
			{id = 758, defS = true,}, -- Icecrown Citadel
			{id = 760, defS = true,}, -- Onyxia's Lair
			{id = 757, defS = true,}, -- Trial of the Crusader
			{id = 759, defS = true,}, -- Ulduar
			{id = 756, defS = true,}, -- The Eye of Eternity
			{id = 755, defS = true,}, -- The Obsidian Sanctum
			{id = 754, defS = true,}, -- Naxxramas
			{id = 753, defS = true,}, -- Vault of Archavon
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
		{id = 1052, defS = true,}, --name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052] -- ОРДА
		----------------------------------------------------------------
		{id = 1124, defS = true,}, --name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
		{id = 1085, defS = true,}, --name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
		{id = 1067, defS = true,}, --name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
		{id = 1064, defS = true,}, --name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
		----------------------------------------------------------------
		{id = 1037, defS = true,}, --name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037] -- АЛЬЯНС
		----------------------------------------------------------------
		{id = 1094, defS = true,}, --name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
		{id = 1126, defS = true,}, --name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
		{id = 1068, defS = true,}, --name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
		{id = 1050, defS = true,}, --name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(24748, false)
			end,
			name_save = "Shadowmourne",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{24545, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24743, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24547, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24749, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24756, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24757, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24548, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24549, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
				{24748, FactionOrClass = {PALADIN = true, WARRIOR = true, DEATHKNIGHT = true,},},
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