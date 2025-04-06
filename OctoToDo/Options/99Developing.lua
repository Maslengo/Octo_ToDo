local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Developing()
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
				order = 3,
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = E.Debug_Color..DELETE.." "..ALL.."|r",
				func = function()
					OctoToDo_DB_Config = {}
					OctoToDo_DB_Levels = {}
					OctoToDo_DB_Other = {}
					OctoToDo_DB_Vars = {}
					OCTO_DB_currencies_test = {}
					OCTO_DB_reputations_test = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},
			-------------------------------------------------
			ReloadHeader3second = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
			OctoToDo_DB_Config = {
				type = "execute",
				name = "Config",
				func = function()
					OctoToDo_DB_Config  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 7,
			},
			-------------------------------------------------
			OctoToDo_DB_Levels = {
				type = "execute",
				name = "Players",
				func = function()
					OctoToDo_DB_Levels  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 8,
			},
			-------------------------------------------------
			OctoToDo_DB_Other = {
				type = "execute",
				name = "Other",
				func = function()
					OctoToDo_DB_Other  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 9,
			},
			-------------------------------------------------
			OctoToDo_DB_Vars = {
				type = "execute",
				name = E.Debug_Color.."Vars".."|r",
				func = function()
					OctoToDo_DB_Vars  = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = 10,
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
				order = 11,
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
				order = 12,
			},

			-------------------------------------------------
			UniversalQuest = {
				type = "execute",
				name = "UniversalQuest",
				func = function()
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						print (CharInfo.Name, "УДАЛИЛИСЬ UniversalQuest")
						CharInfo.MASLENGO.UniversalQuest  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 13,
			},

			-------------------------------------------------
			MASLENGO = {
				type = "execute",
				name = E.Debug_Color.."MASLENGO|r",
				func = function()
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.MASLENGO = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = 14,
			},
			-------------------------------------------------
			ReloadHeader3second22154 = {
				type = "header",
				name = OTHER,
				order = 15,
			},
			-------------------------------------------------
			ItemsUsable = {
				type = "toggle",
				name = "ItemsUsable",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.ItemsUsable
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ItemsUsable = value
				end,
				width = E.FULL_WIDTH/2,
				order = 25,
			},
			-------------------------------------------------
			ItemsDelete = {
				type = "toggle",
				name = "ItemsDelete",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.ItemsDelete
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ItemsDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = 26,
			},
			-------------------------------------------------
			StaticPopup1Button1 = {
				type = "toggle",
				name = "StaticPopup1Button1",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.StaticPopup1Button1
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.StaticPopup1Button1 = value
				end,
				width = E.FULL_WIDTH/2,
				order = 27,
			},
			-------------------------------------------------
			CVar = {
				type = "toggle",
				name = "CVar",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.CVar
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.CVar = value
				end,
				width = E.FULL_WIDTH/2,
				order = 29,
			},
			-------------------------------------------------
			SpeedFrameShown = {
				type = "toggle",
				name = "SpeedFrame.Shown",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.SpeedFrame.Shown
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.SpeedFrame.Shown = value
				end,
				width = E.FULL_WIDTH/2,
				order = 30,
			},
			-------------------------------------------------
			Hide_ObjectivesInInstance = {
				type = "toggle",
				name = "Hide_ObjectivesInInstance",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.Hide_ObjectivesInInstance
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_ObjectivesInInstance = value
				end,
				width = E.FULL_WIDTH/2,
				order = 33,
			},
			-------------------------------------------------
			SellFrame = {
				type = "toggle",
				name = "SellFrame",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.SellFrame
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.SellFrame = value
				end,
				width = E.FULL_WIDTH/2,
				order = 34,
			},
			-------------------------------------------------
			ReloadHeaderDebugs = {
				type = "header",
				name = "Debug",
				order = 35,
			},
			-------------------------------------------------
			DebugIDs = {
				type = "toggle",
				name = "DebugIDs",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.DebugIDs
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.DebugIDs = value
					E.DebugIDs = value
				end,
				width = E.FULL_WIDTH/2,
				order = 36,
			},
			-------------------------------------------------
			DebugInfo = {
				type = "toggle",
				name = "DebugInfo",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.DebugInfo
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.DebugInfo = value
					E.DebugInfo = value
				end,
				width = E.FULL_WIDTH/2,
				order = 37,
			},
			-------------------------------------------------
			DebugEvent = {
				type = "toggle",
				name = "DebugEvent",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.DebugEvent
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.DebugEvent = value
					E.DebugEvent = value
				end,
				width = E.FULL_WIDTH/2,
				order = 38,
			},
			-------------------------------------------------
			DebugFunction = {
				type = "toggle",
				name = "DebugFunction",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.DebugFunction
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.DebugFunction = value
					E.DebugFunction = value
				end,
				width = E.FULL_WIDTH/2,
				order = 39,
			},
			-------------------------------------------------
			DebugButton = {
				type = "toggle",
				name = "DebugButton",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.DebugButton
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.DebugButton = value
					E.DebugButton = value
				end,
				width = E.FULL_WIDTH/2,
				order = 40,
			},
			-------------------------------------------------
			ReloadHeader3second22 = {
				type = "header",
				name = "",
				order = 47,
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

