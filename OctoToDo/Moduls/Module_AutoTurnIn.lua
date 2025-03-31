local GlobalAddonName, E = ... 
----------------------------------------------------------------
local OctoToDo_EventFrame_AutoTurnIn = CreateFrame("Frame")
OctoToDo_EventFrame_AutoTurnIn:Hide()
----------------------------------------------------------------
local collectTrivial = false
local collectRepeatable = false
----------------------------------------------------------------
local MyEventsTable = {
	-- "ADDON_LOADED",
	"QUEST_DETAIL",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
	"QUEST_LOG_UPDATE",
	"QUEST_ACCEPTED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_AutoTurnIn, MyEventsTable, E.func_DebugPath())

function OctoToDo_EventFrame_AutoTurnIn:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:ItemsUsableFrame()
	end
end

function OctoToDo_EventFrame_AutoTurnIn:QUEST_DETAIL()
	if not IsShiftKeyDown() then
		if QuestIsFromAreaTrigger() then
			AcceptQuest()
		elseif QuestGetAutoAccept() then
			AcknowledgeAutoAcceptQuest()
		end
		AcceptQuest()
	end
end

function OctoToDo_EventFrame_AutoTurnIn:QUEST_COMPLETE()
	if not IsShiftKeyDown() then
		if GetNumQuestChoices() <= 1 then
			GetQuestReward(1)
		end
	end
end

function OctoToDo_EventFrame_AutoTurnIn:QUEST_GREETING()
	if not IsShiftKeyDown() then
		for i = 1, GetNumActiveQuests() do
			local _, isComplete = GetActiveTitle(i)
			if isComplete and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
				C_GossipInfo.SelectActiveQuest(i)
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
end

function OctoToDo_EventFrame_AutoTurnIn:GOSSIP_SHOW()
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
				if (collectTrivial == info.isTrivial) or (collectRepeatable == info.collectRepeatable) then
					print ("QWE")
					C_GossipInfo.SelectAvailableQuest(info.questID)
				else
					print ("222")
					C_GossipInfo.SelectAvailableQuest(info.questID)
				end
			end
		end
	end
end

function OctoToDo_EventFrame_AutoTurnIn:QUEST_PROGRESS()
	if not IsShiftKeyDown() then
		CompleteQuest()
	end
end