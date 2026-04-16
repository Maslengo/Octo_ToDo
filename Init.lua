local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
-- local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
E.curLocaleLang = GetLocale() or "enUS"
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
E.DefaultFont = LibSharedMedia:GetDefault("font")
if E.curLocaleLang == "ruRU" or E.curLocaleLang == "enUS" then
	E.DefaultFont = "|cffD177FFE|r|cffCA79FDx|r|cffC47CFBp|r|cffBD7EF9r|r|cffB781F7e|r|cffB084F5s|r|cffAA86F4s|r|cffA389F2w|r|cff9D8CF0a|r|cff968EEEy|r|cff9091EC |r|cff8994EAR|r|cff8396E9g|r|cff7C99E7 |r|cff769CE5B|r|cff6F9EE3o|r|cff69A1E1l|r|cff63A4E0d|r"
end
----------------------------------------------------------------
E.ENABLE_HIGHTLIGHT = true
E.ENABLE_EXPANSIONCOLOR = true
----------------------------------------------------------------
E.DEBUG = false
E.DEBUG_NAME = false
E.DEBUG_CURRENCY_TOOLTIP = false
----------------------------------------------------------------
E.Octo_Table_SI_IDS = {}
E.SavedInstanceID_to_EJInstance = {}
E.EJInstance_to_SavedInstanceID = {}
E.OctoTable_ColoredFrames = {}
E.OctoTables_Vibor = {}
E.ALL_Currencies = {}
E.ALL_Items = {}
E.ALL_UniversalQuests = {}
E.ALL_AdditionallyTOP = {}
E.ALL_AdditionallyBOTTOM = {}
E.ALL_Quests = {}
E.ALL_RaidsOrDungeons = {}
E.UniversalQuestMap = {}
E.First_Option = {}
E.Second_Option = {}
E.ActiveHoliday = {}
E.Fourth_Option = {}
E.Holiday = {}
E.KeyStoneTBL = {}
E.Modules = {}
E.OctoTable_Expansions = {}
E.OctoTable_Expansions_Names = {}
E.OctoTable_Expansions_Tiers = {}
E.OctoTable_Frames_ICONS = {}
E.OctoTable_Frames_SIMPLE = {}
E.OctoTable_itemID_ALL = {}
E.OctoTable_itemID_Cataloged_Research = {}
E.OctoTable_itemID_MECHAGON = {}
E.OctoTable_KeystoneAbbr = {}
E.OctoTable_Mounts = {}
E.OctoTable_Portals = {}
E.OctoTable_QuestID = {}
E.OctoTable_SavedVariables = {}
E.OctoTables_DataOtrisovka = {}
E.Octo_ProfessionsskillLine = {}
E.Octo_ProfessionsskillLine_Other = {}
E.Third_Option = {}
E.Timers = {}
E.OctoTable_ALL_Mounts = {}
E.Components = {}
E.OctoTable_CurrencyMountForFuncCurName = {}
E._spamLocks = {}
E._inCombats = {}
E._callAfterTimer = {}
E.minValue_ItemLevel = 0
E.maxValue_ItemLevel = 0
E.minValue_Money = 0
E.maxValue_Money = 0
E.DataProvider_Otrisovka = {}
E.TEXT_DEFAULT = "Default" -- L["DEFAULT"]
E.TEXT_DEFAULT_DARK = "Default (Dark)" -- L["DEFAULT"]
E.UNIVERSAL = "UNIVERSAL_"
E.TEXTURE_ADDON = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\ToDo.tga"
E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CentralFrame.tga"
E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.TEXTURE_HIGHLIGHT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\Highlight.tga"
E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""
-- E.LEFT_MOUSE_ICON = "newplayertutorial-icon-mouse-leftbutton"
-- E.RIGHT_MOUSE_ICON = "newplayertutorial-icon-mouse-rightbutton"
-- E.MIDDLE_MOUSE_ICON = "newplayertutorial-icon-mouse-middlebutton"
E.className, E.classFilename, E.classId = UnitClass("PLAYER")
E.classColor = RAID_CLASS_COLORS[E.classFilename] and RAID_CLASS_COLORS[E.classFilename].colorStr:sub(3) or "ffffff"
E.classColorHexCurrent = E.func_GetClassColor_HEX(E.classFilename)
E.curCharName = UnitFullName("PLAYER")
E.Class_Warrior_Color = E.func_GetClassColor_HEX("WARRIOR")
E.Class_Paladin_Color = E.func_GetClassColor_HEX("PALADIN")
E.Class_Hunter_Color = E.func_GetClassColor_HEX("HUNTER")
E.Class_Rogue_Color = E.func_GetClassColor_HEX("ROGUE")
E.Class_Priest_Color = E.func_GetClassColor_HEX("PRIEST")
E.Class_Shaman_Color = E.func_GetClassColor_HEX("SHAMAN")
E.Class_Mage_Color = E.func_GetClassColor_HEX("MAGE")
E.Class_Warlock_Color = E.func_GetClassColor_HEX("WARLOCK")
E.Class_Monk_Color = E.func_GetClassColor_HEX("MONK")
E.Class_Druid_Color = E.func_GetClassColor_HEX("DRUID")
E.Class_DemonHunter_Color = E.func_GetClassColor_HEX("DEMONHUNTER")
E.Class_DeathKnight_Color = E.func_GetClassColor_HEX("DEATHKNIGHT")
E.Class_Evoker_Color = E.func_GetClassColor_HEX("EVOKER")
E.TEXT_SPACE = " "
-- E.ICON_QUESTNORMAL = "Crosshair_Quest_64"
-- E.ICON_QUESTDAILY = "Crosshair_Recurring_64"
-- E.ICON_QUESTWEEKLY = "Crosshair_Wrapper_64"
-- E.ICON_QUESTMONTHLY = "warbands-icon" -- "cursor_Wrapper_64"

