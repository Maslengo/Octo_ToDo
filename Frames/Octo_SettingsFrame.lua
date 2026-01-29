local GlobalAddonName, E = ...
if not E.DEBUG then return end
----------------------------------------------------------------
-- /dump SettingsPanel:GetSize()
local HEIGHT = 724
local WIDTH = 920
-- local HEIGHT = 600 -- ВЫСОТА
-- local WIDTH = math.floor(E.func_goldenWidth(HEIGHT)) -- ШИРИНА
-- /dump Octo_SettingsFrame:GetSize()
----------------------------------------------------------------
local LibStub = LibStub
local L = E.L
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame:Hide()
----------------------------------------------------------------
EventFrame.searchFilter = nil
local Octo_SettingsFrame = CreateFrame("BUTTON", "Octo_SettingsFrame", UIParent, "OctoBackdropTemplate")
Octo_SettingsFrame:Hide()
E.func_RegisterFrame_ICONS(Octo_SettingsFrame)
----------------------------------------------------------------
local parentFrame = Octo_SettingsFrame
----------------------------------------------------------------
local btn = CreateFrame("BUTTON", nil, UIParent, "UIPanelButtonTemplate")
btn:SetPoint("TOPLEFT")
btn:SetSize(128, 24)
btn:SetText("Octo_SettingsFrame")
btn:SetScript("OnClick", function(self, button, down)
		Octo_SettingsFrame:SetShown(not Octo_SettingsFrame:IsShown())
end)
btn:RegisterForClicks("LeftButtonUp")
----------------------------------------------------------------
function EventFrame:func_CreateOcto_SettingsFrame()
	----------------------------------------------------------------
	Octo_SettingsFrame:SetSize(WIDTH, HEIGHT)
	Octo_SettingsFrame:SetPoint("CENTER", 0, 0)
	Octo_SettingsFrame:SetDontSavePosition(true)
	Octo_SettingsFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_SettingsFrame:SetFrameStrata("HIGH")
	----------------------------------------------------------------
	Octo_SettingsFrame:EnableMouse(true)
	Octo_SettingsFrame:SetMovable(true)
	Octo_SettingsFrame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_SettingsFrame:StartMoving()
			end
	end)
	Octo_SettingsFrame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_SettingsFrame:StopMovingOrSizing()
				local left = Octo_SettingsFrame:GetLeft()
				local top = Octo_SettingsFrame:GetTop()
				Octo_SettingsFrame:ClearAllPoints()
				Octo_SettingsFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
			end
	end)
	Octo_SettingsFrame:RegisterForClicks("RightButtonUp")
	Octo_SettingsFrame:SetScript("OnClick", Octo_SettingsFrame.Hide)
	----------------------------------------------------------------
	local HEIGHT = 724
	local WIDTH = 920
	local LEFT_WIDTH = 256
	local RIGHT_WIDTH = WIDTH - LEFT_WIDTH
	local LEFT_HEIGHT = HEIGHT - E.HEADER_HEIGHT
	local RIGHT_HEIGHT = HEIGHT - E.HEADER_HEIGHT
	----------------------------------------------------------------
	local HEADER = CreateFrame("FRAME", nil, Octo_SettingsFrame)
	HEADER:SetSize(WIDTH, E.HEADER_HEIGHT)
	HEADER:SetPoint("TOPLEFT")
	HEADER.TEXTURE = HEADER:CreateTexture(nil, "BACKGROUND", nil, -3)
	HEADER.TEXTURE:SetAllPoints()
	HEADER.TEXTURE:SetTexture(E.TEXTURE_CHAR_PATH)
	----------------------------------------------------------------
	local LEFTFRAME = CreateFrame("FRAME", nil, Octo_SettingsFrame, "OctoBackdropTemplate")
	LEFTFRAME:SetSize(LEFT_WIDTH, LEFT_HEIGHT)
	LEFTFRAME:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	-- LEFTFRAME.TEXTURE = LEFTFRAME:CreateTexture(nil, "BACKGROUND", nil, -3)
	-- LEFTFRAME.TEXTURE:SetAllPoints()
	-- LEFTFRAME.TEXTURE:SetTexture(E.TEXTURE_CHAR_PATH)
	-- LEFTFRAME.TEXTURE:SetVertexColor(1, 0, 0, .1)
	----------------------------------------------------------------
	local RIGHTFRAME = CreateFrame("FRAME", nil, Octo_SettingsFrame, "OctoBackdropTemplate")
	RIGHTFRAME:SetSize(RIGHT_WIDTH, RIGHT_HEIGHT)
	RIGHTFRAME:SetPoint("TOPLEFT", LEFT_WIDTH, -E.HEADER_HEIGHT)
	-- RIGHTFRAME.TEXTURE = RIGHTFRAME:CreateTexture(nil, "BACKGROUND", nil, -3)
	-- RIGHTFRAME.TEXTURE:SetAllPoints()
	-- RIGHTFRAME.TEXTURE:SetTexture(E.TEXTURE_CHAR_PATH)
	-- RIGHTFRAME.TEXTURE:SetVertexColor(0, 1, 0, .1)
	----------------------------------------------------------------
	local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
	Octo_SettingsFrame:HookScript("OnShow", function()
			local r, g, b, a = E.func_DB_HEADER_COLOR(CharInfo)
			HEADER:SetSize(WIDTH, E.HEADER_HEIGHT)
			HEADER.TEXTURE:SetVertexColor(r, g, b, a)
	end)
	----------------------------------------------------------------
