local GlobalAddonName, E = ...
function E.Collect_All_MoneyOnLogin()
	if E.func_SpamBlock("Collect_All_MoneyOnLogin", false) then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local Money = GetMoney()
	collectPlayerData.MoneyOnLogin = Money
end