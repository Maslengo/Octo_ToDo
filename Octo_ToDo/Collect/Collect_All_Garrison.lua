local GlobalAddonName, E = ...
function E.Collect_All_Garrison()
	if E.func_SpamBlock("Collect_All_Garrison") then return end
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON then return end
	collectGARRISON.cacheSize = C_QuestLog.IsQuestFlaggedCompleted(37485) and 1000 or 500
end
function E.Collect_All_lastCacheTime(rt, rl, q, _4, _5, _6, source)
	if E.func_SpamBlock("Collect_All_lastCacheTime") then return end
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON then return end
	if rt == "currency" and source == 10 and rl:match("currency:824") then
		collectGARRISON.lastCacheTime = GetServerTime()
	end
end