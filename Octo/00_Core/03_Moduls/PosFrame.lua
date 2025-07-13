local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

-- PosFrame
tinsert(E.Modules, function()
local vars = Octo_ToDo_DB_Vars.PosFrame
if not vars.Shown then return end

local PosFrame = CreateFrame("Frame", "PosFrame", WorldMapFrame, "BackdropTemplate")
PosFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
PosFrame:SetSize(280, 32)
PosFrame:SetClampedToScreen(false)
PosFrame:SetFrameStrata("HIGH")
PosFrame:EnableMouse(true)
PosFrame:SetMovable(true)
PosFrame:RegisterForDrag("LeftButton")

-- Drag handlers
PosFrame:SetScript("OnDragStart", function()
PosFrame:StartMoving()
LibCustomGlow.ButtonGlow_Start(PosFrame, {.31, 1, .47, 1}, .1)
end)

PosFrame:SetScript("OnDragStop", function()
PosFrame:StopMovingOrSizing()
local point, _, relativePoint, xOfs, yOfs = PosFrame:GetPoint()
vars.point = point
vars.relativePoint = relativePoint
vars.xOfs = E.func_CompactNumberSimple(xOfs)
vars.yOfs = E.func_CompactNumberSimple(yOfs)
LibCustomGlow.ButtonGlow_Stop(PosFrame)
end)

-- Create text elements
local function CreateTextElement(offset, color)
local text = PosFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
text:SetPoint("CENTER", 0, offset)
text:SetFontObject(OctoFont11)
text:SetJustifyV("MIDDLE")
text:SetJustifyH("CENTER")
text:SetTextColor(unpack(color))
return text
end

local mapIdText = CreateTextElement(20, {1, 1, 1, 1})
local cursorText = CreateTextElement(7, {0, .65, 1, 1})
local playerText = CreateTextElement(-7, {.31, 1, .47, 1})

-- Position updater
C_Timer.NewTicker(.1, function()
if WorldMapFrame:IsShown() then
local map = C_Map.GetBestMapForUnit("PLAYER") or 0
if map == 0 then return end

local pos = C_Map.GetPlayerMapPosition(map, "PLAYER")
if not pos then return end

local posX, posY = pos:GetXY()
-- posX = posX and string.format("%.1f", posX*100) or 0
-- posY = posY and string.format("%.1f", posY*100) or 0

local cursorX, cursorY
cursorX, cursorY = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
-- cursorX = cursorX and string.format("%.1f", cursorX*100) or 0
-- cursorY = cursorY and string.format("%.1f", cursorY*100) or 0

if tonumber(cursorX) <= 0 or tonumber(cursorX) >= 1 or
tonumber(cursorY) <= 0 or tonumber(cursorY) >= 1 then
cursorX, cursorY = nil, nil
end

	local MapId = WorldMapFrame:GetMapID("current")

	-- Update cursor text
	if cursorX and cursorY then
	cursorText:SetText(E.func_GetCoordFormated(cursorX, cursorY))
	playerText:SetPoint("CENTER", 0, -7)
	else
	if MapId then
	mapIdText:SetText("id: "..MapId)
	end
	cursorText:SetText("")
	playerText:SetPoint("CENTER", 0, 0)
	end
	-- Update player position text
 		playerText:SetText(E.func_GetCoordFormated(posX, posY))
end
end)
end)


-- ADVENTURE_MAP_UPDATE_POIS,
-- ADVENTURE_MAP_OPEN,
-- ADVENTURE_MAP_UPDATE_INSETS

