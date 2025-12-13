local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E.func_RegisterFrame(Octo_MainFrame_ToDo)
----------------------------------------------------------------
-- Константы для настройки интерфейса
local INDENT_LEFT = 10
local INDENT_TEXT = 4 -- Отступ для текста
local MIN_COLUMN_WIDTH_LEFT = 200 -- Минимальная ширина левой колонки
local MIN_COLUMN_WIDTH_Center = 90 -- Минимальная ширина центральной колонки
local MAX_DISPLAY_LINES = E.MAX_DISPLAY_LINES -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.PHYSICAL_SCREEN_WIDTH*.8 -- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.PHYSICAL_SCREEN_HEIGHT*.6 -- Максимальная высота фрейма (60% экрана)
EventFrame.MAX_COLUMN_COUNT = 113 -- Максимальное количество колонок
-- Цветовые настройки
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1 -- Цвет границы (черный)
local textR, textG, textB, textA = 1, 1, 1, 1 -- Цвет текста (белый)
local classR, classG, classB = GetClassColor(E.classFilename) -- Цвет класса игрока
local LEFT_TEXTURE_ALPHA = 0.1 -- Прозрачность текстуры левой колонки
local charR, charG, charB = 1, 1, 1
-- Локальные ссылки на часто используемые функции для оптимизации
local math_min = math.min
local math_max = math.max
local math_ceil= math.ceil
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut
-- Создаем отдельный фрейм для фона
local Octo_MainFrame_ToDo_Background = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "BackdropTemplate")
Octo_MainFrame_ToDo_Background:SetAllPoints()
Octo_MainFrame_ToDo_Background:SetFrameLevel(Octo_MainFrame_ToDo:GetFrameLevel() - 1) -- Ниже основного фрейма
Octo_MainFrame_ToDo_Background:SetBackdrop(E.menuBackdrop)
Octo_MainFrame_ToDo_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
Octo_MainFrame_ToDo_Background:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
-- Создание фрейма для заголовка левой колонки
local HeaderFrameLeft = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo)

