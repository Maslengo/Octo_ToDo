local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_ItemLevels()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	collectPlayerData.avgItemLevel = math.floor(avgItemLevel)
	collectPlayerData.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
	collectPlayerData.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	----------------------------------------------------------------
	local tempTable_ItemLevels = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if (not ShowOnlyCurrentRegion) or pd.CurrentRegionName == E.CurrentRegionName then
			local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
			table.insert(tempTable_ItemLevels, {sortValue = avgItemLevelEquipped})
		end
	end
	E.minValue_ItemLevel, E.maxValue_ItemLevel = E.func_GetMinMaxValue(tempTable_ItemLevels, "sortValue")
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Character_ItemLevels()
	E.func_SpamBlock(Collect_Character_ItemLevels, true)
end