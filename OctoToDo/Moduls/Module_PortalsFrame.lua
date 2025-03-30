local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
local OctoToDo_PortalsFrame = CreateFrame("Frame")
OctoToDo_PortalsFrame:Hide()
OctoToDo_PortalsFrame:RegisterEvent("ADDON_LOADED")
OctoToDo_PortalsFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
OctoToDo_PortalsFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
function OctoToDo_PortalsFrame:ItemsUsableFrame()
	if not InCombatLockdown() then
		Clickable_ItemsUsable:Hide()
		Clickable_ItemsUsable.icon:SetTexture(413587)
		Clickable_ItemsUsable.text:SetText("")
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local itemID = containerInfo.itemID
					if itemID and E.OctoTable_itemID_ItemsUsable[itemID] and not E.OctoTable_itemID_Ignore_List[itemID] and GetItemCount(itemID) >= E.OctoTable_itemID_ItemsUsable[itemID] then
						if self:TEST_FUNC(E.func_GetItemLink(itemID)) == 0 then
							Clickable_ItemsUsable:Show()
							if not InCombatLockdown() then
								Clickable_ItemsUsable:SetAttribute("macrotext", "/use item:"..itemID)
							end
							Clickable_ItemsUsable.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
							local RGB = E.func_GetItemQualityColor(itemID)
							if RGB then
								local r, g, b = RGB.r, RGB.g, RGB.b
								Clickable_ItemsUsable:SetBackdropBorderColor(r, g, b, 1)
							end
							Clickable_ItemsUsable.itemID = itemID
							Clickable_ItemsUsable.text:SetText(" "..GetItemCount(itemID, true, true, true).." "..E.func_itemName(itemID))
							break
						end
					end
				end
			end
		end
	end
end

OctoToDo_PortalsFrame:SetScript("OnEvent",
	function(self, event, ...)
		if self[event] then
			self[event](self, ...)
		else
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("UNUSED UVENT: ", E.Red_Color, E.Venthyr_Color).. E.Green_Color.. event.."|r")
		end
end)

function OctoToDo_PortalsFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
end


function OctoToDo_PortalsFrame:PLAYER_REGEN_DISABLED()
	if Clickable_ItemsUsable and Clickable_ItemsUsable:IsShown() then
		Clickable_ItemsUsable:Hide()
	end
end

function OctoToDo_PortalsFrame:PLAYER_REGEN_ENABLED()
	----------------------------------------------------------------
	self:ItemsUsableFrame()
	----------------------------------------------------------------
end