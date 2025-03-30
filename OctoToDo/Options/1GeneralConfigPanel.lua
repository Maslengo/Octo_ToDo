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
					return OctoToDo_DB_Vars.AutoSellGrey
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AutoSellGrey = value
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
					return OctoToDo_DB_Vars.AutoRepair
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AutoRepair = value
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
					return OctoToDo_DB_Vars.InputDelete
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.InputDelete = value
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
					return OctoToDo_DB_Vars.AutoOpen
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AutoOpen = value
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
					return OctoToDo_DB_Vars.Auto_Gossip
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Auto_Gossip = value
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
					return OctoToDo_DB_Vars.AutoTurnQuests
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AutoTurnQuests = value
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
					return OctoToDo_DB_Vars.Auto_ChatClearing
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Auto_ChatClearing = value
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
					return OctoToDo_DB_Vars.Auto_Screenshot
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Auto_Screenshot = value
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
					return OctoToDo_DB_Vars.Auto_CinematicCanceler
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Auto_CinematicCanceler = value
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
					return OctoToDo_DB_Vars.Auto_CinematicFastSkip
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Auto_CinematicFastSkip = value
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
					return OctoToDo_DB_Vars.Hide_Boss_Banner
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_Boss_Banner = value
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
					return OctoToDo_DB_Vars.Hide_Covenant
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_Covenant = value
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
					return OctoToDo_DB_Vars.Hide_Error_Messages
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_Error_Messages = value
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
					return OctoToDo_DB_Vars.Hide_RaidWarningFrame
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_RaidWarningFrame = value
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
					return OctoToDo_DB_Vars.Hide_OrderHallCommandBar
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_OrderHallCommandBar = value
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
					return OctoToDo_DB_Vars.Hide_Talking_Head_Frame
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_Talking_Head_Frame = value
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
					return OctoToDo_DB_Vars.Hide_Zone_Text
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Hide_Zone_Text = value
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
					return OctoToDo_DB_Vars.UIErrorsFramePosition
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.UIErrorsFramePosition = value
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
					return OctoToDo_DB_Vars.LevelToShow
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.LevelToShow = value
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
					return OctoToDo_DB_Vars.LevelToShowMAX
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.LevelToShowMAX = value
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
					return OctoToDo_DB_Vars.itemLevelToShow
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.itemLevelToShow = value
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
					return OctoToDo_DB_Vars.curWidthCentral
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.curWidthCentral = value
				end,
				width = E.FULL_WIDTH/4,
				order = 31,
			},
			-------------------------------------------------
			curWidthTitle = {
				type = "range",
				name = L["curWidthTitle: "],
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 200,
				max = 500,
				step = 1,
				get = function()
					return OctoToDo_DB_Vars.curWidthTitle
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.curWidthTitle = value
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
					return OctoToDo_DB_Vars.curHeight
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.curHeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 33,
			},
			-------------------------------------------------
			Addon_Height = {
				type = "range",
				name = "Количество строк",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 10,
				max = 50,
				step = 1,
				get = function()
					return OctoToDo_DB_Vars.Addon_Height
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Addon_Height = value
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
					return OctoToDo_DB_Vars.FrameScale
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.FrameScale = value
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
					return OctoToDo_DB_Vars.GameMenuFrameScale
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.GameMenuFrameScale = value
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
				name = E.func_texturefromIcon(3610528, 18)..L["Portals"],
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.PortalsButtons
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.PortalsButtons = value
				end,
				width = E.FULL_WIDTH/2,
				order = 38,
			},
			-------------------------------------------------
			PortalsButtonsOnlyCurrent = {
				type = "toggle",
				name = E.func_texturefromIcon(3610528, 18).."PortalsButtonsOnlyCurrent",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.PortalsButtonsOnlyCurrent
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.PortalsButtonsOnlyCurrent = value
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
					return OctoToDo_DB_Vars.ShowOnlyCurrentServer
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ShowOnlyCurrentServer = value
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
					return OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = value
				end,
				width = E.FULL_WIDTH/2,
				order = 41,
			},
			-------------------------------------------------
			Dungeons = {
				type = "toggle",
				name = "КД инстов",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.Dungeons
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Dungeons = value
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
					return OctoToDo_DB_Vars.Professions
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Professions = value
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
					return OctoToDo_DB_Vars.Gold
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.Gold = value
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
					return OctoToDo_DB_Vars.ItemLevel
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.ItemLevel = value
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
					return OctoToDo_DB_Vars.WasOnline
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.WasOnline = value
				end,
				width = E.FULL_WIDTH/2,
				order = 49,
			},
			-------------------------------------------------
			-- ["ExpansionToShow"] = {
			-- 	type = "select",
			-- 	name = "ExpansionToShow",
			-- 	values = {},
			-- 	desc = "",
			-- 	get = function()
			-- 		return OctoToDo_DB_Vars.ExpansionToShow
			-- 	end,
			-- 	set = function(_, value)
			-- 		OctoToDo_DB_Vars.ExpansionToShow = value
			-- 	end,
			-- 	width = E.FULL_WIDTH/4,
			-- 	order = 3,
			-- },
			-------------------------------------------------
			["prefix"] = {
				type = "select",
				name = "prefix",
				values = {},
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.prefix
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.prefix = value
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
	-- for index, v in ipairs(E.OctoTable_Expansions_Table) do
	-- 	generalOptions.args.ExpansionToShow.values[index] = E.func_texturefromIcon(v.icon)..v.color..v.name.."|r"
	-- end
	-------------------------------------------------
	for index, name in ipairs(E.OctoTable_Prefixes) do
		generalOptions.args.prefix.values[index] = name
	end
	-------------------------------------------------
	-- end
	-------------------------------------------------



	return generalOptions
end

