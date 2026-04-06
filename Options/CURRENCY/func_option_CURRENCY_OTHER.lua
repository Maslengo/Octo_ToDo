local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_OTHER(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["OTHER"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_BRACKETS -------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_CURRENCY_SHOW_BRACKETS"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show progress (in parentheses)"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local tooltip = L["Shows earned amount in () if currency has weekly/seasonal cap"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOR_BRACKETS ------------
	----------------------------------------------------------------
	do
		local name = COLOR
		local variableKey = "CONFIG_CURRENCY_COLOR_BRACKETS"
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local variableTbl = Octo_ToDo_DB_Vars
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_REMAINING ------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_CURRENCY_SHOW_REMAINING"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show earnable amount"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local tooltip = L["Shows remaining amount if currency has weekly/seasonal cap"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOR_REMAINING -----------
	----------------------------------------------------------------
	do
		local name = COLOR
		local variableKey = "CONFIG_CURRENCY_COLOR_REMAINING"
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local variableTbl = Octo_ToDo_DB_Vars
		local tooltip = nil
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end