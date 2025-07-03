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

	return timerText .. (label or "")
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

	return timerText .. str
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

	return timerText .. str
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


local spawns = {
	{mapId = 2112, name="в Вальдракене"},
	{mapId = 84, name="в Штормграде"},
	{mapId = 2022, name="на Берегах Пробуждения"},
	{mapId = 85, name="в Оргриммаре"},
	{mapId = 2023, name="на Равнинах Он'ары"},
	{mapId = 84, name="в Штормграде"},
	{mapId = 2024, name="в Лазурном Просторе"},
	{mapId = 85, name="в Оргриммаре"},
	{mapId = 2025, name="в Тальдразусе"},
	{mapId = 84, name="в Штормграде"},
	{mapId = 2112, name="в Вальдракене"},
	{mapId = 85, name="в Оргриммаре"},
	{mapId = 2022, name="на Берегах Пробуждения"},
	{mapId = 84, name="в Штормграде"},
	{mapId = 2023, name="на Равнинах Он'ары"},
	{mapId = 85, name="в Оргриммаре"},
	{mapId = 2024, name="в Лазурном Просторе"},
	{mapId = 84, name="в Штормграде"},
	{mapId = 2025, name="в Тальдразусе"},
	{mapId = 85, name="в Оргриммаре"}
}

function E.Timers.Treasure_Goblin()
	local offset = 1675076400 -- = time({year=2023,month=1,day=30,hour=12})
	local interval = 1800 -- 30 минут в секундах
	local portal_delay = 1500 -- 25 минут в секундах

	local current_time = time()
	local elapsed = current_time - offset
	local cycle_position = elapsed / interval
	local cycle_remainder = (math.floor(cycle_position) - cycle_position + 1) * interval
	local next_index = (math.ceil(cycle_position) - 1) % #spawns + 1

	local spawn = spawns[next_index]
	local next_location = spawn.name

	local time_until_portal = cycle_remainder
	local time_until_goblin = time_until_portal - portal_delay

	local message, location
	if time_until_portal < portal_delay then
		local s, f = SecondsToTimeAbbrev(time_until_portal)
		-- message = "|cff1abc9cПортал появится через " .. s:format(f)
		location = next_location
	else
		local t, f = SecondsToTimeAbbrev(time_until_goblin)
		-- message = "|cffe74c3cГоблин появится через " .. t:format(f)
		location = spawns[next_index == 1 and #spawns or next_index - 1].name
	end

	local vivod = --[[message .. " " .. ]]next_location .. " -> " .. location
	return CreateTimer(1675076400, 1800, 300, E.Red_Color, E.Green_Color) .. vivod
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
--             vivod = vivod .. E.WOW_Poor_Color..("1)   "..contributionName.." ~ "..SecondsToTime(timeOfNextStateChange - GetServerTime()) ).."|r|n"
--             vivod = vivod .. E.WOW_Common_Color..("2)   "..stateName.." ~ "..date("%m/%d %H:%M", timeOfNextStateChange) ).."|r|n"
--         elseif state == 2 then
--             -- rest time not available
--             local expectTime = 7 * 24 * 60 * 60 -- 7 days
--             vivod = vivod .. E.WOW_Uncommon_Color..("3)   "..contributionName.." ~ ".."100%" ).."|r|n"
--             vivod = vivod .. E.WOW_Rare_Color..("4)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
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
--             vivod = vivod .. E.WOW_Epic_Color..("5)   "..contributionName.." ~ "..format("%.2f%% (%s)", stateAmount * 100, expectTimeText) ).."|r|n"
--             vivod = vivod .. E.WOW_Legendary_Color..("6)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
--         else
--             -- contribute amount not available
--             vivod = vivod .. E.Venthyr_Color..("7)   "..contributionName.." ~ "..stateName ).."|r|n"
--         end
--         print (vivod)
--     end
-- end

