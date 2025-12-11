local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_MoneyUpdate()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.Money = GetMoney() or 0







	----------------------------------------------------------------
	local tempTable_Money = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local Money = pd.Money or 0
			table.insert(tempTable_Money, {sortValue = Money})
		end
	end
	E.minValue_Money, E.maxValue_Money = E.func_GetMinMaxValue(tempTable_Money, "sortValue")
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_All_MoneyUpdate()
	E.func_SpamBlock(Collect_All_MoneyUpdate, false)
end