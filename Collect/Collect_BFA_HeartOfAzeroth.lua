local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_BFA_HeartOfAzeroth()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if not azeriteItemLocation then return end
	local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
	if not totalLevelXP or totalLevelXP == 0 then return end
	local azeriteLVL = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	collectPlayerData.azeriteLVL = azeriteLVL
	collectPlayerData.azeriteEXP = ("%d%%, -%s"):format(
		floor(xp / totalLevelXP * 100),
		E.func_CompactFormatNumber(totalLevelXP - xp)
		)



	collectPlayerData.azerite_xp = xp
	collectPlayerData.azerite_totalLevelXP = totalLevelXP
end
----------------------------------------------------------------
function E.Collect_BFA_HeartOfAzeroth()
	E.func_SpamBlock(Collect_BFA_HeartOfAzeroth, true)
end