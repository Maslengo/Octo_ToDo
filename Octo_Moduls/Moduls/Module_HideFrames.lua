local GlobalAddonName, ns = ...
E = _G.OctoEngine




local Octo_EventFrame_HideFrames = CreateFrame("FRAME")
Octo_EventFrame_HideFrames:Hide()

function E:Config_Hide_CheckListText()
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









-- function E:Config_Hide_SubscriptionInterstitialFrame()
-- 	local frame = SubscriptionInterstitialFrame
-- 	if frame and not self[frame] then
-- 		self[frame] = true
-- 		if frame:IsShown() then frame:Hide()
-- 		else frame:HookScript("OnShow", function(self, ...)
-- 				frame:UnregisterAllEvents()
-- 				frame:Hide()
-- 			end)
-- 		end
-- 	end
-- end

function E:Config_Hide_ActionStatusText()
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

function E:Config_Hide_SecondaryStatusTrackingBarContainer()
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

function E:Config_Hide_MainStatusTrackingBarContainer()
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

function E:Config_Hide_WeeklyRewardExpirationWarningDialog()
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

function E:Config_Hide_MajorFactionsRenownToast()
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

function E:Config_Hide_UIWidgetTopCenterContainerFrame()
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

function E:Config_Hide_BossBanner()
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

function E:Config_Hide_RaidWarningFrame()
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

function E:Config_Hide_RaidBossEmoteFrame()
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

function E:Config_Hide_PrivateRaidBossEmoteFrameAnchor()
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

function E:Config_Hide_SplashFrame()
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

function E:Config_Hide_PTRReporter()
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

function E:Config_Hide_PTRIssueReporter()
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

function E:Config_Hide_PTRIssueReporterAlertFrame()
	local frame = PTRIssueReporterAlertFrame
	if frame then
		frame:SetScript("OnShow", function()
			frame:Hide()
		end)
	end

	-- if frame and not self[frame] then
	-- 	self[frame] = true
	-- 	if frame:IsShown() then frame:Hide()
	-- 	else frame:HookScript("OnShow", function(self, ...)
	-- 			frame:UnregisterAllEvents()
	-- 			frame:Hide()
	-- 		end)
	-- 	end
	-- end
end

function E:Config_Hide_Bug()
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

function E:Config_Hide_CovenantRenownToast()
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

function E:Config_Hide_CovenantChoiceToast()
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

function E:Config_Hide_ZoneTextFrame()
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

function E:Config_Hide_SubZoneTextFrame()
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

function E:Config_Hide_PVPArenaTextString()
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

function E:Config_Hide_ZoneTextString()
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

function E:Config_Hide_SubZoneTextString()
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

function E:Config_Hide_OrderHallCommandBar()
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
		elseif E:func_IsRetail() then
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

function E:Config_Hide_ErrorMessages()
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

function E:Config_Hide_TalkingHeadFrame()
	if TalkingHeadFrame and not self.TalkingHeadFrame then
		self.TalkingHeadFrame = true
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			self:Hide()
		end)
	end
end

function E:Config_Hide_EventToastManagerFrame()
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
	"PLAYER_LOGIN",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_STARTED_MOVING",
	"TALKINGHEAD_REQUESTED",
	"SHOW_SUBSCRIPTION_INTERSTITIAL",
}

