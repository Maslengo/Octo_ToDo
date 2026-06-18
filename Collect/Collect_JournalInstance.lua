local GlobalAddonName, E = ...
local OctoTable_LFGDungeons = {
	[286] = "Повелитель Холода Ахун",
	[287] = "Корен Худовар",
	[285] = "Всадник без головы",
}
----------------------------------------------------------------
local function Collect_JournalInstance()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local ServerTime = E.TIME_SERVER()
	----------------------------------------------------------------
	-- E.DEBUG_START()
	-- local DIFF_ABBR = {
	--     [17] = "LFR",
	--     [1]  = "N", [14] = "N",
	--     [2]  = "H", [15] = "H",
	--     [23] = "M", [16] = "M",
	-- }
	----------------------------------------------------------------
	-- SavedInstances
	----------------------------------------------------------------
	E.cm.journalInstance = {}
	local NumSavedInstances = GetNumSavedInstances()
	if NumSavedInstances > 0 then
		for index = 1, NumSavedInstances do
			local name, _, instanceReset, instanceDifficulty, locked, _, _, _, _, _, totalBosses, defeatedBosses, _, SI_ID = GetSavedInstanceInfo(index)
			if locked then
				E.cm.journalInstance[SI_ID] = E.cm.journalInstance[SI_ID] or {}
				E.cm.journalInstance[SI_ID][instanceDifficulty] = E.cm.journalInstance[SI_ID][instanceDifficulty] or {}
				local ji = E.cm.journalInstance[SI_ID][instanceDifficulty]
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
	E.cm.SavedWorldBoss = {}
	local NumSavedWorldBosses = GetNumSavedWorldBosses()
	if NumSavedWorldBosses > 0 then
		for index = 1, NumSavedWorldBosses do
			local name, worldBossID, reset = GetSavedWorldBossInfo(index)
			E.cm.SavedWorldBoss[worldBossID] = {}
			E.cm.SavedWorldBoss[worldBossID].name = name
			E.cm.SavedWorldBoss[worldBossID].instanceReset = reset > 0 and (reset + ServerTime) or 0 -- deepseek
		end
	end
	----------------------------------------------------------------
	-- RandomDungeons
	----------------------------------------------------------------
	local SecondsUntilDailyReset = E.func_GetSecondsUntilDailyReset()
	E.cm.LFGInstance = {}
	for index = 1, GetNumRandomDungeons() do
		local dungeonID, name, typeID, _, _, _, _, _, _, _, _, textureFilename, difficultyID = GetLFGRandomDungeonInfo(index)
		if OctoTable_LFGDungeons[dungeonID] then
			local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(dungeonID)
			if (isAvailableForPlayer or not hideIfNotJoinable) and isAvailableForAll and GetLFGDungeonRewards(dungeonID) then
				E.cm.LFGInstance[dungeonID] = E.cm.LFGInstance[dungeonID] or {}
				E.cm.LFGInstance[dungeonID].name = name
				E.cm.LFGInstance[dungeonID].typeID = typeID
				E.cm.LFGInstance[dungeonID].textureFilename = textureFilename
				E.cm.LFGInstance[dungeonID].difficultyID = difficultyID
				E.cm.LFGInstance[dungeonID].instanceReset = SecondsUntilDailyReset > 0 and (SecondsUntilDailyReset + ServerTime) or 0 -- deepseek
				E.cm.LFGInstance[dungeonID].reset = SecondsUntilDailyReset
			end
		end
	end
	----------------------------------------------------------------
	-- E.DEBUG_STOP("Collect_JournalInstance")
end
----------------------------------------------------------------
function E.Collect_JournalInstance()
	E.func_SpamBlock(Collect_JournalInstance, false)
end
----------------------------------------------------------------