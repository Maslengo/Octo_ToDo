local GlobalAddonName, E = ...

local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
-- Кеширование глобальных функций и таблиц
local sort = table.sort
local table_insert = table.insert
local table_concat = table.concat
local string_format = string.format
local string_upper = string.upper
local string_lower = string.lower
local string_sub = string.sub
local string_gsub = string.gsub
local string_match = string.match
local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min
local math_max = math.max
local tonumber = tonumber
local tostring = tostring
local select = select
local pairs = pairs
local ipairs = ipairs
local next = next
local type = type
local AddMessage = AddMessage
local CreateFrame = CreateFrame
local GetTime = GetTime
local GetServerTime = GetServerTime
local GetFramerate = GetFramerate
local UnitClass = UnitClass
local UnitFactionGroup = UnitFactionGroup
local UnitFullName = UnitFullName
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel
local UnitSex = UnitSex
local GetClassColor = GetClassColor
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
local GetProfessionInfo = GetProfessionInfo
local BNGetInfo = BNGetInfo
local PlayerHasToy = PlayerHasToy
local CreateColor = CreateColor
local GameTooltip = GameTooltip
local GameTooltip_Hide = GameTooltip_Hide
local StaticPopup_Show = StaticPopup_Show
local Settings = Settings
local SettingsPanel = SettingsPanel
local HideUIPanel = HideUIPanel
local UIParent = UIParent
local WorldFrame = WorldFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
-- Кеширование часто используемых строк
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local SEARCH_LOADING_TEXT = SEARCH_LOADING_TEXT or "Loading..."
local RETRIEVING_ITEM_INFO = RETRIEVING_ITEM_INFO or "Retrieving info"
local QUEST_WATCH_QUEST_READY = QUEST_WATCH_QUEST_READY or "Complete"
local COMPLETE = COMPLETE or "Complete"
local FAILED = FAILED or "Failed"
local CLOSE = CLOSE or "Close"
local OPTIONS = OPTIONS or "Options"
local YES = YES or "Yes"
local NO = NO or "No"
local UNKNOWN = UNKNOWN or "Unknown"
local FACTION_STANDING_LABEL = FACTION_STANDING_LABEL or {}
local ADDON_DEPENDENCIES = ADDON_DEPENDENCIES or "Dependencies:"
-- AddOn functions
local DisableAddOn = DisableAddOn or C_AddOns.DisableAddOn
local DisableAllAddOns = DisableAllAddOns or C_AddOns.DisableAllAddOns
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
local EnableAllAddOns = EnableAllAddOns or C_AddOns.EnableAllAddOns
local GetAddOnDependencies = GetAddOnDependencies or C_AddOns.GetAddOnDependencies
local GetAddOnEnableState = GetAddOnEnableState or C_AddOns.GetAddOnEnableState
local GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local GetAddOnOptionalDependencies = GetAddOnOptionalDependencies or C_AddOns.GetAddOnOptionalDependencies
local GetNumAddOns = GetNumAddOns or C_AddOns.GetNumAddOns
local GetScriptsDisallowedForBeta = GetScriptsDisallowedForBeta or C_AddOns.GetScriptsDisallowedForBeta
local IsAddOnDefaultEnabled = IsAddOnDefaultEnabled or C_AddOns.IsAddOnDefaultEnabled
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local IsAddOnLoadable = IsAddOnLoadable or C_AddOns.IsAddOnLoadable
local IsAddOnLoadOnDemand = IsAddOnLoadOnDemand or C_AddOns.IsAddOnLoadOnDemand
local IsAddonVersionCheckEnabled = IsAddonVersionCheckEnabled or C_AddOns.IsAddonVersionCheckEnabled
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
local ResetAddOns = ResetAddOns or C_AddOns.ResetAddOns
local ResetDisabledAddOns = ResetDisabledAddOns or C_AddOns.ResetDisabledAddOns
local SaveAddOns = SaveAddOns or C_AddOns.SaveAddOns
local SetAddonVersionCheck = SetAddonVersionCheck or C_AddOns.SetAddonVersionCheck
local AddonList_HasOutOfDate = AddonList_HasOutOfDate
-- AddOn Profiler
local IsEnabled = IsEnabled or C_AddOnProfiler.IsEnabled
local GetOverallMetric = GetOverallMetric or C_AddOnProfiler.GetOverallMetric
local GetAddOnMetric = GetAddOnMetric or C_AddOnProfiler.GetAddOnMetric
local GetApplicationMetric = GetApplicationMetric or C_AddOnProfiler.GetApplicationMetric
-- Item functions
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant
local GetItemInventoryTypeByID = GetItemInventoryTypeByID or C_Item.GetItemInventoryTypeByID
local GetItemMaxStackSizeByID = GetItemMaxStackSizeByID or C_Item.GetItemMaxStackSizeByID
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsItemDataCachedByID = IsItemDataCachedByID or C_Item.IsItemDataCachedByID
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
-- Spell functions
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellDescription = GetSpellDescription or C_Spell.GetSpellDescription
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
local IsSpellKnown = IsSpellKnown
-- Currency functions
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
-- Quest functions
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
local IsComplete = IsComplete or C_QuestLog.IsComplete
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
local GetInfo = GetInfo or C_QuestLog.GetInfo
local SetSelectedQuest = SetSelectedQuest or C_QuestLog.SetSelectedQuest
local SetAbandonQuest = SetAbandonQuest or C_QuestLog.SetAbandonQuest
local AbandonQuest = AbandonQuest or C_QuestLog.AbandonQuest
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
local IsFailed = IsFailed or C_QuestLog.IsFailed
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
-- Reputation functions
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
local ExpandAllFactionHeaders = ExpandAllFactionHeaders or C_Reputation.ExpandAllFactionHeaders
local GetNumFactions = GetNumFactions or C_Reputation.GetNumFactions
local GetFactionDataByIndex = GetFactionDataByIndex or C_Reputation.GetFactionDataByIndex
-- Major Faction functions
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
-- Gossip/Friendship functions
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
-- Challenge Mode functions
local GetMapUIInfo = GetMapUIInfo or C_ChallengeMode.GetMapUIInfo
-- Covenant functions
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
-- Trade Skill functions
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
-- Map functions
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetBestMapForUnit = GetBestMapForUnit or C_Map.GetBestMapForUnit
-- Date/Time functions
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
-- Calendar functions
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetDayEvent = GetDayEvent or C_Calendar.GetDayEvent

----------------------------------------------------------------
local r, g, b = GetClassColor(E.classFilename)
----------------------------------------------------------------
-- console -> export "art"
function E:func_IsClassic() if E.interfaceVersion > 10000 and E.interfaceVersion < 20000 then return true else return false end end
function E:func_IsBC() if E.interfaceVersion > 20000 and E.interfaceVersion < 30000 then return true else return false end end
function E:func_IsWOTLK() if E.interfaceVersion > 30000 and E.interfaceVersion < 40000 then return true else return false end end
function E:func_IsCataclysm() if E.interfaceVersion > 40000 and E.interfaceVersion < 50000 then return true else return false end end
function E:func_IsMOP() if E.interfaceVersion > 50000 and E.interfaceVersion < 60000 then return true else return false end end
function E:func_IsWOD() if E.interfaceVersion > 60000 and E.interfaceVersion < 70000 then return true else return false end end
function E:func_IsLegion() if E.interfaceVersion > 70000 and E.interfaceVersion < 80000 then return true else return false end end
function E:func_IsBFA() if E.interfaceVersion > 80000 and E.interfaceVersion < 90000 then return true else return false end end
function E:func_IsShadowlands() if E.interfaceVersion > 90000 and E.interfaceVersion < 100000 then return true else return false end end
function E:func_IsDragonflight() if E.interfaceVersion > 100000 and E.interfaceVersion < 110000 then return true else return false end end
function E:func_IsTWW() if E.interfaceVersion > 110000 and E.interfaceVersion < 120000 then return true else return false end end
function E:func_IsMidnight() if E.interfaceVersion > 120000 and E.interfaceVersion < 130000 then return true else return false end end
function E:func_IsTLT() if E.interfaceVersion > 130000 and E.interfaceVersion < 140000 then return true else return false end end
function E:func_IsRetail() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE end
function E:func_IsPTR() return GetCurrentRegion() >= 72 end
----------------------------------------------------------------
function E:func_GetItemIconByID(itemID)
	return GetItemIconByID(itemID)
end
----------------------------------------------------------------
function E:func_GetItemNameByID(itemID)
	table_insert(E.PromiseItem, itemID)
	-- local info = C_AccountStore.GetItemInfo(itemID)
	-- local itemName = C_AccountStore.GetItemInfo(itemID).name or UNKNOWN
	local itemName = GetItemNameByID(itemID) or SEARCH_LOADING_TEXT
	local vivod = ""
	local itemQuality = select(3, E:func_GetItemInfo(itemID)) or 0
	if itemQuality then
		vivod = vivod..ITEM_QUALITY_COLORS[itemQuality].color:WrapTextInColorCode(itemName)
	end
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..itemID.."|r" or "")
end
----------------------------------------------------------------
function E:func_LFGdungName(dID)
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID == dID then
			return name-- Возвращаем имя сразу при нахождении
		end
	end
	return UNKNOWN-- Возвращаем значение по умолчанию только если ничего не найдено
end
----------------------------------------------------------------
function E:func_GetSpellIcon(spellID)
	return GetSpellTexture(spellID)
end
----------------------------------------------------------------
function E:func_GetSpellName(spellID)
	table_insert(E.PromiseSpell, spellID)
	local vivod = GetSpellName(spellID)
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..spellID.."|r" or "")
end
----------------------------------------------------------------
function E:func_GetCurrencyIcon(currencyID)
	local info = GetCurrencyInfo(currencyID)
	return info and info.iconFileID or E.Icon_Empty --  E.Icon_QuestionMark
