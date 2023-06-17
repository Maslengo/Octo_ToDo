local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
local Octo_REPUTATION_DEV_text = false
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
-- суббота 23:00
--E.modules = {}
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local Button = nil
local CF = nil
local Char_Frame = nil
local EventFrame = nil
local Main_Frame = nil
local UPGRADERANKS_Frame = nil
local className, classFilename, classId = UnitClass("PLAYER")
local Kyri_Color = "|cff6fa8dc"
local Necr_Color = "|cff93c47d"
local NFae_Color = "|cffb4a7d6"
local Vent_Color = "|cffea9999"
local Cyan_Color = "|cff00ccff"
local Rift_Color = "|cffbf9eff"
local Gray_Color = "|cff404040"
local Addon_Color = "|cff4FFF79"--"|cff00FF00"
local White_Color = "|cffFFF7D7"
local Blue_Color = "|cff00A3FF"
local Red_Color = "|cffFF4C4F"
local Green_Color = "|cff4FFF79"
local Yellow_Color = "|cffFFF371"
local Purple_Color = "|cffAF61FF"
local Orange_Color = "|cffFF661A"
local Kyri_Color_r, Kyri_Color_g, Kyri_Color_b = 0.44, 0.66, 0.86
local Necr_Color_r, Necr_Color_g, Necr_Color_b = 0.58, 0.77, 0.49
local NFae_Color_r, NFae_Color_g, NFae_Color_b = 0.56, 0.49, 0.76
local Vent_Color_r, Vent_Color_g, Vent_Color_b = 0.88, 0.40, 0.40
local grayR,grayG,grayB,grayA = 0.5,0.5,0.5,1
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
--local curWidth = Octo_ToDo_DragonflyVars.config.Addon_curWidth*scale or 100*scale
--print (Octo_ToDo_DragonflyVars.config.Addon_curWidth)
local curWidth = 96*scale
local curHeight = 20*scale -- высота 20 24
local curWidthTitle = curWidth*2
local curFontTTF, curFontSize, curFontOutline = [[Interface\Addons\]]..GlobalAddonName..[[\Media\font\01 Octo.TTF]], 11, "OUTLINE"
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalMoney = 0
local TotalMoneyAllServer = 0
local TotalKills = 0
local curMoney = 0
local thursdayReset = (1514358000-10800) --https://wowreset.com/ 14-3=11(ТСК) --thursdayResetDay0EU
local thursdayResetDay0US = 1514300400
local daytime = 86400 -- 60 * 60 * 24 --60 сек на 60 мин на 24 ч
local NONE = Gray_Color.."None|r"
local DONE = Addon_Color.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8 --0.1, 0.1, 0.1, 1
local edgeFile = [[Interface\Buttons\WHITE8X8]]
local bgFile = [[Interface\Buttons\WHITE8X8]]
local IconTexture = [[Interface\Addons\]]..GlobalAddonName..[[\Media\AddonTexture.tga]]
local PlayCustomSound = false
-- OptionsFrame.image = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalGlobalAddonName.."\\media\\OptionLogo2"):Point("TOPLEFT", 15, 5):Size(140, 140)
-- OptionsFrame_title = ELib:Texture(OptionsFrame, "Interface\\AddOns\\"..GlobalGlobalAddonName.."\\media\\logoname2"):Point("LEFT", OptionsFrame.image, "RIGHT", 15, -5):Size(512*0.7, 128*0.7)
local function TableConcat(t1,t2)
	for i=1,#t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end
local bytetoB64 = {
	[0]="a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")"
}
function GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
local Octo_Table_itemID_Cataloged_Research = {
	{itemiD = 186685, count = 1},
	{itemiD = 187322, count = 8},
	{itemiD = 187457, count = 8},
	{itemiD = 187324, count = 8},
	{itemiD = 187323, count = 8},
	{itemiD = 187460, count = 8},
	{itemiD = 187458, count = 8},
	{itemiD = 187459, count = 8},
	{itemiD = 187465, count = 48},
	{itemiD = 187327, count = 48},
	{itemiD = 187463, count = 48},
	{itemiD = 187325, count = 48},
	{itemiD = 187325, count = 48},
	{itemiD = 187326, count = 48},
	{itemiD = 187462, count = 48},
	{itemiD = 187478, count = 48},
	{itemiD = 187336, count = 100},
	{itemiD = 187466, count = 100},
	{itemiD = 187332, count = 100},
	{itemiD = 187328, count = 100},
	{itemiD = 187334, count = 100},
	{itemiD = 187330, count = 150},
	{itemiD = 187329, count = 150},
	{itemiD = 187467, count = 150},
	{itemiD = 187331, count = 150},
	{itemiD = 187311, count = 300},
	{itemiD = 187333, count = 300},
	{itemiD = 187350, count = 300},
}
local Octo_Table_itemID_ALL = {
	24915,24916,24917,24918,24919,49040,50274,51316,51317,51318,51319,51320,51321,52200,52201,52251,52252,52253,83078,92426,92441,92471,122284,122338,122339,122340,122341,128353,129940,129941,129942,129943,129944,129945,129946,129947,129948,129949,129950,129951,129954,129955,133150,133151,133152,133154,133159,133160,137642,138486,138488,138727,138728,138729,141605,141652,143935,143936,143937,143938,143939,143940,143941,143942,143943,143944,143945,143946,143947,151614,151615,166751,167731,167732,167862,167924,167925,167926,167927,167928,167929,167930,167932,168017,168018,180817,183616,185834,187997,187998,188152,189765,190189,190453,190454,190455,190456,191251,191264,191784,191915,192055,192130,192131,192132,193201,193891,193897,193898,193899,193900,193901,193902,193903,193904,193905,193907,193909,193910,193913,194039,194040,194041,194054,194055,194061,194062,194063,194064,194066,194067,194068,194072,194076,194077,194078,194079,194080,194081,194337,194697,194698,194699,194700,194702,194703,194704,194708,197921,198046,198395,198438,198454,198510,198599,198606,198607,198608,198609,198610,198611,198612,198613,198656,198658,198659,198660,198662,198663,198664,198667,198669,198670,198680,198682,198683,198684,198685,198686,198687,198690,198692,198693,198696,198697,198699,198702,198703,198704,198710,198711,198712,198789,198837,198841,198863,198864,198865,198866,198867,198868,198869,198963,198964,198965,198966,198967,198968,198969,198970,198971,198972,198973,198974,198975,198976,198977,198978,199115,199122,199128,199192,199197,199472,199473,199474,199475,199906,200069,200070,200071,200072,200073,200093,200095,200224,200285,200287,200288,200289,200300,200443,200447,200449,200450,200452,200453,200454,200455,200468,200513,200515,200516,200609,200610,200611,200652,200677,200678,200686,200764,200811,200846,200972,200973,200974,200975,200976,200977,200978,200979,200980,200981,200982,201003,201004,201005,201006,201007,201008,201009,201010,201011,201012,201013,201014,201015,201016,201017,201018,201019,201020,201023,201250,201268,201269,201270,201271,201272,201273,201274,201275,201276,201277,201278,201279,201280,201281,201282,201283,201284,201285,201286,201287,201288,201289,201300,201301,201326,201352,201411,201412,201439,201462,201470,201471,201700,201705,201706,201708,201709,201710,201711,201712,201713,201714,201715,201716,201717,201728,201755,201756,201781,201782,201817,201836,201921,201922,201923,201924,201991,202011,202014,202016,202017,202039,202052,202079,202080,202091,202092,202093,202094,202097,202098,202142,202152,202171,202172,202173,202196,202371,202667,202668,202669,202670,202854,202870,202871,202872,203217,203220,203222,203224,203430,203476,203611,203612,203613,203614,203615,203616,203617,203618,203619,203620,203622,203623,203626,203627,203628,203629,203630,203631,203632,203633,203634,203635,203636,203637,203638,203639,203640,203641,203642,203643,203644,203645,203646,203647,203648,203649,203650,203681,203683,203699,203700,203702,203710,204075,204076,204077,204078,204180,204186,204187,204188,204189,204190,204191,204193,204194,204195,204196,204215,204217,204222,204224,204225,204226,204227,204228,204229,204230,204231,204232,204233,204276,204352,204359,204378,204379,204380,204381,204383,204403,204440,204464,204469,204470,204471,204475,204558,204559,204560,204573,204574,204575,204576,204577,204578,204579,204681,204682,204697,204715,204717,204721,204722,204723,204724,204725,204726,204727,204843,204850,204853,204855,204985,204986,204987,204988,204990,204999,205001,205188,205211,205212,205213,205214,205216,205219,205225,205249,205250,205288,205347,205367,205423,205878,205903,205982,205984,205986,205987,205988,205989,205999,206006,206019,206025,206028,206030,206031,206034,206035,206037,206139,206140,206141,206142,206143,206144,206366,
}
local Octo_Table_QuestID = {
	13183,24545,24547,24548,24549,24743,24748,24749,24756,24757,32295,32307,32309,32310,32317,32324,32325,36614,40168,40173,40786,40787,45563,47148,55498,55499,55509,55511,56337,56339,64367,64710,65143,65282,66042,66133,66419,66860,66861,66862,66863,66864,66865,66866,66867,66868,66870,66871,66873,66874,66875,71026,72166,72167,72168,72169,72170,72171,72646,72647,72648,72649,72719,72720,72721,72722,72723,72724,72725,72726,72727,72728,72810,74378,74568,74569,74570,74771,74775,74871,74905,75234,75239,75390,75393,75397,75459,75497,75506,75516,75517,75619,75620,75621,75622,75665,75694,75887,75888,75996,76014,76015,76016,76027,76081,76084,76122,13183,24545,24547,24548,24549,24743,24748,24749,24756,24757,32295,32307,32309,32310,32317,32324,32325,36614,40168,40173,40786,40787,45563,47148,55498,55499,55509,55511,56337,56339,60242,60243,60244,60245,60246,60247,60248,60249,60250,60251,60252,60253,60254,60255,60256,60257,60646,60762,60775,61075,61079,61088,61103,61104,61765,61813,61814,61815,61816,61981,61982,61983,61984,62214,62234,62284,62285,62286,62287,62288,62631,62632,62633,62634,62635,62636,62637,62638,62639,62640,62858,62859,62860,62861,62862,62863,62864,62865,62866,62867,62868,62869,63543,63815,63816,63817,63818,63822,63823,63824,63825,63826,63830,63949,63993,63995,63996,63997,63998,63999,64021,64027,64044,64045,64055,64056,64057,64058,64059,64060,64061,64152,64209,64232,64233,64243,64245,64246,64247,64251,64256,64257,64258,64263,64265,64269,64270,64272,64273,64276,64278,64283,64284,64285,64291,64300,64303,64307,64313,64316,64317,64318,64320,64338,64339,64341,64342,64343,64344,64347,64348,64349,64351,64354,64355,64356,64357,64358,64359,64360,64361,64362,64363,64364,64366,64367,64428,64433,64434,64435,64436,64439,64440,64442,64455,64456,64457,64470,64471,64472,64522,64531,64564,64565,64575,64709,64710,64747,64748,64749,64750,64751,64752,64753,64754,64755,64756,64757,64828,65143,65266,65282,66042,66133,66419,66860,66861,66862,66863,66864,66865,66866,66867,66868,66870,66871,66873,66874,66875,71026,72166,72167,72168,72169,72170,72171,72646,72647,72648,72649,72719,72720,72721,72722,72723,72724,72725,72726,72727,72728,72810,74300,74305,74306,74307,74321,74322,74325,74328,74329,74330,74331,74332,74333,74336,74337,74338,74339,74341,74342,74343,74344,74345,74346,74347,74349,74352,74378,74568,74569,74570,74771,74775,74871,74905,75156,75222,75234,75239,75267,75269,75271,75274,75276,75285,75292,75296,75298,75314,75322,75326,75334,75336,75338,75340,75342,75349,75353,75358,75360,75364,75366,75370,75390,75393,75397,75441,75450,75451,75454,75455,75459,75461,75471,75476,75478,75494,75497,75506,75516,75517,75576,75611,75612,75619,75620,75621,75622,75624,75664,75665,75694,75705,75887,75888,75996,76014,76015,76016,76027,76081,76084,76122,
}
local Octo_Table_itemID_Reputation = {
	192055,200443,200093,200447,199906,200450,201411,201412,200071,200449,201470,201471,206006,202854,
}
local Octo_Table_currencyID_ALL = {
}
local function CurrencyTinsert()
	local table = {}
	for i = 1, 3000 do
		table[i] = C_CurrencyInfo.GetCurrencyInfo(i)
	end
	for k, v in pairs(table) do
		if k ~= nil and v ~= nil and k ~= 0 then
			tinsert(Octo_Table_currencyID_ALL, k)
		end
	end
end
local Octo_Table_SpellID = {
	--Рыбалка
	366253, -- Рыбная ловля дракьньих осттавов
	--Полёты
	33388,
	33391,
	34090,
	90265,
}
local Octo_Table_reputation = {
	2507, -- Драконья экспедиция
	2503, -- Кентавры Маруук
	2511, -- Искарские клыкарры
	2510, -- Союз Вальдраккена
	2564, -- Лоаммские ниффы
	2517, -- Гневион
	2518, -- Сабеллиан
	2463, -- Чесночник (BUGGED)
	-- 2526, -- Фурболги из клана Зимней Шкуры
	-- 2550, -- Кобальтовая ассамблея
	-- 1072, -- [DNT] AC Major Faction Child Renown Test
	-- 2506, -- Dragonfly
	-- 2523, -- Темные Когти (Орда)
	-- 2524, -- Обсидиановые Хранители (Альянс)
	-- 2544, -- Консорциум ремесленников – филиал на Драконьих островах
	-- 2504, -- Кентавры Маруук (идеал)
	-- 2508, -- Драконья экспедиция (идеал)
	-- 2509, -- Клан Шикаар
	-- 2512, -- Клан Айлааг
	-- 2513, -- Клан Он'ир
	-- 2520, -- Клан Нокхуд
	-- 2521, -- Клан Нокуд (идеал)
	-- 2522, -- Клан Тирай
	-- 2542, -- Клан Укхел
	-- 2551, -- Искарские клыкарры (идеал)
	-- 2552, -- Союз Вальдраккена (идеал)
	-- 2554, -- Клан Тогус
	-- 2555, -- Клан Кейган
}
local function ReputationTinsert()
	local tableREP = {}
	for i = 1, GetNumFactions() do
		local factionID = select(14, GetFactionInfo(i))
		tableREP = {factionID}
		for k, v in ipairs (tableREP) do
			tinsert(Octo_Table_reputation, v)
		end
	end
end
local function func_texturefromIcon(textureID)
	return "|T"..textureID..":16:16:::64:64:4:60:4:60|t"
end
local function func_questName(questID)
	local title = C_QuestLog.GetTitleForQuestID(questID) or "notitle"
	return title
end
local function func_reputationName(factionID)
	local name = GetFactionInfoByID(factionID)
	if not name then
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID or 0)
		name = reputationInfo.name or "NONAME"
	end
	local color = "|cffFFFFFF"
	local r = "|r"
	if factionID == 1168 then color = "|cff909090" end
	return color..name..r
end
local function func_itemName(itemID)
	local itemName, _, itemQuality = GetItemInfo(itemID)
	local name = ""
	if itemQuality then
		local r, g, b = GetItemQualityColor(itemQuality)
		local color = CreateColor(r, g, b, 1)
		local name = color:WrapTextInColorCode(itemName)
		return name
	end
	return name
end
local function func_itemName_NOCOLOR(itemID)
	local itemName, _, itemQuality = GetItemInfo(itemID)
	return itemName
end
local function func_itemTexture(itemID)
	local itemTexture = select(10, GetItemInfo(itemID)) or 134400 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	if itemTexture then
		return "|T"..itemTexture..":16:16:::64:64:4:60:4:60|t"
	end
	return "|T134400:16:16:::64:64:4:60:4:60|t"
end
local function func_currencyName(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		local name = info.name
		local iconFileID = info.iconFileID
		local quality = info.quality
		local r, g, b = GetItemQualityColor(quality)
		local color = CreateColor(r, g, b, 1)
		local currencyName = color:WrapTextInColorCode(name)
		return currencyName
	end
end
local function func_currencyicon(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		iconFileID = info.iconFileID or 134400 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	end
	return "|T"..iconFileID..":16:16:::64:64:4:60:4:60|t"
end
local function func_currencyquantity(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		quantity = info.quantity or 0 --https://www.wowhead.com/ru/icon=134400/inv-misc-questionmark
	end
	return quantity
end
local function func_spellName(spellID)
	local name = GetSpellInfo(spellID)
	return name
end
local function Central_Frame_Mouse_OnEnter(self)
	local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	-----------------------------------
	if not self.tooltip then return end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -10)
	GameTooltip:AddLine(" ")
	for _, v in pairs(self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(self)
	local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	-----------------------------------
	GameTooltip:Hide()
end
local function SecondsToClock(seconds)
	local seconds = tonumber(seconds)
	if seconds <= 0 or seconds == nil then
		return "0:00"
	elseif seconds >= 3600 then
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		return hours.."h "..mins.."m"
	elseif seconds >= 600 then
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		return mins.."m"
	else
		hours = string.format("%01.f", math.floor(seconds/3600))
		mins = string.format("%01.f", math.floor(seconds/60 - (hours*60)))
		return mins.."m"
	end
end
local spawns = {
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 85, name="(Оргриммар)"},
}
local spawns2 = {
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2025, name="(Тальдразус)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2112, name="(Вальдракен)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2022, name="(Берега Пробуждения)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2023, name="(Равнины Он'ары)"},
	{mapId = 85, name="(Оргриммар)"},
	{mapId = 2024, name="(Лазурный Простор)"},
	{mapId = 84, name="(Штормград)"},
	{mapId = 2025, name="(Тальдразус)"},
}
-- function TreasureGoblinTimer()
-- local offset = 1675076400+9 -- = time({year=2023,month=1,day=30,hour=12})
-- local interval = 30*60
-- local interval2 = 1500
-- local uptime = GetTime()
-- if (last or 0) < uptime - 1 then
-- last = uptime
-- local n = #spawns
-- local current = (time() - offset) / interval
-- local remainder = (math.floor(current) - current + 1) * interval
-- local nextIndex = (math.ceil(current) - 1) % n + 1
-- local found = true
-- local spawnId, distance
-- for i = 0,n-1 do
-- spawnId = (nextIndex + i - 1) % n + 1
-- distance = i
-- break
-- end
-- if found then
-- local spawn = spawns[spawnId]
-- local spawnprev = spawns2[spawnId]
-- nextSpawn = spawn
-- nextLocation = spawn.name
-- prevLocation = spawnprev.name
-- local when = remainder + distance * interval
-- local timeleft = when - interval2
-- if when < interval2 then
-- nextTime = Red_Color..SecondsToClock(when).."|r"
-- -- local s, f = SecondsToTimeAbbrev(when)
-- -- nextTime = s:format(f)
-- else
-- nextTime = "|cff00FF00"..SecondsToClock(timeleft).."|r"
-- if PlayCustomSound == true then
-- PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\Gnome Woo.ogg", "Master")
-- end
-- -- local t, f = SecondsToTimeAbbrev(timeleft)
-- -- nextTime = t:format(f)
-- nextLocation = prevLocation
-- end
-- else
-- nextSpawn = nil
-- nextLocation = ""
-- prevLocation = ""
-- nextTime = ""
-- end
-- end
-- local TreasureGoblinTimer = nextTime.. " ".. nextLocation
-- return TreasureGoblinTimer
-- end
function ToDragonbaneKeepTimer() -- Драконья экспедиция
	-- local timePattern = "%02d:%02d"
	local TIMER = 1670342460 -- ToDragonbaneKeepTimer
	local interval = 7200
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ToDragonbaneKeepTimer = Red_Color..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ToDragonbaneKeepTimer = Addon_Color..SecondsToClock(nextEventIn) .."|r "
	end
	return ToDragonbaneKeepTimer
end
function GrandHuntsTimer() -- Кентавры Маруук
	-- local timePattern = "%02d:%02d"
	local TIMER = 1671307200-- 1675612800 -- GrandHuntsTimer
	local interval = 7200-- 270000
	local duration = 7199-- 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local GrandHuntsTimer = Red_Color..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		GrandHuntsTimer = Addon_Color..SecondsToClock(nextEventIn) .."|r "
	end
	return GrandHuntsTimer
end
function CommunityFeastTimer() -- Искарские клыкарры
	-- local timePattern = "%02d:%02d"
	local TIMER = 1677168000-- 1670331660 -- CommunityFeastTimer
	local interval = 5400
	local duration = 900
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local CommunityFeastTimer = Red_Color..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		CommunityFeastTimer = Addon_Color..SecondsToClock(nextEventIn) .."|r "
	end
	return CommunityFeastTimer
end
function PrimalStormsTimer() -- Праймал шторм
	-- local timePattern = "%02d:%02d"
	local TIMER = 1683804640-- 1671303600-- PrimalStormsTimer
	local interval = 18000-- 10800
	local duration = 7200
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local PrimalStormsTimer = Red_Color..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		PrimalStormsTimer = Addon_Color..SecondsToClock(nextEventIn) .."|r "
	end
	return PrimalStormsTimer
end
function ResearchersUnderFireTimer()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local currTime = tonumber(GetServerTime())
	local nextEventIn = interval - mod(currTime - TIMER, interval)
	local ResearchersUnderFireTimer = Red_Color..SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		ResearchersUnderFireTimer = Addon_Color..SecondsToClock(nextEventIn) .."|r "
	end
	return ResearchersUnderFireTimer
end
-- local function GetNPCIDFromGUID(guid)
-- if guid then
-- local unit_type, _, _, _, _, mob_id = strsplit("-", guid)
-- if unit_type == "Pet" or unit_type == "Player" then
-- return 0
-- end
-- return (guid and mob_id and tonumber(mob_id)) or 0
-- end
-- return 0
-- end
-- function CollectKillCount()
-- local UnitLevel = UnitLevel("PLAYER")
-- local curGUID = UnitGUID("PLAYER")
-- local collect = Octo_ToDo_DragonflyLevels[curGUID]
-- --------------------------------------------------
-- local timestamp, eventType, hideCaster, srcGuid, srcName, srcFlags, srcRaidFlags, dstGuid, dstName, dstFlags, dstRaidFlags, spellId, spellName, spellSchool, auraType = CombatLogGetCurrentEventInfo()
-- local bit_band = _G.bit.band
-- -- local strlower = _G.strlower
-- -- local format = _G.format
-- local npcIDs_table = {
-- 205490, -- Алчный Гоблин
-- 195305,
-- 195304,
-- }
-- local KillCount = 0
-- local npcid = GetNPCIDFromGUID(dstGuid)
-- if bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) or bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) or bit_band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) then
-- for _,v in pairs(npcIDs_table) do
-- if v == npcid then
-- print ("|cFF00A3FF"..dstName.. "|r " .. Addon_Color..collect.KillCount[npcid].. " (+1)|r")
-- collect.KillCount[npcid] = collect.KillCount[npcid] + 1
-- end
-- end
-- end
-- end
--LoadAddOn("Blizzard_PVPUI")
function CollectKnownSpell()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	--366253
	for k,v in ipairs(Octo_Table_SpellID) do
		local isKnown = IsSpellKnown(v)
		collect.KnownSpell[v] = isKnown
	end
