local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
local ltl = LibStub("LibThingsLoad-1.0")
local inspectScantipUSABLE = nil
if not inspectScantipUSABLE then
	inspectScantipUSABLE = CreateFrame("GameTooltip", "OctoToDoScanningTooltipUSABLE", nil, "GameTooltipTemplate")
	inspectScantipUSABLE:SetOwner(UIParent, "ANCHOR_NONE")
end
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.config.ItemsUsable then
			local function func_coloredText(fontstring)
				if not fontstring then return nil end
				local text = fontstring:GetText()
				if not text then return nil end
				local r, g, b, a = fontstring:GetTextColor()
				return E.func_rgb2hex(r, g, b, a)..text.."|r"
			end
			local function TEST_FUNC(self)
				if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
					DEFAULT_CHAT_FRAME:AddMessage(E.Blue_Color.."TEST_FUNC()".."|r")
				end
				local count = 0
				for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
						local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
						if containerInfo then
							local itemID = containerInfo.itemID
							local promise = ltl:Items(itemID)
							if itemID and itemID == self then
								local link = containerInfo.hyperlink
								inspectScantipUSABLE:ClearLines()
								inspectScantipUSABLE:SetHyperlink(link)
								if inspectScantipUSABLE:NumLines() > 0 then
									for i = 1, inspectScantipUSABLE:NumLines() do
										local r, g, b, a = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetTextColor()
										local TEXTLEFT = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetText()
										local QWE_LEFT = func_coloredText(_G["OctoToDoScanningTooltipUSABLETextLeft"..i])
										local TEXTRIGHT = _G["OctoToDoScanningTooltipUSABLETextRight"..i]:GetText()
										local QWE_RIGHT = func_coloredText(_G["OctoToDoScanningTooltipUSABLETextRight"..i])
										if TEXTLEFT and TEXTLEFT ~= "" and QWE_LEFT ~= nil then
											if QWE_LEFT:find("^|cffFF2020") or QWE_LEFT:find("^|cffFF0000") then
												count = count + 1
											end
										end
										if TEXTRIGHT and TEXTRIGHT ~= "" and QWE_RIGHT ~= nil then
											if QWE_RIGHT:find("^|cffFF2020") or QWE_RIGHT:find("^|cffFF0000") then
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
			local function ItemsUsable_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, -20)
				GameTooltip:ClearLines()
				-- GameTooltip:AddLine(E.func_itemName(self.itemID))
				local itemLink = select(2, GetItemInfo(self.itemID))
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show()
			end
			local function ItemsUsable_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			if not ItemsUsable_Frame then
				ItemsUsable_Frame = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
				ItemsUsable_Frame:Hide()
			end
			ItemsUsable_Frame:Hide()
			ItemsUsable_Frame:SetSize(64*E.scale, 64*E.scale)
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
			ItemsUsable_Frame_TEXTNAME:SetPoint("LEFT", ItemsUsable_Frame, "RIGHT")
			ItemsUsable_Frame_TEXTNAME:SetFont(E.OctoFont, 22, "OUTLINE")
			ItemsUsable_Frame_TEXTNAME:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
			if not ItemsUsable_UIF_texture then
				ItemsUsable_UIF_texture = ItemsUsable_Frame:CreateTexture(nil, "BACKGROUND")
			end
			ItemsUsable_Frame.icon = ItemsUsable_UIF_texture
			ItemsUsable_UIF_texture:SetAllPoints(ItemsUsable_Frame)
			ItemsUsable_UIF_texture:SetTexture(413587)
			function ItemsUsableFrame_OnLoad()
				if not EventFrame_ItemsUsable then
					EventFrame_ItemsUsable = CreateFrame("Frame", E.AddonTitle..E.func_GenerateUniqueID(), UIParent)
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
					-- EventFrame_ItemsUsable:RegisterEvent("PLAYER_ENTERING_WORLD")
					EventFrame_ItemsUsable:SetScript("OnEvent", ItemsUsableFrame_OnEvent)
				end
			end
			function ItemsUsableFrame_OnEvent(self, event, ...)
				if (event == "BAG_UPDATE_DELAYED") and not InCombatLockdown() then
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
				local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(2245)
				local quantity = currencyInfo.quantity or 0
				if not InCombatLockdown() and ItemsUsable_Frame then
					E.START()
					for itemID, count in next, (E.OctoTable_itemID_ItemsUsable) do
						if (GetItemCount(itemID) >= count and TEST_FUNC(itemID) == 0) then
							ItemsUsable_Frame:Show()
							ItemsUsable_Frame:SetAttribute("macrotext", "/use item:"..itemID)
							ItemsUsable_Frame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
							local itemQuality = (select(3, GetItemInfo(itemID)) or 0)
							local r, g, b = GetItemQualityColor(itemQuality)
							ItemsUsable_Frame:SetBackdropBorderColor(r, g, b, 1)
							ItemsUsable_Frame.itemID = itemID
							ItemsUsable_Frame_TEXTNAME:SetText(" "..GetItemCount(itemID, true, true, true).." "..E.func_itemName(itemID))
							break
						elseif GetItemCount(itemID) <= (count-1) and ItemsUsable_Frame:IsShown() then
							ItemsUsable_Frame:Hide()
							ItemsUsable_Frame.icon:SetTexture(413587)
							ItemsUsable_Frame_TEXTNAME:SetText("")
						end
					end
					E:STOP()
				end
			end
			ItemsUsableFrame_OnLoad()
		end
end)
