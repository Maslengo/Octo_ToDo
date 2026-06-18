local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_COLORS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["COLORS"])
	----------------------------------------------------------------
	-- 1. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_COLOREDNAME ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_CURRENCY_COLOREDNAME"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Color by quality"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end