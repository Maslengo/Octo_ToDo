-- OptionsFrame.image = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalAddonName.."\\media\\OptionLogo2"):Point("TOPLEFT", 15, 5):Size(140, 140)
-- OptionsFrame_title = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalAddonName.."\\media\\logoname2"):Point("LEFT", OptionsFrame.image, "RIGHT", 15, -5):Size(512*0.7, 128*0.7)
local AddonName, E = ...
E.modules = {}
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local Main_Frame, EventFrame = nil, nil
local _, className, curClass = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(className)
local r, g, b = classColor:GetRGB()
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local curWidth, curHeight = 96*scale , 20*scale -- ширина 80, высота 20 24
local curWidthTitle = curWidth*2
local curFontTTF, curFontSize, curFontOutline = [[Interface\Addons\]]..AddonName..[[\Media\font\01 Octo.TTF]], 11, "OUTLINE"
local TotalLines = 25
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalMoney = 0
local curMoney = 0
local thursdayResetDay0EU = (1514358000-10800) --https://wowreset.com/ 14-3=11(ТСК)
local thursdayResetDay0US = 1514300400
local daytime = 86400 -- 60 * 60 * 24 --60 сек на 60 мин на 24 ч
local NONE = "" --"|cff404040"..NONE.."|r"
local DONE = "|cff00FF00Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8 --0.1, 0.1, 0.1, 1
local edgeFile = [[Interface\Buttons\WHITE8X8]]
local bgFile = [[Interface\Buttons\WHITE8X8]]
local LevelToShow = 60
local ShowOnlyCurrentRealm = true
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
		local r, g, b = GetItemQualityColor(itemQuality);
		local color = CreateColor(r, g, b, 1);
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
	local r, g, b = GetItemQualityColor(quality);
	local color = CreateColor(r, g, b, 1);
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
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 10)
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
function ToDragonbaneKeepTimer() -- Драконья экспедиция
	-- local timePattern = "%02d:%02d";
	local TIMER = 1670342460 -- ToDragonbaneKeepTimer
	local interval = 7200
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ToDragonbaneKeepTimer = "|cffFF0000"..SecondsToClock(nextEventIn)
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ToDragonbaneKeepTimer = "|cff00FF00"..SecondsToClock(nextEventIn) .." "
	end
	return ToDragonbaneKeepTimer
end
function GrandHuntsTimer() -- Кентавры Маруук
	-- local timePattern = "%02d:%02d";
	local TIMER = 1671307200-- 1675612800 -- GrandHuntsTimer
	local interval = 7200-- 270000
	local duration = 7199-- 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local GrandHuntsTimer = "|cffFF0000"..SecondsToClock(nextEventIn)
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		GrandHuntsTimer = "|cff00FF00"..SecondsToClock(nextEventIn) .." "
	end
	return GrandHuntsTimer
end
function CommunityFeastTimer() -- Искарские клыкарры
	-- local timePattern = "%02d:%02d";
	local TIMER = 1677168000-- 1670331660 -- CommunityFeastTimer
	local interval = 5400
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local CommunityFeastTimer = "|cffFF0000"..SecondsToClock(nextEventIn)
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		CommunityFeastTimer = "|cff00FF00"..SecondsToClock(nextEventIn) .." "
	end
	return CommunityFeastTimer
end
function PrimalStormsTimer() -- Праймал шторм
	-- local timePattern = "%02d:%02d";
	local TIMER = 1683804640-- 1671303600-- PrimalStormsTimer
	local interval = 18000-- 10800
	local duration = 7200
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local PrimalStormsTimer = "|cffFF0000"..SecondsToClock(nextEventIn)
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		PrimalStormsTimer = "|cff00FF00"..SecondsToClock(nextEventIn) .." "
	end
	return PrimalStormsTimer
end
function ResearchersUnderFireTimer()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ResearchersUnderFireTimer = "|cffFF0000"..SecondsToClock(nextEventIn)
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ResearchersUnderFireTimer = "|cff00FF00"..SecondsToClock(nextEventIn) .." "
	end
	return ResearchersUnderFireTimer
end
--LoadAddOn("Blizzard_PVPUI")
function Collect_PVP_Raitings()
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
-- 	local resultRAID = 7
-- 	-- local resultRAID = 0
-- 	-- if pointsRAID <= 2 then
-- 	-- resultRAID = 2
-- 	-- elseif pointsRAID > 2 and pointsRAID < 4 then
-- 	-- resultRAID = 4
-- 	-- elseif pointsRAID >= 4 then
-- 	-- resultRAID = 6
-- 	-- end
-- 	return resultRAID
-- end
-- local function getThresholdKEYS(pointsKEYS)
-- 	local resultKEYS = 8
-- 	-- local resultKEYS = 0
-- 	-- if pointsKEYS <= 1 then
-- 	-- resultKEYS = 1
-- 	-- elseif pointsKEYS > 1 and pointsKEYS < 4 then
-- 	-- resultKEYS = 4
-- 	-- elseif pointsKEYS >= 4 then
-- 	-- resultKEYS = 8
-- 	-- end
-- 	return resultKEYS
-- end
-- local function getThresholdPVP(pointsPVPS)
-- 	local resultPVPS = 5000
-- 	-- local resultPVPS = 0
-- 	-- if pointsPVPS <= 1250 then
-- 	-- resultPVPS = 1250
-- 	-- elseif pointsPVPS > 1250 and pointsPVPS < 2500 then
-- 	-- resultPVPS = 2500
-- 	-- elseif pointsPVPS >= 2500 then
-- 	-- resultPVPS = 5500
-- 	-- end
-- 	return resultPVPS
-- end
function CollectRioRaiting()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local RIOScore = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
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
-- 0	None
-- 1	MythicPlus
-- 2	RankedPvP
-- 3	Raid
-- 4	AlsoReceive
-- 5	Concession
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
	collect.RIO_Score = RIOScore or 0
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
								elseif dungeon == "405" then Abbr_En_Name = "BH(лощина)" --Brackenhide Hollow
								elseif dungeon == "245" then Abbr_En_Name = "FH(гавань)" --Freehold
								elseif dungeon == "406" then Abbr_En_Name = "HOI(чертоги)" --Halls of Infusion
								elseif dungeon == "206" then Abbr_En_Name = "NL(логово)" --Neltharion's Lair
								elseif dungeon == "404" then Abbr_En_Name = "NELT(нелтарий)" --Neltharus
								elseif dungeon == "251" then Abbr_En_Name = "UNDR(подгнилье)" --The Underrot
								elseif dungeon == "438" then Abbr_En_Name = "VP(вершина)" --The Vortex Pinnacle
								elseif dungeon == "403" then Abbr_En_Name = "ULD(ульдаман)" --Uldaman: Legacy of Tyr
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
		if hasAvailableRewards == true then collect.CurrentKey = "|cff00FFFF>>VAULT<<|r" end
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
	local vivod = 0
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
	elseif standingID == 8 then color ="|cff00ffff" standingTEXT = " ("..FACTION_STANDING_LABEL8..")" -- color ="|cff00ffff" Exalted
	elseif standingID == 9 then color ="|cff00ffff" standingTEXT = " ("..FACTION_STANDING_LABEL9..")" -- color ="|cff00ffff" Paragon
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID)
	local friendshipFactionID = reputationInfo.friendshipFactionID
	if not barMax then
		vivod = "not barMax"
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
				vivod = dev_text.."|cff00ffff"..--[[CompactNumberFormat]](value).."/"..--[[CompactNumberFormat]](threshold)..r
				if hasRewardPending then
					vivod = dev_text..CheckCompletedByQuestID(rewardQuestID)
				end
			end
			----------- МАЖОР ФАКШН
		elseif C_Reputation.IsMajorFaction(factionID) then
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cff4FFF79МАЖОР ФАКШН: |r" end
			local data = C_MajorFactions.GetMajorFactionData(factionID)
			local currentValue = data.renownReputationEarned
			local totalValue = data.renownLevelThreshold
			local standing = data.renownLevel
			vivod = dev_text..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue).."|cff00FF00("..--[[CompactNumberFormat]](standing)..")|r"
			if standing == 0 then vivod = 0 end
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
			elseif currentLevel == 6 then color = "|cff00ffff" standingTEXT = " (Best Friend)" -- 6
			end
			vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue) .. standingTEXT..r
			if currentLevel == maxLevel then vivod = dev_text.."|cff00ffffDone|r" end
			--if standing == 0 then vivod = 0 end
			----------- Other
		else
			if Octo_REPUTATION_DEV_text == true then dev_text = "|cffAF61FFOther: |r" end
			local currentValue = barValue-barMin
			local totalValue = barMax-barMin
			vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue)..standingTEXT..r
			if currentValue == totalValue or nextThreshold == 0 then vivod = dev_text.."|cff00ffffDone|r" end
			--if standingID == 0 or currentValue == 0 then vivod = 0 end
		end
	end
	return vivod
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
		if k ~= nil and v ~= nil then
			tinsert(currencyID, k)
		end
	end
