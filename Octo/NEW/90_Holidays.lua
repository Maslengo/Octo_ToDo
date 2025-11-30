local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 90

E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[8].icon
E.OctoTables_Vibor[currentSTATE].name = "90_Holidays"
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
	1166,
	3309,
	2588,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {
	44791,
	45072,
	23247,
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {


		-- E.func_EventName(181) (Noblegarden) (Сад чудес)
		{
			sorted = false,
			showTooltip = true,
			textleft = E.func_questName(13503) .. " ("..E.func_EventName(181)..")",
			name_save = "ATisketaTasketaNoblegardenBasket",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{13503},
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(79575) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "WhattheDuck",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79575},
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(13479) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "TheGreatEggHunt",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{13479},
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(79576) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "AFowlConcoction",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79576},
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(79577) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "DuckTales",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79577},
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(79578) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "JustaWaddleAway",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79578, faction = "Horde",}, -- Horde
				{79331, faction = "Alliance"}, -- Alliance
			},
			-- forcedMaxQuest = 1,
		},
		{
			textleft = E.func_questName(79558) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "FeatheredFiend",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79558, faction = "Horde",}, -- Horde
				{73192, faction = "Alliance"}, -- Alliance
			},
		},
		{
			textleft = E.func_questName(79135) .. " ("..E.func_EventName(181)..")",
			showTooltip = true,
			name_save = "QuackingDown",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysNoblegarden",
			quests = {
				{79135},
			},
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- E.func_EventName(201) (ChildrensWeek) (Детская неделя)
		-- orgrimmar / Stormwind
		{
			textleft = "Orgrimmar/Stormwind" .. " ("..E.func_EventName(201)..")",
			showTooltip = true,
			name_save = "orgrimmarStormwind",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysChildrensWeek",
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
		},
		----------------------------------------------------------------
		{
			textleft = "Shattrath" .. " ("..E.func_EventName(201)..")",
			showTooltip = true,
			name_save = "Shattrath", --
			reset = "Month",
			desc = currentSTATE, --  "HolidaysChildrensWeek",
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
		},
		----------------------------------------------------------------
		{
			textleft = L["Daily quests"] .. " ("..E.func_EventName(181)..")", -- ПОФИКСИТЬ
			showTooltip = true,
			name_save = "orgrimmarStormwindDAILY", --
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysTheSpinnerofSummerTales",
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
			textleft = RAIDS .. " ("..E.func_EventName(1583)..")",
			showTooltip = true,
			name_save = "Raid",
			reset = "Weekly",
			desc = currentSTATE, --  "HolidaysTimewalk",
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
			textleft = DUNGEONS .. " ("..E.func_EventName(1583)..")",
			showTooltip = true,
			name_save = "Dungeons",
			reset = "Weekly",
			desc = currentSTATE, --  "HolidaysTimewalk",
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
		{
			textleft = "Profession Monthlies" .. " ("..E.func_EventName(479)..")",
			showTooltip = true,
			name_save = "ProfessionMonthlies",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysDarkmoonFaire",
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
			textleft = "Monthly Quests" .. " ("..E.func_EventName(479)..")",
			showTooltip = true,
			name_save = "MonthlyQuests",
			reset = "Month",
			desc = currentSTATE, --  "HolidaysDarkmoonFaire",
			quests = {
				{33354},
				{29443},
			},
			-- forcedMaxQuest = 2,
		},
		{
			textleft = "Acount-wide Dailies" .. " ("..E.func_EventName(479)..")",
			showTooltip = true,
			name_save = "AcountwideDailies",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysDarkmoonFaire",
			quests = {
				{32175},
				{36471},
			},
			-- forcedMaxQuest = 2,
		},
		{
			textleft = "item turns ins" .. " ("..E.func_EventName(479)..")",
			showTooltip = true,
			name_save = "itemturnsins",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysDarkmoonFaire",
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
			textleft = E.func_itemName(93724) .. " ("..E.func_EventName(479)..")",
			showTooltip = true,
			name_save = "DarkmoonFaire",
			reset = "Daily",
			desc = currentSTATE, --  "HolidaysDarkmoonFaire",
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
			textleft = E.func_itemName(92441) .. " (Warlock)",
			showTooltip = true,
			name_save = "GreenFire",
			reset = "Once",
			desc = currentSTATE, --  "Warlock",
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
E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {

}
----------------------------------------------------------------
function E.func_Otrisovka_90_Holidays()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Holidays then
		if E.ActiveHoliday[181] then
			E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysNoblegarden")
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[44791] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[44791]
					end
					----------------------------------------------------------------
					textLEFT = E.func_itemName(44791)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[45072] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[45072]
					end
					----------------------------------------------------------------
					textLEFT = E.func_itemName(45072)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- 1583 EU classic
		-- 1508 US classic
		-- 1458 Бурные потоки
		-- local TimewalkHolidayTBL = {1583, 1265, 1063, 652, 622, 1508, 1667}
		-- for _, HolidayID in ipairs(TimewalkHolidayTBL) do
		--     if E.ActiveHoliday[HolidayID] then
		local joinable, timewalkDungeonName = E.func_joinableDung()
		if joinable then
			E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysTimewalk", E.Event_Color)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					tooltipKey = "Timewalk_Mounts"
					----------------------------------------------------------------
					textCENT = E.func_textCENT_Currency(CharInfo, 1166)
					myType = {"Currency", 1166}
					----------------------------------------------------------------
					textLEFT = E.func_currencyName(1166)..timewalkDungeonName
					colorLEFT = E.Event_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
		end
		--     end
		-- end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- if E.ActiveHoliday[201] then
		--     E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysChildrensWeek")
		-- end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
			E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysTheSpinnerofSummerTales")
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday then
						textCENT = CharInfo.MASLENGO.LFGInstance[286].donetoday
					end
					----------------------------------------------------------------
					textLEFT = E.func_texturefromIcon(E.func_GetItemIconByID(23247))..E.func_texturefromIcon(E.Icon_LFG) .. E.func_LFGdungName(286)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[23247] then
						textCENT = CharInfo.MASLENGO.ItemsInBag[23247]
					end
					----------------------------------------------------------------
					textLEFT = E.func_itemName(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[1691] then -- Алчный посланец
			E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysAGreedyEmissary", E.Red_Color)
			table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
					----------------------------------------------------------------
					local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
					----------------------------------------------------------------
					textCENT = E.func_textCENT_Currency(CharInfo, 3309)
					myType = {"Currency", 3309}
					----------------------------------------------------------------
					textLEFT = E.func_currencyName(3309)
					colorLEFT = E.Red_Color
					----------------------------------------------------------------
					return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if E.ActiveHoliday[479] then -- Ярмарка новолунья
			E.func_Universal(OctoTable_Otrisovka_textCENT, "HolidaysDarkmoonFaire", E.Purple_Color)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT)
		E.func_Universal(OctoTable_Otrisovka_textCENT)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end