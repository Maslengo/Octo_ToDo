local GlobalAddonName, E = ...
local INDENT_TEXT = 4
local INDEND_SCROLL = 20
local MIN_COLUMN_WIDTH = 30
local MAX_DISPLAY_LINES = 32
local LINES_TOTAL = math.floor(math.floor(E.PHYSICAL_SCREEN_HEIGHT/E.GLOBAL_LINE_HEIGHT)*.7)
if MAX_DISPLAY_LINES > LINES_TOTAL then
	MAX_DISPLAY_LINES = LINES_TOTAL
end
local charR, charG, charB = 1, 1, 1
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local EventFrame = CreateFrame("FRAME")
local EquipmentsFrame = CreateFrame("BUTTON", "EquipmentsFrame", UIParent, "BackDropTemplate")
EquipmentsFrame:Hide()
E.func_RegisterFrame_SIMPLE(EquipmentsFrame)
local NameHeader = CreateFrame("FRAME", nil, EquipmentsFrame)
EventFrame.columnWidths = {}
EventFrame.columnTypes = {}
EventFrame.columnCount = 0
local function GetColumnCount(rowData)
	local maxColumn = 0
	for key in pairs(rowData) do
		local columnNum = tonumber(key:match("column(%d+)"))
		if columnNum and columnNum > maxColumn then
			maxColumn = columnNum
		end
	end
	return maxColumn
end
local function CalculateMainFrameWidth(columnWidths)
	local totalWidth = 0
	for i = 1, #columnWidths do
		totalWidth = totalWidth + (columnWidths[i] or 0)
	end
	return totalWidth
end
local function CalculateMainFrameHeight(totalLines)
	local displayLines = math.min(totalLines, MAX_DISPLAY_LINES)
	if displayLines == 0 then displayLines = 1 end
	return (E.GLOBAL_LINE_HEIGHT * displayLines) + (E.GLOBAL_LINE_HEIGHT*2), displayLines
end
local function UpdateColumnPositionsAndSizes(frame, columnWidths)
	if not columnWidths or #columnWidths == 0 then
		return
	end
	local accumulatedWidth = 0
	for i = 1, #columnWidths do
		local columnFrame = frame.columnFrames[i]
		if not columnFrame then
			break
		end
		local columnWidth = columnWidths[i] or (EventFrame.columnTypes[i] == "icon" and E.GLOBAL_LINE_HEIGHT or MIN_COLUMN_WIDTH)
		columnFrame:ClearAllPoints()
		columnFrame:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
		if columnFrame.type == "icon" then
			columnFrame:SetSize(columnWidth, E.GLOBAL_LINE_HEIGHT)
		else
			columnFrame:SetWidth(columnWidth)
		end
		accumulatedWidth = accumulatedWidth + columnWidth
	end
end
function EventFrame:Create_NameHeader()
	NameHeader:SetPoint("TOPLEFT", EquipmentsFrame, "TOPLEFT")
	NameHeader:SetPoint("TOPRIGHT", EquipmentsFrame, "TOPRIGHT")
	NameHeader:SetHeight((E.GLOBAL_LINE_HEIGHT*2))
	NameHeader.Nickname = NameHeader:CreateFontString()
	NameHeader.Nickname:SetFontObject(OctoFont11)
	NameHeader.Server = NameHeader:CreateFontString()
	NameHeader.Server:SetFontObject(OctoFont11)

	NameHeader.Nickname:SetPoint("CENTER", 0, E.HEADER_TEXT_OFFSET)
	if Octo_ToDo_DB_Vars.isOnlyCurrentServer then
		NameHeader.Nickname:SetPoint("CENTER")
	end
	NameHeader.Nickname:SetWordWrap(false)
	NameHeader.Nickname:SetJustifyV("MIDDLE")
	NameHeader.Nickname:SetJustifyH("CENTER")
	NameHeader.Nickname:SetText("playerNameText")
	NameHeader.Server:SetPoint("CENTER", 0, -E.HEADER_TEXT_OFFSET)
	NameHeader.Server:SetWordWrap(false)
	NameHeader.Server:SetJustifyV("BOTTOM")
	NameHeader.Server:SetJustifyH("CENTER")
	NameHeader.Server:SetText("playerServerText")


	NameHeader.CharTexture = NameHeader:CreateTexture(nil, "BACKGROUND", nil, -3)
	NameHeader.CharTexture:SetAllPoints()
	NameHeader.CharTexture:SetTexture(E.TEXTURE_CHAR_PATH)



	NameHeader.DurabilityTexture = NameHeader:CreateTexture(nil, "BACKGROUND", nil, -2)
	NameHeader.DurabilityTexture:Hide()
	NameHeader.DurabilityTexture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
	NameHeader.DurabilityTexture:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
	-- NameHeader.DurabilityTexture:SetDrawLayer("OVERLAY", 2)
	NameHeader.DurabilityTexture:SetPoint("TOPRIGHT")
	NameHeader.DurabilityTexture:SetTexture(136241)


	-- PlayerDurability < 100 and durColor..PlayerDurability.."%|r"..E.func_texturefromIcon(136241) or ""

