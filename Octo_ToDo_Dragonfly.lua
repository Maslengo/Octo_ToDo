local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
-- суббота 23:00
--E.modules = {}
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local Button = nil
local CF = nil
local Char_Frame = nil
local EventFrame = nil
local Main_Frame = nil
local UPGRADERANKS_Frame = nil
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
--local curWidth = Octo_ToDo_DragonflyVars.config.Addon_curWidth*scale or 100*scale
--print (Octo_ToDo_DragonflyVars.config.Addon_curWidth)
local curWidth = 96*scale
local curHeight = 20*scale -- высота 20 24
local curWidthTitle = curWidth*2
local curFontTTF, curFontSize, curFontOutline = [[Interface\Addons\]]..GlobalAddonName..[[\Media\font\01 Octo.TTF]], 11, "OUTLINE"
local TotalLines = 18
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalMoney = 0
local TotalMoneyAllServer = 0
local TotalKills = 0
local curMoney = 0
local thursdayReset = (1514358000-10800) --https://wowreset.com/ 14-3=11(ТСК) --thursdayResetDay0EU
local thursdayResetDay0US = 1514300400
local daytime = 86400 -- 60 * 60 * 24 --60 сек на 60 мин на 24 ч
local NONE = "" --ColorGray..NONE.."|r"
local AddonColor = "|cff00FF00"
local DONE = AddonColor.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8 --0.1, 0.1, 0.1, 1
local edgeFile = [[Interface\Buttons\WHITE8X8]]
local bgFile = [[Interface\Buttons\WHITE8X8]]
local IconTexture = [[Interface\Addons\]]..GlobalAddonName..[[\Media\AddonTexture.tga]]
local ColorGray = "|cff404040"
local PlayCustomSound = false
local NFae_Color = "|cffb4a7d6"
local Vent_Color = "|cffea9999"
local Necr_Color = "|cff93c47d"
local Kyri_Color = "|cff6fa8dc"
local AnimaColor = "|cff00A3FF"
-- OptionsFrame.image = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalGlobalAddonName.."\\media\\OptionLogo2"):Point("TOPLEFT", 15, 5):Size(140, 140)
-- OptionsFrame_title = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalGlobalAddonName.."\\media\\logoname2"):Point("LEFT", OptionsFrame.image, "RIGHT", 15, -5):Size(512*0.7, 128*0.7)
local bytetoB64 = {
	[0]="a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")"
}
function GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
local function func_questName(questID)
	local title = C_QuestLog.GetTitleForQuestID(questID) or ""
	return title
end
local function func_reputationName(factionID)
	local name, _, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = GetFactionInfoByID(factionID)
	local color = "|cffFFFFFF"
	local r = "|r"
	if factionID == 1168 then color = "|cff909090" end
	return color..name..r
end
local function func_itemName(itemID)
	local itemName, _, itemQuality = GetItemInfo(itemID)
	local name = ""
	if itemQuality then
		local r, g, b = GetItemQualityColor(itemQuality)
		local color = CreateColor(r, g, b, 1)
		local name = color:WrapTextInColorCode(itemName)
		return name
	end
	return name
end
local function func_itemName_NOCOLOR(itemID)
	local itemName, _, itemQuality = GetItemInfo(itemID)
	return itemName
end
local function func_itemTexture(itemID)
	local itemTexture = select(10, GetItemInfo(itemID)) or 134400 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	if itemTexture then
		return "|T"..itemTexture..":16:16:::64:64:4:60:4:60|t"
	end
	return "|T134400:16:16:::64:64:4:60:4:60|t"
end
local function func_currencyName(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		name = info.name
		iconFileID = info.iconFileID
		quality = info.quality
	end
	local r, g, b = GetItemQualityColor(quality)
	local color = CreateColor(r, g, b, 1)
	local currencyName = color:WrapTextInColorCode(name)
	return currencyName
end
local function func_currencyicon(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		iconFileID = info.iconFileID or 134400 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	end
	return "|T"..iconFileID..":16:16:::64:64:4:60:4:60|t"
end
local function func_currencyquantity(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		quantity = info.quantity or 0 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	end
	return quantity
end
local function func_spellName(spellID)
	local name = GetSpellInfo(spellID)
	return name
end
local function Central_Frame_Mouse_OnEnter(self)
	local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	-----------------------------------
	if not self.tooltip then return end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -10)
	GameTooltip:AddLine(" ")
	for _, v in pairs(self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(self)
	local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	-----------------------------------
	GameTooltip:Hide()
end
local function SecondsToClock(seconds)
	local seconds = tonumber(seconds)
	if seconds <= 0 or seconds == nil then
		return "0:00"
	elseif seconds >= 3600 then
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		return hours.."h "..mins.."m"
	elseif seconds >= 600 then
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		return mins.."m"
	else
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%01.f", math.floor(seconds/60 - (hours*60)))
		return mins.."m"
	end
end
local spawns = {
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 85, name="(Оргриммар)"},
}
local spawns2 = {
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2025, name="(Тальдразус)"},
}
-- function TreasureGoblinTimer()
-- 	local offset = 1675076400+9 -- = time({year=2023,month=1,day=30,hour=12})
-- 	local interval = 30*60
-- 	local interval2 = 1500
-- 	local uptime = GetTime()
-- 	if (last or 0) < uptime - 1 then
-- 		last = uptime
-- 		local n = #spawns
-- 		local current = (time() - offset) / interval
-- 		local remainder = (math.floor(current) - current + 1) * interval
-- 		local nextIndex = (math.ceil(current) - 1) % n + 1
-- 		local found = true
-- 		local spawnId, distance
-- 		for i = 0,n-1 do
-- 			spawnId = (nextIndex + i - 1) % n + 1
-- 			distance = i
-- 			break
-- 		end
-- 		if found then
-- 			local spawn = spawns[spawnId]
-- 			local spawnprev = spawns2[spawnId]
-- 			nextSpawn = spawn
-- 			nextLocation = spawn.name
-- 			prevLocation = spawnprev.name
-- 			local when = remainder + distance * interval
-- 			local timeleft = when - interval2
-- 			if when < interval2 then
-- 				nextTime = "|cffFF0000"..SecondsToClock(when).."|r"
-- 				-- local s, f = SecondsToTimeAbbrev(when)
-- 				-- nextTime = s:format(f)
-- 			else
-- 				nextTime = "|cff00FF00"..SecondsToClock(timeleft).."|r"
-- 				if PlayCustomSound == true then
-- 					PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\Gnome Woo.ogg", "Master")
-- 				end
-- 				-- local t, f = SecondsToTimeAbbrev(timeleft)
-- 				-- nextTime = t:format(f)
-- 				nextLocation = prevLocation
-- 			end
-- 		else
-- 			nextSpawn = nil
-- 			nextLocation = ""
-- 			prevLocation = ""
-- 			nextTime = ""
-- 		end
-- 	end
-- 	local TreasureGoblinTimer = nextTime.. " ".. nextLocation
-- 	return TreasureGoblinTimer
-- end
function ToDragonbaneKeepTimer() -- Драконья экспедиция
	-- local timePattern = "%02d:%02d"
	local TIMER = 1670342460 -- ToDragonbaneKeepTimer
	local interval = 7200
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ToDragonbaneKeepTimer = "|cffFF0000"..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ToDragonbaneKeepTimer = AddonColor..SecondsToClock(nextEventIn) .."|r "
	end
	return ToDragonbaneKeepTimer .. " " .. L["Siege on Dragonbane Keep"]
end
function GrandHuntsTimer() -- Кентавры Маруук
	-- local timePattern = "%02d:%02d"
	local TIMER = 1671307200-- 1675612800 -- GrandHuntsTimer
	local interval = 7200-- 270000
	local duration = 7199-- 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local GrandHuntsTimer = "|cffFF0000"..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		GrandHuntsTimer = AddonColor..SecondsToClock(nextEventIn) .."|r "
	end
	return GrandHuntsTimer .. " " .. L["Grand Hunt"]
end
function CommunityFeastTimer() -- Искарские клыкарры
	-- local timePattern = "%02d:%02d"
	local TIMER = 1677168000-- 1670331660 -- CommunityFeastTimer
	local interval = 5400
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local CommunityFeastTimer = "|cffFF0000"..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		CommunityFeastTimer = AddonColor..SecondsToClock(nextEventIn) .."|r "
	end
	return CommunityFeastTimer .. " " .. L["Community Feast"]
end
function PrimalStormsTimer() -- Праймал шторм
	-- local timePattern = "%02d:%02d"
	local TIMER = 1683804640-- 1671303600-- PrimalStormsTimer
	local interval = 18000-- 10800
	local duration = 7200
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local PrimalStormsTimer = "|cffFF0000"..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		PrimalStormsTimer = AddonColor..SecondsToClock(nextEventIn) .."|r "
	end
	return PrimalStormsTimer .." ".. L["The Storm's Fury"]
end
function ResearchersUnderFireTimer()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ResearchersUnderFireTimer = "|cffFF0000"..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ResearchersUnderFireTimer = AddonColor..SecondsToClock(nextEventIn) .."|r "
	end
	return ResearchersUnderFireTimer .." ".. L["Researchers Under Fire"]
end
-- local function GetNPCIDFromGUID(guid)
-- if guid then
-- local unit_type, _, _, _, _, mob_id = strsplit("-", guid)
-- if unit_type == "Pet" or unit_type == "Player" then
-- return 0
-- end
-- return (guid and mob_id and tonumber(mob_id)) or 0
-- end
-- return 0
-- end
-- function CollectKillCount()
-- local UnitLevel = UnitLevel("PLAYER")
-- local curGUID = UnitGUID("PLAYER")
-- local collect = Octo_ToDo_DragonflyLevels[curGUID]
-- --------------------------------------------------
-- local timestamp, eventType, hideCaster, srcGuid, srcName, srcFlags, srcRaidFlags, dstGuid, dstName, dstFlags, dstRaidFlags, spellId, spellName, spellSchool, auraType = CombatLogGetCurrentEventInfo()
-- local bit_band = _G.bit.band
-- -- local strlower = _G.strlower
-- -- local format = _G.format
-- local npcIDs_table = {
-- 205490, -- Алчный Гоблин
-- 195305,
-- 195304,
-- }
-- local KillCount = 0
-- local npcid = GetNPCIDFromGUID(dstGuid)
-- if bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) or bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) or bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) then
-- for _,v in pairs(npcIDs_table) do
-- if v == npcid then
-- print ("|cFF00A3FF"..dstName.. "|r " .. AddonColor..collect.KillCount[npcid].. " (+1)|r")
-- collect.KillCount[npcid] = collect.KillCount[npcid] + 1
-- end
-- end
-- end
-- end
--LoadAddOn("Blizzard_PVPUI")
local SpellIDTable = {
	--Рыбалка
	366253, -- Рыбная ловля дракьньих осттавов
	--Полёты
	33388,
	33391,
	34090,
	90265,
}
function CollectKnownSpell()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	--366253
	for k,v in ipairs(SpellIDTable) do
		local isKnown = IsSpellKnown(v)
		collect.KnownSpell[v] = isKnown
	end
end
function CollectVoidStorage()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local VOID_STORAGE_MAX = 80
	local VOID_STORAGE_PAGES = 2
	--Page 1
	for i = 1, VOID_STORAGE_MAX do
		local itemID, textureName, locked, recentDeposit, isFiltered, quality = GetVoidItemInfo(1, i)
		collect.VOID_STORAGE_PAGE1[i] = itemID or 0
	end
	--Page 2
	for i = 1, VOID_STORAGE_MAX do
		local itemID, textureName, locked, recentDeposit, isFiltered, quality = GetVoidItemInfo(2, i)
		collect.VOID_STORAGE_PAGE2[i] = itemID or 0
	end
end
function CollectLoginTime()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local xyi = date("%d.%m.%Y %H:%M:%S")
	collect.pizdaDate = date("%d.%m.%Y")
	collect.pizdaHours = date("%H:%M")
	collect.needReset = false
end
function CollectCovenantAnima()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local CovenantNames ={
		[1] = "Kyrian",
		[2] = "Venthyr",
		[3] = "NightFae",
		[4] = "Necrolord",
	}
	local curCovID = C_Covenants.GetActiveCovenantID()
	local curCovName = CovenantNames[curCovID]
	local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
	local curAnimaAmount = currencyInfo.quantity
	if curCovID == 0 then return end
	if curCovID == 1 then
		collect.Shadowland[1] = curCovLevel or 0 --Kyrian.Renown
		collect.Shadowland[2] = curAnimaAmount or 0 --Kyrian.Anima
	elseif curCovID == 2 then
		collect.Shadowland[3] = curCovLevel or 0 --Venthyr.Renown
		collect.Shadowland[4] = curAnimaAmount or 0 --Venthyr.Anima
	elseif curCovID == 3 then
		collect.Shadowland[5] = curCovLevel or 0 --NightFae.Renown
		collect.Shadowland[6] = curAnimaAmount or 0 --NightFae.Anima
	elseif curCovID == 4 then
		collect.Shadowland[7] = curCovLevel or 0 --Necrolord.Renown
		collect.Shadowland[8] = curAnimaAmount or 0 --Necrolord.Anima
	end
	collect.Shadowland[9] = curCovID
end
function CollectPVPRaitings()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	if not IsAddOnLoaded("Blizzard_PVPUI") then
		LoadAddOn("Blizzard_PVPUI")
		return
	end
	local rating2v2, seasonBest2v2, weeklyBest2v2, seasonPlayed2v2, seasonWon2v2, weeklyPlayed2v2, weeklyWon2v2, cap2v2 = GetPersonalRatedInfo(1) --2x2
	local rating3v3, seasonBest3v3, weeklyBest3v3, seasonPlayed3v3, seasonWon3v3, weeklyPlayed3v3, weeklyWon3v3, cap3v3 = GetPersonalRatedInfo(2) --3x3
	local ratingRBG, seasonBestRBG, weeklyBestRBG, seasonPlayedRBG, seasonWonRBG, weeklyPlayedRBG, weeklyWonRBG, capRBG = GetPersonalRatedInfo(4) --RBG
	local winrate2v2 = 0
	if seasonWon2v2 ~= 0 and seasonPlayed2v2 ~= 0 then
		winrate2v2 = math.floor(seasonWon2v2 / seasonPlayed2v2 * 100).."%"
	end
	local winrate3v3 = 0
	if seasonWon3v3 ~= 0 and seasonPlayed3v3 ~= 0 then
		winrate3v3 = math.floor(seasonWon3v3 / seasonPlayed3v3 * 100).."%"
	end
	local winrateRBG = 0
	if seasonWonRBG ~= 0 and seasonPlayedRBG ~= 0 then
		winrateRBG = math.floor(seasonWonRBG / seasonPlayedRBG * 100).."%"
	end
	Octo_ToDo_DragonflyLevels[curGUID].PVP.rating2v2 = rating2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBest2v2 = seasonBest2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrate2v2 = winrate2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.rating3v3 = rating3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBest3v3 = seasonBest3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrate3v3 = winrate3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.ratingRBG = ratingRBG
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBestRBG = seasonBestRBG
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrateRBG = winrateRBG
end
function CollectAllProfessions()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local prof1, prof2 = GetProfessions()
	local prof1 = prof1 and select(7, GetProfessionInfo(prof1))
	local prof2 = prof2 and select(7, GetProfessionInfo(prof2))
	collect.prof1 = prof1 or 0
	collect.prof2 = prof2 or 0
	local profID = {
		name = 0,
		icon = 0,
		chest = {questReq = 0, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 0, questID = {}},
		profQuest = {questReq = 0, questID = {}},
		treatise = {questReq = 0, questID = {}},
	}
	local iconAL = 4620669--136240
	local iconBS = 4620670
	local iconEC = 4620672
	local iconEG = 4620673
	local iconHB = 4620675
	local iconIS = 4620676
	local iconJC = 4620677
	local iconLW = 4620678
	local iconMN = 4620679
	local iconSK = 4620680
	local iconTL = 4620681
	-- Alchemy
	table[171] = {
		--name = " Alchemy",
		name = " Алхимия",
		icon = "|T"..iconAL..":16:16:::64:64:4:60:4:60|t", --AL
		chest = {questReq = 2, questID = {66373, 66374}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 2, questID = {70511, 70504}},
		profQuest = {questReq = 2, questID = {70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937}},
		treatise = {questReq = 1, questID = {74108}}, }
	-- Blacksmithing
	table[164] = {
		--name = " Blacksmithing",
		name = " Кузнечное дело",
		icon = "|T"..iconBS..":16:16:::64:64:4:60:4:60|t", --BS
		chest = {questReq = 2, questID = {66381, 66382}},
		craftOrder = {questReq = 1, questID = {70589}},
		drops = {questReq = 2, questID = {70513, 70512}},
		profQuest = {questReq = 2, questID = {66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211}},
		treatise = {questReq = 1, questID = {74109}}, }
	-- Enchanting
	table[333] = {
		--name = " Enchanting",
		name = " Наложение чар",
		icon = "|T"..iconEC..":16:16:::64:64:4:60:4:60|t", --EC
		chest = {questReq = 2, questID = {66377, 66378}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 2, questID = {70515, 70514}},
		profQuest = {questReq = 2, questID = {66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423}},
		treatise = {questReq = 1, questID = {74110}}, }
	-- Engineering
	table[202] = {
		--name = " Engineering",
		name = " Инженерное дело",
		icon = "|T"..iconEG..":16:16:::64:64:4:60:4:60|t", --EG
		chest = {questReq = 2, questID = {66379, 66380}},
		craftOrder = {questReq = 1, questID = {70591}},
		drops = {questReq = 2, questID = {70517, 70516}},
		profQuest = {questReq = 2, questID = {72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539}},
		treatise = {questReq = 1, questID = {74111}}, }
	-- Herbalism
	table[182] = {
		--name = " Herbalism",
		name = " Травничество",
		icon = "|T"..iconHB..":16:16:::64:64:4:60:4:60|t", --HB --136240
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {71857, 71858, 71859, 71860, 71861, 71864}},
		profQuest = {questReq = 1, questID = {70614, 70613, 70616, 70615}},
		treatise = {questReq = 1, questID = {74107}}, }
	-- Inscription
	table[773] = {
		--name = " Inscription",
		name = " Начертание",
		icon = "|T"..iconIS..":16:16:::64:64:4:60:4:60|t", --IS
		chest = {questReq = 2, questID = {66375, 66376}},
		craftOrder = {questReq = 1, questID = {70592}},
		drops = {questReq = 2, questID = {70519, 70518}},
		profQuest = {questReq = 2, questID = {66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438}},
		treatise = {questReq = 1, questID = {74105}}, }
	-- Jewelcrafting
	table[755] = {
		--name = " Jewelcrafting",
		name = " Ювелирное дело",
		icon = "|T"..iconJC..":16:16:::64:64:4:60:4:60|t", --JC
		chest = {questReq = 2, questID = {66388, 66389}},
		craftOrder = {questReq = 1, questID = {70593}},
		drops = {questReq = 2, questID = {70521, 70520}},
		profQuest = {questReq = 2, questID = {66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562}},
		treatise = {questReq = 1, questID = {74112}}, }
	-- Leatherworking
	table[165] = {
		--name = " Leatherworking",
		name = " Кожевничество",
		icon = "|T"..iconLW..":16:16:::64:64:4:60:4:60|t", --LW
		chest = {questReq = 2, questID = {66384, 66385}},
		craftOrder = {questReq = 1, questID = {70594}},
		drops = {questReq = 2, questID = {70523, 70522}},
		profQuest = {questReq = 2, questID = {66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363}},
		treatise = {questReq = 1, questID = {74113}}, }
	-- Mining
	table[186] = {
		--name = " Mining",
		name = " Горное дело",
		icon = "|T"..iconMN..":16:16:::64:64:4:60:4:60|t", --MN
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {72160, 72161, 72162, 72163, 72164, 72165}},
		profQuest = {questReq = 1, questID = {70617, 70618, 72157, 72156}},
		treatise = {questReq = 1, questID = {74106}}, }
	-- Skinning
	table[393] = {
		--name = " Skinning",
		name = " Снятие шкур",
		icon = "|T"..iconSK..":16:16:::64:64:4:60:4:60|t", --SK
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {70381, 70383, 70384, 70385, 70386, 70389}},
		profQuest = {questReq = 4, questID = {70620, 72159, 70619, 72158}},
		treatise = {questReq = 1, questID = {74114}}, }
	-- Tailoring
	table[197] = {
		--name = " Tailoring",
		name = " Портяжное делло",
		icon = "|T"..iconTL..":16:16:::64:64:4:60:4:60|t", --TL
		chest = {questReq = 2, questID = {66386, 66387}},
		craftOrder = {questReq = 1, questID = {70595}},
		drops = {questReq = 2, questID = {70524, 70525}},
		profQuest = {questReq = 2, questID = {72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899}},
		treatise = {questReq = 1, questID = {74115}}, }
	if prof1 then
		setmetatable(table[prof1], { __index = profID})
		local chest_count_prof1 = 0
		local craftOrder_count_prof1 = 0
		local drops_count_prof1 = 0
		local profQuest_count_prof1 = 0
		local treatise_count_prof1 = 0
		for _, v in ipairs(table[prof1].chest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				chest_count_prof1 = chest_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].craftOrder.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				craftOrder_count_prof1 = craftOrder_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].drops.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				drops_count_prof1 = drops_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].profQuest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				profQuest_count_prof1 = profQuest_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].treatise.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				treatise_count_prof1 = treatise_count_prof1 + 1
			end
		end
		Octo_ToDo_DragonflyLevels[curGUID].profID_prof1 =
		{
			name = table[prof1].name or "noname",
			icon = table[prof1].icon or 0,
			chest = {questReq = table[prof1].chest.questReq, chest_count_prof1 = chest_count_prof1},
			craftOrder = {questReq = table[prof1].craftOrder.questReq, craftOrder_count_prof1 = craftOrder_count_prof1},
			drops = {questReq = table[prof1].drops.questReq, drops_count_prof1 = drops_count_prof1},
			profQuest = {questReq = table[prof1].profQuest.questReq, profQuest_count_prof1 = profQuest_count_prof1},
			treatise = {questReq = table[prof1].treatise.questReq, treatise_count_prof1 = treatise_count_prof1},
		}
		------------------------------------------------------------------------------------------------
	end
	if prof2 then
		setmetatable(table[prof2], { __index = profID})
		local chest_count_prof2 = 0
		local craftOrder_count_prof2 = 0
		local drops_count_prof2 = 0
		local profQuest_count_prof2 = 0
		local treatise_count_prof2 = 0
		for _, v in ipairs(table[prof2].chest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				chest_count_prof2 = chest_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].craftOrder.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				craftOrder_count_prof2 = craftOrder_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].drops.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				drops_count_prof2 = drops_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].profQuest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				profQuest_count_prof2 = profQuest_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].treatise.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				treatise_count_prof2 = treatise_count_prof2 + 1
			end
		end
		Octo_ToDo_DragonflyLevels[curGUID].profID_prof2 =
		{
			name = table[prof2].name or "noname",
			icon = table[prof2].icon or 0,
			chest = {questReq = table[prof2].chest.questReq, chest_count_prof2 = chest_count_prof2},
			craftOrder = {questReq = table[prof2].craftOrder.questReq, craftOrder_count_prof2 = craftOrder_count_prof2},
			drops = {questReq = table[prof2].drops.questReq, drops_count_prof2 = drops_count_prof2},
			profQuest = {questReq = table[prof2].profQuest.questReq, profQuest_count_prof2 = profQuest_count_prof2},
			treatise = {questReq = table[prof2].treatise.questReq, treatise_count_prof2 = treatise_count_prof2},
		}
		------------------------------------------------------------------------------------------------
	end
	return
