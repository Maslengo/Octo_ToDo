local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local Octo_TooltipFrame = CreateFrame("BUTTON", "Octo_TooltipFrame", UIParent, "OctoTooltipBackdropTemplate")
Octo_TooltipFrame:Hide()
E.func_RegisterFrame_SIMPLE(Octo_TooltipFrame)
EventFrame.measureFrame = CreateFrame("Frame")
EventFrame.measureFrame:SetParent(UIParent)
EventFrame.measureFrame:SetScale(UIParent:GetEffectiveScale())
EventFrame.measureText = EventFrame.measureFrame:CreateFontString()
EventFrame.measureText:SetFontObject(OctoFont11)
EventFrame.measureText:SetWordWrap(false)
local TEXT_PADDING = 6
local SEPARATOR_HEIGHT = 2
local SEPARATOR_KEY = "---"
local INDENT_TEXT = 4
local INDENT_SCROLL = 20
local MAX_DISPLAY_LINES = 26
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / E.GLOBAL_LINE_HEIGHT))*.7)
if MAX_DISPLAY_LINES > LINES_TOTAL then
	MAX_DISPLAY_LINES = LINES_TOTAL
end
local classR, classG, classB = GetClassColor(E.classFilename)
EventFrame.COLUMN_SIZES = {}
EventFrame.columns = 0
local func_OnAcquired do
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame.lineFrames = setmetatable({}, {
					__index = function(self, key)
						if key ~= #self + 1 then
							return rawget(self, key)
						end
						local f = CreateFrame("BUTTON", nil, frame, "OctoPropagateTemplate")
						f:SetHeight(E.GLOBAL_LINE_HEIGHT)
						if key == 1 then
							f:SetPoint("TOPLEFT", frame, "TOPLEFT", INDENT_TEXT + 1, 0)
						else
							local prevFrame = rawget(self, key - 1)
							f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", 0, 0)
						end
						f:RegisterForClicks("LeftButtonUp")
						f.text = f:CreateFontString(nil, "OVERLAY")
						f.text:SetFontObject(OctoFont11)
						f.text:SetAllPoints()
						f.text:SetWordWrap(false)
						f.text:SetJustifyV("MIDDLE")
						f.text:SetJustifyH("CENTER")
						f.text:SetTextColor(1, 1, 1, 1)
						rawset(self, key, f)
						return f
					end
			})
			E.func_Create_Highlight(frame, owner)
			frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
			frame:SetScript("OnShow", function() frame.Highlight:Show() end)
		end
		local frameData = data:GetData()
		local isSeparator = frameData and frameData[1] == SEPARATOR_KEY
		if isSeparator then
			frame.Highlight:Hide()
		else
			frame.Highlight:Show()
		end
	end
end
function EventFrame:Octo_Frame_init(frame, node)
	local frameData = node:GetData()
	local lineFrames = frame.lineFrames
	if frameData[1] == SEPARATOR_KEY then
		for i = 1, #lineFrames do
			if lineFrames[i] then
				lineFrames[i]:Hide()
			end
		end
		if not frame.separator then
			frame.separator = frame:CreateTexture(nil, "BACKGROUND")
			frame.separator:SetColorTexture(.8, .8, .8, .8)
			frame.separator:SetHeight(1)
			frame.separator:SetPoint("LEFT", frame, "LEFT", INDENT_TEXT, 0)
			frame.separator:SetPoint("RIGHT", frame, "RIGHT", -INDENT_TEXT, 0)
			frame.separator:SetPoint("CENTER", 0, 0)
		end
		frame.separator:Show()
		return
	end
	if frame.separator then
		frame.separator:Hide()
	end
	local numData = EventFrame.columns or 1
	local columnSizes = EventFrame.COLUMN_SIZES
	for i = 1, numData do
		local currentItem = frameData[i]
		local currentText = ""
		local justify = "CENTER"
		if type(currentItem) == "table" then
			currentText = currentItem[1] or ""
			if currentItem[2] then
				local alignment = string.upper(currentItem[2])
				if alignment == "LEFT" or alignment == "CENTER" or alignment == "RIGHT" then
					justify = alignment
				end
			end
		else
			currentText = currentItem or ""
			if numData > 1 then
				if i == 1 then
					justify = "LEFT"
				elseif i == numData then
					justify = "RIGHT"
				end
			end
		end
		if lineFrames[i] then
			lineFrames[i].text:SetText(currentText)
			lineFrames[i].text:SetJustifyH(justify)
			if columnSizes and columnSizes[i] then
				lineFrames[i]:SetWidth(columnSizes[i])
			end
			lineFrames[i]:Show()
		end
	end
	for i = numData + 1, #lineFrames do
		if lineFrames[i] then
			lineFrames[i].text:SetText()
			lineFrames[i]:Hide()
		end
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
	Octo_TooltipFrame:ClearAllPoints()
	if point then
		local left, right = unpack(point)
		Octo_TooltipFrame:SetPoint(left, frame, right)
	else
		Octo_TooltipFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT")
	end
