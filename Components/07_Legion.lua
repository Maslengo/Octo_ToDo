local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
if not E.Is_Legion_available then return end
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 7
local expansionID = 7
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_Vibor = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].defs = false
	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
	OctoTables_Vibor[categoryKey].color = E.OctoTable_Expansions[expansionID] and E.OctoTable_Expansions[expansionID].color or E.COLOR_BLACK
	----------------------------------------------------------------
	local Currencies = {
		{id = 1508, defS = true,},
		{id = 1342, defS = true,},
		{id = 1220, defS = true,},
		{id = 1226, defS = true,},
		{id = 1533, defS = false,},
		{id = 1155, defS = true,},
		{id = 1149, defS = false,},
		{id = 1416, defS = false,},
		{id = 1273, defS = false,},
		-- {id = 3292, defS = false,}, -- REMIX LEGION
		-- {id = 3268, defS = false,}, -- REMIX LEGION
		{id = 3252, defS = false, AddedInPatch = "11.2.5.62554", RemovedInPatch = "12.0.0",}, -- Bronze (remix) LEGION
	}
	----------------------------------------------------------------
	local Items = {
		{id = 124124, defS = false,}, -- Blood of Sargeras
		-- {id = 254267, defS = false,}, -- REMIX LEGION
		-- {id = 253224, defS = false,}, -- REMIX LEGION
	}
	----------------------------------------------------------------
	local RaidsOrDungeons = {
		-- Raid
		{id = 1712, defS = true,}, -- Antorus, the Burning Throne
		{id = 1676, defS = true,}, -- Tomb of Sargeras
		{id = 1530, defS = true,}, -- The Nighthold
		{id = 1648, defS = true,}, -- Trial of Valor
		{id = 1520, defS = true,}, -- The Emerald Nightmare
		-- Dungeon
		-- {id = 1677, defS = true,}, -- Cathedral of Eternal Night
		-- {id = 1501, defS = true,}, -- Black Rook Hold
		-- {id = 1753, defS = true,}, -- Seat of the Triumvirate
		-- {id = 1651, defS = true,}, -- Return to Karazhan
		-- {id = 1516, defS = true,}, -- The Arcway
		-- {id = 1544, defS = true,}, -- Assault on Violet Hold
		-- {id = 1458, defS = true,}, -- Neltharion's Lair
		-- {id = 1477, defS = true,}, -- Halls of Valor
		-- {id = 1571, defS = true,}, -- Court of Stars
		-- {id = 1492, defS = true,}, -- Maw of Souls
		-- {id = 1466, defS = true,}, -- Darkheart Thicket
		-- {id = 1493, defS = true,}, -- Vault of the Wardens
		-- {id = 1456, defS = true,}, -- Eye of Azshara
	}
	----------------------------------------------------------------
	local Reputations = {
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
	local UniversalQuests = {
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["RAID_INFO_WORLD_BOSS"]
			end,
			defS = true,
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = categoryKey,
			questpools = {
				{
					{
						43193, -- Каламир 109331 Азсуна (4).
						forcedText = {npcID = 109331},
						addText = {mapID = E.MapID_Azsuna},
					},
					{
						43192, -- Левантия 108829 Азсуна (2).
						forcedText = {npcID = 108829},
						addText = {mapID = E.MapID_Azsuna},
					},
					{
						44287, -- Иссохший Дж'им 102075 Азсуна (4).
						forcedText = {npcID = 102075},
						addText = {mapID = E.MapID_Azsuna},
					},
					{
						42819, -- Хумонгрис <Чародей> 108879 Валь'шара (5).
						forcedText = {npcID = 108879},
						addText = {mapID = E.MapID_Valsharah},
					},
					{
						42779, -- Шар'тос 108678 Валь'шара (6).
						forcedText = {npcID = 108678},
						addText = {mapID = E.MapID_Valsharah},
					},
					{
						43448, -- Драгон Зиморожденный 110378 Крутогорье (4).
						forcedText = {npcID = 110378},
						addText = {mapID = E.MapID_Highmountain},
					},
					{
						43985, -- Обломок 99929 Крутогорье (2).
						forcedText = {npcID = 99929},
						addText = {mapID = E.MapID_Highmountain},
					},
					{
						42270, -- Нитхегг 107023 Штормхейм (3).
						forcedText = {npcID = 107023},
						addText = {mapID = E.MapID_Stormheim},
					},
					{
						42269, -- Капитан Хринг 106981, Пленительница душ Мевра 106984, Разоритель Йдорн 106982, Штормхейм (5).
						addText = {mapID = E.MapID_Stormheim},
					},
					{
						43512, -- Ана-Муз 109943 Сурамар .
						forcedText = {npcID = 109943},
						addText = {mapID = E.MapID_Suramar},
					},
					{
						43513, -- На'зак Одержимый 110321 Сурамар (10).
						forcedText = {npcID = 110321},
						addText = {mapID = E.MapID_Suramar},
					},
				},
				{
					{
						47061, -- Апокрон 121124 Расколотый берег (4).
						forcedText = {npcID = 121124},
						addText = {mapID = E.MapID_BrokenShore},
					},
					{
						46947, -- Бруталл 117239 Расколотый берег (6).
						forcedText = {npcID = 117239},
						addText = {mapID = E.MapID_BrokenShore},
					},
					{
						46948, -- Малификус 117303 Расколотый берег (6).
						forcedText = {npcID = 117303},
						addText = {mapID = E.MapID_BrokenShore},
					},
					{
						46945, -- Си'ваш 117470 Расколотый берег (6).
						forcedText = {npcID = 117470},
						addText = {mapID = E.MapID_BrokenShore},
					},
				},
			},
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 43341)
			end,
			defS = true,
			name_save = "UnlocksaccesstoWorldQuestsintheBrokenIsles",
			reset = "Normal",
			desc = categoryKey,
			quests = {
				-- E.func_FormatExpansion(
				{51918, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Alliance = true,}}, -- spell=273746/ Открывает доступ к локальным заданиям в Кул-Тирасе и Зандаларе. (АЛЬЯНС)
				{51916, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Horde = true,}}, -- spell=273743/ Открывает доступ к локальным заданиям в Зандаларе и Кул-Тирасе. (ОРДА)

				{52450, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Alliance = true,}},
				{52451, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Horde = true,}},

				{56156, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Alliance = true,}}, -- spell=304905/ Открывает доступ к локальным заданиям в Назжатаре (АЛЬЯНС)
				{55500, addText_CENT = {text = E.func_FormatExpansion(8, "LEFT")}, FactionOrClass = {Horde = true,}}, -- spell=304906/ Открывает доступ к локальным заданиям в Назжатаре (ОРДА)

				{43341, addText_CENT = {text = E.func_FormatExpansion(7, "LEFT")}}, -- spell=227303/ Открывает доступ к локальным заданиям на Расколотых островах
				{45727, addText_CENT = {text = E.func_FormatExpansion(7, "LEFT")}},

				{59609, addText_CENT = {text = E.func_FormatExpansion(9, "LEFT")}}, -- spell=338946/ Открывает доступ к локальным заданиям Темных Земель
				-- spell=344241/ Открывает доступ к локальным заданиям Темных Земель
			},
			-- forcedMaxQuest = 1,
		},
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
			TextLeft = function()
				return E.func_GetName("quest", 43533, false)
			end,
			defS = false,
			name_save = "BalanceofPower",
			reset = "Normal",
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
			forcedIDQuest = 43533,
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
		-- return E.func_GetName("quest", 92855, false) -- REMIX
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
	-- local AdditionallyTOP = {
	-- }
	----------------------------------------------------------------
	local AdditionallyCENTER = {
		{id = "BountiesLegion", defS = true,},
	}
	----------------------------------------------------------------
	-- local AdditionallyBOTTOM = {
	-- }
	----------------------------------------------------------------
	local OctoTables_DataOtrisovka = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = E.FilterByVersion(AdditionallyTOP)
	OctoTables_DataOtrisovka[categoryKey].Currencies = E.FilterByVersion(Currencies)
	OctoTables_DataOtrisovka[categoryKey].Items = E.FilterByVersion(Items)
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = E.FilterByVersion(RaidsOrDungeons)
	OctoTables_DataOtrisovka[categoryKey].AdditionallyCENTER = E.FilterByVersion(AdditionallyCENTER)
	-- OctoTables_DataOtrisovka[categoryKey].Quests = E.FilterByVersion(Quests)
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = E.FilterByVersion(UniversalQuests, true)
	OctoTables_DataOtrisovka[categoryKey].Reputations = E.FilterByVersion(Reputations)
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = E.FilterByVersion(AdditionallyBOTTOM)
	-- OctoTables_DataOtrisovka[categoryKey].Maps = E.FilterByVersion(Maps)
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
-- 1642 US REMIX
-- 1643 EU REMIX (ru)