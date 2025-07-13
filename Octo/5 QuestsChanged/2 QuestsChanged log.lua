local GlobalAddonName, E = ...
local enable = true
if not enable then return end
local floor = math.floor
local QC_Quests, copybox
function E:BuildLog()
	if _G.TabSystemOwnerMixin then
		QC_Quests = CreateFrame("Frame", "QuestsChangedFrame", UIParent, "UIPanelDialogTemplate, TabSystemOwnerTemplate")
	else
		QC_Quests = CreateFrame("Frame", "QuestsChangedFrame", UIParent, "UIPanelDialogTemplate")
	end
	QC_Quests:EnableMouse(true)
	QC_Quests:SetMovable(true)
	QC_Quests:SetClampedToScreen(true)
	QC_Quests:SetFrameStrata("DIALOG")
	QC_Quests:SetSize(600, 500)
	QC_Quests:SetPoint("TOP", 0, -80)
	QC_Quests:Hide()
	tinsert(UISpecialFrames, QC_Quests:GetName())
	QC_Quests.Title:SetText(GlobalAddonName)
	local drag = CreateFrame("Frame", "$parentTitleButton", QC_Quests, "TitleDragAreaTemplate")
	drag:SetPoint("TOPLEFT", _G["QuestsChangedFrameTitleBG"])
	drag:SetPoint("BOTTOMRIGHT", _G["QuestsChangedFrameTitleBG"])
	QC_Quests.Quests = self:BuildQuestLog()
	if C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED") then
		QC_Quests.Vignettes = self:BuildVignetteLog()
		QC_Quests.Vignettes:Hide()
	end
	if QC_Quests.TabSystem then
		QC_Quests.TabSystem = CreateFrame("Frame", nil, QC_Quests, "TabSystemTemplate")
		QC_Quests.TabSystem:SetPoint("TOPLEFT", QC_Quests, "BOTTOMLEFT", 22, 6)
		QC_Quests:SetTabSystem(QC_Quests.TabSystem)
		QC_Quests.Quests:Show()
		QC_Quests.questTabID = QC_Quests:AddNamedTab(QUESTS_LABEL, QC_Quests.Quests)
		if VIGNETTES then
			QC_Quests.vignettesTabID = QC_Quests:AddNamedTab("Vignettes", QC_Quests.Vignettes)
		end
		QC_Quests:SetTab(QC_Quests.questTabID)
	elseif C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED") then
		local QuestButton = CreateFrame("EventButton", nil, QC_Quests, "UIPanelButtonTemplate")
		QuestButton:SetText(QUESTS_LABEL)
		QuestButton:SetSize(120, 22)
		QuestButton:SetPoint("TOP", QC_Quests, "BOTTOM", -71, 8)
		QuestButton:SetScript("OnClick", function()
				QC_Quests.Vignettes:Hide()
				QC_Quests.Quests:Show()
		end)
		local VignetteButton = CreateFrame("EventButton", nil, QC_Quests, "UIPanelButtonTemplate")
		VignetteButton:SetText("Vignettes")
		VignetteButton:SetSize(120, 22)
		VignetteButton:SetPoint("LEFT", QuestButton, "RIGHT", 22, 0)
		VignetteButton:SetScript("OnClick", function()
				QC_Quests.Quests:Hide()
				QC_Quests.Vignettes:Show()
		end)
	end
