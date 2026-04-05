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
		-- local name = MOUNTS -- "Транспорт"
		local name = ACCESSIBILITY_MOUNT_LABEL.. E.COLOR_RED.."*|r" -- "Средства передвижения" TUTORIAL_TITLE53
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		tooltip = tooltip.."|n|n"..L["Shows mounts available for this currency in the tooltip"]
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
end