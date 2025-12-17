local GlobalAddonName, E =...
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local function CreateTimer(baseTime, interval, duration, label)
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
	return CreateTimer(1547611200, 86400, 86400)
end
function E.Timers.DF_ToDragonbaneKeep()
	return CreateTimer(1670342460, 7200, 900)
end
function E.Timers.DF_GrandHunts()
	return CreateTimer(1671307200, 7200, 7199)
end
function E.Timers.DF_CommunityFeast()
	return CreateTimer(1677168000, 5400, 900)
end
function E.Timers.DF_PrimalStorms()
	return CreateTimer(1683804640, 18000, 7200)
end
function E.Timers.DF_ResearchersUnderFire()
	return CreateTimer(1683804640, 3600, 1500)
end
function E.Timers.DF_TimeRift()
	return CreateTimer(1689159620, 3600, 600)
end
function E.Timers.DF_Dreamsurges()
	return CreateTimer(1689159620, 1800, 300)
end
function E.Timers.SL_Maw_Assault()
	return CreateTimer(3780, 7200, 900)
end
function E.Timers.SL_Maw_TormentorsofTorghast()
	local TIMER = {
		US = 1754917310,
		EU = 1754917310,
		CN = 1754917310,
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 7200, 900)
end
function E.Timers.Daily_Reset()
	local timerText = CreateTimer(1687579264, 86400, 1)
	return timerText..E.COLOR_GRAY.."Daily Reset|r"
end
function E.Timers.Treasure_Goblin()
	return CreateTimer(1689159620, 3600, 300)
end
local spawns = {
	{mapId = 2346},
	{mapId = 85},
	{mapId = 2248},
	{mapId = 84},
}
function E.Timers.ElementalStorm()
	return CreateTimer(1689166820, 10800, 7200)
end
function E.Timers.DF_Flower()
	return CreateTimer(1689166820, 3600, 1200)
end
function E.Timers.TWW_BeledarCycle()
	return CreateTimer(1726311612, 10800, 1800, E.COLOR_YELLOW)
end
function E.Timers.Legion_Invasion()
	local ZONE_CYCLE = {
		{ mapID = 634, poiID = 5178 },
		{ mapID = 630, poiID = 5175 },
		{ mapID = 641, poiID = 5210 },
		{ mapID = 650, poiID = 5177 },
	}
	local BASE_TIME = {
		US = 1762333200,
		EU = 1762333200,
		CN = 1762434000 + 741600,
	}
	local INTERVAL = 66600
	local now = GetServerTime()
	for index, zone in ipairs(ZONE_CYCLE) do
		local sec = C_AreaPoiInfo.GetAreaPOISecondsLeft(zone.poiID)
		if sec and sec > 0 then
			local currentName = E.func_GetMapName(zone.mapID) or "???"
			local nextIndex = index % #ZONE_CYCLE + 1
			local nextName = E.func_GetMapName(ZONE_CYCLE[nextIndex].mapID) or "???"
			return E.COLOR_GREEN..E.func_SecondsToClock(sec).."|r "..currentName..E.COLOR_GRAY.." -> "..nextName.."|r"
		end
	end
	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
	if not baseTime then
		return E.COLOR_RED.."--:--|r "..L["Legion Invasion"]
	end
	local elapsed = now - baseTime
	local cyclesCompleted = math.floor(elapsed / INTERVAL)
	local nextZoneIndex = cyclesCompleted % #ZONE_CYCLE + 1
	local afterNextIndex = nextZoneIndex % #ZONE_CYCLE + 1
	local nextTime = baseTime + (cyclesCompleted + 1) * INTERVAL
	local nextZoneName = E.func_GetMapName(ZONE_CYCLE[nextZoneIndex].mapID) or "???"
	local afterNextName = E.func_GetMapName(ZONE_CYCLE[afterNextIndex].mapID) or "???"
	return E.COLOR_RED..E.func_SecondsToClock(nextTime - now).."|r "..L["Legion Invasion"]..E.COLOR_GRAY.." -> "..afterNextName.."|r"
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
			local currentName = E.func_GetMapName(zone.mapID) or "???"
			local nextIndex = index % #ZONE_CYCLE + 1
			local nextZone = ZONE_CYCLE[nextIndex]
			local nextName = E.func_GetMapName(nextZone.mapID) or "???"
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
	local nextZoneName = nextZone.name or E.func_GetMapName(nextZone.mapID) or "???"
	local afterNextName = afterNextZone.name or E.func_GetMapName(afterNextZone.mapID) or "???"
	return E.COLOR_RED..E.func_SecondsToClock(timeToNext).."|r "..L["Faction Assault"]..E.COLOR_GRAY.." -> "..afterNextName.."|r"
end