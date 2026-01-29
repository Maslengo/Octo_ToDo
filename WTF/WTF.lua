local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
local L = E.L
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
function EventFrame:func_CacheGameData()
	----------------------------------------------------------------
	-- E.DEBUG_START()
	----------------------------------------------------------------
	local ALL_Currencies = E.ALL_Currencies
	----------------------------------------------------------------
	-- Сливаем таблицы предметов и квестов
	local itemTables = {
		E.KeyStoneTBL,
		E.OctoTable_itemID_MECHAGON,
		E.OctoTable_itemID_ALL,
		E.OctoTable_itemID_Ignore_List,
		E.OctoTable_itemID_Cataloged_Research,
		Octo_Cache_DB and Octo_Cache_DB.AllItems,
	}
	-- Проход по предметам и квестам из таблиц
	for i = 1, #itemTables do
		local tbl = itemTables[i]
		if tbl then
			for id in next, tbl do
				E.ALL_Items[id] = true
			end
		end
	end
	for questID in next, (E.OctoTable_QuestID) do
		E.ALL_Quests[questID] = true
	end
	-- QuestLog квесты
	local numQuests = C_QuestLog.GetNumQuestLogEntries()
	for i = 1, numQuests do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			E.ALL_Quests[info.questID] = true
		end
	end
	-- Проход по персонажам и их инвентарю/квестам
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo then
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			if cm and cm.ListOfQuests then
				for qid in next, cm.ListOfQuests do
					E.ALL_Quests[qid] = true
				end
			end
			if cm and cm.InventoryType then
				local inv = cm.InventoryType
				for slotID in next, (E.OctoTable_SlotMapping) do
					local slot = inv[slotID]
					if slot and slot.ItemID then
						E.ALL_Items[slot.ItemID] = true
					end
				end
			end
		end
	end
	----------------------------------------------------------------
	-- Асинхронная загрузка
	local promise = LibThingsLoad:QuestsByKey(E.ALL_Quests)
	promise:AddItemsByKey(E.ALL_Items)
	:ThenForAllWithCached(function(_, ID, type)
			if type == "quest" then
				E.func_GetQuestName(ID)
			elseif type == "item" then
				E.func_GetItemName(ID)
				-- C_Item.GetItemQualityByID(ID)
			end
	end)
	----------------------------------------------------------------
	-- E.DEBUG_STOP("func_CacheGameData")
	----------------------------------------------------------------
end
function EventFrame:func_RemoveDuplicateCharacters()
	if not Octo_ToDo_DB_Levels then return end
	local currentGUID = E.curGUID
	local currentName = E.curCharName
	local currentRealm = E.func_GetPlayerRealm()
	local foundDuplicates = false
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd then
			if pd.Name and pd.curServer and
			pd.Name == currentName and
			pd.curServer == currentRealm then
				if GUID ~= currentGUID then
					foundDuplicates = true
					break
				end
			end
		end
	end
	if foundDuplicates then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			local pd = CharInfo and CharInfo.PlayerData
			local cm = CharInfo and CharInfo.MASLENGO
			if pd then
				if pd.Name and pd.curServer and
				pd.Name == currentName and
				pd.curServer == currentRealm then
					if GUID ~= currentGUID then
						E.func_PrintMessage("Removing duplicate: ", pd.Name.."-"..pd.curServer, "GUID:", GUID)
						Octo_ToDo_DB_Levels[GUID] = nil
					else
						E.func_PrintMessage("Keeping current: ", pd.Name.."-"..pd.curServer, "GUID:", GUID)
					end
				end
			end
		end
	end
end
function EventFrame:func_DatabaseClear()
	local enable = true
	if not enable then return end
	if Octo_ToDo_DB_Levels then
		E.func_RemoveZeroValues(Octo_ToDo_DB_Levels, "^0/")
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo.MASLENGO and CharInfo.MASLENGO.CurrencyID_Total then
				E.func_RemoveZeroValues(CharInfo.MASLENGO.CurrencyID_Total, "anynumber")
			end
			if string.find(CharInfo.PlayerData.Name, "^WTF:") then
				E.func_PrintMessage("Remove: ", CharInfo.PlayerData.Name)
				Octo_ToDo_DB_Levels[GUID] = nil
			end
		end
	end
	local rules = {
		zero = true,
		emptyString = true,
		falseValue = false,
		values = {
			"Done",
			"0/0",
			0,
		},
		strings = {
			"|cff",
			"|r",
			"#%d+/",
		},
		keepKeys = {
			"PlayerData",
			"CharInfo",
		}
	}
	E.func_CleanDeepTable(Octo_profileKeys, rules)
	E.func_CleanDeepTable(Octo_profileColors, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Levels, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Vars, rules)
	E.func_CleanDeepTable(Octo_Cache_DB, rules)
