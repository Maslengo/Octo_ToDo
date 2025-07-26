local GlobalAddonName, E = ...
local Octo_Event_TestFrame = CreateFrame("FRAME")
Octo_Event_TestFrame:Hide()
local Octo_Main_TestFrame = CreateFrame("BUTTON", "Octo_Main_TestFrame", UIParent, "BackdropTemplate")
Octo_Main_TestFrame:Hide()
-- Создаем хедер для левого фрейма
local HeaderFrameLEFT = CreateFrame("FRAME", nil, Octo_Main_TestFrame)
----------------------------------------------------------------
-- Настройки размеров интерфейса
----------------------------------------------------------------
local HEADER_HEIGHT = 40
local LINE_HEIGHT = 20 -- Высота одной строки AddonHeight
local LINE_WIDTH_LEFT = 200 -- Ширина левой панели AddonLeftFrameWeight
local LINE_WIDTH_CENT = 90 -- Ширина центральной панели AddonCentralFrameWeight
local LINES_MAX = 100 -- Количество строк по умолчанию MainFrameDefaultLines
local ICON_INDENT = LINE_HEIGHT
-- Автоматический расчет максимального количества строк
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / LINE_HEIGHT)*.7))
	-- if LINES_MAX > LINES_TOTAL then
	-- 	LINES_MAX = LINES_TOTAL
	-- end
local COLUMNS_MAX = 10 -- Максимальное количество отображаемых столбцов MaxNumCharacters
local TEST_WIDTH = 0
----------------------------------------------------------------
-- Константы цвета
----------------------------------------------------------------
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.bgCr, E.bgCg, E.bgCb, E.bgCa
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local classR, classG, classB, colorHEXwithoutC = GetClassColor(E.classFilename)
local LEFT_TEXTURE_ALPHA = 0.1
----------------------------------------------------------------
-- Локальные функции для оптимизации
----------------------------------------------------------------
local math_min = math.min
local math_max = math.max
----------------------------------------------------------------
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
	local frameFULL = CreateFrame("Button", "Octo_Main_TestFrame.frameFULL", Octo_Main_TestFrame)
	frameFULL:SetPropagateMouseClicks(true)
	frameFULL:SetPropagateMouseMotion(true)
	frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
	frameFULL:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- Текстура выделения
	frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
	frameFULL.HighlightTexture:SetAlpha(E.bgCaOverlay) -- Прозрачность выделения
	frameFULL:SetPoint("LEFT", frame)
	frameFULL:SetPoint("TOP", frame)
	frameFULL:SetPoint("BOTTOM", frame)
	frameFULL:SetPoint("RIGHT")
	frame.frameFULL = frameFULL
	-- Создаем иконку
	local icon = frame:CreateTexture(nil, "BACKGROUND")
	icon:SetSize(LINE_HEIGHT - 2, LINE_HEIGHT - 2)
	icon:SetPoint("TOPLEFT", 1, -1)
	icon:SetTexCoord(0.10, 0.90, 0.10, 0.90) -- Обрезаем края иконки
	frame.icon_1 = icon
	----------------------------------------------------------------
	-- Текст слева
	----------------------------------------------------------------
	frame.textLEFT = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.textLEFT:SetPoint("LEFT", ICON_INDENT, 0)
	frame.textLEFT:SetWidth(LINE_WIDTH_LEFT - ICON_INDENT)
	frame.textLEFT:SetFontObject(OctoFont11) -- Используем наш шрифт
	frame.textLEFT:SetWordWrap(false) -- Запрещаем перенос слов
	frame.textLEFT:SetJustifyV(JustifyV)
	frame.textLEFT:SetJustifyH(JustifyH)
	frame.textLEFT:SetTextColor(textR, textG, textB, textA)
	----------------------------------------------------------------
	-- Текстура для левой панели
	----------------------------------------------------------------
	frame.textureLEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
	frame.textureLEFT:Hide()
	frame.textureLEFT:SetAllPoints()
	frame.textureLEFT:SetTexture(E.TEXTURE_LEFT_PATH)
	----------------------------------------------------------------

	local frameData = data.parent.dataProvider.linearized
	frame:SetScript("OnHide", function()
		frame.frameFULL:Hide()
	end)
	frame:SetScript("OnShow", function()
		frame.frameFULL:Show()
	end)
