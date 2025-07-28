local GlobalAddonName, E = ...

----------------------------------------------------------------
E.OctoTable_UniversalQuest = {}
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
func_ConcatAtStart_UniversalQuest()

-- function E.Collect_All_UNIVERSALQuestUpdate()
--     local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
--     if not collectMASLENGO or InCombatLockdown() then return end
--     -- collectMASLENGO.UniversalQuest = collectMASLENGO.UniversalQuest or {}
--     for i, v in next, (E.OctoTable_UniversalQuest) do
--         local count = 0
--         local questKey = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
--         for _, questID in next, (v.questID) do
--             if C_QuestLog.IsQuestFlaggedCompleted(questID) then
--                 count = count + 1
--             end
--             if v.max == 1 and E:func_IsOnQuest(questID) then
--                 collectMASLENGO.UniversalQuest[questKey] = E:func_CheckCompletedByQuestID(questID)
--             end
--         end
--         -- if Octo_Debug_DB then
--         -- Octo_Debug_DB.UniversalQuest[v.desc] = Octo_Debug_DB.UniversalQuest[v.desc] or {}
--         -- Octo_Debug_DB.UniversalQuest[v.desc][i] = Octo_Debug_DB.UniversalQuest[v.desc][i] or tostringall("CharInfo.MASLENGO.UniversalQuest."..questKey)
--         -- end
--         if count > 0 then
--             collectMASLENGO.UniversalQuest[questKey] = count
--         end
--     end
-- end



function E.Collect_All_UNIVERSALQuestUpdate()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO or InCombatLockdown() then return end
	-- collectMASLENGO.UniversalQuest = collectMASLENGO.UniversalQuest or {}
	for i, v in next, (E.OctoTable_UniversalQuest) do
		local count = 0
		local questKey = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
		for _, questID in next, (v.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(questID) then
				count = count + 1
			end
			if v.max == 1 and E:func_IsOnQuest(questID) then
				collectMASLENGO.UniversalQuest[questKey] = E:func_CheckCompletedByQuestID(questID)
			end
		end
		-- if Octo_Debug_DB then
		-- Octo_Debug_DB.UniversalQuest[v.desc] = Octo_Debug_DB.UniversalQuest[v.desc] or {}
		-- Octo_Debug_DB.UniversalQuest[v.desc][i] = Octo_Debug_DB.UniversalQuest[v.desc][i] or tostringall("CharInfo.MASLENGO.UniversalQuest."..questKey)
		-- end
		if count > 0 then
			collectMASLENGO.UniversalQuest[questKey] = count
		end
	end
end