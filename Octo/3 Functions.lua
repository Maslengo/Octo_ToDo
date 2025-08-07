local GlobalAddonName, E = ...
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local table_sort = table.sort
local table_insert = table.insert
local table_concat = table.concat
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
local QUEST_WATCH_QUEST_READY = QUEST_WATCH_QUEST_READY or "Complete"
local FAILED = FAILED or "Failed"
local UNKNOWN = UNKNOWN or "Unknown"
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
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetDayEvent = GetDayEvent or C_Calendar.GetDayEvent
local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
local classR, classG, classB = GetClassColor(E.classFilename)
function E:func_IsClassic() return E.interfaceVersion > 10000 and E.interfaceVersion < 20000 end
function E:func_IsBC() return E.interfaceVersion > 20000 and E.interfaceVersion < 30000 end
function E:func_IsWOTLK() return E.interfaceVersion > 30000 and E.interfaceVersion < 40000 end
function E:func_IsCataclysm() return E.interfaceVersion > 40000 and E.interfaceVersion < 50000 end
function E:func_IsMOP() return E.interfaceVersion > 50000 and E.interfaceVersion < 60000 end
function E:func_IsWOD() return E.interfaceVersion > 60000 and E.interfaceVersion < 70000 end
function E:func_IsLegion() return E.interfaceVersion > 70000 and E.interfaceVersion < 80000 end
function E:func_IsBFA() return E.interfaceVersion > 80000 and E.interfaceVersion < 90000 end
function E:func_IsShadowlands() return E.interfaceVersion > 90000 and E.interfaceVersion < 100000 end
function E:func_IsDragonflight() return E.interfaceVersion > 100000 and E.interfaceVersion < 110000 end
function E:func_IsTWW() return E.interfaceVersion > 110000 and E.interfaceVersion < 120000 end
function E:func_IsMidnight() return E.interfaceVersion > 120000 and E.interfaceVersion < 130000 end
function E:func_IsTLT() return E.interfaceVersion > 130000 and E.interfaceVersion < 140000 end
function E:func_IsRetail() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE end
function E:func_IsPTR() return GetCurrentRegion() >= 72 end
function E:func_texturefromIcon(icon, iconWidth, iconHeight)
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconWidth)..":"..(iconHeight)..":::64:64:6:58:6:58|t "
end
function E:func_texturefromIconEVENT(icon, iconSize)
	iconSize = iconSize or 16
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconSize)..":"..(iconSize)..":::128:128:0:91:0:91|t "
end
function E:func_GetItemIconByID(itemID)
	return GetItemIconByID(itemID)
end
function E:func_ItemPriceTSM(itemID, myCount)
	local result = ""
	local count = 0
	if myCount then
		count = myCount
	else
		count = E:func_GetItemCount(itemID, true, true, true, false)
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
function E:func_LFGdungName(dID)
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID == dID then
			return name
		end
	end
	return UNKNOWN
end
function E:func_GetSpellIcon(spellID)
	return GetSpellTexture(spellID)
end
function E:func_GetCurrencyIcon(currencyID)
	local info = GetCurrencyInfo(currencyID)
	return info and info.iconFileID or E.Icon_Empty
end
local function func_itemName_CACHE(id)
	local itemCache = Octo_Cache_DB.AllItems[id]
	if itemCache and itemCache[E.curLocaleLang] then
		return itemCache[E.curLocaleLang]
	end
	local itemName = GetItemNameByID(id)
	if itemName and itemName ~= "" then
		if not itemCache then
			itemCache = {}
			Octo_Cache_DB.AllItems[id] = itemCache
		end
		itemCache[E.curLocaleLang] = itemName
		return itemName
	end
	return E.Red_Color .. UNKNOWN .. "|r"
end
function E:func_itemName(id, newQuality)
	if not id then return end
	local quality = GetItemQualityByID(id) or 0
	if newQuality then
		quality = newQuality
	end
	local icon = E:func_texturefromIcon(E:func_GetItemIconByID(id)) or ""
	local colorHex = ITEM_QUALITY_COLORS[quality].hex
	local name = func_itemName_CACHE(id)
	local result = icon .. colorHex .. name .. "|r"
	return result .. E:debugInfo(id)
end
local function func_currencyName_CACHE(id)
	local currencyCache = Octo_Cache_DB.AllCurrencies[id]
	if currencyCache and currencyCache[E.curLocaleLang] then
		return currencyCache[E.curLocaleLang]
	end
	local WarbandIcon = ""
	if IsAccountTransferableCurrency(id) then
		WarbandIcon = E.Icon_AccountTransferable
	elseif IsAccountWideCurrency(id) then
		WarbandIcon = E.Icon_AccountWide
	end
	local info = GetCurrencyInfo(id)
	if not info then
		return E.Red_Color .. UNKNOWN .. "|r"
	end
	local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
	local result = colorHex .. info.name .. "|r" .. WarbandIcon
	if not currencyCache then
		currencyCache = {}
		Octo_Cache_DB.AllCurrencies[id] = currencyCache
	end
	currencyCache[E.curLocaleLang] = result
	return result
end
function E:func_currencyName(id)
	if not id then return end
	local cachedName = (E:func_texturefromIcon(E:func_GetCurrencyIcon(id)) or "") ..func_currencyName_CACHE(id)
	return cachedName .. E:debugInfo(id)
end
local function func_npcName_CACHE(id)
	local npcCache = Octo_Cache_DB.AllNPCs[id]
	if npcCache and npcCache[E.curLocaleLang] then
		return npcCache[E.curLocaleLang]
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
	if name then
		if not npcCache then
			npcCache = {}
			Octo_Cache_DB.AllNPCs[id] = npcCache
		end
		npcCache[E.curLocaleLang] = name
		return name
	end
	return E.Red_Color..UNKNOWN.."|r"
