local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
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
				name = FONT_SIZE,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_FontStyle = {
				name = "Font",
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
				name = "Config_FontSize",
				desc = "Config_FontSize",
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
				name = "Config_FontFlags",
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
			-- 	name = "Texture",
			-- 	type = "select",
			-- 	dialogControl = "LSM30_Statusbar",
			-- 	values = LibSharedMedia:HashTable("statusbar"),
			-- 	get = function()
			-- 		return Octo_ToDo_DB_Vars.Config_Texture
			-- 	end,
			-- 	set = function(_, value)
			-- 		Octo_ToDo_DB_Vars.Config_Texture = value
					
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ADDON_HEIGHT = {
				type = "range",
				name = "Высота одной строки",
				desc = "",
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
			Config_AlphaOnTheMove = {
				type = "range",
				name = L["Alpha On Move"], -- L["Alpha On Drag"],
				desc = "",
				min = 0.1,
				max = 1,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_AlphaOnTheMove
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_AlphaOnTheMove = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ClampedToScreen = {
				type = "toggle",
				name = L["Clamped To Screen"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_ClampedToScreen
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_ClampedToScreen = value
					if Octo_MainFrame_ToDo then
						Octo_MainFrame_ToDo:SetClampedToScreen(value)
					end
					if TestButton1 then
						TestButton1:SetClampedToScreen(value)
					end
					if ItemsUsable then
						ItemsUsable:SetClampedToScreen(value)
					end
					if TestButton1 then
						TestButton1:SetClampedToScreen(value)
					end
					if OctoDebugFunctions then
						OctoDebugFunctions:SetClampedToScreen(value)
					end
					if TestButton3 then
						TestButton3:SetClampedToScreen(value)
					end
					if Octo_MainFrame_Achievements then
						Octo_MainFrame_Achievements:SetClampedToScreen(value)
					end
					if Octo_MainFrame_AddonsManager then
						Octo_MainFrame_AddonsManager:SetClampedToScreen(value)
					end
					if Octo_MinecraftFrameFG then
						Octo_MinecraftFrameFG:SetClampedToScreen(value)
					end
					if PosFrame then
						PosFrame:SetClampedToScreen(value)
					end
					if QC_Quests then
						QC_Quests:SetClampedToScreen(value)
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
				name = "Настройка отображения персонажей",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_LevelToShow = {
				type = "range",
				name = L["Min. Level"],
				desc = "",
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
				desc = "",
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
		},
	}
	-------------------------------------------------
	local table_numberFormatMode = {
		L["Universal (k/M/B/T)"],
		L["Localized format"],
		L["Full with separators"],
		L["Full"],
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