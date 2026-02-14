local GlobalAddonName, E = ...
local L = E.L

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end


function E.func_option_OTHER(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	func_Header(layout, OTHER)
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_numberFormatMode -------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local defaultValue = 1
		local name = L["Number Format"]
		local db = Octo_ToDo_DB_Vars
		-- NAME, VALUE
		local tbl = {
			[1] = L["Universal"], -- "Универсальный"
			[2] = L["Localized"], -- "Локализованный"
			[3] = L["With separators"], -- "С разделителями"
			[4] = L["Full"], -- "Полный"
			[5] = "Blizzard", -- "Blizzard"
			[6] = L["Clean"], -- "Минималистичный"
		}
		local function GetValue()
			for value, name in ipairs(tbl) do
				if value == db.Config_numberFormatMode then
					return value
				end
			end
			return defaultValue
		end
		local function SetValue(value)
			db.Config_numberFormatMode = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local function GetFontOptions()
			local container = Settings.CreateControlTextContainer()
			for value, name in ipairs(tbl) do
				container:Add(value, name) -- container:Add(value, name)
			end
			return container:GetData()
		end
		Settings.CreateDropdown(category, setting, GetFontOptions)
	end



	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_ADDON_HEIGHT
	----------------------------------------------------------------
	do
		-- RegisterProxySetting example. This will run the GetValue and SetValue
		-- callbacks whenever access to the setting is required.
		local variable = E.func_GenerateID()
		local name = E.COLOR_RED..">|r"..L["Line Height"]..E.COLOR_RED.."<|r"
		local defaultValue = 20
		local minValue = 10
		local maxValue = 40
		local step = 1
		local db = Octo_ToDo_DB_Vars
		local function GetValue()
			return db.Config_ADDON_HEIGHT or defaultValue
		end
		local function SetValue(value)
			db.Config_ADDON_HEIGHT = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = E.COLOR_RED..L["Changes require a ReloadUI"].."|r"
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options, tooltip)
	end
	----------------------------------------------------------------
	-- 3. Octo_ToDo_DB_Vars.Config_ClampedToScreen -----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_ClampedToScreen"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Clamped To Screen"]
		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = CURSOR_SIZE_DEFAULT..": "..NO -- "This is a tooltip for the checkbox."
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
end