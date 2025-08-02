local GlobalAddonName, E = ...
local Octo_Event_TestFrame = CreateFrame("FRAME")
Octo_Event_TestFrame:Hide()

-- Создание главного фрейма для тестового интерфейса
local Octo_Main_TestFrame = CreateFrame("BUTTON", "Octo_Main_TestFrame", UIParent, "BackdropTemplate")
Octo_Main_TestFrame:Hide()
E:func_InitFrame(Octo_Main_TestFrame)

-- Создание тестовой кнопки для переключения интерфейса
local TestButton1 = CreateFrame("Button", "TestButton1", UIParent, "UIPanelButtonTemplate")

-- Создание фрейма для заголовка левой колонки
local HeaderFrameLEFT = CreateFrame("FRAME", nil, Octo_Main_TestFrame)

-- Константы для настройки интерфейса
local INDENT_TEST = 4                      -- Отступ для текста
local LINE_HEIGHT = 20                     -- Высота одной строки
local HEADER_HEIGHT = LINE_HEIGHT*2        -- Высота заголовка
local MIN_LINE_WIDTH_LEFT = 200            -- Минимальная ширина левой колонки
local MIN_LINE_WIDTH_CENT = 90             -- Минимальная ширина центральной колонки
local LINES_MAX = 100                      -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.MonitorWidth*.8  -- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.MonitorHeight*.8 -- Максимальная высота фрейма (80% экрана)
Octo_Event_TestFrame.COLUMNS_MAX = 113     -- Максимальное количество колонок

-- Цветовые настройки
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1  -- Цвет границы (черный)
local textR, textG, textB, textA = 1, 1, 1, 1                              -- Цвет текста (белый)
local classR, classG, classB = GetClassColor(E.classFilename)               -- Цвет класса игрока
local LEFT_TEXTURE_ALPHA = 0.1                                              -- Прозрачность текстуры левой колонки
local charR, charG, charB = 1, 1, 1

-- Локальные ссылки на часто используемые функции для оптимизации
local math_min = math.min
local math_max = math.max

-- Функция инициализации элементов левой колонки
local func_OnAcquiredLEFT = function(owner, frame, data, new)
	if not new then return end

	local JustifyV = "MIDDLE"  -- Вертикальное выравнивание
	local JustifyH = "LEFT"     -- Горизонтальное выравнивание

	-- Настройки фрейма
	frame:SetPropagateMouseClicks(true)
	frame:SetPropagateMouseMotion(true)
	frame:SetHitRectInsets(1, 1, 1, 1)

	-- Создание полноразмерного фрейма для подсветки
	local frameFULL = CreateFrame("Button", nil, Octo_Main_TestFrame)
	frameFULL:SetPropagateMouseClicks(true)
	frameFULL:SetPropagateMouseMotion(true)
	frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
	frameFULL:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD")
	frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
	frameFULL.HighlightTexture:SetAlpha(E.backgroundColorAOverlay)
	frameFULL:SetPoint("LEFT", frame)
	frameFULL:SetPoint("TOP", frame)
	frameFULL:SetPoint("BOTTOM", frame)
	frameFULL:SetPoint("RIGHT")
	frame.frameFULL = frameFULL

	-- Текстовое поле для левой колонки
	frame.textLEFT = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.textLEFT:SetPoint("LEFT", INDENT_TEST+0, 0)
	frame.textLEFT:SetWidth(INDENT_TEST+MIN_LINE_WIDTH_LEFT)
	frame.textLEFT:SetFontObject(OctoFont11)
	frame.textLEFT:SetWordWrap(false)
	frame.textLEFT:SetJustifyV(JustifyV)
	frame.textLEFT:SetJustifyH(JustifyH)
	frame.textLEFT:SetTextColor(textR, textG, textB, textA)

	-- Текстура для фона левой колонки
	frame.textureLEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
	frame.textureLEFT:Hide()
	frame.textureLEFT:SetAllPoints()
	frame.textureLEFT:SetTexture(E.TEXTURE_LEFT_PATH)

	-- Обработчики событий показа/скрытия фрейма
	frame:SetScript("OnHide", function()
		frame.frameFULL:Hide()
	end)

	frame:SetScript("OnShow", function()
		frame.frameFULL:Show()
	end)