local func_OnAcquiredLeft do
	local function Create_TextLeft(frame)
		frame.TextLeft = frame:CreateFontString()
		frame.TextLeft:SetFontObject(OctoFont11)
		frame.TextLeft:SetPoint("LEFT", E.GLOBAL_LINE_HEIGHT+INDENT_TEXT+0, 0)
		frame.TextLeft:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
		frame.TextLeft:SetWordWrap(false)
		frame.TextLeft:SetJustifyV("MIDDLE")-- Вертикальное выравнивание
		frame.TextLeft:SetJustifyH("LEFT")-- Горизонтальное выравнивание
		frame.TextLeft:SetTextColor(textR, textG, textB, textA)
	end
	local function Create_TextureLeft(frame)
		frame.TextureLeft = frame:CreateTexture(nil, "BACKGROUND", nil, -3) -- слой для фоновых текстур
		frame.TextureLeft:Hide()
		frame.TextureLeft:SetAllPoints()
		frame.TextureLeft:SetTexture(E.TEXTURE_LEFT_PATH)
	end
	local function Create_CategoryIcon(frame)
		frame.CategoryIcon = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		frame.CategoryIcon:SetPoint("TOPLEFT", 1, -1)
		frame.CategoryIcon:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		frame.CategoryIcon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
	end
	local function Create_SettingsButton(frame)
		frame.SettingsButton = CreateFrame("BUTTON", nil, frame)
		frame.SettingsButton:SetPropagateMouseClicks(true)
		frame.SettingsButton:SetPropagateMouseMotion(true)
		local texture = frame.SettingsButton:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("TOPLEFT", 1, -1)
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		-- Сохраняем текстуру в кнопке и во фрейме
		frame.SettingsButton.ToggleIconTexture = texture
		frame.ToggleIconTexture = texture
		-- Настраиваем КНОПКУ (SettingsButton), а не текстуру!
		frame.SettingsButton:SetSize(E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
		frame.SettingsButton:SetPoint("TOPLEFT", 1, -1)
		frame.SettingsButton:RegisterForClicks("LeftButtonUp")
		frame.SettingsButton:EnableMouse(true)
	end
	local function Create_Highlight(frame, owner)
		frame.Highlight = CreateFrame("BUTTON", nil, owner, "OctoHighlightAnimationTemplate")
		frame.Highlight:SetPropagateMouseClicks(true)
		frame.Highlight:SetPropagateMouseMotion(true)
		frame.Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
		if E.ENABLE_HIGHLIGHT_ANIMATION then
			frame.Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- "auctionhouse-ui-row-highlight"
			frame.Highlight.HighlightTexture = frame.Highlight:GetHighlightTexture()
			frame.Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
		end
		frame.Highlight:SetPoint("LEFT", frame)
		frame.Highlight:SetPoint("TOP", frame)
		frame.Highlight:SetPoint("BOTTOM", frame)
		frame.Highlight:SetPoint("RIGHT")
	end
	local function AdditionalSettings(frame)
		-- Настройки фрейма
		frame:SetPropagateMouseClicks(true)
		frame:SetPropagateMouseMotion(true)
		frame:SetHitRectInsets(1, 1, 1, 1)
	end


	-- Функция инициализации элементов левой колонки
	function func_OnAcquiredLeft(owner, frame, node, new)

		if not C_AddOns.IsAddOnLoaded("Blizzard_CurrencyTransfer") then
			C_AddOns.LoadAddOn("Blizzard_CurrencyTransfer")
		end


		if not new then return end
		local frameData = node:GetData()
		Create_TextLeft(frame) -- Текстовое поле для левой колонки
		Create_TextureLeft(frame) -- Текстура для фона левой колонки
		Create_CategoryIcon(frame)
		Create_SettingsButton(frame)
		Create_Highlight(frame, owner) -- Создание полноразмерного фрейма для подсветки
		AdditionalSettings(frame)
		-- Обработчики событий показа/скрытия фрейма
		frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
		frame:SetScript("OnShow", function() frame.Highlight:Show() end)
	end
end
-- Функция инициализации элементов центральной колонки
local func_OnAcquiredCenter do
	local function Create_CurrentCharBackground(columnFrame)
		columnFrame.CurrentCharBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.CurrentCharBackground:SetAllPoints()
		columnFrame.CurrentCharBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.CurrentCharBackground:SetVertexColor(classR, classG, classB, E.ALPHA_BACKGROUND)
		columnFrame.CurrentCharBackground:Hide()
	end
	local function Create_ReputationBackground(columnFrame)
		columnFrame.ReputationBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.ReputationBackground:SetPoint("LEFT")
		columnFrame.ReputationBackground:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame.ReputationBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
	end
	local function Create_TextCenter(columnFrame)
		columnFrame.TextCenter = columnFrame:CreateFontString()
		columnFrame.TextCenter:SetFontObject(OctoFont11)
		columnFrame.TextCenter:SetAllPoints()
		columnFrame.TextCenter:SetWordWrap(false)
		columnFrame.TextCenter:SetJustifyV("MIDDLE")
		columnFrame.TextCenter:SetJustifyH("CENTER")
		columnFrame.TextCenter:SetTextColor(textR, textG, textB, textA)
	end
	local function AdditionalSettings(columnFrame, frame)
		columnFrame:SetPropagateMouseClicks(true)
		columnFrame:SetPropagateMouseMotion(true)
		columnFrame:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame:SetHitRectInsets(1, 1, 1, 1)
		columnFrame:SetPoint("LEFT", frame, "LEFT", 0, 0)
	end
	function func_OnAcquiredCenter(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		frame:SetPropagateMouseClicks(true)
		-- Создание метатаблицы для динамического создания подфреймов
		frame.columnFrames = setmetatable({}, {
				__index = function(self, key)
					if key then
						-- Создание нового подфрейма для колонки
						local columnFrame = CreateFrame("BUTTON", nil, frame)
						Create_CurrentCharBackground(columnFrame) -- Текстура для фона текущего персонажа
						Create_ReputationBackground(columnFrame)-- Текстура для фона репутации
						Create_TextCenter(columnFrame) -- Текстовое поле для центральной колонки
						AdditionalSettings(columnFrame, frame)
						-- Обработчики скрытия
						columnFrame:SetScript("OnHide", columnFrame.Hide)
						columnFrame.CurrentCharBackground:SetScript("OnHide", columnFrame.CurrentCharBackground.Hide)
						rawset(self, key, columnFrame)
						return columnFrame
					end
				end
		})
	end
end
local function func_SettingsButton_OnClick(button, frameData)
	local dataType, id = ("#"):split(frameData.SettingsType)
	-- Получаем таблицу настроек для типа
	local CurrentProfile = Octo_profileKeys.CurrentProfile
	local settingsTable = Octo_profileKeys.profiles[CurrentProfile][dataType]
	if not settingsTable then return end
	-- Определяем ключ (строковый или числовой)
	local key = id
	if settingsTable[tonumber(id)] ~= nil then
		key = tonumber(id)
	end
	-- Если запись существует, переключаем, иначе создаем с true
	local newValue = not (settingsTable[key] or false)
	settingsTable[key] = newValue
	local texture = newValue and
	"Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonONgreen" or
	"Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFred"
	button.ToggleIconTexture:SetTexture(texture)
end
-- Функция инициализации данных для левой колонки
function EventFrame:func_InitLEFT(frame, node)
	local frameData = node:GetData()
	local CurrentProfile = Octo_profileKeys.CurrentProfile
	if frameData.IconLeft then
		frame.CategoryIcon:SetTexture(frameData.IconLeft)
		frame.CategoryIcon:SetAtlas(frameData.IconLeft, false)
	else
		frame.CategoryIcon:SetTexture("Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\spacerEMPTY")
	end
	if Octo_profileKeys.isSettingsEnabled and frameData.SettingsType then
		local dataType, id = ("#"):split(frameData.SettingsType)
		local texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\spacerEMPTY"
		if Octo_profileKeys.profiles[CurrentProfile][dataType][id] or Octo_profileKeys.profiles[CurrentProfile][dataType][tonumber(id)] then
			texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonONgreen"
		else
			texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFred"
		end
		frame.ToggleIconTexture:SetTexture(texture)
		frame.CategoryIcon:Hide()
		frame.SettingsButton:Show()
	else
		frame.CategoryIcon:Show()
		frame.SettingsButton:Hide()
	end
	frame.SettingsButton:SetScript("OnClick", function(self)
			func_SettingsButton_OnClick(self, frameData)
	end)
	-- Обновление размеров колонки, если они были изменены
	if EventFrame.columnWidthsLeft and EventFrame.columnWidthsLeft[1] then
		local newLeftWidth = EventFrame.columnWidthsLeft[1]
		Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEXT)
		frame.TextLeft:SetWidth(newLeftWidth)
		HeaderFrameLeft:SetWidth(newLeftWidth)
	end
	-- Установка текста и цвета для левой колонки



	if type(frameData.TextLeft) == "function" then
		frame.TextLeft:SetText(frameData.TextLeft()) -- ← Вызываем функцию!
	else
		frame.TextLeft:SetText(frameData.TextLeft) -- ← Просто строка
	end
	-- frame.TextLeft:SetText(frameData.TextLeft)
	if frameData.ColorLeft then
		local r, g, b = E.func_Hex2RGBFloat(frameData.ColorLeft)
		frame.TextureLeft:SetVertexColor(r, g, b, 0) -- LEFT_TEXTURE_ALPHA
		frame.TextureLeft:Show()
	else
		frame.TextureLeft:Hide()
	end
	frame:SetScript("OnEnter", function()
			if frameData.SettingsType then
				frame.tooltip = E.func_KeyTooltip_LEFT(frameData.SettingsType)
			else
				frame.tooltip = nil
			end
			E.func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end)
end
-- Функция инициализации данных для центральной колонки
function EventFrame:func_InitCenter(frame, node)
	local frameData = node:GetData()
	local accumulatedWidth = 0
	local columnWidthsCenter = EventFrame.columnWidthsCenter or {}
	-- Инициализация всех колонок для текущей строки
	for i = 1, (frameData.totalColumns or 0) do
		local columnFrames = frame.columnFrames[i]
		if not columnFrames then
			columnFrames = frame.columnFrames[i] -- Это вызовет __index из метатаблицы
		end
		-- Установка позиции и размера колонки
		columnFrames:ClearAllPoints()
		columnFrames:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
		local columnWidth = columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center
		columnFrames:SetWidth(columnWidth)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Установка текста и стилей для колонки
		if frameData.TextCenter and frameData.TextCenter[i] then
			local TextCenter = frameData.TextCenter[i]
			columnFrames.ReputationBackground:Hide()
			-- Установка цвета фона, если он задан
			if frameData.ColorCenter and frameData.ColorCenter[i] then
				local r1, g1, b1 = E.func_Hex2RGBFloat(frameData.ColorCenter[i])
				columnFrames.ReputationBackground:Show()
				columnFrames.ReputationBackground:SetVertexColor(r1, g1, b1, .3)
				if frameData.IsReputation and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) ~= 0 then
					local FirstReputation = tonumber(frameData.FirstReputation[i])
					local SecondReputation = tonumber(frameData.SecondReputation[i])
					if FirstReputation == SecondReputation then
						columnFrames.ReputationBackground:SetWidth(columnWidth)
					elseif FirstReputation >= 1 then
						columnFrames.ReputationBackground:SetWidth(columnWidth/SecondReputation*FirstReputation)
					end
				elseif frameData.IsReputation and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) == 0 then
					columnFrames.ReputationBackground:Hide()
				else
					columnFrames.ReputationBackground:SetWidth(columnWidth)
				end
			end
			columnFrames.TextCenter:SetText(TextCenter)
			-- Подсветка колонки текущего персонажа если больше 1 персонажа
			if frameData.totalColumns > 1 and i == frameData.currentCharacterIndex then
				columnFrames.CurrentCharBackground:Show()
			else
				columnFrames.CurrentCharBackground:Hide()
			end
		else
			columnFrames.TextCenter:SetText("")
			columnFrames.ReputationBackground:SetVertexColor(0, 0, 0, 0)
			columnFrames.CurrentCharBackground:Hide()
		end
		columnFrames:SetScript("OnEnter", function()
				if frameData.SettingsType and frameData.GUID[i] then
					columnFrames.tooltip = E.func_KeyTooltip_RIGHT(frameData.GUID[i], frameData.SettingsType)
				else
					columnFrames.tooltip = nil
				end
				E.func_OctoTooltip_OnEnter(columnFrames) --, {"LEFT", "RIGHT"}) -- если перс будет справа и тултип со скроллом, то будет габелла
		end)
		columnFrames:Show()
	end
	for i = frameData.totalColumns+1, #frame.columnFrames do
		frame.columnFrames[i]:Hide()
	end
