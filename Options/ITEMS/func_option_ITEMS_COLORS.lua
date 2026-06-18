local GlobalAddonName, E = ...
local L = E.L
function E.func_option_ITEMS_COLORS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["COLORS"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_ITEMS_COLOREDNAME ------------------
	----------------------------------------------------------------
	do
		local name = L["Color by quality"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ITEMS_COLOREDNAME"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end