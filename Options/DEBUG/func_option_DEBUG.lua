local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_option_DEBUG(category, layout)
	------------------------------------------------------------
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	-- E.func_Header(layout, L["ID"])
	----------------------------------------------------------------
	-- E.func_GetProfile_SETTINGS_CURRENT().Config_DebugID_ALL
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local variableKey = "Config_DebugID_ALL"
		local variableTbl = E.func_GetProfile_SETTINGS_CURRENT()
		local name = L["Show ID"]
		local defaultValue = E.DEFAULT_SETTINGS_FORPROFILE[variableKey]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	do
		local name = nil
		local buttonText = L["BROWSER_CLEAR_CACHE"]
		local tooltip = "table: Octo_Cache_DB"
		local function buttonClick()
			Octo_Cache_DB = nil
			E.Init_Octo_Cache_DB()
			E.func_BUILD_DUNG_DB()
		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick, tooltip)
	end
	----------------------------------------------------------------
	do
		local name = nil
		local buttonText = L["RESET"] .. ": " .. L["Characters"]
		local tooltip = "table: Octo_ToDo_DB_Levels"
		local function buttonClick()
			Octo_ToDo_DB_Levels = nil
			E.init_Octo_ToDo_DB_Levels()
		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick, tooltip)
	end
	----------------------------------------------------------------
	do
		local name = nil
		local buttonText = L["RESET"] .. ": " .. L["ALL"]
		local tooltip = nil
		local function buttonClick()
			Octo_DevTool_DB = nil
			Octo_Todo_DB_Profiles = nil
			-- Octo_ToDo_DB_Levels = nil
			Octo_Cache_DB = nil
			Octo_ToDo_DB_AccountData = nil

			E.WTF_func_CheckAll()

			E.func_BUILD_DUNG_DB()
			E.func_UpdateGlobals()
			E.func_UpdateFont()

		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick, tooltip)
	end
	----------------------------------------------------------------
	do
		local name = nil
		local buttonText = L["RELOADUI"]
		local tooltip = nil
		local function buttonClick()
			ReloadUI()
		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick, tooltip)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
end