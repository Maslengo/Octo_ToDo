local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Globals = {}
E.Octo_Globals.modules = {}
E.Octo_Globals.baseWowheadUrl = "https://%swowhead.com/%s=%s"
E.Octo_Globals.baseWowheadAzEsUrl = "https://%swowhead.com/azerite-essence/%s%s"
E.Octo_Globals.baseWowheadTradingPostActivityUrl = "https://%swowhead.com/trading-post-activity/%s%s"
E.Octo_Globals.baseArmoryUrl = "https://worldofwarcraft.com/%s/character/%s/%s"
E.Octo_Globals.baseRaiderIoUrl = "https://raider.io/characters/%s/%s/%s"
E.Octo_Globals.strategies = {}
E.Octo_Globals.altStrategies = {}
E.Octo_Globals.thursdayReset = (1514358000-10800)
E.Octo_Globals.thursdayResetDay0US = 1514300400
E.Octo_Globals.daytime = 86400
-- E.Octo_Globals.currTime = tonumber(GetServerTime())
E.Octo_Globals.curExpansionMaxLevel = 70
E.Octo_Globals.scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale()
E.Octo_Globals.curWidthCentral = 96*E.Octo_Globals.scale
E.Octo_Globals.curHeight = 20*E.Octo_Globals.scale
--E.Octo_Globals.curWidthTitle = E.Octo_Globals.curWidthCentral*2
E.Octo_Globals.curWidthTitle = 200*E.Octo_Globals.scale
E.Octo_Globals.ilvlToShow = 400
E.Octo_Globals.Addon_Height = 400
E.Octo_Globals.BGALPHA = .1
E.Octo_Globals.regions = {
	[1] = "us",
	[2] = "kr",
	[3] = "eu",
	[4] = "tw",
	[5] = "cn"
}
-- E.Octo_Globals.isElvUI = IsAddOnLoaded("ElvUI")
local _, _, _, isElvUI = GetAddOnInfo("ElvUI")
E.Octo_Globals.isElvUI = isElvUI
local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
E.Octo_Globals.isRCLootCouncil = isRCLootCouncil
local _, _, _, isWeakAuras = GetAddOnInfo("WeakAuras")
E.Octo_Globals.isWeakAuras = isWeakAuras
local _, _, _, isTomTom = GetAddOnInfo("TomTom")
E.Octo_Globals.isTomTom = isTomTom
E.Octo_Globals.bgCr = 14/255
E.Octo_Globals.bgCg = 14/255
E.Octo_Globals.bgCb = 14/255
E.Octo_Globals.bgCa = 0.8
E.Octo_Globals.slider_scale = 0.8
E.Octo_Globals.multiplier = 2 - E.Octo_Globals.slider_scale
----------------------------------------------------------------
--COLORS--------------------------------------------------------
----------------------------------------------------------------
-- E.Octo_Globals.Addon_Left_Color = "|cffD177FF"
-- E.Octo_Globals.Addon_Right_Color = "|cff63A4E0"
-- E.Octo_Globals.Blue_Color = "|cff00A3FF"
-- E.Octo_Globals.Cyan_Color = "|cff00CCFF"
-- E.Octo_Globals.LightGray_Color = "|cff909090"
-- E.Octo_Globals.Gray_Color = "|cff404040"
-- E.Octo_Globals.DarkGray_Color = "|cff202020"
-- E.Octo_Globals.Green_Color = "|cff4FFF79"
-- E.Octo_Globals.Orange_Color = "|cffFF661A"
-- E.Octo_Globals.Purple_Color = "|cffAF61FF"
-- E.Octo_Globals.Pink_Color = "|cffFFC0CB"
-- E.Octo_Globals.Brown_Color = "|cff964B00"
-- E.Octo_Globals.Red_Color = "|cffFF4C4F"
-- E.Octo_Globals.Rift_Color = "|cffBF9EFF"
-- E.Octo_Globals.White_Color = "|cffFFF7D7"
-- E.Octo_Globals.Black_Color = "|cff000000"
-- E.Octo_Globals.Yellow_Color = "|cffFFF371"
-- E.Octo_Globals.Kyrian_Color = "|cff6FA8DC"
-- E.Octo_Globals.Necrolord_Color = "|cff93C47D"
-- E.Octo_Globals.NightFae_Color = "|cffB4A7D6"
-- E.Octo_Globals.Venthyr_Color = "|cffEA9999"
-- E.Octo_Globals.WOW_Poor_Color = "|cff9D9D9D"
-- E.Octo_Globals.WOW_Common_Color = "|cffFFFFFF"
-- E.Octo_Globals.WOW_Uncommon_Color = "|cff1EFF00"
-- E.Octo_Globals.WOW_Rare_Color = "|cff0070DD"
-- E.Octo_Globals.WOW_Epic_Color = "|cffA335EE"
-- E.Octo_Globals.WOW_Legendary_Color = "|cffFF8000"
-- E.Octo_Globals.WOW_Artifact_Color = "|cffD9CC80"
-- E.Octo_Globals.WOW_Heirloom_Color = "|cff00CCFF"
-- E.Octo_Globals.WOW_WoWToken_Color = "|cff00CCFF"
-- E.Octo_Globals.Classic_Color = "|cff68CCEF"
-- E.Octo_Globals.TheBurningCrusade_Color = "|cff4FFF79"
-- E.Octo_Globals.WrathoftheLichKing_Color = "|cff00A3FF"
-- E.Octo_Globals.Cataclysm_Color = "|cffFFB300"
-- E.Octo_Globals.MistsofPandaria_Color = "|cff00FFBA"
-- E.Octo_Globals.WarlordsofDraenor_Color = "|cffC86400"
-- E.Octo_Globals.Legion_Color = "|cff1EFF00"
-- E.Octo_Globals.BattleforAzeroth_Color = "|cff6464FF"
-- E.Octo_Globals.Shadowlands_Color = "|cffC9C3AA"
-- E.Octo_Globals.Dragonflight_Color = "|cffE8E379"
----------------------------------------------------------------
E.Octo_Globals.Class_Warrior_Color = "|cffC69B6D"
E.Octo_Globals.Class_Paladin_Color = "|cffF48CBA"
E.Octo_Globals.Class_Hunter_Color = "|cffAAD372"
E.Octo_Globals.Class_Rogue_Color = "|cffFFF468"
E.Octo_Globals.Class_Priest_Color = "|cffFFFFFF"
E.Octo_Globals.Class_Shaman_Color = "|cff0070DD"
E.Octo_Globals.Class_Mage_Color = "|cff3FC7EB"
E.Octo_Globals.Class_Warlock_Color = "|cff8788EE"
E.Octo_Globals.Class_Monk_Color = "|cff00FF98"
E.Octo_Globals.Class_Druid_Color = "|cffFF7C0A"
E.Octo_Globals.Class_DemonHunter_Color = "|cffA330C9"
E.Octo_Globals.Class_DeathKnight_Color = "|cffC41E3A"
E.Octo_Globals.Class_Evoker_Color = "|cff33937F"
E.Octo_Globals.Classic_Color = "|cff68CCEF"
E.Octo_Globals.TheBurningCrusade_Color = "|cff4FFF79"
E.Octo_Globals.WrathoftheLichKing_Color = "|cff00A3FF"
E.Octo_Globals.Cataclysm_Color = "|cffFFB300"
E.Octo_Globals.MistsofPandaria_Color = "|cff00FFBA"
E.Octo_Globals.WarlordsofDraenor_Color = "|cffC86400"
E.Octo_Globals.Legion_Color = "|cff1EFF00"
E.Octo_Globals.BattleforAzeroth_Color = "|cff6464FF"
E.Octo_Globals.Shadowlands_Color = "|cffC9C3AA"
E.Octo_Globals.Dragonflight_Color = "|cffE8E379"
E.Octo_Globals.WOW_Poor_Color = "|cff9D9D9D"
E.Octo_Globals.WOW_Common_Color = "|cffFFFFFF"
E.Octo_Globals.WOW_Uncommon_Color = "|cff1EFF00"
E.Octo_Globals.WOW_Rare_Color = "|cff0070DD"
E.Octo_Globals.WOW_Epic_Color = "|cffA335EE"
E.Octo_Globals.WOW_Legendary_Color = "|cffFF8000"
E.Octo_Globals.WOW_Artifact_Color = "|cffD9CC80"
E.Octo_Globals.WOW_Heirloom_Color = "|cff00CCFF"
E.Octo_Globals.WOW_WoWToken_Color = "|cff00CCFF"
E.Octo_Globals.Kyrian_Color = "|cff6FA8DC"
E.Octo_Globals.Necrolord_Color = "|cff93C47D"
E.Octo_Globals.NightFae_Color = "|cffB4A7D6"
E.Octo_Globals.Venthyr_Color = "|cffEA9999"
E.Octo_Globals.Black_Color = "|cff000000"
E.Octo_Globals.DarkGray_Color = "|cff252525"
E.Octo_Globals.Gray_Color = "|cff505050" -- Ломает 505050 из-за NONE
E.Octo_Globals.LightGray_Color = "|cff757575"
E.Octo_Globals.White_Color = "|cffFFFFFF"
E.Octo_Globals.Addon_Left_Color = "|cffD177FF"
E.Octo_Globals.Addon_Right_Color = "|cff63A4E0"
E.Octo_Globals.Red_Color = "|cffFF4C4F"
E.Octo_Globals.Orange_Color = "|cffFF661A"
E.Octo_Globals.Darkorange_Color = "|cffFF8C00"
E.Octo_Globals.Gold_Color = "|cffFFD600"
E.Octo_Globals.Yellow_Color = "|cffFFF371" --"|cffFFFF00"
E.Octo_Globals.Greenyellow_Color = "|cffACFF2F"
E.Octo_Globals.Green_Color = "|cff4FFF79"
E.Octo_Globals.Cyan_Color = "|cff00FFFF"
E.Octo_Globals.Blue_Color = "|cff00A3FF"
E.Octo_Globals.Purple_Color = "|cffAF61FF"
E.Octo_Globals.Indigo_Color = "|cff4B0082"
E.Octo_Globals.Magenta_Color = "|cffFF00FF"
E.Octo_Globals.Pink_Color = "|cffFF69B3"
E.Octo_Globals.Skyblue_Color = "|cff87CDEB"
E.Octo_Globals.Steelblue_Color = "|cff4682B3"
E.Octo_Globals.Slategray_Color = "|cff708090"
E.Octo_Globals.Brown_Color = "|cff964B00"
----------------------------------------------------------------
E.Octo_Globals.Kyrian_r_Color = 0.44
E.Octo_Globals.Kyrian_g_Color = 0.66
E.Octo_Globals.Kyrian_b_Color = 0.86
E.Octo_Globals.Necrolord_r_Color = 0.58
E.Octo_Globals.Necrolord_g_Color = 0.77
E.Octo_Globals.Necrolord_b_Color = 0.49
E.Octo_Globals.NightFae_r_Color = 0.56
E.Octo_Globals.NightFae_g_Color = 0.49
E.Octo_Globals.NightFae_b_Color = 0.76
E.Octo_Globals.Venthyr_r_Color = 0.88
E.Octo_Globals.Venthyr_g_Color = 0.40
E.Octo_Globals.Venthyr_b_Color = 0.40
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
E.Octo_Globals.NONE = E.Octo_Globals.Gray_Color.."None|r"
E.Octo_Globals.DONE = E.Octo_Globals.Green_Color.."Done|r"
-- E.Octo_Globals.Daily = E.Octo_Globals.Yellow_Color.."D|r "
-- E.Octo_Globals.Weekly = E.Octo_Globals.Blue_Color.."W|r "
-- E.Octo_Globals.Once = E.Octo_Globals.Orange_Color.."O|r "
-- E.Octo_Globals.Daily = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"



-- E.Octo_Globals.Daily = "|TInterface\\GossipFrame\\AvailableLegendaryQuestIcon:0|t"
-- E.Octo_Globals.Weekly = "|TInterface\\GossipFrame\\DailyQuestIcon:0|t"
-- E.Octo_Globals.Once = "|TInterface\\GossipFrame\\AvailableQuestIcon:0|t"


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



E.Octo_Globals.Daily = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\GossipFrame\\tga\\DailyQuestIcon.tga")
-- E.Octo_Globals.Daily = texturefromIcon("Interface\\GossipFrame\\AvailableLegendaryQuestIcon")

E.Octo_Globals.Weekly = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\GossipFrame\\tga\\WeeklyQuestIcon.tga")
-- E.Octo_Globals.Weekly = texturefromIcon("Interface\\GossipFrame\\DailyQuestIcon")

E.Octo_Globals.Once = texturefromIcon("Interface\\Addons\\"..GlobalAddonName.."\\Media\\GossipFrame\\tga\\AvailableQuestIcon.tga")
-- E.Octo_Globals.Once = texturefromIcon("Interface\\GossipFrame\\AvailableQuestIcon")

-- console -> export "art"