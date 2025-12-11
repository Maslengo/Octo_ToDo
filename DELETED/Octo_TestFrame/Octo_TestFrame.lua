local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
-- Создание главного фрейма для тестового интерфейса
local Octo_MainFrame_TestFrame = CreateFrame("BUTTON", "Octo_MainFrame_TestFrame", UIParent, "BackdropTemplate")
Octo_MainFrame_TestFrame:Hide()
E.func_InitFrame(Octo_MainFrame_TestFrame)
-- Создание фрейма для заголовка левой колонки
local HeaderFrameLeft = CreateFrame("FRAME", nil, Octo_MainFrame_TestFrame)
-- Константы для настройки интерфейса
local INDENT_TEXT = 4 		-- Отступ для текста
local LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT		-- Высота одной строки
local HEADER_HEIGHT = LINE_HEIGHT*2 		-- Высота заголовка
local MIN_COLUMN_WIDTH_LEFT = 200 		-- Минимальная ширина левой колонки
local MIN_COLUMN_WIDTH_Center = 90 		-- Минимальная ширина центральной колонки
local MAX_DISPLAY_LINES = E.MAX_DISPLAY_LINES -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.PHYSICAL_SCREEN_WIDTH*.8 		-- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.PHYSICAL_SCREEN_HEIGHT*.6 	-- Максимальная высота фрейма (60% экрана)
EventFrame.MAX_COLUMN_COUNT = 113 		-- Максимальное количество колонок
-- Цветовые настройки
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1 -- Цвет границы (черный)
local textR, textG, textB, textA = 1, 1, 1, 1 -- Цвет текста (белый)
local classR, classG, classB = GetClassColor(E.classFilename) -- Цвет класса игрока
local LEFT_TEXTURE_ALPHA = 0.1 -- Прозрачность текстуры левой колонки
local charR, charG, charB = 1, 1, 1
-- Локальные ссылки на часто используемые функции для оптимизации
local math_min = math.min
local math_max = math.max
local func_OnAcquiredLeft do
	local function func_OnEnter(frame)
		local frameData = frame:GetData()
		-- Получение данных для тултипа
		local typeQ, ID, iANIMA, kCovenant = frameData.myType[1], frameData.myType[2], frameData.myType[3], frameData.myType[4]
		local tooltipOCTO = {}
		if type(ID) == "table" then
			-- Обработка нескольких ID
			for _, tblID in ipairs(ID) do
				E.func_TableConcat(tooltipOCTO, E.func_KeyTooltip_LEFT(typeQ, tblID, iANIMA, kCovenant))
			end
		else
			-- Обработка одиночного ID
			tooltipOCTO = E.func_KeyTooltip_LEFT(typeQ, ID, iANIMA, kCovenant)
		end
		frame.tooltip = tooltipOCTO
		E.func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end
	-- Функция инициализации элементов левой колонки
	function func_OnAcquiredLeft(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		local JustifyV = "MIDDLE" -- Вертикальное выравнивание
		local JustifyH = "LEFT" -- Горизонтальное выравнивание
		-- Настройки фрейма
		frame:SetPropagateMouseClicks(true)
		frame:SetPropagateMouseMotion(true)
		frame:SetHitRectInsets(1, 1, 1, 1)
		-- Создание полноразмерного фрейма для подсветки
		local Highlight = CreateFrame("BUTTON", nil, owner)
		Highlight:SetPropagateMouseClicks(true)
		Highlight:SetPropagateMouseMotion(true)
		Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
		Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD")
		Highlight.HighlightTexture = Highlight:GetHighlightTexture()
		Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
		Highlight:SetPoint("LEFT", frame)
		Highlight:SetPoint("TOP", frame)
		Highlight:SetPoint("BOTTOM", frame)
		Highlight:SetPoint("RIGHT")
		frame.Highlight = Highlight
		-- Текстовое поле для левой колонки
		frame.TextLeft = frame:CreateFontString()
		frame.TextLeft:SetFontObject(OctoFont11)
		frame.TextLeft:SetPoint("LEFT", INDENT_TEXT+0, 0)
		frame.TextLeft:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
		frame.TextLeft:SetWordWrap(false)
		frame.TextLeft:SetJustifyV(JustifyV)
		frame.TextLeft:SetJustifyH(JustifyH)
		frame.TextLeft:SetTextColor(textR, textG, textB, textA)
		-- Текстура для фона левой колонки
		frame.TextureLeft = frame:CreateTexture(nil, "BACKGROUND", nil, -3) -- слой для фоновых текстур
		frame.TextureLeft:Hide()
		frame.TextureLeft:SetAllPoints()
		frame.TextureLeft:SetTexture(E.TEXTURE_LEFT_PATH)
		-- Обработчики событий показа/скрытия фрейма
		frame:SetScript("OnHide", function()
			frame.Highlight:Hide()
		end)
		frame:SetScript("OnShow", function()
			frame.Highlight:Show()
		end)
		-- Обработчик наведения курсора для отображения тултипа
		frame:SetScript("OnEnter", func_OnEnter)
	end
end
-- Функция инициализации элементов центральной колонки
local func_OnAcquiredCENT do
	function func_OnAcquiredCENT(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		frame:SetPropagateMouseClicks(true)
		-- Создание метатаблицы для динамического создания подфреймов
		frame.second = setmetatable({}, {
			__index = function(self, key)
				if key then
					-- Создание нового подфрейма для колонки
					local f = CreateFrame("BUTTON", nil, frame)
					f:SetPropagateMouseClicks(true)
					f:SetPropagateMouseMotion(true)
					f:SetHeight(LINE_HEIGHT)
					f:SetHitRectInsets(1, 1, 1, 1)
					f:SetPoint("LEFT", frame, "LEFT", 0, 0)
					-- Текстура для фона текущего персонажа
					f.curCharTextureBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
					f.curCharTextureBG:SetAllPoints()
					f.curCharTextureBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
					f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.ALPHA_BACKGROUND)
					f.curCharTextureBG:Hide()
					-- Текстура для фона репутации
					f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
					f.ReputTextureAndBG:SetPoint("LEFT")
					f.ReputTextureAndBG:SetHeight(LINE_HEIGHT)
					f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
					-- Текстовое поле для центральной колонки
					f.TextCenter = f:CreateFontString()
					f.TextCenter:SetFontObject(OctoFont11)
					f.TextCenter:SetAllPoints()
					f.TextCenter:SetWordWrap(false)
					f.TextCenter:SetJustifyV("MIDDLE")
					f.TextCenter:SetJustifyH("CENTER")
					f.TextCenter:SetTextColor(textR, textG, textB, textA)
					-- f:SetScript("OnEnter", E.func_OctoTooltip_OnEnter)
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
function EventFrame:func_initLEFT(frame, node)
	local frameData = node:GetData()
	-- Обновление размеров колонки, если они были изменены
	if EventFrame.columnWidthsLeft and EventFrame.columnWidthsLeft[1] then
		local newLeftWidth = EventFrame.columnWidthsLeft[1]
		Octo_MainFrame_TestFrame.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEXT)
		frame.TextLeft:SetWidth(newLeftWidth)
		HeaderFrameLeft:SetWidth(newLeftWidth)
	end
	-- Установка текста и цвета для левой колонки
	frame.TextLeft:SetText(frameData.TextLeft)
	if frameData.ColorLeft then
		local r, g, b = E.func_hex2rgbNUMBER(frameData.ColorLeft)
		frame.TextureLeft:SetVertexColor(r, g, b, 0) -- LEFT_TEXTURE_ALPHA
		frame.TextureLeft:Show()
	else
		frame.TextureLeft:Hide()
	end
end
-- Функция инициализации данных для центральной колонки
function EventFrame:Octo_Frame_initCENT(frame, node)
	local frameData = node:GetData()
	local accumulatedWidth = 0
	local columnSizesRight = EventFrame.columnWidthsRight or {}
	-- Инициализация всех колонок для текущей строки
	for i = 1, (frameData.totalColumns or 0) do
		local secondFrame = frame.second[i]
		if not secondFrame then
			secondFrame = frame.second[i] -- Это вызовет __index из метатаблицы
		end
		-- Установка позиции и размера колонки
		secondFrame:ClearAllPoints()
		secondFrame:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
		local columnWidth = columnSizesRight[i] or MIN_COLUMN_WIDTH_Center
		secondFrame:SetWidth(columnWidth)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Установка текста и стилей для колонки
		if frameData.TextCenter and frameData.TextCenter[i] then
			local TextCenter = frameData.TextCenter[i]
			secondFrame.ReputTextureAndBG:Hide()
			-- Установка цвета фона, если он задан
			if frameData.ColorCenter and frameData.ColorCenter[i] then
				local r1, g1, b1 = E.func_hex2rgbNUMBER(frameData.ColorCenter[i])
				secondFrame.ReputTextureAndBG:SetWidth(columnWidth)
				secondFrame.ReputTextureAndBG:Show()
				secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
			end
			secondFrame.TextCenter:SetText(TextCenter)
			-- Подсветка колонки текущего персонажа если больше 1 персонажа
			if frameData.totalColumns > 1 and i == frameData.currentCharacterIndex then
				secondFrame.curCharTextureBG:Show()
			else
				secondFrame.curCharTextureBG:Hide()
			end
		else
			secondFrame.TextCenter:SetText("")
			secondFrame.ReputTextureAndBG:SetVertexColor(0, 0, 0, 0)
			secondFrame.curCharTextureBG:Hide()
		end
		-- Установка тултипа для колонки, если он есть
		-- if frameData.tooltipCENT and frameData.tooltipCENT[i] then
		-- secondFrame.tooltip = frameData.tooltipCENT[i]
		-- else
		-- secondFrame.tooltip = nil
		-- end
		secondFrame:SetScript("OnEnter", function()
			if frameData.TooltipKey and frameData.GUID[i] then
				secondFrame.tooltip = E.func_KeyTooltip(frameData.GUID[i], frameData.TooltipKey)
			else
				secondFrame.tooltip = nil
			end
			E.func_OctoTooltip_OnEnter(secondFrame)
		end)
		secondFrame:Show()
	end
	for i = frameData.totalColumns+1, #frame.second do
		frame.second[i]:Hide()
	end
end
-- Функция создания главного тестового фрейма
function EventFrame:Octo_Create_MainFrame()
	-- Настройка позиции и обработчика показа фрейма
	-- Octo_MainFrame_TestFrame:SetPoint("TOP", 0, -E.PHYSICAL_SCREEN_WIDTH*.05)
	Octo_MainFrame_TestFrame:SetPoint("CENTER")
	Octo_MainFrame_TestFrame:SetScript("OnShow", function()
		EventFrame:CreateDataProvider()
		RequestRaidInfo()
	end)
	-- Расчет размеров фрейма на основе количества игроков
	local numPlayers = math_min(E.func_numPlayers(), EventFrame.MAX_COLUMN_COUNT)
	Octo_MainFrame_TestFrame:SetSize(MIN_COLUMN_WIDTH_LEFT + MIN_COLUMN_WIDTH_Center * numPlayers, LINE_HEIGHT * MAX_DISPLAY_LINES)
	-- Настройки фрейма
	Octo_MainFrame_TestFrame:SetDontSavePosition(true)
	Octo_MainFrame_TestFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_TestFrame:SetFrameStrata("HIGH")
	-- Создание скроллфрейма для горизонтальной прокрутки
	local horizontalScrollFrame = CreateFrame("ScrollFrame", nil, Octo_MainFrame_TestFrame)
	Octo_MainFrame_TestFrame.horizontalScrollFrame = horizontalScrollFrame
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
	-- opde(self:GetHorizontalScrollRange())
	horizontalScrollFrame:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	horizontalScrollFrame:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)
	-- Создание и настройка горизонтальной полосы прокрутки
	local horizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_TestFrame, "OctoWowTrimhorizontalScrollBar")
	EventFrame.horizontalScrollBar = horizontalScrollBar
	horizontalScrollBar.Backplate = horizontalScrollBar:GetRegions()
	horizontalScrollBar.Backplate:Hide()
	-- Настройка текстур для полосы прокрутки
	local regions = {
		horizontalScrollBar.Back.Texture,
		horizontalScrollBar.Forward.Texture,
		horizontalScrollBar.Track.Middle,
		horizontalScrollBar.Track.Begin,
		horizontalScrollBar.Track.End,
		horizontalScrollBar.Track.Thumb.Middle,
		horizontalScrollBar.Track.Thumb.Begin,
		horizontalScrollBar.Track.Thumb.End
	}
	for _, region in ipairs(regions) do
		region:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	end
	horizontalScrollFrame.hBar = horizontalScrollBar
	horizontalScrollBar:SetPoint("TOPLEFT", horizontalScrollFrame, "BOTTOMLEFT", 0, -6)
	horizontalScrollBar:SetPoint("TOPRIGHT", horizontalScrollFrame, "BOTTOMRIGHT")
	-- Обработчик прокрутки
	horizontalScrollBar:RegisterCallback(horizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
		horizontalScrollFrame:SetHorizontalScroll(scrollPercentage * horizontalScrollFrame:GetHorizontalScrollRange())
	end)
	horizontalScrollBar:SetHideIfUnscrollable(true)
	-- Создание дочернего фрейма для центральной части
	local scrollContentFrame = CreateFrame("FRAME", "scrollContentFrame")
	Octo_MainFrame_TestFrame.scrollContentFrame = scrollContentFrame
	horizontalScrollFrame:SetScrollChild(scrollContentFrame)
	-- Создание ScrollBox для левой колонки
	Octo_MainFrame_TestFrame.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_TestFrame, "WowScrollBoxList")
	Octo_MainFrame_TestFrame.ScrollBoxLEFT:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
	Octo_MainFrame_TestFrame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_TestFrame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_TestFrame.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_TestFrame.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Настройка позиции панели прокрутки
	horizontalScrollFrame:SetPoint("TOPLEFT", Octo_MainFrame_TestFrame.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	horizontalScrollFrame:SetPoint("BOTTOMRIGHT")
	-- Создание и настройка представления для левой колонки
	Octo_MainFrame_TestFrame.ViewLeft = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_TestFrame.ViewLeft:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_TestFrame.ViewLeft:SetElementInitializer("BUTTON", function(...) self:func_initLEFT(...) end)
	Octo_MainFrame_TestFrame.ViewLeft:RegisterCallback(Octo_MainFrame_TestFrame.ViewLeft.Event.OnAcquiredFrame, func_OnAcquiredLeft, Octo_MainFrame_TestFrame)
	-- Создание ScrollBox для центральной колонки
	Octo_MainFrame_TestFrame.ScrollBoxCenter = CreateFrame("FRAME", nil, scrollContentFrame, "WowScrollBoxList")
	Octo_MainFrame_TestFrame.ScrollBoxCenter:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_TestFrame.ScrollBoxCenter:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_TestFrame.ScrollBoxCenter:SetPropagateMouseClicks(true)
	Octo_MainFrame_TestFrame.ScrollBoxCenter:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Создание и настройка вертикальной полосы прокрутки
	Octo_MainFrame_TestFrame.ScrollBarCenter = CreateFrame("EventFrame", nil, Octo_MainFrame_TestFrame, "MinimalScrollBar")
	Octo_MainFrame_TestFrame.ScrollBarCenter:SetPoint("TOPLEFT", Octo_MainFrame_TestFrame, "TOPRIGHT", 6, 0)
	Octo_MainFrame_TestFrame.ScrollBarCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_TestFrame, "BOTTOMRIGHT", 6, 0)
	-- Создание и настройка представления для центральной колонки
	Octo_MainFrame_TestFrame.ViewCenter = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_TestFrame.ViewCenter:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_TestFrame.ViewCenter:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_MainFrame_TestFrame.ViewCenter:RegisterCallback(Octo_MainFrame_TestFrame.ViewCenter.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_MainFrame_TestFrame)
	-- Инициализация ScrollBox с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_TestFrame.ScrollBoxLEFT, Octo_MainFrame_TestFrame.ScrollBarCenter, Octo_MainFrame_TestFrame.ViewLeft)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_TestFrame.ScrollBoxLEFT, Octo_MainFrame_TestFrame.ScrollBarCenter)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_TestFrame.ScrollBoxCenter, Octo_MainFrame_TestFrame.ScrollBarCenter, Octo_MainFrame_TestFrame.ViewCenter)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_TestFrame.ScrollBoxCenter, Octo_MainFrame_TestFrame.ScrollBarCenter)
	-- Настройка фона и границы главного фрейма
	Octo_MainFrame_TestFrame:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_TestFrame:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_MainFrame_TestFrame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка взаимодействия с фреймом
	Octo_MainFrame_TestFrame:EnableMouse(true)
	Octo_MainFrame_TestFrame:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_MainFrame_TestFrame:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			Octo_MainFrame_TestFrame:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnTheMove or E.backgroundColorA)
			Octo_MainFrame_TestFrame:StartMoving()
		end
	end)
	Octo_MainFrame_TestFrame:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			Octo_MainFrame_TestFrame:SetAlpha(1)
			Octo_MainFrame_TestFrame:StopMovingOrSizing()
			-- local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_TestFrame:GetPoint()
			-- print (point, relativePoint, xOfs, yOfs)
		end
	end)
	-- Обработчик клика правой кнопкой для скрытия фрейма
	Octo_MainFrame_TestFrame:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_TestFrame:SetScript("OnClick", Octo_MainFrame_TestFrame.Hide)
	-- Настройка заголовка левой колонки
	HeaderFrameLeft:SetPoint("TOPLEFT")
	HeaderFrameLeft:SetSize(MIN_COLUMN_WIDTH_LEFT, HEADER_HEIGHT)
	HeaderFrameLeft.text = HeaderFrameLeft:CreateFontString()
	HeaderFrameLeft.text:SetFontObject(OctoFont11)
	HeaderFrameLeft.text:SetPoint("LEFT", INDENT_TEXT, 0)
	HeaderFrameLeft.text:SetWordWrap(false)
	HeaderFrameLeft.text:SetJustifyV("MIDDLE")
	HeaderFrameLeft.text:SetJustifyH("LEFT")
	HeaderFrameLeft.text:SetTextColor(textR, textG, textB, textA)
	-- Обработчик показа заголовка левой колонки
	HeaderFrameLeft:SetScript("OnShow", function()
		-- HeaderFrameLeft.text:SetText(E.func_texturefromIcon(E.ICON_FACTION).."Weekly Reset: "..E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetWeeklyReset()).."|r")
		HeaderFrameLeft.text:SetText(E.Purple_Color.."Weekly Reset:|r "..E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetWeeklyReset(), true).."|r ")
	end)
	-- Функция сброса пула фреймов
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	-- Функция инициализации фреймов в пуле
	local function InitializePoolFrame(self)
		self:SetSize(MIN_COLUMN_WIDTH_Center, HEADER_HEIGHT)
		self.text = self:CreateFontString()
		self.text:SetFontObject(OctoFont11)
		self.text:SetPoint("CENTER")
		self.text:SetJustifyV("MIDDLE")
		self.text:SetJustifyH("CENTER")
		self.text:SetTextColor(textR, textG, textB, textA)
		self.charTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.charTexture:SetAllPoints()
		self.charTexture:SetTexture(E.TEXTURE_CHAR_PATH)
	end
	-- Создание пула фреймов для заголовков колонок
	Octo_MainFrame_TestFrame.pool = CreateFramePool("FRAME", scrollContentFrame, nil, ResetPoolFrame, false, InitializePoolFrame)
