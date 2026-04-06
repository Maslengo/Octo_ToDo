local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local Octo_DebugFrame = CreateFrame("BUTTON", "Octo_DebugFrame", UIParent, "OctoBackdropTemplate") -- SettingsFrameTemplate OctoBackdropTemplate OCTOEditBoxTemplate
-- "DialogBoxFrame,OctoBackdropTemplate"
-- "OCTOEditBoxTemplate,OctoBackdropTemplate"
Octo_DebugFrame:Hide()
-- Octo_DebugFrameButton:Hide()
Octo_editFrame_scrollFrame =
CreateFrame("Frame", "Octo_editFrame_scrollFrame", Octo_DebugFrame, "ScrollingEditBoxTemplate") -- "OctoBackdropTemplate,ScrollingEditBoxTemplate"
-- /run Octo_DebugFrameButton:Hide()
----------------------------------------------------------------
-- Минимальные размеры фрейма (нельзя сделать меньше)
local MIN_WIDTH, MIN_HEIGHT = 1920 * .2, 1080 * .2 -- 400, 300 -- Минимальная ширина, высота
local MAX_WIDTH, MAX_HEIGHT = 1920 * .7, 1080 * .7 -- Максимальная ширина, высота
local INDENT = 20
local BUTTON_WIDTH, BUTTON_HEIGHT = 80, 20
-- Ширина, высота
----------------------------------------------------------------
local LibStub = LibStub
local L = E.L
local LibIndentation = LibStub("LibIndentation-1.0")
----------------------------------------------------------------
-- if not Octo_DevTool_DB then return end
function E.func_createColorScheme(themeName)
	local theme = E.editorThemes[themeName] or E.editorThemes["Twilight"]
	return {
		-- Основные токены
		[LibIndentation.tokens.TOKEN_UNKNOWN] = theme["Error"],
		[LibIndentation.tokens.TOKEN_NUMBER] = theme["Number"],
		[LibIndentation.tokens.TOKEN_LINEBREAK] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_WHITESPACE] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_IDENTIFIER] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_ASSIGNMENT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_EQUALITY] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_MINUS] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COMMENT_SHORT] = theme["Comment"],
		[LibIndentation.tokens.TOKEN_COMMENT_LONG] = theme["Comment"],
		[LibIndentation.tokens.TOKEN_STRING] = theme["String"],
		[LibIndentation.tokens.TOKEN_LEFTBRACKET] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_PERIOD] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_DOUBLEPERIOD] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_TRIPLEPERIOD] = theme["Special"],
		[LibIndentation.tokens.TOKEN_LTE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_LT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_GTE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_GT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_NOTEQUAL] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COMMA] = theme["Special"],
		[LibIndentation.tokens.TOKEN_SEMICOLON] = theme["Special"],
		[LibIndentation.tokens.TOKEN_COLON] = theme["Special"],
		[LibIndentation.tokens.TOKEN_LEFTPAREN] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_RIGHTPAREN] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_PLUS] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_SLASH] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_LEFTWING] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_RIGHTWING] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_CIRCUMFLEX] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_ASTERISK] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_RIGHTBRACKET] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_KEYWORD] = theme["Keyword"],
		[LibIndentation.tokens.TOKEN_SPECIAL] = theme["Special"],
		[LibIndentation.tokens.TOKEN_VERTICAL] = theme["Special"],
		[LibIndentation.tokens.TOKEN_TILDE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COLORCODE_START] = theme["Special"],
		[LibIndentation.tokens.TOKEN_COLORCODE_STOP] = theme["Special"],
		[LibIndentation.tokens.TOKEN_HASH] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_PERCENT] = theme["Operator"],
		-- Дополнительные кастомные правила
		["..."] = theme["Special"], -- тройная точка
		[" .. "] = theme["Operator"], -- конкатенация строк
		-- WoW-специфичные токены
		["|c"] = theme["Special"], -- начало цветового кода
		["|r"] = theme["Special"], -- конец цветового кода
		-- Ключевые слова Lua
		["and"] = theme["Keyword"],
		["break"] = theme["Keyword"],
		["do"] = theme["Keyword"],
		["else"] = theme["Keyword"],
		["elseif"] = theme["Keyword"],
		["end"] = theme["Keyword"],
		["false"] = theme["Constant"],
		["for"] = theme["Keyword"],
		["function"] = theme["Keyword"],
		["if"] = theme["Keyword"],
		["in"] = theme["Keyword"],
		["local"] = theme["Keyword"],
		["nil"] = theme["Constant"],
		["not"] = theme["Keyword"],
		["or"] = theme["Keyword"],
		["repeat"] = theme["Keyword"],
		["return"] = theme["Keyword"],
		["then"] = theme["Keyword"],
		["true"] = theme["Constant"],
		["until"] = theme["Keyword"],
		["while"] = theme["Keyword"],
		[0] = "|r" -- сброс цвета
	}
end
------------------------------------------------------------
------------------------------------------------------------
-- Константы цвета
------------------------------------------------------------
local function CreateMyAddonEditFrameTemplate()
	-- Octo_DebugFrame:ClearAllPoints()
	Octo_DebugFrame:SetPoint("CENTER")
	local width = E.PHYSICAL_SCREEN_WIDTH / 2
	local height = E.PHYSICAL_SCREEN_HEIGHT / 2
	Octo_DebugFrame:SetSize(width, height)
	Octo_DebugFrame:SetResizable(true)
	Octo_DebugFrame:SetDontSavePosition(true)
	Octo_DebugFrame:SetClampedToScreen(true)
	Octo_DebugFrame:EnableMouse(true)
	Octo_DebugFrame:SetMovable(true)
	Octo_DebugFrame:RegisterForClicks("RightButtonUp")
	Octo_DebugFrame:SetScript("OnClick", Octo_DebugFrame.Hide)
	Octo_DebugFrame.scrollBar = CreateFrame("EventFrame", nil, Octo_DebugFrame, "MinimalScrollBar")
	Octo_DebugFrame.scrollBar:SetPoint("TOPRIGHT", 14, 0)
	Octo_DebugFrame.scrollBar:SetPoint("BOTTOMRIGHT", 14, 0)
	----------------------------------------------------------------
	-- EditBox - это непосредственно поле ввода текста, куда пользователь пишет.
	----------------------------------------------------------------
	Octo_editFrame_scrollFrame:SetPoint("TOPLEFT", INDENT, -INDENT)
	Octo_editFrame_scrollFrame:SetPoint("BOTTOMRIGHT", -INDENT, INDENT * 3)
	Octo_editFrame_scrollFrame.tex = Octo_editFrame_scrollFrame:CreateTexture()
	Octo_editFrame_scrollFrame.tex:SetAllPoints(Octo_editFrame_scrollFrame)
	-- local r, g, b, a = E.func_Hex2RGBA("|cff1A1A26")
	-- Octo_editFrame_scrollFrame.tex:SetColorTexture(.1, .1, .14, 1)
	Octo_editFrame_scrollFrame.tex:SetColorTexture(0, 0, 0, 1)
	----------------------------------------------------------------
	-- Import
	----------------------------------------------------------------
	Octo_DebugFrame.Import = CreateFrame("Button", nil, Octo_DebugFrame, "UIPanelButtonTemplate")
	Octo_DebugFrame.Import:SetPoint("BOTTOMRIGHT", -(INDENT * 2 + BUTTON_WIDTH), INDENT)
	Octo_DebugFrame.Import:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	Octo_DebugFrame.Import:SetText(L["IMPORT"])
	Octo_DebugFrame.Import:SetScript(
		"OnClick",
		function(self, button, down)
			local str = Octo_editFrame_scrollFrame:GetText()

			if not str or str == "" then
				E.func_PrintMessage(E.COLOR_RED .. "No data to import|r")
				return
			end

			local data = E.getDataFromString(str, true)
			if data then
				E.func_workWitchMyTable(data)
				Octo_DebugFrame:Hide()
			end
		end
	)
	Octo_DebugFrame.Import:RegisterForClicks("AnyUp") -- "AnyDown",
	----------------------------------------------------------------
	-- closeButton
	----------------------------------------------------------------
	Octo_DebugFrame.closeButton = CreateFrame("Button", nil, Octo_DebugFrame, "UIPanelButtonTemplate")
	Octo_DebugFrame.closeButton:SetPoint("BOTTOMRIGHT", -INDENT, INDENT)
	Octo_DebugFrame.closeButton:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	Octo_DebugFrame.closeButton:SetText(L["CLOSE"])
	Octo_DebugFrame.closeButton:SetScript(
		"OnClick",
		function(self, button, down)
			-- E.func_PrintMessage("Pressed", button, down and "down" or "up")
			Octo_DebugFrame:Hide()
		end
	)
	Octo_DebugFrame.closeButton:RegisterForClicks("AnyUp") -- "AnyDown",
	----------------------------------------------------------------
	-- Кнопка изменения размера
	----------------------------------------------------------------
	Octo_DebugFrame.resize = CreateFrame("BUTTON", nil, Octo_DebugFrame)
	Octo_DebugFrame.resize:SetSize(16, 16)
	Octo_DebugFrame.resize:SetPoint("BOTTOMRIGHT", 0, 0)
	Octo_DebugFrame.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	Octo_DebugFrame.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	Octo_DebugFrame.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	Octo_DebugFrame.resize:RegisterForDrag("LeftButton")
	----------------------------------------------------------------
	-- LINE
	----------------------------------------------------------------
	Octo_DebugFrame.lineText = Octo_DebugFrame:CreateFontString()
	Octo_DebugFrame.lineText:SetFontObject(OctoFont11)
	Octo_DebugFrame.lineText:SetPoint("BOTTOMLEFT", 20, 20)
	Octo_DebugFrame.lineText:SetText(L["Line"])
	-- HZ
	-- Octo_DebugFrame.HZ = CreateFrame("Editbox", nil, Octo_DebugFrame, "InputBoxTemplate")
	-- Octo_DebugFrame.HZ:Hide()
	----------------------------------------------------------------
	-- Настройка скроллинга
	-- ScrollBox - это контейнер, который управляет прокруткой содержимого (в данном случае EditBox'а).
	----------------------------------------------------------------
	local scrollBox = Octo_editFrame_scrollFrame:GetScrollBox()
	scrollBox:SetAllPoints(Octo_editFrame_scrollFrame)
	ScrollUtil.RegisterScrollBoxWithScrollBar(scrollBox, Octo_DebugFrame.scrollBar)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollBox, Octo_DebugFrame.scrollBar)
	----------------------------------------------------------------
	-- Настройка edit box
	local editBox = Octo_editFrame_scrollFrame:GetEditBox()
	editBox:HookScript(
		"OnEnterPressed",
		function(self)
			self:Insert("\n")
		end
	)
	editBox:HookScript(
		"OnEscapePressed",
		function(self)
			self:ClearFocus()
		end
	)
	if Octo_DevTool_DB then
		editBox:SetFont(E.Octo_font, Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_FONTSIZE, "")
	else
		editBox:SetFont(E.Octo_font, 11, "")
	end
	editBox:HookScript(
		"OnCursorChanged",
		function(self)
			-- local text = Octo_DebugFrame.HZ.GetText(editBox) -- или Octo_DebugFrame.HZ:GetText()
			-- local text = Octo_editFrame_scrollFrame:GetText()
			local text = self:GetText()
			local pos = self:GetCursorPosition()
			local next = -1
			local line = 0
			-- Подсчет общего количества строк
			local totalLines = 1 -- Минимум 1 строка
			for _ in text:gmatch("\n") do
				totalLines = totalLines + 1
			end
			-- Определение текущей строки
			while next and pos >= next do
				next = text:find("[\n]", next + 1)
				line = line + 1
			end
			Octo_DebugFrame.lineText:SetText(L["Line"] .. ": " .. line .. "/" .. totalLines)
		end
	)
	-- Обработчики перемещения фрейма
	Octo_DebugFrame:SetScript(
		"OnMouseDown",
		function(_, button)
			if button == "LeftButton" then
				-- Octo_DebugFrame:SetAlpha(.8) -- ТУТ
				Octo_DebugFrame:StartMoving()
			end
		end
	)
	Octo_DebugFrame:SetScript(
		"OnMouseUp",
		function(_, button)
			if button == "LeftButton" then
				-- Octo_DebugFrame:SetAlpha(1) -- ТУТ
				Octo_DebugFrame:StopMovingOrSizing()
			end
		end
	)
	-- Обработчик нажатия клавиш
	Octo_DebugFrame:SetScript(
		"OnKeyDown",
		function(self, key)
			if not InCombatLockdown() then
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
			end
		end
	)
	-- Переменная для отслеживания, изменяем ли мы размер
	local isResizing = false
	Octo_DebugFrame.resize:SetScript(
		"OnDragStart",
		function(self)
			isResizing = true
			self:GetParent():StartSizing("BOTTOMRIGHT", true)
			-- self:GetParent():SetAlpha(.8) -- ТУТ
		end
	)
	Octo_DebugFrame.resize:SetScript(
		"OnDragStop",
		function(self)
			isResizing = false
			self:GetParent():StopMovingOrSizing()
			-- self:GetParent():SetAlpha(1) -- ТУТ
		end
	)
	-- Проверка размера в реальном времени (OnUpdate)
	Octo_DebugFrame:SetScript(
		"OnUpdate",
		function(self, elapsed)
			if isResizing then
				local w, h = self:GetSize()
				self:SetSize(math.max(MIN_WIDTH, math.min(MAX_WIDTH, w)), math.max(MIN_HEIGHT, math.min(MAX_HEIGHT, h)))
			end
		end
	)
