local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")

-- Константы для настройки интерфейса
local INDENT_LEFT = 10
local INDENT_TEST = 4 -- Отступ для текста
local LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT -- Высота одной строки
local HEADER_HEIGHT = LINE_HEIGHT*2 -- Высота заголовка
local MIN_LINE_WIDTH_LEFT = 200 -- Минимальная ширина левой колонки
local MIN_LINE_WIDTH_CENT = 90 -- Минимальная ширина центральной колонки
local LINES_MAX = E.LINES_MAX -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.PHYSICAL_SCREEN_WIDTH*.8 -- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.PHYSICAL_SCREEN_HEIGHT*.6 -- Максимальная высота фрейма (60% экрана)
EventFrame.COLUMNS_MAX = 113 -- Максимальное количество колонок
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
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut




-- Создание главного фрейма для тестового интерфейса
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E.func_InitFrame(Octo_MainFrame_ToDo)
-- Создаем отдельный фрейм для фона
local Octo_MainFrame_ToDo_Background = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "BackdropTemplate")
Octo_MainFrame_ToDo_Background:SetAllPoints()
Octo_MainFrame_ToDo_Background:SetFrameLevel(Octo_MainFrame_ToDo:GetFrameLevel() - 1) -- Ниже основного фрейма
Octo_MainFrame_ToDo_Background:SetBackdrop(E.menuBackdrop)
Octo_MainFrame_ToDo_Background:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
Octo_MainFrame_ToDo_Background:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
-- Создание фрейма для заголовка левой колонки
local HeaderFrameLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo)