end
-- local function getThresholdRAID(pointsRAID)
-- local resultRAID = 7
-- -- local resultRAID = 0
-- -- if pointsRAID <= 2 then
-- -- resultRAID = 2
-- -- elseif pointsRAID > 2 and pointsRAID < 4 then
-- -- resultRAID = 4
-- -- elseif pointsRAID >= 4 then
-- -- resultRAID = 6
-- -- end
-- return resultRAID
-- end
-- local function getThresholdKEYS(pointsKEYS)
-- local resultKEYS = 8
-- -- local resultKEYS = 0
-- -- if pointsKEYS <= 1 then
-- -- resultKEYS = 1
-- -- elseif pointsKEYS > 1 and pointsKEYS < 4 then
-- -- resultKEYS = 4
-- -- elseif pointsKEYS >= 4 then
-- -- resultKEYS = 8
-- -- end
-- return resultKEYS
-- end
-- local function getThresholdPVP(pointsPVPS)
-- local resultPVPS = 5000
-- -- local resultPVPS = 0
-- -- if pointsPVPS <= 1250 then
-- -- resultPVPS = 1250
-- -- elseif pointsPVPS > 1250 and pointsPVPS < 2500 then
-- -- resultPVPS = 2500
-- -- elseif pointsPVPS >= 2500 then
-- -- resultPVPS = 5500
-- -- end
-- return resultPVPS
-- end
function CollectDungeonsRaiting()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------
	local info = C_MythicPlus.GetRunHistory(false, true)
	local mapID = C_ChallengeMode.GetMapTable()
	-- --Get Highest Key Level
	-- local level = {}
	-- for l = 1, #info do
	-- local levelMax = info[l].level
	-- tinsert(level, levelMax)
	-- end
	-- if level[1] == nil then
	-- level = {""}
	-- end
	-- --Get Seasen Best Level
	-- table.sort(level, function(a, b) return b<a end)
	----------------------------------------------------------------------------
	--Get Vault Rewards
	local vault = C_WeeklyRewards.GetActivities()
	local RrLvl = {}
	local PrLvl = {false, false, false}
	local MrLvl = {}
	local pRank = {}
	for _, v in ipairs(vault) do
		for i = 1, 3 do
			if v.index == i then
				if v.type == 3 then
					local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
					tinsert(RrLvl, ilvl)
				end
				if v.type == 2 then
					if v.progress >= v.threshold then
						PrLvl[i] = true
					end
					if PrLvl[i] == true then
						local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
						tinsert(pRank, ilvl)
					end
				end
				if v.type == 1 then
					local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
					tinsert(MrLvl, ilvl)
				end
			end
		end
	end
	--Set Rewards ILVL
	if pRank[1] == nil then pRank[1] = NONE end
	if RrLvl[1] == nil then RrLvl[1] = NONE end
	if MrLvl[1] == nil then MrLvl[1] = NONE end
	-- 0 None
	-- 1 MythicPlus
	-- 2 RankedPvP
	-- 3 Raid
	-- 4 AlsoReceive
	-- 5 Concession
	-------------------------------------------------------------------------
	local vaultDataRAID = C_WeeklyRewards.GetActivities()
	local RAIDResult = 0
	local RAIDThreshold = 0
	for i=7, 9 do
		local activityInfoRAID = vaultDataRAID[i]
		if activityInfoRAID then
			RAIDResult = activityInfoRAID.progress
			RAIDThreshold = activityInfoRAID.threshold
		else
			RAIDResult = 0
			RAIDThreshold = 0
		end
	end
	local RAID = RAIDResult.."/"..RAIDThreshold.." |cffa335ee"..table.concat(RrLvl, "/").."|r"
	-------------------------------------------------------------------------
	local vaultDataKEYS = C_WeeklyRewards.GetActivities()
	local KEYSResult = 0
	local KEYSThreshold = 0
	for i=1, 3 do
		local activityInfoKEYS = vaultDataKEYS[i]
		if activityInfoKEYS then
			KEYSResult = activityInfoKEYS.progress
			KEYSThreshold = activityInfoKEYS.threshold
		else
			KEYSResult = 0
			KEYSThreshold = 0
		end
	end
	-- local KEYS = ("%s/%s"):format(KEYSResult, KEYSThreshold)
	local KEYS = KEYSResult.."/"..KEYSThreshold.." |cffa335ee"..table.concat(MrLvl, "/").."|r"
	-------------------------------------------------------------------------
	local vaultDataPVPS = C_WeeklyRewards.GetActivities()
	local PVPSResult = 0
	local PVPSThreshold = 0
	for i=4, 6 do
		local activityInfoPVPS = vaultDataPVPS[i]
		if activityInfoPVPS then
			PVPSResult = activityInfoPVPS.progress
			PVPSThreshold = activityInfoPVPS.threshold
		else
			PVPSResult = 0
			PVPSThreshold = 0
		end
	end
	-- local PVPS = ("%s/%s"):format(PVPSResult, PVPSThreshold)
	local PVPS = PVPSResult.."/"..PVPSThreshold.." |cffa335ee"..table.concat(pRank, "/").."|r"
	------------------------------------------------------------------
	local mythicPlusMaps = C_ChallengeMode.GetMapTable()
	C_MythicPlus.RequestRewards()
	local max = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
	C_MythicPlus.RequestMapInfo()
	for i=1, #mythicPlusMaps do
		--local _, _, level, affixes = C_ChallengeMode.GetMapPlayerStats(mythicPlusMaps[i])
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mythicPlusMaps[i])
		if level and level > max then
			max = level
		end
	end
	if max == 0 then max = "" end
	------------------------------------------------------------------
	collect.RIO_Score = RIO_Score
	collect.RIO_weeklyBest = ("|cffa335ee"..max.."|r") or ""
	collect.RIO_RAID = RAID or ""
	collect.RIO_KEYS = KEYS or ""
	collect.RIO_PVPS = PVPS or ""
end
function CollectCurrentKEY()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local mkey = ""
	------------------------------------------------------------------
	local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
	if keyStoneLevel then
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			--for bag = 0, 5 do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					for k, v in pairs(containerInfo) do
						if k ~= nil and k == "hyperlink" then
							-- local hyperlink = v
							if v and (
								v:find("item:138019") or
								v:find("keystone:") or
								v:find("Ключ:") or
								v:find("item:158923") or
								v:find("item:180653")
							)
							then
								name = v
								if name:find("Каражан") then
									name = name:gsub("^[^:]+: ", "Кара: ")
								elseif name:find("Мехагон") then
									name = name:gsub("^[^ ]+ ", "")
								end
								local _, _, dungeon, lvl, expire = strsplit(":", name)
								-- local dungeonNAME = C_ChallengeMode.GetMapUIInfo(dungeon)
								-- local str = dungeonNAME
								-- mkey = lvl .. ": " ..(str:gsub("%s", ""))
								local dungeonNAME = C_ChallengeMode.GetMapUIInfo(dungeon)
								local Abbr_En_Name = "whz" --https://wow.tools/dbc/?dbc=mapchallengemode
								-- 0
								if dungeon == "56" then Abbr_En_Name = "SB" --Stormstout Brewery
								elseif dungeon == "57" then Abbr_En_Name = "GSS" --Gate of the Setting Sun
								elseif dungeon == "58" then Abbr_En_Name = "SPM" --Shado-Pan Monastery
								elseif dungeon == "59" then Abbr_En_Name = "SoNT" --Siege of Niuzao Temple
								elseif dungeon == "60" then Abbr_En_Name = "MP" --Mogu'shan Palace
								elseif dungeon == "76" then Abbr_En_Name = "Scho" --Scholomance
								elseif dungeon == "77" then Abbr_En_Name = "SH" --Scarlet Halls
								elseif dungeon == "78" then Abbr_En_Name = "SM" --Scarlet Monastery
								elseif dungeon == "161" then Abbr_En_Name = "Sky" --Skyreach
								elseif dungeon == "163" then Abbr_En_Name = "BSM" --Bloodmaul Slag Mines
								elseif dungeon == "164" then Abbr_En_Name = "Auch" --Auchindoun
								elseif dungeon == "167" then Abbr_En_Name = "UBS" --Upper Blackrock Spire
								elseif dungeon == "168" then Abbr_En_Name = "TE" --The Everbloom
								elseif dungeon == "200" then Abbr_En_Name = "HoV" --Halls of Valor
								elseif dungeon == "208" then Abbr_En_Name = "MoS" --Maw of Souls
								elseif dungeon == "209" then Abbr_En_Name = "TA" --The Arcway
								elseif dungeon == "210" then Abbr_En_Name = "CoS" --Court of Stars
								elseif dungeon == "227" then Abbr_En_Name = "RtKL" --Return to Karazhan: Lower
								elseif dungeon == "233" then Abbr_En_Name = "CoEN" --Cathedral of Eternal Night
								elseif dungeon == "234" then Abbr_En_Name = "RtKU" --Return to Karazhan: Upper
								elseif dungeon == "239" then Abbr_En_Name = "SotT" --Seat of the Triumvirate
								elseif dungeon == "197" then Abbr_En_Name = "EoA" --Eye of Azshara
								elseif dungeon == "198" then Abbr_En_Name = "DHT" --Darkheart Thicket
								elseif dungeon == "199" then Abbr_En_Name = "BRH" --Black Rook Hold
								elseif dungeon == "207" then Abbr_En_Name = "VotW" --Vault of the Wardens
									-- 3 CATA
									--elseif dungeon == "438" then Abbr_En_Name = "VP" --The Vortex Pinnacle
									-- 4 MOP
								elseif dungeon == "2" then Abbr_En_Name = "TJS" --Temple of the Jade Serpent
									-- 5 WOD
								elseif dungeon == "165" then Abbr_En_Name = "SBG" --Shadowmoon Burial Grounds
								elseif dungeon == "166" then Abbr_En_Name = "GD" --Grimrail Depot
								elseif dungeon == "169" then Abbr_En_Name = "ID" --Iron Docks
									-- 6 LEGION
									--elseif dungeon == "206" then Abbr_En_Name = "NL" --Neltharion's Lair
									-- 7 BFA
								elseif dungeon == "244" then Abbr_En_Name = "AD" --Atal'Dazar
									-- elseif dungeon == "245" then Abbr_En_Name = "FH" --Freehold
								elseif dungeon == "246" then Abbr_En_Name = "TD" --Tol Dagor
								elseif dungeon == "247" then Abbr_En_Name = "ML" --The MOTHERLODE!!
								elseif dungeon == "248" then Abbr_En_Name = "WM" --Waycrest Manor
								elseif dungeon == "249" then Abbr_En_Name = "KR" --Kings' Rest
								elseif dungeon == "250" then Abbr_En_Name = "ToS" --Temple of Sethraliss
									--elseif dungeon == "251" then Abbr_En_Name = "UNDR" --The Underrot
								elseif dungeon == "252" then Abbr_En_Name = "SotS" --Shrine of the Storm
								elseif dungeon == "353" then Abbr_En_Name = "SoB" --Siege of Boralus
								elseif dungeon == "369" then Abbr_En_Name = "OMJ" --Operation: Mechagon - Junkyard
								elseif dungeon == "370" then Abbr_En_Name = "OMW" --Operation: Mechagon - Workshop
									-- 8 SL
								elseif dungeon == "375" then Abbr_En_Name = "MoTS" --Mists of Tirna Scithe
								elseif dungeon == "376" then Abbr_En_Name = "TNW" --The Necrotic Wake
								elseif dungeon == "377" then Abbr_En_Name = "DOS" --De Other Side
								elseif dungeon == "378" then Abbr_En_Name = "HoA" --Halls of Atonement
								elseif dungeon == "379" then Abbr_En_Name = "PF" --Plaguefall
								elseif dungeon == "380" then Abbr_En_Name = "SD" --Sanguine Depths
								elseif dungeon == "381" then Abbr_En_Name = "SoA" --Spires of Ascension
								elseif dungeon == "382" then Abbr_En_Name = "ToP" --Theater of Pain
								elseif dungeon == "391" then Abbr_En_Name = "STRT" --Tazavesh: Streets of Wonder
								elseif dungeon == "392" then Abbr_En_Name = "GMBT" --Tazavesh: So'leah's Gambit
									-- 9 DF
								elseif dungeon == "399" then Abbr_En_Name = "RLP" --Ruby Life Pools
								elseif dungeon == "400" then Abbr_En_Name = "NO" --The Nokhud Offensive
								elseif dungeon == "401" then Abbr_En_Name = "AV" --The Azure Vault
								elseif dungeon == "402" then Abbr_En_Name = "AA" --Algeth'ar Academy
									--elseif dungeon == "403" then Abbr_En_Name = "ULD" --Uldaman: Legacy of Tyr
									-- elseif dungeon == "404" then Abbr_En_Name = "NELT" --Neltharus
									-- elseif dungeon == "405" then Abbr_En_Name = "BH" --Brackenhide Hollow
									-- elseif dungeon == "406" then Abbr_En_Name = "HOI" --Halls of Infusion
								elseif dungeon == "405" then Abbr_En_Name = "BH" --Brackenhide Hollow 393267 (лощина)
								elseif dungeon == "245" then Abbr_En_Name = "FH" --Freehold 410071 (гавань)
								elseif dungeon == "406" then Abbr_En_Name = "HOI" --Halls of Infusion 393283 (чертоги)
								elseif dungeon == "206" then Abbr_En_Name = "NL" --Neltharion's Lair 410078 (логово)
								elseif dungeon == "404" then Abbr_En_Name = "NELT" --Neltharus 393276 (нелтарий)
								elseif dungeon == "251" then Abbr_En_Name = "UNDR" --The Underrot 410074 (подгнилье)
								elseif dungeon == "438" then Abbr_En_Name = "VP" --The Vortex Pinnacle 410080 (вершина)
								elseif dungeon == "403" then Abbr_En_Name = "ULD" --Uldaman: Legacy of Tyr 393222 (ульдаман)
								end
								mkey = ("|cffa335ee"..lvl .. " " ..Abbr_En_Name.."|r")
							end
						end
					end
				end
			end
		end
	else mkey = 0
	end
	if collect then
		collect.CurrentKey = mkey or 0
		local hasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
		--collect.hasAvailableRewards = hasAvailableRewards or false
		if hasAvailableRewards == true then collect.CurrentKey = AddonColor..">>VAULT<<|r" end
	end
end
local function QuestsByID(questID)
	local count = 0
	for k, questID in pairs(ProfessionsQuests) do
		if C_QuestLog.IsQuestFlaggedCompleted(v) then
			count = count +1
		end
	end
	return count
end
local function CompactNumberFormat(number)
	if not number then
		number = 0
	end
	if number == 0 then
		return 0
	elseif number < 1000 then
		return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then
		return (math.floor(number/100)/10) .."k"
	else return (math.floor(number/100000)/10) .."m"
	end
end
local function CheckCompletedByQuestID(questID)
	local Octopussy = ""
	-- сделан
	if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
		Octopussy = (DONE)
		-- можно сдать
	elseif C_QuestLog.IsComplete(questID) == true then
		Octopussy = "|cffFF00FF>СДАЙ<|r"
		-- не сделан и нет квеста
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then
		Octopussy = (NONE)
		-- есть кв и нельзя сдать
	elseif C_QuestLog.IsOnQuest(questID) == true and C_QuestLog.IsComplete(questID) == false then
		local objectives = C_QuestLog.GetQuestObjectives(questID)
		if objectives == nil then
			return ""
		end
		local OBJF1 = "" local OBJR1 = "" local C1 = " |cFFFF5771" local R1 = "|r"
		local OBJF2 = "" local OBJR2 = "" local C2 = " |cFFFF5771" local R2 = "|r"
		local OBJF3 = "" local OBJR3 = "" local C3 = " |cFFFF5771" local R3 = "|r"
		local OBJF4 = "" local OBJR4 = "" local C4 = " |cFFFF5771" local R4 = "|r"
		local OBJF5 = "" local OBJR5 = "" local C5 = " |cFFFF5771" local R5 = "|r"
		if objectives[1] == nil then
		OBJF1 = "" OBJR1 = "" else if
			objectives[1].numFulfilled == objectives[1].numRequired then
			OBJF1 = "|cff4FFF79done|r" OBJR1 = "" else if
				objectives[1].numFulfilled >= 0 then
					OBJF1 = objectives[1].numFulfilled.."/" OBJR1 = objectives[1].numRequired
				end
			end
		end
		if OBJF1 == OBJR1 then
			C1 = "|cff4FFF79"
		end
		if objectives[2] == nil then
		OBJF2 = "" OBJR2 = "" else if
			objectives[2].numFulfilled == objectives[2].numRequired then
			OBJF2 = "|cff4FFF79done|r" OBJR2 = "" else if
				objectives[2].numFulfilled >= 0 then
					OBJF2 = objectives[2].numFulfilled.."/" OBJR2 = objectives[2].numRequired
				end
			end
		end
		if OBJF2 == OBJR2 then
			C2 = "|cff4FFF79"
		end
		if objectives[3] == nil then
		OBJF3 = "" OBJR3 = "" else if
			objectives[3].numFulfilled == objectives[3].numRequired then
			OBJF3 = "|cff4FFF79done|r" OBJR3 = "" else if
				objectives[3].numFulfilled >= 0 then
					OBJF3 = objectives[3].numFulfilled.."/" OBJR3 = objectives[3].numRequired
				end
			end
		end
		if OBJF3 == OBJR3 then
			C3 = "|cff4FFF79"
		end
		if objectives[4] == nil then
		OBJF4 = "" OBJR4 = "" else if
			objectives[4].numFulfilled == objectives[4].numRequired then
			OBJF4 = "|cff4FFF79done|r" OBJR4 = "" else if
				objectives[4].numFulfilled >= 0 then
					OBJF4 = objectives[4].numFulfilled.."/" OBJR4 = objectives[4].numRequired
				end
			end
		end
		if OBJF4 == OBJR4 then
			C4 = "|cff4FFF79"
		end
		if objectives[5] == nil then
		OBJF5 = "" OBJR5 = "" else if
			objectives[5].numFulfilled == objectives[5].numRequired then
			OBJF5 = "|cff4FFF79done|r" OBJR5 = "" else if
				objectives[5].numFulfilled >= 0 then
					OBJF5 = objectives[5].numFulfilled.."/" OBJR5 = objectives[5].numRequired
				end
			end
		end
		if OBJF5 == OBJR5 then
			C5 = "|cff4FFF79"
		end
		if objectives then
			if objectives[5] then
				Octopussy = "|cffFF0000"..CompactNumberFormat(objectives[5].numFulfilled).."/"..CompactNumberFormat(objectives[5].numRequired).."|r"
			elseif objectives[4] then
				Octopussy = "|cffFF0000"..CompactNumberFormat(objectives[4].numFulfilled).."/"..CompactNumberFormat(objectives[4].numRequired).."|r"
			elseif objectives[3] then
				Octopussy = "|cffFF0000"..CompactNumberFormat(objectives[3].numFulfilled).."/"..CompactNumberFormat(objectives[3].numRequired).."|r"
			elseif objectives[2] then
				Octopussy = "|cffFF0000"..CompactNumberFormat(objectives[2].numFulfilled).."/"..CompactNumberFormat(objectives[2].numRequired).."|r"
			elseif objectives[1] then
				Octopussy = "|cffFF0000"..CompactNumberFormat(objectives[1].numFulfilled).."/"..CompactNumberFormat(objectives[1].numRequired).."|r"
			end
		end
	end
	return Octopussy
