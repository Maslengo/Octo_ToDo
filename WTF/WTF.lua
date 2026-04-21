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
	----------------------------------------------------------------
	-- E.DEBUG_STOP("func_CacheGameData")
	----------------------------------------------------------------
	E.UniversalQuestMap = {}
	E.ALL_UniversalQuests = {}
	-- заранее построенный lookup
	for _, componentFunc in next, (E.Components) do
		local _, OctoTables_DataOtrisovka = componentFunc()
		for _, categoryData in next, (OctoTables_DataOtrisovka) do
			for dataType, dataEntries in next, (categoryData) do
				if dataType == "UniversalQuests" then
					for _, data in next, (dataEntries) do
						if data.quests and data.reset then
							local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
							data.questKey = questKey -- ← ВОТ ЭТО ГЛАВНОЕ
							table.insert(E.ALL_UniversalQuests, data)
							-- local questKey = data.questKey
							E.UniversalQuestMap[questKey] = data
						end
					end
				end
			end
		end
	end
	-- opde(E.UniversalQuestMap)
	-- for categoryKey, categoryData in next, (E.OctoTables_DataOtrisovka) do
	-- for dataType, dataEntries in next, (categoryData) do
	--  E.DataProvider_Otrisovka[categoryKey] = E.DataProvider_Otrisovka[categoryKey] or {}
	--  E.DataProvider_Otrisovka[categoryKey][dataType] = E.DataProvider_Otrisovka[categoryKey][dataType] or {}
	--  if dataType ~= "UniversalQuests" then
	--   func_ProcessStandardData_profileKeys(categoryKey, dataType, dataEntries, Current_profile, defaultProfile)
	--  else
	--   func_ProcessUniversalQuests_profileKeys(categoryKey, dataEntries, Current_profile, defaultProfile)
	--  end
	-- end
	-- end
	-- E.UniversalQuestMap[id] = data
	-- E.ALL_UniversalQuests
end
function E.func_RemoveDuplicateCharacters()
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
	local enable = false
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
	E.func_CleanDeepTable(Octo_profileColors, rules)
	E.func_CleanDeepTable(Octo_profileKeys, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Levels, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_Vars, rules)
	E.func_CleanDeepTable(Octo_Cache_DB, rules)
	E.func_CleanDeepTable(Octo_ToDo_DB_AccountData, rules)
	-- E.func_CleanDeepTable(Octo_ToDo_DB_Options, rules)
	E.func_CleanDeepTable(Octo_Achievements_DB, rules)
	E.func_CleanDeepTable(Octo_DevTool_DB, rules)
	E.func_CleanDeepTable(Octo_Moduls_DB, rules)
	E.func_CleanDeepTable(Octo_QuestsChanged_DB, rules)
	E.func_CleanDeepTable(Octo_TalentsFrameArt_DB, rules)
end
function E.init_Octo_ToDo_DB_Levels()
	local curGUID = UnitGUID("player")
	if not curGUID then return end
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	Octo_ToDo_DB_Levels[curGUID] = Octo_ToDo_DB_Levels[curGUID] or {}
	local serverTime = GetServerTime()
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
		CurrentRegionName = E.CurrentRegionName,
		curServer = E.func_GetPlayerRealm(),
		curServerShort = E.curServerShort, -- E.func_GetRealmShortName(GetRealmName())
		Faction = "Neutral",
		GUID = curGUID,
		guildName = "",
		guildRankName = "",
		interfaceVersion = E.interfaceVersion,
		CONFIG_SHOW_PLAYER = true,
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
		tmstp_Daily = 0,
		tmstp_Weekly = 0,
		time = GetServerTime(),
	}
	local MASLENGO_DEFAULTS = {
		Currency = {},
		GARRISON = {},
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
		pd.time = pd.time or pd.tmstp_Daily or serverTime
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
function E.init_Octo_ToDo_DB_AccountData()
	Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] or {}
	Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank or {}
