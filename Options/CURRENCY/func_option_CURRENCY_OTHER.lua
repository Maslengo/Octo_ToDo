local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_OTHER(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["OTHER"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_SHOW_BRACKETS -------------
	----------------------------------------------------------------
	do
		local name = L["Show progress (in parentheses)"]
		local variableKey = "CONFIG_CURRENCY_SHOW_BRACKETS"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local tooltip = L["Shows earned amount in () if currency has weekly/seasonal cap"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_COLOR_BRACKETS ------------
	----------------------------------------------------------------
	do
		local name = L["COLOR"]
		local variableKey = "CONFIG_CURRENCY_COLOR_BRACKETS"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_SHOW_REMAINING ------------
	----------------------------------------------------------------
	do
		local name = L["Show earnable amount"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_CURRENCY_SHOW_REMAINING"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local tooltip = L["Shows remaining amount if currency has weekly/seasonal cap"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_COLOR_REMAINING -----------
	----------------------------------------------------------------
	do
		local name = L["COLOR"]
		local variableKey = "CONFIG_CURRENCY_COLOR_REMAINING"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local tooltip = nil
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end