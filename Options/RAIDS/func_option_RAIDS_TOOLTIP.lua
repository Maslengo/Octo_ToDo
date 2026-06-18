local GlobalAddonName, E = ...
local L = E.L
function E.func_option_RAIDS_TOOLTIP(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Tooltip"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_RAIDS_DIFFICULTIES_ALL -------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ALL"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["All Difficulties"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local tooltip = L["Shows all raid difficulties in the tooltip"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS ---
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Abbreviation"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local tooltip = L["Use English abbreviations for raid and dungeon difficulties instead of full names"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end