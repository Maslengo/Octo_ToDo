local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Covenant
tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.config.Hide_Covenant then
		CovenantChoiceToast:UnregisterAllEvents()
		CovenantRenownToast:UnregisterAllEvents()
	end
end)