end
CurrencyTEST()
local RARE_ZARALEK_LIST = {75271, 75285, 75298, 75326, 75576, 75314, 75296, 75353, 75358, 75274, 75366, 75336, 75269, 75334, 75322, 75267, 75476, 75276, 75342, 75338, 75340, 75360, 75292, 75349, 75364,
}
local RARE_OSTROV_LIST = {74331, 74347, 74345, 74336, 74337, 74342, 74321, 74343, 74338, 74329, 74307, 74325, 74346, 74344, 74332, 74306, 74333, 74341, 74305, 74339, 74300, 74349, 74322, 74330, 74328,
}
local EVENTS_ZARALEK_LIST = {75612, 75471, 75455, 75664, 75611, 75478, 75451, 75461, 75705, 75454, 75450, 75222, 75370, 75494, 75441, 75156, 75624, 74352,
}
local itemID = {
	205225, 206037, 205999, 206028, 138727, 138728, 138488, 138729, 138486, 167862, 206366, 204180, 204843, 206144, 206143, 206142, 206141, 206140, 206139, 185834, 201250, 204188, 204187, 204186, 204191, 204190, 204189, 203430, 203683, 203710, 204464, 205903, 204985, 205188, 205984, 204715, 204727, 204440, 204717, 24915, 24916, 24917, 24918, 24919, 49040, 50274, 51316, 51317, 51318, 51319, 51320, 51321, 52200, 52201, 52251, 52252, 52253, 122338, 122339, 122340, 122341, 128353, 129940, 129941, 129942, 129943, 129944, 129945, 129946, 129947, 129948, 129949, 129950, 129951, 129954, 129955, 133150, 133151, 133152, 133154, 133159, 133160, 137642, 141605, 141652, 143935, 143936, 143937, 143938, 143939, 143940, 143941, 143942, 143943, 143944, 143945, 143946, 143947, 151614, 151615, 166751, 167731, 167732, 167924, 167925, 167926, 167927, 167928, 167929, 167930, 167932, 168017, 168018, 180817, 183616, 187997, 187998, 188152, 189765, 190189, 190453, 190454, 190455, 190456, 191251, 191264, 191784, 191915, 192055, 192130, 192131, 192132, 193201, 193891, 193897, 193898, 193899, 193900, 193901, 193902, 193903, 193904, 193905, 193907, 193909, 193910, 193913, 194039, 194040, 194041, 194054, 194055, 194061, 194062, 194063, 194064, 194066, 194067, 194068, 194072, 194076, 194077, 194078, 194079, 194080, 194081, 194337, 194697, 194698, 194699, 194700, 194702, 194703, 194704, 194708, 197921, 198046, 198395, 198438, 198454, 198510, 198599, 198606, 198607, 198608, 198609, 198610, 198611, 198612, 198613, 198656, 198658, 198659, 198660, 198662, 198663, 198664, 198667, 198669, 198670, 198680, 198682, 198683, 198684, 198685, 198686, 198687, 198690, 198692, 198693, 198696, 198697, 198699, 198702, 198703, 198704, 198710, 198711, 198712, 198789, 198837, 198841, 198863, 198864, 198865, 198866, 198867, 198868, 198869, 198963, 198964, 198965, 198966, 198967, 198968, 198969, 198970, 198971, 198972, 198973, 198974, 198975, 198976, 198977, 198978, 199115, 199122, 199128, 199192, 199197, 199472, 199473, 199474, 199475, 199906, 200069, 200070, 200071, 200072, 200073, 200093, 200095, 200224, 200285, 200287, 200288, 200289, 200300, 200452, 200453, 200454, 200455, 200468, 200513, 200515, 200516, 200609, 200610, 200611, 200652, 200677, 200678, 200686, 200764, 200811, 200846, 200972, 200973, 200974, 200975, 200976, 200977, 200978, 200979, 200980, 200981, 200982, 201003, 201004, 201005, 201006, 201007, 201008, 201009, 201010, 201011, 201012, 201013, 201014, 201015, 201016, 201017, 201018, 201019, 201020, 201023, 201268, 201269, 201270, 201271, 201272, 201273, 201274, 201275, 201276, 201277, 201278, 201279, 201280, 201281, 201282, 201283, 201284, 201285, 201286, 201287, 201288, 201289, 201300, 201301, 201326, 201352, 201411, 201439, 201462, 201700, 201705, 201706, 201708, 201709, 201710, 201711, 201712, 201713, 201714, 201715, 201716, 201717, 201728, 201755, 201756, 201781, 201782, 201817, 201836, 201921, 201922, 201923, 201924, 201991, 202011, 202014, 202016, 202017, 202039, 202052, 202079, 202080, 202091, 202092, 202093, 202094, 202097, 202098, 202142, 202152, 202171, 202172, 202173, 202196, 202371, 202667, 202668, 202669, 202670, 202854, 202870, 202871, 202872, 203217, 203220, 203222, 203224, 203476, 203611, 203612, 203613, 203614, 203615, 203616, 203617, 203618, 203619, 203620, 203622, 203623, 203626, 203627, 203628, 203629, 203630, 203631, 203632, 203633, 203634, 203635, 203636, 203637, 203638, 203639, 203640, 203641, 203642, 203643, 203644, 203645, 203646, 203647, 203648, 203649, 203650, 203681, 203699, 203700, 203702, 204075, 204076, 204077, 204078, 204193, 204194, 204195, 204196, 204215, 204217, 204222, 204224, 204225, 204226, 204227, 204228, 204229, 204230, 204231, 204232, 204233, 204276, 204352, 204359, 204378, 204379, 204380, 204381, 204383, 204403, 204469, 204470, 204471, 204475, 204558, 204559, 204560, 204573, 204574, 204575, 204576, 204577, 204578, 204579, 204681, 204682, 204697, 204721, 204722, 204723, 204724, 204725, 204726, 204850, 204853, 204855, 204986, 204987, 204988, 204990, 204999, 205001, 205211, 205212, 205213, 205214, 205216, 205219, 205249, 205250, 205423, 205982, 205986, 205987, 205988, 205989, 206019, 206025, 206030, 206031, 206034, 206035, 205288, 205347,
}
-- local function itemID_TEST_INSERT()
-- for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
-- for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
-- local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
-- if containerInfo then
-- for k, v in pairs(containerInfo) do
-- if k == "itemID" then
--   tinsert(itemID, v)
-- end
-- end
-- end
-- end
-- end
-- end
local reputationID = {
	2564, -- Лоаммские ниффы
	2507, -- Драконья экспедиция
	2503, -- Кентавры Маруук
	2511, -- Искарские клыкарры
	2510, -- Союз Вальдраккена
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
	-- Ученики фиррака
	75239, --Шадейсетал
	55509, 55511, 13183, --ОЛО
	56339, 56337, --Ашран
	72167, -- 1500 на пвп
	72170,
	75622, -- трофей за пвп?
	75694, 74905, 75887, 74570, 74569, 74568, 75888, 74775, 75665, 24548, 40168, 40173, 40786, 40787, 45563, 47148, 55498, 55499, 64710, 66133, 66419, 66860, 66861, 66862, 66863, 66864, 66865, 66866, 66867, 66868, 66870, 66871, 66873, 66874, 66875, 69927, 69928, 69929, 69930, 70750, 70866, 70893, 70906, 71026, 72068, 72166, 72168, 72169, 72171, 72373, 72374, 72375, 72646, 72647, 72648, 72649, 72719, 72720, 72721, 72722, 72723, 72724, 72725, 72726, 72727, 72728, 72810, 73162, 74378, 74871, 75259, 75506, 76122, 36614,
}
local Meta_Table = {
	__index = function()
		return 0
	end
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
		Octo_ToDo_DragonflyLevels[curGUID].CurrencyID[v] = quantity
		Octo_ToDo_DragonflyLevels[curGUID].CurrencyID_maxQuantity[v] = maxQuantity
		--if CharInfo.UnitLevel >= 70 then tinsert(currencyID, 2167) end
		-- == 0 and nil or quantity
		-- Octo_ToDo_DragonflyLevels[curGUID].CurrencyID[v] = maxQuantity
		-- local c = "|cffffffff"
		-- local r = "|r"
		-- if maxQuantity > 0 and quantity == 0 then c = "|cff404040" end
		-- if maxQuantity > 0 and quantity == maxQuantity then c = "|cff00FF00" end
		-- if maxQuantity ~= 0 and quantity >= 1 then
		-- Octo_ToDo_DragonflyLevels[curGUID].CurrencyID[v] = c..CompactNumberFormat(quantity)..c.."/"..CompactNumberFormat(maxQuantity)..r
		-- end
	end
end
local function Empty_Zero(number)
	if number == 0 then
		return ""
	end
	return number
end
local function CollectAllItemsInBag()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local GetBindLocation = GetBindLocation()
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
		end
	end
end
-- local itemFragmentTable = {
--   204075,
-- }
local function Fragments_Earned()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	--15 204193 204075
	--16 204195 204076
	--17 204196 204077
	--18 204194 204078
	local countGreen = GetItemCount(204075, true, true, true)
	local countBlue = GetItemCount(204076, true, true, true)
	local countPurple = GetItemCount(204077, true, true, true)
	local countOrange = GetItemCount(204078, true, true, true)
	-- for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
	--   for slot=1, C_Container.GetContainerNumSlots(bag) do
	--     local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
	--     if containerInfo then
	--       local itemID = containerInfo.itemID
	--       --local iconFileID = containerInfo.iconFileID
	--       local itemLink = C_Container.GetContainerItemLink(bag, slot)
	--       --local isLocked = containerInfo.isLocked -- Добавить
	--       local ItemTooltip = _G["Octo_FRAGMENTS_ScanningTooltip"] or
	--       CreateFrame("GameTooltip", "Octo_FRAGMENTS_ScanningTooltip", WorldFrame, "GameTooltipTemplate")
	--       ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	--       ItemTooltip:ClearLines()
	--       ItemTooltip:SetHyperlink(itemLink)
	--       local foundFragments = nil
	--       local foundFragmentsnumber = 0
	--       local foundLevel = nil
	--       local emptySockets = 0
	--       local foundEmptySocket = nil
	--         for i = 1, ItemTooltip:NumLines() do
	--           -- |c%s%s/%s|r
	--           foundFragments = _G["Octo_FRAGMENTS_ScanningTooltipTextLeft" .. i]:GetText():match(ITEM_UPGRADE_FRAGMENTS_TOTAL)
	--           if foundFragments then
	--             --foundFragmentsnumber = tonumber(foundFragments) or 0
	--             foundFragmentsnumber = foundFragmentsnumber + 1
	--           end
	--           foundEmptySocket = _G["Octo_FRAGMENTS_ScanningTooltipTextLeft" .. i]:GetText():match(EMPTY_SOCKET_PRISMATIC)
	--           if foundEmptySocket then
	--             emptySockets = emptySockets + 1
	--           end
	--         end
	--     end
	--   end
	-- end
end
function CollectAllReputations()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	-- for i = 1, GetNumFactions() do
	-- local factionID = select(14, GetFactionInfo(i))
	-- local friendID, _, _, name = GetFriendshipReputation(factionID)
	-- if friendID then
	-- local currentRank, maxRank = GetFriendshipReputationRanks(friendID)
	-- end
	-- end
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
		if CheckCompletedByQuestID(v) == "|cff00FF00Done|r" and RARE_ZARALEK_count < #RARE_ZARALEK_LIST then
			RARE_ZARALEK_count = RARE_ZARALEK_count +1
		end
	end
	for k, v in ipairs(EVENTS_ZARALEK_LIST) do
		local qw = CheckCompletedByQuestID(v)
		collect.EVENTS_ZARALEK_LIST[v] = qw or 0
		if CheckCompletedByQuestID(v) == "|cff00FF00Done|r" and EVENTS_ZARALEK_count < #EVENTS_ZARALEK_LIST then
			EVENTS_ZARALEK_count = EVENTS_ZARALEK_count +1
		end
	end
	for k, v in ipairs(RARE_OSTROV_LIST) do
		local qw = CheckCompletedByQuestID(v)
		collect.RARE_OSTROV_LIST[v] = qw or 0
		if CheckCompletedByQuestID(v) == "|cff00FF00Done|r" and RARE_OSTROV_count < #RARE_OSTROV_LIST then
			RARE_OSTROV_count = RARE_OSTROV_count +1
		end
	end
	----------------------------------------
	collect.RARE_ZARALEK_count = RARE_ZARALEK_count
	collect.RARE_OSTROV_count = RARE_OSTROV_count
	collect.EVENTS_ZARALEK_count = EVENTS_ZARALEK_count
end
local function tmstpDayReset(n)
	n = n or 1
	local thursdayReset = GetCurrentRegion() == 3 and thursdayResetDay0EU or thursdayResetDay0US
	local currTime = GetServerTime()
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
function Octo_ToDo_DragonflyOnLoad()
	local EventFrame = CreateFrame("FRAME", AddonTitle..GenerateUniqueID())
	EventFrame:RegisterEvent("VARIABLES_LOADED")
	EventFrame:RegisterEvent("COVENANT_CHOSEN")
	EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
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
	--EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	EventFrame:RegisterEvent("PLAYER_LOGOUT")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
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
			-- bgFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 3,
	})
	UPGRADERANKS_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	UPGRADERANKS_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	local t = UPGRADERANKS_Frame:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\AddOns\\"..AddonName.."\\Media\\UPGRADERANKS.tga")
	t:SetAllPoints(UPGRADERANKS_Frame)
	UPGRADERANKS_Frame.texture = t
	UPGRADERANKS_Frame:SetPoint("CENTER", 0, 0)
	UPGRADERANKS_Frame:Hide()
