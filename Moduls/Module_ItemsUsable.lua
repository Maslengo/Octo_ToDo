local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
local inspectScantipUSABLE = nil
if not inspectScantipUSABLE then
	inspectScantipUSABLE = CreateFrame("GameTooltip", "OctoToDoScanningTooltipUSABLE", nil, "GameTooltipTemplate")
	inspectScantipUSABLE:SetOwner(UIParent, "ANCHOR_NONE")
end
local function func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text then return nil end
	local r, g, b, a = fontstring:GetTextColor()
	return E.Octo_Func.func_rgb2hex(r, g, b, a)..text.."|r"
end
local function TEST_FUNC(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TEST_FUNC()".."|r")
	end
	local count = 0
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				local itemID = containerInfo.itemID
				if itemID and itemID == self then
					local link = containerInfo.hyperlink
					-- local _, link = GetItemInfo(itemID)
					inspectScantipUSABLE:ClearLines()
					inspectScantipUSABLE:SetHyperlink(link)
					if inspectScantipUSABLE:NumLines() > 0 then
						for i = 1, inspectScantipUSABLE:NumLines() do
							local text = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetText()
							local r, g, b, a = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetTextColor()
							local QWE = func_coloredText(_G["OctoToDoScanningTooltipUSABLETextLeft"..i])
							if text and text ~= "" and QWE ~= nil then
								if QWE:find("^|cffFF2020") or QWE:find("^|cffFF0000") then
									count = count + 1
								end
							end
						end
					end
					inspectScantipUSABLE:ClearLines()
				end
			end
		end
	end
	return count
end
--ItemsUsable
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.ItemsUsable then
			-- https://www.wowhead.com/ru/item=205151/%D0%B8%D0%B7%D0%B2%D0%B8%D0%BB%D0%B8%D1%81%D0%BA#comments
			-- https://www.wowhead.com/ru/item=206009/ https://www.wowhead.com/ru/item=206010/ https://www.wowhead.com/ru/item=206014/
			-- https://www.wowhead.com/ru/item=206014/ https://www.wowhead.com/ru/item=206011/ https://www.wowhead.com/ru/item=206015/
			-- https://www.wowhead.com/ru/item=206015/ https://www.wowhead.com/ru/item=206012/ https://www.wowhead.com/ru/item=206016/
			-- https://www.wowhead.com/ru/item=206016/ https://www.wowhead.com/ru/item=206013/ https://www.wowhead.com/ru/item=206017/
			-- https://www.wowhead.com/ru/item=206017/ https://www.wowhead.com/ru/item=206021/ https://www.wowhead.com/ru/item=205151/
			local function ItemsUsable_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20)
				GameTooltip:ClearLines()
				-- GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemid))
				local itemLink = select(2, GetItemInfo(self.itemid))
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show()
			end
			local function ItemsUsable_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			if not ItemsUsable_Frame then
				ItemsUsable_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
				ItemsUsable_Frame:Hide()
			end
			ItemsUsable_Frame:Hide()
			ItemsUsable_Frame:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
			ItemsUsable_Frame:SetPoint("TOPLEFT", 0, 0)
			ItemsUsable_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
			ItemsUsable_Frame:SetBackdropBorderColor(1, 1, 1, 1)
			ItemsUsable_Frame:HookScript("OnEnter", ItemsUsable_Frame_OnEnter)
			ItemsUsable_Frame:HookScript("OnLeave", ItemsUsable_Frame_OnLeave)
			ItemsUsable_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			ItemsUsable_Frame:SetAttribute("type", "macro")
			if not ItemsUsable_Frame_TEXTNAME then
				ItemsUsable_Frame_TEXTNAME = ItemsUsable_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			ItemsUsable_Frame_TEXTNAME:SetPoint("TOPLEFT", ItemsUsable_Frame, "TOPRIGHT")
			ItemsUsable_Frame_TEXTNAME:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			ItemsUsable_Frame_TEXTNAME:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not ItemsUsable_Frame_TEXTCOUNT then
				ItemsUsable_Frame_TEXTCOUNT = ItemsUsable_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			ItemsUsable_Frame_TEXTCOUNT:SetPoint("LEFT", ItemsUsable_Frame, "RIGHT")
			ItemsUsable_Frame_TEXTCOUNT:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			ItemsUsable_Frame_TEXTCOUNT:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not ItemsUsable_UIF_texture then
				ItemsUsable_UIF_texture = ItemsUsable_Frame:CreateTexture(nil, "BACKGROUND")
			end
			ItemsUsable_Frame.icon = ItemsUsable_UIF_texture
			ItemsUsable_UIF_texture:SetAllPoints(ItemsUsable_Frame)
			ItemsUsable_UIF_texture:SetTexture(413587)
			function ItemsUsableFrame_OnLoad()
				if not EventFrame_ItemsUsable then
					EventFrame_ItemsUsable = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent)
					EventFrame_ItemsUsable:Hide()
				end
				if not InCombatLockdown() then
					EventFrame_ItemsUsable:Hide()
					-- EventFrame_ItemsUsable:RegisterEvent("PLAYER_LOGIN")
					-- EventFrame_ItemsUsable:RegisterEvent("ITEM_COUNT_CHANGED")
					-- EventFrame_ItemsUsable:RegisterEvent("ITEM_COUNT_UPDATE")
					EventFrame_ItemsUsable:RegisterEvent("BAG_UPDATE_DELAYED")
					EventFrame_ItemsUsable:RegisterEvent("PLAYER_REGEN_ENABLED")
					EventFrame_ItemsUsable:RegisterEvent("PLAYER_REGEN_DISABLED")
					EventFrame_ItemsUsable:RegisterEvent("PLAYER_ENTERING_WORLD")
					EventFrame_ItemsUsable:SetScript("OnEvent", ItemsUsableFrame_OnEvent)
				end
			end
			function ItemsUsableFrame_OnEvent(self, event)
				-- if (event == "ITEM_COUNT_CHANGED" or event == "ITEM_COUNT_UPDATE" or event == "PLAYER_REGEN_ENABLED" or event == "BAG_UPDATE_DELAYED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() --[[and isGroup == false]] then
				if (event == "PLAYER_REGEN_ENABLED" or event == "BAG_UPDATE_DELAYED") and not InCombatLockdown() --[[and isGroup == false]] then
					C_Timer.After(0, function()
						ItemsUsableFrame()
					end)
				elseif event == "PLAYER_REGEN_DISABLED" then
					if ItemsUsable_Frame:IsShown() then
						ItemsUsable_Frame:Hide()
					end
				end
			end
			function ItemsUsableFrame()
				if not InCombatLockdown() and ItemsUsable_Frame then
					local itemID = 191251
					if (GetItemCount(191251) >= 30 and GetItemCount(193201) >= 3) then
						ItemsUsable_Frame:Show()
						ItemsUsable_Frame:SetAttribute("macrotext", "/use item:"..itemID)
						ItemsUsable_Frame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
						local itemQuality = (select(3, GetItemInfo(itemID)) or 0)
						local r, g, b = GetItemQualityColor(itemQuality)
						ItemsUsable_Frame:SetBackdropBorderColor(r, g, b, 1)
						ItemsUsable_Frame.itemid = itemID
						ItemsUsable_Frame_TEXTNAME:SetText(E.Octo_Func.func_itemName(itemID))
						ItemsUsable_Frame_TEXTCOUNT:SetText(GetItemCount(itemID, true, true, true))
					else
						for itemid, count in pairs(E.Octo_Table.OctoTable_itemID_ItemsUsable) do
							if GetItemCount(itemid) >= count and TEST_FUNC(itemid) == 0 then
								if itemid == 32502 then -- https://ru.wowhead.com/quest=11020
									itemid = 32503
								end
								-- if itemid == 191160 then -- https://ru.wowhead.com/quest=66020
								-- 	itemid = 191160
								-- end
								ItemsUsable_Frame:Show()
								ItemsUsable_Frame:SetAttribute("macrotext", "/use item:"..itemid)
								ItemsUsable_Frame.icon:SetTexture(select(10, GetItemInfo(itemid)) or 413587)
								local itemQuality = (select(3, GetItemInfo(itemid)) or 0)
								local r, g, b = GetItemQualityColor(itemQuality)
								ItemsUsable_Frame:SetBackdropBorderColor(r, g, b, 1)
								ItemsUsable_Frame.itemid = itemid
								ItemsUsable_Frame_TEXTNAME:SetText(E.Octo_Func.func_itemName(itemid))
								ItemsUsable_Frame_TEXTCOUNT:SetText(GetItemCount(itemid, true, true, true))
								break
							elseif GetItemCount(itemid) <= (count-1) or (GetItemCount(191251) < 30 and GetItemCount(193201) < 3) and ItemsUsable_Frame:IsShown() then
								ItemsUsable_Frame:Hide()
								ItemsUsable_Frame.icon:SetTexture(413587)
								ItemsUsable_Frame_TEXTNAME:SetText("")
								ItemsUsable_Frame_TEXTCOUNT:SetText("")
							end
						end
						--
					end
				end
			end
			E.ItemsUsable_Frame = ItemsUsable_Frame
			E.ItemsUsableFrame_OnLoad = ItemsUsableFrame_OnLoad
			E.ItemsUsableFrame = ItemsUsableFrame
			ItemsUsableFrame_OnLoad()
		end
end)
