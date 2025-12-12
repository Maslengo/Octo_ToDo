local GlobalAddonName, ns = ...; E = _G.OctoEngine
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
local ItemsUsable = CreateFrame("BUTTON", "ItemsUsable", UIParent, "BackDropTemplate")
ItemsUsable:Hide()
local TestButton1 = CreateFrame("Button", "TestButton1", UIParent, "UIPanelButtonTemplate")
-- E.func_InitFrame(ItemsUsable) -- С ДАТА ПРОВАЙДЕРОМ
----------------------------------------------------------------
-- Локальные переменные для работы с инвентарем
local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemCount = C_Item.GetItemCount
local GetItemInfo = C_Item.GetItemInfo
----------------------------------------------------------------
local INDENT_TEXT = 4
local INDEND_SCROLL = 20
local LINE_HEIGHT = 32
local LINE_WIDTH = 256
local MAX_DISPLAY_LINES = 20
local INDENT_BETWEEN_LINES = LINE_HEIGHT
local LINES_TOTAL = math.floor(math.floor(E.PHYSICAL_SCREEN_HEIGHT/LINE_HEIGHT)*.7)
if MAX_DISPLAY_LINES > LINES_TOTAL then
	MAX_DISPLAY_LINES = LINES_TOTAL
end
local classR, classG, classB = GetClassColor(E.classFilename)
----------------------------------------------------------------
local func_OnAcquired do
	-- local function func_OnEnter(frame)
	-- 	local frameData = frame:GetData()
	-- 	local itemID = frameData.itemID
	-- 	-- Получение данных для тултипа
	-- 	local tooltipOCTO = {}
	-- 	local tooltipInfo = C_TooltipInfo.GetItemByID(itemID)
	-- 	-- opde(tooltipInfo.lines)
	-- 	for i, v in next,(tooltipInfo.lines) do
	-- 		local r, g, b = v.leftColor.r, v.leftColor.g, v.leftColor.b
	-- 		local colorHEX = E.func_rgb2hex(r, g, b)
	-- 		local leftText = v.leftText
	-- 		tooltipOCTO[#tooltipOCTO+1] = {colorHEX..leftText.."|r"}
	-- 	end
	-- 	frame.tooltip = tooltipOCTO
	-- 	E.func_OctoTooltip_OnEnter(frame, {"LEFT", "RIGHT"})
	-- end
	-- Функция инициализации элементов колонки
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			frame:SetHitRectInsets(1, 1, 1, 1)
			----------------
			-- Создание полноразмерного фрейма для подсветки
			local Highlight = CreateFrame("BUTTON", nil, owner, "OctoHighlightAnimationTemplate")
			Highlight:SetPropagateMouseClicks(true)
			Highlight:SetPropagateMouseMotion(true)
			Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
			if E.ENABLE_HIGHLIGHT_ANIMATION then
				Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- "auctionhouse-ui-row-highlight"
				Highlight.HighlightTexture = Highlight:GetHighlightTexture()
				Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
			end
			Highlight:SetPoint("LEFT", frame)
			Highlight:SetPoint("TOP", frame)
			Highlight:SetPoint("BOTTOM", frame)
			Highlight:SetPoint("RIGHT")
			frame.Highlight = Highlight
			------------------------------------------------
			frame.icon_1 = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
			frame.icon_1:SetPoint("TOPLEFT", 1, -1)
			frame.icon_1:SetSize(LINE_HEIGHT-2, LINE_HEIGHT-2)
			frame.icon_1:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			----------------
			-- Создаем метатаблицу для дочерних фреймов
			frame.lineFrames = setmetatable({}, {
					__index = function(self, key)
						if key then
							-- Создаем новый фрейм для каждого элемента
							local f = CreateFrame("BUTTON", "frame"..key, frame)
							f:SetPropagateMouseClicks(true)
							f:SetPropagateMouseMotion(true)
							f:SetHeight(LINE_HEIGHT)
							-- f:SetSize(LINE_WIDTH, LINE_HEIGHT)
							-- f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
							if key == 1 then
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDENT_TEXT, 0) -- ОТСТУП
							else
								local prevKey = key - 1
								local prevFrame = rawget(self, prevKey) or self[prevKey] -- Получаем предыдущий фрейм
								f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", INDENT_BETWEEN_LINES, 0)
							end
							-- Текст в центре
							f.text = f:CreateFontString()
							f.text:SetFontObject(OctoFont11)
							-- f.text:SetAllPoints()
							f.text:SetPoint("LEFT", LINE_HEIGHT+INDENT_TEXT+0, 0)
							f.text:SetWordWrap(false)
							f.text:SetJustifyV("MIDDLE") -- TOP, MIDDLE, BOTTOM
							f.text:SetJustifyH("CENTER") -- LEFT, Center, RIGHT
							f.text:SetTextColor(1, 1, 1, 1)
							-- Обработчики событий
							-- f:SetScript("OnHide", f.Hide)
							rawset(self, key, f)
							return f
						end
					end
			})
			-- Обработчики событий показа/скрытия фрейма
			frame:SetScript("OnHide", function()
					frame.Highlight:Hide()
			end)
			frame:SetScript("OnShow", function()
					frame.Highlight:Show()
			end)
			-- Обработчик наведения курсора для отображения тултипа
			-- frame:SetScript("OnEnter", func_OnEnter)
			----------------
		end
	end
