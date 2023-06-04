local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local Version = GetAddOnMetadata(GlobalAddonName, "Version")
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
--------------------------------------------------------------------------------
local Loot_Frame = CreateFrame("Button", AddonTitle..GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
Loot_Frame:Hide()
Loot_Frame:SetSize(12*scale, 12*scale)
Loot_Frame:SetPoint("TOPLEFT", 64, 0)
Loot_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
Loot_Frame:SetBackdropBorderColor(0, 0, 0, 1)
Loot_Frame:RegisterForClicks("LeftButtonUp")
local texture = Loot_Frame:CreateTexture(nil, "BACKGROUND")
Loot_Frame.icon = texture
texture:SetAllPoints(Loot_Frame)
texture:SetTexture(413587)
Loot_Frame:Show()
Loot_Frame:SetScript("OnClick",
function(_, button)
GroupLootHistoryFrame:SetShown(not GroupLootHistoryFrame:IsShown())
end)