end
local function TooltipOnEnter()
	if EventFrame.shouldShowScrollBar then
		Octo_TooltipFrame:Show()
		if not InCombatLockdown() then
			Octo_TooltipFrame:SetPropagateMouseMotion(false)
		end
	else
		if not InCombatLockdown() then
			Octo_TooltipFrame:SetPropagateMouseMotion(true)
		end
	end
end
local function TooltipOnLeave()
	Octo_TooltipFrame:Hide()
end
local function TooltipOnShow()
	local scrollBar = Octo_TooltipFrame.ScrollBar
	local shouldShow = EventFrame.shouldShowScrollBar
	if shouldShow ~= scrollBar:IsShown() then
		if shouldShow then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end
end
function EventFrame:Create_Octo_TooltipFrame()


	Octo_TooltipFrame:SetScript("OnEnter", TooltipOnEnter)
	Octo_TooltipFrame:SetScript("OnLeave", TooltipOnLeave)
	Octo_TooltipFrame:HookScript("OnShow", TooltipOnShow)
	Octo_TooltipFrame:SetPoint("CENTER")
	Octo_TooltipFrame:SetSize(SEPARATOR_HEIGHT, E.GLOBAL_LINE_HEIGHT)
	Octo_TooltipFrame:SetClampedToScreen(true)
	Octo_TooltipFrame:SetFrameStrata("TOOLTIP")
	Octo_TooltipFrame.ScrollBox = CreateFrame("FRAME", nil, Octo_TooltipFrame, "WowScrollBoxList,OctoPropagateTemplate")
	Octo_TooltipFrame.ScrollBox:SetAllPoints()
	if not InCombatLockdown() then
		Octo_TooltipFrame.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
		Octo_TooltipFrame.ScrollBox:GetScrollTarget():SetPropagateMouseMotion(true)
	end
	-- Octo_TooltipFrame.ScrollBox:Layout()
	Octo_TooltipFrame.ScrollBox:SetFrameLevel(Octo_TooltipFrame.ScrollBox:GetFrameLevel() + 1)

	Octo_TooltipFrame.ScrollBar = CreateFrame("EventFrame", nil, Octo_TooltipFrame, "MinimalScrollBar,OctoPropagateTemplate")
	Octo_TooltipFrame.ScrollBar:SetPoint("TOPLEFT", Octo_TooltipFrame.ScrollBox, "TOPRIGHT", -15, -3)
	Octo_TooltipFrame.ScrollBar:SetPoint("BOTTOMLEFT", Octo_TooltipFrame.ScrollBox, "BOTTOMRIGHT", -15, 3)

	if not InCombatLockdown() then
		Octo_TooltipFrame.ScrollBar.Back:SetPropagateMouseMotion(true)
		Octo_TooltipFrame.ScrollBar.Forward:SetPropagateMouseMotion(true)
		Octo_TooltipFrame.ScrollBar.Track:SetPropagateMouseMotion(true)
		Octo_TooltipFrame.ScrollBar.Track.Thumb:SetPropagateMouseMotion(true)
	end
	Octo_TooltipFrame.view = CreateScrollBoxListTreeListView()
	Octo_TooltipFrame.view:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	Octo_TooltipFrame.view:SetElementInitializer("OctoPropagateTemplate", function(...) self:Octo_Frame_init(...) end)
	Octo_TooltipFrame.view:RegisterCallback(Octo_TooltipFrame.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_TooltipFrame)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_TooltipFrame.ScrollBox, Octo_TooltipFrame.ScrollBar, Octo_TooltipFrame.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_TooltipFrame.ScrollBox, Octo_TooltipFrame.ScrollBar)
