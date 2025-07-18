local GlobalAddonName, E = ...


function E.Collect_All_MoneyOnLogin()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local Money = GetMoney()
		collectPlayerData.MoneyOnLogin = Money
	end
end