end
local function CheckReputationByRepID(factionID)
	local Vivod = 0
	local Octo_REPUTATION_DEV_text = false
	local friendshipRank, friendshipMaxRank
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(factionID)
	local color = "|cffFFFFFF"
	local r = "|r"
	local standingTEXT = ""
	--RED
	if standingID == 1 then color ="|cffFF0000" standingTEXT = " ("..FACTION_STANDING_LABEL1..")" -- color ="|cffc0443b" Hated
	elseif standingID == 2 then color ="|cffFF0000" standingTEXT = " ("..FACTION_STANDING_LABEL2..")" -- color ="|cffd91614" Hostile
		--оранж
	elseif standingID == 3 then color ="|cffFF661A" standingTEXT = " ("..FACTION_STANDING_LABEL3..")" -- color ="|cffcd732e" Unfriendly
		--ЖЕЛТЫЙ
	elseif standingID == 4 then color ="|cffd9ff18" standingTEXT = " ("..FACTION_STANDING_LABEL4..")" -- color ="|cffd9ff18" Neutral
		--ЗЕЛЕНЫЙ
	elseif standingID == 5 then color ="|cffFFF371" standingTEXT = " ("..FACTION_STANDING_LABEL5..")" -- color ="|cff1af11a" Friendly
		--ПОЧТИ ЗЕЛЕНЫЙ
	elseif standingID == 6 then color ="|cff4FFF79" standingTEXT = " ("..FACTION_STANDING_LABEL6..")" -- color ="|cff1af05e" Honored
	elseif standingID == 7 then color ="|cff4FFF79" standingTEXT = " ("..FACTION_STANDING_LABEL7..")" -- color ="|cff19ffc6" Revered
		--БИРЮЗОВЫЙ
	elseif standingID == 8 then color = AddonColor standingTEXT = " ("..FACTION_STANDING_LABEL8..")" -- color ="|cff00ffff" Exalted
	elseif standingID == 9 then color = AddonColor standingTEXT = " ("..FACTION_STANDING_LABEL9..")" -- color ="|cff00ffff" Paragon
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID)
	local friendshipFactionID = reputationInfo.friendshipFactionID
	if not barMax then
		Vivod = "not barMax"
	elseif factionID and barMax and barMin ~= 0 then
		--elseif factionID and barMax and isChild == false then
		local dev_text = ""
		----------- ПАРАГОН
		if C_Reputation.IsFactionParagon(factionID) then
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cffFF4C4FПАРАГОН: |r" end
			local currentValue = C_Reputation.GetFactionParagonInfo(factionID) or 0
			local threshold = 1
			local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)
			if threshold then
				local value = currentValue % threshold
				Vivod = dev_text..AddonColor..--[[CompactNumberFormat]](value).."/"..--[[CompactNumberFormat]](threshold)..r
				if hasRewardPending then
					Vivod = dev_text..CheckCompletedByQuestID(rewardQuestID)
				end
			end
			----------- МАЖОР ФАКШН
		elseif C_Reputation.IsMajorFaction(factionID) then
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cff4FFF79МАЖОР ФАКШН: |r" end
			local data = C_MajorFactions.GetMajorFactionData(factionID)
			local currentValue = data.renownReputationEarned
			local totalValue = data.renownLevelThreshold
			local standing = data.renownLevel
			Vivod = dev_text..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue)..AddonColor.."("..--[[CompactNumberFormat]](standing)..")|r"
			if standing == 0 then Vivod = 0 end
			----------- ФРЕНД ФАКШН
		elseif reputationInfo and friendshipFactionID ~= 0 then
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cffF3BC41ФРЕНД ФАКШН: |r" end
			local standing = reputationInfo.standing or 0
			local reactionThreshold = reputationInfo.reactionThreshold or 0
			local nextThreshold = reputationInfo.nextThreshold or 0
			local currentValue = standing-reactionThreshold
			local totalValue = nextThreshold-reactionThreshold
			local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
			local currentLevel, maxLevel
			if rankInfo then
				currentLevel = rankInfo.currentLevel or 0
				maxLevel = rankInfo.maxLevel or 0
			end
			if currentLevel == 1 then color ="|cffd9ff18" standingTEXT = " (Stranger)" -- 1
			elseif currentLevel == 2 then color ="|cffFFF371" standingTEXT = " (Acquaintance)" -- 2
			elseif currentLevel == 3 then color ="|cffFFF371" standingTEXT = " (Buddy)" -- 3
			elseif currentLevel == 4 then color ="|cffFFF371" standingTEXT = " (Friend)" -- 4
			elseif currentLevel == 5 then color ="|cff4FFF79" standingTEXT = " (Good Friend)" -- 5
			elseif currentLevel == 6 then color = AddonColor standingTEXT = " (Best Friend)" -- 6
			end
			Vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue) .. standingTEXT..r
			if currentLevel == maxLevel then Vivod = dev_text..AddonColor.."Done|r" end
			--if standing == 0 then Vivod = 0 end
			----------- Other
		else
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cffAF61FFOther: |r" end
			local currentValue = barValue-barMin
			local totalValue = barMax-barMin
			Vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue)..standingTEXT..r
			if currentValue == totalValue or nextThreshold == 0 then Vivod = dev_text..AddonColor.."Done|r" end
			--if standingID == 0 or currentValue == 0 then Vivod = 0 end
		end
	end
	return Vivod
end
local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	if data then
		return
		data.name, -- 1
		data.quantity, -- 2
		data.iconFileID -- 3
	end
end
local currencyID = {
	2533, --Возрождающееся пламя Тьмы
	-- ЖЕЛТЫЕ
	-- 1803, -- Эхо Ни'алоты
	-- ОРАНЖЕВЫЕ
	-- 1828, -- Пепел душ
	-- 1906, -- Угли душ
	-- 2009, -- Космический ветер
	2409, --зеленая
	2410, --синия
	2411, --фио
	2412, --оранж
	-- ФИОЛЕТОВЫЕ
	1191, -- Доблесть
	1602, -- Очки завоевания
	-- 1721, -- Радужная манажемчужина
	-- 1977, -- Стигийские угли
	-- 2032, -- Торговый жетон
	-- СИНИИ
	2245, --Драконьи камни
	1792, -- Честь
	1166, -- Искаженный временем знак
	2122, -- Печать бури
	-- 1508, -- Дымчатый аргунит
	-- 1810, -- Очищенная душа
	-- 1813, -- Запасенная анима
	-- 1904, -- Знания о Башне
	-- 1979, -- Шифры Предвечных
	-- ЗЕЛЕНЫЕ
	2118, -- Энергия стихий
	-- 1342, -- Припасы Армии погибели Легиона
	-- 1931, -- Исследование каталога
	-- БЕЛЛЫЕ
	2003, -- Припасы Драконьих островов
	2123, -- Кровавые жетоны
	-- 2167, -- Заряды катализатора (НЕ АКТУАЛЬНЫ)
	-- 1155, -- Древняя мана
	-- 1220, -- Ресурсы оплота класса
	-- 1226, -- Осколок Пустоты
	-- 1533, -- Пробуждающая сущность
	-- 1560, -- Ресурсы для войны
	-- 1710, -- Дублон мореплавателя
	-- 1718, -- Пыль титанов
	-- 1719, -- Зараженные реликвии
	-- 1755, -- Сгусток видений
	-- 1767, -- Стигия
	1220, -- Ресурсы оплота класса
	824, -- Ресурсы гарнизона
}
local function CurrencyTEST()
	local table = {}
	for i = 1, 3000 do
		table[i] = C_CurrencyInfo.GetCurrencyInfo(i)
	end
	for k, v in pairs(table) do
		if k ~= nil and v ~= nil and k ~= 0 then
			tinsert(currencyID, k)
		end
	end
end
CurrencyTEST()
-- local function curTest()
-- for k,v in ipairs(currencyID) do
-- --print (k,v)
-- print (func_currencyicon(k)..func_currencyName(k),v.." ID: "..k)
-- end
-- end
-- curTest()
local RARE_ZARALEK_LIST = {75271,
	75285,
	75298,
	75326,
	75576,
	75314,
	75296,
	75353,
	75358,
	75274,
	75366,
	75336,
	75269,
	75334,
	75322,
	75267,
	75476,
	75276,
	75342,
	75338,
	75340,
	75360,
	75292,
	75349,
	75364,
}
local RARE_OSTROV_LIST = {74331,
	74347,
	74345,
	74336,
	74337,
	74342,
	74321,
	74343,
	74338,
	74329,
	74307,
	74325,
	74346,
	74344,
	74332,
	74306,
	74333,
	74341,
	74305,
	74339,
	74300,
	74349,
	74322,
	74330,
	74328,
}
local EVENTS_ZARALEK_LIST = {75612,
	75471,
	75455,
	75664,
	75611,
	75478,
	75451,
	75461,
	75705,
	75454,
	75450,
	75222,
	75370,
	75494,
	75441,
	75156,
	75624,
	74352,
}
local itemID = {
	205367, -- Дар обязанного исследователя
	92426,
	92441,
	83078,
	92471,
	--Комплект вражды DIABLO 4
	122284,
	205878,
	205225,
	206037,
	205999,
	206028,
	138727,
	138728,
	138488,
	138729,
	138486,
	167862,
	206366,
	204180,
	204843,
	206144,
	206143,
	206142,
	206141,
	206140,
	206139,
	185834,
	201250,
	204188,
	204187,
	204186,
	204191,
	204190,
	204189,
	203430,
	203683,
	203710,
	204464,
	205903,
	204985,
	205188,
	205984,
	204715,
	204727,
	204440,
	204717,
	24915,
	24916,
	24917,
	24918,
	24919,
	49040,
	50274,
	51316,
	51317,
	51318,
	51319,
	51320,
	51321,
	52200,
	52201,
	52251,
	52252,
	52253,
	122338,
	122339,
	122340,
	122341,
	128353,
	129940,
	129941,
	129942,
	129943,
	129944,
	129945,
	129946,
	129947,
	129948,
	129949,
	129950,
	129951,
	129954,
	129955,
	133150,
	133151,
	133152,
	133154,
	133159,
	133160,
	137642,
	141605,
	141652,
	143935,
	143936,
	143937,
	143938,
	143939,
	143940,
	143941,
	143942,
	143943,
	143944,
	143945,
	143946,
	143947,
	151614,
	151615,
	166751,
	167731,
	167732,
	167924,
	167925,
	167926,
	167927,
	167928,
	167929,
	167930,
	167932,
	168017,
	168018,
	180817,
	183616,
	187997,
	187998,
	188152,
	189765,
	190189,
	190453,
	190454,
	190455,
	190456,
	191251,
	191264,
	191784,
	191915,
	192130,
	192131,
	192132,
	193201,
	193891,
	193897,
	193898,
	193899,
	193900,
	193901,
	193902,
	193903,
	193904,
	193905,
	193907,
	193909,
	193910,
	193913,
	194039,
	194040,
	194041,
	194054,
	194055,
	194061,
	194062,
	194063,
	194064,
	194066,
	194067,
	194068,
	194072,
	194076,
	194077,
	194078,
	194079,
	194080,
	194081,
	194337,
	194697,
	194698,
	194699,
	194700,
	194702,
	194703,
	194704,
	194708,
	197921,
	198046,
	198395,
	198438,
	198454,
	198510,
	198599,
	198606,
	198607,
	198608,
	198609,
	198610,
	198611,
	198612,
	198613,
	198656,
	198658,
	198659,
	198660,
	198662,
	198663,
	198664,
	198667,
	198669,
	198670,
	198680,
	198682,
	198683,
	198684,
	198685,
	198686,
	198687,
	198690,
	198692,
	198693,
	198696,
	198697,
	198699,
	198702,
	198703,
	198704,
	198710,
	198711,
	198712,
	198789,
	198837,
	198841,
	198863,
	198864,
	198865,
	198866,
	198867,
	198868,
	198869,
	198963,
	198964,
	198965,
	198966,
	198967,
	198968,
	198969,
	198970,
	198971,
	198972,
	198973,
	198974,
	198975,
	198976,
	198977,
	198978,
	199115,
	199122,
	199128,
	199192,
	199197,
	199472,
	199473,
	199474,
	199475,
	200069,
	200070,
	200072,
	200073,
	200095,
	200224,
	200285,
	200287,
	200288,
	200289,
	200300,
	200452,
	200453,
	200454,
	200455,
	200468,
	200513,
	200515,
	200516,
	200609,
	200610,
	200611,
	200652,
	200677,
	200678,
	200686,
	200764,
	200811,
	200846,
	200972,
	200973,
	200974,
	200975,
	200976,
	200977,
	200978,
	200979,
	200980,
	200981,
	200982,
	201003,
	201004,
	201005,
	201006,
	201007,
	201008,
	201009,
	201010,
	201011,
	201012,
	201013,
	201014,
	201015,
	201016,
	201017,
	201018,
	201019,
	201020,
	201023,
	201268,
	201269,
	201270,
	201271,
	201272,
	201273,
	201274,
	201275,
	201276,
	201277,
	201278,
	201279,
	201280,
	201281,
	201282,
	201283,
	201284,
	201285,
	201286,
	201287,
	201288,
	201289,
	201300,
	201301,
	201326,
	201352,
	201439,
	201462,
	201700,
	201705,
	201706,
	201708,
	201709,
	201710,
	201711,
	201712,
	201713,
	201714,
	201715,
	201716,
	201717,
	201728,
	201755,
	201756,
	201781,
	201782,
	201817,
	201836,
	201921,
	201922,
	201923,
	201924,
	201991,
	202011,
	202014,
	202016,
	202017,
	202039,
	202052,
	202079,
	202080,
	202091,
	202092,
	202093,
	202094,
	202097,
	202098,
	202142,
	202152,
	202171,
	202172,
	202173,
	202196,
	202371,
	202667,
	202668,
	202669,
	202670,
	202854,
	202870,
	202871,
	202872,
	203217,
	203220,
	203222,
	203224,
	203476,
	203611,
	203612,
	203613,
	203614,
	203615,
	203616,
	203617,
	203618,
	203619,
	203620,
	203622,
	203623,
	203626,
	203627,
	203628,
	203629,
	203630,
	203631,
	203632,
	203633,
	203634,
	203635,
	203636,
	203637,
	203638,
	203639,
	203640,
	203641,
	203642,
	203643,
	203644,
	203645,
	203646,
	203647,
	203648,
	203649,
	203650,
	203681,
	203699,
	203700,
	203702,
	204075,
	204076,
	204077,
	204078,
	204193,
	204194,
	204195,
	204196,
	204215,
	204217,
	204222,
	204224,
	204225,
	204226,
	204227,
	204228,
	204229,
	204230,
	204231,
	204232,
	204233,
	204276,
	204352,
	204359,
	204378,
	204379,
	204380,
	204381,
	204383,
	204403,
	204469,
	204470,
	204471,
	204475,
	204558,
	204559,
	204560,
	204573,
	204574,
	204575,
	204576,
	204577,
	204578,
	204579,
	204681,
	204682,
	204697,
	204721,
	204722,
	204723,
	204724,
	204725,
	204726,
	204850,
	204853,
	204855,
	204986,
	204987,
	204988,
	204990,
	204999,
	205001,
	205211,
	205212,
	205213,
	205214,
	205216,
	205219,
	205249,
	205250,
	205423,
	205982,
	205986,
	205987,
	205988,
	205989,
	206019,
	206025,
	206030,
	206031,
	206034,
	206035,
	205288,
	205347,
	192055, -- Артефакт Драконьих островов
	200443, -- Артефакт Драконьих островов (BOA)
	200093, -- Охотничий трофей кентавров
	200447, -- Охотничий трофей кентавров (BOA)
	199906, -- Реликвия титанов
	200450, -- Реликвия титанов (BOA)
	201411, -- Древний артефакт хранилища
	201412, -- Древний артефакт хранилища (дает кв)
	200071, -- Священный тотем клыкарров
	200449, -- Священный тотем клыкарров (BOA)
	201470, -- История о незабываемой победе
	201471, -- История о блистательной победе
	206006, -- Благодарность Хранителя Земли (2500 репы)
	202854, -- Чудо рыба 10.0.7
}
local itemIDReputation = {
	192055, -- Артефакт Драконьих островов
	200443, -- Артефакт Драконьих островов (BOA)
	200093, -- Охотничий трофей кентавров
	200447, -- Охотничий трофей кентавров (BOA)
	199906, -- Реликвия титанов
	200450, -- Реликвия титанов (BOA)
	201411, -- Древний артефакт хранилища
	201412, -- Древний артефакт хранилища (дает кв)
	200071, -- Священный тотем клыкарров
	200449, -- Священный тотем клыкарров (BOA)
	201470, -- История о незабываемой победе
	201471, -- История о блистательной победе
	206006, -- Благодарность Хранителя Земли (2500 репы)
	202854, -- Чудо рыба 10.0.7
}
--MergeTable(itemID, itemIDReputation)
-- local function itemID_TEST_INSERT()
-- for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
-- for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
-- local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
-- if containerInfo then
-- for k, v in pairs(containerInfo) do
-- if k == "itemID" then
-- tinsert(itemID, v)
-- end
-- end
-- end
-- end
-- end
-- end
local reputationID = {
	2507, -- Драконья экспедиция
	2503, -- Кентавры Маруук
	2511, -- Искарские клыкарры
	2510, -- Союз Вальдраккена
	2564, -- Лоаммские ниффы
	2517, -- Гневион
	2518, -- Сабеллиан
	-- 2526, -- Фурболги из клана Зимней Шкуры
	-- 2550, -- Кобальтовая ассамблея
	-- 1072, -- [DNT] AC Major Faction Child Renown Test
	-- 2506, -- Dragonfly
	-- 2523, -- Темные Когти (Орда)
	-- 2524, -- Обсидиановые Хранители (Альянс)
	-- 2544, -- Консорциум ремесленников – филиал на Драконьих островах
	-- 2504, -- Кентавры Маруук (идеал)
	-- 2508, -- Драконья экспедиция (идеал)
	-- 2509, -- Клан Шикаар
	-- 2512, -- Клан Айлааг
	-- 2513, -- Клан Он'ир
	-- 2520, -- Клан Нокхуд
	-- 2521, -- Клан Нокуд (идеал)
	-- 2522, -- Клан Тирай
	-- 2542, -- Клан Укхел
	-- 2551, -- Искарские клыкарры (идеал)
	-- 2552, -- Союз Вальдраккена (идеал)
	-- 2554, -- Клан Тогус
	-- 2555, -- Клан Кейган
}
local function TESTREP()
	local tableREP = {}
	for i = 1, GetNumFactions() do
		local factionID = select(14, GetFactionInfo(i))
		tableREP = {factionID}
		for k, v in ipairs (tableREP) do
			tinsert(reputationID, v)
		end
	end
