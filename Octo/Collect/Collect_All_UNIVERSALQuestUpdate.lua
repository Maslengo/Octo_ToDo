local GlobalAddonName, E = ...
----------------------------------------------------------------
local function func_ConcatAtStart_UniversalQuest()
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_01_WorldofWarcraft())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_02_TheBurningCrusade())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_03_WrathoftheLichKing())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_04_Cataclysm())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_05_MistsofPandaria())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_06_WarlordsofDraenor())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_07_Legion())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_08_BattleforAzeroth())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_09_Shadowlands())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_10_Dragonflight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_11_TheWarWithin())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_12_Midnight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_13_TheLastTitan())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_99_Other())
end
----------------------------------------------------------------
function E:func_Collect_All_UNIVERSALQuestUpdate()
	if not E.func_ConcatAtStart_UniversalQuest then
		E.func_ConcatAtStart_UniversalQuest = true
		func_ConcatAtStart_UniversalQuest()
	end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO or InCombatLockdown() then return end
	for i, v in next, (E.OctoTable_UniversalQuest) do
		local questKey = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
		if v.MainquestID and C_QuestLog.IsQuestFlaggedCompleted(v.MainquestID) then
			collectMASLENGO.UniversalQuest[questKey] = v.max
		else
			local count = 0
			for _, questID in next, (v.questID) do
				if C_QuestLog.IsQuestFlaggedCompleted(questID) then
					count = count + 1
				end
				if v.max == 1 and E:func_IsOnQuest(questID) then
					collectMASLENGO.UniversalQuest[questKey] = E:func_CheckCompletedByQuestID(questID)
				end
			end
			if count > 0 then
				collectMASLENGO.UniversalQuest[questKey] = count
			end
		end
	end
end
----------------------------------------------------------------