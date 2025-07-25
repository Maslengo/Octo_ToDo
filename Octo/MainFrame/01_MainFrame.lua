-- Получаем глобальное имя аддона и основную таблицу из внешнего контекста
local GlobalAddonName, E = ...

-- Создаем фреймы для работы аддона
local Octo_EventFrame_ToDo = CreateFrame("FRAME") -- Фрейм для обработки событий
Octo_EventFrame_ToDo:Hide()

-- Основной фрейм интерфейса аддона
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()

----------------------------------------------------------------
-- Настройки размеров интерфейса
----------------------------------------------------------------
local AddonHeight = 20 -- Высота одной строки
local AddonLeftFrameWeight = 200 -- Ширина левой панели
local AddonCentralFrameWeight = 90 -- Ширина центральной панели
local MainFrameDefaultLines = 30 -- Количество строк по умолчанию

-- Автоматический расчет максимального количества строк
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight)*.7))
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end

local SFDropDownWeight = 100 -- Ширина выпадающего меню
local MaxNumCharacters = 10 -- Максимальное количество отображаемых персонажей

----------------------------------------------------------------
-- Подключаем необходимые библиотеки
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibDBIcon = LibStub("LibDBIcon-1.0") -- Для иконки на миникарте
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки

----------------------------------------------------------------
-- Функция для объединения таблиц отрисовки
----------------------------------------------------------------
E.OctoTable_Otrisovka = {} -- Таблица для хранения объединенных данных

local function func_ConcatAtStart_Otrisovka()
	wipe(E.OctoTable_Otrisovka) -- Очищаем таблицу

	-- Объединяем таблицы для каждого дополнения в обратном порядке (от нового к старому)
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_13_TheLastTitan())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_12_Midnight())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_11_TheWarWithin())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_10_Dragonflight())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_09_Shadowlands())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_08_BattleforAzeroth())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_07_Legion())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_06_WarlordsofDraenor())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_05_MistsofPandaria())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_04_Cataclysm())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_03_WrathoftheLichKing())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_02_TheBurningCrusade())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_01_WorldofWarcraft())

	-- Добавляем праздники и другие данные
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_90_Holidays())
	E:func_TableConcat(E.OctoTable_Otrisovka, E:func_Otrisovka_91_Other())

	return E.OctoTable_Otrisovka
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
	frameFULL.HighlightTexture:SetAlpha(E.bgCaOverlay) -- Прозрачность выделения
	frameFULL:SetPoint("LEFT", frame)
	frameFULL:SetPoint("TOP", frame)
	frameFULL:SetPoint("BOTTOM", frame)
	frameFULL:SetPoint("RIGHT")
	frame.frameFULL = frameFULL

	-- Создаем иконку
	local icon = frame:CreateTexture(nil, "BACKGROUND")
	icon:SetSize(AddonHeight - 2, AddonHeight - 2)
	icon:SetPoint("TOPLEFT", 1, -1)
	icon:SetTexCoord(0.10, 0.90, 0.10, 0.90) -- Обрезаем края иконки
	frame.icon_1 = icon

	-- Текст слева
	local textLeft = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	textLeft:SetPoint("LEFT", 2 + AddonHeight, 0)
	textLeft:SetWidth(AddonLeftFrameWeight - 2 - AddonHeight)
	textLeft:SetFontObject(OctoFont11) -- Используем наш шрифт
	textLeft:SetWordWrap(false) -- Запрещаем перенос слов
	textLeft:SetJustifyV(JustifyV)
	textLeft:SetJustifyH(JustifyH)
	textLeft:SetTextColor(1, 1, 1, 1) -- Белый цвет текста
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

	-- -- Обработчик наведения (показываем подсказку если текст обрезан)
	-- frame:SetScript("OnEnter", function(self)
	-- 		if not self.textLEFT:IsTruncated() then return end
	-- 		----------------------------------------------------------------
	-- 		-- GameTooltip:SetOwner(self, "ANCHOR_NONE")
	-- 		-- GameTooltip:SetPoint("CENTER", self)
	-- 		----------------------------------------------------------------
	-- 		GameTooltip:SetText(E:func_texturefromIcon(self.icon_1:GetTexture())..self.textLEFT:GetText(), 1, 1, 1)
	-- 		GameTooltip:Show()
	-- end)

