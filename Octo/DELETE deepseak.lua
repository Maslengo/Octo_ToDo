local GlobalAddonName, E = ...
-- if not Octo_ToDo_DB_Vars.Enable_Moduls then return end

local Octo_EventFrame_HideFrames = CreateFrame("Frame")
Octo_EventFrame_HideFrames:Hide()

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
function E:Hide_OrderHallCommandBar()
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
	elseif E.func_IsRetail() then
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

function E:Hide_ErrorMessages()
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

function E:Hide_TalkingHeadFrame()
	if self.TalkingHeadFrame or not TalkingHeadFrame then return end
	self.TalkingHeadFrame = true
	hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self) self:Hide() end)
end

function E:Hide_EventToastManagerFrame()
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
	Hide_CheckListText = CheckListText,
	Hide_SubscriptionInterstitialFrame = SubscriptionInterstitialFrame,
	Hide_ActionStatusText = ActionStatus.Text,
	Hide_SecondaryStatusTrackingBarContainer = SecondaryStatusTrackingBarContainer,
	Hide_MainStatusTrackingBarContainer = MainStatusTrackingBarContainer,
	Hide_WeeklyRewardExpirationWarningDialog = WeeklyRewardExpirationWarningDialog,
	Hide_MajorFactionsRenownToast = MajorFactionsRenownToast,
	Hide_UIWidgetTopCenterContainerFrame = UIWidgetTopCenterContainerFrame,
	Hide_BossBanner = BossBanner,
	Hide_RaidWarningFrame = RaidWarningFrame,
	Hide_RaidBossEmoteFrame = RaidBossEmoteFrame,
	Hide_PrivateRaidBossEmoteFrameAnchor = PrivateRaidBossEmoteFrameAnchor,
	Hide_SplashFrame = SplashFrame,
	Hide_PTRReporter = PTR_Reporter,
	Hide_PTRIssueReporter = PTR_IssueReporter,
	Hide_PTRIssueReporterAlertFrame = PTRIssueReporterAlertFrame,
	Hide_Bug = Bug,
	Hide_CovenantRenownToast = CovenantRenownToast,
	Hide_CovenantChoiceToast = CovenantChoiceToast,
	Hide_ZoneTextFrame = ZoneTextFrame,
	Hide_SubZoneTextFrame = SubZoneTextFrame,
	Hide_PVPArenaTextString = PVPArenaTextString,
	Hide_ZoneTextString = ZoneTextString,
	Hide_SubZoneTextString = SubZoneTextString,
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
	Octo_EventFrame_HideFrames:RegisterEvent(event)
end

Octo_EventFrame_HideFrames:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" then
			if ... == GlobalAddonName then
				self:UnregisterEvent("ADDON_LOADED")
			end
		else
			self:START_HF_functions()
		end
end)

function Octo_EventFrame_HideFrames:START_HF_functions()
	for funcName in pairs(frameHandlers) do
		if Octo_ToDo_DB_Vars[funcName] then E[funcName](E) end
	end

	-- Специальные обработчики
	if Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar then E:Hide_OrderHallCommandBar() end
	if Octo_ToDo_DB_Vars.Hide_ErrorMessages then E:Hide_ErrorMessages() end
	if Octo_ToDo_DB_Vars.Hide_TalkingHeadFrame then E:Hide_TalkingHeadFrame() end
	if Octo_ToDo_DB_Vars.Hide_EventToastManagerFrame then E:Hide_EventToastManagerFrame() end
end