end
function E.init_Octo_ToDo_DB_Options()
	Octo_ToDo_DB_Options = Octo_ToDo_DB_Options or {}

	-- Валидные ключи
	local validKeys = {}
	for vars in next, E.SORT_OPTIONS do
		validKeys[vars] = true
	end

	-- Очистка невалидных ключей в таблице
	local function cleanInvalidKeys(tbl)
		if not tbl then return end
		for key in pairs(tbl) do
			if not validKeys[key] then
				tbl[key] = nil
			end
		end
	end

	-- 1. sort_reverse
	cleanInvalidKeys(Octo_ToDo_DB_Options.sort_reverse)
	for vars, opt in next, E.SORT_OPTIONS do
		E.func_InitField(Octo_ToDo_DB_Options, "sort_reverse", {})
		E.func_InitField(Octo_ToDo_DB_Options.sort_reverse, vars, opt.reverse)
	end

	-- 2. sort_order (список) - НОВАЯ ЛОГИКА с числовым defaultValue
	if not Octo_ToDo_DB_Options.sort_order then
		Octo_ToDo_DB_Options.sort_order = {}
		-- Собираем все опции с числовым defaultValue
		local orderMap = {}
		for vars, opt in next, E.SORT_OPTIONS do
			if opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0 then
				orderMap[opt.defaultValue] = vars
			end
		end
		-- Вставляем в порядке возрастания ключей
		for i = 1, math.max(table.maxn(orderMap) or 0) do
			if orderMap[i] then
				tinsert(Octo_ToDo_DB_Options.sort_order, orderMap[i])
			end
		end
	else
		-- Фильтрация и дедупликация существующего порядка
		local cleaned = {}
		local seen = {}
		for _, key in ipairs(Octo_ToDo_DB_Options.sort_order) do
			if validKeys[key] and not seen[key] then
				seen[key] = true
				tinsert(cleaned, key)
			end
		end

		-- Добавляем недостающие опции с числовым defaultValue
		local orderMap = {}
		for vars, opt in next, E.SORT_OPTIONS do
			if opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0 and not seen[vars] then
				orderMap[opt.defaultValue] = vars
			end
		end
		-- Вставляем новые в порядке их defaultOrder
		for i = 1, math.max(table.maxn(orderMap) or 0) do
			if orderMap[i] then
				tinsert(cleaned, orderMap[i])
			end
		end

		Octo_ToDo_DB_Options.sort_order = cleaned
	end

	-- 3. sort_order_ACTIVED
	cleanInvalidKeys(Octo_ToDo_DB_Options.sort_order_ACTIVED)
	for vars, opt in next, E.SORT_OPTIONS do
		E.func_InitField(Octo_ToDo_DB_Options, "sort_order_ACTIVED", {})
		-- Включены только те, у кого есть числовой defaultValue
		local isActive = opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0
		E.func_InitField(Octo_ToDo_DB_Options.sort_order_ACTIVED, vars, isActive)
	end
	----------------------------------------------------------------
	-- 4. GUID_order -----------------------------------------------
	----------------------------------------------------------------
	E.func_InitField(Octo_ToDo_DB_Options, "GUID_order", {})

	-- Собираем все текущие GUID из Octo_ToDo_DB_Levels
	local currentGuids = {}
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
	    currentGuids[GUID] = true
	end

	-- Удаляем несуществующих персонажей из порядка
	for i = #Octo_ToDo_DB_Options.GUID_order, 1, -1 do
	    local GUID = Octo_ToDo_DB_Options.GUID_order[i]
	    if not currentGuids[GUID] then
	        table.remove(Octo_ToDo_DB_Options.GUID_order, i)
	    else
	        currentGuids[GUID] = nil -- помечаем как уже существующий в порядке
	    end
	end

	-- Добавляем новых персонажей в конец
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
	    if currentGuids[GUID] then -- если GUID не был в порядке (остался в таблице)
	        tinsert(Octo_ToDo_DB_Options.GUID_order, GUID)
	    end
	end

	-- Если всё еще пусто (первый запуск)
	if #Octo_ToDo_DB_Options.GUID_order == 0 then
	    for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
	        tinsert(Octo_ToDo_DB_Options.GUID_order, GUID)
	    end
	end
	----------------------------------------------------------------
	if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER = false end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION = false end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN = 1 end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX = 90 end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION = false end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = false end
	if Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST == nil then Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST = false end
	if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM == nil then Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM = false end
	----------------------------------------------------------------
	----------------------------------------------------------------
