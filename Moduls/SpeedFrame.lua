local GlobalAddonName, E = ...
local LibStub = LibStub
local LibOctopussy = LibStub("LibOctopussy-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--SpeedFrame
tinsert(E.Modules, function()
		local vars = Octo_ToDo_DB_Vars.config.SpeedFrame
		if vars.Shown then
			local SpeedFrame = nil
			if not SpeedFrame then
				SpeedFrame = CreateFrame("Frame", "SpeedFrame", UIParent, "BackdropTemplate")
				f = SpeedFrame
				f:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
				f:SetSize(80, 32)
				-- f:SetBackdrop({
				-- bgFile = E.bgFile,
				-- edgeFile = E.edgeFile,
				-- edgeSize = 1,
				-- })
				-- f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa/4)
				-- f:SetBackdropBorderColor(0, 0, 0, 1/4)
				f:SetClampedToScreen(false)
				f:SetFrameStrata("HIGH")
				f:EnableMouse(true)
				f:SetMovable(true)
				f:RegisterForDrag("LeftButton")
				f:SetScript("OnDragStart", function()
						-- f:SetAlpha(E.bgCa/2)
						f:StartMoving()
						LibCustomGlow.ButtonGlow_Start(f, {.31, 1, .47, 1}, .1)
				end)
				local relativePoint
				f:SetScript("OnDragStop", function()
						-- f:SetAlpha(1)
						f:StopMovingOrSizing()
						local point, _, relativePoint, xOfs, yOfs = f:GetPoint()
						vars.point = point
						vars.relativePoint = relativePoint
						vars.xOfs = LibOctopussy:func_CompactNumberSimple(xOfs)
						vars.yOfs = LibOctopussy:func_CompactNumberSimple(yOfs)
						LibCustomGlow.ButtonGlow_Stop(f)
				end)
				f.text_glide = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				f.text_glide:SetPoint("CENTER", 0, 7)
				f.text_glide:SetFontObject(OctoFont11)
				f.text_glide:SetJustifyV("MIDDLE")
				f.text_glide:SetJustifyH("CENTER")
				f.text_glide:SetTextColor(0, .65, 1, 1)
				f.text_movespeed = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				f.text_movespeed:SetPoint("CENTER", 0, -7)
				f.text_movespeed:SetFontObject(OctoFont12)
				f.text_movespeed:SetJustifyV("MIDDLE")
				f.text_movespeed:SetJustifyH("CENTER")
				f.text_movespeed:SetTextColor(.31, 1, .47, 1)
				C_Timer.NewTicker(.1, function()
						local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
						local base = isGliding and forwardSpeed or GetUnitSpeed("PLAYER")
						local movespeed = base/BASE_MOVEMENT_SPEED*100
						if forwardSpeed > 1 then
							f.text_glide:SetText("glide: ".. LibOctopussy:func_CompactNumberSimple(forwardSpeed))
							f.text_movespeed:SetPoint("CENTER", 0, -7)
						else
							f.text_glide:SetText("")
							f.text_movespeed:SetPoint("CENTER", 0, 0)
						end
						if movespeed ~= 0 then
							f.text_movespeed:SetText(LibOctopussy:func_CompactNumberSimple(movespeed))
						else
							f.text_movespeed:SetText("")
						end
				end)
			end
		end
end)
