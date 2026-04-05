----------------------------------------------------------------
-- 📦 Корневой контейнер секции
----------------------------------------------------------------
local GlobalAddonName, E = ...
local L = E.L
if not E.DEBUG then return end
----------------------------------------------------------------
local HEIGHT = 724
local WIDTH = 920
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame:Hide()
local Octo_SortUI = CreateFrame("BUTTON", "Octo_SortUI", UIParent, "SettingsFrameTemplate") -- ,OctoBackdropTemplate
Octo_SortUI:Hide()
E.func_RegisterFrame_ICONS(Octo_SortUI)
----------------------------------------------------------------
local btn = CreateFrame("BUTTON", nil, UIParent, "UIPanelButtonTemplate")
btn:SetPoint("TOPLEFT", 0, -32)
btn:SetSize(128, 24)
btn:SetText("Octo_SortUI")
btn:SetScript("OnClick", function(self, button, down)
		Octo_SortUI:SetShown(not Octo_SortUI:IsShown())
end)
btn:RegisterForClicks("LeftButtonUp")
----------------------------------------------------------------
E.SortUI = {}
local SortUI = E.SortUI
SortUI.rows = {}
-- Главный контейнер
function SortUI:Create(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetAllPoints(parent)
	self.frame = frame
	-- ВНУТРЕННИЙ КОНТЕЙНЕР
	frame.Content = CreateFrame("Frame", nil, frame)
	frame.Content:SetPoint("TOPLEFT", 20, -20)
	frame.Content:SetPoint("BOTTOMRIGHT", -20, 20)
	-- Заголовок
	frame.Title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.Title:SetPoint("TOPLEFT", frame.Content, "TOPLEFT", 0, 0)
	frame.Title:SetText("Список персонажей")
	frame.Sub = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	frame.Sub:SetPoint("TOPLEFT", frame.Title, "BOTTOMLEFT", 0, -4)
	frame.Sub:SetText("Настройка порядка и логики отображения")
	self:CreatePresets(frame.Content)
	self:CreateSortBlock(frame.Content)
	self:CreateGroupingBlock(frame.Content)
	self:CreateOptionsBlock(frame.Content)
	return frame
end
----------------------------------------------------------------
-- 🔘 Быстрые пресеты
----------------------------------------------------------------
function SortUI:CreatePresets(parent)
	local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("TOPLEFT", parent:GetParent().Sub, "BOTTOMLEFT", 0, -20)
	label:SetText("Быстрая сортировка")
	local presets = {"Прогресс", "Фракции", "Серверы", "Активность", "PvP", "Кастом"}
	local last
	for i, name in ipairs(presets) do
		local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
		b:SetSize(90, 22)
		b:SetText(name)
		if not last then
			b:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -6)
		else
			b:SetPoint("LEFT", last, "RIGHT", 6, 0)
		end
		b:SetScript("OnClick", function()
				-- тут ты потом подставишь ApplyPreset(name)
				print("Preset:", name)
		end)
		last = b
	end
end
----------------------------------------------------------------
-- 📊 Блок приоритетов сортировки
----------------------------------------------------------------
local SORT_OPTIONS = {
	"Регион", "Сервер", "Фракция", "Класс", "Специализация",
	"Уровень", "Уровень предметов (ilvl)",
	"PvP рейтинг", "M+ рейтинг",
	"Последний вход", "Общее время игры",
}
function SortUI:CreateSortBlock(parent)
	local header = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	header:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -110)
	header:SetText("Приоритеты сортировки")
	local sub = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	sub:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -2)
	sub:SetText("Сверху — важнее")
	self.SortContainer = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	self.SortContainer:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", 0, -8)
	self.SortContainer:SetSize(580, 180)
	local addBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	addBtn:SetSize(180, 22)
	addBtn:SetText("+ Добавить критерий")
	addBtn:SetPoint("TOPLEFT", self.SortContainer, "BOTTOMLEFT", 0, -6)
	addBtn:SetScript("OnClick", function()
			self:AddSortRow()
	end)
end
function SortUI:RefreshRowPositions()
	local prev
	for i, row in ipairs(self.rows) do
		row:ClearAllPoints()
		if not prev then
			row:SetPoint("TOPLEFT", 10, -10)
		else
			row:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -4)
		end
		row.Num:SetText(i .. ".")
		prev = row
	end
end
function SortUI:SwapRows(a, b)
	self.rows[a], self.rows[b] = self.rows[b], self.rows[a]
	self:RefreshRowPositions()
end
function tIndex(frame)
	for i, r in ipairs(SortUI.rows) do
		if r == frame then
			return i
		end
	end
