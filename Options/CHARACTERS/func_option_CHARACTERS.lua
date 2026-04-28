local GlobalAddonName, E = ...
local L = E.L
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local WIDTH_FRAME = 660 -- ШИРИНА
local HEIGHT_FRAME = 560 -- ВЫСОТА
local WIDTH_ROW = WIDTH_FRAME / 2.2 -- ШИРИНА
local HEIGHT_ROW = 32 -- ВЫСОТА
local WIDTH_BUTTON_BIG = 120 -- ШИРИНА
local WIDTH_BUTTON = 20 -- HEIGHT_ROW-2 -- ШИРИНА
local HEIGHT_BUTTON = 20 -- HEIGHT_ROW-2 -- ВЫСОТА
local INDENT_CONTAINER = 16
local INDENT_ROW = 0
local WIDTH_DATAPROVIDER = WIDTH_ROW -- ШИРИНА
local WIDTH_BUTTON_BIG = WIDTH_DATAPROVIDER/2 - INDENT_CONTAINER -- ШИРИНА
local HEIGHT_DATAPROVIDER = 400 -- ВЫСОТА
local INDENT_SCROLL = 6
----------------------------------------------------------------
local ALPHA_DISABLE = .5
local ALPHA_ENABLE = 1
local ALPHA_DRAG = .7
----------------------------------------------------------------
local dragText = E.classColorHexCurrent .. L["Drag to reorder"] .. "|r"
----------------------------------------------------------------
-- local ICON_SETTINGS_GREEN = E.ICON_SETTINGS_GREEN
-- local ICON_SETTINGS_RED = E.ICON_SETTINGS_RED
-- local ICON_SETTINGS_GRAY = E.ICON_SETTINGS_GRAY
-- local ICON_SETTINGS_DARKGRAY = E.ICON_SETTINGS_DARKGRAY
local ICON_DELETE = 130775 -- E.ICON_DELETE
local ICON_UP = "minimal-scrollbar-arrow-top" -- E.ICON_UP
local ICON_DOWN = "minimal-scrollbar-arrow-bottom" -- E.ICON_DOWN
-- local ICON_SETTINGS_ACTIVE = "checkmark-minimal"
-- local ICON_SETTINGS_INACTIVE = E.ICON_EMPTY -- "checkbox-minimal"
-- local ICON_SETTINGS_DISABLED = "checkmark-minimal-disabled"
-- local ICON_SETTINGS_BACKGROUD = "checkbox-minimal"
----------------------------------------------------------------
function E.func_option_CHARACTERS(category, layout) -- layout
	----------------------------------------------------------------
	local EventFrame = CreateFrame("FRAME")
	EventFrame:Hide()
	----------------------------------------------------------------
	local scrollContentFrame_LEFT = CreateFrame("FRAME", nil, layout)
	scrollContentFrame_LEFT:Hide()
	-- scrollContentFrame_LEFT.BG = scrollContentFrame_LEFT:CreateTexture(nil, "BACKGROUND", nil, -2)
	-- scrollContentFrame_LEFT.BG:SetAllPoints()
	-- scrollContentFrame_LEFT.BG:SetColorTexture(.1, .1, .1, 0)
	----------------------------------------------------------------
	local scrollContentFrame_RIGHT = CreateFrame("FRAME", nil, layout)
	scrollContentFrame_RIGHT:Hide()
	-- scrollContentFrame_RIGHT.BG = scrollContentFrame_RIGHT:CreateTexture(nil, "BACKGROUND", nil, -2)
	-- scrollContentFrame_RIGHT.BG:SetAllPoints()
	-- scrollContentFrame_RIGHT.BG:SetColorTexture(.1, .1, .1, 0)
	----------------------------------------------------------------
	local dragFrame_LEFT = CreateFrame("FRAME", nil, UIParent, "OctoPropagateTemplate")
	-- dragFrame_LEFT:SetBackdrop(E.menuBackdrop)
	local dragFrame_RIGHT = CreateFrame("FRAME", nil, UIParent, "OctoPropagateTemplate")
	-- dragFrame_RIGHT:SetBackdrop(E.menuBackdrop)
	----------------------------------------------------------------
	layout:SetScript("OnShow", function()
			scrollContentFrame_LEFT:Show()
			scrollContentFrame_RIGHT:Show()
			RunNextFrame(E.func_CreateDataProvider_SORTUI_FAST) -- C_Timer.After(0, E.func_CreateDataProvider_SORTUI_FAST)
	end)
	----------------------------------------------------------------
	-- Функция для показа подтверждения удаления персонажа
	local function ConfirmCharacterDelete(GUID, CharInfo, callback)
		local name = CharInfo.PlayerData.Name or "Unknown"
		local curServer = CharInfo.PlayerData.curServer or ""
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
	local function func_GetAvailableOptions_LEFT()
		local order = Octo_ToDo_DB_Options and Octo_ToDo_DB_Options.sort_order
		if not order then return end
		local uses = {}
		for _, key in ipairs(order) do
			uses[key] = uses[key] or true
		end
		local available = {}
		for vars, opt in next, (E.SORT_OPTIONS) do
			if not uses[vars] then
				table.insert(available, {vars = vars, displayName = opt.name})
			end
		end
		table.sort(available, function(a, b) return a.displayName < b.displayName end)
		return available
	end
	----------------------------------------------------------------
	local func_OnAcquiredLEFT do
		function E.Create_icon1frame_LEFT(frame) -- ACTIVE
			-- local tooltipFunc = {{"ACTIVE"}}
			frame.icon1frame_LEFT = E.func_CreateUtilityButton(frame, nil, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc, true)
			frame.icon1frame_LEFT:SetPoint("LEFT")
			frame.icon1frame_LEFT:Hide()
		end
		function E.Create_TEXTLEFT_LEFT(frame)
			frame.TEXTLEFT = frame:CreateFontString()
			frame.TEXTLEFT:SetFontObject(OctoFont11)
			frame.TEXTLEFT:SetPoint("LEFT", frame.icon1frame_LEFT, "RIGHT")
			frame.TEXTLEFT:SetWordWrap(false)
			frame.TEXTLEFT:SetJustifyV("MIDDLE")
			frame.TEXTLEFT:SetJustifyH("LEFT")
		end
		function E.Create_icon3frame_LEFT(frame) -- DELETE
			-- local tooltipFunc = {{"DELETE"}}
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
			-- local tooltipFunc = {{"UP"}}
			frame.icon4frame, frame.icon4texture = E.func_CreateUtilityButton(frame, ICON_UP, 17, 11, tooltipFunc, clickFunc)
			frame.icon4frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, 6)
			frame.icon4frame:Hide()
		end
		function E.Create_icon5frame_LEFT(frame) -- DOWN
			-- local tooltipFunc = {{"DOWN"}}
			frame.icon5frame, frame.icon5texture = E.func_CreateUtilityButton(frame, ICON_DOWN, 17, 11, tooltipFunc, clickFunc)
			frame.icon5frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, -6)
			frame.icon5frame:Hide()
		end
		function E.Create_BACKGROUND_LEFT(frame)
			frame.BACKGROUND_LEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			frame.BACKGROUND_LEFT:SetAllPoints()
			E.func_SetupTextureToFrame(frame.BACKGROUND_LEFT, E.TEXTURE_HEADER)
			-- frame.BACKGROUND_LEFT:Hide()
		end
		local function func_OnDragStart_LEFT(frame)
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			EventFrame.cover_LEFT.index = frame.index
			EventFrame.dragSourceIndex = frame.index --node:GetData().index
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
			do -- ACTIVE
				E.func_1_LEFT(dragFrame_LEFT, key) -- ACTIVE
				E.func_2_LEFT(dragFrame_LEFT, key) -- REVERSE
				E.func_3_LEFT(dragFrame_LEFT, key, index) -- DELETE
				E.func_4_LEFT(dragFrame_LEFT, index, order) -- UP
				E.func_5_LEFT(dragFrame_LEFT, index, order) -- DOWN
				E.func_text_LEFT(dragFrame_LEFT, key)
				E.func_BACKGROUND_LEFT(dragFrame_LEFT, key)
			end
		end
		function func_OnAcquiredLEFT(owner, frame, node, new)
			if not new then return end
			local frameData = node:GetData()
			-- frame:SetBackdrop(E.menuBackdrop)
			----------------
			do
				frame:SetWidth(WIDTH_ROW)
				frame:Hide()
				E.Create_icon1frame_LEFT(frame) -- ACTIVE
				E.Create_TEXTLEFT_LEFT(frame)
				E.Create_icon3frame_LEFT(frame) -- DELETE
				E.Create_icon2frame_LEFT(frame) -- REVERSE
				E.Create_icon4frame_LEFT(frame) -- UP
				E.Create_icon5frame_LEFT(frame) -- DOWN
				E.Create_BACKGROUND_LEFT(frame)
			end
			----------------
			-- E.func_Create_Highlight(frame, owner)
			-- if frame.Highlight then
			--     frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
			--     frame:SetScript("OnShow", function() frame.Highlight:Show() end)
			-- end
			----------------
			frame:SetHeight(HEIGHT_ROW)
			frame:SetPoint("LEFT", owner, "LEFT")
			frame:SetScript("OnHide", function()
					frame:Hide()
			end)
			-- Drag
			frame:EnableMouse(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", func_OnDragStart_LEFT)
			frame:SetScript("OnMouseDown", function(self)
					self.dragStartX, self.dragStartY = GetCursorPosition()
			end)
			frame:SetScript("OnDragStop", function(self)
					-- ничего
			end)
		end
	end
	----------------------------------------------------------------
	local func_OnAcquiredRIGHT do
		function E.Create_icon1frame_RIGHT(frame) -- ACTIVE
			-- local tooltipFunc = {{"ACTIVE"}}
			frame.icon1frame_RIGHT = E.func_CreateUtilityButton(frame, nil, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc, true)
			frame.icon1frame_RIGHT:SetPoint("LEFT")
			frame.icon1frame_RIGHT:Hide()
		end
		function E.Create_icon2frame_RIGHT(frame) -- SPEC ICON
			frame.icon2frame = CreateFrame("FRAME", nil, frame)
			frame.icon2frame:Hide()
			frame.icon2frame:SetPoint("LEFT", frame.icon1frame_RIGHT, "RIGHT")
			frame.icon2frame:SetSize(HEIGHT_BUTTON-2, HEIGHT_BUTTON-2)
			local texture = frame.icon2frame:CreateTexture(nil, "BACKGROUND", nil, 5)
			texture:SetPoint("CENTER")
			texture:SetSize(HEIGHT_BUTTON-6, HEIGHT_BUTTON-6)
			-- texture:SetTexCoord(.10, .90, .10, .90)
			frame.icon2texture = texture
			frame.icon2frame:SetCollapsesLayout(true)
		end
		function E.Create_TEXT_RIGHT(frame)
			frame.TEXT_RIGHT = frame:CreateFontString()
			frame.TEXT_RIGHT:SetFontObject(OctoFont11)
			frame.TEXT_RIGHT:SetPoint("LEFT", frame.icon2frame, "RIGHT")
			frame.TEXT_RIGHT:SetWordWrap(false)
			frame.TEXT_RIGHT:SetJustifyV("MIDDLE")
			frame.TEXT_RIGHT:SetJustifyH("CENTER")
		end
		function E.Create_icon3frame_RIGHT(frame) -- DELETE
			-- local tooltipFunc = {{"DELETE"}}
			frame.icon3frame, frame.icon3texture = E.func_CreateUtilityButton(frame, ICON_DELETE, WIDTH_BUTTON-2, HEIGHT_BUTTON-2, tooltipFunc, clickFunc)
			frame.icon3frame:SetPoint("RIGHT", -6, 0)
			frame.icon3frame:Hide()
		end
		function E.Create_icon4frame_RIGHT(frame) -- UP
			-- local tooltipFunc = {{"UP"}}
			frame.icon4frame, frame.icon4texture = E.func_CreateUtilityButton(frame, ICON_UP, 17, 11, tooltipFunc, clickFunc)
			frame.icon4frame:SetPoint("RIGHT", frame.icon3frame, "LEFT", -4, 6)
			frame.icon4frame:Hide()
		end
		function E.Create_icon5frame_RIGHT(frame) -- DOWN
			-- local tooltipFunc = {{"DOWN"}}
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
			if not Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
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
			-- local key = frame.key
			local order = frame.order
			do
				E.func_1_RIGHT(dragFrame_RIGHT, pd)
				E.func_2_RIGHT(dragFrame_RIGHT, pd)
				E.func_3_RIGHT(dragFrame_RIGHT, GUID, CharInfo) -- DELETE
				E.func_4_RIGHT(dragFrame_RIGHT, index, order)  -- UP
				E.func_5_RIGHT(dragFrame_RIGHT, index, order)  -- DOWN
				E.func_text_RIGHT(dragFrame_RIGHT, CharInfo, index, pd)
				E.func_BACKGROUND_RIGHT(dragFrame_RIGHT, GUID, CharInfo, pd)
			end
		end
		function func_OnAcquiredRIGHT(owner, frame, node, new)
			if not new then return end
			local frameData = node:GetData()
			-- frame:SetBackdrop(E.menuBackdrop)
			----------------
			do
				frame:SetWidth(WIDTH_ROW)
				frame:Hide()
				E.Create_icon1frame_RIGHT(frame) -- ACTIVE
				E.Create_icon2frame_RIGHT(frame) -- SPEC ICON
				E.Create_TEXT_RIGHT(frame) -- TEXT_RIGHT
				E.Create_icon3frame_RIGHT(frame) -- DELETE
				E.Create_icon4frame_RIGHT(frame) -- UP
				E.Create_icon5frame_RIGHT(frame) -- DOWN
				E.Create_BACKGROUND_RIGHT(frame)
			end
			----------------
			-- E.func_Create_Highlight(frame, owner)
			-- if frame.Highlight then
			--     frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
			--     frame:SetScript("OnShow", function() frame.Highlight:Show() end)
			-- end
			----------------
			frame:SetHeight(HEIGHT_ROW)
			frame:SetPoint("LEFT", owner, "LEFT")
			frame:SetScript("OnHide", function()
					frame:Hide()
			end)
			-- Drag
			frame:EnableMouse(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", func_OnDragStart_RIGHT)
			frame:SetScript("OnMouseDown", function(self)
					self.dragStartX, self.dragStartY = GetCursorPosition()
			end)
			frame:SetScript("OnDragStop", function(self)
					-- ничего
			end)
		end
	end
	----------------------------------------------------------------
	local func_InitLEFT do
		function E.func_1_LEFT(frame, key) -- ACTIVE
			frame.icon1frame_LEFT:Hide()
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if key == "Name" then return end
			frame.icon1frame_LEFT:Show()
			frame.icon1frame_LEFT:SetData(Octo_ToDo_DB_Options.sort_order_ACTIVED, key, E.func_CreateDataProvider_SORTUI_FAST)
		end
		function E.func_2_LEFT(frame, key) -- REVERSE
			frame.icon2frame:Hide()
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			frame.icon2frame:Show()
			frame.icon2frame:SetData(Octo_ToDo_DB_Options.sort_reverse, key, E.func_CreateDataProvider_SORTUI_FAST)
		end
		function E.func_3_LEFT(frame, key, index) -- DELETE
			frame.icon3frame:Hide()
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if key == "Name" then return end
			frame.icon3frame:Show()
			frame.icon3frame:SetScript("OnClick", function() -- DELETE
					table.remove(Octo_ToDo_DB_Options.sort_order, index)
					Octo_ToDo_DB_Options.sort_order_ACTIVED[key] = nil
					E.func_CreateDataProvider_SORTUI_FAST()
			end)
		end
		function E.func_4_LEFT(frame, index, order) -- UP
			frame.icon4frame:Hide()
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if order and index > 1 then
				frame.icon4frame:Show()
			end
			frame.icon4frame:SetScript("OnClick", function() -- UP
					if not order then return end
					if index > 1 then
						local temp = order[index - 1]
						order[index - 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_SORTUI_FAST()
					end
			end)
		end
		function E.func_5_LEFT(frame, index, order)  -- DOWN
			frame.icon5frame:Hide()
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if order and index < #order then
				frame.icon5frame:Show()
			end
			frame.icon5frame:SetScript("OnClick", function() -- DOWN
					if not order then return end
					if index < #order then
						local temp = order[index + 1]
						order[index + 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_SORTUI_FAST()
					end
			end)
		end

		function E.func_text_LEFT(frame, key)
			local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
			local isActiveSettings = Octo_ToDo_DB_Options.sort_order_ACTIVED[key]
			local isCustomSoring = Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM

			local displayName = E.SORT_OPTIONS[key].name


			local color = E.COLOR_WHITE
			if not isActiveSettings or isCustomSoring then
				color = E.COLOR_GRAY
			end
			frame.TEXTLEFT:SetText(color .. displayName .. "|r")

		end
		function E.func_BACKGROUND_LEFT(frame, key)
			local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
			local isActiveSettings = Octo_ToDo_DB_Options.sort_order_ACTIVED[key]
			local isCustomSoring = Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM
			frame.BACKGROUND_LEFT:Show()
			-- local r, g, b, a = .5, .3, .1, .5
			local r, g, b, a = 1, 1, 1, .5
			local _, _, _, a = E.func_DB_HEADER_COLOR(CharInfo)
			if not isActiveSettings or isCustomSoring then
				r, g, b = .2,.2,.2
			end
			frame.BACKGROUND_LEFT:SetVertexColor(r, g, b, a)
		end
		----------------------------------------------------------------
		function func_InitLEFT(frame, node, isDrag)
			local frameData = node:GetData()
			frame:Show()
			local index = frameData.index
			local key = frameData.key

			local isReverse = Octo_ToDo_DB_Options.sort_reverse[key]

			local order = Octo_ToDo_DB_Options and Octo_ToDo_DB_Options.sort_order
			-- ОБНОВЛЯЕМ ИНДЕКС ПРИ КАЖДОМ ВЫЗОВЕ
			frame.index = index
			frame.key = key
			frame.order = order

			do

				E.func_1_LEFT(frame, key) -- ACTIVE
				E.func_2_LEFT(frame, key) -- REVERSE
				E.func_3_LEFT(frame, key, index) -- DELETE
				E.func_4_LEFT(frame, index, order) -- UP
				E.func_5_LEFT(frame, index, order) -- DOWN
				E.func_text_LEFT(frame, key)
				E.func_BACKGROUND_LEFT(frame, key) -- BACKGROUND_LEFT
			end
			-- EventFrame.cover_LEFT:Hide()
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
		function E.func_1_RIGHT(frame, pd)
			frame.icon1frame_RIGHT:Hide()
			if GUID == E.curGUID then return end
			frame.icon1frame_RIGHT:Show()
			frame.icon1frame_RIGHT:SetData(pd, "CONFIG_SHOW_PLAYER", E.func_CreateDataProvider_SORTUI_FAST)
		end
		function E.func_2_RIGHT(frame, pd)
			frame.icon2frame:Hide()
			frame.icon2frame:Show()
			local specIcon = pd.specIcon or E.ICON_EMPTY
			E.func_SetupTextureToFrame(frame.icon2texture, specIcon)-- SPEC ICON
		end
		function E.func_3_RIGHT(frame, GUID, CharInfo)
			frame.icon3frame:Hide()
			if GUID == E.curGUID then return end
			frame.icon3frame:Show()
			frame.icon3frame:SetScript("OnClick", function() -- DELETE with confirmation
					ConfirmCharacterDelete(GUID, CharInfo, E.func_CreateDataProvider_SORTUI_FAST)
			end)
		end
		function E.func_4_RIGHT(frame, index, order) -- UP
			frame.icon4frame:Hide()
			if not Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if order and index > 1 then
				frame.icon4frame:Show()
			end
			frame.icon4frame:SetScript("OnClick", function() -- UP
					if not order then return end
					if index > 1 then
						local temp = order[index - 1]
						order[index - 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_SORTUI_FAST()
					end
			end)
		end
		function E.func_5_RIGHT(frame, index, order)  -- DOWN
			frame.icon5frame:Hide()
			if not Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
			if order and index < #order then
				frame.icon5frame:Show()
			end
			frame.icon5frame:SetScript("OnClick", function() -- DOWN
					if not order then return end
					if index < #order then
						local temp = order[index + 1]
						order[index + 1] = order[index]
						order[index] = temp
						E.func_CreateDataProvider_SORTUI_FAST()
					end
			end)
		end
		function E.func_text_RIGHT(frame, CharInfo, index, pd)
			local isPlayerMustBeShown = pd.CONFIG_SHOW_PLAYER
			local CustomColor
			if isPlayerMustBeShown or GUID == E.curGUID then
			else
				CustomColor = E.COLOR_GRAY
			end
			-- (CharInfo, alwaysShowLevel, forceHideLevel, CustomColor, markPlayer)
			-- local Nickname = E.func_CharInfo_NickName(CharInfo, true, false, nil, true)
			local Nickname = E.func_CharInfo_NickName(CharInfo, true, false, CustomColor, true)
			-- (CharInfo, alwaysShowServer, useShortServer, CustomColor)
			-- local Server = E.func_CharInfo_Server(CharInfo, true, false, nil)
			local Server = E.func_CharInfo_Server(CharInfo, true, false, CustomColor)
			frame.TEXT_RIGHT:SetText(Nickname .. " " .. Server)
		end
		function E.func_BACKGROUND_RIGHT(frame, GUID, CharInfo, pd)
			-- frame.BACKGROUND_RIGHT:Hide()
			local isPlayerMustBeShown = pd.CONFIG_SHOW_PLAYER
			local r, g, b, a = .1, .1, .1, .5
			if isPlayerMustBeShown or GUID == E.curGUID then
				r, g, b, a = E.func_DB_HEADER_COLOR(CharInfo)
				-- else
				--     color = E.COLOR_DARKGRAY --  E.COLOR_FACTION
			end
			-- local r, g, b, a = E.func_Hex2RGBA(color)
			-- local r, g, b, a = E.func_DB_HEADER_COLOR(CharInfo)
			frame.BACKGROUND_RIGHT:Show()
			frame.BACKGROUND_RIGHT:SetVertexColor(r, g, b, a)
		end
		----------------------------------------------------------------
		function func_InitRIGHT(frame, node)
			local frameData = node:GetData()
			frame:Show()
			local index = frameData.index
			local GUID = frameData.GUID
			local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
			if not CharInfo then return end
			local pd = CharInfo.PlayerData
			local order = Octo_ToDo_DB_Options.GUID_order
			frame.index = index
			frame.GUID = GUID
			frame.CharInfo = CharInfo
			frame.pd = pd
			frame.order = order
			do
				E.func_1_RIGHT(frame, pd)
				E.func_2_RIGHT(frame, pd)
				E.func_3_RIGHT(frame, GUID, CharInfo) -- DELETE
				E.func_4_RIGHT(frame, index, order)  -- UP
				E.func_5_RIGHT(frame, index, order)  -- DOWN
				E.func_text_RIGHT(frame, CharInfo, index, pd)
				E.func_BACKGROUND_RIGHT(frame, GUID, CharInfo, pd)
			end
			-- EventFrame.cover_RIGHT:Hide()
			if EventFrame.cover_RIGHT.index == frame.index then
				EventFrame.cover_RIGHT:SetParent(frame)
				EventFrame.cover_RIGHT:SetAllPoints(frame)
				EventFrame.cover_RIGHT:SetFrameLevel(frame:GetFrameLevel() + 2)
				EventFrame.cover_RIGHT:Show()
			end
			frame.tooltip = nil
			frame:SetScript("OnEnter", function()
					local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
					if not CharInfo then return end
					local pd = CharInfo.PlayerData
					frame.tooltip = E.func_Tooltip_Chars(CharInfo)
					local order = Octo_ToDo_DB_Options.sort_order
					if order then
						table.insert(frame.tooltip, "---")
						for _, vars in ipairs(order) do
							local optInfo = E.SORT_OPTIONS[vars]
							local data = pd[vars]
							local formatter = optInfo.formatter
							if optInfo then
								local colorLEFT = E.COLOR_WHITE
								local colorRIGHT = E.COLOR_WHITE
								if formatter then
									data = formatter(data)
								end
								if vars ~= "Name" then
									local isActiveSettings = Octo_ToDo_DB_Options.sort_order_ACTIVED[vars]
									local isReverse = Octo_ToDo_DB_Options.sort_reverse[vars]
									if isActiveSettings == false then
										colorLEFT = E.COLOR_GRAY
										colorRIGHT = E.COLOR_GRAY
									end
								else
									colorRIGHT = pd.classColorHex
								end
								table.insert(frame.tooltip, {colorLEFT..optInfo.name.."|r", data})
							end
						end
					end
					E.func_Octo_TooltipFrame_OnEnter(frame)
			end)
		end
	end
	----------------------------------------------------------------
	local func_CreateOcto_SortUI do
		local function scroll_LEFT(layout)
			local function Create_DropDownFrame_LEFT(layout, scrollContentFrame_LEFT)
				local DropDownFrame_LEFT = E.func_CreateBaseDropDown(layout, L["ADD"])
				EventFrame.DropDownFrame_LEFT = DropDownFrame_LEFT
				DropDownFrame_LEFT:SetPoint("BOTTOMLEFT", scrollContentFrame_LEFT, "TOPLEFT", 0, INDENT_CONTAINER)
				DropDownFrame_LEFT:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)
				DropDownFrame_LEFT:ddSetInitFunc(function(self, level, value)
						local menu = LibSFDropDown:GetMenu(level)
						if menu then
							menu.numButtons = 0
							menu.height = 0
							menu.width = 0
							wipe(menu.searchFrames)
						end
						local available = func_GetAvailableOptions_LEFT()
						if #available == 0 then
							local info = {
								text = E.NONE, -- Все критерии добавлены
								notCheckable = true,
								disabled = true,
								fontObject = OctoFont11,
							}
							self:ddAddButton(info, level)
						else
							local buttonList = {}
							for _, opt in ipairs(available) do
								table.insert(buttonList, {
										text = opt.displayName,
										value = opt.vars,
										func = function()
											table.insert(Octo_ToDo_DB_Options.sort_order, opt.vars)
											Octo_ToDo_DB_Options.sort_order_ACTIVED[opt.vars] = true
											E.func_CreateDataProvider_SORTUI()
											-- EventFrame:AddSortRow(opt.key)
										end,
										notCheckable = true,
										fontObject = OctoFont11,
								})
							end
							self:ddAddButton({
									list = buttonList,
									listMaxSize = 20,
							}, level)
						end
				end)
				EventFrame.hintLeft = scrollContentFrame_LEFT:CreateFontString()
				EventFrame.hintLeft:SetFontObject(OctoFont11)
				EventFrame.hintLeft:SetPoint("BOTTOM", scrollContentFrame_LEFT, "TOP", 0, 0)
				EventFrame.hintLeft:SetJustifyH("CENTER")
				EventFrame.hintLeft:SetWidth(WIDTH_DATAPROVIDER)
				return DropDownFrame_LEFT
			end
			local function Create_ResetFrame_LEFT(layout, scrollContentFrame_LEFT)
				local ResetFrame_LEFT = CreateFrame("BUTTON", "ResetFrame_LEFT", layout, "OctoBackdropPropagateTemplate")
				ResetFrame_LEFT:SetPoint("BOTTOMRIGHT", scrollContentFrame_LEFT, "TOPRIGHT", 0, INDENT_CONTAINER)
				ResetFrame_LEFT:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)
				table.insert(E.OctoTable_ColoredFrames, ResetFrame_LEFT)
				ResetFrame_LEFT.text = ResetFrame_LEFT:CreateFontString()
				ResetFrame_LEFT.text:SetFontObject(OctoFont11)
				ResetFrame_LEFT.text:SetAllPoints()
				ResetFrame_LEFT.text:SetJustifyV("MIDDLE")
				ResetFrame_LEFT.text:SetJustifyH("CENTER")
				ResetFrame_LEFT.text:SetText(L["SETTINGS_DEFAULTS"])
				ResetFrame_LEFT:SetScript("OnClick", function(selfBtn)
						if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
						ConfirmReset(function()
								wipe(Octo_ToDo_DB_Options)
								E.init_Octo_ToDo_DB_Options()
								E.func_CreateDataProvider_SORTUI()
						end)
				end)
				ResetFrame_LEFT:SetScript("OnMouseDown", function(selfBtn)
						if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
						selfBtn.text:AdjustPointsOffset(1, -1)
				end)
				ResetFrame_LEFT:SetScript("OnMouseUp", function(selfBtn)
						if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then return end
						selfBtn.text:SetAllPoints()
						selfBtn.text:AdjustPointsOffset(-1, 1)
				end)
				return ResetFrame_LEFT
			end
			scrollContentFrame_LEFT:SetPoint("TOPLEFT", layout, "TOPLEFT", INDENT_CONTAINER, -INDENT_CONTAINER-40)
			scrollContentFrame_LEFT:SetPoint("BOTTOMLEFT", layout, "BOTTOMLEFT", INDENT_CONTAINER, INDENT_CONTAINER)
			scrollContentFrame_LEFT:SetWidth(WIDTH_DATAPROVIDER)
			scrollContentFrame_LEFT.ScrollBoxLEFT = CreateFrame("FRAME", nil, scrollContentFrame_LEFT, "WowScrollBoxList,OctoRectTemplate")
			scrollContentFrame_LEFT.ScrollBoxLEFT:SetAllPoints()
			scrollContentFrame_LEFT.ScrollBarLEFT = CreateFrame("EventFrame", nil, scrollContentFrame_LEFT, "MinimalScrollBar")
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("TOPLEFT", scrollContentFrame_LEFT, "TOPRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("BOTTOMLEFT", scrollContentFrame_LEFT, "BOTTOMRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ViewLEFT = CreateScrollBoxListTreeListView(0)
			scrollContentFrame_LEFT.ViewLEFT:SetElementExtent(HEIGHT_ROW)
			scrollContentFrame_LEFT.ViewLEFT:SetElementInitializer("OctoPropagateTemplate", function(...) func_InitLEFT(...) end)
			scrollContentFrame_LEFT.ViewLEFT:RegisterCallback(scrollContentFrame_LEFT.ViewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, scrollContentFrame_LEFT)
			ScrollUtil.InitScrollBoxListWithScrollBar(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT, scrollContentFrame_LEFT.ViewLEFT)
			ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT)
			----------------------------------------------------------------
			local DropDownFrame_LEFT = Create_DropDownFrame_LEFT(layout, scrollContentFrame_LEFT)
			local ResetFrame_LEFT = Create_ResetFrame_LEFT(layout, scrollContentFrame_LEFT)
		end
		local function scroll_RIGHT(layout)
			local function Create_DropDownFrame_RIGHT(layout, scrollContentFrame_RIGHT)
				local DropDownFrame_RIGHT = E.func_CreateBaseDropDown(layout, L["OPTIONS"])
				EventFrame.DropDownFrame_RIGHT = DropDownFrame_RIGHT
				DropDownFrame_RIGHT:SetPoint("BOTTOMLEFT", scrollContentFrame_RIGHT, "TOPLEFT", 0, INDENT_CONTAINER)
				DropDownFrame_RIGHT:SetSize(WIDTH_BUTTON_BIG, HEIGHT_BUTTON)
				-- СОЗДАЁМ СЛАЙДЕРЫ ЧЕРЕЗ НАШ ТЕМПЛЕЙТ (КАК У НЕГО)
				local minLevelSlider = CreateFrame("FRAME", nil, layout, "OctoSliderFrameTemplate")
				minLevelSlider:Hide()
				minLevelSlider:setText(L["Min. Level"])
				minLevelSlider:setMinMax(1, 90)
				minLevelSlider:setStep(1)
				minLevelSlider:setMaxLetters(2)
				minLevelSlider:setOnChanged(function(slider, value)
						Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN = math.floor(value)
						E.func_CreateDataProvider_SORTUI()
				end)
				local maxLevelSlider = CreateFrame("FRAME", nil, layout, "OctoSliderFrameTemplate")
				maxLevelSlider:Hide()
				maxLevelSlider:setText(L["Max. Level"])
				maxLevelSlider:setMinMax(1, 90)
				maxLevelSlider:setStep(1)
				maxLevelSlider:setMaxLetters(2)
				maxLevelSlider:setOnChanged(function(slider, value)
						Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX = math.floor(value)
						E.func_CreateDataProvider_SORTUI()
				end)
				-- Устанавливаем начальные значения
				minLevelSlider:setValue(Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN or 1)
				maxLevelSlider:setValue(Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX or 90)
				DropDownFrame_RIGHT:ddSetInitFunc(function(self, level, value)
						local menu = LibSFDropDown:GetMenu(level)
						if menu then
							menu.numButtons = 0
							menu.height = 0
							menu.width = 0
							wipe(menu.searchFrames)
						end
						----------------------------------------------------------------
						local info = {}
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = false
						info.isNotRadio = true
						----------------------------------------------------------------
						-- Только текущий сервер
						info.text = L["Only Current Server"]
						info.checked = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER = checked
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						-- Только текущая фракция
						if E.FACTION_CURRENT == "Horde" then
							info.text = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
						elseif E.FACTION_CURRENT == "Alliance" then
							info.text = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
						else
							info.text = E.func_texturefromIcon(E.ICON_NEUTRAL)..L["Only Neutral"]
						end
						info.checked = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION = checked
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						-- Только текущий регион
						info.text = L["Only Current Region"]
						info.checked = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION = checked
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						-- Только текущий BattleTag
						info.text = L["Only Current BattleTag"]
						info.checked = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = checked
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						-- Всегда показывать текущего персонажа первым
						info.text = L["Show current character first"]
						info.checked = Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST = checked
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						self:ddAddSeparator(level)----------------------------------------------------------------
						-- Слайдер Min. Level (customFrame)
						----------------------------------------------------------------
						local minInfo = {
							customFrame = minLevelSlider,
							fixedWidth = true,
							notCheckable = true,
						}
						self:ddAddButton(minInfo, level)
						----------------------------------------------------------------
						-- Слайдер Max. Level (customFrame)
						----------------------------------------------------------------
						local maxInfo = {
							customFrame = maxLevelSlider,
							fixedWidth = true,
							notCheckable = true,
						}
						self:ddAddButton(maxInfo, level)
						----------------------------------------------------------------
						self:ddAddSeparator(level)
						----------------------------------------------------------------
						-- Затем кнопки фильтров
						local info = {}
						info.fontObject = OctoFont11
						-- Кнопки "Показать всех" и "Скрыть всех"
						info.hasArrow = nil
						info.keepShownOnClick = false
						info.notCheckable = true
						----------------------------------------------------------------
						info.text = L["Show All"] -- INTERACT_ICONS_SHOW_ALL
						info.func = function(_, _, _, checked)
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								local pd = CharInfo.PlayerData
								pd.CONFIG_SHOW_PLAYER = true
							end
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
						info.text = L["Hide All"]
						info.func = function(_, _, _, checked)
							for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
								local pd = CharInfo.PlayerData
								pd.CONFIG_SHOW_PLAYER = false
							end
							E.func_CreateDataProvider_SORTUI()
						end
						self:ddAddButton(info, level)
						----------------------------------------------------------------
				end)
				EventFrame.hintRight = scrollContentFrame_RIGHT:CreateFontString()
				EventFrame.hintRight:SetFontObject(OctoFont11)
				EventFrame.hintRight:SetPoint("BOTTOM", scrollContentFrame_RIGHT, "TOP", 0, 0)
				EventFrame.hintRight:SetJustifyH("CENTER")
				EventFrame.hintRight:SetWidth(WIDTH_DATAPROVIDER)
				return DropDownFrame_RIGHT
			end
			function E.disableButtonsUpdate()
				local color = E.COLOR_WHITE
				if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then
					color = E.COLOR_GRAY
					EventFrame.DropDownFrame_LEFT:SetEnabled(false)
					EventFrame.DropDownFrame_LEFT:SetAlpha(ALPHA_DISABLE)
					EventFrame.DropDownFrame_RIGHT:SetEnabled(false)
					EventFrame.DropDownFrame_RIGHT:SetAlpha(ALPHA_DISABLE)
					if ResetFrame_LEFT then
						ResetFrame_LEFT:SetEnabled(false)
						ResetFrame_LEFT:SetAlpha(ALPHA_DISABLE)
					end
					scrollContentFrame_LEFT:SetAlpha(ALPHA_DISABLE)
				else
					color = E.COLOR_WHITE
					EventFrame.DropDownFrame_LEFT:SetEnabled(true)
					EventFrame.DropDownFrame_LEFT:SetAlpha(ALPHA_ENABLE)
					EventFrame.DropDownFrame_RIGHT:SetEnabled(true)
					EventFrame.DropDownFrame_RIGHT:SetAlpha(ALPHA_ENABLE)
					if ResetFrame_LEFT then
						ResetFrame_LEFT:SetEnabled(true)
						ResetFrame_LEFT:SetAlpha(ALPHA_ENABLE)
					end
					scrollContentFrame_LEFT:SetAlpha(ALPHA_ENABLE)
				end
				EventFrame.DropDownFrame_LEFT.text:SetText(color..L["ADD"].."|r")
				EventFrame.DropDownFrame_RIGHT.text:SetText(color..L["OPTIONS"].."|r")
				if ResetFrame_LEFT and ResetFrame_LEFT.text then
					ResetFrame_LEFT.text:SetText(color..L["SETTINGS_DEFAULTS"].."|r")
				end
				local sorted = E.func_SortCharacters()
				if ResetFrame_RIGHT and ResetFrame_RIGHT.textUP and #sorted > 0 then
					local text = #sorted .. "/" .. E.TOTAL_CHARS
					ResetFrame_RIGHT.textUP:SetText(text)
					if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM then
						EventFrame.hintLeft:SetText("")
						EventFrame.hintRight:SetText(dragText)
					else
						EventFrame.hintLeft:SetText(dragText)
						EventFrame.hintRight:SetText("")
					end
				end
			end
			local function Create_ResetFrame_RIGHT(layout, scrollContentFrame_LEFT)
				local ResetFrame_RIGHT = E.func_CreateUtilityButton(layout, nil, width, height, tooltipFunc, nil, true, "ResetFrame_RIGHT")
				local variableKey = "CONFIG_SORTING_CUSTOM"
				local variableTbl = Octo_ToDo_DB_Options
				ResetFrame_RIGHT:SetData(variableTbl, variableKey, E.func_CreateDataProvider_SORTUI_FAST)
				ResetFrame_RIGHT:SetPoint("BOTTOMRIGHT", scrollContentFrame_LEFT, "TOPRIGHT", -INDENT_CONTAINER*6, INDENT_CONTAINER)
				ResetFrame_RIGHT.text = ResetFrame_RIGHT:CreateFontString()
				ResetFrame_RIGHT.text:SetFontObject(OctoFont11)
				ResetFrame_RIGHT.text:SetPoint("LEFT", ResetFrame_RIGHT.Icon, "RIGHT", 4, 0)
				ResetFrame_RIGHT.text:SetJustifyV("MIDDLE")
				ResetFrame_RIGHT.text:SetText(L["CUSTOM"])
				ResetFrame_RIGHT.textUP = ResetFrame_RIGHT:CreateFontString()
				ResetFrame_RIGHT.textUP:SetFontObject(OctoFont11)
				ResetFrame_RIGHT.textUP:SetPoint("BOTTOM", ResetFrame_RIGHT.Icon, "TOP", 0, 4)
				ResetFrame_RIGHT.textUP:SetJustifyV("MIDDLE")
				ResetFrame_RIGHT.textUP:SetText(L["CUSTOM"])
				ResetFrame_RIGHT:HookScript("OnClick", E.disableButtonsUpdate)
				ResetFrame_RIGHT:HookScript("OnShow", E.disableButtonsUpdate)
				-- ResetFrame_RIGHT:SetScript("OnClick", function(selfBtn)
				--         wipe(Octo_ToDo_DB_Options)
				--         E.init_Octo_ToDo_DB_Options()
				--         E.func_CreateDataProvider_SORTUI()
				-- end)
				-- ResetFrame_RIGHT:SetScript("OnMouseDown", function(selfBtn)
				--         selfBtn.text:AdjustPointsOffset(1, -1)
				-- end)
				-- ResetFrame_RIGHT:SetScript("OnMouseUp", function(selfBtn)
				--         selfBtn.text:SetAllPoints()
				--         selfBtn.text:AdjustPointsOffset(-1, 1)
				-- end)
				return ResetFrame_RIGHT
			end
			scrollContentFrame_RIGHT:SetPoint("TOPRIGHT", layout, "TOPRIGHT", -INDENT_CONTAINER-INDENT_SCROLL, -INDENT_CONTAINER-40)
			scrollContentFrame_RIGHT:SetPoint("BOTTOMRIGHT", layout, "BOTTOMRIGHT", -INDENT_CONTAINER, INDENT_CONTAINER)
			scrollContentFrame_RIGHT:SetWidth(WIDTH_DATAPROVIDER)
			scrollContentFrame_RIGHT.ScrollBoxRIGHT = CreateFrame("FRAME", nil, scrollContentFrame_RIGHT, "WowScrollBoxList,OctoRectTemplate")
			scrollContentFrame_RIGHT.ScrollBoxRIGHT:SetAllPoints()
			scrollContentFrame_RIGHT.ScrollBarRIGHT = CreateFrame("EventFrame", nil, scrollContentFrame_RIGHT, "MinimalScrollBar")
			scrollContentFrame_RIGHT.ScrollBarRIGHT:SetPoint("TOPLEFT", scrollContentFrame_RIGHT, "TOPRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_RIGHT.ScrollBarRIGHT:SetPoint("BOTTOMLEFT", scrollContentFrame_RIGHT, "BOTTOMRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_RIGHT.ViewRIGHT = CreateScrollBoxListTreeListView(0)
			scrollContentFrame_RIGHT.ViewRIGHT:SetElementExtent(HEIGHT_ROW)
			scrollContentFrame_RIGHT.ViewRIGHT:SetElementInitializer("OctoPropagateTemplate", function(...) func_InitRIGHT(...) end)
			scrollContentFrame_RIGHT.ViewRIGHT:RegisterCallback(scrollContentFrame_RIGHT.ViewRIGHT.Event.OnAcquiredFrame, func_OnAcquiredRIGHT, scrollContentFrame_RIGHT)
			ScrollUtil.InitScrollBoxListWithScrollBar(scrollContentFrame_RIGHT.ScrollBoxRIGHT, scrollContentFrame_RIGHT.ScrollBarRIGHT, scrollContentFrame_RIGHT.ViewRIGHT)
			ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollContentFrame_RIGHT.ScrollBoxRIGHT, scrollContentFrame_RIGHT.ScrollBarRIGHT)
			----------------------------------------------------------------
			local DropDownFrame_RIGHT = Create_DropDownFrame_RIGHT(layout, scrollContentFrame_RIGHT)
			local ResetFrame_RIGHT = Create_ResetFrame_RIGHT(layout, scrollContentFrame_RIGHT)
		end
		local function func_DRAG_SYSTEM_FOR_DATAPROVIDER_LEFT()
			local frame = dragFrame_LEFT
			----------------
			do
				dragFrame_LEFT:SetWidth(WIDTH_ROW)
				dragFrame_LEFT:Hide()
				E.Create_icon1frame_LEFT(dragFrame_LEFT) -- ACTIVE
				E.Create_TEXTLEFT_LEFT(dragFrame_LEFT)
				E.Create_icon3frame_LEFT(dragFrame_LEFT) -- DELETE
				E.Create_icon2frame_LEFT(dragFrame_LEFT) -- REVERSE
				E.Create_icon4frame_LEFT(dragFrame_LEFT) -- UP
				E.Create_icon5frame_LEFT(dragFrame_LEFT) -- DOWN
				E.Create_BACKGROUND_LEFT(dragFrame_LEFT)
			end
			----------------
			dragFrame_LEFT:SetAlpha(ALPHA_DRAG)
			dragFrame_LEFT:SetMovable(true)
			dragFrame_LEFT:SetMouseClickEnabled(false)
			dragFrame_LEFT:SetMouseMotionEnabled(true)
			dragFrame_LEFT:SetSize(WIDTH_ROW, HEIGHT_ROW)
			-- dragFrame_LEFT:SetFrameStrata("TOOLTIP")
			-- dragFrame_LEFT:SetFrameLevel(500)
			----------------
			-- SEPARATOR
			EventFrame.separator_LEFT = CreateFrame("FRAME", nil, scrollContentFrame_LEFT)
			EventFrame.separator_LEFT:SetHeight(10)
			EventFrame.separator_LEFT:SetWidth(WIDTH_ROW)
			EventFrame.separator_LEFT:Hide()
			EventFrame.separator_LEFT.bg = EventFrame.separator_LEFT:CreateTexture(nil, "BACKGROUND")
			EventFrame.separator_LEFT.bg:SetPoint("TOPLEFT", 0, -2)
			EventFrame.separator_LEFT.bg:SetPoint("BOTTOMRIGHT", 0, -2)
			E.func_SetupTextureToFrame(EventFrame.separator_LEFT.bg, "Interface\\Buttons\\UI-Silver-Button-Highlight")
			EventFrame.separator_LEFT.bg:SetBlendMode("ADD")
			-- COVER
			EventFrame.cover_LEFT = CreateFrame("FRAME")
			EventFrame.cover_LEFT:Hide()
			EventFrame.cover_LEFT.bg = EventFrame.cover_LEFT:CreateTexture(nil, "BACKGROUND")
			EventFrame.cover_LEFT.bg:SetAllPoints()
			EventFrame.cover_LEFT.bg:SetColorTexture(0.2, 0.2, 0.2, 0.6)
			-- EventFrame.cover_LEFT:SetScript("OnHide", self.Hide)
			EventFrame.cover_LEFT:SetScript("OnHide", function() EventFrame.cover_LEFT:Hide() end)
			-- ONUPDATE FUNCTION
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
			-- EVENTS FOR GLOBAL_MOUSE_UP
			dragFrame_LEFT:SetScript("OnShow", function(btn)
					btn:RegisterEvent("GLOBAL_MOUSE_UP")
			end)
			dragFrame_LEFT:SetScript("OnHide", function(btn)
					btn:UnregisterEvent("GLOBAL_MOUSE_UP")
					btn:SetScript("OnUpdate", nil)
			end)
			dragFrame_LEFT:SetScript("OnEvent", function(btn)
					btn:SetScript("OnUpdate", nil)
					btn:Hide()
					EventFrame.cover_LEFT.index = nil
					EventFrame.cover_LEFT:Hide()
					-- local id = EventFrame.separator_LEFT.id
					local newID = EventFrame.separator_LEFT.id
					if newID then
						local id = EventFrame.dragSourceIndex
						EventFrame.separator_LEFT:Hide()
						if id then
							local order = Octo_ToDo_DB_Options.sort_order
							if newID > id then
								newID = newID - 1
							end
							table.insert(order, newID, table.remove(order, id))
							-- table.remove(order, oldIndex)
							-- table.insert(order, id, sourceKey)
							E.func_CreateDataProvider_SORTUI()
						end
					end
					-- EventFrame.dragSourceIndex = nil
			end)
		end
		local function func_DRAG_SYSTEM_FOR_DATAPROVIDER_RIGHT()
			local frame = dragFrame_RIGHT
			----------------
			do
				dragFrame_RIGHT:SetWidth(WIDTH_ROW)
				dragFrame_RIGHT:Hide()
				E.Create_icon1frame_RIGHT(dragFrame_RIGHT) -- ACTIVE
				E.Create_icon2frame_RIGHT(dragFrame_RIGHT) -- SPEC ICON
				E.Create_TEXT_RIGHT(dragFrame_RIGHT) -- TEXT_RIGHT
				E.Create_icon3frame_RIGHT(dragFrame_RIGHT) -- DELETE
				E.Create_icon4frame_RIGHT(dragFrame_RIGHT) -- UP
				E.Create_icon5frame_RIGHT(dragFrame_RIGHT) -- DOWN
				E.Create_BACKGROUND_RIGHT(dragFrame_RIGHT)
			end
			----------------
			dragFrame_RIGHT:SetAlpha(ALPHA_DRAG)
			dragFrame_RIGHT:SetMovable(true)
			dragFrame_RIGHT:SetMouseClickEnabled(false)
			dragFrame_RIGHT:SetMouseMotionEnabled(true)
			dragFrame_RIGHT:SetSize(WIDTH_ROW, HEIGHT_ROW)
			-- SEPARATOR для правой стороны
			EventFrame.separator_RIGHT = CreateFrame("FRAME", nil, scrollContentFrame_RIGHT)
			EventFrame.separator_RIGHT:SetHeight(10)
			EventFrame.separator_RIGHT:SetWidth(WIDTH_ROW)
			EventFrame.separator_RIGHT:Hide()
			EventFrame.separator_RIGHT.bg = EventFrame.separator_RIGHT:CreateTexture(nil, "BACKGROUND")
			EventFrame.separator_RIGHT.bg:SetPoint("TOPLEFT", 0, -2)
			EventFrame.separator_RIGHT.bg:SetPoint("BOTTOMRIGHT", 0, -2)
			E.func_SetupTextureToFrame(EventFrame.separator_RIGHT.bg, "Interface\\Buttons\\UI-Silver-Button-Highlight")
			EventFrame.separator_RIGHT.bg:SetBlendMode("ADD")
			-- COVER для правой стороны
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
			dragFrame_RIGHT:SetScript("OnShow", function(btn)
					btn:RegisterEvent("GLOBAL_MOUSE_UP")
			end)
			dragFrame_RIGHT:SetScript("OnHide", function(btn)
					btn:UnregisterEvent("GLOBAL_MOUSE_UP")
					btn:SetScript("OnUpdate", nil)
			end)
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
							local order = Octo_ToDo_DB_Options.GUID_order
							if newID > id then
								newID = newID - 1
							end
							table.insert(order, newID, table.remove(order, id))
							E.func_CreateDataProvider_SORTUI_FAST()
						end
					end
			end)
		end
		function func_CreateOcto_SortUI()
			layout:SetPoint("TOPLEFT", INDENT_CONTAINER, -INDENT_CONTAINER*2)
			layout:SetPoint("BOTTOMRIGHT", -INDENT_CONTAINER, INDENT_CONTAINER)
			----------------------------------------------------------------
			-- LEFT --------------------------------------------------------
			----------------------------------------------------------------
			scroll_LEFT(layout)
			func_DRAG_SYSTEM_FOR_DATAPROVIDER_LEFT()
			func_DRAG_SYSTEM_FOR_DATAPROVIDER_RIGHT()
			----------------------------------------------------------------
			-- RIGHT -------------------------------------------------------
			----------------------------------------------------------------
			scroll_RIGHT(layout)
			----------------------------------------------------------------
		end
	end
	----------------------------------------------------------------
	-- func_CreateDataProvider_RIGHT для списка персонажей ---------
	----------------------------------------------------------------
	local function func_CreateDataProvider_RIGHT()
		local DataProvider = CreateTreeDataProvider()
		local totalLines = 0
		if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM and Octo_ToDo_DB_Options.GUID_order then
			-- Кастомная сортировка
			totalLines = #Octo_ToDo_DB_Options.GUID_order
			for index, GUID in ipairs(Octo_ToDo_DB_Options.GUID_order) do
				local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
				-- if CharInfo and CharInfo.PlayerData.CONFIG_SHOW_PLAYER then
				if CharInfo then
					DataProvider:Insert({
							index = index,
							GUID = GUID
					})
				end
			end
		else
			-- Обычная сортировка
			local sortedCharacters, unsorted = E.func_SortCharacters()
			for index, CharInfo in ipairs(sortedCharacters) do
				totalLines = totalLines + 1
				DataProvider:Insert({index = totalLines, GUID = CharInfo.PlayerData.GUID})
			end
			for index, CharInfo in ipairs(unsorted) do
				totalLines = totalLines + 1
				DataProvider:Insert({index = totalLines, GUID = CharInfo.PlayerData.GUID})
			end
		end
		if totalLines == 0 then
			DataProvider:Insert({GUID = E.curGUID})
		end
		EventFrame:UpdateDataProvider_RIGHT(DataProvider, totalLines)
	end
	----------------------------------------------------------------
	function EventFrame:UpdateDataProvider_RIGHT(DataProvider, totalLines)
		scrollContentFrame_RIGHT.ViewRIGHT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		local visibleLines = math.min(20, totalLines)
		local height = visibleLines * HEIGHT_ROW + INDENT_ROW * 2
		scrollContentFrame_RIGHT.ScrollBoxRIGHT:SetHeight(height)
	end
	----------------------------------------------------------------
	--func_CreateDataProvider_LEFT для списка критерий -------------
	----------------------------------------------------------------
	local function func_CreateDataProvider_LEFT()
		local DataProvider = CreateTreeDataProvider()
		local order = Octo_ToDo_DB_Options.sort_order
		if not order then return end
		local totalLines = 0
		local maxDisplay = 20
		for index, key in ipairs(order) do
			totalLines = totalLines + 1
			local rowData = {
				index = index,
				key = key,
			}
			DataProvider:Insert(rowData) -- local node = DataProvide = DataProvider:Insert(rowData)
		end
		EventFrame:UpdateDataProvider_LEFT(DataProvider, totalLines)
	end
	----------------------------------------------------------------
	function EventFrame:UpdateDataProvider_LEFT(DataProvider, totalLines)
		scrollContentFrame_LEFT.ViewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		local visibleLines = math.min(20, totalLines)
		local height = visibleLines * HEIGHT_ROW + INDENT_ROW * 2
		scrollContentFrame_LEFT.ScrollBoxLEFT:SetHeight(height)
	end
	----------------------------------------------------------------
	function E.func_CreateDataProvider_SORTUI()
		func_CreateDataProvider_RIGHT()
		func_CreateDataProvider_LEFT()
		E.disableButtonsUpdate()
		-- E.func_SpamBlock(func_CreateDataProvider_RIGHT, false, 1)
		-- E.func_SpamBlock(func_CreateDataProvider_LEFT, false, 1)
		-- E.func_SpamBlock(E.disableButtonsUpdate, false, 1)
	end
	function E.func_CreateDataProvider_SORTUI_FAST()
		func_CreateDataProvider_RIGHT()
		func_CreateDataProvider_LEFT()
		E.disableButtonsUpdate()
	end
	----------------------------------------------------------------
	func_CreateOcto_SortUI()
	-- E.func_CreateDataProvider_SORTUI()
end