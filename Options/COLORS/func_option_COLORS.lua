local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_option_COLORS(width, tabName)
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
					return Octo_profileColors.Current_profile
				end,
				set = function(_, value)
					Octo_profileColors.Current_profile = value
					E.func_UpdateGlobals()
				end,
				width = width,
				order = E.func_GetOrder(),
			},
			[E.func_AutoKey()] = {
				type = "execute",
				name = L["SETTINGS_DEFAULTS"],
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
						name = L["CUSTOM"],
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
						name = L["CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL"],
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
						name = L["CUSTOM"],
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
						name = L["CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL"],
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
						name = L["CUSTOM"],
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
						name = L["CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL"],
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
						desc = L["CURSOR_SIZE_DEFAULT"]..": "..L["NO"],
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
						desc = L["CURSOR_SIZE_DEFAULT"]..": "..L["YES"].."|n|n"..L["Use gradient values in tooltip"],
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
						name = L["FACTION_HORDE"],
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
						name = L["FACTION_ALLIANCE"],
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
						name = L["FACTION_NEUTRAL"],
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
				name = L["GARRISON_TYPE_9_0_LANDING_PAGE_TITLE"],
				inline = true,
				order = E.func_GetOrder(),
				args = {
					-------------------------------------------------
					[E.func_AutoKey()] = {
						type = "color",
						name = E.func_GetName("covenant", 1), -- KYRIAN
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
						name = E.func_GetName("covenant", 2), -- VENTHYR
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
						name = E.func_GetName("covenant", 3), -- NIGHTFAE
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
						name = E.func_GetName("covenant", 4), -- NECROLORD
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