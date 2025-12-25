local GlobalAddonName, E = ...
local LibStub = LibStub
local L = E.L
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame.searchFilter = nil
local OctoSettings = CreateFrame("BUTTON", "OctoSettings", UIParent, "BackdropTemplate")
OctoSettings:Hide()
E.func_RegisterFrame(OctoSettings)
local OctoSettings_Background = CreateFrame("FRAME", "OctoSettings_Background", OctoSettings, "BackdropTemplate")
----------------------------------------------------------------
local parentFrame = OctoSettings
----------------------------------------------------------------
local HEIGHT = 600 -- ВЫСОТА
local WIDTH = math.floor(E.func_goldenWidth(HEIGHT)) -- ШИРИНА
----------------------------------------------------------------
local btn = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
btn:SetPoint("TOPLEFT")
btn:SetSize(100, 32)
btn:SetText("OctoSettings")
btn:SetScript("OnClick", function(self, button, down)
		OctoSettings:SetShown(not OctoSettings:IsShown())
end)
btn:RegisterForClicks("LeftButtonUp")
----------------------------------------------------------------
function EventFrame:func_CreateOctoSettings()
	OctoSettings:SetSize(WIDTH, HEIGHT)
	OctoSettings:SetPoint("CENTER", 0, 0)
	OctoSettings_Background:SetAllPoints()
	OctoSettings_Background:SetFrameLevel(OctoSettings:GetFrameLevel() - 1) -- Ниже основного фрейма
	OctoSettings_Background:SetBackdrop(E.menuBackdrop)
	OctoSettings_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA) -- E.backgroundColorA
	OctoSettings_Background:SetBackdropBorderColor(0, 0, 0, 1)
	OctoSettings:SetDontSavePosition(true)
	OctoSettings:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	OctoSettings:SetFrameStrata("HIGH")
	local CENTRALFRAME = CreateFrame("BUTTON", nil, OctoSettings, "BackdropTemplate")
	CENTRALFRAME:SetPoint("CENTER")
	CENTRALFRAME:SetSize(HEIGHT, HEIGHT)
	CENTRALFRAME:SetBackdrop(E.menuBackdrop)
	CENTRALFRAME:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA) -- E.backgroundColorA
	CENTRALFRAME:SetBackdropBorderColor(0, 0, 0, 1)
end
function EventFrame:func_Octo_Options()
	Octo_Options = Octo_Options or {}
	Octo_Options.fontSize = Octo_Options.fontSize or 12
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end
----------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CreateOctoSettings()
end
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_DISABLED()
	OctoSettings:Hide()
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
local menu = LibSFDropDown:SetMixin({})
menu:ddHideWhenButtonHidden(parentFrame)
menu:ddSetMaxHeight(180)
local check = random(10)
local menuList = {}
local menuListFunc = function(btn) check = btn.value end
local menuListChecked = function(btn) return check == btn.value end
for i = 1, 10 do
	menuList[i] = {
		text = "test text "..i,
		value = i,
		checked = menuListChecked,
		func = menuListFunc,
	}
end
menuList[11] = {
	text = "test",
	menuList = {
		{
			notCheckable = true,
			text = "wow",
			func = function() E.func_PrintMessage("wow") end,
		},
	},
}
parentFrame:SetScript("OnMouseDown", function(self, button)
		if button ~= "RightButton" then return end
		menu:ddEasyMenu(menuList, "cursor", nil, nil, "menu")
end)
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