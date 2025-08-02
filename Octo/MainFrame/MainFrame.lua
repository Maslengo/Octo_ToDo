local GlobalAddonName, E = ...
local Octo_EventFrame_ToDo = CreateFrame("FRAME") -- Фрейм для обработки событий
Octo_EventFrame_ToDo:Hide()
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E:func_InitFrame(Octo_MainFrame_ToDo)
----------------------------------------------------------------
-- Настройки размеров интерфейса
----------------------------------------------------------------
local INDENT_TEST = 4
local LINE_HEIGHT = 20 -- Высота одной строки AddonHeight
local HEADER_HEIGHT = LINE_HEIGHT*2
local LINE_WIDTH_LEFT = 200 -- Ширина левой панели AddonLeftFrameWeight
local LINE_WIDTH_CENT = 110 -- Ширина центральной панели AddonCentralFrameWeight
local LINES_MAX = 30 -- Количество строк по умолчанию MainFrameDefaultLines
-- Автоматический расчет максимального количества строк
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / LINE_HEIGHT)*.7))
local COLUMNS_MAX = 10 -- Максимальное количество отображаемых персонажей
-- local TEXT_INDENT = " "
----------------------------------------------------------------
-- Константы цвета
----------------------------------------------------------------
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local classR, classG, classB = GetClassColor(E.classFilename)
local LEFT_TEXTURE_ALPHA = 0.1
local charR, charG, charB = 1, 1, 1
----------------------------------------------------------------
-- Подключаем необходимые библиотеки
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки
----------------------------------------------------------------
-- Функция для объединения таблиц отрисовки
----------------------------------------------------------------
function E:func_Concat_Otrisovka()
	local tbl = {}
	-- Объединяем таблицы для каждого дополнения в обратном порядке (от нового к старому)
	E:func_TableConcat(tbl, E:func_Otrisovka_13_TheLastTitan())
	E:func_TableConcat(tbl, E:func_Otrisovka_12_Midnight())
	E:func_TableConcat(tbl, E:func_Otrisovka_11_TheWarWithin())
	E:func_TableConcat(tbl, E:func_Otrisovka_10_Dragonflight())
	E:func_TableConcat(tbl, E:func_Otrisovka_09_Shadowlands())
	E:func_TableConcat(tbl, E:func_Otrisovka_08_BattleforAzeroth())
	E:func_TableConcat(tbl, E:func_Otrisovka_07_Legion())
	E:func_TableConcat(tbl, E:func_Otrisovka_06_WarlordsofDraenor())
	E:func_TableConcat(tbl, E:func_Otrisovka_05_MistsofPandaria())
	E:func_TableConcat(tbl, E:func_Otrisovka_04_Cataclysm())
	E:func_TableConcat(tbl, E:func_Otrisovka_03_WrathoftheLichKing())
	E:func_TableConcat(tbl, E:func_Otrisovka_02_TheBurningCrusade())
	E:func_TableConcat(tbl, E:func_Otrisovka_01_WorldofWarcraft())
	-- Добавляем праздники и другие данные
	E:func_TableConcat(tbl, E:func_Otrisovka_90_Holidays())
	E:func_TableConcat(tbl, E:func_Otrisovka_91_Other())
	return tbl
end
----------------------------------------------------------------
-- Локальные функции для оптимизации
----------------------------------------------------------------
local math_min = math.min
local math_max = math.max
----------------------------------------------------------------
-- Функции обработки событий для элементов интерфейса
----------------------------------------------------------------
-- Обработчики скрытия/показа для полного фрейма
local function func_OnHideLEFT(frame)
	frame.frameFULL:Hide()
end
local function func_OnShowLEFT(frame)
	frame.frameFULL:Show()
