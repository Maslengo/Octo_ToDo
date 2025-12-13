local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end

	for reputationID in next,(E.ALL_Reputations) do
		if reputationID then
			local output = E.func_GetReputationProgress(reputationID)
			if C_Reputation.IsAccountWideReputation(reputationID) then
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					CharInfo.MASLENGO.Reputation[reputationID] = CharInfo.MASLENGO.Reputation[reputationID] or {}
					if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
						CharInfo.MASLENGO.Reputation[reputationID] = output
					end
				end
			else
				collectMASLENGO.Reputation[reputationID] = output
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_All_Reputations()
	E.func_SpamBlock(Collect_All_Reputations, true)
end