end
function EventFrame:init_Octo_ToDo_DB_Levels()
	local curGUID = UnitGUID("player")
	if not curGUID then return end
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	Octo_ToDo_DB_Levels[curGUID] = Octo_ToDo_DB_Levels[curGUID] or {}
	local ServerTime = GetServerTime()
	local currentDate = date("%d.%m.%Y")
	local currentTime = date("%H:%M")
	local currentDateTime = date("%d.%m.%Y %H:%M:%S")
	local defaults = {
		BattleTag = E.BattleTag,
		BattleTagLocal = E.BattleTagLocal,
		buildDate = E.buildDate,
		buildNumber = E.buildNumber,
		buildVersion = E.buildVersion,
		classColor = E.classColor,
		classColorHex = E.classColorHexCurrent,
		className = E.className,
		classFilename = E.classFilename,
		CurrentRegion = GetCurrentRegion(),
		CurrentRegionName = E.CurrentRegionName,
		curServer = E.func_GetPlayerRealm(),
		curServerShort = E.curServerShort, -- E.func_GetRealmShortName(GetRealmName())
		currentTier = E.currentTier,
		Faction = "Neutral",
		GUID = curGUID,
		guildName = "",
		guildRankName = "",
		interfaceVersion = E.interfaceVersion,
		isShownPlayer = true,
		loginDate = currentDateTime,
		loginDay = currentDate,
		loginHour = currentTime,
		Name = "WTF:"..E.curCharName,
		PlayerDurability = 100,
		UnitSex = 1,
		-- Money = 0,
		realTotalTime = 1,

		levelCapped20 = false,
		GameLimitedMode_IsActive = false,
		specName = E.NONE,
		IsRestrictedAccount = false,
		specPrimaryStat = 0, -- НЕ ТАК
		MythicPlus = {
			[C_MythicPlus.GetCurrentSeason()] = {
			},
		},
		currentXP = 0,
		specId = 0, -- НЕ ТАК
		numShownEntries = 0,
		usedSlots_BAGS = 1,
		SL_Possible_Anima = 0,
		totalSlots_BAGS = 16,
		UnitXPMax = 0,
		specIcon = E.ICON_QUESTION_MARK,
		RaceID = 0,  -- НЕ ТАК
		PVP_timer = 0,
		LuaVersion = _VERSION,
		BindLocation = E.NONE,
		UnitXPPercent = 0,
		GetRestrictedAccountData_rMoney = 0,
		MythicPlus_seasonID = C_MythicPlus.GetCurrentSeason(), -- 0
		GetRestrictedAccountData_rLevel = 0,
		specRole = "DAMAGER", -- не так
		classId = 0, -- не так
		UnitLevel = 1,
		IsVeteranTrialAccount = false,
		curLocation = E.NONE,
		IsPublicBuild = true,
		realLevelTime = 0,
		maxNumQuestsCanAccept = 0,
		HasAvailableRewards = false,
		-- avgItemLevel = 0,
		-- avgItemLevelPvp = 0,
		-- avgItemLevelEquipped = 0,
		Chromie_inChromieTime = false,
		Chromie_UnitChromieTimeID = 0,
		Chromie_name = "",
		Chromie_canEnter = false,
		tmstp_Daily = 0, -- C_DateAndTime.GetSecondsUntilDailyReset() + GetServerTime(),
		tmstp_Weekly = 0, -- C_DateAndTime.GetSecondsUntilWeeklyReset() + GetServerTime(),
		time = GetServerTime(), -- GetServerTime()
	}
	local MASLENGO_DEFAULTS = {
		Currency = {},
		GARRISON = {},
		LegionRemixData = {},
		GreatVault = {},
		Items = {},
		journalInstance = {},
		LFGInstance = {},
		ListOfQuests = {},
		ListOfParagonQuests = {},
		OctoTable_QuestID = {},
		professions = {
		},
		Reputation = {},
		SavedWorldBoss = {},
		UniversalQuest = {},
	}
	local GARRISON_default = {
		cacheSize = 0,
		curRes = 0,
		lastCacheTime = 0,
	}
	local GARRISON_DEFAULTS = {
		buids = {
		},
		summary = {
			inProgress = {},
		},
	}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		CharInfo.MASLENGO = CharInfo.MASLENGO or {}
		CharInfo.PlayerData = CharInfo.PlayerData or {}
		local cm = CharInfo.MASLENGO
		local pd = CharInfo.PlayerData
		cm.Items = cm.Items or {}
		cm.Items.Bags = cm.Items.Bags or {}
		cm.Items.Bank = cm.Items.Bank or {}
		pd.CharDBVersion = pd.CharDBVersion or 1
		for k, v in next, (defaults) do
			E.func_InitField(pd, k, v)
		end
		for k, v in next, (MASLENGO_DEFAULTS) do
			if cm[k] == nil then
				cm[k] = type(v) == "table" and CopyTable(v) or v
			end
		end
		for k, v in next, (GARRISON_default) do
			E.func_InitField(cm.GARRISON, k, v)
		end
		pd.time = pd.time or pd.tmstp_Daily or ServerTime
		pd.MoneyOnLogin = pd.MoneyOnLogin or pd.Money
		pd.MoneyOnDaily = pd.MoneyOnDaily or pd.Money
		pd.MoneyOnWeekly = pd.MoneyOnWeekly or pd.Money
		for k, v in next, (GARRISON_DEFAULTS) do
			if cm.GARRISON[k] == nil then
				cm.GARRISON[k] = type(v) == "table" and CopyTable(v) or v
			end
		end
		for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
			cm.GreatVault[i] = cm.GreatVault[i] or {}
		end
	end
