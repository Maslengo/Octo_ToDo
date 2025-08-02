local GlobalAddonName, E = ...

function E.Collect_All_Quests()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO

	-- Early return if conditions aren't met
	if not collectPlayerData or InCombatLockdown() then
		return
	end

	-- Clear tables
	wipe(collectMASLENGO.ListOfQuests)
	wipe(collectMASLENGO.OctoTable_QuestID)

	-- Process OctoTable_QuestID
	for _, questID in ipairs(E.OctoTable_QuestID) do
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			collectMASLENGO.OctoTable_QuestID[questID] = true
		end
	end

	-- Collect quest information
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local numQuests = 0

	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			numQuests = numQuests + 1
			collectMASLENGO.ListOfQuests[info.questID] = E:func_CheckCompletedByQuestID(info.questID)
		end
	end

	-- Update player data
	if numQuests > 0 then
		collectPlayerData.numQuests = numQuests
	else
		collectPlayerData.numQuests = nil
	end

	-- Save statistics
	collectPlayerData.numShownEntries = numShownEntries
	collectPlayerData.maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
end