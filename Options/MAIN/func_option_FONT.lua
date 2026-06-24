local GlobalAddonName, E = ...
local L = E.L

function E.func_option_FONT(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	E.func_Header(layout, L["Font"])
	----------------------------------------------------------------
	-- 1 Кастомный Dropdown
	-- Config_FontStyle
	----------------------------------------------------------------
	do
		E.func_Options_CreateDropdown_FontStyle(category, layout)
	end
	----------------------------------------------------------------
	-- 2 Settings.CreateSlider
	-- Config_FontSize
	----------------------------------------------------------------
	do
		local name = L["FONT_SIZE"]
		local defaultValue = 11
		local minValue = 8
		local maxValue = 32
		local step = 1
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local variableKey = "Config_FontSize"
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- 3 Settings.CreateDropdown
	-- Config_FontFlags
	----------------------------------------------------------------
	do
		local variableKey = "Config_FontFlags"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Font Outline"]
		local defaultValue = "OUTLINE"
		local values = {
			{value = "", text = NPC_NAMES_DROPDOWN_NONE},
			{value = "MONOCHROME", text = "MONOCHROME"},
			{value = "OUTLINE", text = "OUTLINE"},
			{value = "THICKOUTLINE", text = "THICKOUTLINE"},
			{value = "MONOCHROME, OUTLINE", text = "MONOCHROME, OUTLINE"},
			{value = "MONOCHROME, THICKOUTLINE", text = "MONOCHROME, THICKOUTLINE"},
		}
		E.func_Options_CreateDropdown(category, variableKey, variableTbl, name, defaultValue, values, tooltip)
	end
	----------------------------------------------------------------
end