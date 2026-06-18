local GlobalAddonName, E = ...
local L = E.L
function E.func_option_ITEMS_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_ITEMS_ICON -------------------------
	----------------------------------------------------------------
	do
		local name = E.func_texturefromIcon(E.func_GetIcon("item", 36942)) .. L["Icon"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ITEMS_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end