end
----------------------------------------------------------------
function E:func_currencyName(currencyID)
	-- ВАРИАНТ 1
	-- local vivod = ""
	-- local AWide = ""
	-- if IsAccountTransferableCurrency(currencyID) then
	--     AWide = E.Icon_AccountTransferable
	-- elseif IsAccountWideCurrency(currencyID) then
	--     AWide = E.Icon_AccountWide
	-- end
	-- local info = GetCurrencyInfo(currencyID)
	-- if info then
	--     local name = info.name
	--     local quality = info.quality
	--     local r, g, b = E:func_GetItemQualityColor(quality)
	--     local color = CreateColor(r, g, b, 1)
	--     local currencyName = color:WrapTextInColorCode(name)
	--     vivod = AWide..currencyName
	-- else
	--     vivod = AWide..E.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	-- end
	-- return vivod..(E.DebugIDs and E.Gray_Color.." id:"..currencyID.."|r" or "")
	-- ВАРИАНТ 2
	local WarbandIcon = ""
	if IsAccountTransferableCurrency(currencyID) then
		WarbandIcon = E.Icon_AccountTransferable
	elseif IsAccountWideCurrency(currencyID) then
		WarbandIcon = E.Icon_AccountWide
	end
	-- Получение информации о валюте
	local info = GetCurrencyInfo(currencyID)
	if not info then
		return WarbandIcon .. E.Red_Color .. RETRIEVING_ITEM_INFO .. "|r" .. (E.DebugIDs and E.Gray_Color .. " id:" .. currencyID .. "|r" or "")
	end
	local name = info.name
	local color = ITEM_QUALITY_COLORS[info.quality].hex or ITEM_QUALITY_COLORS[1]
	return WarbandIcon .. color .. name .. "|r" .. (E.DebugIDs and E.Gray_Color .. " id:" .. currencyID .. "|r" or "")
	-- ВАРИАНТ 3
	-- local WarbandIcon = ""
	-- if IsAccountTransferableCurrency(currencyID) then
	--     WarbandIcon = E.Icon_AccountTransferable
	-- elseif IsAccountWideCurrency(currencyID) then
	--     WarbandIcon = E.Icon_AccountWide
	-- end
	-- local parts = { WarbandIcon } -- Инициализация с WarbandIcon
	-- -- Обработка информации о валюте
	-- if info then
	--     parts[2] = ITEM_QUALITY_COLORS[info.quality].hex..info.name.."|r"
	-- else
	--     parts[2] = E.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	-- end
	-- -- Добавление отладочной информации при необходимости
	-- if E.DebugIDs then
	--     parts[3] = E.Gray_Color.." id:"..currencyID.."|r"
	-- end
	-- return table.concat(parts)
	-- ВАРИАНТ 4
	-- return ((IsAccountTransferableCurrency(currencyID) and E.Icon_AccountWide or " ") ..C_AccountStore.GetCurrencyInfo(currencyID).name) or UNKNOWN
end
----------------------------------------------------------------
function E:func_IsAccountQuest(questID)
	return IsAccountQuest(questID)
end
function E:func_IsQuestFlaggedCompletedOnAccount(questID)
	return IsQuestFlaggedCompletedOnAccount(questID)
end
table_insert(E.PromiseQuest, questID)
----------------------------------------------------------------
E.quest_names = {}
setmetatable(E.quest_names, {__index = function(self, key)
			local title = (C_QuestLog.GetTitleForQuestID or C_QuestLog.GetQuestInfo)(key)
			if title then
				self[key] = title
				return title
			end
			return E.Red_Color..UNKNOWN.."|r"
end,})
function E:func_questName_SIMPLE(questID)
	return E.quest_names[questID]
end
----------------------------------------------------------------
function E:func_questName(questID, useLargeIcon)
	table_insert(E.PromiseQuest, questID)
	local title = E.quest_names[questID] -- GetTitleForQuestID(questID)
	local vivod = title and QuestUtils_DecorateQuestText(questID, title, useLargeIcon ~= false)
	if E:func_IsAccountQuest(questID) or E:func_IsQuestFlaggedCompletedOnAccount(questID) then
		vivod = E.Icon_AccountWide..vivod
	end
	if E:func_IsAccountQuest(questID) then
		vivod = "|cffFFFF00"..vivod.."|r"
	elseif E:func_IsQuestFlaggedCompletedOnAccount(questID) then
		vivod = "|cff9fc5e8"..vivod.."|r"
	end
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..questID.."|r" or "")
end
----------------------------------------------------------------
function E:func_getMapFullNameInfo(mapID)
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
----------------------------------------------------------------
function E:func_GetCurrentLocation()
	local curRealZone = GetRealZoneText()
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText()
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText()
	----
	-- local uiMapID = GetBestMapForUnit("PLAYER") or 0
	local uiMapID = MapUtil.GetDisplayableMapForPlayer()
	if uiMapID ~= 0 then
		local mapInfo = E:func_getMapFullNameInfo(uiMapID)
		if FIRSTtext == "" then
			return E.Red_Color..mapInfo.name.."|r"
		elseif FIRSTtext == SECONDtext then
			return FIRSTtext
		else
			return SECONDtext ~= "" and FIRSTtext.." ("..SECONDtext..")" or FIRSTtext
		end
	end
	return UNKNOWN
end
----------------------------------------------------------------
function E:func_reputationName(reputationID)
	if reputationID then
		local vivod = ""

		local side = "-"
		local name = UNKNOWN

		if E.OctoTable_ReputationsDB[reputationID] then
			side = E.OctoTable_ReputationsDB[reputationID].side
			name = E.OctoTable_ReputationsDB[reputationID].name
		end



		local color = E.White_Color
		local repInfo = GetFactionDataByID(reputationID)
		if repInfo then
			vivod = vivod.. repInfo.name
		else
			local reputationInfo = GetFriendshipReputation(reputationID)
			if reputationInfo.name then
				vivod = vivod.. reputationInfo.name
			elseif name then
				vivod = vivod.. name
			else
				vivod = vivod.. reputationID.. "("..UNKNOWN..")"
			end
		end
		----------------------------------------------------------------
		if side == "Alliance" then
			vivod = E:func_texturefromIcon(E.Icon_Alliance)..vivod
			vivod = E.Blue_Color..vivod.."|r"
			-- vivod = "|cffC6D2FF"..vivod.."|r"
		elseif side == "Horde" then
			vivod = E:func_texturefromIcon(E.Icon_Horde)..vivod
			vivod = E.Red_Color..vivod.."|r"
			-- vivod = "|cffFFC6CB"..vivod.."|r"
		end
		----------------------------------------------------------------
		local isAccountWide = IsAccountWideReputation(reputationID) or false
		if isAccountWide == true then
			vivod = E.Icon_AccountWide..vivod
		end
		return vivod..(E.DebugIDs and E.Gray_Color.." id:"..reputationID.."|r" or "")
	else
		return "|cffFF0000no reputationID|r"
	end
end
----------------------------------------------------------------
-- ITEM UTILS
----------------------------------------------------------------
function E:func_GetItemInfo(itemInfo) -- Item ID, Link or name
	return GetItemInfo(itemInfo)
end
----------------------------------------------------------------
function E:func_GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if not itemID then return 0 end
	return GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_GetItemLink(itemID)
	local _, link = E:func_GetItemInfo(itemID)
	return link
end
----------------------------------------------------------------
function E:func_GetItemQuality(itemID)
	return GetItemQualityByID(itemID)
end
----------------------------------------------------------------
function E:func_GetItemQualityColorID(itemID)
	return ITEM_QUALITY_COLORS[E:func_GetItemQuality(itemID)]
