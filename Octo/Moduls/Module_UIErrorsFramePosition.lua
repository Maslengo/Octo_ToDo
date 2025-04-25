local GlobalAddonName, E = ...

-- Module_UIErrorsFramePosition
table.insert(E.Modules, function()
	if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.UIErrorsFramePosition then
		UIErrorsFrame:ClearAllPoints()
		UIErrorsFrame:SetPoint("TOP", UIParent, "TOP", 0, -54)
		UIErrorsFrame:SetAlpha(0.7)
	end
end)