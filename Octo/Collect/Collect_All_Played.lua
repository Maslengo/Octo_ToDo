local GlobalAddonName, E = ...


function E.Collect_All_Played(totalTime, currentLevelTime)
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.realTotalTime = totalTime
		collectPlayerData.realLevelTime = currentLevelTime
	end
end