end
----------------------------------------------------------------
function E:func_GetItemQualityColor(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
----------------------------------------------------------------
function E:func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
----------------------------------------------------------------
function E:func_GetDetailedItemLevelInfo(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
----------------------------------------------------------------
function E:func_GetItemMaxStackSize(itemID)
	return GetItemMaxStackSizeByID(itemID)
end
----------------------------------------------------------------
function E:func_IsItemStackable(itemID)
	local maxStackSize = E:func_GetItemMaxStackSize(itemID)
	return maxStackSize and maxStackSize > 1
end
----------------------------------------------------------------
function E:func_GetItemInventoryType(itemID)
	return GetItemInventoryTypeByID(itemID)
end
----------------------------------------------------------------
function E:func_GetItemInventoryTypeName(itemID)
	local _, _, _, itemEquipLoc = GetItemInfoInstant(itemID)
	return itemEquipLoc
end
----------------------------------------------------------------
function E:func_IsItemDataCached(itemID)
	return IsItemDataCachedByID(itemID)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_spellTexture(spellID)
	local icon = E:func_GetSpellIcon(spellID)
	return E:func_texturefromIcon(icon)
end
----------------------------------------------------------------
function E:func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E:func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
-- SPELLS
----------------------------------------------------------------
function E:func_GetSpellSubtext(spellID)
	local vivod = GetSpellSubtext(spellID)
	return vivod
end
----------------------------------------------------------------
function E:func_GetSpellDescription(spellID)
	return GetSpellDescription(spellID)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_GetSpellCooldown(spellID)
	local start = GetSpellCooldown(spellID).startTime
	local duration = GetSpellCooldown(spellID).duration
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E:func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
function E:func_COMPLETE()
	-- return E.Purple_Color..">>".."Complete".."<<".."|r"
	-- return E.Purple_Color..">"..COMPLETE.."<".."|r"
	return E.Purple_Color..">"..QUEST_WATCH_QUEST_READY.."<".."|r"
end
----------------------------------------------------------------
function E:func_hex2rgb(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
----------------------------------------------------------------
function E:func_hex2rgbNUMBER(hex)
	if hex and hex ~= "" then
		hex = hex:gsub("|cff", "")
		return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
	else
		return 1, 1, 1
	end
end
----------------------------------------------------------------
function E:func_rgb2hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
----------------------------------------------------------------
function E:func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
----------------------------------------------------------------
function E:func_rgb2hexSTRING(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
----------------------------------------------------------------
function E:func_percent(percent, maxvalue)
	return (maxvalue*percent)/100
end
----------------------------------------------------------------
function E:func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local vivod = ""
	local str = ""
	local total = utf8len(text)-1
	if total > 0 then
		local r1, g1, b1 = E:func_hex2rgb(firstColor)
		local r2, g2, b2 = E:func_hex2rgb(secondColor)
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
		vivod = str..secondColor..utf8sub(text, utf8len(text)).."|r"
		return vivod
	else
		return text
	end
end
----------------------------------------------------------------
function E:func_GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		table_insert(s, E.OctoTable_bytetoB64[math.random(0, 63)])
	end
	return table_concat(s)
end
----------------------------------------------------------------
function E:func_GenerateUniqueColor()
	local s = {}
	for i=1, 6 do
		table_insert(s, E.OctoTable_bytetoB64Color[math.random(0, 15)])
	end
	return table_concat(s)
end
----------------------------------------------------------------
function E:func_CompactNumberFormat(number)
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
----------------------------------------------------------------
function E:func_CompactNumberSimple(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math_floor(number+.5)
	end
end
----------------------------------------------------------------
function E:func_texturefromIcon(icon, iconWidth, iconHeight)
	iconWidth = iconWidth or 16 or Octo_ToDo_DB_Vars.AddonHeight
	iconHeight = iconHeight or 16 or Octo_ToDo_DB_Vars.AddonHeight
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconWidth)..":"..(iconHeight or iconWidth)..":::64:64:4:60:4:60|t"
end
----------------------------------------------------------------

function E:func_texturefromIconEVENT(icon, iconSize)
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconSize or 16)..":"..(iconSize or 16)..":::128:128:0:91:0:91|t"
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_currencyIcon(currencyID)
	local info = GetCurrencyInfo(currencyID)
	local iconFileID = E.Icon_QuestionMark
	if info then
		iconFileID = info.iconFileID
	end
	return E:func_texturefromIcon(iconFileID)
end
----------------------------------------------------------------
function E:func_currencyquantity(currencyID)
	local info = GetCurrencyInfo(currencyID)
	local quantity
	if info then
		quantity = info.quantity or 0
	end
	return quantity
end
----------------------------------------------------------------
function E:func_SecondsToClock(time)
	time = tonumber(time) or 0
	if time <= 0 then
		return "" -- "0"..(L["time_SECOND"])
	end
	local years = floor(time / 31536000) -- 86400*365
	local days = floor(time % 31536000 / 86400)
	local hours = floor(time % 86400 / 3600)
	local mins = floor(time % 3600 / 60)
	local secs = floor(time % 60)
	local parts = {}
	if years > 0 then
		table.insert(parts, years..(L["time_YEAR"] or "y").." ")
		table.insert(parts, days..(L["time_DAY"] or "d").." ")
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif days > 0 then
		table.insert(parts, days..(L["time_DAY"] or "d").." ")
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif hours > 0 then
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, string_format("%02d", mins)..(L["time_MINUTE"] or "m"))
	elseif time >= 60 then
		table.insert(parts, mins..(L["time_MINUTE"] or "m").." ")
		if time < 600 then -- Только для 1-9 минут добавляем секунды
			table.insert(parts, secs..(L["time_SECOND"] or "s"))
		end
	else
		table.insert(parts, secs..(L["time_SECOND"] or "s"))
	end
	return table_concat(parts)
end
----------------------------------------------------------------
function E:func_ChatFrame_TimeBreakDown(time)
	local days = floor(time / (60 * 60 * 24))
	local hours = floor((time - (days * (60 * 60 * 24))) / (60 * 60))
	local minutes = floor((time - (days * (60 * 60 * 24)) - (hours * (60 * 60))) / 60)
	local seconds = mod(time, 60)
	return days, hours, minutes, seconds
end
----------------------------------------------------------------
function E:func_tmstpDayReset(time)
	local time = time or 1
	return (math_ceil((tonumber(GetServerTime()) - E.thursdayReset)/(E.daytime*time))*E.daytime*time)+E.thursdayReset
end
----------------------------------------------------------------
function E:func_IsOnQuest(questID)
	return IsOnQuest(questID)
end
----------------------------------------------------------------
function E:func_CheckCompletedByQuestID(questID)
	if IsFailed(questID) then
		return "|cffFF0000>"..FAILED.."<|r"
	end
	if IsQuestFlaggedCompleted(questID) then
		return E.DONE
	end
	if IsComplete(questID) then
		return E:func_COMPLETE()
	end
	if not E:func_IsOnQuest(questID) then
		return E.NONE
	end
	-- Если мы дошли сюда, значит квест взят, но не завершен
	local objectives = GetQuestObjectives(questID)
	if not objectives then
		return ""
	end
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
			table.insert(parts, text)
		end
	end
	return table_concat(parts, "»")
end
----------------------------------------------------------------
function E:func_OnlyFirstWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z
end
----------------------------------------------------------------
function E:func_OnlyLastWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return z or y or x or w or v or u or t or s or r or q or p or i or n or m or l or k or j or i or h or g or f or e or d or c or b or a
end
----------------------------------------------------------------
function E:func_InList(k, t, p)
	for _, v in next, (t) do
		if (p and v[p]==k) or (not p and v==k) then
			return true
		end
	end
end
----------------------------------------------------------------
function E:func_achievementComplete(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
----------------------------------------------------------------
function E:func_achievementName(achievementID)
	local vivod = select(2, GetAchievementInfo(achievementID))
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..achievementID.."|r" or "")
end
----------------------------------------------------------------
function E:func_achievementIcon(achievementID)
	local Icon = select(10, GetAchievementInfo(achievementID))
	return Icon
end
----------------------------------------------------------------
function E:func_achievementDescription(achievementID)
	local description = select(8, GetAchievementInfo(achievementID)) or ""
	return description
end
----------------------------------------------------------------
function E:func_achievementvivod(achievementID)
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
----------------------------------------------------------------
function E:func_CurServerShort(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	if b then
		return utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	end
	return utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
end
E.curServerShort = E:func_CurServerShort(GetRealmName())
----------------------------------------------------------------
function E:func_GetMapName(mapID)
	if not mapID then return end
	local info = GetMapInfo(mapID)
	if info then
		return tostring(info.name)..(E.DebugIDs and E.Gray_Color.." id:"..mapID.."|r" or "")
	end
end
----------------------------------------------------------------
function E:func_GetMapNameFromID(mapID) -- ПОФИКСИТЬ
	if not mapID then
		return UNKNOWN
	end
	local mapdata = GetMapInfo(mapID)
	if not mapdata then
		return UNKNOWN
	end
	local groupID = GetMapGroupID(mapID)
	if groupID then
		local groupdata = GetMapGroupMembersInfo(groupID)
		for _, subzonedata in ipairs(groupdata) do
			if subzonedata.mapID == mapID then
				return mapdata.name, " ("..subzonedata.name..")"
			end
		end
	end
	return mapdata.name, ""
end
----------------------------------------------------------------
function E:func_GetCoord(x, y)
	return floor(x * 10000 + 0.5) * 10000 + floor(y * 10000 + 0.5)
end
----------------------------------------------------------------
function E:func_GetCoordFormated(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	-- return ("%.2f, %.2f"):format(x * 100, y * 100)
	return string.format("%.1f / %.1f", x * 100, y * 100)
end
----------------------------------------------------------------
function E:func_npcName(npcID)
	if not npcID then return E.NONE end
	E.inspectScantipFUNC = E.inspectScantipFUNC or CreateFrame("GameTooltip", "OctoScanningTooltipFUNC", nil, "GameTooltipTemplate")
	local tooltip = E.inspectScantipFUNC
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:ClearLines()
	tooltip:SetHyperlink("unit:Creature-0-0-0-0-"..npcID)
	local vivod = UNKNOWN
	if tooltip:NumLines() > 0 then
		vivod = _G["OctoScanningTooltipFUNCTextLeft1"]:GetText()
	end
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..npcID.."|r" or "")
end
----------------------------------------------------------------
function E:func_RIOColor(RIOscore)
	if not RIOscore or RIOscore == 0 then
		return E.Gray_Color
	end
	local colors = E.OctoTable_RIO_COLORS
	for i = 1, #colors do
		local v = colors[i]
		if RIOscore <= v.score then
			return E:func_rgb2hex(v.color[1], v.color[2], v.color[3])
		end
	end
	return E.Gray_Color
end
----------------------------------------------------------------
function E:func_encryption(text)
	-- Преобразуем в строку и переворачиваем
	local reversed = utf8reverse(tostring(text))
	-- Удаляем все цифры за одну операцию
	local cleaned = reversed:gsub("%d", "")
	-- Приводим к нижнему регистру и возвращаем
	return utf8lower(cleaned)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Reverse_order(a, b)
	return b < a
end
----------------------------------------------------------------
function E:func_CheckReputation(reputationID)
	-- Инициализация переменных по умолчанию
	local SHOWFULL = false
	local FIRST, SECOND = 0, 0
	local vivod = ""
	local color = E.Pink_Color
	local standingTEXT = ""
	local reaction = 0
	-- Получаем данные о репутации
	local simpleData = GetFactionDataByID(reputationID)
	local isSimple = simpleData ~= nil
	local isParagon = IsFactionParagon(reputationID)
	local friendData = GetFriendshipReputation(reputationID)
	local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
	local isMajor = IsMajorFaction(reputationID)
	-- Таблица цветов для уровней репутации
	local reactionColors = {
		[0] = E.White_Color, -- Нейтральный E.White_Color
		[1] = E.Red_Color, -- Ненависть E.Red_Color
		[2] = E.Red_Color, -- Враждебность E.Red_Color
		[3] = E.Orange_Color, -- Неприязнь E.Orange_Color
		[4] = E.Yellow_Color, -- Равнодушие E.Yellow_Color
		[5] = E.Yellow_Color, -- Дружелюбие E.Yellow_Color
		[6] = E.Green_Color, -- Уважение E.Green_Color
		[7] = E.Green_Color, -- Почет E.Green_Color
		[8] = E.Green_Color, -- Превознесение E.Green_Color
	}
	-- Обработка простой репутации
	if isSimple then
		reaction = simpleData.reaction
		standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
		color = reactionColors[reaction] or E.Pink_Color
	end
	-- Обработка разных типов репутации
	if isParagon then
		-- Репутация Paragon
		local currentValue, threshold, _, _, tooLowLevelForParagon = GetFactionParagonInfo(reputationID)
		if threshold then
			local value = currentValue % threshold
			color = E.Blue_Color
			vivod = value.."/"..threshold
			if tooLowLevelForParagon then
				vivod = vivod..E.Red_Color.."*|r"
			end
			FIRST, SECOND = value, threshold
		end
	elseif isMajor then
		-- Основные фракции
		local majorData = GetMajorFactionData(reputationID)
		if majorData then
			local currentValue = majorData.renownReputationEarned % majorData.renownLevelThreshold
			local totalValue = majorData.renownLevelThreshold
			vivod = currentValue.."/"..totalValue..color.."("..majorData.renownLevel..")|r"
			FIRST, SECOND = currentValue, totalValue
		end
	elseif isFriend then
		-- Репутация дружбы
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
			vivod = FIRST.."/"..SECOND
		else
			standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
			FIRST, SECOND = SHOWFULL and standing or currentValue, SHOWFULL and (friendData.maxRep or 0) or totalValue
			vivod = FIRST.."/"..SECOND..standingTEXT
		end
	elseif isSimple and simpleData.currentStanding then
		-- Обычная репутация
		local barMin = simpleData.currentReactionThreshold
		local barMax = simpleData.nextReactionThreshold
		local barValue = simpleData.currentStanding
		local currentValue = barValue - barMin
		local totalValue = barMax - barMin
		if currentValue == totalValue then
			FIRST, SECOND = 1, 1
			vivod = standingTEXT
		else
			FIRST, SECOND = SHOWFULL and barMin or currentValue,
			SHOWFULL and (barMin < 0 and 42000 or barMax) or totalValue
			vivod = FIRST.."/"..SECOND
		end
	end
	return FIRST.."#"..SECOND.."#"..vivod.."#"..color.."#"..standingTEXT
end
----------------------------------------------------------------
function E:func_CurrentNumQuests()
	local numQuests = 0
	for i = 1, GetNumQuestLogEntries() do
		local info = GetInfo(i)
		numQuests = numQuests + (info and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_GetAddOnMetadata(name, variable)
	return GetAddOnMetadata(name, variable)
end
----------------------------------------------------------------
function E:func_IsAddOnLoaded(AddonNameOrIndex)
	return IsAddOnLoaded(AddonNameOrIndex)
end
----------------------------------------------------------------
function E:func_LoadAddOnFORCED(AddonName)
	if DoesAddOnExist(AddonName) and not E:func_IsAddOnLoaded(AddonName) then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------
function E:func_AddonTitle(AddonName)
	local AddonTitle = GetAddOnMetadata(AddonName, "Title")
	return AddonTitle
end
----------------------------------------------------------------
function E:func_AddonNotes(AddonName)
	local AddonNotes = GetAddOnMetadata(AddonName, "Notes")
	return AddonNotes
end
----------------------------------------------------------------
function E:func_AddonAuthor(AddonName)
	local AddonAuthor = GetAddOnMetadata(AddonName, "Author")
	return AddonAuthor
end
----------------------------------------------------------------
function E:func_AddonVersion(AddonName)
	local AddonVersion = GetAddOnMetadata(AddonName, "Version")
	return AddonVersion
end
----------------------------------------------------------------
function E:func_AddonIconTexture(AddonName)
	local AddonIconTexture = GetAddOnMetadata(AddonName, "IconTexture")
	return AddonIconTexture
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_IsInArray(arr, subj)
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_EmptyZero(value)
	if tonumber(value) == 0 then
		return "" --Red_Color.."NEEDDELETE|r"
	end
	return value
end
----------------------------------------------------------------
-- warcraft.wiki.gg/wiki/API_GetAccountExpansionLevel
function E:func_CurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
----------------------------------------------------------------
function E:func_EventName(eventID)
	local monthDay = GetCurrentCalendarTime().monthDay
	local month = 0 -- Можно раскомментировать, если нужен текущий месяц
	local numEvents = GetNumDayEvents(month, monthDay)
	for i = 1, numEvents do
		local event = GetDayEvent(month, monthDay, i)
		if event.eventID == eventID then
			local vivod = event.title
			return vivod..(E.DebugIDs and E.Gray_Color.." id:"..eventID.."|r" or "")
		end
	end
	return nil
end
----------------------------------------------------------------
function E:func_ProfessionName(skillLine)
	if not skillLine then return UNKNOWN end
	local vivod = GetTradeSkillDisplayName(skillLine) or UNKNOWN
	return vivod..(E.DebugIDs and E.Gray_Color.." id:"..skillLine.."|r" or "")
end
----------------------------------------------------------------
-- Возвращает иконку профессии в виде текстуры
function E:func_ProfessionIcon(skillLine)
	return skillLine and E:func_texturefromIcon(GetTradeSkillTexture(skillLine)) or ""
end
-- Возвращает текущий уровень навыка профессии
function E:func_ProfessionSkillLevel(skillLine)
	return skillLine and select(3, GetProfessionInfo(skillLine)) or ""
end
-- Возвращает максимальный уровень навыка профессии
function E:func_ProfessionMaxSkillLevel(skillLine)
	return skillLine and select(4, GetProfessionInfo(skillLine)) or ""
end
----------------------------------------------------------------
function E:func_debugprofileSTART()
	local timer = debugprofilestart()
	return timer
end
----------------------------------------------------------------
function E:func_debugprofileSTOP()
	local timer = E:func_CompactNumberSimple(debugprofilestop())
	local vivod = E:func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	vivod = vivod..timer
	return DEFAULT_CHAT_FRAME:AddMessage(vivod.. "|cff63A4E0 ms.|r")
end
----------------------------------------------------------------
function E:func_dungeonName(dungeonID)
	if dungeonID then
		local vivod = GetMapUIInfo(dungeonID)
		return vivod..(E.DebugIDs and E.Gray_Color.." id:"..dungeonID.."|r" or "")
	end
end
----------------------------------------------------------------
function E:func_dungeontimeLimit(dungeonID)
	if dungeonID then
		local timeLimit = select(3, GetMapUIInfo(dungeonID))
		return timeLimit
	end
end
----------------------------------------------------------------
function E:func_dungeonIcon(dungeonID)
	if dungeonID then
		local texture = select(4, GetMapUIInfo(dungeonID))
		return texture
	end
end
----------------------------------------------------------------
function E:func_FriendsFrame_GetLastOnlineText(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string_format(BNET_LAST_ONLINE_TIME, color..E.func_FriendsFrame_GetLastOnline(time).."|r")
	end
end
----------------------------------------------------------------
function E.func_FriendsFrame_GetLastOnline(timeDiff, isAbsolute)
	if not isAbsolute then
		timeDiff = time() - timeDiff
	end
	if timeDiff < SECONDS_PER_MIN then
		return LASTONLINE_SECS
	elseif timeDiff < SECONDS_PER_HOUR then
		return format(LASTONLINE_MINUTES, floor(timeDiff / SECONDS_PER_MIN))
	elseif timeDiff < SECONDS_PER_DAY then
		return format(LASTONLINE_HOURS, floor(timeDiff / SECONDS_PER_HOUR))
	elseif timeDiff < SECONDS_PER_MONTH then
		return format(LASTONLINE_DAYS, floor(timeDiff / SECONDS_PER_DAY))
	elseif timeDiff < SECONDS_PER_YEAR then
		return format(LASTONLINE_MONTHS, floor(timeDiff / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, floor(timeDiff / SECONDS_PER_YEAR))
	end
end
----------------------------------------------------------------
function E:func_TableMerge(table1, table2)
	for k, v in pairs(table2) do
		local t1_val = table1[k]
		local t2_type = type(v)
		if t1_val == nil or type(t1_val) ~= t2_type then
			table1[k] = v
		elseif t2_type == "table" then
			E:func_TableMerge(t1_val, v)-- Рекурсивный вызов вместо MergeTable
		end
	end
	return table1
end
----------------------------------------------------------------
function E:func_TableConcat(table1, table2)
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
----------------------------------------------------------------
function E:func_MergeTableSFMICTpairs(table1, table2)
	for k, v in pairs(table2) do
		table1[k] = v
	end
	return table1
end
----------------------------------------------------------------
function E:func_tinsertGPTipairs(table1, table2)
	for _, value in ipairs(table2) do
		table.insert(table1, value)
	end
end
-- function E:func_TableConcat(table1, table2)
-- for i = 1, #table2 do
-- table1[#table1+1] = table2[i]
-- end
-- return table1
-- end
----------------------------------------------------------------
function E:func_TableRemoveDuplicates(table1)
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
-- function E:func_TableRemoveDuplicates(table1)
-- if type(table1) ~= "table" then
-- table1 = {}
-- end
-- local table2 = {}
-- local i = 1
-- while table1[i] do
-- local value = table1[i]
-- if table2[value] then
-- tremove(table1, i)
-- else
-- i = i + 1
-- end
-- table2[value] = true
-- end
-- end
----------------------------------------------------------------
function E:func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end-- Проверка на пустую строку
	-- Получаем цвет и сразу конвертируем в hex
	return E:func_rgb2hex(fontstring:GetTextColor())..text.."|r"
end
----------------------------------------------------------------
function E:func_SetBackdrop(frame, hexcolor, BackdropAlpha, edgeAlpha)
	-- Предварительная обработка параметров
	edgeAlpha = edgeAlpha or 1
	local bgCr, bgCg, bgCb = E.bgCr, E.bgCg, E.bgCb
	local bgCa = BackdropAlpha or E.bgCa
	-- Обработка цвета, если он передан
	if hexcolor then
		bgCr, bgCg, bgCb = self.func_hex2rgbNUMBER(hexcolor)
	end
	-- Установка фрейма
	frame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0},
	})
	-- Сохранение цветов во фрейме
	frame.r, frame.g, frame.b, frame.a = bgCr, bgCg, bgCb, bgCa
	frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
	-- Если фрейм еще не инициализирован
	if not frame.isInit then
		frame.isInit = true
		-- Общие обработчики событий
		frame:HookScript("OnEnter", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, self.a)
				self:SetBackdropBorderColor(r, g, b, 1)
		end)
		frame:HookScript("OnLeave", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, self.a)
				self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		end)
		-- Дополнительные обработчики для фреймов с иконкой
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
					self.icon:SetVertexColor(r, g, b, 1)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
			end)
		end
	end
end
----------------------------------------------------------------
function E:func_CreateUtilsButton(frame, title, height, indent)
	local curHeight = height
	local indent = indent or 0
	local mediaPath = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\"
	-- Helper function to create consistent buttons
	local function CreateUtilButton(name, relativeTo, xOffset, texture, tooltip, onClick)
		local button = CreateFrame("Button", name, frame)
		button:SetSize(curHeight, curHeight)
		button:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", xOffset, indent)
		if tooltip then
			button:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddLine(E.WOW_Artifact_Color..tooltip.."|r")
					GameTooltip:Show()
			end)
			button:SetScript("OnLeave", GameTooltip_Hide)
		end
		if onClick then
			button:SetScript("OnClick", onClick)
		end
		if texture then
			button.icon = button:CreateTexture(nil, "BACKGROUND")
			button.icon:SetTexture(texture)
			button.icon:SetAllPoints()
		end
		return button
	end
	-- Close Button
	CreateUtilButton(
		"Octo_CloseButton",
		frame,
		0,
		mediaPath.."CloseTest.tga",
		CLOSE,
		function() frame:Hide() end
	)
	-- Options Button
	CreateUtilButton(
		"Octo_OptionsButton",
		frame,
		-curHeight,
		mediaPath.."IconTexture\\"..title,
		OPTIONS,
		function()
			if frame and frame:IsShown() then
				frame:Hide()
			end
			if SettingsPanel:IsVisible() and frame:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(E:func_AddonTitle(E.GlobalAddonName), true)
			end
		end
	)
	-- Abandon Button
	local function f_AbandonQuests()
		local numQuests = E:func_CurrentNumQuests()
		for i = 1, GetNumQuestLogEntries() do
			if numQuests ~= 0 then
				local info = GetInfo(i)
				if info and not info.isHeader and not info.isHidden then
					DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Abandon: "])..E:func_questName(info.questID))
					SetSelectedQuest(info.questID)
					SetAbandonQuest()
					AbandonQuest()
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.WOW_Artifact_Color..L["Abandon All Quests"].."?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function() C_Timer.After(1, f_AbandonQuests) end,
	}
	local Octo_AbandonButton = CreateUtilButton(
		"Octo_AbandonButton",
		frame,
		-curHeight*2,
		mediaPath.."Arrow72.tga"
	)
	Octo_AbandonButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			local numQuests = E:func_CurrentNumQuests()
			if numQuests > 0 then
				GameTooltip:AddLine(E.WOW_Artifact_Color..L["Abandon All Quests"].."|r".." ("..numQuests..")")
				GameTooltip:AddLine(" ")
				local list = {}
				for i = 1, GetNumQuestLogEntries() do
					local info = GetInfo(i)
					if info and info.questID ~= 0 and not info.isHeader and not info.isHidden then
						table_insert(list, info.questID)
					end
				end
				sort(list, E.func_Reverse_order)
				for _, questID in ipairs(list) do
					GameTooltip:AddDoubleLine(E:func_questName(questID), E:func_CheckCompletedByQuestID(questID), 1, 1, 1, 1, 1, 1)
				end
			else
				GameTooltip:AddLine(L["No quests"], r, g, b)
			end
			GameTooltip:Show()
	end)
	Octo_AbandonButton:SetScript("OnLeave", GameTooltip_Hide)
	Octo_AbandonButton:SetScript("OnClick", function()
			if E:func_CurrentNumQuests() > 0 then
				StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
			end
	end)
	-- Events Button
	local Octo_EventsButton = CreateUtilButton("Octo_EventsButton", frame, -curHeight*3, mediaPath.."Arrow6.tga")
	Octo_EventsButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			local curdatetable = date("*t")
			local curdate = FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year)
			GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..L["Current Date"].."|r", E.WOW_Artifact_Color..curdate.."|r")
			GameTooltip:AddDoubleLine(" ", " ")
			local sorted = {}
			for k in pairs(E.Holiday) do
				table_insert(sorted, k)
			end
			sort(sorted, function(a, b)
					return E.Holiday[a].priority < E.Holiday[b].priority
			end)
			for _, eventID in ipairs(sorted) do
				local v = E.Holiday[eventID]
				local titleText = v.invitedBy..E:func_texturefromIconEVENT(v.iconTexture)
				local timeText = v.startTime.." - "..v.endTime
				if v.Active then
					titleText = titleText..E.Green_Color..v.title.."|r"..E.White_Color.." ("..v.ENDS..")|r"
					timeText = E.Green_Color..timeText.."|r"
				else
					titleText = titleText..E.Gray_Color..v.title.."|r"
					timeText = E.Gray_Color..timeText.."|r"
				end
				if E.DebugIDs then
					titleText = titleText..E.Gray_Color.." id:"..eventID.."|r"
				end
				GameTooltip:AddDoubleLine(titleText, timeText)
			end
			if #sorted == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	Octo_EventsButton:SetScript("OnLeave", GameTooltip_Hide)
	Octo_EventsButton:SetScript("OnClick", function()
			frame:Hide()
			if fpde then
				fpde(E.Holiday)
			end
	end)
	-- Framerate Frame
	local Octo_FramerateFrame = CreateFrame("Frame", "Octo_FramerateFrame", frame)
	Octo_FramerateFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -curHeight*4, indent)
	Octo_FramerateFrame:SetSize(curHeight*2, curHeight)
	Octo_FramerateFrame:SetFrameStrata("HIGH")
	local text_fps = Octo_FramerateFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text_fps:SetPoint("CENTER")
	text_fps:SetFontObject(OctoFont11)
	text_fps:SetJustifyH("CENTER")
	text_fps:SetTextColor(0.31, 1, 0.47, 1)
	Octo_FramerateFrame.text_fps = text_fps
	C_Timer.NewTicker(1, function()
			text_fps:SetText(math_floor(GetFramerate()))
	end)
