local GlobalAddonName, ns = ...
E = _G.OctoEngine

----------------------------------------------------------------
-- Константы модуля
----------------------------------------------------------------
local BUTTON_SIZE = 32 -- Размер кнопок продажи/перемещения
local QUALITY_COLORS = {} -- Цвета для качеств предметов
for i = 0, 8 do -- От серого (0) до эпика (4)
	QUALITY_COLORS[i] = ITEM_QUALITY_COLORS[i].color
end

-- Фильтры по типам предметов
local ITEM_TYPE_FILTERS = {
	WEAPON = {
		INVTYPE_WEAPON = true,
		INVTYPE_WEAPONMAINHAND = true,
		INVTYPE_WEAPONOFFHAND = true,
		INVTYPE_RANGED = true,
		INVTYPE_RANGEDRIGHT = true,
		INVTYPE_2HWEAPON = true,
		INVTYPE_HOLDABLE = true
	},
	ARMOR = {
		INVTYPE_HEAD = true,
		INVTYPE_NECK = false,
		INVTYPE_SHOULDER = true,
		INVTYPE_BODY = true,
		INVTYPE_CHEST = true,
		INVTYPE_WAIST = true,
		INVTYPE_LEGS = true,
		INVTYPE_FEET = true,
		INVTYPE_WRIST = true,
		INVTYPE_HAND = true,
		INVTYPE_CLOAK = true,
		INVTYPE_SHIELD = true
	},
	ACCESSORY = {
		INVTYPE_NECK = true,
		INVTYPE_FINGER = true,
		INVTYPE_TRINKET = true
	},
	CONSUMABLE = {
		Consumable = true
	}
}

----------------------------------------------------------------
-- Инициализация фрейма
----------------------------------------------------------------
local Octo_EventFrame_SellFrame = CreateFrame("Frame")
Octo_EventFrame_SellFrame:Hide()
Octo_EventFrame_SellFrame.BagAndSlot = {} -- Таблица для хранения слотов предметов для продажи

local LibThingsLoad = LibStub("LibThingsLoad-1.0")

-- Цвета интерфейса
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local JustifyV = "MIDDLE" -- Вертикальное выравнивание
local JustifyH = "LEFT" -- Горизонтальное выравнивание

if not Octo_ToDo_DB_Vars.SellFrame then return end

----------------------------------------------------------------
-- Локальные переменные для работы с инвентарем
----------------------------------------------------------------
local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local UseContainerItem = C_Container.UseContainerItem
local GetItemCount = C_Item.GetItemCount
local GetItemInfo = C_Item.GetItemInfo
local GetContainerItemID = C_Container.GetContainerItemID

local func_GetItemCount = function(...) return E:func_GetItemCount(...) end

-- Игнорируемые предметы (не для продажи)
local ignorelist = {}
for _, itemID in ipairs(E.OctoTable_itemID_Ignore_List) do
	ignorelist[itemID] = true
end

-- Загрузка информации о предметах
if not Octo_EventFrame_SellFrame.promise then
	Octo_EventFrame_SellFrame.promise = LibThingsLoad:Items(E.OctoTable_itemID_Ignore_List)
end

local order = 0 -- Порядок отображения кнопок
local activeTooltipButton = nil -- Активная кнопка, для которой отображается тултип
local tooltipLoad = {} -- Кэш для загрузки тултипов

----------------------------------------------------------------
-- Вспомогательные функции
----------------------------------------------------------------

