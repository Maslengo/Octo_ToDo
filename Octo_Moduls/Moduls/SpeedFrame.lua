local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local EventFrame = CreateFrame("Frame")
local Octo_MainFrame_SpeedFrame = CreateFrame("Frame", "Octo_MainFrame_SpeedFrame", UIParent, "BackdropTemplate")
Octo_MainFrame_SpeedFrame:Hide()
function EventFrame:CreateSpeedFrame()
	local vars = EventFrame.savedVars.SpeedFrame
	Octo_MainFrame_SpeedFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
	Octo_MainFrame_SpeedFrame:SetSize(80, 32)
	Octo_MainFrame_SpeedFrame:SetDontSavePosition(true)
	Octo_MainFrame_SpeedFrame:SetClampedToScreen(true)
	Octo_MainFrame_SpeedFrame:SetFrameStrata("HIGH")
	Octo_MainFrame_SpeedFrame:EnableMouse(true)
	Octo_MainFrame_SpeedFrame:SetMovable(true)
	Octo_MainFrame_SpeedFrame:RegisterForDrag("LeftButton")
	-- Drag handlers
	Octo_MainFrame_SpeedFrame:SetScript("OnDragStart", function()
			Octo_MainFrame_SpeedFrame:StartMoving()
	end)
	Octo_MainFrame_SpeedFrame:SetScript("OnDragStop", function()
			Octo_MainFrame_SpeedFrame:StopMovingOrSizing()
			local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_SpeedFrame:GetPoint()
			vars.point = point
			vars.relativePoint = relativePoint
			vars.xOfs = E.func_CompactRoundNumber(xOfs)
			vars.yOfs = E.func_CompactRoundNumber(yOfs)
	end)
	local text_glide = Octo_MainFrame_SpeedFrame:CreateFontString()
	text_glide:SetFontObject(OctoFont11)
	text_glide:SetPoint("CENTER", 0, 7)
	text_glide:SetJustifyV("MIDDLE")
	text_glide:SetJustifyH("CENTER")
	text_glide:SetTextColor(0, 0.65, 1, 1)
	local text_movespeed = Octo_MainFrame_SpeedFrame:CreateFontString()
	text_movespeed:SetFontObject(OctoFont11)
	text_movespeed:SetPoint("CENTER", 0, -7)
	text_movespeed:SetJustifyV("MIDDLE")
	text_movespeed:SetJustifyH("CENTER")
	text_movespeed:SetTextColor(0.31, 1, 0.47, 1)
	-- Update ticker
	C_Timer.NewTicker(0.1, function()
			local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
			local base = isGliding and forwardSpeed or GetUnitSpeed("PLAYER")
			local movespeed = base / BASE_MOVEMENT_SPEED * 100
			if forwardSpeed > 1 then
				text_glide:SetText("glide: ".. E.func_CompactRoundNumber(forwardSpeed))
				text_movespeed:SetPoint("CENTER", 0, -7)
			else
				text_glide:SetText("")
				text_movespeed:SetPoint("CENTER", 0, 0)
			end
			text_movespeed:SetText(movespeed ~= 0 and E.func_CompactRoundNumber(movespeed) or "")
	end)
	Octo_MainFrame_SpeedFrame:Show()
end
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
	EventFrame:CreateSpeedFrame()
end