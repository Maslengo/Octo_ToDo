local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibIndentation = LibStub("LibIndentation-1.0")
local GLOBAL_TABLE_ITEMS = E.OctoTable_itemID_ItemsUsable_Other
----------------------------------------------------------------
-- Таблица цветовых схем для редактора
E.editorThemes = {
	["Twilight"] = {
		-- ["Special"] = "|cff7587A6", -- спецсимволы (голубоватый)
		["Special"] = "|cff66d9ef", -- спецсимволы (голубой)
		["Keyword"] = "|cffCDA869", -- ключевые слова (золотисто-бежевый)
		["Comment"] = "|cff5F5A60", -- комментарии (серо-фиолетовый)
		["Number"] = "|cffCF6A4C", -- числа (оранжево-красный)
		["String"] = "|cff8F9D6A", -- строки (травянисто-зелёный)
		["Background"] = "|cff141414", -- тёмный фон
		-- ["Foreground"] = "|cffF8F8F2", -- основной текст (не чисто белый, а слегка голубоватый)
		["Function"] = "|cffDAD085", -- функции (жёлто-бежевый)
		["Class"] = "|cff9B703F", -- классы/типы (коричневатый)
		-- ["Operator"] = "|cffF8F8F2", -- операторы (как основной текст)
		-- ["Bracket"] = "|cffF8F8F2", -- скобки (как основной текст)
		["Tag"] = "|cffAC885B", -- теги (коричневатый)
		["Attribute"] = "|cff7587A6", -- атрибуты (голубоватый)
		["Constant"] = "|cffCF6A4C", -- константы (оранжево-красный)
		["Error"] = "|cffCF6A4C", -- ошибки (оранжево-красный)
	},
	["Standard"] = {
		["Special"] = "|c00ff3333", -- спецсимволы (ярко-красный)
		["Keyword"] = "|c004444ff", -- ключевые слова (синий)
		["Comment"] = "|c0000aa00", -- комментарии (зелёный)
		["Number"] = "|c00ff9900", -- числа (оранжевый)
		["String"] = "|c00999999", -- строки (серый)
	},
	["Obsidian"] = {
		["Special"] = "|c00AFC0E5", -- спецсимволы (голубой)
		["Keyword"] = "|c0093C763", -- ключевые слова (зелёный)
		["Comment"] = "|c0066747B", -- комментарии (серо-голубой)
		["Number"] = "|c00FFCD22", -- числа (жёлтый)
		["String"] = "|c00EC7600", -- строки (оранжевый)
	},
	["Monokai"] = {
		["Special"] = "|c0066d9ef", -- спецсимволы (бирюзовый)
		["Keyword"] = "|c00f92672", -- ключевые слова (розовый)
		["Comment"] = "|c0075715e", -- комментарии (серо-коричневый)
		["Number"] = "|c00ae81ff", -- числа (фиолетовый)
		["String"] = "|c00e6db74", -- строки (жёлтый)
	},
	["Sublime"] = {
		["Special"] = "|cff66d9ef", -- спецсимволы (голубой)
		["Keyword"] = "|cffF9EE98", -- ключевые слова (светло-жёлтый)
		["Comment"] = "|cff605A60", -- комментарии (серо-фиолетовый)
		["Number"] = "|cffCF6137", -- числа (красно-оранжевый)
		["String"] = "|cff829D61", -- строки (зелёный)
	},
}
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
		[".."] = theme["Operator"], -- конкатенация строк
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
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
----------------------------------------------------------------
-- Константы цвета
----------------------------------------------------------------
local backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
local borderColorR, borderColorG, borderColorB, borderColorA = 0, 0, 0, 1
local textR, textG, textB, textA = 1, 1, 1, 1
local classR, classG, classB = GetClassColor(E.classFilename)
local function CreateMyAddonEditFrameTemplate(frameName, parent)
	-- Создаем основной фрейм
	local frame = CreateFrame("BUTTON", frameName, parent, "DialogBoxFrame")
	-- E.func_RegisterFrame(frame)
	-- local width = E.PHYSICAL_SCREEN_WIDTH/3
	-- local height = E.PHYSICAL_SCREEN_HEIGHT/1.5
	local width = E.PHYSICAL_SCREEN_WIDTH/2
	local height = E.PHYSICAL_SCREEN_HEIGHT/2
	frame:SetSize(width, height)
	frame:SetResizable(true)
	frame:SetDontSavePosition(true)
	frame:SetClampedToScreen(true)
	frame:Hide()
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForClicks("RightButtonUp")
	frame:SetScript("OnClick", frame.Hide)
	-- Настройка backdrop
	frame:SetBackdrop(E.menuBackdrop)
	frame:SetBackdropColor(backgroundColorR, backgroundColorG, backgroundColorB, backgroundColorA)
	frame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Создаем скроллбар
	frame.scrollBar = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	frame.scrollBar:SetPoint("TOPRIGHT", 14, 0)
	frame.scrollBar:SetPoint("BOTTOMRIGHT", 14, 0)
	-- Создаем edit frame
	frame.editFrame = CreateFrame("Frame", nil, frame, "BackdropTemplate, ScrollingEditBoxTemplate")
	frame.editFrame:SetPoint("TOPLEFT", 20, -20)
	frame.editFrame:SetPoint("BOTTOMRIGHT", -20, 60)
	-- Настройка backdrop для editFrame
	frame.editFrame:SetBackdrop(E.menuBackdrop)
	frame.editFrame:SetBackdropColor(25/255, 25/255, 35/255, 1)
	frame.editFrame:SetBackdropBorderColor(borderColorR, borderColorG, borderColorB, borderColorA)
	-- Кнопка изменения размера
	frame.resize = CreateFrame("Button", nil, frame)
	frame.resize:SetSize(16, 16)
	frame.resize:SetPoint("BOTTOMRIGHT", 0, 0)
	frame.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	frame.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	frame.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	frame.resize:RegisterForDrag("LeftButton")
	-- LINE
	frame.lineText = frame:CreateFontString()
	frame.lineText:SetFontObject(OctoFont11)
	frame.lineText:SetPoint("BOTTOMLEFT", 20, 20)
	frame.lineText:SetText(L["Line"])
	-- HZ
	frame.HZ = CreateFrame("Editbox", nil, frame, "InputBoxTemplate")
	frame.HZ:Hide()
	-- Настройка скроллинга
	local scrollBox = frame.editFrame:GetScrollBox()
	scrollBox:SetAllPoints(frame.editFrame)
	ScrollUtil.RegisterScrollBoxWithScrollBar(scrollBox, frame.scrollBar)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollBox, frame.scrollBar)
	-- Настройка edit box
	local editBox = frame.editFrame:GetEditBox()
	editBox:HookScript("OnEnterPressed", function(self) self:Insert("\n") end)
	editBox:HookScript("OnEscapePressed", function(self) self:ClearFocus() end)
	if Octo_DevTool_DB then
		editBox:SetFont(E.Octo_font, Octo_DevTool_DB.editorFontSize, "")
	else
		editBox:SetFont(E.Octo_font, 11, "")
	end
	editBox:HookScript("OnCursorChanged", function(editBox)
			local text = frame.HZ.GetText(editBox)
			local pos = editBox:GetCursorPosition()
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
			frame.lineText:SetText(L["Line"]..": "..line.."/"..totalLines)
	end)
	-- Обработчики перемещения фрейма
	frame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				frame:SetAlpha(Octo_DevTool_DB.Config_AlphaOnTheMove or E.backgroundColorA)
				frame:StartMoving()
			end
	end)
	frame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				frame:SetAlpha(1)
				frame:StopMovingOrSizing()
			end
	end)
	-- Обработчик нажатия клавиш
	frame:SetScript("OnKeyDown", function(self, key)
			if not InCombatLockdown() then
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
			end
	end)
	-- Минимальные размеры фрейма (нельзя сделать меньше)
	local MIN_WIDTH = 400 -- Минимальная ширина
	local MIN_HEIGHT = 300 -- Минимальная высота
	-- Переменная для отслеживания, изменяем ли мы размер
	local isResizing = false
	frame.resize:SetScript("OnDragStart", function(self)
			isResizing = true
			self:GetParent():StartSizing("BOTTOMRIGHT", true)
			self:GetParent():SetAlpha(Octo_DevTool_DB.Config_AlphaOnTheMove or E.backgroundColorA)
	end)
	frame.resize:SetScript("OnDragStop", function(self)
			isResizing = false
			self:GetParent():StopMovingOrSizing()
			self:GetParent():SetAlpha(1)
	end)
	-- Проверка размера в реальном времени (OnUpdate)
	frame:SetScript("OnUpdate", function(self, elapsed)
			if isResizing then
				local currentWidth, currentHeight = self:GetSize()
				if currentWidth < MIN_WIDTH or currentHeight < MIN_HEIGHT then
					-- Принудительно устанавливаем минимальный размер
					self:SetSize(
						math.max(currentWidth, MIN_WIDTH),
						math.max(currentHeight, MIN_HEIGHT)
					)
				end
			end
	end)
	return frame
