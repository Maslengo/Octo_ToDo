local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_02_TheBurningCrusade()
	local OctoTable_Universal = {



		{
			icon = E.func_GetItemIconByID(49623),
			textleft = E.func_questName(10106),
			name_save = "HellfireFortifications",
			reset = "Daily",
			desc = "TheBurningCrusade",
			questID = {

				13408, -- ALLIANCE, -- 10106,
				10110, -- HORDE
			},
			max = 1,
		},







	}
	return OctoTable_Universal
end