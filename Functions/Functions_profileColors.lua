local GlobalAddonName, E = ...
----------------------------------------------------------------
-- local dataDisplayOrder = E.dataDisplayOrder
function E.func_GetData_profileColors(key)
	local db = Octo_profileColors
	local tbl = db.profiles[Octo_profileColors.Current_profile][key] or {}
	return tbl
end
-- local function func_ProcessComponents_profileColors()
--     E.DataProvider_Otrisovka = {}
--     E.ALL_UniversalQuests = {}
--     E.ALL_AdditionallyTOP = {}
--     E.ALL_RaidsOrDungeons = {}
--     E.OctoTables_Vibor = {}
--     E.OctoTables_DataOtrisovka = {}
--     for i, componentFunc in next, (E.Components) do
--         local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()
--         for key, value in next, (OctoTables_Vibor) do
--             if E.OctoTables_Vibor[key] == nil then
--                 E.OctoTables_Vibor[key] = value
--             end
--         end
--         for key, value in next, (OctoTables_DataOtrisovka) do
--             if E.OctoTables_DataOtrisovka[key] == nil then
--                 E.OctoTables_DataOtrisovka[key] = value
--             end
--         end
--     end
-- end
local function func_InitializeProfileStructure_profileColors(profileName)
	local db = Octo_profileColors
	E.func_InitField(db, "Current_profile", profileName)
	Octo_profileColors.Current_profile = db.Current_profile
	E.PROFTBL = Octo_profileColors.profiles[Octo_profileColors.Current_profile]

	-- E.func_InitSubTable(db, "profileColors")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, profileName)
	local profile = db.profiles[profileName]
	-- E.func_InitField(profile, "ExpansionToShow", {
	--     [12] = true,
	--     [99] = true
	-- })
	-- for _, section in ipairs(dataDisplayOrder) do
	--     E.func_InitSubTable(profile, section)
	-- end
	E.func_InitSubTable(db.profiles, "Default")
	-- local defaultProfile = db.profiles.Default
	-- for _, section in ipairs(dataDisplayOrder) do
	--     E.func_InitSubTable(defaultProfile, section)
	-- end
	return db
