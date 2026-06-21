local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
-- Заглушка для проверки «секретных» ивентов -------------------
----------------------------------------------------------------
local issecretvalue = issecretvalue or function() end
----------------------------------------------------------------
-- Константы периодов ------------------------------------------
----------------------------------------------------------------
local PAST_PERIOD = 1
local PRESENT_PERIOD = 2
local FUTURE_PERIOD = 3
----------------------------------------------------------------
-- Фрейм, управляющий календарём
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
-- Сколько дней показывать в прошлом и будущем -----------------
----------------------------------------------------------------
local showPast = true
local previousDays = 3 -- 28
----------------------------------------------------------------
local showFuture = true
local followingDays = 14 -- 28
----------------------------------------------------------------
local showID = false
----------------------------------------------------------------
-- Иконки ------------------------------------------------------
----------------------------------------------------------------
local iconStrPattern = "|T%s:18:18:0:0:128:128:0:91:0:91|t "
local iconStrCustomPattern = "|T%s:18|t "
local iconLockOut = "|T340023:18:18:2:0:32:32:0:28:0:28|t "
local noIcon = "|TInterface/Icons/INV_Misc_QuestionMark:18|t "
----------------------------------------------------------------
-- Текстуры типов событий --------------------------------------
----------------------------------------------------------------
local CALENDAR_EVENTTYPE_TEXTURES = {
	[Enum.CalendarEventType.Raid] = "|TInterface\\LFGFrame\\LFGIcon-Raid:18|t ",
	[Enum.CalendarEventType.Dungeon] = "|TInterface\\LFGFrame\\LFGIcon-Dungeon:18|t ",
	[Enum.CalendarEventType.PvP] = "|TInterface\\Calendar\\UI-Calendar-Event-PVP:18|t ",
	[Enum.CalendarEventType.Meeting] = "|TInterface\\Calendar\\MeetingIcon:18|t ",
	[Enum.CalendarEventType.Other] = "|TInterface\\Calendar\\UI-Calendar-Event-Other:18|t ",
}
----------------------------------------------------------------
-- Фильтры календаря (CVars) -----------------------------------
----------------------------------------------------------------
EventFrame.isMainline = WOW_PROJECT_MAINLINE == WOW_PROJECT_ID
EventFrame.FILTER_CVARS = {
	EventFrame.isMainline and "calendarShowHolidays" or "calendarShowResets",
	"calendarShowDarkmoon",
	"calendarShowLockouts",
	"calendarShowWeeklyHolidays",
	"calendarShowBattlegrounds",
}
----------------------------------------------------------------
-- func_RegisterEvents -----------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
-- Создаёт метку времени из структуры, которую возвращает календарь
----------------------------------------------------------------
local function CreateCalendarTimestamp(calendarTime)
	return time({
			year = calendarTime.year,
			month = calendarTime.month,
			day = calendarTime.monthDay,
			hour = calendarTime.hour,
			min = calendarTime.minute,
	})
end
----------------------------------------------------------------
-- Уникальный ключ для события (дата + ID) ---------------------
----------------------------------------------------------------
local function GetEventKey(event)
	local month = event.startTime.month
	local day = event.startTime.monthDay
	local monthStr = month < 10 and "0" .. month or tostring(month)
	local dayStr = day < 10 and "0" .. day or tostring(day)
	return event.eventID .. ":" .. event.startTime.year .. monthStr .. dayStr
end
----------------------------------------------------------------
-- Форматирует заголовок события (дата и время)
----------------------------------------------------------------

local function NormalizeNumber(num)
	if num < 10 then
		num = "0" .. num
	end
	return num
end

local function FormatEventDateTimeLEFT(db, event)
	local startDate = NormalizeNumber(event.startTime.monthDay) .. "." .. NormalizeNumber(event.startTime.month)
	local color = db.dateColor[event.periodID]
	if event.calendarType == "HOLIDAY" then
		return color .. startDate .. "|r"
	else
		-- local startTime = GameTime_GetFormattedTime(event.startTime.hour, event.startTime.minute, true)
		return color .. startDate .. "|r"
	end
end
local function FormatEventDateTimeRIGHT(db, event)
	local color = db.dateColor[event.periodID]
	if event.calendarType == "HOLIDAY" then
		local endDate = NormalizeNumber(event.endTime.monthDay) .. "." .. NormalizeNumber(event.endTime.month)
		return color .. endDate .. "|r"
	else
		return ""
		-- local startTime = GameTime_GetFormattedTime(event.startTime.hour, event.startTime.minute, true)
		-- return color .. startTime .. "|r"
	end
