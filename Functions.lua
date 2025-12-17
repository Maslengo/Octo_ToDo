local GlobalAddonName, E =...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
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
function E.func_GetAtlasIcon(atlasName, iconWidth, iconHeight)
	if not atlasName then return end
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	return CreateAtlasMarkup(atlasName, iconWidth, iconHeight)
end
function E.func_texturefromIcon(icon, iconWidth, iconHeight, isAtlas)
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	if isAtlas then
		return E.func_GetAtlasIcon(icon, iconWidth, iconHeight)
	else
		return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconWidth)..":"..(iconHeight)..":::64:64:6:58:6:58|t "
	end
end
function E.func_texturefromIconEVENT(icon, iconSize)
	iconSize = iconSize or 16
	return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconSize)..":"..(iconSize)..":::128:128:0:91:0:91|t "
end
function E.func_GetItemIcon(itemID)
	local texture = GetItemIconByID(itemID) or E.ICON_QUESTION_MARK
	return texture
end
function E.func_GetTSMPrice(itemID, myCount)
	local result = ""
	local count = 0
	if myCount then
		count = myCount
	else
		count = E.func_GetItemQuantity(itemID, true, true, true, false)
	end
	if TSM_API then
		local TSM_ItemIDtest = "i:"..itemID
		local CustomPriceValue = (TSM_API.GetCustomPriceValue("DBMarket", TSM_ItemIDtest)) or 0
		if count and count ~= 0 and CustomPriceValue ~= 0 then
			if count ~= 1 then
				result = result..E.COLOR_PURPLE.."*"..count.."|r ("..TSM_API.FormatMoneyString(CustomPriceValue*count)..")"
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
function E.func_GetLFGDungeonName(dID)
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID == dID then
			return name
		end
	end
	return RETRIEVING_DATA
end
function E.func_GetSpellIcon(spellID)
	local texture = GetSpellTexture(spellID) or E.ICON_QUESTION_MARK
	return texture
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
		-- 	name = E.ICON_ACCOUNT_WIDE..name
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
		if E.Collect_Holiday then
			pcall(E.Collect_Holiday)
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_IsAccountQuest(questID)
	return IsAccountQuest(questID)
end
function E.func_IsQuestFlaggedCompletedOnAccount(questID)
	return IsQuestFlaggedCompletedOnAccount(questID)
end
function E.func_GetFullMapInfo(mapID)
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
function E.func_GetPlayerLocation()
	local curRealZone = GetRealZoneText() -- C_Map.GetBestMapForUnit("player") ПОФИКСИТЬ (УСТАРЕЛО?)
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText() -- C_Map.GetMapInfo() ПОФИКСИТЬ (УСТАРЕЛО?)
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText() -- C_Map.GetMapInfo() ПОФИКСИТЬ (УСТАРЕЛО?)
	local uiMapID = MapUtil.GetDisplayableMapForPlayer()
	if uiMapID ~= 0 then
		local mapInfo = E.func_GetFullMapInfo(uiMapID)
		if FIRSTtext == "" then
			return E.COLOR_RED..mapInfo.name.."|r", false
		elseif FIRSTtext == SECONDtext then
			return FIRSTtext, true
		else
			return SECONDtext ~= "" and FIRSTtext.." ("..SECONDtext..")" or FIRSTtext, true
		end
	end
	return UNKNOWN, true
end
function E.func_GetItemData(itemInfo)
	return GetItemInfo(itemInfo)
