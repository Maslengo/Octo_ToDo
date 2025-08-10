local GlobalAddonName, E = ...

function E.Collect_All_BfA_Azerite()

	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if not azeriteItemLocation then return end

	local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
	if not totalLevelXP or totalLevelXP == 0 then return end

	local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	collectPlayerData.azeriteLVL = currentLevel
	collectPlayerData.azeriteEXP = ("%d%%, -%s"):format(
		floor(xp / totalLevelXP * 100),
		E.func_CompactNumberFormat(totalLevelXP - xp)
	)
end