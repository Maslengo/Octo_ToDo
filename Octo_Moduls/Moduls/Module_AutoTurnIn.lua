local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local EventFrame = CreateFrame("Frame")
----------------------------------------------------------------
function EventFrame:Module_AutoTurnIn()
	local NumActiveQuests = 0
	if GetNumActiveQuests() ~= 0 then
		NumActiveQuests = GetNumActiveQuests()
	elseif C_GossipInfo.GetActiveQuests() and #C_GossipInfo.GetActiveQuests() ~= 0 then
		NumActiveQuests = #C_GossipInfo.GetActiveQuests()
	elseif C_GossipInfo.GetNumActiveQuests() ~= 0 then
		NumActiveQuests = C_GossipInfo.GetNumActiveQuests()
	end
	local NumAvailableQuests = 0
	if GetNumAvailableQuests() ~= 0 then
		NumAvailableQuests = GetNumAvailableQuests()
	elseif C_GossipInfo.GetNumAvailableQuests() ~= 0 then
		NumAvailableQuests = C_GossipInfo.GetNumAvailableQuests()
	end
	local ActiveQuests = C_GossipInfo.GetActiveQuests() or {}
	-- local AvailableQuests = C_GossipInfo.GetAvailableQuests() or {}
	for i = 1, NumActiveQuests do
		local questID = 0
		if #C_GossipInfo.GetActiveQuests() ~= 0 then
			local info = C_GossipInfo.GetActiveQuests()
			questID = info[i].questID
		elseif GetActiveQuestID(i) ~= 0 then
			questID = GetActiveQuestID(i)
		end
		local IsComplete = IsComplete or C_QuestLog.IsComplete
		-- print (questID, IsComplete(questID))
		if IsComplete(questID) then
			C_GossipInfo.SelectActiveQuest(questID)
			SelectActiveQuest(i)
			-- C_GossipInfo.SelectActiveQuest(questID)
		end
	end
	for i = 1, NumAvailableQuests do
		local info = C_GossipInfo.GetAvailableQuests()
		if info and info[i] then
			local newInfo = info[i]
			local title = newInfo.title
			local questID = newInfo.questID
			if not newInfo.isTrivial then
				C_GossipInfo.SelectAvailableQuest(questID)
			end
		else
			local isTrivial, frequency, isRepeatable, isLegendary, questID = GetAvailableQuestInfo(i)
			if not (isTrivial and isRepeatable) then
				-- print ("ELSE", questID)
				SelectAvailableQuest(i)
				-- C_GossipInfo.SelectAvailableQuest(questID)
			end
		end
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"QUEST_DETAIL",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:QUEST_DETAIL()
	if not IsShiftKeyDown() then
		if QuestIsFromAreaTrigger() then
			AcceptQuest()
		elseif QuestGetAutoAccept() then
			AcknowledgeAutoAcceptQuest()
		end
		AcceptQuest()
	end
end
----------------------------------------------------------------
function EventFrame:QUEST_COMPLETE()
	if not IsShiftKeyDown() and GetNumQuestChoices() <= 1 then
		GetQuestReward(1)
	end
end
----------------------------------------------------------------
function EventFrame:QUEST_GREETING()
	if IsShiftKeyDown() then return end
	self:Module_AutoTurnIn()
end
----------------------------------------------------------------
function EventFrame:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	EventFrame:Module_AutoTurnIn()
end
----------------------------------------------------------------
function EventFrame:QUEST_PROGRESS()
	if IsShiftKeyDown() then return end
	CompleteQuest()
end
----------------------------------------------------------------