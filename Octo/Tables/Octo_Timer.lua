local GlobalAddonName, E = ... 
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower


function E.Timers.Legion_Invasion()
	local maps = {
		630, -- Azsuna
		641, -- Val'sharah
		650, -- Highmountain
		634, -- Stormheim
	}
	local mapAreaPoiIDs = {
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
	local interval = 66600
	local duration = 21600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER[E.regionName], interval)
	local Timer_Legion_Invasion = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_Legion_Invasion = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	local vivod = L["Legion Invasion"]
	for _, uiMapID in ipairs(maps) do
		local areaPoiID = mapAreaPoiIDs[uiMapID]
		local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
		if seconds and seconds > 0 then
			vivod = C_Map.GetMapInfo(uiMapID).name
			break
		end
	end
	return Timer_Legion_Invasion .. vivod
end
-- InvasionQuests


function E.Timers.BfA_Invasion()
	local maps = {
		862, -- Zuldazar
		863, -- Nazmir
		864, -- Vol'dun
		896, -- Drustvar
		942, -- Stormsong Valley
		895, -- Tiragarde Sound
	}
	local mapAreaPoiIDs = {
		[862] = 5973, -- Zuldazar
		[863] = 5969, -- Nazmir
		[864] = 5970, -- Vol'dun
		[896] = 5964, -- Drustvar
		[942] = 5966, -- Stormsong Valley
		[895] = 5896, -- Tiragarde Sound
	}
	local rotation = {896, 862, 895, 863, 942, 864}
	local TIMER = {
		["US"] = 1548032400, -- 2019-01-20 17:00 UTC-8
		["EU"] = 1548000000, -- 2019-01-20 16:00 UTC+0
		["CN"] = 1546743600, -- 2019-01-06 11:00 UTC+8
	}
	local interval = 68400
	local duration = 25200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER[E.regionName], interval)
	local Timer_BfA_Invasion = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Invasion = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	local vivod = L["Faction Assault"]
	for _, uiMapID in ipairs(maps) do
		local areaPoiID = mapAreaPoiIDs[uiMapID]
		local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
		if seconds and seconds > 0 then
			vivod = C_Map.GetMapInfo(uiMapID).name
			break
		end
	end
	--getRotationName = function(rotationID)
	--    return C_Map_GetMapInfo(rotationID).name
	--end,
	return Timer_BfA_Invasion .. vivod
end


-- AssaultTheBlackEmpire (Нападения Н'Зота - Большой) + (Нападения Н'Зота - Малый)
function E.Timers.BfA_Assault()
	local TIMER = (1547586000+3600+3600+3600+3600+3600+3600+3600)
	local interval = 86400
	local duration = 86400
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Assault = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Assault = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Assault
end


