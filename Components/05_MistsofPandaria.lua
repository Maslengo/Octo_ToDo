local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_MistsofPandaria_available = E.func_Is_MistsofPandaria_available()
----------------------------------------------------------------
if not enable then return end
if not Is_MistsofPandaria_available then return end;
----------------------------------------------------------------
local L = E.L
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
		{id = 2778, defS = false,}, -- Bronze (remix) -- https://www.wowhead.com/currency=2778/bronze#items;0-19+20
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 101529, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			{id = 369, defS = true,}, -- Siege of Orgrimmar
			{id = 362, defS = true,}, -- Throne of Thunder
			{id = 320, defS = true,}, -- Terrace of Endless Spring
			{id = 330, defS = true,}, -- Heart of Fear
			{id = 317, defS = true,}, -- Mogu'shan Vaults
			-- {id = 322, defS = true,}, -- Pandaria
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
		----------------------------------------------------------------
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
		{id = 1358, defS = false,}, --name = "Нат Пэгл", side = "-", category = "Рыболовы", }, --[faction=1358]
		----------------------------------------------------------------
		{id = 1357, defS = false,}, --name = "Номи", side = "-", category = "Другое", }, --[faction=1357]
		-- {id = 1216, defS = false,}, -- Shang Xi's Academy
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			showTooltip = true,
			TextLeft = function()
				return RAID_INFO_WORLD_BOSS -- L["World Boss"]
			end,
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




		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(504)..": "..E.func_GetQuestName(32641, false)
			end,
			name_save = "ChampionsoftheThunderKing",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{32641, FactionOrClass = {Horde = true,}},
				{32640, FactionOrClass = {Alliance = true,}},
			},
			-- forcedMaxQuest = 1,
		},



		-- { -- no longer weekly
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(390)..": "..E.func_GetQuestName(32641, false)
		-- 	end,
		-- 	name_save = "WarforgedSeals",
		-- 	defS = true,
		-- 	reset = "Weekly",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		{33133, FactionOrClass = {Horde = true,}},
		-- 		{33134, FactionOrClass = {Alliance = true,}},
		-- 	},
		-- 	-- forcedMaxQuest = 1,
		-- },



		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(554)..": "..E.func_GetQuestName(33338, false)
			end,
			name_save = "EmpoweringtheHourglass",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{33338},
			},
			-- forcedMaxQuest = 1,
		},





		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(554)..": "..E.func_GetQuestName(33334, false)
			end,
			name_save = "StrongEnoughToSurvive",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{33334},
			},
			-- forcedMaxQuest = 1,
		},





	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)