local GlobalAddonName, E = ...

function E.Collect_All_JournalInstance()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO

	if not collectPlayerData then return end

	local NumSavedInstances = GetNumSavedInstances()
	local NumSavedWorldBosses = GetNumSavedWorldBosses()
	local DiffAbbr = ""
	local instancesLastBoss = {}
	local ServerTime = GetServerTime()
	if NumSavedInstances > 0 then
		for i = 1, NumSavedInstances do
			local instanceName, lockoutId, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, instanceId = GetSavedInstanceInfo(i)
			collectMASLENGO.journalInstance[instanceId] = collectMASLENGO.journalInstance[instanceId] or {}
			collectMASLENGO.journalInstance[instanceId][instanceDifficulty] = collectMASLENGO.journalInstance[instanceId][instanceDifficulty] or {}
			if locked then
				local _, _, lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
				if defeatedBosses == 0 and lastBossDefeated then
					lastBossDefeated = false
				end
				local color = E.Red_Color
				if lastBossDefeated then
					color = E.Yellow_Color
				end
				if defeatedBosses == totalBosses then
					color = E.Green_Color
				end
				if instanceReset and instanceReset > 0 then
					instanceReset = instanceReset + time()
				else
					instanceReset = 0
				end
				if instanceDifficulty == 17 then
					DiffAbbr = "LFR"
				elseif instanceDifficulty == 1 or instanceDifficulty == 14 then
					DiffAbbr = "N"
				elseif instanceDifficulty == 2 or instanceDifficulty == 15 then
					DiffAbbr = "H"
				elseif instanceDifficulty == 23 or instanceDifficulty == 16 then
					DiffAbbr = "M"
				else
					DiffAbbr = "HZ"
				end
				local vivod = color..defeatedBosses.."/"..totalBosses.."|r"
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceName = instanceName
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].vivod = vivod
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceReset = instanceReset
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].difficultyName = difficultyName
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceDifficulty = instanceDifficulty
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].extended = extended
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceIDMostSig = instanceIDMostSig
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].isRaid = isRaid
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].maxPlayers = maxPlayers
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].totalBosses = totalBosses
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].defeatedBosses = defeatedBosses
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].extendDisabled = extendDisabled
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].DiffAbbr = DiffAbbr
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty].Time = E:func_SecondsToClock(instanceReset-ServerTime)
			end
		end
	end
	if NumSavedWorldBosses > 0 then
		for i = 1, NumSavedWorldBosses do
			local name, worldBossID, reset = GetSavedWorldBossInfo(i)
			-- collectMASLENGO.SavedWorldBoss[worldBossID] = collectMASLENGO.SavedWorldBoss[worldBossID] or {}
			collectMASLENGO.SavedWorldBoss[worldBossID] = {}
			collectMASLENGO.SavedWorldBoss[worldBossID].name = name
			collectMASLENGO.SavedWorldBoss[worldBossID].reset = reset
		end
	end
	for i=1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID and E.OctoTable_LFGDungeons[dungeonID] then
			local D_name = GetLFGDungeonInfo(dungeonID)
			local donetoday = GetLFGDungeonRewards(dungeonID)
			collectMASLENGO.LFGInstance[dungeonID].D_name = D_name
			if donetoday == true then
				collectMASLENGO.LFGInstance[dungeonID].donetoday = E.DONE
			else
				collectMASLENGO.LFGInstance[dungeonID].donetoday = nil
			end
		end
	end
end