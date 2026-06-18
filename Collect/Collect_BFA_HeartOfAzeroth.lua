local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_BFA_HeartOfAzeroth()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local azeriteItemLocation = E.func_FindActiveAzeriteItem()
	if not azeriteItemLocation then return end
	if type(azeriteItemLocation) ~= "table" then return end
	local azerite_xp, azerite_totalLevelXP = E.func_GetAzeriteItemXPInfo(azeriteItemLocation)
	if azerite_totalLevelXP == 0 then return end
	local azeriteLVL = E.func_GetPowerLevel(azeriteItemLocation)
	E.pd.azerite_lvl = azeriteLVL

	-- E.pd.azeriteEXP = ("%d%%, -%s"):format(
	-- 	floor(azerite_xp / azerite_totalLevelXP * 100),
	-- 	E.func_CompactFormatNumber(azerite_totalLevelXP - azerite_xp)
	-- )


	E.pd.azerite_xp = azerite_xp
	E.pd.azerite_totalLevelXP = azerite_totalLevelXP
end
----------------------------------------------------------------
function E.Collect_BFA_HeartOfAzeroth()
	E.func_SpamBlock(Collect_BFA_HeartOfAzeroth, true)
end
----------------------------------------------------------------