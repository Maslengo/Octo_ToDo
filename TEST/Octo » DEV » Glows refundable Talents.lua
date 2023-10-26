aura_env.LCG = LibStub("LibCustomGlow-1.0")

local aura_env = aura_env
aura_env.last = GetTime()
hooksecurefunc(TalentDisplayMixin, "FullUpdate",
    function() if aura_env.last < GetTime() then
            C_Timer.After(0.1, function() WeakAuras.ScanEvents("CAUSESE_UPDATE_TALENTS") end)
            aura_env.last = GetTime()
        end
end)

------------------------
CAUSESE_UPDATE_TALENTS
-------------------------
function()
    if ClassTalentFrame and not WeakAuras.IsOptionsOpen() then
        local config = C_Traits.GetConfigInfo(C_ClassTalents.GetActiveConfigID())
        for _, treeID in pairs(config.treeIDs) do
            local nodes = C_Traits.GetTreeNodes(treeID)
            for _, nodeID in pairs(nodes) do
                local configID = C_ClassTalents.GetActiveConfigID()
                if configID then
                    local nodeFrame = ClassTalentFrame.TalentsTab.nodeIDToButton[nodeID]
                    if nodeFrame then
                        local canRefund = C_Traits.CanRefundRank(configID, nodeID)
                        if canRefund then
                            local glowType = aura_env.config.glowType
                            if glowType == 1 then
                                aura_env.LCG.AutoCastGlow_Stop(nodeFrame)
                                aura_env.LCG.PixelGlow_Stop(nodeFrame)
                                aura_env.LCG.ButtonGlow_Start(nodeFrame, aura_env.config.color, nil)
                            elseif glowType == 2 then
                                aura_env.LCG.ButtonGlow_Stop(nodeFrame)
                                aura_env.LCG.AutoCastGlow_Stop(nodeFrame)
                                aura_env.LCG.PixelGlow_Start(nodeFrame, aura_env.config.color, nil)
                            elseif glowType == 3 then
                                aura_env.LCG.PixelGlow_Stop(nodeFrame)
                                aura_env.LCG.ButtonGlow_Stop(nodeFrame)
                                aura_env.LCG.AutoCastGlow_Start(nodeFrame, aura_env.config.color, nil)
                            end
                        else
                            aura_env.LCG.PixelGlow_Stop(nodeFrame)
                            aura_env.LCG.ButtonGlow_Stop(nodeFrame)
                            aura_env.LCG.AutoCastGlow_Stop(nodeFrame)
                        end
                    end
                end
            end
        end
    end
end

