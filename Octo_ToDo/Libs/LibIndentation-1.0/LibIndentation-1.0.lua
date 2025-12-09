local revision = 24
local MAJOR_VERSION, MINOR_VERSION = "LibIndentation-1.0", revision
local lib, oldminor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

-- Локальные ссылки на функции string для оптимизации
local next = next
local stringlen = string.len
local stringformat = string.format
local stringfind = string.find
local stringsub = string.sub
local stringbyte = string.byte
local stringchar = string.char
local stringrep = string.rep
local stringgsub = string.gsub

-- Настройки по умолчанию
local defaultTabWidth = 4
local defaultColorTable
local workingTable = {} -- Рабочие таблицы для временного хранения данных
local workingTable2 = {}

-- Инициализация библиотеки
if not lib._listener then
	-- Функция для очистки таблицы
	local function tableclear(t)
		for k in next, (t) do
			t[k] = nil
		end
	end

	-- Вставка строки в указанную позицию
	local function stringinsert(s, pos, insertStr)
		return stringsub(s, 1, pos) .. insertStr .. stringsub(s, pos + 1)
	end
	lib.stringinsert = stringinsert

	-- Удаление части строки между позициями
	local function stringdelete(s, pos1, pos2)
		return stringsub(s, 1, pos1 - 1) .. stringsub(s, pos2 + 1)
	end
	lib.stringdelete = stringdelete

	-- Определение типов токенов
	local tokens = {}
	lib.tokens = tokens
	tokens.TOKEN_UNKNOWN = 0
	tokens.TOKEN_NUMBER = 1
	tokens.TOKEN_LINEBREAK = 2
	tokens.TOKEN_WHITESPACE = 3
	tokens.TOKEN_IDENTIFIER = 4
	tokens.TOKEN_ASSIGNMENT = 5
	tokens.TOKEN_EQUALITY = 6
	tokens.TOKEN_MINUS = 7
	tokens.TOKEN_COMMENT_SHORT = 8
	tokens.TOKEN_COMMENT_LONG = 9
	tokens.TOKEN_STRING = 10
	tokens.TOKEN_LEFTBRACKET = 11
	tokens.TOKEN_PERIOD = 12
	tokens.TOKEN_DOUBLEPERIOD = 13
	tokens.TOKEN_TRIPLEPERIOD = 14
	tokens.TOKEN_LTE = 15
	tokens.TOKEN_LT = 16
	tokens.TOKEN_GTE = 17
	tokens.TOKEN_GT = 18
	tokens.TOKEN_NOTEQUAL = 19
	tokens.TOKEN_COMMA = 20
	tokens.TOKEN_SEMICOLON = 21
	tokens.TOKEN_COLON = 22
	tokens.TOKEN_LEFTPAREN = 23
	tokens.TOKEN_RIGHTPAREN = 24
	tokens.TOKEN_PLUS = 25
	tokens.TOKEN_SLASH = 27
	tokens.TOKEN_LEFTWING = 28
	tokens.TOKEN_RIGHTWING = 29
	tokens.TOKEN_CIRCUMFLEX = 30
	tokens.TOKEN_ASTERISK = 31
	tokens.TOKEN_RIGHTBRACKET = 32
	tokens.TOKEN_KEYWORD = 33
	tokens.TOKEN_SPECIAL = 34
	tokens.TOKEN_VERTICAL = 35
	tokens.TOKEN_TILDE = 36
	tokens.TOKEN_COLORCODE_START = 37
	tokens.TOKEN_COLORCODE_STOP = 38
	tokens.TOKEN_HASH = 39
	tokens.TOKEN_PERCENT = 40

	-- Таблица байтовых значений символов
	local bytes = {}
	lib.bytes = bytes
	bytes.BYTE_LINEBREAK_UNIX = stringbyte("\n")
	bytes.BYTE_LINEBREAK_MAC = stringbyte("\r")
	bytes.BYTE_SINGLE_QUOTE = stringbyte("'")
	bytes.BYTE_DOUBLE_QUOTE = stringbyte('"')
	bytes.BYTE_0 = stringbyte("0")
	bytes.BYTE_9 = stringbyte("9")
	bytes.BYTE_PERIOD = stringbyte(".")
	bytes.BYTE_SPACE = stringbyte(" ")
	bytes.BYTE_TAB = stringbyte("\t")
	bytes.BYTE_E = stringbyte("E")
	bytes.BYTE_e = stringbyte("e")
	bytes.BYTE_MINUS = stringbyte("-")
	bytes.BYTE_EQUALS = stringbyte("=")
	bytes.BYTE_LEFTBRACKET = stringbyte("[")
	bytes.BYTE_RIGHTBRACKET = stringbyte("]")
	bytes.BYTE_BACKSLASH = stringbyte("\\")
	bytes.BYTE_COMMA = stringbyte(",")
	bytes.BYTE_SEMICOLON = stringbyte(";")
	bytes.BYTE_COLON = stringbyte(":")
	bytes.BYTE_LEFTPAREN = stringbyte("(")
	bytes.BYTE_RIGHTPAREN = stringbyte(")")
	bytes.BYTE_TILDE = stringbyte("~")
	bytes.BYTE_PLUS = stringbyte("+")
	bytes.BYTE_SLASH = stringbyte("/")
	bytes.BYTE_LEFTWING = stringbyte("{")
	bytes.BYTE_RIGHTWING = stringbyte("}")
	bytes.BYTE_CIRCUMFLEX = stringbyte("^")
	bytes.BYTE_ASTERISK = stringbyte("*")
	bytes.BYTE_LESSTHAN = stringbyte("<")
	bytes.BYTE_GREATERTHAN = stringbyte(">")
	bytes.BYTE_VERTICAL = stringbyte("|")
	bytes.BYTE_r = stringbyte("r")
	bytes.BYTE_c = stringbyte("c")
	bytes.BYTE_HASH = stringbyte("#")
	bytes.BYTE_PERCENT = stringbyte("%")

	-- Таблицы для классификации символов
	local linebreakCharacters = {}
	lib.linebreakCharacters = linebreakCharacters
	linebreakCharacters[bytes.BYTE_LINEBREAK_UNIX] = 1
	linebreakCharacters[bytes.BYTE_LINEBREAK_MAC] = 1

	local whitespaceCharacters = {}
	lib.whitespaceCharacters = whitespaceCharacters
	whitespaceCharacters[bytes.BYTE_SPACE] = 1
	whitespaceCharacters[bytes.BYTE_TAB] = 1

	local specialCharacters = {}
	lib.specialCharacters = specialCharacters
	specialCharacters[bytes.BYTE_PERIOD] = -1
	specialCharacters[bytes.BYTE_LESSTHAN] = -1
	specialCharacters[bytes.BYTE_GREATERTHAN] = -1
	specialCharacters[bytes.BYTE_LEFTBRACKET] = -1
	specialCharacters[bytes.BYTE_EQUALS] = -1
	specialCharacters[bytes.BYTE_MINUS] = -1
	specialCharacters[bytes.BYTE_SINGLE_QUOTE] = -1
	specialCharacters[bytes.BYTE_DOUBLE_QUOTE] = -1
	specialCharacters[bytes.BYTE_TILDE] = -1
	specialCharacters[bytes.BYTE_RIGHTBRACKET] = tokens.TOKEN_RIGHTBRACKET
	specialCharacters[bytes.BYTE_COMMA] = tokens.TOKEN_COMMA
	specialCharacters[bytes.BYTE_COLON] = tokens.TOKEN_COLON
	specialCharacters[bytes.BYTE_SEMICOLON] = tokens.TOKEN_SEMICOLON
	specialCharacters[bytes.BYTE_LEFTPAREN] = tokens.TOKEN_LEFTPAREN
	specialCharacters[bytes.BYTE_RIGHTPAREN] = tokens.TOKEN_RIGHTPAREN
	specialCharacters[bytes.BYTE_PLUS] = tokens.TOKEN_PLUS
	specialCharacters[bytes.BYTE_SLASH] = tokens.TOKEN_SLASH
	specialCharacters[bytes.BYTE_LEFTWING] = tokens.TOKEN_LEFTWING
	specialCharacters[bytes.BYTE_RIGHTWING] = tokens.TOKEN_RIGHTWING
	specialCharacters[bytes.BYTE_CIRCUMFLEX] = tokens.TOKEN_CIRCUMFLEX
	specialCharacters[bytes.BYTE_ASTERISK] = tokens.TOKEN_ASTERISK
	specialCharacters[bytes.BYTE_VERTICAL] = -1
	specialCharacters[bytes.BYTE_HASH] = tokens.TOKEN_HASH
	specialCharacters[bytes.BYTE_PERCENT] = tokens.TOKEN_PERCENT

	-- Функции для разбора чисел
	local function nextNumberExponentPartInt(text, pos)
		while true do
			local byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_NUMBER, pos
			end
			if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
				pos = pos + 1
			else
				return tokens.TOKEN_NUMBER, pos
			end
		end
	end

	local function nextNumberExponentPart(text, pos)
		local byte = stringbyte(text, pos)
		if not byte then
			return tokens.TOKEN_NUMBER, pos
		end
		if byte == bytes.BYTE_MINUS then
			byte = stringbyte(text, pos + 1)
			if byte == bytes.BYTE_MINUS then
				return tokens.TOKEN_NUMBER, pos
			end
			return nextNumberExponentPartInt(text, pos + 1)
		end
		return nextNumberExponentPartInt(text, pos)
	end

	local function nextNumberFractionPart(text, pos)
		while true do
			local byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_NUMBER, pos
			end
			if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
				pos = pos + 1
			elseif byte == bytes.BYTE_E or byte == bytes.BYTE_e then
				return nextNumberExponentPart(text, pos + 1)
			else
				return tokens.TOKEN_NUMBER, pos
			end
		end
	end

	local function nextNumberIntPart(text, pos)
		while true do
			local byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_NUMBER, pos
			end
			if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
				pos = pos + 1
			elseif byte == bytes.BYTE_PERIOD then
				return nextNumberFractionPart(text, pos + 1)
			elseif byte == bytes.BYTE_E or byte == bytes.BYTE_e then
				return nextNumberExponentPart(text, pos + 1)
			else
				return tokens.TOKEN_NUMBER, pos
			end
		end
	end

	-- Разбор идентификаторов
	local function nextIdentifier(text, pos)
		while true do
			local byte = stringbyte(text, pos)
			if not byte or
			linebreakCharacters[byte] or
			whitespaceCharacters[byte] or
			specialCharacters[byte] then
				return tokens.TOKEN_IDENTIFIER, pos
			end
			pos = pos + 1
		end
	end

	-- Разбор строк в квадратных скобках
	local function isBracketStringNext(text, pos)
		local byte = stringbyte(text, pos)
		if byte == bytes.BYTE_LEFTBRACKET then
			local pos2 = pos + 1
			byte = stringbyte(text, pos2)
			while byte == bytes.BYTE_EQUALS do
				pos2 = pos2 + 1
				byte = stringbyte(text, pos2)
			end
			if byte == bytes.BYTE_LEFTBRACKET then
				return true, pos2 + 1, (pos2 - 1) - pos
			else
				return false
			end
		else
			return false
		end
	end

	local function nextBracketString(text, pos, equalsCount)
		local state = 0
		while true do
			local byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_STRING, pos
			end
			if byte == bytes.BYTE_RIGHTBRACKET then
				if state == 0 then
					state = 1
				elseif state == equalsCount + 1 then
					return tokens.TOKEN_STRING, pos + 1
				else
					state = 0
				end
			elseif byte == bytes.BYTE_EQUALS then
				if state > 0 then
					state = state + 1
				end
			else
				state = 0
			end
			pos = pos + 1
		end
	end

	-- Разбор комментариев
	local function nextComment(text, pos)
		local isBracketString, nextPos, equalsCount = isBracketStringNext(text, pos)
		if isBracketString then
			local tokenType, nextPos2 = nextBracketString(text, nextPos, equalsCount)
			return tokens.TOKEN_COMMENT_LONG, nextPos2
		end
		local byte = stringbyte(text, pos)
		while true do
			byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_COMMENT_SHORT, pos
			end
			if linebreakCharacters[byte] then
				return tokens.TOKEN_COMMENT_SHORT, pos
			end
			pos = pos + 1
		end
	end

	-- Разбор строк в кавычках
	local function nextString(text, pos, character)
		local even = true
		while true do
			local byte = stringbyte(text, pos)
			if not byte then
				return tokens.TOKEN_STRING, pos
			end
			if byte == character then
				if even then
					return tokens.TOKEN_STRING, pos + 1
				end
			end
			if byte == bytes.BYTE_BACKSLASH then
				even = not even
			else
				even = true
			end
			pos = pos + 1
		end
	end

	-- Основная функция токенизации
	local function nextToken(text, pos)
		local byte = stringbyte(text, pos)
		if not byte then
			return nil
		end
		if linebreakCharacters[byte] then
			return tokens.TOKEN_LINEBREAK, pos + 1
		end
		if whitespaceCharacters[byte] then
			while true do
				pos = pos + 1
				byte = stringbyte(text, pos)
				if not byte or not whitespaceCharacters[byte] then
					return tokens.TOKEN_WHITESPACE, pos
				end
			end
		end
		local token = specialCharacters[byte]
		if token then
			if token ~= -1 then
				return token, pos + 1
			end
			if byte == bytes.BYTE_VERTICAL then
				byte = stringbyte(text, pos + 1)
				if byte == bytes.BYTE_VERTICAL then
					return tokens.TOKEN_VERTICAL, pos + 2
				end
				if byte == bytes.BYTE_c then
					return tokens.TOKEN_COLORCODE_START, pos + 10
				end
				if byte == bytes.BYTE_r then
					return tokens.TOKEN_COLORCODE_STOP, pos + 2
				end
				return tokens.TOKEN_UNKNOWN, pos + 1
			end
			if byte == bytes.BYTE_MINUS then
				byte = stringbyte(text, pos + 1)
				if byte == bytes.BYTE_MINUS then
					return nextComment(text, pos + 2)
				end
				return tokens.TOKEN_MINUS, pos + 1
			end
			if byte == bytes.BYTE_SINGLE_QUOTE then
				return nextString(text, pos + 1, bytes.BYTE_SINGLE_QUOTE)
			end
			if byte == bytes.BYTE_DOUBLE_QUOTE then
				return nextString(text, pos + 1, bytes.BYTE_DOUBLE_QUOTE)
			end
			if byte == bytes.BYTE_LEFTBRACKET then
				local isBracketString, nextPos, equalsCount = isBracketStringNext(text, pos)
				if isBracketString then
					return nextBracketString(text, nextPos, equalsCount)
				else
					return tokens.TOKEN_LEFTBRACKET, pos + 1
				end
			end
			if byte == bytes.BYTE_EQUALS then
				byte = stringbyte(text, pos + 1)
				if not byte then
					return tokens.TOKEN_ASSIGNMENT, pos + 1
				end
				if byte == bytes.BYTE_EQUALS then
					return tokens.TOKEN_EQUALITY, pos + 2
				end
				return tokens.TOKEN_ASSIGNMENT, pos + 1
			end
			if byte == bytes.BYTE_PERIOD then
				byte = stringbyte(text, pos + 1)
				if not byte then
					return tokens.TOKEN_PERIOD, pos + 1
				end
				if byte == bytes.BYTE_PERIOD then
					byte = stringbyte(text, pos + 2)
					if byte == bytes.BYTE_PERIOD then
						return tokens.TOKEN_TRIPLEPERIOD, pos + 3
					end
					return tokens.TOKEN_DOUBLEPERIOD, pos + 2
				elseif byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
					return nextNumberFractionPart(text, pos + 2)
				end
				return tokens.TOKEN_PERIOD, pos + 1
			end
			if byte == bytes.BYTE_LESSTHAN then
				byte = stringbyte(text, pos + 1)
				if byte == bytes.BYTE_EQUALS then
					return tokens.TOKEN_LTE, pos + 2
				end
				return tokens.TOKEN_LT, pos + 1
			end
			if byte == bytes.BYTE_GREATERTHAN then
				byte = stringbyte(text, pos + 1)
				if byte == bytes.BYTE_EQUALS then
					return tokens.TOKEN_GTE, pos + 2
				end
				return tokens.TOKEN_GT, pos + 1
			end
			if byte == bytes.BYTE_TILDE then
				byte = stringbyte(text, pos + 1)
				if byte == bytes.BYTE_EQUALS then
					return tokens.TOKEN_NOTEQUAL, pos + 2
				end
				return tokens.TOKEN_TILDE, pos + 1
			end
			return tokens.TOKEN_UNKNOWN, pos + 1
		elseif byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
			return nextNumberIntPart(text, pos + 1)
		else
			return nextIdentifier(text, pos + 1)
		end
	end

	-- Таблицы для управления отступами
	local noIndentEffect = {0, 0}
	local indentLeft = {-1, 0}
	local indentRight = {0, 1}
	local indentBoth = {-1, 1}

	-- Ключевые слова Lua и их влияние на отступы
	local keywords = {}
	lib.keywords = keywords
	keywords["and"] = noIndentEffect
	keywords["break"] = noIndentEffect
	keywords["false"] = noIndentEffect
	keywords["for"] = noIndentEffect
	keywords["if"] = noIndentEffect
	keywords["in"] = noIndentEffect
	keywords["local"] = noIndentEffect
	keywords["nil"] = noIndentEffect
	keywords["not"] = noIndentEffect
	keywords["or"] = noIndentEffect
	keywords["return"] = noIndentEffect
	keywords["true"] = noIndentEffect
	keywords["while"] = noIndentEffect
	keywords["until"] = indentLeft
	keywords["elseif"] = indentLeft
	keywords["end"] = indentLeft
	keywords["do"] = indentRight
	keywords["then"] = indentRight
	keywords["repeat"] = indentRight
	keywords["function"] = indentRight
	keywords["else"] = indentBoth

	-- Влияние токенов на отступы
	local tokenIndentation = {}
	lib.tokenIndentation = tokenIndentation
	tokenIndentation[tokens.TOKEN_LEFTPAREN] = indentRight
	tokenIndentation[tokens.TOKEN_LEFTBRACKET] = indentRight
	tokenIndentation[tokens.TOKEN_LEFTWING] = indentRight
	tokenIndentation[tokens.TOKEN_RIGHTPAREN] = indentLeft
	tokenIndentation[tokens.TOKEN_RIGHTBRACKET] = indentLeft
	tokenIndentation[tokens.TOKEN_RIGHTWING] = indentLeft

	-- Функции для создания отступов
	local function fillWithTabs(n)
		return stringrep("\t", n)
	end

	local function fillWithSpaces(a, b)
		return stringrep(" ", a*b)
	end

	-- Функция для подсветки кода цветами
	function lib.colorCodeCode(code, colorTable, caretPosition)
		local stopColor = colorTable and colorTable[0]
		if not stopColor then
			return code, caretPosition
		end
		local stopColorLen = stringlen(stopColor)
		tableclear(workingTable)
		local tsize = 0
		local totalLen = 0
		local numLines = 0
		local newCaretPosition
		local prevTokenWasColored = false
		local prevTokenWidth = 0
		local pos = 1
		local level = 0

		while true do
			-- Обработка позиции курсора
			if caretPosition and not newCaretPosition and pos >= caretPosition then
				if pos == caretPosition then
					newCaretPosition = totalLen
				else
					newCaretPosition = totalLen
					local diff = pos - caretPosition
					if diff > prevTokenWidth then
						diff = prevTokenWidth
					end
					if prevTokenWasColored then
						diff = diff + stopColorLen
					end
					newCaretPosition = newCaretPosition - diff
				end
			end

			prevTokenWasColored = false
			prevTokenWidth = 0
			local tokenType, nextPos = nextToken(code, pos)
			if not tokenType then
				break
			end

			-- Пропускаем цветовые коды и неизвестные токены
			if tokenType == tokens.TOKEN_COLORCODE_START or tokenType == tokens.TOKEN_COLORCODE_STOP or tokenType == tokens.TOKEN_UNKNOWN then
			elseif tokenType == tokens.TOKEN_LINEBREAK or tokenType == tokens.TOKEN_WHITESPACE then
				if tokenType == tokens.TOKEN_LINEBREAK then
					numLines = numLines + 1
				end
				local str = stringsub(code, pos, nextPos - 1)
				prevTokenWidth = nextPos - pos
				tsize = tsize + 1
				workingTable[tsize] = str
				totalLen = totalLen + stringlen(str)
			else
				local str = stringsub(code, pos, nextPos - 1)
				prevTokenWidth = nextPos - pos
				-- Проверяем, является ли токен ключевым словом
				if keywords[str] then
					tokenType = tokens.TOKEN_KEYWORD
				end

				-- Получаем цвет для токена
				local color
				if stopColor then
					color = colorTable[str]
					if not color then
						color = colorTable[tokenType]
						if not color then
							if tokenType == tokens.TOKEN_IDENTIFIER then
								color = colorTable[tokens.TOKEN_IDENTIFIER]
							else
								color = colorTable[tokens.TOKEN_SPECIAL]
							end
						end
					end
				end

				-- Добавляем цветные токены в результат
				if color then
					tsize = tsize + 1
					workingTable[tsize] = color
					tsize = tsize + 1
					workingTable[tsize] = str
					tsize = tsize + 1
					workingTable[tsize] = stopColor
					totalLen = totalLen + stringlen(color) + (nextPos - pos) + stopColorLen
					prevTokenWasColored = true
				else
					tsize = tsize + 1
					workingTable[tsize] = str
					totalLen = totalLen + stringlen(str)
				end
			end
			pos = nextPos
		end

		return table.concat(workingTable), newCaretPosition, numLines
	end

	-- Функция для форматирования отступов в коде
	function lib.indentCode(code, tabWidth, colorTable, caretPosition)
		local fillFunction
		if tabWidth == nil then
			tabWidth = defaultTabWidth
		end
		if tabWidth then
			fillFunction = fillWithSpaces
		else
			fillFunction = fillWithTabs
		end

		tableclear(workingTable)
		local tsize = 0
		local totalLen = 0
		tableclear(workingTable2)
		local tsize2 = 0
		local totalLen2 = 0

		local stopColor = colorTable and colorTable[0]
		local stopColorLen = not stopColor or stringlen(stopColor)
		local newCaretPosition
		local newCaretPositionFinalized = false
		local prevTokenWasColored = false
		local prevTokenWidth = 0
		local pos = 1
		local level = 0
		local hitNonWhitespace = false
		local hitIndentRight = false
		local preIndent = 0
		local postIndent = 0

		while true do
			-- Обработка позиции курсора
			if caretPosition and not newCaretPosition and pos >= caretPosition then
				if pos == caretPosition then
					newCaretPosition = totalLen + totalLen2
				else
					newCaretPosition = totalLen + totalLen2
					local diff = pos - caretPosition
					if diff > prevTokenWidth then
						diff = prevTokenWidth
					end
					if prevTokenWasColored then
						diff = diff + stopColorLen
					end
					newCaretPosition = newCaretPosition - diff
				end
			end

			prevTokenWasColored = false
			prevTokenWidth = 0
			local tokenType, nextPos = nextToken(code, pos)

			-- Обработка конца строки или файла
			if not tokenType or tokenType == tokens.TOKEN_LINEBREAK then
				level = level + preIndent
				if level < 0 then level = 0 end

				-- Добавляем отступы в начало строки
				local s = fillFunction(level, tabWidth)
				tsize = tsize + 1
				workingTable[tsize] = s
				totalLen = totalLen + stringlen(s)

				-- Обновляем позицию курсора
				if newCaretPosition and not newCaretPositionFinalized then
					newCaretPosition = newCaretPosition + stringlen(s)
					newCaretPositionFinalized = true
				end

				-- Добавляем накопленные токены строки
				for k, v in next, (workingTable2) do
					tsize = tsize + 1
					workingTable[tsize] = v
					totalLen = totalLen + stringlen(v)
				end

				if not tokenType then
					break
				end

				-- Добавляем символ перевода строки
				tsize = tsize + 1
				workingTable[tsize] = stringsub(code, pos, nextPos - 1)
				totalLen = totalLen + nextPos - pos

				-- Обновляем уровень отступа для следующей строки
				level = level + postIndent
				if level < 0 then level = 0 end

				-- Сбрасываем временные данные для новой строки
				tableclear(workingTable2)
				tsize2 = 0
				totalLen2 = 0
				hitNonWhitespace = false
				hitIndentRight = false
				preIndent = 0
				postIndent = 0
			elseif tokenType == tokens.TOKEN_WHITESPACE then
				-- Пробелы добавляем только после первого не-пробельного символа
				if hitNonWhitespace then
					prevTokenWidth = nextPos - pos
					tsize2 = tsize2 + 1
					local s = stringsub(code, pos, nextPos - 1)
					workingTable2[tsize2] = s
					totalLen2 = totalLen2 + stringlen(s)
				end
			elseif tokenType == tokens.TOKEN_COLORCODE_START or tokenType == tokens.TOKEN_COLORCODE_STOP or tokenType == tokens.TOKEN_UNKNOWN then
				-- Пропускаем цветовые коды и неизвестные токены
			else
				hitNonWhitespace = true
				local str = stringsub(code, pos, nextPos - 1)
				prevTokenWidth = nextPos - pos

				-- Определяем влияние токена на отступы
				local indentTable
				if tokenType == tokens.TOKEN_IDENTIFIER then
					indentTable = keywords[str]
				else
					indentTable = lib.tokenIndentation[tokenType]
				end

				if indentTable then
					if hitIndentRight then
						postIndent = postIndent + indentTable[1] + indentTable[2]
					else
						local pre = indentTable[1]
						local post = indentTable[2]
						if post > 0 then
							hitIndentRight = true
						end
						preIndent = preIndent + pre
						postIndent = postIndent + post
					end
				end

				-- Проверяем, является ли токен ключевым словом
				if keywords[str] then
					tokenType = tokens.TOKEN_KEYWORD
				end

				-- Получаем цвет для токена
				local color
				if stopColor then
					color = colorTable[str]
					if not color then
						color = colorTable[tokenType]
						if not color then
							if tokenType == tokens.TOKEN_IDENTIFIER then
								color = colorTable[tokens.TOKEN_IDENTIFIER]
							else
								color = colorTable[tokens.TOKEN_SPECIAL]
							end
						end
					end
				end

				-- Добавляем цветные токены в результат
				if color then
					tsize2 = tsize2 + 1
					workingTable2[tsize2] = color
					totalLen2 = totalLen2 + stringlen(color)
					tsize2 = tsize2 + 1
					workingTable2[tsize2] = str
					totalLen2 = totalLen2 + nextPos - pos
					tsize2 = tsize2 + 1
					workingTable2[tsize2] = stopColor
					totalLen2 = totalLen2 + stopColorLen
					prevTokenWasColored = true
				else
					tsize2 = tsize2 + 1
					workingTable2[tsize2] = str
					totalLen2 = totalLen2 + nextPos - pos
				end
			end
			pos = nextPos
		end

		return table.concat(workingTable), newCaretPosition
	end

	-- Вспомогательные функции для работы с курсором
	local GetTime = GetTime
	local editboxSetText
	local editboxGetText

	local function critical_enter(editbox)
		local script = editbox:GetScript("OnTextSet")
		if script then
			editbox:SetScript("OnTextSet", nil)
		end
		return script
	end

	local function critical_leave(editbox, script)
		if script then
			editbox:SetScript("OnTextSet", script)
		end
	end

	local function setCaretPos_main(editbox, pos)
		local text = editboxGetText(editbox)
		if stringlen(text) > 0 then
			editboxSetText(editbox, stringinsert(text, pos, "a"))
			editbox:HighlightText(pos, pos + 1)
			editbox:Insert("\0")
		end
	end

	local function getCaretPos(editbox)
		local script = critical_enter(editbox)
		local text = editboxGetText(editbox)
		editbox:Insert("")
		local pos = stringfind(editboxGetText(editbox), "", 1, 1)
		editboxSetText(editbox, text)
		if pos then
			setCaretPos_main(editbox, pos - 1)
		end
		critical_leave(editbox, script)
		return (pos or 0) - 1
	end

	local function setCaretPos(editbox, pos)
		local script, script2 = critical_enter(editbox)
		setCaretPos_main(editbox, pos)
		critical_leave(editbox, script, script2)
	end

	-- Функция для удаления цветовых кодов WoW
	function lib.stripWowColors(code)
		code = stringgsub(code, "|r\n\n$", "|r")
		tableclear(workingTable)
		local tsize = 0
		local pos = 1
		local prevVertical = false
		local even = true
		local selectionStart = 1

		while true do
			local byte = stringbyte(code, pos)
			if not byte then
				break
			end

			if byte == bytes.BYTE_VERTICAL then
				even = not even
				prevVertical = true
			else
				if prevVertical and not even then
					if byte == bytes.BYTE_c then
						if pos - 2 >= selectionStart then
							tsize = tsize + 1
							workingTable[tsize] = stringsub(code, selectionStart, pos - 2)
						end
						pos = pos + 8
						selectionStart = pos + 1
					elseif byte == bytes.BYTE_r then
						if pos - 2 >= selectionStart then
							tsize = tsize + 1
							workingTable[tsize] = stringsub(code, selectionStart, pos - 2)
						end
						selectionStart = pos + 1
					end
				end
				prevVertical = false
				even = true
			end
			pos = pos + 1
		end

		if pos >= selectionStart then
			tsize = tsize + 1
			workingTable[tsize] = stringsub(code, selectionStart, pos - 1)
		end

		return table.concat(workingTable)
	end

	-- Функции для работы с кодированием/декодированием текста
	function lib.decode(code)
		if code then
			code = lib.stripWowColors(code)
			code = stringgsub(code, "||", "|")
		end
		return code or ""
	end

	function lib.encode(code)
		if code then
			code = stringgsub(code, "|", "||")
		end
		return code or ""
	end

	-- Функция для удаления цветовых кодов с сохранением позиции
	function lib.stripWowColorsWithPos(code, pos)
		code = stringinsert(code, pos, "\2")
		code = lib.stripWowColors(code)
		pos = stringfind(code, "\2", 1, 1)
		code = stringdelete(code, pos, pos)
		return code, pos
	end

	-- Функция для добавления переводов строк в конец текста
	local linebreak = stringbyte("\n")
	function lib.padWithLinebreaks(code)
		local len = stringlen(code)
		local linebreakcount = 0
		while len > 0 and linebreakcount < 2 do
			local b = stringbyte(code, len)
			if b == linebreak then
				linebreakcount = linebreakcount + 1
			elseif whitespaceCharacters[b] then
			else
				break
			end
			len = len - 1
		end

		if linebreakcount == 0 then
			return code .. "\n\n", true
		elseif linebreakcount == 1 then
			return code .. "\n", true
		else
			return code, false
		end
	end

	-- Кэши для работы с текстовыми полями
	local enabled = {}
	local dirty = {}
	local editboxIndentCache = {}
	local decodeCache = {}
	local editboxStringCache = {}
	local editboxNumLinesCache = {}

	-- Функция для подсветки синтаксиса в текстовом поле
	function lib.colorCodeEditbox(editbox)
		dirty[editbox] = nil
		local colorTable = editbox.faiap_colorTable or defaultColorTable
		local tabWidth = editbox.faiap_tabWidth
		local orgCode = editboxGetText(editbox)
		local prevCode = editboxStringCache[editbox]

		-- Если текст не изменился, выходим
		if prevCode == orgCode then
			return
		end

		-- Получаем позицию курсора
		local pos = getCaretPos(editbox)
		local code
		code, pos = lib.stripWowColorsWithPos(orgCode, pos)

		-- Подсвечиваем код
		colorTable[0] = "|r"
		local newCode, newPos, numLines = lib.colorCodeCode(code, colorTable, pos)
		newCode = lib.padWithLinebreaks(newCode)
		editboxStringCache[editbox] = newCode

		-- Если текст изменился, обновляем поле ввода
		if orgCode ~= newCode then
			local script, script2 = critical_enter(editbox)
			decodeCache[editbox] = nil
			local stringlenNewCode = stringlen(newCode)
			editboxSetText(editbox, newCode)

			-- Восстанавливаем позицию курсора
			if newPos then
				if newPos < 0 then newPos = 0 end
				if newPos > stringlenNewCode then newPos = stringlenNewCode end
				setCaretPos(editbox, newPos)
			end
			critical_leave(editbox, script, script2)
		end

		-- Если изменилось количество строк, обновляем отступы
		if editboxNumLinesCache[editbox] ~= numLines then
			lib.indentEditbox(editbox)
		end
		editboxNumLinesCache[editbox] = numLines
	end

	-- Функция для форматирования отступов в текстовом поле
	function lib.indentEditbox(editbox)
		dirty[editbox] = nil
		local colorTable = editbox.faiap_colorTable or defaultColorTable
		local tabWidth = editbox.faiap_tabWidth
		local orgCode = editboxGetText(editbox)
		local prevCode = editboxIndentCache[editbox]

		-- Если текст не изменился, выходим
		if prevCode == orgCode then
			return
		end

		-- Получаем позицию курсора
		local pos = getCaretPos(editbox)
		local code
		code, pos = lib.stripWowColorsWithPos(orgCode, pos)

		-- Форматируем отступы
		colorTable[0] = "|r"
		local newCode, newPos = lib.indentCode(code, tabWidth, colorTable, pos)
		newCode = lib.padWithLinebreaks(newCode)
		editboxIndentCache[editbox] = newCode

		-- Если текст изменился, обновляем поле ввода
		if code ~= newCode then
			local script, script2 = critical_enter(editbox)
			decodeCache[editbox] = nil
			local stringlenNewCode = stringlen(newCode)
			editboxSetText(editbox, newCode)

			-- Восстанавливаем позицию курсора
			if newPos then
				if newPos < 0 then newPos = 0 end
				if newPos > stringlenNewCode then newPos = stringlenNewCode end
				setCaretPos(editbox, newPos)
			end
			critical_leave(editbox, script, script2)
		end
	end

	-- Функции для перехвата событий текстового поля
	local function hookHandler(editbox, handler, newFun)
		local oldFun = editbox:GetScript(handler)
		if oldFun == newFun then
			return
		end
		editbox["faiap_old_" .. handler] = oldFun
		editbox:SetScript(handler, newFun)
	end

	local function textChangedHook(editbox, ...)
		local oldFun = editbox["faiap_old_OnTextChanged"]
		if oldFun then
			oldFun(editbox, ...)
		end
		if enabled[editbox] and not editbox:IsInIMECompositionMode() then
			dirty[editbox] = GetTime()
		end
	end

	local function tabPressedHook(editbox, ...)
		local oldFun = editbox["faiap_old_OnTabPressed"]
		if oldFun then
			oldFun(editbox, ...)
		end
		if enabled[editbox] then
			return lib.indentEditbox(editbox)
		end
	end

	local function onUpdateHook(editbox, ...)
		local oldFun = editbox["faiap_old_OnUpdate"]
		if oldFun then
			oldFun(editbox, ...)
		end
		if enabled[editbox] and not editbox:IsInIMECompositionMode() then
			local now = GetTime()
			local lastUpdate = dirty[editbox] or now
			if now - lastUpdate > 0.2 then
				decodeCache[editbox] = nil
				return lib.colorCodeEditbox(editbox)
			end
		end
	end

	-- Новые методы GetText/SetText для текстового поля
	local function newGetText(editbox)
		local decoded = decodeCache[editbox]
		if not decoded then
			decoded = lib.decode(editboxGetText(editbox))
			decodeCache[editbox] = decoded
		end
		return decoded or ""
	end

	local function newSetText(editbox, text)
		decodeCache[editbox] = nil
		if text then
			local encoded = lib.encode(text)
			return editboxSetText(editbox, encoded)
		end
	end

	-- Включение функционала библиотеки для текстового поля
	function lib.enable(editbox, colorTable, tabWidth)
		if not editboxSetText then
			editboxSetText = editbox.SetText
			editboxGetText = editbox.GetText
		end

		local modified
		if editbox.faiap_colorTable ~= colorTable then
			editbox.faiap_colorTable = colorTable
			modified = true
		end
		if editbox.faiap_tabWidth ~= tabWidth then
			editbox.faiap_tabWidth = tabWidth
			modified = true
		end

		-- Если уже включено, просто обновляем настройки
		if enabled[editbox] then
			if modified then
				lib.indentEditbox(editbox)
			end
			return
		end

		enabled[editbox] = true

		-- Сохраняем оригинальные ограничения на длину текста
		editbox.oldMaxBytes = editbox:GetMaxBytes()
		editbox.oldMaxLetters = editbox:GetMaxLetters()
		editbox:SetMaxBytes(0)
		editbox:SetMaxLetters(0)

		-- Переопределяем методы GetText/SetText
		editbox.GetText = newGetText
		editbox.SetText = newSetText

		-- Подключаем обработчики событий
		hookHandler(editbox, "OnTextChanged", textChangedHook)
		hookHandler(editbox, "OnTabPressed", tabPressedHook)
		hookHandler(editbox, "OnUpdate", onUpdateHook)

		-- Применяем форматирование
		lib.indentEditbox(editbox)
	end
	lib.addSmartCode = lib.enable

	-- Отключение функционала библиотеки для текстового поля
	function lib.disable(editbox)
		if not enabled[editbox] then
			return
		end
		enabled[editbox] = nil

		-- Восстанавливаем оригинальные ограничения на длину текста
		editbox:SetMaxBytes(editbox.oldMaxBytes)
		editbox:SetMaxLetters(editbox.oldMaxLetters)

		-- Восстанавливаем оригинальные обработчики событий
		if editbox:GetScript("OnTextChanged") == textChangedHook then
			editbox:SetScript("OnTextChanged", editbox.faiap_old_OnTextChanged)
			editbox.faiap_old_OnTextChanged = nil
		end
		if editbox:GetScript("OnTabPressed") == tabPressedHook then
			editbox:SetScript("OnTabPressed", editbox.faiap_old_OnTabPressed)
			editbox.faiap_old_OnTabPressed = nil
		end
		if editbox:GetScript("OnUpdate") == onUpdateHook then
			editbox:SetScript("OnUpdate", editbox.faiap_old_OnUpdate)
			editbox.faiap_old_OnUpdate = nil
		end

		-- Восстанавливаем оригинальные методы GetText/SetText
		editbox.GetText = nil
		editbox.SetText = nil

		-- Очищаем кэши
		editbox:SetText(newGetText(editbox))
		editboxIndentCache[editbox] = nil
		decodeCache[editbox] = nil
		editboxStringCache[editbox] = nil
		editboxNumLinesCache[editbox] = nil
	end

	-- Цветовая схема по умолчанию
	defaultColorTable = {}
	lib.defaultColorTable = defaultColorTable
	defaultColorTable[tokens.TOKEN_SPECIAL] = "|c00ff99ff" -- Розовый для специальных символов
	defaultColorTable[tokens.TOKEN_KEYWORD] = "|c006666ff" -- Синий для ключевых слов
	defaultColorTable[tokens.TOKEN_COMMENT_SHORT] = "|c00999999" -- Серый для комментариев
	defaultColorTable[tokens.TOKEN_COMMENT_LONG] = "|c00999999" -- Серый для многострочных комментариев
	local stringColor = "|c00ffff77" -- Желтый для строк
	defaultColorTable[tokens.TOKEN_STRING] = stringColor
	defaultColorTable[".."] = stringColor
	local tableColor = "|c00ff9900" -- Оранжевый для таблиц
	defaultColorTable["..."] = tableColor
	defaultColorTable["{"] = tableColor
	defaultColorTable["}"] = tableColor
	defaultColorTable["["] = tableColor
	defaultColorTable["]"] = tableColor
	local arithmeticColor = "|c0033ff55" -- Зеленый для арифметических операций
	defaultColorTable[tokens.TOKEN_NUMBER] = arithmeticColor
	defaultColorTable["+"] = arithmeticColor
	defaultColorTable["-"] = arithmeticColor
	defaultColorTable["/"] = arithmeticColor
	defaultColorTable["*"] = arithmeticColor
	local logicColor1 = "|c0055ff88" -- Светло-зеленый для операторов сравнения
	defaultColorTable["=="] = logicColor1
	defaultColorTable["<"] = logicColor1
	defaultColorTable["<="] = logicColor1
	defaultColorTable[">"] = logicColor1
	defaultColorTable[">="] = logicColor1
	defaultColorTable["~="] = logicColor1
	local logicColor2 = "|c0088ffbb" -- Голубой для логических операторов
	defaultColorTable["and"] = logicColor2
	defaultColorTable["or"] = logicColor2
	defaultColorTable["not"] = logicColor2
	defaultColorTable[0] = "|r" -- Код сброса цвета
end