end
function EventFrame:init_Octo_ToDo_DB_AccountData()
	Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank or {}
end
function EventFrame:init_Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	local featureDefaults = {
		Config_SPAM_TIME = 2,
		Config_ADDON_HEIGHT = 20,
		Config_AchievementShowCompleted = true,
		Config_ClampedToScreen = false,
		Config_LevelToShow = 1,
		Config_LevelToShowMAX = 90,
		Config_numberFormatMode = 1,
		Currencies = true,
		Config_Texture = "Blizzard Raid Bar",
		isOnlyCurrentFaction = false,
		ShowOnlyCurrentRegion = true,
		isOnlyCurrentServer = false,
		Config_DebugID_ALL = false,
		GlobalDBVersion = 0,
		Config_UseTranslit = false,
		Config_ShowAllDifficulties = true, -- E.Config_ShowAllDifficulties,
		Config_DifficultyAbbreviation = true,
	}
	for k, v in next, (featureDefaults) do
		E.func_InitField(Octo_ToDo_DB_Vars, k, v)
	end
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	--------------------------------------------------------------------------------
	-- opde(Octo_ToDo_DB_Vars)
	Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle or "|cffD177FFE|r|cffCA79FDx|r|cffC47CFBp|r|cffBD7EF9r|r|cffB781F7e|r|cffB084F5s|r|cffAA86F4s|r|cffA389F2w|r|cff9D8CF0a|r|cff968EEEy|r|cff9091EC |r|cff8994EAR|r|cff8396E9g|r|cff7C99E7 |r|cff769CE5B|r|cff6F9EE3o|r|cff69A1E1l|r|cff63A4E0d|r"
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or 11
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags or "OUTLINE"
end

function E.init_Octo_ToDo_DB_Vars()
	EventFrame:init_Octo_ToDo_DB_Vars()
	return
end



