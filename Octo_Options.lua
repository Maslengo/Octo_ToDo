local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
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
local Achievements_Table = {
	"ElementalStorm", -- 1
	"Исследование", -- 2
	"Задания", -- 3
	DUNGEONS, -- 4
	RAIDS, -- 5
	REPUTATION, -- 6
	COLLECTIONS, -- 7
	E.Octo_Globals.NONE,
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
local indent = 22
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
		local number = 4
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowTransmogrification)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowTransmogrification = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..TRANSMOGRIFICATION.." (Аберрий)"..FONT_COLOR_CODE_CLOSE) -- E.Octo_Func.func_texturefromIcon(1673939)..
		--
		local number = 5
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
		local number = 6
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
		local number = 7
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
		local number = 8
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
		local number = 9
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
		local number = 10
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
		local number = 11
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
		local number = 12
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
		local number = 13
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
		local number = 14
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowSkips)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowSkips = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE..L["ShowSkips"]..FONT_COLOR_CODE_CLOSE)
		--
		local number = 15
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
		local number = 16
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
		local number = 17
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, MAIN_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_CENTER, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.ShowMoney)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ShowMoney = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(WHITE_FONT_COLOR_CODE.."Деньги"..FONT_COLOR_CODE_CLOSE)
		--
		local number = 18
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
		local number = 19
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
		btn_right1 = lsfdd:CreateButton(MAIN_scrollChild, 140, 22)
		btn_right1:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		btn_right1:ddSetSelectedValue(Octo_ToDoVars.config.ExpansionToShow)
		-- print (tonumber(GetBuildInfo():match("(.-)%.")))
		local function selectFunctionExpansion(menuButton)
			btn_right1:ddSetSelectedValue(menuButton.value)
			Octo_ToDoVars.config.ExpansionToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right1:ddInitialize(function(self, level)
				local info = {}
				for k, v in ipairs(Expansions_Table) do
					info.text = v
					info.value = k
					info.func = selectFunctionExpansion
					self:ddAddButton(info, level)
				end
		end)
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		btn_right2 = lsfdd:CreateButton(MAIN_scrollChild, 140, 22)
		btn_right2:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		btn_right2:ddSetSelectedValue(Octo_ToDoOther.prefix)
		local function selectFunctionprefix(menuButton)
			btn_right2:ddSetSelectedValue(menuButton.value)
			Octo_ToDoOther.prefix = menuButton.value
			-- StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right2:ddInitialize(function(self, level)
				local info = {}
				for k, v in ipairs(E.Octo_Table.wowhead_prefix_Table) do
					info.text = v
					info.value = v
					info.func = selectFunctionprefix
					self:ddAddButton(info, level)
				end
		end)
		--
		local number = 4
		local pizza = E.Octo_Func.GenerateUniqueID()
		LevelToShowTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(1, 70)
		local step = 1
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.LevelToShow)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.LevelToShow = value
				LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		LevelToShowTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		LevelToShowTEXT:SetText(L["Player level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.LevelToShow..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 5.5
		local pizza = E.Octo_Func.GenerateUniqueID()
		itemLevelToShowTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140*E.Octo_Globals.scale)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(1, 560)
		local step = 5
		self[pizza]:SetValue(Octo_ToDoVars.config.itemLevelToShow)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.itemLevelToShow = value
				itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		itemLevelToShowTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		itemLevelToShowTEXT:SetText(L["Item level: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.itemLevelToShow..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 7
		local pizza = E.Octo_Func.GenerateUniqueID()
		curWidthTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(60, 160)
		local step = 2
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.curWidth)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidth = value
				curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		curWidthTEXT:SetText(L["Width: "]..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidth..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 8.5
		local pizza = E.Octo_Func.GenerateUniqueID()
		curWidthTitleTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(100, 400)
		local step = 5
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.curWidthTitle)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidthTitle = value
				curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTitleTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		curWidthTitleTEXT:SetText("curWidthTitle"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidthTitle..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 10
		local pizza = E.Octo_Func.GenerateUniqueID()
		curWidthTitleAchievementTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(100, 400)
		local step = 5
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.curWidthTitleAchievement)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curWidthTitleAchievement = value
				curWidthTitleAchievementTEXT:SetText("curWidthTitleAchievement"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curWidthTitleAchievement..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curWidthTitleAchievementTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		curWidthTitleAchievementTEXT:SetText("curWidthTitleAchievement"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curWidthTitleAchievement..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 11.5
		local pizza = E.Octo_Func.GenerateUniqueID()
		curHeightTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(10, 30)
		local step = 1
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.curHeight)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.curHeight = value
				curHeightTEXT:SetText("curHeight"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.curHeight..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		curHeightTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		curHeightTEXT:SetText("curHeight"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.curHeight..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 13
		local pizza = E.Octo_Func.GenerateUniqueID()
		Addon_HeightTEXT = MAIN_scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self[pizza] = CreateFrame("Slider", nil, MAIN_scrollChild, "OptionsSliderTemplate")
		self[pizza]:SetWidth(140)
		self[pizza]:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*number)
		self[pizza]:SetMinMaxValues(400, 1200)
		local step = 20
		self[pizza]:SetValueStep(step)
		self[pizza]:SetValue(Octo_ToDoVars.config.Addon_Height)
		self[pizza]:SetScript("OnValueChanged", function (self, value)
				value = math.floor(value * (1 / step) + .5) / (1 / step)
				Octo_ToDoVars.config.Addon_Height = value
				Addon_HeightTEXT:SetText("Addon_Height"..E.Octo_Globals.Red_Color..Octo_ToDoVars.config.Addon_Height..FONT_COLOR_CODE_CLOSE)
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		Addon_HeightTEXT:SetPoint("BOTTOMLEFT", self[pizza], "TOPLEFT", indent, 0)
		Addon_HeightTEXT:SetText("Addon_Height"..E.Octo_Globals.Green_Color..Octo_ToDoVars.config.Addon_Height..FONT_COLOR_CODE_CLOSE)
		self[pizza]:Show()
		--
		local number = 14
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
		local number = 15
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
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon(3610528, 20).." "..WHITE_FONT_COLOR_CODE..L["Portals"]..FONT_COLOR_CODE_CLOSE..L["InDev"])
		--
		local number = 16
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
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 20).." "..WHITE_FONT_COLOR_CODE..ACHIEVEMENTS..FONT_COLOR_CODE_CLOSE..L["InDev"])
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
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
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
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_Event_FIRST".."|r")
		--
		local number = 2
		local pizza = E.Octo_Func.GenerateUniqueID()
		self[pizza] = CreateFrame("CheckButton", nil, FIRST_scrollChild, "InterfaceOptionsCheckButtonTemplate")
		self[pizza]:SetPoint("TOPLEFT", FIRST_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*number)
		self[pizza]:SetChecked(Octo_ToDoVars.config.Octo_debug_Function_SECOND)
		self[pizza]:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Octo_debug_Function_SECOND = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
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
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
				self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
		self[pizza].text:SetText(E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22)..E.Octo_Globals.Event_Color.."Octo_debug_Event_SECOND".."|r")
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
--------------------------SECOND_Config-------------------------
----------------------------------------------------------------
local SECOND_Config = CreateFrame("ScrollFrame", GlobalAddonName.."SECOND_Config")
SECOND_Config:Hide()
local SECOND_ScrollBar = CreateFrame("EventFrame", nil, SECOND_Config, "MinimalScrollBar")
SECOND_ScrollBar:SetPoint("TOPLEFT", SECOND_Config, "TOPRIGHT", 6, 0)
SECOND_ScrollBar:SetPoint("BOTTOMLEFT", SECOND_Config, "BOTTOMRIGHT", 6, 0)
local SECOND_scrollChild = CreateFrame("Frame", nil, SECOND_Config)
SECOND_Config:SetScrollChild(SECOND_scrollChild)
SECOND_Config:SetAllPoints()
SECOND_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(SECOND_Config, SECOND_ScrollBar)
local SECOND_OnMouseWheel = SECOND_Config:GetScript("OnMouseWheel")
SECOND_Config:SetScript("OnMouseWheel", function(self, ...)
		if SECOND_ScrollBar:IsShown() then
			SECOND_OnMouseWheel(self, ...)
		end
end)
-- SECOND_TITLE
SECOND_TITLE = SECOND_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
SECOND_TITLE:SetPoint("TOPLEFT", 4, 30)
SECOND_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
SECOND_TITLE:SetTextColor(.5, .5, .5, 1)
----------------------------------------------------------------
SECOND_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		local curGUID = UnitGUID("PLAYER")
		local englishFaction = UnitFactionGroup("PLAYER")
		local count = 0
		for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
			if curCharGUID == curGUID then
				for k, v in pairs(E.Octo_Table.OctoTable_reputation_BC) do
					if CharInfo.Faction == v.faction or v.faction == "Both" then
						local pizza = E.Octo_Func.GenerateUniqueID()
						if not self[pizza] then
							count = count + 1
							self[pizza] = CreateFrame("CheckButton", nil, SECOND_scrollChild, "InterfaceOptionsCheckButtonTemplate")
							self[pizza]:SetPoint("TOPLEFT", SECOND_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*count)
							self[pizza]:SetChecked(Octo_ToDoVars.config.reputation[v.repID])
							self[pizza]:SetScript("OnClick", function(btn)
									Octo_ToDoVars.config.reputation[v.repID] = btn:GetChecked()
									StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
							end)
									self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
							self[pizza].text:SetText("repID: "..v.repID.." "..E.Octo_Func.func_reputationName(v.repID).." "..CharInfo.reputationID[v.repID])
						end
					end
				end
				break
			end
		end
end)
-- ADD SUBCATEGORY
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, SECOND_Config, L["InDev"].."SECOND_Config")
subcategory.ID = L["InDev"].."SECOND_Config"
Settings.RegisterAddOnCategory(subcategory)
----------------------------------------------------------------
--------------------------THIRD_Config--------------------------
----------------------------------------------------------------
local THIRD_Config = CreateFrame("ScrollFrame", GlobalAddonName.."THIRD_Config")
THIRD_Config:Hide()
local THIRD_ScrollBar = CreateFrame("EventFrame", nil, THIRD_Config, "MinimalScrollBar")
THIRD_ScrollBar:SetPoint("TOPLEFT", THIRD_Config, "TOPRIGHT", 6, 0)
THIRD_ScrollBar:SetPoint("BOTTOMLEFT", THIRD_Config, "BOTTOMRIGHT", 6, 0)
local THIRD_scrollChild = CreateFrame("Frame", nil, THIRD_Config)
THIRD_Config:SetScrollChild(THIRD_scrollChild)
THIRD_Config:SetAllPoints()
THIRD_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(THIRD_Config, THIRD_ScrollBar)
local THIRD_OnMouseWheel = THIRD_Config:GetScript("OnMouseWheel")
THIRD_Config:SetScript("OnMouseWheel", function(self, ...)
		if THIRD_ScrollBar:IsShown() then
			THIRD_OnMouseWheel(self, ...)
		end
end)
-- THIRD_TITLE
THIRD_TITLE = THIRD_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
THIRD_TITLE:SetPoint("TOPLEFT", 4, 30)
THIRD_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
THIRD_TITLE:SetTextColor(.5, .5, .5, 1)
----------------------------------------------------------------
THIRD_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		local curGUID = UnitGUID("PLAYER")
		local englishFaction = UnitFactionGroup("PLAYER")
		local count = 0
		local count2 = 0
		for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
			if curCharGUID == curGUID then
				for k, v in pairs(E.Octo_Table.OctoTable_reputation_Classic) do
					if CharInfo.Faction == v.faction or v.faction == "Both" then
						local pizza = E.Octo_Func.GenerateUniqueID()
						if not self[pizza] then
							count = count + 1
							self[pizza] = CreateFrame("CheckButton", nil, THIRD_scrollChild, "InterfaceOptionsCheckButtonTemplate")
							self[pizza]:SetPoint("TOPLEFT", THIRD_scrollChild, "BOTTOMLEFT", POS_LEFT, -indent*count)
							self[pizza]:SetChecked(Octo_ToDoVars.config.reputation[v.repID])
							self[pizza]:SetScript("OnClick", function(btn)
									Octo_ToDoVars.config.reputation[v.repID] = btn:GetChecked()
									StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
							end)
									self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
							self[pizza].text:SetText("ID: "..v.repID.." "..E.Octo_Func.func_reputationName(v.repID).." "..CharInfo.reputationID[v.repID])
						end
					end
				end


				for k, currencyID in pairs(E.Octo_Table.OctoTable_currencyID_ALL) do
					local pizza = E.Octo_Func.GenerateUniqueID()
					if not self[pizza] then
						count2 = count2 + 1
						self[pizza] = CreateFrame("CheckButton", nil, THIRD_scrollChild, "InterfaceOptionsCheckButtonTemplate")
						self[pizza]:SetPoint("TOPLEFT", THIRD_scrollChild, "BOTTOMLEFT", 350, -indent*count2)
						self[pizza]:SetChecked(Octo_ToDoVars.config.reputation[currencyID])
						self[pizza]:SetScript("OnClick", function(btn)
								Octo_ToDoVars.config.reputation[currencyID] = btn:GetChecked()
								StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
						end)
								self[pizza].text:SetJustifyV("MIDDLE")
		self[pizza].text:SetJustifyH("LEFT")
						self[pizza].text:SetText("ID: "..currencyID.." "..E.Octo_Func.func_currencyicon(currencyID)..E.Octo_Func.func_currencyName(currencyID).." "..CharInfo.CurrencyID_Total[currencyID])
					end
				end

				break
			end
		end
end)
-- ADD SUBCATEGORY
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, THIRD_Config, L["InDev"].."THIRD_Config")
subcategory.ID = L["InDev"].."THIRD_Config"
Settings.RegisterAddOnCategory(subcategory)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------




FIRST_Config.MEME = FIRST_Config:CreateTexture(nil, "BACKGROUND")
FIRST_Config.MEME:SetAllPoints()
FIRST_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/1.tga")
FIRST_Config.MEME:SetAlpha(.5)

SECOND_Config.MEME = SECOND_Config:CreateTexture(nil, "BACKGROUND")
SECOND_Config.MEME:SetAllPoints()
SECOND_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/2.tga")
SECOND_Config.MEME:SetAlpha(.5)

THIRD_Config.MEME = THIRD_Config:CreateTexture(nil, "BACKGROUND")
THIRD_Config.MEME:SetAllPoints()
THIRD_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/5.tga")
THIRD_Config.MEME:SetAlpha(.5)