end
local function CreateFrameUsableItems_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameUsableItems_OnLeave(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
end
local function CreateFrameUsableItems_OnEvent(self,event)
	if event == "BAG_UPDATE" then
		local sufficiently = GetItemCount(itemID, true, true, true) < self.count
		self.icon:SetDesaturated(sufficiently)
		self.icon:SetAlpha(sufficiently and .1 or 1)
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(Main_Frame)
		self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
		self:Show()
	end
end
local function CreateFrameUsableItems_OnMouseDown(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 0, 0, sufficiently and .1 or 1)
end
local function CreateFrameUsableItems_OnMouseUp(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
end
local function CreateFrameUsableItems(itemID, count, Ypos, r, g, b)
	local Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
	Button.itemID = itemID
	Button.Ypos = Ypos
	Button.count = count
	-- Button.r = r
	-- Button.g = g
	-- Button.b = b
	Button:SetSize(curHeight, curHeight)
	Button:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, Ypos)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Button:SetBackdropBorderColor(r, g, b, 0.2)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:RegisterEvent("BAG_UPDATE")
	Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(select(10, GetItemInfo(itemID)))
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
	return Button
end
function Octo_ToDo_DragonflyCreateAltFrame()
	Main_Frame = CreateFrame("BUTTON", AddonTitle..GenerateUniqueID(), UIParent, "BackdropTemplate")
	Main_Frame:SetClampedToScreen(false)
	Main_Frame:SetFrameStrata("DIALOG")
	Main_Frame:SetPoint("CENTER", 0, 0)
	Main_Frame:SetBackdrop({
			--elvui
			bgFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga",
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
	Main_Frame.CloseButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
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
	t:SetTexture("Interface\\AddOns\\"..AddonName.."\\Media\\CloseTest.tga")
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
	Main_Frame.OptionsButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
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
			Main_Frame:Hide()
			Settings.OpenToCategory(AddonName, true)
	end)
	local t = Main_Frame.OptionsButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.OptionsButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..AddonName.."\\Media\\ElvUI\\Arrow2.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.OptionsButton)
	-----------------------------------------------------
	Main_Frame.TestButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.TestButton:SetSize(curHeight, curHeight)
	Main_Frame.TestButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -60)
	Main_Frame.TestButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.TestButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.TestButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			--GameTooltip:AddLine("ToDragonbaneKeepTimer") -- "Title"
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("0 -> 398")
			GameTooltip:AddLine("|cffa335ee2 -> 402|r")
			GameTooltip:AddLine("|cffa335ee3 -> 405|r")
			GameTooltip:AddLine("|cffa335ee4 -> 405|r")
			GameTooltip:AddLine("|cffa335ee5 -> 408|r")
			GameTooltip:AddLine("|cffa335ee6 -> 408|r")
			GameTooltip:AddLine("|cffa335ee7 -> 411|r")
			GameTooltip:AddLine("|cffa335ee8 -> 411|r")
			GameTooltip:AddLine("|cffa335ee9 -> 415|r")
			GameTooltip:AddLine("|cffff800010 -> 415|r")
			GameTooltip:AddLine("|cffff800011 -> 418|r")
			GameTooltip:AddLine("|cffff800012 -> 418|r")
			GameTooltip:AddLine("|cffff800013 -> 421|r")
			GameTooltip:AddLine("|cffff800014 -> 421|r")
			GameTooltip:AddLine("|cffff800015 -> 424|r")
			GameTooltip:AddLine("|cffff800016 -> 424|r")
			GameTooltip:AddLine("|cffd9cc8017 -> 428|r")
			GameTooltip:AddLine("|cffd9cc8018 -> 428|r")
			GameTooltip:AddLine("|cffd9cc8019 -> 431|r")
			GameTooltip:AddLine("|cffd9cc8020 -> 431|r")
			GameTooltip:AddLine(" ")
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
	t:SetTexture("Interface\\AddOns\\"..AddonName.."\\Media\\ElvUI\\Arrow5.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.TestButton)
	-----------------------------------------------------
	Main_Frame.MarkOfHonor_Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.MarkOfHonor_Button:SetSize(curHeight, curHeight)
	Main_Frame.MarkOfHonor_Button:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -90)
	Main_Frame.MarkOfHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
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
				-- 	Main_Frame.MarkOfHonor_Button:Hide()
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
	t:SetTexture("Interface\\ICONS\\Ability_PVP_GladiatorMedallion.blp")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.MarkOfHonor_Button)
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.MedalofHonor_Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.MedalofHonor_Button:SetSize(curHeight, curHeight)
	Main_Frame.MedalofHonor_Button:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -120)
	Main_Frame.MedalofHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.MedalofHonor_Button:SetBackdropBorderColor(0, 0.8, 1, 1)
	Main_Frame.MedalofHonor_Button:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[204180] and CharInfo.ItemsInBag[204180] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[204180])
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.MedalofHonor_Button:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(0, 0.8, 1, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.MedalofHonor_Button:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.MedalofHonor_Button:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.MedalofHonor_Button:CreateTexture(nil, "BACKGROUND")
	Main_Frame.MedalofHonor_Button.icon = t
	t:SetTexture("Interface\\ICONS\\PVPCurrency-Conquest-Horde.blp")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.MedalofHonor_Button)
	-----------------------------------------------------
	-- ITEMID, count, Ypox, r, g, b
	CreateFrameUsableItems(204075, 15, 0, .12, 1, 0)
	CreateFrameUsableItems(204076, 15, -24, 0, .44, .98)
	CreateFrameUsableItems(204077, 15, -48, .64, .21, .93)
	CreateFrameUsableItems(204078, 15, -72, 1, .5, 0)
	CreateFrameUsableItems(204717, 2, -96, .85, .8, .5)
	-----------------------------------------------------
	-----------------------------------------------------
	StaticPopupDialogs[AddonName.."DELETE_ADDONDATA_RELOAD"] = {
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
	Main_Frame.RESETVARIABLES:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.RESETVARIABLES:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.RESETVARIABLES:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			--GameTooltip:AddLine("ToDragonbaneKeepTimer") -- "Title"
			GameTooltip:AddLine(RESET)
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
			StaticPopup_Show(AddonName.."DELETE_ADDONDATA_RELOAD")
	end)
	local t = Main_Frame.RESETVARIABLES:CreateTexture(nil, "BACKGROUND")
	Main_Frame.RESETVARIABLES.icon = t
	t:SetTexture("Interface\\AddOns\\"..AddonName.."\\Media\\ElvUI\\SadKitty.tga")
	-- t:SetTexture("Interface/BUTTONS/UI-GroupLoot-Pass-Up")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.RESETVARIABLES)
	local _, className, curClass = UnitClass("PLAYER")
	local classColor = C_ClassColor.GetClassColor(className)
	local r, g, b = classColor:GetRGB()
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, 0.2) --горизонт
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
		-- self.BG:UIFrameFadeOut(
		--   self.BG:UIFrameFadeOut.self,
		--   self.BG:UIFrameFadeOut.1,
		--   self.BG:UIFrameFadeOut.1,
		--   self.BG:UIFrameFadeOut.1,
		--   )
	end
	for i = 0, TotalLines do
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
	--
	Octo_ToDo_DragonflyAddDataToAltFrame()
	Main_Frame:Hide()
end
function OctoQuestUpdate()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
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
	collect.Octopussy_Timewalk = false
	if C_QuestLog.IsOnQuest(40173) or C_QuestLog.IsQuestFlaggedCompleted(40173) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(40173)
	elseif C_QuestLog.IsOnQuest(64710) or C_QuestLog.IsQuestFlaggedCompleted(64710) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(64710)
	elseif C_QuestLog.IsOnQuest(40168) or C_QuestLog.IsQuestFlaggedCompleted(40168) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(40168)
	elseif C_QuestLog.IsOnQuest(40786) or C_QuestLog.IsQuestFlaggedCompleted(40786) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(40786)
	elseif C_QuestLog.IsOnQuest(45563) or C_QuestLog.IsQuestFlaggedCompleted(45563) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(45563)
	elseif C_QuestLog.IsOnQuest(55499) or C_QuestLog.IsQuestFlaggedCompleted(55499) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(55499)
	elseif C_QuestLog.IsOnQuest(55498) or C_QuestLog.IsQuestFlaggedCompleted(55498) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(55498)
	elseif C_QuestLog.IsOnQuest(40787) or C_QuestLog.IsQuestFlaggedCompleted(40787) then collect.Octopussy_Timewalk = CheckCompletedByQuestID(40787)
	end
	collect.Octopussy_WeekendEvent = false
	if C_QuestLog.IsOnQuest(72728) or C_QuestLog.IsQuestFlaggedCompleted(72728) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72728)
	elseif C_QuestLog.IsOnQuest(72719) or C_QuestLog.IsQuestFlaggedCompleted(72719) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72719)
	elseif C_QuestLog.IsOnQuest(72720) or C_QuestLog.IsQuestFlaggedCompleted(72720) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72720)
	elseif C_QuestLog.IsOnQuest(72721) or C_QuestLog.IsQuestFlaggedCompleted(72721) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72721)
	elseif C_QuestLog.IsOnQuest(72722) or C_QuestLog.IsQuestFlaggedCompleted(72722) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72722)
	elseif C_QuestLog.IsOnQuest(72723) or C_QuestLog.IsQuestFlaggedCompleted(72723) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72723)
	elseif C_QuestLog.IsOnQuest(72724) or C_QuestLog.IsQuestFlaggedCompleted(72724) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72724)
	elseif C_QuestLog.IsOnQuest(72725) or C_QuestLog.IsQuestFlaggedCompleted(72725) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72725)
	elseif C_QuestLog.IsOnQuest(72726) or C_QuestLog.IsQuestFlaggedCompleted(72726) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72726)
	elseif C_QuestLog.IsOnQuest(72727) or C_QuestLog.IsQuestFlaggedCompleted(72727) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72727)
	elseif C_QuestLog.IsOnQuest(72728) or C_QuestLog.IsQuestFlaggedCompleted(72728) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72728)
	elseif C_QuestLog.IsOnQuest(72810) or C_QuestLog.IsQuestFlaggedCompleted(72810) then collect.Octopussy_WeekendEvent = CheckCompletedByQuestID(72810)
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
	collect.Octopussy_3kREP = ""
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
	collect.Octopussy_FightingisItsOwnReward = "" --Славный бой – это уже награда
	if C_QuestLog.IsOnQuest(76122) or C_QuestLog.IsQuestFlaggedCompleted(76122) == true then collect.Octopussy_FightingisItsOwnReward = CheckCompletedByQuestID(76122)
	end
	collect.Octopussy_AWorthyAllyLoammNiffen = "" --Достойный союзник: лоаммские ниффы
	if C_QuestLog.IsOnQuest(75665) or C_QuestLog.IsQuestFlaggedCompleted(75665) == true then collect.Octopussy_AWorthyAllyLoammNiffen = CheckCompletedByQuestID(75665)
	end
end
function OctoMoneyUpdate()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local Money = GetMoney()/10000
	collect.Money = Money
