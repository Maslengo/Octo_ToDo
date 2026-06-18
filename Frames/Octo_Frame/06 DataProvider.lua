local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local function func_ShouldShow(id, dataType, profileName)
	local shouldShow = false
	if Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled then
		-- Режим настройки включен - показываем все валюты
		shouldShow = true
	else
		-- Режим настройки выключен - проверяем настройки валют
		local settingsTable = Octo_Todo_DB_Profiles.KEYS.profiles[profileName][dataType] -- dataType
		if settingsTable then
			-- Проверяем числовой ключ
			if settingsTable[id] then
				shouldShow = true
			end
			-- Проверяем строковый ключ
			if settingsTable[tostring(id)] then
				shouldShow = true
			end
		end
	end
	return shouldShow
end
----------------------------------------------------------------
local function func_calculateColumnWidthsLEFT(node)
	local frameData = node:GetData()
	local columnWidthsLEFT = {}
	local textToMeasure = frameData.TextLeft
	local width = E.func_MeasureTextWidth(textToMeasure, E.MIN_COLUMN_WIDTH_LEFT)
	columnWidthsLEFT[1] = width + E.GLOBAL_LINE_HEIGHT + E.GLOBAL_LINE_HEIGHT + E.GLOBAL_LINE_HEIGHT
	return columnWidthsLEFT
end
local function func_calculateColumnWidthsCenter(node)
	local frameData = node:GetData()
	local columnWidthsCenter = {}
	for i = 1, frameData.totalColumns do
		if frameData.TextCenter[i] then
			local textToMeasure = frameData.TextCenter[i]
			local width = E.func_MeasureTextWidth(textToMeasure, E.MIN_COLUMN_WIDTH_CENTER)
			columnWidthsCenter[i] = width
		else
			columnWidthsCenter[i] = E.MIN_COLUMN_WIDTH_CENTER
		end
	end
	return columnWidthsCenter
end
local function func_calculateColumnWidthsCenter_HEADER(nicknameTEXT, serverTEXT)
	return E.func_MeasureTextWidth({nicknameTEXT, serverTEXT}, E.MIN_COLUMN_WIDTH_CENTER)
end


local function func_CalculateMINMAX()
	local CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = E.func_CONFIG_SHOW_ONLY_CURRENT_BATTLETAG()
	local CONFIG_SHOW_ONLY_CURRENT_REGION = E.func_CONFIG_SHOW_ONLY_CURRENT_REGION()
	----------------------------------------------------------------
	local tempTable_ItemLevels = {}
	local tempTable_Money = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if pd then
			if (not CONFIG_SHOW_ONLY_CURRENT_BATTLETAG) or (pd.BattleTag == E.BattleTag) then
				if (not CONFIG_SHOW_ONLY_CURRENT_REGION) or (pd.REGION_NAME == E.CURRENT_REGION_NAME) then
					local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
					table.insert(tempTable_ItemLevels, {sortValue = avgItemLevelEquipped})


					local Money = pd.Money or 0
					table.insert(tempTable_Money, {sortValue = Money})
				end

			end
		end
	end
	E.minValue_ItemLevel, E.maxValue_ItemLevel = E.func_GetMinMaxValue(tempTable_ItemLevels, "sortValue")
	E.minValue_Money, E.maxValue_Money = E.func_GetMinMaxValue(tempTable_Money, "sortValue")
	----------------------------------------------------------------
end

