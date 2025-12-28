local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Garrison()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON then return end
	collectGARRISON.cacheSize = C_QuestLog.IsQuestFlaggedCompleted(37485) and 1000 or 500
end
local function Collect_lastCacheTime(...)
	local rt, rl, q, _4, _5, _6, source = ...
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON then return end
	if rt == "currency" and source == 10 and rl:match("currency:824") then
		collectGARRISON.lastCacheTime = GetServerTime()
	end
end
----------------------------------------------------------------
function E.Collect_Garrison()
	E.func_SpamBlock(Collect_Garrison, true)
end
function E.Collect_lastCacheTime(...)
	local key = (""):join(tostringall(...))
	E.func_SpamBlock(Collect_lastCacheTime(...), true, ...)
end