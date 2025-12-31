local GlobalAddonName, E = ... -- ns
----------------------------------------------------------------
E.MainAddonName = GlobalAddonName
OctoEngine = E -- в других аддонах
-- CreateFrame
----------------------------------------------------------------
E.DEBUG = false
----------------------------------------------------------------
E.L = {}
E.OctoTables_Vibor = {}
E.ALL_Currencies = {}
E.ALL_Items = {}
E.ALL_Reputations = {}
E.ALL_UniversalQuests = {}
E.ALL_Additionally = {}
E.ALL_Quests = {}
E.ALL_RaidsOrDungeons = {}
E.First_Option = {}
E.Second_Option = {}
E.ActiveHoliday = {}
E.Fourth_Option = {}
E.Holiday = {}
E.KeyStoneTBL = {}
E.Modules = {}
E.OctoTable_Expansions = {}
E.OctoTable_Frames_ICONS = {}
E.OctoTable_Frames_SIMPLE = {}
E.OctoTable_itemID_ALL = {}
E.OctoTable_itemID_AutoOpen = {}
E.OctoTable_itemID_Cataloged_Research = {}
E.OctoTable_itemID_Ignore_List = {}
E.OctoTable_itemID_ItemsDelete = {}
E.OctoTable_itemID_ItemsUsable = {}
E.OctoTable_itemID_ItemsUsable_Other = {}
E.OctoTable_itemID_MECHAGON = {}
E.OctoTable_KeystoneAbbr = {}
E.OctoTable_Mounts = {}
E.OctoTable_Portals = {}
E.OctoTable_QuestID = {}
E.OctoTable_QuestID_Paragon = {}
E.OctoTable_RemixInfinityResearch = {}
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
E.REPUTATION_ALPHA = .4 -- Octo_ToDo_DB_Vars.Config_REPUTATION_ALPHA
E.CHARACTER_ALPHA = .1 -- Octo_ToDo_DB_Vars.Config_CHARACTER_ALPHA
E.MAINBACKGROUND_ALPHA = .8 -- Octo_ToDo_DB_Vars.Config_MAINBACKGROUND_ALPHA
E.DataProvider_Otrisovka = {}
E.CurrentProfile = "Default" -- profileName
E.Config_DebugID_ALL = false
-- E.Config_DebugID_Achievements = false
-- E.Config_DebugID_Currencies = false
-- E.Config_DebugID_worldBossID = false
-- E.Config_DebugID_Quests = false
-- E.Config_DebugID_Spells = false
-- E.Config_DebugID_Maps = false
-- E.Config_DebugID_instanceID = false
-- E.Config_DebugID_Mounts = false
-- E.Config_DebugID_NPCs = false
-- E.Config_DebugID_Items = false
-- E.Config_DebugID_Reputations = false
-- E.Config_DebugID_Events = false
-- E.Config_DebugID_Professions = false
E.UNIVERSAL = "UNIVERSAL_"
E.TEXTURE_ADDON = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\ToDo.tga"
E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CentralFrame.tga"
E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Textures\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""
E.curLocaleLang = GetLocale() or "enUS"
E.className, E.classFilename, E.classId = UnitClass("PLAYER")
E.classColor = RAID_CLASS_COLORS[E.classFilename] and RAID_CLASS_COLORS[E.classFilename].colorStr:sub(3) or "ffffff"
E.classColorHexCurrent = C_ClassColor.GetClassColor(E.classFilename):GenerateHexColorMarkup()
E.curCharName = UnitFullName("PLAYER")
E.Class_Warrior_Color = C_ClassColor.GetClassColor("WARRIOR"):GenerateHexColorMarkup()
E.Class_Paladin_Color = C_ClassColor.GetClassColor("PALADIN"):GenerateHexColorMarkup()
E.Class_Hunter_Color = C_ClassColor.GetClassColor("HUNTER"):GenerateHexColorMarkup()
E.Class_Rogue_Color = C_ClassColor.GetClassColor("ROGUE"):GenerateHexColorMarkup()
E.Class_Priest_Color = C_ClassColor.GetClassColor("PRIEST"):GenerateHexColorMarkup()
E.Class_Shaman_Color = C_ClassColor.GetClassColor("SHAMAN"):GenerateHexColorMarkup()
E.Class_Mage_Color = C_ClassColor.GetClassColor("MAGE"):GenerateHexColorMarkup()
E.Class_Warlock_Color = C_ClassColor.GetClassColor("WARLOCK"):GenerateHexColorMarkup()
E.Class_Monk_Color = C_ClassColor.GetClassColor("MONK"):GenerateHexColorMarkup()
E.Class_Druid_Color = C_ClassColor.GetClassColor("DRUID"):GenerateHexColorMarkup()
E.Class_DemonHunter_Color = C_ClassColor.GetClassColor("DEMONHUNTER"):GenerateHexColorMarkup()
E.Class_DeathKnight_Color = C_ClassColor.GetClassColor("DEATHKNIGHT"):GenerateHexColorMarkup()
E.Class_Evoker_Color = C_ClassColor.GetClassColor("EVOKER"):GenerateHexColorMarkup()
E.TEXT_SPACE = " "
E.SPAM_TIME = 3
E.Config_UseTranslit = false
E.ICON_REGULAR = "Crosshair_Quest_64"
E.ICON_DAILY = "Crosshair_Recurring_64"
E.ICON_WEEKLY = "Crosshair_Wrapper_64"
E.ICON_MONTH = "cursor_Wrapper_64"
E.FULL_WIDTH = 3.60
E.backgroundColorR = .08
E.backgroundColorG = .08
E.backgroundColorB = .08
E.backgroundColorA = .8
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
E.ddMenuButtonHeight = 16
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
E.BTAG = tostringall(strsplit("#", E.BattleTag))
E.CURRENT_REGION_ID = GetCurrentRegion()
E.CURRENT_REGION_NAME = GetCurrentRegionName() or "EU"
E.ENABLE_HIGHLIGHT_ANIMATION = false
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
E.COLOR_WORLDOFWARCRAFT = "|cffD6AB7D"
E.COLOR_THEBURNINGCRUSADE = "|cffE43E5A"
E.COLOR_WRATHOFTHELICHKING = "|cff3FC7EB"
E.COLOR_CATACLYSM = "|cffFF7C0A"
E.COLOR_MISTSOFPANDARIA = "|cff00EF88"
E.COLOR_WARLORDSOFDRAENOR = "|cffF48CBA"
E.COLOR_LEGION = "|cffAAD372"
E.COLOR_BATTLEFORAZEROTH = "|cffFFF468"
E.COLOR_SHADOWLANDS = "|cff9798FE"
E.COLOR_DRAGONFLIGHT = "|cff53B39F"
E.COLOR_THEWARWITHIN = "|cff90CCDD"
E.COLOR_MIDNIGHT = "|cff7B69FF"
E.COLOR_THELASTTITAN = "|cffF4C263"
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
E.FACTION_CURRENT = UnitFactionGroup("PLAYER")
E.FACTION_OPPOSITE = E.FACTION_CURRENT == "Alliance" and "Horde" or "Alliance"
E.ICON_TABARD = 135026
E.ICON_ALLIANCE = 255140
E.ICON_HORDE = 255142
E.ICON_KYRIAN = 3641395
E.ICON_NECROLORD = 3752259 -- 3641396
E.ICON_NIGHTFAE = 3752258 -- 3641394
E.ICON_VENTHYR = 3257751 -- 3641397
E.ICON_WORLDBOSS = 3528312
E.ICON_RARES = 135903
E.ICON_MONEY = 133784
E.ICON_DURABILITY = 132281 -- 136241
E.ATLAS_REPAIR = "Crosshair_repairnpc_32"
E.ATLAS_REPAIR_GRAY = "Crosshair_unablerepairnpc_32"
E.ATLAS_MAIL = "Crosshair_mail_32" -- "UI-HUD-Minimap-Mail-Up"
E.ATLAS_MAIL_GRAY = "Crosshair_unablemail_32"

