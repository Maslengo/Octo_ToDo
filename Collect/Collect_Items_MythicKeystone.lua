local GlobalAddonName, E = ...
----------------------------------------------------------------
-- local GetCurrentAffixes = GetCurrentAffixes or C_MythicPlus.GetCurrentAffixes
-- local GetCurrentSeason = GetCurrentSeason or C_MythicPlus.GetCurrentSeason
-- local GetCurrentSeasonValues = GetCurrentSeasonValues or C_MythicPlus.GetCurrentSeasonValues
-- local GetCurrentUIDisplaySeason = GetCurrentUIDisplaySeason or C_MythicPlus.GetCurrentUIDisplaySeason
-- local GetEndOfRunGearSequenceLevel = GetEndOfRunGearSequenceLevel or C_MythicPlus.GetEndOfRunGearSequenceLevel
-- local GetLastWeeklyBestInformation = GetLastWeeklyBestInformation or C_MythicPlus.GetLastWeeklyBestInformation
local GetOwnedKeystoneChallengeMapID = GetOwnedKeystoneChallengeMapID or C_MythicPlus.GetOwnedKeystoneChallengeMapID
local GetOwnedKeystoneLevel = GetOwnedKeystoneLevel or C_MythicPlus.GetOwnedKeystoneLevel
-- local GetOwnedKeystoneMapID = GetOwnedKeystoneMapID or C_MythicPlus.GetOwnedKeystoneMapID
-- local GetRewardLevelForDifficultyLevel = GetRewardLevelForDifficultyLevel or C_MythicPlus.GetRewardLevelForDifficultyLevel
-- local GetRewardLevelFromKeystoneLevel = GetRewardLevelFromKeystoneLevel or C_MythicPlus.GetRewardLevelFromKeystoneLevel
-- local GetRunHistory = GetRunHistory or C_MythicPlus.GetRunHistory
-- local GetSeasonBestAffixScoreInfoForMap = GetSeasonBestAffixScoreInfoForMap or C_MythicPlus.GetSeasonBestAffixScoreInfoForMap
-- local GetSeasonBestForMap = GetSeasonBestForMap or C_MythicPlus.GetSeasonBestForMap
-- local GetSeasonBestMythicRatingFromThisExpansion = GetSeasonBestMythicRatingFromThisExpansion or C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion
-- local GetWeeklyBestForMap = GetWeeklyBestForMap or C_MythicPlus.GetWeeklyBestForMap
-- local GetWeeklyChestRewardLevel = GetWeeklyChestRewardLevel or C_MythicPlus.GetWeeklyChestRewardLevel
local IsMythicPlusActive = IsMythicPlusActive or C_MythicPlus.IsMythicPlusActive
-- local RequestCurrentAffixes = RequestCurrentAffixes or C_MythicPlus.RequestCurrentAffixes
-- local RequestMapInfo = RequestMapInfo or C_MythicPlus.RequestMapInfo
-- local RequestRewards = RequestRewards or C_MythicPlus.RequestRewards
----------------------------------------------------------------
local function Collect_Items_MythicKeystone()
	if not E:func_CanCollectData() then return end
	local isMythicPlusActive = IsMythicPlusActive()
	if not isMythicPlusActive then return end
	-- local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local OwnedKeystoneLevel = GetOwnedKeystoneLevel() -- 20
	local OwnedKeystoneChallengeMapID = GetOwnedKeystoneChallengeMapID() -- 542
	collectPlayerData.OwnedKeystoneLevel = E.func_Save(OwnedKeystoneLevel)
	collectPlayerData.OwnedKeystoneChallengeMapID = E.func_Save(OwnedKeystoneChallengeMapID)

	-- 180653 НОВЫЙ КЛЮЧ
	-- 138019 СТАРЫЕ КЛЮЧИ
	-- 158923 СТАРЫЕ КЛЮЧИ
	-- 151086 СТАРЫЕ КЛЮЧИ

	-- local affixIDs = GetCurrentAffixes()
	-- local seasonID1 = GetCurrentSeason() -- 15
	-- local displaySeasonID, milestoneSeasonID, rewardSeasonID = GetCurrentSeasonValues() -- 15, 102, 108
	-- local seasonID2 = GetCurrentUIDisplaySeason() -- 3
	-- local sequenceLevel = GetEndOfRunGearSequenceLevel(20) -- keystoneLevel
	-- local challengeMapId, level = GetLastWeeklyBestInformation()
	-- local weeklyRewardLevel, endOfRunRewardLevel = GetRewardLevelForDifficultyLevel(20) -- difficultyLevel 707, 0
	-- local rewardLevel = GetRewardLevelFromKeystoneLevel(20) -- keystoneLevel
	-- local runs = C_MythicPlus.GetRunHistory([includePreviousWeeks, includeIncompleteRuns])
	-- local OwnedKeystoneMapID = GetOwnedKeystoneMapID() -- 2830
	-- collectPlayerData.OwnedKeystoneMapID = OwnedKeystoneMapID
end
----------------------------------------------------------------
function E.Collect_Items_MythicKeystone()
	E.func_SpamBlock(Collect_Items_MythicKeystone, false)
end
----------------------------------------------------------------