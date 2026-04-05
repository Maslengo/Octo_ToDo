local GlobalAddonName, E = ...
----------------------------------------------------------------
local L = E.L
local HOUR = 3600 -- 60*60
local ADDITIONAL_TIME = HOUR*5.5
----------------------------------------------------------------
local function CreateTimer(baseTime, interval, duration, label)
	-- if E.CURRENT_REGION_NAME ~= "EU" then return "" end
	if not baseTime or not interval or interval <= 0 then
		return ""
	end
	local displayTime
	local color
	local now = GetServerTime()
	local elapsed = tonumber(now) - baseTime
	local timeToNext = interval - math.fmod(elapsed, interval)
	local isActive = duration and timeToNext > (interval - duration)
	if isActive then
		displayTime = timeToNext - (interval - duration)
		color = E.COLOR_GREEN
	else
		displayTime = timeToNext
		color = E.COLOR_RED
	end
	displayTime = max(0, displayTime)
	return color..E.func_SecondsToClock(displayTime).."|r "..(label or "")
end
function E.Timers.BfA_Assault()
	local TIMER = {
		US = 1547611200+ADDITIONAL_TIME,
		EU = 1547611200,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 86400, 86400)
end
function E.Timers.DF_ToDragonbaneKeep()
	local TIMER = {
		US = 1670342460+ADDITIONAL_TIME,
		EU = 1670342460,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 7200, 900)
end
function E.Timers.DF_GrandHunts()
	local TIMER = {
		US = 1671307200+ADDITIONAL_TIME,
		EU = 1671307200,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 7200, 7199)
end
function E.Timers.DF_CommunityFeast()
	local TIMER = {
		US = 1677168000+ADDITIONAL_TIME,
		EU = 1677168000,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 5400, 900)
end
function E.Timers.DF_PrimalStorms()
	local TIMER = {
		US = 1683804640+ADDITIONAL_TIME,
		EU = 1683804640,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 18000, 7200)
end
function E.Timers.DF_ResearchersUnderFire()
	local TIMER = {
		US = 1683804640+ADDITIONAL_TIME,
		EU = 1683804640,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 3600, 1500)
end
function E.Timers.DF_TimeRift()
	local TIMER = {
		US = 1689159620+ADDITIONAL_TIME,
		EU = 1689159620,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 3600, 600)
end
function E.Timers.DF_Dreamsurges()
	local TIMER = {
		US = 1689159620+ADDITIONAL_TIME,
		EU = 1689159620,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 1800, 300)
end
function E.Timers.SL_Maw_Assault()
	return CreateTimer(3780, 7200, 900)
end
function E.Timers.SL_Maw_TormentorsofTorghast()
	local TIMER = {
		US = 1754917310+ADDITIONAL_TIME,
		EU = 1754917310,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 7200, 900)
end
function E.Timers.Treasure_Goblin()
	local TIMER = {
		US = 1689159620+ADDITIONAL_TIME,
		EU = 1689159620,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 3600, 300)
end
function E.Timers.ElementalStorm()
	local TIMER = {
		US = 1689166820+ADDITIONAL_TIME,
		EU = 1689166820,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 10800, 7200)
end
function E.Timers.DF_Flower()
	local TIMER = {
		US = 1689166820+ADDITIONAL_TIME,
		EU = 1689166820,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 3600, 1200)
end
function E.Timers.TWW_BeledarCycle()
	local TIMER = {
		US = 1726311612+ADDITIONAL_TIME,
		EU = 1726311612,
		-- CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 10800, 1800, E.COLOR_YELLOW)