end
local func_OnAcquired do
	local function Create_Icon(frame)
		local icon = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		icon:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		icon:Hide()
		return icon
	end
	local function Create_Text(frame, justifyH)
		local text = frame:CreateFontString()
		text:SetFontObject(OctoFont11)
		text:SetJustifyV("MIDDLE")
		-- text:SetTextColor(1, 1, 1, 1)
		text:SetWordWrap(false)
		text:SetJustifyH(justifyH or "LEFT")
		return text
	end
	local function Create_Highlight(frame, owner)
		local Highlight = CreateFrame("BUTTON", nil, owner, "OctoHighlightAnimationTemplate")
		Highlight:SetPropagateMouseClicks(true)
		Highlight:SetPropagateMouseMotion(true)
		Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
		if E.ENABLE_HIGHLIGHT_ANIMATION then
			Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD")
			Highlight.HighlightTexture = Highlight:GetHighlightTexture()
			Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
		end
		Highlight:SetPoint("LEFT", frame)
		Highlight:SetPoint("TOP", frame)
		Highlight:SetPoint("BOTTOM", frame)
		Highlight:SetPoint("RIGHT")
		return Highlight
	end

	function func_OnAcquired(owner, frame, node, new)
		if new then
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			frame:SetHitRectInsets(1, 1, 1, 1)
			frame.columnFrames = setmetatable({}, {
					__index = function(self, key)
						if key then
							local columnFrame = CreateFrame("BUTTON", "columnFrame"..key, frame)
							columnFrame:Hide()
							columnFrame:SetPropagateMouseClicks(true)
							columnFrame:SetPropagateMouseMotion(true)
							columnFrame:SetHeight(E.GLOBAL_LINE_HEIGHT)
							local colType = EventFrame.columnTypes[key]
							if colType == "icon" then
								columnFrame.type = "icon"
								columnFrame.texture = Create_Icon(columnFrame)
								columnFrame.texture:SetPoint("CENTER")
								columnFrame:SetSize(E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
							else
								columnFrame.type = "text"
								if key == 3 then
									columnFrame.text = Create_Text(columnFrame, "CENTER")
								else
									columnFrame.text = Create_Text(columnFrame, "LEFT")
								end
								-- AdditionalSettings(columnFrame)
								columnFrame.text:SetAllPoints()
								columnFrame:SetWidth(MIN_COLUMN_WIDTH)
							end
							rawset(self, key, columnFrame)
							return columnFrame
						end
						return nil
					end
			})
			frame.Highlight = Create_Highlight(frame, owner)
			frame:SetScript("OnHide", function()
					if frame.Highlight then
						frame.Highlight:Hide()
					end
			end)
			frame:SetScript("OnShow", function()
					if frame.Highlight then
						frame.Highlight:Show()
					end
			end)
		end
	end
end
function EventFrame:CalculateColumnWidths(rowData, columnMaxWidths)
	local maxColumn = GetColumnCount(rowData)
	for i = 1, maxColumn do
		local iconKey = "column"..i.."Icon"
		local textKey = "column"..i.."Text"
		local hasIcon = rowData[iconKey] ~= nil
		local hasText = rowData[textKey] and rowData[textKey] ~= ""
		if hasIcon then
			EventFrame.columnTypes[i] = "icon"
		elseif not EventFrame.columnTypes[i] then
			EventFrame.columnTypes[i] = "text"
		end
		local dataWidth = 0
		if hasIcon then
			dataWidth = E.GLOBAL_LINE_HEIGHT
		elseif hasText then
			local textToMeasure = rowData[textKey]
			dataWidth = E.func_MeasureTextWidth(textToMeasure) + INDENT_TEXT * 2
		else
			dataWidth = EventFrame.columnTypes[i] == "icon" and E.GLOBAL_LINE_HEIGHT or MIN_COLUMN_WIDTH
		end
		local finalWidth = dataWidth
		if EventFrame.columnTypes[i] == "text" then
			finalWidth = math.max(finalWidth, MIN_COLUMN_WIDTH)
		end
		if not columnMaxWidths[i] or finalWidth > columnMaxWidths[i] then
			columnMaxWidths[i] = finalWidth
		end
	end
	return maxColumn
end
function EventFrame:Octo_Frame_init(frame, node)
	local frameData = node:GetData()
	local columnWidths = EventFrame.columnWidths
	local columnCount = EventFrame.columnCount
	UpdateColumnPositionsAndSizes(frame, columnWidths)
	for i = 1, columnCount do
		local columnFrame = frame.columnFrames[i]
		if columnFrame then
			if columnFrame.type == "icon" then
				local icon = frameData["column"..i.."Icon"]
				if icon then
					columnFrame.texture:SetTexture(icon)
					columnFrame.texture:Show()
					columnFrame:Show()
				else
					columnFrame.texture:Hide()
					columnFrame:Hide()
				end
			else
				local text = frameData["column"..i.."Text"] or ""
				columnFrame.text:SetText(text)
				columnFrame:Show()
				if i == 2 then
					local itemLink = frameData.ItemLink
					columnFrame:SetScript("OnEnter", function(self)
							if itemLink and itemLink ~= "" then
								GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
								GameTooltip:SetHyperlink(itemLink)
								GameTooltip:Show()
							end
					end)
					columnFrame:SetScript("OnLeave", function(self)
							GameTooltip:Hide()
					end)
				end
			end
		end
	end
	for i = columnCount + 1, #frame.columnFrames do
		if frame.columnFrames[i] then
			frame.columnFrames[i]:Hide()
		end
	end
end
function EventFrame:UpdateMainFrameUI(DataProvider, totalLines, columnWidths, CharInfo)
	if not EquipmentsFrame or not EquipmentsFrame.view then
		return
	end

	NameHeader.Nickname:SetPoint("CENTER", 0, E.HEADER_TEXT_OFFSET)
	if Octo_ToDo_DB_Vars.isOnlyCurrentServer then
		NameHeader.Nickname:SetPoint("CENTER")
	end

	NameHeader.Nickname:SetText(E.func_TextCenter_Chars_nickname(CharInfo)) -- playerNameText
	NameHeader.Server:SetText(E.func_TextCenter_Chars_server(CharInfo)) -- playerServerText







	local pd = CharInfo.PlayerData
	local faction = pd.Faction or "Neutral"

	if faction == "Horde" then
		charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_HORDE)
	elseif faction == "Alliance" then
		charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_ALLIANCE)
	elseif faction == "Neutral" then
		charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_NEUTRAL)
	end
	NameHeader.CharTexture:SetVertexColor(charR, charG, charB, E.currentCHAR_ALPHA or 0.2)

	EquipmentsFrame.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	local width = CalculateMainFrameWidth(columnWidths)
	local height, displayLines = CalculateMainFrameHeight(totalLines)
	EquipmentsFrame:SetSize(width, height)
	local frames = EquipmentsFrame.view:GetFrames()
	for _, frame in ipairs(frames) do
		UpdateColumnPositionsAndSizes(frame, columnWidths)
	end
	EquipmentsFrame.ScrollBox:ClearAllPoints()
	EquipmentsFrame.ScrollBox:SetPoint("TOPLEFT", 0, -(E.GLOBAL_LINE_HEIGHT*2))
	EquipmentsFrame.ScrollBox:SetPoint("BOTTOMRIGHT")
