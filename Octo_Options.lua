local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibTranslit = LibStub("LibTranslit-1.0")
local CallbackHandler = LibStub("CallbackHandler-1.0")
local number, pizza, config, text, minValue, maxValue, steps, formatters
local new = E.Octo_Globals.Blue_Color.."NEW: |r"
StaticPopupDialogs[GlobalAddonName.."GET_RELOAD"] = {
	text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	whileDead = 1,
	OnAccept = function() ReloadUI() end,
}
local PlayerName = UnitName("PLAYER")
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = E.Octo_Func.GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local classColorHexCurrent = E.Octo_Func.func_rgb2hex(r, g, b)
local SliderWidth = 256
local ButtonWidth = 128
if classFilename == "SHAMAN" then
	classcolor = "0070de"
end
local MAIN_Config = CreateFrame("ScrollFrame", GlobalAddonName.."MAIN_Config")
MAIN_Config:SetScript("OnEnter", function(self, ...)
		E.Octo_Timer.TWW_BeledarCycle()
		E.Octo_Timer.Daily_Reset()
end)
MAIN_Config:Hide()
local MAIN_ScrollBar = CreateFrame("EventFrame", nil, MAIN_Config, "MinimalScrollBar")
MAIN_ScrollBar:HookScript("OnShow", function(self, ...)
		E.Octo_Timer.TWW_BeledarCycle()
		E.Octo_Timer.Daily_Reset()
		if not MAIN_ScrollBar.promise then
			MAIN_ScrollBar.promise = LibThingsLoad:Items(E.Octo_Table.OctoTable_Empty)
			MAIN_ScrollBar.promise:AddItems(E.Octo_Table.OctoTable_itemID_ALL)
			MAIN_ScrollBar.promise:AddItems(E.Octo_Table.OctoTable_itemID_Config)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_MoP)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_WoD)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Legion)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_BfA)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_SL)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DF)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DF_S3)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_TWW_S1_Horde)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_TWW_S1_Alliance)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Group_Horde)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DRUID)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DEATHKNIGHT)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_SHAMAN)
			MAIN_ScrollBar.promise:AddSpells(E.Octo_Table.OctoTable_Portals_MONK)
			MAIN_ScrollBar.promise:AddQuests(E.Octo_Table.OctoTable_QuestID)
			MAIN_ScrollBar.promise:AddQuests(E.Octo_Table.OctoTable_QuestID_Paragon)
		end
end)
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
local POS_LEFT = 1
local POS_RIGHT = MAIN_Config:GetSize()/3.5
local indent = 19
MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
MAIN_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
MAIN_TITLE:SetTextColor(.5, .5, .5, 1)
local function RefreshCheckboxes(self, TrueOrFalse)
	local i = 1
	local check = self[i.."1".."check"]
	while check do
		check:SetChecked(TrueOrFalse)
		i = i + 1
		check = self[i.."1".."check"]
	end
end
local function Create_Slider(scroll, self, number, pos, config, text, color, minValue, maxValue, step, Callback_func)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos..config] then
		steps = (maxValue-minValue)/(step or 1)
		self[number..pos..config] = CreateFrame("Slider", nil, scroll, "MinimalSliderWithSteppersTemplate")
		self[number..pos..config]:SetScale(E.Octo_Globals.slider_scale)
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos*E.Octo_Globals.multiplier+11, (-indent*(number-1)*E.Octo_Globals.multiplier)-E.Octo_Globals.multiplier*number)
		formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				if config == "Addon_Height" then
					return color..math.ceil(value/20).."|r"
				else
					return color..value.."|r"
				end
			end,
		}
		self[number..pos..config]:Init(Octo_ToDo_DB_Vars.config[config], minValue, maxValue, steps, formatters)
		self[number..pos..config]:SetWidth(SliderWidth)
		self[number..pos..config]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
				Octo_ToDo_DB_Vars.config[config] = math.floor(value * 10 + 0.5)/10
				self[number..pos..config].RightText:SetText(E.Octo_Globals.Blue_Color..Octo_ToDo_DB_Vars.config[config].."|r")
				if Callback_func then
					Callback_func()
				else
					StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				end
		end)
	end
end
local function Create_CheckButton(scroll, self, number, pos, otstyp, config, text, r, g, b, a, button)
	if r == nil then r = E.Octo_Globals.bgCr end
	if g == nil then g = E.Octo_Globals.bgCg end
	if b == nil then b = E.Octo_Globals.bgCb end
	if config == nil then config = 0 end
	if (a == nil or a == false or a == 0) then a = E.Octo_Globals.BGALPHA end
	-- if (a == nil or a == false or a == 0) then a = 0 end
	if button == nil then button = true end
	if not text then text = "no text" end
	if not self[number..pos..config] then
		self[number..pos] = CreateFrame("Frame", nil, scroll, "BackdropTemplate")
		local BG = self[number..pos]
		BG:SetBackdrop({
				bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1,
		})
		BG:SetBackdropColor(r, g, b, a)
		BG:SetBackdropBorderColor(0, 0, 0, 0)
		BG:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		BG:SetFrameStrata("BACKGROUND")
		BG:SetSize(POS_RIGHT-indent*4, indent)
		if button == true then
			local CheckButton = self[number..pos..config]
			CheckButton = CreateFrame("CheckButton", nil, scroll, "InterfaceOptionsCheckButtonTemplate")
			CheckButton:SetPoint("LEFT", BG, "LEFT", otstyp, 0)
			CheckButton:SetChecked(Octo_ToDo_DB_Vars.config[config])
			CheckButton:SetScript("OnClick", function(btn)
					print (text, tostring(btn:GetChecked()) == "true" and "|cff00FF00true|r" or "|cffFF0000false|r")
					Octo_ToDo_DB_Vars.config[config] = btn:GetChecked()
					StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
			end)
		end
		local text2 = BG:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		if button == true then
			text2:SetPoint("LEFT", BG, "LEFT", otstyp+indent+6, 0)
			text2:SetPoint("RIGHT", BG, "RIGHT")
		else
			text2:SetPoint("LEFT", BG, "LEFT", 6, 0)
			text2:SetPoint("RIGHT", BG, "RIGHT")
		end
		text2:SetPoint("RIGHT", BG, "RIGHT")
		text2:SetFontObject(OctoFont11)
		text2:SetJustifyV("MIDDLE")
		text2:SetJustifyH("LEFT")
		text2:SetWordWrap(false)
		text2:SetTextColor(1, 1, 1, 1)
		text2:SetText("|cffFFFFFF"..text..FONT_COLOR_CODE_CLOSE)
	end
