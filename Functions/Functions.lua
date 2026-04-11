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
function E.func_WeeklyRewards_ShowUI()
	if WeeklyRewards_ShowUI then
		return WeeklyRewards_ShowUI()
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetAtlasIcon(atlasName, iconWidth, iconHeight)
	if not atlasName then return end
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	return CreateAtlasMarkup(atlasName, iconWidth, iconHeight)
end
function E.func_GetItemHyperlink(itemID)
	local _, link = E.func_GetItemInfo(itemID)
	return link
end
function E.func_GetItemQualityColorTable(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQualityByID(itemID)]
end
function E.func_GetQualityHexColor(quality)
	local numQuality = tonumber(quality)
	if numQuality and numQuality > 0 and numQuality < 8 then
		return ITEM_QUALITY_COLORS[numQuality].hex
	end
	return E.COLOR_WHITE
end
----------------------------------------------------------------
function E.func_GetSpellDescription(spellID)
	local result = GetSpellSubtext(spellID)
	return result
end
----------------------------------------------------------------
function E.func_RGB2Hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c" .. string.format("%02x", math.floor(a*255)) .. utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
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
	return string.upper(string.format("%02x%02x%02x%02x",
			math.floor(a * 255),
			math.floor(r * 255),
			math.floor(g * 255),
			math.floor(b * 255)
	))
end
----------------------------------------------------------------
function E.func_Hex2ColorTable(hex, forcedAlpha)
	local r, g, b, a = E.func_Hex2RGBA(hex)
	return {r = r, g = g, b = b, a = forcedAlpha or a}
end
----------------------------------------------------------------
function E.func_GetNextResetTime(time)
	local time = time or 1
	local daytime = 86400
	local thursdayReset = E.func_GetWeeklyResetStartTime()
	return (math.ceil((GetServerTime() - thursdayReset)/(daytime*time))*daytime*time)+thursdayReset
end
function E.func_IsAchievementCompleted(id)
	if not id then
		return false
	end
	local completed = select(4, GetAchievementInfo(id))
	return completed
end
function E.func_EncodeCoordinates(x, y)
	return math.floor(x * 10000 + 0.5) * 10000 + math.floor(y * 10000 + 0.5)
