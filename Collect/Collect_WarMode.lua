local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_WarMode()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.WarMode = C_PvP.IsWarModeDesired() or nil
end
----------------------------------------------------------------
function E.Collect_WarMode()
	E.func_SpamBlock(Collect_WarMode, false)
end