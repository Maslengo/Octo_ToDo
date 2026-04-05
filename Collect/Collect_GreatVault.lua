local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
E.Enum_Activities_table = {}
E.GW_Start = true
----------------------------------------------------------------
local GetMapTable = GetMapTable or C_ChallengeMode.GetMapTable
local GetWeeklyChestRewardLevel = GetWeeklyChestRewardLevel or C_MythicPlus.GetWeeklyChestRewardLevel
local GetWeeklyBestForMap = GetWeeklyBestForMap or C_MythicPlus.GetWeeklyBestForMap
local HasAvailableRewards = HasAvailableRewards or C_WeeklyRewards.HasAvailableRewards
local HasGeneratedRewards = HasGeneratedRewards or C_WeeklyRewards.HasGeneratedRewards
local GetCurrentSeason = GetCurrentSeason or C_MythicPlus.GetCurrentSeason
local GetRunHistory = GetRunHistory or C_MythicPlus.GetRunHistory
local GetActivities = GetActivities or C_WeeklyRewards.GetActivities
local GetNumCompletedDungeonRuns = GetNumCompletedDungeonRuns or C_WeeklyRewards.GetNumCompletedDungeonRuns
local affixIDs = C_MythicPlus.GetCurrentAffixes() -- tbl
local challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
local seasonID = C_MythicPlus.GetCurrentUIDisplaySeason()
local challengeMapId, level = C_MythicPlus.GetLastWeeklyBestInformation()


local OnUIInteract = OnUIInteract or C_WeeklyRewards.OnUIInteract
local RequestRewards = RequestRewards or C_MythicPlus.RequestRewards
local RequestMapInfo = RequestMapInfo or C_MythicPlus.RequestMapInfo
local GetEndOfRunGearSequenceLevel = GetEndOfRunGearSequenceLevel or C_MythicPlus.GetEndOfRunGearSequenceLevel




-- local sequenceLevel = GetEndOfRunGearSequenceLevel(keystoneLevel)


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
local CurrentSeason = GetCurrentSeason() or 1
if CurrentSeason == nil or CurrentSeason == false or CurrentSeason == 0 or CurrentSeason == -1 then
	E.MythicPlus_seasonID = 1
else
	E.MythicPlus_seasonID = CurrentSeason
end




local function Collect_GreatVault()
	if E.GW_Start then
		-- /run C_AddOns.LoadAddOn("Blizzard_WeeklyRewards"); WeeklyRewardsFrame:Show()
		for name, ID in next, (Enum.WeeklyRewardChestThresholdType) do
			local activities = GetActivities(ID)
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
	----------------------------------------------------------------
	-- local numHeroic, numMythic, numMythicPlus = GetNumCompletedDungeonRuns()
	----------------------------------------------------------------
	OnUIInteract()
	RequestRewards()
	RequestMapInfo()

	local mapChallengeModeIDs = GetMapTable()
	local currentWeekBestLevel = GetWeeklyChestRewardLevel()
	for i = 1, #mapChallengeModeIDs do
		local _, level = GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	local overallScore = C_ChallengeMode.GetOverallDungeonScore()
	----------------------------------------------------------------
	collectMASLENGO.GreatVault = collectMASLENGO.GreatVault or {}
	wipe(collectMASLENGO.GreatVault)
	----------------------------------------------------------------
	collectMASLENGO.RunHistory = collectMASLENGO.RunHistory or {}
	wipe(collectMASLENGO.RunHistory)
	local RunHistory = GetRunHistory(false, true)
	-- /run opde(C_MythicPlus.GetRunHistory(true, true))
	collectMASLENGO.RunHistory = RunHistory
	-- opde(collectMASLENGO.RunHistory)
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
			-- /dump GetActivities(6) 1 3 6
			local activityInfo = GetActivities(ID)
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
				for i = 1, #activityInfo do
					local rewards = E.func_GetItemLevelDetails(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo[i].id))
					if rewards then
						tbl.rewards = tbl.rewards or {}
						tbl.rewards[i] = rewards
						hasRewards = true
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
	collectPlayerData.HasAvailableRewards = E.func_Save(HasAvailableRewards())
	collectPlayerData.HasGeneratedRewards = E.func_Save(HasGeneratedRewards())

	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)
end
----------------------------------------------------------------
function E.Collect_GreatVault()
	E.func_SpamBlock(Collect_GreatVault, true, 5)
end
----------------------------------------------------------------
-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GreatVault)