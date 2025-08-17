-- local GlobalAddonName, ns = ...
-- E = _G.OctoEngine
local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
-- Создание главного фрейма для тестового интерфейса
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E.func_InitFrame(Octo_MainFrame_ToDo)
-- Создание фрейма для заголовка левой колонки
local HeaderFrameLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo)
-- Константы для настройки интерфейса
local INDENT_LEFT = 10
local INDENT_TEST = 4                      		-- Отступ для текста
local LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT		-- Высота одной строки
local HEADER_HEIGHT = LINE_HEIGHT*2        		-- Высота заголовка
local MIN_LINE_WIDTH_LEFT = 200            		-- Минимальная ширина левой колонки
local MIN_LINE_WIDTH_CENT = 90             		-- Минимальная ширина центральной колонки
local LINES_MAX = E.LINES_MAX                   -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.MonitorWidth*.8  		-- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.MonitorHeight*.6 	-- Максимальная высота фрейма (60% экрана)
EventFrame.COLUMNS_MAX = 113     		-- Максимальное количество колонок
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
local func_OnAcquiredLEFT do
	local function func_OnEnter(frame)
		local frameData = frame:GetData()
		-- Получение данных для тултипа
		local typeQ, ID, iANIMA, kCovenant = frameData.myType[1], frameData.myType[2], frameData.myType[3], frameData.myType[4]
		local tooltipOCTO = {}
		if type(ID) == "table" then
			-- Обработка нескольких ID
			for _, tblID in ipairs(ID) do
				E.func_TableConcat(tooltipOCTO, E.func_tooltipCurrencyAllPlayers(typeQ, tblID, iANIMA, kCovenant))
			end
		else
			-- Обработка одиночного ID
			tooltipOCTO = E.func_tooltipCurrencyAllPlayers(typeQ, ID, iANIMA, kCovenant)
		end
		frame.tooltip = tooltipOCTO
		E.func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end
	-- Функция инициализации элементов левой колонки
	function func_OnAcquiredLEFT(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		local JustifyV = "MIDDLE"  -- Вертикальное выравнивание
		local JustifyH = "LEFT"     -- Горизонтальное выравнивание
		-- Настройки фрейма
		frame:SetPropagateMouseClicks(true)
		frame:SetPropagateMouseMotion(true)
		frame:SetHitRectInsets(1, 1, 1, 1)
		-- Создание полноразмерного фрейма для подсветки
		local frameFULL = CreateFrame("BUTTON", nil, owner)
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
		frame.textLEFT = frame:CreateFontString()
		frame.textLEFT:SetFontObject(OctoFont11)
		frame.textLEFT:SetPoint("LEFT", INDENT_TEST+0, 0)
		frame.textLEFT:SetWidth(INDENT_TEST+MIN_LINE_WIDTH_LEFT)
		frame.textLEFT:SetWordWrap(false)
		frame.textLEFT:SetJustifyV(JustifyV)
		frame.textLEFT:SetJustifyH(JustifyH)
		frame.textLEFT:SetTextColor(textR, textG, textB, textA)
		-- Текстура для фона левой колонки
		frame.textureLEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -3) -- слой для фоновых текстур
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
					f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.backgroundColorAOverlay)
					f.curCharTextureBG:Hide()
					-- Текстура для фона репутации
					f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
					f.ReputTextureAndBG:SetPoint("LEFT")
					f.ReputTextureAndBG:SetHeight(LINE_HEIGHT)
					f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
					-- Текстовое поле для центральной колонки
					f.textCENT = f:CreateFontString()
					f.textCENT:SetFontObject(OctoFont11)
					f.textCENT:SetAllPoints()
					f.textCENT:SetWordWrap(false)
					f.textCENT:SetJustifyV("MIDDLE")
					f.textCENT:SetJustifyH("CENTER")
					f.textCENT:SetTextColor(textR, textG, textB, textA)
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
function EventFrame:Octo_Frame_initLEFT(frame, node)
	local frameData = node:GetData()
	-- Обновление размеров колонки, если они были изменены
	if EventFrame.COLUMN_SIZES_LEFT and EventFrame.COLUMN_SIZES_LEFT[1] then
		local newLeftWidth = EventFrame.COLUMN_SIZES_LEFT[1]
		Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEST)
		frame.textLEFT:SetWidth(newLeftWidth)
		HeaderFrameLEFT:SetWidth(newLeftWidth)
	end
	-- Установка текста и цвета для левой колонки
	frame.textLEFT:SetText(frameData.textLEFT)
	if frameData.colorLEFT then
		local r, g, b = E.func_hex2rgbNUMBER(frameData.colorLEFT)
		frame.textureLEFT:SetVertexColor(r, g, b, 0) -- LEFT_TEXTURE_ALPHA
		frame.textureLEFT:Show()
	else
		frame.textureLEFT:Hide()
	end
