local GlobalAddonName, E = ...

function E.Collect_All_PlayerLevel()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local UnitLevel = UnitLevel("PLAYER") or 0
		local currentXP = UnitXP("PLAYER") or 0
		local UnitXPMax = UnitXPMax("PLAYER") or 0
		local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
		collectPlayerData.UnitLevel = UnitLevel
		collectPlayerData.currentXP = currentXP
		collectPlayerData.UnitXPMax = UnitXPMax
		collectPlayerData.UnitXPPercent = UnitXPPercent
		if UnitLevel == E.currentMaxLevel then
			collectPlayerData.PlayerCanEarnExperience = nil
		else
			if E.GameLimitedMode_IsActive == true then
				if UnitLevel >= E.GetRestrictedAccountData_rLevel then
					-- if MainStatusTrackingBarContainer and MainStatusTrackingBarContainer:IsShown() then
					-- tinsert(E.OctoTable_MustBeHiddenFrames_table, {name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer})
					-- end
					collectPlayerData.levelCapped20 = true
					collectPlayerData.PlayerCanEarnExperience = nil
				else
					collectPlayerData.levelCapped20 = nil
					collectPlayerData.PlayerCanEarnExperience = true
				end
			end
		end
	end
end