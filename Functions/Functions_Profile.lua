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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetProfileData(key)
	local tbl = Octo_profileKeys.profiles[E.CurrentProfile][key] or {}
	return tbl
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
		"Raids",
		"Dungeons",
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
		currentProfile = currentProfile or {}
		currentProfile[dataType] = currentProfile[dataType] or {}
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
		elseif dataType == "Raids" then
			E.ALL_Raids[entry.id] = true
		elseif dataType == "Dungeons" then
			E.ALL_Dungeons[entry.id] = true
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