end


-- Функция создания главного тестового фрейма
function EventFrame:func_CreateMainFrame()
	-- Настройка позиции и обработчика показа фрейма
	Octo_MainFrame_ToDo:SetPoint("TOP", 0, -E.PHYSICAL_SCREEN_WIDTH*.1)
	-- Octo_MainFrame_ToDo:SetPoint("CENTER")
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			RequestRaidInfo()
			E.func_Collect_All()

			EventFrame:CreateDataProvider()
			C_Timer.After(1, function()
				E.func_UPDATE_MAINFRAME()
			end)
			E.func_SmoothBackgroundAlphaChange(Octo_MainFrame_ToDo, Octo_MainFrame_ToDo_Background, "OnShow")
	end)
	-- Расчет размеров фрейма на основе количества игроков
	local numPlayers = math_min(E.func_CountVisibleCharacters(), EventFrame.MAX_COLUMN_COUNT)
	Octo_MainFrame_ToDo:SetSize(MIN_COLUMN_WIDTH_LEFT + MIN_COLUMN_WIDTH_Center * numPlayers, E.GLOBAL_LINE_HEIGHT * MAX_DISPLAY_LINES)
	-- Настройки фрейма
	Octo_MainFrame_ToDo:SetDontSavePosition(true)
	Octo_MainFrame_ToDo:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	-- Создание скроллфрейма для горизонтальной прокрутки
	local horizontalScrollFrame = CreateFrame("ScrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.horizontalScrollFrame = horizontalScrollFrame
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
	local horizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimhorizontalScrollBar")
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
	Octo_MainFrame_ToDo.scrollContentFrame = scrollContentFrame
	horizontalScrollFrame:SetScrollChild(scrollContentFrame)
	-- Создание ScrollBox для левой колонки
	Octo_MainFrame_ToDo.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Настройка позиции панели прокрутки
	horizontalScrollFrame:SetPoint("TOPLEFT", Octo_MainFrame_ToDo.ScrollBoxLEFT, "TOPRIGHT", 0, E.HEADER_HEIGHT)
	horizontalScrollFrame:SetPoint("BOTTOMRIGHT")
	-- Создание и настройка представления для левой колонки
	Octo_MainFrame_ToDo.ViewLeft = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewLeft:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewLeft:SetElementInitializer("BUTTON", function(...) self:func_InitLEFT(...) end)
	Octo_MainFrame_ToDo.ViewLeft:RegisterCallback(Octo_MainFrame_ToDo.ViewLeft.Event.OnAcquiredFrame, func_OnAcquiredLeft, Octo_MainFrame_ToDo)
	-- Создание ScrollBox для центральной колонки
	Octo_MainFrame_ToDo.ScrollBoxCenter = CreateFrame("FRAME", nil, scrollContentFrame, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxCenter:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Создание и настройка вертикальной полосы прокрутки
	Octo_MainFrame_ToDo.ScrollBarCenter = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	-- Создание и настройка представления для центральной колонки
	Octo_MainFrame_ToDo.ViewCenter = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewCenter:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewCenter:SetElementInitializer("BUTTON", function(...) self:func_InitCenter(...) end)
	Octo_MainFrame_ToDo.ViewCenter:RegisterCallback(Octo_MainFrame_ToDo.ViewCenter.Event.OnAcquiredFrame, func_OnAcquiredCenter, Octo_MainFrame_ToDo)
	-- Инициализация ScrollBox с полосами прокрутки
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewLeft)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewCenter)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter)
	-- Настройка фона и границы главного фрейма
	Octo_MainFrame_ToDo:SetBackdrop(nil)
	-- Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	-- Octo_MainFrame_ToDo:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
	-- Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка взаимодействия с фреймом
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				-- Octo_MainFrame_ToDo:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnTheMove or E.backgroundColorA)
				-- UIFrameFadeOut(Octo_MainFrame_ToDo, 0.2, Octo_MainFrame_ToDo:GetAlpha(), Octo_ToDo_DB_Vars.Config_AlphaOnTheMove or E.backgroundColorA)
				Octo_MainFrame_ToDo:StartMoving()
			end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				-- Octo_MainFrame_ToDo:SetAlpha(1)
				-- UIFrameFadeIn(Octo_MainFrame_ToDo, 0.2, Octo_MainFrame_ToDo:GetAlpha(), 1)
				Octo_MainFrame_ToDo:StopMovingOrSizing()
				-- local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_ToDo:GetPoint()
			end
	end)
	-- Обработчик клика правой кнопкой для скрытия фрейма
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", Octo_MainFrame_ToDo.Hide)
	-- Настройка заголовка левой колонки
	HeaderFrameLeft:SetPoint("TOPLEFT")
	HeaderFrameLeft:SetSize(MIN_COLUMN_WIDTH_LEFT, E.HEADER_HEIGHT)
	HeaderFrameLeft.Text = HeaderFrameLeft:CreateFontString()
	HeaderFrameLeft.Text:SetFontObject(OctoFont11)
	HeaderFrameLeft.Text:SetPoint("LEFT", INDENT_TEXT, 0)
	HeaderFrameLeft.Text:SetWordWrap(false)
	HeaderFrameLeft.Text:SetJustifyV("MIDDLE")
	HeaderFrameLeft.Text:SetJustifyH("LEFT")
	HeaderFrameLeft.Text:SetTextColor(textR, textG, textB, textA)
	-- Обработчик показа заголовка левой колонки
	HeaderFrameLeft:SetScript("OnShow", function()
			HeaderFrameLeft.Text:SetText(E.COLOR_PURPLE.."Weekly Reset:|r "..E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetSecondsToWeeklyReset(), true).."|r ")
	end)
	-- Функция сброса пула фреймов
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	-- Функция инициализации фреймов в пуле
	local function InitializePoolFrame(self)
		self:SetSize(MIN_COLUMN_WIDTH_Center, E.HEADER_HEIGHT)
		self.Nickname = self:CreateFontString()
		self.Nickname:SetFontObject(OctoFont11)
		self.Server = self:CreateFontString()
		self.Server:SetFontObject(OctoFont10)
		self.Text = self:CreateFontString()
		self.Text:SetFontObject(OctoFont11)
		self.Text:SetPoint("CENTER")
		self.Text:SetJustifyV("MIDDLE")
		self.Text:SetJustifyH("CENTER")
		self.Text:SetTextColor(textR, textG, textB, textA)
		self.CharTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.CharTexture:SetAllPoints()
		self.CharTexture:SetTexture(E.TEXTURE_CHAR_PATH)
	end
	-- Создание пула фреймов для заголовков колонок
	Octo_MainFrame_ToDo.pool = CreateFramePool("FRAME", scrollContentFrame, nil, ResetPoolFrame, false, InitializePoolFrame)