end
function EventFrame:func_Octo_Options()
	Octo_Options = Octo_Options or {}
	Octo_Options.fontSize = Octo_Options.fontSize or 12
end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CreateOcto_SettingsFrame()
end
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_SettingsFrame:Hide()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local button = LibSFDropDown:CreateButton(parentFrame)
button:SetPoint("TOPLEFT", 20, -20)
button:ddSetSelectedValue(1)
local function selectFunction(menuButton)
	button:ddSetSelectedValue(menuButton.value)
	-- some code
end
button:ddInitialize(function(self, level)
		local info = {}
		for i = 1, 10 do
			info.text = "Text"..i
			info.value = i
			info.func = selectFunction
			self:ddAddButton(info, level)
		end
end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local button = LibSFDropDown:CreateStretchButton(parentFrame, 120, 22)
button:SetText("Some text")
button:SetPoint("TOPLEFT", 20, -40)
local function selectFunction(menuButton, arg1, arg2, checked)
	E.func_PrintMessage(menuButton.value, arg1, arg2, checked)
	-- some code
end
button:ddSetInitFunc(function(self, level)
		local info = {}
		info.notCheckable = true
		info.isTitle = true
		info.justifyH = "CENTER"
		info.text = "TITLE"
		self:ddAddButton(info, level)
		self:ddAddSeparator(level)
		self:ddAddSpace(level)
		info.justifyH = nil
		info.notCheckable = nil
		info.isTitle = nil
		info.isNotRadio = true
		info.keepShownOnClick = true
		for i = 1, 10 do
			info.text = "Text"..i
			info.value = "value"..i
			info.arg1 = "arg1"..i
			info.arg2 = "arg2"..i
			info.checked = i % 2 == 0
			info.func = selectFunction
			self:ddAddButton(info, level)
		end
end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local button = CreateFrame("BUTTON", nil, parentFrame, "UIMenuButtonStretchTemplate")
button:SetSize(120, 22)
button:SetText("Some text")
button:SetPoint("TOPLEFT", 20, -60)
LibSFDropDown:SetMixin(button)
button:ddSetDisplayMode("menu")
button:ddHideWhenButtonHidden()
button:ddSetNoGlobalMouseEvent(true)
local list = {}
for i = 1, 5 do
	local t = {
		name = "text"..i,
		list = {},
	}
	for j = 1, 10 do
		tinsert(t.list, {
				name = "name "..i.." "..j,
				value = j,
		})
	end
	tinsert(list, t)
end
button:SetScript("OnClick", function(self)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:ddToggle(1, list, self, 102, 17)
end)
local function selectFunction(menuButton)
	E.func_PrintMessage(menuButton.value)
	-- some code
end
button:ddSetInitFunc(function(self, level, value)
		local info = {}
		info.notCheckable = true
		for _, v in ipairs(value) do
			info.text = v.name
			if v.list then
				info.keepShownOnClick = true
				info.hasArrow = true
				info.value = v.list
			else
				info.value = v.value
				info.func = selectFunction
			end
			self:ddAddButton(info, level)
		end
end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local button = LibSFDropDown:CreateButton(parentFrame)
button:SetPoint("TOPLEFT", 20, -80)
button:ddSetSelectedValue(1)
local function selectFunction(menuButton)
	button:ddSetSelectedValue(menuButton.value)
	-- some code
end
button:ddInitialize(function(self, level)
		local info = {}
		info.list = {}
		for i = 1, 30 do
			local subInfo = {}
			subInfo.text = "Text"..i
			subInfo.value = i
			subInfo.func = selectFunction
			tinsert(info.list, subInfo)
		end
		self:ddAddButton(info, level)
end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- local menu = LibSFDropDown:SetMixin({})
-- menu:ddHideWhenButtonHidden(parentFrame)
-- menu:ddSetMaxHeight(180)
-- local check = random(10)
-- local menuList = {}
-- local menuListFunc = function(btn) check = btn.value end
-- local menuListChecked = function(btn) return check == btn.value end
-- for i = 1, 10 do
--     menuList[i] = {
--         text = "test text "..i,
--         value = i,
--         checked = menuListChecked,
--         func = menuListFunc,
--     }
-- end
-- menuList[11] = {
--     text = "test",
--     menuList = {
--         {
--             notCheckable = true,
--             text = "wow",
--             func = function() E.func_PrintMessage("wow") end,
--         },
--     },
-- }
-- parentFrame:SetScript("OnMouseDown", function(self, button)
--         if button ~= "RightButton" then return end
--         menu:ddEasyMenu(menuList, "cursor", nil, nil, "menu")
-- end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local background = LibSFDropDown:CreateMediaBackgroundButton(parentFrame, 120) -- BACKGROUND
background:SetPoint("TOPRIGHT", -20, -20)
background:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("background"))
background:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("background", value)
		E.func_PrintMessage(value, texture)
		-- some code
end)
local border = LibSFDropDown:CreateMediaBorderButton(parentFrame, 120) -- BORDER
border:SetPoint("TOPRIGHT", -20, -50)
border:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("border"))
border:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("border", value)
		E.func_PrintMessage(value, texture)
		-- some code
end)
local statusbar = LibSFDropDown:CreateMediaStatusbarButton(parentFrame, 120) -- STATUSBAR
statusbar:SetPoint("TOPRIGHT", -20, -80)
statusbar:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("statusbar"))
statusbar:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("statusbar", value)
		E.func_PrintMessage(value, texture)
		-- some code
end)
local font = LibSFDropDown:CreateMediaFontButton(parentFrame, 120) -- FONT
font:SetPoint("TOPRIGHT", -20, -110)
font:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("font"))
font:ddSetOnSelectedFunc(function(value)
		local selectedFont = LibSharedMedia:Fetch("font", value)
		E.func_PrintMessage(value, selectedFont)
		-- some code
end)
local sound = LibSFDropDown:CreateMediaSoundButton(parentFrame, 120) -- SOUND
sound:SetPoint("TOPRIGHT", -20, -140)
sound:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("sound"))
sound:ddSetOnSelectedFunc(function(value)
		local selectedSound = LibSharedMedia:Fetch("sound", value)
		E.func_PrintMessage(value, selectedSound)
		-- some code
end)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------