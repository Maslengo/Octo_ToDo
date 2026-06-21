local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local strsplit = strsplit
----------------------------------------------------------------
function E.func_GetAtlasIcon(atlasName, iconWidth, iconHeight)
	if not atlasName then return end
	return CreateAtlasMarkup(atlasName, iconWidth or 16, iconHeight or 16)
end
----------------------------------------------------------------
function E.func_GetItemHyperlink(itemID)
	local _, link = E.func_GetItemInfo(itemID)
	return link
end
----------------------------------------------------------------
function E.func_GetItemQualityColorTable(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQualityByID(itemID)]
end
----------------------------------------------------------------
function E.func_GetQualityHexColor(quality)
	local numQuality = tonumber(quality)
	if numQuality and numQuality > 0 and numQuality < 8 then
		return ITEM_QUALITY_COLORS[numQuality].hex
	end
	return E.COLOR_WHITE
end
----------------------------------------------------------------
function E.func_RGB2Hex(r, g, b, a)
	r = r ~= nil and r or 1
	g = g ~= nil and g or 1
	b = b ~= nil and b or 1
	a = a ~= nil and a or 1
	return "|c" .. string.format("%02x%02x%02x%02x",
		math.floor(a * 255),
		math.floor(r * 255),
		math.floor(g * 255),
		math.floor(b * 255)
	)
end
-- function E.func_RGB2Hex(r, g, b, a)
-- 	r = r ~= nil and r or 1
-- 	g = g ~= nil and g or 1
-- 	b = b ~= nil and b or 1
-- 	a = a ~= nil and a or 1
-- 	return "|c" .. string.format("%02x", math.floor(a*255)) .. utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
-- end
----------------------------------------------------------------
function E.func_Hex2RGBA(hex, forcedAlpha)
	if type(hex) ~= "string" then
		return 1, 1, 1, 1
	end
	-- Приводим к нижнему регистру для удобства
	hex = hex:lower()
	-- |cffRRGGBB или |caarrggbb
	if hex:sub(1,2) == "|c" then
		if #hex < 10 then
			return 1, 1, 1, 1
		end
		local a = tonumber(hex:sub(3,4), 16) or 255
		local r = tonumber(hex:sub(5,6), 16) or 255
		local g = tonumber(hex:sub(7,8), 16) or 255
		local b = tonumber(hex:sub(9,10), 16) or 255
		if not (r and g and b and a) then
			return 1, 1, 1, 1
		end
		return r/255, g/255, b/255, forcedAlpha ~= nil and forcedAlpha or a/255
	end
	-- RRGGBB
	if #hex == 6 then
		local r = tonumber(hex:sub(1,2), 16)
		local g = tonumber(hex:sub(3,4), 16)
		local b = tonumber(hex:sub(5,6), 16)
		if not (r and g and b) then
			return 1, 1, 1, 1
		end
		return r/255, g/255, b/255, forcedAlpha ~= nil and forcedAlpha or 1
	end
	if #hex == 8 then
		local a = tonumber(hex:sub(1,2), 16)
		local r = tonumber(hex:sub(3,4), 16)
		local g = tonumber(hex:sub(5,6), 16)
		local b = tonumber(hex:sub(7,8), 16)
		if not (r and g and b and a) then
			return 1, 1, 1, 1
		end
		return r/255, g/255, b/255, forcedAlpha ~= nil and forcedAlpha or a/255
	end
	return 1, 1, 1, 1
end
----------------------------------------------------------------
function E.func_RGB2HexString(r, g, b, a)
	a = a or 1
	return string.format("%02x%02x%02x%02x",
		math.floor(a * 255),
		math.floor(r * 255),
		math.floor(g * 255),
		math.floor(b * 255)
	)
end
-- function E.func_RGB2HexString(r, g, b, a)
-- 	a = a or 1
-- 	return string.upper(string.format("%02x%02x%02x%02x",
-- 			math.floor(a * 255),
-- 			math.floor(r * 255),
-- 			math.floor(g * 255),
-- 			math.floor(b * 255)
-- 	))
-- end
----------------------------------------------------------------
function E.func_Hex2ColorTable(hex, forcedAlpha)
	local r, g, b, a = E.func_Hex2RGBA(hex)
	return {r = r, g = g, b = b, a = forcedAlpha or a}
end
----------------------------------------------------------------
function E.func_GetNextResetTime(t)
	local t = t or 1
	local daytime = 86400
	local thursdayReset = E.func_GetWeeklyResetStartTime()
	return (math.ceil((E.TIME_SERVER() - thursdayReset)/(daytime*t))*daytime*t)+thursdayReset
