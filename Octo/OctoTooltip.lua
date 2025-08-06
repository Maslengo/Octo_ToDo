local GlobalAddonName, E = ...
----------------------------------------------------------------
local OctoTooltip_EventFrame = CreateFrame("FRAME")
OctoTooltip_EventFrame:Hide()
local OctoTooltip = CreateFrame("BUTTON", "OctoTooltip", UIParent, "BackdropTemplate")
OctoTooltip:Hide()
----------------------------------------------------------------
local INDENT_TEST = 4
local INDENT_SCROLL = 20
local TOOLTIP_LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT
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
			textureFULL:SetVertexColor(classR, classG, classB, E.backgroundColorAOverlay)
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
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDENT_TEST+1, 0) -- ОТСТУП
							else
								local prevKey = key - 1
								local prevFrame = rawget(self, prevKey) or self[prevKey] -- Получаем предыдущий фрейм
								f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", 0, 0)
							end
							f:RegisterForClicks("LeftButtonUp")
							-- Текст в центре
							f.text = f:CreateFontString()
							f.text:SetFontObject(OctoFont11)
							f.text:SetAllPoints()
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
function OctoTooltip_EventFrame:Octo_Frame_init(frame, node)
	-- Получаем данные из узла и кэшируем часто используемые переменные
	local frameData = node:GetData()
	local lineFrames = frame.lineFrames  -- Кэшируем для быстрого доступа
	local numData = #frameData           -- Количество элементов в данных
	local numLines = #lineFrames         -- Количество доступных lineFrames
	local columnSizes = OctoTooltip_EventFrame.COLUMN_SIZES  -- Размеры колонок (если есть)
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
function OctoTooltip_EventFrame:func_SmartAnchorTo(frame, point)
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
	if OctoTooltip_EventFrame.shouldShowScrollBar then
		OctoTooltip:Show()
		OctoTooltip:SetPropagateMouseMotion(false)
	else
		OctoTooltip:SetPropagateMouseMotion(true)
	end
end

local function TooltipOnLeave()
	OctoTooltip:Hide()
end

local function TooltipOnShow()
	local scrollBar = OctoTooltip.ScrollBar
	local shouldShow = OctoTooltip_EventFrame.shouldShowScrollBar
	if shouldShow ~= scrollBar:IsShown() then
		if shouldShow then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end
end

function OctoTooltip_EventFrame:Create_OctoTooltip()
	OctoTooltip:SetPropagateMouseClicks(false)
	OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)
	OctoTooltip:SetScript("OnEnter", TooltipOnEnter)
	OctoTooltip:SetScript("OnLeave", TooltipOnLeave)
	OctoTooltip:SetScript("OnShow", TooltipOnShow)
	OctoTooltip:SetPoint("CENTER")
	OctoTooltip:SetSize(1, TOOLTIP_LINE_HEIGHT*1)
	OctoTooltip:SetClampedToScreen(true)
	OctoTooltip:SetFrameStrata("TOOLTIP")
	OctoTooltip:SetBackdrop(E.menuBackdrop)
	OctoTooltip:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA) -- E.backgroundColorA
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
	local frameData = node:GetData()
	local frames = OctoTooltip.view:GetFrames()
	if #frames == 0 then
		OctoTooltip.view:AcquireInternal(1, node)
		OctoTooltip.view:InvokeInitializers()
	end
	local columnWidths = {}
	local sampleFrame = frames[1]
	for i = 1, #frameData do
		sampleFrame.lineFrames[i].text:SetText(frameData[i])
		columnWidths[i] = sampleFrame.lineFrames[i].text:GetStringWidth()
	end
	return columnWidths
end
function OctoTooltip_EventFrame:func_OctoTooltip_CreateDataProvider(tbl)
	local lines = 0
	local columns = 0
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}



	-- Если есть заголовки, вычисляем их ширину, но не добавляем в DataProvider
	if tbl.Header then
		-- Создаем временный узел только для расчета ширины
		local tempHeaderNode = DataProvider:Insert(tbl.Header)
		for i, width in ipairs(calculateColumnWidths(tempHeaderNode)) do
			COLUMN_SIZES[i] = math.max(width, COLUMN_SIZES[i] or 0)
		end
		lines = lines + 1
		-- DataProvider:Remove(tempHeaderNode) -- Удаляем, чтобы не мешал
	end


	for _, v in ipairs(tbl) do
		lines = lines + 1
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

	OctoTooltip_EventFrame.COLUMN_SIZES = COLUMN_SIZES
	local total_width = INDENT_TEST*2 -- ОТСТУП
	for i = 1, columns do
		total_width = total_width + OctoTooltip_EventFrame.COLUMN_SIZES[i]
	end
	-- lines = #tbl
	local shouldShowScrollBar = LINES_MAX < lines
	OctoTooltip_EventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDENT_SCROLL
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
	if point then
		OctoTooltip_EventFrame:func_SmartAnchorTo(frame, point)
	else
		OctoTooltip_EventFrame:func_SmartAnchorTo(frame)
	end
	OctoTooltip_EventFrame:func_OctoTooltip_CreateDataProvider(frame.tooltip)
	OctoTooltip:Show()
	if not frame.initScripts then
		frame.initScripts = true
		frame:SetScript("OnLeave", function()
				if not OctoTooltip_EventFrame.shouldShowScrollBar or not OctoTooltip:IsMouseOver() then
					OctoTooltip:Hide()
				end
		end)
		frame:SetScript("OnHide", function()
				OctoTooltip:Hide()
		end)
	end
end
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E:func_RegisterMyEventsToFrames(OctoTooltip_EventFrame, MyEventsTable)

function OctoTooltip_EventFrame:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")
	self.VARIABLES_LOADED = nil
	self:Create_OctoTooltip()
end