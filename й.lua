function Collect_All_journalInstance()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	----------------------------------------------------------------
	if ((GetNumSavedInstances() + GetNumSavedWorldBosses() > 0) and not RaidInfoFrame:IsVisible()) then
		ToggleRaidFrame()
		RaidInfoFrame:Show()
	end
	if (not RaidFrame:IsVisible()) then
		ToggleRaidFrame()
	end
	if RaidFrame:IsVisible() then
		HideUIPanel(RaidFrame)
	end
	if FriendsFrame:IsVisible() then
		HideUIPanel(FriendsFrame)
	end
	if RaidInfoFrame:IsVisible() then
		HideUIPanel(RaidInfoFrame)
	end
	----------------------------------------------------------------
	local DiffAbbr = " "
	local vivod = " "
	local instancesLastBoss = {}
	for _, v in pairs(E.Octo_Table.OctoTable_journalInstanceID) do
		local name = EJ_GetInstanceInfo(v)
		--collect.journalInstance[v] = {}
		-- collect.journalInstance[v].name = name
		local numsaved = GetNumSavedInstances()
		if numsaved > 0 then
			for i = 1, numsaved do
				local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, mapID = GetSavedInstanceInfo(i)
				if locked then
						local _, _, lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
						if defeatedBosses == 0 and lastBossDefeated then
							lastBossDefeated = false
						end
						if instanceDifficulty == 17 then
							DiffAbbr = "LFR"
						elseif instanceDifficulty == 1 or instanceDifficulty == 14 then
							DiffAbbr = "N"
						elseif instanceDifficulty == 2 or instanceDifficulty == 15 then
							DiffAbbr = "H"
						elseif instanceDifficulty == 23 or instanceDifficulty == 16 then
							DiffAbbr = "M"
						end
						--vivod = defeatedBosses.."/"..totalBosses
						vivod = defeatedBosses.."/"..totalBosses
						if name == instanceName then
							print (vivod)
							-- print (instanceName.." "..DiffAbbr..format("%s%d/%d",totalBosses==defeatedBosses and E.Octo_Globals.Green_Color or lastBossDefeated and E.Octo_Globals.Yellow_Color or E.Octo_Globals.Red_Color,defeatedBosses,totalBosses))
							collect.journalInstance[v].vivod = DiffAbbr..format("%s%d/%d",totalBosses==defeatedBosses and E.Octo_Globals.Green_Color or lastBossDefeated and E.Octo_Globals.Yellow_Color or E.Octo_Globals.Red_Color,defeatedBosses,totalBosses)
							--collect.journalInstance[v].vivod = DiffAbbr..vivod
						end
				end
			end -- for do
			--collect.journalInstance[v][instanceDifficulty] = DiffAbbr.." "..defeatedBosses.."/"..totalBosses
		end
	end -- for table
end -- for function