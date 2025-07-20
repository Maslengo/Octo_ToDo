local GlobalAddonName, E = ...


function E.Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	C_Reputation.ExpandAllFactionHeaders()
	if collectMASLENGO and not InCombatLockdown() then
		----------------------------------------------------------------
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			for i, v in ipairs(tbl) do
				local reputationID = v.id
				local vivod = E:func_CheckReputation(reputationID)
				if C_Reputation.IsAccountWideReputation(reputationID) then
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.MASLENGO.Reputation[reputationID] = CharInfo.MASLENGO.Reputation[reputationID] or {}
						if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
							CharInfo.MASLENGO.Reputation[reputationID] = vivod
						end
					end
				else
					collectMASLENGO.Reputation[reputationID] = vivod
				end
			end
		end
		----------------------------------------------------------------
	end
end