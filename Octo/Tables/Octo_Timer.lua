local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local mod = math.fmod -- (тоже самое что и %)

-- Helper function to create consistent timers
local function CreateTimer(baseTime, interval, duration, colorBefore, colorDuring, label)
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - baseTime, interval)
	local timerText = colorBefore..E.func_SecondsToClock(nextEventIn).."|r "

	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		timerText = colorDuring..E.func_SecondsToClock(nextEventIn).."|r "
	end

	return timerText..(label or "")
end

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
	local timerText = CreateTimer(TIMER[E.regionName], interval, duration, E.Red_Color, E.Green_Color)

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
	local timerText = CreateTimer(TIMER[E.regionName], interval, duration, E.Red_Color, E.Green_Color)

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
	return CreateTimer(1547611200, 86400, 86400, E.Red_Color, E.Green_Color)
end

-- Dragonflight Timers
function E.Timers.DF_ToDragonbaneKeep()
	return CreateTimer(1670342460, 7200, 900, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_GrandHunts()
	return CreateTimer(1671307200, 7200, 7199, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_CommunityFeast()
	return CreateTimer(1677168000, 5400, 900, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_PrimalStorms()
	return CreateTimer(1683804640, 18000, 7200, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_ResearchersUnderFire()
	return CreateTimer(1683804640, 3600, 1500, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_TimeRift()
	return CreateTimer(1689159620, 3600, 600, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_Dreamsurges()
	return CreateTimer(1689159620, 1800, 300, E.Red_Color, E.Green_Color)
end

-- Shadowlands Maw Assault
function E.Timers.SL_Maw_Assault()
	return CreateTimer(3780, 7200, 900, E.Red_Color, E.Green_Color)
end

-- Daily Reset
function E.Timers.Daily_Reset()
	local timerText = CreateTimer(1687579264, 86400, 1, E.Red_Color, E.Green_Color)
	return timerText..E.Gray_Color.."Daily Reset|r"
end

-- 04.07.2025 00ч	0		     	0	1	2346 (TWW шахта)	85   	(ОГРИ)
-- 04.07.2025 01ч	3600			1	2	85   (ОГРИ)     	2248 	(TWW остров)
-- 04.07.2025 02ч	7200			2	3	2248 (TWW остров)	84   	(ШТОРМ)
-- 04.07.2025 03ч	10800			3	4	84   (ШТОРМ)    	2346 	(TWW шахта)


local spawns = {
	{mapId = 2346},  -- TWW шахта (первая локация)
	{mapId = 85},    -- ОГРИ 1:00
	{mapId = 2248},  -- TWW остров
	{mapId = 84},    -- ШТОРМ
}

function E.Timers.Treasure_Goblin()
	if #spawns == 0 then return "Нет точек спауна!" end

	local offset = 1698494400
	local interval = 3600     -- 1 час в секундах
	local delay = 600         -- 10 минут в секундах

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
	local vivod = current_location .. E.Gray_Color .. " -> " .. next_location .. "|r"
	return CreateTimer(offset, interval, delay, E.Red_Color, E.Green_Color) .. vivod
end

function E.Timers.ElementalStorm()
	return CreateTimer(1689166820, 10800, 7200, E.Red_Color, E.Green_Color)
end

function E.Timers.DF_Flower()
	return CreateTimer(1689166820, 3600, 1200, E.Red_Color, E.Green_Color)
end

function E.Timers.TWW_BeledarCycle()
	return CreateTimer(1726311612, 10800, 1800, E.Yellow_Color, E.Purple_Color)
end

-- Removed BfA_Warfront as it had print statements and unclear functionality

-- function E.Timers.BfA_Warfront()
--     -- Arathi Highlands
--     --/dump C_ContributionCollector.GetName(116) -- Alliance
--     --/dump C_ContributionCollector.GetState(116) -- Alliance
--     --/dump C_ContributionCollector.GetName(11) -- Horde
--     --/dump C_ContributionCollector.GetState(11) -- Horde
--     -- Darkshores
--     --/dump C_ContributionCollector.GetName(117) -- Alliance
--     --/dump C_ContributionCollector.GetState(117) -- Alliance
--     --/dump C_ContributionCollector.GetName(118) -- Horde
--     --/dump C_ContributionCollector.GetState(118) -- Horde
--     local warfronts = {
--         -- Arathi Highlands
--         {
--             Alliance = 116,
--             Horde = 11,
--         },
--         -- Darkshores
--         {
--             Alliance = 117,
--             Horde = 118,
--         },
--     }
--     local vivod = ""
--     for _, warfront in ipairs(warfronts) do
--         local contributionID = warfront[E.curFaction]
--         local contributionName = C_ContributionCollector.GetName(contributionID)
--         local state, stateAmount, timeOfNextStateChange = C_ContributionCollector.GetState(contributionID)
--         local stateName = C_ContributionCollector.GetContributionAppearance(contributionID, state or 0).stateName
--         --if state == 4 then
--         --    -- captured
--         --    state, stateAmount, timeOfNextStateChange = C_ContributionCollector.GetState(warfront[E.oppositeFaction])
--         --    stateName = format("%s (%s)", stateName, C_ContributionCollector.GetContributionAppearance(contributionID, state or 0).stateName)
--         --end
--         if state == 2 and timeOfNextStateChange then
--             -- attacking
--             -- rest time available
--             vivod = vivod..E.WOW_Poor_Color..("1)   "..contributionName.." ~ "..SecondsToTime(timeOfNextStateChange - GetServerTime()) ).."|r|n"
--             vivod = vivod..E.WOW_Common_Color..("2)   "..stateName.." ~ "..date("%m/%d %H:%M", timeOfNextStateChange) ).."|r|n"
--         elseif state == 2 then
--             -- rest time not available
--             local expectTime = 7 * 24 * 60 * 60 -- 7 days
--             vivod = vivod..E.WOW_Uncommon_Color..("3)   "..contributionName.." ~ ".."100%" ).."|r|n"
--             vivod = vivod..E.WOW_Rare_Color..("4)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
--         elseif stateAmount then
--             -- contributing
--             -- contribute amount available
--             local expectTime = (1 - stateAmount) * 7 * 24 * 60 * 60 -- 7 days
--             local hour = expectTime / 60 / 60
--             local day = floor(hour / 24)
--             hour = hour - day * 24
--             local expectTimeText
--             if day > 0 then
--                 expectTimeText = format("%d %d", day, hour)
--             else
--                 expectTimeText = format("%d", hour)
--             end
--             vivod = vivod..E.WOW_Epic_Color..("5)   "..contributionName.." ~ "..format("%.2f%% (%s)", stateAmount * 100, expectTimeText) ).."|r|n"
--             vivod = vivod..E.WOW_Legendary_Color..("6)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
--         else
--             -- contribute amount not available
--             vivod = vivod..E.Venthyr_Color..("7)   "..contributionName.." ~ "..stateName ).."|r|n"
--         end
--         print (vivod)
--     end
-- end

