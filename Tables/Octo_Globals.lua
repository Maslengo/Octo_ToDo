local GlobalAddonName, E = ...
print (GlobalAddonName)
local LibOctopussy = LibStub("LibOctopussy-1.0")
E.AddonTitle = LibOctopussy:GetAddOnMetadata(GlobalAddonName, "Title")
E.AddonNotes = LibOctopussy:GetAddOnMetadata(GlobalAddonName, "Notes")
E.AddonAuthor = LibOctopussy:GetAddOnMetadata(GlobalAddonName, "Author")
E.AddonVersion = LibOctopussy:GetAddOnMetadata(GlobalAddonName, "Version")
----------------------------------------------------------------
print (E.AddonVersion)
E.OctoTable_Empty = {}
E.Modules = {}
E.Timers = {}
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower

WOW_PROJECT_MAINLINE = WOW_PROJECT_MAINLINE or 1 -- RETAIL
WOW_PROJECT_CLASSIC = WOW_PROJECT_CLASSIC or 2 -- CLASSIC
WOW_PROJECT_BURNING_CRUSADE_CLASSIC = WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5 -- BURNING CRUSADE
WOW_PROJECT_WRATH_CLASSIC = WOW_PROJECT_WRATH_CLASSIC or 11 -- WRATH OF THE LICH KING
WOW_PROJECT_CATACLYSM_CLASSIC = WOW_PROJECT_CATACLYSM_CLASSIC or 14 -- CATACLYSM
WOW_PROJECT_ID = WOW_PROJECT_ID or WOW_PROJECT_MAINLINE


function IsRetail()
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

function IsClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

function IsBC()
	return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
end

function IsWRATH()
	return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
end

function IsCata()
	return WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
end

print (
	"IsRetail:"..tostringall(IsRetail()),
	"IsClassic:"..tostringall(IsClassic()),
	"IsBC:"..tostringall(IsBC()),
	"IsWRATH:"..tostringall(IsWRATH()),
	"IsCata:"..tostringall(IsCata())

	)

E.AddonTexture_1 = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_1.tga"
E.AddonTexture_2 = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_2.tga"
E.AddonTexture_3 = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_3.tga"
E.AddonTexture_4 = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_4.tga"
E.AddonTexture_5 = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_5.tga"
E.currentMaxLevel = 80
----------------------------------------------------------------
local function texturefromIcon(self, size)
	local show = true -- TYT
	if show == true then
		if not size then
			size = 14
		end
		if not self or self == 0 then
			self = 134400
		end
		return "|T"..self..":"..size..":"..size..":::64:64:4:60:4:60|t"
	else
		return ""
	end
end
----------------------------------------------------------------
local function func_hex2rgb(self)
	self = self:gsub("|cff", "")
	return tonumber("0x"..self:sub(1, 2)), tonumber("0x"..self:sub(3, 4)), tonumber("0x"..self:sub(5, 6))
end
--------------------------------------------------------------------------------
if IsRetail() then
	E.baseWowheadUrl = "https://wowhead.com/%s%s=%s"
end
if IsClassic() then
	E.baseWowheadUrl = "https://wowhead.com/classic/%s=%s%s"
end
if IsCata() then
	E.baseWowheadUrl = "https://wowhead.com/cata/%s=%s%s"