end
-- Функция инициализации данных для центральной колонки
function EventFrame:Octo_Frame_initCENT(frame, node)
	local frameData = node:GetData()
	local accumulatedWidth = 0
	local columnSizesRight = EventFrame.COLUMN_SIZES_RIGHT or {}
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
				local r1, g1, b1 = E.func_hex2rgbNUMBER(frameData.colorCENT[i])
				secondFrame.ReputTextureAndBG:SetWidth(columnWidth)
				secondFrame.ReputTextureAndBG:Show()
				secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
			end
			secondFrame.textCENT:SetText(textCENT)
			-- Подсветка колонки текущего персонажа если больше 1 персонажа
			if frameData.totalColumns > 1 and i == frameData.currentCharacterIndex then
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
		-- if frameData.tooltipCENT and frameData.tooltipCENT[i] then
		-- 	secondFrame.tooltip = frameData.tooltipCENT[i]
		-- else
		-- 	secondFrame.tooltip = nil
		-- end
		secondFrame:SetScript("OnEnter", function()
			if frameData.tooltipKey and frameData.GUID[i] then
				secondFrame.tooltip = E.func_KeyTooltip(frameData.GUID[i], frameData.tooltipKey)
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
	-- Octo_MainFrame_ToDo:SetPoint("TOP", 0, -E.MonitorWidth*.05)
	Octo_MainFrame_ToDo:SetPoint("CENTER")
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
		RequestRaidInfo()
		E.func_Collect_All()
		EventFrame:CreateDataProvider()
	end)
	-- Расчет размеров фрейма на основе количества игроков
	local NumPlayers = math_min(E.func_NumPlayers(), EventFrame.COLUMNS_MAX)
	Octo_MainFrame_ToDo:SetSize(MIN_LINE_WIDTH_LEFT + MIN_LINE_WIDTH_CENT * NumPlayers, LINE_HEIGHT * LINES_MAX)
	-- Настройки фрейма
	Octo_MainFrame_ToDo:SetDontSavePosition(true)
	Octo_MainFrame_ToDo:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	-- Создание скроллфрейма для горизонтальной прокрутки
	local barPanelScroll = CreateFrame("ScrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.barPanelScroll = barPanelScroll
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
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimHorizontalScrollBar")
	EventFrame.HorizontalScrollBar = HorizontalScrollBar
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
	local childCENT = CreateFrame("FRAME", "childCENT")
	Octo_MainFrame_ToDo.childCENT = childCENT
	barPanelScroll:SetScrollChild(childCENT)
	-- Создание ScrollBox для левой колонки
	Octo_MainFrame_ToDo.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(INDENT_TEST+MIN_LINE_WIDTH_LEFT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Настройка позиции панели прокрутки
	barPanelScroll:SetPoint("TOPLEFT", Octo_MainFrame_ToDo.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	barPanelScroll:SetPoint("BOTTOMRIGHT")
	-- Создание и настройка представления для левой колонки
	Octo_MainFrame_ToDo.viewLEFT = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.viewLEFT:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	Octo_MainFrame_ToDo.viewLEFT:RegisterCallback(Octo_MainFrame_ToDo.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, Octo_MainFrame_ToDo)
	-- Создание ScrollBox для центральной колонки
	Octo_MainFrame_ToDo.ScrollBoxCENT = CreateFrame("FRAME", nil, childCENT, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBoxCENT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Создание и настройка вертикальной полосы прокрутки
	Octo_MainFrame_ToDo.ScrollBarCENT = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBarCENT:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBarCENT:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	-- Создание и настройка представления для центральной колонки
	Octo_MainFrame_ToDo.viewCENT = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.viewCENT:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_MainFrame_ToDo.viewCENT:RegisterCallback(Octo_MainFrame_ToDo.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_MainFrame_ToDo)
	-- Инициализация ScrollBox с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCENT, Octo_MainFrame_ToDo.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCENT)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxCENT, Octo_MainFrame_ToDo.ScrollBarCENT, Octo_MainFrame_ToDo.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxCENT, Octo_MainFrame_ToDo.ScrollBarCENT)
	-- Настройка фона и границы главного фрейма
	Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_ToDo:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка взаимодействия с фреймом
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			Octo_MainFrame_ToDo:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnDrag or E.backgroundColorA)
			Octo_MainFrame_ToDo:StartMoving()
		end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			Octo_MainFrame_ToDo:SetAlpha(1)
			Octo_MainFrame_ToDo:StopMovingOrSizing()
			-- local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_ToDo:GetPoint()
			-- print (point, relativePoint, xOfs, yOfs)
		end
	end)
	-- Обработчик клика правой кнопкой для скрытия фрейма
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", Octo_MainFrame_ToDo.Hide)
	-- Настройка заголовка левой колонки
	HeaderFrameLEFT:SetPoint("TOPLEFT")
	HeaderFrameLEFT:SetSize(MIN_LINE_WIDTH_LEFT, HEADER_HEIGHT)
	HeaderFrameLEFT.text = HeaderFrameLEFT:CreateFontString()
	HeaderFrameLEFT.text:SetFontObject(OctoFont11)
	HeaderFrameLEFT.text:SetPoint("LEFT", INDENT_TEST, 0)
	HeaderFrameLEFT.text:SetWordWrap(false)
	HeaderFrameLEFT.text:SetJustifyV("MIDDLE")
	HeaderFrameLEFT.text:SetJustifyH("LEFT")
	HeaderFrameLEFT.text:SetTextColor(textR, textG, textB, textA)
	-- Обработчик показа заголовка левой колонки
	HeaderFrameLEFT:SetScript("OnShow", function()
		-- HeaderFrameLEFT.text:SetText(E.func_texturefromIcon(E.Icon_Faction).."Weekly Reset: "..E.Faction_Color..E.func_SecondsToClock(E.func_GetWeeklyReset()).."|r")
		HeaderFrameLEFT.text:SetText(E.Purple_Color.."Weekly Reset:|r "..E.Faction_Color..E.func_SecondsToClock(E.func_GetWeeklyReset(), true).."|r  ")
	end)
	-- Функция сброса пула фреймов
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	-- Функция инициализации фреймов в пуле
	local function InitializePoolFrame(self)
		self:SetSize(MIN_LINE_WIDTH_CENT, HEADER_HEIGHT)
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
	Octo_MainFrame_ToDo.pool = CreateFramePool("FRAME", childCENT, nil, ResetPoolFrame, false, InitializePoolFrame)