end
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
						local f = CreateFrame("BUTTON", "frame.second"..key, frame)
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
						f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.bgCaOverlay)
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
-- Функция для установки текстуры кнопки
local function SetupButtonTexture(frame, texture, iconWidth)
	if not frame or not texture then return end
	if C_Texture.GetAtlasInfo(texture) then
		frame:SetAtlas(texture, true) -- Используем атлас если доступен
	else
		frame:SetTexture(texture) -- Иначе обычную текстуру
	end
	frame:SetPoint("TOPLEFT", 2, 1)
	frame:SetSize(iconWidth, iconWidth)
end
-- Функция обновления левой панели
function Octo_Event_TestFrame:Octo_Frame_initLEFT(frame, node)
	local frameData = node:GetData()

	-- fpde(frame.frameFULL)
	-- print (frame, frame:GetOrderIndex())
	-- frame:SetWidth(555)

	-- frame.frameFULL:SetPoint("TOPLEFT")
	if Octo_Event_TestFrame.COLUMN_SIZES_LEFT and Octo_Event_TestFrame.COLUMN_SIZES_LEFT[1] then
		local newLeftWidth = Octo_Event_TestFrame.COLUMN_SIZES_LEFT[1]
		Octo_Main_TestFrame.ScrollBoxLEFT:SetWidth(newLeftWidth)
		frame.textLEFT:SetWidth(newLeftWidth - ICON_INDENT)
		HeaderFrameLEFT:SetWidth(newLeftWidth)
		-- Octo_Main_TestFrame.ScrollBoxLEFT:GetScrollTarget():SetWidth(LEFTSIZE)
	end

	-- Устанавливаем текст и иконку
	frame.textLEFT:SetText(frameData.textLEFT)
	SetupButtonTexture(frame.icon_1, frameData.iconLEFT, LINE_HEIGHT-2)
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
function Octo_Event_TestFrame:Octo_Frame_initCENT(frame, node)
	local frameData = node:GetData()
	-- if not data then return end
	-- Обрабатываем случай с несколькими персонажами
	if frameData.totalColumns > 1 then
		local current = frame.second[frameData.currentCharacterIndex]
		if current then
			current:Show()
			current.curCharTextureBG:Show()
			current.textCENT:SetText("")
			current.ReputTextureAndBG:Hide()
		end
	end
	-- Обрабатываем данные для правой панели
	for i = 1, #frameData.textCENT do
		local secondFrame = frame.second[i]
		if frameData.textCENT[i] then
			local textCENT = frameData.textCENT[i]
			secondFrame.ReputTextureAndBG:Hide()
			-- Устанавливаем цвет если задан
			if frameData.colorCENT[i] then
				local r1, g1, b1 = E:func_hex2rgbNUMBER(frameData.colorCENT[i])
				secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_CENT)
				secondFrame.ReputTextureAndBG:Show()
				secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
			end
			secondFrame.textCENT:SetText(textCENT)
		else
			secondFrame.textCENT:SetText("")
			secondFrame.ReputTextureAndBG:SetVertexColor(0, 0, 0, 0)
		end
		secondFrame:Show()
		secondFrame.tooltip = frameData.tooltipRIGHT[i]
	end
end