end

-- Функция инициализации элементов центральной колонки
local func_OnAcquiredCENT do
	function func_OnAcquiredCENT(owner, frame, data, new)
		if not new then return end

		frame:SetPropagateMouseClicks(true)

		-- Создание метатаблицы для динамического создания подфреймов
		frame.second = setmetatable({}, {
			__index = function(self, key)
				if key then
					-- Создание нового подфрейма для колонки
					local f = CreateFrame("BUTTON", "frame.second"..key, frame)
					f:SetPropagateMouseClicks(true)
					f:SetPropagateMouseMotion(true)
					f:SetHeight(LINE_HEIGHT)
					f:SetHitRectInsets(1, 1, 1, 1)
					f:SetPoint("LEFT", frame, "LEFT", 0, 0)

					-- Текстура для фона текущего персонажа
					f.curCharTextureBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
					f.curCharTextureBG:SetAllPoints()
					f.curCharTextureBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
					f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.backgroundColorAOverlay)
					f.curCharTextureBG:Hide()

					-- Текстура для фона репутации
					f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
					f.ReputTextureAndBG:SetPoint("LEFT")
					f.ReputTextureAndBG:SetHeight(LINE_HEIGHT)
					f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)

					-- Текстовое поле для центральной колонки
					f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					f.textCENT:SetAllPoints()
					f.textCENT:SetFontObject(OctoFont11)
					f.textCENT:SetWordWrap(false)
					f.textCENT:SetJustifyV("MIDDLE")
					f.textCENT:SetJustifyH("CENTER")
					f.textCENT:SetTextColor(textR, textG, textB, textA)

					-- Обработчик наведения курсора
					f:SetScript("OnEnter", function() E:func_OctoTooltip_OnEnter(f) end)

					-- Обработчики скрытия
					f:SetScript("OnHide", f.Hide)
					f.curCharTextureBG:SetScript("OnHide", f.curCharTextureBG.Hide)

					rawset(self, key, f)
					return f
				end
			end
		})
	end
end

-- Функция инициализации данных для левой колонки
function Octo_Event_TestFrame:Octo_Frame_initLEFT(frame, node)
	local frameData = node:GetData()

	-- Обновление размеров колонки, если они были изменены
	if Octo_Event_TestFrame.COLUMN_SIZES_LEFT and Octo_Event_TestFrame.COLUMN_SIZES_LEFT[1] then
		local newLeftWidth = Octo_Event_TestFrame.COLUMN_SIZES_LEFT[1]
		Octo_Main_TestFrame.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEST)
		frame.textLEFT:SetWidth(newLeftWidth)
		HeaderFrameLEFT:SetWidth(newLeftWidth)
	end

	-- Установка текста и цвета для левой колонки
	frame.textLEFT:SetText(frameData.textLEFT)

	if frameData.colorLEFT then
		local r, g, b = E:func_hex2rgbNUMBER(frameData.colorLEFT)
		frame.textureLEFT:SetVertexColor(r, g, b, LEFT_TEXTURE_ALPHA)
		frame.textureLEFT:Show()
	else
		frame.textureLEFT:Hide()
	end

	-- Получение данных для тултипа
	local typeQ, ID, iANIMA, kCovenant = frameData.myType[1], frameData.myType[2], frameData.myType[3], frameData.myType[4]

	-- Обработчик наведения курсора для отображения тултипа
	frame:SetScript("OnEnter", function()
		local tooltipOCTO = {}

		if type(ID) == "table" then
			-- Обработка нескольких ID
			for _, tblID in ipairs(ID) do
				E:func_TableConcat(tooltipOCTO, E:func_tooltipCurrencyAllPlayers(typeQ, tblID, iANIMA, kCovenant))
			end
		else
			-- Обработка одиночного ID
			tooltipOCTO = E:func_tooltipCurrencyAllPlayers(typeQ, ID, iANIMA, kCovenant)
		end

		frame.tooltip = tooltipOCTO
		E:func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end)
end