end
-- Функция для кнопки вызова фрейма
function E.ShowImportExportFrame(defaultText)
	if SettingsPanel:IsVisible() then
		HideUIPanel(SettingsPanel)
	end
	if GameMenuFrame:IsVisible() then
		HideUIPanel(GameMenuFrame)
	end
	-- opde()
	Octo_editFrame_scrollFrame:SetText(defaultText or "")
	Octo_DebugFrame:Show()
	Octo_editFrame_scrollFrame:SetFocus()
	-- Octo_editFrame_scrollFrame:HighlightText()
	-- oprint(defaultText or "")
	-- OctoImportExportFrame.EditBox:SetText(defaultText or "")
	-- OctoImportExportFrame:Show()
	-- OctoImportExportFrame.EditBox:SetFocus()
	-- OctoImportExportFrame.EditBox:HighlightText()
end
-- E.ShowImportExportFrame(defaultText)  -- можно передать текст для экспорта
------------------------------------------------------------
------------------------------------------------------------
-- local editBox = Octo_editFrame_scrollFrame

----------------------------------------------------------------
-- Transmission ------------------------------------------------
----------------------------------------------------------------
-- /run opde(E.getStringFromData(Octo_ToDo_DB_Levels, true))
-- /run opde(E.getStringFromData(Octo_ToDo_DB_Levels, false))
-- "awAA"

-- /run opde(E.getDataFromString("awAA"))
----------------------------------------------------------------
-- DO ----------------------------------------------------------
----------------------------------------------------------------
do
	----------------------------------------------------------------
	local compressedCache, encodeForWoWAddonChannel, decodeForWoWAddonChannel

	----------------------------------------------------------------
	function encodeForWoWAddonChannel(str)
		local encode_translate = {
			["\000"] = "\001\002",
			["\001"] = "\001\003"
		}
		function encodeForWoWAddonChannel(str)
			return str:gsub("[%z\001]", encode_translate)
		end
		return encodeForWoWAddonChannel(str)
	end
	----------------------------------------------------------------
	function decodeForWoWAddonChannel(str)
		local decode_translate = {
			["\001\002"] = "\000",
			["\001\003"] = "\001"
		}
		function decodeForWoWAddonChannel(str)
			return str:gsub("\001[\002\003]", decode_translate)
		end
		return decodeForWoWAddonChannel(str)
	end
	----------------------------------------------------------------
	function E.getStringFromData(data, forPrint)
		local serialized = C_EncodingUtil.SerializeCBOR(data)
		local serverTime, compressed = GetServerTime()
		compressedCache = compressedCache or {}

		-- get from / add to cache
		if compressedCache[serialized] then
			compressed = compressedCache[serialized].compressed
			compressedCache[serialized].lastAccess = serverTime
		else
			compressed =
			C_EncodingUtil.CompressString(
				serialized,
				Enum.CompressionMethod.Deflate,
				Enum.CompressionLevel.OptimizeForSize
			)
			compressedCache[serialized] = {
				compressed = compressed,
				lastAccess = serverTime
			}
		end

		-- remove cache after 5 min
		local expiredTime = serverTime - 300
		for k, v in next, compressedCache do
			if v.lastAccess < expiredTime then
				compressedCache[k] = nil
			end
		end

		if forPrint then
			return C_EncodingUtil.EncodeBase64(compressed, Enum.Base64Variant.StandardUrlSafe)
		else
			return encodeForWoWAddonChannel(compressed)
		end
	end
	----------------------------------------------------------------
	function E.getDataFromString(str, fromPrint)
		local decoded, success, decompressed, data
		if fromPrint then
			decoded = C_EncodingUtil.DecodeBase64(str, Enum.Base64Variant.StandardUrlSafe)
		else
			decoded = decodeForWoWAddonChannel(str)
		end
		success, decompressed = pcall(C_EncodingUtil.DecompressString, decoded, Enum.CompressionMethod.Deflate)
		if not success then
			return
		end
		success, data = pcall(C_EncodingUtil.DeserializeCBOR, decompressed)
		if success then
			return data
		end
	end
	----------------------------------------------------------------
	-- func_workWitchMyTable
	----------------------------------------------------------------
	function E.func_workWitchMyTable(tbl)
		Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
		-- opde(tbl)
		local count = 0
		local success = false
		for GUID, CharInfo in next, (tbl) do
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			if pd and cm and pd.Name then
				count = count + 1
				success = true
				Octo_ToDo_DB_Levels[GUID] = CharInfo
			end
		end
		if success then
			E.func_PrintMessage(E.COLOR_GREEN .. "Import successful, chars:|r", count)
		else
			E.func_PrintMessage(E.COLOR_YELLOW .. "Import failed:|r")
		end
	end
end
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
-- Функция для форматированного вывода таблиц
local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do
		indentStr = indentStr .. " "
	end
	for k, v in next, (msg) do
		k =
		(type(k) == "number" and "[" .. k .. "]" or type(k) == "string" and '["' .. k .. '"]' or tostringall(k)) ..
		" ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			str = ("%s%s%s {\n"):format(str, indentStr, k)
			str = str .. dumpEdit(indent + 1, v, tables)
			str = ("%s%s},\n"):format(str, indentStr)
		else
			local vtype = type(v)
			v =
			vtype == "string" and '"' .. v:gsub('["\\]', "\\%1") .. '"' or vtype == "number" and v or
			'"' .. tostringall(v) .. '"'
			str = ("%s%s%s %s,\n"):format(str, indentStr, k, v)
		end
	end
	if indent == 0 then
		LibIndentation.enable(
			Octo_editFrame_scrollFrame:GetEditBox(),
			E.func_createColorScheme(Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_EDITORTHEME or "Twilight"),
			Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_TABSPACES
		) -- 4 - ширина табуляции в пробелах
		Octo_editFrame_scrollFrame:SetText(str)
		LibIndentation.indentEditbox(Octo_editFrame_scrollFrame:GetEditBox())
		Octo_DebugFrame:Show()
	else
		return str
	end
end
-- Обработчик сообщений для вывода в чат
local oprintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E.func_Gradient(GlobalAddonName .. ": ")
		for i = 1, indent do
			indentStr = indentStr .. " "
		end
		for k, v in next, (msg) do
			k = "[" .. tostringall(k) .. "] ="
			if type(v) == "table" then
				if allChildren or indent + 1 == 1 then
					frame:AddMessage(strjoin(" ", indentStr, k, "table: {"))
					sendMessage(frame, indent + 1, v, allChildren)
					frame:AddMessage(strjoin(" ", indentStr, " }"))
				else
					frame:AddMessage(strjoin(" ", indentStr, k, "table"))
				end
			else
				frame:AddMessage(strjoin(" ", indentStr, k, tostringall(v)))
			end
		end
	end
	local message = strjoin(" ", E.func_Gradient(GlobalAddonName .. ": "), tostringall(...))
	local mFrame = DEFAULT_CHAT_FRAME
	local i = 1
	repeat
		local frame = _G["ChatFrame" .. i]
		if frame and frame:IsShown() then
			mFrame = frame
			break
		end
		i = i + 1
	until not frame
	mFrame:AddMessage(message)
	local first = select(1, ...)
	if first == "dump" then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		sendMessage(mFrame, 0, msg)
	end
	if first == dumpe then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		dumpEdit(0, msg)
	end
end
-- Безопасный вызов обработчика
local function oprint_inner(...)
	forceinsecure()
	local ok, err = pcall(oprintHandler, ...)
	if not ok then
		geterrorhandler()(err)
	end
end
-- Глобальные команды для дампа
dump = "dump"
dumpe = "dumpe"
-- Функции для удобного вызова
if not oprint then
	function oprint(...)
		securecall(pcall, oprint_inner, ...)
	end
end
if not opd then
	function opd(...)
		oprint(dump, ...)
	end
end
if not opde then
	function opde(...)
		oprint(dumpe, ...)
	end
end
-- Регистрация slash-команды /oprint
SLASH_OPRINT1 = "/oprint"
SlashCmdList["OPRINT"] = function(msg)
	-- local f, err = loadstring("return " .. msg)
	local f, err = load("return " .. msg)
	if err then
		oprint(err:gsub('"return ', '"'))
		return
	end
	local status, value = pcall(f)
	if status then
		oprint(dumpe, value)
	else
		oprint(value:gsub('"return ', '"'))
	end
end
-- Дополнительные slash-команды
local slashCommands = {
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color .. "GSEARCH:|r " .. msg)
			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str .. color .. i .. "|r - " .. n .. "\n"
				end
			end
			Octo_editFrame_scrollFrame:SetText(str)
			Octo_DebugFrame:Show()
		end
	}
}
-- Регистрация всех slash-команд
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_" .. name .. i] = cmd
	end
end
----------------------------------------------------------------
-- Регистрация событий -----------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN"
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	CreateMyAddonEditFrameTemplate()
	E.editFrame = Octo_DebugFrame
	E.editBox = Octo_editFrame_scrollFrame
	E.func_Create_DDframe_editFrame(Octo_DebugFrame, E.COLOR_BLUE, nil)