E.displayByType = true
function E.func_MAIN_CreateDataProvider(frame)
	if not E.OctoTables_Vibor then return end
	func_CalculateMINMAX()


	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local columnWidthsLeft = {}
	local columnWidthsCenter = {}
	local ExpansionToShowTBL = E.func_GetData_profileKeys("ExpansionToShow")
	local visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID = E.func_SortCharacters()
	local currentCharacterIndex
	for CharIndex, CharInfo in ipairs(visible) do
		local pd = CharInfo.PlayerData
		if pd.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end
	local totalColumns = #visible
	local firstChar = visible[1]

	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	local HeaderFrameCenter = MAIN_FRAME.pool:Acquire()
	for CharIndex, CharInfo in ipairs(visible) do
		local nicknameTEXT = E.func_CharInfo_NickName(CharInfo)
		local serverTEXT = ""
		columnWidthsCenter[CharIndex] = func_calculateColumnWidthsCenter_HEADER(nicknameTEXT, serverTEXT)
	end
	MAIN_FRAME.pool:Release(HeaderFrameCenter)
	local function processData(categoryKey, dataType, dataEntries)
		for i, entryData in ipairs(dataEntries) do
			local questKey, interfaceVersion_MAX, interfaceVersion_MIN
			local effectiveId
			if dataType == "UniversalQuests" then
				questKey = entryData.questKey
				interfaceVersion_MAX = entryData.interfaceVersion_MAX
				interfaceVersion_MIN = entryData.interfaceVersion_MIN
				effectiveId = entryData  -- сам объект
			else
				effectiveId = entryData.id  -- числовой ID
			end
			local canDraw = false
			if dataType ~= "UniversalQuests" then
				canDraw = func_ShouldShow(effectiveId, dataType, Octo_Todo_DB_Profiles.KEYS.CURRENT)
			else
				canDraw = func_ShouldShow(questKey, dataType, Octo_Todo_DB_Profiles.KEYS.CURRENT)
			end
			if interfaceVersion_MAX and interfaceVersion_MAX < E.interfaceVersion then
				canDraw = false
			end
			if canDraw then
				local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = E.func_Otrisovka_LEFT_Dispatcher(categoryKey, firstChar, dataType, effectiveId)
				canDraw = E.PassSearchFilter(TextLeft, E.searchFilter)
				if canDraw then
					totalLines = totalLines + 1
					local rowData = {
						TextLeft = TextLeft or E.NONE or L["NONE"] or "None",
						IconLeft = IconLeft,
						ColorLeft = E.OctoTables_Vibor[categoryKey] and E.OctoTables_Vibor[categoryKey].color or E.COLOR_BLACK,
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
					for CharIndex, CharInfo in ipairs(visible) do
						local pd = CharInfo.PlayerData
						local TextCenter, ColorCenter, FIRST, SECOND = E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, effectiveId)
						rowData.TextCenter[CharIndex] = TextCenter
						rowData.ColorCenter[CharIndex] = ColorCenter
						rowData.GUID[CharIndex] = pd.GUID
						rowData.FirstReputation[CharIndex] = FIRST or 0
						rowData.SecondReputation[CharIndex] = SECOND or 0
					end
					local node = DataProvider:Insert(rowData)
					node.rowIndex = totalLines
					for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
						columnWidthsLeft[j] = math.max(E.MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
					end
					for j, w in ipairs(func_calculateColumnWidthsCenter(node)) do
						columnWidthsCenter[j] = math.max(E.MIN_COLUMN_WIDTH_CENTER, w, columnWidthsCenter[j] or E.MIN_COLUMN_WIDTH_CENTER)
					end
				end
			end
		end
	end


	if E.displayByType then
		-- Основной цикл:
		for _, dataType in ipairs(E.dataDisplayOrder) do
			for categoryKey in next, E.OctoTables_Vibor do
				if ExpansionToShowTBL[categoryKey] then
					local categoryData = E.OctoTables_DataOtrisovka[categoryKey]
					if categoryData and categoryData[dataType] then
						processData(categoryKey, dataType, categoryData[dataType])
					end
				end
			end
		end
	else
		for categoryKey in next, E.OctoTables_Vibor do
			if ExpansionToShowTBL[categoryKey] then
				local categoryData = E.OctoTables_DataOtrisovka[categoryKey]
				if categoryData then
					for _, dataType in ipairs(E.dataDisplayOrder) do
						if categoryData[dataType] then
							processData(categoryKey, dataType, categoryData[dataType])
						end
					end
				end
			end
		end
	end
	if totalLines == 0 then
		totalLines = 1
		local rowData = {
			TextLeft = E.NONE or L["NONE"] or "None",
			IconLeft = {},
			ColorLeft = {},
			categoryKey = {},
			TextCenter = {},
			ColorCenter = {},
			FirstReputation = {},
			SecondReputation = {},
			GUID = {},
			currentCharacterIndex = 1,
			totalColumns = totalColumns > 0 and totalColumns or 1,
		}
		local node = DataProvider:Insert(rowData)
		node.rowIndex = totalLines
		columnWidthsLeft[1] = math.max(E.MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] or E.MIN_COLUMN_WIDTH_LEFT)
		for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
			columnWidthsLeft[j] = math.max(E.MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
		end
	end
	E.columnWidthsLeft = columnWidthsLeft
	E.columnWidthsCenter = columnWidthsCenter
	E.Update_Octo_MainFrame(frame, DataProvider, totalLines, totalColumns, visible, columnWidthsLeft, columnWidthsCenter)
end
----------------------------------------------------------------
local function CalculateFullRightWidth(columnWidthsCenter, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or E.MAX_COLUMN_COUNT) do
		totalRightWidth = totalRightWidth + (columnWidthsCenter[i] or E.MIN_COLUMN_WIDTH_CENTER)
	end
	return totalRightWidth
end
----------------------------------------------------------------
-- local function CalculateMainFrameHeight(totalLines)
-- 	local LINES_TOTAL = math.floor(E.MAX_FRAME_HEIGHT / E.GLOBAL_LINE_HEIGHT)
-- 	local maxDisplayLines = math.max(1, math.min(totalLines, LINES_TOTAL or totalLines))
-- 	return E.GLOBAL_LINE_HEIGHT * maxDisplayLines + E.HEADER_HEIGHT, maxDisplayLines
-- end


local function CalculateMainFrameHeight(totalLines)
	local maxByScreen = math.floor(E.MAX_FRAME_HEIGHT / E.GLOBAL_LINE_HEIGHT)
	local maxDisplayLines = math.min(E.MAX_DISPLAY_LINES, maxByScreen)  -- берём минимум из 20 и 70% экрана
	maxDisplayLines = math.max(1, math.min(totalLines, maxDisplayLines))
	return E.GLOBAL_LINE_HEIGHT * maxDisplayLines + E.HEADER_HEIGHT, maxDisplayLines
end


----------------------------------------------------------------
local function CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local leftColumnWidth = E.MIN_COLUMN_WIDTH_LEFT + E.INDENT_TEXT
	if columnWidthsLeft and columnWidthsLeft[1] then
		leftColumnWidth = math.max(E.MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] + E.INDENT_TEXT)
	end
	local width = leftColumnWidth + totalRightWidth
	if width % 2 == 1 then
		width = width + 1
	end
	return width
