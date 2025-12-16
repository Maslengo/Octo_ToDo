local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end

	for reputationID in next,(E.OctoTable_Reputations_DB) do -- E.ALL_Reputations
		local output = E.func_GetReputationProgress(reputationID)
		local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID)

		if isAccountWide then
			-- Аккаунтовая: обновляем всех
			for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
				local pd = CharInfo.PlayerData
				local cm = CharInfo.MASLENGO

				if pd.CurrentRegionName == E.CurrentRegionName then
					cm.Reputation = cm.Reputation or {}
					cm.Reputation[reputationID] = output or nil
				end
			end
		else
			-- Персонажная: только текущему
			collectMASLENGO.Reputation = collectMASLENGO.Reputation or {}
			collectMASLENGO.Reputation[reputationID] = output or nil
		end
	end
end
----------------------------------------------------------------
function E.Collect_All_Reputations()
	E.func_SpamBlock(Collect_All_Reputations, true)
end
