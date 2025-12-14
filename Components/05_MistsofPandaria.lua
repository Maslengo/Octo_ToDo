local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 5
local expansionID = 5
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
		{id = 738, defS = true,}, -- Lesser Charm of Good Fortune
		{id = 697, defS = true,}, -- (697 MONETKA)
		{id = 752, defS = true,}, -- Mogu Rune of Fate
		{id = 777, defS = true,},
		{id = 789, defS = true,},
		{id = 776, defS = true,}, -- Warforged Seal
		{id = 402, defS = true,}, -- Ironpaw Token
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 101529, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 1492, defS = true,}, --name = "Император Шаохао", side = "-", category = "Mists of Pandaria", }, --[faction=1492]
		{id = 1435, defS = true,}, --name = "Натиск Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1435]
		{id = 1359, defS = true,}, --name = "Черный принц", side = "-", category = "Mists of Pandaria", }, --[faction=1359]
		{id = 1345, defS = true,}, --name = "Хранители истории", side = "-", category = "Mists of Pandaria", }, --[faction=1345]
		{id = 1341, defS = true,}, --name = "Небожители", side = "-", category = "Mists of Pandaria", }, --[faction=1341]
		{id = 1337, defS = true,}, --name = "Клакси", side = "-", category = "Mists of Pandaria", }, --[faction=1337]
		{id = 1271, defS = true,}, --name = "Орден Облачного Змея", side = "-", category = "Mists of Pandaria", }, --[faction=1271]
		{id = 1270, defS = true,}, --name = "Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1270]
		{id = 1269, defS = true,}, --name = "Золотой Лотос", side = "-", category = "Mists of Pandaria", }, --[faction=1269]
		----------------------------------------------------------------
		{id = 1388, defS = false,}, --name = "Войска Похитителей Солнца", side = "-", category = "Mists of Pandaria", }, --[faction=1388]
		{id = 1375, defS = false,}, --name = "Армия Покорителей", side = "-", category = "Mists of Pandaria", }, --[faction=1375] -- ОРДА
		{id = 1228, defS = false,}, --name = "Лесные хозены", side = "-", category = "Mists of Pandaria", }, --[faction=1228] -- ОРДА
		{id = 1387, defS = false,}, --name = "Армия Кирин-Тора", side = "-", category = "Mists of Pandaria", }, --[faction=1387]
		{id = 1376, defS = false,}, --name = "Операция \"Заслон\"", side = "-", category = "Mists of Pandaria", }, --[faction=1376] -- АЛЬЯНС
		{id = 1242, defS = false,}, --name = "Цзинь-юй Жемчужного Плавника", side = "-", category = "Mists of Pandaria", }, --[faction=1242] -- АЛЬЯНС
		----------------------------------------------------------------
		{id = 1272, defS = false,}, --name = "Земледельцы", side = "-", category = "Mists of Pandaria", }, --[faction=1272]
		{id = 1283, defS = false,}, --name = "Фермер Фун", side = "-", category = "Земледельцы", }, --[faction=1283]
		{id = 1282, defS = false,}, --name = "Рыба Тростниковая Шкура", side = "-", category = "Земледельцы", }, --[faction=1282]
		{id = 1281, defS = false,}, --name = "Джина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1281]
		{id = 1280, defS = false,}, --name = "Тина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1280]
		{id = 1279, defS = false,}, --name = "Хаохань Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1279]
		{id = 1278, defS = false,}, --name = "Шо", side = "-", category = "Земледельцы", }, --[faction=1278]
		{id = 1277, defS = false,}, --name = "Чи-Чи", side = "-", category = "Земледельцы", }, --[faction=1277]
		{id = 1276, defS = false,}, --name = "Старик Горная Лапа", side = "-", category = "Земледельцы", }, --[faction=1276]
		{id = 1275, defS = false,}, --name = "Элла", side = "-", category = "Земледельцы", }, --[faction=1275]
		{id = 1273, defS = false,}, --name = "Йогу Пьяный", side = "-", category = "Земледельцы", }, --[faction=1273]
		----------------------------------------------------------------
		{id = 1302, defS = false,}, --name = "Рыболовы", side = "-", category = "Mists of Pandaria", }, --[faction=1302]
		{id = 1358, defS = true,}, --name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
		----------------------------------------------------------------
		{id = 1357, defS = false,}, --name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			showTooltip = true,
			TextLeft = L["World Boss"],
			name_save = "WorldBoss",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{33118, forcedText = {npcID = 72057}, addText = {mapID = 554}, }, -- Ordos <Fire-God of the Yaungol> (Вневременный остров)
				{33117, forcedText = {achievementID = 7333}, addText = {mapID = 554}, }, -- Celestrials (Вневременный остров)
				{32519, forcedText = {npcID = 69161}, addText = {mapID = 507}, }, -- "Oondasta" (Остров Великанов
				-- {33109}, -- Nalak HIDDEN
				{32518, forcedText = {npcID = 69099}, addText = {mapID = 504}, }, -- "Nalak, The Storm Lord" (Остров Грома)
				{32098, forcedText = {npcID = 62346}, addText = {mapID = 376}, }, -- "Salyis's Warband" (Долина Четырех Ветров)
				{32099, forcedText = {npcID = 60491}, addText = {mapID = 379}, }, -- "Sha of Anger" (Вершина Кунь-Лай)
			},
			-- forcedMaxQuest = 6,
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)