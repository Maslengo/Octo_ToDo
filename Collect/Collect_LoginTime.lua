local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_LoginTime()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
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
----------------------------------------------------------------
function E.Collect_LoginTime()
	E.func_SpamBlock(Collect_LoginTime, true)
end