local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")




-- TalkingHeadFrame
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			self:Hide()
			print("|cFF00A3FFTalking head frame|r |cffFF4C4Fcanceled.|r")
		end)
	end
end)



--HideObjectiveTracker
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.HideObjectiveTracker then
		ObjectiveTrackerFrame:Hide()
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--HideZoneText
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.HideZoneText then
		ZoneTextFrame:UnregisterAllEvents()
		EventToastManagerFrame:UnregisterAllEvents()
	end
end)

	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--Covenant
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.Covenant then
		CovenantChoiceToast:UnregisterAllEvents()
		CovenantRenownToast:UnregisterAllEvents()
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--UIErrorsFrame
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.UIErrorsFrame then
		UIErrorsFrame:Hide()
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--RaidBossEmoteFrame
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame then
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
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--CinematicCanceler
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.CinematicCanceler then
		CinematicFrame:HookScript("OnShow", function(self, ...)
		if IsModifierKeyDown() then return end --если нажат модификатор, то запустится мувик
		print("|cFF00A3FFCinematic|r |cffFF4C4Fcanceled.|r")
		CinematicFrame_CancelCinematic()
		end)
		local omfpf = _G["MovieFrame_PlayMovie"] --запускает мувик?
		_G["MovieFrame_PlayMovie"] = function(...)
		if IsModifierKeyDown() then return omfpf(...) end
		print("|cFF00A3FFMovie|r |cffFF4C4Fcanceled.|r")
		GameMovieFinished() return true
		end
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--BossBanner
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.BossBanner then
		BossBanner:UnregisterAllEvents()
		BossBanner:Hide()
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
--MajorFactionsRenownToast
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast then
		--MajorFactionsRenownToast:UnregisterAllEvents()
	end
end)
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------


local function func_Octo_LoadAddOn(AddonName)
	if select(5, GetAddOnInfo(AddonName)) == "DISABLED" then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end

--BugSack
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.BugSack then
		func_Octo_LoadAddOn("!BugGrabber")
		func_Octo_LoadAddOn("BugSack")
	end
end)
--MountsJournal
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.MountsJournal then
		func_Octo_LoadAddOn("MountsJournal")
	end
end)








