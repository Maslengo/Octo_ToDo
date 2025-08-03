local GlobalAddonName, E = ...
--------------------------------------------------------------------------------

E.PromiseItem = {}
E.PromiseSpell = {}
E.PromiseQuest = {}
E.ActiveHoliday = {}
E.Holiday = {}
E.TEXTURE_CENTRAL_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CentralFrame.tga"


E.TEXTURE_REPUTATION_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Naowh.tga"


E.TEXTURE_LEFT_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\LeftFrame.tga"
E.TEXTURE_CHAR_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octo\\CharFrame.tga"
E.TEXTURE_HIGHLIGHT_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"
E.TEXTURE_HIGHLIGHT_ATLAS = "auctionhouse-ui-row-highlight"
E.TEXTURE_BLANK_PATH = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\04_Statusbars\\Blank.tga"
E.HighlightTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\BUTTON\\GlowTexture.tga"


E.LEFT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-leftbutton") and "|A:newplayertutorial-icon-mouse-leftbutton:0:0|a " or ""
E.RIGHT_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-rightbutton") and "|A:newplayertutorial-icon-mouse-rightbutton:0:0|a " or ""
E.MIDDLE_MOUSE_ICON = C_Texture.GetAtlasInfo("newplayertutorial-icon-mouse-middlebutton") and "|A:newplayertutorial-icon-mouse-middlebutton:0:0|a " or ""

E.curLocaleLang = GetLocale() or "enUS"



E.Icon_MailBox = "Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga"
E.className, E.classFilename, E.classId = UnitClass("PLAYER")
E.classColor = RAID_CLASS_COLORS[E.classFilename] and RAID_CLASS_COLORS[E.classFilename].colorStr:sub(3) or "ffffff"
-- if (r == 1 and g == 1 and b == 1) then -- "|cff9659FF"--"|cff7157FF"
-- r = 150/255
-- g = 89/255
-- b = 255/255
-- end
-- E.classColorHexCurrent = E:func_rgb2hex(r, g, b)
E.classColorHexCurrent = C_ClassColor.GetClassColor(E.classFilename):GenerateHexColorMarkup()
E.curCharName = UnitFullName("PLAYER")
E.curServer = GetRealmName()
E.Class_Warrior_Color = C_ClassColor.GetClassColor("WARRIOR"):GenerateHexColorMarkup() --"|cffC69B6D"
E.Class_Paladin_Color = C_ClassColor.GetClassColor("PALADIN"):GenerateHexColorMarkup() --"|cffF48CBA"
E.Class_Hunter_Color = C_ClassColor.GetClassColor("HUNTER"):GenerateHexColorMarkup() --"|cffAAD372"
E.Class_Rogue_Color = C_ClassColor.GetClassColor("ROGUE"):GenerateHexColorMarkup() --"|cffFFF468"
E.Class_Priest_Color = C_ClassColor.GetClassColor("PRIEST"):GenerateHexColorMarkup() --"|cffFFFFFF"
E.Class_Shaman_Color = C_ClassColor.GetClassColor("SHAMAN"):GenerateHexColorMarkup() --"|cff0070DD"
E.Class_Mage_Color = C_ClassColor.GetClassColor("MAGE"):GenerateHexColorMarkup() --"|cff3FC7EB"
E.Class_Warlock_Color = C_ClassColor.GetClassColor("WARLOCK"):GenerateHexColorMarkup() --"|cff8788EE"
E.Class_Monk_Color = C_ClassColor.GetClassColor("MONK"):GenerateHexColorMarkup() --"|cff00FF98"
E.Class_Druid_Color = C_ClassColor.GetClassColor("DRUID"):GenerateHexColorMarkup() --"|cffFF7C0A"
E.Class_DemonHunter_Color = C_ClassColor.GetClassColor("DEMONHUNTER"):GenerateHexColorMarkup() --"|cffA330C9"
E.Class_DeathKnight_Color = C_ClassColor.GetClassColor("DEATHKNIGHT"):GenerateHexColorMarkup() --"|cffC41E3A"
E.Class_Evoker_Color = C_ClassColor.GetClassColor("EVOKER"):GenerateHexColorMarkup() --"|cff33937F"

E.ddMenuButtonHeight = 20
-------------------------------------------------------------------------
E.FULL_WIDTH = 3.60