end
----------------------------------------------------------------
----------------------------------------------------------------
--- @param achievementID number|nil
--- @return boolean
function E.func_IsAchievementCompleted(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_EncodeCoordinates(x, y)
	return math.floor(x * 10000 + 0.5) * 10000 + math.floor(y * 10000 + 0.5)
end
----------------------------------------------------------------
function E.func_FormatCoordinates(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string.format("%.1f / %.1f", x * 100, y * 100)
end
----------------------------------------------------------------
function E.func_UnpackCoordinates(packed)
	if not packed or packed == 0 then
		return nil, nil
	end
	local packedStr = tostring(packed)
	if #packedStr ~= 8 then
		return nil, nil
	end
	local x = tonumber(packedStr:sub(1, 4)) / 10000
	local y = tonumber(packedStr:sub(5, 8)) / 10000
	return x, y -- Возвращаем ДВА ЧИСЛА
end
----------------------------------------------------------------
function E.func_GetQuestLogCount()
	local numQuests = 0
	local numShownEntries = E.func_GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = E.func_GetInfo(i)
		numQuests = numQuests + (info and info.frequency and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
----------------------------------------------------------------
function E.func_GetCurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
----------------------------------------------------------------
function E.func_FormatLastSeen(t, color)
	if not t then
		return L["FRIENDS_LIST_OFFLINE"]
	else
		return string.format(L["BNET_LAST_ONLINE_TIME"], color .. E.func_FormatTimeAgo(t) .. "|r")
	end
end
----------------------------------------------------------------
function E.func_FormatTimeAgo(timeDiff, isAbsolute)
	if not isAbsolute then
		local ServerTime = E.TIME_SERVER()
		timeDiff = ServerTime - timeDiff
	end
	if timeDiff < SECONDS_PER_MIN then
		return LASTONLINE_SECS
	elseif timeDiff < SECONDS_PER_HOUR then
		return format(LASTONLINE_MINUTES, math.floor(timeDiff / SECONDS_PER_MIN))
	elseif timeDiff < SECONDS_PER_DAY then
		return format(LASTONLINE_HOURS, math.floor(timeDiff / SECONDS_PER_HOUR))
	elseif timeDiff < SECONDS_PER_MONTH then
		return format(LASTONLINE_DAYS, math.floor(timeDiff / SECONDS_PER_DAY))
	elseif timeDiff < SECONDS_PER_YEAR then
		return format(LASTONLINE_MONTHS, math.floor(timeDiff / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, math.floor(timeDiff / SECONDS_PER_YEAR))
	end
end
----------------------------------------------------------------
function E.func_TableConcat(table1, table2) -- func_ArrayConcatUnsafe
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
----------------------------------------------------------------
function E.func_MergeTables(table1, table2)
	for k, v in next, (table2) do
		table1[k] = v
	end
	return table1
end
----------------------------------------------------------------
function E.func_GetTextWithColor(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E.func_RGB2Hex(fontstring:GetTextColor()) .. text .. "|r"
end
----------------------------------------------------------------
function E.func_FormatDateTwoDigits(date)
	local result = ("%.2d"):format(date)
	return result
end
----------------------------------------------------------------
function E.func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
----------------------------------------------------------------
function E.func_InitSubTable(tbl, field)
	if type(tbl[field]) ~= "table" then
		tbl[field] = {}
	end
end
----------------------------------------------------------------
function E.func_SpamBlock(...)
	-- Собираем уникальный строковый ключ из всех переданных аргументов.
	-- Это позволяет различать разные вызовы (например, с разными функциями или параметрами).
	local key = (""):join(tostringall(...))

	-- Извлекаем саму функцию, флаг проверки боя и кастомный таймер спама.
	local func, needCheckCombat, newSpamTimer = ...

	-- Если первый аргумент — не функция, прерываем выполнение.
	if type(func) ~= "function" then return end

	-- Определяем время блокировки: либо переданное, либо из настроек, либо по умолчанию 2 секунды.
	local SPAM_TIME = newSpamTimer or E.SPAM_TIME or 2

	-- Если нужно проверять бой и мы сейчас в нём — запоминаем, что вызов был сделан в бою, и выходим.
	if (needCheckCombat == nil or needCheckCombat) and InCombatLockdown() then
		E._inCombats[key] = true
		return true
	end

	-- Получаем текущее время (E.TIME_SERVER — ссылка на GetTime, поэтому вызывается как функция).
	local ServerTime = E.TIME_SERVER()

	-- Проверяем, был ли уже вызов с этим ключом.
	if E._spamLocks[key] then
		local timeSinceLast = ServerTime - E._spamLocks[key]  -- сколько прошло с последнего выполнения
		local timeToEnd = SPAM_TIME - timeSinceLast             -- сколько осталось до конца блокировки

		-- Если с последнего вызова прошло меньше SPAM_TIME, блокируем вызов.
		if timeSinceLast < SPAM_TIME then
			-- Планируем отложенный вызов, только если его ещё нет.
			if not E._callAfterTimer[key] then
				E._callAfterTimer[key] = true  -- помечаем, что таймер уже создан

				-- Сохраняем все исходные аргументы для последующей передачи.
				local args = { ... }

				-- Создаём таймер, который сработает ровно через timeToEnd секунд.
				-- Результат (дескриптор) сохраняем в E._timerHandles, чтобы иметь возможность отменить таймер.
				E._timerHandles = E._timerHandles or {}  -- инициализируем таблицу, если её нет
				E._timerHandles[key] = C_Timer.After(timeToEnd, function()
						-- Таймер сработал — снимаем флаги и удаляем свой дескриптор.
						E._callAfterTimer[key] = nil
						E._timerHandles[key] = nil
						-- Рекурсивно вызываем SpamBlock с теми же аргументами.
						-- Теперь, когда блокировка истекла, func выполнится (если снова не попадёт в спам).
						E.func_SpamBlock(unpack(args))
				end)
			end
			-- Прерываем текущий вызов, потому что он заблокирован.
			return true
		end
	end

	-- Если мы здесь, значит блокировка истекла (или это первый вызов).
	-- Но перед выполнением нужно отменить ранее запланированный таймер,
	-- если он вдруг ещё не сработал — чтобы избежать двойного вызова func.
	if E._timerHandles and E._timerHandles[key] then
		E._timerHandles[key]:Cancel()        -- отменяем таймер
		E._timerHandles[key] = nil           -- очищаем дескриптор
		E._callAfterTimer[key] = nil         -- снимаем флаг существования таймера
	end

	-- Фиксируем время текущего выполнения.
	E._spamLocks[key] = ServerTime

	-- Непосредственно вызываем целевую функцию.
	func()

	-- Возвращаем false как признак того, что вызов не был заблокирован.
	return false
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CloseSettings()
	if InCombatLockdown() then return end
	if SettingsPanel:IsVisible() then
		HideUIPanel(SettingsPanel)
	end
	if GameMenuFrame:IsVisible() then
		HideUIPanel(GameMenuFrame)
	end
end
----------------------------------------------------------------
function E.func_OpenToCategory(frame)
	if InCombatLockdown() then return end
	if frame and frame:IsShown() then
		frame:Hide()
	end
	local id = E.main_category:GetID()
	Settings.OpenToCategory(id, GlobalAddonName)
end
----------------------------------------------------------------
function E.func_toogleFrame(f)
	f.clicked = not f.clicked or nil
	f:SetShown(f.clicked)
	f:SetAlpha(1)
	-- f:SetShown(not f:IsShown())
end
----------------------------------------------------------------
function E.func_CreateMinimapButton(AddonName, Saved_Variables, f, func, frameString)
	if not f then return end
	local function hideFrame(_, elapsed)
		EventFrame.timer = EventFrame.timer - elapsed
		if EventFrame.timer <= 0 then
			f:Hide()
			EventFrame:SetScript("OnUpdate", nil)
		end
	end
	f:HookScript("OnHide", function(f)
			f.clicked = nil
	end)
	f:HookScript("OnShow", function(f)
			E.func_CloseSettings()
	end)
	local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
			type = "data source",
			icon = "Interface\\AddOns\\" .. E.MainAddonName .. "\\Media\\IconTexture\\" .. AddonName,
			OnClick = function(self, button)
				if button == "LeftButton" then
					Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled = nil
					if f then
						E.func_toogleFrame(f)
					end
				elseif button == "RightButton" then
					E.func_OpenToCategory(f)
				end
			end,
			OnTooltipShow = function(tooltip)
				EventFrame.timer = 0
				local addonNameNEW = E.func_AddonNameForOptions(AddonName)
				tooltip:AddLine(addonNameNEW)
				tooltip:AddLine(" ")
				tooltip:AddDoubleLine(E.LEFT_MOUSE_ICON .. L["LMB:"], HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING)
				tooltip:AddDoubleLine(E.RIGHT_MOUSE_ICON .. L["RMB:"], L["OPTIONS"])
				local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
				if settingsProfile.CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER then
					if not f.clicked then
						f:SetAlpha(settingsProfile.CONFIG_FRAME_ALPHA_ON_HOVER/100 or .8)
					end
					f:Show() -- E.func_toogleFrame(f)
				end
				EventFrame:SetScript("OnUpdate", nil)
			end,
			OnLeave = function()
				local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
				if settingsProfile.CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER and settingsProfile.CONFIG_HOVER_SHOW_DURATION and not f.clicked then
					EventFrame.timer = settingsProfile.CONFIG_HOVER_SHOW_DURATION
					EventFrame:SetScript("OnUpdate", hideFrame)
				end
			end,
	})
	if type(Saved_Variables.LibDataBroker) ~= "table" then
		Saved_Variables.LibDataBroker = {}
	end
	if not Saved_Variables.LibDataBroker.minimapPos then
		Saved_Variables.LibDataBroker.minimapPos = random(1, 365)
	end
	LibStub("LibDBIcon-1.0"):Register(AddonName, dataBroker, Saved_Variables.LibDataBroker)
end
----------------------------------------------------------------
function E.func_Gradient(text, firstColor, secondColor)
	if type(text) ~= "string" or text == "" then
		return ""
	end
	firstColor = firstColor or E.COLOR_ADDON_LEFT or "|cffD177FF"
	secondColor = secondColor or E.COLOR_ADDON_RIGHT or "|cff63A4E0"
	local startR, startG, startB = E.func_Hex2RGBA(firstColor)
	local endR, endG, endB = E.func_Hex2RGBA(secondColor)
	local segments = {}
	local chars = {}
	for char in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		chars[#chars + 1] = char
	end
	local textLength = #chars
	if textLength <= 1 then return text end
	for i = 1, textLength do
		local factor = (i - 1) / (textLength - 1)
		local r = startR + (endR - startR) * factor
		local g = startG + (endG - startG) * factor
		local b = startB + (endB - startB) * factor
		segments[i] = E.func_RGB2Hex(r, g, b) .. chars[i] .. "|r"
	end
	return table.concat(segments)
end
----------------------------------------------------------------
function E.func_GetColorGradient(value, minValue, maxValue)
	if not E.PROFTBL then
		return E.COLOR_WHITE
	end
	if E.PROFTBL.ConfigColor_TOOLTIP_usegradient == nil or E.PROFTBL.ConfigColor_TOOLTIP_usegradient == false then
		return E.COLOR_WHITE
	end
	-- Проверяем, что цвета есть в БД
	if not value or not minValue or not maxValue or type(value) == "boolean" or type(minValue) ~= "number" or type(maxValue) ~= "number" then
		return E.COLOR_GREEN
	end
	local r_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_r
	local g_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_g
	local b_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_b
	local a_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_a
	local r_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_r
	local g_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_g
	local b_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_b
	local a_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_a
	local r_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_r
	local g_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_g
	local b_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_b
	local a_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_a
	if minValue >= maxValue then
		return E.func_RGB2Hex(r_max, g_max, b_max, a_max)
	end
	-- Нормализуем значение
	local p = (value - minValue) / (maxValue - minValue)
	if p < 0 then p = 0 end
	if p > 1 then p = 1 end
	local UseOnlyTwoColor = false
	local r1, g1, b1, r2, g2, b2, t
	if UseOnlyTwoColor then
		-- Два цвета: min -> max
		r1, g1, b1 = r_min, g_min, b_min
		r2, g2, b2 = r_max, g_max, b_max
		t = p
	else
		-- Три цвета: min -> mid -> max
		if p < 0.5 then
			r1, g1, b1 = r_min, g_min, b_min
			r2, g2, b2 = r_mid, g_mid, b_mid
			t = p * 2
		else
			r1, g1, b1 = r_mid, g_mid, b_mid
			r2, g2, b2 = r_max, g_max, b_max
			t = (p - 0.5) * 2
		end
	end
	-- Интерполяция и конвертация в 0-255
	local r = math.floor(Lerp(r1, r2, t) * 255 + 0.5)
	local g = math.floor(Lerp(g1, g2, t) * 255 + 0.5)
	local b = math.floor(Lerp(b1, b2, t) * 255 + 0.5)
	-- return string.format("|cff%02x%02x%02x", r, g, b)
	local result = E.func_RGB2Hex(r/255, g/255, b/255, 1)
	return result
end
----------------------------------------------------------------
function E.func_CleanDeepTable(t, rules)
	if type(t) ~= "table" then return false end
	for k, v in pairs(t) do
		local remove = false
		if type(v) == "table" then
			local empty = E.func_CleanDeepTable(v, rules)
			if empty then
				remove = true
			end
		else
			if rules.zero and v == 0 then remove = true end
			if rules.emptyString and v == "" then remove = true end
			if rules.falseValue and v == false then remove = true end
			if rules.values then
				for _, bad in ipairs(rules.values) do
					if v == bad then
						remove = true
						break
					end
				end
			end
			if rules.strings and type(v) == "string" then
				for _, pattern in ipairs(rules.strings) do
					if v:find(pattern) then
						remove = true
						break
					end
				end
			end
		end
		if remove then
			t[k] = nil
		end
	end
	return next(t) == nil
end
----------------------------------------------------------------
function E.func_SetOrNil(tbl, key, val)
	tbl[key] = (val and val ~= 0) and val or nil
end
----------------------------------------------------------------
function E.func_RemoveZeroValues(tbl, smth)
	if not tbl or not smth or type(tbl) ~= "table" then return end
	-- Обработка случая когда smth - таблица значений для удаления
	if type(smth) == "table" then
		for q, w in ipairs(smth) do
			for k, value in pairs(tbl) do
				if value == w then -- Точное совпадение значения
					E.func_PrintMessage(k, E.COLOR_YELLOW .. tostring(value) .. "|r")
					tbl[k] = nil -- Удаляем значение
				elseif type(value) == "table" then
					E.func_RemoveZeroValues(value, w) -- Рекурсия для вложенных таблиц
				end
			end
			return tbl
		end
		-- Обработка числовых значений для удаления
	elseif type(smth) == "number" then
		for k, value in pairs(tbl) do
			if value == smth then
				E.func_PrintMessage(k, E.COLOR_PURPLE .. tostring(value) .. "|r")
				tbl[k] = nil
			elseif type(value) == "table" then
				E.func_RemoveZeroValues(value, smth) -- Рекурсия
			end
		end
		return tbl
		-- Обработка строковых шаблонов
	elseif type(smth) == "string" then
		for k, value in pairs(tbl) do
			-- Специальный случай для любых числовых значений
			if value and smth == "anynumber" and type(value) == "number" then
				E.func_PrintMessage(k, E.COLOR_WOW_TOKEN .. tostring(value) .. "|r")
				tbl[k] = nil
			else
				E.func_RemoveZeroValues(value, smth)
			end
			-- Поиск по строковому шаблону
			if value and type(value) == "string" then
				if string.find(value, smth) then
					E.func_PrintMessage(k, E.COLOR_MAGENTA .. tostring(value) .. "|r")
					tbl[k] = nil
				end
			else
				E.func_RemoveZeroValues(value, smth)
			end
		end
		return tbl
	end
end
----------------------------------------------------------------
-- Функция глубокого копирования таблицы
function E.func_CopyTableDeep(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[E.func_CopyTableDeep(orig_key)] = E.func_CopyTableDeep(orig_value)
		end
		setmetatable(copy, E.func_CopyTableDeep(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end
----------------------------------------------------------------
function E.func_AddonNameForOptions(addonName)
	local name = E.func_GetAddOnMetadata(addonName, "Title")
	local vers = E.COLOR_GRAY .. E.func_GetAddOnMetadata(addonName, "Version") .. "|r" -- ORANGE = ff7f3f
	local result = name .. " " .. vers
	return result
end
----------------------------------------------------------------
local countSavedVars = 0
function E.func_GetSavedVars(addonName)
	if not (E.SavedVarsByAddon and E.SavedVarsByAddon[addonName]) then
		E.InitGlobalDB(addonName)
	end
	countSavedVars = countSavedVars + 1
	return E.SavedVarsByAddon[addonName]
end
----------------------------------------------------------------
function E.func_GetTimewalkingDungeon()
	local joinable, timewalkDungeonName, result = false, "", ""
	for expID, v in ipairs(E.OctoTable_Expansions) do
		if v.timewalkDungeonID and IsLFGDungeonJoinable(v.timewalkDungeonID) then
			joinable = true
			result = E.func_FormatExpansion(expID)
			timewalkDungeonName = GetLFGDungeonInfo(v.timewalkDungeonID)
			-- break
		end
	end
	return joinable, result, timewalkDungeonName:match("%((.-)%)")
end
----------------------------------------------------------------
function E.func_FormatExpansion(expID, iconSide, fullName)
	local expansion = E.OctoTable_Expansions[expID]
	local expIcon = E.func_texturefromIcon(expansion.icon, 16, 32)
	local color = expansion.color
	local expName = color .. (fullName and expansion.name or expansion.nameVeryShort)
	if iconSide == "LEFT" then
		return expIcon .. expName .. "|r"
	end
	-- По умолчанию RIGHT
	return expName .. expIcon .. "|r"
end
----------------------------------------------------------------
function E.func_GetCurrentRegionName()
	local result = GetCurrentRegionName()
	if result == "" then
		result = "PTR " .. E.buildVersion
	end
	return result
end
E.CURRENT_REGION_NAME = E.func_GetCurrentRegionName()
function E.func_RegisterFrame_ICONS(frame)
	E.OctoTable_Frames_ICONS = E.OctoTable_Frames_ICONS or {}
	E.OctoTable_Frames_SIMPLE = E.OctoTable_Frames_SIMPLE or {}
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames_ICONS, frame)
	table.insert(UISpecialFrames, frame:GetName())
	C_Timer.After(0, function()
			frame:HookScript("OnShow", function()
					for i, other in ipairs(E.OctoTable_Frames_ICONS) do
						if frame ~= other and other:IsShown() then
							other:Hide()
						end
					end
			end)
			frame:HookScript("OnHide", function()
					if E.OctoTable_Frames_SIMPLE then
						for i, other in ipairs(E.OctoTable_Frames_SIMPLE) do
							if other:IsShown() then
								other:Hide()
							end
						end
					end
			end)
	end)
end
function E.func_RegisterFrame_SIMPLE(frame)
	E.OctoTable_Frames_SIMPLE = E.OctoTable_Frames_SIMPLE or {}
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames_SIMPLE, frame)
	table.insert(UISpecialFrames, frame:GetName())
end
function E.SafeCall(func, ...)
	local success, result = pcall(func, ...)
	if not success then
		-- Логирование ошибки
		return nil
	end
	return result
end
function E.func_AddTooltipSeparator(tooltip)
	if not tooltip then return end
	if #tooltip > 0 then
		tooltip[#tooltip+1] = {" "}
	end
	return
end
----------------------------------------------------------------
function E.func_GetMinMaxValue(tbl, data)
	if type(tbl) ~= "table" then
		return nil, nil
	end
	local minValue, maxValue
	for _, v in next, tbl do
		local value = (type(v) == "table" and v[data]) or 0
		if minValue == nil or value < minValue then
			minValue = value
		end
		if maxValue == nil or value > maxValue then
			maxValue = value
		end
	end
	return minValue, maxValue
end
----------------------------------------------------------------
-- Функция показа сообщения
function E.func_PrintMessage(...)
	-- Используем стандартное сообщение WoW или создаем свое
	-- UIErrorsFrame:AddMessage(E.func_Gradient(text), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	-- DEFAULT_CHAT_FRAME:AddMessage(E.func_GetAddOnMetadata(E.MainAddonName, "Title") .. ": " .. text)
	-- DEFAULT_CHAT_FRAME:AddMessage(...)
	print(...)
end
function E.InitGlobalDB(addonName)
	local savedVarName = addonName .. "_DB"
	_G[savedVarName] = _G[savedVarName] or {}
	-- Защита от повторов
	for _, entry in ipairs(E.OctoTable_SavedVariables or {}) do
		if entry.name == savedVarName then
			E.SavedVarsByAddon = E.SavedVarsByAddon or {}
			E.SavedVarsByAddon[addonName] = _G[savedVarName]
			return _G[savedVarName], savedVarName
		end
	end
	E.OctoTable_SavedVariables = E.OctoTable_SavedVariables or {}
	table.insert(E.OctoTable_SavedVariables, {
			tbl = _G[savedVarName],
			name = savedVarName
	})
	E.SavedVarsByAddon = E.SavedVarsByAddon or {}
	E.SavedVarsByAddon[addonName] = _G[savedVarName]
	return _G[savedVarName], savedVarName
end
function E.func_FormatMountInfo(mountID)
	local mountIcon = E.func_GetIcon("mount", mountID)
	local mountTexture = E.func_texturefromIcon(mountIcon)
	local mountName = mountTexture .. E.func_GetMountCollectedColor(mountID) .. E.func_GetName("mount", mountID) .. "|r"
	return mountName
end
function E.func_FormatMoney(number)
	if not number or type(number) ~= "number" then return 0 end
	if number > 10000 then
		return E.func_CompactFormatNumber(number/10000) .. "|r" .. "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
	elseif number > 100 then
		return E.func_CompactFormatNumber(number/100) .. "|r" .. "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
	else
		return E.func_CompactFormatNumber(number) .. "|r" .. "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
	end
end
function E.func_CompactRoundNumber(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math.floor(number+.5)
	end
end
function E.func_SecondsToClock(t, allwaysShowSeconds, fullFormat)
	local t = tonumber(t) or 0
	if t <= 0 then
		return ""
	end
	local years = math.floor(t / 31536000)
	local days = math.floor(t % 31536000 / 86400)
	local hours = math.floor(t % 86400 / 3600)
	local mins = math.floor(t % 3600 / 60)
	local secs = math.floor(t % 60)
	local ms = t - math.floor(t)
	local parts = {}
	if years > 0 then
		table.insert(parts, years .. L["y"])
		table.insert(parts, days .. L["d"])
		if fullFormat then
			table.insert(parts, hours .. L["h"])
			table.insert(parts, mins .. L["m"])
			if allwaysShowSeconds then
				table.insert(parts, secs .. L["s"])
			end
		end
	elseif days > 0 then
		table.insert(parts, days .. L["d"])
		table.insert(parts, hours .. L["h"])
		if fullFormat then
			table.insert(parts, mins .. L["m"])
			if allwaysShowSeconds then
				table.insert(parts, secs .. L["s"])
			end
		end
	elseif hours > 0 then
		table.insert(parts, hours .. L["h"])
		table.insert(parts, string.format("%02d", mins) .. L["m"])
		if fullFormat then
			if allwaysShowSeconds then
				table.insert(parts, string.format("%02d", secs) .. L["s"])
			end
		end
	elseif t >= 60 then
		table.insert(parts, mins .. L["m"])
		if fullFormat then
			if t < 600 or allwaysShowSeconds then
				table.insert(parts, secs .. L["s"])
			end
		end
	elseif t >= 1 then
		table.insert(parts, secs .. L["s"])
	else
		table.insert(parts, string.format("%.3f", t) .. "ms")
	end
	return table.concat(parts, " ")
end
function E.func_texturefromIconEVENT(icon, iconSize)
	iconSize = iconSize or 16
	return "|T" .. (icon or E.ICON_QUESTION_MARK) .. ":" .. (iconSize) .. ":" .. (iconSize) .. ":::128:128:0:91:0:91|t "
end
function E.func_GetPlayerLocation()
	-- Получаем текстовые данные о местоположении
	local curRealZone = GetRealZoneText()
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText()
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText()
	-- Получаем ID карты для игрока
	local uiMapID = MapUtil.GetDisplayableMapForPlayer()
	if uiMapID ~= 0 then
		local mapInfo = E.func_GetMapInfo(uiMapID)
		if mapInfo then
			local uiMapGroupID = E.func_GetMapGroupID(uiMapID)
			if uiMapGroupID then
				local mapGroupInfo = E.func_GetMapGroupMembersInfo(uiMapGroupID)
				if mapGroupInfo then
					for _, mapGroupMemberInfo in ipairs(mapGroupInfo) do
						if mapGroupMemberInfo.mapID == uiMapID then
							mapInfo.name = ("%s (%s)"):format(mapInfo.name, mapGroupMemberInfo.name)
							break
						end
					end
				end
			end
			-- Логика определения текста для возврата
			if FIRSTtext == "" then
				return E.COLOR_RED .. mapInfo.name .. "|r", false
			elseif FIRSTtext == SECONDtext then
				return FIRSTtext, true
			else
				return SECONDtext ~= "" and FIRSTtext .. " (" .. SECONDtext .. ")" or FIRSTtext, true
			end
		end
	end
	return E.TEXT_UNKNOWN, true
end

function E.func_IsOnQuest_DB(questID, cm)
	if not questID or not cm then return false end
	if cm.ListOfQuests and cm.ListOfQuests[questID] then
		return true
	end
	return false
end

function E.func_GetQuestStatus(questID, forceBoolean, short)
	if not questID then return "" end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтый делается
	-- фиолетовый можно сдать

	if E.func_IsFailed(questID) then
		result = E.COLOR_RED .. L["FAILED"] .. "|r"
	elseif E.func_IsQuestFlaggedCompleted(questID) then
		if forceBoolean then
			result = true
		else
			result = E.DONE
		end
	elseif E.func_IsComplete(questID) then
		-- if short then
		--     result = E.COLOR_PURPLE .. ">" .. " + " .. "<|r" -- E.DONE -- L["DONE"]
		-- else
		result = E.COLOR_PURPLE .. ">" .. L["QUEST_WATCH_QUEST_READY"] .. "<|r"
		-- end
	elseif not E.func_IsOnQuest(questID) then
		result = nil
	else
		-- result =  E.func_FormatQuestProgress(questID)
		local objectives = E.func_GetQuestObjectives(questID)
		if not objectives then
			result = ""
		else
			local parts = {}
			for i = 1, #objectives do
				local objective = objectives[i]
				if objective then
					local currQ, maxQ = 0, 0
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
					currQ = numFulfilled or 0
					maxQ = numRequired or 0
					if not numRequired then
						currQ, maxQ = 0, 1
					end
					local color = finished and E.COLOR_YELLOW or E.COLOR_RED
					local text
					if objectiveType == "progressbar" then
						text = color .. GetQuestProgressBarPercent(questID) .. "%|r"
					else
						text = color .. currQ .. "/" .. maxQ .. "|r"
					end
					table.insert(parts, text)
				end
			end
			result = table.concat(parts, " ")
		end
	end
	return result

end
function E.func_GetRealmShortName(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	local isRemix = E.IsRemix and " (Remix)" or ""
	local output
	if b then
		output = utf8sub(a, 1, 1):upper() .. utf8sub(b, 1, 1):upper()
	else
		output = utf8sub(a, 1, 1):upper() .. utf8sub(a, 2, 3):lower()
	end
	return output .. isRemix
end
-- /dump OctoEngine.curServerShort
-- /dump OctoEngine.curServer
E.curServerShort = E.func_GetRealmShortName(GetRealmName())
function E.func_GetPlayerRealm()
	local result = GetRealmName()
	if E.IsRemix then
		result = result .. " (Remix)"
	end
	return result
end
E.curServer = E.func_GetPlayerRealm()
function E.func_TableRemoveDuplicates(table1)
	if type(table1) ~= "table" then
		return {}
	end
	local seen = {}
	local write_idx = 1
	for i = 1, #table1 do
		local value = table1[i]
		if not seen[value] then
			seen[value] = true
			if write_idx ~= i then
				table1[write_idx] = value
			end
			write_idx = write_idx + 1
		end
	end
	for i = write_idx, #table1 do
		table1[i] = nil
	end
	return table1
end
function E.func_GetFactionIcon(faction)
	if faction == "Horde" then
		return 2565244
	elseif faction == "Alliance" then
		return 2565243
	else
		return 775462
	end
end
function E.func_FormatResetType(text)
	if not text then return end
	local result = ""
	if text == "Regular" then
		result = E.COLOR_YELLOW .. "O|r"
	elseif text == "Daily" then
		result = E.COLOR_BLUE .. "D|r"
	elseif text == "Weekly" then
		result = E.COLOR_PURPLE .. "W|r"
	elseif text == "Month" then
		result = E.COLOR_RED .. "M|r"
	end
	return result
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
do
	local CompactSuffixes = {
		enUS = { "", "k", "M", "B", "T" },
		enGB = { "", "k", "M", "B", "T" },
		ruRU = { "", " тыс.", " млн", " млрд", " трлн" },
		deDE = { "", " Tsd.", " Mio.", " Mrd.", " Bio." },
		frFR = { "", " k", " M", " Md", " T" },
		esES = { "", " mil", " M", " mil M", " B" },
		esMX = { "", " mil", " M", " mil M", " B" },
		ptBR = { "", " mil", " mi", " bi", " tri" },
		itIT = { "", " mila", " mln", " mld", " tln" },
		zhCN = { "", "万", "亿", "兆" },
		zhTW = { "", "萬", "億", "兆" },
		koKR = { "", "만", "억", "조" },
	}
	local AsianLocales = {
		zhCN = true,
		zhTW = true,
		koKR = true,
	}
	local function FormatWithSeparators(num)
		local formatted = tostring(num)
		while true do
			local k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1 %2")
			if k == formatted then break end
			formatted = k
		end
		return formatted
	end

	function E.func_CompactFormatNumber(num)
		num = num or 0
		local locale = "enUS"
		local suffixes = CompactSuffixes["enUS"]
		local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
		local mode = settingsProfile.Config_numberFormatMode or 1
		local STEP_WEST = 1000
		local STEP_ASIA = 10000
		local step = STEP_WEST

		-- mode 1 - компактный с усечением до 1 знака
		if mode == 1 then
			suffixes = CompactSuffixes["enUS"]
			step = STEP_WEST

			local i = 1
			local sign = num < 0 and -1 or 1
			local value = math.abs(num)

			while value >= step and i < #suffixes do
				value = value / step
				i = i + 1
			end

			-- Усекаем до 1 знака (1.999 -> 1.9, НЕ 2)
			local truncated = math.floor(value * 10) / 10
			local result = truncated * sign
			local s = tostring(result):gsub("%.0$", "")
			return s .. suffixes[i]

		elseif mode == 2 then
			locale = E.curLocaleLang
			suffixes = CompactSuffixes[locale] or CompactSuffixes["enUS"]
			step = AsianLocales[locale] and STEP_ASIA or STEP_WEST

			local i = 1
			local sign = num < 0 and -1 or 1
			local value = math.abs(num)

			while value >= step and i < #suffixes do
				value = value / step
				i = i + 1
			end

			-- Усекаем до 1 знака
			local truncated = math.floor(value * 10) / 10
			local result = truncated * sign
			local s = tostring(result):gsub("%.0$", "")
			return s .. suffixes[i]

		elseif mode == 3 then
			return FormatWithSeparators(math.floor(num + 0.5))
		elseif mode == 4 then
			return tostring(math.floor(num + 0.5))
		elseif mode == 5 then
			if AbbreviateLargeNumbers then
				return AbbreviateLargeNumbers(math.floor(num + 0.5))
			else
				return tostring(math.floor(num + 0.5))
			end
		elseif mode == 6 then
			local i = 1
			local sign = num < 0 and -1 or 1
			local value = math.abs(num)

			while value >= step and i < #suffixes do
				value = value / step
				i = i + 1
			end

			-- Усекаем до 1 знака
			local truncated = math.floor(value * 10) / 10
			local result = truncated * sign
			local s = tostring(result):gsub("%.0$", "")
			return s .. suffixes[i]
		end

		-- fallback (никогда не сработает, но оставлю)
		return tostring(math.floor(num + 0.5))
	end
end
----------------------------------------------------------------
function E.func_GetSpecializationIconSafe()
	local specIndex = GetSpecialization()
	if specIndex then
		local _, _, _, icon = GetSpecializationInfo(specIndex)
		return icon
	end
	return nil
end
----------------------------------------------------------------
function E.func_UpdateFont()
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	settingsProfile.FontOption = settingsProfile.FontOption or {}
	settingsProfile.FontOption[E.curLocaleLang] = settingsProfile.FontOption[E.curLocaleLang] or {}

	local Config_FontStyle = settingsProfile.FontOption[E.curLocaleLang].Config_FontStyle
	local Config_FontSize = settingsProfile.FontOption[E.curLocaleLang].Config_FontSize
	local Config_FontFlags = settingsProfile.FontOption[E.curLocaleLang].Config_FontFlags
	local fontPath = LibSharedMedia:Fetch("font", Config_FontStyle)

	E.OctoFont10:CopyFontObject(GameTooltipText)
	E.OctoFont10:SetFont(fontPath, Config_FontSize-1, Config_FontFlags)

	E.OctoFont11:CopyFontObject(GameTooltipText)
	E.OctoFont11:SetFont(fontPath, Config_FontSize, Config_FontFlags)

	E.OctoFont22:CopyFontObject(SystemFont_Outline_Small)
	E.OctoFont22:SetFont(fontPath, 22, Config_FontFlags)

	Octo_MeasureFrame.measureText:SetFontObject(OctoFont11)
end
----------------------------------------------------------------
function E.func_GetSlotNameForEmptySlot(slotID)
	local slotAPIName = E.OctoTable_SlotMapping[slotID].name
	if slotAPIName then
		return _G[slotAPIName] or slotAPIName
	end
	return "Slot " .. slotID
end
----------------------------------------------------------------
function E.func_GetEmptySlotIcon(slotID)
	local slotAPIName = E.OctoTable_SlotMapping[slotID].name
	if slotAPIName then
		local _, texture = GetInventorySlotInfo(slotAPIName)
		return texture or 134400
	end
	return 134400
end
----------------------------------------------------------------
function E.func_CanCollectData()
	local db = Octo_ToDo_DB_Levels
	if not db then return false end
	local char = db[E.curGUID]
	if not char then return false end
	return char.MASLENGO ~= nil and char.PlayerData ~= nil
end
----------------------------------------------------------------
function E.func_RefreshTranslations()
	wipe(E.L)
end
----------------------------------------------------------------
function E.func_Save(v)
	if v and issecretvalue(v) then return end
	if v == false or v == 0 then
		return nil
	end
	return v
end
----------------------------------------------------------------
function E.func_formatMplusKey(keyStoneLevel, OwnedKeystoneChallengeMapID, needIcon, fullName, forcedColor)
	if not keyStoneLevel or not OwnedKeystoneChallengeMapID then return "" end
	local levelPart = keyStoneLevel
	local namePart = ""
	local iconPart = ""
	local colorPart = forcedColor and forcedColor or E.COLOR_PURPLE
	-- pd.CurrentKey
	local texture = E.func_GetIcon("challenge", OwnedKeystoneChallengeMapID)
	local name = E.func_GetName("challenge", OwnedKeystoneChallengeMapID)
	if fullName then
		namePart = name
	elseif not fullName and E.OctoTable_KeystoneAbbr[OwnedKeystoneChallengeMapID] then -- dungeonID
		namePart = E.OctoTable_KeystoneAbbr[OwnedKeystoneChallengeMapID].abbreviation or E.TEXT_UNKNOWN
	else
		namePart = name
	end
	if needIcon and texture then
		iconPart = E.func_texturefromIcon(texture)
	end
	local result = iconPart .. colorPart .. levelPart .. " " .. namePart .. "|r"
	return result
end
function E.func_DB_FRAME_Color(frame, Type, r, g, b, a, UseFaction, UseClass)
	if not frame then return end
	if UseClass then
		r, g, b = E.func_Hex2RGBA(E.classColorHexCurrent)
	elseif UseFaction then
		r, g, b = E.func_Hex2RGBA(E.COLOR_FACTION)
	end
	if Type == "frame" then
		frame:SetBackdropColor(r, g, b, a)
	elseif Type == "border" then
		frame:SetBackdropBorderColor(r, g, b, a)
	elseif Type == "highlight" then
		frame.highlight:SetVertexColor(r, g, b) -- a?
	end
end
function E.func_UpdateGlobals()
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if not settingsProfile then return end
	if settingsProfile.Config_ADDON_HEIGHT then
		E.GLOBAL_LINE_HEIGHT = settingsProfile.Config_ADDON_HEIGHT
		E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2
		E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
	end
	settingsProfile.FontOption = settingsProfile.FontOption or {}
	settingsProfile.FontOption[E.curLocaleLang] = settingsProfile.FontOption[E.curLocaleLang] or {}
	if settingsProfile.FontOption[E.curLocaleLang].Config_FontStyle then
		E.func_UpdateFont()
	end
	if Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.SETTINGS and Octo_Todo_DB_Profiles.SETTINGS.CURRENT then
		E.func_CreateProfile("SETTINGS", Octo_Todo_DB_Profiles.SETTINGS.CURRENT)
	end
	----------------------------------------------------------------
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	E.PROFTBL = settingsProfile

	if E.PROFTBL then
		local UseFaction = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseFaction_CONFIG
		local UseClass = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseClass_CONFIG

		do
			local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
			if MAIN_FRAME then
				E.Octo_SearchBox_OnShow(MAIN_FRAME)
			end
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_faction_Horde_r, E.PROFTBL.ConfigColor_faction_Horde_g, E.PROFTBL.ConfigColor_faction_Horde_b, E.PROFTBL.ConfigColor_faction_Horde_a
			E.COLOR_HORDE = E.func_RGB2Hex(r, g, b, a)
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_faction_Alliance_r, E.PROFTBL.ConfigColor_faction_Alliance_g, E.PROFTBL.ConfigColor_faction_Alliance_b, E.PROFTBL.ConfigColor_faction_Alliance_a
			E.COLOR_ALLIANCE = E.func_RGB2Hex(r, g, b, a)
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_faction_Neutral_r, E.PROFTBL.ConfigColor_faction_Neutral_g, E.PROFTBL.ConfigColor_faction_Neutral_b, E.PROFTBL.ConfigColor_faction_Neutral_a
			E.COLOR_NEUTRAL = E.func_RGB2Hex(r, g, b, a)
			E.COLOR_FACTION = E.FACTION_CURRENT == "Horde" and E.COLOR_HORDE or E.FACTION_CURRENT == "Alliance" and E.COLOR_ALLIANCE or E.Class_Monk_Color
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_MAIN_MainFrame_r, E.PROFTBL.ConfigColor_MAIN_MainFrame_g, E.PROFTBL.ConfigColor_MAIN_MainFrame_b, E.PROFTBL.ConfigColor_MAIN_MainFrame_a
			for k, frame in next, (E.OctoTable_ColoredFrames) do
				E.func_DB_FRAME_Color(frame, "frame", r, g, b, a, UseFaction, UseClass)
			end
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_r, E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_g, E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_b, E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_a
			-- E.func_DB_FRAME_Color(Octo_TooltipFrame, "frame", r, g, b, a, UseFaction, UseClass)
			for k, frame in next, (E.OctoTable_ColoredTooltips) do
				E.func_DB_FRAME_Color(frame, "frame", r, g, b, a, UseFaction, UseClass)
			end
		end
		----------------------------------------------------------------
		do
			local r, g, b, a = E.PROFTBL.ConfigColor_MAIN_Border_r, E.PROFTBL.ConfigColor_MAIN_Border_g, E.PROFTBL.ConfigColor_MAIN_Border_b, E.PROFTBL.ConfigColor_MAIN_Border_a
			for k, frame in next, (E.OctoTable_ColoredFrames) do
				E.func_DB_FRAME_Color(frame, "border", r, g, b, a, UseFaction, UseClass)
			end
			for k, frame in next, (E.OctoTable_ColoredTooltips) do
				E.func_DB_FRAME_Color(frame, "border", r, g, b, a, UseFaction, UseClass)
			end
		end
		----------------------------------------------------------------
	end
	----------------------------------------------------------------

end
-- function E.func_UpdateGlobals()
--     E.func_SpamBlock(func_UpdateGlobals, true, 1)
-- end
----------------------------------------------------------------
function E.func_DB_REP_COLOR(repType, reaction)
	local color = E.COLOR_DARKGRAY
	if not repType or not reaction or not E.PROFTBL then return color end
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	local r, g, b, a = 0.5, 0.5, 0.5, 0.5

	if repType == 1 and reaction and type(reaction) == "number" and reaction > 0 then
		r = settingsProfile["CONFIG_REPUTATION_SIMPLE_COLOR_" .. reaction .. "_R"]
		g = settingsProfile["CONFIG_REPUTATION_SIMPLE_COLOR_" .. reaction .. "_G"]
		b = settingsProfile["CONFIG_REPUTATION_SIMPLE_COLOR_" .. reaction .. "_B"]
		a = settingsProfile["CONFIG_REPUTATION_SIMPLE_COLOR_" .. reaction .. "_A"]
	elseif repType == 2 then
		r = settingsProfile.CONFIG_REPUTATION_FRIEND_COLOR_R
		g = settingsProfile.CONFIG_REPUTATION_FRIEND_COLOR_G
		b = settingsProfile.CONFIG_REPUTATION_FRIEND_COLOR_B
		a = settingsProfile.CONFIG_REPUTATION_FRIEND_COLOR_A -- E.func_GetProfile_SETTINGS_CURRENT().CONFIG_REPUTATION_FRIEND_COLOR_A
	elseif repType == 3 then
		r = settingsProfile.CONFIG_REPUTATION_MAJOR_COLOR_R
		g = settingsProfile.CONFIG_REPUTATION_MAJOR_COLOR_G
		b = settingsProfile.CONFIG_REPUTATION_MAJOR_COLOR_B
		a = settingsProfile.CONFIG_REPUTATION_MAJOR_COLOR_A
	elseif repType == 4 then
		r = settingsProfile.CONFIG_REPUTATION_PARAGON_COLOR_R
		g = settingsProfile.CONFIG_REPUTATION_PARAGON_COLOR_G
		b = settingsProfile.CONFIG_REPUTATION_PARAGON_COLOR_B
		a = settingsProfile.CONFIG_REPUTATION_PARAGON_COLOR_A
	end
	color = E.func_RGB2Hex(r, g, b, a)

	return color
end
----------------------------------------------------------------
function E.func_DB_COV_COLOR(covenantID)
	local result = E.COLOR_WHITE
	if not E.PROFTBL then return result end
	if covenantID == 1 then
		local r = E.PROFTBL.ConfigColor_KYRIAN_r
		local g = E.PROFTBL.ConfigColor_KYRIAN_g
		local b = E.PROFTBL.ConfigColor_KYRIAN_b
		local a = E.PROFTBL.ConfigColor_KYRIAN_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 2 then
		local r = E.PROFTBL.ConfigColor_VENTHYR_r
		local g = E.PROFTBL.ConfigColor_VENTHYR_g
		local b = E.PROFTBL.ConfigColor_VENTHYR_b
		local a = E.PROFTBL.ConfigColor_VENTHYR_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 3 then
		local r = E.PROFTBL.ConfigColor_NIGHTFAE_r
		local g = E.PROFTBL.ConfigColor_NIGHTFAE_g
		local b = E.PROFTBL.ConfigColor_NIGHTFAE_b
		local a = E.PROFTBL.ConfigColor_NIGHTFAE_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 4 then
		local r = E.PROFTBL.ConfigColor_NECROLORD_r
		local g = E.PROFTBL.ConfigColor_NECROLORD_g
		local b = E.PROFTBL.ConfigColor_NECROLORD_b
		local a = E.PROFTBL.ConfigColor_NECROLORD_a
		result = E.func_RGB2Hex(r, g, b, a)
	end
	return result
end
----------------------------------------------------------------
function E.func_DB_FACTION_COLOR(CharInfo)
	local r, g, b, a = 1, 1, 1, 1
	if not E.PROFTBL then return r, g, b, a end
	if not CharInfo then return r, g, b, a end
	local pd = CharInfo.PlayerData
	local faction = pd.FACTION or "Neutral"
	local result = E.Class_Monk_Color
	if faction == "Horde" then
		r = E.PROFTBL.ConfigColor_faction_Horde_r
		g = E.PROFTBL.ConfigColor_faction_Horde_g
		b = E.PROFTBL.ConfigColor_faction_Horde_b
		a = E.PROFTBL.ConfigColor_faction_Horde_a
	elseif faction == "Alliance" then
		r = E.PROFTBL.ConfigColor_faction_Alliance_r
		g = E.PROFTBL.ConfigColor_faction_Alliance_g
		b = E.PROFTBL.ConfigColor_faction_Alliance_b
		a = E.PROFTBL.ConfigColor_faction_Alliance_a
	elseif faction == "Neutral" then
		r = E.PROFTBL.ConfigColor_faction_Neutral_r
		g = E.PROFTBL.ConfigColor_faction_Neutral_g
		b = E.PROFTBL.ConfigColor_faction_Neutral_b
		a = E.PROFTBL.ConfigColor_faction_Neutral_a
	end
	return r, g, b, a
end
----------------------------------------------------------------
function E.func_DB_HEADER_COLOR(CharInfo)
	local r, g, b, a = 1, 1, 1, 1
	if not E.PROFTBL then return r, g, b, a end
	if not CharInfo then return r, g, b, a end
	local pd = CharInfo.PlayerData
	if not pd then return r, g, b, a end

	local colorTYPE = E.PROFTBL.ConfigColor_CharHeader_TYPE
	if colorTYPE == 0 then -- CUSTOM
		r = E.PROFTBL.ConfigColor_CharHeader_r
		g = E.PROFTBL.ConfigColor_CharHeader_g
		b = E.PROFTBL.ConfigColor_CharHeader_b
	elseif colorTYPE == 1 then -- FACTION
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif colorTYPE == 2 then -- CLASS
		local classColorHex = pd.classColorHex or E.COLOR_WHITE
		r, g, b = E.func_Hex2RGBA(classColorHex)
	end
	a = E.PROFTBL.ConfigColor_CharHeader_a
	return r, g, b, a
end
----------------------------------------------------------------
function E.func_DB_CHARLINE_COLOR(CharInfo)
	local r, g, b, a = 1, 1, 1, 1
	if not E.PROFTBL then return r, g, b, a end
	local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
	-- if not CharInfo then return r, g, b, a end
	local pd = CharInfo.PlayerData
	if not pd then return r, g, b, a end

	local colorTYPE = E.PROFTBL.ConfigColor_CharLines_TYPE
	if colorTYPE == 0 then -- CUSTOM
		r = E.PROFTBL.ConfigColor_CharLines_r
		g = E.PROFTBL.ConfigColor_CharLines_g
		b = E.PROFTBL.ConfigColor_CharLines_b
	elseif colorTYPE == 1 then -- FACTION
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif colorTYPE == 2 then -- CLASS
		local classColorHex = pd.classColorHex or E.COLOR_WHITE
		r, g, b = E.func_Hex2RGBA(classColorHex)
	end
	a = E.PROFTBL.ConfigColor_CharLines_a
	return r, g, b, a
end


----------------------------------------------------------------
local function ResetHighlightState(frame)
	if frame.highlightLeave then
		frame.highlightLeave:Stop()
	end
	if frame.highlight then
		frame.highlight:SetAlpha(0)
	end
	if frame.HighlightTexture then
		frame.HighlightTexture:SetAlpha(0)
	end
end

local function Highlight_OnShow(self, frame, alpha)
	if E.PROFTBL then
		local r = E.PROFTBL.ConfigColor_Highlight_r
		local g = E.PROFTBL.ConfigColor_Highlight_g
		local b = E.PROFTBL.ConfigColor_Highlight_b
		local a = E.PROFTBL.ConfigColor_Highlight_a

		local UseFaction = false
		local UseClass = false
		local colorTYPE = E.PROFTBL.ConfigColor_Highlight_TYPE
		if colorTYPE == 0 then -- CUSTOM
			r = E.PROFTBL.ConfigColor_CharLines_r
			g = E.PROFTBL.ConfigColor_CharLines_g
			b = E.PROFTBL.ConfigColor_CharLines_b
		elseif colorTYPE == 1 then -- FACTION
			UseFaction = true
			r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
		elseif colorTYPE == 2 then -- CLASS
			UseClass = true
			r, g, b = E.func_Hex2RGBA(E.classColorHexCurrent)
		end
		alpha:SetFromAlpha(E.PROFTBL.ConfigColor_Highlight_a or .2)
		E.func_DB_FRAME_Color(frame, "highlight", r, g, b, a, UseFaction, UseClass)
		ResetHighlightState(self)
	end
end

----------------------------------------------------------------
-- function E.func_DB_HIGHLIGHT_COLOR()
-- local r, g, b, a = 1, 1, 1, 1
-- return r, g, b, a
-- end
----------------------------------------------------------------
function E.func_ApplyHighlightTemplate(frame, anchorFrame)
	if not frame or not anchorFrame or frame.highlight then
		return
	end
	if anchorFrame then
		frame:SetFrameLevel(anchorFrame:GetFrameLevel() - 2)
		frame:SetPoint("LEFT", anchorFrame)
		frame:SetPoint("TOP", anchorFrame)
		frame:SetPoint("BOTTOM", anchorFrame)
		frame:SetPoint("RIGHT")
	end
	-- =========================
	-- Overlay Texture
	-- =========================
	-- local bg = frame:CreateTexture(nil, "BACKGROUND")
	-- bg:SetAtlas(E.TEXTURE_HIGHLIGHT_ATLAS)
	-- bg:SetAlpha(0)
	-- bg:SetBlendMode("ADD")
	-- bg:SetAllPoints(frame)
	-- frame.highlight = bg
	local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
	bg:Hide()
	bg:SetTexture(E.TEXTURE_CHAR_PATH) --E.TEXTURE_HIGHLIGHT_PATH
	bg:SetAlpha(0)
	-- bg:SetAllPoints(frame)
	bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, 0) -- отступ слева 1 пиксель
	bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 0) -- отступ справа 1 пиксель
	frame.highlight = bg
	-- =========================
	-- Animation (fade-out)
	-- =========================
	local ag = bg:CreateAnimationGroup()
	ag:SetToFinalAlpha(true)
	local alpha = ag:CreateAnimation("Alpha")
	alpha:SetOrder(1)
	alpha:SetDuration(0.3)
	alpha:SetSmoothing("IN_OUT")
	alpha:SetToAlpha(0)
	ag.alpha = alpha
	frame.highlightLeave = ag
	-- =========================
	-- Scripts
	-- =========================
	local function ResetHighlightState(self)
		if self.highlightLeave then
			self.highlightLeave:Stop()
		end
		if self.highlight then
			self.highlight:SetAlpha(0)
		end
	end
	frame:SetScript("OnEnter", function(self)
			frame.highlight:Show()
			ResetHighlightState(self)
			self.highlight:SetAlpha(E.PROFTBL and E.PROFTBL.ConfigColor_Highlight_a or .2)
	end)
	frame:SetScript("OnLeave", function(self)
			-- frame.highlight:Hide()
			ResetHighlightState(self)
			if E.PROFTBL and E.PROFTBL.ConfigColor_ENABLE_HIGHLIGHT_ANIMATION then
				-- При выключенном флаге, используем fade
				self.highlightLeave:Restart()
			end
			GameTooltip:Hide()
	end)
	frame:SetScript("OnShow", function(self)
		Highlight_OnShow(self, frame, alpha)
	end)
	frame:GetScript("OnShow")(frame)
end
----------------------------------------------------------------
function E.func_Create_Highlight(frame, owner)
	if E.ENABLE_HIGHTLIGHT then
		frame.Highlight = CreateFrame("FRAME", nil, owner, "OctoRectTemplate")
		-- frame.Highlight:SetFrameLevel(500)
		-- frame.Highlight:SetFrameStrata("TOOLTIP")
		E.func_ApplyHighlightTemplate(frame.Highlight, frame)
	end
end
----------------------------------------------------------------
local order_index = 0
function E.func_GetOrder()
	order_index = order_index + 1
	return order_index
end
----------------------------------------------------------------
function E.func_AutoKey()
	return tostring("key_" .. E.func_GetOrder())
end
----------------------------------------------------------------
local soundFile_OnEnter = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\OnEnter.ogg"
function E.sound_OnEnter()
	PlaySoundFile(soundFile_OnEnter, "Master")
end
----------------------------------------------------------------
local soundFile_OnClick = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\OnClick.ogg"
function E.sound_OnClick()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	-- PlaySoundFile(soundFile_OnClick, "Master")
end
----------------------------------------------------------------
local soundFile_Slider_OnValueChanged = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\Slider_OnValueChanged.ogg"
function E.sound_Slider_OnValueChanged()
	PlaySoundFile(soundFile_Slider_OnValueChanged, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Close = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\DropDown_Close.ogg"
function E.sound_DropDown_Close()
	PlaySoundFile(soundFile_DropDown_Close, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Open = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\DropDown_Open.ogg"
function E.sound_DropDown_Open()
	PlaySoundFile(soundFile_DropDown_Open, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Select = "Interface\\Addons\\" .. E.MainAddonName .. "\\Media\\sound\\DropDown_Select.ogg"
function E.sound_DropDown_Select()
	PlaySoundFile(soundFile_DropDown_Select, "Master")
end
----------------------------------------------------------------
local counter = 0
local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
local charLen = #chars
local function RandomString(len)
	local t = {}
	for i = 1, len do
		local r = math.random(charLen)
		t[i] = chars:sub(r, r)
	end
	return table.concat(t)
end
function E.func_GenerateID()
	counter = counter + 1
	local result = GlobalAddonName .. "_" .. RandomString(8) .. "_" .. counter
	return result
end
----------------------------------------------------------------
-- local allRanks = {}
-- for i = 1, 15 do
-- local text = L["AZERITE_ESSENCE_RANK"]:format(i)
-- allRanks[text] = true
-- end
-- local removePatter = L["AZERITE_ESSENCE_RANK"]:format(9999)
-- removePatter = removePatter:gsub("9999", "")
local scanner = CreateFrame("GameTooltip", "RankScannerTooltip", nil, "GameTooltipTemplate")
scanner:SetOwner(UIParent, "ANCHOR_NONE")
function E.GetItemRankFromLink(ItemLink)
	if not ItemLink then
		return nil
	end
	-- "15 rank" ENG
	-- "15-й уровень" RU
	-- "|cFF 0FFFF15-й уровень|r"
	local newPattern = L["AZERITE_ESSENCE_RANK"]:gsub("%%d", "^.-(%%d+).*")
	scanner:SetHyperlink(ItemLink)
	-- Проходим строки тултипа
	for i = 1, scanner:NumLines() do
		-- if i == 2 then
		local line = _G["RankScannerTooltipTextLeft" .. i]
		if line then
			local text = line:GetText()
			if text then
				local rank = text:gsub("|[Cc][%x ][%x ][%x ][%x ][%x ][%x ][%x ][%x ]", ""):match("%d+")
				rank = tonumber(rank)
				if rank then
					return rank
				end
				-- text = text:gsub("|r", "")
				-- text = text:gsub("|cFF 0FFFF", "")
				-- if allRanks[text] then
				-- text = text:gsub(removePatter, "")
				-- return tonumber(text)
				-- end
			end
		end
		-- end
	end
	return nil
end
----------------------------------------------------------------
function E.func_isAtlas(TextureOrAtlas)
	if not TextureOrAtlas then return false end
	if not C_Texture or not C_Texture.GetAtlasInfo then
		return false
	end
	local info = C_Texture.GetAtlasInfo(TextureOrAtlas)
	-- if info and info.name then
	if info and info.width then
		return true
	end
	return false
end
----------------------------------------------------------------
function E.func_SetupTextureToFrame(frame, texture)
	local isAtlas = E.func_isAtlas(texture)
	if isAtlas then
		frame:SetAtlas(texture)
	else
		frame:SetTexture(texture)
	end
end
function E.func_SetupTextureToToggleFrameWithValue(frame, value, isDiabled)
	if not frame then return end
	if value == true then
		E.func_SetupTextureToFrame(frame, E.ICON_SETTINGS_ACTIVE) -- ON
	elseif value == false then
		E.func_SetupTextureToFrame(frame, E.ICON_SETTINGS_INACTIVE) -- OFF
	else
		E.func_SetupTextureToFrame(frame, E.ICON_SETTINGS_DISABLED) -- GRAY
	end
	-- if not frameBG then return end
	-- E.func_SetupTextureToFrame(frameBG, E.ICON_SETTINGS_BACKGROUD) -- BG
end
----------------------------------------------------------------
function E.func_setTexture(frame, TextureOrAtlas, UseAtlasSize)
	if not frame or not TextureOrAtlas then return end
	local m = getmetatable(frame).__index
	if E.func_isAtlas(TextureOrAtlas) then
		m.SetAtlas(frame, TextureOrAtlas, UseAtlasSize or false)
	else
		m.SetTexture(frame, TextureOrAtlas)
	end
end
----------------------------------------------------------------
function E.func_texturefromIcon(icon, iconWidth, iconHeight)
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	if E.func_isAtlas(icon) then
		return E.func_GetAtlasIcon(icon, iconWidth, iconHeight)
	else
		return "|T" .. (icon or E.ICON_QUESTION_MARK) .. ":" .. (iconWidth) .. ":" .. (iconHeight) .. ":::64:64:6:58:6:58|t "
	end
end
----------------------------------------------------------------
function E.func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local RIO_COLORS = {
	{ threshold = 0, color = "GRAY" }, -- E.COLOR_GRAY
	{ threshold = 1, color = "WHITE" }, -- E.COLOR_WHITE
	{ threshold = 1000, color = "GREEN" }, -- E.COLOR_GREEN
	{ threshold = 1500, color = "BLUE" }, -- E.COLOR_BLUE
	{ threshold = 2000, color = "PURPLE" }, -- E.COLOR_PURPLE
	{ threshold = 2500, color = "ORANGE" }, -- E.COLOR_ORANGE
	{ threshold = 3000, color = "YELLOW" }, -- E.COLOR_YELLOW
	{ threshold = 3500, color = "PINK" }, -- E.COLOR_PINK
}
function E.func_RioColor(score)
	if not score or score == 0 then
		return E.COLOR_GRAY
	end
	for i = #RIO_COLORS, 1, -1 do
		if score >= RIO_COLORS[i].threshold then
			return E["COLOR_" .. RIO_COLORS[i].color]
		end
	end
	return E.COLOR_YELLOW
end
----------------------------------------------------------------
function E.func_defaultValue_tooltip(value, reloadRequare)
	local text = L["CURSOR_SIZE_DEFAULT"] .. ": "
	local reloadText = E.COLOR_RED .. "|n|n" .. L["Changes require a ReloadUI"] .. "|r"
	if type(value) == "boolean" then
		text = text .. (value and L["YES"] or L["NO"])
	elseif type(value) == "string" then
		text = text .. value
	elseif type(value) == "number" then
		text = text .. tostring(value)
	end
	if reloadRequare then
		text = text .. reloadText
	end
	return text
end
----------------------------------------------------------------
function E.func_auctionator_price(itemID)
	if not AUCTIONATOR_PRICE_DATABASE then return 0 end
	local price = Auctionator.API.v1.GetAuctionPriceByItemID(GlobalAddonName, itemID)
	return price or 0
end
----------------------------------------------------------------
function E.func_SetFlattensRenderLayers_OnAllFrames()
	-- SetFlattensRenderLayers()
	for k, frame in next, (E.OctoTable_ColoredFrames) do
		frame:SetFlattensRenderLayers(true)
	end
end
----------------------------------------------------------------
function E.func_CountCharacters()
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	local count = 0
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		count = count + 1
	end
	return count
end
----------------------------------------------------------------
function E.func_CountVisibleCharacters()
	local CharacterProfile, CharacterProfile_GUIDS, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()

	local CONFIG_SHOW_ONLY_CURRENT_SERVER = CharacterProfile.OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER or false
	local CONFIG_SHOW_ONLY_CURRENT_REGION = CharacterProfile.OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION or false
	local CONFIG_SHOW_LEVEL_MIN = CharacterProfile.OTHER.CONFIG_SHOW_LEVEL_MIN or 1
	local CONFIG_SHOW_LEVEL_MAX = CharacterProfile.OTHER.CONFIG_SHOW_LEVEL_MAX or 90
	local CONFIG_SHOW_ONLY_CURRENT_FACTION = CharacterProfile.OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION or false
	local CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = CharacterProfile.OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG or false
	local CONFIG_SHOW_ALWAYS_AS_FIRST = CharacterProfile.OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST or false
	local count = 0
	local curGUID = E.curGUID
	local FACTION = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local REGION_NAME = E.CURRENT_REGION_NAME
	local curBattleTag = E.curBattleTag
	local checkCurrentServer = CONFIG_SHOW_ONLY_CURRENT_SERVER and curServer
	local checkCurrentRegion = CONFIG_SHOW_ONLY_CURRENT_REGION and REGION_NAME
	local checkCurrentBtag = CONFIG_SHOW_ONLY_CURRENT_BATTLETAG and curBattleTag


	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				count = count + 1
			else
				if CharacterProfile_GUIDS[GUID] and
				PlayerData.UnitLevel and
				PlayerData.REGION_NAME and
				PlayerData.curServer and
				PlayerData.FACTION and
				PlayerData.BattleTag then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= CONFIG_SHOW_LEVEL_MIN and unitLevel <= CONFIG_SHOW_LEVEL_MAX
					local meetsFaction = not CONFIG_SHOW_ONLY_CURRENT_FACTION or PlayerData.FACTION == FACTION
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.REGION_NAME == REGION_NAME
					local meetsBtag = not checkCurrentBtag or PlayerData.BattleTag == curBattleTag
					if meetsLevel and meetsFaction and meetsServer and meetsRegion and meetsBtag then
						count = count + 1
					end
				end
			end
		end
	end
	return count > 0 and count or 1
end
----------------------------------------------------------------
function E.func_SortCharacters()
	local CharacterProfile, CharacterProfile_GUIDS, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()

	local CONFIG_SHOW_ONLY_CURRENT_SERVER = CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER or false
	local CONFIG_SHOW_ONLY_CURRENT_REGION = CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION or false
	local CONFIG_SHOW_LEVEL_MIN = CharacterProfile_OTHER.CONFIG_SHOW_LEVEL_MIN or 1
	local CONFIG_SHOW_LEVEL_MAX = CharacterProfile_OTHER.CONFIG_SHOW_LEVEL_MAX or 90
	local CONFIG_SHOW_ONLY_CURRENT_FACTION = CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION or false
	local CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG or false
	local CONFIG_SHOW_ALWAYS_AS_FIRST = CharacterProfile_OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST or false
	local CONFIG_SORTING_CUSTOM = CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM or false

	local visible = {}
	local visible_GUID = {}
	local hidden = {}
	local hidden_GUID = {}
	local filtered = {}
	local filtered_GUID = {}

	local curGUID = E.curGUID
	local FACTION = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local REGION_NAME = E.CURRENT_REGION_NAME
	local curBattleTag = E.curBattleTag
	local checkCurrentServer = CONFIG_SHOW_ONLY_CURRENT_SERVER and curServer
	local checkCurrentRegion = CONFIG_SHOW_ONLY_CURRENT_REGION and REGION_NAME
	local checkCurrentBtag = CONFIG_SHOW_ONLY_CURRENT_BATTLETAG and curBattleTag



	if CONFIG_SORTING_CUSTOM and CharacterProfile_SORTING and CharacterProfile_SORTING.GUID_order then
		for _, GUID in ipairs(CharacterProfile_SORTING.GUID_order) do
			local CharInfo = Octo_ToDo_DB_Levels and Octo_ToDo_DB_Levels[GUID]
			local pd = CharInfo and CharInfo.PlayerData
			if pd then
				if GUID == curGUID or CharacterProfile_GUIDS[GUID] then
					visible[#visible + 1] = CharInfo
					visible_GUID[GUID] = true
				else
					hidden[#hidden + 1] = CharInfo
					hidden_GUID[GUID] = true
				end
			end
		end
		E.func_ApplySort(hidden, curGUID, false)
		return visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID
	end

	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		if not CharInfo.PlayerData then
			filtered[#filtered + 1] = CharInfo
			filtered_GUID[GUID] = true
		else
			local pd = CharInfo.PlayerData
			local unitLevel = pd.UnitLevel
			local hasFields = unitLevel and pd.REGION_NAME and pd.curServer and pd.FACTION and pd.BattleTag
			if not hasFields then
				filtered[#filtered + 1] = CharInfo
				filtered_GUID[GUID] = true
			else
				local meetsLevel = unitLevel >= CONFIG_SHOW_LEVEL_MIN and unitLevel <= CONFIG_SHOW_LEVEL_MAX
				local meetsFaction = not CONFIG_SHOW_ONLY_CURRENT_FACTION or pd.FACTION == FACTION
				local meetsServer = not checkCurrentServer or pd.curServer == curServer
				local meetsRegion = not checkCurrentRegion or pd.REGION_NAME == REGION_NAME
				local meetsBtag = not checkCurrentBtag or pd.BattleTag == curBattleTag
				local passedFilters = meetsLevel and meetsFaction and meetsServer and meetsRegion and meetsBtag

				if GUID == curGUID then
					visible[#visible + 1] = CharInfo
					visible_GUID[GUID] = true
				elseif not passedFilters then
					filtered[#filtered + 1] = CharInfo
					filtered_GUID[GUID] = true
				elseif CharacterProfile_GUIDS[GUID] then
					visible[#visible + 1] = CharInfo
					visible_GUID[GUID] = true
				else
					hidden[#hidden + 1] = CharInfo
					hidden_GUID[GUID] = true
				end
			end
		end
	end
	E.func_ApplySort(visible, curGUID, CONFIG_SHOW_ALWAYS_AS_FIRST)
	E.func_ApplySort(hidden, curGUID, false)
	return visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID
end
----------------------------------------------------------------
function E.func_ApplySort(list, curGUID, alwaysFirst)
	local CharacterProfile, CharacterProfile_GUIDS, CharacterProfile_OTHER, CharacterProfile_SORTING = E.func_GetProfile_CHARACTERS_CURRENT()

	if not CharacterProfile_SORTING then return end
	local sortOrder = CharacterProfile_SORTING.sort_order or {}
	local sortOrderActived = CharacterProfile_SORTING.sort_order_ACTIVED or {}
	local sortReverse = CharacterProfile_SORTING.sort_reverse or {}

	local rules = {}

	-- Правило "текущий всегда первый"
	if alwaysFirst then
		table.insert(rules, function(a, b)
				local aIsCurrent = a.PlayerData and a.PlayerData.GUID == curGUID
				local bIsCurrent = b.PlayerData and b.PlayerData.GUID == curGUID
				if aIsCurrent ~= bIsCurrent then
					return aIsCurrent
				end
		end)
	end

	-- Правила по ключам с нормализацией
	for _, sortKey in ipairs(sortOrder) do
		if sortOrderActived[sortKey] then
			local reverse = sortReverse[sortKey]
			table.insert(rules, function(a, b)
					local aData = a.PlayerData
					local bData = b.PlayerData
					if not aData or not bData then return false end

					local aVal = aData[sortKey]
					local bVal = bData[sortKey]

					-- Замена nil на дефолтные значения
					if aVal == nil then aVal = (type(bVal) == "number") and 0 or "" end
					if bVal == nil then bVal = (type(aVal) == "number") and 0 or "" end

					-- Приведение типов
					if type(aVal) == "number" and type(bVal) ~= "number" then
						bVal = tonumber(bVal) or 0
					elseif type(aVal) ~= "number" and type(bVal) == "number" then
						aVal = tonumber(aVal) or 0
					end

					if aVal ~= bVal then
						if reverse then
							return aVal > bVal
						else
							return aVal < bVal
						end
					end
			end)
		end
	end

	-- Финальное правило: сортировка по имени
	table.insert(rules, function(a, b)
			local aData = a.PlayerData
			local bData = b.PlayerData
			local aName = aData and aData.Name or ""
			local bName = bData and bData.Name or ""
			return aName < bName
	end)

	-- Применяем сортировку с помощью универсальной функции
	E.func_SortRecords(list, unpack(rules))
end

function E.func_DELETEPERS(GUID)
	if not GUID or not Octo_ToDo_DB_Levels then return end
	-- Удаляем из основной таблицы
	Octo_ToDo_DB_Levels[GUID] = nil
	-- Удаляем из GUID_order всех профилей
	local profiles = Octo_Todo_DB_Profiles.CHARACTERS.profiles
	for _, profile in pairs(profiles) do
		if profile.SORTING and profile.SORTING.GUID_order then
			for i = #profile.SORTING.GUID_order, 1, -1 do
				if profile.SORTING.GUID_order[i] == GUID then
					tremove(profile.SORTING.GUID_order, i)
					break
				end
			end
		end
	end
	-- Обновляем счётчик персонажей
	E.TOTAL_CHARS = 0
	for _ in pairs(Octo_ToDo_DB_Levels) do
		E.TOTAL_CHARS = E.TOTAL_CHARS + 1
	end
end
----------------------------------------------------------------
function E.func_GetCounts()
	local numServers, numRegions, numBtags, numPlayers = 0, 0, 0, 0
	local seenServers = {}
	local seenRegions = {}
	local seenBtags = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if pd then
			local server = pd.curServer
			local btag = pd.BattleTag
			local region = pd.REGION_NAME
			if btag and not seenBtags[btag] then
				seenBtags[btag] = true
				numBtags = numBtags + 1
			end
			if region and not seenRegions[region] then
				seenRegions[region] = true
				numRegions = numRegions + 1
			end
			if server and not seenServers[server] then
				seenServers[server] = true
				numServers = numServers + 1
			end
			numPlayers = numPlayers + 1
		end
	end
	return numServers, numRegions, numBtags, numPlayers
end
----------------------------------------------------------------
-- function E.func_CreateUtilitySlider(parent, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
--     local MySlider = CreateFrame("Frame", nil, parent, "MinimalSliderWithSteppersTemplate")
--     MySlider:SetPoint("TOPLEFT", 0, -20)
--     -- MySlider:SetSize(200, 40) -- 250, 40
--     local formatters = {
--         [MinimalSliderWithSteppersMixin.Label.Min] = function(value) return minValue end, -- текст у минимального значения
--         [MinimalSliderWithSteppersMixin.Label.Max] = function(value) return maxValue end, -- текст у максимального значения
--         [MinimalSliderWithSteppersMixin.Label.Left] = function(value) return LeftText end, -- левый текст (Low)
--         [MinimalSliderWithSteppersMixin.Label.Right] = function(value) return tostring(math.floor(value)) end, -- правый текст (значение)
--         [MinimalSliderWithSteppersMixin.Label.Top] = function(value) return name end, -- текст сверху
--     }
--     local currentValue = variableTbl[variableKey] or defaultValue or 1
--     MySlider:Init(currentValue, 1, 100, step, formatters)
--     MySlider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
--             local rounded = math.floor(value)
--             variableTbl[variableKey] = rounded
--             -- MySlider.MinText:SetText(minValue)
--             -- MySlider.MaxText:SetText(maxValue)
--             -- MySlider.LeftText:SetText(LeftText)
--             -- MySlider.RightText:SetText(tostring(math.floor(value)))
--             -- MySlider.TopText:SetText(name)-- текст сверху
--     end)
-- end
----------------------------------------------------------------
function E.func_MeasureTextWidth(textToMeasure, minWidth, indent)
	minWidth = minWidth or 1
	indent = indent or 0
	local measureText = Octo_MeasureFrame.measureText
	local width = 0
	if type(textToMeasure) == "table" then
		for i = 1, #textToMeasure do
			local v = textToMeasure[i]
			if type(v) == "function" then
				v = v()
			end
			measureText:SetText(tostring(v or ""))
			width = math.max(width, measureText:GetStringWidth())
		end
	else
		local v = type(textToMeasure) == "function" and textToMeasure() or textToMeasure
		measureText:SetText(tostring(v or ""))
		width = measureText:GetStringWidth()
	end
	return math.max(math.ceil(width) + indent, minWidth)
end
----------------------------------------------------------------
function E.func_Percent(numerator, denominator, decimalPlaces)
	numerator = numerator or 0
	denominator = denominator or 0
	if denominator == 0 then
		return 0
	end
	local exact = (numerator / denominator) * 100
	if decimalPlaces then
		local multiplier = 10 ^ decimalPlaces
		return math.floor(exact * multiplier + 0.5) / multiplier
	else
		return exact
	end
end
----------------------------------------------------------------
function E.CreateSettingsButton(parent)
	local button = CreateFrame("BUTTON", nil, parent, "OctoRectTemplate")
	button:SetSize(E.GLOBAL_LINE_HEIGHT, E.GLOBAL_LINE_HEIGHT)
	button:SetPoint("LEFT", 1, -1)
	button:RegisterForClicks("LeftButtonUp")
	button:EnableMouse(true)
	button:SetCollapsesLayout(true)
	local texture = button:CreateTexture(nil, "BACKGROUND", nil, 5)
	texture:SetPoint("CENTER")
	texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
	-- texture:SetTexCoord(0.1, 0.9, 0.1, 0.9) -- zoom 10%
	button.texture = texture
	return button, texture
end
----------------------------------------------------------------
function E.CreateIconFrame(parent, anchorFrame)
	parent.type = "icon"
	local frame = CreateFrame("FRAME", nil, parent)
	frame:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
	if anchorFrame then
		frame:SetPoint("LEFT", anchorFrame, "RIGHT")
	else
		frame:SetPoint("CENTER")
	end
	frame:Hide()
	frame:SetCollapsesLayout(true)
	local texture = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
	texture:SetPoint("CENTER")
	texture:SetSize(E.GLOBAL_LINE_HEIGHT-2, E.GLOBAL_LINE_HEIGHT-2)
	texture:SetTexCoord(0.1, 0.9, 0.1, 0.9) -- zoom 10%
	frame.texture = texture
	return frame, texture
end
----------------------------------------------------------------
function E.func_CreateStandardText(parent, anchorFrame, justifyH)
	if not parent then return end
	parent.type = "text"
	local text = parent:CreateFontString()
	text:SetFontObject(OctoFont11)
	text:SetJustifyV("MIDDLE")
	text:SetTextColor(E.textR, E.textG, E.textB, E.textA)
	text:SetWordWrap(false)
	text:SetJustifyH(justifyH or "LEFT")
	if anchorFrame and anchorFrame ~= parent then
		-- Текст справа от anchorFrame
		text:SetPoint("LEFT", anchorFrame, "RIGHT") -- , E.INDENT_TEXT, 0)
		text:SetPoint("RIGHT", parent, "RIGHT") -- , -E.INDENT_TEXT, 0)
	else
		-- Текст на всю ширину parent
		text:SetPoint("LEFT", parent, "LEFT") -- , E.INDENT_TEXT, 0)
		text:SetPoint("RIGHT", parent, "RIGHT") -- , -E.INDENT_TEXT, 0)
	end
	return text
end
----------------------------------------------------------------
function E.func_RequestCallings()
	if C_CovenantCallings and C_CovenantCallings.RequestCallings then
		C_CovenantCallings.RequestCallings()
	end
end
----------------------------------------------------------------
--- Примеры:
---   E.func_SortRecords(items, "text")                  -- по полю text, возр.
---   E.func_SortRecords(items, {"score", E.REVERSE})    -- по полю score, убыв.
---   E.func_SortRecords(numbers, true)                  -- числа по убыванию
---   E.func_SortRecords(items, function(a,b) return a.priority > b.priority end)
-- Универсальная сортировка массива на месте.
-- Поддерживаемые виды правил (передаются в ...):
-- 1. Строка (key) — сортировка по возрастанию поля key.
-- 2. Таблица {key, reverse} или {key = ..., reverse = ...}
--    reverse = true (убывание) / false (возрастание).
-- 3. Булево значение — прямая сортировка самих элементов (только для чисел/строк).
--    false = возрастание, true = убывание.
-- 4. Функция function(a, b) — должна возвращать true/false.
-- Правила применяются последовательно, при неравенстве используется первое сработавшее правило.
-- Если все правила не дали различия, порядок элементов не гарантируется.
---@param tbl table[]               Массив для сортировки (изменяется на месте).
---@param ... string|table|boolean|function  Правила сортировки.
function E.func_SortRecords(tbl, ...)
	assert(type(tbl) == "table", "E.func_SortRecords: first argument must be a table (array)")

	local criteria = {...}

	-- Безопасное сравнение: nil считается меньше любого значения,
	-- одинаковые значения возвращают nil (нет решения),
	-- разные типы сравниваются по имени типа (детерминированно).
	local function safe_less(va, vb)
		if va == vb then return nil end
		if va == nil then return true end
		if vb == nil then return false end
		local ta, tb = type(va), type(vb)
		if ta == tb then
			return va < vb
		end
		return ta < tb
	end

	if #criteria == 0 then
		table.sort(tbl, function(a, b)
				local r = safe_less(a, b)
				return r == true
		end)
		return
	end

	table.sort(tbl, function(a, b)
			for _, rule in ipairs(criteria) do
				local rt = type(rule)

				if rt == "function" then
					local res = rule(a, b)
					if res == true then return true end
					if res == false then return false end
					-- не-boolean или nil — идём дальше

				elseif rt == "table" then
					local key = rule[1] or rule.key
					if not key then
						-- некорректное правило — пропускаем
					else
						local reverse = (rule[2] == true) or (rule.reverse == true)
						local va = a and a[key] or nil
						local vb = b and b[key] or nil
						local r = safe_less(va, vb)
						if r ~= nil then
							return reverse and not r or r
						end
					end

				elseif rt == "string" then
					local va = a and a[rule] or nil
					local vb = b and b[rule] or nil
					local r = safe_less(va, vb)
					if r ~= nil then
						return r
					end

				elseif rt == "boolean" then
					-- только для чисел и строк
					local reverse = rule == true
					if (type(a) == "number" or type(a) == "string") and
					(type(b) == "number" or type(b) == "string") then
						local r = safe_less(a, b)
						if r ~= nil then
							-- return reverse and not r or r
							return r ~= reverse
						end
					end
					-- иначе пропускаем правило
				end
			end
			-- все правила не дали различия
			return false
	end)
end

----------------------------------------------------------------
do
	function E.func_VersionToNumber(v)
		if type(v) ~= "string" then return nil end
		local major, minor, patch, build = v:match("^(%d+)%.(%d+)%.(%d+)%.?(%d*)$")
		if not major then return nil end
		major = tonumber(major)
		minor = tonumber(minor)
		patch = tonumber(patch)
		build = tonumber(build) or 0
		return major * 1000000000000 +
		minor * 1000000000 +
		patch * 1000000 +
		build
	end
	local currentVer = E.func_VersionToNumber(tostring(E.buildVersion) .. "." .. tostring(E.buildNumber or 0))
	function E.FilterByVersion(dataList, isUniversalQuests)
		if not dataList then return end
		local filtered = {}

		-- 1. Фильтрация самих групп (AddedInPatch / RemovedInPatch)
		for i = 1, #dataList do
			local group = dataList[i]
			local groupAdded = group.AddedInPatch and E.func_VersionToNumber(group.AddedInPatch)
			local groupRemoved = group.RemovedInPatch and E.func_VersionToNumber(group.RemovedInPatch)

			if (not groupAdded or currentVer >= groupAdded) and (not groupRemoved or currentVer <= groupRemoved) then
				filtered[#filtered + 1] = group
			end
		end

		-- 2. Для UniversalQuests дополнительная обработка внутренних квестов
		if isUniversalQuests then
			local finalFiltered = {}
			for _, questGroup in ipairs(filtered) do
				local newGroup = questGroup
				if newGroup.questpools then
					local validPools = {}
					for _, pool in ipairs(newGroup.questpools) do
						local poolHasActiveQuest = false
						for _, questEntry in ipairs(pool) do
							local questAdded = questEntry.AddedInPatch and E.func_VersionToNumber(questEntry.AddedInPatch)
							local questRemoved = questEntry.RemovedInPatch and E.func_VersionToNumber(questEntry.RemovedInPatch)
							if (not questAdded or currentVer >= questAdded) and (not questRemoved or currentVer <= questRemoved) then
								poolHasActiveQuest = true
								break
							end
						end
						if poolHasActiveQuest then
							validPools[#validPools + 1] = pool
						end
					end
					if #validPools > 0 then
						newGroup.questpools = validPools
						finalFiltered[#finalFiltered + 1] = newGroup
					end
				elseif newGroup.quests then
					local validQuests = {}
					for _, questEntry in ipairs(newGroup.quests) do
						local questAdded = questEntry.AddedInPatch and E.func_VersionToNumber(questEntry.AddedInPatch)
						local questRemoved = questEntry.RemovedInPatch and E.func_VersionToNumber(questEntry.RemovedInPatch)
						if (not questAdded or currentVer >= questAdded) and (not questRemoved or currentVer <= questRemoved) then
							validQuests[#validQuests + 1] = questEntry
						end
					end
					if #validQuests > 0 then
						newGroup.quests = validQuests
						finalFiltered[#finalFiltered + 1] = newGroup
					end
				else
					finalFiltered[#finalFiltered + 1] = newGroup
				end
			end
			return finalFiltered
		end

		return filtered
	end
end
----------------------------------------------------------------
function E.func_IsSameAccount(pd)
	return pd.REGION_NAME == E.CURRENT_REGION_NAME and pd.BattleTag == E.BattleTag
end
----------------------------------------------------------------
function E.OPDECHAT()
	if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.historyBuffer and DEFAULT_CHAT_FRAME.historyBuffer.elements then
		local tbl = {}
		for k, v in ipairs(DEFAULT_CHAT_FRAME.historyBuffer.elements) do
			local message = v.message
			-- local timestamp = v.timestamp
			table.insert(tbl, message)
		end
		opde (tbl)
	end
end
-- [1] = {
--     [1] = "838 398 INIT",
--     [2] = "TOTAL M+: 87",
--     [3] = "In my table: 87",
--     [4] = "missing: 0",
--     [5] = "MUST TO DELETE: 0",
-- },
----------------------------------------------------------------
function E.func_GetCurrentDay()
    return tonumber(date("%d"))  -- возвращает число от 1 до 31
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_RegisterEvents(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or E.TEXT_UNKNOWN
	local DebugPath = STR:gsub("]", "")
	for _, event in ipairs(MyEventsTable) do
		local success, err = pcall(function()
				frame:RegisterEvent(event)
		end)
		if success then
			-- Успешно зарегистрировано
		else
			-- Ошибка регистрации (как в вашем случае с ACCOUNT_MONEY)
			-- DEFAULT_CHAT_FRAME:AddMessage(string.format(
			-- "|cffff0000[Ошибка]|r Событие '%s' не существует в этой версии WoW\n%s",
			-- event,
			-- tostring(err)
			-- ))
		end
	end
	frame:SetScript("OnEvent",
		function(self, event, ...)
			if self[event] then
				self[event](self, ...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.COLOR_EVENT .. event .. "|r" .. tostring(DebugPath))
				pcall(function() self:UnregisterEvent(event) end)
				self.event = nil
			end
	end)
end
----------------------------------------------------------------
function E.func_RunAfterCombat()
	for key, callback in next, (E._inCombats) do
		if type(callback) == "function" then
			callback()
			E._inCombats[key] = nil
		end
	end
end
local MyEventsTable = {
	"PLAYER_REGEN_ENABLED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_ENABLED()
	E.func_RunAfterCombat()
end
----------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	E.func_SetFlattensRenderLayers_OnAllFrames()
end
----------------------------------------------------------------