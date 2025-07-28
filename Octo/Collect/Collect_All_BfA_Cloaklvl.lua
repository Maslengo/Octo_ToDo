local GlobalAddonName, E = ...


function E.Collect_All_BfA_Cloaklvl()

	-- Проверяем, есть ли данные игрока и не в бою ли мы
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not (collectPlayerData and not InCombatLockdown()) then
		return  -- Если условий нет, выходим
	end

	-- Проверяем, есть ли плащ (ID 169223) в инвентаре
	local hasItem = E:func_GetItemCount(169223, false, false, false, false)
	if hasItem == 0 then
		collectPlayerData.cloak_lvl = nil  -- Если плаща нет, очищаем данные
		return
	end

	-- Сначала проверяем надетый плащ (слот 15 — спина)
	local itemLink = GetInventoryItemLink("player", 15)
	if itemLink and itemLink:find("item:169223:") then
		local itemLevel = select(4, E:func_GetItemInfo(itemLink))
		if itemLevel then
			-- Рассчитываем уровень плаща (от 1 до 15)
			collectPlayerData.cloak_lvl = math.min(15, math.max((itemLevel - 125) / 2 + 1, 1))
		end
		return  -- Если нашли надетый плащ, дальше не проверяем
	end

	-- Если плащ не надет, ищем в сумках
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		for slot = 1, numSlots do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo and containerInfo.itemID == 169223 then
				local itemLevel = select(4, E:func_GetItemInfo(containerInfo.hyperlink))
				if itemLevel then
					collectPlayerData.cloak_lvl = math.min(15, math.max((itemLevel - 125) / 2 + 1, 1))
					return  -- Нашли плащ в сумке — выходим
				end
			end
		end
	end
end