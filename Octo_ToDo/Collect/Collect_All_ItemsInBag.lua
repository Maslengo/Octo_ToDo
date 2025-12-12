local GlobalAddonName, E = ...
----------------------------------------------------------------


local function GetInfo(slotInfo)
	return {

	}
end


local function Collect_All_ItemsInBag()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	local usedSlots, totalSlots, Possible_Anima, Possible_CatalogedResearch = 0, 0, 0, 0
	local keystoneFound = false
	local hasKeystone = false
	for _, itemID in ipairs(E.KeyStoneTBL) do
		if E.func_GetItemCount(itemID, false, false, false, false) ~= 0 then
			hasKeystone = true
			break
		end
	end
	local GetContainerNumSlots = C_Container.GetContainerNumSlots
	local GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
	local GetContainerItemInfo = C_Container.GetContainerItemInfo
	local GetItemInfo = C_Item.GetItemInfo

	local OctoTable_itemID_ItemsUsable = E.OctoTable_itemID_ItemsUsable
	local OctoTable_itemID_Ignore_List = E.OctoTable_itemID_Ignore_List
	local OctoTable_itemID_ItemsDelete = E.OctoTable_itemID_ItemsDelete


	local itemType1 = AUCTION_CATEGORY_HOUSING
	local itemType2 = BINDING_HEADER_HOUSING_SYSTEM
	local itemSubType1 = HOUSING_ITEM_TOAST_TYPE_DECOR
	local itemSubType2 = CATALOG_SHOP_TYPE_DECOR
	local itemSubType3 = MOUNTS

	local researchItemsLookup = {}
	for _, tbl in ipairs(E.OctoTable_itemID_Cataloged_Research) do
		researchItemsLookup[tbl.itemiD] = tbl.count
	end
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		if numSlots > 0 then
			totalSlots = totalSlots + numSlots
			local numberOfFreeSlots, BagType = GetContainerNumFreeSlots(bag)
			if BagType == 0 then
				usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
			end
			for slot = 1, numSlots do
				local containerInfo = GetContainerItemInfo(bag, slot)
				if containerInfo then
					local stackCount = containerInfo.stackCount
					local itemID = containerInfo.itemID
					local quality = containerInfo.quality
					local hyperlink = containerInfo.hyperlink
					----------------------------------------------------------------
					if not OctoTable_itemID_ItemsUsable[itemID] then

						local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
						-- ДЕКОР
						if itemType == itemType1 or itemType == itemType2 or itemSubType == itemSubType1 or itemSubType == itemSubType2 then
							OctoTable_itemID_ItemsUsable[itemID] = 1
						-- МАУНТЫ
						elseif itemSubType == itemSubType3 then
							OctoTable_itemID_ItemsUsable[itemID] = 1
						-- ИГРУШКИ (не работает)
						-- elseif itemType == TOY or itemSubType == TOY then
						-- 	OctoTable_itemID_ItemsUsable[itemID] = 1
						end
					end
					----------------------------------------------------------------

					if hasKeystone and not keystoneFound and hyperlink then
						if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") or hyperlink:find("keystone:151086") then
							local _, _, _, dungeonSTR, lvl = strsplit(":", hyperlink)
							local dungeonID = tonumber(dungeonSTR)
							local KeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
							collectPlayerData.CurrentKeyLevel = tonumber(lvl)
							collectPlayerData.CurrentKeyName = KeyName
							local abbrInfo = E.OctoTable_KeystoneAbbr and E.OctoTable_KeystoneAbbr[dungeonID]
							collectPlayerData.CurrentKey = lvl.." "..(abbrInfo and abbrInfo.abbreviation or KeyName)
							keystoneFound = true
						end
					end
					if itemID and researchItemsLookup[itemID] then
						Possible_CatalogedResearch = Possible_CatalogedResearch + (researchItemsLookup[itemID] * E.func_GetItemCount(itemID))
					end
					if stackCount and itemID and E.func_IsAnimaItemByID(itemID) then
						if itemID == 183727 then
							Possible_Anima = Possible_Anima + (3 * stackCount)
						elseif quality == 2 then
							Possible_Anima = Possible_Anima + (5 * stackCount)
						elseif quality == 3 then
							Possible_Anima = Possible_Anima + (35 * stackCount)
						elseif quality == 4 then
							Possible_Anima = Possible_Anima + (250 * stackCount)
						end
					end
				end
			end
		end
	end
	if collectMASLENGO.ItemsInBag then
		wipe(collectMASLENGO.ItemsInBag)
	else
		collectMASLENGO.ItemsInBag = {}
	end
	-- local tbl = E.OctoTable_itemID_ALL
	for itemID in next,(E.ALL_Items) do
		local count = E.func_GetItemCount(itemID, true, true, true, false)
		if count ~= 0 then
			collectMASLENGO.ItemsInBag[itemID] = count
		end
	end
	collectPlayerData.Possible_Anima = Possible_Anima ~= 0 and Possible_Anima or nil
	collectPlayerData.Possible_CatalogedResearch = Possible_CatalogedResearch ~= 0 and Possible_CatalogedResearch or nil
	collectPlayerData.usedSlots = usedSlots ~= 0 and usedSlots or nil
	collectPlayerData.totalSlots = totalSlots ~= 0 and totalSlots or nil
end
----------------------------------------------------------------
function E.Collect_All_ItemsInBag()
	E.func_SpamBlock(Collect_All_ItemsInBag, true)
end