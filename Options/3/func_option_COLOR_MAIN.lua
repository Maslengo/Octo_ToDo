local GlobalAddonName, E = ...
local L = E.L
local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end
function E.func_option_COLOR_MAIN(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	func_Header(layout, L["Main Frame Colors"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Colors.textColor
	----------------------------------------------------------------
	do
		local db = Octo_ToDo_DB_Vars
		db.Colors = db.Colors or {}
		local name = "Main Color1"
		local variableKey = "textColor1"
		local defaultValue = "FFFFFFFF" -- ff0052ff
		local function GetValue()
			return db.Colors[variableKey] or defaultValue
		end
		local function SetValue(value)
			db.Colors[variableKey] = value
			if E.func_UpdateGlobals then E.func_UpdateGlobals() end
		end
		local options = {
			hasAlpha = true, -- НЕ РАБОТАЕТ
			ColorPickerHasAlpha = true, -- НЕ РАБОТАЕТ
		}
		local setting = Settings.RegisterProxySetting(category, variableKey, type(defaultValue), name, defaultValue, GetValue, SetValue)
		Settings.CreateColorSwatch(category, setting, tooltip, options)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	do
		local db = Octo_ToDo_DB_Vars
		db.Colors = db.Colors or {}
		local name = "Main Color2"
		local variableKey = "textColor2"
		local defaultValue = "FFFFFFFF" -- AARRGGBB
		local function GetValue()
			return db.Colors[variableKey] or defaultValue
		end
		local function SetValue(value)
			db.Colors[variableKey] = value
			if E.func_UpdateGlobals then E.func_UpdateGlobals() end
		end
		-- Нужно использовать кастомный инициализатор для включения альфы
		local function CreateColorSwatchWithAlpha(initializerData)
			local frame = CreateFrame("Frame", nil, nil, "SettingsColorSwatchControlTemplate")
			frame:OnLoad()
			-- Включаем поддержку альфы
			if frame.ColorSwatch then
				frame.ColorSwatch:SetHasOpacity(true)
			end
			-- Инициализируем с данными
			if frame.Init then
				frame:Init(initializerData)
			end
			return frame
		end
		local setting = Settings.RegisterProxySetting(category, variableKey, type(defaultValue), name, defaultValue, GetValue, SetValue)
		-- Создаем кастомный инициализатор
		local data = {
			setting = setting,
			name = name,
			options = { hasOpacity = true },
			tooltip = nil
		}
		local initializer = Settings.CreateElementInitializer("SettingsColorSwatchControlTemplate", data)
		initializer.CreateControl = CreateColorSwatchWithAlpha
		layout:AddInitializer(initializer)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	do
		local db = Octo_ToDo_DB_Vars
		db.Colors = db.Colors or {}
		local name = "Main Color3"
		local variableKey = "textColor3"
		local defaultValue = "FFFFFFFF"
		local function GetValue()
			return db.Colors[variableKey] or defaultValue
		end
		local function SetValue(value)
			db.Colors[variableKey] = value
			if E.func_UpdateGlobals then E.func_UpdateGlobals() end
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
	----------------------------------------------------------------
	----------------------------------------------------------------
end