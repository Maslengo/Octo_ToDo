local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E.func_Universal_03_WrathoftheLichKing()
	local OctoTable_Universal = {
		{
			showTooltip = true,
			textleft = E.func_questName(24748),
			name_save = "Shadowmourne",
			reset = "Once",
			desc = "WrathoftheLichKing",
			quests = {
				{24545},
				{24743},
				{24547},
				{24749},
				{24756},
				{24757},
				{24548},
				{24549},
				{24748},
			},
			forcedMaxQuest = 9,
		},
	}
	return OctoTable_Universal
end