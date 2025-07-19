local GlobalAddonName, E = ...

function E.Collect_All_Garrison()
	local list = {}
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].GARRISON
	if not collectGARRISON or InCombatLockdown() then return end

	collectGARRISON.cacheSize = C_QuestLog.IsQuestFlaggedCompleted(37485) and 1000 or 500

end




function E.Collect_All_lastCacheTime(rt, rl, q, _4, _5, _6, source)
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].GARRISON
	if not collectGARRISON or InCombatLockdown() then return end

	if rt == "currency" and source == 10 and rl:match("currency:824") then
		collectGARRISON.lastCacheTime = GetServerTime()
	end
end