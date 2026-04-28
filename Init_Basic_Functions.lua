local GlobalAddonName, E = ...
E.MainAddonName = GlobalAddonName
OctoEngine = E -- в других аддонах
----------------------------------------------------------------
-- C_CreatureInfo ----------------------------------------------
----------------------------------------------------------------
local GetClassInfo = C_CreatureInfo and C_CreatureInfo.GetClassInfo or GetClassInfo
function E.func_GetClassInfo(classID)
	local classData = GetClassInfo(classID)
	if classData then
		if type(classData) == "table" then
			return classData.className, classData.classFile, classData.classID
		elseif type(classData) == "string" then
			return GetClassInfo(classID)
		end
	end
end
----------------------------------------------------------------
local GetRaceInfo = C_CreatureInfo and C_CreatureInfo.GetRaceInfo or GetRaceInfo
-- /dump E.func_GetName("race", 5)
function E.func_GetRaceInfo(raceID)
	local raceData = GetRaceInfo(raceID)
	if raceData then
		if type(raceData) == "table" then
			return raceData.raceName, raceData.clientFileString -- , raceData.raceID
		elseif type(raceData) == "string" then
			return GetRaceInfo(raceID)
		end
	end
end

----------------------------------------------------------------
-- C_Texture ---------------------------------------------------
----------------------------------------------------------------
local GetAtlasInfo = GetAtlasInfo or C_Texture.GetAtlasInfo
function E.func_GetAtlasInfo(atlasName)
	if GetAtlasInfo then
		return GetAtlasInfo(atlasName)
	end
end
----------------------------------------------------------------
-- C_ClassColor ------------------------------------------------
----------------------------------------------------------------
local GetClassColor = C_ClassColor and C_ClassColor.GetClassColor or GetClassColor
function E.func_GetClassColor_HEX(englishClass)
	local colorData = GetClassColor(englishClass)
	if not colorData then return end
	if type(colorData) == "table" then
		return "|c" .. colorData:GenerateHexColor() -- /dump C_ClassColor.GetClassColor("EVOKER"):GenerateHexColor() -> "ff339371"
	elseif type(colorData) == "number" then
		return "|c" .. select(4, GetClassColor(englishClass)) -- /dump select(4, GetClassColor("EVOKER")) -> "ff339371"
	end
end

-- /dump select(4, GetClassColor("PALADIN"))
----------------------------------------------------------------
-- C_AddOns ----------------------------------------------------
----------------------------------------------------------------
local GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo
function E.func_GetAddOnInfo(AddonName)
	if GetAddOnInfo then
		return GetAddOnInfo(AddonName)
	end
end
----------------------------------------------------------------
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
-- local DoesAddOnExist = C_AddOns and C_AddOns.DoesAddOnExist or DoesAddOnExist
function E.func_DoesAddOnExist(AddonName)
	if DoesAddOnExist then
		return DoesAddOnExist(AddonName)
	end
end
----------------------------------------------------------------
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
function E.func_EnableAddOn(AddonName)
	if EnableAddOn then
		return EnableAddOn(AddonName)
	end
end
----------------------------------------------------------------
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
function E.func_GetAddOnMetadata(AddonName, variable)
	if GetAddOnMetadata then
		return GetAddOnMetadata(AddonName, variable)
	end
end
----------------------------------------------------------------
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
function E.func_IsAddOnLoaded(AddonNameOrIndex)
	if IsAddOnLoaded then
		return IsAddOnLoaded(AddonNameOrIndex)
	end
end
----------------------------------------------------------------
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
function E.func_LoadAddOn(AddonName)
	if LoadAddOn then
		return LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------
function E.func_LoadAddOnForced(AddonName)
	if E.func_DoesAddOnExist(AddonName) and not E.func_IsAddOnLoaded(AddonName) then
		E.func_EnableAddOn(AddonName)
		E.func_LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------
-- C_SpellBook -------------------------------------------------
----------------------------------------------------------------
local IsSpellKnown = IsSpellKnown or C_SpellBook.IsSpellKnown
function E.func_IsSpellKnown(id, spellBank)
	if IsSpellKnown then
		return IsSpellKnown(id, spellBank)
	else
		return false
	end