end



local function FormatEventDateTime(db, event)
	local startDate = FormatShortDate(event.startTime.monthDay, event.startTime.month)
	local color = db.dateColor[event.periodID]
	if event.calendarType == "HOLIDAY" then
		local endDate = FormatShortDate(event.endTime.monthDay, event.endTime.month)
		return color .. startDate .. " - " .. endDate .. "|r"
	else
		local startTime = GameTime_GetFormattedTime(event.startTime.hour, event.startTime.minute, true)
		return color .. startDate .. " " .. startTime .. "|r"
	end
end
----------------------------------------------------------------
-- Возвращает период (прошлое, настоящее, будущее) и ключевое время для сортировки
----------------------------------------------------------------
local function AssignPeriodAndTime(event, currentTimestamp)
	local period
	local sortTime
	if event.calendarType == "HOLIDAY" then
		-- Праздники считаем текущими, пока они не закончатся
		period = PRESENT_PERIOD
		sortTime = CreateCalendarTimestamp(event.endTime)
	elseif event.sequenceType == "ONGOING" then
		period = PRESENT_PERIOD
		sortTime = CreateCalendarTimestamp(event.endTime)
	elseif event.sequenceType == "START" then
		local startTimestamp = CreateCalendarTimestamp(event.startTime)
		if startTimestamp > currentTimestamp then
			period = FUTURE_PERIOD
			sortTime = startTimestamp
		else
			period = PRESENT_PERIOD
			sortTime = CreateCalendarTimestamp(event.endTime)
		end
	elseif event.sequenceType == "END" then
		local endTimestamp = CreateCalendarTimestamp(event.endTime)
		if endTimestamp > currentTimestamp then
			period = PRESENT_PERIOD
			sortTime = endTimestamp
		else
			period = PAST_PERIOD
			-- sortTime остаётся nil, не влияет на сортировку
		end
	else
		local startTimestamp = CreateCalendarTimestamp(event.startTime)
		if startTimestamp > currentTimestamp then
			period = FUTURE_PERIOD
			sortTime = startTimestamp
		else
			period = PAST_PERIOD
			-- sortTime nil
		end
	end
	event.periodID = period
	event.sortTime = sortTime
end
----------------------------------------------------------------------
-- PLAYER_LOGIN ------------------------------------------------------
----------------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	C_Timer.After(1, function()
			Octo_CalendarButton:HookScript("OnShow", function()
					local day = tonumber(date("%d"))
					local texture = "UI-HUD-Calendar-" .. day .. "-Mouseover"
					if E.func_isAtlas(texture) then
						Octo_CalendarButton.Icon:SetAtlas(texture)
					else
						Octo_CalendarButton.Icon:SetTexture(texture)
					end
			end)
			Octo_CalendarButton:HookScript("OnEnter", function() self:onEnter() end)
			Octo_CalendarButton:HookScript("OnLeave", function() self:onLeave() end)
	end)
