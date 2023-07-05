local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local function TableConcat(t1,t2)
	for i=1,#t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end
local OctoTable_bytetoB64 = {
    [0]="a", "b", "c", "d", "e", "f", "g", "h",
    "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z", "A", "B", "C", "D", "E", "F",
    "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V",
    "W", "X", "Y", "Z", "0", "1", "2", "3",
    "4", "5", "6", "7", "8", "9", "(", ")"
}
function GenerateUniqueID()
    local s = {}
    for i=1, 11 do
	tinsert(s, OctoTable_bytetoB64[math.random(0, 63)])
    end
    return table.concat(s)
end
local Kyri_Color = "|cff6fa8dc"
local Necr_Color = "|cff93c47d"
local NFae_Color = "|cffb4a7d6"
local Vent_Color = "|cffea9999"
local Cyan_Color = "|cff00ccff"
local Rift_Color = "|cffbf9eff"
local Gray_Color = "|cff404040"
local Addon_Color = "|cff4FFF79"
local White_Color = "|cffFFF7D7"
local Blue_Color = "|cff00A3FF"
local Red_Color = "|cffFF4C4F"
local Green_Color = "|cff4FFF79"
local Yellow_Color = "|cffFFF371"
local Purple_Color = "|cffAF61FF"
local Orange_Color = "|cffFF661A"
local isElfUI = IsAddOnLoaded("ElvUI")
local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local config = CreateFrame("FRAME", GlobalAddonName.."config"..GenerateUniqueID())
-- config:RegisterEvent("VARIABLES_LOADED")
config:Hide()
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
    text = Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
    button1 = YES,
    button2 = NO,
    hideOnEscape = 1,
    whileDead = 1,
    OnAccept = function() ReloadUI() end,
}
local indent = 24
local function newSlider(slider_name, minRange, maxRange, stepSize, getValue, text)
    local slider = CreateFrame("Slider", "OctoSlider"..slider_name, title, "OptionsSliderTemplate")
    slider.minRange = minRange
    slider.maxRange = maxRange
    slider.stepSize = stepSize or 1
    slider.getValue = getValue
    slider.text = text
    slider:SetWidth(140)
    slider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*4)
    slider:SetMinMaxValues(minRange, maxRange)
    slider:SetValueStep(stepSize)
    slider:SetObeyStepOnDrag(true)
    slider.minText = _G[slider:GetName().."Low"]
    slider.maxText = _G[slider:GetName().."High"]
    slider.text = _G[slider:GetName().."Text"]
    slider.minText:SetText(minRange)
    slider.maxText:SetText(maxRange)
    slider.text:SetText(text)
    slider:SetScript("OnValueChanged", function (self, value)
	    value = math.floor(value * step + .5) / step
	    Octo_ToDoVars.config.LevelToShow = value
	    LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDoVars.config.LevelToShow)
    end)
    slider.tooltipText = text
    return slider
end
local function newButton(pos, line)
    Button = CreateFrame("CheckButton", "CheckButton"..GenerateUniqueID(), config.title, "InterfaceOptionsCheckButtonTemplate")
    Button:SetPoint("TOPLEFT", title, "BOTTOMLEFT", pos, -indent*line)
    Button:SetChecked(Octo_ToDoVars.config.ShowOnlyCurrentRealm)
    Button:SetScript("OnClick", function(Button)
	    Octo_ToDoVars.config.ShowOnlyCurrentRealm = Button:GetChecked()
	    StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
    end)
    Button.text:SetText("ShowOnlyCurrentRealm")
    return Button
