local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Played(totalTime, currentLevelTime)
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.realTotalTime = totalTime
	collectPlayerData.realLevelTime = currentLevelTime
end
----------------------------------------------------------------
function E.Collect_All_Played(...)
	local key = (""):join(tostringall(...))
	E.func_SpamBlock(Collect_All_Played(...), false, ...)
end