end
----------------------------------------------------------------
-- ADDON_LOADED ------------------------------------------------
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	self:Init_Octo_ToDo_DB_Calendar()
end
----------------------------------------------------------------
-- Init_Octo_ToDo_DB_Calendar ----------------------------------
----------------------------------------------------------------
function EventFrame:Init_Octo_ToDo_DB_Calendar() -- /run opde(Octo_ToDo_DB_Calendar)
	Octo_ToDo_DB_Calendar = Octo_ToDo_DB_Calendar or {}
	self.db = Octo_ToDo_DB_Calendar
	for _, cvar in ipairs(self.FILTER_CVARS) do
		if self.db[cvar] == nil then
			self.db[cvar] = true
		end
	end
	self.list = {}
	self.filterBackup = {}


	self.db.eventColor = self.db.eventColor or {}
	self.db.timeColor = self.db.timeColor or {}
	self.db.timeDayColor = self.db.timeDayColor or {}
	self.db.dateColor = self.db.dateColor or {}

	self.db.titleColor = E.COLOR_YELLOW or self.db.titleColor

	-- ПРОШЛОЕ
	self.db.eventColor[PAST_PERIOD] = E.COLOR_GRAY or self.db.eventColor[PAST_PERIOD]
	self.db.timeColor[PAST_PERIOD] = E.COLOR_GRAY or self.db.timeColor[PAST_PERIOD]
	self.db.timeDayColor[PAST_PERIOD] = E.COLOR_GRAY or self.db.timeDayColor[PAST_PERIOD]
	self.db.dateColor[PAST_PERIOD] = E.COLOR_GRAY or self.db.dateColor[PAST_PERIOD]
	-- ТЕКУЩЕЕ
	self.db.eventColor[PRESENT_PERIOD] = E.COLOR_WHITE or self.db.eventColor[PRESENT_PERIOD]
	self.db.timeColor[PRESENT_PERIOD] = E.COLOR_YELLOW or self.db.timeColor[PRESENT_PERIOD]
	self.db.timeDayColor[PRESENT_PERIOD] = E.COLOR_ORANGE or self.db.timeDayColor[PRESENT_PERIOD]
	self.db.dateColor[PRESENT_PERIOD] = E.COLOR_TIME or self.db.dateColor[PRESENT_PERIOD]
	-- БУДУЩЕЕ
	self.db.eventColor[FUTURE_PERIOD] = E.COLOR_GRAY or self.db.eventColor[FUTURE_PERIOD]
	self.db.timeColor[FUTURE_PERIOD] = E.COLOR_GRAY or self.db.timeColor[FUTURE_PERIOD]
	self.db.timeDayColor[FUTURE_PERIOD] = E.COLOR_ORANGE or self.db.timeDayColor[FUTURE_PERIOD]
	self.db.dateColor[FUTURE_PERIOD] = E.COLOR_GRAY or self.db.dateColor[FUTURE_PERIOD]
end
----------------------------------------------------------------
-- setBackup ---------------------------------------------------
----------------------------------------------------------------
function EventFrame:setBackup()
	self.isUpdating = true
	self.dateBackup = C_Calendar.GetMonthInfo()
	if CalendarFrame_Global then -- возможно, надо скрыть/отключить стандартный календарь
		CalendarFrame_Global:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
	local backup = self.filterBackup
	for _, cvar in ipairs(self.FILTER_CVARS) do
		backup[cvar] = GetCVar(cvar)
		SetCVar(cvar, self.db[cvar])
	end
end
----------------------------------------------------------------
-- restoreBackup -----------------------------------------------
----------------------------------------------------------------
function EventFrame:restoreBackup()
	local backup = self.filterBackup
	for _, cvar in ipairs(self.FILTER_CVARS) do
		SetCVar(cvar, backup[cvar])
	end
	C_Calendar.SetAbsMonth(self.dateBackup.month, self.dateBackup.year)
	if CalendarFrame_Global then
		CalendarFrame_Global:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
	self.isUpdating = false
end
----------------------------------------------------------------
-- Дополняет объект события текстом, датой и временем ----------
----------------------------------------------------------------
function EventFrame:updateEventAttr(event)
	if event.calendarType == "HOLIDAY" then
		event.title = self.db.eventColor[event.periodID] .. event.title .. "|r"
		event.dateStr = FormatEventDateTime(self.db, event)
		event.dateStrLEFT = FormatEventDateTimeLEFT(self.db, event)
		event.dateStrRIGHT = FormatEventDateTimeRIGHT(self.db, event)
		return
	end
	local titleWithDifficulty = event.title
	if event.difficultyName and event.difficultyName ~= "" then
		titleWithDifficulty = DUNGEON_NAME_WITH_DIFFICULTY:format(event.title, event.difficultyName)
	end
	event.title = self.db.eventColor[event.periodID] .. titleWithDifficulty .. "|r"

	local isSignupEvent = (event.calendarType == "GUILD_EVENT" or event.calendarType == "COMMUNITY_EVENT")
		and event.inviteType == Enum.CalendarInviteType.Signup

	if isSignupEvent then
		local inviteInfo = CalendarUtil.GetCalendarInviteStatusInfo(event.inviteStatus)
		event.title = event.title .. " " .. inviteInfo.color:WrapTextInColorCode("(" .. inviteInfo.name .. ")")
	end
	event.dateStr = FormatEventDateTime(self.db, event)
	event.dateStrLEFT = FormatEventDateTimeLEFT(self.db, event)
	event.dateStrRIGHT = FormatEventDateTimeRIGHT(self.db, event)
