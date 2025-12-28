local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_TimePlayed(totalTime, currentLevelTime)
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	collectPlayerData.realTotalTime = totalTime
	collectPlayerData.realLevelTime = currentLevelTime
end
----------------------------------------------------------------
function E.Collect_Character_TimePlayed(totalTime, currentLevelTime)
	local key = (""):join(tostringall(totalTime, currentLevelTime))
	E.func_SpamBlock(Collect_Character_TimePlayed(totalTime, currentLevelTime), false)
end