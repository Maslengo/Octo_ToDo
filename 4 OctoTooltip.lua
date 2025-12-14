local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
local OctoTooltip = CreateFrame("BUTTON", "OctoTooltip", UIParent, "BackdropTemplate")
OctoTooltip:Hide()
----------------------------------------------------------------
local OctoTooltip_Background = CreateFrame("FRAME", nil, OctoTooltip, "BackdropTemplate")
OctoTooltip_Background:SetAllPoints()
OctoTooltip_Background:SetFrameLevel(OctoTooltip:GetFrameLevel() - 1) -- Ниже основного фрейма
OctoTooltip_Background:SetBackdrop(E.menuBackdrop)
OctoTooltip_Background:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
OctoTooltip_Background:SetBackdropBorderColor(0, 0, 0, 1)

local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1 -- Цвет границы (черный)

local INDENT_TEXT = 4
local INDENT_SCROLL = 20
local MAX_DISPLAY_LINES = 24
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / E.GLOBAL_LINE_HEIGHT))*.7)
if MAX_DISPLAY_LINES > LINES_TOTAL then
	MAX_DISPLAY_LINES = LINES_TOTAL
end
local classR, classG, classB = GetClassColor(E.classFilename)




local func_OnAcquired do
	local function func_OnHide(frame)
		frame.highlightFrame:Hide()
	end
	local function func_OnShow(frame)
		frame.highlightFrame:Show()
	end
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
			frame:SetPropagateMouseMotion(true)
			frame:SetHitRectInsets(1, 1, 1, 1)
			----------------
			local highlightFrame = CreateFrame("Button", nil, OctoTooltip, "OctoHighlightAnimationTemplate")
			highlightFrame:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
			highlightFrame:SetPropagateMouseMotion(true)
			highlightFrame:SetFrameLevel(frame:GetFrameLevel()+2)
			highlightFrame:SetHighlightAtlas("auctionhouse-ui-row-highlight", "ADD")
			highlightFrame.TEXTURE_HIGHLIGHT = highlightFrame:GetHighlightTexture()
			highlightFrame.TEXTURE_HIGHLIGHT:SetAlpha(.2)
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
			textureFULL:SetVertexColor(classR, classG, classB, E.ALPHA_BACKGROUND)
			frame.textureFULL = textureFULL
			----------------
			-- Создаем метатаблицу для дочерних фреймов
			frame.lineFrames = setmetatable({}, {
					__index = function(self, key)
						if key then
							-- Создаем новый фрейм для каждого элемента
							local f = CreateFrame("BUTTON", "frame"..key, frame)
							f:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
							f:SetPropagateMouseMotion(true)
							f:SetHeight(E.GLOBAL_LINE_HEIGHT)
							-- f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
							if key == 1 then
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDENT_TEXT+1, 0) -- ОТСТУП
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
							f.text:SetJustifyH("CENTER") -- LEFT, Center, RIGHT
							f.text:SetTextColor(1, 1, 1, 1)
							-- Обработчики событий
							-- f:SetScript("OnEnter", function() E.func_OctoTooltip_OnEnter(f) end)
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
function EventFrame:Octo_Frame_init(frame, node)
    -- Получаем данные из узла и кэшируем часто используемые переменные
    local frameData = node:GetData()
    local lineFrames = frame.lineFrames -- Кэшируем для быстрого доступа
    local numData = EventFrame.columns or 1 -- Количество элементов в данных
    local numLines = #lineFrames -- Количество доступных lineFrames
    local columnSizes = EventFrame.COLUMN_SIZES -- Размеры колонок (если есть)

    -- Обрабатываем данные и обновляем соответствующие lineFrames
    for i = 1, numData do
        local currentItem = frameData[i]
        local currentText = ""
        local justify = "CENTER" -- По умолчанию

        -- Определяем тип элемента: строка или таблица с настройками
        if type(currentItem) == "table" then
            -- Таблица с настройками: {текст, "RIGHT"} или {текст}
            currentText = currentItem[1] or ""

            -- Определяем выравнивание
            if currentItem[2] then
                local alignment = string.upper(currentItem[2])
                if alignment == "LEFT" or alignment == "CENTER" or alignment == "RIGHT" then
                    justify = alignment
                end
            end
        else
            -- Просто строка
            currentText = currentItem or ""

            -- Автоматическое выравнивание для нескольких колонок
            if numData > 1 then
                if i == 1 then -- Первый элемент выравниваем по ЛЕВОМУ краю
                    justify = "LEFT"
                elseif i == numData then -- Последний элемент — по ПРАВОМУ
                    justify = "RIGHT"
                end
            end
        end

        -- Устанавливаем текст
        lineFrames[i].text:SetText(currentText)

        -- Устанавливаем выравнивание
        lineFrames[i].text:SetJustifyH(justify)

        -- Если заданы размеры колонок, применяем их
        if columnSizes then
            lineFrames[i]:SetWidth(columnSizes[i])
        end
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
function EventFrame:func_SmartAnchorTo(frame, point)
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
		if EventFrame.shouldShowScrollBar then
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
		local shouldShow = EventFrame.shouldShowScrollBar
		if shouldShow ~= scrollBar:IsShown() then
			if shouldShow then
				scrollBar:Show()
			else
				scrollBar:Hide()
			end
		end
		E.func_SmoothBackgroundAlphaChange(OctoTooltip, OctoTooltip_Background, "OnShow")

end
function EventFrame:Create_OctoTooltip()
	OctoTooltip:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
	OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)
	OctoTooltip:SetScript("OnEnter", TooltipOnEnter)
	OctoTooltip:SetScript("OnLeave", TooltipOnLeave)
	OctoTooltip:SetScript("OnShow", TooltipOnShow)
	OctoTooltip:SetPoint("CENTER")
	OctoTooltip:SetSize(1, E.GLOBAL_LINE_HEIGHT*1)
	OctoTooltip:SetClampedToScreen(true)
	OctoTooltip:SetFrameStrata("TOOLTIP")
	-- OctoTooltip:SetBackdrop(E.menuBackdrop)
	-- OctoTooltip:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA) -- E.backgroundColorA
	-- -- OctoTooltip:SetBackdropBorderColor(classR, classG, classB, 1)
	-- OctoTooltip:SetBackdropBorderColor(0, 0, 0, 1)
	OctoTooltip:SetBackdrop(nil)



	OctoTooltip.ScrollBox = CreateFrame("FRAME", nil, OctoTooltip, "WowScrollBoxList")
	OctoTooltip.ScrollBox:SetAllPoints()
	OctoTooltip.ScrollBox:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
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
	-- OctoTooltip:SetPropagateMouseClicks(true) -- БЫЛО ФОЛС
	-- OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip.view = CreateScrollBoxListTreeListView()
	OctoTooltip.view:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
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
        local currentItem = frameData[i]
        local textToMeasure = ""

        -- Извлекаем текст для измерения ширины
        if type(currentItem) == "table" then
            textToMeasure = currentItem[1] or ""
        else
            textToMeasure = currentItem or ""
        end

        sampleFrame.lineFrames[i].text:SetText(textToMeasure)
        columnWidths[i] = sampleFrame.lineFrames[i].text:GetStringWidth()
    end

    return columnWidths