end
function CollectVoidStorage()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local VOID_STORAGE_MAX = 80
	local VOID_STORAGE_PAGES = 2
	--Page 1
	for i = 1, VOID_STORAGE_MAX do
		local itemID, textureName, locked, recentDeposit, isFiltered, quality = GetVoidItemInfo(1, i)
		collect.VOID_STORAGE_PAGE1[i] = itemID or 0
	end
	--Page 2
	for i = 1, VOID_STORAGE_MAX do
		local itemID, textureName, locked, recentDeposit, isFiltered, quality = GetVoidItemInfo(2, i)
		collect.VOID_STORAGE_PAGE2[i] = itemID or 0
	end
end
function CollectLoginTime()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local xyi = date("%d.%m.%Y %H:%M:%S")
	collect.pizdaDate = date("%d.%m.%Y")
	collect.pizdaHours = date("%H:%M")
	collect.needReset = false
end
function CollectCovenantAnima()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local CovenantNames ={
		[1] = "Kyrian",
		[2] = "Venthyr",
		[3] = "NightFae",
		[4] = "Necrolord",
	}
	local curCovID = C_Covenants.GetActiveCovenantID()
	-- 0None
	-- 1Kyrian
	-- 2Venthyr
	-- 3NightFae
	-- 4Necrolord
	local curCovName = CovenantNames[curCovID]
	local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
	local curAnimaAmount = currencyInfo.quantity
	if curCovID == 0 then return end
	if curCovID == 1 then
		collect.Shadowland[1] = curCovLevel or 0 --Kyrian.Renown
		collect.Shadowland[2] = curAnimaAmount or 0 --Kyrian.Anima
	elseif curCovID == 2 then
		collect.Shadowland[3] = curCovLevel or 0 --Venthyr.Renown
		collect.Shadowland[4] = curAnimaAmount or 0 --Venthyr.Anima
	elseif curCovID == 3 then
		collect.Shadowland[5] = curCovLevel or 0 --NightFae.Renown
		collect.Shadowland[6] = curAnimaAmount or 0 --NightFae.Anima
	elseif curCovID == 4 then
		collect.Shadowland[7] = curCovLevel or 0 --Necrolord.Renown
		collect.Shadowland[8] = curAnimaAmount or 0 --Necrolord.Anima
	end
	collect.Shadowland[9] = curCovID
end
function CollectPVPRaitings()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	if not IsAddOnLoaded("Blizzard_PVPUI") then
		LoadAddOn("Blizzard_PVPUI")
		return
	end
	local rating2v2, seasonBest2v2, weeklyBest2v2, seasonPlayed2v2, seasonWon2v2, weeklyPlayed2v2, weeklyWon2v2, cap2v2 = GetPersonalRatedInfo(1) --2x2
	local rating3v3, seasonBest3v3, weeklyBest3v3, seasonPlayed3v3, seasonWon3v3, weeklyPlayed3v3, weeklyWon3v3, cap3v3 = GetPersonalRatedInfo(2) --3x3
	local ratingRBG, seasonBestRBG, weeklyBestRBG, seasonPlayedRBG, seasonWonRBG, weeklyPlayedRBG, weeklyWonRBG, capRBG = GetPersonalRatedInfo(4) --RBG
	local winrate2v2 = 0
	if seasonWon2v2 ~= 0 and seasonPlayed2v2 ~= 0 then
		winrate2v2 = math.floor(seasonWon2v2 / seasonPlayed2v2 * 100).."%"
	end
	local winrate3v3 = 0
	if seasonWon3v3 ~= 0 and seasonPlayed3v3 ~= 0 then
		winrate3v3 = math.floor(seasonWon3v3 / seasonPlayed3v3 * 100).."%"
	end
	local winrateRBG = 0
	if seasonWonRBG ~= 0 and seasonPlayedRBG ~= 0 then
		winrateRBG = math.floor(seasonWonRBG / seasonPlayedRBG * 100).."%"
	end
	Octo_ToDo_DragonflyLevels[curGUID].PVP.rating2v2 = rating2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBest2v2 = seasonBest2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrate2v2 = winrate2v2
	Octo_ToDo_DragonflyLevels[curGUID].PVP.rating3v3 = rating3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBest3v3 = seasonBest3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrate3v3 = winrate3v3
	Octo_ToDo_DragonflyLevels[curGUID].PVP.ratingRBG = ratingRBG
	Octo_ToDo_DragonflyLevels[curGUID].PVP.seasonBestRBG = seasonBestRBG
	Octo_ToDo_DragonflyLevels[curGUID].PVP.winrateRBG = winrateRBG
end
function CollectAllProfessions()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local prof1, prof2 = GetProfessions()
	local prof1 = prof1 and select(7, GetProfessionInfo(prof1))
	local prof2 = prof2 and select(7, GetProfessionInfo(prof2))
	collect.prof1 = prof1 or 0
	collect.prof2 = prof2 or 0
	local profID = {
		name = 0,
		icon = 0,
		chest = {questReq = 0, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 0, questID = {}},
		profQuest = {questReq = 0, questID = {}},
		treatise = {questReq = 0, questID = {}},
	}
	local iconAL = 4620669--136240
	local iconBS = 4620670
	local iconEC = 4620672
	local iconEG = 4620673
	local iconHB = 4620675
	local iconIS = 4620676
	local iconJC = 4620677
	local iconLW = 4620678
	local iconMN = 4620679
	local iconSK = 4620680
	local iconTL = 4620681
	-- Alchemy
	table[171] = {
		--name = " Alchemy",
		name = " Алхимия",
		icon = "|T"..iconAL..":16:16:::64:64:4:60:4:60|t", --AL
		chest = {questReq = 2, questID = {66373, 66374}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 2, questID = {70511, 70504}},
		profQuest = {questReq = 2, questID = {70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937}},
		treatise = {questReq = 1, questID = {74108}}, }
	-- Blacksmithing
	table[164] = {
		--name = " Blacksmithing",
		name = " Кузнечное дело",
		icon = "|T"..iconBS..":16:16:::64:64:4:60:4:60|t", --BS
		chest = {questReq = 2, questID = {66381, 66382}},
		craftOrder = {questReq = 1, questID = {70589}},
		drops = {questReq = 2, questID = {70513, 70512}},
		profQuest = {questReq = 2, questID = {66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211}},
		treatise = {questReq = 1, questID = {74109}}, }
	-- Enchanting
	table[333] = {
		--name = " Enchanting",
		name = " Наложение чар",
		icon = "|T"..iconEC..":16:16:::64:64:4:60:4:60|t", --EC
		chest = {questReq = 2, questID = {66377, 66378}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 2, questID = {70515, 70514}},
		profQuest = {questReq = 2, questID = {66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423}},
		treatise = {questReq = 1, questID = {74110}}, }
	-- Engineering
	table[202] = {
		--name = " Engineering",
		name = " Инженерное дело",
		icon = "|T"..iconEG..":16:16:::64:64:4:60:4:60|t", --EG
		chest = {questReq = 2, questID = {66379, 66380}},
		craftOrder = {questReq = 1, questID = {70591}},
		drops = {questReq = 2, questID = {70517, 70516}},
		profQuest = {questReq = 2, questID = {72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539}},
		treatise = {questReq = 1, questID = {74111}}, }
	-- Herbalism
	table[182] = {
		--name = " Herbalism",
		name = " Травничество",
		icon = "|T"..iconHB..":16:16:::64:64:4:60:4:60|t", --HB --136240
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {71857, 71858, 71859, 71860, 71861, 71864}},
		profQuest = {questReq = 1, questID = {70614, 70613, 70616, 70615}},
		treatise = {questReq = 1, questID = {74107}}, }
	-- Inscription
	table[773] = {
		--name = " Inscription",
		name = " Начертание",
		icon = "|T"..iconIS..":16:16:::64:64:4:60:4:60|t", --IS
		chest = {questReq = 2, questID = {66375, 66376}},
		craftOrder = {questReq = 1, questID = {70592}},
		drops = {questReq = 2, questID = {70519, 70518}},
		profQuest = {questReq = 2, questID = {66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438}},
		treatise = {questReq = 1, questID = {74105}}, }
	-- Jewelcrafting
	table[755] = {
		--name = " Jewelcrafting",
		name = " Ювелирное дело",
		icon = "|T"..iconJC..":16:16:::64:64:4:60:4:60|t", --JC
		chest = {questReq = 2, questID = {66388, 66389}},
		craftOrder = {questReq = 1, questID = {70593}},
		drops = {questReq = 2, questID = {70521, 70520}},
		profQuest = {questReq = 2, questID = {66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562}},
		treatise = {questReq = 1, questID = {74112}}, }
	-- Leatherworking
	table[165] = {
		--name = " Leatherworking",
		name = " Кожевничество",
		icon = "|T"..iconLW..":16:16:::64:64:4:60:4:60|t", --LW
		chest = {questReq = 2, questID = {66384, 66385}},
		craftOrder = {questReq = 1, questID = {70594}},
		drops = {questReq = 2, questID = {70523, 70522}},
		profQuest = {questReq = 2, questID = {66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363}},
		treatise = {questReq = 1, questID = {74113}}, }
	-- Mining
	table[186] = {
		--name = " Mining",
		name = " Горное дело",
		icon = "|T"..iconMN..":16:16:::64:64:4:60:4:60|t", --MN
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {72160, 72161, 72162, 72163, 72164, 72165}},
		profQuest = {questReq = 1, questID = {70617, 70618, 72157, 72156}},
		treatise = {questReq = 1, questID = {74106}}, }
	-- Skinning
	table[393] = {
		--name = " Skinning",
		name = " Снятие шкур",
		icon = "|T"..iconSK..":16:16:::64:64:4:60:4:60|t", --SK
		chest = {questReq = 2, questID = {}},
		craftOrder = {questReq = 0, questID = {}},
		drops = {questReq = 6, questID = {70381, 70383, 70384, 70385, 70386, 70389}},
		profQuest = {questReq = 4, questID = {70620, 72159, 70619, 72158}},
		treatise = {questReq = 1, questID = {74114}}, }
	-- Tailoring
	table[197] = {
		--name = " Tailoring",
		name = " Портяжное делло",
		icon = "|T"..iconTL..":16:16:::64:64:4:60:4:60|t", --TL
		chest = {questReq = 2, questID = {66386, 66387}},
		craftOrder = {questReq = 1, questID = {70595}},
		drops = {questReq = 2, questID = {70524, 70525}},
		profQuest = {questReq = 2, questID = {72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899}},
		treatise = {questReq = 1, questID = {74115}}, }
	if prof1 then
		-- setmetatable(table[prof1], { __index = profID})
		local chest_count_prof1 = 0
		local craftOrder_count_prof1 = 0
		local drops_count_prof1 = 0
		local profQuest_count_prof1 = 0
		local treatise_count_prof1 = 0
		for _, v in ipairs(table[prof1].chest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				chest_count_prof1 = chest_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].craftOrder.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				craftOrder_count_prof1 = craftOrder_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].drops.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				drops_count_prof1 = drops_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].profQuest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				profQuest_count_prof1 = profQuest_count_prof1 + 1
			end
		end
		for _, v in ipairs(table[prof1].treatise.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				treatise_count_prof1 = treatise_count_prof1 + 1
			end
		end
		Octo_ToDo_DragonflyLevels[curGUID].profID_prof1 =
		{
			name = table[prof1].name or "noname",
			icon = table[prof1].icon or 0,
			chest = {questReq = table[prof1].chest.questReq, chest_count_prof1 = chest_count_prof1},
			craftOrder = {questReq = table[prof1].craftOrder.questReq, craftOrder_count_prof1 = craftOrder_count_prof1},
			drops = {questReq = table[prof1].drops.questReq, drops_count_prof1 = drops_count_prof1},
			profQuest = {questReq = table[prof1].profQuest.questReq, profQuest_count_prof1 = profQuest_count_prof1},
			treatise = {questReq = table[prof1].treatise.questReq, treatise_count_prof1 = treatise_count_prof1},
		}
		------------------------------------------------------------------------------------------------
	end
	if prof2 then
		-- setmetatable(table[prof2], { __index = profID})
		local chest_count_prof2 = 0
		local craftOrder_count_prof2 = 0
		local drops_count_prof2 = 0
		local profQuest_count_prof2 = 0
		local treatise_count_prof2 = 0
		for _, v in ipairs(table[prof2].chest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				chest_count_prof2 = chest_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].craftOrder.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				craftOrder_count_prof2 = craftOrder_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].drops.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				drops_count_prof2 = drops_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].profQuest.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				profQuest_count_prof2 = profQuest_count_prof2 + 1
			end
		end
		for _, v in ipairs(table[prof2].treatise.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
				treatise_count_prof2 = treatise_count_prof2 + 1
			end
		end
		Octo_ToDo_DragonflyLevels[curGUID].profID_prof2 =
		{
			name = table[prof2].name or "noname",
			icon = table[prof2].icon or 0,
			chest = {questReq = table[prof2].chest.questReq, chest_count_prof2 = chest_count_prof2},
			craftOrder = {questReq = table[prof2].craftOrder.questReq, craftOrder_count_prof2 = craftOrder_count_prof2},
			drops = {questReq = table[prof2].drops.questReq, drops_count_prof2 = drops_count_prof2},
			profQuest = {questReq = table[prof2].profQuest.questReq, profQuest_count_prof2 = profQuest_count_prof2},
			treatise = {questReq = table[prof2].treatise.questReq, treatise_count_prof2 = treatise_count_prof2},
		}
		------------------------------------------------------------------------------------------------
	end
	return
end
-- local function getThresholdRAID(pointsRAID)
-- local resultRAID = 7
-- -- local resultRAID = 0
-- -- if pointsRAID <= 2 then
-- -- resultRAID = 2
-- -- elseif pointsRAID > 2 and pointsRAID < 4 then
-- -- resultRAID = 4
-- -- elseif pointsRAID >= 4 then
-- -- resultRAID = 6
-- -- end
-- return resultRAID
-- end
-- local function getThresholdKEYS(pointsKEYS)
-- local resultKEYS = 8
-- -- local resultKEYS = 0
-- -- if pointsKEYS <= 1 then
-- -- resultKEYS = 1
-- -- elseif pointsKEYS > 1 and pointsKEYS < 4 then
-- -- resultKEYS = 4
-- -- elseif pointsKEYS >= 4 then
-- -- resultKEYS = 8
-- -- end
-- return resultKEYS
-- end
-- local function getThresholdPVP(pointsPVPS)
-- local resultPVPS = 5000
-- -- local resultPVPS = 0
-- -- if pointsPVPS <= 1250 then
-- -- resultPVPS = 1250
-- -- elseif pointsPVPS > 1250 and pointsPVPS < 2500 then
-- -- resultPVPS = 2500
-- -- elseif pointsPVPS >= 2500 then
-- -- resultPVPS = 5500
-- -- end
-- return resultPVPS
-- end
function CollectDungeonsRaiting()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------
	local info = C_MythicPlus.GetRunHistory(false, true)
	local mapID = C_ChallengeMode.GetMapTable()
	-- --Get Highest Key Level
	-- local level = {}
	-- for l = 1, #info do
	-- local levelMax = info[l].level
	-- tinsert(level, levelMax)
	-- end
	-- if level[1] == nil then
	-- level = {""}
	-- end
	-- --Get Seasen Best Level
	-- table.sort(level, function(a, b) return b<a end)
	----------------------------------------------------------------------------
	--Get Vault Rewards
	local vault = C_WeeklyRewards.GetActivities()
	local RrLvl = {}
	local PrLvl = {false, false, false}
	local MrLvl = {}
	local pRank = {}
	for _, v in ipairs(vault) do
		for i = 1, 3 do
			if v.index == i then
				if v.type == 3 then
					local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
					tinsert(RrLvl, ilvl)
				end
				if v.type == 2 then
					if v.progress >= v.threshold then
						PrLvl[i] = true
					end
					if PrLvl[i] == true then
						local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
						tinsert(pRank, ilvl)
					end
				end
				if v.type == 1 then
					local ilvl = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(v.id))
					tinsert(MrLvl, ilvl)
				end
			end
		end
	end
	--Set Rewards ILVL
	if pRank[1] == nil then pRank[1] = NONE end
	if RrLvl[1] == nil then RrLvl[1] = NONE end
	if MrLvl[1] == nil then MrLvl[1] = NONE end
	-- 0 None
	-- 1 MythicPlus
	-- 2 RankedPvP
	-- 3 Raid
	-- 4 AlsoReceive
	-- 5 Concession
	-------------------------------------------------------------------------
	local vaultDataRAID = C_WeeklyRewards.GetActivities()
	local RAIDResult = 0
	local RAIDThreshold = 0
	for i=7, 9 do
		local activityInfoRAID = vaultDataRAID[i]
		if activityInfoRAID then
			RAIDResult = activityInfoRAID.progress
			RAIDThreshold = activityInfoRAID.threshold
		else
			RAIDResult = 0
			RAIDThreshold = 0
		end
	end
	local RAID = RAIDResult.."/"..RAIDThreshold.." |cffa335ee"..table.concat(RrLvl, "/").."|r"
	-------------------------------------------------------------------------
	local vaultDataKEYS = C_WeeklyRewards.GetActivities()
	local KEYSResult = 0
	local KEYSThreshold = 0
	for i=1, 3 do
		local activityInfoKEYS = vaultDataKEYS[i]
		if activityInfoKEYS then
			KEYSResult = activityInfoKEYS.progress
			KEYSThreshold = activityInfoKEYS.threshold
		else
			KEYSResult = 0
			KEYSThreshold = 0
		end
	end
	-- local KEYS = ("%s/%s"):format(KEYSResult, KEYSThreshold)
	local KEYS = KEYSResult.."/"..KEYSThreshold.." |cffa335ee"..table.concat(MrLvl, "/").."|r"
	-------------------------------------------------------------------------
	local vaultDataPVPS = C_WeeklyRewards.GetActivities()
	local PVPSResult = 0
	local PVPSThreshold = 0
	for i=4, 6 do
		local activityInfoPVPS = vaultDataPVPS[i]
		if activityInfoPVPS then
			PVPSResult = activityInfoPVPS.progress
			PVPSThreshold = activityInfoPVPS.threshold
		else
			PVPSResult = 0
			PVPSThreshold = 0
		end
	end
	-- local PVPS = ("%s/%s"):format(PVPSResult, PVPSThreshold)
	local PVPS = PVPSResult.."/"..PVPSThreshold.." |cffa335ee"..table.concat(pRank, "/").."|r"
	------------------------------------------------------------------
	local mythicPlusMaps = C_ChallengeMode.GetMapTable()
	C_MythicPlus.RequestRewards()
	local max = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
	C_MythicPlus.RequestMapInfo()
	for i=1, #mythicPlusMaps do
		--local _, _, level, affixes = C_ChallengeMode.GetMapPlayerStats(mythicPlusMaps[i])
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mythicPlusMaps[i])
		if level and level > max then
			max = level
		end
	end
	if max == 0 then max = "" end
	------------------------------------------------------------------
	collect.RIO_Score = RIO_Score
	collect.RIO_weeklyBest = (Purple_Color..max.."|r") or ""
	collect.RIO_RAID = RAID or ""
	collect.RIO_KEYS = KEYS or ""
	collect.RIO_PVPS = PVPS or ""
end
function CollectPossibleAnima()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	------------------------------------------------------------------
	local Possible_Anima = 0
	local Possible_CatalogedResearch = 0
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				local stackCount = containerInfo.stackCount
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				local isAnima = C_Item.IsAnimaItemByID(itemID)
				for k,v in pairs(Octo_Table_itemID_Cataloged_Research) do
					if itemID == v.itemiD then
						Possible_CatalogedResearch = Possible_CatalogedResearch + v.count
					end
				end
				if stackCount and isAnima and itemID ~= nil then
					if (quality == 2) and (itemID ~= 183727) then
						Possible_Anima = Possible_Anima + 5 * stackCount
					end
					if quality == 3 then
						Possible_Anima = Possible_Anima + 35 * stackCount
					end
					if quality == 4 then
						Possible_Anima = Possible_Anima + 250 * stackCount
					end
					if itemID == 183727 then
						Possible_Anima = Possible_Anima + 3 * stackCount
					end
				end
			end
		end
	end
	Possible_Anima = Possible_Anima
	Possible_CatalogedResearch = Possible_CatalogedResearch
	if collect then
		collect.Possible_Anima = Possible_Anima
		collect.Possible_CatalogedResearch = Possible_CatalogedResearch
	end