E.ICON_QUESTNORMAL = "QuestNormal"
E.ICON_QUESTDAILY = "questlog-questtypeicon-daily"
E.ICON_QUESTWEEKLY = "questlog-questtypeicon-weekly"
E.ICON_QUESTMONTHLY = "questlog-questtypeicon-monthly"
E.ICON_QUESTWEEKLY_ACCOUNT = "worldquest-tracker-questmarker-gray"

E.RESET_INFO = {
	Normal = {icon = E.ICON_QUESTNORMAL, string = L["ITEM_QUALITY1_DESC"]},
	Daily = {icon = E.ICON_QUESTDAILY, string = L["DAILY"]},
	Weekly = {icon = E.ICON_QUESTWEEKLY, string = L["WEEKLY"]},
	Monthly = {icon = E.ICON_QUESTMONTHLY, string = L["CALENDAR_REPEAT_MONTHLY"]},
}





E.FULL_WIDTH = 3.60
E.FOURTH_WIDTH = E.FULL_WIDTH/4.4
E.HALF_WIDTH = E.FULL_WIDTH/2.2
E.borderColorR = 0
E.borderColorG = 0
E.borderColorB = 0
E.borderColorA = 1
E.edgeSize = 1
E.edgeFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Borders\\Octo.tga"
E.bgFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Borders\\Octo.tga"
E.menuBackdrop = {
	bgFile = E.bgFile,
	edgeFile = E.edgeFile,
	edgeSize = E.edgeSize,
	insets = {left = E.edgeSize, right = E.edgeSize, top = E.edgeSize, bottom = E.edgeSize}
}
E.MAX_DISPLAY_LINES = 30
E.ddMenuButtonHeight = 18
E.GLOBAL_LINE_HEIGHT = 20
E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2 -- Высота заголовка
E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
E.GLOBAL_LINE_WIDTH_LEFT = 200
E.GLOBAL_LINE_WIDTH_RIGHT = 90
E.Octo_font = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\Fonts\\Expressway Rg Bold.TTF"
E.GLOBAL_FONT_SIZE = 11
E.OctoFont10 = CreateFont("OctoFont10")
E.OctoFont10:CopyFontObject(GameTooltipText)
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
E.curBattleTag = E.BattleTag
E.BTAG = tostringall(strsplit("#", E.BattleTag))
E.CURRENT_REGION_ID = GetCurrentRegion()
E.CURRENT_REGION_NAME = GetCurrentRegionName() or "EU"
if E.CURRENT_REGION_NAME == "" then E.CURRENT_REGION_NAME = "US" end
E.GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail"
E.BattleTagLocal = E.BTAG.." ("..E.GameVersion..")"
E.curGUID = UnitGUID("PLAYER")
E.GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.PHYSICAL_SCREEN_WIDTH, E.PHYSICAL_SCREEN_HEIGHT = GetPhysicalScreenSize()
E.POSITION_MAIN_FRAME = -157
E.ANIMATION_DURATION = .2
E.isElvUI = select(4, C_AddOns.GetAddOnInfo("ElvUI"))
E.isRCLootCouncil = select(4, C_AddOns.GetAddOnInfo("RCLootCouncil"))
E.isWeakAuras = select(4, C_AddOns.GetAddOnInfo("WeakAuras"))
E.isTomTom = select(4, C_AddOns.GetAddOnInfo("TomTom"))
E.isPlater = select(4, C_AddOns.GetAddOnInfo("Plater"))
E.isOmniCD = select(4, C_AddOns.GetAddOnInfo("OmniCD"))
E.isOmniCC = select(4, C_AddOns.GetAddOnInfo("OmniCC"))
E.isParrot = select(4, C_AddOns.GetAddOnInfo("Parrot"))
E.ALPHA_BACKGROUND = .2
E.COLOR_TIME = "|cff9999FF"
-- E.COLOR_WORLDOFWARCRAFT = "|cffD6AB7D"
-- E.COLOR_THEBURNINGCRUSADE = "|cffE43E5A"
-- E.COLOR_WRATHOFTHELICHKING = "|cff3FC7EB"
-- E.COLOR_CATACLYSM = "|cffFF7C0A"
-- E.COLOR_MISTSOFPANDARIA = "|cff00EF88"
-- E.COLOR_WARLORDSOFDRAENOR = "|cffF48CBA"
-- E.COLOR_LEGION = "|cffAAD372"
-- E.COLOR_BATTLEFORAZEROTH = "|cffFFF468"
-- E.COLOR_SHADOWLANDS = "|cff9798FE"
-- E.COLOR_DRAGONFLIGHT = "|cff53B39F"
-- E.COLOR_THEWARWITHIN = "|cff90CCDD"
-- E.COLOR_MIDNIGHT = "|cffB580FF"
-- E.COLOR_THELASTTITAN = "|cffF4C263"
E.COLOR_WORLDOFWARCRAFT = "|cffD0B070"
E.COLOR_THEBURNINGCRUSADE = "|cffD45565"
E.COLOR_WRATHOFTHELICHKING = "|cff6CB8D8"
E.COLOR_CATACLYSM = "|cffE07835"
E.COLOR_MISTSOFPANDARIA = "|cff5FD4B0"
E.COLOR_WARLORDSOFDRAENOR = "|cffB06578"
E.COLOR_LEGION = "|cff8FD060"
E.COLOR_BATTLEFORAZEROTH = "|cffE4C860"
E.COLOR_SHADOWLANDS = "|cffb2a4ed"
E.COLOR_DRAGONFLIGHT = "|cff6BC8A8"
E.COLOR_THEWARWITHIN = "|cff9CB4C8"
E.COLOR_MIDNIGHT = "|cff7a91ff"
E.COLOR_THELASTTITAN = "|cffE0C880"
E.COLOR_WOW_POOR = "|cff9D9D9D"
E.COLOR_WOW_COMMON = "|cffFFFFFF"
E.COLOR_WOW_UNCOMMON = "|cff1EFF00"
E.COLOR_WOW_RARE = "|cff0070DD"
E.COLOR_WOW_EPIC = "|cffA335EE"
E.COLOR_WOW_LEGENDARY = "|cffFF8000"
E.COLOR_WOW_ARTIFACT = "|cffD9CC80"
E.COLOR_WOW_HEIRLOOM = "|cff00CCFF"
E.COLOR_WOW_TOKEN = "|cff00CCFF"
E.COLOR_KYRIAN = "|cff6FA8DC"
E.COLOR_NECROLORD = "|cff93C47D"
E.COLOR_NIGHTFAE = "|cffB4A7D6"
E.COLOR_VENTHYR = "|cffEA9999"
E.COLOR_BLACK = "|cff000000"
E.COLOR_DARKGRAY = "|cff252525"
E.COLOR_GRAY = "|cff757575"
E.COLOR_LIGHTGRAY = "|cff909090"
E.COLOR_WHITE = "|cffFFFFFF"
E.COLOR_ADDON_LEFT = "|cffD177FF"
E.COLOR_ADDON_RIGHT = "|cff63A4E0"
E.COLOR_RED = "|cffFF4C4F"
E.COLOR_ORANGE = "|cffFF661A"
E.COLOR_DARKORANGE = "|cffFF8C00"
E.COLOR_GOLD = "|cffFFD600"
E.COLOR_YELLOW = "|cffFFF371"
E.COLOR_LIME = "|cffACFF2F"
E.COLOR_GREEN = "|cff4FFF79"
E.COLOR_CYAN = "|cff00FFFF"
E.COLOR_BLUE = "|cff00A3FF"
E.COLOR_PURPLE = "|cffAF61FF"
E.COLOR_INDIGO = "|cff4B0082"
E.COLOR_MAGENTA = "|cffFF00FF"
E.COLOR_PINK = "|cffFF69B3"
E.COLOR_SKYBLUE = "|cff87CDEB"
E.COLOR_STEELBLUE = "|cff4682B3"
E.COLOR_SLATEGRAY = "|cff708090"
E.COLOR_BROWN = "|cff964B00"
E.COLOR_HOLIDAY = "|cffFF8C00"
E.COLOR_EVENT = "|cffFFF371"
E.COLOR_DEBUG = E.classColorHexCurrent
E.COLOR_FUNCTION = "|cff87CDEB"
E.COLOR_IVORY = "|cffFFF7D7"