end
local function Create_CheckButtonNEW(scroll, self, number, pos, otstyp, config, text, r, g, b, a, button, DATABASE)
	local TEST = ""

	-- Octo_ToDo_DB_Config.ItemDB
	if r == nil then r = E.Octo_Globals.bgCr end
	if g == nil then g = E.Octo_Globals.bgCg end
	if b == nil then b = E.Octo_Globals.bgCb end
	if config == nil then config = 0 end
	if (a == nil or a == false or a == 0) then a = E.Octo_Globals.BGALPHA end
	-- if (a == nil or a == false or a == 0) then a = 0 end
	if button == nil then button = true end
	if not text then text = "no text" end
	if not self[number..pos..tostring(config)] then
		self[number..pos] = CreateFrame("Frame", nil, scroll, "BackdropTemplate")
		local BG = self[number..pos]
		BG:SetBackdrop({
				bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1,
		})
		BG:SetBackdropColor(r, g, b, a)
		BG:SetBackdropBorderColor(0, 0, 0, 0)
		BG:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		BG:SetFrameStrata("BACKGROUND")
		BG:SetSize(POS_RIGHT-indent*4, indent)
		if button == true then
			local CheckButton = CreateFrame("CheckButton", nil, scroll, "InterfaceOptionsCheckButtonTemplate")
			self[number..pos.."check"] = CheckButton
			CheckButton:SetPoint("LEFT", BG, "LEFT", otstyp, 0)
			CheckButton:SetChecked(DATABASE[config])
			CheckButton:SetScript("OnClick", function(btn)
					DATABASE[config] = btn:GetChecked()
						if DATABASE == Octo_ToDo_DB_Config.ReputationDB then
							print (E.Octo_Func.func_reputationName(config), DATABASE[config] == true and "|cff00FF00true|r" or "|cffFF0000false|r")
						end
						if DATABASE == Octo_ToDo_DB_Config.ItemDB then
							print (E.Octo_Func.func_itemName(config), DATABASE[config] == true and "|cff00FF00true|r" or "|cffFF0000false|r")
						end
						if DATABASE == Octo_ToDo_DB_Config.CurrencyDB then
							print (E.Octo_Func.func_currencyicon(config)..E.Octo_Func.func_currencyName(config), DATABASE[config] == true and "|cff00FF00true|r" or "|cffFF0000false|r")
						end


			end)
		end
		local text2 = BG:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		if button == true then
			text2:SetPoint("LEFT", BG, "LEFT", otstyp+indent+6, 0)
			text2:SetPoint("RIGHT", BG, "RIGHT")
		else
			text2:SetPoint("LEFT", BG, "LEFT", 6, 0)
			text2:SetPoint("RIGHT", BG, "RIGHT")
		end
		text2:SetPoint("RIGHT", BG, "RIGHT")
		text2:SetFontObject(OctoFont11)
		text2:SetJustifyV("MIDDLE")
		text2:SetJustifyH("LEFT")
		text2:SetWordWrap(false)
		text2:SetTextColor(1, 1, 1, 1)
		text2:SetText("|cffFFFFFF"..text..FONT_COLOR_CODE_CLOSE)
	end
end
local function Create_FontString(scroll, self, number, pos, text, r, g, b, alignment)
	if text == nil then text = "no text" end
	if color == nil then color = "|cffFFFFFF" end
	if alignment == nil then alignment = "LEFT" end
	if r == nil then r = 1 end
	if g == nil then g = 1 end
	if b == nil then b = 1 end
	if not self[number..pos] then
		self[number..pos] = CreateFrame("Frame", nil, scroll, "BackdropTemplate")
		f = self[number..pos]
		f:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos+4, -indent*(number-1)-2)
		f:SetFrameStrata("BACKGROUND")
		f:SetSize(POS_RIGHT, indent)
		local text_str = self[number..pos]:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		text_str:SetAllPoints()
		text_str:SetFontObject(OctoFont11)
		text_str:SetJustifyV("MIDDLE")
		text_str:SetJustifyH(alignment)
		text_str:SetWordWrap(false)
		text_str:SetTextColor(r, g, b, 1)
		text_str:SetText(text)
	end
