local GlobalAddonName, ns = ...; E = _G.OctoEngine
----------------------------------------------------------------
local OctoDebugFunctions_EventFrame = CreateFrame("FRAME")
OctoDebugFunctions_EventFrame:Hide()
local OctoDebugFunctions = CreateFrame("BUTTON", "OctoDebugFunctions", UIParent, "BackDropTemplate")
OctoDebugFunctions:Hide()
local TestButton3 = CreateFrame("Button", "TestButton3", UIParent, "UIPanelButtonTemplate")
E:func_InitFrame(OctoDebugFunctions) -- С ДАТА ПРОВАЙДЕРОМ
----------------------------------------------------------------
local font = OctoFont11
local INDEND_TEST = 4
local INDEND_SCROLL = 20
local LINE_HEIGHT = 20
local LINE_WIDTH = 256
local LINES_MAX = 20
local INDENT_BETWEEN_LINES = LINE_HEIGHT
local LINES_TOTAL = math.floor(math.floor(E.MonitorHeight/LINE_HEIGHT)*.7)
if LINES_MAX > LINES_TOTAL then
	LINES_MAX = LINES_TOTAL
end
local classR, classG, classB = GetClassColor(E.classFilename)
----------------------------------------------------------------
local function func_OnHide(frame)
	frame.highlightFrame:Hide()
end
local function func_OnShow(frame)
	frame.highlightFrame:Show()
end
local func_OnAcquired do
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			----------------
			local highlightFrame = CreateFrame("Button", nil, OctoDebugFunctions)
			highlightFrame:Hide()
			highlightFrame:SetPropagateMouseClicks(true)
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
							f:SetPropagateMouseClicks(true)
							f:SetPropagateMouseMotion(true)
							f:SetHeight(LINE_HEIGHT)
							-- f:SetSize(LINE_WIDTH, LINE_HEIGHT)
							-- f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
							if key == 1 then
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDEND_TEST, 0) -- ОТСТУП
							else
								local prevKey = key - 1
								local prevFrame = rawget(self, prevKey) or self[prevKey] -- Получаем предыдущий фрейм
								f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", INDENT_BETWEEN_LINES, 0)
							end
							-- Текст в центре
							f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
							f.text:SetAllPoints()
							f.text:SetFontObject(font)
							f.text:SetWordWrap(false)
							f.text:SetJustifyV("MIDDLE") -- TOP, MIDDLE, BOTTOM
							f.text:SetJustifyH("CENTER") -- LEFT, CENTER, RIGHT
							f.text:SetTextColor(1, 1, 1, 1)
							-- Обработчики событий
							-- f:SetScript("OnHide", f.Hide)
							rawset(self, key, f)
							return f
						end
					end
			})
			-- frame:SetScript("OnClick", func_OnClick)
			frame:SetScript("OnHide", func_OnHide)
			frame:SetScript("OnShow", func_OnShow)
			----------------
		end
	end
end
function OctoDebugFunctions_EventFrame:Octo_Frame_init(frame, node)
	-- Получаем данные из узла и кэшируем часто используемые переменные
	local frameData = node:GetData()
	local lineFrames = frame.lineFrames  -- Кэшируем для быстрого доступа
	local numData = #frameData           -- Количество элементов в данных
	local numLines = #lineFrames         -- Количество доступных lineFrames
	local columnSizes = OctoDebugFunctions_EventFrame.COLUMN_SIZES  -- Размеры колонок (если есть)
	-- Обрабатываем данные и обновляем соответствующие lineFrames
	for i = 1, numData do
		local currentText = frameData[i]
		if currentText then
			lineFrames[i].text:SetText(currentText)  -- Устанавливаем текст
		end
		-- Если заданы размеры колонок, применяем их
		if columnSizes and columnSizes[i] and lineFrames and lineFrames[i] then
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
function OctoDebugFunctions_EventFrame:func_SmartAnchorTo(frame, point)
	if not frame then
		return error("Invalid frame provided.", 2)
	end
	OctoDebugFunctions:ClearAllPoints()
	if point then
		local left, right = unpack(point)
		OctoDebugFunctions:SetPoint(left, frame, right)
	else
		OctoDebugFunctions:SetPoint("TOPLEFT", frame, "TOPRIGHT") 
	end
