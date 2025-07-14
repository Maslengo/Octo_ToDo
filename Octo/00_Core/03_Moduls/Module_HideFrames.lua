local GlobalAddonName, E = ...
-- if not Octo_ToDo_DB_Vars.Enable_Moduls then return end
local Octo_EventFrame_HideFrames = CreateFrame("FRAME")
Octo_EventFrame_HideFrames:Hide()

function E:Hide_CheckListText()
	local frame = CheckListText
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_SubscriptionInterstitialFrame()
	local frame = SubscriptionInterstitialFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_ActionStatusText()
	local frame = ActionStatus.Text
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_SecondaryStatusTrackingBarContainer()
	local frame = SecondaryStatusTrackingBarContainer
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_MainStatusTrackingBarContainer()
	local frame = MainStatusTrackingBarContainer
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_WeeklyRewardExpirationWarningDialog()
	local frame = WeeklyRewardExpirationWarningDialog
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_MajorFactionsRenownToast()
	local frame = MajorFactionsRenownToast
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_UIWidgetTopCenterContainerFrame()
	local frame = UIWidgetTopCenterContainerFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_BossBanner()
	local frame = BossBanner
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_RaidWarningFrame()
	local frame = RaidWarningFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_RaidBossEmoteFrame()
	local frame = RaidBossEmoteFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_PrivateRaidBossEmoteFrameAnchor()
	local frame = PrivateRaidBossEmoteFrameAnchor
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_SplashFrame()
	local frame = SplashFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_PTRReporter()
	local frame = PTR_Reporter
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_PTRIssueReporter()
	local frame = PTR_IssueReporter
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_PTRIssueReporterAlertFrame()
	local frame = PTRIssueReporterAlertFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_Bug()
	local frame = Bug
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_CovenantRenownToast()
	local frame = CovenantRenownToast
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_CovenantChoiceToast()
	local frame = CovenantChoiceToast
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_ZoneTextFrame()
	local frame = ZoneTextFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_SubZoneTextFrame()
	local frame = SubZoneTextFrame
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_PVPArenaTextString()
	local frame = PVPArenaTextString
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_ZoneTextString()
	local frame = ZoneTextString
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_SubZoneTextString()
	local frame = SubZoneTextString
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then frame:Hide()
		else frame:HookScript("OnShow", function(self, ...)
				frame:UnregisterAllEvents()
				frame:Hide()
			end)
		end
	end
end

function E:Hide_OrderHallCommandBar()
	if not self.OrderHallCommandBar then
		self.OrderHallCommandBar = true
		local function HandleCommandBar()
			_G.OrderHallCommandBar:UnregisterAllEvents()
			_G.OrderHallCommandBar:SetScript("OnShow", _G.OrderHallCommandBar.Hide)
			_G.OrderHallCommandBar:Hide()
			UIParent:UnregisterEvent("UNIT_AURA")
		end
		if _G.OrderHallCommandBar then
			HandleCommandBar()
		elseif E.func_IsRetail() then
			local frame = CreateFrame("Frame")
			frame:RegisterEvent("ADDON_LOADED")
			frame:SetScript("OnEvent", function(Frame, event, addon)
				if event == "ADDON_LOADED" and addon == "Blizzard_OrderHallUI" then
					if InCombatLockdown() then
						Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						HandleCommandBar()
					end
					Frame:UnregisterEvent(event)
				elseif event == "PLAYER_REGEN_ENABLED" then
					HandleCommandBar()
					Frame:UnregisterEvent(event)
				end
			end)
		end
	end
end

function E:Hide_ErrorMessages()
	if not self.ErrorMessages then
		self.ErrorMessages = true
		local OrigErrHandler = UIErrorsFrame:GetScript("OnEvent")
		UIErrorsFrame:SetScript("OnEvent", function(self, event, id, err, ...)
			if event == "UI_ERROR_MESSAGE" then
				if err == ERR_INV_FULL
					or err == ERR_QUEST_LOG_FULL
					or err == ERR_RAID_GROUP_ONLY
					or err == ERR_PARTY_LFG_BOOT_LIMIT
					or err == ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE
					or err == ERR_PARTY_LFG_BOOT_IN_COMBAT
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

function E:Hide_TalkingHeadFrame()
	if TalkingHeadFrame and not self.TalkingHeadFrame then
		self.TalkingHeadFrame = true
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			self:Hide()
		end)
	end
end

function E:Hide_EventToastManagerFrame()
	if EventToastManagerFrame and not self.EventToastManagerFrame then
		self.EventToastManagerFrame = true
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
}

