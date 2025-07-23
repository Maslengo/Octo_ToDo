local GlobalAddonName, E = ...
------------------------------------------------------------------------------
-- Создаем фреймы для работы аддона
local Octo_Event_TESTFRAME = CreateFrame("FRAME") -- Фрейм для обработки событий
Octo_Event_TESTFRAME:Hide()
------------------------------------------------------------------------------
-- "Smart" Anchoring
------------------------------------------------------------------------------
local function GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then
		return "TOPLEFT", "BOTTOMLEFT"
	end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf .. hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP") .. hhalf
end
function Octo_Event_TESTFRAME:SmartAnchorTo(frame)
	if not frame then
		error("Invalid frame provided.", 2)
	end
	tooltip:ClearAllPoints()
	tooltip:SetClampedToScreen(true)
	tooltip:SetPoint(GetTipAnchor(frame))
end
------------------------------------------------------------------------------
function Octo_Event_TESTFRAME:CreateMainFrame()
	local function func_OnClick(frame)
		tooltip:SetShown(not tooltip:IsShown())
	end
	----------------------------------------------------------------
	local MainFrame = CreateFrame("BUTTON", "MainFrame", UIParent)
	MainFrame:SetPoint("CENTER")
	MainFrame:SetSize(64, 64)
	MainFrame.tex = MainFrame:CreateTexture()
	MainFrame.tex:SetAllPoints(MainFrame)
	MainFrame.tex:SetTexture("interface/icons/inv_mushroom_11")
	MainFrame:SetScript("OnClick", func_OnClick)
	MainFrame:EnableMouse(true)
	MainFrame:SetMovable(true)
	-- Обработчики перемещения фрейма
	MainFrame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				MainFrame:SetAlpha(.5)
				MainFrame:StartMoving()
			end
	end)
	MainFrame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				MainFrame:SetAlpha(1)
				MainFrame:StopMovingOrSizing()
			end
	end)
	MainFrame.tooltip = {}
end
------------------------------------------------------------------------------
-- Конфигурация
local MAX_ROWS = 30 -- Максимальное количество строк до появления прокрутки
local ROW_HEIGHT = 16 -- Высота одной строки
local COLUMN_WIDTH = 155 -- Ширина колонки по умолчанию
local PADDING = 10 -- Отступы внутри тултипа
local SCROLLBAR_WIDTH = 16 -- Ширина полосы прокрутки
------------------------------------------------------------------------------
function Octo_Event_TESTFRAME:CreateTooltipFrame()
	local tooltip = CreateFrame("FRAME", "tooltip", UIParent, "BackdropTemplate")
	tooltip:Hide()
	tooltip:SetFrameStrata("TOOLTIP")
	tooltip:SetSize(400, ROW_HEIGHT * MAX_ROWS + PADDING * 2)
	tooltip:SetPoint("CENTER")
	tooltip:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			-- tile = true, tileSize = 16,
			-- insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	tooltip:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	tooltip:SetBackdropBorderColor(0, 0, 0, 1)
	self:SmartAnchorTo(MainFrame)
	-- Заголовок тултипа
	tooltip.Header = tooltip:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	tooltip.Header:SetFontObject(OctoFont11)
	tooltip.Header:SetPoint("TOP", tooltip, "TOP", 0, -PADDING)
	tooltip.Header:SetText("Custom tooltip")
	-- Полоса прокрутки
	tooltip.ScrollFrame = CreateFrame("ScrollFrame", nil, tooltip, "UIPanelScrollFrameTemplate")
	tooltip.ScrollFrame:SetPoint("TOPLEFT", tooltip, "TOPLEFT", PADDING, -PADDING - ROW_HEIGHT)
	tooltip.ScrollFrame:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -PADDING - SCROLLBAR_WIDTH, PADDING)
	-- Контейнер для строк
	tooltip.Content = CreateFrame("Frame", nil, tooltip.ScrollFrame)
	tooltip.Content:SetSize(1, 1) -- Временный размер
	tooltip.ScrollFrame:SetScrollChild(tooltip.Content)
	-- Кнопки для перемещения вверх/вниз
	tooltip.ScrollUpButton = CreateFrame("Button", nil, tooltip, "UIPanelScrollUpButtonTemplate")
	tooltip.ScrollUpButton:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT", -PADDING, -PADDING - ROW_HEIGHT)
	tooltip.ScrollUpButton:SetScript("OnClick", function()
			local scrollBar = tooltip.ScrollFrame.ScrollBar
			scrollBar:SetValue(scrollBar:GetValue() - ROW_HEIGHT * 3)
	end)
	tooltip.ScrollDownButton = CreateFrame("Button", nil, tooltip, "UIPanelScrollDownButtonTemplate")
	tooltip.ScrollDownButton:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -PADDING, PADDING)
	tooltip.ScrollDownButton:SetScript("OnClick", function()
			local scrollBar = tooltip.ScrollFrame.ScrollBar
			scrollBar:SetValue(scrollBar:GetValue() + ROW_HEIGHT * 3)
	end)
	-- Создаем строки заранее
	tooltip.Rows = {}
	for i = 1, MAX_ROWS do -- Создаем с запасом
		local row = CreateFrame("Frame", nil, tooltip.Content)
		row:SetSize(1, ROW_HEIGHT)
		row:SetPoint("LEFT", tooltip.Content, "LEFT")
		row:SetPoint("RIGHT", tooltip.Content, "RIGHT")
		if i == 1 then
			row:SetPoint("TOP", tooltip.Content, "TOP")
		else
			row:SetPoint("TOP", tooltip.Rows[i-1], "BOTTOM")
		end
		----------------
		-- Текстовые поля для трех колонок
		row.Column1 = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		row.Column1:SetFontObject(OctoFont11)
		row.Column1:SetWordWrap(false)
		row.Column1:SetPoint("LEFT", row, "LEFT", 5, 0)
		row.Column1:SetWidth(COLUMN_WIDTH)
		row.Column1:SetJustifyH("LEFT")
		----------------
		row.Column2 = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		row.Column2:SetFontObject(OctoFont11)
		row.Column2:SetWordWrap(false)
		row.Column2:SetPoint("LEFT", row.Column1, "RIGHT", 5, 0)
		row.Column2:SetWidth(COLUMN_WIDTH)
		row.Column2:SetJustifyH("CENTER")
		----------------
		row.Column3 = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		row.Column3:SetFontObject(OctoFont11)
		row.Column3:SetWordWrap(false)
		row.Column3:SetPoint("LEFT", row.Column2, "RIGHT", 5, 0)
		row.Column3:SetWidth(COLUMN_WIDTH)
		row.Column3:SetJustifyH("RIGHT")
		----------------
		tooltip.Rows[i] = row
	end
