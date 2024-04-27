local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
--AutoSellGrey
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
-- Consumable 0 Consumable Enum.ItemConsumableSubclass
-- Container 1 Container
-- Weapon 2 Weapon Enum.ItemWeaponSubclass
-- Gem 3 Gem Enum.ItemGemSubclass
-- Armor 4 Armor Enum.ItemArmorSubclass
-- Reagent 5 Reagent Enum.ItemReagentSubclass Obsolete
-- Projectile 6 Projectile Obsolete
-- Tradegoods 7 Tradeskill
-- ItemEnhancement 8 Item Enhancement
-- Recipe 9 Recipe Enum.ItemRecipeSubclass
-- CurrencyTokenObsolete 10 Money(OBSOLETE)
-- Quiver 11 Quiver Obsolete
-- Questitem 12 Quest
-- Key 13 Key
-- PermanentObsolete 14 Permanent(OBSOLETE)
-- Miscellaneous 15 Miscellaneous Enum.ItemMiscellaneousSubclass
-- Glyph 16 Glyph
-- Battlepet 17 Battle Pets Enum.BattlePetTypes
-- WoWToken 18 WoW Token
-- Profession 19 Profession Enum.ItemProfessionSubclass Added in 10.0.0
----------------------------------------------------------------------------------------------------------------------------------