local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local mod = math.fmod -- (тоже самое что и %)
-- Helper function to create consistent timers

	-- Базовое время, Интервал, Длительность
local function CreateTimer(baseTime, interval, duration, label)
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - baseTime, interval)
	local timerText = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		timerText = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return timerText..(label or "")
end

E.Timers = {}
-- Legion Invasion
function E.Timers.Legion_Invasion()
	local maps = {
		[630] = 5175, -- Azsuna
		[641] = 5210, -- Val'sharah
		[650] = 5177, -- Highmountain
		[634] = 5178, -- Stormheim
	}
	local TIMER = {
		["US"] = 1547575200-28800,
		["EU"] = 1547575200,
		["CN"] = 1547575200+741600,
	}
	local interval, duration = 66600, 21600
	local timerText = CreateTimer(TIMER[E.regionName], interval, duration)
	local str = L["Legion Invasion"]
	for uiMapID, areaPoiID in pairs(maps) do
		local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
		if seconds and seconds > 0 then
			str = C_Map.GetMapInfo(uiMapID).name
			break
		end
	end
	return timerText..str
end
-- BfA Invasion
function E.Timers.BfA_Invasion()
	local maps = {
		[862] = 5973, -- Zuldazar
		[863] = 5969, -- Nazmir
		[864] = 5970, -- Vol'dun
		[896] = 5964, -- Drustvar
		[942] = 5966, -- Stormsong Valley
		[895] = 5896, -- Tiragarde Sound
	}
	local TIMER = {
		["US"] = 1548032400, -- 2019-01-20 17:00 UTC-8
		["EU"] = 1548000000, -- 2019-01-20 16:00 UTC+0
		["CN"] = 1546743600, -- 2019-01-06 11:00 UTC+8
	}
	local interval, duration = 68400, 25200
	local timerText = CreateTimer(TIMER[E.regionName], interval, duration)
	local str = L["Faction Assault"]
	for uiMapID, areaPoiID in pairs(maps) do
		local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
		if seconds and seconds > 0 then
			str = C_Map.GetMapInfo(uiMapID).name
			break
		end
	end
	return timerText..str
end
-- baseTime, interval, duration, colorBefore, colorDuring, label)
-- Dragonflight Timers
function E.Timers.BfA_Assault()
	return CreateTimer(1547611200, 86400, 86400)
end
-- Dragonflight Timers
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
-- Shadowlands Maw: Assault
function E.Timers.SL_Maw_Assault()
	return CreateTimer(3780, 7200, 900)
end
-- Shadowlands Maw: Tormentors of Torghast
function E.Timers.SL_Maw_TormentorsofTorghast() --  12.05, 14.05 и так далее это по московскому времени если по серверному времени то по нечётным получается.

	local TIMER = {
		US = 1754917310,
		EU = 1754917310, -- HZ
		CN = 1754917310, -- HZ
	}
	return CreateTimer(TIMER[E.regionName], 7200, 900)
end

-- Daily Reset
function E.Timers.Daily_Reset()
	local timerText = CreateTimer(1687579264, 86400, 1)
	return timerText..E.Gray_Color.."Daily Reset|r"
end
function E.Timers.Treasure_Goblin()
	return CreateTimer(1689159620, 3600, 300)
end
-- 04.07.2025 00ч0 012346 (TWW шахта)85 (ОГРИ)
-- 04.07.2025 01ч36001285 (ОГРИ) 2248 (TWW остров)
-- 04.07.2025 02ч7200232248 (TWW остров)84 (ШТОРМ)
-- 04.07.2025 03ч108003484 (ШТОРМ)2346 (TWW шахта)
local spawns = {
	{mapId = 2346},-- TWW шахта (первая локация)
	{mapId = 85},-- ОГРИ 1:00
	{mapId = 2248},-- TWW остров
	{mapId = 84},-- ШТОРМ
}
function E.Timers.Treasure_GoblinOLD()
	if #spawns == 0 then return "Нет точек спауна!" end
	local offset = 1698494400
	local interval = 3600 -- 1 час в секундах
	local delay = 600 -- 10 минут в секундах
	local current_time = time()
	local elapsed = current_time - offset
	if elapsed < 0 then return "Ожидание начала цикла..." end
	-- Текущая и следующая локации
	local cycle_position = math.floor(elapsed / interval)
	local current_index = cycle_position % #spawns + 1
	local next_index = current_index % #spawns + 1
	local current_location = E.func_mapName(spawns[current_index].mapId)
	local next_location = E.func_mapName(spawns[next_index].mapId)
	-- Форматированный вывод
	local vivod = current_location .. E.Gray_Color .. " -> " .. next_location .. "|r"
	return CreateTimer(offset, interval, delay) .. vivod
end
function E.Timers.ElementalStorm()
	return CreateTimer(1689166820, 10800, 7200)
end
function E.Timers.DF_Flower()
	return CreateTimer(1689166820, 3600, 1200)
end
function E.Timers.TWW_BeledarCycle()
	return CreateTimer(1726311612, 10800, 1800, E.Yellow_Color, E.Purple_Color)
end