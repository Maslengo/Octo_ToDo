local GlobalAddonName, E = ...

-- Локализация часто используемых функций и переменных
local time = time
local GetServerTime = GetServerTime
local GetCVarBool, SetCVar = GetCVarBool, SetCVar
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = C_Calendar.GetNumDayEvents
local GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime

-- -- Функция для создания таблицы с датой
-- local function createDateTable(timeData)
-- 	return {
-- 		year = timeData.year,
-- 		month = timeData.month,
-- 		day = timeData.monthDay,
-- 		hour = timeData.hour,
-- 		min = timeData.minute,
-- 	}
-- end


local getCalendarTime do
	local t = {}
	function getCalendarTime(eTime)
		t.year = eTime.year
		t.month = eTime.month
		t.day = eTime.monthDay
		t.hour = eTime.hour
		t.min = eTime.minute
		return time(t)
	end
end

-- Функция для сохранения текущих настроек календаря
local function function_setBackup(backup)
	-- 1. Временная приостановка обработки событий календаря
	-- (не влияет на настройки, только на текущую сессию)
	if CalendarFrame then
		CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end

	-- 2. Сохраняем ТОЧНЫЕ текущие настройки (не изменяя их)
	local cvars = {
		"calendarShowHolidays",
		"calendarShowDarkmoon",
		"calendarShowLockouts",
		"calendarShowWeeklyHolidays",
		"calendarShowBattlegrounds"
	}

	for _, cvar in ipairs(cvars) do
		backup[cvar] = GetCVar(cvar) -- сохраняем как есть (string)
		-- Временное включение для сбора данных
		if GetCVarBool(cvar) ~= true then
			SetCVar(cvar, "1") -- только если было выключено
		end
	end

	-- 3. Сохраняем текущую дату календаря
	backup.dateBackup = GetMonthInfo()
	return backup
end

-- Функция для восстановления настроек календаря
local function function_restoreBackup(backup)
	-- 1. Восстанавливаем оригинальные значения CVar
	for cvar, value in pairs(backup) do
		if type(value) == "string" and cvar ~= "dateBackup" then
			-- Восстанавливаем ТОЧНОЕ оригинальное значение
			SetCVar(cvar, value)
		end
	end

	-- 2. Восстанавливаем дату (если есть)
	if backup.dateBackup then
		SetAbsMonth(backup.dateBackup.month, backup.dateBackup.year)
	end

	-- 3. Возобновляем обработку событий
	if CalendarFrame then
		CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end

-- Функция для генерации уникального ключа события
local function generateEventKey(eventID, startTime)
	return string.format("id:%d %02d_%02d_%02d",
		eventID,
		startTime.monthDay,
		startTime.month,
		startTime.year)
end









-- Основная функция сбора информации о праздниках
function E.Collect_All_Holiday()
	-- Проверка условий для выполнения функции
	if not (GetHolidayInfo and E.ActiveHoliday and E.Holiday and not InCombatLockdown()) then
		return
	end

	-- Инициализация backup
	local backup = {}

	-- Сохраняем текущие настройки
	backup = function_setBackup(backup)

	-- Получаем текущее календарное время
	local currentCalendarTime = GetCurrentCalendarTime()
	local minute, hour = currentCalendarTime.minute, currentCalendarTime.hour
	local monthDay, month = currentCalendarTime.monthDay, currentCalendarTime.month
	local year = currentCalendarTime.year
	local curTime = getCalendarTime(currentCalendarTime)

	-- Получаем информацию о текущем месяце
	local monthInfo = GetMonthInfo()
	local priority = 1

	-- Устанавливаем текущий месяц в календаре
	SetAbsMonth(month, year)

	-- Перебираем все дни месяца
	for day = 1, monthInfo.numDays do
		local numEvents = GetNumDayEvents(0, day)

		-- Перебираем все события дня
		for i = 1, numEvents do
			local event = GetDayEvent(0, day, i)

			-- Пропускаем не-праздники
			if not event or event.calendarType ~= "HOLIDAY" then
				break
			end

			-- Получаем информацию о празднике
			local eInfo = GetHolidayInfo(0, day, i)
			if not eInfo then
				break
			end

			local eventKey = generateEventKey(event.eventID, event.startTime)

			local holiday = E.Holiday[eventKey] or {}
			E.Holiday[eventKey] = holiday

			-- Инициализация нового праздника
			if not holiday.title then
				holiday.title = event.title
				local startTime, endTime = event.startTime, event.endTime
				-- local startDate = createDateTable(startTime)
				-- local endDate = createDateTable(endTime)
				local startDate = getCalendarTime(startTime)
				local endDate = getCalendarTime(endTime)

				local duration = endDate - startDate

				-- local date = C_DateAndTime.GetCurrentCalendarTime()


				-- print (C_DateAndTime.GetServerTimeLocal() == curTime)
				-- print (E:func_SecondsToClock(C_DateAndTime.GetServerTimeLocal()-curTime), C_DateAndTime.GetServerTimeLocal(), curTime)

				-- local curTime = C_DateAndTime.GetServerTimeLocal()

				holiday.event_duration = E.func_FriendsFrame_GetLastOnline(duration, true)
				holiday.startTime = E:func_fixdate(startTime.monthDay).."/"..E:func_fixdate(startTime.month)
				holiday.endTime = E:func_fixdate(endTime.monthDay).."/"..E:func_fixdate(endTime.month)
				-- holiday.ENDS = E:func_SecondsToClock(endDate - GetServerTime(), true)
				holiday.ENDS = E:func_SecondsToClock(endDate - curTime)
				holiday.iconTexture = eInfo.texture or event.iconTexture
				holiday.priority = priority
				holiday.eventID = event.eventID
				priority = priority + 1

				if event.sequenceType then
					holiday.sequenceType = event.sequenceType
				end
			elseif event.sequenceType ~= "ONGOING" and (not holiday.sequenceType or holiday.sequenceType == "ONGOING") then
				holiday.iconTexture = (GetHolidayInfo(0, day, i) or {}).texture or holiday.iconTexture
			end

			-- Проверка активных/возможных событий
			if day == monthDay then
				local secondsToEvent

				if event.sequenceType == "START" then
					secondsToEvent = ((event.startTime.hour - hour) * 60 + event.startTime.minute - minute) * 60
					holiday.Active = secondsToEvent <= 0
					holiday.Possible = not holiday.Active
				elseif event.sequenceType == "END" then
					secondsToEvent = ((event.endTime.hour - hour) * 60 + event.endTime.minute - minute) * 60
					holiday.Active = secondsToEvent > 0
				else
					holiday.Active = true
				end

				if holiday.Active then
					E.ActiveHoliday[event.eventID] = true
				end
			elseif monthDay < day then
				holiday.Possible = true
			end
		end
	end

	-- Восстанавливаем настройки
	function_restoreBackup(backup)
end