-- Функция создания основного фрейма аддона
function Octo_Event_TestFrame:Octo_Create_MainFrame_TestFrame()
	-- Базовые настройки фрейма
	Octo_Main_TestFrame:SetPoint("CENTER")
	-- Обработчик показа фрейма
	Octo_Main_TestFrame:SetScript("OnShow", function()
			Octo_Event_TestFrame:CreateDataProvider()
			RequestRaidInfo() -- Запрашиваем информацию о рейде
	end)
	-- Рассчитываем размеры фрейма
	local NumPlayers = math_min(E:func_NumPlayers(), COLUMNS_MAX)
	Octo_Main_TestFrame:SetSize(LINE_WIDTH_LEFT + LINE_WIDTH_CENT * NumPlayers, LINE_HEIGHT * LINES_MAX)
	-- Настройки поведения фрейма
	Octo_Main_TestFrame:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_Main_TestFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	Octo_Main_TestFrame:SetFrameStrata("HIGH")
	-- Создаем скролл-фрейм
	local barPanelScroll = CreateFrame("ScrollFrame", "barPanelScroll", Octo_Main_TestFrame)
	Octo_Main_TestFrame.barPanelScroll = barPanelScroll
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
	local HorizontalScrollBar = CreateFrame("EventFrame", "HorizontalScrollBar", Octo_Main_TestFrame, "OctoWowTrimHorizontalScrollBar")
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
	Octo_Main_TestFrame.childCENT = childCENT
	barPanelScroll:SetScrollChild(childCENT)
	-- Настраиваем ScrollBox для левой панели
	Octo_Main_TestFrame.ScrollBoxLEFT = CreateFrame("FRAME", "ScrollBoxLEFT", Octo_Main_TestFrame, "WowScrollBoxList")
	Octo_Main_TestFrame.ScrollBoxLEFT:SetWidth(LINE_WIDTH_LEFT)
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_Main_TestFrame.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_Main_TestFrame.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	barPanelScroll:SetPoint("TOPLEFT", Octo_Main_TestFrame.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	barPanelScroll:SetPoint("BOTTOMRIGHT")
	Octo_Main_TestFrame.viewLEFT = CreateScrollBoxListTreeListView(0)
	Octo_Main_TestFrame.viewLEFT:SetElementExtent(LINE_HEIGHT)
	Octo_Main_TestFrame.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	Octo_Main_TestFrame.viewLEFT:RegisterCallback(Octo_Main_TestFrame.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, Octo_Main_TestFrame)
	-- Настраиваем ScrollBox для центральной панели
	Octo_Main_TestFrame.ScrollBoxCENT = CreateFrame("FRAME", "ScrollBoxCENT", childCENT, "WowScrollBoxList")
	Octo_Main_TestFrame.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_Main_TestFrame.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	Octo_Main_TestFrame.ScrollBoxCENT:SetPropagateMouseClicks(true)
	Octo_Main_TestFrame.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_Main_TestFrame.ScrollBarCENT = CreateFrame("EventFrame", "ScrollBarCENT", Octo_Main_TestFrame, "MinimalScrollBar")
	Octo_Main_TestFrame.ScrollBarCENT:SetPoint("TOPLEFT", Octo_Main_TestFrame, "TOPRIGHT", 6, 0)
	Octo_Main_TestFrame.ScrollBarCENT:SetPoint("BOTTOMLEFT", Octo_Main_TestFrame, "BOTTOMRIGHT", 6, 0)
	Octo_Main_TestFrame.viewCENT = CreateScrollBoxListTreeListView(0)
	Octo_Main_TestFrame.viewCENT:SetElementExtent(LINE_HEIGHT)
	Octo_Main_TestFrame.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_Main_TestFrame.viewCENT:RegisterCallback(Octo_Main_TestFrame.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_Main_TestFrame)
	-- Инициализируем скроллбоксы с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_Main_TestFrame.ScrollBoxLEFT, Octo_Main_TestFrame.ScrollBarCENT, Octo_Main_TestFrame.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_Main_TestFrame.ScrollBoxLEFT, Octo_Main_TestFrame.ScrollBarCENT)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_Main_TestFrame.ScrollBoxCENT, Octo_Main_TestFrame.ScrollBarCENT, Octo_Main_TestFrame.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_Main_TestFrame.ScrollBoxCENT, Octo_Main_TestFrame.ScrollBarCENT)
	-- Настраиваем внешний вид основного фрейма
	Octo_Main_TestFrame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	Octo_Main_TestFrame:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_Main_TestFrame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	Octo_Main_TestFrame:EnableMouse(true)
	Octo_Main_TestFrame:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_Main_TestFrame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_Main_TestFrame:SetAlpha(Octo_ToDo_DB_Vars.AlphaOnDrag or E.bgCa)
				Octo_Main_TestFrame:StartMoving()
			end
	end)
	Octo_Main_TestFrame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_Main_TestFrame:SetAlpha(1)
				Octo_Main_TestFrame:StopMovingOrSizing()
			end
	end)
	Octo_Main_TestFrame:RegisterForClicks("RightButtonUp")
	Octo_Main_TestFrame:SetScript("OnClick", Octo_Main_TestFrame.Hide)

	HeaderFrameLEFT:SetPoint("TOPLEFT")
	HeaderFrameLEFT:SetSize(LINE_WIDTH_LEFT, HEADER_HEIGHT)
	HeaderFrameLEFT.text = HeaderFrameLEFT:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	HeaderFrameLEFT.text:SetPoint("CENTER")
	HeaderFrameLEFT.text:SetFontObject(OctoFont11) -- Используем наш шрифт
	HeaderFrameLEFT.text:SetWordWrap(false) -- Запрещаем перенос слов
	HeaderFrameLEFT.text:SetJustifyV("MIDDLE")
	HeaderFrameLEFT.text:SetJustifyH("LEFT")
	HeaderFrameLEFT.text:SetTextColor(textR, textG, textB, textA)
	HeaderFrameLEFT:SetScript("OnShow", function()
		HeaderFrameLEFT.text:SetText(E:func_texturefromIcon(E.Icon_Faction).."Weekly Reset: "..E.Faction_Color..E:func_SecondsToClock(E:func_GetWeeklyReset()).."|r")
	end)
	-- Создаем пул фреймов для персонажей
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	local function InitializePoolFrame(self)
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
	Octo_Main_TestFrame.pool = CreateFramePool("FRAME", childCENT, nil, ResetPoolFrame, false, InitializePoolFrame)