end
-- Функция расчета ширины колонок для левой части
local function calculateColumnWidthsLEFT(node, totalLines)
	local frameData = node:GetData()
	local framesLEFT = Octo_MainFrame_ToDo.viewLEFT:GetFrames()
	local framesCENT = Octo_MainFrame_ToDo.viewCENT:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesLEFT == 0 then
		Octo_MainFrame_ToDo.viewLEFT:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.viewLEFT:InvokeInitializers()
	end
	if #framesCENT == 0 then
		Octo_MainFrame_ToDo.viewCENT:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.viewCENT:InvokeInitializers()
	end
	-- Расчет ширины на основе текста
	local columnWidthsLEFT = {}
	local columnHeightsLEFT = {}
	local sampleFrameLEFT = framesLEFT[1]
	sampleFrameLEFT.textLEFT:SetText(frameData.textLEFT)
	columnWidthsLEFT[1] = math.ceil(sampleFrameLEFT.textLEFT:GetStringWidth()) + INDENT_LEFT
	-- print (sampleFrameLEFT.textLEFT:GetStringHeight())
	return columnWidthsLEFT
end
-- Функция расчета ширины колонок для правой части
local function calculateColumnWidthsRIGHT(node, totalLines)
	local frameData = node:GetData()
	local framesCENT = Octo_MainFrame_ToDo.viewCENT:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesCENT == 0 then
		Octo_MainFrame_ToDo.viewCENT:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.viewCENT:InvokeInitializers()
		framesCENT = Octo_MainFrame_ToDo.viewCENT:GetFrames()
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
	-- EventFrame.COLUMN_SIZES_LEFT = EventFrame.COLUMN_SIZES_LEFT or {}
	-- EventFrame.COLUMN_SIZES_RIGHT = EventFrame.COLUMN_SIZES_RIGHT or {}
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local COLUMN_SIZES_LEFT = {}
	local COLUMN_SIZES_RIGHT = {}
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
			textLEFT = {},
			colorLEFT = {},
			textCENT = {},
			-- tooltipCENT = {},
			colorCENT = {},
			myType = {},
			tooltipKey = {},
			GUID = {},
			-- CharInfo = {},
		}
		-- Заполнение данных для каждого персонажа
		for CharIndex, CharInfo in ipairs(tbl) do
			local _, _, textCENT, _, colorCENT = func(CharInfo)
			zxc.textCENT[CharIndex] = textCENT
			-- zxc.tooltipCENT[CharIndex] = tooltipCENT or {}
			zxc.colorCENT[CharIndex] = colorCENT
			zxc.GUID[CharIndex] = CharInfo.PlayerData.GUID
			-- zxc.CharInfo[CharIndex] = CharInfo
		end
		-- Заполнение данных для левой колонки (берется из первого персонажа)
		local firstChar = tbl[1]
		if firstChar then
			local textLEFT, colorLEFT, _, _, _, myType, tooltipKey = func(firstChar)
			zxc.textLEFT = textLEFT
			zxc.colorLEFT = colorLEFT
			zxc.myType = myType or {}
			zxc.tooltipKey = tooltipKey
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
	EventFrame.COLUMN_SIZES_LEFT = COLUMN_SIZES_LEFT
	EventFrame.COLUMN_SIZES_RIGHT = COLUMN_SIZES_RIGHT
	-- Обновление интерфейса, если фрейм существует
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.childCENT then return end
	Octo_MainFrame_ToDo.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	Octo_MainFrame_ToDo.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	-- Расчет общей ширины правой части
	local totalRightWidth = 0
	local maxRIGHT = MIN_LINE_WIDTH_LEFT
	if COLUMN_SIZES_LEFT and COLUMN_SIZES_LEFT[1] then
		maxRIGHT = MAX_FRAME_WIDTH - COLUMN_SIZES_LEFT[1]+INDENT_TEST
	end
	for i = 1, math_min(#COLUMN_SIZES_RIGHT, EventFrame.COLUMNS_MAX) do
		if (totalRightWidth + COLUMN_SIZES_RIGHT[i]) <= maxRIGHT then
			totalRightWidth = totalRightWidth + COLUMN_SIZES_RIGHT[i]
		else
			break
		end
	end
	local totalRightWidth_childCENT = 0
	for i = 1, math_min(#COLUMN_SIZES_RIGHT, EventFrame.COLUMNS_MAX) do
		totalRightWidth_childCENT = totalRightWidth_childCENT + COLUMN_SIZES_RIGHT[i]
	end
	-- Расчет количества строк
	local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / LINE_HEIGHT)
	LINES_MAX = math_max(1, math_min(totalLines, LINES_TOTAL or totalLines))
	-- Установка размеров фрейма
	local width = MIN_LINE_WIDTH_LEFT
	if COLUMN_SIZES_LEFT and COLUMN_SIZES_LEFT[1] then
		width = (COLUMN_SIZES_LEFT[1]+INDENT_TEST or MIN_LINE_WIDTH_LEFT) + totalRightWidth
	end
	if width%2 == 1 then
		width = width + 1
	end
	local height = LINE_HEIGHT * LINES_MAX + HEADER_HEIGHT
	Octo_MainFrame_ToDo:SetSize(width, height)
	-- print (E.Blue_Color.."left|r", COLUMN_SIZES_LEFT[1]+INDENT_TEST)
	-- print (E.Red_Color.."rightChild|r", totalRightWidth_childCENT)
	-- print (E.Gray_Color.."rightChild|r", totalRightWidth)
	-- print (E.Purple_Color.."MainFrame|r", width)
	Octo_MainFrame_ToDo.childCENT:SetSize(totalRightWidth_childCENT, height)
	-- Освобождение всех фреймов из пула
	Octo_MainFrame_ToDo.pool:ReleaseAll()
	-- Создание заголовков для колонок персонажей
	local accumulatedWidth = 0
	for count, CharInfo in ipairs(tbl) do
		local HeaderFrameRIGHT = Octo_MainFrame_ToDo.pool:Acquire()
		local columnWidth = COLUMN_SIZES_RIGHT[count] or MIN_LINE_WIDTH_CENT
		-- Установка позиции и размера заголовка
		HeaderFrameRIGHT:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.childCENT, "TOPLEFT", accumulatedWidth, -HEADER_HEIGHT)
		HeaderFrameRIGHT:SetSize(columnWidth, HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Настройка текста заголовка
		HeaderFrameRIGHT.text:SetAllPoints()
		HeaderFrameRIGHT.text:SetFontObject(OctoFont11)
		HeaderFrameRIGHT.text:SetWordWrap(true)
		HeaderFrameRIGHT.text:SetJustifyV("MIDDLE")
		HeaderFrameRIGHT.text:SetJustifyH("CENTER")
		HeaderFrameRIGHT.text:SetMaxLines(3)
		HeaderFrameRIGHT.text:SetText(E.func_textCENT_Chars(CharInfo))
		-- Настройка взаимодействия
		HeaderFrameRIGHT:SetPropagateMouseClicks(true)
		HeaderFrameRIGHT:SetPropagateMouseMotion(true)
		HeaderFrameRIGHT:SetHitRectInsets(1, 1, 1, 1)
		-- Устанавливаем цвет фона в зависимости от фракции
		if CharInfo.PlayerData.Faction == "Horde" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.Horde_Color)
		elseif CharInfo.PlayerData.Faction == "Alliance" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.Alliance_Color)
		elseif CharInfo.PlayerData.Faction == "Neutral" then
			charR, charG, charB = E.func_hex2rgbNUMBER(E.Neutral_Color)
		end
		-- -- Установка цвета фона в зависимости от фракции
		-- local charR, charG, charB = E.func_hex2rgbNUMBER(CharInfo.PlayerData.Faction == "Horde" and E.Horde_Color or E.Alliance_Color)
		HeaderFrameRIGHT.charTexture:SetVertexColor(charR, charG, charB, E.backgroundColorAOverlay)
		-- Обработчик наведения для отображения тултипа
		HeaderFrameRIGHT:SetScript("OnEnter", function(self)
			HeaderFrameRIGHT.tooltip = E.func_Tooltip_Chars(CharInfo)
			E.func_OctoTooltip_OnEnter(HeaderFrameRIGHT, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
		HeaderFrameRIGHT:Show()
	end
	-- Обновление позиций подфреймов в центральной колонке
	for _, frame in ipairs(Octo_MainFrame_ToDo.viewCENT:GetFrames()) do
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
	-- Ресет скроллбара
	-- C_Timer.After(0, function()
	-- 	EventFrame.HorizontalScrollBar:SetScrollPercentage(0)
	-- 	Octo_MainFrame_ToDo.ScrollBoxCENT:ScrollToElementDataIndex(1)
	-- end)
end
-- Функция переключения видимости главного фрейма
local function Toggle_Octo_MainFrame_TestFrame(frame)
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
	end
end
-- Открытие главного фрейма по /octo
function EventFrame:main_frame_toggle()
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
	end
end
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	EventFrame:Octo_Create_MainFrame()
	E.func_Create_DDframe_ToDo(Octo_MainFrame_ToDo, E.Faction_Color, function() EventFrame:CreateDataProvider() end)
	E.func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, nil, "Octo_MainFrame_ToDo")
end
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_MainFrame_ToDo:Hide()
end