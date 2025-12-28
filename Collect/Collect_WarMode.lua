local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_WarMode()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	collectPlayerData.WarMode = C_PvP.IsWarModeDesired() or nil
end
----------------------------------------------------------------
function E.Collect_WarMode()
	E.func_SpamBlock(Collect_WarMode, false)
end