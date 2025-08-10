local GlobalAddonName, E = ...


function E.Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	-- C_Reputation.ExpandAllFactionHeaders()
	if not collectMASLENGO then return end
	-- fpde(Octo_Cache_DB.AllReputations)
	-- local tbl = {}
	-- ----------------------------------------------------------------



	if Octo_Cache_DB and E.curLocaleLang and Octo_Cache_DB.AllReputations then

		for reputationID, v in next, (Octo_Cache_DB.AllReputations) do
			if reputationID then
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
	end





	-- if Octo_Cache_DB and E.curLocaleLang and Octo_Cache_DB[E.curLocaleLang] and Octo_Cache_DB[E.curLocaleLang].AllReputations then
	-- 	for reputationID, reputationName_DB in next, (Octo_Cache_DB[E.curLocaleLang].AllReputations) do
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
	----------------------------------------------------------------
	-- for _, tbl in ipairs(E.OctoTable_Reputations) do


	-- 	for _, v in ipairs(tbl) do
	-- 		local reputationID = v.id
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
	----------------------------------------------------------------
end