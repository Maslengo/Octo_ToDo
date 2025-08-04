local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
-------------------------------------------------------------------------
function E:CreateGeneralOptions()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local generalOptions = {
		type = "group",
		childGroups = "tree",
		name = E:func_AddonTitle(GlobalAddonName).." "..E.Gray_Color..E:func_AddonVersion(GlobalAddonName) .. "|r",
		args = {
			-------------------------------------------------
			Header1 = {
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
			Header3 = {
				type = "header",
				name = "Настройки фреймов аддона",
				order = GetOrder(),
			},
			-------------------------------------------------
			AddonHeight = {
				type = "range",
				name = L["AddonHeight"],
				desc = "AddonHeight",
				min = 10,
				max = 30,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.AddonHeight
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.AddonHeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_MainFrameDefaultLines = {
				type = "range",
				name = L["Config_MainFrameDefaultLines"],
				desc = "Config_MainFrameDefaultLines",
				min = 10,
				max = 50,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.Config_MainFrameDefaultLines
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_MainFrameDefaultLines = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			FrameScale = {
				type = "range",
				name = "FrameScale",
				desc = "",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.FrameScale
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_AlphaOnDrag = {
				type = "range",
				name = "Config_AlphaOnDrag",
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
			Config_DontSavePosition = {
				type = "toggle",
				name = "Dont Save Position",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_DontSavePosition
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_DontSavePosition = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_ClampedToScreen = {
				type = "toggle",
				name = "Clamped To Screen",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_ClampedToScreen
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_ClampedToScreen = value
					if Octo_MainFrame_ToDo then
						Octo_MainFrame_ToDo:SetClampedToScreen(value)
					end
					if Octo_Main_TestFrame then
						Octo_Main_TestFrame:SetClampedToScreen(value)
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
			Header29 = {
				type = "header",
				name = "Настройка отображения персонажей",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_LevelToShow = {
				type = "range",
				name = L["Player level"],
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
				name = L["Player MAX level"],
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
			itemConfig_LevelToShow = {
				type = "range",
				name = L["Item level: "],
				desc = "",
				min = 0,
				max = 560,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.itemConfig_LevelToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.itemConfig_LevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			MainHeader24 = {
				type = "header",
				name = OTHER,
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
			Header122 = {
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
			Header123 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------

			FontSize = {
				type = "range",
				name = "FontSize",
				desc = "FontSize",
				min = 8,
				max = 32,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.FontSize
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FontSize = value
					E.OctoFont11:SetFont("Interface\\Addons\\"..E.MainAddonName.."\\Media\\02_Fonts\\Octo.TTF", value, Octo_ToDo_DB_Vars.FontFlags)
					for i, frame in ipairs(E.OctoTable_Frames) do
						if frame:IsShown() then
							frame:Hide()
							frame:Show()
						end
					end
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},




			["FontFlags"] = {
				type = "select",
				name = "FontFlags",
				values = {},
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.FontFlags
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.FontFlags = value
					E.OctoFont11:SetFont("Interface\\Addons\\"..E.MainAddonName.."\\Media\\02_Fonts\\Octo.TTF", Octo_ToDo_DB_Vars.FontSize, value)
					for i, frame in ipairs(E.OctoTable_Frames) do
						if frame:IsShown() then
							frame:Hide()
							frame:Show()
						end
					end
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},










			-------------------------------------------------
		},
	}
	-------------------------------------------------
	for index, name in ipairs(E.OctoTable_Prefixes) do
		generalOptions.args.Config_prefix.values[index] = name
	end


	local tblFontFlags = {
		"",				-- The base font
		"MONOCHROME",	-- Font is rendered without antialiasing
		"OUTLINE",		-- Font is displayed with a black outline
		"THICKOUTLINE",	-- Font is displayed with a thick black outline
	}


	for index, name in ipairs(tblFontFlags) do
		generalOptions.args.FontFlags.values[name] = name
	end




	-------------------------------------------------
	return generalOptions
end