end
function E.func_FormatCoordinates(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string.format("%.1f / %.1f", x * 100, y * 100)
end
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
function E.func_ReversSort(a, b)
	return b < a
end
-- /run E.func_GetQuestLogCount()
function E.func_GetQuestLogCount()
	local numQuests = 0
	local numShownEntries = E.func_GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = E.func_GetInfo(i)
		numQuests = numQuests + (info and info.frequency and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
function E.func_GetCurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
function E.func_FormatLastSeen(time, color)
	if not time then
		return L["FRIENDS_LIST_OFFLINE"]
	else
		return string.format(L["BNET_LAST_ONLINE_TIME"], color .. E.func_FormatTimeAgo(time) .. "|r")
	end
end
function E.func_FormatTimeAgo(timeDiff, isAbsolute)
	if not isAbsolute then
		timeDiff = time() - timeDiff
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
function E.func_TableConcat(table1, table2) -- func_ArrayConcatUnsafe
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
function E.func_MergeTables(table1, table2)
	for k, v in next, (table2) do
		table1[k] = v
	end
	return table1
end
function E.func_GetTextWithColor(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E.func_RGB2Hex(fontstring:GetTextColor()) .. text .. "|r"
end
function E.func_FormatDateTwoDigits(date)
	local result = ("%.2d"):format(date)
	return result
end
function E.func_ShouldShow(id, dataType, profileName)
	local shouldShow = false
	if Octo_profileKeys.isSettingsEnabled then
		-- Режим настройки включен - показываем все валюты
		shouldShow = true
	else
		-- Режим настройки выключен - проверяем настройки валют
		local settingsTable = Octo_profileKeys.profiles[profileName][dataType] -- dataType
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
function E.func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
function E.func_InitSubTable(tbl, field)
	if type(tbl[field]) ~= "table" then
		tbl[field] = {}
	end
end
function E.func_SpamBlock(...)
	local key = (""):join(tostringall(...))
	local func, needCheckCombat, newSpamTimer = ...
	if type(func) ~= "function" then return end
	local SPAM_TIME = newSpamTimer and newSpamTimer or Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.CONFIG_SPAM_TIME or 2
	if (needCheckCombat == nil or needCheckCombat) and InCombatLockdown() then
		E._inCombats[key] = true
		return true -- заблочена и добавлена в выполнение после сброса комбата
	end
	local currentTime = GetTime()
	-- когда было последнее выполнение
	if E._spamLocks[key] then
		local timeSinceLast = currentTime - E._spamLocks[key]
		local timeToEnd = SPAM_TIME-timeSinceLast
		if timeSinceLast < SPAM_TIME then
			if not E._callAfterTimer[key] then
				E._callAfterTimer[key] = true;
				C_Timer.After(timeToEnd, function()
						E._callAfterTimer[key] = nil
						E.func_SpamBlock(func, needCheckCombat)
				end)
			end
			return true -- заблочена
		end
	end
	E._spamLocks[key] = currentTime -- Обновляем время последнего выполнения
	func() -- Выполняем функцию
	if E.func_UPDATE_MAINFRAME then
		E.func_UPDATE_MAINFRAME()
	end
	return false -- всё ок
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateMinimapButton(AddonName, Saved_Variables, frame, func, frameString)
	local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
			type = "data source",
			icon = "Interface\\AddOns\\" .. E.MainAddonName .. "\\Media\\IconTexture\\" .. AddonName,
			OnClick = function(self, button)
				if button == "LeftButton" then
					-- if not InCombatLockdown() then
					Octo_profileKeys.isSettingsEnabled = nil
					if frame then
						E.func_toogleMainFrame(frame)
					end
					-- end
				elseif button == "RightButton" then
					E.func_OpenToCategory(frame)
				end
			end,
			OnTooltipShow = function(tooltip)
				local addonNameNEW = E.func_AddonNameForOptions(AddonName)
				tooltip:AddLine(addonNameNEW)
				tooltip:AddLine(" ")
				tooltip:AddDoubleLine(E.LEFT_MOUSE_ICON .. L["LMB:"], HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING)
				tooltip:AddDoubleLine(E.RIGHT_MOUSE_ICON .. L["RMB:"], L["OPTIONS"])
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
function E.func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = E.COLOR_ADDON_LEFT or "|cffD177FF" end
	if not secondColor then secondColor = E.COLOR_ADDON_RIGHT or "|cff63A4E0" end
	local result = ""
	local str = ""
	local total = utf8len(text)-1
	if total > 0 then
		local r1, g1, b1 = E.func_Hex2RGBA(firstColor)
		local r2, g2, b2 = E.func_Hex2RGBA(secondColor)
		local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
		local r3 = r1
		local g3 = g1
		local b3 = b1
		for i = 1, total do
			str = str .. E.func_RGB2Hex(r3, g3, b3) .. utf8sub(text, i, i) .. "|r"
			r3 = r3 + rdelta
			g3 = g3 + gdelta
			b3 = b3 + bdelta
		end
		result = str .. secondColor .. utf8sub(text, utf8len(text)) .. "|r"
		return result
	else
		return text
	end
end
function E.func_CountVisibleCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local isOnlyCurrentBtag = Octo_ToDo_DB_Vars.isOnlyCurrentBtag -- Добавляем новую переменную
	local count = 0
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local curBattleTag = E.curBattleTag -- Текущий BattleTag игрока
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	local checkCurrentBtag = isOnlyCurrentBtag and curBattleTag
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				count = count + 1
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction and
				PlayerData.BattleTag then -- Добавляем проверку BattleTag
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					local meetsBtag = not checkCurrentBtag or PlayerData.BattleTag == curBattleTag -- Проверка BattleTag
					if meetsLevel and meetsFaction and meetsServer and meetsRegion and meetsBtag then
						count = count + 1
					end
				end
			end
		end
	end
	return count > 0 and count or 1
end
function E.func_SortCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local isOnlyCurrentBtag = Octo_ToDo_DB_Vars.isOnlyCurrentBtag -- Добавляем новую переменную
	local sorted = {}
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local curBattleTag = E.curBattleTag -- Текущий BattleTag игрока
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	local checkCurrentBtag = isOnlyCurrentBtag and curBattleTag
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if not CharInfo.PlayerData then
			-- Пропускаем, если нет PlayerData
		else
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				sorted[#sorted + 1] = CharInfo
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction and
				PlayerData.BattleTag then -- Добавляем проверку BattleTag
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					local meetsBtag = not checkCurrentBtag or PlayerData.BattleTag == curBattleTag -- Проверка BattleTag
					if meetsLevel and meetsFaction and meetsServer and meetsRegion and meetsBtag then
						sorted[#sorted + 1] = CharInfo
					end
				end
			end
		end
	end
	table.sort(sorted, function(a, b)
			local aData, bData = a.PlayerData, b.PlayerData
			local aLevel = aData.UnitLevel or 0
			local bLevel = bData.UnitLevel or 0
			if aLevel ~= bLevel then
				return aLevel > bLevel
			end
			local aItemLevel = aData.avgItemLevelEquipped or 0
			local bItemLevel = bData.avgItemLevelEquipped or 0
			if aItemLevel ~= bItemLevel then
				return aItemLevel > bItemLevel
			end
			local aName = aData.Name or "noname"
			local bName = bData.Name or "noname"
			return aName < bName
	end)
	return sorted
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
	if not value
	or not minValue
	or not maxValue
	then
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
function E.func_CleanTable(tbl)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			prune(v)
			if not next(v) then tbl[k] = nil end
		elseif v == 0 or v == "" then
			tbl[k] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_RemoveEmptyValues(t)
	for k, v in pairs(t) do
		if type(v) == "table" then
			Cleanup(v)
			if next(v) == nil then
				t[k] = nil
			end
		elseif v == 0 or v == "" then
			t[k] = nil
		end
	end
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
	-- local icon = E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))
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
function E.func_RequestUIUpdate(event_name)
	if Octo_DevTool_DB.CONFIG_DEBUG_EVENTS then
		local isMainFrameVisible = Octo_MainFrame and Octo_MainFrame:IsShown()
		if isMainFrameVisible then
			if not E.updateScheduledFlag then
				E.updateScheduledFlag = true
				C_Timer.After(0.1, function()
						E.updateScheduledFlag = false
						if Octo_MainFrame and Octo_MainFrame:IsShown() then
							-- E.func_TODO_CreateDataProvider()
							DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_GREEN, E.COLOR_YELLOW) .. event_name)
						end
				end)
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_RED, E.COLOR_PURPLE) .. event_name)
		end
	end