end
function EventFrame:Octo_Frame_init(frame, node)
	-- Получаем данные из узла и кэшируем часто используемые переменные
	local frameData = node:GetData()
	local lineFrames = frame.lineFrames -- Кэшируем для быстрого доступа
	local numData = #frameData -- Количество элементов в данных
	local numLines = #lineFrames -- Количество доступных lineFrames
	local columnSizes = EventFrame.COLUMN_SIZES -- Размеры колонок (если есть)
	-- Обрабатываем данные и обновляем соответствующие lineFrames
	for i = 1, numData do
		local currentText = frameData[i]
		if currentText then
			lineFrames[i].text:SetText(currentText) -- Устанавливаем текст
		end
		-- Если заданы размеры колонок, применяем их
		if columnSizes and columnSizes[i] and lineFrames and lineFrames[i] then
			lineFrames[i]:SetWidth(columnSizes[i])
		end
		-- Определяем выравнивание текста (по умолчанию Center)
		local justify = "CENTER"
		if numData > 1 then
			if i == 1 then -- Первый элемент выравниваем по ЛЕВОМУ краю
				justify = "LEFT"
			elseif i == numData then -- Последний элемент — по ПРАВОМУ
				justify = "RIGHT"
			end
		end
		lineFrames[i].text:SetJustifyH(justify)
	end
	-- Очищаем оставшиеся lineFrames (если данных меньше, чем фреймов)
	for i = numData + 1, numLines do
		lineFrames[i].text:SetText()
	end
	local itemID = frameData.itemID
	frame.icon_1:SetTexture(E.func_GetItemIconByID(itemID))
	-- local itemID = frame.lineFrames[2].text:GetText()
	-- frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	frame:SetAttribute("useOnKeyDown", false)
	frame:SetAttribute("type", "macro")
	-- frame:SetAttribute("macrotext", "/say "..itemID)
	frame:SetAttribute("macrotext", "/use item:"..itemID)
end
local function GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then
		return "TOPLEFT", "BOTTOMLEFT"
	end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end
function EventFrame:func_SmartAnchorTo(frame, point)
	if not frame then
		return error("Invalid frame provided.", 2)
	end
	ItemsUsable:ClearAllPoints()
	if point then
		local left, right = unpack(point)
		ItemsUsable:SetPoint(left, frame, right)
	else
		ItemsUsable:SetPoint("TOPLEFT", frame, "TOPRIGHT")
		-- ItemsUsable:SetPoint(GetTipAnchor(frame))
	end
end
local function TooltipOnShow()
	local scrollBar = ItemsUsable.ScrollBar
	local shouldShow = EventFrame.shouldShowScrollBar
	if shouldShow ~= scrollBar:IsShown() then
		if shouldShow then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end