end



local function calculateColumnWidthsLEFT(node, totalLines)
	local frameData = node:GetData()
	local framesLEFT = Octo_Main_TestFrame.viewLEFT:GetFrames()
	local framesCENT = Octo_Main_TestFrame.viewCENT:GetFrames()



	if #framesLEFT == 0 then
		Octo_Main_TestFrame.viewLEFT:AcquireInternal(1, node)
		Octo_Main_TestFrame.viewLEFT:InvokeInitializers()
	end

	if #framesCENT == 0 then
		Octo_Main_TestFrame.viewCENT:AcquireInternal(1, node)
		Octo_Main_TestFrame.viewCENT:InvokeInitializers()
	end
	local columnWidthsLEFT = {}
	local sampleFrameLEFT = framesLEFT[1]

	sampleFrameLEFT.textLEFT:SetText(frameData.textLEFT)
	columnWidthsLEFT[1] = sampleFrameLEFT.textLEFT:GetStringWidth() + ICON_INDENT + TEST_WIDTH


	return columnWidthsLEFT
end


local function calculateColumnWidthsRIGHT(node, totalLines)
	-- local frameData = node:GetData()
	-- local framesCENT = Octo_Main_TestFrame.viewCENT:GetFrames()
	-- if #framesCENT == 0 then
	-- 	Octo_Main_TestFrame.viewCENT:AcquireInternal(1, node)
	-- 	Octo_Main_TestFrame.viewCENT:InvokeInitializers()
	-- end
	-- local columnWidthsRIGHT = {}
	-- local sampleFrameRIGHT = framesRIGHT[1]

	-- sampleFrameRIGHT.textRIGHT:SetText(frameData.textRIGHT)
	-- columnWidthsRIGHT[1] = sampleFrameRIGHT.textRIGHT:GetStringWidth()

	-- return columnWidthsRIGHT
