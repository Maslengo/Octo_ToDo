local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_Level()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	local UnitLevel = UnitLevel("PLAYER")
	if UnitLevel then
		local currentXP = UnitXP("PLAYER")
		local UnitXPMax = UnitXPMax("PLAYER")
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
----------------------------------------------------------------
function E.Collect_Character_Level()
	E.func_SpamBlock(Collect_Character_Level, false)
end