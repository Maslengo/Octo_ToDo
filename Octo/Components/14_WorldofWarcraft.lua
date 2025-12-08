local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 14
local expansionID = 1
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
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {
		910, --name = "Род Ноздорму", side = "-", category = "World of Warcraft", }, --[faction=910]
		909, --name = "Ярмарка Новолуния", side = "-", category = "World of Warcraft", }, --[faction=909]
		809, --name = "Шен'дралар", side = "-", category = "World of Warcraft", }, --[faction=809]
		749, --name = "Гидраксианские Повелители Вод", side = "-", category = "World of Warcraft", }, --[faction=749]
		609, --name = "Круг Кенария", side = "-", category = "World of Warcraft", }, --[faction=609]
		576, --name = "Древобрюхи", side = "-", category = "World of Warcraft", }, --[faction=576]
		529, --name = "Серебряный Рассвет", side = "-", category = "World of Warcraft", }, --[faction=529]
		349, --name = "Черный Ворон", side = "-", category = "World of Warcraft", }, --[faction=349]
		270, --name = "Племя Зандалари", side = "-", category = "World of Warcraft", }, --[faction=270]
		169, --name = "Картель Хитрой Шестеренки", side = "-", category = "World of Warcraft", }, --[faction=169]
		93, --name = "Кентавры из племени Маграм", side = "-", category = "World of Warcraft", }, --[faction=93]
		92, --name = "Кентавры из племени Гелкис", side = "-", category = "World of Warcraft", }, --[faction=92]
		87, --name = "Пираты Кровавого Паруса", side = "-", category = "World of Warcraft", }, --[faction=87]
		70, --name = "Синдикат", side = "-", category = "World of Warcraft", }, --[faction=70]
		59, --name = "Братство Тория", side = "-", category = "World of Warcraft", }, --[faction=59]
		----------------------------------------------------------------
		577, --name = "Круговзор", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=577]
		470, --name = "Кабестан", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=470]
		369, --name = "Прибамбасск", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=369]
		21, --name = "Пиратская Бухта", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=21]
		----------------------------------------------------------------
		67, --name = "Орда", side = "Horde", category = "World of Warcraft", }, --[faction=67]
		2523, --name = "Темные Когти", side = "Horde", category = "Орда", }, --[faction=2523]
		1352, --name = "Пандарены Хоцзинь", side = "Horde", category = "Орда", }, --[faction=1352]
		1133, --name = "Картель Трюмных Вод", side = "Horde", category = "Орда", }, --[faction=1133]
		911, --name = "Луносвет", side = "Horde", category = "Орда", }, --[faction=911]
		530, --name = "Племя Черного Копья", side = "Horde", category = "Орда", }, --[faction=530]
		81, --name = "Громовой Утес", side = "Horde", category = "Орда", }, --[faction=81]
		76, --name = "Оргриммар", side = "Horde", category = "Орда", }, --[faction=76]
		68, --name = "Подгород", side = "Horde", category = "Орда", }, --[faction=68]
		----------------------------------------------------------------
		2372, --name = "Арена \"Морд'Бой\"", side = "Horde", category = "Силы Орды", }, --[faction=2372]
		2010, --name = "Арена \"Морд'Бой\" (3-й сезон)", side = "Horde", category = "Силы Орды", }, --[faction=2010]
		1690, --name = "Арена \"Морд'Бой\" (сезон 2)", side = "Horde", category = "Силы Орды", }, --[faction=1690]
		1681, --name = "Копье Вол'джина", side = "Horde", category = "Силы Орды", }, --[faction=1681]
		1374, --name = "Арена \"Морд'Бой\" (сезон 1)", side = "Horde", category = "Силы Орды", }, --[faction=1374]
		889, --name = "Всадники Песни Войны", side = "Horde", category = "Силы Орды", }, --[faction=889]
		729, --name = "Азеротский клан Северного Волка", side = "Horde", category = "Силы Орды", }, --[faction=729]
		510, --name = "Осквернители", side = "Horde", category = "Силы Орды", }, --[faction=510]
		----------------------------------------------------------------
		469, --name = "Альянс", side = "Alliance", category = "World of Warcraft", }, --[faction=469]
		2524, --name = "Обсидиановые Хранители", side = "Alliance", category = "Альянс", }, --[faction=2524]
		1353, --name = "Пандарены Тушуй", side = "Alliance", category = "Альянс", }, --[faction=1353]
		1134, --name = "Гилнеас", side = "Alliance", category = "Альянс", }, --[faction=1134]
		930, --name = "Экзодар", side = "Alliance", category = "Альянс", }, --[faction=930]
		72, --name = "Штормград", side = "Alliance", category = "Альянс", }, --[faction=72]
		69, --name = "Дарнас", side = "Alliance", category = "Альянс", }, --[faction=69]
		54, --name = "Гномреган", side = "Alliance", category = "Альянс", }, --[faction=54]
		47, --name = "Стальгорн", side = "Alliance", category = "Альянс", }, --[faction=47]
		----------------------------------------------------------------
		2371, --name = "Потасовочная \"У Бизмо\"", side = "Alliance", category = "Силы Альянса", }, --[faction=2371]
		2011, --name = "Потасовочная \"У Бизмо\" (3-й сезон)", side = "Alliance", category = "Силы Альянса", }, --[faction=2011
		1691, --name = "Потасовочная \"У Бизмо\" (сезон 2)", side = "Alliance", category = "Силы Альянса", }, --[faction=1691
		1682, --name = "Авангард Ринна", side = "Alliance", category = "Силы Альянса", }, --[faction=1682
		1419, --name = "Потасовочная \"У Бизмо\" (сезон 1)", side = "Alliance", category = "Силы Альянса", }, --[faction=1419]
		890, --name = "Среброкрылые Часовые", side = "Alliance", category = "Силы Альянса", }, --[faction=890
		730, --name = "Стража Грозовой Вершины", side = "Alliance", category = "Силы Альянса", }, --[faction=730
		509, --name = "Лига Аратора", side = "Alliance", category = "Силы Альянса", }, --[faction=509]
		589, --name = "Укротители ледопардов", side = "Alliance", category = "World of Warcraft", }, --[faction=589]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
end

table.insert(E.Components, tempFunction)