end

function Octo_Event_TestFrame:CreateDataProvider()
	local NumPlayers = math_min(E:func_NumPlayers(), COLUMNS_MAX)
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local COLUMN_SIZES_LEFT = {}
	local COLUMN_SIZES_RIGHT = {}
	-- Находим индекс текущего персонажа
	local tbl = E:func_sorted()
	local currentCharacterIndex
	for CharIndex, CharInfo in ipairs(tbl) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end
	local totalColumns = #tbl

	-- Режим без репутаций
	for index, func in ipairs(E:func_Concat_Otrisovka()) do
		totalLines = totalLines + 1
		local zxc = {
			textLEFT = {},
			iconLEFT = {},
			colorLEFT = {},
			textCENT = {},
			tooltipRIGHT = {},
			colorCENT = {},
			myType = {},
		}
		-- Обрабатываем всех персонажей для центральных данных
		for CharIndex, CharInfo in ipairs(tbl) do
			local _, _, _, textCENT, tooltipRIGHT, colorCENT = func(CharInfo)
			zxc.textCENT[CharIndex] = textCENT
			zxc.tooltipRIGHT[CharIndex] = tooltipRIGHT or {}
			zxc.colorCENT[CharIndex] = colorCENT
		end
		-- Получаем данные для левой панели от первого персонажа
		local firstChar = tbl[1]
		if firstChar then
			local textLEFT, iconLEFT, colorLEFT, _, _, _, myType = func(firstChar)
			zxc.textLEFT = textLEFT
			zxc.iconLEFT = iconLEFT or E.Icon_Empty
			zxc.colorLEFT = colorLEFT
			zxc.myType = myType or {}
		end
		zxc.currentCharacterIndex = currentCharacterIndex
		zxc.totalColumns = totalColumns
		local node = DataProvider:Insert(zxc)
			for j, w in ipairs(calculateColumnWidthsLEFT(node, totalLines)) do
				COLUMN_SIZES_LEFT[j] = math_max(w, COLUMN_SIZES_LEFT[j] or HeaderFrameLEFT.text:GetWidth() or 0)
			end
	end
	Octo_Event_TestFrame.COLUMN_SIZES_LEFT = COLUMN_SIZES_LEFT
	Octo_Event_TestFrame.COLUMN_SIZES_RIGHT = COLUMN_SIZES_RIGHT
	-- print ("totalColumns:", totalColumns, "totalLines:", totalLines)
	-- Корректируем количество строк
	LINES_MAX = math_max(1, math_min(totalLines, LINES_TOTAL or totalLines))
	if Octo_Main_TestFrame then
		-- Устанавливаем провайдер данных (это запустит создание фреймов)
		Octo_Main_TestFrame.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_Main_TestFrame.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		-- Обновляем размеры фрейма
		local width = (COLUMN_SIZES_LEFT[1] or LINE_WIDTH_LEFT) + LINE_WIDTH_CENT * NumPlayers
		local height = LINE_HEIGHT * LINES_MAX + HEADER_HEIGHT
		Octo_Main_TestFrame:SetSize(width, height)
		Octo_Main_TestFrame.childCENT:SetSize(LINE_WIDTH_CENT * E:func_NumPlayers(), height)
		-- Обновляем фреймы персонажей
		Octo_Main_TestFrame.pool:ReleaseAll()
		for count, CharInfo in ipairs(tbl) do
			local HeaderFrameRIGHT = Octo_Main_TestFrame.pool:Acquire()
			HeaderFrameRIGHT:SetPoint("BOTTOMLEFT", Octo_Main_TestFrame.childCENT, "TOPLEFT", LINE_WIDTH_CENT * (count - 1), -HEADER_HEIGHT)
			HeaderFrameRIGHT.text:SetAllPoints()
			HeaderFrameRIGHT.text:SetFontObject(OctoFont11)
			HeaderFrameRIGHT.text:SetWordWrap(true)
			HeaderFrameRIGHT.text:SetJustifyV("MIDDLE")
			HeaderFrameRIGHT.text:SetJustifyH("CENTER")
			HeaderFrameRIGHT.text:SetMaxLines(3)
			HeaderFrameRIGHT.text:SetText(E:func_textCENT_Chars(CharInfo))
			HeaderFrameRIGHT:SetPropagateMouseClicks(true)
			HeaderFrameRIGHT:SetPropagateMouseMotion(true)
			HeaderFrameRIGHT:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
			-- Устанавливаем цвет фона в зависимости от фракции
			local charR, charG, charB = E:func_hex2rgbNUMBER(CharInfo.PlayerData.Faction == "Horde" and E.Horde_Color or E.Alliance_Color)
			HeaderFrameRIGHT.charTexture:SetVertexColor(charR, charG, charB, E.bgCaOverlay)
			-- Обработчики событий для фрейма персонажа
			HeaderFrameRIGHT:SetScript("OnEnter", function(self)
					HeaderFrameRIGHT.tooltip = E:func_Tooltip_Chars(CharInfo)
					-- E:func_OctoTooltip_OnEnter(HeaderFrameRIGHT, {"BOTTOM", "TOP"})
					E:func_OctoTooltip_OnEnter(HeaderFrameRIGHT, {"BOTTOMLEFT", "TOPRIGHT"})
			end)
			HeaderFrameRIGHT:Show()
		end
	end
