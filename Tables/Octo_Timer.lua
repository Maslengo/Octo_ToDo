local GlobalAddonName, E = ...
local LibOctopussy = LibStub("LibOctopussy-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
function E.Timers.Legion_Invasion()
	local TIMER = (1547586000-10800)
	local interval = 66600
	local duration = 21600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_Legion_Invasion = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_Legion_Invasion = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_Legion_Invasion
end
function E.Timers.BfA_Invasion()
	local TIMER = (1547586000+3600)
	local interval = 68400
	local duration = 25200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Invasion = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Invasion = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Invasion
end
function E.Timers.BfA_Assault()
	local TIMER = (1547586000+3600+3600+3600+3600+3600+3600+3600)
	local interval = 86400
	local duration = 86400
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Assault = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Assault = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Assault
end
function E.Timers.DF_ToDragonbaneKeep()
	local TIMER = 1670342460
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ToDragonbaneKeep = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ToDragonbaneKeep = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ToDragonbaneKeep
end
function E.Timers.DF_GrandHunts()
	local TIMER = 1671307200
	local interval = 7200
	local duration = 7199
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_GrandHunts = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_GrandHunts = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_GrandHunts
end
function E.Timers.DF_CommunityFeast()
	local TIMER = 1677168000
	local interval = 5400
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_CommunityFeast = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_CommunityFeast = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_CommunityFeast
end
function E.Timers.DF_PrimalStorms()
	local TIMER = 1683804640
	local interval = 18000
	local duration = 7200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_PrimalStorms = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_PrimalStorms = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_PrimalStorms
end
function E.Timers.DF_ResearchersUnderFire()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ResearchersUnderFire = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ResearchersUnderFire = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ResearchersUnderFire
end
function E.Timers.DF_TimeRift()
	local TIMER = 1689159620
	local interval = (1*60)*60
	local duration = (10*60)
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_TimeRift = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_TimeRift = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_TimeRift
end
function E.Timers.DF_Dreamsurges()
	local TIMER = 1689159620
	local interval = 30*60
	local duration = 5*60
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_Dreamsurges = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_Dreamsurges = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_Dreamsurges
end
function E.Timers.SL_Maw_Assault()
	local TIMER = 3780
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_SL_Maw_Assault = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_SL_Maw_Assault = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
	end
	return Timer_SL_Maw_Assault
end
function E.Timers.Daily_Reset()
	local TIMER = 1687579264
	local interval = 86400
	local duration = 1
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Daily_Reset = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Daily_Reset = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
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
		local Timer_Treasure_Goblin = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Treasure_Goblin = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
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
		local Timer_ElementalStorm = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_ElementalStorm = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
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
		local Timer_DF_Flower = E.Red_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_DF_Flower = E.Green_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
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
		local Timer_TWW_Beledarr = E.Yellow_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_TWW_Beledarr = E.Purple_Color..LibOctopussy:func_SecondsToClock(nextEventIn).."|r "
		end
		return Timer_TWW_Beledarr
	else
		return ""
	end
end
