local GlobalAddonName, E = ...
local OctoTooltipEventFrame = CreateFrame("FRAME")
OctoTooltipEventFrame:Hide()
local OctoTooltip = CreateFrame("BUTTON", "OctoTooltip", UIParent, "BackdropTemplate")
OctoTooltip:Hide()
local INDEND_TEST = 4
local INDEND_SCROLL = 20
local TOOLTIP_LINE_HEIGHT = 20
local TOOLTIP_LINE_WIDTH = 256
local LINES_MAX = 20
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / TOOLTIP_LINE_HEIGHT))*.7)
if LINES_MAX > LINES_TOTAL then
	LINES_MAX = LINES_TOTAL
end
local classR, classG, classB = GetClassColor(E.classFilename)
local function func_OnHide(frame)
	frame.highlightFrame:Hide()
end
local function func_OnShow(frame)
	frame.highlightFrame:Show()
end
local func_OnAcquired do
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame:SetPropagateMouseClicks(false)
			frame:SetPropagateMouseMotion(true)
			----------------
			local highlightFrame = CreateFrame("Button", nil, OctoTooltip)
			highlightFrame:SetPropagateMouseClicks(false)
			highlightFrame:SetPropagateMouseMotion(true)
			highlightFrame:SetFrameLevel(frame:GetFrameLevel()+2)
			highlightFrame:SetHighlightAtlas("auctionhouse-ui-row-highlight", "ADD")
			highlightFrame.HighlightTexture = highlightFrame:GetHighlightTexture()
			highlightFrame.HighlightTexture:SetAlpha(.2)
			highlightFrame:SetPoint("LEFT", frame)
			highlightFrame:SetPoint("TOP", frame)
			highlightFrame:SetPoint("BOTTOM", frame)
			highlightFrame:SetPoint("RIGHT")
			frame.highlightFrame = highlightFrame
			----------------
			local textureFULL = highlightFrame:CreateTexture(nil, "BACKGROUND", nil, -3)
			textureFULL:Hide()
			textureFULL:SetAllPoints()
			textureFULL:SetTexture(E.TEXTURE_LEFT_PATH)
			textureFULL:SetVertexColor(classR, classG, classB, E.bgCaOverlay)
			frame.textureFULL = textureFULL
			----------------
			-- Создаем метатаблицу для дочерних фреймов
			frame.lineFrames = setmetatable({}, {
					__index = function(self, key)
						if key then
							-- Создаем новый фрейм для каждого элемента
							local f = CreateFrame("BUTTON", "frame"..key, frame)
							f:SetPropagateMouseClicks(false)
							f:SetPropagateMouseMotion(true)
							f:SetHeight(TOOLTIP_LINE_HEIGHT)
							-- f:SetSize(TOOLTIP_LINE_WIDTH, TOOLTIP_LINE_HEIGHT)
							-- f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
							if key == 1 then
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDEND_TEST, 0) -- ОТСТУП
							else
								local prevKey = key - 1
								local prevFrame = rawget(self, prevKey) or self[prevKey] -- Получаем предыдущий фрейм
								f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", 0, 0)
							end
							f:RegisterForClicks("LeftButtonUp")
							-- Текст в центре
							f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
							f.text:SetAllPoints()
							f.text:SetFontObject(OctoFont11)
							f.text:SetWordWrap(false)
							f.text:SetJustifyV("MIDDLE") -- TOP, MIDDLE, BOTTOM
							f.text:SetJustifyH("CENTER") -- LEFT, CENTER, RIGHT
							f.text:SetTextColor(1, 1, 1, 1)
							-- Обработчики событий
							-- f:SetScript("OnEnter", function() E:func_OctoTooltip_OnEnter(f) end)
							-- f:SetScript("OnHide", f.Hide)
							rawset(self, key, f)
							return f
						end
					end
			})
			frame:SetScript("OnHide", func_OnHide)
			frame:SetScript("OnShow", func_OnShow)
			----------------
		end
	end