-- E.ATLAS_RAID = "Raid"
-- E.ATLAS_DUNGEON = "Dungeon"

E.ATLAS_RAID = "questlog-questtypeicon-raid"
E.ATLAS_DUNGEON = "questlog-questtypeicon-dungeon"

-- E.ATLAS_RAID = "worldquest-icon-raid"
-- E.ATLAS_DUNGEON = "worldquest-icon-dungeon"

E.ATLAS_WORLDBOSS = "worldquest-icon-boss"



-- UI-HUD-Minimap-Mail-New-Flipbook-2x
-- UI-HUD-Minimap-Mail-Reminder-Flipbook-2x

E.ATLAS_ACCOUNT_WIDE = "warbands-icon"-- CreateAtlasMarkup("warbands-icon", 16, 16)
E.ATLAS_ACCOUNT_TRANSFERABLE = "warbands-transferable-icon"-- CreateAtlasMarkup("warbands-transferable-icon", 16, 16)

E.COLOR_HORDE = "|cffC41E3A"
E.COLOR_ALLIANCE = "|cff0070DD"
E.COLOR_NEUTRAL = E.Class_Monk_Color
if E.FACTION_CURRENT == "Horde" then
	E.ICON_FACTION = 2565244
	E.COLOR_FACTION = E.COLOR_HORDE
elseif E.FACTION_CURRENT == "Alliance" then
	E.ICON_FACTION = 2565243
	E.COLOR_FACTION = E.COLOR_ALLIANCE
