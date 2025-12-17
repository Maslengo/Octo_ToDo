local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Money_PLAYER_LOGIN()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local Money = GetMoney()
	collectPlayerData.MoneyOnLogin = Money
end
----------------------------------------------------------------
function E.Collect_Money_PLAYER_LOGIN()
	E.func_SpamBlock(Collect_Money_PLAYER_LOGIN, false)
end