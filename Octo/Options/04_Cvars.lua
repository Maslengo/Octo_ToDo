local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.func_Cvars()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Cvars = {
		type = "group",
		childGroups = "tree",
		name = "Cvars",
		args = {



			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},

			-------------------------------------------------
			reverseCleanupBags = {
				type = "toggle",
				name = REVERSE_CLEAN_UP_BAGS_TEXT,
				desc = OPTION_TOOLTIP_REVERSE_CLEAN_UP_BAGS,
				get = function()
					if C_Container and C_Container.GetSortBagsRightToLeft then
						return C_Container.GetSortBagsRightToLeft()
					elseif GetInsertItemsRightToLeft then
						return GetInsertItemsRightToLeft()
					end
				end,
				set = function(_, value)
					C_Timer.After(0.5, function()
						AceConfigRegistry:NotifyChange("Cvars")
					end)

					if C_Container and C_Container.SetSortBagsRightToLeft then
						C_Container.SetSortBagsRightToLeft(value)
					elseif SetSortBagsRightToLeft then
						SetSortBagsRightToLeft(value)
					end
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},




			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		},
	}
	return Cvars
end