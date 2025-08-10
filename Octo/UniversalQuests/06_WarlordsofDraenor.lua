local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E.func_Universal_06_WarlordsofDraenor()
	local OctoTable_Universal = {
		{

			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "WarlordsofDraenor",
			quests = {
				{37460, forcedText = {npcID = 81252},}, -- Drov the Ruiner
				{37462, forcedText = {npcID = 81535},}, -- Tarlna the Ageless
				{37464, forcedText = {npcID = 87493},}, -- Rukhmar
				{39380, forcedText = {npcID = 94015},}, -- Supreme Lord Kazzak
			},
			forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = GARRISON_LOCATION_TOOLTIP,
			name_save = "GarrisonLevel",
			reset = "Once",
			desc = "WarlordsofDraenor",
			quests = {
				{34378, faction = "Horde",},
				{34586, faction = "Alliance",},

				{36567, faction = "Horde",},
				{36592, faction = "Alliance",},

				{36614, faction = "Horde",},
				{36615, faction = "Alliance",},
			},
			forcedMaxQuest = 3,
		},
	}
	return OctoTable_Universal
end