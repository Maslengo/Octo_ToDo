local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local function HeaderFrameLeft_OnShow(frame)
	local text = E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetSecondsUntilWeeklyReset(), false, true).."|r"
	frame.Text1:SetText(text)
	frame:SetSize(E.MIN_COLUMN_WIDTH_LEFT*2, E.GLOBAL_LINE_HEIGHT)
end
----------------------------------------------------------------
function E.func_WeeklyResetFrameLeft(f)
	local WeeklyResetFrameLeft = CreateFrame("FRAME", nil, f)
	WeeklyResetFrameLeft:SetPoint("TOPLEFT", f, "BOTTOMLEFT")
	WeeklyResetFrameLeft:SetSize(E.MIN_COLUMN_WIDTH_LEFT*2, E.GLOBAL_LINE_HEIGHT)
	WeeklyResetFrameLeft.Text1 = E.func_CreateStandardText(WeeklyResetFrameLeft)

	WeeklyResetFrameLeft:SetScript("OnShow", HeaderFrameLeft_OnShow)
	local tooltip_WR = {}
	tooltip_WR[#tooltip_WR + 1] = {L["Weekly Reset"]}
	WeeklyResetFrameLeft.tooltip = tooltip_WR
	WeeklyResetFrameLeft:SetScript("OnEnter", function()
			E.SafeTooltipShow(WeeklyResetFrameLeft, {"RIGHT", "LEFT"})
	end)
end
----------------------------------------------------------------