end
local function Create_SimpleButton(scroll, self, number, pos, config, text, color)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos..config] then
		self[number..pos..config] = CreateFrame("Button", nil, scroll, "UIPanelButtonTemplate")
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos..config]:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		self[number..pos..config]:SetSize(ButtonWidth, indent)
		self[number..pos..config]:SetText(color..text.."|r")
		self[number..pos..config]:SetScript("OnClick", function(btn)
				if config == "Octo_ToDo_DB_Config" then
					Octo_ToDo_DB_Config = {}
					ReloadUI()
				end
				if config == "Octo_ToDo_DB_Other" then
					Octo_ToDo_DB_Other = {}
					ReloadUI()
				end
				if config == "Octo_ToDo_DB_Players" then
					Octo_ToDo_DB_Players = {}
					ReloadUI()
				end
				if config == "Octo_ToDo_DB_Vars" then
					Octo_ToDo_DB_Vars = {}
					ReloadUI()
				end
				if config == "ReloadUI" then
					ReloadUI()
				end
		end)
	end
end

local function Create_SimpleButton_Movies(scroll, self, number, pos, config, text, color)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos..config] then
		self[number..pos..config] = CreateFrame("Button", nil, scroll, "UIPanelButtonTemplate")
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos..config]:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		self[number..pos..config]:SetSize(ButtonWidth*3, indent)
		self[number..pos..config]:SetText(color..text.."|r")
		-- self[number..pos..config].text:SetJustifyV("MIDDLE")
		-- self[number..pos..config].text:SetJustifyH("LEFT")
		self[number..pos..config]:SetScript("OnClick", function(btn)
			MovieFrame_PlayMovie(MovieFrame, config)
		end)
	end
end




local function Create_SimpleButton_DATABASE(scroll, self, number, pos, text, TrueOrFalse, DATABASE, Callback_func)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos] then
		self[number..pos] = CreateFrame("Button", nil, scroll, "UIPanelButtonTemplate")
		self[number..pos]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos]:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		self[number..pos]:SetSize(ButtonWidth, indent)
		self[number..pos]:SetText(color..text.."|r")
		self[number..pos]:SetScript("OnClick", function(btn)
				for ID, v in pairs(DATABASE) do
					DATABASE[ID] = TrueOrFalse
				end
				RefreshCheckboxes(self, TrueOrFalse)
		end)
	end
end
local editBoxBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = true, edgeSize = 1, tileSize = 5,
}
local function Create_EditBox(scroll, self, number, pos, config)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos] then
		self[number..pos] = CreateFrame("Button", nil, scroll, "SecureActionButtonTemplate, BackDropTemplate")
		self[number..pos]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos]:SetSize(indent*6, 20)
		self[number..pos]:SetBackdrop(editBoxBackdrop)
		self[number..pos]:SetBackdropBorderColor(0, 0, 0, 1)
		self[number..pos]:SetBackdropColor(0, 0, 0, 0.5)
		self[number..pos]:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
		local editBox = CreateFrame("EditBox", "EditBox"..number..pos, self[number..pos])
		editBox:SetAutoFocus(false)
		editBox:SetFontObject(OctoFont12)
		editBox:SetJustifyH("CENTER")
		editBox:EnableMouse(true)
		editBox:SetAllPoints(self[number..pos])
		editBox:SetMultiLine(false)
		editBox:SetText(Octo_ToDo_DB_Vars.config[config])
		editBox:SetJustifyV("MIDDLE")
		editBox:SetScript("OnEscapePressed", editBox.ClearFocus)
		editBox:SetScript("OnEnterPressed", editBox.ClearFocus)
		editBox:SetScript("OnTextChanged", function()
				Octo_ToDo_DB_Vars.config[config] = editBox:GetText()
		end)
	end
end
local function Create_Frame_Color(scroll, self, number, pos, text, color)
	if not color then color = "|cffFFFFFF" end
	if not self[number..pos] then
		local r, g, b = E.Octo_Func.func_hex2rgb(color)
		self[number..pos] = CreateFrame("Frame", nil, scroll, "BackdropTemplate")
		f = self[number..pos]
		f:SetBackdrop({
				bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1,
		})
		f:SetBackdropColor(r/255, g/255, b/255, 1)
		f:SetBackdropBorderColor(0, 0, 0, 0)
		f:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		f:SetFrameStrata("BACKGROUND")
		f:SetSize(POS_RIGHT-indent*4, indent)
		local text_str = self[number..pos]:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		text_str:SetAllPoints()
		text_str:SetFontObject(OctoFont11)
		text_str:SetJustifyV("MIDDLE")
		text_str:SetJustifyH("LEFT")
		text_str:SetWordWrap(false)
		text_str:SetTextColor(1, 1, 1, 1)
		local vivod = text:gsub("_Color", "")
		local vivod = vivod:gsub("Class_", "")
		local vivod2 = color:gsub("|cff", "")
		text_str:SetText(" "..vivod.." "..vivod2)
	end
