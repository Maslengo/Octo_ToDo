local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Covenant
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.Covenant then
            CovenantChoiceToast:UnregisterAllEvents()
            CovenantRenownToast:UnregisterAllEvents()
        end
end)