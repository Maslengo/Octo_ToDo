local GlobalAddonName, E = ...
local L = E.L
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local WIDTH_FRAME = 660
local HEIGHT_FRAME = 560
local WIDTH_ROW = WIDTH_FRAME / 2.2
local HEIGHT_ROW = 32
local WIDTH_BUTTON_BIG = 120
local WIDTH_BUTTON = 20
local HEIGHT_BUTTON = 20
local INDENT_CONTAINER = 16
local INDENT_ROW = 0
local WIDTH_DATAPROVIDER = WIDTH_ROW
local WIDTH_BUTTON_BIG = WIDTH_DATAPROVIDER/2 - INDENT_CONTAINER
local HEIGHT_DATAPROVIDER = 400
local INDENT_SCROLL = 6
----------------------------------------------------------------
local ALPHA_DISABLE = .5
local ALPHA_ENABLE = 1
local ALPHA_DRAG = .7
----------------------------------------------------------------
local dragText = E.classColorHexCurrent .. L["Drag to reorder"] .. "|r"
----------------------------------------------------------------
local ICON_DELETE = 130775
local ICON_UP = "minimal-scrollbar-arrow-top"
local ICON_DOWN = "minimal-scrollbar-arrow-bottom"
----------------------------------------------------------------
local tooltipFunc, clickFunc = nil, nil
----------------------------------------------------------------

