local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_99_Other()
	local OctoTable_Universal = {
		-- E:func_EventName(181) (Noblegarden) (Сад чудес)
		{

			textleft = E:func_questName(13503),
			name_save = "ATisketaTasketaNoblegardenBasket",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			questID = {
				13503,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79575),
			name_save = "WhattheDuck",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			questID = {
				79575,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(13479),
			name_save = "TheGreatEggHunt",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			questID = {
				13479,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79576),
			name_save = "AFowlConcoction",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			questID = {
				79576,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79577),
			name_save = "DuckTales",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			questID = {
				79577,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79578),
			name_save = "JustaWaddleAway",
			reset = "Month",
			desc = "HolidaysNoblegarden",
			questID = {
				79578, -- Horde
				79331, -- Alliance
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79558),
			name_save = "FeatheredFiend",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			questID = {
				79558, -- Horde
				73192, -- Alliance
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = E:func_questName(79135),
			name_save = "QuackingDown",
			reset = "Daily",
			desc = "HolidaysNoblegarden",
			questID = {
				79135,
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		-- E:func_EventName(201) (ChildrensWeek) (Детская неделя)
		-- orgrimmar / Stormwind
		{

			textleft = "Orgrimmar/Stormwind",
			name_save = "orgrimmarStormwind",
			reset = "Month",
			desc = "HolidaysChildrensWeek",
			questID = {
				172, -- Horde
				29146, -- Horde
				29176, -- Horde
				54146, -- Horde
				29190, -- Horde
				29191, -- Horde
				5502, -- Horde
				----
				1468,
				29093,
				29106,
				54130,
				-- 29117, -- ДУБЛЬ
				-- 29119, -- ДУБЛЬ
				171,
			},
			forcedMaxQuest = 7,
		},
		----------------------------------------------------------------
		{

			textleft = "Shattrath",
			name_save = "Shattrath", --
			reset = "Month",
			desc = "HolidaysChildrensWeek",
			questID = {
				10942, -- Horde
				10953, -- Horde
				10951, -- Horde
				10945, -- Horde
				11975, -- Horde
				10963, -- Horde
				10967, -- Horde
				----
				10943,
				10950,
				10952,
				10954,
				-- 10962, -- ДУБЛЬ
				10956,
				-- 10966, -- ЛИШНЕЕ?
				-- 10968, -- ЛИШНЕЕ?
				10966,
			},
			forcedMaxQuest = 7,
		},
		----------------------------------------------------------------
		{

			textleft = L["Daily quests"],
			name_save = "orgrimmarStormwindDAILY", --
			reset = "Daily",
			desc = "HolidaysTheSpinnerofSummerTales",
			questID = {
				82109, -- daily horde
				11925, -- daily horde
				-- 82080, -- daily ally
				-- 11924, -- daily ally
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		{

			textleft = RAIDS,
			name_save = "Raid",
			reset = "Weekly",
			desc = "HolidaysTimewalk",
			questID = {
				57637,
				50316,
				47523,
				82817,
			},
			forcedMaxQuest = 1,
		},
		{

			textleft = DUNGEONS,
			name_save = "Dungeons",
			reset = "Weekly",
			desc = "HolidaysTimewalk",
			questID = {
				88808,
				86564,
				86563,
				86560,
				86556,
				85949,
				85948,
				85947,
				83274,
				83365,
				83363,
				72727,
				72726,
				72725,
				72724,
				72719,
				40792,
				39021,
				39020,
			},
			forcedMaxQuest = 1,
		},



		{

			textleft = "HZ",
			name_save = "Dungeons",
			reset = "Weekly",
			desc = "HolidaysTimewalk",
			questID = {
				43117, -- CLASSIC
				0, -- BC
				5, -- WOTLK
				618, -- CATA
				619, -- CATA (Alliance)
				5395, -- MOP
				15330, -- WOD
				24542, -- Legion
				49055, -- BfA
				49054, -- BfA (Alliance)
				40168, -- HZ
			},
			forcedMaxQuest = 9,
		},






		-- {

		-- 	textleft = E.Timers.Treasure_Goblin()..E:func_npcName(205722), -- 205490
		-- 	name_save = "TreasureGoblin",
		-- 	reset = "Daily",
		-- 	desc = "HolidaysAGreedyEmissary",
		-- 	questID = {
		-- 		76215, -- шам, пал ->Убийство гоблина
		-- 		-- 91091, -- шам, (хз на пале не сделан)
		-- 		-- 76216, -- шам
		-- 		-- 91166, -- шам
		-- 		-- 91167, -- шам
		-- 		-- 91168, -- шам
		-- 		-- 91169, -- пал ->Открытие сундука
		-- 		-- 91170, -- пал ->Открытие сундука
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		{

			textleft = "Profession Monthlies",
			name_save = "ProfessionMonthlies",
			reset = "Month",
			desc = "HolidaysDarkmoonFaire",
			questID = {
				29506,
				29507,
				29508,
				29509,
				29510,
				29511,
				29513,
				29514,
				29515,
				29516,
				29517,
				29518,
				29519,
				29520,
			},
			forcedMaxQuest = 14,
		},
		{

			textleft = "Monthly Quests",
			name_save = "MonthlyQuests",
			reset = "Month",
			desc = "HolidaysDarkmoonFaire",
			questID = {
				33354,
				29443,
			},
			forcedMaxQuest = 2,
		},
		{

			textleft = "Acount-wide Dailies",
			name_save = "AcountwideDailies",
			reset = "Daily",
			desc = "HolidaysDarkmoonFaire",
			questID = {
				32175,
				36471,
			},
			forcedMaxQuest = 2,
		},
		{

			textleft = "item turns ins",
			name_save = "itemturnsins",
			reset = "Daily",
			desc = "HolidaysDarkmoonFaire",
			questID = {
				29458,
				29456,
				29457,
				29443,
				29444,
				29445,
				29446,
				29464,
				29451,
			},
			forcedMaxQuest = 9,
		},
		{

			textleft = E:func_GetItemNameByID(93724),
			name_save = "DarkmoonFaire",
			reset = "Daily",
			desc = "HolidaysDarkmoonFaire",
			questID = {
				37911,
				29438,
				36481,
				29463,
				29436,
				29434,
				37910,
				29455,
				64783,
			},
			forcedMaxQuest = 9,
		},
		{

			textleft = E:func_GetItemNameByID(92441),
			name_save = "GreenFire",
			reset = "Once",
			desc = "Warlock",
			questID = {
				32295,
				32307,
				32309,
				32310,
				32317,
				32324,
				32325,
			},
			forcedMaxQuest = 7,
		},
	}
	return OctoTable_Universal
end