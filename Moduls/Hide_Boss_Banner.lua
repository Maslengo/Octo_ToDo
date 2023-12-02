local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--BossBanner
tinsert(E.Octo_Globals.modules, function()
				if E.Octo_Func.Octo_IsRetail() == true then
		if Octo_ToDo_DB_Vars.config.Hide_Boss_Banner then
			BossBanner:HookScript("OnShow", function(self, ...)
					BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
					BossBanner:UnregisterEvent("BOSS_KILL")
					-- BossBanner:UnregisterAllEvents()
					-- BossBanner:Hide()
			end)
		end
	end
end)