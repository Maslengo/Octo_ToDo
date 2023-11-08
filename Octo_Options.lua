local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local lsfdd = LibStub("LibSFDropDown-1.4")
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
local fontObject9 = CreateFont("OctoFont9")
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
local indent = 26
local POS_LEFT = 6
local POS_RIGHT = 474
local POS_CENTER = POS_RIGHT/2
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
MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
MAIN_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
MAIN_TITLE:SetTextColor(.5, .5, .5, 1)
local function Create_Slider(scroll, self, number, pos, config, text, color, minValue, maxValue, Octo_Callback_func)
	if not color then
		color = "|cffFFFFFF"
	end
	if not self[number..pos..config] then
		-- slider_scale 0.8
		-- multiplier 2 - E.Octo_Globals.slider_scale
		steps = maxValue-minValue
		self[number..pos..config] = CreateFrame("Slider", nil, scroll, "MinimalSliderWithSteppersTemplate")
		self[number..pos..config]:SetScale(E.Octo_Globals.slider_scale)
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos*E.Octo_Globals.multiplier+11, (-indent*(number-1)*E.Octo_Globals.multiplier)-E.Octo_Globals.multiplier*number)
		formatters = {
			[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
				return text
			end,
			[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
				return color..value.."|r"
			end,
		}
		self[number..pos..config]:Init(Octo_ToDo_DB_Vars.config[config], minValue, maxValue, steps, formatters)
		self[number..pos..config]:SetWidth(200)
		self[number..pos..config]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
				Octo_ToDo_DB_Vars.config[config] = value
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				if Octo_Callback_func then
					for i, func in ipairs(E.Octo_Globals.modules) do
						if func == Octo_Callback_func then
							func()
						end
					end
				end
		end)
	end
end
local function Create_CheckButton(scroll, self, number, pos, config, text, color)
	if not color then
		color = "|cffFFFFFF"
	end
	if not self[number..pos..config] then
		self[number..pos..config] = CreateFrame("CheckButton", nil, scroll, "InterfaceOptionsCheckButtonTemplate")
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos..config]:SetChecked(Octo_ToDo_DB_Vars.config[config])
		self[number..pos..config]:SetScript("OnClick", function(btn)
				Octo_ToDo_DB_Vars.config[config] = btn:GetChecked()
				StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end)
		self[number..pos..config].text:SetJustifyV("MIDDLE")
		self[number..pos..config].text:SetJustifyH("LEFT")
		self[number..pos..config].text:SetText(color..text..FONT_COLOR_CODE_CLOSE)
	end
end

local function Create_SimpleButton(scroll, self, number, pos, config, text, color)
	if not color then
		color = "|cffFFFFFF"
	end
	if not self[number..pos..config] then
		self[number..pos..config] = CreateFrame("Button", nil, scroll, "UIPanelButtonTemplate")
		self[number..pos..config]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		-- self[number..pos..config]:SetChecked(Octo_ToDo_DB_Vars.config[config])
		self[number..pos..config]:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		self[number..pos..config]:SetSize(indent*6, indent)
		self[number..pos..config]:SetText(text)
		self[number..pos..config]:SetScript("OnClick", function(btn)
				-- Octo_ToDo_DB_Vars.config[config] = btn:GetChecked()
				if config == "ResetAllChars" then
					Octo_ToDo_DB_Levels = {}
				end
				if config == "ReloadUI" then
					ReloadUI()
				end
		end)
		-- self[number..pos..config].text:SetJustifyV("MIDDLE")
		-- self[number..pos..config].text:SetJustifyH("LEFT")
		-- self[number..pos..config].text:SetText(color..text..FONT_COLOR_CODE_CLOSE)
	end
end