end
-- Функция инициализации левой панели
local func_OnAcquiredLEFT = function(owner, frame, data, new)
	if not new then return end
	local JustifyV = "MIDDLE" -- Вертикальное выравнивание
	local JustifyH = "LEFT" -- Горизонтальное выравнивание
	-- Настройки фрейма
	frame:SetPropagateMouseClicks(true) -- Разрешаем передачу кликов
	frame:SetPropagateMouseMotion(true) -- Разрешаем передачу движения мыши
	frame:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
	-- Создаем фоновую текстуру для всего элемента
	local frameFULL = CreateFrame("Button", nil, Octo_MainFrame_ToDo)
	frameFULL:SetPropagateMouseClicks(true)
	frameFULL:SetPropagateMouseMotion(true)
	frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
	frameFULL:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- Текстура выделения
	frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
	frameFULL.HighlightTexture:SetAlpha(E.backgroundColorAOverlay) -- Прозрачность выделения
	frameFULL:SetPoint("LEFT", frame)
	frameFULL:SetPoint("TOP", frame)
	frameFULL:SetPoint("BOTTOM", frame)
	frameFULL:SetPoint("RIGHT")
	frame.frameFULL = frameFULL
	-- Текст слева
	local textLeft = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	textLeft:SetPoint("LEFT", 0, 0)
	textLeft:SetWidth(LINE_WIDTH_LEFT - 2)
	textLeft:SetFontObject(OctoFont11) -- Используем наш шрифт
	textLeft:SetWordWrap(false) -- Запрещаем перенос слов
	textLeft:SetJustifyV(JustifyV)
	textLeft:SetJustifyH(JustifyH)
	textLeft:SetTextColor(textR, textG, textB, textA) -- Белый цвет текста
	frame.textLEFT = textLeft
	-- Текстура для левой панели
	local textureLEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
	textureLEFT:Hide()
	textureLEFT:SetAllPoints()
	textureLEFT:SetTexture(E.TEXTURE_LEFT_PATH)
	frame.textureLEFT = textureLEFT
	local frameData = data.parent.dataProvider.linearized
	frame:SetScript("OnHide", func_OnHideLEFT)
	frame:SetScript("OnShow", func_OnShowLEFT)

end
----------------------------------------------------------------
-- Функция инициализации центральной панели
----------------------------------------------------------------
local func_OnAcquiredCENT do
	-- Получаем цвет класса игрока
	function func_OnAcquiredCENT(owner, frame, data, new)
		if not new then return end
		-- Настройки фрейма
		frame:SetPropagateMouseClicks(true)
		-- Создаем метатаблицу для дочерних фреймов
		frame.second = setmetatable({}, {
				__index = function(self, key)
					if key then
						-- Создаем новый фрейм для каждого элемента
						local f = CreateFrame("BUTTON", "frame"..key, frame)
						f:SetPropagateMouseClicks(true)
						f:SetPropagateMouseMotion(true)
						f:SetSize(LINE_WIDTH_CENT, LINE_HEIGHT)
						f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
						f:SetPoint("TOPLEFT", frame, "TOPLEFT", LINE_WIDTH_CENT*(key-1), 0)
						f:RegisterForClicks("LeftButtonUp")
						-- Текстура для текущего персонажа
						f.curCharTextureBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.curCharTextureBG:SetAllPoints()
						f.curCharTextureBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
						f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.backgroundColorAOverlay)
						f.curCharTextureBG:Hide()
						-- Текстура репутации
						f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.ReputTextureAndBG:SetPoint("LEFT")
						f.ReputTextureAndBG:SetHeight(LINE_HEIGHT)
						f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
						-- Текст в центре
						f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
						f.textCENT:SetAllPoints()
						f.textCENT:SetFontObject(OctoFont11)
						f.textCENT:SetWordWrap(false)
						f.textCENT:SetJustifyV("MIDDLE")
						f.textCENT:SetJustifyH("CENTER")
						f.textCENT:SetTextColor(textR, textG, textB, textA)
						-- Обработчики событий
						f:SetScript("OnEnter", function() E:func_OctoTooltip_OnEnter(f) end)
						f:SetScript("OnHide", f.Hide)
						f.curCharTextureBG:SetScript("OnHide", f.curCharTextureBG.Hide)
						rawset(self, key, f)
						return f
					end
				end
		})
		-- Обработчики событий для основного фрейма
		-- frame:SetScript("OnEnter", func_OnEnter)
		-- frame:SetScript("OnLeave", func_OnLeave)
	end
