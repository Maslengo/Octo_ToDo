local GlobalAddonName, E = ...
--------------------------------------------------------------------------------
E.OctoTable_reputation_ALL = {
	2590,
	2640,
	2594,
	2570,
	2600,
}
E.OctoTable_reputationID_Hidden = {
	2463,
}




E.OctoTable_OCTOREP = {
	[81] = {icon = "NONE", name = "Громовой Утес", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[1133] = {icon = "NONE", name = "Картель Трюмных Вод", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[911] = {icon = "NONE", name = "Луносвет", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[76] = {icon = "NONE", name = "Оргриммар", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[1352] = {icon = "NONE", name = "Пандарены Хоцзинь", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[530] = {icon = "NONE", name = "Племя Черного Копья", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[68] = {icon = "NONE", name = "Подгород", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	[2523] = {icon = "NONE", name = "Темные Когти", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
}


E.OctoTable_FACTIONTABLE = {
	-- -- [1072] = {icon = 0, name = "[DNT] AC Major Faction Child Renown Test", faction = "", other = "Кентавры Маруук", },
	-- [2159] = {icon = 2024072, name = "7-й легион", faction = "", other = "Battle for Azeroth", },
	-- -- [1861] = {icon = 0, name = "Arcane Thirst (Silgryn) DEPRECATED", faction = "", other = "Помраченные", },
	-- -- [2063] = {icon = 0, name = "Arne Test - Paragon Reputation Stormwind", faction = "", other = "Другое", },
	-- [2104] = {icon = 0, name = "Battle for Azeroth", faction = "", other = "Другое", },
	-- [1162] = {icon = 0, name = "Cataclysm", faction = "", other = "Другое", },
	-- [2233] = {icon = 0, name = "Dino Training - Pterrodax", faction = "", other = "Battle for Azeroth", },
	-- [2506] = {icon = 0, name = "Dragonflight", faction = "", other = "Другое", },
	-- [1834] = {icon = 0, name = "Legion", faction = "", other = "Другое", },
	-- [1245] = {icon = 0, name = "Mists of Pandaria", faction = "", other = "Другое", },
	-- -- [2431] = {icon = 0, name = "Owen Test", faction = "", other = "Другое", },
	-- [980] = {icon = 0, name = "The Burning Crusade", faction = "", other = "Другое", },
	-- [2569] = {icon = 0, name = "The War Within", faction = "", other = "Другое", },
	-- [1444] = {icon = 0, name = "Warlords of Draenor", faction = "", other = "Другое", },
	-- [1118] = {icon = 0, name = "World of Warcraft", faction = "", other = "Другое", },
	-- [1097] = {icon = 0, name = "Wrath of the Lich King", faction = "", other = "Другое", },
	-- [1037] = {icon = "NONE", name = "Авангард Альянса", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Wrath of the Lich King", },
	-- [1682] = {icon = 1042294, name = "Авангард Ринна", faction = "", other = "Силы Альянса", },
	-- [2160] = {icon = 2012311, name = "Адмиралтейство Праудмуров", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Battle for Azeroth", },
	-- [1740] = {icon = "NONE", name = "Аеда Ясная Заря", faction = "", other = "Телохранители из казарм", },
	-- [2615] = {icon = "NONE", name = "Азеротские Архивы", faction = "", other = "Драконья экспедиция", },
	-- [729] = {icon = "NONE", name = "Азеротский клан Северного Волка", faction = "", other = "Силы Орды", },
	-- [1216] = {icon = "NONE", name = "Академия Шан Си", faction = "", other = "Mists of Pandaria", },
	-- [2099] = {icon = 236575, name = "Акуле Речной Рог", faction = "", other = "Legion", },
	-- [932] = {icon = 135026, name = "Алдоры", faction = "", other = "Город Шаттрат", },
	-- [2450] = {icon = "NONE", name = "Александрос Могрейн", faction = "", other = "Пепельный двор", },
	-- [469] = {icon = "NONE", name = "Альянс", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "World of Warcraft", },
	-- [967] = {icon = "NONE", name = "Аметистовое Око", faction = "", other = "The Burning Crusade", },
	-- [1515] = {icon = 1042646, name = "Араккоа-изгои", faction = "", other = "Warlords of Draenor", },
	-- [2570] = {icon = "NONE", name = "Арати Тайносводья", faction = "", other = "The War Within", },
	-- [2372] = {icon = "NONE", name = "Арена \"Морд'Бой\"", faction = "", other = "Силы Орды", },
	-- [2010] = {icon = "NONE", name = "Арена \"Морд'Бой\" (3-й сезон)", faction = "", other = "Силы Орды", },
	-- [1374] = {icon = "NONE", name = "Арена \"Морд'Бой\" (сезон 1)", faction = "", other = "Силы Орды", },
	-- [1690] = {icon = "NONE", name = "Арена \"Морд'Бой\" (сезон 2)", faction = "", other = "Силы Орды", },
	-- [1387] = {icon = "NONE", name = "Армия Кирин-Тора", faction = "", other = "Mists of Pandaria", },
	-- [1085] = {icon = "NONE", name = "Армия Песни Войны", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Экспедиция Орды", },
	-- [2045] = {icon = "NONE", name = "Армия погибели Легиона", faction = "", other = "Legion", },
	-- [1375] = {icon = "NONE", name = "Армия Покорителей", faction = "", other = "Mists of Pandaria", },
	-- [1077] = {icon = "NONE", name = "Армия Расколотого Солнца", faction = "", other = "Город Шаттрат", },
	-- [2165] = {icon = "NONE", name = "Армия Света", faction = "", other = "Legion", },
	-- [2157] = {icon = "NONE", name = "Армия Чести", faction = "", other = "Battle for Azeroth", },
	-- [1711] = {icon = "NONE", name = "Археологическое общество Хитрой Шестеренки", faction = "", other = "Warlords of Draenor", },
	-- [2594] = {icon = "NONE", name = "Ассамблея глубин", faction = "", other = "The War Within", },
	-- [2446] = {icon = "NONE", name = "Баронесса Вайш", faction = "", other = "Пепельный двор", },
	-- [1178] = {icon = "NONE", name = "Батальон Адского Крика", faction = "", other = "Cataclysm", },
	-- [2102] = {icon = 236575, name = "Бесс", faction = "", other = "Legion", },
	-- [2640] = {icon = "NONE", name = "Бранн Бронзобород", faction = "", other = "The War Within", },
	-- [59] = {icon = "NONE", name = "Братство Тория", faction = "", other = "World of Warcraft", },
	-- [1948] = {icon = "NONE", name = "Валарьяры", faction = "", other = "Legion", },
	-- [2432] = {icon = "NONE", name = "Ве'нари", faction = "", other = "Темные Земли", },
	-- [2457] = {icon = "NONE", name = "Великий мастер Воул", faction = "", other = "Пепельный двор", },
	-- [1739] = {icon = "NONE", name = "Вивианна", faction = "", other = "Телохранители из казарм", },
	-- [2390] = {icon = "NONE", name = "Вим Соленодух", faction = "", other = "Battle for Azeroth", },
	-- [1388] = {icon = "NONE", name = "Войска Похитителей Солнца", faction = "", other = "Mists of Pandaria", },
	-- [1440] = {icon = "NONE", name = "Восстание Черного Копья", faction = "", other = "Mists of Pandaria", },
	-- [889] = {icon = "NONE", name = "Всадники Песни Войны", faction = "", other = "Силы Орды", },
	-- [1815] = {icon = "NONE", name = "Выжившие из Гилнеаса", faction = "", other = "Legion", },
	-- [2644] = {icon = "NONE", name = "Вылазки: 1-й сезон", faction = "", other = "The War Within", },
	-- [749] = {icon = "NONE", name = "Гидраксианские Повелители Вод", faction = "", other = "World of Warcraft", },
	-- [1134] = {icon = "NONE", name = "Гилнеас", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [1168] = {icon = "NONE", name = "Гильдия", faction = "", other = "Гильдия", },
	-- [1169] = {icon = "NONE", name = "Гильдия", faction = "", other = "Другое", },
	-- [2517] = {icon = "NONE", name = "Гневион", faction = "", other = "Союз Вальдраккена", },
	-- [54] = {icon = "NONE", name = "Гномреган", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [2568] = {icon = "NONE", name = "Гонщик Мерцающего Огга", faction = "", other = "Dragonflight", },
	-- [936] = {icon = "NONE", name = "Город Шаттрат", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "The Burning Crusade", },
	-- [2449] = {icon = "NONE", name = "Графиня", faction = "", other = "Пепельный двор", },
	-- [81] = {icon = "NONE", name = "Громовой Утес", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [69] = {icon = "NONE", name = "Дарнас", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [2413] = {icon = "NONE", name = "Двор Жнецов", faction = "", other = "Темные Земли", },
	-- [2464] = {icon = "NONE", name = "Двор Ночи", faction = "", other = "Темные Земли", },
	-- [1900] = {icon = "NONE", name = "Двор Фарондиса", faction = "", other = "Legion", },
	-- [1733] = {icon = "NONE", name = "Делвар Железный Кулак", faction = "", other = "Телохранители из казарм", },
	-- [1281] = {icon = "NONE", name = "Джина Грязный Коготь", faction = "", other = "Земледельцы", },
	-- [2465] = {icon = "NONE", name = "Дикая Охота", faction = "", other = "Темные Земли", },
	-- [1847] = {icon = "NONE", name = "Длань Пророка", faction = "", other = "Warlords of Draenor", },
	-- [1091] = {icon = "NONE", name = "Драконий союз", faction = "", other = "Wrath of the Lich King", },
	-- [2507] = {icon = "NONE", name = "Драконья экспедиция", faction = "", other = "Dragonflight", },
	-- [576] = {icon = "NONE", name = "Древобрюхи", faction = "", other = "World of Warcraft", },
	-- [1732] = {icon = "NONE", name = "Дренорcкая Экспедиция Хитрой Шестеренки", faction = "", other = "Warlords of Draenor", },
	-- [2456] = {icon = "NONE", name = "Дроман Алиот", faction = "", other = "Пепельный двор", },
	-- [1919] = {icon = "NONE", name = "Жажда магии Вальтруа", faction = "", other = "Помраченные", },
	-- [1862] = {icon = "NONE", name = "Жажда магии Окулета", faction = "", other = "Помраченные", },
	-- [1860] = {icon = "NONE", name = "Жажда магии Талисры", faction = "", other = "Помраченные", },
	-- [2158] = {icon = "NONE", name = "Жители Вол'дуна", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Battle for Azeroth", },
	-- [1737] = {icon = "NONE", name = "Жрец Когтя Ишааль", faction = "", other = "Телохранители из казарм", },
	-- [2111] = {icon = "NONE", name = "Зандаларские динозавры", faction = "", other = "Battle for Azeroth", },
	-- [2164] = {icon = "NONE", name = "Защитники Азерот", faction = "", other = "Battle for Azeroth", },
	-- [2170] = {icon = "NONE", name = "Защитники Аргуса", faction = "", other = "Legion", },
	-- [1177] = {icon = "NONE", name = "Защитники Тол Барада", faction = "", other = "Cataclysm", },
	-- [1710] = {icon = "NONE", name = "Защитники Ша'тар", faction = "", other = "Warlords of Draenor", },
	-- [1738] = {icon = "NONE", name = "Защитница Иллона", faction = "", other = "Телохранители из казарм", },
	-- [1272] = {icon = "NONE", name = "Земледельцы", faction = "", other = "Mists of Pandaria", },
	-- [1126] = {icon = "NONE", name = "Зиморожденные", faction = "", other = "Авангард Альянса", },
	-- [1269] = {icon = "NONE", name = "Золотой Лотос", faction = "", other = "Mists of Pandaria", },
	-- [1520] = {icon = "NONE", name = "Изгнанники клана Призрачной Луны", faction = "", other = "Warlords of Draenor", },
	-- [2461] = {icon = "NONE", name = "Изобретатель чумы Марилет", faction = "", other = "Пепельный двор", },
	-- [2097] = {icon = 236575, name = "Илиссия Водная", faction = "", other = "Legion", },
	-- [1947] = {icon = "NONE", name = "Иллидари", faction = "", other = "Legion", },
	-- [1492] = {icon = "NONE", name = "Император Шаохао", faction = "", other = "Mists of Pandaria", },
	-- [2103] = {icon = "NONE", name = "Империя Зандалари", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Battle for Azeroth", },
	-- [2511] = {icon = "NONE", name = "Искарские клыкарры", faction = "", other = "Dragonflight", },
	-- [1273] = {icon = "NONE", name = "Йогу Пьяный", faction = "", other = "Земледельцы", },
	-- [470] = {icon = "NONE", name = "Кабестан", faction = "", other = "Картель Хитрой Шестеренки", },
	-- [1073] = {icon = "NONE", name = "Калу'ак", faction = "", other = "Wrath of the Lich King", },
	-- [2460] = {icon = "NONE", name = "Камнелоб", faction = "", other = "Пепельный двор", },
	-- [2451] = {icon = "NONE", name = "Капитан-егерь Корейн", faction = "", other = "Пепельный двор", },
	-- [1067] = {icon = "NONE", name = "Карающая Длань", faction = "", other = "Экспедиция Орды", },
	-- [1133] = {icon = "NONE", name = "Картель Трюмных Вод", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [169] = {icon = "NONE", name = "Картель Хитрой Шестеренки", faction = E.func_texturefromIcon(E.Icon_Horde), other = "World of Warcraft", },
	-- [942] = {icon = "NONE", name = "Кенарийская экспедиция", faction = "", other = "The Burning Crusade", },
	-- [92] = {icon = "NONE", name = "Кентавры из племени Гелкис", faction = "", other = "World of Warcraft", },
	-- [93] = {icon = "NONE", name = "Кентавры из племени Маграм", faction = "", other = "World of Warcraft", },
	-- [2503] = {icon = "NONE", name = "Кентавры Маруук", faction = "", other = "Dragonflight", },
	-- [1090] = {icon = "NONE", name = "Кирин-Тор", faction = "", other = "Wrath of the Lich King", },
	-- [1337] = {icon = "NONE", name = "Клакси", faction = "", other = "Mists of Pandaria", },
	-- [2512] = {icon = "NONE", name = "Клан Айлааг", faction = "", other = "Кентавры Маруук", },
	-- [1708] = {icon = "NONE", name = "Клан Веселого Черепа", faction = "", other = "Warlords of Draenor", },
	-- [1174] = {icon = "NONE", name = "Клан Громового Молота", faction = "", other = "Cataclysm", },
	-- [1172] = {icon = "NONE", name = "Клан Драконьей Пасти", faction = "", other = "Cataclysm", },
	-- [2555] = {icon = "NONE", name = "Клан Кейган", faction = "", other = "Dragonflight", },
	-- [2520] = {icon = "NONE", name = "Клан Нокхуд", faction = "", other = "Dragonflight", },
	-- [2513] = {icon = "NONE", name = "Клан Он'ир", faction = "", other = "Кентавры Маруук", },
	-- [1445] = {icon = "NONE", name = "Клан Северного Волка", faction = "", other = "Warlords of Draenor", },
	-- [2522] = {icon = "NONE", name = "Клан Тирай", faction = "", other = "Кентавры Маруук", },
	-- [2554] = {icon = "NONE", name = "Клан Тогус", faction = "", other = "Кентавры Маруук", },
	-- [2542] = {icon = "NONE", name = "Клан Укхел", faction = "", other = "Dragonflight", },
	-- [2509] = {icon = "NONE", name = "Клан Шикаар", faction = "", other = "Кентавры Маруук", },
	-- [2458] = {icon = "NONE", name = "Клейя и Пелагий", faction = "", other = "Пепельный двор", },
	-- [2400] = {icon = "NONE", name = "Клинки Волн", faction = "", other = "Battle for Azeroth", },
	-- [2550] = {icon = "NONE", name = "Кобальтовая ассамблея", faction = "", other = "Союз Вальдраккена", },
	-- [2472] = {icon = "NONE", name = "Кодекс архивариуса", faction = "", other = "Темные Земли", },
	-- [2593] = {icon = "NONE", name = "Команда Бочконога", faction = "", other = "Другое", },
	-- [933] = {icon = "NONE", name = "Консорциум", faction = "", other = "The Burning Crusade", },
	-- [2544] = {icon = "NONE", name = "Консорциум ремесленников – филиал на Драконьих островах", faction = "", other = "Союз Вальдраккена", },
	-- [1681] = {icon = "NONE", name = "Копье Вол'джина", faction = "", other = "Силы Орды", },
	-- [2100] = {icon = 236575, name = "Корбин", faction = "", other = "Legion", },
	-- [609] = {icon = "NONE", name = "Круг Кенария", faction = "", other = "World of Warcraft", },
	-- [577] = {icon = "NONE", name = "Круговзор", faction = "", other = "Картель Хитрой Шестеренки", },
	-- [1015] = {icon = "NONE", name = "Крылья Пустоты", faction = "", other = "The Burning Crusade", },
	-- [1975] = {icon = "NONE", name = "Кудесник Маргосс", faction = "", other = "Legion", },
	-- [2265] = {icon = "NONE", name = "Кул-Тирас - долина Штормов", faction = "", other = "Орден Возрождения Шторма", },
	-- [2264] = {icon = "NONE", name = "Кул-Тирас - Друствар", faction = "", other = "Орден Пылающих Углей", },
	-- [2120] = {icon = "NONE", name = "Кул-Тирас - Тирагард", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Адмиралтейство Праудмуров", },
	-- [978] = {icon = "NONE", name = "Куренай", faction = "", other = "The Burning Crusade", },
	-- [2470] = {icon = "NONE", name = "Легион Смерти", faction = "", other = "Темные Земли", },
	-- [2447] = {icon = "NONE", name = "Леди Лунная Ягода", faction = "", other = "Пепельный двор", },
	-- [1741] = {icon = "NONE", name = "Леорадж", faction = "", other = "Телохранители из казарм", },
	-- [1228] = {icon = "NONE", name = "Лесные хозены", faction = "", other = "Mists of Pandaria", },
	-- [509] = {icon = "NONE", name = "Лига Аратора", faction = "", other = "Силы Альянса", },
	-- [1068] = {icon = "NONE", name = "Лига исследователей", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Авангард Альянса", },
	-- [2564] = {icon = "NONE", name = "Лоаммские ниффы", faction = "", other = "Dragonflight", },
	-- [1899] = {icon = "NONE", name = "Лунные стражи", faction = "", other = "Legion", },
	-- [1989] = {icon = "NONE", name = "Лунные стражи", faction = "", other = "Legion", },
	-- [911] = {icon = "NONE", name = "Луносвет", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [941] = {icon = "NONE", name = "Маг'хары", faction = E.func_texturefromIcon(E.Icon_Horde), other = "The Burning Crusade", },
	-- [2377] = {icon = "NONE", name = "Мастер клинка Иновари", faction = "", other = "Battle for Azeroth", },
	-- [2375] = {icon = "NONE", name = "Мастер охоты Акана", faction = "", other = "Battle for Azeroth", },
	-- [2448] = {icon = "NONE", name = "Миканикос", faction = "", other = "Пепельный двор", },
	-- [2427] = {icon = "NONE", name = "Молодой акир", faction = "", other = "Battle for Azeroth", },
	-- [1358] = {icon = "NONE", name = "Нат Пэгл", faction = "", other = "Рыболовы", },
	-- [1435] = {icon = "NONE", name = "Натиск Шадо-Пан", faction = "", other = "Mists of Pandaria", },
	-- [1341] = {icon = "NONE", name = "Небожители", faction = "", other = "Mists of Pandaria", },
	-- [2439] = {icon = "NONE", name = "Нераскаявшиеся", faction = "", other = "Темные Земли", },
	-- [2389] = {icon = "NONE", name = "Нери Остроерш", faction = "", other = "Battle for Azeroth", },
	-- [2410] = {icon = "NONE", name = "Неумирающая армия", faction = "", other = "Темные Земли", },
	-- [1011] = {icon = "NONE", name = "Нижний Город", faction = "", other = "Город Шаттрат", },
	-- [1117] = {icon = "NONE", name = "Низина Шолазар", faction = "", other = "Wrath of the Lich King", },
	-- [1357] = {icon = "NONE", name = "Номи", faction = "", other = "Другое", },
	-- [2422] = {icon = "NONE", name = "Ночной народец", faction = "", other = "Дикая Охота", },
	-- [2524] = {icon = "NONE", name = "Обсидиановые Хранители", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [2370] = {icon = "NONE", name = "Обучение динозавров – Дикорог", faction = "", other = "Battle for Azeroth", },
	-- [1038] = {icon = "NONE", name = "Огри'ла", faction = "", other = "The Burning Crusade", },
	-- [1376] = {icon = "NONE", name = "Операция \"Заслон\"", faction = "", other = "Mists of Pandaria", },
	-- [946] = {icon = "NONE", name = "Оплот Чести", faction = "", other = "The Burning Crusade", },
	-- [2376] = {icon = "NONE", name = "Оракул Ори", faction = "", other = "Battle for Azeroth", },
	-- [1105] = {icon = "NONE", name = "Оракулы", faction = "", other = "Низина Шолазар", },
	-- [76] = {icon = "NONE", name = "Оргриммар", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [67] = {icon = "NONE", name = "Орда", faction = E.func_texturefromIcon(E.Icon_Horde), other = "World of Warcraft", },
	-- [2162] = {icon = "NONE", name = "Орден Возрождения Шторма", faction = "", other = "Battle for Azeroth", },
	-- [1271] = {icon = "NONE", name = "Орден Облачного Змея", faction = "", other = "Mists of Pandaria", },
	-- [1849] = {icon = "NONE", name = "Орден Пробудившихся", faction = "", other = "Warlords of Draenor", },
	-- [2161] = {icon = "NONE", name = "Орден Пылающих Углей", faction = "", other = "Battle for Azeroth", },
	-- [2373] = {icon = "NONE", name = "Освобожденные", faction = "", other = "Battle for Azeroth", },
	-- [510] = {icon = "NONE", name = "Осквернители", faction = "", other = "Силы Орды", },
	-- [2018] = {icon = "NONE", name = "Отмщение Когтя", faction = "", other = "Legion", },
	-- [2600] = {icon = "NONE", name = "Отрезанные нити", faction = "", other = "The War Within", },
	-- [1848] = {icon = "NONE", name = "Охотники за головами", faction = "", other = "Warlords of Draenor", },
	-- [1850] = {icon = "NONE", name = "Охотники за саблеронами", faction = "", other = "Warlords of Draenor", },
	-- [1353] = {icon = "NONE", name = "Пандарены Тушуй", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [1352] = {icon = "NONE", name = "Пандарены Хоцзинь", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [2445] = {icon = "NONE", name = "Пепельный двор", faction = "", other = "Темные Земли", },
	-- [1156] = {icon = "NONE", name = "Пепельный союз", faction = "", other = "Wrath of the Lich King", },
	-- [1012] = {icon = "NONE", name = "Пеплоусты-служители", faction = "", other = "The Burning Crusade", },
	-- [2407] = {icon = "NONE", name = "Перерожденные", faction = "", other = "Темные Земли", },
	-- [990] = {icon = "NONE", name = "Песчаная Чешуя", faction = "", other = "The Burning Crusade", },
	-- [21] = {icon = "NONE", name = "Пиратская Бухта", faction = "", other = "Картель Хитрой Шестеренки", },
	-- [87] = {icon = "NONE", name = "Пираты Кровавого Паруса", faction = "", other = "World of Warcraft", },
	-- [1828] = {icon = "NONE", name = "Племена Крутогорья", faction = "", other = "Legion", },
	-- [1104] = {icon = "NONE", name = "Племя Бешеного Сердца", faction = "", other = "Низина Шолазар", },
	-- [270] = {icon = "NONE", name = "Племя Зандалари", faction = "", other = "World of Warcraft", },
	-- [530] = {icon = "NONE", name = "Племя Черного Копья", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [68] = {icon = "NONE", name = "Подгород", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [2452] = {icon = "NONE", name = "Полемарх Адрест", faction = "", other = "Пепельный двор", },
	-- [1859] = {icon = "NONE", name = "Помраченные", faction = "", other = "Legion", }, -- E.func_texturefromIcon(E.Icon_Horde)
	-- [2469] = {icon = "NONE", name = "Понимание фракталов", faction = "", other = "Темные Земли", },
	-- [2371] = {icon = "NONE", name = "Потасовочная \"У Бизмо\"", faction = "", other = "Силы Альянса", },
	-- [2011] = {icon = "NONE", name = "Потасовочная \"У Бизмо\" (3-й сезон)", faction = "", other = "Силы Альянса", },
	-- [1419] = {icon = "NONE", name = "Потасовочная \"У Бизмо\" (сезон 1)", faction = "", other = "Силы Альянса", },
	-- [1691] = {icon = "NONE", name = "Потасовочная \"У Бизмо\" (сезон 2)", faction = "", other = "Силы Альянса", },
	-- [1124] = {icon = "NONE", name = "Похитители Солнца", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Экспедиция Орды", },
	-- [2388] = {icon = "NONE", name = "Поэн Солежабрик", faction = "", other = "Battle for Azeroth", },
	-- [369] = {icon = "NONE", name = "Прибамбасск", faction = "", other = "Картель Хитрой Шестеренки", },
	-- [934] = {icon = "NONE", name = "Провидцы", faction = "", other = "Город Шаттрат", },
	-- [2478] = {icon = "NONE", name = "Просветленные", faction = "", other = "Темные Земли", },
	-- [2397] = {icon = "NONE", name = "Пчеломатка улья Медокрылов", faction = "", other = "Другое", },
	-- [2415] = {icon = "NONE", name = "Раджани", faction = "", other = "Battle for Azeroth", },
	-- [1173] = {icon = "NONE", name = "Рамкахены", faction = "", other = "Cataclysm", },
	-- [2453] = {icon = "NONE", name = "Рендл и Дуборыл", faction = "", other = "Пепельный двор", },
	-- [2391] = {icon = "NONE", name = "Ржавоболтское сопротивление", faction = "", other = "Battle for Azeroth", },
	-- [910] = {icon = "NONE", name = "Род Ноздорму", faction = "", other = "World of Warcraft", },
	-- [1282] = {icon = "NONE", name = "Рыба Тростниковая Шкура", faction = "", other = "Земледельцы", },
	-- [1302] = {icon = "NONE", name = "Рыболовы", faction = "", other = "Mists of Pandaria", },
	-- [1098] = {icon = "NONE", name = "Рыцари Черного Клинка", faction = "", other = "Wrath of the Lich King", },
	-- [2518] = {icon = "NONE", name = "Сабеллиан", faction = "", other = "Союз Вальдраккена", },
	-- [1106] = {icon = "NONE", name = "Серебряный Авангард", faction = "", other = "Wrath of the Lich King", },
	-- [529] = {icon = "NONE", name = "Серебряный Рассвет", faction = "", other = "World of Warcraft", },
	-- [1094] = {icon = "NONE", name = "Серебряный Союз", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Авангард Альянса", },
	-- [2459] = {icon = "NONE", name = "Сика", faction = "", other = "Пепельный двор", },
	-- [891] = {icon = "NONE", name = "Силы Альянса", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "World of Warcraft", },
	-- [892] = {icon = "NONE", name = "Силы Орды", faction = "", other = "World of Warcraft", },
	-- [70] = {icon = "NONE", name = "Синдикат", faction = "", other = "World of Warcraft", },
	-- [1135] = {icon = "NONE", name = "Служители Земли", faction = "", other = "Cataclysm", },
	-- [2590] = {icon = "NONE", name = "Совет Дорногала", faction = "", other = "The War Within", },
	-- [1731] = {icon = "NONE", name = "Совет экзархов", faction = "", other = "Warlords of Draenor", },
	-- [2553] = {icon = "NONE", name = "Соридорми", faction = "", other = "Союз Вальдраккена", },
	-- [2510] = {icon = "NONE", name = "Союз Вальдраккена", faction = "", other = "Dragonflight", },
	-- [1984] = {icon = "NONE", name = "Спасатели", faction = "", other = "Legion", },
	-- [970] = {icon = "NONE", name = "Спореггар", faction = "", other = "The Burning Crusade", },
	-- [890] = {icon = "NONE", name = "Среброкрылые Часовые", faction = "", other = "Силы Альянса", },
	-- [47] = {icon = "NONE", name = "Стальгорн", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [1276] = {icon = "NONE", name = "Старик Горная Лапа", faction = "", other = "Земледельцы", },
	-- [730] = {icon = "NONE", name = "Стража Грозовой Вершины", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Силы Альянса", },
	-- [1894] = {icon = "NONE", name = "Стражи", faction = "", other = "Legion", },
	-- [1031] = {icon = "NONE", name = "Стражи небес Ша'тар", faction = "", other = "Город Шаттрат", },
	-- [2574] = {icon = "NONE", name = "Стражи Сна", faction = "", other = "Dragonflight", },
	-- [1158] = {icon = "NONE", name = "Стражи Хиджала", faction = "", other = "Cataclysm", },
	-- [1119] = {icon = "NONE", name = "Сыны Ходира", faction = "", other = "Wrath of the Lich King", },
	-- [1064] = {icon = "NONE", name = "Таунка", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Экспедиция Орды", },
	-- [1735] = {icon = "NONE", name = "Телохранители из казарм", faction = "", other = "Warlords of Draenor", },
	-- [2414] = {icon = "NONE", name = "Темные Земли", faction = "", other = "Другое", },
	-- [2523] = {icon = "NONE", name = "Темные Когти", faction = E.func_texturefromIcon(E.Icon_Horde), other = "Орда", },
	-- [1171] = {icon = "NONE", name = "Теразан", faction = "", other = "Cataclysm", },
	-- [949] = {icon = "NONE", name = "Тестовая фракция 1", faction = "", other = "Другое", },
	-- [948] = {icon = "NONE", name = "Тестовая фракция 2", faction = "", other = "Тестовая фракция 1", },
	-- [1280] = {icon = "NONE", name = "Тина Грязный Коготь", faction = "", other = "Земледельцы", },
	-- [1883] = {icon = "NONE", name = "Ткачи Снов", faction = "", other = "Legion", },
	-- [1736] = {icon = "NONE", name = "Тормок", faction = "", other = "Телохранители из казарм", },
	-- [2163] = {icon = "NONE", name = "Тортолланские искатели", faction = "", other = "Battle for Azeroth", },
	-- [947] = {icon = "NONE", name = "Траллмар", faction = "", other = "The Burning Crusade", },
	-- [922] = {icon = "NONE", name = "Транквиллион", faction = "", other = "The Burning Crusade", },
	-- [2396] = {icon = "NONE", name = "Трутень из улья Медокрылов", faction = "", other = "Другое", },
	-- [589] = {icon = "NONE", name = "Укротители ледопардов", faction = "", other = "World of Warcraft", },
	-- [2395] = {icon = "NONE", name = "Улей Медокрылов", faction = "", other = "Battle for Azeroth", },
	-- [2417] = {icon = "NONE", name = "Ульдумский союз", faction = "", other = "Battle for Azeroth", },
	-- [1283] = {icon = "NONE", name = "Фермер Фун", faction = "", other = "Земледельцы", },
	-- [2398] = {icon = "NONE", name = "Фуражир из улья Медокрылов", faction = "", other = "Другое", },
	-- [2526] = {icon = "NONE", name = "Фурболги из клана Зимней Шкуры", faction = "", other = "Dragonflight", },
	-- [1279] = {icon = "NONE", name = "Хаохань Грязный Коготь", faction = "", other = "Земледельцы", },
	-- [1204] = {icon = "NONE", name = "Хиджальские мстители", faction = "", other = "Cataclysm", },
	-- [1351] = {icon = "NONE", name = "Хмелевары", faction = "", other = "Mists of Pandaria", },
	-- [989] = {icon = "NONE", name = "Хранители Времени", faction = "", other = "The Burning Crusade", },
	-- [1345] = {icon = "NONE", name = "Хранители истории", faction = "", other = "Mists of Pandaria", },
	-- [2455] = {icon = "NONE", name = "Хранитель склепа Каззир", faction = "", other = "Пепельный двор", },
	-- [2098] = {icon = 236575, name = "Хранительница Рейна", faction = "", other = "Legion", },
	-- [2135] = {icon = "NONE", name = "Хроми", faction = "", other = "Legion", },
	-- [1242] = {icon = "NONE", name = "Цзинь-юй Жемчужного Плавника", faction = "", other = "Mists of Pandaria", },
	-- [349] = {icon = "NONE", name = "Черный Ворон", faction = "", other = "World of Warcraft", },
	-- [1359] = {icon = "NONE", name = "Черный принц", faction = "", other = "Mists of Pandaria", },
	-- [2463] = {icon = "NONE", name = "Чесночник", faction = "", other = "Темные Земли", },
	-- [1277] = {icon = "NONE", name = "Чи-Чи", faction = "", other = "Земледельцы", },
	-- [2454] = {icon = "NONE", name = "Чуфа", faction = "", other = "Пепельный двор", },
	-- [2101] = {icon = 236575, name = "Ша'лет", faction = "", other = "Legion", },
	-- [935] = {icon = "NONE", name = "Ша'тар", faction = "", other = "Город Шаттрат", },
	-- [1270] = {icon = "NONE", name = "Шадо-Пан", faction = "", other = "Mists of Pandaria", },
	-- [809] = {icon = "NONE", name = "Шен'дралар", faction = "", other = "World of Warcraft", },
	-- [1278] = {icon = "NONE", name = "Шо", faction = "", other = "Земледельцы", },
	-- [2462] = {icon = "NONE", name = "Штопальщики", faction = "", other = "Темные Земли", },
	-- [72] = {icon = "NONE", name = "Штормград", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [930] = {icon = "NONE", name = "Экзодар", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Альянс", },
	-- [1052] = {icon = "NONE", name = "Экспедиция Орды", faction = "", other = "Wrath of the Lich King", },
	-- [1050] = {icon = "NONE", name = "Экспедиция Отважных", faction = E.func_texturefromIcon(E.Icon_Alliance), other = "Авангард Альянса", },
	-- [2156] = {icon = "NONE", name = "Экспедиция Таланджи", faction = "", other = "Battle for Azeroth", },
	-- [1275] = {icon = "NONE", name = "Элла", faction = "", other = "Земледельцы", },
	-- [1888] = {icon = "NONE", name = "Яндвикские врайкулы", faction = "", other = "Legion", },
	-- [909] = {icon = "NONE", name = "Ярмарка Новолуния", faction = "", other = "World of Warcraft", },
	-- [2693] = {icon = "NONE", name = "Путь участника вылазки (1-й сезон)", faction = "", other = "The War Within", },
	-- [2653] = {icon = "NONE", name = "Картели Нижней Шахты", faction = "", other = "The War Within", },
	-- [2645] = {icon = "NONE", name = "Земельники", faction = "", other = "Совет Дорногала", },
	-- [2669] = {icon = "NONE", name = "Мрачные Решалы", faction = "", other = "Картели Нижней Шахт", },
	-- [2685] = {icon = "NONE", name = "Клуб лояльности Галаджио", faction = "", other = "Картели Нижней Шахт", },
	-- [2673] = {icon = "NONE", name = "Картель Трюмных Вод", faction = "", other = "Картели Нижней Шахты", },
	-- [2677] = {icon = "NONE", name = "Картель Хитрой Шестеренки", faction = "", other = "Картели Нижней Шахты", },
	-- [2675] = {icon = "NONE", name = "Картель Черноводья", faction = "", other = "Картели Нижней Шахты", },
	-- [2671] = {icon = "NONE", name = "Торговая компания", faction = "", other = "Картели Нижней Шахты", },
	-- [2601] = {icon = "NONE", name = "Прядильщица", faction = "", other = "Отрезанные нити", },
	-- [2607] = {icon = "NONE", name = "Визирь", faction = "", other = "Отрезанные нити", },
	-- [2605] = {icon = "NONE", name = "Генерал", faction = "", other = "Отрезанные нити", },




	-- [2695] = {icon = "NONE", name = "Test Account Wide Stormwind (DNT)", faction = "", other = "", },
	-- [2684] = {icon = "NONE", name = "Клуб лояльности Галаджио (идеал)", faction = "", other = "", },
	-- [2683] = {icon = "NONE", name = "Вылазки: 2-й сезон", faction = "", other = "", },
	-- [2676] = {icon = "NONE", name = "Картель Хитрой Шестеренки (идеал)", faction = "", other = "", },
	-- [2674] = {icon = "NONE", name = "Картель Черноводья (идеал)", faction = "", other = "", },
	-- [2672] = {icon = "NONE", name = "Картель Трюмных Вод (идеал)", faction = "", other = "", },
	-- [2670] = {icon = "NONE", name = "Торговая компания (идеал)", faction = "", other = "", },
	-- [2668] = {icon = "NONE", name = "Мрачные Решалы (идеал)", faction = "", other = "", },
	-- [2667] = {icon = "NONE", name = "Картели Нижней Шахты (идеал)", faction = "", other = "", },
	-- [2649] = {icon = "NONE", name = "Генерал (идеал)", faction = "", other = "", },
	-- [2648] = {icon = "NONE", name = "Прядильщица (идеал)", faction = "", other = "", },
	-- [2647] = {icon = "NONE", name = "Визирь (идеал)", faction = "", other = "", },
	-- [2613] = {icon = "NONE", name = "Ассамблея глубин (идеал)", faction = "", other = "", },
	-- [2612] = {icon = "NONE", name = "Совет Дорногала (идеал)", faction = "", other = "", },
	-- [2611] = {icon = "NONE", name = "Арати Тайносводья (идеал)", faction = "", other = "", },
	-- [2604] = {icon = "NONE", name = "Команда Бочконога (идеал)", faction = "", other = "", },
	-- [2596] = {icon = "NONE", name = "Отрезанные нити (идеал)", faction = "", other = "", },
	-- [2575] = {icon = "NONE", name = "Стражи Сна (идеал)", faction = "", other = "", },
	-- [2565] = {icon = "NONE", name = "Лоаммские ниффы (идеал)", faction = "", other = "", },
	-- [2552] = {icon = "NONE", name = "Союз Вальдраккена (идеал)", faction = "", other = "", },
	-- [2551] = {icon = "NONE", name = "Искарские клыкарры (идеал)", faction = "", other = "", },
	-- [2521] = {icon = "NONE", name = "Клан Нокуд (идеал)", faction = "", other = "", },
	-- [2508] = {icon = "NONE", name = "Драконья экспедиция (идеал)", faction = "", other = "", },
	-- [2504] = {icon = "NONE", name = "Кентавры Маруук (идеал)", faction = "", other = "", },
	-- [2479] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2474] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2473] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2471] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2444] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2442] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2441] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2440] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2418] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2416] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2401] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2392] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2387] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2386] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2385] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2384] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2383] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2382] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2381] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2380] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2379] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2378] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2374] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2167] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2166] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2091] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2090] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2089] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2088] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2087] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2086] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2085] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },
	-- [2063] = {icon = "NONE", name = "ЙЦУЙЦУ", faction = "", other = "", },




	[2697] = {name = "Chase's test faction (DNT)", side = "-", category = "Другое", }, --[faction=2697]
	[2695] = {name = "Test Account Wide Stormwind (DNT)", side = "Альянс", category = "Альянс", }, --[faction=2695]
	[2693] = {name = "Путь участника вылазки (1-й сезон)", side = "-", category = "The War Within", }, --[faction=2693]
	[2685] = {name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
	[2684] = {name = "Клуб лояльности Галаджио (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2684]
	[2683] = {name = "Вылазки: 2-й сезон", side = "-", category = "The War Within", }, --[faction=2683]
	[2677] = {name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
	[2676] = {name = "Картель Хитрой Шестеренки (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2676]
	[2675] = {name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
	[2674] = {name = "Картель Черноводья (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2674]
	[2673] = {name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
	[2672] = {name = "Картель Трюмных Вод (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2672]
	[2671] = {name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
	[2670] = {name = "Торговая компания (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2670]
	[2669] = {name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]
	[2668] = {name = "Мрачные Решалы (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2668]
	[2667] = {name = "Картели Нижней Шахты (идеал)", side = "-", category = "The War Within", }, --[faction=2667]
	[2653] = {name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
	[2649] = {name = "Генерал (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2649]
	[2648] = {name = "Прядильщица (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2648]
	[2647] = {name = "Визирь (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2647]
	[2645] = {name = "Земельники", side = "-", category = "Совет Дорногала", }, --[faction=2645]
	[2644] = {name = "Вылазки: 1-й сезон", side = "-", category = "The War Within", }, --[faction=2644]
	[2640] = {name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
	[2615] = {name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
	[2613] = {name = "Ассамблея глубин (идеал)", side = "-", category = "The War Within", }, --[faction=2613]
	[2612] = {name = "Совет Дорногала (идеал)", side = "-", category = "The War Within", }, --[faction=2612]
	[2611] = {name = "Арати Тайносводья (идеал)", side = "-", category = "The War Within", }, --[faction=2611]
	[2607] = {name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
	[2605] = {name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
	[2604] = {name = "Команда Бочконога (идеал)", side = "-", category = "Другое", }, --[faction=2604]
	[2601] = {name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
	[2600] = {name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
	[2596] = {name = "Отрезанные нити (идеал)", side = "-", category = "The War Within", }, --[faction=2596]
	[2594] = {name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
	[2593] = {name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
	[2590] = {name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
	[2575] = {name = "Стражи Сна (идеал)", side = "-", category = "Dragonflight", }, --[faction=2575]
	[2574] = {name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
	[2570] = {name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
	[2569] = {name = "The War Within", side = "-", category = "Другое", }, --[faction=2569]
	[2568] = {name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
	[2565] = {name = "Лоаммские ниффы (идеал)", side = "-", category = "Dragonflight", }, --[faction=2565]
	[2564] = {name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
	[2555] = {name = "Клан Кейган", side = "-", category = "Dragonflight", }, --[faction=2555]
	[2554] = {name = "Клан Тогус", side = "-", category = "Кентавры Маруук", }, --[faction=2554]
	[2553] = {name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
	[2552] = {name = "Союз Вальдраккена (идеал)", side = "-", category = "Dragonflight", }, --[faction=2552]
	[2551] = {name = "Искарские клыкарры (идеал)", side = "-", category = "Dragonflight", }, --[faction=2551]
	[2550] = {name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
	[2544] = {name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
	[2542] = {name = "Клан Укхел", side = "-", category = "Dragonflight", }, --[faction=2542]
	[2526] = {name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
	[2524] = {name = "Обсидиановые Хранители", side = "Альянс", category = "Альянс", }, --[faction=2524]
	[2523] = {name = "Темные Когти", side = "Орда", category = "Орда", }, --[faction=2523]
	[2522] = {name = "Клан Тирай", side = "-", category = "Кентавры Маруук", }, --[faction=2522]
	[2521] = {name = "Клан Нокуд (идеал)", side = "-", category = "Dragonflight", }, --[faction=2521]
	[2520] = {name = "Клан Нокхуд", side = "-", category = "Dragonflight", }, --[faction=2520]
	[2518] = {name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
	[2517] = {name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
	[2513] = {name = "Клан Он'ир", side = "-", category = "Кентавры Маруук", }, --[faction=2513]
	[2512] = {name = "Клан Айлааг", side = "-", category = "Кентавры Маруук", }, --[faction=2512]
	[2511] = {name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
	[2510] = {name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
	[2509] = {name = "Клан Шикаар", side = "-", category = "Кентавры Маруук", }, --[faction=2509]
	[2508] = {name = "Драконья экспедиция (идеал)", side = "-", category = "Dragonflight", }, --[faction=2508]
	[2507] = {name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
	[2506] = {name = "Dragonflight", side = "-", category = "Другое", }, --[faction=2506]
	[2504] = {name = "Кентавры Маруук (идеал)", side = "-", category = "Dragonflight", }, --[faction=2504]
	[2503] = {name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
	[2479] = {name = "Просветленные (идеал)", side = "-", category = "Темные Земли", }, --[faction=2479]
	[2478] = {name = "Просветленные", side = "-", category = "Темные Земли", }, --[faction=2478]
	[2474] = {name = "Ве'нари (идеал)", side = "-", category = "Темные Земли", }, --[faction=2474]
	[2473] = {name = "Кодекс архивариуса (идеал)", side = "-", category = "Темные Земли", }, --[faction=2473]
	[2472] = {name = "Кодекс архивариуса", side = "-", category = "Темные Земли", }, --[faction=2472]
	[2471] = {name = "Легион Смерти (идеал)", side = "-", category = "Темные Земли", }, --[faction=2471]
	[2470] = {name = "Легион Смерти", side = "-", category = "Темные Земли", }, --[faction=2470]
	[2469] = {name = "Понимание фракталов", side = "-", category = "Темные Земли", }, --[faction=2469]
	[2465] = {name = "Дикая Охота", side = "-", category = "Темные Земли", }, --[faction=2465]
	[2464] = {name = "Двор Ночи", side = "-", category = "Темные Земли", }, --[faction=2464]
	[2463] = {name = "Чесночник", side = "-", category = "Темные Земли", }, --[faction=2463]
	[2462] = {name = "Штопальщики", side = "-", category = "Темные Земли", }, --[faction=2462]
	[2461] = {name = "Изобретатель чумы Марилет", side = "-", category = "Пепельный двор", }, --[faction=2461]
	[2460] = {name = "Камнелоб", side = "-", category = "Пепельный двор", }, --[faction=2460]
	[2459] = {name = "Сика", side = "-", category = "Пепельный двор", }, --[faction=2459]
	[2458] = {name = "Клейя и Пелагий", side = "-", category = "Пепельный двор", }, --[faction=2458]
	[2457] = {name = "Великий мастер Воул", side = "-", category = "Пепельный двор", }, --[faction=2457]
	[2456] = {name = "Дроман Алиот", side = "-", category = "Пепельный двор", }, --[faction=2456]
	[2455] = {name = "Хранитель склепа Каззир", side = "-", category = "Пепельный двор", }, --[faction=2455]
	[2454] = {name = "Чуфа", side = "-", category = "Пепельный двор", }, --[faction=2454]
	[2453] = {name = "Рендл и Дуборыл", side = "-", category = "Пепельный двор", }, --[faction=2453]
	[2452] = {name = "Полемарх Адрест", side = "-", category = "Пепельный двор", }, --[faction=2452]
	[2451] = {name = "Капитан-егерь Корейн", side = "-", category = "Пепельный двор", }, --[faction=2451]
	[2450] = {name = "Александрос Могрейн", side = "-", category = "Пепельный двор", }, --[faction=2450]
	[2449] = {name = "Графиня", side = "-", category = "Пепельный двор", }, --[faction=2449]
	[2448] = {name = "Миканикос", side = "-", category = "Пепельный двор", }, --[faction=2448]
	[2447] = {name = "Леди Лунная Ягода", side = "-", category = "Пепельный двор", }, --[faction=2447]
	[2446] = {name = "Баронесса Вайш", side = "-", category = "Пепельный двор", }, --[faction=2446]
	[2445] = {name = "Пепельный двор", side = "-", category = "Темные Земли", }, --[faction=2445]
	[2444] = {name = "Дикая Охота (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2444]
	[2442] = {name = "Двор Жнецов (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2442]
	[2441] = {name = "Перерожденные (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2441]
	[2440] = {name = "Неумирающая армия (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2440]
	[2439] = {name = "Нераскаявшиеся", side = "-", category = "Темные Земли", }, --[faction=2439]
	[2432] = {name = "Ве'нари", side = "-", category = "Темные Земли", }, --[faction=2432]
	[2431] = {name = "Owen Test", side = "-", category = "Другое", }, --[faction=2431]
	[2427] = {name = "Молодой акир", side = "-", category = "Battle for Azeroth", }, --[faction=2427]
	[2422] = {name = "Ночной народец", side = "-", category = "Дикая Охота", }, --[faction=2422]
	[2418] = {name = "Ульдумский союз (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2418]
	[2417] = {name = "Ульдумский союз", side = "-", category = "Battle for Azeroth", }, --[faction=2417]
	[2416] = {name = "Раджани (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2416]
	[2415] = {name = "Раджани", side = "-", category = "Battle for Azeroth", }, --[faction=2415]
	[2414] = {name = "Темные Земли", side = "-", category = "Другое", }, --[faction=2414]
	[2413] = {name = "Двор Жнецов", side = "-", category = "Темные Земли", }, --[faction=2413]
	[2410] = {name = "Неумирающая армия", side = "-", category = "Темные Земли", }, --[faction=2410]
	[2407] = {name = "Перерожденные", side = "-", category = "Темные Земли", }, --[faction=2407]
	[2401] = {name = "Анкоа из клана Клинков Волн (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2401]
	[2400] = {name = "Клинки Волн", side = "-", category = "Battle for Azeroth", }, --[faction=2400]
	[2398] = {name = "Фуражир из улья Медокрылов", side = "-", category = "Другое", }, --[faction=2398]
	[2397] = {name = "Пчеломатка улья Медокрылов", side = "-", category = "Другое", }, --[faction=2397]
	[2396] = {name = "Трутень из улья Медокрылов", side = "-", category = "Другое", }, --[faction=2396]
	[2395] = {name = "Улей Медокрылов", side = "-", category = "Battle for Azeroth", }, --[faction=2395]
	[2392] = {name = "Ржавоболтское сопротивление (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2392]
	[2391] = {name = "Ржавоболтское сопротивление", side = "-", category = "Battle for Azeroth", }, --[faction=2391]
	[2390] = {name = "Вим Соленодух", side = "-", category = "Battle for Azeroth", }, --[faction=2390]
	[2389] = {name = "Нери Остроерш", side = "-", category = "Battle for Azeroth", }, --[faction=2389]
	[2388] = {name = "Поэн Солежабрик", side = "-", category = "Battle for Azeroth", }, --[faction=2388]
	[2387] = {name = "Тортолланские искатели (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2387]
	[2386] = {name = "Защитники Азерот (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2386]
	[2385] = {name = "Армия Чести (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2385]
	[2384] = {name = "7-й легион (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2384]
	[2383] = {name = "Орден Пылающих Углей (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2383]
	[2382] = {name = "Жители Вол'дуна (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2382]
	[2381] = {name = "Орден Возрождения Шторма (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2381]
	[2380] = {name = "Экспедиция Таланджи (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2380]
	[2379] = {name = "Адмиралтейство Праудмуров (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2379]
	[2378] = {name = "Империя Зандалари (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2378]
	[2377] = {name = "Мастер клинка Иновари", side = "-", category = "Battle for Azeroth", }, --[faction=2377]
	[2376] = {name = "Оракул Ори", side = "-", category = "Battle for Azeroth", }, --[faction=2376]
	[2375] = {name = "Мастер охоты Акана", side = "-", category = "Battle for Azeroth", }, --[faction=2375]
	[2374] = {name = "Освобожденные (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2374]
	[2373] = {name = "Освобожденные", side = "-", category = "Battle for Azeroth", }, --[faction=2373]
	[2372] = {name = "Арена \"Морд'Бой\"", side = "-", category = "Силы Орды", }, --[faction=2372]
	[2371] = {name = "Потасовочная \"У Бизмо\"", side = "-", category = "Силы Альянса", }, --[faction=2371]
	[2370] = {name = "Обучение динозавров – Дикорог", side = "-", category = "Battle for Azeroth", }, --[faction=2370]
	[2265] = {name = "Кул-Тирас - долина Штормов", side = "-", category = "Орден Возрождения Шторма", }, --[faction=2265]
	[2264] = {name = "Кул-Тирас - Друствар", side = "-", category = "Орден Пылающих Углей", }, --[faction=2264]
	[2233] = {name = "Dino Training - Pterrodax", side = "-", category = "Battle for Azeroth", }, --[faction=2233]
	[2170] = {name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
	[2167] = {name = "Защитники Аргуса (идеал)", side = "-", category = "Другое", }, --[faction=2167]
	[2166] = {name = "Армия Света (идеал)", side = "-", category = "Legion", }, --[faction=2166]
	[2165] = {name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
	[2164] = {name = "Защитники Азерот", side = "-", category = "Battle for Azeroth", }, --[faction=2164]
	[2163] = {name = "Тортолланские искатели", side = "-", category = "Battle for Azeroth", }, --[faction=2163]
	[2162] = {name = "Орден Возрождения Шторма", side = "-", category = "Battle for Azeroth", }, --[faction=2162]
	[2161] = {name = "Орден Пылающих Углей", side = "-", category = "Battle for Azeroth", }, --[faction=2161]
	[2160] = {name = "Адмиралтейство Праудмуров", side = "Альянс", category = "Battle for Azeroth", }, --[faction=2160]
	[2159] = {name = "7-й легион", side = "-", category = "Battle for Azeroth", }, --[faction=2159]
	[2158] = {name = "Жители Вол'дуна", side = "Орда", category = "Battle for Azeroth", }, --[faction=2158]
	[2157] = {name = "Армия Чести", side = "-", category = "Battle for Azeroth", }, --[faction=2157]
	[2156] = {name = "Экспедиция Таланджи", side = "-", category = "Battle for Azeroth", }, --[faction=2156]
	[2135] = {name = "Хроми", side = "-", category = "Legion", }, --[faction=2135]
	[2120] = {name = "Кул-Тирас - Тирагард", side = "Альянс", category = "Адмиралтейство Праудмуров", }, --[faction=2120]
	[2111] = {name = "Зандаларские динозавры", side = "-", category = "Battle for Azeroth", }, --[faction=2111]
	[2104] = {name = "Battle for Azeroth", side = "-", category = "Другое", }, --[faction=2104]
	[2103] = {name = "Империя Зандалари", side = "Орда", category = "Battle for Azeroth", }, --[faction=2103]
	[2102] = {name = "Бесс", side = "-", category = "Legion", }, --[faction=2102]
	[2101] = {name = "Ша'лет", side = "-", category = "Legion", }, --[faction=2101]
	[2100] = {name = "Корбин", side = "-", category = "Legion", }, --[faction=2100]
	[2099] = {name = "Акуле Речной Рог", side = "-", category = "Legion", }, --[faction=2099]
	[2098] = {name = "Хранительница Рейна", side = "-", category = "Legion", }, --[faction=2098]
	[2097] = {name = "Илиссия Водная", side = "-", category = "Legion", }, --[faction=2097]
	[2091] = {name = "Армия погибели Легиона (идеал)", side = "-", category = "Legion", }, --[faction=2091]
	[2090] = {name = "Стражи (идеал)", side = "-", category = "Legion", }, --[faction=2090]
	[2089] = {name = "Помраченные (идеал)", side = "-", category = "Legion", }, --[faction=2089]
	[2088] = {name = "Ткачи Снов (идеал)", side = "-", category = "Legion", }, --[faction=2088]
	[2087] = {name = "Двор Фарондиса (идеал)", side = "-", category = "Legion", }, --[faction=2087]
	[2086] = {name = "Валарьяры (идеал)", side = "-", category = "Legion", }, --[faction=2086]
	[2085] = {name = "Племена Крутогорья (идеал)", side = "-", category = "Legion", }, --[faction=2085]
	[2063] = {name = "Arne Test - Paragon Reputation Stormwind", side = "-", category = "Другое", }, --[faction=2063]
	[2045] = {name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]
	[2018] = {name = "Отмщение Когтя", side = "-", category = "Legion", }, --[faction=2018]
	[2011] = {name = "Потасовочная \"У Бизмо\" (3-й сезон)", side = "-", category = "Силы Альянса", }, --[faction=2011]
	[2010] = {name = "Арена \"Морд'Бой\" (3-й сезон)", side = "-", category = "Силы Орды", }, --[faction=2010]
	[1989] = {name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1989]
	[1984] = {name = "Спасатели", side = "-", category = "Legion", }, --[faction=1984]
	[1975] = {name = "Кудесник Маргосс", side = "-", category = "Legion", }, --[faction=1975]
	[1948] = {name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]
	[1947] = {name = "Иллидари", side = "-", category = "Legion", }, --[faction=1947]
	[1919] = {name = "Жажда магии Вальтруа", side = "-", category = "Помраченные", }, --[faction=1919]
	[1900] = {name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
	[1899] = {name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1899]
	[1894] = {name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
	[1888] = {name = "Яндвикские врайкулы", side = "-", category = "Legion", }, --[faction=1888]
	[1883] = {name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
	[1862] = {name = "Жажда магии Окулета", side = "-", category = "Помраченные", }, --[faction=1862]
	[1861] = {name = "Arcane Thirst (Silgryn) DEPRECATED", side = "-", category = "Помраченные", }, --[faction=1861]
	[1860] = {name = "Жажда магии Талисры", side = "-", category = "Помраченные", }, --[faction=1860]
	[1859] = {name = "Помраченные", side = "Орда", category = "Legion", }, --[faction=1859]
	[1850] = {name = "Охотники за саблеронами", side = "-", category = "Warlords of Draenor", }, --[faction=1850]
	[1849] = {name = "Орден Пробудившихся", side = "-", category = "Warlords of Draenor", }, --[faction=1849]
	[1848] = {name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848]
	[1847] = {name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847]
	[1834] = {name = "Legion", side = "-", category = "Другое", }, --[faction=1834]
	[1828] = {name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
	[1815] = {name = "Выжившие из Гилнеаса", side = "-", category = "Legion", }, --[faction=1815]
	[1741] = {name = "Леорадж", side = "-", category = "Телохранители из казарм", }, --[faction=1741]
	[1740] = {name = "Аеда Ясная Заря", side = "-", category = "Телохранители из казарм", }, --[faction=1740]
	[1739] = {name = "Вивианна", side = "-", category = "Телохранители из казарм", }, --[faction=1739]
	[1738] = {name = "Защитница Иллона", side = "-", category = "Телохранители из казарм", }, --[faction=1738]
	[1737] = {name = "Жрец Когтя Ишааль", side = "-", category = "Телохранители из казарм", }, --[faction=1737]
	[1736] = {name = "Тормок", side = "-", category = "Телохранители из казарм", }, --[faction=1736]
	[1735] = {name = "Телохранители из казарм", side = "-", category = "Warlords of Draenor", }, --[faction=1735]
	[1733] = {name = "Делвар Железный Кулак", side = "-", category = "Телохранители из казарм", }, --[faction=1733]
	[1732] = {name = "Дренорcкая Экспедиция Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1732]
	[1731] = {name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731]
	[1711] = {name = "Археологическое общество Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1711]
	[1710] = {name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710]
	[1708] = {name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708]
	[1691] = {name = "Потасовочная \"У Бизмо\" (сезон 2)", side = "-", category = "Силы Альянса", }, --[faction=1691]
	[1690] = {name = "Арена \"Морд'Бой\" (сезон 2)", side = "-", category = "Силы Орды", }, --[faction=1690]
	[1682] = {name = "Авангард Ринна", side = "-", category = "Силы Альянса", }, --[faction=1682]
	[1681] = {name = "Копье Вол'джина", side = "-", category = "Силы Орды", }, --[faction=1681]
	[1520] = {name = "Изгнанники клана Призрачной Луны", side = "-", category = "Warlords of Draenor", }, --[faction=1520]
	[1515] = {name = "Араккоа-изгои", side = "-", category = "Warlords of Draenor", }, --[faction=1515]
	[1492] = {name = "Император Шаохао", side = "-", category = "Mists of Pandaria", }, --[faction=1492]
	[1445] = {name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445]
	[1444] = {name = "Warlords of Draenor", side = "-", category = "Другое", }, --[faction=1444]
	[1440] = {name = "Восстание Черного Копья", side = "-", category = "Mists of Pandaria", }, --[faction=1440]
	[1435] = {name = "Натиск Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1435]
	[1419] = {name = "Потасовочная \"У Бизмо\" (сезон 1)", side = "-", category = "Силы Альянса", }, --[faction=1419]
	[1388] = {name = "Войска Похитителей Солнца", side = "-", category = "Mists of Pandaria", }, --[faction=1388]
	[1387] = {name = "Армия Кирин-Тора", side = "-", category = "Mists of Pandaria", }, --[faction=1387]
	[1376] = {name = "Операция \"Заслон\"", side = "-", category = "Mists of Pandaria", }, --[faction=1376]
	[1375] = {name = "Армия Покорителей", side = "-", category = "Mists of Pandaria", }, --[faction=1375]
	[1374] = {name = "Арена \"Морд'Бой\" (сезон 1)", side = "-", category = "Силы Орды", }, --[faction=1374]
	[1359] = {name = "Черный принц", side = "-", category = "Mists of Pandaria", }, --[faction=1359]
	[1358] = {name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
	[1357] = {name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
	[1353] = {name = "Пандарены Тушуй", side = "Альянс", category = "Альянс", }, --[faction=1353]
	[1352] = {name = "Пандарены Хоцзинь", side = "-", category = "Орда", }, --[faction=1352]
	[1351] = {name = "Хмелевары", side = "-", category = "Mists of Pandaria", }, --[faction=1351]
	[1345] = {name = "Хранители истории", side = "-", category = "Mists of Pandaria", }, --[faction=1345]
	[1341] = {name = "Небожители", side = "-", category = "Mists of Pandaria", }, --[faction=1341]
	[1337] = {name = "Клакси", side = "-", category = "Mists of Pandaria", }, --[faction=1337]
	[1302] = {name = "Рыболовы", side = "-", category = "Mists of Pandaria", }, --[faction=1302]
	[1283] = {name = "Фермер Фун", side = "-", category = "Земледельцы", }, --[faction=1283]
	[1282] = {name = "Рыба Тростниковая Шкура", side = "-", category = "Земледельцы", }, --[faction=1282]
	[1281] = {name = "Джина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1281]
	[1280] = {name = "Тина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1280]
	[1279] = {name = "Хаохань Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1279]
	[1278] = {name = "Шо", side = "-", category = "Земледельцы", }, --[faction=1278]
	[1277] = {name = "Чи-Чи", side = "-", category = "Земледельцы", }, --[faction=1277]
	[1276] = {name = "Старик Горная Лапа", side = "-", category = "Земледельцы", }, --[faction=1276]
	[1275] = {name = "Элла", side = "-", category = "Земледельцы", }, --[faction=1275]
	[1273] = {name = "Йогу Пьяный", side = "-", category = "Земледельцы", }, --[faction=1273]
	[1272] = {name = "Земледельцы", side = "-", category = "Mists of Pandaria", }, --[faction=1272]
	[1271] = {name = "Орден Облачного Змея", side = "-", category = "Mists of Pandaria", }, --[faction=1271]
	[1270] = {name = "Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1270]
	[1269] = {name = "Золотой Лотос", side = "-", category = "Mists of Pandaria", }, --[faction=1269]
	[1245] = {name = "Mists of Pandaria", side = "-", category = "Другое", }, --[faction=1245]
	[1242] = {name = "Цзинь-юй Жемчужного Плавника", side = "-", category = "Mists of Pandaria", }, --[faction=1242]
	[1228] = {name = "Лесные хозены", side = "-", category = "Mists of Pandaria", }, --[faction=1228]
	[1216] = {name = "Академия Шан Си", side = "-", category = "Mists of Pandaria", }, --[faction=1216]
	[1204] = {name = "Хиджальские мстители", side = "-", category = "Cataclysm", }, --[faction=1204]
	[1178] = {name = "Батальон Адского Крика", side = "-", category = "Cataclysm", }, --[faction=1178]
	[1177] = {name = "Защитники Тол Барада", side = "-", category = "Cataclysm", }, --[faction=1177]
	[1174] = {name = "Клан Громового Молота", side = "-", category = "Cataclysm", }, --[faction=1174]
	[1173] = {name = "Рамкахены", side = "-", category = "Cataclysm", }, --[faction=1173]
	[1172] = {name = "Клан Драконьей Пасти", side = "-", category = "Cataclysm", }, --[faction=1172]
	[1171] = {name = "Теразан", side = "-", category = "Cataclysm", }, --[faction=1171]
	[1169] = {name = "Гильдия", side = "-", category = "Другое", }, --[faction=1169]
	[1168] = {name = "Гильдия", side = "-", category = "Гильдия", }, --[faction=1168]
	[1162] = {name = "Cataclysm", side = "-", category = "Другое", }, --[faction=1162]
	[1158] = {name = "Стражи Хиджала", side = "-", category = "Cataclysm", }, --[faction=1158]
	[1156] = {name = "Пепельный союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1156]
	[1135] = {name = "Служители Земли", side = "-", category = "Cataclysm", }, --[faction=1135]
	[1134] = {name = "Гилнеас", side = "Альянс", category = "Альянс", }, --[faction=1134]
	[1133] = {name = "Картель Трюмных Вод", side = "-", category = "Орда", }, --[faction=1133]
	[1126] = {name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
	[1124] = {name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
	[1119] = {name = "Сыны Ходира", side = "-", category = "Wrath of the Lich King", }, --[faction=1119]
	[1118] = {name = "World of Warcraft", side = "-", category = "Другое", }, --[faction=1118]
	[1117] = {name = "Низина Шолазар", side = "-", category = "Wrath of the Lich King", }, --[faction=1117]
	[1106] = {name = "Серебряный Авангард", side = "-", category = "Wrath of the Lich King", }, --[faction=1106]
	[1105] = {name = "Оракулы", side = "-", category = "Низина Шолазар", }, --[faction=1105]
	[1104] = {name = "Племя Бешеного Сердца", side = "-", category = "Низина Шолазар", }, --[faction=1104]
	[1098] = {name = "Рыцари Черного Клинка", side = "-", category = "Wrath of the Lich King", }, --[faction=1098]
	[1097] = {name = "Wrath of the Lich King", side = "-", category = "Другое", }, --[faction=1097]
	[1094] = {name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
	[1091] = {name = "Драконий союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1091]
	[1090] = {name = "Кирин-Тор", side = "-", category = "Wrath of the Lich King", }, --[faction=1090]
	[1085] = {name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
	[1077] = {name = "Армия Расколотого Солнца", side = "-", category = "Город Шаттрат", }, --[faction=1077]
	[1073] = {name = "Калу'ак", side = "-", category = "Wrath of the Lich King", }, --[faction=1073]
	[1072] = {name = "[DNT] AC Major Faction Child Renown Test", side = "-", category = "Кентавры Маруук", }, --[faction=1072]
	[1068] = {name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
	[1067] = {name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
	[1064] = {name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
	[1052] = {name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052]
	[1050] = {name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	[1038] = {name = "Огри'ла", side = "-", category = "The Burning Crusade", }, --[faction=1038]
	[1037] = {name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037]
	[1031] = {name = "Стражи небес Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=1031]
	[1015] = {name = "Крылья Пустоты", side = "-", category = "The Burning Crusade", }, --[faction=1015]
	[1012] = {name = "Пеплоусты-служители", side = "-", category = "The Burning Crusade", }, --[faction=1012]
	[1011] = {name = "Нижний Город", side = "-", category = "Город Шаттрат", }, --[faction=1011]
	[990] = {name = "Песчаная Чешуя", side = "-", category = "The Burning Crusade", }, --[faction=990]
	[989] = {name = "Хранители Времени", side = "-", category = "The Burning Crusade", }, --[faction=989]
	[980] = {name = "The Burning Crusade", side = "-", category = "Другое", }, --[faction=980]
	[978] = {name = "Куренай", side = "-", category = "The Burning Crusade", }, --[faction=978]
	[970] = {name = "Спореггар", side = "-", category = "The Burning Crusade", }, --[faction=970]
	[967] = {name = "Аметистовое Око", side = "-", category = "The Burning Crusade", }, --[faction=967]
	[949] = {name = "Тестовая фракция 1", side = "-", category = "Другое", }, --[faction=949]
	[948] = {name = "Тестовая фракция 2", side = "-", category = "Тестовая фракция 1", }, --[faction=948]
	[947] = {name = "Траллмар", side = "-", category = "The Burning Crusade", }, --[faction=947]
	[946] = {name = "Оплот Чести", side = "-", category = "The Burning Crusade", }, --[faction=946]
	[942] = {name = "Кенарийская экспедиция", side = "-", category = "The Burning Crusade", }, --[faction=942]
	[941] = {name = "Маг'хары", side = "-", category = "The Burning Crusade", }, --[faction=941]
	[936] = {name = "Город Шаттрат", side = "-", category = "The Burning Crusade", }, --[faction=936]
	[935] = {name = "Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=935]
	[934] = {name = "Провидцы", side = "-", category = "Город Шаттрат", }, --[faction=934]
	[933] = {name = "Консорциум", side = "-", category = "The Burning Crusade", }, --[faction=933]
	[932] = {name = "Алдоры", side = "-", category = "Город Шаттрат", }, --[faction=932]
	[930] = {name = "Экзодар", side = "Альянс", category = "Альянс", }, --[faction=930]
	[922] = {name = "Транквиллион", side = "-", category = "The Burning Crusade", }, --[faction=922]
	[911] = {name = "Луносвет", side = "Орда", category = "Орда", }, --[faction=911]
	[910] = {name = "Род Ноздорму", side = "-", category = "World of Warcraft", }, --[faction=910]
	[909] = {name = "Ярмарка Новолуния", side = "-", category = "World of Warcraft", }, --[faction=909]
	[892] = {name = "Силы Орды", side = "-", category = "World of Warcraft", }, --[faction=892]
	[891] = {name = "Силы Альянса", side = "-", category = "World of Warcraft", }, --[faction=891]
	[890] = {name = "Среброкрылые Часовые", side = "-", category = "Силы Альянса", }, --[faction=890]
	[889] = {name = "Всадники Песни Войны", side = "-", category = "Силы Орды", }, --[faction=889]
	[809] = {name = "Шен'дралар", side = "-", category = "World of Warcraft", }, --[faction=809]
	[749] = {name = "Гидраксианские Повелители Вод", side = "-", category = "World of Warcraft", }, --[faction=749]
	[730] = {name = "Стража Грозовой Вершины", side = "-", category = "Силы Альянса", }, --[faction=730]
	[729] = {name = "Азеротский клан Северного Волка", side = "-", category = "Силы Орды", }, --[faction=729]
	[609] = {name = "Круг Кенария", side = "-", category = "World of Warcraft", }, --[faction=609]
	[589] = {name = "Укротители ледопардов", side = "-", category = "World of Warcraft", }, --[faction=589]
	[577] = {name = "Круговзор", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=577]
	[576] = {name = "Древобрюхи", side = "-", category = "World of Warcraft", }, --[faction=576]
	[530] = {name = "Племя Черного Копья", side = "Орда", category = "Орда", }, --[faction=530]
	[529] = {name = "Серебряный Рассвет", side = "-", category = "World of Warcraft", }, --[faction=529]
	[510] = {name = "Осквернители", side = "-", category = "Силы Орды", }, --[faction=510]
	[509] = {name = "Лига Аратора", side = "-", category = "Силы Альянса", }, --[faction=509]
	[470] = {name = "Кабестан", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=470]
	[469] = {name = "Альянс", side = "-", category = "World of Warcraft", }, --[faction=469]
	[369] = {name = "Прибамбасск", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=369]
	[349] = {name = "Черный Ворон", side = "-", category = "World of Warcraft", }, --[faction=349]
	[270] = {name = "Племя Зандалари", side = "-", category = "World of Warcraft", }, --[faction=270]
	[169] = {name = "Картель Хитрой Шестеренки", side = "-", category = "World of Warcraft", }, --[faction=169]
	[93] = {name = "Кентавры из племени Маграм", side = "-", category = "World of Warcraft", }, --[faction=93]
	[92] = {name = "Кентавры из племени Гелкис", side = "-", category = "World of Warcraft", }, --[faction=92]
	[87] = {name = "Пираты Кровавого Паруса", side = "-", category = "World of Warcraft", }, --[faction=87]
	[81] = {name = "Громовой Утес", side = "Орда", category = "Орда", }, --[faction=81]
	[76] = {name = "Оргриммар", side = "Орда", category = "Орда", }, --[faction=76]
	[72] = {name = "Штормград", side = "Альянс", category = "Альянс", }, --[faction=72]
	[70] = {name = "Синдикат", side = "-", category = "World of Warcraft", }, --[faction=70]
	[69] = {name = "Дарнас", side = "Альянс", category = "Альянс", }, --[faction=69]
	[68] = {name = "Подгород", side = "Орда", category = "Орда", }, --[faction=68]
	[67] = {name = "Орда", side = "-", category = "World of Warcraft", }, --[faction=67]
	[59] = {name = "Братство Тория", side = "-", category = "World of Warcraft", }, --[faction=59]
	[54] = {name = "Гномреган", side = "Альянс", category = "Альянс", }, --[faction=54]
	[47] = {name = "Стальгорн", side = "Альянс", category = "Альянс", }, --[faction=47]
	[21] = {name = "Пиратская Бухта", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=21]





}


local ParagonfactionID = {
	-- Legion
	1828, -- Highmountain Tribe
	1859, -- The Nightfallen
	1883, -- Dreamweavers
	1894, -- The Wardens
	1900, -- Court of Farondis
	1948, -- Valarjar
	2045, -- Armies of Legionfall
	2165, -- Army of the Light
	2170, -- Argussian Reach

	-- Battle for Azeroth
	2103, -- Zandalari Empire
	2156, -- Talanji's Expedition
	2157, -- The Honorbound
	2158, -- Voldunai
	2159, -- 7th Legion
	2160, -- Proudmoore Admiralty
	2161, -- Order of Embers
	2162, -- Storm's Wake
	2163, -- Tortollan Seekers
	2164, -- Champions of Azeroth
	2373, -- The Unshackled
	2391, -- Rustbolt Resistance
	2400, -- Waveblade Ankoan
	2415, -- Rajani
	2417, -- Uldum Accord

	-- Shadowlands
	2407, -- The Ascended
	2410, -- The Undying Army
	2413, -- Court of Harvesters
	2432, -- Ve'nari
	2465, -- The Wild Hunt
	2470, -- Death's Advance
	2472, -- The Archivists' Codex
	2478, -- The Enlightened

	-- Dragonflight
	2503, -- Maruuk Centaur
	2507, -- Dragonscale Expedition
	2510, -- Valdrakken Accord
	2511, -- Iskaara Tuskarr
	2564, -- Loamm Niffen
	2574, -- Dream Wardens

	-- The War Within
	2570, -- Hallowfall Arathi
	2590, -- Council of Dornogal
	2594, -- The Assembly of the Deeps
	2600, -- The Severed Threads
	2601, -- The Weaver
	2605, -- The General
	2607, -- The Vizier
	2653, -- The Cartels of Undermine
	2669, -- Darkfuse Solutions
	2671, -- Venture Company
	2673, -- Bilgewater Cartel
	2675, -- Blackwater Cartel
	2677, -- Steamwheedle Cartel
	2685, -- Gallagio Loyalty Rewards Club
}




E.OctoTable_allfaction = {
	2697, --Chase's test faction (DNT)
	2693, --(A)Путь участника вылазки (1-й сезон) id:2693
	2685, --(A)Клуб лояльности Галаджио id:2685
	2677, --(A)Картель Хитрой Шестеренки id:2677
	2675, --(A)Картель Черноводья id:2675
	2673, --(A)Картель Трюмных Вод id:2673
	2671, --(A)Торговая компания id:2671
	2669, --(A)Мрачные Решалы id:2669
	2653, --(A)Картели Нижней Шахты id:2653
	2645, --(A)Земельники id:2645
	2644, --(A)Вылазки: 1-й сезон id:2644
	2640, --(A)Бранн Бронзобород id:2640
	2615, --(A)Азеротские Архивы id:2615
	2607, --(A)Визирь id:2607
	2605, --(A)Генерал id:2605
	2601, --(A)Прядильщица id:2601
	2600, --(A)Отрезанные нити id:2600
	2594, --(A)Ассамблея глубин id:2594
	2593, --(A)Команда Бочконога id:2593
	2590, --(A)Совет Дорногала id:2590
	2574, --(A)Стражи Сна id:2574
	2570, --(A)Арати Тайносводья id:2570
	2569, --The War Within id:2569
	2568, --Гонщик Мерцающего Огга id:2568
	2564, --(A)Лоаммские ниффы id:2564
	2555, --Клан Кейган id:2555
	2554, --Клан Тогус id:2554
	2553, --(A)Соридорми id:2553
	2550, --(A)Кобальтовая ассамблея id:2550
	2544, --(A)Консорциум ремесленников – филиал на Драконьих островах id:2544
	2542, --Клан Укхел id:2542
	2526, --Фурболги из клана Зимней Шкуры id:2526
	2524, --Обсидиановые Хранители id:2524
	2523, --Темные Когти id:2523
	2522, --Клан Тирай id:2522
	2520, --Клан Нокхуд id:2520
	2518, --(A)Сабеллиан id:2518
	2517, --(A)Гневион id:2517
	2513, --Клан Он'ир id:2513
	2512, --Клан Айлааг id:2512
	2511, --(A)Искарские клыкарры id:2511
	2510, --(A)Союз Вальдраккена id:2510
	2509, --Клан Шикаар id:2509
	2507, --(A)Драконья экспедиция id:2507
	2506, --Dragonflight id:2506
	2503, --(A)Кентавры Маруук id:2503
	2478, --Просветленные id:2478
	2472, --Кодекс архивариуса id:2472
	2470, --Легион Смерти id:2470
	2469, --Понимание фракталов id:2469
	2465, --Дикая Охота id:2465
	2464, --Двор Ночи id:2464
	2463, --Чесночник id:2463
	2462, --Штопальщики id:2462
	2461, --Изобретатель чумы Марилет id:2461
	2460, --Камнелоб id:2460
	2459, --Сика id:2459
	2458, --Клейя и Пелагий id:2458
	2457, --Великий мастер Воул id:2457
	2456, --Дроман Алиот id:2456
	2455, --Хранитель склепа Каззир id:2455
	2454, --Чуфа id:2454
	2453, --Рендл и Дуборыл id:2453
	2452, --Полемарх Адрест id:2452
	2451, --Капитан-егерь Корейн id:2451
	2450, --Александрос Могрейн id:2450
	2449, --Графиня id:2449
	2448, --Миканикос id:2448
	2447, --Леди Лунная Ягода id:2447
	2446, --Баронесса Вайш id:2446
	2445, --Пепельный двор id:2445
	2439, --Нераскаявшиеся id:2439
	2432, --Ве'нари id:2432
	2431, --Owen Test
	2427, --Молодой акир id:2427
	2422, --Ночной народец id:2422
	2417, --Ульдумский союз id:2417
	2415, --Раджани id:2415
	2414, --Темные Земли id:2414
	2413, --Двор Жнецов id:2413
	2410, --Неумирающая армия id:2410
	2407, --Перерожденные id:2407
	2400, --Клинки Волн id:2400
	2398, --Фуражир из улья Медокрылов id:2398
	2397, --Пчеломатка улья Медокрылов id:2397
	2396, --Трутень из улья Медокрылов id:2396
	2395, --Улей Медокрылов id:2395
	2391, --Ржавоболтское сопротивление id:2391
	2390, --Вим Соленодух id:2390
	2389, --Нери Остроерш id:2389
	2388, --Поэн Солежабрик id:2388
	2377, --Мастер клинка Иновари id:2377
	2376, --Оракул Ори id:2376
	2375, --Мастер охоты Акана id:2375
	2373, --Освобожденные id:2373
	2372, --Арена "Морд'Бой" id:2372
	2371, --Потасовочная "У Бизмо" id:2371
	2370, --Обучение динозавров – Дикорог id:2370
	2265, --Кул-Тирас - долина Штормов id:2265
	2264, --Кул-Тирас - Друствар id:2264
	2233, --Dino Training - Pterrodax id:2233
	2170, --Защитники Аргуса id:2170
	2165, --Армия Света id:2165
	2164, --Защитники Азерот id:2164
	2163, --Тортолланские искатели id:2163
	2162, --Орден Возрождения Шторма id:2162
	2161, --Орден Пылающих Углей id:2161
	2160, --Адмиралтейство Праудмуров id:2160
	2159, --7-й легион id:2159
	2158, --Жители Вол'дуна id:2158
	2157, --Армия Чести id:2157
	2156, --Экспедиция Таланджи id:2156
	2135, --Хроми id:2135
	2120, --Кул-Тирас - Тирагард id:2120
	2111, --Зандаларские динозавры id:2111
	2104, --Battle for Azeroth id:2104
	2103, --Империя Зандалари id:2103
	2102, --Бесс id:2102
	2101, --Ша'лет id:2101
	2100, --Корбин id:2100
	2099, --Акуле Речной Рог id:2099
	2098, --Хранительница Рейна id:2098
	2097, --Илиссия Водная id:2097
	2045, --Армия погибели Легиона id:2045
	2018, --Отмщение Когтя id:2018
	2011, --Потасовочная "У Бизмо" (3-й сезон) id:2011
	2010, --Арена "Морд'Бой" (3-й сезон) id:2010
	1989, --Лунные стражи id:1989
	1984, --Спасатели id:1984
	1975, --Кудесник Маргосс id:1975
	1948, --Валарьяры id:1948
	1947, --Иллидари id:1947
	1919, --Жажда магии Вальтруа id:1919
	1900, --Двор Фарондиса id:1900
	1899, --Лунные стражи id:1899
	1894, --Стражи id:1894
	1888, --Яндвикские врайкулы id:1888
	1883, --Ткачи Снов id:1883
	1862, --Жажда магии Окулета id:1862
	1861, --Arcane Thirst (Silgryn) DEPRECATED
	1860, --Жажда магии Талисры id:1860
	1859, --Помраченные id:1859
	1850, --Охотники за саблеронами id:1850
	1849, --Орден Пробудившихся id:1849
	1848, --Охотники за головами id:1848
	1847, --Длань Пророка id:1847
	1834, --Legion id:1834
	1828, --Племена Крутогорья id:1828
	1815, --Выжившие из Гилнеаса id:1815
	1741, --Леорадж id:1741
	1740, --Аеда Ясная Заря id:1740
	1739, --Вивианна id:1739
	1738, --Защитница Иллона id:1738
	1737, --Жрец Когтя Ишааль id:1737
	1736, --Тормок id:1736
	1735, --Телохранители из казарм id:1735
	1733, --Делвар Железный Кулак id:1733
	1732, --Дренорcкая Экспедиция Хитрой Шестеренки id:1732
	1731, --Совет экзархов id:1731
	1711, --Археологическое общество Хитрой Шестеренки id:1711
	1710, --Защитники Ша'тар id:1710
	1708, --Клан Веселого Черепа id:1708
	1691, --Потасовочная "У Бизмо" (сезон 2) id:1691
	1690, --Арена "Морд'Бой" (сезон 2) id:1690
	1682, --Авангард Ринна id:1682
	1681, --Копье Вол'джина id:1681
	1520, --Изгнанники клана Призрачной Луны id:1520
	1515, --Араккоа-изгои id:1515
	1492, --Император Шаохао id:1492
	1445, --Клан Северного Волка id:1445
	1444, --Warlords of Draenor id:1444
	1440, --Восстание Черного Копья id:1440
	1435, --Натиск Шадо-Пан id:1435
	1419, --Потасовочная "У Бизмо" (сезон 1) id:1419
	1388, --Войска Похитителей Солнца id:1388
	1387, --Армия Кирин-Тора id:1387
	1376, --Операция "Заслон" id:1376
	1375, --Армия Покорителей id:1375
	1374, --Арена "Морд'Бой" (сезон 1) id:1374
	1359, --Черный принц id:1359
	1358, --Нат Пэгл id:1358
	1357, --Номи id:1357
	1353, --Пандарены Тушуй id:1353
	1352, --Пандарены Хоцзинь id:1352
	1351, --Хмелевары id:1351
	1345, --Хранители истории id:1345
	1341, --Небожители id:1341
	1337, --Клакси id:1337
	1302, --Рыболовы id:1302
	1283, --Фермер Фун id:1283
	1282, --Рыба Тростниковая Шкура id:1282
	1281, --Джина Грязный Коготь id:1281
	1280, --Тина Грязный Коготь id:1280
	1279, --Хаохань Грязный Коготь id:1279
	1278, --Шо id:1278
	1277, --Чи-Чи id:1277
	1276, --Старик Горная Лапа id:1276
	1275, --Элла id:1275
	1273, --Йогу Пьяный id:1273
	1272, --Земледельцы id:1272
	1271, --Орден Облачного Змея id:1271
	1270, --Шадо-Пан id:1270
	1269, --Золотой Лотос id:1269
	1245, --Mists of Pandaria id:1245
	1242, --Цзинь-юй Жемчужного Плавника id:1242
	1228, --Лесные хозены id:1228
	1216, --Академия Шан Си id:1216
	1204, --Хиджальские мстители id:1204
	1178, --Батальон Адского Крика id:1178
	1177, --Защитники Тол Барада id:1177
	1174, --Клан Громового Молота id:1174
	1173, --Рамкахены id:1173
	1172, --Клан Драконьей Пасти id:1172
	1171, --Теразан id:1171
	1169, --Гильдия id:1169
	1168, --Гильдия id:1168
	1162, --Cataclysm id:1162
	1158, --Стражи Хиджала id:1158
	1156, --Пепельный союз id:1156
	1135, --Служители Земли id:1135
	1134, --Гилнеас id:1134
	1133, --Картель Трюмных Вод id:1133
	1126, --Зиморожденные id:1126
	1124, --Похитители Солнца id:1124
	1119, --Сыны Ходира id:1119
	1118, --World of Warcraft id:1118
	1117, --Низина Шолазар id:1117
	1106, --Серебряный Авангард id:1106
	1105, --Оракулы id:1105
	1104, --Племя Бешеного Сердца id:1104
	1098, --Рыцари Черного Клинка id:1098
	1097, --Wrath of the Lich King id:1097
	1094, --Серебряный Союз id:1094
	1091, --Драконий союз id:1091
	1090, --Кирин-Тор id:1090
	1085, --Армия Песни Войны id:1085
	1077, --Армия Расколотого Солнца id:1077
	1073, --Калу'ак id:1073
	1072, --[DNT] AC Major Faction Child Renown Test
	1068, --Лига исследователей id:1068
	1067, --Карающая Длань id:1067
	1064, --Таунка id:1064
	1052, --Экспедиция Орды id:1052
	1050, --Экспедиция Отважных id:1050
	1038, --Огри'ла id:1038
	1037, --Авангард Альянса id:1037
	1031, --Стражи небес Ша'тар id:1031
	1015, --Крылья Пустоты id:1015
	1012, --Пеплоусты-служители id:1012
	1011, --Нижний Город id:1011
	990, --Песчаная Чешуя id:990
	989, --Хранители Времени id:989
	980, --The Burning Crusade id:980
	978, --Куренай id:978
	970, --Спореггар id:970
	967, --Аметистовое Око id:967
	949, --Тестовая фракция 1 id:949
	948, --Тестовая фракция 2 id:948
	947, --Траллмар id:947
	946, --Оплот Чести id:946
	942, --Кенарийская экспедиция id:942
	941, --Маг'хары id:941
	936, --Город Шаттрат id:936
	935, --Ша'тар id:935
	934, --Провидцы id:934
	933, --Консорциум id:933
	932, --Алдоры id:932
	930, --Экзодар id:930
	922, --Транквиллион id:922
	911, --Луносвет id:911
	910, --Род Ноздорму id:910
	909, --Ярмарка Новолуния id:909
	892, --Силы Орды id:892
	891, --Силы Альянса id:891
	890, --Среброкрылые Часовые id:890
	889, --Всадники Песни Войны id:889
	809, --Шен'дралар id:809
	749, --Гидраксианские Повелители Вод id:749
	730, --Стража Грозовой Вершины id:730
	729, --Азеротский клан Северного Волка id:729
	609, --Круг Кенария id:609
	589, --Укротители ледопардов id:589
	577, --Круговзор id:577
	576, --Древобрюхи id:576
	530, --Племя Черного Копья id:530
	529, --Серебряный Рассвет id:529
	510, --Осквернители id:510
	509, --Лига Аратора id:509
	470, --Кабестан id:470
	469, --Альянс id:469
	369, --Прибамбасск id:369
	349, --Черный Ворон id:349
	270, --Племя Зандалари id:270
	169, --Картель Хитрой Шестеренки id:169
	93, --Кентавры из племени Маграм id:93
	92, --Кентавры из племени Гелкис id:92
	87, --Пираты Кровавого Паруса id:87
	81, --Громовой Утес id:81
	76, --Оргриммар id:76
	72, --Штормград id:72
	70, --Синдикат id:70
	69, --Дарнас id:69
	68, --Подгород id:68
	67, --Орда id:67
	59, --Братство Тория id:59
	54, --Гномреган id:54
	47, --Стальгорн id:47
	21, --Пиратская Бухта id:21
	2695,
	2684,
	2683,
	2676,
	2674,
	2672,
	2670,
	2668,
	2667,
	2649,
	2648,
	2647,
	2613,
	2612,
	2611,
	2604,
	2596,
	2575,
	2565,
	2552,
	2551,
	2521,
	2508,
	2504,
	2479,
	2474,
	2473,
	2471,
	2444,
	2442,
	2441,
	2440,
	2418,
	2416,
	2401,
	2392,
	2387,
	2386,
	2385,
	2384,
	2383,
	2382,
	2381,
	2380,
	2379,
	2378,
	2374,
	2167,
	2166,
	2091,
	2090,
	2089,
	2088,
	2087,
	2086,
	2085,
	2063,

}