end
-- Функция для обновления тултипа
function Octo_Event_TESTFRAME:SetData(header, data)
	tooltip.Header:SetText(header or "Custom Tooltip")
	local numRows = #data
	local contentHeight = numRows * ROW_HEIGHT
	tooltip.Content:SetSize(1, contentHeight)

	local SIZES1 = {}
	local SIZES2 = {}
	local SIZES3 = {}
	-- Обновляем данные в строках
	for i, row in ipairs(tooltip.Rows) do
		if i <= numRows then
			local rowData = data[i]
			row.Column1:SetText(rowData[1] or "")
			tinsert(SIZES1, row.Column1:GetStringWidth())

			row.Column2:SetText(rowData[2] or "")
			tinsert(SIZES2, row.Column2:GetStringWidth())

			row.Column3:SetText(rowData[3] or "")
			tinsert(SIZES3, row.Column3:GetStringWidth())

		end
	end

	local max1 = math.max(unpack(SIZES1)) or 1
	local max2 = math.max(unpack(SIZES2)) or 1
	local max3 = math.max(unpack(SIZES3)) or 1
	local total = max1+max2+max3
	tooltip:SetSize(total+50, ROW_HEIGHT * MAX_ROWS + PADDING * 2)
	-- row.Column1:SetSize(max1)
	-- row.Column2:SetSize(max2)
	-- row.Column3:SetSize(max3)



	-- Показываем/скрываем элементы прокрутки
	local showScroll = numRows > MAX_ROWS
	tooltip.ScrollFrame.ScrollBar:SetShown(showScroll)
	tooltip.ScrollUpButton:SetShown(showScroll)
	tooltip.ScrollDownButton:SetShown(showScroll)
	if showScroll then
		tooltip.ScrollFrame.ScrollBar:SetMinMaxValues(0, contentHeight - MAX_ROWS * ROW_HEIGHT)
		tooltip.ScrollFrame.ScrollBar:SetValue(0)
	end