end
function SortUI:AddSortRow()
	local index = #self.rows + 1
	local row = CreateFrame("Frame", nil, self.SortContainer, "OctoBackdropTemplate")
	row:SetSize(560, 26)
	-- Номер
	row.Num = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	row.Num:SetPoint("LEFT", 4, 0)
	row.Num:SetText(index .. ".")
	-- Текст вместо dropdown (пока)
	row.Criterion = "Уровень предметов (ilvl)" -- дефолт
	row.Select = CreateFrame("Button", nil, row)
	row.Select:SetSize(240, 20)
	row.Select:SetPoint("LEFT", row.Num, "RIGHT", 10, 0)
	row.Select.Text = row.Select:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	row.Select.Text:SetAllPoints()
	row.Select.Text:SetJustifyH("LEFT")
	row.Select.Text:SetText(row.Criterion)
	-- local menuFrame = CreateFrame("Frame", "SortUICriterionMenu", UIParent, "UIDropDownMenuTemplate")
	row.Select:SetScript("OnClick", function(self)
			-- создаём или повторно используем фрейм меню
			if not row.menuFrame then
				row.menuFrame = CreateFrame("Frame", nil, UIParent, "OctoBackdropTemplate")
				row.menuFrame:SetSize(160, #SORT_OPTIONS*20 + 10)
				row.menuFrame.buttons = {}
				for i, opt in ipairs(SORT_OPTIONS) do
					local b = CreateFrame("Button", nil, row.menuFrame, "UIPanelButtonTemplate")
					b:SetSize(140, 20)
					b:SetPoint("TOP", row.menuFrame, "TOP", 0, -10 - (i-1)*20)
					b:SetText(opt)
					b:SetScript("OnClick", function()
							row.Criterion = opt
							row.Select.Text:SetText(opt)
							row.menuFrame:Hide()
					end)
					table.insert(row.menuFrame.buttons, b)
				end
				row.menuFrame:Hide()
			end
			-- позиционируем меню под кнопку
			local x, y = self:GetCenter()
			local scale = UIParent:GetEffectiveScale()
			row.menuFrame:SetPoint("TOP", UIParent, "BOTTOMLEFT", x*scale, y*scale)
			row.menuFrame:Show()
	end)
	-- Направление
	row.Dir = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
	row.Dir:SetSize(40, 20)
	row.Dir:SetPoint("RIGHT", -30, 0)
	row.Dir.state = "DESC"
	row.Dir:SetText("v") -- ↓
	row.Dir:SetScript("OnClick", function(self)
			self.state = self.state == "DESC" and "ASC" or "DESC"
			self:SetText(self.state == "DESC" and "v" or "^") -- ↓↑
	end)
	-- Перетаскивание
	row:EnableMouse(true)
	row:RegisterForDrag("LeftButton")
	row:SetScript("OnDragStart", function(self)
			SortUI.draggingRow = self
			self:SetBackdropColor(0.2, 0.4, 0.8, 0.8) -- подсветка
	end)
	row:SetScript("OnUpdate", function(self)
			if SortUI.draggingRow ~= self then return end
			local _, cursorY = GetCursorPosition()
			local scale = UIParent:GetEffectiveScale()
			cursorY = cursorY / scale
			for i, other in ipairs(SortUI.rows) do
				if other ~= self then
					local top = other:GetTop()
					local bottom = other:GetBottom()
					if cursorY < top and cursorY > bottom then
						local from = tIndex(self)
						local to = i
						if from ~= to then
							table.remove(SortUI.rows, from)
							table.insert(SortUI.rows, to, self)
							SortUI:RefreshRowPositions()
						end
						break
					end
				end
			end
	end)
	row:SetScript("OnDragStop", function(self)
			SortUI.draggingRow = nil
			self:SetBackdropColor(E.PROFTBL.ConfigColor_MAIN_MainFrame_r, E.PROFTBL.ConfigColor_MAIN_MainFrame_g, E.PROFTBL.ConfigColor_MAIN_MainFrame_b, E.PROFTBL.ConfigColor_MAIN_MainFrame_a)
	end)
	-- Удалить
	row.Del = CreateFrame("Button", nil, row, "UIPanelCloseButton")
	row.Del:SetSize(20, 20)
	row.Del:SetPoint("RIGHT", -4, 0)
	row.Del:SetScript("OnClick", function()
			for i, r in ipairs(self.rows) do
				if r == row then
					table.remove(self.rows, i)
					break
				end
			end
			row:Hide()
			self:RefreshRowPositions()
	end)
	table.insert(self.rows, row)
	self:RefreshRowPositions()
end
----------------------------------------------------------------
-- 🧩 Группировка
----------------------------------------------------------------
function SortUI:CreateGroupingBlock(parent)
	local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -330)
	label:SetText("Группировка персонажей")
	local options = {"Не группировать", "По серверу", "По фракции", "По региону", "По классу"}
	local last
	for i, text in ipairs(options) do
		local b = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")
		b.text:SetText(text)
		if not last then
			b:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -6)
		else
			b:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -4)
		end
		last = b
	end
end
----------------------------------------------------------------
-- ⚙ Доп. опции
----------------------------------------------------------------
function SortUI:CreateOptionsBlock(parent)
	local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("TOPLEFT", parent, "TOPLEFT", 260, -330)
	label:SetText("Поведение списка")
	local checks = {
		"Показывать активную сортировку в заголовке",
		"Подсвечивать основной критерий",
		"Игнорировать оффлайн при сортировке активности",
	}
	local last
	for _, text in ipairs(checks) do
		local c = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
		c.Text:SetText(text)
		if not last then
			c:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -6)
		else
			c:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -4)
		end
		last = c
	end
	local reset = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	reset:SetSize(160, 22)
	reset:SetText("Сбросить к стандартной")
	reset:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -12)
end
function EventFrame:func_CreateOcto_SortUI()
	----------------------------------------------------------------
	-- ВРЕМЕННЫЙ ТЕСТОВЫЙ ВЫЗОВ (чтобы просто увидеть окно)
	----------------------------------------------------------------
	Octo_SortUI:SetSize(660, 560)
	Octo_SortUI:SetPoint("CENTER")
	Octo_SortUI:SetMovable(true)
	Octo_SortUI:EnableMouse(true)
	Octo_SortUI:RegisterForDrag("LeftButton")
	Octo_SortUI:SetScript("OnDragStart", Octo_SortUI.StartMoving)
	Octo_SortUI:SetScript("OnDragStop", Octo_SortUI.StopMovingOrSizing)
	E.SortUI:Create(Octo_SortUI)
	-- local close = CreateFrame("Button", nil, Octo_SortUI, "UIPanelCloseButton")
	-- close:SetPoint("TOPRIGHT")
end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CreateOcto_SortUI()
end
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_SortUI:Hide()
end