end

----------------------------------------------------------------
-- Функция инициализации центральной панели
----------------------------------------------------------------
local func_OnAcquiredCENT do

	-- Получаем цвет класса игрока
	local r, g, b = GetClassColor(E.classFilename)

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
						f:SetSize(AddonCentralFrameWeight, AddonHeight)
						f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
						f:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*(key-1), 0)
						f:RegisterForClicks("LeftButtonUp")

						-- Текстура для текущего персонажа
						f.curCharTextureBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.curCharTextureBG:SetAllPoints()
						f.curCharTextureBG:SetTexture(E.TEXTURE_CENTRAL_PATH)
						f.curCharTextureBG:SetVertexColor(r, g, b, E.bgCaOverlay)
						f.curCharTextureBG:Hide()

						-- Текстура репутации
						f.ReputTextureAndBG = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.ReputTextureAndBG:SetPoint("LEFT")
						f.ReputTextureAndBG:SetHeight(AddonHeight)
						f.ReputTextureAndBG:SetTexture(E.TEXTURE_CENTRAL_PATH)

						-- Текст в центре
						f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
						f.textCENT:SetAllPoints()
						f.textCENT:SetFontObject(OctoFont11)
						f.textCENT:SetWordWrap(false)
						f.textCENT:SetJustifyV("MIDDLE")
						f.textCENT:SetJustifyH("CENTER")
						f.textCENT:SetTextColor(1, 1, 1, 1)

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
local function InitButtonTexture(frame, texture, iconWidth)
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
function Octo_EventFrame_ToDo:Octo_Frame_initLEFT(frame, node)
	local data = node:GetData()
	if not data.zxc then return end

	local frameData = data.zxc

	-- Устанавливаем текст и иконку
	frame.textLEFT:SetText(frameData.textLEFT)
	InitButtonTexture(frame.icon_1, frameData.iconLEFT, AddonHeight-2)

	-- Устанавливаем цвет фона если задан
	if frameData.colorLEFT then
		local r, g, b = E:func_hex2rgbNUMBER(frameData.colorLEFT)
		frame.textureLEFT:SetVertexColor(r, g, b, .2)
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
					secondFrame.ReputTextureAndBG:SetWidth(AddonCentralFrameWeight)
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
					secondFrame.ReputTextureAndBG:SetWidth(AddonCentralFrameWeight)
					secondFrame.ReputTextureAndBG:Show()
				elseif FIRST >= 1 then
					secondFrame.ReputTextureAndBG:SetWidth(AddonCentralFrameWeight/SECOND*FIRST)
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
	local frame = Octo_MainFrame_ToDo

	-- Базовые настройки фрейма
	frame:SetPoint("CENTER", 0, 0)

	-- Обработчик показа фрейма
	frame:SetScript("OnShow", function()
			E:func_TODO_CreateDataProvider()
			RequestRaidInfo() -- Запрашиваем информацию о рейде
	end)

	-- Рассчитываем размеры фрейма
	local NumPlayers = math_min(E:func_NumPlayers(), MaxNumCharacters)
	frame:SetSize(AddonLeftFrameWeight + AddonCentralFrameWeight * NumPlayers, AddonHeight * MainFrameDefaultLines)

	-- Настройки поведения фрейма
	frame:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	frame:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	frame:SetFrameStrata("HIGH")

	-- Создаем скролл-фрейм
	local barPanelScroll = CreateFrame("ScrollFrame", nil, frame)
	frame.barPanelScroll = barPanelScroll

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
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, frame, "OctoWowTrimHorizontalScrollBar")
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
	local childCENT = CreateFrame("Frame")
	frame.childCENT = childCENT
	barPanelScroll:SetScrollChild(childCENT)

	-- Настраиваем ScrollBox для левой панели
	frame.ScrollBoxLEFT = CreateFrame("Frame", nil, frame, "WowScrollBoxList")
	frame.ScrollBoxLEFT:SetWidth(AddonLeftFrameWeight)
	frame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -AddonHeight*2)
	frame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	frame.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	frame.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)

	barPanelScroll:SetPoint("TOPLEFT", frame.ScrollBoxLEFT, "TOPRIGHT", 0, AddonHeight*2)
	barPanelScroll:SetPoint("BOTTOMRIGHT")

	frame.viewLEFT = CreateScrollBoxListTreeListView(0)
	frame.viewLEFT:SetElementExtent(AddonHeight)
	frame.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	frame.viewLEFT:RegisterCallback(frame.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, frame)

	-- Настраиваем ScrollBox для центральной панели
	frame.ScrollBoxCENT = CreateFrame("Frame", nil, childCENT, "WowScrollBoxList")
	frame.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -AddonHeight*2)
	frame.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	frame.ScrollBoxCENT:SetPropagateMouseClicks(true)
	frame.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)

	frame.ScrollBarCENT = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	frame.ScrollBarCENT:SetPoint("TOPLEFT", frame, "TOPRIGHT", 6, 0)
	frame.ScrollBarCENT:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 6, 0)

	frame.viewCENT = CreateScrollBoxListTreeListView(0)
	frame.viewCENT:SetElementExtent(AddonHeight)
	frame.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	frame.viewCENT:RegisterCallback(frame.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, frame)

	-- Инициализируем скроллбоксы с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBoxLEFT, frame.ScrollBarCENT, frame.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(frame.ScrollBoxLEFT, frame.ScrollBarCENT)

	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBoxCENT, frame.ScrollBarCENT, frame.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(frame.ScrollBoxCENT, frame.ScrollBarCENT)

	-- Настраиваем внешний вид основного фрейма
	frame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0}
	})

	frame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, 1)
	frame:EnableMouse(true)
	frame:SetMovable(true)

	-- Обработчики перемещения фрейма
	frame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				frame:SetAlpha(E.bgCa)
				frame:StartMoving()
			end
	end)

	frame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				frame:SetAlpha(1)
				frame:StopMovingOrSizing()
			end
	end)

	frame:RegisterForClicks("RightButtonUp")
	frame:SetScript("OnClick", frame.Hide)

	-- Создаем пул фреймов для персонажей
	local function resetFunc(_, self)
		self:Hide()
		self:ClearAllPoints()
	end

	local function initFunc(self)
		self:SetSize(AddonCentralFrameWeight, AddonHeight*2)

		self.text = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.text:SetPoint("CENTER")
		self.text:SetFontObject(OctoFont11)
		self.text:SetJustifyV("MIDDLE")
		self.text:SetJustifyH("CENTER")
		self.text:SetTextColor(1, 1, 1, 1)

		self.charTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.charTexture:SetAllPoints()
		self.charTexture:SetTexture(E.TEXTURE_CHAR_PATH)
	end

	frame.pool = CreateFramePool("FRAME", childCENT, nil, resetFunc, false, initFunc)
