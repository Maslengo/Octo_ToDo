local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_LoginTime()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	E.pd.loginDate = date("%d.%m.%Y %H:%M:%S")
	E.pd.loginDay = date("%d.%m.%Y")
	E.pd.loginHour = date("%H:%M")
	E.pd.needResetWeekly = nil
	E.pd.needResetDaily = nil
	E.pd.needResetMonth = nil
	E.pd.time = E.TIME_SERVER() -- ServerTime
	E.pd.tmstp_Daily = E.func_GetSecondsUntilDailyReset() + E.TIME_SERVER()
	E.pd.tmstp_Weekly = E.func_GetSecondsUntilWeeklyReset() + E.TIME_SERVER()


	-- E.pd.WeeklyReset = E.func_Save(E.TIME_SERVER() + E.func_GetSecondsUntilWeeklyReset()) -- GetServerTime() + C_DateAndTime.GetSecondsUntilWeeklyReset()
	-- E.pd.DailyReset = E.func_Save(E.TIME_SERVER() + E.func_GetSecondsUntilDailyReset()) -- GetServerTime() + C_DateAndTime.GetSecondsUntilWeeklyReset()


end
----------------------------------------------------------------
function E.Collect_LoginTime()
	E.func_SpamBlock(Collect_LoginTime, true)
end
----------------------------------------------------------------