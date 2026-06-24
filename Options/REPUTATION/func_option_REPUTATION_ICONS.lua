local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_ICON --------------------
	----------------------------------------------------------------
	do
		local icon = E.ICON_TABARD
		local name = E.func_texturefromIcon(icon)..L["Icon"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_EXTRA_ICON ---------
	----------------------------------------------------------------
	do
		local name = E.func_texturefromIcon("MajorFactions_Icons_Valdrakken512")..L["Extra icon"] -- "majorfactions_icons_light512" -- 2710 Silvermoon Court
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_EXTRA_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_FACTION_ICON ---------------
	----------------------------------------------------------------
	do
		local name = E.func_texturefromIcon(E.ICON_CURRENT_FACTION)..L["Faction icon"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_FACTION_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_WARBAND_ICON ------------
	----------------------------------------------------------------
	do
		local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_WARBAND_ICON"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end