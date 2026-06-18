local GlobalAddonName, E = ...
----------------------------------------------------------------
local OctoTable_bankTabs = E.OctoTable_bankTabs
local OctoTable_Account_bankTabs = E.OctoTable_Account_bankTabs
local function Collect_Items_BANK()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local usedSlots_BANK, totalSlots_BANK = 0, 0
			----------------------------------------------------------------
			E.cm.Items = E.cm.Items or {}
			E.cm.Items.Bank = {}
			E.cm.Items.Bank_FULL = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if not Enum.BagIndex or not Enum.BagIndex.CharacterBankTab_1 then return end
			----------------------------------------------------------------
			-- L["BANK"]
			-- local seenSlots = {}
			for _, bagID in next, (OctoTable_bankTabs) do
				local numSlots = E.func_GetContainerNumSlots(bagID)
				if numSlots and numSlots > 0 then
					totalSlots_BANK = totalSlots_BANK + numSlots
					local free = E.func_GetContainerNumFreeSlots(bagID)
					usedSlots_BANK = usedSlots_BANK + (numSlots - free)
					for slotIndex = 1, numSlots do
						-- local itemLocation = ItemLocation:CreateFromEquipmentSlot(slotIndex)
						local itemLocation = ItemLocation:CreateFromBagAndSlot(bagID, slotIndex)
						if itemLocation and C_Item.DoesItemExist(itemLocation) then
							local ItemName = C_Item.GetItemName(itemLocation)
							if ItemName then
								local current_Durability, maximum_Durability = GetInventoryItemDurability(slotIndex)
								local itemID = C_Item.GetItemID(itemLocation)
								local Icon = C_Item.GetItemIcon(itemLocation)
								local ItemLink = C_Item.GetItemLink(itemLocation)
								local Quality = C_Item.GetItemQuality(itemLocation)
								local CurrentItemLevel = C_Item.GetCurrentItemLevel(itemLocation)
								local ItemInventoryType = C_Item.GetItemInventoryType(itemLocation)
								local RequestLoadItemData = C_Item.RequestLoadItemData(itemLocation) -- or false
								-- local xyz = tostring(bagID)..tostring(slotIndex)
								E.cm.Items.Bank_FULL[itemID] = {
									itemID = itemID,
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
								-- else
								--     -- данные не загружены, оставляем старые и помечаем для подгрузки
								--     local existing = E.cm.Items.Bank_FULL[itemID]
								--     if existing then
								--         existing.RequestLoadItemData = true
								--         seenSlots[slotID] = true
								--     end
							end
						end
						local info = E.func_GetContainerItemInfo(bagID, slotIndex)
						if info then
							local itemID = info.itemID
							local stack = info.stackCount or 1
							if itemID == 169223 then
								local itemLocation = ItemLocation:CreateFromBagAndSlot(bagID, slotIndex)
								if itemLocation:IsValid() and C_Item.DoesItemExist(itemLocation) then
									local itemLink = C_Item.GetItemLink(itemLocation)
									local rank = E.GetItemRankFromLink(itemLink)
									E.pd.cloak_lvl = rank
								end
							end
							E.cm.Items.Bank[itemID] = (E.cm.Items.Bank[itemID] or 0) + stack
						end
					end
				end
			end
			----------------------------------------------------------------
			E.pd.usedSlots_BANK = E.func_Save(usedSlots_BANK)
			E.pd.totalSlots_BANK = E.func_Save(totalSlots_BANK)
			----------------------------------------------------------------
	end)
end
local function Collect_Items_AccountBank()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local usedSlots_AccountBank, totalSlots_AccountBank = 0, 0
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME]or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if C_Bank and C_Bank.FetchBankLockedReason and C_Bank.FetchBankLockedReason(Enum.BankType.Account) ~= nil then return end -- Банк заблокирован, не обрабатываем
			----------------------------------------------------------------
			-- ACCOUNT L["BANK"]
			for _, bagID in next, (OctoTable_Account_bankTabs) do
				local numSlots = E.func_GetContainerNumSlots(bagID)
				if numSlots and numSlots > 0 then
					totalSlots_AccountBank = totalSlots_AccountBank + numSlots
					local free = E.func_GetContainerNumFreeSlots(bagID)
					usedSlots_AccountBank = usedSlots_AccountBank + (numSlots - free)
					for slotIndex = 1, numSlots do
						local info = E.func_GetContainerItemInfo(bagID, slotIndex)
						if info then
							local itemID = info.itemID
							local stack = info.stackCount or 1
							Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank[itemID] = (Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank[itemID] or 0) + stack
						end
					end
				end
			end
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].usedSlots_AccountBank = E.func_Save(usedSlots_AccountBank)
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].totalSlots_AccountBank = E.func_Save(totalSlots_AccountBank)
			----------------------------------------------------------------
	end)
end
----------------------------------------------------------------
function E.Collect_Items_BANK()
	E.func_SpamBlock(Collect_Items_BANK, true, 1)
end
----------------------------------------------------------------
function E.Collect_Items_AccountBank()
	E.func_SpamBlock(Collect_Items_AccountBank, true, 1)
end
----------------------------------------------------------------