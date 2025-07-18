local GlobalAddonName, E = ...

function E.Collect_All_Locations()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local curRealZone = GetRealZoneText()
		local curBindLocation = GetBindLocation()
		collectPlayerData.curLocation = E:func_GetCurrentLocation()
		if curRealZone and curBindLocation then
			collectPlayerData.BindLocation = curRealZone.." ("..curBindLocation..")"
		end
	end
end