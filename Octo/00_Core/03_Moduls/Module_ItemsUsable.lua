local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end



local LibCustomGlow = LibStub("LibCustomGlow-1.0")-- Подключаем библиотеку для свечения кнопок
-- Создаем кнопки для использования и удаления предметов
local Clickable_ItemsUsable = CreateFrame("Button", "Clickable_ItemsUsable", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
local Clickable_ItemsDelete = CreateFrame("Button", "Clickable_ItemsDelete", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
-- Локальные переменные для работы с инвентарем
local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemCount = C_Item.GetItemCount
local GetItemInfo = C_Item.GetItemInfo
-- Функции из основной таблицы аддона
local GetItemLink = E.func_GetItemLink
local GetItemQualityColorID = E.func_GetItemQualityColorID
local itemName = E.func_GetItemNameByID
local coloredText = E.func_coloredText
-- Функции для работы с предметами
local PickupContainerItem = C_Container.PickupContainerItem
local DeleteCursorItem = DeleteCursorItem
-- Создаем фрейм для обработки событий
local Octo_EventFrame_Items = CreateFrame("Frame")
Octo_EventFrame_Items:Hide()
-- Создаем tooltip для проверки, можно ли использовать предмет
local inspectScantipUsable = CreateFrame("GameTooltip", "OctoScanningTooltipUsable", nil, "GameTooltipTemplate")
inspectScantipUsable:SetOwner(UIParent, "ANCHOR_NONE")
-- Функция для настройки общих параметров кнопок
function Octo_EventFrame_Items:CreateCommonButtonSettings(button, pointY, borderColor)
	button:Hide()
	button:SetSize(48, 48)-- Размер кнопки
	button:SetPoint("TOPLEFT", 0, pointY)-- Позиция кнопки
	-- Настройка фона и границы
	button:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
	button:SetBackdropBorderColor(unpack(borderColor))
	-- Текст рядом с кнопкой
	button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	button.text:SetPoint("LEFT", button, "RIGHT")
	button.text:SetFontObject(OctoFont22)
	button.text:SetText(E.func_GetAddOnMetadata(GlobalAddonName, "Version"))
	-- Иконка предмета на кнопке
	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints(button)
	button.icon:SetTexture(413587)-- Текстура по умолчанию
	-- Обработчики наведения мыши
	button:SetScript("OnEnter", function()
			GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT", 20, -20)
			GameTooltip:ClearLines()
			if button.itemID then
				-- Показываем информацию о предмете
				local itemLink = select(2, GetItemInfo(button.itemID))
				GameTooltip:SetHyperlink(itemLink)
			else
				-- Или просто название кнопки
				GameTooltip:SetText(E.Black_Color..button:GetName().."|r")
			end
			GameTooltip:Show()
	end)
	button:HookScript("OnLeave", function()
			GameTooltip:Hide()
	end)
	return button
end
-- Функция проверки, можно ли использовать предмет
local function IsItemUsable(itemLink)
	if not itemLink then return false end
	-- Используем tooltip для анализа текста
	inspectScantipUsable:ClearLines()
	inspectScantipUsable:SetHyperlink(itemLink)
	-- Проверяем все строки tooltip'а
	for i = 1, inspectScantipUsable:NumLines() do
		local leftText = coloredText(_G["OctoScanningTooltipUsableTextLeft"..i])
		local rightText = coloredText(_G["OctoScanningTooltipUsableTextRight"..i])
		-- Ищем красный текст (признак того, что предмет нельзя использовать)
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
	return true-- Если красного текста нет, предмет можно использовать
end
-- Обновление кнопки для использования предметов
function Octo_EventFrame_Items:UpdateItemsUsableFrame()
	if InCombatLockdown() then return end-- Не обновляем в бою
	if not Clickable_ItemsUsable then return end
	-- Сбрасываем кнопку
	Clickable_ItemsUsable:Hide()
	Clickable_ItemsUsable.icon:SetTexture(413587)
	Clickable_ItemsUsable.text:SetText("")
	-- Перебираем все сумки и слоты
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and containerInfo.itemID then
				local itemID = containerInfo.itemID
				-- Проверяем, есть ли предмет в списке для использования
				local requiredCount = E.OctoTable_itemID_ItemsUsable[itemID]
				if requiredCount and not E.OctoTable_itemID_Ignore_List[itemID] and GetItemCount(itemID) >= requiredCount then
					local itemLink = GetItemLink(itemID)
					-- Проверяем, можно ли использовать предмет
					if IsItemUsable(itemLink) then
						-- Настраиваем кнопку
						Clickable_ItemsUsable:Show()
						Clickable_ItemsUsable:SetAttribute("macrotext", "/use item:"..itemID)
						local texture = select(10, GetItemInfo(itemID)) or 413587
						Clickable_ItemsUsable.icon:SetTexture(texture)
						-- Устанавливаем цвет границы по качеству предмета
						local RGB = GetItemQualityColorID(itemID)
						if RGB then
							Clickable_ItemsUsable:SetBackdropBorderColor(RGB.r, RGB.g, RGB.b, 1)
						end
						-- Устанавливаем текст с количеством и названием предмета
						Clickable_ItemsUsable.itemID = itemID
						Clickable_ItemsUsable.text:SetText(" "..GetItemCount(itemID, true, true, true).." "..itemName(itemID))
						return-- Нашли предмет - выходим
					-- else
					-- 	-- Если предмет нельзя использовать, добавляем его в список на удаление
					-- 	if not E.OctoTable_itemID_ItemsDelete[itemID] then
					-- 		DEFAULT_CHAT_FRAME:AddMessage(itemName(itemID), E.func_Gradient("mark to DELETE"))
					-- 		E.OctoTable_itemID_ItemsDelete[itemID] = true
					-- 	end
					end
				end
			end
		end
	end
end
-- Обновление кнопки для удаления предметов
function Octo_EventFrame_Items:UpdateItemsDeleteFrame()
	if InCombatLockdown() then return end-- Не обновляем в бою
	if not Clickable_ItemsDelete then return end
	-- Сбрасываем кнопку
	Clickable_ItemsDelete:Hide()
	Clickable_ItemsDelete.icon:SetTexture(413587)
	Clickable_ItemsDelete.text:SetText("")
	-- Перебираем все сумки и слоты
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			-- Проверяем, есть ли предмет в списке на удаление
			if containerInfo and E.OctoTable_itemID_ItemsDelete[containerInfo.itemID] then
				local itemID = containerInfo.itemID
				local _, itemLink, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)
				-- Настраиваем кнопку
				Clickable_ItemsDelete:Show()
				Clickable_ItemsDelete:SetScript("OnClick", function()
						-- Удаляем предмет при клике
						PickupContainerItem(bag, slot)
						DeleteCursorItem()
						Clickable_ItemsDelete:Hide()
				end)
				Clickable_ItemsDelete.icon:SetTexture(itemTexture or 413587)
				Clickable_ItemsDelete.itemID = itemID
				-- Красный текст для предметов на удаление
				Clickable_ItemsDelete.text:SetText(" "..GetItemCount(itemID, false, false, false).." "..E.Red_Color..itemName(itemID).."|r")
				return-- Нашли предмет - выходим
			end
		end
	end
end
-- Таблица событий, на которые реагирует аддон
local MyEventsTable = {
	"ADDON_LOADED",-- При загрузке аддона
	"BAG_UPDATE_DELAYED",-- При изменении содержимого сумок
	"PLAYER_REGEN_DISABLED", -- При входе в бой
	"PLAYER_REGEN_ENABLED",-- При выходе из боя
}
-- Регистрируем события
E.RegisterMyEventsToFrames(Octo_EventFrame_Items, MyEventsTable)
-- Обработчик события загрузки аддона
function Octo_EventFrame_Items:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	-- Отписываемся от события после загрузки
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	-- Настраиваем кнопку для использования предметов
	self:CreateCommonButtonSettings(Clickable_ItemsUsable, 0, {1, 1, 1, 1})
	Clickable_ItemsUsable:SetAttribute("type", "macro")
	-- Добавляем свечение при наведении
	Clickable_ItemsUsable:HookScript("OnEnter", function()
			LibCustomGlow.AutoCastGlow_Start(Clickable_ItemsUsable, {.31, 1, .47, 1}, 4, 0.125, 1, nil, nil, 1)
	end)
	Clickable_ItemsUsable:HookScript("OnLeave", function()
			LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsUsable)
	end)
	Clickable_ItemsUsable:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Clickable_ItemsUsable:SetAttribute("type", "macro")
	-- Настраиваем кнопку для удаления предметов
	self:CreateCommonButtonSettings(Clickable_ItemsDelete, -128, {1, 0, 0, 1})
	-- Добавляем красное свечение при наведении
	Clickable_ItemsDelete:HookScript("OnEnter", function()
			LibCustomGlow.AutoCastGlow_Start(Clickable_ItemsDelete, {1, 0, 0, 1}, 4, 0.125, 1, nil, 1)
	end)
	Clickable_ItemsDelete:HookScript("OnLeave", function()
			LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsDelete)
	end)
end
-- Обработчик изменения содержимого сумок
function Octo_EventFrame_Items:BAG_UPDATE_DELAYED()
	self:UpdateItemsUsableFrame()-- Обновляем кнопку использования
	self:UpdateItemsDeleteFrame()-- Обновляем кнопку удаления
end
-- Обработчик выхода из боя
function Octo_EventFrame_Items:PLAYER_REGEN_ENABLED()
	self:UpdateItemsUsableFrame()-- Обновляем кнопку использования
	self:UpdateItemsDeleteFrame()-- Обновляем кнопку удаления
end
-- Обработчик входа в бой
function Octo_EventFrame_Items:PLAYER_REGEN_DISABLED()
	-- Скрываем кнопки в бою
	if Clickable_ItemsUsable then Clickable_ItemsUsable:Hide() end
	if Clickable_ItemsDelete then Clickable_ItemsDelete:Hide() end
end