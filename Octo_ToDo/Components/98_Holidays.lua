local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 98
-- local expansionID =
----------------------------------------------------------------
local function tempFunction()
	local joinable, timewalkDungeonName = E.func_joinableDung()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = CALENDAR_FILTER_HOLIDAYS
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 1166, defS = true,}, -- Timewarped Badge (local joinable, timewalkDungeonName = E.func_joinableDung())
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
	OctoTables_DataOtrisovka[categoryKey].Reputations = {

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		-- E.func_EventName(181) (Noblegarden) (Сад чудес)
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = E.func_questName(13503, false) .. " ("..E.func_EventName(181)..")",
		-- 	name_save = "ATisketaTasketaNoblegardenBasket",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{13503},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79575, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "WhattheDuck",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79575},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(13479, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "TheGreatEggHunt",
		-- 	defS = true,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{13479},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79576, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "AFowlConcoction",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79576},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79577, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "DuckTales",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79577},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79578, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "JustaWaddleAway",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79578, faction = "Horde",}, -- Horde
		-- 		{79331, faction = "Alliance"}, -- Alliance
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79558, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "FeatheredFiend",
		-- 	defS = true,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79558, faction = "Horde",}, -- Horde
		-- 		{73192, faction = "Alliance"}, -- Alliance
		-- 	},
		-- },
		-- {
		-- 	TextLeft = E.func_questName(79135, false) .. " ("..E.func_EventName(181)..")",
		-- 	showTooltip = true,
		-- 	name_save = "QuackingDown",
		-- 	defS = true,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysNoblegarden",
		-- 	quests = {
		-- 		{79135},
		-- 	},
		-- },
		-- -- E.func_EventName(201) (ChildrensWeek) (Детская неделя)
		-- -- orgrimmar / Stormwind
		-- {
		-- 	TextLeft = "Orgrimmar/Stormwind" .. " ("..E.func_EventName(201)..")",
		-- 	showTooltip = true,
		-- 	name_save = "orgrimmarStormwind",
		-- 	defS = true,
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
		-- 	TextLeft = "Shattrath" .. " ("..E.func_EventName(201)..")",
		-- 	showTooltip = true,
		-- 	name_save = "Shattrath", --
		-- 	defS = true,
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
		-- 	TextLeft = L["Daily quests"] .. " ("..E.func_EventName(181)..")", -- ПОФИКСИТЬ
		-- 	showTooltip = true,
		-- 	name_save = "orgrimmarStormwindDAILY", --
		-- 	defS = true,
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
			TextLeft = RAIDS..(joinable and timewalkDungeonName or ""), --.. " ("..E.func_EventName(1583)..")",
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
			TextLeft = DUNGEONS..(joinable and timewalkDungeonName or ""), --.. " ("..E.func_EventName(1583)..")",
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
		-- 	TextLeft = "Profession Monthlies" .. " ("..E.func_EventName(479)..")",
		-- 	showTooltip = true,
		-- 	name_save = "ProfessionMonthlies",
		-- 	defS = true,
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
		-- 	TextLeft = "Monthly Quests" .. " ("..E.func_EventName(479)..")",
		-- 	showTooltip = true,
		-- 	name_save = "MonthlyQuests",
		-- 	defS = true,
		-- 	reset = "Month",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{33354},
		-- 		{29443},
		-- 	},
		-- 	forcedMaxQuest = 2,
		-- },
		-- {
		-- 	TextLeft = "Acount-wide Dailies" .. " ("..E.func_EventName(479)..")",
		-- 	showTooltip = true,
		-- 	name_save = "AcountwideDailies",
		-- 	defS = true,
		-- 	reset = "Daily",
		-- 	desc = categoryKey, -- "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{32175},
		-- 		{36471},
		-- 	},
		-- 	forcedMaxQuest = 2,
		-- },
		-- {
		-- 	TextLeft = "item turns ins" .. " ("..E.func_EventName(479)..")",
		-- 	showTooltip = true,
		-- 	name_save = "itemturnsins",
		-- 	defS = true,
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
		-- 	TextLeft = E.func_itemName(93724) .. " ("..E.func_EventName(479)..")",
		-- 	showTooltip = true,
		-- 	name_save = "DarkmoonFaire",
		-- 	defS = true,
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
		-- 	TextLeft = E.func_itemName(92441) .. " (Warlock)",
		-- 	showTooltip = true,
		-- 	name_save = "GreenFire",
		-- 	defS = true,
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
-- 	local OctoTable_Otrisovka_TextCenter = {}
-- 	----------------------------------------------------------------
-- 	----------------------------------------------------------------
-- 	----------------------------------------------------------------
-- 	if Octo_ToDo_DB_Vars.Holidays then
-- 		if E.ActiveHoliday[181] then
-- 			E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysNoblegarden")
-- 			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- 					----------------------------------------------------------------
-- 					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
-- 					----------------------------------------------------------------
-- 					if CharInfo.MASLENGO.ItemsInBag[44791] then
-- 						TextCenter = CharInfo.MASLENGO.ItemsInBag[44791]
-- 					end
-- 					----------------------------------------------------------------
-- 					TextLeft = E.func_itemName(44791)
-- 					ColorLeft = E.Holiday_Color
-- 					----------------------------------------------------------------
-- 					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
-- 					----------------------------------------------------------------
-- 			end)
-- 			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- 					----------------------------------------------------------------
-- 					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
-- 					----------------------------------------------------------------
-- 					if CharInfo.MASLENGO.ItemsInBag[45072] then
-- 						TextCenter = CharInfo.MASLENGO.ItemsInBag[45072]
-- 					end
-- 					----------------------------------------------------------------
-- 					TextLeft = E.func_itemName(45072)
-- 					ColorLeft = E.Holiday_Color
-- 					----------------------------------------------------------------
-- 					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
-- 					----------------------------------------------------------------
-- 			end)
-- 		end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
		-- 1583 EU classic
		-- 1508 US classic
		-- 1458 Бурные потоки
		-- local TimewalkHolidayTBL = {1705, 1583, 1265, 1063, 652, 622, 1508, 1667}
		-- for _, HolidayID in ipairs(TimewalkHolidayTBL) do
		-- if E.ActiveHoliday[HolidayID] then
		local joinable, timewalkDungeonName = E.func_joinableDung()
		if joinable then
			E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysTimewalk", E.Event_Color)
			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
					----------------------------------------------------------------
					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
					TooltipKey = "Timewalk_Mounts"
					----------------------------------------------------------------
					TextCenter = E.func_TextCenter_Currency(CharInfo, 1166)
					----------------------------------------------------------------
					TextLeft = E.func_currencyName(1166)..timewalkDungeonName
					ColorLeft = E.Event_Color
					SettingsType = "Currencies#"..1166
					----------------------------------------------------------------
					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
					----------------------------------------------------------------
			end)
		end
		-- end
		-- end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		-- if E.ActiveHoliday[201] then
