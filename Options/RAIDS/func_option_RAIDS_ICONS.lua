local GlobalAddonName, E = ...
local L = E.L
function E.func_option_RAIDS_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])

	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.CONFIG_RAIDS_ICON ----------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ICON_FIRSTRAID) .. L["Icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end

	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.CONFIG_RAIDS_EXTRA_ICON ----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_RAIDS_EXTRA_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ATLAS_RAID) .. L["Extra icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end

	----------------------------------------------------------------
end