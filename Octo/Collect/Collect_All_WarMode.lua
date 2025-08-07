local GlobalAddonName, E = ...
----------------------------------------------------------------
function E.Collect_All_WarMode()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	collectPlayerData.WarMode = C_PvP.IsWarModeDesired() or nil
end