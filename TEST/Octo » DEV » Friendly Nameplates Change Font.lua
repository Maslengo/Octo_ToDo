local font, height, flags = aura_env.region.text:GetFont()
local sr, sg, sb, sa = aura_env.region.text:GetShadowColor()
local sx, sy = aura_env.region.text:GetShadowOffset()
local function SetFont(obj, optSize)
    obj:SetFont(font, optSize, flags)
    -- obj:SetTextColor(1, 0, 0, 1)
    obj:SetShadowColor(sr, sg, sb, sa)
    obj:SetShadowOffset(sx, sy)
end
local function ModifyCVars()
    SetCVar("nameplateShowOnlyNames", 1)
    SetCVar("nameplateShowFriends", 1)
    SetCVar("nameplateVerticalScale", 1)
end
ModifyCVars()
SetFont(SystemFont_NamePlateFixed, height)

