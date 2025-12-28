local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Legion_Remix()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	collectMASLENGO.LegionRemixData = collectMASLENGO.LegionRemixData or {}
	----------------------------------------------------------------
	local info = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(7330)
	if info then
		for key, value in pairs(info) do
			collectMASLENGO.LegionRemixData[key] = value
		end
	end
	----------------------------------------------------------------
	local count = 0
	for questID in next, (E.OctoTable_RemixInfinityResearch) do
		if C_QuestLog.IsOnQuest(questID) then
			count = count + 1
		end
	end
	collectMASLENGO.LegionRemixData.TotalInfinityResearchQuests = count > 0 and count or nil
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Legion_Remix()
	E.func_SpamBlock(Collect_Legion_Remix, true)
end