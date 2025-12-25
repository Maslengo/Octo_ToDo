local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
-- Переводы для названия настройки
local NumberFormatSettingName = {
	enUS = "Number Format",
	ruRU = "Формат чисел",
	deDE = "Zahlenformat",
	frFR = "Format des nombres",
	esES = "Formato numérico",
	esMX = "Formato numérico",
	ptBR = "Formato numérico",
	itIT = "Formato numerico",
	zhCN = "数字格式",
	zhTW = "數字格式",
	koKR = "숫자 형식",
}
-- Пример применения
local settingName = NumberFormatSettingName[E.curLocaleLang] or NumberFormatSettingName["enUS"]
-------------------------------------------------------------------------
function E.func_Octo_Options(savedVars)
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Options = {
		type = "group",
		childGroups = "tree",
		name = E.func_AddonNameForOptionsFunc(GlobalAddonName),
		args = {
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			["Config_numberFormatMode"] = {
				type = "select",
				name = settingName, -- L["Number Format"],
				values = {},
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_numberFormatMode
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_numberFormatMode = value
				end,
				width = E.FULL_WIDTH/3,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = L["Font settings"],
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_FontStyle = {
				name = L["Font"],
				type = "select",
				dialogControl = "LSM30_Font",
				values = LibSharedMedia:HashTable("font"),
				get = function()
					return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = value
					E.func_UpdateFont()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_FontSize = {
				type = "range",
				name = L["Font Size"],
				desc = "",
				min = 8,
				max = 32,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = value
					E.func_UpdateFont()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Config_FontFlags"] = {
				type = "select",
				name = L["Font Flags"],
				values = {},
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = value
					E.func_UpdateFont()
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			-- Config_Texture = {
			-- name = "Texture",
			-- type = "select",
			-- dialogControl = "LSM30_Statusbar",
			-- values = LibSharedMedia:HashTable("statusbar"),
			-- get = function()
			-- return Octo_ToDo_DB_Vars.Config_Texture
			-- end,
			-- set = function(_, value)
			-- Octo_ToDo_DB_Vars.Config_Texture = value
			-- end,
			-- width = E.FULL_WIDTH/4,
			-- order = GetOrder(),
			-- },
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = CINEMATIC_SUBTITLES_BACKGROUND_OPACITY_OPTION_LABEL,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_REPUTATION_ALPHA = {
				type = "range",
				name = E.COLOR_RED..">|r"..L["Reputation Background"]..E.COLOR_RED.."<|r",
				desc = CURSOR_SIZE_DEFAULT..": 0.3|n|n"..E.COLOR_RED..L["Changes require a ReloadUI"].."|r",
				min = 0,
				max = 1,
				step = .1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_REPUTATION_ALPHA
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_REPUTATION_ALPHA = value
					E.REPUTATION_ALPHA = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_CHARACTER_ALPHA = {
				type = "range",
				name = E.COLOR_RED..">|r"..L["Character Background"]..E.COLOR_RED.."<|r",
				desc = CURSOR_SIZE_DEFAULT..": 0.2|n|n"..E.COLOR_RED..L["Changes require a ReloadUI"].."|r",
				min = 0,
				max = 1,
				step = .1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_CHARACTER_ALPHA
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_CHARACTER_ALPHA = value
					E.CHARACTER_ALPHA = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_MAINBACKGROUND_ALPHA = {
				type = "range",
				name = L["Addon Background"],
				desc = CURSOR_SIZE_DEFAULT..": 0.8",
				min = 0,
				max = 1,
				step = .1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_MAINBACKGROUND_ALPHA
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_MAINBACKGROUND_ALPHA = value
					E.MAINBACKGROUND_ALPHA = value
							 Octo_MainFrame_ToDo_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA) -- E.backgroundColorA
					Octo_MainFrame_QuestsChanged_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA) -- E.backgroundColorA
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ExtraBackgroundFadeWhenMoving = {
				type = "range",
				name = L["Extra Background Fade When Moving"], -- L["Alpha On Drag"],
				desc = CURSOR_SIZE_DEFAULT..": 1",
				min = 0.1,
				max = 1,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_ExtraBackgroundFadeWhenMoving
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_ExtraBackgroundFadeWhenMoving = value
					E.MOVINGBACKGROUND_ALPHA = value
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
			Config_ADDON_HEIGHT = {
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
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ClampedToScreen = {
				type = "toggle",
				name = L["Clamped To Screen"],
				desc = CURSOR_SIZE_DEFAULT..": "..NO,
				get = function()
					return Octo_ToDo_DB_Vars.Config_ClampedToScreen
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_ClampedToScreen = value
					if Octo_MainFrame_ToDo then
						Octo_MainFrame_ToDo:SetClampedToScreen(value)
					end
					if Octo_MainFrame_QuestsChanged then
						Octo_MainFrame_QuestsChanged:SetClampedToScreen(value)
					end
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = L["Character Display Settings"],
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_LevelToShow = {
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
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_LevelToShowMAX = {
				type = "range",
				name = L["Max. Level"],
				desc = CURSOR_SIZE_DEFAULT..": 90",
				min = 1,
				max = 90*2,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_LevelToShowMAX
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_LevelToShowMAX = value
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
				name = L["Show ID"],
				desc = CURSOR_SIZE_DEFAULT..": "..NO,
				get = function()
					return Octo_ToDo_DB_Vars.Config_DebugID_ALL
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_DebugID_ALL = value
					E.Config_DebugID_ALL = value
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
		},
	}
	-------------------------------------------------
	local table_numberFormatMode = {
		L["Universal"], -- "Универсальный"
		L["Localized"], -- "Локализованный"
		L["With separators"], -- "С разделителями"
		L["Full"], -- "Полный"
		"Blizzard", -- "Blizzard"
		L["Clean"], -- "Минималистичный"
	}
	for index, name in ipairs(table_numberFormatMode) do
		Options.args.Config_numberFormatMode.values[index] = name
	end
	local table_FontFlags = {
		"", -- (пустая строка) стандартный шрифт с антиалиасингом.
		"MONOCHROME", -- шрифт без сглаживания (пиксельный).
		"OUTLINE", -- шрифт с тонкой черной обводкой.
		"THICKOUTLINE", -- шрифт с толстой черной обводкой.
		"MONOCHROME, OUTLINE", -- пиксельный шрифт с тонкой обводкой.
		"MONOCHROME, THICKOUTLINE", -- пиксельный шрифт с толстой обводкой.
	}
	for index, name in ipairs(table_FontFlags) do
		Options.args.Config_FontFlags.values[name] = name
	end
	-------------------------------------------------
	return Options
end