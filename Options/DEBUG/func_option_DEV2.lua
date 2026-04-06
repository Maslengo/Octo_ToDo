local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_option_DEV2(category, layout)
	----------------------------------------------------------------
	local db = Octo_DevTool_DB
	----------------------------------------------------------------
	-- HEADER ------------------------------------------------------
	----------------------------------------------------------------
	E.func_Header(layout, L["Import"] .. "/" .. L["Export"])
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	do
		local name = L["Export"]
		local buttonText = L["button Text"]
		local function buttonClick()
			if not Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS then return end
			local str = E.getStringFromData(Octo_ToDo_DB_Levels, true)
			E.ShowImportExportFrame(str)
		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	do
		local name = L["Import"]
		local buttonText = L["button Text"]
		local function buttonClick()
			if not Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS then return end
			-- opde(E.OctoTable_KeystoneAbbr)
			E.ShowImportExportFrame()
		end
		E.func_Options_CreateButton(category, name, buttonText, buttonClick)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	do
		if E.Octo_DevTool_DB_DATA then
			local name = L["Import from file"]
			local buttonText = L["button Text"]
			local function buttonClick()
				if not Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS then return end
				local data = E.getDataFromString(E.Octo_DevTool_DB_DATA, true)
				if not data then
					E.func_PrintMessage("|cffff0000Import failed:|r", err)
					return
				end
				E.func_workWitchMyTable(data)
			end
			E.func_Options_CreateButton(category, name, buttonText, buttonClick)
		end
	end
	----------------------------------------------------------------
	-- 1 Config_Hide_ActionStatusText
	----------------------------------------------------------------
	-- do
	-- 	local variable = E.func_GenerateID()
	-- 	local variableKey = "Config_Hide_ActionStatusText"
	-- 	local name = variableKey -- "Текст статуса действий"
	-- 	local defaultValue = E.Octo_Moduls_DB_defaultOptions[variableKey]
	-- 	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, db, type(defaultValue), name, defaultValue)
	-- 	setting:SetValueChangedCallback(E.func_UpdateGlobals)
	-- 	local tooltip = L["CURSOR_SIZE_DEFAULT"]..": "..(defaultValue and L["YES"] or L["NO"]) -- "This is a tooltip for the checkbox."
	-- 	Settings.CreateCheckbox(category, setting, tooltip)
	-- end
	----------------------------------------------------------------
end