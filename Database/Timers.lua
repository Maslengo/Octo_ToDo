local GlobalAddonName, E =...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local mod = math.fmod -- (тоже самое что и %)
-- Создаёт строку таймера до следующего события
-- baseTime — базовое время отсчёта (обычно серверное, от которого пляшут все события)
-- interval — интервал повторения события в секундах (например, каждые 3600 сек)
-- duration — длительность активной фазы события
-- label — необязательный текст, который будет добавлен в конец строки
-- Базовое время, Интервал, Длительность
local function CreateTimer(baseTime, interval, duration, label)
	if not baseTime or not interval or interval <= 0 then
		return ""
	end
	local displayTime
	local color
	local now = GetServerTime()
	local elapsed = tonumber(now) - baseTime
	-- Время до следующего начала события
	local timeToNext = interval - mod(elapsed, interval)
	-- Проверяем, активна ли сейчас фаза события
	local isActive = duration and timeToNext > (interval - duration)
	if isActive then
		-- Время до конца активной фазы
		displayTime = timeToNext - (interval - duration)
		color = E.COLOR_GREEN
	else
		-- Время до следующего события
		displayTime = timeToNext
		color = E.COLOR_RED
	end
	displayTime = max(0, displayTime)
	return color..E.func_SecondsToClock(displayTime).."|r "..(label or "")
end
-- baseTime, interval, duration, colorBefore, colorDuring, label)
-- Dragonflight Timers
function E.Timers.BfA_Assault()
	local ZONE_CYCLE = {
		{ mapID = 249, poiID = "ЙЦУЙЦУ", name = "УЛЬДУМ" }, -- Зулдазар
		{ mapID = 390, poiID = "ЙУЦЙУЦ", name = "ДОЛ" }, -- Звук Тирагарда
	}
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
function E.Timers.SL_Maw_TormentorsofTorghast() -- 12.05, 14.05 и так далее это по московскому времени если по серверному времени то по нечётным получается.
	local TIMER = {
		US = 1754917310,
		EU = 1754917310, -- HZ
		CN = 1754917310, -- HZ
	}
	return CreateTimer(TIMER[E.CURRENT_REGION_NAME], 7200, 900)
end
-- Daily Reset
function E.Timers.Daily_Reset()
	local timerText = CreateTimer(1687579264, 86400, 1)
	return timerText..E.COLOR_GRAY.."Daily Reset|r"
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
	local current_location = E.func_GetMapName(spawns[current_index].mapId)
	local next_location = E.func_GetMapName(spawns[next_index].mapId)
	-- Форматированный вывод
	local output = current_location..E.COLOR_GRAY.." -> "..next_location.."|r"
	return CreateTimer(offset, interval, delay)..output
end




function E.Timers.Treasure_GoblinTEST() -- /run print(E.Timers.Treasure_GoblinTEST())
	local SPAWN_CYCLE = {
		{ mapID = 2346 }, -- TWW шахта (первая локация)
		{ mapID = 85 }, -- ОГРИ 1:00
		{ mapID = 2248 }, -- TWW остров
		{ mapID = 84 }, -- ШТОРМ
	}

	-- Базовое время старта цикла
	local BASE_TIME = 1698494400
	local INTERVAL = 3600 -- 1 час в секундах
	local DURATION = 600 -- 10 минут в секундах (длительность появления)
	local now = GetServerTime() -- Исправлено: было time(), теперь GetServerTime()

	------------------------------------------------
	-- 1. Активный спавн -> проверяем, может быть есть API?
	------------------------------------------------
	-- Для гоблинов сокровищ нет POI API, пропускаем эту часть

	------------------------------------------------
	-- 2. Нет активного спавна -> считаем следующий
	------------------------------------------------
	local elapsed = now - BASE_TIME
	if elapsed < 0 then
		return "Ожидание начала цикла..."
	end

	local cyclesCompleted = math.floor(elapsed / INTERVAL)

	-- Следующая локация в ротации
	local nextSpawnIndex = cyclesCompleted % #SPAWN_CYCLE + 1
	local afterNextIndex = nextSpawnIndex % #SPAWN_CYCLE + 1

	-- Время до следующего спавна
	local nextTime = BASE_TIME + (cyclesCompleted + 1) * INTERVAL
	local timeToNext = nextTime - now

	local nextSpawn = SPAWN_CYCLE[nextSpawnIndex]
	local afterNextSpawn = SPAWN_CYCLE[afterNextIndex]

	local nextSpawnName = nextSpawn.name or E.func_GetMapName(nextSpawn.mapID) or "???"
	local afterNextName = afterNextSpawn.name or E.func_GetMapName(afterNextSpawn.mapID) or "???"

	return E.COLOR_RED..E.func_SecondsToClock(timeToNext).."|r "..nextSpawnName..E.COLOR_GRAY.." -> "..afterNextName.."|r"
end






function E.Timers.ElementalStorm()
	return CreateTimer(1689166820, 10800, 7200)
end
function E.Timers.DF_Flower()
	return CreateTimer(1689166820, 3600, 1200)
