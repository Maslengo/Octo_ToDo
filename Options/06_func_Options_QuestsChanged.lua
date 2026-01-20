local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
function E.func_Options_QuestsChanged(name, savedVars)
	local Options = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			-- Вкладка: Настройки QuestsChanged
			-------------------------------------------------
			mainTab = {
				type = "group",
				name = "Настройки",
				order = E.func_GetOrder(),
				args = {
					Config_QC_Quests = {
						type = "toggle",
						name = "Config_QC_Quests",

						get = function()
							return savedVars.Config_QC_Quests
						end,
						set = function(_, value)
							savedVars.Config_QC_Quests = value
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_QC_Vignettes = {
						type = "toggle",
						name = "Config_QC_Vignettes",

						get = function()
							return savedVars.Config_QC_Vignettes
						end,
						set = function(_, value)
							savedVars.Config_QC_Vignettes = value
						end,
						width = E.FOURTH_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
		},
	}
	return Options
end