local func_OnAcquiredLEFT do
	-- Функция инициализации элементов левой колонки
	function func_OnAcquiredLEFT(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		local JustifyV = "MIDDLE" -- Вертикальное выравнивание
		local JustifyH = "LEFT" -- Горизонтальное выравнивание
		-- Настройки фрейма
		frame:SetPropagateMouseClicks(true)
		frame:SetPropagateMouseMotion(true)
		frame:SetHitRectInsets(1, 1, 1, 1)
		-- Создание полноразмерного фрейма для подсветки
		local frameFULL = CreateFrame("BUTTON", nil, owner, "OctoHighlightAnimationTemplate")
		frameFULL:SetPropagateMouseClicks(true)
		frameFULL:SetPropagateMouseMotion(true)
		frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
		if 1 ~= 1 then
			frameFULL:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD") -- "auctionhouse-ui-row-highlight"
			frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
			frameFULL.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
		end
		frameFULL:SetPoint("LEFT", frame)
		frameFULL:SetPoint("TOP", frame)
		frameFULL:SetPoint("BOTTOM", frame)
		frameFULL:SetPoint("RIGHT")
		frame.frameFULL = frameFULL
		------------------------------------------------
		frame.settings_button = CreateFrame("BUTTON", nil, frame)
		local texture = frame.settings_button:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("TOPLEFT", 1, -1)
		texture:SetSize(LINE_HEIGHT-2, LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		-- Сохраняем текстуру в кнопке и во фрейме
		frame.settings_button.icon_settings_texture = texture
		frame.icon_settings_texture = texture
		-- Настраиваем КНОПКУ (settings_button), а не текстуру!
		frame.settings_button:SetSize(LINE_HEIGHT, LINE_HEIGHT)
		frame.settings_button:SetPoint("TOPLEFT", 1, -1)
		frame.settings_button:RegisterForClicks("LeftButtonUp")
		frame.settings_button:EnableMouse(true)
		------------------------------------------------
		frame.icon_1 = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		frame.icon_1:SetPoint("TOPLEFT", 1, -1)
		frame.icon_1:SetSize(LINE_HEIGHT-2, LINE_HEIGHT-2)
		frame.icon_1:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		------------------------------------------------
		-- Текстовое поле для левой колонки
		frame.textLEFT = frame:CreateFontString()
		frame.textLEFT:SetFontObject(OctoFont11)
		frame.textLEFT:SetPoint("LEFT", LINE_HEIGHT+INDENT_TEST+0, 0)
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
		-- frame:SetScript("OnEnter", func_OnEnter)






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

function E.func_icon_settings_OnClick(button, frameData)
	local dataType, id = ("#"):split(frameData.settingsType)

	-- Получаем таблицу настроек для типа
	local settingsTable = Octo_ToDo_DB_VisualUserSettings[dataType]
	if not settingsTable then return end

	-- Определяем ключ (строковый или числовой)
	local key = id
	if settingsTable[tonumber(id)] ~= nil then
		key = tonumber(id)
	end

	-- Если запись существует, переключаем, иначе создаем с true
	local newValue = not (settingsTable[key] or false)
	settingsTable[key] = newValue

	-- print("Настройка обновлена:", dataType, key, "=", newValue)

	-- Обновляем текстуру
	local texture = newValue and
	"Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonONgreen" or
	"Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFred"
	button.icon_settings_texture:SetTexture(texture)
end

-- Функция инициализации данных для левой колонки
function EventFrame:Octo_Frame_initLEFT(frame, node)
	local frameData = node:GetData()
	if frameData.iconLEFT then
		frame.icon_1:SetTexture(frameData.iconLEFT)
	else
		frame.icon_1:SetTexture("Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\spacerEMPTY")
	end
	if Octo_ToDo_DB_VisualUserSettings.SettingsEnabled and frameData.settingsType then
		local dataType, id = ("#"):split(frameData.settingsType)
		local texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\spacerEMPTY"

		if Octo_ToDo_DB_VisualUserSettings[dataType][id] or Octo_ToDo_DB_VisualUserSettings[dataType][tonumber(id)] then
			texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonONgreen"
		else
			texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFred"
		end
		frame.icon_settings_texture:SetTexture(texture)
		frame.icon_1:Hide()
		frame.settings_button:Show()
	else
		frame.icon_1:Show()
		frame.settings_button:Hide()
	end

	frame.settings_button:SetScript("OnClick", function(self)
			E.func_icon_settings_OnClick(self, frameData)
	end)

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

	frame:SetScript("OnEnter", function()
			if frameData.settingsType then
				frame.tooltip = E.func_KeyTooltip_LEFT(frameData.settingsType)
			else
				frame.tooltip = nil
			end
			E.func_OctoTooltip_OnEnter(frame, {"RIGHT", "LEFT"})
	end)


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
				secondFrame.ReputTextureAndBG:Show()
				secondFrame.ReputTextureAndBG:SetVertexColor(r1, g1, b1, .3)
				if frameData.isReputation and frameData.FIRSTrep and tonumber(frameData.FIRSTrep[i]) ~= 0 then
					local FIRSTrep = tonumber(frameData.FIRSTrep[i])
					local SECONDrep = tonumber(frameData.SECONDrep[i])
					if FIRSTrep == SECONDrep then
						secondFrame.ReputTextureAndBG:SetWidth(columnWidth)
					elseif FIRSTrep >= 1 then
						secondFrame.ReputTextureAndBG:SetWidth(columnWidth/SECONDrep*FIRSTrep)
					end
				elseif frameData.isReputation and frameData.FIRSTrep and tonumber(frameData.FIRSTrep[i]) == 0 then
					secondFrame.ReputTextureAndBG:Hide()
				else
					secondFrame.ReputTextureAndBG:SetWidth(columnWidth)
				end
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
		secondFrame:SetScript("OnEnter", function()
				if frameData.settingsType and frameData.GUID[i] then
					secondFrame.tooltip = E.func_KeyTooltip_RIGHT(frameData.GUID[i], frameData.settingsType)
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
	Octo_MainFrame_ToDo:SetPoint("TOP", 0, -E.PHYSICAL_SCREEN_WIDTH*.12)
	-- Octo_MainFrame_ToDo:SetPoint("CENTER")
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			RequestRaidInfo()
			E.func_Collect_All()
			EventFrame:CreateDataProvider()
			E.func_SmoothBackgroundAlphaChange(Octo_MainFrame_ToDo, Octo_MainFrame_ToDo_Background, "OnShow")
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
	Octo_MainFrame_ToDo:SetBackdrop(nil)
	-- Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	-- Octo_MainFrame_ToDo:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	-- Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка взаимодействия с фреймом
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	-- Обработчики перемещения фрейма
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				-- Octo_MainFrame_ToDo:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnDrag or E.backgroundColorA)
				-- UIFrameFadeOut(Octo_MainFrame_ToDo, 0.2, Octo_MainFrame_ToDo:GetAlpha(), Octo_ToDo_DB_Vars.Config_AlphaOnDrag or E.backgroundColorA)
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
			-- HeaderFrameLEFT.text:SetText(E.func_texturefromIcon(E.ICON_FACTION).."Weekly Reset: "..E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetWeeklyReset()).."|r")
			HeaderFrameLEFT.text:SetText(E.Purple_Color.."Weekly Reset:|r "..E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetWeeklyReset(), true).."|r ")
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
	columnWidthsLEFT[1] = math.ceil(sampleFrameLEFT.textLEFT:GetStringWidth()) + INDENT_LEFT + LINE_HEIGHT -- (иконка)
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

