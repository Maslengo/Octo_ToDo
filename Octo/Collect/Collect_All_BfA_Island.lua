local GlobalAddonName, E = ...


function E.Collect_All_BfA_Island()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
		if questID then
			if E:func_CheckCompletedByQuestID(questID) ~= E.NONE then
				collectMASLENGO.islandBfA = E:func_CheckCompletedByQuestID(questID)
			end
		end
	end
end