local GlobalAddonName, E = ...

function E.Collect_All_Locations()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	collectPlayerData.curLocation = E:func_GetCurrentLocation()

	local curBindLocation = GetBindLocation()
	if curBindLocation then
		collectPlayerData.BindLocation = curBindLocation
	end
	----------------------------------------------------------------
	-- local curRealZone = GetRealZoneText()
	-- if curRealZone and curBindLocation then
	-- 	collectPlayerData.BindLocation = curRealZone.." ("..curBindLocation..")"
	-- end
	----------------------------------------------------------------
end