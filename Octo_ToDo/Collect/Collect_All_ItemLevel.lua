local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_ItemLevel()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	collectPlayerData.avgItemLevel = math.floor(avgItemLevel)
	collectPlayerData.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
	collectPlayerData.avgItemLevelPvp = math.floor(avgItemLevelPvp)



	----------------------------------------------------------------
	local tempTable_ItemLevels = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
			table.insert(tempTable_ItemLevels, {sortValue = avgItemLevelEquipped})
		end
	end
	E.minValue_ItemLevel, E.maxValue_ItemLevel = E.func_GetMinMaxValue(tempTable_ItemLevels, "sortValue")
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_All_ItemLevel()
	E.func_SpamBlock(Collect_All_ItemLevel, true)
end