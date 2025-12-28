local GlobalAddonName, E = ...
local L = E.L
local EventFrame = CreateFrame("FRAME")
EventFrame.searchFilter = nil
EventFrame.measureFrame = CreateFrame("Frame")
EventFrame.measureFrame:SetParent(UIParent)
EventFrame.measureFrame:SetScale(UIParent:GetEffectiveScale())
EventFrame.measureText = EventFrame.measureFrame:CreateFontString()
EventFrame.measureText:SetFontObject(OctoFont11)
EventFrame.measureText:SetWordWrap(false)
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate") -- SettingsFrameTemplate
Octo_MainFrame_ToDo:Hide()
E.func_RegisterFrame_ICONS(Octo_MainFrame_ToDo)
local SearchBox = CreateFrame("EditBox", "Octo_SearchBox", Octo_MainFrame_ToDo, "SearchBoxTemplate")
local NewSettingsButton = CreateFrame("CheckButton", "NewSettingsButton", Octo_MainFrame_ToDo, "UICheckButtonTemplate")
local INDENT_LEFT = 10
local INDENT_TEXT = 4
local MIN_COLUMN_WIDTH_LEFT = 200
local MIN_COLUMN_WIDTH_Center = 90
local MAX_DISPLAY_LINES = E.MAX_DISPLAY_LINES
local MAX_FRAME_WIDTH = E.PHYSICAL_SCREEN_WIDTH*.7 -- 8
local MAX_FRAME_HEIGHT = E.PHYSICAL_SCREEN_HEIGHT*.7 -- 7
EventFrame.MAX_COLUMN_COUNT = 113
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local classR, classG, classB = GetClassColor(E.classFilename)
local LEFT_TEXTURE_ALPHA = .05
local charR, charG, charB = 1, 1, 1
local WeeklyResetFrameLeft = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo)
local function SafeTooltipShow(frame, ...)
	if Octo_MainFrame_ToDo:IsShown() then
		E.func_OctoTooltip_OnEnter(frame, ...)
	end
