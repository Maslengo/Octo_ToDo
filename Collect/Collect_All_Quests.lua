local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Quests()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	wipe(collectMASLENGO.ListOfQuests)
	wipe(collectMASLENGO.ListOfParagonQuests)
	wipe(collectMASLENGO.OctoTable_QuestID)
	for _, questID in ipairs(E.OctoTable_QuestID) do
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			collectMASLENGO.OctoTable_QuestID[questID] = true
		end
	end
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local numQuests = 0
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			numQuests = numQuests + 1
			collectMASLENGO.ListOfQuests[info.questID] = E.func_GetQuestStatus(info.questID)
		end
	end
	if numQuests > 0 then
		collectPlayerData.numQuests = numQuests
	else
		collectPlayerData.numQuests = nil
	end
	collectPlayerData.numShownEntries = numShownEntries
	collectPlayerData.maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
		if E.func_IsOnQuest(questID) then
			collectMASLENGO.ListOfParagonQuests[questID] = true
		end
	end
end
----------------------------------------------------------------
function E.Collect_All_Quests()
	E.func_SpamBlock(Collect_All_Quests, true)
end