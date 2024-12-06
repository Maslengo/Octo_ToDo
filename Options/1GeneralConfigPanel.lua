local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local continue = true
local index = 0
function E.CreateGeneralOptions()
	local generalOptions = {
		type = "group",
		childGroups = "tree",
		name = GlobalAddonName,
		args = {
			-------------------------------------------------
			instructions2 = {
				type = "description",
				name = "These options allow you to toggle various options.",
				fontSize = "medium",
				order = 1,
			},
			-------------------------------------------------
			MainHeader = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			ExpansionToShow = {
				type = "select",
				name = "ExpansionToShow",
				desc = "",
				values = {
					[1] = E.func_texturefromIcon(254094).."|cff68ccef".._G["EXPANSION_NAME"..(1 - 1)].."|r",
					[2] = _G["EXPANSION_NAME"..(2 - 1)],
					[3] = _G["EXPANSION_NAME"..(3 - 1)],
					[4] = _G["EXPANSION_NAME"..(4 - 1)],
					[5] = _G["EXPANSION_NAME"..(5 - 1)],
					[6] = _G["EXPANSION_NAME"..(6 - 1)],
					[7] = _G["EXPANSION_NAME"..(7 - 1)],
					[8] = _G["EXPANSION_NAME"..(8 - 1)],
					[9] = _G["EXPANSION_NAME"..(9 - 1)],
					[10] = _G["EXPANSION_NAME"..(10 - 1)],
					[11] = _G["EXPANSION_NAME"..(11 - 1)],
					[12] = "TEST",
				},
				sorting = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
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
			prefix = {
				type = "select",
				name = "prefix",
				desc = "",
				values = {
					[1] = "Русский", -- "ru.",
					[2] = "Deutsch", -- "de.",
					[3] = "English", -- "",
					[4] = "Español", -- "es.",
					[5] = "Français", -- "fr.",
					[6] = "Italiano", -- "it.",
					[7] = "Português Brasileiro", -- "pt.",
					[8] = "Korean", -- "한국어", --"ko.",
					[9] = "Chinese", -- "简体中文", --"cn.",
				},
				sorting = {1, 2, 3, 4, 5, 6, 7, 8, 9},
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
				order = 13,
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
				order = 14,
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
				order = 15,
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
				order = 16,
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
				max = E.currentMaxLevel,
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
				max = E.currentMaxLevel*2,
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
			-- generalHeader = {
			--     type = "header",
			--     name = "General Options",
			--     order = 10,
			-- },
			-- UnitNamePlayerPVPTitle = {
			--     type = "toggle",
			--     name = UNIT_NAME_PLAYER_TITLE,
			--     desc = OPTION_TOOLTIP_UNIT_NAME_PLAYER_TITLE,
			--     get = function()
			--         return C_CVar.GetCVarBool("UnitNamePlayerPVPTitle")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("UnitNamePlayerPVPTitle", value)
			--     end,
			--     width = "full",
			--     order = 11,
			-- },
			-- UnitNamePlayerGuild = {
			--     type = "toggle",
			--     name = UNIT_NAME_GUILD,
			--     desc = OPTION_TOOLTIP_UNIT_NAME_GUILD,
			--     get = function()
			--         return C_CVar.GetCVarBool("UnitNamePlayerGuild")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("UnitNamePlayerGuild", value)
			--     end,
			--     width = "full",
			--     order = 12,
			-- },
			-- UnitNameGuildTitle = {
			--     type = "toggle",
			--     name = UNIT_NAME_GUILD_TITLE,
			--     desc = OPTION_TOOLTIP_UNIT_NAME_GUILD_TITLE,
			--     get = function()
			--         return C_CVar.GetCVarBool("UnitNameGuildTitle")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("UnitNameGuildTitle", value)
			--     end,
			--     width = "full",
			--     order = 13,
			-- },
			-- mapFade = {
			--     type = "toggle",
			--     name = MAP_FADE_TEXT,
			--     desc = OPTION_TOOLTIP_MAP_FADE,
			--     get = function()
			--         return C_CVar.GetCVarBool("mapFade")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("mapFade", value)
			--     end,
			--     hidden = function()
			--         return self.IsClassicEra() or self.IsClassic()
			--     end,
			--     width = "full",
			--     order = 14,
			-- },
			-- secureAbilityToggle = {
			--     type = "toggle",
			--     name = SECURE_ABILITY_TOGGLE,
			--     desc = OPTION_TOOLTIP_SECURE_ABILITY_TOGGLE,
			--     get = function()
			--         return C_CVar.GetCVarBool("secureAbilityToggle")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("secureAbilityToggle", value)
			--     end,
			--     width = "full",
			--     order = 15,
			-- },
			-- scriptErrors = {
			--     type = "toggle",
			--     name = SHOW_LUA_ERRORS,
			--     desc = OPTION_TOOLTIP_SHOW_LUA_ERRORS,
			--     get = function()
			--         return C_CVar.GetCVarBool("scriptErrors")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("scriptErrors", value)
			--     end,
			--     width = "full",
			--     order = 16,
			-- },
			-- noBuffDebuffFilterOnTarget = {
			--     type = "toggle",
			--     name = "No Debuff Filter on Target",
			--     desc = "Do not filter buffs or debuffs at all on targets",
			--     get = function()
			--         return C_CVar.GetCVarBool("noBuffDebuffFilterOnTarget")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("noBuffDebuffFilterOnTarget", value)
			--     end,
			--     width = "full",
			--     order = 17,
			-- },
			-- reverseCleanupBags = {
			--     type = "toggle",
			--     name = REVERSE_CLEAN_UP_BAGS_TEXT,
			--     desc = OPTION_TOOLTIP_REVERSE_CLEAN_UP_BAGS,
			--     get = function()
			--         if C_Container and C_Container.GetSortBagsRightToLeft then
			--             return C_Container.GetSortBagsRightToLeft()
			--         elseif GetInsertItemsRightToLeft then
			--             return GetInsertItemsRightToLeft()
			--         end
			--     end,
			--     set = function(_, value)
			--         -- This is a dirty hack for SetSortBagsRightToLeft not instantly updating the bags
			--         -- Force a refresh of the UI after a set amount of time to make the checkbox reflect the new value
			--         C_Timer.After(0.5, function()
			--                 LibStub("AceConfigRegistry-3.0"):NotifyChange("AdvancedInterfaceOptions")
			--         end)
			--         if C_Container and C_Container.SetSortBagsRightToLeft then
			--             C_Container.SetSortBagsRightToLeft(value)
			--         elseif SetSortBagsRightToLeft then
			--             SetSortBagsRightToLeft(value)
			--         end
			--     end,
			--     hidden = function()
			--         return self.IsClassicEra() or self.IsClassic()
			--     end,
			--     width = "full",
			--     order = 18,
			-- },
			-- lootLeftmostBag = {
			--     type = "toggle",
			--     name = REVERSE_NEW_LOOT_TEXT,
			--     desc = OPTION_TOOLTIP_REVERSE_NEW_LOOT,
			--     get = function()
			--         if C_Container and C_Container.GetInsertItemsLeftToRight then
			--             return C_Container.GetInsertItemsLeftToRight()
			--         elseif GetInsertItemsLeftToRight then
			--             GetInsertItemsLeftToRight()
			--         end
			--     end,
			--     set = function(_, value)
			--         -- This is a dirty hack for SetInsertItemsLeftToRight not instantly updating the bags
			--         -- Force a refresh of the UI after a set amount of time to make the checkbox reflect the new value
			--         C_Timer.After(0.5, function()
			--                 LibStub("AceConfigRegistry-3.0"):NotifyChange("AdvancedInterfaceOptions")
			--         end)
			--         if C_Container and C_Container.SetInsertItemsLeftToRight then
			--             return C_Container.SetInsertItemsLeftToRight(value)
			--         elseif SetInsertItemsLeftToRight then
			--             SetInsertItemsLeftToRight(value)
			--         end
			--     end,
			--     hidden = function()
			--         return self.IsClassicEra() or self.IsClassic()
			--     end,
			--     width = "full",
			--     order = 19,
			-- },
			-- enableWoWMouse = {
			--     type = "toggle",
			--     name = WOW_MOUSE,
			--     desc = OPTION_TOOLTIP_WOW_MOUSE,
			--     get = function()
			--         -- NOTE: Currently broken, see https://github.com/Stanzilla/AdvancedInterfaceOptions/issues/83
			--         ---@diagnostic disable-next-line: param-type-mismatch
			--         return C_CVar.GetCVarBool("enableWoWMouse")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("enableWoWMouse", value)
			--     end,
			--     width = "full",
			--     order = 20,
			-- },
			-- -------------------------------------------------
			-- cameraHeader = {
			--     type = "header",
			--     name = "",
			--     order = 30,
			-- },
			-- trackQuestSorting = {
			--     type = "select",
			--     name = "Select quest sorting mode:",
			--     desc = "Select how quests are sorted in the quest log.",
			--     values = {
			--         ["top"] = "Top",
			--         ["proximity"] = "Proximity",
			--     },
			--     sorting = {
			--         "top",
			--         "proximity",
			--     },
			--     get = function()
			--         return C_CVar.GetCVar("trackQuestSorting")
			--     end,
			--     set = function(_, value)
			--         self:SetCVar("trackQuestSorting", value)
			--     end,
			--     width = E.FULL_WIDTH/4,
			--     order = 31,
			-- },
			-- -------------------------------------------------
			-- dataHeader = {
			--     type = "header",
			--     name = "",
			--     order = 40,
			-- },
			-- backupSettings = {
			--     type = "execute",
			--     name = "Backup Settings",
			--     func = function()
			--         StaticPopup_Show("AIO_BACKUP_SETTINGS")
			--     end,
			--     width = E.FULL_WIDTH/4,
			--     order = 41,
			-- },
			-- restoreSettings = {
			--     type = "execute",
			--     name = "Restore Settings",
			--     func = function()
			--         StaticPopup_Show("AIO_RESTORE_SETTINGS")
			--     end,
			--     width = E.FULL_WIDTH/4,
			--     order = 43,
			-- },
			-- resetSettings = {
			--     type = "execute",
			--     name = "Reset Settings",
			--     func = function()
			--         StaticPopup_Show("AIO_RESET_EVERYTHING")
			--     end,
			--     width = E.FULL_WIDTH/4,
			--     order = 43,
			-- },
		},
	}
	return generalOptions
end
