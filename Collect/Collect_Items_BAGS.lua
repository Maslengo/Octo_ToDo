local GlobalAddonName, E = ...
----------------------------------------------------------------
-- /run opde(Enum.BagIndex)
-- [1] = {
----------------------------------------------------------------
--     ["Characterbanktab"] = -2,
--     ["CharacterBankTab_1"] = 6,
--     ["CharacterBankTab_6"] = 11,
--     ["CharacterBankTab_2"] = 7,
--     ["CharacterBankTab_3"] = 8,
--     ["CharacterBankTab_5"] = 10,
--     ["CharacterBankTab_4"] = 9,
----------------------------------------------------------------
--     ["Accountbanktab"] = -3,
--     ["AccountBankTab_1"] = 12,
--     ["AccountBankTab_2"] = 13,
--     ["AccountBankTab_3"] = 14,
--     ["AccountBankTab_4"] = 15,
--     ["AccountBankTab_5"] = 16,
----------------------------------------------------------------
--     ["Keyring"] = -1,
--     ["Backpack"] = 0,
--     ["Bag_1"] = 1,
--     ["Bag_2"] = 2,
--     ["Bag_3"] = 3,
--     ["Bag_4"] = 4,
--     ["ReagentBag"] = 5,
----------------------------------------------------------------
-- },
----------------------------------------------------------------
E.ItemInfoCache_BAGS = E.ItemInfoCache_BAGS or {}
local function Collect_Items_BAGS()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	if not collectPlayerData or not collectMASLENGO then return end
	local usedSlots_BAGS, totalSlots_BAGS = 0, 0
	local Possible_Anima, Possible_CatalogedResearch = 0, 0
	local keystoneFound = false
	local ItemCounts_BAGS = {}
	local PlayerBags = {
		Enum.BagIndex.Keyring, -- -1, (no need in retail?)
		Enum.BagIndex.Backpack, -- 0,
		Enum.BagIndex.Bag_1, -- 1,
		Enum.BagIndex.Bag_2, -- 2,
		Enum.BagIndex.Bag_3, -- 3,
		Enum.BagIndex.Bag_4, -- 4,
		Enum.BagIndex.ReagentBag, -- 5,
	}
	for _, bagID in next, (PlayerBags) do
	-- for bagID = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bagID)
		if numSlots > 0 then
			totalSlots_BAGS = totalSlots_BAGS + numSlots
			local free, bagType = C_Container.GetContainerNumFreeSlots(bagID)
			if bagType == 0 then
				usedSlots_BAGS = usedSlots_BAGS + (numSlots - free)
			end
			for slot = 1, numSlots do
				local info = C_Container.GetContainerItemInfo(bagID, slot)
				if info then
					local itemID = info.itemID
					local stack = info.stackCount or 1
					ItemCounts_BAGS[itemID] = (ItemCounts_BAGS[itemID] or 0) + stack
					-- Keystone (по itemID, без строк)
					if not keystoneFound and E.KeyStoneTBL[itemID] then
						local link = info.hyperlink
						if link then
							local _, _, _, dungeonID, lvl = strsplit(":", link)
							local dungID = tonumber(dungeonID)
							collectPlayerData.CurrentKeyLevel = tonumber(lvl)
							collectPlayerData.CurrentKeyName = C_ChallengeMode.GetMapUIInfo(dungID)
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