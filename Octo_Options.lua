local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
local slider_scale = 0.8
local multiplier = 2-slider_scale
--
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
--
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
	text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
local indent = 28
local POS_LEFT = 6
local POS_RIGHT = 474
local POS_CENTER = POS_RIGHT/2
----------------------------------------------------------------
--------------------------MAIN_Config---------------------------
----------------------------------------------------------------
local MAIN_Config = CreateFrame("ScrollFrame", GlobalAddonName.."MAIN_Config")
MAIN_Config:Hide()
local MAIN_ScrollBar = CreateFrame("EventFrame", nil, MAIN_Config, "MinimalScrollBar")
MAIN_ScrollBar:SetPoint("TOPLEFT", MAIN_Config, "TOPRIGHT", 6, 0)
MAIN_ScrollBar:SetPoint("BOTTOMLEFT", MAIN_Config, "BOTTOMRIGHT", 6, 0)
local MAIN_scrollChild = CreateFrame("Frame", nil, MAIN_Config)
MAIN_Config:SetScrollChild(MAIN_scrollChild)
MAIN_Config:SetAllPoints()
MAIN_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(MAIN_Config, MAIN_ScrollBar)
local MAIN_OnMouseWheel = MAIN_Config:GetScript("OnMouseWheel")
MAIN_Config:SetScript("OnMouseWheel", function(self, ...)
		if MAIN_ScrollBar:IsShown() then
			MAIN_OnMouseWheel(self, ...)
		end
end)
--MAIN_TITLE
MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
MAIN_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
MAIN_TITLE:SetTextColor(.5, .5, .5, 1)
----------------------------------------------------------------
MAIN_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoSellGrey"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AutoRepair)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoRepair = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoRepair"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 3
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.InputDelete)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.InputDelete = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["InputDelete"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 4
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AutoOpen)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoOpen = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoOpen"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 5
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AutoGossip)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoGossip = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["AutoGossip"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 6
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.CinematicCanceler)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CinematicCanceler = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["CinematicCanceler"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 7
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AutoTurnQuests)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoTurnQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Auto Turn Quests"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 8
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ClearChat)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ClearChat = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["ClearChat"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 9
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.TalkingHeadFrame)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TalkingHeadFrame = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["TalkingHeadFrame"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 10
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.HideZoneText)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideZoneText = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["HideZoneText"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 11
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Covenant)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Covenant = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["HideCovenant"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 12
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.RaidBossEmoteFrame)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.RaidBossEmoteFrame = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["RaidBossEmoteFrame"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 13
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.BossBanner)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.BossBanner = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["BossBanner"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 14
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.HideErrorMessages)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideErrorMessages = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["HideErrorMessages"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 15
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.UIErrorsFramePosition)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UIErrorsFramePosition = btn:GetChecked()
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["UIErrorsFramePosition"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 16
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Auto_Screenshot)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Auto_Screenshot = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Auto_Screenshot"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 17
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.UsableItems)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UsableItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."UsableItems (Слева сверху)"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 18
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Hide_ObjectivesInInstance)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Hide_ObjectivesInInstance = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Hide_ObjectivesInInstance"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 19
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ChallengesKeystoneFrame)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ChallengesKeystoneFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."ChallengesKeystoneFrame"..FONT_COLOR_CODE_CLOSE)

















		--
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AidingtheAccord)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AidingtheAccord = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Aiding the Accord"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.CommunityFeast)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CommunityFeast = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Community Feast"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..
		--
		local number = 3
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ResearchersUnderFire)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ResearchersUnderFire = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Researchers Under Fire"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1603189)..
		--
		-- local number = 4
		-- local pizza = E.Octo_Func.GenerateUniqueID()
		-- self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		-- self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		-- self[pizza]:SetChecked(Octo_ToDoVars.config.ShowTransmogrification)
		-- self[pizza]:SetScript("OnClick", function(btn)
		-- 		Octo_ToDoVars.config.ShowTransmogrification = btn:GetChecked()
		-- 		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		-- end)
		-- 		self[pizza].text:SetJustifyV("MIDDLE")
		-- self[pizza].text:SetJustifyH("LEFT")
		-- self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..TRANSMOGRIFICATION.." (Аберрий)"..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1673939)..
		--
		local number = 4
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.TimeRift)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TimeRift = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Globals.Purple_Color..L["TimeRift"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(628677)..
		--
		local number = 5
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Dreamsurges)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Dreamsurges = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Globals.Green_Color..L["Dreamsurges"]..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(134206)..
		--
		local number = 6
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowEvents)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowEvents = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Globals.Yellow_Color..EVENTS_LABEL..FONT_COLOR_CODE_CLOSE)
		--
		local number = 7
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowPVPEvents)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowPVPEvents = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Globals.Yellow_Color..EVENTS_LABEL.." (PvP)"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 8
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowHoliday)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowHoliday = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Globals.Yellow_Color..CALENDAR_FILTER_HOLIDAYS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 9
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.InstanceTracker)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.InstanceTracker = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..DUNGEONS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 10
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowCurrency)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowCurrency = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..CURRENCY..FONT_COLOR_CODE_CLOSE)
		--
		local number = 11
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowReputation)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowReputation = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..REPUTATION..FONT_COLOR_CODE_CLOSE)
		--
		local number = 12
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowQuests)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..QUESTS_LABEL..FONT_COLOR_CODE_CLOSE)
		--
		local number = 13
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowItems)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..ITEMS..FONT_COLOR_CODE_CLOSE)
		--
		local number = 14
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowProfessions)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowProfessions = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Профессии"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 15
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowItemLevel)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowItemLevel = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Уровень предметов"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 16
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowLogoutTime)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowLogoutTime = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Время выхода"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		btn_right1 = lsfdd:CreateStretchButtonOriginal(MAIN_scrollChild, 140, 22) -- lsfdd:CreateButton
		btn_right1:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		btn_right1:SetText(EXPANSION_FILTER_TEXT)
		btn_right1:ddSetDisplayMode(GlobalAddonName)
		local function selectFunctionExpansion(menuButton)
			Octo_ToDoVars.config.ExpansionToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right1:ddSetInitFunc(function(self, level, value)
				local info = {}
				if not value then
					for k, v in ipairs(Expansions_Table) do
						info.text = v
						info.value = k
						info.checked = Octo_ToDoVars.config.ExpansionToShow == k
						info.func = selectFunctionExpansion
						self:ddAddButton(info, level)
					end
				end
		end)
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		btn_right2 = lsfdd:CreateStretchButtonOriginal(MAIN_scrollChild, 140, 22) -- lsfdd:CreateButton
		btn_right2:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		btn_right2:SetText("Wowhead prefix")
		btn_right2:ddSetDisplayMode(GlobalAddonName)
		local function selectFunctionprefix(menuButton)
			Octo_ToDoOther.prefix = menuButton.value
			-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right2:ddSetInitFunc(function(self, level, value)
				local info = {}
				if not value then
					for k, v in ipairs(E.Octo_Table.wowhead_prefix_Table) do
						info.text = v
						info.value = k
						info.checked = Octo_ToDoOther.prefix == k
						info.func = selectFunctionprefix
						self:ddAddButton(info, level)
					end
				end
		end)
		--
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		local number = 3
		local config = "LevelToShow"
		local text = L["Player level"]
		local minValue = 1
		local maxValue = 70
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,

			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 4
		local config = "LevelToShowMAX"
		local text = L["Player MAX level"]
		local minValue = 1
		local maxValue = 70
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 5
		local config = "itemLevelToShow"
		local text = L["Item level: "]
		local minValue = 1
		local maxValue = 560
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 6
		local config = "curWidth"
		local text = L["Width: "]
		local minValue = 60
		local maxValue = 160
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 7
		local config = "curWidthTitle"
		local text = L["curWidthTitle: "]
		local minValue = 100
		local maxValue = 400
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 8
		local config = "curWidthTitleAchievement"
		local text = "curWidthTitleAchievement"
		local minValue = 100
		local maxValue = 400
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 9
		local config = "curHeight"
		local text = "Высота строк: "
		local minValue = 10
		local maxValue = 30
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r"
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		local number = 10
		local config = "Addon_Height"
		local text = "Количество строк: /20"
		local minValue = 200
		local maxValue = 1200
		--------
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "MinimalSliderWithSteppersTemplate")
		self[pizza]:SetScale(slider_scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT*multiplier+11, -indent*number*multiplier)
		local steps = maxValue-minValue
		local formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return E.Octo_Globals.Green_Color..value.."|r" -- math.floor(value/20+.5)
			end,
		}
		self[pizza]:Init(Octo_ToDoVars.config[config], minValue, maxValue, steps, formatters)
		self[pizza]:SetWidth(200)
		self[pizza]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDoVars.config[config] = value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		--
		--
		local number = 11
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowOnlyCurrentRealm)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowOnlyCurrentRealm = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["Only Current Realm"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 12
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Portals)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Portals = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon(3610528, 20).." "..WHITE_FONT_COLOR_CODE..L["Portals"]..FONT_COLOR_CODE_CLOSE.." "..L["InDev"])
		--
		local number = 13
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Achievements)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Achievements = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 20).." "..WHITE_FONT_COLOR_CODE..ACHIEVEMENTS..FONT_COLOR_CODE_CLOSE) -- ..L["InDev"]


		--
		local number = 17
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowMoney)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowMoney = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Всего денег"..FONT_COLOR_CODE_CLOSE)





        --
        local number = 18
        local pizza = E.Octo_Func.GenerateUniqueID()
        self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
        self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
        self[pizza]:SetChecked(Octo_ToDoVars.config.ShowTime)
        self[pizza]:SetScript("OnClick", function(btn)
                Octo_ToDoVars.config.ShowTime = btn:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
                self[pizza].text:SetJustifyV("MIDDLE")
        self[pizza].text:SetJustifyH("LEFT")
        self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Общее время игры"..FONT_COLOR_CODE_CLOSE)
        --













		-- https://wowpedia.fandom.com/wiki/Patch_10.0.0/API_changes
		-- https://github.com/Gethe/wow-ui-source/tree/live/Interface/SharedXML/Slider









end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(MAIN_Config, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)
----------------------------------------------------------------
--------------------------FIRST_Config---------------------------
----------------------------------------------------------------
local FIRST_Config = CreateFrame("ScrollFrame", GlobalAddonName.."FIRST_Config")
FIRST_Config:Hide()
local FIRST_ScrollBar = CreateFrame("EventFrame", nil, FIRST_Config, "MinimalScrollBar")
FIRST_ScrollBar:SetPoint("TOPLEFT", FIRST_Config, "TOPRIGHT", 6, 0)
FIRST_ScrollBar:SetPoint("BOTTOMLEFT", FIRST_Config, "BOTTOMRIGHT", 6, 0)
local FIRST_scrollChild = CreateFrame("Frame", nil, FIRST_Config)
FIRST_Config:SetScrollChild(FIRST_scrollChild)
FIRST_Config:SetAllPoints()
FIRST_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(FIRST_Config, FIRST_ScrollBar)
local FIRST_OnMouseWheel = FIRST_Config:GetScript("OnMouseWheel")
FIRST_Config:SetScript("OnMouseWheel", function(self, ...)
		if FIRST_ScrollBar:IsShown() then
			FIRST_OnMouseWheel(self, ...)
		end
end)
-- TITLE_FIRST
TITLE_FIRST = FIRST_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_FIRST:SetPoint("TOPLEFT", 4, 30)
TITLE_FIRST:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_FIRST:SetTextColor(.5, .5, .5, 1)
----------------------------------------------------------------
FIRST_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		--
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_Function_FIRST)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_Function_FIRST = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22)..E.Octo_Globals.Function_Color.."Octo_debug_Function_FIRST".."|r")
		--
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_Event_FIRST)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_Event_FIRST = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_Event_FIRST".."|r")
				--
		local number = 1
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_BUTTONS_FIRST".."|r")


		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_Function_SECOND)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_Function_SECOND = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22)..E.Octo_Globals.Function_Color.."Octo_debug_Function_SECOND".."|r")
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_Event_SECOND)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_Event_SECOND = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_Event_SECOND".."|r")
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND = btn:GetChecked()
				-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_BUTTONS_SECOND".."|r")












		--
		local number = 3
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.StaticPopup1Button1)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.StaticPopup1Button1 = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("StaticPopup1Button1")
		--
		local number = 4
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AnotherAddonsCasual)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsCasual = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("AnotherAddonsCasual")
		--
		local number = 5
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.AnotherAddonsRAID)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AnotherAddonsRAID = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("AnotherAddonsRAID")
		--
		local number = 6
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.CVar)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CVar = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("CVar")
		--
		local number = 7
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.SORTING)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SORTING = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("SORTING")
		--
		local number = 8
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.SellFrame)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SellFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText("SellFrame")
		--
		local number = 9
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.GlobalFadePersist)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.GlobalFadePersist = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isElvUI == true then
					self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
			self[pizza].text:SetText("GlobalFadePersist"..E.Octo_Globals.Green_Color.." (ElvUI ENABLED)"..FONT_COLOR_CODE_CLOSE)
		else
					self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
			self[pizza].text:SetText(E.Octo_Globals.LightGray_Color.."GlobalFadePersist".." (ElvUI DISABLED)"..FONT_COLOR_CODE_CLOSE)
		end
		--
		local number = 10
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.LootFrame)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.LootFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if E.Octo_Globals.isRCLootCouncil then
					self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
			self[pizza].text:SetText("LootFrame"..E.Octo_Globals.Green_Color.." (RCLootCouncil ENABLED)"..FONT_COLOR_CODE_CLOSE)
		else
					self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
			self[pizza].text:SetText(E.Octo_Globals.LightGray_Color.."LootFrame".." (RCLootCouncil DISABLED)"..FONT_COLOR_CODE_CLOSE)
		end
end)
-- ADD SUBCATEGORY
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, L["InDev"].."FIRST_Config")
subcategory.ID = L["InDev"].."FIRST_Config"
Settings.RegisterAddOnCategory(subcategory)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
FIRST_Config.MEME = FIRST_Config:CreateTexture(nil, "BACKGROUND")
FIRST_Config.MEME:SetAllPoints()
FIRST_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/1.tga")
FIRST_Config.MEME:SetAlpha(.5)