end
-- Функция расчета ширины колонок для левой части
local function func_calculateColumnWidthsLEFT(node, totalLines)
	local frameData = node:GetData()
	local framesLEFT = Octo_MainFrame_TestFrame.ViewLeft:GetFrames()
	local framesCENT = Octo_MainFrame_TestFrame.ViewCenter:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesLEFT == 0 then
		Octo_MainFrame_TestFrame.ViewLeft:AcquireInternal(1, node)
		Octo_MainFrame_TestFrame.ViewLeft:InvokeInitializers()
	end
	if #framesCENT == 0 then
		Octo_MainFrame_TestFrame.ViewCenter:AcquireInternal(1, node)
		Octo_MainFrame_TestFrame.ViewCenter:InvokeInitializers()
	end
	-- Расчет ширины на основе текста
	local columnWidthsLEFT = {}
	local columnHeightsLEFT = {}
	local sampleFrameLEFT = framesLEFT[1]
	sampleFrameLEFT.TextLeft:SetText(frameData.TextLeft)
	columnWidthsLEFT[1] = math.ceil(sampleFrameLEFT.TextLeft:GetStringWidth())
	-- print (sampleFrameLEFT.TextLeft:GetStringHeight())
	return columnWidthsLEFT
end
-- Функция расчета ширины колонок для правой части
local function calculateColumnWidthsRIGHT(node, totalLines)
	local frameData = node:GetData()
	local framesCENT = Octo_MainFrame_TestFrame.ViewCenter:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesCENT == 0 then
		Octo_MainFrame_TestFrame.ViewCenter:AcquireInternal(1, node)
		Octo_MainFrame_TestFrame.ViewCenter:InvokeInitializers()
		framesCENT = Octo_MainFrame_TestFrame.ViewCenter:GetFrames()
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
		if frameData.TextCenter[i] then
			sampleFrameCENT.second[i].TextCenter:SetText(frameData.TextCenter[i])
			columnWidthsRIGHT[i] = math.ceil(math_max(
							sampleFrameCENT.second[i].TextCenter:GetStringWidth() + 10,
							MIN_COLUMN_WIDTH_Center
						))
		else
			columnWidthsRIGHT[i] = MIN_COLUMN_WIDTH_Center
		end
	end
	return columnWidthsRIGHT