E.RegisterMyEventsToFrames(Octo_EventFrame_HideFrames, MyEventsTable)

function Octo_EventFrame_HideFrames:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
end

function Octo_EventFrame_HideFrames:START_HF_functions()
	if Octo_ToDo_DB_Vars.Hide_CheckListText then E:Hide_CheckListText() end
	if Octo_ToDo_DB_Vars.Hide_SubscriptionInterstitialFrame then E:Hide_SubscriptionInterstitialFrame() end
	if Octo_ToDo_DB_Vars.Hide_ActionStatusText then E:Hide_ActionStatusText() end
	if Octo_ToDo_DB_Vars.Hide_SecondaryStatusTrackingBarContainer then E:Hide_SecondaryStatusTrackingBarContainer() end
	if Octo_ToDo_DB_Vars.Hide_MainStatusTrackingBarContainer then E:Hide_MainStatusTrackingBarContainer() end
	if Octo_ToDo_DB_Vars.Hide_WeeklyRewardExpirationWarningDialog then E:Hide_WeeklyRewardExpirationWarningDialog() end
	if Octo_ToDo_DB_Vars.Hide_MajorFactionsRenownToast then E:Hide_MajorFactionsRenownToast() end
	if Octo_ToDo_DB_Vars.Hide_UIWidgetTopCenterContainerFrame then E:Hide_UIWidgetTopCenterContainerFrame() end
	if Octo_ToDo_DB_Vars.Hide_BossBanner then E:Hide_BossBanner() end
	if Octo_ToDo_DB_Vars.Hide_RaidWarningFrame then E:Hide_RaidWarningFrame() end
	if Octo_ToDo_DB_Vars.Hide_RaidBossEmoteFrame then E:Hide_RaidBossEmoteFrame() end
	if Octo_ToDo_DB_Vars.Hide_PrivateRaidBossEmoteFrameAnchor then E:Hide_PrivateRaidBossEmoteFrameAnchor() end
	if Octo_ToDo_DB_Vars.Hide_SplashFrame then E:Hide_SplashFrame() end
	if Octo_ToDo_DB_Vars.Hide_PTRReporter then E:Hide_PTRReporter() end
	if Octo_ToDo_DB_Vars.Hide_PTRIssueReporter then E:Hide_PTRIssueReporter() end
	if Octo_ToDo_DB_Vars.Hide_PTRIssueReporterAlertFrame then E:Hide_PTRIssueReporterAlertFrame() end
	if Octo_ToDo_DB_Vars.Hide_Bug then E:Hide_Bug() end
	if Octo_ToDo_DB_Vars.Hide_CovenantRenownToast then E:Hide_CovenantRenownToast() end
	if Octo_ToDo_DB_Vars.Hide_CovenantChoiceToast then E:Hide_CovenantChoiceToast() end
	if Octo_ToDo_DB_Vars.Hide_ZoneTextFrame then E:Hide_ZoneTextFrame() end
	if Octo_ToDo_DB_Vars.Hide_SubZoneTextFrame then E:Hide_SubZoneTextFrame() end
	if Octo_ToDo_DB_Vars.Hide_PVPArenaTextString then E:Hide_PVPArenaTextString() end
	if Octo_ToDo_DB_Vars.Hide_ZoneTextString then E:Hide_ZoneTextString() end
	if Octo_ToDo_DB_Vars.Hide_SubZoneTextString then E:Hide_SubZoneTextString() end
	if Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar then E:Hide_OrderHallCommandBar() end
	if Octo_ToDo_DB_Vars.Hide_ErrorMessages then E:Hide_ErrorMessages() end
	if Octo_ToDo_DB_Vars.Hide_TalkingHeadFrame then E:Hide_TalkingHeadFrame() end
	if Octo_ToDo_DB_Vars.Hide_EventToastManagerFrame then E:Hide_EventToastManagerFrame() end
end

function Octo_EventFrame_HideFrames:PLAYER_LOGIN()
	self:START_HF_functions()
end

function Octo_EventFrame_HideFrames:PLAYER_REGEN_ENABLED()
	self:START_HF_functions()
end

function Octo_EventFrame_HideFrames:PLAYER_REGEN_DISABLED()
	self:START_HF_functions()
end

function Octo_EventFrame_HideFrames:PLAYER_STARTED_MOVING()
	self:START_HF_functions()
end

function Octo_EventFrame_HideFrames:TALKINGHEAD_REQUESTED()
	self:START_HF_functions()
end