-- Функция инициализации данных для центральной колонки
function Octo_Event_TestFrame:Octo_Frame_initCENT(frame, node)
	local frameData = node:GetData()
	local accumulatedWidth = 0
	local columnSizesRight = Octo_Event_TestFrame.COLUMN_SIZES_RIGHT or {}

	-- Инициализация всех колонок для текущей строки
	for i = 1, (frameData.totalColumns or 0) do
		local secondFrame = frame.second[i]
		if not secondFrame then
			secondFrame = frame.second[i] -- Это вызовет __index из метатаблицы
		end

		-- Установка позиции и размера колонки
		secondFrame:ClearAllPoints()
		secondFrame:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
		local columnWidth = columnSizesRight[i] or MIN_LINE_WIDTH_CENT
		secondFrame:SetWidth(columnWidth)
		accumulatedWidth = accumulatedWidth + columnWidth

		-- Установка текста и стилей для колонки
		if frameData.textCENT and frameData.textCENT[i] then
			local textCENT = frameData.textCENT[i]
			secondFrame.ReputTextureAndBG:Hide()

			-- Установка цвета фона, если он задан
			if frameData.colorCENT and frameData.colorCENT[i] then
				local r1, g1, b1 = E:func_hex2rgbNUMBER(frameData.colorCENT[i])
				secondFrame.ReputTextureAndBG:SetWidth(columnWidth)
				secondFrame.ReputTextureAndBG:Show()
				secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
			end

			secondFrame.textCENT:SetText(textCENT)

			-- Подсветка колонки текущего персонажа если больше 1 персонажа
			if frameData.totalPers > 1 and i == frameData.currentCharacterIndex then
				secondFrame.curCharTextureBG:Show()
			else
				secondFrame.curCharTextureBG:Hide()
			end
		else
			secondFrame.textCENT:SetText("")
			secondFrame.ReputTextureAndBG:SetVertexColor(0, 0, 0, 0)
			secondFrame.curCharTextureBG:Hide()
		end

		-- Установка тултипа для колонки, если он есть
		if frameData.tooltipRIGHT and frameData.tooltipRIGHT[i] then
			secondFrame.tooltip = frameData.tooltipRIGHT[i]
		else
			secondFrame.tooltip = nil
		end

		secondFrame:Show()
	end
end