end
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
	local HORR, HORG, HORB, HORA = E.func_Hex2RGBA("|cffC41E3A")
	local ALLR, ALLG, ALLB, ALLA = E.func_Hex2RGBA("|cff0070DD")
	local NEUR, NEUG, NEUB, NEUA = E.func_Hex2RGBA(E.Class_Monk_Color)
	-- Цвета репутации с альфа = 0.5
	local RS1r, RS1g, RS1b, RS1a = E.func_Hex2RGBA(E.COLOR_RED, .5)
	local RS2r, RS2g, RS2b, RS2a = E.func_Hex2RGBA(E.COLOR_RED, .5)
	local RS3r, RS3g, RS3b, RS3a = E.func_Hex2RGBA(E.COLOR_ORANGE, .5)
	local RS4r, RS4g, RS4b, RS4a = E.func_Hex2RGBA(E.COLOR_YELLOW, .5)
	local RS5r, RS5g, RS5b, RS5a = E.func_Hex2RGBA(E.COLOR_YELLOW, .5)
	local RS6r, RS6g, RS6b, RS6a = E.func_Hex2RGBA(E.COLOR_GREEN, .5)
	local RS7r, RS7g, RS7b, RS7a = E.func_Hex2RGBA(E.COLOR_GREEN, .5)
	local RS8r, RS8g, RS8b, RS8a = E.func_Hex2RGBA(E.COLOR_GREEN, .5)
	local RFr, RFg, RFb, RFa = E.func_Hex2RGBA(E.COLOR_REPFRIEND, .5)
	local RMr, RMg, RMb, RMa = E.func_Hex2RGBA(E.COLOR_BLUE, .5)
	local RPr, RPg, RPb, RPa = E.func_Hex2RGBA(E.COLOR_BLUE, .5)
	local tbl = {
		ConfigColor_MAIN_MainFrame_r = 0.08,
		ConfigColor_MAIN_MainFrame_g = 0.08,
		ConfigColor_MAIN_MainFrame_b = 0.08,
		ConfigColor_MAIN_MainFrame_a = 0.8,
		ConfigColor_MAIN_MainFrame_UseFaction_CONFIG = false,
		ConfigColor_MAIN_MainFrame_UseClass_CONFIG = false,
		ConfigColor_MAIN_Border_r = 0,
		ConfigColor_MAIN_Border_g = 0,
		ConfigColor_MAIN_Border_b = 0,
		ConfigColor_MAIN_Border_a = 1,
		ConfigColor_MAIN_Border_UseFaction_CONFIG = false,
		ConfigColor_MAIN_Border_UseClass_CONFIG = false,
		ConfigColor_TOOLTIP_TooltipFrame_r = 0.15, -- 0.08,
		ConfigColor_TOOLTIP_TooltipFrame_g = 0.15, -- 0.08,
		ConfigColor_TOOLTIP_TooltipFrame_b = 0.15, -- 0.08,
		ConfigColor_TOOLTIP_TooltipFrame_a = 1,
		ConfigColor_TOOLTIP_TooltipFrame_UseFaction_CONFIG = false,
		ConfigColor_TOOLTIP_TooltipFrame_UseClass_CONFIG = false,
		ConfigColor_TOOLTIP_Border_r = 0,
		ConfigColor_TOOLTIP_Border_g = 0,
		ConfigColor_TOOLTIP_Border_b = 0,
		ConfigColor_TOOLTIP_Border_a = 1,
		ConfigColor_TOOLTIP_Border_UseFaction_CONFIG = false,
		ConfigColor_TOOLTIP_Border_UseClass_CONFIG = false,
		ConfigColor_TOOLTIP_min_RGBA_r = TR,
		ConfigColor_TOOLTIP_min_RGBA_g = TG,
		ConfigColor_TOOLTIP_min_RGBA_b = TB,
		ConfigColor_TOOLTIP_min_RGBA_a = TA,
		ConfigColor_TOOLTIP_mid_RGBA_r = OR,
		ConfigColor_TOOLTIP_mid_RGBA_g = OG,
		ConfigColor_TOOLTIP_mid_RGBA_b = OB,
		ConfigColor_TOOLTIP_mid_RGBA_a = OA,
		ConfigColor_TOOLTIP_max_RGBA_r = GR,
		ConfigColor_TOOLTIP_max_RGBA_g = GG,
		ConfigColor_TOOLTIP_max_RGBA_b = GB,
		ConfigColor_TOOLTIP_max_RGBA_a = GA,
		ConfigColor_TOOLTIP_usegradient = true,
		ConfigColor_CharLines_r = 0.5,
		ConfigColor_CharLines_g = 0.5,
		ConfigColor_CharLines_b = 0.5,
		ConfigColor_CharLines_a = 0.2,
		ConfigColor_CharLines_UseFaction_CONFIG = false,
		ConfigColor_CharLines_UseClass_CONFIG = true,
		ConfigColor_CharHeader_r = 0.5,
		ConfigColor_CharHeader_g = 0.5,
		ConfigColor_CharHeader_b = 0.5,
		ConfigColor_CharHeader_a = 0.2,
		ConfigColor_CharHeader_UseFaction_CONFIG = true,
		ConfigColor_CharHeader_UseClass_CONFIG = false,
		ConfigColor_Highlight_r = 0.5,
		ConfigColor_Highlight_g = 0.5,
		ConfigColor_Highlight_b = 0.5,
		ConfigColor_Highlight_a = 0.1,
		ConfigColor_Highlight_UseFaction_CONFIG = false,
		ConfigColor_Highlight_UseClass_CONFIG = true,
		ConfigColor_ENABLE_HIGHLIGHT_ANIMATION = false,
		-- Репутация
		ConfigColor_Rep_Standard_1_r = RS1r,
		ConfigColor_Rep_Standard_1_g = RS1g,
		ConfigColor_Rep_Standard_1_b = RS1b,
		ConfigColor_Rep_Standard_1_a = RS1a,
		ConfigColor_Rep_Standard_2_r = RS2r,
		ConfigColor_Rep_Standard_2_g = RS2g,
		ConfigColor_Rep_Standard_2_b = RS2b,
		ConfigColor_Rep_Standard_2_a = RS2a,
		ConfigColor_Rep_Standard_3_r = RS3r,
		ConfigColor_Rep_Standard_3_g = RS3g,
		ConfigColor_Rep_Standard_3_b = RS3b,
		ConfigColor_Rep_Standard_3_a = RS3a,
		ConfigColor_Rep_Standard_4_r = RS4r,
		ConfigColor_Rep_Standard_4_g = RS4g,
		ConfigColor_Rep_Standard_4_b = RS4b,
		ConfigColor_Rep_Standard_4_a = RS4a,
		ConfigColor_Rep_Standard_5_r = RS5r,
		ConfigColor_Rep_Standard_5_g = RS5g,
		ConfigColor_Rep_Standard_5_b = RS5b,
		ConfigColor_Rep_Standard_5_a = RS5a,
		ConfigColor_Rep_Standard_6_r = RS6r,
		ConfigColor_Rep_Standard_6_g = RS6g,
		ConfigColor_Rep_Standard_6_b = RS6b,
		ConfigColor_Rep_Standard_6_a = RS6a,
		ConfigColor_Rep_Standard_7_r = RS7r,
		ConfigColor_Rep_Standard_7_g = RS7g,
		ConfigColor_Rep_Standard_7_b = RS7b,
		ConfigColor_Rep_Standard_7_a = RS7a,
		ConfigColor_Rep_Standard_8_r = RS8r,
		ConfigColor_Rep_Standard_8_g = RS8g,
		ConfigColor_Rep_Standard_8_b = RS8b,
		ConfigColor_Rep_Standard_8_a = RS8a,

		ConfigColor_Rep_Friend_r = RFr,
		ConfigColor_Rep_Friend_g = RFg,
		ConfigColor_Rep_Friend_b = RFb,
		ConfigColor_Rep_Friend_a = RFa,

		ConfigColor_Rep_Major_r = RMr,
		ConfigColor_Rep_Major_g = RMg,
		ConfigColor_Rep_Major_b = RMb,
		ConfigColor_Rep_Major_a = RMa,
		ConfigColor_Rep_Paragon_r = RPr,
		ConfigColor_Rep_Paragon_g = RPg,
		ConfigColor_Rep_Paragon_b = RPb,
		ConfigColor_Rep_Paragon_a = RPa,
		-- Ковенанты
		ConfigColor_KYRIAN_r = KYR,
		ConfigColor_KYRIAN_g = KYG,
		ConfigColor_KYRIAN_b = KYB,
		ConfigColor_KYRIAN_a = KYA,
		ConfigColor_VENTHYR_r = VENR,
		ConfigColor_VENTHYR_g = VENG,
		ConfigColor_VENTHYR_b = VENB,
		ConfigColor_VENTHYR_a = VENA,
		ConfigColor_NIGHTFAE_r = NFR,
		ConfigColor_NIGHTFAE_g = NFG,
		ConfigColor_NIGHTFAE_b = NFB,
		ConfigColor_NIGHTFAE_a = NFA,
		ConfigColor_NECROLORD_r = NECR,
		ConfigColor_NECROLORD_g = NECG,
		ConfigColor_NECROLORD_b = NECB,
		ConfigColor_NECROLORD_a = NECA,
		-- Фракции
		ConfigColor_faction_Horde_r = HORR,
		ConfigColor_faction_Horde_g = HORG,
		ConfigColor_faction_Horde_b = HORB,
		ConfigColor_faction_Horde_a = HORA,
		ConfigColor_faction_Alliance_r = ALLR,
		ConfigColor_faction_Alliance_g = ALLG,
		ConfigColor_faction_Alliance_b = ALLB,
		ConfigColor_faction_Alliance_a = ALLA,
		ConfigColor_faction_Neutral_r = NEUR,
		ConfigColor_faction_Neutral_g = NEUG,
		ConfigColor_faction_Neutral_b = NEUB,
		ConfigColor_faction_Neutral_a = NEUA,
	}
	return tbl
