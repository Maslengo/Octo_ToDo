local Octo_AUTO_ACCEPT_QUEST = CreateFrame("Frame", AddonTitle)
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_GREETING")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("GOSSIP_SHOW")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_DETAIL")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_PROGRESS")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_COMPLETE")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_LOG_UPDATE")
Octo_AUTO_ACCEPT_QUEST:RegisterEvent("QUEST_ACCEPTED")
Octo_AUTO_ACCEPT_QUEST:SetScript("OnEvent", function(self, event, ...)
    if not IsShiftKeyDown() and (GossipFrame:IsShown() or QuestFrame:IsShown()) then
        --QuestFrameAcceptButton
        AcceptQuest()
        --CompleteQuest()
    end
end)
-- QUEST_DETAIL
-- PLAYER_SOFT_INTERACT_CHANGED
-- QUEST_FINISHED
-- PLAYER_INTERACTION_MANAGER_FRAME_HIDE

                            -- 1 rewards table: 000001F553BA35F0 
                            -- 1 flags 0 
                            -- 1 gossipOptionID 42453 
                            -- 1 name Мне бы хотелось купить что-нибудь у тебя. 
                            -- 1 status 0 
                            -- 1 orderIndex 1 
                            -- 1 icon 132060 
                            -- 1 selectOptionWhenOnlyOption true 