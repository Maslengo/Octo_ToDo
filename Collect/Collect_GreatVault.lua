local GlobalAddonName, E = ...
----------------------------------------------------------------
E.Enum_Activities_table = {}
E.GW_Start = true
----------------------------------------------------------------
local function Collect_GreatVault()
	----------------------------------------------------------------
	E.name_activities = setmetatable({
			[0] = E.NONE, -- "None"
			[1] = DUNGEONS,							-- Enum.WeeklyRewardChestThresholdType.Activities
			[2] = PVP,								-- Enum.WeeklyRewardChestThresholdType.RankedPvP
			[3] = RAIDS,							-- Enum.WeeklyRewardChestThresholdType.Raid
			[4] = "AlsoReceive",					-- Enum.WeeklyRewardChestThresholdType.AlsoReceive
			[5] = WEEKLY_REWARDS_GET_CONCESSION,	-- Enum.WeeklyRewardChestThresholdType.Concession
			[6] = WORLD,							-- Enum.WeeklyRewardChestThresholdType.World
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

	-- local numHeroic, numMythic, numMythicPlus = C_WeeklyRewards.GetNumCompletedDungeonRuns()
	-- local hasGeneratedRewards = C_WeeklyRewards.HasGeneratedRewards()
	-- local hasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	----------------------------------------------------------------
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end

	collectMASLENGO.GreatVault = collectMASLENGO.GreatVault or {}
	wipe(collectMASLENGO.GreatVault)
	-- collectPlayerData.RIO_Score = nil
	-- collectPlayerData.RIO_weeklyBest = nil
	-- collectPlayerData.HasAvailableRewards = nil

	-- local canClaimRewards = C_WeeklyRewards.CanClaimRewards()
	-- if not canClaimRewards then return end

	-- C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
	-- if WeeklyRewardsFrame then
	-- WeeklyRewardsFrame:Show()
	-- WeeklyRewardsFrame:Hide()
	-- end

	C_WeeklyRewards.OnUIInteract()
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
		----------------------------------------------------------------
		if E.GW_Start then
			 -- /run C_AddOns.LoadAddOn("Blizzard_WeeklyRewards"); WeeklyRewardsFrame:Show()
			for name, ID in next, (Enum.WeeklyRewardChestThresholdType) do
				local activities = C_WeeklyRewards.GetActivities(ID)
				if activities[1] then
					E.Enum_Activities_table[#E.Enum_Activities_table+1] = ID
				end
			end
			if #E.Enum_Activities_table > 0 then
				table.sort(E.Enum_Activities_table)
			end
			E.GW_Start = false
		end
		----------------------------------------------------------------
		if #E.Enum_Activities_table > 0 then
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local activityInfo = C_WeeklyRewards.GetActivities(ID)

				if activityInfo then
					local tbl = {}
					local hasRewards = false

					-- Progress
					for i = 1, #activityInfo do
						if activityInfo[i].progress and activityInfo[i].progress ~= 0 then
							tbl.min = activityInfo[i].progress
							break -- берём только первый ненулевой progress
						end
					end

					-- Rewards
					for i = 1, #activityInfo do
						local rewards = E.func_GetItemLevelDetails(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo[i].id))
						if rewards then
							tbl.rewards = tbl.rewards or {}
							tbl.rewards[i] = rewards
							hasRewards = true
						end
					end

					-- Сохраняем только если есть данные
					if tbl.min or hasRewards then
						-- local resetReward = nil
						collectMASLENGO.GreatVault.NextWeekReward = true
						collectMASLENGO.GreatVault[ID] = tbl
					else
						collectMASLENGO.GreatVault[ID] = nil
					end
				end
			end
		end
		----------------------------------------------------------------
	local OwnedKeystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
	collectPlayerData.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards() or nil
	--opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)
end
----------------------------------------------------------------
function E.Collect_GreatVault()
	E.func_SpamBlock(Collect_GreatVault, true)
end
----------------------------------------------------------------
-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)