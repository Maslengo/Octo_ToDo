local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
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
if classFilename == "SHAMAN" then
	classcolor = "0070de"
end
----
local MAIN_Config = CreateFrame("ScrollFrame", GlobalAddonName.."MAIN_Config")
MAIN_Config:SetScript("OnEnter", function(self, ...)
		E.Octo_Timer.Legion_Invasion()
		E.Octo_Timer.BfA_Invasion()
		E.Octo_Timer.BfA_Assault()
		E.Octo_Timer.DF_ToDragonbaneKeep()
		E.Octo_Timer.DF_GrandHunts()
		E.Octo_Timer.DF_CommunityFeast()
		E.Octo_Timer.DF_PrimalStorms()
		E.Octo_Timer.DF_ResearchersUnderFire()
		E.Octo_Timer.DF_TimeRift()
		E.Octo_Timer.DF_Dreamsurges()
		E.Octo_Timer.SL_Maw_Assault()
		E.Octo_Timer.Daily_Reset()
		E.Octo_Timer.Treasure_Goblin()
		E.Octo_Timer.ElementalStorm()
		E.Octo_Timer.DF_Flower()
end)
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
local POS_LEFT = 1
local POS_RIGHT = MAIN_Config:GetSize()/4
local indent = 19
local height = 232 -- Высота
local width = 34 -- Ширина
local row = 30
MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
MAIN_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
MAIN_TITLE:SetTextColor(.5, .5, .5, 1)
local Rat_Table = {
	{id = 1, SoundFile = "Kurwa ratatui", time = 9,},
	{id = 2, SoundFile = "Ya Perdole", time = 7,},
	{id = 3, SoundFile = "Kurwa wut", time = 10,},
	{id = 4, SoundFile = "Kurwa raketa", time = 10,},
	{id = 5, SoundFile = "Chipi chipi - Bobr kurwa", time = 57,},
	{id = 6, SoundFile = "Mюсли - Kurwa Bober", time = 147,},
}
local function Create_Model(scroll, self, number, pos, model)
	local ModelFrame = self.model
	local count = 0
	ModelFrame = CreateFrame("PlayerModel", nil, scroll)
	ModelFrame:SetSize(POS_RIGHT, POS_RIGHT)
	ModelFrame:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
	ModelFrame:SetDisplayInfo(model)
	ModelFrame:SetRotation(.4)
	ModelFrame:PlayAnimKit(1371)
	local ModelFrame_Button = CreateFrame("Button", nil, ModelFrame)
	-- ModelFrame_Button:Hide()
	ModelFrame_Button:SetAllPoints(ModelFrame)
	ModelFrame_Button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	ModelFrame_Button:SetScript("OnClick", function(self)
			count = count + 1
			if count > #Rat_Table then
				count = 1
			end
			for i = 1, #Rat_Table do
				if count == Rat_Table[i].id then
					print (E.Octo_Func.func_Gradient("Now playing: ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..count.."/"..(#Rat_Table), classColorHexCurrent..Rat_Table[i].SoundFile.."|r "..E.Octo_Func.SecondsToClock(Rat_Table[i].time))
					PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\rat\\"..Rat_Table[count].SoundFile..".ogg", "Master")
				end
			end
	end)
end
local function Create_Slider(scroll, self, number, pos, config, text, color, minValue, maxValue, step, Octo_Callback_func)
	if not color then
		color = "|cffFFFFFF"
	end
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
		self[number..pos..config]:SetWidth(200)
		self[number..pos..config]:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
				Octo_ToDo_DB_Vars.config[config] = math.floor(value * 10 + 0.5)/10
				self[number..pos..config].RightText:SetText(E.Octo_Globals.Blue_Color..Octo_ToDo_DB_Vars.config[config].."|r")
				if Octo_Callback_func then
					Octo_Callback_func()
					-- for i, func in ipairs(E.Octo_Globals.modules) do
					--     if func == Octo_Callback_func then
					--         func()
					--     end
					-- end
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
	end
end
local editBoxBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = true, edgeSize = 1, tileSize = 5,
}
local function Create_EditBox(scroll, self, number, pos, config)
	if not color then
		color = "|cffFFFFFF"
	end
	-- for i=0, 0xffff do
	-- print (i)
	-- end
	if not self[number..pos] then
		self[number..pos] = CreateFrame("Button", nil, scroll, "SecureActionButtonTemplate, BackDropTemplate")
		self[number..pos]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
		self[number..pos]:SetSize(indent*6, 20)
		-- self[number..pos]:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
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
				Octo_ToDo_DB_Vars.config[config] = editBox:GetText() -- 000AD0FD (0AE9B27E RETAIL)
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
-- local function Create_Colored_Frames(anchor, self, number, text, color, height, width)
--     if color == nil then color = "|cffFFFFFF" end
--     if self[number] == nil then
--         local r, g, b = E.Octo_Func.func_hex2rgb(color)
--         self[number] = CreateFrame("Frame", nil, anchor, "BackdropTemplate")
--         frame = self[number]
--         if startHiding == true then frame:Hide() end
--         number = number - 1
--         local x = number % row*(width-1)
--         local y = -math.floor(number / row)*(height-1)
--         frame:SetPoint("TOPLEFT", anchor, "BOTTOMRIGHT", x, y)
--         frame:SetFrameStrata("HIGH")
--         frame:SetSize(width, height)
--         frame.BG = frame:CreateTexture()
--         frame.BG:SetTexture(texture_BG)
--         frame.BG:SetAllPoints(frame)
--         frame.BG:SetVertexColor(1, 1, 1, 1)
--         frame.FG = frame:CreateTexture()
--         frame.FG:SetTexture(texture_FG)
--         frame.FG:SetAllPoints(frame)
--         frame.FG:SetVertexColor(r/255, g/255, b/255, 1)
--     end
-- end
MAIN_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		Create_CheckButton(MAIN_scrollChild, self, 1, POS_LEFT, 0, "AutoSellGrey", L["AutoSellGrey"])
		Create_CheckButton(MAIN_scrollChild, self, 2, POS_LEFT, 0, "AutoRepair", L["AutoRepair"])
		Create_CheckButton(MAIN_scrollChild, self, 3, POS_LEFT, 0, "InputDelete", L["InputDelete"])
		Create_CheckButton(MAIN_scrollChild, self, 4, POS_LEFT, 0, "AutoOpen", L["AutoOpen"])
		Create_CheckButton(MAIN_scrollChild, self, 5, POS_LEFT, 0, "AutoGossip", L["AutoGossip"])
		Create_CheckButton(MAIN_scrollChild, self, 6, POS_LEFT, 0, "CinematicCanceler", L["CinematicCanceler"])
		Create_CheckButton(MAIN_scrollChild, self, 7, POS_LEFT, 0, "AutoTurnQuests", L["Auto Turn Quests"])
		Create_CheckButton(MAIN_scrollChild, self, 8, POS_LEFT, 0, "ClearChat", L["ClearChat"])
		Create_CheckButton(MAIN_scrollChild, self, 9, POS_LEFT, 0, "Auto_Screenshot", L["Auto_Screenshot"])
		Create_CheckButton(MAIN_scrollChild, self, 10, POS_LEFT, 0, "Hide_Boss_Banner", L["Hide: Boss Banner"])
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_LEFT, 0, "Hide_Covenant", L["Hide: Covenant"])
		Create_CheckButton(MAIN_scrollChild, self, 12, POS_LEFT, 0, "Hide_Error_Messages", L["Hide: Error Messages"])
		Create_CheckButton(MAIN_scrollChild, self, 13, POS_LEFT, 0, "Hide_Talking_Head_Frame", L["Hide: TalkingHeadFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 14, POS_LEFT, 0, "Hide_Zone_Text", L["Hide: Zone Text"])
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_LEFT, 0, "UIErrorsFramePosition", L["UIErrorsFramePosition"])
		number = 1
		btn_right1 = LibSFDropDown:CreateStretchButton(MAIN_scrollChild, 140, 22) -- CreateStretchButtonOriginal
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
		btn_right2 = LibSFDropDown:CreateStretchButton(MAIN_scrollChild, 140, 22) -- CreateStretchButtonOriginal
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

		-- Create_Slider(MAIN_scrollChild, self, 14.5, POS_RIGHT, "Addon_Height", "Количество строк /20px: ", E.Octo_Globals.Green_Color, 200, 1000, 1, function()
		-- 	print (Octo_ToDo_DB_Vars.config.Addon_Height, value)
		-- 		Octo_ToDo_DB_Vars.config.Addon_Height = value НАОБОРОТ
		-- end)


		Create_Slider(MAIN_scrollChild, self, 14.5, POS_RIGHT, "FrameScale", "Addon Scale: ", E.Octo_Globals.Green_Color, 0.5, 2.5, 0.1, function()
				Octo_ToDo_FIRST_Frame_Main_FramePIZDA:SetScale(Octo_ToDo_DB_Vars.config.FrameScale or 1)
		end)
		Create_Slider(MAIN_scrollChild, self, 16, POS_RIGHT, "GameMenuFrameScale", "GameMenuFrameScale: ", E.Octo_Globals.Green_Color, 0.5, 2.5, 0.1, function()
				GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or 1)
		end)

		Create_CheckButton(MAIN_scrollChild, self, 20, POS_RIGHT, 0, "PortalsButtons", E.Octo_Func.func_texturefromIcon(3610528, 20)..L["Portals"])
		Create_CheckButton(MAIN_scrollChild, self, 21, POS_RIGHT, indent, "PortalsButtonsOnlyCurrent", "Only current M+ Portals")
		Create_CheckButton(MAIN_scrollChild, self, 22, POS_RIGHT, 0, "ShowOnlyCurrentRealm", L["Only Current Realm"])
		Create_CheckButton(MAIN_scrollChild, self, 23, POS_RIGHT, 0, "Octo_debug_BUTTONS_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Доп кнопки", r, g, b, .2)
		Create_CheckButton(MAIN_scrollChild, self, 24, POS_RIGHT, 0, "ItemsUsable", "ItemsUsable".." "..L["InDev"])
		Create_CheckButton(MAIN_scrollChild, self, 25, POS_RIGHT, 0, "ItemsDelete", "ItemsDelete".." "..L["InDev"])
		Create_CheckButton(MAIN_scrollChild, self, 28, POS_RIGHT, 0, "ShowTotalMoney", "Всего денег")
		Create_CheckButton(MAIN_scrollChild, self, 29, POS_RIGHT, 0, "ShowTimeAll", "Общее время игры")
		Create_SimpleButton(MAIN_scrollChild, self, 31, POS_RIGHT, "ReloadUI", "ReloadUI")
