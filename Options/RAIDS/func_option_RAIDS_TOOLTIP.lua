local GlobalAddonName, E = ...
local L = E.L
function E.func_option_RAIDS_TOOLTIP(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Tooltip"])
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.CONFIG_RAIDS_DIFFICULTIES_ALL -------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ALL"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["All Difficulties"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local tooltip = L["Shows all raid difficulties in the tooltip"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Abbreviation"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local tooltip = L["Use English abbreviations for raid and dungeon difficulties instead of full names"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end