local GlobalAddonName, E = ...

function E.Collect_All_Quests()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or InCombatLockdown() then return end
	-- Очищаем таблицы
	wipe(collectMASLENGO.ListOfQuests)
	wipe(collectMASLENGO.OctoTable_QuestID)
	-- Обрабатываем OctoTable_QuestID
	for _, questID in ipairs(E.OctoTable_QuestID) do
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			collectMASLENGO.OctoTable_QuestID[questID] = true
		end
		-- local status = E:func_CheckCompletedByQuestID(questID)
		-- if status ~= E.NONE then
		-- collectMASLENGO.OctoTable_QuestID[questID] = status
		-- end
	end
	-- Собираем информацию о квестах
	local numQuests = 0
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			numQuests = numQuests + 1
			collectMASLENGO.ListOfQuests[info.questID] = E:func_CheckCompletedByQuestID(info.questID)
		end
	end
	-- Сохраняем статистику
	if numShownEntries then
		collectPlayerData.numShownEntries = numShownEntries
	end
	if numQuests ~= 0 then
		collectPlayerData.numQuests = numQuests
	end
	if C_QuestLog.GetMaxNumQuestsCanAccept() then
		collectPlayerData.maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	end
end