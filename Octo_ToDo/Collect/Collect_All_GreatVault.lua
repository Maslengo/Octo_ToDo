local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_GreatVault()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	C_MythicPlus.RequestRewards()
	C_MythicPlus.RequestMapInfo()
	local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
	local currentWeekBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
	for i = 1, #mapChallengeModeIDs do
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	local overallScore = C_ChallengeMode.GetOverallDungeonScore()
	collectPlayerData.RIO_Score = (overallScore and overallScore ~= 0) and overallScore or nil
	collectPlayerData.RIO_weeklyBest = (currentWeekBestLevel and currentWeekBestLevel ~= 0) and currentWeekBestLevel or nil
	local name_activities = setmetatable({
			[0] = "None",
			[1] = DUNGEONS,
			[2] = "PvP",
			[3] = RAIDS,
			[4] = "AlsoReceive",
			[5] = "Concession",
			[6] = WORLD,
		}, {
			__index = function(self, k)
				for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
					if i == k then
						self[k] = name
						return name
					end
				end
				return k
			end
	})
	for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
		local activities = C_WeeklyRewards.GetActivities(i)
		local activity_name = name_activities[i] or name
		local vivod = nil
		for k = 1, #activities do
			local activityInfo = activities[k]
			if activityInfo then
				local tip = activityInfo.type
				if tip then
					collectMASLENGO.GreatVault[tip] = collectMASLENGO.GreatVault[tip] or {}
					local vaultEntry = collectMASLENGO.GreatVault[tip]
					vaultEntry.type = activity_name
					vaultEntry.progress = (activityInfo.progress and activityInfo.progress ~= 0) and activityInfo.progress or nil
					vaultEntry.threshold = activityInfo.threshold or nil
					local hyperlink_STRING = E.func_GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					if hyperlink_STRING then
						vivod = vivod and vivod..", "..hyperlink_STRING or hyperlink_STRING
						if vivod and vivod ~= "" then
							vaultEntry.hyperlink_STRING = vivod
						end
					else
						vaultEntry.hyperlink_STRING = nil
					end
				end
			end
		end
	end
	collectPlayerData.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards() or nil
end
----------------------------------------------------------------
function E.Collect_All_GreatVault()
	E.func_SpamBlock(Collect_All_GreatVault, true)
end