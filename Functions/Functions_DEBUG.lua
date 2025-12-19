local debug = false
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
function E.func_StartDebugTimer()
	local timer = debugprofilestart()
	return timer
end
function E.func_StopDebugTimer(funcName)
	if not funcName then funcName = "" end
	local timer = E.func_CompactRoundNumber(debugprofilestop())
	local result = funcName.." "..E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
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
