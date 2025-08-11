local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.func_Debug()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Debug = {
		type = "group",
		childGroups = "tab",
		name = "Debug", -- BINDING_HEADER_DEBUG
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
				desc = "Octo_ToDo_DB_Levels= {}|nOcto_ToDo_DB_Vars = {}",
				func = function()
					Octo_ToDo_DB_Levels = {}
					Octo_ToDo_DB_Vars = {}
					Octo_ToDo_DB_Other = {}
					Octo_Minecraft_DB = {}
					Octo_Achievements_DB = {}
					Octo_AddonsTable_DB = {}
					Octo_AddonsManager_DB = {}
					Octo_Debug_DB = {}
					Octo_QuestsChanged_DB = {}
					Octo_Cache_DB = {}
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
			MASLENGO = {
				type = "execute",
				name = "MASLENGO",
				desc = "CharInfo.MASLENGO = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO = {}
					end
					return
				end,
				width = E.FULL_WIDTH,
				order = GetOrder(),
			},
			-------------------------------------------------
			CovenantAndAnima = {
				type = "execute",
				name = "CovenantAndAnima",
				desc = "CharInfo.MASLENGO.CovenantAndAnima = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.CovenantAndAnima= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Currency = {
				type = "execute",
				name = "Currency",
				desc = "CharInfo.MASLENGO.Currency = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.Currency= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			garrisonType = {
				type = "execute",
				name = "garrisonType",
				desc = "CharInfo.MASLENGO.garrisonType = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.garrisonType= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			GARRISON = {
				type = "execute",
				name = "GARRISON",
				desc = "CharInfo.MASLENGO.GARRISON = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.GARRISON= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			GarrisonFollowers = {
				type = "execute",
				name = "GarrisonFollowers",
				desc = "CharInfo.MASLENGO.GarrisonFollowers = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.GarrisonFollowers= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			GarrisonFollowersCount = {
				type = "execute",
				name = "GarrisonFollowersCount",
				desc = "CharInfo.MASLENGO.GarrisonFollowersCount = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.GarrisonFollowersCount= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			GreatVault = {
				type = "execute",
				name = "GreatVault",
				desc = "CharInfo.MASLENGO.GreatVault = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.GreatVault= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			HasGarrison = {
				type = "execute",
				name = "HasGarrison",
				desc = "CharInfo.MASLENGO.HasGarrison = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.HasGarrison= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ItemsALL = {
				type = "execute",
				name = "ItemsALL",
				desc = "CharInfo.MASLENGO.ItemsALL = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.ItemsALL= {}
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
						CharInfo.MASLENGO.ItemsInBag= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			journalInstance = {
				type = "execute",
				name = "journalInstance",
				desc = "CharInfo.MASLENGO.journalInstance = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.journalInstance= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			LFGInstance = {
				type = "execute",
				name = "LFGInstance",
				desc = "CharInfo.MASLENGO.LFGInstance = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.LFGInstance= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ListOfQuests = {
				type = "execute",
				name = "ListOfQuests",
				desc = "CharInfo.MASLENGO.ListOfQuests = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.ListOfQuests= {}
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
						CharInfo.MASLENGO.OctoTable_QuestID= {}
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
						CharInfo.MASLENGO.professions= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Reputation = {
				type = "execute",
				name = "Reputation",
				desc = "CharInfo.MASLENGO.Reputation = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.Reputation= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			SavedWorldBoss = {
				type = "execute",
				name = "SavedWorldBoss",
				desc = "CharInfo.MASLENGO.SavedWorldBoss = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.SavedWorldBoss= {}
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
						CharInfo.MASLENGO.UniversalQuest= {}
					end
					return
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},


			-------------------------------------------------
			GARRISON = {
				type = "execute",
				name = "GARRISON",
				desc = "CharInfo.GARRISON = {}",
				func = function()
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						-- CharInfo.GARRISON = {}
						CharInfo.GARRISON = nil
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
					if Octo_MainFrame_SpeedFrame then
						Octo_MainFrame_SpeedFrame:SetShown(value)
					end
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
					if Octo_MainFrame_SellFrame1 then
						Octo_MainFrame_SellFrame1:SetShown(value)
					end
					if Octo_MainFrame_SellFrame2 then
						Octo_MainFrame_SellFrame2:SetShown(value)
					end
					if Octo_MainFrame_SellFrame3 then
						Octo_MainFrame_SellFrame3:SetShown(value)
					end
					if Octo_MainFrame_SellFrame4 then
						Octo_MainFrame_SellFrame4:SetShown(value)
					end
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
			DebugGossip = {
				type = "toggle",
				name = "DebugGossip",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.DebugGossip
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugGossip = value
					E.DebugGossip = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			DebugCache = {
				type = "toggle",
				name = "DebugCache",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.DebugCache
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DebugCache = value
					E.DebugCache = value
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
		},
	}
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	local function add_args_recursive(tbl, parent_path, current_depth, max_depth)
	    if max_depth and current_depth > max_depth then return end
	    local key, value = next(tbl)
	    while key do
	        if type(value) == "table" and type(key) ~= "table" then
	            local order = GetOrder()
	            local str_key = tostring(key)
	            local path = parent_path.."."..str_key
	            Debug.args[str_key..order] = {
	                type = "execute",
	                name = (max_depth and current_depth == max_depth) and "|cffff0000"..str_key.."|r"  -- Красный для последнего уровня
	                or "|cffFFF371"..str_key.."|r",  -- Жёлтый для остальных
	                desc = path.." = {}",
	                order = order,
	                width = E.FULL_WIDTH/4,
	                func = (function(k)  -- Создаем новое замыкание для сохранения значения key
	                    return function()
	                        tbl[k] = nil
	                    end
	                end)(key),  -- Передаем текущее значение key в замыкание
	            }
	            add_args_recursive(value, path, current_depth + 1, max_depth)
	        end
	        key, value = next(tbl, key)
	    end
	end
	local function add_args(tbl, name, max_depth)
		local header_order = GetOrder()
		Debug.args[name..header_order] = {
			type = "header",
			name = "",
			order = header_order,
		}
		local execute_order = GetOrder()
		Debug.args[name..execute_order] = {
			type = "execute",
			name = max_depth and "|cff00BFFF"..name.."|r"  -- Голубой, если есть ограничение глубины
			or "|cff4fff79"..name.."|r",  -- Зеленый, если рекурсия без лимита
			desc = name.." = {}",
			order = execute_order,
			width = E.FULL_WIDTH,
			func = function()
				wipe(tbl)
				tbl = nil
			end,
		}
		add_args_recursive(tbl, name, 1, max_depth)
	end
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	add_args(Octo_ToDo_DB_Levels, "Octo_ToDo_DB_Levels", 0)  -- 1
	add_args(Octo_ToDo_DB_Vars, "Octo_ToDo_DB_Vars")
	add_args(Octo_ToDo_DB_Other, "Octo_ToDo_DB_Other")
	add_args(Octo_Cache_DB, "Octo_Cache_DB", 1) -- FALSE

	add_args(Octo_Achievements_DB, "Octo_Achievements_DB")

	add_args(Octo_AddonsManager_DB, "Octo_AddonsManager_DB")
	add_args(Octo_AddonsTable_DB, "Octo_AddonsTable_DB", 1) -- 1

	add_args(Octo_Debug_DB, "Octo_Debug_DB")

	add_args(Octo_LoadAddons_DB, "Octo_LoadAddons_DB")

	add_args(Octo_Minecraft_DB, "Octo_Minecraft_DB")

	add_args(Octo_Moduls_DB, "Octo_Moduls_DB")

	add_args(Octo_QuestsChanged_DB, "Octo_QuestsChanged_DB", 1) -- 1
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	return Debug
end