end
function E.Timers.TWW_BeledarCycle()
	return CreateTimer(1726311612, 10800, 1800, E.COLOR_YELLOW)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.Timers.Legion_Invasion() -- /run print(E.Timers.Legion_Invasion())
	-- Фиксированный цикл зон атаки
	local ZONE_CYCLE = {
		{ mapID = 634, poiID = 5178 }, -- Stormheim
		{ mapID = 630, poiID = 5175 }, -- Azsuna
		{ mapID = 641, poiID = 5210 }, -- Val'sharah
		{ mapID = 650, poiID = 5177 }, -- Highmountain
	}
	-- Подтверждённые старты для регионов
	local BASE_TIME = {
		US = 1762333200, -- Nov 7, 2025, 1:00 AM
		EU = 1762434000 + 66600 + 66600, -- Nov 6, 2025, 12:00 PM
		CN = 1762434000 + 741600,
	}
	local INTERVAL = 66600 -- 18h 30m
	local now = GetServerTime()
	------------------------------------------------
	-- 1. Активная атака -> серверная истина (POI)
	------------------------------------------------
	for index, zone in ipairs(ZONE_CYCLE) do
		local sec = C_AreaPoiInfo.GetAreaPOISecondsLeft(zone.poiID)
		if sec and sec > 0 then
			local currentName = E.func_GetMapName(zone.mapID) or "???"
			local nextIndex = index % #ZONE_CYCLE + 1
			local nextName = E.func_GetMapName(ZONE_CYCLE[nextIndex].mapID) or "???"
			return E.COLOR_GREEN..E.func_SecondsToClock(sec).."|r "..currentName..E.COLOR_GRAY.." -> "..nextName.."|r"
		end
	end
	------------------------------------------------
	-- 2. атаки нет -> считаем следующий старт
	------------------------------------------------
	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
	if not baseTime then
		return E.COLOR_RED.."--:--|r "..L["Legion Invasion"]
	end
	local elapsed = now - baseTime
	local cyclesCompleted = math.floor(elapsed / INTERVAL)
	-- Следующая зона в ротации
	local nextZoneIndex = cyclesCompleted % #ZONE_CYCLE + 1
	local afterNextIndex = nextZoneIndex % #ZONE_CYCLE + 1
	-- Время до следующей атаки
	local nextTime = baseTime + (cyclesCompleted + 1) * INTERVAL
	local nextZoneName = E.func_GetMapName(ZONE_CYCLE[nextZoneIndex].mapID) or "???"
	local afterNextName = E.func_GetMapName(ZONE_CYCLE[afterNextIndex].mapID) or "???"
	return E.COLOR_RED..E.func_SecondsToClock(nextTime - now).."|r "..L["Legion Invasion"]..--[[nextZoneName..]]E.COLOR_GRAY.." -> "..afterNextName.."|r"
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- BfA Invasion
function E.Timers.BfA_Invasion() -- /run print(E.Timers.BfA_Invasion())
	-- Цикл зон атак в ПРАВИЛЬНОМ ПОРЯДКЕ (из расписания) -- https://wow.gameinfo.io/bfa/faction-assault-timer
	local ZONE_CYCLE = {
		{ mapID = 862, poiID = 5973 }, -- Зулдазар
		{ mapID = 895, poiID = 5896 }, -- Звук Тирагарда
		{ mapID = 863, poiID = 5969 }, -- Назмир
		{ mapID = 942, poiID = 5966 }, -- Долина Штормового Шёпота
		{ mapID = 864, poiID = 5970 }, -- Воль'дун
		{ mapID = 896, poiID = 5964 }, -- Друствол
	}
	-- Время старта для регионов (первая атака в Zuldazar)
	local BASE_TIME = {
		["US"] = 1548032400, -- 2019-01-20 17:00 UTC-8 (Первая атака в Зулдазаре)
		["EU"] = 1548000000, -- 2019-01-20 16:00 UTC+0
		["CN"] = 1546743600, -- 2019-01-06 11:00 UTC+8
	}
	local INTERVAL = 68400 -- 19 часов между началом атак
	local DURATION = 25200 -- 7 часов длительность
	local now = GetServerTime()
	------------------------------------------------
	-- 1. Активная атака -> проверяем POI
	------------------------------------------------
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
	------------------------------------------------
	-- 2. Нет активной атаки -> считаем следующую
	------------------------------------------------
	local baseTime = BASE_TIME[E.CURRENT_REGION_NAME]
	if not baseTime then
		return E.COLOR_RED.."--:--|r "..L["Faction Assault"]
	end
	local elapsed = now - baseTime
	local cyclesCompleted = math.floor(elapsed / INTERVAL)
	-- Следующая зона в ротации
	local nextZoneIndex = cyclesCompleted % #ZONE_CYCLE + 1
	local afterNextIndex = nextZoneIndex % #ZONE_CYCLE + 1
	-- Время до следующей атаки
	local nextTime = baseTime + (cyclesCompleted + 1) * INTERVAL
	local timeToNext = nextTime - now
	local nextZone = ZONE_CYCLE[nextZoneIndex]
	local afterNextZone = ZONE_CYCLE[afterNextIndex]
	local nextZoneName = nextZone.name or E.func_GetMapName(nextZone.mapID) or "???"
	local afterNextName = afterNextZone.name or E.func_GetMapName(afterNextZone.mapID) or "???"
	return E.COLOR_RED..E.func_SecondsToClock(timeToNext).."|r "..L["Faction Assault"]..--[[nextZoneName..]]E.COLOR_GRAY.." -> "..afterNextName.."|r"
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------