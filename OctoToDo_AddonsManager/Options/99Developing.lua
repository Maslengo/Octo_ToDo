local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.DevelopingADDONS()
	local Developing = {
		type = "group",
		childGroups = "tree",
		name = E.Debug_Color..BINDING_HEADER_DEBUG.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = 1,
			},
			-------------------------------------------------
			Reload = {
				type = "execute",
				name = E.Debug_Color..RELOADUI.."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 2,
			},
			-- -------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = E.Debug_Color..DELETE.." "..ALL.."|r",
				func = function()
					OctoToDo_AddonsManager = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			-------------------------------------------------
			Header4 = {
				type = "header",
				name = "",
				order = 4,
			},
			-- -------------------------------------------------
		},
	}
	return Developing
end