end

local function OctoUI_tbl()
	local tbl = {
		ConfigColor_Highlight_UseFaction_CONFIG = false,
		ConfigColor_Rep_Standard_8_b = 0.4745098039215686,
		ConfigColor_MAIN_Border_r = 0.3333333432674408,
		ConfigColor_VENTHYR_a = 1,
		ConfigColor_VENTHYR_r = 0.9176470588235294,
		ConfigColor_NIGHTFAE_r = 0.7058823529411765,
		ConfigColor_NECROLORD_b = 0.4901960784313725,
		ConfigColor_CharHeader_r = 0.04,
		ConfigColor_TOOLTIP_usegradient = false,
		ConfigColor_VENTHYR_b = 0.6,
		ConfigColor_TOOLTIP_min_RGBA_a = 1,
		ConfigColor_TOOLTIP_min_RGBA_g = 0.5647059082984924,
		ConfigColor_MAIN_MainFrame_g = 0.1411764770746231,
		ConfigColor_Rep_Standard_6_r = 0.3098039215686275,
		ConfigColor_faction_Alliance_r = 0,
		ConfigColor_Rep_Standard_7_r = 0.3098039215686275,
		ConfigColor_CharHeader_UseClass_CONFIG = false,
		ConfigColor_MAIN_MainFrame_UseClass_CONFIG = false,
		ConfigColor_KYRIAN_g = 0.6588235294117647,
		ConfigColor_KYRIAN_a = 1,
		ConfigColor_TOOLTIP_min_RGBA_r = 0.5647059082984924,
		ConfigColor_faction_Neutral_a = 1,
		ConfigColor_ENABLE_HIGHLIGHT_ANIMATION = true,
		ConfigColor_MAIN_MainFrame_a = 0.8671879768371582,
		ConfigColor_MAIN_Border_g = 0.415686309337616,
		ConfigColor_TOOLTIP_Border_g = 0,
		ConfigColor_TOOLTIP_Border_UseFaction_CONFIG = false,
		ConfigColor_Highlight_a = 0.6,
		ConfigColor_Rep_Standard_7_a = 0.5,
		ConfigColor_VENTHYR_g = 0.6,
		ConfigColor_CharHeader_UseFaction_CONFIG = false,
		ConfigColor_CharLines_a = 0.6,
		ConfigColor_MAIN_MainFrame_UseFaction_CONFIG = false,
		ConfigColor_Rep_Standard_1_g = 0.2980392156862745,
		ConfigColor_Rep_Standard_2_r = 1,
		ConfigColor_TOOLTIP_Border_b = 0,
		ConfigColor_MAIN_Border_b = 0.4862745404243469,
		ConfigColor_Rep_Friend_r = 0.6235294117647059,
		ConfigColor_Rep_Friend_g = 0.4862745098039216,
		ConfigColor_Rep_Friend_b = 1,
		ConfigColor_Rep_Friend_a = 0.5,

		ConfigColor_faction_Horde_r = 0.7686274509803922,
		ConfigColor_TOOLTIP_TooltipFrame_b = 0.1647058874368668,
		ConfigColor_Rep_Paragon_b = 1,
		ConfigColor_Rep_Standard_3_r = 1,
		ConfigColor_CharHeader_g = 0.04,
		ConfigColor_CharLines_UseClass_CONFIG = false,
		ConfigColor_Rep_Paragon_r = 0,
		ConfigColor_NIGHTFAE_g = 0.6549019607843137,
		ConfigColor_TOOLTIP_Border_r = 0,
		ConfigColor_CharHeader_a = 0.6,
		ConfigColor_Rep_Standard_2_a = 0.5,
		ConfigColor_Rep_Standard_6_a = 0.5,
		ConfigColor_TOOLTIP_TooltipFrame_a = 1,
		ConfigColor_Rep_Standard_6_g = 1,
		ConfigColor_TOOLTIP_mid_RGBA_r = 0.7333333492279053,
		ConfigColor_MAIN_MainFrame_b = 0.1647058874368668,
		ConfigColor_Rep_Standard_3_g = 0.4,
		ConfigColor_TOOLTIP_mid_RGBA_b = 0.7333333492279053,
		ConfigColor_Rep_Standard_3_a = 0.5,
		ConfigColor_TOOLTIP_Border_UseClass_CONFIG = false,
		ConfigColor_TOOLTIP_max_RGBA_b = 1,
		ConfigColor_NECROLORD_a = 1,
		ConfigColor_Rep_Major_r = 0,
		ConfigColor_Rep_Standard_2_g = 0.2980392156862745,
		ConfigColor_TOOLTIP_max_RGBA_a = 1,
		ConfigColor_CharLines_UseFaction_CONFIG = false,
		ConfigColor_MAIN_Border_UseClass_CONFIG = false,
		ConfigColor_Rep_Standard_4_r = 1,
		ConfigColor_faction_Alliance_a = 1,
		ConfigColor_CharLines_b = 0.04,
		ConfigColor_Rep_Standard_4_g = 0.9529411764705882,
		ConfigColor_CharLines_r = 0.04,
		ConfigColor_Rep_Standard_8_a = 0.5,
		ConfigColor_Rep_Standard_3_b = 0.1019607843137255,
		ConfigColor_faction_Horde_b = 0.2274509803921569,
		ConfigColor_Rep_Standard_1_r = 1,
		ConfigColor_Highlight_UseClass_CONFIG = false,
		ConfigColor_Highlight_b = 0.04,
		ConfigColor_MAIN_Border_a = 1,
		ConfigColor_Rep_Standard_4_a = 0.5,
		ConfigColor_Rep_Paragon_a = 0.5,
		ConfigColor_faction_Neutral_b = 0.596078431372549,
		ConfigColor_TOOLTIP_max_RGBA_r = 1,
		ConfigColor_faction_Alliance_b = 0.8666666666666667,
		ConfigColor_Rep_Standard_5_b = 0.4431372549019608,
		ConfigColor_Rep_Standard_7_b = 0.4745098039215686,
		ConfigColor_NECROLORD_g = 0.7686274509803922,
		ConfigColor_faction_Neutral_g = 1,
		ConfigColor_Rep_Standard_1_b = 0.3098039215686275,
		ConfigColor_Highlight_r = 0.04,
		ConfigColor_faction_Horde_a = 1,
		ConfigColor_Rep_Standard_5_r = 1,
		ConfigColor_TOOLTIP_mid_RGBA_a = 1,
		ConfigColor_Highlight_g = 0.04,
		ConfigColor_TOOLTIP_TooltipFrame_r = 0.1137254983186722,
		ConfigColor_TOOLTIP_TooltipFrame_UseFaction_CONFIG = false,
		ConfigColor_Rep_Standard_5_g = 0.9529411764705882,
		ConfigColor_Rep_Standard_6_b = 0.4745098039215686,
		ConfigColor_Rep_Standard_1_a = 0.5,
		ConfigColor_TOOLTIP_max_RGBA_g = 1,
		ConfigColor_Rep_Standard_8_r = 0.3098039215686275,
		ConfigColor_NECROLORD_r = 0.5764705882352941,
		ConfigColor_Rep_Standard_4_b = 0.4431372549019608,
		ConfigColor_MAIN_Border_UseFaction_CONFIG = false,
		ConfigColor_faction_Alliance_g = 0.4392156862745098,
		ConfigColor_Rep_Major_g = 0.6392156862745098,
		ConfigColor_TOOLTIP_TooltipFrame_UseClass_CONFIG = false,
		ConfigColor_TOOLTIP_min_RGBA_b = 0.5647059082984924,
		ConfigColor_Rep_Paragon_g = 0.6392156862745098,
		ConfigColor_TOOLTIP_Border_a = 1,
		ConfigColor_Rep_Major_b = 1,
		ConfigColor_TOOLTIP_mid_RGBA_g = 0.7333333492279053,
		ConfigColor_faction_Neutral_r = 0,
		ConfigColor_KYRIAN_r = 0.4352941176470588,
		ConfigColor_Rep_Standard_7_g = 1,
		ConfigColor_NIGHTFAE_a = 1,
		ConfigColor_KYRIAN_b = 0.8627450980392157,
		ConfigColor_MAIN_MainFrame_r = 0.1137254983186722,
		ConfigColor_CharHeader_b = 0.04,
		ConfigColor_CharLines_g = 0.04,
		ConfigColor_NIGHTFAE_b = 0.8392156862745098,
		ConfigColor_Rep_Standard_8_g = 1,
		ConfigColor_TOOLTIP_TooltipFrame_g = 0.1411764770746231,
		ConfigColor_Rep_Standard_5_a = 0.5,
		ConfigColor_faction_Horde_g = 0.1176470588235294,
		ConfigColor_Rep_Major_a = 0.5,
		ConfigColor_Rep_Standard_2_b = 0.3098039215686275,
	}
	return tbl
