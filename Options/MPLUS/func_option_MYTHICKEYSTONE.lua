local GlobalAddonName, E = ...
local L = E.L
function E.func_option_MYTHICKEYSTONE(category, layout)

	-- ["CUURENTKEY"] = {
	-- 	BEST
	-- 	RIO
	-- 	HISTORY
	-- }

	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["WEEKLY_REWARDS_MYTHIC_KEYSTONE"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE ----
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Advanced Tooltip"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end