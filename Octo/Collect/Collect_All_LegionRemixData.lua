local GlobalAddonName, E = ...
function E.Collect_All_LegionRemixData()
	if E.func_SpamBlock("Collect_All_LegionRemixData", false) then return end
	----------------------------------------------------------------
	local collect = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collect then return end
	----------------------------------------------------------------
	collect.LegionRemixData = collect.LegionRemixData or {}
	----------------------------------------------------------------
	local info = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(7330)
	if info then
		for key, value in pairs(info) do
			collect.LegionRemixData[key] = value
		end
	end
	----------------------------------------------------------------
	local count = 0
	for _, questID in next,(E.OctoTable_RemixInfinityResearch) do
		if C_QuestLog.IsOnQuest(questID) then
			count = count + 1
		end
	end
	collect.LegionRemixData.TotalInfinityResearchQuests = count > 0 and count or nil
	----------------------------------------------------------------
end