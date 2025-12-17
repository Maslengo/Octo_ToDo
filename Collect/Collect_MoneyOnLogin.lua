local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_MoneyOnLogin()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local Money = GetMoney()
	collectPlayerData.MoneyOnLogin = Money
end
----------------------------------------------------------------
function E.Collect_MoneyOnLogin()
	E.func_SpamBlock(Collect_MoneyOnLogin, false)
end