end
function OctoilvlStr()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	collect.avgItemLevel = avgItemLevel or 0
	collect.avgItemLevelEquipped = avgItemLevelEquipped or 0
	collect.avgItemLevelPvp = avgItemLevelPvp or 0
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
			return
			a.curServer < b.curServer or a.curServer == b.curServer
			and
			a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
			and
			-- a.Faction < b.Faction or a.Faction == b.Faction
			-- and
			b.Name < a.Name
	end)
	TotalMoney = 0
	for i, CharInfo in pairs(sorted) do
		local curCharGUID = CharInfo.GUID
		local curName = nil
		if CharInfo.Name == nil then
		curName = "UnLogged Char" else
			curName = CharInfo.Name
		end
		local Char_Frame
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
			for i = 1, TotalLines do
				local CF = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Char_Frame)
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
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.UnitLevel >= LevelToShow)) or
		(ShowOnlyCurrentRealm == false and CharInfo.UnitLevel >= LevelToShow) or
		(curGUID == CharInfo.GUID) then
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
				Char_Frame.UnitLevelBG:SetColorTexture(bgCr, bgCg, bgCb, 0.5)
				--Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel.." "..math.floor((CharInfo.currentXP/CharInfo.UnitXPMax)*100).."%"))
				Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel))
				Char_Frame.experience = Char_Frame:CreateTexture(nil, "ARTWORK")
				if CharInfo.currentXP == 0 then
					Char_Frame.experience:SetWidth(0.1)
				else
					Char_Frame.experience:SetWidth(CharInfo.currentXP/CharInfo.UnitXPMax*curWidth)
				end
				Char_Frame.experience:SetHeight(curHeight/2) --Высота
				Char_Frame.experience:SetTexture("Interface\\Addons\\"..AddonName.."\\Media\\statusbar\\O_03.tga")
				Char_Frame.experience:SetPoint("BOTTOMLEFT", Char_Frame, "TOPLEFT")
				Char_Frame.experience:SetVertexColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b, 1)
			elseif CharInfo.UnitLevel == 70 then
				-- Char_Frame.experience:Hide()
			end
			Char_Frame.CharName:SetSize(curWidth, curHeight)
			Char_Frame.CharName:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
			Char_Frame.CharName:SetFont(curFontTTF, curFontSize)
			Char_Frame.CharName:SetText(classcolor:WrapTextInColorCode(CharInfo.Name))
			-- if CharInfo.specIcon then
			--   Char_Frame.CharName:SetText("|T"..CharInfo.specIcon..":16:16:::64:64:4:60:4:60|t"..classcolor:WrapTextInColorCode(CharInfo.Name))
			-- end
			Char_Frame.CharName:SetWordWrap(true)
			Char_Frame.CharName:SetJustifyV("TOP")
			Char_Frame.curServer:SetSize(curWidth, curHeight)
			Char_Frame.curServer:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
			Char_Frame.curServer:SetFont(curFontTTF, curFontSize-2)
			Char_Frame.curServer:SetText(classcolor:WrapTextInColorCode(CharInfo.curServer))
			Char_Frame.curServer:SetWordWrap(false)
			Char_Frame.curServer:SetJustifyV("BOTTOM")
			---------------------------------------------
			-- StaticPopupDialogs[AddonName.."DELETE_CHARACTER"] = {
			--   text = DELETE.."?",
			--   button1 = YES,
			--   button2 = NO,
			--   hideOnEscape = 1,
			--   whileDead = 1,
			--   OnAccept = function() Octo_ToDo_DragonflyDeleteChar(curCharGUID) end,
			-- }
			---------------------------------------------
			Char_Frame.DeleteButton:SetSize(16, 10)
			Char_Frame.DeleteButton:SetPoint("TOP", Char_Frame, "BOTTOM", 0, -4)
			Char_Frame.DeleteButton:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", -- Interface/Addons/"..AddonName.."/Media/border/01 Octo.tga -- Interface/Buttons/white8x8
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
					--StaticPopup_Show(AddonName.."DELETE_CHARACTER")
					Octo_ToDo_DragonflyDeleteChar(curCharGUID)
			end)
			local t = Char_Frame.DeleteButton:CreateTexture(nil, "BACKGROUND")
			Char_Frame.DeleteButton.icon = t
			t:SetTexture("Interface\\Addons\\"..AddonName.."\\Media\\closeWHITE.tga")
			t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Char_Frame.DeleteButton)
			--1
			Main_Frame.TextLeft1:SetText("|T3753264:16:16:::64:64:4:60:4:60|t " .. ToDragonbaneKeepTimer() .." ".. L["Siege on Dragonbane Keep"])
			Char_Frame.CenterLines1.CL:SetText(CharInfo.Octopussy_DragonbaneKeep or NONE)
			if CharInfo.ItemsInBag[200072] ~= 0 then
				Char_Frame.CenterLines1.CL:SetText((CharInfo.Octopussy_DragonbaneKeep or NONE).." +"..CharInfo.ItemsInBag[200072]..func_itemTexture(200072))
			end
			--2
			Main_Frame.TextLeft2:SetText("|T1519430:16:16:::64:64:4:60:4:60|t " .. GrandHuntsTimer() ..L["Grand Hunt"])
			Char_Frame.CenterLines2.CL:SetText(CharInfo.Octopussy_TheGrandHunt or NONE)
			if CharInfo.ItemsInBag[200516] ~= 0 or
			CharInfo.ItemsInBag[200515] ~= 0 or
			CharInfo.ItemsInBag[200513] ~= 0 or
			CharInfo.ItemsInBag[200468] ~= 0 then
				Char_Frame.CenterLines2.CL:SetText((CharInfo.Octopussy_TheGrandHunt or NONE).." +"..
					(CharInfo.ItemsInBag[200516] + CharInfo.ItemsInBag[200515] + CharInfo.ItemsInBag[200513] + CharInfo.ItemsInBag[200468])
					..func_itemTexture(200468))
			end
			--3
			Main_Frame.TextLeft3:SetText("|T629056:16:16:::64:64:4:60:4:60|t " .. CommunityFeastTimer() .." " .. L["Community Feast"])
			Char_Frame.CenterLines3.CL:SetText(CharInfo.Octopussy_Feast or NONE)
			if CharInfo.ItemsInBag[200652] ~= 0 then
				Char_Frame.CenterLines3.CL:SetText((CharInfo.Octopussy_Feast or NONE).." +"..CharInfo.ItemsInBag[200652]..func_itemTexture(200652))
			end
			if CharInfo.ItemsInBag[200095] ~= 0 then
				Char_Frame.CenterLines3.CL:SetText((CharInfo.Octopussy_Feast or NONE).." +"..CharInfo.ItemsInBag[200095]..func_itemTexture(200095))
			end
			--4
			Main_Frame.TextLeft4:SetText("|T236469:16:16:::64:64:4:60:4:60|t " .. PrimalStormsTimer() .. " ".. L["The Storm's Fury"])
			Char_Frame.CenterLines4.CL:SetText(CharInfo.Octopussy_StormsFury or NONE)
			if CharInfo.ItemsInBag[203476] ~= 0 or
			CharInfo.ItemsInBag[202371] ~= 0 then
				Char_Frame.CenterLines4.CL:SetText((CharInfo.Octopussy_StormsFury or NONE).." +"..(CharInfo.ItemsInBag[203476]+CharInfo.ItemsInBag[202371])..func_itemTexture(202371))
			end
			--5
			Main_Frame.TextLeft5:SetText("|T236469:16:16:::64:64:4:60:4:60|t " .. ResearchersUnderFireTimer() .. " ".. L["Researchers Under Fire"])
			Char_Frame.CenterLines5.CL:SetText(CharInfo.Octopussy_ResearchersUnderFire or NONE)
			--6
			Main_Frame.TextLeft6:SetText("|T1603189:16:16:::64:64:4:60:4:60|t |cffFFFFFF".. func_questName(70750).."|r")
			Char_Frame.CenterLines6.CL:SetText(CharInfo.Octopussy_3kREP or NONE)
			if CharInfo.ItemsInBag[200073] ~= 0 then
				Char_Frame.CenterLines6.CL:SetText((CharInfo.Octopussy_3kREP or NONE).." +"..CharInfo.ItemsInBag[200073]..func_itemTexture(200073))
			end
			--7 1500 РЕПЫ НИФАМ
			Main_Frame.TextLeft7:SetText(func_questName(75665))
			if CharInfo.Octopussy_AWorthyAllyLoammNiffen then
				Char_Frame.CenterLines7.CL:SetText(CharInfo.Octopussy_AWorthyAllyLoammNiffen)
			end
			--8 ПЯТЬ РГЕРОВ 415 шмот
			Main_Frame.TextLeft8:SetText(func_questName(76122))
			if CharInfo.Octopussy_FightingisItsOwnReward then
				Char_Frame.CenterLines8.CL:SetText(CharInfo.Octopussy_FightingisItsOwnReward)
			end
			--9
			Main_Frame.TextLeft9:SetText(func_itemTexture(180653)..func_itemName(180653))
			Char_Frame.CenterLines9.CL:SetText(CharInfo.CurrentKey)
			if CharInfo.CurrentKey == 0 then Char_Frame.CenterLines9.CL:SetText("") end
			if CharInfo.CurrentKey ~= 0 and
			CharInfo.RIO_RAID ~= "" or CharInfo.RIO_RAID ~= "0/6 |cffa335ee|r" and
			CharInfo.RIO_KEYS ~= "" or CharInfo.RIO_KEYS ~= "0/8 |cffa335ee|r" and
			CharInfo.RIO_PVPS ~= "" or CharInfo.RIO_PVPS ~= "0/5500 |cffa335ee|r" then
				Char_Frame.CenterLines9.tooltip = {
					{"Рейды", CharInfo.RIO_RAID},
					{"M+", CharInfo.RIO_KEYS},
					{"PVP", CharInfo.RIO_PVPS},
				}
			end
			--10
			Main_Frame.TextLeft10:SetText(func_currencyicon(2245)..func_currencyName(2245)) -- Доблесть
			Char_Frame.CenterLines10.CL:SetText("|cff404040Валюта|r")
			if CharInfo.CurrencyID[2245] >= 1 then
				Char_Frame.CenterLines10.CL:SetText(func_currencyicon(2245).."|cff00ccff"..Empty_Zero(CharInfo.CurrencyID[2245]).."|r")
			end
			Char_Frame.CenterLines10.tooltip = {
				{"PVE: ", " "},
				{func_currencyicon(2533)..func_currencyName(2533), CharInfo.CurrencyID[2533].."/"..CharInfo.CurrencyID_maxQuantity[2533]}, --Возрождающее пламя Тьмы
				-- {func_currencyicon(2409)..func_currencyName(2409), CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]}, --
				-- {func_currencyicon(2410)..func_currencyName(2410), CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]}, --
				-- {func_currencyicon(2411)..func_currencyName(2411), CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]}, --
				-- {func_currencyicon(2412)..func_currencyName(2412), CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]}, --
				-- {func_currencyicon(1191)..func_currencyName(1191), CharInfo.CurrencyID[1191].."/"..CharInfo.CurrencyID_maxQuantity[1191]}, --Доблесть
				{func_currencyicon(2245)..func_currencyName(2245), CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]}, --Драконьи камни
				{func_currencyicon(2122)..func_currencyName(2122), CharInfo.CurrencyID[2122]}, --Печать бури
				{func_currencyicon(2118)..func_currencyName(2118), CharInfo.CurrencyID[2118]}, --Энергия стихий
				{func_currencyicon(2003)..func_currencyName(2003), CharInfo.CurrencyID[2003]}, --Припасы Драконьих островов
				-- {" ", " "},
				-- {"PVP: ", " "},
				-- {func_currencyicon(1602)..func_currencyName(1602), CharInfo.CurrencyID[1602].."/"..CharInfo.CurrencyID_maxQuantity[1602]}, --Очки завоевания
				-- {func_currencyicon(1792)..func_currencyName(1792), CharInfo.CurrencyID[1792].."/"..CharInfo.CurrencyID_maxQuantity[1792]}, --Честь
				-- {func_currencyicon(2123)..func_currencyName(2123), CharInfo.CurrencyID[2123]}, --Кровавые жетоны
				{" ", " "},
				{"OLD: ", " "},
				{func_currencyicon(2032)..func_currencyName(2032), func_currencyquantity(2032)},
				{func_currencyicon(1166)..func_currencyName(1166), CharInfo.CurrencyID[1166]}, --Искаженный временем знак
				{func_currencyicon(1226)..func_currencyName(1226), CharInfo.CurrencyID[1226]}, --Осколок пустоты
				{func_currencyicon(1220)..func_currencyName(1220), CharInfo.CurrencyID[1220]}, --Ресурсы опллота класса
				{func_currencyicon(824)..func_currencyName(824), CharInfo.CurrencyID[824].."/"..CharInfo.CurrencyID_maxQuantity[824]}, --Ресурсы гарнизона
			}
			-- for k, v in ipairs(currencyID) do
			--     if v ~= 2409 and v ~= 2410 and v ~= 2411 and v ~= 2412 then
			--         local count = tonumber(CharInfo.CurrencyID[v])
			--         if count ~= 0 and CharInfo.CurrencyID_maxQuantity[v] == 0 then
			--             if CharInfo.CurrencyID[2245] == 0 then Char_Frame.CenterLines10.CL:SetText("|cff404040"..CURRENCY.."|r") end
			--             Char_Frame.CenterLines10.tooltip[#Char_Frame.CenterLines10.tooltip+1] = {func_currencyicon(v)..func_currencyName(v), count}
			--         elseif count ~= 0 and CharInfo.CurrencyID_maxQuantity[v] ~= 0 and (count ~= CharInfo.CurrencyID_maxQuantity[v]) then
			--             if CharInfo.CurrencyID[2245] == 0 then Char_Frame.CenterLines10.CL:SetText("|cff404040"..CURRENCY.."|r") end
			--             Char_Frame.CenterLines10.tooltip[#Char_Frame.CenterLines10.tooltip+1] = {func_currencyicon(v)..func_currencyName(v), count.."/"..CharInfo.CurrencyID_maxQuantity[v]}
			--         elseif count ~= 0 and count == CharInfo.CurrencyID_maxQuantity[v] then
			--             if CharInfo.CurrencyID[2245] == 0 then Char_Frame.CenterLines10.CL:SetText("|cff404040"..CURRENCY.."|r") end
			--             Char_Frame.CenterLines10.tooltip[#Char_Frame.CenterLines10.tooltip+1] = {func_currencyicon(v)..func_currencyName(v), "|cff00FF00"..count.."/"..CharInfo.CurrencyID_maxQuantity[v].."|r"}
			--         end
			--     end
			-- end
			if #Char_Frame.CenterLines10.tooltip == 0 then
				Char_Frame.CenterLines10.tooltip = nil
			end
			--11
			Main_Frame.TextLeft11:SetText(func_reputationName(2564))
			Char_Frame.CenterLines11.tooltip = {}
			-- for k, v in ipairs(reputationID) do
			--     if CharInfo.reputationID[v] ~= 0 then
			--         Char_Frame.CenterLines11.CL:SetText("|cff404040"..REPUTATION.."|r")
			--         Char_Frame.CenterLines11.tooltip[#Char_Frame.CenterLines11.tooltip+1] = {func_reputationName(v), CharInfo.reputationID[v]}
			--     end
			-- end
			if CharInfo.reputationID ~= 0 then
				Char_Frame.CenterLines11.CL:SetText("|cff404040"..REPUTATION.."|r")
			end
			if CharInfo.reputationID[2564] ~= 0 then
				tinsert(Char_Frame.CenterLines11.tooltip, {func_reputationName(2564), CharInfo.reputationID[2564]})
			end
			if CharInfo.reputationID[2507] ~= 0 then
				tinsert(Char_Frame.CenterLines11.tooltip, {func_reputationName(2507), CharInfo.reputationID[2507]})
			end
			if CharInfo.reputationID[2503] ~= 0 then
				tinsert(Char_Frame.CenterLines11.tooltip, {func_reputationName(2503), CharInfo.reputationID[2503]})
			end
			if CharInfo.reputationID[2511] ~= 0 then
				tinsert(Char_Frame.CenterLines11.tooltip, {func_reputationName(2511), CharInfo.reputationID[2511]})
			end
			if CharInfo.reputationID[2510] ~= 0 then
				tinsert(Char_Frame.CenterLines11.tooltip, {func_reputationName(2510), CharInfo.reputationID[2510]})
			end
			if CharInfo.reputationID[2564] and CharInfo.reputationID[2564] ~= 0 then
				Char_Frame.CenterLines11.CL:SetText(CharInfo.reputationID[2564])
			end
			--tinsert(Char_Frame.CenterLines11.tooltip, {"qwe", CharInfo.ItemsInBag[192055]})
			if #Char_Frame.CenterLines11.tooltip == 0 then
				Char_Frame.CenterLines11.tooltip = nil
				Char_Frame.CenterLines11.CL:SetText("")
			end
			--12 204193 204075 2409
			Char_Frame.CenterLines12.tooltip = {}
			local PEREMENNAYA_2409 = ""
			if CharInfo.ItemsInBag[204193] >= 1 then
				tinsert(Char_Frame.CenterLines12.tooltip, {func_itemTexture(204193)..func_itemName(204193), CharInfo.ItemsInBag[204193]})
				PEREMENNAYA_2409 = func_itemTexture(204193).."|cff1eff00"..CharInfo.ItemsInBag[204193].."|r"
			end
			if CharInfo.ItemsInBag[204075] >= 1 then
				tinsert(Char_Frame.CenterLines12.tooltip, {func_itemTexture(204075)..func_itemName(204075), CharInfo.ItemsInBag[204075]})
			end
			if CharInfo.ItemsInBag[204075] >= 15 then
				PEREMENNAYA_2409 = PEREMENNAYA_2409.. "(+"..math.floor(CharInfo.ItemsInBag[204075]/15)..")"
			end
			if CharInfo.CurrencyID[2409] ~= 0 and (CharInfo.CurrencyID[2409] == CharInfo.CurrencyID_maxQuantity[2409]) then
				PEREMENNAYA_2409 = PEREMENNAYA_2409.."|cff00FF00*|r"
			end
			Char_Frame.CenterLines12.CL:SetText(PEREMENNAYA_2409)
			if (CharInfo.ItemsInBag[204193] ~= 0 or CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.CurrencyID[2409] ~= 0) and CharInfo.CurrencyID_maxQuantity[2409] ~= 0 then
				tinsert(Char_Frame.CenterLines12.tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]})
			end
			if #Char_Frame.CenterLines12.tooltip == 0 then
				Char_Frame.CenterLines12.tooltip = nil
				Char_Frame.CenterLines12.CL:SetText("")
			end
			--13 204195 204076 2410
			Char_Frame.CenterLines13.tooltip = {}
			local PEREMENNAYA_2410 = ""
			if CharInfo.ItemsInBag[204195] >= 1 then
				tinsert(Char_Frame.CenterLines13.tooltip, {func_itemTexture(204195)..func_itemName(204195), CharInfo.ItemsInBag[204195]})
				PEREMENNAYA_2410 = func_itemTexture(204195).."|cff0070dd"..CharInfo.ItemsInBag[204195].."|r"
			end
			if CharInfo.ItemsInBag[204076] >= 1 then
				tinsert(Char_Frame.CenterLines13.tooltip, {func_itemTexture(204076)..func_itemName(204076), CharInfo.ItemsInBag[204076]})
			end
			if CharInfo.ItemsInBag[204076] >= 15 then
				PEREMENNAYA_2410 = PEREMENNAYA_2410.. "(+"..math.floor(CharInfo.ItemsInBag[204076]/15)..")"
			end
			if CharInfo.CurrencyID[2410] ~= 0 and (CharInfo.CurrencyID[2410] == CharInfo.CurrencyID_maxQuantity[2410]) then
				PEREMENNAYA_2410 = PEREMENNAYA_2410.."|cff00FF00*|r"
			end
			Char_Frame.CenterLines13.CL:SetText(PEREMENNAYA_2410)
			if (CharInfo.ItemsInBag[204195] ~= 0 or CharInfo.ItemsInBag[204076] ~= 0 or CharInfo.CurrencyID[2410] ~= 0) and CharInfo.CurrencyID_maxQuantity[2410] ~= 0 then
				tinsert(Char_Frame.CenterLines13.tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]})
			end
			if #Char_Frame.CenterLines13.tooltip == 0 then
				Char_Frame.CenterLines13.tooltip = nil
				Char_Frame.CenterLines13.CL:SetText("")
			end
			--14 204196 204077 2411
			Char_Frame.CenterLines14.tooltip = {}
			local PEREMENNAYA_2411 = ""
			if CharInfo.ItemsInBag[204196] >= 1 then
				tinsert(Char_Frame.CenterLines14.tooltip, {func_itemTexture(204196)..func_itemName(204196), CharInfo.ItemsInBag[204196]})
				PEREMENNAYA_2411 = func_itemTexture(204196).."|cffa335ee"..CharInfo.ItemsInBag[204196].."|r"
			end
			if CharInfo.ItemsInBag[204077] >= 1 then
				tinsert(Char_Frame.CenterLines14.tooltip, {func_itemTexture(204077)..func_itemName(204077), CharInfo.ItemsInBag[204077]})
			end
			if CharInfo.ItemsInBag[204077] >= 15 then
				PEREMENNAYA_2411 = PEREMENNAYA_2411.. "(+"..math.floor(CharInfo.ItemsInBag[204077]/15)..")"
			end
			if CharInfo.CurrencyID[2411] ~= 0 and (CharInfo.CurrencyID[2411] == CharInfo.CurrencyID_maxQuantity[2411]) then
				PEREMENNAYA_2411 = PEREMENNAYA_2411.."|cff00FF00*|r"
			end
			Char_Frame.CenterLines14.CL:SetText(PEREMENNAYA_2411)
			if (CharInfo.ItemsInBag[204196] ~= 0 or CharInfo.ItemsInBag[204077] ~= 0 or CharInfo.CurrencyID[2411] ~= 0) and CharInfo.CurrencyID_maxQuantity[2411] ~= 0 then
				tinsert(Char_Frame.CenterLines14.tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]})
			end
			if #Char_Frame.CenterLines14.tooltip == 0 then
				Char_Frame.CenterLines14.tooltip = nil
				Char_Frame.CenterLines14.CL:SetText("")
			end
			--15 204194 204078 2412
			Char_Frame.CenterLines15.tooltip = {}
			local PEREMENNAYA_2412 = ""
			if CharInfo.ItemsInBag[204194] >= 1 then
				tinsert(Char_Frame.CenterLines15.tooltip, {func_itemTexture(204194)..func_itemName(204194), CharInfo.ItemsInBag[204194]})
				PEREMENNAYA_2412 = func_itemTexture(204194).."|cffff8000"..CharInfo.ItemsInBag[204194].."|r"
			end
			if CharInfo.ItemsInBag[204078] >= 1 then
				tinsert(Char_Frame.CenterLines15.tooltip, {func_itemTexture(204078)..func_itemName(204078), CharInfo.ItemsInBag[204078]})
			end
			if CharInfo.ItemsInBag[204078] >= 15 then
				PEREMENNAYA_2412 = PEREMENNAYA_2412.. "(+"..math.floor(CharInfo.ItemsInBag[204078]/15)..")"
			end
			if CharInfo.CurrencyID[2412] ~= 0 and (CharInfo.CurrencyID[2412] == CharInfo.CurrencyID_maxQuantity[2412]) then
				PEREMENNAYA_2412 = PEREMENNAYA_2412.."|cff00FF00*|r"
			end
			Char_Frame.CenterLines15.CL:SetText(PEREMENNAYA_2412)
			if (CharInfo.ItemsInBag[204194] ~= 0 or CharInfo.ItemsInBag[204078] ~= 0 or CharInfo.CurrencyID[2412] ~= 0) and CharInfo.CurrencyID_maxQuantity[2412] ~= 0 then
				tinsert(Char_Frame.CenterLines15.tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]})
			end
			if #Char_Frame.CenterLines15.tooltip == 0 then
				Char_Frame.CenterLines15.tooltip = nil
				Char_Frame.CenterLines15.CL:SetText("")
			end
			--16
			Main_Frame.TextLeft16:SetText(func_itemTexture(204440)..func_itemName(204440))
			local PEREMENNAYA_204440 = func_itemTexture(204440)..CharInfo.ItemsInBag[204440]
			Char_Frame.CenterLines16.tooltip = {}
			if CharInfo.ItemsInBag[204440] >= 1 then
				Char_Frame.CenterLines16.CL:SetText(PEREMENNAYA_204440)
			end
			if CharInfo.ItemsInBag[204717] >=1 then
				Char_Frame.CenterLines16.tooltip = {{func_itemTexture(204717)..func_itemName(204717), CharInfo.ItemsInBag[204717]}, }
			end
			if CharInfo.ItemsInBag[204717] >=2 then
				Char_Frame.CenterLines16.CL:SetText(PEREMENNAYA_204440.."|cffFF00FF(+"..(math.floor(CharInfo.ItemsInBag[204717]/2)) ..")|r")
			end
			if #Char_Frame.CenterLines16.tooltip == 0 then
				Char_Frame.CenterLines16.tooltip = nil
				--Char_Frame.CenterLines16.CL:SetText("")
			end
			--17 НОВЫЙ КАТАЛИСТ
			Main_Frame.TextLeft17:SetText(func_currencyicon(2533)..func_currencyName(2533))
			if CharInfo.CurrencyID[2533] >= 1 then
				Char_Frame.CenterLines17.CL:SetText(func_currencyicon(2533)..CharInfo.CurrencyID[2533])
			end
			--18
			Char_Frame.CenterLines18.CL:SetText(CharInfo.profID_prof1.icon .. " " .. CharInfo.profID_prof2.icon)
			if CharInfo.profID_prof1.icon == 0 then Char_Frame.CenterLines18.CL:SetText("") end
			Char_Frame.CenterLines18.tooltip = {}
			if CharInfo.prof1 ~= 0 or CharInfo.prof2 ~= 0 then
				Char_Frame.CenterLines18.tooltip = {
					{CharInfo.profID_prof1.icon.."|cffa335ee"..CharInfo.profID_prof1.name.."|r"},
					{"Сундуки", CharInfo.profID_prof1.chest.chest_count_prof1.."/"..CharInfo.profID_prof1.chest.questReq},
					{"Лут", CharInfo.profID_prof1.drops.drops_count_prof1.."/"..CharInfo.profID_prof1.drops.questReq},
					{"Квест", CharInfo.profID_prof1.profQuest.profQuest_count_prof1.."/"..CharInfo.profID_prof1.profQuest.questReq},
					{"Трактаты", CharInfo.profID_prof1.treatise.treatise_count_prof1.."/"..CharInfo.profID_prof1.treatise.questReq},
					{"Крафт", CharInfo.profID_prof1.craftOrder.craftOrder_count_prof1.."/"..CharInfo.profID_prof1.craftOrder.questReq},
					{" ", " "},
					{CharInfo.profID_prof2.icon.."|cffa335ee"..CharInfo.profID_prof2.name.."|r"},
					{"Сундуки", CharInfo.profID_prof2.chest.chest_count_prof2.."/"..CharInfo.profID_prof2.chest.questReq},
					{"Лут", CharInfo.profID_prof2.drops.drops_count_prof2.."/"..CharInfo.profID_prof2.drops.questReq},
					{"Квест", CharInfo.profID_prof2.profQuest.profQuest_count_prof2.."/"..CharInfo.profID_prof2.profQuest.questReq},
					{"Трактаты", CharInfo.profID_prof2.treatise.treatise_count_prof2.."/"..CharInfo.profID_prof2.treatise.questReq},
					{"Крафт", CharInfo.profID_prof2.craftOrder.craftOrder_count_prof2.."/"..CharInfo.profID_prof2.craftOrder.questReq},
				}
			end
			if CharInfo.ItemsInBag[204985] >= 1 or CharInfo.ItemsInBag[191784] >=1 then
				tinsert(Char_Frame.CenterLines18.tooltip, {" ", " "})
			end
			if CharInfo.ItemsInBag[204985] >= 1 then
				tinsert(Char_Frame.CenterLines18.tooltip, {func_itemTexture(204985)..func_itemName(204985), CharInfo.ItemsInBag[204985]})
			end
			if CharInfo.ItemsInBag[191784] >= 1 then
				tinsert(Char_Frame.CenterLines18.tooltip, {func_itemTexture(191784)..func_itemName(191784), CharInfo.ItemsInBag[191784]})
			end
			if #Char_Frame.CenterLines18.tooltip == 0 then
				Char_Frame.CenterLines18.tooltip = nil
				Char_Frame.CenterLines18.CL:SetText("")
			end
			--19
			local tinsertTABLE = {
				-- -- {name = L["Siege on Dragonbane Keep"], data=CharInfo.Octopussy_DragonbaneKeep},
				-- -- {name = L["Grand Hunt"], data=CharInfo.Octopussy_TheGrandHunt},
				-- -- {name = L["Community Feast"], data=CharInfo.Octopussy_Feast},
				-- -- {name = L["The Storm's Fury"], data=CharInfo.Octopussy_StormsFury},
				-- -- {name = func_questName(70750), data=CharInfo.Octopussy_3kREP}, --"Помощь союзу"
				-- {name = "WORLD BOSS", data=CharInfo.Octopussy_WB}, --"CharInfo.Octopussy_WB"
				-- {name = "WORLD BOSS "..func_questName(74892), data=CharInfo.Octopussy_WB_NEW},
				-- {name = DUNGEONS.. " (Поиски реликвии)", data=CharInfo.Octopussy_dungeons_RelicRecovery}, --"Octopussy_dungeons_RelicRecovery"
				-- {name = DUNGEONS.." (Сохранение прошлого)", data=CharInfo.Octopussy_dungeons_PreservingthePast}, --"CharInfo.Octopussy_dungeons_PreservingthePast"
				-- {name = PLAYER_DIFFICULTY_TIMEWALKER, data=CharInfo.Octopussy_Timewalk}, --"CharInfo.Octopussy_Timewalk"
				-- {name = CALENDAR_FILTER_WEEKLY_HOLIDAYS, data=CharInfo.Octopussy_WeekendEvent}, --"CharInfo.Octopussy_WeekendEvent"
				-- {name = func_questName(66133), data=CharInfo.Octopussy_KeysofLoyalty}, --"CharInfo.Octopussy_KeysofLoyalty" -- Присяга
				-- {name = "Запечатанный бурей сундук", data=CharInfo.Octopussy_StormBoundChest}, --"CharInfo.Octopussy_StormBoundChest" https://www.wowhead.com/ru/object=386356/
				-- {name = func_questName(72528), data=CheckCompletedByQuestID(72528)},
				-- {name = func_itemName(49623), data=CharInfo.questIDtable[24548]}, --Кв на ШМ
				-- -- {name = func_questName(76122), data=CharInfo.Octopussy_FightingisItsOwnReward},
				-- -- {name = func_questName(75665), data=CharInfo.Octopussy_AWorthyAllyLoammNiffen},
				-- {name = L["Fyrakk Asssaults"], data = CharInfo.Octopussy_FyrakkAssaults},
				-- -- {name ="", data =""},
				-- -- {name ="PVP: ", data =""}
				-- {name = func_questName(55509), data = CharInfo.questIDtable[55509]}, --Оло
				-- {name = func_questName(55511), data = CharInfo.questIDtable[55511]},
				-- {name = func_questName(13183), data = CharInfo.questIDtable[13183]},
				-- {name = func_questName(56339), data = CharInfo.questIDtable[56339]}, --Ашран
				-- {name = func_questName(56337), data = CharInfo.questIDtable[56337]},
				-- {name = func_questName(72167), data = CharInfo.questIDtable[72167]},
			}
			Char_Frame.CenterLines19.CL:SetText("|cff404040".. QUESTS_LABEL .."|r")
			Char_Frame.CenterLines19.tooltip = {}
			for k, v in ipairs(tinsertTABLE) do
				if v.data ~= false and v.data ~= "" and v.data ~= 0 then
					tinsert(Char_Frame.CenterLines19.tooltip, {v.name, v.data})
				end
			end
			for k, v in ipairs(questIDtable) do
				if CharInfo.questIDtable[v] ~= "" and CharInfo.questIDtable[v] ~= 0 then
					tinsert(Char_Frame.CenterLines19.tooltip, {func_questName(v), CharInfo.questIDtable[v]})
				end
			end
			if #Char_Frame.CenterLines19.tooltip == 0 then
				Char_Frame.CenterLines19.tooltip = nil
				Char_Frame.CenterLines19.CL:SetText("")
			end
			--20
			-- Char_Frame.CenterLines20.CL:SetText(func_itemTexture(190453)..Empty_Zero(CharInfo.ItemsInBag[190453]))
			-- if CharInfo.ItemsInBag[199197] ~= 0 then Char_Frame.CenterLines20.CL:SetText("|cffFF00FF"..func_itemTexture(190453)..CharInfo.ItemsInBag[190453].." (+"..CharInfo.ItemsInBag[199197]..")|r") end
			Char_Frame.CenterLines20.tooltip = {}
			for k, v in ipairs(itemID) do
				local count = tonumber(CharInfo.ItemsInBag[v])
				if count ~= 0 then
					--if CharInfo.ItemsInBag[190453] == 0 and CharInfo.ItemsInBag[199197] == 0 then Char_Frame.CenterLines20.CL:SetText("|cff404040"..ITEMS.."|r") end
					Char_Frame.CenterLines20.CL:SetText("|cff404040"..ITEMS.."|r")
					Char_Frame.CenterLines20.tooltip[#Char_Frame.CenterLines20.tooltip+1] = {func_itemTexture(v)..func_itemName(v), count}
				end
			end
			if #Char_Frame.CenterLines20.tooltip == 0 then
				Char_Frame.CenterLines20.tooltip = nil
				Char_Frame.CenterLines20.CL:SetText(" ")
			end
			--21
			--Char_Frame.CenterLines21.CL:SetText(format("|cff%s%.1f|r", CharInfo.avgItemLevel >= 430 and "00ff00" or CharInfo.avgItemLevel >= 400 and "ffff00" or "ff0000", CharInfo.avgItemLevel))
			Main_Frame.TextLeft21:SetText(LFG_LIST_ITEM_LEVEL_INSTR_SHORT)
			local PEREMENNAYA_PVP = ""
			Char_Frame.CenterLines21.tooltip = {}
			local pvpcolor = "|cffFF0000"
			if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
				if CharInfo.avgItemLevelEquipped > 440 then
					pvpcolor = "|cff4FFF79"
				elseif CharInfo.avgItemLevelEquipped > 400 then
					pvpcolor = "|cffFFF371"
				end
				PEREMENNAYA_PVP = pvpcolor..math.floor(CharInfo.avgItemLevelEquipped).."/"..math.floor(CharInfo.avgItemLevel).."|r"
				if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
					PEREMENNAYA_PVP = PEREMENNAYA_PVP.."|cff00FF00*|r"
					tinsert(Char_Frame.CenterLines21.tooltip, {"PVP:",math.floor(CharInfo.avgItemLevelPvp)})
				end
			end
			if #Char_Frame.CenterLines21.tooltip == 0 then
				Char_Frame.CenterLines21.tooltip = nil
				--Char_Frame.CenterLines21.CL:SetText(" ")
			end
			Char_Frame.CenterLines21.CL:SetText(PEREMENNAYA_PVP)
			--22
			local curServerShort = GetRealmName()
			local text = (curServerShort):gsub("-", " "):gsub("'", " ")
			local a, b = strsplit(" ", text)
			if b then
				curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
			end
			Main_Frame.TextLeft22:SetText("|T133784:16:16:::64:64:4:60:4:60|t ".."|cffFFF371"..curServerShort..": "..CompactNumberFormat(TotalMoney).."|r")
			Char_Frame.CenterLines22.CL:SetText("|T133784:16:16:::64:64:4:60:4:60|t".."|cffFFF371"..CompactNumberFormat(CharInfo.Money).."|r") -- 0.949, 0.902, 0.6 icon = 133784 https://www.wowhead.com/icons/name:coin
			Char_Frame.CenterLines22.tooltip = {}
			if CharInfo.GetBindLocation then
				tinsert(Char_Frame.CenterLines22.tooltip, {"|cffFF0000"..func_itemTexture(6948)..CharInfo.GetBindLocation.."|r"})
			end
			if CharInfo.CurrentLocation then
				tinsert(Char_Frame.CenterLines22.tooltip, {func_itemTexture(40536) ..CharInfo.CurrentLocation})
			end
			if CharInfo.specId and CharInfo.specName and CharInfo.specIcon then
				tinsert(Char_Frame.CenterLines22.tooltip, {"|T"..CharInfo.specIcon..":16:16:::64:64:4:60:4:60|t"..classcolor:WrapTextInColorCode(CharInfo.specName)}) --SPECIALIZATION,
			end
			if CharInfo.avgItemLevel then
				tinsert(Char_Frame.CenterLines22.tooltip, {LFG_LIST_ITEM_LEVEL_INSTR_SHORT, format("|cff%s%.1f|r", CharInfo.avgItemLevel >= 410 and "00ff00" or CharInfo.avgItemLevel >= 390 and "ffff00" or "ff0000", CharInfo.avgItemLevel)})
			end
			if CharInfo.avgItemLevelEquipped then
				tinsert(Char_Frame.CenterLines22.tooltip, {STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, format("|cff%s%.1f|r", CharInfo.avgItemLevelEquipped >= 410 and "00ff00" or CharInfo.avgItemLevelEquipped >= 390 and "ffff00" or "ff0000", CharInfo.avgItemLevelEquipped)})
			end
			if CharInfo.avgItemLevelPvp then
				tinsert(Char_Frame.CenterLines22.tooltip, {LFG_LIST_ITEM_LEVEL_INSTR_PVP_SHORT, format("|cff%s%.1f|r", CharInfo.avgItemLevelPvp >= 410 and "00ff00" or CharInfo.avgItemLevelPvp >= 390 and "ffff00" or "ff0000", CharInfo.avgItemLevelPvp )})
			end
			if #Char_Frame.CenterLines22.tooltip == 0 then
				Char_Frame.CenterLines22.tooltip = nil
			end
			--23
			Char_Frame.CenterLines23.CL:SetText("PVP")
			Char_Frame.CenterLines23.tooltip = {
				{CURRENCY..": ", " "},
				{func_currencyicon(1602)..func_currencyName(1602), CharInfo.CurrencyID[1602].."/"..CharInfo.CurrencyID_maxQuantity[1602]}, --Очки завоевания
				{func_currencyicon(1792)..func_currencyName(1792), CharInfo.CurrencyID[1792].."/"..CharInfo.CurrencyID_maxQuantity[1792]}, --Честь
				{func_currencyicon(2123)..func_currencyName(2123), CharInfo.CurrencyID[2123]}, --Кровавые жетоны
				{" "," "},
				{QUESTS_LABEL..": ", " "},
				-- {func_questName(55509),CharInfo.questIDtable[55509]}, --ОЛО
				-- {func_questName(55511),CharInfo.questIDtable[55511]}, --ОЛО
				-- {func_questName(13183),CharInfo.questIDtable[13183]}, --ОЛО
				-- {func_questName(56339),CharInfo.questIDtable[56339]}, --АШРАН
				-- {func_questName(56337),CharInfo.questIDtable[56337]}, --АШРАН
				{func_questName(75622),CharInfo.questIDtable[75622]},
				{func_questName(71026),CharInfo.questIDtable[71026]},
				{func_questName(72169),CharInfo.questIDtable[72169]},
				{func_questName(72167),CharInfo.questIDtable[72167]},
				{func_questName(72166),CharInfo.questIDtable[72166]},
				{func_questName(72168),CharInfo.questIDtable[72168]},
				{func_questName(72171),CharInfo.questIDtable[72171]},
				{func_questName(72170),CharInfo.questIDtable[72170]},
				-- {" "," "},
				-- {"Предметы: ", " "},
				-- {func_itemTexture(137642)..func_itemName(137642),CharInfo.ItemsInBag[137642]},
				-- {func_itemTexture(204180)..func_itemName(204180),CharInfo.ItemsInBag[204180]},
				{" "," "},
				{"2v2: ", CharInfo.PVP.rating2v2.." WR:"..CharInfo.PVP.winrate2v2},
				{"3v3: ", CharInfo.PVP.rating3v3.." WR:"..CharInfo.PVP.winrate3v3},
				{"RBG: ", CharInfo.PVP.ratingRBG.." WR:"..CharInfo.PVP.winrateRBG},
			}
			--24
			Char_Frame.CenterLines24.CL:SetText("PVE")
			Char_Frame.CenterLines24.tooltip = {
				{CURRENCY..": ", " "},
				{func_currencyicon(2533)..func_currencyName(2533), CharInfo.CurrencyID[2533].."/"..CharInfo.CurrencyID_maxQuantity[2533]}, --Возрождающее пламя Тьмы
				{func_currencyicon(2245)..func_currencyName(2245), CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]}, --Драконьи камни
				{func_currencyicon(2122)..func_currencyName(2122), CharInfo.CurrencyID[2122]}, --Печать бури
				{func_currencyicon(2118)..func_currencyName(2118), CharInfo.CurrencyID[2118]}, --Энергия стихий
				{func_currencyicon(2003)..func_currencyName(2003), CharInfo.CurrencyID[2003]}, --Припасы Драконьих островов
				-- {" "," "},
				-- {QUESTS_LABEL..": ", " "},
				-- {func_questName(55509),CharInfo.questIDtable[55509]}, --ОЛО
				-- {func_questName(55511),CharInfo.questIDtable[55511]}, --ОЛО
				-- {func_questName(13183),CharInfo.questIDtable[13183]}, --ОЛО
				-- {func_questName(56339),CharInfo.questIDtable[56339]}, --АШРАН
				-- {func_questName(56337),CharInfo.questIDtable[56337]}, --АШРАН
				-- {func_questName(75622),CharInfo.questIDtable[75622]},
				-- {func_questName(71026),CharInfo.questIDtable[71026]},
				-- {func_questName(72169),CharInfo.questIDtable[72169]},
				-- {func_questName(72167),CharInfo.questIDtable[72167]},
				-- {func_questName(72166),CharInfo.questIDtable[72166]},
				-- {func_questName(72168),CharInfo.questIDtable[72168]},
				-- {func_questName(72171),CharInfo.questIDtable[72171]},
				-- {func_questName(72170),CharInfo.questIDtable[72170]},
				{" "," "},
				{"Предметы: ", " "},
				{func_itemTexture(205225)..func_itemName(205225),CharInfo.ItemsInBag[205225].."/12"},
				{func_itemTexture(205999)..func_itemName(205999),CharInfo.ItemsInBag[205999]},
				-- {func_itemTexture(204075).."|cff1eff00"..func_itemName_NOCOLOR(204075).."|r", CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]},
				-- {func_itemTexture(204076).."|cff0070dd"..func_itemName_NOCOLOR(204076).."|r", CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]},
				-- {func_itemTexture(204077).."|cffa335ee"..func_itemName_NOCOLOR(204077).."|r", CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]},
				-- {func_itemTexture(204078).."|cffff8000"..func_itemName_NOCOLOR(204078).."|r", CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]},
				--25
				Char_Frame.CenterLines25.CL:SetText(Empty_Zero(CharInfo.PVP.ratingRBG))
			}
			--------------------------------
			if curGUID == curCharGUID then
				Char_Frame.BG:Show()
				Char_Frame.BG:SetAlpha(0.2)
			end
		end
		local curAltFrameWidth = #Main_Frame.AllCharFrames * curWidth/2
		Main_Frame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(TotalLines+1))
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
function Octo_ToDo_DragonflyFrameUpdateValues()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER") or 0
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	collect.currentXP = currentXP
	collect.UnitXPMax = UnitXPMax
	collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
	collect.Name = curCharName
	collect.curServer = curServer
	collect.Class = curClass
	collect.GUID = curGUID
	collect.Faction = UnitFactionGroup("PLAYER")
	collect.UnitLevel = UnitLevel
	collect.specId = specId
	collect.specName = specName
	collect.specIcon = specIcon
