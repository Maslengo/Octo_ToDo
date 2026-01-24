local GlobalAddonName, E = ...
local L = E.L

E.TEXT_INDEV = E.COLOR_RED..">>> "..L["In Development"].." <<<|r"
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
			-- Сброс цвета
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "select",
				name = L["Profiles"],
				desc = E.TEXT_INDEV,
				values = function()
					local t = {}
					local names = {}
					for name in pairs(Octo_profileColors.profiles) do
						names[#names + 1] = name
					end
					table.sort(names)
					for _, name in ipairs(names) do
						t[name] = name
					end
					return t
				end,
				get = function()
					return Octo_profileColors.Current_profileColors
				end,
				set = function(_, value)
					Octo_profileColors.Current_profileColors = value
					E.Current_profileColors = value
					E.func_CreateNew_profileColors(value)
					E.PROFTBL = Octo_profileColors.profiles[E.Current_profileColors]
					E.func_UpdateGlobals()
					-- local profileName = Octo_profileColors.Current_profileColors
					-- local profile = Octo_profileColors.profiles[profileName]
				end,
				width = width,
				order = E.func_GetOrder(),
			},
			[E.func_AutoKey()] = {
				type = "execute",
				name = SETTINGS_DEFAULTS,
				desc = E.TEXT_INDEV .. "|n|n".. L["Reset Color Settings"],
				confirm = true,
				confirmText = L["Are you sure?"],
				func = function()
					wipe(Octo_profileColors)
					E.init_Octo_profileColors()
					E.func_UpdateGlobals()
					return
				end,
				width = width,
				order = E.func_GetOrder(),
			},
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
							local r = E.PROFTBL.ConfigColor_MAIN_MainFrame_r
							local g = E.PROFTBL.ConfigColor_MAIN_MainFrame_g
							local b = E.PROFTBL.ConfigColor_MAIN_MainFrame_b
							local a = E.PROFTBL.ConfigColor_MAIN_MainFrame_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_MAIN_MainFrame_r = r
							E.PROFTBL.ConfigColor_MAIN_MainFrame_g = g
							E.PROFTBL.ConfigColor_MAIN_MainFrame_b = b
							E.PROFTBL.ConfigColor_MAIN_MainFrame_a = a
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
							local r = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_r
							local g = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_g
							local b = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_b
							local a = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_r = r
							E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_g = g
							E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_b = b
							E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_a = a
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = L["Border Color"],
						hasAlpha = true,
						get = function()
							local r = E.PROFTBL.ConfigColor_MAIN_Border_r
							local g = E.PROFTBL.ConfigColor_MAIN_Border_g
							local b = E.PROFTBL.ConfigColor_MAIN_Border_b
							local a = E.PROFTBL.ConfigColor_MAIN_Border_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_MAIN_Border_r = r
							E.PROFTBL.ConfigColor_MAIN_Border_g = g
							E.PROFTBL.ConfigColor_MAIN_Border_b = b
							E.PROFTBL.ConfigColor_MAIN_Border_a = a
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
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
							local r = E.PROFTBL.ConfigColor_CharHeader_r
							local g = E.PROFTBL.ConfigColor_CharHeader_g
							local b = E.PROFTBL.ConfigColor_CharHeader_b
							local a = E.PROFTBL.ConfigColor_CharHeader_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_CharHeader_r = r
							E.PROFTBL.ConfigColor_CharHeader_g = g
							E.PROFTBL.ConfigColor_CharHeader_b = b
							E.PROFTBL.ConfigColor_CharHeader_a = a
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
							return E.PROFTBL.ConfigColor_CharHeader_UseFaction_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharHeader_UseFaction_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_CharHeader_UseClass_CONFIG = false
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
							return E.PROFTBL.ConfigColor_CharHeader_UseClass_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharHeader_UseClass_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_CharHeader_UseFaction_CONFIG = false
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
							return E.PROFTBL.ConfigColor_CharHeader_a
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharHeader_a = value
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
							local r = E.PROFTBL.ConfigColor_CharLines_r
							local g = E.PROFTBL.ConfigColor_CharLines_g
							local b = E.PROFTBL.ConfigColor_CharLines_b
							local a = E.PROFTBL.ConfigColor_CharLines_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_CharLines_r = r
							E.PROFTBL.ConfigColor_CharLines_g = g
							E.PROFTBL.ConfigColor_CharLines_b = b
							E.PROFTBL.ConfigColor_CharLines_a = a
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
							return E.PROFTBL.ConfigColor_CharLines_UseFaction_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharLines_UseFaction_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_CharLines_UseClass_CONFIG = false
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
							return E.PROFTBL.ConfigColor_CharLines_UseClass_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharLines_UseClass_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_CharLines_UseFaction_CONFIG = false
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
							return E.PROFTBL.ConfigColor_CharLines_a
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_CharLines_a = value
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
							local r = E.PROFTBL.ConfigColor_Highlight_r
							local g = E.PROFTBL.ConfigColor_Highlight_g
							local b = E.PROFTBL.ConfigColor_Highlight_b
							local a = E.PROFTBL.ConfigColor_Highlight_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Highlight_r = r
							E.PROFTBL.ConfigColor_Highlight_g = g
							E.PROFTBL.ConfigColor_Highlight_b = b
							E.PROFTBL.ConfigColor_Highlight_a = a
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
							return E.PROFTBL.ConfigColor_Highlight_UseFaction_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_Highlight_UseFaction_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_Highlight_UseClass_CONFIG = false
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
							return E.PROFTBL.ConfigColor_Highlight_UseClass_CONFIG
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_Highlight_UseClass_CONFIG = value
							if value then
								E.PROFTBL.ConfigColor_Highlight_UseFaction_CONFIG = false
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
							return E.PROFTBL.ConfigColor_Highlight_a
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_Highlight_a = value
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "toggle",
						name = L["Smooth Animation"],
						desc = CURSOR_SIZE_DEFAULT..": "..NO,
						get = function()
							return E.PROFTBL.ConfigColor_ENABLE_HIGHLIGHT_ANIMATION
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_ENABLE_HIGHLIGHT_ANIMATION = value
							-- E.func_UpdateGlobals()
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
							return E.PROFTBL.ConfigColor_TOOLTIP_usegradient
						end,
						set = function(_, value)
							E.PROFTBL.ConfigColor_TOOLTIP_usegradient = value
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
							local r = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_r
							local g = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_g
							local b = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_b
							local a = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_r = r
							E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_g = g
							E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_b = b
							E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_a = a
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
							local r = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_r
							local g = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_g
							local b = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_b
							local a = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_r = r
							E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_g = g
							E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_b = b
							E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_a = a
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
							local r = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_r
							local g = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_g
							local b = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_b
							local a = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_r = r
							E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_g = g
							E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_b = b
							E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_1_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_1_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_1_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_1_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_1_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_1_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_1_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_1_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_2_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_2_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_2_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_2_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_2_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_2_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_2_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_2_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_3_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_3_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_3_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_3_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_3_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_3_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_3_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_3_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_4_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_4_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_4_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_4_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_4_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_4_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_4_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_4_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_5_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_5_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_5_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_5_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_5_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_5_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_5_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_5_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_6_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_6_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_6_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_6_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_6_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_6_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_6_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_6_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_7_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_7_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_7_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_7_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_7_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_7_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_7_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_7_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Standard_8_r
							local g = E.PROFTBL.ConfigColor_Rep_Standard_8_g
							local b = E.PROFTBL.ConfigColor_Rep_Standard_8_b
							local a = E.PROFTBL.ConfigColor_Rep_Standard_8_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Standard_8_r = r
							E.PROFTBL.ConfigColor_Rep_Standard_8_g = g
							E.PROFTBL.ConfigColor_Rep_Standard_8_b = b
							E.PROFTBL.ConfigColor_Rep_Standard_8_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Friend_r
							local g = E.PROFTBL.ConfigColor_Rep_Friend_g
							local b = E.PROFTBL.ConfigColor_Rep_Friend_b
							local a = E.PROFTBL.ConfigColor_Rep_Friend_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Friend_r = r
							E.PROFTBL.ConfigColor_Rep_Friend_g = g
							E.PROFTBL.ConfigColor_Rep_Friend_b = b
							E.PROFTBL.ConfigColor_Rep_Friend_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Major_r
							local g = E.PROFTBL.ConfigColor_Rep_Major_g
							local b = E.PROFTBL.ConfigColor_Rep_Major_b
							local a = E.PROFTBL.ConfigColor_Rep_Major_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Major_r = r
							E.PROFTBL.ConfigColor_Rep_Major_g = g
							E.PROFTBL.ConfigColor_Rep_Major_b = b
							E.PROFTBL.ConfigColor_Rep_Major_a = a
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
							local r = E.PROFTBL.ConfigColor_Rep_Paragon_r
							local g = E.PROFTBL.ConfigColor_Rep_Paragon_g
							local b = E.PROFTBL.ConfigColor_Rep_Paragon_b
							local a = E.PROFTBL.ConfigColor_Rep_Paragon_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_Rep_Paragon_r = r
							E.PROFTBL.ConfigColor_Rep_Paragon_g = g
							E.PROFTBL.ConfigColor_Rep_Paragon_b = b
							E.PROFTBL.ConfigColor_Rep_Paragon_a = a
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
							local r = E.PROFTBL.ConfigColor_faction_Horde_r
							local g = E.PROFTBL.ConfigColor_faction_Horde_g
							local b = E.PROFTBL.ConfigColor_faction_Horde_b
							local a = E.PROFTBL.ConfigColor_faction_Horde_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_faction_Horde_r = r
							E.PROFTBL.ConfigColor_faction_Horde_g = g
							E.PROFTBL.ConfigColor_faction_Horde_b = b
							E.PROFTBL.ConfigColor_faction_Horde_a = a
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
							local r = E.PROFTBL.ConfigColor_faction_Alliance_r
							local g = E.PROFTBL.ConfigColor_faction_Alliance_g
							local b = E.PROFTBL.ConfigColor_faction_Alliance_b
							local a = E.PROFTBL.ConfigColor_faction_Alliance_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_faction_Alliance_r = r
							E.PROFTBL.ConfigColor_faction_Alliance_g = g
							E.PROFTBL.ConfigColor_faction_Alliance_b = b
							E.PROFTBL.ConfigColor_faction_Alliance_a = a
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
							local r = E.PROFTBL.ConfigColor_faction_Neutral_r
							local g = E.PROFTBL.ConfigColor_faction_Neutral_g
							local b = E.PROFTBL.ConfigColor_faction_Neutral_b
							local a = E.PROFTBL.ConfigColor_faction_Neutral_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_faction_Neutral_r = r
							E.PROFTBL.ConfigColor_faction_Neutral_g = g
							E.PROFTBL.ConfigColor_faction_Neutral_b = b
							E.PROFTBL.ConfigColor_faction_Neutral_a = a
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
							local r = E.PROFTBL.ConfigColor_KYRIAN_r
							local g = E.PROFTBL.ConfigColor_KYRIAN_g
							local b = E.PROFTBL.ConfigColor_KYRIAN_b
							local a = E.PROFTBL.ConfigColor_KYRIAN_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_KYRIAN_r = r
							E.PROFTBL.ConfigColor_KYRIAN_g = g
							E.PROFTBL.ConfigColor_KYRIAN_b = b
							E.PROFTBL.ConfigColor_KYRIAN_a = a
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
							local r = E.PROFTBL.ConfigColor_VENTHYR_r
							local g = E.PROFTBL.ConfigColor_VENTHYR_g
							local b = E.PROFTBL.ConfigColor_VENTHYR_b
							local a = E.PROFTBL.ConfigColor_VENTHYR_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_VENTHYR_r = r
							E.PROFTBL.ConfigColor_VENTHYR_g = g
							E.PROFTBL.ConfigColor_VENTHYR_b = b
							E.PROFTBL.ConfigColor_VENTHYR_a = a
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
							local r = E.PROFTBL.ConfigColor_NIGHTFAE_r
							local g = E.PROFTBL.ConfigColor_NIGHTFAE_g
							local b = E.PROFTBL.ConfigColor_NIGHTFAE_b
							local a = E.PROFTBL.ConfigColor_NIGHTFAE_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_NIGHTFAE_r = r
							E.PROFTBL.ConfigColor_NIGHTFAE_g = g
							E.PROFTBL.ConfigColor_NIGHTFAE_b = b
							E.PROFTBL.ConfigColor_NIGHTFAE_a = a
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
							local r = E.PROFTBL.ConfigColor_NECROLORD_r
							local g = E.PROFTBL.ConfigColor_NECROLORD_g
							local b = E.PROFTBL.ConfigColor_NECROLORD_b
							local a = E.PROFTBL.ConfigColor_NECROLORD_a
							return r, g, b, a
						end,
						set = function(_, r, g, b, a)
							E.PROFTBL.ConfigColor_NECROLORD_r = r
							E.PROFTBL.ConfigColor_NECROLORD_g = g
							E.PROFTBL.ConfigColor_NECROLORD_b = b
							E.PROFTBL.ConfigColor_NECROLORD_a = a
							E.func_UpdateGlobals()
						end,
						width = width,
						order = E.func_GetOrder(),
					},
					-------------------------------------------------
				},
			},
			-------------------------------------------------
		},
	}
	return tbl
end