end
local function TooltipOnShow()
	local scrollBar = OctoDebugFunctions.ScrollBar
	local shouldShow = OctoDebugFunctions_EventFrame.shouldShowScrollBar
	if shouldShow ~= scrollBar:IsShown() then
		if shouldShow then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end
end
function OctoDebugFunctions_EventFrame:Create_OctoDebugFunctions()
	OctoDebugFunctions:SetPropagateMouseClicks(true)
	OctoDebugFunctions:SetPropagateMouseMotion(true)
	OctoDebugFunctions:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)
	OctoDebugFunctions:SetScript("OnShow", TooltipOnShow)
	OctoDebugFunctions:SetPoint("CENTER")
	OctoDebugFunctions:SetSize(1, LINE_HEIGHT*1)
	OctoDebugFunctions:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	-- OctoDebugFunctions:SetFrameStrata("BACKGROUND")
	OctoDebugFunctions:SetBackdrop(E.menuBackdrop)
	OctoDebugFunctions:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA) -- E.backgroundColorA
	-- OctoDebugFunctions:SetBackdropBorderColor(classR, classG, classB, 1)
	OctoDebugFunctions:SetBackdropBorderColor(0, 0, 0, 1)
	OctoDebugFunctions.ScrollBox = CreateFrame("FRAME", nil, OctoDebugFunctions, "WowScrollBoxList")
	OctoDebugFunctions.ScrollBox:SetAllPoints()
	OctoDebugFunctions.ScrollBox:SetPropagateMouseClicks(true)
	OctoDebugFunctions.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoDebugFunctions.ScrollBox:SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBox:GetScrollTarget():SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBox:Layout()
	OctoDebugFunctions.ScrollBar = CreateFrame("EventFrame", nil, OctoDebugFunctions, "MinimalScrollBar")
	OctoDebugFunctions.ScrollBar:SetPoint("TOPLEFT", OctoDebugFunctions.ScrollBox, "TOPRIGHT", 6, 0)
	OctoDebugFunctions.ScrollBar:SetPoint("BOTTOMLEFT", OctoDebugFunctions.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoDebugFunctions.ScrollBar:SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBar.Back:SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBar.Forward:SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBar.Track:SetPropagateMouseMotion(true)
	OctoDebugFunctions.ScrollBar.Track.Thumb:SetPropagateMouseMotion(true)
	-- OctoDebugFunctions:SetPropagateMouseClicks(true)
	-- OctoDebugFunctions:SetPropagateMouseMotion(true)
	OctoDebugFunctions.view = CreateScrollBoxListTreeListView()
	OctoDebugFunctions.view:SetElementExtent(LINE_HEIGHT)
	OctoDebugFunctions.view:SetElementInitializer("SecureActionButtonTemplate",
		function(...)
			self:Octo_Frame_init(...)
	end)
	OctoDebugFunctions.view:RegisterCallback(OctoDebugFunctions.view.Event.OnAcquiredFrame, func_OnAcquired, OctoDebugFunctions)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoDebugFunctions.ScrollBox, OctoDebugFunctions.ScrollBar, OctoDebugFunctions.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoDebugFunctions.ScrollBox, OctoDebugFunctions.ScrollBar)
end
local function calculateColumnWidths(node)
	local tbl = node:GetData()
	local frames = OctoDebugFunctions.view:GetFrames()
	if #frames == 0 then
		OctoDebugFunctions.view:AcquireInternal(1, node)
		OctoDebugFunctions.view:InvokeInitializers()
	end
	local columnWidths = {}
	local sampleFrame = frames[1]
	for i = 1, #tbl do
		sampleFrame.lineFrames[i].text:SetText(tbl[i])
		columnWidths[i] = sampleFrame.lineFrames[i].text:GetStringWidth()
	end
	return columnWidths
