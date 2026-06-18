local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Money_PLAYER_LOGIN()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local Money = GetMoney()
	E.pd.MoneyOnLogin = Money
	E.pd.RELOAD_COUNT = (E.pd.RELOAD_COUNT or 0) + 1
end
----------------------------------------------------------------
function E.Collect_Money_PLAYER_LOGIN()
	E.func_SpamBlock(Collect_Money_PLAYER_LOGIN, false)
end
----------------------------------------------------------------