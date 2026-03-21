local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
function E.func_option_CURRENCY(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, CURRENCY)
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_ZERO ----------
	----------------------------------------------------------------
	-- do
	-- 	local variable = E.func_GenerateID()
	-- 	local variableKey = "CONFIG_CURRENCY_SHOW_ZERO"
	-- 	local variableTbl = Octo_ToDo_DB_Vars
	-- 	local name = L["Show zero values"] -- Всегда показывать нулевые значения
	-- 	local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
	-- 	-- local variableType = Settings.VarType.Boolean
	-- 	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
	-- 	setting:SetValueChangedCallback(E.func_UpdateGlobals)
	-- 	local tooltip = L["Shows currency even if zero"]
	-- 	Settings.CreateCheckbox(category, setting, tooltip)
	-- end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOR_ZERO ----------
	----------------------------------------------------------------
	-- do
	-- 	local name = COLOR
	-- 	local variableKey = "CONFIG_CURRENCY_COLOR_ZERO"
	-- 	local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
	-- 	local function GetValue()
	-- 		return Octo_ToDo_DB_Vars[variableKey] or defaultValue
	-- 	end
	-- 	local function SetValue(value)
	-- 		Octo_ToDo_DB_Vars[variableKey] = value
	-- 		-- if E.func_UpdateGlobals then E.func_UpdateGlobals() end
	-- 	end
	-- 	local setting = Settings.RegisterProxySetting(category, variableKey, type(defaultValue), name, defaultValue, GetValue, SetValue)
	-- 	-- Создаем цветовую палитру
	-- 	local initializer = Settings.CreateColorSwatch(category, setting)
	-- 	-- Патчим инициализатор чтобы включить альфу
	-- 	local originalCreate = initializer.CreateControl
	-- 	initializer.CreateControl = function(self, initializerData)
	-- 		local frame = originalCreate(self, initializerData)
	-- 		if frame and frame.ColorSwatch then
	-- 			frame.ColorSwatch:SetHasOpacity(true)
	-- 		end
	-- 		return frame
	-- 	end
	-- end
	----------------------------------------------------------------
	-- 3. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_BRACKETS ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_CURRENCY_SHOW_BRACKETS"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show progress (in parentheses)"] -- Показывать в скобках заработанной валюты за сезон/неделю, если есть лимит на получение (сезонное, еженедельное ограничение)
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = L["Shows earned amount in () if currency has weekly/seasonal cap"]
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 4. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOR_BRACKETS ----------
	----------------------------------------------------------------
	do
		local name = COLOR
		local variableKey = "CONFIG_CURRENCY_COLOR_BRACKETS"
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
	-- 5. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_REMAINING ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_CURRENCY_SHOW_REMAINING"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Show earnable amount"] -- Показывать сколько можно еще получить, если есть лимит на получения (сезонное, еженедельное ограничение)
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = L["Shows remaining amount if currency has weekly/seasonal cap"]
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 6. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOR_REMAINING ----------
	----------------------------------------------------------------
	do
		local name = COLOR
		local variableKey = "CONFIG_CURRENCY_COLOR_REMAINING"
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