local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local inspectScantipUSABLE = nil
if not inspectScantipUSABLE then
	inspectScantipUSABLE = CreateFrame("GameTooltip", "OctoToDoScanningTooltipUSABLE", nil, "GameTooltipTemplate")
	inspectScantipUSABLE:SetOwner(UIParent, "ANCHOR_NONE")
end
tinsert(E.Octo_Globals.modules, function()
		if E.Octo_Func.Octo_IsRetail() == true then
		if Octo_ToDo_DB_Vars.config.ItemsDelete then
		local ltl = LibStub("LibThingsLoad-1.0")
			local function ItemsDelete_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20)
				GameTooltip:ClearLines()
				local itemLink = select(2, GetItemInfo(self.itemID))
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show()
			end
			local function ItemsDelete_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			if not ItemsDelete_Frame then
				ItemsDelete_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
				ItemsDelete_Frame:Hide()
			end
			ItemsDelete_Frame:Hide()
			ItemsDelete_Frame:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
			ItemsDelete_Frame:SetPoint("TOPLEFT", 0, -64)
			ItemsDelete_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
			ItemsDelete_Frame:SetBackdropBorderColor(1, 1, 1, 1)
			ItemsDelete_Frame:HookScript("OnEnter", ItemsDelete_Frame_OnEnter)
			ItemsDelete_Frame:HookScript("OnLeave", ItemsDelete_Frame_OnLeave)
			ItemsDelete_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			-- ItemsDelete_Frame:SetAttribute("type", "macro")
			if not ItemsDelete_Frame_TEXTNAME then
				ItemsDelete_Frame_TEXTNAME = ItemsDelete_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			ItemsDelete_Frame_TEXTNAME:SetPoint("TOPLEFT", ItemsDelete_Frame, "TOPRIGHT")
			ItemsDelete_Frame_TEXTNAME:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			ItemsDelete_Frame_TEXTNAME:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not ItemsDelete_Frame_TEXTCOUNT then
				ItemsDelete_Frame_TEXTCOUNT = ItemsDelete_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			ItemsDelete_Frame_TEXTCOUNT:SetPoint("LEFT", ItemsDelete_Frame, "RIGHT")
			ItemsDelete_Frame_TEXTCOUNT:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			ItemsDelete_Frame_TEXTCOUNT:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not ItemsDelete_UIF_texture then
				ItemsDelete_UIF_texture = ItemsDelete_Frame:CreateTexture(nil, "BACKGROUND")
			end
			ItemsDelete_Frame.icon = ItemsDelete_UIF_texture
			ItemsDelete_UIF_texture:SetAllPoints(ItemsDelete_Frame)
			ItemsDelete_UIF_texture:SetTexture(413587)
			function ItemsDeleteFrame_OnLoad()
				if not EventFrame_ItemsDelete then
					EventFrame_ItemsDelete = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent)
					EventFrame_ItemsDelete:Hide()
				end
				if not InCombatLockdown() then
					EventFrame_ItemsDelete:Hide()
					EventFrame_ItemsDelete:RegisterEvent("BAG_UPDATE_DELAYED")
					EventFrame_ItemsDelete:RegisterEvent("PLAYER_REGEN_ENABLED")
					EventFrame_ItemsDelete:RegisterEvent("PLAYER_REGEN_DISABLED")
					-- EventFrame_ItemsDelete:RegisterEvent("PLAYER_ENTERING_WORLD")
					EventFrame_ItemsDelete:RegisterEvent("DELETE_ITEM_CONFIRM")
					EventFrame_ItemsDelete:SetScript("OnEvent", ItemsDeleteFrame_OnEvent)
				end
			end
			function ItemsDeleteFrame_OnEvent(self, event)
				if (event == "PLAYER_REGEN_ENABLED" or event == "BAG_UPDATE_DELAYED" or event == "DELETE_ITEM_CONFIRM") and not InCombatLockdown() then
					C_Timer.After(0, function()
							ItemsDeleteFrame()
					end)
				elseif event == "PLAYER_REGEN_DISABLED" then
					if ItemsDelete_Frame:IsShown() then
						ItemsDelete_Frame:Hide()
					end
				end
			end
			function ItemsDeleteFrame()
				if not InCombatLockdown() and ItemsDelete_Frame then
					for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
						for slot = 1, C_Container.GetContainerNumSlots(bag) do
							CurrentItemLink = C_Container.GetContainerItemLink(bag, slot)
							if CurrentItemLink then
								local _, _, itemQuality = GetItemInfo(CurrentItemLink)
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								local itemID = containerInfo.itemID
								local promise = ltl:Items(itemID)
								----------------------------------------------------------------
								for i = 1, #E.Octo_Table.OctoTable_itemID_ItemsDelete do
									if E.Octo_Table.OctoTable_itemID_ItemsDelete[i] == itemID then
										ItemsDelete_Frame:Show()
										ItemsDelete_Frame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
										local itemQuality = (select(3, GetItemInfo(itemID)) or 0)
										local r, g, b = GetItemQualityColor(itemQuality)
										ItemsDelete_Frame:SetBackdropBorderColor(r, g, b, 1)
										ItemsDelete_Frame.itemID = itemID
										ItemsDelete_Frame_TEXTNAME:SetText(E.Octo_Func.func_itemName(itemID))
										ItemsDelete_Frame_TEXTCOUNT:SetText(GetItemCount(itemID, true, true, true))
										ItemsDelete_Frame:SetScript("OnClick", function()
												C_Container.PickupContainerItem(bag, slot)
												DeleteCursorItem()
												ItemsDelete_Frame:Hide()
										end)
										return
									-- elseif GetItemCount(itemID) == 0 and ItemsDelete_Frame:IsShown() then
									-- 	ItemsDelete_Frame:Hide()
									-- 	ItemsDelete_Frame.icon:SetTexture(413587)
									-- 	ItemsDelete_Frame_TEXTNAME:SetText("")
									-- 	ItemsDelete_Frame_TEXTCOUNT:SetText("")
									end
								end
								----------------------------------------------------------------
							end
						end
					end
				end
			end
			E.ItemsDelete_Frame = ItemsDelete_Frame
			E.ItemsDeleteFrame_OnLoad = ItemsDeleteFrame_OnLoad
			E.ItemsDeleteFrame = ItemsDeleteFrame
			ItemsDeleteFrame_OnLoad()
		end end
end)
