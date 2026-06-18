local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_SIMPLE(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["SIMPLE"] .. E.COLOR_GRAY.." (repType == 1)|r")
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_VALUE_SIMPLE ------------
	----------------------------------------------------------------
	do
		local name = L["Value"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_VALUE_SIMPLE"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_VALUE_SIMPLE -------
	----------------------------------------------------------------
	do
		local name = L["Percentage"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_PERCENTAGE_SIMPLE"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_VALUE_SIMPLE ---------
	----------------------------------------------------------------
	do
		local name = L["Reaction"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_REACTION_SIMPLE"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_VALUE_SIMPLE --------
	----------------------------------------------------------------
	do
		local name = L["Standings"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_STANDINGS_SIMPLE"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_8 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL8"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_8"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_7 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL7"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_7"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_6 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL6"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_6"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_5 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL5"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_5"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_4 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL4"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_4"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_3 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL3"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_3"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_2 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL2"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_2"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_SIMPLE_COLOR_1 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL1"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_1"
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end
	----------------------------------------------------------------
end