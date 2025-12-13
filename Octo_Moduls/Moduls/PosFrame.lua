local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local EventFrame = CreateFrame("Frame")
local Octo_MainFrame_PosFrame = CreateFrame("Frame", "Octo_MainFrame_PosFrame", WorldMapFrame, "BackdropTemplate") -- WorldMapFrame
Octo_MainFrame_PosFrame:Hide()
function EventFrame:CreatePosFrame()
	local vars = EventFrame.savedVars.PosFrame
	if not vars.Shown then return end
	local Gray_Color = E.COLOR_GRAY
	Octo_MainFrame_PosFrame:Show()
	Octo_MainFrame_PosFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
	Octo_MainFrame_PosFrame:SetSize(280, 32)
	Octo_MainFrame_PosFrame:SetDontSavePosition(true)
	Octo_MainFrame_PosFrame:SetClampedToScreen(true)
	Octo_MainFrame_PosFrame:SetFrameStrata("HIGH")
	Octo_MainFrame_PosFrame:EnableMouse(true)
	Octo_MainFrame_PosFrame:SetMovable(true)
	Octo_MainFrame_PosFrame:RegisterForDrag("LeftButton")
	-- Drag handlers
	Octo_MainFrame_PosFrame:SetScript("OnDragStart", function()
			Octo_MainFrame_PosFrame:StartMoving()
	end)
	Octo_MainFrame_PosFrame:SetScript("OnDragStop", function()
			Octo_MainFrame_PosFrame:StopMovingOrSizing()
			local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_PosFrame:GetPoint()
			vars.point = point
			vars.relativePoint = relativePoint
			vars.xOfs = E.func_CompactRoundNumber(xOfs)
			vars.yOfs = E.func_CompactRoundNumber(yOfs)
	end)
	-- Create text elements
	local function CreateTextElement(offset, r, g, b)
		local text = Octo_MainFrame_PosFrame:CreateFontString()
		text:SetFontObject(OctoFont11)
		offset = offset or 0
		r = r or 1
		g = g or 1
		b = b or 1
		text:SetPoint("CENTER", 0, offset)
		text:SetJustifyV("MIDDLE")
		text:SetJustifyH("CENTER")
		text:SetTextColor(r, g, b, 1)
		-- text:SetTextColor(unpack(color))
		return text
	end
	local mapIdText = CreateTextElement(20, 1, 1, 1)
	local cursorText = CreateTextElement(7, 0, .65, 1)
	local playerText = CreateTextElement(-7, .31, 1, .47)
	-- Position updater
	C_Timer.NewTicker(.2, function()
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
				if MapId then
					mapIdText:SetText(E.func_GetMapName(MapId)..Gray_Color.."id: "..MapId.."|r")
				end
				-- Update cursor text
				if cursorX and cursorY then
					cursorText:SetText(E.func_FormatCoordinates(cursorX, cursorY))
					playerText:SetPoint("CENTER", 0, -7)
				else
					cursorText:SetText("")
					playerText:SetPoint("CENTER", 0, 0)
				end
				-- Update player position text
				playerText:SetText(E.func_FormatCoordinates(posX, posY))
			end
	end)
end
-- OPEN_WORLD_MAP, WORLD_MAP_UPDATE, QUEST_LOG_UPDATE
----------------------------------------------------------------
-- Обработчики событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_LOGIN()
	EventFrame:CreatePosFrame()
end
-- ADVENTURE_MAP_UPDATE_POIS,
-- ADVENTURE_MAP_OPEN,
-- ADVENTURE_MAP_UPDATE_INSETS