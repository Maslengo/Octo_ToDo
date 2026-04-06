local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	-- E.func_Header(layout, CURRENCY)
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.CONFIG_CURRENCY_SHOW_ZERO ----------
	----------------------------------------------------------------
	-- do
	-- 	local variable = E.func_GenerateID()
	-- 	local variableKey = "CONFIG_CURRENCY_SHOW_ZERO"
	-- 	local variableTbl = Octo_ToDo_DB_Vars
	-- 	local name = L["Show zero values"] -- Всегда показывать нулевые значения
	-- 	local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
	-- 	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
	-- 	setting:SetValueChangedCallback(E.func_UpdateGlobals)

	-- local tooltip = E.func_defaultValue_tooltip(defaultValue)
	-- 	local initializer = Settings.CreateCheckbox(category, setting, tooltip)
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
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_ICON ----------------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_CURRENCY_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.func_GetIcon("currency", 1166)) .. L["Icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_CURRENCY_WARBAND_ICON --------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_CURRENCY_WARBAND_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end