end

E.Octo_ToDo_DB_Vars_DEFAULTS = {
	Config_numberFormatMode = 1,
	GlobalDBVersion = 0,
		CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER = false,
		CONFIG_HOVER_SHOW_DURATION = 1,
		CONFIG_FRAME_ALPHA_ON_HOVER = 80,
		-- CONFIG_SHOW_LEVEL_MIN = 1,
		-- CONFIG_SHOW_LEVEL_MAX = 90,
		-- CONFIG_SHOW_ONLY_CURRENT_SERVER = false,
		-- CONFIG_SHOW_ONLY_CURRENT_FACTION = false,
		-- CONFIG_SHOW_ONLY_CURRENT_REGION = false,
		-- CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = false,
		-- CONFIG_SHOW_ALWAYS_AS_FIRST = false,
		-- CONFIG_SORTING_CUSTOM = false,

		Config_DebugID_ALL = false, -- /run Octo_ToDo_DB_Vars.Config_DebugID_ALL = true
		Config_ADDON_HEIGHT = 20,
		Config_ClampedToScreen = false,
		Config_MountsInTooltip = true,
		CONFIG_SPAM_TIME = 2,
		CONFIG_ACHIEVEMENT_SHOW_COMPLETED = true,
		Currencies = true,
		CONFIG_RAIDS_ICON = true,
		CONFIG_RAIDS_EXTRA_ICON = false,
		CONFIG_RAIDS_DIFFICULTIES_ALL = true,
		CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS = true,
		Config_ShowAllDifficulties = true,
		Config_DifficultyAbbreviation = true,
		CONFIG_ITEMS_COLOREDNAME = true,
		CONFIG_ITEMS_ICON = true,
		CONFIG_CURRENCY_ICON = true,
		CONFIG_CURRENCY_WARBAND_ICON = true,
		CONFIG_CURRENCY_COLOREDNAME = true,
		CONFIG_CURRENCY_SHOW_BRACKETS = false,
		CONFIG_CURRENCY_COLOR_BRACKETS = E.COLOR_ADDON_LEFT:gsub("^|cff", "80"),
		CONFIG_CURRENCY_SHOW_REMAINING = true,
		CONFIG_CURRENCY_COLOR_REMAINING = E.COLOR_ADDON_RIGHT:gsub("^|cff", "80"),
		CONFIG_CURRENCY_SHOW_ZERO = false,
		CONFIG_CURRENCY_COLOR_ZERO = E.COLOR_GRAY:gsub("^|cff", "80"),
		CONFIG_REPUTATION_ICON = false,
		CONFIG_REPUTATION_EXTRA_ICON = true,
		CONFIG_REPUTATION_FACTION_ICON = true,
		CONFIG_REPUTATION_WARBAND_ICON = true,
		CONFIG_REPUTATION_ZERO = false,
		CONFIG_REPUTATION_COLOREDNAME = false,
		CONFIG_REPUTATION_VALUE_PARAGON = true,
		CONFIG_REPUTATION_PERCENTAGE_PARAGON = false,
		CONFIG_REPUTATION_REACTION_PARAGON = false,
		CONFIG_REPUTATION_STANDINGS_PARAGON = false,
		CONFIG_REPUTATION_PARAGON_COLOR = E.COLOR_REPPARAGON:gsub("^|cff", "80"),
		CONFIG_REPUTATION_VALUE_MAJOR = true,
		CONFIG_REPUTATION_PERCENTAGE_MAJOR = false,
		CONFIG_REPUTATION_REACTION_MAJOR = true,
		CONFIG_REPUTATION_STANDINGS_MAJOR = false,
		CONFIG_REPUTATION_MAJOR_COLOR = E.COLOR_REPMAJOR:gsub("^|cff", "80"),
		CONFIG_REPUTATION_VALUE_FRIEND = true,
		CONFIG_REPUTATION_PERCENTAGE_FRIEND = false,
		CONFIG_REPUTATION_REACTION_FRIEND = true,
		CONFIG_REPUTATION_STANDINGS_FRIEND = false,
		CONFIG_REPUTATION_FRIEND_COLOR = E.COLOR_REPFRIEND:gsub("^|cff", "80"),
		CONFIG_REPUTATION_VALUE_SIMPLE = true,
		CONFIG_REPUTATION_PERCENTAGE_SIMPLE = false,
		CONFIG_REPUTATION_REACTION_SIMPLE = false,
		CONFIG_REPUTATION_STANDINGS_SIMPLE = false,
		CONFIG_REPUTATION_SIMPLE_COLOR_1 = E.COLOR_REPSIMPLE_1:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_2 = E.COLOR_REPSIMPLE_2:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_3 = E.COLOR_REPSIMPLE_3:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_4 = E.COLOR_REPSIMPLE_4:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_5 = E.COLOR_REPSIMPLE_5:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_6 = E.COLOR_REPSIMPLE_6:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_7 = E.COLOR_REPSIMPLE_7:gsub("^|cff", "80"),
		CONFIG_REPUTATION_SIMPLE_COLOR_8 = E.COLOR_REPSIMPLE_8:gsub("^|cff", "80"),
}
function E.init_Octo_ToDo_DB_Vars()
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	for k, v in next, (E.Octo_ToDo_DB_Vars_DEFAULTS) do
		E.func_InitField(Octo_ToDo_DB_Vars, k, v)
	end
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- opde(Octo_ToDo_DB_Vars)
	Octo_ToDo_DB_Vars.FontOption = Octo_ToDo_DB_Vars.FontOption or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang] or {}
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle or E.DefaultFont
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or 11
	Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags or "OUTLINE"