-- Функция создания главного тестового фрейма
function Octo_Event_TestFrame:Octo_Create_MainFrame_TestFrame()
	-- Настройка позиции и обработчика показа фрейма
	-- Octo_Main_TestFrame:SetPoint("TOP", 0, -E.MonitorWidth*.05)
	Octo_Main_TestFrame:SetPoint("CENTER") -- ПОФИКСИТЬ
	Octo_Main_TestFrame:SetScript("OnShow", function()
		Octo_Event_TestFrame:CreateDataProvider()
		RequestRaidInfo()
	end)

	-- Расчет размеров фрейма на основе количества игроков
	local NumPlayers = math_min(E:func_NumPlayers(), Octo_Event_TestFrame.COLUMNS_MAX)
	Octo_Main_TestFrame:SetSize(MIN_LINE_WIDTH_LEFT + MIN_LINE_WIDTH_CENT * NumPlayers, LINE_HEIGHT * LINES_MAX)

	-- Настройки фрейма
	Octo_Main_TestFrame:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_Main_TestFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	Octo_Main_TestFrame:SetFrameStrata("HIGH")

	-- Создание скроллфрейма для горизонтальной прокрутки
	local barPanelScroll = CreateFrame("ScrollFrame", nil, Octo_Main_TestFrame)
	Octo_Main_TestFrame.barPanelScroll = barPanelScroll

	-- Функции для обработки горизонтальной прокрутки
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
	-- fpde(self:GetHorizontalScrollRange())
	barPanelScroll:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	barPanelScroll:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)

	-- Создание и настройка горизонтальной полосы прокрутки
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, Octo_Main_TestFrame, "OctoWowTrimHorizontalScrollBar")
	HorizontalScrollBar.Backplate = HorizontalScrollBar:GetRegions()
	HorizontalScrollBar.Backplate:Hide()

	-- Настройка текстур для полосы прокрутки
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

	-- Обработчик прокрутки
	HorizontalScrollBar:RegisterCallback(HorizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
		barPanelScroll:SetHorizontalScroll(scrollPercentage * barPanelScroll:GetHorizontalScrollRange())
	end)

	HorizontalScrollBar:SetHideIfUnscrollable(true)

	-- Создание дочернего фрейма для центральной части
	local childCENT = CreateFrame("FRAME")
	Octo_Main_TestFrame.childCENT = childCENT
	barPanelScroll:SetScrollChild(childCENT)

	-- Создание ScrollBox для левой колонки
	Octo_Main_TestFrame.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_Main_TestFrame, "WowScrollBoxList")
	Octo_Main_TestFrame.ScrollBoxLEFT:SetWidth(INDENT_TEST+MIN_LINE_WIDTH_LEFT)
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_Main_TestFrame.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)

	-- Настройка позиции панели прокрутки
	barPanelScroll:SetPoint("TOPLEFT", Octo_Main_TestFrame.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	barPanelScroll:SetPoint("BOTTOMRIGHT")

	-- Создание и настройка представления для левой колонки
	Octo_Main_TestFrame.viewLEFT = CreateScrollBoxListTreeListView(0)
	Octo_Main_TestFrame.viewLEFT:SetElementExtent(LINE_HEIGHT)
	Octo_Main_TestFrame.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	Octo_Main_TestFrame.viewLEFT:RegisterCallback(Octo_Main_TestFrame.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, Octo_Main_TestFrame)

	-- Создание ScrollBox для центральной колонки
	Octo_Main_TestFrame.ScrollBoxCENT = CreateFrame("FRAME", nil, childCENT, "WowScrollBoxList")
	Octo_Main_TestFrame.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_Main_TestFrame.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	Octo_Main_TestFrame.ScrollBoxCENT:SetPropagateMouseClicks(true)
	Octo_Main_TestFrame.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)

	-- Создание и настройка вертикальной полосы прокрутки
	Octo_Main_TestFrame.ScrollBarCENT = CreateFrame("EventFrame", nil, Octo_Main_TestFrame, "MinimalScrollBar")
	Octo_Main_TestFrame.ScrollBarCENT:SetPoint("TOPLEFT", Octo_Main_TestFrame, "TOPRIGHT", 6, 0)
	Octo_Main_TestFrame.ScrollBarCENT:SetPoint("BOTTOMLEFT", Octo_Main_TestFrame, "BOTTOMRIGHT", 6, 0)

	-- Создание и настройка представления для центральной колонки
	Octo_Main_TestFrame.viewCENT = CreateScrollBoxListTreeListView(0)
	Octo_Main_TestFrame.viewCENT:SetElementExtent(LINE_HEIGHT)
	Octo_Main_TestFrame.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_Main_TestFrame.viewCENT:RegisterCallback(Octo_Main_TestFrame.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_Main_TestFrame)

	-- Инициализация ScrollBox с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_Main_TestFrame.ScrollBoxLEFT, Octo_Main_TestFrame.ScrollBarCENT, Octo_Main_TestFrame.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_Main_TestFrame.ScrollBoxLEFT, Octo_Main_TestFrame.ScrollBarCENT)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_Main_TestFrame.ScrollBoxCENT, Octo_Main_TestFrame.ScrollBarCENT, Octo_Main_TestFrame.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_Main_TestFrame.ScrollBoxCENT, Octo_Main_TestFrame.ScrollBarCENT)

	-- Настройка фона и границы главного фрейма
	Octo_Main_TestFrame:SetBackdrop(E.menuBackdrop)
	Octo_Main_TestFrame:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_Main_TestFrame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)

	-- Настройка взаимодействия с фреймом
	Octo_Main_TestFrame:EnableMouse(true)
	Octo_Main_TestFrame:SetMovable(true)

	-- Обработчики перемещения фрейма
	Octo_Main_TestFrame:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			Octo_Main_TestFrame:SetAlpha(Octo_ToDo_DB_Vars.AlphaOnDrag or E.backgroundColorA)
			Octo_Main_TestFrame:StartMoving()
		end
	end)

	Octo_Main_TestFrame:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			Octo_Main_TestFrame:SetAlpha(1)
			Octo_Main_TestFrame:StopMovingOrSizing()

			-- local point, _, relativePoint, xOfs, yOfs = Octo_Main_TestFrame:GetPoint()
			-- print (point, relativePoint, xOfs, yOfs)
		end
	end)

	-- Обработчик клика правой кнопкой для скрытия фрейма
	Octo_Main_TestFrame:RegisterForClicks("RightButtonUp")
	Octo_Main_TestFrame:SetScript("OnClick", Octo_Main_TestFrame.Hide)

	-- Настройка заголовка левой колонки
	HeaderFrameLEFT:SetPoint("TOPLEFT")
	HeaderFrameLEFT:SetSize(MIN_LINE_WIDTH_LEFT, HEADER_HEIGHT)

	HeaderFrameLEFT.text = HeaderFrameLEFT:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	HeaderFrameLEFT.text:SetPoint("CENTER")
	HeaderFrameLEFT.text:SetFontObject(OctoFont11)
	HeaderFrameLEFT.text:SetWordWrap(false)
	HeaderFrameLEFT.text:SetJustifyV("MIDDLE")
	HeaderFrameLEFT.text:SetJustifyH("LEFT")
	HeaderFrameLEFT.text:SetTextColor(textR, textG, textB, textA)

	-- Обработчик показа заголовка левой колонки
	HeaderFrameLEFT:SetScript("OnShow", function()
		HeaderFrameLEFT.text:SetText(E:func_texturefromIcon(E.Icon_Faction).."Weekly Reset: "..E.Faction_Color..E:func_SecondsToClock(E:func_GetWeeklyReset()).."|r")
	end)

	-- Функция сброса пула фреймов
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end

	-- Функция инициализации фреймов в пуле
	local function InitializePoolFrame(self)
		self:SetSize(MIN_LINE_WIDTH_CENT, HEADER_HEIGHT)

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

	-- Создание пула фреймов для заголовков колонок
	Octo_Main_TestFrame.pool = CreateFramePool("FRAME", childCENT, nil, ResetPoolFrame, false, InitializePoolFrame)