end
E.baseWowheadAzEsUrl = "https://%swowhead.com/azerite-essence/%s%s"
E.baseWowheadTradingPostActivityUrl = "https://%swowhead.com/trading-post-activity/%s%s"
E.baseArmoryUrl = "https://worldofwarcraft.blizzard.com/%s/character/%s/%s"
E.baseRaiderIoUrl = "https://raider.io/characters/%s/%s/%s"
E.strategies = {}
E.altStrategies = {}
E.thursdayReset = (1514358000-10800)
E.thursdayResetDay0US = 1514300400
E.daytime = 86400
-- E.currTime = tonumber(GetServerTime())
E.curExpansionMaxLevel = 70
E.scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale()
E.curWidthCentral = 96*E.scale
E.curHeight = 20*E.scale
--E.curWidthTitle = E.curWidthCentral*2
E.curWidthTitle = 200*E.scale
E.curWidthTitleAchievement = E.curWidthTitle
E.ilvlToShow = 400
E.Addon_Height = 400
E.BGALPHA = .1
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
E.regions = {
	[1] = "us",
	[2] = "kr",
	[3] = "eu",
	[4] = "tw",
	[5] = "cn"
}
-- E.isElvUI = IsAddOnLoaded("ElvUI")
local _, _, _, isElvUI = LibOctopussy:GetAddOnInfo("ElvUI")
E.isElvUI = isElvUI
local _, _, _, isRCLootCouncil = LibOctopussy:GetAddOnInfo("RCLootCouncil")
E.isRCLootCouncil = isRCLootCouncil
local _, _, _, isWeakAuras = LibOctopussy:GetAddOnInfo("WeakAuras")
E.isWeakAuras = isWeakAuras
local _, _, _, isTomTom = LibOctopussy:GetAddOnInfo("TomTom")
E.isTomTom = isTomTom
E.bgCr = 14/255
E.bgCg = 14/255
E.bgCb = 14/255
E.bgCa = 0.8
E.slider_scale = 0.8
E.multiplier = 2 - E.slider_scale
----------------------------------------------------------------
--COLORS--------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
E.Class_Warrior_Color = "|cffC69B6D"
E.Class_Paladin_Color = "|cffF48CBA"
E.Class_Hunter_Color = "|cffAAD372"
E.Class_Rogue_Color = "|cffFFF468"
E.Class_Priest_Color = "|cffFFFFFF"
E.Class_Shaman_Color = "|cff0070DD"
E.Class_Mage_Color = "|cff3FC7EB"
E.Class_Warlock_Color = "|cff8788EE"
E.Class_Monk_Color = "|cff00FF98"
E.Class_Druid_Color = "|cffFF7C0A"
E.Class_DemonHunter_Color = "|cffA330C9"
E.Class_DeathKnight_Color = "|cffC41E3A"
E.Class_Evoker_Color = "|cff33937F"
E.Classic_Color = "|cff68CCEF"
E.TheBurningCrusade_Color = "|cff4FFF79"
E.WrathoftheLichKing_Color = "|cff00A3FF"
E.Cataclysm_Color = "|cffFFB300"
E.MistsofPandaria_Color = "|cff00FFBA"
E.WarlordsofDraenor_Color = "|cffC86400"
E.Legion_Color = "|cff1EFF00"
E.BattleforAzeroth_Color = "|cff6464FF"
E.Shadowlands_Color = "|cffC9C3AA"
E.Dragonflight_Color = "|cffE8E379"
E.TheWarWithin_Color = "|cffB59377"
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
E.DarkGray_Color = "|cff252525"
E.Gray_Color = "|cff505050"
E.LightGray_Color = "|cff757575"
E.White_Color = "|cffFFFFFF"
E.Addon_Left_Color = "|cffD177FF"
E.Addon_Right_Color = "|cff63A4E0"
E.Red_Color = "|cffFF4C4F"
E.Orange_Color = "|cffFF661A"
E.Darkorange_Color = "|cffFF8C00"
E.Gold_Color = "|cffFFD600"
E.Yellow_Color = "|cffFFF371" --"|cffFFFF00"
E.Greenyellow_Color = "|cffACFF2F"
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
-- local RAID_CLASS_COLORS = RAID_CLASS_COLORS
-- local FONTEND = FONT_COLOR_CODE_CLOSE
-- local GOLDFONT = NORMAL_FONT_COLOR_CODE
-- local YELLOWFONT = LIGHTYELLOW_FONT_COLOR_CODE
-- local REDFONT = RED_FONT_COLOR_CODE
-- local GREENFONT = GREEN_FONT_COLOR_CODE
-- local WHITEFONT = HIGHLIGHT_FONT_COLOR_CODE
-- local GRAYFONT = GRAY_FONT_COLOR_CODE
-- local GRAY_COLOR = { 0.5, 0.5, 0.5, 1 }
-- local INSTANCE_SAVED, TRANSFER_ABORT_TOO_MANY_INSTANCES, NO_RAID_INSTANCES_SAVED = INSTANCE_SAVED, TRANSFER_ABORT_TOO_MANY_INSTANCES, NO_RAID_INSTANCES_SAVED
-- E.Daily = E.Yellow_Color.."D|r "
-- E.Weekly = E.Blue_Color.."W|r "
-- E.Once = E.Orange_Color.."O|r "
-- E.Daily = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"
-- E.Daily = "|TInterface\\GossipFrame\\AvailableLegendaryQuestIcon:0|t"
-- E.Weekly = "|TInterface\\GossipFrame\\DailyQuestIcon:0|t"
-- E.Once = "|TInterface\\GossipFrame\\AvailableQuestIcon:0|t"
E.Once = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\QuestIcon_Once.tga")
-- E.Once = texturefromIcon("Interface\\GossipFrame\\AvailableQuestIcon")
-- E.Daily = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\QuestIcon_Daily.tga")
E.Daily = "|A:Recurringavailablequesticon:14:14:0:0|a"
-- E.Daily = texturefromIcon("Interface\\GossipFrame\\AvailableLegendaryQuestIcon")
E.Weekly = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\QuestIcon_Weekly.tga")
-- E.Weekly = texturefromIcon("Interface\\GossipFrame\\DailyQuestIcon")
-- console -> export "art"
function func_texturefromIcon(iconID, iconSize, isShown)
	if isShown == nil then isShown = true end
	if iconSize == nil then iconSize = 14 end
	if iconID == nil then iconID = 134400 end
	local vivod
	if isShown == true then
		vivod = "|T".. iconID ..":"..iconSize..":"..iconSize..":::64:64:4:60:4:60|t"
	else
		vivod = ""
	end
	return vivod
end
E.Icon_Alliance = func_texturefromIcon(255140) -- 132486
E.Icon_Horde = func_texturefromIcon(255142) -- 132485
E.Icon_Unknown = func_texturefromIcon(134400)
E.Icon_Kyrian = func_texturefromIcon(3257748)
E.Icon_Necrolord = func_texturefromIcon(3257749)
E.Icon_NightFae = func_texturefromIcon(3257750)
E.Icon_Venthyr = func_texturefromIcon(3257751)
E.Icon_WorldBoss = func_texturefromIcon(3528312)
E.Icon_Rares = func_texturefromIcon(135903)
E.Icon_Money = func_texturefromIcon(133784, 14)
E.Icon_MailBox = func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga")
E.AccountWide = E.Blue_Color.."(A)".."|r"
-- E.Icon_AccountWide = func_texturefromIcon(1120721)
E.AccountTransferable = E.Red_Color.."(T)".."|r"
-- E.Icon_AccountTransferable = func_texturefromIcon(6124644)
E.Icon_Achievement = func_texturefromIcon(236544)
