local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 5

E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[currentSTATE].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
	402, -- Ironpaw Token
	738, -- Lesser Charm of Good Fortune
	752, -- Mogu Rune of Fate
	776, -- Warforged Seal
	777,
	789,
	697, -- (697 MONETKA)
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
	1492, --name = "Император Шаохао", side = "-", category = "Mists of Pandaria", }, --[faction=1492]
	1435, --name = "Натиск Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1435]
	1359, --name = "Черный принц", side = "-", category = "Mists of Pandaria", }, --[faction=1359]
	1345, --name = "Хранители истории", side = "-", category = "Mists of Pandaria", }, --[faction=1345]
	1341, --name = "Небожители", side = "-", category = "Mists of Pandaria", }, --[faction=1341]
	1337, --name = "Клакси", side = "-", category = "Mists of Pandaria", }, --[faction=1337]
	1271, --name = "Орден Облачного Змея", side = "-", category = "Mists of Pandaria", }, --[faction=1271]
	1270, --name = "Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1270]
	1269, --name = "Золотой Лотос", side = "-", category = "Mists of Pandaria", }, --[faction=1269]
	----------------------------------------------------------------
	1388, --name = "Войска Похитителей Солнца", side = "-", category = "Mists of Pandaria", }, --[faction=1388]
	1375, --name = "Армия Покорителей", side = "-", category = "Mists of Pandaria", }, --[faction=1375] -- ОРДА
	1228, --name = "Лесные хозены", side = "-", category = "Mists of Pandaria", }, --[faction=1228] -- ОРДА
	1387, --name = "Армия Кирин-Тора", side = "-", category = "Mists of Pandaria", }, --[faction=1387]
	1376, --name = "Операция \"Заслон\"", side = "-", category = "Mists of Pandaria", }, --[faction=1376] -- АЛЬЯНС
	1242, --name = "Цзинь-юй Жемчужного Плавника", side = "-", category = "Mists of Pandaria", }, --[faction=1242] -- АЛЬЯНС
		----------------------------------------------------------------
	1272, --name = "Земледельцы", side = "-", category = "Mists of Pandaria", }, --[faction=1272]
	1283, --name = "Фермер Фун", side = "-", category = "Земледельцы", }, --[faction=1283]
	1282, --name = "Рыба Тростниковая Шкура", side = "-", category = "Земледельцы", }, --[faction=1282]
	1281, --name = "Джина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1281]
	1280, --name = "Тина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1280]
	1279, --name = "Хаохань Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1279]
	1278, --name = "Шо", side = "-", category = "Земледельцы", }, --[faction=1278]
	1277, --name = "Чи-Чи", side = "-", category = "Земледельцы", }, --[faction=1277]
	1276, --name = "Старик Горная Лапа", side = "-", category = "Земледельцы", }, --[faction=1276]
	1275, --name = "Элла", side = "-", category = "Земледельцы", }, --[faction=1275]
	1273, --name = "Йогу Пьяный", side = "-", category = "Земледельцы", }, --[faction=1273]
		----------------------------------------------------------------
	1302, --name = "Рыболовы", side = "-", category = "Mists of Pandaria", }, --[faction=1302]
	1358, --name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
		----------------------------------------------------------------
	1357, --name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
		{
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = currentSTATE,
			quests = {
				{33118, forcedText = {npcID = 72057},  addText = {mapID = 554},   }, -- Ordos <Fire-God of the Yaungol> (Вневременный остров)
				{33117, forcedText = {achievementID = 7333},  addText = {mapID = 554},   }, -- Celestrials (Вневременный остров)
				{32519, forcedText = {npcID = 69161},  addText = {mapID = 507},   }, -- "Oondasta" (Остров Великанов
				-- {33109}, -- Nalak HIDDEN
				{32518, forcedText = {npcID = 69099},  addText = {mapID = 504},   }, -- "Nalak, The Storm Lord" (Остров Грома)
				{32098, forcedText = {npcID = 62346},  addText = {mapID = 376},   }, -- "Salyis's Warband" (Долина Четырех Ветров)
				{32099, forcedText = {npcID = 60491},  addText = {mapID = 379},   }, -- "Sha of Anger" (Вершина Кунь-Лай)
			},
			-- forcedMaxQuest = 6,
		},
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {

}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------