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
			-------------------------------------------------
			Enable_ToDo = {
				type = "toggle",
				name = "Enable_ToDo",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_ToDo
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_ToDo = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Enable_Moduls = {
				type = "toggle",
				name = "Enable_Moduls",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_Moduls
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_Moduls = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Enable_Achievements = {
				type = "toggle",
				name = "Enable_Achievements",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_Achievements
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_Achievements = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Enable_AddonsManager = {
				type = "toggle",
				name = "Enable_AddonsManager",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_AddonsManager
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_AddonsManager = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Enable_QuestsChanged = {
				type = "toggle",
				name = "Enable_QuestsChanged",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_QuestsChanged
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_QuestsChanged = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Enable_Minecraft = {
				type = "toggle",
				name = "Enable_Minecraft",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Enable_Minecraft
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Enable_Minecraft = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		},
	}
	return myOther
end