end
local function checkCharInfo(CharInfo)
	CharInfo.Name = CharInfo.Name or "NO NAME"
	CharInfo.curServer = CharInfo.curServer or ""
	CharInfo.avgItemLevel = CharInfo.avgItemLevel or 0
	CharInfo.classColor = CharInfo.classColor or {r = 0.5, g = 0.5, b = 0.5}
	CharInfo.Class = CharInfo.Class or 1
	CharInfo.Faction = CharInfo.Faction or "Horde"
	CharInfo.UnitLevel = CharInfo.UnitLevel or 1
	if (CharInfo.tmstp or 0) < GetServerTime() and CharInfo.Octopussy_3kREP == "|cff00FF00Done|r" then
		CharInfo.Octopussy_3kREP = false
	end
	if (CharInfo.tmstp or 0) < GetServerTime() and CharInfo.Octopussy_FightingisItsOwnReward == "|cff00FF00Done|r" then
		CharInfo.Octopussy_FightingisItsOwnReward = false
	end
	if (CharInfo.tmstp or 0) < GetServerTime() and CharInfo.Octopussy_AWorthyAllyLoammNiffen == "|cff00FF00Done|r" then
		CharInfo.Octopussy_AWorthyAllyLoammNiffen = false
	end
	if (CharInfo.tmstp or 0) < GetServerTime() and CharInfo.CurrentKey ~= 0 then
		CharInfo.CurrentKey = "|cff00FFFF>>VAULT<<|r"
	end
	if (CharInfo.tmstp or 0) < GetServerTime() then
		CharInfo.tmstp = tmstpDayReset(7)
		CharInfo.Octopussy_Feast = false
		CharInfo.Octopussy_DragonbaneKeep = false
		CharInfo.Octopussy_TheGrandHunt = false
		CharInfo.Octopussy_StormsFury = false
		CharInfo.Octopussy_ResearchersUnderFire = false
		CharInfo.Octopussy_WB = false
		CharInfo.Octopussy_WB_NEW = false
		CharInfo.Octopussy_FyrakkAssaults = false
		CharInfo.Octopussy_Timewalk = false
		CharInfo.Octopussy_WeekendEvent = false
		CharInfo.Octopussy_dungeons_RelicRecovery = false
		CharInfo.Octopussy_dungeons_PreservingthePast = false
		CharInfo.Octopussy_StormBoundChest = false
		--CharInfo.Octopussy_FightingisItsOwnReward = false
		--CharInfo.Octopussy_3kREP = false
		CharInfo.RIO_weeklyBest = ""
		CharInfo.RIO_RAID = ""
		CharInfo.RIO_KEYS = ""
		CharInfo.RIO_PVPS = ""
	end
	if (CharInfo.tmstp or 0) < GetServerTime() then
		CharInfo.tmstp = tmstpDayReset(1)
		CharInfo.RARE_ZARALEK_LIST = {}
		CharInfo.EVENTS_ZARALEK_LIST = {}
		CharInfo.RARE_OSTROV_LIST = {}
	end
	CharInfo.CurrencyID = CharInfo.CurrencyID or {}
	CharInfo.CurrencyID_maxQuantity = CharInfo.CurrencyID_maxQuantity or {}
	CharInfo.PVP = CharInfo.PVP or {}
	CharInfo.ItemsInBag = CharInfo.ItemsInBag or {}
	CharInfo.reputationID = CharInfo.reputationID or {}
	CharInfo.RIOScore = CharInfo.RIOScore or 0
	CharInfo.questIDtable = CharInfo.questIDtable or {}
	CharInfo.RARE_ZARALEK_LIST = CharInfo.RARE_ZARALEK_LIST or {}
	CharInfo.RARE_OSTROV_LIST = CharInfo.RARE_OSTROV_LIST or {}
	CharInfo.EVENTS_ZARALEK_LIST = CharInfo.RARE_ZARALEK_LIST or {}
	CharInfo.RARE_ZARALEK_count = CharInfo.RARE_ZARALEK_count or 0
	CharInfo.RARE_OSTROV_count = CharInfo.RARE_OSTROV_count or 0
	CharInfo.EVENTS_ZARALEK_count = CharInfo.EVENTS_ZARALEK_count or 0
	setmetatable(CharInfo.CurrencyID, Meta_Table)
	setmetatable(CharInfo.CurrencyID_maxQuantity, Meta_Table)
	setmetatable(CharInfo.PVP, Meta_Table)
	setmetatable(CharInfo.ItemsInBag, Meta_Table)
	setmetatable(CharInfo.reputationID, Meta_Table)
	setmetatable(CharInfo.questIDtable, Meta_Table)
	setmetatable(CharInfo.RARE_ZARALEK_LIST, Meta_Table)
	setmetatable(CharInfo.RARE_OSTROV_LIST, Meta_Table)
	setmetatable(CharInfo.EVENTS_ZARALEK_LIST, Meta_Table)
	--setmetatable(CharInfo.GetBindLocation, Meta_Table)
	CharInfo.profID_prof1 = CharInfo.profID_prof1 or {}
	CharInfo.profID_prof1.name = CharInfo.profID_prof1.name or 0
	CharInfo.profID_prof1.chest = CharInfo.profID_prof1.chest or {}
	CharInfo.profID_prof1.craftOrder = CharInfo.profID_prof1.craftOrder or {}
	CharInfo.profID_prof1.drops = CharInfo.profID_prof1.drops or {}
	CharInfo.profID_prof1.profQuest = CharInfo.profID_prof1.profQuest or {}
	CharInfo.profID_prof1.treatise = CharInfo.profID_prof1.treatise or {}
	setmetatable(CharInfo.profID_prof1, Meta_Table)--icon
	--setmetatable(CharInfo.profID_prof1.name, Meta_Table) --icon
	setmetatable(CharInfo.profID_prof1.chest, Meta_Table)
	setmetatable(CharInfo.profID_prof1.craftOrder, Meta_Table)
	setmetatable(CharInfo.profID_prof1.drops, Meta_Table)
	setmetatable(CharInfo.profID_prof1.profQuest, Meta_Table)
	setmetatable(CharInfo.profID_prof1.treatise, Meta_Table)
	CharInfo.profID_prof2 = CharInfo.profID_prof2 or {}
	CharInfo.profID_prof2.name = CharInfo.profID_prof2.name or 0
	CharInfo.profID_prof2.chest = CharInfo.profID_prof2.chest or {}
	CharInfo.profID_prof2.craftOrder = CharInfo.profID_prof2.craftOrder or {}
	CharInfo.profID_prof2.drops = CharInfo.profID_prof2.drops or {}
	CharInfo.profID_prof2.profQuest = CharInfo.profID_prof2.profQuest or {}
	CharInfo.profID_prof2.treatise = CharInfo.profID_prof2.treatise or {}
	setmetatable(CharInfo.profID_prof2, Meta_Table) --icon
	--setmetatable(CharInfo.profID_prof2.name, Meta_Table) --icon
	setmetatable(CharInfo.profID_prof2.chest, Meta_Table)
	setmetatable(CharInfo.profID_prof2.craftOrder, Meta_Table)
	setmetatable(CharInfo.profID_prof2.drops, Meta_Table)
	setmetatable(CharInfo.profID_prof2.profQuest, Meta_Table)
	setmetatable(CharInfo.profID_prof2.treatise, Meta_Table)
