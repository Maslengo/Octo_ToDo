local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
--AutoTurnQuests
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoTurnQuests then
			-- print (AddonTitle.." ".."AutoTurnIn |CFFFF0000ВКЛЮЧЕН|r")
			local Octo_AutoTurnInFrame_EventFrame = nil
			function Octo_AutoTurnInOnLoad()
				if not Octo_AutoTurnInFrame_EventFrame then
					Octo_AutoTurnInFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
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
						-- print (AddonTitle.." "..event)
						if QuestIsFromAreaTrigger() then
							AcceptQuest()
						elseif QuestGetAutoAccept() then
							AcknowledgeAutoAcceptQuest()
						end
						AcceptQuest()
					end
				elseif event == "QUEST_COMPLETE" then
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						if GetNumQuestChoices() <= 1 then
							GetQuestReward(1)
						else
							-- print ("ДОХЪУ")
						end
					end
				elseif event == "QUEST_GREETING" then -- Запускается при разговоре с NPC, который предлагает или принимает более одного квеста, т. е. имеет более одного активного или доступного квеста.
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						-- turn in all completed quests
						for i = 1, GetNumActiveQuests() do
							local _, isComplete = GetActiveTitle(i)
							if isComplete and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
								SelectActiveQuest(i)
							end
						end
						-- accept all available quests
						for i = 1, GetNumAvailableQuests() do
							local isTrivial, _, isRepeatable, _, questID = GetAvailableQuestInfo(i)
							--if (not isTrivial or isTrackingTrivialQuests()) and (not isRepeatable --[[or addon.db.profile.general.acceptRepeatables]]) then
							if (isTrivial and Octo_ToDoVars.config.TrivialQuests == false) and (isRepeatable and Octo_ToDoVars.config.RepeatableQuests == false) then
								return
							else
								SelectAvailableQuest(i)
							end
						end
					end
				elseif event == "GOSSIP_SHOW" then
					if not IsShiftKeyDown() --[[and not ignore_list_NPC[targetNPCID] then]] then
						-- turn in all completed quests
						if C_GossipInfo.GetActiveQuests() ~= 0 then
							for _, info in pairs(C_GossipInfo.GetActiveQuests()) do
								if info.isComplete and not C_QuestLog.IsWorldQuest(info.questID) then
									C_GossipInfo.SelectActiveQuest(info.questID)
								end
							end
						end
						-- accept all available quests
						if C_GossipInfo.GetAvailableQuests() ~= 0 then
							for _, info in pairs(C_GossipInfo.GetAvailableQuests()) do
								-- print (info.title, info.questLevel, info.repeatable, info.frequency, info.isIgnored, info.isLegendary)
								-- if (not info.isTrivial --[[or isTrackingTrivialQuests()]]) and (not info.repeatable --[[or addon.db.profile.general.acceptRepeatables]]) then
								if (info.isTrivial and Octo_ToDoVars.config.TrivialQuests == false) and (info.repeatable and Octo_ToDoVars.config.RepeatableQuests == false) then
									return
								else
									C_GossipInfo.SelectAvailableQuest(info.questID)
								end
							end
						end
					end
				elseif event == "QUEST_PROGRESS" then
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						CompleteQuest()
						-- elseif event == "QUEST_LOG_UPDATE" then
						-- print (AddonTitle.." "..event)
						-- elseif event == "QUEST_ACCEPTED" then
						-- print (AddonTitle.." "..event)
					end
				end
			end
			Octo_AutoTurnInOnLoad()
			Octo_AutoTurnInFrame_EventFrame:SetScript("OnEvent", OnEvent) --for function
		end
end)