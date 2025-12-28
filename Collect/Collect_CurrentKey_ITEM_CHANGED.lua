local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_CurrentKey_ITEM_CHANGED(arg2)
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local dungeonSTR = select(18, strsplit(":", arg2))
	local lvl = select(20, strsplit(":", arg2))
	local dungeonID = tonumber(dungeonSTR)
	local KeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
	collectPlayerData.CurrentKeyLevel = tonumber(lvl)
	collectPlayerData.CurrentKeyName = KeyName
	if E.OctoTable_KeystoneAbbr[dungeonID] then
		collectPlayerData.CurrentKey = lvl.." "..E.OctoTable_KeystoneAbbr[dungeonID].abbreviation
	else
		collectPlayerData.CurrentKey = lvl.." "..KeyName
	end
end
----------------------------------------------------------------
function E.Collect_CurrentKey_ITEM_CHANGED(arg2)
	E.func_SpamBlock(Collect_CurrentKey_ITEM_CHANGED(arg2), false, arg2)
end