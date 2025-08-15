local GlobalAddonName, E = ...
-- if not Octo_ToDo_DB_Vars.Enable_Moduls then return end
local EventFrame = CreateFrame("Frame")
-- Общая функция для скрытия фреймов
function E:HideFrame(frame)
	if frame and not self[frame] then
		self[frame] = true
		if frame:IsShown() then
			frame:Hide()
		else
			frame:HookScript("OnShow", function(self)
					frame:UnregisterAllEvents()
					frame:Hide()
			end)
		end
	end
end
-- Специфичные обработчики
function E:Config_Hide_OrderHallCommandBar()
	if self.OrderHallCommandBar then return end
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
		frame:SetScript("OnEvent", function(_, event, addon)
				if event == "ADDON_LOADED" and addon == "Blizzard_OrderHallUI" then
					if InCombatLockdown() then
						frame:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						HandleCommandBar()
					end
				elseif event == "PLAYER_REGEN_ENABLED" then
					HandleCommandBar()
					frame:UnregisterAllEvents()
				end
		end)
	end
end
function E:Config_Hide_ErrorMessages()
	if self.ErrorMessages then return end
	self.ErrorMessages = true
	local errorsToShow = {
		[ERR_INV_FULL] = true,
		[ERR_QUEST_LOG_FULL] = true,
		-- ... (другие обрабатываемые ошибки)
	}
	local origHandler = UIErrorsFrame:GetScript("OnEvent")
	UIErrorsFrame:SetScript("OnEvent", function(self, event, id, err, ...)
			if (event == "UI_ERROR_MESSAGE" and errorsToShow[err]) or event == "UI_INFO_MESSAGE" then
				origHandler(self, event, id, err, ...)
			end
	end)
end
function E:Config_Hide_TalkingHeadFrame()
	if self.TalkingHeadFrame or not TalkingHeadFrame then return end
	self.TalkingHeadFrame = true
	hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self) self:Hide() end)
end
function E:Config_Hide_EventToastManagerFrame()
	if self.EventToastManagerFrame or not EventToastManagerFrame then return end
	self.EventToastManagerFrame = true
	hooksecurefunc(EventToastManagerFrame, "Show", function()
			if EventToastManagerFrame.currentDisplayingToast and not EventToastManagerFrame.HideButton:IsShown() then
				if IsInJailersTower() then
					local title = EventToastManagerFrame.currentDisplayingToast.Title:GetText() or ""
					if title:find(JAILERS_TOWER_SCENARIO_FLOOR) then
						EventToastManagerFrame.currentDisplayingToast:SetScript("OnMouseDown", function(_, btn)
								if btn == "RightButton" then
									EventToastManagerFrame:CloseActiveToasts()
								end
						end)
						return
					end
				end
				EventToastManagerFrame.currentDisplayingToast:OnAnimatedOut()
			end
	end)
end
-- Автоматическая генерация обработчиков
local frameHandlers = {
	Config_Hide_CheckListText = CheckListText,
	Config_Hide_SubscriptionInterstitialFrame = SubscriptionInterstitialFrame,
	Config_Hide_ActionStatusText = ActionStatus.Text,
	Config_Hide_SecondaryStatusTrackingBarContainer = SecondaryStatusTrackingBarContainer,
	Config_Hide_MainStatusTrackingBarContainer = MainStatusTrackingBarContainer,
	Config_Hide_WeeklyRewardExpirationWarningDialog = WeeklyRewardExpirationWarningDialog,
	Config_Hide_MajorFactionsRenownToast = MajorFactionsRenownToast,
	Config_Hide_UIWidgetTopCenterContainerFrame = UIWidgetTopCenterContainerFrame,
	Config_Hide_BossBanner = BossBanner,
	Config_Hide_RaidWarningFrame = RaidWarningFrame,
	Config_Hide_RaidBossEmoteFrame = RaidBossEmoteFrame,
	Config_Hide_PrivateRaidBossEmoteFrameAnchor = PrivateRaidBossEmoteFrameAnchor,
	Config_Hide_SplashFrame = SplashFrame,
	Config_Hide_PTRReporter = PTR_Reporter,
	Config_Hide_PTRIssueReporter = PTR_IssueReporter,
	Config_Hide_PTRIssueReporterAlertFrame = PTRIssueReporterAlertFrame,
	Config_Hide_Bug = Bug,
	Config_Hide_CovenantRenownToast = CovenantRenownToast,
	Config_Hide_CovenantChoiceToast = CovenantChoiceToast,
	Config_Hide_ZoneTextFrame = ZoneTextFrame,
	Config_Hide_SubZoneTextFrame = SubZoneTextFrame,
	Config_Hide_PVPArenaTextString = PVPArenaTextString,
	Config_Hide_ZoneTextString = ZoneTextString,
	Config_Hide_SubZoneTextString = SubZoneTextString,
}
for funcName, frame in pairs(frameHandlers) do
	E[funcName] = function(self)
		E:HideFrame(frame)
	end
end
-- Регистрация событий
local events = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_STARTED_MOVING",
	"TALKINGHEAD_REQUESTED",
}
for _, event in ipairs(events) do
	EventFrame:RegisterEvent(event)
end
EventFrame:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" then
			if ... == GlobalAddonName then
				self:UnregisterEvent("ADDON_LOADED")
			end
		else
			self:START_HF_functions()
		end
end)
function EventFrame:START_HF_functions()
	for funcName in pairs(frameHandlers) do
		if Octo_ToDo_DB_Vars[funcName] then E[funcName](E) end
	end
	-- Специальные обработчики
	if Octo_ToDo_DB_Vars.Config_Hide_OrderHallCommandBar then E:Config_Hide_OrderHallCommandBar() end
	if Octo_ToDo_DB_Vars.Config_Hide_ErrorMessages then E:Config_Hide_ErrorMessages() end
	if Octo_ToDo_DB_Vars.Config_Hide_TalkingHeadFrame then E:Config_Hide_TalkingHeadFrame() end
	if Octo_ToDo_DB_Vars.Config_Hide_EventToastManagerFrame then E:Config_Hide_EventToastManagerFrame() end
end