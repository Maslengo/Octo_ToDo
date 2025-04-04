local GlobalAddonName, E = ...
local OctoToDo_EventFrame_HideFrames = CreateFrame("FRAME")
OctoToDo_EventFrame_HideFrames:Hide()
----------------------------------------------------------------
local OctoTable_MustBeHiddenFrames_SIMPLE = {
	-- {name = "ZoneAbilityFrame.Style", frame = ZoneAbilityFrame.Style},
	-- {name = "ExtraActionButton1.style", frame = ExtraActionButton1.style},
	-- {name = "PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator", frame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator},
	-- {name = "EncounterBar", frame = EncounterBar}, -- ДЛЯ ПОЛЁТА
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "SplashFrame", frame = SplashFrame},
	{name = "MajorFactionsRenownToast", frame = MajorFactionsRenownToast},
	{name = "RaidWarningFrame", frame = RaidWarningFrame},
	{name = "ZoneTextFrame", frame = ZoneTextFrame},
	{name = "SubZoneTextFrame", frame = SubZoneTextFrame},
	{name = "PVPArenaTextString", frame = PVPArenaTextString},
	{name = "ZoneTextString", frame = ZoneTextString},
	{name = "SubZoneTextString", frame = SubZoneTextString},

	{name = "EventToastManagerFrame", frame = EventToastManagerFrame},
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "UIWidgetTopCenterContainerFrame", frame = UIWidgetTopCenterContainerFrame},
	{name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer},
	{name = "SecondaryStatusTrackingBarContainer", frame = SecondaryStatusTrackingBarContainer},
	{name = "BossBanner", frame = BossBanner},
	{name = "RaidWarningFrame", frame = RaidWarningFrame},
	{name = "RaidBossEmoteFrame", frame = RaidBossEmoteFrame},
	{name = "Bug", frame = Bug},
	{name = "PTR_Reporter", frame = PTR_Reporter},
	{name = "PTR_IssueReporter", frame = PTR_IssueReporter},
	{name = "PTRIssueReporterAlertFrame", frame = PTRIssueReporterAlertFrame},
	{name = "CheckListText", frame = CheckListText},
	{name = "PrivateRaidBossEmoteFrameAnchor", frame = PrivateRaidBossEmoteFrameAnchor},

}
function OctoToDo_EventFrame_HideFrames:MustBeHiddenFrames_SIMPLE()
	for _, v in next, (OctoTable_MustBeHiddenFrames_SIMPLE) do
		local frame = v.frame
		local name = v.name
		if frame and frame:IsShown() --[[and not frame.isInit]] then
			-- frame.isInit = true
			-- frame:HookScript("OnShow", function(self)
			-- self:Hide()
			frame:Hide()
			-- frame:UnregisterAllEvents()
			--DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide: (", E.Green_Color, E.Yellow_Color)..name..E.Yellow_Color..")|r" )
			-- end)
			-- else
			-- if PTRIssueReporterAlertFrame and PTRIssueReporterAlertFrame:IsShown() then
			--     PTRIssueReporterAlertFrame:Hide()
			--     --print(E.Red_Color.. "PTRIssueReporterAlertFrame:Hide()" .. "|r")
			-- end
		end
	end
end

local OctoTable_MustBeHiddenFrames_HOOK = {
	{name = "CovenantChoiceToast", frame = CovenantChoiceToast},
	{name = "CovenantRenownToast", frame = CovenantRenownToast},
}

function OctoToDo_EventFrame_HideFrames:MustBeHiddenFrames_HOOK()
	for _, v in next, (OctoTable_MustBeHiddenFrames_HOOK) do
		local frame = v.frame
		local name = v.name
		if frame and not frame.isInit then
			frame.isInit = true
			if frame:IsShown() then
				frame:Hide()
			end
			frame:HookScript("OnShow", function(self, ...)
					frame:UnregisterAllEvents()
					frame:Hide()
					--DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide: (", E.Addon_Left_Color, E.Addon_Right_Color)..name..E.Addon_Right_Color..")|r" )
			end)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_OrderHallCommandBar()
	local function HandleCommandBar()
		_G.OrderHallCommandBar:UnregisterAllEvents()
		_G.OrderHallCommandBar:SetScript("OnShow", _G.OrderHallCommandBar.Hide)
		_G.OrderHallCommandBar:Hide()
		UIParent:UnregisterEvent("UNIT_AURA") -- Only used for OrderHall Bar
		--DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("OrderHallCommandBar Hide", E.Addon_Left_Color, E.Addon_Right_Color))
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
------------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_BossBanner()
	local frame = BossBanner
	local name = "BossBanner"
	frame:HookScript("OnShow", function(self, ...)
			frame:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			frame:UnregisterEvent("BOSS_KILL")
			--DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide: (", E.Addon_Left_Color, E.Addon_Right_Color)..name..E.Addon_Right_Color..")|r" )
	end)
end
-------------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_Error_Messages()
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
-------------------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_RaidWarningFrame()
	RaidWarningFrame:HookScript("OnShow", function(self, ...)
			-- RaidWarningFrame:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			-- RaidWarningFrame:UnregisterEvent("BOSS_KILL")
			RaidWarningFrame:UnregisterAllEvents()
			RaidWarningFrame:Hide()
	end)
	RaidBossEmoteFrame:HookScript("OnShow", function(self, ...)
			-- RaidBossEmoteFrame:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
			-- RaidBossEmoteFrame:UnregisterEvent("BOSS_KILL")
			--print ("RaidBossEmoteFrame HIDE")
			RaidBossEmoteFrame:UnregisterAllEvents()
			RaidBossEmoteFrame:Hide()
	end)
end
-----------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_PTRIssueReporterAlertFrame()
	if PTRIssueReporterAlertFrame then
		PTRIssueReporterAlertFrame:HookScript("OnShow", function(self, ...)
				PTRIssueReporterAlertFrame:Hide()
		end)
		-- hooksecurefunc(PTRIssueReporterAlertFrame, "Show", function(self)
		--         self:Hide()
		--         --DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("PTRIssueReporterAlertFrame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
		-- end)
	end
end
---------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_Talking_Head_Frame()
	hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			self:Hide()
			--DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Talking Head Frame canceled", E.Addon_Left_Color, E.Addon_Right_Color))
	end)
end
---------------------------------------------------------------
function OctoToDo_EventFrame_HideFrames:Hide_Zone_Text()
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
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_HideFrames, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_HideFrames:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		self:Hide_PTRIssueReporterAlertFrame()
		self:Hide_BossBanner()
		self:Hide_Error_Messages()
		self:Hide_RaidWarningFrame()
		self:Hide_Talking_Head_Frame()
		self:Hide_Zone_Text()
		self:MustBeHiddenFrames_SIMPLE()
		self:MustBeHiddenFrames_HOOK()
		self:Hide_OrderHallCommandBar()
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame_HideFrames:PLAYER_REGEN_ENABLED()
	C_Timer.After(1, function()
			self:MustBeHiddenFrames_SIMPLE()
			self:MustBeHiddenFrames_HOOK()
	end)
end

function OctoToDo_EventFrame_HideFrames:PLAYER_REGEN_DISABLED()
	self:MustBeHiddenFrames_SIMPLE()
	self:MustBeHiddenFrames_HOOK()
end

function OctoToDo_EventFrame_HideFrames:PLAYER_STARTED_MOVING()
	C_Timer.After(1, function()
			self:Hide_PTRIssueReporterAlertFrame()
			self:MustBeHiddenFrames_SIMPLE()
			self:MustBeHiddenFrames_HOOK()
	end)
end