end
function EventFrame:Create_ItemsUsable()
	ItemsUsable:SetPropagateMouseClicks(true)
	ItemsUsable:SetPropagateMouseMotion(true)
	ItemsUsable:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)
	ItemsUsable:SetScript("OnShow", TooltipOnShow)
	ItemsUsable:SetPoint("CENTER")
	ItemsUsable:SetSize(1, LINE_HEIGHT*1)
	ItemsUsable:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	-- ItemsUsable:SetFrameStrata("BACKGROUND")
	ItemsUsable:SetBackdrop(E.menuBackdrop)
	ItemsUsable:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA) -- E.backgroundColorA
	-- ItemsUsable:SetBackdropBorderColor(classR, classG, classB, 1)
	ItemsUsable:SetBackdropBorderColor(0, 0, 0, 1)
	ItemsUsable.ScrollBox = CreateFrame("FRAME", nil, ItemsUsable, "WowScrollBoxList")
	ItemsUsable.ScrollBox:SetAllPoints()
	ItemsUsable.ScrollBox:SetPropagateMouseClicks(true)
	ItemsUsable.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	ItemsUsable.ScrollBox:SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBox:GetScrollTarget():SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBox:Layout()
	ItemsUsable.ScrollBar = CreateFrame("EventFrame", nil, ItemsUsable, "MinimalScrollBar")
	ItemsUsable.ScrollBar:SetPoint("TOPLEFT", ItemsUsable.ScrollBox, "TOPRIGHT", 6, 0)
	ItemsUsable.ScrollBar:SetPoint("BOTTOMLEFT", ItemsUsable.ScrollBox, "BOTTOMRIGHT", 6, 0)
	ItemsUsable.ScrollBar:SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBar.Back:SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBar.Forward:SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBar.Track:SetPropagateMouseMotion(true)
	ItemsUsable.ScrollBar.Track.Thumb:SetPropagateMouseMotion(true)
	-- ItemsUsable:SetPropagateMouseClicks(true)
	-- ItemsUsable:SetPropagateMouseMotion(true)
	ItemsUsable.view = CreateScrollBoxListTreeListView()
	ItemsUsable.view:SetElementExtent(LINE_HEIGHT)
	ItemsUsable.view:SetElementInitializer("SecureActionButtonTemplate",
		function(...)
			self:Octo_Frame_init(...)
	end)
	ItemsUsable.view:RegisterCallback(ItemsUsable.view.Event.OnAcquiredFrame, func_OnAcquired, ItemsUsable)
	ScrollUtil.InitScrollBoxListWithScrollBar(ItemsUsable.ScrollBox, ItemsUsable.ScrollBar, ItemsUsable.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(ItemsUsable.ScrollBox, ItemsUsable.ScrollBar)
end
local function calculateColumnWidths(node)
	local tbl = node:GetData()
	local frames = ItemsUsable.view:GetFrames()
	if #frames == 0 then
		ItemsUsable.view:AcquireInternal(1, node)
		ItemsUsable.view:InvokeInitializers()
	end
	local columnWidths = {}
	local sampleFrame = frames[1]
	for i = 1, #tbl do
		sampleFrame.lineFrames[i].text:SetText(tbl[i])
		columnWidths[i] = sampleFrame.lineFrames[i].text:GetStringWidth()
	end
	return columnWidths
end
function EventFrame:func_ItemsUsable_CreateDataProvider()
	-- if not ItemsUsable:IsShown() then return end
	-- Сначала соберем все предметы с их количеством
	local UsableTBL = {}
	-- Оптимизация: вынесем часто используемые таблицы в локальные переменные
	local OctoTable_itemID_ItemsUsable = E.OctoTable_itemID_ItemsUsable
	local OctoTable_itemID_Ignore_List = E.OctoTable_itemID_Ignore_List
	local OctoTable_itemID_ItemsDelete = E.OctoTable_itemID_ItemsDelete
	local func_GetItemCount = function(...) return E.func_GetItemCount(...) end
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		for slot = numSlots, 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and containerInfo.itemID then
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				----------------------------------------------------------------
				local requiredCount = OctoTable_itemID_ItemsUsable[itemID] -- Проверяем предметы для использования
				if requiredCount and not OctoTable_itemID_Ignore_List[itemID] and GetItemCount(itemID) >= requiredCount then
					if not UsableTBL[itemID] then
						UsableTBL[itemID] = {
							count = func_GetItemCount(itemID, false, false, false, false),
							quality = quality,
							usable = true
						}
					end
				end
				-- if OctoTable_itemID_ItemsDelete[itemID] then -- Проверяем предметы для удаления
				-- if not UsableTBL[itemID] then
				-- UsableTBL[itemID] = {
				-- count = func_GetItemCount(itemID, false, false, false, false),
				-- quality = quality,
				-- usable = false
				-- }
				-- end
				-- end
				----------------------------------------------------------------
				-- UsableTBL[itemID] = {
				-- count = func_GetItemCount(itemID, false, false, false, false),
				-- quality = quality or 0,
				-- usable = false
				-- }
				----------------------------------------------------------------
			end
		end
	end
	-- Преобразуем в таблицу для сортировки
	local sorted_itemList = {}
	for itemID, v in next, (UsableTBL) do
		table.insert(sorted_itemList, {itemID = itemID, count = v.count, quality = v.quality, usable = v.usable})
	end
	-- Сортируем сначала по quality (убывание), затем по count (убывание), затем по itemID (возрастание)
	table.sort(sorted_itemList, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality
			elseif a.count ~= b.count then
				return a.count > b.count
			else
				return a.itemID > b.itemID
			end
	end)
	local lines = 0
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}
	-- Создаем финальную таблицу для отображения
	local color, itemName -- Локальные переменные для повторного использования
	-- local color = E.White_Color
	for _, item in ipairs(sorted_itemList) do
		local itemID = item.itemID
		if itemID then
			color = item.usable and E.Green_Color or E.Red_Color
			itemName = E.func_itemName(itemID, item.quality)
			lines = lines + 1
			local node = DataProvider:Insert({
				itemName,
				item.usable and color.."USE|r" or color.."DELETE|r",
				color..item.count.."|r",
				itemID = itemID,
			})
			for j, w in ipairs(calculateColumnWidths(node)) do
				COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
			end
		end
	end
	local columns = 3
	EventFrame.COLUMN_SIZES = COLUMN_SIZES
	local total_width = INDENT_TEXT*2 + (INDENT_BETWEEN_LINES*(columns-1)) + LINE_HEIGHT-- ОТСТУП -- (иконка)
	if EventFrame.COLUMN_SIZES[1] then
		for i = 1, columns do
			total_width = total_width + EventFrame.COLUMN_SIZES[i]
		end
	end
	local shouldShowScrollBar = MAX_DISPLAY_LINES < lines
	EventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDEND_SCROLL
	end
	ItemsUsable.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	if lines > MAX_DISPLAY_LINES then
		ItemsUsable:SetSize(total_width, LINE_HEIGHT*MAX_DISPLAY_LINES)
	elseif lines == 0 then
		ItemsUsable:SetSize(total_width, LINE_HEIGHT*1)
	else
		ItemsUsable:SetSize(total_width, LINE_HEIGHT*lines)
	end
