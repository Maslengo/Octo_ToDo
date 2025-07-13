local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
E.OctoTable_05_MistsofPandaria = {

	{
		icon = E.Icon_WorldBoss,
		textleft = L["World Boss"],
		name_save = "WorldBoss",
		reset = "Weekly",
		desc = "MistsofPandaria",
		questID = {
			33118,
			33117,
			32519, -- Undasta
			33109,
			32098,
			32099,
		},
		max = 6,
	},


	{
		icon = E.func_GetItemIconByID(92441),
		textleft = E.func_GetItemNameByID(92441),
		name_save = "MistsofPandaria_GreenFire",
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
		max = 7,
	},


}