end
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
E.CurrentRegionName = E.func_GetCurrentRegionName()
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
	E.OctoTable_Frames_ICONS = E.OctoTable_Frames_ICONS or {}
	E.OctoTable_Frames_SIMPLE = E.OctoTable_Frames_SIMPLE or {}
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames_SIMPLE, frame)
	table.insert(UISpecialFrames, frame:GetName())
end
function E.func_GetPlayerRealm()
	local result = GetRealmName()
	if E.IsRemix then
		result = result .. " (Remix)"
	end
	return result
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
	if not number then return 0 end
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
function E.func_SecondsToClock(time, allwaysShowSeconds)
	local time = tonumber(time) or 0
	if time <= 0 then
		return ""
	end
	local years = math.floor(time / 31536000)
	local days = math.floor(time % 31536000 / 86400)
	local hours = math.floor(time % 86400 / 3600)
	local mins = math.floor(time % 3600 / 60)
	local secs = math.floor(time % 60)
	local ms = time - math.floor(time)
	local parts = {}
	if years > 0 then
		table.insert(parts, years .. L["y"] .. " ")
		table.insert(parts, days .. L["d"] .. " ")
		table.insert(parts, hours .. L["h"] .. " ")
		table.insert(parts, mins .. L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " " .. secs .. L["s"])
		end
	elseif days > 0 then
		table.insert(parts, days .. L["d"] .. " ")
		table.insert(parts, hours .. L["h"] .. " ")
		table.insert(parts, mins .. L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " " .. secs .. L["s"])
		end
	elseif hours > 0 then
		table.insert(parts, hours .. L["h"] .. " ")
		table.insert(parts, string.format("%02d", mins) .. L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " " .. string.format("%02d", secs) .. L["s"])
		end
	elseif time >= 60 then
		table.insert(parts, mins .. L["m"] .. " ")
		if time < 600 or allwaysShowSeconds then
			table.insert(parts, secs .. L["s"])
		end
	elseif time >= 1 then
		table.insert(parts, secs .. L["s"])
	else
		table.insert(parts, string.format("%.3f", time) .. "ms")
	end
	return table.concat(parts)
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
	return L["UNKNOWN"], true