--- Создает кнопку для продажи/перемещения предметов
-- @param Parentframe Родительский фрейм
-- @param texture Текстура кнопки
-- @param text Текст кнопки (опционально)
-- @param quality Качество предмета для фильтрации (опционально)
-- @return Созданная кнопка
local function CreateSellButton(Parentframe, texture, text, quality)
	quality = quality or 1
	local color = ITEM_QUALITY_COLORS[quality].hex
	local r, g, b = QUALITY_COLORS[quality].r, QUALITY_COLORS[quality].g, QUALITY_COLORS[quality].b

	order = order + 1
	local button = CreateFrame("Button", "Octo_MainFrame_SellFrame"..order, Parentframe, "BackdropTemplate")
	-- button:SetFrameStrata("BACKGROUND")
	-- button:SetFrameLevel(button:GetParent():GetFrameLevel() + 10)
	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	button:SetPoint("TOPRIGHT", 64, -((BUTTON_SIZE*2)*order))
	button:SetBackdrop(E.menuBackdrop)
	button:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	button:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	button:RegisterForClicks("LeftButtonUp")

	-- Иконка кнопки
	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetTexture("Interface\\Addons\\"..E.MainAddonName.."\\Media\\"..texture)
	button.icon:SetAllPoints(button)
	button.icon:SetVertexColor(r, g, b, 1)
	button.quality = quality -- Сохраняем качество для фильтрации

	-- Текст кнопки (если указан)
	if text then
		button.text = button:CreateFontString()
		button.text:SetFontObject(OctoFont11)
		button.text:SetPoint("LEFT", button, "RIGHT")
		button.text:SetWidth(255)
		button.text:SetWordWrap(false)
		button.text:SetJustifyV(JustifyV)
		button.text:SetJustifyH(JustifyH)
		button.text:SetTextColor(textR, textG, textB, textA)
		button.text:SetText(color..text.."|r")
	end

	-- Подсветка при наведении
	button:SetScript("OnEnter", function(self)
			self.icon:SetVertexColor(1, 1, 1, 1)
	end)

	button:SetScript("OnLeave", function(self)
			self.icon:SetVertexColor(r, g, b, 1)
	end)
	return button
end

--- Проверяет, принадлежит ли предмет к указанной категории
-- @param itemEquipLoc Тип предмета (слот экипировки)
-- @param itemClass Класс предмета
-- @param category Категория для проверки
-- @return true если предмет принадлежит категории
local function IsItemInCategory(itemEquipLoc, itemClass, category)
	if not category then return true end
	if category == "WEAPON" then
		return ITEM_TYPE_FILTERS.WEAPON[itemEquipLoc] or itemClass == LE_ITEM_CLASS_WEAPON
	elseif category == "ARMOR" then
		return ITEM_TYPE_FILTERS.ARMOR[itemEquipLoc] or
		(itemClass == LE_ITEM_CLASS_ARMOR and not ITEM_TYPE_FILTERS.ACCESSORY[itemEquipLoc])
	elseif category == "ACCESSORY" then
		return ITEM_TYPE_FILTERS.ACCESSORY[itemEquipLoc]
	elseif category == "CONSUMABLE" then
		return itemClass == LE_ITEM_CLASS_CONSUMABLE
	end
	return false
end

--- Сортировка предметов для отображения в тултипе
-- @param a Первый предмет для сравнения
-- @param b Второй предмет для сравнения
-- @return true если a должен быть выше b в списке
local function func_SortItems(a, b)
	if a.totalPrice ~= b.totalPrice then
		return a.totalPrice > b.totalPrice -- Сначала дорогие
	elseif a.sellPrice ~= b.sellPrice then
		return a.sellPrice > b.sellPrice -- Затем по цене за штуку
	elseif a.count ~= b.count then
		return a.count > b.count -- Большие стаки выше
	end
	return a.itemID > b.itemID -- Если всё одинаково, сортируем по ID
end

----------------------------------------------------------------
-- Функции работы с банком
----------------------------------------------------------------

--- Перемещает предметы между банком и инвентарем
-- @param fromBank Если true, перемещает из банка в инвентарь, иначе наоборот
local function BankTransfer(fromBank)
	local startBag, endBag

	if fromBank then
		startBag = REAGENTBANK_CONTAINER
		endBag = NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS
	else
		startBag = BACKPACK_CONTAINER
		endBag = NUM_TOTAL_EQUIPPED_BAG_SLOTS
	end

	-- Защита от повторного клика
	if not E.fromBank_lock then
		E.fromBank_lock = true
		C_Timer.After(1, function() E.fromBank_lock = false end)

		for bag = startBag, endBag do
			for slot = 1, GetContainerNumSlots(bag) do
				local itemLink = C_Container.GetContainerItemLink(bag, slot)
				if itemLink then
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

