local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Developing()
	local Developing = {
		type = "group",
		childGroups = "tree",
		name = "Developing",
		args = {
			-------------------------------------------------
			Developinginstructions = {
				type = "description",
				name = "These options allow you to toggle various options.",
				fontSize = "medium",
				order = 1,
			},
			-------------------------------------------------
			ReloadHeader3 = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			Reload = {
				type = "execute",
				name = RELOADUI,
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/2,
				order = 3,
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = DELETE.." "..ALL,
				func = function()
					profileKeys = {}
					Octo_ToDo_DB_Config = {}
					Octo_ToDo_DB_Players = {}
					Octo_ToDo_DB_Vars = {}
					Octo_ToDo_DB_Other = {}
					OCTO_DB_currencies_test = {}
					OCTO_DB_reputations_test = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/2,
				order = 4,
			},
			-------------------------------------------------

			ReloadHeader3second = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Config = {
				type = "execute",
				name = "Config",
				func = function()
					Octo_ToDo_DB_Config  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 7,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Players = {
				type = "execute",
				name = "Players",
				func = function()
					Octo_ToDo_DB_Players  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 8,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Vars = {
				type = "execute",
				name = "Vars",
				func = function()
					Octo_ToDo_DB_Vars  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 9,
			},
			-------------------------------------------------
			OCTO_DB_currencies_test = {
				type = "execute",
				name = "currencies",
				func = function()
					OCTO_DB_currencies_test  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 10,
			},
			-------------------------------------------------
			OCTO_DB_reputations_test = {
				type = "execute",
				name = "reputations",
				func = function()
					OCTO_DB_reputations_test  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 11,
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	return Developing
end

