local GlobalAddonName, E = ...

function E.Collect_All_Holiday()
	if E.ActiveHoliday and E.Holiday and not InCombatLockdown() then
		local backup = Octo_ToDo_DB_Other.CVar
		local function function_setBackup()
			if CalendarFrame then
				CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
				CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
			end
			backup.calendarShowHolidays = GetCVarBool("calendarShowHolidays")
			backup.calendarShowDarkmoon = GetCVarBool("calendarShowDarkmoon")
			backup.calendarShowLockouts = GetCVarBool("calendarShowLockouts")
			backup.calendarShowWeeklyHolidays = GetCVarBool("calendarShowWeeklyHolidays")
			backup.calendarShowBattlegrounds = GetCVarBool("calendarShowBattlegrounds")
			if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "1") end
			if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "1") end
			if not backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "1") end
			if not backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "1") end
			if not backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "1") end
			backup.dateBackup = C_Calendar.GetMonthInfo()
		end
		local function function_restoreBackup()
			if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "0") end
			if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "0") end
			if not backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "0") end
			if not backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "0") end
			if not backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "0") end
			C_Calendar.SetAbsMonth(backup.dateBackup.month, backup.dateBackup.year)
			if CalendarFrame then
				CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
				CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
			end
		end
		function_setBackup()
		local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
		local minute = currentCalendarTime.minute
		local hour = currentCalendarTime.hour
		local monthDay = currentCalendarTime.monthDay
		local month = currentCalendarTime.month
		local offsetMonths = 0
		local year = currentCalendarTime.year
		local monthInfo = C_Calendar.GetMonthInfo()
		local priority = 0
		C_Calendar.SetAbsMonth(month, year)
		for day = 1, monthInfo.numDays do
			local numEvents = C_Calendar.GetNumDayEvents(offsetMonths, day)
			for i = 1, numEvents do
				local eInfo = C_Calendar.GetHolidayInfo(0, day, i)
				local event = C_Calendar.GetDayEvent(offsetMonths, day, i)
				local id = event.eventID
				-- E.Holiday[id] = E.Holiday[id] or {}
				if not E.Holiday[id] then
					E.Holiday[id] = E.Holiday[id] or {}
					E.Holiday[id].title = event.title -- E:func_EventName(id)
					local startTime = event.startTime
					local endTime = event.endTime
					local startTime_month = startTime.month
					local startTime_monthDay = startTime.monthDay
					local endTime_month = endTime.month
					local endTime_monthDay = endTime.monthDay
					local dateTbl_startTime = {
						year = startTime.year,
						month = startTime.month,
						day = startTime.monthDay,
						hour = startTime.hour,
						min = startTime.minute,
					}
					local dateTbl_endTime = {
						year = endTime.year,
						month = endTime.month,
						day = endTime.monthDay,
						hour = endTime.hour,
						min = endTime.minute,
					}
					local event_duration = E.func_FriendsFrame_GetLastOnline(time(dateTbl_endTime)-time(dateTbl_startTime), true)
					E.Holiday[id].event_duration = event_duration
					E.Holiday[id].startTime = E:func_fixdate(startTime_monthDay).."/"..E:func_fixdate(startTime_month)
					E.Holiday[id].endTime = E:func_fixdate(endTime_monthDay).."/"..E:func_fixdate(endTime_month)
					E.Holiday[id].ENDS = E:func_SecondsToClock(time(dateTbl_endTime)-GetServerTime(), true)
					if eInfo then
						E.Holiday[id].iconTexture = eInfo.texture or E.Icon_QuestionMark
					else
						E.Holiday[id].iconTexture = event.iconTexture or E.Icon_QuestionMark
						E.Holiday[id].ENDS = event_duration
					end
					E.Holiday[id].invitedBy = event.invitedBy
					if not E.Holiday[id].priority then
						E.Holiday[id].priority = priority
						priority = priority + 1
					end
					if event.sequenceType then
						E.Holiday[id].sequenceType = event.sequenceType
					end
				elseif event.sequenceType ~= "ONGOING" and (not E.Holiday[id].sequenceType or E.Holiday[id].sequenceType == "ONGOING") then
					E.Holiday[id].iconTexture = C_Calendar.GetHolidayInfo(0, day, i).texture
				end
				if day == monthDay then
					if event.sequenceType == "START" then
						local secondsToEvent = ((event.startTime.hour - hour) * 60 + event.startTime.minute - minute) * 60
						if secondsToEvent <= 0 then
							E.ActiveHoliday[id] = true
							E.Holiday[id].Active = true
						else
							E.Holiday[id].Possible = true
						end
					elseif event.sequenceType == "END" then
						local secondsToEvent = ((event.endTime.hour - hour) * 60 + event.endTime.minute - minute) * 60
						if secondsToEvent > 0 then
							E.ActiveHoliday[id] = true
							E.Holiday[id].Active = true
						end
					else
						E.ActiveHoliday[id] = true
						E.Holiday[id].Active = true
					end
				elseif monthDay < day then
					E.Holiday[id].Possible = true
				end
			end
		end
		function_restoreBackup()
	end
end