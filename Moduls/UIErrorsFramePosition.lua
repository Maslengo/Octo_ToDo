local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.UIErrorsFramePosition then
            UIErrorsFrame:SetPoint("TOP", 0, -54)
            UIErrorsFrame:SetAlpha(0.7)
            --UIErrorsFrame:SetScale(.7111111111111111)
            --UIErrorsFrame:Hide()
        end
end)