-- BfA_Warfront
function E.Timers.BfA_Warfront()
	-- Arathi Highlands
	--/dump C_ContributionCollector.GetName(116) -- Alliance
	--/dump C_ContributionCollector.GetState(116) -- Alliance
	--/dump C_ContributionCollector.GetName(11) -- Horde
	--/dump C_ContributionCollector.GetState(11) -- Horde
	-- Darkshores
	--/dump C_ContributionCollector.GetName(117) -- Alliance
	--/dump C_ContributionCollector.GetState(117) -- Alliance
	--/dump C_ContributionCollector.GetName(118) -- Horde
	--/dump C_ContributionCollector.GetState(118) -- Horde
	local warfronts = {
		-- Arathi Highlands
		{
			Alliance = 116,
			Horde = 11,
		},
		-- Darkshores
		{
			Alliance = 117,
			Horde = 118,
		},
	}
	local vivod = ""
	for _, warfront in ipairs(warfronts) do
		local contributionID = warfront[E.curFaction]
		local contributionName = C_ContributionCollector.GetName(contributionID)
		local state, stateAmount, timeOfNextStateChange = C_ContributionCollector.GetState(contributionID)
		local stateName = C_ContributionCollector.GetContributionAppearance(contributionID, state or 0).stateName
		--if state == 4 then
		--	-- captured
		--	state, stateAmount, timeOfNextStateChange = C_ContributionCollector.GetState(warfront[E.oppositeFaction])
		--	stateName = format("%s (%s)", stateName, C_ContributionCollector.GetContributionAppearance(contributionID, state or 0).stateName)
		--end
		if state == 2 and timeOfNextStateChange then
			-- attacking
			-- rest time available
			vivod = vivod .. E.WOW_Poor_Color..("1)   "..contributionName.." ~ "..SecondsToTime(timeOfNextStateChange - GetServerTime()) ).."|r|n"
			vivod = vivod .. E.WOW_Common_Color..("2)   "..stateName.." ~ "..date("%m/%d %H:%M", timeOfNextStateChange) ).."|r|n"
		elseif state == 2 then
			-- rest time not available
			local expectTime = 7 * 24 * 60 * 60 -- 7 days
			vivod = vivod .. E.WOW_Uncommon_Color..("3)   "..contributionName.." ~ ".."100%" ).."|r|n"
			vivod = vivod .. E.WOW_Rare_Color..("4)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
		elseif stateAmount then
			-- contributing
			-- contribute amount available
			local expectTime = (1 - stateAmount) * 7 * 24 * 60 * 60 -- 7 days
			local hour = expectTime / 60 / 60
			local day = floor(hour / 24)
			hour = hour - day * 24
			local expectTimeText
			if day > 0 then
				expectTimeText = format("%d %d", day, hour)
			else
				expectTimeText = format("%d", hour)
			end
			vivod = vivod .. E.WOW_Epic_Color..("5)   "..contributionName.." ~ "..format("%.2f%% (%s)", stateAmount * 100, expectTimeText) ).."|r|n"
			vivod = vivod .. E.WOW_Legendary_Color..("6)   "..stateName.." ~ "..date("~ %m/%d %H:00", expectTime + GetServerTime()) ).."|r|n"
		else
			-- contribute amount not available
			vivod = vivod .. E.Venthyr_Color..("7)   "..contributionName.." ~ "..stateName ).."|r|n"
		end
		print (vivod)
	end
end
-- E.Timers.BfA_Warfront()


function E.Timers.DF_ToDragonbaneKeep()
	local TIMER = 1670342460
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ToDragonbaneKeep = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ToDragonbaneKeep = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ToDragonbaneKeep
end


function E.Timers.DF_GrandHunts()
	local TIMER = 1671307200
	local interval = 7200
	local duration = 7199
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_GrandHunts = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_GrandHunts = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_GrandHunts
end


function E.Timers.DF_CommunityFeast()
	local TIMER = 1677168000
	local interval = 5400
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_CommunityFeast = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_CommunityFeast = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_CommunityFeast
end


function E.Timers.DF_PrimalStorms()
	local TIMER = 1683804640
	local interval = 18000
	local duration = 7200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_PrimalStorms = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_PrimalStorms = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_PrimalStorms
end


function E.Timers.DF_ResearchersUnderFire()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ResearchersUnderFire = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ResearchersUnderFire = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ResearchersUnderFire
end


function E.Timers.DF_TimeRift()
	local TIMER = 1689159620
	local interval = (1*60)*60
	local duration = (10*60)
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_TimeRift = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_TimeRift = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_TimeRift
end


function E.Timers.DF_Dreamsurges()
	local TIMER = 1689159620
	local interval = 30*60
	local duration = 5*60
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_Dreamsurges = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_Dreamsurges = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_Dreamsurges
end


function E.Timers.SL_Maw_Assault()
	local TIMER = 3780
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_SL_Maw_Assault = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_SL_Maw_Assault = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_SL_Maw_Assault
end


function E.Timers.Daily_Reset()
	local TIMER = 1687579264
	local interval = 86400
	local duration = 1
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Daily_Reset = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Daily_Reset = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Daily_Reset..E.Gray_Color.."Daily Reset|r"
	else
		return ""
	end
end


function E.Timers.Treasure_Goblin()
	local TIMER = 1685001600
	local interval = 1800
	local duration = 300
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Treasure_Goblin = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Treasure_Goblin = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Treasure_Goblin
	else
		return ""
	end
end


function E.Timers.ElementalStorm()
	local TIMER = 1689166820
	local interval = (3*60)*60
	local duration = (2*60)*60
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_ElementalStorm = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_ElementalStorm = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_ElementalStorm
	else
		return ""
	end
end


function E.Timers.DF_Flower()
	local TIMER = 1689166820
	local interval = (60)*60
	local duration = (20)*60
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_DF_Flower = E.Red_Color..E.func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_DF_Flower = E.Green_Color..E.func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_DF_Flower
	else
		return ""
	end
end


function E.Timers.TWW_BeledarCycle()
	local TIMER = 1726311612
	local interval = (180)*60
	local duration = (30)*60
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_TWW_Beledarr = E.Yellow_Color..E.func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_TWW_Beledarr = E.Purple_Color..E.func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_TWW_Beledarr
	else
		return ""
	end
end
