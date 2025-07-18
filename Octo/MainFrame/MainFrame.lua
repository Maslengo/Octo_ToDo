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
local LibSFDropDown = LibStub("LibSFDropDown-1.5") -- Для выпадающих меню

----------------------------------------------------------------
-- Настраиваем стиль выпадающего меню
----------------------------------------------------------------
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)

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

-- Обработчик наведения на левый элемент
local function func_OnEnterLEFT(frame)
	local tooltip = frame.tooltip
	if not tooltip or #tooltip == 0 then return end

	-- Показываем подсказку снизу слева от элемента
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMLEFT", 0, AddonHeight)

	-- Добавляем строки в подсказку
	for _, value in ipairs(tooltip) do
		GameTooltip:AddDoubleLine(tostring(value[1]), tostring(value[2]), 1, 1, 1, 1, 1, 1)
	end
	GameTooltip:Show()
end

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

	-- Назначаем обработчики событий
	frame:SetScript("OnLeave", GameTooltip_Hide)
	frame:SetScript("OnHide", func_OnHideLEFT)
	frame:SetScript("OnShow", func_OnShowLEFT)

	-- Обработчик наведения (показываем подсказку если текст обрезан)
	frame:SetScript("OnEnter", function(self)
			if not self.textLEFT:IsTruncated() then return end
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("CENTER", self)
			GameTooltip:SetText(E:func_texturefromIcon(self.icon_1:GetTexture())..self.textLEFT:GetText(), 1, 1, 1)
			GameTooltip:Show()
	end)

	frame:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
	end)
end

----------------------------------------------------------------
-- Функция инициализации центральной панели
----------------------------------------------------------------
local func_OnAcquiredCENT do

	-- Получаем цвет класса игрока
	local r, g, b = GetClassColor(E.classFilename)

	local function func_OnEnterSecond(frame)
		E:func_TooltipOnEnter(frame, true, true)
	end

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
						f:SetScript("OnEnter", func_OnEnterSecond)
						f:SetScript("OnLeave", GameTooltip_Hide)
						f:SetScript("OnHide", f.Hide)
						f.curCharTextureBG:SetScript("OnHide", f.curCharTextureBG.Hide)

						rawset(self, key, f)
						return f
					end
				end
		})

		-- Обработчики событий для основного фрейма
		frame:SetScript("OnEnter", func_OnEnter)
		frame:SetScript("OnLeave", func_OnLeave)
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
		frame.textureLEFT:SetVertexColor(r, g, b, E.bgCaOverlay)
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
			func_OnEnterLEFT(frame)
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
			E:func_CreateMyDataProvider()
			RequestRaidInfo() -- Запрашиваем информацию о рейде

			-- Обновляем текстовые поля
			local moneyText, timePlayedText, levelTimeText, resetText = Octo_EventFrame_ToDo:DisplayCharacterStats_TEXT()
			Octo_MainFrame_ToDo.moneyFrame.text:SetText(moneyText)
			Octo_MainFrame_ToDo.timePlayedFrame.text:SetText(timePlayedText)
			Octo_MainFrame_ToDo.levelTimeFrame.text:SetText(levelTimeText)
			Octo_MainFrame_ToDo.resetFrame.text:SetText(resetText)
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
local function func_OnEnterChars(frame)
	local tooltip = frame.tooltip
	if not tooltip or #tooltip == 0 then return end


-- tt:SetOwner(self, self.Button and 'ANCHOR_CURSOR' or 'ANCHOR_RIGHT') -- 11.0 fix this more


	-- GameTooltip:SetOwner(frame, "ANCHOR_CURSOR_RIGHT", 30, 30)
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT", 0, 1)

	for _, value in ipairs(tooltip) do
		GameTooltip:AddDoubleLine(tostring(value[1]), tostring(value[2]), 1, 1, 1, 1, 1, 1)
	end

	GameTooltip:Show()
end

----------------------------------------------------------------
-- Функция создания провайдера данных для отображения
----------------------------------------------------------------
function E:func_CreateMyDataProvider()
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
					func_OnEnterChars(curCharFrame)
			end)

			curCharFrame:SetScript("OnLeave", GameTooltip_Hide)
			curCharFrame:Show()
		end
	end
end

