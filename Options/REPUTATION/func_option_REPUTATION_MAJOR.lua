local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_MAJOR(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["MAJOR"] .. "/" .. L["RENOWN"] .. E.COLOR_GRAY.." (repType == 3)|r")
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_MAJOR -------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_VALUE_MAJOR"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Value"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_PERCENTAGE_MAJOR --------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_PERCENTAGE_MAJOR"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Percentage"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_REACTION_MAJOR ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_REACTION_MAJOR"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Reaction"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_STANDINGS_MAJOR ---------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_STANDINGS_MAJOR"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Standings"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_MAJOR_COLOR ----------
	----------------------------------------------------------------
	do
		local name = L["COLOR"]
		local variableKey = "CONFIG_REPUTATION_MAJOR_COLOR"
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local variableTbl = Octo_ToDo_DB_Vars
		E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	end






end