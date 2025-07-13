local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_03_WrathoftheLichKing()
	local OctoTable_Universal = {
		{
			icon = E.func_GetItemIconByID(49623),
			textleft = E.func_GetItemNameByID(49623),
			name_save = "Shadowmourne",
			reset = "Once",
			desc = "WrathoftheLichKing",
			questID = {
				24545,
				24743,
				24547,
				24749,
				24756,
				24757,
				24548,
				24549,
				24748,
			},
			max = 9,
		},
	}
	return OctoTable_Universal
end