end
----------------------------------------------------------------
function E:func_CreateMinimapButton(addonName, title, vars, frame, func, frameString)
	local MinimapName = E:func_AddonTitle(E.GlobalAddonName).." » "..title
	local info = {
		type = "data source",
		text = MinimapName,
		icon = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\IconTexture\\"..title,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
			GameTooltip_SetTitle(GameTooltip, MinimapName)
			GameTooltip:Show()
		end,
		OnLeave = function()
			GameTooltip:Hide()
		end,
	}
	info.OnClick = function(_, button)
		if button == "LeftButton" then
			if not InCombatLockdown() then
				if func then
					func()
				end
				if frame then
					if not frame.insertIn_SecuredFrames_SequredFrames then
						frame.insertIn_SecuredFrames_SequredFrames = true
						tinsert(UISpecialFrames, frameString)
						tinsert(E.OctoTable_Frames, frame)
					end
					for index, frames in ipairs(E.OctoTable_Frames) do
						if frame ~= frames and frames:IsShown() then
							frames:Hide()
						end
					end
					frame:SetShown(not frame:IsShown())
				end
				if SettingsPanel:IsVisible() and frame:IsVisible() then
					HideUIPanel(SettingsPanel)
				end
				if GameMenuFrame:IsVisible() and frame:IsVisible() then
					HideUIPanel(GameMenuFrame)
				end
			end
		elseif button == "RightButton" then
			if frame and frame:IsShown() then
				frame:Hide()
			end
			if SettingsPanel:IsVisible() and frame:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(E:func_AddonTitle(E.GlobalAddonName), true)
			end
		end
	end
	vars.minimapPos = vars.minimapPos or 244
	local ldb_icon = LibDataBroker:NewDataObject(MinimapName, info)
	LibDBIcon:Register(MinimapName, ldb_icon, vars.minimap)
	LibDBIcon:Show(MinimapName)
