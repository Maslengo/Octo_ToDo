local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- ClearChat
tinsert(E.Octo_Globals.modules, function()
    if Octo_ToDo_DB_Vars.config.ClearChat then
        C_Timer.After(1, function() ChatFrame1:Clear() end)
    end
end)