end
-- function E.Timers.Legion_Invasion()
-- 	local ZONE_CYCLE = {
-- 		{ mapID = 634, poiID = 5178 },
-- 		{ mapID = 630, poiID = 5175 },
-- 		{ mapID = 641, poiID = 5210 },
-- 		{ mapID = 650, poiID = 5177 },
-- 	}
-- 	local BASE_TIME = {
-- 		US = 1762333200,
-- 		EU = 1762333200,
-- 		CN = 1762434000 + 741600,
-- 	}
-- 	local INTERVAL = 66600
-- 	local now = GetServerTime()
-- 	for index, zone in ipairs(ZONE_CYCLE) do
-- 		local sec = C_AreaPoiInfo.GetAreaPOISecondsLeft(zone.poiID)
-- 		if sec and sec > 0 then
-- 			local currentName = E.func_GetName("map", zone.mapID) or "???"
-- 			local nextIndex = index % #ZONE_CYCLE + 1
-- 			local nextName = E.func_GetName("map", ZONE_CYCLE[nextIndex].mapID) or "???"
-- 			return E.COLOR_GREEN..E.func_SecondsToClock(sec).."|r "..currentName..E.COLOR_GRAY.." -> "..nextName.."|r"
-- 		end
-- 	end
-- 	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
-- 	if not baseTime then
-- 		return E.COLOR_RED.."--:--|r "..L["Legion Invasion"]
-- 	end
-- 	local elapsed = now - baseTime
-- 	local cyclesCompleted = math.floor(elapsed / INTERVAL)
-- 	local nextZoneIndex = cyclesCompleted % #ZONE_CYCLE + 1
-- 	local afterNextIndex = nextZoneIndex % #ZONE_CYCLE + 1
-- 	local nextTime = baseTime + (cyclesCompleted + 1) * INTERVAL
-- 	local nextZoneName = E.func_GetName("map", ZONE_CYCLE[nextZoneIndex].mapID) or "???"
-- 	local afterNextName = E.func_GetName("map", ZONE_CYCLE[afterNextIndex].mapID) or "???"
-- 	return E.COLOR_RED..E.func_SecondsToClock(nextTime - now).."|r "..L["Legion Invasion"]..E.COLOR_GRAY.." -> "..afterNextName.."|r"
-- end
function E.Timers.Legion_Invasion()
	local ZONE_DATA = {
		{ mapID = 650, poiID = 5177 },
		{ mapID = 634, poiID = 5178 },
		{ mapID = 641, poiID = 5210 },
		{ mapID = 630, poiID = 5175 },
	}
	local BASE_TIME = {
		EU = 1762434000,
		US = 1762333200,
		CN = 1762434000 + 741600,
	}
	local INVASION_INTERVAL = (14 * 3600) + (30 * 60) -- 66600
	for i = 1, #ZONE_DATA do
		local sec = C_AreaPoiInfo.GetAreaPOISecondsLeft(ZONE_DATA[i].poiID)
		if sec then
			local zoneName = E.func_GetName("map", ZONE_DATA[i].mapID)
			return E.COLOR_GREEN..E.func_SecondsToClock(sec).."|r "..zoneName
		end
	end
	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
	if not baseTime then return end
	local now = time() --GetServerTime()
	while baseTime <= now do
		baseTime = baseTime + INVASION_INTERVAL
	end
	local nextIn = baseTime - now
	-- local elapsed = now - baseTime
	-- local cyclesCompleted = math.floor(elapsed / INTERVAL)
	-- local nextInvasionTime = baseTime + (cyclesCompleted + 1) * INTERVAL
	-- local timeToNext = nextInvasionTime - now
	return E.COLOR_RED..E.func_SecondsToClock(nextIn).."|r "..L["Legion Invasion"]
end
function E.Timers.BfA_Invasion()
	local ZONE_CYCLE = {
		{ mapID = 862, poiID = 5973 },
		{ mapID = 895, poiID = 5896 },
		{ mapID = 863, poiID = 5969 },
		{ mapID = 942, poiID = 5966 },
		{ mapID = 864, poiID = 5970 },
		{ mapID = 896, poiID = 5964 },
	}
	local BASE_TIME = {
		["US"] = 1548032400,
		["EU"] = 1548000000,
		["CN"] = 1546743600,
	}
	local INTERVAL = 68400
	local DURATION = 25200
	local now = GetServerTime()
	for index, zone in ipairs(ZONE_CYCLE) do
		local sec = C_AreaPoiInfo.GetAreaPOISecondsLeft(zone.poiID)
		if sec and sec > 0 and sec <= DURATION then
			local currentName = E.func_GetName("map", zone.mapID) or "???"
			local nextIndex = index % #ZONE_CYCLE + 1
			local nextZone = ZONE_CYCLE[nextIndex]
			local nextName = E.func_GetName("map", nextZone.mapID) or "???"
			return E.COLOR_GREEN..E.func_SecondsToClock(sec).."|r "..currentName..E.COLOR_GRAY.." -> "..nextName.."|r"
		end
	end
	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
	if not baseTime then
		return E.COLOR_RED.."--:--|r "..L["Faction Assault"]
	end
	local elapsed = now - baseTime
	local cyclesCompleted = math.floor(elapsed / INTERVAL)
	local nextZoneIndex = cyclesCompleted % #ZONE_CYCLE + 1
	local afterNextIndex = nextZoneIndex % #ZONE_CYCLE + 1
	local nextTime = baseTime + (cyclesCompleted + 1) * INTERVAL
	local timeToNext = nextTime - now
	local nextZone = ZONE_CYCLE[nextZoneIndex]
	local afterNextZone = ZONE_CYCLE[afterNextIndex]
	local nextZoneName = nextZone.name or E.func_GetName("map", nextZone.mapID) or "???"
	local afterNextName = afterNextZone.name or E.func_GetName("map", afterNextZone.mapID) or "???"
	return E.COLOR_RED..E.func_SecondsToClock(timeToNext).."|r "..L["Faction Assault"]..E.COLOR_GRAY.." -> "..afterNextName.."|r"
end