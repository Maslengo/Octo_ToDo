local GlobalAddonName, E = ...
function E.Collect_All_ItemsInBag()
	if E.func_SpamBlock("Collect_All_ItemsInBag") then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	collectMASLENGO.ItemsALL.Bags = collectMASLENGO.ItemsALL.Bags or {}
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
					local name = E.func_itemName(itemID)
					collectMASLENGO.ItemsALL.Bags[itemID] = E.func_GetItemCount(itemID, true, true, true, false)
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
	for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
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