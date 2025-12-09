local GlobalAddonName, E = ...
function E.Collect_All_MoneyUpdate()
	if E.func_SpamBlock("Collect_All_MoneyUpdate", false) then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.Money = GetMoney() or 0
	Octo_ToDo_DB_Other.AccountMoney[E.CurrentRegionName] = C_Bank.FetchDepositedMoney(2)
end