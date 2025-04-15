local GlobalAddonName, E = ...
--------------------------------------------------------------------------------
E.OctoTable_Reputations = {
	-- [2697] = {icon = 134400, exp = EXPANSION_NAME11, id = 2697, name = "Chase's test faction (DNT)", side = "-", category = "Другое", }, --[faction=2697]
	-- [2645] = {icon = 134400, exp = EXPANSION_NAME11, id = 2645, name = "Земельники", side = "-", category = "Совет Дорногала", }, --[faction=2645]
	-- [2604] = {icon = 134400, exp = EXPANSION_NAME11, id = 2604, name = "Команда Бочконога (идеал)", side = "-", category = "Другое", }, --[faction=2604]
	-- [2569] = {icon = 134400, exp = EXPANSION_NAME11, id = 2569, name = "The War Within", side = "-", category = "Другое", }, --[faction=2569] -- ХЕДЕР?
	-- [2554] = {icon = 134400, exp = EXPANSION_NAME11, id = 2554, name = "Клан Тогус", side = "-", category = "Кентавры Маруук", }, --[faction=2554]
	-- [2522] = {icon = 134400, exp = EXPANSION_NAME11, id = 2522, name = "Клан Тирай", side = "-", category = "Кентавры Маруук", }, --[faction=2522]
	-- [2513] = {icon = 134400, exp = EXPANSION_NAME11, id = 2513, name = "Клан Он'ир", side = "-", category = "Кентавры Маруук", }, --[faction=2513]
	-- [2512] = {icon = 134400, exp = EXPANSION_NAME11, id = 2512, name = "Клан Айлааг", side = "-", category = "Кентавры Маруук", }, --[faction=2512]
	-- [2509] = {icon = 134400, exp = EXPANSION_NAME11, id = 2509, name = "Клан Шикаар", side = "-", category = "Кентавры Маруук", }, --[faction=2509]
	-- [2506] = {icon = 134400, exp = EXPANSION_NAME11, id = 2506, name = "Dragonflight", side = "-", category = "Другое", }, --[faction=2506] -- ХЕДЕР?
	-- [2431] = {icon = 134400, exp = EXPANSION_NAME11, id = 2431, name = "Owen Test", side = "-", category = "Другое", }, --[faction=2431]
	-- [2422] = {icon = 134400, exp = EXPANSION_NAME11, id = 2422, name = "Ночной народец", side = "-", category = "Дикая Охота", }, --[faction=2422]
	-- [2414] = {icon = 134400, exp = EXPANSION_NAME11, id = 2414, name = "Темные Земли", side = "-", category = "Другое", }, --[faction=2414] -- ХЕДЕР?
	-- [2265] = {icon = 134400, exp = EXPANSION_NAME11, id = 2265, name = "Кул-Тирас - долина Штормов", side = "-", category = "Орден Возрождения Шторма", }, --[faction=2265]
	-- [2264] = {icon = 134400, exp = EXPANSION_NAME11, id = 2264, name = "Кул-Тирас - Друствар", side = "-", category = "Орден Пылающих Углей", }, --[faction=2264]
	-- [2167] = {icon = 134400, exp = EXPANSION_NAME11, id = 2167, name = "Защитники Аргуса (идеал)", side = "-", category = "Другое", }, --[faction=2167]
	-- [2120] = {icon = 134400, exp = EXPANSION_NAME11, id = 2120, name = "Кул-Тирас - Тирагард", side = "Alliance", category = "Адмиралтейство Праудмуров", }, --[faction=2120]
	-- [2104] = {icon = 134400, exp = EXPANSION_NAME11, id = 2104, name = "Battle for Azeroth", side = "-", category = "Другое", }, --[faction=2104] -- ХЕДЕР
	-- [2063] = {icon = 134400, exp = EXPANSION_NAME11, id = 2063, name = "Arne Test - Paragon Reputation Stormwind", side = "-", category = "Другое", }, --[faction=2063]
	-- [1834] = {icon = 134400, exp = EXPANSION_NAME11, id = 1834, name = "Legion", side = "-", category = "Другое", }, --[faction=1834] -- ХЕДЕР?
	-- [1444] = {icon = 134400, exp = EXPANSION_NAME11, id = 1444, name = "Warlords of Draenor", side = "-", category = "Другое", }, --[faction=1444] -- ХЕДЕР?
	-- [1245] = {icon = 134400, exp = EXPANSION_NAME11, id = 1245, name = "Mists of Pandaria", side = "-", category = "Другое", }, --[faction=1245] -- ХЕДЕР?
	-- [1162] = {icon = 134400, exp = EXPANSION_NAME11, id = 1162, name = "Cataclysm", side = "-", category = "Другое", }, --[faction=1162] -- ХЕДЕР?
	-- [1118] = {icon = 134400, exp = EXPANSION_NAME11, id = 1118, name = "World of Warcraft", side = "-", category = "Другое", }, --[faction=1118] -- ХЕДЕР?
	-- [1097] = {icon = 134400, exp = EXPANSION_NAME11, id = 1097, name = "Wrath of the Lich King", side = "-", category = "Другое", }, --[faction=1097] -- ХЕДЕР?
	-- [1072] = {icon = 134400, exp = EXPANSION_NAME11, id = 1072, name = "[DNT] AC Major Faction Child Renown Test", side = "-", category = "Кентавры Маруук", }, --[faction=1072]
	-- [949] = {icon = 134400, exp = EXPANSION_NAME11, id = 949, name = "Тестовая фракция 1", side = "-", category = "Другое", }, --[faction=949]
	-- [948] = {icon = 134400, exp = EXPANSION_NAME11, id = 948, name = "Тестовая фракция 2", side = "-", category = "Тестовая фракция 1", }, --[faction=948]
	-- [980] = {icon = 134400, exp = EXPANSION_NAME11, id = 980, name = "The Burning Crusade", side = "-", category = "Другое", }, --[faction=980] -- ХЕДЕР?
	-- [892] = {icon = 134400, exp = EXPANSION_NAME11, id = 892, name = "Силы Орды", side = "-", category = "World of Warcraft", }, --[faction=892] -- ВНУТРЕННИЙ ХЕДЕР
	-- [891] = {icon = 134400, exp = EXPANSION_NAME11, id = 891, name = "Силы Альянса", side = "-", category = "World of Warcraft", }, --[faction=891] -- ВНУТРЕННИЙ ХЕДЕР
	-- [2695] = {icon = 134400, exp = EXPANSION_NAME11, id = 2695, name = "Test Account Wide Stormwind (DNT)", side = "Alliance", category = "Альянс", }, --[faction=2695]
	-- [1169] = {icon = 134400, exp = EXPANSION_NAME11, id = 1169, name = "Гильдия", side = "-", category = "Другое", }, --[faction=1169] -- ХЕДЕР
	-- [2166] = {icon = 134400, exp = EXPANSION_NAME11, id = 2166, name = "Армия Света (идеал)", side = "-", category = "Legion", }, --[faction=2166]
	-- [2091] = {icon = 134400, exp = EXPANSION_NAME11, id = 2091, name = "Армия погибели Легиона (идеал)", side = "-", category = "Legion", }, --[faction=2091]
	-- [2090] = {icon = 134400, exp = EXPANSION_NAME11, id = 2090, name = "Стражи (идеал)", side = "-", category = "Legion", }, --[faction=2090]
	-- [2089] = {icon = 134400, exp = EXPANSION_NAME11, id = 2089, name = "Помраченные (идеал)", side = "-", category = "Legion", }, --[faction=2089]
	-- [2088] = {icon = 134400, exp = EXPANSION_NAME11, id = 2088, name = "Ткачи Снов (идеал)", side = "-", category = "Legion", }, --[faction=2088]
	-- [2087] = {icon = 134400, exp = EXPANSION_NAME11, id = 2087, name = "Двор Фарондиса (идеал)", side = "-", category = "Legion", }, --[faction=2087]
	-- [2086] = {icon = 134400, exp = EXPANSION_NAME11, id = 2086, name = "Валарьяры (идеал)", side = "-", category = "Legion", }, --[faction=2086]
	-- [2085] = {icon = 134400, exp = EXPANSION_NAME11, id = 2085, name = "Племена Крутогорья (идеал)", side = "-", category = "Legion", }, --[faction=2085]
	-- [1989] = {icon = 134400, exp = EXPANSION_NAME11, id = 1989, name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1989]
	-- [1947] = {icon = 134400, exp = EXPANSION_NAME11, id = 1947, name = "Иллидари", side = "-", category = "Legion", }, --[faction=1947]
	-- [1888] = {icon = 134400, exp = EXPANSION_NAME11, id = 1888, name = "Яндвикские врайкулы", side = "-", category = "Legion", }, --[faction=1888]
	-- [2693] = {icon = 134400, exp = EXPANSION_NAME11, id = 2693, name = "Путь участника вылазки (1-й сезон)", side = "-", category = "The War Within", }, --[faction=2693]
	-- [2683] = {icon = 134400, exp = EXPANSION_NAME11, id = 2683, name = "Вылазки: 2-й сезон", side = "-", category = "The War Within", }, --[faction=2683]
	-- [2667] = {icon = 134400, exp = EXPANSION_NAME11, id = 2667, name = "Картели Нижней Шахты (идеал)", side = "-", category = "The War Within", }, --[faction=2667]
	-- [2644] = {icon = 134400, exp = EXPANSION_NAME11, id = 2644, name = "Вылазки: 1-й сезон", side = "-", category = "The War Within", }, --[faction=2644]
	-- [2613] = {icon = 134400, exp = EXPANSION_NAME11, id = 2613, name = "Ассамблея глубин (идеал)", side = "-", category = "The War Within", }, --[faction=2613]
	-- [2612] = {icon = 134400, exp = EXPANSION_NAME11, id = 2612, name = "Совет Дорногала (идеал)", side = "-", category = "The War Within", }, --[faction=2612]
	-- [2611] = {icon = 134400, exp = EXPANSION_NAME11, id = 2611, name = "Арати Тайносводья (идеал)", side = "-", category = "The War Within", }, --[faction=2611]
	-- [2596] = {icon = 134400, exp = EXPANSION_NAME11, id = 2596, name = "Отрезанные нити (идеал)", side = "-", category = "The War Within", }, --[faction=2596]
	-- [2649] = {icon = 134400, exp = EXPANSION_NAME11, id = 2649, name = "Генерал (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2649]
	-- [2648] = {icon = 134400, exp = EXPANSION_NAME11, id = 2648, name = "Прядильщица (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2648]
	-- [2647] = {icon = 134400, exp = EXPANSION_NAME11, id = 2647, name = "Визирь (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2647]
	-- [2684] = {icon = 134400, exp = EXPANSION_NAME11, id = 2684, name = "Клуб лояльности Галаджио (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2684]
	-- [2676] = {icon = 134400, exp = EXPANSION_NAME11, id = 2676, name = "Картель Хитрой Шестеренки (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2676]
	-- [2674] = {icon = 134400, exp = EXPANSION_NAME11, id = 2674, name = "Картель Черноводья (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2674]
	-- [2672] = {icon = 134400, exp = EXPANSION_NAME11, id = 2672, name = "Картель Трюмных Вод (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2672]
	-- [2670] = {icon = 134400, exp = EXPANSION_NAME11, id = 2670, name = "Торговая компания (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2670]
	-- [2668] = {icon = 134400, exp = EXPANSION_NAME11, id = 2668, name = "Мрачные Решалы (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2668]
	-- [2575] = {icon = 134400, exp = EXPANSION_NAME11, id = 2575, name = "Стражи Сна (идеал)", side = "-", category = "Dragonflight", }, --[faction=2575]
	-- [2565] = {icon = 134400, exp = EXPANSION_NAME11, id = 2565, name = "Лоаммские ниффы (идеал)", side = "-", category = "Dragonflight", }, --[faction=2565]
	-- [2555] = {icon = 134400, exp = EXPANSION_NAME11, id = 2555, name = "Клан Кейган", side = "-", category = "Dragonflight", }, --[faction=2555]
	-- [2552] = {icon = 134400, exp = EXPANSION_NAME11, id = 2552, name = "Союз Вальдраккена (идеал)", side = "-", category = "Dragonflight", }, --[faction=2552]
	-- [2551] = {icon = 134400, exp = EXPANSION_NAME11, id = 2551, name = "Искарские клыкарры (идеал)", side = "-", category = "Dragonflight", }, --[faction=2551]
	-- [2542] = {icon = 134400, exp = EXPANSION_NAME11, id = 2542, name = "Клан Укхел", side = "-", category = "Dragonflight", }, --[faction=2542]
	-- [2521] = {icon = 134400, exp = EXPANSION_NAME11, id = 2521, name = "Клан Нокуд (идеал)", side = "-", category = "Dragonflight", }, --[faction=2521]
	-- [2520] = {icon = 134400, exp = EXPANSION_NAME11, id = 2520, name = "Клан Нокхуд", side = "-", category = "Dragonflight", }, --[faction=2520]
	-- [2508] = {icon = 134400, exp = EXPANSION_NAME11, id = 2508, name = "Драконья экспедиция (идеал)", side = "-", category = "Dragonflight", }, --[faction=2508]
	-- [2504] = {icon = 134400, exp = EXPANSION_NAME11, id = 2504, name = "Кентавры Маруук (идеал)", side = "-", category = "Dragonflight", }, --[faction=2504]
	-- [2479] = {icon = 134400, exp = EXPANSION_NAME11, id = 2479, name = "Просветленные (идеал)", side = "-", category = "Темные Земли", }, --[faction=2479]
	-- [2474] = {icon = 134400, exp = EXPANSION_NAME11, id = 2474, name = "Ве'нари (идеал)", side = "-", category = "Темные Земли", }, --[faction=2474]
	-- [2473] = {icon = 134400, exp = EXPANSION_NAME11, id = 2473, name = "Кодекс архивариуса (идеал)", side = "-", category = "Темные Земли", }, --[faction=2473]
	-- [2471] = {icon = 134400, exp = EXPANSION_NAME11, id = 2471, name = "Легион Смерти (идеал)", side = "-", category = "Темные Земли", }, --[faction=2471]
	-- [2444] = {icon = 134400, exp = EXPANSION_NAME11, id = 2444, name = "Дикая Охота (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2444]
	-- [2442] = {icon = 134400, exp = EXPANSION_NAME11, id = 2442, name = "Двор Жнецов (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2442]
	-- [2441] = {icon = 134400, exp = EXPANSION_NAME11, id = 2441, name = "Перерожденные (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2441]
	-- [2440] = {icon = 134400, exp = EXPANSION_NAME11, id = 2440, name = "Неумирающая армия (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2440]
	-- [2418] = {icon = 134400, exp = EXPANSION_NAME11, id = 2418, name = "Ульдумский союз (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2418]
	-- [2416] = {icon = 134400, exp = EXPANSION_NAME11, id = 2416, name = "Раджани (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2416]
	-- [2401] = {icon = 134400, exp = EXPANSION_NAME11, id = 2401, name = "Анкоа из клана Клинков Волн (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2401]
	-- [2392] = {icon = 134400, exp = EXPANSION_NAME11, id = 2392, name = "Ржавоболтское сопротивление (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2392]
	-- [2387] = {icon = 134400, exp = EXPANSION_NAME11, id = 2387, name = "Тортолланские искатели (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2387]
	-- [2386] = {icon = 134400, exp = EXPANSION_NAME11, id = 2386, name = "Защитники Азерот (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2386]
	-- [2385] = {icon = 134400, exp = EXPANSION_NAME11, id = 2385, name = "Армия Чести (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2385]
	-- [2384] = {icon = 134400, exp = EXPANSION_NAME11, id = 2384, name = "7-й легион (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2384]
	-- [2383] = {icon = 134400, exp = EXPANSION_NAME11, id = 2383, name = "Орден Пылающих Углей (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2383]
	-- [2382] = {icon = 134400, exp = EXPANSION_NAME11, id = 2382, name = "Жители Вол'дуна (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2382]
	-- [2381] = {icon = 134400, exp = EXPANSION_NAME11, id = 2381, name = "Орден Возрождения Шторма (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2381]
	-- [2380] = {icon = 134400, exp = EXPANSION_NAME11, id = 2380, name = "Экспедиция Таланджи (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2380]
	-- [2379] = {icon = 134400, exp = EXPANSION_NAME11, id = 2379, name = "Адмиралтейство Праудмуров (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2379]
	-- [2378] = {icon = 134400, exp = EXPANSION_NAME11, id = 2378, name = "Империя Зандалари (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2378]
	-- [2374] = {icon = 134400, exp = EXPANSION_NAME11, id = 2374, name = "Освобожденные (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2374]
	-- [1861] = {icon = 134400, exp = EXPANSION_NAME11, id = 1861, name = "Arcane Thirst (Silgryn) DEPRECATED", side = "-", category = "Помраченные", }, --[faction=1861]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2653] = {icon = "Interface\\ICONS\\UI_MajorFactions_Rocket", exp = EXPANSION_NAME10, id = 2653, name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
	[2640] = {icon = 134400, exp = EXPANSION_NAME10, id = 2640, name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
	[2600] = {icon = "Interface\\ICONS\\UI_MajorFactions_web", exp = EXPANSION_NAME10, id = 2600, name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
	[2594] = {icon = "Interface\\ICONS\\UI_MajorFactions_candle", exp = EXPANSION_NAME10, id = 2594, name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
	[2590] = {icon = "Interface\\ICONS\\UI_MajorFactions_storm", exp = EXPANSION_NAME10, id = 2590, name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
	[2570] = {icon = "Interface\\ICONS\\UI_MajorFactions_flame", exp = EXPANSION_NAME10, id = 2570, name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
	----------------------------------------------------------------
	[2607] = {icon = 134400, exp = EXPANSION_NAME10, id = 2607, name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
	[2605] = {icon = 134400, exp = EXPANSION_NAME10, id = 2605, name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
	[2601] = {icon = 134400, exp = EXPANSION_NAME10, id = 2601, name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
	----------------------------------------------------------------
	[2685] = {icon = "Interface\\ICONS\\UI_MajorFactions_stars", exp = EXPANSION_NAME10, id = 2685, name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
	[2677] = {icon = 134400, exp = EXPANSION_NAME10, id = 2677, name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
	[2675] = {icon = 134400, exp = EXPANSION_NAME10, id = 2675, name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
	[2673] = {icon = 134400, exp = EXPANSION_NAME10, id = 2673, name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
	[2671] = {icon = 134400, exp = EXPANSION_NAME10, id = 2671, name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
	[2669] = {icon = 134400, exp = EXPANSION_NAME10, id = 2669, name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2574] = {icon = 134400, exp = EXPANSION_NAME9, id = 2574, name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
	[2568] = {icon = 134400, exp = EXPANSION_NAME9, id = 2568, name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
	[2564] = {icon = 134400, exp = EXPANSION_NAME9, id = 2564, name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
	[2526] = {icon = 134400, exp = EXPANSION_NAME9, id = 2526, name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
	[2511] = {icon = 134400, exp = EXPANSION_NAME9, id = 2511, name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
	[2510] = {icon = 134400, exp = EXPANSION_NAME9, id = 2510, name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
	[2507] = {icon = 134400, exp = EXPANSION_NAME9, id = 2507, name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
	[2503] = {icon = 134400, exp = EXPANSION_NAME9, id = 2503, name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
	----------------------------------------------------------------
	[2553] = {icon = 134400, exp = EXPANSION_NAME9, id = 2553, name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
	[2550] = {icon = 134400, exp = EXPANSION_NAME9, id = 2550, name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
	[2544] = {icon = 134400, exp = EXPANSION_NAME9, id = 2544, name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
	[2518] = {icon = 134400, exp = EXPANSION_NAME9, id = 2518, name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
	[2517] = {icon = 134400, exp = EXPANSION_NAME9, id = 2517, name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
	----------------------------------------------------------------
	[2615] = {icon = 134400, exp = EXPANSION_NAME9, id = 2615, name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
	----------------------------------------------------------------
	[2593] = {icon = 134400, exp = EXPANSION_NAME9, id = 2593, name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2478] = {icon = 134400, exp = EXPANSION_NAME8, id = 2478, name = "Просветленные", side = "-", category = "Темные Земли", }, --[faction=2478]
	[2472] = {icon = 134400, exp = EXPANSION_NAME8, id = 2472, name = "Кодекс архивариуса", side = "-", category = "Темные Земли", }, --[faction=2472]
	[2470] = {icon = 134400, exp = EXPANSION_NAME8, id = 2470, name = "Легион Смерти", side = "-", category = "Темные Земли", }, --[faction=2470]
	[2469] = {icon = 134400, exp = EXPANSION_NAME8, id = 2469, name = "Понимание фракталов", side = "-", category = "Темные Земли", }, --[faction=2469]
	[2465] = {icon = 134400, exp = EXPANSION_NAME8, id = 2465, name = "Дикая Охота", side = "-", category = "Темные Земли", }, --[faction=2465]
	[2464] = {icon = 134400, exp = EXPANSION_NAME8, id = 2464, name = "Двор Ночи", side = "-", category = "Темные Земли", }, --[faction=2464]
	[2463] = {icon = 134400, exp = EXPANSION_NAME8, id = 2463, name = "Чесночник", side = "-", category = "Темные Земли", }, --[faction=2463]
	[2462] = {icon = 134400, exp = EXPANSION_NAME8, id = 2462, name = "Штопальщики", side = "-", category = "Темные Земли", }, --[faction=2462]
	[2445] = {icon = 134400, exp = EXPANSION_NAME8, id = 2445, name = "Пепельный двор", side = "-", category = "Темные Земли", }, --[faction=2445]
	[2439] = {icon = 134400, exp = EXPANSION_NAME8, id = 2439, name = "Нераскаявшиеся", side = "-", category = "Темные Земли", }, --[faction=2439]
	[2432] = {icon = 134400, exp = EXPANSION_NAME8, id = 2432, name = "Ве'нари", side = "-", category = "Темные Земли", }, --[faction=2432]
	[2413] = {icon = 134400, exp = EXPANSION_NAME8, id = 2413, name = "Двор Жнецов", side = "-", category = "Темные Земли", }, --[faction=2413]
	[2410] = {icon = 134400, exp = EXPANSION_NAME8, id = 2410, name = "Неумирающая армия", side = "-", category = "Темные Земли", }, --[faction=2410]
	[2407] = {icon = 134400, exp = EXPANSION_NAME8, id = 2407, name = "Перерожденные", side = "-", category = "Темные Земли", }, --[faction=2407]
	----------------------------------------------------------------
	[2461] = {icon = 134400, exp = EXPANSION_NAME8, id = 2461, name = "Изобретатель чумы Марилет", side = "-", category = "Пепельный двор", }, --[faction=2461]
	[2460] = {icon = 134400, exp = EXPANSION_NAME8, id = 2460, name = "Камнелоб", side = "-", category = "Пепельный двор", }, --[faction=2460]
	[2459] = {icon = 134400, exp = EXPANSION_NAME8, id = 2459, name = "Сика", side = "-", category = "Пепельный двор", }, --[faction=2459]
	[2458] = {icon = 134400, exp = EXPANSION_NAME8, id = 2458, name = "Клейя и Пелагий", side = "-", category = "Пепельный двор", }, --[faction=2458]
	[2457] = {icon = 134400, exp = EXPANSION_NAME8, id = 2457, name = "Великий мастер Воул", side = "-", category = "Пепельный двор", }, --[faction=2457]
	[2456] = {icon = 134400, exp = EXPANSION_NAME8, id = 2456, name = "Дроман Алиот", side = "-", category = "Пепельный двор", }, --[faction=2456]
	[2455] = {icon = 134400, exp = EXPANSION_NAME8, id = 2455, name = "Хранитель склепа Каззир", side = "-", category = "Пепельный двор", }, --[faction=2455]
	[2454] = {icon = 134400, exp = EXPANSION_NAME8, id = 2454, name = "Чуфа", side = "-", category = "Пепельный двор", }, --[faction=2454]
	[2453] = {icon = 134400, exp = EXPANSION_NAME8, id = 2453, name = "Рендл и Дуборыл", side = "-", category = "Пепельный двор", }, --[faction=2453]
	[2452] = {icon = 134400, exp = EXPANSION_NAME8, id = 2452, name = "Полемарх Адрест", side = "-", category = "Пепельный двор", }, --[faction=2452]
	[2451] = {icon = 134400, exp = EXPANSION_NAME8, id = 2451, name = "Капитан-егерь Корейн", side = "-", category = "Пепельный двор", }, --[faction=2451]
	[2450] = {icon = 134400, exp = EXPANSION_NAME8, id = 2450, name = "Александрос Могрейн", side = "-", category = "Пепельный двор", }, --[faction=2450]
	[2449] = {icon = 134400, exp = EXPANSION_NAME8, id = 2449, name = "Графиня", side = "-", category = "Пепельный двор", }, --[faction=2449]
	[2448] = {icon = 134400, exp = EXPANSION_NAME8, id = 2448, name = "Миканикос", side = "-", category = "Пепельный двор", }, --[faction=2448]
	[2447] = {icon = 134400, exp = EXPANSION_NAME8, id = 2447, name = "Леди Лунная Ягода", side = "-", category = "Пепельный двор", }, --[faction=2447]
	[2446] = {icon = 134400, exp = EXPANSION_NAME8, id = 2446, name = "Баронесса Вайш", side = "-", category = "Пепельный двор", }, --[faction=2446]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2427] = {icon = 134400, exp = EXPANSION_NAME7, id = 2427, name = "Молодой акир", side = "-", category = "Battle for Azeroth", }, --[faction=2427]
	[2417] = {icon = 134400, exp = EXPANSION_NAME7, id = 2417, name = "Ульдумский союз", side = "-", category = "Battle for Azeroth", }, --[faction=2417]
	[2415] = {icon = 134400, exp = EXPANSION_NAME7, id = 2415, name = "Раджани", side = "-", category = "Battle for Azeroth", }, --[faction=2415]
	[2400] = {icon = 134400, exp = EXPANSION_NAME7, id = 2400, name = "Клинки Волн", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2400]
	[2395] = {icon = 134400, exp = EXPANSION_NAME7, id = 2395, name = "Улей Медокрылов", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2395]
	[2391] = {icon = 134400, exp = EXPANSION_NAME7, id = 2391, name = "Ржавоболтское сопротивление", side = "-", category = "Battle for Azeroth", }, --[faction=2391]
	[2390] = {icon = 134400, exp = EXPANSION_NAME7, id = 2390, name = "Вим Соленодух", side = "-", category = "Battle for Azeroth", }, --[faction=2390]
	[2389] = {icon = 134400, exp = EXPANSION_NAME7, id = 2389, name = "Нери Остроерш", side = "-", category = "Battle for Azeroth", }, --[faction=2389]
	[2388] = {icon = 134400, exp = EXPANSION_NAME7, id = 2388, name = "Поэн Солежабрик", side = "-", category = "Battle for Azeroth", }, --[faction=2388]
	[2377] = {icon = 134400, exp = EXPANSION_NAME7, id = 2377, name = "Мастер клинка Иновари", side = "-", category = "Battle for Azeroth", }, --[faction=2377]
	[2376] = {icon = 134400, exp = EXPANSION_NAME7, id = 2376, name = "Оракул Ори", side = "-", category = "Battle for Azeroth", }, --[faction=2376]
	[2375] = {icon = 134400, exp = EXPANSION_NAME7, id = 2375, name = "Мастер охоты Акана", side = "-", category = "Battle for Azeroth", }, --[faction=2375]
	[2373] = {icon = 134400, exp = EXPANSION_NAME7, id = 2373, name = "Освобожденные", side = "Horde", category = "Battle for Azeroth", }, --[faction=2373
	[2370] = {icon = 134400, exp = EXPANSION_NAME7, id = 2370, name = "Обучение динозавров – Дикорог", side = "-", category = "Battle for Azeroth", }, --[faction=2370]
	[2233] = {icon = 134400, exp = EXPANSION_NAME7, id = 2233, name = "Dino Training - Pterrodax", side = "-", category = "Battle for Azeroth", }, --[faction=2233]
	[2164] = {icon = 134400, exp = EXPANSION_NAME7, id = 2164, name = "Защитники Азерот", side = "-", category = "Battle for Azeroth", }, --[faction=2164]
	[2163] = {icon = 134400, exp = EXPANSION_NAME7, id = 2163, name = "Тортолланские искатели", side = "-", category = "Battle for Azeroth", }, --[faction=2163]
	[2162] = {icon = 134400, exp = EXPANSION_NAME7, id = 2162, name = "Орден Возрождения Шторма", side = "-", category = "Battle for Azeroth", }, --[faction=2162]
	[2161] = {icon = 134400, exp = EXPANSION_NAME7, id = 2161, name = "Орден Пылающих Углей", side = "-", category = "Battle for Azeroth", }, --[faction=2161]
	[2160] = {icon = 134400, exp = EXPANSION_NAME7, id = 2160, name = "Адмиралтейство Праудмуров", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2160]
	[2159] = {icon = 134400, exp = EXPANSION_NAME7, id = 2159, name = "7-й легион", side = "-", category = "Battle for Azeroth", }, --[faction=2159]
	[2158] = {icon = 134400, exp = EXPANSION_NAME7, id = 2158, name = "Жители Вол'дуна", side = "Horde", category = "Battle for Azeroth", }, --[faction=2158]
	[2157] = {icon = 134400, exp = EXPANSION_NAME7, id = 2157, name = "Армия Чести", side = "-", category = "Battle for Azeroth", }, --[faction=2157]
	[2156] = {icon = 134400, exp = EXPANSION_NAME7, id = 2156, name = "Экспедиция Таланджи", side = "-", category = "Battle for Azeroth", }, --[faction=2156]
	[2111] = {icon = 134400, exp = EXPANSION_NAME7, id = 2111, name = "Зандаларские динозавры", side = "-", category = "Battle for Azeroth", }, --[faction=2111]
	[2103] = {icon = 134400, exp = EXPANSION_NAME7, id = 2103, name = "Империя Зандалари", side = "Horde", category = "Battle for Azeroth", }, --[faction=2103]
	----------------------------------------------------------------
	[2398] = {icon = 134400, exp = EXPANSION_NAME7, id = 2398, name = "Фуражир из улья Медокрылов", side = "-", category = "Другое", }, --[faction=2398]
	[2397] = {icon = 134400, exp = EXPANSION_NAME7, id = 2397, name = "Пчеломатка улья Медокрылов", side = "-", category = "Другое", }, --[faction=2397]
	[2396] = {icon = 134400, exp = EXPANSION_NAME7, id = 2396, name = "Трутень из улья Медокрылов", side = "-", category = "Другое", }, --[faction=2396]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2170] = {icon = 134400, exp = EXPANSION_NAME6, id = 2170, name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
	[2165] = {icon = 134400, exp = EXPANSION_NAME6, id = 2165, name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
	[2135] = {icon = 134400, exp = EXPANSION_NAME6, id = 2135, name = "Хроми", side = "-", category = "Legion", }, --[faction=2135]
	[2102] = {icon = 134400, exp = EXPANSION_NAME6, id = 2102, name = "Бесс", side = "-", category = "Legion", }, --[faction=2102]
	[2101] = {icon = 134400, exp = EXPANSION_NAME6, id = 2101, name = "Ша'лет", side = "-", category = "Legion", }, --[faction=2101]
	[2100] = {icon = 134400, exp = EXPANSION_NAME6, id = 2100, name = "Корбин", side = "-", category = "Legion", }, --[faction=2100]
	[2099] = {icon = 134400, exp = EXPANSION_NAME6, id = 2099, name = "Акуле Речной Рог", side = "-", category = "Legion", }, --[faction=2099]
	[2098] = {icon = 134400, exp = EXPANSION_NAME6, id = 2098, name = "Хранительница Рейна", side = "-", category = "Legion", }, --[faction=2098]
	[2097] = {icon = 134400, exp = EXPANSION_NAME6, id = 2097, name = "Илиссия Водная", side = "-", category = "Legion", }, --[faction=2097]
	[2045] = {icon = 134400, exp = EXPANSION_NAME6, id = 2045, name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]
	[2018] = {icon = 134400, exp = EXPANSION_NAME6, id = 2018, name = "Отмщение Когтя", side = "-", category = "Legion", }, --[faction=2018]
	[1984] = {icon = 134400, exp = EXPANSION_NAME6, id = 1984, name = "Спасатели", side = "-", category = "Legion", }, --[faction=1984]
	[1975] = {icon = 134400, exp = EXPANSION_NAME6, id = 1975, name = "Кудесник Маргосс", side = "-", category = "Legion", }, --[faction=1975]
	[1948] = {icon = 134400, exp = EXPANSION_NAME6, id = 1948, name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]
	[1900] = {icon = 134400, exp = EXPANSION_NAME6, id = 1900, name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
	[1899] = {icon = 134400, exp = EXPANSION_NAME6, id = 1899, name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1899]
	[1894] = {icon = 134400, exp = EXPANSION_NAME6, id = 1894, name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
	[1883] = {icon = 134400, exp = EXPANSION_NAME6, id = 1883, name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
	[1859] = {icon = 134400, exp = EXPANSION_NAME6, id = 1859, name = "Помраченные", side = "Horde", category = "Legion", }, --[faction=1859]
	[1828] = {icon = 134400, exp = EXPANSION_NAME6, id = 1828, name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
	[1815] = {icon = 134400, exp = EXPANSION_NAME6, id = 1815, name = "Выжившие из Гилнеаса", side = "-", category = "Legion", }, --[faction=1815]
	----------------------------------------------------------------
	[1919] = {icon = 134400, exp = EXPANSION_NAME6, id = 1919, name = "Жажда магии Вальтруа", side = "-", category = "Помраченные", }, --[faction=1919]
	[1862] = {icon = 134400, exp = EXPANSION_NAME6, id = 1862, name = "Жажда магии Окулета", side = "-", category = "Помраченные", }, --[faction=1862]
	[1860] = {icon = 134400, exp = EXPANSION_NAME6, id = 1860, name = "Жажда магии Талисры", side = "-", category = "Помраченные", }, --[faction=1860]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1850] = {icon = 134400, exp = EXPANSION_NAME5, id = 1850, name = "Охотники за саблеронами", side = "-", category = "Warlords of Draenor", }, --[faction=1850]
	[1849] = {icon = 134400, exp = EXPANSION_NAME5, id = 1849, name = "Орден Пробудившихся", side = "-", category = "Warlords of Draenor", }, --[faction=1849]
	[1848] = {icon = 134400, exp = EXPANSION_NAME5, id = 1848, name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848]
	[1847] = {icon = 134400, exp = EXPANSION_NAME5, id = 1847, name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847]
	[1735] = {icon = 134400, exp = EXPANSION_NAME5, id = 1735, name = "Телохранители из казарм", side = "-", category = "Warlords of Draenor", }, --[faction=1735]
	[1732] = {icon = 134400, exp = EXPANSION_NAME5, id = 1732, name = "Дренорcкая Экспедиция Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1732]
	[1731] = {icon = 134400, exp = EXPANSION_NAME5, id = 1731, name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731]
	[1711] = {icon = 134400, exp = EXPANSION_NAME5, id = 1711, name = "Археологическое общество Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1711]
	[1710] = {icon = 134400, exp = EXPANSION_NAME5, id = 1710, name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710]
	[1708] = {icon = 134400, exp = EXPANSION_NAME5, id = 1708, name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708]
	[1520] = {icon = 134400, exp = EXPANSION_NAME5, id = 1520, name = "Изгнанники клана Призрачной Луны", side = "-", category = "Warlords of Draenor", }, --[faction=1520]
	[1515] = {icon = 134400, exp = EXPANSION_NAME5, id = 1515, name = "Араккоа-изгои", side = "-", category = "Warlords of Draenor", }, --[faction=1515]
	[1445] = {icon = 134400, exp = EXPANSION_NAME5, id = 1445, name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445]
	----------------------------------------------------------------
	[1741] = {icon = 134400, exp = EXPANSION_NAME5, id = 1741, name = "Леорадж", side = "-", category = "Телохранители из казарм", }, --[faction=1741]
	[1740] = {icon = 134400, exp = EXPANSION_NAME5, id = 1740, name = "Аеда Ясная Заря", side = "-", category = "Телохранители из казарм", }, --[faction=1740]
	[1739] = {icon = 134400, exp = EXPANSION_NAME5, id = 1739, name = "Вивианна", side = "-", category = "Телохранители из казарм", }, --[faction=1739]
	[1738] = {icon = 134400, exp = EXPANSION_NAME5, id = 1738, name = "Защитница Иллона", side = "-", category = "Телохранители из казарм", }, --[faction=1738]
	[1737] = {icon = 134400, exp = EXPANSION_NAME5, id = 1737, name = "Жрец Когтя Ишааль", side = "-", category = "Телохранители из казарм", }, --[faction=1737]
	[1736] = {icon = 134400, exp = EXPANSION_NAME5, id = 1736, name = "Тормок", side = "-", category = "Телохранители из казарм", }, --[faction=1736]
	[1733] = {icon = 134400, exp = EXPANSION_NAME5, id = 1733, name = "Делвар Железный Кулак", side = "-", category = "Телохранители из казарм", }, --[faction=1733]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1492] = {icon = 134400, exp = EXPANSION_NAME4, id = 1492, name = "Император Шаохао", side = "-", category = "Mists of Pandaria", }, --[faction=1492]
	[1440] = {icon = 134400, exp = EXPANSION_NAME4, id = 1440, name = "Восстание Черного Копья", side = "-", category = "Mists of Pandaria", }, --[faction=1440]
	[1435] = {icon = 134400, exp = EXPANSION_NAME4, id = 1435, name = "Натиск Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1435]
	[1388] = {icon = 134400, exp = EXPANSION_NAME4, id = 1388, name = "Войска Похитителей Солнца", side = "-", category = "Mists of Pandaria", }, --[faction=1388]
	[1387] = {icon = 134400, exp = EXPANSION_NAME4, id = 1387, name = "Армия Кирин-Тора", side = "-", category = "Mists of Pandaria", }, --[faction=1387]
	[1376] = {icon = 134400, exp = EXPANSION_NAME4, id = 1376, name = "Операция \"Заслон\"", side = "-", category = "Mists of Pandaria", }, --[faction=1376]
	[1375] = {icon = 134400, exp = EXPANSION_NAME4, id = 1375, name = "Армия Покорителей", side = "-", category = "Mists of Pandaria", }, --[faction=1375
	[1359] = {icon = 134400, exp = EXPANSION_NAME4, id = 1359, name = "Черный принц", side = "-", category = "Mists of Pandaria", }, --[faction=1359]
	[1351] = {icon = 134400, exp = EXPANSION_NAME4, id = 1351, name = "Хмелевары", side = "-", category = "Mists of Pandaria", }, --[faction=1351]
	[1345] = {icon = 134400, exp = EXPANSION_NAME4, id = 1345, name = "Хранители истории", side = "-", category = "Mists of Pandaria", }, --[faction=1345]
	[1341] = {icon = 134400, exp = EXPANSION_NAME4, id = 1341, name = "Небожители", side = "-", category = "Mists of Pandaria", }, --[faction=1341]
	[1337] = {icon = 134400, exp = EXPANSION_NAME4, id = 1337, name = "Клакси", side = "-", category = "Mists of Pandaria", }, --[faction=1337]
	[1302] = {icon = 134400, exp = EXPANSION_NAME4, id = 1302, name = "Рыболовы", side = "-", category = "Mists of Pandaria", }, --[faction=1302]
	[1272] = {icon = 134400, exp = EXPANSION_NAME4, id = 1272, name = "Земледельцы", side = "-", category = "Mists of Pandaria", }, --[faction=1272]
	[1271] = {icon = 134400, exp = EXPANSION_NAME4, id = 1271, name = "Орден Облачного Змея", side = "-", category = "Mists of Pandaria", }, --[faction=1271]
	[1270] = {icon = 134400, exp = EXPANSION_NAME4, id = 1270, name = "Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1270]
	[1269] = {icon = 134400, exp = EXPANSION_NAME4, id = 1269, name = "Золотой Лотос", side = "-", category = "Mists of Pandaria", }, --[faction=1269]
	[1242] = {icon = 134400, exp = EXPANSION_NAME4, id = 1242, name = "Цзинь-юй Жемчужного Плавника", side = "-", category = "Mists of Pandaria", }, --[faction=1242]
	[1228] = {icon = 134400, exp = EXPANSION_NAME4, id = 1228, name = "Лесные хозены", side = "-", category = "Mists of Pandaria", }, --[faction=1228]
	[1216] = {icon = 134400, exp = EXPANSION_NAME4, id = 1216, name = "Академия Шан Си", side = "-", category = "Mists of Pandaria", }, --[faction=1216]
	----------------------------------------------------------------
	[1283] = {icon = 134400, exp = EXPANSION_NAME4, id = 1283, name = "Фермер Фун", side = "-", category = "Земледельцы", }, --[faction=1283]
	[1282] = {icon = 134400, exp = EXPANSION_NAME4, id = 1282, name = "Рыба Тростниковая Шкура", side = "-", category = "Земледельцы", }, --[faction=1282]
	[1281] = {icon = 134400, exp = EXPANSION_NAME4, id = 1281, name = "Джина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1281]
	[1280] = {icon = 134400, exp = EXPANSION_NAME4, id = 1280, name = "Тина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1280]
	[1279] = {icon = 134400, exp = EXPANSION_NAME4, id = 1279, name = "Хаохань Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1279]
	[1278] = {icon = 134400, exp = EXPANSION_NAME4, id = 1278, name = "Шо", side = "-", category = "Земледельцы", }, --[faction=1278]
	[1277] = {icon = 134400, exp = EXPANSION_NAME4, id = 1277, name = "Чи-Чи", side = "-", category = "Земледельцы", }, --[faction=1277]
	[1276] = {icon = 134400, exp = EXPANSION_NAME4, id = 1276, name = "Старик Горная Лапа", side = "-", category = "Земледельцы", }, --[faction=1276]
	[1275] = {icon = 134400, exp = EXPANSION_NAME4, id = 1275, name = "Элла", side = "-", category = "Земледельцы", }, --[faction=1275]
	[1273] = {icon = 134400, exp = EXPANSION_NAME4, id = 1273, name = "Йогу Пьяный", side = "-", category = "Земледельцы", }, --[faction=1273]
	----------------------------------------------------------------
	[1358] = {icon = 134400, exp = EXPANSION_NAME4, id = 1358, name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
	----------------------------------------------------------------
	[1357] = {icon = 134400, exp = EXPANSION_NAME4, id = 1357, name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1204] = {icon = 134400, exp = EXPANSION_NAME3, id = 1204, name = "Хиджальские мстители", side = "-", category = "Cataclysm", }, --[faction=1204]
	[1178] = {icon = 134400, exp = EXPANSION_NAME3, id = 1178, name = "Батальон Адского Крика", side = "-", category = "Cataclysm", }, --[faction=1178]
	[1177] = {icon = 134400, exp = EXPANSION_NAME3, id = 1177, name = "Защитники Тол Барада", side = "-", category = "Cataclysm", }, --[faction=1177]
	[1174] = {icon = 134400, exp = EXPANSION_NAME3, id = 1174, name = "Клан Громового Молота", side = "-", category = "Cataclysm", }, --[faction=1174]
	[1173] = {icon = 134400, exp = EXPANSION_NAME3, id = 1173, name = "Рамкахены", side = "-", category = "Cataclysm", }, --[faction=1173]
	[1172] = {icon = 134400, exp = EXPANSION_NAME3, id = 1172, name = "Клан Драконьей Пасти", side = "-", category = "Cataclysm", }, --[faction=1172]
	[1171] = {icon = 134400, exp = EXPANSION_NAME3, id = 1171, name = "Теразан", side = "-", category = "Cataclysm", }, --[faction=1171]
	[1158] = {icon = 134400, exp = EXPANSION_NAME3, id = 1158, name = "Стражи Хиджала", side = "-", category = "Cataclysm", }, --[faction=1158]
	[1135] = {icon = 134400, exp = EXPANSION_NAME3, id = 1135, name = "Служители Земли", side = "-", category = "Cataclysm", }, --[faction=1135]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1156] = {icon = 134400, exp = EXPANSION_NAME2, id = 1156, name = "Пепельный союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1156]
	[1119] = {icon = 134400, exp = EXPANSION_NAME2, id = 1119, name = "Сыны Ходира", side = "-", category = "Wrath of the Lich King", }, --[faction=1119]
	[1117] = {icon = 134400, exp = EXPANSION_NAME2, id = 1117, name = "Низина Шолазар", side = "-", category = "Wrath of the Lich King", }, --[faction=1117]
	[1106] = {icon = 134400, exp = EXPANSION_NAME2, id = 1106, name = "Серебряный Авангард", side = "-", category = "Wrath of the Lich King", }, --[faction=1106]
	[1098] = {icon = 134400, exp = EXPANSION_NAME2, id = 1098, name = "Рыцари Черного Клинка", side = "-", category = "Wrath of the Lich King", }, --[faction=1098]
	[1091] = {icon = 134400, exp = EXPANSION_NAME2, id = 1091, name = "Драконий союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1091]
	[1090] = {icon = 134400, exp = EXPANSION_NAME2, id = 1090, name = "Кирин-Тор", side = "-", category = "Wrath of the Lich King", }, --[faction=1090]
	[1073] = {icon = 134400, exp = EXPANSION_NAME2, id = 1073, name = "Калу'ак", side = "-", category = "Wrath of the Lich King", }, --[faction=1073]
	[1052] = {icon = 134400, exp = EXPANSION_NAME2, id = 1052, name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052]
	[1037] = {icon = 134400, exp = EXPANSION_NAME2, id = 1037, name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037] -- ХЕДЕР ВНУТРЕННИЙ
	----------------------------------------------------------------
	[1105] = {icon = 134400, exp = EXPANSION_NAME2, id = 1105, name = "Оракулы", side = "-", category = "Низина Шолазар", }, --[faction=1105]
	[1104] = {icon = 134400, exp = EXPANSION_NAME2, id = 1104, name = "Племя Бешеного Сердца", side = "-", category = "Низина Шолазар", }, --[faction=1104]
	----------------------------------------------------------------
	[1124] = {icon = 134400, exp = EXPANSION_NAME2, id = 1124, name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
	[1085] = {icon = 134400, exp = EXPANSION_NAME2, id = 1085, name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
	[1067] = {icon = 134400, exp = EXPANSION_NAME2, id = 1067, name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
	[1064] = {icon = 134400, exp = EXPANSION_NAME2, id = 1064, name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
	----------------------------------------------------------------
	[1126] = {icon = 134400, exp = EXPANSION_NAME2, id = 1126, name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
	[1094] = {icon = 134400, exp = EXPANSION_NAME2, id = 1094, name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
	[1068] = {icon = 134400, exp = EXPANSION_NAME2, id = 1068, name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
	[1050] = {icon = 134400, exp = EXPANSION_NAME2, id = 1050, name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1038] = {icon = 134400, exp = EXPANSION_NAME1, id = 1038, name = "Огри'ла", side = "-", category = "The Burning Crusade", }, --[faction=1038]
	[1015] = {icon = 134400, exp = EXPANSION_NAME1, id = 1015, name = "Крылья Пустоты", side = "-", category = "The Burning Crusade", }, --[faction=1015]
	[1012] = {icon = 134400, exp = EXPANSION_NAME1, id = 1012, name = "Пеплоусты-служители", side = "-", category = "The Burning Crusade", }, --[faction=1012]
	[990] = {icon = 134400, exp = EXPANSION_NAME1, id = 990, name = "Песчаная Чешуя", side = "-", category = "The Burning Crusade", }, --[faction=990]
	[989] = {icon = 134400, exp = EXPANSION_NAME1, id = 989, name = "Хранители Времени", side = "-", category = "The Burning Crusade", }, --[faction=989]
	[978] = {icon = 134400, exp = EXPANSION_NAME1, id = 978, name = "Куренай", side = "-", category = "The Burning Crusade", }, --[faction=978]
	[970] = {icon = 134400, exp = EXPANSION_NAME1, id = 970, name = "Спореггар", side = "-", category = "The Burning Crusade", }, --[faction=970]
	[967] = {icon = 134400, exp = EXPANSION_NAME1, id = 967, name = "Аметистовое Око", side = "-", category = "The Burning Crusade", }, --[faction=967]
	[947] = {icon = 134400, exp = EXPANSION_NAME1, id = 947, name = "Траллмар", side = "-", category = "The Burning Crusade", }, --[faction=947]
	[946] = {icon = 134400, exp = EXPANSION_NAME1, id = 946, name = "Оплот Чести", side = "-", category = "The Burning Crusade", }, --[faction=946]
	[942] = {icon = 134400, exp = EXPANSION_NAME1, id = 942, name = "Кенарийская экспедиция", side = "-", category = "The Burning Crusade", }, --[faction=942]
	[941] = {icon = 134400, exp = EXPANSION_NAME1, id = 941, name = "Маг'хары", side = "-", category = "The Burning Crusade", }, --[faction=941]
	[936] = {icon = 134400, exp = EXPANSION_NAME1, id = 936, name = "Город Шаттрат", side = "-", category = "The Burning Crusade", }, --[faction=936]
	[933] = {icon = 134400, exp = EXPANSION_NAME1, id = 933, name = "Консорциум", side = "-", category = "The Burning Crusade", }, --[faction=933]
	[922] = {icon = 134400, exp = EXPANSION_NAME1, id = 922, name = "Транквиллион", side = "-", category = "The Burning Crusade", }, --[faction=922]
	----------------------------------------------------------------
	[1077] = {icon = 134400, exp = EXPANSION_NAME1, id = 1077, name = "Армия Расколотого Солнца", side = "-", category = "Город Шаттрат", }, --[faction=1077]
	[1031] = {icon = 134400, exp = EXPANSION_NAME1, id = 1031, name = "Стражи небес Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=1031]
	[1011] = {icon = 134400, exp = EXPANSION_NAME1, id = 1011, name = "Нижний Город", side = "-", category = "Город Шаттрат", }, --[faction=1011]
	[935] = {icon = 134400, exp = EXPANSION_NAME1, id = 935, name = "Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=935]
	[934] = {icon = 134400, exp = EXPANSION_NAME1, id = 934, name = "Провидцы", side = "-", category = "Город Шаттрат", }, --[faction=934]
	[932] = {icon = 134400, exp = EXPANSION_NAME1, id = 932, name = "Алдоры", side = "-", category = "Город Шаттрат", }, --[faction=932]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[910] = {icon = 134400, exp = EXPANSION_NAME0, id = 910, name = "Род Ноздорму", side = "-", category = "World of Warcraft", }, --[faction=910]
	[909] = {icon = 134400, exp = EXPANSION_NAME0, id = 909, name = "Ярмарка Новолуния", side = "-", category = "World of Warcraft", }, --[faction=909]
	[809] = {icon = 134400, exp = EXPANSION_NAME0, id = 809, name = "Шен'дралар", side = "-", category = "World of Warcraft", }, --[faction=809]
	[749] = {icon = 134400, exp = EXPANSION_NAME0, id = 749, name = "Гидраксианские Повелители Вод", side = "-", category = "World of Warcraft", }, --[faction=749]
	[609] = {icon = 134400, exp = EXPANSION_NAME0, id = 609, name = "Круг Кенария", side = "-", category = "World of Warcraft", }, --[faction=609]
	[589] = {icon = 134400, exp = EXPANSION_NAME0, id = 589, name = "Укротители ледопардов", side = "-", category = "World of Warcraft", }, --[faction=589]
	[576] = {icon = 134400, exp = EXPANSION_NAME0, id = 576, name = "Древобрюхи", side = "-", category = "World of Warcraft", }, --[faction=576]
	[529] = {icon = 134400, exp = EXPANSION_NAME0, id = 529, name = "Серебряный Рассвет", side = "-", category = "World of Warcraft", }, --[faction=529]
	[469] = {icon = 134400, exp = EXPANSION_NAME0, id = 469, name = "Альянс", side = "Alliance", category = "World of Warcraft", }, --[faction=469]
	[349] = {icon = 134400, exp = EXPANSION_NAME0, id = 349, name = "Черный Ворон", side = "-", category = "World of Warcraft", }, --[faction=349]
	[270] = {icon = 134400, exp = EXPANSION_NAME0, id = 270, name = "Племя Зандалари", side = "-", category = "World of Warcraft", }, --[faction=270]
	[169] = {icon = 134400, exp = EXPANSION_NAME0, id = 169, name = "Картель Хитрой Шестеренки", side = "-", category = "World of Warcraft", }, --[faction=169]
	[93] = {icon = 134400, exp = EXPANSION_NAME0, id = 93, name = "Кентавры из племени Маграм", side = "-", category = "World of Warcraft", }, --[faction=93]
	[92] = {icon = 134400, exp = EXPANSION_NAME0, id = 92, name = "Кентавры из племени Гелкис", side = "-", category = "World of Warcraft", }, --[faction=92]
	[87] = {icon = 134400, exp = EXPANSION_NAME0, id = 87, name = "Пираты Кровавого Паруса", side = "-", category = "World of Warcraft", }, --[faction=87]
	[70] = {icon = 134400, exp = EXPANSION_NAME0, id = 70, name = "Синдикат", side = "-", category = "World of Warcraft", }, --[faction=70]
	[67] = {icon = 134400, exp = EXPANSION_NAME0, id = 67, name = "Орда", side = "Horde", category = "World of Warcraft", }, --[faction=67]
	[59] = {icon = 134400, exp = EXPANSION_NAME0, id = 59, name = "Братство Тория", side = "-", category = "World of Warcraft", }, --[faction=59]
	----------------------------------------------------------------
	[2372] = {icon = 134400, exp = EXPANSION_NAME0, id = 2372, name = "Арена \"Морд'Бой\"", side = "-", category = "Силы Орды", }, --[faction=2372]
	[2010] = {icon = 134400, exp = EXPANSION_NAME0, id = 2010, name = "Арена \"Морд'Бой\" (3-й сезон)", side = "-", category = "Силы Орды", }, --[faction=2010]
	[1690] = {icon = 134400, exp = EXPANSION_NAME0, id = 1690, name = "Арена \"Морд'Бой\" (сезон 2)", side = "-", category = "Силы Орды", }, --[faction=1690]
	[1681] = {icon = 134400, exp = EXPANSION_NAME0, id = 1681, name = "Копье Вол'джина", side = "-", category = "Силы Орды", }, --[faction=1681]
	[1374] = {icon = 134400, exp = EXPANSION_NAME0, id = 1374, name = "Арена \"Морд'Бой\" (сезон 1)", side = "-", category = "Силы Орды", }, --[faction=1374]
	[889] = {icon = 134400, exp = EXPANSION_NAME0, id = 889, name = "Всадники Песни Войны", side = "-", category = "Силы Орды", }, --[faction=889]
	[729] = {icon = 134400, exp = EXPANSION_NAME0, id = 729, name = "Азеротский клан Северного Волка", side = "-", category = "Силы Орды", }, --[faction=729]
	[510] = {icon = 134400, exp = EXPANSION_NAME0, id = 510, name = "Осквернители", side = "-", category = "Силы Орды", }, --[faction=510]
	----------------------------------------------------------------
	[577] = {icon = 134400, exp = EXPANSION_NAME0, id = 577, name = "Круговзор", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=577]
	[470] = {icon = 134400, exp = EXPANSION_NAME0, id = 470, name = "Кабестан", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=470]
	[369] = {icon = 134400, exp = EXPANSION_NAME0, id = 369, name = "Прибамбасск", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=369]
	[21] = {icon = 134400, exp = EXPANSION_NAME0, id = 21, name = "Пиратская Бухта", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=21]
	----------------------------------------------------------------
	[2523] = {icon = 134400, exp = EXPANSION_NAME0, id = 2523, name = "Темные Когти", side = "Horde", category = "Орда", }, --[faction=2523]
	[1352] = {icon = 134400, exp = EXPANSION_NAME0, id = 1352, name = "Пандарены Хоцзинь", side = "-", category = "Орда", }, --[faction=1352]
	[1133] = {icon = 134400, exp = EXPANSION_NAME0, id = 1133, name = "Картель Трюмных Вод", side = "-", category = "Орда", }, --[faction=1133]
	[911] = {icon = 134400, exp = EXPANSION_NAME0, id = 911, name = "Луносвет", side = "Horde", category = "Орда", }, --[faction=911]
	[530] = {icon = 134400, exp = EXPANSION_NAME0, id = 530, name = "Племя Черного Копья", side = "Horde", category = "Орда", }, --[faction=530]
	[81] = {icon = 134400, exp = EXPANSION_NAME0, id = 81, name = "Громовой Утес", side = "Horde", category = "Орда", }, --[faction=81]
	[76] = {icon = 134400, exp = EXPANSION_NAME0, id = 76, name = "Оргриммар", side = "Horde", category = "Орда", }, --[faction=76]
	[68] = {icon = 134400, exp = EXPANSION_NAME0, id = 68, name = "Подгород", side = "Horde", category = "Орда", }, --[faction=68]
	----------------------------------------------------------------
	[2371] = {icon = 134400, exp = EXPANSION_NAME0, id = 2371, name = "Потасовочная \"У Бизмо\"", side = "-", category = "Силы Альянса", }, --[faction=2371]
	[2011] = {icon = 134400, exp = EXPANSION_NAME0, id = 2011, name = "Потасовочная \"У Бизмо\" (3-й сезон)", side = "-", category = "Силы Альянса", }, --[faction=2011
	[1691] = {icon = 134400, exp = EXPANSION_NAME0, id = 1691, name = "Потасовочная \"У Бизмо\" (сезон 2)", side = "-", category = "Силы Альянса", }, --[faction=1691
	[1682] = {icon = 134400, exp = EXPANSION_NAME0, id = 1682, name = "Авангард Ринна", side = "-", category = "Силы Альянса", }, --[faction=1682
	[1419] = {icon = 134400, exp = EXPANSION_NAME0, id = 1419, name = "Потасовочная \"У Бизмо\" (сезон 1)", side = "-", category = "Силы Альянса", }, --[faction=1419]
	[890] = {icon = 134400, exp = EXPANSION_NAME0, id = 890, name = "Среброкрылые Часовые", side = "-", category = "Силы Альянса", }, --[faction=890
	[730] = {icon = 134400, exp = EXPANSION_NAME0, id = 730, name = "Стража Грозовой Вершины", side = "-", category = "Силы Альянса", }, --[faction=730
	[509] = {icon = 134400, exp = EXPANSION_NAME0, id = 509, name = "Лига Аратора", side = "-", category = "Силы Альянса", }, --[faction=509]
	----------------------------------------------------------------
	[2524] = {icon = 134400, exp = EXPANSION_NAME0, id = 2524, name = "Обсидиановые Хранители", side = "Alliance", category = "Альянс", }, --[faction=2524]
	[1353] = {icon = 134400, exp = EXPANSION_NAME0, id = 1353, name = "Пандарены Тушуй", side = "Alliance", category = "Альянс", }, --[faction=1353]
	[1134] = {icon = 134400, exp = EXPANSION_NAME0, id = 1134, name = "Гилнеас", side = "Alliance", category = "Альянс", }, --[faction=1134]
	[930] = {icon = 134400, exp = EXPANSION_NAME0, id = 930, name = "Экзодар", side = "Alliance", category = "Альянс", }, --[faction=930]
	[72] = {icon = 134400, exp = EXPANSION_NAME0, id = 72, name = "Штормград", side = "Alliance", category = "Альянс", }, --[faction=72]
	[69] = {icon = 134400, exp = EXPANSION_NAME0, id = 69, name = "Дарнас", side = "Alliance", category = "Альянс", }, --[faction=69]
	[54] = {icon = 134400, exp = EXPANSION_NAME0, id = 54, name = "Гномреган", side = "Alliance", category = "Альянс", }, --[faction=54]
	[47] = {icon = 134400, exp = EXPANSION_NAME0, id = 47, name = "Стальгорн", side = "Alliance", category = "Альянс", }, --[faction=47]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1168] = {exp = OTHER, id = 1168, name = "Гильдия", side = "-", category = "Гильдия", }, --[faction=1168]
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
}