local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_TimePlayed(totalTime, currentLevelTime)
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	E.pd.realTotalTime = totalTime
	E.pd.realLevelTime = currentLevelTime
end
----------------------------------------------------------------
function E.Collect_Character_TimePlayed(totalTime, currentLevelTime)
	local key = (""):join(tostringall(totalTime, currentLevelTime))
	E.func_SpamBlock(Collect_Character_TimePlayed(totalTime, currentLevelTime), false)
end
----------------------------------------------------------------