end
MAIN_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		Create_CheckButton(MAIN_scrollChild, self, 1, POS_LEFT, 0, "AutoSellGrey", L["AutoSellGrey"])
		Create_CheckButton(MAIN_scrollChild, self, 2, POS_LEFT, 0, "AutoRepair", L["AutoRepair"])
		Create_CheckButton(MAIN_scrollChild, self, 3, POS_LEFT, 0, "InputDelete", L["InputDelete"])
		Create_CheckButton(MAIN_scrollChild, self, 4, POS_LEFT, 0, "AutoOpen", L["AutoOpen"])
		Create_CheckButton(MAIN_scrollChild, self, 5, POS_LEFT, 0, "Auto_Gossip", L["AutoGossip"])
		Create_CheckButton(MAIN_scrollChild, self, 6, POS_LEFT, 0, "Auto_CinematicCanceler", E.Octo_Globals.Green_Color..L["CinematicCanceler"].."|r")
		Create_CheckButton(MAIN_scrollChild, self, 7, POS_LEFT, 0, "Auto_CinematicFastSkip", E.Octo_Globals.Green_Color.."Fast Cinematic Skip (ESC/Space/Enter)".."|r")
		Create_CheckButton(MAIN_scrollChild, self, 8, POS_LEFT, 0, "AutoTurnQuests", L["Auto Turn Quests"])
		Create_CheckButton(MAIN_scrollChild, self, 9, POS_LEFT, 0, "Auto_ChatClearing", L["ClearChat"])
		Create_CheckButton(MAIN_scrollChild, self, 10, POS_LEFT, 0, "Auto_Screenshot", L["Auto_Screenshot"])
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_LEFT, 0, "Hide_Boss_Banner", L["Hide: Boss Banner"])
		Create_CheckButton(MAIN_scrollChild, self, 12, POS_LEFT, 0, "Hide_Covenant", L["Hide: Covenant"])
		Create_CheckButton(MAIN_scrollChild, self, 13, POS_LEFT, 0, "Hide_Error_Messages", L["Hide: Error Messages"])
		Create_CheckButton(MAIN_scrollChild, self, 14, POS_LEFT, 0, "Hide_Talking_Head_Frame", L["Hide: TalkingHeadFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_LEFT, 0, "Hide_Zone_Text", L["Hide: Zone Text"])
		Create_CheckButton(MAIN_scrollChild, self, 16, POS_LEFT, 0, "UIErrorsFramePosition", L["UIErrorsFramePosition"])
		number = 1
		btn_right2 = LibSFDropDown:CreateStretchButton(MAIN_scrollChild, 140, 22)
		btn_right2:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*(number-1))
		btn_right2:SetText(E.Octo_Table.wowhead_prefix_Table[Octo_ToDo_DB_Vars.config.prefix])
		btn_right2:ddSetDisplayMode(GlobalAddonName)
		local function selectFunctionprefix(menuButton)
			Octo_ToDo_DB_Vars.config.prefix = menuButton.value
			btn_right2:SetText(E.Octo_Table.wowhead_prefix_Table[Octo_ToDo_DB_Vars.config.prefix])
		end
		btn_right2:ddSetInitFunc(function(self, level, value)
				local info = {}
				info.fontObject = OctoFont10
				info.text = "Wowhead links"
				info.notCheckable = true
				self:ddAddButton(info, level)
				self:ddAddSeparator(level)
				if not value then
					for k, v in ipairs(E.Octo_Table.wowhead_prefix_Table) do
						info.isNotRadio = true
						info.notCheckable = false
						info.text = v
						info.value = k
						info.checked = Octo_ToDo_DB_Vars.config.prefix == k
						info.func = selectFunctionprefix
						self:ddAddButton(info, level)
					end
				end
		end)
		Create_Slider(MAIN_scrollChild, self, 4, POS_RIGHT, "LevelToShow", L["Player level"], E.Octo_Globals.Green_Color, 1, 70)
		Create_Slider(MAIN_scrollChild, self, 5.5, POS_RIGHT, "LevelToShowMAX", L["Player MAX level"], E.Octo_Globals.Green_Color, 1, 120)
		Create_Slider(MAIN_scrollChild, self, 7, POS_RIGHT, "itemLevelToShow", L["Item level: "], E.Octo_Globals.Green_Color, 0, 560)
		Create_Slider(MAIN_scrollChild, self, 8.5, POS_RIGHT, "curWidthCentral", L["Width: "], E.Octo_Globals.Green_Color, 60, 160)
		Create_Slider(MAIN_scrollChild, self, 10, POS_RIGHT, "curWidthTitle", L["curWidthTitle: "], E.Octo_Globals.Green_Color, 100, 400)
		Create_Slider(MAIN_scrollChild, self, 11.5, POS_RIGHT, "curHeight", "Высота строк: ", E.Octo_Globals.Green_Color, 10, 30)
		Create_Slider(MAIN_scrollChild, self, 13, POS_RIGHT, "Addon_Height", "Количество строк /20px: ", E.Octo_Globals.Green_Color, 200, 1000)
		Create_Slider(MAIN_scrollChild, self, 14.5, POS_RIGHT, "FrameScale", "Addon Scale: ", E.Octo_Globals.Green_Color, 0.5, 2.5, 0.1, function()
				if Octo_ToDo_FIRST_Frame_Main_FramePIZDA then
					Octo_ToDo_FIRST_Frame_Main_FramePIZDA:SetScale(Octo_ToDo_DB_Vars.config.FrameScale or 1)
				end
		end)
		Create_Slider(MAIN_scrollChild, self, 16, POS_RIGHT, "GameMenuFrameScale", "GameMenuFrameScale: ", E.Octo_Globals.Green_Color, 0.5, 2.5, 0.1, function()
				if GameMenuFrame then
					GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or 1)
				end
		end)
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_LEFT, 0, "PortalsButtons", E.Octo_Func.func_texturefromIcon(3610528, 20)..L["Portals"])
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_LEFT, 150, "PortalsButtonsOnlyCurrent", "Only current M+ Portals")
		Create_CheckButton(MAIN_scrollChild, self, 19, POS_LEFT, 0, "ShowOnlyCurrentRealm", L["Only Current Realm"])
		Create_CheckButton(MAIN_scrollChild, self, 20, POS_LEFT, 0, "ShowTotalMoney", "Всего денег")
		Create_CheckButton(MAIN_scrollChild, self, 21, POS_LEFT, 0, "ShowTimeAll", "Общее время игры")
		Create_CheckButton(MAIN_scrollChild, self, 21, POS_LEFT, 150, "ShowTimeMAXLEVEL", E.Octo_Globals.currentMaxLevel.." "..LEVEL)
		Create_CheckButton(MAIN_scrollChild, self, 22, POS_LEFT, 0, "Dungeons", "КД инстов")
		Create_CheckButton(MAIN_scrollChild, self, 23, POS_LEFT, 0, "Professions", TRADE_SKILLS)
		Create_CheckButton(MAIN_scrollChild, self, 24, POS_LEFT, 0, "Gold", BONUS_ROLL_REWARD_MONEY)
		Create_CheckButton(MAIN_scrollChild, self, 25, POS_LEFT, 0, "ItemLevel", STAT_AVERAGE_ITEM_LEVEL)
		Create_CheckButton(MAIN_scrollChild, self, 26, POS_LEFT, 0, "LastUpdate", L["Was online"])


		Create_CheckButton(MAIN_scrollChild, self, 24, POS_RIGHT, 0, "CVar", E.Octo_Func.func_texturefromIcon(E.Octo_Globals.AddonTexture_THIRD, indent).."CVar")
		Create_CheckButton(MAIN_scrollChild, self, 25, POS_RIGHT, 0, "Minecraft", E.Octo_Func.func_texturefromIcon(E.Octo_Globals.AddonTexture_SECOND, indent).."Minecraft")
		Create_CheckButton(MAIN_scrollChild, self, 26, POS_RIGHT, 0, "Octo_debug_Function_FIRST", E.Octo_Func.func_texturefromIcon(E.Octo_Globals.AddonTexture_FIRST, indent).."Debug")
		Create_SimpleButton(MAIN_scrollChild, self, 27, POS_RIGHT, "ReloadUI", E.Octo_Globals.White_Color.."Reload UI".."|r")
		Create_SimpleButton(MAIN_scrollChild, self, 28, POS_RIGHT, "Octo_ToDo_DB_Config", E.Octo_Globals.White_Color.."Config".."|r")
		Create_SimpleButton(MAIN_scrollChild, self, 29, POS_RIGHT, "Octo_ToDo_DB_Other", E.Octo_Globals.White_Color.."Other".."|r")
		Create_SimpleButton(MAIN_scrollChild, self, 30, POS_RIGHT, "Octo_ToDo_DB_Players", E.Octo_Globals.White_Color.."Players".."|r")
		Create_SimpleButton(MAIN_scrollChild, self, 31, POS_RIGHT, "Octo_ToDo_DB_Vars", E.Octo_Globals.White_Color.."Vars".."|r")
