local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME") -- Фрейм для обработки событий
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E:func_InitFrame(Octo_MainFrame_ToDo)
----------------------------------------------------------------
-- Настройки размеров интерфейса
----------------------------------------------------------------
local LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT
local HEADER_HEIGHT = LINE_HEIGHT*2
local LINE_WIDTH_LEFT = E.GLOBAL_LINE_WIDTH_LEFT -- Ширина левой панели
local LINE_WIDTH_RIGHT = E.GLOBAL_LINE_WIDTH_RIGHT
local MAX_DISPLAY_LINES = E.MAX_DISPLAY_LINES
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
-- Локальные функции для оптимизации
----------------------------------------------------------------
local math_min = math.min
local math_max = math.max
----------------------------------------------------------------
-- Функции обработки событий для элементов интерфейса
----------------------------------------------------------------
-- Обработчики скрытия/показа для полного фрейма
local function func_OnHideLEFT(frame)
	frame.Highlight:Hide()
end
local function func_OnShowLEFT(frame)
	frame.Highlight:Show()
end
-- Функция инициализации левой панели
local func_OnAcquiredLeft = function(owner, frame, data, new)
	if not new then return end
	local JustifyV = "MIDDLE" -- Вертикальное выравнивание
	local JustifyH = "LEFT" -- Горизонтальное выравнивание
	-- Настройки фрейма
	frame:SetPropagateMouseClicks(true) -- Разрешаем передачу кликов
	frame:SetPropagateMouseMotion(true) -- Разрешаем передачу движения мыши
	frame:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
	-- Создаем фоновую текстуру для всего элемента
	local Highlight = CreateFrame("Button", nil, Octo_MainFrame_ToDo)
	Highlight:SetPropagateMouseClicks(true)
	Highlight:SetPropagateMouseMotion(true)
	Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
	Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- Текстура выделения
	Highlight.HighlightTexture = Highlight:GetHighlightTexture()
	Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND) -- Прозрачность выделения
	Highlight:SetPoint("LEFT", frame)
	Highlight:SetPoint("TOP", frame)
	Highlight:SetPoint("BOTTOM", frame)
	Highlight:SetPoint("RIGHT")
	frame.Highlight = Highlight
	-- Текст слева
	local TextLeft = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TextLeft:SetPoint("LEFT", 0, 0)
	TextLeft:SetWidth(LINE_WIDTH_LEFT - 2)
	TextLeft:SetFontObject(OctoFont11) -- Используем наш шрифт
	TextLeft:SetWordWrap(false) -- Запрещаем перенос слов
	TextLeft:SetJustifyV(JustifyV)
	TextLeft:SetJustifyH(JustifyH)
	TextLeft:SetTextColor(textR, textG, textB, textA) -- Белый цвет текста
	frame.TextLeft = TextLeft
	-- Текстура для левой панели
	local TextureLeft = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
	TextureLeft:Hide()
	TextureLeft:SetAllPoints()
	TextureLeft:SetTexture(E.TEXTURE_LEFT_PATH)
	frame.TextureLeft = TextureLeft
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
						f:SetSize(LINE_WIDTH_RIGHT, LINE_HEIGHT)
						f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
						f:SetPoint("TOPLEFT", frame, "TOPLEFT", LINE_WIDTH_RIGHT*(key-1), 0)
						f:RegisterForClicks("LeftButtonUp")
						-- Текстура для текущего персонажа
						f.curCharTextureBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.curCharTextureBG:SetAllPoints()
						f.curCharTextureBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
						f.curCharTextureBG:SetVertexColor(classR, classG, classB, E.ALPHA_BACKGROUND)
						f.curCharTextureBG:Hide()
						-- Текстура репутации
						f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.ReputTextureAndBG:SetPoint("LEFT")
						f.ReputTextureAndBG:SetHeight(LINE_HEIGHT)
						f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
						-- Текст в центре
						f.TextCenter = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
						f.TextCenter:SetAllPoints()
						f.TextCenter:SetFontObject(OctoFont11)
						f.TextCenter:SetWordWrap(false)
						f.TextCenter:SetJustifyV("MIDDLE")
						f.TextCenter:SetJustifyH("CENTER")
						f.TextCenter:SetTextColor(textR, textG, textB, textA)
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
function EventFrame:func_initLEFT(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	local frameData = data.zxc
	-- Устанавливаем текст и иконку
	frame.TextLeft:SetText(frameData.TextLeft)
	-- Устанавливаем цвет фона если задан
	if frameData.ColorLeft then
		local r, g, b = E:func_hex2rgbNUMBER(frameData.ColorLeft)
		frame.TextureLeft:SetVertexColor(r, g, b, LEFT_TEXTURE_ALPHA)
		frame.TextureLeft:Show()
	else
		frame.TextureLeft:Hide()
	end
	-- Получаем тип данных
	local typeQ, ID, iANIMA, kCovenant = frameData.myType[1], frameData.myType[2], frameData.myType[3], frameData.myType[4]
	-- Настраиваем подсказку в зависимости от типа данных
	frame:SetScript("OnEnter", function()
			local tooltipOCTO = {}
			-- Обрабатываем таблицу ID или одиночный ID
			if type(ID) == "table" then
				for _, tblID in ipairs(ID) do
					E:func_TableConcat(tooltipOCTO, E:func_KeyTooltip_LEFT(typeQ, tblID, iANIMA, kCovenant))
				end
			else
				tooltipOCTO = E:func_KeyTooltip_LEFT(typeQ, ID, iANIMA, kCovenant)
			end
			frame.tooltip = tooltipOCTO
			E:func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end)
end
-- Функция обновления центральной панели
function EventFrame:Octo_Frame_initCENT(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	-- Обрабатываем случай с несколькими персонажами
	if data.totalPers > 1 then
		local current = frame.second[data.currentChar]
		if current then
			current:Show()
			current.curCharTextureBG:Show()
			current.TextCenter:SetText("")
			current.ReputTextureAndBG:Hide()
		end
	end
	-- Обрабатываем данные для правой панели
	for i = 1, #data.zxc.FIRST do
		local secondFrame = frame.second[i]
		local frameData = data.zxc
		if frameData.TextCenter[i] then
			local TextCenter = frameData.TextCenter[i]
			local FIRST = frameData.FIRST[i]
			local SECOND = frameData.SECOND[i]
			secondFrame.ReputTextureAndBG:Hide()
			-- Устанавливаем цвет если задан
			if frameData.ColorCenter[i] then
				local r1, g1, b1 = E:func_hex2rgbNUMBER(frameData.ColorCenter[i])
				if not frameData.IsReputations then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_RIGHT)
					secondFrame.ReputTextureAndBG:Show()
					secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
				else
					secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
				end
			end
			secondFrame.TextCenter:SetText(TextCenter)
			-- Особый случай для репутации
			if frameData.IsReputations and FIRST ~= 0 then
				if FIRST == SECOND then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_RIGHT)
					secondFrame.ReputTextureAndBG:Show()
				elseif FIRST >= 1 then
					secondFrame.ReputTextureAndBG:SetWidth(LINE_WIDTH_RIGHT/SECOND*FIRST)
					secondFrame.ReputTextureAndBG:Show()
				end
			end
		else
			secondFrame.TextCenter:SetText("")
			secondFrame.ReputTextureAndBG:SetVertexColor(0, 0, 0, 0)
		end
		secondFrame:Show()
		secondFrame.tooltip = frameData.tooltipRIGHT[i]
	end
