local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
--RaidBossEmoteFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
			RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
			RaidBossEmoteFrame:UnregisterAllEvents()
			RaidBossEmoteFrame:Hide()
			-- RaidBossEmoteFrameSlot1:Hide()
			-- RaidBossEmoteFrameSlot2:Hide()
			ObjectiveTrackerBonusBannerFrame:Hide()
			ObjectiveTrackerBonusBannerFrame.BG1:Hide()
			ObjectiveTrackerBonusBannerFrame.BG2:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon2:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon3:Hide()
			ObjectiveTrackerBonusBannerFrame.BonusLabel:Hide()
			ObjectiveTrackerBonusBannerFrame.Title:Hide()
			ObjectiveTrackerBonusBannerFrame.TitleFlash:Hide()
		end
end)