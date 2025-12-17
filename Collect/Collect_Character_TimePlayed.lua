local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Character_TimePlayed(totalTime, currentLevelTime)
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.realTotalTime = totalTime
	collectPlayerData.realLevelTime = currentLevelTime
end
----------------------------------------------------------------
function E.Collect_Character_TimePlayed(...)
	local key = (""):join(tostringall(...))
	E.func_SpamBlock(Collect_Character_TimePlayed(...), false, ...)
end