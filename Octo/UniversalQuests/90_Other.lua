local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_90_Other()
	local OctoTable_Universal = {
		-- E:func_EventName(181) (Noblegarden) (Сад чудес)
		{

			textleft = E:func_questName(13503),
			showTooltip = true,
			name_save = "ATisketaTasketaNoblegardenBasket",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			quests = {
				{13503},
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79575),
			showTooltip = true,
			name_save = "WhattheDuck",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			quests = {
				{79575},
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(13479),
			showTooltip = true,
			name_save = "TheGreatEggHunt",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			quests = {
				{13479},
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79576),
			showTooltip = true,
			name_save = "AFowlConcoction",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			quests = {
				{79576},
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79577),
			showTooltip = true,
			name_save = "DuckTales",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			quests = {
				{79577},
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79578),
			showTooltip = true,
			name_save = "JustaWaddleAway",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			quests = {
				{79578, faction = "Horde",}, -- Horde
				{79331, faction = "Alliance"}, -- Alliance
			},
			-- forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79558),
			showTooltip = true,
			name_save = "FeatheredFiend",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			quests = {
				{79558, faction = "Horde",}, -- Horde
				{73192, faction = "Alliance"}, -- Alliance
			},
		},
		{

			textleft = E:func_questName(79135),
			showTooltip = true,
			name_save = "QuackingDown",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			quests = {
				{79135},
			},
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- E:func_EventName(201) (ChildrensWeek) (Детская неделя)
		-- orgrimmar / Stormwind
		{

			textleft = "Orgrimmar/Stormwind",
			showTooltip = true,
			name_save = "orgrimmarStormwind",
			reset = "Month",
			desc = "HolidaysChildrensWeek",
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

			textleft = "Shattrath",
			showTooltip = true,
			name_save = "Shattrath", --
			reset = "Month",
			desc = "HolidaysChildrensWeek",
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

			textleft = L["Daily quests"],
			showTooltip = true,
			name_save = "orgrimmarStormwindDAILY", --
			reset = "Daily",
			desc = "HolidaysTheSpinnerofSummerTales",
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

			textleft = RAIDS,
			showTooltip = true,
			name_save = "Raid",
			reset = "Weekly",
			desc = "HolidaysTimewalk",
			quests = {
				{57637},
				{50316},
				{47523},
				{82817},
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = DUNGEONS,
			showTooltip = true,
			name_save = "Dungeons",
			reset = "Weekly",
			desc = "HolidaysTimewalk",
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
		-- {

		-- 	textleft = "Profession Monthlies",
		-- 	showTooltip = true,
		-- 	name_save = "ProfessionMonthlies",
		-- 	reset = "Month",
		-- 	desc = "HolidaysDarkmoonFaire",
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
		-- 	-- forcedMaxQuest = 14,
		-- },
		-- {

		-- 	textleft = "Monthly Quests",
		-- 	showTooltip = true,
		-- 	name_save = "MonthlyQuests",
		-- 	reset = "Month",
		-- 	desc = "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{33354},
		-- 		{29443},
		-- 	},
		-- 	-- forcedMaxQuest = 2,
		-- },
		-- {

		-- 	textleft = "Acount-wide Dailies",
		-- 	showTooltip = true,
		-- 	name_save = "AcountwideDailies",
		-- 	reset = "Daily",
		-- 	desc = "HolidaysDarkmoonFaire",
		-- 	quests = {
		-- 		{32175},
		-- 		{36471},
		-- 	},
		-- 	-- forcedMaxQuest = 2,
		-- },
		-- {

		-- 	textleft = "item turns ins",
		-- 	showTooltip = true,
		-- 	name_save = "itemturnsins",
		-- 	reset = "Daily",
		-- 	desc = "HolidaysDarkmoonFaire",
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
		-- 	-- forcedMaxQuest = 9,
		-- },
		-- {

		-- 	textleft = E:func_itemName(93724),
		-- 	showTooltip = true,
		-- 	name_save = "DarkmoonFaire",
		-- 	reset = "Daily",
		-- 	desc = "HolidaysDarkmoonFaire",
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
		-- 	-- forcedMaxQuest = 9,
		-- },
		{

			textleft = E:func_itemName(92441),
			showTooltip = true,
			name_save = "GreenFire",
			reset = "Once",
			desc = "Warlock",
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
	return OctoTable_Universal
end