E.COLOR_REPPARAGON =  "|cff00A3FF"      -- "|cff00527F" -- 00A3FF
E.COLOR_REPMAJOR =  "|cff00A3FF"      -- "|cff00527F" -- 00A3FF
E.COLOR_REPFRIEND =  "|cff9F7CFF"      -- "|cff4F3E7F"  -- 9F7CFF
E.COLOR_REPSIMPLE_1 =  "|cffFF4C4F"      -- "|cff7F2629" -- FF4C4F
E.COLOR_REPSIMPLE_2 =  "|cffFF4C4F"      -- "|cff7F2629" -- FF4C4F
E.COLOR_REPSIMPLE_3 =  "|cffFF661A"      -- "|cff7F300E" -- FF661A
E.COLOR_REPSIMPLE_4 =  "|cffFFF371"      -- "|cff7C7638" -- FFF371
E.COLOR_REPSIMPLE_5 =  "|cffFFF371"      -- "|cff7C7638" -- FFF371
E.COLOR_REPSIMPLE_6 =  "|cff4FFF79"      -- "|cff277F3C" -- 4FFF79
E.COLOR_REPSIMPLE_7 =  "|cff4FFF79"      -- "|cff277F3C" -- 4FFF79
E.COLOR_REPSIMPLE_8 =  "|cff4FFF79"      -- "|cff277F3C" -- 4FFF79