end
local func_OnAcquiredLeft do
	local function Create_SettingsButton(frame)
		frame.SettingsButton = CreateFrame("BUTTON", nil, frame)
		frame.SettingsButton:Hide()
		frame.SettingsButton:SetPropagateMouseClicks(true)
		frame.SettingsButton:SetPropagateMouseMotion(true)
		frame.SettingsButton:SetSize(E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
		frame.SettingsButton:SetPoint("LEFT", 1, -1)
		frame.SettingsButton:RegisterForClicks("LeftButtonUp")
		frame.SettingsButton:EnableMouse(true)
		local texture = frame.SettingsButton:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		frame.SettingsTexture = texture
		frame.SettingsButton:SetCollapsesLayout(true)
	end
	local function Create_icon1frame(frame)
		frame.icon1frame = CreateFrame("FRAME", nil, frame)
		frame.icon1frame:Hide()
		frame.icon1frame:SetPoint("LEFT", frame.SettingsButton, "RIGHT")
		frame.icon1frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon1frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		frame.icon1texture = texture
		frame.icon1frame:SetCollapsesLayout(true)
	end
	local function Create_icon2frame(frame)
		frame.icon2frame = CreateFrame("FRAME", nil, frame)
		frame.icon2frame:Hide()
		frame.icon2frame:SetPoint("LEFT", frame.icon1frame, "RIGHT")
		frame.icon2frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon2frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		texture:SetTexCoord(.10, .90, .10, .90)
		frame.icon2texture = texture
		frame.icon2frame:SetCollapsesLayout(true)
	end
	local function Create_icon3frame(frame)
		frame.icon3frame = CreateFrame("FRAME", nil, frame)
		frame.icon3frame:Hide()
		frame.icon3frame:SetPoint("LEFT", frame.icon2frame, "RIGHT")
		frame.icon3frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		local texture = frame.icon3frame:CreateTexture(nil, "BACKGROUND", nil, 5)
		texture:SetPoint("CENTER")
		texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
		frame.icon3texture = texture
		frame.icon3frame:SetCollapsesLayout(true)
	end
	local function Create_TextLeft(frame)
		frame.TextLeft = frame:CreateFontString()
		frame.TextLeft:SetFontObject(OctoFont11)
		frame.TextLeft:SetPoint("LEFT", frame.icon3frame, "RIGHT")
		frame.TextLeft:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
		frame.TextLeft:SetWordWrap(false)
		frame.TextLeft:SetJustifyV("MIDDLE")
		frame.TextLeft:SetJustifyH("LEFT")
		frame.TextLeft:SetTextColor(textR, textG, textB, textA)
	end
	local function Create_TextureLeft(frame)
		frame.TextureLeft = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
		frame.TextureLeft:Hide()
		frame.TextureLeft:SetAllPoints()
		frame.TextureLeft:SetTexture(E.TEXTURE_LEFT_PATH)
	end
	local function Create_Highlight(frame, owner)
		frame.Highlight = CreateFrame("BUTTON", nil, owner, "OctoHighlightAnimationTemplate")
		frame.Highlight:SetPropagateMouseClicks(true)
		frame.Highlight:SetPropagateMouseMotion(true)
		frame.Highlight:SetFrameLevel(frame:GetFrameLevel()+2)
		if E.ENABLE_HIGHLIGHT_ANIMATION then
			frame.Highlight:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD")
			frame.Highlight.HighlightTexture = frame.Highlight:GetHighlightTexture()
			frame.Highlight.HighlightTexture:SetAlpha(E.ALPHA_BACKGROUND)
		end
		frame.Highlight:SetPoint("LEFT", frame)
		frame.Highlight:SetPoint("TOP", frame)
		frame.Highlight:SetPoint("BOTTOM", frame)
		frame.Highlight:SetPoint("RIGHT")
	end
	local function AdditionalSettings(frame)
		frame:SetPropagateMouseClicks(true)
		frame:SetPropagateMouseMotion(true)
		frame:SetHitRectInsets(1, 1, 1, 1)
	end
	function func_OnAcquiredLeft(owner, frame, node, new)
		if not C_AddOns.IsAddOnLoaded("Blizzard_CurrencyTransfer") then
			C_AddOns.LoadAddOn("Blizzard_CurrencyTransfer")
		end
		if not new then return end
		local frameData = node:GetData()
		Create_SettingsButton(frame)
		Create_icon1frame(frame)
		Create_icon2frame(frame)
		Create_icon3frame(frame)
		Create_TextLeft(frame)
		Create_TextureLeft(frame)
		Create_Highlight(frame, owner)
		AdditionalSettings(frame)
		frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
		frame:SetScript("OnShow", function() frame.Highlight:Show() end)
	end
end
local func_OnAcquiredCenter do
	local function Create_CurrentCharBackground(columnFrame)
		columnFrame.CurrentCharBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.CurrentCharBackground:SetAllPoints()
		columnFrame.CurrentCharBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.CurrentCharBackground:SetVertexColor(classR, classG, classB, E.CHARACTER_ALPHA)
		columnFrame.CurrentCharBackground:Hide()
	end
	local function Create_ReputationBackground(columnFrame)
		columnFrame.ReputationBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.ReputationBackground:SetPoint("LEFT")
		columnFrame.ReputationBackground:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame.ReputationBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.ReputationBackground:SetVertexColor(classR, classG, classB, E.REPUTATION_ALPHA)
		columnFrame.ReputationBackground:Hide()
	end
	local function Create_TextCenter(columnFrame)
		columnFrame.TextCenter = columnFrame:CreateFontString()
		columnFrame.TextCenter:SetFontObject(OctoFont11)
		columnFrame.TextCenter:SetAllPoints()
		columnFrame.TextCenter:SetWordWrap(false)
		columnFrame.TextCenter:SetJustifyV("MIDDLE")
		columnFrame.TextCenter:SetJustifyH("CENTER")
		columnFrame.TextCenter:SetTextColor(textR, textG, textB, textA)
	end
	local function AdditionalSettings(columnFrame, frame)
		columnFrame:SetPropagateMouseClicks(true)
		columnFrame:SetPropagateMouseMotion(true)
		columnFrame:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame:SetHitRectInsets(1, 1, 1, 1)
		columnFrame:SetPoint("LEFT", frame, "LEFT", 0, 0)
	end
	function func_OnAcquiredCenter(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		frame:SetPropagateMouseClicks(true)
		frame.columnFrames = setmetatable({}, {
				__index = function(self, key)
					if key then
						local columnFrame = CreateFrame("BUTTON", nil, frame)
						columnFrame:Hide()
						Create_CurrentCharBackground(columnFrame)
						Create_ReputationBackground(columnFrame)
						Create_TextCenter(columnFrame)
						AdditionalSettings(columnFrame, frame)
						columnFrame:SetScript("OnHide", function()
								columnFrame:Hide()
						end)
						columnFrame.CurrentCharBackground:SetScript("OnHide", columnFrame.CurrentCharBackground.Hide)
						rawset(self, key, columnFrame)
						return columnFrame
					end
				end
		})
	end
end
local function func_SettingsButton_OnClick(button, frameData)
	local dataType, id = ("#"):split(frameData.SettingsType)
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
		id = tonumber(id)
	end
	if not Octo_profileKeys.profiles[E.CurrentProfile][dataType] then
		Octo_profileKeys.profiles[E.CurrentProfile][dataType] = {}
	end
	local settingsTable = Octo_profileKeys.profiles[E.CurrentProfile][dataType]
	local newValue = not (settingsTable[id] or false)
	settingsTable[id] = newValue
	local texture = newValue and "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonONgreen" or "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonOFFred"
	button:GetParent().SettingsTexture:SetTexture(texture)
end
local function func_Setup_Currencies(frame, id)
	local icon1 = E.func_GetCurrencyIcon(id)
	frame.icon1texture:SetTexture(icon1)
	frame.icon1frame:Show()
	if C_CurrencyInfo.IsAccountWideCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		frame.icon3frame:Show()
	elseif C_CurrencyInfo.IsAccountTransferableCurrency(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_TRANSFERABLE, false)
		frame.icon3frame:Show()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)
		frame.icon3frame:Hide()
	end
end
local function func_Setup_Reputations(frame, id)
	frame.icon1texture:SetTexture(E.ICON_TABARD)
	local factionIcon = E.func_GetReputationSideIcon(id)
	local AdditionalIcon = E.func_GetReputationIcon(id)
	local ReputationAtlas = E.func_GetReputationAtlas(id)
	if factionIcon then
		frame.icon2texture:SetTexture(factionIcon)
		frame.icon2frame:Show()
	elseif AdditionalIcon then
		frame.icon2texture:SetTexture(AdditionalIcon)
		frame.icon2frame:Show()
	elseif ReputationAtlas then
		frame.icon2texture:SetAtlas(ReputationAtlas)
		frame.icon2frame:Show()
	else
		frame.icon2texture:SetTexture(spacerEMPTY)
		frame.icon2frame:Hide()
	end
	if C_Reputation.IsAccountWideReputation(id) then
		frame.icon3texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		frame.icon3frame:Show()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)
		frame.icon3frame:Hide()
	end