local function Create_EditBox(scroll, self, number, pos, config)
	if not color then
		color = "|cffFFFFFF"
	end
	if not self[number..pos] then
		self[number..pos] = CreateFrame("Button", nil, scroll, "SecureActionButtonTemplate, BackDropTemplate")
		self[number..pos]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos]:SetSize(indent*6, 20)
		self[number..pos]:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		self[number..pos]:SetBackdropBorderColor(0, 0, 0, 1)

		local editBox = CreateFrame("EditBox", nil, self[number..pos])
		editBox:SetAllPoints(self[number..pos])
		editBox:SetFontObject(fontObject12)
		editBox:SetMultiLine(false)
		editBox:SetAutoFocus(false)

		editBox:SetText(Octo_ToDo_DB_Vars.config[config])
		editBox:SetJustifyV("MIDDLE")
		editBox:SetJustifyH("CENTER")

		editBox:SetScript("OnEscapePressed", editBox.ClearFocus)
		editBox:SetScript("OnEnterPressed", editBox.ClearFocus)

		-- editBox:SetScript("OnCursorChanged", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnEditFocusLost", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnEnter", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnLeave", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnMouseDown", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnReceiveDrag", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnTextSet", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)
		-- editBox:SetScript("OnEditFocusGained", function()
		-- 	if Octo_ToDo_DB_Vars.config[config] == "" then Octo_ToDo_DB_Vars.config[config] = E.Octo_Globals.NONE end
		-- end)




		editBox:SetScript("OnTextChanged", function()
			Octo_ToDo_DB_Vars.config[config] = editBox:GetText()  -- 000AD0FD (0AE9B27E RETAIL)
			-- print (Octo_ToDo_DB_Vars.config[config], editBox:GetText())
		end)
	end
end



