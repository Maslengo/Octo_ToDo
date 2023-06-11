local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = GetAddOnMetadata(GlobalAddonName, "AddonVersion")
E.modules = {}
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local bytetoB64 = {
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
        tinsert(s, bytetoB64[math.random(0, 63)])
    end
    return table.concat(s)
end
local config = CreateFrame("FRAME", GlobalAddonName.."config"..GenerateUniqueID())
-- config:RegisterEvent("VARIABLES_LOADED")
config:Hide()
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
    text = "|cffFF0000!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
    button1 = YES,
    button2 = NO,
    hideOnEscape = 1,
    whileDead = 1,
    OnAccept = function() ReloadUI() end,
}
local indent = 34
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
            Octo_ToDo_DragonflyVars.config.LevelToShow = value
            LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDo_DragonflyVars.config.LevelToShow)
    end)
    slider.tooltipText = text
    return slider
end
local function newButton(pos, line)
    Button = CreateFrame("CheckButton", "CheckButton"..GenerateUniqueID(), config.title, "InterfaceOptionsCheckButtonTemplate")
    Button:SetPoint("TOPLEFT", title, "BOTTOMLEFT", pos, -indent*line)
    Button:SetChecked(Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm)
    Button:SetScript("OnClick", function(Button)
            Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm = Button:GetChecked()
            StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
    end)
    Button.text:SetText("|cffFF0000ShowOnlyCurrentRealm|r")
    return Button