end
local function func_Setup_Items(frame, id)
	local icon1 = E.func_GetItemIcon(id)
	frame.icon1texture:SetTexture(icon1)
	frame.icon1frame:Show()
end
local function func_Setup_UniversalQuests(frame, id)
	local IconLeft = nil
	local reset = id:match("_([^_]+)$")
	if reset == "Daily" then
		IconLeft = E.ICON_DAILY
	elseif reset == "Weekly" then
		IconLeft = E.ICON_WEEKLY
	elseif reset == "Regular" then
		IconLeft = E.ICON_REGULAR
	elseif reset == "Month" then
		IconLeft = E.ICON_MONTH
	end
	if IconLeft then
		frame.icon3texture:SetAtlas(IconLeft, false)
		frame.icon3frame:Show()
		frame.icon1frame:Hide()
	else
		frame.icon3texture:SetTexture(spacerEMPTY)
		frame.icon3frame:Hide()
	end
end
function EventFrame:func_InitLEFT(frame, node)
	local frameData = node:GetData()
	if EventFrame.columnWidthsLeft and EventFrame.columnWidthsLeft[1] then
		local newLeftWidth = math.max(MIN_COLUMN_WIDTH_LEFT, EventFrame.columnWidthsLeft[1])
		Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(newLeftWidth+INDENT_TEXT)
		SearchBox:SetSize(newLeftWidth - INDENT_TEXT - 40, 22)
		frame.TextLeft:SetWidth(newLeftWidth)
	end
	if not frameData.SettingsType then
		frame.SettingsButton:Show()
		frame.SettingsButton:Hide()
		frame.icon1frame:Show()
		frame.icon2frame:Show()
		frame.icon3frame:Show()
		frame.icon2frame:Hide()
		frame.icon3frame:Hide()
		frame.TextLeft:SetText("")
		frame.icon1texture:SetTexture(spacerEMPTY)
		frame:SetScript("OnEnter", function()
				frame.tooltip = nil
		end)
	else
		local dataType, id = ("#"):split(frameData.SettingsType)
		if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
			id = tonumber(id)
		end
		frame.SettingsButton:Show()
		frame.icon1frame:Show()
		frame.icon2frame:Show()
		frame.icon3frame:Show()
		frame.SettingsButton:Hide()
		frame.icon2frame:Hide()
		frame.icon3frame:Hide()
		if frameData.IconLeft then
			frame.icon1texture:SetTexture(frameData.IconLeft)
			frame.icon1texture:SetAtlas(frameData.IconLeft, false)
		else
			frame.icon1texture:SetTexture(E.ICON_EMPTY)
		end
		if dataType == "Currencies" then
			func_Setup_Currencies(frame, id)
		end
		if dataType == "Items" then
			func_Setup_Items(frame, id)
		end
		if dataType == "Reputations" then
			func_Setup_Reputations(frame, id)
		end
		if dataType == "RaidsOrDungeons" then
			local name, _, _, _, _, buttonImage2, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(id)
			if isRaid then
				frame.icon2frame:Show()
				frame.icon2texture:SetAtlas("Raid")
			else
				frame.icon2frame:Show()
				frame.icon2texture:SetAtlas("Dungeon")
			end
			frame.icon1texture:SetTexture(buttonImage2)
		end
		if dataType == "UniversalQuests" then
			func_Setup_UniversalQuests(frame, id)
		end
		if Octo_profileKeys.isSettingsEnabled then
			local texture = E.ICON_EMPTY
			if Octo_profileKeys.profiles[E.CurrentProfile][dataType] and Octo_profileKeys.profiles[E.CurrentProfile][dataType][id] ~= nil then
				if Octo_profileKeys.profiles[E.CurrentProfile][dataType][id] or Octo_profileKeys.profiles[E.CurrentProfile][dataType][tonumber(id)] then
					texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonONgreen"
				else
					texture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\Textures\\buttonOFFred"
				end
			end
			frame.SettingsTexture:SetTexture(texture)
			frame.SettingsButton:Show()
		else
			frame.SettingsButton:Hide()
		end
		frame.SettingsButton:SetScript("OnClick", function(self)
				func_SettingsButton_OnClick(self, frameData)
		end)
		local expansionICON = ""
		if type(frameData.TextLeft) == "function" then
			frame.TextLeft:SetText(expansionICON..frameData.TextLeft())
		else
			frame.TextLeft:SetText(expansionICON..frameData.TextLeft)
		end
		if frameData.ColorLeft then
			local r, g, b = E.func_Hex2RGBFloat(frameData.ColorLeft)
			frame.TextureLeft:SetVertexColor(r, g, b, LEFT_TEXTURE_ALPHA)
			frame.TextureLeft:Show()
		else
			frame.TextureLeft:Hide()
		end
		frame:SetScript("OnEnter", function()
				if frameData.SettingsType then
					frame.tooltip = E.func_KeyTooltip_LEFT(frameData.SettingsType)
				else
					frame.tooltip = nil
				end
				SafeTooltipShow(frame, {"RIGHT", "LEFT"})
		end)
	end
