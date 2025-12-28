local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Money_PLAYER_LOGIN()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local Money = GetMoney()
	collectPlayerData.MoneyOnLogin = Money
end
----------------------------------------------------------------
function E.Collect_Money_PLAYER_LOGIN()
	E.func_SpamBlock(Collect_Money_PLAYER_LOGIN, false)
end