local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
function E.CreateGeneralOptions()
	local generalOptions = {
		type = "group",
		childGroups = "tree",
		name = E.func_AddonTitle(GlobalAddonName).." "..E.Gray_Color..E.func_AddonVersion(GlobalAddonName) .. "|r",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = 1,
			},
			-------------------------------------------------
			-- ПРЕФИКСЫ 2
			-------------------------------------------------
			Header3 = {
				type = "header",
				name = "",
				order = 3,
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
					return OctoToDo_DB_Vars.AddonHeight
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AddonHeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 4,
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
					return OctoToDo_DB_Vars.AddonLeftFrameWeight
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AddonLeftFrameWeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 5,
			},
			-------------------------------------------------
			AddonCentralFrameWeight = {
				type = "range",
				name = L["AddonCentralFrameWeight"],
				desc = "AddonCentralFrameWeight",
				min = 60,
				max = 160,
				step = 1,
				get = function()
					return OctoToDo_DB_Vars.AddonCentralFrameWeight
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.AddonCentralFrameWeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 6,
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
					return OctoToDo_DB_Vars.MainFrameDefaultLines
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.MainFrameDefaultLines = value
				end,
				width = E.FULL_WIDTH/4,
				order = 7,
			},
			-------------------------------------------------
			SFDropDownWeight = {
				type = "range",
				name = L["SFDropDownWeight"],
				desc = "SFDropDownWeight",
				min = 50,
				max = 200,
				step = 1,
				get = function()
					return OctoToDo_DB_Vars.SFDropDownWeight
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.SFDropDownWeight = value
				end,
				width = E.FULL_WIDTH/4,
				order = 8,
			},



			-------------------------------------------------
			Header9 = {
				type = "header",
				name = "",
				order = 9,
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
				order = 10,
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
				order = 11,
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
				order = 12,
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
				order = 13,
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
				order = 14,
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
				order = 15,
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
				order = 16,
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
				order = 17,
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
				order = 18,
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
				order = 19,
			},
			-------------------------------------------------
			Header20 = {
				type = "header",
				name = "HIDE",
				order = 20,
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
				order = 21,
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
				order = 22,
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
				order = 23,
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
				order = 24,
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
				order = 25,
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
				order = 26,
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
				order = 27,
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
				order = 28,
			},
			-------------------------------------------------
			Header29 = {
				type = "header",
				name = "настройки аддона",
				order = 29,
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
					return OctoToDo_DB_Vars.LevelToShow
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.LevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = 30,
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
					return OctoToDo_DB_Vars.LevelToShowMAX
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.LevelToShowMAX = value
				end,
				width = E.FULL_WIDTH/4,
				order = 31,
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
					return OctoToDo_DB_Vars.itemLevelToShow
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.itemLevelToShow = value
				end,
				width = E.FULL_WIDTH/4,
				order = 32,
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
					return OctoToDo_DB_Vars.FrameScale
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.FrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = 33,
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
					return OctoToDo_DB_Vars.GameMenuFrameScale
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.GameMenuFrameScale = value
				end,
				width = E.FULL_WIDTH/4,
				order = 34,
			},
			-------------------------------------------------
			MainHeader24 = {
				type = "header",
				name = OTHER,
				order = 35,
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
				order = 36,
			},
			-------------------------------------------------
			PortalsButtonsOnlyAvailable = {
				type = "toggle",
				name = E.func_texturefromIcon(3610528, 18).."PortalsButtonsOnlyAvailable",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable = value
				end,
				width = E.FULL_WIDTH/2,
				order = 37,
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
				order = 38,
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
				order = 39,
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
				order = 40,
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
				order = 41,
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
				order = 42,
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
				order = 43,
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
				order = 44,
			},
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
				order = 2,
			},
			-------------------------------------------------
		},
	}
	-- if wipe == false then
	-- wipe = true
	-------------------------------------------------
	-- for index, v in ipairs(E.OctoTable_Expansions) do
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