end
function EventFrame:func_InitCenter(frame, node)
	local frameData = node:GetData()
	if not frameData.SettingsType then
		for i = 1, (frameData.totalColumns or 0) do
			local columnFrames = frame.columnFrames[i]
			if not columnFrames then
				columnFrames = frame.columnFrames[i]
			end
			columnFrames.TextCenter:SetText(frameData.TextCenter[i])
			columnFrames:Show()
			columnFrames:SetScript("OnEnter", function()
					columnFrames.tooltip = nil
			end)
			columnFrames.ReputationBackground:Hide()
		end
	else
		local dataType, id = ("#"):split(frameData.SettingsType)
		if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
			id = tonumber(id)
		end
		local accumulatedWidth = 0
		local columnWidthsCenter = EventFrame.columnWidthsCenter or {}
		for i = 1, (frameData.totalColumns or 0) do
			local columnFrames = frame.columnFrames[i]
			if not columnFrames then
				columnFrames = frame.columnFrames[i]
			end
			columnFrames:ClearAllPoints()
			columnFrames:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
			local columnWidth = columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center
			columnFrames:SetWidth(columnWidth)
			accumulatedWidth = accumulatedWidth + columnWidth
			if frameData.TextCenter and frameData.TextCenter[i] then
				local TextCenter = frameData.TextCenter[i]
				columnFrames.ReputationBackground:Hide()
				if frameData.ColorCenter and frameData.ColorCenter[i] then
					local r1, g1, b1 = E.func_Hex2RGBFloat(frameData.ColorCenter[i])
					columnFrames.ReputationBackground:Show()
					columnFrames.ReputationBackground:SetVertexColor(r1, g1, b1)
					if dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) ~= 0 then
						local FirstReputation = tonumber(frameData.FirstReputation[i])
						local SecondReputation = tonumber(frameData.SecondReputation[i])
						if FirstReputation == SecondReputation then
							columnFrames.ReputationBackground:SetWidth(columnWidth)
						elseif FirstReputation >= 1 then
							columnFrames.ReputationBackground:SetWidth(columnWidth/SecondReputation*FirstReputation)
						end
					elseif dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) == 0 then
						columnFrames.ReputationBackground:Hide()
					else
						columnFrames.ReputationBackground:SetWidth(columnWidth)
					end
				end
				columnFrames.TextCenter:SetText(TextCenter)
				if frameData.totalColumns > 1 and i == frameData.currentCharacterIndex then
					columnFrames.CurrentCharBackground:Show()
				else
					columnFrames.CurrentCharBackground:Hide()
				end
			else
				columnFrames.TextCenter:SetText("")
				columnFrames.ReputationBackground:SetVertexColor(0, 0, 0)
				columnFrames.CurrentCharBackground:Hide()
			end
			columnFrames:SetScript("OnEnter", function()
					if frameData.SettingsType and frameData.GUID[i] then
						columnFrames.tooltip = E.func_KeyTooltip_RIGHT(frameData.GUID[i], frameData.SettingsType)
					else
						columnFrames.tooltip = nil
					end
					SafeTooltipShow(columnFrames)
			end)
			columnFrames:Show()
		end
		for i = frameData.totalColumns+1, #frame.columnFrames do
			frame.columnFrames[i]:Hide()
		end
	end
end
local function HeaderFrameLeft_OnShow(frame)
	local text = E.COLOR_FACTION..E.func_SecondsToClock(E.func_GetSecondsToWeeklyReset(), false).."|r"
	frame.Text1:SetText(text)
