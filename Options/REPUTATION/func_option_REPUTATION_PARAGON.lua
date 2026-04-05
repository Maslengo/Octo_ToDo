local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_PARAGON(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["PARAGON"] .. E.COLOR_GRAY.." (repType == 4)|r")
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_PARAGON -----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_VALUE_PARAGON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Value"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_PERCENTAGE_PARAGON ------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_PERCENTAGE_PARAGON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Percentage"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_REACTION_PARAGON --------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_REACTION_PARAGON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Reaction"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_STANDINGS_PARAGON -------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_STANDINGS_PARAGON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Standings"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_PARAGON_COLOR ----------
	----------------------------------------------------------------
	do
		local name = L["COLOR"]
		local variableKey = "CONFIG_REPUTATION_PARAGON_COLOR"
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local function GetValue()
			return Octo_ToDo_DB_Vars[variableKey] or defaultValue
		end
		local function SetValue(value)
			Octo_ToDo_DB_Vars[variableKey] = value
			-- if E.func_UpdateGlobals then E.func_UpdateGlobals() end
		end
		local setting = Settings.RegisterProxySetting(category, variableKey, type(defaultValue), name, defaultValue, GetValue, SetValue)
		-- Создаем цветовую палитру
		local initializer = Settings.CreateColorSwatch(category, setting)
		-- Патчим инициализатор чтобы включить альфу
		local originalCreate = initializer.CreateControl
		initializer.CreateControl = function(self, initializerData)
			local frame = originalCreate(self, initializerData)
			if frame and frame.ColorSwatch then
				frame.ColorSwatch:SetHasOpacity(true)
			end
			return frame
		end
	end




end