local GlobalAddonName, E = ...
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

-- Создаем фрейм для обработки событий
local Octo_EventFrame_ItemsUsable = CreateFrame("Frame")
Octo_EventFrame_ItemsUsable:Hide()

-- Создаем tooltip для проверки предметов
local inspectScantipUsable = CreateFrame("GameTooltip", "OctoScanningTooltipUsable", nil, "GameTooltipTemplate")
inspectScantipUsable:SetOwner(UIParent, "ANCHOR_NONE")

-- Локальные переменные для кэширования часто используемых значений
local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemCount = C_Item.GetItemCount
local GetItemInfo = C_Item.GetItemInfo
local GetItemLink = E.func_GetItemLink
local GetItemQualityColorID = E.func_GetItemQualityColorID
local itemName = E.func_GetItemNameByID
local coloredText = E.func_coloredText

-- Функция для проверки, можно ли использовать предмет
local function IsItemUsable(itemLink)
	if not itemLink then return false end

	inspectScantipUsable:ClearLines()
	inspectScantipUsable:SetHyperlink(itemLink)

	for i = 1, inspectScantipUsable:NumLines() do
		local leftText = coloredText(_G["OctoScanningTooltipUsableTextLeft"..i])
		local rightText = coloredText(_G["OctoScanningTooltipUsableTextRight"..i])

		if leftText and (leftText:find("^|cffFF2020") or leftText:find("^|cffFF0000")) then
			inspectScantipUsable:ClearLines()
			return false
		end

		if rightText and (rightText:find("^|cffFF2020") or rightText:find("^|cffFF0000")) then
			inspectScantipUsable:ClearLines()
			return false
		end
	end

	inspectScantipUsable:ClearLines()
	return true
end

-- Основная функция для обновления кнопки usable items
local function UpdateItemsUsableFrame()
	if InCombatLockdown() then return end

	local Clickable_ItemsUsable = _G.Clickable_ItemsUsable
	if not Clickable_ItemsUsable then return end

	Clickable_ItemsUsable:Hide()
	Clickable_ItemsUsable.icon:SetTexture(413587)
	Clickable_ItemsUsable.text:SetText("")

	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and containerInfo.itemID then
				local itemID = containerInfo.itemID
				local requiredCount = E.OctoTable_itemID_ItemsUsable[itemID]

				if requiredCount and not E.OctoTable_itemID_Ignore_List[itemID] and GetItemCount(itemID) >= requiredCount then
					local itemLink = GetItemLink(itemID)
					if IsItemUsable(itemLink) then
						Clickable_ItemsUsable:Show()
						Clickable_ItemsUsable:SetAttribute("macrotext", "/use item:"..itemID)

						local texture = select(10, GetItemInfo(itemID)) or 413587
						Clickable_ItemsUsable.icon:SetTexture(texture)

						local RGB = GetItemQualityColorID(itemID)
						if RGB then
							Clickable_ItemsUsable:SetBackdropBorderColor(RGB.r, RGB.g, RGB.b, 1)
						end

						Clickable_ItemsUsable.itemID = itemID
						Clickable_ItemsUsable.text:SetText(" "..GetItemCount(itemID, true, true, true).." "..itemName(itemID))
						return -- Прерываем цикл после нахождения первого подходящего предмета
					else
						if not E.OctoTable_itemID_ItemsDelete[itemID] then
							print (E.func_GetItemNameByID(itemID), E.func_Gradient("mark to DELETE"))
							E.OctoTable_itemID_ItemsDelete[itemID] = true
						end
						-- tinsert(E.OctoTable_itemID_ItemsDelete, itemID = true)
					end
				end
			end
		end
	end
end

-- Обработчики событий
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
}

E.RegisterMyEventsToFrames(Octo_EventFrame_ItemsUsable, MyEventsTable, E.func_DebugPath())

function Octo_EventFrame_ItemsUsable:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	-- Создаем кнопку для usable items
	local Clickable_ItemsUsable = CreateFrame("Button", "Clickable_ItemsUsable", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
	Clickable_ItemsUsable:Hide()
	Clickable_ItemsUsable:SetSize(64*E.scale, 64*E.scale)
	Clickable_ItemsUsable:SetPoint("TOPLEFT", 0, 0)
	Clickable_ItemsUsable:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
	Clickable_ItemsUsable:SetBackdropBorderColor(1, 1, 1, 1)

	-- Обработчики наведения мыши
	Clickable_ItemsUsable:HookScript("OnEnter", function()
		GameTooltip:SetOwner(Clickable_ItemsUsable, "ANCHOR_BOTTOMRIGHT", 20, -20)
		GameTooltip:ClearLines()

		if Clickable_ItemsUsable.itemID then
			local itemLink = select(2, GetItemInfo(Clickable_ItemsUsable.itemID))
			GameTooltip:SetHyperlink(itemLink)
		else
			GameTooltip:SetText(E.Black_Color.."Clickable_ItemsUsable".."|r")
		end

		GameTooltip:Show()
		LibCustomGlow.AutoCastGlow_Start(
			Clickable_ItemsUsable, {.31, 1, .47, 1}, 4, 0.125, 1, nil, nil, 1
		)
	end)

	Clickable_ItemsUsable:HookScript("OnLeave", function()
		GameTooltip:Hide()
		LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsUsable)
	end)

	-- Настройки кнопки
	Clickable_ItemsUsable:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Clickable_ItemsUsable:SetAttribute("type", "macro")

	-- Текст кнопки
	Clickable_ItemsUsable.text = Clickable_ItemsUsable:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	Clickable_ItemsUsable.text:SetPoint("LEFT", Clickable_ItemsUsable, "RIGHT")
	Clickable_ItemsUsable.text:SetFontObject(OctoFont22)
	Clickable_ItemsUsable.text:SetText(E.func_GetAddOnMetadata(GlobalAddonName, "Version"))

	-- Иконка кнопки
	Clickable_ItemsUsable.icon = Clickable_ItemsUsable:CreateTexture(nil, "BACKGROUND")
	Clickable_ItemsUsable.icon:SetAllPoints(Clickable_ItemsUsable)
	Clickable_ItemsUsable.icon:SetTexture(413587)