end)
local category, layout = Settings.RegisterCanvasLayoutCategory(MAIN_Config, AddonTitle)
category.ID = AddonTitle
Settings.RegisterAddOnCategory(category)
----------------------------------------------------------------
----------------------------------------------------------------
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
TITLE_FIRST = FIRST_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_FIRST:SetPoint("TOPLEFT", 4, 30)
TITLE_FIRST:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_FIRST:SetTextColor(.5, .5, .5, 1)
FIRST_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		----------------------------------------------------------------
		----------------------------НАСТРОЙКИ---------------------------
		ConfigTable_DF_LEFT = {
			{
				text = QUESTS_LABEL,
				button = false,
			},
			{
				config = "AidingtheAccord",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(1603189)..L["Aiding the Accord"],
			},
			{
				config = "CommunityFeast",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(629056)..E.Octo_Timer.DF_CommunityFeast()..L["Community Feast"],
				r = 0, g = .65, b = 1,
			},
			{
				config = "CommunityFeast",
				text = E.Octo_Timer.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"]
			},
			{
				config = "CommunityFeast",
				text = E.Octo_Timer.DF_GrandHunts()..L["Grand Hunt"]
			},
			{
				config = "CommunityFeast",
				text = E.Octo_Timer.DF_PrimalStorms()..L["The Storm's Fury"]
			},
			{
				config = "CommunityFeast",
				text = E.Octo_Timer.ElementalStorm().. "Elemental Storm"
			},
			{
				config = "ResearchersUnderFire",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(236469)..E.Octo_Timer.DF_ResearchersUnderFire()..E.Octo_Func.func_questName(74906),
				r = .2, g = .58, b = .50,
			},
			{
				otstyp = indent,
				config = "ResearchersUnderFire_Weekly",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_questName(75665),
				r = .2, g = .58, b = .50,
			},
			{
				config = "EmeraldDream_Superbloom",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Timer.DF_Flower()..E.Octo_Func.func_questName(78319),
				r = 1, g = 0, b = .28,
			},
			{
				otstyp = indent,
				config = "EmeraldDreamBloomingDreamseeds",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78821),
				r = 1, g = 0, b = .28,
			},
			{
				otstyp = indent,
				config = "EmeraldDreamAWorthyAllyDreamWardens",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78444),
				r = 1, g = 0, b = .28,
			},
			{
				otstyp = indent,
				config = "EmeraldDreamDreamsUnified",
				text = E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78381),
				r = 1, g = 0, b = .28,
			},
			{
				otstyp = indent,
				config = "EmeraldDream_DreamWardens",
				text = E.Octo_Func.func_reputationName(2574)..E.Octo_Globals.Gray_Color.." ("..REPUTATION..")|r",
				r = 1, g = 0, b = .28,
			},
			{
				config = "TimeRift",
				text = E.Octo_Globals.Weekly..(E.Octo_Func.func_texturefromIcon(628677)..E.Octo_Timer.DF_TimeRift()..L["TimeRift"]),
				r = .64, g = .21, b = .93,
			},
			{
				otstyp = indent,
				config = "DilatedTimePod",
				text = E.Octo_Func.func_itemTexture(209856)..E.Octo_Func.func_itemName(209856),
				r = .64, g = .21, b = .93,
			},
			{
				otstyp = indent,
				config = "EncapsulatedDestiny",
				text = E.Octo_Func.func_itemTexture(207002)..E.Octo_Func.func_itemName(207002),
				r = .64, g = .21, b = .93,
			},
			{
				otstyp = indent,
				config = "ParacausalFlakes",
				text = E.Octo_Func.func_currencyicon(2594)..E.Octo_Func.func_currencyName(2594),
				r = .64, g = .21, b = .93,
			},
			{
				config = "Dreamsurges",
				text = E.Octo_Globals.Weekly..(E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Timer.DF_Dreamsurges()..L["Dreamsurges"]),
				r = .31, g = 1, b = .47,
			},
			{
				otstyp = indent,
				config = "DreamsurgeCocoon",
				text = E.Octo_Func.func_itemTexture(210254)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_itemName_NOCOLOR(210254).."|r",
				r = .31, g = 1, b = .47,
			},
			{
				otstyp = indent,
				config = "DreamsurgeCoalescence",
				text = E.Octo_Func.func_itemTexture(207026)..E.Octo_Globals.WOW_Common_Color..E.Octo_Func.func_itemName_NOCOLOR(207026),
				r = .31, g = 1, b = .47,
			},
			{
				button = false,
				text = CURRENCY,
			},
			{
				otstyp = indent,
				config = "CatalystCharges",
				text = E.Octo_Func.func_currencyicon(2912)..E.Octo_Func.func_currencyName(2912),
			},
			{
				otstyp = indent,
				config = "Flightstones",
				text = E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245),
			},
			{
				text = ITEMS,
				button = false,
			},
			{
				otstyp = indent,
				config = "AntiqueBronzeBullion",
				text = E.Octo_Func.func_itemTexture(213089)..E.Octo_Func.func_itemName(213089),
			},
			{
				otstyp = indent,
				config = "SparkofAwakening",
				text = E.Octo_Func.func_itemTexture(211516)..E.Octo_Func.func_itemName(211516),
			},
			{
				otstyp = indent,
				config = "SplinteredSparkofAwakening",
				text = E.Octo_Func.func_itemTexture(211515)..E.Octo_Func.func_itemName(211515),
			},
			{
				button = false,
				text = L["Crests"],
			},
			{
				otstyp = indent,
				config = "Crests_Mythic",
				text = E.Octo_Func.func_currencyicon(2812)..E.Octo_Globals.WOW_Legendary_Color..E.Octo_Func.func_currencyName_NOCOLOR(2812).."|r"
			},
			{
				otstyp = indent,
				config = "Crests_Heroic",
				text = E.Octo_Func.func_currencyicon(2809)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2809).."|r"
			},
			{
				otstyp = indent,
				config = "Crests_Normal",
				text = E.Octo_Func.func_currencyicon(2807)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2807).."|r"
			},
			{
				otstyp = indent,
				config = "Crests_LFR",
				text = E.Octo_Func.func_currencyicon(2806)..E.Octo_Globals.WOW_Uncommon_Color..E.Octo_Func.func_currencyName_NOCOLOR(2806).."|r"
			},
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
		ConfigTable_DF_RIGHT = {
			--- ОБЩИЙ
			{
				button = false,
				text = L["General"],
			},
			{
				config = "Event",
				text = EVENTS_LABEL,
				r = 1, g = .95, b = .44,
			},
			{
				config = "Holiday",
				text = CALENDAR_FILTER_HOLIDAYS,
				r = 1, g = .4, b = .1,
			},
			{
				config = "Dungeons",
				text = "КД инстов",
			},
			{
				config = "Currency",
				text = CURRENCY,
			},
			{
				config = "Reputations",
				text = REPUTATION,
			},
			{
				config = "Quests",
				text = QUESTS_LABEL,
			},
			{
				config = "Items",
				text = ITEMS,
			},
			{
				config = "Professions",
				text = TRADE_SKILLS,
			},
			{
				config = "Gold",
				text = BONUS_ROLL_REWARD_MONEY,
			},
			{
				config = "ItemLevel",
				text = STAT_AVERAGE_ITEM_LEVEL,
			},
			{
				config = "LastUpdate",
				text = L["Was online"],
			},
		}
		for i = 1, #ConfigTable_DF_RIGHT do
			if ConfigTable_DF_RIGHT[i].otstyp == nil then ConfigTable_DF_RIGHT[i].otstyp = 0 end
			if ConfigTable_DF_RIGHT[i].config == nil then ConfigTable_DF_RIGHT[i].config = 0 end
			if ConfigTable_DF_RIGHT[i].text == nil then ConfigTable_DF_RIGHT[i].text = "" end
			if ConfigTable_DF_RIGHT[i].r == nil then ConfigTable_DF_RIGHT[i].r = 0 end
			if ConfigTable_DF_RIGHT[i].g == nil then ConfigTable_DF_RIGHT[i].g = 0 end
			if ConfigTable_DF_RIGHT[i].b == nil then ConfigTable_DF_RIGHT[i].b = 0 end
			if ConfigTable_DF_RIGHT[i].a == nil then ConfigTable_DF_RIGHT[i].a = 0 end
			if ConfigTable_DF_RIGHT[i].button == nil then ConfigTable_DF_RIGHT[i].button = true end
			Create_CheckButton(FIRST_scrollChild, self, i, POS_RIGHT, ConfigTable_DF_RIGHT[i].otstyp, ConfigTable_DF_RIGHT[i].config, ConfigTable_DF_RIGHT[i].text, ConfigTable_DF_RIGHT[i].r, ConfigTable_DF_RIGHT[i].g, ConfigTable_DF_RIGHT[i].b, ConfigTable_DF_RIGHT[i].a, ConfigTable_DF_RIGHT[i].button)
		end
		----------------------------------------------------------------
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, E.Octo_Table.OctoTable_Expansions_Table[10].." (10)") --Dragonflight
subcategory.ID = L["InDev"].."FIRST_Config"
Settings.RegisterAddOnCategory(subcategory)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
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
TITLE_SECOND = SECOND_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_SECOND:SetPoint("TOPLEFT", 4, 30)
TITLE_SECOND:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_SECOND:SetTextColor(.5, .5, .5, 1)
SECOND_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		----------------------------------------------------------------
		----------------------------НАСТРОЙКИ---------------------------
		ConfigTable_TWW_LEFT = {
			{
				config = "MP_MythicKeystone",
				text = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r",
			},
			{
				text = QUESTS_LABEL,
				button = false,
			},
			{
				-- otstyp = indent,
				config = "BeledarCycle",
				text = L["Light/Dark Cycle"].." "..E.Octo_Timer.TWW_BeledarCycle(),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "World_Boss_S1",
				text = L["World Boss"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_DQ_S1",
				text = L["Weekly Dungeon Quest"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_Delve_S1",
				text = E.Octo_Func.func_questName(83366),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_Caches_S1",
				text = L["Weekly World Quest caches x2"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_Soul",
				text = E.Octo_Func.func_questName(82452),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_Crafting",
				text = L["Weekly Crafting Quests"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_Fishing",
				text = "Fishing", -- E.Octo_Func.func_questName(82778),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_zKahet",
				text = L["Weekly Azj-Kahet"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_zHallow",
				text = L["Weekly Hallowfall"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_Sniffer",
				text = E.Octo_Func.func_questName(82946),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_zRing",
				text = E.Octo_Func.func_questName(83333),
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Weekly_WQ_S1_zDorn",
				text = L["Weekly the Isle of Dorn"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "MajorKeyflames",
				text = E.Octo_Func.func_texturefromIcon(132863) .. L["Major Keyflames"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},
			{
				-- otstyp = indent,
				config = "MinorKeyflames",
				text = E.Octo_Func.func_texturefromIcon(135619) .. L["Minor Keyflames"],
				r = E.Octo_Globals.QW_Color_r, g = E.Octo_Globals.QW_Color_g, b = E.Octo_Globals.QW_Color_b,
			},

			{
				button = false,
				text = CURRENCY,
			},
			{
				-- otstyp = indent,
				config = "RestoredCofferKey",
				text = E.Octo_Func.func_currencyicon(3028)..E.Octo_Func.func_currencyName(3028),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "NerubarFinery",
				text = E.Octo_Func.func_currencyicon(3093)..E.Octo_Func.func_currencyName(3093),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},





			{
				-- otstyp = indent,
				config = "Undercoin",
				text = E.Octo_Func.func_currencyicon(2803)..E.Octo_Func.func_currencyName(2803),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Valorstones",
				text = E.Octo_Func.func_currencyicon(3008)..E.Octo_Func.func_currencyName(3008),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "MereldarDerbyMark",
				text = E.Octo_Func.func_currencyicon(3055)..E.Octo_Func.func_currencyName(3055),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "ResidualMemories",
				text = E.Octo_Func.func_currencyicon(3089)..E.Octo_Func.func_currencyName(3089),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "Kej",
				text = E.Octo_Func.func_currencyicon(3056)..E.Octo_Func.func_currencyName(3056),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},
			{
				-- otstyp = indent,
				config = "ResonanceCrystals",
				text = E.Octo_Func.func_currencyicon(2815)..E.Octo_Func.func_currencyName(2815),
				r = E.Octo_Globals.CURR_Color_r, g = E.Octo_Globals.CURR_Color_g, b = E.Octo_Globals.CURR_Color_b,
			},


			{
				button = false,
				text = L["Crests"],
			},
			{
				-- otstyp = indent,
				config = "GildedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2917)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2917).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				-- otstyp = indent,
				config = "RunedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2916)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2916).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				-- otstyp = indent,
				config = "CarvedHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2915)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2915).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},
			{
				-- otstyp = indent,
				config = "WeatheredHarbingerCrest",
				text = E.Octo_Func.func_currencyicon(2914)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2914).."|r",
				r = E.Octo_Globals.CREST_Color_r, g = E.Octo_Globals.CREST_Color_g, b = E.Octo_Globals.CREST_Color_b,
			},








			{
				text = ITEMS,
				button = false,
			},


			{
				config = "CofferKeyShard",
				text = E.Octo_Func.func_itemTexture(229899)..E.Octo_Func.func_itemName(229899),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "OddGlobofWax",
				text = E.Octo_Func.func_itemTexture(212493)..E.Octo_Func.func_itemName(212493),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "NascentWeatheredHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(220788)..E.Octo_Func.func_itemName(220788),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "EnchantedWeatheredHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(224069)..E.Octo_Func.func_itemName(224069),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "NascentRunedHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(220790)..E.Octo_Func.func_itemName(220790),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "EnchantedRunedHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(224072)..E.Octo_Func.func_itemName(224072),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "NascentGildedHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(220789)..E.Octo_Func.func_itemName(220789),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "EnchantedGildedHarbingerCrest",
				text = E.Octo_Func.func_itemTexture(224073)..E.Octo_Func.func_itemName(224073),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "SparkofOmens",
				text = E.Octo_Func.func_itemTexture(211296)..E.Octo_Func.func_itemName(211296),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "FracturedSparkofOmens",
				text = E.Octo_Func.func_itemTexture(211297)..E.Octo_Func.func_itemName(211297),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "RadiantRemnant",
				text = E.Octo_Func.func_itemTexture(206350)..E.Octo_Func.func_itemName(206350),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},
			{
				config = "RadiantEcho",
				text = E.Octo_Func.func_itemTexture(220520)..E.Octo_Func.func_itemName(220520),
				r = E.Octo_Globals.ITEM_Color_r, g = E.Octo_Globals.ITEM_Color_g, b = E.Octo_Globals.ITEM_Color_b,
			},







			{
				button = false,
				text = REPUTATION,
			},
			{
				-- otstyp = indent,
				config = "TheAssemblyoftheDeeps",
				text = E.Octo_Func.func_texturefromIcon(5891367)..E.Octo_Func.func_reputationName(2594),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "CouncilofDornogal",
				text = E.Octo_Func.func_texturefromIcon(5891369)..E.Octo_Func.func_reputationName(2590),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "HallowfallArathi",
				text = E.Octo_Func.func_texturefromIcon(5891368)..E.Octo_Func.func_reputationName(2570),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "TheSeveredThreads",
				text = E.Octo_Func.func_texturefromIcon(5891370)..E.Octo_Func.func_reputationName(2600),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "TheWeaver",
				text = E.Octo_Func.func_texturefromIcon(5862764)..E.Octo_Func.func_reputationName(2601),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "TheVizier",
				text = E.Octo_Func.func_texturefromIcon(5862763)..E.Octo_Func.func_reputationName(2607),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "TheGeneral",
				text = E.Octo_Func.func_texturefromIcon(5862762)..E.Octo_Func.func_reputationName(2605),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
			{
				-- otstyp = indent,
				config = "BrannBronzebeard",
				text = E.Octo_Func.func_texturefromIcon(5453546)..E.Octo_Func.func_reputationName(2640),
				r = E.Octo_Globals.REP_Color_r, g = E.Octo_Globals.REP_Color_g, b = E.Octo_Globals.REP_Color_b,
			},
		}
		for i = 1, #ConfigTable_TWW_LEFT do
			if ConfigTable_TWW_LEFT[i].otstyp == nil then ConfigTable_TWW_LEFT[i].otstyp = 0 end
			if ConfigTable_TWW_LEFT[i].config == nil then ConfigTable_TWW_LEFT[i].config = 0 end
			if ConfigTable_TWW_LEFT[i].text == nil then ConfigTable_TWW_LEFT[i].text = "" end
			if ConfigTable_TWW_LEFT[i].r == nil then ConfigTable_TWW_LEFT[i].r = 0 end
			if ConfigTable_TWW_LEFT[i].g == nil then ConfigTable_TWW_LEFT[i].g = 0 end
			if ConfigTable_TWW_LEFT[i].b == nil then ConfigTable_TWW_LEFT[i].b = 0 end
			if ConfigTable_TWW_LEFT[i].a == nil then ConfigTable_TWW_LEFT[i].a = 0 end
			if ConfigTable_TWW_LEFT[i].button == nil then ConfigTable_TWW_LEFT[i].button = true end
			Create_CheckButton(SECOND_scrollChild, self, i, POS_LEFT, ConfigTable_TWW_LEFT[i].otstyp, ConfigTable_TWW_LEFT[i].config, ConfigTable_TWW_LEFT[i].text, ConfigTable_TWW_LEFT[i].r, ConfigTable_TWW_LEFT[i].g, ConfigTable_TWW_LEFT[i].b, ConfigTable_TWW_LEFT[i].a, ConfigTable_TWW_LEFT[i].button)
		end
		ConfigTable_TWW_RIGHT = {
			--- ОБЩИЙ
			{
				button = false,
				text = L["General"],
			},
			{
				config = "Event",
				text = EVENTS_LABEL,
				r = 1, g = .95, b = .44,
			},
			{
				config = "Holiday",
				text = CALENDAR_FILTER_HOLIDAYS,
				r = 1, g = .4, b = .1,
			},
			{
				config = "Dungeons",
				text = "КД инстов",
			},
			{
				config = "Currency",
				text = CURRENCY,
			},
			{
				config = "Reputations",
				text = REPUTATION,
			},
			{
				config = "Quests",
				text = QUESTS_LABEL,
			},
			{
				config = "Items",
				text = ITEMS,
			},
			{
				config = "Professions",
				text = TRADE_SKILLS,
			},
			{
				config = "Gold",
				text = BONUS_ROLL_REWARD_MONEY,
			},
			{
				config = "ItemLevel",
				text = STAT_AVERAGE_ITEM_LEVEL,
			},
			{
				config = "LastUpdate",
				text = L["Was online"],
			},
		}
		for i = 1, #ConfigTable_TWW_RIGHT do
			if ConfigTable_TWW_RIGHT[i].otstyp == nil then ConfigTable_TWW_RIGHT[i].otstyp = 0 end
			if ConfigTable_TWW_RIGHT[i].config == nil then ConfigTable_TWW_RIGHT[i].config = 0 end
			if ConfigTable_TWW_RIGHT[i].text == nil then ConfigTable_TWW_RIGHT[i].text = "" end
			if ConfigTable_TWW_RIGHT[i].r == nil then ConfigTable_TWW_RIGHT[i].r = 0 end
			if ConfigTable_TWW_RIGHT[i].g == nil then ConfigTable_TWW_RIGHT[i].g = 0 end
			if ConfigTable_TWW_RIGHT[i].b == nil then ConfigTable_TWW_RIGHT[i].b = 0 end
			if ConfigTable_TWW_RIGHT[i].a == nil then ConfigTable_TWW_RIGHT[i].a = 0 end
			if ConfigTable_TWW_RIGHT[i].button == nil then ConfigTable_TWW_RIGHT[i].button = true end
			Create_CheckButton(SECOND_scrollChild, self, i, POS_RIGHT, ConfigTable_TWW_RIGHT[i].otstyp, ConfigTable_TWW_RIGHT[i].config, ConfigTable_TWW_RIGHT[i].text, ConfigTable_TWW_RIGHT[i].r, ConfigTable_TWW_RIGHT[i].g, ConfigTable_TWW_RIGHT[i].b, ConfigTable_TWW_RIGHT[i].a, ConfigTable_TWW_RIGHT[i].button)
		end
		----------------------------------------------------------------
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, SECOND_Config, E.Octo_Table.OctoTable_Expansions_Table[11].." (11)") --The War Within
subcategory.ID = L["InDev"].."SECOND_Config"
Settings.RegisterAddOnCategory(subcategory)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local Octo_DEV_Config = CreateFrame("ScrollFrame", GlobalAddonName.."Octo_DEV_Config")
Octo_DEV_Config:Hide()
local Octo_DEV_ScrollBar = CreateFrame("EventFrame", nil, Octo_DEV_Config, "MinimalScrollBar")
Octo_DEV_ScrollBar:SetPoint("TOPLEFT", Octo_DEV_Config, "TOPRIGHT", 6, 0)
Octo_DEV_ScrollBar:SetPoint("BOTTOMLEFT", Octo_DEV_Config, "BOTTOMRIGHT", 6, 0)
local Octo_DEV_scrollChild = CreateFrame("Frame", nil, Octo_DEV_Config)
Octo_DEV_Config:SetScrollChild(Octo_DEV_scrollChild)
Octo_DEV_Config:SetAllPoints()
Octo_DEV_scrollChild:SetSize(1, 1)
ScrollUtil.InitScrollFrameWithScrollBar(Octo_DEV_Config, Octo_DEV_ScrollBar)
local Octo_DEV_OnMouseWheel = Octo_DEV_Config:GetScript("OnMouseWheel")
Octo_DEV_Config:SetScript("OnMouseWheel", function(self, ...)
		if Octo_DEV_ScrollBar:IsShown() then
			Octo_DEV_OnMouseWheel(self, ...)
		end
end)
TITLE_Octo_DEV = Octo_DEV_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
TITLE_Octo_DEV:SetPoint("TOPLEFT", 4, 30)
TITLE_Octo_DEV:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_Octo_DEV:SetTextColor(.5, .5, .5, 1)
Octo_DEV_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		----------------------------------------------------------------
		----------------------------НАСТРОЙКИ---------------------------
		Create_CheckButton(Octo_DEV_scrollChild, self, 1, POS_RIGHT, 0, "StaticPopup1Button1", "StaticPopup1Button1")
		Create_CheckButton(Octo_DEV_scrollChild, self, 2, POS_RIGHT, 0, "CVar", "CVar")
		Create_CheckButton(Octo_DEV_scrollChild, self, 3, POS_RIGHT, 0, "Minecraft", "Minecraft")
		Create_CheckButton(Octo_DEV_scrollChild, self, 4, POS_RIGHT, 0, "Octo_debug_Function_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Function 1", 0, .65, 1, E.Octo_Globals.BGALPHA)
		Create_CheckButton(Octo_DEV_scrollChild, self, 5, POS_RIGHT, 0, "Octo_debug_Event_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Event 1", .31, 1, .47, E.Octo_Globals.BGALPHA)
		Create_CheckButton(Octo_DEV_scrollChild, self, 6, POS_RIGHT, 0, "Octo_debug_BUTTONS_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."BUTTONS 1", .69, .38, 1, E.Octo_Globals.BGALPHA)



		Create_SimpleButton(Octo_DEV_scrollChild, self, 22, POS_RIGHT, "ResetAllChars", "Reset All Chars")
		Create_SimpleButton(Octo_DEV_scrollChild, self, 26, POS_RIGHT, "ReloadUI", "Reload UI")
		for number, v in ipairs(E.Octo_Table.OctoTable_Colors) do
			Create_Frame_Color(Octo_DEV_scrollChild, self, number, POS_LEFT, v.name, v.hex)
		end
		----------------------------------------------------------------
end)
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, Octo_DEV_Config, E.Octo_Globals.DarkGray_Color.."Octo_DEV_Config".."|r") --Dragonflight
subcategory.ID = L["InDev"].."Octo_DEV_Config"
Settings.RegisterAddOnCategory(subcategory)


----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- local Octo_Minecraft_Config = CreateFrame("ScrollFrame", GlobalAddonName.."Octo_Minecraft_Config")
-- Octo_Minecraft_Config:Hide()
-- local Octo_Minecraft_ScrollBar = CreateFrame("EventFrame", nil, Octo_Minecraft_Config, "MinimalScrollBar")
-- Octo_Minecraft_ScrollBar:SetPoint("TOPLEFT", Octo_Minecraft_Config, "TOPRIGHT", 6, 0)
-- Octo_Minecraft_ScrollBar:SetPoint("BOTTOMLEFT", Octo_Minecraft_Config, "BOTTOMRIGHT", 6, 0)
-- local Octo_Minecraft_scrollChild = CreateFrame("Frame", nil, Octo_Minecraft_Config)
-- Octo_Minecraft_Config:SetScrollChild(Octo_Minecraft_scrollChild)
-- Octo_Minecraft_Config:SetAllPoints()
-- Octo_Minecraft_scrollChild:SetSize(1, 1)
-- ScrollUtil.InitScrollFrameWithScrollBar(Octo_Minecraft_Config, Octo_Minecraft_ScrollBar)
-- local Octo_Minecraft_OnMouseWheel = Octo_Minecraft_Config:GetScript("OnMouseWheel")
-- Octo_Minecraft_Config:SetScript("OnMouseWheel", function(self, ...)
--         if Octo_Minecraft_ScrollBar:IsShown() then
--             Octo_Minecraft_OnMouseWheel(self, ...)
--         end
-- end)
-- TITLE_Octo_Minecraft = Octo_Minecraft_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
-- TITLE_Octo_Minecraft:SetPoint("TOPLEFT", 4, 30)
-- TITLE_Octo_Minecraft:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
-- TITLE_Octo_Minecraft:SetTextColor(.5, .5, .5, 1)
-- Octo_Minecraft_Config:SetScript("OnShow", function(self)
--         self:SetScript("OnShow", nil)
--         ----------------------------------------------------------------
--         ----------------------------НАСТРОЙКИ---------------------------
--         for number, v in ipairs(E.Octo_Table.OctoTable_Colors) do
--             Create_Colored_Frames(Octo_Minecraft_scrollChild, self, number, v.name, v.hex, height, width)
--         end
--         ----------------------------------------------------------------
-- end)
-- local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, Octo_Minecraft_Config, E.Octo_Globals.Blue_Color.."Octo_Minecraft_Config".."|r") --Dragonflight
-- subcategory.ID = "Octo_Minecraft_Config"
-- Settings.RegisterAddOnCategory(subcategory)


