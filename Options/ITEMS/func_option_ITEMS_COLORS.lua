local GlobalAddonName, E = ...
local L = E.L
function E.func_option_ITEMS_COLORS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["COLORS"])
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.CONFIG_ITEMS_COLOREDNAME ---------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ITEMS_COLOREDNAME"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Color by quality"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
end