-- Функция создания выпадающего меню
function E:func_Create_DD_ToDo(mainFrame)
	local DD_ToDo = CreateFrame("Button", "DD_ToDo", mainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	DD_ToDo:SetSize(AddonLeftFrameWeight/2, AddonHeight)

	E:func_SetBackdrop(DD_ToDo) -- Устанавливаем фон

	-- Стрелка раскрытия меню
	DD_ToDo.ExpandArrow = DD_ToDo:CreateTexture(nil, "ARTWORK")
	DD_ToDo.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_ToDo.ExpandArrow:SetPoint("RIGHT", -4, 0)

	-- Текст меню
	DD_ToDo.text = DD_ToDo:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_ToDo.text:SetAllPoints()
	DD_ToDo.text:SetFontObject(OctoFont11)
	DD_ToDo.text:SetJustifyV("MIDDLE")
	DD_ToDo.text:SetJustifyH("CENTER")
	DD_ToDo.text:SetTextColor(1, 1, 1, 1)
	DD_ToDo.text:SetText(E.Purple_Color..MAIN_MENU.."|r")

	-- Настраиваем библиотеку выпадающего меню
	LibSFDropDown:SetMixin(DD_ToDo)
	DD_ToDo:SetPoint("BOTTOMLEFT", mainFrame, "TOPLEFT", 0, 0)
	DD_ToDo:ddSetDisplayMode(GlobalAddonName)
	DD_ToDo:ddSetNoGlobalMouseEvent(true)
	DD_ToDo:ddHideWhenButtonHidden()

	DD_ToDo:RegisterForClicks("LeftButtonUp")
	DD_ToDo:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)

	-- Функции для обработки выбора в меню
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		Octo_ToDo_DB_Levels[menuButton.value].PlayerData.isShownPLAYER = checked
		E:func_CreateMyDataProvider()
		mainFrame.ScrollBoxCENT:ScrollToOffset(0)
		mainFrame.barPanelScroll:SetHorizontalScroll(0)
	end

	local function func_remove_GUID(menuButton)
		Octo_ToDo_DB_Levels[menuButton.value] = nil
		E:func_CreateMyDataProvider()
	end

	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		E:func_CreateMyDataProvider()
	end

	-- Функция инициализации меню
	DD_ToDo:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			info.fontObject = OctoFont11
			local count = 0

			if level == 1 then
				-- Собираем список BattleTag'ов
				local BnetList = {}
				local Octo_BatlleNets = {}

				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo.PlayerData then
						if not BnetList[CharInfo.PlayerData.BattleTagLocal] then
							count = count + 1
							Octo_BatlleNets[count] = CharInfo.PlayerData.BattleTagLocal
						end
						BnetList[CharInfo.PlayerData.BattleTagLocal] = true
					end
				end

				sort(Octo_BatlleNets)

				-- Если BattleTag'ов больше одного, создаем подменю
				if count > 1 then
					for i, Bnets in ipairs(Octo_BatlleNets) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true

						local vivod = Bnets
						if Bnets == E.BattleTagLocal then
							vivod = E.classColorHexCurrent..Bnets.."|r"
						end

						if Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag == true then
							if Bnets ~= E.BattleTagLocal then
								vivod = E.Gray_Color..vivod.."|r"
							end
						end

						info.text = vivod
						info.value = Bnets
						tinsert(list, info)
					end
				else
					local GUID, CharInfo = next(Octo_ToDo_DB_Levels)
					value = CharInfo.PlayerData.BattleTagLocal
				end
			end

			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)

			-- Обработка разных уровней меню
			if type(value) == "string" then
				-- Меню серверов
				local tbl_Players = {}

				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo.PlayerData and (CharInfo.PlayerData.BattleTagLocal == value or not value) then
						tbl_Players[CharInfo.PlayerData.curServer] = tbl_Players[CharInfo.PlayerData.curServer] or {}
						tbl_Players[CharInfo.PlayerData.curServer][GUID] = tbl_Players[CharInfo.PlayerData.curServer][GUID] or {}
						tbl_Players[CharInfo.PlayerData.curServer][GUID] = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r"..(CharInfo.PlayerData.UnitLevel or 0)
					end
				end

				for Server, v in next, (tbl_Players) do
					local info = {}
					info.fontObject = OctoFont11
					info.hasArrow = true
					info.keepShownOnClick = true
					info.notCheckable = true

					local vivod = Server

					-- Подсвечиваем текущий сервер
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag and (value ~= E.BattleTagLocal or Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer)
					or not Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag and Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.curServer then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end

					info.text = vivod
					info.value = v
					tinsert(list, info)
				end

				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			elseif type(value) == "table" then
				-- Меню персонажей
				local players_list = {}

				for GUID, names in next, (value) do
					tinsert(players_list, GUID)
				end

				-- Сортируем персонажей по серверу, уровню и предметам
				sort(players_list, function(a, b)
						if Octo_ToDo_DB_Levels[a] and Octo_ToDo_DB_Levels[b] then
							local infoA = Octo_ToDo_DB_Levels[a].PlayerData
							local infoB = Octo_ToDo_DB_Levels[b].PlayerData

							if infoA and infoB then
								return
								(infoA.curServer or 0) > (infoB.curServer or 0) or
								(infoA.curServer or 0) == (infoB.curServer or 0) and (infoA.UnitLevel or 0) > (infoB.UnitLevel or 0) or
								(infoA.UnitLevel or 0) == (infoB.UnitLevel or 0) and (infoA.avgItemLevel or 0) > (infoB.avgItemLevel or 0) or
								(infoA.avgItemLevel or 0) == (infoB.avgItemLevel or 0) and (infoB.Name or 0) > (infoA.Name or 0)
							end
						end
				end)

				-- Добавляем персонажей в меню
				for _, GUID in next, (players_list) do
					if Octo_ToDo_DB_Levels[GUID].PlayerData then
						local info = {}
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.isNotRadio = true

						local vivod = Octo_ToDo_DB_Levels[GUID].PlayerData.classColorHex..Octo_ToDo_DB_Levels[GUID].PlayerData.Name.."|r"

						if Octo_ToDo_DB_Levels[GUID].PlayerData.UnitLevel ~= E.currentMaxLevel then
							vivod = vivod.." "..E.Yellow_Color..(Octo_ToDo_DB_Levels[GUID].PlayerData.UnitLevel or 0).."|r"
						end

						info.text = vivod
						info.value = GUID
						info.func = selectFunctionisShownPLAYER
						info.checked = Octo_ToDo_DB_Levels[GUID].PlayerData.isShownPLAYER
						info.remove = func_remove_GUID
						info.removeDoNotHide = true
						info.icon = Octo_ToDo_DB_Levels[GUID].PlayerData.specIcon
						info.iconInfo = {tSizeX = 16, tSizeY = 16}

						tinsert(list, info)
					end
				end

				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end

			-- Добавляем общие кнопки в меню
			if level == 1 then
				-- Кнопка "Показать всех"
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = INTERACT_ICONS_SHOW_ALL
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.PlayerData.isShownPLAYER = true
					end
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				-- Кнопка "Скрыть всех"
				info.text = HIDE
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.PlayerData.isShownPLAYER = false
					end
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Кнопка "Только текущий сервер"
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = checked
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				-- Кнопка "Только текущий BattleTag" (если их несколько)
				if count > 1 then
					info.text = L["Only Current BattleTag"]
					info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag = checked
						E:func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end

				-- Кнопка "Только текущая фракция"
				if E.curFaction == "Horde" then
					info.text = E:func_texturefromIcon(E.Icon_Horde)..L["Only Horde"]
				else
					info.text = E:func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"]
				end

				info.checked = Octo_ToDo_DB_Vars.OnlyCurrentFaction
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.OnlyCurrentFaction = checked
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				-- Кнопка "Репутация"
				info.text = REPUTATION
				info.checked = Octo_ToDo_DB_Vars.Reputations
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.Reputations = checked
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)
			end

			-- Меню фильтров по дополнениям
			if level == 1 then
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = EXPANSION_FILTER_TEXT
				info.value = EXPANSION_FILTER_TEXT
				info.icon = false
				info.hasArrow = true
				info.func = nil
				self:ddAddButton(info, level)
			elseif value == EXPANSION_FILTER_TEXT then
				-- Виджеты для кнопок
				info.widgets = {{
						icon = "interface/worldmap/worldmappartyicon",
						OnClick = function(btn)
							PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
							for expansionID = #E.OctoTable_Expansions, 1, -1 do
								Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
							end
							Octo_ToDo_DB_Vars.ExpansionToShow[btn.value] = true
							self:ddRefresh(level)
							E:func_CreateMyDataProvider()
						end,
				}}

				info.checked = function(btn)
					return Octo_ToDo_DB_Vars.ExpansionToShow[btn.value]
				end

				info.func = selectFunctionExpansion

				-- Добавляем кнопки для каждого дополнения (в обратном порядке)
				for expansionID = #E.OctoTable_Expansions, 1, -1 do
					local v = E.OctoTable_Expansions[expansionID]
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					self:ddAddButton(info, level)
				end

				info.widgets = nil
				info.iconInfo = nil
				info.checked = nil

				self:ddAddSeparator(level)

				-- Кнопки "Показать все" и "Скрыть все" для дополнений
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = INTERACT_ICONS_SHOW_ALL
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					self:ddRefresh(level)
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				info.text = HIDE
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					self:ddRefresh(level)
					E:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Кнопки фильтров для разных типов контента
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true

				local filterButtons = {
					{text = QUESTS_LABEL, var = "Quests"},
					{text = CALENDAR_FILTER_HOLIDAYS, var = "Holidays"},
					{text = DUNGEONS, var = "Dungeons"},
					{text = ITEMS, var = "Items"},
					{text = TRADE_SKILLS, var = "Professions"},
					{text = BONUS_ROLL_REWARD_MONEY, var = "Gold"},
					{text = STAT_AVERAGE_ITEM_LEVEL, var = "ItemLevel"},
					{text = L["Was online"], var = "WasOnline"},
				}

				for _, btn in ipairs(filterButtons) do
					info.text = btn.text
					info.checked = Octo_ToDo_DB_Vars[btn.var]
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars[btn.var] = checked
						E:func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end
			end
	end)

	DD_ToDo:ddSetOpenMenuUp(true)
	DD_ToDo:ddSetMenuButtonHeight(E.ddMenuButtonHeight)
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
	self:DisplayCharacterStats_CREATEFRAMES()
	E:func_Create_DD_ToDo(Octo_MainFrame_ToDo)

	-- Создаем элементы интерфейса
	E:func_CreateUtilsButton(Octo_MainFrame_ToDo, "ToDo", AddonHeight, 0)
	E:func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, nil, "Octo_MainFrame_ToDo")

	-- Загружаем ресурсы с небольшой задержкой
	C_Timer.After(0, function()
			self:LoadAssetsAsync()
	end)
