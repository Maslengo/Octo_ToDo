local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Covenant
tinsert(E.Octo_Globals.modules, function()
	if IsRetail() == true then
		if Octo_ToDo_DB_Vars.config.Hide_Covenant then
			CovenantChoiceToast:UnregisterAllEvents()
			CovenantRenownToast:UnregisterAllEvents()
		end
	end
end)