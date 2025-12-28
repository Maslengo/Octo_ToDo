local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Delves()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Delves()
	E.func_SpamBlock(Collect_Delves, true)
end