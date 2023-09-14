local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
local isElvUI = IsAddOnLoaded("ElvUI")
local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local config = CreateFrame("FRAME", GlobalAddonName.."config"..E.Octo_Func.GenerateUniqueID())
-- config:RegisterEvent("VARIABLES_LOADED")
config:Hide()
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
	text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
local indent = 24
-- local function newSlider(slider_name, minRange, maxRange, stepSize, getValue, text)
-- local slider = CreateFrame("Slider", "OctoSlider"..slider_name, title, "OptionsSliderTemplate")
-- slider.minRange = minRange
-- slider.maxRange = maxRange
-- slider.stepSize = stepSize or 1
-- slider.getValue = getValue
-- slider.text = text
-- slider:SetWidth(140)
-- slider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 200, -indent*4)
-- slider:SetMinMaxValues(minRange, maxRange)
-- slider:SetValueStep(stepSize)
-- slider:SetObeyStepOnDrag(true)
-- slider.minText = _G[slider:GetName().."Low"]
-- slider.maxText = _G[slider:GetName().."High"]
-- slider.text = _G[slider:GetName().."Text"]
-- slider.minText:SetText(minRange)
-- slider.maxText:SetText(maxRange)
-- slider.text:SetText(text)
-- slider:SetScript("OnValueChanged", function (self, value)
-- value = math.floor(value * step + .5) / step
-- Octo_ToDoVars.config.LevelToShow = value
-- LevelToShowTEXT:SetText("LevelToShow: "..Octo_ToDoVars.config.LevelToShow)
-- end)
-- slider.tooltipText = text
-- return slider
-- end
local function newButton(pos, line)
	Button = CreateFrame("CheckButton", "CheckButton"..E.Octo_Func.GenerateUniqueID(), config.title, "InterfaceOptionsCheckButtonTemplate")
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
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		title:SetPoint("TOPLEFT", 4, 30)
		title:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		title:SetTextColor(.5, .5, .5, 1)
		-- AddonVersion
		-- local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		-- ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 0 , 0)
		-- ver:SetTextColor(.5, .5, .5, 1)
		-- ver:SetJustifyH("RIGHT")
		-- ver:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		local LEFTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		LEFTTEXT1:SetText(L["Functions"])
		LEFTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		local CENTERTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		CENTERTEXT1:SetText(L["Modules"])
		CENTERTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		local RIGHTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		RIGHTTEXT1:SetText(L["DisplaySettings"])
		RIGHTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*1-4)
		-----------------------------------------------
		-- TEXT LEFT
		-----------------------------------------------
		local RIGHTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		RIGHTTEXT1:SetText("DEV")
		RIGHTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*19-4)
		-----------------------------------------------
		-- btn_left2 AutoSellGrey
		-----------------------------------------------
		self.btn_left2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_left3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_left4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_left5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*5)
		self.btn_left5:SetChecked(Octo_ToDoVars.config.AutoOpen)
		self.btn_left5:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoOpen = btn:GetChecked()
		end)
		self.btn_left5.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoOpen"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left6 AutoGossip
		-----------------------------------------------
		self.btn_left6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*6)
		self.btn_left6:SetChecked(Octo_ToDoVars.config.AutoGossip)
		self.btn_left6:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoGossip = btn:GetChecked()
		end)
		self.btn_left6.text:SetText(WHITE_FONT_COLOR_CODE..L["AutoGossip"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left7 CinematicCanceler
		-----------------------------------------------
		self.btn_left7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*7)
		self.btn_left7:SetChecked(Octo_ToDoVars.config.CinematicCanceler)
		self.btn_left7:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.CinematicCanceler = btn:GetChecked()
		end)
		self.btn_left7.text:SetText(WHITE_FONT_COLOR_CODE..L["CinematicCanceler"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left8 ClearChat
		-----------------------------------------------
		self.btn_left8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*8)
		self.btn_left8:SetChecked(Octo_ToDoVars.config.ClearChat)
		self.btn_left8:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.ClearChat = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left8.text:SetText(WHITE_FONT_COLOR_CODE..L["ClearChat"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left9 TalkingHeadFrame
		-----------------------------------------------
		self.btn_left9 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left9:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*9)
		self.btn_left9:SetChecked(Octo_ToDoVars.config.TalkingHeadFrame)
		self.btn_left9:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TalkingHeadFrame = btn:GetChecked()
		end)
		self.btn_left9.text:SetText(WHITE_FONT_COLOR_CODE..L["TalkingHeadFrame"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left10 HideZoneText
		-----------------------------------------------
		self.btn_left10 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left10:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*10)
		self.btn_left10:SetChecked(Octo_ToDoVars.config.HideZoneText)
		self.btn_left10:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideZoneText = btn:GetChecked()
		end)
		self.btn_left10.text:SetText(WHITE_FONT_COLOR_CODE..L["HideZoneText"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left11 Covenant
		-----------------------------------------------
		self.btn_left11 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left11:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*11)
		self.btn_left11:SetChecked(Octo_ToDoVars.config.Covenant)
		self.btn_left11:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.Covenant = btn:GetChecked()
		end)
		self.btn_left11.text:SetText(WHITE_FONT_COLOR_CODE..L["HideCovenant"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left12 RaidBossEmoteFrame
		-----------------------------------------------
		self.btn_left12 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left12:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*12)
		self.btn_left12:SetChecked(Octo_ToDoVars.config.RaidBossEmoteFrame)
		self.btn_left12:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.RaidBossEmoteFrame = btn:GetChecked()
		end)
		self.btn_left12.text:SetText(WHITE_FONT_COLOR_CODE..L["RaidBossEmoteFrame"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left13 BossBanner
		-----------------------------------------------
		self.btn_left13 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left13:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*13)
		self.btn_left13:SetChecked(Octo_ToDoVars.config.BossBanner)
		self.btn_left13:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.BossBanner = btn:GetChecked()
		end)
		self.btn_left13.text:SetText(WHITE_FONT_COLOR_CODE..L["BossBanner"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left14 HideErrorMessages
		-----------------------------------------------
		self.btn_left14 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left14:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*14)
		self.btn_left14:SetChecked(Octo_ToDoVars.config.HideErrorMessages)
		self.btn_left14:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.HideErrorMessages = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_left14.text:SetText(WHITE_FONT_COLOR_CODE..L["HideErrorMessages"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_left15 UIErrorsFramePosition
		-----------------------------------------------
		self.btn_left15 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_left15:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -indent*15)
		self.btn_left15:SetChecked(Octo_ToDoVars.config.UIErrorsFramePosition)
		self.btn_left15:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UIErrorsFramePosition = btn:GetChecked()
		end)
		self.btn_left15.text:SetText(WHITE_FONT_COLOR_CODE..L["UIErrorsFramePosition"]..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-----------------------------------------------
		-- btn_center2 GlobalFadePersist
		-----------------------------------------------
		self.btn_center2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*2)
		self.btn_center2:SetChecked(Octo_ToDoVars.config.GlobalFadePersist)
		self.btn_center2:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.GlobalFadePersist = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if isElvUI then
			self.btn_center2.text:SetText(E.Octo_Func.func_Gradient("GlobalFadePersist", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (ElvUI ENABLED)|r")
		else
			self.btn_center2.text:SetText(E.Octo_Globals.LightGray_Color.."GlobalFadePersist".." (ElvUI DISABLED)|r")
		end
		-----------------------------------------------
		-- btn_center3 LootFrame
		-----------------------------------------------
		self.btn_center3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*3)
		self.btn_center3:SetChecked(Octo_ToDoVars.config.LootFrame)
		self.btn_center3:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.LootFrame = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		if isRCLootCouncil then
			self.btn_center3.text:SetText(E.Octo_Func.func_Gradient("LootFrame", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." (RCLootCouncil ENABLED)|r")
		else
			self.btn_center3.text:SetText(E.Octo_Globals.LightGray_Color.."LootFrame".." (RCLootCouncil DISABLED)|r")
		end
		-----------------------------------------------
		-- btn_center4 SellFrame
		-----------------------------------------------
		self.btn_center4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_center5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*5)
		self.btn_center5:SetChecked(Octo_ToDoVars.config.UsableItems)
		self.btn_center5:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.UsableItems = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center5.text:SetText(WHITE_FONT_COLOR_CODE.."UsableItems"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center6 AutoTurnQuests
		-----------------------------------------------
		self.btn_center6 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center6:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*6)
		self.btn_center6:SetChecked(Octo_ToDoVars.config.AutoTurnQuests)
		self.btn_center6:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.AutoTurnQuests = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center6.text:SetText(WHITE_FONT_COLOR_CODE.."AutoTurnQuests"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center7 TrivialQuests
		-----------------------------------------------
		self.btn_center7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center7:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*7)
		self.btn_center7:SetChecked(Octo_ToDoVars.config.TrivialQuests)
		self.btn_center7:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.TrivialQuests = btn:GetChecked()
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center7.text:SetText(WHITE_FONT_COLOR_CODE.."TrivialQuests"..FONT_COLOR_CODE_CLOSE)
		-----------------------------------------------
		-- btn_center8 RepeatableQuests
		-----------------------------------------------
		self.btn_center8 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_center8:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 250, -indent*8)
		self.btn_center8:SetChecked(Octo_ToDoVars.config.RepeatableQuests)
		self.btn_center8:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.RepeatableQuests = btn:GetChecked()
				--StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_center8.text:SetText(WHITE_FONT_COLOR_CODE.."RepeatableQuests"..FONT_COLOR_CODE_CLOSE)
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
		local btn_right2 = lsfdd:CreateButton(self, 140, 22)
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
		-- TEXT LEFT 3
		-----------------------------------------------
		local RIGHTTEXT1 = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		RIGHTTEXT1:SetText("wowhead prefix")
		RIGHTTEXT1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*3-6)
		-----------------------------------------------
		-- btn_right4 wowhead prefix
		-----------------------------------------------

		local btn_right4 = lsfdd:CreateButton(self, 140, 22)
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
		self.btn_right7 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		local LevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.Slider_right9 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
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
		local itemLevelToShowTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.Slider_right11 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
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
		local curWidthTEXT = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.Slider_right13 = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
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
		-----------------------------------------------
		-- btn_right20 StaticPopup1Button1
		-----------------------------------------------
		self.btn_right20 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_right21 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_right22 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_right23 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
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
		self.btn_right24 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		self.btn_right24:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 500, -indent*24)
		self.btn_right24:SetChecked(Octo_ToDoVars.config.SORTING)
		self.btn_right24:SetScript("OnClick", function(btn)
				Octo_ToDoVars.config.SORTING = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self.btn_right24.text:SetText(E.Octo_Func.func_Gradient("SORTING", E.Octo_Globals.LightGray_Color, E.Octo_Globals.LightGray_Color))
end)
-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)