E.FACTION_CURRENT = UnitFactionGroup("PLAYER")
E.FACTION_OPPOSITE = E.FACTION_CURRENT == "Alliance" and "Horde" or "Alliance"
E.ICON_TABARD = 135026
E.ICON_KYRIAN = "CovenantChoice-Panel-Sigil-Kyrian" -- 3641395
E.ICON_NECROLORD = "CovenantChoice-Panel-Sigil-Necrolords" -- 3752259 -- 3641396
E.ICON_NIGHTFAE = "CovenantChoice-Panel-Sigil-NightFae" -- 3752258 -- 3641394
E.ICON_VENTHYR = "CovenantChoice-Panel-Sigil-Venthyr" -- 3257751 -- 3641397
E.ICON_WORLDBOSS = "worldquest-icon-boss" -- 3528312
E.ICON_RARES = "nameplates-icon-rareelite" -- 135903 -- "UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Star" "UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare"
E.ICON_MONEY = "Coin-Gold" -- 133784
-- challenges-medal-small-bronze challenges-medal-bronze
-- challenges-medal-small-silver challenges-medal-silver
-- challenges-medal-small-gold   challenges-medal-gold
E.ATLAS_REPAIR = "Repair" -- "SpellIcon-256x256-RepairAll" -- "Crosshair_repairnpc_32" -- 132281 -- 136241
E.ATLAS_REPAIR_GRAY = "Crosshair_unablerepairnpc_32"
E.ATLAS_MAIL = "Crosshair_mail_32" -- "UI-HUD-Minimap-Mail-Up"
E.ATLAS_MAIL_GRAY = "Crosshair_unablemail_32"
E.ATLAS_RAID = "Raid"
E.ATLAS_DUNGEON = "Dungeon"
E.ICON_FIRSTRAID = 136346 -- 7480127
E.ATLAS_WORLDBOSS = "worldquest-icon-boss"
-- UI-HUD-Minimap-Mail-New-Flipbook-2x
-- UI-HUD-Minimap-Mail-Reminder-Flipbook-2x