end
config:SetScript("OnShow", function(self)
        self:SetScript("OnShow", function(self)
                self:SetPoint("TOPLEFT", -12, 8)
        end)
        self:SetPoint("TOPLEFT", -12, 8)
        -- AddonVersion
        local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        ver:SetPoint("TOPLEFT", 40, 20)
        ver:SetTextColor(.5, .5, .5, 1)
        ver:SetJustifyH("RIGHT")
        ver:SetText(GetAddOnMetadata(GlobalAddonName, "AddonVersion"))
        -- TITLE
        local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText(GlobalAddonName)
        -- btn_left1 CVar
        -----------------------------------------------
        self.btn_left1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*1)
        self.btn_left1:SetChecked(Octo_ToDo_DragonflyVars.config.CVar)
        self.btn_left1:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.CVar = btn_left:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_left1.text:SetText("|cffFF0000CVar|r")
        -----------------------------------------------
        -- btn_left2 InputDelete
        -----------------------------------------------
        self.btn_left2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*2)
        self.btn_left2:SetChecked(Octo_ToDo_DragonflyVars.config.InputDelete)
        self.btn_left2:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.InputDelete = btn_left:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_left2.text:SetText("|cffFF0000InputDelete|r")
        -----------------------------------------------
        -----------------------------------------------
        -- btn_left3 UsableItems
        -----------------------------------------------
        self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*3)
        self.btn_left3:SetChecked(Octo_ToDo_DragonflyVars.config.UsableItems)
        self.btn_left3:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.UsableItems = btn_left:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_left3.text:SetText("|cffFF0000UsableItems|r")
        -----------------------------------------------
        -- btn_left4 AutoOpen
        -----------------------------------------------
        self.btn_left4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*4)
        self.btn_left4:SetChecked(Octo_ToDo_DragonflyVars.config.AutoOpen)
        self.btn_left4:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.AutoOpen = btn_left:GetChecked()
        end)
        self.btn_left4.text:SetText("AutoOpen")
        -----------------------------------------------
        -- btn_left5 AutoGossip
        -----------------------------------------------
        self.btn_left5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*5)
        self.btn_left5:SetChecked(Octo_ToDo_DragonflyVars.config.AutoGossip)
        self.btn_left5:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.AutoGossip = btn_left:GetChecked()
        end)
        self.btn_left5.text:SetText("AutoGossip")
        -----------------------------------------------
        -- btn_left6 TalkingHeadFrame
        -----------------------------------------------
        self.btn_left6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*6)
        self.btn_left6:SetChecked(Octo_ToDo_DragonflyVars.config.TalkingHeadFrame)
        self.btn_left6:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.TalkingHeadFrame = btn_left:GetChecked()
        end)
        self.btn_left6.text:SetText("TalkingHeadFrame")
        -----------------------------------------------
        -- btn_left7 HideObjectiveTracker
        -----------------------------------------------
        self.btn_left7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*7)
        self.btn_left7:SetChecked(Octo_ToDo_DragonflyVars.config.HideObjectiveTracker)
        self.btn_left7:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.HideObjectiveTracker = btn_left:GetChecked()
        end)
        self.btn_left7.text:SetText("HideObjectiveTracker")
        -----------------------------------------------
        -- btn_left8 HideZoneText
        -----------------------------------------------
        self.btn_left8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*8)
        self.btn_left8:SetChecked(Octo_ToDo_DragonflyVars.config.HideZoneText)
        self.btn_left8:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.HideZoneText = btn_left:GetChecked()
        end)
        self.btn_left8.text:SetText("HideZoneText")
        -----------------------------------------------
        -- btn_left9 Covenant
        -----------------------------------------------
        self.btn_left9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*9)
        self.btn_left9:SetChecked(Octo_ToDo_DragonflyVars.config.Covenant)
        self.btn_left9:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.Covenant = btn_left:GetChecked()
        end)
        self.btn_left9.text:SetText("Covenant")
        -----------------------------------------------
        -- btn_left10 UIErrorsFrameScale
        -----------------------------------------------
        self.btn_left10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*10)
        self.btn_left10:SetChecked(Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale)
        self.btn_left10:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale = btn_left:GetChecked()
        end)
        self.btn_left10.text:SetText("UIErrorsFrameScale")
        -----------------------------------------------
        -- btn_left11 RaidBossEmoteFrame
        -----------------------------------------------
        self.btn_left11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*11)
        self.btn_left11:SetChecked(Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame)
        self.btn_left11:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame = btn_left:GetChecked()
        end)
        self.btn_left11.text:SetText("RaidBossEmoteFrame")
        -----------------------------------------------
        -- btn_left12 CinematicCanceler
        -----------------------------------------------
        self.btn_left12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*12)
        self.btn_left12:SetChecked(Octo_ToDo_DragonflyVars.config.CinematicCanceler)
        self.btn_left12:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.CinematicCanceler = btn_left:GetChecked()
        end)
        self.btn_left12.text:SetText("CinematicCanceler")
        -----------------------------------------------
        -- btn_left13 BossBanner
        -----------------------------------------------
        self.btn_left13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*13)
        self.btn_left13:SetChecked(Octo_ToDo_DragonflyVars.config.BossBanner)
        self.btn_left13:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.BossBanner = btn_left:GetChecked()
        end)
        self.btn_left13.text:SetText("BossBanner")
        -----------------------------------------------
        -- btn_left14 MajorFactionsRenownToast
        -----------------------------------------------
        self.btn_left14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_left14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*14)
        self.btn_left14:SetChecked(Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast)
        self.btn_left14:SetScript("OnClick", function(btn_left)
                Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast = btn_left:GetChecked()
        end)
        self.btn_left14.text:SetText("MajorFactionsRenownToast")
        -----------------------------------------------
        -----------------------------------------------
        -- btn_right1 AnotherAddons
        -----------------------------------------------
        self.btn_right1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_right1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*1)
        self.btn_right1:SetChecked(Octo_ToDo_DragonflyVars.config.AnotherAddons)
        self.btn_right1:SetScript("OnClick", function(btn_right)
                Octo_ToDo_DragonflyVars.config.AnotherAddons = btn_right:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_right1.text:SetText("|cffFF0000AnotherAddons|r\nBugGrabber, BugSack, AutoTurnIn, MountsJournal,\n WowheadQuickLink, Postal, HidingBar, TalentTreeTweaks, Simulationcraft,\n SpeedyAutoLoot, AdvancedInterfaceOptions, Pawn, Rarity")
        -----------------------------------------------
        -----------------------------------------------
        -- btn_right2 ClearChat
        -----------------------------------------------
        self.btn_right2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_right2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*2)
        self.btn_right2:SetChecked(Octo_ToDo_DragonflyVars.config.ClearChat)
        self.btn_right2:SetScript("OnClick", function(btn_right)
                Octo_ToDo_DragonflyVars.config.ClearChat = btn_right:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
                --StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_right2.text:SetText("|cffFF0000ClearChat|r")
        -----------------------------------------------
        -----------------------------------------------
        -- btn_right3 ShowOnlyCurrentRealm
        -----------------------------------------------
        self.btn_right3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_right3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*3)
        self.btn_right3:SetChecked(Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm)
        self.btn_right3:SetScript("OnClick", function(btn)
                Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm = btn:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_right3.text:SetText("|cffFF0000ShowOnlyCurrentRealm|r")
        -----------------------------------------------
        --LevelToShowTEXT
        local LevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        self.Slider_right4 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
        self.Slider_right4:SetWidth(140)
        self.Slider_right4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*4)
        self.Slider_right4:SetMinMaxValues(1,70)
        self.Slider_right4:SetValueStep(1)
        local step = 1
        self.Slider_right4:SetValue(Octo_ToDo_DragonflyVars.config.LevelToShow)
        self.Slider_right4:SetScript("OnValueChanged", function (self, value)
                value = math.floor(value * step + .5) / step
                Octo_ToDo_DragonflyVars.config.LevelToShow = value
                LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDo_DragonflyVars.config.LevelToShow)
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        LevelToShowTEXT:SetPoint("LEFT", self.Slider_right4, "RIGHT", indent, 0)
        LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDo_DragonflyVars.config.LevelToShow)
        self.Slider_right4:Show()
        -- btn_right5 AutoSellGrey
        -----------------------------------------------
        self.btn_right5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_right5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*5)
        self.btn_right5:SetChecked(Octo_ToDo_DragonflyVars.config.AutoSellGrey)
        self.btn_right5:SetScript("OnClick", function(btn)
                Octo_ToDo_DragonflyVars.config.AutoSellGrey = btn:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_right5.text:SetText("|cffFF0000AutoSellGrey|r")
        -- btn_right6 AutoRepair
        -----------------------------------------------
        self.btn_right6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
        self.btn_right6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*6)
        self.btn_right6:SetChecked(Octo_ToDo_DragonflyVars.config.AutoRepair)
        self.btn_right6:SetScript("OnClick", function(btn)
                Octo_ToDo_DragonflyVars.config.AutoRepair = btn:GetChecked()
                StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        end)
        self.btn_right6.text:SetText("|cffFF0000AutoRepair|r")
        -----------------------------------------------
        --Addon_curWidthTEXT
        -- local Addon_curWidthTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        -- self.Slider_right7 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
        -- self.Slider_right7:SetWidth(140)
        -- self.Slider_right7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*7)
        -- self.Slider_right7:SetMinMaxValues(70,140)
        -- self.Slider_right7:SetValueStep(1)
        -- local step = 1
        -- self.Slider_right7:SetValue(Octo_ToDo_DragonflyVars.config.Addon_curWidth)
        -- self.Slider_right7:SetScript("OnValueChanged", function (self, value)
        --         value = math.floor(value * step + .5) / step
        --         Octo_ToDo_DragonflyVars.config.Addon_curWidth = value
        --         Addon_curWidthTEXT:SetText("Addon_curWidth: "..Octo_ToDo_DragonflyVars.config.Addon_curWidth)
        --         StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
        -- end)
        -- Addon_curWidthTEXT:SetPoint("LEFT", self.Slider_right7, "RIGHT", indent, 0)
        -- Addon_curWidthTEXT:SetText("Addon_curWidth: "..Octo_ToDo_DragonflyVars.config.Addon_curWidth)
        -- self.Slider_right7:Show()
        --Addon_curWidth
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, GlobalAddonName)
category.ID = GlobalAddonName
Settings.RegisterAddOnCategory(category)
