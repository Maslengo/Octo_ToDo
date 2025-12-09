local GlobalAddonName, E =...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local strsplit = strsplit
local table_sort = table.sort
local table_insert = table.insert
local table_concat = table.concat
local table_remove = table.remove
local string_format = string.format
local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min
local math_max = math.max
local tonumber = tonumber
local tostring = tostring
local select = select
local ipairs = ipairs
local next = next
local type = type
local CreateFrame = CreateFrame
local GetTime = GetTime
local GetServerTime = GetServerTime
local UnitClass = UnitClass
local UnitFactionGroup = UnitFactionGroup
local UnitFullName = UnitFullName
local UnitGUID = UnitGUID
local UnitSex = UnitSex
local GetClassColor = GetClassColor or C_ClassColor.GetClassColor
local GetRealmName = GetRealmName
local GetCurrentRegion = GetCurrentRegion
local GetCurrentRegionName = GetCurrentRegionName
local GetBuildInfo = GetBuildInfo
local GetPhysicalScreenSize = GetPhysicalScreenSize
local GetQuestProgressBarPercent = GetQuestProgressBarPercent
local GetQuestObjectiveInfo = GetQuestObjectiveInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local BNGetInfo = BNGetInfo
local PlayerHasToy = PlayerHasToy
local GameTooltip = GameTooltip
local Settings = Settings
local SettingsPanel = SettingsPanel
local HideUIPanel = HideUIPanel
local UIParent = UIParent
local WorldFrame = WorldFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local QUEST_WATCH_QUEST_READY = QUEST_WATCH_QUEST_READY
local FAILED = FAILED
local UNKNOWN = UNKNOWN
local RETRIEVING_DATA = RETRIEVING_DATA
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
function E.func_IsClassic() return E.interfaceVersion > 10000 and E.interfaceVersion < 20000 end
function E.func_IsBC() return E.interfaceVersion > 20000 and E.interfaceVersion < 30000 end
function E.func_IsWOTLK() return E.interfaceVersion > 30000 and E.interfaceVersion < 40000 end
function E.func_IsCataclysm() return E.interfaceVersion > 40000 and E.interfaceVersion < 50000 end
function E.func_IsMOP() return E.interfaceVersion > 50000 and E.interfaceVersion < 60000 end
function E.func_IsWOD() return E.interfaceVersion > 60000 and E.interfaceVersion < 70000 end
function E.func_IsLegion() return E.interfaceVersion > 70000 and E.interfaceVersion < 80000 end
function E.func_IsBFA() return E.interfaceVersion > 80000 and E.interfaceVersion < 90000 end
function E.func_IsShadowlands() return E.interfaceVersion > 90000 and E.interfaceVersion < 100000 end
function E.func_IsDragonflight() return E.interfaceVersion > 100000 and E.interfaceVersion < 110000 end
function E.func_IsTWW() return E.interfaceVersion > 110000 and E.interfaceVersion < 120000 end
function E.func_IsMidnight() return E.interfaceVersion > 120000 and E.interfaceVersion < 130000 end
function E.func_IsTLT() return E.interfaceVersion > 130000 and E.interfaceVersion < 140000 end
function E.func_IsRetail() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE end
function E.func_IsPTR() return GetCurrentRegion() >= 72 end -- 90 BETA midnight
function E.func_IsRemix()
	return PlayerIsTimerunning()
	-- return GetPlayerAuraBySpellID(1213439)
end
function E.func_vignetteIcon(atlasName, iconWidth, iconHeight)
	if not atlasName then return end
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	return CreateAtlasMarkup(atlasName, iconWidth, iconHeight)
end
function E.func_texturefromIcon(icon, iconWidth, iconHeight, isAtlas)
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	if isAtlas then
		return E.func_vignetteIcon(icon, iconWidth, iconHeight)
	else
		return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconWidth)..":"..(iconHeight)..":::64:64:6:58:6:58|t "
	end
end
function E.func_texturefromIconEVENT(icon, iconSize)
	iconSize = iconSize or 16
	return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconSize)..":"..(iconSize)..":::128:128:0:91:0:91|t "
end
function E.func_GetItemIconByID(itemID)
	return GetItemIconByID(itemID)
end
function E.func_ItemPriceTSM(itemID, myCount)
	local result = ""
	local count = 0
	if myCount then
		count = myCount
	else
		count = E.func_GetItemCount(itemID, true, true, true, false)
	end
	if TSM_API then
		local TSM_ItemIDtest = "i:"..itemID
		local CustomPriceValue = (TSM_API.GetCustomPriceValue("DBMarket", TSM_ItemIDtest)) or 0
		if count and count ~= 0 and CustomPriceValue ~= 0 then
			if count ~= 1 then
				result = result..E.Purple_Color.."*"..count.."|r ("..TSM_API.FormatMoneyString(CustomPriceValue*count)..")"
			else
				result = result..TSM_API.FormatMoneyString(CustomPriceValue)
			end
		end
	end
	if result ~= "" then
		return result
	else
		return ""
	end
end
function E.func_LFGdungName(dID)
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID == dID then
			return name
		end
	end
	return RETRIEVING_DATA
end
function E.func_GetSpellIcon(spellID)
	return GetSpellTexture(spellID)
end
function E.func_GetCurrencyIcon(currencyID)
	local info = GetCurrencyInfo(currencyID)
	return info and info.iconFileID or E.ICON_EMPTY