end
-- Функция обновления левой панели
function Octo_EventFrame_ToDo:Octo_Frame_initLEFT(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	local frameData = data.zxc
	-- Устанавливаем текст и иконку
	frame.textLEFT:SetText(frameData.textLEFT)
	-- Устанавливаем цвет фона если задан
	if frameData.colorLEFT then
		local r, g, b = E:func_hex2rgbNUMBER(frameData.colorLEFT)
		frame.textureLEFT:SetVertexColor(r, g, b, LEFT_TEXTURE_ALPHA)
		frame.textureLEFT:Show()
	else
		frame.textureLEFT:Hide()
	end
	-- Получаем тип данных
	local typeQ, ID, iANIMA, kCovenant = frameData.myType[1], frameData.myType[2], frameData.myType[3], frameData.myType[4]
	-- Настраиваем подсказку в зависимости от типа данных
	frame:SetScript("OnEnter", function()
			local tooltipOCTO = {}
			-- Обрабатываем таблицу ID или одиночный ID
			if type(ID) == "table" then
				for _, tblID in ipairs(ID) do
					E:func_TableConcat(tooltipOCTO, E:func_tooltipCurrencyAllPlayers(typeQ, tblID, iANIMA, kCovenant))
				end
			else
				tooltipOCTO = E:func_tooltipCurrencyAllPlayers(typeQ, ID, iANIMA, kCovenant)
			end
			frame.tooltip = tooltipOCTO
			E:func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end)
end
-- Функция обновления центральной панели
function Octo_EventFrame_ToDo:Octo_Frame_initCENT(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	-- Обрабатываем случай с несколькими персонажами
	if data.totalPers > 1 then
		local current = frame.second[data.currentChar]
		if current then
			current:Show()
			current.curCharTextureBG:Show()
			current.textCENT:SetText("")
			current.ReputTextureAndBG:Hide()
		end
	end
	-- Обрабатываем данные для правой панели
	for i = 1, #data.zxc.FIRST do
		local secondFrame = frame.second[i]
		local frameData = data.zxc
		if frameData.textCENT[i] then
			local textCENT = frameData.textCENT[i]
			local FIRST = frameData.FIRST[i]
			local SECOND = frameData.SECOND[i]
			secondFrame.ReputTextureAndBG:Hide()
			-- Устанавливаем цвет если задан
			if frameData.colorCENT[i] then
				local r1, g1, b1 = E:func_hex2rgbNUMBER(frameData.colorCENT[i])
				if not frameData.isReputations then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_CENT)
					secondFrame.ReputTextureAndBG:Show()
					secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
				else
					secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
				end
			end
			secondFrame.textCENT:SetText(textCENT)
			-- Особый случай для репутации
			if frameData.isReputations and FIRST ~= 0 then
				if FIRST == SECOND then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_CENT)
					secondFrame.ReputTextureAndBG:Show()
				elseif FIRST >= 1 then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_CENT/SECOND*FIRST)
					secondFrame.ReputTextureAndBG:Show()
				end
			end
		else
			secondFrame.textCENT:SetText("")
			secondFrame.ReputTextureAndBG:SetVertexColor(0, 0, 0, 0)
		end
		secondFrame:Show()
		secondFrame.tooltip = frameData.tooltipRIGHT[i]
	end
