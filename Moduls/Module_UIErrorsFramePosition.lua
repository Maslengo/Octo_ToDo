local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition then
			UIErrorsFrame:SetPoint("TOP", 0, -54)
			UIErrorsFrame:SetAlpha(0.7)
			-- /run UIErrorsFrame:SetScale(2)
			--UIErrorsFrame:SetScale(.7111111111111111)
			--UIErrorsFrame:Hide()
		end
end)