-- interface/warbands/uiwarbandsicons
E.ATLAS_ACCOUNT_WIDE = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\warbands-icon" -- "warbands-icon"
E.ATLAS_ACCOUNT_TRANSFERABLE = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\warbands-transferable-icon" -- "warbands-transferable-icon"



E.ATLAS_GREATVAULT = "greatvault-dragonflight-32x32" -- GreatVault-32x32
-- "greatVault-whole-normal"


E.COLOR_HORDE = "|cffC41E3A"
E.COLOR_ALLIANCE = "|cff0070DD"
E.COLOR_NEUTRAL = E.Class_Monk_Color

E.ICON_HORDE = "HordeEmblem" -- "GarrMission_ClassIcon-Horde" -- 255142-- 2565244
E.ICON_ALLIANCE = "AllianceEmblem" -- "GarrMission_ClassIcon-Alliance" -- 255140-- 2565243
E.ICON_NEUTRAL = 775462
if E.FACTION_CURRENT == "Horde" then
	E.ICON_CURRENT_FACTION = E.ICON_HORDE
	E.COLOR_FACTION = E.COLOR_HORDE
elseif E.FACTION_CURRENT == "Alliance" then
	E.ICON_CURRENT_FACTION = E.ICON_ALLIANCE
	E.COLOR_FACTION = E.COLOR_ALLIANCE
else
	E.ICON_CURRENT_FACTION = 775462
	E.COLOR_FACTION = E.Class_Monk_Color
end

E.COLOR_KYRIAN_R = 0.44
E.COLOR_KYRIAN_G = 0.66
E.COLOR_KYRIAN_B = 0.86
E.COLOR_NECROLORD_R = 0.58
E.COLOR_NECROLORD_G = 0.77
E.COLOR_NECROLORD_B = 0.49
E.COLOR_NIGHTFAE_R = 0.56
E.COLOR_NIGHTFAE_G = 0.49
E.COLOR_NIGHTFAE_B = 0.76
E.COLOR_VENTHYR_R = 0.88
E.COLOR_VENTHYR_G = 0.40
E.COLOR_VENTHYR_B = 0.40

