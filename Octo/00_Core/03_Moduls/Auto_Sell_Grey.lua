local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end



tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.AutoSellGrey then return end

	local function SellGreyItems()
		local totalPrice = 0

		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local itemLink = C_Container.GetContainerItemLink(bag, slot)
				if itemLink then
					local _, _, quality, _, _, _, _, _, _, sellPrice, _, classID = C_Item.GetItemInfo(itemLink)
					local itemInfo = C_Container.GetContainerItemInfo(bag, slot)

					if quality == Enum.ItemQuality.Poor and sellPrice > 0 and classID ~= Enum.ItemClass.Weapon and classID ~= Enum.ItemClass.Armor then
						totalPrice = totalPrice + (sellPrice * (itemInfo.stackCount or 1))
						C_Container.UseContainerItem(bag, slot)
					end
				end
			end
		end

		if totalPrice > 0 then
			PickupMerchantItem(0) -- Закрываем окно продажи
		end
	end

	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", SellGreyItems)
	frame:RegisterEvent("MERCHANT_SHOW")
end)