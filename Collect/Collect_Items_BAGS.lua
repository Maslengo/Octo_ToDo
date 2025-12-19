local GlobalAddonName, E = ...
----------------------------------------------------------------
E.ItemInfoCache_BAGS = E.ItemInfoCache_BAGS or {}
local function Collect_Items_BAGS()
	local player = Octo_ToDo_DB_Levels[E.curGUID]
	if not player then return end
	local collectPlayerData = player.PlayerData
	local collectMASLENGO = player.MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	local usedSlots_BAGS, totalSlots_BAGS = 0, 0
	local Possible_Anima, Possible_CatalogedResearch = 0, 0
	local keystoneFound = false
	local ItemCounts_BAGS = {}
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		if numSlots > 0 then
			totalSlots_BAGS = totalSlots_BAGS + numSlots
			local free, bagType = C_Container.GetContainerNumFreeSlots(bag)
			if bagType == 0 then
				usedSlots_BAGS = usedSlots_BAGS + (numSlots - free)
			end
			for slot = 1, numSlots do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info then
					local itemID = info.itemID
					local stack = info.stackCount or 1
					ItemCounts_BAGS[itemID] = (ItemCounts_BAGS[itemID] or 0) + stack
					-- Keystone (по itemID, без строк)
					if not keystoneFound and E.KeyStoneTBL[itemID] then
						local link = info.hyperlink
						if link then
							local _, _, _, dungeonID, lvl = strsplit(":", link)
							dungeonID = tonumber(dungeonID)
							collectPlayerData.CurrentKeyLevel = tonumber(lvl)
							collectPlayerData.CurrentKeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
							keystoneFound = true
						end
					end
					-- Cataloged Research
					local researchValue = E.OctoTable_itemID_Cataloged_Research[itemID]
					if researchValue then
						Possible_CatalogedResearch = Possible_CatalogedResearch + (researchValue * stack)
					end
					-- Anima
					if E.func_IsAnimaItemByID(itemID) then
						local quality = info.quality
						if itemID == 183727 then
							Possible_Anima = Possible_Anima + (3 * stack)
						elseif quality == 2 then
							Possible_Anima = Possible_Anima + (5 * stack)
						elseif quality == 3 then
							Possible_Anima = Possible_Anima + (35 * stack)
						elseif quality == 4 then
							Possible_Anima = Possible_Anima + (250 * stack)
						end
					end
					-- Usable items cache
					if not E.OctoTable_itemID_ItemsUsable[itemID] then
						local cached = E.ItemInfoCache_BAGS[itemID]
						if not cached then
							local _, _, _, _, _, itemType, subType = C_Item.GetItemInfo(itemID)
							cached = { itemType, subType }
							E.ItemInfoCache_BAGS[itemID] = cached
						end
						local itemType, subType = cached[1], cached[2]
						if itemType == AUCTION_CATEGORY_HOUSING
						or itemType == BINDING_HEADER_HOUSING_SYSTEM
						or subType == HOUSING_ITEM_TOAST_TYPE_DECOR
						or subType == CATALOG_SHOP_TYPE_DECOR
						or subType == MOUNTS then
							E.OctoTable_itemID_ItemsUsable[itemID] = 1
						end
					end
				end
			end
		end
	end
	-- collectMASLENGO.Items = collectMASLENGO.Items or {}
	-- collectMASLENGO.Items.Bags = {}
	wipe(collectMASLENGO.Items.Bags or {})
	collectMASLENGO.Items.Bags = ItemCounts_BAGS
	collectPlayerData.Possible_Anima = Possible_Anima ~= 0 and Possible_Anima or nil
	collectPlayerData.Possible_CatalogedResearch = Possible_CatalogedResearch ~= 0 and Possible_CatalogedResearch or nil
	collectPlayerData.usedSlots_BAGS = usedSlots_BAGS
	collectPlayerData.totalSlots_BAGS = totalSlots_BAGS
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Items)
end
----------------------------------------------------------------
function E.Collect_Items_BAGS()
	E.func_SpamBlock(Collect_Items_BAGS, true)
end