E.RIFT = E.COLOR_PURPLE.." (RIFT)|r"
E.DONE = E.COLOR_GREEN..L["DONE"].."|r"
E.NONE = E.COLOR_GRAY..L["NONE"].."|r"
E.TRUE = E.COLOR_GREEN.."true|r"
E.FALSE = E.COLOR_RED.."false|r"
E.NIL = E.COLOR_RED.."nil|r"
E.ICON_WARBANDS = E.COLOR_BLUE.."(A)".."|r"
E.ICON_QUESTION_MARK = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.ICON_EMPTY = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\ICON_EMPTY"
E.ICON_DEBUG = 7448162 -- "poi-torghast" -- ATLAS
E.ICON_LFG = "Interface\\LFGFRAME\\BattlenetWorking0"
E.OctoTable_Covenant = {
	[1] = {
		prefix = "SL_KYRIAN",
		name = "Kyrian",
		icon = E.ICON_KYRIAN,
		color = E.COLOR_KYRIAN,
		r = E.COLOR_KYRIAN_R,
		g = E.COLOR_KYRIAN_G,
		b = E.COLOR_KYRIAN_B,
	},
	[2] = {
		prefix = "SL_VENTHYR",
		name = "Venthyr",
		icon = E.ICON_VENTHYR,
		color = E.COLOR_VENTHYR,
		r = E.COLOR_VENTHYR_R,
		g = E.COLOR_VENTHYR_G,
		b = E.COLOR_VENTHYR_B,
	},
	[3] = {
		prefix = "SL_NIGHTFAE",
		name = "Night fae",
		icon = E.ICON_NIGHTFAE,
		color = E.COLOR_NIGHTFAE,
		r = E.COLOR_NIGHTFAE_R,
		g = E.COLOR_NIGHTFAE_G,
		b = E.COLOR_NIGHTFAE_B,
	},
	[4] = {
		prefix = "SL_NECROLORD",
		name = "Necrolord",
		icon = E.ICON_NECROLORD,
		color = E.COLOR_NECROLORD,
		r = E.COLOR_NECROLORD_R,
		g = E.COLOR_NECROLORD_G,
		b = E.COLOR_NECROLORD_B,
	},
}
-- E.CovenantData = {
--   [1] = { prefix = "SL_KYRIAN" },
--   [2] = { prefix = "SL_VENTHYR" },
--   [3] = { prefix = "SL_NIGHTFAE" },
--   [4] = { prefix = "SL_NECROLORD" },
-- }
E.LIST_MAX_SIZE = 30
E.DEVTEXT = "|T"..E.IconTexture..":14:14:::64:64:4:60:4:60|t"..E.COLOR_GREEN.."DebugInfo|r: "
E.func_IsClassic = E.interfaceVersion > 10000 and E.interfaceVersion < 20000
E.func_IsBC = E.interfaceVersion > 20000 and E.interfaceVersion < 30000
E.func_IsWOTLK = E.interfaceVersion > 30000 and E.interfaceVersion < 40000
E.func_IsCataclysm = E.interfaceVersion > 40000 and E.interfaceVersion < 50000
E.func_IsMOP = E.interfaceVersion > 50000 and E.interfaceVersion < 60000
E.func_IsWOD = E.interfaceVersion > 60000 and E.interfaceVersion < 70000
E.func_IsLegion = E.interfaceVersion > 70000 and E.interfaceVersion < 80000
E.func_IsBFA = E.interfaceVersion > 80000 and E.interfaceVersion < 90000
E.func_IsShadowlands = E.interfaceVersion > 90000 and E.interfaceVersion < 100000
E.func_IsDragonflight = E.interfaceVersion > 100000 and E.interfaceVersion < 110000
E.func_IsTWW = E.interfaceVersion > 110000 and E.interfaceVersion < 120000
E.IsMidnight = E.interfaceVersion > 120000 and E.interfaceVersion < 130000
E.IsTLT = E.interfaceVersion > 130000 and E.interfaceVersion < 140000
E.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
E.IsPTR = GetCurrentRegion() >= 72 -- 90 BETA midnight
E.IsRemix = PlayerIsTimerunning and PlayerIsTimerunning()
E.Is_WorldofWarcraft_available = E.interfaceVersion >= 10000
E.Is_TheBurningCrusade_available = E.interfaceVersion >= 20000
E.Is_WrathoftheLichKing_available = E.interfaceVersion >= 30000
E.Is_Cataclysm_available = E.interfaceVersion >= 40000
E.Is_MistsofPandaria_available = E.interfaceVersion >= 50000
E.Is_WarlordsofDraenor_available = E.interfaceVersion >= 60000
E.Is_Legion_available = E.interfaceVersion >= 70000
E.Is_BattleforAzeroth_available = E.interfaceVersion >= 80000
E.Is_Shadowlands_available = E.interfaceVersion >= 90000
E.Is_Dragonflight_available = E.interfaceVersion >= 100000
E.Is_TheWarWithin_available = E.interfaceVersion >= 110000
E.Is_Midnight_available = E.interfaceVersion >= 120000
E.Is_TheLastTitan_available = E.interfaceVersion >= 130000

E.OctoTable_PlayerBags = {
	-- Enum.BagIndex.Keyring, -- -1, (no need in retail)
	Enum.BagIndex.Backpack, -- 0,
	Enum.BagIndex.Bag_1, -- 1,
	Enum.BagIndex.Bag_2, -- 2,
	Enum.BagIndex.Bag_3, -- 3,
	Enum.BagIndex.Bag_4, -- 4,
	Enum.BagIndex.ReagentBag, -- 5,
}