end
-- Функция создания основного фрейма аддона
function Octo_EventFrame_ToDo:Octo_Create_MainFrame_ToDo()
	-- Базовые настройки фрейма
	Octo_MainFrame_ToDo:SetPoint("CENTER", 0, 0)
	-- Обработчик показа фрейма
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			E:func_TODO_CreateDataProvider()
			RequestRaidInfo() -- Запрашиваем информацию о рейде
	end)
	-- Рассчитываем размеры фрейма
	local NumPlayers = math_min(E:func_NumPlayers(), COLUMNS_MAX)
	Octo_MainFrame_ToDo:SetSize(LINE_WIDTH_LEFT + LINE_WIDTH_CENT * NumPlayers, LINE_HEIGHT * LINES_MAX)
	-- Настройки поведения фрейма
	Octo_MainFrame_ToDo:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_MainFrame_ToDo:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	-- Создаем скролл-фрейм
	local barPanelScroll = CreateFrame("ScrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.barPanelScroll = barPanelScroll
	-- Функции для обработки скроллинга
	local function OnHorizontalScroll(self, offset)
		local scrollRange = self:GetHorizontalScrollRange()
		self.hBar:SetScrollPercentage(scrollRange > 0 and offset / scrollRange or 0, ScrollBoxConstants.NoScrollInterpolation)
	end
	local function OnScrollRangeChanged(self, xrange)
		OnHorizontalScroll(self, self:GetHorizontalScroll())
		local width = self:GetWidth()
		self.hBar:SetVisibleExtentPercentage(width > 0 and width / (xrange + width) or 0)
		self.hBar:SetPanExtentPercentage(xrange > 0 and 30 / xrange or 0)
	end
	barPanelScroll:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	barPanelScroll:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)
	-- Создаем горизонтальную полосу прокрутки
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimHorizontalScrollBar")
	HorizontalScrollBar.Backplate = HorizontalScrollBar:GetRegions()
	HorizontalScrollBar.Backplate:Hide()
	-- Настраиваем регионы полосы прокрутки
	local regions = {
		HorizontalScrollBar.Back.Texture,
		HorizontalScrollBar.Forward.Texture,
		HorizontalScrollBar.Track.Middle,
		HorizontalScrollBar.Track.Begin,
		HorizontalScrollBar.Track.End,
		HorizontalScrollBar.Track.Thumb.Middle,
		HorizontalScrollBar.Track.Thumb.Begin,
		HorizontalScrollBar.Track.Thumb.End
	}
	for _, region in ipairs(regions) do
		region:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	end
	barPanelScroll.hBar = HorizontalScrollBar
	HorizontalScrollBar:SetPoint("TOPLEFT", barPanelScroll, "BOTTOMLEFT", 0, -6)
	HorizontalScrollBar:SetPoint("TOPRIGHT", barPanelScroll, "BOTTOMRIGHT")
	HorizontalScrollBar:RegisterCallback(HorizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
			barPanelScroll:SetHorizontalScroll(scrollPercentage * barPanelScroll:GetHorizontalScrollRange())
	end)
	HorizontalScrollBar:SetHideIfUnscrollable(true)
	-- Создаем дочерний фрейм для содержимого
	local childCENT = CreateFrame("FRAME")
	Octo_MainFrame_ToDo.childCENT = childCENT
	barPanelScroll:SetScrollChild(childCENT)
	-- Настраиваем ScrollBox для левой панели
	Octo_MainFrame_ToDo.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(LINE_WIDTH_LEFT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	barPanelScroll:SetPoint("TOPLEFT", Octo_MainFrame_ToDo.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	barPanelScroll:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.viewLEFT = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.viewLEFT:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	Octo_MainFrame_ToDo.viewLEFT:RegisterCallback(Octo_MainFrame_ToDo.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, Octo_MainFrame_ToDo)
	-- Настраиваем ScrollBox для центральной панели
	Octo_MainFrame_ToDo.ScrollBoxCENT = CreateFrame("FRAME", nil, childCENT, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBarCENT = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBarCENT:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBarCENT:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_ToDo.viewCENT = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.viewCENT:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_MainFrame_ToDo.viewCENT:RegisterCallback(Octo_MainFrame_ToDo.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_MainFrame_ToDo)
	-- Инициализируем скроллбоксы с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCENT, Octo_MainFrame_ToDo.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCENT)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxCENT, Octo_MainFrame_ToDo.ScrollBarCENT, Octo_MainFrame_ToDo.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxCENT, Octo_MainFrame_ToDo.ScrollBarCENT)
	-- Настраиваем внешний вид основного фрейма
	Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_ToDo:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:SetAlpha(Octo_ToDo_DB_Vars.AlphaOnDrag or E.backgroundColorA)
				Octo_MainFrame_ToDo:StartMoving()
			end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:SetAlpha(1)
				Octo_MainFrame_ToDo:StopMovingOrSizing()
			end
	end)
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", Octo_MainFrame_ToDo.Hide)
	-- Создаем пул фреймов для персонажей
	local function resetFunc(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	local function initFunc(self)
		self:SetSize(LINE_WIDTH_CENT, HEADER_HEIGHT)
		self.text = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.text:SetPoint("CENTER")
		self.text:SetFontObject(OctoFont11)
		self.text:SetJustifyV("MIDDLE")
		self.text:SetJustifyH("CENTER")
		self.text:SetTextColor(textR, textG, textB, textA)
		self.charTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.charTexture:SetAllPoints()
		self.charTexture:SetTexture(E.TEXTURE_CHAR_PATH)
	end
	Octo_MainFrame_ToDo.pool = CreateFramePool("FRAME", childCENT, nil, resetFunc, false, initFunc)
end
----------------------------------------------------------------
-- Функция создания провайдера данных для отображения
----------------------------------------------------------------
function E:func_TODO_CreateDataProvider()
	E:func_Collect_All_Table() -- Собираем все данные
	local NumPlayers = math_min(E:func_NumPlayers(), COLUMNS_MAX)
	local DataProvider = CreateTreeDataProvider()
	local numlines = 0
	-- Находим индекс текущего персонажа
	local sortedPlayersTBL = E:func_sorted()
	local MyCharIndex
	for CharIndex, CharInfo in ipairs(sortedPlayersTBL) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			MyCharIndex = CharIndex
			break
		end
	end
	local totalPers = #sortedPlayersTBL
	local commonNodeData = {
		currentChar = MyCharIndex,
		totalPers = totalPers
	}
	-- Вспомогательная функция для создания таблицы zxc
	local function CreateZxcTable(isReputations)
		return {
			FIRST = {},
			SECOND = {},
			textLEFT = {},
			colorLEFT = {},
			textCENT = {},
			tooltipRIGHT = {},
			colorCENT = {},
			isReputations = isReputations or false,
			myType = {},
		}
	end
	-- Режим без репутаций
	if not Octo_ToDo_DB_Vars.Reputations then
		for index, func in ipairs(E:func_Concat_Otrisovka()) do
			numlines = numlines + 1
			local zxc = CreateZxcTable(false)
			-- Обрабатываем всех персонажей для центральных данных
			for CharIndex, CharInfo in ipairs(sortedPlayersTBL) do
				zxc.FIRST[CharIndex] = 0
				zxc.SECOND[CharIndex] = 0
				local _, _, textCENT, tooltipRIGHT, colorCENT = func(CharInfo)
				zxc.textCENT[CharIndex] = textCENT
				zxc.tooltipRIGHT[CharIndex] = tooltipRIGHT or {}
				zxc.colorCENT[CharIndex] = colorCENT
			end
			-- Получаем данные для левой панели от первого персонажа
			local firstChar = sortedPlayersTBL[1]
			if firstChar then
				local textLEFT, colorLEFT, _, _, _, myType = func(firstChar)
				zxc.textLEFT = textLEFT
				zxc.colorLEFT = colorLEFT
				zxc.myType = myType or {}
			end
			DataProvider:Insert({
					zxc = zxc,
					currentChar = MyCharIndex,
					totalPers = totalPers,
			})
		end
	else
		-- Режим с репутациями (обрабатываем в обратном порядке)
		for index = #E.OctoTable_Reputations, 1, -1 do
			local tbl = E.OctoTable_Reputations[index]
			if Octo_ToDo_DB_Vars.ExpansionToShow[index] then
				for _, v in ipairs(tbl) do
					local repInfo = E.OctoTable_ReputationsDB[v.id]
					-- Проверяем соответствие фракции
					local factionMatch = not Octo_ToDo_DB_Vars.OnlyCurrentFaction
					or repInfo.side == E.curFaction
					or repInfo.side == "-"
					if factionMatch then
						numlines = numlines + 1
						local zxc = CreateZxcTable(true)
						for CharIndex, CharInfo in ipairs(sortedPlayersTBL) do
							local FIRST, SECOND, vivod, colorCENT = ("#"):split(CharInfo.MASLENGO.Reputation[v.id])
							zxc.FIRST[CharIndex] = tonumber(FIRST) or 0
							zxc.SECOND[CharIndex] = tonumber(SECOND) or 0
							-- zxc.textLEFT = E:func_texturefromIcon(E.OctoTable_ReputationsDB[v.id].icon)..E:func_reputationName(v.id)
							zxc.textLEFT = E:func_texturefromIcon(E.OctoTable_Expansions[index].icon, 18, 32)..E:func_reputationName(v.id)
							-- if repInfo then
							-- 	zxc.iconLEFT = repInfo.icon
							-- else
							-- 	zxc.iconLEFT = E.Icon_Empty
							-- end
							zxc.colorLEFT = E.OctoTable_Expansions[index].color
							zxc.textCENT[CharIndex] = vivod
							zxc.tooltipRIGHT[CharIndex] = {}
							zxc.colorCENT[CharIndex] = colorCENT
							zxc.myType = {}
						end
						DataProvider:Insert({
								zxc = zxc,
								currentChar = MyCharIndex,
								totalPers = totalPers,
						})
					end
				end
			end
		end
	end
	-- Корректируем количество строк
	LINES_MAX = math_max(1, math_min(numlines, LINES_TOTAL or numlines))
	if Octo_MainFrame_ToDo then
		-- Устанавливаем провайдер данных (это запустит создание фреймов)
		Octo_MainFrame_ToDo.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_MainFrame_ToDo.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		-- Обновляем размеры фрейма
		local width = LINE_WIDTH_LEFT + LINE_WIDTH_CENT * NumPlayers
		local height = LINE_HEIGHT * LINES_MAX + HEADER_HEIGHT
		Octo_MainFrame_ToDo:SetSize(width, height)
		Octo_MainFrame_ToDo.childCENT:SetSize(LINE_WIDTH_CENT * E:func_NumPlayers(), height)
		-- Обновляем фреймы персонажей
		Octo_MainFrame_ToDo.pool:ReleaseAll()
		for count, CharInfo in ipairs(sortedPlayersTBL) do
			local curCharFrame = Octo_MainFrame_ToDo.pool:Acquire()
			curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.childCENT, "TOPLEFT", LINE_WIDTH_CENT * (count - 1), -HEADER_HEIGHT)
			curCharFrame.text:SetAllPoints()
			curCharFrame.text:SetFontObject(OctoFont11)
			curCharFrame.text:SetWordWrap(true)
			curCharFrame.text:SetJustifyV("MIDDLE")
			curCharFrame.text:SetJustifyH("CENTER")
			curCharFrame.text:SetMaxLines(3)
			curCharFrame.text:SetText(E:func_textCENT_Chars(CharInfo))
			curCharFrame:SetPropagateMouseClicks(true)
			curCharFrame:SetPropagateMouseMotion(true)
			curCharFrame:SetHitRectInsets(1, 1, 1, 1)
			-- Устанавливаем цвет фона в зависимости от фракции
			if CharInfo.PlayerData.Faction == "Horde" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Horde_Color)
			elseif CharInfo.PlayerData.Faction == "Alliance" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Alliance_Color)
			elseif CharInfo.PlayerData.Faction == "Neutral" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Neutral_Color)
			end



			curCharFrame.charTexture:SetVertexColor(charR, charG, charB, E.backgroundColorAOverlay)
			-- Обработчики событий для фрейма персонажа
			curCharFrame:SetScript("OnEnter", function(self)
					curCharFrame.tooltip = E:func_Tooltip_Chars(CharInfo)
					-- E:func_OctoTooltip_OnEnter(curCharFrame, {"BOTTOM", "TOP"})
					E:func_OctoTooltip_OnEnter(curCharFrame, {"BOTTOMLEFT", "TOPRIGHT"})
			end)
			curCharFrame:Show()
		end
	end
