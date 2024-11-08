local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Module_UIErrorsFramePosition
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition then
			UIErrorsFrame:SetPoint("TOP", 0, -54)
			UIErrorsFrame:SetAlpha(0.7)
		end
end)