local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("Frame")
EventFrame:Hide()
local Octo_MainFrame_SpeedFrame = CreateFrame("Frame", "Octo_MainFrame_SpeedFrame", UIParent, "BackdropTemplate")
Octo_MainFrame_SpeedFrame:Hide()
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
function EventFrame:CreateSpeedFrame()
	local vars = Octo_ToDo_DB_Vars.SpeedFrame
	Octo_MainFrame_SpeedFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
	Octo_MainFrame_SpeedFrame:SetSize(80, 32)
	Octo_MainFrame_SpeedFrame:SetDontSavePosition(true)
	Octo_MainFrame_SpeedFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_SpeedFrame:SetFrameStrata("HIGH")
	Octo_MainFrame_SpeedFrame:EnableMouse(true)
	Octo_MainFrame_SpeedFrame:SetMovable(true)
	Octo_MainFrame_SpeedFrame:RegisterForDrag("LeftButton")
	-- Drag handlers
	Octo_MainFrame_SpeedFrame:SetScript("OnDragStart", function()
			Octo_MainFrame_SpeedFrame:StartMoving()
			LibCustomGlow.ButtonGlow_Start(Octo_MainFrame_SpeedFrame, {.31, 1, .47, 1}, .1)
	end)
	Octo_MainFrame_SpeedFrame:SetScript("OnDragStop", function()
			Octo_MainFrame_SpeedFrame:StopMovingOrSizing()
			local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_SpeedFrame:GetPoint()
			vars.point = point
			vars.relativePoint = relativePoint
			vars.xOfs = E.func_CompactNumberRound(xOfs)
			vars.yOfs = E.func_CompactNumberRound(yOfs)
			LibCustomGlow.ButtonGlow_Stop(Octo_MainFrame_SpeedFrame)
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
				text_glide:SetText("glide: ".. E.func_CompactNumberRound(forwardSpeed))
				text_movespeed:SetPoint("CENTER", 0, -7)
			else
				text_glide:SetText("")
				text_movespeed:SetPoint("CENTER", 0, 0)
			end
			text_movespeed:SetText(movespeed ~= 0 and E.func_CompactNumberRound(movespeed) or "")
	end)
	Octo_MainFrame_SpeedFrame:Show()
end
----------------------------------------------------------------
-- Обработчики событий
----------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
--- Обрабатывает событие загрузки аддона
function EventFrame:VARIABLES_LOADED()
	EventFrame:CreateSpeedFrame()
end