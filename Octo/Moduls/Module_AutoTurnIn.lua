local GlobalAddonName, E = ... 

local Octo_EventFrame_AutoTurnIn = CreateFrame("Frame")
Octo_EventFrame_AutoTurnIn:Hide()

local events = {
	"QUEST_DETAIL",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
}

E.RegisterMyEventsToFrames(Octo_EventFrame_AutoTurnIn, events)

function Octo_EventFrame_AutoTurnIn:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:ItemsUsableFrame()
	end
end

function Octo_EventFrame_AutoTurnIn:ShouldProcess()
	return not IsShiftKeyDown()
end

function Octo_EventFrame_AutoTurnIn:QUEST_DETAIL()
	if self:ShouldProcess() then
		if QuestIsFromAreaTrigger() then
			AcceptQuest()
		elseif QuestGetAutoAccept() then
			AcknowledgeAutoAcceptQuest()
		end
		AcceptQuest()
	end
end

function Octo_EventFrame_AutoTurnIn:QUEST_COMPLETE()
	if self:ShouldProcess() and GetNumQuestChoices() <= 1 then
		GetQuestReward(1)
	end
end

function Octo_EventFrame_AutoTurnIn:ProcessActiveQuests()
	for i = 1, GetNumActiveQuests() do
		local _, isComplete = GetActiveTitle(i)
		local questID = GetActiveQuestID(i)
		if questID and isComplete and not C_QuestLog.IsWorldQuest(questID) then
			C_GossipInfo.SelectActiveQuest(i)
		end
	end
end

function Octo_EventFrame_AutoTurnIn:ProcessAvailableQuests()
	for i = 1, GetNumAvailableQuests() do
		local isTrivial, _, isRepeatable = GetAvailableQuestInfo(i)
		if not (isTrivial and isRepeatable) then
			SelectAvailableQuest(i)
		end
	end
end

function Octo_EventFrame_AutoTurnIn:QUEST_GREETING()
	if self:ShouldProcess() then
		self:ProcessActiveQuests()
		self:ProcessAvailableQuests()
	end
end

function Octo_EventFrame_AutoTurnIn:GOSSIP_SHOW()
	if not self:ShouldProcess() then return end

	for _, info in ipairs(C_GossipInfo.GetActiveQuests() or {}) do
		if info.isComplete and not C_QuestLog.IsWorldQuest(info.questID) then
			C_GossipInfo.SelectActiveQuest(info.questID)
		end
	end

	for _, info in ipairs(C_GossipInfo.GetAvailableQuests() or {}) do
		C_GossipInfo.SelectAvailableQuest(info.questID)
	end
end

function Octo_EventFrame_AutoTurnIn:QUEST_PROGRESS()
	if self:ShouldProcess() then
		CompleteQuest()
	end
end