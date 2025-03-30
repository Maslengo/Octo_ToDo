local GlobalAddonName, E = ...
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--SpeedFrame
tinsert(E.Modules, function()
		local vars = OctoToDo_DB_Vars.SpeedFrame
		if vars.Shown then
			local SpeedFrame = nil
			if not SpeedFrame then
				SpeedFrame = CreateFrame("Frame", "SpeedFrame", UIParent, "BackdropTemplate")
				local f = SpeedFrame
				SpeedFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
				SpeedFrame:SetSize(80, 32)
				-- SpeedFrame:SetBackdrop({
				-- bgFile = E.bgFile,
				-- edgeFile = E.edgeFile,
				-- edgeSize = 1,
				-- })
				-- SpeedFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa/4)
				-- SpeedFrame:SetBackdropBorderColor(0, 0, 0, 1/4)
				SpeedFrame:SetClampedToScreen(false)
				SpeedFrame:SetFrameStrata("HIGH")
				SpeedFrame:EnableMouse(true)
				SpeedFrame:SetMovable(true)
				SpeedFrame:RegisterForDrag("LeftButton")
				SpeedFrame:SetScript("OnDragStart", function()
						-- SpeedFrame:SetAlpha(E.bgCa)
						SpeedFrame:StartMoving()
						LibCustomGlow.ButtonGlow_Start(SpeedFrame, {.31, 1, .47, 1}, .1)
				end)
				local relativePoint
				SpeedFrame:SetScript("OnDragStop", function()
						-- SpeedFrame:SetAlpha(1)
						SpeedFrame:StopMovingOrSizing()
						local point, _, relativePoint, xOfs, yOfs = SpeedFrame:GetPoint()
						vars.point = point
						vars.relativePoint = relativePoint
						vars.xOfs = E.func_CompactNumberSimple(xOfs)
						vars.yOfs = E.func_CompactNumberSimple(yOfs)
						LibCustomGlow.ButtonGlow_Stop(SpeedFrame)
				end)
				SpeedFrame.text_glide = SpeedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				SpeedFrame.text_glide:SetPoint("CENTER", 0, 7)
				SpeedFrame.text_glide:SetFontObject(OctoFont11)
				SpeedFrame.text_glide:SetJustifyV("MIDDLE")
				SpeedFrame.text_glide:SetJustifyH("CENTER")
				SpeedFrame.text_glide:SetTextColor(0, .65, 1, 1)
				SpeedFrame.text_movespeed = SpeedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				SpeedFrame.text_movespeed:SetPoint("CENTER", 0, -7)
				SpeedFrame.text_movespeed:SetFontObject(OctoFont12)
				SpeedFrame.text_movespeed:SetJustifyV("MIDDLE")
				SpeedFrame.text_movespeed:SetJustifyH("CENTER")
				SpeedFrame.text_movespeed:SetTextColor(.31, 1, .47, 1)
				C_Timer.NewTicker(.1, function()
						local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
						local base = isGliding and forwardSpeed or GetUnitSpeed("PLAYER")
						local movespeed = base/BASE_MOVEMENT_SPEED*100
						if forwardSpeed > 1 then
							SpeedFrame.text_glide:SetText("glide: ".. E.func_CompactNumberSimple(forwardSpeed))
							SpeedFrame.text_movespeed:SetPoint("CENTER", 0, -7)
						else
							SpeedFrame.text_glide:SetText("")
							SpeedFrame.text_movespeed:SetPoint("CENTER", 0, 0)
						end
						if movespeed ~= 0 then
							SpeedFrame.text_movespeed:SetText(E.func_CompactNumberSimple(movespeed))
							-- SpeedFrame.text_movespeed:SetText(E.func_CompactNumberSimple(movespeed)/4.347826086956522) -- КМ\Ч
						else
							SpeedFrame.text_movespeed:SetText("")
						end
				end)
			end
		end
end)