end
----------------------------------------------------------------
function E:func_TooltipOnEnter(frame, first, second)
	local tooltip = frame.tooltip
	if not tooltip or #tooltip == 0 then return end
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	if first then GameTooltip:AddLine(" ") end
	for _, value in ipairs(tooltip) do
		GameTooltip:AddDoubleLine(tostring(value[1]), tostring(value[2]), 1, 1, 1, 1, 1, 1)
	end
	if second then GameTooltip:AddLine(" ") end
	GameTooltip:Show()
end
----------------------------------------------------------------
function E:func_fixdate(date)
	-- GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..(L["Current Date"]).."|r", E.WOW_Artifact_Color..(date("%d/%m/%Y").."|r"))
	-- local curdate = (FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year))
	local vivod = ("%.2d"):format(date)
	--return format("%.2d", date)
	return vivod
end
----------------------------------------------------------------
-- ПОФИКСИТЬ 61304 это заклиание ГКД
function E:func_IsAvailable(id, curType)
	if id and curType then
		if curType == "spell" and IsSpellKnown(id) then
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
----------------------------------------------------------------
function E:func_IsOnCD(id, curType)
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
-- /dump PlayerHasToy(172924)
function E:FrameColor(frame, id, curType)
	if E:func_IsAvailable(id, curType) == false then
		frame:SetBackdropBorderColor(0, 0, 0, .5)
		frame.icon:SetVertexColor(1, 1, 1, .5)
		frame.icon:SetDesaturated(true)
	else
		if E:func_IsOnCD(id, curType) == true then
			frame.icon:SetVertexColor(1, 0, 0, 1)
		else
			frame.icon:SetVertexColor(1, 1, 1, 1)
		end
	end
