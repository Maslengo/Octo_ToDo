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
			if not E.DEBUG then return end
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
			if not E.DEBUG then return end
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
				if not E.DEBUG then return end
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
end