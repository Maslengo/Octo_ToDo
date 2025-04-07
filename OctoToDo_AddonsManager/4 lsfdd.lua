local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

----------------------------------------------------------------
local background = LibSFDropDown:CreateMediaBackgroundButton(parentFrame, 120) -- BACKGROUND
background:SetPoint("TOPLEFT", 20, -20)
background:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("background"))
background:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("background", value)
		print(value, texture)
		-- some code
end)

local border = LibSFDropDown:CreateMediaBorderButton(parentFrame, 120) -- BORDER
border:SetPoint("TOPLEFT", background, "BOTTOMLEFT", 0, -10)
border:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("border"))
border:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("border", value)
		print(value, texture)
		-- some code
end)

local statusbar = LibSFDropDown:CreateMediaStatusbarButton(parentFrame, 120) -- STATUSBAR
statusbar:SetPoint("TOPLEFT", border, "BOTTOMLEFT", 0, -10)
statusbar:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("statusbar"))
statusbar:ddSetOnSelectedFunc(function(value)
		local texture = LibSharedMedia:Fetch("statusbar", value)
		print(value, texture)
		-- some code
end)

local font = LibSFDropDown:CreateMediaFontButton(parentFrame, 120) -- FONT
font:SetPoint("TOPLEFT", statusbar, "BOTTOMLEFT", 0, -10)
font:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("font"))
font:ddSetOnSelectedFunc(function(value)
		local selectedFont = LibSharedMedia:Fetch("font", value)
		print(value, selectedFont)
		-- some code
end)

local sound = LibSFDropDown:CreateMediaSoundButton(parentFrame, 120) -- SOUND
sound:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -10)
sound:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("sound"))
sound:ddSetOnSelectedFunc(function(value)
		local selectedSound = LibSharedMedia:Fetch("sound", value)
		print(value, selectedSound)
		-- some code
end)
----------------------------------------------------------------
local button = CreateFrame("BUTTON", nil, parentFrame, "UIMenuButtonStretchTemplate")
button:SetSize(120, 22)
button:SetText("Some text")
button:SetPoint("TOPLEFT")
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
	print(menuButton.value)
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