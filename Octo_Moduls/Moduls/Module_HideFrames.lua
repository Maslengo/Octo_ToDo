local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function E.func_Config_Hide_CheckListText()
	local frame = CheckListText
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
-- function E.func_Config_Hide_SubscriptionInterstitialFrame()
-- local frame = SubscriptionInterstitialFrame
-- if frame and not E[frame] then
-- E[frame] = true
-- if frame:IsShown() then frame:Hide()
-- else frame:HookScript("OnShow", function(self, ...)
-- frame:UnregisterAllEvents()
-- frame:Hide()
-- end)
-- end
-- end
-- end
function E.func_Config_Hide_ActionStatusText()
	local frame = ActionStatus.Text
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_SecondaryStatusTrackingBarContainer()
	local frame = SecondaryStatusTrackingBarContainer
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_MainStatusTrackingBarContainer()
	local frame = MainStatusTrackingBarContainer
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_WeeklyRewardExpirationWarningDialog()
	local frame = WeeklyRewardExpirationWarningDialog
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_MajorFactionsRenownToast()
	local frame = MajorFactionsRenownToast
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_UIWidgetTopCenterContainerFrame()
	local frame = UIWidgetTopCenterContainerFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_BossBanner()
	local frame = BossBanner
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_RaidWarningFrame()
	local frame = RaidWarningFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_RaidBossEmoteFrame()
	local frame = RaidBossEmoteFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_PrivateRaidBossEmoteFrameAnchor()
	local frame = PrivateRaidBossEmoteFrameAnchor
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_SplashFrame()
	local frame = SplashFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_PTRReporter()
	local frame = PTR_Reporter
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_PTRIssueReporter()
	local frame = PTR_IssueReporter
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_PTRIssueReporterAlertFrame()
	local frame = PTRIssueReporterAlertFrame
	if frame then
		frame:SetScript("OnShow", function()
			frame:Hide()
		end)
	end
	-- if frame and not E[frame] then
	-- E[frame] = true
	-- if frame:IsShown() then frame:Hide()
	-- else frame:HookScript("OnShow", function(self, ...)
	-- frame:UnregisterAllEvents()
	-- frame:Hide()
	-- end)
	-- end
	-- end
end
function E.func_Config_Hide_Bug()
	local frame = Bug
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_CovenantRenownToast()
	local frame = CovenantRenownToast
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_CovenantChoiceToast()
	local frame = CovenantChoiceToast
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_ZoneTextFrame()
	local frame = ZoneTextFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_SubZoneTextFrame()
	local frame = SubZoneTextFrame
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_PVPArenaTextString()
	local frame = PVPArenaTextString
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_ZoneTextString()
	local frame = ZoneTextString
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_SubZoneTextString()
	local frame = SubZoneTextString
	if frame and not E[frame] then
		E[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end
function E.func_Config_Hide_ErrorMessages()
	if not E.ErrorMessages then
		E.ErrorMessages = true
		local OrigErrHandler = UIErrorsFrame:GetScript("OnEvent")
		UIErrorsFrame:SetScript("OnEvent", function(self, event, id, err, ...)
			if event == "UI_ERROR_MESSAGE" then
				if err == ERR_INV_FULL
					or err == ERR_QUEST_LOG_FULL
					or err == ERR_RAID_GROUP_ONLY
					or err == ERR_PARTY_LFG_BOOT_LIMIT
					or err == ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE
					-- or err == ERR_PARTY_LFG_BOOT_IN_COMBAT
					or err == ERR_PARTY_LFG_BOOT_IN_PROGRESS
					or err == ERR_PARTY_LFG_BOOT_LOOT_ROLLS
					or err == ERR_PARTY_LFG_TELEPORT_IN_COMBAT
					or err == ERR_PET_SPELL_DEAD
					or err == ERR_PLAYER_DEAD
					or err == SPELL_FAILED_TARGET_NO_POCKETS
					or err == ERR_ALREADY_PICKPOCKETED
					or err:find(format(ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S, ".+"))
					then
						return OrigErrHandler(self, event, id, err, ...)
					end
				elseif event == "UI_INFO_MESSAGE" then
					return OrigErrHandler(self, event, id, err, ...)
				end
			end)
	end
end
function E.func_Config_Hide_TalkingHeadFrame()
	if TalkingHeadFrame and not E.TalkingHeadFrame then
		E.TalkingHeadFrame = true
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			self:Hide()
		end)
	end
