local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_06_WarlordsofDraenor()
	local OctoTable_Universal = {
		{

			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "WarlordsofDraenor",
			quests = {
				{37460},
				{37462},
				{37464}, -- "Rukhmar"
				{39380},
			},
			forcedMaxQuest = 4,
		},
		{

			showTooltip = true,
			textleft = GARRISON_LOCATION_TOOLTIP,
			name_save = "GarrisonLevel",
			reset = "Once",
			desc = "WarlordsofDraenor",
			quests = {
				{34378},
				{36567},
				{36614},
			},
			forcedMaxQuest = 3,
		},
	}
	return OctoTable_Universal
end