end
----------------------------------------------------------------
local function Toggle_Octo_Main_TestFrame()
	if Octo_Main_TestFrame then
		if not Octo_Main_TestFrame.insertIn_SecuredFrames_SequredFrames then
			Octo_Main_TestFrame.insertIn_SecuredFrames_SequredFrames = true
			tinsert(UISpecialFrames, "Octo_Main_TestFrame")
			tinsert(E.OctoTable_Frames, Octo_Main_TestFrame)
		end
		for index, frames in ipairs(E.OctoTable_Frames) do
			if Octo_Main_TestFrame ~= frames and frames:IsShown() then
				frames:Hide()
			end
		end
		Octo_Main_TestFrame:SetShown(not Octo_Main_TestFrame:IsShown())
	end
end
function Octo_Event_TestFrame:CreateTestButton1()
	local TestButton1 = CreateFrame("Button", "TestButton1", UIParent, "UIPanelButtonTemplate")
	TestButton1:SetClampedToScreen(true)
	TestButton1:SetPoint("TOPLEFT", 128, -256)
	TestButton1:SetSize(128, 32)
	TestButton1:SetText("Toggle_Octo_Main_TestFrame")
	TestButton1:EnableMouse(true)
	TestButton1:SetMovable(true)
	-- Обработчики перемещения фрейма
	TestButton1:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				TestButton1:SetAlpha(Octo_ToDo_DB_Vars.AlphaOnDrag or E.bgCa)
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
	TestButton1:SetScript("OnClick", Toggle_Octo_Main_TestFrame)
	-- Octo_Event_TestFrame:func_SmartAnchorTo(TestButton1)
end
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E:func_RegisterMyEventsToFrames(Octo_Event_TestFrame, MyEventsTable)
-- Обработчик события загрузки аддона
function Octo_Event_TestFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	Octo_Event_TestFrame:Octo_Create_MainFrame_TestFrame()
	self:CreateTestButton1()
end



function Octo_Event_TestFrame:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	E:func_Create_DD_ToDo(Octo_Main_TestFrame, E.Faction_Color, function() Octo_Event_TestFrame:CreateDataProvider() end)

end