end

----------------------------------------------------------------
-- Функция для отображения подсказки при наведении на персонажа
----------------------------------------------------------------








----------------------------------------------------------------
-- Функция создания провайдера данных для отображения
----------------------------------------------------------------
function E:func_TODO_CreateDataProvider()
	E.Collect_All_Table() -- Собираем все данные

	local NumPlayers = math_min(E:func_NumPlayers(), MaxNumCharacters)
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
			iconLEFT = {},
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
		for index, func in ipairs(func_ConcatAtStart_Otrisovka()) do
			numlines = numlines + 1
			local zxc = CreateZxcTable(false)

			-- Обрабатываем всех персонажей для центральных данных
			for CharIndex, CharInfo in ipairs(sortedPlayersTBL) do
				zxc.FIRST[CharIndex] = 0
				zxc.SECOND[CharIndex] = 0

				local _, _, _, textCENT, tooltipRIGHT, colorCENT = func(CharInfo)

				zxc.textCENT[CharIndex] = textCENT
				zxc.tooltipRIGHT[CharIndex] = tooltipRIGHT or {}
				zxc.colorCENT[CharIndex] = colorCENT
			end

			-- Получаем данные для левой панели от первого персонажа
			local firstChar = sortedPlayersTBL[1]
			if firstChar then
				local textLEFT, iconLEFT, colorLEFT, _, _, _, myType = func(firstChar)

				zxc.textLEFT = textLEFT
				zxc.iconLEFT = iconLEFT or E.Icon_Empty
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
					local factionMatch = not Octo_ToDo_DB_Vars.OnlyCurrentFaction or
					repInfo.side == E.curFaction or
					repInfo.side == "-"

					if factionMatch then
						numlines = numlines + 1
						local zxc = CreateZxcTable(true)

						for CharIndex, CharInfo in ipairs(sortedPlayersTBL) do
							local FIRST, SECOND, vivod, colorCENT = ("#"):split(CharInfo.MASLENGO.Reputation[v.id])

							zxc.FIRST[CharIndex] = tonumber(FIRST) or 0
							zxc.SECOND[CharIndex] = tonumber(SECOND) or 0
							zxc.textLEFT = E:func_reputationName(v.id)
							zxc.iconLEFT = repInfo.icon or E.Icon_Empty
							zxc.colorLEFT = E.OctoTable_Expansions[index].color
							zxc.textCENT[CharIndex] = vivod or "vivod"
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
	MainFrameDefaultLines = math_max(1, math_min(numlines, Octo_ToDo_DB_Vars.MainFrameDefaultLines or numlines))

	if Octo_MainFrame_ToDo then
		-- Устанавливаем провайдер данных (это запустит создание фреймов)
		Octo_MainFrame_ToDo.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_MainFrame_ToDo.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)

		-- Обновляем размеры фрейма
		local width = AddonLeftFrameWeight + AddonCentralFrameWeight * NumPlayers
		local height = AddonHeight * MainFrameDefaultLines + AddonHeight*2
		Octo_MainFrame_ToDo:SetSize(width, height)
		Octo_MainFrame_ToDo.childCENT:SetSize(AddonCentralFrameWeight * E:func_NumPlayers(), height)

		-- Обновляем фреймы персонажей
		Octo_MainFrame_ToDo.pool:ReleaseAll()

		for count, CharInfo in ipairs(sortedPlayersTBL) do
			local curCharFrame = Octo_MainFrame_ToDo.pool:Acquire()

			curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.childCENT, "TOPLEFT", AddonCentralFrameWeight * (count - 1), -AddonHeight*2)
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
			local charR, charG, charB = E:func_hex2rgbNUMBER(CharInfo.PlayerData.Faction == "Horde" and E.Horde_Color or E.Alliance_Color)
			curCharFrame.charTexture:SetVertexColor(charR, charG, charB, E.bgCaOverlay)


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
		if not Octo_MainFrame_ToDo.insertIn_SecuredFrames_SequredFrames then
			Octo_MainFrame_ToDo.insertIn_SecuredFrames_SequredFrames = true
			tinsert(UISpecialFrames, frameString)
			tinsert(E.OctoTable_Frames, Octo_MainFrame_ToDo)
		end
		for index, frames in ipairs(E.OctoTable_Frames) do
			if Octo_MainFrame_ToDo ~= frames and frames:IsShown() then
				frames:Hide()
			end
		end
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
	local db = Octo_ToDo_DB_Vars
	AddonHeight = db.AddonHeight or AddonHeight
	AddonLeftFrameWeight = db.AddonLeftFrameWeight or AddonLeftFrameWeight
	AddonCentralFrameWeight = db.AddonCentralFrameWeight or AddonCentralFrameWeight
	MainFrameDefaultLines = db.MainFrameDefaultLines or MainFrameDefaultLines
	SFDropDownWeight = db.SFDropDownWeight or SFDropDownWeight

	-- Рассчитываем максимальное количество персонажей
	local maxNum = math.floor((E.MonitorWidth - AddonLeftFrameWeight) / AddonCentralFrameWeight) - 1
	MaxNumCharacters = db.MaxNumCharacters and math_min(db.MaxNumCharacters, maxNum) or MaxNumCharacters

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

	-- Обновляем цену токена
	C_WowTokenPublic.UpdateMarketPrice()

	-- Устанавливаем масштаб меню игры
	GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.GameMenuFrameScale or 1)

	-- Инициализируем основные системы
	E:InitOptions()
	self:Octo_Create_MainFrame_ToDo()
	E:func_Create_DD_ToDo(Octo_MainFrame_ToDo, E.Red_Color, function() E:func_TODO_CreateDataProvider() end)

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