end
function E:BuildLogPanel(initializer, dataProvider)
	local Container = CreateFrame("Frame", nil, QC_Quests)
	Container:SetPoint("TOPLEFT", 12, -32)
	Container:SetPoint("BOTTOMRIGHT", -3, 4)
	local ScrollBar = CreateFrame("EventFrame", nil, Container, "WowTrimScrollBar")
	ScrollBar:SetPoint("TOPRIGHT", 0, 5)
	ScrollBar:SetPoint("BOTTOMRIGHT", 0, 2)
	Container.ScrollBar = ScrollBar
	local ScrollBox = CreateFrame("Frame", nil, Container, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT")
	ScrollBox:SetPoint("BOTTOMRIGHT", ScrollBar, "BOTTOMLEFT", -2, 2)
	Container.ScrollBox = ScrollBox
	local ScrollView = CreateScrollBoxListLinearView()
	ScrollView:SetDataProvider(dataProvider, ScrollBoxConstants.RetainScrollPosition)
	ScrollView:SetElementExtent(32)  -- Fixed height for each row; required as we're not using XML.
	ScrollView:SetElementInitializer("Button", initializer)
	Container.ScrollView = ScrollView
	ScrollUtil.InitScrollBoxWithScrollBar(ScrollBox, ScrollBar, ScrollView)
	-- This causes errors when removing lines:
	-- Container:SetScript("OnShow", function()
	--     -- for the timestamps
	--     ScrollView:Rebuild()
	-- end)
	return Container
end
function E:BuildQuestLog()
	local function Line_OnEnter(self)
		local quest = self.data
		if quest then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:AddLine(E.quest_names[quest.id] or UNKNOWN)
			GameTooltip:AddDoubleLine("id", quest.id)
			GameTooltip:AddDoubleLine("mapID", quest.mapID)
			if quest.level then
				-- pre-8.0
				GameTooltip:AddDoubleLine("level", quest.level)
			end
			GameTooltip:AddDoubleLine("coords", ("%.2f, %.2f"):format(quest.x * 100, quest.y * 100))
			GameTooltip:AddDoubleLine("time", quest.time)
			GameTooltip:AddDoubleLine(" ", date("%c", quest.time))
			if C_QuestLog.IsQuestFlaggedCompletedOnAccount and C_QuestLog.IsQuestFlaggedCompletedOnAccount(quest.id) then
				GameTooltip:AddLine(ACCOUNT_COMPLETED_QUEST_LABEL, ACCOUNT_WIDE_FONT_COLOR:GetRGB())
			end
			GameTooltip:AddLine("Left-click for waypoint", 0, 1, 1)
			GameTooltip:AddLine("Shift-click to copy", 0, 1, 1)
			GameTooltip:AddLine("Right-click to remove", 0, 1, 1)
			GameTooltip:Show()
		end
	end
	local function Line_OnClick(self, button, down)
		local quest = self.data
		if button == "RightButton" then
			E:RemoveQuest(quest)
		elseif IsShiftKeyDown() then
			StaticPopup_Show("QuestsChanged_CopyBox", nil, nil, ("[%d] = {quest=%d},"):format(
					E.func_GetCoord(quest.x, quest.y),
					quest.id or "nil"
			))
		else
			if quest and quest.mapID and quest.x and quest.y then
				local m = tonumber(quest.mapID)
				if C_Map.CanSetUserWaypointOnMap(m) then
					if C_Map.HasUserWaypoint() then
						C_Map.ClearUserWaypoint()
					end
					local p = UiMapPoint.CreateFromCoordinates(m,quest.x,quest.y)
					C_Map.SetUserWaypoint(p)
					OpenWorldMap(m)
				end
			end
		end
	end
	local function Time_OnShow(self)
		if self.data and self.data.time then
			self.Time:SetText(E.FormatLastSeen(self.data.time))
		else
			self.Time:SetText(UNKNOWN)
		end
	end
	local initializer = function(line, index)
		if not line.Title then
			line:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
			line:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
			line:GetHighlightTexture():SetAlpha(0.5)
			line.Title = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
			line.Title:SetPoint("TOPLEFT")
			line.Title:SetPoint("TOPRIGHT", line, "TOPLEFT", 260, 0)
			line.Title:SetPoint("BOTTOM", 0, 16)
			line.Time = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Time:SetPoint("TOPRIGHT")
			line.Time:SetPoint("TOPLEFT", line, "TOPRIGHT", -100, 0)
			line.Time:SetPoint("BOTTOM", 0, 16)
			line.Location = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Location:SetPoint("TOPRIGHT", line.Time, "TOPLEFT")
			line.Location:SetPoint("TOPLEFT", line.Title, "TOPRIGHT")
			line.Location:SetPoint("BOTTOM", 0, 16)
			line.Coords = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Coords:SetPoint("TOPLEFT", line.Location, "BOTTOMLEFT")
			line.Coords:SetPoint("TOPRIGHT", line.Location, "BOTTOMRIGHT")
			line.Coords:SetPoint("BOTTOM")
			line.Divider = line:CreateTexture()
			line.Divider:SetColorTexture(1, 1, 0, 0.5)
			line.Divider:SetPoint("BOTTOMLEFT")
			line.Divider:SetPoint("BOTTOMRIGHT")
			line:SetScript("OnEnter", Line_OnEnter)
			line:SetScript("OnLeave", GameTooltip_Hide)
			line:SetScript("OnClick", Line_OnClick)
			line:SetScript("OnShow", Time_OnShow)
			line:RegisterForClicks("LeftButtonUp","RightButtonUp")
		end
		-- It's an append table, but I want this to be newest-first
		-- (And the indexrange dataprovider doesn't have a sort comparator)
		local quest = self.Octo_QuestsChangedDB.QC_Quests[#self.Octo_QuestsChangedDB.QC_Quests - (index - 1)]
		line.data = quest
		local mapID, level
		if type(quest.mapID) == 'string' then
			-- pre-8.0 quest logging has mapFiles, just show them
			mapID = quest.mapID
			level = quest.level
		else
			mapID, level = self.func_GetMapNameFromID(quest.mapID)
		end
		line.Title:SetFormattedText("%d: %s %s",
			quest.id, self.quest_names[quest.id] or UNKNOWN,
			C_QuestLog.IsQuestFlaggedCompletedOnAccount and C_QuestLog.IsQuestFlaggedCompletedOnAccount(quest.id) and E.Icon_AccountWide or ""
		)
		line.Location:SetFormattedText("%s (%s)", quest.mapID, mapID .. (level and (' / ' .. level) or ''))
		line.Coords:SetFormattedText("%.2f, %.2f", quest.x * 100, quest.y * 100)
		line.Time:SetText(self.FormatLastSeen(quest.time))
		if index == #E.quests_completed then
			line.Divider:Show()
		else
			line.Divider:Hide()
		end
	end
	-- This is a vast table (my main has 18,586 entries in it), so use the IndexRange provider
	local dataProvider = CreateIndexRangeDataProvider(#self.Octo_QuestsChangedDB.QC_Quests)
	self:RegisterCallback(self.Event.OnQuestAdded, function(_, quest, index)
			dataProvider:SetSize(#self.Octo_QuestsChangedDB.QC_Quests)
	end)
	self:RegisterCallback(self.Event.OnQuestRemoved, function(_, quest, index)
			dataProvider:SetSize(#self.Octo_QuestsChangedDB.QC_Quests)
	end)
	self:RegisterCallback(self.Event.OnAllQuestsRemoved, function()
			dataProvider:Flush()
	end)
	return E:BuildLogPanel(initializer, dataProvider)
end
function E:BuildVignetteLog()
	local function Line_OnEnter(self)
		local vignette = self.data
		if vignette then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:AddLine(vignette.name or UNKNOWN)
			GameTooltip:AddDoubleLine("id", vignette.id)
			GameTooltip:AddDoubleLine("mapID", vignette.mapID)
			GameTooltip:AddDoubleLine("atlas", vignette.atlas)
			GameTooltip:AddDoubleLine("coords", ("%.2f, %.2f"):format(vignette.x * 100, vignette.y * 100))
			GameTooltip:AddDoubleLine("time", vignette.time)
			GameTooltip:AddDoubleLine(" ", date("%c", vignette.time))
			GameTooltip:AddLine("Left-click for waypoint", 0, 1, 1)
			GameTooltip:AddLine("Shift-click to copy", 0, 1, 1)
			GameTooltip:AddLine("Right-click to remove", 0, 1, 1)
			GameTooltip:Show()
		end
	end
	local function Line_OnClick(self, button, down)
		local vignette = self.data
		if button == "RightButton" then
			E:RemoveVignette(vignette)
		elseif IsShiftKeyDown() then
			StaticPopup_Show("QuestsChanged_CopyBox", nil, nil, ("[%d] = {vignette=%d, label=\"%s\"},"):format(
					E.func_GetCoord(vignette.x, vignette.y),
					vignette.id or "nil",
					vignette.name or UNKNOWN
			))
		else
			if vignette and vignette.mapID and vignette.x and vignette.y then
				local m = tonumber(vignette.mapID)
				if C_Map.CanSetUserWaypointOnMap(m) then
					if C_Map.HasUserWaypoint() then
						C_Map.ClearUserWaypoint()
					end
					local p = UiMapPoint.CreateFromCoordinates(m, vignette.x, vignette.y)
					C_Map.SetUserWaypoint(p)
					OpenWorldMap(m)
				end
			end
		end
	end
	local initializer = function(line, vignetteGUID)
		if not line.Title then
			line:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
			line:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
			line:GetHighlightTexture():SetAlpha(0.5)
			line.Texture = line:CreateTexture(nil, "ARTWORK")
			line.Texture:SetPoint("TOPLEFT")
			line.Texture:SetPoint("BOTTOMLEFT")
			line.Texture:SetWidth(line:GetHeight())
			line.Title = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
			line.Title:SetPoint("TOPLEFT", line.Texture, "TOPRIGHT")
			line.Title:SetPoint("TOPRIGHT", line, "TOPLEFT", 260, 0)
			line.Title:SetPoint("BOTTOM", 0, 16)
			line.Time = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Time:SetPoint("TOPRIGHT")
			line.Time:SetPoint("TOPLEFT", line, "TOPRIGHT", -100, 0)
			line.Time:SetPoint("BOTTOM", 0, 16)
			line.Location = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Location:SetPoint("TOPRIGHT", line.Time, "TOPLEFT")
			line.Location:SetPoint("TOPLEFT", line.Title, "TOPRIGHT")
			line.Location:SetPoint("BOTTOM", 0, 16)
			line.Coords = line:CreateFontString(nil, "ARTWORK", "GameFontHighlightRight")
			line.Coords:SetPoint("TOPLEFT", line.Location, "BOTTOMLEFT")
			line.Coords:SetPoint("TOPRIGHT", line.Location, "BOTTOMRIGHT")
			line.Coords:SetPoint("BOTTOM")
			line:SetScript("OnEnter", Line_OnEnter)
			line:SetScript("OnLeave", GameTooltip_Hide)
			line:SetScript("OnClick", Line_OnClick)
			line:SetScript("OnShow", function(self) if self.data then self.Time:SetText(E.FormatLastSeen(self.data.time)) end end)
			line:RegisterForClicks("LeftButtonUp","RightButtonUp")
		end
		local vignette = self.vignetteLog[vignetteGUID]
		line.data = vignette
		local mapID, level = self.func_GetMapNameFromID(vignette.mapID)
		line.Texture:SetAtlas(vignette.atlas)
		line.Title:SetFormattedText("%d: %s", vignette.id, vignette.name or UNKNOWN)
		line.Location:SetFormattedText("%s (%s)", vignette.mapID or "?", mapID .. (level and (' / ' .. level) or ''))
		line.Coords:SetFormattedText("%.2f, %.2f", vignette.x * 100, vignette.y * 100)
		line.Time:SetText(self.FormatLastSeen(vignette.time))
	end
	-- This is a tiny table that's its own source-of-truth, so regular dataprovider is fine
	local dataProvider = CreateDataProvider(self.vignetteLogOrder)
	-- It's stored in an append-table, but I want the new events at the top:
	dataProvider:SetSortComparator(function(lhs, rhs)
			return self.vignetteLog[lhs].time > self.vignetteLog[rhs].time
	end)
	self:RegisterCallback(self.Event.OnVignetteAdded, function(_, vignette, guid)
			dataProvider:Insert(guid)
	end)
	self:RegisterCallback(self.Event.OnVignetteRemoved, function(_, vignette, guid)
			dataProvider:Remove(guid)
	end)
	self:RegisterCallback(self.Event.OnAllVignettesRemoved, function()
			dataProvider:Flush()
	end)
	return E:BuildLogPanel(initializer, dataProvider)
end
function E:LogShown()
	return QC_Quests and QC_Quests:IsShown()
end
function E:ToggleLog()
	if not QC_Quests then self:BuildLog() end
	if QC_Quests:IsShown() then
		QC_Quests:Hide()
	else
		QC_Quests:Show()
	end
end
do
	local QCSecondsFormatter = CreateFromMixins(SecondsFormatterMixin)
	QCSecondsFormatter:Init(
		_G.LESS_THAN_OPERAND and SECONDS_PER_MIN or 0, -- missing in classic
		SecondsFormatter.Abbreviation.Truncate,
		SecondsFormatterConstants.RoundUpLastUnit,
		SecondsFormatterConstants.ConvertToLower,
		SecondsFormatterConstants.RoundUpIntervals
	)
	function QCSecondsFormatter:GetDesiredUnitCount(seconds)
		return seconds > SECONDS_PER_DAY and 2 or 1
	end
	function QCSecondsFormatter:GetMinInterval(seconds)
		return SecondsFormatter.Interval.Minutes
	end
	function E.FormatLastSeen(t)
		local now = time()
		if not now then return UNKNOWN end
		t = tonumber(t)
		if not t or t == 0 then return NEVER end
		return QCSecondsFormatter:Format(now - t)
	end
end