end
-- Функция создания основного фрейма аддона
function EventFrame:Octo_Create_MainFrame_ToDo()
	-- Базовые настройки фрейма
	Octo_MainFrame_ToDo:SetPoint("CENTER", 0, 0)
	-- Обработчик показа фрейма
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			E:func_TODO_CreateDataProvider()
			RequestRaidInfo() -- Запрашиваем информацию о рейде
	end)
	-- Рассчитываем размеры фрейма
	local numPlayers = math_min(E:func_numPlayers(), COLUMNS_MAX)
	Octo_MainFrame_ToDo:SetSize(LINE_WIDTH_LEFT + LINE_WIDTH_RIGHT * numPlayers, LINE_HEIGHT * MAX_DISPLAY_LINES)
	-- Настройки поведения фрейма
	Octo_MainFrame_ToDo:SetDontSavePosition(Octo_ToDo_DB_Vars.Config_DontSavePosition)
	Octo_MainFrame_ToDo:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	-- Создаем скролл-фрейм
	local horizontalScrollFrame = CreateFrame("ScrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.horizontalScrollFrame = horizontalScrollFrame
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
	horizontalScrollFrame:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	horizontalScrollFrame:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)
	-- Создаем горизонтальную полосу прокрутки
	local horizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimhorizontalScrollBar")
	horizontalScrollBar.Backplate = horizontalScrollBar:GetRegions()
	horizontalScrollBar.Backplate:Hide()
	-- Настраиваем регионы полосы прокрутки
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
	horizontalScrollBar:RegisterCallback(horizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
			horizontalScrollFrame:SetHorizontalScroll(scrollPercentage * horizontalScrollFrame:GetHorizontalScrollRange())
	end)
	horizontalScrollBar:SetHideIfUnscrollable(true)
	-- Создаем дочерний фрейм для содержимого
	local scrollContentFrame = CreateFrame("FRAME")
	Octo_MainFrame_ToDo.scrollContentFrame = scrollContentFrame
	horizontalScrollFrame:SetScrollChild(scrollContentFrame)
	-- Настраиваем ScrollBox для левой панели
	Octo_MainFrame_ToDo.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(LINE_WIDTH_LEFT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	horizontalScrollFrame:SetPoint("TOPLEFT", Octo_MainFrame_ToDo.ScrollBoxLEFT, "TOPRIGHT", 0, HEADER_HEIGHT)
	horizontalScrollFrame:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ViewLeft = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewLeft:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewLeft:SetElementInitializer("BUTTON", function(...) self:func_initLEFT(...) end)
	Octo_MainFrame_ToDo.ViewLeft:RegisterCallback(Octo_MainFrame_ToDo.ViewLeft.Event.OnAcquiredFrame, func_OnAcquiredLeft, Octo_MainFrame_ToDo)
	-- Настраиваем ScrollBox для центральной панели
	Octo_MainFrame_ToDo.ScrollBoxCenter = CreateFrame("FRAME", nil, scrollContentFrame, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("TOPLEFT", 0, -HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxCenter:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBarCenter = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ViewCenter = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewCenter:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewCenter:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	Octo_MainFrame_ToDo.ViewCenter:RegisterCallback(Octo_MainFrame_ToDo.ViewCenter.Event.OnAcquiredFrame, func_OnAcquiredCENT, Octo_MainFrame_ToDo)
	-- Инициализируем скроллбоксы с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewLeft)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewCenter)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter)
	-- Настраиваем внешний вид основного фрейма
	Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_ToDo:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
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
		self:SetSize(LINE_WIDTH_RIGHT, HEADER_HEIGHT)
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
	Octo_MainFrame_ToDo.pool = CreateFramePool("FRAME", scrollContentFrame, nil, resetFunc, false, initFunc)
