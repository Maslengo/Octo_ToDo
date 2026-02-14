local GlobalAddonName, E = ...
local L = E.L

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end


function E.func_option_DEBUG(category, layout)
	------------------------------------------------------------
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	func_Header(layout, BINDING_HEADER_DEBUG)
	----------------------------------------------------------------
	-- 1. Config_DebugID_ALL
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_DebugID_ALL"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show ID"]
		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = CURSOR_SIZE_DEFAULT..": "..NO
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end