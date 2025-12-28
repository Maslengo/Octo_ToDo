local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Locations()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
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