end
-- Функция расчета ширины колонок для левой части
local function func_calculateColumnWidthsLEFT(node)
	local frameData = node:GetData()
	local framesLEFT = Octo_MainFrame_ToDo.ViewLeft:GetFrames()
	local framesCENT = Octo_MainFrame_ToDo.ViewCenter:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesLEFT == 0 then
		Octo_MainFrame_ToDo.ViewLeft:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.ViewLeft:InvokeInitializers()
	end
	if #framesCENT == 0 then
		Octo_MainFrame_ToDo.ViewCenter:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.ViewCenter:InvokeInitializers()
	end
	-- Расчет ширины на основе текста
	local columnWidthsLEFT = {}
	-- framesLEFT[1].TextLeft:SetText(frameData.TextLeft)

	if type(frameData.TextLeft) == "function" then
		framesLEFT[1].TextLeft:SetText(frameData.TextLeft()) -- ← Вызываем функцию!
	else
		framesLEFT[1].TextLeft:SetText(frameData.TextLeft) -- ← Просто строка
	end
	columnWidthsLEFT[1] = math_ceil(framesLEFT[1].TextLeft:GetStringWidth()) + INDENT_LEFT + E.GLOBAL_LINE_HEIGHT -- (иконка)
	return columnWidthsLEFT