end
function EventFrame:func_CreateMainFrame()
	Octo_MainFrame_ToDo:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_ToDo:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.MAINBACKGROUND_ALPHA)
	Octo_MainFrame_ToDo:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)



	Octo_MainFrame_ToDo:SetPoint("TOP", 0, -150)
	Octo_MainFrame_ToDo:SetScript("OnShow", function()
			RequestRaidInfo()
			E.func_Collect_All()
			EventFrame:CreateDataProvider()
	end)
	local numPlayers = math.min(E.func_CountVisibleCharacters(), EventFrame.MAX_COLUMN_COUNT)
	Octo_MainFrame_ToDo:SetSize(MIN_COLUMN_WIDTH_LEFT + MIN_COLUMN_WIDTH_Center * numPlayers, E.GLOBAL_LINE_HEIGHT * MAX_DISPLAY_LINES)
	Octo_MainFrame_ToDo:SetDontSavePosition(true)
	Octo_MainFrame_ToDo:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	local horizontalScrollFrame = CreateFrame("ScrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.horizontalScrollFrame = horizontalScrollFrame
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
	local horizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimhorizontalScrollBar")
	EventFrame.horizontalScrollBar = horizontalScrollBar
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
	local scrollContentFrame = CreateFrame("FRAME", "scrollContentFrame")
	Octo_MainFrame_ToDo.scrollContentFrame = scrollContentFrame
	horizontalScrollFrame:SetScrollChild(scrollContentFrame)
	Octo_MainFrame_ToDo.ScrollBoxLEFT = CreateFrame("FRAME", nil, Octo_MainFrame_ToDo, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetWidth(INDENT_TEXT+MIN_COLUMN_WIDTH_LEFT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	Octo_MainFrame_ToDo.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	horizontalScrollFrame:SetPoint("TOPLEFT", Octo_MainFrame_ToDo.ScrollBoxLEFT, "TOPRIGHT", 0, E.HEADER_HEIGHT)
	horizontalScrollFrame:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ViewLeft = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewLeft:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewLeft:SetElementInitializer("BUTTON", function(...) self:func_InitLEFT(...) end)
	Octo_MainFrame_ToDo.ViewLeft:RegisterCallback(Octo_MainFrame_ToDo.ViewLeft.Event.OnAcquiredFrame, func_OnAcquiredLeft, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.ScrollBoxCenter = CreateFrame("FRAME", nil, scrollContentFrame, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("TOPLEFT", 0, -E.HEADER_HEIGHT)
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBoxCenter:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBoxCenter:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBarCenter = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBarCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ViewCenter = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.ViewCenter:SetElementExtent(E.GLOBAL_LINE_HEIGHT)
	Octo_MainFrame_ToDo.ViewCenter:SetElementInitializer("BUTTON", function(...) self:func_InitCenter(...) end)
	Octo_MainFrame_ToDo.ViewCenter:RegisterCallback(Octo_MainFrame_ToDo.ViewCenter.Event.OnAcquiredFrame, func_OnAcquiredCenter, Octo_MainFrame_ToDo)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewLeft)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxLEFT, Octo_MainFrame_ToDo.ScrollBarCenter)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter, Octo_MainFrame_ToDo.ViewCenter)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBoxCenter, Octo_MainFrame_ToDo.ScrollBarCenter)
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:StartMoving()
			end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:StopMovingOrSizing()
				local left = Octo_MainFrame_ToDo:GetLeft()
				local top = Octo_MainFrame_ToDo:GetTop()
				Octo_MainFrame_ToDo:ClearAllPoints()
				Octo_MainFrame_ToDo:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
			end
	end)
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", Octo_MainFrame_ToDo.Hide)
	WeeklyResetFrameLeft:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT")
	WeeklyResetFrameLeft:SetSize(MIN_COLUMN_WIDTH_LEFT*2, E.GLOBAL_LINE_HEIGHT)
	WeeklyResetFrameLeft.Text1 = WeeklyResetFrameLeft:CreateFontString()
	WeeklyResetFrameLeft.Text1:SetFontObject(OctoFont11)
	WeeklyResetFrameLeft.Text1:SetPoint("LEFT", INDENT_TEXT)
	WeeklyResetFrameLeft.Text1:SetWordWrap(false)
	WeeklyResetFrameLeft.Text1:SetJustifyV("MIDDLE")
	WeeklyResetFrameLeft.Text1:SetJustifyH("LEFT")
	WeeklyResetFrameLeft.Text1:SetTextColor(textR, textG, textB, textA)
	WeeklyResetFrameLeft:SetScript("OnShow", HeaderFrameLeft_OnShow)
	local tooltip_WR = {}
	tooltip_WR[#tooltip_WR+1] = {L["Weekly Reset"]}
	WeeklyResetFrameLeft.tooltip = tooltip_WR
	WeeklyResetFrameLeft:SetScript("OnEnter", function()
			SafeTooltipShow(WeeklyResetFrameLeft, {"RIGHT", "LEFT"})
	end)
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	local function InitializePoolFrame(self)
		self:RegisterForClicks("LeftButtonUp")
		self:SetSize(MIN_COLUMN_WIDTH_Center, E.HEADER_HEIGHT)
		self.Nickname = self:CreateFontString()
		self.Nickname:SetFontObject(OctoFont11)
		self.Server = self:CreateFontString()
		self.Server:SetFontObject(OctoFont10)
		self.Text = self:CreateFontString()
		self.Text:SetFontObject(OctoFont11)
		self.Text:SetPoint("CENTER")
		self.Text:SetJustifyV("MIDDLE")
		self.Text:SetJustifyH("CENTER")
		self.Text:SetTextColor(textR, textG, textB, textA)
		self.CharTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.CharTexture:SetAllPoints()
		self.CharTexture:SetTexture(E.TEXTURE_CHAR_PATH)
	end
	Octo_MainFrame_ToDo.pool = CreateFramePool("BUTTON", scrollContentFrame, nil, ResetPoolFrame, false, InitializePoolFrame)
end
function E.func_main_frame_toggle()
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
		local left = Octo_MainFrame_ToDo:GetLeft()
		local top = Octo_MainFrame_ToDo:GetTop()
		Octo_MainFrame_ToDo:ClearAllPoints()
		Octo_MainFrame_ToDo:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
	end
end
function EventFrame:func_CreateSearchBox()
	SearchBox.Border = SearchBox:CreateTexture(nil, "BACKGROUND")
	SearchBox.Border:SetColorTexture(0, 0, 0, 1)
	SearchBox.Border:SetPoint("TOPLEFT", SearchBox, "TOPLEFT", -5, 0)
	SearchBox.Border:SetPoint("BOTTOMRIGHT", SearchBox, "BOTTOMRIGHT", 0, 0)
	SearchBox.Border:SetDrawLayer("BACKGROUND", -1)
	SearchBox.Background = SearchBox:CreateTexture(nil, "BACKGROUND")
	SearchBox.Background:SetColorTexture(0.15, 0.15, 0.15, 0.8)
	SearchBox.Background:SetPoint("TOPLEFT", SearchBox, "TOPLEFT", -4, -1)
	SearchBox.Background:SetPoint("BOTTOMRIGHT", SearchBox, "BOTTOMRIGHT", -1, 1)
	SearchBox:SetPoint("TOPLEFT", INDENT_TEXT+30, -E.HEADER_TEXT_OFFSET)
	SearchBox:SetSize(MIN_COLUMN_WIDTH_LEFT - INDENT_TEXT - 40, E.GLOBAL_LINE_HEIGHT/2)
	SearchBox:SetAutoFocus(false)
	SearchBox:SetFontObject(OctoFont11)
	SearchBox:SetText("")
	SearchBox.Left:Hide()
	SearchBox.Middle:Hide()
	SearchBox.Right:Hide()
	SearchBox:HookScript("OnTextChanged", function(self)
			EventFrame:ApplySearchFilter(self:GetText())
	end)
	NewSettingsButton:SetPoint("RIGHT", SearchBox, "LEFT", -9, 0)
	NewSettingsButton:SetSize(20, 20)
	NewSettingsButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	NewSettingsButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	NewSettingsButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	NewSettingsButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	NewSettingsButton:SetScript("OnClick", function(self)
			local checked = self:GetChecked()
			Octo_profileKeys.isSettingsEnabled = checked
			EventFrame:CreateDataProvider()
	end)
	NewSettingsButton:SetChecked(Octo_profileKeys.isSettingsEnabled or false)
	NewSettingsButton:SetScript("OnShow", function(self)
			NewSettingsButton:SetChecked(Octo_profileKeys.isSettingsEnabled or false)
	end)
	local tooltip = {}
	tooltip[#tooltip+1] = {L["Settings mode"]}
	NewSettingsButton.tooltip = tooltip
	NewSettingsButton:SetScript("OnEnter", function()
			SafeTooltipShow(NewSettingsButton, {"RIGHT", "LEFT"})
	end)
	Octo_MainFrame_ToDo.SearchBox = SearchBox
end
function EventFrame:ApplySearchFilter(searchText)
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.ViewLeft then return end
	searchText = searchText and searchText:lower():trim() or ""
	local dataProvider = Octo_MainFrame_ToDo.ViewLeft:GetDataProvider()
	if not dataProvider then return end
	if searchText == "" then
		EventFrame:func_ResetsearchFilter()
		return
	end
	EventFrame.searchFilter = searchText
	EventFrame:CreateDataProvider()
end
function EventFrame:func_ResetsearchFilter()
	EventFrame.searchFilter = nil
	if Octo_MainFrame_ToDo.SearchBox then
		Octo_MainFrame_ToDo.SearchBox:SetText("")
	end
	EventFrame:CreateDataProvider()
end
local function func_calculateColumnWidthsLEFT(node)
	local frameData = node:GetData()
	local columnWidthsLEFT = {}
	local textToMeasure = frameData.TextLeft
	local width = E.func_MeasureTextWidth(textToMeasure, MIN_COLUMN_WIDTH)
	columnWidthsLEFT[1] = width + E.GLOBAL_LINE_HEIGHT + E.GLOBAL_LINE_HEIGHT + E.GLOBAL_LINE_HEIGHT
	return columnWidthsLEFT
end
local function func_calculateColumnWidthsCenter(node)
	local frameData = node:GetData()
	local columnWidthsCenter = {}
	for i = 1, frameData.totalColumns do
		if frameData.TextCenter[i] then
			local textToMeasure = frameData.TextCenter[i]
			local width = E.func_MeasureTextWidth(textToMeasure, MIN_COLUMN_WIDTH_Center)
			columnWidthsCenter[i] = width
		else
			columnWidthsCenter[i] = MIN_COLUMN_WIDTH_Center
		end
	end
	return columnWidthsCenter
end
local function func_calculateColumnWidthsCenter_HEADER(frame, nicknameTEXT, serverTEXT)
	local textToMeasure1 = nicknameTEXT
	local width1 = E.func_MeasureTextWidth(textToMeasure1, MIN_COLUMN_WIDTH_Center)
	local textToMeasure2 = serverTEXT
	local width2 = E.func_MeasureTextWidth(textToMeasure2, MIN_COLUMN_WIDTH_Center)
	return math.max(width1, width2)
end
local function func_UPDATE_MAINFRAME()
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() and OctoTooltip and not OctoTooltip:IsShown() then
		EventFrame:CreateDataProvider()
	end
end
function E.func_UPDATE_MAINFRAME()
	E.func_SpamBlock(func_UPDATE_MAINFRAME, true)
end
local function PassSearchFilter(TextLeft, searchText)
	if not searchText or searchText == "" then
		return true
	end
	local text = type(TextLeft) == "function"
	and TextLeft()
	or tostring(TextLeft or "")
	return text:lower():find(searchText:lower(), 1, true) ~= nil
end
local function CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local leftColumnWidth = MIN_COLUMN_WIDTH_LEFT + INDENT_TEXT
	if columnWidthsLeft and columnWidthsLeft[1] then
		leftColumnWidth = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] + INDENT_TEXT)
	end
	local width = leftColumnWidth + totalRightWidth
	if width % 2 == 1 then
		width = width + 1
	end
	return width
