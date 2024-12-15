local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Module_UIErrorsFramePosition
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.UIErrorsFramePosition then
			UIErrorsFrame:SetPoint("TOP", 0, -54)
			UIErrorsFrame:SetAlpha(0.7)
		end
end)