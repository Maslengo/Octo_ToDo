local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetData_profileKeys(key) -- "ExpansionToShow"
	local db = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.KEYS
	local tbl = db and db.profiles and db.CURRENT and db.profiles[db.CURRENT] and db.profiles[db.CURRENT][key] or {}
	return tbl
end
----------------------------------------------------------------
-- COLOR -------------------------------------------------------
----------------------------------------------------------------





local function defaults_tbl()
	-- Вычисляем значения перед созданием defaults
	local TR, TG, TB, TA = E.func_Hex2RGBA(E.COLOR_RED)
	local OR, OG, OB, OA = E.func_Hex2RGBA(E.COLOR_ORANGE)
	local YR, YG, YB, YA = E.func_Hex2RGBA(E.COLOR_YELLOW)
	local GR, GG, GB, GA = E.func_Hex2RGBA(E.COLOR_GREEN)
	local PR, PG, PB, PA = E.func_Hex2RGBA(E.COLOR_PINK)
	local BR, BG, BB, BA = E.func_Hex2RGBA(E.COLOR_BLUE)
	local KYR, KYG, KYB, KYA = E.func_Hex2RGBA(E.COLOR_KYRIAN)
	local VENR, VENG, VENB, VENA = E.func_Hex2RGBA(E.COLOR_VENTHYR)
	local NFR, NFG, NFB, NFA = E.func_Hex2RGBA(E.COLOR_NIGHTFAE)
	local NECR, NECG, NECB, NECA = E.func_Hex2RGBA(E.COLOR_NECROLORD)
	local HORR, HORG, HORB, HORA = E.func_Hex2RGBA(E.COLOR_HORDE)
	local ALLR, ALLG, ALLB, ALLA = E.func_Hex2RGBA(E.COLOR_ALLIANCE)
	local NEUR, NEUG, NEUB, NEUA = E.func_Hex2RGBA(E.COLOR_NEUTRAL)
	local COLOR_ADDON_LEFT_R, COLOR_ADDON_LEFT_G, COLOR_ADDON_LEFT_B, COLOR_ADDON_LEFT_A = E.func_Hex2RGBA(E.COLOR_ADDON_LEFT)
	local COLOR_ADDON_RIGHT_R, COLOR_ADDON_RIGHT_G, COLOR_ADDON_RIGHT_B, COLOR_ADDON_RIGHT_A = E.func_Hex2RGBA(E.COLOR_ADDON_RIGHT)

	-- Репутационные цвета и серый
	local PRR, PRG, PRB, PRA = E.func_Hex2RGBA(E.COLOR_REPPARAGON)
	local MJR, MJG, MJB, MJA = E.func_Hex2RGBA(E.COLOR_REPMAJOR)
	local FRR, FRG, FRB, FRA = E.func_Hex2RGBA(E.COLOR_REPFRIEND)
	local ZR, ZG, ZB, ZA = E.func_Hex2RGBA(E.COLOR_GRAY)

	-- Простые репутационные цвета (8 штук)
	local S1R, S1G, S1B, S1A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_1)
	local S2R, S2G, S2B, S2A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_2)
	local S3R, S3G, S3B, S3A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_3)
	local S4R, S4G, S4B, S4A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_4)
	local S5R, S5G, S5B, S5A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_5)
	local S6R, S6G, S6B, S6A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_6)
	local S7R, S7G, S7B, S7A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_7)
	local S8R, S8G, S8B, S8A = E.func_Hex2RGBA(E.COLOR_REPSIMPLE_8)



	E.DEFAULT_SETTINGS_FORPROFILE = {
		Config_numberFormatMode = 1,
		GlobalDBVersion = 0,
		CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE = true,
		CONFIG_ADVANCED_TOOLTIP_GREATVAULT = true,
		CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER = false,
		CONFIG_HOVER_SHOW_DURATION = 0,
		CONFIG_FRAME_ALPHA_ON_HOVER = 80,
		Config_DebugID_ALL = false, -- /dump E.func_GetProfile_SETTINGS_CURRENT().Config_DebugID_ALL
		Config_ADDON_HEIGHT = 20,
		CONFIG_SAVE_POSITION = true,
		Config_ClampedToScreen = false,
		Config_MountsInTooltip = true,
		-- Config_FontStyle = E.DefaultFont,
		-- Config_FontSize = 11,
		-- Config_FontFlags = "OUTLINE",
		FontOption = {
			[E.curLocaleLang] = {
				Config_FontStyle = E.DefaultFont,
				Config_FontSize = 11,
				Config_FontFlags = "OUTLINE",
			}
		},
		FramePosition = {},
		----------------------------------------------------------------
		-- CONFIG_ACHIEVEMENT_SHOW_COMPLETED = true,
		-- Currencies = true,
		CONFIG_ZEBRA_MODE = 0,
		----------------------------------------------------------------
		ConfigColor_CharHeader_r = 0.5,
		ConfigColor_CharHeader_g = 0.5,
		ConfigColor_CharHeader_b = 0.5,
		ConfigColor_CharHeader_a = 0.2,
		ConfigColor_CharHeader_TYPE = 1, -- FACTION
		-- ConfigColor_CharHeader_UseClass_CONFIG = false,
		-- ConfigColor_CharHeader_UseFaction_CONFIG = true,
		----------------------------------------------------------------
		ConfigColor_CharLines_r = 0.5,
		ConfigColor_CharLines_g = 0.5,
		ConfigColor_CharLines_b = 0.5,
		ConfigColor_CharLines_a = 0.2,
		ConfigColor_CharLines_TYPE = 2, -- CLASS
		-- ConfigColor_CharLines_UseClass_CONFIG = true,
		-- ConfigColor_CharLines_UseFaction_CONFIG = false,
		----------------------------------------------------------------
		ConfigColor_Highlight_r = 0.5,
		ConfigColor_Highlight_g = 0.5,
		ConfigColor_Highlight_b = 0.5,
		ConfigColor_Highlight_a = 0.1,
		-- ConfigColor_Highlight_UseClass_CONFIG = true,
		-- ConfigColor_Highlight_UseFaction_CONFIG = false,
		ConfigColor_Highlight_TYPE = 0, -- CUSTOM
		ConfigColor_ENABLE_HIGHLIGHT_ANIMATION = false,
		----------------------------------------------------------------
		ConfigColor_KYRIAN_r = KYR,
		ConfigColor_KYRIAN_g = KYG,
		ConfigColor_KYRIAN_b = KYB,
		ConfigColor_KYRIAN_a = KYA,
		ConfigColor_MAIN_Border_r = 0,
		ConfigColor_MAIN_Border_g = 0,
		ConfigColor_MAIN_Border_b = 0,
		ConfigColor_MAIN_Border_a = 1,
		-- ConfigColor_MAIN_Border_UseClass_CONFIG = false,
		-- ConfigColor_MAIN_Border_UseFaction_CONFIG = false,
		ConfigColor_MAIN_MainFrame_r = 0.08,
		ConfigColor_MAIN_MainFrame_g = 0.08,
		ConfigColor_MAIN_MainFrame_b = 0.08,
		ConfigColor_MAIN_MainFrame_a = 0.8,
		-- ConfigColor_MAIN_MainFrame_UseClass_CONFIG = false,
		-- ConfigColor_MAIN_MainFrame_UseFaction_CONFIG = false,
		ConfigColor_NECROLORD_r = NECR,
		ConfigColor_NECROLORD_g = NECG,
		ConfigColor_NECROLORD_b = NECB,
		ConfigColor_NECROLORD_a = NECA,
		ConfigColor_NIGHTFAE_r = NFR,
		ConfigColor_NIGHTFAE_g = NFG,
		ConfigColor_NIGHTFAE_b = NFB,
		ConfigColor_NIGHTFAE_a = NFA,
		ConfigColor_TOOLTIP_Border_r = 0,
		ConfigColor_TOOLTIP_Border_g = 0,
		ConfigColor_TOOLTIP_Border_b = 0,
		ConfigColor_TOOLTIP_Border_a = 1,
		-- ConfigColor_TOOLTIP_Border_UseClass_CONFIG = false,
		-- ConfigColor_TOOLTIP_Border_UseFaction_CONFIG = false,
		ConfigColor_TOOLTIP_max_RGBA_r = GR,
		ConfigColor_TOOLTIP_max_RGBA_g = GG,
		ConfigColor_TOOLTIP_max_RGBA_b = GB,
		ConfigColor_TOOLTIP_max_RGBA_a = GA,
		ConfigColor_TOOLTIP_mid_RGBA_r = OR,
		ConfigColor_TOOLTIP_mid_RGBA_g = OG,
		ConfigColor_TOOLTIP_mid_RGBA_b = OB,
		ConfigColor_TOOLTIP_mid_RGBA_a = OA,
		ConfigColor_TOOLTIP_min_RGBA_r = TR,
		ConfigColor_TOOLTIP_min_RGBA_g = TG,
		ConfigColor_TOOLTIP_min_RGBA_b = TB,
		ConfigColor_TOOLTIP_min_RGBA_a = TA,
		ConfigColor_TOOLTIP_TooltipFrame_r = 0.15,
		ConfigColor_TOOLTIP_TooltipFrame_g = 0.15,
		ConfigColor_TOOLTIP_TooltipFrame_b = 0.15,
		ConfigColor_TOOLTIP_TooltipFrame_a = 1,
		-- ConfigColor_TOOLTIP_TooltipFrame_UseClass_CONFIG = false,
		-- ConfigColor_TOOLTIP_TooltipFrame_UseFaction_CONFIG = false,
		ConfigColor_TOOLTIP_usegradient = true,
		ConfigColor_VENTHYR_r = VENR,
		ConfigColor_VENTHYR_g = VENG,
		ConfigColor_VENTHYR_b = VENB,
		ConfigColor_VENTHYR_a = VENA,
		ConfigColor_ZEBRA_RGBA_r = 0.08,
		ConfigColor_ZEBRA_RGBA_g = 0.08,
		ConfigColor_ZEBRA_RGBA_b = 0.08,
		ConfigColor_ZEBRA_RGBA_a = 0.4,
		ConfigColor_faction_Alliance_r = ALLR,
		ConfigColor_faction_Alliance_g = ALLG,
		ConfigColor_faction_Alliance_b = ALLB,
		ConfigColor_faction_Alliance_a = ALLA,
		ConfigColor_faction_Horde_r = HORR,
		ConfigColor_faction_Horde_g = HORG,
		ConfigColor_faction_Horde_b = HORB,
		ConfigColor_faction_Horde_a = HORA,
		ConfigColor_faction_Neutral_r = NEUR,
		ConfigColor_faction_Neutral_g = NEUG,
		ConfigColor_faction_Neutral_b = NEUB,
		ConfigColor_faction_Neutral_a = NEUA,

		-- local other = {
		CONFIG_RAIDS_ICON = true,
		CONFIG_RAIDS_EXTRA_ICON = false,
		CONFIG_RAIDS_DIFFICULTIES_ALL = true,
		CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS = true,
		----------------
		Config_ShowAllDifficulties = true,
		Config_DifficultyAbbreviation = true,
		----------------
		CONFIG_ITEMS_COLOREDNAME = true,
		CONFIG_ITEMS_ICON = true,
		----------------
		CONFIG_CURRENCY_ICON = true,
		CONFIG_CURRENCY_WARBAND_ICON = true,
		CONFIG_CURRENCY_COLOREDNAME = true,
		CONFIG_CURRENCY_SHOW_BRACKETS = false,

		CONFIG_CURRENCY_COLOR_BRACKETS_R = COLOR_ADDON_LEFT_R,
		CONFIG_CURRENCY_COLOR_BRACKETS_G = COLOR_ADDON_LEFT_G,
		CONFIG_CURRENCY_COLOR_BRACKETS_B = COLOR_ADDON_LEFT_B,
		CONFIG_CURRENCY_COLOR_BRACKETS_A = COLOR_ADDON_LEFT_A,
		-- CONFIG_CURRENCY_COLOR_BRACKETS = E.COLOR_ADDON_LEFT:gsub("^|cff", "80"),


		CONFIG_CURRENCY_SHOW_REMAINING = true,
		CONFIG_CURRENCY_COLOR_REMAINING_R = COLOR_ADDON_RIGHT_R,
		CONFIG_CURRENCY_COLOR_REMAINING_G = COLOR_ADDON_RIGHT_G,
		CONFIG_CURRENCY_COLOR_REMAINING_B = COLOR_ADDON_RIGHT_B,
		CONFIG_CURRENCY_COLOR_REMAINING_A = COLOR_ADDON_RIGHT_A,
		-- CONFIG_CURRENCY_COLOR_REMAINING = E.COLOR_ADDON_RIGHT:gsub("^|cff", "80"),

		Config_MountsInTooltip = true,

		CONFIG_CURRENCY_SHOW_ZERO = false,
		CONFIG_CURRENCY_COLOR_ZERO_R = ZR,
		CONFIG_CURRENCY_COLOR_ZERO_G = ZG,
		CONFIG_CURRENCY_COLOR_ZERO_B = ZB,
		CONFIG_CURRENCY_COLOR_ZERO_A = ZA,
		-- CONFIG_CURRENCY_COLOR_ZERO = E.COLOR_GRAY:gsub("^|cff", "80"),
		----------------
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

		CONFIG_REPUTATION_PARAGON_COLOR_R = PRR,
		CONFIG_REPUTATION_PARAGON_COLOR_G = PRG,
		CONFIG_REPUTATION_PARAGON_COLOR_B = PRB,
		CONFIG_REPUTATION_PARAGON_COLOR_A =  .5, -- PRA,
		-- CONFIG_REPUTATION_PARAGON_COLOR = E.COLOR_REPPARAGON:gsub("^|cff", "80"),

		CONFIG_REPUTATION_VALUE_MAJOR = true,
		CONFIG_REPUTATION_PERCENTAGE_MAJOR = false,
		CONFIG_REPUTATION_REACTION_MAJOR = true,
		CONFIG_REPUTATION_STANDINGS_MAJOR = false,

		CONFIG_REPUTATION_MAJOR_COLOR_R = MJR,
		CONFIG_REPUTATION_MAJOR_COLOR_G = MJG,
		CONFIG_REPUTATION_MAJOR_COLOR_B = MJB,
		CONFIG_REPUTATION_MAJOR_COLOR_A =  .5, -- MJA,
		-- CONFIG_REPUTATION_MAJOR_COLOR = E.COLOR_REPMAJOR:gsub("^|cff", "80"),

		CONFIG_REPUTATION_VALUE_FRIEND = true,
		CONFIG_REPUTATION_PERCENTAGE_FRIEND = false,
		CONFIG_REPUTATION_REACTION_FRIEND = true,
		CONFIG_REPUTATION_STANDINGS_FRIEND = false,

		CONFIG_REPUTATION_FRIEND_COLOR_R = FRR,
		CONFIG_REPUTATION_FRIEND_COLOR_G = FRG,
		CONFIG_REPUTATION_FRIEND_COLOR_B = FRB,
		CONFIG_REPUTATION_FRIEND_COLOR_A =  .5, -- FRA,
		-- CONFIG_REPUTATION_FRIEND_COLOR = E.COLOR_REPFRIEND:gsub("^|cff", "80"),

		CONFIG_REPUTATION_VALUE_SIMPLE = true,
		CONFIG_REPUTATION_PERCENTAGE_SIMPLE = false,
		CONFIG_REPUTATION_REACTION_SIMPLE = false,
		CONFIG_REPUTATION_STANDINGS_SIMPLE = false,

		CONFIG_REPUTATION_SIMPLE_COLOR_1_R = S1R,
		CONFIG_REPUTATION_SIMPLE_COLOR_1_G = S1G,
		CONFIG_REPUTATION_SIMPLE_COLOR_1_B = S1B,
		CONFIG_REPUTATION_SIMPLE_COLOR_1_A = .5, -- S1A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_1 = E.COLOR_REPSIMPLE_1:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_2_R = S2R,
		CONFIG_REPUTATION_SIMPLE_COLOR_2_G = S2G,
		CONFIG_REPUTATION_SIMPLE_COLOR_2_B = S2B,
		CONFIG_REPUTATION_SIMPLE_COLOR_2_A = .5, -- S2A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_2 = E.COLOR_REPSIMPLE_2:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_3_R = S3R,
		CONFIG_REPUTATION_SIMPLE_COLOR_3_G = S3G,
		CONFIG_REPUTATION_SIMPLE_COLOR_3_B = S3B,
		CONFIG_REPUTATION_SIMPLE_COLOR_3_A = .5, -- S3A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_3 = E.COLOR_REPSIMPLE_3:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_4_R = S4R,
		CONFIG_REPUTATION_SIMPLE_COLOR_4_G = S4G,
		CONFIG_REPUTATION_SIMPLE_COLOR_4_B = S4B,
		CONFIG_REPUTATION_SIMPLE_COLOR_4_A = .5, -- S4A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_4 = E.COLOR_REPSIMPLE_4:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_5_R = S5R,
		CONFIG_REPUTATION_SIMPLE_COLOR_5_G = S5G,
		CONFIG_REPUTATION_SIMPLE_COLOR_5_B = S5B,
		CONFIG_REPUTATION_SIMPLE_COLOR_5_A = .5, -- S5A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_5 = E.COLOR_REPSIMPLE_5:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_6_R = S6R,
		CONFIG_REPUTATION_SIMPLE_COLOR_6_G = S6G,
		CONFIG_REPUTATION_SIMPLE_COLOR_6_B = S6B,
		CONFIG_REPUTATION_SIMPLE_COLOR_6_A = .5, -- S6A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_6 = E.COLOR_REPSIMPLE_6:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_7_R = S7R,
		CONFIG_REPUTATION_SIMPLE_COLOR_7_G = S7G,
		CONFIG_REPUTATION_SIMPLE_COLOR_7_B = S7B,
		CONFIG_REPUTATION_SIMPLE_COLOR_7_A = .5, -- S7A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_7 = E.COLOR_REPSIMPLE_7:gsub("^|cff", "80"),

		CONFIG_REPUTATION_SIMPLE_COLOR_8_R = S8R,
		CONFIG_REPUTATION_SIMPLE_COLOR_8_G = S8G,
		CONFIG_REPUTATION_SIMPLE_COLOR_8_B = S8B,
		CONFIG_REPUTATION_SIMPLE_COLOR_8_A = .5, -- S8A,
		-- CONFIG_REPUTATION_SIMPLE_COLOR_8 = E.COLOR_REPSIMPLE_8:gsub("^|cff", "80"),
		----------------
	}


	return E.DEFAULT_SETTINGS_FORPROFILE
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

----------------------------------------------------------------
-- Рекурсивная синхронизация профиля с defaults + debug --------
----------------------------------------------------------------
local function syncProfileWithDefaults(profile, defaults, profileName, path)
	path = path or ""
	-- Добавляем недостающие ключи
	for key, defaultValue in next, (defaults) do
		local currentPath = (path ~= "" and (path .. "." .. key)) or key
		if type(defaultValue) == "table" then
			if type(profile[key]) ~= "table" then
				profile[key] = E.func_CopyTableDeep(defaultValue)
			else
				syncProfileWithDefaults(profile[key], defaultValue, profileName, currentPath)
			end
		else
			if profile[key] == nil then
				profile[key] = defaultValue
			end
		end
	end
	-- Удаляем лишние ключи
	-- for key in next, (profile) do
	-- 	local defaultValue = defaults[key]
	-- 	local currentPath = (path ~= "" and (path .. "." .. key)) or key
	-- 	if defaultValue == nil then
	-- 		profile[key] = nil
	-- 	elseif type(profile[key]) == "table" and type(defaultValue) == "table" then
	-- 		syncProfileWithDefaults(profile[key], defaultValue, profileName, currentPath)
	-- 	end
	-- end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_InitProfileDefaults_KEYS(db, profileName)
	local CURRENT = db.profiles[profileName]
	for categoryKey, categoryData in next, E.OctoTables_DataOtrisovka do
		for dataType, dataEntries in next, categoryData do
			CURRENT[dataType] = CURRENT[dataType] or {}
			if dataType == "UniversalQuests" then
				for _, questData in ipairs(dataEntries) do
					local questKey = questData.questKey
					if questKey and CURRENT.UniversalQuests[questKey] == nil then
						CURRENT.UniversalQuests[questKey] = questData.defS
					end
				end
			else
				for _, entry in ipairs(dataEntries) do
					if entry.id ~= nil and CURRENT[dataType][entry.id] == nil then
						CURRENT[dataType][entry.id] = entry.defS
					end
				end
			end
		end
	end
end
local function func_CreateProfile_KEYS(db, profileName)
	db.profiles[profileName] = db.profiles[profileName] or {}
	----------------------------------------------------------------
	do
		local profile = db.profiles[profileName]
		local lastExp = E.func_GetCurrentExpansion()
		E.func_InitField(profile, "ExpansionToShow", {
				[lastExp] = true, -- [12] = true, -- MIDNIGHT
				[96] = true, -- MPLUS
				-- [97] = false, -- PVP
				[99] = true -- OTHER
		})
		for _, dataType in ipairs(E.dataDisplayOrder) do
			E.func_InitSubTable(profile, dataType)
		end
		E.func_InitSubTable(db.profiles, "Default")
		local defaultProfile_TBL = db.profiles.Default
		for _, dataType in ipairs(E.dataDisplayOrder) do
			E.func_InitSubTable(defaultProfile_TBL, dataType)
		end
	end

	db.isSettingsEnabled = false
	----------------------------------------------------------------
	func_InitProfileDefaults_KEYS(db, profileName)
	----------------------------------------------------------------
end

local function func_CreateProfile_CHARACTERS(db, profileName)
	db.profiles[profileName] = db.profiles[profileName] or {}
	local profile = db.profiles[profileName]
	profile.GUIDS = profile.GUIDS or {}
	profile.OTHER = profile.OTHER or {}
	-- Инициализация OTHER
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if profile.OTHER.CONFIG_SHOW_LEVEL_MIN == nil then profile.OTHER.CONFIG_SHOW_LEVEL_MIN = 1 end
		if profile.OTHER.CONFIG_SHOW_LEVEL_MAX == nil then profile.OTHER.CONFIG_SHOW_LEVEL_MAX = 90 end
		if profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG == nil then profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = false end
		if profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION == nil then profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION = false end
		if profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER == nil then profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER = false end
		if profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION == nil then profile.OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION = false end
		if profile.OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST == nil then profile.OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST = false end
		if profile.OTHER.CONFIG_SORTING_CUSTOM == nil then profile.OTHER.CONFIG_SORTING_CUSTOM = false end
		if profile.GUIDS[GUID] == nil then profile.GUIDS[GUID] = true end
	end
	-- Инициализация SORTING (только дефолтные значения, без копирования из старой БД)
	profile.SORTING = profile.SORTING or {}
	local sorting = profile.SORTING
	local validKeys = {}
	for vars in next, (E.SORT_OPTIONS) do
		validKeys[vars] = true
	end
	local function cleanInvalidKeys(tbl)
		if not tbl then return end
		for key in pairs(tbl) do
			if not validKeys[key] then
				tbl[key] = nil
			end
		end
	end
	-- sort_reverse
	if not sorting.sort_reverse then
		sorting.sort_reverse = {}
		for vars, opt in next, (E.SORT_OPTIONS) do
			sorting.sort_reverse[vars] = opt.reverse
		end
	else
		cleanInvalidKeys(sorting.sort_reverse)
		for vars, opt in next, (E.SORT_OPTIONS) do
			if sorting.sort_reverse[vars] == nil then
				sorting.sort_reverse[vars] = opt.reverse
			end
		end
	end
	-- sort_order
	if not sorting.sort_order then
		sorting.sort_order = {}
		local orderMap = {}
		for vars, opt in next, (E.SORT_OPTIONS) do
			if opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0 then
				orderMap[opt.defaultValue] = vars
			end
		end
		for i = 1, math.max(table.maxn(orderMap) or 0) do
			if orderMap[i] then
				tinsert(sorting.sort_order, orderMap[i])
			end
		end
	else
		local cleaned = {}
		local seen = {}
		for _, key in ipairs(sorting.sort_order) do
			if validKeys[key] and not seen[key] then
				seen[key] = true
				tinsert(cleaned, key)
			end
		end
		local orderMap = {}
		for vars, opt in next, (E.SORT_OPTIONS) do
			if opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0 and not seen[vars] then
				orderMap[opt.defaultValue] = vars
			end
		end
		for i = 1, math.max(table.maxn(orderMap) or 0) do
			if orderMap[i] then
				tinsert(cleaned, orderMap[i])
			end
		end
		sorting.sort_order = cleaned
	end
	-- sort_order_ACTIVED
	if not sorting.sort_order_ACTIVED then
		sorting.sort_order_ACTIVED = {}
		for vars, opt in next, (E.SORT_OPTIONS) do
			local isActive = opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0
			sorting.sort_order_ACTIVED[vars] = isActive
		end
	else
		cleanInvalidKeys(sorting.sort_order_ACTIVED)
		for vars, opt in next, (E.SORT_OPTIONS) do
			if sorting.sort_order_ACTIVED[vars] == nil then
				local isActive = opt.defaultValue and type(opt.defaultValue) == "number" and opt.defaultValue > 0
				sorting.sort_order_ACTIVED[vars] = isActive
			end
		end
	end
	-- GUID_order
	if not sorting.GUID_order then
		sorting.GUID_order = {}
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			tinsert(sorting.GUID_order, GUID)
		end
	end
	-- Актуализация GUID_order
	local currentGuids = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		currentGuids[GUID] = true
	end
	for i = #sorting.GUID_order, 1, -1 do
		local GUID = sorting.GUID_order[i]
		if not currentGuids[GUID] then
			tremove(sorting.GUID_order, i)
		else
			currentGuids[GUID] = nil
		end
	end
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if currentGuids[GUID] then
			tinsert(sorting.GUID_order, GUID)
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local function func_CreateProfile_SETTINGS(db, profileName)
	db.profiles[profileName] = db.profiles[profileName] or {}
	syncProfileWithDefaults(db.profiles[profileName], defaults_tbl(), profileName)
end


function E.func_CreateProfile(field, profileName, justChecked)

	Octo_Todo_DB_Profiles[field] = Octo_Todo_DB_Profiles[field] or {}
	profileName = profileName or E.TEXT_ENG_DEFAULT
	local db = Octo_Todo_DB_Profiles[field]
	db.profiles[profileName] = db.profiles[profileName] or {}
	if not justChecked then
		db.CURRENT = profileName
	end
	-- E.func_InitField(db, "CURRENT", profileName)  -- if tbl[field] == nil then
	-- E.func_InitSubTable(db, "profiles")           -- if type(tbl[field]) ~= "table" then
	-- E.func_InitSubTable(db.profiles, profileName) -- if type(tbl[field]) ~= "table" then
	-- db.CURRENT = db.CURRENT or E.TEXT_ENG_DEFAULT
	if field == "CHARACTERS" then
		func_CreateProfile_CHARACTERS(db, profileName) -- E.func_CreateProfile("CHARACTERS", profileName)
	end
	if field == "SETTINGS" then
		func_CreateProfile_SETTINGS(db, profileName) -- E.func_CreateProfile("SETTINGS", profileName)
		E.PROFTBL = db.profiles[db.CURRENT]
	end
	if field == "KEYS" then
		func_CreateProfile_KEYS(db, profileName) -- E.func_CreateProfile("KEYS", profileName)
	end
	E.func_UpdateGlobalNSforProfiles()
end
function E.func_GetProfile_CHARACTERS_CURRENT()
	-- assert(Octo_Todo_DB_Profiles == nil, "Octo_Todo_DB_Profiles: first argument must be a table (array)")
	if not Octo_Todo_DB_Profiles or not E.CHARACTERS_CURRENT then
		return
	end
	local CharacterProfile = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.CHARACTERS and Octo_Todo_DB_Profiles.CHARACTERS.profiles and Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT]
	local CharacterProfile_GUIDS = CharacterProfile and CharacterProfile.GUIDS
	local CharacterProfile_OTHER = CharacterProfile and CharacterProfile.OTHER
	local CharacterProfile_SORTING = CharacterProfile and CharacterProfile.SORTING

	return CharacterProfile, CharacterProfile_GUIDS, CharacterProfile_OTHER, CharacterProfile_SORTING
