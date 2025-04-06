local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
function E.Items()
	local Items = {
		type = "group",
		childGroups = "tree",
		name = E.White_Color..ITEMS.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = 1,
			},
			-------------------------------------------------
			Items = {
				type = "toggle",
				name = ITEMS,
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.Items
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Items = value
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			-------------------------------------------------
			ItemsShowAllways = {
				type = "toggle",
				name = BATTLEFIELD_MINIMAP_SHOW_ALWAYS,
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.ItemsShowAllways
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ItemsShowAllways = value
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},
			-------------------------------------------------
			ReloadHeader453 = {
				type = "header",
				name = "",
				order = 7,
			},
		},
	}
	return Items
end