end
function E.func_Config_Hide_EventToastManagerFrame()
	if EventToastManagerFrame and not E.EventToastManagerFrame then
		E.EventToastManagerFrame = true
		hooksecurefunc(EventToastManagerFrame, "Show", function()
			if not EventToastManagerFrame.HideButton:IsShown() then
				if EventToastManagerFrame.currentDisplayingToast then
					if IsInJailersTower() then
						local title = EventToastManagerFrame.currentDisplayingToast.Title:GetText() or nil
						if title and strfind(title, JAILERS_TOWER_SCENARIO_FLOOR) then
							EventToastManagerFrame.currentDisplayingToast:SetScript("OnMouseDown", function(self, btn)
								if btn == "RightButton" then
									EventToastManagerFrame:CloseActiveToasts()
									return
								end
							end)
							return
						end
					end
					EventToastManagerFrame.currentDisplayingToast:OnAnimatedOut()
				end
			end
		end)
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_STARTED_MOVING",
	"TALKINGHEAD_REQUESTED",
	"SHOW_SUBSCRIPTION_INTERSTITIAL",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:START_HF_functions()
	if EventFrame.savedVars.Config_Hide_CheckListText then E.func_Config_Hide_CheckListText() end
	-- if EventFrame.savedVars.Config_Hide_SubscriptionInterstitialFrame then E.func_Config_Hide_SubscriptionInterstitialFrame() end
	if EventFrame.savedVars.Config_Hide_ActionStatusText then E.func_Config_Hide_ActionStatusText() end
	if EventFrame.savedVars.Config_Hide_SecondaryStatusTrackingBarContainer then E.func_Config_Hide_SecondaryStatusTrackingBarContainer() end
	if EventFrame.savedVars.Config_Hide_MainStatusTrackingBarContainer then E.func_Config_Hide_MainStatusTrackingBarContainer() end
	if EventFrame.savedVars.Config_Hide_WeeklyRewardExpirationWarningDialog then E.func_Config_Hide_WeeklyRewardExpirationWarningDialog() end
	if EventFrame.savedVars.Config_Hide_MajorFactionsRenownToast then E.func_Config_Hide_MajorFactionsRenownToast() end
	if EventFrame.savedVars.Config_Hide_UIWidgetTopCenterContainerFrame then E.func_Config_Hide_UIWidgetTopCenterContainerFrame() end
	if EventFrame.savedVars.Config_Hide_BossBanner then E.func_Config_Hide_BossBanner() end
	if EventFrame.savedVars.Config_Hide_RaidWarningFrame then E.func_Config_Hide_RaidWarningFrame() end
	if EventFrame.savedVars.Config_Hide_RaidBossEmoteFrame then E.func_Config_Hide_RaidBossEmoteFrame() end
	if EventFrame.savedVars.Config_Hide_PrivateRaidBossEmoteFrameAnchor then E.func_Config_Hide_PrivateRaidBossEmoteFrameAnchor() end
	if EventFrame.savedVars.Config_Hide_SplashFrame then E.func_Config_Hide_SplashFrame() end
	if EventFrame.savedVars.Config_Hide_PTRReporter then E.func_Config_Hide_PTRReporter() end
	if EventFrame.savedVars.Config_Hide_PTRIssueReporter then E.func_Config_Hide_PTRIssueReporter() end
	if EventFrame.savedVars.Config_Hide_PTRIssueReporterAlertFrame then E.func_Config_Hide_PTRIssueReporterAlertFrame() end
	if EventFrame.savedVars.Config_Hide_Bug then E.func_Config_Hide_Bug() end
	if EventFrame.savedVars.Config_Hide_CovenantRenownToast then E.func_Config_Hide_CovenantRenownToast() end
	if EventFrame.savedVars.Config_Hide_CovenantChoiceToast then E.func_Config_Hide_CovenantChoiceToast() end
	if EventFrame.savedVars.Config_Hide_ZoneTextFrame then E.func_Config_Hide_ZoneTextFrame() end
	if EventFrame.savedVars.Config_Hide_SubZoneTextFrame then E.func_Config_Hide_SubZoneTextFrame() end
	if EventFrame.savedVars.Config_Hide_PVPArenaTextString then E.func_Config_Hide_PVPArenaTextString() end
	if EventFrame.savedVars.Config_Hide_ZoneTextString then E.func_Config_Hide_ZoneTextString() end
	if EventFrame.savedVars.Config_Hide_SubZoneTextString then E.func_Config_Hide_SubZoneTextString() end
	if EventFrame.savedVars.Config_Hide_ErrorMessages then E.func_Config_Hide_ErrorMessages() end
	if EventFrame.savedVars.Config_Hide_TalkingHeadFrame then E.func_Config_Hide_TalkingHeadFrame() end
	if EventFrame.savedVars.Config_Hide_EventToastManagerFrame then E.func_Config_Hide_EventToastManagerFrame() end
end
function EventFrame:PLAYER_LOGIN()
	self:START_HF_functions()
end
function EventFrame:PLAYER_REGEN_ENABLED()
	self:START_HF_functions()
end
function EventFrame:PLAYER_REGEN_DISABLED()
	self:START_HF_functions()
end
function EventFrame:PLAYER_STARTED_MOVING()
	self:START_HF_functions()
end
function EventFrame:TALKINGHEAD_REQUESTED()
	self:START_HF_functions()
end
function E.func_Config_Hide_SubscriptionInterstitialFrame()
	local frame = SubscriptionInterstitialFrame
	if frame and not E[frame] then
		E[frame] = true
		SubscriptionInterstitialFrame:UnregisterAllEvents()
	end
end
function EventFrame:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if EventFrame.savedVars.Config_Hide_SubscriptionInterstitialFrame then E.func_Config_Hide_SubscriptionInterstitialFrame() end
end