-- 		-- E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysChildrensWeek")
-- 		-- end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		if E.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
-- 			E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysTheSpinnerofSummerTales")
-- 			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- 					----------------------------------------------------------------
-- 					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
-- 					----------------------------------------------------------------
-- 					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday then
-- 						TextCenter = CharInfo.MASLENGO.LFGInstance[286].donetoday
-- 					end
-- 					----------------------------------------------------------------
-- 					TextLeft = E.func_texturefromIcon(E.func_GetItemIconByID(23247))..E.func_texturefromIcon(E.ICON_LFG) .. E.func_LFGdungName(286)
-- 					ColorLeft = E.Holiday_Color
-- 					----------------------------------------------------------------
-- 					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
-- 					----------------------------------------------------------------
-- 			end)
-- 			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- 					----------------------------------------------------------------
-- 					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
-- 					----------------------------------------------------------------
-- 					if CharInfo.MASLENGO.ItemsInBag[23247] then
-- 						TextCenter = CharInfo.MASLENGO.ItemsInBag[23247]
-- 					end
-- 					----------------------------------------------------------------
-- 					TextLeft = E.func_itemName(23247)
-- 					ColorLeft = E.Holiday_Color
-- 					----------------------------------------------------------------
-- 					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
-- 					----------------------------------------------------------------
-- 			end)
-- 		end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		if E.ActiveHoliday[1691] then -- Алчный посланец
-- 			E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysAGreedyEmissary", E.Red_Color)
-- 			table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
-- 					----------------------------------------------------------------
-- 					local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
-- 					----------------------------------------------------------------
-- 					TextCenter = E.func_TextCenter_Currency(CharInfo, 3309)
-- 					----------------------------------------------------------------
-- 					TextLeft = E.func_currencyName(3309)
-- 					ColorLeft = E.Red_Color
-- 					SettingsType = "Currencies#"..3309
-- 					----------------------------------------------------------------
-- 					return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
-- 					----------------------------------------------------------------
-- 			end)
-- 		end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		if E.ActiveHoliday[479] then -- Ярмарка новолунья
-- 			E.func_Otrisovka_UniversalQuests(OctoTable_Otrisovka_TextCenter, "HolidaysDarkmoonFaire", E.Purple_Color)
-- 		end
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 		----------------------------------------------------------------
-- 	end
-- 	----------------------------------------------------------------
-- 	----------------------------------------------------------------
-- 	----------------------------------------------------------------
-- 	return OctoTable_Otrisovka_TextCenter
end