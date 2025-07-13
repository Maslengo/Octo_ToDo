local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

-- SpeedFrame
tinsert(E.Modules, function()
	local vars = Octo_ToDo_DB_Vars.SpeedFrame
	if not vars.Shown then return end

	local SpeedFrame = CreateFrame("Frame", "SpeedFrame", UIParent, "BackdropTemplate")
	local f = SpeedFrame

	-- Frame setup
	f:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
	f:SetSize(80, 32)
	f:SetClampedToScreen(false)
	f:SetFrameStrata("HIGH")
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")

	-- Drag handlers
	f:SetScript("OnDragStart", function()
		f:StartMoving()
		LibCustomGlow.ButtonGlow_Start(f, {.31, 1, .47, 1}, .1)
	end)

	f:SetScript("OnDragStop", function()
		f:StopMovingOrSizing()
		local point, _, relativePoint, xOfs, yOfs = f:GetPoint()
		vars.point = point
		vars.relativePoint = relativePoint
		vars.xOfs = E.func_CompactNumberSimple(xOfs)
		vars.yOfs = E.func_CompactNumberSimple(yOfs)
		LibCustomGlow.ButtonGlow_Stop(f)
	end)

	-- Text elements
	local text_glide = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text_glide:SetPoint("CENTER", 0, 7)
	text_glide:SetFontObject(OctoFont11)
	text_glide:SetJustifyV("MIDDLE")
	text_glide:SetJustifyH("CENTER")
	text_glide:SetTextColor(0, 0.65, 1, 1)

	local text_movespeed = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text_movespeed:SetPoint("CENTER", 0, -7)
	text_movespeed:SetFontObject(OctoFont12)
	text_movespeed:SetJustifyV("MIDDLE")
	text_movespeed:SetJustifyH("CENTER")
	text_movespeed:SetTextColor(0.31, 1, 0.47, 1)

	-- Update ticker
	C_Timer.NewTicker(0.1, function()
		local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
		local base = isGliding and forwardSpeed or GetUnitSpeed("PLAYER")
		local movespeed = base / BASE_MOVEMENT_SPEED * 100

		if forwardSpeed > 1 then
			text_glide:SetText("glide: ".. E.func_CompactNumberSimple(forwardSpeed))
			text_movespeed:SetPoint("CENTER", 0, -7)
		else
			text_glide:SetText("")
			text_movespeed:SetPoint("CENTER", 0, 0)
		end

		text_movespeed:SetText(movespeed ~= 0 and E.func_CompactNumberSimple(movespeed) or "")
	end)
end)