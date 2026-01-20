local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_02_Colors(width, tabName)
	-------------------------------------------------
	-- Вкладка: Цвета
	-------------------------------------------------
	local tbl = {
		type = "group",
		name = tabName,
		order = E.func_GetOrder(),
		args = {
			-------------------------------------------------
			-- Основные
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = " ", -- L["Main Frame"], -- GRAPHICS_LABEL GENERAL_LABEL
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = L["Main Frame Color"],
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = L["Tooltip Color"],
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.TOOLTIP_TooltipFrame
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.TOOLTIP_TooltipFrame = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "toggle",
					-- 	name = L["By Faction"],
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseFaction_CONFIG
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseFaction_CONFIG = value
					-- 		if value then
					-- 			Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseClass_CONFIG = false
					-- 		end
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "toggle",
					-- 	name = L["By Class"],
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseClass_CONFIG
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseClass_CONFIG = value
					-- 		if value then
					-- 			Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame_UseFaction_CONFIG = false
					-- 		end
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "range",
					-- 	name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
					-- 	min = 0,
					-- 	max = 1,
					-- 	step = .01,
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame.a
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_MainFrame.a = value
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = L["Border Color"],
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.MAIN_Border
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.MAIN_Border = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "toggle",
					-- 	name = L["By Faction"],
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseFaction_CONFIG
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseFaction_CONFIG = value
					-- 		if value then
					-- 			Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseClass_CONFIG = false
					-- 		end
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-- -------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "toggle",
					-- 	name = L["By Class"],
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseClass_CONFIG
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseClass_CONFIG = value
					-- 		if value then
					-- 			Octo_ToDo_DB_Vars.Colors.MAIN_Border_UseFaction_CONFIG = false
					-- 		end
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-- -------------------------------------------------
					-- [E.func_AutoKey()] = {
					-- 	type = "range",
					-- 	name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
					-- 	min = 0,
					-- 	max = 1,
					-- 	step = .01,
					-- 	get = function()
					-- 		return Octo_ToDo_DB_Vars.Colors.MAIN_Border.a
					-- 	end,
					-- 	set = function(_, value)
					-- 		Octo_ToDo_DB_Vars.Colors.MAIN_Border.a = value
					-- 		E.func_UpdateGlobals()
					-- 	end,
					-- 	width = width,
					-- 	order = E.func_GetOrder(),
					-- },
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "header",
						name = L["Header Color"], -- L["Header"],
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = CUSTOM,
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.CharHeader
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.CharHeader = {r = r, g = g, b = b, a = a}
							E.CharHeader = Octo_ToDo_DB_Vars.Colors.CharHeader
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Faction"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharHeader_UseFaction_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharHeader_UseFaction_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.CharHeader_UseClass_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Class"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharHeader_UseClass_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharHeader_UseClass_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.CharHeader_UseFaction_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
						min = 0,
						max = 1,
						step = .01,
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharHeader.a
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharHeader.a = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "header",
						name = L["Character Highlight Color"], -- L["Character Highlight"],
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = CUSTOM,
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.CharLines
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.CharLines = {r = r, g = g, b = b, a = a}
							E.CharLines = Octo_ToDo_DB_Vars.Colors.CharLines
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Faction"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharLines_UseFaction_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharLines_UseFaction_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.CharLines_UseClass_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Class"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharLines_UseClass_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharLines_UseClass_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.CharLines_UseFaction_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
						min = 0,
						max = 1,
						step = .01,
						get = function()
							return Octo_ToDo_DB_Vars.Colors.CharLines.a
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.CharLines.a = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "header",
						name = L["Row Highlight Color"], -- L["Row Highlight"],
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = CUSTOM,
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Highlight
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Highlight = {r = r, g = g, b = b, a = a}
							E.Highlight = Octo_ToDo_DB_Vars.Colors.Highlight
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Faction"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.Highlight_UseFaction_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.Highlight_UseFaction_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.Highlight_UseClass_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["By Class"],
						get = function()
							return Octo_ToDo_DB_Vars.Colors.Highlight_UseClass_CONFIG
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.Highlight_UseClass_CONFIG = value
							if value then
								Octo_ToDo_DB_Vars.Colors.Highlight_UseFaction_CONFIG = false
							end
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "range",
						name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
						min = 0,
						max = 1,
						step = .01,
						get = function()
							return Octo_ToDo_DB_Vars.Colors.Highlight.a
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.Colors.Highlight.a = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
				}
			},
			-------------------------------------------------
			-- Градиент
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = L["Gradient"],
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Gradient"],
						desc = CURSOR_SIZE_DEFAULT..": "..YES.."|n|n"..L["Use gradient values in tooltip"],
						get = function()
							return Octo_ToDo_DB_Vars.TOOLTIP_usegradient
						end,
						set = function(_, value)
							Octo_ToDo_DB_Vars.TOOLTIP_usegradient = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = "max",
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.TOOLTIP_max_RGBA
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.TOOLTIP_max_RGBA = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = "mid",
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.TOOLTIP_mid_RGBA
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.TOOLTIP_mid_RGBA = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = "min",
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.TOOLTIP_min_RGBA
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.TOOLTIP_min_RGBA = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
				},
			},
			-------------------------------------------------
			-- Репутация
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = REPUTATION,
				inline = true,
				order = E.func_GetOrder(),
				args = {
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..1, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[1]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[1] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..2, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[2]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[2] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..3, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[3]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[3] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..4, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[4]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[4] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..5, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[5]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[5] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..6, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[6]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[6] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..7, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[7]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[7] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = GetText("FACTION_STANDING_LABEL"..8, UnitSex("PLAYER")),
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Standard[8]
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Standard[8] = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					[E.func_AutoKey()] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = "Rep_Friend",
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Friend
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Friend = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = "Rep_Major",
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Major
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Major = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = L["Paragon"],
						hasAlpha = true,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.Rep_Paragon
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.Rep_Paragon = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
				},
			},
			-------------------------------------------------
			-- Фракция
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = FACTION,
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = FACTION_HORDE,
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.faction_Horde
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.faction_Horde = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = FACTION_ALLIANCE,
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.faction_Alliance
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.faction_Alliance = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = FACTION_NEUTRAL,
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.faction_Neutral
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.faction_Neutral = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
				},
			},
			-------------------------------------------------
			-- Обитель ковенанта
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "group",
				name = GARRISON_TYPE_9_0_LANDING_PAGE_TITLE,
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = E.func_CovenantName(1), -- KYRIAN
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.KYRIAN
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.KYRIAN = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = E.func_CovenantName(2), -- VENTHYR
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.VENTHYR
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.VENTHYR = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = E.func_CovenantName(3), -- NIGHTFAE
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.NIGHTFAE
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.NIGHTFAE = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = E.func_CovenantName(4), -- NECROLORD
						hasAlpha = false,
						get = function()
							local color = Octo_ToDo_DB_Vars.Colors.NECROLORD
							local r, g, b, a = color.r, color.g, color.b, color.a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							Octo_ToDo_DB_Vars.Colors.NECROLORD = {r = r, g = g, b = b, a = a}
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
				},
			},
			-------------------------------------------------
			-- Сброс цвета
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "execute",
				name = SETTINGS_DEFAULTS,
				desc = L["Reset Color Settings"],
				confirm = true,
				confirmText = L["Are you sure?"],
				func = function()
					wipe(Octo_ToDo_DB_Vars.Colors)
					-- Octo_ToDo_DB_Vars.Colors = nil
					E.init_Octo_ToDo_DB_Vars()
					E.func_UpdateGlobals()
					return
				end,
				width = width,
				order = E.func_GetOrder(),
			},
			-------------------------------------------------
		},
	}
	return tbl
end