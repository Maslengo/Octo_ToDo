local GlobalAddonName, E = ...


local OctoTable_LFGDungeons = {
	[286] = "Повелитель Холода Ахун",
	[287] = "Корен Худовар",
	[285] = "Всадник без головы",
}


----------------------------------------------------------------
local function Collect_JournalInstance()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local ServerTime = GetServerTime()
	----------------------------------------------------------------
	-- E.DEBUG_START()
	-- local DIFF_ABBR = {
	-- 	[17] = "LFR",
	-- 	[1]  = "N", [14] = "N",
	-- 	[2]  = "H", [15] = "H",
	-- 	[23] = "M", [16] = "M",
	-- }
	----------------------------------------------------------------
	-- SavedInstances
	----------------------------------------------------------------
	collectMASLENGO.journalInstance = {}
	local NumSavedInstances = GetNumSavedInstances()
	if NumSavedInstances > 0 then
		for index = 1, NumSavedInstances do
			local name, _, instanceReset, instanceDifficulty, locked, _, _, _, _, _, totalBosses, defeatedBosses, _, SI_ID = GetSavedInstanceInfo(index)
			if locked then
				local EJ_ID = E.func_SI_to_EJ(SI_ID)
				collectMASLENGO.journalInstance[SI_ID] = collectMASLENGO.journalInstance[SI_ID] or {}
				collectMASLENGO.journalInstance[SI_ID][instanceDifficulty] = collectMASLENGO.journalInstance[SI_ID][instanceDifficulty] or {}
				local ji = collectMASLENGO.journalInstance[SI_ID][instanceDifficulty]
				ji.EJ_ID = EJ_ID
				ji.SI_ID = SI_ID
				-- wipe(ji)
				local lastBossDefeated = select(3, GetSavedInstanceEncounterInfo(index, totalBosses))
				if defeatedBosses == 0 and lastBossDefeated then
					lastBossDefeated = false
				end
				ji.name = name
				ji.instanceReset = instanceReset > 0 and (instanceReset + ServerTime) or 0 -- deepseek
				ji.totalBosses = E.func_Save(totalBosses)
				ji.defeatedBosses = E.func_Save(defeatedBosses)
				ji.lastBossDefeated = E.func_Save(lastBossDefeated)

				-- Bosses собираем только если нужно
				if not ji.Bosses or #ji.Bosses ~= totalBosses then
					ji.Bosses = {}
				end
				for p = 1, totalBosses do
					ji.Bosses[p] = ji.Bosses[p] or {}
					local bossName, _, bossKilled = GetSavedInstanceEncounterInfo(index, p)
					ji.Bosses[p].bossName = bossName
					ji.Bosses[p].bossKilled = E.func_Save(bossKilled)
				end
			end
		end
	end
	----------------------------------------------------------------
	-- WorldBosses
	----------------------------------------------------------------
	collectMASLENGO.SavedWorldBoss = {}
	local NumSavedWorldBosses = GetNumSavedWorldBosses()
	if NumSavedWorldBosses > 0 then
		for index = 1, NumSavedWorldBosses do
			local name, worldBossID, reset = GetSavedWorldBossInfo(index)
			collectMASLENGO.SavedWorldBoss[worldBossID] = {}
			collectMASLENGO.SavedWorldBoss[worldBossID].name = name
			collectMASLENGO.SavedWorldBoss[worldBossID].instanceReset = reset > 0 and (reset + ServerTime) or 0 -- deepseek
		end
	end
	----------------------------------------------------------------
	-- RandomDungeons
	----------------------------------------------------------------
	local SecondsUntilDailyReset = C_DateAndTime.GetSecondsUntilDailyReset()
	collectMASLENGO.LFGInstance = {}
	for index = 1, GetNumRandomDungeons() do
		local dungeonID, name, typeID, _, _, _, _, _, _, _, _, textureFilename, difficultyID = GetLFGRandomDungeonInfo(index)
		if OctoTable_LFGDungeons[dungeonID] then
			local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(dungeonID)
			if (isAvailableForPlayer or not hideIfNotJoinable) and isAvailableForAll and GetLFGDungeonRewards(dungeonID) then
				collectMASLENGO.LFGInstance[dungeonID] = collectMASLENGO.LFGInstance[dungeonID] or {}
				collectMASLENGO.LFGInstance[dungeonID].name = name
				collectMASLENGO.LFGInstance[dungeonID].typeID = typeID
				collectMASLENGO.LFGInstance[dungeonID].textureFilename = textureFilename
				collectMASLENGO.LFGInstance[dungeonID].difficultyID = difficultyID
				collectMASLENGO.LFGInstance[dungeonID].instanceReset = SecondsUntilDailyReset > 0 and (SecondsUntilDailyReset + ServerTime) or 0 -- deepseek
				collectMASLENGO.LFGInstance[dungeonID].reset = SecondsUntilDailyReset
			end
		end
	end
	----------------------------------------------------------------
	-- DEBUG
	----------------------------------------------------------------
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.journalInstance)
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.LFGInstance)
	----------------------------------------------------------------
	-- E.DEBUG_STOP("Collect_JournalInstance")
end
----------------------------------------------------------------
function E.Collect_JournalInstance()
	E.func_SpamBlock(Collect_JournalInstance, false)
end
----------------------------------------------------------------