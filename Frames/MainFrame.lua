local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame.searchFilter = nil
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
E.func_RegisterFrame(Octo_MainFrame_ToDo)
-- Создаем отдельный фрейм для фона
local Octo_MainFrame_ToDo_Background = CreateFrame("FRAME", "Octo_MainFrame_ToDo_Background", Octo_MainFrame_ToDo, "BackdropTemplate")
local SearchBox = CreateFrame("EditBox", "Octo_SearchBox", Octo_MainFrame_ToDo, "SearchBoxTemplate") -- SearchBoxTemplate, InputBoxTemplate
local NewSettingsButton = CreateFrame("CheckButton", "NewSettingsButton", Octo_MainFrame_ToDo, "UICheckButtonTemplate")
----------------------------------------------------------------
-- Константы для настройки интерфейса
local INDENT_LEFT = 10
local INDENT_TEXT = 4 -- Отступ для текста
local MIN_COLUMN_WIDTH_LEFT = 200 -- Минимальная ширина левой колонки
local MIN_COLUMN_WIDTH_Center = 100 -- Минимальная ширина центральной колонки
local MAX_DISPLAY_LINES = E.MAX_DISPLAY_LINES -- Максимальное количество строк
local MAX_FRAME_WIDTH = E.PHYSICAL_SCREEN_WIDTH*.8 -- Максимальная ширина фрейма (80% экрана)
local MAX_FRAME_HEIGHT = E.PHYSICAL_SCREEN_HEIGHT*.7 -- Максимальная высота фрейма (60% экрана)
EventFrame.MAX_COLUMN_COUNT = 113 -- Максимальное количество колонок
-- Цветовые настройки
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1 -- Цвет границы (черный)
local textR, textG, textB, textA = 1, 1, 1, 1 -- Цвет текста (белый)
local classR, classG, classB = GetClassColor(E.classFilename) -- Цвет класса игрока
local LEFT_TEXTURE_ALPHA = .05 -- Прозрачность текстуры левой колонки
local charR, charG, charB = 1, 1, 1
-- Создание фрейма для заголовка левой колонки
local WeeklyResetFrameLeft = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo)
local function SafeTooltipShow(frame, ...)
	if Octo_MainFrame_ToDo:IsShown() then
		E.func_OctoTooltip_OnEnter(frame, ...)
	end
end
local func_OnAcquiredLeft do
	-- ИКОНКА НАСТРОЕК
	-- ИКОНКА КАТЕГОРИЙ
	-- ТЕКСТ КАТЕРГРИИ
	local function Create_SettingsButton(frame)
		frame.SettingsButton = CreateFrame("BUTTON", nil, frame)
		frame.SettingsButton:Hide()
		frame.SettingsButton:SetPropagateMouseClicks(true)
		frame.SettingsButton:SetPropagateMouseMotion(true)
		frame.SettingsButton:SetSize(E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
		-- frame.SettingsButton:SetPoint("TOPLEFT", 1, -1)
		frame.SettingsButton:SetPoint("LEFT", 1, -1)
		frame.SettingsButton:RegisterForClicks("LeftButtonUp")
		frame.SettingsButton:EnableMouse(true)
		local texture = frame.SettingsButton:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		-- texture:SetTexCoord(.10, .90, .10, .90)
		frame.SettingsTexture = texture
		frame.SettingsButton:SetCollapsesLayout(true)
	end
	local function Create_icon1frame(frame)
		frame.icon1frame = CreateFrame("FRAME", nil, frame)
		frame.icon1frame:Hide()
		frame.icon1frame:SetPoint("LEFT", frame.SettingsButton, "RIGHT")
		frame.icon1frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon1frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		frame.icon1texture = texture
		frame.icon1frame:SetCollapsesLayout(true)
	end
	local function Create_icon2frame(frame)
		frame.icon2frame = CreateFrame("FRAME", nil, frame)
		frame.icon2frame:Hide()
		frame.icon2frame:SetPoint("LEFT", frame.icon1frame, "RIGHT")
		frame.icon2frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon2frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		frame.icon2texture = texture
		frame.icon2frame:SetCollapsesLayout(true)
	end
	local function Create_icon3frame(frame)
		frame.icon3frame = CreateFrame("FRAME", nil, frame)
		frame.icon3frame:Hide()
		frame.icon3frame:SetPoint("LEFT", frame.icon2frame, "RIGHT")
		frame.icon3frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon3frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		-- texture:SetTexCoord(.10, .90, .10, .90)
		frame.icon3texture = texture
		frame.icon3frame:SetCollapsesLayout(true)
	end
	local function Create_TextLeft(frame)
		frame.TextLeft = frame:CreateFontString()
		frame.TextLeft:SetFontObject(OctoFont11)
		frame.TextLeft:SetPoint("LEFT", frame.icon3frame, "RIGHT")
		-- frame.TextLeft:SetPoint("LEFT", E.GLOBAL_LINE_HEIGHT+INDENT_TEXT+0, 0)
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
		Create_SettingsButton(frame)
		Create_icon1frame(frame)
		Create_icon2frame(frame)
		Create_icon3frame(frame)
		Create_TextLeft(frame) -- Текстовое поле для левой колонки
		Create_TextureLeft(frame) -- Текстура для фона левой колонки
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
		columnFrame.CurrentCharBackground:SetVertexColor(classR, classG, classB, E.CHARACTER_ALPHA)
		columnFrame.CurrentCharBackground:Hide()
	end
	local function Create_ReputationBackground(columnFrame)
		columnFrame.ReputationBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.ReputationBackground:SetPoint("LEFT")
		columnFrame.ReputationBackground:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame.ReputationBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.ReputationBackground:SetVertexColor(classR, classG, classB, E.REPUTATION_ALPHA)
		columnFrame.ReputationBackground:Hide()
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
						columnFrame:Hide()
						Create_CurrentCharBackground(columnFrame) -- Текстура для фона текущего персонажа
						Create_ReputationBackground(columnFrame)-- Текстура для фона репутации
						Create_TextCenter(columnFrame) -- Текстовое поле для центральной колонки
						AdditionalSettings(columnFrame, frame)
						-- Обработчики скрытия
						columnFrame:SetScript("OnHide", function()
								columnFrame:Hide()
						end)
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
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
		id = tonumber(id)
	end
	-- Инициализация таблицы если нужно
	if not Octo_profileKeys.profiles[E.CurrentProfile][dataType] then
		Octo_profileKeys.profiles[E.CurrentProfile][dataType] = {}
	end
	local settingsTable = Octo_profileKeys.profiles[E.CurrentProfile][dataType]
	-- Простое переключение
	local newValue = not (settingsTable[id] or false)
	settingsTable[id] = newValue
	-- Обновление текстуры
	local texture = newValue and "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonONgreen" or "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonOFFred"
	button:GetParent().SettingsTexture:SetTexture(texture)
end
local function func_Setup_Currencies(frame, id)
	local icon1 = E.func_GetCurrencyIcon(id)
	frame.icon1texture:SetTexture(icon1)
	frame.icon1frame:Show()
	if C_CurrencyInfo.IsAccountWideCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		frame.icon3frame:Show()
	elseif C_CurrencyInfo.IsAccountTransferableCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_TRANSFERABLE, false)
		frame.icon3frame:Show()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame.icon3frame:Hide()                                -- ОБЯЗАТЕЛЬНО!
	end
