local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local bytetoB64 = {
	[0]="a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")"
}
function GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
local EventFrame = nil
do
	local EventFrame = CreateFrame("FRAME", AddonTitle..GenerateUniqueID())
	EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("ZONE_CHANGED")
	EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	EventFrame:SetScript("OnEvent", function(...) Loot_Frame_OnEvent(...) end)
end
local normal_difficulty = 14
local heroic_difficulty = 15
local mythic_difficulty = 16
local LFG_difficulty = 17
-- https://wowpedia.fandom.com/wiki/DifficultyID
--------------------------------------------------------------------------------
local Loot_Frame = CreateFrame("Button", AddonTitle..GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
Loot_Frame:Hide()
Loot_Frame:SetSize(24*scale, 24*scale)
Loot_Frame:SetPoint("TOPLEFT", 64, 0)
Loot_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
Loot_Frame:SetBackdropBorderColor(0, 0, 0, 1)
Loot_Frame:RegisterForClicks("LeftButtonUp")
local texture = Loot_Frame:CreateTexture(nil, "BACKGROUND")
Loot_Frame.icon = texture
texture:SetAllPoints(Loot_Frame)
texture:SetTexture(413587)
Loot_Frame:Hide()
Loot_Frame:SetScript("OnClick",
	function(_, button)
		GroupLootHistoryFrame:SetShown(not GroupLootHistoryFrame:IsShown())
end)
--if select(5, GetAddOnInfo("RCLootCouncil")) ~= "DISABLED" then
local RC_Frame = CreateFrame("Button", AddonTitle..GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
RC_Frame:Hide()
RC_Frame:SetSize(24*scale, 24*scale)
RC_Frame:SetPoint("TOPLEFT", 128, 0)
RC_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
RC_Frame:SetBackdropBorderColor(0, 0, 0, 1)
RC_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
local texture = RC_Frame:CreateTexture(nil, "BACKGROUND")
RC_Frame.icon = texture
texture:SetAllPoints(RC_Frame)
texture:SetTexture(133785)
RC_Frame:Hide()
RC_Frame:SetAttribute("type", "macro")
RC_Frame:SetAttribute("macrotext", "/rc open")
function Loot_Frame_OnEvent(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
		if difficultyID == 14 or difficultyID == 15 or difficultyID == 16 or difficultyID == 17 then
			if select(5, GetAddOnInfo("RCLootCouncil")) ~= "DISABLED" and RC_Frame then
				RC_Frame:Show()
			end
			Loot_Frame:Show()
		end
		if (difficultyID ~= 14 and difficultyID ~= 15 and difficultyID ~= 16 and difficultyID ~= 17) then
			if select(5, GetAddOnInfo("RCLootCouncil")) ~= "DISABLED" and RC_Frame then
				RC_Frame:Hide()
			end
			Loot_Frame:Hide()
		end
	end
end