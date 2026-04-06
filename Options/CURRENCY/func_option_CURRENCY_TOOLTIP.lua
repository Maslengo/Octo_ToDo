local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_TOOLTIP(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Tooltip"])
	----------------------------------------------------------------
	-- 6. Octo_ToDo_DB_Vars.Config_MountsInTooltip -----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_MountsInTooltip"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["ACCESSIBILITY_MOUNT_LABEL"] .. E.COLOR_RED .. "*|r" -- "Средства передвижения" TUTORIAL_TITLE53
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		tooltip = L["Shows mounts available for this currency in the tooltip"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end