end
------------------------------------------------------------------------------
function Octo_Event_TESTFRAME:CreatetooltipDATAFrame()
	local text1 = "ЙЦУЙЦУ"
	local text2 = "PRIVET"
	local width, height, indent = 10, 20, 15 -- Ширина, высота, отступ
	local tooltipDATA = CreateFrame("FRAME", "tooltipDATA", UIParent)
	tooltipDATA:Hide()
	tooltipDATA:SetPoint("CENTER")
	tooltipDATA.textLeft = tooltipDATA:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	tooltipDATA.textLeft:SetPoint("LEFT")
	tooltipDATA.textLeft:SetFontObject(OctoFont11)
	tooltipDATA.textLeft:SetWordWrap(false)
	tooltipDATA.textLeft:SetJustifyV("MIDDLE")
	tooltipDATA.textLeft:SetJustifyH("CENTER")
	tooltipDATA.textLeft:SetTextColor(1, 1, 1, 1)
	tooltipDATA.textLeft:SetText(text1)
	tooltipDATA.textRight = tooltipDATA:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	tooltipDATA.textRight:SetPoint("RIGHT")
	tooltipDATA.textRight:SetFontObject(OctoFont11)
	tooltipDATA.textRight:SetWordWrap(false)
	tooltipDATA.textRight:SetJustifyV("MIDDLE")
	tooltipDATA.textRight:SetJustifyH("CENTER")
	tooltipDATA.textRight:SetTextColor(1, 1, 1, 1)
	tooltipDATA.textRight:SetText(text1)
	if text1 and text1 ~= "" then
		width = width + tooltipDATA.textLeft:GetStringWidth() -- GetStringWidth / GetWidth
	end
	if text2 and text2 ~= "" then
		width = width + tooltipDATA.textRight:GetStringWidth() -- GetStringWidth / GetWidth
	end
end
------------------------------------------------------------------------------
function Octo_Event_TESTFRAME:AddDataToTooltip()
	local tooltip = {}
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		tooltip[#tooltip+1] = {CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r ("..CharInfo.PlayerData.curServer..")", E.Green_Color..(CharInfo.PlayerData.guildName or "").."|r", E.Green_Color..(CharInfo.PlayerData.guildRankName or "").."|r"}
	end
	Octo_Event_TESTFRAME:SetData("PLAYERS", tooltip)
end
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_Event_TESTFRAME, MyEventsTable)
-- Обработчик события загрузки аддона
function Octo_Event_TESTFRAME:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	C_Timer.After(0, function()
			self:CreateMainFrame()
			self:CreateTooltipFrame()
			self:CreatetooltipDATAFrame()
			self:AddDataToTooltip()
	end)
end
-- local function CreateDropDownMenuList(parent)
--     local menu = CreateFrame("FRAME", nil, parent)
--     menu:Hide()
--     menu:EnableMouse(true)
--     menu:SetClampedToScreen(true)
--     menu:SetFrameStrata("FULLSCREEN_DIALOG")
--     menu:SetScript("OnHide", DropDownMenuList_OnHide)
--     menu.scrollFrame = CreateFrame("ScrollFrame", nil, menu)
--     menu.scrollFrame:SetPoint("TOPLEFT", 15, -15)
--     menu.scrollFrame:SetScript("OnVerticalScroll", DropDownMenuListScrollFrame_OnVerticalScroll)
--     menu.scrollFrame:SetScript("OnScrollRangeChanged", DropDownMenuListScrollFrame_OnScrollRangeChanged)
--     menu.scrollFrame:SetScript("OnMouseWheel", DropDownMenuListScrollFrame_OnMouseWheel)
--     menu.scrollFrame:SetScript("OnEnter", DropDownMenuListScrollFrame_OnEnter)
--     menu.scrollBar = CreateFrame("EventFrame", nil, menu, "MinimalScrollBar")
--     menu.scrollFrame.scrollBar = menu.scrollBar
--     menu.scrollBar:SetPoint("TOPLEFT", menu.scrollFrame, "TOPRIGHT", 6, 0)
--     menu.scrollBar:SetPoint("BOTTOMLEFT", menu.scrollFrame, "BOTTOMRIGHT", 6, 0)
--     menu.scrollBar:RegisterCallback(menu.scrollBar.Event.OnScroll, DropDownMenuListScrollBar_OnScroll, menu.scrollFrame)
--     menu.scrollBar:HookScript("OnEnter", DropDownMenuListScrollBar_OnEnter)
--     menu.scrollBar.Back:HookScript("OnEnter", DropDownMenuListScrollBarControl_OnEnter)
--     menu.scrollBar.Forward:HookScript("OnEnter", DropDownMenuListScrollBarControl_OnEnter)
--     menu.scrollBar.Track:HookScript("OnEnter", DropDownMenuListScrollBarControl_OnEnter)
--     menu.scrollBar.Track.Thumb:HookScript("OnEnter", DropDownMenuListScrollBarThumb_OnEnter)
--     menu.scrollChild = CreateFrame("FRAME")
--     menu.scrollChild:SetSize(1, 1)
--     menu.scrollFrame:SetScrollChild(menu.scrollChild)
--     menu.scrollFrame.scrollChild = menu.scrollChild
--     menu.scrollBar.scrollChild = menu.scrollChild
--     menu.styles = {}
--     for name, frameFunc in next, menuStyles do
--         v.createMenuStyle(menu, name, frameFunc)
--     end
--     menu.activeStyle = menu.styles[v.defaultStyle]
--     return menu
-- end