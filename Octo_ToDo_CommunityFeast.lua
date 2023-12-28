local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
local Frame_CommunityFeast = nil
local EventFrame = nil
if not EventFrame then
	EventFrame = CreateFrame("Frame")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("QUEST_FINISHED")
	EventFrame:RegisterEvent("QUEST_COMPLETE")
	EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	EventFrame:RegisterEvent("ZONE_CHANGED")
	EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end
local Width = 446*E.Octo_Globals.scale
local Height = 26*E.Octo_Globals.scale
local questID = 70893
local mapID = 2024
if not Frame_CommunityFeast then
	Frame_CommunityFeast = CreateFrame("Frame", GlobalAddonName..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
end
Frame_CommunityFeast:Hide()
Frame_CommunityFeast:SetBackdrop({
		edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		edgeSize = 1,
})
Frame_CommunityFeast:SetBackdropBorderColor(0, 0, 0, 1)
Frame_CommunityFeast:SetPoint("TOP",0,-220)
Frame_CommunityFeast:SetFrameStrata("BACKGROUND")
Frame_CommunityFeast:SetSize(Width, Height)
Frame_CommunityFeast.BG = Frame_CommunityFeast:CreateTexture()
Frame_CommunityFeast.BG:SetAllPoints(Frame_CommunityFeast)
Frame_CommunityFeast.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
Frame_CommunityFeast.BG:SetVertexColor(0,0,0,.5)
Frame_CommunityFeast.texture = Frame_CommunityFeast:CreateTexture()
Frame_CommunityFeast.texture:SetSize(Width, Height)
Frame_CommunityFeast.texture:SetVertexColor(1,0,0,1)
Frame_CommunityFeast.texture:SetPoint("LEFT", Frame_CommunityFeast, "LEFT")
Frame_CommunityFeast.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
local function OnEvent(self, event, ...)
	local curMapID = C_Map.GetBestMapForUnit("player") or 0
	if curMapID == mapID and C_QuestLog.IsOnQuest(questID) == true then
		Frame_CommunityFeast:Show()
		local objectives = C_QuestLog.GetQuestObjectives(questID)
		if objectives[1].numFulfilled == 0 then
			Frame_CommunityFeast.texture:SetWidth(.1)
		elseif objectives[1].numFulfilled == objectives[1].numRequired then
			Frame_CommunityFeast.texture:SetWidth((Width/objectives[1].numRequired)*objectives[1].numFulfilled)
			Frame_CommunityFeast.texture:SetVertexColor(0,1,0,1)
		elseif objectives[1].numFulfilled >= 1 then
			Frame_CommunityFeast.texture:SetWidth((Width/objectives[1].numRequired)*objectives[1].numFulfilled)
		end
	else
		Frame_CommunityFeast:Hide()
	end
end
EventFrame:SetScript("OnEvent", OnEvent)

