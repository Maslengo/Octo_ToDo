local GlobalAddonName, E = ...
local time = time
local GetServerTime = GetServerTime
local GetCVarBool, SetCVar = GetCVarBool, SetCVar
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = C_Calendar.GetNumDayEvents
local GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
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
local function function_setBackup(backup)
	if CalendarFrame then
		CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
	local cvars = {
		"calendarShowHolidays",
		"calendarShowDarkmoon",
		"calendarShowLockouts",
		"calendarShowWeeklyHolidays",
		"calendarShowBattlegrounds"
	}
	for _, cvar in ipairs(cvars) do
		backup[cvar] = GetCVar(cvar)
		if GetCVarBool(cvar) ~= true then
			SetCVar(cvar, "1")
		end
	end
	backup.dateBackup = GetMonthInfo()
	return backup
end
local function function_restoreBackup(backup)
	for cvar, value in pairs(backup) do
		if type(value) == "string" and cvar ~= "dateBackup" then
			SetCVar(cvar, value)
		end
	end
	if backup.dateBackup then
		SetAbsMonth(backup.dateBackup.month, backup.dateBackup.year)
	end
	if CalendarFrame then
		CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end
local function generateEventKey(eventID, startTime)
	return string.format("id:%d %02d_%02d_%02d",
		eventID,
		startTime.monthDay,
		startTime.month,
		startTime.year)
end
function E.Collect_All_Holiday()
	-- if E.func_SpamBlock("Collect_All_Holiday") then return end
	if not (GetHolidayInfo and E.ActiveHoliday and E.Holiday) then
		return
	end
	local backup = {}
	backup = function_setBackup(backup)
	local currentCalendarTime = GetCurrentCalendarTime()
	local minute, hour = currentCalendarTime.minute, currentCalendarTime.hour
	local monthDay, month = currentCalendarTime.monthDay, currentCalendarTime.month
	local year = currentCalendarTime.year
	local curTime = getCalendarTime(currentCalendarTime)
	local monthInfo = GetMonthInfo()
	local priority = 1
	SetAbsMonth(month, year)
	for day = 1, monthInfo.numDays do
		local numEvents = GetNumDayEvents(0, day)
		for i = 1, numEvents do
			local event = GetDayEvent(0, day, i)
			if not event or event.calendarType ~= "HOLIDAY" then
				break
			end
			local eInfo = GetHolidayInfo(0, day, i)
			if not eInfo then
				break
			end
			local eventKey = generateEventKey(event.eventID, event.startTime)
			local holiday = E.Holiday[eventKey] or {}
			E.Holiday[eventKey] = holiday
			if not holiday.title then
				holiday.title = event.title
				local startTime, endTime = event.startTime, event.endTime
				local startDate = getCalendarTime(startTime)
				local endDate = getCalendarTime(endTime)
				local duration = endDate - startDate
				holiday.event_duration = E.func_FriendsFrame_GetLastOnline(duration, true)
				holiday.startTime = E.func_fixdate(startTime.monthDay).."/"..E.func_fixdate(startTime.month)
				holiday.endTime = E.func_fixdate(endTime.monthDay).."/"..E.func_fixdate(endTime.month)
				holiday.ENDS = E.func_SecondsToClock(endDate - curTime)
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
	function_restoreBackup(backup)
end
