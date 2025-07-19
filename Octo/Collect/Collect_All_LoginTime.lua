local GlobalAddonName, E = ...

function E.Collect_All_LoginTime()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.loginDate = date("%d.%m.%Y %H:%M:%S")
		collectPlayerData.loginDay = date("%d.%m.%Y")
		collectPlayerData.loginHour = date("%H:%M")
		collectPlayerData.needResetWeekly = false
		collectPlayerData.needResetDaily = false
		collectPlayerData.needResetMonth = false
		collectPlayerData.time = time()

		collectPlayerData.tmstp_Daily = C_DateAndTime.GetSecondsUntilDailyReset() + GetServerTime()
		collectPlayerData.tmstp_Weekly = C_DateAndTime.GetSecondsUntilWeeklyReset() + GetServerTime()
	end
end