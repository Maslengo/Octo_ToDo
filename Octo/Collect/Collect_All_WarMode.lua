local GlobalAddonName, E = ...


function E.Collect_All_WarMode()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		local WarMode = C_PvP.IsWarModeDesired()
		if WarMode then
			collectPlayerData.WarMode = WarMode
		else
			collectPlayerData.WarMode = nil
		end
	end
end