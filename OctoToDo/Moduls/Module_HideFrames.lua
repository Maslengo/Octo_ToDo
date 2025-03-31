local GlobalAddonName, E = ...
local OctoToDo_EventFrame_HIDE = CreateFrame("FRAME")
OctoToDo_EventFrame_HIDE:Hide()
----------------------------------------------------------------
E.OctoTable_MustBeHiddenFrames_table = {
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "SplashFrame", frame = SplashFrame},
	{name = "MajorFactionsRenownToast", frame = MajorFactionsRenownToast},
	{name = "RaidWarningFrame", frame = RaidWarningFrame},
	{name = "ZoneTextFrame", frame = ZoneTextFrame},
	{name = "SubZoneTextFrame", frame = SubZoneTextFrame},
	{name = "PVPArenaTextString", frame = PVPArenaTextString},





	{name = "EventToastManagerFrame", frame = EventToastManagerFrame},
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	-- {name = "ZoneAbilityFrame.Style", frame = ZoneAbilityFrame.Style},
	-- {name = "ExtraActionButton1.style", frame = ExtraActionButton1.style},
	{name = "UIWidgetTopCenterContainerFrame", frame = UIWidgetTopCenterContainerFrame},
	-- {name = "PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator", frame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator},
	{name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer},
	{name = "SecondaryStatusTrackingBarContainer", frame = SecondaryStatusTrackingBarContainer},
	{name = "BossBanner", frame = BossBanner},
	{name = "CovenantChoiceToast", frame = CovenantChoiceToast},
	{name = "CovenantRenownToast", frame = CovenantRenownToast},
	{name = "RaidWarningFrame", frame = RaidWarningFrame},
	{name = "RaidBossEmoteFrame", frame = RaidBossEmoteFrame},
	{name = "Bug", frame = Bug},
	{name = "PTR_Reporter", frame = PTR_Reporter},
	{name = "PTR_IssueReporter", frame = PTR_IssueReporter},
	{name = "PTRIssueReporterAlertFrame", frame = PTRIssueReporterAlertFrame},
	{name = "CheckListText", frame = CheckListText},


}
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Boss_Banner
function OctoToDo_EventFrame_HIDE:Hide_Boss_Banner()
	if OctoToDo_DB_Vars.Hide_Boss_Banner then
		BossBanner:HookScript("OnShow", function(self, ...)
				BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
				BossBanner:UnregisterEvent("BOSS_KILL")
				-- BossBanner:UnregisterAllEvents()
				-- BossBanner:Hide()
		end)
	end
end
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Covenant
function OctoToDo_EventFrame_HIDE:Hide_Covenant()
	if OctoToDo_DB_Vars.Hide_Covenant then
		CovenantChoiceToast:UnregisterAllEvents()
		CovenantRenownToast:UnregisterAllEvents()
	end
end
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Error_Messages
function OctoToDo_EventFrame_HIDE:Hide_Error_Messages()
	if OctoToDo_DB_Vars.Hide_Error_Messages then
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
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_RaidWarningFrame
function OctoToDo_EventFrame_HIDE:Hide_RaidWarningFrame()
	if OctoToDo_DB_Vars.Hide_RaidWarningFrame then
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
end




----------------------------------------------------------------------------------------------------------------------------------
-- PTRIssueReporterAlertFrame
function OctoToDo_EventFrame_HIDE:Hide_PTRIssueReporterAlertFrame()
	if PTRIssueReporterAlertFrame then
			PTRIssueReporterAlertFrame:HookScript("OnShow", function(self, ...)
					PTRIssueReporterAlertFrame:Hide()
			end)



		-- hooksecurefunc(PTRIssueReporterAlertFrame, "Show", function(self)
		-- 		self:Hide()
		-- 		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("PTRIssueReporterAlertFrame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
		-- end)
	end
end




----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Talking_Head_Frame
function OctoToDo_EventFrame_HIDE:Hide_Talking_Head_Frame()
	if OctoToDo_DB_Vars.Hide_Talking_Head_Frame then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
				self:Hide()
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Talking Head Frame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
		end)
	end
end
----------------------------------------------------------------------------------------------------------------------------------
-- Hide_Zone_Text
function OctoToDo_EventFrame_HIDE:Hide_Zone_Text()
	if OctoToDo_DB_Vars.Hide_Zone_Text then
		ZoneTextFrame:SetScript("OnShow", ZoneTextFrame.Hide);
		SubZoneTextFrame:SetScript("OnShow", SubZoneTextFrame.Hide);
		PVPArenaTextString:HookScript("OnShow", function(self, ...)
				PVPArenaTextString:Hide()
		end)
		ZoneTextString:HookScript("OnShow", function(self, ...)
				ZoneTextString:Hide()
		end)
		SubZoneTextString:HookScript("OnShow", function(self, ...)
				SubZoneTextString:Hide()
		end)
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
----------------------------------------------------------------------------------------------------------------------------------
function OctoToDo_EventFrame_HIDE:MustBeHiddenFrames()
	for _, v in next, (E.OctoTable_MustBeHiddenFrames_table) do
		local frame = v.frame
		local name = v.name
		if frame and frame:IsShown() --[[and not frame.isInit]] then
			-- frame.isInit = true
			-- frame:HookScript("OnShow", function(self)
					-- self:Hide()
					frame:Hide()
					-- frame:UnregisterAllEvents()
					DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide: (", E.Green_Color, E.Yellow_Color)..name..E.Yellow_Color..")|r" )
			-- end)
		-- else
			-- if PTRIssueReporterAlertFrame and PTRIssueReporterAlertFrame:IsShown() then
			-- 	PTRIssueReporterAlertFrame:Hide()
			-- 	print(E.Red_Color.. "PTRIssueReporterAlertFrame:Hide()" .. "|r")
			-- end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_STARTED_MOVING",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_HIDE, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_HIDE:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		self:Hide_PTRIssueReporterAlertFrame()
		self:Hide_Boss_Banner()
		self:Hide_Covenant()
		self:Hide_Error_Messages()
		self:Hide_RaidWarningFrame()
		self:Hide_Talking_Head_Frame()
		self:Hide_Zone_Text()
		self:MustBeHiddenFrames()
		----------------------------------------------------------------
	end
end
function OctoToDo_EventFrame_HIDE:PLAYER_REGEN_ENABLED()
	C_Timer.After(1, function()
			self:MustBeHiddenFrames()
	end)
end
function OctoToDo_EventFrame_HIDE:PLAYER_REGEN_DISABLED()
	self:MustBeHiddenFrames()
	if OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown() then
		OctoToDo_MainFrame_OCTOMAIN:Hide()
	end
end
function OctoToDo_EventFrame_HIDE:PLAYER_STARTED_MOVING()
	C_Timer.After(1, function()
			self:Hide_PTRIssueReporterAlertFrame()
			self:MustBeHiddenFrames()
	end)
end

