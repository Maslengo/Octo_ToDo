local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Shadowlands_available = E.func_Is_Shadowlands_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Shadowlands_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local categoryKey = 9
local expansionID = 9
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
		{id = 1822, defS = true,}, -- Renown
		{id = 1813, defS = true,}, -- Reservoir Anima
		{id = 2009, defS = true,},
		{id = 1906, defS = true,},
		{id = 1828, defS = true,},
		{id = 1979, defS = true,},
		{id = 1931, defS = true,},
		{id = 1816, defS = false,},
		{id = 1885, defS = true,},
		{id = 1767, defS = true,},
		{id = 1820, defS = false,},
		{id = 1904, defS = false,},
		{id = 1819, defS = false,},
		{id = 1754, defS = false,},
		{id = 1977, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			{id = 1195, defS = true,}, -- Sepulcher of the First Ones
			{id = 1193, defS = true,}, -- Sanctum of Domination
			{id = 1190, defS = true,}, -- Castle Nathria
			-- {id = 1192, defS = true,}, -- Shadowlands
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 2470, defS = true,}, --name = "Легион Смерти", side = "-", category = "Темные Земли", }, --[faction=2470]
		{id = 2472, defS = true,}, --name = "Кодекс архивариуса", side = "-", category = "Темные Земли", }, --[faction=2472]
		{id = 2478, defS = true,}, --name = "Просветленные", side = "-", category = "Темные Земли", }, --[faction=2478]
		{id = 2432, defS = true,}, --name = "Ве'нари", side = "-", category = "Темные Земли", }, --[faction=2432]
		----------------------------------------------------------------
		{id = 2407, defS = true,}, --name = "Перерожденные", side = "-", category = "Темные Земли", }, --[faction=2407]
		----------------------------------------------------------------
		{id = 2413, defS = true,}, --name = "Двор Жнецов", side = "-", category = "Темные Земли", }, --[faction=2413]
		{id = 2439, defS = false,}, --name = "Нераскаявшиеся", side = "-", category = "Темные Земли", }, --[faction=2439]
		{id = 2445, defS = false,}, --name = "Пепельный двор", side = "-", category = "Темные Земли", }, --[faction=2445]
		{id = 2455, defS = false,}, --name = "Хранитель склепа Каззир", side = "-", category = "Пепельный двор", }, --[faction=2455]
		{id = 2458, defS = false,}, --name = "Клейя и Пелагий", side = "-", category = "Пепельный двор", }, --[faction=2458]
		{id = 2453, defS = false,}, --name = "Рендл и Дуборыл", side = "-", category = "Пепельный двор", }, --[faction=2453]
		{id = 2460, defS = false,}, --name = "Камнелоб", side = "-", category = "Пепельный двор", }, --[faction=2460]
		{id = 2461, defS = false,}, --name = "Изобретатель чумы Марилет", side = "-", category = "Пепельный двор", }, --[faction=2461]
		{id = 2459, defS = false,}, --name = "Сика", side = "-", category = "Пепельный двор", }, --[faction=2459]
		{id = 2457, defS = false,}, --name = "Великий мастер Воул", side = "-", category = "Пепельный двор", }, --[faction=2457]
		{id = 2456, defS = false,}, --name = "Дроман Алиот", side = "-", category = "Пепельный двор", }, --[faction=2456]
		{id = 2454, defS = false,}, --name = "Чуфа", side = "-", category = "Пепельный двор", }, --[faction=2454]
		{id = 2452, defS = false,}, --name = "Полемарх Адрест", side = "-", category = "Пепельный двор", }, --[faction=2452]
		{id = 2451, defS = false,}, --name = "Капитан-егерь Корейн", side = "-", category = "Пепельный двор", }, --[faction=2451]
		{id = 2450, defS = false,}, --name = "Александрос Могрейн", side = "-", category = "Пепельный двор", }, --[faction=2450]
		{id = 2449, defS = false,}, --name = "Графиня", side = "-", category = "Пепельный двор", }, --[faction=2449]
		{id = 2448, defS = false,}, --name = "Миканикос", side = "-", category = "Пепельный двор", }, --[faction=2448]
		{id = 2447, defS = false,}, --name = "Леди Лунная Ягода", side = "-", category = "Пепельный двор", }, --[faction=2447]
		{id = 2446, defS = false,}, --name = "Баронесса Вайш", side = "-", category = "Пепельный двор", }, --[faction=2446]
		----------------------------------------------------------------
		{id = 2465, defS = true,}, --name = "Дикая Охота", side = "-", category = "Темные Земли", }, --[faction=2465]
		{id = 2464, defS = false,}, --name = "Двор Ночи", side = "-", category = "Темные Земли", }, --[faction=2464]
		{id = 2463, defS = false,}, --name = "Чесночник", side = "-", category = "Темные Земли", }, --[faction=2463]
		----------------------------------------------------------------
		{id = 2410, defS = true,}, --name = "Неумирающая армия", side = "-", category = "Темные Земли", }, --[faction=2410]
		{id = 2462, defS = false,}, --name = "Штопальщики", side = "-", category = "Темные Земли", }, --[faction=2462]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			TextLeft = L["World Boss"],
			name_save = "WorldBoss",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
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
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = L["Replenish the Reservoir"],-- "1000 anima", -- E.func_GetQuestName(61981, false),
		-- name_save = "anima1k",
		-- defS = true,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {61982, addText = {Icon = E.ICON_KYRIAN}},
		-- {61981, addText = {Icon = E.ICON_VENTHYR}},
		-- {61984, addText = {Icon = E.ICON_NIGHTFAE}},
		-- {61983, addText = {Icon = E.ICON_NECROLORD}},
		-- },
		-- -- forcedMaxQuest = 4,
		-- },
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = L["Troubles at Home"], -- E.func_GetQuestName(61981, false),
		-- name_save = "Troubles at Home",
		-- defS = true,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {60425, addText = {Icon = E.ICON_KYRIAN}},
		-- {60432, addText = {Icon = E.ICON_VENTHYR}},
		-- {60419, addText = {Icon = E.ICON_NIGHTFAE}},
		-- {60429, addText = {Icon = E.ICON_NECROLORD}},
		-- },
		-- -- forcedMaxQuest = 1,
		-- },
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": "..E.func_GetQuestName(66042, true)
			end,
			name_save = "ZMpatternswithinpatterns",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{66042},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": ".."Rares"
			end,
			name_save = "ZMRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = function()
				return E.func_GetMapName(1970)..": ".."WorldQuests"
			end,
			name_save = "ZMWorldQuests",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
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
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": "..AREA_LOOTING_UNLOCKED -- AREA_LOOTING_UNLOCKED "Treasures"
			end,
			name_save = "ZMtreasures",
			defS = true,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{65520, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 1"},},
				{65573, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 2"},},
				{65489, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 3"},},
				{64667, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 4"},},
				{65465, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 5"},},
				{65523, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 6"},},
				{65487, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 7"},},
				{65503, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 8"},},
				{65178, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 9"},},
				{65480, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 10"},},
				{65545, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 11"},},
				{65173, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 12"},},
				{65441, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 13"},},
				{65522, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 14"},},
				{65537, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 15"},},
				{65536, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 16"},},
				{65542, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 17"},},
				{65546, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 18"},},
				{65540, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 19"},},
				{65566, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 20"},},
				{65447, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 21"},},
				{65543, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 22"},},
				{64545, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 23"},},
				{65270, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 24"},},
				{65565, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 25"},},
				{65175, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Treasure"].." 26"},},
			},
			-- forcedMaxQuest = 26,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": "..L["Undulating Foliage"]
			end,
			name_save = "ZMUndulatingFoliage",
			defS = false,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{65572, forcedText = {text = L["Undulating Foliage"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": "..L["Prying Eye Discovery"]
			end,
			name_save = "ZMPryingEyeDiscovery",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
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
			TextLeft = function()
				return E.func_GetMapName(1970)..": ".."Puzzle caches"
			end,
			name_save = "Puzzle caches",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{65094, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 1"},},
				{65323, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 2"},},
				{65318, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 3"},},
				{65322, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 4"},},
				{65317, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 5"},},
				{65093, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 6"},},
				{65321, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 7"},},
				{65092, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 8"},},
				{65316, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 9"},},
				{65412, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 10"},},
				{65315, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 11"},},
				{65091, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 12"},},
				{65320, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 13"},},
				{64972, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 14"},},
				{65314, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 15"},},
				{65319, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Puzzle caches".." 16"},},
			},
			-- forcedMaxQuest = 50,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1970)..": ".."Concordance"
			end,
			name_save = "Concordance",
			defS = false,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{65179, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 1"},},
				{65213, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 2"},},
				{65216, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 3"},},
				{65210, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 4"},},
				{65180, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 5"},},
				{65214, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 6"},},
				{65211, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 7"},},
				{65217, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 8"},},
				{64940, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 9"},},
				{65212, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 10"},},
				{65209, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 11"},},
				{65215, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Concordance".." 12"},},
			},
			-- forcedMaxQuest = 12,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": "..E.func_GetQuestName(63949, true)
			end,
			name_save = "KORTHIAweekly",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{63949},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": "..E.func_GetQuestName(65266, false)
			end,
			name_save = "KORTHIAlostresearch",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{65266},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": "..E.func_GetQuestName(64552, false)
			end,
			name_save = "KORTHIAanimatablemission",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{64552, addText = {Icon = E.ICON_KYRIAN},}, -- ker
				{64553, addText = {Icon = E.ICON_VENTHYR},}, -- vent
				{64549, addText = {Icon = E.ICON_NIGHTFAE},}, -- fae
				{64551, addText = {Icon = E.ICON_NECROLORD},}, -- necr
			},
			forcedMaxQuest = 4,
		},
		-- {
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetMapName(1961)..": ".. E.func_GetQuestName(64522, false)
		-- end,
		-- name_save = "KORTHIAStolenKorthianSupplies",
		-- defS = true,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {64522},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": ".."Rares"
			end,
			name_save = "KORTHIARares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
				{64292, forcedText = {npcID = 179912}, addText = {mount = 1511},}, -- ONCE
				{64338, forcedText = {npcID = 180032}, addText = {mount = 1493, Icon = E.ICON_KYRIAN},}, -- KYRIAN
				{64313, forcedText = {npcID = 179985}, addText = {mount = 803, Icon = E.ICON_VENTHYR},}, -- VENTHYR
				{64320, forcedText = {npcID = 180014}, addText = {mount = 1487, Icon = E.ICON_NIGHTFAE},}, -- NIGHT FAE
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
		-- {
		-- sorted = true,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetMapName(1961)..": ".. L["Daily quests"]
		-- end,
		-- name_save = "KORTHIADailyQuest",
		-- defS = false,
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {63793},--Задание брокеров: Энсидий Осквернитель
		-- {63964},--Задание брокеров: Мрачный Коготь
		-- {63794},--Задание брокеров: голодающее чудище
		-- {63790},--Задание брокеров: лорд Аззорак
		-- {63792},--Задание брокеров: Ноктюрнус Развоплотитель
		-- {63963},--Задание брокеров: Железная Лапа
		-- {63791},--Задание брокеров: Валдинар Окаянный
		-- {63789},--Неустанная борьба: Обитель ученых
		-- {63788},--Неустанная борьба: Святилище наставлений
		-- {63787},--Неустанная борьба: Площадка терзателей
		-- {63785},--Неустанная борьба: Форум Искателей
		-- {64103},--Проверенный трюк
		-- {64101},--Соблюдение процедур
		-- {64089},--Чаи и настои
		-- {64430},--Пролитый чай
		-- {64065},--Местные реагенты
		-- {63989},--Скользим со стилем
		-- {64016},--Скользим со стилем
		-- {64017},--Скользим со стилем
		-- {63936},--Поглощенная анима
		-- {63784},--Золото не вопрос
		-- },
		-- forcedMaxQuest = 4,
		-- },
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": ".. E.func_GetQuestName(63777, false)
			end,
			name_save = "SealedSecrets",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{63777},
				{63954},
				{63955},
				{63956},
				{63961},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": ".. L["Purple Mobs"]
			end,
			name_save = "KORTHIAPurpleMobs",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{64341, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 1"},},
				{64342, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 2"},},
				{64343, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 3"},},
				{64344, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 4"},},
				{64747, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 5"},},
				{64748, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 6"},},
				{64749, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 7"},},
				{64750, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 8"},},
				{64751, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 9"},},
				{64752, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 10"},},
				{64753, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 11"},},
				{64754, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 12"},},
				{64755, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 13"},},
				{64756, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 14"},},
				{64757, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Purple Mobs"].." 15"},},
			},
			forcedMaxQuest = 15, -- 3?
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": ".. L["Relic Gorgers"]
			end,
			name_save = "KORTHIARelicGorgers",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{64433, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Relic Gorgers"].." 1"},},
				{64434, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Relic Gorgers"].." 2"},},
				{64435, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Relic Gorgers"].." 3"},},
				{64436, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Relic Gorgers"].." 4"},},
			},
			forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1961)..": ".. AREA_LOOTING_UNLOCKED -- L["Mushrooms"]
			end,
			name_save = "KORTHIACollectionMushrooms",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetMapName(1961)..": ".."Items"
		-- end,
		-- name_save = "KORTHIAitems",
		-- defS = true,
		-- reset = "Once",
		-- desc = categoryKey,
		-- quests = {
		-- {64061, forcedText = {itemID = 186453}}, -- Vault Anima Tracker
		-- {64307, forcedText = {itemID = 187145}}, -- Treatise: Recognizing StygiaanditsUses
		-- {64828, forcedText = {itemID = 187706}}, -- Treatise: Bonds of Stygiain Mortals
		-- {64027, forcedText = {itemID = 186722}}, -- Treatise: The Study of Animaand Harnessing Every Drop
		-- {64366, forcedText = {itemID = 186721}}, -- Treatise: Relics Aboundinthe Shadowlands
		-- -- {64339, forcedText = {itemID = 186714}}, -- 100(2) Research Report: All-Seeing Crystal
		-- -- {64348, forcedText = {itemID = 186716}}, -- 1000(5) Research Report: Ancient Shrines
		-- {64300, forcedText = {itemID = 186717}}, -- 4000(6) Research Report: Adaptive Alloys
		-- {64303, forcedText = {itemID = 187138}}, -- 8000(6) Research Report: First Alloys
		-- {64367, forcedText = {itemID = 187136}}, -- 2500(6) Research Report Relic Examination Techniques
		-- },
		-- -- forcedMaxQuest = 1,
		-- },
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["Covenant Assault"]
			end,
			name_save = "MAWassault",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{63824, addText = {Icon = E.ICON_KYRIAN}},
				{63822, addText = {Icon = E.ICON_VENTHYR}},
				{63823, addText = {Icon = E.ICON_NIGHTFAE}},
				{63543, addText = {Icon = E.ICON_NECROLORD}},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["The Hunt"]
			end,
			name_save = "MAWhunt",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
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
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["Wrath of the Jailer"]
			end,
			name_save = "MAWwrathofthejailer",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{63414, addText = {IconVignette = "VignetteEventElite"}, forcedText = {text = L["Wrath of the Jailer"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["Event: Tormentors of Torghast"].." "..E.Timers.SL_Maw_TormentorsofTorghast()
			end,
			name_save = "MAWtormentor",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{63854, addText = {IconVignette = "Tormentors-Boss",}, forcedText = {text = L["Event: Tormentors of Torghast"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["Helsworn Chest"]
			end,
			name_save = "MAWHelswornChest",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{64256, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Helsworn Chest"]},}, -- Maw chest in Desmotaeron
			},
			forcedMaxQuest = 1,
		},
		{ -- ПОФИКСИТЬ доступно только во время найт фей ассаулта
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": "..L["Stolen Anima Vessel"]..E.RIFT
			end,
			name_save = "MAWStolenAnimaVesselRIFT",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{64265, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
				{64269, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
				{64270, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = L["Stolen Anima Vessel"]},},
			},
			forcedMaxQuest = 3,
		},
		-- {
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetMapName(1543)..": "..L["Daily quests"],--E.func_GetCurrencyName(1880)
		-- end,
		-- name_save = "MAWdailyQuests",
		-- defS = false,
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {60646},
		-- {60762},
		-- {60775},
		-- {61075},
		-- {61079},
		-- {61088},
		-- {61103},
		-- {61104},
		-- {61765},
		-- {62214},
		-- {62234},
		-- },
		-- forcedMaxQuest = 3,
		-- },
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1543)..": ".."Rares"
			end,
			name_save = "MAWRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			sorted = false,
			showTooltip = true,
			TextLeft = OTHER..": Rares",
			name_save = "OtherRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
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
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1670)..": "..DUNGEONS
			end,
			name_save = "DUNGEONS",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{60242},
				{60243},
				{60244},
				{60245},
				{60246},
				{60247},
				{60248},
				{60249},
				{60250},
				{60251},
				{60252},
				{60253},
				{60254},
				{60255},
				{60256},
				{60257},
			},
			forcedMaxQuest = 2,
		},
		------------------------------------------------------------
		------------------------------------------------------------
		------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(62858, false)
			end,
			name_save = "Return Lost Souls",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{62861, addText = {Icon = E.ICON_KYRIAN}},
				{62862, addText = {Icon = E.ICON_KYRIAN}},
				{62863, addText = {Icon = E.ICON_KYRIAN}},
				{nil},
				{62867, addText = {Icon = E.ICON_VENTHYR}},
				{62868, addText = {Icon = E.ICON_VENTHYR}},
				{62869, addText = {Icon = E.ICON_VENTHYR}},
				{nil},
				{62858, addText = {Icon = E.ICON_NIGHTFAE}},
				{62859, addText = {Icon = E.ICON_NIGHTFAE}},
				{62860, addText = {Icon = E.ICON_NIGHTFAE}},
				{nil},
				{62864, addText = {Icon = E.ICON_NECROLORD}},
				{62865, addText = {Icon = E.ICON_NECROLORD}},
				{62866, addText = {Icon = E.ICON_NECROLORD}},
			},
			forcedMaxQuest = 4,
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)