end
local function calculateColumnWidths(node)
	local frameData = node:GetData()
	if frameData and frameData[1] == SEPARATOR_KEY then
		return {}
	end
	local columnWidths = {}
	for i = 1, #frameData do
		local currentItem = frameData[i]
		local textToMeasure = ""
		if type(currentItem) == "table" then
			textToMeasure = currentItem[1] or ""
		else
			textToMeasure = currentItem or ""
		end
		local width = E.func_MeasureTextWidth(textToMeasure)
		columnWidths[i] = width
	end
	return columnWidths
end
function EventFrame:CreateDataProvider(tbl)
	EventFrame.COLUMN_SIZES = {}
	EventFrame.columns = 0
	local lines = #tbl
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}
	local maxColumns = 0
	for stroka, v in ipairs(tbl) do
		local zxc = {}
		if type(v) == "string" and v == SEPARATOR_KEY then
			zxc = {SEPARATOR_KEY}
		else
			maxColumns = math.max(maxColumns, #v)
			for indexColumn = 1, #v do
				local value = v[indexColumn]
				if value == nil then
					value = E.NIL
				elseif value == true then
					value = E.TRUE
				elseif value == false then
					value = E.FALSE
				end
				if type(value) == "table" then
					local tableValue = value[1]
					if tableValue == nil then
						tableValue = E.NIL
					elseif tableValue == true then
						tableValue = E.TRUE
					elseif tableValue == false then
						tableValue = E.FALSE
					end
					local processedValue = {}
					processedValue[1] = tostring(tableValue)
					processedValue[2] = value[2]
					table.insert(zxc, processedValue)
				else
					value = tostring(value)
					if value == "" then value = " " end
					table.insert(zxc, value)
				end
			end
		end
		if #zxc > 0 then
			local node = DataProvider:Insert(zxc)
			if type(v) ~= "string" or v ~= SEPARATOR_KEY then
				local widths = calculateColumnWidths(node)
				for j, w in ipairs(widths) do
					COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
				end
			end
		end
	end
	EventFrame.COLUMN_SIZES = COLUMN_SIZES
	EventFrame.columns = maxColumns
	local total_width = INDENT_TEXT * 2
	for i = 1, maxColumns do
		total_width = total_width + (COLUMN_SIZES[i] or 0)
	end
	local shouldShowScrollBar = MAX_DISPLAY_LINES < lines
	EventFrame.shouldShowScrollBar = shouldShowScrollBar
	if shouldShowScrollBar then
		total_width = total_width + INDENT_SCROLL
	end
	Octo_TooltipFrame.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	local totalHeight = lines * E.GLOBAL_LINE_HEIGHT
	if lines > MAX_DISPLAY_LINES then
		totalHeight = E.GLOBAL_LINE_HEIGHT * MAX_DISPLAY_LINES
	elseif lines == 0 then
		totalHeight = E.GLOBAL_LINE_HEIGHT
	end
	Octo_TooltipFrame:SetSize(total_width, totalHeight)
end
function E.func_Octo_TooltipFrame_OnEnter(frame, point, allwaysLeft)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	if type(point) == "table" then
		EventFrame:func_SmartAnchorTo(frame, point)
	else
		EventFrame:func_SmartAnchorTo(frame)
	end
	E.Octo_TooltipFrame_GLOBAL_TABLE = frame.tooltip
	EventFrame:CreateDataProvider(frame.tooltip)
	Octo_TooltipFrame:Show()
	if not frame.initScripts then
		frame.initScripts = true
		frame:SetScript("OnLeave", function()
				if not EventFrame.shouldShowScrollBar or not Octo_TooltipFrame:IsMouseOver() then
					Octo_TooltipFrame:Hide()
					E.Octo_TooltipFrame_GLOBAL_TABLE = nil
				end
		end)
		frame:SetScript("OnHide", function()
				Octo_TooltipFrame:Hide()
				E.Octo_TooltipFrame_GLOBAL_TABLE = nil
		end)
	end
end
local MyEventsTable = {
	"VARIABLES_LOADED",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")
	self.VARIABLES_LOADED = nil
	self:Create_Octo_TooltipFrame()
end
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_TooltipFrame:Hide()
end