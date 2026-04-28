local GlobalAddonName, E = ...
local L = E.L
function E.func_option_GREATVAULT(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["RATED_PVP_WEEKLY_VAULT"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_ADVANCED_TOOLTIP_GREATVAULT -------------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ADVANCED_TOOLTIP_GREATVAULT"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Advanced Tooltip"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end