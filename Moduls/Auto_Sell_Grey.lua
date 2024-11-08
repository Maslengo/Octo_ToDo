local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Sell_Grey
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.AutoSellGrey then
			local function OnEvent(self, event)
				totalPrice = 0
				--for myBags = 0, 4 do
				for myBags = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					for bagSlots = 1, C_Container.GetContainerNumSlots(myBags) do
						CurrentItemLink = C_Container.GetContainerItemLink(myBags, bagSlots)
						if CurrentItemLink then
							local _, _, itemQuality, _, _, _, _, _, _, _, sellPrice, classID, subclassID = GetItemInfo(CurrentItemLink)
							local itemInfo = C_Container.GetContainerItemInfo(myBags, bagSlots)
							if itemQuality == 0 and sellPrice ~= 0 and classID ~= 2 and classID ~= 4 then
								totalPrice = totalPrice + (sellPrice * itemInfo.stackCount)
								C_Container.UseContainerItem(myBags, bagSlots)
								PickupMerchantItem()
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