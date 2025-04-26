local GlobalAddonName, E = ...
local ltl = LibStub("LibThingsLoad-1.0")

-- SellFrame
tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.SellFrame then return end

	-- Сортировка и создание таблицы игнорируемых предметов
	sort(E.OctoTable_itemID_Ignore_List, E.func_Reverse_order)
	local ignorelist = {}
	for _, itemID in pairs(E.OctoTable_itemID_Ignore_List) do
		ignorelist[itemID] = true
	end

	local size = 32
	local bgColor = {14/255, 14/255, 14/255, 0.8}
	local avgItemLevelEquipped = select(2, GetAverageItemLevel())
	local ilvlStr = avgItemLevelEquipped or 0

	-- Локальные переменные для фреймов
	local OctoFrame_Events, OctoFrame_SellALLGRAY, OctoFrame_SellConsumable, OctoFrame_SellOther
	local OctoFrame_SellOtherFiolet, OctoFrame_SellAll, OctoFrame_FROMBANK, OctoFrame_TOBANK

	-- Общие функции
	local function SetQAButtonGameTooltip(button, text)
		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:SetText(text)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", GameTooltip.Hide)
	end

	local function CreateSellButton(name, texture, tooltip, x, y)
		local button = CreateFrame("Button", E.func_AddonTitle(GlobalAddonName)..E.func_GenerateUniqueID(), UIParent, "BackdropTemplate")
		button:SetSize(size*E.scale, size*E.scale)
		button:SetFrameStrata("LOW")
		button:EnableMouse(true)
		button:SetMovable(true)
		button:RegisterForDrag("RightButton")
		button:SetScript("OnDragStart", button.StartMoving)
		button:SetScript("OnDragStop", button.StopMovingOrSizing)
		button:SetPoint("CENTER", x, y)

		button:SetBackdrop({
			bgFile = format("Interface\\Addons\\%s\\Media\\border\\01 Octo.tga", GlobalAddonName),
			edgeFile = format("Interface\\Addons\\%s\\Media\\border\\01 Octo.tga", GlobalAddonName),
			edgeSize = 1,
		})
		button:SetBackdropColor(unpack(bgColor))
		button:SetBackdropBorderColor(0, 0, 0, 1)
		button:RegisterForClicks("LeftButtonUp")

		button.icon = button:CreateTexture(nil, "ARTWORK")
		button.icon:SetTexture(format("Interface\\AddOns\\%s\\Media\\%s", GlobalAddonName, texture))
		button.icon:SetAllPoints(button)

		if tooltip then
			SetQAButtonGameTooltip(button, tooltip)
		end

		return button
	end

	local function ScanItemTooltip(itemLink)
		local ItemTooltip = _G["OctoScanningTooltip"] or CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
		ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		ItemTooltip:ClearLines()
		ItemTooltip:SetHyperlink(itemLink)

		local itemLevel
		for i = 1, ItemTooltip:NumLines() do
			local text = _G["OctoScanningTooltipTextLeft"..i]:GetText()
			itemLevel = text and text:match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
			if itemLevel then break end
		end

		return tonumber(itemLevel) or 0
	end

	-- Функции для кнопок
	local function SellGrayItems()
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info then
					local _, _, rarity, _, _, _, _, _, _, _, price = GetItemInfo(info.itemID)
					if rarity == 0 and price ~= 0 then
						C_Container.UseContainerItem(bag, slot)
					end
				end
			end
		end
	end

	local function SellConsumables()
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info then
					local classID = select(12, GetItemInfo(info.itemID))
					if classID == 0 then -- Consumables
						C_Container.UseContainerItem(bag, slot)
					end
				end
			end
		end
	end

	local function SellItemsByQuality(maxQuality)
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info and not ignorelist[info.itemID] then
					local link = C_Container.GetContainerItemLink(bag, slot)
					local _, _, quality, _, _, _, _, _, _, _, price = GetItemInfo(link)

					if price and price ~= 0 and quality and quality <= maxQuality then
						C_Container.UseContainerItem(bag, slot)
					end
				end
			end
		end
	end

	local function SellAllItems()
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info and not ignorelist[info.itemID] then
					C_Container.UseContainerItem(bag, slot)
				end
			end
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
			for slot = 1, C_Container.GetContainerNumSlots(bag) do
				if C_Container.GetContainerItemLink(bag, slot) then
					C_Container.UseContainerItem(bag, slot)
				end
			end
		end
	end

	-- Создание кнопок
	local function CreateTradeButtons()
		-- Gray Items
		OctoFrame_SellALLGRAY = CreateSellButton("SellGray", "Garbage.tga", "Gray items", -551, 130)
		OctoFrame_SellALLGRAY:SetScript("OnClick", SellGrayItems)

		-- Consumables
		OctoFrame_SellConsumable = CreateSellButton("SellConsumable", "Trade_Alchemy_DPotion_A28.tga", "Consumable", -551, 65)
		OctoFrame_SellConsumable:SetScript("OnClick", SellConsumables)

		-- Items < Epic
		OctoFrame_SellOther = CreateSellButton("SellOther", "Sell.tga", nil, -551, 0)
		OctoFrame_SellOther:SetScript("OnEnter", function(self)
			if not self.promise then
				self.promise = ltl:Items(E.OctoTable_itemID_Ignore_List)
				self.promise:FailWithChecked(print)
			end
			self.promise:Then(function()
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine("itemQuality < фиолет")
				GameTooltip:AddLine(" ")
				for _, itemID in next, E.OctoTable_itemID_Ignore_List do
					GameTooltip:AddLine(E.func_GetItemIconByID(itemID)..E.func_GetItemNameByID(itemID))
				end
				GameTooltip:Show()
			end)
		end)
		OctoFrame_SellOther:SetScript("OnLeave", GameTooltip.Hide)
		OctoFrame_SellOther:SetScript("OnClick", function() SellItemsByQuality(3) end) -- 3 = Rare

		-- Epic Items
		OctoFrame_SellOtherFiolet = CreateSellButton("SellEpic", "Sell.tga", nil, -551, -30)
		OctoFrame_SellOtherFiolet:SetScript("OnEnter", function(self)
			if not self.promise then
				self.promise = ltl:Items(E.OctoTable_itemID_Ignore_List)
				self.promise:FailWithChecked(print)
			end
			self.promise:Then(function()
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine("itemQuality = фиолет")
				GameTooltip:AddLine(" ")
				for _, itemID in next, E.OctoTable_itemID_Ignore_List do
					GameTooltip:AddLine(E.func_GetItemIconByID(itemID)..E.func_GetItemNameByID(itemID))
				end
				GameTooltip:Show()
			end)
		end)
		OctoFrame_SellOtherFiolet:SetScript("OnLeave", GameTooltip.Hide)
		OctoFrame_SellOtherFiolet:SetScript("OnClick", function() SellItemsByQuality(4) end) -- 4 = Epic

		-- Sell All
		OctoFrame_SellAll = CreateSellButton("SellAll", "SellAll.tga", "Sell All", -551, -65)
		OctoFrame_SellAll:SetScript("OnClick", SellAllItems)
	end

	local function CreateBankButtons()
		-- From Bank
		OctoFrame_FROMBANK = CreateSellButton("FromBank", "Arrow_RIGHT.tga", nil, -500, 32)
		OctoFrame_FROMBANK:SetScript("OnClick", function() BankTransfer(true) end)

		-- To Bank
		OctoFrame_TOBANK = CreateSellButton("ToBank", "Arrow_LEFT.tga", nil, -500, -32)
		OctoFrame_TOBANK:SetScript("OnClick", function() BankTransfer(false) end)
	end

	-- Обработчик событий
	local function Octo_Trade_OnEvent(self, event)
		if InCombatLockdown() then return end

		if event == "MERCHANT_SHOW" or event == "TRADE_SHOW" or event == "MAIL_SHOW" then
			CreateTradeButtons()
		elseif event == "BANKFRAME_OPENED" then
			CreateBankButtons()
		elseif event == "SECURE_TRANSFER_CANCEL" or event == "MERCHANT_CLOSED" or event == "PLAYER_STARTED_MOVING" then
			for _, frame in pairs({OctoFrame_SellALLGRAY, OctoFrame_SellConsumable, OctoFrame_SellOther,
								 OctoFrame_SellOtherFiolet, OctoFrame_SellAll}) do
				if frame then frame:Hide() end
			end
		elseif event == "BANKFRAME_CLOSED" then
			for _, frame in pairs({OctoFrame_FROMBANK, OctoFrame_TOBANK}) do
				if frame then frame:Hide() end
			end
		end
	end

	-- Инициализация
	OctoFrame_Events = CreateFrame("Frame")
	OctoFrame_Events:RegisterEvent("TRADE_SHOW")
	OctoFrame_Events:RegisterEvent("SECURE_TRANSFER_CANCEL")
	OctoFrame_Events:RegisterEvent("MERCHANT_SHOW")
	OctoFrame_Events:RegisterEvent("MERCHANT_CLOSED")
	OctoFrame_Events:RegisterEvent("BANKFRAME_OPENED")
	OctoFrame_Events:RegisterEvent("BANKFRAME_CLOSED")
	OctoFrame_Events:RegisterEvent("PLAYER_STARTED_MOVING")
	OctoFrame_Events:RegisterEvent("MAIL_SHOW")
	OctoFrame_Events:SetScript("OnEvent", Octo_Trade_OnEvent)
end)