end
local function func_Setup_Reputations(frame, id)
	-- Первая иконка
	frame.icon1texture:SetTexture(E.ICON_TABARD) -- E.func_GetReputationIcon(id)
	-- Вторая иконка
	local factionIcon = E.func_GetReputationSideIcon(id)
	local AdditionalIcon = E.func_GetReputationIcon(id) -- reputationData.icon1 ICON_NIGHTFAE etc
	local ReputationAtlas = E.func_GetReputationAtlas(id)
	if factionIcon then
		frame.icon2texture:SetTexture(factionIcon)
					-- frame.icon2texture:SetAtlas(icon3)
		frame.icon2frame:Show()
	elseif AdditionalIcon then
		frame.icon2texture:SetTexture(AdditionalIcon)
					-- frame.icon2texture:SetAtlas(AdditionalIcon)
		frame.icon2frame:Show()
	elseif ReputationAtlas then
					-- frame.icon2texture:SetTexture(ReputationAtlas)
		frame.icon2texture:SetAtlas(ReputationAtlas)
		frame.icon2frame:Show()
	else
		frame.icon2texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame.icon2frame:Hide()                             -- ОБЯЗАТЕЛЬНО!
	end
	if C_Reputation.IsAccountWideReputation(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		frame.icon3frame:Show()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame.icon3frame:Hide()                                -- ОБЯЗАТЕЛЬНО!
	end
end
local function func_Setup_Items(frame, id)
	local icon1 = E.func_GetItemIcon(id)
	frame.icon1texture:SetTexture(icon1)
	frame.icon1frame:Show()
end
local function func_Setup_Currencies(frame, id)
	local icon1 = E.func_GetCurrencyIcon(id)
	frame.icon1texture:SetTexture(icon1)
	frame.icon1frame:Show()
	if C_CurrencyInfo.IsAccountWideCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		frame.icon3frame:Show()
	elseif C_CurrencyInfo.IsAccountTransferableCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_TRANSFERABLE, false)
		frame.icon3frame:Show()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame.icon3frame:Hide()                                -- ОБЯЗАТЕЛЬНО!
	end
end
local function func_Setup_UniversalQuests(frame, id)
	local IconLeft = nil
	-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
	local reset = id:match("_([^_]+)$")
	if reset == "Daily" then
		IconLeft = E.ICON_DAILY
	elseif reset == "Weekly" then
		IconLeft = E.ICON_WEEKLY
	elseif reset == "Once" then
		IconLeft = E.ICON_ONCE
	elseif reset == "Month" then
		IconLeft = E.ICON_MONTH
	end
	if IconLeft then
		frame.icon3texture:SetAtlas(IconLeft, false)
		frame.icon3frame:Show()
		frame.icon1frame:Hide()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame.icon3frame:Hide()                                -- ОБЯЗАТЕЛЬНО!
		-- frame.icon1frame:Show()                            -- ОБЯЗАТЕЛЬНО!
	end