end

-- Функция расчета ширины колонок для левой части
local function calculateColumnWidthsLEFT(node, totalLines)
	local frameData = node:GetData()
	local framesLEFT = Octo_Main_TestFrame.viewLEFT:GetFrames()
	local framesCENT = Octo_Main_TestFrame.viewCENT:GetFrames()

	-- Создание тестовых фреймов, если их нет
	if #framesLEFT == 0 then
		Octo_Main_TestFrame.viewLEFT:AcquireInternal(1, node)
		Octo_Main_TestFrame.viewLEFT:InvokeInitializers()
	end

	if #framesCENT == 0 then
		Octo_Main_TestFrame.viewCENT:AcquireInternal(1, node)
		Octo_Main_TestFrame.viewCENT:InvokeInitializers()
	end

	-- Расчет ширины на основе текста
	local columnWidthsLEFT = {}
	local sampleFrameLEFT = framesLEFT[1]
	sampleFrameLEFT.textLEFT:SetText(frameData.textLEFT)
	columnWidthsLEFT[1] = math.ceil(sampleFrameLEFT.textLEFT:GetStringWidth())

	return columnWidthsLEFT
end

-- Функция расчета ширины колонок для правой части
local function calculateColumnWidthsRIGHT(node, totalLines)
	local frameData = node:GetData()
	local framesCENT = Octo_Main_TestFrame.viewCENT:GetFrames()

	-- Создание тестовых фреймов, если их нет
	if #framesCENT == 0 then
		Octo_Main_TestFrame.viewCENT:AcquireInternal(1, node)
		Octo_Main_TestFrame.viewCENT:InvokeInitializers()
		framesCENT = Octo_Main_TestFrame.viewCENT:GetFrames()
	end

	local columnWidthsRIGHT = {}
	local sampleFrameCENT = framesCENT[1]

	-- Инициализация всех подфреймов
	for i = 1, frameData.totalColumns do
		if not sampleFrameCENT.second[i] then
			sampleFrameCENT.second[i] = sampleFrameCENT.second[i] -- Вызовет __index
		end
	end

	-- Расчет ширины для каждой колонки
	for i = 1, frameData.totalColumns do
		if frameData.textCENT[i] then
			sampleFrameCENT.second[i].textCENT:SetText(frameData.textCENT[i])
			columnWidthsRIGHT[i] = math.ceil(math_max(
							sampleFrameCENT.second[i].textCENT:GetStringWidth() + 10,
							MIN_LINE_WIDTH_CENT
						))
		else
			columnWidthsRIGHT[i] = MIN_LINE_WIDTH_CENT
		end
	end

	return columnWidthsRIGHT