end)
local category, layout = Settings.RegisterCanvasLayoutCategory(MAIN_Config, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)
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
TITLE_FIRST = FIRST_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_FIRST:SetPoint("TOPLEFT", 4, 30)
TITLE_FIRST:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_FIRST:SetTextColor(.5, .5, .5, 1)
FIRST_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		ConfigTable_DF_LEFT = {
			{
				text = ITEMS,
				button = false,
			},
			{
				config = "MP_MythicKeystone",
				text = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r",
			},
			{
				text = QUESTS_LABEL,
				button = false,
			},
			{
				config = "BeledarCycle",
				text = L["Light/Dark Cycle"].." "..E.Octo_Timer.TWW_BeledarCycle(),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "TWW_WorldBoss_Weekly",
				text = L["World Boss"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "TWW_DungeonQuest_Weekly",
				text = L["Weekly Dungeon Quest"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "TWW_Delve_Weekly",
				text = "Bonus Event Holiday Quests",
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "MajorKeyflames",
				text = E.Octo_Func.func_texturefromIcon(132863) .. L["Major Keyflames"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "MinorKeyflames",
				text = E.Octo_Func.func_texturefromIcon(135619) .. L["Minor Keyflames"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				config = "Timewalk",
				text = PLAYER_DIFFICULTY_TIMEWALKER,
				r = 70/255, g = 130/255, b = 179/255,
			},


			{
				text = L["Crests"],
				button = false,
			},

			{
				config = "GildedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2917)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2917).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				config = "RunedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2916)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2916).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				config = "CarvedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2915)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2915).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				config = "WeatheredHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2914)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2914).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			-- {
			-- 	config = "WeatheredHarbingerCrest",
			-- 	text = E.Octo_Func.func_currencyicon(3023)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(3023).."|r",
			-- 	r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			-- },






		}
		for i = 1, #ConfigTable_DF_LEFT do
			if ConfigTable_DF_LEFT[i].otstyp == nil then ConfigTable_DF_LEFT[i].otstyp = 0 end
			if ConfigTable_DF_LEFT[i].config == nil then ConfigTable_DF_LEFT[i].config = 0 end
			if ConfigTable_DF_LEFT[i].text == nil then ConfigTable_DF_LEFT[i].text = "" end
			if ConfigTable_DF_LEFT[i].r == nil then ConfigTable_DF_LEFT[i].r = 0 end
			if ConfigTable_DF_LEFT[i].g == nil then ConfigTable_DF_LEFT[i].g = 0 end
			if ConfigTable_DF_LEFT[i].b == nil then ConfigTable_DF_LEFT[i].b = 0 end
			if ConfigTable_DF_LEFT[i].a == nil then ConfigTable_DF_LEFT[i].a = 0 end
			if ConfigTable_DF_LEFT[i].button == nil then ConfigTable_DF_LEFT[i].button = true end
			Create_CheckButton(FIRST_scrollChild, self, i, POS_LEFT, ConfigTable_DF_LEFT[i].otstyp, ConfigTable_DF_LEFT[i].config, ConfigTable_DF_LEFT[i].text, ConfigTable_DF_LEFT[i].r, ConfigTable_DF_LEFT[i].g, ConfigTable_DF_LEFT[i].b, ConfigTable_DF_LEFT[i].a, ConfigTable_DF_LEFT[i].button)
		end
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, OTHER) -- QUESTS_LABEL
subcategory.ID = L["InDev"].."FIRST_Config"
Settings.RegisterAddOnCategory(subcategory)