end
----------------------------------------------------------------
-- C_Covenants -------------------------------------------------
----------------------------------------------------------------
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
function E.func_GetCovenantData(id)
	if GetCovenantData then
		return GetCovenantData(id)
	end
end
----------------------------------------------------------------
-- C_CovenantSanctumUI -----------------------------------------
----------------------------------------------------------------
local GetRenownLevel = GetRenownLevel or C_CovenantSanctumUI.GetRenownLevel
function E.func_GetRenownLevel()
	if GetRenownLevel then
		return GetRenownLevel()
	end
end
----------------------------------------------------------------
-- C_CurrencyInfo ----------------------------------------------
----------------------------------------------------------------
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
function E.func_GetCurrencyInfo(id)
	if GetCurrencyInfo then
		return GetCurrencyInfo(id)
	end
end
----------------------------------------------------------------
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
function E.func_IsAccountWideCurrency(id)
	if id == 2032 then return true end
	if IsAccountWideCurrency then
		return IsAccountWideCurrency(id)
	else
		return false
	end
end
----------------------------------------------------------------
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
function E.func_IsAccountTransferableCurrency(id)
	if IsAccountTransferableCurrency then
		return IsAccountTransferableCurrency(id)
	end
end
----------------------------------------------------------------
local FetchCurrencyDataFromAccountCharacters = FetchCurrencyDataFromAccountCharacters or C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters
function E.func_FetchCurrencyDataFromAccountCharacters(id)
	if FetchCurrencyDataFromAccountCharacters then
		return FetchCurrencyDataFromAccountCharacters(id)
	end
end
----------------------------------------------------------------
local GetCoinTextureString = GetCoinTextureString or C_CurrencyInfo.GetCoinTextureString
function E.func_GetCoinTextureString(id)
	if GetCoinTextureString then
		return GetCoinTextureString(id)
	end
end
----------------------------------------------------------------
-- C_Spell -----------------------------------------------------
----------------------------------------------------------------
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
function E.func_GetSpellCooldown(id)
	if GetSpellCooldown then
		return GetSpellCooldown(id)
	end
end
-- function E.func_GetSpellCooldown(spellID)
--     local start = GetSpellCooldown(spellID).startTime
--     local duration = GetSpellCooldown(spellID).duration
--     local result = 0
--     if start > 0 and duration > 0 then
--         result = (start + duration - GetTime())
--     end
--     return E.func_CompactRoundNumber(result)
-- end
----------------------------------------------------------------
local GetSpellName = GetSpellName or C_Spell.GetSpellName
function E.func_GetSpellName(id)
	if GetSpellName then
		return GetSpellName(id)
		-- elseif GetSpellInfo and GetSpellInfo(id) then
		-- 	result = GetSpellInfo(id)
		-- 	-- /dump GetSpellInfo(20271)
		-- end
	end
end
----------------------------------------------------------------
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or GetSpellInfo
function E.func_GetSpellInfo(id)
	local spellData = GetSpellInfo(id)
	if type(spellData) == "table" then
		return spellData.name, spellData.iconID, spellData.originalIconID, spellData.castTime, spellData.minRange, spellData.maxRange, spellData.spellID
	elseif type(spellData) == "string" then
		return GetSpellInfo(id) -- name, subtext, icon, castTime, minRange, maxRange, spellID, originalIcon
	else
		return E.func_GetSpellName(id)
	end
end
----------------------------------------------------------------
local GetSpellLink = C_Spell and C_Spell.GetSpellLink or GetSpellLink
function E.func_GetSpellLink(id)
	if GetSpellLink then
		return GetSpellLink(id)
	end
end
----------------------------------------------------------------
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
function E.func_GetSpellSubtext(id)
	if GetSpellSubtext then
		return GetSpellSubtext(id)
	end
end
----------------------------------------------------------------
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
function E.func_GetSpellTexture(id)
	if GetSpellTexture then
		return GetSpellTexture(id)
	end
end
----------------------------------------------------------------
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
function E.func_GetSpellCharges(id)
	if GetSpellCharges then
		return GetSpellCharges(id)
	end
