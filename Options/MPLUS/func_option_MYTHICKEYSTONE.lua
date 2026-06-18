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
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE ----
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Advanced Tooltip"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end