end
function E.func_GetQuestStatus(questID, forceBoolean)
	if not questID then return end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтный делается
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
		result = E.COLOR_PURPLE .. ">" .. L["QUEST_WATCH_QUEST_READY"] .. "<|r"
	elseif not E.func_IsOnQuest(questID) then
		result = nil
	else
		local objectives = E.func_GetQuestObjectives(questID)
		if not objectives then
			result = ""
		else
			local parts = {}
			for i = 1, #objectives do
				local objective = objectives[i]
				if objective then
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
					local color = finished and E.COLOR_YELLOW or E.COLOR_RED
					local text
					if objectiveType == "progressbar" then
						text = color .. GetQuestProgressBarPercent(questID) .. "%|r"
					else
						text = color .. objective.numFulfilled .. "/" .. objective.numRequired .. "|r"
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
E.curServerShort = E.func_GetRealmShortName(GetRealmName())
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
	zhCN = { "", "万", "亿", "兆" }, -- Упрощённый китайский
	zhTW = { "", "萬", "億", "兆" }, -- Традиционный китайский
	koKR = { "", "만", "억", "조" }, -- Корейский
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
	local mode = Octo_ToDo_DB_Vars.Config_numberFormatMode or 1
	local STEP_WEST = 1000
	local STEP_ASIA = 10000
	local DECIMALS = 1
	local step = STEP_WEST
	----------------------------------------------------------------
	if mode == 1 then
		suffixes = CompactSuffixes["enUS"]
	elseif mode == 2 then
		locale = E.curLocaleLang
		suffixes = CompactSuffixes[locale] or CompactSuffixes["enUS"]
		step = AsianLocales[locale] and STEP_ASIA or STEP_WEST
	elseif mode == 3 then -- ПОЛНЫЙ С РАЗДЕЛИТЕЛЯМИ
		return FormatWithSeparators(math.floor(num + 0.5))
	elseif mode == 4 then -- ПОЛНЫЙ
		return (math.floor(num + 0.5))
	elseif mode == 5 then -- BLIZZ LIKE
		if AbbreviateLargeNumbers then
			return AbbreviateLargeNumbers(math.floor(num + 0.5))
		else
			return tostring(math.floor(num + 0.5))
		end
	elseif mode == 6 then -- Short & Clean
		local i = 1
		local sign = num < 0 and -1 or 1
		num = math.abs(num)
		while num >= step and i < #suffixes do
			num = num / step
			i = i + 1
		end
		local rounded = math.floor(num + 0.5) * sign
		return tostring(rounded) .. suffixes[i]
	end
	----------------------------------------------------------------
	local i = 1
	local sign = num < 0 and -1 or 1
	num = math.abs(num)
	if not suffixes then
		return tostring(math.floor(num * sign + 0.5))
	end
	while num >= step and i < #suffixes do
		num = num / step
		i = i + 1
	end
	local rounded = tonumber(string.format("%." .. DECIMALS .. "f", num))
	if rounded >= step and i < #suffixes then
		rounded = rounded / step
		i = i + 1
	end
	rounded = rounded * sign
	local s = tostring(rounded):gsub("%.0$", "")
	return s .. suffixes[i]
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_SI_to_EJ(id) -- jInstanceID func_SI_to_EJ
	if not id then return end
	local newID = Octo_Cache_DB.SavedInstanceID_to_EJInstance[id] or 0 -- jInstanceID
	return newID
end
----------------------------------------------------------------
function E.func_EJ_to_SI(id) -- 721 Чертоги доблести
	if not id then return end
	local newID = Octo_Cache_DB.EJInstance_to_SavedInstanceID[id] or 0 -- instanceID
	return newID
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
function E.func_MeasureTextWidth(textToMeasure, minWidth, indent)
	minWidth = minWidth or 1
	local result = type(textToMeasure) == "function" and textToMeasure() or textToMeasure
	local text = tostring(result or "")
	Octo_MeasureFrame.measureText:SetText(text)
	local width = math.max(math.ceil(Octo_MeasureFrame.measureText:GetStringWidth()), minWidth) -- 8 indent
	return width
