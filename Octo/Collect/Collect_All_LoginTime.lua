local GlobalAddonName, E = ...

function E.Collect_All_LoginTime()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.loginDate = date("%d.%m.%Y %H:%M:%S")
		collectPlayerData.loginDay = date("%d.%m.%Y")
		collectPlayerData.loginHour = date("%H:%M")
		collectPlayerData.needResetWeekly = nil
		collectPlayerData.needResetDaily = nil
		collectPlayerData.needResetMonth = nil
		collectPlayerData.time = time()
	end
end