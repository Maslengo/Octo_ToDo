local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
function E.func_Options_DevTool(name, savedVars)
	local Options = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			-- Вкладка: Опасные действия
			-------------------------------------------------
			dangerousTab = {
				type = "group",
				name = "Опасные действия",
				order = E.func_GetOrder(),
				args = {
					Reload = {
						type = "execute",
						name = RELOADUI,
						func = function()
							return ReloadUI()
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
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
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					["Header1"] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
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
						order = E.func_GetOrder(),
					},
					["Header2"] = {
						type = "header",
						name = "Очистить подразделы MASLENGO",
						order = E.func_GetOrder(),
					},
					Currency = {
						type = "execute",
						name = "Currency",
						desc = "CharInfo.MASLENGO.Currency = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.Currency = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					GARRISON = {
						type = "execute",
						name = "GARRISON",
						desc = "CharInfo.MASLENGO.GARRISON = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.GARRISON = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					GreatVault = {
						type = "execute",
						name = "GreatVault",
						desc = "CharInfo.MASLENGO.GreatVault = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.GreatVault = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					HasGarrison = {
						type = "execute",
						name = "HasGarrison",
						desc = "CharInfo.MASLENGO.HasGarrison = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.HasGarrison = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					ItemsInBag = {
						type = "execute",
						name = "ItemsInBag",
						desc = "CharInfo.MASLENGO.ItemsInBag = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.ItemsInBag = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					journalInstance = {
						type = "execute",
						name = "journalInstance",
						desc = "CharInfo.MASLENGO.journalInstance = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.journalInstance = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					LFGInstance = {
						type = "execute",
						name = "LFGInstance",
						desc = "CharInfo.MASLENGO.LFGInstance = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.LFGInstance = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					ListOfQuests = {
						type = "execute",
						name = "ListOfQuests",
						desc = "CharInfo.MASLENGO.ListOfQuests = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.ListOfQuests = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					OctoTable_QuestID = {
						type = "execute",
						name = "OctoTable_QuestID",
						desc = "CharInfo.MASLENGO.OctoTable_QuestID = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.OctoTable_QuestID = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					professions = {
						type = "execute",
						name = "professions",
						desc = "CharInfo.MASLENGO.professions = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.professions = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					Reputation = {
						type = "execute",
						name = "Reputation",
						desc = "CharInfo.MASLENGO.Reputation = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.Reputation = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					SavedWorldBoss = {
						type = "execute",
						name = "SavedWorldBoss",
						desc = "CharInfo.MASLENGO.SavedWorldBoss = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.SavedWorldBoss = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					UniversalQuest = {
						type = "execute",
						name = "UniversalQuest",
						desc = "CharInfo.MASLENGO.UniversalQuest = {}",
						func = function()
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								CharInfo.MASLENGO.UniversalQuest = {}
							end
							return
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Вкладка: Настройки отладки
			-------------------------------------------------
			debugTab = {
				type = "group",
				name = "Отладка",
				order = E.func_GetOrder(),
				args = {
					Config_SPAM_TIME = {
						type = "range",
						name = "Config_SPAM_TIME",
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
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_CVAR = {
						type = "toggle",
						name = "Config_CVAR",
						get = function()
							return Octo_DevTool_DB.Config_CVAR
						end,
						set = function(_, value)
							Octo_DevTool_DB.Config_CVAR = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					["Header1"] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
					DebugCharacterInfo = {
						type = "toggle",
						name = "DebugCharacterInfo",
						get = function()
							return Octo_DevTool_DB.DebugCharacterInfo
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugCharacterInfo = value
							E.DebugCharacterInfo = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugReputationInfo = {
						type = "toggle",
						name = "DebugReputationInfo",
						get = function()
							return Octo_DevTool_DB.DebugReputationInfo
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugReputationInfo = value
							E.DebugReputationInfo = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugEvent = {
						type = "toggle",
						name = "DebugEvent",
						get = function()
							return Octo_DevTool_DB.DebugEvent
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugEvent = value
							E.DebugEvent = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugFunction = {
						type = "toggle",
						name = "DebugFunction",
						get = function()
							return Octo_DevTool_DB.DebugFunction
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugFunction = value
							E.DebugFunction = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugButton = {
						type = "toggle",
						name = "DebugButton",
						get = function()
							return Octo_DevTool_DB.DebugButton
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugButton = value
							E.DebugButton = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugGossip = {
						type = "toggle",
						name = "DebugGossip",
						get = function()
							return Octo_DevTool_DB.DebugGossip
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugGossip = value
							E.DebugGossip = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugCache = {
						type = "toggle",
						name = "DebugCache",
						get = function()
							return Octo_DevTool_DB.DebugCache
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugCache = value
							E.DebugCache = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugQC_Vignettes = {
						type = "toggle",
						name = "DebugQC_Vignettes",
						get = function()
							return Octo_DevTool_DB.DebugQC_Vignettes
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugQC_Vignettes = value
							E.DebugQC_Vignettes = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugQC_Quests = {
						type = "toggle",
						name = "DebugQC_Quests",
						get = function()
							return Octo_DevTool_DB.DebugQC_Quests
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugQC_Quests = value
							E.DebugQC_Quests = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					DebugUniversal = {
						type = "toggle",
						name = "DebugUniversal",
						get = function()
							return Octo_DevTool_DB.DebugUniversal
						end,
						set = function(_, value)
							Octo_DevTool_DB.DebugUniversal = value
							E.DebugUniversal = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Вкладка: Настройки редактора
			-------------------------------------------------
			editorTab = {
				type = "group",
				name = "Редактор",
				order = E.func_GetOrder(),
				args = {
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
						get = function()
							return Octo_DevTool_DB.editorFontSize
						end,
						set = function(_, value)
							Octo_DevTool_DB.editorFontSize = value
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
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
						get = function()
							return Octo_DevTool_DB.editorTabSpaces
						end,
						set = function(_, value)
							Octo_DevTool_DB.editorTabSpaces = value
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
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
						get = function()
							return Octo_DevTool_DB.editorTheme
						end,
						set = function(_, value)
							Octo_DevTool_DB.editorTheme = value
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Вкладка: Управление данными (рекурсивные кнопки)
			-------------------------------------------------
			dataManagementTab = {
				type = "group",
				name = "Управление данными",
				order = E.func_GetOrder(),
				args = {},
			},
		},
	}
	-------------------------------------------------
	-- Функция для добавления рекурсивных кнопок
	-------------------------------------------------
	local function add_args_recursive(tbl, parent_path, current_depth, max_depth)
		if max_depth and current_depth > max_depth then return end
		local key, value = next(tbl)
		while key do
			if type(value) == "table" and type(key) ~= "table" then
				local order = E.func_GetOrder()
				local str_key = tostring(key)
				local path = parent_path.."."..str_key
				Options.args.dataManagementTab.args[str_key..order] = {
					type = "execute",
					name = (max_depth and current_depth == max_depth) and "|cffff0000"..str_key.."|r"
					or "|cffFFF371"..str_key.."|r",
					desc = path.." = {}",
					order = order,
					width = E.FOURTH_WIDTH,
					func = (function(k)
							return function()
								tbl[k] = nil
							end
					end)(key),
				}
				add_args_recursive(value, path, current_depth + 1, max_depth)
			end
			key, value = next(tbl, key)
		end
	end
	local function add_args(tbl, name, max_depth)
		if tbl then
			local header_order = E.func_GetOrder()
			Options.args.dataManagementTab.args[name..header_order] = {
				type = "header",
				name = "",
				order = header_order,
			}
			local execute_order = E.func_GetOrder()
			Options.args.dataManagementTab.args[name..execute_order] = {
				type = "execute",
				name = max_depth and "|cff00BFFF"..name.."|r"
				or "|cff4fff79"..name.."|r",
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
	-- Добавляем все рекурсивные кнопки в вкладку управления данными
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
	-------------------------------------------------
	return Options
end