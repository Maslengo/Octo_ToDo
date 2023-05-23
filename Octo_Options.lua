local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
--E.modules = {}
--------------------------------------------------------------------------------
local config = CreateFrame("FRAME", AddonName.."config")
-- config:RegisterEvent("VARIABLES_LOADED")
config:Hide()
	StaticPopupDialogs[AddonName.."GET_RELOAD"] = {
	text = "|cffFF0000!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
config:SetScript("OnShow", function(self)
	self:SetScript("OnShow", function(self)
		self:SetPoint("TOPLEFT", -12, 8)
	end)
	self:SetPoint("TOPLEFT", -12, 8)
	-- VERSION
	local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	ver:SetPoint("TOPLEFT", 40, 20)
	ver:SetTextColor(.5, .5, .5, 1)
	ver:SetJustifyH("RIGHT")
	ver:SetText(GetAddOnMetadata(AddonName, "Version"))
	-- TITLE
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(AddonName)
	-- BUTTON 1 CVar
	-----------------------------------------------
	self.btn_left1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, 0)
	self.btn_left1:SetChecked(Octo_ToDo_DragonflyVars.config.CVar)
	self.btn_left1:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.CVar = btn_left:GetChecked()
		StaticPopup_Show(AddonName.."GET_RELOAD")
	end)
	self.btn_left1.text:SetText("|cffFF0000CVar|r")
	-----------------------------------------------
	-- BUTTON 2 InputDelete
	-----------------------------------------------
	self.btn_left2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
	self.btn_left2:SetChecked(Octo_ToDo_DragonflyVars.config.InputDelete)
	self.btn_left2:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.InputDelete = btn_left:GetChecked()
		StaticPopup_Show(AddonName.."GET_RELOAD")
	end)
	self.btn_left2.text:SetText("|cffFF0000InputDelete|r")
	-----------------------------------------------
	-----------------------------------------------
	-- BUTTON 3 UsableItems
	-----------------------------------------------
	-- self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	-- self.btn_left3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -60)
	-- self.btn_left3:SetChecked(Octo_ToDo_DragonflyVars.config.UsableItems)
	-- self.btn_left3:SetScript("OnClick", function(btn_left)
	-- 	Octo_ToDo_DragonflyVars.config.UsableItems = btn_left:GetChecked()
	-- 	if Octo_ToDo_DragonflyVars.config.UsableItems == false then
	-- 		if E.UsableItems_Frame then
	-- 			E.UsableItems_Frame:Hide()
	-- 		end
	-- 	else
	-- 		E.UsableItemFrame_OnLoad()
	-- 		E.UsableItemFrame()
	-- 	end
	-- end)
	-- self.btn_left3.text:SetText("UsableItems")

	self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -60)
	self.btn_left3:SetChecked(Octo_ToDo_DragonflyVars.config.UsableItems)
	self.btn_left3:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.UsableItems = btn_left:GetChecked()
		StaticPopup_Show(AddonName.."GET_RELOAD")
	end)
	self.btn_left3.text:SetText("|cffFF0000UsableItems|r")







	-----------------------------------------------
	-- BUTTON 4 AutoOpen
	-----------------------------------------------
	self.btn_left4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -90)
	self.btn_left4:SetChecked(Octo_ToDo_DragonflyVars.config.AutoOpen)
	self.btn_left4:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.AutoOpen = btn_left:GetChecked()
	end)
	self.btn_left4.text:SetText("AutoOpen")
	-----------------------------------------------
	-- BUTTON 5 AutoGossip
	-----------------------------------------------
	self.btn_left5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -120)
	self.btn_left5:SetChecked(Octo_ToDo_DragonflyVars.config.AutoGossip)
	self.btn_left5:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.AutoGossip = btn_left:GetChecked()
	end)
	self.btn_left5.text:SetText("AutoGossip")
	-----------------------------------------------
	-- BUTTON 6 TalkingHeadFrame
	-----------------------------------------------
	self.btn_left6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -150)
	self.btn_left6:SetChecked(Octo_ToDo_DragonflyVars.config.TalkingHeadFrame)
	self.btn_left6:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.TalkingHeadFrame = btn_left:GetChecked()
	end)
	self.btn_left6.text:SetText("TalkingHeadFrame")
	-----------------------------------------------
	-- BUTTON 7 HideObjectiveTracker
	-----------------------------------------------
	self.btn_left7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -180)
	self.btn_left7:SetChecked(Octo_ToDo_DragonflyVars.config.HideObjectiveTracker)
	self.btn_left7:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.HideObjectiveTracker = btn_left:GetChecked()
	end)
	self.btn_left7.text:SetText("HideObjectiveTracker")
	-----------------------------------------------
	-- BUTTON 8 HideZoneText
	-----------------------------------------------
	self.btn_left8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -210)
	self.btn_left8:SetChecked(Octo_ToDo_DragonflyVars.config.HideZoneText)
	self.btn_left8:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.HideZoneText = btn_left:GetChecked()
	end)
	self.btn_left8.text:SetText("HideZoneText")
	-----------------------------------------------
	-- BUTTON 9 Covenant
	-----------------------------------------------
	self.btn_left9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -240)
	self.btn_left9:SetChecked(Octo_ToDo_DragonflyVars.config.Covenant)
	self.btn_left9:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.Covenant = btn_left:GetChecked()
	end)
	self.btn_left9.text:SetText("Covenant")
	-----------------------------------------------
	-- BUTTON 10 UIErrorsFrame
	-----------------------------------------------
	self.btn_left10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -270)
	self.btn_left10:SetChecked(Octo_ToDo_DragonflyVars.config.UIErrorsFrame)
	self.btn_left10:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.UIErrorsFrame = btn_left:GetChecked()
	end)
	self.btn_left10.text:SetText("UIErrorsFrame")
	-----------------------------------------------
	-- BUTTON 11 RaidBossEmoteFrame
	-----------------------------------------------
	self.btn_left11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -300)
	self.btn_left11:SetChecked(Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame)
	self.btn_left11:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame = btn_left:GetChecked()
	end)
	self.btn_left11.text:SetText("RaidBossEmoteFrame")
	-----------------------------------------------
	-- BUTTON 12 CinematicCanceler
	-----------------------------------------------
	self.btn_left12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -330)
	self.btn_left12:SetChecked(Octo_ToDo_DragonflyVars.config.CinematicCanceler)
	self.btn_left12:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.CinematicCanceler = btn_left:GetChecked()
	end)
	self.btn_left12.text:SetText("CinematicCanceler")
	-----------------------------------------------
	-- BUTTON 13 BossBanner
	-----------------------------------------------
	self.btn_left13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -360)
	self.btn_left13:SetChecked(Octo_ToDo_DragonflyVars.config.BossBanner)
	self.btn_left13:SetScript("OnClick", function(btn_left)
		Octo_ToDo_DragonflyVars.config.BossBanner = btn_left:GetChecked()
	end)
	self.btn_left13.text:SetText("BossBanner")
	-----------------------------------------------
	-- BUTTON 14 MajorFactionsRenownToast
	-----------------------------------------------
	-- self.btn_left14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	-- self.btn_left14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -390)
	-- self.btn_left14:SetChecked(Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast)
	-- self.btn_left14:SetScript("OnClick", function(btn_left)
	-- 	Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast = btn_left:GetChecked()
	-- end)
	-- self.btn_left14.text:SetText("MajorFactionsRenownToast")
	-----------------------------------------------
	-----------------------------------------------
	-- BUTTON 15 AnotherAddons
	-----------------------------------------------
	self.btn_right15 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, 0)
	self.btn_right15:SetChecked(Octo_ToDo_DragonflyVars.config.AnotherAddons)
	self.btn_right15:SetScript("OnClick", function(btn_right)
		Octo_ToDo_DragonflyVars.config.AnotherAddons = btn_right:GetChecked()
		StaticPopup_Show(AddonName.."GET_RELOAD")
	end)
	self.btn_right15.text:SetText("|cffFF0000AnotherAddons|r\nBugGrabber, BugSack, AutoTurnIn, MountsJournal, WowheadQuickLink, Postal")
	-----------------------------------------------
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, AddonName)
category.ID = AddonName
Settings.RegisterAddOnCategory(category)