end
function E:func_npcName(id)
	if not id then return end
	local cachedName = func_npcName_CACHE(id)
	return cachedName .. E:debugInfo(id)
end
local function func_questName_CACHE(id)
	local questCache = Octo_Cache_DB.AllQuests[id]
	if questCache and questCache[E.curLocaleLang] then
		return questCache[E.curLocaleLang]
	end
	local name = (GetTitleForQuestID or GetQuestInfo)(id)
	if name then
		if not questCache then
			questCache = {}
			Octo_Cache_DB.AllQuests[id] = questCache
		end
		questCache[E.curLocaleLang] = name
		return name
	end
	return E.Red_Color..UNKNOWN.."|r"
end
function E:func_questName(id)
	if not id then return end
	local cachedName = func_questName_CACHE(id)
	return cachedName .. E:debugInfo(id)
end
local function func_reputationName_CACHE(id)
	if Octo_Cache_DB.AllReputations[id] and Octo_Cache_DB.AllReputations[id][E.curLocaleLang] then
		return Octo_Cache_DB.AllReputations[id][E.curLocaleLang]
	end
	local result = ""
	local name
	local repInfo = GetFactionDataByID(id)
	if repInfo then
		name = repInfo.name
	else
		local reputationInfo = GetFriendshipReputation(id)
		if reputationInfo.name then
			name = reputationInfo.name
		end
	end
	result = name
	if result and result ~= "" then
		local isAccountWide = IsAccountWideReputation(id) or false
		if isAccountWide == true then
			result = E.Icon_AccountWide..result
		end
		Octo_Cache_DB.AllReputations[id] = Octo_Cache_DB.AllReputations[id] or {}
		Octo_Cache_DB.AllReputations[id][E.curLocaleLang] = result
	end
	return Octo_Cache_DB.AllReputations[id] and Octo_Cache_DB.AllReputations[id][E.curLocaleLang] or E.Purple_Color..UNKNOWN.."|r"
end
function E:func_reputationName(id)
	if not id then return end
	local sideIcon = ""
	local side = "-"
	if E.OctoTable_ReputationsDB[id] then
		side = E.OctoTable_ReputationsDB[id].side
	end
	if side == "Alliance" then
		sideIcon = E:func_texturefromIcon(E.Icon_Alliance)..sideIcon
		sideIcon = E.Blue_Color..sideIcon.."|r"
	elseif side == "Horde" then
		sideIcon = E:func_texturefromIcon(E.Icon_Horde)..sideIcon
		sideIcon = E.Red_Color..sideIcon.."|r"
	end
	return sideIcon..func_reputationName_CACHE(id) .. E:debugInfo(id)
end
local function func_spellName_CACHE(id)
	local spellCache = Octo_Cache_DB.AllSpells[id]
	if spellCache and spellCache[E.curLocaleLang] then
		return spellCache[E.curLocaleLang]
	end
	local name = GetSpellName(id)
	if name then
		if not spellCache then
			spellCache = {}
			Octo_Cache_DB.AllSpells[id] = spellCache
		end
		spellCache[E.curLocaleLang] = name
		return name
	end
	return E.Red_Color..UNKNOWN.."|r"
end
function E:func_spellName(id)
	local cachedName = func_spellName_CACHE(id)
	return cachedName .. E:debugInfo(id)
end
function E:func_IsAccountQuest(questID)
	return IsAccountQuest(questID)
end
function E:func_IsQuestFlaggedCompletedOnAccount(questID)
	return IsQuestFlaggedCompletedOnAccount(questID)
end
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
function E:func_GetCurrentLocation()
	local curRealZone = GetRealZoneText()
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText()
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText()
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
function E:func_GetItemInfo(itemInfo)
	return GetItemInfo(itemInfo)
end
function E:func_GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if not itemID then return end
	return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
end
function E:func_GetItemLink(itemID)
	local _, link = E:func_GetItemInfo(itemID)
	return link
end
function E:func_GetItemQuality(itemID)
	return GetItemQualityByID(itemID) or 0
end
function E:func_GetItemQualityColorID(itemID)
	return ITEM_QUALITY_COLORS[E:func_GetItemQuality(itemID)]
