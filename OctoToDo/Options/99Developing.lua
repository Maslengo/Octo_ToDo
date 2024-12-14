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
				name = E.Green_Color..RELOADUI.."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/3,
				order = 3,
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = E.Green_Color..DELETE.." "..ALL.."|r",
				func = function()
					OctoToDo_DB_Config = {}
					OctoToDo_DB_Levels = {}
					OctoToDo_DB_Other = {}
					OctoToDo_DB_Vars = {}
					OCTO_DB_currencies_test = {}
					OCTO_DB_reputations_test = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/3,
				order = 4,
			},
			-------------------------------------------------
			ReloadHeader3second = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
			OctoToDo_DB_Config = {
				type = "execute",
				name = "Config",
				func = function()
					OctoToDo_DB_Config  = {}
					return
				end,
				width = E.FULL_WIDTH/3,
				order = 7,
			},
			-------------------------------------------------
			OctoToDo_DB_Levels = {
				type = "execute",
				name = "Players",
				func = function()
					OctoToDo_DB_Levels  = {}
					return
				end,
				width = E.FULL_WIDTH/3,
				order = 8,
			},
			-------------------------------------------------
			OctoToDo_DB_Other = {
				type = "execute",
				name = "Other",
				func = function()
					OctoToDo_DB_Other  = {}
					return
				end,
				width = E.FULL_WIDTH/3,
				order = 9,
			},
			-------------------------------------------------
			OctoToDo_DB_Vars = {
				type = "execute",
				name = E.Green_Color.."Vars".."|r",
				func = function()
					OctoToDo_DB_Vars  = {}
					return ReloadUI()
				end,
				width = E.FULL_WIDTH/3,
				order = 10,
			},
			-------------------------------------------------
			OCTO_DB_currencies_test = {
				type = "execute",
				name = "currencies",
				func = function()
					OCTO_DB_currencies_test  = {}
					return
				end,
				width = E.FULL_WIDTH/3,
				order = 11,
			},
			-------------------------------------------------
			OCTO_DB_reputations_test = {
				type = "execute",
				name = "reputations",
				func = function()
					OCTO_DB_reputations_test  = {}
					return
				end,
				width = E.FULL_WIDTH/3,
				order = 12,
			},
			-------------------------------------------------
			ReloadHeader3second224 = {
				type = "header",
				name = ADDONS,
				order = 13,
			},
			-------------------------------------------------
			ReloadHeader3second22154 = {
				type = "header",
				name = OTHER,
				order = 15,
			},
			-------------------------------------------------
			ItemsUsable = {
				type = "toggle",
				name = "ItemsUsable",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.ItemsUsable
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.ItemsUsable = value
				end,
				width = E.FULL_WIDTH/2,
				order = 25,
			},
			-------------------------------------------------
			ItemsDelete = {
				type = "toggle",
				name = "ItemsDelete",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.ItemsDelete
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.ItemsDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = 26,
			},
			-------------------------------------------------
			StaticPopup1Button1 = {
				type = "toggle",
				name = "StaticPopup1Button1",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.StaticPopup1Button1
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.StaticPopup1Button1 = value
				end,
				width = E.FULL_WIDTH/2,
				order = 27,
			},
			-------------------------------------------------
			CVar = {
				type = "toggle",
				name = "CVar",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.CVar
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.CVar = value
				end,
				width = E.FULL_WIDTH/2,
				order = 29,
			},
			-------------------------------------------------
			SpeedFrameShown = {
				type = "toggle",
				name = "SpeedFrame.Shown",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.SpeedFrame.Shown
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.SpeedFrame.Shown = value
				end,
				width = E.FULL_WIDTH/2,
				order = 30,
			},
			-------------------------------------------------
			OctoToDo_debug_Function_FIRST = {
				type = "toggle",
				name = "OctoToDo_debug_Function_FIRST",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.OctoToDo_debug_Function_FIRST
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.OctoToDo_debug_Function_FIRST = value
				end,
				width = E.FULL_WIDTH/2,
				order = 32,
			},
			-------------------------------------------------
			Hide_ObjectivesInInstance = {
				type = "toggle",
				name = "Hide_ObjectivesInInstance",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.Hide_ObjectivesInInstance
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.Hide_ObjectivesInInstance = value
				end,
				width = E.FULL_WIDTH/2,
				order = 33,
			},
			-------------------------------------------------
			SellFrame = {
				type = "toggle",
				name = "SellFrame",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.SellFrame
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.SellFrame = value
				end,
				width = E.FULL_WIDTH/2,
				order = 34,
			},
			-------------------------------------------------
			ReloadHeader3second2 = {
				type = "header",
				name = "FOV",
				order = 35,
			},
			-------------------------------------------------
			FieldOfView = {
				type = "toggle",
				name = "FieldOfView",
				desc = "",
				get = function()
					return OctoToDo_DB_Vars.config.FieldOfView
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.FieldOfView = value
				end,
				width = E.FULL_WIDTH,
				order = 36,
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
					return OctoToDo_DB_Vars.config.FoV_top
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.FoV_top = value
				end,
				width = E.FULL_WIDTH/4,
				order = 37,
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
					return OctoToDo_DB_Vars.config.FoV_bottom
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.FoV_bottom = value
				end,
				width = E.FULL_WIDTH/4,
				order = 38,
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
					return OctoToDo_DB_Vars.config.FoV_left
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.FoV_left = value
				end,
				width = E.FULL_WIDTH/4,
				order = 39,
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
					return OctoToDo_DB_Vars.config.FoV_right
				end,
				set = function(_, value)
					OctoToDo_DB_Vars.config.FoV_right = value
				end,
				width = E.FULL_WIDTH/4,
				order = 40,
			},
			-------------------------------------------------
			ReloadHeader3second22 = {
				type = "header",
				name = "",
				order = 41,
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
			--     arg = OctoToDo_DB_Config.colorstart,
			-- get = function()
			--     return OctoToDo_DB_Config.colorstart
			-- end,
			-- set = function(_, value)
			--     OctoToDo_DB_Config.colorstart = value
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