end
----------------------------------------------------------------
-- C_TradeSkillUI ----------------------------------------------
----------------------------------------------------------------
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
function E.func_GetTradeSkillDisplayName(id)
	if GetTradeSkillDisplayName then
		return GetTradeSkillDisplayName(id)
	end
end
----------------------------------------------------------------
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
function E.func_GetTradeSkillTexture(id)
	if GetTradeSkillTexture then
		return GetTradeSkillTexture(id)
	end
end
----------------------------------------------------------------
local GetAllProfessionTradeSkillLines = GetAllProfessionTradeSkillLines or C_TradeSkillUI.GetAllProfessionTradeSkillLines
function E.func_GetAllProfessionTradeSkillLines()
	if GetAllProfessionTradeSkillLines then
		return GetAllProfessionTradeSkillLines()
	end
end
----------------------------------------------------------------
local GetProfessionInfoBySkillLineID = GetProfessionInfoBySkillLineID or C_TradeSkillUI.GetProfessionInfoBySkillLineID
function E.func_GetProfessionInfoBySkillLineID(id)
	if GetProfessionInfoBySkillLineID then
		return GetProfessionInfoBySkillLineID(id)
	end
end
----------------------------------------------------------------
local GetProfessionInfo = GetProfessionInfo -- https://warcraft.wiki.gg/wiki/API_GetProfessionInfo
function E.func_GetProfessionInfo(index) -- GetProfessions()
	if GetProfessionInfo then
		return GetProfessionInfo(index) -- name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset, skillLineName
	end
end
----------------------------------------------------------------
-- C_DateAndTime -----------------------------------------------
----------------------------------------------------------------
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
function E.func_GetCurrentCalendarTime()
	if GetCurrentCalendarTime then
		return GetCurrentCalendarTime()
	end
end
----------------------------------------------------------------
local GetSecondsUntilWeeklyReset = GetSecondsUntilWeeklyReset or C_DateAndTime.GetSecondsUntilWeeklyReset
function E.func_GetSecondsUntilWeeklyReset()
	if GetSecondsUntilWeeklyReset then
		return GetSecondsUntilWeeklyReset()
	else
		return 0
	end
end
----------------------------------------------------------------
local GetWeeklyResetStartTime = GetWeeklyResetStartTime or C_DateAndTime.GetWeeklyResetStartTime
function E.func_GetWeeklyResetStartTime()
	if GetWeeklyResetStartTime then
		return GetWeeklyResetStartTime()
	else
		return 0
	end
end
----------------------------------------------------------------
local GetSecondsUntilDailyReset = GetSecondsUntilDailyReset or C_DateAndTime.GetSecondsUntilDailyReset
function E.func_GetSecondsUntilDailyReset()
	local func = GetSecondsUntilDailyReset or GetQuestResetTime
	if func then
		return func()
	else
		return 0
	end
end
----------------------------------------------------------------
-- C_Calendar --------------------------------------------------
----------------------------------------------------------------
local GetHolidayInfo = GetHolidayInfo or C_Calendar.GetHolidayInfo
function E.func_GetHolidayInfo(monthOffset, monthDay, index)
	if GetHolidayInfo then
		return GetHolidayInfo(monthOffset, monthDay, index)
	end
end
----------------------------------------------------------------
local GetDayEvent = GetDayEvent or C_Calendar.GetDayEvent
function E.func_GetDayEvent(monthOffset, monthDay, index)
	if GetDayEvent then
		return GetDayEvent(monthOffset, monthDay, index)
	end
end
----------------------------------------------------------------
local GetMonthInfo = GetMonthInfo or C_Calendar.GetMonthInfo
function E.func_GetMonthInfo(offsetMonths)
	if GetMonthInfo then
		return GetMonthInfo(offsetMonths)
	end
end
----------------------------------------------------------------
local SetAbsMonth = SetAbsMonth or C_Calendar.SetAbsMonth
function E.func_SetAbsMonth(month, year)
	if SetAbsMonth then
		return SetAbsMonth(month, year)
	end
end
----------------------------------------------------------------
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
function E.func_GetNumDayEvents(offsetMonths, monthDay)
	if GetNumDayEvents then
		return GetNumDayEvents(offsetMonths, monthDay)
	end