end
----------------------------------------------------------------
-- Функция для объединения таблиц отрисовки
----------------------------------------------------------------
function E.func_Concat_Otrisovka()
	local tbl = {}
	-- Объединяем таблицы для каждого дополнения в обратном порядке (от нового к старому)
	E.func_TableConcat(tbl, E.func_Otrisovka_13_TheLastTitan())
	E.func_TableConcat(tbl, E.func_Otrisovka_12_Midnight())
	E.func_TableConcat(tbl, E.func_Otrisovka_11_TheWarWithin())
	E.func_TableConcat(tbl, E.func_Otrisovka_10_Dragonflight())
	E.func_TableConcat(tbl, E.func_Otrisovka_09_Shadowlands())
	E.func_TableConcat(tbl, E.func_Otrisovka_08_BattleforAzeroth())
	E.func_TableConcat(tbl, E.func_Otrisovka_07_Legion())
	E.func_TableConcat(tbl, E.func_Otrisovka_06_WarlordsofDraenor())
	E.func_TableConcat(tbl, E.func_Otrisovka_05_MistsofPandaria())
	E.func_TableConcat(tbl, E.func_Otrisovka_04_Cataclysm())
	E.func_TableConcat(tbl, E.func_Otrisovka_03_WrathoftheLichKing())
	E.func_TableConcat(tbl, E.func_Otrisovka_02_TheBurningCrusade())
	E.func_TableConcat(tbl, E.func_Otrisovka_01_WorldofWarcraft())
	-- Добавляем праздники и другие данные
	E.func_TableConcat(tbl, E.func_Otrisovka_90_Holidays())
	E.func_TableConcat(tbl, E.func_Otrisovka_91_Other())
	return tbl
