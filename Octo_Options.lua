local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = GetAddOnMetadata(GlobalAddonName, "Version")
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
-- local fontObject9 = CreateFont("OctoFont9")
-- fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
-- local fontObject10 = CreateFont("OctoFont10")
-- fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
-- local fontObject11 = CreateFont("OctoFont11")
-- fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
-- local fontObject12 = CreateFont("OctoFont12")
-- fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
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
local POS_LEFT = MAIN_Config:GetSize()/MAIN_Config:GetSize()
local POS_RIGHT = MAIN_Config:GetSize()/3
local POS_CENTER = POS_RIGHT/2
local indent = 19
MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
MAIN_TITLE:SetText(GetAddOnMetadata(GlobalAddonName, "Version"))
MAIN_TITLE:SetTextColor(.5, .5, .5, 1)

-- do
-- 	local mountID = 804
-- 	local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountID)
-- 	print (name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID)
-- 	local creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(mountID)
-- 	print (creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview)
-- end

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
		ModelFrame:SetSize(POS_CENTER, POS_CENTER)
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
			-- local RandomNumber = math.random(#Rat_Table)
			-- for i = 1, #Rat_Table do
			-- 	local XYI = Rat_Table[i].id
			-- 	if XYI == RandomNumber then
			-- 		print (RandomNumber.."/"..(#Rat_Table),Rat_Table[i].SoundFile)
			-- 		PlaySoundFile(Rat_Table[i].SoundFile, "Master")
			-- 	end
			-- end
		end)

		-- local BG = CreateFrame("Frame", nil, scroll, "BackdropTemplate")
		-- BG:SetBackdrop({
		-- 		bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- 		edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- 		edgeSize = 1,
		-- })
		-- BG:SetBackdropColor(r, g, b, a)
		-- BG:SetBackdropBorderColor(0, 0, 0, 0)
		-- BG:SetAllPoints(ModelFrame)
		-- BG:SetFrameStrata("BACKGROUND")
		-- BG:SetSize(POS_CENTER-1, indent)
end
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
		BG:SetSize(POS_CENTER-1, indent)
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
		-- f:SetBackdrop({
		-- bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- edgeSize = 1,
		-- })
		-- f:SetBackdropColor(r/255, g/255, b/255, 0)
		-- f:SetBackdropBorderColor(0, 0, 0, 1)
		f:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos+4, -indent*(number-1)-2)
		f:SetFrameStrata("BACKGROUND")
		f:SetSize(POS_CENTER, indent)
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
		-- self[number..pos..config].text:SetJustifyV("MIDDLE")
		-- self[number..pos..config].text:SetJustifyH("LEFT")
		-- self[number..pos..config].text:SetText(color..text..FONT_COLOR_CODE_CLOSE)
	end
end
-- local function Create_EditBox(scroll, self, number, pos, config)
-- if not color then
-- color = "|cffFFFFFF"
-- end
-- if not self[number..pos] then
-- self[number..pos] = CreateFrame("Button", nil, scroll, "SecureActionButtonTemplate, BackDropTemplate")
-- self[number..pos]:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", pos, -indent*(number-1))
-- self[number..pos]:SetSize(indent*6, 20)
-- self[number..pos]:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
-- self[number..pos]:SetBackdropBorderColor(0, 0, 0, 1)
-- local editBox = CreateFrame("EditBox", nil, self[number..pos])
-- editBox:SetAllPoints(self[number..pos])
-- editBox:SetFontObject(OctoFont12)
-- editBox:SetMultiLine(false)
-- editBox:SetAutoFocus(false)
-- editBox:SetText(Octo_ToDo_DB_Vars.config[config])
-- editBox:SetJustifyV("MIDDLE")
-- editBox:SetJustifyH("CENTER")
-- editBox:SetScript("OnEscapePressed", editBox.ClearFocus)
-- editBox:SetScript("OnEnterPressed", editBox.ClearFocus)
-- editBox:SetScript("OnTextChanged", function()
-- Octo_ToDo_DB_Vars.config[config] = editBox:GetText() -- 000AD0FD (0AE9B27E RETAIL)
-- end)
-- end
-- end
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
		f:SetSize(POS_CENTER, indent)
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
		ConfigTable = {
			{
				config = "MP_MythicKeystone",
				text = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r",
			},
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
			-- {
			-- 	config = "CommunityFeast",
			-- 	text = E.Octo_Timer.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"]
			-- },
			-- {
			-- 	config = "CommunityFeast",
			-- 	text = E.Octo_Timer.DF_GrandHunts()..L["Grand Hunt"]
			-- },
			-- {
			-- 	config = "CommunityFeast",
			-- 	text = E.Octo_Timer.DF_PrimalStorms()..L["The Storm's Fury"]
			-- },
			-- {
			-- 	config = "CommunityFeast",
			-- 	text = E.Octo_Timer.ElementalStorm().. "Elemental Storm"
			-- },
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
			{
				button = false,
				text = L["Other"],
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
	for i = 1, #ConfigTable do
		if ConfigTable[i].pos == nil then ConfigTable[i].pos = 0 end
		if ConfigTable[i].otstyp == nil then ConfigTable[i].otstyp = 0 end
		if ConfigTable[i].config == nil then ConfigTable[i].config = 0 end
		if ConfigTable[i].text == nil then ConfigTable[i].text = "" end
		if ConfigTable[i].r == nil then ConfigTable[i].r = 0 end
		if ConfigTable[i].g == nil then ConfigTable[i].g = 0 end
		if ConfigTable[i].b == nil then ConfigTable[i].b = 0 end
		if ConfigTable[i].a == nil then ConfigTable[i].a = 0 end
		if ConfigTable[i].button == nil then ConfigTable[i].button = true end
		Create_CheckButton(MAIN_scrollChild, self, i, ConfigTable[i].pos, ConfigTable[i].otstyp, ConfigTable[i].config, ConfigTable[i].text, ConfigTable[i].r, ConfigTable[i].g, ConfigTable[i].b, ConfigTable[i].a, ConfigTable[i].button)
	end
-- (scroll, self, number, pos, config, text, r, g, b, a)
		-- Create_FontString(MAIN_scrollChild, self, 1, POS_LEFT, ITEMS, "LEFT")
		-- Create_CheckButton(MAIN_scrollChild, self, 2, POS_LEFT+(indent), "MP_MythicKeystone", E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r")
		-- Create_CheckButton(MAIN_scrollChild, self, 3, POS_LEFT+(indent), "AntiqueBronzeBullion", E.Octo_Func.func_texturefromIcon(213089)..E.Octo_Func.func_itemName(213089))
		-- Create_CheckButton(MAIN_scrollChild, self, 4, POS_LEFT, "AidingtheAccord", E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(1603189)..L["Aiding the Accord"])
		-- Create_CheckButton(MAIN_scrollChild, self, 5, POS_LEFT, "CommunityFeast", E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(629056)..E.Octo_Timer.DF_CommunityFeast()..L["Community Feast"])
		-- -- Create_CheckButton(MAIN_scrollChild, self, 5, POS_LEFT, "CommunityFeast", E.Octo_Timer.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"]) -- CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count
		-- -- Create_CheckButton(MAIN_scrollChild, self, 6, POS_LEFT, "CommunityFeast", E.Octo_Timer.DF_GrandHunts()..L["Grand Hunt"]) -- CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count
		-- -- Create_CheckButton(MAIN_scrollChild, self, 7, POS_LEFT, "CommunityFeast", E.Octo_Timer.DF_PrimalStorms()..L["The Storm's Fury"]) -- CharInfo.Octopussy_DF_Weekly_StormsFury_count
		-- -- Create_CheckButton(MAIN_scrollChild, self, 8, POS_LEFT, "CommunityFeast", E.Octo_Timer.ElementalStorm().. "Elemental Storm")
		-- Create_CheckButton(MAIN_scrollChild, self, 6, POS_LEFT, "ResearchersUnderFire", E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(236469)..E.Octo_Timer.DF_ResearchersUnderFire()..E.Octo_Func.func_questName(74906))
		-- Create_CheckButton(MAIN_scrollChild, self, 7, POS_LEFT+(indent), "ResearchersUnderFire_Weekly", E.Octo_Globals.Weekly..E.Octo_Func.func_questName(75665))
		-- Create_CheckButton(MAIN_scrollChild, self, 8, POS_LEFT, "EmeraldDream_Superbloom", E.Octo_Globals.Weekly..E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Timer.DF_Flower()..E.Octo_Func.func_questName(78319), r = 1, g = .93, b = .43)
		-- Create_CheckButton(MAIN_scrollChild, self, 9, POS_LEFT+(indent), "EmeraldDreamBloomingDreamseeds", E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78821), r = 1, g = .93, b = .43)
		-- Create_CheckButton(MAIN_scrollChild, self, 10, POS_LEFT+(indent), "EmeraldDreamAWorthyAllyDreamWardens", E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78444), r = 1, g = .93, b = .43)
		-- Create_CheckButton(MAIN_scrollChild, self, 11, POS_LEFT+(indent), "EmeraldDreamDreamsUnified", E.Octo_Globals.Weekly..E.Octo_Func.func_questName(78381), r = 1, g = .93, b = .43)
		-- Create_CheckButton(MAIN_scrollChild, self, 12, POS_LEFT+(indent), "EmeraldDream_DreamWardens", E.Octo_Func.func_reputationName(2574)..E.Octo_Globals.Gray_Color.." ("..REPUTATION..")|r", r = 1, g = .93, b = .43)
		-- Create_CheckButton(MAIN_scrollChild, self, 13, POS_LEFT, "TimeRift", E.Octo_Globals.Weekly..(E.Octo_Func.func_texturefromIcon(628677)..E.Octo_Timer.DF_TimeRift()..L["TimeRift"]), r = .64, g = .21, b = .93)
		-- Create_CheckButton(MAIN_scrollChild, self, 14, POS_LEFT+(indent), "DilatedTimePod", E.Octo_Func.func_itemTexture(209856)..E.Octo_Func.func_itemName(209856), r = .64, g = .21, b = .93)
		-- Create_CheckButton(MAIN_scrollChild, self, 15, POS_LEFT+(indent), "EncapsulatedDestiny", E.Octo_Func.func_itemTexture(207002)..E.Octo_Func.func_itemName(207002), r = .64, g = .21, b = .93)
		-- Create_CheckButton(MAIN_scrollChild, self, 16, POS_LEFT+(indent), "ParacausalFlakes", E.Octo_Func.func_currencyicon(2594)..E.Octo_Func.func_currencyName(2594), r = .64, g = .21, b = .93)
		-- Create_CheckButton(MAIN_scrollChild, self, 17, POS_LEFT, "Dreamsurges", E.Octo_Globals.Weekly..(E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Timer.DF_Dreamsurges()..L["Dreamsurges"]), .31, 1, .47)
		-- Create_CheckButton(MAIN_scrollChild, self, 24, POS_LEFT+(indent), "DreamsurgeCocoon", E.Octo_Func.func_itemTexture(210254)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_itemName_NOCOLOR(210254).."|r", .31, 1, .47)
		-- Create_CheckButton(MAIN_scrollChild, self, 25, POS_LEFT+(indent), "DreamsurgeCoalescence", E.Octo_Func.func_itemTexture(207026)..E.Octo_Globals.WOW_Common_Color..E.Octo_Func.func_itemName_NOCOLOR(207026), .31, 1, .47)
		-- Create_CheckButton(MAIN_scrollChild, self, 27, POS_LEFT, "CatalystCharges", E.Octo_Func.func_currencyicon(2912)..E.Octo_Func.func_currencyName(2912))
		-- Create_CheckButton(MAIN_scrollChild, self, 28, POS_LEFT, "Flightstones", E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245))
		-- Create_FontString(MAIN_scrollChild, self, 30, POS_LEFT, L["Crests"], "LEFT")
		-- Create_CheckButton(MAIN_scrollChild, self, 31, POS_LEFT+(indent), "Crests_Mythic", E.Octo_Func.func_currencyicon(2812)..E.Octo_Globals.WOW_Legendary_Color..E.Octo_Func.func_currencyName_NOCOLOR(2812).."|r")
		-- Create_CheckButton(MAIN_scrollChild, self, 32, POS_LEFT+(indent), "Crests_Heroic", E.Octo_Func.func_currencyicon(2809)..E.Octo_Globals.WOW_Epic_Color..E.Octo_Func.func_currencyName_NOCOLOR(2809).."|r")
		-- Create_CheckButton(MAIN_scrollChild, self, 33, POS_LEFT+(indent), "Crests_Normal", E.Octo_Func.func_currencyicon(2807)..E.Octo_Globals.WOW_Rare_Color..E.Octo_Func.func_currencyName_NOCOLOR(2807).."|r")
		-- Create_CheckButton(MAIN_scrollChild, self, 34, POS_LEFT+(indent), "Crests_LFR", E.Octo_Func.func_currencyicon(2806)..E.Octo_Globals.WOW_Uncommon_Color..E.Octo_Func.func_currencyName_NOCOLOR(2806).."|r")
		-- Create_CheckButton(MAIN_scrollChild, self, 42, POS_LEFT, "Event", EVENTS_LABEL, r = 1, g = .95, b = .44)
		-- Create_CheckButton(MAIN_scrollChild, self, 43, POS_LEFT, "Holiday", CALENDAR_FILTER_HOLIDAYS, r = 1, g = .4, b = .1)
		-- Create_CheckButton(MAIN_scrollChild, self, 44, POS_LEFT, "Dungeons", "КД инстов")
		-- Create_CheckButton(MAIN_scrollChild, self, 45, POS_LEFT, "Currency", CURRENCY)
		-- Create_CheckButton(MAIN_scrollChild, self, 46, POS_LEFT, "Reputations", REPUTATION)
		-- Create_CheckButton(MAIN_scrollChild, self, 47, POS_LEFT, "Quests", QUESTS_LABEL)
		-- Create_CheckButton(MAIN_scrollChild, self, 48, POS_LEFT, "Items", ITEMS)
		-- Create_CheckButton(MAIN_scrollChild, self, 49, POS_LEFT, "Professions", TRADE_SKILLS)
		-- Create_CheckButton(MAIN_scrollChild, self, 50, POS_LEFT, "Gold", BONUS_ROLL_REWARD_MONEY) -- WORLD_QUEST_REWARD_FILTERS_GOLD
		-- Create_CheckButton(MAIN_scrollChild, self, 51, POS_LEFT, "ItemLevel", STAT_AVERAGE_ITEM_LEVEL)
		-- Create_CheckButton(MAIN_scrollChild, self, 52, POS_LEFT, "LastUpdate", L["Was online"])
		Create_CheckButton(MAIN_scrollChild, self, 1, POS_CENTER, 0, "AutoSellGrey", L["AutoSellGrey"])
		Create_CheckButton(MAIN_scrollChild, self, 2, POS_CENTER, 0, "AutoRepair", L["AutoRepair"])
		Create_CheckButton(MAIN_scrollChild, self, 3, POS_CENTER, 0, "InputDelete", L["InputDelete"])
		Create_CheckButton(MAIN_scrollChild, self, 4, POS_CENTER, 0, "AutoOpen", L["AutoOpen"])
		Create_CheckButton(MAIN_scrollChild, self, 5, POS_CENTER, 0, "AutoGossip", L["AutoGossip"])
		Create_CheckButton(MAIN_scrollChild, self, 6, POS_CENTER, 0, "CinematicCanceler", L["CinematicCanceler"])
		Create_CheckButton(MAIN_scrollChild, self, 7, POS_CENTER, 0, "AutoTurnQuests", L["Auto Turn Quests"])
		Create_CheckButton(MAIN_scrollChild, self, 8, POS_CENTER, 0, "ClearChat", L["ClearChat"])
		Create_CheckButton(MAIN_scrollChild, self, 9, POS_CENTER, 0, "Auto_Screenshot", L["Auto_Screenshot"])
		Create_CheckButton(MAIN_scrollChild, self, 10, POS_CENTER, 0, "Hide_AzeriteEmpoweredItemUI", L["Hide: Azerite Animations"])
		Create_CheckButton(MAIN_scrollChild, self, 11, POS_CENTER, 0, "Hide_Boss_Banner", L["Hide: Boss Banner"])
		Create_CheckButton(MAIN_scrollChild, self, 12, POS_CENTER, 0, "Hide_Covenant", L["Hide: Covenant"])
		Create_CheckButton(MAIN_scrollChild, self, 13, POS_CENTER, 0, "Hide_Error_Messages", L["Hide: Error Messages"])
		Create_CheckButton(MAIN_scrollChild, self, 14, POS_CENTER, 0, "Hide_ObjectivesInInstance", L["Hide: Objectives In Instance"])
		Create_CheckButton(MAIN_scrollChild, self, 15, POS_CENTER, 0, "Hide_Raid_Boss_Emote_Frame", L["Hide: RaidBossEmoteFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 16, POS_CENTER, 0, "Hide_Talking_Head_Frame", L["Hide: TalkingHeadFrame"])
		Create_CheckButton(MAIN_scrollChild, self, 17, POS_CENTER, 0, "Hide_Zone_Text", L["Hide: Zone Text"])
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_CENTER, 0, "UIErrorsFramePosition", L["UIErrorsFramePosition"])
-- local function Create_CheckButton(scroll, self, number, pos, otstyp, config, text, r, g, b, a, button)
		Create_FontString(MAIN_scrollChild, self, 23, POS_CENTER, PlayerName, r, g, b, "CENTER")
		Create_Model(MAIN_scrollChild, self, 22, POS_CENTER, 70619) -- 55907
		number = 1
		btn_right1 = LibSFDropDown:CreateStretchButton(MAIN_scrollChild, 140, 22) -- CreateStretchButtonOriginal
		btn_right1:SetPoint("TOPLEFT", MAIN_scrollChild, "BOTTOMLEFT", POS_RIGHT, -indent*(number-1))
		btn_right1:SetText(E.Octo_Table.OctoTable_Expansions_Table[Octo_ToDo_DB_Vars.config.ExpansionToShow])
		btn_right1:ddSetDisplayMode(GlobalAddonName)
		-- btn_right1:ddSetOpenMenuUp(true) -- NEW
		-- btn_right1:SetScript("OnClick", function(self)
		-- self:ddToggle(1, nil, self, self:GetWidth()+1, self:GetHeight())
		-- end)
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
		-- btn_right2:ddSetOpenMenuUp(true) -- NEW
		-- btn_right2:SetScript("OnClick", function(self)
		-- self:ddToggle(1, nil, self, self:GetWidth()+1, self:GetHeight())
		-- end)
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
		Create_Slider(MAIN_scrollChild, self, 11.5, POS_RIGHT, "curWidthTitleAchievement", "curWidthTitleAchievement", E.Octo_Globals.Green_Color, 100, 400)
		Create_Slider(MAIN_scrollChild, self, 13, POS_RIGHT, "curHeight", "Высота строк: ", E.Octo_Globals.Green_Color, 10, 30)
		Create_Slider(MAIN_scrollChild, self, 14.5, POS_RIGHT, "Addon_Height", "Количество строк: ", E.Octo_Globals.Green_Color, 200, 1000)
		Create_CheckButton(MAIN_scrollChild, self, 17, POS_RIGHT, 0, "ShowOnlyCurrentRealm", L["Only Current Realm"])
		Create_CheckButton(MAIN_scrollChild, self, 18, POS_RIGHT, 0, "PortalsButtons", E.Octo_Func.func_texturefromIcon(3610528, 20)..L["Portals"].." "..L["InDev"])
		Create_CheckButton(MAIN_scrollChild, self, 19, POS_RIGHT, 0, "Octo_debug_BUTTONS_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Доп кнопки", r, g, b, .2)
		Create_CheckButton(MAIN_scrollChild, self, 21, POS_RIGHT, 0, "Achievements", E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 20).." "..WHITE_FONT_COLOR_CODE..ACHIEVEMENTS..FONT_COLOR_CODE_CLOSE)
		Create_CheckButton(MAIN_scrollChild, self, 22, POS_RIGHT, 0, "ItemsUsable", "ItemsUsable".." "..L["InDev"])
		Create_CheckButton(MAIN_scrollChild, self, 23, POS_RIGHT, 0, "ItemsDelete", "ItemsDelete".." "..L["InDev"])
		Create_CheckButton(MAIN_scrollChild, self, 28, POS_RIGHT, 0, "ShowTotalMoney", "Всего денег")
		Create_CheckButton(MAIN_scrollChild, self, 29, POS_RIGHT, 0, "ShowTimeAll", "Общее время игры")
		Create_SimpleButton(MAIN_scrollChild, self, 31, POS_RIGHT, "ReloadUI", "ReloadUI")
		-- Create_EditBox(MAIN_scrollChild, self, 35, POS_RIGHT, "security")
		-- Create_SimpleButton(MAIN_scrollChild, self, 36, POS_RIGHT, "ReloadUI", "ReloadUI")
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
TITLE_FIRST:SetText(GetAddOnMetadata(GlobalAddonName, "Version"))
TITLE_FIRST:SetTextColor(.5, .5, .5, 1)
FIRST_Config:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		Create_CheckButton(FIRST_scrollChild, self, 1, POS_CENTER, 0, "StaticPopup1Button1", "StaticPopup1Button1")
		Create_CheckButton(FIRST_scrollChild, self, 2, POS_CENTER, 0, "AnotherAddonsCasual", "AnotherAddonsCasual")
		Create_CheckButton(FIRST_scrollChild, self, 3, POS_CENTER, 0, "AnotherAddonsDUNG", "AnotherAddonsDUNG")
		Create_CheckButton(FIRST_scrollChild, self, 4, POS_CENTER, 0, "AnotherAddonsRAID", "AnotherAddonsRAID")
		Create_CheckButton(FIRST_scrollChild, self, 5, POS_CENTER, 0, "CVar", "CVar")
		Create_CheckButton(FIRST_scrollChild, self, 6, POS_CENTER, 0, "SORTING", "SORTING")
		Create_CheckButton(FIRST_scrollChild, self, 7, POS_CENTER, 0, "SellFrame", "SellFrame")
		Create_CheckButton(FIRST_scrollChild, self, 8, POS_CENTER, 0, "GlobalFadePersist", "GlobalFadePersist")
		Create_CheckButton(FIRST_scrollChild, self, 9, POS_CENTER, 0, "LootFrame", "LootFrame")
		Create_CheckButton(FIRST_scrollChild, self, 10, POS_CENTER, 0, "THIRD", E.Octo_Func.func_texturefromIcon("Interface/Addons/"..GlobalAddonName.."/Media/AddonTexture_THIRD.tga", 20).."THIRD")
		Create_CheckButton(FIRST_scrollChild, self, 11, POS_CENTER, 0, "TalentTreeTweaks", "TalentTreeTweaks")
		Create_CheckButton(FIRST_scrollChild, self, 12, POS_CENTER, 0, "Octo_debug_Function_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Function 1", 0, .65, 1, 1)
		Create_CheckButton(FIRST_scrollChild, self, 13, POS_CENTER, 0, "Octo_debug_Event_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."Event 1", .31, 1, .47, 1)
		Create_CheckButton(FIRST_scrollChild, self, 14, POS_CENTER, 0, "Octo_debug_BUTTONS_FIRST", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_FIRST.tga", 22).."BUTTONS 1", .69, .38, 1, 1)
		Create_CheckButton(FIRST_scrollChild, self, 15, POS_CENTER, 0, "Octo_debug_Function_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."Function 2", 0, .65, 1, 1)
		Create_CheckButton(FIRST_scrollChild, self, 16, POS_CENTER, 0, "Octo_debug_Event_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."Event 2", .31, 1, .47, 1)
		Create_CheckButton(FIRST_scrollChild, self, 17, POS_CENTER, 0, "Octo_debug_BUTTONS_SECOND", E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/AddonTexture_SECOND.tga", 22).."BUTTONS 2", .69, .38, 1, 1)
		Create_CheckButton(FIRST_scrollChild, self, 18, POS_CENTER, 0, "ChallengesKeystoneFrame", "ChallengesKeystoneFrame")
		Create_CheckButton(FIRST_scrollChild, self, 1, POS_RIGHT, 0, "FieldOfView", "FieldOfView")
-- local function Create_CheckButton(scroll, self, number, pos, otstyp, config, text, r, g, b, a, button)
		Create_Slider(FIRST_scrollChild, self, 3, POS_RIGHT, "FoV_top", "FieldOfView: FoV_top", E.Octo_Globals.Green_Color, 0, 300, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 4.5, POS_RIGHT, "FoV_bottom", "FieldOfView: FoV_bottom", E.Octo_Globals.Green_Color, 0, 300, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 6, POS_RIGHT, "FoV_left", "FieldOfView: FoV_left", E.Octo_Globals.Green_Color, 0, 300, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 7.5, POS_RIGHT, "FoV_right", "FieldOfView: FoV_right", E.Octo_Globals.Green_Color, 0, 300, func_FieldOfView)
		Create_Slider(FIRST_scrollChild, self, 9, POS_RIGHT, "glowType", "glowType", E.Octo_Globals.Green_Color, 1, 3)
		Create_Slider(FIRST_scrollChild, self, 10.5, POS_RIGHT, "glowColor", "glowColor", E.Octo_Globals.Green_Color, 1, 3)
		Create_SimpleButton(FIRST_scrollChild, self, 23, POS_RIGHT, "ResetAllChars", "ResetAllChars")
		Create_SimpleButton(FIRST_scrollChild, self, 31, POS_RIGHT, "ReloadUI", "ReloadUI")
		for k, v in ipairs(E.Octo_Table.OctoTable_Colors) do
			Create_Frame_Color(FIRST_scrollChild, self, k, POS_LEFT, v.name, v.hex)
		end
end)
-- if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
-- if Octo_ToDo_DB_Vars.config == nil then Octo_ToDo_DB_Vars.config = {} end
-- Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
-- Octo_ToDo_DB_Vars.config = Octo_ToDo_DB_Vars.config or {}
local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, "FIRST_Config")
subcategory.ID = L["InDev"].."FIRST_Config"
Settings.RegisterAddOnCategory(subcategory)
-- end
-- FIRST_Config.MEME = FIRST_Config:CreateTexture(nil, "BACKGROUND")
-- FIRST_Config.MEME:SetAllPoints()
-- FIRST_Config.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/1.tga")
-- FIRST_Config.MEME:SetAlpha(.5)
