local GlobalAddonName, E = ...
function E.Collect_All_LegionRemixData()
	if E.func_SpamBlock("Collect_All_LegionRemixData", false) then return end
	local collect = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collect then return end
	collect.LegionRemixData = collect.LegionRemixData or {}
	collect.LegionRemixData.TotalInfinityResearchQuests = nil
	----------------------------------------------------------------
	local info = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(7330)
	if not info then return end
	collect.LegionRemixData = info
	----------------------------------------------------------------
	local count = 0
	for _, questID in next,(E.OctoTable_RemixInfinityResearch) do
		if C_QuestLog.IsOnQuest(questID) then
			count = count + 1
		end
	end
    -- Сохраняем только если есть активные квесты
    collect.LegionRemixData.TotalInfinityResearchQuests = count > 0 and count or nil
	----------------------------------------------------------------
end