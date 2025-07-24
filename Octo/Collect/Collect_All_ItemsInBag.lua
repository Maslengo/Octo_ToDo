local GlobalAddonName, E = ...

function E.Collect_All_ItemsInBag()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO

	if not collectPlayerData or InCombatLockdown() then return end

	local usedSlots, totalSlots, Possible_Anima, Possible_CatalogedResearch = 0, 0, 0, 0
	local keystoneFound = false

	-- Оптимизация: выносим часто используемые функции в локальные переменные
	local GetContainerNumSlots = C_Container.GetContainerNumSlots
	local GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
	local GetContainerItemInfo = C_Container.GetContainerItemInfo
	local strsplit = strsplit

	-- Сканирование сумок
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

					-- Обработка ключей подземелий
					if not keystoneFound and hyperlink and (hyperlink:find("keystone:180653")
						or hyperlink:find("keystone:138019")
						or hyperlink:find("keystone:158923")
						or hyperlink:find("keystone:151086")) then
						local _, _, _, dungeonSTR, lvl = strsplit(":", hyperlink)
						local dungeonID = tonumber(dungeonSTR)
						local KeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
						collectPlayerData.CurrentKeyLevel = tonumber(lvl)
						collectPlayerData.CurrentKeyName = KeyName
						collectPlayerData.CurrentKey = lvl.." "..(E.OctoTable_KeystoneAbbr[dungeonID] and E.OctoTable_KeystoneAbbr[dungeonID].abbreviation or KeyName)
						keystoneFound = true -- Прекращаем поиск после первого найденного ключа
					end

					-- Обработка исследовательских материалов
					if itemID and E.OctoTable_itemID_Cataloged_Research then
						for _, tbl in ipairs(E.OctoTable_itemID_Cataloged_Research) do
							if itemID == tbl.itemiD then
								Possible_CatalogedResearch = Possible_CatalogedResearch + (tbl.count * E:func_GetItemCount(itemID))
								break -- Прерываем цикл после нахождения совпадения
							end
						end
					end

					-- Обработка анимы
					if stackCount and itemID and E:func_IsAnimaItemByID(itemID) then
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

	-- Обновление данных о предметах в сумке
	collectMASLENGO.ItemsInBag = collectMASLENGO.ItemsInBag or {}
	for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
		local count = E:func_GetItemCount(itemID, true, true, true, false)
		if count ~= 0 then
			collectMASLENGO.ItemsInBag[itemID] = count
		else
			collectMASLENGO.ItemsInBag[itemID] = nil
		end
	end

	-- Обновление данных игрока
	collectPlayerData.Possible_Anima = Possible_Anima ~= 0 and Possible_Anima or nil
	collectPlayerData.Possible_CatalogedResearch = Possible_CatalogedResearch ~= 0 and Possible_CatalogedResearch or nil
	collectPlayerData.usedSlots = usedSlots ~= 0 and usedSlots or nil
	collectPlayerData.totalSlots = totalSlots ~= 0 and totalSlots or nil
end