local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
--
--
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
	text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
local Expansions_Table = {
	"|cff68ccefClassic"..FONT_COLOR_CODE_CLOSE,
	"|cff4fff79The Burning Crusade"..FONT_COLOR_CODE_CLOSE,
	"|cff00a3ffWrath of the Lich King"..FONT_COLOR_CODE_CLOSE,
	"|cffffb300Cataclysm"..FONT_COLOR_CODE_CLOSE,
	"|cff00ffbaMists of Pandaria"..FONT_COLOR_CODE_CLOSE,
	"|cffc86400Warlords of Draenor"..FONT_COLOR_CODE_CLOSE,
	"|cff1eff00Legion"..FONT_COLOR_CODE_CLOSE,
	"|cff6464ffBattle for Azeroth"..FONT_COLOR_CODE_CLOSE,
	"|cffc9c3aaShadowlands"..FONT_COLOR_CODE_CLOSE,
	"|cffe8e379Dragonflight"..FONT_COLOR_CODE_CLOSE,
}
local indent = 22
local POS_LEFT = 0
local POS_RIGHT = 480
local POS_CENTER = POS_RIGHT/2
local Generate = E.Octo_Func.GenerateUniqueID()
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
		--
		local number = 1
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoSellGrey"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 2
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AutoRepair)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoRepair = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoRepair"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 3
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.InputDelete)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.InputDelete = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["InputDelete"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 4
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AutoOpen)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoOpen = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoOpen"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 5
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AutoGossip)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoGossip = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoGossip"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 6
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.CinematicCanceler)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CinematicCanceler = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["CinematicCanceler"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 7
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AutoTurnQuests)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoTurnQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Auto Turn Quests"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 8
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ClearChat)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ClearChat = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["ClearChat"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 9
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.TalkingHeadFrame)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TalkingHeadFrame = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["TalkingHeadFrame"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 10
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.HideZoneText)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideZoneText = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["HideZoneText"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 11
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.Covenant)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Covenant = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["HideCovenant"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 12
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.RaidBossEmoteFrame)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.RaidBossEmoteFrame = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["RaidBossEmoteFrame"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 13
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.BossBanner)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.BossBanner = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["BossBanner"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 14
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.HideErrorMessages)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideErrorMessages = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["HideErrorMessages"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 15
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.UIErrorsFramePosition)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UIErrorsFramePosition = btn:GetChecked()
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["UIErrorsFramePosition"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 16
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.Auto_Screenshot)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Auto_Screenshot = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Auto_Screenshot"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 17
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.UsableItems)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UsableItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE.."UsableItems (Слева сверху)"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 1
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AidingtheAccord)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AidingtheAccord = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Aiding the Accord"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..
		--
		local number = 2
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.CommunityFeast)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CommunityFeast = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Community Feast"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..
		--
		local number = 3
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ResearchersUnderFire)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ResearchersUnderFire = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Researchers Under Fire"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..












		--
		local number = 4
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowTransmogrification)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowTransmogrification = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..TRANSMOGRIFICATION.." (Аберрий)"..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1673939)..
		--
		local number = 5
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.TimeRift)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TimeRift = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Globals.Purple_Color..L["TimeRift"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(628677)..
		--
		local number = 6
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.Dreamsurges)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Dreamsurges = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Globals.Green_Color..L["Dreamsurges"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(134206)..
		--
		local number = 7
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowHoliday)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowHoliday = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Globals.Yellow_Color..CALENDAR_FILTER_HOLIDAYS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 8
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.InstanceTracker)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.InstanceTracker = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..DUNGEONS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 9
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowCurrency)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowCurrency = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..CURRENCY..FONT_COLOR_CODE_CLOSE)
		--
		local number = 9
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowReputation)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowReputation = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..REPUTATION..FONT_COLOR_CODE_CLOSE)
		--
		local number = 10
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowQuests)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..QUESTS_LABEL..FONT_COLOR_CODE_CLOSE)
		--
		local number = 11
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowSkips)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowSkips = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["ShowSkips"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 12
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowItems)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..ITEMS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 13
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowProfessions)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowProfessions = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE.."Профессии"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 14
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowMoney)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowMoney = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE.."Деньги"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 15
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowItemLevel)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItemLevel = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE.."Уровень предметов"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 16
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowLogoutTime)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowLogoutTime = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE.."Время выхода"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 1
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not btn_right2 then
			btn_right2 = lsfdd:CreateButton(self, 140, 22)
		end
		btn_right2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
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
		--
		local number = 2
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not btn_right4 then
			btn_right4 = lsfdd:CreateButton(self, 140, 22)
		end
		btn_right4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
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
		--
		--
		local number = 4
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not LevelToShowTEXT then
			LevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self[pizda] then
			self[pizda] = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self[pizda]:SetWidth(140)
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetMinMaxValues(1, 70)
		local step = 1
		self[pizda]:SetValueStep(step)
		self[pizda]:SetValue(Octo_ToDoVars.config.LevelToShow)
		self[pizda]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.LevelToShow = value
				LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		LevelToShowTEXT:SetPoint("BOTTOMLEFT", self[pizda], "TOPLEFT", indent, 0)
		LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
		self[pizda]:Show()
		--
		local number = 6
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not itemLevelToShowTEXT then
			itemLevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self[pizda] then
			self[pizda] = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self[pizda]:SetWidth(140*E.Octo_Globals.scale)
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetMinMaxValues(1, 560)
		local step = 5
		self[pizda]:SetValue(Octo_ToDoVars.config.itemLevelToShow)
		self[pizda]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.itemLevelToShow = value
				itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		itemLevelToShowTEXT:SetPoint("BOTTOMLEFT", self[pizda], "TOPLEFT", indent, 0)
		itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
		self[pizda]:Show()
		--
		local number = 8
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not curWidthTEXT then
			curWidthTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self[pizda] then
			self[pizda] = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self[pizda]:SetWidth(140)
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetMinMaxValues(60, 120)
		local step = 2
		self[pizda]:SetValueStep(step)
		self[pizda]:SetValue(Octo_ToDoVars.config.curWidth)
		self[pizda]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidth = value
				curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTEXT:SetPoint("BOTTOMLEFT", self[pizda], "TOPLEFT", indent, 0)
		curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
		self[pizda]:Show()
		--
		local number = 10
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not curWidthTitleTEXT then
			curWidthTitleTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		end
		if not self[pizda] then
			self[pizda] = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		end
		self[pizda]:SetWidth(140)
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetMinMaxValues(100, 400)
		local step = 5
		self[pizda]:SetValueStep(step)
		self[pizda]:SetValue(Octo_ToDoVars.config.curWidthTitle)
		self[pizda]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidthTitle = value
				curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTitleTEXT:SetPoint("BOTTOMLEFT", self[pizda], "TOPLEFT", indent, 0)
		curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
		self[pizda]:Show()
		--
		local number = 12
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.ShowOnlyCurrentRealm)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowOnlyCurrentRealm = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(WHITE_FONT_COLOR_CODE..L["Only Current Realm"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 13
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.Portals)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Portals = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_texturefromIcon(3610528)..WHITE_FONT_COLOR_CODE..L["Portals"]..FONT_COLOR_CODE_CLOSE)
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config_MAIN, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)
-----
-----
-----
-----
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
		--
		-- for number, currencyID in pairs(Currency_Table) do
		--     if not self[pizda] then
		--         self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		--     end
		--     self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		--     self[pizda]:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
		--     self[pizda]:SetScript("OnClick", function(btn)
		--             Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
		--             StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		--     end)
		--     self[pizda].text:SetText(E.Octo_Func.func_currencyicon(currencyID)..E.Octo_Func.func_currencyName(currencyID))
		-- end
		--
		local number = 1
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.StaticPopup1Button1)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.StaticPopup1Button1 = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_Gradient("StaticPopup1Button1", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		--
		local number = 2
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AnotherAddonsCasual)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsCasual = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_Gradient("AnotherAddonsCasual", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		--
		local number = 3
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.AnotherAddonsRAID)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsRAID = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_Gradient("AnotherAddonsRAID", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		--
		local number = 4
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.CVar)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CVar = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_Gradient("CVar", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		--
		local number = 5
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.SORTING)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SORTING = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Func.func_Gradient("SORTING", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
		--
		local number = 6
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.SellFrame)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SellFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[pizda].text:SetText(E.Octo_Globals.LightGray_Color.."SellFrame"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 7
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.GlobalFadePersist)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.GlobalFadePersist = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isElvUI == true then
			self[pizda].text:SetText(E.Octo_Func.func_Gradient("GlobalFadePersist", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (ElvUI ENABLED)"..FONT_COLOR_CODE_CLOSE)
		else
			self[pizda].text:SetText(E.Octo_Globals.LightGray_Color.."GlobalFadePersist".." (ElvUI DISABLED)"..FONT_COLOR_CODE_CLOSE)
		end
		--
		local number = 8
		local pizda = E.Octo_Func.GenerateUniqueID()
		if not self[pizda] then
			self[pizda] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		end
		self[pizda]:SetPoint("TOPLEFT", title_FIRST, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizda]:SetChecked(Octo_ToDoVars.config.LootFrame)
		self[pizda]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.LootFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isRCLootCouncil then
			self[pizda].text:SetText(E.Octo_Func.func_Gradient("LootFrame", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (RCLootCouncil ENABLED)"..FONT_COLOR_CODE_CLOSE)
		else
			self[pizda].text:SetText(E.Octo_Globals.LightGray_Color.."LootFrame".." (RCLootCouncil DISABLED)"..FONT_COLOR_CODE_CLOSE)
		end
end)
-- ADD SUBCATEGORY
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, config_FIRST, "Yamete Kudasai")
subcategory.ID = "Yamete Kudasai"
Settings.RegisterAddOnCategory(subcategory)
-----
-----
-----
-----
-- -- ADD SUBCATEGORY
-- local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, aboutConfig, "2")
-- subcategory.ID = "2"
-- Settings.RegisterAddOnCategory(subcategory)