end
function E.func_GetProfile_SETTINGS_ALL() -- local profilesALL, profilesALL_COLORS, profilesALL_OTHER = E.func_GetProfile_SETTINGS_ALL()
	if not Octo_Todo_DB_Profiles then
		return
	end
	local profilesALL = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.SETTINGS and Octo_Todo_DB_Profiles.SETTINGS.profiles
	-- local profilesALL_COLORS = profilesALL.COLORS
	-- local profilesALL_OTHER = profilesALL.OTHER
	return profilesALL -- , profilesALL_COLORS, profilesALL_OTHER
end
function E.func_GetProfile_SETTINGS_CURRENT() -- local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if not Octo_Todo_DB_Profiles or not E.SETTINGS_CURRENT then
		return
	end
	local settingsProfile = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.SETTINGS and Octo_Todo_DB_Profiles.SETTINGS.profiles and Octo_Todo_DB_Profiles.SETTINGS.profiles[E.SETTINGS_CURRENT]
	return settingsProfile
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SHOW_ONLY_CURRENT_BATTLETAG() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG
end
-- local CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = E.func_CONFIG_SHOW_ONLY_CURRENT_BATTLETAG()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SHOW_ONLY_CURRENT_REGION() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION
end
-- local CONFIG_SHOW_ONLY_CURRENT_REGION = E.func_CONFIG_SHOW_ONLY_CURRENT_REGION()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SHOW_ONLY_CURRENT_SERVER() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER
end
-- local CONFIG_SHOW_ONLY_CURRENT_SERVER = E.func_CONFIG_SHOW_ONLY_CURRENT_SERVER()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SHOW_ONLY_CURRENT_FACTION() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION
end
-- local CONFIG_SHOW_ONLY_CURRENT_FACTION = E.func_CONFIG_SHOW_ONLY_CURRENT_FACTION()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SHOW_ALWAYS_AS_FIRST() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST
end
-- local CONFIG_SHOW_ALWAYS_AS_FIRST = E.func_CONFIG_SHOW_ALWAYS_AS_FIRST()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CONFIG_SORTING_CUSTOM() -- Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SORTING_CUSTOM
	local _, _, CharacterProfile_OTHER, _ = E.func_GetProfile_CHARACTERS_CURRENT()
	return CharacterProfile_OTHER and CharacterProfile_OTHER.CONFIG_SORTING_CUSTOM
end
-- local CONFIG_SORTING_CUSTOM = E.func_CONFIG_SORTING_CUSTOM()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------