end
function E.init_Octo_profileColors()
	Octo_profileColors = Octo_profileColors or {}
	local db = Octo_profileColors
	db.profiles = db.profiles or {}
	db.Current_profile = db.Current_profile or E.TEXT_DEFAULT
	E.func_CreateNew_profileColors(E.TEXT_DEFAULT)
	if db and db.profiles then
		for profileName in next, (db.profiles) do
			if profileName ~= E.TEXT_DEFAULT then
				E.func_CreateNew_profileColors(E.TEXT_DEFAULT)
			end
		end
	end
	E.func_CheckALL_profileColors()
	-- C_Timer.After(1, function()
	-- opde(db)
	-- end)
	E.PROFTBL = db.profiles[db.Current_profile]
end
function E.init_Octo_profileKeys()
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	E.func_CreateNew_profileKeys(E.TEXT_DEFAULT)
	if Octo_profileKeys and Octo_profileKeys.profiles then
		for profileName in next, (Octo_profileKeys.profiles) do
			if profileName ~= E.TEXT_DEFAULT then
				E.func_CreateNew_profileKeys(profileName)
			end
		end
	end
	if not Octo_ToDo_DB_Levels then return end
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		if pd and pd.Name and pd.curServer then
			local key = pd.Name .. " - " .. pd.curServer
			db.profileKeys[key] = db.profileKeys[key] or E.TEXT_DEFAULT
		end
	end
