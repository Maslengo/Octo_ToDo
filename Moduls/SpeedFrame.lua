local GlobalAddonName, E = ...
local LibStub = LibStub
local LibOctopussy = LibStub("LibOctopussy-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--SpeedFrame
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.config.SpeedFrame then
			local SpeedFrame = nil
			if not SpeedFrame then
				SpeedFrame = CreateFrame("Frame", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), UIParent, "BackdropTemplate")
				f = SpeedFrame
				f:SetPoint("CENTER", 200, -420)
				f:SetSize(80, 32)
				f:SetBackdrop({
						bgFile = E.bgFile,
						edgeFile = E.edgeFile,
						edgeSize = 1
				})
				f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa/4)
				f:SetBackdropBorderColor(0, 0, 0, 1/4)
				f:SetClampedToScreen(false)
				f:SetFrameStrata("HIGH")
				f:EnableMouse(true)
				f:SetMovable(true)
				f:RegisterForDrag("LeftButton")
				f:SetScript("OnDragStart", f.StartMoving)
				f:SetScript("OnDragStop", function() f:StopMovingOrSizing() end)
				-- f.BG = f:CreateTexture(nil, "BACKGROUND")
				-- f.BG:SetHeight(E.curHeight)
				-- f.BG:SetAllPoints()
				-- f.BG:SetColorTexture(0, 0, 0)
				-- f.BG:SetAlpha(0)
				-- LibCustomGlow.ButtonGlow_Start(f, {1,1,1,1}, 1)
				LibCustomGlow.ButtonGlow_Start(f, {1,0,.34,1}, .1)

				f.text_glide = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				f.text_glide:SetPoint("CENTER", 0, 7)
				f.text_glide:SetFontObject(OctoFont11)
				f.text_glide:SetJustifyV("MIDDLE")
				f.text_glide:SetJustifyH("CENTER")
				f.text_glide:SetTextColor(0, .65, 1, 1)

				f.text_movespeed = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				f.text_movespeed:SetPoint("CENTER", 0, -7)
				f.text_movespeed:SetFontObject(OctoFont11)
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
						f.text_movespeed:SetText(LibOctopussy:func_CompactNumberSimple(movespeed))
				end)
			end







		end
end)