end
function EventFrame:CreateDataProvider(GUID)
	local GUID = GUID or E.curGUID
	local CharInfo = Octo_ToDo_DB_Levels[GUID]
	local pd = CharInfo.PlayerData
	local InventoryType = pd.InventoryType or {}
	local DataProvider = CreateTreeDataProvider()
	local columnMaxWidths = {}
	local totalLines = 0
	local maxColumnCount = 0
	local classColorHex = pd.classColorHex or ""
	local Name = pd.Name or ""
	local specIcon = pd.specIcon or 0
	local specTexture = E.func_texturefromIcon(specIcon)
	local curServer = pd.curServer or ""
	local resultName = specTexture..classColorHex..Name.."|r"
	local PlayerItemLevel = ""
	if pd.avgItemLevelEquipped and pd.avgItemLevel then
		PlayerItemLevel = E.func_GetColorGradient(pd.avgItemLevelEquipped, E.minValue_ItemLevel, E.maxValue_ItemLevel)..pd.avgItemLevelEquipped
		if pd.avgItemLevel > pd.avgItemLevelEquipped then
			PlayerItemLevel = PlayerItemLevel.."/"..pd.avgItemLevel.."|r"
		end
		if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
			PlayerItemLevel = PlayerItemLevel..E.COLOR_GREEN.."+|r"
		end
	end


	for slotID in next, E.OctoTable_SlotMapping do
		totalLines = totalLines + 1
		local v = InventoryType[slotID] or {}
		local ItemID = v.ItemID or 0
		local Icon = v.Icon or E.func_GetEmptySlotIcon(slotID) or 134400
		local ItemLink = v.ItemLink or ""
		local Quality = v.Quality or 0
		local CurrentItemLevel = v.CurrentItemLevel or 0
		local ItemInventoryType = v.ItemInventoryType or 0
		local color = E.func_GetQualityHexColor(Quality)
		local slotName = E.func_GetSlotNameForEmptySlot(slotID)
		local current_Durability = v.current_Durability or 0
		local maximum_Durability = v.maximum_Durability or 0
		local ItemName = v.ItemName and E.func_GetItemName(ItemID, Quality) or E.COLOR_GRAY..EMPTY.." ("..slotName..")|r"
		local rowData = {
			ItemLink = v.ItemLink,
			slotID = slotID,
			column1Icon = Icon,
			column2Text = color..ItemName.."|r",
			column3Text = CurrentItemLevel > 0 and color..CurrentItemLevel.."|r" or "",
		}
		local columnCount = self:CalculateColumnWidths(rowData, columnMaxWidths)
		maxColumnCount = math.max(maxColumnCount, columnCount)
		DataProvider:Insert(rowData)
	end
	EventFrame.columnCount = maxColumnCount
	if totalLines == 0 then
		totalLines = 1
		local rowData = {}
		for i = 1, maxColumnCount do
			if columnMaxWidths[i] then
				if EventFrame.columnTypes[i] == "icon" then
					rowData["column"..i.."Icon"] = nil
				else
					rowData["column"..i.."Text"] = ""
				end
			else
				rowData["column"..i.."Text"] = ""
			end
		end
		self:CalculateColumnWidths(rowData, columnMaxWidths)
		DataProvider:Insert(rowData)
	end
	EventFrame.totalLines = totalLines
	EventFrame.columnWidths = {}
	for i = 1, maxColumnCount do
		EventFrame.columnWidths[i] = columnMaxWidths[i] or (EventFrame.columnTypes[i] == "icon" and E.GLOBAL_LINE_HEIGHT or MIN_COLUMN_WIDTH)
	end
	local totalWidth = CalculateMainFrameWidth(EventFrame.columnWidths)
	EventFrame.shouldShowScrollBar = MAX_DISPLAY_LINES < totalLines
	local displayLines = math.min(totalLines, MAX_DISPLAY_LINES)
	if displayLines == 0 then displayLines = 1 end
	local totalHeight = (E.GLOBAL_LINE_HEIGHT * displayLines) + (E.GLOBAL_LINE_HEIGHT*2)
	EquipmentsFrame:SetSize(totalWidth, totalHeight)
	EquipmentsFrame.ScrollBox:ClearAllPoints()
	EquipmentsFrame.ScrollBox:SetPoint("TOPLEFT", 0, -(E.GLOBAL_LINE_HEIGHT*2))
	EquipmentsFrame.ScrollBox:SetPoint("BOTTOMRIGHT")
	DataProvider:SetSortComparator(function(a, b)
			local aSlot = a:GetData().slotID
			local bSlot = b:GetData().slotID
			local aPrio = E.OctoTable_SlotMapping[aSlot].priority or math.huge
			local bPrio = E.OctoTable_SlotMapping[bSlot].priority or math.huge
			return aPrio < bPrio
	end)
	DataProvider:Sort()
	self:UpdateMainFrameUI(DataProvider, totalLines, EventFrame.columnWidths, CharInfo)
