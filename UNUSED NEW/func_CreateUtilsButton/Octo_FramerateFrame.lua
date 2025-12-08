
function EventFrame:Octo_FramerateFrame(frame)
	if not utilityFrames.framerate then
		local Octo_FramerateFrame = CreateFrame("Frame", nil, UIParent)
		Octo_FramerateFrame:Hide()
		Octo_FramerateFrame:SetSize(WIDTH*4, HEIGHT)
		Octo_FramerateFrame:SetFrameStrata("HIGH")
		Octo_FramerateFrame.text = Octo_FramerateFrame:CreateFontString()
		Octo_FramerateFrame.text:SetFontObject(OctoFont11)
		Octo_FramerateFrame.text:SetAllPoints()
		Octo_FramerateFrame.text:SetJustifyH("RIGHT")
		Octo_FramerateFrame.ticker = nil
		Octo_FramerateFrame.isTickerActive = false
		local function UpdateFPS()
			-- local FPS = math.floor(GetFramerate() * 10) / 10
			local FPS = math.floor(GetFramerate())
			if FPS >= 144 then
				Octo_FramerateFrame.text:SetTextColor(0, 1, 1, 1)
			elseif FPS >= 60 then
				Octo_FramerateFrame.text:SetTextColor(0.31, 1, 0.47, 1)
			else
				Octo_FramerateFrame.text:SetTextColor(1, 0, 0, 1)
			end
			Octo_FramerateFrame.text:SetText(FPS)
		end
		local function StartTicker()
			if not Octo_FramerateFrame.isTickerActive then
				Octo_FramerateFrame.ticker = C_Timer.NewTicker(.4, UpdateFPS)
				Octo_FramerateFrame.isTickerActive = true
			end
		end
		local function StopTicker()
			if Octo_FramerateFrame.isTickerActive and Octo_FramerateFrame.ticker then
				Octo_FramerateFrame.ticker:Cancel()
				Octo_FramerateFrame.ticker = nil
				Octo_FramerateFrame.isTickerActive = false
			end
		end
		Octo_FramerateFrame:SetScript("OnShow", StartTicker)
		Octo_FramerateFrame:SetScript("OnHide", StopTicker)
		if Octo_FramerateFrame:IsShown() then
			StartTicker()
		end
		utilityFrames.framerate = Octo_FramerateFrame
	end
end