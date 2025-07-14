local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Automatization()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Automatization = {
		type = "group",
		childGroups = "tree",
		name = "Automatization",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_SellGrey = {
				type = "toggle",
				name = L["Auto Sell Grey"], -- "AUTO "..SELL_ALL_JUNK_ITEMS_EXCLUDE_HEADER, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_SellGrey
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_SellGrey = value
				end,
				width = E.FULL_WIDTH/2, -- "full",
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_Repair = {
				type = "toggle",
				name = L["Auto Repair"], -- "AUTO "..REPAIR_ALL_ITEMS, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_Repair
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_Repair = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_InputDelete = {
				type = "toggle",
				name = L["Auto Input Delete"], -- "AUTO "..DELETE, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_InputDelete
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_InputDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_OpenItems = {
				type = "toggle",
				name = L["Auto Open Items"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_OpenItems
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_OpenItems = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_Gossip = {
				type = "toggle",
				name = L["Auto Gossip"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_Gossip
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_Gossip = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_TurnQuests = {
				type = "toggle",
				name = L["Auto Turn Quests"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_TurnQuests
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_TurnQuests = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_ChatClearing = {
				type = "toggle",
				name = L["Auto Clear Chat"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_ChatClearing
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_ChatClearing = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_Screenshot = {
				type = "toggle",
				name = L["Auto Screenshot"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_Screenshot
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_Screenshot = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_CinematicCanceler = {
				type = "toggle",
				name = L["Auto Cinematic Canceler"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_CinematicCanceler
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_CinematicCanceler = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Auto_CinematicFastSkip = {
				type = "toggle",
				name = "Cinematic Fast Skip (ESC/Space/Enter)",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Auto_CinematicFastSkip
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Auto_CinematicFastSkip = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},

			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		},
	}
	return Automatization
end