function EventFrame:Init_Octo_Cache_DB()
	Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB.interfaceVersion = E.interfaceVersion
	E.func_InitSubTable(Octo_Cache_DB, "AllItems")
	E.func_InitSubTable(Octo_Cache_DB, "AllDungeons")
	E.func_InitSubTable(Octo_Cache_DB, "SavedInstanceID_to_EJInstance")
	E.func_InitSubTable(Octo_Cache_DB, "EJInstance_to_SavedInstanceID")
	E.func_InitSubTable(Octo_Cache_DB, "AllCurrencies")
	E.func_InitSubTable(Octo_Cache_DB, "AllNPCs")
	E.func_InitSubTable(Octo_Cache_DB, "AllQuests")
	E.func_InitSubTable(Octo_Cache_DB, "AllReputations")
	E.func_InitSubTable(Octo_Cache_DB, "AllSpells")
	E.func_InitSubTable(Octo_Cache_DB, "AllAchievements")
	E.func_InitSubTable(Octo_Cache_DB, "AllVignettes")
	E.func_InitSubTable(Octo_Cache_DB, "AllEvents")
	E.func_InitSubTable(Octo_Cache_DB, "AllProfessions")
	E.func_InitSubTable(Octo_Cache_DB, "AllDifficulty")
end
function EventFrame:init_Octo_profileColors()
	Octo_profileColors = Octo_profileColors or {}
	local db = Octo_profileColors
	db.profiles = db.profiles or {}
	E.func_CreateNew_profileColors("Default")

	if Octo_profileColors and Octo_profileColors.profiles then
		for profileName in next, (Octo_profileColors.profiles) do
			if profileName ~= "Default" then
				E.func_CreateNew_profileColors("Default")
			end
		end
	end
	E.func_CheckALL_profileColors()
	-- C_Timer.After(1, function()
	-- 	opde(db)
	-- end)
end

function E.init_Octo_profileColors()
	EventFrame:init_Octo_profileColors()
	return
end


function EventFrame:init_Octo_profileKeys()
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	E.func_CreateNew_profileKeys("Default")

	if Octo_profileKeys and Octo_profileKeys.profiles then
		for profileName in next, (Octo_profileKeys.profiles) do
			if profileName ~= "Default" then
				E.func_CreateNew_profileKeys(profileName)
			end
		end
	end
	if not Octo_ToDo_DB_Levels then return end
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		if pd and pd.Name and pd.curServer then
			local key = pd.Name .. " - " .. pd.curServer
			db.profileKeys[key] = db.profileKeys[key] or "Default"
		end
	end
end







function EventFrame:func_Daily_Reset()
	local ServerTime = GetServerTime()
	E.Reset_JournalInstance()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd.tmstp_Daily and pd.tmstp_Daily < ServerTime then
			pd.tmstp_Daily = pd.tmstp_Daily + 86400
			pd.needResetDaily = true
			for _, data in next, (E.ALL_UniversalQuests) do
				if data.reset == "Daily" then
					local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
					cm.UniversalQuest[questKey] = nil
				end
			end
			wipe(cm.LFGInstance)
			if pd.MoneyOnDaily and pd.Money then
				pd.MoneyOnDaily = pd.Money
			end
			if cm.LegionRemixData and cm.LegionRemixData.barValue and cm.LegionRemixData.barMax then
				if cm.LegionRemixData.barValue > 3 then
					cm.LegionRemixData.barValue = cm.LegionRemixData.barValue - 3
				end
			end
		end
	end
end
function EventFrame:func_Weekly_Reset()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd and cm then
			if pd.tmstp_Weekly and pd.tmstp_Weekly < ServerTime then
				pd.tmstp_Weekly = pd.tmstp_Weekly + 86400*7
				pd.needResetWeekly = true
				if cm.GreatVault and cm.GreatVault.NextWeekReward then
					pd.HasAvailableRewards = true
				end
				pd.OwnedKeystoneLevel = nil
				pd.OwnedKeystoneChallengeMapID = nil
				pd.RIO_weeklyBest = nil
				cm.journalInstance = {}
				cm.SavedWorldBoss = {}
				cm.LFGInstance = {}
				cm.GreatVault = {}
				for _, data in next, (E.ALL_UniversalQuests) do
					if data.reset == "Weekly" then
						local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						cm.UniversalQuest[questKey] = nil
					end
				end
				if pd.MoneyOnWeekly and pd.Money then
					pd.MoneyOnWeekly = pd.Money
				end
			end
		end
	end
end
function EventFrame:func_Month_Reset()
	local tmstp_Month = E.func_GetNextResetTime(365/12)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd and cm then
			if (pd.tmstp_Month or 0) < GetServerTime() then
				pd.tmstp_Month = tmstp_Month
				pd.needResetMonth = true
				for _, data in next, (E.ALL_UniversalQuests) do
					if data.reset == "Month" then
						local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						cm.UniversalQuest[questKey] = nil
					end
				end
			end
		end
	end