end
-- Функция расчета ширины колонок для правой части
local function func_calculateColumnWidthsCenter(node)
	local frameData = node:GetData()
	local framesCENT = Octo_MainFrame_ToDo.ViewCenter:GetFrames()
	-- Создание тестовых фреймов, если их нет
	if #framesCENT == 0 then
		Octo_MainFrame_ToDo.ViewCenter:AcquireInternal(1, node)
		Octo_MainFrame_ToDo.ViewCenter:InvokeInitializers()
		framesCENT = Octo_MainFrame_ToDo.ViewCenter:GetFrames()
	end
	local columnWidthsCenter = {}
	local sampleFrameCenter = framesCENT[1]
	-- Инициализация всех подфреймов
	for i = 1, frameData.totalColumns do
		if not sampleFrameCenter.columnFrames[i] then
			sampleFrameCenter.columnFrames[i] = sampleFrameCenter.columnFrames[i] -- Вызовет __index
		end
	end
	-- Расчет ширины для каждой колонки
	for i = 1, frameData.totalColumns do
		if frameData.TextCenter[i] then
			sampleFrameCenter.columnFrames[i].TextCenter:SetText(frameData.TextCenter[i])
			columnWidthsCenter[i] = math_ceil(math_max(
					sampleFrameCenter.columnFrames[i].TextCenter:GetStringWidth() + INDENT_LEFT,
					MIN_COLUMN_WIDTH_Center
			))
		else
			columnWidthsCenter[i] = MIN_COLUMN_WIDTH_Center
		end
	end
	return columnWidthsCenter
