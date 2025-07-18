local GlobalAddonName, E = ...


function E.Collect_All_BfA_Azerite()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if azeriteItemLocation then
			local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
			local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
			if totalLevelXP and totalLevelXP ~= 0 then
				collectPlayerData.azeriteLVL = currentLevel
				collectPlayerData.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E:func_CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end