end
-- Функция инициализации данных для левой колонки
function EventFrame:func_InitLEFT(frame, node)
	local frameData = node:GetData()
	-- Обновление размеров колонки, если они были изменены
	if EventFrame.columnWidthsLeft and EventFrame.columnWidthsLeft[1] then
		local newLeftWidth = math.max(MIN_COLUMN_WIDTH_LEFT, EventFrame.columnWidthsLeft[1])
		Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEXT)
		SearchBox:SetSize(newLeftWidth - INDENT_TEXT - 40, 22)
		frame.TextLeft:SetWidth(newLeftWidth)
	end
	if not frameData.SettingsType then
		frame.SettingsButton:Show() -- не баг а фича
		frame.SettingsButton:Hide() -- не баг а фича
		frame.icon1frame:Show() -- не баг а фича
		frame.icon2frame:Show() -- не баг а фича
		frame.icon3frame:Show() -- не баг а фича
		-- frame.icon1frame:Hide() -- не баг а фича
		frame.icon2frame:Hide() -- не баг а фича
		frame.icon3frame:Hide() -- не баг а фича
		frame.TextLeft:SetText("")
		frame.icon1texture:SetTexture(spacerEMPTY)            -- ОБЯЗАТЕЛЬНО!
		frame:SetScript("OnEnter", function()
				frame.tooltip = nil
		end)
	else
		local dataType, id = ("#"):split(frameData.SettingsType)
		if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
			id = tonumber(id)
		end
		----------------------------------------------------------------
		frame.SettingsButton:Show() -- не баг а фича
		frame.icon1frame:Show() -- не баг а фича
		frame.icon2frame:Show() -- не баг а фича
		frame.icon3frame:Show() -- не баг а фича
		frame.SettingsButton:Hide() -- не баг а фича
		-- frame.icon1frame:Hide() -- не баг а фича (ЧТО БЫ ТЕКСТ ВЫРАВНИВАЛСЯ)
		frame.icon2frame:Hide() -- не баг а фича
		frame.icon3frame:Hide() -- не баг а фича
		----------------------------------------------------------------
		if frameData.IconLeft then
			frame.icon1texture:SetTexture(frameData.IconLeft)
			frame.icon1texture:SetAtlas(frameData.IconLeft, false)
		else
			frame.icon1texture:SetTexture(E.ICON_EMPTY)
		end
		----------------------------------------------------------------
		if dataType == "Currencies" then
			func_Setup_Currencies(frame, id)
		end
		----------------------------------------------------------------
		if dataType == "Items" then
			func_Setup_Items(frame, id)
		end
		----------------------------------------------------------------
		if dataType == "Reputations" then
			func_Setup_Reputations(frame, id)
		end
		if dataType == "RaidsOrDungeons" then
			local name, _, _, _, _, buttonImage2, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(id)
			-- func_Setup_Raids(frame, id)
			if isRaid then
				frame.icon2frame:Show()
				frame.icon2texture:SetAtlas("Raid")
			else
				frame.icon2frame:Show()
				frame.icon2texture:SetAtlas("Dungeon")
			end
			-- frame.icon1frame:Show()
			frame.icon1texture:SetTexture(buttonImage2)
		end
		----------------------------------------------------------------
		if dataType == "UniversalQuests" then
			func_Setup_UniversalQuests(frame, id)
		end
		if Octo_profileKeys.isSettingsEnabled then
			local texture = E.ICON_EMPTY
			if Octo_profileKeys.profiles[E.CurrentProfile][dataType] and Octo_profileKeys.profiles[E.CurrentProfile][dataType][id] ~= nil then
				if Octo_profileKeys.profiles[E.CurrentProfile][dataType][id] or Octo_profileKeys.profiles[E.CurrentProfile][dataType][tonumber(id)] then
					texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonONgreen"
				else
					texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonOFFred"
				end
			end
			frame.SettingsTexture:SetTexture(texture)
			-- frame.icon1texture:Hide()
			frame.SettingsButton:Show()
		else
			-- frame.icon1texture:Show()
			frame.SettingsButton:Hide()
		end
		frame.SettingsButton:SetScript("OnClick", function(self)
				func_SettingsButton_OnClick(self, frameData)
		end)
		local expansionICON = ""
		-- local categoryKey = frameData.categoryKey
		-- if E.OctoTable_Expansions[categoryKey] then
		-- expansionICON = E.func_FormatExpansion(categoryKey, "RIGHT")
		-- end
		-- Установка текста и цвета для левой колонки
		if type(frameData.TextLeft) == "function" then
			frame.TextLeft:SetText(expansionICON..frameData.TextLeft()) -- ← Вызываем функцию!
		else
			frame.TextLeft:SetText(expansionICON..frameData.TextLeft) -- ← Просто строка
		end
		-- frame.TextLeft:SetText(frameData.TextLeft)
		if frameData.ColorLeft then
			local r, g, b = E.func_Hex2RGBFloat(frameData.ColorLeft)
			frame.TextureLeft:SetVertexColor(r, g, b, LEFT_TEXTURE_ALPHA)
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
				SafeTooltipShow(frame, {"RIGHT", "LEFT"})
		end)
	end