end
function EventFrame:func_CheckAll()
	EventFrame:func_RemoveDuplicateCharacters()
	EventFrame:init_Octo_ToDo_DB_Levels()
	EventFrame:init_Octo_ToDo_DB_Vars()
	EventFrame:init_Octo_ToDo_DB_AccountData()
	EventFrame:Init_Octo_Cache_DB()
	E.func_setOldChanges()
	EventFrame:func_Daily_Reset()
	EventFrame:func_Weekly_Reset()
	EventFrame:func_Month_Reset()
end


function E.WTF_func_CheckAll()
	EventFrame:func_CheckAll()
end



function EventFrame:func_ScheduleResetTimer()
	local function func_GetTimeToReset()
		if C_DateAndTime and C_DateAndTime.GetSecondsUntilDailyReset then
			return C_DateAndTime.GetSecondsUntilDailyReset()
		else
			return GetQuestResetTime()
		end
	end
	local seconds = func_GetTimeToReset()
	if seconds and seconds > 0 then
		if timerHandle then
			timerHandle:Cancel()
		end
		timerHandle = C_Timer.NewTimer(seconds + 4, function()
				EventFrame:func_CheckAll()
				E.func_Collect_All()
				EventFrame:func_ScheduleResetTimer()
		end)
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
	"UPDATE_INSTANCE_INFO",
	"PLAYER_ENTERING_WORLD",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	Octo_Cache_DB = Octo_Cache_DB or {}
	if Octo_Cache_DB.interfaceVersion ~= E.interfaceVersion then
		Octo_Cache_DB = {}
	end
	Octo_Cache_DB.interfaceVersion = E.interfaceVersion
	OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
	OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	EventFrame:init_Octo_profileKeys()
	EventFrame:init_Octo_profileColors()
	E.func_UpdateGlobals()
end
function EventFrame:VARIABLES_LOADED()
	EventFrame:func_CheckAll()
end
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CacheGameData()
	self:func_ScheduleResetTimer()
	E.Cache_All_EventNames_Year()
	C_Timer.After(1, E.func_UpdateGlobals)
end
local function Reset_JournalInstance()
	local ServerTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		for instanceID, v in next, (cm.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w and w.instanceReset and w.instanceReset < ServerTime then
						cm.journalInstance[instanceID][difficultyID] = nil
					end
				end
			end
		end
	end
end
function E.Reset_JournalInstance()
	E.func_SpamBlock(Reset_JournalInstance, true)
end
function EventFrame:UPDATE_INSTANCE_INFO()
	E.Reset_JournalInstance()
	E.func_RequestUIUpdate("UPDATE_INSTANCE_INFO")
end
function EventFrame:PLAYER_ENTERING_WORLD()
	local tbl1 = {}
	local tbl2 = {}
	local allDifficultyIDs = {
	}
	local function setActualInstances()
		local numTiers = EJ_GetNumTiers()
		if numTiers < 1 then
			return
		end
		local backupTier = EJ_GetCurrentTier()
		for tier = 1, numTiers do
			EJ_SelectTier(tier)
			for j = 1, 2 do
				local isRaid = j == 2
				local index = 1
				local jInstanceID = EJ_GetInstanceByIndex(index, isRaid)
				while jInstanceID do
					local name, _, _, _, _, _, _, _, _, instanceID = EJ_GetInstanceInfo(jInstanceID)
					tbl1[instanceID] = jInstanceID
					tbl2[jInstanceID] = instanceID
					index = index + 1
					jInstanceID = EJ_GetInstanceByIndex(index, isRaid)
				end
			end
		end
		EJ_SelectTier(backupTier)
		return tbl1, tbl2
	end
	if Octo_Cache_DB.SavedInstanceID_to_EJInstance then
		wipe(Octo_Cache_DB.SavedInstanceID_to_EJInstance)
	end
	if Octo_Cache_DB.EJInstance_to_SavedInstanceID then
		wipe(Octo_Cache_DB.EJInstance_to_SavedInstanceID)
	end
	Octo_Cache_DB.SavedInstanceID_to_EJInstance, Octo_Cache_DB.EJInstance_to_SavedInstanceID = setActualInstances()
end