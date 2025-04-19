local GlobalAddonName, E = ...
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--PosFrame
tinsert(E.Modules, function()
		local vars = Octo_ToDo_DB_Vars.PosFrame
		if vars.Shown then
			local PosFrame = nil
			if not PosFrame then
				PosFrame = CreateFrame("Frame", "PosFrame", UIParent, "BackdropTemplate")
				local f = PosFrame
				PosFrame:SetPoint(vars.point, nil, vars.relativePoint, vars.xOfs, vars.yOfs)
				PosFrame:SetSize(280, 32)
				PosFrame:SetClampedToScreen(false)
				PosFrame:SetFrameStrata("HIGH")
				PosFrame:EnableMouse(true)
				PosFrame:SetMovable(true)
				PosFrame:RegisterForDrag("LeftButton")
				PosFrame:SetScript("OnDragStart", function()
						PosFrame:StartMoving()
						LibCustomGlow.ButtonGlow_Start(PosFrame, {.31, 1, .47, 1}, .1)
				end)
				local relativePoint
				PosFrame:SetScript("OnDragStop", function()
						PosFrame:StopMovingOrSizing()
						local point, _, relativePoint, xOfs, yOfs = PosFrame:GetPoint()
						vars.point = point
						vars.relativePoint = relativePoint
						vars.xOfs = E.func_CompactNumberSimple(xOfs)
						vars.yOfs = E.func_CompactNumberSimple(yOfs)
						LibCustomGlow.ButtonGlow_Stop(PosFrame)
				end)
				PosFrame.text_cursor = PosFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				PosFrame.text_cursor:SetPoint("CENTER", 0, 7)
				PosFrame.text_cursor:SetFontObject(OctoFont11)
				PosFrame.text_cursor:SetJustifyV("MIDDLE")
				PosFrame.text_cursor:SetJustifyH("CENTER")
				PosFrame.text_cursor:SetTextColor(0, .65, 1, 1)
				PosFrame.text_playerpos = PosFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				PosFrame.text_playerpos:SetPoint("CENTER", 0, -7)
				PosFrame.text_playerpos:SetFontObject(OctoFont11)
				PosFrame.text_playerpos:SetJustifyV("MIDDLE")
				PosFrame.text_playerpos:SetJustifyH("CENTER")
				PosFrame.text_playerpos:SetTextColor(.31, 1, .47, 1)
				C_Timer.NewTicker(.1, function()
						local map = C_Map.GetBestMapForUnit("PLAYER") or 0
						if map ~= 0 then
							local pos = C_Map.GetPlayerMapPosition(map, "PLAYER")
							if pos then
								local posX, posY = pos:GetXY()
								posX = string.format("%.1f", posX*100)
								posY = string.format("%.1f", posY*100)
								local x, y
								if WorldMapFrame:IsShown() then
									x, y = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
									x = string.format("%.1f", x*100)
									y = string.format("%.1f", y*100)
									if tonumber(x) <= 0 or
									tonumber(x) >= 100 or
									tonumber(y) <= 0 or
									tonumber(y) >= 100  then
										x, y = ""
									end
								end
								--return posX, posY, x, comma, y
								if x and y  then
									PosFrame.text_cursor:SetText((x or 0).." / "..(y or 0))
									PosFrame.text_playerpos:SetPoint("CENTER", 0, -7)
								else
									PosFrame.text_cursor:SetText("")
									PosFrame.text_playerpos:SetPoint("CENTER", 0, 0)
								end
								if posX and posY then
									PosFrame.text_playerpos:SetText((posX or 0).." / "..(posY or 0))
								else
									PosFrame.text_playerpos:SetText("")
								end
							end
						end
				end)
			end
		end
end)

