local GlobalAddonName, E = ...
function E.Collect_All_Reputations()
	if E.func_SpamBlock("Collect_All_Reputations") then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end




	-- local tbl = Octo_Cache_DB.AllReputations
	-- local tbl = Octo_ToDo_DB_VisualUserSettings.Reputations



	-- local tbl = E.ALL_Reputations

	-- for _, reputationID in ipairs(tbl) do
	-- 	if reputationID then
	-- 		local vivod = E.func_CheckReputation(reputationID)
	-- 		if C_Reputation.IsAccountWideReputation(reputationID) then
	-- 			for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
	-- 				CharInfo.MASLENGO.Reputation[reputationID] = CharInfo.MASLENGO.Reputation[reputationID] or {}
	-- 				if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
	-- 					CharInfo.MASLENGO.Reputation[reputationID] = vivod
	-- 				end
	-- 			end
	-- 		else
	-- 			collectMASLENGO.Reputation[reputationID] = vivod
	-- 		end
	-- 	end
	-- end




	for reputationID = 1, 4000 do
		if E.func_reputationName(reputationID) ~= E.Lime_Color..UNKNOWN.."|r" then
			local vivod = E.func_CheckReputation(reputationID)
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



	-- local tempTBL = {}
	-- for id = 1, 4000 do
	-- 	tempTBL[id] = E.func_reputationName(id)
	-- end
	-- fpde(tempTBL)


end