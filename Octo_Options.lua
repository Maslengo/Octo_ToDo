local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
	text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
local indent = 24
-- MAIN

config_MAIN = CreateFrame("FRAME", GlobalAddonName.."config_MAIN"..E.Octo_Func.GenerateUniqueID())
config_MAIN:Hide()
config_MAIN:SetScript("OnShow", function(self)
		self:SetPoint("TOPLEFT", 0, 0)
		-- TITLE
		if not title then
			title = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		end
		title:SetPoint("TOPLEFT", 4, 30)
		title:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		title:SetTextColor(.5, .5, .5, 1)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		if not LEFTTEXT1 then
			LEFTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		end
		LEFTTEXT1:SetText(L["Functions"])
		LEFTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		if not CENTERTEXT1 then
			CENTERTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		end
		CENTERTEXT1:SetText(L["Modules"])
		CENTERTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		if not RIGHTTEXT1 then
			RIGHTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		end
		RIGHTTEXT1:SetText(L["DisplaySettings"])
		RIGHTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		if not RIGHTTEXT1 then
			RIGHTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		end
		RIGHTTEXT1:SetText("DEV")
		RIGHTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*19-4)
		-----------------------------------------------
		-- btn_left2 AutoSellGrey
		-----------------------------------------------
		if not self.btn_left2 then
			self.btn_left2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*2)
		self.btn_left2:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
		self.btn_left2:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left2.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoSellGrey"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left3 AutoRepair
		-----------------------------------------------
		if not self.btn_left3 then
			self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*3)
		self.btn_left3:SetChecked(Octo_ToDoVars.config.AutoRepair)
		self.btn_left3:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoRepair = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left3.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoRepair"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left4 InputDelete
		-----------------------------------------------
		if not self.btn_left4 then
			self.btn_left4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*4)
		self.btn_left4:SetChecked(Octo_ToDoVars.config.InputDelete)
		self.btn_left4:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.InputDelete = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left4.text:SetText(WHITE_FONT_COLOR_CODE..L["InputDelete"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_left5 AutoOpen
		-----------------------------------------------
		if not self.btn_left5 then
			self.btn_left5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*5)
		self.btn_left5:SetChecked(Octo_ToDoVars.config.AutoOpen)
		self.btn_left5:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoOpen = btn:GetChecked()
		end)
		self.btn_left5.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoOpen"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left6 AutoGossip
		-----------------------------------------------
		if not self.btn_left6 then
			self.btn_left6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*6)
		self.btn_left6:SetChecked(Octo_ToDoVars.config.AutoGossip)
		self.btn_left6:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoGossip = btn:GetChecked()
		end)
		self.btn_left6.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoGossip"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left7 CinematicCanceler
		-----------------------------------------------
		if not self.btn_left7 then
			self.btn_left7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*7)
		self.btn_left7:SetChecked(Octo_ToDoVars.config.CinematicCanceler)
		self.btn_left7:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CinematicCanceler = btn:GetChecked()
		end)
		self.btn_left7.text:SetText(WHITE_FONT_COLOR_CODE..L["CinematicCanceler"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left8 AutoTurnQuests
		-----------------------------------------------
		if not self.btn_left8 then
			self.btn_left8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*8)
		self.btn_left8:SetChecked(Octo_ToDoVars.config.AutoTurnQuests)
		self.btn_left8:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoTurnQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left8.text:SetText(WHITE_FONT_COLOR_CODE..L["Auto Turn Quests"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left9 ClearChat
		-----------------------------------------------
		if not self.btn_left9 then
			self.btn_left9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*9)
		self.btn_left9:SetChecked(Octo_ToDoVars.config.ClearChat)
		self.btn_left9:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ClearChat = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left9.text:SetText(WHITE_FONT_COLOR_CODE..L["ClearChat"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left10 TalkingHeadFrame
		-----------------------------------------------
		if not self.btn_left10 then
			self.btn_left10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*10)
		self.btn_left10:SetChecked(Octo_ToDoVars.config.TalkingHeadFrame)
		self.btn_left10:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TalkingHeadFrame = btn:GetChecked()
		end)
		self.btn_left10.text:SetText(WHITE_FONT_COLOR_CODE..L["TalkingHeadFrame"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left11 HideZoneText
		-----------------------------------------------
		if not self.btn_left11 then
			self.btn_left11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*11)
		self.btn_left11:SetChecked(Octo_ToDoVars.config.HideZoneText)
		self.btn_left11:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideZoneText = btn:GetChecked()
		end)
		self.btn_left11.text:SetText(WHITE_FONT_COLOR_CODE..L["HideZoneText"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left12 Covenant
		-----------------------------------------------
		if not self.btn_left12 then
			self.btn_left12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*12)
		self.btn_left12:SetChecked(Octo_ToDoVars.config.Covenant)
		self.btn_left12:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Covenant = btn:GetChecked()
		end)
		self.btn_left12.text:SetText(WHITE_FONT_COLOR_CODE..L["HideCovenant"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left13 RaidBossEmoteFrame
		-----------------------------------------------
		if not self.btn_left13 then
			self.btn_left13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*13)
		self.btn_left13:SetChecked(Octo_ToDoVars.config.RaidBossEmoteFrame)
		self.btn_left13:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.RaidBossEmoteFrame = btn:GetChecked()
		end)
		self.btn_left13.text:SetText(WHITE_FONT_COLOR_CODE..L["RaidBossEmoteFrame"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left14 BossBanner
		-----------------------------------------------
		if not self.btn_left14 then
			self.btn_left14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*14)
		self.btn_left14:SetChecked(Octo_ToDoVars.config.BossBanner)
		self.btn_left14:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.BossBanner = btn:GetChecked()
		end)
		self.btn_left14.text:SetText(WHITE_FONT_COLOR_CODE..L["BossBanner"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left15 HideErrorMessages
		-----------------------------------------------
		if not self.btn_left15 then
			self.btn_left15 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*15)
		self.btn_left15:SetChecked(Octo_ToDoVars.config.HideErrorMessages)
		self.btn_left15:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideErrorMessages = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left15.text:SetText(WHITE_FONT_COLOR_CODE..L["HideErrorMessages"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left16 UIErrorsFramePosition
		-----------------------------------------------
		if not self.btn_left16 then
			self.btn_left16 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left16:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*16)
		self.btn_left16:SetChecked(Octo_ToDoVars.config.UIErrorsFramePosition)
		self.btn_left16:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UIErrorsFramePosition = btn:GetChecked()
		end)
		self.btn_left16.text:SetText(WHITE_FONT_COLOR_CODE..L["UIErrorsFramePosition"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_left17 Auto_Screenshot
		-----------------------------------------------
		if not self.btn_left17 then
			self.btn_left17 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_left17:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*17)
		self.btn_left17:SetChecked(Octo_ToDoVars.config.Auto_Screenshot)
		self.btn_left17:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Auto_Screenshot = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left17.text:SetText(WHITE_FONT_COLOR_CODE..L["Auto_Screenshot"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center2 GlobalFadePersist
		-----------------------------------------------
		if not self.btn_center2 then
			self.btn_center2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*2)
		self.btn_center2:SetChecked(Octo_ToDoVars.config.GlobalFadePersist)
		self.btn_center2:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.GlobalFadePersist = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isElvUI then
			self.btn_center2.text:SetText(E.Octo_Func.func_Gradient("GlobalFadePersist", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (ElvUI ENABLED)|r")
		else
			self.btn_center2.text:SetText(E.Octo_Globals.LightGray_Color.."GlobalFadePersist".." (ElvUI DISABLED)|r")
		end
		-----------------------------------------------
		-- btn_center3 LootFrame
		-----------------------------------------------
		if not self.btn_center3 then
			self.btn_center3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*3)
		self.btn_center3:SetChecked(Octo_ToDoVars.config.LootFrame)
		self.btn_center3:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.LootFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isRCLootCouncil then
			self.btn_center3.text:SetText(E.Octo_Func.func_Gradient("LootFrame", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (RCLootCouncil ENABLED)|r")
		else
			self.btn_center3.text:SetText(E.Octo_Globals.LightGray_Color.."LootFrame".." (RCLootCouncil DISABLED)|r")
		end
		-----------------------------------------------
		-- btn_center4 SellFrame
		-----------------------------------------------
		if not self.btn_center4 then
			self.btn_center4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*4)
		self.btn_center4:SetChecked(Octo_ToDoVars.config.SellFrame)
		self.btn_center4:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SellFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center4.text:SetText(WHITE_FONT_COLOR_CODE.."SellFrame"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center5 UsableItems
		-----------------------------------------------
		if not self.btn_center5 then
			self.btn_center5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*5)
		self.btn_center5:SetChecked(Octo_ToDoVars.config.UsableItems)
		self.btn_center5:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UsableItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center5.text:SetText(WHITE_FONT_COLOR_CODE.."UsableItems"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center6 ShowHoliday
		-----------------------------------------------
		if not self.btn_center6 then
			self.btn_center6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*6)
		self.btn_center6:SetChecked(Octo_ToDoVars.config.ShowHoliday)
		self.btn_center6:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowHoliday = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center6.text:SetText(WHITE_FONT_COLOR_CODE.."ShowHoliday"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center7 ShowTransmogrification
		-----------------------------------------------
		if not self.btn_center7 then
			self.btn_center7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*7)
		self.btn_center7:SetChecked(Octo_ToDoVars.config.ShowTransmogrification)
		self.btn_center7:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowTransmogrification = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center7.text:SetText(E.Octo_Func.func_texturefromIcon(1673939)..WHITE_FONT_COLOR_CODE.."ShowTransmogrification"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center8 ShowInstanceCD
		-----------------------------------------------
		if not self.btn_center8 then
			self.btn_center8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*8)
		self.btn_center8:SetChecked(Octo_ToDoVars.config.ShowInstanceCD)
		self.btn_center8:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowInstanceCD = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center8.text:SetText(WHITE_FONT_COLOR_CODE.."ShowInstanceCD"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center9 ShowCurrency
		-----------------------------------------------
		if not self.btn_center9 then
			self.btn_center9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*9)
		self.btn_center9:SetChecked(Octo_ToDoVars.config.ShowCurrency)
		self.btn_center9:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowCurrency = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center9.text:SetText(WHITE_FONT_COLOR_CODE.."ShowCurrency"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center10 ShowReputation
		-----------------------------------------------
		if not self.btn_center10 then
			self.btn_center10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*10)
		self.btn_center10:SetChecked(Octo_ToDoVars.config.ShowReputation)
		self.btn_center10:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowReputation = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center10.text:SetText(WHITE_FONT_COLOR_CODE.."ShowReputation"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center11 ShowQuests
		-----------------------------------------------
		if not self.btn_center11 then
			self.btn_center11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*11)
		self.btn_center11:SetChecked(Octo_ToDoVars.config.ShowQuests)
		self.btn_center11:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center11.text:SetText(WHITE_FONT_COLOR_CODE.."ShowQuests"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center12 ShowItems
		-----------------------------------------------
		if not self.btn_center12 then
			self.btn_center12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*12)
		self.btn_center12:SetChecked(Octo_ToDoVars.config.ShowItems)
		self.btn_center12:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center12.text:SetText(WHITE_FONT_COLOR_CODE.."ShowItems"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center13 ShowProfessions
		-----------------------------------------------
		if not self.btn_center13 then
			self.btn_center13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*13)
		self.btn_center13:SetChecked(Octo_ToDoVars.config.ShowProfessions)
		self.btn_center13:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowProfessions = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center13.text:SetText(WHITE_FONT_COLOR_CODE.."ShowProfessions"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center14 ShowMoney
		-----------------------------------------------
		if not self.btn_center14 then
			self.btn_center14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*14)
		self.btn_center14:SetChecked(Octo_ToDoVars.config.ShowMoney)
		self.btn_center14:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowMoney = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center14.text:SetText(WHITE_FONT_COLOR_CODE.."ShowMoney"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center15 ShowItemLevel
		-----------------------------------------------
		if not self.btn_center15 then
			self.btn_center15 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*15)
		self.btn_center15:SetChecked(Octo_ToDoVars.config.ShowItemLevel)
		self.btn_center15:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItemLevel = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center15.text:SetText(WHITE_FONT_COLOR_CODE.."ShowItemLevel"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center16 ShowLogoutTime
		-----------------------------------------------
		if not self.btn_center16 then
			self.btn_center16 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center16:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*16)
		self.btn_center16:SetChecked(Octo_ToDoVars.config.ShowLogoutTime)
		self.btn_center16:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowLogoutTime = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center16.text:SetText(WHITE_FONT_COLOR_CODE.."ShowLogoutTime"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center17 AidingtheAccord
		-----------------------------------------------
		if not self.btn_center17 then
			self.btn_center17 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center17:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*17)
		self.btn_center17:SetChecked(Octo_ToDoVars.config.AidingtheAccord)
		self.btn_center17:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AidingtheAccord = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center17.text:SetText(E.Octo_Func.func_texturefromIcon(1603189)..WHITE_FONT_COLOR_CODE..L["Aiding the Accord"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center18 TimeRift
		-----------------------------------------------
		if not self.btn_center18 then
			self.btn_center18 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center18:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*18)
		self.btn_center18:SetChecked(Octo_ToDoVars.config.TimeRift)
		self.btn_center18:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TimeRift = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center18.text:SetText(E.Octo_Func.func_texturefromIcon(628677)..E.Octo_Globals.Purple_Color..L["TimeRift"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center19 Dreamsurges
		-----------------------------------------------
		if not self.btn_center19 then
			self.btn_center19 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center19:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*19)
		self.btn_center19:SetChecked(Octo_ToDoVars.config.Dreamsurges)
		self.btn_center19:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Dreamsurges = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center19.text:SetText(E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Globals.Green_Color..L["Dreamsurges"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center20 Portals
		-----------------------------------------------
		if not self.btn_center20 then
			self.btn_center20 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_center20:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*20)
		self.btn_center20:SetChecked(Octo_ToDoVars.config.Portals)
		self.btn_center20:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Portals = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center20.text:SetText(E.Octo_Func.func_texturefromIcon(134414)..WHITE_FONT_COLOR_CODE..L["Portals"]..FONT_COLOR_CODE_CLOSE)




		-----------------------------------------------
		-- btn_right2 Expansions
		-----------------------------------------------
		local Expansions_Table = {
			"|cff68ccefClassic|r",
			"|cff4fff79The Burning Crusade|r",
			"|cff00a3ffWrath of the Lich King|r",
			"|cffffb300Cataclysm|r",
			"|cff00ffbaMists of Pandaria|r",
			"|cffc86400Warlords of Draenor|r",
			"|cff1eff00Legion|r",
			"|cff6464ffBattle for Azeroth|r",
			"|cffc9c3aaShadowlands|r",
			"|cffe8e379Dragonflight|r",
		}
		if not btn_right2 then
			btn_right2 = lsfdd:CreateButton(self, 140, 22)
		end
		btn_right2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*2)
		btn_right2:ddSetSelectedValue(Octo_ToDoVars.config.ExpansionToShow)
		-- print (tonumber(GetBuildInfo():match("(.-)%.")))
		local function selectFunction(menuButton)
			btn_right2:ddSetSelectedValue(menuButton.value)
			Octo_ToDoVars.config.ExpansionToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right2:ddInitialize(function(self, level)
				local info = {}
				for k, v in ipairs(Expansions_Table) do
					info.text = v
					info.value = k
					info.func = selectFunction
					self:ddAddButton(info, level)
				end
		end)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_right4 wowhead prefix
		-----------------------------------------------
		if not btn_right4 then
			btn_right4 = lsfdd:CreateButton(self, 140, 22)
		end
		btn_right4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*4)
		btn_right4:ddSetSelectedValue(Octo_ToDoOther.prefix)
		local function selectFunction(menuButton)
			btn_right4:ddSetSelectedValue(menuButton.value)
			Octo_ToDoOther.prefix = menuButton.value
			-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right4:ddInitialize(function(self, level)
				local info = {}
				for k, v in ipairs(E.Octo_Table.wowhead_prefix_Table) do
					info.text = v
					info.value = v
					info.func = selectFunction
					self:ddAddButton(info, level)
				end
		end)
		-----------------------------------------------
		-- btn_right7 ShowOnlyCurrentRealm
		-----------------------------------------------
		if not self.btn_right7 then
			self.btn_right7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*7)
		self.btn_right7:SetChecked(Octo_ToDoVars.config.ShowOnlyCurrentRealm)
		self.btn_right7:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowOnlyCurrentRealm = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right7.text:SetText(WHITE_FONT_COLOR_CODE..L["Only Current Realm"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- Slider_right9 LevelToShowTEXT
		-----------------------------------------------
		if not LevelToShowTEXT then
			LevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self.Slider_right9 then
			self.Slider_right9 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self.Slider_right9:SetWidth(140)
		self.Slider_right9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*9)
		self.Slider_right9:SetMinMaxValues(1, 70)
		local step = 1
		self.Slider_right9:SetValueStep(step)
		self.Slider_right9:SetValue(Octo_ToDoVars.config.LevelToShow)
		self.Slider_right9:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.LevelToShow = value
				LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		LevelToShowTEXT:SetPoint("BOTTOMLEFT", self.Slider_right9, "TOPLEFT", indent, 0)
		LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
		self.Slider_right9:Show()
		-----------------------------------------------
		-- Slider_right11 itemLevelToShowTEXT
		-----------------------------------------------
		if not itemLevelToShowTEXT then
			itemLevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self.Slider_right11 then
			self.Slider_right11 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self.Slider_right11:SetWidth(140*E.Octo_Globals.scale)
		self.Slider_right11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*11)
		self.Slider_right11:SetMinMaxValues(1, 560)
		local step = 5
		self.Slider_right11:SetValue(Octo_ToDoVars.config.itemLevelToShow)
		self.Slider_right11:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.itemLevelToShow = value
				itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		itemLevelToShowTEXT:SetPoint("BOTTOMLEFT", self.Slider_right11, "TOPLEFT", indent, 0)
		itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
		self.Slider_right11:Show()
		-----------------------------------------------
		-- Slider_right13 itemLevelToShowTEXT
		-----------------------------------------------
		if not curWidthTEXT then
			curWidthTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self.Slider_right13 then
			self.Slider_right13 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self.Slider_right13:SetWidth(140)
		self.Slider_right13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*13)
		self.Slider_right13:SetMinMaxValues(60, 120)
		local step = 2
		self.Slider_right13:SetValueStep(step)
		self.Slider_right13:SetValue(Octo_ToDoVars.config.curWidth)
		self.Slider_right13:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidth = value
				curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTEXT:SetPoint("BOTTOMLEFT", self.Slider_right13, "TOPLEFT", indent, 0)
		curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
		self.Slider_right13:Show()
		-----------------------------------------------
		-- Slider_right15 itemLevelToShowTEXT
		-----------------------------------------------
		if not curWidthTitleTEXT then
			curWidthTitleTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self.Slider_right15 then
			self.Slider_right15 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self.Slider_right15:SetWidth(140)
		self.Slider_right15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*15)
		self.Slider_right15:SetMinMaxValues(100, 400)
		local step = 5
		self.Slider_right15:SetValueStep(step)
		self.Slider_right15:SetValue(Octo_ToDoVars.config.curWidthTitle)
		self.Slider_right15:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidthTitle = value
				curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTitleTEXT:SetPoint("BOTTOMLEFT", self.Slider_right15, "TOPLEFT", indent, 0)
		curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
		self.Slider_right15:Show()
		-----------------------------------------------
		-----------------------------------------------
		-- btn_right20 StaticPopup1Button1
		-----------------------------------------------
		if not self.btn_right20 then
			self.btn_right20 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right20:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*20)
		self.btn_right20:SetChecked(Octo_ToDoVars.config.StaticPopup1Button1)
		self.btn_right20:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.StaticPopup1Button1 = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right20.text:SetText(E.Octo_Func.func_Gradient("StaticPopup1Button1", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		-----------------------------------------------
		-- btn_right21 AnotherAddonsCasual
		-----------------------------------------------
		if not self.btn_right21 then
			self.btn_right21 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right21:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*21)
		self.btn_right21:SetChecked(Octo_ToDoVars.config.AnotherAddonsCasual)
		self.btn_right21:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsCasual = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right21.text:SetText(E.Octo_Func.func_Gradient("AnotherAddonsCasual", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		-----------------------------------------------
		-- btn_right22 AnotherAddonsRAID
		-----------------------------------------------
		if not self.btn_right22 then
			self.btn_right22 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right22:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*22)
		self.btn_right22:SetChecked(Octo_ToDoVars.config.AnotherAddonsRAID)
		self.btn_right22:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsRAID = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right22.text:SetText(E.Octo_Func.func_Gradient("AnotherAddonsRAID", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		-----------------------------------------------
		-- btn_left23 CVar
		-----------------------------------------------
		if not self.btn_right23 then
			self.btn_right23 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right23:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*23)
		self.btn_right23:SetChecked(Octo_ToDoVars.config.CVar)
		self.btn_right23:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CVar = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right23.text:SetText(E.Octo_Func.func_Gradient("CVar", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		-----------------------------------------------
		-- btn_left24 SORTING
		-----------------------------------------------
		if not self.btn_right24 then
			self.btn_right24 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self.btn_right24:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*24)
		self.btn_right24:SetChecked(Octo_ToDoVars.config.SORTING)
		self.btn_right24:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SORTING = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right24.text:SetText(E.Octo_Func.func_Gradient("SORTING", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config_MAIN, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)


	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local Currency_Table = {
		2245,
		2594,
		2122,
		2118,
		2003,

		2009,
		1906,
		1828,
		1977,
		1813,
		1979,
		1904,
		1819,
		1931,
		1767,
		1885,
		1820,
		1816,
	}
	local TESTTABLEQWE = 15
	config_FIRST = CreateFrame("FRAME", GlobalAddonName.."config_FIRST"..E.Octo_Func.GenerateUniqueID())
	config_FIRST:Hide()
	config_FIRST:SetScript("OnShow", function(self)
			self:SetPoint("TOPLEFT", 0, 0)
			-- TITLE_FIRST
			if not title_FIRST then
				title_FIRST = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			end
			title_FIRST:SetPoint("TOPLEFT", 4, 30)
			title_FIRST:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			title_FIRST:SetTextColor(.5, .5, .5, 1)
			-----------------------------------------------
			-- TEXT LEFT
			-----------------------------------------------
			-- if not LEFTTEXT1_FIRST then
			-- 	LEFTTEXT1_FIRST = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			-- end
			-- LEFTTEXT1_FIRST:SetText(L["Functions"])
			-- LEFTTEXT1_FIRST:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", 0, -indent*1-4)
			-----------------------------------------------
			-- BUTTON
			-----------------------------------------------
			for number, currencyID in pairs(Currency_Table) do
				if not self[number] then
					self[number] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
				end
				self[number]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", 0, -indent*number)
				self[number]:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
				self[number]:SetScript("OnClick", function(btn)
						Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
						StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				end)
				self[number].text:SetText(E.Octo_Func.func_currencyicon(currencyID)..E.Octo_Func.func_currencyName(currencyID))
			end
			-----------------------------------------------



	end)
	-- ADD SUBCATEGORY
	local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, config_FIRST, L["InDev"])
	subcategory.ID = L["InDev"]
	Settings.RegisterAddOnCategory(subcategory)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------

-- -- ADD SUBCATEGORY
-- local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, aboutConfig, "2")
-- subcategory.ID = "2"
-- Settings.RegisterAddOnCategory(subcategory)