end
function E.func_GetItemQuantity(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if not itemID then return end
	return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
end
function E.func_GetItemHyperlink(itemID)
	local _, link = E.func_GetItemData(itemID)
	return link
end
function E.func_GetItemQualityLevel(itemID)
	return GetItemQualityByID(itemID) or 0
end
function E.func_GetItemQualityColorTable(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQualityLevel(itemID)]
end
function E.func_GetQualityHexColor(quality)
	local numQuality = tonumber(quality)
	if numQuality and numQuality > 0 and numQuality < 8 then
		return ITEM_QUALITY_COLORS[numQuality].hex
	end
	return E.COLOR_WHITE
end
function E.func_GetQualityColorRGB(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
function E.func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
function E.func_GetItemLevelDetails(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
function E.func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactRoundNumber(result)
end
function E.func_GetSpellDescription(spellID)
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
	return E.func_CompactRoundNumber(result)
end
function E.func_Hex2RGB(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
function E.func_Hex2RGBFloat(hex)
	if hex and hex ~= "" then
		hex = hex:gsub("|cff", "")
		return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
	else
		return 1, 1, 1
	end
end
function E.func_RGB2Hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E.func_RGB2HexString(r, g, b, a)
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
		local r1, g1, b1 = E.func_Hex2RGB(firstColor)
		local r2, g2, b2 = E.func_Hex2RGB(secondColor)
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
function E.func_CompactFormatNumber(num)
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
function E.func_FormatMoney(number)
	if not number then return 0 end
	if number > 10000 then
		return E.func_CompactFormatNumber(number/10000).."|r".."|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
	elseif number > 100 then
		return E.func_CompactFormatNumber(number/100).."|r".."|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
	else
		return E.func_CompactFormatNumber(number).."|r".."|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
	end
end
function E.func_CompactRoundNumber(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math_floor(number+.5)
	end
end
function E.func_SecondsToClock(time, allwaysShowSeconds)
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
		if allwaysShowSeconds then
			table_insert(parts, " "..secs..(L["time_SECOND"] or "s"))
		end
	elseif days > 0 then
		table_insert(parts, days..(L["time_DAY"] or "d").." ")
		table_insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table_insert(parts, mins..(L["time_MINUTE"] or "m"))
		if allwaysShowSeconds then
			table_insert(parts, " "..secs..(L["time_SECOND"] or "s"))
		end
	elseif hours > 0 then
		table_insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table_insert(parts, string_format("%02d", mins)..(L["time_MINUTE"] or "m"))
		if allwaysShowSeconds then
			table_insert(parts, " "..string_format("%02d", secs)..(L["time_SECOND"] or "s"))
		end
	elseif time >= 60 then
		table_insert(parts, mins..(L["time_MINUTE"] or "m").." ")
		if time < 600 or allwaysShowSeconds then
			table_insert(parts, secs..(L["time_SECOND"] or "s"))
		end
	elseif time >= 1 then
		table_insert(parts, secs..(L["time_SECOND"] or "s"))
	else
		table_insert(parts, string_format("%.3f", time).."ms")
	end

	return table_concat(parts)
end
function E.func_GetNextResetTime(time)
	local time = time or 1
	local daytime = 86400
	local thursdayReset = GetWeeklyResetStartTime()
	return (math_ceil((GetServerTime() - thursdayReset)/(daytime*time))*daytime*time)+thursdayReset
end
function E.func_GetSecondsToWeeklyReset()
	return GetSecondsUntilWeeklyReset()
end
function E.func_IsOnQuest(id)
	return IsOnQuest(id)
end
function E.func_GetQuestStatus(questID)
	if not questID then return end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтный делается
	-- фиолетовый можно сдать
	if IsFailed(questID) then
		result = E.COLOR_RED..FAILED.."|r"
	elseif IsQuestFlaggedCompleted(questID) then
		result = E.DONE
	elseif IsComplete(questID) then
		result = E.COLOR_PURPLE..">"..QUEST_WATCH_QUEST_READY.."<|r"
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
					local color = finished and E.COLOR_YELLOW or E.COLOR_RED
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
function E.func_IsAchievementCompleted(id)
	if not id then
		return false
	end
	local completed = select(4, GetAchievementInfo(id))
	return completed
end
function E.func_GetAchievementCompletion(id)
	local name, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe, earnedBy = GetAchievementInfo(id)
	if completed then
		return E.DONE
	end
	local numCriteria = GetAchievementNumCriteria(id)
	if numCriteria == 0 then
		return E.COLOR_RED.."0 / 1".."|r"
	end
	if numCriteria == 1 then
		local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(id, 1, false)
		return quantity == 0 and (E.COLOR_RED..quantity.." / "..reqQuantity.."|r") or (quantity.." / "..reqQuantity)
	else
		local count = 0
		for i = 1, numCriteria do
			local _, _, completedCrit = GetAchievementCriteriaInfo(id, i, false)
			if completedCrit then
				count = count + 1
			end
		end
		return count == 0 and (E.COLOR_RED..count.." / "..numCriteria.."|r") or (count.." / "..numCriteria)
	end
end

function E.func_GetAchievementIcon(id)
	return select(10, GetAchievementInfo(id))
end


function E.func_GetRealmShortName(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	if b then
		return utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	end
	return utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
end
E.curServerShort = E.func_GetRealmShortName(GetRealmName())
function E.func_EncodeCoordinates(x, y)
	return math_floor(x * 10000 + 0.5) * 10000 + math_floor(y * 10000 + 0.5)
end
function E.func_FormatCoordinates(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string_format("%.1f / %.1f", x * 100, y * 100)
end
function E.func_ReversSort(a, b)
	return b < a
end


-- function E.func_GetReputationProgress(reputationID)
-- 	local reactionColors = {
-- 		[0] = E.COLOR_WHITE,
-- 		[1] = E.COLOR_RED,
-- 		[2] = E.COLOR_RED,
-- 		[3] = E.COLOR_ORANGE,
-- 		[4] = E.COLOR_YELLOW,
-- 		[5] = E.COLOR_YELLOW,
-- 		[6] = E.COLOR_GREEN,
-- 		[7] = E.COLOR_GREEN,
-- 		[8] = E.COLOR_GREEN,
-- 	}

-- 	local SHOWFULL = false
-- 	local FIRST, SECOND = 0, 0
-- 	-- local result = ""
-- 	local color = E.COLOR_PINK
-- 	local standingTEXT = ""
-- 	local reaction = 0
-- 	local simpleData = GetFactionDataByID(reputationID)
-- 	local isSimple = simpleData ~= nil
-- 	local isParagon = IsFactionParagon(reputationID)
-- 	local friendData = GetFriendshipReputation(reputationID)
-- 	local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
-- 	local isMajor = IsMajorFaction(reputationID)
-- 	local repType = 0

-- 	if isSimple then
-- 		reaction = simpleData.reaction
-- 		standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
-- 		color = reactionColors[reaction] or E.COLOR_PINK
-- 		repType = 5
-- 	end
-- 	if isParagon then
-- 		local currentValue, threshold, _, _, tooLowLevelForParagon = GetFactionParagonInfo(reputationID)
-- 		if threshold then
-- 			local value = currentValue % threshold
-- 			color = E.COLOR_BLUE
-- 			-- result = value.."/"..threshold
-- 			-- if tooLowLevelForParagon then
-- 				-- result = result..E.COLOR_RED.."*|r"
-- 				-- color = E.COLOR_GRAY
-- 			-- end
-- 			FIRST, SECOND = value, threshold
-- 		end
-- 		repType = 4
-- 	elseif isMajor then
-- 		local majorData = GetMajorFactionData(reputationID)
-- 		if majorData then
-- 			local currentValue = majorData.renownReputationEarned % majorData.renownLevelThreshold
-- 			local totalValue = majorData.renownLevelThreshold
-- 			-- result = currentValue.."/"..totalValue..color.."("..majorData.renownLevel..")|r"
-- 			FIRST, SECOND = currentValue, totalValue
-- 		end
-- 		repType = 3
-- 	elseif isFriend then
-- 		local standing = friendData.standing or 0
-- 		local reactionThreshold = friendData.reactionThreshold or 0
-- 		local nextThreshold = friendData.nextThreshold or 0
-- 		local currentValue = standing - reactionThreshold
-- 		local totalValue = nextThreshold - reactionThreshold
-- 		local rankInfo = GetFriendshipReputationRanks(friendData.friendshipFactionID)
-- 		local currentLevel = rankInfo and rankInfo.currentLevel or 0
-- 		local maxLevel = rankInfo and rankInfo.maxLevel or 0
-- 		if currentLevel == maxLevel then
-- 			FIRST, SECOND = currentLevel, maxLevel
-- 			-- result = FIRST.."/"..SECOND
-- 		else
-- 			standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
-- 			FIRST, SECOND = SHOWFULL and standing or currentValue, SHOWFULL and (friendData.maxRep or 0) or totalValue
-- 			-- result = FIRST.."/"..SECOND..standingTEXT
-- 		end
-- 		repType = 2
-- 	elseif isSimple and simpleData.currentStanding then
-- 		local barMin = simpleData.currentReactionThreshold
-- 		local barMax = simpleData.nextReactionThreshold
-- 		local barValue = simpleData.currentStanding
-- 		local currentValue = barValue - barMin
-- 		local totalValue = barMax - barMin
-- 		if currentValue == totalValue then
-- 			FIRST, SECOND = 1, 1
-- 			-- result = standingTEXT
-- 		else
-- 			FIRST, SECOND = SHOWFULL and barMin or currentValue,
-- 			SHOWFULL and (barMin < 0 and 42000 or barMax) or totalValue
-- 			-- result = FIRST.."/"..SECOND
-- 		end
-- 		repType = 1
-- 	end
-- 	if SECOND == 0 then -- NO INFO + где-то может repType записаться
-- 		return false
-- 	end


-- 	-- 1 simple, 2 Friend, 3 major, 4 paragon
-- 	-- return {FIRST, SECOND, repType, standing, maxStanding}
-- 	return FIRST.."#"..SECOND.."#"..repType.."#"..color.."#"..standingTEXT
-- end



function E.func_GetMaxRenownLevel(reputationID)
	local levels = C_MajorFactions.GetRenownLevels(reputationID)
	if levels then
		return levels[#levels].level
	end
end


function E.func_GetReputationProgress(reputationID)
	local SHOWFULL = false
	local FIRST, SECOND = 0, 0
	local result = ""
	local color = E.COLOR_PINK
	local standingTEXT = ""
	local reaction = 0
	local simpleData = GetFactionDataByID(reputationID)
	local isSimple = simpleData ~= nil
	local isParagon = IsFactionParagon(reputationID)
	local friendData = GetFriendshipReputation(reputationID)
	local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
	local isMajor = IsMajorFaction(reputationID)
	local reactionColors = {
		[0] = E.COLOR_WHITE,
		[1] = E.COLOR_RED,
		[2] = E.COLOR_RED,
		[3] = E.COLOR_ORANGE,
		[4] = E.COLOR_YELLOW,
		[5] = E.COLOR_YELLOW,
		[6] = E.COLOR_GREEN,
		[7] = E.COLOR_GREEN,
		[8] = E.COLOR_GREEN,
	}
	if isSimple then
		reaction = simpleData.reaction
		standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
		color = reactionColors[reaction] or E.COLOR_PINK
	end
	if isParagon then
		local currentValue, threshold, _, _, tooLowLevelForParagon = GetFactionParagonInfo(reputationID)
		if threshold then
			local value = currentValue % threshold
			color = E.COLOR_BLUE
			result = value.."/"..threshold
			if tooLowLevelForParagon then
				result = result..E.COLOR_RED.."*|r"
			end
			FIRST, SECOND = value, threshold
		end
	elseif isMajor then
		local majorData = GetMajorFactionData(reputationID)
		if majorData then
			local currentValue = majorData.renownReputationEarned % majorData.renownLevelThreshold
			local totalValue = majorData.renownLevelThreshold
			local maxLevel = E.func_GetMaxRenownLevel(reputationID)
			standingTEXT = "("..majorData.renownLevel.."/"..maxLevel..")|r"
			result = currentValue.."/"..totalValue..color.."("..majorData.renownLevel.."/"..maxLevel..")|r"
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


function E.func_GetQuestLogCount()
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
function E.func_LoadAddOnForced(AddonName)
	if DoesAddOnExist(AddonName) and not E.func_IsAddOnLoaded(AddonName) then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
function E.func_GetCurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
function E.func_ProfessionIcon(skillLine)
	return skillLine and E.func_texturefromIcon(GetTradeSkillTexture(skillLine)) or ""
end
function E.func_StartDebugTimer()
	local timer = debugprofilestart()
	return timer
end
function E.func_StopDebugTimer()
	local timer = E.func_CompactRoundNumber(debugprofilestop())
	local result = E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
function E.func_FormatLastSeen(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string_format(BNET_LAST_ONLINE_TIME, color..E.func_FormatTimeAgo(time).."|r")
	end
end
function E.func_FormatTimeAgo(timeDiff, isAbsolute)
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
function E.func_MergeTables(table1, table2)
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
function E.func_GetTextWithColor(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E.func_RGB2Hex(fontstring:GetTextColor())..text.."|r"
end
function E.func_SetBackdropStyle(frame, hexcolor, BackdropAlpha, edgeAlpha)
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
			icon = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\"..nameForIcon,
			OnClick = function(self, button)
				if button == "LeftButton" then
					if not InCombatLockdown() then
						Octo_profileKeys.isSettingsEnabled = false
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
function E.func_FormatDateTwoDigits(date)
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
function E.func_UpdateButtonState(frame, id, curType)
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
function E.func_CreateSpellButton(id, point, parent, rPoint, x, y, size, curType)
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
			frame.icon:SetTexture(E.func_GetItemIcon(id))
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
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
					E.func_OctoTooltip_OnEnter(frame)
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E.func_GetItemName(id), E.func_SecondsToClock(E.func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E.func_GetSpellName(id), E.func_SecondsToClock(E.func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E.func_GetSpellDescription(id))
					end
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
		end
	end
end
function E.func_RegisterEvents(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or UNKNOWN
	local DebugPath = STR:gsub("]", "")
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event,...)
			if self[event] then
				self[event](self,...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.COLOR_EVENT..event.."|r"..tostring(DebugPath))
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
function E.func_CountVisibleCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local count = 0
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		if CharInfo.PlayerData then
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				count = count + 1
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
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
function E.func_SortCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local sorted = {}
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		if not CharInfo.PlayerData then
		else
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				sorted[#sorted + 1] = CharInfo
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
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
function E.func_FormatResetType(text)
	if not text then return end
	local result = ""
	if text == "Once" then
		result = E.COLOR_YELLOW.."O|r"
	elseif text == "Daily" then
		result = E.COLOR_BLUE.."D|r"
	elseif text == "Weekly" then
		result = E.COLOR_PURPLE.."W|r"
	elseif text == "Month" then
		result = E.COLOR_RED.."M|r"
	end
	return result
end
function E.func_GetFactionIcon(faction)
	if faction == "Horde" then
		return 2565244
	elseif faction == "Alliance" then
		return 2565243
	else
		return 775462
	end
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
	-- TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	return "", nil, nil, nil, nil
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
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	TextLeft = E.func_GetCurrencyName(id)
	-- ColorLeft = E.COLOR_GREEN
	-- IconLeft = E.func_GetCurrencyIcon(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	if id == 824 then
		TooltipKey = "WoD_824"
	end
	if id == 1166 then
		local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon()
		if joinable then
			TextLeft = TextLeft..timewalkDungeonName
		end
	end
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	TextCenter = E.func_TextCenter_Currency(CharInfo, id)
	if id == 1931 and CharInfo.PlayerData.Possible_CatalogedResearch then
		TextCenter = string_format("%s%s +%d|r", TextCenter, E.COLOR_PURPLE, CharInfo.PlayerData.Possible_CatalogedResearch)
	end
	if id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
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
			TextCenter = TextCenter..E.COLOR_BLUE.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	TextLeft = E.func_GetItemName(id)
	-- ColorLeft =
	-- IconLeft = E.func_GetItemIcon(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
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
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
	local reset = data.reset -- questKey:match("_([^_]+)$")
	----------------------------------------------------------------
	-- TextLeft = tostringall(E.func_FormatResetType(data.reset).." "..data.TextLeft)



	local output
	if type(data.TextLeft) == "function" then
		output = data.TextLeft() -- ← Вызываем функцию!
	else
		output = data.TextLeft
	end



	TextLeft = output
	-- ColorLeft =
	-- if reset == "Daily" then
	-- 	IconLeft = E.ICON_DAILY
	-- elseif reset == "Weekly" then
	-- 	IconLeft = E.ICON_WEEKLY
	-- elseif reset == "Once" then
	-- 	IconLeft = E.ICON_ONCE
	-- elseif reset == "Month" then
	-- 	IconLeft = E.ICON_MONTH
	-- end
	SettingsType = dataType.."#"..questKey
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
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
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	TextLeft = E.func_GetReputationName(id)
	-- ColorLeft =
	-- IconLeft = E.func_GetReputationIcon(id)
	SettingsType = dataType.."#"..id
	TooltipKey = "Reputation_"..id
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	----------------------------------------------------------------
end



E.STANDINGSREP = {
	[1] = "SIMPLE",
	[2] = "Friend",
	[3] = "major",
	[4] = "paragon",
}
 -- 1 simple, 2 Friend, 3 major, 4 paragon

function E.func_Otrisovka_Center_Reputations(categoryKey, CharInfo, dataType, id) -- func_Otrisovka_LEFT_Dispatcher
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	if CharInfo.MASLENGO.Reputation and CharInfo.MASLENGO.Reputation[id] and type(CharInfo.MASLENGO.Reputation[id]) == "string" then
		local FIRST, SECOND, repType, colorC, standing = ("#"):split(CharInfo.MASLENGO.Reputation[id])
		FirstReputation = tonumber(FIRST)
		SecondReputation = tonumber(SECOND)
		ColorCenter = colorC
		local isParagonRewardEnableLEFT = ""
		local isParagonRewardEnableRIGHT = ""
		TextCenter = E.func_CompactFormatNumber(FirstReputation).."/"..E.func_CompactFormatNumber(SecondReputation)
		if TextCenter == "1/1" then
			TextCenter = E.DONE
		elseif TextCenter == "0/0" then
			TextCenter = ""
		end
		repType = tonumber(repType)
		-- if repType and repType < 5 and repType ~= 2 then
		-- 	local stText = GetText("FACTION_STANDING_LABEL"..repType, UnitSex("player"))
		-- 	TextCenter = TextCenter .. ColorCenter..E.STANDINGSREP[repType]..stText.." ("..repType..")|r" -- ПОФИКСИТЬ РЕПА
		-- end
		for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
			if id == v.factionID and CharInfo.MASLENGO.ListOfParagonQuests[questID] then
				TextCenter = E.COLOR_PURPLE..">"..TextCenter.."<".."|r"
			end
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	----------------------------------------------------------------
end
function E.func_Otrisovka_LEFT_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, dataType.."#"..id, nil
	----------------------------------------------------------------
	if id == "LegionRemixResearch" then
		TextLeft = L["Infinite Research"]
	elseif id == "ListOfQuests" then
		TextLeft = QUESTS_LABEL
	elseif id == "LFGInstance" then
		TextLeft = DUNGEONS
	elseif id == "AllItems" then
		TextLeft = ITEMS
	elseif id == "Professions" then
		TextLeft = PROFESSIONS_BUTTON
	elseif id == "ItemLevel" then
		TextLeft = STAT_AVERAGE_ITEM_LEVEL
	elseif id == "Money" then
		TextLeft = BONUS_ROLL_REWARD_MONEY
	elseif id == "WasOnline" then
		TextLeft = L["Was online"]
	elseif id == "GreatVault" then
		TextLeft = RATED_PVP_WEEKLY_VAULT
		IconLeft = "greatVault-whole-normal"
	elseif id == "CurrentKey" then
		TextLeft = E.COLOR_WOW_EPIC..L["Mythic Keystone"].."|r"
		IconLeft = 4352494
	end
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	----------------------------------------------------------------
	if id == "GreatVault" then
		if pd.HasAvailableRewards then
			TextCenter = E.COLOR_BLUE..">"..REWARD.."<|r"
		else
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local name = E.name_activities[ID]
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0

				-- Безопасное получение данных из cm.GreatVault
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local vaultMin = vaultData and vaultData.min or 0
				local rewards = vaultData and vaultData.rewards or {}


				-- TextCenter = TextCenter..(rewards[1] or "-")..(rewards[1] or "-")..(rewards[1] or "-")
				if vaultMin ~= 0 then
					TextCenter = TextCenter..("  "..vaultMin.."/"..max)
				end
				-- tooltip[#tooltip+1] = {
				-- 	name,
				-- 	" ",
				-- 	" ",
				-- 	vaultMin.."/"..max,
				-- 	" ",
				-- 	" ",
				-- 	rewards[1] or "-",
				-- 	rewards[2] or "-",
				-- 	rewards[3] or "-"
				-- }
			end







		end
	end
	if id == "CurrentKey" then -- ПОФИКСИТЬ
		if pd.CurrentKey then
			TextCenter = pd.CurrentKey
		end
	end
	if id == "LegionRemixResearch" then
		if cm.LegionRemixData and cm.LegionRemixData.barValue and cm.LegionRemixData.barMax then
			local barValue = cm.LegionRemixData.barValue
			local barMax = cm.LegionRemixData.barMax
			TextCenter = barValue.."/"..barMax
			if cm.LegionRemixData.TotalInfinityResearchQuests then
				TextCenter = barValue..E.COLOR_BLUE.."("..cm.LegionRemixData.TotalInfinityResearchQuests..")|r".."/"..barMax
			end
		end
	end
	if id == "ListOfQuests" then
		if pd.numQuests then
			TextCenter = pd.classColorHex..pd.numQuests.."/"..pd.maxNumQuestsCanAccept.."|r"
		end
	end
	if id == "LFGInstance" then
		local count = 0
		for instanceID, v in next, (cm.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w.output then
						count = count + 1
					end
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if v then
				if cm.LFGInstance[dungeonID].donetoday then
					count = count + 1
				end
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			if v then
				count = count + 1
			end
		end
		if count ~= 0 then
			TextCenter = count
			-- TextCenter = E.COLOR_GRAY..DUNGEONS.."|r"
		end
	end
	if id == "AllItems" then
		local count = 0
		for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
			if cm.ItemsInBag[itemID] then
				count = count + 1
				break
			end
		end
		if count ~= 0 then
			TextCenter = E.COLOR_GRAY..ITEMS.."|r"
		end
	end
	if id == "Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				if i == 1 or i == 2 then
					TextCenter = TextCenter..E.func_ProfessionIcon(charProf[i].skillLine).." "
				end
			end
		end
	end
	if id == "ItemLevel" then
		----------------------------------------------------------------
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			-- TextCenter = color..pd.avgItemLevelEquipped
			TextCenter = E.func_GetColorGradient(pd.avgItemLevelEquipped, E.minValue_ItemLevel, E.maxValue_ItemLevel)..pd.avgItemLevelEquipped
			if pd.avgItemLevel > pd.avgItemLevelEquipped then
				TextCenter = TextCenter.."/"..pd.avgItemLevel.."|r"
			end
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				TextCenter = TextCenter..E.COLOR_GREEN.."+|r"
			end
		end
	end
	----------------------------------------------------------------
	if id == "Money" then
		if pd.Money then
			TextCenter = E.func_GetColorGradient(pd.Money, E.minValue_Money, E.maxValue_Money)..E.func_FormatMoney(pd.Money)
			-- TextCenter = E.func_FormatMoney(pd.Money)
			-- if pd.MoneyOnLogin then
			-- if pd.Money < pd.MoneyOnLogin then
			-- TextCenter = TextCenter..E.COLOR_RED.."-|r"
			-- elseif pd.Money > pd.MoneyOnLogin then
			-- TextCenter = TextCenter..E.COLOR_GREEN.."+|r"
			-- end
			-- end
		end
	end
	if id == "WasOnline" then
		local color = E.COLOR_WHITE
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				TextCenter = E.COLOR_GREEN..FRIENDS_LIST_ONLINE.."|r"
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				TextCenter = color..E.func_FormatTimeAgo(pd.time).."|r"
			end
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_ShouldShow(id, dataType, profileName)
	local shouldShow = false
	if Octo_profileKeys.isSettingsEnabled then
		-- Режим настройки включен - показываем все валюты
		shouldShow = true
	else
		-- Режим настройки выключен - проверяем настройки валют
		local settingsTable = Octo_profileKeys.profiles[profileName][dataType] -- dataType
		if settingsTable then
			-- Проверяем числовой ключ
			if settingsTable[id] then
				shouldShow = true
			end
			-- Проверяем строковый ключ
			if settingsTable[tostring(id)] then
				shouldShow = true
			end
		end
	end
	return shouldShow
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
		result = " +"..result..E.func_texturefromIcon(E.func_GetItemIcon(itemID))
	end
	return result
end
function E.func_TextCenter_Currency(CharInfo, currencyID, itemID)
	local data = CharInfo.MASLENGO.Currency
	if not data[currencyID] then return "" end
	local result = ""
	local color = E.COLOR_WHITE
	if data[currencyID].quantity then
		result = result..E.func_CompactFormatNumber(data[currencyID].quantity)
		if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
			if data[currencyID].quantity == data[currencyID].maxQuantity then
				color = E.COLOR_GREEN
			end
			result = color..result.."/"..E.func_CompactFormatNumber(data[currencyID].maxQuantity).."|r"
		end
	end
	if data[currencyID].totalEarned and data[currencyID].maxQuantity then
		local curQuantity = E.func_CompactFormatNumber(data[currencyID].quantity or 0)
		result = E.func_CompactFormatNumber(data[currencyID].totalEarned)
		result = " ("..result.."/"..E.func_CompactFormatNumber(data[currencyID].maxQuantity)..")"
		result = color..curQuantity..result.."|r"
	end
	if itemID then
		result = result..E.COLOR_GREEN..E.func_TextCenter_Items(CharInfo, itemID, true).."|r"
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
function E.func_RequestUIUpdate(event_name)
	if not E.DebugEvent then return end
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()
	if isMainFrameVisible then
		if not E.updateScheduledFlag then
			E.updateScheduledFlag = true
			C_Timer.After(0.1, function()
					E.updateScheduledFlag = false
					if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
						-- E.func_TODO_CreateDataProvider()
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_GREEN, E.COLOR_YELLOW)..event_name)
					end
			end)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_RED, E.COLOR_PURPLE)..event_name)
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
function E.func_BuildItemTooltip(CharInfo, TBL, needShowAllItems)
	local tooltipCENT = {}
	local sorted_itemList = {}
	local ItemsInBag = CharInfo.MASLENGO.ItemsInBag
	for _, itemID in ipairs(TBL) do
		local count = ItemsInBag[itemID]
		if needShowAllItems or count then
			table_insert(sorted_itemList, {
					itemID = itemID,
					quality = E.func_GetItemQualityLevel(itemID),
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
		local icon = E.func_texturefromIcon(E.func_GetItemIcon(itemID))
		local name = E.func_GetItemName(itemID)
		local price = E.func_GetTSMPrice(itemID, item.count)
		tooltipCENT[#tooltipCENT + 1] = {icon..name, count, price}
	end
	return tooltipCENT
end
function E.func_RegisterFrame(frame)
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


function E.func_FormatExpansion(expID, iconSide)
	local expansion = E.OctoTable_Expansions[expID]
	local expIcon = E.func_texturefromIcon(expansion.icon, 16, 32)
	local expName = expansion.color..expansion.nameVeryShort

	if iconSide == "LEFT" then
		return expIcon..expName.."|r"
	end
	-- По умолчанию RIGHT
	return expName..expIcon.."|r"
end


function E.func_GetTimewalkingDungeon()
	local joinable, timewalkDungeonName, result = false, "", ""
	for expID, v in ipairs(E.OctoTable_Expansions) do
		if v.timewalkDungeonID and IsLFGDungeonJoinable(v.timewalkDungeonID) then
			joinable = true
			result = E.func_FormatExpansion(expID)
			timewalkDungeonName = GetLFGDungeonInfo(v.timewalkDungeonID)
			-- break
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
			local result = (E.Config_DebugID_ALL or Octo_ToDo_DB_Vars["Config_DebugID_"..name]) and (E.COLOR_GRAY.." id:"..id.."|r") or ""
			return result
		end
	end
end
function E.debugInfo(id)
	local result = E.Config_DebugID_ALL and (E.COLOR_GRAY.." id:"..id.."|r") or ""
	return result
end
function E.func_GetPlayerRealm()
	local result = GetRealmName()
	if E.func_IsRemix() then
		result = result.." (Remix)"
	end
	return result
end
-- E.curServer = E.func_GetPlayerRealm()

E.Config_DebugID_ALL = false
E.Config_DebugID_Achievements = false
E.Config_DebugID_Currencies = false
E.Config_DebugID_worldBossID = false
E.Config_DebugID_Quests = false
E.Config_DebugID_Spells = false
E.Config_DebugID_Maps = false
E.Config_DebugID_instanceID = false
E.Config_DebugID_Mounts = false
E.Config_DebugID_NPCs = false
E.Config_DebugID_Items = false
E.Config_DebugID_Reputations = false
E.Config_DebugID_Events = false
E.Config_DebugID_Professions = false

E.UNIVERSAL = "UNIVERSAL_"
E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CentralFrame.tga"
E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""
E.curLocaleLang = GetLocale() or "enUS"
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
E.TEXT_SPACE = " "
E.SPAM_TIME = 3
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
E.edgeFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Borders\\Octo.tga"
E.bgFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Borders\\Octo.tga"
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
E.Octo_font = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Fonts\\Expressway Rg Bold.TTF"
E.GLOBAL_FONT_SIZE = 11
E.OctoFont10 = CreateFont("OctoFont10")
E.OctoFont10:CopyFontObject(GameTooltipText)
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
E.COLOR_BLACK = "|cff000000"
E.COLOR_DARKGRAY = "|cff252525"
E.COLOR_GRAY = "|cff757575"
E.COLOR_LIGHTGRAY = "|cff909090"
E.COLOR_WHITE = "|cffFFFFFF"
E.COLOR_ADDON_LEFT = "|cffD177FF"
E.COLOR_ADDON_RIGHT = "|cff63A4E0"
E.COLOR_RED = "|cffFF4C4F"
E.COLOR_ORANGE = "|cffFF661A"
E.COLOR_DARKORANGE = "|cffFF8C00"
E.COLOR_GOLD = "|cffFFD600"
E.COLOR_YELLOW = "|cffFFF371"
E.COLOR_LIME = "|cffACFF2F"
E.COLOR_GREEN = "|cff4FFF79"
E.COLOR_CYAN = "|cff00FFFF"
E.COLOR_BLUE = "|cff00A3FF"
E.COLOR_PURPLE = "|cffAF61FF"
E.COLOR_INDIGO = "|cff4B0082"
E.COLOR_MAGENTA = "|cffFF00FF"
E.COLOR_PINK = "|cffFF69B3"
E.COLOR_SKYBLUE = "|cff87CDEB"
E.COLOR_STEELBLUE = "|cff4682B3"
E.COLOR_SLATEGRAY = "|cff708090"
E.COLOR_BROWN = "|cff964B00"
E.COLOR_HOLIDAY = "|cffFF8C00"
E.COLOR_EVENT = "|cffFFF371"
E.COLOR_DEBUG = E.classColorHexCurrent
E.COLOR_FUNCTION = "|cff87CDEB"
E.FACTION_CURRENT = UnitFactionGroup("PLAYER")
E.FACTION_OPPOSITE = E.FACTION_CURRENT == "Alliance" and "Horde" or "Alliance"
E.ICON_TABARD = 135026
E.ICON_ALLIANCE = 255140
E.ICON_HORDE = 255142
E.ICON_KYRIAN = 3641395
E.ICON_NECROLORD = 3752259 -- 3641396
E.ICON_NIGHTFAE = 3752258 -- 3641394
E.ICON_VENTHYR = 3257751 -- 3641397
E.ICON_WORLDBOSS = 3528312
E.ICON_RARES = 135903
E.ICON_MONEY = 133784
E.COLOR_HORDE = "|cffC41E3A"
E.COLOR_ALLIANCE = "|cff0070DD"
E.COLOR_NEUTRAL = E.Class_Monk_Color
if E.FACTION_CURRENT == "Horde" then
	E.ICON_FACTION = 2565244
	E.COLOR_FACTION = E.COLOR_HORDE
elseif E.FACTION_CURRENT == "Alliance" then
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
E.RIFT = E.COLOR_PURPLE.." (RIFT)|r"
E.DONE = E.COLOR_GREEN..DONE.."|r"
E.NONE = E.COLOR_GRAY..NONE.."|r"
E.TRUE = E.COLOR_GREEN.."true|r"
E.FALSE = E.COLOR_RED.."false|r"
E.NIL = E.COLOR_RED.."nil|r"
E.ATLAS_ACCOUNT_WIDE = "warbands-icon"-- CreateAtlasMarkup("warbands-icon", 16, 16)
E.ATLAS_ACCOUNT_TRANSFERABLE = "warbands-transferable-icon"-- CreateAtlasMarkup("warbands-transferable-icon", 16, 16)
E.ICON_WARBANDS = E.COLOR_BLUE.."(A)".."|r"
E.ICON_QUESTION_MARK = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.ICON_EMPTY = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\ICON_EMPTY"
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
E.DEBUG_TEXT = E.COLOR_BLUE..BINDING_HEADER_DEBUG.."|r"
E.DEVTEXT = "|T"..E.IconTexture..":14:14:::64:64:4:60:4:60|t"..E.COLOR_GREEN.."DebugInfo|r: "
function E.func_FormatMountInfo(mountID)
	local mountIconNumber = E.func_GetMountTexture(mountID)
	local mountIcon = E.func_texturefromIcon(mountIconNumber)
	local mountName = mountIcon..E.func_GetMountCollectedColor(mountID)..E.func_GetMountName(mountID).."|r"
	return mountName
end
function E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
	local pd = CharInfo.PlayerData
	local isVisible = visiblePlayers[GUID]
	local colorPlayer = isVisible and pd.classColorHex or E.COLOR_GRAY
	local colorServer = isVisible and "|cffFFFFFF" or E.COLOR_GRAY
	local curPers = pd.GUID == E.curGUID and E.COLOR_GREEN.."*|r" or ""
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				for covenant = 1, 4 do
					local value = values[covenant]
					if value > 0 then
						local c = covenant == curCovID
						and E.OctoTable_Covenant[covenant].color
						or E.COLOR_GRAY
						row[covenant + 1] = c..E.func_CompactFormatNumber(value).."|r"
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
						totalAnimaText = E.func_CompactFormatNumber(charTotal)
					else
						totalAnimaText = "-"
					end
					if pd.Possible_Anima and pd.Possible_Anima > 0 then
						Possible_Anima = E.COLOR_BLUE.." +"..E.func_CompactFormatNumber(pd.Possible_Anima).."|r"
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
	if #characterData > 0 then
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
				local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
				d.row[6] = d.Possible_Anima
				d.row[7] = color..d.totalAnimaText.."|r"
			end
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData > 1 then
			local header = {
				"",
				E.func_texturefromIcon(E.ICON_KYRIAN),
				E.func_texturefromIcon(E.ICON_VENTHYR),
				E.func_texturefromIcon(E.ICON_NIGHTFAE),
				E.func_texturefromIcon(E.ICON_NECROLORD),
				""
			}
			if not isRenown then
				header[#header+1] = TOTAL..": "..E.func_CompactFormatNumber(grandTotal)
			end
			table.insert(tooltip, 1, header)
		end
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = ""
				local row3Text = ""
				if pd.avgItemLevelEquipped and pd.avgItemLevel then
					row2Text = pd.avgItemLevelEquipped
					if pd.avgItemLevel > pd.avgItemLevelEquipped then
						row3Text = " +"..pd.avgItemLevel-pd.avgItemLevelEquipped
					end
					if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
						row2Text = row2Text..E.COLOR_BLUE.."+|r"
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
	if #characterData > 0 then
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
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
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
				"avg"..": "..E.func_CompactFormatNumber(avgILVL/#characterData),
				"",
			}
			table.insert(tooltip, 1, header)
		end
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local prof = {}
				for i = 1, 2 do
					prof[i] = prof[i] or {}
					prof[i].Icon = ""
					prof[i].Text = ""
					if cmP[i] and cmP[i].skillLevel and cmP[i].maxSkillLevel then
						prof[i].Icon = E.func_ProfessionIcon(cmP[i].skillLine)
						prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel).."/"..E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
						if cmP[i].skillModifier then
							prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel)..E.COLOR_GREEN.."+"..E.func_CompactFormatNumber(cmP[i].skillModifier).."|r".."/"..E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
						end
					end
				end
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = cmP[1].skillLine,
						sortValue2 = cmP[1].skillLevel,
						prof1Icon = prof[1].Icon,
						prof1Text = prof[1].Text,
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
		-- local color = E.func_GetColorGradient(d.charValue, minValue, maxValue)
		-- d.row[2] = ""
		d.row[2] = {d.prof1Text..d.prof1Icon, "RIGHT"}
		-- d.row[4] = ""
		-- d.row[5] = ""
		d.row[3] = {d.prof2Text..d.prof2Icon, "RIGHT"}
		-- d.row[4] = ""
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	-- if #characterData > 1 then
	-- local header = {
	-- "1",
	-- "2",
	-- "3",
	-- "4",
	-- "5",
	-- "6",
	-- "7",
	-- }
	-- table.insert(tooltip, 1, header)
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = E.func_CompactFormatNumber(curquantity)
				if curmaxQuantity > 0 then
					row2Text = row2Text.."/"..E.func_CompactFormatNumber(curmaxQuantity)
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
	if #characterData > 0 then
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
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = color..d.row2Text.."|r"
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData > 1 then
			local header = {
				"",
				TOTAL..": "..E.func_CompactFormatNumber(total),
			}
			table.insert(tooltip, 1, header)
		end
		--------------------------------------------------------
	end
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = E.func_FormatMoney(curMoney)
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
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
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
				E.func_GetItemName(122284)..": "..E.func_FormatMoney(C_WowTokenPublic.GetCurrentMarketPrice())
			}
			table.insert(tooltip, 1, header1)
		end
		if C_Bank.FetchDepositedMoney(Enum.BankType.Account) then
			local heade2 = {
				"",
				ACCOUNT_BANK_PANEL_TITLE..": "..E.func_FormatMoney(C_Bank.FetchDepositedMoney(Enum.BankType.Account)),
			}
			table.insert(tooltip, 2, heade2)
		end
		local heade3 = {
			"",
			TOTAL..": "..E.func_FormatMoney(total),
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
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
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
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			TOTAL..": "..E.func_SecondsToClock(total),
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end


function E.func_CurrentKeyTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local CurrentKeyName = pd.CurrentKeyName or ""
			local CurrentKeyLevel = pd.CurrentKeyLevel or 0
			local RIO_weeklyBest = pd.RIO_weeklyBest or E.COLOR_GRAY.."-|r"
			local RIO_Score = pd.RIO_Score or 0
			local keyABBR = pd.CurrentKey or ""
			-- Фильтр пустоты
			local hasData = (RIO_Score > 0) or (CurrentKeyLevel > 0)
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = keyABBR -- ..E.COLOR_ORANGE..CurrentKeyLevel.."|r "..E.COLOR_PURPLE..CurrentKeyName.."|r"
				local row3Text = RIO_weeklyBest
				local row4Text = RIO_Score
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = RIO_Score,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
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
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = {d.row2Text, "LEFT"}
		d.row[3] = d.row3Text
		d.row[4] = color..d.row4Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			"",
			"Weekly Best",
			"RIO",
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end


function E.func_GreatVaultTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	local ids_tbl = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO

			local HasAvailableRewards = pd.HasAvailableRewards and 1 or 0
			local RIO_Score = pd.RIO_Score or 0

			local reward1 = E.COLOR_GRAY.."-|r"
			local reward2 = E.COLOR_GRAY.."-|r"
			local reward3 = E.COLOR_GRAY.."-|r"
			local maxQWE = 0
			-- Фильтр пустоты
			local hasData = (HasAvailableRewards > 0)

			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				table_insert(ids_tbl, ID)
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local rewards = vaultData and vaultData.rewards or {}
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				local vaultMin = vaultData and vaultData.min or 0
				if rewards[1] then
					hasData = true
					reward1 = E.COLOR_GREEN..rewards[1].."|r"
				end
				if rewards[2] then
					hasData = true
					reward2 = E.COLOR_GREEN..rewards[2].."|r"
				end
				if rewards[3] then
					hasData = true
					reward3 = E.COLOR_GREEN..rewards[3].."|r"
				end
			end
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = HasAvailableRewards > 0 and E.COLOR_BLUE..">"..REWARD.."<|r" or ""
				local row3Text = reward1
				local row4Text = reward2
				local row5Text = reward3
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = HasAvailableRewards,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
						row5Text = row5Text,
						ids_tbl = ids_tbl,
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
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = d.row2Text
		d.row[3] = d.row3Text
		d.row[4] = d.row4Text
		d.row[5] = d.row5Text
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			"",
			E.name_activities[ids_tbl[1]],
			E.name_activities[ids_tbl[2]],
			E.name_activities[ids_tbl[3]],
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
	local sortedPlayersTBL = E.func_SortCharacters()
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
	elseif SettingsType == "Additionally#CurrentKey" then
		tooltip = E.func_CurrentKeyTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#GreatVault" then
		tooltip = E.func_GreatVaultTooltipLeft(visiblePlayers)
	end

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		-- if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
		local specIcon, color, Name
		local RIGHT1 = ""
		local RIGHT2 = ""
		local curServer, curPers = "", ""
		specIcon = E.func_texturefromIcon(CharInfo.PlayerData.specIcon)
		local colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.COLOR_GRAY
		local colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.COLOR_GRAY
		Name = CharInfo.PlayerData.Name
		if CharInfo.PlayerData.GUID == E.curGUID then
			curPers = E.COLOR_GREEN.."*|r"
		end
		if CharInfo.PlayerData.curServer ~= E.func_GetPlayerRealm() then
			curServer = "-"..CharInfo.PlayerData.curServer
		end
		-- if dataType == "Currencies" and id == 1822 then
		-- local typeSL = 1 -- Renown
		-- local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
		-- if curCovID then
		-- local totalRenownPerChar = 0
		-- local currentCovenantColor = E.OctoTable_Covenant[curCovID].color
		-- for covenant = 1, 4 do
		-- local covenantColor = E.OctoTable_Covenant[covenant].color
		-- if CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL] then
		-- total = total + CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL]
		-- RIGHT1 = RIGHT1..covenantColor..CharInfo.MASLENGO.CovenantAndAnima[covenant][typeSL].."|r "
		-- end
		-- end
		-- end
		-- end
		if dataType == "Items" and CharInfo.MASLENGO.ItemsInBag[id] then
			total = total + CharInfo.MASLENGO.ItemsInBag[id]
			RIGHT1 = CharInfo.MASLENGO.ItemsInBag[id]
			RIGHTforSORT = CharInfo.MASLENGO.ItemsInBag[id]
		end
		if RIGHT1 ~= "" then
			specIcon = E.func_texturefromIcon(CharInfo.PlayerData.specIcon)
			local colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.COLOR_GRAY
			local colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.COLOR_GRAY
			Name = CharInfo.PlayerData.Name
			if CharInfo.PlayerData.GUID == E.curGUID then
				curPers = E.COLOR_GREEN.."*|r"
			end
			if CharInfo.PlayerData.curServer ~= E.func_GetPlayerRealm() then
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
			tooltip[#tooltip+1] = {"", CLUB_FINDER_MEDIUM..": "..E.func_CompactFormatNumber(total/#sorted)}
		elseif dataType == "Currencies" then
			-- tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetCurrencyIcon(id))..E.func_GetCurrencyName(id), TOTAL..": "..E.func_CompactFormatNumber(total)}
			tooltip[#tooltip+1] = {"", TOTAL..": "..E.func_CompactFormatNumber(total)}
		elseif dataType == "Items" then
			-- tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIcon(id))..E.func_GetItemName(id), TOTAL..": "..E.func_CompactFormatNumber(total)}
			tooltip[#tooltip+1] = {"", TOTAL..": "..E.func_CompactFormatNumber(total)}
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
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO

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
			local curCovID = cm.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = cm.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.COLOR_GRAY
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
	end
	if dataType == "Currencies" and id == 1813 then
		local typeSL = 2 -- Anima
		for covenant = 1, 4 do
			local curCovID = cm.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = cm.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.COLOR_GRAY
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			if pd.Possible_Anima and curCovID == covenant then
				centText = centText..E.COLOR_BLUE.."+"..pd.Possible_Anima.."|r"
			end
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
		E.func_AddTooltipSeparator(tooltip)
	end
	if dataType == "Currencies" and id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600 -- 10 minutes in seconds
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, math_floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
			local timeUntilFull = (lastCacheTime + secondsToMax) - GetServerTime()
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
			end
			tooltip[#tooltip+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
			tooltip[#tooltip+1] = {" ", " "} -- Empty separator
			if earnedSinceLastCollect ~= cacheSize then
				tooltip[#tooltip+1] = {"Time to full: ", E.func_SecondsToClock(timeUntilFull)}
			end
			tooltip[#tooltip+1] = {"Was earned: ", E.func_SecondsToClock(GetServerTime()-(cm.GARRISON.lastCacheTime or time()))}
		end
	end
	----------------------------------------------------------------
	if dataType == "Currencies" and id == 1166 then -- ТАЙМВОЛК КАРРЕНСИ ТУЛТИП
		local icon = E.func_texturefromIcon(E.func_GetCurrencyIcon(1166))
		for i, v in ipairs(E.func_Mounts_1166()) do
			local mountID = v.mountID
			local source = v.source
			local price = v.price
			tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), {source, "LEFT"}, E.func_CompactFormatNumber(price)..icon}
		end
	end
	-- if dataType == "Currencies" and id == 3252 then
	-- for i, v in ipairs(E.func_Mounts_3252()) do
	-- local mountID = v.mountID
	-- local source = v.source
	-- tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), E.func_texturefromIcon(E.func_GetCurrencyIcon(id))..v.price, source}
	-- end
	-- end
	if id == "GreatVault" then

			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local rewards = vaultData and vaultData.rewards or {}
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				local vaultMin = vaultData and vaultData.min or 0

				tooltip[#tooltip+1] = {
					E.name_activities[ID] or "?",
					" ",
					" ",
					(vaultMin >= max and E.COLOR_GREEN or vaultMin > 0 and E.COLOR_YELLOW or E.COLOR_GRAY)..vaultMin.."/"..max.."|r",
					" ",
					" ",
					rewards[1] and E.COLOR_GREEN..rewards[1].."|r" or E.COLOR_GRAY.."-|r",
					rewards[2] and E.COLOR_GREEN..rewards[2].."|r" or E.COLOR_GRAY.."-|r",
					rewards[3] and E.COLOR_GREEN..rewards[3].."|r" or E.COLOR_GRAY.."-|r"
				}
			end


	end
	if id == "CurrentKey" then
		if pd.CurrentKeyName then
			tooltip[#tooltip+1] = {E.COLOR_ORANGE..pd.CurrentKeyLevel.."|r "..E.COLOR_PURPLE..pd.CurrentKeyName.."|r", ""}
		end
		if pd.RIO_Score and pd.RIO_weeklyBest then
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Weekly Best:", pd.RIO_weeklyBest or 0}
			tooltip[#tooltip+1] = {"RIO Score:", pd.RIO_Score or 0}
		end
	end
	if id == "LegionRemixResearch" then
		for questID in next,(E.OctoTable_RemixInfinityResearch) do
			if cm.ListOfQuests[questID] then
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	if dataType == "Currencies" then
		for currencyID, dataTBL in pairs(E.OctoTable_ALL_Mounts) do
			if id == tonumber(currencyID) and id ~= 1166 then -- ТАЙМВОЛК КАРРЕНСИ ТУЛТИП
				-- Создаем таблицу для сортировки
				local mounts = {}
				for mountID, price in pairs(dataTBL) do
					local mountIconNumber = E.func_GetMountTexture(mountID)
					local mountIcon = E.func_texturefromIcon(mountIconNumber)
					local mountName = E.func_GetMountName(mountID)
					local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
					local color = isCollected and E.COLOR_WHITE or E.COLOR_RED
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
						E.func_CompactFormatNumber(mount.price)..
						E.func_texturefromIcon(E.func_GetCurrencyIcon(currencyID))
					}
				end
			end
		end
	end
	if SettingsType == "BfA_mechagonItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_MECHAGON, true)
	end
	----------------------------------------------------------------
	if dataType == "Reputations" then
		if cm.Reputation[id] and type(cm.Reputation[id]) == "string" then
			local FIRST, SECOND, output, ColorCenter, standing = ("#"):split(cm.Reputation[id])
			local icon1texture = E.func_texturefromIcon(E.ICON_TABARD)
			local icon2texture = E.func_GetReputationIcon(id) and E.func_texturefromIcon(E.func_GetReputationIcon(id)) or ""
			local firstTEXT = icon1texture..icon2texture..E.func_GetReputationName(id)
			local secondTEXT = FIRST.."/"..SECOND
			if secondTEXT == "1/1" then
				secondTEXT = E.DONE
			end
			local thirdTEXT = ColorCenter..standing.."|r"
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and cm.ListOfParagonQuests[questID] then
					isParagonRewardEnable = E.COLOR_PURPLE..">>"..CONTRIBUTION_REWARD_TOOLTIP_TITLE.."<<|r"
				end
			end
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and cm.ListOfParagonQuests[questID] then
					secondTEXT = E.COLOR_PURPLE..">"..FIRST.."/"..SECOND.."<".."|r"
				end
			end
			if secondTEXT ~= "0/0" then
				tooltip[#tooltip+1] = {firstTEXT}
				tooltip[#tooltip+1] = {secondTEXT, thirdTEXT}
			end
			-- else
			-- opde(cm.Reputation[id])
		end
	end
	if SettingsType == "Additionally#AllItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_ALL, false)
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				local leftText = E.func_ProfessionIcon(charProf[i].skillLine).." "..E.func_GetProfessionName(charProf[i].skillLine)
				local rightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
				if charProf[i].skillModifier then
					rightText = charProf[i].skillLevel..E.COLOR_GREEN.."+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
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
							tooltip[#tooltip+1] = {E.func_FormatExpansion(expIndex), v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
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
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, pd.avgItemLevelPvp)}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#Money" then
		if pd.Money then
			local function addMoneyDiff(label, oldValue)
				if not oldValue then return end
				local diff = pd.Money - oldValue
				if diff == 0 then return end
				local sign = diff > 0 and "+" or "-"
				local color = diff > 0 and E.COLOR_GREEN or E.COLOR_RED
				local result = sign..E.func_FormatMoney(math.abs(diff))
				tooltip[#tooltip + 1] = {label, color..result.."|r"}
			end
			addMoneyDiff("SESSION", pd.MoneyOnLogin)
			addMoneyDiff("DAILY", pd.MoneyOnDaily)
			addMoneyDiff("WEEKLY", pd.MoneyOnWeekly)
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#WasOnline" then
		local color = "|cffFFFFFF"
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				-- tooltip[#tooltip+1] = {"Время после релоуда: "..pd.classColorHex..E.func_SecondsToClock(GetServerTime() - pd.time).."|r", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, pd.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r" ), " "}
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				tooltip[#tooltip+1] = {color..E.func_FormatLastSeen(pd.time, pd.classColorHex).."|r", ""}
				tooltip[#tooltip+1] = {"", ""}
				tooltip[#tooltip+1] = {color..pd.loginDay.."|r", ""}
				tooltip[#tooltip+1] = {color..pd.loginHour.."|r", ""}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#ListOfQuests" then
		if pd.numQuests then
			local questIDs = {}
			for questID in next, cm.ListOfQuests do
				questIDs[#questIDs+1] = questID
			end
			table_sort(questIDs, E.func_ReversSort)
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[i] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#LFGInstance" then
		local combinedTooltip = {}
		for instanceID, v in next, (cm.journalInstance) do
			for difficultyID, w in next, (v) do
				if w.output then
					table_insert(combinedTooltip, {
							name = w.instanceName.."("..w.difficultyName..") "..E.debugInfo(instanceID),
							status = w.output,
							time = E.func_SecondsToClock(w.instanceReset-GetServerTime())
					})
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if cm.LFGInstance[dungeonID].donetoday then
				table_insert(combinedTooltip, {
						name = cm.LFGInstance[dungeonID].D_name..E.debugInfo(dungeonID),
						status = " ",
						time = cm.LFGInstance[dungeonID].donetoday
				})
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			table_insert(combinedTooltip, {
					-- name = E.func_texturefromIcon(E.ICON_WORLDBOSS)..v.name..E.debugInfo(worldBossID),
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
		-- TextCenter = E.COLOR_GRAY..DUNGEONS.."|r"
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
					if not faction or faction == pd.Faction then
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
				if totalQuest >= 1 then
					local output
					if type(data.TextLeft) == "function" then
						output = data.TextLeft() -- ← Вызываем функцию!
					else
						output = data.TextLeft
					end

					local TextLeft = tostringall(E.func_FormatResetType(data.reset).." "..output)
					tooltip[#tooltip+1] = {" ", TOTAL..": "..totalQuest}
					-- tooltip[#tooltip+1] = {" "}
				end
				-- Список квестов в тултипе
				local questsToShow = {}
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == pd.Faction then
						table_insert(questsToShow, questData)
					end
				end
				if data.sorted ~= false then
					table_sort(questsToShow, function(a, b)
							local function getName(entry)
								if entry.forcedText then
									if entry.forcedText.npcID then
										return E.func_GetNPCName(entry.forcedText.npcID) or ""
									elseif entry.forcedText.text then
										return entry.forcedText.text or ""
									end
								end
								return E.func_GetQuestName(entry[1]) or ""
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
					local Output_LEFT = ""
					local Output_CENT = ""
					local Output_RIGHT = ""
					if questID then
						Output_RIGHT = cm.UniversalQuest and cm.UniversalQuest[questKey] and cm.UniversalQuest[questKey][questID] or E.COLOR_GRAY..NONE.."|r"
					end
					if forcedText then
						-- Добавляем текст
						if forcedText.text then
							Output_LEFT = Output_LEFT..forcedText.text.." "
						end
						-- Добавляем имя NPC
						if forcedText.npcID then
							Output_LEFT = Output_LEFT..E.func_GetNPCName(forcedText.npcID).." "
						end
						-- Добавляем название достижения
						if forcedText.achievementID then
							Output_LEFT = Output_LEFT..E.func_GetAchievementName(forcedText.achievementID).." "
						end
						-- Добавляем название предмета
						if forcedText.itemID then
							Output_LEFT = Output_LEFT..E.func_GetItemName(forcedText.itemID).." "
						end
						if forcedText.Icon then
							Output_LEFT = E.func_texturefromIcon(forcedText.Icon)..Output_LEFT
						end
						-- Удаляем лишний пробел в конце
						Output_LEFT = Output_LEFT:match("^(.-)%s*$")
					else
						if questID then
							Output_LEFT = Output_LEFT..E.func_GetQuestName(questID)
						end
					end
					if addText then
						-- Добавляем иконку Vignette
						if addText.IconVignette then
							Output_LEFT = E.func_texturefromIcon(addText.IconVignette, nil, nil, true)..Output_LEFT
						end
						if addText.Icon then
							Output_LEFT = E.func_texturefromIcon(addText.Icon)..Output_LEFT
						end
						if addText.mount then
							-- local mountIconNumber = E.func_GetMountTexture(addText.mount)
							-- local mountIcon = E.func_texturefromIcon(mountIconNumber)
							-- local mountName = mountIcon..E.func_GetMountCollectedColor(addText.mount)..E.func_GetMountName(addText.mount).."|r"
							Output_CENT = Output_CENT..E.COLOR_PURPLE.." +"..string_format(RENOWN_REWARD_MOUNT_NAME_FORMAT, E.func_FormatMountInfo(addText.mount)).."|r"
						end
						if addText.expansionText then
							Output_CENT = Output_CENT..addText.expansionText
						end
						if addText.notes then
							Output_LEFT = Output_LEFT..addText.notes
						end
						if addText.mapID then
							Output_LEFT = Output_LEFT..E.COLOR_GRAY.." ("..E.func_GetMapName(addText.mapID)..")|r"
						end
						if addText.spellID then
							Output_LEFT = Output_LEFT..E.COLOR_PINK..E.func_GetSpellName(addText.spellID).."|r"
						end
						if addText.text then
							Output_LEFT = Output_LEFT..addText.text
						end
					end
					if faction == pd.Faction then
						Output_LEFT = E.func_texturefromIcon(E.func_GetFactionIcon(faction))..Output_LEFT
					end
					-- tooltip[#tooltip+1] = {Output_LEFT, Output_CENT, Output_RIGHT}
					if Output_CENT ~= "" then
						tooltip[#tooltip+1] = {Output_LEFT, {Output_CENT, "LEFT"}, Output_RIGHT}
					else
						tooltip[#tooltip+1] = {Output_LEFT, Output_RIGHT}
						-- tooltip[#tooltip+1] = {Output_LEFT, Output_CENT ~= "" and {Output_CENT, "LEFT"} or nil, Output_RIGHT}
					end

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
	local MailPart = ""
	if CharInfo.PlayerData.UnitLevel and CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerData.PlayerCanEarnExperience then
		levelPart = " "..E.COLOR_YELLOW..CharInfo.PlayerData.UnitLevel.."|r"
	end
	if CharInfo.PlayerData.hasMail then
		MailPart = E.func_texturefromIcon("UI-HUD-Minimap-Mail-Up", 16, 10, true)
	end
	return namePart..levelPart..MailPart
end
function E.func_TextCenter_Chars_server(CharInfo)
	local serverPart = ""
	if not Octo_ToDo_DB_Vars.isOnlyCurrentServer and E.curServerShort ~= CharInfo.PlayerData.curServer then
		serverPart = E.COLOR_SKYBLUE..CharInfo.PlayerData.curServer.."|r"
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
			tooltip_Chars[#tooltip_Chars+1] = {"<"..E.COLOR_GREEN..CharInfo.PlayerData.guildName.."|r"..">".." ["..E.COLOR_GREEN..CharInfo.PlayerData.guildRankName.."|r".."]"}
		end
		-- War mode status
		if CharInfo.PlayerData.WarMode then
			tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.WarMode and E.COLOR_GREEN..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""}
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
		-- tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon("ChromieMap", nil, nil, true)..L["Chromie"]..": "..E.COLOR_GREEN..CharInfo.PlayerData.Chromie_name.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {E.func_texturefromIcon("ChromieMap", nil, nil, true)..E.func_GetNPCName(167032)..": "..E.COLOR_GREEN..CharInfo.PlayerData.Chromie_name.."|r"}
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
		tooltip_Chars[#tooltip_Chars+1] = {E.func_GetItemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
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
		tooltip_Chars[#tooltip_Chars+1] = {E.COLOR_PURPLE.."GUID".."|r", E.COLOR_PURPLE..CharInfo.PlayerData.GUID.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"hasMail", CharInfo.PlayerData.hasMail and E.func_texturefromIcon(E.Icon_MailBox)..CharInfo.PlayerData.classColorHex.."true|r"}
		-- Chromie time debug info
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_canEnter", CharInfo.PlayerData.Chromie_canEnter and E.TRUE}
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_UnitChromieTimeID", CharInfo.PlayerData.Chromie_UnitChromieTimeID}
		-- if CharInfo.PlayerData.Chromie_name then
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_name", CharInfo.PlayerData.Chromie_name}
		-- end
		-- BattleTag info
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTag", E.COLOR_BLUE..CharInfo.PlayerData.BattleTag.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTagLocal", E.COLOR_BLUE..CharInfo.PlayerData.BattleTagLocal.."|r"}
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
		-- CharDBVersion
		tooltip_Chars[#tooltip_Chars+1] = {"CharDBVersion", CharInfo.PlayerData.CharDBVersion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegion", CharInfo.PlayerData.CurrentRegion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegionName", CharInfo.PlayerData.CurrentRegionName}
	end
	return tooltip_Chars
end
----------------------------------------------------------------
function E.func_AddonNameForOptionsFunc(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title").." "..E.COLOR_GRAY..E.func_GetAddOnMetadata(addonName, "Version").."|r"
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
		local targetAlpha = Octo_ToDo_DB_Vars.Config_AlphaOnTheMove
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
function E.func_AddTooltipSeparator(tooltip)
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
-- function E.func_GetColorGradient(value, minValue, maxValue)
-- -- текущее, мин, макс
-- if not value or not minValue or not maxValue or minValue >= maxValue then
-- return "|cff00ff00"
-- end
-- local p = (value - minValue) / (maxValue - minValue)
-- if p < 0 then p = 0 end
-- if p > 1 then p = 1 end
-- local r, g
-- if p < 0.5 then
-- r = 255
-- g = math.floor(p * 2 * 255)
-- else
-- g = 255
-- r = math.floor((1 - (p - 0.5) * 2) * 255)
-- end
-- return string.format("|cff%02x%02x00", r, g)
-- end
----------------------------------------------------------------
function E.func_GetColorGradient(value, minValue, maxValue, minHex, midHex, maxHex)
	local UseOnlyTwoColor = false -- (min and max)

	-- дефолты на случай кривых рук
	minHex = minHex or E.COLOR_RED
	midHex = midHex or E.COLOR_YELLOW
	maxHex = maxHex or E.COLOR_GREEN

	if not value or not minValue or not maxValue or minValue >= maxValue then
		return maxHex
	end

	local p = (value - minValue) / (maxValue - minValue)
	if p < 0 then p = 0 end
	if p > 1 then p = 1 end

	local r1, g1, b1
	local r2, g2, b2
	local t

	if UseOnlyTwoColor then
		-- Используем только начальный и конечный цвета
		r1, g1, b1 = E.func_Hex2RGB(minHex)
		r2, g2, b2 = E.func_Hex2RGB(maxHex)
		t = p -- используем полный диапазон от 0 до 1
	else
		-- Оригинальная логика с тремя цветами
		if p < 0.5 then
			r1, g1, b1 = E.func_Hex2RGB(minHex)
			r2, g2, b2 = E.func_Hex2RGB(midHex)
			t = p * 2
		else
			r1, g1, b1 = E.func_Hex2RGB(midHex)
			r2, g2, b2 = E.func_Hex2RGB(maxHex)
			t = (p - 0.5) * 2
		end
	end

	local r = math.floor(Lerp(r1, r2, t))
	local g = math.floor(Lerp(g1, g2, t))
	local b = math.floor(Lerp(b1, b2, t))

	return string.format("|cff%02x%02x%02x", r, g, b)
end
----------------------------------------------------------------
function E.func_CleanTable(tbl)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			prune(v)
			if not next(v) then tbl[k] = nil end
		elseif v == 0 or v == "" then
			tbl[k] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_RemoveEmptyValues(t)
	for k, v in pairs(t) do
		if type(v) == "table" then
			Cleanup(v)
			if next(v) == nil then
				t[k] = nil
			end
		elseif v == 0 or v == "" then
			t[k] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_CleanDeepTable(t, rules)
	if type(t) ~= "table" then return false end
	for k, v in pairs(t) do
		local remove = false
		if type(v) == "table" then
			local empty = E.func_CleanDeepTable(v, rules)
			if empty then
				remove = true
			end
		else
			if rules.zero and v == 0 then remove = true end
			if rules.emptyString and v == "" then remove = true end
			if rules.falseValue and v == false then remove = true end
			if rules.values then
				for _, bad in ipairs(rules.values) do
					if v == bad then
						remove = true
						break
					end
				end
			end
			if rules.strings and type(v) == "string" then
				for _, pattern in ipairs(rules.strings) do
					if v:find(pattern) then
						remove = true
						break
					end
				end
			end
		end
		if remove then
			t[k] = nil
		end
	end
	return next(t) == nil
end
----------------------------------------------------------------
function E.func_RunAfterCombat()
	for key in next,(E._inCombats) do
		if type(callback) == "function" then
			callback()
			E._inCombats[key] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_SpamBlock(...)
	local key = (""):join(tostringall(...))
	local func, needCheckCombat, id = ...
	if type(func) ~= "function" then return end
	local SPAM_TIME = E.SPAM_TIME
	if (needCheckCombat == nil or needCheckCombat == true) and InCombatLockdown() then
		E._inCombats[key] = true
		return true -- заблочена и добавлена в выполнение после сброса комбата
	end
	local currentTime = GetTime()
	-- когда было последнее выполнение
	if E._spamLocks[key] then
		local timeSinceLast = currentTime - E._spamLocks[key]
		local timeToEnd = SPAM_TIME-timeSinceLast
		if timeSinceLast < SPAM_TIME then
			if not E._callAfterTimer[key] then
				E._callAfterTimer[key] = true;
				C_Timer.After(timeToEnd, function()
						E._callAfterTimer[key] = nil
						E.func_SpamBlock(func, needCheckCombat)
				end)
			end
			return true -- заблочена
		end
	end
	E._spamLocks[key] = currentTime -- Обновляем время последнего выполнения
	func() -- Выполняем функцию
	E.func_UPDATE_MAINFRAME()
	return false -- всё ок
end

----------------------------------------------------------------
function E.func_SetOrNil(tbl, key, val)
	tbl[key] = (val and val ~= 0) and val or nil
end
----------------------------------------------------------------
-- Функция глубокого копирования таблицы
function E.func_CopyTableDeep(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[E.func_CopyTableDeep(orig_key)] = E.func_CopyTableDeep(orig_value)
		end
		setmetatable(copy, E.func_CopyTableDeep(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

-- Функция показа сообщения
function E.func_PrintMessage(text)
	-- Используем стандартное сообщение WoW или создаем свое
	UIErrorsFrame:AddMessage(E.func_Gradient(text), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)

	-- DEFAULT_CHAT_FRAME:AddMessage(E.func_GetAddOnMetadata(E.MainAddonName, "Title")..": "..text)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetTimeToReset()
	if C_DateAndTime and C_DateAndTime.GetSecondsUntilDailyReset then
		return C_DateAndTime.GetSecondsUntilDailyReset()
	else
		return GetQuestResetTime()
	end
end
----------------------------------------------------------------
function E.func_RemoveZeroValues(tbl, smth)
	-- Проверка входных параметров
	if not tbl or not smth or type(tbl) ~= "table" then return end
	-- Обработка случая когда smth - таблица значений для удаления
	if type(smth) == "table" then
		for q, w in ipairs(smth) do
			for k, value in pairs(tbl) do
				if value == w then -- Точное совпадение значения
					print(k, E.COLOR_YELLOW..tostring(value).."|r")
					tbl[k] = nil -- Удаляем значение
				elseif type(value) == "table" then
					E.func_RemoveZeroValues(value, w) -- Рекурсия для вложенных таблиц
				end
			end
			return tbl
		end
		-- Обработка числовых значений для удаления
	elseif type(smth) == "number" then
		for k, value in pairs(tbl) do
			if value == smth then
				print(k, E.COLOR_PURPLE..tostring(value).."|r")
				tbl[k] = nil
			elseif type(value) == "table" then
				E.func_RemoveZeroValues(value, smth) -- Рекурсия
			end
		end
		return tbl
		-- Обработка строковых шаблонов
	elseif type(smth) == "string" then
		for k, value in pairs(tbl) do
			-- Специальный случай для любых числовых значений
			if value and smth == "anynumber" and type(value) == "number" then
				print(k, E.COLOR_WOW_TOKEN..tostring(value).."|r")
				tbl[k] = nil
			else
				E.func_RemoveZeroValues(value, smth)
			end
			-- Поиск по строковому шаблону
			if value and type(value) == "string" then
				if string.find(value, smth) then
					print(k, E.COLOR_MAGENTA..tostring(value).."|r")
					tbl[k] = nil
				end
			else
				E.func_RemoveZeroValues(value, smth)
			end
		end
		return tbl
	end
end
----------------------------------------------------------------
function E.func_UpdateFont()
	local Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	local Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	local Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags

	E.OctoFont10:SetFont(LibSharedMedia:Fetch("font", Config_FontStyle), Config_FontSize-1, Config_FontFlags)
	E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Config_FontStyle), Config_FontSize, Config_FontFlags)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

----------------------------------------------------------------
function E.func_GetProfileData(key)
	local tbl = Octo_profileKeys.profiles[E.CurrentProfile][key] or {}
	return tbl
end
----------------------------------------------------------------

function E.func_SHOULDSHOWatPROFILEDATA(profileName)


end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateNewProfile(profileName)
	-- Инициализация провайдера данных
	E.DataProvider_Otrisovka = {}
	E.ALL_UniversalQuests = {}
	E.ALL_Additionally = {}
	E.OctoTables_Vibor = {}
	E.OctoTables_DataOtrisovka = {}

	-- 1. Обработка компонентов
	E.func_ProcessComponents()

	-- 2. Инициализация структуры профиля
	local db = E.func_InitializeProfileStructure(profileName)

	-- 3. Заполнение данных профиля
	E.func_PopulateProfileData(db, profileName)
end
----------------------------------------------------------------
-- Вспомогательные функции
function E.func_ProcessComponents()
	-- Обработка компонентов
	for _, componentFunc in pairs(E.Components) do
		local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()

		-- Объединение данных Vibor
		for key, value in pairs(OctoTables_Vibor) do
			if E.OctoTables_Vibor[key] == nil then
				E.OctoTables_Vibor[key] = value
			end
		end

		-- Объединение данных DataOtrisovka
		for key, value in pairs(OctoTables_DataOtrisovka) do
			if E.OctoTables_DataOtrisovka[key] == nil then
				E.OctoTables_DataOtrisovka[key] = value
			end
		end
	end
end
----------------------------------------------------------------
function E.func_InitializeProfileStructure(profileName)
	-- Инициализация основной структуры
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys

	-- Базовые настройки
	E.func_InitField(db, "CurrentProfile", profileName)
	E.func_InitField(db, "useGlobalProfile", false)
	E.func_InitField(db, "isSettingsEnabled", false)

	-- Инициализация подтаблиц
	E.func_InitSubTable(db, "profileKeys")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, profileName)
	----------------------------------------------------------------
	-- Инициализация секций профиля
	local profile = db.profiles[profileName]

	local profileSections = {
		"Currencies",
		"Items",
		"Reputations",
		"UniversalQuests",
		"Additionally"
	}
	-- Настройки расширений по умолчанию
	E.func_InitField(profile, "ExpansionToShow", {
		-- [7] = true, -- 07_Legion
		[11] = true, -- 11_TheWarWithin
		-- [98] = true, -- Holidays
		[99] = true
	})
	----------------------------------------------------------------

	for _, section in pairs(profileSections) do
		E.func_InitSubTable(profile, section)
	end

	-- Создание профиля Default если не существует
	E.func_InitSubTable(db.profiles, "Default")

	-- Инициализация секций для Default
	local defaultProfile = db.profiles.Default
	for _, section in pairs(profileSections) do
		E.func_InitSubTable(defaultProfile, section)
	end

	return db
end

----------------------------------------------------------------
function E.func_PopulateProfileData(db, profileName)
	local currentProfile = db.profiles[profileName]
	local defaultProfile = db.profiles.Default
	for categoryKey, categoryData in pairs(E.OctoTables_DataOtrisovka) do
		for dataType, dataEntries in pairs(categoryData) do
			-- Инициализация структуры данных
			E.DataProvider_Otrisovka[categoryKey] = E.DataProvider_Otrisovka[categoryKey] or {}
			E.DataProvider_Otrisovka[categoryKey][dataType] = E.DataProvider_Otrisovka[categoryKey][dataType] or {}

			if dataType ~= "UniversalQuests" then
				E.func_ProcessStandardData(categoryKey, dataType, dataEntries, currentProfile, defaultProfile)
			else
				E.func_ProcessUniversalQuests(categoryKey, dataEntries, currentProfile, defaultProfile)
			end
		end
	end
end
----------------------------------------------------------------
function E.func_ProcessStandardData(categoryKey, dataType, dataEntries, currentProfile, defaultProfile)
	for _, entry in pairs(dataEntries) do
		-- Добавление ID в DataProvider
		table.insert(E.DataProvider_Otrisovka[categoryKey][dataType], entry.id)
		-- Установка значения по умолчанию для текущего профиля
		if currentProfile[dataType][entry.id] == nil then currentProfile[dataType][entry.id] = entry.defS end

		-- Установка значения по умолчанию для Default профиля
		if defaultProfile[dataType][entry.id] == nil then defaultProfile[dataType][entry.id] = entry.defS end

		-- Регистрация в глобальных таблицах
		if dataType == "Currencies" then
			E.ALL_Currencies[entry.id] = true
		elseif dataType == "Items" then
			E.ALL_Items[entry.id] = true
		elseif dataType == "Reputations" then
			E.ALL_Reputations[entry.id] = true
		elseif dataType == "Additionally" then
			E.ALL_Additionally[entry.id] = true
		end
	end
end
----------------------------------------------------------------
function E.func_ProcessUniversalQuests(categoryKey, questEntries, currentProfile, defaultProfile)
	for _, questData in pairs(questEntries) do
		-- Добавление данных квеста
		table.insert(E.DataProvider_Otrisovka[categoryKey]["UniversalQuests"], questData)
		table.insert(E.ALL_UniversalQuests, questData)

		-- Создание уникального ключа для квеста
		local questKey = E.UNIVERSAL..questData.desc.."_"..questData.name_save.."_"..questData.reset

		-- Установка значений по умолчанию
		currentProfile.UniversalQuests[questKey] = currentProfile.UniversalQuests[questKey] or questData.defS
		defaultProfile.UniversalQuests[questKey] = defaultProfile.UniversalQuests[questKey] or questData.defS

		-- Регистрация ID квестов
		for _, questEntry in ipairs(questData.quests) do
			local questID = questEntry[1]
			if type(questID) == "number" then
				E.ALL_Quests[questID] = true
			end
		end
	end
end
----------------------------------------------------------------
function E.func_UpdateCurrentProfile(name)
	if name then
		Octo_profileKeys.CurrentProfile = name
	end
	E.CurrentProfile = Octo_profileKeys.CurrentProfile
end
----------------------------------------------------------------
function E.func_countTable(t)
	if not t then
		print ("NOT TABLE in func_countTable")
		return 0
	end
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end


----------------------------------------------------------------
-- XOR для uint16
local function xor16(a, b)
	local r = 0
	for i = 0, 15 do
		local bitA = a % 2
		local bitB = b % 2
		local bitR = (bitA + bitB) % 2
		r = r + bitR * 2^i
		a = math.floor(a/2)
		b = math.floor(b/2)
	end
	return r
end

-- Константа ключа
local XOR_KEY = 0xABCD

-- Кодирование массива чисел в uint16 с XOR
function E.func_EncodeUInt16Array(arr)
	local packed = {}
	for i = 1, #arr do
		assert(arr[i] >= 0 and arr[i] <= 65535, "Value out of uint16 range")
		packed[i] = xor16(arr[i], XOR_KEY)
	end
	return packed
end

-- Декодирование массива чисел
function E.func_DecodeUInt16Array(packed)
	local arr = {}
	for i = 1, #packed do
		arr[i] = xor16(packed[i], XOR_KEY)
	end
	return arr
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_REGEN_ENABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_ENABLED()
	E.func_RunAfterCombat()
end