end
----------------------------------------------------------------
function E.func_UpdateFont()
	local Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	local Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	local Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
	local fontPath = LibSharedMedia:Fetch("font", Config_FontStyle)
	E.OctoFont10:CopyFontObject(GameTooltipText)
	E.OctoFont11:CopyFontObject(GameTooltipText)
	E.OctoFont22:CopyFontObject(SystemFont_Outline_Small)
	E.OctoFont10:SetFont(fontPath, Config_FontSize-1, Config_FontFlags)
	E.OctoFont11:SetFont(fontPath, Config_FontSize, Config_FontFlags)
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
function E:func_CanCollectData()
	local db = Octo_ToDo_DB_Levels
	if not db then return false end
	local char = db[self.curGUID]
	if not char then return false end
	return char.MASLENGO ~= nil and char.PlayerData ~= nil
end
----------------------------------------------------------------
function E.func_RefreshTranslations()
	wipe(E.L)
end
----------------------------------------------------------------
function E.func_Save(v)
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
		namePart = E.OctoTable_KeystoneAbbr[OwnedKeystoneChallengeMapID].abbreviation or L["UNKNOWN"]
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
local function func_UpdateGlobals()
	local db = Octo_ToDo_DB_Vars
	if db then
		if db.Config_ADDON_HEIGHT then
			E.GLOBAL_LINE_HEIGHT = db.Config_ADDON_HEIGHT
			E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2
			E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
		end
		db.FontOption = db.FontOption or {}
		db.FontOption[E.curLocaleLang] = db.FontOption[E.curLocaleLang] or {}
		if db.FontOption[E.curLocaleLang].Config_FontStyle then
			E.func_UpdateFont()
		end
		if Octo_profileColors and Octo_profileColors.profiles and Octo_profileColors.Current_profile then
			E.func_CreateNew_profileColors(Octo_profileColors.Current_profile)
		end
		----------------------------------------------------------------
		if E.PROFTBL then
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_faction_Horde_r
				local g = E.PROFTBL.ConfigColor_faction_Horde_g
				local b = E.PROFTBL.ConfigColor_faction_Horde_b
				local a = E.PROFTBL.ConfigColor_faction_Horde_a
				E.COLOR_HORDE = E.func_RGB2Hex(r, g, b, a)
			end
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_faction_Alliance_r
				local g = E.PROFTBL.ConfigColor_faction_Alliance_g
				local b = E.PROFTBL.ConfigColor_faction_Alliance_b
				local a = E.PROFTBL.ConfigColor_faction_Alliance_a
				E.COLOR_ALLIANCE = E.func_RGB2Hex(r, g, b, a)
			end
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_faction_Neutral_r
				local g = E.PROFTBL.ConfigColor_faction_Neutral_g
				local b = E.PROFTBL.ConfigColor_faction_Neutral_b
				local a = E.PROFTBL.ConfigColor_faction_Neutral_a
				E.COLOR_NEUTRAL = E.func_RGB2Hex(r, g, b, a)
				E.COLOR_FACTION = E.FACTION_CURRENT == "Horde" and E.COLOR_HORDE or E.FACTION_CURRENT == "Alliance" and E.COLOR_ALLIANCE or E.Class_Monk_Color
			end
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_MAIN_MainFrame_r
				local g = E.PROFTBL.ConfigColor_MAIN_MainFrame_g
				local b = E.PROFTBL.ConfigColor_MAIN_MainFrame_b
				local a = E.PROFTBL.ConfigColor_MAIN_MainFrame_a
				local UseFaction = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseFaction_CONFIG
				local UseClass = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseClass_CONFIG
				for k, frame in next, (E.OctoTable_ColoredFrames) do
					E.func_DB_FRAME_Color(frame, "frame", r, g, b, a, UseFaction, UseClass)
				end
				for k, frame in next, (E.OctoFrames_Dropdowns) do
					E.func_DB_FRAME_Color(frame, "frame", r, g, b, a, UseFaction, UseClass)
				end
			end
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_MAIN_Border_r
				local g = E.PROFTBL.ConfigColor_MAIN_Border_g
				local b = E.PROFTBL.ConfigColor_MAIN_Border_b
				local a = E.PROFTBL.ConfigColor_MAIN_Border_a
				local UseFaction = E.PROFTBL.ConfigColor_MAIN_Border_UseFaction_CONFIG
				local UseClass = E.PROFTBL.ConfigColor_MAIN_Border_UseClass_CONFIG
				for k, frame in next, (E.OctoTable_ColoredFrames) do
					E.func_DB_FRAME_Color(frame, "border", r, g, b, a, UseFaction, UseClass)
				end
				for k, frame in next, (E.OctoFrames_Dropdowns) do
					E.func_DB_FRAME_Color(frame, "border", r, g, b, a, UseFaction, UseClass)
				end
			end
			----------------------------------------------------------------
			do
				local r = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_r
				local g = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_g
				local b = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_b
				local a = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_a
				local UseFaction = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_UseFaction_CONFIG
				local UseClass = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_UseClass_CONFIG
				E.func_DB_FRAME_Color(Octo_TooltipFrame, "frame", r, g, b, a, UseFaction, UseClass)
			end
			----------------------------------------------------------------
		end
		----------------------------------------------------------------
	end
