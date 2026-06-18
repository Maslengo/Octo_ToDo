local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_Level()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local UnitLevel = UnitLevel("PLAYER")
	if UnitLevel then
		local currentXP = UnitXP("PLAYER")
		local UnitXPMax = UnitXPMax("PLAYER")
		local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
		E.pd.UnitLevel = UnitLevel
		E.pd.currentXP = currentXP
		E.pd.UnitXPMax = UnitXPMax
		E.pd.UnitXPPercent = UnitXPPercent
		if UnitLevel == E.currentMaxLevel then
			E.pd.PlayerCanEarnExperience = nil
		else
			if E.GameLimitedMode_IsActive then
				if UnitLevel >= E.GetRestrictedAccountData_rLevel then
					E.pd.levelCapped20 = true
					E.pd.PlayerCanEarnExperience = nil
				else
					E.pd.levelCapped20 = nil
					E.pd.PlayerCanEarnExperience = true
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_Character_Level()
	E.func_SpamBlock(Collect_Character_Level, false)
end
----------------------------------------------------------------