end
function CollectCurrentKEY()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local mkey = ""
	------------------------------------------------------------------
	local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
	if keyStoneLevel then
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					for k, v in pairs(containerInfo) do
						if k ~= nil and k == "hyperlink" then
							-- local hyperlink = v
							if v and (
								v:find("item:138019") or
								v:find("keystone:") or
								v:find("Ключ:") or
								v:find("item:158923") or
								v:find("item:180653")
							)
							then
								name = v
								if name:find("Каражан") then
									name = name:gsub("^[^:]+: ", "Кара: ")
								elseif name:find("Мехагон") then
									name = name:gsub("^[^ ]+ ", "")
								end
								local _, _, dungeon, lvl, expire = strsplit(":", name)
								-- local dungeonNAME = C_ChallengeMode.GetMapUIInfo(dungeon)
								-- local str = dungeonNAME
								-- mkey = lvl .. ": " ..(str:gsub("%s", ""))
								local dungeonNAME = C_ChallengeMode.GetMapUIInfo(dungeon)
								local Abbr_En_Name = "whz" --https://wow.tools/dbc/?dbc=mapchallengemode
								-- 0
								if dungeon == "56" then Abbr_En_Name = "SB" --Stormstout Brewery
								elseif dungeon == "57" then Abbr_En_Name = "GSS" --Gate of the Setting Sun
								elseif dungeon == "58" then Abbr_En_Name = "SPM" --Shado-Pan Monastery
								elseif dungeon == "59" then Abbr_En_Name = "SoNT" --Siege of Niuzao Temple
								elseif dungeon == "60" then Abbr_En_Name = "MP" --Mogu'shan Palace
								elseif dungeon == "76" then Abbr_En_Name = "Scho" --Scholomance
								elseif dungeon == "77" then Abbr_En_Name = "SH" --Scarlet Halls
								elseif dungeon == "78" then Abbr_En_Name = "SM" --Scarlet Monastery
								elseif dungeon == "161" then Abbr_En_Name = "Sky" --Skyreach
								elseif dungeon == "163" then Abbr_En_Name = "BSM" --Bloodmaul Slag Mines
								elseif dungeon == "164" then Abbr_En_Name = "Auch" --Auchindoun
								elseif dungeon == "167" then Abbr_En_Name = "UBS" --Upper Blackrock Spire
								elseif dungeon == "168" then Abbr_En_Name = "TE" --The Everbloom
								elseif dungeon == "200" then Abbr_En_Name = "HoV" --Halls of Valor
								elseif dungeon == "208" then Abbr_En_Name = "MoS" --Maw of Souls
								elseif dungeon == "209" then Abbr_En_Name = "TA" --The Arcway
								elseif dungeon == "210" then Abbr_En_Name = "CoS" --Court of Stars
								elseif dungeon == "227" then Abbr_En_Name = "RtKL" --Return to Karazhan: Lower
								elseif dungeon == "233" then Abbr_En_Name = "CoEN" --Cathedral of Eternal Night
								elseif dungeon == "234" then Abbr_En_Name = "RtKU" --Return to Karazhan: Upper
								elseif dungeon == "239" then Abbr_En_Name = "SotT" --Seat of the Triumvirate
								elseif dungeon == "197" then Abbr_En_Name = "EoA" --Eye of Azshara
								elseif dungeon == "198" then Abbr_En_Name = "DHT" --Darkheart Thicket
								elseif dungeon == "199" then Abbr_En_Name = "BRH" --Black Rook Hold
								elseif dungeon == "207" then Abbr_En_Name = "VotW" --Vault of the Wardens
									-- 3 CATA
									--elseif dungeon == "438" then Abbr_En_Name = "VP" --The Vortex Pinnacle
									-- 4 MOP
								elseif dungeon == "2" then Abbr_En_Name = "TJS" --Temple of the Jade Serpent
									-- 5 WOD
								elseif dungeon == "165" then Abbr_En_Name = "SBG" --Shadowmoon Burial Grounds
								elseif dungeon == "166" then Abbr_En_Name = "GD" --Grimrail Depot
								elseif dungeon == "169" then Abbr_En_Name = "ID" --Iron Docks
									-- 6 LEGION
									--elseif dungeon == "206" then Abbr_En_Name = "NL" --Neltharion's Lair
									-- 7 BFA
								elseif dungeon == "244" then Abbr_En_Name = "AD" --Atal'Dazar
									-- elseif dungeon == "245" then Abbr_En_Name = "FH" --Freehold
								elseif dungeon == "246" then Abbr_En_Name = "TD" --Tol Dagor
								elseif dungeon == "247" then Abbr_En_Name = "ML" --The MOTHERLODE!!
								elseif dungeon == "248" then Abbr_En_Name = "WM" --Waycrest Manor
								elseif dungeon == "249" then Abbr_En_Name = "KR" --Kings' Rest
								elseif dungeon == "250" then Abbr_En_Name = "ToS" --Temple of Sethraliss
									--elseif dungeon == "251" then Abbr_En_Name = "UNDR" --The Underrot
								elseif dungeon == "252" then Abbr_En_Name = "SotS" --Shrine of the Storm
								elseif dungeon == "353" then Abbr_En_Name = "SoB" --Siege of Boralus
								elseif dungeon == "369" then Abbr_En_Name = "OMJ" --Operation: Mechagon - Junkyard
								elseif dungeon == "370" then Abbr_En_Name = "OMW" --Operation: Mechagon - Workshop
									-- 8 SL
								elseif dungeon == "375" then Abbr_En_Name = "MoTS" --Mists of Tirna Scithe
								elseif dungeon == "376" then Abbr_En_Name = "TNW" --The Necrotic Wake
								elseif dungeon == "377" then Abbr_En_Name = "DOS" --De Other Side
								elseif dungeon == "378" then Abbr_En_Name = "HoA" --Halls of Atonement
								elseif dungeon == "379" then Abbr_En_Name = "PF" --Plaguefall
								elseif dungeon == "380" then Abbr_En_Name = "SD" --Sanguine Depths
								elseif dungeon == "381" then Abbr_En_Name = "SoA" --Spires of Ascension
								elseif dungeon == "382" then Abbr_En_Name = "ToP" --Theater of Pain
								elseif dungeon == "391" then Abbr_En_Name = "STRT" --Tazavesh: Streets of Wonder
								elseif dungeon == "392" then Abbr_En_Name = "GMBT" --Tazavesh: So'leah's Gambit
									-- 9 DF
								elseif dungeon == "399" then Abbr_En_Name = "RLP" --Ruby Life Pools
								elseif dungeon == "400" then Abbr_En_Name = "NO" --The Nokhud Offensive
								elseif dungeon == "401" then Abbr_En_Name = "AV" --The Azure Vault
								elseif dungeon == "402" then Abbr_En_Name = "AA" --Algeth'ar Academy
									--elseif dungeon == "403" then Abbr_En_Name = "ULD" --Uldaman: Legacy of Tyr
									-- elseif dungeon == "404" then Abbr_En_Name = "NELT" --Neltharus
									-- elseif dungeon == "405" then Abbr_En_Name = "BH" --Brackenhide Hollow
									-- elseif dungeon == "406" then Abbr_En_Name = "HOI" --Halls of Infusion
								elseif dungeon == "405" then Abbr_En_Name = "BH" --Brackenhide Hollow 393267 (лощина)
								elseif dungeon == "245" then Abbr_En_Name = "FH" --Freehold 410071 (гавань)
								elseif dungeon == "406" then Abbr_En_Name = "HOI" --Halls of Infusion 393283 (чертоги)
								elseif dungeon == "206" then Abbr_En_Name = "NL" --Neltharion's Lair 410078 (логово)
								elseif dungeon == "404" then Abbr_En_Name = "NELT" --Neltharus 393276 (нелтарий)
								elseif dungeon == "251" then Abbr_En_Name = "UNDR" --The Underrot 410074 (подгнилье)
								elseif dungeon == "438" then Abbr_En_Name = "VP" --The Vortex Pinnacle 410080 (вершина)
								elseif dungeon == "403" then Abbr_En_Name = "ULD" --Uldaman: Legacy of Tyr 393222 (ульдаман)
								end
								mkey = (Purple_Color..lvl .. " " ..Abbr_En_Name.."|r")
							end
						end
					end
				end
			end
		end
	else mkey = 0
	end
	if collect then
		collect.CurrentKey = mkey or 0
		local hasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
		--collect.hasAvailableRewards = hasAvailableRewards or false
		if hasAvailableRewards == true then collect.CurrentKey = Addon_Color..">>VAULT<<|r" end
	end
end
local function QuestsByID(questID)
	local count = 0
	for k, questID in pairs(ProfessionsQuests) do
		if C_QuestLog.IsQuestFlaggedCompleted(v) then
			count = count +1
		end
	end
	return count
end
local function CompactNumberFormat(number)
	if not number then
		number = 0
	end
	if number == 0 then
		return 0
	elseif number < 1000 then
		return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then
		return (math.floor(number/100)/10) .."k"
	else return (math.floor(number/100000)/10) .."m"
	end
end
local function CheckCompletedByQuestID(questID)
	local Octopussy = ""
	-- сделан
	if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
		Octopussy = (DONE)
		-- можно сдать
	elseif C_QuestLog.IsComplete(questID) == true then
		Octopussy = Purple_Color..">>СДАЙ<<|r"
		-- не сделан и нет квеста
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then
		Octopussy = (NONE)
		-- есть кв и нельзя сдать
	elseif C_QuestLog.IsOnQuest(questID) == true and C_QuestLog.IsComplete(questID) == false then
		local objectives = C_QuestLog.GetQuestObjectives(questID)
		local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
		if objectives == nil then
			return ""
		end
		if objectiveType == "progressbar" then
			return Red_Color..GetQuestProgressBarPercent(questID).."%|r"
		end
		local OBJF1 = "" local OBJR1 = "" local C1 = Red_Color local R1 = "|r"
		local OBJF2 = "" local OBJR2 = "" local C2 = Red_Color local R2 = "|r"
		local OBJF3 = "" local OBJR3 = "" local C3 = Red_Color local R3 = "|r"
		local OBJF4 = "" local OBJR4 = "" local C4 = Red_Color local R4 = "|r"
		local OBJF5 = "" local OBJR5 = "" local C5 = Red_Color local R5 = "|r"
		if objectives[1] == nil then
		OBJF1 = "" OBJR1 = "" else if
			objectives[1].numFulfilled == objectives[1].numRequired then
			OBJF1 = Green_Color.."done|r" OBJR1 = "" else if
				objectives[1].numFulfilled >= 0 then
					OBJF1 = objectives[1].numFulfilled.."/" OBJR1 = objectives[1].numRequired
				end
			end
		end
		if OBJF1 == OBJR1 then
			C1 = Green_Color..""
		end
		if objectives[2] == nil then
		OBJF2 = "" OBJR2 = "" else if
			objectives[2].numFulfilled == objectives[2].numRequired then
			OBJF2 = Green_Color.."done|r" OBJR2 = "" else if
				objectives[2].numFulfilled >= 0 then
					OBJF2 = objectives[2].numFulfilled.."/" OBJR2 = objectives[2].numRequired
				end
			end
		end
		if OBJF2 == OBJR2 then
			C2 = Green_Color..""
		end
		if objectives[3] == nil then
		OBJF3 = "" OBJR3 = "" else if
			objectives[3].numFulfilled == objectives[3].numRequired then
			OBJF3 = Green_Color.."done|r" OBJR3 = "" else if
				objectives[3].numFulfilled >= 0 then
					OBJF3 = objectives[3].numFulfilled.."/" OBJR3 = objectives[3].numRequired
				end
			end
		end
		if OBJF3 == OBJR3 then
			C3 = Green_Color..""
		end
		if objectives[4] == nil then
		OBJF4 = "" OBJR4 = "" else if
			objectives[4].numFulfilled == objectives[4].numRequired then
			OBJF4 = Green_Color.."done|r" OBJR4 = "" else if
				objectives[4].numFulfilled >= 0 then
					OBJF4 = objectives[4].numFulfilled.."/" OBJR4 = objectives[4].numRequired
				end
			end
		end
		if OBJF4 == OBJR4 then
			C4 = Green_Color..""
		end
		if objectives[5] == nil then
		OBJF5 = "" OBJR5 = "" else if
			objectives[5].numFulfilled == objectives[5].numRequired then
			OBJF5 = Green_Color.."done|r" OBJR5 = "" else if
				objectives[5].numFulfilled >= 0 then
					OBJF5 = objectives[5].numFulfilled.."/" OBJR5 = objectives[5].numRequired
				end
			end
		end
		if OBJF5 == OBJR5 then
			C5 = Green_Color..""
		end
		if objectives then
			if objectives[5] then
				Octopussy = Red_Color..CompactNumberFormat(objectives[5].numFulfilled).."/"..CompactNumberFormat(objectives[5].numRequired).."|r"
			elseif objectives[4] then
				Octopussy = Red_Color..CompactNumberFormat(objectives[4].numFulfilled).."/"..CompactNumberFormat(objectives[4].numRequired).."|r"
			elseif objectives[3] then
				Octopussy = Red_Color..CompactNumberFormat(objectives[3].numFulfilled).."/"..CompactNumberFormat(objectives[3].numRequired).."|r"
			elseif objectives[2] then
				Octopussy = Red_Color..CompactNumberFormat(objectives[2].numFulfilled).."/"..CompactNumberFormat(objectives[2].numRequired).."|r"
			elseif objectives[1] then
				Octopussy = Red_Color..CompactNumberFormat(objectives[1].numFulfilled).."/"..CompactNumberFormat(objectives[1].numRequired).."|r"
			end
		end
	end
	return Octopussy
end
local function CheckReputationByRepID(factionID)
	local Vivod = ""
	local dev_text = ""
	local friendshipRank, friendshipMaxRank
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched, isChild, _, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(factionID)
	local color = White_Color
	local r = "|r"
	local standingTEXT = ""
	--RED
	if standingID == 1 then
		color = Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL1..")" -- color = "|cffc0443b" Hated
	elseif standingID == 2 then
		color = Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL2..")" -- color = "|cffd91614" Hostile
		--оранж
	elseif standingID == 3 then
		color =  Orange_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL3..")" -- color = "|cffcd732e" Unfriendly
		--ЖЕЛТЫЙ
	elseif standingID == 4 then
		color =  Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL4..")" -- color = Yellow_Color Neutral
		--ЗЕЛЕНЫЙ
	elseif standingID == 5 then
		color =  Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL5..")" -- color = "|cff1af11a" Friendly
		--ПОЧТИ ЗЕЛЕНЫЙ
	elseif standingID == 6 then
		color =  Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL6..")" -- color = "|cff1af05e" Honored
	elseif standingID == 7 then
		color =  Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL7..")" -- color = "|cff19ffc6" Revered
		--БИРЮЗОВЫЙ
	elseif standingID == 8 then
		color =  Addon_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL8..")" -- color = "|cff00ffff" Exalted
	elseif standingID == 9 then
		color =  Addon_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL9..")" -- color ="|cff00ffff" Paragon
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID or 0)
	-- if not barMax then
	-- Vivod = "not barMax"
	-- elseif factionID and barMax and barMin ~= 0 then
	----------- ПАРАГОН
	if C_Reputation.IsFactionParagon(factionID) then
		if Octo_REPUTATION_DEV_text == true then dev_text = Red_Color.."ПАРАГОН: |r" end
		local currentValue = C_Reputation.GetFactionParagonInfo(factionID) or 0
		local threshold = 1
		local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)
		if threshold then
			local value = currentValue % threshold
			Vivod = dev_text..Addon_Color..--[[CompactNumberFormat]](value).."/"..--[[CompactNumberFormat]](threshold)..r
			if hasRewardPending then
				Vivod = dev_text..CheckCompletedByQuestID(rewardQuestID)
			end
		end
		----------- МАЖОР ФАКШН
	elseif C_Reputation.IsMajorFaction(factionID) then
		if Octo_REPUTATION_DEV_text == true then dev_text = Green_Color.."МАЖОР ФАКШН: |r" end
		local data = C_MajorFactions.GetMajorFactionData(factionID)
		local currentValue = data.renownReputationEarned
		local totalValue = data.renownLevelThreshold
		local standing = data.renownLevel
		Vivod = dev_text..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue)..Addon_Color.."("..--[[CompactNumberFormat]](standing)..")|r"
		if standing == 0 then Vivod = 0 end
		----------- ФРЕНД ФАКШН
	elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
		if Octo_REPUTATION_DEV_text == true then dev_text = Yellow_Color.."ФРЕНД ФАКШН: |r" end
		local friendshipFactionID = reputationInfo.friendshipFactionID or 0
		local reactionThreshold = reputationInfo.reactionThreshold or 0
		local nextThreshold = reputationInfo.nextThreshold or 0
		local standing = reputationInfo.standing or 0
		local name = reputationInfo.name
		local currentValue = standing-reactionThreshold
		local totalValue = nextThreshold-reactionThreshold
		local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
		local currentLevel, maxLevel
		if rankInfo then
			currentLevel = rankInfo.currentLevel or 0
			maxLevel = rankInfo.maxLevel or 0
		end
		if currentLevel == 1 then
			color = Yellow_Color
			standingTEXT = " (Stranger)" -- 1
		elseif currentLevel == 2 then
			color = Yellow_Color
			standingTEXT = " (Acquaintance)" -- 2
		elseif currentLevel == 3 then
			color = Yellow_Color
			standingTEXT = " (Buddy)" -- 3
		elseif currentLevel == 4 then
			color = Yellow_Color
			standingTEXT = " (Friend)" -- 4
		elseif currentLevel == 5 then
			color = Green_Color
			standingTEXT = " (Good Friend)" -- 5
		elseif currentLevel == 6 then
			color = Addon_Color
			standingTEXT = " (Best Friend)" -- 6
		end
		Vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue) .. standingTEXT..r
		if currentLevel == maxLevel then Vivod = dev_text..Addon_Color.."Done|r" end
		--if standing == 0 then Vivod = 0 end
		----------- Other
	else
		if Octo_REPUTATION_DEV_text == true then dev_text = Purple_Color.."Other: |r" end
		local currentValue = barValue-barMin
		local totalValue = barMax-barMin
		Vivod = dev_text..color..--[[CompactNumberFormat]](currentValue).."/"..--[[CompactNumberFormat]](totalValue)..standingTEXT..r
		if currentValue == totalValue or nextThreshold == 0 then Vivod = dev_text..Addon_Color.."Done|r" end
		--if standingID == 0 or currentValue == 0 then Vivod = 0 end
	end
	--end
	return Vivod
end
local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	if data then
		return
		data.name, -- 1
		data.quantity, -- 2
		data.iconFileID -- 3
	end
end
--MergeTable(Octo_Table_itemID_ALL, Octo_Table_itemID_Reputation)
-- local function itemID_TEST_INSERT()
-- for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
-- for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
-- local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
-- if containerInfo then
-- for k, v in pairs(containerInfo) do
-- if k == "itemID" then
-- tinsert(Octo_Table_itemID_ALL, v)
-- end
-- end
-- end
-- end
-- end
-- end
local ZM_arr10 = {
	{id=65557},--npc=178229,Feasting
	{id=65581},--npc=178563,Hadeon the Stonebreaker
	{id=65579},--npc=178778,Gluttonous Overgrowth
	{id=63988},--npc=178963,Gorkek
	{id=65582},--npc=179043,Orixal
	{id=64668},--npc=180746,Protector of the First Ones
	{id=64716},--npc=180917,Destabilized Core
	{id=65548},--npc=180978,Hirukon
	{id=65550},--npc=181249,Tethos
	{id=65239},--npc=181360,Vexis
	{id=65580},--npc=183516,The Engulfer
	{id=65553},--npc=183596,Chitali the Eldest
	{id=65544},--npc=183646,Furidian
	{id=65240},--npc=183722,Sorranos
	{id=65241},--npc=183737,Xy"rath the Covetous
	{id=65556},--npc=183746,Otiosen
	{id=65584},--npc=183747,Vitiane
	{id=65551},--npc=183748,Helmix
	{id=65251},--npc=183764,Zatojin
	{id=65257},--npc=183814,Otaris the Provoked
	{id=65272},--npc=183925,Tahkwitz
	{id=65574},--npc=183927,Sand Matriarch Ileus
	{id=65273},--npc=183953,Corrupted Architect
	{id=65555},--npc=184409,Euv'ouk
	{id=65549},--npc=184413,Shifting Stargorger
}
local ZM_arr15 = {
	{id=65547},--npc=178508,Mother Phestis
	{id=65552},--npc=179006,Akkaris
	{id=64719},--npc=180924,Garudeon
	{id=65585},--npc=182114,Iska,Outrider of Ruin
	{id=65586},--npc=182155,High Reaver Damaris
	{id=65587},--npc=182158,Reanimatrox Marzan
	{id=65583},--npc=182318,General Zarathura
}
local ZM_arr125 = {
	{id=64960},
	{id=64974},
	{id=65081},
	{id=65089},
	{id=65102},
	{id=65115},
	{id=65117},
	{id=65119},
	{id=65230},
	{id=65232},
	{id=65234},
	{id=65244},
	{id=65252},
	{id=65262},
	{id=65402},
	{id=65403},
	{id=65404},
	{id=65405},
	{id=65406},
	{id=65407},
	{id=65408},
	{id=65410},
	{id=65411},
	{id=65412},
	{id=65413},
	{id=65414},
	{id=65415},
	{id=65416},
	{id=65417},
	{id=65231},--Elite World Quest
}
local ZM_arr1250WQ = {
	{id=66042}, --WEEKLY
}
local ZM_arr500WB = {
	{id=65143}, --WB
}
--КОРТИЯ
-- tinsert(aura_env.arr, { name="|cff00A3FFW|r Мучители Торгаста", id=63854}) --Мучители Торгаста
-- local ASSAULTQuests, ASSAULTQID = {
-- [63822] = true, --вент
-- [63823] = true, --феи
-- [63824] = true, --кирии
-- [63543] = true; --некролорды
-- }
-- for qID in pairs(ASSAULTQuests) do
-- if C_QuestLog.IsQuestFlaggedCompleted(qID) then
-- ASSAULTQID = qID
-- break
-- end
-- end
-- if not ASSAULTQID then
-- for _, quest in ipairs(C_TaskQuest.GetQuestsForPlayerByMapID(1550)) do
-- if ASSAULTQuests[quest.questId] then
-- ASSAULTQID = quest.questId
-- break
-- end
-- end
-- end
-- --
-- --WORLDBOSS
-- --
-- local WORLDBOSSQuests, WORLDBOSSQID = {
-- [61816] = true,
-- [61815] = true,
-- [61814] = true,
-- [61813] = true,
-- }
-- for qID in pairs(WORLDBOSSQuests) do
-- if C_QuestLog.IsQuestFlaggedCompleted(qID) then
-- WORLDBOSSQID = qID
-- break
-- end
-- end
-- if not WORLDBOSSQID then
-- for _, quest in ipairs(C_TaskQuest.GetQuestsForPlayerByMapID(1550)) do
-- if WORLDBOSSQuests[quest.questId] then
-- WORLDBOSSQID = quest.questId
-- break
-- end
-- end
-- end
-- if WORLDBOSSQID==61813 then tinsert(aura_env.arr, { name="|cff00A3FFW|r |T3257748:0|tWB - Кирии", id=61813}) end --БастионВалинор
-- if WORLDBOSSQID==61814 then tinsert(aura_env.arr, { name="|cff00A3FFW|r |T3257751:0|tWB - Вентиры", id=61814}) end --РевендретНургаш Жижерожденный
-- if WORLDBOSSQID==61815 then tinsert(aura_env.arr, { name="|cff00A3FFW|r |T3257750:0|tWB - Ночной народец", id=61815}) end --АрденвельдОраномонос Вечноветвящаяся
-- if WORLDBOSSQID==61816 then tinsert(aura_env.arr, { name="|cff00A3FFW|r |T3257749:0|tWB - Некролорды", id=61816}) end --МалдраксусМортанис
-- tinsert(aura_env.arr, { name="|cff00A3FFW|r |T1003591:0|tWB - Мор'гет", id=64531})--Утроба
-- tinsert(aura_env.arr, { name="|cff00A3FFW|r |T1003591:0|tWB - Антрос", id=65143})--Zereth Mortis --Antros <Keeper of the Antecedents> --npc=182466/
function ASSAULT_YTROBATimer()
	local refreshTime = 1 --sec
	local invasionStart = 3780--3963 -- начало в 00:03
	local invasionInterval = 7200 --2ч
	local invasionPending = 900 --15мин
	if lastRefresh == nil or lastRefresh < GetTime()-refreshTime then
		lastRefresh = GetTime()
		local function GetTimeFromMs( ms)
			local hr = string.format("%02d", math.floor(ms/3600)) --hours
			local mn = string.format("%02d", math.floor((ms%(3600))/60)) --minutes
			local ss = string.format("%02d", math.floor((ms%(60)))) --seconds
			local out = hr .. ":" .. mn .. ":" .. ss -- format timer output
			return out
		end
		local delta = time() - invasionStart
		local perc = invasionInterval - delta%invasionInterval --time
		if (perc > invasionInterval-invasionPending ) then
			invasionMsg = Green_Color..GetTimeFromMs(perc-(invasionInterval-invasionPending)).."|r"
		else
			invasionMsg= Red_Color..GetTimeFromMs(perc).."|r"
		end
	end
	return invasionMsg