end
function E.func_UpdateGlobals()
	E.func_SpamBlock(func_UpdateGlobals, true, 1)
end
----------------------------------------------------------------
function E.func_DB_REP_COLOR(repType, reaction)
	local color
	if not repType or not reaction or not E.PROFTBL then return color end
	if repType == 1 and reaction and type(reaction) == "number" and reaction > 0 then
		color = Octo_ToDo_DB_Vars[string.format("CONFIG_REPUTATION_SIMPLE_COLOR_%d", reaction)]
	elseif repType == 2 then
		color = Octo_ToDo_DB_Vars.CONFIG_REPUTATION_FRIEND_COLOR
	elseif repType == 3 then
		color = Octo_ToDo_DB_Vars.CONFIG_REPUTATION_MAJOR_COLOR
	elseif repType == 4 then
		color = Octo_ToDo_DB_Vars.CONFIG_REPUTATION_PARAGON_COLOR
	else
		color = E.COLOR_DARKGRAY:gsub("^|c", "")
	end
	return "|c" .. color
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
	local faction = pd.Faction or "Neutral"
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
	local classColorHex = pd.classColorHex or E.COLOR_WHITE
	if E.PROFTBL.ConfigColor_CharHeader_UseFaction_CONFIG then
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif E.PROFTBL.ConfigColor_CharHeader_UseClass_CONFIG then
		r, g, b = E.func_Hex2RGBA(classColorHex)
	else
		r = E.PROFTBL.ConfigColor_CharHeader_r
		g = E.PROFTBL.ConfigColor_CharHeader_g
		b = E.PROFTBL.ConfigColor_CharHeader_b
	end
	a = E.PROFTBL.ConfigColor_CharHeader_a
	return r, g, b, a
end
----------------------------------------------------------------
function E.func_DB_CHARLINE_COLOR()
	local r, g, b, a = 1, 1, 1, 1
	if not E.PROFTBL then return r, g, b, a end
	local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
	local pd = CharInfo.PlayerData
	local classColorHex = pd.classColorHex or E.COLOR_WHITE
	if E.PROFTBL.ConfigColor_CharLines_UseFaction_CONFIG then
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif E.PROFTBL.ConfigColor_CharLines_UseClass_CONFIG then
		r, g, b = E.func_Hex2RGBA(classColorHex)
	else
		r = E.PROFTBL.ConfigColor_CharLines_r
		g = E.PROFTBL.ConfigColor_CharLines_g
		b = E.PROFTBL.ConfigColor_CharLines_b
	end
	a = E.PROFTBL.ConfigColor_CharLines_a
	return r, g, b, a
