local GlobalAddonName, E = ...
local L = E.L

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end


function E.func_option_TOOLTIP(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	func_Header(layout, L["Tooltip"]) --  .. " ("..HUD_EDIT_MODE_HUD_TOOLTIP_LABEL..")"
	----------------------------------------------------------------
	-- 1. Octo_ToDo_DB_Vars.Config_ShowAllDifficulties -------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_ShowAllDifficulties"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ATLAS_RAID, nil, nil, true) .. L["All Difficulties"]
		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = L["Shows all raid difficulties in the tooltip"]
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_DifficultyAbbreviation ----------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_DifficultyAbbreviation"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ATLAS_RAID, nil, nil, true) .. L["Abbreviation"]
		local defaultValue = true -- Settings.Default.True
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = L["Use English abbreviations for raid and dungeon difficulties instead of full names"]
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
	-- 2. Octo_ToDo_DB_Vars.Config_MountsInTooltip -----------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_MountsInTooltip"
		local variableTbl = Octo_ToDo_DB_Vars
		-- local name = MOUNTS -- "Транспорт"
		local name = ACCESSIBILITY_MOUNT_LABEL.. E.COLOR_RED.."*|r" -- "Средства передвижения" TUTORIAL_TITLE53


		local defaultValue = false -- Settings.Default.False
		-- local variableType = Settings.VarType.Boolean
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local tooltip = L["Shows mounts available for this currency in the tooltip"]
		Settings.CreateCheckbox(category, setting, tooltip)
	end
	----------------------------------------------------------------
end