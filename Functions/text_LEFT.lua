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
function E.func_Otrisovka_LEFT_Raids(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	E.QWETBL = {}
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	local name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty, mapID, covenantID, isRaid = EJ_GetInstanceInfo(id)
	if isRaid then
		E.QWETBL[id] = E.QWETBL[id] or true
	end
	local color = isRaid and E.COLOR_GREEN or E.COLOR_RED
	local totalEncounters, encountersCompleted = GetLFGDungeonNumEncounters(id)
	----------------------------------------------------------------
	TextLeft = color..(name or "NONAME").."|r".. E.COLOR_GRAY .. " id:"..id.."|r" .. (encountersCompleted or 0).."/"..(totalEncounters or 0)
	-- ColorLeft =
	IconLeft = buttonImage2 or E.ICON_QUESTION_MARK
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Dungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	E.QWETBL = {}
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, ni
	----------------------------------------------------------------
	local name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty, mapID, covenantID, isRaid = EJ_GetInstanceInfo(id)
	if isRaid then
		E.QWETBL[id] = E.QWETBL[id] or true
	end
	local color = isRaid and E.COLOR_GREEN or E.COLOR_RED
	local totalEncounters, encountersCompleted = GetLFGDungeonNumEncounters(id)
	----------------------------------------------------------------
	TextLeft = color..(name or "NONAME").."|r".. E.COLOR_GRAY .. " id:"..id.."|r" .. (encountersCompleted or 0).."/"..(totalEncounters or 0) .. dungeonAreaMapID
	-- ColorLeft =
	IconLeft = buttonImage2 or E.ICON_QUESTION_MARK
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
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