end
function OctoTooltipEventFrame:Octo_Frame_init(frame, node)
	-- Получаем данные из узла и кэшируем часто используемые переменные
	local frameData = node:GetData()
	local lineFrames = frame.lineFrames  -- Кэшируем для быстрого доступа
	local numData = #frameData           -- Количество элементов в данных
	local numLines = #lineFrames         -- Количество доступных lineFrames
	local columnSizes = OctoTooltipEventFrame.COLUMN_SIZES  -- Размеры колонок (если есть)
	-- Обрабатываем данные и обновляем соответствующие lineFrames
	for i = 1, numData do
		local currentText = frameData[i]
		if currentText then
			lineFrames[i].text:SetText(currentText)  -- Устанавливаем текст
		end
		-- Если заданы размеры колонок, применяем их
		if columnSizes then
			lineFrames[i]:SetWidth(columnSizes[i])
		end
		-- Определяем выравнивание текста (по умолчанию CENTER)
		local justify = "CENTER"
		if numData > 1 then
			if i == 1 then          -- Первый элемент выравниваем по ЛЕВОМУ краю
				justify = "LEFT"
			elseif i == numData then -- Последний элемент — по ПРАВОМУ
				justify = "RIGHT"
			end
		end
		lineFrames[i].text:SetJustifyH(justify)
	end
	-- Очищаем оставшиеся lineFrames (если данных меньше, чем фреймов)
	for i = numData + 1, numLines do
		lineFrames[i].text:SetText()
	end
end
local function GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then
		return "TOPLEFT", "BOTTOMLEFT"
	end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf .. hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP") .. hhalf
end
function OctoTooltipEventFrame:func_SmartAnchorTo(frame, point)
	if not frame then
		return error("Invalid frame provided.", 2)
	end
	OctoTooltip:ClearAllPoints()
	if point then
		local left, right = unpack(point)
		OctoTooltip:SetPoint(left, frame, right)
	else
		OctoTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
		-- OctoTooltip:SetPoint(GetTipAnchor(frame))
	end
end


local function TooltipOnEnter()
	if OctoTooltipEventFrame.shouldShowScrollBar then
		OctoTooltip:Show()
		OctoTooltip:SetPropagateMouseMotion(false)
	else
		OctoTooltip:SetPropagateMouseMotion(true)
	end
end

local function TooltipOnLeave()
	OctoTooltip:Hide()
end

function OctoTooltipEventFrame:Create_OctoTooltip()
	OctoTooltip:SetPropagateMouseClicks(false)
	OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)
	OctoTooltip:SetScript("OnEnter", TooltipOnEnter)
	OctoTooltip:SetScript("OnLeave", TooltipOnLeave)
	OctoTooltip:SetPoint("CENTER")
	OctoTooltip:SetSize(1, TOOLTIP_LINE_HEIGHT*1)
	OctoTooltip:SetClampedToScreen(true)
	OctoTooltip:SetFrameStrata("TOOLTIP")
	OctoTooltip:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoTooltip:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa) -- E.bgCa
	-- OctoTooltip:SetBackdropBorderColor(classR, classG, classB, 1)
	OctoTooltip:SetBackdropBorderColor(0, 0, 0, 1)
	OctoTooltip.ScrollBox = CreateFrame("FRAME", nil, OctoTooltip, "WowScrollBoxList")
	OctoTooltip.ScrollBox:SetAllPoints()
	OctoTooltip.ScrollBox:SetPropagateMouseClicks(false)
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(false)
	OctoTooltip.ScrollBox:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBox:Layout()
	OctoTooltip.ScrollBar = CreateFrame("EventFrame", nil, OctoTooltip, "MinimalScrollBar")
	OctoTooltip.ScrollBar:SetPoint("TOPLEFT", OctoTooltip.ScrollBox, "TOPRIGHT", -15, -3)
	OctoTooltip.ScrollBar:SetPoint("BOTTOMLEFT", OctoTooltip.ScrollBox, "BOTTOMRIGHT", -15, 3)
	OctoTooltip.ScrollBar:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Back:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Forward:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Track:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Track.Thumb:SetPropagateMouseMotion(true)
	-- OctoTooltip:SetPropagateMouseClicks(false)
	-- OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip.view = CreateScrollBoxListTreeListView()
	OctoTooltip.view:SetElementExtent(TOOLTIP_LINE_HEIGHT)
	OctoTooltip.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	OctoTooltip.view:RegisterCallback(OctoTooltip.view.Event.OnAcquiredFrame, func_OnAcquired, OctoTooltip)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar, OctoTooltip.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar)
end
local function calculateColumnWidths(node)
	local zxc = node:GetData()
	local frames = OctoTooltip.view:GetFrames()
	if #frames == 0 then
		OctoTooltip.view:AcquireInternal(1, node)
		OctoTooltip.view:InvokeInitializers()
	end
	local columnWidths = {}
	local sampleFrame = frames[1]
	for i = 1, #zxc do
		sampleFrame.lineFrames[i].text:SetText(zxc[i])
		columnWidths[i] = sampleFrame.lineFrames[i].text:GetStringWidth()
	end
	return columnWidths
