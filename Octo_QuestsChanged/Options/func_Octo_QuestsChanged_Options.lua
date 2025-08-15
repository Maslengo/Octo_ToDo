local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
function E.func_Octo_QuestsChanged_Options(savedVars)
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local QuestsChanged = {
		type = "group",
		childGroups = "tab",
		name = E.func_AddonNameForOptionsFunc(GlobalAddonName), -- BINDING_HEADER_DEBUG
		args = {
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_QC_Quests = {
				type = "toggle",
				name = "Config_QC_Quests",
				desc = "",
				get = function()
					return savedVars.Config_QC_Quests
				end,
				set = function(_, value)
					savedVars.Config_QC_Quests = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_QC_Vignettes = {
				type = "toggle",
				name = "Config_QC_Vignettes",
				desc = "",
				get = function()
					return savedVars.Config_QC_Vignettes
				end,
				set = function(_, value)
					savedVars.Config_QC_Vignettes = value
				end,
				width = E.FULL_WIDTH/4,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	return QuestsChanged
end