end


function EventFrame:CreateDataProvider(tbl)
    -- opde(tbl)
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

    local newColumnsNumber = 0
    for stroka, v in ipairs(tbl) do
        lines = lines + 1
        local zxc = {}

        for indexColumn = 1, #v do
            newColumnsNumber = math.max(newColumnsNumber, #v)
            local value = v[indexColumn]

            -- Обрабатываем значения
            if value == nil then
                value = E.NIL
            elseif value == true then
                value = E.TRUE
            elseif value == false then
                value = E.FALSE
            end

            -- Для таблиц проверяем первый элемент
            if type(value) == "table" then
                local tableValue = value[1]
                if tableValue == nil then
                    tableValue = E.NIL
                elseif tableValue == true then
                    tableValue = E.TRUE
                elseif tableValue == false then
                    tableValue = E.FALSE
                end

                -- Создаем новую таблицу с обработанными значениями
                local processedValue = {}
                processedValue[1] = tostring(tableValue)
                processedValue[2] = value[2] -- Сохраняем выравнивание
                table.insert(zxc, processedValue)
            else
                -- Обычные значения
                value = tostring(value)
                if value == "" then value = " " end
                table.insert(zxc, value)
            end
        end

        if newColumnsNumber > 0 then
            local node = DataProvider:Insert(zxc)
            columns = newColumnsNumber
            for j, w in ipairs(calculateColumnWidths(node)) do
                COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
            end
        end
    end

    EventFrame.COLUMN_SIZES = COLUMN_SIZES
    EventFrame.columns = columns
	local total_width = INDENT_TEXT*2 -- ОТСТУП
	for i = 1, columns do
		total_width = total_width + EventFrame.COLUMN_SIZES[i]
	end
	-- lines = #tbl
	local shouldShowScrollBar = MAX_DISPLAY_LINES < lines
	EventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDENT_SCROLL
	end
	OctoTooltip.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	if lines > MAX_DISPLAY_LINES then
		OctoTooltip:SetSize(total_width, E.GLOBAL_LINE_HEIGHT*MAX_DISPLAY_LINES)
	elseif lines == 0 then
		OctoTooltip:SetSize(total_width, E.GLOBAL_LINE_HEIGHT*1)
	else
		OctoTooltip:SetSize(total_width, E.GLOBAL_LINE_HEIGHT*lines)
	end
end
function E.func_OctoTooltip_OnEnter(frame, point, allwaysLeft) -- ПОФИКСИТЬ (3им аргументом сделать point) либо повешать на объект 1395 hidingbar


	if not frame.tooltip or #frame.tooltip == 0 then return end
	if type(point) == "table" then
		EventFrame:func_SmartAnchorTo(frame, point)
	else
		EventFrame:func_SmartAnchorTo(frame)
	end


	E.OctoTooltip_GLOBAL_TABLE = frame.tooltip
	EventFrame:CreateDataProvider(frame.tooltip)
	OctoTooltip:Show()



	C_Timer.After(0.001, function()
			EventFrame:CreateDataProvider(frame.tooltip)
	end)
	if not frame.initScripts then
		frame.initScripts = true
		frame:SetScript("OnLeave", function()
				if not EventFrame.shouldShowScrollBar or not OctoTooltip:IsMouseOver() then
					OctoTooltip:Hide()
					E.OctoTooltip_GLOBAL_TABLE = nil
				end
		end)
		frame:SetScript("OnHide", function()
				OctoTooltip:Hide()
				E.OctoTooltip_GLOBAL_TABLE = nil
		end)
	end
end
local MyEventsTable = {
	"VARIABLES_LOADED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_STARTED_MOVING",
	"PLAYER_STOPPED_MOVING",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")
	self.VARIABLES_LOADED = nil
	self:Create_OctoTooltip()
end




function EventFrame:PLAYER_REGEN_DISABLED()
	OctoTooltip:Hide()
end

-- Обновляем обработчики событий
function EventFrame:PLAYER_STARTED_MOVING()
	E.func_SmoothBackgroundAlphaChange(OctoTooltip, OctoTooltip_Background, "PLAYER_STARTED_MOVING")
end

function EventFrame:PLAYER_STOPPED_MOVING()
	E.func_SmoothBackgroundAlphaChange(OctoTooltip, OctoTooltip_Background, "PLAYER_STOPPED_MOVING")
end