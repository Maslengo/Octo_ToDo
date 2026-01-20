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
-- local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant
local OctoTable_PlayerBags = E.OctoTable_PlayerBags


local function Collect_Items_BAGS()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	if not collectPlayerData or not collectMASLENGO then return end
	local usedSlots_BAGS, totalSlots_BAGS = 0, 0
	local SL_Possible_Anima, SL_Possible_CatalogedResearch = 0, 0
	collectMASLENGO.Items = collectMASLENGO.Items or {}
	collectMASLENGO.Items.Bags = {}

	local OctoTable_itemID_ItemsUsable = E.OctoTable_itemID_ItemsUsable



	for _, bagID in next, (OctoTable_PlayerBags) do
	-- for bagID = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bagID)
		if numSlots > 0 then
			totalSlots_BAGS = totalSlots_BAGS+numSlots
			local free, bagType = C_Container.GetContainerNumFreeSlots(bagID)
			if bagType == 0 then
				usedSlots_BAGS = usedSlots_BAGS+(numSlots - free)
			end
			for slot = 1, numSlots do
				local info = C_Container.GetContainerItemInfo(bagID, slot)
				if info then
					local itemID = info.itemID
					local stack = info.stackCount or 1
					collectMASLENGO.Items.Bags[itemID] = (collectMASLENGO.Items.Bags[itemID] or 0)+stack
					-- Cataloged Research
					local researchValue = E.OctoTable_itemID_Cataloged_Research[itemID]
					if researchValue then
						SL_Possible_CatalogedResearch = SL_Possible_CatalogedResearch+(researchValue*stack)
					end
					-- Anima
					if E.func_IsAnimaItemByID(itemID) then
						local quality = info.quality
						if itemID == 183727 then
							SL_Possible_Anima = SL_Possible_Anima+(3*stack)
						elseif quality == 2 then
							SL_Possible_Anima = SL_Possible_Anima+(5*stack)
						elseif quality == 3 then
							SL_Possible_Anima = SL_Possible_Anima+(35*stack)
						elseif quality == 4 then
							SL_Possible_Anima = SL_Possible_Anima+(250*stack)
						end
					end
					-- Usable items cache
					if OctoTable_itemID_ItemsUsable and not OctoTable_itemID_ItemsUsable[itemID] then
						-- local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
						local _, itemType, itemSubType = GetItemInfoInstant(itemID)
						if itemType == AUCTION_CATEGORY_HOUSING
						or itemType == BINDING_HEADER_HOUSING_SYSTEM
						or itemSubType == HOUSING_ITEM_TOAST_TYPE_DECOR
						or itemSubType == CATALOG_SHOP_TYPE_DECOR
						or itemSubType == MOUNTS then
							OctoTable_itemID_ItemsUsable[itemID] = 1
						end
					end
				end
			end
		end
	end

	-- wipe(collectMASLENGO.Items.Bags or {})
	collectPlayerData.SL_Possible_Anima = SL_Possible_Anima ~= 0 and SL_Possible_Anima or nil
	collectPlayerData.SL_Possible_CatalogedResearch = SL_Possible_CatalogedResearch ~= 0 and SL_Possible_CatalogedResearch or nil
	collectPlayerData.usedSlots_BAGS = usedSlots_BAGS
	collectPlayerData.totalSlots_BAGS = totalSlots_BAGS
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Items)
end
----------------------------------------------------------------
function E.Collect_Items_BAGS()
	E.func_SpamBlock(Collect_Items_BAGS, true)
end