end
local questIDtable = {
	75497, -- Дар катализатор 10.1.0
	-- PALADIN WARRIOR DEATHKNIGHT
	24545, -- Святость и скверна
	24743, -- Грань Тьмы
	24547, -- Пиршество душ
	24749, -- Сила нечестивости
	24756, -- Сила крови
	24757, -- Сила льда
	24548, -- Расколотый трон
	24549, -- Темная Скорбь...
	24748, -- Последняя битва Короля-лича
	--WARLOCK
	32295, -- Необычная книга
	32307, -- Чтец мертвого языка
	32309, -- История шести мастеров (HORDE)
	32310, -- История шести мастеров (Alliance)
	32317, -- В поисках камней души
	32324, -- В поисках сигнала
	32325, -- Проникновение в Черный храм
	--Sniffen
	75459,
	76027,
	75621,
	75397,
	75517,
	75619,
	76014,
	75620,
	76081,
	75390,
	75234,
	75516,
	75996,
	76016,
	75393,
	76015,
	76084,
	-- Ученики фиррака
	75239,
	--Шадейсетал
	55509,
	55511,
	13183,
	--ОЛО
	56339,
	56337,
	--Ашран
	72167,-- 1500 на пвп
	72170,
	75622,-- трофей за пвп?
	74771,
	75694,
	74905,
	75887,
	74570,
	74569,
	74568,
	75888,
	74775,
	75665,
	40168,
	40173,
	40786,
	40787,
	45563,
	47148,
	55498,
	55499,
	64710,
	66133,
	66419,
	66860,
	66861,
	66862,
	66863,
	66864,
	66865,
	66866,
	66867,
	66868,
	66870,
	66871,
	66873,
	66874,
	66875,
	71026,
	72166,
	72168,
	72169,
	72171,
	72646,
	72647,
	72648,
	72649,
	72719,
	72720,
	72721,
	72722,
	72723,
	72724,
	72725,
	72726,
	72727,
	72728,
	72810,
	74378,
	74871,
	75506,
	76122,
	36614,
}
---------------------------------------------------------------------------------------------------------
function CollectAllCurrency()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	for k, v in ipairs(currencyID) do
		local data = C_CurrencyInfo.GetCurrencyInfo(v)
		local quantity = data.quantity
		local maxQuantity = data.maxQuantity
		if v == 2167 and maxQuantity > 6 then maxQuantity = 6 end
		collect.CurrencyID[v] = quantity
		collect.CurrencyID_maxQuantity[v] = maxQuantity
		--if CharInfo.UnitLevel >= 70 then tinsert(currencyID, 2167) end
		-- == 0 and nil or quantity
		-- collect.CurrencyID[v] = maxQuantity
		-- local c = "|cffffffff"
		-- local r = "|r"
		-- if maxQuantity > 0 and quantity == 0 then c = ColorGray end
		-- if maxQuantity > 0 and quantity == maxQuantity then c = AddonColor end
		-- if maxQuantity ~= 0 and quantity >= 1 then
		-- collect.CurrencyID[v] = c..CompactNumberFormat(quantity)..c.."/"..CompactNumberFormat(maxQuantity)..r
		-- end
	end
end
local function Empty_Zero(number)
	if number == 0 then
		return ""
	end
	return number
end
function CollectAppliedMountEquipmentID()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local canUseMountEquipment = C_PlayerInfo.CanPlayerUseMountEquipment()
	local itemID = C_MountJournal.GetAppliedMountEquipmentID()
	collect.canUseMountEquipment = canUseMountEquipment
	collect.currentMountItemID = itemID
end
function CollectAllItemsInBag()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local usedSlots = 0
	local totalSlots = 0
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlots = totalSlots + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
		end
	end
	if collect and usedSlots > 0 and totalSlots > 0 then
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
	end
	-------------------------------------------------------------------------
	local GetBindLocation = GetBindLocation()
	local PlayerReagentnumSlots = C_Container.GetContainerNumSlots(BACKPACK_CONTAINER+NUM_BAG_SLOTS+1)
	local mapID = C_Map.GetBestMapForUnit("player")
	if mapID then
		local info = C_Map.GetMapInfo(mapID)
		local CurrentLocation= "noname"
		CurrentLocation = info.name
		if collect and not InCombatLockdown() then
			for k, v in ipairs(itemID) do
				local count = GetItemCount(v, true, true, true)
				collect.ItemsInBag[v] = count or 0
				collect.GetBindLocation = GetBindLocation
				collect.CurrentLocation = CurrentLocation
			end
			collect.PlayerReagentnumSlots = PlayerReagentnumSlots
		end
	end
end
-- local itemFragmentTable = {
-- 204075,
-- }
function CollectBankInfo()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	--REAGENTBANK_CONTAINER,BANK_CONTAINER
	--NUM_TOTAL_EQUIPPED_BAG_SLOTS+1,NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS
	local usedSlotsBANK = 0
	local totalSlotsBANK = 0
	local usedSlotsBANKREAGENT = 0
	local totalSlotsBANKREAGENT = 0
	local usedSlotsBANKBAGS = 0
	local totalSlotsBANKBAGS = 0
	for bag = BANK_CONTAINER, BANK_CONTAINER do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANK = totalSlotsBANK + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANK = usedSlotsBANK + (numSlots - numberOfFreeSlots)
		end
	end
	for bag = REAGENTBANK_CONTAINER, REAGENTBANK_CONTAINER do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANKREAGENT = totalSlotsBANKREAGENT + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANKREAGENT = usedSlotsBANKREAGENT + (numSlots - numberOfFreeSlots)
		end
	end
	for bag = NUM_TOTAL_EQUIPPED_BAG_SLOTS+1, NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANKBAGS = totalSlotsBANKBAGS + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANKBAGS = usedSlotsBANKBAGS + (numSlots - numberOfFreeSlots)
		end
	end
	-------------------------------------------------------------------------
	collect.usedSlotsBANK = usedSlotsBANK + usedSlotsBANKREAGENT + usedSlotsBANKBAGS
	collect.totalSlotsBANK = totalSlotsBANK + totalSlotsBANKREAGENT + totalSlotsBANKBAGS
end
function CollectAllReputations()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	if collect then
		for k, v in pairs(reputationID) do
			local rep = CheckReputationByRepID(v)
			collect.reputationID[v] = rep or 0
		end
	end
end
function CollectAllQuests()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	local RARE_ZARALEK_count = 0
	local RARE_OSTROV_count = 0
	local EVENTS_ZARALEK_count = 0
	for k, v in ipairs(questIDtable) do
		local qw = CheckCompletedByQuestID(v)
		collect.questIDtable[v] = qw or 0
	end
	for k, v in ipairs(RARE_ZARALEK_LIST) do
		local qw = CheckCompletedByQuestID(v)
		collect.RARE_ZARALEK_LIST[v] = qw or 0
		if CheckCompletedByQuestID(v) == AddonColor.."Done|r" and RARE_ZARALEK_count < #RARE_ZARALEK_LIST then
			RARE_ZARALEK_count = RARE_ZARALEK_count +1
		end
	end
	for k, v in ipairs(EVENTS_ZARALEK_LIST) do
		local qw = CheckCompletedByQuestID(v)
		collect.EVENTS_ZARALEK_LIST[v] = qw or 0
		if CheckCompletedByQuestID(v) == AddonColor.."Done|r" and EVENTS_ZARALEK_count < #EVENTS_ZARALEK_LIST then
			EVENTS_ZARALEK_count = EVENTS_ZARALEK_count +1
		end
	end
	for k, v in ipairs(RARE_OSTROV_LIST) do
		local qw = CheckCompletedByQuestID(v)
		collect.RARE_OSTROV_LIST[v] = qw or 0
		if CheckCompletedByQuestID(v) == AddonColor.."Done|r" and RARE_OSTROV_count < #RARE_OSTROV_LIST then
			RARE_OSTROV_count = RARE_OSTROV_count +1
		end
	end
	----------------------------------------
	collect.RARE_ZARALEK_count = RARE_ZARALEK_count
	collect.RARE_OSTROV_count = RARE_OSTROV_count
	collect.EVENTS_ZARALEK_count = EVENTS_ZARALEK_count
	collect.numShownEntries = numShownEntries
	collect.numQuests = numQuests
	collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept
