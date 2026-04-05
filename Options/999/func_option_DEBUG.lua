local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_option_DEBUG(category, layout)
	------------------------------------------------------------
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	-- E.func_Header(layout, L["BINDING_HEADER_DEBUG"])
	----------------------------------------------------------------
	-- 1. Config_DebugID_ALL
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_DebugID_ALL"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show ID"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		-- setting:SetIsEnabledCallback(function() return false end)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end