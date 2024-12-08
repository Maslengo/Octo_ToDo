local GlobalAddonName, E = ... 
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
local EventFrame = CreateFrame("Frame")
EventFrame:Hide()
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
EventFrame:RegisterEvent("ITEM_DATA_LOAD_RESULT")
EventFrame:RegisterEvent("ITEM_COUNT_CHANGED")
EventFrame:RegisterEvent("ITEM_PUSH")
EventFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
local inspectScantipUSABLE = nil
if not inspectScantipUSABLE then
	inspectScantipUSABLE = CreateFrame("GameTooltip", "OctoToDoScanningTooltipUSABLE", nil, "GameTooltipTemplate")
	inspectScantipUSABLE:SetOwner(UIParent, "ANCHOR_NONE")
end
function EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		local ClickableFrame = CreateFrame("Button", "ClickableFrame", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
		-- ClickableFrame:Hide()
		ClickableFrame:SetSize(64*E.scale, 64*E.scale)
		ClickableFrame:SetPoint("TOPLEFT", 0, 0)
		ClickableFrame:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
		ClickableFrame:SetBackdropBorderColor(1, 1, 1, 1)
		ClickableFrame:HookScript("OnEnter", function()
				GameTooltip:SetOwner(ClickableFrame, "ANCHOR_BOTTOMRIGHT", 20, -20) -- ANCHOR_CURSOR
				GameTooltip:ClearLines()
				local itemLink = select(2, GetItemInfo(ClickableFrame.itemID))
				GameTooltip:SetHyperlink(itemLink)
				GameTooltip:Show()
				-- LibCustomGlow.ButtonGlow_Start(ClickableFrame, {.31, 1, .47, 1}, .1)
				LibCustomGlow.AutoCastGlow_Start(
					ClickableFrame,     -- `frame` - target frame to set glowing;
					{.31, 1, .47, 1},     -- `color` - {r,g,b,a}, color of particles and opacity, from 0 to 1. Default value is {0.95, 0.95, 0.32, 1};
					4,                     -- `N` - number of particle groups. Each group contains 4 particles. Default value is 4;
					0.125,                 -- `frequency` - frequency, set to negative to inverse direction of rotation. Default value is 0.125;
					1,                     -- `scale` - scale of particles;
					nil,                 -- `xOffset`,`yOffset`
					1                     -- `key` - key of glow, allows for multiple glows on one frame;
				)
		end)
		ClickableFrame:HookScript("OnLeave", function()
				GameTooltip:ClearLines()
				GameTooltip:Hide()
				-- LibCustomGlow.ButtonGlow_Stop(ClickableFrame)
				LibCustomGlow.AutoCastGlow_Stop(ClickableFrame)
		end)
		ClickableFrame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		ClickableFrame:SetAttribute("type", "macro")
		ClickableFrame.text = ClickableFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		ClickableFrame.text:SetPoint("LEFT", ClickableFrame, "RIGHT")
		ClickableFrame.text:SetFontObject(OctoFont22)
		-- ClickableFrame.text:SetFont(E.OctoFont, 22, "OUTLINE")
		ClickableFrame.text:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		ClickableFrame.icon = ClickableFrame:CreateTexture(nil, "BACKGROUND")
		ClickableFrame.icon:SetAllPoints(ClickableFrame)
		ClickableFrame.icon:SetTexture(413587)

	end
end

function EventFrame:func_cycle()
	if not InCombatLockdown() then
		print ("EventFrame:func_cycle()")
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					if E.OctoTable_itemID_ItemsUsable[containerInfo.itemID] then
						self:ItemsUsableFrame(containerInfo.itemID)
					end
				end
			end
		end
	end
end

function EventFrame:PLAYER_REGEN_ENABLED()
	print (E.Green_Color.."PLAYER_REGEN_ENABLED".."|r")
	self:func_cycle()

end

function EventFrame:PLAYER_REGEN_DISABLED()
	-- print (E.Red_Color.."PLAYER_REGEN_DISABLED".."|r")
	-- if ClickableFrame:IsShown() then
	--     ClickableFrame:Hide()
	-- end
end

function EventFrame:BAG_NEW_ITEMS_UPDATED()
	print (E.Green_Color.."BAG_NEW_ITEMS_UPDATED".."|r")
	self:func_cycle()
end

function EventFrame:ITEM_DATA_LOAD_RESULT(itemID)
	if E.OctoTable_itemID_ItemsUsable[itemID] then
		print (E.Event_Color.."ITEM_DATA_LOAD_RESULT".."|r", itemID, E.func_itemTexture(itemID)..E.func_itemName(itemID))
		self:ItemsUsableFrame(itemID)
	end
end

function EventFrame:ITEM_COUNT_CHANGED(itemID)
	if E.OctoTable_itemID_ItemsUsable[itemID] then
		print (E.Event_Color.."ITEM_COUNT_CHANGED".."|r", itemID, E.func_itemTexture(itemID)..E.func_itemName(itemID))
		self:ItemsUsableFrame(itemID)
	end
end

function EventFrame:ITEM_PUSH(_, itemID)
	if E.OctoTable_itemID_ItemsUsable[itemID] then
		print (E.Event_Color.."ITEM_PUSH".."|r", itemID, E.func_itemTexture(itemID)..E.func_itemName(itemID))
		self:ItemsUsableFrame(itemID)
	end
end

function EventFrame:TEST_FUNC(itemLink)
	local count = 0
	-- print (count)
	-- local data = C_TooltipInfo.GetItemByID(itemLink)
	-- if data.lines then
	-- 	for i = 1, #data.lines do
	-- 		print (data.lines[i].leftText)
	-- 		local leftColor = data.lines[i].leftColor
	-- 		if leftColor and leftColor.r >= 0.9 and leftColor.g <= 0.13 and leftColor.b <= 0.13 then
	-- 			count = count + 1
	-- 			print ("ТЕКСТ НАШЁЛСЯ", leftColor.r, leftColor.g, leftColor.b, count)
	-- 		end
	-- 	end
	-- end

	inspectScantipUSABLE:ClearLines()
	inspectScantipUSABLE:SetHyperlink(itemLink)
	if inspectScantipUSABLE:NumLines() > 0 then
		for i = 1, inspectScantipUSABLE:NumLines() do
			local r, g, b, a = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetTextColor()
			local TEXTLEFT = _G["OctoToDoScanningTooltipUSABLETextLeft"..i]:GetText()
			local QWE_LEFT = E.func_coloredText(_G["OctoToDoScanningTooltipUSABLETextLeft"..i])
			local TEXTRIGHT = _G["OctoToDoScanningTooltipUSABLETextRight"..i]:GetText()
			local QWE_RIGHT = E.func_coloredText(_G["OctoToDoScanningTooltipUSABLETextRight"..i])
			if TEXTLEFT and TEXTLEFT ~= "" and QWE_LEFT ~= nil then
				if QWE_LEFT:find("^|cffFF2020") or QWE_LEFT:find("^|cffFF0000") then
					print ("ТЕКСТ НАШЁЛСЯ", QWE_LEFT)
					count = count + 1
				end
			end
			if TEXTRIGHT and TEXTRIGHT ~= "" and QWE_RIGHT ~= nil then
				-- print (TEXTRIGHT)
				if QWE_RIGHT:find("^|cffFF2020") or QWE_RIGHT:find("^|cffFF0000") then
					count = count + 1
				end
			end
		end
	end
	inspectScantipUSABLE:ClearLines()

	return count
end

function EventFrame:ItemsUsableFrame(itemID)

	local count = E.OctoTable_itemID_ItemsUsable[itemID]
	local stop = false
	if GetItemCount(itemID) >= count and not E.OctoTable_itemID_Ignore_List[itemID] then
		-- if self:TEST_FUNC(itemID) == 0 then
		if self:TEST_FUNC(E.func_GetItemLink(itemID)) == 0 then
			print (E.func_itemTexture(itemID)..E.func_itemName(itemID), E.Green_Color.."SHOW|r")
			ClickableFrame:SetAlpha(1)
			if not InCombatLockdown() then
				ClickableFrame:SetAttribute("macrotext", "/use item:"..itemID)
			end
			ClickableFrame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)

			local RGB = E.func_GetItemQualityColor(itemID)
			local r, g, b = RGB.r, RGB.g, RGB.b
			ClickableFrame:SetBackdropBorderColor(r, g, b, 1)
			ClickableFrame.itemID = itemID
			ClickableFrame.text:SetText(" "..GetItemCount(itemID, true, true, true).." "..E.func_itemName(itemID))
			stop = true
		end
	end
	-- if stop == false and GetItemCount(itemID) <= (count-1) and ClickableFrame:IsShown() then
	if stop == false and ClickableFrame:GetAlpha() == 1 then
		print (E.func_itemTexture(itemID)..E.func_itemName(itemID), E.Red_Color.."HIDE|r")
		ClickableFrame:SetAlpha(.1)
		ClickableFrame.icon:SetTexture(413587)
		ClickableFrame.text:SetText("")
	end
end

