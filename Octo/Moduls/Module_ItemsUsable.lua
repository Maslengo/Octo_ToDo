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
local itemName = E.func_itemName
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
	Clickable_ItemsUsable.text:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))

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