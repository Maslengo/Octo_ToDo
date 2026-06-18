local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.SafeTooltipShow(customFrame, ...)
	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	if MAIN_FRAME and MAIN_FRAME:IsShown() then
		E.func_Octo_TooltipFrame_OnEnter(customFrame, ...)
	end
end
----------------------------------------------------------------
function E.GetZebraColor(index, num)
	if E.PROFTBL then
		if (E.PROFTBL and E.PROFTBL.CONFIG_ZEBRA_MODE or 0) ~= num then return 0, 0, 0, 0 end
		local r = E.PROFTBL.ConfigColor_ZEBRA_RGBA_r or 0
		local g = E.PROFTBL.ConfigColor_ZEBRA_RGBA_g or 0
		local b = E.PROFTBL.ConfigColor_ZEBRA_RGBA_b or 0
		local a = E.PROFTBL.ConfigColor_ZEBRA_RGBA_a or 0
		if index % 2 == 0 then
			return 0, 0, 0, 0
		else
			return r, g, b, a
		end
	end
end




local function SetFramePosition(frame, x, y)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x or 0, y or -150)
end



----------------------------------------------------------------
local function setupHorizontalScroll(frame, scrollContentFrame)
	local horizontalScrollFrame = CreateFrame("ScrollFrame", nil, frame)
	frame.horizontalScrollFrame = horizontalScrollFrame
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
	horizontalScrollFrame:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	horizontalScrollFrame:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)
	local horizontalScrollBar = CreateFrame("EventFrame", nil, frame, "OctoWowTrimhorizontalScrollBar")
	horizontalScrollBar.Backplate = horizontalScrollBar:GetRegions()
	horizontalScrollBar.Backplate:Hide()
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
	horizontalScrollBar:RegisterCallback(horizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
			horizontalScrollFrame:SetHorizontalScroll(scrollPercentage * horizontalScrollFrame:GetHorizontalScrollRange())
	end)
	horizontalScrollBar:SetHideIfUnscrollable(true)
	horizontalScrollFrame:SetScrollChild(scrollContentFrame)






	return horizontalScrollFrame
end
local function setupLeftScrollBox(frame, horizontalScrollFrame)
	frame.ScrollBoxLEFT = CreateFrame("FRAME", nil, frame, "WowScrollBoxList")
	frame.ScrollBoxLEFT:SetWidth(E.INDENT_TEXT + E.MIN_COLUMN_WIDTH_LEFT)
	frame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	frame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	frame.ScrollBoxLEFT:SetFrameLevel(frame.ScrollBoxLEFT:GetFrameLevel() + 1)
	horizontalScrollFrame:SetPoint("TOPLEFT", frame.ScrollBoxLEFT, "TOPRIGHT", 0, E.HEADER_HEIGHT)
	horizontalScrollFrame:SetPoint("BOTTOMRIGHT")
	frame.ViewLeft = CreateScrollBoxListTreeListView(0)
	frame.ViewLeft:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	frame.ViewLeft:SetElementInitializer("OctoRectTemplate", function(...) E.func_InitLEFT(...) end)
	frame.ViewLeft:RegisterCallback(frame.ViewLeft.Event.OnAcquiredFrame, E.func_OnAcquiredLeft, frame)
end
local function setupCenterScrollBox(frame, scrollContentFrame)
	frame.ScrollBoxCenter = CreateFrame("FRAME", nil, scrollContentFrame, "WowScrollBoxList")
	frame.ScrollBoxCenter:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	frame.ScrollBoxCenter:SetPoint("BOTTOMRIGHT")
	frame.ScrollBarCenter = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	frame.ScrollBarCenter:SetPoint("TOPLEFT", frame, "TOPRIGHT", 6, 0)
	frame.ScrollBarCenter:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 6, 0)
	frame.ViewCenter = CreateScrollBoxListTreeListView(0)
	frame.ViewCenter:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	frame.ViewCenter:SetElementInitializer("OctoRectTemplate", function(...) E.func_InitCenter(...) end)
	frame.ViewCenter:RegisterCallback(frame.ViewCenter.Event.OnAcquiredFrame, E.func_OnAcquiredCenter, frame)
end
local function registerScrollBoxPair(scrollBox, scrollBar, scrollBoxView)
	E.func_RegisterWithScrollBar(scrollBox, scrollBar)
	E.func_RegisterWithScrollBox(scrollBox, scrollBar)
	scrollBox:Init(scrollBoxView)
	E.func_ApplyInterpolationCompatibility(scrollBox, scrollBar)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollBox, scrollBar)
end
local function setupMouseHandlers(frame, frameName)
	frame:EnableMouse(true)
	frame:SetMovable(true)


	frame:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			frame:StartMoving()
		elseif button == "MiddleButton" then
			E.isPanning = true
		end
	end)

	frame:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			frame:StopMovingOrSizing() -- ПЕРЕПРИВЯЗЫВАЕТ ПОЗИЦИИ
			E.func_ClampFrameToScreen(frame)   -- <-- проверяем, не уехал ли за экран
			E.SaveFramePositionNormalized(frame)
		elseif button == "MiddleButton" then
			E.isPanning = false
		end
	end)

	frame:SetScript("OnUpdate", function(self, elapsed)
		E.func_OnUpdate(frame, elapsed)
	end)
	frame:RegisterForClicks("RightButtonUp")
	frame:SetScript("OnClick", frame.Hide)