end
local function tmstpDayReset(n)
	local n = n or 1
	local currTime = GetServerTime()
	local xyu = (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
	return (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
end
-- https://wago.io/fVZJC8tik
-- https://wago.io/sl3JkGN7T
local WA_Utf8Sub = function(input, size)
	local output = ""
	if type(input) ~= "string" then
		return output
	end
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then
			return output
		end
		if byte < 128 then
			output = output .. input:sub(i, i)
			size = size - 1
		elseif byte < 192 then
			output = output .. input:sub(i, i)
		elseif byte < 244 then
			output = output .. input:sub(i, i)
			size = size - 1
		end i = i + 1
	end
	while (true) do
		local byte = input:byte(i)
		if byte and byte >= 128 and byte < 192 then
			output = output .. input:sub(i, i)
		else
			break
		end
		i = i + 1
	end
	return output
end
local table_func_otrisovka = {
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		-- ТЕКС СЛЕВА
		local VivodLeft = ("|T629056:16:16:::64:64:4:60:4:60|t " .. CommunityFeastTimer())
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.Octopussy_Feast then
			VivodCent = CharInfo.Octopussy_Feast
		end
		if CharInfo.ItemsInBag[200652] ~= 0 then
			VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200652]..func_itemTexture(200652)
		end
		if CharInfo.ItemsInBag[200095] ~= 0 then
			VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200095]..func_itemTexture(200095)
		end
		if CharInfo.UnitLevel >= 58 and (CharInfo.KnownSpell[366253] == false or CharInfo.KnownSpell[366253] == 0) then
			VivodCent = VivodCent .. "|cffFF0000*|r"
		end
		return VivodCent, VivodLeft
	end,
	--2
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = "|T1603189:16:16:::64:64:4:60:4:60|t |cffFFFFFF".. func_questName(70750).."|r"
		if CharInfo.Octopussy_3kREP_IsOnQuest ~= 0 then
			tinsert(tooltip,{func_questName(CharInfo.Octopussy_3kREP_IsOnQuest)})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.Octopussy_3kREP then
			VivodCent = CharInfo.Octopussy_3kREP
		end
		if CharInfo.ItemsInBag[200073] ~= 0 then
			VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200073]..func_itemTexture(200073)
		end
		return VivodCent, VivodLeft
	end,
	--3
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_questName(75665)
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.Octopussy_AWorthyAllyLoammNiffen then
			VivodCent = CharInfo.Octopussy_AWorthyAllyLoammNiffen
		end
		return VivodCent, VivodLeft
	end,
	--4
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(180653)..func_itemName(180653)
		if CharInfo.CurrentKey ~= 0 then

			tooltip[#tooltip+1] = {"Score", CharInfo.RIO_Score}
			tooltip[#tooltip+1] = {"Weekly Best", CharInfo.RIO_weeklyBest}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Рейды", CharInfo.RIO_RAID}
			tooltip[#tooltip+1] = {"M+", CharInfo.RIO_KEYS}
			tooltip[#tooltip+1] = {"PVP", CharInfo.RIO_PVPS}


			-- tooltip[#tooltip+1] = {
			-- 	{"Score", CharInfo.RIO_Score},
			-- 	{"Weekly Best", CharInfo.RIO_weeklyBest},
			-- 	{" ", " "},
			-- 	{"Рейды", CharInfo.RIO_RAID},
			-- 	{"M+", CharInfo.RIO_KEYS},
			-- 	{"PVP", CharInfo.RIO_PVPS},
			-- }
			-- tinsert(tooltip, {"Score", CharInfo.RIO_Score})
			-- tinsert(tooltip, {"Weekly Best", CharInfo.RIO_weeklyBest})
			-- tinsert(tooltip, {" ", " "})
			-- tinsert(tooltip, {"Рейды", CharInfo.RIO_RAID})
			-- tinsert(tooltip, {"M+", CharInfo.RIO_KEYS})
			-- tinsert(tooltip, {"PVP", CharInfo.RIO_PVPS})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.CurrentKey then
			VivodCent = Empty_Zero(CharInfo.CurrentKey)
		end
		if CharInfo.ItemsInBag[205225] ~= 0 then
			VivodCent = VivodCent .. func_itemTexture(205225)..CharInfo.ItemsInBag[205225]
		end
		if CharInfo.ItemsInBag[205999] ~= 0 then
			VivodCent = VivodCent .. func_itemTexture(205999)..CharInfo.ItemsInBag[205999]
		end
		return VivodCent, VivodLeft
	end,
	--5
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""

		if CharInfo.CurrencyID[2245] ~= 0 or CharInfo.CurrencyID[2122] ~= 0 or CharInfo.CurrencyID[2118] ~= 0 or CharInfo.CurrencyID[2003] ~= 0 then
			tooltip[#tooltip+1] = {"PVE: ", " "}
		end
		if CharInfo.CurrencyID[2245] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2245)..func_currencyName(2245), CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]} --Драконьи камни
		end
		if CharInfo.CurrencyID[2122] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2122)..func_currencyName(2122), CharInfo.CurrencyID[2122]} --Печать бури
		end
		if CharInfo.CurrencyID[2118] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2118)..func_currencyName(2118), CharInfo.CurrencyID[2118]} --Энергия стихий
		end
		if CharInfo.CurrencyID[2003] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2003)..func_currencyName(2003), CharInfo.CurrencyID[2003]} --Припасы Драконьих островов
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if CharInfo.CurrencyID[1602] ~= 0 or CharInfo.CurrencyID[1792] ~= 0 or CharInfo.CurrencyID[2123] ~= 0 then
			--tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"PVP: ", " "}
		end
		if CharInfo.CurrencyID[1602] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1602)..func_currencyName(1602), CharInfo.CurrencyID[1602].."/"..CharInfo.CurrencyID_maxQuantity[1602]} --Очки завоевания
		end
		if CharInfo.CurrencyID[1792] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1792)..func_currencyName(1792), CharInfo.CurrencyID[1792].."/"..CharInfo.CurrencyID_maxQuantity[1792]} --Честь
		end
		if CharInfo.CurrencyID[2123] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2123)..func_currencyName(2123), CharInfo.CurrencyID[2123]} --Кровавые жетоны
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------


		if CharInfo.CurrencyID[2032] ~= 0 or CharInfo.CurrencyID[1166] ~= 0 or CharInfo.CurrencyID[1560] ~= 0 or CharInfo.CurrencyID[1220] ~= 0 or CharInfo.CurrencyID[824] ~= 0 then
			--tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Other: ", " "}
		end
		if CharInfo.CurrencyID[2032] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(2032)..func_currencyName(2032), func_currencyquantity(2032)}
		end
		if CharInfo.CurrencyID[1166] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1166)..func_currencyName(1166), CharInfo.CurrencyID[1166]} --Искаженный временем знак
		end
		if CharInfo.CurrencyID[1560] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1560)..func_currencyName(1560), CharInfo.CurrencyID[1560]} --Ресурсы для войны
		end
		if CharInfo.CurrencyID[1220] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1220)..func_currencyName(1220), CharInfo.CurrencyID[1220]} --Ресурсы опллота класса
		end
		if CharInfo.CurrencyID[824] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(824)..func_currencyName(824), CharInfo.CurrencyID[824].."/"..CharInfo.CurrencyID_maxQuantity[824]} --Ресурсы гарнизона
		end



		if CharInfo.CurrencyID[1580] ~= 0 or CharInfo.CurrencyID[1273] ~= 0 or CharInfo.CurrencyID[994] ~= 0  or CharInfo.CurrencyID[1129] ~= 0  or CharInfo.CurrencyID[697] ~= 0  or CharInfo.CurrencyID[776] ~= 0 then
			--tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Монетки: "," "}
		end

		if CharInfo.CurrencyID[1580] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1580).."|cff6464ffBFA|r "..func_currencyName(1580), CharInfo.CurrencyID[1580].."/"..CharInfo.CurrencyID_maxQuantity[1580]} --Печать судьбы воина
		end
		if CharInfo.CurrencyID[1273] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1273).."|cff1eff00LEG|r "..func_currencyName(1273), CharInfo.CurrencyID[1273].."/"..CharInfo.CurrencyID_maxQuantity[1273]} --Печать сломанной судьбы
		end
		if CharInfo.CurrencyID[994] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(994).."|cffc86400WoD|r "..func_currencyName(994), CharInfo.CurrencyID[994].."/"..CharInfo.CurrencyID_maxQuantity[994]} --Печать закаленной судьбы
		end
		if CharInfo.CurrencyID[1129] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(1129).."|cffc86400WoD|r "..func_currencyName(1129), CharInfo.CurrencyID[1129].."/"..CharInfo.CurrencyID_maxQuantity[1129]} --Печать закаленной судьбы
		end
		if CharInfo.CurrencyID[697] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(697).."|cff00ffbaMoP|r "..func_currencyName(697), CharInfo.CurrencyID[697].."/"..CharInfo.CurrencyID_maxQuantity[697]} --Большой амулет удачи
		end
		if CharInfo.CurrencyID[776] ~= 0 then
			tooltip[#tooltip+1] = {func_currencyicon(776).."|cff00ffbaMoP|r "..func_currencyName(776), CharInfo.CurrencyID[776].."/"..CharInfo.CurrencyID_maxQuantity[776]} --Закаленная в бою печать
		end





		-- for k,v in pairs(CharInfo.CurrencyID) do
		-- if k ~= nil and k ~= 0 then
		-- print (func_currencyicon(k)..func_currencyName(k),v.." ID: "..k)
		-- --tooltip[#tooltip+1] = {func_currencyicon(k)..func_currencyName(k), v}
		-- --tinsert (tooltip,{"name:",CharInfo.CurrencyID(k)})
		-- end
		-- end
		-- ТЕКСТ В ЦЕНТРЕ
		VivodCent = ColorGray..CURRENCY.."|r"
		if CharInfo.CurrencyID[2245] ~= 0 then
			VivodCent = func_currencyicon(2245)..Empty_Zero(CharInfo.CurrencyID[2245])
		end
		if CharInfo.CurrencyID[2245] == CharInfo.CurrencyID_maxQuantity[2245] then
			VivodCent = AddonColor..VivodCent.."|r"
		end
		return VivodCent, VivodLeft
	end,
	--6
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		if CharInfo.reputationID[2507] ~= 0 then
			tinsert(tooltip, {func_reputationName(2507), CharInfo.reputationID[2507]})
		end
		if CharInfo.reputationID[2503] ~= 0 then
			tinsert(tooltip, {func_reputationName(2503), CharInfo.reputationID[2503]})
		end
		if CharInfo.reputationID[2511] ~= 0 then
			tinsert(tooltip, {func_reputationName(2511), CharInfo.reputationID[2511]})
		end
		if CharInfo.reputationID[2510] ~= 0 then
			tinsert(tooltip, {func_reputationName(2510), CharInfo.reputationID[2510]})
		end
		if CharInfo.reputationID[2564] ~= 0 then
			tinsert(tooltip, {func_reputationName(2564), CharInfo.reputationID[2564]})
		end
		for k,v in ipairs (itemIDReputation) do
			if CharInfo.ItemsInBag[v] ~= 0 then
				tinsert(tooltip, {func_itemTexture(v)..func_itemName(v), CharInfo.ItemsInBag[v]})
			end
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.reputationID ~= 0 then
			VivodCent = ColorGray..REPUTATION.."|r"
		end
		if CharInfo.reputationID[2564] and CharInfo.reputationID[2564] ~= 0 then
			VivodCent = CharInfo.reputationID[2564]
		end
		return VivodCent, VivodLeft
	end,
	--7
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(204193)..ColorGray..PLAYER_DIFFICULTY3..", M+ 1-5|r"
		if CharInfo.ItemsInBag[204075] >= 1 then
			tinsert(tooltip, {func_itemTexture(204075)..func_itemName(204075), CharInfo.ItemsInBag[204075]})
		end
		if (CharInfo.ItemsInBag[204193] ~= 0 or CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.CurrencyID[2409] ~= 0) and CharInfo.CurrencyID_maxQuantity[2409] ~= 0 then
			tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.ItemsInBag[204193] >= 1 then
			tinsert(tooltip, {func_itemTexture(204193)..func_itemName(204193), CharInfo.ItemsInBag[204193]})
			VivodCent = "|cff1eff00"..CharInfo.ItemsInBag[204193].."|r"
		end
		if CharInfo.ItemsInBag[204075] >= 15 then
			VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204075]/15)..")"
		end
		if CharInfo.CurrencyID[2409] ~= 0 and (CharInfo.CurrencyID[2409] == CharInfo.CurrencyID_maxQuantity[2409]) then
			VivodCent = VivodCent..AddonColor.."*|r"
		end
		return VivodCent, VivodLeft
	end,
	--8
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(204195)..ColorGray..PLAYER_DIFFICULTY1..", M+ 6-10|r"
		if CharInfo.ItemsInBag[204076] >= 1 then
			tinsert(tooltip, {func_itemTexture(204076)..func_itemName(204076), CharInfo.ItemsInBag[204076]})
		end
		if (CharInfo.ItemsInBag[204195] ~= 0 or CharInfo.ItemsInBag[204076] ~= 0 or CharInfo.CurrencyID[2410] ~= 0) and CharInfo.CurrencyID_maxQuantity[2410] ~= 0 then
			tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.ItemsInBag[204195] >= 1 then
			tinsert(tooltip, {func_itemTexture(204195)..func_itemName(204195), CharInfo.ItemsInBag[204195]})
			VivodCent = "|cff0070dd"..CharInfo.ItemsInBag[204195].."|r"
		end
		if CharInfo.ItemsInBag[204076] >= 15 then
			VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204076]/15)..")"
		end
		if CharInfo.CurrencyID[2410] ~= 0 and (CharInfo.CurrencyID[2410] == CharInfo.CurrencyID_maxQuantity[2410]) then
			VivodCent = VivodCent..AddonColor.."*|r"
		end
		return VivodCent, VivodLeft
	end,
	--9
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(204196)..ColorGray..PLAYER_DIFFICULTY2..", M+ 11-15|r"
		if CharInfo.ItemsInBag[204077] >= 1 then
			tinsert(tooltip, {func_itemTexture(204077)..func_itemName(204077), CharInfo.ItemsInBag[204077]})
		end
		if (CharInfo.ItemsInBag[204196] ~= 0 or CharInfo.ItemsInBag[204077] ~= 0 or CharInfo.CurrencyID[2411] ~= 0) and CharInfo.CurrencyID_maxQuantity[2411] ~= 0 then
			tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.ItemsInBag[204196] >= 1 then
			tinsert(tooltip, {func_itemTexture(204196)..func_itemName(204196), CharInfo.ItemsInBag[204196]})
			VivodCent = "|cffa335ee"..CharInfo.ItemsInBag[204196].."|r"
		end
		if CharInfo.ItemsInBag[204077] >= 15 then
			VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204077]/15)..")"
		end
		if CharInfo.CurrencyID[2411] ~= 0 and (CharInfo.CurrencyID[2411] == CharInfo.CurrencyID_maxQuantity[2411]) then
			VivodCent = VivodCent..AddonColor.."*|r"
		end
		return VivodCent, VivodLeft
	end,
	--10
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(204194)..ColorGray..PLAYER_DIFFICULTY6..", M+ 16+|r"
		if CharInfo.ItemsInBag[204078] >= 1 then
			tinsert(tooltip, {func_itemTexture(204078)..func_itemName(204078), CharInfo.ItemsInBag[204078]})
		end
		if (CharInfo.ItemsInBag[204194] ~= 0 or CharInfo.ItemsInBag[204078] ~= 0 or CharInfo.CurrencyID[2412] ~= 0) and CharInfo.CurrencyID_maxQuantity[2412] ~= 0 then
			tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.ItemsInBag[204194] >= 1 then
			tinsert(tooltip, {func_itemTexture(204194)..func_itemName(204194), CharInfo.ItemsInBag[204194]})
			VivodCent = "|cffff8000"..CharInfo.ItemsInBag[204194].."|r"
		end
		if CharInfo.ItemsInBag[204078] >= 15 then
			VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204078]/15)..")"
		end
		if CharInfo.CurrencyID[2412] ~= 0 and (CharInfo.CurrencyID[2412] == CharInfo.CurrencyID_maxQuantity[2412]) then
			VivodCent = VivodCent..AddonColor.."*|r"
		end
		return VivodCent, VivodLeft
	end,
	--11
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_itemTexture(204440)..func_itemName(204440)
		-- {func_itemName_NOCOLOR(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440]},
		-- {func_itemName_NOCOLOR(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717]},
		-- {func_itemName_NOCOLOR(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681]},
		-- {func_itemName_NOCOLOR(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682]},
		-- {func_itemName_NOCOLOR(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697]},
		if CharInfo.ItemsInBag[204440] ~= 0 then tinsert(tooltip, {func_itemName(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440]}) end
		if CharInfo.ItemsInBag[204717] ~= 0 then tinsert(tooltip, {func_itemName(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717]}) end
		if CharInfo.ItemsInBag[204681] ~= 0 then tinsert(tooltip, {func_itemName(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681]}) end
		if CharInfo.ItemsInBag[204682] ~= 0 then tinsert(tooltip, {func_itemName(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682]}) end
		if CharInfo.ItemsInBag[204697] ~= 0 then tinsert(tooltip, {func_itemName(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697]}) end
		-- if CharInfo.ItemsInBag[204440] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440].."|r"}) end
		-- if CharInfo.ItemsInBag[204717] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717].."|r"}) end
		-- if CharInfo.ItemsInBag[204681] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681].."|r"}) end
		-- if CharInfo.ItemsInBag[204682] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682].."|r"}) end
		-- if CharInfo.ItemsInBag[204697] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697].."|r"}) end
		-- if CharInfo.ItemsInBag[204440] >= 1 then
		-- CL:SetText(VivodCent)
		-- end
		-- if CharInfo.ItemsInBag[204717] >=1 then
		-- tooltip = {{func_itemTexture(204717)..func_itemName(204717), CharInfo.ItemsInBag[204717]}, }
		-- end
		-- if CharInfo.ItemsInBag[204717] >=2 then
		-- CL:SetText(VivodCent.."|cffFF00FF(+"..(math.floor(CharInfo.ItemsInBag[204717]/2)) ..")|r")
		-- end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.ItemsInBag[204440] >= 1 then
			VivodCent = VivodCent..func_itemTexture(204440)..CharInfo.ItemsInBag[204440]
		end
		if CharInfo.ItemsInBag[204717] >= 1 then
			VivodCent = VivodCent..func_itemTexture(204717)..CharInfo.ItemsInBag[204717]
		end
		if CharInfo.ItemsInBag[204681] >= 1 then
			VivodCent = VivodCent..func_itemTexture(204681)..CharInfo.ItemsInBag[204681]
		end
		if CharInfo.ItemsInBag[204682] >= 1 then
			VivodCent = VivodCent..func_itemTexture(204682)..CharInfo.ItemsInBag[204682]
		end
		if CharInfo.ItemsInBag[204697] >= 1 then
			VivodCent = VivodCent..func_itemTexture(204697)..CharInfo.ItemsInBag[204697]
		end
		return VivodCent, VivodLeft
	end,
	--12
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		VivodLeft = func_currencyicon(2533)..func_currencyName(2533)
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.CurrencyID[2533] >= 1 then
			VivodCent = func_currencyicon(2533)..CharInfo.CurrencyID[2533]
		end
		-- if CharInfo.questIDtable[75497] == "|cff00FF00Done|r" then
		-- 	VivodCent = VivodCent .. "*"
		-- end
		return VivodCent, VivodLeft
	end,
	--13
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		if CharInfo.prof1 ~= 0 or CharInfo.prof2 ~= 0 then
				tooltip[#tooltip+1]= {Empty_Zero(CharInfo.profID_prof1.icon).."|cffa335ee"..Empty_Zero(CharInfo.profID_prof1.name).."|r"}
				tooltip[#tooltip+1]= {"Сундуки", CharInfo.profID_prof1.chest.chest_count_prof1.."/"..CharInfo.profID_prof1.chest.questReq}
				tooltip[#tooltip+1]= {"Лут", CharInfo.profID_prof1.drops.drops_count_prof1.."/"..CharInfo.profID_prof1.drops.questReq}
				tooltip[#tooltip+1]= {"Квест", CharInfo.profID_prof1.profQuest.profQuest_count_prof1.."/"..CharInfo.profID_prof1.profQuest.questReq}
				tooltip[#tooltip+1]= {"Трактаты", CharInfo.profID_prof1.treatise.treatise_count_prof1.."/"..CharInfo.profID_prof1.treatise.questReq}
				tooltip[#tooltip+1]= {"Крафт", CharInfo.profID_prof1.craftOrder.craftOrder_count_prof1.."/"..CharInfo.profID_prof1.craftOrder.questReq}
				tooltip[#tooltip+1]= {" ", " "}
				tooltip[#tooltip+1]= {Empty_Zero(CharInfo.profID_prof2.icon).."|cffa335ee"..Empty_Zero(CharInfo.profID_prof2.name).."|r"}
				tooltip[#tooltip+1]= {"Сундуки", CharInfo.profID_prof2.chest.chest_count_prof2.."/"..CharInfo.profID_prof2.chest.questReq}
				tooltip[#tooltip+1]= {"Лут", CharInfo.profID_prof2.drops.drops_count_prof2.."/"..CharInfo.profID_prof2.drops.questReq}
				tooltip[#tooltip+1]= {"Квест", CharInfo.profID_prof2.profQuest.profQuest_count_prof2.."/"..CharInfo.profID_prof2.profQuest.questReq}
				tooltip[#tooltip+1]= {"Трактаты", CharInfo.profID_prof2.treatise.treatise_count_prof2.."/"..CharInfo.profID_prof2.treatise.questReq}
				tooltip[#tooltip+1]= {"Крафт", CharInfo.profID_prof2.craftOrder.craftOrder_count_prof2.."/"..CharInfo.profID_prof2.craftOrder.questReq}
				tooltip[#tooltip+1]= {" ", " "}
		end
		if CharInfo.ItemsInBag[204186] >= 1 then tinsert(tooltip, {func_itemTexture(204186)..func_itemName(204186), CharInfo.ItemsInBag[204186]}) end
		if CharInfo.ItemsInBag[204187] >= 1 then tinsert(tooltip, {func_itemTexture(204187)..func_itemName(204187), CharInfo.ItemsInBag[204187]}) end
		if CharInfo.ItemsInBag[204188] >= 1 then tinsert(tooltip, {func_itemTexture(204188)..func_itemName(204188), CharInfo.ItemsInBag[204188]}) end
		if CharInfo.ItemsInBag[190453] >= 1 then tinsert(tooltip, {func_itemTexture(190453)..func_itemName(190453), CharInfo.ItemsInBag[190453]}) end
		if CharInfo.ItemsInBag[191784] >= 1 then tinsert(tooltip, {func_itemTexture(191784)..func_itemName(191784), CharInfo.ItemsInBag[191784]}) end
		if CharInfo.ItemsInBag[204985] >= 1 then tinsert(tooltip, {func_itemTexture(204985)..func_itemName(204985), CharInfo.ItemsInBag[204985]}) end
		if CharInfo.ItemsInBag[204715] >= 1 then tinsert(tooltip, {func_itemTexture(204715)..func_itemName(204715), CharInfo.ItemsInBag[204715]}) end
		if CharInfo.ItemsInBag[190456] >= 1 then tinsert(tooltip, {func_itemTexture(190456)..func_itemName(190456), CharInfo.ItemsInBag[190456]}) end
		if CharInfo.ItemsInBag[199197] >= 1 then tinsert(tooltip, {func_itemTexture(199197)..func_itemName(199197), CharInfo.ItemsInBag[199197]}) end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.profID_prof1.icon ~= 0 then
			VivodCent = CharInfo.profID_prof1.icon
		end
		if CharInfo.profID_prof2.icon ~= 0 then
			VivodCent = VivodCent.. " "..CharInfo.profID_prof2.icon
		end
		return VivodCent, VivodLeft
	end,
	--14
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		local tinsertTABLE = {
			-- {name = func_questName(72528), data=CheckCompletedByQuestID(72528)}, --БУДУЩИЙ КАТАЛИЗАТОР
			-- {name = TreasureGoblinTimer(), data=CharInfo.Octopussy_TreasureGoblin},
			{name = ToDragonbaneKeepTimer(), data=CharInfo.Octopussy_DragonbaneKeep},
			{name = GrandHuntsTimer(), data=CharInfo.Octopussy_TheGrandHunt},
			{name = CommunityFeastTimer(), data=CharInfo.Octopussy_Feast},
			{name = PrimalStormsTimer(), data=CharInfo.Octopussy_StormsFury},
			{name = ResearchersUnderFireTimer(), data = CharInfo.Octopussy_ResearchersUnderFire},
			{name = func_questName(70750), data=CharInfo.Octopussy_3kREP}, --"Помощь союзу"
			{name ="", data =""},
			{name = "WORLD BOSS", data=CharInfo.Octopussy_WB}, --"CharInfo.Octopussy_WB"
			{name = "WORLD BOSS "..func_questName(74892), data=CharInfo.Octopussy_WB_NEW},
			{name = PLAYER_DIFFICULTY_TIMEWALKER.."(500 currency)", data=CharInfo.Octopussy_Timewalk500CURRENCY}, --
			{name = PLAYER_DIFFICULTY_TIMEWALKER.."(5 dungeon)", data=CharInfo.Octopussy_Timewalk5DUNGEONS}, --
			{name = CALENDAR_FILTER_WEEKLY_HOLIDAYS, data=CharInfo.Octopussy_WeekendEvent}, --"CharInfo.Octopussy_WeekendEvent"
			{name = func_questName(76122), data=CharInfo.Octopussy_FightingisItsOwnReward},
			{name = func_questName(75665), data=CharInfo.Octopussy_AWorthyAllyLoammNiffen},
			{name = L["Fyrakk Asssaults (Local)"], data = CharInfo.Octopussy_FyrakkAssaults},
		}
		if CharInfo.UnitLevel >= 70 then
			local questID = 75459
			local countSniffen = 0
			if CharInfo.questIDtable[75459] == "|cff00FF00Done|r" then
				questID = 76027 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[76027] == "|cff00FF00Done|r" then
				questID = 75621 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75621] == "|cff00FF00Done|r" then
				questID = 75397 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75397] == "|cff00FF00Done|r" then
				questID = 75517 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75517] == "|cff00FF00Done|r" then
				questID = 75619 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75619] == "|cff00FF00Done|r" then
				questID = 76014 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[76014] == "|cff00FF00Done|r" then
				questID = 75620 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75620] == "|cff00FF00Done|r" then
				questID = 76081 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[76081] == "|cff00FF00Done|r" then
				questID = 75390 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75390] == "|cff00FF00Done|r" then
				questID = 75234 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75234] == "|cff00FF00Done|r" then
				questID = 75516 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75516] == "|cff00FF00Done|r" then
				questID = 75996 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75996] == "|cff00FF00Done|r" then
				questID = 76016 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[76016] == "|cff00FF00Done|r" then
				questID = 75393 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[75393] == "|cff00FF00Done|r" then
				questID = 76015 countSniffen = countSniffen + 1
			end
			if CharInfo.questIDtable[76015] == "|cff00FF00Done|r" then
				questID = 76084 countSniffen = countSniffen + 1
			end
			tinsert(tinsertTABLE,{name = "Раскопки с Мирратом", data = "|cffc9c3aa"..countSniffen.."/17|r"})
		end
		if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" --[[and CharInfo.UnitLevel >= 30]] then
			local questID = 24545
			local countShadowmourne = 1
			if CharInfo.questIDtable[24545] == "|cff00FF00Done|r" then
				questID = 24743 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24743] == "|cff00FF00Done|r" then
				questID = 24547 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24547] == "|cff00FF00Done|r" then
				questID = 24749 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24749] == "|cff00FF00Done|r" then
				questID = 24756 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24756] == "|cff00FF00Done|r" then
				questID = 24757 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24757] == "|cff00FF00Done|r" then
				questID = 24548 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24548] == "|cff00FF00Done|r" then
				questID = 24549 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[24549] == "|cff00FF00Done|r" then
				questID = 24748 countShadowmourne = countShadowmourne + 1
			end
			tinsert(tinsertTABLE,{name = " "," "})
			tinsert(tinsertTABLE,{name = "|cff00A3FFКлассовые задания:|r"," "})
			tinsert(tinsertTABLE,{name = countShadowmourne.."/9 "..func_questName(questID), data = CharInfo.questIDtable[questID]})
		end
		if CharInfo.classFilename == "WARLOCK" --[[and CharInfo.UnitLevel >= 35]] then
			local questID = 32295
			local countShadowmourne = 1
			if CharInfo.questIDtable[32295] == "|cff00FF00Done|r" then
				questID = 32307 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[32307] == "|cff00FF00Done|r" and CharInfo.Faction == "Horde" then
				questID = 32309 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[32307] == "|cff00FF00Done|r" and CharInfo.Faction == "Alliance" then
				questID = 32310 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[32309] == "|cff00FF00Done|r" or CharInfo.questIDtable[32310] == "|cff00FF00Done|r" then
				questID = 32317 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[32317] == "|cff00FF00Done|r" then
				questID = 32324 countShadowmourne = countShadowmourne + 1
			end
			if CharInfo.questIDtable[32324] == "|cff00FF00Done|r" then
				questID = 32325 countShadowmourne = countShadowmourne + 1
			end
			tinsert(tinsertTABLE,{name = " "," "})
			tinsert(tinsertTABLE,{name = "|cff00A3FFКлассовые задания:|r"," "})
			tinsert(tinsertTABLE,{name = countShadowmourne.."/6 "..func_questName(questID), data = CharInfo.questIDtable[questID]})
		end
		for k, v in ipairs(tinsertTABLE) do
			color = "|cffc9c3aa"
			-- if v.data == "|cff00FF00Done|r" then
			-- color = AddonColor
			-- end
			tinsert(tooltip, {color..v.name.."|r", v.data})
		end
		-- for k, v in ipairs(questIDtable) do
		-- if CharInfo.questIDtable[v] ~= "" and CharInfo.questIDtable[v] ~= 0 then
		-- tinsert(tooltip, {func_questName(v), CharInfo.questIDtable[v]})
		-- end
		-- end
		-- ТЕКСТ В ЦЕНТРЕ
		VivodCent = ColorGray..QUESTS_LABEL.."|r"
		return VivodCent, VivodLeft
	end,
	--15
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		-- CL:SetText(func_itemTexture(190453)..Empty_Zero(CharInfo.ItemsInBag[190453]))
		-- if CharInfo.ItemsInBag[199197] ~= 0 then CL:SetText("|cffFF00FF"..func_itemTexture(190453)..CharInfo.ItemsInBag[190453].." (+"..CharInfo.ItemsInBag[199197]..")|r") end
		tooltip[#tooltip+1] = {" "," "}
		for k, v in ipairs(CharInfo.VOID_STORAGE_PAGE1) do
			if v ~= 0 then
				tooltip[#tooltip+1] = {func_itemTexture(CharInfo.VOID_STORAGE_PAGE1[k])..func_itemName(CharInfo.VOID_STORAGE_PAGE1[k])}
			end
		end
		for k, v in ipairs(CharInfo.VOID_STORAGE_PAGE2) do
			if v ~= 0 then
				tinsert(tooltip,{func_itemTexture(CharInfo.VOID_STORAGE_PAGE2[k])..func_itemName(CharInfo.VOID_STORAGE_PAGE2[k])})
			end
		end
		-- ТЕКСТ В ЦЕНТРЕ
		for k, v in ipairs(itemID) do
			local count = tonumber(CharInfo.ItemsInBag[v])
			if count ~= 0 then
				--if CharInfo.ItemsInBag[190453] == 0 and CharInfo.ItemsInBag[199197] == 0 then CL:SetText(ColorGray..ITEMS.."|r") end
				VivodCent = ColorGray..ITEMS.."|r"
				tooltip[#tooltip+1] = {func_itemTexture(v)..func_itemName(v), count}
			end
		end
		return VivodCent, VivodLeft
	end,
	--16
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		--CL:SetText(format("|cff%s%.1f|r", CharInfo.avgItemLevel >= 430 and "00ff00" or CharInfo.avgItemLevel >= 400 and "ffff00" or "ff0000", CharInfo.avgItemLevel))
		VivodLeft = LFG_LIST_ITEM_LEVEL_INSTR_SHORT
		local pvpcolor = "|cffFF0000"
		if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
			if CharInfo.avgItemLevelEquipped > 440 then
				pvpcolor = "|cff4FFF79"
			elseif CharInfo.avgItemLevelEquipped > 400 then
				pvpcolor = "|cffFFF371"
			end
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
			VivodCent = pvpcolor..CharInfo.avgItemLevelEquipped
			if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
				VivodCent = VivodCent.."/"..CharInfo.avgItemLevel.."|r"
			end
			if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
				VivodCent = VivodCent..AddonColor.."*|r"
				tinsert(tooltip, {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)})
			end
		end
		return VivodCent, VivodLeft
	end,
	--17
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		local curServerShort = GetRealmName()
		local text = (curServerShort):gsub("-", " "):gsub("'", " ")
		local a, b = strsplit(" ", text)
		if b then
			curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
		end
		-- CL:SetFont(curFontTTF, curFontSize-1, curFontOutline)
		VivodLeft = curServerShort..": "..GetCoinTextureString(TotalMoney-TotalMoney % 10000)
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.Money then
			VivodCent = GetCoinTextureString(CharInfo.Money - CharInfo.Money % 10000) or 0
		end
		if CharInfo.Money - CharInfo.Money % 10000 < 10000000 then -- меньше тысячи
			VivodCent = ColorGray..VivodCent.."|r"
		end
		if CharInfo.PlayerReagentnumSlots == 0 then VivodCent = VivodCent.."|cffFF0000*|r" end
		return VivodCent, VivodLeft
	end,
	--18
	function(CharInfo, tooltip, CL)
		local VivodLeft, VivodCent = "", ""
		if TotalMoneyAllServer > TotalMoney and CharInfo.Money ~= 0 then
			VivodLeft = "Всего: "..GetCoinTextureString(TotalMoneyAllServer-TotalMoneyAllServer%10000)
		end
		if CharInfo.currentMountItemID ~= 0 then
			tinsert(tooltip, {func_itemTexture(CharInfo.currentMountItemID)..func_itemName(CharInfo.currentMountItemID)})
		end
		if CharInfo.CurrentLocation then
			tinsert(tooltip, {L["Current Location"],CharInfo.CurrentLocation})
		end
		if CharInfo.maxNumQuestsCanAccept ~= 0 then
			tinsert(tooltip, {QUESTS_LABEL,CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept})
		end
		if CharInfo.totalSlots ~= 0 then
			tinsert(tooltip, {L["Bags"],CharInfo.usedSlots.."/"..CharInfo.totalSlots})
		end
		if CharInfo.totalSlotsBANK ~= 0 then
			tinsert(tooltip, {L["Bank"],CharInfo.usedSlotsBANK.."/"..CharInfo.totalSlotsBANK})
		end
		-- ТЕКСТ В ЦЕНТРЕ
		if CharInfo.pizdaDate ~= 0 and CharInfo.pizdaDate ~= 0 then
			CL:SetFont(curFontTTF, curFontSize-1, curFontOutline)
			VivodCent = (CharInfo.needReset and "|cffFF0000" or "|cffFFFFFF")..CharInfo.pizdaDate.."\n"..CharInfo.pizdaHours
		end
		return VivodCent, VivodLeft
	end,
}
function Octo_ToDo_DragonflyOnLoad()
	EventFrame = CreateFrame("FRAME", AddonTitle..GenerateUniqueID())
	EventFrame:RegisterEvent("VARIABLES_LOADED")
	EventFrame:RegisterEvent("PLAYER_LOGIN")
	EventFrame:RegisterEvent("PLAYER_MONEY")
	EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	EventFrame:RegisterEvent("BAG_UPDATE")
	EventFrame:RegisterEvent("HEARTHSTONE_BOUND")
	EventFrame:RegisterEvent("ZONE_CHANGED")
	EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	EventFrame:RegisterEvent("QUEST_FINISHED")
	EventFrame:RegisterEvent("QUEST_COMPLETE")
	EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	EventFrame:RegisterEvent("PLAYER_LOGOUT")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EventFrame:RegisterEvent("COVENANT_CHOSEN")
	EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	EventFrame:RegisterEvent("BANKFRAME_OPENED")
	EventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	EventFrame:RegisterEvent("VOID_STORAGE_UPDATE")
	EventFrame:RegisterEvent("VOID_STORAGE_CONTENTS_UPDATE")
	EventFrame:RegisterEvent("VOID_TRANSFER_DONE")
	EventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
	EventFrame:RegisterEvent("SPELLS_CHANGED")
	EventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	-- -- EventFrame:RegisterEvent("VARIABLES_LOADED")
	-- EventFrame:RegisterEvent("ARENA_SEASON_WORLD_STATE")
	-- EventFrame:RegisterEvent("BATTLEFIELDS_CLOSED")
	-- EventFrame:RegisterEvent("BATTLEFIELDS_SHOW")
	-- EventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	-- EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	-- EventFrame:RegisterEvent("HONOR_LEVEL_UPDATE")
	-- EventFrame:RegisterEvent("HONOR_XP_UPDATE")
	-- EventFrame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
	-- EventFrame:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
	-- EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
	-- EventFrame:RegisterEvent("PVP_BRAWL_INFO_UPDATED")
	-- EventFrame:RegisterEvent("PVP_RATED_STATS_UPDATE")
	-- EventFrame:RegisterEvent("PVP_REWARDS_UPDATE")
	-- EventFrame:RegisterEvent("PVP_ROLE_UPDATE")
	-- EventFrame:RegisterEvent("PVP_TYPES_ENABLED")
	-- EventFrame:RegisterEvent("PVP_WORLDSTATE_UPDATE")
	-- EventFrame:RegisterEvent("PVPQUEUE_ANYWHERE_SHOW")
	-- EventFrame:RegisterEvent("PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE")
	-- EventFrame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	-- EventFrame:RegisterEvent("WEEKLY_REWARDS_ITEM_CHANGED")
	-- EventFrame:RegisterEvent("WEEKLY_REWARDS_UPDATE")
	-- EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	-- EventFrame:RegisterEvent("ZONE_CHANGED")
	local group = EventFrame:CreateAnimationGroup()
	-- group:SetScript('OnFinished', function() group:Play() end)
	-- group:Play()
	EventFrame:SetScript("OnEvent", function(...) Octo_ToDo_DragonflyOnEvent(...) end)
end
function UPGRADERANKS_Frame()
	UPGRADERANKS_Frame = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), UIParent, "BackdropTemplate")
	UPGRADERANKS_Frame:SetFrameStrata("FULLSCREEN")
	UPGRADERANKS_Frame:SetWidth(1024*scale*0.7111111111111111) -- Set these to whatever height/width is needed
	UPGRADERANKS_Frame:SetHeight(512*scale*0.7111111111111111) -- for your Texture
	UPGRADERANKS_Frame:SetBackdrop({
			-- bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 3,
	})
	UPGRADERANKS_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	UPGRADERANKS_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	local t = UPGRADERANKS_Frame:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\UPGRADERANKS.tga")
	t:SetAllPoints(UPGRADERANKS_Frame)
	UPGRADERANKS_Frame.texture = t
	UPGRADERANKS_Frame:SetPoint("CENTER", 0, 0)
	UPGRADERANKS_Frame:Hide()