end
local rares = {
	--{name = "|cff00A3FFW|r Определяя судьбу",quests = {63949,}, max=1},
	--{name = "|cff00A3FFW|r Ворлд Боссы",quests = {61813,61814,61815,61816,64531}, max=2},
	--{name = "|cff00A3FFW|r Наполнение резервуара",quests = {61981,61982,61983,61984,}, max=1},
	{name = "|cff00A3FFW|r Торгаст",quests = {64347,}, max=1},
	--{name = "Атака ковенантов",quests = {63822,63823,63824,63543,}, max=1},
	--{name = "|cff00A3FFW|r Локалка у рейда SoD",quests = {64273,}, max=1},
	--{name = "Возвращение потерянных душ",quests = {62858,62859,62860,62861,62862,62863,62864,62865,62866,62867,62868,62869,}, max=1},
	--{name = "|cff00A3FFW|r Обмен услугами",quests = {60242,60243,60244,60245,60246,60247,60248,60249,60250,60251,60252,60253,60254,60255,60256,60257,}, max=2},
	{name = "|cff00A3FFW|r Событие выходного дня",quests = {62631,62632,62633,62634,62635,62636,62637,62638,62639,62640,64709,}, max=1},
	--{name = "|cff00A3FFW|r ПВП",quests = {47148,62284,62285,62286,62287,62288,}, max=2}, --64304 килл 20 челиков
	--{name = "|cff00A3FFW|r Украденные кортийские припасы", quests = {64522,}, max=1},--Stolen Korthian Supplies (ДРОПАЕТСЯ)
	{name = "|cff00A3FFW|r |T528693:0|t|cffbf9effRIFT|r Пропавшие исследования",quests = {65266,}, max=1},
	{name = "|cff00A3FFW|r |T528693:0|t|cffbf9effRIFT|r Сосуд с анимой", quests = {64265,64269,64270,}, max=3},--Rift Weekly
	{name = "|cffF3BC41D|r |T528693:0|t|cffbf9effRIFT|r Тайники кортии", quests = {64470,64471,64472,64456,}, max=4},--Rift DailyТайник Разлома
	--{name = "|cffF3BC41D|r |T528693:0|t|cffbf9effRIFT|r Тайник с украденной анимой", quests = {64575,}, max=1},--Утроба 250 анимы
	--{name = "|cffF3BC41D|r |T528693:0|t|cffbf9effRIFT|r Хранилище Зоваала", quests = {64283,}, max=1},--Rift Daily
	{name = "|cffF3BC41D|r Сундук с призрачным замком", quests = {64247,}, max=1},--Chest with 3 keys
	--{name = "|cffF3BC41D|r Сундук у рейда", quests = {64256,}, max=1},--Maw chest in Desmotaeron
	--{name = "|cffF3BC41D|r Мобы", quests = {64341,64342,64343,64344,64747,64748,64749,64750,64751,64752,64753,64754,64755,64756,64757,}, max=3},
	{name = "|cffF3BC41D|r Сбор",quests = {64351,64354,64355,64356,64357,64358,64359,64360,64361,64362,64021,64363,64364,64316,64317,64318,64564,64565,}, max=18},
	--{name = "|cffF3BC41D|r Горгеры",quests = {64433,64434,64435,64436,}, max=4},
	--{name = "|cffF3BC41D|r Утроба",quests = {60646,60762,60775,61075,61079,61088,61103,61104,61765,62214,62234,}, max=3},
	--{name = "|cffF3BC41D|r Рарки",quests = {64457,64338,64442,64278,64245,64246,64263,64428,64258,64233,64349,63830,64243,64291,64455,64320,64313,64284,64285,64257,64440,64276,64272,64232,64251,64152,64439}, max=23},
	--[[
{name = "|cffFFF371ITEM|r +REP Отчет об исследованиях: методика изучения реликвий",quests = {64367,}, max=1}, --1871362500
{name = "|cffFFF371ITEM|r Детектор украденной анимы",quests = {64061,}, max=1}, --186453 доступ к сосудам 1000
{name = "|cffFFF371ITEM|r Отчет об исследованиях: всевидящий кристалл",quests = {64339,}, max=1}, --186714100
{name = "|cffFFF371ITEM|r Исследование: распознавание стигии и ее применение",quests = {64307,}, max=1}, --187145800
{name = "|cffFFF371ITEM|r Исследование: узы стигии в смертных",quests = {64828,}, max=1}, --1877061000
{name = "|cffFFF371ITEM|r Отчет об исследованиях: древние святилища",quests = {64348,}, max=1}, --1867161000
{name = "|cffFFF371ITEM|r Исследование: свойства и эффективное использование анимы",quests = {64027,}, max=1}, --1867221500
{name = "|cffFFF371ITEM|r Исследование: поиски реликвий в Темных Землях",quests = {64366,}, max=1}, --1867212000
{name = "|cffFFF371ITEM|r Отчет об исследованиях: адаптивные сплавы",quests = {64300,}, max=1}, --1867174000
{name = "|cffFFF371ITEM|r Отчет об исследованиях: первые сплавы",quests = {64303,}, max=1}, --1871388000
]]
}
local raresKyrian = {
	{name = "|cff00A3FFW|r |T3257748:0|tАтака кирий", quests = {63824,}, max=1},--Kyrian
	{name = "|cff00A3FFW|r |T3257748:0|tСосуд с анимой", quests = {64057,64058,}, max=2},--Kyrian
}
local raresNecrolord = {
	{name = "|cff00A3FFW|r |T3257749:0|tАтака некролордов", quests = {63543,}, max=1},--Necrolord
	{name = "|cff00A3FFW|r |T3257749:0|tСосуд с анимой", quests = {64044,64045,}, max=2},--Necrolord
	--{name = "|cff00A3FFW|r |T3257749:0|tТайник ковенанта", quests = {64209,63815,63816,63817,63818,63825,63826,}, max=7},--Necrolord
}
local raresNightFae = {
	{name = "|cff00A3FFW|r |T3257750:0|t|tАтака ночного народца", quests = {63823,}, max=1},--NightFae
	{name = "|cff00A3FFW|r |T3257750:0|tСосуд с анимой", quests = {64059,64060,}, max=2},--NightFae
	--{name = "|cff00A3FFW|r |T528693:0|t|cffbf9eff|T3257750:0|tТайник ковенанта|r", quests = {63995,63997,63998,63996,63999,63993,}, max=6},--NightFae
}
local raresVenthyr = {
	{name = "|cff00A3FFW|r |T3257751:0|tАтака вентиров", quests = {63822,}, max=1},--Venthyr
	{name = "|cff00A3FFW|r |T3257751:0|tСосуд с анимой", quests = {64055,64056,}, max=2},--Venthyr
}
local assaults = {
	{64057, 1}, {64058, 1},--Kyrian63824
	{64044, 1}, {64045, 1},--Necrolord63543
	{64055, 2}, {64056, 2},--Venthyr63822
	{64059, 2}, {64060, 2},--Night Fae63823
}
---------------------------------------------------------------------------------------------------------
function CollectAllCurrency()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	for k, v in ipairs(Octo_Table_currencyID_ALL) do
		local data = C_CurrencyInfo.GetCurrencyInfo(v)
		local quantity = data.quantity
		local maxQuantity = data.maxQuantity
		if v == 2167 and maxQuantity > 6 then maxQuantity = 6 end
		if collect then
			collect.CurrencyID[v] = quantity
			collect.CurrencyID_maxQuantity[v] = maxQuantity
			--if CharInfo.UnitLevel >= 70 then tinsert(Octo_Table_currencyID_ALL, 2167) end
			-- == 0 and nil or quantity
			-- collect.Octo_Table_currencyID_ALL[v] = maxQuantity
			-- local c = "|cffffffff"
			-- local r = "|r"
			-- if maxQuantity > 0 and quantity == 0 then c = Gray_Color end
			-- if maxQuantity > 0 and quantity == maxQuantity then c = Addon_Color end
			-- if maxQuantity ~= 0 and quantity >= 1 then
			-- collect.Octo_Table_currencyID_ALL[v] = c..CompactNumberFormat(quantity)..c.."/"..CompactNumberFormat(maxQuantity)..r
			-- end
		end
	end
end
local function Empty_Zero(number)
	if number == 0 then
		return ""
	end
	return number
end
function CollectAppliedMountEquipmentID()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local canUseMountEquipment = C_PlayerInfo.CanPlayerUseMountEquipment()
	local itemID = C_MountJournal.GetAppliedMountEquipmentID()
	if collect then
		collect.canUseMountEquipment = canUseMountEquipment
		collect.currentMountItemID = itemID
	end
end
function CollectAllItemsInBag()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local usedSlots = 0
	local totalSlots = 0
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlots = totalSlots + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
		end
	end
	if collect and usedSlots > 0 and totalSlots > 0 then
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
	end
	-------------------------------------------------------------------------
	local GetBindLocation = GetBindLocation()
	local PlayerReagentnumSlots = C_Container.GetContainerNumSlots(BACKPACK_CONTAINER+NUM_BAG_SLOTS+1)
	local mapID = C_Map.GetBestMapForUnit("player")
	if mapID then
		local info = C_Map.GetMapInfo(mapID)
		local CurrentLocation= "noname"
		CurrentLocation = info.name
		if collect and not InCombatLockdown() then
			for k, v in ipairs(Octo_Table_itemID_ALL) do
				local count = GetItemCount(v, true, true, true)
				collect.ItemsInBag[v] = count or 0
				collect.GetBindLocation = GetBindLocation
				collect.CurrentLocation = CurrentLocation
			end
			collect.PlayerReagentnumSlots = PlayerReagentnumSlots
		end
	end
end
-- local itemFragmentTable = {
-- 204075,
-- }
function CollectBankInfo()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	--REAGENTBANK_CONTAINER,BANK_CONTAINER
	--NUM_TOTAL_EQUIPPED_BAG_SLOTS+1,NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS
	local usedSlotsBANK = 0
	local totalSlotsBANK = 0
	local usedSlotsBANKREAGENT = 0
	local totalSlotsBANKREAGENT = 0
	local usedSlotsBANKBAGS = 0
	local totalSlotsBANKBAGS = 0
	for bag = BANK_CONTAINER, BANK_CONTAINER do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANK = totalSlotsBANK + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANK = usedSlotsBANK + (numSlots - numberOfFreeSlots)
		end
	end
	for bag = REAGENTBANK_CONTAINER, REAGENTBANK_CONTAINER do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANKREAGENT = totalSlotsBANKREAGENT + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANKREAGENT = usedSlotsBANKREAGENT + (numSlots - numberOfFreeSlots)
		end
	end
	for bag = NUM_TOTAL_EQUIPPED_BAG_SLOTS+1, NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlotsBANKBAGS = totalSlotsBANKBAGS + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlotsBANKBAGS = usedSlotsBANKBAGS + (numSlots - numberOfFreeSlots)
		end
	end
	-------------------------------------------------------------------------
	if collect then
		collect.usedSlotsBANK = usedSlotsBANK + usedSlotsBANKREAGENT + usedSlotsBANKBAGS
		collect.totalSlotsBANK = totalSlotsBANK + totalSlotsBANKREAGENT + totalSlotsBANKBAGS
	end
end
function CollectAllReputations()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	if collect then
		for k, v in pairs(Octo_Table_reputation) do
			local rep = CheckReputationByRepID(v)
			collect.reputationID[v] = rep or 0
		end
	end
end
function CollectAllQuests()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	-------------------------------------------------------------------------
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	local EVENTS_ZARALEK_count = 0
	for k, v in ipairs(Octo_Table_QuestID) do
		local qw = CheckCompletedByQuestID(v)
		collect.Octo_Table_QuestID[v] = qw or 0
	end
	----------------------------------------
	if collect then
		collect.numShownEntries = numShownEntries
		collect.numQuests = numQuests
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept
	end
