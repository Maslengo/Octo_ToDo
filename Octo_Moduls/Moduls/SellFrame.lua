local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local Octo_EventFrame_SellFrame = CreateFrame("Frame")
Octo_EventFrame_SellFrame:Hide()
Octo_EventFrame_SellFrame.BagAndSlot = {}
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local JustifyV = "MIDDLE" -- Вертикальное выравнивание
local JustifyH = "LEFT" -- Горизонтальное выравнивание
if not Octo_ToDo_DB_Vars.SellFrame then return end
----------------------------------------------------------------
-- Локальные переменные для работы с инвентарем
local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local UseContainerItem = C_Container.UseContainerItem
local GetItemCount = C_Item.GetItemCount
local GetItemInfo = C_Item.GetItemInfo

local QUALITY_COLORS = {}
for i = 0, 8 do  -- От серого (0) до эпика (4)
	QUALITY_COLORS[i] = ITEM_QUALITY_COLORS[i].color
end


----------------------------------------------------------------
local func_GetItemCount = function(...) return E:func_GetItemCount(...) end
local ignorelist = {}
for _, itemID in ipairs(E.OctoTable_itemID_Ignore_List) do
	ignorelist[itemID] = true
end
if not Octo_EventFrame_SellFrame.promise then
	Octo_EventFrame_SellFrame.promise = LibThingsLoad:Items(E.OctoTable_itemID_Ignore_List)
end
local BUTTON_SIZE = 32
local order = 0
local function CreateSellButton(Parentframe, texture, text, quality)
	if not quality then
		quality = 1
	end
	local color = ITEM_QUALITY_COLORS[quality].hex
	local r, g, b = QUALITY_COLORS[quality].r, QUALITY_COLORS[quality].g, QUALITY_COLORS[quality].b
	order = order + 1
	local button = CreateFrame("Button", nil, Parentframe, "BackdropTemplate")
	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	button:SetPoint("TOPRIGHT", 64, -((BUTTON_SIZE*2)*order))
	button:SetBackdrop(E.menuBackdrop)
	button:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	button:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	button:RegisterForClicks("LeftButtonUp")
	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetTexture("Interface\\Addons\\"..E.MainAddonName.."\\Media\\"..texture)
	button.icon:SetAllPoints(button)
	button.icon:SetVertexColor(r, g, b, 1)
	if text then
		button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		button.text:SetPoint("LEFT", button, "RIGHT")
		button.text:SetWidth(255)
		button.text:SetFontObject(OctoFont11) -- Используем наш шрифт
		button.text:SetWordWrap(false) -- Запрещаем перенос слов
		button.text:SetJustifyV(JustifyV)
		button.text:SetJustifyH(JustifyH)
		button.text:SetTextColor(textR, textG, textB, textA) -- Белый цвет текста
		button.text:SetText(color..text.."|r" )
	end
	return button
end
function Octo_EventFrame_SellFrame:func_SellItemsByQuality()
	for _, value in ipairs(Octo_EventFrame_SellFrame.BagAndSlot) do
		C_Container.UseContainerItem(value[1], value[2])
	end
end
local function BankTransfer(fromBank)
	local startBag, endBag
	if fromBank then
		startBag = REAGENTBANK_CONTAINER
		endBag = NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS
	else
		startBag = BACKPACK_CONTAINER
		endBag = NUM_TOTAL_EQUIPPED_BAG_SLOTS
	end
	for bag = startBag, endBag do
		for slot = 1, GetContainerNumSlots(bag) do
			if C_Container.GetContainerItemLink(bag, slot) then
				UseContainerItem(bag, slot)
			end
		end
	end
end
local tooltipLoad = {}
function Octo_EventFrame_SellFrame:TOOLTIP_DATA_UPDATE(dataInstanceID)
	local mount = tooltipLoad[dataInstanceID]
	if mount then
		local tooltipInfo = C_TooltipInfo.GetItemByID(mount.itemID)
		mount:updateFunc(tooltipInfo)
		tooltipLoad[dataInstanceID] = nil
		tooltipLoad[tooltipInfo.dataInstanceID] = mount
	end