--- Создает кнопки для работы с банком
local function CreateBankButtons()
	local OctoFrame_FROMBANK = CreateSellButton(BankFrame, "FROMBANK.tga", "OctoFrame_FROMBANK")
	OctoFrame_FROMBANK:SetScript("OnClick", function()
			-- Добавляем подтверждение для массового перемещения
			StaticPopup_Show("OCTO_CONFIRM_BANK_TRANSFER", nil, nil, {fromBank = false})
	end)

	local OctoFrame_TOBANK = CreateSellButton(BankFrame, "TOBANK.tga", "OctoFrame_TOBANK")
	OctoFrame_TOBANK:SetScript("OnClick", function()
			StaticPopup_Show("OCTO_CONFIRM_BANK_TRANSFER", nil, nil, {fromBank = true})
	end)

	-- Диалог подтверждения
	StaticPopupDialogs["OCTO_CONFIRM_BANK_TRANSFER"] = {
		text = "Вы уверены, что хотите переместить все предметы?",
		button1 = YES,
		button2 = NO,
		OnAccept = function(self, data)
			BankTransfer(data.fromBank)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true
	}
end

----------------------------------------------------------------
-- Функции работы с тултипами
----------------------------------------------------------------

--- Обрабатывает событие обновления данных тултипа
function Octo_EventFrame_SellFrame:TOOLTIP_DATA_UPDATE(dataInstanceID)
	local mount = tooltipLoad[dataInstanceID]
	if mount then
		local tooltipInfo = C_TooltipInfo.GetItemByID(mount.itemID)
		if tooltipInfo then
			mount:updateFunc(tooltipInfo)
			tooltipLoad[dataInstanceID] = nil
			tooltipLoad[tooltipInfo.dataInstanceID] = mount
		end
	end
end

--- Создает и обрабатывает тултип для предмета
-- @param itemID ID предмета
-- @return true если предмет имеет цену продажи
local function CreateAndProcessTooltip(itemID)
	local hasPrice = false
	local tooltipData = {itemID = itemID}

	tooltipData.updateFunc = function(self, tooltipInfo)
		if tooltipInfo and tooltipInfo.lines then
			for i, v in ipairs(tooltipInfo.lines) do
				if v.price then
					hasPrice = true
					break
				end
			end
		end
	end

	local tooltipInfo = C_TooltipInfo.GetItemByID(tooltipData.itemID)
	if tooltipInfo then
		tooltipData:updateFunc(tooltipInfo)
		tooltipLoad[tooltipInfo.dataInstanceID] = tooltipData
	end

	return hasPrice
end