end
-- Функция инициализации данных для центральной колонки
function EventFrame:func_InitCenter(frame, node)
	local frameData = node:GetData()
	if not frameData.SettingsType then
		for i = 1, (frameData.totalColumns or 0) do
			----------------------------------------------------------------
			local columnFrames = frame.columnFrames[i]
			if not columnFrames then
				columnFrames = frame.columnFrames[i] -- Это вызовет __index из метатаблицы
			end
			columnFrames.TextCenter:SetText(frameData.TextCenter[i])
			columnFrames:Show()
			----------------------------------------------------------------
			columnFrames:SetScript("OnEnter", function()
					columnFrames.tooltip = nil
			end)
			----------------------------------------------------------------
			columnFrames.ReputationBackground:Hide()
		end
	else
		local dataType, id = ("#"):split(frameData.SettingsType)
		if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
			id = tonumber(id)
		end
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
					columnFrames.ReputationBackground:SetVertexColor(r1, g1, b1)
					if dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) ~= 0 then
						-- ПОФИКСИТЬ НА НОВЫЙ ЛАД
						-- if dataType == "Reputations" then
						--     local GUID = frameData.GUID[i]
						--     local FirstReputation, SecondReputation, repType, colorC, standing = ("#"):split(Octo_ToDo_DB_Levels[GUID].MASLENGO.Reputation[id])
						--     FirstReputation = tonumber(FirstReputation)
						--     SecondReputation = tonumber(SecondReputation)
						local FirstReputation = tonumber(frameData.FirstReputation[i])
						local SecondReputation = tonumber(frameData.SecondReputation[i])
						if FirstReputation == SecondReputation then
							columnFrames.ReputationBackground:SetWidth(columnWidth)
						elseif FirstReputation >= 1 then
							columnFrames.ReputationBackground:SetWidth(columnWidth/SecondReputation*FirstReputation)
						end
					elseif dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) == 0 then
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
				columnFrames.ReputationBackground:SetVertexColor(0, 0, 0)
				columnFrames.CurrentCharBackground:Hide()
			end
			columnFrames:SetScript("OnEnter", function()
					if frameData.SettingsType and frameData.GUID[i] then
						columnFrames.tooltip = E.func_KeyTooltip_RIGHT(frameData.GUID[i], frameData.SettingsType)
					else
						columnFrames.tooltip = nil
					end
					SafeTooltipShow(columnFrames) --, {"LEFT", "RIGHT"}) -- если перс будет справа и тултип со скроллом, то будет габелла
			end)
			columnFrames:Show()
		end
		for i = frameData.totalColumns+1, #frame.columnFrames do
			frame.columnFrames[i]:Hide()
		end
	end
end
local function HeaderFrameLeft_OnShow(frame)
	local text = E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetSecondsToWeeklyReset(), false).."|r"
	frame.Text1:SetText(text)