-- Функция создания и обновления провайдера данных
function EventFrame:CreateDataProvider()
	-- EventFrame.COLUMN_SIZES_LEFT = EventFrame.COLUMN_SIZES_LEFT or {}
	-- EventFrame.COLUMN_SIZES_RIGHT = EventFrame.COLUMN_SIZES_RIGHT or {}
	for dropdownOrder in next,(E.OctoTables_Vibor) do
		E.func_ResetOtrisovkaTables(dropdownOrder)
	end
	E.func_LoadComponents()
	-- E.ebanieMounti(15)
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
	local firstChar = tbl[1]
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- Определяем порядок обработки типов данных
	local typeOrder_Constant = {
		"Additionally", -- 3. Адишинал
		"UniversalQuests",-- 4. Универсал
		"Currencies", -- 1. Валюта
		"Items", -- 2. Итемы
		"Reputations", -- 5. Репа
	}
	----------------------------------------------------------------
	for dropdownOrder in next,(E.OctoTables_Vibor) do
		if Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then
			-- Обрабатываем типы данных в нужном порядке
			for _, dataType in ipairs(typeOrder_Constant) do
				-- for dataType in next,(E.OctoTables_DataOtrisovka[dropdownOrder]) do
				for i, id in next,(E.OctoTables_DataOtrisovka[dropdownOrder][dataType]) do
					local questKey
					if dataType == "UniversalQuests" then
						-- id это data для universal
						questKey = E.UNIVERSAL..id.desc.."_"..id.name_save.."_"..id.reset
					end

					if dataType ~= "UniversalQuests" and E.func_ShouldShow(id, dataType) or E.func_ShouldShow(questKey, dataType) then
						totalLines = totalLines + 1
						local zxc = {
							textLEFT = {},
							colorLEFT = {},
							iconLEFT = {},
							settingsType = {},
							tooltipKey = {},
							isReputation = {},

							textCENT = {},
							colorCENT = {},
							FIRSTrep = {},
							SECONDrep = {},

							GUID = {},
						}
						-- Заполнение данных для левой колонки (берется из первого персонажа)
						if firstChar then
							local textLEFT,    colorLEFT,    iconLEFT,    settingsType,    tooltipKey,    isReputation = E.func_Otrisovka_LEFT_Dispatcher(dropdownOrder, firstChar, dataType, id)
							zxc.iconLEFT = iconLEFT
							zxc.textLEFT = textLEFT or "NONE"
							zxc.colorLEFT = colorLEFT or E.Blue_Color
							zxc.settingsType = settingsType
							-- zxc.tooltipKey = tooltipKey
							zxc.isReputation = isReputation or false
						end
						-- Заполнение данных для каждого персонажа
						for CharIndex, CharInfo in ipairs(tbl) do
							-- local _, _, _, textCENT, _, colorCENT, _, _, _, FIRSTrep, SECONDrep = func(CharInfo)
							local textCENT,    colorCENT,    FIRSTrep,    SECONDrep = E.func_Otrisovka_RIGHT_Dispatcher(dropdownOrder, CharInfo, dataType, id)

							zxc.textCENT[CharIndex] = textCENT
							zxc.colorCENT[CharIndex] = colorCENT
							zxc.GUID[CharIndex] = CharInfo.PlayerData.GUID
							zxc.FIRSTrep[CharIndex] = FIRSTrep or 0
							zxc.SECONDrep[CharIndex] = SECONDrep or 0

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
				end


			end


		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- Обработка данных для каждой строки
	-- for _, func in ipairs(E.func_Concat_Otrisovka(firstChar)) do
	-- totalLines = totalLines + 1
	-- local zxc = {
	-- iconLEFT = {},
	-- textLEFT = {},
	-- colorLEFT = {},
	-- textCENT = {},
	-- colorCENT = {},
	-- tooltipKey = {},
	-- GUID = {},
	-- isReputation = {},
	-- FIRSTrep = {},
	-- SECONDrep = {},
	-- settingsType = {},
	-- }
	-- -- Заполнение данных для каждого персонажа
	-- for CharIndex, CharInfo in ipairs(tbl) do
	-- local _, _, _, textCENT, _, colorCENT, _, _, _, FIRSTrep, SECONDrep = func(CharInfo)
	-- zxc.textCENT[CharIndex] = textCENT
	-- zxc.colorCENT[CharIndex] = colorCENT
	-- zxc.GUID[CharIndex] = CharInfo.PlayerData.GUID
	-- zxc.FIRSTrep[CharIndex] = FIRSTrep or 0
	-- zxc.SECONDrep[CharIndex] = SECONDrep or 0
	-- end
	-- -- Заполнение данных для левой колонки (берется из первого персонажа)
	-- if firstChar then
	-- local iconLEFT, textLEFT, colorLEFT, _, settingsType, _, tooltipKey, isReputation = func(firstChar)
	-- zxc.iconLEFT = iconLEFT
	-- zxc.textLEFT = textLEFT or "NONE"
	-- zxc.colorLEFT = colorLEFT or E.Blue_Color
	-- zxc.tooltipKey = tooltipKey
	-- zxc.isReputation = isReputation or false
	-- zxc.settingsType = settingsType
	-- end
	-- -- Установка дополнительных параметров
	-- zxc.currentCharacterIndex = currentCharacterIndex
	-- zxc.totalColumns = totalColumns
	-- -- Вставка данных в провайдер
	-- local node = DataProvider:Insert(zxc)
	-- -- Расчет ширины колонок
	-- for j, w in ipairs(calculateColumnWidthsLEFT(node, totalLines)) do
	-- COLUMN_SIZES_LEFT[j] = math_max(w, COLUMN_SIZES_LEFT[j] or HeaderFrameLEFT.text:GetWidth() or 0)
	-- end
	-- local rightWidths = calculateColumnWidthsRIGHT(node, totalLines)
	-- for i, w in ipairs(rightWidths) do
	-- COLUMN_SIZES_RIGHT[i] = math_max(w, COLUMN_SIZES_RIGHT[i] or MIN_LINE_WIDTH_CENT)
	-- end
	-- end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------



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
	-- EventFrame.HorizontalScrollBar:SetScrollPercentage(0)
	-- Octo_MainFrame_ToDo.ScrollBoxCENT:ScrollToElementDataIndex(1)
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
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	AlertFrame:ClearAllPoints()
	AlertFrame:SetPoint("BOTTOMLEFT", 200, 300)
	EventFrame:Octo_Create_MainFrame()
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