end
----------------------------------------------------------------
-- Основная функция создания главного фрейма
function E.func_CreateMainFrame(frameName)
	if not frameName or E[frameName] then return end

	local frame = CreateFrame("BUTTON", frameName, UIParent, "OctoBackdropTemplate")
	frame:Hide()
	E[frameName] = frame
	E.func_RegisterFrame_ICONS(frame)
	table.insert(E.OctoTable_ColoredFrames, frame)

	-- Инициализация для режима сохранения позиции (если нужен)
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if settingsProfile.CONFIG_SAVE_POSITION then
		settingsProfile.FramePosition = settingsProfile.FramePosition or {}
		settingsProfile.FramePosition[frameName] = settingsProfile.FramePosition[frameName] or {}
	end

	frame:SetSize(100, 100)
	frame:SetClampedToScreen(settingsProfile.Config_ClampedToScreen)
	frame:SetFrameStrata("HIGH")
	-- Не вызываем SetDontSavePosition(true) в новом режиме, чтобы разрешить перемещение
	do
		local width = frame:GetWidth()
		local screenWidth = UIParent:GetWidth()
		local xOffset = (screenWidth - width) * 0.5
		SetFramePosition(frame, xOffset, -150) -- SetPoint("TOP", UIParent, "TOP", 0, -150)
	end

	frame:HookScript("OnShow", function()
		Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled = false
		E.func_Collect_All()
		E.func_UPDATE_MAINFRAME(frame)



		if settingsProfile.CONFIG_SAVE_POSITION then
			local pos = settingsProfile.FramePosition and settingsProfile.FramePosition[frameName]
			if pos and pos.xOfs and pos.yOfs then
				-- Восстанавливаем позицию из сохранения
				SetFramePosition(frame, pos.xOfs, pos.yOfs)
			else
				E.func_ClampFrameToScreen(frame, true)
				-- SetFramePosition()
			end
		else
			local width = frame:GetWidth()
			local screenWidth = UIParent:GetWidth()
			local xOffset = (screenWidth - width) * 0.5
			E.SaveFramePositionNormalized(frame, xOffset, -150)
		end
		E.func_ClampFrameToScreen(frame)
	end)

	-- Создание скроллов
	local scrollContentFrame = CreateFrame("FRAME", "scrollContentFrame")
	frame.scrollContentFrame = scrollContentFrame
	local horizontalScrollFrame = setupHorizontalScroll(frame, scrollContentFrame)
	setupLeftScrollBox(frame, horizontalScrollFrame)
	setupCenterScrollBox(frame, scrollContentFrame)
	registerScrollBoxPair(frame.ScrollBoxLEFT, frame.ScrollBarCenter, frame.ViewLeft)
	registerScrollBoxPair(frame.ScrollBoxCenter, frame.ScrollBarCenter, frame.ViewCenter)
	setupMouseHandlers(frame, frameName)
	E.func_createPool(frame, scrollContentFrame)
	return frame
end
----------------------------------------------------------------
function E.func_main_frame_toggle(frame)
	if not frame then return end
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if settingsProfile.CONFIG_SAVE_POSITION then
		-- Режим B: просто переключаем видимость
		frame:SetShown(not frame:IsShown())
	else
		-- Режим A: классическое поведение – пересчёт позиции при открытии
		if not frame:IsShown() then
			-- При открытии получаем текущие координаты фрейма и перепривязываем к BOTTOMLEFT
			local left = frame:GetLeft()
			local top = frame:GetTop()
			E.SaveFramePositionNormalized(frame, left, top)
			frame:Show()
		else
			frame:Hide()
		end
	end
end
----------------------------------------------------------------
function E.func_UPDATE_MAINFRAME(frameOrFrameName)
	if not frameOrFrameName then return end
	local frame
	if type(frameOrFrameName) == "string" then
		frame = E.FRAMES[frameOrFrameName]
	elseif type(frameOrFrameName) == "table" then
		frame = frameOrFrameName
	end
	if not frame then return end
	if frame and frame:IsShown() then
		if (Octo_TooltipFrame and not Octo_TooltipFrame:IsShown()) then
			E.func_MAIN_CreateDataProvider(frame)
		end
	end
end
----------------------------------------------------------------
function E.func_ClampFrameToScreen(frame, firstRUN)
	if not frame then return end

	local left = frame:GetLeft()
	local top = frame:GetTop()
	if not left or not top then return false end

	local width = frame:GetWidth()
	local height = frame:GetHeight()
	local right = left + width
	local bottom = top - height

	local screenLeft = 0
	local screenRight = UIParent:GetWidth()
	local screenTop = UIParent:GetHeight()
	local screenBottom = 0
	if not firstRUN then
		-- Проверяем, что фрейм хотя бы частично виден (порог 10 пикселей)
		local isVisible = (right > screenLeft + 10 and left < screenRight - 10 and bottom < screenTop - 10 and top > screenBottom + 10)

		if isVisible then
			return true
		end
	end

	-- Сброс в дефолтную позицию
	local screenWidth = screenRight - screenLeft
	local xOffset = (screenWidth - width) * .5
	-- Обновляем сохранённую позицию (используем frame:GetName())
	E.SaveFramePositionNormalized(frame, xOffset, -150)
end

-- Сохраняет позицию frame в FramePosition[frameName], всегда привязывая к TOPLEFT
function E.SaveFramePositionNormalized(frame, x, y)
	local frameName = frame:GetName()
	x = x or frame:GetLeft()
	local top = frame:GetTop()
	if not x or not top then return end
	y = y or top - UIParent:GetHeight()

	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if settingsProfile.CONFIG_SAVE_POSITION then
		settingsProfile.FramePosition = settingsProfile.FramePosition or {}
		settingsProfile.FramePosition[frameName] = settingsProfile.FramePosition[frameName] or {}

		settingsProfile.FramePosition[frame:GetName()] = {
			point = "TOPLEFT",
			relativePoint = "TOPLEFT",
			xOfs = x,
			yOfs = y,
		}
	end
	SetFramePosition(frame, x, y)
end