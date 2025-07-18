local GlobalAddonName, E = ...

function E.Collect_All_GreatVault()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
		C_MythicPlus.RequestRewards()
		local currentWeekBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
		C_MythicPlus.RequestMapInfo()
		for i = 1, #mapChallengeModeIDs do
			local _, level = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeIDs[i])
			if level and level > currentWeekBestLevel then
				currentWeekBestLevel = level
			end
		end
		if C_ChallengeMode.GetOverallDungeonScore("PLAYER") and C_ChallengeMode.GetOverallDungeonScore("PLAYER") ~= 0 then
			collectPlayerData.RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
		else
			collectPlayerData.RIO_Score = nil
		end
		if currentWeekBestLevel and currentWeekBestLevel ~= 0 then
			collectPlayerData.RIO_weeklyBest = currentWeekBestLevel
		else
			collectPlayerData.RIO_weeklyBest = nil
		end
		local name_activities = setmetatable({
				[0] = "None",
				[1] = DUNGEONS,
				[2] = "PvP",
				[3] = RAIDS,
				[4] = "AlsoReceive",
				[5] = "Concession",
				[6] = WORLD,
			}, {__index = function(self, k)
					for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
						if i == k then
							self[k] = name
							break
						end
					end
					return self[k]
				end
		})
		for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
			local activities = C_WeeklyRewards.GetActivities(i)
			local activity_name = name_activities[i] or name
			for k = 1, #activities do
				local activityInfo = activities[k]
				if activityInfo then
					local tip = activityInfo.type
					if collectPlayerData and tip ~= nil then
						collectMASLENGO.GreatVault[tip] = collectMASLENGO.GreatVault[tip] or {}
						collectMASLENGO.GreatVault[tip].type = activity_name
						if activityInfo.progress and activityInfo.progress ~= 0 then
							collectMASLENGO.GreatVault[tip].progress = activityInfo.progress
						else
							collectMASLENGO.GreatVault[tip].progress = nil
						end
						if activityInfo.threshold then
							collectMASLENGO.GreatVault[tip].threshold = activityInfo.threshold
						else
							collectMASLENGO.GreatVault[tip].threshold = nil
						end
						local hyperlink = E:func_GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						local hyperlink_STRING = E:func_GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						if hyperlink_STRING ~= nil then
							local vivod = vivod and vivod..", "..hyperlink_STRING or hyperlink_STRING
							if vivod and vivod ~= "" and vivod ~= 0 then
								collectMASLENGO.GreatVault[tip].hyperlink_STRING = vivod
							end
						else
							collectMASLENGO.GreatVault[tip].hyperlink_STRING = nil
						end
					end
				end
			end
		end
		collectPlayerData.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards() or nil
	end
end