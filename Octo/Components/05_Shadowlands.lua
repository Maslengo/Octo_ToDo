local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local dropdownOrder = 5
local expansionID = 9
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[dropdownOrder].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].name
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(dropdownOrder)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {
		2009, 1906, 1828, 1979, 1931,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[dropdownOrder].icon, name = E.OctoTable_Expansions[dropdownOrder].color..E.OctoTable_Expansions[dropdownOrder].name.."|r",},
		-- ["Shadowlands"] = {
		2413, --name = "Двор Жнецов", side = "-", category = "Темные Земли", }, --[faction=2413]
		2464, --name = "Двор Ночи", side = "-", category = "Темные Земли", }, --[faction=2464]
		2470, --name = "Легион Смерти", side = "-", category = "Темные Земли", }, --[faction=2470]
		2462, --name = "Штопальщики", side = "-", category = "Темные Земли", }, --[faction=2462]
		2472, --name = "Кодекс архивариуса", side = "-", category = "Темные Земли", }, --[faction=2472]
		2407, --name = "Перерожденные", side = "-", category = "Темные Земли", }, --[faction=2407]
		2439, --name = "Нераскаявшиеся", side = "-", category = "Темные Земли", }, --[faction=2439]
		2478, --name = "Просветленные", side = "-", category = "Темные Земли", }, --[faction=2478]
		2410, --name = "Неумирающая армия", side = "-", category = "Темные Земли", }, --[faction=2410]
		2465, --name = "Дикая Охота", side = "-", category = "Темные Земли", }, --[faction=2465]
		2432, --name = "Ве'нари", side = "-", category = "Темные Земли", }, --[faction=2432]
		2445, --name = "Пепельный двор", side = "-", category = "Темные Земли", }, --[faction=2445]
		2469, --name = "Понимание фракталов", side = "-", category = "Темные Земли", }, --[faction=2469]
		2463, --name = "Чесночник", side = "-", category = "Темные Земли", }, --[faction=2463]
		----------------------------------------------------------------
		2455, --name = "Хранитель склепа Каззир", side = "-", category = "Пепельный двор", }, --[faction=2455]
		2458, --name = "Клейя и Пелагий", side = "-", category = "Пепельный двор", }, --[faction=2458]
		2453, --name = "Рендл и Дуборыл", side = "-", category = "Пепельный двор", }, --[faction=2453]
		2460, --name = "Камнелоб", side = "-", category = "Пепельный двор", }, --[faction=2460]
		2461, --name = "Изобретатель чумы Марилет", side = "-", category = "Пепельный двор", }, --[faction=2461]
		2459, --name = "Сика", side = "-", category = "Пепельный двор", }, --[faction=2459]
		2457, --name = "Великий мастер Воул", side = "-", category = "Пепельный двор", }, --[faction=2457]
		2456, --name = "Дроман Алиот", side = "-", category = "Пепельный двор", }, --[faction=2456]
		2454, --name = "Чуфа", side = "-", category = "Пепельный двор", }, --[faction=2454]
		2452, --name = "Полемарх Адрест", side = "-", category = "Пепельный двор", }, --[faction=2452]
		2451, --name = "Капитан-егерь Корейн", side = "-", category = "Пепельный двор", }, --[faction=2451]
		2450, --name = "Александрос Могрейн", side = "-", category = "Пепельный двор", }, --[faction=2450]
		2449, --name = "Графиня", side = "-", category = "Пепельный двор", }, --[faction=2449]
		2448, --name = "Миканикос", side = "-", category = "Пепельный двор", }, --[faction=2448]
		2447, --name = "Леди Лунная Ягода", side = "-", category = "Пепельный двор", }, --[faction=2447]
		2446, --name = "Баронесса Вайш", side = "-", category = "Пепельный двор", }, --[faction=2446]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = "Other: Rares",
			name_save = "OtherRares",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				-- Bastion
				{nil, addText = {mapID = 1533},},
				{60977, forcedText = {npcID = 170832}, addText = {mount = 1426},},
				{60977, forcedText = {npcID = 170833}, addText = {mount = 1426},},
				{60977, forcedText = {npcID = 170834}, addText = {mount = 1426},},
				{60977, forcedText = {npcID = 170835}, addText = {mount = 1426},},
				{60977, forcedText = {npcID = 170836}, addText = {mount = 1426},},
				{60862, forcedText = {npcID = 170548}, addText = {mount = 1307},},
				{nil},
				-- Maldraxxus
				{nil, addText = {mapID = 1536},},
				{61720, forcedText = {npcID = 157309}, addText = {mount = 1410},},
				{58783, forcedText = {npcID = 162586}, addText = {mount = 1366, Icon = E.ICON_NECROLORD},},
				{58851, forcedText = {npcID = 162690}, addText = {mount = 1373},},
				{58872, forcedText = {npcID = 162741}, addText = {mount = 1411, Icon = E.ICON_NECROLORD},},
				{58889, forcedText = {npcID = 162819}, addText = {mount = 1372},},
				{58784, forcedText = {npcID = 168147}, addText = {mount = 1370, Icon = E.ICON_NECROLORD},},
				{nil},
				-- Ardenweald
				{nil, addText = {mapID = 1565},},
				{59145, forcedText = {npcID = 164107}, addText = {mount = 1362},},
				{59157, forcedText = {npcID = 164112}, addText = {mount = 1415},},
				{60306, forcedText = {npcID = 168135}, addText = {mount = 1306},},
				{61632, forcedText = {npcID = 168647}, addText = {mount = 1393, Icon = E.ICON_NIGHTFAE},},
				{nil},
				-- Revendreth
				{nil, addText = {mapID = 1525},},
				{58259, forcedText = {npcID = 160821}, addText = {mount = 1391},},
				{59612, forcedText = {npcID = 165290}, addText = {mount = 1310, Icon = E.ICON_VENTHYR},},
				{59869, forcedText = {npcID = 166521}, addText = {mount = 1379},},
				{59900, forcedText = {npcID = 166679}, addText = {mount = 1298, Icon = E.ICON_VENTHYR},},
				{62046, forcedText = {npcID = 173499}, addText = {mount = 1391},},
				-- {62050, forcedText = {npcID = 173468}, addText = {mount = 1414},}, -- WEEKLY
			},
			-- forcedMaxQuest = 25,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{61813, forcedText = {npcID = 167524}, addText = {mapID = 1533},}, -- "Валинор" <Свет эпох> Бастион
				{61816, forcedText = {npcID = 167525}, addText = {mapID = 1536},}, -- Мортанис Малдраксус (2).
				{61815, forcedText = {npcID = 167527}, addText = {mapID = 1565},}, -- Ораномонос Вечноветвящаяся Арденвельд (3).
				{61814, forcedText = {npcID = 167526}, addText = {mapID = 1525},}, -- Нургаш Жижерожденный Ревендрет (3).
				{nil},
				{65143, forcedText = {npcID = 182466}, addText = {mapID = 1970},}, -- Антрос <Хранитель Предшественников> Зерет Мортис (2).
				{nil},
				{64531, forcedText = {npcID = 178958}, addText = {mapID = 1543},}, -- Мор'гет <Мучитель проклятых> Утроба .
			},
			forcedMaxQuest = 3,
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			textleft = L["Replenish the Reservoir"],-- "1000 anima", -- E.func_questName(61981),
			name_save = "anima1k",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{61982, addText = {Icon = E.ICON_KYRIAN}},
				{61983, addText = {Icon = E.ICON_NECROLORD}},
				{61984, addText = {Icon = E.ICON_NIGHTFAE}},
				{61981, addText = {Icon = E.ICON_VENTHYR}},
			},
			-- forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = L["Troubles at Home"], -- E.func_questName(61981),
			name_save = "Troubles at Home",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{60425, addText = {Icon = E.ICON_KYRIAN}},
				{60429, addText = {Icon = E.ICON_NECROLORD}},
				{60419, addText = {Icon = E.ICON_NIGHTFAE}},
				{60432, addText = {Icon = E.ICON_VENTHYR}},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["Covenant Assault"],
			name_save = "MAWassault",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{63824, addText = {Icon = E.ICON_KYRIAN}},
				{63543, addText = {Icon = E.ICON_NECROLORD}},
				{63823, addText = {Icon = E.ICON_NIGHTFAE}},
				{63822, addText = {Icon = E.ICON_VENTHYR}},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["The Hunt"],
			name_save = "MAWhunt",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{63180, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Hunt: Shadehounds"]},},
				{63194, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Hunt: Winged Soul Eaters"]},},
				{63198, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Hunt: Death Elementals"]},},
				{63199, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Hunt: Soul Eaters"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["Wrath of the Jailer"],
			name_save = "MAWwrathofthejailer",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{63414, addText = {IconVignette = "VignetteEventElite"}, forcedText = {text = L["Wrath of the Jailer"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["Event: Tormentors of Torghast"].." "..E.Timers.SL_Maw_TormentorsofTorghast(),
			name_save = "MAWtormentor",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{63854, addText = {IconVignette = "Tormentors-Boss",}, forcedText = {text = L["Event: Tormentors of Torghast"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["Helsworn Chest"],
			name_save = "MAWHelswornChest",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{64256, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Helsworn Chest"]},}, -- Maw chest in Desmotaeron
			},
			forcedMaxQuest = 1,
		},
		{ -- ПОФИКСИТЬ доступно только во время найт фей ассаулта
			showTooltip = true,
			textleft = E.func_mapName(1543)..": "..L["Stolen Anima Vessel"]..E.RIFT,
			name_save = "MAWStolenAnimaVesselRIFT",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{64265, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
				{64269, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
				{64270, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": ".."Daily",--E.func_currencyName(1880),
			name_save = "MAWdailyQuests",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{60646},
				{60762},
				{60775},
				{61075},
				{61079},
				{61088},
				{61103},
				{61104},
				{61765},
				{62214},
				{62234},
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1543)..": ".."Rares",
			name_save = "MAWRares",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{57469, forcedText = {npcID = 157833}},
				{57482, forcedText = {npcID = 157964}},
				{57509, forcedText = {npcID = 154330}},
				{57573, forcedText = {npcID = 158278}},
				{59183, forcedText = {npcID = 158314}},
				{59230, forcedText = {npcID = 162452}},
				{61519, forcedText = {npcID = 172577}},
				{61568, forcedText = {npcID = 172862}},
				{61728, forcedText = {npcID = 173086}},
				{62209, forcedText = {npcID = 172523}},
				{62210, forcedText = {npcID = 172521}},
				{62211, forcedText = {npcID = 172524}},
				{62281, forcedText = {npcID = 160770}},
				{62282, forcedText = {npcID = 158025}},
				{62539, forcedText = {npcID = 156203}},
				{62788, forcedText = {npcID = 175012}},
				{63044, forcedText = {npcID = 175821}},
				{64152, forcedText = {npcID = 177444}},
				{64164, forcedText = {npcID = 179460}, addText = {mount = 1502}},
				{64232, forcedText = {npcID = 179735}, addText = {notes = E.RIFT}},
				{64251, forcedText = {npcID = 179779}},
				{64258, forcedText = {npcID = 179805}},
				{64258, forcedText = {npcID = 180246}},
				{64272, forcedText = {npcID = 179851}, addText = {notes = E.RIFT}},
				{64276, forcedText = {npcID = 179853}, addText = {notes = E.RIFT}},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": "..E.func_questName(63949), --"Weekly",
			name_save = "KORTHIAweekly",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{63949},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".."Lost Research", -- E.func_questName(65266),
			name_save = "KORTHIAlostresearch",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{65266},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": "..E.func_questName(64552), --"anima table mission",
			name_save = "KORTHIAanimatablemission",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{64552, addText = {Icon = E.ICON_KYRIAN},}, -- ker
				{64551, addText = {Icon = E.ICON_NECROLORD},}, -- necr
				{64549, addText = {Icon = E.ICON_NIGHTFAE},}, -- fae
				{64553, addText = {Icon = E.ICON_VENTHYR},}, -- vent
			},
			forcedMaxQuest = 4,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".."Rares",
			name_save = "KORTHIARares",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{63830, forcedText = {npcID = 177903},},
				{64233, forcedText = {npcID = 179684}, addText = {mount = 1506},},
				{64243, forcedText = {npcID = 179768},},
				{64245, forcedText = {npcID = 179760},},
				{64246, forcedText = {npcID = 179472}, addText = {mount = 1514},},
				{64257, forcedText = {npcID = 179802},},
				{64263, forcedText = {npcID = 179608},},
				{64278, forcedText = {npcID = 179859},},
				{64284, forcedText = {npcID = 179911},},
				{64285, forcedText = {npcID = 179913},},
				{64291, forcedText = {npcID = 179931},},
				-- {64292, forcedText = {npcID = 179912}, addText = {mount = 1511},}, -- ONCE
				{64313, forcedText = {npcID = 179985}, addText = {mount = 803, Icon = E.ICON_VENTHYR},}, -- VENTHYR
				{64320, forcedText = {npcID = 180014}, addText = {mount = 1487, Icon = E.ICON_NIGHTFAE},}, -- NIGHT FAE
				{64338, forcedText = {npcID = 180032}, addText = {mount = 1493, Icon = E.ICON_KYRIAN},}, -- KYRIAN
				{64349, forcedText = {npcID = 180042}, addText = {mount = 1449, Icon = E.ICON_NECROLORD},}, -- NECROLORD
				{64428, forcedText = {npcID = 179108},},
				{64439, forcedText = {npcID = 180246},},
				{64440, forcedText = {npcID = 179914}, addText = {notes = E.RIFT}},
				{64442, forcedText = {npcID = 177336},},
				{64455, forcedText = {npcID = 180160}, addText = {mount = 1509},},
				{64457, forcedText = {npcID = 180162},},
			},
			forcedMaxQuest = 23,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".. L["Daily quests"],
			name_save = "KORTHIADailyQuest",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{63787},
				{64103},
				{63788},
				{63793},
			},
			forcedMaxQuest = 4,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".. E.func_questName(64522),
			name_save = "KORTHIAStolenKorthianSupplies",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{64522},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".. L["Purple Mobs"],
			name_save = "KORTHIAPurpleMobs",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{64341},
				{64342},
				{64343},
				{64344},
				{64747},
				{64748},
				{64749},
				{64750},
				{64751},
				{64752},
				{64753},
				{64754},
				{64755},
				{64756},
				{64757},
			},
			forcedMaxQuest = 15, -- 3?
		},
		{
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".. L["Relic Gorgers"],
			name_save = "KORTHIARelicGorgers",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{64433},
				{64434},
				{64435},
				{64436},
			},
			forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".. AREA_LOOTING_UNLOCKED, -- L["Mushrooms"]
			name_save = "KORTHIACollectionMushrooms",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{64351, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mushrooms"].." 1"},},
				{64354, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mushrooms"].." 2"},},
				{64355, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mushrooms"].." 3"},},
				{64356, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mushrooms"].." 4"},},
				{64357, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mushrooms"].." 5"},},
				{nil},
				{64358, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Nests"].." 1"},}, -- ДА
				{64359, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Nests"].." 2"},},
				{64360, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Nests"].." 3"},},
				{64361, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Nests"].." 4"},},
				{64362, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Nests"].." 5"},},
				{nil},
				{64021, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mawsworn Caches"].." 1"},},
				{64363, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mawsworn Caches"].." 2"},},
				{64364, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Mawsworn Caches"].." 3"},},
				{nil},
				{64787, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Bones/Stones/Relics"].." 1"},},
				{64788, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Bones/Stones/Relics"].." 2"},},
				{64789, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Bones/Stones/Relics"].." 3"},},
				{64790, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Bones/Stones/Relics"].." 4"},},
				{64791, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Bones/Stones/Relics"].." 5"},},
				{nil},
				{64247, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Spectral Bound Chest"]},}, -- Chest with 3 keys
				{nil},
				{64575, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Anima Vessel"]},},
				{nil},
				{64456, addText = {IconVignette = "VignetteLoot", notes = E.RIFT,}, forcedText = {text = L["Riftbound Cache"].." 1"},},
				{64470, addText = {IconVignette = "VignetteLoot", notes = E.RIFT,}, forcedText = {text = L["Riftbound Cache"].." 2"},},
				{64471, addText = {IconVignette = "VignetteLoot", notes = E.RIFT,}, forcedText = {text = L["Riftbound Cache"].." 3"},},
				{64472, addText = {IconVignette = "VignetteLoot", notes = E.RIFT,}, forcedText = {text = L["Riftbound Cache"].." 4"},},
				{nil},
				{64283, addText = {IconVignette = "VignetteLoot", notes = E.RIFT,}, forcedText = {text = L["Zovaal's Vault"]},},
				{nil},
				{64572, forcedText = {itemID = 187216},},
			},
			-- forcedMaxQuest = 5,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_texturefromIcon(456578)..E.func_mapName(1961)..": ".."Items",
			name_save = "KORTHIAitems",
			reset = "Once",
			desc = dropdownOrder,
			quests = {
				{64061, forcedText = {itemID = 186453}}, -- Vault Anima Tracker
				{64307, forcedText = {itemID = 187145}}, -- Treatise: Recognizing StygiaanditsUses
				{64828, forcedText = {itemID = 187706}}, -- Treatise: Bonds of Stygiain Mortals
				{64027, forcedText = {itemID = 186722}}, -- Treatise: The Study of Animaand Harnessing Every Drop
				{64366, forcedText = {itemID = 186721}}, -- Treatise: Relics Aboundinthe Shadowlands
				-- {64339, forcedText = {itemID = 186714}}, -- 100(2) Research Report: All-Seeing Crystal
				-- {64348, forcedText = {itemID = 186716}}, -- 1000(5) Research Report: Ancient Shrines
				{64300, forcedText = {itemID = 186717}}, -- 4000(6) Research Report: Adaptive Alloys
				{64303, forcedText = {itemID = 187138}}, -- 8000(6) Research Report: First Alloys
				{64367, forcedText = {itemID = 187136}}, -- 2500(6) Research Report Relic Examination Techniques
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": ".."Weekly", -- E.func_questName(66042),
			name_save = "ZMpatternswithinpatterns",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{66042},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": ".."Rares",
			name_save = "ZMRares",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{65557, forcedText = {npcID = 178229}},
				{65547, forcedText = {npcID = 178508}},
				{65581, forcedText = {npcID = 178563}},
				{65579, forcedText = {npcID = 178778}},
				{63988, forcedText = {npcID = 178963}},
				{65552, forcedText = {npcID = 184413}}, -- ???????
				{65582, forcedText = {npcID = 179043}},
				{64668, forcedText = {npcID = 180746}},
				{64716, forcedText = {npcID = 180917}},
				{64719, forcedText = {npcID = 180924}},
				{65548, forcedText = {npcID = 180978}, addText = {mount = 1434},},
				{65550, forcedText = {npcID = 181249}},
				{65239, forcedText = {npcID = 181360}},
				{65585, forcedText = {npcID = 182114}, addText = {mount = 1584},}, -- Dominance Rares
				{65586, forcedText = {npcID = 182155}}, -- Dominance Rares
				{65587, forcedText = {npcID = 182158}}, -- Dominance Rares
				{65583, forcedText = {npcID = 182318}},
				{65580, forcedText = {npcID = 183516}},
				{65553, forcedText = {npcID = 183596}},
				{65544, forcedText = {npcID = 183646}},
				{65240, forcedText = {npcID = 183722}},
				{65241, forcedText = {npcID = 183737}},
				{65556, forcedText = {npcID = 183746}},
				{65584, forcedText = {npcID = 183747}},
				{65551, forcedText = {npcID = 183748}},
				{65251, forcedText = {npcID = 183764}},
				{65257, forcedText = {npcID = 183814}},
				{65272, forcedText = {npcID = 183925}},
				{65574, forcedText = {npcID = 183927}},
				{65273, forcedText = {npcID = 183953}},
				{65555, forcedText = {npcID = 184409}},
				{65549, forcedText = {npcID = 179006}},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": ".."WorldQuests",
			name_save = "ZMWorldQuests",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{64960},
				{64974},
				{65081},
				{65089},
				{65102},
				{65115},
				{65117},
				{65119},
				{65230},
				{65232},
				{65234},
				{65244},
				{65252},
				{65262},
				{65402},
				{65403},
				{65404},
				{65405},
				{65406},
				{65407},
				{65408},
				{65410},
				{65411},
				{65412},
				{65413},
				{65414},
				{65415},
				{65416},
				{65417},
				{65231},
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": "..AREA_LOOTING_UNLOCKED, -- AREA_LOOTING_UNLOCKED "Treasures"
			name_save = "ZMtreasures",
			reset = "Once",
			desc = dropdownOrder,
			quests = {
				{65520},
				{65573},
				{65489},
				{64667},
				{65465},
				{65523},
				{65487},
				{65503},
				{65178},
				{65480},
				{65545},
				{65173},
				{65441},
				{65522},
				{65537},
				{65536},
				{65542},
				{65546},
				{65540},
				{65566},
				{65447},
				{65543},
				{64545},
				{65270},
				{65565},
				{65175},
			},
			-- forcedMaxQuest = 26,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": "..L["Undulating Foliage"],
			name_save = "ZMUndulatingFoliage",
			reset = "Once",
			desc = dropdownOrder,
			quests = {
				{65572, forcedText = {text = L["Undulating Foliage"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": "..L["Prying Eye Discovery"],
			name_save = "ZMPryingEyeDiscovery",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{65184, forcedText = {text = L["Prying Eye Discovery"]},},
				{65501, forcedText = {text = L["Prying Eye Discovery"]},},
				{65611, forcedText = {text = L["Prying Eye Discovery"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(1670)..": ".."Trading Favors",
			name_save = "Trading Favors",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{60242},
				{60243},
				{60244},
				{60245},
				{60246},
				{60247},
				{60248},
				{60249},
			},
			forcedMaxQuest = 1,
		},

		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_mapName(1670)..": ".."A Valuable Find",
			name_save = "A Valuable Find",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{60250},
				{60251},
				{60252},
				{60253},
				{60254},
				{60255},
				{60256},
				{60257},
			},
			forcedMaxQuest = 1,
		},








		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": ".."ZMPUZZLECACHES",
			name_save = "ZMPUZZLECACHES",
			reset = "Daily",
			desc = dropdownOrder,
			quests = {
				{65094},
				{65323},
				{65318},
				{65322},
				{65317},
				{65093},
				{65321},
				{65092},
				{65316},
				{65412},
				{65315},
				{65091},
				{65320},
				{64972},
				{65314},
				{65319},
			},
			forcedMaxQuest = 50,
		},
		{
			showTooltip = true,
			textleft = E.func_mapName(1970)..": ".."ZMConcordance",
			name_save = "ZMConcordance",
			reset = "Once",
			desc = dropdownOrder,
			quests = {
				{65179},
				{65213},
				{65216},
				{65210},
				{65180},
				{65214},
				{65211},
				{65217},
				{64940},
				{65212},
				{65209},
				{65215},
			},
			forcedMaxQuest = 12,
		},
		--------------------------------------------------------------
		--------------------------------------------------------------
		--------------------------------------------------------------
		{
			showTooltip = false,
			textleft = E.func_questName(62858),
			name_save = "Return Lost Souls",
			reset = "Weekly",
			desc = dropdownOrder,
			quests = {
				{62858},
				{62859},
				{62860},
				{62861},
				{62862},
				{62863},
				{62864},
				{62865},
				{62866},
				{62867},
				{62868},
				{62869},
			},
			forcedMaxQuest = 1,
		},
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
		"CovenantRenown",
		"CovenantAnima",
	}
	----------------------------------------------------------------
end

table.insert(E.Components, tempFunction)
----------------------------------------------------------------
local function localfunc2()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
						----------------------------------------------------------------
						local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil, false, nil, nil
						----------------------------------------------------------------
						local color = E.OctoTable_Covenant[iANIMA].color
						-- отриосвка всего по центру
						if CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] then
							textCENT = color..CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant].."|r"
						end
						if kCovenant == 1 then
							-- iconLEFT = E.OctoTable_Covenant[iANIMA].icon
							myType = {"Currency_Covenant_Renown", 1813, iANIMA, kCovenant}
						elseif kCovenant == 2 then
							-- iconLEFT = E.func_GetCurrencyIcon(1813)
							myType = {"Currency_Covenant_Anima", 1813, iANIMA, kCovenant}
							if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
								if CharInfo.PlayerData.Possible_Anima then
									textCENT = textCENT..E.Blue_Color.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
								end
							end
						end
						if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
							colorCENT = color
						else
							colorCENT = nil
						end
						----------------------------------------------------------------
						vivodLeft = color..E.OctoTable_Covenant[iANIMA].name.."|r"
						----------------------------------------------------------------
						textLEFT = vivodLeft
						colorLEFT = E.OctoTable_Expansions[dropdownOrder].color
						----------------------------------------------------------------
						return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep
						----------------------------------------------------------------
				end)
			end
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end

