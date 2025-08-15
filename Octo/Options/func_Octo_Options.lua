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
	local generalOptions = {
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
			["Config_prefix"] = {
				type = "select",
				name = "wowhead",
				values = {},
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_prefix
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_prefix = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
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
				name = "Настройки фреймов аддона",
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
					E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle), Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize, Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags)
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
					E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle), Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize, Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags)
				
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
					E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle), Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize, Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags)
					
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Texture = {
				name = "Texture",
				type = "select",
				dialogControl = "LSM30_Statusbar",
				values = LibSharedMedia:HashTable("statusbar"),
				get = function()
					return Octo_ToDo_DB_Vars.Config_Texture
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Texture = value
					
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ADDON_HEIGHT = {
				type = "range",
				name = "Высота одной строки",
				desc = "",
				min = 15,
				max = 30,
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
			Config_AlphaOnDrag = {
				type = "range",
				name = L["Alpha On Drag"],
				desc = "",
				min = 0.1,
				max = 1,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_AlphaOnDrag
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_AlphaOnDrag = value
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
				max = 80,
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
				max = 80*2,
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
			ShowOnlyCurrentServer = {
				type = "toggle",
				name = L["Only Current Server"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ShowOnlyCurrentRegion = {
				type = "toggle",
				name = L["Only Current Region"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			OnlyCurrentFaction = {
				type = "toggle",
				name = E.curFaction == "Horde" and E.func_texturefromIcon(E.Icon_Horde)..L["Only Horde"] or E.func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.OnlyCurrentFaction
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.OnlyCurrentFaction = value
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
			QUESTS_LABEL = {
				type = "toggle",
				name = QUESTS_LABEL,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Quests
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Quests = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			CALENDAR_FILTER_HOLIDAYS = {
				type = "toggle",
				name = CALENDAR_FILTER_HOLIDAYS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Holidays
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Holidays = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			DUNGEONS = {
				type = "toggle",
				name = DUNGEONS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Dungeons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Dungeons = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ITEMS = {
				type = "toggle",
				name = ITEMS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Items
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Items = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			TRADE_SKILLS = {
				type = "toggle",
				name = TRADE_SKILLS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Professions
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Professions = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			BONUS_ROLL_REWARD_MONEY = {
				type = "toggle",
				name = BONUS_ROLL_REWARD_MONEY,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Gold
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Gold = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			STAT_AVERAGE_ITEM_LEVEL = {
				type = "toggle",
				name = STAT_AVERAGE_ITEM_LEVEL,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.ItemLevel
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ItemLevel = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_WasOnline = {
				type = "toggle",
				name = L["Was online"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_WasOnline
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_WasOnline = value
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
		},
	}
	-------------------------------------------------
	for index, name in ipairs(E.OctoTable_Prefixes) do
		generalOptions.args.Config_prefix.values[index] = name
	end
	local table_numberFormatMode = {
		L["Universal (k/M/B/T)"],
		L["Localized format"],
		L["Full with separators"],
	}
	for index, name in ipairs(table_numberFormatMode) do
		generalOptions.args.Config_numberFormatMode.values[index] = name
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
		generalOptions.args.Config_FontFlags.values[name] = name
	end
	-------------------------------------------------
	return generalOptions
end