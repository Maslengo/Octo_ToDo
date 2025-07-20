local GlobalAddonName, E = ...


function E.Collect_All_MoneyUpdate()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		collectPlayerData.Money = GetMoney() or 0
		Octo_ToDo_DB_Other.AccountMoney[E.CurrentRegionName] = C_Bank.FetchDepositedMoney(2)
	end
end