end
config:SetScript("OnShow", function(self)
	self:SetScript("OnShow", function(self)
		self:SetPoint("TOPLEFT", 0, 0)
	end)
	self:SetPoint("TOPLEFT", 0, 0)
	-- TITLE
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 0, 30)
	title:SetText(AddonTitle)
	-- AddonVersion
	local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 0 ,0)
	ver:SetTextColor(.5, .5, .5, 1)
	ver:SetJustifyH("RIGHT")
	ver:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
	-----------------------------------------------
	-- btn_left2 InputDelete
	-----------------------------------------------
	self.btn_left2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*2)
	self.btn_left2:SetChecked(Octo_ToDoVars.config.InputDelete)
	self.btn_left2:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.InputDelete = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left2.text:SetText("InputDelete")
	-----------------------------------------------
	-----------------------------------------------
	-- btn_left3 UsableItems
	-----------------------------------------------
	self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*3)
	self.btn_left3:SetChecked(Octo_ToDoVars.config.UsableItems)
	self.btn_left3:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.UsableItems = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left3.text:SetText("UsableItems")
	-----------------------------------------------
	-- btn_left4 AutoOpen
	-----------------------------------------------
	self.btn_left4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*4)
	self.btn_left4:SetChecked(Octo_ToDoVars.config.AutoOpen)
	self.btn_left4:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AutoOpen = btn:GetChecked()
	end)
	self.btn_left4.text:SetText("AutoOpen")
	-----------------------------------------------
	-- btn_left5 AutoGossip
	-----------------------------------------------
	self.btn_left5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*5)
	self.btn_left5:SetChecked(Octo_ToDoVars.config.AutoGossip)
	self.btn_left5:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AutoGossip = btn:GetChecked()
	end)
	self.btn_left5.text:SetText("AutoGossip")
	-----------------------------------------------
	-- btn_left6 TalkingHeadFrame
	-----------------------------------------------
	self.btn_left6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*6)
	self.btn_left6:SetChecked(Octo_ToDoVars.config.TalkingHeadFrame)
	self.btn_left6:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.TalkingHeadFrame = btn:GetChecked()
	end)
	self.btn_left6.text:SetText("TalkingHeadFrame")
	-----------------------------------------------
	-- btn_left8 HideZoneText
	-----------------------------------------------
	self.btn_left8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*8)
	self.btn_left8:SetChecked(Octo_ToDoVars.config.HideZoneText)
	self.btn_left8:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.HideZoneText = btn:GetChecked()
	end)
	self.btn_left8.text:SetText("HideZoneText")
	-----------------------------------------------
	-- btn_left9 Covenant
	-----------------------------------------------
	self.btn_left9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*9)
	self.btn_left9:SetChecked(Octo_ToDoVars.config.Covenant)
	self.btn_left9:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.Covenant = btn:GetChecked()
	end)
	self.btn_left9.text:SetText("Covenant")
	-----------------------------------------------
	-- btn_left10 UIErrorsFrameScale
	-----------------------------------------------
	self.btn_left10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*10)
	self.btn_left10:SetChecked(Octo_ToDoVars.config.UIErrorsFrameScale)
	self.btn_left10:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.UIErrorsFrameScale = btn:GetChecked()
	end)
	self.btn_left10.text:SetText("UIErrorsFrameScale")
	-----------------------------------------------
	-- btn_left11 RaidBossEmoteFrame
	-----------------------------------------------
	self.btn_left11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*11)
	self.btn_left11:SetChecked(Octo_ToDoVars.config.RaidBossEmoteFrame)
	self.btn_left11:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.RaidBossEmoteFrame = btn:GetChecked()
	end)
	self.btn_left11.text:SetText("RaidBossEmoteFrame")
	-----------------------------------------------
	-- btn_left12 CinematicCanceler
	-----------------------------------------------
	self.btn_left12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*12)
	self.btn_left12:SetChecked(Octo_ToDoVars.config.CinematicCanceler)
	self.btn_left12:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.CinematicCanceler = btn:GetChecked()
	end)
	self.btn_left12.text:SetText("CinematicCanceler")
	-----------------------------------------------
	-- btn_left13 BossBanner
	-----------------------------------------------
	self.btn_left13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*13)
	self.btn_left13:SetChecked(Octo_ToDoVars.config.BossBanner)
	self.btn_left13:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.BossBanner = btn:GetChecked()
	end)
	self.btn_left13.text:SetText("BossBanner")
	-----------------------------------------------
	-----------------------------------------------
	-----------------------------------------------
	-- btn_left14 AnotherAddonsCasual
	-----------------------------------------------
	self.btn_left14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*14)
	self.btn_left14:SetChecked(Octo_ToDoVars.config.AnotherAddonsCasual)
	self.btn_left14:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AnotherAddonsCasual = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left14.text:SetText("AnotherAddonsCasual")
	-- btn_left15 AnotherAddonsRAID
	-----------------------------------------------
	self.btn_left15 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*15)
	self.btn_left15:SetChecked(Octo_ToDoVars.config.AnotherAddonsRAID)
	self.btn_left15:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AnotherAddonsRAID = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left15.text:SetText("AnotherAddonsRAID")
	-----------------------------------------------
	-----------------------------------------------
	-- btn_left16 ClearChat
	-----------------------------------------------
	self.btn_left16 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left16:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*16)
	self.btn_left16:SetChecked(Octo_ToDoVars.config.ClearChat)
	self.btn_left16:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.ClearChat = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left16.text:SetText("ClearChat")
	-----------------------------------------------
	-----------------------------------------------
	-- btn_left17 ShowOnlyCurrentRealm
	-----------------------------------------------
	self.btn_left17 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left17:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*17)
	self.btn_left17:SetChecked(Octo_ToDoVars.config.ShowOnlyCurrentRealm)
	self.btn_left17:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.ShowOnlyCurrentRealm = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left17.text:SetText("ShowOnlyCurrentRealm")
	-----------------------------------------------
	-- Slider_right18 LevelToShowTEXT
	local LevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	self.Slider_right18 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
	self.Slider_right18:SetWidth(140)
	self.Slider_right18:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*18)
	self.Slider_right18:SetMinMaxValues(1,70)
	self.Slider_right18:SetValueStep(1)
	local step = 1
	self.Slider_right18:SetValue(Octo_ToDoVars.config.LevelToShow)
	self.Slider_right18:SetScript("OnValueChanged", function (self, value)
		value = math.floor(value * step + .5) / step
		Octo_ToDoVars.config.LevelToShow = value
		LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDoVars.config.LevelToShow)
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	LevelToShowTEXT:SetPoint("LEFT", self.Slider_right18, "RIGHT", indent, 0)
	LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDoVars.config.LevelToShow)
	self.Slider_right18:Show()
	-- btn_left19 AutoSellGrey
	-----------------------------------------------
	self.btn_left19 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left19:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*19)
	self.btn_left19:SetChecked(Octo_ToDoVars.config.AutoSellGrey)
	self.btn_left19:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AutoSellGrey = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left19.text:SetText("AutoSellGrey")
	-- btn_left19 AutoRepair
	-----------------------------------------------
	self.btn_left20 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left20:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*20)
	self.btn_left20:SetChecked(Octo_ToDoVars.config.AutoRepair)
	self.btn_left20:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.AutoRepair = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left20.text:SetText("AutoRepair")
	-----------------------------------------------
	-- btn_left21 HideErrorMessages
	-----------------------------------------------
	self.btn_left21 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left21:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*21)
	self.btn_left21:SetChecked(Octo_ToDoVars.config.HideErrorMessages)
	self.btn_left21:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.HideErrorMessages = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left21.text:SetText("HideErrorMessages")
	-----------------------------------------------
	-- btn_left22 SellFrame
	-----------------------------------------------
	self.btn_left22 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_left22:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*22)
	self.btn_left22:SetChecked(Octo_ToDoVars.config.SellFrame)
	self.btn_left22:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.SellFrame = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_left22.text:SetText("SellFrame")
	-----------------------------------------------
	-- btn_center1 GlobalFadePersist
	-----------------------------------------------
	self.btn_center1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_center1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*1)
	self.btn_center1:SetChecked(Octo_ToDoVars.config.GlobalFadePersist)
	self.btn_center1:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.GlobalFadePersist = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	if isElvUI then
		self.btn_center1.text:SetText("GlobalFadePersist"..Green_Color.." (ElvUI ENABLED)|r")
	else
		self.btn_center1.text:SetText(Gray_Color.."GlobalFadePersist".." (ElvUI DISABLED)|r")
	end
	-----------------------------------------------
	-- btn_center2 LootFrame
	-----------------------------------------------
	self.btn_center2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_center2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*2)
	self.btn_center2:SetChecked(Octo_ToDoVars.config.LootFrame)
	self.btn_center2:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LootFrame = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	if isRCLootCouncil then
		self.btn_center2.text:SetText("LootFrame"..Green_Color.." (RCLootCouncil ENABLED)|r")
	else
		self.btn_center2.text:SetText(Gray_Color.."LootFrame".." (RCLootCouncil DISABLED)|r")
	end
	-- btn_right1 LINE_Classic
	-----------------------------------------------
	self.btn_right1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*1)
	self.btn_right1:SetChecked(Octo_ToDoVars.config.LINE_Classic)
	self.btn_right1:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_Classic = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right1.text:SetText("|cff68ccef".."Classic|r")
	-----------------------------------------------
	-- btn_right2 LINE_TheBurningCrusade
	-----------------------------------------------
	self.btn_right2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*2)
	self.btn_right2:SetChecked(Octo_ToDoVars.config.LINE_TheBurningCrusade)
	self.btn_right2:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_TheBurningCrusade = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right2.text:SetText("|cff4fff79".."The Burning Crusade|r")
	-----------------------------------------------
	-- btn_right3 LINE_WrathoftheLichKing
	-----------------------------------------------
	self.btn_right3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*3)
	self.btn_right3:SetChecked(Octo_ToDoVars.config.LINE_WrathoftheLichKing)
	self.btn_right3:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_WrathoftheLichKing = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right3.text:SetText("|cff00a3ff".."Wrath of the Lich King|r")
	-----------------------------------------------
	-- btn_right4 LINE_Cataclysm
	-----------------------------------------------
	self.btn_right4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*4)
	self.btn_right4:SetChecked(Octo_ToDoVars.config.LINE_Cataclysm)
	self.btn_right4:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_Cataclysm = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right4.text:SetText("|cffffb300".."Cataclysm|r")
	-----------------------------------------------
	-- btn_right5 LINE_MistsofPandaria
	-----------------------------------------------
	self.btn_right5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*5)
	self.btn_right5:SetChecked(Octo_ToDoVars.config.LINE_MistsofPandaria)
	self.btn_right5:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_MistsofPandaria = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right5.text:SetText("|cff00ffba".."Mists of Pandaria|r")
	-----------------------------------------------
	-- btn_right6 LINE_WarlordsofDraenor
	-----------------------------------------------
	self.btn_right6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*6)
	self.btn_right6:SetChecked(Octo_ToDoVars.config.LINE_WarlordsofDraenor)
	self.btn_right6:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_WarlordsofDraenor = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right6.text:SetText("|cffc86400".."Warlords of Draenor|r")
	-----------------------------------------------
	-- btn_right7 LINE_Legion
	-----------------------------------------------
	self.btn_right7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*7)
	self.btn_right7:SetChecked(Octo_ToDoVars.config.LINE_Legion)
	self.btn_right7:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_Legion = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right7.text:SetText("|cff1eff00".."Legion|r")
	-----------------------------------------------
	-- btn_right8 LINE_BattleforAzeroth
	-----------------------------------------------
	self.btn_right8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*8)
	self.btn_right8:SetChecked(Octo_ToDoVars.config.LINE_BattleforAzeroth)
	self.btn_right8:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_BattleforAzeroth = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right8.text:SetText("|cff6464ff".."Battle for Azeroth|r")
	-----------------------------------------------
	-- btn_right9 LINE_Shadowlands
	-----------------------------------------------
	self.btn_right9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*9)
	self.btn_right9:SetChecked(Octo_ToDoVars.config.LINE_Shadowlands)
	self.btn_right9:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_Shadowlands = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right9.text:SetText("|cffc9c3aa".."Shadowlands|r")
	-----------------------------------------------
	-- btn_right10 LINE_Dragonflight
	-----------------------------------------------
	self.btn_right10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*10)
	self.btn_right10:SetChecked(Octo_ToDoVars.config.LINE_Dragonflight)
	self.btn_right10:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.LINE_Dragonflight = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right10.text:SetText("|cffe8e379".."Dragonflight|r")
	-----------------------------------------------
	-- btn_left24 CVar
	-----------------------------------------------
	self.btn_right24 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn_right24:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 600, -indent*24)
	self.btn_right24:SetChecked(Octo_ToDoVars.config.CVar)
	self.btn_right24:SetScript("OnClick", function(btn)
		Octo_ToDoVars.config.CVar = btn:GetChecked()
		StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
	end)
	self.btn_right24.text:SetText("CVar")
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, GlobalAddonName)
category.ID = GlobalAddonName
Settings.RegisterAddOnCategory(category)
