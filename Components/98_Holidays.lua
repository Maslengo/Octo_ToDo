local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = false
if not enable then return end
----------------------------------------------------------------
local categoryKey = 98
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = CALENDAR_FILTER_HOLIDAYS
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 1166, defS = true,}, -- Timewarped Badge (local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon())
		-- {id = 3309, defS = true,}, -- Hellstone Shard
		-- {id = 2588, defS = true,}, -- Riders of Azeroth Badge
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 44791, defS = true,}, -- Event: Noblegarden
		-- {id = 45072, defS = true,}, -- Event: Noblegarden
		-- {id = 23247, defS = true,}, -- Event: Midsummer Fire Festival
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetEventName(141)
			end,
			name_save = "FeastofWinterVeil", -- "Feast of Winter Veil"
			defS = true,
			reset = "Month",
			desc = categoryKey,
			quests = {
				{8744, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{8768, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{8769, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{8803, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{91041, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{91042, addText = {mapID = 85}, FactionOrClass = {Horde = true,}},
				{8744, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
				{8768, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
				{8769, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
				{8803, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
				{91041, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
				{91042, addText = {mapID = 87}, FactionOrClass = {Alliance = true,}},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetEventName(141).. " "..GARRISON_LOCATION_TOOLTIP
			end,
			name_save = "FeastofWinterVeil_DRAENOR", -- "Feast of Winter Veil"
			defS = true,
			reset = "Month",
			desc = categoryKey,
			quests = {
				{39651},
				{39668},
				{39648},
				{39649},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return "Тыквовин" --E.func_GetEventName()
			end,
			name_save = "HallowsEnd_DRAENOR", -- "Hallow's End"
			defS = true,
			reset = "Month",
			desc = categoryKey,
			quests = {
				{39716},
				{39719},
				{39720},
				{39721},
			},
			-- forcedMaxQuest = 1,
		},
		-- E.func_GetEventName(181) (Noblegarden) (Сад чудес)
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(13503, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			name_save = "ATisketaTasketaNoblegardenBasket",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{13503},
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79575, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "WhattheDuck",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79575},
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(13479, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "TheGreatEggHunt",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{13479},
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79576, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "AFowlConcoction",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79576},
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79577, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "DuckTales",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79577},
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79578, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "JustaWaddleAway",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79578, faction = "Horde",}, -- Horde
				{79331, faction = "Alliance"}, -- Alliance
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79558, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "FeatheredFiend",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79558, faction = "Horde",}, -- Horde
				{73192, faction = "Alliance"}, -- Alliance
			},
			-- forcedMaxQuest = 1,
		},
		{
			TextLeft = function()
				return E.func_GetQuestName(79135, false) .. " ("..E.func_GetEventName(181)..")"
			end,
			showTooltip = true,
			name_save = "QuackingDown",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysNoblegarden",
			quests = {
				{79135},
			},
			-- forcedMaxQuest = 1,
		},
		-- E.func_GetEventName(201) (ChildrensWeek) (Детская неделя)
		-- orgrimmar / Stormwind
		{
			TextLeft = function()
				return E.func_GetMapName(85) .."/"..E.func_GetMapName(84).. " ("..E.func_GetEventName(201)..")"
			end,
			showTooltip = true,
			name_save = "orgrimmarStormwind",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysChildrensWeek",
			quests = {
				{172, faction = "Horde",}, -- Horde, -- Horde
				{29146, faction = "Horde",}, -- Horde, -- Horde
				{29176, faction = "Horde",}, -- Horde, -- Horde
				{54146, faction = "Horde",}, -- Horde, -- Horde
				{29190, faction = "Horde",}, -- Horde, -- Horde
				{29191, faction = "Horde",}, -- Horde, -- Horde
				{5502, faction = "Horde",}, -- Horde, -- Horde
				----
				{1468, faction = "Alliance"}, -- Alliance,
				{29093, faction = "Alliance"}, -- Alliance,
				{29106, faction = "Alliance"}, -- Alliance,
				{54130, faction = "Alliance"}, -- Alliance,
				-- {29117, faction = "Alliance"}, -- Alliance, -- ДУБЛЬ
				-- {29119, faction = "Alliance"}, -- Alliance, -- ДУБЛЬ
				{171, faction = "Alliance"}, -- Alliance,
			},
			-- forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			TextLeft = function()
				return "Shattrath" .. " ("..E.func_GetEventName(201)..")"
			end,
			showTooltip = true,
			name_save = "Shattrath", --
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysChildrensWeek",
			quests = {
				{10942, faction = "Horde",}, -- Horde
				{10953, faction = "Horde",}, -- Horde
				{10951, faction = "Horde",}, -- Horde
				{10945, faction = "Horde",}, -- Horde
				{11975, faction = "Horde",}, -- Horde
				{10963, faction = "Horde",}, -- Horde
				{10967, faction = "Horde",}, -- Horde
				----
				{10943, faction = "Alliance"},
				{10950, faction = "Alliance"},
				{10952, faction = "Alliance"},
				{10954, faction = "Alliance"},
				-- {10962, faction = "Alliance"}, -- ДУБЛЬ
				{10956, faction = "Alliance"},
				-- {10966, faction = "Alliance"}, -- ЛИШНЕЕ?
				-- {10968, faction = "Alliance"}, -- ЛИШНЕЕ?
				{10966, faction = "Alliance"},
			},
			-- forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			TextLeft = function()
				return L["Daily quests"] .. " ("..E.func_GetEventName(181)..")" -- ПОФИКСИТЬ
			end,
			showTooltip = true,
			name_save = "orgrimmarStormwindDAILY", --
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysTheSpinnerofSummerTales",
			quests = {
				{82109, faction = "Horde",}, -- Horde
				{11925, faction = "Horde",}, -- Horde
				{82080, faction = "Alliance"},
				{11924, faction = "Alliance"},
			},
			-- forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		{
			TextLeft = function()
				return RAIDS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
			end,
			showTooltip = true,
			name_save = "Raid",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- "HolidaysTimewalk",
			quests = {
				{57637},
				{50316},
				{47523},
				{82817},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = false,
			TextLeft = function()
				return DUNGEONS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
			end,
			showTooltip = true,
			name_save = "Dungeons",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- "HolidaysTimewalk",
			quests = {
				{nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = "Bonus Event Holiday Quests"},},
				{86731, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC (An Original Path Through Time)
				{83363, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC (A Burning Path Through Time)
				{83365, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK (A Frozen Path Through Time)
				{83359, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
				{83362, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA (A Shrouded Path Through Time)
				{83364, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR (A Savage Path Through Time)
				{83360, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION (A Fel Path Through Time)
				{88805, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA (A Scarred Path Through Time)
				{92649, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL (Темный путь сквозь время)
				{nil},
				{nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = L["Weekend Event"]},},
				-- NORMAL TIMEWALK
				{85947, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC
				{85948, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC
				{85949, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK
				{86556, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm
				{86560, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA
				{86563, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR
				{86564, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION
				{88808, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA
				{92647, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL
				-- {86731, addText = {expansionText = E.func_FormatExpansion(1)}}, -- 1 CLASSIC (An Original Path Through Time)
				-- {85947, addText = {expansionText = E.func_FormatExpansion(1)}}, -- 1 CLASSIC
				-- {83363, addText = {expansionText = E.func_FormatExpansion(2)}}, -- 2 TBC (A Burning Path Through Time)
				-- {85948, addText = {expansionText = E.func_FormatExpansion(2)}}, -- 2 TBC
				-- {83365, addText = {expansionText = E.func_FormatExpansion(3)}}, -- 3 WOTLK (A Frozen Path Through Time)
				-- {85949, addText = {expansionText = E.func_FormatExpansion(3)}}, -- 3 WOTLK
				-- {83359, addText = {expansionText = E.func_FormatExpansion(4)}}, -- 4 Cataclysm (A Shattered Path Through Time)
				-- {86556, addText = {expansionText = E.func_FormatExpansion(4)}}, -- 4 Cataclysm
				-- {83362, addText = {expansionText = E.func_FormatExpansion(5)}}, -- 5 PANDA (A Shrouded Path Through Time)
				-- {86560, addText = {expansionText = E.func_FormatExpansion(5)}}, -- 5 PANDA
				-- {83364, addText = {expansionText = E.func_FormatExpansion(6)}}, -- 6 DRAENOR (A Savage Path Through Time)
				-- {86563, addText = {expansionText = E.func_FormatExpansion(6)}}, -- 6 DRAENOR
				-- {83360, addText = {expansionText = E.func_FormatExpansion(7)}}, -- 7 LEGION (A Fel Path Through Time)
				-- {86564, addText = {expansionText = E.func_FormatExpansion(7)}}, -- 7 LEGION
				-- {88805, addText = {expansionText = E.func_FormatExpansion(8)}}, -- 8 BFA (A Scarred Path Through Time)
				-- {88808, addText = {expansionText = E.func_FormatExpansion(8)}}, -- 8 BFA
				-- {92649, addText = {expansionText = E.func_FormatExpansion(9)}}, -- 9 SL (Темный путь сквозь время)
				-- {92647, addText = {expansionText = E.func_FormatExpansion(9)}}, -- 9 SL
				-- {83274}, -- Празднование 20-й годовщины
				-- {72727}, -- Пылающий путь сквозь время (Blizzard пометили это задание как устаревшее — его нельзя получить или выполнить.)
				-- {72726}, -- Замерзший путь сквозь время (Blizzard пометили это задание как устаревшее — его нельзя получить или выполнить.)
				-- {72725}, -- Затуманенный путь сквозь время (Blizzard пометили это задание как устаревшее — его нельзя получить или выполнить.)
				-- {72724}, -- Дикий путь сквозь время (Blizzard пометили это задание как устаревшее — его нельзя получить или выполнить.)
				-- {72719}, -- Путь Скверны сквозь время (Blizzard пометили это задание как устаревшее — его нельзя получить или выполнить.)
				-- {40792}, -- Разрушенный путь сквозь время
				-- {39021}, -- Замерзший путь сквозь время
				-- {39020}, -- Пылающий путь сквозь время
			},
			forcedMaxQuest = 2,
		},
		{
			TextLeft = function()
				return "Profession Monthlies" .. " ("..E.func_GetEventName(479)..")"
			end,
			showTooltip = true,
			name_save = "ProfessionMonthlies",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysDarkmoonFaire",
			quests = {
				{29506},
				{29507},
				{29508},
				{29509},
				{29510},
				{29511},
				{29513},
				{29514},
				{29515},
				{29516},
				{29517},
				{29518},
				{29519},
				{29520},
			},
			-- forcedMaxQuest = 14,
		},
		{
			TextLeft = function()
				return "Monthly Quests" .. " ("..E.func_GetEventName(479)..")"
			end,
			showTooltip = true,
			name_save = "MonthlyQuests",
			defS = true,
			reset = "Month",
			desc = categoryKey, -- "HolidaysDarkmoonFaire",
			quests = {
				{33354},
				{29443},
			},
			-- forcedMaxQuest = 2,
		},
		{
			TextLeft = function()
				return "Acount-wide Dailies" .. " ("..E.func_GetEventName(479)..")"
			end,
			showTooltip = true,
			name_save = "AcountwideDailies",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysDarkmoonFaire",
			quests = {
				{32175},
				{36471},
			},
			-- forcedMaxQuest = 2,
		},
		{
			TextLeft = function()
				return "item turns ins" .. " ("..E.func_GetEventName(479)..")"
			end,
			showTooltip = true,
			name_save = "itemturnsins",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysDarkmoonFaire",
			quests = {
				{29458},
				{29456},
				{29457},
				{29443},
				{29444},
				{29445},
				{29446},
				{29464},
				{29451},
			},
			-- forcedMaxQuest = 9,
		},
		{
			TextLeft = function()
				return E.func_GetItemName(93724) .. " ("..E.func_GetEventName(479)..")"
			end,
			showTooltip = true,
			name_save = "DarkmoonFaire",
			defS = true,
			reset = "Daily",
			desc = categoryKey, -- "HolidaysDarkmoonFaire",
			quests = {
				{37911},
				{29438},
				{36481},
				{29463},
				{29436},
				{29434},
				{37910},
				{29455},
				{64783},
			},
			-- forcedMaxQuest = 9,
		},
		{
			TextLeft = function()
				return E.func_GetItemName(92441) .. " (Warlock)"
			end,
			showTooltip = true,
			name_save = "GreenFire",
			defS = true,
			reset = "Regular",
			desc = categoryKey, -- "Warlock",
			quests = {
				{32295},
				{32307},
				{32309},
				{32310},
				{32317},
				{32324},
				{32325},
			},
			-- forcedMaxQuest = 7,
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
-- local function localfunc2()
-- local OctoTable_Otrisovka_TextCenter = {}
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- if Octo_ToDo_DB_Vars.Holidays then
-- if E.ActiveHoliday[181] then
-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysNoblegarden")
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- ----------------------------------------------------------------
-- if CharInfo.MASLENGO.ItemsInBag[44791] then
-- TextCenter = CharInfo.MASLENGO.ItemsInBag[44791]
-- end
-- ----------------------------------------------------------------
-- TextLeft = E.func_GetItemName(44791)
-- ColorLeft = E.COLOR_HOLIDAY
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- ----------------------------------------------------------------
-- if CharInfo.MASLENGO.ItemsInBag[45072] then
-- TextCenter = CharInfo.MASLENGO.ItemsInBag[45072]
-- end
-- ----------------------------------------------------------------
-- TextLeft = E.func_GetItemName(45072)
-- ColorLeft = E.COLOR_HOLIDAY
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- 1583 EU classic
-- 1508 US classic
-- 1458 Бурные потоки
-- local TimewalkHolidayTBL = {1705, 1583, 1265, 1063, 652, 622, 1508, 1667}
-- for _, HolidayID in ipairs(TimewalkHolidayTBL) do
-- if E.ActiveHoliday[HolidayID] then
-- local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon()
-- if joinable then
-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysTimewalk", E.COLOR_EVENT)
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- TooltipKey = "Timewalk_Mounts"
-- ----------------------------------------------------------------
-- TextCenter = E.func_TextCenter_Currency(CharInfo, 1166)
-- ----------------------------------------------------------------
-- TextLeft = E.func_GetCurrencyName(1166)..timewalkDungeonName
-- ColorLeft = E.COLOR_EVENT
-- SettingsType = "Currencies#"..1166
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- end
-- end
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- -- if E.ActiveHoliday[201] then
-- -- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysChildrensWeek")
-- -- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- if E.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysTheSpinnerofSummerTales")
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- ----------------------------------------------------------------
-- if CharInfo.MASLENGO.LFGInstance[286] then
-- TextCenter = "CharInfo.MASLENGO.LFGInstance[286]"
-- end
-- ----------------------------------------------------------------
-- TextLeft = E.func_texturefromIcon(E.func_GetItemIcon(23247))..E.func_texturefromIcon(E.ICON_LFG) .. E.func_GetLFGDungeonName(286)
-- ColorLeft = E.COLOR_HOLIDAY
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- ----------------------------------------------------------------
-- if CharInfo.MASLENGO.ItemsInBag[23247] then
-- TextCenter = CharInfo.MASLENGO.ItemsInBag[23247]
-- end
-- ----------------------------------------------------------------
-- TextLeft = E.func_GetItemName(23247)
-- ColorLeft = E.COLOR_HOLIDAY
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- if E.ActiveHoliday[1691] then -- Алчный посланец
-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysAGreedyEmissary", E.COLOR_RED)
-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- ----------------------------------------------------------------
-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, nil, nil
-- ----------------------------------------------------------------
-- TextCenter = E.func_TextCenter_Currency(CharInfo, 3309)
-- ----------------------------------------------------------------
-- TextLeft = E.func_GetCurrencyName(3309)
-- ColorLeft = E.COLOR_RED
-- SettingsType = "Currencies#"..3309
-- ----------------------------------------------------------------
-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, FirstReputation, SecondReputation
-- ----------------------------------------------------------------
-- end)
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- if E.ActiveHoliday[479] then -- Ярмарка новолунья
-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysDarkmoonFaire", E.COLOR_PURPLE)
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- end
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- return OctoTable_Otrisovka_TextCenter
-- end