E.OctoTable_PlayerBags_WithoutReagents = {
	-- Enum.BagIndex.Keyring, -- -1, (no need in retail)
	Enum.BagIndex.Backpack, -- 0,
	Enum.BagIndex.Bag_1, -- 1,
	Enum.BagIndex.Bag_2, -- 2,
	Enum.BagIndex.Bag_3, -- 3,
	Enum.BagIndex.Bag_4, -- 4,
	-- Enum.BagIndex.ReagentBag, -- 5,
}



E.OctoTable_bankTabs = {
	-- Enum.BagIndex.CharacterBankTab, -- -2, (classic)
	Enum.BagIndex.CharacterBankTab_1, -- 6,
	Enum.BagIndex.CharacterBankTab_2, -- 7,
	Enum.BagIndex.CharacterBankTab_3, -- 8,
	Enum.BagIndex.CharacterBankTab_4, -- 9,
	Enum.BagIndex.CharacterBankTab_5, -- 10,
	Enum.BagIndex.CharacterBankTab_6, -- 11,
}
E.OctoTable_Account_bankTabs = {
	-- Enum.BagIndex.Accountbanktab, -- (такого нет, хотя есть в Enum)
	Enum.BagIndex.AccountBankTab_1, -- 12
	Enum.BagIndex.AccountBankTab_2, -- 13
	Enum.BagIndex.AccountBankTab_3, -- 14
	Enum.BagIndex.AccountBankTab_4, -- 15
	Enum.BagIndex.AccountBankTab_5, -- 16
}
E.OctoTable_SlotMapping = {
	[1] = {name = "HEADSLOT", invslot = INVSLOT_HEAD, priority = 1},
	[2] = {name = "NECKSLOT", invslot = INVSLOT_NECK, priority = 2},
	[3] = {name = "SHOULDERSLOT", invslot = INVSLOT_SHOULDER, priority = 3},
	[15] = {name = "BACKSLOT", invslot = INVSLOT_BACK, priority = 4},
	[5] = {name = "CHESTSLOT", invslot = INVSLOT_CHEST, priority = 5},
	[4] = {name = "SHIRTSLOT", invslot = INVSLOT_BODY, priority = 6},
	[19] = {name = "TABARDSLOT", invslot = INVSLOT_TABARD, priority = 7},
	[9] = {name = "WRISTSLOT", invslot = INVSLOT_WRIST, priority = 8},
	[10] = {name = "HANDSSLOT", invslot = INVSLOT_HAND, priority = 9},
	[6] = {name = "WAISTSLOT", invslot = INVSLOT_WAIST, priority = 10},
	[7] = {name = "LEGSSLOT", invslot = INVSLOT_LEGS, priority = 11},
	[8] = {name = "FEETSLOT", invslot = INVSLOT_FEET, priority = 12},
	[11] = {name = "FINGER0SLOT", invslot = INVSLOT_FINGER1, priority = 13},
	[12] = {name = "FINGER1SLOT", invslot = INVSLOT_FINGER2, priority = 14},
	[13] = {name = "TRINKET0SLOT", invslot = INVSLOT_TRINKET1, priority = 15},
	[14] = {name = "TRINKET1SLOT", invslot = INVSLOT_TRINKET2, priority = 16},
	[16] = {name = "MAINHANDSLOT", invslot = INVSLOT_MAINHAND, priority = 17},
	[17] = {name = "SECONDARYHANDSLOT", invslot = INVSLOT_OFFHAND, priority = 18},
}
E.dataDisplayOrder = {
	"AdditionallyTOP",
	"Currencies",
	"Items",
	"RaidsOrDungeons",
	"UniversalQuests",
	"Reputations",
	"AdditionallyBOTTOM",
}
local season = C_MythicPlus and C_MythicPlus.GetCurrentSeason()
if season == nil or season == false or season == 0 or season == -1 then
	E.MythicPlus_seasonID = 1
else
	E.MythicPlus_seasonID = season
end
E.TEXT_INDEV = E.COLOR_RED..">>> ".."In Development".." <<<|r"

