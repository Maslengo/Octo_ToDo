local GlobalAddonName, E = ...
local L = E.L
function E.func_option_REPUTATION_ICONS(category, layout)
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Icons"])
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_ICON --------------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local icon = E.ICON_TABARD
		local name = E.func_texturefromIcon(icon)..L["Icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_EXTRA_ICON ---------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_EXTRA_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local icon = "MajorFactions_Icons_Valdrakken512" -- "majorfactions_icons_light512" -- 2710 Silvermoon Court
		local name = E.func_texturefromIcon(icon)..L["Extra icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_FACTION_ICON ---------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_FACTION_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local icon = E.ICON_CURRENT_FACTION
		local name = E.func_texturefromIcon(icon)..L["Faction icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.CONFIG_REPUTATION_WARBAND_ICON ------------
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "CONFIG_REPUTATION_WARBAND_ICON"
		local variableTbl = Octo_ToDo_DB_Vars
		local name = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. L["Warband icon"]
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]

		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
end