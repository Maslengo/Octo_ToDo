local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
function E.Collect_All_UNIVERSALQuestUpdate()
	if E.func_SpamBlock("Collect_All_UNIVERSALQuestUpdate") then return end
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
				if not faction or faction == E.curFaction then
					local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
					local status = E.func_CheckCompletedByQuestID(questID)
					totalQUEST = totalQUEST + 1
					questDataTable[questID] = status
					if isCompleted then
						count = count + 1
					end
					if (totalQUEST == 1 or forcedMaxQuest == 1 or #data.quests == 1) and E.func_IsOnQuest(questID) then
						questDataTable.textCENT = status
						hasSingleQuestOutput = true
					end
				end
			end
		end
		if not hasSingleQuestOutput and count ~= 0 then
			questDataTable.textCENT = count
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