end
----------------------------------------------------------------
-- function E.func_DB_HIGHLIGHT_COLOR()
-- local r, g, b, a = 1, 1, 1, 1
-- return r, g, b, a
-- end
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
			if E.PROFTBL then
				local r = E.PROFTBL.ConfigColor_Highlight_r
				local g = E.PROFTBL.ConfigColor_Highlight_g
				local b = E.PROFTBL.ConfigColor_Highlight_b
				local a = E.PROFTBL.ConfigColor_Highlight_a
				local UseFaction = E.PROFTBL.ConfigColor_Highlight_UseFaction_CONFIG
				local UseClass = E.PROFTBL.ConfigColor_Highlight_UseClass_CONFIG
				alpha:SetFromAlpha(E.PROFTBL.ConfigColor_Highlight_a or .2)
				E.func_DB_FRAME_Color(frame, "highlight", r, g, b, a, UseFaction, UseClass)
				ResetHighlightState(self)
			end
	end)
	frame:GetScript("OnShow")(frame)
end
----------------------------------------------------------------
function E.func_Create_Highlight(frame, owner)
	frame.Highlight = CreateFrame("FRAME", nil, owner, "OctoPropagateTemplate")
	E.func_ApplyHighlightTemplate(frame.Highlight, frame)
end
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
function E.func_OpenToCategory(frame)
	if InCombatLockdown() then return end
	if frame and frame:IsShown() then
		frame:Hide()
	end
	local id = E.main_category:GetID()
	Settings.OpenToCategory(id, GlobalAddonName)
end
function E.func_toogleMainFrame(frame)
	frame:SetShown(not frame:IsShown())
	if frame:IsShown() then
		E.func_CloseSettings()
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
local soundFile_OnEnter = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\OnEnter.ogg"
function E.sound_OnEnter()
	PlaySoundFile(soundFile_OnEnter, "Master")