--- Обновляет информацию в тултипе для кнопки
-- @param button Кнопка, для которой обновляется тултип
local function UpdateTooltip(button)
	wipe(Octo_EventFrame_SellFrame.BagAndSlot)
	local UsableTBL = {}
	local totalMoney = 0
	local currentFilter = button.currentFilter

	-- Оптимизированный проход по инвентарю
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		for slot = numSlots, 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and not ignorelist[containerInfo.itemID] then
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				local hyperlink = containerInfo.hyperlink

				-- Кэшируем информацию о предмете
				local itemName, _, _, _, _, itemClass, _, _, itemEquipLoc, _, sellPrice = GetItemInfo(hyperlink)
				if itemName and sellPrice and sellPrice ~= 0 and quality and quality <= button.quality
				and CreateAndProcessTooltip(itemID)
				and IsItemInCategory(itemEquipLoc, itemClass, currentFilter) then

					table.insert(Octo_EventFrame_SellFrame.BagAndSlot, {bag, slot})

					if not UsableTBL[itemID] then
						local itemCount = func_GetItemCount(itemID, false, false, false, false)
						local itemTotalPrice = sellPrice * itemCount
						totalMoney = totalMoney + itemTotalPrice

						UsableTBL[itemID] = {
							count = itemCount,
							quality = quality,
							sellPrice = sellPrice,
							itemName = E:func_itemName(itemID, quality),
							itemType = itemEquipLoc
						}
					end
				end
			end
		end
	end

	-- Сортировка предметов для отображения
	local sorted_itemList = {}
	for itemID, v in next, (UsableTBL) do
		table.insert(sorted_itemList, {
				itemID = itemID,
				count = v.count,
				quality = v.quality,
				sellPrice = v.sellPrice,
				totalPrice = v.count * v.sellPrice,
				itemName = v.itemName,
				itemType = v.itemType
		})
	end
	table.sort(sorted_itemList, func_SortItems)

	-- Формирование данных для тултипа
	local SellOther_tooltip = {}
	SellOther_tooltip[#SellOther_tooltip+1] = {" ", TOTAL..": "..E:func_MoneyString(totalMoney)}

	for _, item in ipairs(sorted_itemList) do
		local displayText = E:func_MoneyString(item.totalPrice)
		if item.count > 1 then
			displayText = E.Blue_Color.."x"..item.count.."|r "..displayText
		end
		table.insert(SellOther_tooltip, {
				item.itemName,
				displayText
		})
	end

	button.tooltip = SellOther_tooltip

	-- Обновляем тултип, если он сейчас отображается
	if activeTooltipButton == button then
		E.func_OctoTooltip_OnEnter(button)
	end
end

----------------------------------------------------------------
-- Функции продажи предметов
----------------------------------------------------------------

--- Продает предметы по качеству
function Octo_EventFrame_SellFrame:func_SellItemsByQuality()
	-- Защита от повторного клика
	if self.sellLock then return end
	self.sellLock = true

	-- Обновляем список предметов перед продажей
	UpdateTooltip(activeTooltipButton)

	local totalItems = #self.BagAndSlot
	if totalItems == 0 then
		-- print("Нет предметов для продажи.")
		self.sellLock = false
		return
	end

	-- Создаем свой фрейм для отображения прогресса
	if not self.progressFrame then
		self.progressFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
		self.progressFrame:SetSize(300, 80)
		self.progressFrame:SetPoint("CENTER")
		self.progressFrame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 32, edgeSize = 32,
			insets = { left = 11, right = 12, top = 12, bottom = 11 }
		})

		self.progressFrame.text = self.progressFrame:CreateFontString()
		self.progressFrame.text:SetFontObject(OctoFont11)
		self.progressFrame.text:SetPoint("TOP", 0, -15)
		self.progressFrame.text:SetText("Продажа предметов...")

		self.progressFrame.progressText = self.progressFrame:CreateFontString()
		self.progressFrame.progressText:SetFontObject(OctoFont11)
		self.progressFrame.progressText:SetPoint("CENTER", 0, 0)

		self.progressFrame.cancelButton = CreateFrame("Button", nil, self.progressFrame, "UIPanelButtonTemplate")
		self.progressFrame.cancelButton:SetSize(100, 25)
		self.progressFrame.cancelButton:SetPoint("BOTTOM", 0, 10)
		self.progressFrame.cancelButton:SetText("Отмена")
		self.progressFrame.cancelButton:SetScript("OnClick", function()
			self.sellLock = false
			self.progressFrame:Hide()
		end)
	end

	-- Показываем наш фрейм прогресса
	self.progressFrame.progressText:SetFormattedText("Осталось: %d/%d", totalItems, totalItems)
	self.progressFrame:Show()

	-- Функция для продажи одного предмета
	local function SellNextItem()
		if #self.BagAndSlot == 0 or not self.sellLock then
			-- Все продано или процесс отменен
			self.progressFrame:Hide()
			self.sellLock = false
			-- print("Продажа завершена!")
			return
		end

		-- Берем первый предмет из списка
		local item = table.remove(self.BagAndSlot, 1)
		C_Container.UseContainerItem(item[1], item[2])

		-- Обновляем прогресс
		self.progressFrame.progressText:SetFormattedText("Осталось: %d/%d", #self.BagAndSlot, totalItems)

		-- Планируем следующую продажу через 0.3 секунды
		C_Timer.After(0.3, SellNextItem)
	end

	-- Начинаем процесс продажи
	SellNextItem()
end

----------------------------------------------------------------
-- Создание кнопок интерфейса
----------------------------------------------------------------

--- Создает кнопки для продажи предметов
function Octo_EventFrame_SellFrame:func_CreateTradeButtons()
	-- Создаем кнопки для разных качеств предметов
	for _, i in ipairs({3, 4}) do -- 0 COMMON, 3 RARE, 4 EPIC
		local text = "OctoFrame_SellOtherBlue"
		local Blue_quality = i
		local OctoFrame_SellOtherBlue = CreateSellButton(MerchantFrame, "Arrow72.tga", nil, Blue_quality)

		-- Создаем меню фильтров
		OctoFrame_SellOtherBlue.filterMenu = CreateFrame("Frame", "OctoFilterMenu_"..i, OctoFrame_SellOtherBlue, "UIDropDownMenuTemplate")
		OctoFrame_SellOtherBlue.filterMenu:SetPoint("TOPLEFT", OctoFrame_SellOtherBlue, "TOPRIGHT", 5, 0)
		UIDropDownMenu_SetWidth(OctoFrame_SellOtherBlue.filterMenu, 120)
		UIDropDownMenu_SetText(OctoFrame_SellOtherBlue.filterMenu, ALL)

		local filterOptions = {
			{text = ALL, value = nil},
			{text = WEAPON, value = "WEAPON"},
			{text = AUCTION_CATEGORY_ARMOR, value = "ARMOR"},
			{text = HEIRLOOMS_CATEGORY_TRINKETS_RINGS_AND_NECKLACES, value = "ACCESSORY"},
			{text = BANK_TAB_ASSIGN_CONSUMABLES_CHECKBOX, value = "CONSUMABLE"}
		}

		UIDropDownMenu_Initialize(OctoFrame_SellOtherBlue.filterMenu, function(self)
				for _, option in ipairs(filterOptions) do
					local info = UIDropDownMenu_CreateInfo()
					info.text = option.text
					info.value = option.value
					info.func = function()
						UIDropDownMenu_SetSelectedValue(self, info.value)
						UIDropDownMenu_SetText(self, info.text)
						OctoFrame_SellOtherBlue.currentFilter = info.value
						if activeTooltipButton == OctoFrame_SellOtherBlue then
							UpdateTooltip(OctoFrame_SellOtherBlue)
						end
					end
					UIDropDownMenu_AddButton(info)
				end
		end)

		OctoFrame_SellOtherBlue:SetScript("OnClick", function()
				self:func_SellItemsByQuality()
		end)

		OctoFrame_SellOtherBlue:SetScript("OnEnter", function()
				activeTooltipButton = OctoFrame_SellOtherBlue
				UpdateTooltip(OctoFrame_SellOtherBlue)
				E.func_OctoTooltip_OnEnter(OctoFrame_SellOtherBlue)
		end)

		OctoFrame_SellOtherBlue:SetScript("OnLeave", function()
				activeTooltipButton = nil
		end)
	end
end

----------------------------------------------------------------
-- Обработчики событий
----------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
	"MERCHANT_UPDATE",
	"TOOLTIP_DATA_UPDATE",
	"MERCHANT_CLOSED",
}

E:func_RegisterMyEventsToFrames(Octo_EventFrame_SellFrame, MyEventsTable)

--- Обрабатывает событие загрузки аддона
function Octo_EventFrame_SellFrame:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")
	self.VARIABLES_LOADED = nil
	self:func_CreateTradeButtons()
	CreateBankButtons()
end

--- Обрабатывает событие обновления торговца
function Octo_EventFrame_SellFrame:MERCHANT_UPDATE()
	if activeTooltipButton and OctoTooltip:IsShown() then
		UpdateTooltip(activeTooltipButton)
	end
end


function Octo_EventFrame_SellFrame:MERCHANT_CLOSED()
	if self.sellLock then
		self.sellLock = false
		self.progressFrame:Hide()
	end
end