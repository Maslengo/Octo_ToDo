local GlobalAddonName, E = ...
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
function E.func_DevTool_Options(savedVars)
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Options = {
		type = "group",
		childGroups = "tab",
		name = E.func_AddonNameForOptionsFunc(GlobalAddonName), -- BINDING_HEADER_DEBUG
		args = {
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
				desc = "ВООБЩЕ ВСЁ",
				func = function()
						wipe(Octo_profileKeys)
						wipe(Octo_ToDo_DB_Levels)
						wipe(Octo_ToDo_DB_Vars)
						wipe(Octo_Cache_DB)
						wipe(Octo_DevTool_DB)

						Octo_profileKeys = nil
						Octo_ToDo_DB_Levels = nil
						Octo_ToDo_DB_Vars = nil
						Octo_Cache_DB = nil
						Octo_DevTool_DB = nil
					-- for _, tbl in ipairs(E.OctoTable_SavedVariables) do
					-- 	print (tbl.name)
					-- 	wipe(tbl)
					-- end
					return --ReloadUI()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			MASLENGO = {
				type = "execute",
				name = DELETE.." ".."MASLENGO",
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
			["Header"..GetOrder()] = {
				type = "header",
				name = OTHER,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_SPAM_TIME = {
				type = "range",
				name = "Config_SPAM_TIME",
				desc = "",
				min = 2,
				max = 10,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_SPAM_TIME
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_SPAM_TIME = value
					E.SPAM_TIME = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},

			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_ALL = {
				type = "toggle",
				name = E.COLOR_BLUE.."Config_DebugID_ALL|r",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_ALL
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_ALL = value
					E.Config_DebugID_ALL = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Items = {
				type = "toggle",
				name = "Config_DebugID_Items",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Items
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Items = value
					E.Config_DebugID_Items = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Currencies = {
				type = "toggle",
				name = "Config_DebugID_Currencies",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Currencies
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Currencies = value
					E.Config_DebugID_Currencies = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_NPCs = {
				type = "toggle",
				name = "Config_DebugID_NPCs",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_NPCs
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_NPCs = value
					E.Config_DebugID_NPCs = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Quests = {
				type = "toggle",
				name = "Config_DebugID_Quests",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Quests
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Quests = value
					E.Config_DebugID_Quests = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Reputations = {
				type = "toggle",
				name = "Config_DebugID_Reputations",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Reputations
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Reputations = value
					E.Config_DebugID_Reputations = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Spells = {
				type = "toggle",
				name = "Config_DebugID_Spells",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Spells
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Spells = value
					E.Config_DebugID_Spells = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Achievements = {
				type = "toggle",
				name = "Config_DebugID_Achievements",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Achievements
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Achievements = value
					E.Config_DebugID_Achievements = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Mounts = {
				type = "toggle",
				name = "Config_DebugID_Mounts",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Mounts
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Mounts = value
					E.Config_DebugID_Mounts = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Maps = {
				type = "toggle",
				name = "Config_DebugID_Maps",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Maps
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Maps = value
					E.Config_DebugID_Maps = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Events = {
				type = "toggle",
				name = "Config_DebugID_Events",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Events
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Events = value
					E.Config_DebugID_Events = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_Professions = {
				type = "toggle",
				name = "Config_DebugID_Professions",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_Professions
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_Professions = value
					E.Config_DebugID_Professions = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_instanceID = {
				type = "toggle",
				name = "Config_DebugID_instanceID",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_instanceID
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_instanceID = value
					E.Config_DebugID_instanceID = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_DebugID_worldBossID = {
				type = "toggle",
				name = "Config_DebugID_worldBossID",
				desc = "",
				get = function()
					return Octo_DevTool_DB.Config_DebugID_worldBossID
				end,
				set = function(_, value)
					Octo_DevTool_DB.Config_DebugID_worldBossID = value
					E.Config_DebugID_worldBossID = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},

			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			DebugCharacterInfo = {
				type = "toggle",
				name = "DebugCharacterInfo",
				desc = "",
				get = function()
					return Octo_DevTool_DB.DebugCharacterInfo
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugCharacterInfo = value
					E.DebugCharacterInfo = value
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
					return Octo_DevTool_DB.DebugEvent
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugEvent = value
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
					return Octo_DevTool_DB.DebugFunction
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugFunction = value
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
					return Octo_DevTool_DB.DebugButton
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugButton = value
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
					return Octo_DevTool_DB.DebugGossip
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugGossip = value
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
					return Octo_DevTool_DB.DebugCache
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugCache = value
					E.DebugCache = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			DebugQC_Vignettes = {
				type = "toggle",
				name = "DebugQC_Vignettes",
				desc = "",
				get = function()
					return Octo_DevTool_DB.DebugQC_Vignettes
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugQC_Vignettes = value
					E.DebugQC_Vignettes = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			DebugQC_Quests = {
				type = "toggle",
				name = "DebugQC_Quests",
				desc = "",
				get = function()
					return Octo_DevTool_DB.DebugQC_Quests
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugQC_Quests = value
					E.DebugQC_Quests = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			DebugUniversal = {
				type = "toggle",
				name = "DebugUniversal",
				desc = "",
				get = function()
					return Octo_DevTool_DB.DebugUniversal
				end,
				set = function(_, value)
					Octo_DevTool_DB.DebugUniversal = value
					E.DebugUniversal = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			["editorFontSize"] = {
				type = "select",
				name = "editorFontSize",
				values = (function()
					local t = {}
					for i = 10, 16 do
						t[i] = i
					end
					return t
				end)(),
				desc = "",
				get = function()
					return Octo_DevTool_DB.editorFontSize
				end,
				set = function(_, value)
					Octo_DevTool_DB.editorFontSize = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["editorTabSpaces"] = {
				type = "select",
				name = "editorTabSpaces",
				values = (function()
					local t = {}
					for _, v in ipairs({0, 2, 3, 4}) do
						t[v] = v
					end
					return t
				end)(),
				desc = "",
				get = function()
					return Octo_DevTool_DB.editorTabSpaces
				end,
				set = function(_, value)
					Octo_DevTool_DB.editorTabSpaces = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["editorTheme"] = {
				type = "select",
				name = "editorTheme",
				values = (function()
					local t, keys = {}, {}
					for k in pairs(E.editorThemes) do
						table.insert(keys, k)
					end
					table.sort(keys)
					for i, k in ipairs(keys) do
						t[i] = k
					end
					return t
				end)(),
				desc = "",
				get = function()
					return Octo_DevTool_DB.editorTheme
				end,
				set = function(_, value)
					Octo_DevTool_DB.editorTheme = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	-- for index = 10, 16 do
	-- Options.args.editorFontSize.values[index] = index
	-- end
	-- for index, v in ipairs({0, 2, 3, 4}) do
	-- Options.args.editorTabSpaces.values[index] = index
	-- end
	-- local countET = 0
	-- for name in next, (E.editorThemes) do
	-- countET = countET + 1
	-- Options.args.editorTheme.values[countET] = name
	-- end
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
				Options.args[str_key..order] = {
					type = "execute",
					name = (max_depth and current_depth == max_depth) and "|cffff0000"..str_key.."|r" -- Красный для последнего уровня
					or "|cffFFF371"..str_key.."|r", -- Жёлтый для остальных
					desc = path.." = {}",
					order = order,
					width = E.FULL_WIDTH/4,
					func = (function(k) -- Создаем новое замыкание для сохранения значения key
						return function()
							tbl[k] = nil
						end
					end)(key), -- Передаем текущее значение key в замыкание
				}
				add_args_recursive(value, path, current_depth + 1, max_depth)
			end
			key, value = next(tbl, key)
		end
	end
	local function add_args(tbl, name, max_depth)
		if tbl then
			local header_order = GetOrder()
			Options.args[name..header_order] = {
				type = "header",
				name = "",
				order = header_order,
			}
			local execute_order = GetOrder()
			Options.args[name..execute_order] = {
				type = "execute",
				name = max_depth and "|cff00BFFF"..name.."|r" -- Голубой, если есть ограничение глубины
				or "|cff4fff79"..name.."|r", -- Зеленый, если рекурсия без лимита
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
	end
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	add_args(Octo_ToDo_DB_Levels, "Octo_ToDo_DB_Levels", 0)
	add_args(Octo_ToDo_DB_Vars, "Octo_ToDo_DB_Vars")
	add_args(Octo_Cache_DB, "Octo_Cache_DB", 1)
	add_args(Octo_DevTool_DB, "Octo_DevTool_DB")
	add_args(Octo_Minecraft_DB, "Octo_Minecraft_DB")
	if Octo_Moduls_DB then
		add_args(Octo_Moduls_DB, "Octo_Moduls_DB")
	end
	add_args(Octo_profileKeys, "Octo_profileKeys", 1)
	-- add_args(Octo_QuestsChanged_DB, "Octo_QuestsChanged_DB", 1)
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	return Options
end