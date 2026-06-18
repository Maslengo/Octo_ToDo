local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_ChromieTime()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
	if C_PlayerInfo.IsPlayerInChromieTime() then
		E.pd.Chromie_inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
	else
		E.pd.Chromie_inChromieTime = nil
	end
	if C_PlayerInfo.CanPlayerEnterChromieTime() then
		E.pd.Chromie_canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
	else
		E.pd.Chromie_canEnter = nil
	end
	if E.GameLimitedMode_IsActive then
		E.pd.GameLimitedMode_IsActive = E.GameLimitedMode_IsActive
	else
		E.pd.GameLimitedMode_IsActive = nil
	end
	local UnitChromieTimeID = UnitChromieTimeID("player")
	if UnitChromieTimeID ~= 0 then
		E.pd.Chromie_UnitChromieTimeID = UnitChromieTimeID
		for i = 1, #expansionOptions do
			if expansionOptions[i].id == UnitChromieTimeID then
				local expansionChromie = expansionOptions[i].name
				E.pd.Chromie_name = tostring(expansionChromie)
			end
		end
	else
		E.pd.Chromie_UnitChromieTimeID = nil
		E.pd.Chromie_name = nil
	end
end
----------------------------------------------------------------
function E.Collect_ChromieTime()
	E.func_SpamBlock(Collect_ChromieTime, true)
end
----------------------------------------------------------------