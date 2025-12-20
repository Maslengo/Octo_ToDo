local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Legion_available = E.func_Is_Legion_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Legion_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local categoryKey = 7
local expansionID = 7
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
		{id = 1508, defS = false,},
		{id = 1342, defS = false,},
		{id = 1220, defS = true,},
		{id = 1226, defS = false,},
		{id = 1533, defS = false,},
		{id = 1155, defS = false,},
		{id = 1149, defS = false,},
		{id = 1416, defS = false,},
		{id = 1273, defS = false,},
		{id = 3292, defS = true,}, -- REMIX
		{id = 3268, defS = true,}, -- REMIX
		{id = 3252, defS = true,}, -- REMIX
		-- {id = 3293, defS = false,}, -- REMIX PANDA?
		-- {id = 3251, defS = false,}, -- REMIX PANDA?
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 124124, defS = false,}, -- Blood of Sargeras
		{id = 254267, defS = true,}, -- REMIX
		{id = 253224, defS = false,}, -- REMIX
		-- {id = 217956, defS = false,},
		-- {id = 217731, defS = false,},
		-- {id = 217929, defS = false,},
		-- {id = 217730, defS = false,},
		-- {id = 217928, defS = false,},
		-- {id = 217608, defS = false,},
		-- {id = 217605, defS = false,},
		-- {id = 217607, defS = false,},
		-- {id = 217606, defS = false,},
		-- {id = 217901, defS = false,},
		-- {id = 238727, defS = false,},
		-- {id = 141295, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			-- {id = 959, defS = true,}, -- Invasion Points
			{id = 946, defS = true,}, -- Antorus, the Burning Throne
			{id = 875, defS = true,}, -- Tomb of Sargeras
			{id = 786, defS = true,}, -- The Nighthold
			{id = 861, defS = true,}, -- Trial of Valor
			{id = 768, defS = true,}, -- The Emerald Nightmare
			-- {id = 822, defS = true,}, -- Broken Isles
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 1900, defS = true,}, --name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
		{id = 1883, defS = true,}, --name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
		{id = 1828, defS = true,}, --name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
		{id = 1948, defS = true,}, --name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]
		{id = 1859, defS = true,}, --name = "Помраченные", side = "-", category = "Legion", }, --[faction=1859]
		{id = 1894, defS = true,}, --name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
		{id = 2045, defS = true,}, --name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]
		{id = 2170, defS = true,}, --name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
		{id = 2165, defS = true,}, --name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
		----------------------------------------------------------------
		{id = 2018, defS = false,}, --name = "Отмщение Когтя", side = "-", category = "Legion", }, --[faction=2018]
		----------------------------------------------------------------
		{id = 2097, defS = false,}, --name = "Илиссия Водная", side = "-", category = "Legion", }, --[faction=2097]
		{id = 2099, defS = false,}, --name = "Акуле Речной Рог", side = "-", category = "Legion", }, --[faction=2099]
		{id = 2101, defS = false,}, --name = "Ша'лет", side = "-", category = "Legion", }, --[faction=2101]
		{id = 2100, defS = false,}, --name = "Корбин", side = "-", category = "Legion", }, --[faction=2100]
		{id = 2102, defS = false,}, --name = "Бесс", side = "-", category = "Legion", }, --[faction=2102]
		{id = 2098, defS = false,}, --name = "Хранительница Рейна", side = "-", category = "Legion", }, --[faction=2098]
		----------------------------------------------------------------
		{id = 1919, defS = false,}, --name = "Жажда магии Вальтруа", side = "-", category = "Помраченные", }, --[faction=1919]
		{id = 1862, defS = false,}, --name = "Жажда магии Окулета", side = "-", category = "Помраченные", }, --[faction=1862]
		{id = 1860, defS = false,}, --name = "Жажда магии Талисры", side = "-", category = "Помраченные", }, --[faction=1860]
		----------------------------------------------------------------
		{id = 2135, defS = false,}, --name = "Хроми", side = "-", category = "Legion", }, --[faction=2135]
		----------------------------------------------------------------
		{id = 1975, defS = false,}, --name = "Кудесник Маргосс", side = "-", category = "Legion", }, --[faction=1975]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = "bounty_Legion_TEST",
		-- defS = true,
		-- name_save = "bounty_Legion_TEST",
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {43179},
		-- {42422},
		-- {48639},
		-- },
		-- -- forcedMaxQuest = 1,
		-- },
		{
			sorted = false,
			showTooltip = true,
			TextLeft = L["World Boss"],
			defS = true,
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{43193, forcedText = {npcID = 109331}, addText = {mapID = 630},}, -- Каламир 109331 Азсуна (4).
				{43192, forcedText = {npcID = 108829}, addText = {mapID = 630},}, -- Левантия 108829 Азсуна (2).
				{44287, forcedText = {npcID = 102075}, addText = {mapID = 630},}, -- Иссохший Дж'им 102075 Азсуна (4).
				{nil},
				{42819, forcedText = {npcID = 108879}, addText = {mapID = 641},}, -- Хумонгрис <Чародей> 108879 Валь'шара (5).
				{42779, forcedText = {npcID = 108678}, addText = {mapID = 641},}, -- Шар'тос 108678 Валь'шара (6).
				{nil},
				{43448, forcedText = {npcID = 110378}, addText = {mapID = 650},}, -- Драгон Зиморожденный 110378 Крутогорье (4).
				{43985, forcedText = {npcID = 99929}, addText = {mapID = 650},}, -- Обломок 99929 Крутогорье (2).
				{nil},
				{42270, forcedText = {npcID = 107023}, addText = {mapID = 634},}, -- Нитхегг 107023 Штормхейм (3).
				{42269, addText = {mapID = 634},}, -- Капитан Хринг 106981, Пленительница душ Мевра 106984, Разоритель Йдорн 106982, Штормхейм (5).
				{nil},
				{43512, forcedText = {npcID = 109943}, addText = {mapID = 680},}, -- Ана-Муз 109943 Сурамар .
				{43513, forcedText = {npcID = 110321}, addText = {mapID = 680},}, -- На'зак Одержимый 110321 Сурамар (10).
				{nil},
				{47061, forcedText = {npcID = 121124}, addText = {mapID = 646},}, -- Апокрон 121124 Расколотый берег (4).
				{46947, forcedText = {npcID = 117239}, addText = {mapID = 646},}, -- Бруталл 117239 Расколотый берег (6).
				{46948, forcedText = {npcID = 117303}, addText = {mapID = 646},}, -- Малификус 117303 Расколотый берег (6).
				{46945, forcedText = {npcID = 117470}, addText = {mapID = 646},}, -- Си'ваш 117470 Расколотый берег (6).
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(43533, false)
			end,
			defS = false,
			name_save = "BalanceofPower",
			reset = "Once",
			desc = categoryKey,
			MainquestID = 43533,
			quests = {
				{43496},
				{43503},
				{43501},
				{43505},
				{40668},
				{43514},
				{43517},
				{43518},
				{43519},
				{43581},
				{43520},
				{43521},
				{43522},
				{43938},
				{43527},
				{43937},
				{43523},
				{40673},
				{43524},
				{40675},
				{43525},
				{40678},
				{43526},
				{40603},
				{40608},
				{40613},
				{40614},
				{40672},
				{40615},
				{43898},
				{43528},
				{43530},
				{43531},
				{43532},
				{43533},
			},
			forcedMaxQuest = 33,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.Legion_Invasion()
			end,
			defS = true,
			name_save = "InvasionQuests",
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{45838},
				{45812},
				{45840},
				{45839}, -- Атака на Штормхейм (ПОМЕНЯЛИ?)
			},
			forcedMaxQuest = 1,
		},
		-- {
		-- showTooltip = true,
			-- TextLeft = function()
			-- 	return E.func_GetQuestName(92855, false)
			-- end,
		-- defS = true,
		-- name_save = "MakeHasteNotWaste",
		-- reset = "Daily",
		-- desc = categoryKey,
		-- quests = {
		-- {92855},
		-- },
		-- forcedMaxQuest = 1,
		-- },
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
		{id = "LegionRemixResearch", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
-- 1642 US REMIX
-- 1643 EU REMIX (ru)