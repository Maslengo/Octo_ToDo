local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.myOther()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local myOther = {
		type = "group",
		childGroups = "tree",
		name = "myOther",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		},
	}
	return myOther
end