end
----------------------------------------------------------------
-- Функция создания провайдера данных для отображения
----------------------------------------------------------------
function E:func_TODO_CreateDataProvider()
	E:func_Collect_All_Table() -- Собираем все данные
	local numPlayers = math_min(E:func_numPlayers(), COLUMNS_MAX)
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
	local function CreateZxcTable(IsReputations)
		return {
			FIRST = {},
			SECOND = {},
			TextLeft = {},
			ColorLeft = {},
			TextCenter = {},
			tooltipRIGHT = {},
			ColorCenter = {},
			IsReputations = IsReputations or false,
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
				local _, _, TextCenter, tooltipRIGHT, ColorCenter = func(CharInfo)
				zxc.TextCenter[CharIndex] = TextCenter
				zxc.tooltipRIGHT[CharIndex] = tooltipRIGHT or {}
				zxc.ColorCenter[CharIndex] = ColorCenter
			end
			-- Получаем данные для левой панели от первого персонажа
			local firstChar = sortedPlayersTBL[1]
			if firstChar then
				local TextLeft, ColorLeft, _, _, _, myType = func(firstChar)
				zxc.TextLeft = TextLeft
				zxc.ColorLeft = ColorLeft
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
							local FIRST, SECOND, vivod, ColorCenter = ("#"):split(CharInfo.MASLENGO.Reputation[v.id])
							zxc.FIRST[CharIndex] = tonumber(FIRST) or 0
							zxc.SECOND[CharIndex] = tonumber(SECOND) or 0
							zxc.TextLeft = E:func_texturefromIcon(E.OctoTable_ReputationsDB[v.id].icon)..E:func_reputationName(v.id)
							-- zxc.TextLeft = E:func_texturefromIcon(E.OctoTable_Expansions[index].icon, 18, 32)..E:func_reputationName(v.id)
							-- if repInfo then
							-- zxc.IconLeft = repInfo.icon
							-- else
							-- zxc.IconLeft = E.ICON_EMPTY
							-- end
							zxc.ColorLeft = E.OctoTable_Expansions[index].color
							zxc.TextCenter[CharIndex] = vivod
							zxc.tooltipRIGHT[CharIndex] = {}
							zxc.ColorCenter[CharIndex] = ColorCenter
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
	MAX_DISPLAY_LINES = math_max(1, math_min(numlines, LINES_TOTAL or numlines))
	if Octo_MainFrame_ToDo then
		-- Устанавливаем провайдер данных (это запустит создание фреймов)
		Octo_MainFrame_ToDo.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_MainFrame_ToDo.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		-- Обновляем размеры фрейма
		local width = LINE_WIDTH_LEFT + LINE_WIDTH_RIGHT * numPlayers
		local height = LINE_HEIGHT * MAX_DISPLAY_LINES + HEADER_HEIGHT
		Octo_MainFrame_ToDo:SetSize(width, height)
		Octo_MainFrame_ToDo.scrollContentFrame:SetSize(LINE_WIDTH_RIGHT * E:func_numPlayers(), height)
		-- Обновляем фреймы персонажей
		Octo_MainFrame_ToDo.pool:ReleaseAll()
		for count, CharInfo in ipairs(sortedPlayersTBL) do
			local curCharFrame = Octo_MainFrame_ToDo.pool:Acquire()
			curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.scrollContentFrame, "TOPLEFT", LINE_WIDTH_RIGHT * (count - 1), -HEADER_HEIGHT)
			curCharFrame.text = curCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			curCharFrame.text:SetAllPoints()
			-- curCharFrame.text:SetFontObject(OctoFont11)
			curCharFrame.text:SetWordWrap(true)
			curCharFrame.text:SetJustifyV("MIDDLE")
			curCharFrame.text:SetJustifyH("CENTER")
			curCharFrame.text:SetMaxLines(3)
			curCharFrame.text:SetText(E:func_TextCenter_Chars(CharInfo))
			curCharFrame:SetPropagateMouseClicks(true)
			curCharFrame:SetPropagateMouseMotion(true)
			curCharFrame:SetHitRectInsets(1, 1, 1, 1)
			-- Устанавливаем цвет фона в зависимости от фракции
			if CharInfo.PlayerData.Faction == "Horde" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.COLOR_HORDE)
			elseif CharInfo.PlayerData.Faction == "Alliance" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.COLOR_ALLIANCE)
			elseif CharInfo.PlayerData.Faction == "Neutral" then
				charR, charG, charB = E:func_hex2rgbNUMBER(E.COLOR_NEUTRAL)
			end
			curCharFrame.charTexture:SetVertexColor(charR, charG, charB, E.ALPHA_BACKGROUND)
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
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED", -- Загрузка аддона
	"PLAYER_LOGIN", -- Вход игрока
	"PLAYER_REGEN_DISABLED", -- Вход в бой
}
E:func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
-- Обработчик события загрузки аддона
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	-- Рассчитываем максимальное количество персонажей
	local maxNum = math.floor((E.PHYSICAL_SCREEN_WIDTH - LINE_WIDTH_LEFT) / LINE_WIDTH_RIGHT) - 1
end
-- Обработчик события входа игрока
function EventFrame:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	-- Инициализируем основные системы
	self:Octo_Create_MainFrame_ToDo()
end
-- Обработчик входа в бой
function EventFrame:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
		Octo_MainFrame_ToDo:Hide() -- Скрываем фрейм в бою
	end
end
