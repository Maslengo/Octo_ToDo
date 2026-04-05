local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local Octo_MeasureFrame = CreateFrame("FRAME", "Octo_MeasureFrame", UIParent)
Octo_MeasureFrame:Hide()
Octo_MeasureFrame:SetScale(UIParent:GetEffectiveScale())
----------------------------------------------------------------
Octo_MeasureFrame.measureText = Octo_MeasureFrame:CreateFontString()
Octo_MeasureFrame.measureText:SetFontObject(OctoFont11)
Octo_MeasureFrame.measureText:SetWordWrap(false)
----------------------------------------------------------------