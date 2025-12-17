local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Locations()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end
	collectPlayerData.curLocation = E.func_GetPlayerLocation()
	local curBindLocation = GetBindLocation()
	if curBindLocation then
		collectPlayerData.BindLocation = curBindLocation
	end
end
----------------------------------------------------------------
function E.Collect_Locations()
	E.func_SpamBlock(Collect_Locations, true)
end