----
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
TITLE_SECOND = SECOND_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_SECOND:SetPoint("TOPLEFT", 4, 30)
TITLE_SECOND:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_SECOND:SetTextColor(.5, .5, .5, 1)
SECOND_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		ConfigTable_SECOND_LEFT = {
		}
		local list = {}
		for CurrencyID, v in pairs(Octo_ToDo_DB_Config.CurrencyDB) do
			tinsert(list, CurrencyID)
		end
		sort(list, E.Octo_Func.reverse_order)
		for k, CurrencyID in pairs(list) do
			tinsert(ConfigTable_SECOND_LEFT,
				{
					otstyp = 0,
					config = CurrencyID,
					text = E.Octo_Globals.LightGray_Color..tostringall(CurrencyID).."|r "..E.Octo_Func.func_currencyicon(CurrencyID)..E.Octo_Func.func_currencyName(CurrencyID),
				}
			)
		end
		for i = 1, #ConfigTable_SECOND_LEFT do
			if ConfigTable_SECOND_LEFT[i].otstyp == nil then ConfigTable_SECOND_LEFT[i].otstyp = 0 end
			if ConfigTable_SECOND_LEFT[i].config == nil then ConfigTable_SECOND_LEFT[i].config = 0 end
			if ConfigTable_SECOND_LEFT[i].text == nil then ConfigTable_SECOND_LEFT[i].text = "" end
			if ConfigTable_SECOND_LEFT[i].r == nil then ConfigTable_SECOND_LEFT[i].r = 0 end
			if ConfigTable_SECOND_LEFT[i].g == nil then ConfigTable_SECOND_LEFT[i].g = 0 end
			if ConfigTable_SECOND_LEFT[i].b == nil then ConfigTable_SECOND_LEFT[i].b = 0 end
			if ConfigTable_SECOND_LEFT[i].a == nil then ConfigTable_SECOND_LEFT[i].a = 0 end
			if ConfigTable_SECOND_LEFT[i].button == nil then ConfigTable_SECOND_LEFT[i].button = true end
			Create_CheckButtonNEW(SECOND_scrollChild, self, i, POS_LEFT, ConfigTable_SECOND_LEFT[i].otstyp, ConfigTable_SECOND_LEFT[i].config, ConfigTable_SECOND_LEFT[i].text, ConfigTable_SECOND_LEFT[i].r, ConfigTable_SECOND_LEFT[i].g, ConfigTable_SECOND_LEFT[i].b, ConfigTable_SECOND_LEFT[i].a, ConfigTable_SECOND_LEFT[i].button, Octo_ToDo_DB_Config.CurrencyDB)
		end
		Create_CheckButton(SECOND_scrollChild, self, 1, POS_RIGHT, 0, "Currency", CURRENCY)
		Create_CheckButtonNEW(SECOND_scrollChild, self, 1, POS_RIGHT+100, 0, "CurrencyShowAll", "CurrencyShowAll", r, g, b, a, true, Octo_ToDo_DB_Vars.config)
		Create_SimpleButton_DATABASE(SECOND_scrollChild, self, 3, POS_RIGHT, L["Turn on"], true, Octo_ToDo_DB_Config.CurrencyDB)
		Create_SimpleButton_DATABASE(SECOND_scrollChild, self, 4, POS_RIGHT, L["Turn off"], false, Octo_ToDo_DB_Config.CurrencyDB)
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, SECOND_Config, CURRENCY)
subcategory.ID = L["InDev"].."SECOND_Config"
Settings.RegisterAddOnCategory(subcategory)
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
TITLE_THIRD = THIRD_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_THIRD:SetPoint("TOPLEFT", 4, 30)
TITLE_THIRD:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_THIRD:SetTextColor(.5, .5, .5, 1)
THIRD_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		ConfigTable_THIRD_LEFT = {
		}
		-- isAccountWide = C_Reputation.IsAccountWideReputation(factionID)
		local list = {}
		for reputationID, v in pairs(Octo_ToDo_DB_Config.ReputationDB) do
			if C_Reputation.GetFactionDataByID(reputationID) then
				tinsert(list, reputationID)
			end
		end
		sort(list, E.Octo_Func.reverse_order)
		for k, reputationID in pairs(list) do
			tinsert(ConfigTable_THIRD_LEFT,
				{
					otstyp = 0,
					config = reputationID,
					text = E.Octo_Globals.LightGray_Color..tostringall(reputationID).."|r "..E.Octo_Func.func_reputationName(reputationID),
				}
			)
		end
		for i = 1, #ConfigTable_THIRD_LEFT do
			if ConfigTable_THIRD_LEFT[i].otstyp == nil then ConfigTable_THIRD_LEFT[i].otstyp = 0 end
			if ConfigTable_THIRD_LEFT[i].config == nil then ConfigTable_THIRD_LEFT[i].config = 0 end
			if ConfigTable_THIRD_LEFT[i].text == nil then ConfigTable_THIRD_LEFT[i].text = "" end
			if ConfigTable_THIRD_LEFT[i].r == nil then ConfigTable_THIRD_LEFT[i].r = 0 end
			if ConfigTable_THIRD_LEFT[i].g == nil then ConfigTable_THIRD_LEFT[i].g = 0 end
			if ConfigTable_THIRD_LEFT[i].b == nil then ConfigTable_THIRD_LEFT[i].b = 0 end
			if ConfigTable_THIRD_LEFT[i].a == nil then ConfigTable_THIRD_LEFT[i].a = 0 end
			if ConfigTable_THIRD_LEFT[i].button == nil then ConfigTable_THIRD_LEFT[i].button = true end
			Create_CheckButtonNEW(THIRD_scrollChild, self, i, POS_LEFT, ConfigTable_THIRD_LEFT[i].otstyp, ConfigTable_THIRD_LEFT[i].config, ConfigTable_THIRD_LEFT[i].text, ConfigTable_THIRD_LEFT[i].r, ConfigTable_THIRD_LEFT[i].g, ConfigTable_THIRD_LEFT[i].b, ConfigTable_THIRD_LEFT[i].a, ConfigTable_THIRD_LEFT[i].button, Octo_ToDo_DB_Config.ReputationDB)
		end
		Create_CheckButton(THIRD_scrollChild, self, 1, POS_RIGHT, 0, "Reputations", REPUTATION)
		-- Create_CheckButtonNEW(THIRD_scrollChild, self, 1, POS_RIGHT+100, 0, "ReputationsShowAll", "ReputationsShowAll", r, g, b, a, true, Octo_ToDo_DB_Vars.config)
		Create_SimpleButton_DATABASE(THIRD_scrollChild, self, 3, POS_RIGHT, L["Turn on"], true, Octo_ToDo_DB_Config.ReputationDB)
		Create_SimpleButton_DATABASE(THIRD_scrollChild, self, 4, POS_RIGHT, L["Turn off"], false, Octo_ToDo_DB_Config.ReputationDB)
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, THIRD_Config, REPUTATION)
subcategory.ID = L["InDev"].."THIRD_Config"
Settings.RegisterAddOnCategory(subcategory)
local FOURTH_Config = CreateFrame("ScrollFrame", GlobalAddonName.."FOURTH_Config")
FOURTH_Config:Hide()
local FOURTH_ScrollBar = CreateFrame("EventFrame", nil, FOURTH_Config, "MinimalScrollBar")
FOURTH_ScrollBar:SetPoint("TOPLEFT", FOURTH_Config, "TOPRIGHT", 6, 0)
FOURTH_ScrollBar:SetPoint("BOTTOMLEFT", FOURTH_Config, "BOTTOMRIGHT", 6, 0)
local FOURTH_scrollChild = CreateFrame("Frame", nil, FOURTH_Config)
FOURTH_Config:SetScrollChild(FOURTH_scrollChild)
FOURTH_Config:SetAllPoints()
FOURTH_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(FOURTH_Config, FOURTH_ScrollBar)
local FOURTH_OnMouseWheel = FOURTH_Config:GetScript("OnMouseWheel")
FOURTH_Config:SetScript("OnMouseWheel", function(self, ...)
		if FOURTH_ScrollBar:IsShown() then
			FOURTH_OnMouseWheel(self, ...)
		end
end)
TITLE_FOURTH = FOURTH_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_FOURTH:SetPoint("TOPLEFT", 4, 30)
TITLE_FOURTH:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_FOURTH:SetTextColor(.5, .5, .5, 1)
FOURTH_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		ConfigTable_FOURTH_LEFT = {
		}
		local list = {}
		for itemID, v in pairs(Octo_ToDo_DB_Config.ItemDB) do
			tinsert(list, itemID)
		end
		sort(list, E.Octo_Func.reverse_order)
		for _, id in pairs(E.Octo_Table.OctoTable_itemID_Config) do
			for k, itemID in pairs(list) do
				if id == itemID then
					tinsert(ConfigTable_FOURTH_LEFT,
						{
							otstyp = 0,
							config = itemID,
							text = E.Octo_Globals.LightGray_Color..tostringall(itemID).."|r "..E.Octo_Func.func_itemTexture(itemID)..E.Octo_Func.func_itemName(itemID),
						}
					)
				end
			end
		end
		for i = 1, #ConfigTable_FOURTH_LEFT do
			if ConfigTable_FOURTH_LEFT[i].otstyp == nil then ConfigTable_FOURTH_LEFT[i].otstyp = 0 end
			if ConfigTable_FOURTH_LEFT[i].config == nil then ConfigTable_FOURTH_LEFT[i].config = 0 end
			if ConfigTable_FOURTH_LEFT[i].text == nil then ConfigTable_FOURTH_LEFT[i].text = "" end
			if ConfigTable_FOURTH_LEFT[i].r == nil then ConfigTable_FOURTH_LEFT[i].r = 0 end
			if ConfigTable_FOURTH_LEFT[i].g == nil then ConfigTable_FOURTH_LEFT[i].g = 0 end
			if ConfigTable_FOURTH_LEFT[i].b == nil then ConfigTable_FOURTH_LEFT[i].b = 0 end
			if ConfigTable_FOURTH_LEFT[i].a == nil then ConfigTable_FOURTH_LEFT[i].a = 0 end
			if ConfigTable_FOURTH_LEFT[i].button == nil then ConfigTable_FOURTH_LEFT[i].button = true end
			Create_CheckButtonNEW(FOURTH_scrollChild, self, i, POS_LEFT, ConfigTable_FOURTH_LEFT[i].otstyp, ConfigTable_FOURTH_LEFT[i].config, ConfigTable_FOURTH_LEFT[i].text, ConfigTable_FOURTH_LEFT[i].r, ConfigTable_FOURTH_LEFT[i].g, ConfigTable_FOURTH_LEFT[i].b, ConfigTable_FOURTH_LEFT[i].a, ConfigTable_FOURTH_LEFT[i].button, Octo_ToDo_DB_Config.ItemDB)
		end
		Create_CheckButton(FOURTH_scrollChild, self, 1, POS_RIGHT, 0, "Items", ITEMS)
		Create_CheckButtonNEW(FOURTH_scrollChild, self, 1, POS_RIGHT+100, 0, "Itemsа", "ItemsShowAll", r, g, b, a, true, Octo_ToDo_DB_Vars.config)
		Create_SimpleButton_DATABASE(FOURTH_scrollChild, self, 3, POS_RIGHT, L["Turn on"], true, Octo_ToDo_DB_Config.ItemDB)
		Create_SimpleButton_DATABASE(FOURTH_scrollChild, self, 4, POS_RIGHT, L["Turn off"], false, Octo_ToDo_DB_Config.ItemDB)
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FOURTH_Config, ITEMS)
subcategory.ID = L["InDev"].."FOURTH_Config"
Settings.RegisterAddOnCategory(subcategory)


