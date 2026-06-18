local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_TOOLTIP(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Tooltip"])
	----------------------------------------------------------------
	-- 6. E.func_GetProfile_SETTINGS_CURRENT().Config_MountsInTooltip -----------------
	----------------------------------------------------------------
	do
		local name = L["ACCESSIBILITY_MOUNT_LABEL"] .. E.COLOR_RED .. "*|r" -- "Средства передвижения" TUTORIAL_TITLE53
		local variable = E.func_GenerateID()
		local variableKey = "Config_MountsInTooltip"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		tooltip = L["Shows mounts available for this currency in the tooltip"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end