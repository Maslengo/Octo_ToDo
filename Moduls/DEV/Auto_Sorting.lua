local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- AutoSorting
tinsert(E.Octo_Globals.modules, function()
				if E.Octo_Func.Octo_IsRetail() == true then
	if Octo_ToDo_DB_Vars.config.SORTING then
		if E.Octo_Globals.isElvUI == true and not InCombatLockdown() then
			C_Timer.After(1, function()
				C_Container.SetSortBagsRightToLeft(false)
				C_Container.SetInsertItemsLeftToRight(false)
			end)
		end
		if E.Octo_Globals.isElvUI == false and not InCombatLockdown() then
			C_Timer.After(1, function()
				C_Container.SetSortBagsRightToLeft(false)
				C_Container.SetInsertItemsLeftToRight(false)
				C_Container.SortBags()
			end)
		end
	end
end
end)