local function Create_Frame_Color(scroll, self, number, pos, text, color)
	if not color then
		color = "|cffFFFFFF"
	end
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
		f:SetBackdropBorderColor(0, 0, 0, 1)
		f:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		f:SetFrameStrata("BACKGROUND")
		f:SetSize(200, 20)
		-- f.BG = f:CreateTexture()
		-- f.BG:SetAllPoints(f)
		-- f.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		-- f.BG:SetVertexColor(E.Octo_Func.func_hex2rgb(color))
		-- f.texture = f:CreateTexture()
		-- f.texture:SetAllPoints()
		-- f.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
		-- f.texture:SetColorTexture(r/255, g/255, b/255)
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
		Create_CheckButton(MAIN_scrollChild, self, 1, POS_LEFT, "AutoSellGrey", L["AutoSellGrey"])
		Create_CheckButton(MAIN_scrollChild, self, 2, POS_LEFT, "AutoRepair", L["AutoRepair"])
		Create_CheckButton(MAIN_scrollChild, self, 3, POS_LEFT, "InputDelete", L["InputDelete"])
		Create_CheckButton(MAIN_scrollChild, self, 4, POS_LEFT, "AutoOpen", L["AutoOpen"])
		Create_CheckButton(MAIN_scrollChild, self, 5, POS_LEFT, "AutoGossip", L["AutoGossip"])
		Create_CheckButton(MAIN_scrollChild, self, 6, POS_LEFT, "CinematicCanceler", L["CinematicCanceler"])
		Create_CheckButton(MAIN_scrollChild, self, 7, POS_LEFT, "AutoTurnQuests", L["Auto Turn Quests"])
		Create_CheckButton(MAIN_scrollChild, self, 8, POS_LEFT, "ClearChat", L["ClearChat"])
		Create_CheckButton(MAIN_scrollChild, self, 9, POS_LEFT, "TalkingHeadFrame", L["TalkingHeadFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 10, POS_LEFT, "HideZoneText", L["HideZoneText"])
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_LEFT, "Covenant", L["HideCovenant"])
		Create_CheckButton(MAIN_scrollChild, self, 12, POS_LEFT, "RaidBossEmoteFrame", L["RaidBossEmoteFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 13, POS_LEFT, "BossBanner", L["BossBanner"])
		Create_CheckButton(MAIN_scrollChild, self, 14, POS_LEFT, "HideErrorMessages", L["HideErrorMessages"])
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_LEFT, "UIErrorsFramePosition", L["UIErrorsFramePosition"])
		Create_CheckButton(MAIN_scrollChild, self, 16, POS_LEFT, "Auto_Screenshot", L["Auto_Screenshot"])
		Create_CheckButton(MAIN_scrollChild, self, 17, POS_LEFT, "ItemsUsable", "ItemsUsable")
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_LEFT, "ItemsDelete", "ItemsDelete")

		Create_CheckButton(MAIN_scrollChild, self, 1, POS_CENTER, "MythicKeystone", L["Mythic Keystone"], E.Octo_Globals.Purple_Color)
		Create_CheckButton(MAIN_scrollChild, self, 2, POS_CENTER, "AidingtheAccord", L["Aiding the Accord"])
		Create_CheckButton(MAIN_scrollChild, self, 3, POS_CENTER, "CommunityFeast", L["Community Feast"])
		Create_CheckButton(MAIN_scrollChild, self, 4, POS_CENTER, "ResearchersUnderFire", L["Researchers Under Fire"]..E.Octo_Globals.Gray_Color.." (10.1.0)|r")

		-- EmeraldDream_
		Create_CheckButton(MAIN_scrollChild, self, 5, POS_CENTER, "EmeraldDream_Superbloom", new..L["Superbloom"])
		Create_CheckButton(MAIN_scrollChild, self, 6, POS_CENTER, "EmeraldDream_DreamWardens", new..L["Dream Wardens"]..E.Octo_Globals.Gray_Color.." ("..REPUTATION..")|r")
		Create_CheckButton(MAIN_scrollChild, self, 7, POS_CENTER, "EmeraldDream_Dreamseeds", new..L["Dreamseeds"])
		Create_CheckButton(MAIN_scrollChild, self, 8, POS_CENTER, "EmeraldDream_Crests", new..L["Crests"]..E.Octo_Globals.Gray_Color.." ("..CURRENCY..")|r")
		Create_CheckButton(MAIN_scrollChild, self, 9, POS_CENTER, "EmeraldDream_Rares", new..L["Rares"]..", "..L["Treasures"])
		Create_CheckButton(MAIN_scrollChild, self, 10, POS_CENTER, "EmeraldDream_Storyline", new..L["Storyline"])
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_CENTER, "Flightstones", L["Flightstones"]..E.Octo_Globals.Gray_Color.." ("..CURRENCY..")|r")



		Create_CheckButton(MAIN_scrollChild, self, 12, POS_CENTER, "TimeRift", L["TimeRift"]..E.Octo_Globals.Gray_Color.." (10.1.5)|r", E.Octo_Globals.Purple_Color)
		Create_CheckButton(MAIN_scrollChild, self, 13, POS_CENTER, "Dreamsurges", L["Dreamsurges"]..E.Octo_Globals.Gray_Color.." (10.1.7)|r", E.Octo_Globals.Green_Color)
		Create_CheckButton(MAIN_scrollChild, self, 14, POS_CENTER, "Event", EVENTS_LABEL, E.Octo_Globals.Yellow_Color)
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_CENTER, "Holiday", CALENDAR_FILTER_HOLIDAYS, E.Octo_Globals.Orange_Color)
		Create_CheckButton(MAIN_scrollChild, self, 16, POS_CENTER, "Dungeons", DUNGEONS)
		Create_CheckButton(MAIN_scrollChild, self, 17, POS_CENTER, "Currency", CURRENCY)
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_CENTER, "Reputations", REPUTATION)
		Create_CheckButton(MAIN_scrollChild, self, 19, POS_CENTER, "Quests", QUESTS_LABEL)
		Create_CheckButton(MAIN_scrollChild, self, 20, POS_CENTER, "Items", ITEMS)
		Create_CheckButton(MAIN_scrollChild, self, 21, POS_CENTER, "Professions", TRADE_SKILLS)
		Create_CheckButton(MAIN_scrollChild, self, 22, POS_CENTER, "Gold", BONUS_ROLL_REWARD_MONEY) -- WORLD_QUEST_REWARD_FILTERS_GOLD
		Create_CheckButton(MAIN_scrollChild, self, 23, POS_CENTER, "ItemLevel", STAT_AVERAGE_ITEM_LEVEL)
		Create_CheckButton(MAIN_scrollChild, self, 24, POS_CENTER, "LastUpdate", "Last Update")

		number = 1
		btn_right1 = lsfdd:CreateStretchButtonOriginal(MAIN_scrollChild, 140, 22)
		btn_right1:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*(number-1))
		btn_right1:SetText(E.Octo_Table.OctoTable_Expansions_Table[Octo_ToDo_DB_Vars.config.ExpansionToShow])
		btn_right1:ddSetDisplayMode(GlobalAddonName)
		local function selectFunctionExpansion(menuButton)
			Octo_ToDo_DB_Vars.config.ExpansionToShow = menuButton.value
			btn_right1:SetText(E.Octo_Table.OctoTable_Expansions_Table[Octo_ToDo_DB_Vars.config.ExpansionToShow])
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		btn_right1:ddSetInitFunc(function(self, level, value)
				local info = {}
				info.fontObject = OctoFont10
				info.text = EXPANSION_FILTER_TEXT
				info.notCheckable = true
				self:ddAddButton(info, level)
				self:ddAddSeparator(level)
				if not value then
					for k, v in ipairs(E.Octo_Table.OctoTable_Expansions_Table) do
						info.isNotRadio = true
						info.notCheckable = false
						info.text = v
						info.value = k
						info.checked = Octo_ToDo_DB_Vars.config.ExpansionToShow == k
						info.func = selectFunctionExpansion
						self:ddAddButton(info, level)
					end
				end
		end)
		number = 2
		btn_right2 = lsfdd:CreateStretchButtonOriginal(MAIN_scrollChild, 140, 22)
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
		Create_Slider(MAIN_scrollChild, self, 3, POS_RIGHT, "LevelToShow", L["Player level"], E.Octo_Globals.Green_Color, 1, 70)
		Create_Slider(MAIN_scrollChild, self, 4, POS_RIGHT, "LevelToShowMAX", L["Player MAX level"], E.Octo_Globals.Green_Color, 1, 70)
		Create_Slider(MAIN_scrollChild, self, 5, POS_RIGHT, "itemLevelToShow", L["Item level: "], E.Octo_Globals.Green_Color, 1, 560)
		Create_Slider(MAIN_scrollChild, self, 6, POS_RIGHT, "curWidth", L["Width: "], E.Octo_Globals.Green_Color, 60, 160)
		Create_Slider(MAIN_scrollChild, self, 7, POS_RIGHT, "curWidthTitle", L["curWidthTitle: "], E.Octo_Globals.Green_Color, 100, 400)
		Create_Slider(MAIN_scrollChild, self, 8, POS_RIGHT, "curWidthTitleAchievement", "curWidthTitleAchievement", E.Octo_Globals.Green_Color, 100, 400)
		Create_Slider(MAIN_scrollChild, self, 9, POS_RIGHT, "curHeight", "Высота строк: ", E.Octo_Globals.Green_Color, 10, 30)
		Create_Slider(MAIN_scrollChild, self, 10, POS_RIGHT, "Addon_Height", "Количество строк: /20", E.Octo_Globals.Green_Color, 200, 1200)
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_RIGHT, "ShowOnlyCurrentRealm", L["Only Current Realm"])
		Create_CheckButton(MAIN_scrollChild, self, 12, POS_RIGHT, "Achievements", E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 20).." "..WHITE_FONT_COLOR_CODE..ACHIEVEMENTS..FONT_COLOR_CODE_CLOSE)
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_RIGHT, "ShowTotalMoney", "Всего денег")
		Create_CheckButton(MAIN_scrollChild, self, 16, POS_RIGHT, "ShowTimeAll", "Общее время игры")
		-- Create_EditBox(MAIN_scrollChild, self, 22, POS_RIGHT, "security")
		Create_SimpleButton(MAIN_scrollChild, self, 23, POS_RIGHT, "ReloadUI", "ReloadUI")







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
		Create_CheckButton(FIRST_scrollChild, self, 1, POS_CENTER, "StaticPopup1Button1", "StaticPopup1Button1")
		Create_CheckButton(FIRST_scrollChild, self, 2, POS_CENTER, "AnotherAddonsCasual", "AnotherAddonsCasual")
		Create_CheckButton(FIRST_scrollChild, self, 3, POS_CENTER, "AnotherAddonsRAID", "AnotherAddonsRAID")
		Create_CheckButton(FIRST_scrollChild, self, 4, POS_CENTER, "CVar", "CVar")
		Create_CheckButton(FIRST_scrollChild, self, 5, POS_CENTER, "SORTING", "SORTING")
		Create_CheckButton(FIRST_scrollChild, self, 6, POS_CENTER, "SellFrame", "SellFrame")
		Create_CheckButton(FIRST_scrollChild, self, 7, POS_CENTER, "GlobalFadePersist", "GlobalFadePersist")
		Create_CheckButton(FIRST_scrollChild, self, 8, POS_CENTER, "LootFrame", "LootFrame")
		Create_CheckButton(FIRST_scrollChild, self, 9, POS_CENTER, "PortalsNEW", E.Octo_Func.func_texturefromIcon(3610528, 20)..L["Portals"], E.Octo_Globals.Green_Color)
		Create_CheckButton(FIRST_scrollChild, self, 10, POS_CENTER, "THIRD", E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_THIRD.tga", 20).."THIRD")
		Create_CheckButton(FIRST_scrollChild, self, 11, POS_CENTER, "TalentTreeTweaks", "TalentTreeTweaks")
		Create_CheckButton(FIRST_scrollChild, self, 12, POS_CENTER, "Octo_debug_Function_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Function 1", E.Octo_Globals.Blue_Color)
		Create_CheckButton(FIRST_scrollChild, self, 13, POS_CENTER, "Octo_debug_Event_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Event 1", E.Octo_Globals.Green_Color)
		Create_CheckButton(FIRST_scrollChild, self, 14, POS_CENTER, "Octo_debug_BUTTONS_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."BUTTONS 1", E.Octo_Globals.Addon_Left_Color)
		Create_CheckButton(FIRST_scrollChild, self, 15, POS_CENTER, "Octo_debug_Function_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."Function 2", E.Octo_Globals.Blue_Color)
		Create_CheckButton(FIRST_scrollChild, self, 16, POS_CENTER, "Octo_debug_Event_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."Event 2", E.Octo_Globals.Green_Color)
		Create_CheckButton(FIRST_scrollChild, self, 17, POS_CENTER, "Octo_debug_BUTTONS_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."BUTTONS 2", E.Octo_Globals.Addon_Left_Color)
		Create_Slider(FIRST_scrollChild, self, 18, POS_CENTER, "glowType", "glowType", E.Octo_Globals.Green_Color, 1, 3)
		Create_Slider(FIRST_scrollChild, self, 19, POS_CENTER, "glowColor", "glowColor", E.Octo_Globals.Green_Color, 1, 3)
		Create_CheckButton(FIRST_scrollChild, self, 20, POS_CENTER, "Hide_ObjectivesInInstance", "Hide_ObjectivesInInstance")
		Create_CheckButton(FIRST_scrollChild, self, 21, POS_CENTER, "ChallengesKeystoneFrame", "ChallengesKeystoneFrame")


		Create_CheckButton(FIRST_scrollChild, self, 1, POS_RIGHT, "FieldOfView", "FieldOfView")
		Create_Slider(FIRST_scrollChild, self, 2, POS_RIGHT, "FoV_top", "FieldOfView: FoV_top", E.Octo_Globals.Green_Color, 0, 200, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 3, POS_RIGHT, "FoV_bottom", "FieldOfView: FoV_bottom", E.Octo_Globals.Green_Color, 0, 200, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 4, POS_RIGHT, "FoV_left", "FieldOfView: FoV_left", E.Octo_Globals.Green_Color, 0, 200, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 5, POS_RIGHT, "FoV_right", "FieldOfView: FoV_right", E.Octo_Globals.Green_Color, 0, 200, func_FieldOfView)
		Create_SimpleButton(FIRST_scrollChild, self, 23, POS_RIGHT, "ResetAllChars", "ResetAllChars")
		for k, v in ipairs(E.Octo_Table.OctoTable_Colors) do
			Create_Frame_Color(FIRST_scrollChild, self, k, POS_LEFT, v.name, v.hex)
		end
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, "FIRST_Config")
subcategory.ID = L["InDev"].."FIRST_Config"
Settings.RegisterAddOnCategory(subcategory)
-- FIRST_Config.MEME = FIRST_Config:CreateTexture(nil, "BACKGROUND")
-- FIRST_Config.MEME:SetAllPoints()
-- FIRST_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/1.tga")
-- FIRST_Config.MEME:SetAlpha(.5)
