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
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		tooltip = tooltip .. "|n|n" .. L["Shows all raid difficulties in the tooltip"]
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
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
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		tooltip = tooltip .. "|n|n" .. L["Use English abbreviations for raid and dungeon difficulties instead of full names"]
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
end