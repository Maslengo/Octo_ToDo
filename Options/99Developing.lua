local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E.Developing()
	local Developing = {
		type = "group",
		childGroups = "tree",
		name = "Developing",
		args = {
			-------------------------------------------------
			ReloadHeader3 = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			Reload = {
				type = "execute",
				name = RELOADUI,
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/5,
				order = 3,
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = DELETE.." "..ALL,
				func = function()
					profileKeys = {}
					Octo_ToDo_DB_Config = {}
					Octo_ToDo_DB_Players = {}
					Octo_ToDo_DB_Vars = {}
					Octo_ToDo_DB_Other = {}
					OCTO_DB_currencies_test = {}
					OCTO_DB_reputations_test = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/5,
				order = 4,
			},
			-------------------------------------------------
			ReloadHeader3second = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Config = {
				type = "execute",
				name = "Config",
				func = function()
					Octo_ToDo_DB_Config  = {}
					return
				end,
				width = E.FULL_WIDTH/5,
				order = 7,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Players = {
				type = "execute",
				name = "Players",
				func = function()
					Octo_ToDo_DB_Players  = {}
					return
				end,
				width = E.FULL_WIDTH/5,
				order = 8,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Vars = {
				type = "execute",
				name = "Vars",
				func = function()
					Octo_ToDo_DB_Vars  = {}
					return
				end,
				width = E.FULL_WIDTH/5,
				order = 9,
			},
			-------------------------------------------------
			OCTO_DB_currencies_test = {
				type = "execute",
				name = "currencies",
				func = function()
					OCTO_DB_currencies_test  = {}
					return
				end,
				width = E.FULL_WIDTH/5,
				order = 10,
			},
			-------------------------------------------------
			OCTO_DB_reputations_test = {
				type = "execute",
				name = "reputations",
				func = function()
					OCTO_DB_reputations_test  = {}
					return
				end,
				width = E.FULL_WIDTH/5,
				order = 11,
			},
			-------------------------------------------------
			ReloadHeader3second2 = {
				type = "header",
				name = "",
				order = 12,
			},
			-------------------------------------------------
			Achievements = {
				type = "toggle",
				name = "Achievements",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Achievements
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Achievements = value
				end,
				width = E.FULL_WIDTH/2,
				order = 13,
			},
			-------------------------------------------------
			ItemsUsable = {
				type = "toggle",
				name = "ItemsUsable",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ItemsUsable
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ItemsUsable = value
				end,
				width = E.FULL_WIDTH/2,
				order = 14,
			},
			-------------------------------------------------
			ItemsDelete = {
				type = "toggle",
				name = "ItemsDelete",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.ItemsDelete
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.ItemsDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = 15,
			},
			-------------------------------------------------
			StaticPopup1Button1 = {
				type = "toggle",
				name = "StaticPopup1Button1",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.StaticPopup1Button1
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.StaticPopup1Button1 = value
				end,
				width = E.FULL_WIDTH/2,
				order = 16,
			},
			-------------------------------------------------
			AdditionalButtons = {
				type = "toggle",
				name = "AdditionalButtons",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.AdditionalButtons
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.AdditionalButtons = value
				end,
				width = E.FULL_WIDTH/2,
				order = 17,
			},
			-------------------------------------------------
			CVar = {
				type = "toggle",
				name = "CVar",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.CVar
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.CVar = value
				end,
				width = E.FULL_WIDTH/2,
				order = 18,
			},
			-------------------------------------------------
			SpeedFrameShown = {
				type = "toggle",
				name = "SpeedFrame.Shown",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.SpeedFrame.Shown
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.SpeedFrame.Shown = value
				end,
				width = E.FULL_WIDTH/2,
				order = 19,
			},
			-------------------------------------------------
			Minecraft = {
				type = "toggle",
				name = "Minecraft",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Minecraft
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Minecraft = value
				end,
				width = E.FULL_WIDTH/2,
				order = 20,
			},
			-------------------------------------------------
			Octo_debug_Function_FIRST = {
				type = "toggle",
				name = "Octo_debug_Function_FIRST",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST = value
				end,
				width = E.FULL_WIDTH/2,
				order = 21,
			},
			-------------------------------------------------
			Hide_ObjectivesInInstance = {
				type = "toggle",
				name = "Hide_ObjectivesInInstance",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance = value
				end,
				width = E.FULL_WIDTH/2,
				order = 22,
			},
			-------------------------------------------------
			ReloadHeader3second2 = {
				type = "header",
				name = "",
				order = 23,
			},
			-------------------------------------------------
			FoV_top = {
				type = "range",
				name = "FoV_top",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.FoV_top
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FoV_top = value
				end,
				width = E.FULL_WIDTH/4,
				order = 25,
			},
			-------------------------------------------------
			FoV_bottom = {
				type = "range",
				name = "FoV_bottom",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.FoV_bottom
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FoV_bottom = value
				end,
				width = E.FULL_WIDTH/4,
				order = 27,
			},
			-------------------------------------------------
			FoV_left = {
				type = "range",
				name = "FoV_left",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.FoV_left
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FoV_left = value
				end,
				width = E.FULL_WIDTH/4,
				order = 28,
			},
			-------------------------------------------------
			FoV_right = {
				type = "range",
				name = "FoV_right",
				desc = "The scale of in-world damage numbers, xp gain, artifact gains, etc",
				min = 0.5,
				max = 2.5,
				step = 0.1,
				get = function()
					return Octo_ToDo_DB_Vars.config.FoV_right
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FoV_right = value
				end,
				width = E.FULL_WIDTH/4,
				order = 29,
			},
			-------------------------------------------------
			FieldOfView = {
				type = "toggle",
				name = "FieldOfView",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.config.FieldOfView
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.config.FieldOfView = value
				end,
				width = E.FULL_WIDTH/2,
				order = 30,
			},
			-------------------------------------------------
			ReloadHeader3second22 = {
				type = "header",
				name = "",
				order = 31,
			},
			-------------------------------------------------

			-- color = {
			--     type = "group",
			--     name = "Arrow colors",
			--     order = 15,
			--     inline = true,
			--     args = {
			--         help = {
			--             order = 1,
			--             type = "description",
			--             name = "The floating waypoint arrow can change color depending on whether or nor you are facing your destination.\nBy default it will display green when you are facing it directly, and red when you are facing away from it.\nThese colors can be changed in this section.\nSetting these options to the same color will cause the arrow to not change color at all",
			--         },
			--         ReloadHeader3second = {
			--             type = "header",
			--             name = "",
			--             order = 2,
			--         },
			-- colorstart = {
			--     order = 3,
			--     type = "color",
			--     name = "Good color",
			--     desc = "The color to be displayed when you are moving in the direction of the active waypoint",
			--     arg = Octo_ToDo_DB_Config.colorstart,
			-- get = function()
			--     return Octo_ToDo_DB_Config.colorstart
			-- end,
			-- set = function(_, value)
			--     Octo_ToDo_DB_Config.colorstart = value
			-- end,
			--     hasAlpha = false,
			-- },
			--     },
			-- },
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	return Developing
end