end
local function Toggle_ItemsUsable()
	if not ItemsUsable:IsShown() then
		EventFrame:func_ItemsUsable_CreateDataProvider()
	end
	ItemsUsable:SetShown(not ItemsUsable:IsShown())
end
function EventFrame:CreateTestButton1()
	TestButton1:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	TestButton1:SetPoint("TOPLEFT", 64, -64)
	TestButton1:SetSize(128, 32)
	TestButton1:SetText("Toggle_ItemsUsable")
	TestButton1:EnableMouse(true)
	TestButton1:SetMovable(true)
	-- Обработчики перемещения фрейма
	TestButton1:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				TestButton1:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnTheMove or E.backgroundColorA)
				TestButton1:StartMoving()
			end
	end)
	TestButton1:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				TestButton1:SetAlpha(1)
				TestButton1:StopMovingOrSizing()
			end
	end)
	TestButton1:RegisterForClicks("LeftButtonUp")
	TestButton1:SetScript("OnClick", Toggle_ItemsUsable)
	EventFrame:func_SmartAnchorTo(TestButton1)
end
local MyEventsTable = {
	"VARIABLES_LOADED",
	"BAG_UPDATE",
	"PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
	"ITEM_COUNT_CHANGED",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	EventFrame:Create_ItemsUsable()
	self:CreateTestButton1()
	EventFrame:func_ItemsUsable_CreateDataProvider()
end
function EventFrame:BAG_UPDATE()
	if not ItemsUsable:IsShown() or self.BAG_UPDATE_pause then return end
	self.BAG_UPDATE_pause = true
	if ItemsUsable:IsShown() then
		EventFrame:func_ItemsUsable_CreateDataProvider()
	end
	C_Timer.After(1, function()
			self.BAG_UPDATE_pause = nil -- Используем nil вместо false для экономии памяти
	end)
end
function EventFrame:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if not ItemsUsable:IsShown() or self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause then return end
	self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = true
	if ItemsUsable:IsShown() then
		EventFrame:func_ItemsUsable_CreateDataProvider()
	end
	C_Timer.After(1, function()
			self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = nil -- Используем nil вместо false для экономии памяти
	end)
end
function EventFrame:ITEM_COUNT_CHANGED()
	if ItemsUsable:IsShown() then
		EventFrame:func_ItemsUsable_CreateDataProvider()
	end
end
function EventFrame:BAG_UPDATE_DELAYED()
	if ItemsUsable:IsShown() then
		EventFrame:func_ItemsUsable_CreateDataProvider()
	end
end
function EventFrame:PLAYER_REGEN_ENABLED()
	TestButton1:Show()
end
function EventFrame:PLAYER_REGEN_DISABLED()
	ItemsUsable:Hide()
	TestButton1:Hide()
end