end
function EventFrame:Create_EquipmentsFrame()
	EquipmentsFrame:SetBackdrop(E.menuBackdrop)
	EquipmentsFrame:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA)
	EquipmentsFrame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)

	EquipmentsFrame:SetHitRectInsets(-1, -1, -1, -1)
	EquipmentsFrame:SetScript("OnShow", function()
			local scrollBar = EquipmentsFrame.ScrollBar
			local shouldShow = EventFrame.shouldShowScrollBar
			if shouldShow ~= scrollBar:IsShown() then
				if shouldShow then
					scrollBar:Show()
				else
					scrollBar:Hide()
				end
			end
	end)
	EquipmentsFrame:SetSize(1, E.GLOBAL_LINE_HEIGHT*1 + (E.GLOBAL_LINE_HEIGHT*2))
	EquipmentsFrame:SetDontSavePosition(true)
	EquipmentsFrame:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	EquipmentsFrame:SetFrameStrata("HIGH")
	EquipmentsFrame:SetPoint("TOPLEFT", 0, -150)
	EquipmentsFrame:EnableMouse(true)
	EquipmentsFrame:SetMovable(true)
	EquipmentsFrame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				EquipmentsFrame:StartMoving()
			end
	end)
	EquipmentsFrame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				EquipmentsFrame:StopMovingOrSizing()
				local left = EquipmentsFrame:GetLeft()
				local top = EquipmentsFrame:GetTop()
				EquipmentsFrame:ClearAllPoints()
				EquipmentsFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
			end
	end)
	EquipmentsFrame:RegisterForClicks("RightButtonUp")
	EquipmentsFrame:SetScript("OnClick", function(self)
			self:Hide()
	end)
	EquipmentsFrame.ScrollBox = CreateFrame("FRAME", nil, EquipmentsFrame, "WowScrollBoxList")
	EquipmentsFrame.ScrollBox:SetPoint("TOPLEFT", 0, -(E.GLOBAL_LINE_HEIGHT*2))
	EquipmentsFrame.ScrollBox:SetPoint("BOTTOMRIGHT")
	EquipmentsFrame.ScrollBox:SetPropagateMouseClicks(false)
	EquipmentsFrame.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	EquipmentsFrame.ScrollBox:Layout()
	EquipmentsFrame.ScrollBar = CreateFrame("EventFrame", nil, EquipmentsFrame, "MinimalScrollBar")
	EquipmentsFrame.ScrollBar:SetPoint("TOPLEFT", EquipmentsFrame.ScrollBox, "TOPRIGHT", 6, 0)
	EquipmentsFrame.ScrollBar:SetPoint("BOTTOMLEFT", EquipmentsFrame.ScrollBox, "BOTTOMRIGHT", 6, 0)
	EquipmentsFrame.view = CreateScrollBoxListTreeListView()
	EquipmentsFrame.view:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	EquipmentsFrame.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	EquipmentsFrame.view:RegisterCallback(EquipmentsFrame.view.Event.OnAcquiredFrame, func_OnAcquired, EquipmentsFrame)
	ScrollUtil.InitScrollBoxListWithScrollBar(EquipmentsFrame.ScrollBox, EquipmentsFrame.ScrollBar, EquipmentsFrame.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(EquipmentsFrame.ScrollBox, EquipmentsFrame.ScrollBar)
end
EquipmentsFrame.lastGUID = nil
function E.Toggle_EquipmentsFrame(GUID)
	GUID = GUID or E.curGUID
	local isSameGUID = EquipmentsFrame.lastGUID == GUID
	if EquipmentsFrame:IsShown() then
		if isSameGUID then
			EquipmentsFrame:Hide()
			if EquipmentsFrame.updateTimer then
				EquipmentsFrame.updateTimer:Cancel()
				EquipmentsFrame.updateTimer = nil
			end
			EquipmentsFrame.lastGUID = nil
		else
			EquipmentsFrame.lastGUID = GUID
			E.Collect_Equipments()
			EventFrame:CreateDataProvider(GUID)
		end
	else
		EquipmentsFrame:Show()
		EquipmentsFrame.lastGUID = GUID
		if EquipmentsFrame.updateTimer then
			EquipmentsFrame.updateTimer:Cancel()
			EquipmentsFrame.updateTimer = nil
		end
		EquipmentsFrame.updateTimer = C_Timer.NewTicker(2, function()
				if EquipmentsFrame:IsShown() then
					E.Collect_Equipments()
					EventFrame:CreateDataProvider(EquipmentsFrame.lastGUID)
				else
					if EquipmentsFrame.updateTimer then
						EquipmentsFrame.updateTimer:Cancel()
						EquipmentsFrame.updateTimer = nil
					end
				end
		end)
		E.Collect_Equipments()
		EventFrame:CreateDataProvider(GUID)
	end
end





local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	EventFrame:Create_EquipmentsFrame()
	EventFrame:Create_NameHeader()
end
function EventFrame:PLAYER_REGEN_DISABLED()
	EquipmentsFrame:Hide()
	if EquipmentsFrame.updateTimer then
		EquipmentsFrame.updateTimer:Cancel()
		EquipmentsFrame.updateTimer = nil
	end
end