end
function OctoTooltipEventFrame:func_OctoTooltip_CreateDataProvider(tbl)
	local lines = 0
	local columns = 0
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}
	for i, v in ipairs(tbl) do
		local zxc = {}
		for i, value in ipairs(v) do
			if value ~= nil then
				table.insert(zxc, value)
			end
		end
		if #zxc > 0 then
			local node = DataProvider:Insert(zxc)
			columns = #zxc
			for j, w in ipairs(calculateColumnWidths(node)) do
				COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
			end
		end
	end
	OctoTooltipEventFrame.COLUMN_SIZES = COLUMN_SIZES
	local total_width = INDEND_TEST*2 -- ОТСТУП
	for i = 1, columns do
		total_width = total_width + OctoTooltipEventFrame.COLUMN_SIZES[i]
	end
	lines = #tbl
	local shouldShowScrollBar = LINES_MAX < lines
	OctoTooltipEventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDEND_SCROLL
	end
	OctoTooltip.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	if lines > LINES_MAX then
		OctoTooltip:SetSize(total_width, TOOLTIP_LINE_HEIGHT*LINES_MAX)
	elseif lines == 0 then
		OctoTooltip:SetSize(total_width, TOOLTIP_LINE_HEIGHT*1)
	else
		OctoTooltip:SetSize(total_width, TOOLTIP_LINE_HEIGHT*lines)
	end
end
function E:func_OctoTooltip_OnEnter(frame, point)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	OctoTooltipEventFrame:func_SmartAnchorTo(frame, point)
	OctoTooltipEventFrame:func_OctoTooltip_CreateDataProvider(frame.tooltip)
	OctoTooltip:Show()
	if not frame.initScripts then
		frame.initScripts = true
		frame:SetScript("OnLeave", function()
				if not OctoTooltipEventFrame.shouldShowScrollBar or not OctoTooltip:IsMouseOver() then
					OctoTooltip:Hide()
				end
		end)
		frame:SetScript("OnHide", function()
				OctoTooltip:Hide()
		end)
	end
end
local function Create_TestButton1()
	local TestButton1 = CreateFrame("Button", "TestButton1", UIParent, "UIPanelButtonTemplate")
	TestButton1:SetPoint("TOPLEFT", UIParent, 128, -64)
	TestButton1:SetSize(100, 40)
	TestButton1:SetText("ONE")
	TestButton1:SetScript("OnEnter", function()
			E:func_OctoTooltip_OnEnter(TestButton1)
	end)
	TestButton1:EnableMouse(true)
	TestButton1:SetMovable(true)
	TestButton1:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				TestButton1:SetAlpha(.5)
				TestButton1:StartMoving()
			end
	end)
	TestButton1:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				TestButton1:SetAlpha(1)
				TestButton1:StopMovingOrSizing()
			end
	end)
	local tooltip = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local data = CharInfo.PlayerData
		tooltip[#tooltip+1] = {
			data.classColorHex..data.Name.."|r",
			data.specName,
			data.loginDay,
			data.curServerShort,
			data.raceID
		}
		-- tooltip.ShownGUID = GUID
	end
	TestButton1.tooltip = tooltip
end
local function Create_TestButton2()
	local TestButton2 = CreateFrame("Button", "TestButton2", UIParent, "UIPanelButtonTemplate")
	TestButton2:SetPoint("TOPLEFT", UIParent, 128, -128)
	TestButton2:SetSize(100, 40)
	TestButton2:SetText("TWO")
	TestButton2:SetScript("OnEnter", function()
			E:func_OctoTooltip_OnEnter(TestButton2)
	end)
	TestButton2:EnableMouse(true)
	TestButton2:SetMovable(true)
	TestButton2:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				TestButton2:SetAlpha(.5)
				TestButton2:StartMoving()
			end
	end)
	TestButton2:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				TestButton2:SetAlpha(1)
				TestButton2:StopMovingOrSizing()
			end
	end)
	local tooltip = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		tooltip[#tooltip+1] = {CharInfo.PlayerData.Name.."|r", E:func_CompactNumberFormat(CharInfo.PlayerData.Money/10000)}
	end
	TestButton2.tooltip = tooltip
end
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(OctoTooltipEventFrame, MyEventsTable)
function OctoTooltipEventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		Create_TestButton1()
		Create_TestButton2()
		self:Create_OctoTooltip()
	end
end