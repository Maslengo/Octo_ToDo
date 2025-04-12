local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Sell_Grey
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.AutoSellGrey then
			local function OnEvent(self, event)
				totalPrice = 0
				--for myBags = 0, 4 do
				for myBags = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					for bagSlots = 1, C_Container.GetContainerNumSlots(myBags) do
						CurrentItemLink = C_Container.GetContainerItemLink(myBags, bagSlots)
						if CurrentItemLink then
							local itemQuality = select(3, C_Item.GetItemInfo(CurrentItemLink))
							local sellPrice = select(11, C_Item.GetItemInfo(CurrentItemLink))
							local classID = select(12, C_Item.GetItemInfo(CurrentItemLink))
							local itemInfo = C_Container.GetContainerItemInfo(myBags, bagSlots)
							if itemQuality == 0 and sellPrice ~= 0 and classID ~= 2 and classID ~= 4 then
								totalPrice = totalPrice + (sellPrice * itemInfo.stackCount)
								C_Container.UseContainerItem(myBags, bagSlots)
								PickupMerchantItem(0)
							end
						end
					end
				end
			end
			if not AutoSellGreyFrame then
				AutoSellGreyFrame = CreateFrame("Frame")
				AutoSellGreyFrame:Hide()
			end
			AutoSellGreyFrame:SetScript("OnEvent", OnEvent)
			AutoSellGreyFrame:RegisterEvent("MERCHANT_SHOW")
		end
end)