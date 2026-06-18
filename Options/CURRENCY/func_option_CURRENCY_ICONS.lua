local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CURRENCY_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	-- E.func_Header(layout, CURRENCY)
	----------------------------------------------------------------
	-- 1. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_SHOW_ZERO ----------
	----------------------------------------------------------------
	-- do
	-- 	local variable = E.func_GenerateID()
	-- 	local variableKey = "CONFIG_CURRENCY_SHOW_ZERO"
	-- 	local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
	-- 	local name = L["Show zero values"] -- Всегда показывать нулевые значения
	-- 	local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
	-- 	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
	-- 	setting:SetValueChangedCallback(E.func_UpdateGlobals)

	-- local tooltip = E.func_defaultValue_tooltip(defaultValue)
	-- 	local initializer = Settings.CreateCheckbox(category, setting, tooltip)
	-- end
	----------------------------------------------------------------
	-- 2. E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_COLOR_ZERO ----------
	----------------------------------------------------------------
	-- do
	-- 	local name = COLOR
	-- 	local variableKey = "CONFIG_CURRENCY_COLOR_ZERO"
	-- 	local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
	-- 	local function GetValue()
	-- 		return E.func_GetProfile_SETTINGS_CURRENT()[variableKey] or defaultValue
	-- 	end
	-- 	local function SetValue(value)
	-- 		E.func_GetProfile_SETTINGS_CURRENT()[variableKey] = value
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
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_ICON ----------------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_CURRENCY_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = E.func_texturefromIcon(E.func_GetIcon("currency", 1166)) .. L["Icon"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_CURRENCY_WARBAND_ICON --------------
	----------------------------------------------------------------
	do
		local variableKey = "CONFIG_CURRENCY_WARBAND_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end