end
----------------------------------------------------------------
local function CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or E.MAX_COLUMN_COUNT) do
		local colWidth = columnWidthsCenter[i] or E.MIN_COLUMN_WIDTH_CENTER
		if (totalRightWidth + colWidth) <= maxRIGHT then
			totalRightWidth = totalRightWidth + colWidth
		else
			break
		end
	end
	return totalRightWidth
end
----------------------------------------------------------------

----------------------------------------------------------------
function E.Update_Octo_MainFrame(frame, DataProvider, totalLines, totalColumns, visible, columnWidthsLeft, columnWidthsCenter)
	if not frame or not frame.scrollContentFrame then return end
	frame.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	frame.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	local leftColumnWidth = math.max(E.MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft and columnWidthsLeft[1] or E.MIN_COLUMN_WIDTH_LEFT)
	local maxRIGHT = E.MAX_FRAME_WIDTH - leftColumnWidth - E.INDENT_TEXT
	if #columnWidthsCenter == 0 and totalColumns > 0 then
		for i = 1, totalColumns do
			columnWidthsCenter[i] = E.MIN_COLUMN_WIDTH_CENTER
		end
	end
	local totalRightWidth = CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, E.MAX_COLUMN_COUNT)
	local totalRightWidth_scrollContentFrame = CalculateFullRightWidth(columnWidthsCenter, E.MAX_COLUMN_COUNT)
	local width = CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local height, maxDisplayLines = CalculateMainFrameHeight(totalLines)
	frame:SetSize(width, height)
	frame.scrollContentFrame:SetSize(totalRightWidth_scrollContentFrame, height)
	E.func_CreateColumnHeaders(frame, visible, columnWidthsCenter)
	-- UpdateCenterColumnPositions
	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	local frames = MAIN_FRAME.ViewCenter:GetFrames()
	if not frames or #frames == 0 then return end
	for _, f in ipairs(frames) do
		local accumulatedWidth = 0
		for i = 1, #columnWidthsCenter do
			if f.columnFrames[i] then
				f.columnFrames[i]:ClearAllPoints()
				f.columnFrames[i]:SetPoint("TOPLEFT", f, "TOPLEFT", accumulatedWidth, 0)
				f.columnFrames[i]:SetWidth(columnWidthsCenter[i])
				accumulatedWidth = accumulatedWidth + columnWidthsCenter[i]
			end
		end
	end
end