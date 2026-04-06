local GlobalAddonName, E = ...
local L = E.L
function E.func_option_OTHER(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	E.func_Header(layout, L["OTHER"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_numberFormatMode -------------------
	----------------------------------------------------------------
	do
		local variableKey = "Config_numberFormatMode"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Number Format"]
		local defaultValue = 1
		-- local values = {
		-- 		[1] = L["Universal"],
		-- 		[2] = L["Localized"],
		-- 		[3] = L["With separators"],
		-- 		[4] = L["Full"],
		-- 		[5] = "Blizzard",
		-- 		[6] = L["Clean"],
		-- }
		local values = {
			{value = 1, text = L["Universal"]},
			{value = 2, text = L["Localized"]},
			{value = 3, text = L["With separators"]},
			{value = 4, text = L["Full"]},
			{value = 5, text = "Blizzard"},
			{value = 6, text = L["Clean"]},
		}
		E.func_Options_CreateDropdown(category, variableKey, variableTbl, name, defaultValue, values, tooltip)
	end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT
	----------------------------------------------------------------
	do
		local variableKey = "Config_ADDON_HEIGHT"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = 20
		local name = E.COLOR_RED..">|r"..L["Line Height"]..E.COLOR_RED.."<|r"
		local minValue = 10
		local maxValue = 40
		local step = 1
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- 3. Octo_ToDo_DB_Vars.Config_ClampedToScreen -----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_ClampedToScreen"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Clamped To Screen"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end