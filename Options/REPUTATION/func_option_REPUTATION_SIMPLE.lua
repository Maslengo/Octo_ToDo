local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_SIMPLE(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["SIMPLE"] .. E.COLOR_GRAY.." (repType == 1)|r")
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_SIMPLE ------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_VALUE_SIMPLE"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Value"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_SIMPLE -------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_PERCENTAGE_SIMPLE"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Percentage"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_SIMPLE ---------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_REACTION_SIMPLE"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Reaction"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_VALUE_SIMPLE --------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_STANDINGS_SIMPLE"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Standings"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.func_defaultValue_tooltip(defaultValue)
		local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_8 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL8"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_8"
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
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_7 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL7"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_7"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_6 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL6"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_6"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_5 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL5"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_5"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_4 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL4"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_4"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_3 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL3"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_3"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_2 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL2"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_2"
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

	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_SIMPLE_COLOR_1 ----------
	----------------------------------------------------------------
	do
		local name = L["FACTION_STANDING_LABEL1"]
		local variableKey = "CONFIG_REPUTATION_SIMPLE_COLOR_1"
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
	----------------------------------------------------------------



end