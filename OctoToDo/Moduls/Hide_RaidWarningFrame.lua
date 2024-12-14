local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_RaidWarningFrame
tinsert(E.Modules, function()
	if OctoToDo_DB_Vars.config.Hide_RaidWarningFrame then
		RaidWarningFrame:HookScript("OnShow", function(self, ...)
			-- RaidWarningFrame:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			-- RaidWarningFrame:UnregisterEvent("BOSS_KILL")
			RaidWarningFrame:UnregisterAllEvents()
			RaidWarningFrame:Hide()
		end)
		RaidBossEmoteFrame:HookScript("OnShow", function(self, ...)
			-- RaidBossEmoteFrame:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			-- RaidBossEmoteFrame:UnregisterEvent("BOSS_KILL")
			print ("RaidBossEmoteFrame HIDE")
			RaidBossEmoteFrame:UnregisterAllEvents()
			RaidBossEmoteFrame:Hide()
		end)


	end
end)