end
----------------------------------------------------------------
-- C_MountJournal ----------------------------------------------
----------------------------------------------------------------
local GetMountIDs = GetMountIDs or C_MountJournal.GetMountIDs
function E.func_GetMountIDs()
	if GetMountIDs then
		return GetMountIDs()
	end
end
----------------------------------------------------------------
local GetMountInfoByID = GetMountInfoByID or C_MountJournal.GetMountInfoByID -- C_MountJournal.GetDisplayedMountInfo(displayIndex)
function E.func_GetMountInfoByID(id)
	if GetMountInfoByID then
		return GetMountInfoByID(id)
	end
end
----------------------------------------------------------------
local GetMountInfoExtraByID = GetMountInfoExtraByID or C_MountJournal.GetMountInfoExtraByID -- C_MountJournal.GetDisplayedMountInfoExtra(index)
function E.func_GetMountInfoExtraByID(id)
	if GetMountInfoExtraByID then
		return GetMountInfoExtraByID(id)
	end
end
----------------------------------------------------------------
local GetMountFromItem = GetMountFromItem or C_MountJournal.GetMountFromItem
function E.func_GetMountFromItem(id)
	if GetMountFromItem then
		return GetMountFromItem(id)
	end
end
----------------------------------------------------------------
-- C_Item ------------------------------------------------------
----------------------------------------------------------------
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
function E.func_GetItemCooldown(itemID)
	if GetItemCooldown then
		return GetItemCooldown(itemID)
	end
end
----------------------------------------------------------------
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
function E.func_GetItemIconByID(itemID)
	if GetItemIconByID then
		return GetItemIconByID(itemID)
	end
end
----------------------------------------------------------------
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
function E.func_GetItemNameByID(itemID)
	if GetItemNameByID then
		return GetItemNameByID(itemID)
	end
end
----------------------------------------------------------------
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
function E.func_GetItemQualityByID(itemID)
	if GetItemQualityByID then
		return GetItemQualityByID(itemID) or 0
	end
end
----------------------------------------------------------------
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
function E.func_GetItemQualityColor(itemID)
	if GetItemQualityColor then
		return GetItemQualityColor(itemID)
	end
end
----------------------------------------------------------------
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
function E.func_IsAnimaItemByID(itemID)
	if IsAnimaItemByID then
		return IsAnimaItemByID(itemID)
	end
end
----------------------------------------------------------------
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
function E.func_GetDetailedItemLevelInfo(itemID)
	if GetDetailedItemLevelInfo then
		return GetDetailedItemLevelInfo(itemID)
	end
end
----------------------------------------------------------------
local GetItemCount = GetItemCount or C_Item.GetItemCount
function E.func_GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if GetItemCount then
		return GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
function E.func_GetItemInfo(itemIDorLink)
	if GetItemInfo then
		return GetItemInfo(itemIDorLink)
	end
end
----------------------------------------------------------------
local GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant
function E.func_GetItemInfoInstant(itemID)
	if GetItemInfoInstant then
		return GetItemInfoInstant(itemID)
	end
end
----------------------------------------------------------------
-- C_Garrison -------------------------------------------------
----------------------------------------------------------------
-- local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
-- local IsFollowerOnCompletedMission = IsFollowerOnCompletedMission or C_Garrison.IsFollowerOnCompletedMission
-- local GetFollowerNameByID = GetFollowerNameByID or C_Garrison.GetFollowerNameByID -- (garrFollowerID)
-- local GetFollowerName = GetFollowerName or C_Garrison.GetFollowerName -- (followerID)
----------------------------------------------------------------
-- C_Container -------------------------------------------------
----------------------------------------------------------------
local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots
function E.func_GetContainerNumSlots(bagID)
	if GetContainerNumSlots then
		return GetContainerNumSlots(bagID)
	end
end
----------------------------------------------------------------
local GetContainerItemInfo = GetContainerItemInfo or C_Container.GetContainerItemInfo
function E.func_GetContainerItemInfo(bagID, slotIndex)
	if GetContainerItemInfo then
		return GetContainerItemInfo(bagID, slotIndex)
	end