end
-- local function CreateFrameUsableItems_OnEnter(self)
-- self.icon:SetVertexColor(1, 1, 1, 1)
-- end
-- local function CreateFrameUsableItems_OnLeave(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
-- GameTooltip:ClearLines()
-- GameTooltip:Hide()
-- end
-- local function CreateFrameUsableItems_OnEvent(self,event)
-- if event == "BAG_UPDATE" then
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetDesaturated(sufficiently)
-- self.icon:SetAlpha(sufficiently and .1 or 1)
-- elseif event == "PLAYER_REGEN_DISABLED" then
-- self:SetParent(UIParent)
-- self:ClearAllPoints()
-- self:Hide()
-- else
-- self:SetParent(Main_Frame)
-- self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
-- self:Show()
-- end
-- end
-- local function CreateFrameUsableItems_OnMouseDown(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 0, 0, sufficiently and .1 or 1)
-- end
-- local function CreateFrameUsableItems_OnMouseUp(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
-- end
-- local function CreateFrameUsableItems(itemID, Texture, count, Ypos, r, g, b)
-- local Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
-- Button.itemID = itemID
-- Button.Texture = Texture
-- Button.count = count
-- Button.Ypos = Ypos
-- -- Button.r = r
-- -- Button.g = g
-- -- Button.b = b
-- Button:SetSize(curHeight, curHeight)
-- Button:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, Ypos)
-- Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
-- Button:SetBackdropBorderColor(r, g, b, 0.2)
-- Button:RegisterEvent("PLAYER_REGEN_DISABLED")
-- Button:RegisterEvent("PLAYER_REGEN_ENABLED")
-- Button:RegisterEvent("BAG_UPDATE")
-- Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
-- Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
-- Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
-- Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
-- Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
-- Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
-- Button:SetAttribute("type", "macro")
-- Button:SetAttribute("macrotext", "/use item:"..itemID)
-- local t = Button:CreateTexture(nil, "BACKGROUND")
-- Button.icon = t
-- t:SetTexture(Texture)--select(10, GetItemInfo(itemID)))
-- t:SetVertexColor(1, 1, 1, 1)
-- t:SetAllPoints(Button)
-- Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
-- return Button
-- end
local function CreateFrameExpansion_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameExpansion_OnLeave(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
end
local function CreateFrameExpansion_OnEvent(self,event)
	if event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(Main_Frame)
		self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
		self:Show()
	end
end
local function CreateFrameExpansion_OnMouseDown(self)
	self.icon:SetVertexColor(1, 0, 0, 1)
end
local function CreateFrameExpansion_OnMouseUp(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameExpansion(Expansion, Texture, Ypos, r, g, b)
	Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
	Button.Expansion = Expansion
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button:SetSize(curHeight, curHeight)
	Button:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, Ypos)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Button:SetBackdropBorderColor(r, g, b, 0.2)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:RegisterEvent("BAG_UPDATE")
	Button:HookScript("OnEvent", CreateFrameExpansion_OnEvent)
	Button:HookScript("OnEnter", CreateFrameExpansion_OnEnter)
	Button:HookScript("OnLeave", CreateFrameExpansion_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameExpansion_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameExpansion_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	-- Button:SetAttribute("type", "macro")
	-- Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)--select(10, GetItemInfo(itemID)))
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
	return Button
end
function Octo_ToDo_DragonflyCreateAltFrame()
	Main_Frame = CreateFrame("BUTTON", AddonTitle..GenerateUniqueID(), UIParent, "BackdropTemplate")
	Main_Frame:SetClampedToScreen(false)
	Main_Frame:SetFrameStrata("DIALOG")
	Main_Frame:SetPoint("TOP", 0, -200*scale)
	Main_Frame:SetBackdrop({
			--elvui
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
			--Стандартный
			-- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			-- edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			-- edgeSize = 16,
			-- insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	Main_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	--elvui
	Main_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	Main_Frame:SetScript("OnShow", function() Octo_ToDo_DragonflyAddDataToAltFrame()
	end)
	Main_Frame:EnableMouse(true)
	Main_Frame:SetMovable(true)
	Main_Frame:RegisterForDrag("LeftButton")
	Main_Frame:SetScript("OnDragStart", Main_Frame.StartMoving)
	Main_Frame:SetScript("OnDragStop", function() Main_Frame:StopMovingOrSizing() end)
	Main_Frame:RegisterForClicks("RightButtonUp")
	Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	--CloseButton
	Main_Frame.CloseButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.CloseButton:SetSize(curHeight, curHeight)
	Main_Frame.CloseButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, 0)
	Main_Frame.CloseButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.CloseButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(CLOSE) -- "Title"
			GameTooltip:Show()
	end)
	Main_Frame.CloseButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.CloseButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.CloseButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.CloseButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.CloseButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.CloseButton)
	Main_Frame.CloseButton:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:GetParent():Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	--OptionsButton
	Main_Frame.OptionsButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.OptionsButton:SetSize(curHeight, curHeight)
	Main_Frame.OptionsButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -30)
	Main_Frame.OptionsButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.OptionsButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			--GameTooltip:ClearLines()
			GameTooltip:AddLine(OPTIONS) -- "Title"
			GameTooltip:Show()
	end)
	Main_Frame.OptionsButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			--GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.OptionsButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.OptionsButton:SetScript("OnClick", function()
			if Main_Frame and Main_Frame:IsShown() then
				Main_Frame:Hide()
			end
			if SettingsPanel:IsVisible() and self:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(GlobalAddonName, true)
			end
	end)
	local t = Main_Frame.OptionsButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.OptionsButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\OptionsButton.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.OptionsButton)
	-----------------------------------------------------
	Main_Frame.TestButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.TestButton:SetSize(curHeight, curHeight)
	Main_Frame.TestButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -60)
	Main_Frame.TestButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.TestButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.TestButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			--GameTooltip:AddLine("ToDragonbaneKeepTimer") -- "Title"
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:AddDoubleLine("0","398")
			GameTooltip:AddDoubleLine("|cffa335ee2|r","|cffa335ee402|r")
			GameTooltip:AddDoubleLine("|cffa335ee3|r","|cffa335ee405|r")
			GameTooltip:AddDoubleLine("|cffa335ee4|r","|cffa335ee405|r")
			GameTooltip:AddDoubleLine("|cffa335ee5|r","|cffa335ee408|r")
			GameTooltip:AddDoubleLine("|cffa335ee6|r","|cffa335ee408|r")
			GameTooltip:AddDoubleLine("|cffa335ee7|r","|cffa335ee411|r")
			GameTooltip:AddDoubleLine("|cffa335ee8|r","|cffa335ee411|r")
			GameTooltip:AddDoubleLine("|cffa335ee9|r","|cffa335ee415|r")
			GameTooltip:AddDoubleLine("|cffff800010|r","|cffff8000415|r")
			GameTooltip:AddDoubleLine("|cffff800011|r","|cffff8000418|r")
			GameTooltip:AddDoubleLine("|cffff800012|r","|cffff8000418|r")
			GameTooltip:AddDoubleLine("|cffff800013|r","|cffff8000421|r")
			GameTooltip:AddDoubleLine("|cffff800014|r","|cffff8000421|r")
			GameTooltip:AddDoubleLine("|cffff800015|r","|cffff8000424|r")
			GameTooltip:AddDoubleLine("|cffff800016|r","|cffff8000424|r")
			GameTooltip:AddDoubleLine("|cffd9cc8017|r","|cffd9cc80428|r")
			GameTooltip:AddDoubleLine("|cffd9cc8018|r","|cffd9cc80428|r")
			GameTooltip:AddDoubleLine("|cffd9cc8019|r","|cffd9cc80431|r")
			GameTooltip:AddDoubleLine("|cffd9cc8020|r","|cffd9cc80431|r")
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
			UPGRADERANKS_Frame:Show()
	end)
	Main_Frame.TestButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
			UPGRADERANKS_Frame:Hide()
	end)
	Main_Frame.TestButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.TestButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.TestButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.TestButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow5.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.TestButton)
	-----------------------------------------------------
	Main_Frame.MarkOfHonor_Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.MarkOfHonor_Button:SetSize(curHeight, curHeight)
	Main_Frame.MarkOfHonor_Button:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -90)
	Main_Frame.MarkOfHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.MarkOfHonor_Button:SetBackdropBorderColor(0, 0.44, 0.98, 1)
	Main_Frame.MarkOfHonor_Button:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[137642] and CharInfo.ItemsInBag[137642] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[137642])
					-- else
					-- Main_Frame.MarkOfHonor_Button:Hide()
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(0, 0.44, 0.98, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.MarkOfHonor_Button:CreateTexture(nil, "BACKGROUND")
	Main_Frame.MarkOfHonor_Button.icon = t
	t:SetTexture(1322720)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.MarkOfHonor_Button)
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.ZskeraVaultKeyButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.ZskeraVaultKeyButton:SetSize(curHeight, curHeight)
	Main_Frame.ZskeraVaultKeyButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -120)
	Main_Frame.ZskeraVaultKeyButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.ZskeraVaultKeyButton:SetBackdropBorderColor(.64, .21, .93, 1)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[202196] and CharInfo.ItemsInBag[202196] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[202196])
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(.64, .21, .93, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, .5)
			self.icon:SetVertexColor(1, 0, 0, .5)
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.ZskeraVaultKeyButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.ZskeraVaultKeyButton.icon = t
	t:SetTexture(4909720)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.ZskeraVaultKeyButton)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.ShadowflameEssenceButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.ShadowflameEssenceButton:SetSize(curHeight, curHeight)
	Main_Frame.ShadowflameEssenceButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -150)
	Main_Frame.ShadowflameEssenceButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.ShadowflameEssenceButton:SetBackdropBorderColor(.64, .21, .93, 1)
	Main_Frame.ShadowflameEssenceButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[204464] and CharInfo.ItemsInBag[204464] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[204464])
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.ShadowflameEssenceButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(.64, .21, .93, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.ShadowflameEssenceButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, .5)
			self.icon:SetVertexColor(1, 0, 0, .5)
	end)
	Main_Frame.ShadowflameEssenceButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.ShadowflameEssenceButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.ShadowflameEssenceButton.icon = t
	t:SetTexture(5009042)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.ShadowflameEssenceButton)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.DraughtofTenLandsButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.DraughtofTenLandsButton:SetSize(curHeight, curHeight)
	Main_Frame.DraughtofTenLandsButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -180)
	Main_Frame.DraughtofTenLandsButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.DraughtofTenLandsButton:SetBackdropBorderColor(0, 1, 0, 1)
	Main_Frame.DraughtofTenLandsButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
				local curServerShort = CharInfo.curServer
				local text = (curServerShort):gsub("-", " "):gsub("'", " ")
				local a, b = strsplit(" ", text)
				if b then
					curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
				end
				if CharInfo.ItemsInBag[166751] and CharInfo.ItemsInBag[166751] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(func_itemTexture(166751)..classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"), CharInfo.ItemsInBag[166751])
				end
				if CharInfo.CurrencyID[1716] >= 5 then
					i = i + 1
					GameTooltip:AddDoubleLine(func_currencyicon(1716)..classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"), CharInfo.CurrencyID[1716])
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.DraughtofTenLandsButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(.64, .21, .93, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.DraughtofTenLandsButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, .5)
			self.icon:SetVertexColor(1, 0, 0, .5)
	end)
	Main_Frame.DraughtofTenLandsButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.DraughtofTenLandsButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.DraughtofTenLandsButton.icon = t
	t:SetTexture(967526)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.DraughtofTenLandsButton)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- ITEMID, count, Ypox, r, g, b
	-- CreateFrameUsableItems(204075, 5062636, 15, 0, .12, 1, 0)
	-- CreateFrameUsableItems(204076, 5062624, 15, -24, 0, .44, .98)
	-- CreateFrameUsableItems(204077, 5062642, 15, -48, .64, .21, .93)
	-- CreateFrameUsableItems(204078, 5062612, 15, -72, 1, .5, 0)
	-- CreateFrameUsableItems(204717, 442739, 2, -96, .85, .8, .5)
	-- Expansion, texture, Ypox, r,g,b
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- local qz = -21
	-- CreateFrameExpansion("Classic", 254652, qz*0, 104/255, 204/255, 239/255)
	-- CreateFrameExpansion("TBC", 236415, qz*1, 79/255, 1, 121/255)
	-- CreateFrameExpansion("WotLK", 630787, qz*2, 0, 163/255, 1)
	-- CreateFrameExpansion("Cata", 4622499, qz*3, 1, 179/255, 0)
	-- CreateFrameExpansion("MoP", 626190, qz*4, 0, 1, 186/255)
	-- CreateFrameExpansion("WoD", 236452, qz*5, 200/255, 100/255, 0)
	-- CreateFrameExpansion("Legion", 135794, qz*6, 30/255, 1, 0)
	-- CreateFrameExpansion("BfA", 2484334, qz*7, 100/255, 100/255, 1)
	-- CreateFrameExpansion("SL", 3586268, qz*8, 201/255, 195/255, 170/255)
	-- CreateFrameExpansion("DF", 4640492, qz*9, 232/255, 277/255, 121/255)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = "|cffFF0000!!! ACHTUNG !!!|r\n".."Отменить все ("..numQuests..") задания?",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function()
			C_Timer.After(1,function()
					for i=1, numShownEntries do
						if numQuests ~= 0 then
							local questInfo = C_QuestLog.GetInfo(i)
							if questInfo then
								if (not questInfo.isHeader and not questInfo.isHidden) then
									print ("|cFF00A3FF"..L["Abandon"].."|r".."|cFFFF5771"..questInfo.title.."|r")
									C_QuestLog.SetSelectedQuest(questInfo.questID)
									C_QuestLog.SetAbandonQuest()
									C_QuestLog.AbandonQuest()
								end
							end
						end
					end
					print (DONE)
			end)
		end,
	}
	-----------------------------------------------------
	Main_Frame.AbandonAllQuests = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.AbandonAllQuests:SetSize(curHeight, curHeight)
	Main_Frame.AbandonAllQuests:SetPoint("BOTTOMLEFT", Main_Frame, "BOTTOMRIGHT", 0, 30)
	Main_Frame.AbandonAllQuests:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.AbandonAllQuests:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.AbandonAllQuests:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["Abandon All Quests"].." ("..numQuests..")")
			GameTooltip:Show()
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnClick", function()
			StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
	end)
	local t = Main_Frame.AbandonAllQuests:CreateTexture(nil, "BACKGROUND")
	Main_Frame.AbandonAllQuests.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\SadKitty.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.AbandonAllQuests)
	-----------------------------------------------------
	-----------------------------------------------------
	StaticPopupDialogs[GlobalAddonName.."DELETE_ADDONDATA_RELOAD"] = {
		text = "|cffFF0000!!! ACHTUNG !!!|r\n".."Для применения изменений необходимо перезагрузить интерфейс. Сделать это сейчас?",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function() Main_Frame:Hide() Octo_ToDo_DragonflyLevels = {} ReloadUI() end,
	}
	-----------------------------------------------------
	Main_Frame.RESETVARIABLES = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.RESETVARIABLES:SetSize(curHeight, curHeight)
	Main_Frame.RESETVARIABLES:SetPoint("BOTTOMLEFT", Main_Frame, "BOTTOMRIGHT", 0, 0)
	Main_Frame.RESETVARIABLES:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.RESETVARIABLES:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.RESETVARIABLES:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["RESET"])
			GameTooltip:Show()
	end)
	Main_Frame.RESETVARIABLES:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.RESETVARIABLES:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.RESETVARIABLES:SetScript("OnClick", function()
			StaticPopup_Show(GlobalAddonName.."DELETE_ADDONDATA_RELOAD")
	end)
	local t = Main_Frame.RESETVARIABLES:CreateTexture(nil, "BACKGROUND")
	Main_Frame.RESETVARIABLES.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Facepalm.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.RESETVARIABLES)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- local className, classFilename, classId = UnitClass("PLAYER")
	-- local classColor = C_ClassColor.GetClassColor(classFilename)
	-- local r, g, b = classColor:GetRGB()
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, 0.2) --горизонт
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 0, #table_func_otrisovka do
		local fname, f
		if i ~= 0 then
			fname = "FrameLine"..i
			Main_Frame[fname] = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Main_Frame, "BackdropTemplate")
			f = Main_Frame[fname]
			f:SetHeight(curHeight)
			f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 0, -curHeight*i)
			-- f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 0+curWidthTitle, -curHeight*i)
			f:SetPoint("RIGHT")
			f:SetScript("OnEnter", FrameLine_OnEnter)
			f:SetScript("OnLeave", FrameLine_OnLeave)
			f:SetMouseClickEnabled(false)
			f.BG = f:CreateTexture(nil, "BACKGROUND")
			f.BG:SetHeight(curHeight)
			f.BG:SetAllPoints()
			--Горизонт
			-- f:SetBackdrop({
			-- bgFile = bgFile,
			-- edgeFile = edgeFile,
			-- edgeSize = 1,
			-- })
			-- f:SetBackdropColor(bgCr, bgCg, bgCb, 0)
			-- f:SetBackdropBorderColor(0, 0, 0, 0.15)
		end
		fname = "TextLeft"..i
		Main_Frame[fname] = Main_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = Main_Frame[fname]
		f:SetSize(curWidthTitle, curHeight)
		f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 6, -curHeight*i)
		f:SetFont(curFontTTF, curFontSize, curFontOutline)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDo_DragonflyAddDataToAltFrame()
	Main_Frame:Hide()
