local GlobalAddonName, E = ...
function E.Collect_All_Chromie()
	if E.func_SpamBlock("Collect_All_Chromie") then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
	if C_PlayerInfo.IsPlayerInChromieTime() then
		collectPlayerData.Chromie_inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
	else
		collectPlayerData.Chromie_inChromieTime = nil
	end
	if C_PlayerInfo.CanPlayerEnterChromieTime() then
		collectPlayerData.Chromie_canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
	else
		collectPlayerData.Chromie_canEnter = nil
	end
	if E.GameLimitedMode_IsActive then
		collectPlayerData.GameLimitedMode_IsActive = E.GameLimitedMode_IsActive
	else
		collectPlayerData.GameLimitedMode_IsActive = nil
	end
	local UnitChromieTimeID = UnitChromieTimeID("player")
	if UnitChromieTimeID ~= 0 then
		collectPlayerData.Chromie_UnitChromieTimeID = UnitChromieTimeID
		for i = 1, #expansionOptions do
			if expansionOptions[i].id == UnitChromieTimeID then
				local expansionChromie = expansionOptions[i].name
				collectPlayerData.Chromie_name = tostring(expansionChromie)
			end
		end
	else
		collectPlayerData.Chromie_UnitChromieTimeID = nil
		collectPlayerData.Chromie_name = nil
	end
end