local GlobalAddonName, E = ...
----------------------------------------------------------------
local ICON_ALLIANCE = E.ICON_ALLIANCE -- 2024072 --
local ICON_HORDE = E.ICON_HORDE -- 2024073 --
local ICON_KYRIAN = E.ICON_KYRIAN -- = 3641395
local ICON_NECROLORD = E.ICON_NECROLORD -- = 3752259 -- 3641396
local ICON_NIGHTFAE = E.ICON_NIGHTFAE -- = 3752258 -- 3641394
local ICON_VENTHYR = E.ICON_VENTHYR -- = 3257751 -- 3641397
local ICON_FISH = 1053367 -- https://www.wowhead.com/item = 133755/ (Underlight Angler)
local ICON_PVP = 1455894
----------------------------------------------------------------
E.OctoTable_Reputations_DB = {
	[999999] = {
		paragonQuest = nil,
	},
	[2774] = {
		["enUS"] = "Slayer's Duellum (Paragon)",
		["ruRU"] = "Дуэлянты Зубца убийцы (идеал)",
		paragonQuest = nil,
	},
	[2770] = {
		["enUS"] = "Slayer's Duellum",
		["ruRU"] = "Дуэлянты Зубца убийцы",
		["deDE"] = "Schlächterduellum",
		["esES"] = "Duellum del Asesino",
		["esMX"] = "Duelario del Asesino",
		["frFR"] = "Duellum meurtrier",
		["itIT"] = "Duello del Carnefice",
		["ptBR"] = "Duellum do Matador",
		["koKR"] = "학살자의 결전장",
		["zhCN"] = "屠戮角斗",
		["zhTW"] = "殺戮者決鬥會",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		paragonQuest = nil,
	},
	[2767] = {
		["enUS"] = "Bizmo's Brawlpub",
		["ruRU"] = "Потасовочная \"У Бизмо\"",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		paragonQuest = nil,
	},
	[2766] = {
		["enUS"] = "Brawl'gar Arena",
		["ruRU"] = "Арена \"Морд'Бой\"",
		side = "Horde",
		icon1 = ICON_HORDE,
		paragonQuest = nil,
	},
	[2764] = {
		["enUS"] = "Prey: Season 1",
		["ruRU"] = "Охота: 1-й сезон",
		["deDE"] = "Beutejagd: Saison 1",
		["esES"] = "Presa: temporada 1",
		["esMX"] = "Presa: temporada 1",
		["frFR"] = "Traque saison 1",
		["itIT"] = "Preda: Stagione 1",
		["ptBR"] = "Presa: Temporada 1",
		["koKR"] = "사냥감: 1 시즌",
		["zhCN"] = "狩猎：第1赛季",
		["zhTW"] = "狩獵：第1賽季",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		paragonQuest = nil,
	},
	[2744] = {
		["enUS"] = "Valeera Sanguinar",
		["ruRU"] = "Валира Сангвинар",
		paragonQuest = nil,
	},
	[2742] = {
		["enUS"] = "Delves: Season 1",
		["ruRU"] = "Вылазки: 1-й сезон",
		["deDE"] = "Tiefen: Saison 1",
		["esES"] = "Profundidades: temporada 1",
		["esMX"] = "Abismos: temporada 1",
		["frFR"] = "Gouffres saison 1",
		["itIT"] = "Scorribande: Stagione 1",
		["ptBR"] = "Imersões: Série 1",
		["koKR"] = "구렁: 1 시즌",
		["zhCN"] = "地下堡：第1赛季",
		["zhTW"] = "探究：第1賽季",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		paragonQuest = nil,
	},
	[2739] = {
		["enUS"] = "Delves: Coffer Key Shards Conversion",
		["ruRU"] = "Вылазки: обмен осколков ключа от сундука",
		paragonQuest = nil,
	},
	[2736] = {
		["enUS"] = "Manaforge Vandals",
		["ruRU"] = "Крушители манагорнов",
		atlas = "majorfactions_icons_ManaforgeVandals512",
		paragonQuest = nil,
	},
	[2727] = {
		["enUS"] = "Silvermoon Court (Paragon)",
		["ruRU"] = "Двор Луносвета (идеал)",
		paragonQuest = nil,
	},
	[2726] = {
		["enUS"] = "Hara'ti (Paragon)",
		["ruRU"] = "Хара'ти (идеал)",
		paragonQuest = nil,
	},
	[2725] = {
		["enUS"] = "The Singularity (Paragon)",
		["ruRU"] = "Сингулярность (идеал)",
		paragonQuest = nil,
	},
	[2722] = {
		["enUS"] = "Delves: Season 3",
		["ruRU"] = "Вылазки: 3-й сезон",
		paragonQuest = nil,
	},
	[2714] = {
		["enUS"] = "Shades of the Row",
		["ruRU"] = "Тени Закоулка",
		paragonQuest = nil,
	},
	[2713] = {
		["enUS"] = "Farstriders",
		["ruRU"] = "Странники",
		["deDE"] = "Weltenwanderer",
		["esES"] = "Errantes",
		["esMX"] = "Los Errantes",
		["frFR"] = "Pérégrins",
		["itIT"] = "Lungopasso",
		["ptBR"] = "Andarilhos",
		["koKR"] = "원정순찰대",
		["zhCN"] = "远行者",
		["zhTW"] = "遠行者",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		paragonQuest = nil,
	},
	[2712] = {
		["enUS"] = "Blood Knights",
		["ruRU"] = "Рыцари крови",
		["deDE"] = "Blutritter",
		["esES"] = "Caballeros de sangre",
		["esMX"] = "Caballeros de sangre",
		["frFR"] = "Chevaliers de sang",
		["itIT"] = "Cavalieri del Sangue",
		["ptBR"] = "Cavaleiros Sangrentos",
		["koKR"] = "혈기사",
		["zhCN"] = "血骑士",
		["zhTW"] = "血騎士",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		paragonQuest = nil,
	},
	[2711] = {
		["enUS"] = "Magisters",
		["ruRU"] = "Магистры",
		paragonQuest = nil,
	},
	[2710] = {
		["enUS"] = "Silvermoon Court",
		["ruRU"] = "Двор Луносвета",
		["deDE"] = "Hof in Silbermond",
		["esES"] = "Corte de Lunargenta",
		["esMX"] = "Corte de Lunargenta",
		["frFR"] = "Cour de Lune-d’Argent",
		["itIT"] = "Corte di Lunargenta",
		["ptBR"] = "Corte de Luaprata",
		["koKR"] = "실버문 궁정",
		["zhCN"] = "银月宫廷",
		["zhTW"] = "銀月城宮廷",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		atlas = "majorfactions_icons_light512",
		paragonQuest = nil,
	},
	[2705] = {
		["enUS"] = "Amani Tribe (Paragon)",
		["ruRU"] = "Племя Амани (идеал)",
		paragonQuest = nil,
	},
	[2704] = {
		["enUS"] = "Hara'ti",
		["ruRU"] = "Хара'ти",
		["deDE"] = "Hara'ti",
		["esES"] = "Hara'ti",
		["esMX"] = "Hara'ti",
		["frFR"] = "Hara’ti",
		["itIT"] = "Hara'ti",
		["ptBR"] = "Hara'ti",
		["koKR"] = "하라티",
		["zhCN"] = "哈籁提",
		["zhTW"] = "哈拉提",
		atlas = "majorfactions_icons_root512",
		paragonQuest = nil,
	},
	[2700] = {
		["enUS"] = "DEPRECATED Fungarian Fighting Ring",
		paragonQuest = nil,
	},
	[2699] = {
		["enUS"] = "The Singularity",
		["ruRU"] = "Сингулярность",
		["deDE"] = "Die Singularität",
		["esES"] = "La Singularidad",
		["esMX"] = "La Singularidad",
		["frFR"] = "La Singularité",
		["itIT"] = "Singolarità",
		["ptBR"] = "A Singularidade",
		["koKR"] = "특이점",
		["zhCN"] = "奇点特勤",
		["zhTW"] = "奇異點",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		atlas = "majorfactions_icons_sky512",
		paragonQuest = nil,
	},
	[2697] = {
		["enUS"] = "Chase's test faction (DNT)",
		["ruRU"] = "Chase's test faction (DNT)",
		paragonQuest = nil,
	},
	[2696] = {
		["enUS"] = "Amani Tribe",
		["ruRU"] = "Племя Амани",
		["deDE"] = "Amanistamm",
		["esES"] = "Tribu Amani",
		["esMX"] = "Tribu amani",
		["frFR"] = "Tribu des Amani",
		["itIT"] = "Tribù Amani",
		["ptBR"] = "Tribo Amani",
		["koKR"] = "아마니 부족",
		["zhCN"] = "阿曼尼部族",
		["zhTW"] = "阿曼尼部族",
		expansion = "Midnight",
		AddedInPatch = "12.0.0.65390",
		atlas = "majorfactions_icons_origin512",
		paragonQuest = nil,
	},
	[2695] = {
		["enUS"] = "Test Account Wide Stormwind (DNT)",
		["ruRU"] = "Test Account Wide Stormwind (DNT)",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		paragonQuest = nil,
	},
	[2693] = {
		["enUS"] = "Delver's Journey (Season 1)",
		["ruRU"] = "Путь участника вылазки (1-й сезон)",
		paragonQuest = nil,
	},
	[2689] = {
		["enUS"] = "Flame's Radiance (Paragon)",
		["ruRU"] = "Сияние Пламени (идеал)",
		paragonQuest = nil,
	},
	[2688] = {
		["enUS"] = "Flame's Radiance",
		["ruRU"] = "Сияние Пламени",
		atlas = "majorfactions_icons_Nightfall512",
		itemCache = 239489,
		paragonQuest = 89515,
	},
	[2685] = {
		["enUS"] = "Gallagio Loyalty Rewards Club",
		["ruRU"] = "Клуб лояльности Галаджио",
		atlas = "majorfactions_icons_stars512",
		itemCache = 232463,
		paragonQuest = 85471,
	},
	[2684] = {
		["enUS"] = "Gallagio Loyalty Rewards Club (Paragon)",
		["ruRU"] = "Клуб лояльности Галаджио (идеал)",
		paragonQuest = nil,
	},
	[2683] = {
		["enUS"] = "Delves: Season 2",
		["ruRU"] = "Вылазки: 2-й сезон",
		paragonQuest = nil,
	},
	[2677] = {
		["enUS"] = "Steamwheedle Cartel",
		["ruRU"] = "Картель Хитрой Шестеренки",
		itemCache = 237134,
		paragonQuest = 85809,
	},
	[2676] = {
		["enUS"] = "Steamwheedle Cartel (Paragon)",
		["ruRU"] = "Картель Хитрой Шестеренки (идеал)",
		paragonQuest = nil,
	},
	[2675] = {
		["enUS"] = "Blackwater Cartel",
		["ruRU"] = "Картель Черноводья",
		itemCache = 237135,
		paragonQuest = 85807,
	},
	[2674] = {
		["enUS"] = "Blackwater Cartel (Paragon)",
		["ruRU"] = "Картель Черноводья (идеал)",
		paragonQuest = nil,
	},
	[2673] = {
		["enUS"] = "Bilgewater Cartel",
		["ruRU"] = "Картель Трюмных Вод",
		itemCache = 237132,
		paragonQuest = 85806,
	},
	[2672] = {
		["enUS"] = "Bilgewater Cartel (Paragon)",
		["ruRU"] = "Картель Трюмных Вод (идеал)",
		paragonQuest = nil,
	},
	[2671] = {
		["enUS"] = "Venture Company",
		["ruRU"] = "Торговая компания",
		itemCache = 237133,
		paragonQuest = 85810,
	},
	[2670] = {
		["enUS"] = "Venture Company (Paragon)",
		["ruRU"] = "Торговая компания (идеал)",
		paragonQuest = nil,
	},
	[2669] = {
		["enUS"] = "Darkfuse Solutions",
		["ruRU"] = "Мрачные Решалы",
		itemCache = 232465,
		paragonQuest = 85808,
	},
	[2668] = {
		["enUS"] = "Darkfuse Solutions (Paragon)",
		["ruRU"] = "Мрачные Решалы (идеал)",
		paragonQuest = nil,
	},
	[2667] = {
		["enUS"] = "The Cartels of Undermine (Paragon)",
		["ruRU"] = "Картели Нижней Шахты (идеал)",
		paragonQuest = nil,
	},
	[2666] = {
		["enUS"] = "Roasts and Boasts",
		["ruRU"] = "Байки за чашкой",
		paragonQuest = nil,
	},
	[2665] = {
		["enUS"] = "Lillistrasza",
		["ruRU"] = "Лиллистраза",
		paragonQuest = nil,
	},
	[2664] = {
		["enUS"] = "Flynn Fairwind",
		["ruRU"] = "Флинн Фэйрвинд",
		paragonQuest = nil,
	},
	[2663] = {
		["enUS"] = "Meerah",
		["ruRU"] = "Миира",
		paragonQuest = nil,
	},
	[2662] = {
		["enUS"] = "[PH] The Power of Friendship",
		["ruRU"] = "[PH] The Power of Friendship",
		paragonQuest = nil,
	},
	[2659] = {
		["enUS"] = "The K'aresh Trust (Paragon)",
		["ruRU"] = "Концерн К'ареша (идеал)",
		paragonQuest = nil,
	},
	[2658] = {
		["enUS"] = "The K'aresh Trust",
		["ruRU"] = "Концерн К'ареша",
		atlas = "majorfactions_icons_Karesh512",
		itemCache = 230032,
		paragonQuest = 85109,
	},
	[2653] = {
		["enUS"] = "The Cartels of Undermine",
		["ruRU"] = "Картели Нижней Шахты",
		atlas = "majorfactions_icons_rocket512",
		itemCache = 232463,
		paragonQuest = 85805,
	},
	[2649] = {
		["enUS"] = "The General (Paragon)",
		["ruRU"] = "Генерал (идеал)",
		paragonQuest = nil,
	},
	[2648] = {
		["enUS"] = "The Weaver (Paragon)",
		["ruRU"] = "Прядильщица (идеал)",
	},
	[2647] = {
		["enUS"] = "The Vizier (Paragon)",
		["ruRU"] = "Визирь (идеал)",
	},
	[2645] = {
		["enUS"] = "Earthen",
		["ruRU"] = "Земельники",
	},
	[2644] = {
		["enUS"] = "Delves: Season 1",
		["ruRU"] = "Вылазки: 1-й сезон",
	},
	[2640] = {
		["enUS"] = "Brann Bronzebeard",
		["ruRU"] = "Бранн Бронзобород",
	},
	[2615] = {
		["enUS"] = "Azerothian Archives",
		["ruRU"] = "Азеротские Архивы",
	},
	[2613] = {
		["enUS"] = "The Assembly of the Deeps (Paragon)",
		["ruRU"] = "Ассамблея глубин (идеал)",
	},
	[2612] = {
		["enUS"] = "Council of Dornogal (Paragon)",
		["ruRU"] = "Совет Дорногала (идеал)",
	},
	[2611] = {
		["enUS"] = "Hallowfall Arathi (Paragon)",
		["ruRU"] = "Арати Тайносводья (идеал)",
	},
	[2607] = {
		["enUS"] = "The Vizier",
		["ruRU"] = "Визирь",
		itemCache = 226100,
		paragonQuest = 83740,
	},
	[2605] = {
		["enUS"] = "The General",
		["ruRU"] = "Генерал",
		itemCache = 226045,
		paragonQuest = 83739,
	},
	[2604] = {
		["enUS"] = "Keg Leg's Crew (Paragon)",
		["ruRU"] = "Команда Бочконога (идеал)",
	},
	[2601] = {
		["enUS"] = "The Weaver",
		["ruRU"] = "Прядильщица",
		itemCache = 226103,
		paragonQuest = 83738,
	},
	[2600] = {
		["enUS"] = "The Severed Threads",
		["ruRU"] = "Отрезанные нити",
		atlas = "majorfactions_icons_web512",
		itemCache = 225247,
		paragonQuest = 79196,
	},
	[2596] = {
		["enUS"] = "The Severed Threads (Paragon)",
		["ruRU"] = "Отрезанные нити (идеал)",
	},
	[2594] = {
		["enUS"] = "The Assembly of the Deeps",
		["ruRU"] = "Ассамблея глубин",
		atlas = "majorfactions_icons_candle512",
		itemCache = 225245,
		paragonQuest = 79220,
	},
	[2593] = {
		["enUS"] = "Keg Leg's Crew",
		["ruRU"] = "Команда Бочконога",
		atlas = "majorfactions_icons_plunderstorm512",
	},
	[2590] = {
		["enUS"] = "Council of Dornogal",
		["ruRU"] = "Совет Дорногала",
		atlas = "majorfactions_icons_storm512",
		itemCache = 225239,
		paragonQuest = 79219,
	},
	[2575] = {
		["enUS"] = "Dream Wardens (Paragon)",
		["ruRU"] = "Стражи Сна (идеал)",
	},
	[2574] = {
		["enUS"] = "Dream Wardens",
		["ruRU"] = "Стражи Сна",
		atlas = "MajorFactions_Icons_Dream512",
		itemCache = 210992,
		paragonQuest = 76425,
	},
	[2570] = {
		["enUS"] = "Hallowfall Arathi",
		["ruRU"] = "Арати Тайносводья",
		atlas = "majorfactions_icons_flame512",
		itemCache = 225246,
		paragonQuest = 79218,
	},
	[2569] = {
		["enUS"] = "The War Within",
		["ruRU"] = "The War Within",
	},
	[2568] = {
		["enUS"] = "Glimmerogg Racer",
		["ruRU"] = "Гонщик Мерцающего Огга",
	},
	[2565] = {
		["enUS"] = "Loamm Niffen (Paragon)",
		["ruRU"] = "Лоаммские ниффы (идеал)",
	},
	[2564] = {
		["enUS"] = "Loamm Niffen",
		["ruRU"] = "Лоаммские ниффы",
		atlas = "MajorFactions_Icons_Niffen512",
		itemCache = 204712,
		paragonQuest = 75290,
	},
	[2555] = {
		["enUS"] = "Clan Kaighan",
		["ruRU"] = "Клан Кейган",
	},
	[2554] = {
		["enUS"] = "Clan Toghus",
		["ruRU"] = "Клан Тогус",
	},
	[2553] = {
		["enUS"] = "Soridormi",
		["ruRU"] = "Соридорми",
	},
	[2552] = {
		["enUS"] = "Valdrakken Accord (Paragon)",
		["ruRU"] = "Союз Вальдраккена (идеал)",
	},
	[2551] = {
		["enUS"] = "Iskaara Tuskarr (Paragon)",
		["ruRU"] = "Искарские клыкарры (идеал)",
	},
	[2550] = {
		["enUS"] = "Cobalt Assembly",
		["ruRU"] = "Кобальтовая ассамблея",
	},
	[2544] = {
		["enUS"] = "Artisan's Consortium - Dragon Isles Branch",
		["ruRU"] = "Консорциум ремесленников – филиал на Драконьих островах",
	},
	[2542] = {
		["enUS"] = "Clan Ukhel",
		["ruRU"] = "Клан Укхел",
	},
	[2526] = {
		["enUS"] = "Winterpelt Furbolg",
		["ruRU"] = "Фурболги из клана Зимней Шкуры",
	},
	[2524] = {
		["enUS"] = "Obsidian Warders",
		["ruRU"] = "Обсидиановые Хранители",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2523] = {
		["enUS"] = "Dark Talons",
		["ruRU"] = "Темные Когти",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2522] = {
		["enUS"] = "Clan Teerai",
		["ruRU"] = "Клан Тирай",
	},
	[2521] = {
		["enUS"] = "Clan Nokhud (Paragon)",
		["ruRU"] = "Клан Нокуд (идеал)",
	},
	[2520] = {
		["enUS"] = "Clan Nokhud",
		["ruRU"] = "Клан Нокхуд",
	},
	[2518] = {
		["enUS"] = "Sabellian",
		["ruRU"] = "Сабеллиан",
	},
	[2517] = {
		["enUS"] = "Wrathion",
		["ruRU"] = "Гневион",
	},
	[2513] = {
		["enUS"] = "Clan Ohn'ir",
		["ruRU"] = "Клан Он'ир",
	},
	[2512] = {
		["enUS"] = "Clan Aylaag",
		["ruRU"] = "Клан Айлааг",
	},
	[2511] = {
		["enUS"] = "Iskaara Tuskarr",
		["ruRU"] = "Искарские клыкарры",
		atlas = "MajorFactions_Icons_Tuskarr512",
		itemCache = 199473,
		paragonQuest = 66511,
	},
	[2510] = {
		["enUS"] = "Valdrakken Accord",
		["ruRU"] = "Союз Вальдраккена",
		atlas = "MajorFactions_Icons_Valdrakken512",
		itemCache = 199475,
		paragonQuest = 71023,
	},
	[2509] = {
		["enUS"] = "Clan Shikaar",
		["ruRU"] = "Клан Шикаар",
	},
	[2508] = {
		["enUS"] = "Dragonscale Expedition (Paragon)",
		["ruRU"] = "Драконья экспедиция (идеал)",
	},
	[2507] = {
		["enUS"] = "Dragonscale Expedition",
		["ruRU"] = "Драконья экспедиция",
		atlas = "MajorFactions_Icons_Expedition512",
		itemCache = 199472,
		paragonQuest = 66156,
	},
	[2506] = {
		["enUS"] = "Dragonflight",
		["ruRU"] = "Dragonflight",
	},
	[2504] = {
		["enUS"] = "Maruuk Centaur (Paragon)",
		["ruRU"] = "Кентавры Маруук (идеал)",
	},
	[2503] = {
		["enUS"] = "Maruuk Centaur",
		["ruRU"] = "Кентавры Маруук",
		atlas = "MajorFactions_Icons_Centaur512",
		itemCache = 199474,
		paragonQuest = 65606,
	},
	[2479] = {
		["enUS"] = "The Enlightened (Paragon)",
		["ruRU"] = "Просветленные (идеал)",
	},
	[2478] = {
		["enUS"] = "The Enlightened",
		["ruRU"] = "Просветленные",
		itemCache = 187780,
		paragonQuest = 64867,
	},
	[2474] = {
		["enUS"] = "Ve'nari (Paragon)",
		["ruRU"] = "Ве'нари (идеал)",
	},
	[2473] = {
		["enUS"] = "The Archivists' Codex (Paragon)",
		["ruRU"] = "Кодекс архивариуса (идеал)",
	},
	[2472] = {
		["enUS"] = "The Archivists' Codex",
		["ruRU"] = "Кодекс архивариуса",
		itemCache = 187028,
		paragonQuest = 64266,
	},
	[2471] = {
		["enUS"] = "Death's Advance (Paragon)",
		["ruRU"] = "Легион Смерти (идеал)",
	},
	[2470] = {
		["enUS"] = "Death's Advance",
		["ruRU"] = "Легион Смерти",
		itemCache = 186650,
		paragonQuest = 64012,
	},
	[2469] = {
		["enUS"] = "Fractal Lore",
		["ruRU"] = "Понимание фракталов",
	},
	[2465] = {
		["enUS"] = "The Wild Hunt",
		["ruRU"] = "Дикая Охота",
		icon1 = ICON_NIGHTFAE,
		itemCache = 180649,
		paragonQuest = 61098,
	},
	[2464] = {
		["enUS"] = "Court of Night",
		["ruRU"] = "Двор Ночи",
		icon1 = ICON_NIGHTFAE,
	},
	[2463] = {
		["enUS"] = "Marasmius",
		["ruRU"] = "Чесночник",
		icon1 = ICON_NIGHTFAE,
	},
	[2462] = {
		["enUS"] = "Stitchmasters",
		["ruRU"] = "Штопальщики",
		icon1 = ICON_NECROLORD,
	},
	[2461] = {
		["enUS"] = "Plague Deviser Marileth",
		["ruRU"] = "Изобретатель чумы Марилет",
		icon1 = ICON_VENTHYR,
	},
	[2460] = {
		["enUS"] = "Stonehead",
		["ruRU"] = "Камнелоб",
		icon1 = ICON_VENTHYR,
	},
	[2459] = {
		["enUS"] = "Sika",
		["ruRU"] = "Сика",
		icon1 = ICON_VENTHYR,
	},
	[2458] = {
		["enUS"] = "Kleia and Pelagos",
		["ruRU"] = "Клейя и Пелагий",
		icon1 = ICON_VENTHYR,
	},
	[2457] = {
		["enUS"] = "Grandmaster Vole",
		["ruRU"] = "Великий мастер Воул",
		icon1 = ICON_VENTHYR,
	},
	[2456] = {
		["enUS"] = "Droman Aliothe",
		["ruRU"] = "Дроман Алиот",
		icon1 = ICON_VENTHYR,
	},
	[2455] = {
		["enUS"] = "Cryptkeeper Kassir",
		["ruRU"] = "Хранитель склепа Каззир",
		icon1 = ICON_VENTHYR,
	},
	[2454] = {
		["enUS"] = "Choofa",
		["ruRU"] = "Чуфа",
		icon1 = ICON_VENTHYR,
	},
	[2453] = {
		["enUS"] = "Rendle and Cudgelface",
		["ruRU"] = "Рендл и Дуборыл",
		icon1 = ICON_VENTHYR,
	},
	[2452] = {
		["enUS"] = "Polemarch Adrestes",
		["ruRU"] = "Полемарх Адрест",
		icon1 = ICON_VENTHYR,
	},
	[2451] = {
		["enUS"] = "Hunt-Captain Korayn",
		["ruRU"] = "Капитан-егерь Корейн",
		icon1 = ICON_VENTHYR,
	},
	[2450] = {
		["enUS"] = "Alexandros Mograine",
		["ruRU"] = "Александрос Могрейн",
		icon1 = ICON_VENTHYR,
	},
	[2449] = {
		["enUS"] = "The Countess",
		["ruRU"] = "Графиня",
		icon1 = ICON_VENTHYR,
	},
	[2448] = {
		["enUS"] = "Mikanikos",
		["ruRU"] = "Миканикос",
		icon1 = ICON_VENTHYR,
	},
	[2447] = {
		["enUS"] = "Lady Moonberry",
		["ruRU"] = "Леди Лунная Ягода",
		icon1 = ICON_VENTHYR,
	},
	[2446] = {
		["enUS"] = "Baroness Vashj",
		["ruRU"] = "Баронесса Вайш",
		icon1 = ICON_VENTHYR,
	},
	[2445] = {
		["enUS"] = "The Ember Court",
		["ruRU"] = "Пепельный двор",
		icon1 = ICON_VENTHYR,
	},
	[2444] = {
		["enUS"] = "The Wild Hunt (Paragon)",
		["ruRU"] = "Дикая Охота (Идеал)",
	},
	[2442] = {
		["enUS"] = "Court of Harvesters (Paragon)",
		["ruRU"] = "Двор Жнецов (Идеал)",
	},
	[2441] = {
		["enUS"] = "The Ascended (Paragon)",
		["ruRU"] = "Перерожденные (Идеал)",
	},
	[2440] = {
		["enUS"] = "The Undying Army (Paragon)",
		["ruRU"] = "Неумирающая армия (Идеал)",
	},
	[2439] = {
		["enUS"] = "The Avowed",
		["ruRU"] = "Нераскаявшиеся",
		icon1 = ICON_VENTHYR,
	},
	[2432] = {
		["enUS"] = "Ve'nari",
		["ruRU"] = "Ве'нари",
		itemCache = 187029,
		paragonQuest = 64267,
	},
	[2431] = {
		["enUS"] = "Owen Test",
		["ruRU"] = "Owen Test",
	},
	[2427] = {
		["enUS"] = "Aqir Hatchling",
		["ruRU"] = "Молодой акир",
	},
	[2422] = {
		["enUS"] = "Night Fae",
		["ruRU"] = "Ночной народец",
	},
	[2418] = {
		["enUS"] = "Uldum Accord (Paragon)",
		["ruRU"] = "Ульдумский союз (идеал)",
	},
	[2417] = {
		["enUS"] = "Uldum Accord",
		["ruRU"] = "Ульдумский союз",
		itemCache = 174484,
		paragonQuest = 58097,
	},
	[2416] = {
		["enUS"] = "Rajani (Paragon)",
		["ruRU"] = "Раджани (идеал)",
	},
	[2415] = {
		["enUS"] = "Rajani",
		["ruRU"] = "Раджани",
		itemCache = 174483,
		paragonQuest = 58096,
	},
	[2414] = {
		["enUS"] = "Shadowlands",
		["ruRU"] = "Темные Земли",
	},
	[2413] = {
		["enUS"] = "Court of Harvesters",
		["ruRU"] = "Двор Жнецов",
		icon1 = ICON_VENTHYR,
		itemCache = 180648,
		paragonQuest = 61100,
	},
	[2410] = {
		["enUS"] = "The Undying Army",
		["ruRU"] = "Неумирающая армия",
		icon1 = ICON_NECROLORD,
		itemCache = 180646,
		paragonQuest = 61095,
	},
	[2407] = {
		["enUS"] = "The Ascended",
		["ruRU"] = "Перерожденные",
		icon1 = ICON_KYRIAN,
		itemCache = 180647,
		paragonQuest = 61097,
	},
	[2401] = {
		["enUS"] = "Waveblade Ankoan (Paragon)",
		["ruRU"] = "Анкоа из клана Клинков Волн (идеал)",
	},
	[2400] = {
		["enUS"] = "Waveblade Ankoan",
		["ruRU"] = "Клинки Волн",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		itemCache = 169939,
		paragonQuest = 55976,
	},
	[2398] = {
		["enUS"] = "Honeyback Harvester",
		["ruRU"] = "Фуражир из улья Медокрылов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2397] = {
		["enUS"] = "Honeyback Hivemother",
		["ruRU"] = "Пчеломатка улья Медокрылов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2396] = {
		["enUS"] = "Honeyback Drone",
		["ruRU"] = "Трутень из улья Медокрылов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2395] = {
		["enUS"] = "Honeyback Hive",
		["ruRU"] = "Улей Медокрылов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2392] = {
		["enUS"] = "Rustbolt Resistance (Paragon)",
		["ruRU"] = "Ржавоболтское сопротивление (идеал)",
	},
	[2391] = {
		["enUS"] = "Rustbolt Resistance",
		["ruRU"] = "Ржавоболтское сопротивление",
		itemCache = 170061,
		paragonQuest = 55348,
	},
	[2390] = {
		["enUS"] = "Vim Brineheart",
		["ruRU"] = "Вим Соленодух",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2389] = {
		["enUS"] = "Neri Sharpfin",
		["ruRU"] = "Нери Остроерш",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2388] = {
		["enUS"] = "Poen Gillbrack",
		["ruRU"] = "Поэн Солежабрик",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2387] = {
		["enUS"] = "Tortollan Seekers (Paragon)",
		["ruRU"] = "Тортолланские искатели (идеал)",
	},
	[2386] = {
		["enUS"] = "Champions of Azeroth (Paragon)",
		["ruRU"] = "Защитники Азерот (идеал)",
	},
	[2385] = {
		["enUS"] = "The Honorbound (Paragon)",
		["ruRU"] = "Армия Чести (идеал)",
	},
	[2384] = {
		["enUS"] = "7th Legion (Paragon)",
		["ruRU"] = "7-й легион (идеал)",
	},
	[2383] = {
		["enUS"] = "Order of Embers (Paragon)",
		["ruRU"] = "Орден Пылающих Углей (идеал)",
	},
	[2382] = {
		["enUS"] = "Voldunai (Paragon)",
		["ruRU"] = "Жители Вол'дуна (идеал)",
	},
	[2381] = {
		["enUS"] = "Storm's Wake (Paragon)",
		["ruRU"] = "Орден Возрождения Шторма (идеал)",
	},
	[2380] = {
		["enUS"] = "Talanji's Expedition (Paragon)",
		["ruRU"] = "Экспедиция Таланджи (идеал)",
	},
	[2379] = {
		["enUS"] = "Proudmoore Admiralty (Paragon)",
		["ruRU"] = "Адмиралтейство Праудмуров (идеал)",
	},
	[2378] = {
		["enUS"] = "Zandalari Empire (Paragon)",
		["ruRU"] = "Империя Зандалари (идеал)",
	},
	[2377] = {
		["enUS"] = "Bladesman Inowari",
		["ruRU"] = "Мастер клинка Иновари",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2376] = {
		["enUS"] = "Farseer Ori",
		["ruRU"] = "Оракул Ори",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2375] = {
		["enUS"] = "Hunter Akana",
		["ruRU"] = "Мастер охоты Акана",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2374] = {
		["enUS"] = "The Unshackled (Paragon)",
		["ruRU"] = "Освобожденные (идеал)",
	},
	[2373] = {
		["enUS"] = "The Unshackled",
		["ruRU"] = "Освобожденные",
		side = "Horde",
		icon1 = ICON_HORDE,
		itemCache = 169940,
		paragonQuest = 53982,
	},
	[2372] = {
		["enUS"] = "Brawl'gar Arena (Season 4)",
		["ruRU"] = "Арена \"Морд'Бой\" (4-й сезон)",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2371] = {
		["enUS"] = "Bizmo's Brawlpub (Season 4)",
		["ruRU"] = "Потасовочная \"У Бизмо\" (4-й сезон)",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2370] = {
		["enUS"] = "Dino Training - Direhorn",
		["ruRU"] = "Обучение динозавров – Дикорог",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2265] = {
		["enUS"] = "Kul Tiras - Stormsong",
		["ruRU"] = "Кул-Тирас - долина Штормов",
	},
	[2264] = {
		["enUS"] = "Kul Tiras - Drustvar",
		["ruRU"] = "Кул-Тирас - Друствар",
	},
	[2233] = {
		["enUS"] = "Dino Training - Pterrodax",
		["ruRU"] = "Dino Training - Pterrodax",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[2170] = {
		["enUS"] = "Argussian Reach",
		["ruRU"] = "Защитники Аргуса",
		itemCache = 152922,
		paragonQuest = 48976,
	},
	[2167] = {
		["enUS"] = "Argussian Reach (Paragon)",
		["ruRU"] = "Защитники Аргуса (идеал)",
	},
	[2166] = {
		["enUS"] = "Army of the Light (Paragon)",
		["ruRU"] = "Армия Света (идеал)",
	},
	[2165] = {
		["enUS"] = "Army of the Light",
		["ruRU"] = "Армия Света",
		itemCache = 152923,
		paragonQuest = 48977,
	},
	[2164] = {
		["enUS"] = "Champions of Azeroth",
		["ruRU"] = "Защитники Азерот",
		itemCache = 166298,
		paragonQuest = 54453,
	},
	[2163] = {
		["enUS"] = "Tortollan Seekers",
		["ruRU"] = "Тортолланские искатели",
		itemCache = 166245,
		paragonQuest = 54451,
	},
	[2162] = {
		["enUS"] = "Storm's Wake",
		["ruRU"] = "Орден Возрождения Шторма",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		itemCache = 166294,
		paragonQuest = 54457,
	},
	[2161] = {
		["enUS"] = "Order of Embers",
		["ruRU"] = "Орден Пылающих Углей",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		itemCache = 166297,
		paragonQuest = 54456,
	},
	[2160] = {
		["enUS"] = "Proudmoore Admiralty",
		["ruRU"] = "Адмиралтейство Праудмуров",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		itemCache = 166295,
		paragonQuest = 54458,
	},
	[2159] = {
		["enUS"] = "7th Legion",
		["ruRU"] = "7-й легион",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
		itemCache = 166300,
		paragonQuest = 54454,
	},
	[2158] = {
		["enUS"] = "Voldunai",
		["ruRU"] = "Жители Вол'дуна",
		side = "Horde",
		icon1 = ICON_HORDE,
		itemCache = 166290,
		paragonQuest = 54461,
	},
	[2157] = {
		["enUS"] = "The Honorbound",
		["ruRU"] = "Армия Чести",
		side = "Horde",
		icon1 = ICON_HORDE,
		itemCache = 166299,
		paragonQuest = 54455,
	},
	[2156] = {
		["enUS"] = "Talanji's Expedition",
		["ruRU"] = "Экспедиция Таланджи",
		side = "Horde",
		icon1 = ICON_HORDE,
		itemCache = 166282,
		paragonQuest = 54460,
	},
	[2135] = {
		["enUS"] = "Chromie",
		["ruRU"] = "Хроми",
	},
	[2120] = {
		["enUS"] = "Kul Tiras - Tiragarde",
		["ruRU"] = "Кул-Тирас - Тирагард",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2111] = {
		["enUS"] = "Zandalari Dinosaurs",
		["ruRU"] = "Зандаларские динозавры",
	},
	[2104] = {
		["enUS"] = "Battle for Azeroth",
		["ruRU"] = "Battle for Azeroth",
	},
	[2103] = {
		["enUS"] = "Zandalari Empire",
		["ruRU"] = "Империя Зандалари",
		side = "Horde",
		icon1 = ICON_HORDE,
		itemCache = 166292,
		paragonQuest = 54462,
	},
	[2102] = {
		["enUS"] = "Impus",
		["ruRU"] = "Бесс",
		icon1 = ICON_FISH,
	},
	[2101] = {
		["enUS"] = "Sha'leth",
		["ruRU"] = "Ша'лет",
		icon1 = ICON_FISH,
	},
	[2100] = {
		["enUS"] = "Corbyn",
		["ruRU"] = "Корбин",
		icon1 = ICON_FISH,
	},
	[2099] = {
		["enUS"] = "Akule Riverhorn",
		["ruRU"] = "Акуле Речной Рог",
		icon1 = ICON_FISH,
	},
	[2098] = {
		["enUS"] = "Keeper Raynae",
		["ruRU"] = "Хранительница Рейна",
		icon1 = ICON_FISH,
	},
	[2097] = {
		["enUS"] = "Ilyssia of the Waters",
		["ruRU"] = "Илиссия Водная",
		icon1 = ICON_FISH,
	},
	[2091] = {
		["enUS"] = "Armies of Legionfall (Paragon)",
		["ruRU"] = "Армия погибели Легиона (идеал)",
	},
	[2090] = {
		["enUS"] = "The Wardens (Paragon)",
		["ruRU"] = "Стражи (идеал)",
	},
	[2089] = {
		["enUS"] = "The Nightfallen (Paragon)",
		["ruRU"] = "Помраченные (идеал)",
	},
	[2088] = {
		["enUS"] = "Dreamweavers (Paragon)",
		["ruRU"] = "Ткачи Снов (идеал)",
	},
	[2087] = {
		["enUS"] = "Court of Farondis (Paragon)",
		["ruRU"] = "Двор Фарондиса (идеал)",
	},
	[2086] = {
		["enUS"] = "Valarjar (Paragon)",
		["ruRU"] = "Валарьяры (идеал)",
	},
	[2085] = {
		["enUS"] = "Highmountain Tribe (Paragon)",
		["ruRU"] = "Племена Крутогорья (идеал)",
	},
	[2063] = {
		["enUS"] = "Arne Test - Paragon Reputation Stormwind",
		["ruRU"] = "Arne Test - Paragon Reputation Stormwind",
	},
	[2045] = {
		["enUS"] = "Armies of Legionfall",
		["ruRU"] = "Армия погибели Легиона",
		itemCache = 152108,
		paragonQuest = 46777,
	},
	[2018] = {
		["enUS"] = "Talon's Vengeance",
		["ruRU"] = "Отмщение Когтя",
	},
	[2011] = {
		["enUS"] = "Bizmo's Brawlpub (Season 3)",
		["ruRU"] = "Потасовочная \"У Бизмо\" (3-й сезон)",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[2010] = {
		["enUS"] = "Brawl'gar Arena (Season 3)",
		["ruRU"] = "Арена \"Морд'Бой\" (3-й сезон)",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1989] = {
		["enUS"] = "Moon Guard",
		["ruRU"] = "Лунные стражи",
	},
	[1984] = {
		["enUS"] = "The First Responders",
		["ruRU"] = "Спасатели",
	},
	[1975] = {
		["enUS"] = "Conjurer Margoss",
		["ruRU"] = "Кудесник Маргосс",
	},
	[1948] = {
		["enUS"] = "Valarjar",
		["ruRU"] = "Валарьяры",
		itemCache = 152106,
		paragonQuest = 46746,
	},
	[1947] = {
		["enUS"] = "Illidari",
		["ruRU"] = "Иллидари",
	},
	[1919] = {
		["enUS"] = "Arcane Thirst (Valtrois)",
		["ruRU"] = "Жажда магии Вальтруа",
	},
	[1900] = {
		["enUS"] = "Court of Farondis",
		["ruRU"] = "Двор Фарондиса",
		itemCache = 152102,
		paragonQuest = 46745,
	},
	[1899] = {
		["enUS"] = "Moonguard",
		["ruRU"] = "Лунные стражи",
	},
	[1894] = {
		["enUS"] = "The Wardens",
		["ruRU"] = "Стражи",
		itemCache = 152107,
		paragonQuest = 46749,
	},
	[1888] = {
		["enUS"] = "Jandvik Vrykul",
		["ruRU"] = "Яндвикские врайкулы",
	},
	[1883] = {
		["enUS"] = "Dreamweavers",
		["ruRU"] = "Ткачи Снов",
		itemCache = 152103,
		paragonQuest = 46747,
	},
	[1862] = {
		["enUS"] = "Arcane Thirst (Oculeth)",
		["ruRU"] = "Жажда магии Окулета",
	},
	[1861] = {
		["enUS"] = "Arcane Thirst (Silgryn) DEPRECATED",
		["ruRU"] = "Arcane Thirst (Silgryn) DEPRECATED",
	},
	[1860] = {
		["enUS"] = "Arcane Thirst (Thalyssra)",
		["ruRU"] = "Жажда магии Талисры",
	},
	[1859] = {
		["enUS"] = "The Nightfallen",
		["ruRU"] = "Помраченные",
		itemCache = 152105,
		paragonQuest = 46748,
	},
	[1850] = {
		["enUS"] = "The Saberstalkers",
		["ruRU"] = "Охотники за саблеронами",
	},
	[1849] = {
		["enUS"] = "Order of the Awakened",
		["ruRU"] = "Орден Пробудившихся",
	},
	[1848] = {
		["enUS"] = "Vol'jin's Headhunters",
		["ruRU"] = "Охотники за головами",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1847] = {
		["enUS"] = "Hand of the Prophet",
		["ruRU"] = "Длань Пророка",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1834] = {
		["enUS"] = "Legion",
		["ruRU"] = "Legion",
	},
	[1828] = {
		["enUS"] = "Highmountain Tribe",
		["ruRU"] = "Племена Крутогорья",
		itemCache = 152104,
		paragonQuest = 46743,
	},
	[1815] = {
		["enUS"] = "Gilnean Survivors",
		["ruRU"] = "Выжившие из Гилнеаса",
	},
	[1741] = {
		["enUS"] = "Leorajh",
		["ruRU"] = "Леорадж",
	},
	[1740] = {
		["enUS"] = "Aeda Brightdawn",
		["ruRU"] = "Аеда Ясная Заря",
	},
	[1739] = {
		["enUS"] = "Vivianne",
		["ruRU"] = "Вивианна",
	},
	[1738] = {
		["enUS"] = "Defender Illona",
		["ruRU"] = "Защитница Иллона",
	},
	[1737] = {
		["enUS"] = "Talonpriest Ishaal",
		["ruRU"] = "Жрец Когтя Ишааль",
	},
	[1736] = {
		["enUS"] = "Tormmok",
		["ruRU"] = "Тормок",
	},
	[1735] = {
		["enUS"] = "Barracks Bodyguards",
		["ruRU"] = "Телохранители из казарм",
	},
	[1733] = {
		["enUS"] = "Delvar Ironfist",
		["ruRU"] = "Делвар Железный Кулак",
	},
	[1732] = {
		["enUS"] = "Steamwheedle Draenor Expedition",
		["ruRU"] = "Дренорcкая Экспедиция Хитрой Шестеренки",
	},
	[1731] = {
		["enUS"] = "Council of Exarchs",
		["ruRU"] = "Совет экзархов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1711] = {
		["enUS"] = "Steamwheedle Preservation Society",
		["ruRU"] = "Археологическое общество Хитрой Шестеренки",
	},
	[1710] = {
		["enUS"] = "Sha'tari Defense",
		["ruRU"] = "Защитники Ша'тар",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1708] = {
		["enUS"] = "Laughing Skull Orcs",
		["ruRU"] = "Клан Веселого Черепа",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1691] = {
		["enUS"] = "Bizmo's Brawlpub (Season 2)",
		["ruRU"] = "Потасовочная \"У Бизмо\" (сезон 2)",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1690] = {
		["enUS"] = "Brawl'gar Arena (Season 2)",
		["ruRU"] = "Арена \"Морд'Бой\" (сезон 2)",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1682] = {
		["enUS"] = "Wrynn's Vanguard",
		["ruRU"] = "Авангард Ринна",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1681] = {
		["enUS"] = "Vol'jin's Spear",
		["ruRU"] = "Копье Вол'джина",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1520] = {
		["enUS"] = "Shadowmoon Exiles",
		["ruRU"] = "Изгнанники клана Призрачной Луны",
	},
	[1515] = {
		["enUS"] = "Arakkoa Outcasts",
		["ruRU"] = "Араккоа-изгои",
	},
	[1492] = {
		["enUS"] = "Emperor Shaohao",
		["ruRU"] = "Император Шаохао",
	},
	[1445] = {
		["enUS"] = "Frostwolf Orcs",
		["ruRU"] = "Клан Северного Волка",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1444] = {
		["enUS"] = "Warlords of Draenor",
		["ruRU"] = "Warlords of Draenor",
	},
	[1440] = {
		["enUS"] = "Darkspear Rebellion",
		["ruRU"] = "Восстание Черного Копья",
	},
	[1435] = {
		["enUS"] = "Shado-Pan Assault",
		["ruRU"] = "Натиск Шадо-Пан",
	},
	[1419] = {
		["enUS"] = "Bizmo's Brawlpub (Season 1)",
		["ruRU"] = "Потасовочная \"У Бизмо\" (сезон 1)",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1388] = {
		["enUS"] = "Sunreaver Onslaught",
		["ruRU"] = "Войска Похитителей Солнца",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1387] = {
		["enUS"] = "Kirin Tor Offensive",
		["ruRU"] = "Армия Кирин-Тора",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1376] = {
		["enUS"] = "Operation: Shieldwall",
		["ruRU"] = "Операция \"Заслон\"",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1375] = {
		["enUS"] = "Dominance Offensive",
		["ruRU"] = "Армия Покорителей",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1374] = {
		["enUS"] = "Brawl'gar Arena (Season 1)",
		["ruRU"] = "Арена \"Морд'Бой\" (сезон 1)",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1359] = {
		["enUS"] = "The Black Prince",
		["ruRU"] = "Черный принц",
	},
	[1358] = {
		["enUS"] = "Nat Pagle",
		["ruRU"] = "Нат Пэгл",
	},
	[1357] = {
		["enUS"] = "Nomi",
		["ruRU"] = "Номи",
	},
	[1353] = {
		["enUS"] = "Tushui Pandaren",
		["ruRU"] = "Пандарены Тушуй",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1352] = {
		["enUS"] = "Huojin Pandaren",
		["ruRU"] = "Пандарены Хоцзинь",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1351] = {
		["enUS"] = "The Brewmasters",
		["ruRU"] = "Хмелевары",
	},
	[1345] = {
		["enUS"] = "The Lorewalkers",
		["ruRU"] = "Хранители истории",
	},
	[1341] = {
		["enUS"] = "The August Celestials",
		["ruRU"] = "Небожители",
	},
	[1337] = {
		["enUS"] = "The Klaxxi",
		["ruRU"] = "Клакси",
	},
	[1302] = {
		["enUS"] = "The Anglers",
		["ruRU"] = "Рыболовы",
	},
	[1283] = {
		["enUS"] = "Farmer Fung",
		["ruRU"] = "Фермер Фун",
	},
	[1282] = {
		["enUS"] = "Fish Fellreed",
		["ruRU"] = "Рыба Тростниковая Шкура",
	},
	[1281] = {
		["enUS"] = "Gina Mudclaw",
		["ruRU"] = "Джина Грязный Коготь",
	},
	[1280] = {
		["enUS"] = "Tina Mudclaw",
		["ruRU"] = "Тина Грязный Коготь",
	},
	[1279] = {
		["enUS"] = "Haohan Mudclaw",
		["ruRU"] = "Хаохань Грязный Коготь",
	},
	[1278] = {
		["enUS"] = "Sho",
		["ruRU"] = "Шо",
	},
	[1277] = {
		["enUS"] = "Chee Chee",
		["ruRU"] = "Чи-Чи",
	},
	[1276] = {
		["enUS"] = "Old Hillpaw",
		["ruRU"] = "Старик Горная Лапа",
	},
	[1275] = {
		["enUS"] = "Ella",
		["ruRU"] = "Элла",
	},
	[1273] = {
		["enUS"] = "Jogu the Drunk",
		["ruRU"] = "Йогу Пьяный",
	},
	[1272] = {
		["enUS"] = "The Tillers",
		["ruRU"] = "Земледельцы",
	},
	[1271] = {
		["enUS"] = "Order of the Cloud Serpent",
		["ruRU"] = "Орден Облачного Змея",
	},
	[1270] = {
		["enUS"] = "Shado-Pan",
		["ruRU"] = "Шадо-Пан",
	},
	[1269] = {
		["enUS"] = "Golden Lotus",
		["ruRU"] = "Золотой Лотос",
	},
	[1245] = {
		["enUS"] = "Mists of Pandaria",
		["ruRU"] = "Mists of Pandaria",
	},
	[1242] = {
		["enUS"] = "Pearlfin Jinyu",
		["ruRU"] = "Цзинь-юй Жемчужного Плавника",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1228] = {
		["enUS"] = "Forest Hozen",
		["ruRU"] = "Лесные хозены",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1216] = {
		["enUS"] = "Shang Xi's Academy",
		["ruRU"] = "Академия Шан Си",
	},
	[1204] = {
		["enUS"] = "Avengers of Hyjal",
		["ruRU"] = "Хиджальские мстители",
	},
	[1178] = {
		["enUS"] = "Hellscream's Reach",
		["ruRU"] = "Батальон Адского Крика",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1177] = {
		["enUS"] = "Baradin's Wardens",
		["ruRU"] = "Защитники Тол Барада",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1174] = {
		["enUS"] = "Wildhammer Clan",
		["ruRU"] = "Клан Громового Молота",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1173] = {
		["enUS"] = "Ramkahen",
		["ruRU"] = "Рамкахены",
	},
	[1172] = {
		["enUS"] = "Dragonmaw Clan",
		["ruRU"] = "Клан Драконьей Пасти",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1171] = {
		["enUS"] = "Therazane",
		["ruRU"] = "Теразан",
	},
	[1169] = {
		["enUS"] = "Guild",
		["ruRU"] = "Гильдия",
	},
	[1168] = {
		["enUS"] = "Guild",
		["ruRU"] = "Гильдия",
	},
	[1162] = {
		["enUS"] = "Cataclysm",
		["ruRU"] = "Cataclysm",
	},
	[1158] = {
		["enUS"] = "Guardians of Hyjal",
		["ruRU"] = "Стражи Хиджала",
	},
	[1156] = {
		["enUS"] = "The Ashen Verdict",
		["ruRU"] = "Пепельный союз",
	},
	[1135] = {
		["enUS"] = "The Earthen Ring",
		["ruRU"] = "Служители Земли",
	},
	[1134] = {
		["enUS"] = "Gilneas",
		["ruRU"] = "Гилнеас",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1133] = {
		["enUS"] = "Bilgewater Cartel",
		["ruRU"] = "Картель Трюмных Вод",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1126] = {
		["enUS"] = "The Frostborn",
		["ruRU"] = "Зиморожденные",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1124] = {
		["enUS"] = "The Sunreavers",
		["ruRU"] = "Похитители Солнца",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1119] = {
		["enUS"] = "The Sons of Hodir",
		["ruRU"] = "Сыны Ходира",
	},
	[1118] = {
		["enUS"] = "Classic",
		["ruRU"] = "World of Warcraft",
	},
	[1117] = {
		["enUS"] = "Sholazar Basin",
		["ruRU"] = "Низина Шолазар",
	},
	[1106] = {
		["enUS"] = "Argent Crusade",
		["ruRU"] = "Серебряный Авангард",
	},
	[1105] = {
		["enUS"] = "The Oracles",
		["ruRU"] = "Оракулы",
	},
	[1104] = {
		["enUS"] = "Frenzyheart Tribe",
		["ruRU"] = "Племя Бешеного Сердца",
	},
	[1098] = {
		["enUS"] = "Knights of the Ebon Blade",
		["ruRU"] = "Рыцари Черного Клинка",
	},
	[1097] = {
		["enUS"] = "Wrath of the Lich King",
		["ruRU"] = "Wrath of the Lich King",
	},
	[1094] = {
		["enUS"] = "The Silver Covenant",
		["ruRU"] = "Серебряный Союз",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1091] = {
		["enUS"] = "The Wyrmrest Accord",
		["ruRU"] = "Драконий союз",
	},
	[1090] = {
		["enUS"] = "Kirin Tor",
		["ruRU"] = "Кирин-Тор",
	},
	[1085] = {
		["enUS"] = "Warsong Offensive",
		["ruRU"] = "Армия Песни Войны",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1077] = {
		["enUS"] = "Shattered Sun Offensive",
		["ruRU"] = "Армия Расколотого Солнца",
	},
	[1073] = {
		["enUS"] = "The Kalu'ak",
		["ruRU"] = "Калу'ак",
	},
	[1072] = {
		["enUS"] = "[DNT] AC Major Faction Child Renown Test",
		["ruRU"] = "[DNT] AC Major Faction Child Renown Test",
	},
	[1068] = {
		["enUS"] = "Explorers' League",
		["ruRU"] = "Лига исследователей",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1067] = {
		["enUS"] = "The Hand of Vengeance",
		["ruRU"] = "Карающая Длань",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1064] = {
		["enUS"] = "The Taunka",
		["ruRU"] = "Таунка",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1052] = {
		["enUS"] = "Horde Expedition",
		["ruRU"] = "Экспедиция Орды",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[1050] = {
		["enUS"] = "Valiance Expedition",
		["ruRU"] = "Экспедиция Отважных",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1038] = {
		["enUS"] = "Ogri'la",
		["ruRU"] = "Огри'ла",
	},
	[1037] = {
		["enUS"] = "Alliance Vanguard",
		["ruRU"] = "Авангард Альянса",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[1031] = {
		["enUS"] = "Sha'tari Skyguard",
		["ruRU"] = "Стражи небес Ша'тар",
	},
	[1015] = {
		["enUS"] = "Netherwing",
		["ruRU"] = "Крылья Пустоты",
	},
	[1012] = {
		["enUS"] = "Ashtongue Deathsworn",
		["ruRU"] = "Пеплоусты-служители",
	},
	[1011] = {
		["enUS"] = "Lower City",
		["ruRU"] = "Нижний Город",
	},
	[990] = {
		["enUS"] = "The Scale of the Sands",
		["ruRU"] = "Песчаная Чешуя",
	},
	[989] = {
		["enUS"] = "Keepers of Time",
		["ruRU"] = "Хранители Времени",
	},
	[980] = {
		["enUS"] = "The Burning Crusade",
		["ruRU"] = "The Burning Crusade",
	},
	[978] = {
		["enUS"] = "Kurenai",
		["ruRU"] = "Куренай",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[970] = {
		["enUS"] = "Sporeggar",
		["ruRU"] = "Спореггар",
	},
	[967] = {
		["enUS"] = "The Violet Eye",
		["ruRU"] = "Аметистовое Око",
	},
	[949] = {
		["enUS"] = "Test Faction 1",
		["ruRU"] = "Тестовая фракция 1",
	},
	[948] = {
		["enUS"] = "Test Faction 2",
		["ruRU"] = "Тестовая фракция 2",
	},
	[947] = {
		["enUS"] = "Thrallmar",
		["ruRU"] = "Траллмар",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[946] = {
		["enUS"] = "Honor Hold",
		["ruRU"] = "Оплот Чести",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[942] = {
		["enUS"] = "Cenarion Expedition",
		["ruRU"] = "Кенарийская экспедиция",
	},
	[941] = {
		["enUS"] = "The Mag'har",
		["ruRU"] = "Маг'хары",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[936] = {
		["enUS"] = "Shattrath City",
		["ruRU"] = "Город Шаттрат",
	},
	[935] = {
		["enUS"] = "The Sha'tar",
		["ruRU"] = "Ша'тар",
	},
	[934] = {
		["enUS"] = "The Scryers",
		["ruRU"] = "Провидцы",
	},
	[933] = {
		["enUS"] = "The Consortium",
		["ruRU"] = "Консорциум",
	},
	[932] = {
		["enUS"] = "The Aldor",
		["ruRU"] = "Алдоры",
	},
	[930] = {
		["enUS"] = "Exodar",
		["ruRU"] = "Экзодар",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[922] = {
		["enUS"] = "Tranquillien",
		["ruRU"] = "Транквиллион",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[911] = {
		["enUS"] = "Silvermoon City",
		["ruRU"] = "Луносвет",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[910] = {
		["enUS"] = "Brood of Nozdormu",
		["ruRU"] = "Род Ноздорму",
	},
	[909] = {
		["enUS"] = "Darkmoon Faire",
		["ruRU"] = "Ярмарка Новолуния",
	},
	[892] = {
		["enUS"] = "Horde Forces",
		["ruRU"] = "Силы Орды",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[891] = {
		["enUS"] = "Alliance Forces",
		["ruRU"] = "Силы Альянса",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[890] = {
		["enUS"] = "Silverwing Sentinels",
		["ruRU"] = "Среброкрылые Часовые",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[889] = {
		["enUS"] = "Warsong Outriders",
		["ruRU"] = "Всадники Песни Войны",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[809] = {
		["enUS"] = "Shen'dralar",
		["ruRU"] = "Шен'дралар",
	},
	[749] = {
		["enUS"] = "Hydraxian Waterlords",
		["ruRU"] = "Гидраксианские Повелители Вод",
	},
	[730] = {
		["enUS"] = "Stormpike Guard",
		["ruRU"] = "Стража Грозовой Вершины",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[729] = {
		["enUS"] = "Frostwolf Clan",
		["ruRU"] = "Азеротский клан Северного Волка",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[609] = {
		["enUS"] = "Cenarion Circle",
		["ruRU"] = "Круг Кенария",
	},
	[589] = {
		["enUS"] = "Wintersaber Trainers",
		["ruRU"] = "Укротители ледопардов",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[577] = {
		["enUS"] = "Everlook",
		["ruRU"] = "Круговзор",
	},
	[576] = {
		["enUS"] = "Timbermaw Hold",
		["ruRU"] = "Древобрюхи",
	},
	[530] = {
		["enUS"] = "Darkspear Trolls",
		["ruRU"] = "Племя Черного Копья",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[529] = {
		["enUS"] = "Argent Dawn",
		["ruRU"] = "Серебряный Рассвет",
	},
	[510] = {
		["enUS"] = "The Defilers",
		["ruRU"] = "Осквернители",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[509] = {
		["enUS"] = "The League of Arathor",
		["ruRU"] = "Лига Аратора",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[470] = {
		["enUS"] = "Ratchet",
		["ruRU"] = "Кабестан",
	},
	[469] = {
		["enUS"] = "Alliance",
		["ruRU"] = "Альянс",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[369] = {
		["enUS"] = "Gadgetzan",
		["ruRU"] = "Прибамбасск",
	},
	[349] = {
		["enUS"] = "Ravenholdt",
		["ruRU"] = "Черный Ворон",
	},
	[270] = {
		["enUS"] = "Zandalar Tribe",
		["ruRU"] = "Племя Зандалари",
	},
	[169] = {
		["enUS"] = "Steamwheedle Cartel",
		["ruRU"] = "Картель Хитрой Шестеренки",
	},
	[93] = {
		["enUS"] = "Magram Clan Centaur",
		["ruRU"] = "Кентавры из племени Маграм",
	},
	[92] = {
		["enUS"] = "Gelkis Clan Centaur",
		["ruRU"] = "Кентавры из племени Гелкис",
	},
	[87] = {
		["enUS"] = "Bloodsail Buccaneers",
		["ruRU"] = "Пираты Кровавого Паруса",
	},
	[81] = {
		["enUS"] = "Thunder Bluff",
		["ruRU"] = "Громовой Утес",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[76] = {
		["enUS"] = "Orgrimmar",
		["ruRU"] = "Оргриммар",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[72] = {
		["enUS"] = "Stormwind",
		["ruRU"] = "Штормград",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[70] = {
		["enUS"] = "Syndicate",
		["ruRU"] = "Синдикат",
	},
	[69] = {
		["enUS"] = "Darnassus",
		["ruRU"] = "Дарнас",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[68] = {
		["enUS"] = "Undercity",
		["ruRU"] = "Подгород",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[67] = {
		["enUS"] = "Horde",
		["ruRU"] = "Орда",
		side = "Horde",
		icon1 = ICON_HORDE,
	},
	[59] = {
		["enUS"] = "Thorium Brotherhood",
		["ruRU"] = "Братство Тория",
	},
	[54] = {
		["enUS"] = "Gnomeregan",
		["ruRU"] = "Гномреган",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[47] = {
		["enUS"] = "Ironforge",
		["ruRU"] = "Стальгорн",
		side = "Alliance",
		icon1 = ICON_ALLIANCE,
	},
	[21] = {
		["enUS"] = "Booty Bay",
		["ruRU"] = "Пиратская Бухта",
	},
}
E.TBL_validReps = {}
E.TBL_paragonQuests = {}
E.OctoTable_Reputations_Paragon_Data = {}
for reputationID, data in next, (E.OctoTable_Reputations_DB) do
	E.TBL_validReps[reputationID] = true
	local paragonQuest = data.paragonQuest
	if paragonQuest then
		E.TBL_paragonQuests[paragonQuest] = true
		E.ALL_Quests[paragonQuest] = true
	end
	local itemCache = data.itemCache
	if itemCache then
		E.ALL_Items[itemCache] = true
	end
	if paragonQuest and itemCache then
		E.OctoTable_Reputations_Paragon_Data[paragonQuest] = {
			factionID = reputationID,
			cache = itemCache
		}
	end
end
-- local itemCache = E.OctoTable_Reputations_DB[id].itemCache
-- local paragonQuest = E.OctoTable_Reputations_DB[id].paragonQuest
-- collectMASLENGO.ListOfParagonQuests?????