end
function E:func_GetItemQualityColor(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
function E:func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
function E:func_GetDetailedItemLevelInfo(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
function E:func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E:func_CompactNumberSimple(result)
end
function E:func_GetSpellSubtext(spellID)
	local result = GetSpellSubtext(spellID)
	return result
end
function E:func_GetSpellCooldown(spellID)
	local start = GetSpellCooldown(spellID).startTime
	local duration = GetSpellCooldown(spellID).duration
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E:func_CompactNumberSimple(result)
end
function E:func_hex2rgb(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
function E:func_hex2rgbNUMBER(hex)
	if hex and hex ~= "" then
		hex = hex:gsub("|cff", "")
		return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
	else
		return 1, 1, 1
	end
end
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
function E:func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "|c"..string_format("%02x", math_floor(a*255))..utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E:func_rgb2hexSTRING(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return utf8upper(string_format("%02x%02x%02x", math_floor(r*255), math_floor(g*255), math_floor(b*255)))
end
function E:func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local result = ""
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
		result = str..secondColor..utf8sub(text, utf8len(text)).."|r"
		return result
	else
		return text
	end
end
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
function E:func_MoneyString(number)
	if not number then return 0 end
	if number > 10000 then
		return E:func_CompactNumberFormat(number/10000).."|r".."|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
	elseif number > 100 then
		return E:func_CompactNumberFormat(number/100).."|r".."|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
	else
		return E:func_CompactNumberFormat(number).."|r".."|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
	end
end
function E:func_CompactNumberSimple(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math_floor(number+.5)
	end
end
function E:func_SecondsToClock(time, showSecond)
	time = tonumber(time) or 0
	if time <= 0 then
		return ""
	end
	local years = floor(time / 31536000)
	local days = floor(time % 31536000 / 86400)
	local hours = floor(time % 86400 / 3600)
	local mins = floor(time % 3600 / 60)
	local secs = floor(time % 60)
	local ms = time - floor(time)
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
function E:func_tmstpDayReset(time)
	local time = time or 1
	local daytime = 86400
	local thursdayReset = GetWeeklyResetStartTime()
	return (math_ceil((GetServerTime() - thursdayReset)/(daytime*time))*daytime*time)+thursdayReset
end
function E:func_GetWeeklyReset()
	return GetSecondsUntilWeeklyReset()
end
function E:func_IsOnQuest(id)
	return IsOnQuest(id)
end
function E:func_CheckCompletedByQuestID(questID)
	if not questID then return end
	local result
	if IsFailed(questID) then
		result = E.Red_Color..FAILED.."|r"
	elseif IsQuestFlaggedCompleted(questID) then
		result = E.DONE
	elseif IsComplete(questID) then
		result = E.Purple_Color..">"..QUEST_WATCH_QUEST_READY.."<".."|r"
	elseif not E:func_IsOnQuest(questID) then
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
function E:func_achievementComplete(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
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
function E:func_CurServerShort(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	if b then
		return utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	end
	return utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
end
E.curServerShort = E:func_CurServerShort(GetRealmName())
function E:func_GetMapName(id)
	if not id then return end
	local info = GetMapInfo(id)
	if info and info.name then
		return info.name .. E:debugInfo(id)
	end
end
function E:func_GetMapNameFromID(id)
	if not id then
		return UNKNOWN
	end
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
function E:func_GetCoord(x, y)
	return floor(x * 10000 + 0.5) * 10000 + floor(y * 10000 + 0.5)
end
function E:func_GetCoordFormated(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string_format("%.1f / %.1f", x * 100, y * 100)
end
function E.func_Reverse_order(a, b)
	return b < a
end
function E:func_CheckReputation(reputationID)
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
function E:func_CurrentNumQuests()
	local numQuests = 0
	for i = 1, GetNumQuestLogEntries() do
		local info = GetInfo(i)
		numQuests = numQuests + (info and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
function E:func_GetAddOnMetadata(name, variable)
	return GetAddOnMetadata(name, variable)
end
function E:func_IsAddOnLoaded(AddonNameOrIndex)
	return IsAddOnLoaded(AddonNameOrIndex)
end
function E:func_LoadAddOnFORCED(AddonName)
	if DoesAddOnExist(AddonName) and not E:func_IsAddOnLoaded(AddonName) then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
function E:func_CurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
function E:func_EventName(id)
	if not id then return end
	local monthDay = GetCurrentCalendarTime().monthDay
	local month = 0
	local numEvents = GetNumDayEvents(month, monthDay)
	for i = 1, numEvents do
		local event = GetDayEvent(month, monthDay, i)
		if event.eventID == id then
			local result = event.title
			return result .. E:debugInfo(id)
		end
	end
	return nil
end
function E:func_ProfessionName(id)
	if not id then return end
	local result = GetTradeSkillDisplayName(id) or E.Red_Color..UNKNOWN.."|r"
	return result .. E:debugInfo(id)
end
function E:func_ProfessionIcon(skillLine)
	return skillLine and E:func_texturefromIcon(GetTradeSkillTexture(skillLine)) or ""
end
function E:func_debugprofileSTART()
	local timer = debugprofilestart()
	return timer
end
function E:func_debugprofileSTOP()
	local timer = E:func_CompactNumberSimple(debugprofilestop())
	local result = E:func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
function E:func_FriendsFrame_GetLastOnlineText(time, color)
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
function E:func_TableConcat(table1, table2)
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
function E:func_MergeTableSFMICTpairs(table1, table2)
	for k, v in next, (table2) do
		table1[k] = v
	end
	return table1
end
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
function E:func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E:func_rgb2hex(fontstring:GetTextColor())..text.."|r"
end
function E:func_SetBackdrop(frame, hexcolor, BackdropAlpha, edgeAlpha)
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
function E:func_CreateMinimapButton(AddonName, nameForIcon, Saved_Variables, frame, func, frameString)
	local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
			type = "data source",
			icon = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\IconTexture\\"..nameForIcon,
			OnClick = function(self, button)
				if button == "LeftButton" then
					if not InCombatLockdown() then
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
						Settings.OpenToCategory(E:func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
					end
				end
			end,
			OnTooltipShow = function(tooltip)
				tooltip:AddDoubleLine(E:func_GetAddOnMetadata(AddonName, "Title"))
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
function E:func_fixdate(date)
	local result = ("%.2d"):format(date)
	return result
end
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
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E:FrameColor(self, id, curType)
					E:func_OctoTooltip_OnEnter(frame)
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E:func_itemName(id), E:func_SecondsToClock(E:func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E:func_spellName(id), E:func_SecondsToClock(E:func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E:func_GetSpellSubtext(id))
					end
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
		end
	end
end
function E:func_RegisterMyEventsToFrames(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or UNKNOWN
	local DebugPath = STR:gsub("]", "")
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event, ...)
			if self[event] then
				self[event](self, ...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.KILLTEXT..E.Event_Color..event.."|r"..E.KILLTEXT..tostring(DebugPath))
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
function E:func_NumPlayers()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local count = 0
	local curGUID = E.curGUID
	local curFaction = E.curFaction
	local curServer = E.curServer
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
function E:func_sorted()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
	local sorted = {}
	local curGUID = E.curGUID
	local curFaction = E.curFaction
	local curServer = E.curServer
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
function E:func_achievementName(id)
	if not id then return end
	local name = select(2, GetAchievementInfo(id))
	if name then
		return name .. E:debugInfo(id)
	else
		return E.Red_Color..UNKNOWN.."|r"
	end
end
function E:func_FactionIconID(faction)
	if faction == "Horde" then
		return 2565244
	elseif faction == "Alliance" then
		return 2565243
	else
		return 775462
	end
end
function E:func_Universal(tbl, DESCRIPT)
	if not tbl or not DESCRIPT then return end
	if not Octo_ToDo_DB_Vars.Quests and not Octo_ToDo_DB_Vars.Holidays then return end
	local expID, expColor, expName, descSTR
	if type(DESCRIPT) == "number" and Octo_ToDo_DB_Vars.Quests then
		local expansionData = E.OctoTable_Expansions[DESCRIPT]
		if expansionData then
			expID = expansionData.id
			expColor = expansionData.color
			expName = expansionData.name
			descSTR = expName:gsub(" ", "")
		else
			return
		end
	elseif type(DESCRIPT) == "string" and Octo_ToDo_DB_Vars.Holidays then
		expColor = E.Holiday_Color
		descSTR = DESCRIPT
	else
		return
	end
	for _, data in ipairs(E.OctoTable_UniversalQuest) do
		if data.quests and descSTR == data.desc then
			table_insert(tbl, function(CharInfo)
					local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType = "", nil, "", {}, nil, {}
					local questKey = data.desc.."_"..data.name_save.."_"..data.reset
					local showTooltip = data.showTooltip or false
					if not data.textleft then
						fpde(data)
					end
					textLEFT = tostringall(func_OnceDailyWeeklyMonth_Format(data.reset).." "..data.textleft)
					if showTooltip then
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
						if E.DebugInfo then
							tooltipCENT[#tooltipCENT+1] = {questKey, "forcedMaxQuest: "..totalQuest}
						end
						if totalQuest > 1 then
							tooltipCENT[#tooltipCENT+1] = {textLEFT, TOTAL..": "..totalQuest}
							tooltipCENT[#tooltipCENT+1] = {" "}
						end
						local questsToShow = {}
						for _, questData in ipairs(data.quests) do
							local faction = questData.faction
							if not faction or faction == CharInfo.PlayerData.Faction then
								table_insert(questsToShow, questData)
							end
						end
						if data.sorted ~= false then
							table_sort(questsToShow, function(a, b)
									local nameA = a.forcedText and a.forcedText.npcID and E:func_npcName(a.forcedText.npcID) or E:func_questName(a[1]) or a.forcedText.text or ""
									local nameB = b.forcedText and b.forcedText.npcID and E:func_npcName(b.forcedText.npcID) or E:func_questName(b[1]) or b.forcedText.text or ""
									return nameA < nameB
							end)
						end
						for _, questData in ipairs(questsToShow) do
							local questID = questData[1]
							local faction = questData.faction
							local forcedText = questData.forcedText
							local vivod_RIGHT = CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] and CharInfo.MASLENGO.UniversalQuest[questKey][questID] or E.Gray_Color..NONE.."|r"
							local vivod_LEFT = ""
							if forcedText then
								vivod_LEFT = forcedText.npcID and E:func_npcName(forcedText.npcID) or
								forcedText.text or
								forcedText.achievementID and E:func_achievementName(forcedText.achievementID) or
								forcedText.itemID and E:func_itemName(forcedText.itemID) or ""
							else
								vivod_LEFT = E:func_questName(questID)
							end
							if faction == CharInfo.PlayerData.Faction then
								vivod_LEFT = E:func_texturefromIcon(E:func_FactionIconID(faction))..vivod_LEFT
							end
							tooltipCENT[#tooltipCENT+1] = {vivod_LEFT, vivod_RIGHT}
						end
					end
					if CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] then
						local LeftData = CharInfo.MASLENGO.UniversalQuest[questKey].textCENT
						if LeftData then
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
							if type(LeftData) == "number" and forcedMaxQuest then
								textCENT = LeftData >= forcedMaxQuest and E.DONE or LeftData.."/"..forcedMaxQuest
							elseif forcedMaxQuest ~= 1 then
								textCENT = "0/"..forcedMaxQuest
							elseif type(LeftData) == "string" then
								textCENT = LeftData
							end
						end
					end
					colorLEFT = expColor
					return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType
			end)
		end
	end
end
function E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT, expansionID)
	if not OctoTable_Otrisovka_textCENT or not E.OctoTable_Expansions[expansionID] then return end
	if not (Octo_ToDo_DB_Vars.Currencies or Octo_ToDo_DB_Vars.Items) then return end
	local itemProcessors = setmetatable({}, {__mode = "v"})
	local currencyProcessors = setmetatable({}, {__mode = "v"})
	local expansionData = E.OctoTable_Expansions[expansionID]
	local Data = E.OctoTables_DataOtrisovka[expansionID]
	if not Data then return end
	local func_textCENT_Items = function(...) return E:func_textCENT_Items(...) end
	local func_itemName = function(...) return E:func_itemName(...) end
	local func_GetItemIconByID = function(...) return E:func_GetItemIconByID(...) end
	local func_textCENT_Currency = function(...) return E:func_textCENT_Currency(...) end
	local func_currencyName = function(...) return E:func_currencyName(...) end
	local func_GetCurrencyIcon = function(...) return E:func_GetCurrencyIcon(...) end
	local Purple_Color = E.Purple_Color
	local function getItemProcessor(itemID)
		local processor = itemProcessors[itemID]
		if not processor then
			processor = function(CharInfo)
				return func_itemName(itemID),
				expansionData.color,
				func_textCENT_Items(CharInfo, itemID),
				{},
				nil,
				{"Item", itemID}
			end
			itemProcessors[itemID] = processor
		end
		return processor
	end
	local function getCurrencyProcessor(currencyID)
		local processor = currencyProcessors[currencyID]
		if not processor then
			processor = function(CharInfo)
				local textCENT = func_textCENT_Currency(CharInfo, currencyID)
				if currencyID == 1931 and CharInfo.PlayerData.Possible_CatalogedResearch then
					textCENT = string_format("%s%s +%d|r", textCENT, Purple_Color, CharInfo.PlayerData.Possible_CatalogedResearch)
				end
				return func_currencyName(currencyID),
				expansionData.color,
				textCENT,
				{},
				nil,
				{"Currency", currencyID}
			end
			currencyProcessors[currencyID] = processor
		end
		return processor
	end
	if Octo_ToDo_DB_Vars.Items and Data.Items then
		for _, itemID in ipairs(Data.Items) do
			if type(itemID) == "number" then
				OctoTable_Otrisovka_textCENT[#OctoTable_Otrisovka_textCENT + 1] = getItemProcessor(itemID)
			elseif type(itemID) == "table" then
				for _, ItemID_new in ipairs(itemID) do
					OctoTable_Otrisovka_textCENT[#OctoTable_Otrisovka_textCENT + 1] = getItemProcessor(ItemID_new)
				end
			end
		end
	end
	if Octo_ToDo_DB_Vars.Currencies and Data.Currencies then
		for _, currencyID in ipairs(Data.Currencies) do
			OctoTable_Otrisovka_textCENT[#OctoTable_Otrisovka_textCENT + 1] = getCurrencyProcessor(currencyID)
		end
	end
end
function E:func_tooltipCurrencyAllPlayers(myType, ID, iANIMA, kCovenant)
	local tooltip = {}
	local total = 0
	local sorted = {}
	local hasTotal = false
	local sortedPlayersTBL = E:func_sorted()
	local visiblePlayers = {}
	for _, charInfo in ipairs(sortedPlayersTBL) do
		visiblePlayers[charInfo.PlayerData.GUID] = true
	end
	local minItemLevel, maxItemLevel, minMoney, maxMoney = 0, 0, 0, 0
	local itemLevelsMinMax, MoneysMinMax = {}, {}
	if myType == "ItemLevel" then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
				table_insert(itemLevelsMinMax, CharInfo.PlayerData.avgItemLevelEquipped)
			end
		end
		minItemLevel = math_min(unpack(itemLevelsMinMax))
		maxItemLevel = math_max(unpack(itemLevelsMinMax))
	end
	if myType == "Money" then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
				table_insert(MoneysMinMax, CharInfo.PlayerData.Money)
			end
		end
		minMoney = math_min(unpack(MoneysMinMax))
		maxMoney = math_max(unpack(MoneysMinMax))
	end
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local specIcon, color, Name
			local RIGHT1 = ""
			local RIGHT2 = ""
			local curServer, curPers = "", ""
			if myType == "professions" then
				local charProf = CharInfo.MASLENGO.professions
				for i = 1, 2 do
					if charProf[i] and charProf[i].skillLine then
						local icon = E:func_ProfessionIcon(charProf[i].skillLine)
						local result = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
						if charProf[i].skillModifier then
							result = charProf[i].skillLevel.."|cff00FF00+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
						end
						if i == 1 then
							RIGHT1 = RIGHT1..result..icon
						end
						if i == 2 then
							RIGHT2 = RIGHT2..result..icon
						end
						RIGHTforSORT = charProf[i].skillLine
						total = total + i
					end
				end
			elseif myType == "ItemLevel" and CharInfo.PlayerData.avgItemLevel then
				local hexcolorItemLevel = "|cff000000"
				local result = ""
				if minItemLevel then
					local done = CharInfo.PlayerData.avgItemLevelEquipped - minItemLevel
					local totalIlevels = maxItemLevel - minItemLevel
					local red = min(255, (1 - done / totalIlevels) * 510)
					local green = min(255, (done / totalIlevels) * 510)
					hexcolorItemLevel = string_format("|cff%2x%2x00", red, green)
				end
				if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
					result = hexcolorItemLevel..CharInfo.PlayerData.avgItemLevelEquipped
					if CharInfo.PlayerData.avgItemLevel > CharInfo.PlayerData.avgItemLevelEquipped then
						result = result.."/"..CharInfo.PlayerData.avgItemLevel.."|r"
					end
					if CharInfo.PlayerData.avgItemLevelPvp and CharInfo.PlayerData.avgItemLevelPvp > CharInfo.PlayerData.avgItemLevel then
						result = result..E.Blue_Color.."+|r"
					end
				end
				RIGHT1 = result
				RIGHTforSORT = CharInfo.PlayerData.avgItemLevelEquipped
				total = total + CharInfo.PlayerData.avgItemLevelEquipped
			elseif myType == "Money" and CharInfo.PlayerData.Money then
				local hexcolorMoney = "|cff000000"
				if minMoney then
					local done = CharInfo.PlayerData.Money - minMoney
					local totalMoney = maxMoney - minMoney
					local red = min(255, (1 - done / totalMoney) * 510)
					local green = min(255, (done / totalMoney) * 510)
					hexcolorMoney = string_format("|cff%2x%2x00", red, green)
				end
				RIGHT1 = hexcolorMoney..E:func_MoneyString(CharInfo.PlayerData.Money)
				RIGHTforSORT = CharInfo.PlayerData.Money
				total = total + CharInfo.PlayerData.Money
			elseif myType == "Online" and CharInfo.PlayerData.realTotalTime then
				RIGHT1 = E:func_SecondsToClock(CharInfo.PlayerData.realTotalTime)
				RIGHTforSORT = CharInfo.PlayerData.realTotalTime
				total = total + CharInfo.PlayerData.realTotalTime
			elseif myType == "Currency" and CharInfo.MASLENGO.Currency[ID] and E:func_textCENT_Currency(CharInfo, ID) ~= "" then
				RIGHT1 = E:func_textCENT_Currency(CharInfo, ID)
				RIGHTforSORT = CharInfo.MASLENGO.Currency[ID].quantity or 0
				total = total + (CharInfo.MASLENGO.Currency[ID].quantity or 0)
			elseif myType == "Item" and CharInfo.MASLENGO.ItemsInBag[ID] then
				total = total + CharInfo.MASLENGO.ItemsInBag[ID]
				RIGHT1 = CharInfo.MASLENGO.ItemsInBag[ID]
				RIGHTforSORT = CharInfo.MASLENGO.ItemsInBag[ID]
			elseif (myType == "Currency_Covenant_Anima" or myType == "Currency_Covenant_Renown") and CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] then
				total = total + CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
				RIGHT1 = CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
				RIGHTforSORT = CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant]
			end
			if RIGHT1 ~= "" then
				specIcon = E:func_texturefromIcon(CharInfo.PlayerData.specIcon)
				local colorPlayer = visiblePlayers[GUID] and CharInfo.PlayerData.classColorHex or E.Gray_Color
				local colorServer = visiblePlayers[GUID] and "|cffFFFFFF" or E.Gray_Color
				Name = CharInfo.PlayerData.Name
				if CharInfo.PlayerData.GUID == E.curGUID then
					curPers = E.Green_Color.."*|r"
				end
				if CharInfo.PlayerData.curServer ~= E.curServer then
					curServer = "-"..CharInfo.PlayerData.curServer
				end
				sorted[#sorted+1] = {specIcon, colorPlayer, Name, curPers, colorServer, curServer, RIGHT1, RIGHT2, RIGHTforSORT}
			end
		end
	end
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
		table_sort(sorted, function(a, b)
				if a[9] == b[9] then
					return a[3] < b[3]
				end
				return a[9] > b[9]
		end)
		if myType == "ItemLevel" then
			tooltip[#tooltip+1] = {"", CLUB_FINDER_MEDIUM..": "..math_floor(total/#sorted)}
		elseif myType == "Money" then
			C_WowTokenPublic.UpdateMarketPrice()
			if C_WowTokenPublic.GetCurrentMarketPrice() then
				local price, hz = C_WowTokenPublic.GetCurrentMarketPrice()
				tooltip[#tooltip+1] = {"", E:func_itemName(122284)..": "..E:func_MoneyString(C_WowTokenPublic.GetCurrentMarketPrice())}
			end
			if C_Bank.FetchDepositedMoney(Enum.BankType.Account) then
				tooltip[#tooltip+1] = {"", ACCOUNT_BANK_PANEL_TITLE..": "..E:func_MoneyString(C_Bank.FetchDepositedMoney(Enum.BankType.Account))}
			end
			tooltip[#tooltip+1] = {"", TOTAL..": "..E:func_MoneyString(total)}
		elseif myType == "Online" then
			tooltip[#tooltip+1] = {"", E:func_SecondsToClock(total)}
		elseif myType == "Currency" then
			tooltip[#tooltip+1] = {"", TOTAL..": "..total}
		elseif myType == "Item" then
			tooltip[#tooltip+1] = {E:func_itemName(ID), TOTAL..": "..total}
		elseif myType == "Currency_Covenant_Anima" then
			tooltip[#tooltip+1] = {E:func_texturefromIcon(E:func_GetCurrencyIcon(ID)).." "..E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r", total}
		elseif myType == "Currency_Covenant_Renown" then
			tooltip[#tooltip+1] = {E:func_texturefromIcon(E.OctoTable_Covenant[iANIMA].icon).." "..E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r", total}
		end
		for _, v in ipairs(sorted) do
			tooltip[#tooltip+1] = {v[1]..v[2]..v[3]..v[4].."|r"..v[5]..v[6].."|r", v[7]..v[8]}
		end
	end
	return tooltip
end
function E:func_textCENT_Items(CharInfo, itemID, showIcon)
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
		result = " +"..result..E:func_texturefromIcon(E:func_GetItemIconByID(itemID))
	end
	return result
end
function E:func_textCENT_Currency(CharInfo, currencyID, itemID)
	local data = CharInfo.MASLENGO.Currency
	if not data[currencyID] then return "" end
	local result = ""
	local color = E.White_Color
	if data[currencyID].quantity then
		result = result..E:func_CompactNumberFormat(data[currencyID].quantity)
		if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
			if data[currencyID].quantity == data[currencyID].maxQuantity then
				color = E.Green_Color
			end
			result = color..result.."/"..E:func_CompactNumberFormat(data[currencyID].maxQuantity).."|r"
		end
	end
	if data[currencyID].totalEarned and data[currencyID].maxQuantity then
		local curQuantity = E:func_CompactNumberFormat(data[currencyID].quantity or 0)
		result = E:func_CompactNumberFormat(data[currencyID].totalEarned)
		result = " ("..result.."/"..E:func_CompactNumberFormat(data[currencyID].maxQuantity)..")"
		result = color..curQuantity..result.."|r"
	end
	if itemID then
		result = result..E.Green_Color..E:func_textCENT_Items(CharInfo, itemID, true).."|r"
	end
	return result
end
function E:func_InitTable(tbl)
	return tbl or {}
end
function E:func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
function E:func_InitSubTable(tbl, field)
	if tbl[field] == nil then
		tbl[field] = {}
	end
end
function E:func_Update(event_name)
	if not E.DebugEvent then return end
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()
	if isMainFrameVisible then
		if not E.func_UpdateScheduled then
			E.func_UpdateScheduled = true
			C_Timer.After(0.1, function()
					E.func_UpdateScheduled = false
					if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
						E:func_TODO_CreateDataProvider()
						DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient("E:func_Update ", E.Green_Color, E.Yellow_Color)..event_name)
					end
			end)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient("E:func_Update ", E.Red_Color, E.Purple_Color)..event_name)
	end
end
function E:func_GetCurrentRegion()
	return GetCurrentRegion()
end
function E:func_GetCurrentRegionName()
	if GetCurrentRegionName() == "" then
		return "PTR "..E.buildVersion
	end
	return GetCurrentRegionName()
end
function E:func_tooltipCENT_ITEMS(CharInfo, TBL, needShowAllItems)
	local tooltipCENT = {}
	local sorted_itemList = {}
	local ItemsInBag = CharInfo.MASLENGO.ItemsInBag
	local GetItemQuality = function(id) return self:func_GetItemQuality(id) end
	local GetItemIconByID = function(id) return self:func_GetItemIconByID(id) end
	local GetItemNameByID = function(id) return self:func_itemName(id) end
	local ItemPriceTSM = function(id, count) return self:func_ItemPriceTSM(id, count) end
	local texturefromIcon = function(icon) return self:func_texturefromIcon(icon) end
	for _, itemID in ipairs(TBL) do
		local count = ItemsInBag[itemID]
		if needShowAllItems or count then
			table_insert(sorted_itemList, {
					itemID = itemID,
					quality = GetItemQuality(itemID),
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
		local name = GetItemNameByID(itemID)
		local price = ItemPriceTSM(itemID, item.count)
		tooltipCENT[#tooltipCENT + 1] = {name, count, price}
	end
	return tooltipCENT
end
function E:func_InitFrame(frame)
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	tinsert(E.OctoTable_Frames, frame)
	tinsert(UISpecialFrames, frame:GetName())
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
function E:func_joinableDung()
	local joinable, timewalkDungeonName, result = false, "", ""
	for expID, v in ipairs(E.OctoTable_Expansions) do
		if v.timewalkDungeonID and IsLFGDungeonJoinable(v.timewalkDungeonID) then
			joinable = true
			result = E:func_texturefromIcon(v.icon, 16, 32)..v.color .. v.nameVeryShort .. "|r"
			timewalkDungeonName = GetLFGDungeonInfo(v.timewalkDungeonID)
		end
	end
	return joinable, result, timewalkDungeonName:match("%((.-)%)")
end
function E:debugInfo(id)
	local result = E.DebugIDs and (E.Gray_Color .. " id:" .. id .. "|r") or ""
	return result
end




function E:func_buildIcon(id)
	local icon = select(4, GetBuildingInfo(id))
	return icon
end

function E:func_buildName(id)
	-- local id, name, textureKit, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot = GetBuildingInfo(id)
	local name = select(2, GetBuildingInfo(id))
	return name .. E:debugInfo(id)
end

function E:func_buildLevel(id)
	local id, name, textureKit, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot = GetBuildingInfo(id)

	-- if not canUpgrade then
	if isMaxLevel then
		return E.Green_Color..rank.."|r"
	else
		return E.Red_Color..rank.."|r"
	end

end



E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CentralFrame.tga"
E.TEXTURE_REPUTATION_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Naowh.tga"
E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.TEXTURE_BLANK_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Blank.tga"
E.HighlightTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"
E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""
E.curLocaleLang = GetLocale() or "enUS"
E.Icon_MailBox = "Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga"
E.className, E.classFilename, E.classId = UnitClass("PLAYER")
E.classColor = RAID_CLASS_COLORS[E.classFilename] and RAID_CLASS_COLORS[E.classFilename].colorStr:sub(3) or "ffffff"
E.classColorHexCurrent = C_ClassColor.GetClassColor(E.classFilename):GenerateHexColorMarkup()
E.curCharName = UnitFullName("PLAYER")
E.curServer = GetRealmName()
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
E.LINES_MAX = 30
E.ddMenuButtonHeight = 16
E.GLOBAL_LINE_HEIGHT = 20
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
E.regionID = GetCurrentRegion()
E.regionName = GetCurrentRegionName()
E.CurrentRegionName = E:func_GetCurrentRegionName()
if E.regionName == "" then
	E.regionName = "US"
end
E.GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail"
E.BattleTagLocal = E.BTAG.." ("..E.GameVersion..")"
E.curGUID = UnitGUID("PLAYER")
E.GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.baseWowheadAzEsUrl = "%swowhead.com/azerite-essence/%s%s"
E.baseWowheadTradingPostActivityUrl = "%swowhead.com/trading-post-activity/%s%s"
E.baseArmoryUrl = "worldofwarcraft.blizzard.com/%s/character/%s/%s"
E.baseRaiderIoUrl = "raider.io/characters/%s/%s/%s"
E.curExpansionMaxLevel = 70
E.scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale()
E.MonitorWidth, E.MonitorHeight = GetPhysicalScreenSize()
E.Color_Quest_r = .3
E.Color_Quest_g = .1
E.Color_Quest_b = 0
E.Color_Currency_r = 0
E.Color_Currency_g = 0
E.Color_Currency_b = .3
E.Color_Crest_r = 0
E.Color_Crest_g = .3
E.Color_Crest_b = .3
E.Color_Item_r = 0
E.Color_Item_g = .3
E.Color_Item_b = 0
E.Color_Reputation_r = .3
E.Color_Reputation_g = .3
E.Color_Reputation_b = 0
E.MainFrame_Position = -157
E.AnimationDuration = .2
E.isElvUI = select(4, C_AddOns.GetAddOnInfo("ElvUI"))
E.isRCLootCouncil = select(4, C_AddOns.GetAddOnInfo("RCLootCouncil"))
E.isWeakAuras = select(4, C_AddOns.GetAddOnInfo("WeakAuras"))
E.isTomTom = select(4, C_AddOns.GetAddOnInfo("TomTom"))
E.isPlater = select(4, C_AddOns.GetAddOnInfo("Plater"))
E.isOmniCD = select(4, C_AddOns.GetAddOnInfo("OmniCD"))
E.isOmniCC = select(4, C_AddOns.GetAddOnInfo("OmniCC"))
E.isParrot = select(4, C_AddOns.GetAddOnInfo("Parrot"))
E.backgroundColorAOverlay = .2
E.slider_scale = .8
E.multiplier = 2 - E.slider_scale
E.WorldofWarcraft_Color = "|cffD6AB7D"
E.TheBurningCrusade_Color = "|cffE43E5A"
E.WrathoftheLichKing_Color = "|cff3FC7EB"
E.Cataclysm_Color = "|cffFF7C0A"
E.MistsofPandaria_Color = "|cff00EF88"
E.WarlordsofDraenor_Color = "|cffF48CBA"
E.Legion_Color = "|cffAAD372"
E.BattleforAzeroth_Color = "|cffFFF468"
E.Shadowlands_Color = "|cff9798FE"
E.Dragonflight_Color = "|cff53B39F"
E.TheWarWithin_Color = "|cff90CCDD"
E.Midnight_Color = "|cff7B69FF"
E.TheLastTitan_Color = "|cffF4C263"
E.WOW_Poor_Color = "|cff9D9D9D"
E.WOW_Common_Color = "|cffFFFFFF"
E.WOW_Uncommon_Color = "|cff1EFF00"
E.WOW_Rare_Color = "|cff0070DD"
E.WOW_Epic_Color = "|cffA335EE"
E.WOW_Legendary_Color = "|cffFF8000"
E.WOW_Artifact_Color = "|cffD9CC80"
E.WOW_Heirloom_Color = "|cff00CCFF"
E.WOW_WoWToken_Color = "|cff00CCFF"
E.Kyrian_Color = "|cff6FA8DC"
E.Necrolord_Color = "|cff93C47D"
E.NightFae_Color = "|cffB4A7D6"
E.Venthyr_Color = "|cffEA9999"
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
E.Icon_Alliance = 255140
E.Icon_Horde = 255142
E.Icon_Kyrian = 3641395
E.Icon_Necrolord = 3641396
E.Icon_NightFae = 3641394
E.Icon_Venthyr = 3641397
E.Icon_WorldBoss = 3528312
E.Icon_Rares = 135903
E.Icon_Money = 133784
E.Horde_Color = "|cffC41E3A"
E.Alliance_Color = "|cff0070DD"
E.Neutral_Color = E.Class_Monk_Color
if E.curFaction == "Horde" then
	E.Icon_Faction = 2565244
	E.Faction_Color = E.Horde_Color
elseif E.curFaction == "Alliance" then
	E.Icon_Faction = 2565243
	E.Faction_Color = E.Alliance_Color
else
	E.Icon_Faction = 775462
	E.Faction_Color = E.Class_Monk_Color
end
E.Kyrian_r_Color = 0.44
E.Kyrian_g_Color = 0.66
E.Kyrian_b_Color = 0.86
E.Necrolord_r_Color = 0.58
E.Necrolord_g_Color = 0.77
E.Necrolord_b_Color = 0.49
E.NightFae_r_Color = 0.56
E.NightFae_g_Color = 0.49
E.NightFae_b_Color = 0.76
E.Venthyr_r_Color = 0.88
E.Venthyr_g_Color = 0.40
E.Venthyr_b_Color = 0.40
E.DONE = E.Green_Color..DONE.."|r"
E.NONE = E.Gray_Color..NONE.."|r"
E.TRUE = E.Green_Color.."true|r"
E.FALSE = E.Red_Color.."false|r"
E.NIL = E.Red_Color.."nil|r"
E.Icon_AccountWide = CreateAtlasMarkup("warbands-icon", 16, 16)
E.Icon_AccountTransferable = CreateAtlasMarkup("warbands-icon", 16, 16)
E.Icon_Warbands = E.Blue_Color.."(A)".."|r"
E.Icon_QuestionMark = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.Icon_Empty = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Util_Icons\\Icon_Empty"
E.Icon_LFG = "Interface\\LFGFRAME\\BattlenetWorking0"
E.OctoTable_Prefixes = {
	"Русский",
	"Deutsch",
	"English",
	"Español",
	"Français",
	"Italiano",
	"Português Brasileiro",
	"Korean",
	"Chinese"
}
E.OctoTable_Covenant = {
	[1] = {
		name = GetCovenantData(1).name,
		icon = 3641395,
		color = "|cff6FA8DC",
		r = 0.44,
		g = 0.66,
		b = 0.86,
	},
	[2] = {
		name = GetCovenantData(2).name,
		icon = 3641397,
		color = "|cffEA9999",
		r = 0.88,
		g = 0.40,
		b = 0.40,
	},
	[3] = {
		name = GetCovenantData(3).name,
		icon = 3641394,
		color = "|cffB4A7D6",
		r = 0.56,
		g = 0.49,
		b = 0.76,
	},
	[4] = {
		name = GetCovenantData(4).name,
		icon = 3641396,
		color = "|cff93C47D",
		r = 0.58,
		g = 0.77,
		b = 0.49,
	},
}
E.listMaxSize = 30
E.DEVTEXT = "|T".. E.IconTexture ..":14:14:::64:64:4:60:4:60|t"..E.Green_Color.. "DebugInfo|r: "
E.KILLTEXT = "|T".. "Interface\\Addons\\"..E.MainAddonName.."\\Media\\ElvUI\\Facepalm.tga" ..":14:14:::64:64:4:60:4:60|t"