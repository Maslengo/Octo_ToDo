local GlobalAddonName, E = ...
--------------------------------------------------------------------------------
E.OctoTable_Reputations = {
	-- ["DONTWORK"] = {
	-- { id = 2697, }, --name = "Chase's test faction (DNT)", side = "-", category = "Другое", }, --[faction=2697]
	-- { id = 2645, }, --name = "Земельники", side = "-", category = "Совет Дорногала", }, --[faction=2645]
	-- { id = 2604, }, --name = "Команда Бочконога (идеал)", side = "-", category = "Другое", }, --[faction=2604]
	-- { id = 2569, }, --name = "The War Within", side = "-", category = "Другое", }, --[faction=2569] -- ХЕДЕР?
	-- { id = 2554, }, --name = "Клан Тогус", side = "-", category = "Кентавры Маруук", }, --[faction=2554]
	-- { id = 2522, }, --name = "Клан Тирай", side = "-", category = "Кентавры Маруук", }, --[faction=2522]
	-- { id = 2513, }, --name = "Клан Он'ир", side = "-", category = "Кентавры Маруук", }, --[faction=2513]
	-- { id = 2512, }, --name = "Клан Айлааг", side = "-", category = "Кентавры Маруук", }, --[faction=2512]
	-- { id = 2509, }, --name = "Клан Шикаар", side = "-", category = "Кентавры Маруук", }, --[faction=2509]
	-- { id = 2506, }, --name = "Dragonflight", side = "-", category = "Другое", }, --[faction=2506] -- ХЕДЕР?
	-- { id = 2431, }, --name = "Owen Test", side = "-", category = "Другое", }, --[faction=2431]
	-- { id = 2422, }, --name = "Ночной народец", side = "-", category = "Дикая Охота", }, --[faction=2422]
	-- { id = 2414, }, --name = "Темные Земли", side = "-", category = "Другое", }, --[faction=2414] -- ХЕДЕР?
	-- { id = 2265, }, --name = "Кул-Тирас - долина Штормов", side = "-", category = "Орден Возрождения Шторма", }, --[faction=2265]
	-- { id = 2264, }, --name = "Кул-Тирас - Друствар", side = "-", category = "Орден Пылающих Углей", }, --[faction=2264]
	-- { id = 2167, }, --name = "Защитники Аргуса (идеал)", side = "-", category = "Другое", }, --[faction=2167]
	-- { id = 2120, }, --name = "Кул-Тирас - Тирагард", side = "Alliance", category = "Адмиралтейство Праудмуров", }, --[faction=2120]
	-- { id = 2104, }, --name = "Battle for Azeroth", side = "-", category = "Другое", }, --[faction=2104] -- ХЕДЕР
	-- { id = 2063, }, --name = "Arne Test - Paragon Reputation Stormwind", side = "-", category = "Другое", }, --[faction=2063]
	-- { id = 1834, }, --name = "Legion", side = "-", category = "Другое", }, --[faction=1834] -- ХЕДЕР?
	-- { id = 1444, }, --name = "Warlords of Draenor", side = "-", category = "Другое", }, --[faction=1444] -- ХЕДЕР?
	-- { id = 1245, }, --name = "Mists of Pandaria", side = "-", category = "Другое", }, --[faction=1245] -- ХЕДЕР?
	-- { id = 1162, }, --name = "Cataclysm", side = "-", category = "Другое", }, --[faction=1162] -- ХЕДЕР?
	-- { id = 1118, }, --name = "World of Warcraft", side = "-", category = "Другое", }, --[faction=1118] -- ХЕДЕР?
	-- { id = 1097, }, --name = "Wrath of the Lich King", side = "-", category = "Другое", }, --[faction=1097] -- ХЕДЕР?
	-- { id = 1072, }, --name = "[DNT] AC Major Faction Child Renown Test", side = "-", category = "Кентавры Маруук", }, --[faction=1072]
	-- { id = 949, }, --name = "Тестовая фракция 1", side = "-", category = "Другое", }, --[faction=949]
	-- { id = 948, }, --name = "Тестовая фракция 2", side = "-", category = "Тестовая фракция 1", }, --[faction=948]
	-- { id = 980, }, --name = "The Burning Crusade", side = "-", category = "Другое", }, --[faction=980] -- ХЕДЕР?
	-- { id = 892, }, --name = "Силы Орды", side = "-", category = "World of Warcraft", }, --[faction=892] -- ВНУТРЕННИЙ ХЕДЕР
	-- { id = 891, }, --name = "Силы Альянса", side = "-", category = "World of Warcraft", }, --[faction=891] -- ВНУТРЕННИЙ ХЕДЕР
	-- { id = 2695, }, --name = "Test Account Wide Stormwind (DNT)", side = "Alliance", category = "Альянс", }, --[faction=2695]
	-- { id = 1169, }, --name = "Гильдия", side = "-", category = "Другое", }, --[faction=1169] -- ХЕДЕР
	-- { id = 2166, }, --name = "Армия Света (идеал)", side = "-", category = "Legion", }, --[faction=2166]
	-- { id = 2091, }, --name = "Армия погибели Легиона (идеал)", side = "-", category = "Legion", }, --[faction=2091]
	-- { id = 2090, }, --name = "Стражи (идеал)", side = "-", category = "Legion", }, --[faction=2090]
	-- { id = 2089, }, --name = "Помраченные (идеал)", side = "-", category = "Legion", }, --[faction=2089]
	-- { id = 2088, }, --name = "Ткачи Снов (идеал)", side = "-", category = "Legion", }, --[faction=2088]
	-- { id = 2087, }, --name = "Двор Фарондиса (идеал)", side = "-", category = "Legion", }, --[faction=2087]
	-- { id = 2086, }, --name = "Валарьяры (идеал)", side = "-", category = "Legion", }, --[faction=2086]
	-- { id = 2085, }, --name = "Племена Крутогорья (идеал)", side = "-", category = "Legion", }, --[faction=2085]
	-- { id = 1989, }, --name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1989]
	-- { id = 1947, }, --name = "Иллидари", side = "-", category = "Legion", }, --[faction=1947]
	-- { id = 1888, }, --name = "Яндвикские врайкулы", side = "-", category = "Legion", }, --[faction=1888]
	-- { id = 2693, }, --name = "Путь участника вылазки (1-й сезон)", side = "-", category = "The War Within", }, --[faction=2693]
	-- { id = 2683, }, --name = "Вылазки: 2-й сезон", side = "-", category = "The War Within", }, --[faction=2683]
	-- { id = 2667, }, --name = "Картели Нижней Шахты (идеал)", side = "-", category = "The War Within", }, --[faction=2667]
	-- { id = 2644, }, --name = "Вылазки: 1-й сезон", side = "-", category = "The War Within", }, --[faction=2644]
	-- { id = 2613, }, --name = "Ассамблея глубин (идеал)", side = "-", category = "The War Within", }, --[faction=2613]
	-- { id = 2612, }, --name = "Совет Дорногала (идеал)", side = "-", category = "The War Within", }, --[faction=2612]
	-- { id = 2611, }, --name = "Арати Тайносводья (идеал)", side = "-", category = "The War Within", }, --[faction=2611]
	-- { id = 2596, }, --name = "Отрезанные нити (идеал)", side = "-", category = "The War Within", }, --[faction=2596]
	-- { id = 2649, }, --name = "Генерал (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2649]
	-- { id = 2648, }, --name = "Прядильщица (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2648]
	-- { id = 2647, }, --name = "Визирь (идеал)", side = "-", category = "Отрезанные нити", }, --[faction=2647]
	-- { id = 2684, }, --name = "Клуб лояльности Галаджио (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2684]
	-- { id = 2676, }, --name = "Картель Хитрой Шестеренки (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2676]
	-- { id = 2674, }, --name = "Картель Черноводья (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2674]
	-- { id = 2672, }, --name = "Картель Трюмных Вод (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2672]
	-- { id = 2670, }, --name = "Торговая компания (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2670]
	-- { id = 2668, }, --name = "Мрачные Решалы (идеал)", side = "-", category = "Картели Нижней Шахты", }, --[faction=2668]
	-- { id = 2575, }, --name = "Стражи Сна (идеал)", side = "-", category = "Dragonflight", }, --[faction=2575]
	-- { id = 2565, }, --name = "Лоаммские ниффы (идеал)", side = "-", category = "Dragonflight", }, --[faction=2565]
	-- { id = 2555, }, --name = "Клан Кейган", side = "-", category = "Dragonflight", }, --[faction=2555]
	-- { id = 2552, }, --name = "Союз Вальдраккена (идеал)", side = "-", category = "Dragonflight", }, --[faction=2552]
	-- { id = 2551, }, --name = "Искарские клыкарры (идеал)", side = "-", category = "Dragonflight", }, --[faction=2551]
	-- { id = 2542, }, --name = "Клан Укхел", side = "-", category = "Dragonflight", }, --[faction=2542]
	-- { id = 2521, }, --name = "Клан Нокуд (идеал)", side = "-", category = "Dragonflight", }, --[faction=2521]
	-- { id = 2520, }, --name = "Клан Нокхуд", side = "-", category = "Dragonflight", }, --[faction=2520]
	-- { id = 2508, }, --name = "Драконья экспедиция (идеал)", side = "-", category = "Dragonflight", }, --[faction=2508]
	-- { id = 2504, }, --name = "Кентавры Маруук (идеал)", side = "-", category = "Dragonflight", }, --[faction=2504]
	-- { id = 2479, }, --name = "Просветленные (идеал)", side = "-", category = "Темные Земли", }, --[faction=2479]
	-- { id = 2474, }, --name = "Ве'нари (идеал)", side = "-", category = "Темные Земли", }, --[faction=2474]
	-- { id = 2473, }, --name = "Кодекс архивариуса (идеал)", side = "-", category = "Темные Земли", }, --[faction=2473]
	-- { id = 2471, }, --name = "Легион Смерти (идеал)", side = "-", category = "Темные Земли", }, --[faction=2471]
	-- { id = 2444, }, --name = "Дикая Охота (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2444]
	-- { id = 2442, }, --name = "Двор Жнецов (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2442]
	-- { id = 2441, }, --name = "Перерожденные (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2441]
	-- { id = 2440, }, --name = "Неумирающая армия (Идеал)", side = "-", category = "Темные Земли", }, --[faction=2440]
	-- { id = 2418, }, --name = "Ульдумский союз (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2418]
	-- { id = 2416, }, --name = "Раджани (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2416]
	-- { id = 2401, }, --name = "Анкоа из клана Клинков Волн (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2401]
	-- { id = 2392, }, --name = "Ржавоболтское сопротивление (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2392]
	-- { id = 2387, }, --name = "Тортолланские искатели (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2387]
	-- { id = 2386, }, --name = "Защитники Азерот (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2386]
	-- { id = 2385, }, --name = "Армия Чести (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2385]
	-- { id = 2384, }, --name = "7-й легион (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2384]
	-- { id = 2383, }, --name = "Орден Пылающих Углей (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2383]
	-- { id = 2382, }, --name = "Жители Вол'дуна (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2382]
	-- { id = 2381, }, --name = "Орден Возрождения Шторма (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2381]
	-- { id = 2380, }, --name = "Экспедиция Таланджи (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2380]
	-- { id = 2379, }, --name = "Адмиралтейство Праудмуров (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2379]
	-- { id = 2378, }, --name = "Империя Зандалари (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2378]
	-- { id = 2374, }, --name = "Освобожденные (идеал)", side = "-", category = "Battle for Azeroth", }, --[faction=2374]
	-- { id = 1861, }, --name = "Arcane Thirst (Silgryn) DEPRECATED", side = "-", category = "Помраченные", }, --[faction=1861]
	-- { id = 1815, }, --name = "Выжившие из Гилнеаса", side = "-", category = "Legion", }, --[faction=1815]
	-- { id = 1984, }, --name = "Спасатели", side = "-", category = "Legion", }, --[faction=1984]
	-- { id = 1899, }, --name = "Лунные стражи", side = "-", category = "Legion", }, --[faction=1899]
	-- { id = 2111, }, --name = "Зандаларские динозавры", side = "-", category = "Battle for Azeroth", }, --[faction=2111]
	-- },
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[11] = {
		header = {icon = E.OctoTable_Expansions[11].icon, name = E.OctoTable_Expansions[11].color..E.OctoTable_Expansions[11].name.."|r",},

		-- ["The War Within"] = {
		{ id = 2653, }, --name = "Картели Нижней Шахты", side = "-", category = "The War Within", }, --[faction=2653]
		{ id = 2640, }, --name = "Бранн Бронзобород", side = "-", category = "The War Within", }, --[faction=2640]
		{ id = 2600, }, --name = "Отрезанные нити", side = "-", category = "The War Within", }, --[faction=2600]
		{ id = 2594, }, --name = "Ассамблея глубин", side = "-", category = "The War Within", }, --[faction=2594]
		{ id = 2590, }, --name = "Совет Дорногала", side = "-", category = "The War Within", }, --[faction=2590]
		{ id = 2570, }, --name = "Арати Тайносводья", side = "-", category = "The War Within", }, --[faction=2570]
		----------------------------------------------------------------
		{ id = 2607, }, --name = "Визирь", side = "-", category = "Отрезанные нити", }, --[faction=2607]
		{ id = 2605, }, --name = "Генерал", side = "-", category = "Отрезанные нити", }, --[faction=2605]
		{ id = 2601, }, --name = "Прядильщица", side = "-", category = "Отрезанные нити", }, --[faction=2601]
		----------------------------------------------------------------
		{ id = 2685, }, --name = "Клуб лояльности Галаджио", side = "-", category = "Картели Нижней Шахты", }, --[faction=2685]
		{ id = 2677, }, --name = "Картель Хитрой Шестеренки", side = "-", category = "Картели Нижней Шахты", }, --[faction=2677]
		{ id = 2675, }, --name = "Картель Черноводья", side = "-", category = "Картели Нижней Шахты", }, --[faction=2675]
		{ id = 2673, }, --name = "Картель Трюмных Вод", side = "-", category = "Картели Нижней Шахты", }, --[faction=2673]
		{ id = 2671, }, --name = "Торговая компания", side = "-", category = "Картели Нижней Шахты", }, --[faction=2671]
		{ id = 2669, }, --name = "Мрачные Решалы", side = "-", category = "Картели Нижней Шахты", }, --[faction=2669]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[10] = {
		header = {icon = E.OctoTable_Expansions[10].icon, name = E.OctoTable_Expansions[10].color..E.OctoTable_Expansions[10].name.."|r",},
		-- ["Dragonflight"] = {
		{ id = 2507, }, --name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
		{ id = 2574, }, --name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
		{ id = 2511, }, --name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
		{ id = 2564, }, --name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
		{ id = 2503, }, --name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]


		{ id = 2510, }, --name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
		----------------------------------------------------------------
		{ id = 2550, }, --name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
		{ id = 2544, }, --name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
		{ id = 2553, }, --name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
		{ id = 2518, }, --name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
		{ id = 2517, }, --name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
		----------------------------------------------------------------
		{ id = 2568, }, --name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
		----------------------------------------------------------------
		{ id = 2615, }, --name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
		----------------------------------------------------------------
		{ id = 2593, }, --name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
		{ id = 2526, }, --name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[9] = {
		header = {icon = E.OctoTable_Expansions[9].icon, name = E.OctoTable_Expansions[9].color..E.OctoTable_Expansions[9].name.."|r",},
		-- ["Shadowlands"] = {
		{ id = 2413, }, --name = "Двор Жнецов", side = "-", category = "Темные Земли", }, --[faction=2413]
		{ id = 2464, }, --name = "Двор Ночи", side = "-", category = "Темные Земли", }, --[faction=2464]
		{ id = 2470, }, --name = "Легион Смерти", side = "-", category = "Темные Земли", }, --[faction=2470]
		{ id = 2462, }, --name = "Штопальщики", side = "-", category = "Темные Земли", }, --[faction=2462]
		{ id = 2472, }, --name = "Кодекс архивариуса", side = "-", category = "Темные Земли", }, --[faction=2472]
		{ id = 2407, }, --name = "Перерожденные", side = "-", category = "Темные Земли", }, --[faction=2407]
		{ id = 2439, }, --name = "Нераскаявшиеся", side = "-", category = "Темные Земли", }, --[faction=2439]
		{ id = 2478, }, --name = "Просветленные", side = "-", category = "Темные Земли", }, --[faction=2478]
		{ id = 2410, }, --name = "Неумирающая армия", side = "-", category = "Темные Земли", }, --[faction=2410]
		{ id = 2465, }, --name = "Дикая Охота", side = "-", category = "Темные Земли", }, --[faction=2465]
		{ id = 2432, }, --name = "Ве'нари", side = "-", category = "Темные Земли", }, --[faction=2432]


		{ id = 2445, }, --name = "Пепельный двор", side = "-", category = "Темные Земли", }, --[faction=2445]





		{ id = 2469, }, --name = "Понимание фракталов", side = "-", category = "Темные Земли", }, --[faction=2469]
		{ id = 2463, }, --name = "Чесночник", side = "-", category = "Темные Земли", }, --[faction=2463]
		----------------------------------------------------------------
		{ id = 2455, }, --name = "Хранитель склепа Каззир", side = "-", category = "Пепельный двор", }, --[faction=2455]
		{ id = 2458, }, --name = "Клейя и Пелагий", side = "-", category = "Пепельный двор", }, --[faction=2458]
		{ id = 2453, }, --name = "Рендл и Дуборыл", side = "-", category = "Пепельный двор", }, --[faction=2453]
		{ id = 2460, }, --name = "Камнелоб", side = "-", category = "Пепельный двор", }, --[faction=2460]


		{ id = 2461, }, --name = "Изобретатель чумы Марилет", side = "-", category = "Пепельный двор", }, --[faction=2461]
		{ id = 2459, }, --name = "Сика", side = "-", category = "Пепельный двор", }, --[faction=2459]
		{ id = 2457, }, --name = "Великий мастер Воул", side = "-", category = "Пепельный двор", }, --[faction=2457]
		{ id = 2456, }, --name = "Дроман Алиот", side = "-", category = "Пепельный двор", }, --[faction=2456]
		{ id = 2454, }, --name = "Чуфа", side = "-", category = "Пепельный двор", }, --[faction=2454]
		{ id = 2452, }, --name = "Полемарх Адрест", side = "-", category = "Пепельный двор", }, --[faction=2452]
		{ id = 2451, }, --name = "Капитан-егерь Корейн", side = "-", category = "Пепельный двор", }, --[faction=2451]
		{ id = 2450, }, --name = "Александрос Могрейн", side = "-", category = "Пепельный двор", }, --[faction=2450]
		{ id = 2449, }, --name = "Графиня", side = "-", category = "Пепельный двор", }, --[faction=2449]
		{ id = 2448, }, --name = "Миканикос", side = "-", category = "Пепельный двор", }, --[faction=2448]
		{ id = 2447, }, --name = "Леди Лунная Ягода", side = "-", category = "Пепельный двор", }, --[faction=2447]
		{ id = 2446, }, --name = "Баронесса Вайш", side = "-", category = "Пепельный двор", }, --[faction=2446]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[8] = {
		header = {icon = E.OctoTable_Expansions[8].icon, name = E.OctoTable_Expansions[8].color..E.OctoTable_Expansions[8].name.."|r",},
		-- ["Battle for Azeroth"] = {
		{ id = 2164, }, --name = "Защитники Азерот", side = "-", category = "Battle for Azeroth", }, --[faction=2164]
		{ id = 2415, }, --name = "Раджани", side = "-", category = "Battle for Azeroth", }, --[faction=2415]
		{ id = 2391, }, --name = "Ржавоболтское сопротивление", side = "-", category = "Battle for Azeroth", }, --[faction=2391]
		{ id = 2163, }, --name = "Тортолланские искатели", side = "-", category = "Battle for Azeroth", }, --[faction=2163]
		{ id = 2417, }, --name = "Ульдумский союз", side = "-", category = "Battle for Azeroth", }, --[faction=2417]


		{ id = 2427, }, --name = "Молодой акир", side = "-", category = "Battle for Azeroth", }, --[faction=2427]



		{ id = 2157, }, --name = "Армия Чести", side = "Horde", category = "Battle for Azeroth", }, --[faction=2157]
		{ id = 2373, }, --name = "Освобожденные", side = "Horde", category = "Battle for Azeroth", }, --[faction=2373]
		{ id = 2158, }, --name = "Жители Вол'дуна", side = "Horde", category = "Battle for Azeroth", }, --[faction=2158]
		{ id = 2103, }, --name = "Империя Зандалари", side = "Horde", category = "Battle for Azeroth", }, --[faction=2103]
		{ id = 2156, }, --name = "Экспедиция Таланджи", side = "-", category = "Battle for Azeroth", }, --[faction=2156]
		{ id = 2233, }, --name = "Dino Training - Pterrodax", side = "Horde", category = "Battle for Azeroth", }, --[faction=2233]
		{ id = 2370, }, --name = "Обучение динозавров – Дикорог", side = "-", category = "Battle for Azeroth", }, --[faction=2370]
		{ id = 2390, }, --name = "Вим Соленодух", side = "Horde", category = "Battle for Azeroth", }, --[faction=2390]
		{ id = 2389, }, --name = "Нери Остроерш", side = "Horde", category = "Battle for Azeroth", }, --[faction=2389]
		{ id = 2388, }, --name = "Поэн Солежабрик", side = "Horde", category = "Battle for Azeroth", }, --[faction=2388]

		{ id = 2159, }, --name = "7-й легион", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2159]
		{ id = 2160, }, --name = "Адмиралтейство Праудмуров", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2160]
		{ id = 2400, }, --name = "Клинки Волн", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2400]
		{ id = 2162, }, --name = "Орден Возрождения Шторма", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2162]
		{ id = 2161, }, --name = "Орден Пылающих Углей", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2161]
		{ id = 2395, }, --name = "Улей Медокрылов", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2395]
		{ id = 2398, }, --name = "Фуражир из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2398]
		{ id = 2397, }, --name = "Пчеломатка улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2397]
		{ id = 2396, }, --name = "Трутень из улья Медокрылов", side = "Alliance", category = "Другое", }, --[faction=2396]
		{ id = 2376, }, --name = "Оракул Ори", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2376]
		{ id = 2375, }, --name = "Мастер охоты Акана", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2375]
		{ id = 2377, }, --name = "Мастер клинка Иновари", side = "Alliance", category = "Battle for Azeroth", }, --[faction=2377]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[7] = {
		header = {icon = E.OctoTable_Expansions[7].icon, name = E.OctoTable_Expansions[7].color..E.OctoTable_Expansions[7].name.."|r",},
		-- ["Legion"] = {
		{ id = 2170, }, --name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
		{ id = 2165, }, --name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
		{ id = 2045, }, --name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]
		{ id = 2018, }, --name = "Отмщение Когтя", side = "-", category = "Legion", }, --[faction=2018]
		{ id = 1948, }, --name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]
		{ id = 1900, }, --name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
		{ id = 1894, }, --name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
		{ id = 1883, }, --name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
		{ id = 1859, }, --name = "Помраченные", side = "-", category = "Legion", }, --[faction=1859]
		{ id = 1828, }, --name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
		----------------------------------------------------------------
		{ id = 2097, }, --name = "Илиссия Водная", side = "-", category = "Legion", }, --[faction=2097]
		{ id = 2099, }, --name = "Акуле Речной Рог", side = "-", category = "Legion", }, --[faction=2099]
		{ id = 2101, }, --name = "Ша'лет", side = "-", category = "Legion", }, --[faction=2101]
		{ id = 2100, }, --name = "Корбин", side = "-", category = "Legion", }, --[faction=2100]
		{ id = 2102, }, --name = "Бесс", side = "-", category = "Legion", }, --[faction=2102]
		{ id = 2098, }, --name = "Хранительница Рейна", side = "-", category = "Legion", }, --[faction=2098]
		----------------------------------------------------------------
		{ id = 1919, }, --name = "Жажда магии Вальтруа", side = "-", category = "Помраченные", }, --[faction=1919]
		{ id = 1862, }, --name = "Жажда магии Окулета", side = "-", category = "Помраченные", }, --[faction=1862]
		{ id = 1860, }, --name = "Жажда магии Талисры", side = "-", category = "Помраченные", }, --[faction=1860]
		----------------------------------------------------------------
		{ id = 2135, }, --name = "Хроми", side = "-", category = "Legion", }, --[faction=2135]
		----------------------------------------------------------------
		{ id = 1975, }, --name = "Кудесник Маргосс", side = "-", category = "Legion", }, --[faction=1975]
	},
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
	[6] = {
		header = {icon = E.OctoTable_Expansions[6].icon, name = E.OctoTable_Expansions[6].color..E.OctoTable_Expansions[6].name.."|r",},
		-- ["Warlords of Draenor"] = {
		{ id = 1850, }, --name = "Охотники за саблеронами", side = "-", category = "Warlords of Draenor", }, --[faction=1850]
		{ id = 1849, }, --name = "Орден Пробудившихся", side = "-", category = "Warlords of Draenor", }, --[faction=1849]
		{ id = 1848, }, --name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848]
		{ id = 1847, }, --name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847]
		{ id = 1735, }, --name = "Телохранители из казарм", side = "-", category = "Warlords of Draenor", }, --[faction=1735]
		{ id = 1732, }, --name = "Дренорcкая Экспедиция Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1732]
		{ id = 1731, }, --name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731]
		{ id = 1711, }, --name = "Археологическое общество Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1711]
		{ id = 1710, }, --name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710]
		{ id = 1708, }, --name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708]
		{ id = 1520, }, --name = "Изгнанники клана Призрачной Луны", side = "-", category = "Warlords of Draenor", }, --[faction=1520]
		{ id = 1515, }, --name = "Араккоа-изгои", side = "-", category = "Warlords of Draenor", }, --[faction=1515]
		{ id = 1445, }, --name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445]
		----------------------------------------------------------------
		{ id = 1741, }, --name = "Леорадж", side = "-", category = "Телохранители из казарм", }, --[faction=1741]
		{ id = 1740, }, --name = "Аеда Ясная Заря", side = "-", category = "Телохранители из казарм", }, --[faction=1740]
		{ id = 1739, }, --name = "Вивианна", side = "-", category = "Телохранители из казарм", }, --[faction=1739]
		{ id = 1738, }, --name = "Защитница Иллона", side = "-", category = "Телохранители из казарм", }, --[faction=1738]
		{ id = 1737, }, --name = "Жрец Когтя Ишааль", side = "-", category = "Телохранители из казарм", }, --[faction=1737]
		{ id = 1736, }, --name = "Тормок", side = "-", category = "Телохранители из казарм", }, --[faction=1736]
		{ id = 1733, }, --name = "Делвар Железный Кулак", side = "-", category = "Телохранители из казарм", }, --[faction=1733]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[5] = {
		header = {icon = E.OctoTable_Expansions[5].icon, name = E.OctoTable_Expansions[5].color..E.OctoTable_Expansions[5].name.."|r",},
		-- ["Mists of Pandaria"] = {
		{ id = 1492, }, --name = "Император Шаохао", side = "-", category = "Mists of Pandaria", }, --[faction=1492]
		{ id = 1440, }, --name = "Восстание Черного Копья", side = "-", category = "Mists of Pandaria", }, --[faction=1440]
		{ id = 1435, }, --name = "Натиск Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1435]
		{ id = 1388, }, --name = "Войска Похитителей Солнца", side = "-", category = "Mists of Pandaria", }, --[faction=1388]
		{ id = 1387, }, --name = "Армия Кирин-Тора", side = "-", category = "Mists of Pandaria", }, --[faction=1387]
		{ id = 1376, }, --name = "Операция \"Заслон\"", side = "-", category = "Mists of Pandaria", }, --[faction=1376]
		{ id = 1375, }, --name = "Армия Покорителей", side = "-", category = "Mists of Pandaria", }, --[faction=1375
		{ id = 1359, }, --name = "Черный принц", side = "-", category = "Mists of Pandaria", }, --[faction=1359]
		{ id = 1351, }, --name = "Хмелевары", side = "-", category = "Mists of Pandaria", }, --[faction=1351]
		{ id = 1345, }, --name = "Хранители истории", side = "-", category = "Mists of Pandaria", }, --[faction=1345]
		{ id = 1341, }, --name = "Небожители", side = "-", category = "Mists of Pandaria", }, --[faction=1341]
		{ id = 1337, }, --name = "Клакси", side = "-", category = "Mists of Pandaria", }, --[faction=1337]
		{ id = 1302, }, --name = "Рыболовы", side = "-", category = "Mists of Pandaria", }, --[faction=1302]
		{ id = 1272, }, --name = "Земледельцы", side = "-", category = "Mists of Pandaria", }, --[faction=1272]
		{ id = 1271, }, --name = "Орден Облачного Змея", side = "-", category = "Mists of Pandaria", }, --[faction=1271]
		{ id = 1270, }, --name = "Шадо-Пан", side = "-", category = "Mists of Pandaria", }, --[faction=1270]
		{ id = 1269, }, --name = "Золотой Лотос", side = "-", category = "Mists of Pandaria", }, --[faction=1269]
		{ id = 1242, }, --name = "Цзинь-юй Жемчужного Плавника", side = "-", category = "Mists of Pandaria", }, --[faction=1242]
		{ id = 1228, }, --name = "Лесные хозены", side = "-", category = "Mists of Pandaria", }, --[faction=1228]
		{ id = 1216, }, --name = "Академия Шан Си", side = "-", category = "Mists of Pandaria", }, --[faction=1216]
		----------------------------------------------------------------
		{ id = 1283, }, --name = "Фермер Фун", side = "-", category = "Земледельцы", }, --[faction=1283]
		{ id = 1282, }, --name = "Рыба Тростниковая Шкура", side = "-", category = "Земледельцы", }, --[faction=1282]
		{ id = 1281, }, --name = "Джина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1281]
		{ id = 1280, }, --name = "Тина Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1280]
		{ id = 1279, }, --name = "Хаохань Грязный Коготь", side = "-", category = "Земледельцы", }, --[faction=1279]
		{ id = 1278, }, --name = "Шо", side = "-", category = "Земледельцы", }, --[faction=1278]
		{ id = 1277, }, --name = "Чи-Чи", side = "-", category = "Земледельцы", }, --[faction=1277]
		{ id = 1276, }, --name = "Старик Горная Лапа", side = "-", category = "Земледельцы", }, --[faction=1276]
		{ id = 1275, }, --name = "Элла", side = "-", category = "Земледельцы", }, --[faction=1275]
		{ id = 1273, }, --name = "Йогу Пьяный", side = "-", category = "Земледельцы", }, --[faction=1273]
		----------------------------------------------------------------
		{ id = 1358, }, --name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
		----------------------------------------------------------------
		{ id = 1357, }, --name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[4] = {
		header = {icon = E.OctoTable_Expansions[4].icon, name = E.OctoTable_Expansions[4].color..E.OctoTable_Expansions[4].name.."|r",},
		-- ["Cataclysm"] = {
		{ id = 1204, }, --name = "Хиджальские мстители", side = "-", category = "Cataclysm", }, --[faction=1204]
		{ id = 1173, }, --name = "Рамкахены", side = "-", category = "Cataclysm", }, --[faction=1173]
		{ id = 1171, }, --name = "Теразан", side = "-", category = "Cataclysm", }, --[faction=1171]
		{ id = 1158, }, --name = "Стражи Хиджала", side = "-", category = "Cataclysm", }, --[faction=1158]
		{ id = 1135, }, --name = "Служители Земли", side = "-", category = "Cataclysm", }, --[faction=1135]
		----------------------------------------------------------------
		{ id = 1178, }, --name = "Батальон Адского Крика", side = "Horde", category = "Cataclysm", }, --[faction=1178]
		{ id = 1172, }, --name = "Клан Драконьей Пасти", side = "Horde", category = "Cataclysm", }, --[faction=1172]
		----------------------------------------------------------------
		{ id = 1177, }, --name = "Защитники Тол Барада", side = "Alliance", category = "Cataclysm", }, --[faction=1177]
		{ id = 1174, }, --name = "Клан Громового Молота", side = "Alliance", category = "Cataclysm", }, --[faction=1174]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[3] = {
		header = {icon = E.OctoTable_Expansions[3].icon, name = E.OctoTable_Expansions[3].color..E.OctoTable_Expansions[3].name.."|r",},
		-- ["Wrath of the Lich King"] = {
		{ id = 1156, }, --name = "Пепельный союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1156]
		{ id = 1119, }, --name = "Сыны Ходира", side = "-", category = "Wrath of the Lich King", }, --[faction=1119]
		{ id = 1117, }, --name = "Низина Шолазар", side = "-", category = "Wrath of the Lich King", }, --[faction=1117]
		{ id = 1106, }, --name = "Серебряный Авангард", side = "-", category = "Wrath of the Lich King", }, --[faction=1106]
		{ id = 1098, }, --name = "Рыцари Черного Клинка", side = "-", category = "Wrath of the Lich King", }, --[faction=1098]
		{ id = 1091, }, --name = "Драконий союз", side = "-", category = "Wrath of the Lich King", }, --[faction=1091]
		{ id = 1090, }, --name = "Кирин-Тор", side = "-", category = "Wrath of the Lich King", }, --[faction=1090]
		{ id = 1073, }, --name = "Калу'ак", side = "-", category = "Wrath of the Lich King", }, --[faction=1073]
		{ id = 1052, }, --name = "Экспедиция Орды", side = "-", category = "Wrath of the Lich King", }, --[faction=1052]
		{ id = 1037, }, --name = "Авангард Альянса", side = "-", category = "Wrath of the Lich King", }, --[faction=1037] -- ХЕДЕР ВНУТРЕННИЙ
		----------------------------------------------------------------
		{ id = 1105, }, --name = "Оракулы", side = "-", category = "Низина Шолазар", }, --[faction=1105]
		{ id = 1104, }, --name = "Племя Бешеного Сердца", side = "-", category = "Низина Шолазар", }, --[faction=1104]
		----------------------------------------------------------------
		{ id = 1124, }, --name = "Похитители Солнца", side = "-", category = "Экспедиция Орды", }, --[faction=1124]
		{ id = 1085, }, --name = "Армия Песни Войны", side = "-", category = "Экспедиция Орды", }, --[faction=1085]
		{ id = 1067, }, --name = "Карающая Длань", side = "-", category = "Экспедиция Орды", }, --[faction=1067]
		{ id = 1064, }, --name = "Таунка", side = "-", category = "Экспедиция Орды", }, --[faction=1064]
		----------------------------------------------------------------
		{ id = 1126, }, --name = "Зиморожденные", side = "-", category = "Авангард Альянса", }, --[faction=1126]
		{ id = 1094, }, --name = "Серебряный Союз", side = "-", category = "Авангард Альянса", }, --[faction=1094]
		{ id = 1068, }, --name = "Лига исследователей", side = "-", category = "Авангард Альянса", }, --[faction=1068]
		{ id = 1050, }, --name = "Экспедиция Отважных", side = "-", category = "Авангард Альянса", }, --[faction=1050]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[2] = {
		header = {icon = E.OctoTable_Expansions[2].icon, name = E.OctoTable_Expansions[2].color..E.OctoTable_Expansions[2].name.."|r",},
		-- ["The Burning Crusade"] = {
		{ id = 1038, }, --name = "Огри'ла", side = "-", category = "The Burning Crusade", }, --[faction=1038]
		{ id = 1015, }, --name = "Крылья Пустоты", side = "-", category = "The Burning Crusade", }, --[faction=1015]
		{ id = 1012, }, --name = "Пеплоусты-служители", side = "-", category = "The Burning Crusade", }, --[faction=1012]
		{ id = 990, }, --name = "Песчаная Чешуя", side = "-", category = "The Burning Crusade", }, --[faction=990]
		{ id = 989, }, --name = "Хранители Времени", side = "-", category = "The Burning Crusade", }, --[faction=989]
		{ id = 978, }, --name = "Куренай", side = "-", category = "The Burning Crusade", }, --[faction=978]
		{ id = 970, }, --name = "Спореггар", side = "-", category = "The Burning Crusade", }, --[faction=970]
		{ id = 967, }, --name = "Аметистовое Око", side = "-", category = "The Burning Crusade", }, --[faction=967]
		{ id = 947, }, --name = "Траллмар", side = "-", category = "The Burning Crusade", }, --[faction=947]
		{ id = 946, }, --name = "Оплот Чести", side = "-", category = "The Burning Crusade", }, --[faction=946]
		{ id = 942, }, --name = "Кенарийская экспедиция", side = "-", category = "The Burning Crusade", }, --[faction=942]
		{ id = 941, }, --name = "Маг'хары", side = "-", category = "The Burning Crusade", }, --[faction=941]
		{ id = 936, }, --name = "Город Шаттрат", side = "-", category = "The Burning Crusade", }, --[faction=936]
		{ id = 933, }, --name = "Консорциум", side = "-", category = "The Burning Crusade", }, --[faction=933]
		{ id = 922, }, --name = "Транквиллион", side = "-", category = "The Burning Crusade", }, --[faction=922]
		----------------------------------------------------------------
		{ id = 1077, }, --name = "Армия Расколотого Солнца", side = "-", category = "Город Шаттрат", }, --[faction=1077]
		{ id = 1031, }, --name = "Стражи небес Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=1031]
		{ id = 1011, }, --name = "Нижний Город", side = "-", category = "Город Шаттрат", }, --[faction=1011]
		{ id = 935, }, --name = "Ша'тар", side = "-", category = "Город Шаттрат", }, --[faction=935]
		{ id = 934, }, --name = "Провидцы", side = "-", category = "Город Шаттрат", }, --[faction=934]
		{ id = 932, }, --name = "Алдоры", side = "-", category = "Город Шаттрат", }, --[faction=932]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	[1] = {
		header = {icon = E.OctoTable_Expansions[1].icon, name = E.OctoTable_Expansions[1].color..E.OctoTable_Expansions[1].name.."|r",},
		-- ["World of Warcraft"] = {
		{ id = 910, }, --name = "Род Ноздорму", side = "-", category = "World of Warcraft", }, --[faction=910]
		{ id = 909, }, --name = "Ярмарка Новолуния", side = "-", category = "World of Warcraft", }, --[faction=909]
		{ id = 809, }, --name = "Шен'дралар", side = "-", category = "World of Warcraft", }, --[faction=809]
		{ id = 749, }, --name = "Гидраксианские Повелители Вод", side = "-", category = "World of Warcraft", }, --[faction=749]
		{ id = 609, }, --name = "Круг Кенария", side = "-", category = "World of Warcraft", }, --[faction=609]
		{ id = 589, }, --name = "Укротители ледопардов", side = "Alliance", category = "World of Warcraft", }, --[faction=589]
		{ id = 576, }, --name = "Древобрюхи", side = "-", category = "World of Warcraft", }, --[faction=576]
		{ id = 529, }, --name = "Серебряный Рассвет", side = "-", category = "World of Warcraft", }, --[faction=529]
		{ id = 469, }, --name = "Альянс", side = "Alliance", category = "World of Warcraft", }, --[faction=469]
		{ id = 349, }, --name = "Черный Ворон", side = "-", category = "World of Warcraft", }, --[faction=349]
		{ id = 270, }, --name = "Племя Зандалари", side = "-", category = "World of Warcraft", }, --[faction=270]
		{ id = 169, }, --name = "Картель Хитрой Шестеренки", side = "-", category = "World of Warcraft", }, --[faction=169]
		{ id = 93, }, --name = "Кентавры из племени Маграм", side = "-", category = "World of Warcraft", }, --[faction=93]
		{ id = 92, }, --name = "Кентавры из племени Гелкис", side = "-", category = "World of Warcraft", }, --[faction=92]
		{ id = 87, }, --name = "Пираты Кровавого Паруса", side = "-", category = "World of Warcraft", }, --[faction=87]
		{ id = 70, }, --name = "Синдикат", side = "-", category = "World of Warcraft", }, --[faction=70]
		{ id = 67, }, --name = "Орда", side = "Horde", category = "World of Warcraft", }, --[faction=67]
		{ id = 59, }, --name = "Братство Тория", side = "-", category = "World of Warcraft", }, --[faction=59]
		----------------------------------------------------------------
		{ id = 577, }, --name = "Круговзор", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=577]
		{ id = 470, }, --name = "Кабестан", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=470]
		{ id = 369, }, --name = "Прибамбасск", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=369]
		{ id = 21, }, --name = "Пиратская Бухта", side = "-", category = "Картель Хитрой Шестеренки", }, --[faction=21]
		----------------------------------------------------------------
		{ id = 2372, }, --name = "Арена \"Морд'Бой\"", side = "Horde", category = "Силы Орды", }, --[faction=2372]
		{ id = 2010, }, --name = "Арена \"Морд'Бой\" (3-й сезон)", side = "Horde", category = "Силы Орды", }, --[faction=2010]
		{ id = 1690, }, --name = "Арена \"Морд'Бой\" (сезон 2)", side = "Horde", category = "Силы Орды", }, --[faction=1690]
		{ id = 1681, }, --name = "Копье Вол'джина", side = "Horde", category = "Силы Орды", }, --[faction=1681]
		{ id = 1374, }, --name = "Арена \"Морд'Бой\" (сезон 1)", side = "Horde", category = "Силы Орды", }, --[faction=1374]
		{ id = 889, }, --name = "Всадники Песни Войны", side = "Horde", category = "Силы Орды", }, --[faction=889]
		{ id = 729, }, --name = "Азеротский клан Северного Волка", side = "Horde", category = "Силы Орды", }, --[faction=729]
		{ id = 510, }, --name = "Осквернители", side = "Horde", category = "Силы Орды", }, --[faction=510]
		----------------------------------------------------------------
		{ id = 2523, }, --name = "Темные Когти", side = "Horde", category = "Орда", }, --[faction=2523]
		{ id = 1352, }, --name = "Пандарены Хоцзинь", side = "Horde", category = "Орда", }, --[faction=1352]
		{ id = 1133, }, --name = "Картель Трюмных Вод", side = "Horde", category = "Орда", }, --[faction=1133]
		{ id = 911, }, --name = "Луносвет", side = "Horde", category = "Орда", }, --[faction=911]
		{ id = 530, }, --name = "Племя Черного Копья", side = "Horde", category = "Орда", }, --[faction=530]
		{ id = 81, }, --name = "Громовой Утес", side = "Horde", category = "Орда", }, --[faction=81]
		{ id = 76, }, --name = "Оргриммар", side = "Horde", category = "Орда", }, --[faction=76]
		{ id = 68, }, --name = "Подгород", side = "Horde", category = "Орда", }, --[faction=68]
		----------------------------------------------------------------
		{ id = 2371, }, --name = "Потасовочная \"У Бизмо\"", side = "Alliance", category = "Силы Альянса", }, --[faction=2371]
		{ id = 2011, }, --name = "Потасовочная \"У Бизмо\" (3-й сезон)", side = "Alliance", category = "Силы Альянса", }, --[faction=2011
		{ id = 1691, }, --name = "Потасовочная \"У Бизмо\" (сезон 2)", side = "Alliance", category = "Силы Альянса", }, --[faction=1691
		{ id = 1682, }, --name = "Авангард Ринна", side = "Alliance", category = "Силы Альянса", }, --[faction=1682
		{ id = 1419, }, --name = "Потасовочная \"У Бизмо\" (сезон 1)", side = "Alliance", category = "Силы Альянса", }, --[faction=1419]
		{ id = 890, }, --name = "Среброкрылые Часовые", side = "Alliance", category = "Силы Альянса", }, --[faction=890
		{ id = 730, }, --name = "Стража Грозовой Вершины", side = "Alliance", category = "Силы Альянса", }, --[faction=730
		{ id = 509, }, --name = "Лига Аратора", side = "Alliance", category = "Силы Альянса", }, --[faction=509]
		----------------------------------------------------------------
		{ id = 2524, }, --name = "Обсидиановые Хранители", side = "Alliance", category = "Альянс", }, --[faction=2524]
		{ id = 1353, }, --name = "Пандарены Тушуй", side = "Alliance", category = "Альянс", }, --[faction=1353]
		{ id = 1134, }, --name = "Гилнеас", side = "Alliance", category = "Альянс", }, --[faction=1134]
		{ id = 930, }, --name = "Экзодар", side = "Alliance", category = "Альянс", }, --[faction=930]
		{ id = 72, }, --name = "Штормград", side = "Alliance", category = "Альянс", }, --[faction=72]
		{ id = 69, }, --name = "Дарнас", side = "Alliance", category = "Альянс", }, --[faction=69]
		{ id = 54, }, --name = "Гномреган", side = "Alliance", category = "Альянс", }, --[faction=54]
		{ id = 47, }, --name = "Стальгорн", side = "Alliance", category = "Альянс", }, --[faction=47]
	},
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- {
	-- 	header = {icon = ("Interface\\AddOns\\OctoToDo\\Media\\IconTexture\\OCTOREP"), name = OTHER, },
	-- 	{ id = 1168, }, --name = "Гильдия", side = "-", category = "Гильдия", }, --[faction=1168]
	-- },
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