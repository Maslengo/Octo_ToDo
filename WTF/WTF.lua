local GlobalAddonName, E = ...
----------------------------------------------------------------
-- local funcName = GlobalAddonName.."WTF"
local L = E.L
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
----------------------------------------------------------------
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
	local numShownEntries = E.func_GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = E.func_GetInfo(i)
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
			if cm and cm.Items then
				if cm.Items.Bags then
					for itemID in next,(cm.Items.Bags) do
						if itemID then
							E.ALL_Items[itemID] = true
						end
					end
				end
				if cm.Items.Bags_FULL then
					for itemID in next,(cm.Items.Bags_FULL) do
						if itemID then
							E.ALL_Items[itemID] = true
						end
					end
				end
				if cm.Items.Bank then
					for itemID in next,(cm.Items.Bank) do
						if itemID then
							E.ALL_Items[itemID] = true
						end
					end
				end
				if cm.Items.Bank_FULL then
					for itemID in next,(cm.Items.Bank_FULL) do
						if itemID then
							E.ALL_Items[itemID] = true
						end
					end
				end
			end
		end
	end
	----------------------------------------------------------------
	-- E.DEBUG_STOP("func_CacheGameData")
	----------------------------------------------------------------
	E.UniversalQuestMap = {}
	E.ALL_UniversalQuests = {}
	-- заранее построенный lookup
	for _, categoryData in next, (E.OctoTables_DataOtrisovka) do
		for dataType, dataEntries in next, (categoryData) do
			if dataType == "UniversalQuests" then
				for _, data in next, (dataEntries) do
					if (data.quests or data.questpools) and data.reset then
						local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						data.questKey = questKey
						table.insert(E.ALL_UniversalQuests, data)
						E.UniversalQuestMap[questKey] = data
					end
				end
			end
			if dataType == "Currencies" then
				for i, v in next, (dataEntries) do
					local currencyID = v.id
					E.ALL_Currencies[currencyID] = true
				end
			end
			if dataType == "Reputations" then
				for i, v in next, (dataEntries) do
					local reputationID = v.id
					E.ALL_Reputations[reputationID] = true
				end
			end
			-- if dataType == "RaidsOrDungeons" then
			-- end
			if dataType == "Items" then
				for i, v in next, (dataEntries) do
					local itemID = v.id
					E.ALL_Items[itemID] = true
				end
			end
			-- if dataType == "AdditionallyTOP" then
			-- end
			-- if dataType == "AdditionallyBOTTOM" then
			-- end
			-- if dataType == "AdditionallyCENTER" then
			-- end
		end
	end
	-- opde(E.UniversalQuestMap)
	----------------------------------------------------------------
	-- Асинхронная загрузка
	local promise = LibThingsLoad:QuestsByKey(E.ALL_Quests)
	promise:AddItemsByKey(E.ALL_Items)
	:ThenForAllWithCached(function(_, ID, TYPE)
			E.func_GetName(TYPE, ID)
			-- if TYPE == "item" then
			-- E.func_GetItemQualityByID(ID)
			-- end
			-- if TYPE == "quest" then
			-- E.func_GetName("quest", ID)
			-- elseif TYPE == "item" then
			-- E.func_GetName("item", ID)
			-- -- E.func_GetItemQualityByID(ID)
			-- end
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_RemoveDuplicateCharacters()
	if not Octo_ToDo_DB_Levels then return end
	local currentGUID = E.curGUID
	local currentName = E.curCharName
	local currentRealm = E.func_GetPlayerRealm()
	local foundDuplicates = false
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
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
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:func_DatabaseClear()
	local enable = false
	if not enable then return end
	if Octo_ToDo_DB_Levels then
		E.func_RemoveZeroValues(Octo_ToDo_DB_Levels, "^0/")
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if CharInfo and CharInfo.MASLENGO and CharInfo.MASLENGO.CurrencyID_Total then
				E.func_RemoveZeroValues(E.cm.CurrencyID_Total, "anynumber")
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
	E.func_CleanDeepTable(Octo_Todo_DB_Profiles, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Levels, rules)
	E.func_CleanDeepTable(Octo_Cache_DB, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_AccountData, rules)
	E.func_CleanDeepTable(Octo_Achievements_DB, rules)
	E.func_CleanDeepTable(Octo_Moduls_DB, rules)
	E.func_CleanDeepTable(Octo_QuestsChanged_DB, rules)
	E.func_CleanDeepTable(Octo_TalentsFrameArt_DB, rules)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.init_Octo_ToDo_DB_Levels()
	local curGUID = UnitGUID("player")
	if not curGUID then return end
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	Octo_ToDo_DB_Levels[curGUID] = Octo_ToDo_DB_Levels[curGUID] or {}
	local ServerTime = E.TIME_SERVER()
	local currentDate = date("%d.%m.%Y")
	local currentTime = date("%H:%M")
	local currentDateTime = date("%d.%m.%Y %H:%M:%S")
	local defaults = {
		BattleTag = E.BattleTag,
		buildDate = E.buildDate,
		buildNumber = E.buildNumber,
		buildVersion = E.buildVersion,
		classColor = E.classColor,
		classColorHex = E.classColorHexCurrent,
		className = E.className,
		classFilename = E.classFilename,
		CurrentRegion = GetCurrentRegion(),
		REGION_NAME = E.CURRENT_REGION_NAME,
		curServer = E.func_GetPlayerRealm(),
		curServerShort = E.curServerShort, -- E.func_GetRealmShortName(GetRealmName())
		FACTION = E.FACTION_CURRENT,
		GUID = curGUID,
		guildName = "",
		guildRankName = "",
		interfaceVersion = E.interfaceVersion,
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
		RELOAD_COUNT = 0,
		MythicPlus = {
			[E.MythicPlus_seasonID] = {
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
		RaceID = 0, -- НЕ ТАК
		PVP_timer = 0,
		LuaVersion = _VERSION,
		UnitXPPercent = 0,
		GetRestrictedAccountData_rMoney = 0,
		MythicPlus_seasonID = E.MythicPlus_seasonID, -- 0
		GetRestrictedAccountData_rLevel = 0,
		specRole = "DAMAGER", -- не так
		classId = 0, -- не так
		UnitLevel = 1,
		IsVeteranTrialAccount = false,
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
		-- tmstp_Daily = 0,
		-- tmstp_Weekly = 0,
		time = E.TIME_SERVER(),
	}
	local MASLENGO_DEFAULTS = {
		Currency = {},
		GARRISON = {},
		GreatVaultbossDifficulties = {},
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
	E.TOTAL_CHARS = 0
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		E.TOTAL_CHARS = E.TOTAL_CHARS + 1
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
	E.cm = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	E.pd = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.init_Octo_ToDo_DB_AccountData()
	Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank or {}
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local fields = {
	"SETTINGS",        -- E.SETTINGS_CURRENT
	"KEYS",            -- E.KEYS_CURRENT
	"CHARACTERS",    -- E.CHARACTERS_CURRENT
}
----------------------------------------------------------------
function E.func_UpdateGlobalNSforProfiles()
	Octo_Todo_DB_Profiles = Octo_Todo_DB_Profiles or {}
	for _, field in ipairs(fields) do
		Octo_Todo_DB_Profiles[field] = Octo_Todo_DB_Profiles[field] or {}
		Octo_Todo_DB_Profiles[field].CURRENT = Octo_Todo_DB_Profiles[field].CURRENT or E.TEXT_ENG_DEFAULT
		E[field .. "_CURRENT"] = Octo_Todo_DB_Profiles[field].CURRENT
	end
end
function E.func_INIT_Components()
	-- E.DEBUG_START()
	----------------------------------------------------------------
	E.OctoTables_Vibor = {}
	E.OctoTables_DataOtrisovka = {}
	E.OctoTables_Vibor_ORDER = {}
	----------------------------------------------------------------
	for i, componentFunc in next, (E.Components) do
		local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()
		for key, value in next, (OctoTables_Vibor) do
			if E.OctoTables_Vibor[key] == nil then
				E.OctoTables_Vibor[key] = value
			end
		end
		for key, value in next, (OctoTables_DataOtrisovka) do
			if E.OctoTables_DataOtrisovka[key] == nil then
				E.OctoTables_DataOtrisovka[key] = value
			end
		end
	end
	E.OctoTables_Vibor_ORDER = {}
	for key in pairs(E.OctoTables_Vibor) do
		table.insert(E.OctoTables_Vibor_ORDER, key)
	end
	table.sort(E.OctoTables_Vibor_ORDER)
	----------------------------------------------------------------
	-- E.DEBUG_STOP("func_INIT_Components")
end
----------------------------------------------------------------
function E.init_Octo_Todo_DB_Profiles()
	Octo_Todo_DB_Profiles = Octo_Todo_DB_Profiles or {}
	----------------------------------------------------------------
	for _, field in ipairs(fields) do
		Octo_Todo_DB_Profiles[field] = Octo_Todo_DB_Profiles[field] or {}
		Octo_Todo_DB_Profiles[field].CURRENT = Octo_Todo_DB_Profiles[field].CURRENT or E.TEXT_ENG_DEFAULT
		Octo_Todo_DB_Profiles[field].profiles = Octo_Todo_DB_Profiles[field].profiles or {}
		Octo_Todo_DB_Profiles[field].profiles[E.TEXT_ENG_DEFAULT] = Octo_Todo_DB_Profiles[field].profiles[E.TEXT_ENG_DEFAULT] or {}
		for profileName in next, (Octo_Todo_DB_Profiles[field].profiles) do
			E.func_CreateProfile(field, profileName, true)
		end
	end
	----------------------------------------------------------------
	E.func_UpdateGlobalNSforProfiles()
	----------------------------------------------------------------
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:func_Daily_Reset()
	local ServerTime = E.TIME_SERVER()
	E.Reset_JournalInstance()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd.tmstp_Daily and pd.tmstp_Daily < ServerTime then
			-- pd.tmstp_Daily = pd.tmstp_Daily + 86400
			pd.tmstp_Daily = nil
			pd.needResetDaily = true
			for _, data in next, (E.ALL_UniversalQuests) do
				if data.reset == "Daily" then
					-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
					local questKey = data.questKey
					cm.UniversalQuest[questKey] = nil
				end
			end
			wipe(cm.LFGInstance)
			if pd.MoneyOnDaily and pd.Money then
				pd.MoneyOnDaily = pd.Money
			end
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:func_Weekly_Reset()
	local ServerTime = E.TIME_SERVER()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd and cm then
			if pd.tmstp_Weekly and pd.tmstp_Weekly < ServerTime then
				-- pd.tmstp_Weekly = pd.tmstp_Weekly + (86400 * 7)
				pd.tmstp_Weekly = nil
				pd.needResetWeekly = true
				if cm.GreatVault and cm.GreatVault.NextWeekReward then
					pd.HasAvailableRewards = true
				end
				pd.OwnedKeystoneLevel = nil
				pd.OwnedKeystoneChallengeMapID = nil
				pd.RIO_weeklyBest = nil
				if pd.MythicPlus and pd.MythicPlus[E.MythicPlus_seasonID] then
					pd.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = nil
				end
				cm.journalInstance = {}
				cm.SavedWorldBoss = {}
				cm.LFGInstance = {}
				cm.GreatVault = {}
				cm.GreatVaultbossDifficulties = {}
				cm.RunHistory = {}
				for _, data in next, (E.ALL_UniversalQuests) do
					if data.reset == "Weekly" then
						-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						local questKey = data.questKey
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:func_Month_Reset()
	local tmstp_Month = E.func_GetNextResetTime(365/12)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd and cm then
			if (pd.tmstp_Month or 0) < E.TIME_SERVER() then
				pd.tmstp_Month = tmstp_Month
				pd.needResetMonth = true
				for _, data in next, (E.ALL_UniversalQuests) do
					if data.reset == "Month" then
						-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						local questKey = data.questKey
						cm.UniversalQuest[questKey] = nil
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.Init_Octo_Cache_DB()
	Octo_Cache_DB = Octo_Cache_DB or {}
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
E.Octo_ToDo_DB_Variables_defaultOptions = {
	["CONFIG_DEBUG"] = {
		{
			name = L["DEBUG"],
			variableKey = "CONFIG_DEBUG_DEBUG",
			defaultValue = false,
		},
		{
			name = L["TRANSLIT"],
			variableKey = "CONFIG_DEBUG_TRANSLIT",
			defaultValue = false,
		},
		{
			name = L["CHARACTERTOOLTIP"],
			variableKey = "CONFIG_DEBUG_CHARACTERTOOLTIP",
			defaultValue = false,
		},
		{
			name = L["REPUTATIONTOOLTIP"],
			variableKey = "CONFIG_DEBUG_REPUTATIONTOOLTIP",
			defaultValue = false,
		},
		{
			name = L["EVENTS"],
			variableKey = "CONFIG_DEBUG_EVENTS",
			defaultValue = false,
		},
		{
			name = E.COLOR_GRAY..L["FUNCTIONS"].."|r",
			variableKey = "CONFIG_DEBUG_FUNCTIONS",
			defaultValue = false,
		},
		{
			name = E.COLOR_GRAY..L["BUTTONS"].."|r",
			variableKey = "CONFIG_DEBUG_BUTTONS",
			defaultValue = false,
		},
		{
			name = L["GOSSIPS"],
			variableKey = "CONFIG_DEBUG_GOSSIPS",
			defaultValue = false,
		},
		{
			name = L["CACHE"],
			variableKey = "CONFIG_DEBUG_CACHE",
			defaultValue = false,
		},
		{
			name = L["UNIVERSAL"],
			variableKey = "CONFIG_DEBUG_UNIVERSAL",
			defaultValue = false,
		},
		{
			name = L["FUNCTION_TIMERS"],
			variableKey = "CONFIG_DEBUG_FUNCTION_TIMERS",
			defaultValue = false,
		}
	},
	-- ["Quests Changed"] = {
	-- {
	-- name = L["QC_VIGNETTES"],
	-- variableKey = "CONFIG_DEBUG_QC_VIGNETTES",
	-- defaultValue = false,
	-- },
	-- {
	-- name = L["QC_QUESTS"],
	-- variableKey = "CONFIG_DEBUG_QC_QUESTS",
	-- defaultValue = false,
	-- },
	-- },
	["EDITBOX"] = {
		{
			name = L["EDITBOX_FONTSIZE"],
			variableKey = "CONFIG_DEBUG_EDITBOX_FONTSIZE",
			defaultValue = 12,
			minValue = 10,
			maxValue = 16,
			step = 1,
		},
		{
			name = L["EDITBOX_TABSPACES"],
			variableKey = "CONFIG_DEBUG_EDITBOX_TABSPACES",
			defaultValue = 4,
			minValue = 0,
			maxValue = 4,
			step = 1,
		}, -- for _, v in ipairs({0, 2, 3, 4}) do
		{
			name = L["EDITBOX_EDITORTHEME"],
			variableKey = "CONFIG_DEBUG_EDITBOX_EDITORTHEME",
			defaultValue = "Standard",
			values = E.editorThemes,
		},
	},
	-- CONFIG_DEBUG_EDITBOX_EDITORTHEME = "Twilight", -- for name in next, E.editorThemes do
}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.init_Octo_ToDo_DB_Variables()
	Octo_ToDo_DB_Variables = Octo_ToDo_DB_Variables or {}
	Octo_ToDo_DB_Variables.dbv = Octo_ToDo_DB_Variables.dbv or 1
	Octo_ToDo_DB_Variables.LibDataBroker = Octo_ToDo_DB_Variables.LibDataBroker or 240
	Octo_ToDo_DB_Variables.dataprovider = Octo_ToDo_DB_Variables.dataprovider or {}
	Octo_ToDo_DB_Variables.CONFIG = Octo_ToDo_DB_Variables.CONFIG or {}
	Octo_ToDo_DB_Variables.Calendar = Octo_ToDo_DB_Variables.Calendar or {}
	for _, headers in next,(E.Octo_ToDo_DB_Variables_defaultOptions) do
		for _, tbl in ipairs(headers) do
			local variableKey = tbl.variableKey
			local defaultValue = tbl.defaultValue
			E.func_InitField(Octo_ToDo_DB_Variables.CONFIG, variableKey, defaultValue)
			-- E[variableKey] = Octo_ToDo_DB_Variables.CONFIG[variableKey] -- Копируем в глобальную таблицу
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.CleanupAllCallings()
	local ServerTime = E.TIME_SERVER()
	-- 1. Глобальный кеш: все регионы → ковенанты → квесты
	if Octo_ToDo_DB_AccountData.Callings then
		for region, covenants in next,(Octo_ToDo_DB_AccountData.Callings) do
			for covID, quests in next,(covenants) do
				for questID, data in next,(quests) do
					if data.endTime and data.endTime < ServerTime then
						quests[questID] = nil
					end
				end
				if not next(quests) then
					covenants[covID] = nil
				end
			end
			if not next(covenants) then
				Octo_ToDo_DB_AccountData.Callings[region] = nil
			end
		end
	end
	-- 2. Данные всех персонажей (MASLENGO.Callings)
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if type(CharInfo) == "table" and CharInfo.MASLENGO then
			local cm = CharInfo.MASLENGO
			local callings = cm.Callings
			if callings then
				for region, covenants in pairs(callings) do
					for covID, quests in pairs(covenants) do
						for questID, data in pairs(quests) do
							if data.endTime and data.endTime < ServerTime then
								quests[questID] = nil
							end
						end
						if not next(quests) then
							covenants[covID] = nil
						end
					end
					if not next(covenants) then
						callings[region] = nil
					end
				end
				if not next(callings) then
					E.cm.Callings = nil
				end
			end
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:func_ScheduleResetTimer()
	local seconds = E.func_GetSecondsUntilDailyReset()
	if seconds and seconds > 0 then
		if timerHandle then
			timerHandle:Cancel()
		end
		timerHandle = C_Timer.NewTimer(seconds + 4, function()
				E.WTF_func_CheckAll()
				E.func_Collect_All()
				EventFrame:func_Daily_Reset()
				EventFrame:func_Weekly_Reset()
				EventFrame:func_Month_Reset()
				EventFrame:func_ScheduleResetTimer()
		end)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
	"UPDATE_INSTANCE_INFO",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
	OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.WTF_func_CheckAll()
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	EventFrame:func_DatabaseClear()
	E.init_Octo_ToDo_DB_Levels()
	E.init_Octo_Todo_DB_Profiles()
	E.func_RemoveDuplicateCharacters()
	E.Init_Octo_Cache_DB()
	E.init_Octo_ToDo_DB_AccountData()
	E.init_Octo_ToDo_DB_Variables()
	E.func_setOldChanges()
	E.func_UpdateGlobals()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:VARIABLES_LOADED()
	E.func_INIT_Components() -- E.Components
	E.WTF_func_CheckAll()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CacheGameData() -- E.Components
	self:func_ScheduleResetTimer()
	E.func_BUILD_DUNG_DB()
	EventFrame:func_Daily_Reset()
	EventFrame:func_Weekly_Reset()
	EventFrame:func_Month_Reset()
	E.CleanupAllCallings()
	C_Timer.After(1, E.func_UpdateGlobals)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function Reset_JournalInstance()
	local ServerTime = E.TIME_SERVER()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if cm.journalInstance then
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
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.Reset_JournalInstance()
	E.func_SpamBlock(Reset_JournalInstance, true)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:UPDATE_INSTANCE_INFO()
	E.Reset_JournalInstance()
	E.func_RequestUIUpdate("UPDATE_INSTANCE_INFO")
end
----------------------------------------------------------------