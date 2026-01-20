local GlobalAddonName, E = ...
	----------------------------------------------------------------
	-- local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	-- local slots = Enum.InventoryType
	----------------------------------------------------------------
local function Collect_Equipments()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	collectMASLENGO.InventoryType = collectMASLENGO.InventoryType or {}
	-- Таблица для слотов, которые реально есть сейчас
	local seenSlots = {}
	for slotID in next, E.OctoTable_SlotMapping do
		local itemLocation = ItemLocation:CreateFromEquipmentSlot(slotID)
		if itemLocation and C_Item.DoesItemExist(itemLocation) then
			local ItemName = C_Item.GetItemName(itemLocation)
			if ItemName then
				local current_Durability, maximum_Durability = GetInventoryItemDurability(slotID)
				local ItemID = C_Item.GetItemID(itemLocation)
				local Icon = C_Item.GetItemIcon(itemLocation)
				local ItemLink = C_Item.GetItemLink(itemLocation)
				local Quality = C_Item.GetItemQuality(itemLocation)
				local CurrentItemLevel = C_Item.GetCurrentItemLevel(itemLocation)
				local ItemInventoryType = C_Item.GetItemInventoryType(itemLocation)
				local RequestLoadItemData = C_Item.RequestLoadItemData(itemLocation) -- or false
				-- local ItemDataCached = C_Item.IsItemDataCached(itemLocation) -- or false
				if ItemID then
					local cacheName = E.func_GetItemName(ItemID)
					E.ALL_Items[ItemID] = true
				end
				collectMASLENGO.InventoryType[slotID] = {
					ItemID = ItemID,
					ItemName = ItemName,
					Icon = Icon,
					ItemLink = ItemLink,
					Quality = Quality,
					CurrentItemLevel = CurrentItemLevel,
					ItemInventoryType = ItemInventoryType,
					RequestLoadItemData = RequestLoadItemData,
					-- ItemDataCached = ItemDataCached,
					current_Durability = current_Durability,
					maximum_Durability = maximum_Durability,
				}

				seenSlots[slotID] = true
			else
				-- данные не загружены, оставляем старые и помечаем для подгрузки
				local existing = collectMASLENGO.InventoryType[slotID]
				if existing then
					existing.RequestLoadItemData = true
					seenSlots[slotID] = true
				end
			end
		end
	end
	-- Убираем слоты, которых больше нет на персонаже
	for slotID in pairs(collectMASLENGO.InventoryType) do
		if not seenSlots[slotID] then
			collectMASLENGO.InventoryType[slotID] = nil
		end
	end
end
----------------------------------------------------------------
function E.Collect_Equipments()
	E.func_SpamBlock(Collect_Equipments, false, 1)
end
----------------------------------------------------------------
-- /dump Enum.InventoryType