else
	E.ICON_FACTION = 775462
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
E.DONE = E.COLOR_GREEN..DONE.."|r"
E.NONE = E.COLOR_GRAY..NONE.."|r"
E.TRUE = E.COLOR_GREEN.."true|r"
E.FALSE = E.COLOR_RED.."false|r"
E.NIL = E.COLOR_RED.."nil|r"
E.ICON_WARBANDS = E.COLOR_BLUE.."(A)".."|r"
E.ICON_QUESTION_MARK = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.ICON_EMPTY = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\ICON_EMPTY"
E.ICON_LFG = "Interface\\LFGFRAME\\BattlenetWorking0"
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
E.OctoTable_Covenant = {
	[1] = {
		name = C_Covenants.GetCovenantData(1).name,
		icon = E.ICON_KYRIAN,
		color = E.COLOR_KYRIAN,
		r = E.COLOR_KYRIAN_R,
		g = E.COLOR_KYRIAN_G,
		b = E.COLOR_KYRIAN_B,
	},
	[2] = {
		name = C_Covenants.GetCovenantData(2).name,
		icon = E.ICON_VENTHYR,
		color = E.COLOR_VENTHYR,
		r = E.COLOR_VENTHYR_R,
		g = E.COLOR_VENTHYR_G,
		b = E.COLOR_VENTHYR_B,
	},
	[3] = {
		name = C_Covenants.GetCovenantData(3).name,
		icon = E.ICON_NIGHTFAE,
		color = E.COLOR_NIGHTFAE,
		r = E.COLOR_NIGHTFAE_R,
		g = E.COLOR_NIGHTFAE_G,
		b = E.COLOR_NIGHTFAE_B,
	},
	[4] = {
		name = C_Covenants.GetCovenantData(4).name,
		icon = E.ICON_NECROLORD,
		color = E.COLOR_NECROLORD,
		r = E.COLOR_NECROLORD_R,
		g = E.COLOR_NECROLORD_G,
		b = E.COLOR_NECROLORD_B,
	},
}
E.LIST_MAX_SIZE = 30
E.DEBUG_TEXT = E.COLOR_BLUE..BINDING_HEADER_DEBUG.."|r"
E.DEVTEXT = "|T"..E.IconTexture..":14:14:::64:64:4:60:4:60|t"..E.COLOR_GREEN.."DebugInfo|r: "
function E.func_IsClassic() return E.interfaceVersion > 10000 and E.interfaceVersion < 20000 end
function E.func_IsBC() return E.interfaceVersion > 20000 and E.interfaceVersion < 30000 end
function E.func_IsWOTLK() return E.interfaceVersion > 30000 and E.interfaceVersion < 40000 end
function E.func_IsCataclysm() return E.interfaceVersion > 40000 and E.interfaceVersion < 50000 end
function E.func_IsMOP() return E.interfaceVersion > 50000 and E.interfaceVersion < 60000 end
function E.func_IsWOD() return E.interfaceVersion > 60000 and E.interfaceVersion < 70000 end
function E.func_IsLegion() return E.interfaceVersion > 70000 and E.interfaceVersion < 80000 end
function E.func_IsBFA() return E.interfaceVersion > 80000 and E.interfaceVersion < 90000 end
function E.func_IsShadowlands() return E.interfaceVersion > 90000 and E.interfaceVersion < 100000 end
function E.func_IsDragonflight() return E.interfaceVersion > 100000 and E.interfaceVersion < 110000 end
function E.func_IsTWW() return E.interfaceVersion > 110000 and E.interfaceVersion < 120000 end
function E.func_IsMidnight() return E.interfaceVersion > 120000 and E.interfaceVersion < 130000 end
function E.func_IsTLT() return E.interfaceVersion > 130000 and E.interfaceVersion < 140000 end
function E.func_IsRetail() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE end
function E.func_IsPTR() return GetCurrentRegion() >= 72 end -- 90 BETA midnight
function E.func_IsRemix() return PlayerIsTimerunning() end
function E.func_Is_WorldofWarcraft_available() return E.interfaceVersion >= 10000 end
function E.func_Is_TheBurningCrusade_available() return E.interfaceVersion >= 20000 end
function E.func_Is_WrathoftheLichKing_available() return E.interfaceVersion >= 30000 end
function E.func_Is_Cataclysm_available() return E.interfaceVersion >= 40000 end
function E.func_Is_MistsofPandaria_available() return E.interfaceVersion >= 50000 end
function E.func_Is_WarlordsofDraenor_available() return E.interfaceVersion >= 60000 end
function E.func_Is_Legion_available() return E.interfaceVersion >= 70000 end
function E.func_Is_BattleforAzeroth_available() return E.interfaceVersion >= 80000 end
function E.func_Is_Shadowlands_available() return E.interfaceVersion >= 90000 end
function E.func_Is_Dragonflight_available() return E.interfaceVersion >= 100000 end
function E.func_Is_TheWarWithin_available() return E.interfaceVersion >= 110000 end
function E.func_Is_Midnight_available() return E.interfaceVersion >= 120000 end
function E.func_Is_TheLastTitan_available() return E.interfaceVersion >= 130000 end


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

E.Config_ShowAllDifficulties = false
E.Config_DifficultyAbbreviation = true