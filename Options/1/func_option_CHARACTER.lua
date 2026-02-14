local GlobalAddonName, E = ...
local L = E.L

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end


function E.func_option_CHARACTER(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	func_Header(layout, L["Characters"])
	----------------------------------------------------------------




	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_LevelToShow
	----------------------------------------------------------------
	do
		-- RegisterProxySetting example. This will run the GetValue and SetValue
		-- callbacks whenever access to the setting is required.
		local variable = E.func_GenerateID()
		local name = L["Min. Level"]
		local defaultValue = 1
		local minValue = 1
		local maxValue = 90
		local step = 1
		local db = Octo_ToDo_DB_Vars
		local function GetValue()
			return db.Config_LevelToShow or defaultValue
		end
		local function SetValue(value)
			db.Config_LevelToShow = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = E.COLOR_RED..L["Changes require a ReloadUI"].."|r"
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
		local name = L["Max. Level"]
		local defaultValue = 90
		local minValue = 1
		local maxValue = 90
		local step = 1
		local db = Octo_ToDo_DB_Vars
		local function GetValue()
			return db.Config_LevelToShowMAX or defaultValue
		end
		local function SetValue(value)
			db.Config_LevelToShowMAX = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = E.COLOR_RED..L["Changes require a ReloadUI"].."|r"
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options, tooltip)
	end






	----------------------------------------------------------------
	-- 3. isOnlyCurrentServer
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentServer"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Only Current Server"]
		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = CURSOR_SIZE_DEFAULT..": "..NO -- "This is a tooltip for the checkbox."
		Settings.CreateCheckbox(category, setting, tooltip)
	end


	----------------------------------------------------------------
	-- 4. isOnlyCurrentFaction
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "isOnlyCurrentFaction"
		local variableTbl = Octo_ToDo_DB_Vars
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
		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = CURSOR_SIZE_DEFAULT..": "..NO -- "This is a tooltip for the checkbox."
		Settings.CreateCheckbox(category, setting, tooltip)
	end


	----------------------------------------------------------------
	-- 5. ShowOnlyCurrentRegion
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "ShowOnlyCurrentRegion"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = L["Only Current Region"]
		local defaultValue = true -- Settings.Default.True
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- local tooltip = CURSOR_SIZE_DEFAULT..": "..NO -- "This is a tooltip for the checkbox."
		Settings.CreateCheckbox(category, setting, tooltip)
	end






end