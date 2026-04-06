local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CHARACTER(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Characters"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_LevelToShow ------------------------
	----------------------------------------------------------------
	do
		local variableKey = "Config_LevelToShow"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Min. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_LevelToShowMAX ---------------------
	----------------------------------------------------------------
	do
		local variableKey = "Config_LevelToShowMAX"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Max. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentBtag -------------------------------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentBtag"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current BattleTag"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- ShowOnlyCurrentRegion ---------------------------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "ShowOnlyCurrentRegion"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Region"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentServer -----------------------------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentServer"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Server"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentFaction ----------------------------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentFaction"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local function funcName()
			local result = ""
			if E.FACTION_CURRENT == "Horde" then
				result = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
			else
				result = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
			end
			return result
		end
		local name = funcName()
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
end