end
local function func_calculateColumnWidthsCenter_HEADER(frame, nicknameTEXT, serverTEXT)
	frame.Nickname:SetText(nicknameTEXT)
	local width2 = 0
	local width1 = math_ceil(math_max(
			frame.Nickname:GetStringWidth() + INDENT_LEFT,
			MIN_COLUMN_WIDTH_Center
	))
	if not Octo_ToDo_DB_Vars.isOnlyCurrentServer then
		frame.Server:SetText(serverTEXT)
		width2 = math_ceil(math_max(
				frame.Server:GetStringWidth() + INDENT_LEFT,
				MIN_COLUMN_WIDTH_Center
		))
	end
	return math_max(width1, width2)
end




local function func_UPDATE_MAINFRAME() -- providerfunc
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() and OctoTooltip and not OctoTooltip:IsShown() then
		EventFrame:CreateDataProvider()
	end
end

function E.func_UPDATE_MAINFRAME()
	E.func_SpamBlock(func_UPDATE_MAINFRAME, true)
end

-- Функция создания и обновления провайдера данных
function EventFrame:CreateDataProvider()
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local columnWidthsLeft = {}
	local columnWidthsCenter = {}
	local CurrentProfile = Octo_profileKeys.CurrentProfile
	-- E.func_CreateNewProfile(CurrentProfile)
	local ExpansionToShowTBL = Octo_profileKeys.profiles[CurrentProfile].ExpansionToShow
	-- Получение отсортированных данных персонажей
	local sortedCharacters = E.func_SortCharacters()
	local currentCharacterIndex
	-- Поиск индекса текущего персонажа
	for CharIndex, CharInfo in ipairs(sortedCharacters) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end
	local totalColumns = #sortedCharacters
	local firstChar = sortedCharacters[1]
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- Определяем порядок обработки типов данных
	local dataDisplayOrder = {
		"Currencies", -- 1. Валюта
		"Items", -- 2. Итемы
		"Additionally", -- 3. Адишинал
		"UniversalQuests",-- 4. Универсал
		"Reputations", -- 5. Репа
	}
	----------------------------------------------------------------
	-- Расчёт ширины правых фреймпулов
	local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
	for CharIndex, CharInfo in ipairs(sortedCharacters) do
		columnWidthsCenter[CharIndex] = func_calculateColumnWidthsCenter_HEADER(HeaderFrameCenter, E.func_TextCenter_Chars_nickname(CharInfo), E.func_TextCenter_Chars_server(CharInfo))
	end
	Octo_MainFrame_ToDo.pool:Release(HeaderFrameCenter)
	-- opde(E.OctoTables_DataOtrisovka)
	----------------------------------------------------------------
	for categoryKey in next,(E.OctoTables_Vibor) do
		-- if Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then
		if ExpansionToShowTBL[categoryKey] then
			-- Обрабатываем типы данных в нужном порядке
			for _, dataType in ipairs(dataDisplayOrder) do
				-- for dataType in next,(E.OctoTables_DataOtrisovka[categoryKey]) do


				-- for i, id in next,(E.OctoTables_DataOtrisovka[categoryKey][dataType]) do
				for i, id in next,(E.DataProvider_Otrisovka[categoryKey][dataType]) do
					local questKey
					if dataType == "UniversalQuests" then
						questKey = E.UNIVERSAL..id.desc.."_"..id.name_save.."_"..id.reset
					end
					if dataType ~= "UniversalQuests" and E.func_ShouldShow(id, dataType, CurrentProfile) or E.func_ShouldShow(questKey, dataType, CurrentProfile) then
						totalLines = totalLines + 1
						local rowData = {
							TextLeft = {},
							ColorLeft = {},
							IconLeft = {},
							SettingsType = {},
							TooltipKey = {},
							IsReputation = {},
							TextCenter = {},
							ColorCenter = {},
							FirstReputation = {},
							SecondReputation = {},
							GUID = {},
						}
						-- Заполнение данных для левой колонки (берется из первого персонажа)
						local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = E.func_Otrisovka_LEFT_Dispatcher(categoryKey, firstChar, dataType, id)
						rowData.IconLeft = IconLeft
						rowData.TextLeft = TextLeft or "NONE"
						rowData.ColorLeft = ColorLeft or E.COLOR_BLUE
						rowData.SettingsType = SettingsType
						-- rowData.TooltipKey = TooltipKey
						rowData.IsReputation = IsReputation or false
						-- Заполнение данных для каждого персонажа
						for CharIndex, CharInfo in ipairs(sortedCharacters) do
							local TextCenter, ColorCenter, FirstReputation, SecondReputation = E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
							rowData.TextCenter[CharIndex] = TextCenter
							rowData.ColorCenter[CharIndex] = ColorCenter
							rowData.GUID[CharIndex] = CharInfo.PlayerData.GUID
							rowData.FirstReputation[CharIndex] = FirstReputation or 0
							rowData.SecondReputation[CharIndex] = SecondReputation or 0
						end
						-- Установка дополнительных параметров
						rowData.currentCharacterIndex = currentCharacterIndex
						rowData.totalColumns = totalColumns
						-- Вставка данных в провайдер
						local node = DataProvider:Insert(rowData)
						-- Расчет ширины колонок
						for j, w in ipairs(func_calculateColumnWidthsLEFT(node, totalLines)) do
							columnWidthsLeft[j] = math_max(w, columnWidthsLeft[j] or HeaderFrameLeft.Text:GetWidth() or 0)
						end
						local rightWidths = func_calculateColumnWidthsCenter(node)
						for i, w in ipairs(rightWidths) do
							columnWidthsCenter[i] = math_max(w, columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center)
						end
					end
				end
			end
		end
	end
	-- Сохранение рассчитанных размеров колонок
	EventFrame.columnWidthsLeft = columnWidthsLeft
	EventFrame.columnWidthsCenter = columnWidthsCenter
	-- Обновление интерфейса, если фрейм существует
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.scrollContentFrame then return end
	Octo_MainFrame_ToDo.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	Octo_MainFrame_ToDo.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	-- Расчет общей ширины правой части
	local totalRightWidth = 0
	local maxRIGHT = MIN_COLUMN_WIDTH_LEFT
	if columnWidthsLeft and columnWidthsLeft[1] then
		maxRIGHT = MAX_FRAME_WIDTH - columnWidthsLeft[1]+INDENT_TEXT
	end
	for i = 1, math_min(#columnWidthsCenter, EventFrame.MAX_COLUMN_COUNT) do
		if (totalRightWidth + columnWidthsCenter[i]) <= maxRIGHT then
			totalRightWidth = totalRightWidth + columnWidthsCenter[i]
		else
			break
		end
	end
	local totalRightWidth_scrollContentFrame = 0
	for i = 1, math_min(#columnWidthsCenter, EventFrame.MAX_COLUMN_COUNT) do
		totalRightWidth_scrollContentFrame = totalRightWidth_scrollContentFrame + columnWidthsCenter[i]
	end
	-- Расчет количества строк
	local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / E.GLOBAL_LINE_HEIGHT)
	MAX_DISPLAY_LINES = math_max(1, math_min(totalLines, LINES_TOTAL or totalLines))
	-- Установка размеров фрейма
	local width = MIN_COLUMN_WIDTH_LEFT
	if columnWidthsLeft and columnWidthsLeft[1] then
		width = (columnWidthsLeft[1]+INDENT_TEXT or MIN_COLUMN_WIDTH_LEFT) + totalRightWidth
	end
	if width%2 == 1 then
		width = width + 1
	end
	local height = E.GLOBAL_LINE_HEIGHT * MAX_DISPLAY_LINES + E.HEADER_HEIGHT
	Octo_MainFrame_ToDo:SetSize(width, height)
	Octo_MainFrame_ToDo.scrollContentFrame:SetSize(totalRightWidth_scrollContentFrame, height)
	-- Освобождение всех фреймов из пула
	Octo_MainFrame_ToDo.pool:ReleaseAll()
	-- Создание заголовков для колонок персонажей
	local accumulatedWidth = 0
	for count, CharInfo in ipairs(sortedCharacters) do
		local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
		local columnWidth = columnWidthsCenter[count] or MIN_COLUMN_WIDTH_Center
		-- Установка позиции и размера заголовка
		HeaderFrameCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.scrollContentFrame, "TOPLEFT", accumulatedWidth, -E.HEADER_HEIGHT)
		HeaderFrameCenter:SetSize(columnWidth, E.HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Настройка текста заголовка
		-- HeaderFrameCenter.Nickname:SetAllPoints()
		HeaderFrameCenter.Nickname:SetPoint("CENTER", 0, E.HEADER_TEXT_OFFSET)
		if Octo_ToDo_DB_Vars.isOnlyCurrentServer then
			HeaderFrameCenter.Nickname:SetPoint("CENTER")
		end
		HeaderFrameCenter.Nickname:SetWordWrap(false)
		HeaderFrameCenter.Nickname:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Nickname:SetJustifyH("CENTER")
		HeaderFrameCenter.Nickname:SetText(E.func_TextCenter_Chars_nickname(CharInfo))
		-- HeaderFrameCenter.Server:SetAllPoints()
		HeaderFrameCenter.Server:SetPoint("CENTER", 0, -E.HEADER_TEXT_OFFSET)
		HeaderFrameCenter.Server:SetWordWrap(false)
		HeaderFrameCenter.Server:SetJustifyV("BOTTOM")
		HeaderFrameCenter.Server:SetJustifyH("CENTER")
		HeaderFrameCenter.Server:SetText(E.func_TextCenter_Chars_server(CharInfo))
		-- Настройка взаимодействия
		HeaderFrameCenter:SetPropagateMouseClicks(true)
		HeaderFrameCenter:SetPropagateMouseMotion(true)
		HeaderFrameCenter:SetHitRectInsets(1, 1, 1, 1)
		-- Устанавливаем цвет фона в зависимости от фракции
		if CharInfo.PlayerData.Faction == "Horde" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_HORDE)
		elseif CharInfo.PlayerData.Faction == "Alliance" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_ALLIANCE)
		elseif CharInfo.PlayerData.Faction == "Neutral" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_NEUTRAL)
		end
		-- -- Установка цвета фона в зависимости от фракции
		-- local charR, charG, charB = E.func_Hex2RGBFloat(CharInfo.PlayerData.Faction == "Horde" and E.COLOR_HORDE or E.COLOR_ALLIANCE)
		HeaderFrameCenter.CharTexture:SetVertexColor(charR, charG, charB, E.ALPHA_BACKGROUND)
		-- Обработчик наведения для отображения тултипа
		HeaderFrameCenter:SetScript("OnEnter", function(self)
				HeaderFrameCenter.tooltip = E.func_Tooltip_Chars(CharInfo)
				E.func_OctoTooltip_OnEnter(HeaderFrameCenter, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
		HeaderFrameCenter:Show()
	end
	-- Обновление позиций подфреймов в центральной колонке
	for _, frame in ipairs(Octo_MainFrame_ToDo.ViewCenter:GetFrames()) do
		local accumulatedWidth = 0
		for i = 1, #columnWidthsCenter do
			if frame.columnFrames[i] then
				frame.columnFrames[i]:ClearAllPoints()
				frame.columnFrames[i]:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
				frame.columnFrames[i]:SetWidth(columnWidthsCenter[i])
				accumulatedWidth = accumulatedWidth + columnWidthsCenter[i]
			end
		end
	end
	-- Ресет скроллбара
	-- C_Timer.After(0, function()
	-- EventFrame.horizontalScrollBar:SetScrollPercentage(0)
	-- Octo_MainFrame_ToDo.ScrollBoxCenter:ScrollToElementDataIndex(1)
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
	"PLAYER_STARTED_MOVING",
	"PLAYER_STOPPED_MOVING",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	-- AlertFrame:ClearAllPoints()
	-- AlertFrame:SetPoint("BOTTOMLEFT", 200, 300)
	EventFrame:func_CreateMainFrame()
	E.func_Create_DDframe_ToDo(Octo_MainFrame_ToDo, E.COLOR_FACTION, function() EventFrame:CreateDataProvider() end)
	E.func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, nil, "Octo_MainFrame_ToDo")
end
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_MainFrame_ToDo:Hide()
end
-- Обновляем обработчики событий
function EventFrame:PLAYER_STARTED_MOVING()
	E.func_SmoothBackgroundAlphaChange(Octo_MainFrame_ToDo, Octo_MainFrame_ToDo_Background, "PLAYER_STARTED_MOVING")
end
function EventFrame:PLAYER_STOPPED_MOVING()
	E.func_SmoothBackgroundAlphaChange(Octo_MainFrame_ToDo, Octo_MainFrame_ToDo_Background, "PLAYER_STOPPED_MOVING")
end