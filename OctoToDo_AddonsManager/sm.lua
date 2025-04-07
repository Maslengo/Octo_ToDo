local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------






local lsfdd = LibStub("LibSFDropDown-1.5")
local media = LibStub("LibSharedMedia-3.0")

local background = lsfdd:CreateMediaBackgroundButton(parentFrame, 120) -- BACKGROUND
background:SetPoint("TOPLEFT", 0, 0)
background:ddSetSelectedValue(currentValue or media:GetDefault("background"))
background:ddSetOnSelectedFunc(function(value)
		local texture = media:Fetch("background", value)
		print(value, texture)
		-- some code
end)

local border = lsfdd:CreateMediaBorderButton(parentFrame, 120) -- BORDER
border:SetPoint("TOPLEFT", background, "BOTTOMLEFT", 0, -10)
border:ddSetSelectedValue(currentValue or media:GetDefault("border"))
border:ddSetOnSelectedFunc(function(value)
		local texture = media:Fetch("border", value)
		print(value, texture)
		-- some code
end)

local statusbar = lsfdd:CreateMediaStatusbarButton(parentFrame, 120) -- STATUSBAR
statusbar:SetPoint("TOPLEFT", border, "BOTTOMLEFT", 0, -10)
statusbar:ddSetSelectedValue(currentValue or media:GetDefault("statusbar"))
statusbar:ddSetOnSelectedFunc(function(value)
		local texture = media:Fetch("statusbar", value)
		print(value, texture)
		-- some code
end)

local font = lsfdd:CreateMediaFontButton(parentFrame, 120) -- FONT
font:SetPoint("TOPLEFT", statusbar, "BOTTOMLEFT", 0, -10)
font:ddSetSelectedValue(currentValue or media:GetDefault("font"))
font:ddSetOnSelectedFunc(function(value)
		local selectedFont = media:Fetch("font", value)
		print(value, selectedFont)
		-- some code
end)

local sound = lsfdd:CreateMediaSoundButton(parentFrame, 120) -- SOUND
sound:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -10)
sound:ddSetSelectedValue(currentValue or media:GetDefault("sound"))
sound:ddSetOnSelectedFunc(function(value)
		local selectedSound = media:Fetch("sound", value)
		print(value, selectedSound)
		-- some code
end)