end
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
-- Создаем фрейм для редактирования текста
local editFrame = CreateMyAddonEditFrameTemplate("editFrame", UIParent)
-- E.func_RegisterFrame(editFrame)
editFrame:ClearAllPoints()
editFrame:SetPoint("CENTER")
local editBox = editFrame.editFrame
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
-- Функция для форматированного вывода таблиц
local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do
		indentStr = indentStr.." "
	end
	for k, v in next, (msg) do
		k = (type(k) == "number" and "["..k.."]" or type(k) == "string" and '["'..k..'"]' or tostringall(k)).." ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			str = ("%s%s%s {\n"):format(str, indentStr, k)
			str = str..dumpEdit(indent + 1, v, tables)
			str = ("%s%s},\n"):format(str, indentStr)
		else
			local vtype = type(v)
			v = vtype == "string" and '"'..v:gsub("[\"\\]", "\\%1")..'"' or vtype == "number" and v or '"'..tostringall(v)..'"'
			str = ("%s%s%s %s,\n"):format(str, indentStr, k, v)
		end
	end
	if indent == 0 then
		LibIndentation.enable(editBox:GetEditBox(), E.func_createColorScheme(Octo_DevTool_DB.editorTheme or "Twilight"), Octo_DevTool_DB.editorTabSpaces) -- 4 - ширина табуляции в пробелах
		editBox:SetText(str)
		LibIndentation.indentEditbox(editBox:GetEditBox())
		editFrame:Show()
	else
		return str
	end
end
-- Обработчик сообщений для вывода в чат
local LOCAL_OPrintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E.func_Gradient(GlobalAddonName..": ")
		for i = 1, indent do
			indentStr = indentStr.." "
		end
		for k, v in next, (msg) do
			k = "["..tostringall(k).."] ="
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
	local message = strjoin(" ", E.func_Gradient(GlobalAddonName..": "), tostringall(...))
	local mFrame = DEFAULT_CHAT_FRAME
	local i = 1
	repeat
		local frame = _G["ChatFrame"..i]
		if frame and frame:IsShown() then
			mFrame = frame
			break
		end
		i = i + 1
	until not frame
	mFrame:AddMessage(message)
	local first = select(1, ...)
	if first == "dump" or first == "dump1" then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		sendMessage(mFrame, 0, msg, first ~= "dump1")
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
	local ok, err = pcall(LOCAL_OPrintHandler, ...)
	if not ok then
		geterrorhandler()(err)
	end
end
-- Глобальные команды для дампа
dump = "dump"
dump1 = "dump1"
dumpe = "dumpe"
-- Функции для удобного вызова
if not oprint then function oprint(...) securecall(pcall, oprint_inner, ...) end end
if not opd then function opd(...) oprint(dump, ...) end end
if not opd1 then function opd1(...) oprint(dump1, ...) end end
if not opde then function opde(...) oprint(dumpe, ...) end end
-- Регистрация slash-команды /oprint
SLASH_OPRINT1 = "/oprint"
SlashCmdList["OPRINT"] = function(msg)
	local f, err = loadstring("return "..msg)
	if err then
		oprint(err:gsub("\"return ", "\""))
		return
	end
	local status, value = pcall(f)
	if status then
		oprint(dumpe, value)
	else
		oprint(value:gsub("\"return ", "\""))
	end
end
-- Функции для работы со списками
function EventFrame:func_itemslist(msg)
	local str = ""
	local list1, list2 = {}, {}
	local promise1 = LibThingsLoad:Items(GLOBAL_TABLE_ITEMS)
	:ThenForAllWithCached(function(_, ids1) tinsert(list1, ids1) end)
	:FailWithChecked(function(_, ids2) tinsert(list2, ids2) end)
	:Then(function()
			sort(list1, E.func_ReversSort)
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..E.func_GetItemName(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..E.func_GetItemName(id2).."\n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
function EventFrame:func_itemslistSort24(msg)
	local startTime = debugprofilestop()
	editFrame:SetScript("OnShow", function()
		local executionTime = (debugprofilestop() - startTime)
		print (executionTime)
	end)
	----------------------------------------------------------------
	-------------------------- СРЕДНЕЕ 15500ms ---------------------
	----------------------------------------------------------------
	-- local str = ""
	-- local list1, list2 = {}, {}
	-- local promise1 = LibThingsLoad:Items(GLOBAL_TABLE_ITEMS)
	-- :ThenForAllWithCached(function(_, ids1) tinsert(list1, ids1) end)
	-- :FailWithChecked(function(_, ids2) tinsert(list2, ids2) end)
	-- local count = 0
	-- promise1:Then(function()
	-- sort(list1, E.func_ReversSort)
	-- for _, id1 in next, (list1) do
	-- count = count + 1
	-- if count < 24 then
	-- str = str..id1..", "
	-- else
	-- count = 0
	-- str = str..id1..", |n"
	-- end
	-- end
	-- for _, id2 in next, (list2) do
	-- str = str..id2..", -- UNKNOWN|n"
	-- end
	-- editBox:SetText(str)
	-- editFrame:Show()
	-- end)
	----------------------------------------------------------------
	-------------------------- СРЕДНЕЕ 80ms ------------------------
	----------------------------------------------------------------
	-- E.func_TableRemoveDuplicates(GLOBAL_TABLE_ITEMS)
	-- table.sort(GLOBAL_TABLE_ITEMS, E.func_ReversSort)
	-- local output, count = "", 0
	-- for _, itemID in ipairs(GLOBAL_TABLE_ITEMS) do
	-- count = count + 1
	-- if count < 24 then
	-- output = output .. itemID..", "
	-- else
	-- count = 0
	-- output = output .. itemID..",|n"
	-- end
	-- end
	-- editBox:SetText(output)
	-- editFrame:Show()
	----------------------------------------------------------------
	-------------------------- СРЕДНЕЕ 32ms ------------------------
	----------------------------------------------------------------
	if not tbl then
		tbl = GLOBAL_TABLE_ITEMS
	end
	print (tbl)
	E.func_TableRemoveDuplicates(tbl)
	table.sort(tbl, E.func_ReversSort)
	local chunks = {}
	local chunk_size = 24
	local count = #tbl
	for i = 1, count, chunk_size do
		local chunk = {}
		local last = math.min(i + chunk_size - 1, count)
		for j = i, last do
			table.insert(chunk, tostring(tbl[j]))
		end
		table.insert(chunks, table.concat(chunk, ", "))
	end
	editBox:SetText(table.concat(chunks, ",|n"))
	editFrame:Show()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
function EventFrame:func_itemslistSortBOOLEN(msg)
	local str = ""
	local list1, list2 = {}, {}
	local tbl = {}
	for k, v in next, (GLOBAL_TABLE_ITEMS) do
		tinsert(tbl, k)
	end
	local promise1 = LibThingsLoad:Items(tbl)
	:ThenForAllWithCached(function(_, ids1) tinsert(list1, ids1) end)
	:FailWithChecked(function(_, ids2) tinsert(list2, ids2) end)
	local count = 0
	promise1:Then(function()
			sort(list1, E.func_ReversSort)
			for _, id1 in next, (list1) do
				count = count + 1
				if count < 8 then
					str = str.."["..id1.."] = true, "
				else
					count = 0
					str = str.."["..id1.."] = true, |n"
				end
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- UNKNOWN|n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
function EventFrame:func_questslist(msg)
	local str = ""
	local list1, list2 = {}, {}
	local promise2 = LibThingsLoad:Quests(E.OctoTable_QuestID_Paragon)
	:ThenForAllWithCached(function(_, ids1) tinsert(list1, ids1) end)
	sort(list1, E.func_ReversSort)
	promise2:FailWithChecked(function(_, ids2) tinsert(list2, ids2) end)
	sort(list2, E.func_ReversSort)
	promise2:Then(function()
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..E.func_GetQuestName(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..E.func_GetQuestName(id2).."\n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
function EventFrame:func_currencieslist(msg)
	local str1 = ""
	local str2 = ""
	local output = ""
	local list = {}
	for currencyID, cachedName in next, (Octo_Cache_DB.AllCurrencies) do
		tinsert(list, currencyID)
	end
	sort(list, E.func_ReversSort)
	for _, currencyID in ipairs(list) do
		if E.func_GetCurrencyName(currencyID) ~= (currencyID.. " (UNKNOWN)") then
			str1 = str1..currencyID..", --" ..E.func_GetCurrencyName(currencyID).."|n"
		else
			str2 = str2..currencyID..", --" ..E.func_GetCurrencyName(currencyID).."|n"
		end
	end
	output = str1..str2
	editBox:SetText(output)
	editFrame:Show()
end
function EventFrame:func_reputationslist(msg)
	local str4 = ""
	local str5 = ""
	local output = ""
	local list = {}
	for _, reputationID in next, (E.OctoTable_allfaction) do
		tinsert(list, reputationID)
	end
	sort(list, E.func_ReversSort)
	for _, reputationID in next, (list) do
		if E.func_GetReputationName(reputationID) ~= (reputationID.. " (UNKNOWN)") then
			str4 = str4..reputationID..", --" ..E.func_GetReputationName(reputationID).."|n"
		else
			str5 = str5..reputationID..", --" ..E.func_GetReputationName(reputationID).."|n"
		end
	end
	output = str4..str5
	editBox:SetText(output)
	editFrame:Show()
end
function EventFrame:func_spellslist(msg)
	local str4 = ""
	local str5 = ""
	local output = ""
	local list = {}
	for intexRow, tbl in next, (E.OctoTable_Portals) do
		for spellID, v in next, (tbl) do
			tinsert(list, spellID)
		end
	end
	sort(list, E.func_ReversSort)
	for _, spellID in next, (list) do
		if E.func_spellNameFull(spellID) ~= "|cffFF4C4F"..SEARCH_LOADING_TEXT.."|r" then
			str4 = str4..spellID..", --" ..E.func_spellNameFull(spellID).."\n"
		else
			str5 = str5..spellID..", --" ..E.func_spellNameFull(spellID).."\n"
		end
	end
	output = str4..str5
	editBox:SetText(output)
	editFrame:Show()
end
-- Обработчик команд для /op
local function func_HandleCommand(msg)
	local command, arg1, arg2 = strsplit(" ", msg, 3)
	if (command == "quest" or command == "2") then
		EventFrame:func_questslist(arg1)
	elseif (command == "currency" or command == "3") then
		EventFrame:func_currencieslist(arg1)
	elseif (command == "rep" or command == "4") then
		EventFrame:func_reputationslist(arg1)
	elseif (command == "spell" or command == "5") then
		EventFrame:func_spellslist(arg1)
	elseif (command == "item2" or command == "6") then
		EventFrame:func_itemslistSort24(arg1)
	elseif (command == "item3" or command == "7") then
		EventFrame:func_itemslistSortBOOLEN(arg1)
	else
		DEFAULT_CHAT_FRAME:AddMessage("Команды:")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."quest".." (2)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."currency".." (3)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."rep".." (4)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."spell".." (5)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."item2".." (6)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."item3".." (7)")
	end
end
-- Регистрация slash-команды /op
SLASH_OCTOLIST1 = "/fp"
SlashCmdList["OCTOLIST"] = func_HandleCommand
-- Дополнительные slash-команды
local slashCommands = {
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color.."GSEARCH:|r "..msg)
			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str..color..i.."|r - "..n.."\n"
				end
			end
			editBox:SetText(str)
			editFrame:Show()
		end
	}
}
-- Регистрация всех slash-команд
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_"..name..i] = cmd
	end
end
-- Регистрация событий
local MyEventsTable = {
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
-- Обработчик события VARIABLES_LOADED
function EventFrame:VARIABLES_LOADED()
	-- E.func_CreateMinimapButton(GlobalAddonName, "Debug", Octo_DevTool_DB)
end
function EventFrame:PLAYER_LOGIN()
	E.func_Create_DDframe_editFrame(editFrame, E.COLOR_BLUE, nil)
end