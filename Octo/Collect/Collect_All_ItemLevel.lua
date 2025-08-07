local GlobalAddonName, E = ...

function E.Collect_All_ItemLevel()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	collectPlayerData.avgItemLevel = math.floor(avgItemLevel)
	collectPlayerData.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
	collectPlayerData.avgItemLevelPvp = math.floor(avgItemLevelPvp)
end