-------------------------------------------------------------------------
-- BACKDROP
-------------------------------------------------------------------------
E.backgroundColorR = .08 -- 14/255
E.backgroundColorG = .08 -- 14/255
E.backgroundColorB = .08 -- 14/255
E.backgroundColorA = .8
E.edgeSize = 1
E.edgeFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\03_Borders\\Octo.tga"
E.bgFile = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\03_Borders\\Octo.tga"

E.menuBackdrop = {
	bgFile = E.bgFile,
	edgeFile = E.edgeFile,
	edgeSize = E.edgeSize,
	insets = {left = E.edgeSize, right = E.edgeSize, top = E.edgeSize, bottom = E.edgeSize}
}

-------------------------------------------------------------------------
E.GLOBAL_FONT_SIZE = 12
E.GLOBAL_LINE_HEIGHT = E.GLOBAL_FONT_SIZE+10

E.Octo_font = "Interface\\Addons\\"..E.MainAddonName.."\\Media\\02_Fonts\\Octo.TTF"
-- E.Octo_font = "Friz Quadrata TT"
-- E.Octo_font = "Fonts\\FRIZQT___CYR.TTF"
E.OctoFont11 = CreateFont("OctoFont11")
E.OctoFont11:CopyFontObject(GameFontNormal)-- local font = GameFontHighlightSmallLeft
local fontFile, height, flags = E.OctoFont11:GetFont()
E.OctoFont11:SetFont(fontFile, E.GLOBAL_FONT_SIZE, flags)

-- GameFontNormalSmall
-- GameTooltipText

-- /dump GameFontNormalSmall:GetFonts()
-- /dump GetFontInfo(GameFontNormalSmall)

E.OctoFont22 = CreateFont("OctoFont22")
E.OctoFont22:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.OctoFont22:SetFont(E.Octo_font, 22, "OUTLINE")

E.IconTexture = C_AddOns.GetAddOnMetadata(GlobalAddonName, "IconTexture")
E.currentMaxLevel = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT)
E.currentExpansionName = _G['EXPANSION_NAME'..LE_EXPANSION_LEVEL_CURRENT] -- GetExpansionLevel()
----------------------------------------------------------------
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
E.regionID = GetCurrentRegion()
E.regionName = GetCurrentRegionName()



local function func_GetCurrentRegionName()
	if GetCurrentRegionName() == "" then
		return "PTR "..E.buildVersion
	end
	return GetCurrentRegionName()

end
E.CurrentRegionName = func_GetCurrentRegionName()




if E.regionName == "" then
	E.regionName = "US"
end
E.GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail" -- 90 xptr
E.BattleTagLocal = E.BTAG.." ("..E.GameVersion..")"
E.curGUID = UnitGUID("PLAYER")
E.GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.baseWowheadAzEsUrl = "%swowhead.com/azerite-essence/%s%s"
E.baseWowheadTradingPostActivityUrl = "%swowhead.com/trading-post-activity/%s%s"
E.baseArmoryUrl = "worldofwarcraft.blizzard.com/%s/character/%s/%s"
E.baseRaiderIoUrl = "raider.io/characters/%s/%s/%s"
E.strategies = {}
E.altStrategies = {}
E.curExpansionMaxLevel = 70
E.scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale() -- ТУТ ПЛОХО РАБОТАЕТ