end
local function CalculateMainFrameHeight(totalLines)
	local LINES_TOTAL = math.floor(MAX_FRAME_HEIGHT / E.GLOBAL_LINE_HEIGHT)
	local maxDisplayLines = math.max(1, math.min(totalLines, LINES_TOTAL or totalLines))
	return E.GLOBAL_LINE_HEIGHT * maxDisplayLines + E.HEADER_HEIGHT, maxDisplayLines
end
local function CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or EventFrame.MAX_COLUMN_COUNT) do
		local colWidth = columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center
		if (totalRightWidth + colWidth) <= maxRIGHT then
			totalRightWidth = totalRightWidth + colWidth
		else
			break
		end
	end
	return totalRightWidth
end
local function CalculateFullRightWidth(columnWidthsCenter, maxColumns)
	local totalRightWidth = 0
	for i = 1, math.min(#columnWidthsCenter, maxColumns or EventFrame.MAX_COLUMN_COUNT) do
		totalRightWidth = totalRightWidth + (columnWidthsCenter[i] or MIN_COLUMN_WIDTH_Center)
	end
	return totalRightWidth
end
function EventFrame:CreateDataProvider()
	local DataProvider = CreateTreeDataProvider()
	local totalLines = 0
	local columnWidthsLeft = {}
	local columnWidthsCenter = {}
	E.func_UpdateCurrentProfile()
	local ExpansionToShowTBL = E.func_GetProfileData("ExpansionToShow")
	local sortedCharacters = E.func_SortCharacters()
	local currentCharacterIndex
	for CharIndex, CharInfo in ipairs(sortedCharacters) do
		if CharInfo.PlayerData.GUID == E.curGUID then
			currentCharacterIndex = CharIndex
			break
		end
	end
	local totalColumns = #sortedCharacters
	local firstChar = sortedCharacters[1]
	local dataDisplayOrder = {
		"Currencies",
		"Items",
		"Additionally",
		"RaidsOrDungeons",
		"UniversalQuests",
		"Reputations",
	}
	local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
	for CharIndex, CharInfo in ipairs(sortedCharacters) do
		columnWidthsCenter[CharIndex] = func_calculateColumnWidthsCenter_HEADER(HeaderFrameCenter, E.func_TextCenter_Chars_nickname(CharInfo), E.func_TextCenter_Chars_server(CharInfo))
	end
	Octo_MainFrame_ToDo.pool:Release(HeaderFrameCenter)
	for categoryKey in next, (E.OctoTables_Vibor) do
		if ExpansionToShowTBL[categoryKey] then
			for _, dataType in ipairs(dataDisplayOrder) do
				for i, id in next, (E.DataProvider_Otrisovka[categoryKey][dataType]) do
					local questKey
					if dataType == "UniversalQuests" then
						questKey = E.UNIVERSAL..id.desc.."_"..id.name_save.."_"..id.reset
					end
					local canDraw = false
					if dataType ~= "UniversalQuests" then
						canDraw = E.func_ShouldShow(id, dataType, E.CurrentProfile)
					else
						canDraw = E.func_ShouldShow(questKey, dataType, E.CurrentProfile)
					end
					if canDraw then
						local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey =
						E.func_Otrisovka_LEFT_Dispatcher(categoryKey, firstChar, dataType, id)
						canDraw = PassSearchFilter(TextLeft, EventFrame.searchFilter)
						if canDraw then
							totalLines = totalLines + 1
							local rowData = {
								TextLeft = TextLeft or "NONE",
								IconLeft = IconLeft,
								ColorLeft = E.OctoTable_Expansions[categoryKey]
								and E.OctoTable_Expansions[categoryKey].color
								or E.COLOR_BLACK,
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
							for CharIndex, CharInfo in ipairs(sortedCharacters) do
								local TextCenter, ColorCenter, FIRST, SECOND = E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
								rowData.TextCenter[CharIndex] = TextCenter
								rowData.ColorCenter[CharIndex] = ColorCenter
								rowData.GUID[CharIndex] = CharInfo.PlayerData.GUID
								rowData.FirstReputation[CharIndex] = FIRST or 0
								rowData.SecondReputation[CharIndex] = SECOND or 0
							end
							local node = DataProvider:Insert(rowData)
							for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
								columnWidthsLeft[j] = math.max(MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
							end
							for j, w in ipairs(func_calculateColumnWidthsCenter(node)) do
								columnWidthsCenter[j] = math.max(MIN_COLUMN_WIDTH_Center, w, columnWidthsCenter[j] or MIN_COLUMN_WIDTH_Center)
							end
						end
					end
				end
			end
		end
	end
	if totalLines == 0 then
		totalLines = 1
		local rowData = {
			TextLeft = "qwe",
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
		columnWidthsLeft[1] = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft[1] or MIN_COLUMN_WIDTH_LEFT)
		for j, w in ipairs(func_calculateColumnWidthsLEFT(node)) do
			columnWidthsLeft[j] = math.max(MIN_COLUMN_WIDTH_LEFT, w, columnWidthsLeft[j] or 0)
		end
	end
	EventFrame.columnWidthsLeft = columnWidthsLeft
	EventFrame.columnWidthsCenter = columnWidthsCenter
	self:UpdateMainFrameUI(DataProvider, totalLines, totalColumns, sortedCharacters, columnWidthsLeft, columnWidthsCenter)
end
function EventFrame:UpdateMainFrameUI(DataProvider, totalLines, totalColumns, sortedCharacters, columnWidthsLeft, columnWidthsCenter)
	if not Octo_MainFrame_ToDo or not Octo_MainFrame_ToDo.scrollContentFrame then return end
	Octo_MainFrame_ToDo.ViewCenter:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	Octo_MainFrame_ToDo.ViewLeft:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	local leftColumnWidth = math.max(MIN_COLUMN_WIDTH_LEFT, columnWidthsLeft and columnWidthsLeft[1] or MIN_COLUMN_WIDTH_LEFT)
	local maxRIGHT = MAX_FRAME_WIDTH - leftColumnWidth - INDENT_TEXT
	if #columnWidthsCenter == 0 and totalColumns > 0 then
		for i = 1, totalColumns do
			columnWidthsCenter[i] = MIN_COLUMN_WIDTH_Center
		end
	end
	local totalRightWidth = CalculateLimitedRightWidth(columnWidthsCenter, maxRIGHT, EventFrame.MAX_COLUMN_COUNT)
	local totalRightWidth_scrollContentFrame = CalculateFullRightWidth(columnWidthsCenter, EventFrame.MAX_COLUMN_COUNT)
	local width = CalculateMainFrameWidth(columnWidthsLeft, columnWidthsCenter, totalRightWidth)
	local height, maxDisplayLines = CalculateMainFrameHeight(totalLines)
	MAX_DISPLAY_LINES = maxDisplayLines
	Octo_MainFrame_ToDo:SetSize(width, height)
	Octo_MainFrame_ToDo.scrollContentFrame:SetSize(totalRightWidth_scrollContentFrame, height)
	self:CreateColumnHeaders(sortedCharacters, columnWidthsCenter)
	self:UpdateCenterColumnPositions(columnWidthsCenter)
end
function EventFrame:CreateColumnHeaders(sortedCharacters, columnWidthsCenter)
	Octo_MainFrame_ToDo.pool:ReleaseAll()
	local accumulatedWidth = 0
	for count, CharInfo in ipairs(sortedCharacters) do
		local pd = CharInfo.PlayerData
		local HeaderFrameCenter = Octo_MainFrame_ToDo.pool:Acquire()
		local columnWidth = columnWidthsCenter[count] or MIN_COLUMN_WIDTH_Center
		HeaderFrameCenter:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.scrollContentFrame, "TOPLEFT", accumulatedWidth, -E.HEADER_HEIGHT)
		HeaderFrameCenter:SetSize(columnWidth, E.HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth
		HeaderFrameCenter.Nickname:SetPoint("CENTER", 0, E.HEADER_TEXT_OFFSET)
		if Octo_ToDo_DB_Vars.isOnlyCurrentServer then
			HeaderFrameCenter.Nickname:SetPoint("CENTER")
		end
		HeaderFrameCenter.Nickname:SetWordWrap(false)
		HeaderFrameCenter.Nickname:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Nickname:SetJustifyH("CENTER")
		HeaderFrameCenter.Nickname:SetText(E.func_TextCenter_Chars_nickname(CharInfo))
		HeaderFrameCenter.Server:SetPoint("CENTER", 0, -E.HEADER_TEXT_OFFSET)
		HeaderFrameCenter.Server:SetWordWrap(false)
		HeaderFrameCenter.Server:SetJustifyV("BOTTOM")
		HeaderFrameCenter.Server:SetJustifyH("CENTER")
		HeaderFrameCenter.Server:SetText(E.func_TextCenter_Chars_server(CharInfo))
		HeaderFrameCenter:SetPropagateMouseClicks(true)
		HeaderFrameCenter:SetPropagateMouseMotion(true)
		HeaderFrameCenter:SetHitRectInsets(1, 1, 1, 1)
		local faction = pd.Faction or "Neutral"
		if faction == "Horde" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_HORDE)
		elseif faction == "Alliance" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_ALLIANCE)
		elseif faction == "Neutral" then
			charR, charG, charB = E.func_Hex2RGBFloat(E.COLOR_NEUTRAL)
		end
		HeaderFrameCenter.CharTexture:SetVertexColor(charR, charG, charB, E.currentCHAR_ALPHA or 0.2)
		HeaderFrameCenter:SetScript("OnEnter", function(self)
				HeaderFrameCenter.tooltip = E.func_Tooltip_Chars(CharInfo)
				SafeTooltipShow(HeaderFrameCenter, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
		HeaderFrameCenter:SetScript("OnClick", function(self, button)
				if button == "LeftButton" and IsShiftKeyDown() then -- IsLeftShiftKeyDown
					local GUID = pd.GUID
					E.Toggle_EquipmentsFrame(GUID)
				end
		end)
		HeaderFrameCenter:Show()
	end
end
function EventFrame:UpdateCenterColumnPositions(columnWidthsCenter)
	for _, frame in ipairs(Octo_MainFrame_ToDo.ViewCenter:GetFrames()) do
		local accumulatedWidth = 0
		for i = 1, #columnWidthsCenter do
			if frame.columnFrames[i] then
				frame.columnFrames[i]:ClearAllPoints()
				frame.columnFrames[i]:SetPoint("LEFT", frame, "LEFT", accumulatedWidth, 0)
				frame.columnFrames[i]:SetWidth(columnWidthsCenter[i])
				accumulatedWidth = accumulatedWidth + columnWidthsCenter[i]
			end
		end
	end
end
local function Toggle_Octo_MainFrame_TestFrame(frame)
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
	end
end
function EventFrame:main_frame_toggle()
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetShown(not Octo_MainFrame_ToDo:IsShown())
	end
end
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CreateMainFrame()
	EventFrame:func_CreateSearchBox()
	E.func_CreateMenuStyle()
	E.func_Create_DDframe_ToDo(Octo_MainFrame_ToDo, E.COLOR_FACTION, function() EventFrame:CreateDataProvider() end)
	E.func_CreateMinimapButton(GlobalAddonName, Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, E.func_main_frame_toggle)
end
function EventFrame:PLAYER_REGEN_DISABLED()
	Octo_MainFrame_ToDo:Hide()
end