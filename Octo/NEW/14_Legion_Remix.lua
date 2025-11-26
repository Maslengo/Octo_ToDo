local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 14
E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[7].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[7].color..E.OctoTable_Expansions[7].name.." (REMIX)|r"
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
	-- 3292, -- E.func_IsRemix()
	-- 3268, -- E.func_IsRemix()
	3252, -- E.func_IsRemix()
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {
}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {

	1900, --name = "Двор Фарондиса", side = "-", category = "Legion", }, --[faction=1900]
	1883, --name = "Ткачи Снов", side = "-", category = "Legion", }, --[faction=1883]
	1828, --name = "Племена Крутогорья", side = "-", category = "Legion", }, --[faction=1828]
	1948, --name = "Валарьяры", side = "-", category = "Legion", }, --[faction=1948]

	1894, --name = "Стражи", side = "-", category = "Legion", }, --[faction=1894]
	1859, --name = "Помраченные", side = "-", category = "Legion", }, --[faction=1859]

	2170, --name = "Защитники Аргуса", side = "-", category = "Legion", }, --[faction=2170]
	2165, --name = "Армия Света", side = "-", category = "Legion", }, --[faction=2165]
	2045, --name = "Армия погибели Легиона", side = "-", category = "Legion", }, --[faction=2045]


}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
	{
		showTooltip = true,
		sorted = false,
		textleft = E.Timers.Legion_Remix_Invasion(),
		name_save = "hz45921",
		reset = "Daily",
		desc = currentSTATE,
		quests ={
			-- VALSHARA
			-- {45812},
			-- {44789},
			-- {45856},
			{45921},
			{46763},
			{46265},
			{44884},
			{44759},
			{46261},

			{nil},
			-- ASUNA
			-- {45838}, -- АТАКА НА АЗСУНУ
			-- {45795},
			-- {46205},
			-- {46199},
			{46169},
			{46168},
			{46163},
			{45058},
			{45134},
			{45203},

			{nil},
			-- {45840}, -- КРУТОГОРЬЕ
			-- {45572},
			-- {46182},
			{46183},
			{46186},
			{46195},
			{46188},
			{46194},
			{46190},


			{nil},
			-- {45839}, -- ШТОРМХЕЙМ
			-- {45406},
			-- {46110},
			{46015},
			{46013},
			{45786},
			{46216},
			{46012},
			{45439},


		},
		forcedMaxQuest = 6,
	},
}
----------------------------------------------------------------
E.func_TableConcat(E.ALL_Currencies, E.OctoTables_DataOtrisovka[currentSTATE].Currencies)
E.func_TableConcat(E.ALL_Items, E.OctoTables_DataOtrisovka[currentSTATE].Items)
E.func_TableConcat(E.ALL_Reputations, E.OctoTables_DataOtrisovka[currentSTATE].Reputations)
E.func_TableConcat(E.ALL_UniversalQuests, E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests)