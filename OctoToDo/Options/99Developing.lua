local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Developing()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Developing = {
		type = "group",
		childGroups = "tree",
		name = E.Debug_Color..BINDING_HEADER_DEBUG.."|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Reload = {
				type = "execute",
				name = E.Debug_Color..RELOADUI.."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = E.Debug_Color..DELETE.." "..ALL.."|r",
				func = function()
					OctoToDo_DB_Config = {}
					OctoToDo_DB_Levels = {}
					OctoToDo_DB_Vars = {}
					OctoToDo_DB_Other = {}
					OctoToDo_Achievements = {}
					OctoSimpleList = {}
					OctoToDo_AddonsTable = {}
					OctoToDo_AddonsManager = {}
					OctoToDo_OCTOREP = {}
					OctoToDo_TrashCan = {}




					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeader3second = {
				type = "header",
				name = "",
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
			},

			-------------------------------------------------
			UniversalQuest = {
				type = "execute",
				name = "UniversalQuest",
				func = function()
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						print (CharInfo.Name, "УДАЛИЛИСЬ CharInfo.MASLENGO.UniversalQuest")
						CharInfo.MASLENGO.UniversalQuest  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			MASLENGO = {
				type = "execute",
				name = E.Debug_Color.."MASLENGO|r",
				func = function()
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						print (CharInfo.Name, "УДАЛИЛИСЬ CharInfo.MASLENGO")
						CharInfo.MASLENGO = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeader3second22154 = {
				type = "header",
				name = OTHER,
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeaderDebugs = {
				type = "header",
				name = "Debug",
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
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
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeader3second22 = {
				type = "header",
				name = "",
				order = GetOrder(),
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