end
-- Открытие главного фрейма по /octo
function Octo_EventFrame_ToDo:main_frame_toggle()
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
	end
end
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED", -- Загрузка аддона
	"PLAYER_LOGIN", -- Вход игрока
	"PLAYER_REGEN_DISABLED", -- Вход в бой
	"READY_CHECK", -- Проверка готовности
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_ToDo, MyEventsTable)
-- Обработчик события загрузки аддона
function Octo_EventFrame_ToDo:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	-- Загружаем настройки или устанавливаем значения по умолчанию
	LINE_HEIGHT = Octo_ToDo_DB_Vars.AddonHeight or LINE_HEIGHT
	LINE_WIDTH_LEFT = Octo_ToDo_DB_Vars.AddonLeftFrameWeight or LINE_WIDTH_LEFT
	LINE_WIDTH_CENT = Octo_ToDo_DB_Vars.LINE_WIDTH_CENT or LINE_WIDTH_CENT
	LINES_MAX = Octo_ToDo_DB_Vars.AddonCentralFrameWeight or LINES_MAX





	-- Рассчитываем максимальное количество персонажей
	local maxNum = math.floor((E.MonitorWidth - LINE_WIDTH_LEFT) / LINE_WIDTH_CENT) - 1
	COLUMNS_MAX = Octo_ToDo_DB_Vars.MaxNumCharacters and math_min(Octo_ToDo_DB_Vars.MaxNumCharacters, maxNum) or COLUMNS_MAX
	-- Объединяем таблицы квестов и предметов
	local function ConcatAtStart()
		E:func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
		for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Other) do
			E.OctoTable_itemID_ItemsUsable[itemID] = 1
		end
	end
	ConcatAtStart()