end
function OctoQuestUpdate()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-- collect.Octopussy_TreasureGoblin = CheckCompletedByQuestID(76215)
	collect.Octopussy_Feast = CheckCompletedByQuestID(70893)
	collect.Octopussy_DragonbaneKeep = CheckCompletedByQuestID(70866)
	collect.Octopussy_TheGrandHunt = CheckCompletedByQuestID(70906)
	collect.Octopussy_StormsFury = CheckCompletedByQuestID(73162)--74378
	collect.Octopussy_KeysofLoyalty = CheckCompletedByQuestID(66133)--66419) -- Allegiance to One -- Присяга
	collect.Octopussy_StormBoundChest = CheckCompletedByQuestID(74567)
	collect.Octopussy_ResearchersUnderFire = CheckCompletedByQuestID(75643) --75643 или 75627 (хуита 74905)
	collect.Octopussy_WB = false
	if C_QuestLog.IsQuestFlaggedCompleted(69927) then collect.Octopussy_WB = CheckCompletedByQuestID(69927)
	elseif C_QuestLog.IsQuestFlaggedCompleted(69928) then collect.Octopussy_WB = CheckCompletedByQuestID(69928)
	elseif C_QuestLog.IsQuestFlaggedCompleted(69929) then collect.Octopussy_WB = CheckCompletedByQuestID(69929)
	elseif C_QuestLog.IsQuestFlaggedCompleted(69930) then collect.Octopussy_WB = CheckCompletedByQuestID(69930)
	end
	collect.Octopussy_WB_NEW = false
	if C_QuestLog.IsQuestFlaggedCompleted(74892) then collect.Octopussy_WB_NEW = CheckCompletedByQuestID(74892)
	end
	collect.Octopussy_FyrakkAssaults = false
	if C_QuestLog.IsQuestFlaggedCompleted(74501) then collect.Octopussy_FyrakkAssaults = CheckCompletedByQuestID(74501)
	elseif C_QuestLog.IsQuestFlaggedCompleted(75280) then collect.Octopussy_FyrakkAssaults = CheckCompletedByQuestID(75280)
	end
	collect.Octopussy_Timewalk500CURRENCY = false
	if C_QuestLog.IsOnQuest(40173) or C_QuestLog.IsQuestFlaggedCompleted(40173) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(40173)
	elseif C_QuestLog.IsOnQuest(64710) or C_QuestLog.IsQuestFlaggedCompleted(64710) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(64710)
	elseif C_QuestLog.IsOnQuest(40168) or C_QuestLog.IsQuestFlaggedCompleted(40168) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(40168)
	elseif C_QuestLog.IsOnQuest(40786) or C_QuestLog.IsQuestFlaggedCompleted(40786) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(40786)
	elseif C_QuestLog.IsOnQuest(45563) or C_QuestLog.IsQuestFlaggedCompleted(45563) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(45563)
	elseif C_QuestLog.IsOnQuest(55499) or C_QuestLog.IsQuestFlaggedCompleted(55499) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(55499)
	elseif C_QuestLog.IsOnQuest(55498) or C_QuestLog.IsQuestFlaggedCompleted(55498) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(55498)
	elseif C_QuestLog.IsOnQuest(40787) or C_QuestLog.IsQuestFlaggedCompleted(40787) then collect.Octopussy_Timewalk500CURRENCY = CheckCompletedByQuestID(40787)
	end
	collect.Octopussy_WeekendEvent = false
	if C_QuestLog.IsOnQuest(72728) or C_QuestLog.IsQuestFlaggedCompleted(72728) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72728)
	elseif C_QuestLog.IsOnQuest(72720) or C_QuestLog.IsQuestFlaggedCompleted(72720) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72720)
	-- elseif C_QuestLog.IsOnQuest(72721) or C_QuestLog.IsQuestFlaggedCompleted(72721) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72721) --Битва питомцев
	elseif C_QuestLog.IsOnQuest(72722) or C_QuestLog.IsQuestFlaggedCompleted(72722) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72722)
	elseif C_QuestLog.IsOnQuest(72723) or C_QuestLog.IsQuestFlaggedCompleted(72723) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72723)
	elseif C_QuestLog.IsOnQuest(72728) or C_QuestLog.IsQuestFlaggedCompleted(72728) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72728)
	end

	collect.Octopussy_Timewalk5DUNGEONS = false
	if C_QuestLog.IsOnQuest(72727) or C_QuestLog.IsQuestFlaggedCompleted(72727) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72727)
	elseif C_QuestLog.IsOnQuest(72810) or C_QuestLog.IsQuestFlaggedCompleted(72810) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72810)
	elseif C_QuestLog.IsOnQuest(72719) or C_QuestLog.IsQuestFlaggedCompleted(72719) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72719)
	elseif C_QuestLog.IsOnQuest(72725) or C_QuestLog.IsQuestFlaggedCompleted(72725) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72725)
	elseif C_QuestLog.IsOnQuest(72726) or C_QuestLog.IsQuestFlaggedCompleted(72726) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72726)
	elseif C_QuestLog.IsOnQuest(72724) or C_QuestLog.IsQuestFlaggedCompleted(72724) then collect.Octopussy_Timewalk5DUNGEONS = CheckCompletedByQuestID(72724)
	end




	collect.Octopussy_dungeons_RelicRecovery = false
	if C_QuestLog.IsOnQuest(66860) or C_QuestLog.IsQuestFlaggedCompleted(66860) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66860)
	elseif C_QuestLog.IsOnQuest(66861) or C_QuestLog.IsQuestFlaggedCompleted(66861) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66861)
	elseif C_QuestLog.IsOnQuest(66862) or C_QuestLog.IsQuestFlaggedCompleted(66862) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66862)
	elseif C_QuestLog.IsOnQuest(66863) or C_QuestLog.IsQuestFlaggedCompleted(66863) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66863)
	elseif C_QuestLog.IsOnQuest(66864) or C_QuestLog.IsQuestFlaggedCompleted(66864) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66864)
	elseif C_QuestLog.IsOnQuest(66865) or C_QuestLog.IsQuestFlaggedCompleted(66865) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66865)
	elseif C_QuestLog.IsOnQuest(66866) or C_QuestLog.IsQuestFlaggedCompleted(66866) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66866)
	elseif C_QuestLog.IsOnQuest(66867) or C_QuestLog.IsQuestFlaggedCompleted(66867) then collect.Octopussy_dungeons_RelicRecovery = CheckCompletedByQuestID(66867)
	end
	collect.Octopussy_dungeons_PreservingthePast = false
	if C_QuestLog.IsOnQuest(66868) or C_QuestLog.IsQuestFlaggedCompleted(66868) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66868)
	elseif C_QuestLog.IsOnQuest(66870) or C_QuestLog.IsQuestFlaggedCompleted(66870) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66870)
	elseif C_QuestLog.IsOnQuest(66871) or C_QuestLog.IsQuestFlaggedCompleted(66871) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66871)
	elseif C_QuestLog.IsOnQuest(66873) or C_QuestLog.IsQuestFlaggedCompleted(66873) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66873)
	elseif C_QuestLog.IsOnQuest(66874) or C_QuestLog.IsQuestFlaggedCompleted(66874) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66874)
	elseif C_QuestLog.IsOnQuest(66875) or C_QuestLog.IsQuestFlaggedCompleted(66875) then collect.Octopussy_dungeons_PreservingthePast = CheckCompletedByQuestID(66875)
	end
	collect.Octopussy_3kREP = false
	if C_QuestLog.IsOnQuest(72068) or C_QuestLog.IsQuestFlaggedCompleted(72068) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(72068)
	elseif C_QuestLog.IsOnQuest(72373) or C_QuestLog.IsQuestFlaggedCompleted(72373) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(72373)
	elseif C_QuestLog.IsOnQuest(72374) or C_QuestLog.IsQuestFlaggedCompleted(72374) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(72374)
	elseif C_QuestLog.IsOnQuest(72375) or C_QuestLog.IsQuestFlaggedCompleted(72375) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(72375)
	elseif C_QuestLog.IsOnQuest(75259) or C_QuestLog.IsQuestFlaggedCompleted(75259) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(75259)
	elseif C_QuestLog.IsOnQuest(70750) or C_QuestLog.IsQuestFlaggedCompleted(70750) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(70750)
	elseif C_QuestLog.IsOnQuest(75859) or C_QuestLog.IsQuestFlaggedCompleted(75859) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(75859)
	elseif C_QuestLog.IsOnQuest(75860) or C_QuestLog.IsQuestFlaggedCompleted(75860) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(75860)
	elseif C_QuestLog.IsOnQuest(75861) or C_QuestLog.IsQuestFlaggedCompleted(75861) == true then collect.Octopussy_3kREP = CheckCompletedByQuestID(75861)
	end
	collect.Octopussy_3kREP_IsOnQuest = 0
	if C_QuestLog.IsOnQuest(72068) == true then collect.Octopussy_3kREP_IsOnQuest = 72068
	elseif C_QuestLog.IsOnQuest(72373) == true then collect.Octopussy_3kREP_IsOnQuest = 72373
	elseif C_QuestLog.IsOnQuest(72374) == true then collect.Octopussy_3kREP_IsOnQuest = 72374
	elseif C_QuestLog.IsOnQuest(72375) == true then collect.Octopussy_3kREP_IsOnQuest = 72375
	elseif C_QuestLog.IsOnQuest(75259) == true then collect.Octopussy_3kREP_IsOnQuest = 75259
	elseif C_QuestLog.IsOnQuest(70750) == true then collect.Octopussy_3kREP_IsOnQuest = 70750
	elseif C_QuestLog.IsOnQuest(75859) == true then collect.Octopussy_3kREP_IsOnQuest = 75859
	elseif C_QuestLog.IsOnQuest(75860) == true then collect.Octopussy_3kREP_IsOnQuest = 75860
	elseif C_QuestLog.IsOnQuest(75861) == true then collect.Octopussy_3kREP_IsOnQuest = 75861
	end
	collect.Octopussy_FightingisItsOwnReward = false --Славный бой – это уже награда
	if C_QuestLog.IsOnQuest(76122) or C_QuestLog.IsQuestFlaggedCompleted(76122) == true then collect.Octopussy_FightingisItsOwnReward = CheckCompletedByQuestID(76122)
	end
	collect.Octopussy_AWorthyAllyLoammNiffen = false --Достойный союзник: лоаммские ниффы
	if C_QuestLog.IsOnQuest(75665) or C_QuestLog.IsQuestFlaggedCompleted(75665) == true then collect.Octopussy_AWorthyAllyLoammNiffen = CheckCompletedByQuestID(75665)
	end
end
function OctoMoneyUpdate()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local Money = GetMoney()
	collect.Money = Money
end
function OctoilvlStr()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	collect.avgItemLevel = math.floor(avgItemLevel)
	collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
	collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
