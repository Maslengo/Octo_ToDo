local GlobalAddonName, E =...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local strsplit = strsplit
local GetClassColor = GetClassColor or C_ClassColor.GetClassColor
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
local IsSpellKnown = IsSpellKnown
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
local IsComplete = IsComplete or C_QuestLog.IsComplete
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
local GetInfo = GetInfo or C_QuestLog.GetInfo
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
local IsFailed = IsFailed or C_QuestLog.IsFailed
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
local GetSecondsUntilWeeklyReset = GetSecondsUntilWeeklyReset or C_DateAndTime.GetSecondsUntilWeeklyReset
local GetWeeklyResetStartTime = GetWeeklyResetStartTime or C_DateAndTime.GetWeeklyResetStartTime
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
local IsFollowerOnCompletedMission = IsFollowerOnCompletedMission or C_Garrison.IsFollowerOnCompletedMission
local GetFollowerNameByID = GetFollowerNameByID or C_Garrison.GetFollowerNameByID -- (garrFollowerID)
local GetPlayerAuraBySpellID = GetPlayerAuraBySpellID or C_UnitAuras.GetPlayerAuraBySpellID
-- local GetFollowerName = GetFollowerName or C_Garrison.GetFollowerName -- (followerID)
local GetMountIDs = C_MountJournal.GetMountIDs
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
local GetMountFromItem = C_MountJournal.GetMountFromItem
local classR, classG, classB = GetClassColor(E.classFilename)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function GetOrCreateCache(category)
	Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB[category] = Octo_Cache_DB[category] or {}
	return Octo_Cache_DB[category]
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_itemName_CACHE(id, forcedQuality)
	local Cache = GetOrCreateCache("AllItems", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		if forcedQuality then
			local colorHex = ITEM_QUALITY_COLORS[forcedQuality].hex
			return colorHex..Cache[id][E.curLocaleLang].."|r"
		end
		return Cache[id][E.curLocaleLang]
	end
	local name = GetItemNameByID(id)
	local quality = GetItemQualityByID(id)
	if name and name ~= "" and quality then
		Cache[id] = Cache[id] or {}
		local colorHex = ITEM_QUALITY_COLORS[quality].hex
		local result = colorHex..name.."|r"
		Cache[id][E.curLocaleLang] = result
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..ITEMS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetItemName(id, forcedQuality)
	if not id then return end
	id = tonumber(id)
	local name = func_itemName_CACHE(id, forcedQuality)
	return name..E.debugInfo_Items(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_currencyName_CACHE(id, forcedQuality)
	local Cache = GetOrCreateCache("AllCurrencies", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		local hasMount = E.OctoTable_CurrencyMountForFuncCurName[id] or false
		if id == 3252 or id == 1166 then
			hasMount = true
		end
		if forcedQuality then
			local colorHex = ITEM_QUALITY_COLORS[forcedQuality].hex
			return colorHex..Cache[id][E.curLocaleLang].."|r"..(hasMount and E.COLOR_LIME.."*|r" or "")
		end
		return Cache[id][E.curLocaleLang]..(hasMount and E.COLOR_RED.."*|r" or "")
	end
	local info = GetCurrencyInfo(id)
	if not info then
		return E.COLOR_RED..UNKNOWN.."|r"
	end
	local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
	local name = info.name
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = colorHex..info.name.."|r"
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..CURRENCY.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetCurrencyName(id, forcedQuality)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_currencyName_CACHE(id, forcedQuality)
	return cachedName..E.debugInfo_Currencies(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_npcName_CACHE(id)
	local Cache = GetOrCreateCache("AllNPCs", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	E.ScanningTooltipFUNC = E.ScanningTooltipFUNC or CreateFrame("GameTooltip", E.MainAddonName.."ScanningTooltipFUNC", nil, "GameTooltipTemplate")
	local tooltip = E.ScanningTooltipFUNC
	tooltip:Hide()
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:ClearLines()
	tooltip:SetHyperlink("unit:Creature-0-0-0-0-"..id)
	local name
	if tooltip:NumLines() > 0 then
		for i = 1, tooltip:NumLines() do
			if i == 1 then
				name = _G[E.MainAddonName.."ScanningTooltipFUNCTextLeft1"]:GetText()
			end
		end
	end
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME.."NPC".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetNPCName(id)
	if not id then return end
	id = tonumber(id)
	if E.func_IsPTR() and E.OctoTable_AllNPCs_DB and E.OctoTable_AllNPCs_DB[id] and E.OctoTable_AllNPCs_DB[id] then
		return E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] or UNKNOWN
	else
		local cachedName = func_npcName_CACHE(id)
		return cachedName..E.debugInfo_NPCs(id)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_questName_CACHE(id)
	local Cache = GetOrCreateCache("AllQuests", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = (GetTitleForQuestID or GetQuestInfo)(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..QUESTS_LABEL.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetQuestName(id, ShowIcon)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_questName_CACHE(id)
	if ShowIcon == false then
		return cachedName..E.debugInfo_Quests(id)
	end
	return E.func_GetQuestIcon(id)..cachedName..E.debugInfo_Quests(id)
end
function E.func_GetQuestIcon(id)
	local icon = ""
	----------------------------------------------------------------
	local info = C_QuestLog.GetQuestTagInfo(id)
	if info and info.tagID and QUEST_TAG_ATLAS[info.tagID] then
		local atlasName = QUEST_TAG_ATLAS[info.tagID]
		icon = icon..E.func_texturefromIcon(atlasName, nil, nil, true)
	end
	----------------------------------------------------------------
	local classification, _, atlasName = QuestUtil.GetQuestClassificationDetails(id)
	if classification and atlasName then
		icon = icon..E.func_texturefromIcon(atlasName, nil, nil, true)
	end
	----------------------------------------------------------------
	return icon
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_reputationName_CACHE(id)
	local Cache = GetOrCreateCache("AllReputations", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = ""
	local repInfo = GetFactionDataByID(id)
	if repInfo then
		name = repInfo.name
	else
		local reputationInfo = GetFriendshipReputation(id)
		if reputationInfo.name then
			name = reputationInfo.name
		end
	end
	if name and name ~= "" then
		-- local isAccountWide = IsAccountWideReputation(id) or false
		-- if isAccountWide == true then
		-- name = E.ICON_ACCOUNT_WIDE..name
		-- end
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..REPUTATION.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	elseif E.OctoTable_Reputations_DB[id] then
		if E.OctoTable_Reputations_DB[id][E.curLocaleLang] ~= "NONE" then
			return E.OctoTable_Reputations_DB[id][E.curLocaleLang]..E.COLOR_SKYBLUE.." (DB)|r"
		elseif E.OctoTable_Reputations_DB[id]["enUS"] then
			return E.OctoTable_Reputations_DB[id]["enUS"]..E.COLOR_SLATEGRAY.." (enUS)|r"
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetReputationName(id)
	if not id then return end
	id = tonumber(id)
	return func_reputationName_CACHE(id)..E.debugInfo_Reputations(id)
end
function E.func_GetReputationIcon(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData then
		return reputationData.icon1
	end
	return
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_spellName_CACHE(id)
	local Cache = GetOrCreateCache("AllSpells", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetSpellName(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..SPELLS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetSpellName(id)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_spellName_CACHE(id)
	return cachedName..E.debugInfo_Spells(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_achievementName_CACHE(id)
	-- /run opde(Octo_Cache_DB.AllAchievements)
	local Cache = GetOrCreateCache("AllAchievements", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = select(2, GetAchievementInfo(id))
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..LOOT_JOURNAL_LEGENDARIES_SOURCE_ACHIEVEMENT.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetAchievementName(id)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_achievementName_CACHE(id)
	return cachedName..E.debugInfo_Achievements(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_mountName_CACHE(id)
	-- /run opde(Octo_Cache_DB.AllAchievements)
	local Cache = GetOrCreateCache("AllMounts", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetMountInfoByID(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..MOUNTS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetMountName(mountID)
	if not mountID then return end
	local cachedName = func_mountName_CACHE(mountID)
	return cachedName..E.debugInfo_Mounts(mountID)
end
function E.func_GetMountTexture(mountID)
	if not mountID then return end
	return select(3, GetMountInfoByID(mountID))
end
function E.func_IsMountCollected(mountID)
	if not mountID then return end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected
end
function E.func_GetMountCollectedColor(mountID)
	if not mountID then return end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected and E.COLOR_WHITE or E.COLOR_RED
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_mapName_CACHE(id)
	local Cache = GetOrCreateCache("AllMaps", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetMapInfo(id).name
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME.."MAPS".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetMapName(id)
	if not id then return end
	id = tonumber(id)
	-- if C_Map.GetBestMapForUnit("player") == id then
	-- return E.COLOR_NECROLORD..">>"..func_mapName_CACHE(id).."<<|r"
	-- end
	local cachedName = func_mapName_CACHE(id)
	return cachedName..E.debugInfo_Maps(id)
end
function E.func_GetFullMapName(id)
	if not id then return end
	id = tonumber(id)
	local info = GetMapInfo(id)
	if not info then
		return UNKNOWN
	end
	local groupID = GetMapGroupID(id)
	if groupID then
		local groupdata = GetMapGroupMembersInfo(groupID)
		for _, subzonedata in ipairs(groupdata) do
			if subzonedata.mapID == id then
				return info.name, " ("..subzonedata.name..")"
			end
		end
	end
	return info.name, ""
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.Cache_All_EventNames_Year()
	if not GetNumDayEvents then return end
	local currentYear = GetCurrentCalendarTime().year
	for month = 1, 12 do
		local monthInfo = GetMonthInfo(month, currentYear)
		if not monthInfo then
			break
		end
		SetAbsMonth(month, currentYear)
		for day = 1, monthInfo.numDays do
			local numEvents = GetNumDayEvents(0, day)
			for i = 1, numEvents do
				local event = GetDayEvent(0, day, i)
				if not event or event.calendarType ~= "HOLIDAY" then break end
				local Cache = GetOrCreateCache("AllEvents", event.eventID)
				Cache[event.eventID] = Cache[event.eventID] or {}
				Cache[event.eventID][E.curLocaleLang] = event.title
			end
		end
	end
end
local function func_EventName_CACHE(id)
	-- E.Cache_All_EventNames_Year()
	-- local Cache = GetOrCreateCache("AllEvents")
	local Cache = Octo_Cache_DB.AllEvents
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name
	if not E.Holiday or next(E.Holiday) == nil then
		if E.Collect_Holidays then
			pcall(E.Collect_Holidays)
		end
	end
	for eventKey, v in next, (E.Holiday) do
		if id == v.eventID then
			name = v.title or ""
		end
	end
	if not name or name == "" then
		return E.COLOR_RED..UNKNOWN.."|r"
	end
	Cache[id] = Cache[id] or {}
	Cache[id][E.curLocaleLang] = name
	if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
		print (E.COLOR_LIME.."MAPS".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetEventName(id)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_EventName_CACHE(id)
	return cachedName..E.debugInfo_Events(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ProfessionName_CACHE(id)
	local Cache = GetOrCreateCache("AllProfessions", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetTradeSkillDisplayName(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			print (E.COLOR_LIME..PROFESSIONS_TRACKER_HEADER_PROFESSION.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r" -- RETRIEVING_DATA
	return output
end
function E.func_GetProfessionName(id)
	if not id then return end
	id = tonumber(id)
	local cachedName = func_ProfessionName_CACHE(id)
	return cachedName..E.debugInfo_Professions(id)
end
-- function E.func_GetProfessionName(id)
-- if not id then return end
-- id = tonumber(id)
-- local result = GetTradeSkillDisplayName(id)
-- return result..E.debugInfo_Professions(id)
-- end
function E.func_GetDungeonName(id) -- 721 Чертоги доблести
	if not id then return end
	id = tonumber(id)
	-- EJ_SelectInstance(7)
	-- local name = EJ_GetInstanceInfo(id)
	local name = EJ_GetInstanceInfo(id) or RETRIEVING_DATA
	return name
end