end
function Octo_ToDo_DragonflyOnEvent(self, event, ...)
	if InCombatLockdown() then return end
	-- if Main_Frame and Main_Frame:IsShown() and not InCombatLockdown() then
	-- 	print (event)
	-- 	Collect_PVP_Raitings()
	-- end
	if event == "ACTIONBAR_UPDATE_COOLDOWN" and not InCombatLockdown() then
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
			ToDragonbaneKeepTimer()
			GrandHuntsTimer()
			CommunityFeastTimer()
			PrimalStormsTimer()
			ResearchersUnderFireTimer()
			CollectAllProfessions()
			CollectRioRaiting()
			--Collect_PVP_Raitings()
			CollectCurrentKEY()
			OctoilvlStr()
			CollectAllReputations()
		end
	elseif event == "QUEST_FINISHED" and not InCombatLockdown() then
		OctoQuestUpdate()
		CollectAllQuests()
	elseif event == "QUEST_COMPLETE" and not InCombatLockdown() then
		OctoQuestUpdate()
		CollectAllQuests()
	elseif event == "QUEST_LOG_UPDATE" and not InCombatLockdown() then
		OctoQuestUpdate()
		CollectAllQuests()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_MONEY" and not InCombatLockdown() then
		OctoMoneyUpdate()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "CURRENCY_DISPLAY_UPDATE" and not InCombatLockdown() then
		CollectAllCurrency()
		-- CurrencyTEST()
		if Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "VARIABLES_LOADED" and not InCombatLockdown() then
		if Octo_ToDo_DragonflyLevels == nil then
			Octo_ToDo_DragonflyLevels = {
			}
		end
		if Octo_ToDo_DragonflyVars == nil then
			Octo_ToDo_DragonflyVars = {
			}
		end
		local MinimapName = AddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = 3528288,
				OnClick = function(_, button)
					Main_Frame:SetShown(not Main_Frame:IsShown())
					-- PlaySoundFile("Interface\\AddOns\\Octo_ToDo_Dragonfly\\Media\\sound\\Memes\\Gnome Woo.ogg", "Master")
					CollectAllItemsInBag()
					Fragments_Earned()
					CollectAllReputations()
					Collect_PVP_Raitings()
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle)
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DragonflyVars.omb = Octo_ToDo_DragonflyVars.omb or {}
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DragonflyVars.omb)
		ldbi:Show(MinimapName)
		Octo_ToDo_DragonflyVars.config = Octo_ToDo_DragonflyVars.config or {}
		if Octo_ToDo_DragonflyVars.config.CVar == nil then  --RELOAD
			Octo_ToDo_DragonflyVars.config.CVar = false
		end
		if Octo_ToDo_DragonflyVars.config.InputDelete == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.InputDelete = false
		end
		if Octo_ToDo_DragonflyVars.config.UsableItems == nil then
			Octo_ToDo_DragonflyVars.config.UsableItems = false
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
		if Octo_ToDo_DragonflyVars.config.UIErrorsFrame == nil then
			Octo_ToDo_DragonflyVars.config.UIErrorsFrame = false
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
		if Octo_ToDo_DragonflyVars.config.BugSack == nil then   --RELOAD
			Octo_ToDo_DragonflyVars.config.BugSack = true
		end
		if Octo_ToDo_DragonflyVars.config.MountsJournal == nil then   --RELOAD
			Octo_ToDo_DragonflyVars.config.MountsJournal = true
		end
		for i, func in ipairs(E.modules) do
			func()
		end
	elseif event == "UNIT_INVENTORY_CHANGED" and not InCombatLockdown() then
		OctoilvlStr()
		Octo_ToDo_DragonflyFrameUpdateValues()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_LOGIN" and not InCombatLockdown() then
		Collect_PVP_Raitings()
		local curGUID = UnitGUID("PLAYER")
		Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
		self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
			checkCharInfo(CharInfo)
		end
		Octo_ToDo_DragonflyFrameUpdateValues()
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		OctoQuestUpdate()
		OctoMoneyUpdate()
		OctoilvlStr()
		Octo_ToDo_DragonflyCreateAltFrame()
		CollectAllCurrency()
		-- CurrencyTEST()
		CollectAllProfessions()
		CollectAllItemsInBag()
		Fragments_Earned()
		CollectAllReputations()
		TESTREP()
		CollectRioRaiting()
		CollectCurrentKEY()
		CollectAllQuests()
		UPGRADERANKS_Frame()
		--itemID_TEST_INSERT()
	elseif event == "PLAYER_LOGOUT" and not InCombatLockdown() then
		Collect_PVP_Raitings()
	elseif event == "PLAYER_LEAVING_WORLD" and not InCombatLockdown() then
		-- OctoMoneyUpdate()
		-- CollectAllCurrency()
		CollectRioRaiting()
		-- Collect_PVP_Raitings()
		-- elseif event == "PLAYER_LOGOUT" then
		-- CollectAllItemsInBag()
		-- CollectCurrentKEY()
	elseif event == "PLAYER_ENTERING_WORLD" and not InCombatLockdown() then
		Collect_PVP_Raitings()
	elseif event == "BAG_UPDATE" and not InCombatLockdown() then
		CollectAllItemsInBag()
		Fragments_Earned()
		CollectCurrentKEY()
		--itemID_TEST_INSERT()
	elseif event == "HEARTHSTONE_BOUND" and not InCombatLockdown() then
		CollectAllItemsInBag()
		Fragments_Earned()
	elseif event == "ZONE_CHANGED" and not InCombatLockdown() then
		CollectAllItemsInBag()
		Fragments_Earned()
	elseif event == "ZONE_CHANGED_NEW_AREA" and not InCombatLockdown() then
		CollectAllItemsInBag()
		Fragments_Earned()
	-- elseif event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		-- Collect_PVP_Raitings()
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