end
-- Обработчик события входа игрока
function Octo_EventFrame_ToDo:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	-- Устанавливаем масштаб меню игры
	GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.GameMenuFrameScale or 1)
	-- Инициализируем основные системы
	E:InitOptions()
	self:Octo_Create_MainFrame_ToDo()
	E:func_Create_DDframe_ToDo(Octo_MainFrame_ToDo, E.Red_Color, function() E:func_TODO_CreateDataProvider() end)
	E:func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, nil, "Octo_MainFrame_ToDo")
	-- Загружаем ресурсы с небольшой задержкой
	C_Timer.After(0, function()
			self:LoadAssetsAsync()
	end)
end
-- Функция асинхронной загрузки ресурсов
function Octo_EventFrame_ToDo:LoadAssetsAsync()
	local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
	-- Добавляем предметы, заклинания и квесты для загрузки
	promise:AddItems(E.PromiseItem)
	promise:AddItems(E.OctoTable_itemID_ALL)
	promise:AddSpells(E.PromiseSpell)
	promise:AddQuests(E.PromiseQuest)
	promise:Then(function()
			if Octo_MainFrame_ToDo:IsShown() then
				E:func_TODO_CreateDataProvider() -- Обновляем данные после загрузки
			end
	end)
end
-- Обработчик проверки готовности
function Octo_EventFrame_ToDo:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
-- Обработчик входа в бой
function Octo_EventFrame_ToDo:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
		Octo_MainFrame_ToDo:Hide() -- Скрываем фрейм в бою
	end
end
----------------------------------------------------------------
-- Slash-команды
----------------------------------------------------------------
local slashCommands = {
	OCTO = {
		commands = {"/octo"},
		handler = function(msg)
			if not InCombatLockdown() then
				Octo_EventFrame_ToDo:main_frame_toggle() -- Переключаем фрейм
			end
		end
	},
	RELOAD = {
		commands = {"/rl"},
		handler = E.ReloadUI -- Перезагрузка интерфейса
	},
	FRAMESTK = {
		commands = {"/fs"},
		handler = function(msg)
			-- Показ стека фреймов
			if not E:func_IsAddOnLoaded("Blizzard_DebugTools") then
				E:func_LoadAddOnFORCED("Blizzard_DebugTools")
			end
			FrameStackTooltip_Toggle(msg == "true", true, true)
		end
	}
}
-- Регистрируем все slash-команды
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_"..name..i] = cmd
	end
end

