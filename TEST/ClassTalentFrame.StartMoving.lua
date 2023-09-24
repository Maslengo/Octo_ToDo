--if not aura_env.xyi then
--aura_env.xyi = true

local Config = aura_env.config
local function scale()
    ClassTalentFrame:SetScale(Config["FrameScale"])
    ClassTalentFrame:SetMovable(Config["FrameMoveable"])
    ClassTalentFrame:EnableMouse(true)
    ClassTalentFrame:SetClampedToScreen(false)
    ClassTalentFrame:RegisterForDrag("LeftButton")
    ClassTalentFrame:SetScript("OnDragStart", ClassTalentFrame.StartMoving)
    ClassTalentFrame:SetScript("OnDragStop", ClassTalentFrame.StopMovingOrSizing)
    --ClassTalentFrame.Blackout:EnableMouse(false)
end

EventRegistry:RegisterCallback("TalentFrame.OpenFrame", scale)
--end

--TalentsTab