end
function OctoDebugFunctions_EventFrame:func_OctoDebugFunctions_CreateDataProvider()
	local lines = 0
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}
	local funcTABLES = {}
	for funcName, v in pairs(Octo_Debug_DB.Functions) do
		if v.count > 0 then
			funcTABLES[funcName] = {
				minTime = v.minTime,
				maxTime = v.maxTime,
				totalTime = v.totalTime,
				count = v.count,
			}
		end
	end
	local sorted_functions = {}
	for funcName, v in next, (funcTABLES) do
		table.insert(sorted_functions, {funcName = funcName, count = v.count, minTime = v.minTime, maxTime = v.maxTime, totalTime = v.totalTime})
	end
	table.sort(sorted_functions, function(a, b)
			if a.count ~= b.count then
				return a.count > b.count  -- descending by count
			elseif a.totalTime ~= b.totalTime then
				return a.totalTime > b.totalTime  -- descending by totalTime
			elseif a.maxTime ~= b.maxTime then
				return a.maxTime > b.maxTime  -- descending by maxTime
			elseif a.minTime ~= b.minTime then
				return a.minTime > b.minTime  -- descending by minTime
			else
				return a.funcName < b.funcName  -- ascending by funcName
			end
	end)
	for _, v in ipairs(sorted_functions) do
		local funcName = v.funcName
		local maxTime = v.maxTime
		local count = v.count
		local minTime = v.minTime
		local totalTime = v.totalTime
		lines = lines + 1
		local node = DataProvider:Insert({
				funcName,
				count,
				string.format("%.3f", minTime),
				string.format("%.3f", maxTime),
				string.format("%.3f", totalTime),
		})
		for j, w in ipairs(calculateColumnWidths(node)) do
			COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
		end
	end
	local columns = 5
	OctoDebugFunctions_EventFrame.COLUMN_SIZES = COLUMN_SIZES
	local total_width = INDEND_TEST*2 + (INDENT_BETWEEN_LINES*(columns-1)) -- ОТСТУП
	if OctoDebugFunctions_EventFrame.COLUMN_SIZES[1] then
		for i = 1, columns do
			total_width = total_width + OctoDebugFunctions_EventFrame.COLUMN_SIZES[i]
		end
	end
	local shouldShowScrollBar = LINES_MAX < lines
	OctoDebugFunctions_EventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDEND_SCROLL
	end
	OctoDebugFunctions.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	if lines > LINES_MAX then
		OctoDebugFunctions:SetSize(total_width, LINE_HEIGHT*LINES_MAX)
	elseif lines == 0 then
		OctoDebugFunctions:SetSize(total_width, LINE_HEIGHT*1)
	else
		OctoDebugFunctions:SetSize(total_width, LINE_HEIGHT*lines)
	end
end
local function Toggle_OctoDebugFunctions()
	if not OctoDebugFunctions:IsShown() then
		OctoDebugFunctions_EventFrame:func_OctoDebugFunctions_CreateDataProvider()
	end
	OctoDebugFunctions:SetShown(not OctoDebugFunctions:IsShown())
end
function OctoDebugFunctions_EventFrame:CreateTestButton3()
	TestButton3:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	TestButton3:SetPoint("TOPLEFT", 128, -384)
	TestButton3:SetSize(256, 32)
	TestButton3:SetText("OctoDebugFunctions")
	TestButton3:EnableMouse(true)
	TestButton3:SetMovable(true)
	-- Обработчики перемещения фрейма
	TestButton3:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				TestButton3:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnDrag or E.backgroundColorA)
				TestButton3:StartMoving()
			end
	end)
	TestButton3:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				TestButton3:SetAlpha(1)
				TestButton3:StopMovingOrSizing()
			end
	end)
	TestButton3:RegisterForClicks("LeftButtonUp")
	TestButton3:SetScript("OnClick", Toggle_OctoDebugFunctions)
	OctoDebugFunctions_EventFrame:func_SmartAnchorTo(TestButton3)
end
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE_DELAYED",
}
E:func_RegisterMyEventsToFrames(OctoDebugFunctions_EventFrame, MyEventsTable)
function OctoDebugFunctions_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		OctoDebugFunctions_EventFrame:Create_OctoDebugFunctions()
		self:CreateTestButton3()
		OctoDebugFunctions_EventFrame:func_OctoDebugFunctions_CreateDataProvider()
	end
end
function OctoDebugFunctions_EventFrame:BAG_UPDATE_DELAYED()
	if OctoDebugFunctions:IsShown() then
		C_Timer.After(1, function()
				OctoDebugFunctions_EventFrame:func_OctoDebugFunctions_CreateDataProvider()
		end)
	end
end
function OctoDebugFunctions_EventFrame:PLAYER_REGEN_ENABLED()
	TestButton3:Show()
end
function OctoDebugFunctions_EventFrame:PLAYER_REGEN_DISABLED()
	OctoDebugFunctions:Hide()
	TestButton3:Hide()
end