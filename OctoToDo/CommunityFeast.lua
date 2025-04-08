local GlobalAddonName, E = ...
local show = false
----------------------------------------------------------------------------------------------------------------------------------
if show then
	local MainFrame_CommunityFeast = nil
	local EventFrame_CommunityFeast = nil
	if not EventFrame_CommunityFeast then
		EventFrame_CommunityFeast = CreateFrame("Frame")
		EventFrame_CommunityFeast:RegisterEvent("PLAYER_ENTERING_WORLD")
		EventFrame_CommunityFeast:RegisterEvent("QUEST_FINISHED")
		EventFrame_CommunityFeast:RegisterEvent("QUEST_COMPLETE")
		EventFrame_CommunityFeast:RegisterEvent("QUEST_LOG_UPDATE")
		EventFrame_CommunityFeast:RegisterEvent("ZONE_CHANGED")
		EventFrame_CommunityFeast:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	end
	local curWidthTitle = 446
	local AddonHeight = 26
	local reputationID = 2685
	if not MainFrame_CommunityFeast then
		MainFrame_CommunityFeast = CreateFrame("Frame", "MainFrame_CommunityFeast", UIParent, "BackdropTemplate")
	end
	MainFrame_CommunityFeast:Hide()
	MainFrame_CommunityFeast:SetBackdrop({
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	MainFrame_CommunityFeast:SetBackdropBorderColor(0, 0, 0, 1)
	MainFrame_CommunityFeast:SetPoint("TOP",0,-220)
	MainFrame_CommunityFeast:SetFrameStrata("BACKGROUND")
	MainFrame_CommunityFeast:SetSize(curWidthTitle, AddonHeight)
	MainFrame_CommunityFeast.BG = MainFrame_CommunityFeast:CreateTexture()
	MainFrame_CommunityFeast.BG:SetAllPoints(MainFrame_CommunityFeast)
	MainFrame_CommunityFeast.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	MainFrame_CommunityFeast.BG:SetVertexColor(0,0,0,.5)
	MainFrame_CommunityFeast.texture = MainFrame_CommunityFeast:CreateTexture()
	MainFrame_CommunityFeast.texture:SetSize(curWidthTitle, AddonHeight)
	MainFrame_CommunityFeast.texture:SetVertexColor(1,0,0,1)
	MainFrame_CommunityFeast.texture:SetPoint("LEFT", MainFrame_CommunityFeast, "LEFT")
	MainFrame_CommunityFeast.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")

	MainFrame_CommunityFeast.textLEFT = MainFrame_CommunityFeast:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	MainFrame_CommunityFeast.textLEFT:SetPoint("LEFT", MainFrame_CommunityFeast, "LEFT", AddonHeight, 0)
	MainFrame_CommunityFeast.textLEFT:SetFontObject(OctoFont11)
	MainFrame_CommunityFeast.textLEFT:SetJustifyV("MIDDLE")
	MainFrame_CommunityFeast.textLEFT:SetJustifyH("LEFT")
	MainFrame_CommunityFeast.textLEFT:SetTextColor(1, 1, 1, 1)




	local function OnEvent(self, event, ...)
		MainFrame_CommunityFeast:Show()

		-- local FIRST = barValue         -- objectives[1].numFulfilled
		-- local SECOND = barMax        -- objectives[1].numRequired
		local FIRST = select(1, E.func_CheckRepCURSTANDING(reputationID))
		local SECOND = select(2, E.func_CheckRepCURSTANDING(reputationID))
		if FIRST == 0 then
			MainFrame_CommunityFeast.texture:SetWidth(.1)
		elseif FIRST == SECOND then
			MainFrame_CommunityFeast.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
			MainFrame_CommunityFeast.texture:SetVertexColor(0,1,0,1)
		elseif FIRST >= 1 then
			MainFrame_CommunityFeast.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
		end
		MainFrame_CommunityFeast.textLEFT:SetText(E.func_reputationName(reputationID))
	end
	EventFrame_CommunityFeast:SetScript("OnEvent", OnEvent)
end