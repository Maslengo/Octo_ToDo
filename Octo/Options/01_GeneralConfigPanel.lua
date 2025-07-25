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
			["prefix"] = {
				type = "select",
				name = "wowhead",
				values = {},
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.prefix
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.prefix = value
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
			AddonLeftFrameWeight = {
				type = "range",
				name = L["AddonLeftFrameWeight"],
				desc = "AddonLeftFrameWeight",
				min = 200,
				max = 500,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.AddonLeftFrameWeight
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.AddonLeftFrameWeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			AddonCentralFrameWeight = {
				type = "range",
				name = L["AddonCentralFrameWeight"],
				desc = "AddonCentralFrameWeight",
				min = 60,
				max = 200,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.AddonCentralFrameWeight
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.AddonCentralFrameWeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			MainFrameDefaultLines = {
				type = "range",
				name = L["MainFrameDefaultLines"],
				desc = "MainFrameDefaultLines",
				min = 10,
				max = 50,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.MainFrameDefaultLines
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.MainFrameDefaultLines = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			-- MaxNumCharacters = {
			-- 	type = "range",
			-- 	name = L["MaxNumCharacters"],
			-- 	desc = "MaxNumCharacters",
			-- 	min = 1,
			-- 	max = 20,
			-- 	step = 1,
			-- 	get = function()
			-- 		return Octo_ToDo_DB_Vars.MaxNumCharacters
			-- 	end,
			-- 	set = function(_, value)
			-- 		Octo_ToDo_DB_Vars.MaxNumCharacters = value
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },
			-- -----------------------------------------------
			-- SFDropDownWeight = {
			-- 	type = "range",
			-- 	name = L["SFDropDownWeight"],
			-- 	desc = "SFDropDownWeight",
			-- 	min = 50,
			-- 	max = 200,
			-- 	step = 1,
			-- 	get = function()
			-- 		return Octo_ToDo_DB_Vars.SFDropDownWeight
			-- 	end,
			-- 	set = function(_, value)
			-- 		Octo_ToDo_DB_Vars.SFDropDownWeight = value
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = GetOrder(),
			-- },


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
			AlphaOnDrag = {
				type = "range",
				name = "AlphaOnDrag",
				desc = "",
				min = 0.1,
				max = 1,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.AlphaOnDrag
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.AlphaOnDrag = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			DontSavePosition = {
				type = "toggle",
				name = "Dont Save Position",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.DontSavePosition
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.DontSavePosition = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			ClampedToScreen = {
				type = "toggle",
				name = "Clamped To Screen",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.ClampedToScreen
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.ClampedToScreen = value
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
			LevelToShow = {
				type = "range",
				name = L["Player level"],
				desc = "",
				min = 1,
				max = 80,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.LevelToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.LevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			LevelToShowMAX = {
				type = "range",
				name = L["Player MAX level"],
				desc = "",
				min = 1,
				max = 80*2,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.LevelToShowMAX
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.LevelToShowMAX = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			itemLevelToShow = {
				type = "range",
				name = L["Item level: "],
				desc = "",
				min = 0,
				max = 560,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.itemLevelToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.itemLevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			MaxNumCharacters = {
				type = "range",
				name = "MaxNumCharacters",
				desc = "",
				min = 1,
				max = 30,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.MaxNumCharacters
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.MaxNumCharacters = value
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
			GameMenuFrameScale = {
				type = "range",
				name = "GameMenuFrameScale",
				desc = "",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.GameMenuFrameScale
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.GameMenuFrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			PortalsButtons = {
				type = "toggle",
				name = E:func_texturefromIcon(3610528, 18)..L["Portals"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.PortalsButtons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.PortalsButtons = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			PortalsButtonsOnlyAvailable = {
				type = "toggle",
				name = E:func_texturefromIcon(3610528, 18).."PortalsButtonsOnlyAvailable",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.PortalsButtonsOnlyAvailable = value
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
			WasOnline = {
				type = "toggle",
				name = L["Was online"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.WasOnline
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.WasOnline = value
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
			-------------------------------------------------
		},
	}
	-------------------------------------------------
	for index, name in ipairs(E.OctoTable_Prefixes) do
		generalOptions.args.prefix.values[index] = name
	end
	-------------------------------------------------
	return generalOptions
end
