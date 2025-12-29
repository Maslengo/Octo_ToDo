local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_JournalInstance()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
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
	local ServerTime = GetServerTime()
	if NumSavedInstances > 0 then
		for i = 1, NumSavedInstances do
			local instanceName, _, instanceReset, instanceDifficulty, locked, _, _, _, _, _, totalBosses, defeatedBosses, _, instanceId = GetSavedInstanceInfo(i)
			collectMASLENGO.journalInstance[instanceId] = collectMASLENGO.journalInstance[instanceId] or {}
			collectMASLENGO.journalInstance[instanceId][instanceDifficulty] = collectMASLENGO.journalInstance[instanceId][instanceDifficulty] or {}
			local ji = collectMASLENGO.journalInstance[instanceId][instanceDifficulty]
			if locked then
				-- wipe(ji)
				local lastBossDefeated = select(3, GetSavedInstanceEncounterInfo(i, totalBosses))
				if defeatedBosses == 0 and lastBossDefeated then
					lastBossDefeated = false
				end
				ji.instanceName = instanceName
				ji.instanceReset = instanceReset > 0 and (instanceReset + ServerTime) or 0 -- deepseek
				-- ji.instanceReset = instanceReset + ServerTime -- RESET -> ServerTime-w.instanceReset
				ji.totalBosses = totalBosses
				ji.defeatedBosses = defeatedBosses
				ji.lastBossDefeated = lastBossDefeated
				ji.EJ_ID = E.func_SI_to_EJ(instanceId)


				-- Bosses собираем только если нужно
				if not ji.Bosses or #ji.Bosses ~= totalBosses then
					ji.Bosses = {}
				end
				for p = 1, totalBosses do
					ji.Bosses[p] = ji.Bosses[p] or {}
					local bossName, _, bossKilled = GetSavedInstanceEncounterInfo(i, p)
					ji.Bosses[p].bossName = bossName
					ji.Bosses[p].bossKilled = bossKilled
				end
			end
		end
	end
	----------------------------------------------------------------
	-- WorldBosses
	----------------------------------------------------------------
	collectMASLENGO.SavedWorldBoss = collectMASLENGO.SavedWorldBoss or {}
	local NumSavedWorldBosses = GetNumSavedWorldBosses()
	if NumSavedWorldBosses > 0 then
		for i = 1, NumSavedWorldBosses do
			local name, worldBossID, reset = GetSavedWorldBossInfo(i)
			collectMASLENGO.SavedWorldBoss[worldBossID] = {}
			collectMASLENGO.SavedWorldBoss[worldBossID].name = name
			collectMASLENGO.SavedWorldBoss[worldBossID].reset = reset
		end
	end
	----------------------------------------------------------------
	-- RandomDungeons
	----------------------------------------------------------------
	collectMASLENGO.LFGInstance = collectMASLENGO.LFGInstance or {}
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID and E.OctoTable_LFGDungeons[dungeonID] then
			local donetoday = GetLFGDungeonRewards(dungeonID)
			collectMASLENGO.LFGInstance[dungeonID] = collectMASLENGO.LFGInstance[dungeonID] or {}
			collectMASLENGO.LFGInstance[dungeonID].D_name = name -- local D_name = GetLFGDungeonInfo(dungeonID)
			if donetoday == true then
				collectMASLENGO.LFGInstance[dungeonID].donetoday = E.DONE
			else
				collectMASLENGO.LFGInstance[dungeonID].donetoday = nil
			end
		end
	end
	----------------------------------------------------------------
	-- DEBUG
	----------------------------------------------------------------
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.journalInstance)
	----------------------------------------------------------------
	-- E.DEBUG_STOP("Collect_JournalInstance")
end
----------------------------------------------------------------
function E.Collect_JournalInstance()
	E.func_SpamBlock(Collect_JournalInstance, true)
end
----------------------------------------------------------------