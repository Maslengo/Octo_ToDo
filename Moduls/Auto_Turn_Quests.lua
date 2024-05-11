local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.AutoTurnQuests then
			local Octo_AutoTurnInFrame_EventFrame = nil
			function Octo_AutoTurnInOnLoad()
				if not Octo_AutoTurnInFrame_EventFrame then
					Octo_AutoTurnInFrame_EventFrame =
					CreateFrame("FRAME",
						AddonTitle .. E.Octo_Func.GenerateUniqueID())
				end
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_DETAIL")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_COMPLETE")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_GREETING")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("GOSSIP_SHOW")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_PROGRESS")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
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
							for _, info in pairs(C_GossipInfo.GetActiveQuests()) do
								if info.isComplete and
								not C_QuestLog.IsWorldQuest(info.questID) then
									C_GossipInfo.SelectActiveQuest(info.questID)
								end
							end
						end
						if C_GossipInfo.GetAvailableQuests() ~= 0 then
							for _, info in pairs(C_GossipInfo.GetAvailableQuests()) do
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
			Octo_AutoTurnInOnLoad()
			Octo_AutoTurnInFrame_EventFrame:SetScript("OnEvent", OnEvent) -- for function
		end
end)
