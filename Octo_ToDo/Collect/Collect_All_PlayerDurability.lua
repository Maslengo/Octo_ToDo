local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_PlayerDurability()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local totalDurability = 100
	local slots = {
		[1] = _G.INVTYPE_HEAD,
		[3] = _G.INVTYPE_SHOULDER,
		[5] = _G.INVTYPE_CHEST,
		[6] = _G.INVTYPE_WAIST,
		[7] = _G.INVTYPE_LEGS,
		[8] = _G.INVTYPE_FEET,
		[9] = _G.INVTYPE_WRIST,
		[10] = _G.INVTYPE_HAND,
		[16] = _G.INVTYPE_WEAPONMAINHAND,
		[17] = _G.INVTYPE_WEAPONOFFHAND,
		[18] = _G.INVTYPE_RANGED,
	}
	for index in next, (slots) do
		local currentDura, maxDura = GetInventoryItemDurability(index)
		if currentDura and maxDura > 0 then
			local perc = (currentDura/maxDura)*100
			if perc < totalDurability then
				totalDurability = perc
			end
		end
	end
	collectPlayerData.PlayerDurability = E.func_CompactRoundNumber(totalDurability)
end
----------------------------------------------------------------
function E.Collect_All_PlayerDurability()
	E.func_SpamBlock(Collect_All_PlayerDurability, false)
end