end
----------------------------------------------------------------
local soundFile_OnClick = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\OnClick.ogg"
function E.sound_OnClick()
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	-- PlaySoundFile(soundFile_OnClick, "Master")
end
----------------------------------------------------------------
local soundFile_Slider_OnValueChanged = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\Slider_OnValueChanged.ogg"
function E.sound_Slider_OnValueChanged()
	PlaySoundFile(soundFile_Slider_OnValueChanged, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Close = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\DropDown_Close.ogg"
function E.sound_DropDown_Close()
	PlaySoundFile(soundFile_DropDown_Close, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Open = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\DropDown_Open.ogg"
function E.sound_DropDown_Open()
	PlaySoundFile(soundFile_DropDown_Open, "Master")
end
----------------------------------------------------------------
local soundFile_DropDown_Select = "Interface\\Addons\\" .. GlobalAddonName .. "\\Media\\sound\\DropDown_Select.ogg"
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
----------------------------------------------------------------
-- 38 ms
function E.func_BUILD_DUNG_DB()
	-- local serverTime = GetServerTime()
	-- if Octo_Cache_DB.LastUpdateDB and Octo_Cache_DB.LastUpdateDB > serverTime then
	-- return
	-- end
	-- E.DEBUG_START()
	-- wipe(Octo_Cache_DB.Octo_Table_SI_IDS)
	-- wipe(Octo_Cache_DB.SavedInstanceID_to_EJInstance)
	-- wipe(Octo_Cache_DB.EJInstance_to_SavedInstanceID)
	-- Octo_Cache_DB.LastUpdateDB = nil
	local backupTier = EJ_GetCurrentTier()
	local backupDifficulty = EJ_GetDifficulty()
	local maxTiers = EJ_GetNumTiers()
	if not maxTiers or maxTiers < 1 then
		return
	end
	local SI_to_EJ = {}
	local EJ_to_SI = {}
	local result = {}
	-- local currentSeason = {}
	local function CountEncounters()
		local i = 1
		while EJ_GetEncounterInfoByIndex(i) do
			i = i + 1
		end
		return i - 1
	end
	for tier = 1, maxTiers do
		if maxTiers == 11 and tier ~= 10 or tier ~= maxTiers then
			EJ_SelectTier(tier)
			if maxTiers == 11 and tier == maxTiers then
				tier = tier - 1
			end
			-- local tierName = EJ_GetTierInfo(tier)
			-- local realTierNumber = E.OctoTable_Expansions_Tiers[tierName]
			-- if realTierNumber then
			for pass = 1, 2 do
				local isRaid = (pass == 2)
				-- local isRaid = true -- Только рейды 38 ms
				-- local isRaid = false -- Только подземелья 70 ms
				local index = 1
				local ejInstanceID = EJ_GetInstanceByIndex(index, isRaid)
				while ejInstanceID do
					EJ_SelectInstance(ejInstanceID)
					local _, _, _, _, _, _, _, _, _, savedInstanceID = EJ_GetInstanceInfo(ejInstanceID)
					if savedInstanceID then
						SI_to_EJ[savedInstanceID] = ejInstanceID
						EJ_to_SI[ejInstanceID] = savedInstanceID
					end
					local diffTable = nil
					for diffID in next, (E.OctoTable_Difficulties) do
						if EJ_IsValidInstanceDifficulty(diffID) then
							EJ_SetDifficulty(diffID)
							local bossCount = CountEncounters()
							if bossCount > 0 then
								diffTable = diffTable or {}
								diffTable[diffID] = bossCount
							end
						end
					end
					if diffTable then

						-- if tierName == E.currentExpansionName and not isRaid then -- and savedInstanceID ~= 3029 then
						-- if tierName == E.currentExpansionName and not isRaid then -- and savedInstanceID ~= 3029 then
						-- if currentSeason[savedInstanceID] == nil then currentSeason[savedInstanceID] = {
						-- difficulties = diffTable,
						-- -- name = name,
						-- tier = tier,
						-- }
						-- end
						-- end
						-- if E.OctoTable_Expansions_Names[tierName] then
						if result[savedInstanceID] == nil then result[savedInstanceID] = {
								difficulties = diffTable,
								isRaid = isRaid,
								-- name = name,
								tier = tier,
							}
						end
						-- end
						-- elseif tier == maxTiers and not isRaid and savedInstanceID ~= 3029 then
						-- currentSeason[savedInstanceID] = {
						-- difficulties = diffTable,
						-- isRaid = isRaid,
						-- -- name = name
						-- }
					end
					index = index + 1
					ejInstanceID = EJ_GetInstanceByIndex(index, isRaid)
				end
				-- end
			end
		end
	end
	EJ_SetDifficulty(backupDifficulty)
	EJ_SelectTier(backupTier)
	-- Octo_Cache_DB.Octo_Table_currentSeason = currentSeason
	-- opde(Octo_Cache_DB.Octo_Table_currentSeason)
	Octo_Cache_DB.Octo_Table_SI_IDS = result
	-- opde(Octo_Cache_DB.Octo_Table_SI_IDS)
	Octo_Cache_DB.SavedInstanceID_to_EJInstance = SI_to_EJ
	Octo_Cache_DB.EJInstance_to_SavedInstanceID = EJ_to_SI
	-- E.DEBUG_STOP()
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
function E.func_GetDungTier(SI_ID)
	if not Octo_Cache_DB or not Octo_Cache_DB.Octo_Table_SI_IDS then return 1 end
	local tier = Octo_Cache_DB.Octo_Table_SI_IDS[SI_ID] and Octo_Cache_DB.Octo_Table_SI_IDS[SI_ID].tier or 1
	return tier
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
function E.func_DungeonOrRaid(SI_ID)
	if Octo_Cache_DB and Octo_Cache_DB.Octo_Table_SI_IDS and Octo_Cache_DB.Octo_Table_SI_IDS[SI_ID] then
		local isRaid = Octo_Cache_DB.Octo_Table_SI_IDS[SI_ID].isRaid
		return isRaid
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_RegisterEvents(frame, MyEventsTable)
-- local stack = debugstack(2)
-- local STR = stack:match("Interface/AddOns/(.-):%d+") or L["UNKNOWN"]
-- local DebugPath = STR:gsub("]", "")
-- for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
-- frame:SetScript("OnEvent",
-- function(self, event, ...)
-- if self[event] then
-- self[event](self, ...)
-- else
-- DEFAULT_CHAT_FRAME:AddMessage(E.COLOR_EVENT .. event .. "|r" .. tostring(DebugPath))
-- self:UnregisterEvent(event)
-- self.event = nil
-- end
-- end)
-- end
function E.func_RegisterEvents(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or L["UNKNOWN"]
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
	for key in next, (E._inCombats) do
		if type(callback) == "function" then
			callback()
			E._inCombats[key] = nil
		end
	end
end
local MyEventsTable = {
	"PLAYER_REGEN_ENABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_ENABLED()
	E.func_RunAfterCombat()
end
----------------------------------------------------------------