--------
-- local FIFTH_Config = CreateFrame("ScrollFrame", GlobalAddonName.."FIFTH_Config")
-- FIFTH_Config:Hide()
-- local FIFTH_ScrollBar = CreateFrame("EventFrame", nil, FIFTH_Config, "MinimalScrollBar")
-- FIFTH_ScrollBar:SetPoint("TOPLEFT", FIFTH_Config, "TOPRIGHT", 6, 0)
-- FIFTH_ScrollBar:SetPoint("BOTTOMLEFT", FIFTH_Config, "BOTTOMRIGHT", 6, 0)
-- local FIFTH_scrollChild = CreateFrame("Frame", nil, FIFTH_Config)
-- FIFTH_Config:SetScrollChild(FIFTH_scrollChild)
-- FIFTH_Config:SetAllPoints()
-- FIFTH_scrollChild:SetSize(1, 1)
-- ScrollUtil.InitScrollFrameWithScrollBar(FIFTH_Config, FIFTH_ScrollBar)
-- local FIFTH_OnMouseWheel = FIFTH_Config:GetScript("OnMouseWheel")
-- FIFTH_Config:SetScript("OnMouseWheel", function(self, ...)
-- 		if FIFTH_ScrollBar:IsShown() then
-- 			FIFTH_OnMouseWheel(self, ...)
-- 		end
-- end)
-- TITLE_FIFTH = FIFTH_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
-- TITLE_FIFTH:SetPoint("TOPLEFT", 4, 30)
-- TITLE_FIFTH:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
-- TITLE_FIFTH:SetTextColor(.5, .5, .5, 1)
-- FIFTH_Config:SetScript("OnShow", function(self)
-- 		self:SetScript("OnShow", nil)
-- 		ConfigTable_FIFTH_LEFT = {
-- 		}
-- 		for Expansion, tbl in pairs(E.Octo_Table.Movies) do
-- 			for number, v in pairs (tbl) do
-- 				-- print (Expansion, number, v.name, v.id)
-- 				for _, s in ipairs (E.Octo_Table.OctoTable_Expansions_Table2) do
-- 					if Expansion == s then
-- 						tinsert(ConfigTable_FIFTH_LEFT,
-- 										{
-- 											otstyp = 0,
-- 											config = v.id,
-- 											text = "|cffFF00FF"..Expansion.."|r "..v.name .. E.Octo_Globals.Green_Color.." ("..v.id..")|r",
-- 										}
-- 									)
-- 					end
-- 				end
-- 			end
-- 		end

-- 		for i = 1, #ConfigTable_FIFTH_LEFT do
-- 			if ConfigTable_FIFTH_LEFT[i].otstyp == nil then ConfigTable_FIFTH_LEFT[i].otstyp = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].config == nil then ConfigTable_FIFTH_LEFT[i].config = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].text == nil then ConfigTable_FIFTH_LEFT[i].text = "" end
-- 			if ConfigTable_FIFTH_LEFT[i].color == nil then ConfigTable_FIFTH_LEFT[i].color = "|cffFFFFFF" end
-- 			if ConfigTable_FIFTH_LEFT[i].r == nil then ConfigTable_FIFTH_LEFT[i].r = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].g == nil then ConfigTable_FIFTH_LEFT[i].g = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].b == nil then ConfigTable_FIFTH_LEFT[i].b = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].a == nil then ConfigTable_FIFTH_LEFT[i].a = 0 end
-- 			if ConfigTable_FIFTH_LEFT[i].button == nil then ConfigTable_FIFTH_LEFT[i].button = true end
-- 			Create_SimpleButton_Movies(FIFTH_scrollChild, self, i, POS_LEFT, ConfigTable_FIFTH_LEFT[i].config, ConfigTable_FIFTH_LEFT[i].text, ConfigTable_FIFTH_LEFT[i].color)
-- 		end
-- end)
-- local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIFTH_Config, E.Octo_Globals.Gray_Color..CINEMATICS.."|r")
-- subcategory.ID = L["InDev"].."FIFTH_Config"
-- Settings.RegisterAddOnCategory(subcategory)