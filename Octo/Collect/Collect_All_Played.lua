local GlobalAddonName, E = ...
function E.Collect_All_Played(totalTime, currentLevelTime)
	if E.func_SpamBlock("Collect_All_Played", false) then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.realTotalTime = totalTime
	collectPlayerData.realLevelTime = currentLevelTime
end