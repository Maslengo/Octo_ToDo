local GlobalAddonName, E = ...
local L = E.L
function E.func_option_ITEMS_COLORS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["COLORS"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_ITEMS_COLOREDNAME ------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ITEMS_COLOREDNAME"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Color by quality"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end