end
----------------------------------------------------------------
local GetContainerItemID = GetContainerItemID or C_Container.GetContainerItemID
function E.func_GetContainerItemID(bagID, slotIndex) -- containerIndex, slotIndex
	if GetContainerItemID then
		return GetContainerItemID(bagID, slotIndex) -- containerIndex, slotIndex
	end
end
----------------------------------------------------------------
local GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink
function E.func_GetContainerItemLink(bagID, slotIndex)
	if GetContainerItemLink then
		return GetContainerItemLink(bagID, slotIndex)
	end
end
----------------------------------------------------------------
local UseContainerItem = UseContainerItem or C_Container.UseContainerItem
function E.func_UseContainerItem(bagID, slotIndex)
	if UseContainerItem then
		return UseContainerItem(bagID, slotIndex)
	end
end
----------------------------------------------------------------
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots
function E.func_GetContainerNumFreeSlots(bagID) -- free, bagType
	if GetContainerNumFreeSlots then
		return GetContainerNumFreeSlots(bagID)
	end
end
----------------------------------------------------------------
local PickupContainerItem = PickupContainerItem or C_Container.PickupContainerItem
function E.func_PickupContainerItem(bagID, slotIndex)
	if PickupContainerItem then
		return PickupContainerItem(bagID, slotIndex)
	end
end
----------------------------------------------------------------
-- C_QuestLog --------------------------------------------------
----------------------------------------------------------------
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
function E.func_GetQuestInfo(id)
	if GetQuestInfo then
		return GetQuestInfo(id)
	end
end
----------------------------------------------------------------
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
function E.func_IsQuestFlaggedCompleted(id)
	if IsQuestFlaggedCompleted then
		return IsQuestFlaggedCompleted(id)
	end
end
----------------------------------------------------------------
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
function E.func_IsQuestFlaggedCompletedOnAccount(id)
	if IsQuestFlaggedCompletedOnAccount then
		return IsQuestFlaggedCompletedOnAccount(id)
	end
end
----------------------------------------------------------------
local IsComplete = IsComplete or C_QuestLog.IsComplete
function E.func_IsComplete(id)
	if IsComplete then
		return IsComplete(id)
	end
end
----------------------------------------------------------------
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
function E.func_IsOnQuest(id)
	if IsOnQuest then
		return IsOnQuest(id)
	end
end
----------------------------------------------------------------
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
function E.func_GetQuestObjectives(id)
	if GetQuestObjectives then
		return GetQuestObjectives(id)
	end
end
----------------------------------------------------------------
local GetInfo = GetInfo or C_QuestLog.GetInfo
function E.func_GetInfo(id)
	if GetInfo then
		return GetInfo(id)
	end
end
----------------------------------------------------------------
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
function E.func_IsAccountQuest(id)
	if IsAccountQuest then
		return IsAccountQuest(id)
	end
end
----------------------------------------------------------------
local IsFailed = IsFailed or C_QuestLog.IsFailed
function E.func_IsFailed(id)
	if IsFailed then
		return IsFailed(id)
	end
end
----------------------------------------------------------------
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
function E.func_GetNumQuestLogEntries() -- numShownEntries, numQuests
	if GetNumQuestLogEntries then
		return GetNumQuestLogEntries()
	end
end
----------------------------------------------------------------
local GetMaxNumQuestsCanAccept = GetMaxNumQuestsCanAccept or C_QuestLog.GetMaxNumQuestsCanAccept
function E.func_GetMaxNumQuestsCanAccept()
	if GetMaxNumQuestsCanAccept then
		return GetMaxNumQuestsCanAccept()
	end
end
----------------------------------------------------------------
local GetAllCompletedQuestIDs = GetAllCompletedQuestIDs or C_QuestLog.GetAllCompletedQuestIDs
function E.func_GetAllCompletedQuestIDs()
	local ok, result = pcall(GetAllCompletedQuestIDs)
	return ok and type(result) == "table" and result or {}
end
----------------------------------------------------------------
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
function E.func_GetTitleForQuestID(id)
	if GetTitleForQuestID then
		return GetTitleForQuestID(id)
	end
end
----------------------------------------------------------------
local GetQuestTagInfo = GetQuestTagInfo or C_QuestLog.GetQuestTagInfo
function E.func_GetQuestTagInfo(id)
	if GetQuestTagInfo then
		return GetQuestTagInfo(id)
	end