end
-- Рекурсивная синхронизация профиля с defaults + debug
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
	for key in next, (profile) do
		local defaultValue = defaults[key]
		local currentPath = (path ~= "" and (path .. "." .. key)) or key
		if defaultValue == nil then
			profile[key] = nil
		elseif type(profile[key]) == "table" and type(defaultValue) == "table" then
			syncProfileWithDefaults(profile[key], defaultValue, profileName, currentPath)
		end
	end
end


-- local function applyProfileToE(profile)
-- 	-- local profile = Octo_profileColors.profiles[profileName]
-- 	if not profile then return end

-- 	local function recurse(tbl, prefix)
-- 		for key, value in next, tbl do
-- 			local flatKey = prefix and (prefix .. "_" .. key) or key

-- 			if type(value) == "table" then
-- 				recurse(value, flatKey)
-- 			else
-- 				E[flatKey] = value
-- 			end
-- 		end
-- 	end

-- 	recurse(profile, nil)
-- end







-- Обновлённая функция проверки всех профилей
function E.func_CheckALL_profileColors()
	local db = Octo_profileColors
	if not db.profiles then return end
	local defaults = defaults_tbl()
	for profileName, profile in next, db.profiles do
		syncProfileWithDefaults(profile, defaults, profileName)
	end
end





function E.func_CreateNew_profileColors(profileName)
	local db = func_InitializeProfileStructure_profileColors(profileName)
	-- гарантируем, что профиль существует
	db.profiles[profileName] = db.profiles[profileName] or {}
	-- единая точка инициализации / миграции
	syncProfileWithDefaults(db.profiles[profileName], defaults_tbl(), profileName)
	-- applyProfileToE(db.profiles[profileName])

	do
		local profileName = E.TEXT_DEFAULT_DARK
		local db = func_InitializeProfileStructure_profileColors(profileName)
		db.profiles[profileName] = db.profiles[profileName] or {}
		syncProfileWithDefaults(db.profiles[profileName], OctoUI_tbl(), profileName)
	end

end