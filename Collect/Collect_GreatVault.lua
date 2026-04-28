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
	table.sort(E.Enum_Activities_table, function(a, b)
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
local function CollectGreatVault(db)
	local maslengo = db.MASLENGO
	maslengo.GreatVault = {}
	wipe(maslengo.GreatVault)
	for _, ID in ipairs(E.Enum_Activities_table) do
		local activityInfo = E.func_GetActivities(ID)
		if activityInfo then
			local tbl, hasRewards = CollectProgressAndRewards(activityInfo)
			if tbl.min and hasRewards then
				maslengo.GreatVault.NextWeekReward = true
				maslengo.GreatVault[ID] = tbl
			end
		end
	end
end
----------------------------------------------------------------
-- RunHistory --------------------------------------------------
----------------------------------------------------------------
local function CollectRunHistory(db)
	local maslengo = db.MASLENGO
	maslengo.RunHistory = {}
	wipe(maslengo.RunHistory)
	local history = E.func_GetRunHistory(false, true)
	maslengo.RunHistory = history
	maslengo.totalRuns = history and #history or 0
end
----------------------------------------------------------------
-- BossDifficulties --------------------------------------------
----------------------------------------------------------------
local function CollectBossDifficulties(db)
	local maslengo = db.MASLENGO
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
	maslengo.GreatVaultbossDifficulties = out
end
----------------------------------------------------------------
-- PlayerData --------------------------------------------------
----------------------------------------------------------------
local function CollectPlayerData(db)
	local player = db.PlayerData
	player.MythicPlus = player.MythicPlus or {}
	player.MythicPlus[E.MythicPlus_seasonID] = player.MythicPlus[E.MythicPlus_seasonID] or {}
	player.MythicPlus[E.MythicPlus_seasonID].RIO_Score = E.func_Save(E.func_GetOverallDungeonScore())

	local mapChallengeModeIDs = E.func_GetMapTable()
	local currentWeekBestLevel = E.func_GetWeeklyChestRewardLevel()
	for i = 1, #mapChallengeModeIDs do
		local _, level = E.func_GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	player.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
end
----------------------------------------------------------------
-- Collect_GreatVault ------------------------------------------
----------------------------------------------------------------
local function Collect_GreatVault()
	E.MythicPlus_seasonID = E.func_GetCurrentSeason()
	InitActivities()
	if not E:func_CanCollectData() then return end
	local db = Octo_ToDo_DB_Levels[E.curGUID]

	E.func_OnUIInteract()
	E.func_RequestRewards()
	E.func_RequestMapInfo()

	CollectPlayerData(db)
	CollectRunHistory(db)
	CollectBossDifficulties(db)
	CollectGreatVault(db)
end
----------------------------------------------------------------
function E.Collect_GreatVault()
	E.func_SpamBlock(Collect_GreatVault, true, 5)
end
----------------------------------------------------------------
-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)
----------------------------------------------------------------
-- local function Collect_GreatVault()
-- E.MythicPlus_seasonID = E.func_GetCurrentSeason()
-- if E.GW_INIT then
-- for name, ID in next, (Enum.WeeklyRewardChestThresholdType) do
-- local activities = E.func_GetActivities(ID)
-- if activities[1] then
-- E.Enum_Activities_table[#E.Enum_Activities_table+1] = ID
-- end
-- end
-- if #E.Enum_Activities_table > 0 then
-- -- Приоритет сортировки: сначала RAID, потом DUNGEONS, потом всё остальное по возрастанию ID
-- local priorityOrder = {
-- [3] = 1, -- RAID
-- [1] = 2, -- DUNGEONS
-- }
-- table.sort(E.Enum_Activities_table, function(a, b)
-- local pa = priorityOrder[a] or 99
-- local pb = priorityOrder[b] or 99
-- if pa ~= pb then
-- return pa < pb
-- end
-- return a < b -- если приоритет одинаковый, сортируем по ID
-- end)
-- end
-- E.GW_INIT = false
-- end
-- -- local UnitLevel = UnitLevel("PLAYER") or 0
-- -- if UnitLevel < 90 then return end
-- ----------------------------------------------------------------
-- if not E:func_CanCollectData() then return end
-- local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
-- local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- E.func_OnUIInteract()
-- E.func_RequestRewards()
-- E.func_RequestMapInfo()
-- local mapChallengeModeIDs = E.func_GetMapTable()
-- local currentWeekBestLevel = E.func_GetWeeklyChestRewardLevel()
-- for i = 1, #mapChallengeModeIDs do
-- 	local _, level = E.func_GetWeeklyBestForMap(mapChallengeModeIDs[i])
-- 	if level and level > currentWeekBestLevel then
-- 		currentWeekBestLevel = level
-- 	end
-- end






-- local overallScore = E.func_GetOverallDungeonScore()
-- ----------------------------------------------------------------
-- collectMASLENGO.GreatVault = collectMASLENGO.GreatVault or {}
-- wipe(collectMASLENGO.GreatVault)
-- ----------------------------------------------------------------
-- collectMASLENGO.RunHistory = collectMASLENGO.RunHistory or {}
-- wipe(collectMASLENGO.RunHistory)
-- local RunHistory = E.func_GetRunHistory(false, true)
-- collectMASLENGO.RunHistory = RunHistory
-- collectMASLENGO.totalRuns = RunHistory and #RunHistory or 0
-- ----------------------------------------------------------------
-- collectPlayerData.MythicPlus = collectPlayerData.MythicPlus or {}
-- collectPlayerData.MythicPlus[E.MythicPlus_seasonID] = collectPlayerData.MythicPlus[E.MythicPlus_seasonID] or {}
-- collectPlayerData.MythicPlus[E.MythicPlus_seasonID].RIO_Score = E.func_Save(overallScore)
-- collectPlayerData.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
-- -- collectPlayerData.RIO_Score = E.func_Save(overallScore)
-- -- collectPlayerData.RIO_weeklyBest = E.func_Save(currentWeekBestLevel)
-- ----------------------------------------------------------------
-- collectMASLENGO.GreatVaultbossDifficulties = {}
-- local GreatVaultbossDifficulties = {}
-- for vaultTypeid, v in ipairs(E.name_activities) do
-- for index = 1, 3 do
-- local encounters = E.func_GetActivityEncounterInfo(vaultTypeid, index)
-- if encounters then
-- for _, boss in ipairs(encounters) do
-- local instanceID = boss.instanceID
-- local encounterID = boss.encounterID
-- local uiOrder = boss.uiOrder
-- GreatVaultbossDifficulties[instanceID] = GreatVaultbossDifficulties[instanceID] or {}
-- -- Сохраняем вместе с uiOrder для сортировки
-- if not GreatVaultbossDifficulties[instanceID][encounterID] then
-- GreatVaultbossDifficulties[instanceID][encounterID] = {
-- difficulty = boss.bestDifficulty,
-- order = uiOrder
-- }
-- else
-- GreatVaultbossDifficulties[instanceID][encounterID].difficulty = math.max(
-- GreatVaultbossDifficulties[instanceID][encounterID].difficulty,
-- boss.bestDifficulty
-- )
-- end
-- end
-- end
-- end
-- end
-- collectMASLENGO.GreatVaultbossDifficulties = GreatVaultbossDifficulties
-- ----------------------------------------------------------------
-- if #E.Enum_Activities_table > 0 then
-- for j = 1, #E.Enum_Activities_table do
-- local ID = E.Enum_Activities_table[j]
-- local activityInfo = E.func_GetActivities(ID)
-- if activityInfo then
-- local tbl = {}
-- local hasRewards = false
-- -- Rewards
-- -- for i = 1, #activityInfo do
-- -- local rewards = E.func_GetDetailedItemLevelInfo(E.func_GetExampleRewardItemHyperlinks(activityInfo[i].id))
-- -- if rewards then
-- -- tbl.rewards = tbl.rewards or {}
-- -- tbl.rewards[i] = rewards
-- -- hasRewards = true
-- -- end
-- -- end
-- for i = 1, #activityInfo do
-- -- Progress
-- if activityInfo[i].progress and activityInfo[i].progress ~= 0 then
-- tbl.min = activityInfo[i].progress
-- -- break -- берём только первый ненулевой progress
-- end
-- local required = activityInfo[i].threshold or activityInfo[i].requiredCount or 0
-- local currentProgress = activityInfo[i].progress or 0
-- -- local currentProgress = activityInfo[1].progress or 0 -- общий прогресс для этой категории
-- if required > 0 and currentProgress >= required then
-- local rewards = E.func_GetDetailedItemLevelInfo(E.func_GetExampleRewardItemHyperlinks(activityInfo[i].id))
-- if rewards then
-- tbl.rewards = tbl.rewards or {}
-- tbl.rewards[i] = rewards
-- hasRewards = true
-- -- if ID == 3 then
-- -- tbl.levels = tbl.levels or {}
-- -- tbl.levels[i] = activityInfo[i].level
-- -- end
-- end
-- tbl.activities = tbl.activities or {}
-- tbl.activities[i] = activityInfo[i]
-- else
-- if tbl.rewards then
-- tbl.rewards[i] = nil
-- end
-- end
-- end
-- -- Сохраняем только если есть данные
-- if tbl.min and hasRewards then
-- -- local resetReward = nil
-- collectMASLENGO.GreatVault.NextWeekReward = true
-- collectMASLENGO.GreatVault[ID] = tbl
-- else
-- collectMASLENGO.GreatVault[ID] = nil
-- end
-- end
-- end
-- end
-- ----------------------------------------------------------------
-- collectPlayerData.HasAvailableRewards = E.func_Save(E.func_HasAvailableRewards())
-- collectPlayerData.HasGeneratedRewards = E.func_Save(E.func_HasGeneratedRewards())
-- -- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)
-- end
----------------------------------------------------------------


