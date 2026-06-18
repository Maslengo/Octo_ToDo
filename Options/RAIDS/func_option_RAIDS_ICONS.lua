local GlobalAddonName, E = ...
local L = E.L
function E.func_option_RAIDS_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])

	----------------------------------------------------------------
	-- 1. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_RAIDS_ICON ----------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = E.func_texturefromIcon(E.ICON_FIRSTRAID) .. L["Icon"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end

	----------------------------------------------------------------
	-- 2. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_RAIDS_EXTRA_ICON ----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_EXTRA_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = E.func_texturefromIcon(E.ATLAS_RAID) .. L["Extra icon"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end

	----------------------------------------------------------------
end