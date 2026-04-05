local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CHARACTER(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Characters"])
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.Config_LevelToShow
	----------------------------------------------------------------
	do
		-- RegisterProxySetting example. This will run the GetValue and SetValue
		-- callbacks whenever access to the setting is required.
		local variable = E.func_GenerateID()
		local variableKey = "Config_LevelToShow"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Min. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		local function GetValue()
			return variableTbl[variableKey] or defaultValue
		end
		local function SetValue(value)
			variableTbl[variableKey] = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options, tooltip)
	end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	----------------------------------------------------------------
	do
		-- RegisterProxySetting example. This will run the GetValue and SetValue
		-- callbacks whenever access to the setting is required.
		local variable = E.func_GenerateID()
		local variableKey = "Config_LevelToShowMAX"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Max. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		local function GetValue()
			return variableTbl[variableKey] or defaultValue
		end
		local function SetValue(value)
			variableTbl[variableKey] = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options, tooltip)
	end
	----------------------------------------------------------------
	-- 3. isOnlyCurrentBtag
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentBtag"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current BattleTag"]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 5. ShowOnlyCurrentRegion
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "ShowOnlyCurrentRegion"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Region"]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 3. isOnlyCurrentServer
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentServer"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Server"]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 4. isOnlyCurrentFaction
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
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		Settings.CreateCheckbox(category, setting, tooltip)
	end
end