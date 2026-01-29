local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_01_General(width, tabName)
	-------------------------------------------------
	-- Вкладка: Основные настройки
	-------------------------------------------------
	local tbl = {
		type = "group",
		name = tabName,
		order = E.func_GetOrder(),
		args = {
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = L["Font"],
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						name = L["Default Font"],
						type = "input",
						control = "OctoMediaFont",
						get = function()
							return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
						end,
						set = function(tbl, value)
							if value then
								Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = value
								E.func_UpdateGlobals()
							end
						end,
						-- set = function(_, value)
						--     Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = value
						--     E.func_UpdateGlobals()
						-- end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					-- [E.func_AutoKey()] = {
					--     name = L["Font"],
					--     type = "select",
					--     dialogControl = "LSM30_Font",
					--     values = LibSharedMedia:HashTable("font"),
					--     get = function()
					--         return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
					--     end,
					--     set = function(_, value)
					--         Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = value
					--         E.func_UpdateGlobals()
					--     end,
					--     width = width,
					--     order = E.func_GetOrder(),
					-- },
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = FONT_SIZE,
						min = 8,
						max = 32,
						step = 1,
						get = function()
							return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "select",
						name = L["Font Outline"], -- L["Font Flags"],
						values = {
							[""] = NPC_NAMES_DROPDOWN_NONE,
							["MONOCHROME"] = "MONOCHROME",
							["OUTLINE"] = "OUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE",
							["MONOCHROME, OUTLINE"] = "MONOCHROME, OUTLINE",
							["MONOCHROME, THICKOUTLINE"] = "MONOCHROME, THICKOUTLINE",
						},
						get = function()
							return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
				}
			},
			[E.func_AutoKey()] = {
				type = "group",
				name = " ",
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "select",
						name = L["Number Format"],
						values = {
							[1] = L["Universal"], -- "Универсальный"
							[2] = L["Localized"], -- "Локализованный"
							[3] = L["With separators"], -- "С разделителями"
							[4] = L["Full"], -- "Полный"
							[5] = "Blizzard", -- "Blizzard"
							[6] = L["Clean"], -- "Минималистичный"
						},
						get = function()
							return Octo_ToDo_DB_Vars.Config_numberFormatMode
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_numberFormatMode = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = E.COLOR_RED..">|r"..L["Line Height"]..E.COLOR_RED.."<|r",
						desc = CURSOR_SIZE_DEFAULT..": 20|n|n"..E.COLOR_RED..L["Changes require a ReloadUI"].."|r",
						min = 10,
						max = 50,
						step = 1,
						get = function()
							return Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT = value
							E.GLOBAL_LINE_HEIGHT = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Clamped To Screen"],
						desc = CURSOR_SIZE_DEFAULT..": "..NO,
						get = function()
							return Octo_ToDo_DB_Vars.Config_ClampedToScreen
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_ClampedToScreen = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Отладка
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = L["Tooltip"],
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = E.func_texturefromIcon(E.ATLAS_RAID, nil, nil, true) .. L["All Difficulties"],
						desc = CURSOR_SIZE_DEFAULT..": "..NO .. "|n|n" .. L["Shows all raid difficulties in the tooltip"],
						get = function()
							return Octo_ToDo_DB_Vars.Config_ShowAllDifficulties
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_ShowAllDifficulties = value
							E.Config_ShowAllDifficulties = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = E.func_texturefromIcon(E.ATLAS_RAID, nil, nil, true) .. L["Abbreviation"],
						desc = CURSOR_SIZE_DEFAULT..": "..YES.."|n|n"..L["Use English abbreviations for raid and dungeon difficulties instead of full names"],
						get = function()
							return Octo_ToDo_DB_Vars.Config_DifficultyAbbreviation
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_DifficultyAbbreviation = value
							E.Config_DifficultyAbbreviation = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
				},
			},
			-------------------------------------------------
			-- Вкладка: Отображение персонажей
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = L["Characters"], -- FILTERS,
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = L["Min. Level"],
						desc = CURSOR_SIZE_DEFAULT..": 1",
						min = 1,
						max = 90,
						step = 1,
						get = function()
							return Octo_ToDo_DB_Vars.Config_LevelToShow
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_LevelToShow = value
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = L["Max. Level"],
						desc = CURSOR_SIZE_DEFAULT..": 90",
						min = 1,
						max = 90,
						step = 1,
						get = function()
							return Octo_ToDo_DB_Vars.Config_LevelToShowMAX
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_LevelToShowMAX = value
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
					-------------------------------------------------

					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Only Current Server"],
						desc = CURSOR_SIZE_DEFAULT..": "..NO,
						get = function()
							return Octo_ToDo_DB_Vars.isOnlyCurrentServer
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.isOnlyCurrentServer = value
							-- E.isOnlyCurrentServer = value
							-- E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------

					[E.func_AutoKey()] = {
						type = "toggle",
						name = function()
							local result = ""
							if E.FACTION_CURRENT == "Horde" then
								result = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
							else
								result = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
							end
							return result
						end,
						desc = CURSOR_SIZE_DEFAULT..": "..NO,
						get = function()
							return Octo_ToDo_DB_Vars.isOnlyCurrentFaction
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.isOnlyCurrentFaction = value
							-- E.isOnlyCurrentFaction = value
							-- E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------

					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Only Current Region"],
						desc = CURSOR_SIZE_DEFAULT..": "..YES,
						get = function()
							return Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = value
							-- E.ShowOnlyCurrentRegion = value
							-- E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------







				},
			},
			-------------------------------------------------
			-- Отладка
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = BINDING_HEADER_DEBUG,
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Show ID"],
						desc = CURSOR_SIZE_DEFAULT..": "..NO,
						get = function()
							return Octo_ToDo_DB_Vars.Config_DebugID_ALL
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Config_DebugID_ALL = value
							E.Config_DebugID_ALL = value
						end,
						width = width,
						order = E.func_GetOrder(),
					},
				},
			},
		},
	}
	return tbl
end
