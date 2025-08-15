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
function E.Collect_All_GarrisonBuilds()
	if E.func_SpamBlock("Collect_All_GarrisonBuilds") then return end
	local collect = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collect then return end
	local HasShipyard = HasShipyard or C_Garrison.HasShipyard
	local HasGarrison = HasGarrison or C_Garrison.HasGarrison
	wipe(collect.garrisonType)
	for garrisonType, id in next, (Enum.GarrisonType) do
		collect.HasGarrison[id] = HasGarrison(id)
		for i, data in ipairs(C_Garrison.GetBuildings(id)) do
			collect.garrisonType[id] = collect.garrisonType[id] or {}
			collect.garrisonType[id][i] = collect.garrisonType[id][i] or {}
			collect.garrisonType[id][i].buildingID = data.buildingID
			collect.garrisonType[id][i].plotID = data.plotID
			collect.garrisonType[id][i].textureKit = data.textureKit
			collect.garrisonType[id][i].uiTab = data.uiTab
			collect.garrisonType[id][i].rank = E.func_buildRank(data.buildingID)
		end
	end
end
function E.Collect_All_GarrisonFollowers()
	if E.func_SpamBlock("Collect_All_GarrisonFollowers") then return end
	local collect = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collect then return end
	wipe(collect.GarrisonFollowers)
	for _, followerData in ipairs(E.OctoTable_followerTypeIDs) do
		collect.GarrisonFollowers[followerData.name] = collect.GarrisonFollowers[followerData.name] or {}
		collect.GarrisonFollowers[followerData.name] = C_Garrison.GetFollowers(followerData.id)
		collect.GarrisonFollowersCount[followerData.name].maxFollowers = C_Garrison.GetFollowerSoftCap(followerData.id)
		collect.GarrisonFollowersCount[followerData.name].numActiveFollowers = C_Garrison.GetNumActiveFollowers(followerData.id) or 0
	end
end