end

function Octo_EventFrame_ItemsUsable:BAG_UPDATE_DELAYED()
	UpdateItemsUsableFrame()
end

function Octo_EventFrame_ItemsUsable:PLAYER_REGEN_DISABLED()
	local Clickable_ItemsUsable = _G.Clickable_ItemsUsable
	if Clickable_ItemsUsable and Clickable_ItemsUsable:IsShown() then
		Clickable_ItemsUsable:Hide()
	end
end

function Octo_EventFrame_ItemsUsable:PLAYER_REGEN_ENABLED()
	UpdateItemsUsableFrame()
end







local GlobalAddonName, E = ...
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

-----------------------------------------------------
local Octo_EventFrame_ItemsDelete = CreateFrame("Frame")
Octo_EventFrame_ItemsDelete:Hide()
-----------------------------------------------------

-- Cache frequently used functions
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemInfo = C_Item.GetItemInfo
local GetItemCount = C_Item.GetItemCount
local PickupContainerItem = C_Container.PickupContainerItem
local DeleteCursorItem = DeleteCursorItem

-- Local references for better performance
local Red_Color = E.Red_Color
local func_GetItemNameByID = E.func_GetItemNameByID
local OctoTable_itemID_ItemsDelete = E.OctoTable_itemID_ItemsDelete

function Octo_EventFrame_ItemsDelete:ItemsDeleteFrame()
	if InCombatLockdown() then return end

	local foundItem = false

	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and OctoTable_itemID_ItemsDelete[containerInfo.itemID] then
				local itemID = containerInfo.itemID
				local _, itemLink, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)

				Clickable_ItemsDelete:Show()
				Clickable_ItemsDelete:SetScript("OnClick", function()
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
					Clickable_ItemsDelete:Hide()
				end)

				Clickable_ItemsDelete.icon:SetTexture(itemTexture or 413587)
				Clickable_ItemsDelete.itemID = itemID
				Clickable_ItemsDelete.text:SetText(" "..GetItemCount(itemID, false, false, false).." "..Red_Color..func_GetItemNameByID(itemID).."|r")

				foundItem = true
				break
			end
		end
		if foundItem then break end
	end

	if not foundItem then
		Clickable_ItemsDelete:Hide()
		Clickable_ItemsDelete.icon:SetTexture(413587)
		Clickable_ItemsDelete.text:SetText("")
	end
end

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
}

E.RegisterMyEventsToFrames(Octo_EventFrame_ItemsDelete, MyEventsTable, E.func_DebugPath())

function Octo_EventFrame_ItemsDelete:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	local Clickable_ItemsDelete = CreateFrame("Button", "Clickable_ItemsDelete", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
	Clickable_ItemsDelete:Hide()
	Clickable_ItemsDelete:SetSize(64*E.scale, 64*E.scale)
	Clickable_ItemsDelete:SetPoint("TOPLEFT", 0, -128*E.scale)
	Clickable_ItemsDelete:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
	Clickable_ItemsDelete:SetBackdropBorderColor(1, 0, 0, 1)

	local function OnEnter()
		GameTooltip:SetOwner(Clickable_ItemsDelete, "ANCHOR_BOTTOMRIGHT", 20, -20)
		GameTooltip:ClearLines()

		if Clickable_ItemsDelete.itemID then
			local itemLink = select(2, GetItemInfo(Clickable_ItemsDelete.itemID))
			GameTooltip:SetHyperlink(itemLink)
		else
			GameTooltip:SetText(E.Black_Color.."Clickable_ItemsDelete".."|r")
		end
		GameTooltip:Show()

		LibCustomGlow.AutoCastGlow_Start(
			Clickable_ItemsDelete,
			{1, 0, 0, 1},
			4,
			0.125,
			1,
			nil,
			1
		)
	end

	local function OnLeave()
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsDelete)
	end

	Clickable_ItemsDelete:HookScript("OnEnter", OnEnter)
	Clickable_ItemsDelete:HookScript("OnLeave", OnLeave)
	Clickable_ItemsDelete:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Clickable_ItemsDelete:SetAttribute("type", "macro")

	Clickable_ItemsDelete.text = Clickable_ItemsDelete:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	Clickable_ItemsDelete.text:SetPoint("LEFT", Clickable_ItemsDelete, "RIGHT")
	Clickable_ItemsDelete.text:SetFontObject(OctoFont22)
	Clickable_ItemsDelete.text:SetText(E.func_GetAddOnMetadata(GlobalAddonName, "Version"))

	Clickable_ItemsDelete.icon = Clickable_ItemsDelete:CreateTexture(nil, "BACKGROUND")
	Clickable_ItemsDelete.icon:SetAllPoints(Clickable_ItemsDelete)
	Clickable_ItemsDelete.icon:SetTexture(413587)
end

function Octo_EventFrame_ItemsDelete:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:ItemsDeleteFrame()
	end
end

function Octo_EventFrame_ItemsDelete:PLAYER_REGEN_DISABLED()
	if Clickable_ItemsDelete then
		Clickable_ItemsDelete:Hide()
	end
end

function Octo_EventFrame_ItemsDelete:PLAYER_REGEN_ENABLED()
	self:ItemsDeleteFrame()
end