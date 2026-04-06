local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
function E.func_option_FONT(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	E.func_Header(layout, L["Font"])
	----------------------------------------------------------------
	-- 1 Кастомный Dropdown
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	----------------------------------------------------------------
	do
		E.func_Options_CreateDropdown_FontStyle(category, layout)
	end
	----------------------------------------------------------------
	-- 2 Settings.CreateSlider
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	----------------------------------------------------------------
	do
		local name = L["FONT_SIZE"]
		local defaultValue = 11
		local minValue = 8
		local maxValue = 32
		local step = 1
		Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
		Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
		Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
		local variableTbl = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang]
		local variableKey = "Config_FontSize"
		-- local function GetValue()
		-- 	return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or defaultValue
		-- end
		-- local function SetValue(value)
		-- 	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = value
		-- end
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- 3 Settings.CreateDropdown
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
	----------------------------------------------------------------
	do
		local variableKey = "Config_FontFlags"
		local variableTbl = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang]
		local name = L["Font Outline"]
		local defaultValue = "OUTLINE"
		-- local tbl = {
		-- 	[""] = NPC_NAMES_DROPDOWN_NONE,
		-- 	["MONOCHROME"] = "MONOCHROME",
		-- 	["OUTLINE"] = "OUTLINE",
		-- 	["THICKOUTLINE"] = "THICKOUTLINE",
		-- 	["MONOCHROME, OUTLINE"] = "MONOCHROME, OUTLINE",
		-- 	["MONOCHROME, THICKOUTLINE"] = "MONOCHROME, THICKOUTLINE",
		-- }
		local values = {
			{value = "", text = NPC_NAMES_DROPDOWN_NONE},
			{value = "MONOCHROME", text = "MONOCHROME"},
			{value = "OUTLINE", text = "OUTLINE"},
			{value = "THICKOUTLINE", text = "THICKOUTLINE"},
			{value = "MONOCHROME, OUTLINE", text = "MONOCHROME, OUTLINE"},
			{value = "MONOCHROME, THICKOUTLINE", text = "MONOCHROME, THICKOUTLINE"},
		}
		E.func_Options_CreateDropdown(category, variableKey, variableTbl, name, defaultValue, values, tooltip)
	end
	----------------------------------------------------------------
end