end
-- Функция создания и обновления провайдера данных
function EventFrame:CreateDataProvider()
	-- EventFrame.columnWidthsLeft = EventFrame.columnWidthsLeft or {}
	-- EventFrame.columnWidthsRight = EventFrame.columnWidthsRight or {}
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local columnWidthsLeft = {}
	local columnWidthsRight = {}
	-- Получение отсортированных данных персонажей
	local tbl = E.func_sorted()
	local currentCharacterIndex
	-- Поиск индекса текущего персонажа
	for CharIndex, CharInfo in ipairs(tbl) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end
	local totalColumns = #tbl
	-- Обработка данных для каждой строки
	for _, func in ipairs(E.func_Concat_Otrisovka()) do
		totalLines = totalLines + 1
		local zxc = {
			TextLeft = {},
			ColorLeft = {},
			TextCenter = {},
			-- tooltipCENT = {},
			ColorCenter = {},
			myType = {},
			TooltipKey = {},
			GUID = {},
			-- CharInfo = {},
		}
		-- Заполнение данных для каждого персонажа
		for CharIndex, CharInfo in ipairs(tbl) do
			local _, _, TextCenter, _, ColorCenter = func(CharInfo)
			zxc.TextCenter[CharIndex] = TextCenter
			-- zxc.tooltipCENT[CharIndex] = tooltipCENT or {}
			zxc.ColorCenter[CharIndex] = ColorCenter
			zxc.GUID[CharIndex] = CharInfo.PlayerData.GUID
			-- zxc.CharInfo[CharIndex] = CharInfo
		end
		-- Заполнение данных для левой колонки (берется из первого персонажа)
		local firstChar = tbl[1]
		if firstChar then
			local TextLeft, ColorLeft, _, _, _, myType, TooltipKey = func(firstChar)
			zxc.TextLeft = TextLeft
			zxc.ColorLeft = ColorLeft
			zxc.myType = myType or {}
			zxc.TooltipKey = TooltipKey
		end
		-- Установка дополнительных параметров
		zxc.currentCharacterIndex = currentCharacterIndex
		zxc.totalColumns = totalColumns
		-- Вставка данных в провайдер
		local node = DataProvider:Insert(zxc)
		-- Расчет ширины колонок
		for j, w in ipairs(func_calculateColumnWidthsLEFT(node, totalLines)) do
			columnWidthsLeft[j] = math_max(w, columnWidthsLeft[j] or HeaderFrameLeft.text:GetWidth() or 0)
		end
		local rightWidths = calculateColumnWidthsRIGHT(node, totalLines)
		for i, w in ipairs(rightWidths) do
			columnWidthsRight[i] = math_max(w, columnWidthsRight[i] or MIN_COLUMN_WIDTH_Center)
		end
	end
	-- Сохранение рассчитанных размеров колонок
	EventFrame.columnWidthsLeft = columnWidthsLeft
	EventFrame.columnWidthsRight = columnWidthsRight
	-- Обновление интерфейса, если фрейм существует
	if not Octo_MainFrame_TestFrame or not Octo_MainFrame_TestFrame.scrollContentFrame then return end
	Octo_MainFrame_TestFrame.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	Octo_MainFrame_TestFrame.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	-- Расчет общей ширины правой части
	local totalRightWidth = 0
	local maxRIGHT = MIN_COLUMN_WIDTH_LEFT
	if columnWidthsLeft and columnWidthsLeft[1] then
		maxRIGHT = MAX_FRAME_WIDTH - columnWidthsLeft[1]+INDENT_TEXT
	end
	for i = 1, math_min(#columnWidthsRight, EventFrame.MAX_COLUMN_COUNT) do
		if (totalRightWidth + columnWidthsRight[i]) <= maxRIGHT then
			totalRightWidth = totalRightWidth + columnWidthsRight[i]
		else
			break
		end
	end
	local totalRightWidth_scrollContentFrame = 0
	for i = 1, math_min(#columnWidthsRight, EventFrame.MAX_COLUMN_COUNT) do
		totalRightWidth_scrollContentFrame = totalRightWidth_scrollContentFrame + columnWidthsRight[i]
	end
	-- Расчет количества строк
	local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / LINE_HEIGHT)
	MAX_DISPLAY_LINES = math_max(1, math_min(totalLines, LINES_TOTAL or totalLines))
	-- Установка размеров фрейма
	local width = MIN_COLUMN_WIDTH_LEFT
	if columnWidthsLeft and columnWidthsLeft[1] then
		width = (columnWidthsLeft[1]+INDENT_TEXT or MIN_COLUMN_WIDTH_LEFT) + totalRightWidth
	end
	if width%2 == 1 then
		width = width + 1
	end
	local height = LINE_HEIGHT * MAX_DISPLAY_LINES + HEADER_HEIGHT
	Octo_MainFrame_TestFrame:SetSize(width, height)
	-- print (E.Blue_Color.."left|r", columnWidthsLeft[1]+INDENT_TEXT)
	-- print (E.Red_Color.."rightChild|r", totalRightWidth_scrollContentFrame)
	-- print (E.Gray_Color.."rightChild|r", totalRightWidth)
	-- print (E.Purple_Color.."MainFrame|r", width)
	Octo_MainFrame_TestFrame.scrollContentFrame:SetSize(totalRightWidth_scrollContentFrame, height)
	-- Освобождение всех фреймов из пула
	Octo_MainFrame_TestFrame.pool:ReleaseAll()
	-- Создание заголовков для колонок персонажей
	local accumulatedWidth = 0
	for count, CharInfo in ipairs(tbl) do
		local HeaderFrameRIGHT = Octo_MainFrame_TestFrame.pool:Acquire()
		local columnWidth = columnWidthsRight[count] or MIN_COLUMN_WIDTH_Center
		-- Установка позиции и размера заголовка
		HeaderFrameRIGHT:SetPoint("BOTTOMLEFT", Octo_MainFrame_TestFrame.scrollContentFrame, "TOPLEFT", accumulatedWidth, -HEADER_HEIGHT)
		HeaderFrameRIGHT:SetSize(columnWidth, HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Настройка текста заголовка
		HeaderFrameRIGHT.text:SetAllPoints()
		HeaderFrameRIGHT.text:SetFontObject(OctoFont11)
		HeaderFrameRIGHT.text:SetWordWrap(true)
		HeaderFrameRIGHT.text:SetJustifyV("MIDDLE")
		HeaderFrameRIGHT.text:SetJustifyH("CENTER")
		HeaderFrameRIGHT.text:SetMaxLines(3)
		HeaderFrameRIGHT.text:SetText(E.func_TextCenter_Chars(CharInfo))
		-- Настройка взаимодействия
		HeaderFrameRIGHT:SetPropagateMouseClicks(true)
		HeaderFrameRIGHT:SetPropagateMouseMotion(true)
		HeaderFrameRIGHT:SetHitRectInsets(1, 1, 1, 1)
		-- Устанавливаем цвет фона в зависимости от фракции
		if CharInfo.PlayerData.Faction == "Horde" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.COLOR_HORDE)
		elseif CharInfo.PlayerData.Faction == "Alliance" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.COLOR_ALLIANCE)
		elseif CharInfo.PlayerData.Faction == "Neutral" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.COLOR_NEUTRAL)
		end
		-- -- Установка цвета фона в зависимости от фракции
		-- local charR, charG, charB = E.func_hex2rgbNUMBER(CharInfo.PlayerData.Faction == "Horde" and E.COLOR_HORDE or E.COLOR_ALLIANCE)
		HeaderFrameRIGHT.charTexture:SetVertexColor(charR, charG, charB, E.ALPHA_BACKGROUND)
		-- Обработчик наведения для отображения тултипа
		HeaderFrameRIGHT:SetScript("OnEnter", function(self)
			HeaderFrameRIGHT.tooltip = E.func_Tooltip_Chars(CharInfo)
			E.func_OctoTooltip_OnEnter(HeaderFrameRIGHT, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
		HeaderFrameRIGHT:Show()
	end
	-- Обновление позиций подфреймов в центральной колонке
	for _, frame in ipairs(Octo_MainFrame_TestFrame.ViewCenter:GetFrames()) do
		local accumulatedWidth = 0
		for i = 1, #columnWidthsRight do
			if frame.second[i] then
				frame.second[i]:ClearAllPoints()
				frame.second[i]:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
				frame.second[i]:SetWidth(columnWidthsRight[i])
				accumulatedWidth = accumulatedWidth + columnWidthsRight[i]
			end
		end
	end
	-- Ресет скроллбара
	-- C_Timer.After(0, function()
	-- EventFrame.horizontalScrollBar:SetScrollPercentage(0)
	-- Octo_MainFrame_TestFrame.ScrollBoxCenter:ScrollToElementDataIndex(1)
	-- end)
end
-- Функция переключения видимости главного фрейма
local function Toggle_Octo_MainFrame_TestFrame(frame)
	if Octo_MainFrame_TestFrame then
		Octo_MainFrame_TestFrame:SetShown(not Octo_MainFrame_TestFrame:IsShown())
	end
end
-- Открытие главного фрейма по /octo
function EventFrame:main_frame_toggle()
	if Octo_MainFrame_TestFrame then
		Octo_MainFrame_TestFrame:SetShown(not Octo_MainFrame_TestFrame:IsShown())
	end
end
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	EventFrame:Octo_Create_MainFrame()
	E.func_Create_DDframe_ToDo(Octo_MainFrame_TestFrame, E.COLOR_FACTION, function() EventFrame:CreateDataProvider() end)
	Octo_TestFrame_DB_Vars = Octo_TestFrame_DB_Vars or {}
	E.func_CreateMinimapButton(GlobalAddonName, "TestFrame", Octo_TestFrame_DB_Vars, Octo_MainFrame_TestFrame, nil, "Octo_MainFrame_TestFrame")
end
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_MainFrame_TestFrame:Hide()
end