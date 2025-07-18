local GlobalAddonName, E = ...

function E.Collect_All_ItemsInBag()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local usedSlots = 0
		local totalSlots = 0
		local Possible_Anima = 0
		local Possible_CatalogedResearch = 0
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			local numSlots = C_Container.GetContainerNumSlots(bag)
			totalSlots = totalSlots + numSlots
			local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
			if BagType == 0 then
				usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
			end
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local stackCount = containerInfo.stackCount
					local itemID = containerInfo.itemID
					local quality = containerInfo.quality
					local hyperlink = containerInfo.hyperlink
					if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") or hyperlink:find("keystone:151086") then
						local dungeonSTR = select(4, strsplit(":", hyperlink)) -- БЫЛО 3
						local lvl = select(5, strsplit(":", hyperlink)) -- БЫЛО 4
						local dungeonID = tonumber(dungeonSTR)
						local KeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
						collectPlayerData.CurrentKeyLevel = tonumber(lvl)
						collectPlayerData.CurrentKeyName = KeyName
						if E.OctoTable_KeystoneAbbr[dungeonID] then
							collectPlayerData.CurrentKey = lvl.." "..E.OctoTable_KeystoneAbbr[dungeonID].abbreviation
						else
							collectPlayerData.CurrentKey = lvl.." "..KeyName
						end
					end
					for _, tbl in next, (E.OctoTable_itemID_Cataloged_Research) do
						if itemID == tbl.itemiD then
							Possible_CatalogedResearch = Possible_CatalogedResearch + (tbl.count*E:func_GetItemCount(itemID))
						end
					end
					local isAnima = E:func_IsAnimaItemByID(itemID)
					if stackCount and isAnima and itemID ~= nil then
						if (quality == 2) and (itemID ~= 183727) then
							Possible_Anima = Possible_Anima + (5 * stackCount)
						end
						if quality == 3 then
							Possible_Anima = Possible_Anima + (35 * stackCount)
						end
						if quality == 4 then
							Possible_Anima = Possible_Anima + (250 * stackCount)
						end
						if itemID == 183727 then
							Possible_Anima = Possible_Anima + (3 * stackCount)
						end
					end
				end
			end
		end
		collectMASLENGO.ItemsInBag = collectMASLENGO.ItemsInBag or {}
		for _, itemID in next, (E.OctoTable_itemID_ALL) do
			local count = E:func_GetItemCount(itemID, true, true, true, false)
			if count ~= 0 then
				collectMASLENGO.ItemsInBag[itemID] = count
			else
				collectMASLENGO.ItemsInBag[itemID] = nil
			end
		end
		if Possible_Anima ~= 0 then
			collectPlayerData.Possible_Anima = Possible_Anima
		else
			collectPlayerData.Possible_Anima = nil
		end
		if Possible_CatalogedResearch ~= 0 then
			collectPlayerData.Possible_CatalogedResearch = Possible_CatalogedResearch
		else
			collectPlayerData.Possible_CatalogedResearch = nil
		end
		if usedSlots ~= 0 then
			collectPlayerData.usedSlots = usedSlots
		else
			collectPlayerData.usedSlots = nil
		end
		if totalSlots ~= 0 then
			collectPlayerData.totalSlots = totalSlots
		else
			collectPlayerData.totalSlots = nil
		end
	end
end