function E.func_option_CHARACTERS(category, layout)
	----------------------------------------------------------------
	local EventFrame = CreateFrame("FRAME")
	EventFrame:Hide()
	----------------------------------------------------------------
	local scrollContentFrame_LEFT = CreateFrame("FRAME", nil, layout)
	scrollContentFrame_LEFT:Hide()
	----------------------------------------------------------------
	local scrollContentFrame_RIGHT = CreateFrame("FRAME", nil, layout)
	scrollContentFrame_RIGHT:Hide()
	----------------------------------------------------------------
	local dragFrame_LEFT = CreateFrame("FRAME", nil, UIParent, "OctoPropagateTemplate")
	local dragFrame_RIGHT = CreateFrame("FRAME", nil, UIParent, "OctoPropagateTemplate")
	----------------------------------------------------------------
	layout:SetScript("OnShow", function()
			scrollContentFrame_LEFT:Show()
			scrollContentFrame_RIGHT:Show()
			RunNextFrame(E.func_CreateDataProvider_CHARACTERS)
	end)
	----------------------------------------------------------------
	-- Функция для показа подтверждения удаления персонажа
	local function ConfirmCharacterDelete(GUID, CharInfo, callback)
		local name = E.pd.Name or E.TEXT_UNKNOWN
		local curServer = E.pd.curServer or ""
		local fullName = name .. " - " .. curServer
		StaticPopup_Show("CONFIRM_DELETE_CHARACTER", fullName, nil, {
				func = function()
					E.func_DELETEPERS(GUID)
					if callback then callback() end
				end
		})
	end
	-- Функция для показа подтверждения сброса настроек
	local function ConfirmReset(callback)
		StaticPopup_Show("CONFIRM_RESET_SORT_OPTIONS", nil, nil, {
				func = function()
					if callback then callback() end
				end
		})
	end
	-- Регистрация диалогов подтверждения
	StaticPopupDialogs["CONFIRM_DELETE_CHARACTER"] = {
		text = L["Are you sure you want to delete this character?"],
		button1 = L["YES"],
		button2 = L["NO"],
		OnAccept = function(self, data)
			if data and data.func then data.func() end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	StaticPopupDialogs["CONFIRM_RESET_SORT_OPTIONS"] = {
		text = L["Are you sure you want to reset settings? This action cannot be undone."],
		button1 = L["YES"],
		button2 = L["NO"],
		OnAccept = function(self, data)
			if data and data.func then data.func() end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	----------------------------------------------------------------
	-- Блоки func_OnAcquiredLEFT, func_OnAcquiredRIGHT, func_InitLEFT, func_InitRIGHT
	----------------------------------------------------------------
	local func_OnAcquiredLEFT do
		function E.Create_icon1frame_LEFT(frame) -- ACTIVE
			frame.icon1frame_LEFT = E.func_CreateUtilityButton(frame, nil, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc, true)
			frame.icon1frame_LEFT:SetPoint("LEFT")
			frame.icon1frame_LEFT:Hide()
		end
		function E.Create_TEXTLEFT_LEFT(frame)
			frame.TEXTLEFT = frame:CreateFontString()
			frame.TEXTLEFT:SetFontObject(E.OctoFont12_MT)
			frame.TEXTLEFT:SetPoint("LEFT", frame.icon1frame_LEFT, "RIGHT")
			frame.TEXTLEFT:SetWordWrap(false)
			frame.TEXTLEFT:SetJustifyV("MIDDLE")
			frame.TEXTLEFT:SetJustifyH("LEFT")
		end
		function E.Create_icon3frame_LEFT(frame) -- DELETE
			frame.icon3frame, frame.icon3texture = E.func_CreateUtilityButton(frame, ICON_DELETE, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc)
			frame.icon3frame:SetPoint("RIGHT", -6, 0)
			frame.icon3frame:Hide()
		end
		function E.Create_icon2frame_LEFT(frame) -- REVERSE
			local tooltipFunc = {{"REVERSE"}}
			frame.icon2frame, frame.icon2texture, frame.icon2textureBG = E.func_CreateUtilityButton(frame, nil, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc, true)
			frame.icon2frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -(4 + WIDTH_BUTTON), 0)
			frame.icon2frame:Hide()
		end
		function E.Create_icon4frame_LEFT(frame) -- UP
			frame.icon4frame, frame.icon4texture = E.func_CreateUtilityButton(frame, ICON_UP, 17, 11, tooltipFunc, clickFunc)
			frame.icon4frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, 6)
			frame.icon4frame:Hide()
		end
		function E.Create_icon5frame_LEFT(frame) -- DOWN
			frame.icon5frame, frame.icon5texture = E.func_CreateUtilityButton(frame, ICON_DOWN, 17, 11, tooltipFunc, clickFunc)
			frame.icon5frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, -6)
			frame.icon5frame:Hide()
		end
		function E.Create_BACKGROUND_LEFT(frame)
			frame.BACKGROUND_LEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			frame.BACKGROUND_LEFT:SetAllPoints()
			E.func_SetupTextureToFrame(frame.BACKGROUND_LEFT, E.TEXTURE_HEADER)
		end
		local function func_OnDragStart_LEFT(frame)
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			EventFrame.cover_LEFT.index = frame.index
			EventFrame.dragSourceIndex = frame.index
			dragFrame_LEFT:SetSize(frame:GetSize())
			dragFrame_LEFT.TEXTLEFT:SetText(frame.TEXTLEFT:GetText())
			dragFrame_LEFT:SetFrameLevel(frame:GetFrameLevel() + 500)
			dragFrame_LEFT:SetFrameStrata("TOOLTIP")
			local x, y = GetCursorPosition()
			local xd, yd = GetCursorDelta()
			local scale = frame:GetEffectiveScale()
			x = frame:GetLeft() + (x - (frame.dragStartX or x) - xd) / scale
			y = frame:GetBottom() + (y - (frame.dragStartY or y) - yd) / scale
			dragFrame_LEFT:SetPoint("BOTTOMLEFT", UIParent, x, y)
			dragFrame_LEFT:SetScript("OnUpdate", dragFrame_LEFT.onUpdate)
			dragFrame_LEFT:Show()
			EventFrame.cover_LEFT:SetParent(frame)
			EventFrame.cover_LEFT:SetAllPoints(frame)
			EventFrame.cover_LEFT:SetFrameLevel(frame:GetFrameLevel() + 2)
			EventFrame.cover_LEFT:Show()
			local index = frame.index
			local key = frame.key
			local order = frame.order
			do
				E.func_1_LEFT(dragFrame_LEFT, key)
				E.func_2_LEFT(dragFrame_LEFT, key)
				E.func_3_LEFT(dragFrame_LEFT, key, index)
				E.func_4_LEFT(dragFrame_LEFT, index, order)
				E.func_5_LEFT(dragFrame_LEFT, index, order)
				E.func_text_LEFT(dragFrame_LEFT, key)
				E.func_BACKGROUND_LEFT(dragFrame_LEFT, key)
			end
		end
		function func_OnAcquiredLEFT(owner, frame, node, new)
			if not new then
				return
			end
			frame:SetWidth(WIDTH_ROW)
			frame:Hide()
			E.Create_icon1frame_LEFT(frame)
			E.Create_TEXTLEFT_LEFT(frame)
			E.Create_icon3frame_LEFT(frame)
			E.Create_icon2frame_LEFT(frame)
			E.Create_icon4frame_LEFT(frame)
			E.Create_icon5frame_LEFT(frame)
			E.Create_BACKGROUND_LEFT(frame)
			frame:SetHeight(HEIGHT_ROW)
			frame:SetPoint("LEFT", owner, "LEFT")
			frame:SetScript("OnHide", function() frame:Hide() end)
			frame:EnableMouse(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", func_OnDragStart_LEFT)
			frame:SetScript("OnMouseDown", function(self) self.dragStartX, self.dragStartY = GetCursorPosition() end)
		end
	end
	----------------------------------------------------------------
	local func_OnAcquiredRIGHT do
		function E.Create_icon1frame_RIGHT(frame)
			frame.icon1frame_RIGHT = E.func_CreateUtilityButton(frame, nil, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc, true)
			frame.icon1frame_RIGHT:SetPoint("LEFT")
			frame.icon1frame_RIGHT:Hide()
		end
		function E.Create_icon2frame_RIGHT(frame)
			frame.icon2frame = CreateFrame("FRAME", nil, frame)
			frame.icon2frame:Hide()
			frame.icon2frame:SetPoint("LEFT", frame.icon1frame_RIGHT, "RIGHT")
			frame.icon2frame:SetSize(HEIGHT_BUTTON-2, HEIGHT_BUTTON-2)
			local texture = frame.icon2frame:CreateTexture(nil, "BACKGROUND", nil, 5)
			texture:SetPoint("CENTER")
			texture:SetSize(HEIGHT_BUTTON-6, HEIGHT_BUTTON-6)
			frame.icon2texture = texture
			frame.icon2frame:SetCollapsesLayout(true)
		end
		function E.Create_TEXT_RIGHT(frame)
			frame.TEXT_RIGHT = frame:CreateFontString()
			frame.TEXT_RIGHT:SetFontObject(E.OctoFont12_MT)
			frame.TEXT_RIGHT:SetPoint("LEFT", frame.icon2frame, "RIGHT")
			frame.TEXT_RIGHT:SetWordWrap(false)
			frame.TEXT_RIGHT:SetJustifyV("MIDDLE")
			frame.TEXT_RIGHT:SetJustifyH("CENTER")
		end
		function E.Create_icon3frame_RIGHT(frame)
			frame.icon3frame, frame.icon3texture = E.func_CreateUtilityButton(frame, ICON_DELETE, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc)
			frame.icon3frame:SetPoint("RIGHT", -6, 0)
			frame.icon3frame:Hide()
		end
		function E.Create_icon4frame_RIGHT(frame)
			frame.icon4frame, frame.icon4texture = E.func_CreateUtilityButton(frame, ICON_UP, 17, 11, tooltipFunc, clickFunc)
			frame.icon4frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, 6)
			frame.icon4frame:Hide()
		end
		function E.Create_icon5frame_RIGHT(frame)
			frame.icon5frame, frame.icon5texture = E.func_CreateUtilityButton(frame, ICON_DOWN, 17, 11, tooltipFunc, clickFunc)
			frame.icon5frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, -6)
			frame.icon5frame:Hide()
		end
		function E.Create_BACKGROUND_RIGHT(frame)
			frame.BACKGROUND_RIGHT = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			frame.BACKGROUND_RIGHT:SetAllPoints()
			E.func_SetupTextureToFrame(frame.BACKGROUND_RIGHT, E.TEXTURE_HEADER)
			frame.BACKGROUND_RIGHT:Hide()
		end
		local function func_OnDragStart_RIGHT(frame)
			if not E.func_CONFIG_SORTING_CUSTOM() then return end
			EventFrame.cover_RIGHT.index = frame.index
			EventFrame.dragSourceIndex_RIGHT = frame.index
			dragFrame_RIGHT:SetSize(frame:GetSize())
			dragFrame_RIGHT.TEXT_RIGHT:SetText(frame.TEXT_RIGHT:GetText())
			dragFrame_RIGHT:SetFrameLevel(frame:GetFrameLevel() + 500)
			dragFrame_RIGHT:SetFrameStrata("TOOLTIP")
			local x, y = GetCursorPosition()
			local xd, yd = GetCursorDelta()
			local scale = frame:GetEffectiveScale()
			x = frame:GetLeft() + (x - (frame.dragStartX or x) - xd) / scale
			y = frame:GetBottom() + (y - (frame.dragStartY or y) - yd) / scale
			dragFrame_RIGHT:SetPoint("BOTTOMLEFT", UIParent, x, y)
			dragFrame_RIGHT:SetScript("OnUpdate", dragFrame_RIGHT.onUpdate)
			dragFrame_RIGHT:Show()
			EventFrame.cover_RIGHT:SetParent(frame)
			EventFrame.cover_RIGHT:SetAllPoints(frame)
			EventFrame.cover_RIGHT:SetFrameLevel(frame:GetFrameLevel() + 2)
			EventFrame.cover_RIGHT:Show()
			local index = frame.index
			local GUID = frame.GUID
			local CharInfo = frame.CharInfo
			local pd = frame.pd
			local order = frame.order
			do
				E.func_1_RIGHT(dragFrame_RIGHT, GUID)
				E.func_2_RIGHT(dragFrame_RIGHT, pd)
				E.func_3_RIGHT(dragFrame_RIGHT, GUID, CharInfo)
				E.func_4_RIGHT(dragFrame_RIGHT, index, order)
				E.func_5_RIGHT(dragFrame_RIGHT, index, order)
				E.func_text_RIGHT(dragFrame_RIGHT, GUID, CharInfo, index, pd)
				E.func_BACKGROUND_RIGHT(dragFrame_RIGHT, GUID, CharInfo, pd)
			end
		end
		function func_OnAcquiredRIGHT(owner, frame, node, new)
			if not new then
				return
			end
			frame:SetWidth(WIDTH_ROW)
			frame:Hide()
			E.Create_icon1frame_RIGHT(frame)
			E.Create_icon2frame_RIGHT(frame)
			E.Create_TEXT_RIGHT(frame)
			E.Create_icon3frame_RIGHT(frame)
			E.Create_icon4frame_RIGHT(frame)
			E.Create_icon5frame_RIGHT(frame)
			E.Create_BACKGROUND_RIGHT(frame)
			frame:SetHeight(HEIGHT_ROW)
			frame:SetPoint("LEFT", owner, "LEFT")
			frame:SetScript("OnHide", function() frame:Hide() end)
			frame:EnableMouse(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", func_OnDragStart_RIGHT)
			frame:SetScript("OnMouseDown", function(self) self.dragStartX, self.dragStartY = GetCursorPosition() end)
		end
	end
	----------------------------------------------------------------
	local func_InitLEFT do
		-- Удалён захват переменных из E.func_GetProfile_CHARACTERS_CURRENT(); каждая функция получает свежие данные при вызове
		function E.func_1_LEFT(frame, key)
			frame.icon1frame_LEFT:Hide()
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			if key == "Name" then
				return
			end
			frame.icon1frame_LEFT:Show()
			local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			if CharacterProfile_SORTING then
				frame.icon1frame_LEFT:SetData(CharacterProfile_SORTING.sort_order_ACTIVED, key, E.func_CreateDataProvider_CHARACTERS)
			end
		end
		function E.func_2_LEFT(frame, key)
			frame.icon2frame:Hide()
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			frame.icon2frame:Show()
			local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			if CharacterProfile_SORTING then
				frame.icon2frame:SetData(CharacterProfile_SORTING.sort_reverse, key, E.func_CreateDataProvider_CHARACTERS)
			end
		end
		function E.func_3_LEFT(frame, key, index)
			frame.icon3frame:Hide()
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			if key == "Name" then
				return
			end
			frame.icon3frame:Show()
			frame.icon3frame:SetScript("OnClick", function()
				local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
				if not CharacterProfile_SORTING then
					return
				end
				table.remove(CharacterProfile_SORTING.sort_order, index)
				CharacterProfile_SORTING.sort_order_ACTIVED[key] = nil
				E.func_CreateDataProvider_CHARACTERS()
			end)
		end
		function E.func_4_LEFT(frame, index, order)
			frame.icon4frame:Hide()
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			if order and index > 1 then
				frame.icon4frame:Show()
			end
			frame.icon4frame:SetScript("OnClick", function()
					if not order then
						return
					end
					if index > 1 then
						local temp = order[index - 1]
						order[index - 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_CHARACTERS()
					end
			end)
		end
		function E.func_5_LEFT(frame, index, order)
			frame.icon5frame:Hide()
			if E.func_CONFIG_SORTING_CUSTOM() then return end
			if order and index < #order then
				frame.icon5frame:Show()
			end
			frame.icon5frame:SetScript("OnClick", function()
					if not order then
						return
					end
					if index < #order then
						local temp = order[index + 1]
						order[index + 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_CHARACTERS()
					end
			end)
		end
		function E.func_text_LEFT(frame, key)
			local _, _, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			local isActiveSettings = CharacterProfile_SORTING and CharacterProfile_SORTING.sort_order_ACTIVED[key]
			local isCustomSoring = CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM
			local displayName = E.SORT_OPTIONS[key].name
			local color = E.COLOR_WHITE
			if not isActiveSettings or isCustomSoring then
				color = E.COLOR_GRAY
			end
			frame.TEXTLEFT:SetText(color .. displayName .. "|r")
		end
		function E.func_BACKGROUND_LEFT(frame, key)
			local _, _, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
			local isActiveSettings = CharacterProfile_SORTING and CharacterProfile_SORTING.sort_order_ACTIVED[key]
			local isCustomSoring = CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM
			frame.BACKGROUND_LEFT:Show()
			local r, g, b, a = .8, .8, .8, .3
			if not isActiveSettings or isCustomSoring then
				r, g, b = .2, .2, .2
			end
			frame.BACKGROUND_LEFT:SetVertexColor(r, g, b, a)
		end
		function func_InitLEFT(frame, node, isDrag)
			local frameData = node:GetData()
			frame:Show()
			local index = frameData.index
			local key = frameData.key
			local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			local order = CharacterProfile_SORTING and CharacterProfile_SORTING.sort_order
			frame.index = index
			frame.key = key
			frame.order = order
			E.func_1_LEFT(frame, key)
			E.func_2_LEFT(frame, key)
			E.func_3_LEFT(frame, key, index)
			E.func_4_LEFT(frame, index, order)
			E.func_5_LEFT(frame, index, order)
			E.func_text_LEFT(frame, key)
			E.func_BACKGROUND_LEFT(frame, key)
			if EventFrame.cover_LEFT.index == frame.index then
				EventFrame.cover_LEFT:SetParent(frame)
				EventFrame.cover_LEFT:SetAllPoints(frame)
				EventFrame.cover_LEFT:SetFrameLevel(frame:GetFrameLevel() + 2)
				EventFrame.cover_LEFT:Show()
			end
		end
	end
	----------------------------------------------------------------
	local func_InitRIGHT do
		-- Удалён захват переменных из E.func_GetProfile_CHARACTERS_CURRENT(); каждая функция получает свежие данные при вызове
		function E.func_1_RIGHT(frame, GUID)
			frame.icon1frame_RIGHT:Hide()
			if GUID == E.curGUID then
				return
			end
			frame.icon1frame_RIGHT:Show()
			local _, CharacterProfile_GUIDS = E.func_GetProfile_CHARACTERS_CURRENT()
			if CharacterProfile_GUIDS then
				frame.icon1frame_RIGHT:SetData(CharacterProfile_GUIDS, GUID, E.func_CreateDataProvider_CHARACTERS)
			end
		end
		function E.func_2_RIGHT(frame, pd)
			frame.icon2frame:Hide()
			frame.icon2frame:Show()
			local specIcon = pd.specIcon or E.ICON_EMPTY
			E.func_SetupTextureToFrame(frame.icon2texture, specIcon)
		end
		function E.func_3_RIGHT(frame, GUID, CharInfo)
			frame.icon3frame:Hide()
			if GUID == E.curGUID then
				return
			end
			frame.icon3frame:Show()
			frame.icon3frame:SetScript("OnClick", function()
					ConfirmCharacterDelete(GUID, CharInfo, E.func_CreateDataProvider_CHARACTERS)
			end)
		end
		function E.func_4_RIGHT(frame, index, order)
			frame.icon4frame:Hide()
			local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
			if not CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM then return end
			if order and index > 1 then frame.icon4frame:Show() end
			frame.icon4frame:SetScript("OnClick", function()
					if not order then
						return
					end
					if index > 1 then
						local temp = order[index - 1]
						order[index - 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_CHARACTERS()
					end
			end)
		end
		function E.func_5_RIGHT(frame, index, order)
			frame.icon5frame:Hide()
			local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
			if not CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM then return end
			if order and index < #order then frame.icon5frame:Show() end
			frame.icon5frame:SetScript("OnClick", function()
					if not order then
						return
					end
					if index < #order then
						local temp = order[index + 1]
						order[index + 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_CHARACTERS()
					end
			end)
		end
		function E.func_text_RIGHT(frame, GUID, CharInfo, index, pd)
			local _, CharacterProfile_GUIDS = E.func_GetProfile_CHARACTERS_CURRENT()
			local isPlayerMustBeShown = CharacterProfile_GUIDS and CharacterProfile_GUIDS[GUID]
			local CustomColor
			if not (isPlayerMustBeShown or GUID == E.curGUID) then CustomColor = E.COLOR_GRAY end
			local Nickname = E.func_CharInfo_NickName(CharInfo, true, false, CustomColor, true)
			local Server = E.func_CharInfo_Server(CharInfo, true, false, CustomColor)
			frame.TEXT_RIGHT:SetText(Nickname .. " " .. Server)
		end
		function E.func_BACKGROUND_RIGHT(frame, GUID, CharInfo, pd)
			local _, CharacterProfile_GUIDS = E.func_GetProfile_CHARACTERS_CURRENT()
			local isPlayerMustBeShown = CharacterProfile_GUIDS and CharacterProfile_GUIDS[GUID]
			local r, g, b, a = .1, .1, .1, .5
			if isPlayerMustBeShown or GUID == E.curGUID then
				r, g, b, a = E.func_DB_HEADER_COLOR(CharInfo)
			end
			frame.BACKGROUND_RIGHT:Show()
			frame.BACKGROUND_RIGHT:SetVertexColor(r, g, b, a)
		end
		function func_InitRIGHT(frame, node)
			local frameData = node:GetData()
			frame:Show()
			local index = frameData.index
			local GUID = frameData.GUID
			local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
			if not CharInfo then
				return
			end
			local pd = CharInfo.PlayerData
			local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
			local order = CharacterProfile_SORTING and CharacterProfile_SORTING.GUID_order
			frame.index = index
			frame.GUID = GUID
			frame.CharInfo = CharInfo
			frame.pd = pd
			frame.order = order
			E.func_1_RIGHT(frame, GUID)
			E.func_2_RIGHT(frame, pd)
			E.func_3_RIGHT(frame, GUID, CharInfo)
			E.func_4_RIGHT(frame, index, order)
			E.func_5_RIGHT(frame, index, order)
			E.func_text_RIGHT(frame, GUID, CharInfo, index, pd)
			E.func_BACKGROUND_RIGHT(frame, GUID, CharInfo, pd)
			if EventFrame.cover_RIGHT.index == frame.index then
				EventFrame.cover_RIGHT:SetParent(frame)
				EventFrame.cover_RIGHT:SetAllPoints(frame)
				EventFrame.cover_RIGHT:SetFrameLevel(frame:GetFrameLevel() + 2)
				EventFrame.cover_RIGHT:Show()
			end
			frame.tooltip = nil
			frame:SetScript("OnEnter", function()
					local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
					if not CharInfo then
						return
					end
					local pd = CharInfo.PlayerData
					frame.tooltip = E.func_Tooltip_Chars(CharInfo, false)
					E.func_Octo_TooltipFrame_OnEnter(frame)
			end)
		end
	end
	----------------------------------------------------------------
	local func_CreateOcto_SortUI do
		local function scroll_LEFT(layout)
			scrollContentFrame_LEFT:SetPoint("TOPLEFT", layout, "TOPLEFT", 0, -INDENT_CONTAINER-40)
			scrollContentFrame_LEFT:SetPoint("BOTTOMLEFT", layout, "BOTTOMLEFT", INDENT_CONTAINER, INDENT_CONTAINER)
			scrollContentFrame_LEFT:SetWidth(WIDTH_DATAPROVIDER)
			scrollContentFrame_LEFT.ScrollBoxLEFT = CreateFrame("FRAME", nil, scrollContentFrame_LEFT, "WowScrollBoxList")
			scrollContentFrame_LEFT.ScrollBoxLEFT:SetAllPoints()
			scrollContentFrame_LEFT.ScrollBarLEFT = CreateFrame("EventFrame", nil, scrollContentFrame_LEFT, "MinimalScrollBar")
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("TOPLEFT", scrollContentFrame_LEFT, "TOPRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("BOTTOMLEFT", scrollContentFrame_LEFT, "BOTTOMRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ViewLEFT = CreateScrollBoxListTreeListView(0)
			scrollContentFrame_LEFT.ViewLEFT:SetElementExtent(HEIGHT_ROW)
			scrollContentFrame_LEFT.ViewLEFT:SetElementInitializer("OctoRectTemplate", function(...) func_InitLEFT(...) end)
			scrollContentFrame_LEFT.ViewLEFT:RegisterCallback(scrollContentFrame_LEFT.ViewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, scrollContentFrame_LEFT)
			ScrollUtil.InitScrollBoxListWithScrollBar(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT, scrollContentFrame_LEFT.ViewLEFT)
			ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT)
			do
				local frame = layout
				local providerfunc = nil
				local buttonName = nil
				EventFrame.DropDownFrame_LEFT = E.func_Create_DDframe_Options_LEFT(frame, providerfunc, buttonName)
				EventFrame.DropDownFrame_LEFT:SetPoint("BOTTOMLEFT", scrollContentFrame_LEFT, "TOPLEFT", 0, INDENT_CONTAINER)
				EventFrame.DropDownFrame_LEFT:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)

				EventFrame.hintLeft = scrollContentFrame_LEFT:CreateFontString()
				EventFrame.hintLeft:SetFontObject(E.OctoFont12_MT)
				EventFrame.hintLeft:SetPoint("BOTTOM", scrollContentFrame_LEFT, "TOP", 0, 0)
				EventFrame.hintLeft:SetJustifyH("CENTER")
				EventFrame.hintLeft:SetWidth(WIDTH_DATAPROVIDER)
			end
			do -- ResetFrame_LEFT
				local f = CreateFrame("BUTTON", "ResetFrame_LEFT", layout, "OctoBackdropPropagateTemplate")
				f:SetPoint("BOTTOMRIGHT", scrollContentFrame_LEFT, "TOPRIGHT", 0, INDENT_CONTAINER)
				f:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)
				table.insert(E.OctoTable_ColoredFrames, f)
				f.text = f:CreateFontString()
				f.text:SetFontObject(E.OctoFont12_MT)
				f.text:SetAllPoints()
				f.text:SetJustifyV("MIDDLE")
				f.text:SetJustifyH("CENTER")
				f.text:SetText(L["SETTINGS_DEFAULTS"])
				f:SetScript("OnClick", function(selfBtn)
					local CharacterProfile, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
					if CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM then
						return
					end
					ConfirmReset(function()
						local CharacterProfile = E.func_GetProfile_CHARACTERS_CURRENT()
						if CharacterProfile then
							CharacterProfile.SORTING = nil   -- удаляем старую сортировку
						end
						E.func_CreateProfile("CHARACTERS", E.CHARACTERS_CURRENT)
						E.func_CreateDataProvider_CHARACTERS()
					end)
				end)
				f:SetScript("OnMouseDown", function(selfBtn)
					local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
					if CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM then
						return
					end
					selfBtn.text:AdjustPointsOffset(1, -1)
				end)
				f:SetScript("OnMouseUp", function(selfBtn)
					local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
					if CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM then
						return
					end
					selfBtn.text:SetAllPoints()
					selfBtn.text:AdjustPointsOffset(-1, 1)
				end)
			end
		end

		local function scroll_RIGHT(layout)
			function E.disableButtonsUpdate()
				local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
				local isCustom = CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM
				local color = isCustom and E.COLOR_GRAY or E.COLOR_WHITE
				local alpha = isCustom and ALPHA_DISABLE or ALPHA_ENABLE
				if EventFrame.DropDownFrame_LEFT then
					EventFrame.DropDownFrame_LEFT:SetEnabled(not isCustom)
					EventFrame.DropDownFrame_LEFT:SetAlpha(alpha)
					EventFrame.DropDownFrame_LEFT.text:SetText(color..L["ADD"].."|r")
				end
				if ResetFrame_LEFT then
					ResetFrame_LEFT:SetEnabled(not isCustom)
					ResetFrame_LEFT:SetAlpha(alpha)
					if ResetFrame_LEFT.text then
						ResetFrame_LEFT.text:SetText(color..L["SETTINGS_DEFAULTS"].."|r")
					end
				end
				scrollContentFrame_LEFT:SetAlpha(alpha)
				local visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID = E.func_SortCharacters()
				if ResetFrame_RIGHT and ResetFrame_RIGHT.textUP and #visible > 0 then
					local text = #visible .. "/" .. E.TOTAL_CHARS
					ResetFrame_RIGHT.textUP:SetText(text)
					if isCustom then
						EventFrame.hintLeft:SetText("")
						EventFrame.hintRight:SetText(dragText)
					else
						EventFrame.hintLeft:SetText(dragText)
						EventFrame.hintRight:SetText("")
					end
				end
			end

			scrollContentFrame_RIGHT:SetPoint("TOPRIGHT", layout, "TOPRIGHT", -INDENT_CONTAINER-INDENT_SCROLL, -INDENT_CONTAINER-40)
			scrollContentFrame_RIGHT:SetPoint("BOTTOMRIGHT", layout, "BOTTOMRIGHT", -INDENT_CONTAINER, INDENT_CONTAINER)
			scrollContentFrame_RIGHT:SetWidth(WIDTH_DATAPROVIDER)
			scrollContentFrame_RIGHT.ScrollBoxRIGHT = CreateFrame("FRAME", nil, scrollContentFrame_RIGHT, "WowScrollBoxList")
			scrollContentFrame_RIGHT.ScrollBoxRIGHT:SetAllPoints()
			scrollContentFrame_RIGHT.ScrollBarRIGHT = CreateFrame("EventFrame", nil, scrollContentFrame_RIGHT, "MinimalScrollBar")
			scrollContentFrame_RIGHT.ScrollBarRIGHT:SetPoint("TOPLEFT", scrollContentFrame_RIGHT, "TOPRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_RIGHT.ScrollBarRIGHT:SetPoint("BOTTOMLEFT", scrollContentFrame_RIGHT, "BOTTOMRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_RIGHT.ViewRIGHT = CreateScrollBoxListTreeListView(0)
			scrollContentFrame_RIGHT.ViewRIGHT:SetElementExtent(HEIGHT_ROW)
			scrollContentFrame_RIGHT.ViewRIGHT:SetElementInitializer("OctoRectTemplate", function(...) func_InitRIGHT(...) end)
			scrollContentFrame_RIGHT.ViewRIGHT:RegisterCallback(scrollContentFrame_RIGHT.ViewRIGHT.Event.OnAcquiredFrame, func_OnAcquiredRIGHT, scrollContentFrame_RIGHT)
			ScrollUtil.InitScrollBoxListWithScrollBar(scrollContentFrame_RIGHT.ScrollBoxRIGHT, scrollContentFrame_RIGHT.ScrollBarRIGHT, scrollContentFrame_RIGHT.ViewRIGHT)
			ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollContentFrame_RIGHT.ScrollBoxRIGHT, scrollContentFrame_RIGHT.ScrollBarRIGHT)

			do
				local frame = layout
				local providerfunc = E.func_CreateDataProvider_CHARACTERS
				local buttonName = L["Characters"]
				EventFrame.DropDownFrame_RIGHT = E.func_Create_DDframe_Options_RIGHT(frame, providerfunc, buttonName)
				EventFrame.DropDownFrame_RIGHT:SetPoint("BOTTOMLEFT", scrollContentFrame_RIGHT, "TOPLEFT", 0, INDENT_CONTAINER)
				EventFrame.DropDownFrame_RIGHT:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)

				EventFrame.hintRight = scrollContentFrame_RIGHT:CreateFontString()
				EventFrame.hintRight:SetFontObject(E.OctoFont12_MT)
				EventFrame.hintRight:SetPoint("BOTTOM", scrollContentFrame_RIGHT, "TOP", 0, 0)
				EventFrame.hintRight:SetJustifyH("CENTER")
				EventFrame.hintRight:SetWidth(WIDTH_DATAPROVIDER)
			end

			-- Кнопка переключения режима сортировки (CUSTOM)
			do
				local ResetFrame_RIGHT = E.func_CreateUtilityButton(layout, nil, HEIGHT_BUTTON, HEIGHT_BUTTON, nil, nil, true, "ResetFrame_RIGHT")
				local _, _, CharacterProfile_OTHER = E.func_GetProfile_CHARACTERS_CURRENT()
				if CharacterProfile_OTHER then
					ResetFrame_RIGHT:SetData(CharacterProfile_OTHER, "CONFIG_SORTING_CUSTOM", E.func_CreateDataProvider_CHARACTERS)
				end
				ResetFrame_RIGHT:SetPoint("BOTTOMRIGHT", scrollContentFrame_RIGHT, "TOPRIGHT", -INDENT_CONTAINER*6, INDENT_CONTAINER)
				ResetFrame_RIGHT.text = ResetFrame_RIGHT:CreateFontString()
				ResetFrame_RIGHT.text:SetFontObject(E.OctoFont12_MT)
				ResetFrame_RIGHT.text:SetPoint("LEFT", ResetFrame_RIGHT.Icon, "RIGHT", 4, 0)
				ResetFrame_RIGHT.text:SetJustifyV("MIDDLE")
				ResetFrame_RIGHT.text:SetText(L["CUSTOM"])
				ResetFrame_RIGHT.textUP = ResetFrame_RIGHT:CreateFontString()
				ResetFrame_RIGHT.textUP:SetFontObject(E.OctoFont12_MT)
				ResetFrame_RIGHT.textUP:SetPoint("BOTTOM", ResetFrame_RIGHT.Icon, "TOP", 0, 4)
				ResetFrame_RIGHT.textUP:SetText(L["CUSTOM"])
				ResetFrame_RIGHT:HookScript("OnClick", E.disableButtonsUpdate)
				ResetFrame_RIGHT:HookScript("OnShow", E.disableButtonsUpdate)
			end
		end

		local function func_DRAG_SYSTEM_FOR_DATAPROVIDER_LEFT()
			local frame = dragFrame_LEFT
			do
				dragFrame_LEFT:SetWidth(WIDTH_ROW)
				dragFrame_LEFT:Hide()
				E.Create_icon1frame_LEFT(dragFrame_LEFT)
				E.Create_TEXTLEFT_LEFT(dragFrame_LEFT)
				E.Create_icon3frame_LEFT(dragFrame_LEFT)
				E.Create_icon2frame_LEFT(dragFrame_LEFT)
				E.Create_icon4frame_LEFT(dragFrame_LEFT)
				E.Create_icon5frame_LEFT(dragFrame_LEFT)
				E.Create_BACKGROUND_LEFT(dragFrame_LEFT)
			end
			dragFrame_LEFT:SetAlpha(ALPHA_DRAG)
			dragFrame_LEFT:SetMovable(true)
			dragFrame_LEFT:SetMouseClickEnabled(false)
			dragFrame_LEFT:SetMouseMotionEnabled(true)
			dragFrame_LEFT:SetSize(WIDTH_ROW, HEIGHT_ROW)
			EventFrame.separator_LEFT = CreateFrame("FRAME", nil, scrollContentFrame_LEFT)
			EventFrame.separator_LEFT:SetHeight(10)
			EventFrame.separator_LEFT:SetWidth(WIDTH_ROW)
			EventFrame.separator_LEFT:Hide()
			EventFrame.separator_LEFT.bg = EventFrame.separator_LEFT:CreateTexture(nil, "BACKGROUND")
			EventFrame.separator_LEFT.bg:SetPoint("TOPLEFT", 0, -2)
			EventFrame.separator_LEFT.bg:SetPoint("BOTTOMRIGHT", 0, -2)
			E.func_SetupTextureToFrame(EventFrame.separator_LEFT.bg, "Interface\\Buttons\\UI-Silver-Button-Highlight")
			EventFrame.separator_LEFT.bg:SetBlendMode("ADD")
			EventFrame.cover_LEFT = CreateFrame("FRAME")
			EventFrame.cover_LEFT:Hide()
			EventFrame.cover_LEFT.bg = EventFrame.cover_LEFT:CreateTexture(nil, "BACKGROUND")
			EventFrame.cover_LEFT.bg:SetAllPoints()
			EventFrame.cover_LEFT.bg:SetColorTexture(0.2, 0.2, 0.2, 0.6)
			EventFrame.cover_LEFT:SetScript("OnHide", function() EventFrame.cover_LEFT:Hide() end)
			dragFrame_LEFT.onUpdate = function(btn, elapsed)
				local x, y = GetCursorDelta()
				local scale = btn:GetEffectiveScale()
				btn:AdjustPointsOffset(x / scale, y / scale)
				EventFrame.separator_LEFT:Hide()
				EventFrame.separator_LEFT.id = nil
				for _, f in ipairs(scrollContentFrame_LEFT.ViewLEFT:GetFrames() or {}) do
					if f:IsMouseOver() then
						if f.index == btn.index then
							return
						end
						EventFrame.separator_LEFT:ClearAllPoints()
						local _, y = GetCursorPosition()
						local xc, yc = f:GetCenter()
						local scale = f:GetEffectiveScale()
						y = y / scale
						if yc < y then
							if f:GetTop() <= scrollContentFrame_LEFT:GetTop() + 5 then
								EventFrame.separator_LEFT.id = f.index
								EventFrame.separator_LEFT:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 5, -5)
								EventFrame.separator_LEFT:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -5, -5)
								EventFrame.separator_LEFT:Show()
							end
						else
							if math.floor(f:GetBottom() + 0.5) >= math.floor(scrollContentFrame_LEFT:GetBottom() + 0.5) then
								EventFrame.separator_LEFT.id = f.index + 1
								EventFrame.separator_LEFT:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 5, 5)
								EventFrame.separator_LEFT:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", -5, 5)
								EventFrame.separator_LEFT:Show()
							end
						end
						break
					end
				end
			end
			dragFrame_LEFT:SetScript("OnShow", function(btn) btn:RegisterEvent("GLOBAL_MOUSE_UP") end)
			dragFrame_LEFT:SetScript("OnHide", function(btn) btn:UnregisterEvent("GLOBAL_MOUSE_UP"); btn:SetScript("OnUpdate", nil) end)
			dragFrame_LEFT:SetScript("OnEvent", function(btn)
				btn:SetScript("OnUpdate", nil)
				btn:Hide()
				EventFrame.cover_LEFT.index = nil
				EventFrame.cover_LEFT:Hide()
				local newID = EventFrame.separator_LEFT.id
				if newID then
					local id = EventFrame.dragSourceIndex
					EventFrame.separator_LEFT:Hide()
					if id then
						local CharacterProfile, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
						if not CharacterProfile_SORTING then
							return
						end
						local order = CharacterProfile_SORTING.sort_order
						if newID > id then newID = newID - 1 end
						table.insert(order, newID, table.remove(order, id))
						E.func_CreateDataProvider_CHARACTERS()
					end
				end
			end)
		end

		local function func_DRAG_SYSTEM_FOR_DATAPROVIDER_RIGHT()
			local frame = dragFrame_RIGHT
			do
				dragFrame_RIGHT:SetWidth(WIDTH_ROW)
				dragFrame_RIGHT:Hide()
				E.Create_icon1frame_RIGHT(dragFrame_RIGHT)
				E.Create_icon2frame_RIGHT(dragFrame_RIGHT)
				E.Create_TEXT_RIGHT(dragFrame_RIGHT)
				E.Create_icon3frame_RIGHT(dragFrame_RIGHT)
				E.Create_icon4frame_RIGHT(dragFrame_RIGHT)
				E.Create_icon5frame_RIGHT(dragFrame_RIGHT)
				E.Create_BACKGROUND_RIGHT(dragFrame_RIGHT)
			end
			dragFrame_RIGHT:SetAlpha(ALPHA_DRAG)
			dragFrame_RIGHT:SetMovable(true)
			dragFrame_RIGHT:SetMouseClickEnabled(false)
			dragFrame_RIGHT:SetMouseMotionEnabled(true)
			dragFrame_RIGHT:SetSize(WIDTH_ROW, HEIGHT_ROW)
			EventFrame.separator_RIGHT = CreateFrame("FRAME", nil, scrollContentFrame_RIGHT)
			EventFrame.separator_RIGHT:SetHeight(10)
			EventFrame.separator_RIGHT:SetWidth(WIDTH_ROW)
			EventFrame.separator_RIGHT:Hide()
			EventFrame.separator_RIGHT.bg = EventFrame.separator_RIGHT:CreateTexture(nil, "BACKGROUND")
			EventFrame.separator_RIGHT.bg:SetPoint("TOPLEFT", 0, -2)
			EventFrame.separator_RIGHT.bg:SetPoint("BOTTOMRIGHT", 0, -2)
			E.func_SetupTextureToFrame(EventFrame.separator_RIGHT.bg, "Interface\\Buttons\\UI-Silver-Button-Highlight")
			EventFrame.separator_RIGHT.bg:SetBlendMode("ADD")
			EventFrame.cover_RIGHT = CreateFrame("FRAME")
			EventFrame.cover_RIGHT:Hide()
			EventFrame.cover_RIGHT.bg = EventFrame.cover_RIGHT:CreateTexture(nil, "BACKGROUND")
			EventFrame.cover_RIGHT.bg:SetAllPoints()
			EventFrame.cover_RIGHT.bg:SetColorTexture(0.2, 0.2, 0.2, 0.6)
			EventFrame.cover_RIGHT:SetScript("OnHide", function() EventFrame.cover_RIGHT:Hide() end)
			dragFrame_RIGHT.onUpdate = function(btn, elapsed)
				local x, y = GetCursorDelta()
				local scale = btn:GetEffectiveScale()
				btn:AdjustPointsOffset(x / scale, y / scale)
				EventFrame.separator_RIGHT:Hide()
				EventFrame.separator_RIGHT.id = nil
				for _, f in ipairs(scrollContentFrame_RIGHT.ViewRIGHT:GetFrames() or {}) do
					if f:IsMouseOver() then
						if f.index == btn.index then
							return
						end
						EventFrame.separator_RIGHT:ClearAllPoints()
						local _, y = GetCursorPosition()
						local xc, yc = f:GetCenter()
						local scale = f:GetEffectiveScale()
						y = y / scale
						if yc < y then
							if f:GetTop() <= scrollContentFrame_RIGHT:GetTop() + 5 then
								EventFrame.separator_RIGHT.id = f.index
								EventFrame.separator_RIGHT:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 5, -5)
								EventFrame.separator_RIGHT:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -5, -5)
								EventFrame.separator_RIGHT:Show()
							end
						else
							if math.floor(f:GetBottom() + 0.5) >= math.floor(scrollContentFrame_RIGHT:GetBottom() + 0.5) then
								EventFrame.separator_RIGHT.id = f.index + 1
								EventFrame.separator_RIGHT:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 5, 5)
								EventFrame.separator_RIGHT:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", -5, 5)
								EventFrame.separator_RIGHT:Show()
							end
						end
						break
					end
				end
			end
			dragFrame_RIGHT:SetScript("OnShow", function(btn) btn:RegisterEvent("GLOBAL_MOUSE_UP") end)
			dragFrame_RIGHT:SetScript("OnHide", function(btn) btn:UnregisterEvent("GLOBAL_MOUSE_UP"); btn:SetScript("OnUpdate", nil) end)
			dragFrame_RIGHT:SetScript("OnEvent", function(btn)
				btn:SetScript("OnUpdate", nil)
				btn:Hide()
				EventFrame.cover_RIGHT.index = nil
				EventFrame.cover_RIGHT:Hide()
				local newID = EventFrame.separator_RIGHT.id
				if newID then
					local id = EventFrame.dragSourceIndex_RIGHT
					EventFrame.separator_RIGHT:Hide()
					if id then
						local CharacterProfile, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
						if not CharacterProfile_SORTING then
							return
						end
						local order = CharacterProfile_SORTING.GUID_order
						if newID > id then newID = newID - 1 end
						table.insert(order, newID, table.remove(order, id))
						E.func_CreateDataProvider_CHARACTERS()
					end
				end
			end)
		end

		function func_CreateOcto_SortUI()
			layout:SetPoint("TOPLEFT", INDENT_CONTAINER, -INDENT_CONTAINER*2)
			layout:SetPoint("BOTTOMRIGHT", -INDENT_CONTAINER, INDENT_CONTAINER)
			scroll_LEFT(layout)
			func_DRAG_SYSTEM_FOR_DATAPROVIDER_LEFT()
			func_DRAG_SYSTEM_FOR_DATAPROVIDER_RIGHT()
			scroll_RIGHT(layout)
		end
	end
	-- Создание провайдеров данных
	local function func_CreateDataProvider_RIGHT()
		local DataProvider = CreateTreeDataProvider()
		local totalLines = 0
		local CharacterProfile, _, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
		if CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM and CharacterProfile_SORTING and CharacterProfile_SORTING.GUID_order then
			totalLines = #CharacterProfile_SORTING.GUID_order
			for index, GUID in ipairs(CharacterProfile_SORTING.GUID_order) do
				local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
				if CharInfo then
					DataProvider:Insert({ index = index, GUID = GUID })
				end
			end
		else
			local visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID = E.func_SortCharacters()
			for index, CharInfo in ipairs(visible) do
				local pd = CharInfo.PlayerData
				totalLines = totalLines + 1
				DataProvider:Insert({index = totalLines, GUID = pd.GUID})
			end
			for index, CharInfo in ipairs(hidden) do
				local pd = CharInfo.PlayerData
				totalLines = totalLines + 1
				DataProvider:Insert({index = totalLines, GUID = pd.GUID})
			end
		end
		if totalLines == 0 then
			DataProvider:Insert({GUID = E.curGUID})
		end
		EventFrame:UpdateDataProvider_RIGHT(DataProvider, totalLines)
	end
	function EventFrame:UpdateDataProvider_RIGHT(DataProvider, totalLines)
		scrollContentFrame_RIGHT.ViewRIGHT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		local visibleLines = math.min(20, totalLines)
		local height = visibleLines * HEIGHT_ROW + INDENT_ROW * 2
		scrollContentFrame_RIGHT.ScrollBoxRIGHT:SetHeight(height)
	end
	local function func_CreateDataProvider_LEFT()
		local DataProvider = CreateTreeDataProvider()
		local _, _, _, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()
		local order = CharacterProfile_SORTING and CharacterProfile_SORTING.sort_order
		if not order then
			return
		end
		local totalLines = 0
		for index, key in ipairs(order) do
			totalLines = totalLines + 1
			DataProvider:Insert({ index = index, key = key })
		end
		EventFrame:UpdateDataProvider_LEFT(DataProvider, totalLines)
	end
	function EventFrame:UpdateDataProvider_LEFT(DataProvider, totalLines)
		scrollContentFrame_LEFT.ViewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		local visibleLines = math.min(20, totalLines)
		local height = visibleLines * HEIGHT_ROW + INDENT_ROW * 2
		scrollContentFrame_LEFT.ScrollBoxLEFT:SetHeight(height)
	end
	function E.func_CreateDataProvider_CHARACTERS()
		func_CreateDataProvider_RIGHT()
		func_CreateDataProvider_LEFT()
		E.disableButtonsUpdate()
	end
	func_CreateOcto_SortUI()
end