end
function Octo_ToDo_DragonflyAddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	--------------------------------------------------------------------------------------
	Main_Frame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
		sorted[#sorted+1] = CharInfo
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.curServer < b.curServer or a.curServer == b.curServer
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				-- a.Faction < b.Faction or a.Faction == b.Faction
				-- and
				b.Name < a.Name
			end
	end)
	TotalMoney = 0
	TotalMoneyAllServer = 0
	TotalKills = 0
	for i, CharInfo in pairs(sorted) do
		local curCharGUID = CharInfo.GUID
		local curName = nil
		if CharInfo.Name == nil then
		curName = "UnLogged Char" else
			curName = CharInfo.Name
		end
		if not Main_Frame[curCharGUID] then
			Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Main_Frame, "BackdropTemplate")
			Char_Frame = Main_Frame[curCharGUID]
			Char_Frame:SetPoint("BOTTOM", 0, 0)
			Char_Frame.BG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.BG:Hide()
			Char_Frame.BG:SetPoint("TOPLEFT", 0, -curHeight)
			Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
			Char_Frame.BG:SetColorTexture(r, g, b, 1)
			--Вертикаль
			-- Char_Frame:SetBackdrop({
			-- bgFile = bgFile,
			-- edgeFile = edgeFile,
			-- edgeSize = 1 ,
			-- })
			-- Char_Frame:SetBackdropColor(bgCr, bgCg, bgCb, 0)
			-- Char_Frame:SetBackdropBorderColor(0, 0, 0, 0.15)
			for i = 1, #table_func_otrisovka do
				CF = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Char_Frame)
				Char_Frame["CenterLines"..i] = CF
				CF.index = i
				CF:SetSize(curWidth, curHeight)
				CF:SetPoint("TOP", Char_Frame, "TOP", 0, -curHeight*i)
				CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
				CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
				CF:SetMouseClickEnabled(false)
				-- if #CF.tooltip == 0 then CF.tooltip = nil end
				local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				--Char_Frame["CenterLines"..i] = CL
				CL:SetAllPoints()
				--CL:SetSize(curWidth, curHeight)
				--CL:SetPoint("TOP", Char_Frame, "TOP", 0, -curHeight*i)
				CL:SetFont(curFontTTF, curFontSize, curFontOutline)
				CL:SetJustifyV("MIDDLE")
				CL:SetJustifyH("CENTER")
				CL:SetTextColor(1, 1, 1, 1)
				CF.CL = CL
			end
		else
			Char_Frame = Main_Frame[curCharGUID]
		end
		local ShowOnlyCurrentRealm = Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm
		local LevelToShow = Octo_ToDo_DragonflyVars.config.LevelToShow
		TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.UnitLevel >= LevelToShow)) or (ShowOnlyCurrentRealm == false and CharInfo.UnitLevel >= LevelToShow) or (curGUID == CharInfo.GUID) then
			CharInfo.GUID = curCharGUID
			Char_Frame:SetSize(curWidth, curHeight)
			if #Main_Frame.AllCharFrames == 0 then
				Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				Char_Frame:SetPoint("TOPRIGHT", Main_Frame.AllCharFrames[#Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			Main_Frame.AllCharFrames[#Main_Frame.AllCharFrames + 1] = Char_Frame
			local curMoney = 0
			if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then
				curMoney = CharInfo.Money
			end
			TotalMoney = TotalMoney + curMoney
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			Char_Frame.DeleteButton = CreateFrame("BUTTON", AddonTitle..GenerateUniqueID(), Char_Frame, "BackDropTemplate")
			Char_Frame.CharName = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.curServer = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.CharNameBG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.CharNameBG:SetAllPoints(Char_Frame.CharName)
			Char_Frame.UnitLevel = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.UnitLevelBG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.UnitLevelBG:SetAllPoints(Char_Frame.UnitLevel)
			if CharInfo.Faction == "Horde" then
				Char_Frame.CharNameBG:SetColorTexture(.2, 0, 0, 1)
			else
				Char_Frame.CharNameBG:SetColorTexture(0, 0, .2, 1)
			end
			Char_Frame.UnitLevel:SetSize(curWidth, curHeight/2)
			Char_Frame.UnitLevel:SetPoint("BOTTOM", Char_Frame, "TOP", 0, 0)
			Char_Frame.UnitLevel:SetFont(curFontTTF, curFontSize, curFontOutline)
			Char_Frame.UnitLevel:SetWordWrap(true)
			Char_Frame.UnitLevel:SetJustifyV("CENTER")
			--Char_Frame.UnitLevel:SetText(" ")
			if CharInfo.UnitLevel ~= 70 then
				Char_Frame.UnitLevelBG:SetColorTexture(bgCr, bgCg, bgCb, 1)
				--Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel.." "..math.floor((CharInfo.currentXP/CharInfo.UnitXPMax)*100).."%"))
				Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel))
				Char_Frame.experience = Char_Frame:CreateTexture(nil, "ARTWORK")
				if CharInfo.currentXP == 0 then
					Char_Frame.experience:SetWidth(0.1)
				else
					Char_Frame.experience:SetWidth(CharInfo.currentXP/CharInfo.UnitXPMax*curWidth)
				end
				Char_Frame.experience:SetHeight(curHeight/2) --Высота
				Char_Frame.experience:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\O_03.tga")
				Char_Frame.experience:SetPoint("BOTTOMLEFT", Char_Frame, "TOPLEFT")
				Char_Frame.experience:SetVertexColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b, 1)
			elseif CharInfo.UnitLevel == 70 then
				-- Char_Frame.experience:Hide()
			end
			Char_Frame.CharName:SetSize(curWidth, curHeight)
			Char_Frame.CharName:SetFont(curFontTTF, curFontSize, curFontOutline)
			Char_Frame.CharName:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
			Char_Frame.CharName:SetText(classcolor:WrapTextInColorCode(CharInfo.Name))
			Char_Frame.CharName:SetWordWrap(true)
			Char_Frame.CharName:SetJustifyV("CENTER")
			if Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm == false then
				Char_Frame.CharName:SetJustifyV("TOP")
				--Char_Frame.CharName:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
				Char_Frame.curServer:SetSize(curWidth, curHeight)
				Char_Frame.curServer:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
				Char_Frame.curServer:SetFont(curFontTTF, curFontSize-2, curFontOutline)
				Char_Frame.curServer:SetText(classcolor:WrapTextInColorCode(CharInfo.curServer))
				Char_Frame.curServer:SetWordWrap(false)
				Char_Frame.curServer:SetJustifyV("BOTTOM")
			end
			---------------------------------------------
			-- StaticPopupDialogs[GlobalAddonName.."DELETE_CHARACTER"] = {
			-- text = DELETE.."?",
			-- button1 = YES,
			-- button2 = NO,
			-- hideOnEscape = 1,
			-- whileDead = 1,
			-- OnAccept = function() Octo_ToDo_DragonflyDeleteChar(curCharGUID) end,
			-- }
			---------------------------------------------
			Char_Frame.DeleteButton:SetSize(16, 10)
			Char_Frame.DeleteButton:SetPoint("TOP", Char_Frame, "BOTTOM", 0, -4)
			Char_Frame.DeleteButton:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", -- Interface/Addons/"..GlobalAddonName.."/Media/border/01 Octo.tga -- Interface/Buttons/white8x8
					edgeSize = 1,
			})
			Char_Frame.DeleteButton:SetBackdropBorderColor(1, 0, 0, 0)
			Char_Frame.DeleteButton:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
					GameTooltip:ClearLines()
					GameTooltip:SetText(DELETE)
					GameTooltip:Show()
			end)
			Char_Frame.DeleteButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			Char_Frame.DeleteButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0.5)
					self.icon:SetVertexColor(1, 0, 0, 0.5)
			end)
			Char_Frame.DeleteButton:SetScript("OnClick", function()
					--StaticPopup_Show(GlobalAddonName.."DELETE_CHARACTER")
					Octo_ToDo_DragonflyDeleteChar(curCharGUID)
			end)
			local t = Char_Frame.DeleteButton:CreateTexture(nil, "BACKGROUND")
			Char_Frame.DeleteButton.icon = t
			t:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\closeWHITE.tga")
			t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Char_Frame.DeleteButton)
			if curGUID == curCharGUID then
				Char_Frame.BG:Show()
				Char_Frame.BG:SetAlpha(.2)
			end
			for i = 1, #table_func_otrisovka do
				local TEXTLEFT = Main_Frame["TextLeft"..i]
				local TEXTCENT = Char_Frame["CenterLines"..i]
				TEXTCENT.tooltip = {}
				local VivodCent, VivodLeft = table_func_otrisovka[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL)
				TEXTLEFT:SetText(VivodLeft)
				TEXTCENT.CL:SetText(VivodCent)
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
		end
		local curAltFrameWidth = #Main_Frame.AllCharFrames * curWidth/2
		Main_Frame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(#table_func_otrisovka+1))
	end
end
function Octo_ToDo_DragonflyDeleteChar(curGUID)
	Octo_ToDo_DragonflyLevels[curGUID] = nil
	for X, Y in pairs(Main_Frame.AllCharFrames) do
		-- https://www.wowhead.com/ru/npc=38606/ ДЖАЙНА
		-- https://www.wowhead.com/ru/npc=38609/ СИЛЬВАНА
		PlaySound(11014) -- Джайна стоны
		--PlaySound(109068) --Черепаха добралась до воды https://www.wowhead.com/ru/npc=102636/
		if Y == Main_Frame[curGUID] then
			Main_Frame.AllCharFrames[X].parent = nil
			Main_Frame.AllCharFrames[X]:Hide()
			Main_Frame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDo_DragonflyAddDataToAltFrame()
end
function CollectPlayerInfo()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER") or 0
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	collect.currentXP = currentXP
	collect.UnitXPMax = UnitXPMax
	collect.Name = curCharName
	collect.curServer = curServer
	collect.className = className
	collect.classFilename = classFilename
	collect.classId = classId
	collect.GUID = curGUID
	collect.Faction = UnitFactionGroup("PLAYER")
	collect.UnitLevel = UnitLevel
	collect.specId = specId
	collect.specName = specName
	collect.specIcon = specIcon
	collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
end
local function checkCharInfo(CharInfo)
	CharInfo.avgItemLevel = CharInfo.avgItemLevel or 0
	CharInfo.avgItemLevelEquipped = CharInfo.avgItemLevelEquipped or 0
	CharInfo.avgItemLevelPvp = CharInfo.avgItemLevelPvp or 0
	CharInfo.className = CharInfo.className or 0
	CharInfo.classFilename = CharInfo.classFilename or 0
	CharInfo.classId = CharInfo.classId or 0
	CharInfo.classColor = CharInfo.classColor or {r = 0.5, g = 0.5, b = 0.5}
	CharInfo.curCovID = CharInfo.curCovID or 0
	CharInfo.CurrencyID = CharInfo.CurrencyID or {}
	CharInfo.CurrencyID_maxQuantity = CharInfo.CurrencyID_maxQuantity or {}
	CharInfo.curServer = CharInfo.curServer or 0
	CharInfo.EVENTS_ZARALEK_LIST = CharInfo.RARE_ZARALEK_LIST or {}
	CharInfo.Faction = CharInfo.Faction or 0
	CharInfo.ItemsInBag = CharInfo.ItemsInBag or {}
	CharInfo.KnownSpell = CharInfo.KnownSpell or {}
	CharInfo.maxNumQuestsCanAccept = CharInfo.maxNumQuestsCanAccept or 0
	CharInfo.Name = CharInfo.Name or 0
	CharInfo.needReset = CharInfo.needReset or false
	CharInfo.numQuests = CharInfo.numQuests or 0
	CharInfo.numShownEntries = CharInfo.numShownEntries or 0
	CharInfo.Octopussy_3kREP = CharInfo.Octopussy_3kREP or false
	CharInfo.Octopussy_3kREP_IsOnQuest = CharInfo.Octopussy_3kREP_IsOnQuest or 0
	CharInfo.Octopussy_AWorthyAllyLoammNiffen = CharInfo.Octopussy_AWorthyAllyLoammNiffen or false
	CharInfo.Octopussy_DragonbaneKeep = CharInfo.Octopussy_DragonbaneKeep or false
	CharInfo.Octopussy_dungeons_PreservingthePast = CharInfo.Octopussy_dungeons_PreservingthePast or false
	CharInfo.Octopussy_dungeons_RelicRecovery = CharInfo.Octopussy_dungeons_RelicRecovery or false
	CharInfo.Octopussy_Feast = CharInfo.Octopussy_Feast or false
	CharInfo.Octopussy_FightingisItsOwnReward = CharInfo.Octopussy_FightingisItsOwnReward or false
	CharInfo.Octopussy_FyrakkAssaults = CharInfo.Octopussy_FyrakkAssaults or false
	CharInfo.Octopussy_KeysofLoyalty = CharInfo.Octopussy_KeysofLoyalty or false
	CharInfo.Octopussy_ResearchersUnderFire = CharInfo.Octopussy_ResearchersUnderFire or false
	CharInfo.Octopussy_StormBoundChest = CharInfo.Octopussy_StormBoundChest or false
	CharInfo.Octopussy_StormsFury = CharInfo.Octopussy_StormsFury or false
	CharInfo.Octopussy_TheGrandHunt = CharInfo.Octopussy_TheGrandHunt or false
	CharInfo.Octopussy_Timewalk500CURRENCY = CharInfo.Octopussy_Timewalk500CURRENCY or false
	-- CharInfo.Octopussy_TreasureGoblin = CharInfo.Octopussy_TreasureGoblin or false
	CharInfo.Octopussy_WB_NEW = CharInfo.Octopussy_WB_NEW or false
	CharInfo.Octopussy_WeekendEvent = CharInfo.Octopussy_WeekendEvent or false
	CharInfo.Octopussy_Timewalk5DUNGEONS = CharInfo.Octopussy_Timewalk5DUNGEONS or false
	CharInfo.pizdaDate = CharInfo.pizdaDate or 0
	CharInfo.pizdaHours = CharInfo.pizdaHours or 0
	CharInfo.profID_prof1 = CharInfo.profID_prof1 or {}
	CharInfo.profID_prof1.chest = CharInfo.profID_prof1.chest or {}
	CharInfo.profID_prof1.craftOrder = CharInfo.profID_prof1.craftOrder or {}
	CharInfo.profID_prof1.drops = CharInfo.profID_prof1.drops or {}
	CharInfo.profID_prof1.profQuest = CharInfo.profID_prof1.profQuest or {}
	CharInfo.profID_prof1.treatise = CharInfo.profID_prof1.treatise or {}
	CharInfo.profID_prof2 = CharInfo.profID_prof2 or {}
	CharInfo.profID_prof2.chest = CharInfo.profID_prof2.chest or {}
	CharInfo.profID_prof2.craftOrder = CharInfo.profID_prof2.craftOrder or {}
	CharInfo.profID_prof2.drops = CharInfo.profID_prof2.drops or {}
	CharInfo.profID_prof2.profQuest = CharInfo.profID_prof2.profQuest or {}
	CharInfo.profID_prof2.treatise = CharInfo.profID_prof2.treatise or {}
	CharInfo.PVP = CharInfo.PVP or {}
	CharInfo.questIDtable = CharInfo.questIDtable or {}
	CharInfo.RARE_OSTROV_LIST = CharInfo.RARE_OSTROV_LIST or {}
	CharInfo.RARE_ZARALEK_LIST = CharInfo.RARE_ZARALEK_LIST or {}
	CharInfo.reputationID = CharInfo.reputationID or {}
	CharInfo.Shadowland = CharInfo.Shadowland or {}
	CharInfo.totalSlots = CharInfo.totalSlots or 0
	CharInfo.totalSlotsBANK = CharInfo.totalSlotsBANK or 0
	CharInfo.UnitLevel = CharInfo.UnitLevel or 0
	CharInfo.usedSlots = CharInfo.usedSlots or 0
	CharInfo.usedSlotsBANK = CharInfo.usedSlotsBANK or 0
	CharInfo.VOID_STORAGE_PAGE1 = CharInfo.VOID_STORAGE_PAGE1 or {}
	CharInfo.VOID_STORAGE_PAGE2 = CharInfo.VOID_STORAGE_PAGE2 or {}
	CharInfo.canUseMountEquipment = CharInfo.canUseMountEquipment or false
	CharInfo.currentMountItemID = CharInfo.currentMountItemID or 0
	setmetatable(CharInfo, Meta_Table_0)
	setmetatable(CharInfo.CurrencyID_maxQuantity, Meta_Table_0)
	setmetatable(CharInfo.CurrencyID, Meta_Table_0)
	setmetatable(CharInfo.EVENTS_ZARALEK_LIST, Meta_Table_0)
	setmetatable(CharInfo.ItemsInBag, Meta_Table_0)
	setmetatable(CharInfo.KnownSpell, Meta_Table_false)
	setmetatable(CharInfo.profID_prof1, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.chest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.craftOrder, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.drops, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.profQuest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.treatise, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.chest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.craftOrder, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.drops, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.profQuest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.treatise, Meta_Table_0)
	setmetatable(CharInfo.PVP, Meta_Table_0)
	setmetatable(CharInfo.questIDtable, Meta_Table_0)
	setmetatable(CharInfo.RARE_OSTROV_LIST, Meta_Table_0)
	setmetatable(CharInfo.RARE_ZARALEK_LIST, Meta_Table_0)
	setmetatable(CharInfo.reputationID, Meta_Table_0)
	setmetatable(CharInfo.Shadowland, Meta_Table_0)
	setmetatable(CharInfo.VOID_STORAGE_PAGE1, Meta_Table_0)
	setmetatable(CharInfo.VOID_STORAGE_PAGE2, Meta_Table_0)
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.Octopussy_3kREP == AddonColor.."Done|r" then
		CharInfo.Octopussy_3kREP = false
		CharInfo.Octopussy_3kREP_IsOnQuest = 0
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.Octopussy_FightingisItsOwnReward == AddonColor.."Done|r" then
		CharInfo.Octopussy_FightingisItsOwnReward = false
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.Octopussy_AWorthyAllyLoammNiffen == AddonColor.."Done|r" then
		CharInfo.Octopussy_AWorthyAllyLoammNiffen = false
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.CurrentKey ~= 0 then
		CharInfo.CurrentKey = AddonColor..">>VAULT<<|r"
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
		CharInfo.tmstp_Weekly = tmstpDayReset(7)
		CharInfo.Octopussy_Feast = false
		CharInfo.Octopussy_DragonbaneKeep = false
		CharInfo.Octopussy_TheGrandHunt = false
		CharInfo.Octopussy_StormsFury = false
		CharInfo.Octopussy_ResearchersUnderFire = false
		CharInfo.Octopussy_WB = false
		CharInfo.Octopussy_WB_NEW = false
		CharInfo.Octopussy_FyrakkAssaults = false
		CharInfo.Octopussy_Timewalk500CURRENCY = false
		CharInfo.Octopussy_WeekendEvent = false
		CharInfo.Octopussy_Timewalk5DUNGEONS = false
		CharInfo.Octopussy_dungeons_RelicRecovery = false
		CharInfo.Octopussy_dungeons_PreservingthePast = false
		CharInfo.Octopussy_StormBoundChest = false
		CharInfo.RIO_weeklyBest = ""
		CharInfo.RIO_RAID = ""
		CharInfo.RIO_KEYS = ""
		CharInfo.RIO_PVPS = ""
		--CharInfo.questIDtable = {}
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.CurrencyID[2533] < 8 then
		CharInfo.CurrencyID[2533] = CharInfo.CurrencyID[2533] + 1
	end

	if (CharInfo.tmstp_Daily or 0) < GetServerTime() then
		CharInfo.tmstp_Daily = tmstpDayReset(1)
		--CharInfo.classColor = {r = 0.5, g = 0.5, b = 0.5}
		-- CharInfo.Octopussy_TreasureGoblin = false
		CharInfo.RARE_ZARALEK_LIST = {}
		CharInfo.EVENTS_ZARALEK_LIST = {}
		CharInfo.RARE_OSTROV_LIST = {}
		CharInfo.needReset = true
	end
end
function Octo_ToDo_DragonflyOnEvent(self, event, ...)
	--if InCombatLockdown() then return end
	if event == "ACTIONBAR_UPDATE_COOLDOWN" and not InCombatLockdown() then
		-- print (GetExpansionLevel(), GetAccountExpansionLevel(), GetServerExpansionLevel(), LE_EXPANSION_LEVEL_CURRENT)
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
			ToDragonbaneKeepTimer()
			GrandHuntsTimer()
			CommunityFeastTimer()
			PrimalStormsTimer()
			ResearchersUnderFireTimer()
			-- TreasureGoblinTimer()
			CollectAllProfessions()
			CollectDungeonsRaiting()
			--CollectPVPRaitings()
			CollectCurrentKEY()
			OctoilvlStr()
			CollectAllReputations()
			CollectAllQuests()
			OctoQuestUpdate()
			CollectLoginTime()
		end
	elseif event == "COVENANT_CHOSEN" then
		C_Timer.After(1, function()
				CollectCovenantAnima()
		end)
	elseif event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED" then
		C_Timer.After(1, function()
				CollectCovenantAnima()
		end)
	elseif event == "QUEST_FINISHED" then
		OctoQuestUpdate()
		CollectAllQuests()
		Octo_ToDo_DragonflyAddDataToAltFrame()
	elseif event == "QUEST_COMPLETE" then
		OctoQuestUpdate()
		CollectAllQuests()
		Octo_ToDo_DragonflyAddDataToAltFrame()
	elseif event == "QUEST_LOG_UPDATE" then
		OctoQuestUpdate()
		CollectAllQuests()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_MONEY" then
		OctoMoneyUpdate()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "CURRENCY_DISPLAY_UPDATE" and not InCombatLockdown() then
		CollectAllCurrency()
		CollectKnownSpell()
		-- CurrencyTEST()
		if Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "VARIABLES_LOADED" and not InCombatLockdown() then
		if Octo_ToDo_DragonflyVars == nil then
			Octo_ToDo_DragonflyVars = {
			}
		end
		if Octo_ToDo_DragonflyLevels == nil then
			Octo_ToDo_DragonflyLevels = {
			}
		end
		local MinimapName = GlobalAddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = IconTexture,
				OnClick = function(_, button)
					if not InCombatLockdown() then
						Main_Frame:SetShown(not Main_Frame:IsShown())
						if PlayCustomSound == true then
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\Gnome Woo.ogg", "Master")
						end
						-- CollectAllItemsInBag()
						--Fragments_Earned()
						CollectAllReputations()
						CollectPVPRaitings()
						-- if Main_Frame and Main_Frame:IsShown() then
						-- Main_Frame:Hide()
						-- end
						-- if SettingsPanel:IsVisible() and self:IsVisible() then
						-- HideUIPanel(SettingsPanel)
						-- else
						-- Settings.OpenToCategory(GlobalAddonName, true)
						-- end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle.." "..AddonVersion)
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DragonflyVars.config = Octo_ToDo_DragonflyVars.config or {}
		Octo_ToDo_DragonflyVars.config.minimapPos = Octo_ToDo_DragonflyVars.config.minimapPos or 244
		Octo_ToDo_DragonflyVars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DragonflyVars.config)
		ldbi:Show(MinimapName)
		if Octo_ToDo_DragonflyVars.config.CVar == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.CVar = false
		end
		if Octo_ToDo_DragonflyVars.config.InputDelete == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.InputDelete = true
		end
		if Octo_ToDo_DragonflyVars.config.UsableItems == nil then
			Octo_ToDo_DragonflyVars.config.UsableItems = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoOpen == nil then
			Octo_ToDo_DragonflyVars.config.AutoOpen = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoGossip == nil then
			Octo_ToDo_DragonflyVars.config.AutoGossip = true
		end
		if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame == nil then
			Octo_ToDo_DragonflyVars.config.TalkingHeadFrame = true
		end
		if Octo_ToDo_DragonflyVars.config.HideObjectiveTracker == nil then
			Octo_ToDo_DragonflyVars.config.HideObjectiveTracker = false
		end
		if Octo_ToDo_DragonflyVars.config.HideZoneText == nil then
			Octo_ToDo_DragonflyVars.config.HideZoneText = true
		end
		if Octo_ToDo_DragonflyVars.config.Covenant == nil then
			Octo_ToDo_DragonflyVars.config.Covenant = true
		end
		if Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale == nil then
			Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale = true
		end
		if Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame == nil then
			Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame = true
		end
		if Octo_ToDo_DragonflyVars.config.CinematicCanceler == nil then
			Octo_ToDo_DragonflyVars.config.CinematicCanceler = true
		end
		if Octo_ToDo_DragonflyVars.config.BossBanner == nil then
			Octo_ToDo_DragonflyVars.config.BossBanner = true
		end
		if Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast == nil then
			Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast = true
		end
		if Octo_ToDo_DragonflyVars.config.AnotherAddons == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.AnotherAddons = true
		end
		if Octo_ToDo_DragonflyVars.config.ClearChat == nil then
			Octo_ToDo_DragonflyVars.config.ClearChat = true
		end
		if Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm == nil then
			Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm = false
		end
		if Octo_ToDo_DragonflyVars.config.LevelToShow == nil then
			Octo_ToDo_DragonflyVars.config.LevelToShow = 60
		end
		if Octo_ToDo_DragonflyVars.config.AutoSellGrey == nil then
			Octo_ToDo_DragonflyVars.config.AutoSellGrey = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoRepair == nil then
			Octo_ToDo_DragonflyVars.config.AutoRepair = true
		end
		if Octo_ToDo_DragonflyVars.config.HideErrorMessages == nil then
			Octo_ToDo_DragonflyVars.config.HideErrorMessages = false
		end
		for i, func in ipairs(E.modules) do
			func()
		end
	elseif event == "UNIT_INVENTORY_CHANGED" and not InCombatLockdown() then
		OctoilvlStr()
		CollectPlayerInfo()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_LOGIN" then
		-- CollectVoidStorage()
		local curGUID = UnitGUID("PLAYER")
		Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
		for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
			checkCharInfo(CharInfo)
		end
		self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		self:RegisterEvent("PLAYER_STARTED_MOVING")
		CollectCovenantAnima()
		CollectPlayerInfo()
		CollectPVPRaitings()
		OctoQuestUpdate()
		OctoMoneyUpdate()
		OctoilvlStr()
		Octo_ToDo_DragonflyCreateAltFrame()
		CollectAllCurrency()
		CollectKnownSpell()
		-- CurrencyTEST()
		CollectAllProfessions()
		--Fragments_Earned()
		CollectAllReputations()
		TESTREP()
		CollectDungeonsRaiting()
		CollectCurrentKEY()
		CollectAllQuests()
		UPGRADERANKS_Frame()
		C_Timer.After(3, function()
				Octo_ToDo_DragonflyAddDataToAltFrame()
		end)
		--itemID_TEST_INSERT()
		-- elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		-- local _, eventType = CombatLogGetCurrentEventInfo()
		-- if eventType == "UNIT_DIED" then
		-- CollectKillCount()
		-- end
	elseif event == "PLAYER_LOGOUT" and not InCombatLockdown() then
		CollectPVPRaitings()
		--CollectLoginTime()
	elseif event == "PLAYER_LEAVING_WORLD" and not InCombatLockdown() then
		-- OctoMoneyUpdate()
		-- CollectAllCurrency()
		CollectDungeonsRaiting()
		CollectLoginTime()
		-- CollectPVPRaitings()
		-- elseif event == "PLAYER_LOGOUT" then
		-- CollectAllItemsInBag()
		-- CollectCurrentKEY()
	elseif event == "PLAYER_ENTERING_WORLD" and not InCombatLockdown() then
		CollectPVPRaitings()
		CollectLoginTime()
		CollectAllItemsInBag()
		CollectAppliedMountEquipmentID()
	elseif event == "BAG_UPDATE" and not InCombatLockdown() then
		CollectAllItemsInBag()
		--Fragments_Earned()
		CollectCurrentKEY()
		-- CollectLoginTime()
		--itemID_TEST_INSERT()
	elseif event == "HEARTHSTONE_BOUND" and not InCombatLockdown() then
		CollectAllItemsInBag()
		CollectLoginTime()
		--Fragments_Earned()
	elseif event == "ZONE_CHANGED" and not InCombatLockdown() then
		OctoQuestUpdate()
		CollectAllItemsInBag()
		CollectLoginTime()
		--Fragments_Earned()
	elseif event == "ZONE_CHANGED_NEW_AREA" and not InCombatLockdown() then
		OctoQuestUpdate()
		CollectAllItemsInBag()
		CollectLoginTime()
		--Fragments_Earned()
		-- elseif event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		-- CollectPVPRaitings()
	elseif event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" then
		CollectBankInfo()
	elseif event == "BAG_UPDATE" then
		if BankFrame:IsShown() then
			CollectBankInfo()
		end
	elseif event == "VOID_STORAGE_UPDATE" or event == "VOID_TRANSFER_DONE" or event == "VOID_STORAGE_CONTENTS_UPDATE" or event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
		CollectVoidStorage()
	elseif event == "SPELLS_CHANGED" then
		CollectKnownSpell()
	elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
		CollectAppliedMountEquipmentID()
	end
end
Octo_ToDo_DragonflyOnLoad()
SLASH_Octo1, SLASH_Octo2 = '/Octo', '/OctoDF'
function SlashCmdList.Octo(msg, editBox)
	Main_Frame:SetShown(not Main_Frame:IsShown())
	CollectAllItemsInBag()
	CollectAllReputations()
end
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	print("SEARCH:", msg)
	for i, n in pairs(_G) do
		if type(n) == "string" and n:find(msg) then
			print(i, n)
		end
	end
end
-- local ColorKyrian = CreateColor(1, 1, 1, 1)
-- (KYRIAN_BLUE_COLOR:GetRGB())
-- SetAtlas("Dragonfly-landingbutton-kyrian-highlight")