E.MonitorWidth, E.MonitorHeight = GetPhysicalScreenSize()
E.Color_Quest_r = .3 -- 1
E.Color_Quest_g = .1 -- .7
E.Color_Quest_b = 0 -- 0
E.Color_Currency_r = 0 -- 0.79
E.Color_Currency_g = 0 -- 0.76
E.Color_Currency_b = .3 -- 0.67
E.Color_Crest_r = 0 -- 0
E.Color_Crest_g = .3 -- 0
E.Color_Crest_b = .3 -- 1
E.Color_Item_r = 0 -- 0
E.Color_Item_g = .3 -- 1
E.Color_Item_b = 0 -- 1
E.Color_Reputation_r = .3 -- 0
E.Color_Reputation_g = .3 -- 1
E.Color_Reputation_b = 0 -- 1
E.MainFrame_Position = -157
E.AnimationDuration = .2
E.isElvUI = select(4, C_AddOns.GetAddOnInfo("ElvUI"))
E.isRCLootCouncil = select(4, C_AddOns.GetAddOnInfo("RCLootCouncil"))
E.isWeakAuras = select(4, C_AddOns.GetAddOnInfo("WeakAuras"))
E.isTomTom = select(4, C_AddOns.GetAddOnInfo("TomTom"))
E.isPlater = select(4, C_AddOns.GetAddOnInfo("Plater"))
E.isOmniCD = select(4, C_AddOns.GetAddOnInfo("OmniCD"))
E.isOmniCC = select(4, C_AddOns.GetAddOnInfo("OmniCC"))
E.isParrot = select(4, C_AddOns.GetAddOnInfo("Parrot"))
E.backgroundColorAOverlay = .2
E.slider_scale = .8
E.multiplier = 2 - E.slider_scale
E.WorldofWarcraft_Color = "|cffD6AB7D" -- "|cff68CCEF"
E.TheBurningCrusade_Color = "|cffE43E5A" -- "|cff4FFF79"
E.WrathoftheLichKing_Color = "|cff3FC7EB" -- "|cff00A3FF"
E.Cataclysm_Color = "|cffFF7C0A" -- "|cffFFB300"
E.MistsofPandaria_Color = "|cff00EF88" -- "|cff00FFBA"
E.WarlordsofDraenor_Color = "|cffF48CBA" -- "|cffC86400"
E.Legion_Color = "|cffAAD372" -- "|cff1EFF00"
E.BattleforAzeroth_Color = "|cffFFF468" -- "|cff6464FF"
E.Shadowlands_Color = "|cff9798FE" -- "|cffC9C3AA"
E.Dragonflight_Color = "|cff53B39F" -- "|cffE8E379"
E.TheWarWithin_Color = "|cff90CCDD" -- "|cffB59377"
E.Midnight_Color = "|cff7B69FF" -- СИНИЙ
E.TheLastTitan_Color = "|cffF4C263" -- ЖЕЛТЫЙ
E.WOW_Poor_Color = "|cff9D9D9D"
E.WOW_Common_Color = "|cffFFFFFF"
E.WOW_Uncommon_Color = "|cff1EFF00"
E.WOW_Rare_Color = "|cff0070DD"
E.WOW_Epic_Color = "|cffA335EE"
E.WOW_Legendary_Color = "|cffFF8000"
E.WOW_Artifact_Color = "|cffD9CC80"
E.WOW_Heirloom_Color = "|cff00CCFF"
E.WOW_WoWToken_Color = "|cff00CCFF"
E.Kyrian_Color = "|cff6FA8DC"
E.Necrolord_Color = "|cff93C47D"
E.NightFae_Color = "|cffB4A7D6"
E.Venthyr_Color = "|cffEA9999"
E.Black_Color = "|cff000000"
E.DarkGray_Color = "|cff252525" -- "|cff303030"
E.Gray_Color = "|cff757575" -- "|cff505050"
E.LightGray_Color = "|cff909090" -- "|cff757575"
E.White_Color = "|cffFFFFFF"
E.Addon_Left_Color = "|cffD177FF"
E.Addon_Right_Color = "|cff63A4E0"
E.Red_Color = "|cffFF4C4F"
E.Orange_Color = "|cffFF661A"
E.Darkorange_Color = "|cffFF8C00"
E.Gold_Color = "|cffFFD600"
E.Yellow_Color = "|cffFFF371" --"|cffFFFF00"
E.Lime_Color = "|cffACFF2F"
E.Green_Color = "|cff4FFF79"
E.Cyan_Color = "|cff00FFFF"
E.Blue_Color = "|cff00A3FF"
E.Purple_Color = "|cffAF61FF"
E.Indigo_Color = "|cff4B0082"
E.Magenta_Color = "|cffFF00FF"
E.Pink_Color = "|cffFF69B3"
E.Skyblue_Color = "|cff87CDEB"
E.Steelblue_Color = "|cff4682B3"
E.Slategray_Color = "|cff708090"
E.Brown_Color = "|cff964B00"
E.Holiday_Color = "|cffFF8C00"
E.Event_Color = "|cffFFF371"-- "|cff4682B3" КРАСИВОЕ
E.Debug_Color = E.classColorHexCurrent -- "|cff4682B3"
E.Function_Color = "|cff87CDEB"