end
----------------------------------------------------------------
-- Заполняет список событий для одного дня ---------------------
----------------------------------------------------------------
function EventFrame:setEventList(day, periodID)
	local numEvents = C_Calendar.GetNumDayEvents(0, day)
	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(0, day, i)
		if issecretvalue(event.eventID) then
			self.isSecret = true
			return
		end
		local eventKey = GetEventKey(event)
		local cached = self.list[eventKey]
		if not cached then
			local holidayInfo = C_Calendar.GetHolidayInfo(0, day, i)
			event.icon = holidayInfo and holidayInfo.texture or event.iconTexture
			event.startTimestamp = CreateCalendarTimestamp(event.startTime)
			event.endTimestamp = CreateCalendarTimestamp(event.endTime)
			-- Определяем период и время сортировки
			if periodID ~= PRESENT_PERIOD then
				event.periodID = periodID
				if periodID == FUTURE_PERIOD then
					event.sortTime = event.startTimestamp
				end
			else
				AssignPeriodAndTime(event, self.currentTimestamp)
			end
			if event.sortTime and event.sortTime < self.timeToEvent then
				self.timeToEvent = event.sortTime
			end
			if showID then
				event.title = event.title .. E.COLOR_GRAY .. " (" .. event.eventID .. ")|r"
			end
			self:updateEventAttr(event)
			self.list[#self.list + 1] = event
			self.list[eventKey] = event
		else
			-- Если событие уже есть, но изменился тип последовательности, обновляем иконку
			if cached.sequenceType == "ONGOING" and event.sequenceType ~= "ONGOING" then
				local freshInfo = C_Calendar.GetHolidayInfo(0, day, i)
				if freshInfo then
					cached.icon = freshInfo.texture
				end
			elseif cached.icon == nil and event.iconTexture ~= nil then
				cached.icon = event.iconTexture
			end
		end
	end
end
----------------------------------------------------------------
-- Загружает события в диапазоне месяцев/дней ------------------
----------------------------------------------------------------
function EventFrame:setEventListRange(monthOffset, startDay, endDay, periodID)
	local month = self.currentDate.month + monthOffset
	local year = self.currentDate.year
	if month < 1 then
		month = 12
		year = year - 1
	elseif month > 12 then
		month = 1
		year = year + 1
	end
	C_Calendar.SetAbsMonth(month, year)
	for day = startDay, endDay do
		self:setEventList(day, periodID)
	end
end
----------------------------------------------------------------
-- Основная функция обновления списка событий ------------------
----------------------------------------------------------------
function EventFrame:updateList()
	self.timeToEvent = math.huge
	self.currentDate = C_DateAndTime.GetCurrentCalendarTime()
	self.currentTimestamp = CreateCalendarTimestamp(self.currentDate)
	local today = self.currentDate.monthDay
	wipe(self.list)
	self.isSecret = nil
	self:setBackup()
	----------------------------------------------------------------
	-- Текущие события ---------------------------------------------
	----------------------------------------------------------------
	C_Calendar.SetAbsMonth(self.currentDate.month, self.currentDate.year)
	self:setEventList(today, PRESENT_PERIOD)
	-- Прошедшие дни
	local beforeDay = today - previousDays
	if beforeDay < 1 then
		local numDaysPrevMonth = C_Calendar.GetMonthInfo(-1).numDays
		self:setEventListRange(-1, numDaysPrevMonth + beforeDay, numDaysPrevMonth, PAST_PERIOD)
		beforeDay = 1
	end
	self:setEventListRange(0, beforeDay, today - 1, PAST_PERIOD)
	-- Будущие дни
	local afterDay = today + followingDays
	local numDaysThisMonth = C_Calendar.GetMonthInfo().numDays
	if afterDay > numDaysThisMonth then
		self:setEventListRange(0, today + 1, numDaysThisMonth, FUTURE_PERIOD)
		self:setEventListRange(1, 1, afterDay - numDaysThisMonth, FUTURE_PERIOD)
	else
		self:setEventListRange(0, today + 1, afterDay, FUTURE_PERIOD)
	end
	self:restoreBackup()
	-- Сортировка
	E.func_SortRecords(self.list, function(a, b)
			if a.periodID ~= b.periodID then
				return a.periodID < b.periodID
			end
			if a.periodID == FUTURE_PERIOD then
				if a.sortTime ~= b.sortTime then return a.sortTime < b.sortTime end
				if a.endTimestamp ~= b.endTimestamp then return a.endTimestamp < b.endTimestamp end
			else
				if a.endTimestamp ~= b.endTimestamp then return a.endTimestamp < b.endTimestamp end
				if a.sortTime ~= b.sortTime then return a.sortTime < b.sortTime end
			end
			if a.title ~= b.title then return a.title < b.title end
			return a.eventID < b.eventID
	end)
end
----------------------------------------------------------------
-- Генерация данных для тултипа --------------------------------
----------------------------------------------------------------
function EventFrame:generateTooltipData()
	if self.isSecret then return nil end
	local now = C_DateAndTime.GetCurrentCalendarTime()
	local curDateStr = FormatShortDate(now.monthDay, now.month, now.year)
	local curTimeStr = GameTime_GetFormattedTime(now.hour, now.minute, true)
	local currentTimestamp = CreateCalendarTimestamp(now)
	local tooltip = {}
	local leftHeader = self.db.titleColor .. EVENTS_LABEL .. "|r"
	local centHeader = self.db.titleColor .. curTimeStr .. "|r"
	local rightHeader = self.db.titleColor .. curDateStr .. "|r"
	local testSTR = E.COLOR_TIME .. NormalizeNumber(now.monthDay) .. "." .. NormalizeNumber(now.month) .. "|r"
	-- tooltip[#tooltip+1] = {leftHeader, centHeader, rightHeader}
	tooltip[#tooltip+1] = {"", "", testSTR, "", ""}
	tooltip[#tooltip+1] = {E.SEPARATOR_KEY}
	local visibleCount = 0
	local lastPeriod
	for _, event in ipairs(self.list) do
		local visible = event.periodID == PRESENT_PERIOD
			or (event.periodID == PAST_PERIOD and showPast)
			or (event.periodID == FUTURE_PERIOD and showFuture)
		if visible then
			visibleCount = visibleCount + 1
			local icon
			if event.icon then
				local pattern = (event.calendarType == "HOLIDAY") and iconStrPattern or iconStrCustomPattern
				icon = pattern:format(event.icon)
			elseif event.calendarType == "RAID_LOCKOUT" then
				icon = iconLockOut
			elseif event.calendarType ~= "HOLIDAY" then
				icon = CALENDAR_EVENTTYPE_TEXTURES[event.eventType]
			else
				icon = noIcon
			end
			if lastPeriod ~= event.periodID then
				if lastPeriod then
					tooltip[#tooltip+1] = {" "}
				end
				lastPeriod = event.periodID
			end
			local timeRemaining = ""
			if event.sortTime then
				local diff = event.sortTime - currentTimestamp
				if diff > 0 then
					local remainingStr = E.func_SecondsToClock(diff)
					if diff < 86400 then
						timeRemaining = self.db.timeDayColor[event.periodID] .. remainingStr .. "|r"
					else
						timeRemaining = self.db.timeColor[event.periodID] .. remainingStr .. "|r"
					end
				end
			end
			tooltip[#tooltip+1] = {icon .. event.title, timeRemaining, {event.dateStrLEFT, "RIGHT"}, event.dateStrRIGHT ~= "" and "-" or "", {event.dateStrRIGHT, "LEFT"}} -- , event.dateStr
		end
	end
	if visibleCount == 0 then
		tooltip[#tooltip+1] = {L["EMPTY"]}
	end
	return tooltip
end
----------------------------------------------------------------
-- CALENDAR_UPDATE_EVENT_LIST ----------------------------------
----------------------------------------------------------------
function EventFrame:CALENDAR_UPDATE_EVENT_LIST()
	if self.isUpdating then return end
	self:updateList()
	if Octo_TooltipFrame:IsShown() then
		Octo_CalendarButton.tooltip = function() return self:generateTooltipData() end
		E.func_Octo_TooltipFrame_OnEnter(Octo_CalendarButton, { "BOTTOMRIGHT", "TOPLEFT" })
	end
end
----------------------------------------------------------------
-- onEnter -----------------------------------------------------
----------------------------------------------------------------
function EventFrame:onEnter()
	self:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	self:updateList()
	C_Calendar.OpenCalendar()
	Octo_CalendarButton.tooltip = function() return self:generateTooltipData() end
	E.func_Octo_TooltipFrame_OnEnter(Octo_CalendarButton, { "BOTTOMRIGHT", "TOPLEFT" })
end
----------------------------------------------------------------
-- onLeave -----------------------------------------------------
----------------------------------------------------------------
function EventFrame:onLeave()
	self:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	Octo_TooltipFrame:Hide()
	Octo_CalendarButton.tooltip = nil
end
----------------------------------------------------------------