local GlobalAddonName, ns = ...
E = _G.OctoEngine

local Octo_MinecraftFrameFG, frameLEFT, frameRIGHT
local Octo_EventFrame_Minecraft = CreateFrame("Frame")
Octo_EventFrame_Minecraft:Hide()

-- Constants
local SIZE = 64
local HALF_SIZE = SIZE / 2
local TEXTURE_PATH_FG = "Interface/AddOns/"..GlobalAddonName.."/Media/MINECRAFT/44.tga"
local TEXTURE_PATH_BG = "Interface/AddOns/"..GlobalAddonName.."/Media/statusbar/02 Octo-Blank.tga"

-- Helper functions
local function CreateFrameWithTexture(name, parent, size, strata, texturePath, color, anchor, x, y)
	local frame = CreateFrame("Button", name, parent)
	frame:SetSize(size, size)
	frame:SetFrameStrata(strata)
	if anchor then frame:SetPoint(anchor[1], anchor[2], anchor[3], x or 0, y or 0) end

	local texture = frame:CreateTexture(nil, "ARTWORK")
	texture:SetAllPoints()
	texture:SetTexture(texturePath)
	texture:SetVertexColor(color.r, color.g, color.b, 1)
	frame.texture = texture

	return frame
end

local function CreateColorPickerFrame(parent, color, anchor, x, y, clickFunc, isLeft)
	local frame = CreateFrame("Button", nil, parent, "BackdropTemplate")
	frame:SetPoint("TOP", parent, anchor, x, y)
	frame:SetSize(HALF_SIZE, HALF_SIZE)

	local swatchBg = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
	swatchBg:SetSize(HALF_SIZE-4, HALF_SIZE-4)
	swatchBg:SetPoint("CENTER")
	swatchBg:SetColorTexture(HIGHLIGHT_FONT_COLOR:GetRGB())
	frame.swatchBg = swatchBg

	local innerBorder = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
	innerBorder:SetSize(HALF_SIZE-6, HALF_SIZE-6)
	innerBorder:SetPoint("CENTER")
	innerBorder:SetColorTexture(BLACK_FONT_COLOR:GetRGB())

	local colorTex = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
	colorTex:SetSize(HALF_SIZE-10, HALF_SIZE-10)
	colorTex:SetPoint("CENTER")
	colorTex:SetColorTexture(color.r, color.g, color.b)
	frame.color = colorTex

	frame:SetScript("OnClick", clickFunc)
	frame:SetScript("OnEnter", function(self) self.swatchBg:SetVertexColor(NORMAL_FONT_COLOR:GetRGB()) end)
	frame:SetScript("OnLeave", function(self) self.swatchBg:SetVertexColor(HIGHLIGHT_FONT_COLOR:GetRGB()) end)

	if isLeft then
		frameLEFT = frame
	else
		frameRIGHT = frame
	end

	return frame
end

local function CreateText(parent, point, relativePoint, x, y, justifyH)
	local text = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text:SetPoint(point, parent, relativePoint, x, y)
	text:SetFontObject(OctoFont11)
	text:SetWordWrap(true)
	text:SetJustifyV("MIDDLE")
	text:SetJustifyH(justifyH)
	text:SetTextColor(1, 1, 1, 1)
	return text
end

local function UpdateColorDisplay(frame, color, text, colorPickerFrame)
	frame.texture:SetVertexColor(color.r, color.g, color.b)
	if colorPickerFrame then
		colorPickerFrame.color:SetColorTexture(color.r, color.g, color.b)
	end
	text:SetText(string.format("r: %s\ng: %s\nb: %s\n \n%s", color.r, color.g, color.b, E:func_rgb2hexSTRING(color.r, color.g, color.b)))
end

local function ColorSwatch_OnClick(color, updateFunc)
	ColorPickerFrame:SetupColorPickerAndShow({
			r = color.r, g = color.g, b = color.b,
			swatchFunc = function()
				color.r, color.g, color.b = ColorPickerFrame:GetColorRGB()
				updateFunc()
			end,
			cancelFunc = function(prevValues)
				color.r, color.g, color.b = prevValues.r, prevValues.g, prevValues.b
				updateFunc()
			end
	})
end

function Octo_EventFrame_Minecraft:CreateOcto_MinecraftFrameFG()
	local colorFG, colorBG = Octo_Minecraft_DB.ColorFG, Octo_Minecraft_DB.ColorBG

	-- Main Frame
	Octo_MinecraftFrameFG = CreateFrameWithTexture("Octo_MinecraftFrameFG", UIParent, SIZE, "HIGH", TEXTURE_PATH_FG, colorFG, {"TOPLEFT", 300, -100})
	Octo_MinecraftFrameFG:Hide()
	Octo_MinecraftFrameFG:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_MinecraftFrameFG:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	Octo_MinecraftFrameFG:EnableMouse(true)
	Octo_MinecraftFrameFG:SetMovable(true)

	Octo_MinecraftFrameFG:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_MinecraftFrameFG:SetAlpha(E.bgCa)
				Octo_MinecraftFrameFG:StartMoving()
			end
	end)

	Octo_MinecraftFrameFG:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_MinecraftFrameFG:SetAlpha(1)
				Octo_MinecraftFrameFG:StopMovingOrSizing()
			end
	end)

	Octo_MinecraftFrameFG:RegisterForClicks("RightButtonUp")
	Octo_MinecraftFrameFG:SetScript("OnClick", Octo_MinecraftFrameFG.Hide)
	Octo_MinecraftFrameFG.text = CreateText(Octo_MinecraftFrameFG, "RIGHT", "LEFT", 0, 0, "RIGHT")

	local Octo_MinecraftFrameBG = CreateFrameWithTexture("Octo_MinecraftFrameBG", Octo_MinecraftFrameFG, SIZE, "LOW", TEXTURE_PATH_BG, colorBG, {"CENTER", 0, 0})
	Octo_MinecraftFrameBG.text = CreateText(Octo_MinecraftFrameBG, "LEFT", "RIGHT", 0, 0, "LEFT")

	local function UpdateFG()
		UpdateColorDisplay(Octo_MinecraftFrameFG, colorFG, Octo_MinecraftFrameFG.text, frameLEFT)
	end

	local function UpdateBG()
		UpdateColorDisplay(Octo_MinecraftFrameBG, colorBG, Octo_MinecraftFrameBG.text, frameRIGHT)
	end

	CreateColorPickerFrame(Octo_MinecraftFrameFG, colorFG, "BOTTOM", -HALF_SIZE/2, -HALF_SIZE, function()
			ColorSwatch_OnClick(colorFG, UpdateFG)
	end, true)

	CreateColorPickerFrame(Octo_MinecraftFrameBG, colorBG, "BOTTOM", HALF_SIZE/2, -HALF_SIZE, function()
			ColorSwatch_OnClick(colorBG, UpdateBG)
	end, false)

	UpdateFG()
	UpdateBG()
end

local MyEventsTable = {"ADDON_LOADED"}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Minecraft, MyEventsTable)

function Octo_EventFrame_Minecraft:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil

		if not OctpToDo_inspectScantip then
			OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
			OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
		end

		self:CreateOcto_MinecraftFrameFG()
		E:func_CreateMinimapButton(GlobalAddonName, "Minecraft", Octo_Minecraft_DB, Octo_MinecraftFrameFG, nil, "Octo_MinecraftFrameFG")
	end
end