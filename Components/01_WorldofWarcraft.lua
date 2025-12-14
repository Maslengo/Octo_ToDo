local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 1
local expansionID = 1
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
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 910, defS = true,}, --name = "Род Ноздорму", side = "-", category = "World of Warcraft", }, --[faction=910]
		{id = 909, defS = true,}, --name = "Ярмарка Новолуния", side = "-", category = "World of Warcraft", }, --[faction=909]
		{id = 809, defS = true,}, --name = "Шен'дралар", side = "-", category = "World of Warcraft", }, --[faction=809]
		{id = 749, defS = true,}, --name = "Гидраксианские Повелители Вод", side = "-", category = "World of Warcraft", }, --[faction=749]
		{id = 609, defS = true,}, --name = "Круг Кенария", side = "-", category = "World of Warcraft", }, --[faction=609]
		{id = 576, defS = true,}, --name = "Древобрюхи", side = "-", category = "World of Warcraft", }, --[faction=576]
		{id = 529, defS = true,}, --name = "Серебряный Рассвет", side = "-", category = "World of Warcraft", }, --[faction=529]
		{id = 349, defS = true,}, --name = "Черный Ворон", side = "-", category = "World of Warcraft", }, --[faction=349]
		{id = 270, defS = true,}, --name = "Племя Зандалари", side = "-", category = "World of Warcraft", }, --[faction=270]
		{id = 169, defS = true,}, --name = "Картель Хитрой Шестеренки", side = "-", category = "World of Warcraft", }, --[faction=169]
		{id = 93, defS = true,}, --name = "Кентавры из племени Маграм", side = "-", category = "World of Warcraft", }, --[faction=93]
		{id = 92, defS = true,}, --name = "Кентавры из племени Гелкис", side = "-", category = "World of Warcraft", }, --[faction=92]
		{id = 87, defS = true,}, --name = "Пираты Кровавого Паруса", side = "-", category = "World of Warcraft", }, --[faction=87]
		{id = 70, defS = true,}, --name = "Синдикат", side = "-", category = "World of Warcraft", }, --[faction=70]
		{id = 59, defS = true,}, --name = "Братство Тория", side = "-", category = "World of Warcraft", }, --[faction=59]
		----------------------------------------------------------------
		{id = 577, defS = true,}, --name = "Круговзор", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=577]
		{id = 470, defS = true,}, --name = "Кабестан", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=470]
		{id = 369, defS = true,}, --name = "Прибамбасск", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=369]
		{id = 21, defS = true,}, --name = "Пиратская Бухта", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=21]
		----------------------------------------------------------------
		{id = 67, defS = true,}, --name = "Орда", side = "Horde", category = "World of Warcraft", }, --[faction=67]
		{id = 2523, defS = true,}, --name = "Темные Когти", side = "Horde", category = "Орда", }, --[faction=2523]
		{id = 1352, defS = true,}, --name = "Пандарены Хоцзинь", side = "Horde", category = "Орда", }, --[faction=1352]
		{id = 1133, defS = true,}, --name = "Картель Трюмных Вод", side = "Horde", category = "Орда", }, --[faction=1133]
		{id = 911, defS = true,}, --name = "Луносвет", side = "Horde", category = "Орда", }, --[faction=911]
		{id = 530, defS = true,}, --name = "Племя Черного Копья", side = "Horde", category = "Орда", }, --[faction=530]
		{id = 81, defS = true,}, --name = "Громовой Утес", side = "Horde", category = "Орда", }, --[faction=81]
		{id = 76, defS = true,}, --name = "Оргриммар", side = "Horde", category = "Орда", }, --[faction=76]
		{id = 68, defS = true,}, --name = "Подгород", side = "Horde", category = "Орда", }, --[faction=68]
		----------------------------------------------------------------
		{id = 2372, defS = true,}, --name = "Арена \"Морд'Бой\"", side = "Horde", category = "Силы Орды", }, --[faction=2372]
		{id = 2010, defS = true,}, --name = "Арена \"Морд'Бой\" (3-й сезон)", side = "Horde", category = "Силы Орды", }, --[faction=2010]
		{id = 1690, defS = true,}, --name = "Арена \"Морд'Бой\" (сезон 2)", side = "Horde", category = "Силы Орды", }, --[faction=1690]
		{id = 1681, defS = true,}, --name = "Копье Вол'джина", side = "Horde", category = "Силы Орды", }, --[faction=1681]
		{id = 1374, defS = true,}, --name = "Арена \"Морд'Бой\" (сезон 1)", side = "Horde", category = "Силы Орды", }, --[faction=1374]
		{id = 889, defS = true,}, --name = "Всадники Песни Войны", side = "Horde", category = "Силы Орды", }, --[faction=889]
		{id = 729, defS = true,}, --name = "Азеротский клан Северного Волка", side = "Horde", category = "Силы Орды", }, --[faction=729]
		{id = 510, defS = true,}, --name = "Осквернители", side = "Horde", category = "Силы Орды", }, --[faction=510]
		----------------------------------------------------------------
		{id = 469, defS = true,}, --name = "Альянс", side = "Alliance", category = "World of Warcraft", }, --[faction=469]
		{id = 2524, defS = true,}, --name = "Обсидиановые Хранители", side = "Alliance", category = "Альянс", }, --[faction=2524]
		{id = 1353, defS = true,}, --name = "Пандарены Тушуй", side = "Alliance", category = "Альянс", }, --[faction=1353]
		{id = 1134, defS = true,}, --name = "Гилнеас", side = "Alliance", category = "Альянс", }, --[faction=1134]
		{id = 930, defS = true,}, --name = "Экзодар", side = "Alliance", category = "Альянс", }, --[faction=930]
		{id = 72, defS = true,}, --name = "Штормград", side = "Alliance", category = "Альянс", }, --[faction=72]
		{id = 69, defS = true,}, --name = "Дарнас", side = "Alliance", category = "Альянс", }, --[faction=69]
		{id = 54, defS = true,}, --name = "Гномреган", side = "Alliance", category = "Альянс", }, --[faction=54]
		{id = 47, defS = true,}, --name = "Стальгорн", side = "Alliance", category = "Альянс", }, --[faction=47]
		----------------------------------------------------------------
		{id = 2371, defS = true,}, --name = "Потасовочная \"У Бизмо\"", side = "Alliance", category = "Силы Альянса", }, --[faction=2371]
		{id = 2011, defS = true,}, --name = "Потасовочная \"У Бизмо\" (3-й сезон)", side = "Alliance", category = "Силы Альянса", }, --[faction=2011
		{id = 1691, defS = true,}, --name = "Потасовочная \"У Бизмо\" (сезон 2)", side = "Alliance", category = "Силы Альянса", }, --[faction=1691
		{id = 1682, defS = true,}, --name = "Авангард Ринна", side = "Alliance", category = "Силы Альянса", }, --[faction=1682
		{id = 1419, defS = true,}, --name = "Потасовочная \"У Бизмо\" (сезон 1)", side = "Alliance", category = "Силы Альянса", }, --[faction=1419]
		{id = 890, defS = true,}, --name = "Среброкрылые Часовые", side = "Alliance", category = "Силы Альянса", }, --[faction=890
		{id = 730, defS = true,}, --name = "Стража Грозовой Вершины", side = "Alliance", category = "Силы Альянса", }, --[faction=730
		{id = 509, defS = true,}, --name = "Лига Аратора", side = "Alliance", category = "Силы Альянса", }, --[faction=509]
		{id = 589, defS = true,}, --name = "Укротители ледопардов", side = "Alliance", category = "World of Warcraft", }, --[faction=589]
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