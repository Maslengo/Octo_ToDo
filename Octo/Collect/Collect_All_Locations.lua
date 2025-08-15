local GlobalAddonName, E = ...
function E.Collect_All_Locations()
	if E.func_SpamBlock("Collect_All_Locations", false) then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.curLocation = E.func_GetCurrentLocation()
	local curBindLocation = GetBindLocation()
	if curBindLocation then
		collectPlayerData.BindLocation = curBindLocation
	end
end