local GlobalAddonName, E = ...
local LibOctopussy = LibStub("LibOctopussy-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E:CreateDevelopmentOptions()
	local DevelopmentOptions = {
		type = "group",
		childGroups = "tree",
		name = E.AddonTitle,
		args = {
			-------------------------------------------------
			instructions = {
				type = "description",
				name = "These options allow you to toggle various options.",
				fontSize = "medium",
				order = 1,
			},
			-------------------------------------------------

			ReloadHeader = {
				type = "header",
				name = "",
				order = 2,
			},
			-------------------------------------------------
			Reload = {
				type = "execute",
				name = E.White_Color.."Reload UI".."|r",
				func = function()
					return ReloadUI()
				end,
				width = E.HALF_WIDTH,
				order = 3,
			},
			-------------------------------------------------
			DELETEALL = {
				type = "execute",
				name = E.Yellow_Color.."DELETEALL".."|r",
				func = function()
					profileKeys = {}
					OctoPlayer = {}
					Octo_ToDo_DB_Config  = {}
					Octo_ToDo_DB_Players  = {}
					Octo_ToDo_DB_Vars  = {}
					Octo_ToDo_DB_Other  = {}
					Octo_Achi_MAIN  = {}
					Octo_ToDo_DB_Players_LIST  = {}
					Octo_ToDo_Movies  = {}
					Octo_ToDo_DB_Artifact  = {}
					Octo_ToDo_DB_LegionArtifacts  = {}
					OCTO_DB_currencies  = {}
					OCTO_DB_currencies_sort  = {}
					OCTO_DB_currencies_headers  = {}
					OCTO_DB_currencies_test  = {}
					OCTO_DB_reputations  = {}
					OCTO_DB_reputations_test = {}
					return ReloadUI()
				end,
				width = E.HALF_WIDTH,
				order = 4,
			},
			-------------------------------------------------

			ReloadHeader = {
				type = "header",
				name = "",
				order = 5,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Config = {
				type = "execute",
				name = "Octo_ToDo_DB_Config",
				func = function()
					Octo_ToDo_DB_Config  = {}
					return
				end,
				width = E.THIRD_WIDTH,
				order = 6,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Other = {
				type = "execute",
				name = "Octo_ToDo_DB_Other",
				func = function()
					Octo_ToDo_DB_Other  = {}
					return
				end,
				width = E.THIRD_WIDTH,
				order = 7,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Players = {
				type = "execute",
				name = "Octo_ToDo_DB_Players",
				func = function()
					Octo_ToDo_DB_Players  = {}
					return
				end,
				width = E.THIRD_WIDTH,
				order = 8,
			},
			-------------------------------------------------
			Octo_ToDo_DB_Vars = {
				type = "execute",
				name = "Octo_ToDo_DB_Vars",
				func = function()
					Octo_ToDo_DB_Vars  = {}
					return
				end,
				width = E.THIRD_WIDTH,
				order = 9,
			},
			-------------------------------------------------
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
	return DevelopmentOptions
end

