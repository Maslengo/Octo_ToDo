local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
E.Enum_Activities_table = {}
E.GW_INIT = true
----------------------------------------------------------------
E.name_activities = setmetatable({
		[0] = E.NONE, -- "None"
		[1] = L["DUNGEONS"], -- Enum.WeeklyRewardChestThresholdType.Activities
		[2] = PVP, -- Enum.WeeklyRewardChestThresholdType.RankedPvP
		[3] = RAIDS, -- Enum.WeeklyRewardChestThresholdType.Raid
		[4] = "AlsoReceive", -- Enum.WeeklyRewardChestThresholdType.AlsoReceive
		[5] = WEEKLY_REWARDS_GET_CONCESSION, -- Enum.WeeklyRewardChestThresholdType.Concession
		[6] = WORLD, -- Enum.WeeklyRewardChestThresholdType.World
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
----------------------------------------------------------------
-- InitActivities ----------------------------------------------
----------------------------------------------------------------
local function InitActivities()
	if not E.GW_INIT then return end
	for _, ID in next, Enum.WeeklyRewardChestThresholdType do
		local activities = E.func_GetActivities(ID)
		if activities and activities[1] then
			E.Enum_Activities_table[#E.Enum_Activities_table + 1] = ID
		end
	end
	local priority = {
		[3] = 1, -- RAID
		[1] = 2, -- DUNGEONS
	}
	E.func_SortRecords(E.Enum_Activities_table, function(a, b)
			local pa = priority[a] or 99
			local pb = priority[b] or 99
			if pa ~= pb then return pa < pb end
			return a < b
	end)
	E.GW_INIT = false
end
----------------------------------------------------------------
-- ProgressAndRewards ------------------------------------------
----------------------------------------------------------------
local function CollectProgressAndRewards(activityInfo)
	local tbl, hasRewards = {}, false
	for i = 1, #activityInfo do
		local info = activityInfo[i]
		local progress = info.progress or 0
		if progress ~= 0 then
			tbl.min = progress
		end
		local required = info.threshold or info.requiredCount or 0
		if required > 0 and progress >= required then
			local rewards = E.func_GetDetailedItemLevelInfo(
				E.func_GetExampleRewardItemHyperlinks(info.id)
			)
			if rewards then
				tbl.rewards = tbl.rewards or {}
				tbl.rewards[i] = rewards
				hasRewards = true
			end
			tbl.activities = tbl.activities or {}
			tbl.activities[i] = info
		end
	end
	return tbl, hasRewards
end
----------------------------------------------------------------
-- GreatVault --------------------------------------------------
----------------------------------------------------------------
local function CollectGreatVault()
	E.cm.GreatVault = {}
	wipe(E.cm.GreatVault)
	for _, ID in ipairs(E.Enum_Activities_table) do
		local activityInfo = E.func_GetActivities(ID)
		if activityInfo then
			local tbl, hasRewards = CollectProgressAndRewards(activityInfo)
			if tbl.min and hasRewards then
				E.cm.GreatVault.NextWeekReward = true
				E.cm.GreatVault[ID] = tbl
			end
		end
	end
end
----------------------------------------------------------------
-- RunHistory --------------------------------------------------
----------------------------------------------------------------
local function CollectRunHistory()
	E.cm.RunHistory = {}
	wipe(E.cm.RunHistory)
	local history = E.func_GetRunHistory(false, true)
	E.cm.RunHistory = history
	E.cm.totalRuns = history and #history or 0
end
----------------------------------------------------------------
-- BossDifficulties --------------------------------------------
----------------------------------------------------------------
local function CollectBossDifficulties()
	local out = {}
	for vaultTypeID, _ in ipairs(E.name_activities) do
		for index = 1, 3 do
			local encounters = E.func_GetActivityEncounterInfo(vaultTypeID, index)
			if encounters then
				for _, boss in ipairs(encounters) do
					local instanceID = boss.instanceID
					local encounterID = boss.encounterID
					out[instanceID] = out[instanceID] or {}
					local entry = out[instanceID][encounterID]
					if not entry then
						out[instanceID][encounterID] = {
							difficulty = boss.bestDifficulty,
							order = boss.uiOrder
						}
					else
						entry.difficulty = math.max(entry.difficulty, boss.bestDifficulty)
					end
				end
			end
		end
	end
	E.cm.GreatVaultbossDifficulties = out
end
----------------------------------------------------------------
-- PlayerData --------------------------------------------------
----------------------------------------------------------------
local function CollectPlayerData()
	E.pd.MythicPlus = E.pd.MythicPlus or {}
	E.pd.MythicPlus[E.MythicPlus_seasonID] = E.pd.MythicPlus[E.MythicPlus_seasonID] or {}
	E.pd.MythicPlus[E.MythicPlus_seasonID].RIO_Score = E.func_Save(E.func_GetOverallDungeonScore())
	local mapChallengeModeIDs = E.func_GetMapTable()
	local currentWeekBestLevel = E.func_GetWeeklyChestRewardLevel()
	for i = 1, #mapChallengeModeIDs do
		local _, level = E.func_GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	E.pd.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
	E.pd.HasAvailableRewards = E.func_Save(E.func_HasAvailableRewards())
	E.pd.HasGeneratedRewards = E.func_Save(E.func_HasGeneratedRewards())
end
----------------------------------------------------------------
-- Collect_GreatVault ------------------------------------------
----------------------------------------------------------------
local function Collect_GreatVault()
	E.MythicPlus_seasonID = E.func_GetCurrentSeason()
	InitActivities()
	if not E.func_CanCollectData() then return end
	local db = Octo_ToDo_DB_Levels[E.curGUID]
	E.func_OnUIInteract()
	E.func_RequestRewards()
	E.func_RequestMapInfo()
	CollectPlayerData()
	CollectRunHistory()
	CollectBossDifficulties()
	CollectGreatVault()
end
----------------------------------------------------------------
function E.Collect_GreatVault()
	E.func_SpamBlock(Collect_GreatVault, true, 5)
end
----------------------------------------------------------------