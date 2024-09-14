
local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
-- local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower


local utf8charbytes = E.Octo_Func.utf8charbytes
local utf8len = E.Octo_Func.utf8len
local utf8sub = E.Octo_Func.utf8sub
local utf8replace = E.Octo_Func.utf8replace
local utf8upper = E.Octo_Func.utf8upper
local utf8lower = E.Octo_Func.utf8lower
local utf8reverse = E.Octo_Func.utf8reverse
----------------------------------------------------------------
function E.Octo_Timer.Legion_Invasion()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_Legion_Invasion".."|r")
	end
	local TIMER = (1547586000-10800)
	local interval = 66600
	local duration = 21600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_Legion_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_Legion_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_Legion_Invasion
end
function E.Octo_Timer.BfA_Invasion()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_BfA_Invasion".."|r")
	end
	local TIMER = (1547586000+3600)
	local interval = 68400
	local duration = 25200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Invasion
end
function E.Octo_Timer.BfA_Assault()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_BfA_Assault".."|r")
	end
	local TIMER = (1547586000+3600+3600+3600+3600+3600+3600+3600)
	local interval = 86400
	local duration = 86400
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Assault
end
function E.Octo_Timer.DF_ToDragonbaneKeep()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_ToDragonbaneKeep".."|r")
	end
	local TIMER = 1670342460
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ToDragonbaneKeep
end
function E.Octo_Timer.DF_GrandHunts()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_GrandHunts".."|r")
	end
	local TIMER = 1671307200
	local interval = 7200
	local duration = 7199
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_GrandHunts = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_GrandHunts = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_GrandHunts
end
function E.Octo_Timer.DF_CommunityFeast()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_CommunityFeast".."|r")
	end
	local TIMER = 1677168000
	local interval = 5400
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_CommunityFeast = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_CommunityFeast = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_CommunityFeast
end
function E.Octo_Timer.DF_PrimalStorms()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_PrimalStorms".."|r")
	end
	local TIMER = 1683804640
	local interval = 18000
	local duration = 7200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_PrimalStorms = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_PrimalStorms = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_PrimalStorms
end
function E.Octo_Timer.DF_ResearchersUnderFire()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_ResearchersUnderFire".."|r")
	end
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ResearchersUnderFire = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ResearchersUnderFire = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ResearchersUnderFire
end
function E.Octo_Timer.DF_TimeRift()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_TimeRift".."|r")
	end
	local TIMER = 1689159620 -- начало в 16:00
	local interval = (1*60)*60 -- каждый час
	local duration = (10*60) -- 10 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_TimeRift = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_TimeRift = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_TimeRift
end
function E.Octo_Timer.DF_Dreamsurges()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_Dreamsurges".."|r")
	end
	local TIMER = 1689159620 -- начало в 16:00
	local interval = 30*60 -- каждые пол часа
	local duration = 5*60 -- 5 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_Dreamsurges = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_Dreamsurges = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_Dreamsurges
end
function E.Octo_Timer.SL_Maw_Assault()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_SL_Maw_Assault".."|r")
	end
	local TIMER = 3780
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_SL_Maw_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_SL_Maw_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_SL_Maw_Assault
end
function E.Octo_Timer.Daily_Reset()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_Daily_Reset".."|r")
	end
	local TIMER = 1687579264
	local interval = 86400
	local duration = 1
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Daily_Reset = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Daily_Reset = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Daily_Reset..E.Octo_Globals.Gray_Color.."Daily Reset|r"
	else
		return " "
	end
end
function E.Octo_Timer.Treasure_Goblin()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_Treasure_Goblin".."|r")
	end
	local TIMER = 1685001600
	local interval = 1800
	local duration = 300
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Treasure_Goblin = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Treasure_Goblin = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Treasure_Goblin
	else
		return " "
	end
end
function E.Octo_Timer.ElementalStorm()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_ElementalStorm".."|r")
	end
	local TIMER = 1689166820
	local interval = (3*60)*60 -- 3 часа
	local duration = (2*60)*60 -- 2 часа
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_ElementalStorm = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_ElementalStorm = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_ElementalStorm
	else
		return " "
	end
end
function E.Octo_Timer.DF_Flower()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_DF_Flower".."|r")
	end
	local TIMER = 1689166820
	local interval = (60)*60 -- каждый час
	local duration = (20)*60 -- 20 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_DF_Flower = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_DF_Flower = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_DF_Flower
	else
		return " "
	end
end


function E.Octo_Timer.TWW_Beledarr()
--questid = 83240
--icon 1355358 or 608954
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Timer_TWW_Beledarr".."|r")
	end
	local TIMER = 1698494405
	local interval = 3600
	local duration = 600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_TWW_Beledarr = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_TWW_Beledarr = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_TWW_Beledarr
	else
		return " "
	end
end



