local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Money_AYE()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.Money = GetMoney() or 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	----------------------------------------------------------------
	local tempTable_Money = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if (not ShowOnlyCurrentRegion) or pd.CurrentRegionName == E.CurrentRegionName then
			local Money = pd.Money or 0
			table.insert(tempTable_Money, {sortValue = Money})
		end
	end
	E.minValue_Money, E.maxValue_Money = E.func_GetMinMaxValue(tempTable_Money, "sortValue")
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Money_AYE()
	E.func_SpamBlock(Collect_Money_AYE, false)
end