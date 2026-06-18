local GlobalAddonName, E = ...
local L = E.L
function E.func_option_MINIMAP(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	E.func_Header(layout, L["MINIMAP_LABEL"])
	----------------------------------------------------------------
	-- 3. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER -----------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Show on hover"]
		local tooltip = L["Show frame automatically when mouse is over the minimap button"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_HOVER_SHOW_DURATION ----------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_HOVER_SHOW_DURATION"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local name = L["Hide Delay (sec.)"] -- L["Show on hover"]
		local minValue = 0
		local maxValue = 10
		if E.DEBUG then maxValue = 100 end
		local step = 1
		local tooltip -- = L["TIME_LABEL"] -- .. string.format(L["SECONDS_FLOAT_ABBR"], E.func_GetProfile_SETTINGS_CURRENT().CONFIG_HOVER_SHOW_DURATION)
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_FRAME_ALPHA_ON_HOVER ---------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_FRAME_ALPHA_ON_HOVER"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local name = L["Alpha"] .. " %"
		local minValue = 50
		local maxValue = 100
		local step = 1
		local tooltip
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
end