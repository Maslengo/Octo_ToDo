local GlobalAddonName, E = ...
local L = E.L
function E.func_option_MINIMAP(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	E.func_Header(layout, L["MINIMAP_LABEL"])
	----------------------------------------------------------------
	-- 3. Octo_ToDo_DB_Vars.CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER -----------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show on hover"]
		local tooltip = L["Show frame automatically when mouse is over the minimap button"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_HOVER_SHOW_DURATION ----------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_HOVER_SHOW_DURATION"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Hide Delay (sec.)"] -- L["Show on hover"]
		local minValue = 0
		local maxValue = 10
		if E.DEBUG then maxValue = 100 end
		local step = 1
		local tooltip -- = L["TIME_LABEL"] -- .. string.format(L["SECONDS_FLOAT_ABBR"], Octo_ToDo_DB_Vars.CONFIG_HOVER_SHOW_DURATION)
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_FRAME_ALPHA_ON_HOVER ---------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_FRAME_ALPHA_ON_HOVER"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Alpha"] .. " %"
		local minValue = 50
		local maxValue = 100
		local step = 1
		local tooltip
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
end