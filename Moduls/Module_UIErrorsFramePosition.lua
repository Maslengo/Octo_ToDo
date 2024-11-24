local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Module_UIErrorsFramePosition
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition then
			UIErrorsFrame:SetPoint("TOP", 0, -54)
			UIErrorsFrame:SetAlpha(0.7)
		end
end)