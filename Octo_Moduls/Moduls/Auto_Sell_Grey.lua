local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local function Auto_SellGrey()
	if InCombatLockdown() or UnitIsDead("player") then return end
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
----------------------------------------------------------------
function EventFrame:Auto_SellGrey()
	E.func_SpamBlock(Auto_SellGrey, true)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"MERCHANT_SHOW",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:MERCHANT_SHOW()
	if not EventFrame.savedVars.Config_Auto_SellGrey then return end
	EventFrame:Auto_SellGrey()
end
----------------------------------------------------------------