end
----------------------------------------------------------------
function E:CreateUsableSpellFrame(id, point, parent, rPoint, x, y, size, curType)
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
			frame.icon:SetTexture(E:func_GetItemIconByID(id))
		else
			frame.icon:SetTexture(E:func_GetSpellIcon(id))
		end
		frame.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame:SetBackdrop({
				bgFile = E.bgFile,
				edgeFile = E.edgeFile,
				edgeSize = 1,
				insets = {left = 0, right = 0, top = 0, bottom = 0},
		})
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
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
					E:FrameColor(self, id, curType)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E:func_GetItemNameByID(id), E:func_SecondsToClock(E:func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E:func_GetSpellName(id), E:func_SecondsToClock(E:func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E:func_GetSpellSubtext(id))
					end
					GameTooltip:Show()
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
		end
	end
end
----------------------------------------------------------------
function E:func_RegisterMyEventsToFrames(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or UNKNOWN
	local DebugPath = STR:gsub("]", "")
	----------------------------------------------------------------
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event, ...)
			if self[event] then
				self[event](self, ...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.KILLTEXT.. E.Event_Color..event.."|r"..E.KILLTEXT..tostring(DebugPath))
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
----------------------------------------------------------------
function E:func_Reason(reason)
	local vivod = ""
	if reason == "CORRUPT" then vivod = ADDON_CORRUPT end
	if reason == "DEMAND_LOADED" then vivod = ADDON_DEMAND_LOADED end
	if reason == "DEP_BANNED" then vivod = ADDON_DEP_BANNED end
	if reason == "DEP_CORRUPT" then vivod = ADDON_DEP_CORRUPT end
	if reason == "DEP_DEMAND_LOADED" then vivod = ADDON_DEP_DEMAND_LOADED end
	if reason == "DEP_DISABLED" then vivod = ADDON_DEP_DISABLED end
	if reason == "DEP_EXCLUDED_FROM_BUILD" then vivod = ADDON_DEP_EXCLUDED_FROM_BUILD end
	if reason == "DEP_INSECURE" then vivod = ADDON_DEP_INSECURE end
	if reason == "DEP_INTERFACE_VERSION" then vivod = ADDON_DEP_INTERFACE_VERSION end
	if reason == "DEP_LOADABLE" then vivod = ADDON_DEP_LOADABLE end
	if reason == "DEP_MISSING" then vivod = ADDON_DEP_MISSING end
	if reason == "DEP_NO_ACTIVE_INTERFACE" then vivod = ADDON_DEP_NO_ACTIVE_INTERFACE end
	if reason == "DEP_NOT_AVAILABLE" then vivod = ADDON_DEP_NOT_AVAILABLE end
	if reason == "DEP_USER_ADDONS_DISABLED" then vivod = ADDON_DEP_USER_ADDONS_DISABLED end
	if reason == "DEP_WRONG_ACTIVE_INTERFACE" then vivod = ADDON_DEP_WRONG_ACTIVE_INTERFACE end
	if reason == "DEP_WRONG_GAME_TYPE" then vivod = ADDON_DEP_WRONG_GAME_TYPE end
	if reason == "DEP_WRONG_LOAD_PHASE" then vivod = ADDON_DEP_WRONG_LOAD_PHASE end
	if reason == "EXCLUDED_FROM_BUILD" then vivod = ADDON_EXCLUDED_FROM_BUILD end
	if reason == "INSECURE" then vivod = ADDON_INSECURE end
	if reason == "INTERFACE_VERSION" then vivod = ADDON_INTERFACE_VERSION end
	if reason == "MISSING" then vivod = ADDON_MISSING end
	if reason == "NO_ACTIVE_INTERFACE" then vivod = ADDON_NO_ACTIVE_INTERFACE end
	if reason == "NOT_AVAILABLE" then vivod = ADDON_NOT_AVAILABLE end
	if reason == "USER_ADDONS_DISABLED" then vivod = ADDON_USER_ADDONS_DISABLED end
	if reason == "WRONG_ACTIVE_INTERFACE" then vivod = ADDON_WRONG_ACTIVE_INTERFACE end
	if reason == "WRONG_GAME_TYPE" then vivod = ADDON_WRONG_GAME_TYPE end
	if reason == "WRONG_LOAD_PHASE" then vivod = ADDON_WRONG_LOAD_PHASE end
	return vivod
end
----------------------------------------------------------------
function E:func_CreateInfoFrame(text, point, parent, rPoint, x, y, sizeW, sizeH, JustifyH)
	local frame = CreateFrame("frame", nil, parent, "BackDropTemplate")
	frame:SetPoint(point, parent, rPoint, x, y)
	frame:SetSize(sizeW, sizeH)
	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.text:SetAllPoints()
	frame.text:SetFontObject(OctoFont11)
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetJustifyH(JustifyH)
	frame.text:SetTextColor(1, 1, 1, 1)
	return frame
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

----------------------------------------------------------------
local AddonManager = CreateFrame("Frame")
local profiles = {}
local currentProfile = "default"
function E:func_GetAddonIndex(name)
	local index = Octo_AddonsTable.indexByName[name]
	return tonumber(index)
end
function E:func_GetAddonName(index)
	local name = select(1, GetAddOnInfo(index))
	return name
end
function E:func_GetAddonTitle(index)
	local title = select(2, GetAddOnInfo(index))
	return title
end
function E:func_GetAddonNotes(index)
	local notes = select(2, GetAddOnInfo(index))
	return notes
end
function E:func_GetAddonReason(index, character)
	character = character or UnitName("player") -- ALL_CHARACTERS
	local reason = select(2, IsAddOnLoadable(index, character));
	return reason
end
function E:func_IsAddonInstalled(index) -- Исключаем отсутствующие аддоны
	local reason = select(5, GetAddOnInfo(index))
	return reason ~= "MISSING"
end
function E:func_GetAddonSecurity(index)
	local security = select(6, GetAddOnInfo(index))
	return security
end
function E:func_GetAddonUpdateAvailable(index)
	local updateAvailable = select(7, GetAddOnInfo(index))
	return updateAvailable
end
function E:func_GetAddonVersion(index)
	local Version = GetAddOnMetadata(index, "Version") or 0
	return Version
end
function E:func_GetAddonAuthor(index)
	local Author = GetAddOnMetadata(index, "Author") or ""
	return Author
end
function E:func_GetAddoniconTexture(index)
	local iconTexture = GetAddOnMetadata(index, "IconTexture")
	return iconTexture
end
function E:func_GetAddoniconAtlas(index)
	local iconAtlas = GetAddOnMetadata(index, "IconAtlas")
	return iconAtlas
end
function E:func_GetAddonCategory(index)
	local Category = GetAddOnMetadata(index, "Category")
	return Category
end
function E:func_GetAddonGroup(index)
	local Group = GetAddOnMetadata(index, "Group")
	return Group
end
function E:func_GetAddOnEnableState(i, character)
	character = character or UnitName("player") -- ALL_CHARACTERS
	return GetAddOnEnableState(i, character)
end
function E:func_IsAddOnLoadable(index, character)
	local loadable = select(1, IsAddOnLoadable(index, character)) -- reason 2
	return loadable
end
function E:func_DoesAddOnExist(index)
	return DoesAddOnExist(index)
end
function E:func_IsAddOnDefaultEnabled(index)
	return IsAddOnDefaultEnabled(index)
end
function E:func_GetAddOnDependenciesTable(index)
	return {GetAddOnDependencies(index)}
end
function E:func_GetAddOnDependenciesSTR(index)
	return GetAddOnDependencies(index)
end
function E:func_GetNumReps()
	local LineNumber = 0
	ExpandAllFactionHeaders()
	for i = 1, GetNumFactions() do
		local factionData = GetFactionDataByIndex(i)
		if factionData then
			if (factionData.isHeaderWithRep or not factionData.isHeader) then
				LineNumber = LineNumber + 1
			end
		end
	end
	return LineNumber
end
function E:func_GetNumAddOns()
	return GetNumAddOns()
end
function E:func_EnableAddOn(name, character)
	character = character or UnitName("player") -- ALL_CHARACTERS
	return EnableAddOn(name, character)
end
function E:func_EnableAllAddOns(character) -- Включить все аддоны
	character = character or UnitName("player") -- ALL_CHARACTERS
	return EnableAllAddOns(character)
end
function E:func_DisableAddOn(name, character)
	character = character or UnitName("player") -- ALL_CHARACTERS
	return DisableAddOn(name, character)
end
function E:func_DisableAllAddons()
	for index, name in ipairs(E:func_GetAllAddons()) do
		if not Octo_AddonsManager_DB.lock.addons[name] then
			E:func_DisableAddOn(index)
		end
	end
end
function E:func_IsProfilerEnabled()
	return IsEnabled()
end
function E:func_UpdatePerformance()
	if E:func_IsProfilerEnabled() then
		UpdateAddOnMemoryUsage()
		-- UpdateAddOnCPUUsage() -- НЕ РАБОТАЕТ?
	end
end
function E:func_IsAddonVersionCheckEnabled()
	return IsAddonVersionCheckEnabled()
end
function E:func_AddonList_HasOutOfDate()
	return AddonList_HasOutOfDate()
end
-- Получить список всех аддонов
function E:func_GetAllAddons()
	local addons = {}
	for index = 1, E:func_GetNumAddOns() do
		if E:func_IsAddonInstalled(index) then -- Исключаем отсутствующие аддоны
			table.insert(addons, E:func_GetAddonName(index))
		end
	end
	return addons
end
-- Показать список аддонов с их статусом
function E:func_ListAddons(filter)
	local addons = E:func_GetAllAddons()
	DEFAULT_CHAT_FRAME:AddMessage("Список аддонов ("..#addons.."):")
	for index, name in ipairs(addons) do
		if not filter or string.find(string_lower(name), string_lower(filter)) then
			local status = E:func_IsAddOnLoaded(index) and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r"
			DEFAULT_CHAT_FRAME:AddMessage(string_format("%3d. %s - %s", index, name, status))
		end
	end
end
function E:func_AddonListEntry_SetEnabled(index, character, enabled)
	if enabled == nil then
		enabled = IsAddOnDefaultEnabled(index)
	end
	if enabled then
		E:func_EnableAddOn(index, character)
	else
		E:func_DisableAddOn(index, character)
	end
end
function E:func_AddonList_HasAnyChanged()
	if (AddonList.outOfDate and not E:func_IsAddonVersionCheckEnabled() or (not AddonList.outOfDate and E:func_IsAddonVersionCheckEnabled() and E:func_AddonList_HasOutOfDate())) then
		return true
	end
	for i=1,E:func_GetNumAddOns() do
		local character = nil
		character = UnitName("player")
		local enabled = (E:func_GetAddOnEnableState(i, character) > Enum.AddOnEnableState.None)
		if ( enabled ~= AddonList.startStatus[i] and E:func_GetAddonReason(i) ~= "DEP_DISABLED" ) then
			return true
		end
	end
	return false
end
function E:func_AddonTooltipBuildDepsString(index, color)
	color = color or "|cff000000"
	local deps = E:func_GetAddOnDependenciesTable(index)
	local depsString = ""
	for i, name in ipairs(deps) do
		if i == 1 then
			depsString = "Родители:|n" -- ADDON_DEPENDENCIES
		end
		depsString = depsString..color..""..(name).."|r|n"
	end
	return depsString
end
function E:func_IsAddonSelected(nameOrIndex, forSome, charGuid)
	if (forSome) then
		local state = E:func_GetAddOnEnableState(nameOrIndex, nil)
		return state == 1
	end
	-- local guid = charGuid or E:func_GetSelectedCharGuid()
	-- if (charGuid == true) then
	-- guid = nil
	-- end
	local state = E:func_GetAddOnEnableState(nameOrIndex, guid)
	return state == 2
end
-- function E:func_GetSelectedCharGuid()
-- if (selectedCharIndex >= 1) then return orderedCharList[selectedCharIndex + 1].guid end
-- return nil
-- end
function E:func_LocalizeCategoryName(name, isUserCategory)
	if (isUserCategory) then
		return name
	end
	return rawget(L, string_lower(name)) or name
end
function E:func_GetCategoryTables()
	local db = self:GetDb()
	local userCategories = db.categories
	local tocCategories = categoryTocTable
	return userCategories, tocCategories, fixedCategories
end
function E:func_CategoriesForAddon(name)
	local userTable, tocTable, fixedTable = E:func_GetCategoryTables()
	local resultText = ""
	local sep = ""
	for _, categoryTable in pairs(userTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText..sep..E:func_LocalizeCategoryName(categoryTable.name, userTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(tocTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText..sep..E:func_LocalizeCategoryName(categoryTable.name, tocTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(fixedTable) do
		if (categoryTable.prepare) then categoryTable:prepare() end
		if (categoryTable:addons(name)) then
			resultText = resultText..sep..categoryTable.name
			sep = ", "
		end
	end
	return resultText
end
function E:func_rec_toggle(index, state)
	if state then
		E:func_DisableAddOn(index)
	else
		E:func_EnableAddOn(index)
	end
	if Octo_AddonsTable.depsByIndex[index] and not IsModifierKeyDown() and not Octo_AddonsTable.recycleByIndex[index] then
		for i, depIndex in ipairs(Octo_AddonsTable.depsByIndex[index]) do
			E:func_rec_toggle(depIndex, state)
		end
	end
end
-- Переключить аддон
function E:func_ToggleAddon(index, state)
	local addonName = GetAddOnInfo(index)
	local enabled = E:func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E:func_rec_toggle(index, enabled)
end
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
function E:func_LockAddon(index)
	local name = E:func_GetAddonName(index)
	if Octo_AddonsManager_DB.lock.addons[name] then
		Octo_AddonsManager_DB.lock.addons[name] = false
	else
		Octo_AddonsManager_DB.lock.addons[name] = true
		-- E:func_EnableAddOn(index)
	end
end
function E:func_rec_lock(index)
	E:func_LockAddon(index)
	if Octo_AddonsTable.depsByIndex[index] and not IsModifierKeyDown() then
		for i, depIndex in ipairs(Octo_AddonsTable.depsByIndex[index]) do
			E:func_rec_lock(depIndex)
		end
	end
end
-- Переключить аддон
function E:func_lockAddonNEW(index, state)
	local addonName = GetAddOnInfo(index)
	local enabled = E:func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E:func_rec_lock(index, enabled)
end
-- Сохранить текущий профиль
function E:func_SaveProfile(profileName)
	if not profileName or profileName == "" then
		profileName = currentProfile
	end
	Octo_AddonsManager_DB.profiles[profileName] = {}
	local addons = E:func_GetAllAddons()
	for index, name in ipairs(addons) do
		-- Octo_AddonsManager_DB.profiles[profileName][name] = E:func_IsAddOnLoaded(index)
		local loadable = E:func_IsAddOnLoadable(index, character)
		local reason = E:func_GetAddonReason(index, character) or ""
		if loadable or reason == "DEMAND_LOADED" or reason == "DEP_DEMAND_LOADED" then
			Octo_AddonsManager_DB.profiles[profileName][name] = true
		else
			Octo_AddonsManager_DB.profiles[profileName][name] = false
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("Профиль '"..profileName.." сохранен ("..#addons.." аддонов)")
end
-- Загрузить профиль
function E:func_LoadProfile(profileName)
	if not Octo_AddonsManager_DB.profiles[profileName] then
		DEFAULT_CHAT_FRAME:AddMessage("Профиль '"..profileName.." не найден")
		return
	end
	for name, enabled in pairs(Octo_AddonsManager_DB.profiles[profileName]) do
		if enabled then
			E:func_EnableAddOn(name)
		else
			E:func_DisableAddOn(name)
		end
	end
	currentProfile = profileName
	DEFAULT_CHAT_FRAME:AddMessage("Профиль '"..profileName.." загружен")
end
-- Список профилей
function E:func_ListProfiles()
	DEFAULT_CHAT_FRAME:AddMessage("Доступные профили:")
	for name, _ in pairs(Octo_AddonsManager_DB.profiles) do
		DEFAULT_CHAT_FRAME:AddMessage("- "..name)
	end
end
-- Обработчик команд
local function func_HandleCommand(msg)
	local command, arg1, arg2 = strsplit(" ", msg, 3)
	if command == "list" then
		E:func_ListAddons(arg1)
	elseif command == "toggle" then
		E:func_ToggleAddon(arg1)
	elseif command == "enableall" then
		E:func_EnableAllAddOns()
	elseif command == "disableall" then
		E:func_DisableAllAddons()
	elseif command == "save" then
		E:func_SaveProfile(arg1)
	elseif command == "load" then
		E:func_LoadProfile(arg1)
	elseif command == "profiles" then
		E:func_ListProfiles()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Команды:")
		DEFAULT_CHAT_FRAME:AddMessage("/uam list [фильтр] - список аддонов")
		DEFAULT_CHAT_FRAME:AddMessage("/uam toggle <имя/номер> - переключить аддон")
		DEFAULT_CHAT_FRAME:AddMessage("/uam enableall - включить все аддоны")
		DEFAULT_CHAT_FRAME:AddMessage("/uam disableall - выключить все аддоны")
		DEFAULT_CHAT_FRAME:AddMessage("/uam save [профиль] - сохранить текущие настройки")
		DEFAULT_CHAT_FRAME:AddMessage("/uam load <профиль> - загрузить профиль")
		DEFAULT_CHAT_FRAME:AddMessage("/uam profiles - список профилей")
	end
end
-- Инициализация при загрузке
-- Регистрируем команды
SLASH_UNIVERSALADDONMANAGER1 = "/uam"
SlashCmdList["UNIVERSALADDONMANAGER"] = func_HandleCommand
function E:func_GetAddonMetricPercent(addonName, metric, warningInLeftSide, def)
	if (not E:func_IsProfilerEnabled()) then
		return def or ""
	end
	local overall = GetOverallMetric(metric)
	local addon = GetAddOnMetric(addonName, metric)
	local relative = overall
	if GetApplicationMetric then
		local app = GetApplicationMetric(metric)
		relative = app - overall + addon
	end
	if relative <= 0 then
		return def or ""
	end
	local percent = addon / relative
	if (warningInLeftSide) then
		return E:func_GetWarningFor(percent)..E:func_FormatProfilerPercent(percent * 100.0)
	end
	return E:func_FormatProfilerPercent(percent * 100.0)..E:func_GetWarningFor(percent)
end
----------------------------------------------------------------
function E:func_FormatProfilerPercent(pct)
	local color = E.White_Color
	if (pct > 25) then color = E.Yellow_Color end
	if (pct > 50) then color = E.Orange_Color end
	if (pct > 80) then color = E.Red_Color end
	local vivod = string_format("%.2f", pct)
	return vivod
	-- return color:WrapText(string_format("%.2f", pct))..E.White_Color:WrapText("%")
end
----------------------------------------------------------------
function E:func_GetCVarNumber(name)
	-- if the CVar doesn't exist, the GetCVar returns "nothing" (not even nil) and the tonumber fails
	local number = tonumber(GetCVar(name) or nil)
	return number or tonumber(GetCVarDefault(name) or nil)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_GetWarningFor(percent)
	local warningPercent = E:func_GetCVarNumber("addonPerformanceMsgWarning") or -1
	if (warningPercent > 0.0 and warningPercent < 1.0 and percent > warningPercent) then
		return " "..CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16)
	end
	return ""
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_GetAddonMetricCount(addonName, metric)
	if (not E:func_IsProfilerEnabled()) then
		return ""
	end
	local count = GetAddOnMetric(addonName, metric) or 0
	return count
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E:func_CompactMemory(memory)
-- if memory > 0 then
-- if memory > 1024 then
-- return string_format(ADDON_LIST_PERFORMANCE_MEMORY_MB, memory/1024)
-- else
-- return string_format(ADDON_LIST_PERFORMANCE_MEMORY_KB, memory)
-- end
-- else
-- return 0
-- end
-- end
----------------------------------------------------------------
function E:func_AddonTooltip_BuildDeps(...)
	local deps = ""
	for i=1, select("#", ...) do
		if i == 1 then
			deps = ADDON_DEPENDENCIES..select(i, ...)
		else
			deps = deps..", "..select(i, ...)
		end
	end
	return deps
end
----------------------------------------------------------------
function E:func_AddonList_IsAddOnLoadOnDemand(index)
	local lod = false
	if IsAddOnLoadOnDemand(index) then
		local deps = E:func_GetAddOnDependenciesSTR(index)
		local okay = true
		for i = 1, select('#', deps) do
			local dep = select(i, deps)
			if ( dep and not E:func_IsAddOnLoaded(select(i, deps)) ) then
				okay = false
				break
			end
		end
		lod = okay
	end
	return lod
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_NumPlayers()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = Octo_ToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local sorted = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			if E.curGUID == GUID then
				sorted[#sorted+1] = CharInfo
			end
			local isShownPLAYER = CharInfo.PlayerData.isShownPLAYER --or false
			local UnitLevel = CharInfo.PlayerData.UnitLevel --or 0
			local BattleTagLocal = CharInfo.PlayerData.BattleTagLocal
			local curServer = CharInfo.PlayerData.curServer
			local Faction = CharInfo.PlayerData.Faction --or "Horde"
			if isShownPLAYER and UnitLevel and BattleTagLocal and curServer and Faction and E.curGUID ~= GUID then
				if not OnlyCurrentFaction or (OnlyCurrentFaction and Faction == E.curFaction) then
					if ShowOnlyCurrentBattleTag then
						if (ShowOnlyCurrentServer and curServer == E.curServer or not ShowOnlyCurrentServer)
						and BattleTagLocal == E.BattleTagLocal
						and UnitLevel >= LevelToShow
						and UnitLevel <= LevelToShowMAX then
							sorted[#sorted+1] = CharInfo
						end
					else
						if (ShowOnlyCurrentServer and curServer == E.curServer or not ShowOnlyCurrentServer)
						and UnitLevel >= LevelToShow
						and UnitLevel <= LevelToShowMAX then
							sorted[#sorted+1] = CharInfo
						end
					end
				end
			end
		end
	end
	return #sorted or 1
end
function E:func_sorted()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = Octo_ToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local sorted = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			if E.curGUID == GUID then
				sorted[#sorted+1] = CharInfo
			end
			local isShownPLAYER = CharInfo.PlayerData.isShownPLAYER --or false
			local UnitLevel = CharInfo.PlayerData.UnitLevel --or 0
			local BattleTagLocal = CharInfo.PlayerData.BattleTagLocal
			local curServer = CharInfo.PlayerData.curServer
			local Faction = CharInfo.PlayerData.Faction --or "Horde"
			if isShownPLAYER and UnitLevel and BattleTagLocal and curServer and Faction and E.curGUID ~= GUID then
				if not OnlyCurrentFaction or (OnlyCurrentFaction and Faction == E.curFaction) then
					if ShowOnlyCurrentBattleTag then
						if (ShowOnlyCurrentServer and curServer == E.curServer or not ShowOnlyCurrentServer)
						and BattleTagLocal == E.BattleTagLocal
						and UnitLevel >= LevelToShow
						and UnitLevel <= LevelToShowMAX
						then
							sorted[#sorted+1] = CharInfo
						end
					else
						if (ShowOnlyCurrentServer and curServer == E.curServer or not ShowOnlyCurrentServer)
						and UnitLevel >= LevelToShow
						and UnitLevel <= LevelToShowMAX
						then
							sorted[#sorted+1] = CharInfo
						end
					end
				end
			end
		end
		sort(sorted, function(a, b)
				if not a or not b then return false end
				local a_UnitLevel = a.PlayerData.UnitLevel or 0
				local b_UnitLevel = b.PlayerData.UnitLevel or 0
				local a_avgItemLevel = a.PlayerData.avgItemLevel or 0
				local b_avgItemLevel = b.PlayerData.avgItemLevel or 0
				local a_Name = a.PlayerData.Name or "noname"
				local b_Name = b.PlayerData.Name or "noname"
				-- Сначала сортируем по серверу (в алфавитном порядке)
				-- if a.PlayerData.curServer ~= b.PlayerData.curServer then
				-- return a.PlayerData.curServer < b.PlayerData.curServer
				-- end
				-- Затем по уровню (по убыванию)
				if a_UnitLevel ~= b_UnitLevel then
					return a_UnitLevel > b_UnitLevel
				end
				-- Затем по уровню предметов (по убыванию) -- avgItemLevelEquipped
				if a_avgItemLevel ~= b_avgItemLevel then
					return a_avgItemLevel > b_avgItemLevel
				end
				-- В конце по имени (по возрастанию)
				return a_Name < b_Name
		end)
	end
	return sorted
end
----------------------------------------------------------------
----------------------------------------------------------------
-- 2 Операции с таблицами:
-- Предварительное выделение памяти:
local function CreateTable(size)
	local t = {}
	for i = 1, size do t[i] = 0 end
	return t
end
----------------------------------------------------------------
-- 3 Сборка строк:
-- Использование table_concat для множественных конкатенаций:
local function BuildString(parts)
	local t = {}
	for i, part in ipairs(parts) do
		t[i] = tostring(part)
	end
	return table_concat(t)
end
----------------------------------------------------------------
-- 4 Создание фреймов:
-- Переиспользование шаблонов фреймов:
local function CreateOptimizedFrame(parent)
	if not E.framePool then
		E.framePool = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		-- Настройка общих свойств
	end
	return E.framePool
end
----------------------------------------------------------------
-- 5 Оптимизация подсказок:
-- Переиспользование объекта подсказки:
function E:func_ShowTooltip(...)
	tooltip:ClearLines()
	-- Добавление строк
	tooltip:Show()
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_Universal(tbl, expansionID)
	if not tbl then return end
	if not Octo_ToDo_DB_Vars.Quests then return end
	for expID, expDATA in ipairs(E.OctoTable_Expansions) do
		if expID == expansionID then
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if expDATA.nameShort == v.desc then
					table.insert(tbl, function(CharInfo)
							----------------------------------------------------------------
							local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT = "", nil, nil, "", {}, nil, {}
							----------------------------------------------------------------
							local LeftData = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							if LeftData then
								local max = v.max
								if type(LeftData) == "number" and max then
									if LeftData < max then
										textCENT = LeftData.."/"..max
									elseif LeftData >= max then
										textCENT = E.DONE
									else
										textCENT = E.DONE
									end
								elseif max ~= 1 then
									textCENT = "0/"..max
								elseif type(LeftData) == "string" then
									textCENT = LeftData
								end
								if CharInfo.PlayerData.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E:func_questName(questID), E:func_CheckCompletedByQuestID(questID)}
									end
								end
							end
							----------------------------------------------------------------
							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = expDATA.color
							----------------------------------------------------------------
							return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT
							----------------------------------------------------------------
					end)
				end
			end
		end
	end
end
----------------------------------------------------------------
function E:func_Universal_Holiday(tbl, Holiday, color)
	if not tbl then return end
	for _, v in ipairs(E.OctoTable_UniversalQuest) do
		if v.desc == Holiday then
			table.insert(tbl, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT = "", nil, nil, "", {}, nil, {}
					----------------------------------------------------------------
					local LeftData = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
					if LeftData then
						local max = v.max
						if type(LeftData) == "number" and max then
							if LeftData < max then
								textCENT = LeftData.."/"..max
							elseif LeftData >= max then
								textCENT = E.DONE
							else
								textCENT = E.DONE
							end
						elseif max ~= 1 then
							textCENT = "0/"..max
						elseif type(LeftData) == "string" then
							textCENT = LeftData
						end
						if CharInfo.PlayerData.GUID == E.curGUID then
							for index, questID in ipairs(v.questID) do
								tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E:func_questName(questID), E:func_CheckCompletedByQuestID(questID)}
							end
						end
					end
					----------------------------------------------------------------
					textLEFT = tostringall(v.textleft).."|r"
					iconLEFT = v.icon
					colorLEFT = color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, tooltipLEFT
					----------------------------------------------------------------
			end)
		end
	end
end
--------------------------------------------------------------
function E:func_tooltipCurrencyAllPlayers(typeQ, ID, iANIMA, kCovenant)
	----------------------------------------------------------------
	local tooltip = {}
	local total = 0
	local sorted = {}
	local hasTotal = false
	local sortedPlayersTBL = E:func_sorted()
	local visiblePlayers = {}
	local totalPersToShow = 30+2
	for _, charInfo in ipairs(sortedPlayersTBL) do
		visiblePlayers[charInfo.PlayerData.GUID] = true
	end
	----------------------------------------------------------------
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local specIcon, color, Name, RIGHT
		local curServer, curPers = "", ""
		if typeQ == "Currency" and CharInfo.MASLENGO.Currency[ID] and E:func_textCENT_Currency(CharInfo, ID) ~= "" then
			RIGHT = E:func_textCENT_Currency(CharInfo, ID)
			RIGHTforSORT = CharInfo.MASLENGO.Currency[ID].quantity or 0
			total = total + (CharInfo.MASLENGO.Currency[ID].quantity or 0)
		end
		-- if typeQ == "Currency" and CharInfo.MASLENGO.Currency[ID] and CharInfo.MASLENGO.Currency[ID].quantity then
		--     total = total + CharInfo.MASLENGO.Currency[ID].quantity
		--     if CharInfo.MASLENGO.Currency[ID].quantity then
		--         if CharInfo.MASLENGO.Currency[ID].maxQuantity and CharInfo.MASLENGO.Currency[ID].maxQuantity ~= 0 then
		--             -- RIGHT = CharInfo.MASLENGO.Currency[ID].quantity.."/"..CharInfo.MASLENGO.Currency[ID].maxQuantity
		--             hasTotal = true
		--         else
		--             -- RIGHT = CharInfo.MASLENGO.Currency[ID].quantity
		--         end
		--         RIGHTforSORT = CharInfo.MASLENGO.Currency[ID].quantity
		--     end
		-- end
		if typeQ == "Item" and CharInfo.MASLENGO.ItemsInBag[ID] then
			total = total + CharInfo.MASLENGO.ItemsInBag[ID]
			RIGHT = CharInfo.MASLENGO.ItemsInBag[ID]
			RIGHTforSORT = CharInfo.MASLENGO.ItemsInBag[ID]
		end
		if (typeQ == "Currency_Covenant_Anima" or typeQ == "Currency_Covenant_Renown") and CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] then
			total = total + CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
			RIGHT = CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
			RIGHTforSORT = CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
		end
		if RIGHT then
			specIcon = E:func_texturefromIcon(CharInfo.PlayerData.specIcon)
			colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.Gray_Color
			colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.Gray_Color
			-- color = CharInfo.PlayerData.isShownPLAYER and CharInfo.PlayerData.classColorHex or E.Gray_Color
			-- color = E.Gray_Color
			-- for CharIndex, CharInfo2 in ipairs(sortedPlayersTBL) do
			--     if CharInfo.PlayerData.GUID == CharInfo2.PlayerData.GUID then
			--         color = CharInfo.PlayerData.classColorHex
			--     end
			-- end
			Name = CharInfo.PlayerData.Name
			if CharInfo.PlayerData.GUID == E.curGUID then
				curPers = ">> "
			end
			if CharInfo.PlayerData.curServer ~= E.curServer then
				curServer = "-"..CharInfo.PlayerData.curServer
			end
			sorted[#sorted+1] = {curPers, specIcon, colorPlayer, Name, colorServer, curServer, RIGHT, RIGHTforSORT}
		end
	end
	----------------------------------------------------------------
	if hasTotal == true then
		local index = 1
		local info = sorted[index]
		while info do
			if type(info[7]) == "number" then
				table.remove(sorted, index)
			else
				index = index + 1
			end
			info = sorted[index]
		end
	end
	if total ~= 0 then
		sort(sorted, function(a, b)
				if a[8] == b[8] then
					return a[4] < b[4]
				end
				return a[8] > b[8]
		end)
		----------------------------------------------------------------
		if typeQ == "Currency" then
			-- tooltip[#tooltip+1] = {E:func_texturefromIcon(E:func_GetCurrencyIcon(ID)).." "..E:func_currencyName(ID), TOTAL..": "..total}
			tooltip[#tooltip+1] = {" ", TOTAL..": "..total}
			tooltip[#tooltip+1] = {" ", " "}
		end
		if typeQ == "Item" then
			tooltip[#tooltip+1] = {E:func_texturefromIcon(E:func_GetItemIconByID(ID)).." "..E:func_GetItemNameByID(ID), TOTAL..": "..total}
			tooltip[#tooltip+1] = {" ", " "}
		end
		if typeQ == "Currency_Covenant_Anima" then
			tooltip[#tooltip+1] = {E:func_texturefromIcon(E:func_GetCurrencyIcon(ID)).." "..E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r", total}
			tooltip[#tooltip+1] = {" ", " "}
		end
		if typeQ == "Currency_Covenant_Renown" then
			tooltip[#tooltip+1] = {E:func_texturefromIcon(E.OctoTable_Covenant[iANIMA].icon).." "..E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r", total}
			tooltip[#tooltip+1] = {" ", " "}
		end
		----------------------------------------------------------------
		for _, v in ipairs(sorted) do
			if #tooltip < totalPersToShow then
				tooltip[#tooltip+1] = {v[1].." "..v[2]..v[3]..v[4].."|r"..v[5]..v[6].."|r", v[7]}
			end
		end
		local hidden = #sorted - #tooltip
		if hidden > 0 then
			tooltip[#tooltip+1] = {E.Yellow_Color.."...(+|r" ..E.Red_Color.. hidden.."|r"..E.Yellow_Color..")|r", " "}
		end
	end
	----------------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_textCENT_Items(CharInfo, itemID, showIcon)
	if not itemID then return "" end
	showIcon = showIcon or false
	local vivod = ""
	if type(itemID) == "number" then
		vivod = vivod..(CharInfo.MASLENGO.ItemsInBag[itemID] or "")
	elseif type(itemID) == "table" then
		for _, v in ipairs(itemID) do
			vivod = vivod..(CharInfo.MASLENGO.ItemsInBag[v] or "")
		end
	end
	if showIcon and vivod ~= "" then
		vivod = " +"..vivod..E:func_texturefromIcon(E:func_GetItemIconByID(itemID))
	end
	return vivod
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_textCENT_Currency(CharInfo, currencyID, itemID)
	local data = CharInfo.MASLENGO.Currency
	if not data[currencyID] then return "" end
	local vivod = ""
	local color = E.White_Color
	if data[currencyID].quantity then
		vivod = vivod .. data[currencyID].quantity
		if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
			if data[currencyID].quantity == data[currencyID].maxQuantity then
				color = E.Green_Color
			end
			vivod = color..vivod .. "/" ..data[currencyID].maxQuantity.."|r"
		end
	end
	if data[currencyID].totalEarned and data[currencyID].maxQuantity then
		-- color = E.Green_Color
		local curQuantity = (data[currencyID].quantity or 0)
		vivod = data[currencyID].totalEarned
		vivod = " ("..vivod .. "/" ..data[currencyID].maxQuantity..")"
		vivod = color.. curQuantity.. vivod .. "|r"
	end
	-- if data[currencyID].maxQuantity then
	--     vivod = vivod .. E.Purple_Color.. "/" ..data[currencyID].maxQuantity.."|r"
	-- end
	--     vivod = data[currencyID].quantity
	--     if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
	--         vivod = vivod.."/"..data[currencyID].maxQuantity
	--     end
	-- elseif data[currencyID].quantity and data[currencyID].maxQuantity and data[currencyID].totalEarned and (data[currencyID].maxQuantity ~= data[currencyID].totalEarned) then
	--     vivod = E.Purple_Color..data[currencyID].quantity.."|r (" .. data[currencyID].maxQuantity .. "/" ..data[currencyID].totalEarned..")"
	-- elseif not data[currencyID].quantity and data[currencyID].maxQuantity and data[currencyID].totalEarned and (data[currencyID].maxQuantity == data[currencyID].totalEarned) then
	--     vivod = E.Red_Color.."can't earn|r" -- CURRENCY_SEASON_TOTAL_MAXIMUM:format(0, data[currencyID].maxQuantity, data[currencyID].totalEarned)
	-- end
	if itemID then
		vivod = vivod..E:func_textCENT_Items(CharInfo, itemID, true)
	end
	return vivod
end
----------------------------------------------------------------
function E:func_InitTable(tbl)
	return tbl or {}
end
----------------------------------------------------------------
function E:func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
----------------------------------------------------------------
function E:func_InitSubTable(tbl, field)
	if tbl[field] == nil then
		tbl[field] = {}
	end
end
----------------------------------------------------------------
function E:func_tToStr(t)
	local str = ""
	for _, v in ipairs(t) do
		str = str..v..","
	end
	return "{"..str:sub(1, -2).."}"
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------