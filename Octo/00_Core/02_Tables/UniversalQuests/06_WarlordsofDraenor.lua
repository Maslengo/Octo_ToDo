local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_06_WarlordsofDraenor()
	local OctoTable_Universal = {
		{
			icon = E.Icon_WorldBoss,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "WarlordsofDraenor",
			questID = {
				37460,
				37462,
				37464,
				39380,
			},
			max = 4,
		},
		{
			icon = E.func_GetItemIconByID(110560),
			textleft = GARRISON_LOCATION_TOOLTIP,
			name_save = "GarrisonLevel",
			reset = "Once",
			desc = "WarlordsofDraenor",
			questID = {
				34378,
				36567,
				36614,
			},
			max = 3,
		},
	}
	return OctoTable_Universal
end