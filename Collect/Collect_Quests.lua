local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Quests()
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


local function Collect_Quests_Universal()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	local hasDataToSave = false
	local tempUniversalQuest = {}
	for _, data in next,(E.ALL_UniversalQuests) do
		if not data.quests then
			break
		end
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		local questDataTable = {}
		local count = 0
		local totalQUEST = 0
		local forcedMaxQuest = data.forcedMaxQuest
		local hasSingleQuestOutput = false
		for _, questData in ipairs(data.quests) do
			if type(questData[1]) == "number" then
				local questID = questData[1]
				local faction = questData.faction
				if not faction or faction == E.FACTION_CURRENT then
					local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
					local status = E.func_GetQuestStatus(questID)
					totalQUEST = totalQUEST + 1
					questDataTable[questID] = status
					if isCompleted then
						count = count + 1
					end
					if (totalQUEST == 1 or forcedMaxQuest == 1 or #data.quests == 1) and E.func_IsOnQuest(questID) then
						questDataTable.TextCenter = status
						hasSingleQuestOutput = true
					end
				end
			end
		end
		if not hasSingleQuestOutput and count ~= 0 then
			questDataTable.TextCenter = count
		end
		if next(questDataTable) ~= nil then
			tempUniversalQuest[questKey] = questDataTable
			hasDataToSave = true
		end
	end
	if hasDataToSave then
		collectMASLENGO.UniversalQuest = tempUniversalQuest
	elseif collectMASLENGO.UniversalQuest then
		collectMASLENGO.UniversalQuest = nil
	end
end
----------------------------------------------------------------
function E.Collect_Quests()
	E.func_SpamBlock(Collect_Quests, true)
	E.func_SpamBlock(Collect_Quests_Universal, true)
end