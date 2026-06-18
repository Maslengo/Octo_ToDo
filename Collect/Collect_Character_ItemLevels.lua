local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_ItemLevels()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	E.pd.avgItemLevel = math.floor(avgItemLevel)
	E.pd.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
	E.pd.avgItemLevelPvp = math.floor(avgItemLevelPvp)


end
----------------------------------------------------------------
function E.Collect_Character_ItemLevels()
	E.func_SpamBlock(Collect_Character_ItemLevels, true)
end
----------------------------------------------------------------