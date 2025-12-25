local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Equipment_Durability()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local slots = {
		INVSLOT_HEAD, -- 1
		INVSLOT_SHOULDER, -- 3
		INVSLOT_CHEST, -- 5
		INVSLOT_WAIST, -- 6
		INVSLOT_LEGS, -- 7
		INVSLOT_FEET, -- 8
		INVSLOT_WRIST, -- 9
		INVSLOT_HAND, -- 10
		INVSLOT_MAINHAND, -- 16
		INVSLOT_OFFHAND, -- 17
	}
	----------------------------------------------------------------
	-- минимальная прочность
	----------------------------------------------------------------
	local lowestItemDurability = 100
	for _, slotID in ipairs(slots) do
		local cur, max = GetInventoryItemDurability(slotID)
		if cur and max and max > 0 then
			local perc = (cur / max) * 100
			if perc < lowestItemDurability then
				lowestItemDurability = perc
			end
		end
	end
	----------------------------------------------------------------
	-- минимальная НЕнулевая прочность
	----------------------------------------------------------------
	-- local lowestNonBrokenDurability = 100
	-- local found = false
	-- for _, slotID in ipairs(slots) do
	-- 	local cur, max = GetInventoryItemDurability(slotID)
	-- 	if cur and max and max > 0 and cur > 0 then
	-- 		found = true
	-- 		local perc = (cur / max) * 100
	-- 		if perc < lowestNonBrokenDurability then
	-- 			lowestNonBrokenDurability = perc
	-- 		end
	-- 	end
	-- end
	-- if not found then
	-- 	lowestNonBrokenDurability = 0
	-- end
	----------------------------------------------------------------
	-- средняя прочность экипировки
	----------------------------------------------------------------
	-- local sum, count = 0, 0
	-- for _, slotID in next,(slots) do
	-- 	local cur, max = GetInventoryItemDurability(slotID)
	-- 	if cur and max and max > 0 then
	-- 		sum = sum + (cur / max) * 100
	-- 		count = count + 1
	-- 	end
	-- end
	-- local averageDurability = count > 0 and (sum / count) or 100
	----------------------------------------------------------------
	collectPlayerData.PlayerDurability = E.func_CompactRoundNumber(lowestItemDurability)
end
----------------------------------------------------------------
function E.Collect_Equipment_Durability()
	E.func_SpamBlock(Collect_Equipment_Durability, false)
end