end
----------------------------------------------------------------
-- C_MajorFactions ---------------------------------------------
----------------------------------------------------------------
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
function E.func_GetMajorFactionData(id)
	if GetMajorFactionData then
		return GetMajorFactionData(id)
	end
end
----------------------------------------------------------------
local GetRenownLevels = GetRenownLevels or C_MajorFactions.GetRenownLevels
function E.func_GetRenownLevels(id)
	if GetRenownLevels then
		return GetRenownLevels(id)
	end
end
----------------------------------------------------------------
function E.func_GetMaxRenownLevel(id)
	local levels = E.func_GetRenownLevels(id)
	if levels then
		return levels[#levels].level
	else
		return 0
	end
end
----------------------------------------------------------------
-- C_GossipInfo ------------------------------------------------
----------------------------------------------------------------
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
function E.func_GetFriendshipReputationRanks(id)
	if GetFriendshipReputationRanks then
		return GetFriendshipReputationRanks(id)
	end
end
----------------------------------------------------------------
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
function E.func_GetFriendshipReputation(id)
	if GetFriendshipReputation then
		return GetFriendshipReputation(id)
	end
end
----------------------------------------------------------------
-- C_Reputation ------------------------------------------------
----------------------------------------------------------------
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
function E.func_IsFactionParagon(id)
	if IsFactionParagon then
		return IsFactionParagon(id)
	end
end
----------------------------------------------------------------
local IsFactionParagonForCurrentPlayer = IsFactionParagonForCurrentPlayer or C_Reputation.IsFactionParagonForCurrentPlayer
function E.func_IsFactionParagonForCurrentPlayer(id)
	local func = IsFactionParagonForCurrentPlayer or IsFactionParagon
	if func then
		return func(id)
	end
end
----------------------------------------------------------------
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
function E.func_GetFactionParagonInfo(id)
	if GetFactionParagonInfo then
		return GetFactionParagonInfo(id)
	end
end
----------------------------------------------------------------
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
function E.func_IsAccountWideReputation(id)
	if IsAccountWideReputation then
		return IsAccountWideReputation(id)
	end
end
----------------------------------------------------------------
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
function E.func_IsMajorFaction(id)
	if IsMajorFaction then
		return IsMajorFaction(id)
	end
end
----------------------------------------------------------------
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
function E.func_GetFactionDataByID(id)
	if GetFactionDataByID then
		return GetFactionDataByID(id)
	end
end
----------------------------------------------------------------
function E.func_GetFactionInfoByID(id) -- 10.2.7
	if GetFactionInfoByID then
		return GetFactionInfoByID(id)
	end
end
----------------------------------------------------------------
-- C_ChallengeMode ---------------------------------------------
----------------------------------------------------------------
local SlotKeystone = SlotKeystone or C_ChallengeMode.SlotKeystone
function E.func_SlotKeystone()
	if SlotKeystone then
		return SlotKeystone()
	end
end
----------------------------------------------------------------
local GetMapUIInfo = GetMapUIInfo or C_ChallengeMode.GetMapUIInfo
function E.func_GetMapUIInfo(id)
	if GetMapUIInfo then
		return GetMapUIInfo(id)
	end
end
----------------------------------------------------------------
local GetOverallDungeonScore = GetOverallDungeonScore or C_ChallengeMode.GetOverallDungeonScore
function E.func_GetOverallDungeonScore()
	if GetOverallDungeonScore then
		return GetOverallDungeonScore()
	end
end
----------------------------------------------------------------
local GetMapTable = GetMapTable or C_ChallengeMode.GetMapTable
function E.func_GetMapTable()
	if GetMapTable then
		return GetMapTable()
	end
end
----------------------------------------------------------------
-- C_WeeklyRewards ---------------------------------------------
----------------------------------------------------------------
local HasAvailableRewards = HasAvailableRewards or C_WeeklyRewards.HasAvailableRewards
function E.func_HasAvailableRewards()
	if HasAvailableRewards then
		return HasAvailableRewards()
	end
end
----------------------------------------------------------------
local HasGeneratedRewards = HasGeneratedRewards or C_WeeklyRewards.HasGeneratedRewards
function E.func_HasGeneratedRewards()
	if HasGeneratedRewards then
		return HasGeneratedRewards()
	end
end
----------------------------------------------------------------
local GetNumCompletedDungeonRuns = GetNumCompletedDungeonRuns or C_WeeklyRewards.GetNumCompletedDungeonRuns
function E.func_GetNumCompletedDungeonRuns() -- tbl
	if GetNumCompletedDungeonRuns then
		return GetNumCompletedDungeonRuns()
	end
end
----------------------------------------------------------------
local GetActivities = GetActivities or C_WeeklyRewards.GetActivities
function E.func_GetActivities(id)
	if GetActivities then
		return GetActivities(id)
	end
end
----------------------------------------------------------------
local GetActivityEncounterInfo = GetActivityEncounterInfo or C_WeeklyRewards.GetActivityEncounterInfo
function E.func_GetActivityEncounterInfo(vaultTypeid, index)
	if GetActivityEncounterInfo then
		return GetActivityEncounterInfo(vaultTypeid, index)
	end
end
----------------------------------------------------------------
local OnUIInteract = OnUIInteract or C_WeeklyRewards.OnUIInteract
function E.func_OnUIInteract()
	if OnUIInteract then
		return OnUIInteract()
	end
end
----------------------------------------------------------------
local GetExampleRewardItemHyperlinks = GetExampleRewardItemHyperlinks or C_WeeklyRewards.GetExampleRewardItemHyperlinks
function E.func_GetExampleRewardItemHyperlinks(id)
	if GetExampleRewardItemHyperlinks then
		return GetExampleRewardItemHyperlinks(id)
	end
end
----------------------------------------------------------------
-- C_MythicPlus ------------------------------------------------
----------------------------------------------------------------
local GetCurrentAffixes = GetCurrentAffixes or C_MythicPlus.GetCurrentAffixes
function E.func_GetCurrentAffixes() -- tbl
	if GetCurrentAffixes then
		return GetCurrentAffixes()
	end
end
----------------------------------------------------------------
local GetCurrentSeason = GetCurrentSeason or C_MythicPlus.GetCurrentSeason
function E.func_GetCurrentSeason()
	local CurrentSeason = GetCurrentSeason()
	if CurrentSeason == nil or CurrentSeason == false or CurrentSeason == 0 or CurrentSeason == -1 then
		return 1
	else
		return CurrentSeason -- (9 DF) (17 MiD)
	end
end
----------------------------------------------------------------
-- local GetCurrentSeasonValues = GetCurrentSeasonValues or C_MythicPlus.GetCurrentSeasonValues
----------------------------------------------------------------
local GetCurrentUIDisplaySeason = GetCurrentUIDisplaySeason or C_MythicPlus.GetCurrentUIDisplaySeason
function E.func_GetCurrentUIDisplaySeason() -- 1
	if GetCurrentUIDisplaySeason then
		return GetCurrentUIDisplaySeason()
	end
end
----------------------------------------------------------------
local GetOwnedKeystoneLevel = GetOwnedKeystoneLevel or C_MythicPlus.GetOwnedKeystoneLevel
function E.func_GetOwnedKeystoneLevel() -- 21
	if GetOwnedKeystoneLevel then
		return GetOwnedKeystoneLevel()
	end
end
----------------------------------------------------------------
-- local GetOwnedKeystoneMapID = GetOwnedKeystoneMapID or C_MythicPlus.GetOwnedKeystoneMapID
----------------------------------------------------------------
-- local GetRewardLevelForDifficultyLevel = GetRewardLevelForDifficultyLevel or C_MythicPlus.GetRewardLevelForDifficultyLevel
----------------------------------------------------------------
-- local GetRewardLevelFromKeystoneLevel = GetRewardLevelFromKeystoneLevel or C_MythicPlus.GetRewardLevelFromKeystoneLevel
----------------------------------------------------------------
local GetRunHistory = GetRunHistory or C_MythicPlus.GetRunHistory
function E.func_GetRunHistory(includePreviousWeeks, includeIncompleteRuns)
	if GetRunHistory then
		return GetRunHistory(includePreviousWeeks or false, includeIncompleteRuns or true)
	end
end
----------------------------------------------------------------
-- local GetSeasonBestAffixScoreInfoForMap = GetSeasonBestAffixScoreInfoForMap or C_MythicPlus.GetSeasonBestAffixScoreInfoForMap
----------------------------------------------------------------
-- local GetSeasonBestForMap = GetSeasonBestForMap or C_MythicPlus.GetSeasonBestForMap
----------------------------------------------------------------
-- local GetSeasonBestMythicRatingFromThisExpansion = GetSeasonBestMythicRatingFromThisExpansion or C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion
----------------------------------------------------------------
local GetWeeklyBestForMap = GetWeeklyBestForMap or C_MythicPlus.GetWeeklyBestForMap
function E.func_GetWeeklyBestForMap(id)
	if GetWeeklyBestForMap then
		return GetWeeklyBestForMap(id)
	end
end
----------------------------------------------------------------
local GetWeeklyChestRewardLevel = GetWeeklyChestRewardLevel or C_MythicPlus.GetWeeklyChestRewardLevel
function E.func_GetWeeklyChestRewardLevel()
	if GetWeeklyChestRewardLevel then
		return GetWeeklyChestRewardLevel()
	end
end
----------------------------------------------------------------
local IsMythicPlusActive = IsMythicPlusActive or C_MythicPlus.IsMythicPlusActive
function E.func_IsMythicPlusActive() -- true
	if IsMythicPlusActive then
		return IsMythicPlusActive()
	end
end
----------------------------------------------------------------
-- local RequestCurrentAffixes = RequestCurrentAffixes or C_MythicPlus.RequestCurrentAffixes
----------------------------------------------------------------
local GetOwnedKeystoneChallengeMapID = GetOwnedKeystoneChallengeMapID or C_MythicPlus.GetOwnedKeystoneChallengeMapID
function E.func_GetOwnedKeystoneChallengeMapID() -- 401
	if GetOwnedKeystoneChallengeMapID then
		return GetOwnedKeystoneChallengeMapID()
	end
end
----------------------------------------------------------------
local GetLastWeeklyBestInformation = GetLastWeeklyBestInformation or C_MythicPlus.GetLastWeeklyBestInformation
function E.func_GetLastWeeklyBestInformation()
	if GetLastWeeklyBestInformation then
		return GetLastWeeklyBestInformation()
	end
end
----------------------------------------------------------------
local RequestRewards = RequestRewards or C_MythicPlus.RequestRewards
function E.func_RequestRewards()
	if RequestRewards then
		return RequestRewards()
	end
end
----------------------------------------------------------------
local RequestMapInfo = RequestMapInfo or C_MythicPlus.RequestMapInfo
function E.func_RequestMapInfo()
	if RequestMapInfo then
		return RequestMapInfo()
	end
end
----------------------------------------------------------------
-- local GetEndOfRunGearSequenceLevel = GetEndOfRunGearSequenceLevel or C_MythicPlus.GetEndOfRunGearSequenceLevel
----------------------------------------------------------------
----------------------------------------------------------------
-- C_Map -------------------------------------------------------
----------------------------------------------------------------
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
function E.func_GetMapInfo(id)
	if GetMapInfo then
		return GetMapInfo(id)
	end
end
----------------------------------------------------------------
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
function E.func_GetMapGroupID(uiMapID)
	if GetMapGroupID then
		return GetMapGroupID(uiMapID)
	end
end
----------------------------------------------------------------
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
function E.func_GetMapGroupMembersInfo(uiMapGroupID)
	if GetMapGroupMembersInfo then
		return GetMapGroupMembersInfo(uiMapGroupID)
	end
end
----------------------------------------------------------------
local GetBestMapForUnit = GetBestMapForUnit or C_Map.GetBestMapForUnit
function E.func_GetBestMapForUnit(unit)
	if GetBestMapForUnit then
		return GetBestMapForUnit(unit or "player")
	end
end
----------------------------------------------------------------
local GetPlayerMapPosition = GetPlayerMapPosition or C_Map.GetPlayerMapPosition
function E.func_GetPlayerMapPosition(mapID, unit)
	if GetPlayerMapPosition then
		return GetPlayerMapPosition(mapID, unit or "player")
	end
end
----------------------------------------------------------------