end

-- Функция создания и обновления провайдера данных
function Octo_Event_TestFrame:CreateDataProvider()
	Octo_Event_TestFrame.COLUMN_SIZES_LEFT = Octo_Event_TestFrame.COLUMN_SIZES_LEFT or {}
	Octo_Event_TestFrame.COLUMN_SIZES_RIGHT = Octo_Event_TestFrame.COLUMN_SIZES_RIGHT or {}

	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local COLUMN_SIZES_LEFT = {}
	local COLUMN_SIZES_RIGHT = {}

	-- Получение отсортированных данных персонажей
	local tbl = E:func_sorted()
	local currentCharacterIndex

	-- Поиск индекса текущего персонажа
	for CharIndex, CharInfo in ipairs(tbl) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end

	local totalColumns = #tbl
	local totalPers = totalColumns

	-- Обработка данных для каждой строки
	for _, func in ipairs(E:func_Concat_Otrisovka()) do
		totalLines = totalLines + 1

		local zxc = {
			textLEFT = {},
			colorLEFT = {},
			textCENT = {},
			tooltipRIGHT = {},
			colorCENT = {},
			myType = {},
			totalPers = totalPers,
		}

		-- Заполнение данных для каждого персонажа
		for CharIndex, CharInfo in ipairs(tbl) do
			local _, _, textCENT, tooltipRIGHT, colorCENT = func(CharInfo)
			zxc.textCENT[CharIndex] = textCENT
			zxc.tooltipRIGHT[CharIndex] = tooltipRIGHT or {}
			zxc.colorCENT[CharIndex] = colorCENT
		end

		-- Заполнение данных для левой колонки (берется из первого персонажа)
		local firstChar = tbl[1]
		if firstChar then
			local textLEFT, colorLEFT, _, _, _, myType = func(firstChar)
			zxc.textLEFT = textLEFT
			zxc.colorLEFT = colorLEFT
			zxc.myType = myType or {}
		end

		-- Установка дополнительных параметров
		zxc.currentCharacterIndex = currentCharacterIndex
		zxc.totalColumns = totalColumns

		-- Вставка данных в провайдер
		local node = DataProvider:Insert(zxc)

		-- Расчет ширины колонок
		for j, w in ipairs(calculateColumnWidthsLEFT(node, totalLines)) do
			COLUMN_SIZES_LEFT[j] = math_max(w, COLUMN_SIZES_LEFT[j] or HeaderFrameLEFT.text:GetWidth() or 0)
		end

		local rightWidths = calculateColumnWidthsRIGHT(node, totalLines)
		for i, w in ipairs(rightWidths) do
			COLUMN_SIZES_RIGHT[i] = math_max(w, COLUMN_SIZES_RIGHT[i] or MIN_LINE_WIDTH_CENT)
		end
	end

	-- Сохранение рассчитанных размеров колонок
	Octo_Event_TestFrame.COLUMN_SIZES_LEFT = COLUMN_SIZES_LEFT
	Octo_Event_TestFrame.COLUMN_SIZES_RIGHT = COLUMN_SIZES_RIGHT

	-- Обновление интерфейса, если фрейм существует
	if Octo_Main_TestFrame then
		Octo_Main_TestFrame.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_Main_TestFrame.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)

		-- Расчет общей ширины правой части
		local totalRightWidth = 0
		local maxRIGHT = MAX_FRAME_WIDTH - COLUMN_SIZES_LEFT[1]+INDENT_TEST

		for i = 1, math_min(#COLUMN_SIZES_RIGHT, Octo_Event_TestFrame.COLUMNS_MAX) do
			if (totalRightWidth + COLUMN_SIZES_RIGHT[i]) <= maxRIGHT then
				totalRightWidth = totalRightWidth + COLUMN_SIZES_RIGHT[i]
			else
				break
			end
		end

		local totalRightWidth_childCENT = 0
		for i = 1, math_min(#COLUMN_SIZES_RIGHT, Octo_Event_TestFrame.COLUMNS_MAX) do
			totalRightWidth_childCENT = totalRightWidth_childCENT + COLUMN_SIZES_RIGHT[i]
		end

		-- Расчет количества строк
		local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / LINE_HEIGHT)
		LINES_MAX = math_max(1, math_min(totalLines, LINES_TOTAL or totalLines))

		-- Установка размеров фрейма
		local width = (COLUMN_SIZES_LEFT[1]+INDENT_TEST or MIN_LINE_WIDTH_LEFT) + totalRightWidth
		local height = LINE_HEIGHT * LINES_MAX + HEADER_HEIGHT

		Octo_Main_TestFrame:SetSize(width, height)


		-- print (E.Blue_Color.."left|r", COLUMN_SIZES_LEFT[1]+INDENT_TEST)
		-- print (E.Red_Color.."rightChild|r", totalRightWidth_childCENT)
		-- print (E.Gray_Color.."rightChild|r", totalRightWidth)
		-- print (E.Purple_Color.."MainFrame|r", width)


		Octo_Main_TestFrame.childCENT:SetSize(totalRightWidth_childCENT, height) -- ПОФИКСИТЬ? - INDENT_TEST

		-- Освобождение всех фреймов из пула
		Octo_Main_TestFrame.pool:ReleaseAll()

		-- Создание заголовков для колонок персонажей
		local accumulatedWidth = 0
		for count, CharInfo in ipairs(tbl) do
			local HeaderFrameRIGHT = Octo_Main_TestFrame.pool:Acquire()
			local columnWidth = COLUMN_SIZES_RIGHT[count] or MIN_LINE_WIDTH_CENT

			-- Установка позиции и размера заголовка
			HeaderFrameRIGHT:SetPoint("BOTTOMLEFT", Octo_Main_TestFrame.childCENT, "TOPLEFT", accumulatedWidth, -HEADER_HEIGHT)
			HeaderFrameRIGHT:SetSize(columnWidth, HEADER_HEIGHT)
			accumulatedWidth = accumulatedWidth + columnWidth

			-- Настройка текста заголовка
			HeaderFrameRIGHT.text:SetAllPoints()
			HeaderFrameRIGHT.text:SetFontObject(OctoFont11)
			HeaderFrameRIGHT.text:SetWordWrap(true)
			HeaderFrameRIGHT.text:SetJustifyV("MIDDLE")
			HeaderFrameRIGHT.text:SetJustifyH("CENTER")
			HeaderFrameRIGHT.text:SetMaxLines(3)
			HeaderFrameRIGHT.text:SetText(E:func_textCENT_Chars(CharInfo))

			-- Настройка взаимодействия
			HeaderFrameRIGHT:SetPropagateMouseClicks(true)
			HeaderFrameRIGHT:SetPropagateMouseMotion(true)
			HeaderFrameRIGHT:SetHitRectInsets(1, 1, 1, 1)



			-- Устанавливаем цвет фона в зависимости от фракции
			if CharInfo.PlayerData.Faction == "Horde" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Horde_Color)
			elseif CharInfo.PlayerData.Faction == "Alliance" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Alliance_Color)
			elseif CharInfo.PlayerData.Faction == "Neutral" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.Neutral_Color)
			end


			-- -- Установка цвета фона в зависимости от фракции
			-- local charR, charG, charB = E:func_hex2rgbNUMBER(CharInfo.PlayerData.Faction == "Horde" and E.Horde_Color or E.Alliance_Color)
			HeaderFrameRIGHT.charTexture:SetVertexColor(charR, charG, charB, E.backgroundColorAOverlay)

			-- Обработчик наведения для отображения тултипа
			HeaderFrameRIGHT:SetScript("OnEnter", function(self)
				HeaderFrameRIGHT.tooltip = E:func_Tooltip_Chars(CharInfo)
				E:func_OctoTooltip_OnEnter(HeaderFrameRIGHT, {"BOTTOMLEFT", "TOPRIGHT"})
			end)

			HeaderFrameRIGHT:Show()
		end

		-- Обновление позиций подфреймов в центральной колонке
		for _, frame in ipairs(Octo_Main_TestFrame.viewCENT:GetFrames()) do
			local accumulatedWidth = 0
			for i = 1, #COLUMN_SIZES_RIGHT do
				if frame.second[i] then
					frame.second[i]:ClearAllPoints()
					frame.second[i]:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
					frame.second[i]:SetWidth(COLUMN_SIZES_RIGHT[i])
					accumulatedWidth = accumulatedWidth + COLUMN_SIZES_RIGHT[i]
				end
			end
		end
	end