end

-- Функция для отображения статистики персонажей
function Octo_EventFrame_ToDo:DisplayCharacterStats_TEXT()
	local totalMoney, realTotalTime, realLevelTime = 0, 0, 0

	-- Считаем общие деньги и время игры
	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.BattleTag == E.BattleTag then
			if CharInfo.PlayerData.Money then
				totalMoney = totalMoney + CharInfo.PlayerData.Money
			end

			if CharInfo.PlayerData.realTotalTime then
				realTotalTime = realTotalTime + CharInfo.PlayerData.realTotalTime
			end

			if CharInfo.PlayerData.UnitLevel and (CharInfo.PlayerData.UnitLevel >= E.currentMaxLevel) then
				realLevelTime = realLevelTime + CharInfo.PlayerData.realLevelTime
			end
		end
	end

	-- Форматируем текст для отображения
	local moneyText = format("Money: %s%s|r %s", E.classColorHexCurrent, E:func_CompactNumberFormat(totalMoney/10000), E.curServerShort)
	local timePlayedText = format(TIME_PLAYED_TOTAL, E.classColorHexCurrent..E:func_SecondsToClock(realTotalTime).."|r")
	local levelTimeText = format("realLevelTime: %s%s|r", E.classColorHexCurrent, E:func_SecondsToClock(realLevelTime))

	-- Время до сброса еженедельных заданий
	local weeklyReset = tonumber(E:func_tmstpDayReset(7)-GetServerTime())
	local resetText = E:func_texturefromIcon(E.Icon_Empty).." "..E:func_SecondsToClock(weeklyReset)..E.Gray_Color.." Weekly reset|r"

	return moneyText, timePlayedText, levelTimeText, resetText
end

-- Функция создания фреймов статистики
function Octo_EventFrame_ToDo:DisplayCharacterStats_CREATEFRAMES()
	local moneyText, timePlayedText, levelTimeText, resetText = Octo_EventFrame_ToDo:DisplayCharacterStats_TEXT()

	-- Создаем фреймы для отображения статистики
	Octo_MainFrame_ToDo.moneyFrame = E:func_CreateInfoFrame(moneyText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*0, AddonLeftFrameWeight, AddonHeight, "LEFT")
	Octo_MainFrame_ToDo.timePlayedFrame = E:func_CreateInfoFrame(timePlayedText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*1, AddonLeftFrameWeight, AddonHeight, "LEFT")
	Octo_MainFrame_ToDo.levelTimeFrame = E:func_CreateInfoFrame(levelTimeText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight, "LEFT")
	Octo_MainFrame_ToDo.resetFrame = E:func_CreateInfoFrame(resetText, "TOPLEFT", Octo_MainFrame_ToDo, "TOPLEFT", 0, 0, AddonLeftFrameWeight, AddonHeight*2, "LEFT")
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
				E:func_CreateMyDataProvider() -- Обновляем данные после загрузки
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