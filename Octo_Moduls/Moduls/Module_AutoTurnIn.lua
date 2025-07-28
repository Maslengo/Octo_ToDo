local GlobalAddonName, ns = ...
E = _G.OctoEngine




local Octo_EventFrame_AutoTurnIn = CreateFrame("Frame")
Octo_EventFrame_AutoTurnIn:Hide()

local MyEventsTable = {
	"QUEST_DETAIL",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
}

E:func_RegisterMyEventsToFrames(Octo_EventFrame_AutoTurnIn, MyEventsTable)

function Octo_EventFrame_AutoTurnIn:QUEST_DETAIL()
	if not IsShiftKeyDown() then
		if QuestIsFromAreaTrigger() then
			AcceptQuest()
		elseif QuestGetAutoAccept() then
			AcknowledgeAutoAcceptQuest()
		end
		AcceptQuest()
	end
end

function Octo_EventFrame_AutoTurnIn:QUEST_COMPLETE()
	if not IsShiftKeyDown() and GetNumQuestChoices() <= 1 then
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
	if IsShiftKeyDown() then return end
		self:ProcessActiveQuests()
		self:ProcessAvailableQuests()
end






-- questframecompletequestbutton



function Octo_EventFrame_AutoTurnIn:Module_AutoTurnIn()
	local NumActiveQuests = C_GossipInfo.GetNumActiveQuests()
	local NumAvailableQuests = C_GossipInfo.GetNumAvailableQuests()
	local ActiveQuests = C_GossipInfo.GetActiveQuests() or {}
	local AvailableQuests = C_GossipInfo.GetAvailableQuests() or {}

	for i = 1, NumActiveQuests do
		local info = C_GossipInfo.GetActiveQuests()
		if info then
			local newInfo = info[i]
			-- local title = newInfo.title
			-- local questLevel = newInfo.questLevel
			-- local isTrivial = newInfo.isTrivial
			-- local frequency = newInfo.frequency
			-- local repeatable = newInfo.repeatable
			local isComplete = newInfo.isComplete
			-- local isLegendary = newInfo.isLegendary
			-- local isIgnored = newInfo.isIgnored
			local questID = newInfo.questID
			-- local isImportant = newInfo.isImportant
			-- local isMeta = newInfo.isMeta
			if isComplete and not C_QuestLog.IsWorldQuest(questID) then
				C_GossipInfo.SelectActiveQuest(questID)
			end
		end
	end


	for i = 1, NumAvailableQuests do
		local info = C_GossipInfo.GetAvailableQuests()
		if info then
			local newInfo = info[i]
			local title = newInfo.title
			-- local questLevel = newInfo.questLevel
			-- local isTrivial = newInfo.isTrivial
			-- local frequency = newInfo.frequency
			-- local repeatable = newInfo.repeatable
			-- local isComplete = newInfo.isComplete
			-- local isLegendary = newInfo.isLegendary
			-- local isIgnored = newInfo.isIgnored
			local questID = newInfo.questID
			-- local isImportant = newInfo.isImportant
			-- local isMeta = newInfo.isMeta
			C_GossipInfo.SelectAvailableQuest(questID)
		end
	end

end


function Octo_EventFrame_AutoTurnIn:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	Octo_EventFrame_AutoTurnIn:Module_AutoTurnIn()
end

function Octo_EventFrame_AutoTurnIn:QUEST_PROGRESS()
	if IsShiftKeyDown() then return end
		CompleteQuest()
end