end
-- Функция создания главного тестового фрейма
function EventFrame:func_CreateMainFrame()
	Octo_MainFrame_ToDo_Background:SetAllPoints()
	Octo_MainFrame_ToDo_Background:SetFrameLevel(Octo_MainFrame_ToDo:GetFrameLevel() - 1) -- Ниже основного фрейма
	Octo_MainFrame_ToDo_Background:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_ToDo_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA) -- E.backgroundColorA
	Octo_MainFrame_ToDo_Background:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка позиции и обработчика показа фрейма
	-- Octo_MainFrame_ToDo:SetPoint("TOP", 0, -E.PHYSICAL_SCREEN_WIDTH*.1)
	-- Octo_MainFrame_ToDo:SetPoint("CENTER")
	Octo_MainFrame_ToDo:SetPoint("TOP", 0, -150)
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			RequestRaidInfo()
			E.func_Collect_All()
			EventFrame:CreateDataProvider()
			-- C_Timer.After(1, function()
			--         E.func_UPDATE_MAINFRAME()
			-- end)
			E.func_SmoothBackgroundAlphaChange(Octo_MainFrame_ToDo, Octo_MainFrame_ToDo_Background, "OnShow")
	end)
	-- Расчет размеров фрейма на основе количества игроков
	local numPlayers = math.min(E.func_CountVisibleCharacters(), EventFrame.MAX_COLUMN_COUNT)
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
	-- Octo_MainFrame_ToDo:SetBackdrop(nil)
	-- Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	-- Octo_MainFrame_ToDo:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
	-- Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Настройка взаимодействия с фреймом
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	----------------------------------------------------------------
	-- РЕЗКОЕ ПЕРЕМЕЩЕНИЕ
	----------------------------------------------------------------
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				-- Octo_MainFrame_ToDo:SetAlpha(E.MOVINGBACKGROUND_ALPHA or E.backgroundColorA)
				-- UIFrameFadeOut(Octo_MainFrame_ToDo, 0.2, Octo_MainFrame_ToDo:GetAlpha(), E.MOVINGBACKGROUND_ALPHA or E.backgroundColorA)
				Octo_MainFrame_ToDo:StartMoving()
			end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				-- Octo_MainFrame_ToDo:SetAlpha(1)
				-- UIFrameFadeIn(Octo_MainFrame_ToDo, 0.2, Octo_MainFrame_ToDo:GetAlpha(), 1)
				Octo_MainFrame_ToDo:StopMovingOrSizing()
				-- local point, _, relativePoint, xOfs, yOfs = Octo_MainFrame_ToDo:GetPoint()
				local left = Octo_MainFrame_ToDo:GetLeft()
				local top = Octo_MainFrame_ToDo:GetTop()
				Octo_MainFrame_ToDo:ClearAllPoints()
				Octo_MainFrame_ToDo:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
				-- Octo_MainFrame_ToDo:SetPoint("TOPLEFT", left, top-UIParent:GetHeight())
			end
	end)
	----------------------------------------------------------------
	-- ПЛАВНОЕ ПЕРЕМЕЩЕНИЕ (что бы во время настройки не перемещать фрейм)
	----------------------------------------------------------------
	-- Octo_MainFrame_ToDo:RegisterForDrag("LeftButton")
	-- Octo_MainFrame_ToDo:SetScript("OnDragStart", function(self, button)
	--     Octo_MainFrame_ToDo:StartMoving()
	-- end)
	-- Octo_MainFrame_ToDo:SetScript("OnDragStop", function(self)
	--     Octo_MainFrame_ToDo:StopMovingOrSizing()
	-- end)
	----------------------------------------------------------------
	-- Обработчик клика правой кнопкой для скрытия фрейма
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", Octo_MainFrame_ToDo.Hide)
	-- Настройка заголовка левой колонки
	WeeklyResetFrameLeft:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT")
	WeeklyResetFrameLeft:SetSize(MIN_COLUMN_WIDTH_LEFT*2, E.GLOBAL_LINE_HEIGHT)
	WeeklyResetFrameLeft.Text1 = WeeklyResetFrameLeft:CreateFontString()
	WeeklyResetFrameLeft.Text1:SetFontObject(OctoFont11)
	WeeklyResetFrameLeft.Text1:SetPoint("LEFT", INDENT_TEXT)
	WeeklyResetFrameLeft.Text1:SetWordWrap(false)
	WeeklyResetFrameLeft.Text1:SetJustifyV("MIDDLE")
	WeeklyResetFrameLeft.Text1:SetJustifyH("LEFT")
	WeeklyResetFrameLeft.Text1:SetTextColor(textR, textG, textB, textA)
	-- Обработчик показа заголовка левой колонки
	WeeklyResetFrameLeft:SetScript("OnShow", HeaderFrameLeft_OnShow)
	local tooltip_WR = {}
	tooltip_WR[#tooltip_WR+1] = {L["Weekly Reset"]}
	WeeklyResetFrameLeft.tooltip = tooltip_WR
	WeeklyResetFrameLeft:SetScript("OnEnter", function()
		SafeTooltipShow(WeeklyResetFrameLeft, {"RIGHT", "LEFT"})
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
function E.func_main_frame_toggle()
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
		local left = Octo_MainFrame_ToDo:GetLeft()
		local top = Octo_MainFrame_ToDo:GetTop()
		Octo_MainFrame_ToDo:ClearAllPoints()
		Octo_MainFrame_ToDo:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
	end
end
-- Функция создания фрейма поиска
function EventFrame:func_CreateSearchBox()
	SearchBox.Border = SearchBox:CreateTexture(nil, "BACKGROUND")
	-- SearchBox.Border:ClearAllPoints()
	SearchBox.Border:SetColorTexture(0, 0, 0, 1)
	SearchBox.Border:SetPoint("TOPLEFT", SearchBox, "TOPLEFT", -5, 0)
	SearchBox.Border:SetPoint("BOTTOMRIGHT", SearchBox, "BOTTOMRIGHT", 0, 0)
	SearchBox.Border:SetDrawLayer("BACKGROUND", -1)
	SearchBox.Background = SearchBox:CreateTexture(nil, "BACKGROUND")
	-- SearchBox.Background:ClearAllPoints()
	SearchBox.Background:SetColorTexture(0.15, 0.15, 0.15, 0.8)
	SearchBox.Background:SetPoint("TOPLEFT", SearchBox, "TOPLEFT", -4, -1)
	SearchBox.Background:SetPoint("BOTTOMRIGHT", SearchBox, "BOTTOMRIGHT", -1, 1)
	----------------------------------------------------------------
	-- Устанавливаем точку привязки и размер
	SearchBox:SetPoint("TOPLEFT", INDENT_TEXT+30, -E.HEADER_TEXT_OFFSET)
	SearchBox:SetSize(MIN_COLUMN_WIDTH_LEFT - INDENT_TEXT - 40, E.GLOBAL_LINE_HEIGHT/2) -- МЕНЯЕТСЯ В ДРУГОМ МЕСТЕ ПРИ АПДЕЙТЕ
	-- SearchBox:SetAlpha(.5)
	SearchBox:SetAutoFocus(false)
	SearchBox:SetFontObject(OctoFont11)
	SearchBox:SetText("")
	-- Скрываем стандартные элементы
	SearchBox.Left:Hide()
	SearchBox.Middle:Hide()
	SearchBox.Right:Hide()
	-- Octo_SearchBoxSearchIcon:Hide()
	-- Вешаем обработчик изменения текста
	SearchBox:HookScript("OnTextChanged", function(self)
			EventFrame:ApplySearchFilter(self:GetText())
	end)
	----------------------------------------------------------------
	-- local texture = SearchBox:CreateTexture(nil, "BACKGROUND", nil, 5)
	-- texture:SetPoint("RIGHT", SearchBox, "LEFT", -4, 0)
	-- texture:SetSize(12, 12)
	-- texture:SetAlpha(.5)
	-- -- texture:SetAtlas("uitools-icon-search")
	-- texture:SetAtlas("common-search-magnifyingglass")
	----------------------------------------------------------------
	NewSettingsButton:SetPoint("RIGHT", SearchBox, "LEFT", -9, 0)
	NewSettingsButton:SetSize(20, 20)
	-- Настраиваем текстуры
	-- NewSettingsButton:SetNormalTexture("common-dropdown-icon-checkmark-yellow")
	-- NewSettingsButton:SetPushedTexture("common-dropdown-tickradial")
	NewSettingsButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	NewSettingsButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	NewSettingsButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	NewSettingsButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	-- Функция для установки состояния с логикой
	NewSettingsButton:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		Octo_profileKeys.isSettingsEnabled = checked
		EventFrame:CreateDataProvider()
	end)
	-- Установка начального состояния
	NewSettingsButton:SetChecked(Octo_profileKeys.isSettingsEnabled or false)
	NewSettingsButton:SetScript("OnShow", function(self)
		NewSettingsButton:SetChecked(Octo_profileKeys.isSettingsEnabled or false)
	end)
	local tooltip = {}
	tooltip[#tooltip+1] = {L["Settings mode"]}
	NewSettingsButton.tooltip = tooltip
	----------------------------------------------------------------
	NewSettingsButton:SetScript("OnEnter", function()
		SafeTooltipShow(NewSettingsButton, {"RIGHT", "LEFT"})
	end)
	----------------------------------------------------------------
	-- Добавляем в основную фрейм
	Octo_MainFrame_ToDo.SearchBox = SearchBox
end
-- Функция применения фильтра поиска
function EventFrame:ApplySearchFilter(searchText)
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.ViewLeft then return end
	-- if searchText == nil or searchText == "" then
	--     EventFrame:func_ResetsearchFilter()
	--     Octo_profileKeys.isSettingsEnabled = false
	-- else
	--     Octo_profileKeys.isSettingsEnabled = true
	-- end
	searchText = searchText and searchText:lower():trim() or ""
	-- Получаем текущий DataProvider
	local dataProvider = Octo_MainFrame_ToDo.ViewLeft:GetDataProvider()
	if not dataProvider then return end
	if searchText == "" then
		EventFrame:func_ResetsearchFilter() -- EventFrame:CreateDataProvider()
		return
	end
	EventFrame.searchFilter = searchText
	EventFrame:CreateDataProvider()
end
function EventFrame:func_ResetsearchFilter()
	EventFrame.searchFilter = nil
	if Octo_MainFrame_ToDo.SearchBox then
		Octo_MainFrame_ToDo.SearchBox:SetText("")
	end
	EventFrame:CreateDataProvider()
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
	columnWidthsLEFT[1] = math.ceil(framesLEFT[1].TextLeft:GetStringWidth()) + INDENT_LEFT + E.GLOBAL_LINE_HEIGHT + E.GLOBAL_LINE_HEIGHT -- (иконка)
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
	-- for i = 1, frameData.totalColumns do
	-- if not sampleFrameCenter.columnFrames[i] then
	--     sampleFrameCenter.columnFrames[i] = sampleFrameCenter.columnFrames[i] -- Вызовет __index
	-- end
	-- end
	for i = 1, frameData.totalColumns do
		-- Инициализация всех подфреймов (раньше было 2 цикла)
		if not sampleFrameCenter.columnFrames[i] then
			sampleFrameCenter.columnFrames[i] = sampleFrameCenter.columnFrames[i] -- Вызовет __index
		end
		-- Расчет ширины для каждой колонки
		if frameData.TextCenter[i] then
			sampleFrameCenter.columnFrames[i].TextCenter:SetText(frameData.TextCenter[i])
			columnWidthsCenter[i] = math.ceil(math.max(
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
	local width1 = math.ceil(math.max(
			frame.Nickname:GetStringWidth() + INDENT_LEFT,
			MIN_COLUMN_WIDTH_Center
	))
	if not Octo_ToDo_DB_Vars.isOnlyCurrentServer then
		frame.Server:SetText(serverTEXT)
		width2 = math.ceil(math.max(
				frame.Server:GetStringWidth() + INDENT_LEFT,
				MIN_COLUMN_WIDTH_Center
		))
	end
	return math.max(width1, width2)
end
local function func_UPDATE_MAINFRAME() -- providerfunc
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() and OctoTooltip and not OctoTooltip:IsShown() then
		EventFrame:CreateDataProvider()
	end
end
function E.func_UPDATE_MAINFRAME()
	E.func_SpamBlock(func_UPDATE_MAINFRAME, true)
end
local function PassSearchFilter(TextLeft, searchText)
	if not searchText or searchText == "" then
		return true
	end
	local text = type(TextLeft) == "function"
	and TextLeft()
	or tostring(TextLeft or "")
	return text:lower():find(searchText:lower(), 1, true) ~= nil
end
-- Функция расчета ширины главного фрейма
local function CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local leftColumnWidth = MIN_COLUMN_WIDTH_LEFT + INDENT_TEXT
	if columnWidthsLeft and columnWidthsLeft[1] then
		leftColumnWidth = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] + INDENT_TEXT)
	end
	local width = leftColumnWidth + totalRightWidth
	-- Делаем ширину четной для лучшего отображения
	if width % 2 == 1 then
		width = width + 1
	end
	return width
end
-- Функция расчета высоты главного фрейма
local function CalculateMainFrameHeight(totalLines)
	local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / E.GLOBAL_LINE_HEIGHT)
	local maxDisplayLines = math.max(1, math.min(totalLines, LINES_TOTAL or totalLines))
	return E.GLOBAL_LINE_HEIGHT * maxDisplayLines + E.HEADER_HEIGHT, maxDisplayLines
end
-- Функция расчета ограниченной ширины правой части
local function CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or EventFrame.MAX_COLUMN_COUNT) do
		local colWidth = columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center
		if (totalRightWidth + colWidth) <= maxRIGHT then
			totalRightWidth = totalRightWidth + colWidth
		else
			break
		end
	end
	return totalRightWidth
