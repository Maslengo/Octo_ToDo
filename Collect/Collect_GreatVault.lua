local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
E.Enum_Activities_table = {}
E.GW_Start = true
----------------------------------------------------------------
E.name_activities = setmetatable({
		[0] = E.NONE, -- "None"
		[1] = L["DUNGEONS"],                    -- Enum.WeeklyRewardChestThresholdType.Activities
		[2] = PVP,                                -- Enum.WeeklyRewardChestThresholdType.RankedPvP
		[3] = RAIDS,                            -- Enum.WeeklyRewardChestThresholdType.Raid
		[4] = "AlsoReceive",                    -- Enum.WeeklyRewardChestThresholdType.AlsoReceive
		[5] = WEEKLY_REWARDS_GET_CONCESSION,    -- Enum.WeeklyRewardChestThresholdType.Concession
		[6] = WORLD,                            -- Enum.WeeklyRewardChestThresholdType.World
	}, {
		__index = function(self, k)
			for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
				if i == k then
					self[k] = name
					return name
				end
			end
			return tostring(k)
		end
})
local function Collect_GreatVault()
	E.MythicPlus_seasonID = E.func_GetCurrentSeason()
	if E.GW_Start then
		for name, ID in next, (Enum.WeeklyRewardChestThresholdType) do
			local activities = E.func_GetActivities(ID)
			if activities[1] then
				E.Enum_Activities_table[#E.Enum_Activities_table+1] = ID
			end
		end
		if #E.Enum_Activities_table > 0 then
			table.sort(E.Enum_Activities_table)
		end
		E.GW_Start = false
	end
	-- local UnitLevel = UnitLevel("PLAYER") or 0
	-- if UnitLevel < 90 then return end
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	E.func_OnUIInteract()
	E.func_RequestRewards()
	E.func_RequestMapInfo()

	local mapChallengeModeIDs = E.func_GetMapTable()
	local currentWeekBestLevel = E.func_GetWeeklyChestRewardLevel()
	for i = 1, #mapChallengeModeIDs do
		local _, level = E.func_GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	local overallScore = E.func_GetOverallDungeonScore()
	----------------------------------------------------------------
	collectMASLENGO.GreatVault = collectMASLENGO.GreatVault or {}
	wipe(collectMASLENGO.GreatVault)
	----------------------------------------------------------------
	collectMASLENGO.RunHistory = collectMASLENGO.RunHistory or {}
	wipe(collectMASLENGO.RunHistory)
	local RunHistory = E.func_GetRunHistory(false, true)
	collectMASLENGO.RunHistory = RunHistory
	collectMASLENGO.totalRuns = RunHistory and #RunHistory or 0
	----------------------------------------------------------------
	collectPlayerData.MythicPlus = collectPlayerData.MythicPlus or {}
	collectPlayerData.MythicPlus[E.MythicPlus_seasonID] = collectPlayerData.MythicPlus[E.MythicPlus_seasonID] or {}
	collectPlayerData.MythicPlus[E.MythicPlus_seasonID].RIO_Score = E.func_Save(overallScore)
	collectPlayerData.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
	-- collectPlayerData.RIO_Score = E.func_Save(overallScore)
	-- collectPlayerData.RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
	----------------------------------------------------------------
	----------------------------------------------------------------
	if #E.Enum_Activities_table > 0 then
		for j = 1, #E.Enum_Activities_table do
			local ID = E.Enum_Activities_table[j]
			local activityInfo = E.func_GetActivities(ID)
			if activityInfo then
				local tbl = {}
				local hasRewards = false

				-- Progress
				for i = 1, #activityInfo do
					if activityInfo[i].progress and activityInfo[i].progress ~= 0 then
						tbl.min = activityInfo[i].progress
						-- break -- берём только первый ненулевой progress
					end
				end
				-- Rewards
				-- for i = 1, #activityInfo do
				-- 	local rewards = E.func_GetDetailedItemLevelInfo(E.func_GetExampleRewardItemHyperlinks(activityInfo[i].id))
				-- 	if rewards then
				-- 		tbl.rewards = tbl.rewards or {}
				-- 		tbl.rewards[i] = rewards
				-- 		hasRewards = true
				-- 	end
				-- end
				for i = 1, #activityInfo do
					local required = activityInfo[i].threshold or activityInfo[i].requiredCount or 0
					local currentProgress = activityInfo[1].progress or 0 -- общий прогресс для этой категории

					-- Проверяем, достигнут ли порог для этой награды
					if required > 0 and currentProgress >= required then
						local rewards = E.func_GetDetailedItemLevelInfo(E.func_GetExampleRewardItemHyperlinks(activityInfo[i].id))
						if rewards then
							tbl.rewards = tbl.rewards or {}
							tbl.rewards[i] = rewards
							hasRewards = true
						end
					else
						-- Опционально: явно ставим nil (можно и не делать, поле просто не создастся)
						if tbl.rewards then
							tbl.rewards[i] = nil
						end
					end
				end

				-- Сохраняем только если есть данные
				if tbl.min and hasRewards then
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
	collectPlayerData.HasAvailableRewards = E.func_Save(E.func_HasAvailableRewards())
	collectPlayerData.HasGeneratedRewards = E.func_Save(E.func_HasGeneratedRewards())

	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)
end
----------------------------------------------------------------
function E.Collect_GreatVault()
	E.func_SpamBlock(Collect_GreatVault, true, 5)
end
----------------------------------------------------------------
-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)