end
----------------------------------------------------------------
E.Octo_DevTool_DB_DATA = "vb0JfBzFlT_u0ZzdM8IQIKgNGHHbYBvN6DaGIOsc67QkH5yirWlJg0czYg4bEQjiMme4w52ADcTkvyzrGBt8YZIlkGOzySib3U1IIISQLAnJhiSYLOEH_L9Vc3VX17RKxlI-eVhTU1NV7_tevaO6umpLf09EHdfii_01_urFFctr62tqayq2tHU29HU0d7V2P9vWmIrHtejg-G7nNxTvgc3to-oVK1NqNBlOjislHYrz4wnF-7GhuCyk-GzGkgWKz2kqkUwlpcaS4xTfEROK72hj6YTiIqWnghbi72MM39oUn39Csd2EL-tBDVvaLs99o692lOJrNrY6X_EFjSVXKL5ONLEStAp0vpF1-zuK72JzkYqaGigMGgVdDkoZ261VfOPGkgsU39WmOtcaShyK70a24BamwHYPOvsK6CEWkq-icDPoG6B_Bu1kxPgzxbcbxS-Cvg16pYCaR1_Ro_j-E1__HPQ66PdFwJ2r-P6Er_8CMuqLrNgen1BKjVJWbO8rpUcY2f-eUno0KkLEpQs3G-VWuhiFEHEpxFt6DqgZZJRcieLaaiiYN6d07-NK6Uq21nPGgRx5s-LaCY16AQQ4XHtZDXH9G0p_DJoE_QcIaLh-AQIarl-DfgP6H9DvJxS3F1QKmgs6EnR0Aa2ysHF09tLzFPexqHOqscduxX26qQT8u88CAQN3JagaVAsCHu6zQcDE3biZ00Ezr7AVtYOgdhC03d0Ngsa7ofHuCwsjlo1idF-MrwdAUHf3ICjGaJw7gcIUaCNoHPRF0NWga0DXgq4H3Qi6DfRl0J2gu0H3gqDC7gdAD4EeAUF73Y-BoMHuJ0BPgbaCoM3ufwJBo93_Avom6DkQZOfeC4I6u_8dBGm5IS03pOWG7rohMTck5v4VCFJzQ2ru324uSEdR3BCimwjxXRB02f1nEPTZ_TfQAdDfQR-CPgLBALo_nVA8JSAXSAYdBvoc6POgeaD5oJNAp4HOAC0xirVH8QRQWgNaCjoXtJxB1NOCwhWgLlAvaDXoAkMlu-K5hC0YMhS4FM9l-FkUFAdtAF3JGBHPl9iC61BrE-hW0B0gWBnP_aCHQV8DbQF9HfT_gbaDnge9CvoB6Eegn4D-C_RaAWLF9nvF8wbz-S39598ont8ZP0vAVQKuEnCVgKsEXCXgKgFXCbhKwFVaAgKSEpCUgKQEJKXlIIAnATwJ4EkATwJ40gWgS0DrCv0cpUjARwI-EvCRgI90JehLIKAgAQEJCEhAQAICEhCQgIAEBCQgIAEB6VkQUJCAgrQHtB_0ryAgIgERCYhIQEQCItJroDdAfwD9L-ivoA9A_wB9MqHI0CgZGiWDcxmcy-BcBufyfKPdcqcVGSDIAEEGCDJAkAGCDBBkgCADBBkgyABBBggyQJABggwAZAAgrwMNgcC6DNZlsC6DdRmsy2BdBusyFEAG-zLYl8G-DPZlsC6DdRmsy2BdBusyWJfBugzWZbAug3UZrMtgXQbrMliXwbr8GmOM5t-AwrdAvwMBDxk4yMBB_oQNErxAxHsa8_MHMR7vGbzCJRyr5w3wCmt4hUt5hQDU21swjk7DCBXFC-3yAlwvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9QLcEvDtBbhegOsFuF4ybuiWFwB7AbAXAHsBsBcAewGwF-CWvMf4Re-_Ggo-p5T8lfWp3h8x3tgLaXjfMgUx3t-Zi_5QYBefTV__r_XXf2UavFTxfsAUlSnefzBxwV2K9xNTYFliChpdphLZVHIYYxd9mEq-z282Bjd2D4OpXUItzCofZpUPs8qHWeXDrPItZYD0tRh7rFN8K0zBJKadHVGND9rhu8AcOV5iLlpnKHIqviG24DK2ACrmg4r5Nhi7b1F8RkNfNqD4jJa-rF3xXceGmJvYglvZAuisj8Sd0Fcf9NUHffVBX33QVx_01bedjUWfNwVdPuizD8bCB2Phe_XJ9mQsqUaa1XhUC5UY84G8kpWsSSW0_kK9lli8ExWT4wcU348MLcw1RKb5BuZaNIBZ4YONsiOqstfpFPvU8w0jP_1wxfcHIzM371J8MOQ-GHIfDFgpjHYpNK0UrqoUOlQaKBIxe5RSVqVKYWRKYbFLYalLYTxKAbL9WnY62AG_fRurOWWIAe0_NZZ2lSv2t1j9Rphjfw-EUMb-_-Ci7SA3CLGrB3GrB3GrB3Gp5wTQyaDTdVHSfMVzJooQinoQhnoAlgfhp-cLoEY2dkGU6Wk3jke6VPH0oXgNG7FcyBYMsyHMevwsBkJs6fkiG61cwxYg0vQgHfQg0vQgyvQgwvQguvQgsvQgqvQgovQgmvQgcvQg8vcgcvR8F4RY34NY34PI0fPfoF8w4cqv9J9_p3h-w3z_P_rP31cc15myHgkwS4BZAszSMSBALQFqCVBLp4OArwR8JeArAV8J-ErAV2oEAVIJQbuEgF0CjtIa0IUgROUSAJIAkJRgkJOAmIRIXEIULgEXCbhIwEUCLhJwkYCLBFwk4CIBFwm4SIiwJUTXEvCRgI8EfKSXQC-DgJMEnCTgJAEnCThJiK4lRNbSb0xBiuN9k4mTEGBLCK4lBNYSgmoJAbWEYFqGJsrQRBkQyYBIBkTyMRNlSE3kE8zRDwCTAZgMwGQAJgMwGYDJAEwGYDIAkwGYDMBkACYDMOci_AvAZAAmI4WRh0EATgZwMrIXGVjJwEoGVjKwkoGVDKxkYCUDK2cH_gVWMnCSgZMMnGTgJAMnGTjJwEkGTjJwkoGTDJxk4CQDJ2fEpAsykhAZ01EGIPKfjV8fu1aRgY8MfGTgIwMfL_Bx3syJobzQI-_pvEDoTF7hWbzwppJXWMsrPJtXCHC90EYvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9UIRvQDXC0X0AmAvAPYCYC8A9gJY70ts9AOUnW-bFMP7Y3ZByQv4vb8xxzf_Yx3AvGv9NTTY-zdmTeUmxft3puhcxfsRU4QffmqKceym-MVtKvGalq_msp72WHbdzAfj4sNc8WGu-DBXXKQMc8WHueLDXPF9wbT-ZjTlytIHFV-rKdZpZ4MCzDEf1MC1iA1PLjQHOQPmImiMb5j9KVTHB9XxbTR2v1jxfdEE4DXs-pprucn7-G5iR30bWwBt9EETfdBEHzTRB030QRN90EQfNNHHrB-pTys-KKcPs973smm2XaP4vlvQohImgIRl8EE1fbCgPlhQH0yBD6bA97fiC5gwB6VzzUtpR5qW0o5h8Sk9ll1UO9k0dUrPZOvAsJZCWUprzX1Cd0phZ11PF2EQo3AhGHRtZ0fi2oFS5IuuPaZvvoVSZI2uH4KQObrSIERmrp-CEJ25fgZCAu1CAu1CAuWeY9JUN2aXG7mz2wdCKOY-3NhJQHF_ju3WfRTqYVq4jzN9M9-0FHcK6p1mKl1gKkHq4K4AIX1wV4GQQrjrQEjO3ctATbyVuRZeYRtqI4V3w_m4kU-4e0AIEN3IKdxrQReBLgUhDXCPGQEpfV5xIzNwI_l0XwFCAuq-CoQk1D0BQiLqhgNxI9N33w5CZOm-C4S4030fCO7C_SAIgb77URCCfffjIAT87idBCPrdT4MQ-LufAUHe7m0gJKxuSNm9C7QPhEDf_a8TZWQxECJ1_8S48AbJun8JglTdb4KIZN8G_Q70DugPoD-CEGW739NFWPavKm5E3W5jiOFW3AjD3f8H-gcIIa77E4Ryc0AOkAcE3fAcDjoOVA6CTD0LjGEuIgUPxOeB6DwQmwci8zSxIS4k44FUPJCIpx-0lg1jL2ILQmxcO8IWRNDOGOgqNqaFvDyQledmEGTlgZw8kJEHcvFAJh7IwwNZeIC_ZwfbL4Tg-Q5b-D0UYqZ5IBIPZpjnZ0x0-0vm85tMtPs2s3j3DrN4B6glQC0BaglTTMIUkwC5BMglQC4tAAFnCThLwFkCzhJwls4DNYEArwR4JcArAV4Jyi5B2SUouzQCAlQSoJKSIGi3BM2WgJIElCSgJAElCShJQEmCFktASgJSEpCSgJQEjZWAlgRNlaCpEkCSYIGk74CAjQRsJGAjARsJlkeCjkrQTwk6KUEfJWRR0vsgqJoENZOhYjJUTAbfMviWwbcMvmXwLJebA1hAIAMCmQSlgEAGBDIgkAGBDAhkQCADApkEnYBABgQy2JdDILAvg30Z7MtgXwb7MtiXwb5MVtXAvgz2ZbAvg30ZrMtgXQbrMliXwboM1mWwLoN1GazLYF0G6zJYl8G6DNZlsC7_0uSsZaAgY4bKQEL-Y9EHR_J7bLwiAyoZUHkX8ALTRbzCCl64WcUrrOMVLuMV9hcZMlnHW1v4zs1-B_S9lxa-l_TfS4oXgvFCMF4IxgvBeCEYLwTjhWC8EIyXhOoQjBeC8UIwXgjGC730QjheCMcL4XghHC-E44VwvLt4Y4ekvN8yB70QlhfC8r5pDnPfNhe9Yx3a_tH6a-i9l0nrbG8r3v9j-ilXvBC1b44pUnOYAluPqcRnKjmcDXUxrXwwJT7MIx_mkW9R8SeYFYWvHExEhVnnqyvy0AtfLzNFx5iavqYiERqCujbTGiDmrg9z1wfz5bvIHPheai4KsXEwtMoXMeEIHfNBx3xXsCGOz-g8ypYpvgk2zr2BLbiZLbidLYDO-qCzvgdNI4EG-6DBPmiwDxrsgwb7trHy2sFJXX0wPj6otA_GxwfD44Me-6DHPthbH6yLD3bWBxtbCltaCltaCh9SepwJsdJyxo2WnsIWLOIE56UVzGpw6TI2AIa0S2GIS2GISyGF0shE2esTZeQx92sTZdpE2dBE2fBE2fhEGVnbRxhVsptpwXmuaaVuM3zt5ITi-JAZo22CDeNt15pKbjGt8O_mmM0SJN82owBhTxTbl03t3WEqudNUcpep5G5TyW_QIVxCiR30JPttyVOmEniekj0Tiv0MULXx238o9mWmknNMJeeybTruM5Xcz5Y4T2INi7MFIxmCQBFT2241tYB0xAGv6PzUlGKthzqEkYgcb1JHF8mz_YVoaN4c7z13KK6ALsRcq7gqzb-D-y-F5BxIOB1kkf3L0BQbyAmSQKWgI0DkkcL1bIB4PL44EXQqaCFoMcgPqgbVg84BNbCTcg1aIhU6QStBq0Dns4HixeyTFLIArLGRa5gtGEWty0EpdqTjRcwxvrqarXstGrgRdAuIwHE36CuAp5PRetumxxXPV_ElmV1Pgb6BCfkh46X-oXi-iQgEcLowsT0v4t9vsHL1vGLyrp7vo_K_o9MwM7k9_4kvfs6Exa8zn3_NhMm_1X9-SfH8Hm08hFFBbvL5plVAx9WmZycy8JCBh-N63faSs4ycLlIkKIwEhZGgMBIURlJA0BEJOuK4F_QVlnMJGiNBYyQohASNkaAxUgOoGRQEQUkkKIkEJZHOB10MUjFryO8wEyQIXILApRRoHIR8T4L8JIxXwnglyE-C_CTITwLHEsQlQVwSxCVBXNI_gyAfaSdoNwjykb4NegUEEUgQgQTDKQF16eeg10G_Bv22qOeXAK70JxAstoOsM38I-hjwYVbZwJoMkGSAJAMkmcyq-fgXw5HRpfNIM_KYVzK4lYGSDJRkoCQDJZk0BZRkoCQDJZmsWQMlJ6l7sX6vgQy8ZA0EvGTgJQMvGXjJwEsGXjLwcjaCSGvASwZeznYQaRV4ycDLhpZl4CUDL5noM_CSgZcMvGTg5RxkJSsDPRnoyUBPBnoy0JMhBRnoyb8FASYZMDnHzbH-AXwF1OSPi4OMKhKQkaDBrnNBQMSFLMZ1NmgpCCh5T-UF9wt5hYt5Ya-fV1jNK6znFLqcLCIuBxvE2CAR5ycmf_GWaS8CZOtdVQDDxWYJ-9l1akwTL8Tuhdi96MQLsXshdi_E7oXYvRC7F2L3Ypp4MU28ELsXYvdCQF5MEy_E7oXYvdBLL7FqELsXYrfdhgFjCnhfZDuEDnhfMXuXL0yUQQ-8kxNlX5oou2qijCzG_9qcHPzWXPR764TgT9Zf_4VdEi87Y6KjI5xIdg-tTGmJZGILzHd4c_dVg0NDLS1VjVUt_rP8V8WVu-etPaFQVkHKypnPfZlmetS4OhyLZlqb6AxGN2jRZCw-3j8-pt37jZXBpDZqKLO1kaIudVRbe1r60fSuyesmJ9LbyievS29L706_mN6f3k0-7Elvm7wJ396Y3tULDsKjqdGBplRcXReO0B1cLWHScBN07Klf9Q7SPbNJQ4WezEbaJOmtQ9ugRcrm0Z47wtH1a7901WA0uLJy6VVtpJmlgcr6ilr_0uz_AhVLA9U1-DewtGppTU11YGldnd-_1B-oqKldWluLrwJL62mtuqX-uszPrhq5UIyZi68auSreFByMRefNOe7R21ohGjJe-1YzUiUFpJakH0NbO9Lb0zsnryXNlae_mt6Z_ib9SLp5Lr2_PP0EamwjA8iDUxL41BKHTUYc_FVV_kCtJQ4B4FBZW2-Fw7SGqsdD-vmdeTw4mmMv4LEUbW5Lv5Tei1ZvQqu70NGu8vQLaPNaQpO3of9tk3dM3oKuaYfbCfyTE5N3WmtTSWDj9LXpyyyKlfX1PG2qzKA4pSIdNG8GMOv9VsrlKIBZlX4SneynHV6Hf0nrd5JW96P4xYwQUYAOrocYt03eTAqyiClP3WKCxlZAZowiE8ghUwXVMamXvwpEIaivyUNwECPSM18yN5ljvoSjSUcVmF-U_hqa2Esn6E6K9s7y9EvQzJ1UQ6_Dv3tJ33vR9zae7lyts0Rv8nTnakvduYZjiQKfQXemwY3RFN1iNfVcBcCOTz88eT0Q35beUw5J7IUInieGL9M0D6EFhdn1psxDaIElQuuZ2VVXVxWo4SAkYJmsRm5QH-e9Vmi4WcNMzNrzZJLiA5TyNjojr6WqSyfoPUSPibXjwXNBHh5b_9948FxggueYAjobjOjU1QbqKk0zDM5raU2tv8IAS6DeYLGFedAD5flHjxVQngJQlXCP--m8vZbO4dvK8c8LmTn9QnoHFUzWX0J1J2-GcLiOv6GgTPuu5KHVMC2HV1tfGbCcblNo1PSZ0sNX_R_9VvBJBfhqIJaMNdxJ-iHT-kXiJdDi3snbqWfN-okdxCpmBbd9iukYDUx_Ot7BIFhdH6gLfNbQ6aCY0yM5_5zjrZCUjTN2J5q5idpD2uou4lGI_6QudTfah4nchxFgMFMg-KtHpo_gVSaDVumvLmLQpsRtGqwYLJy73yo68Oqjg4eJJ4YcNhEz8DyJ4yj-e3KW4SUS75H4FnKiTmfyzgJApROWWNzOYFFZVQ0WpwpAp0DlIAasx-boq58XxKYdceweYhMxz0lDL2bCEoRpwHw_-t9OtZp82kW63ZkXFaLiR4nfIZIhWq2P2UvvsITsCTNkVZ95Ah46PoxIft8KSV8ByRPhm4nTIaHLdfh3dyaH2ksVmupvwUv-tcwSnxiDT6C22h842HjBekyGGXXkfkFeT0h_naK8LROaZZKlXURR2clTeYIlp3Fz9lZd_xmcmfWwDMnFG1dbMXu43nw8RhsjJvwFqiUv5oL5TDyxP72PqhT1ABN0Turz1z9bInCTGQH_Z8m8DmKsBlhuPczKCx1RgOVkkuRN3kAb2U0Tml1EvzJ_vJTpjud6BgrQ7Pkyz_UMWOK1gQ1_6nJh4MFpzNRM6OGpmrwmD88HH3D05ki9m76XYvzNQvpHYgLS8o6M3dmeCQ9oRxMFWLYesEpI2WSitqqipp4TL2cy0rqayjyr0xqOnuuKkwuGofuyWCoeVSPBaCKpRge1ia5V0fAGLZ5QI3QBbdfutSeu6gqubu7ta-gY8FcMtGvjidhQR2xcjSTHB9Zo2vrI-MTa0wp16gfau3v724INkVgiGdcSmhofHMlXPNXQ2AVqXI1o6xtV9BjtVVF7oEkNk3on6er5Bxoiw2o83B_X1GQ4oeUbO8VQqX9Ew__VpBbvj8dSYxq3T_9A3xiaCYWjw6jcER4eSebrzecwoRvUFuWjUw6s6NeuSDZCllq8yX9WoHLtcYUfVVcP9I2oyWRcTY4MdMaiyZGJtWfovq4aCGmRDWguUF1RM0C4SaRI673acCqixg381A2sG1IXR6-MJUcWq4mEmooUxnmyjp_AQB8EMaLFw5FEG2CM5muV6xuDUquJcG5RNAeycexNqeiwFosm8i2cbhj7CGQVDalx3sCLcFlVy6us15XagZ64NgbZRoeHYvHlAC9SkNsCQ6sbYuFQAvNydIo2AUlPPDakJQi_tKmwVuDpOKNeQTXDG3Rfn6BXgQs6k-aejtPXWBOLR0LLY4kEb8wYCFSsD6yRX2KyZcHPVdWpeO3AcjVCpl9sqCe2UYsXujvRIKIWqDdkrYVawlo0lBPjokKdmoFWNR4PJ2LRgS51gxppio2Go5g0-Jxv8lTDEBvWpSDVaLJ7aEgjYkjw5jSgssD0JIOcrkQvoyr6U4vpNhhpGIylosmN4ZBGeAgXm_ed6mWxOCzOEJrUdXgml-FVUZgawBPqVIfDg1yJVXMkZlSd5WRc4aFUpIkocaC2oipfsZiSV_MU8nhDq-ZeT9DPzk5tcIQ8sjBYwBN5TFLvkevlCWXTigPKHf-tN0qNgbMq9Y0DxFXxYS0Z60vhHx6CRM_HMPFggRMbw8mRcDT3iSfgwmD7e5sb-lb1NnO0MG89G2ORiDZI1K8zlRiJx2KjefaMsPeNaYNhNdIABRuOjoITbufwGE302c46Naq1a9oYVzbVA7H4cDw8OqrG-4i92BiOhpoagh3n57ouN8BDBR1PNKqRSEF8CwxVmgdjkRh0So30pQYHM7OAZ43zfPek4mMRrTO2Ls9ubXG_1wDtSI6MN0Qi4x0xdXS0K4ypGOVZrBprRQLnJIZIwqEnwtF81yezXhITiugD5YRn7OsGGq6ELUhqLbE4qreoVILZmpuV9N4-_YO3ypqKioqr4msrDRz2a6NjMTDZMHh5KpwIkwYSWSGHE0k-0BUozoQLkMeqaEiLt4TjBZ09Vj_CNWp8KA4Xm__2eAOXjTFizsAo1zD7B3qhmOFoU2xjNAw3rTVBlxJc_1ox0BAmwQIqNQwOxuIhHmBkkpHhbiTS6R7TEADAqxQxpJ2xOOIUNboihYirZ0TVxTPz9KrU2bBmJKVj0OB4uokbMJgLxnNRRTF6e679ioYjAZ79MsYYLeqGGOw_Om1EuJjkYUA6BQj4dRJwtcQiYRX2Jt9elaG9nJwboRWxiLa0-YqxSCyegXk1_HxRRAwsL2Isg6aOJoiVIxF8IhkeZvxenaF68yjEFAnRXw3opiAtgHaFNJ0BPNEgwZa4pjW2Nff3k-fN3MiChCDaeJuqU5fTuE5SPJYic2qquId1XvgNP-4JRpGoUSuWhfJMY0zQGlVhNYeJKGJDSF7CMUzhcTGXWVNfw7Xd_oF2IrwRYItAMsm1YGitA1lDhzaM8CYh2l99kf46YN-0fPgwlR8P1E0VrELDe-LjwKV5XGsKJwZjsN7jOQRPYQKX6PgKmP82hMwRLZjkBpi1A41qfIN2PqbUGpXbELQa_YThS2JDLeNxdf36fENnFdfmzExAHjcU1kIFVk5g5hLxjTTT5eVTmWAT8fbQmjCJK1Zr4Ugmp3li3hzb4OYD5L9bmMijRm9lC5FCp7oeoDV0ErkVhnNmcQY4cjiJGXybFknA3EYbRzDVOcEjiTFbYhsjsDCDsYz_ymZkxggdLg66NA6705uKoqlYVBdnLrEYIiJ75JjxdREENbxZRhOqwfX98POJXNfG8aGJVpLRNg8PtxFkskwwjszKztQNILoPrw7rZ7LRLbVqNLdaNYbsimTF63Tp1Yk8WdFAac3KXGsLDXNFI4FSLDo8sDEWw_RkInxjnNEH1x0NJiJapjve8Gs54Ywx2muMjY6mojA9VBeLJFnZAI6ahfE-VIxF_UVyWDWpFrW7p3IyQ-DegkBoJJ6KFllN6NVCqUGtV0slNOLUEEPyjBajPH2aprNup_KWHbRIeLAVcSwY43p48BnRQn3aYFwrePhTeBLN1GkJJ0Z4AWHFAI2RCXihzFzimEkSBY2G46G4itA3MpUfYsLb5g00nDdnNXUDbTFkNUPhwXKjChvNfVt23YF-uQaeQwvxEKlFDqHG1ydgsNQ4L37IhfoF4BWjbTfEFqcx9mYjWdShEdBlqKDF-dPRrM_GZLszHIqSJadOLanS4Iy3WlNJVpFCsY2jZGVO45pAXdbbkF0cyo57ARvstxDft5ykBM0kqVMjvC5JcEGsEYBu08ec5QaDRa1YJLeMkbVpC9lWYFHXhUMIn3o1dXDEAOrpRk-f8fIUVCrkcJw3eeoGMsnb6mBfsL-7d2Dlqua-_j4Ov2R-xwfJvsKoOkVKTkXKLquxy4RMRlpk-U2XPnYGm7gzAtAVVk8yIIYLTqFYWO6fYoXQsCTGmGJ2OazoEls5x_ZsNBrs-QZG4LG0KE3LinSG1CZCzIQaNS3XLmR1k4BGxU_nTSKWivDqVsN4jpFVsUx-0IZpMUy64I0wG3l3AROdphtZWEPWaJHzwTtzHDOUOBNpZSdWgodVbZEFVcOaaxMxRyPI9gxzYL7Z-CZaUvFiierysBYfjiVHsouzRqNh8Ag00omHyCpiQTaL9DA2jqijYyQRp5j3I7tEztoOVKcKjSu4KWK5cR7wBmi0HwSQ0Vgs2qIS_THHbPVomyxekBSgD8qQ4Cb3FVNYWcbXGsA3xlaWq7fVkE0csU5zNJYaHukn62cb9En9mYw1gSQjWrQhGh5VV5O8I9IbbOnP164sPsDlJIKEEDJRuyEyMMi3J3XllRGtfBBGVeOu7egfBfTFAHEe42P17TSt6mpt7u7q4ya32elDfNSoqlt7WTRFZtDU29DcBeM8xVMP7lKpcQVrZUodJOkCWZvJjb_MUKNX1S0QnDrFwl9uRIutAlnOoIzTtKmlPzyq9YaHkjyJklyjP5xYD6fer9J_umIItIfpIsJyWpIbxsn8RyqM-TbCN5oNGgYaEJJi5Jnl0WzlLcqfuw1ZmP-sagaUNmJlNyaayQMDo5jO5Fh_lWhwUsX4R8PGhc7q4jFeX5SuWUJ7iejIs82i3OR5bsWgULkTxk1X-SzRTrhPH6oH6KraGjWErLthI5LqDKcruweTsX7C1AA1UMGmifaOltb8Q8-21obe3mBfd9dTzetS8KkTrYkUUaPxzSvCUfjuYYgnMRGkc68vfKWm2N7vhAtKNpICohpzWgZTcSQAc1b0amOpJF152m07UZF-vLWlr7mxu6tJOb6jCxkRtLpTvSLzGHx-e6Yg-6m5Jdjb16_MfaMj-wZDI8loHG1QTprAzoHvHaM7pRXnu0_mmvXuyvxuTr6eI1fPpkj_-fVsPVumlq0f6K8PRodi2Sf1tG9X_rdrj6VP0On2JLplizw_z2xySz-Xa7ekJ9fIaJYVlyL912z1ZP97nvfbH2d5t-l4_4UgRr8UbO8NU3tloXxFe6Gi7WOxBh0HxAZo-0SsnuODfL0lb2aV6eQF-ZouXc0ChMeMsS06dfX-T7DnD3PCV8rT2Xpc8dvyv-6n72C8kN2zsD-9L71zcpOlgr2X7-PYtVnunOdyeylMmV66f2ZXth-6-7x4H07F8dHM8-H4f7OA1Qf5PqRLc1jVcnux53vpSm_ObssnOO22xOmTmefB_bGgjn4682NxzpmFPmyz0EfJLPRhn_k-ZEdxr3qU3qkelVX-I6-c2qfKnvzAS_aJDbwLA99PX0u4iezmtZoysiRmSmW5MHW_wwYMip43V5Y3R6WZG3vZStPs0Tkr3fSRD5smlMc-ZoDSxoPScZggs_NFmfVke7c_z2FWkU-0aGeBvp057Gj0rZwkOhpndjTuA9x2Foi247YazUJdK9n-SvZNYcN76IszZIf0LZlXFIqrpKTIi809SPdweyjR9fBAYZ6SLchWPdi_LKgHZ830SDz-mbdKnsDM92G_Qyy29FTNAr_Vs9BHzSxgeqdJSxXbXTw99dSJ6XPJEeZU4XvcBr8gJs6Szwmac_cpHF7e58bsC0xNKof9hesievIyOO9n2ZpnBLhSOLwgBX_NYrL1-nq6SX07fY_q9uJSKAspjjNFB-Q-Q9Cs9OcHfvgIY4hlUa_gWZNvxP6OmAZ2UA3cP3kDeZezOM9uxVEhyMjFxT2KwUk7srrxKdejrBNsRc62cjavFZuYbz9aWA-rzar9ElcNhwTBGp62wKbhShDJjcxw--EZbv-yabff519M31PLz-YXJ--06sITMYlqLtf8jYrlePKomOg9MUHvOCZWz10v2G9csL2lgiqcEMPFkxLMkc8RNa3OcwQ5vlKQky8eAhMsXy1ouGwWjTgbBNeylgtyNlF8UDJnUIrzl7xhORrFunOL1mvKDassZLUQa9OtkT04eS05xGPyxqnXyCCMmwWFYSVRd8tMj_K2QzBKZ5tg1OUIignH_pR5HpZ8idviCkEtvOsQ8Gn_umBn9x-CzuQH8o3Y3hdzP_RRAQnpt2deGycPCuCOyLMDq5jSpTi7ZmEt6qHZ48f-tKAN6xGst1KwXq85nynnasgWQXNfkvNCF3JjzP8SjB7LzhZioKzF5J-Vq7ke2v7P5p6l7_Ce8sjbik-GuaJOyf6s2SDYHdyc50LBOfr8IXC4jksEO9tlWrcRCSWnkRYuUxwDZtm5v8aTnXNAbNTOS8WiNft2wed4IdHoyv6cuabrb1z7PyQYUYomRT_MS2ru4wcdh_1o2pnD2nnpuyFo2NDyXA4xQf33c-ltxcXuUeQfz1pXzvWCUK8XNJajoms1EcEGY4LPiS8WXJ06T_BBdkmDaBLvvmaG4znHDYJYbRKsd6ugrbhtlvRQVuzfFQwi3xfzeU2iwrP_zVzT9SYXtbsE0b1bMIusNWviDl5Fl2CD9icFB3ivoAv4gdlgf34312DfJ6hQgksKjq8I7l4pLA3WbBN9avnw5PU0uN1LDoqwmnau7-dbP_1wYfXfQs8j2U9OgMzM7eyJdrdbdSVdI-jJavNDWphd7lRKn5lygewuwmp6B8axz_q5mFOx7xAU0cNi9VwPH9SCm3iUJCvORwSH8siMD8X1L4ILFY8K2ojLBaOwj2ch1xNcb3O2Ck7eD4U2zTl1U_cResQqOQBph9XUdSrOx6c_dRdSQHZkUlF6ntZ-euDr_swBTOQIHXKwIPSgeM8lirPb7E_k97j8L9dFpaLPVh7LnMpnLSukVj8R3NbXNMNTwqNIzYK-gbM8ZN_FUzCprbDosGhGEq_5ihSc-T7sPxWcKP2zwO-qme_D9YyYAZHWCMY744J2_1nByXCRaZPlIYwmSn4uKO1L8qMofeaQj8J-laDjqZyFrQcLBUMN0ZDkOPMW4CM-5m4BdgvKYvgp1o0oJX81bAErPNrz6LaA-QXbv8zcvrPU0L7Eab9sjXlV6NZnOCpd1iGajb8wC_tyo4KgCGb80uWCZuINwdj64dlby_bszvd15M2H1Pc7yhrNflSX-uofLMcEA7rOaStHR_qJ_JHne6yAcN0jaJu_OG3AVqUfRP97smfSbyJnZi5ZssQCOcXxLcG1pstFVxfkB2dPp9zfOoi9OpvpGarkUN4JK2Skia0mQ2V_3mCoPFO88mLxNoKDpxj_NmvJt32rYBzx77M2JNfLYtPCKRpC3mQ2CqVv8ya765VZY9LxQzEmXWJrg2XmFWDFneYK8nuzt7Bz5yFwrJYxHRzrXbPgvO-eeT5cP5g9sdw7C2K5bxbE8pXP3sfkpsnbLPu4fxb4eGAW-nhwFmT-0Czw8fAsyPyRWcDq0VnA6quz0MfXvm5yT1P0sTp9N-mDWqwX6An2N031dqb02Kz0Ulg37c29dXTKr6Z4z5S-dzN5UzY7maqHzeaUd-5JhkjSy0uppXtmQZJ3zIKT--HsObmnpp0QtNF3-izbPVyRvm4WYVmHQYQurgifNicRx_uNv5siieizeK-Cl0U4Py-Y-18ulgqX_Ekw3n7WDNGJ7xpYLeEuHL0mGPdHBFP3S2btCb77tRl_uiY1zvjTCvcvZpwLx-uCOtQ680vynqhpyXQOb8G0RBUc86hZ7-V3DHov8_TekxR8blon-AhB8N1Lp-CWCfkngmuNorJdPeOyLbtINB12vyXI3E5TcDDVoHv7kmpSK68oX1zeEiMH8Whxy80HgpsK3LWCq4bftTiAxvAycpmSi0XuL2KldW94exKCUv6BYL1_m_YwfesNw3Tyhin9aNrH7zgXTH1UgLuZ3e4255Bud2sfyx8XmLjxiRWJ9eFIJNNgMPN3OKqVPdWJ-n35r8ra9RVdhYqK7RamZuiDIm0qthBT9XvFet9trIg5vIIeZruanJk30UyPgHqiabk6nHhWueXHtnlzbK__xaYcewr561eLyH__HsJ_S6Rf0r_raY0P6d9nk_9-cKtT6XM5ld7XnfPm2E87TUbZR022IGlxoGVVRwdp9huWF_bUTnlDTuaKPxJL3lhOb16jdwJbXbCHTsWu19Pd8JMw3vBTWR2oLX7BT2V9lfAFP_zhG64AK-3M3_RDRWB9B9QScqdmNk3alu00c81UZu29nB4Qs4fuCylyd2jh4mL0JnZx8VEFqL5Ioaot3JQWqKw2XR4KoKrrKjL3E_ZE1HEtvthf469eXLG8tr6mtqaCYjctRgyQSc05yNzQVw5gc_SXZj1M76Cjrih3y-Z2em_dLblbyqxQQgdiGOnUaTXFyJ_DqKa-ynQ9YW3u8sbM3YNTjdCoMfkLwzJT1foa8NPoLaw3Fa4l25-5zncfvHT-6Zfu-jQ0aCX_uEn-NTV1XPkHphT_1KMyiv28vNipcdpqNVPWpP9Fp0zpzbnrCAt8_j1k4lMu8DlA-awp8FlXZ-azHozWVtYtDSytW1pblbmQujar94RH_hD0TB05fFqOKRe1td-wvAbwtPTmyRuozdlGr_Cm2yWphpRn1lHI2VD8C0gLVwajF7Erg49iLWRB7JWV1fU1XLH7a63lLsSAHqLDv3WYQe711hbylPSW06FEJATduaiA-v7JmzLWeRs5v876Um70IXYpt05fImZ9CVTz9aU-oy_VAZO-CIxcj8wRF16pUx44Z2vlqSMPUqlZ3VdYm8nd2zlBN-dk73EkBpno7fWQRhH72KDzIh-K3amsU6cbzV6kxs9Rp9p6fJhCnQ6KJaNhWWpQsLM5MB5dgPHs9MP0ltO9p9P9lyAIaw9xZfTe5j3ldCFsX_YS5_SD-POl7NWPu6xvBkbXYqGLTu-u5-hdLVfvqiqo3vn99Sa9O3iGDOq47Hm9On5w61ZLz7yI3LlLjeMd6X3lJ6Ufp7u_Mxtbs1sKyD2i5I7EF08qYPTBrVaud8DoegFHTXWFSbH0rld4CAaV8fjzPhhB8FSMPkZ9HXXw5KLqB4DcPhoO0quFyYFQe7IZc84_oVETm74Cm5cY2Qz4A9VVFlxOo38Dl97rClz2vm7N5YmYitdn7gLOIJcBdoJu-KO3wudY633dSqH7KGsBHWv-SgvWpupUz4_9sXiOnxKaskytoLrA7AXMjBtppHodfUZBTUvuEvJdeQVFs9NQ0EBFTWVtlaWCCg_BaNNa9EHiR03WUXJV-mvpb2afwZBFVTS3nU7xHZm76jNDyFkA8gzh-SmN2UdNYsZsbgGcYXb21tfVWM3egxi04app-7l5kJAIR9dPdPWpG7RQ_tTxiRUZv9OkJtVd7Z0RMtxGdWxMCwUqDrSRC-eiTer4ikDNkorKJYGKQM3aslbA2REexfhDnbGQNhBMNAySq8YOtK6KhpN92hX2tsSYNkhQ76ePpK6FyyIqnF1zCEZTo5kT60v6gole_BEPD6IxcrVZKpo80Nc5nhwJD_ZEUomBBL1JJdh0RIe6Ybhwd6-yolBn8xETQTpOciZ_M2Kzisoeeib4kDqordboDVOQ1U-_HVyXCkdCYFRr71Tj5YGKcsJPZzjRNxLbGM3AcKCzr2OA3KkUVSG_Jltn44gab1qebeaj8y46_yH87-FgVuxre5Rl6sqsuHu1YbIJmNx00byqhUAQDCm2OV2o26fFN2hx9BNPNsEEP9mNXtrP7w02dA3Qw9rLwj2Fkl66IGTrHCT3C7SEIxjLqNbS0xts7uvvBnZ0uM1RoKYlPhfsWd0zkAyPavF5cxwPfK-JdN-bvid76-43aT7-zfS2IG2MfLkifT_xa5Ob0tuaO2NRbRzYzHuoK5XQQn2RWDIxsLyhte-wbj3cPRvGypR-fUnz5akw0ZEypal1VbCpnxe7tCdHE8mxzNnX88Lvbry0OxlLqpFCJ2Xx9l6IqDk6HAknRlpXpyLk0rpg5nKIfnV4BTkv--SAv6qqNkg0a21Pp3qFsvq51jVqnCjegWBWPZNaX0E_y6kGLA3Ud1BxZyXX4g8sqVjiX9U4Eo-NhrWBcDT7Fzk3-8CKjpSardiKP8url_g7DUK1r1VyvyQj0f022DS3Y3k4GuqIDaqZ3Y53wVgRc4VwfytZCiF2qzMz_h4tPog2y1qy2NCT5eeFX53zUmv2fsPmtlg8pK09oVVLmiYGmaID8azMHrx_oic7cwuWJ0QnXu7idQf91BuLaC1tzQ0dzb0dOR6IQvVmcC4fisXLyU2LseQIRTkTx64KJlZrmEPkAg1yAUl2anblhUP4jXQSCZUv6NWSYGRhT675QZWoJyZTOxVBV2p0HVFPm6OkiWjqvPArjsvbMStymK09h75RtGPyTurjdmbuyka0Nnlb-YL0k2R5ZPK68qsqF_sXmDV74cJuwmZPPEyOSifr3I5gfsatVTDbaHSTPdt78gb8liy37FgF096VM0SNahQsamPJspM7g4me1LpIeHA5GfuBzrimRvqJ4hJpY45NPkWLKEzZosvubs_ag_6wFvcFiVZTfHryw81Ek9usBJsBfgWdqI2xSCzeMkT_10El3h3tIMpOJ2sL6SDYVHZyK60cDDk7C79q065YQW7GzP44o2iZY-rnhX_44BfYudqwvKHZv6Wts6Gvo7mrtftZw5H0HeTSr-6hDEjPoPPw5u7CtZv-s_xXxZVPpG79TZyk6JGP1pbrywIVV8WNBah04-a1p5CyhpYaf0vLuelHqfci73lB_DtoAHD7kmWoeGCpvs-KU1F0ywmCv33kE8GKj3oEK37ca2L30WMEf7up3fTbA8fpmasGc30ZzLPr_xnoJzoNYc29nFDHVgh1zqAh1UuTd8Dn7k-_mJlOdDsBwgjyF42J9-KPbfmF2UJw99TubOxw3K_v5y4bmsKbsnmF-OY64zpzoLK-olIf3PpJThYILK1aWlNTjWStzh9AEFRRU7u0thahTwCJHImCkL3V-Q0RohA7NPThLmZaryBW5NbqaIhN92LT4Brx1TbS4_U0WdxPEwq6lKNbSzTHwkflU6jHCsBczVlVDLDAWKwH0HmqX1YUHSrFJJ_9czTHrl9Z-hpMFfFeN2XyqOcya9OZMHwLMWZ8ndmeZfn4x5ZPX2c2mnUmUMPRmcqMzkypLgI8FFeUDzgIOQsILU7fD0dC0xGymH89jaXoi6p0ibecLmvvzMblu3JQOQpQJU7JQrXm3dd5UN1vCVXm2URVHqpATUVdlQkqsgxSU4uZRfEqgBSorQzkUZoOH0Xhup-DlktviR6jF2tcSyYtdBFzmCz476aPPjCdd9FjommIZNaqksvW5S3R3dxMbDqWyF9dV1lR81ktkTA7RRFbwEHMrU9Tn6ZzGtObaO5e-trMrkKOt4PO9efISinpjGZUPOxeuj2LXU35cTzsBiyxu4nBrq7CX1FnNSMra-utYDsInooCOMAB0FMAcBVd7NmbechNBbQrE1HChVBfsas8Kz_0RR_KkO2C5fSrF_XZ9HbUeQnN3EyedpoRtu27LIuw1PkTHsLLTAgfUwD4cQZgf2VtbQULsN8POKsCVVV07uaBrQzU6fXxkPNaFPllHOSlAvI1CHxIik_eYrqOiDqzHE2NCnq4ObsYB7N8PV2_IFcW3MJzJyV7qvPKe8z0J_4dDLa1deTBldXE90-twQfF2rSMgFxAspIuZ06Q58boYQ8R40G5mtPyruYNHowBSxgnOK6mRtjVVPnrDWuz02OmKHABThzn1T__eRrN3pBb6c0-KtlPooBsyDi5iXS2jT57vpFaGiovne4d4KCSxbH6_T8X8LnLpGb1ApHuVIby4IZviPHs1hj5s2vlGWlsE5BGQaPin1qAc8BZAOdLZuWpqj1o5ZnOYA1QOLYeimfN-sfKRYP9w791mPiz5FywX-xZciHYF3-WnA_xt87MI1L909DiKY-0VPwRqHjK81kegVrhcngBF3LsjGFj045sfEyxfyC963S6WedavTrs-4rFdPiP8wtIXMXaivrKqvrPEE-JDtVoF6x3FdRk1-r3T964mCSTk3em9xyk3zk8i8HKR7n72BKWfucGs-moOcgU56AYKup7Eh98sNVyr1_9lJvlttLvX8ytWTyMP16CUc_NLWX7YeYHa7kne29vL2CUMj5BrKrO7UXSR49V2d18dTU1wrv5ig3QoEgl3ZeRW8HVSH6dsGtVNExuM1UjdL1q127Dfa4VA-3aeCI21BEbVyPJcd792vmbPyOxRDKuJTQ1PjhS5GZdw32chpt1TzLcrNsQGVbjYdMF0KewF0Dj_2pSi_fHY6kxrehF3GgmFI4Oo3IHvQeVc61zngndoLYoH52ivxq1yX9WoFJ_X3t1NblpPZkkV7tPdXNtzRS3cdcNrBtSF0evjCVHFrMXixe7pLcNMEZ5dyXXFble2jj27I3LheuCT-dftMoZeBEuq2p5lfW6Umt1mfiCIpeTW7dJ7xzObXemTZHL0XNtHmfUK6hmeINW5IbkCzqT5p6O09ewvPGZXl6u9YE18ktMtiz4nItmaweWqxEy_WJDPWRHf6G7E9mLkomstVBLWCPX72bEqLtMuWagVY3Hw4lYdKBL3aBGmshV0PTJTKHJUw1DbFiXglSjye6hIXojeoI3pwGVBaYnGeR0JXoZVaPsHcSnGO83pk9LNoZDGuEhXGzed6qXxeKwOENoUtfhmVyGV0VhagBPqFMdDg9yJVbNkZhRdZaTcYWHUpEmosSB2oqqqS4zr-JeQn28oVVzryfoZ2enNjhCnhAYLOCJPCapH8n18oSyacUB5Y7_NtzXHDirUt84QFwVH9aS5L7x4SK3jV_QOYaJBwuc2BhOjoSjuU88ARcG29_b3NC3qreZo4V569kYi0Q0-jS0M5UYicdio3n2jLD3jWmD5OEkFGw4mrmQmtM5uTmbPkpZp0a1dk0b48qGd213U0Ow4_xc1-UGeKig44lGNRIpiG-BoUrzYIw8nx5UI32pwUHNeI31yRy-e1LxsYjWGVuXZ7e2uN9rgHYkR8YbIpHxjpg6OtpFr6XmWawaa0UC5ySGIFfeJ8JR7p3u1EtiQhF9oJzwjH3dAHmKjKZaYnFUzz7PLnL3fL82OhaLk-fKl6fCiTCpmchKM5xI8hGtQHEmLgDwq6IhLd4S1l0Of6x-KGvU-FAcvjT_7fEGdhpjxG6BI64F9g_0QgPDUXL5exj-WGuC0iS4jrRioCFMogJUIs9y4yEeMmQ2keFuJGLoJnscyG6ZIhazMxZHQKJG6RXiPSOqLnCZp9eZzoY1IykdgwYP003svcEuMC6KaoTRrXMNVTQcCfAMlTGYaFE3xGDo0Wkj4sIkDwPSKUDAr5OAqyUWCaswLPn2qgzt5eTcCK2IRbSlzVeMRWLxDMyr4dCLImJgeRFjAjR1NEHMGYneE8nwMOPg6gzVm0chpkiI_mpAN9doAbQrpOks3YkGCbbENa2xrbm_nzzH5YYQJNbQxttUnbqcxvWG4kETmVPWQRME0BMfB4jN41pTOEH2OMXHOTEdOAhGkf1Qc8U1u4y3q6mv4dkVVOxALN-hDSPo4Btm_0A7EdgI8ESUmBT0rjX19bxpW_Axnep6sNnQSX5WwMLYcQesmJYPEqby1oG6KQJvGnVEx1fAdrch3o1owYLkzyquWBmlRO40FNZChYZPMMS6jWp8g3Y-JtYaNS-vU4y6DXGG4TpiQy3jcXX9en5givlBHBvNXHlqWTeAqC-8OqwX_ClsIIlYemgN3V23WgtHcvnKSUw_bVokAWsXbRzBTMu1dWZxHKawMEi_YOmjwUREy4ybN_zaKeNqOCao0TiMSG8qioHForrocInF6BCPIzOMr4sgFOF1TdOgwfX98M4JDiT4Gk3QFxObh4fbiFZyIEFQ3RpVEXYMExMXG2pMxcMxuMZxbsSMYLgltjECCzkYyzjabL9Gv9Oq0Sxp1RjyJJLfrtMlSify5g4NedaszA2QcZsmq2YMsxpjo6OpKIZMFaVIJp3JntBIC4KFkXiqECIsNEw-jcRXsejwwMZYDPaDSQyMks1GY9RQjPfRLaN-_iToSV15ZUQrH1QRRfCdI34e0UJ92mBcKzhHIwu9Wig1qPVqqYRGXBVCQM7aQgHTTFst4cQIp7nCmoEWCQ-2IggFIxyfTEKN0XA8FEdej4lnmjFPzJtja7zFsNIQOMvvJ6WbDhiS4oG-JEKj4eZoLDU80k9C_A3FwhEm5mzeQGNsDibMjDH44XnmwDnBV8K2GPKVofBgudEIGb1BW3ZFgX65Bm5Dy6e0itHdGUZRbEmFG94Y1zDUpFrUHZcbw1oyzTG6Nn1kZsycO8OhKFk_6tSSKg3A-HpKJ3Y8RLJ7rgvTZbAN2YUesyuvm8Ik0ri-hTjA5ST6byb5mxrhhrBw5hlHTsM8KoNwfMq1pb4Y7LaWG9lCFisY5HXhEEKpXg3z0SCu04orV5-mhbihQt1AJmFbHewL9nf3Dqxc1dzX35dr0bguhPASqhOOqlOk4dSdsUtp7NIgk4UWgUWXMnYGm7hBGsx6YcWEGnS6ymG1KogI3T9FcGJYBmPsKLsEVnRZ7TRmiUolG07DZHsws7w638AOvJ4WpXlakSx5eViLD8eSI9l1ROOUWMgqKwGPaiBV7EQsFeF6DyjMGFkRy6QM5L2AYTJc3hizwXgXsNGpvpGJNWR9FmkgfHxOFuUcC77RGJsYfWMmMsvO1QR_vbVJja9PjCABNEyF-YZ26OJEoiUVH-e1UVtkzbbcwE9Gs3Iri1mOFunxaxxRR8dIUk7B7kemify1HXDyOq0kC9ih2MZR8lBA49vGwABXwMZxEf5HY7Foi0oUxry2V4-2yToFySv6IPsE_0kCZuxGsppOx34ZWtHi3HWACo55NAY8lgsnCM37xojEEBGrcf4iGYYCgUW0KH3LYzVJOiK9wZb-IssiBju3nISbgDyTJBiM3slmlSCxTygTb4utURL2zUsn9QNNq7pam7u7-rjZbXayEAc2quoWXxZNkSc09TY0d8EkT_F8g7soalyrWplSB0l6RxZncipSZqjRq-pWCE6dYokvN6LFVrEnZ1DGSdnUQt4E6A0PJXmCJcF6fzixHh6_X6X_dMUQiA_TVYTltCQ3jJP5D08Yo22EbzQbUQw0ILDGyDMLodnKW5Q_dxtWev1nVTOgtBGbujHRTB4NGMV0JsfIqUSRkyrGPxo2LmlWFw8c-6J0dRJKTERHj2Upxk2e51YMCpU74Rt0lc8S7aRI1kSX1daoIaToDRuRT2c41Z8Us-tkZd88m7LvOJvy8rfJi4U_u7xEefUGm_LqJpTWgZaCloHOBZ2HWntA-_D38ahzPehG0E3kl0f_U9l2ZV8tvqoHnQ06B_QFkGJTbklnT6Kx77A7lJdftCnP3kd-9P4zaG4vOZUm_V27su9Y-leNE_-teFZ38gwdpvVrAL3pe7Nb_rZn9_nRjZf7Jyfoa5Z0Q-DOzPHm9N2Y9OPkJWB6XMnO7B57-hB4C35yHX0-vo192I8xZB9PO15pF9tmOpfdqJd_0l9V56-uKv4Uu65a9xT7EPNVfLMpFIGD8lEFlFvTXyO7csi7S3T35aGD9rg8tK1ie-rnsu_MG6CtEYL20DBTfHs9JpX1Kwgn59_2zV77RIbxIt3Rmt_Tb8Lq5W9nsXL6N4ptGJ3Lvq-cx6q6wu-vFMJq6oEW3wBKDYv1G8vHZzZOUvy_OXlb4YX9HZPXT96Y34xR2Jf1s8uzKMz93yvE9nvqUOgxbinxByrqq6pNm7WML9wXG1vx7ZuwpFst978fb0SVvg5IXoGevINsU8nJ-9UbzKzkNWBDganzWdHWBSqmL1pmEMYdhvAL1pt5T-Y19pJxS6xJoV_dlGfn8mlP_gEz14GD5ZoZqMXE3ldn7Y4a0k8ccu9TZ-19LKf91SYTWSfmfZ6YKWezALGFtbNpztjn9POYZ7cdQhyXWruahBWO15pxnIar-YysFN-shxjNWh876S7K53ShxC5yEMwhw3SZtW7eb4XpLWZM64QwPZQsFX_pC7GvtRVfSQfyTfpS90T2RZNddO__wQ4mD-u5RS2_45XOAoJfNiFYXyGM4KEcOOMt9p1n7S1WZ059Tm_nmt9DqJ7n5VELTls97zGDK-ZgZoQ3Cz19ec9WS3t6Is_l7S-EwIWduS_vsYg4ogVoLjYFkxU1B-t7DQNh9OjlfVstrdsCU4O7y-lLYXtzbw7fTL5P78szuM-CwUSBwZCZwbqDYrDIeNj5cvxWy3ShmU7YbMj92a3L8RbWpdvK51XXCluXzzpYNv683jqhOpGXp-y3TKdevd46nVpmZRxMM6DOX3-w6dR-oWRqmfLqjda-_liO9uUWDczc31jQ-2nH3mvMsbf_IKdHboAWMferN1nbtxOKmpVM3JVn-SYx63ahmbvKz2TdMsMwajRdOZvq3LL7M82REw_upK8Nk3fiqBf5Kg199tPXjJmzGo7-p6KvV3jmu9iz5_K5cC1MXKVFKjyNsRjfo1D21VpHA0HTu5OHLgCotQ4ALHOnG83xqagezLDPRw5Vb_2GfWP67lwmfwjRrC8EodMOp64xo1ktFk59ZkasYvyzp_K89J1octgBeZHos3resw_W89aJed5DMVg2NjnH2vq2k9P7yGkj-fOed352nM6xwKmVPcHBgFO9YFZ-qIbMovUF6zjlIn1wVFh-ImOhJ2pkjo84ZBP2CwXtmvZa6YPm_Mc_3fDvUHNosea6T5lOzpl7o5YeYrDpkGKuWLucnunlnNWV0845DxlvFjHZLWnrGyHOEb5SIXt4LdUQ9nVbe_4uiHT-0PwOsVhdd1TruOlWiDreKSQHfysEjwWLOP5QXHWQP--0cL1B4VoBMbUTvuiAAnQwFx1wVYc-C7YG4FTYZ5om67HPLFVtp8pKjtXZZn42hIazIFz-3k_Ewj3dgcVrmQOLqwI1ZoNnOLR26jFaRHAvv2gdwS3gpRMvZg7dy3zYSw_du838nPDFwlOiaVsgzspH_cEmP7zRWtiUZ--zjjQCtA960CBpcAc9FG5b5sK4rAXbnTkHaAe9kkT3KO3Z-4oGFCWuxQXuo8aJUFVVUy_-UGlaIzPEDZktEd-wPNGkNX2PaaLxjk3ZQ73vrsxZVMRKbaZ_7KA5ybWFaeMuZIzvP5PFwrf0b2L7G3RXANzHnn9R56892CP_DgV_FrscXt67ddoPMVlnmp9key0WEy63eu5eUXuQ84kdCrugUJL-7lQLCnnnTo9QpAq6I480dWL76JLF8-n9hQNA0t8tuqDg2nsuy6ruPLWqavOimM6ATmMwxiM-lH3HWtvOZnpkWMb8HMr891jr_HfB9J4gVlcLKsJnZ8Vqi0ZJusZabRZjimXPm6HTjxxUTI-nIR4v889-eMFM4LNNpzc1RfXGfdRxBWQuNemN8Sh9Vm-mMxqj4tD9ZdbMLiELXeQG43J6Xt-eyeuzR6Bt1x8lB1nQe3gLp0ah4aLclsg_LHB7GcNtVWV1JYfbzCVEuT0N2QU48XEZ-c4cit-WGd_g-G7bBYr3wOZ2qDBqRJOoopR0KN6PDUVlIcVnM5YsUHxOU4lkKik1lhyn-I42lkwormMMJTbF17Cl7fLcJ_1XRym-ZuOv5yu-oLHkCsV3vpEd-zuK72JzUcr4u1rFN24suUDxXW2qc62hxKH4bmQLbmELHmLZ28nA_TPF98oWfZEnz75H8f2-CBhzFd9fJhSfUXayUmpEXLG9r5QeYWTje0rpws1GXEuNKJYorq2GgnlzSvc-rpSuZGs9Z-zsyJsV115WQu6jmabspecp7lON1boV9-mmkkbeD5t5hRca8JPziMmKO8bA756cUNy_3ZyvUqYoniXGrnsUz3LmV54LDAV2xXMJWzBkKHApng0TiudKw8Ac-V4diudLjKJ4XisMSrH9XvG8wXx-S__5N4rnd8bP0rrC56MUeb5RNO60Ir_GQDf_hglF_oSds17XhOI9jan64P0oPINXuIQjD2-AV1jDK1zKK-wt6LzTMDpF8V42oZS8x6iv918NBZ9TSv7Kqrz3R8xE8f4Eg3_LZBe8vzMX_WELU1TAnXz9v9Zf_5Vp8FLF-wFTVKZ4_8FM27sU7ycmG1xisq8uU4lsKjmM0VTf5w0FHsXuYfD0LWXA8rUYW61TfCtMdvcCs5G9xFy0zlDkVHxDbMFlbMEGY1ctiu9KY8mA4jPOprJ2xXcda4g3sQW3sgXbWVP9vMm--V59sp3e69GsxqNaqCQv6xKjo1uTSmj9hXotsXgnvk6OH1B8PzK0MDffwlyDebdoAJprry1Mdp9irzOq4OmHF1Tw9MMV3x-MbNy8S_H9dUIpDRTxOjallFUA-7WsMtq3mWRr_6mxqKtcsb_FqJbndJ3pna94GllD225sQ7pU8axhTe2FbMEwa3u_WNzuXlP8q18wFvdX-s-_Uzy_Yb7_H_3n7yuO60y-V0owI5N-Y7LLjvdNSMonmGo5I6bG5T8bi45dqzhv5th47-k8w30mr_Asnjmu5BXW8grP5hW-xKiA820Tc94fs3Gi9z8wmt-YbfH_WBvbd62__hsTet2keP_OFJ2reD9iijCST0222G6ys25TidcUrc5lLcyxbDjs-4IpZDbOEWXpg4qv1WSP2xlj5lrEmtELzcZ4wFw0zP5so7GrxYrviyYwrmFDZ9dy0zT23cSa29vYAiacVJ9WfC-btPQaxffdLXyzC0f1YyD4LuhvRXOI0rnmCPlIU4R8DMtj6bFszHyySY1Lz2TrnAUzW2vqz_U0259rO9ufaw9b4p5j0gP34cZKAcX9OdPPjjOVzDeF2qeZShaYSpp4kXcLr3DMONDS5xX3TwwRt_sPm3Xexv2ezo7av6q4jQbRrXgWGJ1GE-s01rIO4SK2IMR6iBG24KrifmEH29p32IKfMZ7il8znNxnP8TYTy79j_CyXm6P3X5q9xB-Lpo3ye6zp8S7g2ftFvMIKnhWv4hXW8QqX8Qr7C_PRw4b0awvfudnvLjWwKOUrSop3F6-fb5l9SxosvWn2JG-bi96x9h5_tP6aceO2txXv_zF9lCu-OSbj6TD5DY-pxGcqOZz1JIuKryFUFAB2MJF-XeErmflqmckRNRUxqrC7baZ04CKzb7nUXBRi3U3EhM8VrI3zXWUsWab4JlhXcgNbcDNbcDtb8KCp520sxjs40ZUP-uX7I-z8cSbuSssZI1N6CluwiOPfSiuYBK10GeNXbBOsA7Hdaiq5xVRiZBkzSLF92VTpDlPJnaaSu0wld7MlJU-aSp5iS-zVxpJ_KPZlppJzTCXnsu047jOV3M-WOE8yLXTsZ1G91vSjt9gfOT81uW6HyXX7C9Z83hzvPXcoroDOga1VXJUmVfE0sD7tfNbHXMwWaKwLC7MFKXaNaZwtuLqo13N0Mqpp2_S44nnFZF89P2d82-vM518zvu63-s8vKc4jTUm242pz0fVG42tblG-kVHF8hRWK9Nui1tDxIYOSc5D9tXy-KbGSL9avrjnHzc744-I9hhlFc33DtDz1IeM8_qH4rmdk5T2V56wX8goX81yjn1dYzSus5xS6jjex7HKa5ssnJsZWFXyGi3Xuu3ljf5Fd3HvF7KgnJxTnuabikt3sT39t_ulvzUW_t_brf7L--i9sAtnW2tDbG-zr7nqqeV0qHEpMtCZS5BCO8c0rwtGeeGw4riUSE0F6Jltf-EoNGUFnRE0kG0kBOVhjTstgKt6rJeas6NXGUkl6cOdu24mK9OOtLX3Njd1dTcrxHV1xem1up3pF5kaB-e2Zguyn5pZgb1-_MveNjuzFio3kPBRHW1zLHFQ7pzWujZEHXg7F-e6TuQ-2_PeOXE_eXZmm5ijSf349W2jLFNn642p0fTA6FMs-TqR9u_JtrD2WbACkj6bILWKZG0nJzpjJ69PP5bos6ck1MpplxaVI_zVbPdn_zuHdluP99sfzvP9CEKNfCrb3BqeenW0PvsT2sViDjgNiA7R9IlbP8YFgPR6Azly9Y8by9f5PsL0Pv86VdZ7l8rRZjHkJZ1vJd9APtdhJH4Nuow_D95FbxRXpvZx6wbJnJ4rzXG63hQnTm36M3KORbYzuFC6uWE7F8dHM8-H4f7OA1Qd5rKRLc1jVcru155vqSm-m2992ZLYlWOL0yczz4P5YUEc_nfmxOOfMQh-2WeijZBb6sM98H7KjuE89Su9Sj8oq_5FXTu1RZc8UAy_ZZ54KRQfelX2tiuzq2Z_eo8iSmCmV5cLU_Q4bLih63lxZ3hyVZm7sZStFZo9y5JAiHzZNLI99zICljYel4zBBbueLcuvJ9m5_nsOtIp9o0c4CfTtzWEHpWzlJdDTO7GjcB7jtLBBtx201moW6VrL9leybwoj30O1m5ILXWzKHAhQ345IiLzb3IN3D7aFE18MDhdlIXgG16sH-ZRE9UGzNinzWTI_F4595w-QJzHwf9jvEgktP1SzwWz0LfdTMAqZ3CplLz2uKp07MspUcIVIPubbnC2LiLPkcp56HybgU9ylCE67kfxXHArGapYrck5-a5_0sW3xGgCuTwws4-2sW09fDs_eE0pdNik9PJE2OM0UH5D5D0Lv05wd--Ahjh2VRp-BZM4X62d8xceMuqn4dVP32T95AdsArjgpBRi4u7lAMPtqRVatPuQ5lnWArcraVs3mt2MRc-9Fihv99xVEtiMGQYL3h6cureBhn8jCKPDLD7YdnuP3LDmX7ff7FmUulc_P8xck7FU9ETFSeUbEUTx590vTjQrv5JhRPTNAzjonVc9cL8hEXbG-poAonnjSBUMBHx29KMEU-R9SyOs8R5PhKQU6-eAgssHy1oN2yWTTibBBcylouhJVzmyJPFB-WzBmW4vwlb2CORjHheBR3oxgL7ibrGV4WMk1wOzPBbboVtAfpiwq3Td6YW0FT5JsFBWIlVXfLTI_ytkMwSmebaB7tCIpJx_6UoCKuEJxidx0CNu1fF-zs_kPQmfxAvhHb-9l6fFUwPiogYTt9aypzLtdz9DWi66yiSpfi7JqF1aiHZo8f-9OC2tMjWG-lYL1eQQXZImjws9gqh13IDTL_SzB8LDtbaFxlLSIeWrka0_OfRZ7xQPsVeVvxuTBX1C3ZnxW06RcK4v_8IXC4jksEO9tlWrOZSvFJvDiNrHCZ4hgQi62cA2Jjdl4q1p59u-AjvJCY-y5T7M8JTrUhwWhSNCH6YV5Kcx8_6BjsR9PPGjxF7ejaeZkDTyY3lefyB_quPf5EXPXjWevKuV4Q6vWCohNKaJSjxhW3YIrkiAk-Ib5YcFnqPMFH2CUNogm8-5oZDuQcNwhitUmw3q2CpuK26SuifHCKaP-u4NDvEqx3t1g9l2A9x72CVvMHQt6TLPvcJ9jzVwTD6q0i9WTFkxDs92GxwEJo3pEdd66HD6U28fyo4nxEUOqPzPhQ5MvFljCcPxWMfx4V3Mpzx8zG-3uI17hk1uyC8_OCpurxKYZ0-uGmIZUUH9JCyveOTEJCj8HMHndbnn6J7qd5iezbIuJWpOVT9Dz38SnNv355_DF6GsSLmacyPxHcl9V0KCMG_tR6UlAQTwlFACVBRWqbYtC2ReZ4eP70Ri0FZ74Pu-AMlvpngd9VM9-H6xmxRVdpjZgDaRJSGOlcxSm4Gu16VtBXvy_Y3r8ICvjiKcCv2TYNS9CVfpielrSfHre1TZGmMrqlz3yG1j1JwShjh2C9vwmFBa43FcfHs7BAlRJzxg5B7pytgk8JaoWegT-lSMNPFRxVzkT-1bDNaG7hmbduE3S3EMzye4p9XFCJLzOPxFlqGInEG4l00RRiPHbtwatnWQdn8K5cy0vezEXVV5RdJBqNSlFBRX5dMK_8uSC-lwv2e5VgvTcEVbFyFjaRLBRMLY4TkpJjnuJwC7boF_M1a4RWQW99RpEfnr0lbemLU4jmyJtNv3IUFc2q9IMQyx56LcG2yU3kLNMlS5YoJarozLBdLrxz4VuCOn-NYL2JrSbbY3_eYHs8U7xSYbHf3cGB3rP7UEJvDN7lmJDTKWsUWzL7QHG9LBbXuO4Rqyc_OIs6fpMJDKX0bZ4Pdr0y_UzObpVcbqEnlu6fvDGbVu7KHreHSPb7s9eV4PqW9GXBmPR7szZ06c6ZX1GQ7pqFd0LungU-7pkFPu6deT4cPxRcePjKjI6FHBKrSPfPAqYPzHwfrn-fvSn70CxA9vAsiP6RWZiyj84CVl-dhT6-NkUf3l3T2NZILptAH1SzXoCWkbd4yKMo6bFZ6eXxfGTSm3vv5ZRfTfGqI33zY_KmbAQ2xYuO0mZzmjv3JEOo6eWmuffNgiQfnHmtd_1w9ozRU9NfnD68aFdt9LUy2u7XzSIs6zCI0MUV4dPmLON4v_F3U2QZfRZb-3lphuvfZi_Q_MGsdVXyJ8GY9lmzoE581wB4CU9QjtcEd750Hsr50pF-In-r0h5FapzxJyvu12b8YaT7W9PvwirN3UwvL3ie3FiguH8x48N3CK7BSa0z__TDI7huKI2alV5-x6D0Mk_p3XWCT1cE98W4X5gFh7V6Fp5sfSh0uIZTt4T8CL3XaCe9W2ObVTBg3znF-Hs90whqevuSalIrryhfXN4Si0RiG7W4Yn9YUFq1gks3tfkAaaEjt5zyzBSLNz3pu-jtGzvolQqWr8Y6FfdbgnreLPjIJCKm1-7mz7yZao7lZirpuxbH0RjeTS5TcoHh_UWclf7l-Z-IvaIj_UAQ13-b9jB96w3DdPKG6blcMLH_0bQP7XEumPqIAbvYLoL2sXhsSEsk8GXixidWJNaHI5HMlo1g5u9wVCt7vhMK0Jf_qiykr2grVFTsTuGa84w1FXt5saq2kGCjZbuZNm2LVgADNblaTUWSW20TJRP2CceEc8I1MWdiZfdgMtavrotoAytTWiIZbJro6lM3aKE1sXgktDyWSEysyFw_1KQm1V3dnRHSZKM6NqaFAhUH2iKx4XC0SR1fEahZUlG5JFARqFlb1qqOah3h0XBSC3XGQtpAMNEA3DdoB1pXRcPJPu0Ke1tiTBskt4dkJswmGvJls6hgNDVKx5Lw9QUTvfgjHh5EUw2Dg0TMB_o6x5Mj4cGeSCoxkNDURCwabDqiQ90wnL9FpKxsRaHOE7aJ8okjJoJ0pG2xVLzZX7u0orInHE1q8SF1UFutxYnc582x_fTbwXWpcCQEVrX2TjVeHqgoJxx1hhN9I1C_DBAHOvs6BgZjG7SoGgVe9s7GETXetDzbzEfnXXT-Q_jfw8GsMVnbo5zys5XZi056tWHiKcD48uZVLQSEYKgs3IWqfVp8gxZHN_FkU_rx9JOdgxE1kWgJR9DNqNbc1Lsq2NQNZOhAmqPAREuUlQd7VvcMJMOjWnzeHMcD32siLXelv5beQy8epgc7BWlD5IsV6fvoSU-70ju6Ugkt1BeJJRMDyxta-8pObmpF-_28i6bak6OJ5NhAZyyaHJkXfnfjpd30VHbdj5e19wLG5uhwJJwYae6Pwwf168XRfHkqTPSlrCxI5L-2B_NaWf1cMKs7Sa2voDzlVDhL_dUdVBJZUFv8gSUVS_yrGkfisdGwNhCOZv8ix4AdWNGRUrMVW_FnefUSfyf0PUKPhSc15s1xLlsWzIO8VgHA5OrH67MnYE3eMHk7uVE7vWOtkuuCjFTXSbDJ1bE8HA11xAbpOWNrK2jyf232nq3MtTL7yY1l-yfvyFwoQ-OV7eXpr5GGJ2_rzPDeo8UHoQhlZ2ZxbVLDkfF54VfnfKu1JWOdmtti8ZC29oRWLWlSfjIJB-KQhZY5Bq6D_tkdzbQyp2T5z4PL1WQyovWrwyvI1D454K-qqm3O_gLf05nXG4toLW3NDR3NvR05homarT2FcjVBo-295WT0D5DLw7KnFNEsLL2zc5iIphdOkWjVeSsxHXpgKMLEiDREw6OqYitrISoRbPJQiWdeVloVTKzWMOfUaH88rEZy07krP2CCbaSTjLp8Qa-WBEsLe3KjG1SJ0mPytVO96EqNriM6b3OUNBH1nxd-xTHYrVe6ng1jZWXtkHlOYl3p-_SXzFnhmx0vrGhXzhQ1qlFU0caSZSdTBLPXFB0Z7gwmelLrIuHB5WRcB7rJlz3xMDnHjoRlDqqJtMGsJs6_qD1rGfrDWtzXk7WuhQumQkGCHQWjI72FxqR7CfCtdCIHQ96OjOas0bT1RHV--OB5K-hXjbFILN4yNFQ7WKHmFKODzDEq-F6IqSvY2tbf0tA80EvdqS1IJUml2GmwUPbO7O-znZAG-trURMMGSIV4i15toxoPJd7vLPTcpl2x4qrBoaHMAP5_"