end
-- Функция расчета полной ширины правой части
local function CalculateFullRightWidth(columnWidthsCenter, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or EventFrame.MAX_COLUMN_COUNT) do
		totalRightWidth = totalRightWidth + (columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center)
	end
	return totalRightWidth
end
-- Функция создания и обновления провайдера данных
function EventFrame:CreateDataProvider()
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local columnWidthsLeft = {}
	local columnWidthsCenter = {}
	E.func_UpdateCurrentProfile()
	local ExpansionToShowTBL = E.func_GetProfileData("ExpansionToShow")
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
		"RaidsOrDungeons", -- 4. Рейды или данжи
		"UniversalQuests",-- 5. Универсал
		"Reputations", -- 6. Репа
	}
	----------------------------------------------------------------
	-- Расчёт ширины правых фреймпулов
	local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
	for CharIndex, CharInfo in ipairs(sortedCharacters) do
		columnWidthsCenter[CharIndex] = func_calculateColumnWidthsCenter_HEADER(HeaderFrameCenter, E.func_TextCenter_Chars_nickname(CharInfo), E.func_TextCenter_Chars_server(CharInfo))
	end
	Octo_MainFrame_ToDo.pool:Release(HeaderFrameCenter)
	----------------------------------------------------------------
	-- local keys = {}
	-- for categoryKey in next, E.OctoTables_Vibor do
	-- table.insert(keys, categoryKey)
	-- end
	-- for i = #keys, 1, -1 do
	-- local categoryKey = keys[i]
	----------------------------------------------------------------
	for categoryKey in next,(E.OctoTables_Vibor) do
		-----------------------------------------------------------------
		if ExpansionToShowTBL[categoryKey] then
			for _, dataType in ipairs(dataDisplayOrder) do
				for i, id in next,(E.DataProvider_Otrisovka[categoryKey][dataType]) do
					local questKey
					if dataType == "UniversalQuests" then
						questKey = E.UNIVERSAL..id.desc.."_"..id.name_save.."_"..id.reset
					end
					-- можно ли вообще рисовать эту строку
					local canDraw = false
					if dataType ~= "UniversalQuests" then
						canDraw = E.func_ShouldShow(id, dataType, E.CurrentProfile)
					else
						canDraw = E.func_ShouldShow(questKey, dataType, E.CurrentProfile)
					end
					if canDraw then
						local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey =
						E.func_Otrisovka_LEFT_Dispatcher(categoryKey, firstChar, dataType, id)
						-- фильтр поиска
						canDraw = PassSearchFilter(TextLeft, EventFrame.searchFilter)
						if canDraw then
							-- ====== ОДИН БЛОК, БЕЗ ELSE ======
							totalLines = totalLines + 1
							local rowData = {
								TextLeft = TextLeft or "NONE",
								IconLeft = IconLeft,
								ColorLeft = E.OctoTable_Expansions[categoryKey]
								and E.OctoTable_Expansions[categoryKey].color
								or E.COLOR_BLACK,
								SettingsType = SettingsType,
								categoryKey = categoryKey,
								TextCenter = {},
								ColorCenter = {},
								FirstReputation = {},
								SecondReputation = {},
								GUID = {},
								currentCharacterIndex = currentCharacterIndex,
								totalColumns = totalColumns,
							}
							for CharIndex, CharInfo in ipairs(sortedCharacters) do
								local TextCenter, ColorCenter, FIRST, SECOND = E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
								rowData.TextCenter[CharIndex] = TextCenter
								rowData.ColorCenter[CharIndex] = ColorCenter
								rowData.GUID[CharIndex] = CharInfo.PlayerData.GUID
								rowData.FirstReputation[CharIndex] = FIRST or 0
								rowData.SecondReputation[CharIndex] = SECOND or 0
							end
							local node = DataProvider:Insert(rowData)
							for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
								columnWidthsLeft[j] = math.max(MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
							end
							for j, w in ipairs(func_calculateColumnWidthsCenter(node)) do
								columnWidthsCenter[j] = math.max(MIN_COLUMN_WIDTH_Center, w, columnWidthsCenter[j] or MIN_COLUMN_WIDTH_Center)
							end
						end
					end
				end
			end
		end
	end
	-- === FIX: гарантируем хотя бы одну строку ===
	if totalLines == 0 then
		totalLines = 1
		local rowData = {
			TextLeft = "qwe",
			IconLeft = {},
			ColorLeft = {},
			-- SettingsType = {},
			categoryKey = {},
			TextCenter = {},
			ColorCenter = {},
			FirstReputation = {},
			SecondReputation = {},
			GUID = {},
			currentCharacterIndex = 1,
			totalColumns = totalColumns > 0 and totalColumns or 1,
		}
		-- for CharIndex, CharInfo in ipairs(sortedCharacters) do
		--     rowData.TextCenter[CharIndex] = ""
		--     rowData.ColorCenter[CharIndex] = nil
		--     rowData.GUID[CharIndex] = CharInfo.PlayerData.GUID
		--     rowData.FirstReputation[CharIndex] = 0
		--     rowData.SecondReputation[CharIndex] = 0
		-- end
		local node = DataProvider:Insert(rowData)
		columnWidthsLeft[1] = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] or MIN_COLUMN_WIDTH_LEFT)
		for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
			columnWidthsLeft[j] = math.max(MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
		end
		-- for j, w in ipairs(func_calculateColumnWidthsCenter(node)) do
		--     columnWidthsCenter[j] = math.max(MIN_COLUMN_WIDTH_Center, w, columnWidthsCenter[j] or MIN_COLUMN_WIDTH_Center)
		-- end
	end
	-- Сохранение рассчитанных размеров колонок
	EventFrame.columnWidthsLeft = columnWidthsLeft
	EventFrame.columnWidthsCenter = columnWidthsCenter
	-- Обновление интерфейса
	self:UpdateMainFrameUI(DataProvider, totalLines, totalColumns, sortedCharacters, columnWidthsLeft, columnWidthsCenter)
end
-- Функция обновления UI главного фрейма
function EventFrame:UpdateMainFrameUI(DataProvider, totalLines, totalColumns, sortedCharacters, columnWidthsLeft, columnWidthsCenter)
	-- Обновление интерфейса, если фрейм существует
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.scrollContentFrame then return end
	-- Устанавливаем провайдеры данных
	Octo_MainFrame_ToDo.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	Octo_MainFrame_ToDo.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	-- Расчет максимальной доступной ширины для правой части
	local leftColumnWidth = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft and columnWidthsLeft[1] or MIN_COLUMN_WIDTH_LEFT)
	local maxRIGHT = MAX_FRAME_WIDTH - leftColumnWidth - INDENT_TEXT
	-- Гарантируем, что columnWidthsCenter содержит хотя бы минимальные ширины для каждого персонажа
	if #columnWidthsCenter == 0 and totalColumns > 0 then
		for i = 1, totalColumns do
			columnWidthsCenter[i] = MIN_COLUMN_WIDTH_Center
		end
	end
	-- Расчет ширины правой части с ограничением по maxRIGHT
	local totalRightWidth = CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, EventFrame.MAX_COLUMN_COUNT)
	-- Расчет полной ширины для scrollContentFrame (без ограничений)
	local totalRightWidth_scrollContentFrame = CalculateFullRightWidth(columnWidthsCenter, EventFrame.MAX_COLUMN_COUNT)
	-- Расчет размеров фрейма
	local width = CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local height, maxDisplayLines = CalculateMainFrameHeight(totalLines)
	-- Обновляем глобальную переменную
	MAX_DISPLAY_LINES = maxDisplayLines
	----------------------------------------------------------------
	-- Установка размеров фреймов
	Octo_MainFrame_ToDo:SetSize(width, height)
	Octo_MainFrame_ToDo.scrollContentFrame:SetSize(totalRightWidth_scrollContentFrame, height)
	-- Создание заголовков колонок
	self:CreateColumnHeaders(sortedCharacters, columnWidthsCenter)
	-- Обновление позиций подфреймов в центральной колонке
	self:UpdateCenterColumnPositions(columnWidthsCenter)
