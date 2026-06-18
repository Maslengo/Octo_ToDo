local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_PARAGON(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["PARAGON"] .. E.COLOR_GRAY.." (repType == 4)|r")
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_VALUE_PARAGON -----------
	----------------------------------------------------------------
	do
		local name = L["Value"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_VALUE_PARAGON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_PERCENTAGE_PARAGON ------
	----------------------------------------------------------------
	do
		local name = L["Percentage"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_PERCENTAGE_PARAGON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_REACTION_PARAGON --------
	----------------------------------------------------------------
	do
		local name = L["Reaction"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_REACTION_PARAGON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_STANDINGS_PARAGON -------
	----------------------------------------------------------------
	do
		local name = L["Standings"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_STANDINGS_PARAGON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_PARAGON_COLOR ----------
	----------------------------------------------------------------
	do
		local name = L["COLOR"]
		local variableKey = "CONFIG_REPUTATION_PARAGON_COLOR"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
end