end

-- Функция переключения видимости главного фрейма
local function Toggle_Octo_Main_TestFrame(frame)
	if Octo_Main_TestFrame then
		Octo_Main_TestFrame:SetShown(not Octo_Main_TestFrame:IsShown())
	end
end

-- Функция создания тестовой кнопки
function Octo_Event_TestFrame:CreateTestButton1()
	-- Настройки кнопки
	TestButton1:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	TestButton1:SetPoint("TOPLEFT", 128, -256)
	TestButton1:SetSize(128, 32)
	TestButton1:SetText("Toggle_Octo_Main_TestFrame")

	-- Настройки взаимодействия
	TestButton1:EnableMouse(true)
	TestButton1:SetMovable(true)

	-- Обработчики перемещения кнопки
	TestButton1:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			TestButton1:SetAlpha(Octo_ToDo_DB_Vars.AlphaOnDrag or E.backgroundColorA)
			TestButton1:StartMoving()
		end
	end)

	TestButton1:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			TestButton1:SetAlpha(1)
			TestButton1:StopMovingOrSizing()
		end
	end)

	-- Обработчик клика для переключения фрейма
	TestButton1:RegisterForClicks("LeftButtonUp")
	TestButton1:SetScript("OnClick", Toggle_Octo_Main_TestFrame)