end
Octo_EventFrame_SellFrame:RegisterEvent("TOOLTIP_DATA_UPDATE")
function CreateAndProcessTooltip(itemID)
	local vivod = false
	local m = {itemID = itemID}
	m.updateFunc = function(self, tooltipInfo)
		if tooltipInfo.lines then
			for i, v in ipairs(tooltipInfo.lines) do
				if v.price then
					-- print (v.price, itemID, E:func_texturefromIcon(E:func_GetItemIconByID(itemID))..E:func_GetItemNameByID(itemID))
					vivod = true
					break
				end
			end
		end
	end
	local tooltipInfo = C_TooltipInfo.GetItemByID(m.itemID)
	m:updateFunc(tooltipInfo)
	tooltipLoad[tooltipInfo.dataInstanceID] = m
	return vivod
end
-- Сортировка предметов для отображения в подсказке
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
-- Создание кнопок
function Octo_EventFrame_SellFrame:func_CreateTradeButtons()
	-- Настройки фильтрации
	local ITEM_TYPE_FILTERS = {
		WEAPON = {
			-- Все виды оружия
			INVTYPE_WEAPON = true,
			INVTYPE_WEAPONMAINHAND = true,
			INVTYPE_WEAPONOFFHAND = true,
			INVTYPE_RANGED = true,
			INVTYPE_RANGEDRIGHT = true,
			INVTYPE_2HWEAPON = true,
			INVTYPE_HOLDABLE = true
		},
		ARMOR = {
			-- Все виды брони (кроме аксессуаров)
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
			INVTYPE_ROBE = true,
			INVTYPE_SHIELD = true
		},
		ACCESSORY = {
			-- Аксессуары
			INVTYPE_NECK = true,
			INVTYPE_FINGER = true,
			INVTYPE_TRINKET = true
		},
		CONSUMABLE = {
			-- Расходуемые предметы
			Consumable = true
		}
	}

	-- Функция проверки типа предмета
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

	-- Создаем кнопки для разных качеств предметов
	for _, i in ipairs({0, 3, 4}) do -- 0 COMMON, 3 RARE, 4 EPIC
	-- for i = 0, 8 do
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
					end
					UIDropDownMenu_AddButton(info)
				end
		end)

		OctoFrame_SellOtherBlue:SetScript("OnClick", function()
				self:func_SellItemsByQuality(OctoFrame_SellOtherBlue.currentFilter)
		end)

		OctoFrame_SellOtherBlue:SetScript("OnEnter", function()
				wipe(self.BagAndSlot)
				local UsableTBL = {}
				local totalMoney = 0
				local currentFilter = OctoFrame_SellOtherBlue.currentFilter

				for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					local numSlots = GetContainerNumSlots(bag)
					for slot = numSlots, 1, -1 do
						local containerInfo = GetContainerItemInfo(bag, slot)
						if containerInfo and not ignorelist[containerInfo.itemID] then
							local itemID = containerInfo.itemID
							local quality = containerInfo.quality
							local hyperlink = containerInfo.hyperlink
							local _, _, _, _, _, itemClass, _, _, itemEquipLoc, _, sellPrice = GetItemInfo(hyperlink)

							if sellPrice and sellPrice ~= 0 and quality and quality <= Blue_quality
							and CreateAndProcessTooltip(itemID)
							and IsItemInCategory(itemEquipLoc, itemClass, currentFilter) then

								table.insert(self.BagAndSlot, {bag, slot})

								if not UsableTBL[itemID] then
									local itemCount = func_GetItemCount(itemID, false, false, false, false)
									local itemTotalPrice = sellPrice * itemCount
									totalMoney = totalMoney + itemTotalPrice

									UsableTBL[itemID] = {
										count = itemCount,
										quality = quality,
										sellPrice = sellPrice,
										itemName = E:func_texturefromIcon(E:func_GetItemIconByID(itemID))..E:func_GetItemNameByID(itemID, quality),
										itemType = itemEquipLoc
									}
								end
							end
						end
					end
				end

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

				OctoFrame_SellOtherBlue.tooltip = SellOther_tooltip
				E:func_OctoTooltip_OnEnter(OctoFrame_SellOtherBlue)
		end)
	end
end
local function CreateBankButtons()
	local OctoFrame_FROMBANK = CreateSellButton(BankFrame, "Arrow6.tga", "OctoFrame_FROMBANK")
	OctoFrame_FROMBANK:SetScript("OnClick", function() BankTransfer(true) end)
	local OctoFrame_TOBANK = CreateSellButton(BankFrame, "Arrow6.tga", "OctoFrame_TOBANK")
	OctoFrame_TOBANK:SetScript("OnClick", function() BankTransfer(false) end)
end
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_SellFrame, MyEventsTable)
function Octo_EventFrame_SellFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	self:func_CreateTradeButtons()
	CreateBankButtons()
end