----------------------------------------------------------------
E.curFaction = UnitFactionGroup("PLAYER")
E.oppositeFaction = E.curFaction == "Alliance" and "Horde" or "Alliance"
E.Icon_Alliance = 255140-- E:func_texturefromIcon(255140) -- 132486
E.Icon_Horde = 255142 -- 132485
E.Icon_Kyrian = 3641395
E.Icon_Necrolord = 3641396
E.Icon_NightFae = 3641394
E.Icon_Venthyr = 3641397
E.Icon_WorldBoss = 3528312
E.Icon_Rares = 135903
E.Icon_Money = 133784

E.Horde_Color = "|cffC41E3A"
E.Alliance_Color = "|cff0070DD"
E.Neutral_Color = E.Class_Monk_Color

if E.curFaction == "Horde" then
	E.Icon_Faction = 2565244
	E.Faction_Color = E.Horde_Color
elseif E.curFaction == "Alliance" then
	E.Icon_Faction = 2565243
	E.Faction_Color = E.Alliance_Color
else
	E.Icon_Faction = 775462
	E.Faction_Color = E.Class_Monk_Color
end
----------------------------------------------------------------
E.Kyrian_r_Color = 0.44
E.Kyrian_g_Color = 0.66
E.Kyrian_b_Color = 0.86
E.Necrolord_r_Color = 0.58
E.Necrolord_g_Color = 0.77
E.Necrolord_b_Color = 0.49
E.NightFae_r_Color = 0.56
E.NightFae_g_Color = 0.49
E.NightFae_b_Color = 0.76
E.Venthyr_r_Color = 0.88
E.Venthyr_g_Color = 0.40
E.Venthyr_b_Color = 0.40
----------------------------------------------------------------
E.DONE = E.Green_Color..DONE.."|r"
E.NONE = E.Gray_Color..NONE.."|r"
E.TRUE = E.Green_Color.."true|r"
E.FALSE = E.Red_Color.."false|r"
E.NIL = E.Red_Color.."nil|r"
----------------------------------------------------------------
-- E.Icon_AccountWide = E:func_texturefromIcon(6124644) -- CreateAtlasMarkup("warbands-icon", 16, 16)
E.Icon_AccountWide = CreateAtlasMarkup("warbands-icon", 16, 16) --     interface/warbands/uiwarbandsicons.blp
E.Icon_AccountTransferable = CreateAtlasMarkup("warbands-icon", 16, 16) -- E.Red_Color.."(W)".."|r"
E.Icon_Warbands = E.Blue_Color.."(A)".."|r"
E.Icon_QuestionMark = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.Icon_Empty = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Util_Icons\\Icon_Empty"
E.Icon_LFG = "Interface\\LFGFRAME\\BattlenetWorking0"

