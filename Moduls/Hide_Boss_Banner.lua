local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--BossBanner
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.BossBanner then
			BossBanner:HookScript("OnShow", function(self, ...)
					BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
					BossBanner:UnregisterEvent("BOSS_KILL")
					-- BossBanner:UnregisterAllEvents()
					-- BossBanner:Hide()
			end)
		end
end)