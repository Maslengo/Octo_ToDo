local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Turn_Quests
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.config.AutoTurnQuests then
			local OctoToDo_AutoTurnInFrame_EventFrame = nil
			function OctoToDo_AutoTurnInOnLoad()
				if not OctoToDo_AutoTurnInFrame_EventFrame then
					OctoToDo_AutoTurnInFrame_EventFrame = CreateFrame("FRAME", GlobalAddonName.."Auto_Turn_Quests"..E.func_GenerateUniqueID())
				end
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_DETAIL")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_COMPLETE")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_GREETING")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("GOSSIP_SHOW")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_PROGRESS")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
				OctoToDo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
			end
			local function OnEvent(self, event, ...)
				if event == "QUEST_DETAIL" then
					if not IsShiftKeyDown() then
						if QuestIsFromAreaTrigger() then
							AcceptQuest()
						elseif QuestGetAutoAccept() then
							AcknowledgeAutoAcceptQuest()
						end
						AcceptQuest()
					end
				elseif event == "QUEST_COMPLETE" then
					if not IsShiftKeyDown() then
						if GetNumQuestChoices() <= 1 then
							GetQuestReward(1)
						end
					end
				elseif event == "QUEST_GREETING" then
					if not IsShiftKeyDown() then
						for i = 1, GetNumActiveQuests() do
							local _, isComplete = GetActiveTitle(i)
							if isComplete and
							not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
								SelectActiveQuest(i)
							end
						end
						for i = 1, GetNumAvailableQuests() do
							local isTrivial, _, isRepeatable, _, questID =
							GetAvailableQuestInfo(i)
							if isTrivial and isRepeatable then
								return
							else
								SelectAvailableQuest(i)
							end
						end
					end
				elseif event == "GOSSIP_SHOW" then
					if not IsShiftKeyDown() then
						if C_GossipInfo.GetActiveQuests() ~= 0 then
							for _, info in next, (C_GossipInfo.GetActiveQuests()) do
								if info.isComplete and
								not C_QuestLog.IsWorldQuest(info.questID) then
									C_GossipInfo.SelectActiveQuest(info.questID)
								end
							end
						end
						if C_GossipInfo.GetAvailableQuests() ~= 0 then
							for _, info in next, (C_GossipInfo.GetAvailableQuests()) do
								if info.isTrivial and info.repeatable then
									return
								else
									C_GossipInfo.SelectAvailableQuest(info.questID)
								end
							end
						end
					end
				elseif event == "QUEST_PROGRESS" then
					if not IsShiftKeyDown() then CompleteQuest() end
				end
			end
			OctoToDo_AutoTurnInOnLoad()
			OctoToDo_AutoTurnInFrame_EventFrame:SetScript("OnEvent", OnEvent)
		end
end)