E:func_RegisterMyEventsToFrames(Octo_EventFrame_HideFrames, MyEventsTable)
function Octo_EventFrame_HideFrames:START_HF_functions()
	if Octo_ToDo_DB_Vars.Config_Hide_CheckListText then E:Config_Hide_CheckListText() end
	-- if Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame then E:Config_Hide_SubscriptionInterstitialFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_ActionStatusText then E:Config_Hide_ActionStatusText() end
	if Octo_ToDo_DB_Vars.Config_Hide_SecondaryStatusTrackingBarContainer then E:Config_Hide_SecondaryStatusTrackingBarContainer() end
	if Octo_ToDo_DB_Vars.Config_Hide_MainStatusTrackingBarContainer then E:Config_Hide_MainStatusTrackingBarContainer() end
	if Octo_ToDo_DB_Vars.Config_Hide_WeeklyRewardExpirationWarningDialog then E:Config_Hide_WeeklyRewardExpirationWarningDialog() end
	if Octo_ToDo_DB_Vars.Config_Hide_MajorFactionsRenownToast then E:Config_Hide_MajorFactionsRenownToast() end
	if Octo_ToDo_DB_Vars.Config_Hide_UIWidgetTopCenterContainerFrame then E:Config_Hide_UIWidgetTopCenterContainerFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_BossBanner then E:Config_Hide_BossBanner() end
	if Octo_ToDo_DB_Vars.Config_Hide_RaidWarningFrame then E:Config_Hide_RaidWarningFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_RaidBossEmoteFrame then E:Config_Hide_RaidBossEmoteFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_PrivateRaidBossEmoteFrameAnchor then E:Config_Hide_PrivateRaidBossEmoteFrameAnchor() end
	if Octo_ToDo_DB_Vars.Config_Hide_SplashFrame then E:Config_Hide_SplashFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_PTRReporter then E:Config_Hide_PTRReporter() end
	if Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporter then E:Config_Hide_PTRIssueReporter() end
	if Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporterAlertFrame then E:Config_Hide_PTRIssueReporterAlertFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_Bug then E:Config_Hide_Bug() end
	if Octo_ToDo_DB_Vars.Config_Hide_CovenantRenownToast then E:Config_Hide_CovenantRenownToast() end
	if Octo_ToDo_DB_Vars.Config_Hide_CovenantChoiceToast then E:Config_Hide_CovenantChoiceToast() end
	if Octo_ToDo_DB_Vars.Config_Hide_ZoneTextFrame then E:Config_Hide_ZoneTextFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextFrame then E:Config_Hide_SubZoneTextFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_PVPArenaTextString then E:Config_Hide_PVPArenaTextString() end
	if Octo_ToDo_DB_Vars.Config_Hide_ZoneTextString then E:Config_Hide_ZoneTextString() end
	if Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextString then E:Config_Hide_SubZoneTextString() end
	if Octo_ToDo_DB_Vars.Config_Hide_OrderHallCommandBar then E:Config_Hide_OrderHallCommandBar() end
	if Octo_ToDo_DB_Vars.Config_Hide_ErrorMessages then E:Config_Hide_ErrorMessages() end
	if Octo_ToDo_DB_Vars.Config_Hide_TalkingHeadFrame then E:Config_Hide_TalkingHeadFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_EventToastManagerFrame then E:Config_Hide_EventToastManagerFrame() end
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
	-- local size1, size2 = GetPhysicalScreenSize()
	-- local scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale()

	-- print (E.Red_Color.."UIParent:|r", UIParent:GetSize())
	-- print (E.Blue_Color.."WorldFrame:|r", WorldFrame:GetSize())

	-- print (E.Green_Color.."GetPhysicalScreenSize:|r", size1, size2)
	-- print (scale, E.scale)
	-- /script WorldFrame:ClearAllPoints(); WorldFrame:SetWidth(1920); WorldFrame:SetHeight(1080); WorldFrame:SetPoint("CENTER", 0, 0);
	-- /script UIParent:ClearAllPoints(); UIParent:SetWidth(1920); UIParent:SetHeight(1080); UIParent:SetPoint("CENTER", 0, 0);

end

function Octo_EventFrame_HideFrames:TALKINGHEAD_REQUESTED()
	self:START_HF_functions()
end


function E:Config_Hide_SubscriptionInterstitialFrame()
	local frame = SubscriptionInterstitialFrame
	if frame and not self[frame] then
		self[frame] = true
		SubscriptionInterstitialFrame:UnregisterAllEvents()
	end
end

function Octo_EventFrame_HideFrames:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame then E:Config_Hide_SubscriptionInterstitialFrame() end
end