end
local function GetOrCreateCache(category)
	Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB[category] = Octo_Cache_DB[category] or {}
	return Octo_Cache_DB[category]
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_itemName_CACHE(id)
	local Cache = GetOrCreateCache("AllItems", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetItemNameByID(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..ITEMS.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_itemName(id, forcedQuality)
	if not id then return end
	local quality = GetItemQualityByID(id) or 0
	if forcedQuality then
		quality = forcedQuality
	end
	-- local icon = E.func_texturefromIcon(E.func_GetItemIconByID(id)) or ""
	local colorHex = ITEM_QUALITY_COLORS[quality].hex
	local name = func_itemName_CACHE(id)
	-- local result = icon..colorHex..name.."|r"
	local result = colorHex..name.."|r"
	return result..E.debugInfo_Items(id)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_currencyName_CACHE(id)
	local Cache = GetOrCreateCache("AllCurrencies", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local info = GetCurrencyInfo(id)
	if not info then
		return E.Red_Color..UNKNOWN.."|r"
	end
	local WarbandIcon = ""
	if IsAccountTransferableCurrency(id) then
		WarbandIcon = E.ICON_ACCOUNT_TRANSFERABLE
	elseif IsAccountWideCurrency(id) then
		WarbandIcon = E.ICON_ACCOUNT_WIDE
	end
	local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
	local name = info.name
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = colorHex..info.name.."|r"..WarbandIcon
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..CURRENCY.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_currencyName(id)
	if not id then return end
	-- local cachedName = (E.func_texturefromIcon(E.func_GetCurrencyIcon(id)) or "")..func_currencyName_CACHE(id)
	local cachedName = func_currencyName_CACHE(id)
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color.."NPC".."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_npcName(id)
	if not id then return end
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..QUESTS_LABEL.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_questName(id, ShowIcon)
	if not id then return end
	local cachedName = func_questName_CACHE(id)
	if ShowIcon == false then
		return cachedName..E.debugInfo_Quests(id)
	end
	return E.func_questIcon(id)..cachedName..E.debugInfo_Quests(id)
end
function E.func_questIcon(id)
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
		local isAccountWide = IsAccountWideReputation(id) or false
		if isAccountWide == true then
			name = E.ICON_ACCOUNT_WIDE..name
		end
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..REPUTATION.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_reputationName(id)
	if not id then return end
	local sideIcon = ""
	local side = "-"
	if E.OctoTable_ReputationsDB[id] then
		side = E.OctoTable_ReputationsDB[id].side
		if E.OctoTable_ReputationsDB[id].icon2 ~= "" then
			sideIcon = E.func_texturefromIcon(E.OctoTable_ReputationsDB[id].icon2)
		end
	end
	if side == "Alliance" then
		sideIcon = E.func_texturefromIcon(E.ICON_ALLIANCE)..sideIcon
		sideIcon = E.Blue_Color..sideIcon.."|r"
	elseif side == "Horde" then
		sideIcon = E.func_texturefromIcon(E.ICON_HORDE)..sideIcon
		sideIcon = E.Red_Color..sideIcon.."|r"
	end
	return sideIcon..func_reputationName_CACHE(id)..E.debugInfo_Reputations(id)
end
function E.func_reputaionIcon(id)
	if E.OctoTable_ReputationsDB[id] then
		return E.OctoTable_ReputationsDB[id].icon
	end
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..SPELLS.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_spellName(id)
	if not id then return end
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..LOOT_JOURNAL_LEGENDARIES_SOURCE_ACHIEVEMENT.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_achievementName(id)
	if not id then return end
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..MOUNTS.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_mountName(mountID)
	if not mountID then return end
	local cachedName = func_mountName_CACHE(mountID)
	return cachedName..E.debugInfo_Mounts(mountID)
end
function E.func_mountIcon(mountID)
	if not mountID then return end
	return select(3, GetMountInfoByID(mountID))
end
function E.func_mountIsCollected(mountID)
	if not mountID then return end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected
end
function E.func_mountIsCollectedColor(mountID)
	if not mountID then return end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected and E.White_Color or E.Red_Color
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color.."MAPS".."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_mapName(id)
	if not id then return end
	if C_Map.GetBestMapForUnit("player") == id then
		return E.COLOR_NECROLORD..">>"..func_mapName_CACHE(id).."<<|r"
	end
	local cachedName = func_mapName_CACHE(id)
	return cachedName..E.debugInfo_Maps(id)
end
function E.func_GetMapNameFromID(id)
	if not id then return end
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
		if E.Collect_All_Holiday then
			pcall(E.Collect_All_Holiday)
		end
	end
	for eventKey, v in next, (E.Holiday) do
		if id == v.eventID then
			name = v.title or ""
		end
	end
	if not name or name == "" then
		return E.Red_Color..UNKNOWN.."|r"
	end
	Cache[id] = Cache[id] or {}
	Cache[id][E.curLocaleLang] = name
	if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
		print (E.Lime_Color.."MAPS".."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_EventName(id)
	if not id then return end
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
		if Octo_Debug_DB and Octo_Debug_DB.DebugCache then
			print (E.Lime_Color..PROFESSIONS_TRACKER_HEADER_PROFESSION.."|r", E.Addon_Left_Color..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.Addon_Right_Color..id.."|r")
		end
	end
	local vivod = Cache[id] and Cache[id][E.curLocaleLang] or E.Lime_Color..RETRIEVING_DATA.."|r"
	return vivod
end
function E.func_ProfessionName(id)
	if not id then return end
	local cachedName = func_ProfessionName_CACHE(id)
	return cachedName..E.debugInfo_Professions(id)
end
-- function E.func_ProfessionName(id)
-- if not id then return end
-- local result = GetTradeSkillDisplayName(id)
-- return result..E.debugInfo_Professions(id)
-- end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_IsAccountQuest(questID)
	return IsAccountQuest(questID)
end
function E.func_IsQuestFlaggedCompletedOnAccount(questID)
	return IsQuestFlaggedCompletedOnAccount(questID)
end
function E.func_getMapFullNameInfo(mapID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	local mapGroupID = C_Map.GetMapGroupID(mapID)
	if mapGroupID then
		local mapGroupInfo = C_Map.GetMapGroupMembersInfo(mapGroupID)
		if mapGroupInfo then
			for _, mapGroupMemberInfo in ipairs(mapGroupInfo) do
				if mapGroupMemberInfo.mapID == mapID then
					mapInfo.name = ("%s (%s)"):format(mapInfo.name, mapGroupMemberInfo.name)
					break
				end
			end
		end
	end
	return mapInfo
end
function E.func_GetCurrentLocation()
	local curRealZone = GetRealZoneText() -- C_Map.GetBestMapForUnit("player") ПОФИКСИТЬ (УСТАРЕЛО?)
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText() -- C_Map.GetMapInfo() ПОФИКСИТЬ (УСТАРЕЛО?)
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText() -- C_Map.GetMapInfo() ПОФИКСИТЬ (УСТАРЕЛО?)
	local uiMapID = MapUtil.GetDisplayableMapForPlayer()
	if uiMapID ~= 0 then
		local mapInfo = E.func_getMapFullNameInfo(uiMapID)
		if FIRSTtext == "" then
			return E.Red_Color..mapInfo.name.."|r", false
		elseif FIRSTtext == SECONDtext then
			return FIRSTtext, true
		else
			return SECONDtext ~= "" and FIRSTtext.." ("..SECONDtext..")" or FIRSTtext, true
		end
	end
	return UNKNOWN, true
end
function E.func_GetItemInfo(itemInfo)
	return GetItemInfo(itemInfo)
end
function E.func_GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if not itemID then return end
	return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
end
function E.func_GetItemLink(itemID)
	local _, link = E.func_GetItemInfo(itemID)
	return link
end
function E.func_GetItemQuality(itemID)
	return GetItemQualityByID(itemID) or 0
end
function E.func_GetItemQualityColorID(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQuality(itemID)]
end
function E.func_GetHexColorFromQuality(quality)
	local numQuality = tonumber(quality)
	if numQuality and numQuality > 0 and numQuality < 8 then
		return ITEM_QUALITY_COLORS[numQuality].hex
	end
	return E.White_Color
end
function E.func_GetItemQualityColor(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
function E.func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
function E.func_GetDetailedItemLevelInfo(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
function E.func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactNumberRound(result)
end
function E.func_GetSpellSubtext(spellID)
	local result = GetSpellSubtext(spellID)
	return result
end
function E.func_GetSpellCooldown(spellID)
	local start = GetSpellCooldown(spellID).startTime
	local duration = GetSpellCooldown(spellID).duration
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactNumberRound(result)
end
function E.func_hex2rgb(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
function E.func_hex2rgbNUMBER(hex)
	if hex and hex ~= "" then
		hex = hex:gsub("|cff", "")
		return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
	else
		return 1, 1, 1
	end
end
function E.func_rgb2hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E.func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E.func_rgb2hexSTRING(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E.func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local result = ""
	local str = ""
	local total = utf8len(text)-1
	if total > 0 then
		local r1, g1, b1 = E.func_hex2rgb(firstColor)
		local r2, g2, b2 = E.func_hex2rgb(secondColor)
		local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
		local r3 = r1
		local g3 = g1
		local b3 = b1
		for i = 1, total do
			str = str..("|cff%02x%02x%02x%s|r"):format(math_floor(r3+.5), math_floor(g3+.5), math_floor(b3+.5), utf8sub(text, i, i))
			r3 = r3 + rdelta
			g3 = g3 + gdelta
			b3 = b3 + bdelta
		end
		result = str..secondColor..utf8sub(text, utf8len(text)).."|r"
		return result
	else
		return text
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local CompactSuffixes = {
	enUS = { "", "k", "M", "B", "T" },
	enGB = { "", "k", "M", "B", "T" },
	ruRU = { "", " тыс.", " млн", " млрд", " трлн" },
	deDE = { "", " Tsd.", " Mio.", " Mrd.", " Bio." },
	frFR = { "", " k", " M", " Md", " T" },
	esES = { "", " mil", " M", " mil M", " B" },
	esMX = { "", " mil", " M", " mil M", " B" },
	ptBR = { "", " mil", " mi", " bi", " tri" },
	itIT = { "", " mila", " mln", " mld", " tln" },
	zhCN = { "", "万", "亿", "万亿" }, -- Упрощённый китайский
	zhTW = { "", "萬", "億", "兆" }, -- Традиционный китайский
	koKR = { "", "만", "억", "조" }, -- Корейский
}
local AsianLocales = {
	zhCN = true,
	zhTW = true,
	koKR = true,
}
local function FormatWithSeparators(num)
	local formatted = tostring(num)
	while true do
		local k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1 %2")
		if k == formatted then break end
		formatted = k
	end
	return formatted
end
function E.func_CompactNumberFormat(num)
	num = num or 0
	if Octo_ToDo_DB_Vars.Config_numberFormatMode == 4 then
		return num
	end
	-- Полный формат с разделителями
	if Octo_ToDo_DB_Vars.Config_numberFormatMode == 3 then
		return FormatWithSeparators(math_floor(num + 0.5))
	end
	local locale
	local suffixes
	local step
	if Octo_ToDo_DB_Vars.Config_numberFormatMode == 1 then
		locale = "enUS"
		suffixes = CompactSuffixes["enUS"]
		step = 1000
	else -- локальный
		locale = E.curLocaleLang or "enUS"
		suffixes = CompactSuffixes[locale] or CompactSuffixes["enUS"]
		step = AsianLocales[locale] and 10000 or 1000
	end
	local i = 1
	while num >= step and i < #suffixes do
		num = num / step
		i = i + 1
	end
	local s = string.format("%.1f", num):gsub("%.0$", "")
	return s..suffixes[i]
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CompactNumberFormatOLD(number)
	local number = number or 0
	if number == 0 then
		return 0
	elseif number < 1000 then
		return (math_floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then
		return (math_floor(number/100)/10).."k"
	else
		return (math_floor(number/100000)/10).."m"
	end
end
function E.func_MoneyString(number)
	if not number then return 0 end
	if number > 10000 then
		return E.func_CompactNumberFormat(number/10000).."|r".."|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
	elseif number > 100 then
		return E.func_CompactNumberFormat(number/100).."|r".."|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
	else
		return E.func_CompactNumberFormat(number).."|r".."|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
	end
end
function E.func_CompactNumberRound(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math_floor(number+.5)
	end
end
function E.func_SecondsToClock(time, showSecond)
	local time = tonumber(time) or 0
	if time <= 0 then
		return ""
	end
	local years = math_floor(time / 31536000)
	local days = math_floor(time % 31536000 / 86400)
	local hours = math_floor(time % 86400 / 3600)
	local mins = math_floor(time % 3600 / 60)
	local secs = math_floor(time % 60)
	local ms = time - math_floor(time)
	local parts = {}
	if years > 0 then
		table_insert(parts, years..(L["time_YEAR"] or "y").." ")
		table_insert(parts, days..(L["time_DAY"] or "d").." ")
		table_insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table_insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif days > 0 then
		table_insert(parts, days..(L["time_DAY"] or "d").." ")
		table_insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table_insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif hours > 0 then
		table_insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table_insert(parts, string_format("%02d", mins)..(L["time_MINUTE"] or "m"))
	elseif time >= 60 then
		table_insert(parts, mins..(L["time_MINUTE"] or "m").." ")
		if time < 600 then
			table_insert(parts, secs..(L["time_SECOND"] or "s"))
		end
	elseif time >= 1 then
		table_insert(parts, secs..(L["time_SECOND"] or "s"))
	else
		table_insert(parts, string_format("%.3f", time).."ms")
	end
	return table_concat(parts)
end
function E.func_tmstpDayReset(time)
	local time = time or 1
	local daytime = 86400
	local thursdayReset = GetWeeklyResetStartTime()
	return (math_ceil((GetServerTime() - thursdayReset)/(daytime*time))*daytime*time)+thursdayReset
end
function E.func_GetWeeklyReset()
	return GetSecondsUntilWeeklyReset()
end
function E.func_IsOnQuest(id)
	return IsOnQuest(id)
end
function E.func_CheckCompletedByQuestID(questID)
	if not questID then return end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтный делается
	-- фиолетовый можно сдать
	if IsFailed(questID) then
		result = E.Red_Color..FAILED.."|r"
	elseif IsQuestFlaggedCompleted(questID) then
		result = E.DONE
	elseif IsComplete(questID) then
		result = QUEST_WATCH_QUEST_READY
	elseif not E.func_IsOnQuest(questID) then
		result = nil
	else
		local objectives = GetQuestObjectives(questID)
		if not objectives then
			result = ""
		else
			local parts = {}
			for i = 1, #objectives do
				local objective = objectives[i]
				if objective then
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
					local color = finished and E.Yellow_Color or E.Red_Color
					local text
					if objectiveType == "progressbar" then
						text = color..GetQuestProgressBarPercent(questID).."%|r"
					else
						text = color..objective.numFulfilled.."/"..objective.numRequired.."|r"
					end
					table_insert(parts, text)
				end
			end
			result = table_concat(parts, " ")
		end
	end
	return result
end
function E.func_achievementComplete(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
function E.func_achievementvivod(achievementID)
	local name, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe, earnedBy = GetAchievementInfo(achievementID)
	if completed then
		return E.DONE
	end
	local numCriteria = GetAchievementNumCriteria(achievementID)
	if numCriteria == 0 then
		return E.Red_Color.."0 / 1".."|r"
	end
	if numCriteria == 1 then
		local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, 1, false)
		return quantity == 0 and (E.Red_Color..quantity.." / "..reqQuantity.."|r") or (quantity.." / "..reqQuantity)
	else
		local count = 0
		for i = 1, numCriteria do
			local _, _, completedCrit = GetAchievementCriteriaInfo(achievementID, i, false)
			if completedCrit then
				count = count + 1
			end
		end
		return count == 0 and (E.Red_Color..count.." / "..numCriteria.."|r") or (count.." / "..numCriteria)
	end
end
function E.func_CurServerShort(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	if b then
		return utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	end
	return utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
end
E.curServerShort = E.func_CurServerShort(GetRealmName())
function E.func_GetCoord(x, y)
	return math_floor(x * 10000 + 0.5) * 10000 + math_floor(y * 10000 + 0.5)
end
function E.func_GetCoordFormated(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string_format("%.1f / %.1f", x * 100, y * 100)
end
function E.func_Reverse_order(a, b)
	return b < a
end
function E.func_CheckReputation(reputationID)
	local SHOWFULL = false
	local FIRST, SECOND = 0, 0
	local result = ""
	local color = E.Pink_Color
	local standingTEXT = ""
	local reaction = 0
	local simpleData = GetFactionDataByID(reputationID)
	local isSimple = simpleData ~= nil
	local isParagon = IsFactionParagon(reputationID)
	local friendData = GetFriendshipReputation(reputationID)
	local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
	local isMajor = IsMajorFaction(reputationID)
	local reactionColors = {
		[0] = E.White_Color,
		[1] = E.Red_Color,
		[2] = E.Red_Color,
		[3] = E.Orange_Color,
		[4] = E.Yellow_Color,
		[5] = E.Yellow_Color,
		[6] = E.Green_Color,
		[7] = E.Green_Color,
		[8] = E.Green_Color,
	}
	if isSimple then
		reaction = simpleData.reaction
		standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
		color = reactionColors[reaction] or E.Pink_Color
	end
	if isParagon then
		local currentValue, threshold, _, _, tooLowLevelForParagon = GetFactionParagonInfo(reputationID)
		if threshold then
			local value = currentValue % threshold
			color = E.Blue_Color
			result = value.."/"..threshold
			if tooLowLevelForParagon then
				result = result..E.Red_Color.."*|r"
			end
			FIRST, SECOND = value, threshold
		end
	elseif isMajor then
		local majorData = GetMajorFactionData(reputationID)
		if majorData then
			local currentValue = majorData.renownReputationEarned % majorData.renownLevelThreshold
			local totalValue = majorData.renownLevelThreshold
			result = currentValue.."/"..totalValue..color.."("..majorData.renownLevel..")|r"
			FIRST, SECOND = currentValue, totalValue
		end
	elseif isFriend then
		local standing = friendData.standing or 0
		local reactionThreshold = friendData.reactionThreshold or 0
		local nextThreshold = friendData.nextThreshold or 0
		local currentValue = standing - reactionThreshold
		local totalValue = nextThreshold - reactionThreshold
		local rankInfo = GetFriendshipReputationRanks(friendData.friendshipFactionID)
		local currentLevel = rankInfo and rankInfo.currentLevel or 0
		local maxLevel = rankInfo and rankInfo.maxLevel or 0
		if currentLevel == maxLevel then
			FIRST, SECOND = currentLevel, maxLevel
			result = FIRST.."/"..SECOND
		else
			standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
			FIRST, SECOND = SHOWFULL and standing or currentValue, SHOWFULL and (friendData.maxRep or 0) or totalValue
			result = FIRST.."/"..SECOND..standingTEXT
		end
	elseif isSimple and simpleData.currentStanding then
		local barMin = simpleData.currentReactionThreshold
		local barMax = simpleData.nextReactionThreshold
		local barValue = simpleData.currentStanding
		local currentValue = barValue - barMin
		local totalValue = barMax - barMin
		if currentValue == totalValue then
			FIRST, SECOND = 1, 1
			result = standingTEXT
		else
			FIRST, SECOND = SHOWFULL and barMin or currentValue,
			SHOWFULL and (barMin < 0 and 42000 or barMax) or totalValue
			result = FIRST.."/"..SECOND
		end
	end
	return FIRST.."#"..SECOND.."#"..result.."#"..color.."#"..standingTEXT
end
function E.func_CurrentNumQuests()
	local numQuests = 0
	for i = 1, GetNumQuestLogEntries() do
		local info = GetInfo(i)
		numQuests = numQuests + (info and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
function E.func_GetAddOnMetadata(name, variable)
	return GetAddOnMetadata(name, variable)
end
function E.func_IsAddOnLoaded(AddonNameOrIndex)
	return IsAddOnLoaded(AddonNameOrIndex)
end
function E.func_LoadAddOnFORCED(AddonName)
	if DoesAddOnExist(AddonName) and not E.func_IsAddOnLoaded(AddonName) then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
function E.func_CurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
function E.func_ProfessionIcon(skillLine)
	return skillLine and E.func_texturefromIcon(GetTradeSkillTexture(skillLine)) or ""
end
function E.func_debugprofileSTART()
	local timer = debugprofilestart()
	return timer
end
function E.func_debugprofileSTOP()
	local timer = E.func_CompactNumberRound(debugprofilestop())
	local result = E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
function E.func_FriendsFrame_GetLastOnlineText(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string_format(BNET_LAST_ONLINE_TIME, color..E.func_FriendsFrame_GetLastOnline(time).."|r")
	end
end
function E.func_FriendsFrame_GetLastOnline(timeDiff, isAbsolute)
	if not isAbsolute then
		timeDiff = time() - timeDiff
	end
	if timeDiff < SECONDS_PER_MIN then
		return LASTONLINE_SECS
	elseif timeDiff < SECONDS_PER_HOUR then
		return format(LASTONLINE_MINUTES, math_floor(timeDiff / SECONDS_PER_MIN))
	elseif timeDiff < SECONDS_PER_DAY then
		return format(LASTONLINE_HOURS, math_floor(timeDiff / SECONDS_PER_HOUR))
	elseif timeDiff < SECONDS_PER_MONTH then
		return format(LASTONLINE_DAYS, math_floor(timeDiff / SECONDS_PER_DAY))
	elseif timeDiff < SECONDS_PER_YEAR then
		return format(LASTONLINE_MONTHS, math_floor(timeDiff / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, math_floor(timeDiff / SECONDS_PER_YEAR))
	end
end
function E.func_TableConcat(table1, table2)
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
function E.func_MergeTableSFMICTpairs(table1, table2)
	for k, v in next, (table2) do
		table1[k] = v
	end
	return table1
end
function E.func_TableRemoveDuplicates(table1)
	if type(table1) ~= "table" then
		return {}
	end
	local seen = {}
	local write_idx = 1
	for i = 1, #table1 do
		local value = table1[i]
		if not seen[value] then
			seen[value] = true
			if write_idx ~= i then
				table1[write_idx] = value
			end
			write_idx = write_idx + 1
		end
	end
	for i = write_idx, #table1 do
		table1[i] = nil
	end
	return table1
end
function E.func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E.func_rgb2hex(fontstring:GetTextColor())..text.."|r"
end
function E.func_SetBackdrop(frame, hexcolor, BackdropAlpha, edgeAlpha)
	edgeAlpha = edgeAlpha or 1
	local bgCr, bgCg, bgCb = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB
	local bgCa = BackdropAlpha or E.backgroundColorA
	if hexcolor then
		bgCr, bgCg, bgCb = self.func_hex2rgbNUMBER(hexcolor)
	end
	frame:SetBackdrop(E.menuBackdrop)
	frame.r, frame.g, frame.b, frame.a = bgCr, bgCg, bgCb, bgCa
	frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
	if not frame.isInit then
		frame.isInit = true
		frame:HookScript("OnEnter", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, self.a)
				self:SetBackdropBorderColor(classR, classG, classB, 1)
		end)
		frame:HookScript("OnLeave", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, self.a)
				self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		end)
		if frame.icon then
			frame.icon:SetAllPoints(frame)
			frame:SetScript("OnShow", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
			end)
			frame:SetScript("OnMouseDown", function(self)
					self.icon:SetVertexColor(1, 0, 0, 0.5)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self.icon:SetVertexColor(classR, classG, classB, 1)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
			end)
		end
	end
end
function E.func_CreateMinimapButton(AddonName, nameForIcon, Saved_Variables, frame, func, frameString)
	local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
			type = "data source",
			icon = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\IconTexture\\"..nameForIcon,
			OnClick = function(self, button)
				if button == "LeftButton" then
					if not InCombatLockdown() then
						Octo_ToDo_DB_VisualUserSettings.SettingsEnabled = false
						if func then func() end
						if frame then
							frame:SetShown(not frame:IsShown())
							if frame:IsShown() then
								if SettingsPanel:IsVisible() then
									HideUIPanel(SettingsPanel)
								end
								if GameMenuFrame:IsVisible() then
									HideUIPanel(GameMenuFrame)
								end
							end
						end
					end
				elseif button == "RightButton" then
					if frame and frame:IsShown() then
						frame:Hide()
					end
					if SettingsPanel:IsVisible() then
						HideUIPanel(SettingsPanel)
					else
						Settings.OpenToCategory(E.func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
					end
				end
			end,
			OnTooltipShow = function(tooltip)
				tooltip:AddDoubleLine(E.func_GetAddOnMetadata(AddonName, "Title"))
				tooltip:AddLine(" ")
				tooltip:AddDoubleLine(E.LEFT_MOUSE_ICON..L["Left Click:"], HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING)
				tooltip:AddDoubleLine(E.RIGHT_MOUSE_ICON..L["Right Click:"], GAMEMENU_OPTIONS)
			end,
	})
	if type(Saved_Variables.LibDataBroker) ~= "table" then
		Saved_Variables.LibDataBroker = {}
	end
	if not Saved_Variables.LibDataBroker.minimapPos then
		Saved_Variables.LibDataBroker.minimapPos = random(1, 365)
	end
	LibStub("LibDBIcon-1.0"):Register(AddonName, dataBroker, Saved_Variables.LibDataBroker)
end
function E.func_fixdate(date)
	local result = ("%.2d"):format(date)
	return result
end
function E.func_IsAvailable(id, curType)
	if id and curType then
		if curType == "spell" and IsSpellKnown(id) then -- ПОФИКСИТЬ (Устаревшие API в Retail 11.2.7 C_Spell.IsSpellKnown(id))
			return true
		elseif curType == "item" and GetItemCount(id, false, false, false) > 0 then
			return true
		elseif curType == "toy" and PlayerHasToy(id) then
			return true
		else
			return false
		end
	end
end
function E.func_IsOnCD(id, curType)
	local id = id or nil
	local curType = curType or nil
	if id and curType then
		if curType == "spell" and GetSpellCooldown(id).startTime > 0 then
			return true
		elseif curType == "item" and select(2, GetItemCooldown(id)) > 0 then
			return true
		elseif curType == "toy" and select(2, GetItemCooldown(id)) > 0 then
			return true
		else
			return false
		end
	end
end
function E.func_FrameColor(frame, id, curType)
	if E.func_IsAvailable(id, curType) == false then
		frame:SetBackdropBorderColor(0, 0, 0, .5)
		frame.icon:SetVertexColor(1, 1, 1, .5)
		frame.icon:SetDesaturated(true)
	else
		if E.func_IsOnCD(id, curType) == true then
			frame.icon:SetVertexColor(1, 0, 0, 1)
		else
			frame.icon:SetVertexColor(1, 1, 1, 1)
		end
	end
end
function E.func_CreateUsableSpellFrame(id, point, parent, rPoint, x, y, size, curType)
	if id and type(id) == "number" then
		local curType = curType or "spell"
		local frame = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate, BackDropTemplate")
		frame:Hide()
		frame:SetPoint(point, parent, rPoint, x, y)
		frame:SetSize(size, size)
		local edgeAlpha = 1
		frame.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.icon:SetAllPoints()
		if curType == "item" or curType == "toy" then
			frame.icon:SetTexture(E.func_GetItemIconByID(id))
		else
			frame.icon:SetTexture(E.func_GetSpellIcon(id))
		end
		frame.icon:SetTexCoord(.10, .90, .10, .90)
		frame:SetBackdrop(E.menuBackdrop)
		frame:SetBackdropColor(0, 0, 0, 0)
		frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		frame:SetAttribute("type", "macro")
		if not InCombatLockdown() then
			if curType == "item" or curType == "toy" then
				frame:SetAttribute("macrotext", "/use item:"..id)
			else
				frame:SetAttribute("macrotext", "/cast "..GetSpellName(id))
			end
		end
		if not frame.isInit then
			frame.isInit = true
			frame:SetScript("OnShow", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E.func_FrameColor(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_FrameColor(self, id, curType)
					E.func_OctoTooltip_OnEnter(frame)
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E.func_itemName(id), E.func_SecondsToClock(E.func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E.func_spellName(id), E.func_SecondsToClock(E.func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E.func_GetSpellSubtext(id))
					end
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E.func_FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E.func_FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_FrameColor(self, id, curType)
			end)
		end
	end
end
function E.func_RegisterMyEventsToFrames(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or UNKNOWN
	local DebugPath = STR:gsub("]", "")
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event,...)
			if self[event] then
				self[event](self,...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.KILLTEXT..E.Event_Color..event.."|r"..E.KILLTEXT..tostring(DebugPath))
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
function E.func_numPlayers()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local count = 0
	local curGUID = E.curGUID
	local curFaction = E.curFaction
	local curServer = E.func_GetRealmName()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = ShowOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		if CharInfo.PlayerData then
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				count = count + 1
			else
				if PlayerData.isShownPLAYER and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not OnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					if meetsLevel and meetsFaction and meetsServer and meetsRegion then
						count = count + 1
					end
				end
			end
		end
	end
	return count > 0 and count or 1
end
function E.func_sorted()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local sorted = {}
	local curGUID = E.curGUID
	local curFaction = E.curFaction
	local curServer = E.func_GetRealmName()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = ShowOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		if not CharInfo.PlayerData then
		else
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				sorted[#sorted + 1] = CharInfo
			else
				if PlayerData.isShownPLAYER and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not OnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					if meetsLevel and meetsFaction and meetsServer and meetsRegion then
						sorted[#sorted + 1] = CharInfo
					end
				end
			end
		end
	end
	table_sort(sorted, function(a, b)
			local aData, bData = a.PlayerData, b.PlayerData
			local aLevel = aData.UnitLevel or 0
			local bLevel = bData.UnitLevel or 0
			if aLevel ~= bLevel then
				return aLevel > bLevel
			end
			local aItemLevel = aData.avgItemLevelEquipped or 0
			local bItemLevel = bData.avgItemLevelEquipped or 0
			if aItemLevel ~= bItemLevel then
				return aItemLevel > bItemLevel
			end
			local aName = aData.Name or "noname"
			local bName = bData.Name or "noname"
			return aName < bName
	end)
	return sorted
end
local function func_OnceDailyWeeklyMonth_Format(text)
	if not text then return end
	local result = ""
	if text == "Once" then
		result = E.Yellow_Color.."O|r"
	elseif text == "Daily" then
		result = E.Blue_Color.."D|r"
	elseif text == "Weekly" then
		result = E.Purple_Color.."W|r"
	elseif text == "Month" then
		result = E.Red_Color.."M|r"
	end
	return result
end
function E.func_FactionIconID(faction)
	if faction == "Horde" then
		return 2565244
	elseif faction == "Alliance" then
		return 2565243
	else
		return 775462
	end
end
function E.func_ShouldShow(id, qwe)
	local shouldShow = false
	if Octo_ToDo_DB_VisualUserSettings.SettingsEnabled then
		-- Режим настройки включен - показываем все валюты
		shouldShow = true
	else
		-- Режим настройки выключен - проверяем настройки валют
		local currenciesSettings = Octo_ToDo_DB_VisualUserSettings[qwe]
		if currenciesSettings then
			-- Проверяем числовой ключ
			if currenciesSettings[id] then
				shouldShow = true
			end
			-- Проверяем строковый ключ
			if currenciesSettings[tostring(id)] then
				shouldShow = true
			end
		end
	end
	return shouldShow
end
function E.func_Otrisovka_LEFT_Dispatcher(categoryKey, CharInfo, dataType, id)
	-- Пробуем разные варианты названий функций
	local funcNames = {
		"func_Otrisovka_LEFT_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] --[[and dataType ~= "UniversalQuests"]] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	-- Если функция не найдена, возвращаем значения по умолчанию
	-- TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	return "", nil, nil, nil, nil, false
end
function E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
	-- Пробуем разные варианты названий функций
	local funcNames = {
		"func_Otrisovka_Center_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] --[[and dataType ~= "UniversalQuests"]] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	-- Если функция не найдена, возвращаем значения по умолчанию
	-- TextCenter, ColorCenter, FirstReputation, SecondReputation
	return "", nil, nil, nil
end
function E.func_Otrisovka_LEFT_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = "", nil, nil, nil, nil, false
	----------------------------------------------------------------
	TextLeft = E.func_currencyName(id)
	-- ColorLeft =
	IconLeft = E.func_GetCurrencyIcon(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	if id == 824 then
		TooltipKey = "WoD_824"
	end
	-- IsReputation =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	TextCenter = E.func_TextCenter_Currency(CharInfo, id)
	if id == 1931 and CharInfo.PlayerData.Possible_CatalogedResearch then
		TextCenter = string_format("%s%s +%d|r", TextCenter, E.Purple_Color, CharInfo.PlayerData.Possible_CatalogedResearch)
	end
	if id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
			local color = E.Gray_Color
			local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.Purple_Color or E.Yellow_Color
				end
				TextCenter = TextCenter..color.." +"..earnedSinceLastCollect.."|r"
			end
		end
	elseif id == 1822 then
		local typeSL = 1 -- Renown
		if CharInfo.MASLENGO.CovenantAndAnima.curCovID then
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
			if CharInfo.MASLENGO.CovenantAndAnima[curCovID] then
				local color = E.OctoTable_Covenant[curCovID].color
				ColorCenter = color
				if CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL] then
					TextCenter = color..CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL].."|r"
				end
			end
		end
	elseif id == 1813 then
		local typeSL = 2 -- Anima
		if CharInfo.MASLENGO.CovenantAndAnima.curCovID then
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
			if CharInfo.MASLENGO.CovenantAndAnima[curCovID] then
				local color = E.OctoTable_Covenant[curCovID].color
				ColorCenter = color
				if CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL] then
					TextCenter = color..CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL].."|r"
				end
			end
		end
		if CharInfo.PlayerData.Possible_Anima then
			TextCenter = TextCenter..E.Blue_Color.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = "", nil, nil, nil, nil, false
	----------------------------------------------------------------
	TextLeft = E.func_itemName(id)
	-- ColorLeft =
	IconLeft = E.func_GetItemIconByID(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	-- IsReputation =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	ColorLeft = E.COLOR_THEBURNINGCRUSADE or expansionData.color
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_UniversalQuests(categoryKey, CharInfo, dataType, data)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = "", nil, nil, nil, nil, false
	----------------------------------------------------------------
	local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
	local reset = data.reset -- questKey:match("_([^_]+)$")
	----------------------------------------------------------------
	-- TextLeft = tostringall(func_OnceDailyWeeklyMonth_Format(data.reset).." "..data.TextLeft)
	TextLeft = data.TextLeft
	-- ColorLeft =
	if reset == "Daily" then
		IconLeft = E.ICON_DAILY --E.func_vignetteIcon("greatVault-whole-normal")
	elseif reset == "Weekly" then
		IconLeft = E.ICON_WEEKLY
	elseif reset == "Once" then
		IconLeft = E.ICON_ONCE
	elseif reset == "Month" then
		IconLeft = E.ICON_MONTH
	end
	-- IconLeft =
	SettingsType = dataType.."#"..questKey
	-- TooltipKey =
	-- IsReputation =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
-- function E.func_Otrisovka_Center_UniversalQuests(tbl, DESCRIPT)
function E.func_Otrisovka_Center_UniversalQuests(categoryKey, CharInfo, dataType, data)
	----------------------------------------------------------------
	if data.quests then
		----------------------------------------------------------------
		local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
		----------------------------------------------------------------
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		----------------------------------------------------------------
		local showTooltip = data.showTooltip or false
		if CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] then
			local LeftData = CharInfo.MASLENGO.UniversalQuest[questKey].TextCenter
			if LeftData then
				local totalQuest = 0
				local forcedMaxQuest = data.forcedMaxQuest
				-- Подсчет общего числа квестов
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == CharInfo.PlayerData.Faction then
						if forcedMaxQuest and type(forcedMaxQuest) == "string" and forcedMaxQuest == "all" then
							totalQuest = totalQuest + 1
						elseif forcedMaxQuest and type(forcedMaxQuest) == "number" then
							totalQuest = forcedMaxQuest
							break
						else
							totalQuest = totalQuest + 1
						end
					end
				end
				forcedMaxQuest = totalQuest
				-- Формирование текста в центре
				if type(LeftData) == "number" and forcedMaxQuest then
					TextCenter = LeftData >= forcedMaxQuest and E.DONE or LeftData.."/"..forcedMaxQuest
				elseif forcedMaxQuest ~= 1 then
					TextCenter = "0/"..forcedMaxQuest
				elseif type(LeftData) == "string" then
					TextCenter = LeftData
				end
			end
		end
		----------------------------------------------------------------
		return TextCenter, ColorCenter, FirstReputation, SecondReputation
		----------------------------------------------------------------
	end -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Reputations(categoryKey, CharInfo, dataType, id) -- func_Otrisovka_LEFT_Dispatcher
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = "", nil, nil, nil, nil, false
	----------------------------------------------------------------
	TextLeft = E.func_reputationName(id)
	-- ColorLeft =
	IconLeft = E.func_reputaionIcon(id)
	SettingsType = dataType.."#"..id
	TooltipKey = "Reputation_"..id
	IsReputation = true
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	----------------------------------------------------------------
end
function E.func_Otrisovka_Center_Reputations(categoryKey, CharInfo, dataType, id) -- func_Otrisovka_LEFT_Dispatcher
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	if CharInfo.MASLENGO.Reputation[id] and type(CharInfo.MASLENGO.Reputation[id]) == "string" then
		local FIRST, SECOND, vivod, colorC, standing = ("#"):split(CharInfo.MASLENGO.Reputation[id])
		FirstReputation = tonumber(FIRST)
		SecondReputation = tonumber(SECOND)
		ColorCenter = colorC
		local isParagonRewardEnableLEFT = ""
		local isParagonRewardEnableRIGHT = ""
		TextCenter = E.func_CompactNumberFormat(FirstReputation).."/"..E.func_CompactNumberFormat(SecondReputation)
		if TextCenter == "1/1" then
			TextCenter = E.DONE
		elseif TextCenter == "0/0" then
			TextCenter = ""
		end
		for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
			if id == v.factionID and CharInfo.MASLENGO.ListOfParagonQuests[questID] then
				TextCenter = E.Purple_Color.."> "..TextCenter.." <".."|r"
			end
		end
		-- print (id, TextCenter, ColorCenter, FirstReputation, SecondReputation)
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	----------------------------------------------------------------
end
function E.func_Otrisovka_LEFT_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation = "", nil, nil, dataType.."#"..id, nil, false
	----------------------------------------------------------------
	if id == "LegionRemixResearch" then
		TextLeft = L["Infinite Research"]
	elseif id == "ListOfQuests" then
		-- TooltipKey = "Other_ListOfQuests"
		TextLeft = QUESTS_LABEL
	elseif id == "LFGInstance" then
		-- TooltipKey = "Other_LFGInstance"
		TextLeft = DUNGEONS
	elseif id == "AllItems" then
		-- TooltipKey = "Other_AllItems"
		TextLeft = ITEMS
	elseif id == "Professions" then
		-- TooltipKey = "Other_Professions"
		TextLeft = PROFESSIONS_BUTTON
		-- myType = {"professions"}
	elseif id == "ItemLevel" then
		-- TooltipKey = "Other_ItemLevel"
		TextLeft = STAT_AVERAGE_ITEM_LEVEL
		-- myType = {"ItemLevel"}
	elseif id == "Money" then
		-- TooltipKey = "Other_Money"
		TextLeft = BONUS_ROLL_REWARD_MONEY
		-- myType = {"Money"}
	elseif id == "WasOnline" then
		-- TooltipKey = "Other_WasOnline"
		TextLeft = L["Was online"]
		-- myType = {"Online"}
	end
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey, IsReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	if id == "LegionRemixResearch" then
		if CharInfo.MASLENGO.LegionRemixData and CharInfo.MASLENGO.LegionRemixData.barValue and CharInfo.MASLENGO.LegionRemixData.barMax then
			local barValue = CharInfo.MASLENGO.LegionRemixData.barValue
			local barMax = CharInfo.MASLENGO.LegionRemixData.barMax
			TextCenter = barValue.."/"..barMax
			if CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests then
				TextCenter = barValue..E.Blue_Color.."("..CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests..")|r".."/"..barMax
			end
		end
	elseif id == "ListOfQuests" then
		if CharInfo.PlayerData.numQuests then
			TextCenter = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.numQuests.."/"..CharInfo.PlayerData.maxNumQuestsCanAccept.."|r"
		end
	elseif id == "LFGInstance" then
		local count = 0
		for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w.vivod then
						count = count + 1
					end
				end
			end
		end
		for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
			if v then
				if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday then
					count = count + 1
				end
			end
		end
		for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
			if v then
				count = count + 1
			end
		end
		if count ~= 0 then
			TextCenter = count
			-- TextCenter = E.Gray_Color..DUNGEONS.."|r"
		end
	elseif id == "AllItems" then
		local count = 0
		for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
			if CharInfo.MASLENGO.ItemsInBag[itemID] then
				count = count + 1
				break
			end
		end
		if count ~= 0 then
			TextCenter = E.Gray_Color..ITEMS.."|r"
		end
	elseif id == "Professions" then
		local charProf = CharInfo.MASLENGO.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				if i == 1 or i == 2 then
					TextCenter = TextCenter..E.func_ProfessionIcon(charProf[i].skillLine).." "
				end
			end
		end
	elseif id == "ItemLevel" then
		----------------------------------------------------------------
		local color = E.Red_Color
		local ItemLevelGreen = 625
		local ItemLevelOrange = 610
		local ItemLevelRed = 580
		if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
			if CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelGreen then
				color = E.Green_Color
			elseif CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelOrange then
				color = E.Yellow_Color
			elseif CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelRed then
				color = E.Orange_Color
			end
		end
		if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
			TextCenter = color..CharInfo.PlayerData.avgItemLevelEquipped
			if CharInfo.PlayerData.avgItemLevel > CharInfo.PlayerData.avgItemLevelEquipped then
				TextCenter = TextCenter.."/"..CharInfo.PlayerData.avgItemLevel.."|r"
			end
			if CharInfo.PlayerData.avgItemLevelPvp and CharInfo.PlayerData.avgItemLevelPvp > CharInfo.PlayerData.avgItemLevel then
				TextCenter = TextCenter..E.Green_Color.."+|r"
			end
		end
		----------------------------------------------------------------
	elseif id == "Money" then
		if CharInfo.PlayerData.Money then
			TextCenter = E.func_MoneyString(CharInfo.PlayerData.Money)
			if CharInfo.PlayerData.MoneyOnLogin then
				if CharInfo.PlayerData.Money < CharInfo.PlayerData.MoneyOnLogin then
					TextCenter = TextCenter..E.Red_Color.."-|r"
				elseif CharInfo.PlayerData.Money > CharInfo.PlayerData.MoneyOnLogin then
					TextCenter = TextCenter..E.Green_Color.."+|r"
				end
			end
		end
	elseif id == "WasOnline" then
		local color = E.White_Color
		if CharInfo.PlayerData.loginHour and CharInfo.PlayerData.loginDay then
			if CharInfo.PlayerData.GUID == E.curGUID then
				TextCenter = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
			else
				if CharInfo.PlayerData.needResetWeekly then
					color = E.Gray_Color
				elseif CharInfo.PlayerData.needResetDaily then
					color = E.Red_Color
				end
				TextCenter = color..E.func_FriendsFrame_GetLastOnline(CharInfo.PlayerData.time).."|r"
			end
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.getSettings(type, id)
	-- Проверяем, существует ли таблица настроек для этого типа
	if not Octo_ToDo_DB_VisualUserSettings then
		return false
	end
	local settingsTable = Octo_ToDo_DB_VisualUserSettings[type]
	if not settingsTable then
		return false
	end
	-- Определяем ключ (строковый или числовой)
	local key = id
	local numID = tonumber(id)
	if numID and settingsTable[numID] ~= nil then
		key = numID
	end
	-- Возвращаем значение, если оно существует, иначе false
	return settingsTable[key] or false
end
function E.func_TextCenter_Items(CharInfo, itemID, showIcon)
	if not itemID then return "" end
	showIcon = showIcon or false
	local result = ""
	if type(itemID) == "number" then
		result = result..(CharInfo.MASLENGO.ItemsInBag[itemID] or "")
	elseif type(itemID) == "table" then
		for _, v in ipairs(itemID) do
			result = result..(CharInfo.MASLENGO.ItemsInBag[v] or "")
		end
	end
	if showIcon and result ~= "" then
		result = " +"..result..E.func_texturefromIcon(E.func_GetItemIconByID(itemID))
	end
	return result
end
function E.func_TextCenter_Currency(CharInfo, currencyID, itemID)
	local data = CharInfo.MASLENGO.Currency
	if not data[currencyID] then return "" end
	local result = ""
	local color = E.White_Color
	if data[currencyID].quantity then
		result = result..E.func_CompactNumberFormat(data[currencyID].quantity)
		if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
			if data[currencyID].quantity == data[currencyID].maxQuantity then
				color = E.Green_Color
			end
			result = color..result.."/"..E.func_CompactNumberFormat(data[currencyID].maxQuantity).."|r"
		end
	end
	if data[currencyID].totalEarned and data[currencyID].maxQuantity then
		local curQuantity = E.func_CompactNumberFormat(data[currencyID].quantity or 0)
		result = E.func_CompactNumberFormat(data[currencyID].totalEarned)
		result = " ("..result.."/"..E.func_CompactNumberFormat(data[currencyID].maxQuantity)..")"
		result = color..curQuantity..result.."|r"
	end
	if itemID then
		result = result..E.Green_Color..E.func_TextCenter_Items(CharInfo, itemID, true).."|r"
	end
	return result
end
function E.func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
function E.func_InitSubTable(tbl, field)
	if type(tbl[field]) ~= "table" then
		tbl[field] = {}
	end
end
function E.func_Update(event_name)
	if not E.DebugEvent then return end
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()
	if isMainFrameVisible then
		if not E.func_UpdateScheduled then
			E.func_UpdateScheduled = true
			C_Timer.After(0.1, function()
					E.func_UpdateScheduled = false
					if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
						-- E.func_TODO_CreateDataProvider()
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_Update ", E.Green_Color, E.Yellow_Color)..event_name)
					end
			end)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_Update ", E.Red_Color, E.Purple_Color)..event_name)
	end
end
function E.func_GetCurrentRegion()
	return GetCurrentRegion()
end
----------------------------------------------------------------
function E.func_GetCurrentRegionName()
	local result = GetCurrentRegionName()
	if result == "" then
		result = "PTR "..E.buildVersion
	end
	return result
end
----------------------------------------------------------------
function E.func_tooltipCENT_ITEMS(CharInfo, TBL, needShowAllItems)
	local tooltipCENT = {}
	local sorted_itemList = {}
	local ItemsInBag = CharInfo.MASLENGO.ItemsInBag
	for _, itemID in ipairs(TBL) do
		local count = ItemsInBag[itemID]
		if needShowAllItems or count then
			table_insert(sorted_itemList, {
					itemID = itemID,
					quality = E.func_GetItemQuality(itemID),
					count = count or 0
			})
		end
	end
	table_sort(sorted_itemList, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality
			elseif a.count ~= b.count then
				return a.count > b.count
			end
			return a.itemID > b.itemID
	end)
	for _, item in ipairs(sorted_itemList) do
		local itemID = item.itemID
		local count = ItemsInBag[itemID] or ""
		local icon = E.func_texturefromIcon(E.func_GetItemIconByID(itemID))
		local name = E.func_itemName(itemID)
		local price = E.func_ItemPriceTSM(itemID, item.count)
		tooltipCENT[#tooltipCENT + 1] = {icon..name, count, price}
	end
	return tooltipCENT
end
function E.func_InitFrame(frame)
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table_insert(E.OctoTable_Frames, frame)
	table_insert(UISpecialFrames, frame:GetName())
	C_Timer.After(0, function()
			frame:HookScript("OnShow", function()
					for i, other in ipairs(E.OctoTable_Frames) do
						if frame ~= other and other:IsShown() then
							other:Hide()
						end
					end
			end)
	end)
end
function E.func_ExpansionVivod(expID)
	local expIcon = E.func_texturefromIcon(E.OctoTable_Expansions[expID].icon, 16, 32)
	local expName = E.OctoTable_Expansions[expID].color..E.OctoTable_Expansions[expID].nameVeryShort
	return " "..expName..expIcon.."|r"
end
function E.func_joinableDung()
	local joinable, timewalkDungeonName, result = false, "", ""
	for expID, v in ipairs(E.OctoTable_Expansions) do
		if v.timewalkDungeonID and IsLFGDungeonJoinable(v.timewalkDungeonID) then
			joinable = true
			result = E.func_ExpansionVivod(expID)
			timewalkDungeonName = GetLFGDungeonInfo(v.timewalkDungeonID)
		end
	end
	return joinable, result, timewalkDungeonName:match("%((.-)%)")
end
do
	local funcNames = {
		"Items",
		"Currencies",
		"NPCs",
		"Quests",
		"Reputations",
		"Spells",
		"Achievements",
		"Mounts",
		"Maps",
		"Events",
		"Professions",
		"instanceID",
		"worldBossID",
	}
	for _, name in ipairs(funcNames) do
		E["debugInfo_"..name] = function(id)
			local result = (E.Config_DebugID_ALL or Octo_Debug_DB["Config_DebugID_"..name]) and (E.Gray_Color.." id:"..id.."|r") or ""
			return result
		end
	end
end
function E.debugInfo(id)
	local result = E.Config_DebugID_ALL and (E.Gray_Color.." id:"..id.."|r") or ""
	return result
end
function E.func_GetRealmName()
	local result = GetRealmName()
	if E.func_IsRemix() then
		result = result.." (Remix)"
	end
	return result
end
-- E.curServer = E.func_GetRealmName()
E.SPAM_TIME = 2
E.UNIVERSAL = "UNIVERSAL_"
E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CentralFrame.tga"
E.TEXTURE_REPUTATION_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Naowh.tga"
E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.TEXTURE_BLANK_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Blank.tga"
E.TEXTURE_HIGHLIGHT = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"
E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""
E.curLocaleLang = GetLocale() or "enUS"
E.Icon_MailBox = "Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga"
E.className, E.classFilename, E.classId = UnitClass("PLAYER")
E.classColor = RAID_CLASS_COLORS[E.classFilename] and RAID_CLASS_COLORS[E.classFilename].colorStr:sub(3) or "ffffff"
E.classColorHexCurrent = C_ClassColor.GetClassColor(E.classFilename):GenerateHexColorMarkup()
E.curCharName = UnitFullName("PLAYER")
E.Class_Warrior_Color = C_ClassColor.GetClassColor("WARRIOR"):GenerateHexColorMarkup()
E.Class_Paladin_Color = C_ClassColor.GetClassColor("PALADIN"):GenerateHexColorMarkup()
E.Class_Hunter_Color = C_ClassColor.GetClassColor("HUNTER"):GenerateHexColorMarkup()
E.Class_Rogue_Color = C_ClassColor.GetClassColor("ROGUE"):GenerateHexColorMarkup()
E.Class_Priest_Color = C_ClassColor.GetClassColor("PRIEST"):GenerateHexColorMarkup()
E.Class_Shaman_Color = C_ClassColor.GetClassColor("SHAMAN"):GenerateHexColorMarkup()
E.Class_Mage_Color = C_ClassColor.GetClassColor("MAGE"):GenerateHexColorMarkup()
E.Class_Warlock_Color = C_ClassColor.GetClassColor("WARLOCK"):GenerateHexColorMarkup()
E.Class_Monk_Color = C_ClassColor.GetClassColor("MONK"):GenerateHexColorMarkup()
E.Class_Druid_Color = C_ClassColor.GetClassColor("DRUID"):GenerateHexColorMarkup()
E.Class_DemonHunter_Color = C_ClassColor.GetClassColor("DEMONHUNTER"):GenerateHexColorMarkup()
E.Class_DeathKnight_Color = C_ClassColor.GetClassColor("DEATHKNIGHT"):GenerateHexColorMarkup()
E.Class_Evoker_Color = C_ClassColor.GetClassColor("EVOKER"):GenerateHexColorMarkup()
-- /run opde(_G.QUEST_TAG_ATLAS)
-- E.QUEST_TAG_ATLAS = _G.QUEST_TAG_ATLAS or {
-- [1] = "questlog-questtypeicon-group",
-- ["COMPLETED_LEGENDARY"] = "questlog-questtypeicon-legendaryturnin",
-- [89] = "questlog-questtypeicon-raid",
-- [62] = "questlog-questtypeicon-raid",
-- [288] = "questlog-questtypeicon-delves",
-- [41] = "questlog-questtypeicon-pvp",
-- [88] = "questlog-questtypeicon-raid",
-- ["WEEKLY"] = "questlog-questtypeicon-weekly",
-- ["EXPIRING_SOON"] = "questlog-questtypeicon-clockorange",
-- [85] = "questlog-questtypeicon-heroic",
-- ["EXPIRING"] = "questlog-questtypeicon-clockyellow",
-- ["DAILY"] = "questlog-questtypeicon-daily",
-- [98] = "questlog-questtypeicon-scenario",
-- ["ALLIANCE"] = "questlog-questtypeicon-alliance",
-- ["FAILED"] = "questlog-questtypeicon-questfailed",
-- ["HORDE"] = "questlog-questtypeicon-horde",
-- ["STORY"] = "questlog-questtypeicon-story",
-- [81] = "questlog-questtypeicon-dungeon",
-- ["COMPLETED"] = "questlog-questtypeicon-quest",
-- },
E.ICON_ONCE = "Crosshair_Quest_64"
E.ICON_DAILY = "Crosshair_Recurring_64"
E.ICON_WEEKLY = "Crosshair_Wrapper_64"
E.ICON_MONTH = "cursor_Wrapper_64" -- "Crosshair_legendaryquest_64"
-- E.ICON_ONCE = "questlog-questtypeicon-quest"
-- E.ICON_DAILY = "questlog-questtypeicon-daily"
-- E.ICON_DAILY = "Recurringavailablequesticon"
-- E.ICON_WEEKLY = "questlog-questtypeicon-weekly"
E.FULL_WIDTH = 3.60
E.backgroundColorR = .08
E.backgroundColorG = .08
E.backgroundColorB = .08
E.backgroundColorA = .8
E.edgeSize = 1
E.edgeFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\03_Borders\\Octo.tga"
E.bgFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\03_Borders\\Octo.tga"
E.menuBackdrop = {
	bgFile = E.bgFile,
	edgeFile = E.edgeFile,
	edgeSize = E.edgeSize,
	insets = {left = E.edgeSize, right = E.edgeSize, top = E.edgeSize, bottom = E.edgeSize}
}
E.MAX_DISPLAY_LINES = 30
E.ddMenuButtonHeight = 16
E.GLOBAL_LINE_HEIGHT = 20
E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2 -- Высота заголовка
E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
E.GLOBAL_LINE_WIDTH_LEFT = 200
E.GLOBAL_LINE_WIDTH_RIGHT = 90
E.Octo_font = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\02_Fonts\\Octo.TTF"
E.GLOBAL_FONT_SIZE = 11
E.OctoFont11 = CreateFont("OctoFont11")
E.OctoFont11:CopyFontObject(GameTooltipText)
E.OctoFont22 = CreateFont("OctoFont22")
E.OctoFont22:CopyFontObject(SystemFont_Outline_Small)
E.OctoFont22:SetFont(E.Octo_font, 22, "OUTLINE")
E.IconTexture = C_AddOns.GetAddOnMetadata(GlobalAddonName, "IconTexture")
E.currentMaxLevel = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT)
E.currentExpansionName = _G['EXPANSION_NAME'..LE_EXPANSION_LEVEL_CURRENT]
E.IsPublicBuild = IsPublicBuild()
E.buildVersion, E.buildNumber, E.buildDate, E.interfaceVersion = GetBuildInfo()
E.buildNumber = tonumber(E.buildNumber)
E.interfaceVersion_PTR = 110200
E.currentTier = tonumber(GetBuildInfo():match("(.-)%."))
E.GetRestrictedAccountData_rLevel, E.GetRestrictedAccountData_rMoney = GetRestrictedAccountData()
E.IsAccountSecured = IsAccountSecured()
E.IsRestrictedAccount = IsRestrictedAccount()
E.IsTrialAccount = IsTrialAccount()
E.IsVeteranTrialAccount = IsVeteranTrialAccount()
E.BattleTag = select(2, BNGetInfo()) or "Trial Account"
E.BTAG = tostringall(strsplit("#", E.BattleTag))
E.CURRENT_REGION_ID = GetCurrentRegion()
E.CURRENT_REGION_NAME = GetCurrentRegionName()
E.CurrentRegionName = E.func_GetCurrentRegionName()
E.ENABLE_HIGHLIGHT_ANIMATION = false
if E.CURRENT_REGION_NAME == "" then
	E.CURRENT_REGION_NAME = "US"
end
E.GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail"
E.BattleTagLocal = E.BTAG.." ("..E.GameVersion..")"
E.curGUID = UnitGUID("PLAYER")
E.GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.PHYSICAL_SCREEN_WIDTH, E.PHYSICAL_SCREEN_HEIGHT = GetPhysicalScreenSize()
E.POSITION_MAIN_FRAME = -157
E.ANIMATION_DURATION = .2
E.isElvUI = select(4, C_AddOns.GetAddOnInfo("ElvUI"))
E.isRCLootCouncil = select(4, C_AddOns.GetAddOnInfo("RCLootCouncil"))
E.isWeakAuras = select(4, C_AddOns.GetAddOnInfo("WeakAuras"))
E.isTomTom = select(4, C_AddOns.GetAddOnInfo("TomTom"))
E.isPlater = select(4, C_AddOns.GetAddOnInfo("Plater"))
E.isOmniCD = select(4, C_AddOns.GetAddOnInfo("OmniCD"))
E.isOmniCC = select(4, C_AddOns.GetAddOnInfo("OmniCC"))
E.isParrot = select(4, C_AddOns.GetAddOnInfo("Parrot"))
E.ALPHA_BACKGROUND = .2
E.COLOR_WORLDOFWARCRAFT = "|cffD6AB7D"
E.COLOR_THEBURNINGCRUSADE = "|cffE43E5A"
E.COLOR_WRATHOFTHELICHKING = "|cff3FC7EB"
E.COLOR_CATACLYSM = "|cffFF7C0A"
E.COLOR_MISTSOFPANDARIA = "|cff00EF88"
E.COLOR_WARLORDSOFDRAENOR = "|cffF48CBA"
E.COLOR_LEGION = "|cffAAD372"
E.COLOR_BATTLEFORAZEROTH = "|cffFFF468"
E.COLOR_SHADOWLANDS = "|cff9798FE"
E.COLOR_DRAGONFLIGHT = "|cff53B39F"
E.COLOR_THEWARWITHIN = "|cff90CCDD"
E.COLOR_MIDNIGHT = "|cff7B69FF"
E.COLOR_THELASTTITAN = "|cffF4C263"
E.COLOR_WOW_POOR = "|cff9D9D9D"
E.COLOR_WOW_COMMON = "|cffFFFFFF"
E.COLOR_WOW_UNCOMMON = "|cff1EFF00"
E.COLOR_WOW_RARE = "|cff0070DD"
E.COLOR_WOW_EPIC = "|cffA335EE"
E.COLOR_WOW_LEGENDARY = "|cffFF8000"
E.COLOR_WOW_ARTIFACT = "|cffD9CC80"
E.COLOR_WOW_HEIRLOOM = "|cff00CCFF"
E.COLOR_WOW_TOKEN = "|cff00CCFF"
E.COLOR_KYRIAN = "|cff6FA8DC"
E.COLOR_NECROLORD = "|cff93C47D"
E.COLOR_NIGHTFAE = "|cffB4A7D6"
E.COLOR_VENTHYR = "|cffEA9999"
E.Black_Color = "|cff000000"
E.DarkGray_Color = "|cff252525"
E.Gray_Color = "|cff757575"
E.LightGray_Color = "|cff909090"
E.White_Color = "|cffFFFFFF"
E.Addon_Left_Color = "|cffD177FF"
E.Addon_Right_Color = "|cff63A4E0"
E.Red_Color = "|cffFF4C4F"
E.Orange_Color = "|cffFF661A"
E.Darkorange_Color = "|cffFF8C00"
E.Gold_Color = "|cffFFD600"
E.Yellow_Color = "|cffFFF371"
E.Lime_Color = "|cffACFF2F"
E.Green_Color = "|cff4FFF79"
E.Cyan_Color = "|cff00FFFF"
E.Blue_Color = "|cff00A3FF"
E.Purple_Color = "|cffAF61FF"
E.Indigo_Color = "|cff4B0082"
E.Magenta_Color = "|cffFF00FF"
E.Pink_Color = "|cffFF69B3"
E.Skyblue_Color = "|cff87CDEB"
E.Steelblue_Color = "|cff4682B3"
E.Slategray_Color = "|cff708090"
E.Brown_Color = "|cff964B00"
E.Holiday_Color = "|cffFF8C00"
E.Event_Color = "|cffFFF371"
E.Debug_Color = E.classColorHexCurrent
E.Function_Color = "|cff87CDEB"
E.curFaction = UnitFactionGroup("PLAYER")
E.oppositeFaction = E.curFaction == "Alliance" and "Horde" or "Alliance"
E.ICON_ALLIANCE = 255140
E.ICON_HORDE = 255142
E.ICON_KYRIAN = 3641395
E.ICON_NECROLORD = 3752259 -- 3641396
E.ICON_NIGHTFAE = 3752258 -- 3641394
E.ICON_VENTHYR = 3257751 -- 3641397
E.Icon_WorldBoss = 3528312
E.Icon_Rares = 135903
E.Icon_Money = 133784
E.COLOR_HORDE = "|cffC41E3A"
E.COLOR_ALLIANCE = "|cff0070DD"
E.COLOR_NEUTRAL = E.Class_Monk_Color
if E.curFaction == "Horde" then
	E.ICON_FACTION = 2565244
	E.COLOR_FACTION = E.COLOR_HORDE
elseif E.curFaction == "Alliance" then
	E.ICON_FACTION = 2565243
	E.COLOR_FACTION = E.COLOR_ALLIANCE
else
	E.ICON_FACTION = 775462
	E.COLOR_FACTION = E.Class_Monk_Color
end
E.COLOR_KYRIAN_R = 0.44
E.COLOR_KYRIAN_G = 0.66
E.COLOR_KYRIAN_B = 0.86
E.COLOR_NECROLORD_R = 0.58
E.COLOR_NECROLORD_G = 0.77
E.COLOR_NECROLORD_B = 0.49
E.COLOR_NIGHTFAE_R = 0.56
E.COLOR_NIGHTFAE_G = 0.49
E.COLOR_NIGHTFAE_B = 0.76
E.COLOR_VENTHYR_R = 0.88
E.COLOR_VENTHYR_G = 0.40
E.COLOR_VENTHYR_B = 0.40
E.RIFT = E.Purple_Color.." (RIFT)|r"
E.DONE = E.Green_Color..DONE.."|r"
E.NONE = E.Gray_Color..NONE.."|r"
E.TRUE = E.Green_Color.."true|r"
E.FALSE = E.Red_Color.."false|r"
E.NIL = E.Red_Color.."nil|r"
E.ICON_ACCOUNT_WIDE = CreateAtlasMarkup("warbands-icon", 16, 16)
E.ICON_ACCOUNT_TRANSFERABLE = CreateAtlasMarkup("warbands-icon", 16, 16)
E.ICON_WARBANDS = E.Blue_Color.."(A)".."|r"
E.ICON_QUESTION_MARK = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.ICON_EMPTY = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Util_Icons\\ICON_EMPTY"
E.ICON_LFG = "Interface\\LFGFRAME\\BattlenetWorking0"
E.OctoTable_Prefixes = {
	"Русский",
	"Deutsch",
	"English",
	"Español",
	"Français",
	"Italiano",
	"Português Brasileiro",
	"Korean",
	"Chinese",
}
E.OctoTable_Covenant = {
	[1] = {
		name = GetCovenantData(1).name,
		icon = E.ICON_KYRIAN,
		color = E.COLOR_KYRIAN,
		r = E.COLOR_KYRIAN_R,
		g = E.COLOR_KYRIAN_G,
		b = E.COLOR_KYRIAN_B,
	},
	[2] = {
		name = GetCovenantData(2).name,
		icon = E.ICON_VENTHYR,
		color = E.COLOR_VENTHYR,
		r = E.COLOR_VENTHYR_R,
		g = E.COLOR_VENTHYR_G,
		b = E.COLOR_VENTHYR_B,
	},
	[3] = {
		name = GetCovenantData(3).name,
		icon = E.ICON_NIGHTFAE,
		color = E.COLOR_NIGHTFAE,
		r = E.COLOR_NIGHTFAE_R,
		g = E.COLOR_NIGHTFAE_G,
		b = E.COLOR_NIGHTFAE_B,
	},
	[4] = {
		name = GetCovenantData(4).name,
		icon = E.ICON_NECROLORD,
		color = E.COLOR_NECROLORD,
		r = E.COLOR_NECROLORD_R,
		g = E.COLOR_NECROLORD_G,
		b = E.COLOR_NECROLORD_B,
	},
}
E.LIST_MAX_SIZE = 30
E.DEVTEXT = "|T"..E.IconTexture..":14:14:::64:64:4:60:4:60|t"..E.Green_Color.."DebugInfo|r: "
E.KILLTEXT = "|T".."Interface\\Addons\\"..E.MainAddonName.."\\Media\\ElvUI\\Facepalm.tga"..":14:14:::64:64:4:60:4:60|t"
function E.func_pizda(mountID)
	local mountIconNumber = E.func_mountIcon(mountID)
	local mountIcon = E.func_texturefromIcon(mountIconNumber)
	local mountName = mountIcon..E.func_mountIsCollectedColor(mountID)..E.func_mountName(mountID).."|r"
	return mountName
end


function E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
	local pd = CharInfo.PlayerData
	local isVisible = visiblePlayers[GUID]
	local colorPlayer = isVisible and pd.classColorHex or E.Gray_Color
	local colorServer = isVisible and "|cffFFFFFF" or E.Gray_Color
	local curPers = pd.GUID == E.curGUID and E.Green_Color.."*|r" or ""
	local curServer = pd.curServer ~= currentRealm and "-"..pd.curServer or ""
	local leftText =
		E.func_texturefromIcon(pd.specIcon)..
		colorPlayer..pd.Name..
		colorServer..curServer.."|r"..
		curPers

	return leftText
end

function E.func_CovenantCurrencyTooltip(id, visiblePlayers, typeSL)
	-- typeSL: 1 = Renown, 2 = Anima
	local tooltip = {}
	local isRenown = (typeSL == 1)
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local grandTotal = 0
	local totalPossible = 0
	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		local covData = CharInfo.MASLENGO.CovenantAndAnima
		local curCovID = covData and covData.curCovID
		if curCovID then
			local pd = CharInfo.PlayerData
			local values = {}
			local charTotal = 0
			local activeValue = 0
			for covenant = 1, 4 do
				local value = covData[covenant] and covData[covenant][typeSL] or 0
				values[covenant] = value
				charTotal = charTotal + value
				if covenant == curCovID then
					activeValue = value
				end
			end
			-- Фильтр пустоты
			local hasData
			if isRenown then
				hasData = activeValue > 0
			else
				hasData = charTotal > 0 or (pd.Possible_Anima or 0) > 0
			end
			if hasData then
				if not isRenown then
					grandTotal = grandTotal + charTotal
					totalPossible = totalPossible + (pd.Possible_Anima or 0)
				end
				local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)

				local row = { leftText }
				for covenant = 1, 4 do
					local value = values[covenant]
					if value > 0 then
						local c = covenant == curCovID
							and E.OctoTable_Covenant[covenant].color
							or E.Gray_Color
						row[covenant + 1] = c..E.func_CompactNumberFormat(value).."|r"
					else
						row[covenant + 1] = "-"
					end
				end
				local totalAnimaText
				local sortValue
				local Possible_Anima
				if isRenown then
					sortValue = activeValue
				else
					sortValue = charTotal -- + (pd.Possible_Anima or 0)
					if charTotal ~= 0 then
						totalAnimaText = E.func_CompactNumberFormat(charTotal)
					else
						totalAnimaText = "-"
					end
					if pd.Possible_Anima and pd.Possible_Anima > 0 then
						Possible_Anima = E.Blue_Color.." +"..E.func_CompactNumberFormat(pd.Possible_Anima).."|r"
					end
				end
				table.insert(characterData, {
					row = row,
					name = pd.Name,
					sortValue = sortValue,
					-- charValue = isRenown and activeValue or charTotal,
					Possible_Anima = Possible_Anima or " ",
					totalAnimaText = totalAnimaText,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
		if a.sortValue ~= b.sortValue then
			return a.sortValue > b.sortValue
		end
		return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент (только для Anima)
	--------------------------------------------------------
	local minValue, maxValue
	if not isRenown then
		minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	end
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		if not isRenown then
			local color = E.func_GetGradientHex(d.sortValue, minValue, maxValue)
			d.row[6] = d.Possible_Anima
			d.row[7] = color..d.totalAnimaText.."|r"
		end
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 0 then
		local header = {
			"",
			E.func_texturefromIcon(E.ICON_KYRIAN),
			E.func_texturefromIcon(E.ICON_VENTHYR),
			E.func_texturefromIcon(E.ICON_NIGHTFAE),
			E.func_texturefromIcon(E.ICON_NECROLORD),
			""
		}
		if not isRenown then
			header[#header+1] = TOTAL..": "..E.func_CompactNumberFormat(grandTotal)
		end
		table.insert(tooltip, 1, header)
	end
	--------------------------------------------------------
	return tooltip
end

function E.func_ItemLevelTooltipLeft(visiblePlayers)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local avgILVL = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
		local pd = CharInfo.PlayerData
		local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
		local avgItemLevel = pd.avgItemLevel or 0
		local avgItemLevelPvp = pd.avgItemLevelPvp or 0
		-- Фильтр пустоты
		local hasData = pd.avgItemLevelEquipped > 0 or pd.avgItemLevel > 0 or pd.avgItemLevelPvp > 0
		if hasData then
			local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)

			local row = { leftText }
			local row2Text = ""
			local row3Text = ""
			if pd.avgItemLevelEquipped and pd.avgItemLevel then
				row2Text = pd.avgItemLevelEquipped
				if pd.avgItemLevel > pd.avgItemLevelEquipped then
					row3Text = " +"..pd.avgItemLevel-pd.avgItemLevelEquipped
				end
				if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
					row2Text = row2Text..E.Blue_Color.."+|r"
				end
			end
			avgILVL = avgILVL + pd.avgItemLevel
			table.insert(characterData, {
					row = row,
					name = pd.Name,
					sortValue = avgItemLevelEquipped,
					-- charValue = avgItemLevelEquipped,
					row2Text = row2Text,
					row3Text = row3Text,
			})
		end
	end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetGradientHex(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		d.row[3] = color..d.row3Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local header = {
			"",
			"avg"..": "..E.func_CompactNumberFormat(avgILVL/#characterData),
			"",
		}
		table.insert(tooltip, 1, header)
	end
	--------------------------------------------------------
	return tooltip
end





function E.func_ProfessionsTooltipLeft(visiblePlayers)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
		local pd = CharInfo.PlayerData
		local cmP = CharInfo.MASLENGO.professions
		-- Фильтр пустоты
		local hasData = cmP[1] and cmP[1].skillLine
		if hasData then
			local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
			local row = { leftText }
			local prof = {}
			for i = 1, 2 do
				prof[i] = prof[i] or {}
				prof[i].Icon = ""
				prof[i].Text = ""
				if cmP[i] and cmP[i].skillLevel and cmP[i].maxSkillLevel then
					prof[i].Icon = E.func_ProfessionIcon(cmP[i].skillLine)
					prof[i].Text = E.func_CompactNumberFormat(cmP[i].skillLevel).."/"..E.func_CompactNumberFormat(cmP[i].maxSkillLevel)
					if cmP[i].skillModifier then
						prof[i].Text = E.func_CompactNumberFormat(cmP[i].skillLevel).."|cff00FF00+"..E.func_CompactNumberFormat(cmP[i].skillModifier).."|r".."/"..E.func_CompactNumberFormat(cmP[i].maxSkillLevel)
					end
				end
			end

			table.insert(characterData, {
					row = row,
					name = pd.Name,
					sortValue = cmP[1].skillLine,
					sortValue2 = cmP[1].skillLevel,
					prof1Icon = prof[1].Icon,
					prof1Text = prof[2].Text,
					prof2Icon = prof[2].Icon,
					prof2Text = prof[2].Text,
			})
		end
	end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			elseif a.sortValue2 ~= b.sortValue2 then
				return a.sortValue2 > b.sortValue2
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	-- local minValue, maxValue
	-- local MinMaxValues = E.func_GetMinMaxValue(characterData, "charValue")
	-- minValue = math_min(unpack(MinMaxValues))
	-- maxValue = math_max(unpack(MinMaxValues))
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		-- local color = E.func_GetGradientHex(d.charValue, minValue, maxValue)
		d.row[2] = d.prof1Icon
		d.row[3] = d.prof1Text
		d.row[4] = ""
		d.row[5] = d.prof2Icon
		d.row[6] = d.prof2Text
		d.row[4] = ""
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	-- if #characterData > 1 then
	-- 	local header = {
	-- 		"1",
	-- 		"2",
	-- 		"3",
	-- 		"4",
	-- 		"5",
	-- 		"6",
	-- 		"7",
	-- 	}
	-- 	table.insert(tooltip, 1, header)
	-- end
	--------------------------------------------------------
	return tooltip
end




function E.func_CurrenciesTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cmC = CharInfo.MASLENGO.Currency

			local curquantity = cmC[id] and cmC[id].quantity or 0
			local curmaxQuantity = cmC[id] and cmC[id].maxQuantity or 0

			-- Фильтр пустоты
			local hasData = curquantity > 0
			if hasData then
				local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)

				local row = { leftText }
				local row2Text = E.func_CompactNumberFormat(curquantity)
				if curmaxQuantity > 0 then
					row2Text = row2Text .. "/" .. E.func_CompactNumberFormat(curmaxQuantity)
				end
				total = total + curquantity
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curquantity,
						-- charValue = curquantity,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetGradientHex(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 0 then
		local header = {
			"",
			TOTAL..": "..E.func_CompactNumberFormat(total),
		}
		table.insert(tooltip, 1, header)
	end
	--------------------------------------------------------
	return tooltip
end




 -- CharInfo.PlayerData.Money

function E.func_MoneyTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData

			local curMoney = pd.Money

			-- Фильтр пустоты
			local hasData = curMoney > 0
			if hasData then
				local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)

				local row = { leftText }
				local row2Text = E.func_MoneyString(curMoney)
				total = total + curMoney
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curMoney,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetGradientHex(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 0 then
		C_WowTokenPublic.UpdateMarketPrice()
		if C_WowTokenPublic.GetCurrentMarketPrice() then
			local price, hz = C_WowTokenPublic.GetCurrentMarketPrice()
			local header1 = {
				"",
				E.func_itemName(122284)..": "..E.func_MoneyString(C_WowTokenPublic.GetCurrentMarketPrice())

			}
			table.insert(tooltip, 1, header1)
		end
		if C_Bank.FetchDepositedMoney(Enum.BankType.Account) then
			local heade2 = {
				"",
				ACCOUNT_BANK_PANEL_TITLE..": "..E.func_MoneyString(C_Bank.FetchDepositedMoney(Enum.BankType.Account)),
			}
			table.insert(tooltip, 2, heade2)
		end
		local heade3 = {
			"",
			TOTAL..": "..E.func_MoneyString(total),
		}
		table.insert(tooltip, 3, heade3)
	end
	--------------------------------------------------------
	return tooltip
end


function E.func_WasOnlineTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData

			local curTime = pd.realTotalTime

			-- Фильтр пустоты
			local hasData = curTime > 0
			if hasData then
				local leftText = E.GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)

				local row = { leftText }
				local row2Text = E.func_SecondsToClock(curTime)
				total = total + curTime
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curTime,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetGradientHex(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 0 then

		local heade1 = {
			"",
			TOTAL..": "..E.func_SecondsToClock(total),
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end



function E.func_KeyTooltip_LEFT(SettingsType)
	if not SettingsType then return end
	local tooltip = {}
	local dataType, id = ("#"):split(SettingsType)
	-- local CharInfo = Octo_ToDo_DB_Levels[GUID]
	----------------------------------------------------------------
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" then
		id = tonumber(id)
	end
	----------------------------------------------------------------
	local total = 0
	local sorted = {}
	local hasTotal = false
	local sortedPlayersTBL = E.func_sorted()
	local visiblePlayers = {}
	for _, charInfo in ipairs(sortedPlayersTBL) do
		visiblePlayers[charInfo.PlayerData.GUID] = true
	end
	local minOnline, maxOnline = 0, 0
	if SettingsType == "Additionally#Money" then
		local MoneysMinMax = {}
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
				table_insert(MoneysMinMax, CharInfo.PlayerData.Money)
			-- end
		end
		EventFrame.minMoney = math_min(unpack(MoneysMinMax))
		EventFrame.maxMoney = math_max(unpack(MoneysMinMax))
		-- elseif dataType == "WasOnline" then
	elseif id == "WasOnline" then
		local OnlineMinMax = {}
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
				table_insert(OnlineMinMax, CharInfo.PlayerData.realTotalTime)
			-- end
		end
		minOnline = math_min(unpack(OnlineMinMax))
		maxOnline = math_max(unpack(OnlineMinMax))
	elseif dataType == "UniversalQuests" then
		local reset = id:match("_([^_]+)$")
		tooltip[#tooltip+1] = {reset}
	end
	if dataType == "Currencies" and id == 1822 then
		tooltip = E.func_CovenantCurrencyTooltip(1822, visiblePlayers, 1) -- Для ренома (typeSL = 1)
	elseif dataType == "Currencies" and id == 1813 then
		tooltip = E.func_CovenantCurrencyTooltip(1813, visiblePlayers, 2) -- Для анимы (typeSL = 2)
	elseif SettingsType == "Additionally#Professions" then
		tooltip = E.func_ProfessionsTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#ItemLevel" then
		tooltip = E.func_ItemLevelTooltipLeft(visiblePlayers)
	elseif dataType == "Currencies" then
		tooltip = E.func_CurrenciesTooltipLeft(visiblePlayers, id)
	elseif SettingsType == "Additionally#Money" then
		tooltip = E.func_MoneyTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#WasOnline" then
		tooltip = E.func_WasOnlineTooltipLeft(visiblePlayers)
	end







	-- print (dataType, id)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local specIcon, color, Name
			local RIGHT1 = ""
			local RIGHT2 = ""
			local curServer, curPers = "", ""
			specIcon = E.func_texturefromIcon(CharInfo.PlayerData.specIcon)
			local colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.Gray_Color
			local colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.Gray_Color
			Name = CharInfo.PlayerData.Name
			if CharInfo.PlayerData.GUID == E.curGUID then
				curPers = E.Green_Color.."*|r"
			end
			if CharInfo.PlayerData.curServer ~= E.func_GetRealmName() then
				curServer = "-"..CharInfo.PlayerData.curServer
			end
			-- if dataType == "Currencies" and id == 1822 then
			-- 	local typeSL = 1 -- Renown
			-- 	local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
			-- 	if curCovID then
			-- 		local totalRenownPerChar = 0
			-- 		local currentCovenantColor = E.OctoTable_Covenant[curCovID].color
			-- 		for covenant = 1, 4 do
			-- 			local covenantColor = E.OctoTable_Covenant[covenant].color
			-- 			if CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL] then
			-- 				total = total + CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL]
			-- 				RIGHT1 = RIGHT1..covenantColor..CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL].."|r "
			-- 			end
			-- 		end
			-- 	end
			-- end

			if dataType == "Items" and CharInfo.MASLENGO.ItemsInBag[id] then
				total = total + CharInfo.MASLENGO.ItemsInBag[id]
				RIGHT1 = CharInfo.MASLENGO.ItemsInBag[id]
				RIGHTforSORT = CharInfo.MASLENGO.ItemsInBag[id]
			end
			if RIGHT1 ~= "" then
				specIcon = E.func_texturefromIcon(CharInfo.PlayerData.specIcon)
				local colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.Gray_Color
				local colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.Gray_Color
				Name = CharInfo.PlayerData.Name
				if CharInfo.PlayerData.GUID == E.curGUID then
					curPers = E.Green_Color.."*|r"
				end
				if CharInfo.PlayerData.curServer ~= E.func_GetRealmName() then
					curServer = "-"..CharInfo.PlayerData.curServer
				end
				sorted[#sorted+1] = {specIcon, colorPlayer, Name, curPers, colorServer, curServer, RIGHT1, RIGHT2, RIGHTforSORT}
			end
		-- end
	end
	if hasTotal == true then
		local index = 1
		local info = sorted[index]
		while info do
			if type(info[7]) == "number" then
				table_remove(sorted, index)
			else
				index = index + 1
			end
			info = sorted[index]
		end
	end
	if total ~= 0 then
		table_sort(sorted, function(a, b)
				if a[9] == b[9] then
					return a[3] < b[3]
				end
				return a[9] > b[9]
		end)
		if SettingsType == "Additionally#ItemLevel" then
			tooltip[#tooltip+1] = {"", CLUB_FINDER_MEDIUM..": "..E.func_CompactNumberFormat(total/#sorted)}
		elseif dataType == "Currencies" then
			-- tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetCurrencyIcon(id))..E.func_currencyName(id), TOTAL..": "..E.func_CompactNumberFormat(total)}
			tooltip[#tooltip+1] = {"", TOTAL..": "..E.func_CompactNumberFormat(total)}
		elseif dataType == "Items" then
			-- tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(id))..E.func_itemName(id), TOTAL..": "..E.func_CompactNumberFormat(total)}
			tooltip[#tooltip+1] = {"", TOTAL..": "..E.func_CompactNumberFormat(total)}
		end
		for _, v in ipairs(sorted) do
			tooltip[#tooltip+1] = {v[1]..v[2]..v[3]..v[4].."|r"..v[5]..v[6].."|r", v[7]..v[8]}
		end
	end
	return tooltip
end
function E.func_KeyTooltip_RIGHT(GUID, SettingsType)
	if not GUID or not SettingsType then return end
	local tooltip = {}
	local CharInfo = Octo_ToDo_DB_Levels[GUID]
	local dataType, id = ("#"):split(SettingsType)
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" then
		id = tonumber(id)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if dataType == "Currencies" and id == 1822 then
		local typeSL = 1 -- Renown
		for covenant = 1, 4 do
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.Gray_Color
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
	end
	if dataType == "Currencies" and id == 1813 then
		local typeSL = 2 -- Anima
		for covenant = 1, 4 do
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.Gray_Color
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			if CharInfo.PlayerData.Possible_Anima and curCovID == covenant then
				centText = centText..E.Blue_Color.."+"..CharInfo.PlayerData.Possible_Anima.."|r"
			end
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
		E.func_tooltipSpacer(tooltip)
	end
	if dataType == "Currencies" and id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600 -- 10 minutes in seconds
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
			local color = E.Gray_Color
			local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, math_floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
			local timeUntilFull = (lastCacheTime + secondsToMax) - GetServerTime()
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.Purple_Color or E.Yellow_Color
				end
			end
			tooltip[#tooltip+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
			tooltip[#tooltip+1] = {" ", " "} -- Empty separator
			if earnedSinceLastCollect ~= cacheSize then
				tooltip[#tooltip+1] = {"Time to full: ", E.func_SecondsToClock(timeUntilFull)}
			end
			tooltip[#tooltip+1] = {"Was earned: ", E.func_SecondsToClock(GetServerTime()-(CharInfo.MASLENGO.GARRISON.lastCacheTime or time()))}
		end
	end
	----------------------------------------------------------------
	-- if dataType == "Currencies" and id == 1166 then
	-- 	for i, v in ipairs(E.func_Mounts_1166()) do
	-- 		local mountID = v.mountID
	-- 		local source = v.source
	-- 		tooltip[#tooltip+1] = {E.func_pizda(mountID), source}
	-- 	end
	-- end
	-- if dataType == "Currencies" and id == 3252 then
	-- 	for i, v in ipairs(E.func_Mounts_3252()) do
	-- 		local mountID = v.mountID
	-- 		local source = v.source
	-- 		tooltip[#tooltip+1] = {E.func_pizda(mountID), E.func_texturefromIcon(E.func_GetCurrencyIcon(id))..v.price, source}
	-- 	end
	-- end
	if id == "LegionRemixResearch" then
		for _, questID in next,(E.OctoTable_RemixInfinityResearch) do
			if CharInfo.MASLENGO.ListOfQuests[questID] then
				tooltip[#tooltip+1] = {E.func_questName(questID), CharInfo.MASLENGO.ListOfQuests[questID]}
			end
		end
	end
	if dataType == "Currencies" then
		for currencyID, dataTBL in pairs(E.OctoTable_ALL_Mounts) do
			if id == tonumber(currencyID) then
				-- Создаем таблицу для сортировки
				local mounts = {}
				for mountID, price in pairs(dataTBL) do
					local mountIconNumber = E.func_mountIcon(mountID)
					local mountIcon = E.func_texturefromIcon(mountIconNumber)
					local mountName = E.func_mountName(mountID)
					local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
					local color = isCollected and E.White_Color or E.Red_Color
					local mountLeftText = mountIcon..color..mountName.."|r"
					table.insert(mounts, {
							id = mountID,
							price = price,
							name = mountName,
							leftText = mountLeftText,
							collected = isCollected
					})
				end
				-- Сортировка: собранные сверху, потом цена, потом имя
				table.sort(mounts, function(a, b)
						-- 1. Собранные маунты сверху
						-- if a.collected ~= b.collected then
						-- return b.collected
						-- end
						-- 2. По цене (дорогие сверху)
						-- if a.price ~= b.price then
						-- return a.price > b.price
						-- end
						-- 2. По имени
						if a.name ~= b.name then
							return a.name < b.name
						end
						-- 4. По id
						return a.id < b.id
				end)
				-- Добавляем в tooltip
				for _, mount in ipairs(mounts) do
					tooltip[#tooltip + 1] = {
						mount.leftText,
						" ",
						E.func_CompactNumberFormat(mount.price)..
						E.func_texturefromIcon(E.func_GetCurrencyIcon(currencyID))
					}
				end
			end
		end
	end
	if SettingsType == "BfA_mechagonItems" then
		tooltip = E.func_tooltipCENT_ITEMS(CharInfo, E.OctoTable_itemID_MECHAGON, true)
	end
		----------------------------------------------------------------
	if dataType == "Reputations" then
		if CharInfo.MASLENGO.Reputation[id] and type(CharInfo.MASLENGO.Reputation[id]) == "string" then
			local FIRST, SECOND, vivod, ColorCenter, standing = ("#"):split(CharInfo.MASLENGO.Reputation[id])
			local firstTEXT = E.func_texturefromIcon(E.func_reputaionIcon(id))..E.func_reputationName(id)
			local secondTEXT = FIRST.."/"..SECOND
			if secondTEXT == "1/1" then
				secondTEXT = E.DONE
			end
			local thirdTEXT = ColorCenter..standing.."|r"
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and CharInfo.MASLENGO.ListOfParagonQuests[questID] then
					isParagonRewardEnable = E.Purple_Color..">>"..CONTRIBUTION_REWARD_TOOLTIP_TITLE.."<<|r"
				end
			end
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and CharInfo.MASLENGO.ListOfParagonQuests[questID] then
					secondTEXT = E.Purple_Color.."> "..FIRST.."/"..SECOND.." <".."|r"
				end
			end
			if secondTEXT ~= "0/0" then
				tooltip[#tooltip+1] = {firstTEXT}
				tooltip[#tooltip+1] = {secondTEXT, thirdTEXT}
			end
		-- else
		-- 	opde(CharInfo.MASLENGO.Reputation[id])
		end
	end
	if SettingsType == "Additionally#AllItems" then
		tooltip = E.func_tooltipCENT_ITEMS(CharInfo, E.OctoTable_itemID_ALL, false)
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#Professions" then
		local charProf = CharInfo.MASLENGO.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				local leftText = E.func_ProfessionIcon(charProf[i].skillLine).." "..E.func_ProfessionName(charProf[i].skillLine)
				local rightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
				if charProf[i].skillModifier then
					rightText = charProf[i].skillLevel.."|cff00FF00+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
				end
				tooltip[#tooltip+1] = {leftText, rightText}
				if charProf[i].child then
					-- for expIndex, v in ipairs(charProf[i].child) do
					for expIndex = #charProf[i].child, 1, -1 do
						local v = charProf[i].child[expIndex]
						if v.QWEskillLevel and v.QWEprofessionName then
							-- for expI, j in ipairs(E.OctoTable_Expansions) do
							-- for expI = #E.OctoTable_Expansions, 1, -1 do
							-- local j = E.OctoTable_Expansions[expI]
							local j = E.OctoTable_Expansions[expIndex]
							tooltip[#tooltip+1] = {E.func_ExpansionVivod(expIndex), v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
							-- end
							-- end
						end
					end
				end
			end
		end
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#ItemLevel" then
		if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
			if CharInfo.PlayerData.avgItemLevelPvp and CharInfo.PlayerData.avgItemLevelPvp > CharInfo.PlayerData.avgItemLevel then
				tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.PlayerData.avgItemLevelPvp)}
			end
		end
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#Money" then
		if CharInfo.PlayerData.Money then
			local function addMoneyDiff(label, oldValue)
				if not oldValue then return end
				local diff = CharInfo.PlayerData.Money - oldValue
				if diff == 0 then return end
				local sign = diff > 0 and "+" or "-"
				local color = diff > 0 and E.Green_Color or E.Red_Color
				local result = sign..E.func_MoneyString(math.abs(diff))
				tooltip[#tooltip + 1] = {label, color..result.."|r"}
			end
			addMoneyDiff("SESSION", CharInfo.PlayerData.MoneyOnLogin)
			addMoneyDiff("DAILY", CharInfo.PlayerData.MoneyOnDaily)
			addMoneyDiff("WEEKLY", CharInfo.PlayerData.MoneyOnWeekly)
		end
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#WasOnline" then
		local color = "|cffFFFFFF"
		if CharInfo.PlayerData.loginHour and CharInfo.PlayerData.loginDay then
			if CharInfo.PlayerData.GUID == E.curGUID then
				-- tooltip[#tooltip+1] = {"Время после релоуда: "..CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(GetServerTime() - CharInfo.PlayerData.time).."|r", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r" ), " "}
			else
				if CharInfo.PlayerData.needResetWeekly then
					color = E.Gray_Color
				elseif CharInfo.PlayerData.needResetDaily then
					color = E.Red_Color
				end
				tooltip[#tooltip+1] = {color..E.func_FriendsFrame_GetLastOnlineText(CharInfo.PlayerData.time, CharInfo.PlayerData.classColorHex).."|r", ""}
				tooltip[#tooltip+1] = {"", ""}
				tooltip[#tooltip+1] = {color..CharInfo.PlayerData.loginDay.."|r", ""}
				tooltip[#tooltip+1] = {color..CharInfo.PlayerData.loginHour.."|r", ""}
			end
		end
	end
		----------------------------------------------------------------
	if SettingsType == "TWW_GreatVault" then
		local Enum_Activities_table = {}
		for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
			Enum_Activities_table[#Enum_Activities_table+1] = i
		end
		table_sort(Enum_Activities_table)
		for j = 1, #Enum_Activities_table do
			local i = Enum_Activities_table[j]
			if CharInfo.MASLENGO.GreatVault[i] and CharInfo.MASLENGO.GreatVault[i].type ~= "" then
				if CharInfo.MASLENGO.GreatVault[i].progress and CharInfo.MASLENGO.GreatVault[i].threshold then
					if CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING then
						tooltip[#tooltip+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold.." "..CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING}
					elseif CharInfo.MASLENGO.GreatVault[i].progress then
						tooltip[#tooltip+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold}
					end
				end
			end
		end
	end
		----------------------------------------------------------------
	if SettingsType == "TWW_CurrentKey" then
		if CharInfo.PlayerData.CurrentKeyName then
			tooltip[#tooltip+1] = {CharInfo.PlayerData.CurrentKeyLevel.." "..CharInfo.PlayerData.CurrentKeyName, ""}
		end
		if CharInfo.PlayerData.RIO_Score and CharInfo.PlayerData.RIO_weeklyBest then
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Weekly Best:", CharInfo.PlayerData.RIO_weeklyBest}
			tooltip[#tooltip+1] = {"RIO Score:", CharInfo.PlayerData.RIO_Score}
		end
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#ListOfQuests" then
		if CharInfo.PlayerData.numQuests then
			local questIDs = {}
			for questID in next, CharInfo.MASLENGO.ListOfQuests do
				questIDs[#questIDs+1] = questID
			end
			table_sort(questIDs, E.func_Reverse_order)
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[i] = {E.func_questName(questID), CharInfo.MASLENGO.ListOfQuests[questID]}
			end
		end
	end
		----------------------------------------------------------------
	if SettingsType == "Additionally#LFGInstance" then
		local combinedTooltip = {}
		for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
			for difficultyID, w in next, (v) do
				if w.vivod then
					table_insert(combinedTooltip, {
							name = w.instanceName.."("..w.difficultyName..") "..E.debugInfo(instanceID),
							status = w.vivod,
							time = E.func_SecondsToClock(w.instanceReset-GetServerTime())
					})
				end
			end
		end
		for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
			if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday then
				table_insert(combinedTooltip, {
						name = CharInfo.MASLENGO.LFGInstance[dungeonID].D_name..E.debugInfo(dungeonID),
						status = " ",
						time = CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday
				})
			end
		end
		for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
			table_insert(combinedTooltip, {
					-- name = E.func_texturefromIcon(E.Icon_WorldBoss)..v.name..E.debugInfo(worldBossID),
					name = v.name..E.debugInfo(worldBossID),
					status = " ",
					time = E.func_SecondsToClock(v.reset)
			})
		end
		-- Сортировка по name
		table_sort(combinedTooltip, function(a, b)
				return a.name < b.name
		end)
		-- Выводим отсортированные данные
		for _, v in ipairs(combinedTooltip) do
			tooltip[#tooltip+1] = {
				v.name,
				"|cff9999ff"..v.time.."|r",
				v.status
			}
		end
		-- if #tooltip ~= 0 then
		-- TextCenter = E.Gray_Color..DUNGEONS.."|r"
		-- end
		----------------------------------------------------------------
		-- elseif SettingsType:find(E.UNIVERSAL) then
	end
	if dataType == "UniversalQuests" then
		for _, data in next,(E.ALL_UniversalQuests) do
			if not data.quests then
				break -- Пропускаем записи без квестов
			end
			local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
			local showTooltip = data.showTooltip or false
			-- id eto questKey
			if showTooltip and id == questKey then
				-- Подсчет общего числа квестов
				local totalQuest = 0
				local forcedMaxQuest = data.forcedMaxQuest
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == CharInfo.PlayerData.Faction then
						if forcedMaxQuest and type(forcedMaxQuest) == "string" and forcedMaxQuest == "all" then
							totalQuest = totalQuest + 1
						elseif forcedMaxQuest and type(forcedMaxQuest) == "number" then
							totalQuest = forcedMaxQuest
							break
						else
							totalQuest = totalQuest + 1
						end
					end
				end
				forcedMaxQuest = totalQuest
				-- Заголовок тултипа (если квестов больше одного)
				if E.DebugUniversal then
					tooltip[#tooltip+1] = {questKey, "forcedMaxQuest: "..totalQuest}
				end
				if totalQuest > 1 then
					local TextLeft = tostringall(func_OnceDailyWeeklyMonth_Format(data.reset).." "..data.TextLeft)
					tooltip[#tooltip+1] = {" ", TOTAL..": "..totalQuest}
					tooltip[#tooltip+1] = {" "}
				end
				-- Список квестов в тултипе
				local questsToShow = {}
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == CharInfo.PlayerData.Faction then
						table_insert(questsToShow, questData)
					end
				end
				if data.sorted ~= false then
					table_sort(questsToShow, function(a, b)
							local function getName(entry)
								if entry.forcedText then
									if entry.forcedText.npcID then
										return E.func_npcName(entry.forcedText.npcID) or ""
									elseif entry.forcedText.text then
										return entry.forcedText.text or ""
									end
								end
								return E.func_questName(entry[1]) or ""
							end
							return getName(a) < getName(b)
					end)
				end
				-- Формирование строк тултипа
				for _, questData in ipairs(questsToShow) do
					local questID = questData[1]
					local faction = questData.faction
					local forcedText = questData.forcedText
					local forcedIcon = questData.forcedIcon
					local addText = questData.addText
					local vivod_LEFT = ""
					local vivod_RIGHT = ""
					if questID then
						vivod_RIGHT = CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] and CharInfo.MASLENGO.UniversalQuest[questKey][questID] or E.Gray_Color..NONE.."|r"
					end
					if forcedText then
						-- Добавляем текст
						if forcedText.text then
							vivod_LEFT = vivod_LEFT..forcedText.text.." "
						end
						-- Добавляем имя NPC
						if forcedText.npcID then
							vivod_LEFT = vivod_LEFT..E.func_npcName(forcedText.npcID).." "
						end
						-- Добавляем название достижения
						if forcedText.achievementID then
							vivod_LEFT = vivod_LEFT..E.func_achievementName(forcedText.achievementID).." "
						end
						-- Добавляем название предмета
						if forcedText.itemID then
							vivod_LEFT = vivod_LEFT..E.func_itemName(forcedText.itemID).." "
						end
						if forcedText.Icon then
							vivod_LEFT = E.func_texturefromIcon(forcedText.Icon)..vivod_LEFT
						end
						-- Удаляем лишний пробел в конце
						vivod_LEFT = vivod_LEFT:match("^(.-)%s*$")
					else
						if questID then
							vivod_LEFT = vivod_LEFT..E.func_questName(questID)
						end
					end
					if addText then
						-- Добавляем иконку Vignette
						if addText.IconVignette then
							vivod_LEFT = E.func_texturefromIcon(addText.IconVignette, nil, nil, true)..vivod_LEFT
						end
						if addText.Icon then
							vivod_LEFT = E.func_texturefromIcon(addText.Icon)..vivod_LEFT
						end
						if addText.mount then
							-- local mountIconNumber = E.func_mountIcon(addText.mount)
							-- local mountIcon = E.func_texturefromIcon(mountIconNumber)
							-- local mountName = mountIcon..E.func_mountIsCollectedColor(addText.mount)..E.func_mountName(addText.mount).."|r"
							vivod_LEFT = vivod_LEFT..E.Purple_Color.." +"..string_format(RENOWN_REWARD_MOUNT_NAME_FORMAT, E.func_pizda(addText.mount)).."|r"
						end
						if addText.notes then
							vivod_LEFT = vivod_LEFT..addText.notes
						end
						if addText.mapID then
							vivod_LEFT = vivod_LEFT..E.Gray_Color.." ("..E.func_mapName(addText.mapID)..")|r"
						end
						if addText.spellID then
							vivod_LEFT = vivod_LEFT..E.Pink_Color..E.func_spellName(addText.spellID).."|r"
						end
						if addText.text then
							vivod_LEFT = vivod_LEFT..addText.text
						end
					end
					if faction == CharInfo.PlayerData.Faction then
						vivod_LEFT = E.func_texturefromIcon(E.func_FactionIconID(faction))..vivod_LEFT
					end
					tooltip[#tooltip+1] = {vivod_LEFT, vivod_RIGHT}
				end
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		--elseif SettingsType == "ЙЦУЙЦУ" then
		----------------------------------------------------------------
		--elseif SettingsType == "ЙЦУЙЦУ" then
		----------------------------------------------------------------
		----------------------------------------------------------------
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
function E.func_TextCenter_Chars_nickname(CharInfo)
	local namePart = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r"
	local levelPart = ""
	if CharInfo.PlayerData.UnitLevel and CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerData.PlayerCanEarnExperience then
		levelPart = " "..E.Yellow_Color..CharInfo.PlayerData.UnitLevel.."|r"
	end
	return namePart..levelPart
end
function E.func_TextCenter_Chars_server(CharInfo)
	local serverPart = ""
	if not Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and E.curServerShort ~= CharInfo.PlayerData.curServer then
		serverPart = E.Skyblue_Color..CharInfo.PlayerData.curServer.."|r"
	end
	return serverPart
end
----------------------------------------------------------------
function E.func_Tooltip_Chars(CharInfo)
	local tooltip_Chars = {}
	-- Basic character information
	if CharInfo.PlayerData.classColorHex then
		-- Name and guild info
		if CharInfo.PlayerData.Name and CharInfo.PlayerData.curServer then
			tooltip_Chars.Header = {CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r ("..CharInfo.PlayerData.curServer..")"}
			-- tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r ("..CharInfo.PlayerData.curServer..")"}
		end
		if CharInfo.PlayerData.guildRankName and CharInfo.PlayerData.guildRankIndex then
			tooltip_Chars[#tooltip_Chars+1] = {"<"..E.Green_Color..CharInfo.PlayerData.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.PlayerData.guildRankName.."|r".."]"}
		end
		-- War mode status
		if CharInfo.PlayerData.WarMode then
			tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""}
		end
		-- Level and race info
		if CharInfo.PlayerData.RaceLocal then
			if CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerData.UnitXPPercent then
				tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.RaceLocal.." "..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.UnitLevel.."-го|r уровня "..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.UnitXPPercent.."%|r", ""}
			else
				tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.RaceLocal, ""}
			end
		end
		-- Spec and class info
		if CharInfo.PlayerData.specName and CharInfo.PlayerData.specIcon then
			tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon(CharInfo.PlayerData.specIcon)..CharInfo.PlayerData.specName.." "..CharInfo.PlayerData.className, ""}
		end
	end
	-- Chromie time info
	if CharInfo.PlayerData.Chromie_name and CharInfo.PlayerData.Chromie_name ~= "" then
		tooltip_Chars[#tooltip_Chars+1] = {" ", " "}
		-- tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon("ChromieMap", nil, nil, true)..L["Chromie"]..": "..E.Green_Color..CharInfo.PlayerData.Chromie_name.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon("ChromieMap", nil, nil, true)..E.func_npcName(167032)..": "..E.Green_Color..CharInfo.PlayerData.Chromie_name.."|r"}
	end
	-- Location info
	if CharInfo.PlayerData.BindLocation then
		tooltip_Chars[#tooltip_Chars+1] = {" ", " "}
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon(134414)..string.format(BIND_ZONE_DISPLAY, CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.BindLocation.."|r"), ""}
	end
	if CharInfo.PlayerData.curLocation then
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon(132319)..FRIENDS_LIST_ZONE..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.curLocation.."|r", ""}
	end
	-- Inventory info
	if CharInfo.PlayerData.usedSlots and CharInfo.PlayerData.totalSlots then
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon(133634)..L["Bags"]..": "..CharInfo.PlayerData.classColorHex..(CharInfo.PlayerData.usedSlots.."/"..CharInfo.PlayerData.totalSlots).."|r", ""}
	end
	-- Quests info
	if CharInfo.PlayerData.numQuests and CharInfo.PlayerData.maxNumQuestsCanAccept then
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon(236664)..QUESTS_LABEL..": "..CharInfo.PlayerData.classColorHex..(CharInfo.PlayerData.numQuests.."/"..CharInfo.PlayerData.maxNumQuestsCanAccept).."|r", ""}
	end
	-- Play time info
	if CharInfo.PlayerData.realTotalTime then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(CharInfo.PlayerData.realTotalTime)).."|r", ""}
		tooltip_Chars[#tooltip_Chars+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(CharInfo.PlayerData.realLevelTime)).."|r", ""}
	end
	-- Special item info
	if CharInfo.MASLENGO.ItemsInBag[122284] then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {E.func_itemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
	end
	-- Debug information
	if E.DebugCharacterInfo then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {E.DEVTEXT, ""}
		if CharInfo.PlayerData.tmstp_Daily then
			tooltip_Chars[#tooltip_Chars+1] = {"tmstp_Daily: "..CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(CharInfo.PlayerData.tmstp_Daily-GetServerTime()).."|r", ""}
		end
		if CharInfo.PlayerData.tmstp_Weekly then
			tooltip_Chars[#tooltip_Chars+1] = {"tmstp_Weekly: "..CharInfo.PlayerData.classColorHex..E.func_SecondsToClock(CharInfo.PlayerData.tmstp_Weekly-GetServerTime()).."|r", ""}
		end
		-- Character identification
		tooltip_Chars[#tooltip_Chars+1] = {E.Purple_Color.."GUID".."|r", E.Purple_Color..CharInfo.PlayerData.GUID.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"hasMail", CharInfo.PlayerData.hasMail and E.func_texturefromIcon(E.Icon_MailBox)..CharInfo.PlayerData.classColorHex.."true|r"}
		-- Chromie time debug info
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_canEnter", CharInfo.PlayerData.Chromie_canEnter and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_UnitChromieTimeID", CharInfo.PlayerData.Chromie_UnitChromieTimeID}
		-- if CharInfo.PlayerData.Chromie_name then
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_name", CharInfo.PlayerData.Chromie_name}
		-- end
		-- BattleTag info
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTag", E.Blue_Color..CharInfo.PlayerData.BattleTag.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTagLocal", E.Blue_Color..CharInfo.PlayerData.BattleTagLocal.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account restrictions
		tooltip_Chars[#tooltip_Chars+1] = {"GameLimitedMode_IsActive", CharInfo.PlayerData.GameLimitedMode_IsActive and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"levelCapped20", CharInfo.PlayerData.levelCapped20 and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"PlayerCanEarnExperience", CharInfo.PlayerData.PlayerCanEarnExperience and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Build info
		tooltip_Chars[#tooltip_Chars+1] = {"buildVersion", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"buildNumber", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildNumber.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"buildDate", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildDate.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"interfaceVersion", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.interfaceVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Version info
		tooltip_Chars[#tooltip_Chars+1] = {"currentTier", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.currentTier.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"IsPublicBuild", CharInfo.PlayerData.IsPublicBuild and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account limits
		tooltip_Chars[#tooltip_Chars+1] = {"max LVL", CharInfo.PlayerData.GetRestrictedAccountData_rLevel and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"max Money", CharInfo.PlayerData.GetRestrictedAccountData_rMoney and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account security
		tooltip_Chars[#tooltip_Chars+1] = {"Authenticator", CharInfo.PlayerData.IsAccountSecured and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"УЗ имеет ограничения пробной УЗ", CharInfo.PlayerData.IsRestrictedAccount and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"Использует ли игрок пробную УЗ", CharInfo.PlayerData.IsTrialAccount and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"Нет игрового времени", CharInfo.PlayerData.IsVeteranTrialAccount and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Durability
		tooltip_Chars[#tooltip_Chars+1] = {"PlayerDurability", CharInfo.PlayerData.PlayerDurability and E.TRUE}
		-- DBVersion
		tooltip_Chars[#tooltip_Chars+1] = {"DBVersion", CharInfo.PlayerData.DBVersion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegion", CharInfo.PlayerData.CurrentRegion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegionName", CharInfo.PlayerData.CurrentRegionName}
	end
	return tooltip_Chars
end
----------------------------------------------------------------
function E.func_AddonNameForOptionsFunc(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title").." "..E.Gray_Color..E.func_GetAddOnMetadata(addonName, "Version").."|r"
end
function E.func_AddonNameForOptionsInit(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title")
end
----------------------------------------------------------------
-- function E.InitGlobalDB(addonName)
-- local savedVarName = addonName.."_DB"
-- _G[savedVarName] = _G[savedVarName] or {}
-- -------------------------- ПОВТОР? -----------------------------
-- for _, entry in ipairs(E.OctoTable_SavedVariables) do
-- if entry.name == savedVarName then
-- return _G[savedVarName], savedVarName
-- end
-- end
-- ----------------------------------------------------------------
-- table.insert(E.OctoTable_SavedVariables, {
-- tbl = _G[savedVarName],
-- name = savedVarName
-- })
-- return _G[savedVarName], savedVarName
-- end
----------------------------------------------------------------
function E.InitGlobalDB(addonName)
	local savedVarName = addonName.."_DB"
	_G[savedVarName] = _G[savedVarName] or {}
	-- Защита от повторов
	for _, entry in ipairs(E.OctoTable_SavedVariables or {}) do
		if entry.name == savedVarName then
			E.SavedVarsByAddon = E.SavedVarsByAddon or {}
			E.SavedVarsByAddon[addonName] = _G[savedVarName]
			return _G[savedVarName], savedVarName
		end
	end
	E.OctoTable_SavedVariables = E.OctoTable_SavedVariables or {}
	table.insert(E.OctoTable_SavedVariables, {
			tbl = _G[savedVarName],
			name = savedVarName
	})
	E.SavedVarsByAddon = E.SavedVarsByAddon or {}
	E.SavedVarsByAddon[addonName] = _G[savedVarName]
	return _G[savedVarName], savedVarName
end
----------------------------------------------------------------
local countSavedVars = 0
function E.func_GetSavedVars(addonName)
	if not (E.SavedVarsByAddon and E.SavedVarsByAddon[addonName]) then
		E.InitGlobalDB(addonName)
	end
	countSavedVars = countSavedVars + 1
	return E.SavedVarsByAddon[addonName]
end
----------------------------------------------------------------
-- local function safecall(f,...)
-- 	local ok, err = pcall(f,...)
-- 	if not ok then
-- 		print("Ошибка в отложенной функции:", err)
-- 	end
-- end
-- function E.func_SpamBlock(key, isCombat, callback)
-- 	E._spamLocks = E._spamLocks or {}
-- 	E._spamCombatQueue = E._spamCombatQueue or {}
-- 	if isCombat and InCombatLockdown() then
-- 		-- если уже есть отложенный вызов — не ставим второй раз
-- 		if not E._spamCombatQueue[key] and type(callback) == "function" then
-- 			E._spamCombatQueue[key] = callback
-- 			-- один раз подписываемся на событие выхода из боя
-- 			if not E._spamCombatFrame then
-- 				E._spamCombatFrame = CreateFrame("Frame")
-- 				E._spamCombatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 				E._spamCombatFrame:SetScript("OnEvent", function()
-- 						for k, func in pairs(E._spamCombatQueue) do
-- 							safecall(func) -- безопасный вызов, чтобы не крашнуло
-- 							E._spamCombatQueue[k] = nil
-- 						end
-- 				end)
-- 			end
-- 		end
-- 		return true -- Заблокировано
-- 	end
-- 	if E._spamLocks[key] then
-- 		return true -- Всё ещё в задержке
-- 	end
-- 	E._spamLocks[key] = true
-- 	C_Timer.After(E.SPAM_TIME or 0.5, function()
-- 			E._spamLocks[key] = nil
-- 	end)
-- 	return false -- Всё нормально, можно выполнять
-- end
----------------------------------------------------------------
function E.func_SpamBlock(key, needCheckCombat)
	if (needCheckCombat == nil or needCheckCombat == true) and InCombatLockdown() then
		return true -- Заблокировано
	end
	E._spamLocks = E._spamLocks or {}
	if E._spamLocks[key] then
		return true -- Заблокировано
	end
	E._spamLocks[key] = true
	C_Timer.After(E.SPAM_TIME or 0.5, function()
			E._spamLocks[key] = nil
	end)
	return false -- Всё норм
end
----------------------------------------------------------------
function E.func_LoadComponents(start)
	for i, func in ipairs(E.Components) do
		func(start)
	end
end
----------------------------------------------------------------
function E.func_ResetOtrisovkaTables(categoryKey)
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {}
	E.OctoTables_DataOtrisovka[categoryKey].Items = {}
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {}
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {}
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {}
end
----------------------------------------------------------------
function E.func_SmoothBackgroundAlphaChange(frame_main, frame_Background, event)
	if InCombatLockdown() or not frame_main or not frame_Background or not event then return end
	if frame_main:IsShown() then
		local targetAlpha = Octo_ToDo_DB_Vars.Config_AlphaOnDrag
		if targetAlpha == 1 then return end
		local duration = 0.3
		local currentAlpha = frame_Background:GetAlpha()
		if event == "PLAYER_STOPPED_MOVING" then
			targetAlpha = 1
			duration = 0.1
		elseif event == "OnShow" then
			targetAlpha = 1
			duration = 0.5
		end
		if currentAlpha == targetAlpha then return end
		if not frame_Background.alphaAnim then
			frame_Background.alphaAnim = frame_Background:CreateAnimationGroup()
			frame_Background.alphaAnim.animation = frame_Background.alphaAnim:CreateAnimation("Alpha")
			frame_Background.alphaAnim.animation:SetDuration(duration)
			frame_Background.alphaAnim:SetScript("OnFinished", function(self)
					frame_Background:SetAlpha(self.targetAlpha)
			end)
		end
		-- print ("currentAlpha:", E.Blue_Color..currentAlpha.."|r", "targetAlpha:", E.Blue_Color..targetAlpha.."|r", "duration:", E.Blue_Color..duration.."|r")
		if math.abs(currentAlpha - targetAlpha) < 0.01 then
			return
		end
		frame_Background.alphaAnim.animation:SetFromAlpha(currentAlpha)
		frame_Background.alphaAnim.animation:SetToAlpha(targetAlpha)
		frame_Background.alphaAnim.targetAlpha = targetAlpha
		if frame_Background.alphaAnim:IsPlaying() then
			frame_Background.alphaAnim:Stop()
		end
		frame_Background.alphaAnim:Play()
	end
end
----------------------------------------------------------------
function E.func_GetMountIDFromItemID(itemID)
	return GetMountFromItem(itemID)
end
----------------------------------------------------------------
function E.SafeCall(func,...)
	local success, result = pcall(func,...)
	if not success then
		-- Логирование ошибки
		return nil
	end
	return result
end
----------------------------------------------------------------
function E.func_tooltipSpacer(tooltip)
	if not tooltip then return end
	if #tooltip > 0 then
		tooltip[#tooltip+1] = {" "}
	end
	return
end
----------------------------------------------------------------
function E.func_GetMinMaxValue(tbl, data)
	if type(tbl) ~= "table" then
		return nil, nil
	end

	local minValue, maxValue

	for _, v in next, tbl do
		local value = (type(v) == "table" and v[data]) or 0

		if minValue == nil or value < minValue then
			minValue = value
		end
		if maxValue == nil or value > maxValue then
			maxValue = value
		end
	end

	return minValue, maxValue
end

----------------------------------------------------------------

-- function E.func_GetGradientHex(value, minValue, maxValue)
-- 	-- текущее, мин, макс
-- 	if not value or not minValue or not maxValue or minValue >= maxValue then
-- 		return "|cff00ff00"
-- 	end
-- 	local p = (value - minValue) / (maxValue - minValue)
-- 	if p < 0 then p = 0 end
-- 	if p > 1 then p = 1 end
-- 	local r, g
-- 	if p < 0.5 then
-- 		r = 255
-- 		g = math.floor(p * 2 * 255)
-- 	else
-- 		g = 255
-- 		r = math.floor((1 - (p - 0.5) * 2) * 255)
-- 	end
-- 	return string.format("|cff%02x%02x00", r, g)
-- end
----------------------------------------------------------------
function E.func_GetGradientHex(value, minValue, maxValue, minHex, midHex, maxHex)
	-- дефолты на случай кривых рук
	minHex = minHex or E.Red_Color
	midHex = midHex or E.Yellow_Color
	maxHex = maxHex or E.Green_Color

	if not value or not minValue or not maxValue or minValue >= maxValue then
		return maxHex
	end

	local p = (value - minValue) / (maxValue - minValue)
	if p < 0 then p = 0 end
	if p > 1 then p = 1 end

	local r1, g1, b1
	local r2, g2, b2
	local t

	if p < 0.5 then
		r1, g1, b1 = E.func_hex2rgb(minHex)
		r2, g2, b2 = E.func_hex2rgb(midHex)
		t = p * 2
	else
		r1, g1, b1 = E.func_hex2rgb(midHex)
		r2, g2, b2 = E.func_hex2rgb(maxHex)
		t = (p - 0.5) * 2
	end

	local r = math.floor(Lerp(r1, r2, t))
	local g = math.floor(Lerp(g1, g2, t))
	local b = math.floor(Lerp(b1, b2, t))

	return string.format("|cff%02x%02x%02x", r, g, b)
end


----------------------------------------------------------------