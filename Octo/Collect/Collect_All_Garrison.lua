local GlobalAddonName, E = ...

function E.Collect_All_Garrison()

	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON then return end

	collectGARRISON.cacheSize = C_QuestLog.IsQuestFlaggedCompleted(37485) and 1000 or 500

end




function E.Collect_All_lastCacheTime(rt, rl, q, _4, _5, _6, source)
	local collectGARRISON = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.GARRISON
	if not collectGARRISON or InCombatLockdown() then return end

	if rt == "currency" and source == 10 and rl:match("currency:824") then
		collectGARRISON.lastCacheTime = GetServerTime()
	end

end





-- Blizzard_GarrisonBuildingUI.lua

-- 2	Type_6_0_Garrison	Warlords of Draenor
-- 3	Type_7_0_Garrison	Legion
-- 9	Type_8_0_Garrison	Battle for Azeroth
-- 111	Type_9_0_Garrison	Shadowlands

-- C_Garrison.GetLandingPageGarrisonType() = 111
-- C_Garrison.GetBuildingSizes()
-- looseShipments = C_Garrison.GetLooseShipments(garrisonType)
-- hasAdventures = C_Garrison.HasAdventures() ???????




function E.Collect_All_GarrisonBuilds()
	local collect = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collect or InCombatLockdown() then return end

	local HasShipyard = HasShipyard or C_Garrison.HasShipyard
	local HasGarrison = HasGarrison or C_Garrison.HasGarrison  --MASLENGO.HasGarrison[id]
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
			collect.garrisonType[id][i].level = E:func_buildLevel(data.buildingID)
		end
	end
end