end

-- Таблица событий для регистрации
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_REGEN_DISABLED",
	"VARIABLES_LOADED"
}

-- Регистрация событий
E:func_RegisterMyEventsToFrames(Octo_Event_TestFrame, MyEventsTable)

-- Обработчик события ADDON_LOADED
function Octo_Event_TestFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	-- Создание интерфейса после загрузки аддона
	Octo_Event_TestFrame:Octo_Create_MainFrame_TestFrame()
	self:CreateTestButton1()
end

-- Обработчик события PLAYER_LOGIN
function Octo_Event_TestFrame:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	-- Создание выпадающего меню после входа игрока
	E:func_Create_DDframe_ToDo(Octo_Main_TestFrame, E.Faction_Color, function() Octo_Event_TestFrame:CreateDataProvider() end)
end

-- Обработчик события выхода из боя
function Octo_Event_TestFrame:PLAYER_REGEN_ENABLED()
	TestButton1:Show()
end

-- Обработчик события входа в бой
function Octo_Event_TestFrame:PLAYER_REGEN_DISABLED()
	Octo_Main_TestFrame:Hide()
	TestButton1:Hide()
end

-- Обработчик события загрузки переменных
function Octo_Event_TestFrame:VARIABLES_LOADED()
	-- Включение отладки времени выполнения функций, если установлен флаг
	if E.DEBUG_TIMINGS_TESTFRAME1 then
		wipe(Octo_Debug_DB.Functions)

		-- Функция для замера времени выполнения
		local function TimeFunctionExecution(funcName, func)
			Octo_Debug_DB.Functions[funcName] = {
				count = 0,
				minTime = math.huge,
				maxTime = 0,
				totalTime = 0,
			}

			return function(...)
				local startTime = debugprofilestop()
				local result = {func(...)}
				local executionTime = (debugprofilestop() - startTime)

				local stats = Octo_Debug_DB.Functions[funcName]
				stats.count = stats.count + 1
				stats.minTime = math.min(stats.minTime, executionTime)
				stats.maxTime = math.max(stats.maxTime, executionTime)
				stats.totalTime = stats.totalTime + executionTime

				-- print (funcName, stats.count)

				return table.unpack(result)
			end
		end

		-- Обертывание всех функций для замера времени
		for funcName, func in pairs(Octo_Event_TestFrame) do
			if type(func) == "function" and funcName ~= "OnEvent" and funcName ~= "OnUpdate" then
				Octo_Event_TestFrame[funcName] = TimeFunctionExecution(funcName, func)
			end
		end
	end
end