local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Boss_Banner
tinsert(E.Modules, function()
	if OctoToDo_DB_Vars.config.Hide_Boss_Banner then
		BossBanner:HookScript("OnShow", function(self, ...)
			BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			BossBanner:UnregisterEvent("BOSS_KILL")
			-- BossBanner:UnregisterAllEvents()
			-- BossBanner:Hide()
		end)
	end
end)
