local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- local wipe = false
function E.CreateGeneralOptions()
	local generalOptions = {
		type = "group",
		childGroups = "tree",
		name = E.func_AddonTitle(GlobalAddonName).." "..E.Gray_Color..E.func_AddonVersion(GlobalAddonName) .. "|r",
		args = {
			-------------------------------------------------
			MainHeader = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			-------------------------------------------------
			MainHeader2 = {
				type = "header",
				name = "AUTO",
				order = 7,
			},
			-------------------------------------------------
			AutoSellGrey = {
				type = "toggle",
				name = L["AutoSellGrey"], -- "AUTO "..SELL_ALL_JUNK_ITEMS_EXCLUDE_HEADER, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.AutoSellGrey
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.AutoSellGrey = value
				end,
				width = E.FULL_WIDTH/2, -- "full",
				order = 8,
			},
			-------------------------------------------------
			AutoRepair = {
				type = "toggle",
				name = L["AutoRepair"], -- "AUTO "..REPAIR_ALL_ITEMS, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.AutoRepair
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.AutoRepair = value
				end,
				width = E.FULL_WIDTH/2,
				order = 9,
			},
			-------------------------------------------------
			InputDelete = {
				type = "toggle",
				name = L["InputDelete"], -- "AUTO "..DELETE, --
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.InputDelete
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.InputDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = 10,
			},
			-------------------------------------------------
			AutoOpen = {
				type = "toggle",
				name = L["AutoOpen"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.AutoOpen
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.AutoOpen = value
				end,
				width = E.FULL_WIDTH/2,
				order = 11,
			},
			-------------------------------------------------
			Auto_Gossip = {
				type = "toggle",
				name = L["AutoGossip"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Auto_Gossip
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Auto_Gossip = value
				end,
				width = E.FULL_WIDTH/2,
				order = 12,
			},
			-------------------------------------------------
			AutoTurnQuests = {
				type = "toggle",
				name = L["Auto Turn Quests"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.AutoTurnQuests
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.AutoTurnQuests = value
				end,
				width = E.FULL_WIDTH/2,
				order = 13,
			},
			-------------------------------------------------
			Auto_ChatClearing = {
				type = "toggle",
				name = L["ClearChat"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Auto_ChatClearing
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Auto_ChatClearing = value
				end,
				width = E.FULL_WIDTH/2,
				order = 14,
			},
			-------------------------------------------------
			Auto_Screenshot = {
				type = "toggle",
				name = L["Auto_Screenshot"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Auto_Screenshot
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Auto_Screenshot = value
				end,
				width = E.FULL_WIDTH/2,
				order = 15,
			},
			-------------------------------------------------
			Auto_CinematicCanceler = {
				type = "toggle",
				name = E.Green_Color..L["CinematicCanceler"].."|r",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler = value
				end,
				width = E.FULL_WIDTH/2,
				order = 16,
			},
			-------------------------------------------------
			Auto_CinematicFastSkip = {
				type = "toggle",
				name = E.Green_Color.."Fast Cinematic Skip (ESC/Space/Enter)".."|r",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip = value
				end,
				width = E.FULL_WIDTH/2,
				order = 17,
			},
			-------------------------------------------------
			HideHeader3 = {
				type = "header",
				name = "HIDE",
				order = 18,
			},
			-------------------------------------------------
			Hide_Boss_Banner = {
				type = "toggle",
				name = L["Hide: Boss Banner"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_Boss_Banner
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_Boss_Banner = value
				end,
				width = E.FULL_WIDTH/2,
				order = 19,
			},
			-------------------------------------------------
			Hide_Covenant = {
				type = "toggle",
				name = L["Hide: Covenant"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_Covenant
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_Covenant = value
				end,
				width = E.FULL_WIDTH/2,
				order = 20,
			},
			-------------------------------------------------
			Hide_Error_Messages = {
				type = "toggle",
				name = L["Hide: Error Messages"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_Error_Messages
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_Error_Messages = value
				end,
				width = E.FULL_WIDTH/2,
				order = 21,
			},
			-------------------------------------------------
			Hide_RaidWarningFrame = {
				type = "toggle",
				name = "Hide_RaidWarningFrame",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame = value
				end,
				width = E.FULL_WIDTH/2,
				order = 22,
			},
			-------------------------------------------------
			Hide_OrderHallCommandBar = {
				type = "toggle",
				name = "Hide_OrderHallCommandBar",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar = value
				end,
				width = E.FULL_WIDTH/2,
				order = 23,
			},
			-------------------------------------------------
			Hide_Talking_Head_Frame = {
				type = "toggle",
				name = L["Hide: TalkingHeadFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame = value
				end,
				width = E.FULL_WIDTH/2,
				order = 24,
			},
			-------------------------------------------------
			Hide_Zone_Text = {
				type = "toggle",
				name = L["Hide: Zone Text"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_Zone_Text
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_Zone_Text = value
				end,
				width = E.FULL_WIDTH/2,
				order = 25,
			},
			-------------------------------------------------
			UIErrorsFramePosition = {
				type = "toggle",
				name = L["UIErrorsFramePosition"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.UIErrorsFramePosition
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.UIErrorsFramePosition = value
				end,
				width = E.FULL_WIDTH/2,
				order = 26,
			},
			-------------------------------------------------
			LevelToShowHeader = {
				type = "header",
				name = "настройки аддона",
				order = 27,
			},
			-------------------------------------------------
			LevelToShow = {
				type = "range",
				name = L["Player level"],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 1,
				max = 80,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.LevelToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.LevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = 28,
			},
			-------------------------------------------------
			LevelToShowMAX = {
				type = "range",
				name = L["Player MAX level"],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 1,
				max = 80*2,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.LevelToShowMAX
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.LevelToShowMAX = value
				end,
				width = E.FULL_WIDTH/4,
				order = 29,
			},
			-------------------------------------------------
			itemLevelToShow = {
				type = "range",
				name = L["Item level: "],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0,
				max = 560,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.itemLevelToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.itemLevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = 30,
			},
			-------------------------------------------------
			curWidthCentral = {
				type = "range",
				name = L["Width: "],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 60,
				max = 160,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.curWidthCentral
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.curWidthCentral = value
				end,
				width = E.FULL_WIDTH/4,
				order = 31,
			},
			-------------------------------------------------
			curWidthTitle = {
				type = "range",
				name = L["curWidthTitle: "],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 100,
				max = 400,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.curWidthTitle
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.curWidthTitle = value
				end,
				width = E.FULL_WIDTH/4,
				order = 32,
			},
			-------------------------------------------------
			curHeight = {
				type = "range",
				name = "Высота строк: ",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 10,
				max = 30,
				step = 1,
				get = function()
					return Octo_ToDo_DB_Vars.config.curHeight
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.curHeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 33,
			},
			-------------------------------------------------
			Addon_Height = {
				type = "range",
				name = "Количество строк",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 200,
				max = 1000,
				step = 20,
				get = function()
					return Octo_ToDo_DB_Vars.config.Addon_Height
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Addon_Height = value
				end,
				width = E.FULL_WIDTH/4,
				order = 34,
			},
			-------------------------------------------------
			FrameScale = {
				type = "range",
				name = "FrameScale",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.FrameScale
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = 35,
			},
			-------------------------------------------------
			GameMenuFrameScale = {
				type = "range",
				name = "GameMenuFrameScale",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.GameMenuFrameScale
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.GameMenuFrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = 36,
			},
			-------------------------------------------------
			MainHeader24 = {
				type = "header",
				name = OTHER,
				order = 37,
			},
			-------------------------------------------------
			PortalsButtons = {
				type = "toggle",
				name = E.func_texturefromIcon(3610528, 20)..L["Portals"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.PortalsButtons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.PortalsButtons = value
				end,
				width = E.FULL_WIDTH/2,
				order = 38,
			},
			-------------------------------------------------
			PortalsButtonsOnlyCurrent = {
				type = "toggle",
				name = E.func_texturefromIcon(3610528).."PortalsButtonsOnlyCurrent",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent = value
				end,
				width = E.FULL_WIDTH/2,
				order = 39,
			},
			-------------------------------------------------
			ShowOnlyCurrentServer = {
				type = "toggle",
				name = L["Only Current Server"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = value
				end,
				width = E.FULL_WIDTH/2,
				order = 40,
			},
			-------------------------------------------------
			ShowOnlyCurrentBattleTag = {
				type = "toggle",
				name = L["Only Current BattleTag"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag = value
				end,
				width = E.FULL_WIDTH/2,
				order = 41,
			},
			-------------------------------------------------
			ShowTotalMoney = {
				type = "toggle",
				name = "Всего денег",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ShowTotalMoney
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ShowTotalMoney = value
				end,
				width = E.FULL_WIDTH/2,
				order = 42,
			},
			-------------------------------------------------
			ShowTimeAll = {
				type = "toggle",
				name = "Общее время игры",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ShowTimeAll
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ShowTimeAll = value
				end,
				width = E.FULL_WIDTH/2,
				order = 43,
			},
			-------------------------------------------------
			ShowTimeMAXLEVEL = {
				type = "toggle",
				name = "80 "..LEVEL,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL = value
				end,
				width = E.FULL_WIDTH/2,
				order = 44,
			},
			-------------------------------------------------
			Dungeons = {
				type = "toggle",
				name = "КД инстов",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Dungeons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Dungeons = value
				end,
				width = E.FULL_WIDTH/2,
				order = 45,
			},
			-------------------------------------------------
			Professions = {
				type = "toggle",
				name = TRADE_SKILLS,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Professions
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Professions = value
				end,
				width = E.FULL_WIDTH/2,
				order = 46,
			},
			-------------------------------------------------
			Gold = {
				type = "toggle",
				name = BONUS_ROLL_REWARD_MONEY,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Gold
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Gold = value
				end,
				width = E.FULL_WIDTH/2,
				order = 47,
			},
			-------------------------------------------------
			ItemLevel = {
				type = "toggle",
				name = STAT_AVERAGE_ITEM_LEVEL,
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ItemLevel
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ItemLevel = value
				end,
				width = E.FULL_WIDTH/2,
				order = 48,
			},
			-------------------------------------------------
			WasOnline = {
				type = "toggle",
				name = L["Was online"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.WasOnline
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.WasOnline = value
				end,
				width = E.FULL_WIDTH/2,
				order = 49,
			},
			-------------------------------------------------
			["ExpansionToShow"] = {
				type = "select",
				name = "ExpansionToShow",
				values = {}, 
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ExpansionToShow
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ExpansionToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = 3,
			},
			-------------------------------------------------
			["prefix"] = {
				type = "select",
				name = "prefix",
				values = {}, 
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.prefix
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.prefix = value
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
			},
			-------------------------------------------------
		},
	}
	-- if wipe == false then
		-- wipe = true
		-------------------------------------------------
		for index, v in ipairs(E.OctoTable_Expansions_Table) do
			generalOptions.args.ExpansionToShow.values[index] = E.func_texturefromIcon(v.icon)..v.color..v.name.."|r" 
		end
		-------------------------------------------------
		for index, name in ipairs(E.wowhead_prefix_Table) do
			generalOptions.args.prefix.values[index] = name 
		end
		-------------------------------------------------
	-- end
	-------------------------------------------------



	return generalOptions
end