E.OctoTable_Prefixes = {
	"Русский", -- "ru.",
	"Deutsch", -- "de.",
	"English", -- "",
	"Español", -- "es.",
	"Français", -- "fr.",
	"Italiano", -- "it.",
	"Português Brasileiro", -- "pt.",
	"Korean", -- "한국어", --"ko.",
	"Chinese" -- "简体中文", --"cn.",
}
E.OctoTable_Covenant = {
	[1] = {
		name = C_Covenants.GetCovenantData(1).name, -- "Kyrian",
		icon = 3641395,
		color = "|cff6FA8DC",
		r = 0.44,
		g = 0.66,
		b = 0.86,
	},
	[2] = {
		name = C_Covenants.GetCovenantData(2).name, -- "Venthyr",
		icon = 3641397,
		color = "|cffEA9999",
		r = 0.88,
		g = 0.40,
		b = 0.40,
	},
	[3] = {
		name = C_Covenants.GetCovenantData(3).name, -- "NightFae",
		icon = 3641394,
		color = "|cffB4A7D6",
		r = 0.56,
		g = 0.49,
		b = 0.76,
	},
	[4] = {
		name = C_Covenants.GetCovenantData(4).name, -- "Necrolord",
		icon = 3641396,
		color = "|cff93C47D",
		r = 0.58,
		g = 0.77,
		b = 0.49,
	},
}
----------------------------------------------------------------
E.listMaxSize = 30
E.DEVTEXT = "|T".. E.IconTexture ..":14:14:::64:64:4:60:4:60|t"..E.Green_Color.. "DebugInfo|r: "
E.KILLTEXT = "|T".. "Interface\\Addons\\"..E.MainAddonName.."\\Media\\ElvUI\\Facepalm.tga" ..":14:14:::64:64:4:60:4:60|t"
----------------------------------------------------------------
E.OctoTable_bytetoB64 = {
	[0] =
	"a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")",
}
--------------------------------------------------------------------------------
E.OctoTable_bytetoB64Color = {
	[0] =
	"0", "1", "2", "3", "4", "5", "6", "7", "8",
	"9", "A", "B", "C", "D", "E", "F",
}
E.OctoTable_RIO_COLORS = {
	{["score"] = 10000, ["color"] = {1, 0.5, 0}},
	{["score"] = 3975, ["color"] = {1, 0.5, 0}},
	{["score"] = 3900, ["color"] = {1, 0.49, 0.07}},
	{["score"] = 3875, ["color"] = {0.99, 0.49, 0.11}},
	{["score"] = 3850, ["color"] = {0.99, 0.48, 0.14}},
	{["score"] = 3825, ["color"] = {0.99, 0.48, 0.17}},
	{["score"] = 3805, ["color"] = {0.98, 0.47, 0.19}},
	{["score"] = 3780, ["color"] = {0.98, 0.47, 0.22}},
	{["score"] = 3755, ["color"] = {0.98, 0.46, 0.24}},
	{["score"] = 3730, ["color"] = {0.97, 0.45, 0.25}},
	{["score"] = 3705, ["color"] = {0.97, 0.45, 0.27}},
	{["score"] = 3685, ["color"] = {0.96, 0.44, 0.29}},
	{["score"] = 3660, ["color"] = {0.96, 0.44, 0.31}},
	{["score"] = 3635, ["color"] = {0.96, 0.43, 0.33}},
	{["score"] = 3610, ["color"] = {0.95, 0.42, 0.35}},
	{["score"] = 3585, ["color"] = {0.95, 0.42, 0.36}},
	{["score"] = 3565, ["color"] = {0.95, 0.41, 0.38}},
	{["score"] = 3540, ["color"] = {0.94, 0.41, 0.4}},
	{["score"] = 3515, ["color"] = {0.93, 0.4, 0.41}},
	{["score"] = 3490, ["color"] = {0.93, 0.39, 0.43}},
	{["score"] = 3465, ["color"] = {0.93, 0.39, 0.44}},
	{["score"] = 3445, ["color"] = {0.92, 0.38, 0.46}},
	{["score"] = 3420, ["color"] = {0.91, 0.38, 0.47}},
	{["score"] = 3395, ["color"] = {0.91, 0.37, 0.49}},
	{["score"] = 3370, ["color"] = {0.9, 0.36, 0.51}},
	{["score"] = 3345, ["color"] = {0.9, 0.36, 0.52}},
	{["score"] = 3325, ["color"] = {0.89, 0.35, 0.54}},
	{["score"] = 3300, ["color"] = {0.89, 0.35, 0.55}},
	{["score"] = 3275, ["color"] = {0.88, 0.34, 0.56}},
	{["score"] = 3250, ["color"] = {0.87, 0.33, 0.58}},
	{["score"] = 3225, ["color"] = {0.87, 0.33, 0.6}},
	{["score"] = 3205, ["color"] = {0.86, 0.32, 0.61}},
	{["score"] = 3180, ["color"] = {0.85, 0.32, 0.63}},
	{["score"] = 3155, ["color"] = {0.84, 0.31, 0.64}},
	{["score"] = 3130, ["color"] = {0.84, 0.31, 0.66}},
	{["score"] = 3105, ["color"] = {0.83, 0.3, 0.67}},
	{["score"] = 3085, ["color"] = {0.82, 0.29, 0.69}},
	{["score"] = 3060, ["color"] = {0.81, 0.29, 0.7}},
	{["score"] = 3035, ["color"] = {0.8, 0.28, 0.72}},
	{["score"] = 3010, ["color"] = {0.8, 0.27, 0.73}},
	{["score"] = 2985, ["color"] = {0.78, 0.27, 0.75}},
	{["score"] = 2965, ["color"] = {0.78, 0.27, 0.76}},
	{["score"] = 2940, ["color"] = {0.76, 0.26, 0.78}},
	{["score"] = 2915, ["color"] = {0.76, 0.25, 0.8}},
	{["score"] = 2890, ["color"] = {0.75, 0.25, 0.81}},
	{["score"] = 2865, ["color"] = {0.73, 0.24, 0.82}},
	{["score"] = 2845, ["color"] = {0.72, 0.24, 0.84}},
	{["score"] = 2820, ["color"] = {0.71, 0.23, 0.85}},
	{["score"] = 2795, ["color"] = {0.7, 0.23, 0.87}},
	{["score"] = 2770, ["color"] = {0.68, 0.22, 0.89}},
	{["score"] = 2745, ["color"] = {0.67, 0.22, 0.9}},
	{["score"] = 2725, ["color"] = {0.65, 0.21, 0.92}},
	{["score"] = 2700, ["color"] = {0.64, 0.21, 0.93}},
	{["score"] = 2660, ["color"] = {0.62, 0.23, 0.93}},
	{["score"] = 2635, ["color"] = {0.6, 0.25, 0.93}},
	{["score"] = 2610, ["color"] = {0.58, 0.27, 0.92}},
	{["score"] = 2585, ["color"] = {0.55, 0.29, 0.92}},
	{["score"] = 2560, ["color"] = {0.53, 0.31, 0.91}},
	{["score"] = 2540, ["color"] = {0.51, 0.32, 0.91}},
	{["score"] = 2515, ["color"] = {0.48, 0.34, 0.91}},
	{["score"] = 2490, ["color"] = {0.46, 0.35, 0.9}},
	{["score"] = 2465, ["color"] = {0.43, 0.36, 0.9}},
	{["score"] = 2440, ["color"] = {0.4, 0.37, 0.89}},
	{["score"] = 2420, ["color"] = {0.37, 0.38, 0.89}},
	{["score"] = 2395, ["color"] = {0.34, 0.4, 0.89}},
	{["score"] = 2370, ["color"] = {0.3, 0.4, 0.88}},
	{["score"] = 2345, ["color"] = {0.26, 0.42, 0.88}},
	{["score"] = 2320, ["color"] = {0.21, 0.42, 0.87}},
	{["score"] = 2300, ["color"] = {0.14, 0.43, 0.87}},
	{["score"] = 2275, ["color"] = {0, 0.44, 0.87}},
	{["score"] = 2195, ["color"] = {0.08, 0.45, 0.85}},
	{["score"] = 2170, ["color"] = {0.13, 0.46, 0.85}},
	{["score"] = 2145, ["color"] = {0.16, 0.47, 0.84}},
	{["score"] = 2120, ["color"] = {0.19, 0.48, 0.83}},
	{["score"] = 2100, ["color"] = {0.21, 0.49, 0.82}},
	{["score"] = 2075, ["color"] = {0.23, 0.5, 0.81}},
	{["score"] = 2050, ["color"] = {0.24, 0.51, 0.8}},
	{["score"] = 2025, ["color"] = {0.26, 0.51, 0.78}},
	{["score"] = 2000, ["color"] = {0.27, 0.53, 0.78}},
	{["score"] = 1980, ["color"] = {0.28, 0.53, 0.76}},
	{["score"] = 1955, ["color"] = {0.29, 0.55, 0.76}},
	{["score"] = 1930, ["color"] = {0.3, 0.55, 0.75}},
	{["score"] = 1905, ["color"] = {0.31, 0.56, 0.73}},
	{["score"] = 1880, ["color"] = {0.32, 0.57, 0.73}},
	{["score"] = 1860, ["color"] = {0.33, 0.58, 0.71}},
	{["score"] = 1835, ["color"] = {0.33, 0.59, 0.7}},
	{["score"] = 1810, ["color"] = {0.34, 0.6, 0.69}},
	{["score"] = 1785, ["color"] = {0.35, 0.61, 0.68}},
	{["score"] = 1760, ["color"] = {0.35, 0.62, 0.67}},
	{["score"] = 1740, ["color"] = {0.36, 0.63, 0.66}},
	{["score"] = 1715, ["color"] = {0.36, 0.64, 0.65}},
	{["score"] = 1690, ["color"] = {0.36, 0.65, 0.64}},
	{["score"] = 1665, ["color"] = {0.36, 0.66, 0.63}},
	{["score"] = 1640, ["color"] = {0.37, 0.67, 0.62}},
	{["score"] = 1620, ["color"] = {0.37, 0.68, 0.61}},
	{["score"] = 1595, ["color"] = {0.37, 0.69, 0.6}},
	{["score"] = 1570, ["color"] = {0.37, 0.7, 0.58}},
	{["score"] = 1545, ["color"] = {0.37, 0.71, 0.57}},
	{["score"] = 1520, ["color"] = {0.37, 0.72, 0.56}},
	{["score"] = 1500, ["color"] = {0.37, 0.73, 0.55}},
	{["score"] = 1475, ["color"] = {0.37, 0.74, 0.54}},
	{["score"] = 1450, ["color"] = {0.37, 0.75, 0.53}},
	{["score"] = 1425, ["color"] = {0.37, 0.76, 0.51}},
	{["score"] = 1400, ["color"] = {0.37, 0.77, 0.5}},
	{["score"] = 1380, ["color"] = {0.37, 0.78, 0.49}},
	{["score"] = 1355, ["color"] = {0.36, 0.79, 0.47}},
	{["score"] = 1330, ["color"] = {0.36, 0.8, 0.46}},
	{["score"] = 1305, ["color"] = {0.36, 0.82, 0.45}},
	{["score"] = 1280, ["color"] = {0.35, 0.82, 0.44}},
	{["score"] = 1260, ["color"] = {0.35, 0.84, 0.42}},
	{["score"] = 1235, ["color"] = {0.34, 0.84, 0.41}},
	{["score"] = 1210, ["color"] = {0.34, 0.85, 0.39}},
	{["score"] = 1185, ["color"] = {0.33, 0.87, 0.38}},
	{["score"] = 1160, ["color"] = {0.32, 0.87, 0.36}},
	{["score"] = 1140, ["color"] = {0.31, 0.89, 0.35}},
	{["score"] = 1115, ["color"] = {0.31, 0.9, 0.33}},
	{["score"] = 1090, ["color"] = {0.29, 0.91, 0.31}},
	{["score"] = 1065, ["color"] = {0.28, 0.92, 0.29}},
	{["score"] = 1040, ["color"] = {0.27, 0.93, 0.27}},
	{["score"] = 1020, ["color"] = {0.26, 0.94, 0.25}},
	{["score"] = 995, ["color"] = {0.24, 0.95, 0.23}},
	{["score"] = 970, ["color"] = {0.22, 0.96, 0.2}},
	{["score"] = 945, ["color"] = {0.2, 0.97, 0.17}},
	{["score"] = 920, ["color"] = {0.18, 0.98, 0.14}},
	{["score"] = 900, ["color"] = {0.15, 0.99, 0.09}},
	{["score"] = 875, ["color"] = {0.12, 1, 0}},
	{["score"] = 850, ["color"] = {0.22, 1, 0.13}},
	{["score"] = 825, ["color"] = {0.29, 1, 0.19}},
	{["score"] = 800, ["color"] = {0.35, 1, 0.24}},
	{["score"] = 775, ["color"] = {0.4, 1, 0.29}},
	{["score"] = 750, ["color"] = {0.44, 1, 0.33}},
	{["score"] = 725, ["color"] = {0.47, 1, 0.36}},
	{["score"] = 700, ["color"] = {0.51, 1, 0.4}},
	{["score"] = 675, ["color"] = {0.55, 1, 0.44}},
	{["score"] = 650, ["color"] = {0.58, 1, 0.47}},
	{["score"] = 625, ["color"] = {0.6, 1, 0.5}},
	{["score"] = 600, ["color"] = {0.64, 1, 0.53}},
	{["score"] = 575, ["color"] = {0.66, 1, 0.56}},
	{["score"] = 550, ["color"] = {0.69, 1, 0.59}},
	{["score"] = 525, ["color"] = {0.71, 1, 0.62}},
	{["score"] = 500, ["color"] = {0.74, 1, 0.65}},
	{["score"] = 475, ["color"] = {0.76, 1, 0.68}},
	{["score"] = 450, ["color"] = {0.79, 1, 0.71}},
	{["score"] = 425, ["color"] = {0.81, 1, 0.74}},
	{["score"] = 400, ["color"] = {0.83, 1, 0.77}},
	{["score"] = 375, ["color"] = {0.85, 1, 0.8}},
	{["score"] = 350, ["color"] = {0.88, 1, 0.83}},
	{["score"] = 325, ["color"] = {0.9, 1, 0.85}},
	{["score"] = 300, ["color"] = {0.92, 1, 0.88}},
	{["score"] = 275, ["color"] = {0.94, 1, 0.91}},
	{["score"] = 250, ["color"] = {0.96, 1, 0.94}},
	{["score"] = 225, ["color"] = {0.98, 1, 0.97}},
	{["score"] = 200, ["color"] = {1, 1, 1}},
}












