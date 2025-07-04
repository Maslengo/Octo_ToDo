local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
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
		name = BINDING_HEADER_DEBUG,
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
				name = RELOADUI,
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = DELETE.." "..ALL,
				desc = "Octo_ToDo_DB_Levels  = {}|nOcto_ToDo_DB_Vars = {}",
				func = function()
					Octo_ToDo_DB_Levels = {}
					Octo_ToDo_DB_Vars = {}
					Octo_ToDo_DB_Other = {}
					Octo_Achievements_DB = {}
					Octo_AddonsTable = {}
					Octo_AddonsManager_DB = {}
					Octo_DEBUG = {}
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
			Octo_ToDo_DB_Levels = {
				type = "execute",
				name = "Levels",
				desc = "Octo_ToDo_DB_Levels  = {}",
				func = function()
					Octo_ToDo_DB_Levels  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Octo_ToDo_DB_Other = {
				type = "execute",
				name = "Other",
				desc = "Octo_ToDo_DB_Other  = {}",
				func = function()
					Octo_ToDo_DB_Other  = {}
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Octo_ToDo_DB_Vars = {
				type = "execute",
				name = "Vars",
				desc = "Octo_ToDo_DB_Vars  = {}",
				func = function()
					Octo_ToDo_DB_Vars  = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeader3second221542 = {
				type = "header",
				name = OTHER,
				order = GetOrder(),
			},
			-------------------------------------------------
			MASLENGO = {
				type = "execute",
				name = "MASLENGO",
				desc = "CharInfo.MASLENGO = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO")
						CharInfo.MASLENGO = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ReloadHeader3second222154 = {
				type = "header",
				name = OTHER,
				order = GetOrder(),
			},
			-------------------------------------------------
			CurrencyID_totalEarned = {
				type = "execute",
				name = "CurrencyID_totalEarned",
				desc = "CharInfo.MASLENGO.CurrencyID_totalEarned = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.CurrencyID_totalEarned")
						CharInfo.MASLENGO.CurrencyID_totalEarned  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			CurrencyID = {
				type = "execute",
				name = "CurrencyID",
				desc = "CharInfo.MASLENGO.CurrencyID = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.CurrencyID")
						CharInfo.MASLENGO.CurrencyID  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			OctoTable_QuestID = {
				type = "execute",
				name = "OctoTable_QuestID",
				desc = "CharInfo.MASLENGO.OctoTable_QuestID = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.OctoTable_QuestID")
						CharInfo.MASLENGO.OctoTable_QuestID  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ItemsInBag = {
				type = "execute",
				name = "ItemsInBag",
				desc = "CharInfo.MASLENGO.ItemsInBag = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.ItemsInBag")
						CharInfo.MASLENGO.ItemsInBag  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			professions = {
				type = "execute",
				name = "professions",
				desc = "CharInfo.MASLENGO.professions = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.professions")
						CharInfo.MASLENGO.professions  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			reputationNEW = {
				type = "execute",
				name = "reputationNEW",
				desc = "CharInfo.MASLENGO.reputationNEW = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.reputationNEW")
						CharInfo.MASLENGO.reputationNEW = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			CurrencyID_Total = {
				type = "execute",
				name = "CurrencyID_Total",
				desc = "CharInfo.MASLENGO.CurrencyID_Total = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.CurrencyID_Total")
						CharInfo.MASLENGO.CurrencyID_Total  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Quests = {
				type = "execute",
				name = "Quests",
				desc = "CharInfo.MASLENGO.Quests = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.Quests")
						CharInfo.MASLENGO.Quests  = {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			UniversalQuest = {
				type = "execute",
				name = "UniversalQuest",
				desc = "CharInfo.MASLENGO.UniversalQuest = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						print (CharInfo.classColorHex..CharInfo.Name.."|r", "CharInfo.MASLENGO.UniversalQuest")
						CharInfo.MASLENGO.UniversalQuest  = {}
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
					return Octo_ToDo_DB_Vars.ItemsUsable
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ItemsUsable = value
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
					return Octo_ToDo_DB_Vars.ItemsDelete
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ItemsDelete = value
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
					return Octo_ToDo_DB_Vars.StaticPopup1Button1
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.StaticPopup1Button1 = value
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
					return Octo_ToDo_DB_Vars.CVar
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.CVar = value
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
					return Octo_ToDo_DB_Vars.SpeedFrame.Shown
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.SpeedFrame.Shown = value
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
					return Octo_ToDo_DB_Vars.Hide_ObjectivesInInstance
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_ObjectivesInInstance = value
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
					return Octo_ToDo_DB_Vars.SellFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.SellFrame = value
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
					return Octo_ToDo_DB_Vars.DebugIDs
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugIDs = value
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
					return Octo_ToDo_DB_Vars.DebugInfo
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugInfo = value
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
					return Octo_ToDo_DB_Vars.DebugEvent
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugEvent = value
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
					return Octo_ToDo_DB_Vars.DebugFunction
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugFunction = value
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
					return Octo_ToDo_DB_Vars.DebugButton
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugButton = value
					E.DebugButton = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Header999 = {
				type = "header",
				name = "",
				order = GetOrder()+999,
			},
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


	local function add_args_recursive(tbl, text)
		for k, v in next, (tbl) do
			if type(v) == "table" and type(k) ~= "table" then
				local order1 = GetOrder()
				k = tostring(k)
				Developing.args[k..order1] = {
					type = "execute",
					name = k,
					desc = text.."."..k.." = {}",
					order = order1,
					width = E.FULL_WIDTH/4,
					func = function()
						tbl[k] = nil
						print (text..".|cffFF5050"..k .. "|r=", v)
						-- fpde(tbl[k])
						return
					end,
				}
				add_args_recursive(v, k)
			end
		end
	end

	local function add_args(tbl, text)
		local order2 = GetOrder()
		Developing.args[text..order2] = {
			type = "header",
			name = text,
			order = order2,
		}

		local order3 = GetOrder()
		Developing.args[text..order3] = {
			type = "execute",
			name = "|cff4fff79"..text.."|r",
			desc = text.." = {}",
			order = order3,
			width = E.FULL_WIDTH/4,
			func = function()
				tbl = nil
				print (text.." = {}")
				-- fpde(tbl)
				return
			end,
		}

		add_args_recursive(tbl, text)
	end




	-- add_args(Octo_ToDo_DB_Levels, "Octo_ToDo_DB_Levels")
	add_args(Octo_ToDo_DB_Vars, "Octo_ToDo_DB_Vars")
	add_args(Octo_ToDo_DB_Other, "Octo_ToDo_DB_Other")
	add_args(Octo_Achievements_DB, "Octo_Achievements_DB")
	add_args(Octo_AddonsTable, "Octo_AddonsTable")
	add_args(Octo_AddonsManager_DB, "Octo_AddonsManager_DB")
	add_args(Octo_DEBUG, "Octo_DEBUG")



	return Developing
end