-- Таблица цветовых схем для редактора
E.editorThemes = {
	["Twilight"] = {
		-- ["Special"] = "|cff7587A6", -- спецсимволы (голубоватый)
		["Special"] = "|cff66d9ef", -- спецсимволы (голубой)
		["Keyword"] = "|cffCDA869", -- ключевые слова (золотисто-бежевый)
		["Comment"] = "|cff5F5A60", -- комментарии (серо-фиолетовый)
		["Number"] = "|cffCF6A4C", -- числа (оранжево-красный)
		["String"] = "|cff8F9D6A", -- строки (травянисто-зелёный)
		["Background"] = "|cff141414", -- тёмный фон
		-- ["Foreground"] = "|cffF8F8F2", -- основной текст (не чисто белый, а слегка голубоватый)
		["Function"] = "|cffDAD085", -- функции (жёлто-бежевый)
		["Class"] = "|cff9B703F", -- классы/типы (коричневатый)
		-- ["Operator"] = "|cffF8F8F2", -- операторы (как основной текст)
		-- ["Bracket"] = "|cffF8F8F2", -- скобки (как основной текст)
		["Tag"] = "|cffAC885B", -- теги (коричневатый)
		["Attribute"] = "|cff7587A6", -- атрибуты (голубоватый)
		["Constant"] = "|cffCF6A4C", -- константы (оранжево-красный)
		["Error"] = "|cffCF6A4C", -- ошибки (оранжево-красный)
	},
	["Standard"] = {
		["Special"] = "|c00ff3333", -- спецсимволы (ярко-красный)
		["Keyword"] = "|c004444ff", -- ключевые слова (синий)
		["Comment"] = "|c0000aa00", -- комментарии (зелёный)
		["Number"] = "|c00ff9900", -- числа (оранжевый)
		["String"] = "|c00999999", -- строки (серый)
	},
	["Obsidian"] = {
		["Special"] = "|c00AFC0E5", -- спецсимволы (голубой)
		["Keyword"] = "|c0093C763", -- ключевые слова (зелёный)
		["Comment"] = "|c0066747B", -- комментарии (серо-голубой)
		["Number"] = "|c00FFCD22", -- числа (жёлтый)
		["String"] = "|c00EC7600", -- строки (оранжевый)
	},
	["Monokai"] = {
		["Special"] = "|c0066d9ef", -- спецсимволы (бирюзовый)
		["Keyword"] = "|c00f92672", -- ключевые слова (розовый)
		["Comment"] = "|c0075715e", -- комментарии (серо-коричневый)
		["Number"] = "|c00ae81ff", -- числа (фиолетовый)
		["String"] = "|c00e6db74", -- строки (жёлтый)
	},
	["Sublime"] = {
		["Special"] = "|cff66d9ef", -- спецсимволы (голубой)
		["Keyword"] = "|cffF9EE98", -- ключевые слова (светло-жёлтый)
		["Comment"] = "|cff605A60", -- комментарии (серо-фиолетовый)
		["Number"] = "|cffCF6137", -- числа (красно-оранжевый)
		["String"] = "|cff829D61", -- строки (зелёный)
	},
}




E.cur_gender = UnitSex("PLAYER")
-- addon mem: 6.16 MB
E.OctoTable_Prefixes = {
	"Русский",
	"Deutsch",
	"English",
	"Español",
	"Français",
	"Italiano",
	"Português Brasileiro",
	"Korean",
	"Chinese",
}
E.OctoTable_Launguages = {
	{name = "ruRU", translate = "Русский", }, -- 1
	{name = "deDE", translate = "Deutsch", }, -- 2
	{name = "enEN", translate = "English", }, -- 3
	{name = "esES", translate = "Español", }, -- 4
	{name = "esMX", translate = "Español (México)", }, -- 5
	{name = "frFR", translate = "Français", }, -- 6
	{name = "itIT", translate = "Italiano", }, -- 7
	{name = "ptBR", translate = "Português (Brasil)", }, -- 8
	{name = "koKR", translate = "한국어", }, -- 9
	{name = "zhCN", translate = "简体中文", }, -- 10
	{name = "zhTW", translate = "繁體中文", }, -- 11

	{name = "Auto", translate = "Язык", }, -- 12
}
E.CompressionMethod = Enum.CompressionMethod and Enum.CompressionMethod.Deflate or 0
E.CompressionLevel = Enum.CompressionLevel and Enum.CompressionLevel.OptimizeForSize or 2
E.Base64Variant = Enum.Base64Variant and Enum.Base64Variant.StandardUrlSafe or 1