end
-- Функция создания заголовков колонок персонажей
function EventFrame:CreateColumnHeaders(sortedCharacters, columnWidthsCenter)
	-- Освобождение всех фреймов из пула
	Octo_MainFrame_ToDo.pool:ReleaseAll()
	local accumulatedWidth = 0
	for count, CharInfo in ipairs(sortedCharacters) do
		local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
		local columnWidth = columnWidthsCenter[count] or MIN_COLUMN_WIDTH_Center
		-- Установка позиции и размера заголовка
		HeaderFrameCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.scrollContentFrame, "TOPLEFT", accumulatedWidth, -E.HEADER_HEIGHT)
		HeaderFrameCenter:SetSize(columnWidth, E.HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth
		-- Настройка текста заголовка
		HeaderFrameCenter.Nickname:SetPoint("CENTER", 0, E.HEADER_TEXT_OFFSET)
		if Octo_ToDo_DB_Vars.isOnlyCurrentServer then
			HeaderFrameCenter.Nickname:SetPoint("CENTER")
		end
		HeaderFrameCenter.Nickname:SetWordWrap(false)
		HeaderFrameCenter.Nickname:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Nickname:SetJustifyH("CENTER")
		HeaderFrameCenter.Nickname:SetText(E.func_TextCenter_Chars_nickname(CharInfo))
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
		HeaderFrameCenter.CharTexture:SetVertexColor(charR, charG, charB, E.currentCHAR_ALPHA or 0.2)
		-- Обработчик наведения для отображения тултипа
		HeaderFrameCenter:SetScript("OnEnter", function(self)
				HeaderFrameCenter.tooltip = E.func_Tooltip_Chars(CharInfo)
				SafeTooltipShow(HeaderFrameCenter, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
		HeaderFrameCenter:Show()
	end
end
-- Функция обновления позиций подфреймов в центральной колонке
function EventFrame:UpdateCenterColumnPositions(columnWidthsCenter)
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
	EventFrame:func_CreateMainFrame()
	-- EventFrame:CreateDataProvider()
	-- C_Timer.After(1, function()
	--         Octo_MainFrame_ToDo:Show()
	--         Octo_MainFrame_ToDo:Hide()
	--         local left = Octo_MainFrame_ToDo:GetLeft()
	--         local top = Octo_MainFrame_ToDo:GetTop()
	--         Octo_MainFrame_ToDo:ClearAllPoints()
	--         Octo_MainFrame_ToDo:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
	-- end)
	EventFrame:func_CreateSearchBox()

	E.func_CreateMenuStyle()
	E.func_Create_DDframe_ToDo(Octo_MainFrame_ToDo, E.COLOR_FACTION, function() EventFrame:CreateDataProvider() end)
	E.func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, E.func_main_frame_toggle, "Octo_MainFrame_ToDo")
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