end
local function tmstpDayReset(n)
	local n = n or 1
	local currTime = GetServerTime()
	local xyu = (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
	return (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
end
-- https://wago.io/fVZJC8tik
-- https://wago.io/sl3JkGN7T
local WA_Utf8Sub = function(input, size)
	local output = ""
	if type(input) ~= "string" then
		return output
	end
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then
			return output
		end
		if byte < 128 then
			output = output .. input:sub(i, i)
			size = size - 1
		elseif byte < 192 then
			output = output .. input:sub(i, i)
		elseif byte < 244 then
			output = output .. input:sub(i, i)
			size = size - 1
		end i = i + 1
	end
	while (true) do
		local byte = input:byte(i)
		if byte and byte >= 128 and byte < 192 then
			output = output .. input:sub(i, i)
		else
			break
		end
		i = i + 1
	end
	return output
end
local table_func_otrisovka = {}
local function pizdalishe()
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				-- ТЕКС СЛЕВА
				local VivodLeft = (func_texturefromIcon(3753264).. ToDragonbaneKeepTimer()..L["Siege on Dragonbane Keep"])
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				-- ТЕКС СЛЕВА
				local VivodLeft = (func_texturefromIcon(1519430) .. GrandHuntsTimer()..L["Grand Hunt"])
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				-- ТЕКС СЛЕВА
				local VivodLeft = (func_texturefromIcon(629056).. CommunityFeastTimer()..L["Community Feast"])
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_Feast_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_Feast_count
				end
				if CharInfo.ItemsInBag[200652] ~= 0 then
					VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200652]..func_itemTexture(200652)
				end
				if CharInfo.ItemsInBag[200095] ~= 0 then
					VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200095]..func_itemTexture(200095)
				end
				if CharInfo.UnitLevel >= 58 and (CharInfo.KnownSpell[366253] == false or CharInfo.KnownSpell[366253] == 0) then
					VivodCent = VivodCent .. Red_Color.."-|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				-- ТЕКС СЛЕВА
				local VivodLeft = (func_texturefromIcon(236469).. PrimalStormsTimer()..L["The Storm's Fury"])
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_StormsFury_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_StormsFury_count
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				-- ТЕКС СЛЕВА
				local VivodLeft = (func_texturefromIcon(236469) .. ResearchersUnderFireTimer()..L["Researchers Under Fire"])
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_texturefromIcon(1603189)..func_questName(70750)
				-- if CharInfo.OctopussyWeekly_3kREP_IsOnQuest ~= 0 then
				--     tinsert(tooltip,{func_questName(CharInfo.OctopussyWeekly_3kREP_IsOnQuest)})
				-- end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_3kREP_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_3kREP_count
				end
				if CharInfo.ItemsInBag[200073] ~= 0 then
					VivodCent = VivodCent.." +"..CharInfo.ItemsInBag[200073]..func_itemTexture(200073)
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_questName(75665)
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count ~= NONE then
					VivodCent = CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			--4
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(180653)..func_itemName(180653)
				if CharInfo.CurrentKey ~= 0 then
					tooltip[#tooltip+1] = {"Score", CharInfo.RIO_Score}
					tooltip[#tooltip+1] = {"Weekly Best", CharInfo.RIO_weeklyBest}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {"Рейды", CharInfo.RIO_RAID}
					tooltip[#tooltip+1] = {"M+", CharInfo.RIO_KEYS}
					tooltip[#tooltip+1] = {"PVP", CharInfo.RIO_PVPS}
					-- tooltip[#tooltip+1] = {
					-- {"Score", CharInfo.RIO_Score},
					-- {"Weekly Best", CharInfo.RIO_weeklyBest},
					-- {" ", " "},
					-- {"Рейды", CharInfo.RIO_RAID},
					-- {"M+", CharInfo.RIO_KEYS},
					-- {"PVP", CharInfo.RIO_PVPS},
					-- }
					-- tinsert(tooltip, {"Score", CharInfo.RIO_Score})
					-- tinsert(tooltip, {"Weekly Best", CharInfo.RIO_weeklyBest})
					-- tinsert(tooltip, {" ", " "})
					-- tinsert(tooltip, {"Рейды", CharInfo.RIO_RAID})
					-- tinsert(tooltip, {"M+", CharInfo.RIO_KEYS})
					-- tinsert(tooltip, {"PVP", CharInfo.RIO_PVPS})
				end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.CurrentKey then
					VivodCent = Empty_Zero(CharInfo.CurrentKey)
				end
				if CharInfo.ItemsInBag[205225] ~= 0 then
					VivodCent = VivodCent .. func_itemTexture(205225)..CharInfo.ItemsInBag[205225]
				end
				if CharInfo.ItemsInBag[205999] ~= 0 then
					VivodCent = VivodCent .. func_itemTexture(205999)..CharInfo.ItemsInBag[205999]
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			--7
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(204193)..Gray_Color..PLAYER_DIFFICULTY3..", M+ 1-5|r"
				if CharInfo.ItemsInBag[204075] >= 1 then
					tinsert(tooltip, {func_itemTexture(204075)..func_itemName(204075), CharInfo.ItemsInBag[204075]})
				end
				if (CharInfo.ItemsInBag[204193] ~= 0 or CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.CurrencyID[2409] ~= 0) and CharInfo.CurrencyID_maxQuantity[2409] ~= 0 then
					tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]})
				end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.ItemsInBag[204193] >= 1 then
					tinsert(tooltip, {func_itemTexture(204193)..func_itemName(204193), CharInfo.ItemsInBag[204193]})
					VivodCent = Green_Color..CharInfo.ItemsInBag[204193].."|r"
				end
				if CharInfo.ItemsInBag[204075] >= 15 then
					VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204075]/15)..")"
				end
				if CharInfo.CurrencyID[2409] ~= 0 and (CharInfo.CurrencyID[2409] == CharInfo.CurrencyID_maxQuantity[2409]) then
					VivodCent = VivodCent..Addon_Color.."+|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(204195)..Gray_Color..PLAYER_DIFFICULTY1..", M+ 6-10|r"
				if CharInfo.ItemsInBag[204076] >= 1 then
					tinsert(tooltip, {func_itemTexture(204076)..func_itemName(204076), CharInfo.ItemsInBag[204076]})
				end
				if (CharInfo.ItemsInBag[204195] ~= 0 or CharInfo.ItemsInBag[204076] ~= 0 or CharInfo.CurrencyID[2410] ~= 0) and CharInfo.CurrencyID_maxQuantity[2410] ~= 0 then
					tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]})
				end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.ItemsInBag[204195] >= 1 then
					tinsert(tooltip, {func_itemTexture(204195)..func_itemName(204195), CharInfo.ItemsInBag[204195]})
					VivodCent = Blue_Color..CharInfo.ItemsInBag[204195].."|r"
				end
				if CharInfo.ItemsInBag[204076] >= 15 then
					VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204076]/15)..")"
				end
				if CharInfo.CurrencyID[2410] ~= 0 and (CharInfo.CurrencyID[2410] == CharInfo.CurrencyID_maxQuantity[2410]) then
					VivodCent = VivodCent..Addon_Color.."+|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(204196)..Gray_Color..PLAYER_DIFFICULTY2..", M+ 11-15|r"
				if CharInfo.ItemsInBag[204077] >= 1 then
					tinsert(tooltip, {func_itemTexture(204077)..func_itemName(204077), CharInfo.ItemsInBag[204077]})
				end
				if (CharInfo.ItemsInBag[204196] ~= 0 or CharInfo.ItemsInBag[204077] ~= 0 or CharInfo.CurrencyID[2411] ~= 0) and CharInfo.CurrencyID_maxQuantity[2411] ~= 0 then
					tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]})
				end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.ItemsInBag[204196] >= 1 then
					tinsert(tooltip, {func_itemTexture(204196)..func_itemName(204196), CharInfo.ItemsInBag[204196]})
					VivodCent = Purple_Color..CharInfo.ItemsInBag[204196].."|r"
				end
				if CharInfo.ItemsInBag[204077] >= 15 then
					VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204077]/15)..")"
				end
				if CharInfo.CurrencyID[2411] ~= 0 and (CharInfo.CurrencyID[2411] == CharInfo.CurrencyID_maxQuantity[2411]) then
					VivodCent = VivodCent..Addon_Color.."+|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(204194)..Gray_Color..PLAYER_DIFFICULTY6..", M+ 16+|r"
				if CharInfo.ItemsInBag[204078] >= 1 then
					tinsert(tooltip, {func_itemTexture(204078)..func_itemName(204078), CharInfo.ItemsInBag[204078]})
				end
				if (CharInfo.ItemsInBag[204194] ~= 0 or CharInfo.ItemsInBag[204078] ~= 0 or CharInfo.CurrencyID[2412] ~= 0) and CharInfo.CurrencyID_maxQuantity[2412] ~= 0 then
					tinsert(tooltip, {"Weekly CAP: ", CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]})
				end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.ItemsInBag[204194] >= 1 then
					tinsert(tooltip, {func_itemTexture(204194)..func_itemName(204194), CharInfo.ItemsInBag[204194]})
					VivodCent = Orange_Color..CharInfo.ItemsInBag[204194].."|r"
				end
				if CharInfo.ItemsInBag[204078] >= 15 then
					VivodCent = VivodCent.. "(+"..math.floor(CharInfo.ItemsInBag[204078]/15)..")"
				end
				if CharInfo.CurrencyID[2412] ~= 0 and (CharInfo.CurrencyID[2412] == CharInfo.CurrencyID_maxQuantity[2412]) then
					VivodCent = VivodCent..Addon_Color.."+|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_itemTexture(204440)..func_itemName(204440)
				-- {func_itemName_NOCOLOR(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440]},
				-- {func_itemName_NOCOLOR(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717]},
				-- {func_itemName_NOCOLOR(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681]},
				-- {func_itemName_NOCOLOR(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682]},
				-- {func_itemName_NOCOLOR(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697]},
				if CharInfo.ItemsInBag[204440] ~= 0 then tinsert(tooltip, {func_itemName(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440]}) end
				if CharInfo.ItemsInBag[204717] ~= 0 then tinsert(tooltip, {func_itemName(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717]}) end
				if CharInfo.ItemsInBag[204681] ~= 0 then tinsert(tooltip, {func_itemName(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681]}) end
				if CharInfo.ItemsInBag[204682] ~= 0 then tinsert(tooltip, {func_itemName(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682]}) end
				if CharInfo.ItemsInBag[204697] ~= 0 then tinsert(tooltip, {func_itemName(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697]}) end
				-- if CharInfo.ItemsInBag[204440] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204440), func_itemTexture(204440)..CharInfo.ItemsInBag[204440].."|r"}) end
				-- if CharInfo.ItemsInBag[204717] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204717), func_itemTexture(204717)..CharInfo.ItemsInBag[204717].."|r"}) end
				-- if CharInfo.ItemsInBag[204681] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204681), func_itemTexture(204681)..CharInfo.ItemsInBag[204681].."|r"}) end
				-- if CharInfo.ItemsInBag[204682] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204682), func_itemTexture(204682)..CharInfo.ItemsInBag[204682].."|r"}) end
				-- if CharInfo.ItemsInBag[204697] == 0 then tinsert(tooltip, {"|cffc9c3aa"..func_itemName_NOCOLOR(204697), func_itemTexture(204697)..CharInfo.ItemsInBag[204697].."|r"}) end
				-- if CharInfo.ItemsInBag[204440] >= 1 then
				-- CL:SetText(VivodCent)
				-- end
				-- if CharInfo.ItemsInBag[204717] >=1 then
				-- tooltip = {{func_itemTexture(204717)..func_itemName(204717), CharInfo.ItemsInBag[204717]}, }
				-- end
				-- if CharInfo.ItemsInBag[204717] >=2 then
				-- CL:SetText(VivodCent.."|cffFF00FF(+"..(math.floor(CharInfo.ItemsInBag[204717]/2)) ..")|r")
				-- end
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.ItemsInBag[204440] >= 1 then
					VivodCent = VivodCent..func_itemTexture(204440)..CharInfo.ItemsInBag[204440]
				end
				if CharInfo.ItemsInBag[204717] >= 1 then
					VivodCent = VivodCent..func_itemTexture(204717)..CharInfo.ItemsInBag[204717]
				end
				if CharInfo.ItemsInBag[204681] >= 1 then
					VivodCent = VivodCent..func_itemTexture(204681)..CharInfo.ItemsInBag[204681]
				end
				if CharInfo.ItemsInBag[204682] >= 1 then
					VivodCent = VivodCent..func_itemTexture(204682)..CharInfo.ItemsInBag[204682]
				end
				if CharInfo.ItemsInBag[204697] >= 1 then
					VivodCent = VivodCent..func_itemTexture(204697)..CharInfo.ItemsInBag[204697]
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodLeft = func_currencyicon(2533)..func_currencyName(2533)
				-- ТЕКСТ В ЦЕНТРЕ
				if CharInfo.CurrencyID[2533] ~= 0 then
					VivodCent = func_currencyicon(2533)..CharInfo.CurrencyID[2533]
				end
				if CharInfo.CurrencyID[2533] < CharInfo.CurrencyID_maxQuantity[2533] and CharInfo.needReset then
					VivodCent = func_currencyicon(2533)..CharInfo.CurrencyID[2533]+1
				end
				if CharInfo.CurrencyID[2533] == CharInfo.CurrencyID_maxQuantity[2533] then
					VivodCent = Addon_Color..VivodCent.."|r"
				end
				if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.CurrencyID[2533] < 8 then
					VivodCent = Red_Color..VivodCent .."|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Kyri_Color_r, Kyri_Color_g, Kyri_Color_b)
				if CharInfo.Shadowland[9] == 1 then
					BG:SetColorTexture(Kyri_Color_r, Kyri_Color_g, Kyri_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[1] then
					VivodLeft = func_texturefromIcon(3257748)..Kyri_Color..L["Kyrian"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[1])
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Necr_Color_r, Necr_Color_g, Necr_Color_b)
				if CharInfo.Shadowland[9] == 4 then
					BG:SetColorTexture(Necr_Color_r, Necr_Color_g, Necr_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[7] then
					VivodLeft = func_texturefromIcon(3257749)..Necr_Color..L["Necrolord"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[7])
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(NFae_Color_r, NFae_Color_g, NFae_Color_b)
				if CharInfo.Shadowland[9] == 3 then
					BG:SetColorTexture(NFae_Color_r, NFae_Color_g, NFae_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[5] then
					VivodLeft = func_texturefromIcon(3257750)..NFae_Color..L["Night Fae"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[5])
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Vent_Color_r, Vent_Color_g, Vent_Color_b)
				if CharInfo.Shadowland[9] == 2 then
					BG:SetColorTexture(Vent_Color_r, Vent_Color_g, Vent_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[3] then
					VivodLeft = func_texturefromIcon(3257751)..Vent_Color..L["Venthyr"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[3])
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Kyri_Color_r, Kyri_Color_g, Kyri_Color_b)
				if CharInfo.Shadowland[9] == 1 then
					BG:SetColorTexture(Kyri_Color_r, Kyri_Color_g, Kyri_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[2] then
					VivodLeft = func_texturefromIcon(3257748)..Kyri_Color..L["Kyrian"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[2])
				end
				if CharInfo.Shadowland[2] and CharInfo.Shadowland[2] < 1000 then
					VivodCent = Gray_Color..VivodCent.."|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Necr_Color_r, Necr_Color_g, Necr_Color_b)
				if CharInfo.Shadowland[9] == 4 then
					BG:SetColorTexture(Necr_Color_r, Necr_Color_g, Necr_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[8] then
					VivodLeft = func_texturefromIcon(3257749)..Necr_Color..L["Necrolord"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[8])
				end
				if CharInfo.Shadowland[8] and CharInfo.Shadowland[8] < 1000 then
					VivodCent = Gray_Color..VivodCent.."|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(NFae_Color_r, NFae_Color_g, NFae_Color_b)
				if CharInfo.Shadowland[9] == 3 then
					BG:SetColorTexture(NFae_Color_r, NFae_Color_g, NFae_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[6] then
					VivodLeft = func_texturefromIcon(3257750)..NFae_Color..L["Night Fae"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[6])
				end
				if CharInfo.Shadowland[6] and CharInfo.Shadowland[6] < 1000 then
					VivodCent = Gray_Color..VivodCent.."|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				CL:SetTextColor(Vent_Color_r, Vent_Color_g, Vent_Color_b)
				if CharInfo.Shadowland[9] == 2 then
					BG:SetColorTexture(Vent_Color_r, Vent_Color_g, Vent_Color_b, .2)
				else
					BG:SetColorTexture(0,0,0,0)
				end
				if CharInfo.Shadowland[4] then
					VivodLeft = func_texturefromIcon(3257751)..Vent_Color..L["Venthyr"].."|r"
					VivodCent = Empty_Zero(CharInfo.Shadowland[4])
				end
				if CharInfo.Shadowland[4] and CharInfo.Shadowland[4] < 1000 then
					VivodCent = Gray_Color..VivodCent.."|r"
				end
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodCent = Empty_Zero(CharInfo.CurrencyID[2009])
				VivodLeft = func_currencyicon(2009)..func_currencyName(2009)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodCent = Empty_Zero(CharInfo.CurrencyID[1906])
				VivodLeft = func_currencyicon(1906)..func_currencyName(1906)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodCent = Empty_Zero(CharInfo.CurrencyID[1828])
				VivodLeft = func_currencyicon(1828)..func_currencyName(1828)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				VivodCent = Empty_Zero(CharInfo.CurrencyID[1979])
				VivodLeft = func_currencyicon(1979)..func_currencyName(1979)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= NONE then
					VivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				VivodLeft = func_texturefromIcon(4074774)..func_questName(66042)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ZMWBAntros_count ~= NONE then
					VivodCent = CharInfo.Octopussy_SL_Weekly_ZMWBAntros_count
				end
				VivodLeft = func_texturefromIcon(3528312)..func_questName(65143)
				return VivodCent, VivodLeft
		end)
	end
	----------------------------------------------------------------
	if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
		tinsert(table_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local VivodCent, VivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= NONE then
					VivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				VivodLeft = func_currencyicon(1813)..func_questName(61981)
				return VivodCent, VivodLeft
		end)
	end
	-- ВАЛЮТА
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			VivodCent = Gray_Color..CURRENCY.."|r"
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Dragonflight".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(2245)..func_currencyName(2245), CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]} --Драконьи камни
				tooltip[#tooltip+1] = {func_currencyicon(2122)..func_currencyName(2122), CharInfo.CurrencyID[2122]} --Печать бури
				tooltip[#tooltip+1] = {func_currencyicon(2118)..func_currencyName(2118), CharInfo.CurrencyID[2118]} --Энергия стихий
				tooltip[#tooltip+1] = {func_currencyicon(2003)..func_currencyName(2003), CharInfo.CurrencyID[2003]} --Припасы Драконьих островов
				if CharInfo.CurrencyID[2245] ~= 0 then
					VivodCent = func_currencyicon(2245)..Empty_Zero(CharInfo.CurrencyID[2245])
				end
				if CharInfo.CurrencyID[2245] == CharInfo.CurrencyID_maxQuantity[2245] then
					VivodCent = Addon_Color..VivodCent.."|r"
				end
			end
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Shadowlands".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(2009)..func_currencyName(2009), CharInfo.CurrencyID[2009]}
				tooltip[#tooltip+1] = {func_currencyicon(1906)..func_currencyName(1906), CharInfo.CurrencyID[1906]}
				tooltip[#tooltip+1] = {func_currencyicon(1828)..func_currencyName(1828), CharInfo.CurrencyID[1828]}
				tooltip[#tooltip+1] = {func_currencyicon(1977)..func_currencyName(1977), CharInfo.CurrencyID[1977]}
				tooltip[#tooltip+1] = {func_currencyicon(1813)..func_currencyName(1813), CharInfo.CurrencyID[1813].."/"..CharInfo.CurrencyID_maxQuantity[1813]} -- Запасенная анима
				tooltip[#tooltip+1] = {func_currencyicon(1979)..func_currencyName(1979), CharInfo.CurrencyID[1979]}
				tooltip[#tooltip+1] = {func_currencyicon(1904)..func_currencyName(1904), CharInfo.CurrencyID[1904].."/"..CharInfo.CurrencyID_maxQuantity[1904]} -- Знания о Башне
				tooltip[#tooltip+1] = {func_currencyicon(1819)..func_currencyName(1819), CharInfo.CurrencyID[1819]}
				tooltip[#tooltip+1] = {func_currencyicon(1931)..func_currencyName(1931), CharInfo.CurrencyID[1931]}
				tooltip[#tooltip+1] = {func_currencyicon(1767)..func_currencyName(1767), CharInfo.CurrencyID[1767]}
				tooltip[#tooltip+1] = {func_currencyicon(1885)..func_currencyName(1885), CharInfo.CurrencyID[1885]}
				tooltip[#tooltip+1] = {func_currencyicon(1820)..func_currencyName(1820), CharInfo.CurrencyID[1820].."/"..CharInfo.CurrencyID_maxQuantity[1820]} -- Насыщенный рубин
				tooltip[#tooltip+1] = {func_currencyicon(1816)..func_currencyName(1816), CharInfo.CurrencyID[1816]}
				if CharInfo.Possible_Anima == 0 and CharInfo.Possible_CatalogedResearch == 0 then
					VivodCent = Gray_Color..CURRENCY.."|r"
				end
				if CharInfo.Possible_Anima ~= 0 then
					VivodCent = VivodCent..Blue_Color..CharInfo.Possible_Anima.."|r"
				end
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					VivodCent = VivodCent.." "..Rift_Color..CharInfo.Possible_CatalogedResearch.."|r"
				end
				--Korthia
				if CharInfo.Octo_Table_QuestID[64367] ~= Addon_Color.."Done|r" then
					tooltip[#tooltip+1] = {func_itemTexture(187136)..func_itemName(187136), Rift_Color.."(Korthia)|r".."Нужно купить +50%".. func_currencyicon(1931)}
					VivodCent = VivodCent..Rift_Color.."-".."|r"
				end
				-- ZM
				if CharInfo.Octo_Table_QuestID[65282] ~= Addon_Color.."Done|r" then
					tooltip[#tooltip+1] = {func_itemTexture(188793)..func_itemName(188793), Cyan_Color.."(ZerethMortis)|r".."Нужно купить +50%".. func_currencyicon(1979)}
					VivodCent = VivodCent..Cyan_Color.."-".."|r"
				end
			end
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_BattleforAzeroth then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Battle for Azeroth".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(1580)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(1580), CharInfo.CurrencyID[1580].."/"..CharInfo.CurrencyID_maxQuantity[1580]} --Печать судьбы воина
				tooltip[#tooltip+1] = {func_currencyicon(1803)..func_currencyName(1803), CharInfo.CurrencyID[1803]}
				tooltip[#tooltip+1] = {func_currencyicon(1721)..func_currencyName(1721), CharInfo.CurrencyID[1721]}
				tooltip[#tooltip+1] = {func_currencyicon(1587)..func_currencyName(1587), CharInfo.CurrencyID[1587].."/"..CharInfo.CurrencyID_maxQuantity[1587]}
				tooltip[#tooltip+1] = {func_currencyicon(1299)..func_currencyName(1299), CharInfo.CurrencyID[1299].."/"..CharInfo.CurrencyID_maxQuantity[1299]}
				tooltip[#tooltip+1] = {func_currencyicon(1565)..func_currencyName(1565), CharInfo.CurrencyID[1565].."/"..CharInfo.CurrencyID_maxQuantity[1565]}
				tooltip[#tooltip+1] = {func_currencyicon(1715)..func_currencyName(1715), CharInfo.CurrencyID[1715].."/"..CharInfo.CurrencyID_maxQuantity[1715]}
				tooltip[#tooltip+1] = {func_currencyicon(1755)..func_currencyName(1755), CharInfo.CurrencyID[1755]}
				tooltip[#tooltip+1] = {func_currencyicon(1710)..func_currencyName(1710), CharInfo.CurrencyID[1710]}
				if CharInfo.Faction == "Horde" then
					tooltip[#tooltip+1] = {func_currencyicon(1716)..func_currencyName(1716), CharInfo.CurrencyID[1716]}
				else
					tooltip[#tooltip+1] = {func_currencyicon(1717)..func_currencyName(1717), CharInfo.CurrencyID[1717]}
				end
				tooltip[#tooltip+1] = {func_currencyicon(1560)..func_currencyName(1560), CharInfo.CurrencyID[1560]}
				tooltip[#tooltip+1] = {func_currencyicon(1719)..func_currencyName(1719), CharInfo.CurrencyID[1719]}
				tooltip[#tooltip+1] = {func_currencyicon(1718)..func_currencyName(1718), CharInfo.CurrencyID[1718]}
			end
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_Legion then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Legion".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(1273)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(1273), CharInfo.CurrencyID[1273].."/"..CharInfo.CurrencyID_maxQuantity[1273]} --Печать сломанной судьбы
			end
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_WarlordsofDraenor then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Warlords of Draenor".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(994)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(994), CharInfo.CurrencyID[994].."/"..CharInfo.CurrencyID_maxQuantity[994]} --Печать закаленной судьбы
				tooltip[#tooltip+1] = {func_currencyicon(1129)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(1129), CharInfo.CurrencyID[1129].."/"..CharInfo.CurrencyID_maxQuantity[1129]} --Печать закаленной судьбы
			end
			----------------------------------------------------------------
			if Octo_ToDo_DragonflyVars.config.LINE_MistsofPandaria then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Mists of Pandaria".."|r", " "}
				tooltip[#tooltip+1] = {func_currencyicon(697)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(697), CharInfo.CurrencyID[697].."/"..CharInfo.CurrencyID_maxQuantity[697]} --Большой амулет удачи
				tooltip[#tooltip+1] = {func_currencyicon(776)..Blue_Color.."("..L["Coins"]..")|r"..func_currencyName(776), CharInfo.CurrencyID[776].."/"..CharInfo.CurrencyID_maxQuantity[776]} --Закаленная в бою печать
			end
			----------------------------------------------------------------
			if #tooltip > 0 then
				tooltip[#tooltip+1] = {" ", " "}
			end
			tooltip[#tooltip+1] = {Blue_Color..L["Other"].."|r", " "}
			tooltip[#tooltip+1] = {func_currencyicon(2032)..func_currencyName(2032), func_currencyquantity(2032)}
			tooltip[#tooltip+1] = {func_currencyicon(81)..func_currencyName(81), CharInfo.CurrencyID[81]}
			tooltip[#tooltip+1] = {func_currencyicon(1379)..func_currencyName(1379), CharInfo.CurrencyID[1379]}
			tooltip[#tooltip+1] = {func_currencyicon(515)..func_currencyName(515), CharInfo.CurrencyID[515]}
			tooltip[#tooltip+1] = {func_currencyicon(402)..func_currencyName(402), CharInfo.CurrencyID[402]}
			tooltip[#tooltip+1] = {func_currencyicon(1401)..func_currencyName(1401), CharInfo.CurrencyID[1401]}
			tooltip[#tooltip+1] = {func_currencyicon(1388)..func_currencyName(1388), CharInfo.CurrencyID[1388]}
			tooltip[#tooltip+1] = {" "," "}
			tooltip[#tooltip+1] = {Blue_Color..GROUP_FINDER.."|r",""}
			tooltip[#tooltip+1] = {func_currencyicon(1166)..func_currencyName(1166), CharInfo.CurrencyID[1166]} --Искаженный временем знак
			if #tooltip > 0 then
				tooltip[#tooltip+1] = {" ", " "}
			end
			tooltip[#tooltip+1] = {Blue_Color.."PvP".."|r", " "}
			tooltip[#tooltip+1] = {func_currencyicon(1602)..func_currencyName(1602), CharInfo.CurrencyID[1602].."/"..CharInfo.CurrencyID_maxQuantity[1602]} --Очки завоевания
			tooltip[#tooltip+1] = {func_currencyicon(1792)..func_currencyName(1792), CharInfo.CurrencyID[1792].."/"..CharInfo.CurrencyID_maxQuantity[1792]} --Честь
			tooltip[#tooltip+1] = {func_currencyicon(2123)..func_currencyName(2123), CharInfo.CurrencyID[2123]} -- Кровавые жетоны
			tooltip[#tooltip+1] = {func_currencyicon(391)..func_currencyName(391), CharInfo.CurrencyID[391]} -- Рекомендательный значок Тол Барада
			return VivodCent, VivodLeft
	end)
	-- РЕПУТАЦИЯ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
				tinsert(tooltip, {func_reputationName(2507), CharInfo.reputationID[2507]})
				tinsert(tooltip, {func_reputationName(2503), CharInfo.reputationID[2503]})
				tinsert(tooltip, {func_reputationName(2511), CharInfo.reputationID[2511]})
				tinsert(tooltip, {func_reputationName(2510), CharInfo.reputationID[2510]})
				tinsert(tooltip, {func_reputationName(2564), CharInfo.reputationID[2564]})
				for k,v in ipairs (Octo_Table_itemID_Reputation) do
					if CharInfo.ItemsInBag[v] ~= 0 then
						tinsert(tooltip, {func_itemTexture(v)..func_itemName(v), CharInfo.ItemsInBag[v]})
					end
				end
			end
			if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
				tinsert(tooltip, {func_reputationName(2432), CharInfo.reputationID[2432]})
				tinsert(tooltip, {func_reputationName(2413), CharInfo.reputationID[2413]})
				tinsert(tooltip, {func_reputationName(2464), CharInfo.reputationID[2464]})
				tinsert(tooltip, {func_reputationName(2465), CharInfo.reputationID[2465]})
				tinsert(tooltip, {func_reputationName(2472), CharInfo.reputationID[2472]})
				tinsert(tooltip, {func_reputationName(2470), CharInfo.reputationID[2470]})
				tinsert(tooltip, {func_reputationName(2439), CharInfo.reputationID[2439]})
				tinsert(tooltip, {func_reputationName(2410), CharInfo.reputationID[2410]})
				tinsert(tooltip, {func_reputationName(2407), CharInfo.reputationID[2407]})
				tinsert(tooltip, {func_reputationName(2478), CharInfo.reputationID[2478]})
				tinsert(tooltip, {func_reputationName(2462), CharInfo.reputationID[2462]})
				tinsert(tooltip, {func_reputationName(2445), CharInfo.reputationID[2445]})
				tinsert(tooltip, {func_reputationName(2460), CharInfo.reputationID[2460]})
				tinsert(tooltip, {func_reputationName(2458), CharInfo.reputationID[2458]})
				tinsert(tooltip, {func_reputationName(2453), CharInfo.reputationID[2453]})
				tinsert(tooltip, {func_reputationName(2455), CharInfo.reputationID[2455]})
				tinsert(tooltip, {func_reputationName(2463), CharInfo.reputationID[2463]})
			end
			-- ТЕКСТ В ЦЕНТРЕ
			VivodCent = Gray_Color..REPUTATION.."|r"
			return VivodCent, VivodLeft
	end)
	-- ЗАДАНИЯ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight then
				tooltip[#tooltip+1] = {Blue_Color.."Dragonflight".."|r", " "}
				tooltip[#tooltip+1] = {ToDragonbaneKeepTimer()..CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_name, CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
				tooltip[#tooltip+1] = {GrandHuntsTimer()..CharInfo.Octopussy_DF_Weekly_TheGrandHunt_name, CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
				tooltip[#tooltip+1] = {CommunityFeastTimer()..CharInfo.Octopussy_DF_Weekly_Feast_name, CharInfo.Octopussy_DF_Weekly_Feast_count}
				tooltip[#tooltip+1] = {PrimalStormsTimer()..CharInfo.Octopussy_DF_Weekly_StormsFury_name, CharInfo.Octopussy_DF_Weekly_StormsFury_count}
				tooltip[#tooltip+1] = {ResearchersUnderFireTimer()..CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_name, CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_3kREP_name, CharInfo.Octopussy_DF_Weekly_3kREP_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_name, CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_name, CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_name, CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_PVP_name, CharInfo.Octopussy_DF_Weekly_PVP_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_StormBoundChest_name, CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_Timewalk500CURRENCY_name, CharInfo.Octopussy_DF_Weekly_Timewalk500CURRENCY_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_name, CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_WB_name, CharInfo.Octopussy_DF_Weekly_WB_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_WeekendEvent_name, CharInfo.Octopussy_DF_Weekly_WeekendEvent_count}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["Zaralek Cavern"].."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_name, CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_name, CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Weekly_ZaralekCavernWBZaqaliElders_name, CharInfo.Octopussy_DF_Weekly_ZaralekCavernWBZaqaliElders_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Daily_ZaralekCavernEvents_name, CharInfo.Octopussy_DF_Daily_ZaralekCavernEvents_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Daily_ZaralekCavernRares_name, CharInfo.Octopussy_DF_Daily_ZaralekCavernRares_count}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["The Forbidden Reach"].."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_DF_Daily_TheForbiddenReachRares_name, CharInfo.Octopussy_DF_Daily_TheForbiddenReachRares_count}
			end
			if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color.."Shadowlands".."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WB_name, CharInfo.Octopussy_SL_Weekly_WB_count}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["Zereth Mortis"].."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_name, CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ZMWBAntros_name, CharInfo.Octopussy_SL_Weekly_ZMWBAntros_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMGetLockStatus_name, CharInfo.Octopussy_SL_Daily_ZMGetLockStatus_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_name, CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_name, CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRares_name, CharInfo.Octopussy_SL_Daily_ZMRares_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_name, CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMTREASURES_name, CharInfo.Octopussy_SL_Daily_ZMTREASURES_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMworldQuests_name, CharInfo.Octopussy_SL_Daily_ZMworldQuests_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMConcordance_name, CharInfo.Octopussy_SL_Once_ZMConcordance_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_name, CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_count}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["Korthia"].."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_name, CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaRares_name, CharInfo.Octopussy_SL_Weekly_KorthiaRares_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaMobs_name, CharInfo.Octopussy_SL_Daily_KorthiaMobs_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_name, CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaCollection_name, CharInfo.Octopussy_SL_Daily_KorthiaCollection_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_name, CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_name, CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_name, CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRIFTRiftboundCache_name, CharInfo.Octopussy_SL_Daily_KorthiaRIFTRiftboundCache_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaRIFTStolenAnimaVessel_name, CharInfo.Octopussy_SL_Weekly_KorthiaRIFTStolenAnimaVessel_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRIFTSpectralBoundChest_name, CharInfo.Octopussy_SL_Daily_KorthiaRIFTSpectralBoundChest_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRIFTZovaalsVault_name, CharInfo.Octopussy_SL_Daily_KorthiaRIFTZovaalsVault_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaITEMResearchReportAncientShrines_name, CharInfo.Octopussy_SL_Weekly_KorthiaITEMResearchReportAncientShrines_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportAdaptiveAlloys_name, CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportAdaptiveAlloys_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportAllSeeingCrystal_name, CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportAllSeeingCrystal_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportFirstAlloys_name, CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportFirstAlloys_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportRelicExaminationTechniques_name, CharInfo.Octopussy_SL_Once_KorthiaITEMResearchReportRelicExaminationTechniques_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseBondsofStygiainMortals_name, CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseBondsofStygiainMortals_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseRecognizingStygiaanditsUses_name, CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseRecognizingStygiaanditsUses_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseRelicsAboundintheShadowlands_name, CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseRelicsAboundintheShadowlands_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseTheStudyofAnimaandHarnessingEveryDrop_name, CharInfo.Octopussy_SL_Once_KorthiaITEMTreatiseTheStudyofAnimaandHarnessingEveryDrop_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_KorthiaITEMVaultAnimaTracker_name, CharInfo.Octopussy_SL_Once_KorthiaITEMVaultAnimaTracker_count}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["Maw"].."|r", " "}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawMorgeth_name, CharInfo.Octopussy_SL_Weekly_MawMorgeth_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
				tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
			end
			if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {Blue_Color..L["Class quests"].."|r"," "}
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {CharInfo.Octopussy_WotLK_Once_Shadowmourne_name, CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {CharInfo.Octopussy_MoP_Once_Warlock_name, CharInfo.Octopussy_MoP_Once_Warlock_count}
				end
			end
			VivodCent = Gray_Color..QUESTS_LABEL.."|r"
			return VivodCent, VivodLeft
	end)
	-- ПРЕДМЕТЫ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			tooltip[#tooltip+1] = {" "," "}
			-- ТЕКСТ В ЦЕНТРЕ
			for k, v in ipairs(Octo_Table_itemID_ALL) do
				local count = tonumber(CharInfo.ItemsInBag[v])
				if count ~= 0 then
					VivodCent = Gray_Color..ITEMS.."|r"
					tooltip[#tooltip+1] = {func_itemTexture(v)..func_itemName(v), count}
				end
			end
			for k, v in ipairs(CharInfo.VOID_STORAGE_PAGE1) do
				if v ~= 0 then
					tooltip[#tooltip+1] = {func_itemTexture(CharInfo.VOID_STORAGE_PAGE1[k])..func_itemName(CharInfo.VOID_STORAGE_PAGE1[k])}
				end
			end
			for k, v in ipairs(CharInfo.VOID_STORAGE_PAGE2) do
				if v ~= 0 then
					tinsert(tooltip,{func_itemTexture(CharInfo.VOID_STORAGE_PAGE2[k])..func_itemName(CharInfo.VOID_STORAGE_PAGE2[k])})
				end
			end
			return VivodCent, VivodLeft
	end)
	-- ПРОФЕССИИ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			if CharInfo.prof1 ~= 0 or CharInfo.prof2 ~= 0 then
				tooltip[#tooltip+1]= {Empty_Zero(CharInfo.profID_prof1.icon)..Purple_Color..Empty_Zero(CharInfo.profID_prof1.name).."|r"}
				tooltip[#tooltip+1]= {"Сундуки", CharInfo.profID_prof1.chest.chest_count_prof1.."/"..CharInfo.profID_prof1.chest.questReq}
				tooltip[#tooltip+1]= {"Лут", CharInfo.profID_prof1.drops.drops_count_prof1.."/"..CharInfo.profID_prof1.drops.questReq}
				tooltip[#tooltip+1]= {"Квест", CharInfo.profID_prof1.profQuest.profQuest_count_prof1.."/"..CharInfo.profID_prof1.profQuest.questReq}
				tooltip[#tooltip+1]= {"Трактаты", CharInfo.profID_prof1.treatise.treatise_count_prof1.."/"..CharInfo.profID_prof1.treatise.questReq}
				tooltip[#tooltip+1]= {"Крафт", CharInfo.profID_prof1.craftOrder.craftOrder_count_prof1.."/"..CharInfo.profID_prof1.craftOrder.questReq}
				tooltip[#tooltip+1]= {" ", " "}
				tooltip[#tooltip+1]= {Empty_Zero(CharInfo.profID_prof2.icon)..Purple_Color..Empty_Zero(CharInfo.profID_prof2.name).."|r"}
				tooltip[#tooltip+1]= {"Сундуки", CharInfo.profID_prof2.chest.chest_count_prof2.."/"..CharInfo.profID_prof2.chest.questReq}
				tooltip[#tooltip+1]= {"Лут", CharInfo.profID_prof2.drops.drops_count_prof2.."/"..CharInfo.profID_prof2.drops.questReq}
				tooltip[#tooltip+1]= {"Квест", CharInfo.profID_prof2.profQuest.profQuest_count_prof2.."/"..CharInfo.profID_prof2.profQuest.questReq}
				tooltip[#tooltip+1]= {"Трактаты", CharInfo.profID_prof2.treatise.treatise_count_prof2.."/"..CharInfo.profID_prof2.treatise.questReq}
				tooltip[#tooltip+1]= {"Крафт", CharInfo.profID_prof2.craftOrder.craftOrder_count_prof2.."/"..CharInfo.profID_prof2.craftOrder.questReq}
				tooltip[#tooltip+1]= {" ", " "}
			end
			if CharInfo.ItemsInBag[204186] >= 1 then tinsert(tooltip, {func_itemTexture(204186)..func_itemName(204186), CharInfo.ItemsInBag[204186]}) end
			if CharInfo.ItemsInBag[204187] >= 1 then tinsert(tooltip, {func_itemTexture(204187)..func_itemName(204187), CharInfo.ItemsInBag[204187]}) end
			if CharInfo.ItemsInBag[204188] >= 1 then tinsert(tooltip, {func_itemTexture(204188)..func_itemName(204188), CharInfo.ItemsInBag[204188]}) end
			if CharInfo.ItemsInBag[190453] >= 1 then tinsert(tooltip, {func_itemTexture(190453)..func_itemName(190453), CharInfo.ItemsInBag[190453]}) end
			if CharInfo.ItemsInBag[191784] >= 1 then tinsert(tooltip, {func_itemTexture(191784)..func_itemName(191784), CharInfo.ItemsInBag[191784]}) end
			if CharInfo.ItemsInBag[204985] >= 1 then tinsert(tooltip, {func_itemTexture(204985)..func_itemName(204985), CharInfo.ItemsInBag[204985]}) end
			if CharInfo.ItemsInBag[204715] >= 1 then tinsert(tooltip, {func_itemTexture(204715)..func_itemName(204715), CharInfo.ItemsInBag[204715]}) end
			if CharInfo.ItemsInBag[190456] >= 1 then tinsert(tooltip, {func_itemTexture(190456)..func_itemName(190456), CharInfo.ItemsInBag[190456]}) end
			if CharInfo.ItemsInBag[199197] >= 1 then tinsert(tooltip, {func_itemTexture(199197)..func_itemName(199197), CharInfo.ItemsInBag[199197]}) end
			-- ТЕКСТ В ЦЕНТРЕ
			if CharInfo.profID_prof1.icon ~= 0 then
				VivodCent = CharInfo.profID_prof1.icon
			end
			if CharInfo.profID_prof2.icon ~= 0 then
				VivodCent = VivodCent.. " "..CharInfo.profID_prof2.icon
			end
			return VivodCent, VivodLeft
	end)
	-- MONEY
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			local curServerShort = GetRealmName()
			local text = (curServerShort):gsub("-", " "):gsub("'", " ")
			local a, b = strsplit(" ", text)
			if b then
				curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
			end
			-- CL:SetFont(curFontTTF, curFontSize-1, curFontOutline)
			if CharInfo.Money then
				VivodLeft = curServerShort..": "..GetCoinTextureString(TotalMoney-TotalMoney % 10000)
			end
			if TotalMoneyAllServer > TotalMoney and CharInfo.Money ~= 0 then
				VivodLeft = VivodLeft.." ("..GetCoinTextureString(TotalMoneyAllServer-TotalMoneyAllServer%10000)..")"
			end
			-- ТЕКСТ В ЦЕНТРЕ
			if CharInfo.Money then
				VivodCent = GetCoinTextureString(CharInfo.Money - CharInfo.Money % 10000)
			end
			if CharInfo.Money - CharInfo.Money % 10000 < 10000000 then -- меньше тысячи
				VivodCent = Gray_Color..VivodCent.."|r"
			end
			if CharInfo.PlayerReagentnumSlots == 0 then VivodCent = VivodCent..Red_Color.."-".."|r" end
			return Yellow_Color..VivodCent.."|r", VivodLeft
	end)
	-- УРОВЕНЬ ПРЕДМЕТОВ / ИТЕМ ЛЕВЕЛЛ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			--CL:SetText(format("|cff%s%.1f|r", CharInfo.avgItemLevel >= 430 and "00ff00" or CharInfo.avgItemLevel >= 400 and "ffff00" or "ff0000", CharInfo.avgItemLevel))
			VivodLeft = LFG_LIST_ITEM_LEVEL_INSTR_SHORT
			local pvpcolor = Red_Color
			if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
				if CharInfo.avgItemLevelEquipped > 440 then
					pvpcolor = Green_Color
				elseif CharInfo.avgItemLevelEquipped > 400 then
					pvpcolor = Yellow_Color
				end
			end
			-- ТЕКСТ В ЦЕНТРЕ
			if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
				VivodCent = pvpcolor..CharInfo.avgItemLevelEquipped
				if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
					VivodCent = VivodCent.."/"..CharInfo.avgItemLevel.."|r"
				end
				if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
					VivodCent = VivodCent..Addon_Color.."++|r"
					tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
				end
			end
			return VivodCent, VivodLeft
	end)
	-- ЛОГИН ТАЙМ
	tinsert(table_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local VivodCent, VivodLeft = "", ""
			if CharInfo.currentMountItemID ~= 0 then
				tinsert(tooltip, {func_itemTexture(CharInfo.currentMountItemID)..func_itemName(CharInfo.currentMountItemID)})
			end
			if CharInfo.CurrentLocation then
				tinsert(tooltip, {L["Current Location"],CharInfo.CurrentLocation})
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tinsert(tooltip, {QUESTS_LABEL,CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept})
			end
			if CharInfo.totalSlots ~= 0 then
				tinsert(tooltip, {L["Bags"],CharInfo.usedSlots.."/"..CharInfo.totalSlots})
			end
			if CharInfo.totalSlotsBANK ~= 0 then
				tinsert(tooltip, {L["Bank"],CharInfo.usedSlotsBANK.."/"..CharInfo.totalSlotsBANK})
			end
			-- ТЕКСТ В ЦЕНТРЕ
			if CharInfo.pizdaDate ~= 0 and CharInfo.pizdaDate ~= 0 then
				CL:SetFont(curFontTTF, curFontSize-1, curFontOutline)
				VivodCent = (CharInfo.needReset and Red_Color or White_Color)..CharInfo.pizdaDate.."\n"..CharInfo.pizdaHours
			end
			return VivodCent, VivodLeft
	end)
	-------
	----------------------------------------------------------------
end
function Octo_ToDo_DragonflyOnLoad()
	EventFrame = CreateFrame("FRAME", AddonTitle..GenerateUniqueID())
	EventFrame:RegisterEvent("VARIABLES_LOADED")
	EventFrame:RegisterEvent("PLAYER_LOGIN")
	EventFrame:RegisterEvent("PLAYER_MONEY")
	EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	EventFrame:RegisterEvent("BAG_UPDATE")
	EventFrame:RegisterEvent("HEARTHSTONE_BOUND")
	EventFrame:RegisterEvent("ZONE_CHANGED")
	EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	EventFrame:RegisterEvent("QUEST_FINISHED")
	EventFrame:RegisterEvent("QUEST_COMPLETE")
	EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	EventFrame:RegisterEvent("PLAYER_LOGOUT")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EventFrame:RegisterEvent("COVENANT_CHOSEN")
	EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	EventFrame:RegisterEvent("BANKFRAME_OPENED")
	EventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	EventFrame:RegisterEvent("VOID_STORAGE_UPDATE")
	EventFrame:RegisterEvent("VOID_STORAGE_CONTENTS_UPDATE")
	EventFrame:RegisterEvent("VOID_TRANSFER_DONE")
	EventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
	EventFrame:RegisterEvent("SPELLS_CHANGED")
	EventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	-- -- EventFrame:RegisterEvent("VARIABLES_LOADED")
	-- EventFrame:RegisterEvent("ARENA_SEASON_WORLD_STATE")
	-- EventFrame:RegisterEvent("BATTLEFIELDS_CLOSED")
	-- EventFrame:RegisterEvent("BATTLEFIELDS_SHOW")
	-- EventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	-- EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	-- EventFrame:RegisterEvent("HONOR_LEVEL_UPDATE")
	-- EventFrame:RegisterEvent("HONOR_XP_UPDATE")
	-- EventFrame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
	-- EventFrame:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
	-- EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
	-- EventFrame:RegisterEvent("PVP_BRAWL_INFO_UPDATED")
	-- EventFrame:RegisterEvent("PVP_RATED_STATS_UPDATE")
	-- EventFrame:RegisterEvent("PVP_REWARDS_UPDATE")
	-- EventFrame:RegisterEvent("PVP_ROLE_UPDATE")
	-- EventFrame:RegisterEvent("PVP_TYPES_ENABLED")
	-- EventFrame:RegisterEvent("PVP_WORLDSTATE_UPDATE")
	-- EventFrame:RegisterEvent("PVPQUEUE_ANYWHERE_SHOW")
	-- EventFrame:RegisterEvent("PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE")
	-- EventFrame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	-- EventFrame:RegisterEvent("WEEKLY_REWARDS_ITEM_CHANGED")
	-- EventFrame:RegisterEvent("WEEKLY_REWARDS_UPDATE")
	-- EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	-- EventFrame:RegisterEvent("ZONE_CHANGED")
	local group = EventFrame:CreateAnimationGroup()
	-- group:SetScript('OnFinished', function() group:Play() end)
	-- group:Play()
	EventFrame:SetScript("OnEvent", function(...) Octo_ToDo_DragonflyOnEvent(...) end)
end
function UPGRADERANKS_Frame()
	UPGRADERANKS_Frame = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), UIParent, "BackdropTemplate")
	UPGRADERANKS_Frame:SetFrameStrata("FULLSCREEN")
	UPGRADERANKS_Frame:SetWidth(1024*scale*0.7111111111111111) -- Set these to whatever height/width is needed
	UPGRADERANKS_Frame:SetHeight(512*scale*0.7111111111111111) -- for your Texture
	UPGRADERANKS_Frame:SetBackdrop({
			-- bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 3,
	})
	UPGRADERANKS_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	UPGRADERANKS_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	local t = UPGRADERANKS_Frame:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\UPGRADERANKS.tga")
	t:SetAllPoints(UPGRADERANKS_Frame)
	UPGRADERANKS_Frame.texture = t
	UPGRADERANKS_Frame:SetPoint("CENTER", 0, 0)
	UPGRADERANKS_Frame:Hide()
end
-- local function CreateFrameUsableItems_OnEnter(self)
-- self.icon:SetVertexColor(1, 1, 1, 1)
-- end
-- local function CreateFrameUsableItems_OnLeave(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
-- GameTooltip:ClearLines()
-- GameTooltip:Hide()
-- end
-- local function CreateFrameUsableItems_OnEvent(self,event)
-- if event == "BAG_UPDATE" then
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetDesaturated(sufficiently)
-- self.icon:SetAlpha(sufficiently and .1 or 1)
-- elseif event == "PLAYER_REGEN_DISABLED" then
-- self:SetParent(UIParent)
-- self:ClearAllPoints()
-- self:Hide()
-- else
-- self:SetParent(Main_Frame)
-- self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
-- self:Show()
-- end
-- end
-- local function CreateFrameUsableItems_OnMouseDown(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 0, 0, sufficiently and .1 or 1)
-- end
-- local function CreateFrameUsableItems_OnMouseUp(self)
-- local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
-- self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
-- end
-- local function CreateFrameUsableItems(itemID, Texture, count, Ypos, r, g, b)
-- local Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
-- Button.itemID = itemID
-- Button.Texture = Texture
-- Button.count = count
-- Button.Ypos = Ypos
-- -- Button.r = r
-- -- Button.g = g
-- -- Button.b = b
-- Button:SetSize(curHeight, curHeight)
-- Button:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, Ypos)
-- Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
-- Button:SetBackdropBorderColor(r, g, b, 0.2)
-- Button:RegisterEvent("PLAYER_REGEN_DISABLED")
-- Button:RegisterEvent("PLAYER_REGEN_ENABLED")
-- Button:RegisterEvent("BAG_UPDATE")
-- Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
-- Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
-- Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
-- Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
-- Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
-- Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
-- Button:SetAttribute("type", "macro")
-- Button:SetAttribute("macrotext", "/use item:"..itemID)
-- local t = Button:CreateTexture(nil, "BACKGROUND")
-- Button.icon = t
-- t:SetTexture(Texture)--select(10, GetItemInfo(itemID)))
-- t:SetVertexColor(1, 1, 1, 1)
-- t:SetAllPoints(Button)
-- Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
-- return Button
-- end
local function CreateFrameExpansion_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameExpansion_OnLeave(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
end
local function CreateFrameExpansion_OnEvent(self,event)
	if event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(Main_Frame)
		self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
		self:Show()
	end
end
local function CreateFrameExpansion_OnMouseDown(self)
	self.icon:SetVertexColor(1, 0, 0, 1)
end
local function CreateFrameExpansion_OnMouseUp(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameExpansion(Expansion, Texture, Ypos, r, g, b)
	Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
	Button.Expansion = Expansion
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button:SetSize(curHeight, curHeight)
	Button:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, Ypos)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Button:SetBackdropBorderColor(r, g, b, 0.2)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:RegisterEvent("BAG_UPDATE")
	Button:HookScript("OnEvent", CreateFrameExpansion_OnEvent)
	Button:HookScript("OnEnter", CreateFrameExpansion_OnEnter)
	Button:HookScript("OnLeave", CreateFrameExpansion_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameExpansion_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameExpansion_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	-- Button:SetAttribute("type", "macro")
	-- Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)--select(10, GetItemInfo(itemID)))
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
	return Button
end
function Octo_ToDo_DragonflyCreateAltFrame()
	Main_Frame = CreateFrame("BUTTON", AddonTitle..GenerateUniqueID(), UIParent, "BackdropTemplate")
	Main_Frame:SetClampedToScreen(false)
	Main_Frame:SetFrameStrata("DIALOG")
	Main_Frame:SetPoint("TOP", 0, -257*scale)
	Main_Frame:SetBackdrop({
			--elvui
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
			--Стандартный
			-- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			-- edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			-- edgeSize = 16,
			-- insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	Main_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	--elvui
	Main_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	Main_Frame:SetScript("OnShow", function() Octo_ToDo_DragonflyAddDataToAltFrame()
	end)
	Main_Frame:EnableMouse(true)
	Main_Frame:SetMovable(true)
	Main_Frame:RegisterForDrag("LeftButton")
	Main_Frame:SetScript("OnDragStart", Main_Frame.StartMoving)
	Main_Frame:SetScript("OnDragStop", function() Main_Frame:StopMovingOrSizing() end)
	Main_Frame:RegisterForClicks("RightButtonUp")
	Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	--CloseButton
	Main_Frame.CloseButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.CloseButton:SetSize(curHeight, curHeight)
	Main_Frame.CloseButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, 0)
	Main_Frame.CloseButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.CloseButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(CLOSE) -- "Title"
			GameTooltip:Show()
	end)
	Main_Frame.CloseButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.CloseButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.CloseButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.CloseButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.CloseButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.CloseButton)
	Main_Frame.CloseButton:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:GetParent():Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	--OptionsButton
	Main_Frame.OptionsButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.OptionsButton:SetSize(curHeight, curHeight)
	Main_Frame.OptionsButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -30)
	Main_Frame.OptionsButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.OptionsButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			--GameTooltip:ClearLines()
			GameTooltip:AddLine(OPTIONS) -- "Title"
			GameTooltip:Show()
	end)
	Main_Frame.OptionsButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			--GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.OptionsButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.OptionsButton:SetScript("OnClick", function()
			if Main_Frame and Main_Frame:IsShown() then
				Main_Frame:Hide()
			end
			if SettingsPanel:IsVisible() and self:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(GlobalAddonName, true)
			end
	end)
	local t = Main_Frame.OptionsButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.OptionsButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\OptionsButton.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.OptionsButton)
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.MarkOfHonor_Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.MarkOfHonor_Button:SetSize(curHeight, curHeight)
	Main_Frame.MarkOfHonor_Button:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -60)
	Main_Frame.MarkOfHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.MarkOfHonor_Button:SetBackdropBorderColor(0, 0.44, 0.98, 1)
	Main_Frame.MarkOfHonor_Button:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[137642] and CharInfo.ItemsInBag[137642] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[137642])
					-- else
					-- Main_Frame.MarkOfHonor_Button:Hide()
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(0, 0.44, 0.98, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.MarkOfHonor_Button:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.MarkOfHonor_Button:CreateTexture(nil, "BACKGROUND")
	Main_Frame.MarkOfHonor_Button.icon = t
	t:SetTexture(1322720)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.MarkOfHonor_Button)
	-----------------------------------------------------
	-----------------------------------------------------
	Main_Frame.ZskeraVaultKeyButton = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.ZskeraVaultKeyButton:SetSize(curHeight, curHeight)
	Main_Frame.ZskeraVaultKeyButton:SetPoint("TOPRIGHT", Main_Frame, "TOPRIGHT", curHeight+1, -90)
	Main_Frame.ZskeraVaultKeyButton:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.ZskeraVaultKeyButton:SetBackdropBorderColor(.64, .21, .93, 1)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" "," ")
			for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
				if CharInfo.ItemsInBag[202196] and CharInfo.ItemsInBag[202196] ~= 0 then
					i = i + 1
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					local curServerShort = CharInfo.curServer
					local text = (curServerShort):gsub("-", " "):gsub("'", " ")
					local a, b = strsplit(" ", text)
					if b then
						curServerShort = WA_Utf8Sub(a, 1)..WA_Utf8Sub(b, 1):upper() else curServerShort = WA_Utf8Sub(a, 3):lower()
					end
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..curServerShort..")"),CharInfo.ItemsInBag[202196])
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" "," ")
			GameTooltip:Show()
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(.64, .21, .93, 1)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, .5)
			self.icon:SetVertexColor(1, 0, 0, .5)
	end)
	Main_Frame.ZskeraVaultKeyButton:SetScript("OnClick", function()
			Main_Frame:Hide()
	end)
	local t = Main_Frame.ZskeraVaultKeyButton:CreateTexture(nil, "BACKGROUND")
	Main_Frame.ZskeraVaultKeyButton.icon = t
	t:SetTexture(4909720)
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.ZskeraVaultKeyButton)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- ITEMID, count, Ypox, r, g, b
	-- CreateFrameUsableItems(204075, 5062636, 15, 0, .12, 1, 0)
	-- CreateFrameUsableItems(204076, 5062624, 15, -24, 0, .44, .98)
	-- CreateFrameUsableItems(204077, 5062642, 15, -48, .64, .21, .93)
	-- CreateFrameUsableItems(204078, 5062612, 15, -72, 1, .5, 0)
	-- CreateFrameUsableItems(204717, 442739, 2, -96, .85, .8, .5)
	-- Expansion, texture, Ypox, r,g,b
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- local qz = -21
	-- CreateFrameExpansion("Classic", 254652, qz*0, 104/255, 204/255, 239/255)
	-- CreateFrameExpansion("TBC", 236415, qz*1, 79/255, 1, 121/255)
	-- CreateFrameExpansion("WotLK", 630787, qz*2, 0, 163/255, 1)
	-- CreateFrameExpansion("Cata", 4622499, qz*3, 1, 179/255, 0)
	-- CreateFrameExpansion("MoP", 626190, qz*4, 0, 1, 186/255)
	-- CreateFrameExpansion("WoD", 236452, qz*5, 200/255, 100/255, 0)
	-- CreateFrameExpansion("Legion", 135794, qz*6, 30/255, 1, 0)
	-- CreateFrameExpansion("BfA", 2484334, qz*7, 100/255, 100/255, 1)
	-- CreateFrameExpansion("SL", 3586268, qz*8, 201/255, 195/255, 170/255)
	-- CreateFrameExpansion("DF", 4640492, qz*9, 232/255, 277/255, 121/255)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = Red_Color.."!!! ACHTUNG !!!|r\n".."Отменить все ("..numQuests..") задания?",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function()
			C_Timer.After(1,function()
					for i=1, numShownEntries do
						if numQuests ~= 0 then
							local questInfo = C_QuestLog.GetInfo(i)
							if questInfo then
								if (not questInfo.isHeader and not questInfo.isHidden) then
									print (Blue_Color..L["Abandon"].."|r"..Red_Color..questInfo.title.."|r")
									C_QuestLog.SetSelectedQuest(questInfo.questID)
									C_QuestLog.SetAbandonQuest()
									C_QuestLog.AbandonQuest()
								end
							end
						end
					end
					print (DONE)
			end)
		end,
	}
	-----------------------------------------------------
	Main_Frame.AbandonAllQuests = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "BackDropTemplate")
	Main_Frame.AbandonAllQuests:SetSize(curHeight, curHeight)
	Main_Frame.AbandonAllQuests:SetPoint("BOTTOMLEFT", Main_Frame, "BOTTOMRIGHT", 0, 0)
	Main_Frame.AbandonAllQuests:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Main_Frame.AbandonAllQuests:SetBackdropBorderColor(1, 0, 0, 0)
	Main_Frame.AbandonAllQuests:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["Abandon All Quests"].." ("..numQuests..")")
			GameTooltip:Show()
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1, 0, 0, 0.5)
	end)
	Main_Frame.AbandonAllQuests:SetScript("OnClick", function()
			StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
	end)
	local t = Main_Frame.AbandonAllQuests:CreateTexture(nil, "BACKGROUND")
	Main_Frame.AbandonAllQuests.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\SadKitty.tga")
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Main_Frame.AbandonAllQuests)
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- local className, classFilename, classId = UnitClass("PLAYER")
	-- local classColor = C_ClassColor.GetClassColor(classFilename)
	-- local r, g, b = classColor:GetRGB()
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, 0.2) --горизонт
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 0, #table_func_otrisovka do
		local fname, f
		if i ~= 0 then
			fname = "FrameLine"..i
			Main_Frame[fname] = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Main_Frame, "BackdropTemplate")
			f = Main_Frame[fname]
			f:SetHeight(curHeight)
			f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 0, -curHeight*i)
			-- f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 0+curWidthTitle, -curHeight*i)
			f:SetPoint("RIGHT")
			f:SetScript("OnEnter", FrameLine_OnEnter)
			f:SetScript("OnLeave", FrameLine_OnLeave)
			f:SetMouseClickEnabled(false)
			f.BG = f:CreateTexture(nil, "BACKGROUND")
			f.BG:SetHeight(curHeight)
			f.BG:SetAllPoints()
			--Горизонт
			-- f:SetBackdrop({
			-- bgFile = bgFile,
			-- edgeFile = edgeFile,
			-- edgeSize = 1,
			-- })
			-- f:SetBackdropColor(bgCr, bgCg, bgCb, 0)
			-- f:SetBackdropBorderColor(0, 0, 0, 0.15)
		end
		fname = "TextLeft"..i
		Main_Frame[fname] = Main_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = Main_Frame[fname]
		f:SetSize(curWidthTitle, curHeight)
		f:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", 6, -curHeight*i)
		f:SetFont(curFontTTF, curFontSize, curFontOutline)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDo_DragonflyAddDataToAltFrame()
	Main_Frame:Hide()
end
local tableTEST = {
	{
		name_save = "ShapingFate",
		name_quest = "Определяя судьбу",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {63949},
		max = 1
	},
	{
		name_save = "WB",
		name_quest = "Мировой босс ШЛ",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {61813,61814,61815,61816},
		max = 1
	},
	{
		name_save = "Morgeth",
		name_quest = "Мировой босс ШЛ (Мор'гет)",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {64531},
		max = 1
	},
	{
		name_save = "ReplenishtheReservoir", --Наполнение резервуара
		name_quest = func_currencyicon(1813)..func_questName(61981),
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {61981,61982,61983,61984},
		max = 1
	},
	{
		name_save = "Torghast",
		name_quest = "Торгаст",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {64347},
		max = 1
	},
	{
		name_save = "CovenantAssault",
		name_quest = "Атака ковенантов",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {63822,63823,63824,63543},
		max = 1
	},
	{
		name_save = "ContainingtheHelsworn", -- Сдержать Верных Хелии
		name_quest = func_itemTexture(186997)..func_questName(64273),
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {64273},
		max = 1
	},
	{
		name_save = "ReturnLostSouls", --Возвращение потерянных душ
		name_quest = func_currencyicon(1810)..func_questName(62858),
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {62858,62859,62860,62861,62862,62863,62864,62865,62866,62867,62868,62869},
		max = 1
	},
	{
		name_save = "TradingFavors",
		name_quest = "Обмен услугами или Ценная находка",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {60242,60243,60244,60245,60246,60247,60248,60249,60250,60251,60252,60253,60254,60255,60256,60257},
		max = 2
	},
	{
		name_save = "WeekendEvent",
		name_quest = "Событие выходного дня",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {72728,72720,72722,72723},
		max = 1
	},
	{
		name_save = "Timewalk5DUNGEONS",
		name_quest = "Таймволк 5 инстов",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {72727,72810,72719,72725,72726},
		max = 1
	},
	{
		name_save = "PVP",
		name_quest = "ПВП",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {47148,71026,72169,72167,72166,72168,72171,72170,72646,74871,72648,72647,72649},
		max = 3
	},
	{
		name_save = "StolenKorthianSupplies",
		name_quest = "Украденные кортийские припасы (ДРОПАЕТСЯ)",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64522},
		max = 1
	},
	{
		name_save = "LostResearch",
		name_quest = "Пропавшие исследования",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {65266},
		max = 1
	},
	{
		name_save = "KorthianAnimaVessel", --Тайник с украденной анимой
		name_quest = "Кортийский сосуд с анимой",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64575},
		max = 1
	},
	{
		name_save = "StolenAnimaVessel", --RIFT
		name_quest = func_texturefromIcon(528693).."Сосуд с украденной анимой",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {64265,64269,64270},
		max = 3
	},
	{
		name_save = "RiftboundCache", --RIFT DAILY
		name_quest = func_texturefromIcon(528693).."Тайник Разлома",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {64470,64471,64472,64456},
		max = 4
	},
	{
		name_save = "ZovaalsVault", --RIFT DAILY
		name_quest = func_texturefromIcon(528693).."Хранилище Зоваала",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {64283},
		max = 1
	},
	{
		name_save = "SpectralBoundChest", --RIFT DAILY --Chest with 3 keys
		name_quest = func_texturefromIcon(528693).."Сундук с призрачным замком",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {64247},
		max = 1
	},
	{
		name_save = "HelswornChest", --Maw chest in Desmotaeron
		name_quest = "Сундук Верных Хелии",
		reset = "Daily",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {64256},
		max = 1
	},
	{
		name_save = "Mobs",
		name_quest = func_texturefromIcon(237273).."Мобы",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64341,64342,64343,64344,64747,64748,64749,64750,64751,64752,64753,64754,64755,64756,64757},
		max = 3
	},
	{
		name_save = "RelicGorger",
		name_quest = func_texturefromIcon(237273).."Поглотитель реликвий",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64433,64434,64435,64436},
		max = 4
	},
	{
		name_save = "Collection",
		name_quest = "Сбор",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64351,64354,64355,64356,64357,64358,64359,64360,64361,64362,64021,64363,64364,64316,64317,64318,64564,64565},
		max = 18
	},
	{
		name_save = "Quest",
		name_quest = "Утроба",
		reset = "Daily",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {60646,60762,60775,61075,61079,61088,61103,61104,61765,62214,62234},
		max = 3
	},
	{
		name_save = "Rares",
		name_quest = func_texturefromIcon(237273).."Рарки",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {64457,64338,64442,64278,64245,64246,64263,64428,64258,64233,64349,63830,64243,64291,64455,64320,64313,64284,64285,64257,64440,64276,64272,64232,64251,64152,64439},
		max = 23
	},
	{
		name_save = "ResearchReportRelicExaminationTechniques", -- Отчет об исследованиях: методика изучения реликвий
		name_quest = func_itemTexture(187136)..func_itemName(187136), -- +50% REP
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64367},
		max = 1
	},
	{
		name_save = "VaultAnimaTracker", -- Детектор украденной анимы
		name_quest = func_itemTexture(186453)..func_itemName(186453), -- доступ к сосудам 1000
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64061},
		max = 1
	},
	{
		name_save = "ResearchReportAllSeeingCrystal", -- Отчет об исследованиях: всевидящий кристалл
		name_quest = func_itemTexture(186714)..func_itemName(186714),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64339},
		max = 1
	},
	{
		name_save = "TreatiseRecognizingStygiaanditsUses", -- Исследование: распознавание стигии и ее применение
		name_quest = func_itemTexture(187145)..func_itemName(187145),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64307},
		max = 1
	},
	{
		name_save = "TreatiseBondsofStygiainMortals", -- Исследование: узы стигии в смертных
		name_quest = func_itemTexture(187706)..func_itemName(187706),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64828},
		max = 1
	},
	{
		name_save = "ResearchReportAncientShrines", -- Отчет об исследованиях: древние святилища
		name_quest = func_itemTexture(186716)..func_itemName(186716),
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64348},
		max = 1
	},
	{
		name_save = "TreatiseTheStudyofAnimaandHarnessingEveryDrop", -- Исследование: свойства и эффективное использование анимы
		name_quest = func_itemTexture(186722)..func_itemName(186722),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64027},
		max = 1
	},
	{
		name_save = "TreatiseRelicsAboundintheShadowlands", -- Исследование: поиски реликвий в Темных Землях
		name_quest = func_itemTexture(186721)..func_itemName(186721),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64366},
		max = 1
	},
	{
		name_save = "ResearchReportAdaptiveAlloys", -- Отчет об исследованиях: адаптивные сплавы
		name_quest = func_itemTexture(186717)..func_itemName(186717),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64300},
		max = 1
	},
	{
		name_save = "ResearchReportFirstAlloys", -- Отчет об исследованиях: первые сплавы
		name_quest = func_itemTexture(187138)..func_itemName(187138),
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {64303},
		max = 1
	},
	{
		name_save = "Events",
		name_quest = "10.1.0 Пещера Заралек (события)",
		reset = "Daily",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {75612,75471,75455,75664,75611,75478,75451,75461,75705,75454,75450,75222,75370,75494,75441,75156,75624,74352},
		max = 18
	},
	{
		name_save = "Rares",
		name_quest = func_texturefromIcon(237273).."Рарки",
		reset = "Daily",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {75271,75285,75298,75326,75576,75314,75296,75353,75358,75274,75366,75336,75269,75334,75322,75267,75476,75276,75342,75338,75340,75360,75292,75349,75364},
		max = 25
	},
	{
		name_save = "ZaqaliElders",
		name_quest = "Мировой босс ДФ (Старейшины закали)",
		reset = "Weekly",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "WB",
		questID = {74892},
		max = 1
	},
	{
		name_save = "AWorthyAllyLoammNiffen", --Достойный союзник: лоаммские ниффы
		name_quest = func_questName(75665),
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "ZaralekCavern",
		questID = {75665},
		max = 1
	},
	{
		name_save = "Sniffenseeking",
		name_quest = "нюхорысканье",
		reset = "Weekly",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {75459,76027,75621,75397,75517,75619,76014,75620,76081,75390,75234,75516,75996,76016,75393,76015,76084},
		max = 9 -- ?
	},
	{
		name_save = "Rares",
		name_quest = func_texturefromIcon(237273).."Рарки",
		reset = "Daily",
		expansion = "DF",
		place = "TheForbiddenReach",
		desc = "",
		questID = {74331,74347,74345,74336,74337,74342,74321,74343,74338,74329,74307,74325,74346,74344,74332,74306,74333,74341,74305,74339,74300,74349,74322,74330,74328},
		max = 25
	},
	{
		name_save = "Feast",
		name_quest = L["Community Feast"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {70893},
		max = 1
	},
	{
		name_save = "DragonbaneKeep",
		name_quest = L["Siege on Dragonbane Keep"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {70866},
		max = 1
	},
	{
		name_save = "TheGrandHunt",
		name_quest = L["Grand Hunt"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {70906},
		max = 1
	},
	{
		name_save = "StormsFury",
		name_quest = L["The Storm's Fury"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {73162},
		max = 1
	},
	{
		name_save = "KeysofLoyalty",
		name_quest = L["Keys of Loyalty"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {66133},
		max = 1
	},
	{
		name_save = "StormBoundChest",
		name_quest = "10.0.7 Запечатанный бурей сундук",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {74567},
		max = 1
	},
	{
		name_save = "ResearchersUnderFire",
		name_quest = L["Researchers Under Fire"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {75643},
		max = 1
	},
	{
		name_save = "WB",
		name_quest = "Мировой босс ДФ",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {69927,69928,69929,69930},
		max = 1
	},
	{
		name_save = "FyrakkAssaults",
		name_quest = L["Fyrakk Asssaults (Local)"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {74501,75280},
		max = 1
	},
	{
		name_save = "Timewalk500CURRENCY",
		name_quest = PLAYER_DIFFICULTY_TIMEWALKER.."Timewalk500CURRENCY",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {40173,64710,40168,40786,45563,55499,55498,40787},
		max = 1
	},
	{
		name_save = "Timewalk5DUNGEONS",
		name_quest = PLAYER_DIFFICULTY_TIMEWALKER.."Timewalk5DUNGEONS",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {72727,72810,72719,72725,72726,72724},
		max = 1
	},
	{
		name_save = "3kREP",
		name_quest = func_questName(70750),
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {72068,72373,72374,72375,75259,70750,75859,75860,75861},
		max = 1
	},
	{
		name_save = "FightingisItsOwnReward", --Славный бой – это уже награда
		name_quest = func_questName(76122),
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {76122},
		max = 1
	},
	{
		name_save = "Shadowmourne",
		name_quest = "Темная Скорбь",
		reset = "Once",
		expansion = "WotLK",
		place = "",
		desc = "",
		questID = {24545,24743,24547,24749,24756,24757,24548,24549,24748},
		max = 9
	},
	{
		name_save = "Warlock",
		name_quest = "Зеленый огонь",
		reset = "Once",
		expansion = "MoP",
		place = "",
		desc = "",
		questID = {32295,32307,32309,32310,32317,32324,32325}, --КАКОЙ-то за орду, какой-то за алли и почему-то 8
		max = 7
	},
	{
		name_save = "PatternsWithinPatterns", --Закономерности в закономерностях
		name_quest = func_texturefromIcon(4074774)..func_questName(66042),
		reset = "Weekly",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {66042},
		max = 1
	},
	{
		name_save = "Antros", --Антрос
		name_quest = func_texturefromIcon(3528312)..func_questName(65143),
		reset = "Weekly",
		expansion = "SL",
		place = "ZM",
		desc = "WB",
		questID = {65143},
		max = 1
	},
	{
		name_save = "Rares",
		name_quest = func_texturefromIcon(237273).."Рарки",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65557,65547,65581,65579,63988,65552,65582,64668,64716,64719,65548,65550,65239,65585,65586,65587,65583,65580,65553,65544,65240,65241,65556,65584,65551,65251,65257,65272,65574,65273,65555,65549},
		max = 25
	},
	{
		name_save = "RaresDuneDominance",
		name_quest = func_texturefromIcon(237273).."Рарки (Дюны)",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65585,65586,65587},
		max = 3
	},
	{
		name_save = "worldQuests",
		name_quest = "worldQuests",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {64960,64974,65081,65089,65102,65115,65117,65119,65230,65232,65234,65244,65252,65262,65402,65403,65404,65405,65406,65407,65408,65410,65411,65412,65413,65414,65415,65416,65417,65231},
		max = 3
	},
	{
		name_save = "TREASURES",
		name_quest = "TREASURES",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65520,65573,65489,64667,65465,65523,65487,65503,65178,65480,65545,65173,65441,65522,65537,65536,65542,65546,65540,65566,65447,65543,64545,65270,65565,65175},
		max = 36
	},
	{
		name_save = "GetLockStatus",
		name_quest = "GetLockStatus",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65589,65590,65591,65592},
		max = 4
	},
	{
		name_save = "UndulatingFoliage",
		name_quest = "UndulatingFoliage",
		reset = "Once",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65572},
		max = 1
	},
	{
		name_save = "PryingEyeDiscovery",
		name_quest = "ZM_PryingEyeDiscovery",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65184,65501,65611},
		max = 1
	},
	{
		name_save = "PUZZLECACHES",
		name_quest = "PUZZLECACHES",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65094,65323,65318,65322,65317,65093,65321,65092,65316,65412,65315,65091,65320,64972,65314,65319},
		max = 50
	},
	{
		name_save = "Concordance", --Волнующий конкорданс --Оживленный конкорданс --Безмятежный конкорданс
		name_quest = "Concordance",
		reset = "Once",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {65179,65213,65216,65210,65180,65214,65211,65217,64940,65212,65209,65215,},
		max = 12
	},
} -- For table
function OctoQuestUpdate()
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	----------------------------------------------------------------
	for k,v in pairs(tableTEST) do
		for q,w in pairs(v) do
			local count = 0
			local vivod = ""
			for z,x in pairs(v.questID) do
				if v.max > 1 then
					if C_QuestLog.IsQuestFlaggedCompleted(x) == true then
						count = count + 1
					end
					vivod = count
				else
					local IsComplete = CheckCompletedByQuestID(x)
					vivod = IsComplete
				end
				-- elseif v.max == 1 then
				--     if C_QuestLog.IsQuestFlaggedCompleted(x) == true then
				--         vivod = DONE
				--     else
				--         vivod = NONE
				--     end
				-- end
			end
			if collect then
				if collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_name"] == nil or
				collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_name"] == "noname"
				then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_name"] = v.name_quest or "noname"
				end
				if v.max == 1 then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_count"] = vivod
				elseif v.max > 1 then
					if vivod == v.max and v.max > 1 then
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_count"] = DONE
					else
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_count"] = vivod.."/"..v.max
					end
				end
			end
		end
	end
end
function OctoMoneyUpdate()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local Money = GetMoney()
	if collect then
		collect.Money = Money
	end
end
function OctoilvlStr()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	--------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	if collect then
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function Octo_ToDo_DragonflyAddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	--------------------------------------------------------------------------------------
	Main_Frame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
		sorted[#sorted+1] = CharInfo
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.curServer < b.curServer or a.curServer == b.curServer
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				-- a.Faction < b.Faction or a.Faction == b.Faction
				-- and
				b.Name < a.Name
			end
	end)
	TotalMoney = 0
	TotalMoneyAllServer = 0
	TotalKills = 0
	for i, CharInfo in pairs(sorted) do
		local curCharGUID = CharInfo.GUID
		local curName = nil
		if CharInfo.Name == nil then
		curName = "UnLogged Char" else
			curName = CharInfo.Name
		end
		if not Main_Frame[curCharGUID] then
			Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Main_Frame, "BackdropTemplate")
			Char_Frame = Main_Frame[curCharGUID]
			Char_Frame:SetPoint("BOTTOM", 0, 0)
			Char_Frame.BG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.BG:Hide()
			Char_Frame.BG:SetPoint("TOPLEFT", 0, -curHeight)
			Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
			Char_Frame.BG:SetColorTexture(r, g, b, 1)
			--Вертикаль
			-- Char_Frame:SetBackdrop({
			-- bgFile = bgFile,
			-- edgeFile = edgeFile,
			-- edgeSize = 1 ,
			-- })
			-- Char_Frame:SetBackdropColor(bgCr, bgCg, bgCb, 0)
			-- Char_Frame:SetBackdropBorderColor(0, 0, 0, 0.15)
			for i = 1, #table_func_otrisovka do
				CF = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), Char_Frame)
				Char_Frame["CenterLines"..i] = CF
				CF.index = i
				CF:SetSize(curWidth, curHeight)
				CF:SetPoint("TOP", Char_Frame, "TOP", 0, -curHeight*i)
				CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
				CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
				CF:SetMouseClickEnabled(false)
				-- if #CF.tooltip == 0 then CF.tooltip = nil end
				local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				--Char_Frame["CenterLines"..i] = CL
				CL:SetAllPoints()
				--CL:SetSize(curWidth, curHeight)
				--CL:SetPoint("TOP", Char_Frame, "TOP", 0, -curHeight*i)
				CL:SetFont(curFontTTF, curFontSize, curFontOutline)
				CL:SetJustifyV("MIDDLE")
				CL:SetJustifyH("CENTER")
				CL:SetTextColor(1, 1, 1, 1)
				Char_Frame["CenterLines"..i.."BG"] = Char_Frame:CreateTexture(nil,"BACKGROUND")
				Char_Frame["CenterLines"..i.."BG"]:SetAllPoints(Char_Frame["CenterLines"..i])
				Char_Frame["CenterLines"..i.."BG"]:SetColorTexture(r,g,b,0)
				CF.CL = CL
			end
		else
			Char_Frame = Main_Frame[curCharGUID]
		end
		local ShowOnlyCurrentRealm = Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm
		local LevelToShow = Octo_ToDo_DragonflyVars.config.LevelToShow
		TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.UnitLevel >= LevelToShow)) or (ShowOnlyCurrentRealm == false and CharInfo.UnitLevel >= LevelToShow) or (curGUID == CharInfo.GUID) then
			CharInfo.GUID = curCharGUID
			Char_Frame:SetSize(curWidth, curHeight)
			if #Main_Frame.AllCharFrames == 0 then
				Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				Char_Frame:SetPoint("TOPRIGHT", Main_Frame.AllCharFrames[#Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			Main_Frame.AllCharFrames[#Main_Frame.AllCharFrames + 1] = Char_Frame
			local curMoney = 0
			if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then
				curMoney = CharInfo.Money
			end
			TotalMoney = TotalMoney + curMoney
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			Char_Frame.DeleteButton = CreateFrame("BUTTON", AddonTitle..GenerateUniqueID(), Char_Frame, "BackDropTemplate")
			Char_Frame.CharName = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.curServer = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.CharNameBG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.CharNameBG:SetAllPoints(Char_Frame.CharName)
			Char_Frame.UnitLevel = Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			Char_Frame.UnitLevelBG = Char_Frame:CreateTexture(nil, "BACKGROUND")
			Char_Frame.UnitLevelBG:SetAllPoints(Char_Frame.UnitLevel)
			if CharInfo.Faction == "Horde" then
				Char_Frame.CharNameBG:SetColorTexture(.2, 0, 0, 1)
			else
				Char_Frame.CharNameBG:SetColorTexture(0, 0, .2, 1)
			end
			Char_Frame.UnitLevel:SetSize(curWidth, curHeight/2)
			Char_Frame.UnitLevel:SetPoint("BOTTOM", Char_Frame, "TOP", 0, 0)
			Char_Frame.UnitLevel:SetFont(curFontTTF, curFontSize, curFontOutline)
			Char_Frame.UnitLevel:SetWordWrap(true)
			Char_Frame.UnitLevel:SetJustifyV("CENTER")
			--Char_Frame.UnitLevel:SetText(" ")
			if CharInfo.UnitLevel ~= 70 then
				Char_Frame.UnitLevelBG:SetColorTexture(bgCr, bgCg, bgCb, 1)
				--Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel.." "..math.floor((CharInfo.currentXP/CharInfo.UnitXPMax)*100).."%"))
				Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel))
				Char_Frame.experience = Char_Frame:CreateTexture(nil, "ARTWORK")
				if CharInfo.currentXP == 0 then
					Char_Frame.experience:SetWidth(0.1)
				else
					Char_Frame.experience:SetWidth(CharInfo.currentXP/CharInfo.UnitXPMax*curWidth)
				end
				Char_Frame.experience:SetHeight(curHeight/2) --Высота
				Char_Frame.experience:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\O_03.tga")
				Char_Frame.experience:SetPoint("BOTTOMLEFT", Char_Frame, "TOPLEFT")
				Char_Frame.experience:SetVertexColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b, 1)
			elseif CharInfo.UnitLevel == 70 then
				-- Char_Frame.experience:Hide()
			end
			Char_Frame.CharName:SetSize(curWidth, curHeight)
			Char_Frame.CharName:SetFont(curFontTTF, curFontSize, curFontOutline)
			Char_Frame.CharName:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
			Char_Frame.CharName:SetText(classcolor:WrapTextInColorCode(CharInfo.Name))
			Char_Frame.CharName:SetWordWrap(true)
			Char_Frame.CharName:SetJustifyV("CENTER")
			if Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm == false then
				Char_Frame.CharName:SetJustifyV("TOP")
				--Char_Frame.CharName:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
				Char_Frame.curServer:SetSize(curWidth, curHeight)
				Char_Frame.curServer:SetPoint("TOP", Char_Frame, "TOP", 0, 0)
				Char_Frame.curServer:SetFont(curFontTTF, curFontSize-2, curFontOutline)
				Char_Frame.curServer:SetText(classcolor:WrapTextInColorCode(CharInfo.curServer))
				Char_Frame.curServer:SetWordWrap(false)
				Char_Frame.curServer:SetJustifyV("BOTTOM")
			end
			---------------------------------------------
			-- StaticPopupDialogs[GlobalAddonName.."DELETE_CHARACTER"] = {
			-- text = DELETE.."?",
			-- button1 = YES,
			-- button2 = NO,
			-- hideOnEscape = 1,
			-- whileDead = 1,
			-- OnAccept = function() Octo_ToDo_DragonflyDeleteChar(curCharGUID) end,
			-- }
			---------------------------------------------
			Char_Frame.DeleteButton:SetSize(16, 10)
			Char_Frame.DeleteButton:SetPoint("TOP", Char_Frame, "BOTTOM", 0, -4)
			Char_Frame.DeleteButton:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", -- Interface/Addons/"..GlobalAddonName.."/Media/border/01 Octo.tga -- Interface/Buttons/white8x8
					edgeSize = 1,
			})
			Char_Frame.DeleteButton:SetBackdropBorderColor(1, 0, 0, 0)
			Char_Frame.DeleteButton:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
					GameTooltip:ClearLines()
					GameTooltip:SetText(DELETE)
					GameTooltip:Show()
			end)
			Char_Frame.DeleteButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			Char_Frame.DeleteButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0.5)
					self.icon:SetVertexColor(1, 0, 0, 0.5)
			end)
			Char_Frame.DeleteButton:SetScript("OnClick", function()
					--StaticPopup_Show(GlobalAddonName.."DELETE_CHARACTER")
					Octo_ToDo_DragonflyDeleteChar(curCharGUID)
			end)
			local t = Char_Frame.DeleteButton:CreateTexture(nil, "BACKGROUND")
			Char_Frame.DeleteButton.icon = t
			t:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\closeWHITE.tga")
			t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Char_Frame.DeleteButton)
			if curGUID == curCharGUID then
				Char_Frame.BG:Show()
				Char_Frame.BG:SetAlpha(.2)
			end
			for i = 1, #table_func_otrisovka do
				local TEXTLEFT = Main_Frame["TextLeft"..i]
				local TEXTCENT = Char_Frame["CenterLines"..i]
				local BG = Char_Frame["CenterLines"..i.."BG"]
				TEXTCENT.tooltip = {}
				local VivodCent, VivodLeft = table_func_otrisovka[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
				TEXTLEFT:SetText(VivodLeft)
				TEXTCENT.CL:SetText(VivodCent)
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
		end
		local curAltFrameWidth = #Main_Frame.AllCharFrames * curWidth/2
		Main_Frame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(#table_func_otrisovka+1))
	end
end
function Octo_ToDo_DragonflyDeleteChar(curGUID)
	Octo_ToDo_DragonflyLevels[curGUID] = nil
	for X, Y in pairs(Main_Frame.AllCharFrames) do
		-- https://www.wowhead.com/ru/npc=38606/ ДЖАЙНА
		-- https://www.wowhead.com/ru/npc=38609/ СИЛЬВАНА
		PlaySound(11014) -- Джайна стоны
		--PlaySound(109068) --Черепаха добралась до воды https://www.wowhead.com/ru/npc=102636/
		if Y == Main_Frame[curGUID] then
			Main_Frame.AllCharFrames[X].parent = nil
			Main_Frame.AllCharFrames[X]:Hide()
			Main_Frame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDo_DragonflyAddDataToAltFrame()
end
function CollectPlayerInfo()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER") or 0
	local collect = Octo_ToDo_DragonflyLevels[curGUID]
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	if collect then
		collect.currentXP = currentXP
		collect.UnitXPMax = UnitXPMax
		collect.Name = curCharName
		collect.curServer = curServer
		collect.className = className
		collect.classFilename = classFilename
		collect.classId = classId
		collect.GUID = curGUID
		collect.Faction = UnitFactionGroup("PLAYER")
		collect.UnitLevel = UnitLevel
		collect.specId = specId
		collect.specName = specName
		collect.specIcon = specIcon
		collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
	end
end
local function checkCharInfo(CharInfo)
	for k,v in pairs(tableTEST) do
		for q,w in pairs(v) do
			CharInfo["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_name"] = CharInfo["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_name"] or "noname"
			CharInfo["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_count"] = CharInfo["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.place..v.desc..v.name_save.."_count"] or 0
		end
	end
	CharInfo.avgItemLevel = CharInfo.avgItemLevel or 0
	CharInfo.avgItemLevelEquipped = CharInfo.avgItemLevelEquipped or 0
	CharInfo.avgItemLevelPvp = CharInfo.avgItemLevelPvp or 0
	CharInfo.className = CharInfo.className or 0
	CharInfo.classFilename = CharInfo.classFilename or 0
	CharInfo.classId = CharInfo.classId or 0
	CharInfo.classColor = CharInfo.classColor or {r = 0.5, g = 0.5, b = 0.5}
	CharInfo.curCovID = CharInfo.curCovID or 0
	CharInfo.CurrencyID = CharInfo.CurrencyID or {}
	CharInfo.CurrencyID_maxQuantity = CharInfo.CurrencyID_maxQuantity or {}
	CharInfo.curServer = CharInfo.curServer or 0
	CharInfo.Faction = CharInfo.Faction or 0
	CharInfo.ItemsInBag = CharInfo.ItemsInBag or {}
	CharInfo.KnownSpell = CharInfo.KnownSpell or {}
	CharInfo.maxNumQuestsCanAccept = CharInfo.maxNumQuestsCanAccept or 0
	CharInfo.Name = CharInfo.Name or 0
	CharInfo.needReset = CharInfo.needReset or false
	CharInfo.numQuests = CharInfo.numQuests or 0
	CharInfo.numShownEntries = CharInfo.numShownEntries or 0
	CharInfo.Possible_Anima = CharInfo.Possible_Anima or 0
	CharInfo.Possible_CatalogedResearch = CharInfo.Possible_CatalogedResearch or 0
	-- CharInfo.Octopussy_TreasureGoblin = CharInfo.Octopussy_TreasureGoblin or false
	CharInfo.pizdaDate = CharInfo.pizdaDate or 0
	CharInfo.pizdaHours = CharInfo.pizdaHours or 0
	CharInfo.profID_prof1 = CharInfo.profID_prof1 or {}
	CharInfo.profID_prof1.chest = CharInfo.profID_prof1.chest or {}
	CharInfo.profID_prof1.craftOrder = CharInfo.profID_prof1.craftOrder or {}
	CharInfo.profID_prof1.drops = CharInfo.profID_prof1.drops or {}
	CharInfo.profID_prof1.profQuest = CharInfo.profID_prof1.profQuest or {}
	CharInfo.profID_prof1.treatise = CharInfo.profID_prof1.treatise or {}
	CharInfo.profID_prof2 = CharInfo.profID_prof2 or {}
	CharInfo.profID_prof2.chest = CharInfo.profID_prof2.chest or {}
	CharInfo.profID_prof2.craftOrder = CharInfo.profID_prof2.craftOrder or {}
	CharInfo.profID_prof2.drops = CharInfo.profID_prof2.drops or {}
	CharInfo.profID_prof2.profQuest = CharInfo.profID_prof2.profQuest or {}
	CharInfo.profID_prof2.treatise = CharInfo.profID_prof2.treatise or {}
	CharInfo.PVP = CharInfo.PVP or {}
	CharInfo.Octo_Table_QuestID = CharInfo.Octo_Table_QuestID or {}
	CharInfo.reputationID = CharInfo.reputationID or {}
	CharInfo.Shadowland = CharInfo.Shadowland or {}
	CharInfo.totalSlots = CharInfo.totalSlots or 0
	CharInfo.totalSlotsBANK = CharInfo.totalSlotsBANK or 0
	CharInfo.UnitLevel = CharInfo.UnitLevel or 0
	CharInfo.usedSlots = CharInfo.usedSlots or 0
	CharInfo.usedSlotsBANK = CharInfo.usedSlotsBANK or 0
	CharInfo.VOID_STORAGE_PAGE1 = CharInfo.VOID_STORAGE_PAGE1 or {}
	CharInfo.VOID_STORAGE_PAGE2 = CharInfo.VOID_STORAGE_PAGE2 or {}
	CharInfo.canUseMountEquipment = CharInfo.canUseMountEquipment or false
	CharInfo.currentMountItemID = CharInfo.currentMountItemID or 0
	setmetatable(CharInfo, Meta_Table_0)
	setmetatable(CharInfo.CurrencyID_maxQuantity, Meta_Table_0)
	setmetatable(CharInfo.CurrencyID, Meta_Table_0)
	setmetatable(CharInfo.ItemsInBag, Meta_Table_0)
	setmetatable(CharInfo.KnownSpell, Meta_Table_false)
	setmetatable(CharInfo.profID_prof1, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.chest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.craftOrder, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.drops, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.profQuest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof1.treatise, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.chest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.craftOrder, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.drops, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.profQuest, Meta_Table_0)
	setmetatable(CharInfo.profID_prof2.treatise, Meta_Table_0)
	setmetatable(CharInfo.PVP, Meta_Table_0)
	setmetatable(CharInfo.Octo_Table_QuestID, Meta_Table_0)
	setmetatable(CharInfo.reputationID, Meta_Table_0)
	setmetatable(CharInfo.Shadowland, Meta_Table_0)
	setmetatable(CharInfo.VOID_STORAGE_PAGE1, Meta_Table_0)
	setmetatable(CharInfo.VOID_STORAGE_PAGE2, Meta_Table_0)
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.CurrentKey ~= 0 then
		CharInfo.CurrentKey = Addon_Color..">>VAULT<<|r"
	end
	if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
		CharInfo.tmstp_Weekly = tmstpDayReset(7)
		--CharInfo.OctopussyWeekly_Feast = 0
	end
	if (CharInfo.tmstp_Daily or 0) < GetServerTime() then
		CharInfo.tmstp_Daily = tmstpDayReset(1)
		CharInfo.needReset = true
	end
end
function Octo_ToDo_DragonflyOnEvent(self, event, ...)
	--if InCombatLockdown() then return end
	if event == "VARIABLES_LOADED" and not InCombatLockdown() then
		if Octo_ToDo_DragonflyVars == nil then
			Octo_ToDo_DragonflyVars = {}
		end
		if Octo_ToDo_DragonflyVars.config == nil then
			Octo_ToDo_DragonflyVars.config = {}
		end
		if Octo_ToDo_DragonflyLevels == nil then
			Octo_ToDo_DragonflyLevels = {}
		end
		if Octo_ToDo_DragonflyVars.config.CVar == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.CVar = false
		end
		if Octo_ToDo_DragonflyVars.config.InputDelete == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.InputDelete = true
		end
		if Octo_ToDo_DragonflyVars.config.UsableItems == nil then
			Octo_ToDo_DragonflyVars.config.UsableItems = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoOpen == nil then
			Octo_ToDo_DragonflyVars.config.AutoOpen = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoGossip == nil then
			Octo_ToDo_DragonflyVars.config.AutoGossip = true
		end
		if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame == nil then
			Octo_ToDo_DragonflyVars.config.TalkingHeadFrame = true
		end
		if Octo_ToDo_DragonflyVars.config.HideObjectiveTracker == nil then
			Octo_ToDo_DragonflyVars.config.HideObjectiveTracker = false
		end
		if Octo_ToDo_DragonflyVars.config.HideZoneText == nil then
			Octo_ToDo_DragonflyVars.config.HideZoneText = true
		end
		if Octo_ToDo_DragonflyVars.config.Covenant == nil then
			Octo_ToDo_DragonflyVars.config.Covenant = true
		end
		if Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale == nil then
			Octo_ToDo_DragonflyVars.config.UIErrorsFrameScale = true
		end
		if Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame == nil then
			Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame = true
		end
		if Octo_ToDo_DragonflyVars.config.CinematicCanceler == nil then
			Octo_ToDo_DragonflyVars.config.CinematicCanceler = true
		end
		if Octo_ToDo_DragonflyVars.config.BossBanner == nil then
			Octo_ToDo_DragonflyVars.config.BossBanner = true
		end
		if Octo_ToDo_DragonflyVars.config.AnotherAddons == nil then --RELOAD
			Octo_ToDo_DragonflyVars.config.AnotherAddons = true
		end
		if Octo_ToDo_DragonflyVars.config.ClearChat == nil then
			Octo_ToDo_DragonflyVars.config.ClearChat = true
		end
		if Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm == nil then
			Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm = true
		end
		if Octo_ToDo_DragonflyVars.config.LevelToShow == nil then
			Octo_ToDo_DragonflyVars.config.LevelToShow = 60
		end
		if Octo_ToDo_DragonflyVars.config.AutoSellGrey == nil then
			Octo_ToDo_DragonflyVars.config.AutoSellGrey = true
		end
		if Octo_ToDo_DragonflyVars.config.AutoRepair == nil then
			Octo_ToDo_DragonflyVars.config.AutoRepair = true
		end
		if Octo_ToDo_DragonflyVars.config.HideErrorMessages == nil then
			Octo_ToDo_DragonflyVars.config.HideErrorMessages = true
		end
		-- Expansions
		if Octo_ToDo_DragonflyVars.config.LINE_Classic == nil then
			Octo_ToDo_DragonflyVars.config.LINE_Classic = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_TheBurningCrusade == nil then
			Octo_ToDo_DragonflyVars.config.LINE_TheBurningCrusade = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_WrathoftheLichKing == nil then
			Octo_ToDo_DragonflyVars.config.LINE_WrathoftheLichKing = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_Cataclysm == nil then
			Octo_ToDo_DragonflyVars.config.LINE_Cataclysm = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_MistsofPandaria == nil then
			Octo_ToDo_DragonflyVars.config.LINE_MistsofPandaria = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_WarlordsofDraenor == nil then
			Octo_ToDo_DragonflyVars.config.LINE_WarlordsofDraenor = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_Legion == nil then
			Octo_ToDo_DragonflyVars.config.LINE_Legion = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_BattleforAzeroth == nil then
			Octo_ToDo_DragonflyVars.config.LINE_BattleforAzeroth = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_Shadowlands == nil then
			Octo_ToDo_DragonflyVars.config.LINE_Shadowlands = false
		end
		if Octo_ToDo_DragonflyVars.config.LINE_Dragonflight == nil then
			Octo_ToDo_DragonflyVars.config.LINE_Dragonflight = true
		end
		for i, func in ipairs(E.modules) do
			func()
		end
		CurrencyTinsert()
		pizdalishe()
		local MinimapName = GlobalAddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = IconTexture,
				OnClick = function(_, button)
					if not InCombatLockdown() then
						Main_Frame:SetShown(not Main_Frame:IsShown())
						if PlayCustomSound == true then
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\Gnome Woo.ogg", "Master")
						end
						-- CollectAllItemsInBag()
						--Fragments_Earned()
						CollectAllReputations()
						CollectPVPRaitings()
						-- if Main_Frame and Main_Frame:IsShown() then
						-- Main_Frame:Hide()
						-- end
						-- if SettingsPanel:IsVisible() and self:IsVisible() then
						-- HideUIPanel(SettingsPanel)
						-- else
						-- Settings.OpenToCategory(GlobalAddonName, true)
						-- end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle.." "..AddonVersion)
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DragonflyVars.config = Octo_ToDo_DragonflyVars.config or {}
		Octo_ToDo_DragonflyVars.config.minimapPos = Octo_ToDo_DragonflyVars.config.minimapPos or 244
		Octo_ToDo_DragonflyVars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DragonflyVars.config)
		ldbi:Show(MinimapName)
	elseif event == "ACTIONBAR_UPDATE_COOLDOWN" and not InCombatLockdown() and Main_Frame and Main_Frame:IsShown() then
		-- print (GetExpansionLevel(), GetAccountExpansionLevel(), GetServerExpansionLevel(), LE_EXPANSION_LEVEL_CURRENT)
		Octo_ToDo_DragonflyAddDataToAltFrame()
		ToDragonbaneKeepTimer()
		GrandHuntsTimer()
		CommunityFeastTimer()
		PrimalStormsTimer()
		ResearchersUnderFireTimer()
		-- TreasureGoblinTimer()
		CollectAllProfessions()
		CollectDungeonsRaiting()
		--CollectPVPRaitings()
		CollectCurrentKEY()
		OctoilvlStr()
		CollectAllReputations()
		CollectAllQuests()
		CollectLoginTime()
	elseif event == "COVENANT_CHOSEN" then
		C_Timer.After(1, function()
				CollectCovenantAnima()
		end)
	elseif event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED" then
		C_Timer.After(1, function()
				CollectCovenantAnima()
		end)
	elseif event == "QUEST_FINISHED" then
		OctoQuestUpdate()
		CollectAllQuests()
		Octo_ToDo_DragonflyAddDataToAltFrame()
	elseif event == "QUEST_COMPLETE" then
		OctoQuestUpdate()
		CollectAllQuests()
		Octo_ToDo_DragonflyAddDataToAltFrame()
	elseif event == "QUEST_LOG_UPDATE" then
		OctoQuestUpdate()
		CollectAllQuests()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_MONEY" then
		OctoMoneyUpdate()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "CURRENCY_DISPLAY_UPDATE" and not InCombatLockdown() then
		CollectAllCurrency()
		CollectKnownSpell()
		CollectPossibleAnima()
		-- CurrencyTinsert()
		if Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "UNIT_INVENTORY_CHANGED" and not InCombatLockdown() then
		OctoilvlStr()
		CollectPlayerInfo()
		if Main_Frame and Main_Frame:IsShown() then
			Octo_ToDo_DragonflyAddDataToAltFrame()
		end
	elseif event == "PLAYER_LOGIN" then
		-- CollectVoidStorage()
		local curGUID = UnitGUID("PLAYER")
		Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
		for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
			checkCharInfo(CharInfo)
		end
		self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		self:RegisterEvent("PLAYER_STARTED_MOVING")
		CollectCovenantAnima()
		CollectPlayerInfo()
		CollectPVPRaitings()
		OctoQuestUpdate()
		OctoMoneyUpdate()
		OctoilvlStr()
		Octo_ToDo_DragonflyCreateAltFrame()
		CollectAllCurrency()
		CollectKnownSpell()
		-- CurrencyTinsert()
		CollectAllProfessions()
		--Fragments_Earned()
		CollectAllReputations()
		ReputationTinsert()
		CollectDungeonsRaiting()
		CollectCurrentKEY()
		CollectAllQuests()
		UPGRADERANKS_Frame()
		C_Timer.After(3, function()
				Octo_ToDo_DragonflyAddDataToAltFrame()
		end)
		--itemID_TEST_INSERT()
		-- elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		-- local _, eventType = CombatLogGetCurrentEventInfo()
		-- if eventType == "UNIT_DIED" then
		-- CollectKillCount()
		-- end
	elseif event == "PLAYER_LOGOUT" and not InCombatLockdown() then
		CollectPVPRaitings()
		--CollectLoginTime()
	elseif event == "PLAYER_LEAVING_WORLD" and not InCombatLockdown() then
		-- OctoMoneyUpdate()
		-- CollectAllCurrency()
		CollectDungeonsRaiting()
		CollectLoginTime()
		-- CollectPVPRaitings()
		-- elseif event == "PLAYER_LOGOUT" then
		-- CollectAllItemsInBag()
		-- CollectCurrentKEY()
	elseif event == "PLAYER_ENTERING_WORLD" and not InCombatLockdown() then
		CollectPVPRaitings()
		CollectLoginTime()
		CollectAllItemsInBag()
		CollectAppliedMountEquipmentID()
		CollectPossibleAnima()
	elseif event == "BAG_UPDATE" and not InCombatLockdown() then
		CollectAllItemsInBag()
		CollectPossibleAnima()
		--Fragments_Earned()
		CollectCurrentKEY()
		-- CollectLoginTime()
		--itemID_TEST_INSERT()
	elseif event == "HEARTHSTONE_BOUND" and not InCombatLockdown() then
		CollectAllItemsInBag()
		CollectPossibleAnima()
		CollectLoginTime()
		--Fragments_Earned()
	elseif event == "ZONE_CHANGED" and not InCombatLockdown() then
		CollectAllItemsInBag()
		CollectPossibleAnima()
		CollectLoginTime()
		--Fragments_Earned()
	elseif event == "ZONE_CHANGED_NEW_AREA" and not InCombatLockdown() then
		CollectAllItemsInBag()
		CollectPossibleAnima()
		CollectLoginTime()
		--Fragments_Earned()
		-- elseif event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		-- CollectPVPRaitings()
	elseif event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" then
		CollectBankInfo()
	elseif event == "BAG_UPDATE" then
		if BankFrame:IsShown() then
			CollectBankInfo()
		end
	elseif event == "VOID_STORAGE_UPDATE" or event == "VOID_TRANSFER_DONE" or event == "VOID_STORAGE_CONTENTS_UPDATE" or event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
		CollectVoidStorage()
	elseif event == "SPELLS_CHANGED" then
		CollectKnownSpell()
	elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
		CollectAppliedMountEquipmentID()
	end
end
Octo_ToDo_DragonflyOnLoad()
SLASH_Octo1, SLASH_Octo2 = '/Octo', '/OctoDF'
function SlashCmdList.Octo(msg, editBox)
	Main_Frame:SetShown(not Main_Frame:IsShown())
	CollectAllItemsInBag()
	CollectPossibleAnima()
	CollectAllReputations()
end
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	print("SEARCH:", msg)
	for i, n in pairs(_G) do
		if type(n) == "string" and n:find(msg) then
			print(i, n)
		end
	end
end
-- local ColorKyrian = CreateColor(1, 1, 1, 1)
-- (KYRIAN_Blue_Color:GetRGB())
-- SetAtlas("Dragonfly-landingbutton-kyrian-highlight")