end
function EventFrame:func_Daily_Reset()
	local serverTime = GetServerTime()
	E.Reset_JournalInstance()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd.tmstp_Daily and pd.tmstp_Daily < serverTime then
			pd.tmstp_Daily = pd.tmstp_Daily + 86400
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
function EventFrame:func_Weekly_Reset()
	local serverTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd and cm then
			if pd.tmstp_Weekly and pd.tmstp_Weekly < serverTime then
				pd.tmstp_Weekly = pd.tmstp_Weekly + 86400*7
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
						-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
						local questKey = data.questKey
						cm.UniversalQuest[questKey] = nil
					end
				end
			end
		end
	end
end
function E.Init_Octo_Cache_DB()
	Octo_Cache_DB = Octo_Cache_DB or {}
end
E.Octo_DevTool_DB_defaultOptions = { -- Octo_DevTool_DB
	["CONFIG_DEBUG"] = {
		{
			name = L["DEBUG"],
			variableKey = "CONFIG_DEBUG_DEBUG", -- Octo_DevTool_DB.CONFIG_DEBUG_ENABLED
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
			variableKey = "FUNCTION_TIMERS",
			defaultValue = false,
		}
	},
	-- ["Quests Changed"] = {
	-- {
	--  name = L["QC_VIGNETTES"],
	--  variableKey = "CONFIG_DEBUG_QC_VIGNETTES",
	--  defaultValue = false,
	-- },
	-- {
	--  name = L["QC_QUESTS"],
	--  variableKey = "CONFIG_DEBUG_QC_QUESTS",
	--  defaultValue = false,
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
function E.init_Octo_DevTool_DB()
	Octo_DevTool_DB = Octo_DevTool_DB or {}
	-- EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	for _, headers in next,(E.Octo_DevTool_DB_defaultOptions) do
		for _, tbl in ipairs(headers) do
			local variableKey = tbl.variableKey
			local defaultValue = tbl.defaultValue
			E.func_InitField(Octo_DevTool_DB, variableKey, defaultValue)
			E[variableKey] = Octo_DevTool_DB[variableKey] -- Копируем в глобальную таблицу
		end
	end
end
function E.WTF_func_CheckAll()
	E.init_Octo_DevTool_DB()
	E.init_Octo_profileColors()
	E.init_Octo_profileKeys()
	E.func_RemoveDuplicateCharacters()
	E.init_Octo_ToDo_DB_Levels()
	E.init_Octo_ToDo_DB_Vars()
	E.Init_Octo_Cache_DB()
	E.init_Octo_ToDo_DB_AccountData()
	E.init_Octo_ToDo_DB_Options()
	E.func_setOldChanges()
end
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
	-- E.Init_Octo_Cache_DB()
	-- E.init_Octo_profileKeys()
	-- E.init_Octo_profileColors()
	-- E.func_UpdateGlobals()
end
function EventFrame:VARIABLES_LOADED()
	Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
	EventFrame:func_DatabaseClear()
	E.init_Octo_DevTool_DB()
	E.init_Octo_profileColors()
	E.init_Octo_profileKeys()
	E.func_RemoveDuplicateCharacters()
	E.init_Octo_ToDo_DB_Levels()
	E.init_Octo_ToDo_DB_Vars()
	E.Init_Octo_Cache_DB()
	E.init_Octo_ToDo_DB_AccountData()
	E.init_Octo_ToDo_DB_Options()
	E.func_setOldChanges()
	E.func_UpdateGlobals()
end
function EventFrame:PLAYER_LOGIN()
	EventFrame:func_CacheGameData()
	self:func_ScheduleResetTimer()
	E.func_BUILD_DUNG_DB()
	EventFrame:func_Daily_Reset()
	EventFrame:func_Weekly_Reset()
	EventFrame:func_Month_Reset()
	C_Timer.After(1, E.func_UpdateGlobals)
end
local function Reset_JournalInstance()
	local serverTime = GetServerTime()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		for instanceID, v in next, (cm.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w and w.instanceReset and w.instanceReset < serverTime then
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