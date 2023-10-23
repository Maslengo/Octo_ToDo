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
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."TEST_FUNC()".."|r")
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
											-- cff0070DD -- синий шмот
											-- cffFF2020 красный
											-- if QWE:find("У вас еще нет такой модели") and not QWE:find("|cffFF2020") then
											-- if QWE:find("У вас еще нет такой модели") and not QWE:find("|cffFF2020") then
											-- if QWE:find("|cffFF2020|r") then -- RED COLOR
											-- elseif QWE:find("Использование:") and itemID then
											-- print (E.Octo_Func.func_rgb2hexDEV(r, g, b, a).."tinsert"..link)
											-- tinsert(E.Octo_Table.white_list_ALL, {itemid = itemID, count = 1},)
											-- print (text, inspectScantipUSABLE:NumLines(), E.Octo_Func.func_rgb2hexDEV(r, g, b, a))
											if QWE:find("^|cffFF2020") --[[and QWE:find(USE_COLON)]] then
												count = count + 1
											end
										end
									end
								end
								-- print (count, link)
								inspectScantipUSABLE:ClearLines()
							end
			end
		end
	end
	return count
end
--USABLEITEMS
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.UsableItems then
			-- https://www.wowhead.com/ru/item=205151/%D0%B8%D0%B7%D0%B2%D0%B8%D0%BB%D0%B8%D1%81%D0%BA#comments
			-- https://www.wowhead.com/ru/item=206009/ https://www.wowhead.com/ru/item=206010/ https://www.wowhead.com/ru/item=206014/
			-- https://www.wowhead.com/ru/item=206014/ https://www.wowhead.com/ru/item=206011/ https://www.wowhead.com/ru/item=206015/
			-- https://www.wowhead.com/ru/item=206015/ https://www.wowhead.com/ru/item=206012/ https://www.wowhead.com/ru/item=206016/
			-- https://www.wowhead.com/ru/item=206016/ https://www.wowhead.com/ru/item=206013/ https://www.wowhead.com/ru/item=206017/
			-- https://www.wowhead.com/ru/item=206017/ https://www.wowhead.com/ru/item=206021/ https://www.wowhead.com/ru/item=205151/
			local function UsableItems_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20)
				GameTooltip:ClearLines()
				-- GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemid))
				local itemLink = select(2, GetItemInfo(self.itemid))
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show()
			end
			local function UsableItems_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			if not UsableItems_Frame then
				UsableItems_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
				UsableItems_Frame:Hide()
			end
			UsableItems_Frame:Hide()
			UsableItems_Frame:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
			UsableItems_Frame:SetPoint("TOPLEFT", 0, 0)
			UsableItems_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
			UsableItems_Frame:SetBackdropBorderColor(1, 1, 1, 1)
			UsableItems_Frame:HookScript("OnEnter", UsableItems_Frame_OnEnter)
			UsableItems_Frame:HookScript("OnLeave", UsableItems_Frame_OnLeave)
			UsableItems_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			UsableItems_Frame:SetAttribute("type", "macro")
			if not UsableItems_Frame_TEXTNAME then
				UsableItems_Frame_TEXTNAME = UsableItems_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			UsableItems_Frame_TEXTNAME:SetPoint("TOPLEFT", UsableItems_Frame, "TOPRIGHT")
			UsableItems_Frame_TEXTNAME:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			UsableItems_Frame_TEXTNAME:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not UsableItems_Frame_TEXTCOUNT then
				UsableItems_Frame_TEXTCOUNT = UsableItems_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			end
			UsableItems_Frame_TEXTCOUNT:SetPoint("LEFT", UsableItems_Frame, "RIGHT")
			UsableItems_Frame_TEXTCOUNT:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 22, "OUTLINE")
			UsableItems_Frame_TEXTCOUNT:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not UIF_texture then
				UIF_texture = UsableItems_Frame:CreateTexture(nil, "BACKGROUND")
			end
			UsableItems_Frame.icon = UIF_texture
			UIF_texture:SetAllPoints(UsableItems_Frame)
			UIF_texture:SetTexture(413587)
			function UsableItemFrame_OnLoad()
				if not EventFrame then
					EventFrame = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent)
					EventFrame:Hide()
				end
				if not InCombatLockdown() then
					EventFrame:Hide()
					-- EventFrame:RegisterEvent("PLAYER_LOGIN")
					-- EventFrame:RegisterEvent("ITEM_COUNT_CHANGED")
					-- EventFrame:RegisterEvent("ITEM_COUNT_UPDATE")
					EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
					EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
					EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
					EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
					EventFrame:SetScript("OnEvent", UsableItemFrame_OnEvent)
				end
			end
			function UsableItemFrame_OnEvent(self, event)
				-- if (event == "ITEM_COUNT_CHANGED" or event == "ITEM_COUNT_UPDATE" or event == "PLAYER_REGEN_ENABLED" or event == "BAG_UPDATE_DELAYED" or event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() --[[and isGroup == false]] then
				if (event == "PLAYER_REGEN_ENABLED" or event == "BAG_UPDATE_DELAYED") and not InCombatLockdown() --[[and isGroup == false]] then
					C_Timer.After(.2, function()
						UsableItemFrame()
					end)
				elseif event == "PLAYER_REGEN_DISABLED" then
					if UsableItems_Frame:IsShown() then
						UsableItems_Frame:Hide()
					end
				end
			end
			function UsableItemFrame()
				if not InCombatLockdown() and UsableItems_Frame then
					local itemID = 191251
					if (GetItemCount(191251) >= 30 and GetItemCount(193201) >= 3) then
						UsableItems_Frame:Show()
						UsableItems_Frame:SetAttribute("macrotext", "/use item:"..itemID)
						UsableItems_Frame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
						local itemQuality = (select(3, GetItemInfo(itemID)) or 0)
						local r, g, b = GetItemQualityColor(itemQuality)
						UsableItems_Frame:SetBackdropBorderColor(r, g, b, 1)
						UsableItems_Frame.itemid = itemID
						UsableItems_Frame_TEXTNAME:SetText(E.Octo_Func.func_itemName(itemID))
						UsableItems_Frame_TEXTCOUNT:SetText(GetItemCount(itemID, true, true, true))
					else
						for itemid, count in pairs(E.Octo_Table.white_list_ALL_2) do
							if GetItemCount(itemid) >= count and TEST_FUNC(itemid) == 0 then
								if itemid == 32502 then -- https://ru.wowhead.com/quest=11020
									itemid = 32503
								end
								UsableItems_Frame:Show()
								UsableItems_Frame:SetAttribute("macrotext", "/use item:"..itemid)
								UsableItems_Frame.icon:SetTexture(select(10, GetItemInfo(itemid)) or 413587)
								local itemQuality = (select(3, GetItemInfo(itemid)) or 0)
								local r, g, b = GetItemQualityColor(itemQuality)
								UsableItems_Frame:SetBackdropBorderColor(r, g, b, 1)
								UsableItems_Frame.itemid = itemid
								UsableItems_Frame_TEXTNAME:SetText(E.Octo_Func.func_itemName(itemid))
								UsableItems_Frame_TEXTCOUNT:SetText(GetItemCount(itemid, true, true, true))
								break
							elseif GetItemCount(itemid) <= (count-1) or (GetItemCount(191251) < 30 and GetItemCount(193201) < 3) and UsableItems_Frame:IsShown() then
								UsableItems_Frame:Hide()
								UsableItems_Frame.icon:SetTexture(413587)
								UsableItems_Frame_TEXTNAME:SetText("")
								UsableItems_Frame_TEXTCOUNT:SetText("")
							end
						end
						--
					end
				end
			end
			E.UsableItems_Frame = UsableItems_Frame
			E.UsableItemFrame_OnLoad = UsableItemFrame_OnLoad
			E.UsableItemFrame = UsableItemFrame
			UsableItemFrame_OnLoad()
		end
end)
