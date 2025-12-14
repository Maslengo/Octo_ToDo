local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 98
-- local expansionID =


local function func_TIMEDUNGNAMEPLUSICON()
	local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon()
	if joinable then
		return timewalkDungeonName
	end
	return ""
end


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
		-- {id = 3309, defS = false,}, -- Hellstone Shard
		-- {id = 2588, defS = false,}, -- Riders of Azeroth Badge
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		-- {id = 44791, defS = false,}, -- Event: Noblegarden
		-- {id = 45072, defS = false,}, -- Event: Noblegarden
		-- {id = 23247, defS = false,}, -- Event: Midsummer Fire Festival
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		-- E.func_GetEventName(181) (Noblegarden) (Сад чудес)
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(13503, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	name_save = "ATisketaTasketaNoblegardenBasket",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{13503},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79575, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "WhattheDuck",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79575},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(13479, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "TheGreatEggHunt",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{13479},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79576, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "AFowlConcoction",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79576},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79577, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "DuckTales",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79577},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79578, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "JustaWaddleAway",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79578, faction = "Horde",}, -- Horde
		-- 		{79331, faction = "Alliance"}, -- Alliance
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79558, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "FeatheredFiend",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79558, faction = "Horde",}, -- Horde
		-- 		{73192, faction = "Alliance"}, -- Alliance
		-- 	},
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetQuestName(79135, false) .. " ("..E.func_GetEventName(181)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "QuackingDown",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79135},
		-- 	},
		-- },
		-- -- E.func_GetEventName(201) (ChildrensWeek) (Детская неделя)
		-- -- orgrimmar / Stormwind
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(85) .."/"..E.func_GetMapName(84).. " ("..E.func_GetEventName(201)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "orgrimmarStormwind",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysChildrensWeek",
		-- 	quests = {
		-- 		{172, faction = "Horde",}, -- Horde, -- Horde
		-- 		{29146, faction = "Horde",}, -- Horde, -- Horde
		-- 		{29176, faction = "Horde",}, -- Horde, -- Horde
		-- 		{54146, faction = "Horde",}, -- Horde, -- Horde
		-- 		{29190, faction = "Horde",}, -- Horde, -- Horde
		-- 		{29191, faction = "Horde",}, -- Horde, -- Horde
		-- 		{5502, faction = "Horde",}, -- Horde, -- Horde
		-- 		----
		-- 		{1468, faction = "Alliance"}, -- Alliance,
		-- 		{29093, faction = "Alliance"}, -- Alliance,
		-- 		{29106, faction = "Alliance"}, -- Alliance,
		-- 		{54130, faction = "Alliance"}, -- Alliance,
		-- 		-- {29117, faction = "Alliance"}, -- Alliance, -- ДУБЛЬ
		-- 		-- {29119, faction = "Alliance"}, -- Alliance, -- ДУБЛЬ
		-- 		{171, faction = "Alliance"}, -- Alliance,
		-- 	},
		-- },
		-- ----------------------------------------------------------------
		-- {
		-- 	TextLeft = function()
		-- 		return "Shattrath" .. " ("..E.func_GetEventName(201)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "Shattrath", --
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysChildrensWeek",
		-- 	quests = {
		-- 		{10942, faction = "Horde",}, -- Horde
		-- 		{10953, faction = "Horde",}, -- Horde
		-- 		{10951, faction = "Horde",}, -- Horde
		-- 		{10945, faction = "Horde",}, -- Horde
		-- 		{11975, faction = "Horde",}, -- Horde
		-- 		{10963, faction = "Horde",}, -- Horde
		-- 		{10967, faction = "Horde",}, -- Horde
		-- 		----
		-- 		{10943, faction = "Alliance"},
		-- 		{10950, faction = "Alliance"},
		-- 		{10952, faction = "Alliance"},
		-- 		{10954, faction = "Alliance"},
		-- 		-- {10962, faction = "Alliance"}, -- ДУБЛЬ
		-- 		{10956, faction = "Alliance"},
		-- 		-- {10966, faction = "Alliance"}, -- ЛИШНЕЕ?
		-- 		-- {10968, faction = "Alliance"}, -- ЛИШНЕЕ?
		-- 		{10966, faction = "Alliance"},
		-- 	},
		-- },
		-- ----------------------------------------------------------------
		-- {
		-- 	TextLeft = function()
		-- 		return L["Daily quests"] .. " ("..E.func_GetEventName(181)..")" -- ПОФИКСИТЬ
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "orgrimmarStormwindDAILY", --
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysTheSpinnerofSummerTales",
		-- 	quests = {
		-- 		{82109, faction = "Horde",}, -- Horde
		-- 		{11925, faction = "Horde",}, -- Horde
		-- 		{82080, faction = "Alliance"},
		-- 		{11924, faction = "Alliance"},
		-- 	},
		-- 	forcedMaxQuest = 2,
		-- },
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		{
			TextLeft = function()
				return RAIDS..func_TIMEDUNGNAMEPLUSICON() --.. " ("..E.func_GetEventName(1583)..")",
			end,
			showTooltip = true,
			name_save = "Raid",
			defS = false,
			reset = "Weekly",
			desc = categoryKey, -- "HolidaysTimewalk",
			quests = {
				{57637},
				{50316},
				{47523},
				{82817},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			TextLeft = function()
				return DUNGEONS..func_TIMEDUNGNAMEPLUSICON() --.. " ("..E.func_GetEventName(1583)..")",
			end,
			showTooltip = true,
			name_save = "Dungeons",
			defS = true,
			reset = "Weekly",
			desc = categoryKey, -- "HolidaysTimewalk",
			quests = {
				{88808},
				{86564},
				{86563},
				{86560},
				{86556},
				{85949},
				{85948},
				{85947},
				{83274},
				{83365},
				{83363},
				{92647}, -- SL
				-- {72727},
				-- {72726},
				-- {72725},
				-- {72724},
				-- {72719},
				-- {40792},
				-- {39021},
				-- {39020},
			},
			forcedMaxQuest = 1,
		},
		-- {
		-- 	TextLeft = function()
		-- 		return "Profession Monthlies" .. " ("..E.func_GetEventName(479)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "ProfessionMonthlies",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{29506},
		-- 		{29507},
		-- 		{29508},
		-- 		{29509},
		-- 		{29510},
		-- 		{29511},
		-- 		{29513},
		-- 		{29514},
		-- 		{29515},
		-- 		{29516},
		-- 		{29517},
		-- 		{29518},
		-- 		{29519},
		-- 		{29520},
		-- 	},
		-- 	forcedMaxQuest = 14,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return "Monthly Quests" .. " ("..E.func_GetEventName(479)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "MonthlyQuests",
		-- 	defS = false,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{33354},
		-- 		{29443},
		-- 	},
		-- 	forcedMaxQuest = 2,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return "Acount-wide Dailies" .. " ("..E.func_GetEventName(479)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "AcountwideDailies",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{32175},
		-- 		{36471},
		-- 	},
		-- 	forcedMaxQuest = 2,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return "item turns ins" .. " ("..E.func_GetEventName(479)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "itemturnsins",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{29458},
		-- 		{29456},
		-- 		{29457},
		-- 		{29443},
		-- 		{29444},
		-- 		{29445},
		-- 		{29446},
		-- 		{29464},
		-- 		{29451},
		-- 	},
		-- 	forcedMaxQuest = 9,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetItemName(93724) .. " ("..E.func_GetEventName(479)..")"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "DarkmoonFaire",
		-- 	defS = false,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{37911},
		-- 		{29438},
		-- 		{36481},
		-- 		{29463},
		-- 		{29436},
		-- 		{29434},
		-- 		{37910},
		-- 		{29455},
		-- 		{64783},
		-- 	},
		-- 	forcedMaxQuest = 9,
		-- },
		-- {
		-- 	TextLeft = function()
		-- 		return E.func_GetItemName(92441) .. " (Warlock)"
		-- 	end,
		-- 	showTooltip = true,
		-- 	name_save = "GreenFire",
		-- 	defS = false,
		-- 	reset = "Once",
		-- 	desc = categoryKey, -- "Warlock",
		-- 	quests = {
		-- 		{32295},
		-- 		{32307},
		-- 		{32309},
		-- 		{32310},
		-- 		{32317},
		-- 		{32324},
		-- 		{32325},
		-- 	},
		-- 	forcedMaxQuest = 7,
		-- },
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {

	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end

table.insert(E.Components, tempFunction)
local function localfunc2()
	-- local OctoTable_Otrisovka_TextCenter = {}
	-- ----------------------------------------------------------------
	-- ----------------------------------------------------------------
	-- ----------------------------------------------------------------
	-- if Octo_ToDo_DB_Vars.Holidays then
	-- if E.ActiveHoliday[181] then
	-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysNoblegarden")
	-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
	-- ----------------------------------------------------------------
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- ----------------------------------------------------------------
	-- if CharInfo.MASLENGO.ItemsInBag[44791] then
	-- TextCenter = CharInfo.MASLENGO.ItemsInBag[44791]
	-- end
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_GetItemName(44791)
	-- ColorLeft = E.COLOR_HOLIDAY
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
	-- ----------------------------------------------------------------
	-- end)
	-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
	-- ----------------------------------------------------------------
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- ----------------------------------------------------------------
	-- if CharInfo.MASLENGO.ItemsInBag[45072] then
	-- TextCenter = CharInfo.MASLENGO.ItemsInBag[45072]
	-- end
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_GetItemName(45072)
	-- ColorLeft = E.COLOR_HOLIDAY
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
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
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- TooltipKey = "Timewalk_Mounts"
	-- ----------------------------------------------------------------
	-- TextCenter = E.func_TextCenter_Currency(CharInfo, 1166)
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_GetCurrencyName(1166)..timewalkDungeonName
	-- ColorLeft = E.COLOR_EVENT
	-- SettingsType = "Currencies#"..1166
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
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
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- ----------------------------------------------------------------
	-- if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday then
	-- TextCenter = CharInfo.MASLENGO.LFGInstance[286].donetoday
	-- end
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_texturefromIcon(E.func_GetItemIcon(23247))..E.func_texturefromIcon(E.ICON_LFG) .. E.func_GetLFGDungeonName(286)
	-- ColorLeft = E.COLOR_HOLIDAY
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
	-- ----------------------------------------------------------------
	-- end)
	-- table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
	-- ----------------------------------------------------------------
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- ----------------------------------------------------------------
	-- if CharInfo.MASLENGO.ItemsInBag[23247] then
	-- TextCenter = CharInfo.MASLENGO.ItemsInBag[23247]
	-- end
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_GetItemName(23247)
	-- ColorLeft = E.COLOR_HOLIDAY
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
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
	-- local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
	-- ----------------------------------------------------------------
	-- TextCenter = E.func_TextCenter_Currency(CharInfo, 3309)
	-- ----------------------------------------------------------------
	-- TextLeft = E.func_GetCurrencyName(3309)
	-- ColorLeft = E.COLOR_RED
	-- SettingsType = "Currencies#"..3309
	-- ----------------------------------------------------------------
	-- return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
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
end

