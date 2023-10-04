local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonNotes = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Notes")
local AddonAuthor = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Author")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
--------------------------------
E.Octo_Func.func_Octo_LoadAddOn("!BugGrabber")
E.Octo_Func.func_Octo_LoadAddOn("BugSack")
E.Octo_Func.func_Octo_LoadAddOn("Rarity")
E.Octo_Func.func_Octo_LoadAddOn("Rarity_Options")
E.Octo_Func.func_Octo_LoadAddOn("MountsJournal")
-- FRAMES ----------------------------
local Octo_DEV_FUNC = false
--------------------------------
local Button = nil
local CF = nil
local OctoFrame_Char_Frame = nil
local OctoFrame_EventFrame = nil
local inspectScantip = nil
local OctoFrame_Main_Frame = nil
local OctoFrame_UPGRADERANKS_Frame = nil
local OctoFrame_Close_Button = nil
local OctoFrame_Options_Button = nil
local OctoFrame_MarkOfHonor_Button = nil
local OctoFrame_QuestFeast_Button = nil
local OctoFrame_AbandonAllQuests_Button = nil
local OctoFrame_Char_FrameDeleteButton = nil
--------------------------------
local className, classFilename, classId = UnitClass("PLAYER")
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local Horde_Icon = E.Octo_Func.func_texturefromIcon(132485)--"|T132485:16:16:::64:64:4:60:4:60|t"
local Alliance_Icon = E.Octo_Func.func_texturefromIcon(132486)--"|T132486:16:16:::64:64:4:60:4:60|t"
local Kyrian_Icon = E.Octo_Func.func_texturefromIcon(3257748)--"|T3257748:16:16:::64:64:4:60:4:60|t"
local Necrolord_Icon = E.Octo_Func.func_texturefromIcon(3257749)--"|T3257749:16:16:::64:64:4:60:4:60|t"
local NightFae_Icon = E.Octo_Func.func_texturefromIcon(3257750)--"|T3257750:16:16:::64:64:4:60:4:60|t"
local Venthyr_Icon = E.Octo_Func.func_texturefromIcon(3257751)--"|T3257751:16:16:::64:64:4:60:4:60|t"
local WorldBoss_Icon = E.Octo_Func.func_texturefromIcon(3528312)--"|T3528312:16:16:::64:64:4:60:4:60|t"
local Rares_Icon = E.Octo_Func.func_texturefromIcon(135903)--"|T135903:16:16:::64:64:4:60:4:60|t"
local Unknown_Icon = E.Octo_Func.func_texturefromIcon(134400)--"|T134400:16:16:::64:64:4:60:4:60|t"
local Token_Icon = E.Octo_Func.func_texturefromIcon(1120721)--"|T1120721:16:16:::64:64:4:64:4:64|t"
local Money_Icon = E.Octo_Func.func_texturefromIcon(133784, 12)--"|T133784:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T1418621:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T".."Interface/AddOns/Octo_ToDo/Media/ElvUI/Mail0.tga"..":12:12:::64:64:4:64:4:64|t"
local MailBox_Icon = "|T1506457:12:12:::64:64:4:64:4:64|t"
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
local fontObject9 = CreateFont("OctoFont9")
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalMoney = 0
local TotalMoneyAllServer = 0
local TotalTransAnima = 0
local TotalTransParacausalFlakes = 0
local TotalKills = 0
local BGALPHA = .05
-- local E.Octo_Globals.NONE = E.Octo_Globals.Gray_Color.."None|r"
-- local E.Octo_Globals.DONE = E.Octo_Globals.Green_Color.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local AddonTexture = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture.tga"
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
local Meta_Table_DONE = {__index = function() return E.Octo_Globals.DONE end}
local Meta_Table_NONE = {__index = function() return E.Octo_Globals.NONE end}
local Meta_Table_Empty = {__index = function() return "" end}
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_Holiday)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_Reputation)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_DFMountsSkins)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.T3Items)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.Dreamsurges_Items)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_Professions_currencyID)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.FirstAid)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Blacksmithing)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Leatherworking)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Alchemy)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Herbalism)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Cooking)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Mining)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Tailoring)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Engineering)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Enchanting)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Fishing)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Skinning)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Jewelcrafting)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Inscription)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Archeology)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Holiday)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Recurring)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Uncategorized)
local OctoTable_func_otrisovka = {
}
local OctoTable_UniversalQuest = {
	{
		name_save = "ALL",
		name_quest = WorldBoss_Icon.."WB",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "WB",
		questID = {
			69927, 69928, 69929, 69930
		},
		max = 1
	},
	{
		name_save = "ZaqaliElders",
		name_quest = WorldBoss_Icon.."WB: Старейшины закали",
		reset = "Weekly",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "WB",
		questID = {
			74892
		},
		max = 1
	},
	{
		name_save = "ALL",
		name_quest = WorldBoss_Icon.."WB",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "WB",
		questID = {
			61813, 61814, 61815, 61816
		},
		max = 1
	},
	{
		name_save = "Antros",
		name_quest = WorldBoss_Icon.."WB: Антрос",
		reset = "Weekly",
		expansion = "SL",
		place = "ZM",
		desc = "WB",
		questID = {
			65143
		},
		max = 1
	},
	{
		name_save = "Morgeth",
		name_quest = WorldBoss_Icon.."WB: Мор'гет",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "WB",
		questID = {
			64531
		},
		max = 1
	},
	{
		name_save = "ALL",
		name_quest = WorldBoss_Icon.."WB",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "WB",
		questID = {
			52157, 52163, 52166, 52181, 52169, 52196
		},
		max = 1,
	},
	{
		name_save = "Nazjatar",
		name_quest = WorldBoss_Icon.."WB: Nazjatar",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "WB",
		questID = {
			56056, 56057
		},
		max = 1,
	},
	{
		name_save = "Darkshore",
		name_quest = WorldBoss_Icon.."WB: PVP",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "WB",
		questID = {
			54896, 52847
		},
		max = 1,
	},
	{
		name_save = "Assault",
		name_quest = WorldBoss_Icon.."WB: Assault",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "WB",
		questID = {
			55466, 58705
		},
		max = 1,
	},
	{
		name_save = "ALL",
		name_quest = WorldBoss_Icon.."WB",
		reset = "Weekly",
		expansion = "Legion",
		place = "",
		desc = "WB",
		questID = {
			43512, 43193, 43448, 43985, 42819, 43192, 43513, 42270, 42779, 42269, 44287
		},
		max = 1,
	},
	{
		name_save = "ShapingFate",
		name_quest = "Определяя судьбу",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			63949
		},
		max = 1
	},
	{
		name_save = "ReplenishtheReservoir",
		name_quest = "Наполнение резервуара",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {
			61981, 61982, 61983, 61984
		},
		max = 1
	},
	{
		name_save = "Torghast",
		name_quest = "Торгаст",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {
			64347
		},
		max = 1
	},
	{
		name_save = "CovenantAssault",
		name_quest = "Атака ковенантов",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {
			63822, 63823, 63824, 63543
		},
		max = 1
	},
	{
		name_save = "ContainingtheHelsworn",
		name_quest = "Сдержать Верных Хелии",
		reset = "Weekly",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {
			64273
		},
		max = 1
	},
	{
		name_save = "ReturnLostSouls",
		name_quest = "Возвращение потерянных душ",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {
			62858, 62859, 62860, 62861, 62862, 62863, 62864, 62865, 62866, 62867, 62868, 62869
		},
		max = 1
	},
	{
		name_save = "TradingFavors",
		name_quest = "Обмен услугами или Ценная находка",
		reset = "Weekly",
		expansion = "SL",
		place = "",
		desc = "",
		questID = {
			60242, 60243, 60244, 60245, 60246, 60247, 60248, 60249, 60250, 60251, 60252, 60253, 60254, 60255, 60256, 60257
		},
		max = 2
	},
	{
		name_save = "TheWorldAwaits",
		name_quest = "The World Awaits",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72728
		},
		max = 1
	},
	{
		name_save = "TheArenaCalls",
		name_quest = "The Arena Calls",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72720
		},
		max = 1
	},
	{
		name_save = "EmissaryofWar",
		name_quest = "Emissary of War",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72722
		},
		max = 1
	},
	{
		name_save = "ACalltoBattle",
		name_quest = "A Call to Battle",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72723
		},
		max = 1
	},
	{
		name_save = "SomethingDifferent",
		name_quest = "Something Different",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			47148
		},
		max = 1
	},
	{
		name_save = "PVP",
		name_quest = "ПВП",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			47148, 71026, 72169, 72167, 72166, 72168, 72171, 72170, 72646, 74871, 72648, 72647, 72649
		},
		max = 3
	},
	{
		name_save = "StolenKorthianSupplies",
		name_quest = "Украденные кортийские припасы (ДРОПАЕТСЯ)",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64522
		},
		max = 1
	},
	{
		name_save = "LostResearch",
		name_quest = "Пропавшие исследования",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			65266
		},
		max = 1
	},
	{
		name_save = "KorthianAnimaVessel",
		name_quest = "Кортийский сосуд с анимой",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64575
		},
		max = 1
	},
	{
		name_save = "StolenAnimaVessel",
		name_quest = "Сосуд с украденной анимой",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {
			64265, 64269, 64270
		},
		max = 3
	},
	{
		name_save = "RiftboundCache",
		name_quest = "Тайник Разлома",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {
			64470, 64471, 64472, 64456
		},
		max = 4
	},
	{
		name_save = "ZovaalsVault",
		name_quest = "Хранилище Зоваала",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {
			64283
		},
		max = 1
	},
	{
		name_save = "SpectralBoundChest",
		name_quest = "Сундук с призрачным замком",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "RIFT",
		questID = {
			64247
		},
		max = 1
	},
	{
		name_save = "HelswornChest",
		name_quest = "Сундук Верных Хелии",
		reset = "Daily",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {
			64256
		},
		max = 1
	},
	{
		name_save = "Mobs",
		name_quest = "Мобы",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64341, 64342, 64343, 64344, 64747, 64748, 64749, 64750, 64751, 64752, 64753, 64754, 64755, 64756, 64757
		},
		max = 3
	},
	{
		name_save = "RelicGorger",
		name_quest = "Поглотитель реликвий",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64433, 64434, 64435, 64436
		},
		max = 4
	},
	{
		name_save = "Collection",
		name_quest = "Сбор",
		reset = "Daily",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64351, 64354, 64355, 64356, 64357, 64358, 64359, 64360, 64361, 64362, 64021, 64363, 64364, 64316, 64317, 64318, 64564, 64565
		},
		max = 18
	},
	{
		name_save = "Quest",
		name_quest = "Утроба",
		reset = "Daily",
		expansion = "SL",
		place = "Maw",
		desc = "",
		questID = {
			60646, 60762, 60775, 61075, 61079, 61088, 61103, 61104, 61765, 62214, 62234
		},
		max = 3
	},
	{
		name_save = "Rares",
		name_quest = "Рарки",
		reset = "Weekly",
		expansion = "SL",
		place = "Korthia",
		desc = "",
		questID = {
			64457, 64338, 64442, 64278, 64245, 64246, 64263, 64428, 64258, 64233, 64349, 63830, 64243, 64291, 64455, 64320, 64313, 64284, 64285, 64257, 64440, 64276, 64272, 64232, 64251, 64152, 64439
		},
		max = 23
	},
	{
		name_save = "ResearchReportRelicExaminationTechniques",
		name_quest = "Отчет об исследованиях: методика изучения реликвий",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64367
		},
		max = 1
	},
	{
		name_save = "VaultAnimaTracker",
		name_quest = "Детектор украденной анимы",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64061
		},
		max = 1
	},
	{
		name_save = "ResearchReportAllSeeingCrystal",
		name_quest = "Отчет об исследованиях: всевидящий кристалл",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64339
		},
		max = 1
	},
	{
		name_save = "TreatiseRecognizingStygiaanditsUses",
		name_quest = "Исследование: распознавание стигии и ее применение",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64307
		},
		max = 1
	},
	{
		name_save = "TreatiseBondsofStygiainMortals",
		name_quest = "Исследование: узы стигии в смертных",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64828
		},
		max = 1
	},
	{
		name_save = "ResearchReportAncientShrines",
		name_quest = "Отчет об исследованиях: древние святилища",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64348
		},
		max = 1
	},
	{
		name_save = "TreatiseTheStudyofAnimaandHarnessingEveryDrop",
		name_quest = "Исследование: свойства и эффективное использование анимы",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64027
		},
		max = 1
	},
	{
		name_save = "TreatiseRelicsAboundintheShadowlands",
		name_quest = "Исследование: поиски реликвий в Темных Землях",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64366
		},
		max = 1
	},
	{
		name_save = "ResearchReportAdaptiveAlloys",
		name_quest = "Отчет об исследованиях: адаптивные сплавы",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64300
		},
		max = 1
	},
	{
		name_save = "ResearchReportFirstAlloys",
		name_quest = "Отчет об исследованиях: первые сплавы",
		reset = "Once",
		expansion = "SL",
		place = "Korthia",
		desc = "ITEM",
		questID = {
			64303
		},
		max = 1
	},
	{
		name_save = "Events",
		name_quest = "Пещера Заралек (события)",
		reset = "Daily",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {
			75612, 75471, 75455, 75664, 75611, 75478, 75451, 75461, 75705, 75454, 75450, 75222, 75370, 75494, 75441, 75156, 75624, 74352
		},
		max = 18
	},
	{
		name_save = "Rares",
		name_quest = "Рарки",
		reset = "Daily",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {
			75271, 75285, 75298, 75326, 75576, 75314, 75296, 75353, 75358, 75274, 75366, 75336, 75269, 75334, 75322, 75267, 75476, 75276, 75342, 75338, 75340, 75360, 75292, 75349, 75364
		},
		max = 25
	},
	{
		name_save = "AWorthyAllyLoammNiffen",
		name_quest = L["A Worthy Ally: Loamm Niffen"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "ZaralekCavern",
		questID = {
			75665
		},
		max = 1
	},
	{
		name_save = "Sniffenseeking",
		name_quest = "нюхорысканье",
		reset = "Weekly",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {
			75459, 76027, 75621, 75397, 75517, 75619, 76014, 75620, 76081, 75390, 75234, 75516, 75996, 76016, 75393, 76015, 76084
		},
		max = 17
	},
	{
		name_save = "SniffenseekingItems",
		name_quest = "нюхорысканье (Items)",
		reset = "Weekly",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {
			75771, 75772, 75767, 75768, 75765, 75936, 75766, 75769, 75770, 75998, 75773, 76004,
		},
		max = 12,
	},
	{
		name_save = "Storylines",
		name_quest = "Storylines: ".. L["Zaralek Cavern"],
		reset = "Once",
		expansion = "DF",
		place = "ZaralekCavern",
		desc = "",
		questID = {
			--74381, 73076, 72712, 72713, 72545, 73094, 72714, 72715, 73137, 72717, 72975, 75456, 72976,
			72977, 72978, 72981, 72873, 72872, 72970, 72980, 72874, 72979, 72973, 72974, 75643, 75644, 74334, 72958, 74375, 72959, 72961, 72962, 75419, 72963, 72964, 72965, 72966, 72908, 72909, 72910, 72911, 72912, 72913, 72914, 72915, 72916, 74494, 72917, 72918, 72919, 72920, 75145, 72987, 75367, 74393, 74538, 74539, 74540, 74542, 74557, 74562, 74563, 72922, 72923, 72924, 72925, 72926, 72928, 72931, 72927, 72929, 72930, 74521, 74522, 74523, 74525, 75018, 75028, 75029, 75417,
		},
		max = 67, -- 80-13
	},
	{
		name_save = "Storylines",
		name_quest = "Storylines: ".. L["Dawn of the Infinites"],
		reset = "Once",
		expansion = "DF",
		place = "DawnoftheInfinites",
		desc = "",
		questID = {
			76140,76142,76143,76144,76145,76146,76147,76141,
		},
		max = 8,
	},
	{
		name_save = "Rares",
		name_quest = "Рарки",
		reset = "Daily",
		expansion = "DF",
		place = "TheForbiddenReach",
		desc = "",
		questID = {
			74331, 74347, 74345, 74336, 74337, 74342, 74321, 74343, 74338, 74329, 74307, 74325, 74346, 74344, 74332, 74306, 74333, 74341, 74305, 74339, 74300, 74349, 74322, 74330, 74328
		},
		max = 25
	},
	{
		name_save = "CommunityFeast",
		name_quest = L["Community Feast"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			70893
		},
		max = 1
	},
	{
		name_save = "DragonbaneKeep",
		name_quest = L["Siege on Dragonbane Keep"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			70866
		},
		max = 1
	},
	{
		name_save = "TheGrandHunt",
		name_quest = L["Grand Hunt"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			70906
		},
		max = 1
	},
	{
		name_save = "StormsFury",
		name_quest = L["The Storm's Fury"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			73162
		},
		max = 1
	},
	{
		name_save = "KeysofLoyalty",
		name_quest = L["Keys of Loyalty"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			66133
		},
		max = 1
	},
	{
		name_save = "StormBoundChest",
		name_quest = L["Storm-Bound Chest"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			74567
		},
		max = 1
	},
	{
		name_save = "ResearchersUnderFire",
		name_quest = L["Researchers Under Fire"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75630, -- MAW_BUFF_QUALITY_STRING_EPIC Epic
			75629, -- MAW_BUFF_QUALITY_STRING_RARE Rare
			75628, -- MAW_BUFF_QUALITY_STRING_UNCOMMON Uncommon
			75627, -- MAW_BUFF_QUALITY_STRING_COMMON Common
		},
		max = 4
	},
	{
		name_save = "FyrakkAssaults",
		name_quest = L["Fyrakk Asssaults"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			74501, 75280
		},
		max = 1
	},
	{
		name_save = "DiscipleofFyrakk",
		name_quest = L["Disciple of Fyrakk"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75467
		},
		max = 1
	},
	{
		name_save = "Timewalk_500CURRENCY",
		name_quest = PLAYER_DIFFICULTY_TIMEWALKER.."(500 cur)",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			40173, 64710, 40168, 40786, 45563, 55499, 55498, 40787
		},
		max = 1
	},
	{
		name_save = "Timewalk_RAIDS_Cataclysm",  -- Cataclysm
		name_quest = "Timewalk_RAIDS_Cataclysm",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			57637,
		},
		max = 1
	},
	{
		name_save = "Timewalk_RAIDS_BurningCrusade", -- Burning Crusade
		name_quest = "Timewalk_RAIDS_BurningCrusade",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			47523,
		},
		max = 1
	},
	{
		name_save = "Timewalk5DUNGEONS",
		name_quest = PLAYER_DIFFICULTY_TIMEWALKER.."Timewalk5DUNGEONS",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72727, 72810, 72719, 72725, 72726, 72724
		},
		max = 1
	},
	{
		name_save = "AidingtheAccord",
		name_quest = L["Aiding the Accord"], -- "Помощь союзу",
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72068, 72373, 72374, 72375, 75259, 70750, 75859, 75860, 75861, 77254, 77976
		},
		max = 1
	},
	{
		name_save = "FightingisItsOwnReward",
		name_quest = L["Fighting is Its Own Reward"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			76122
		},
		max = 1
	},
	{
		name_save = "Shadowmourne",
		name_quest = "Темная Скорбь",
		reset = "Once",
		expansion = "WotLK",
		place = "",
		desc = "",
		questID = {
			24545, 24743, 24547, 24749, 24756, 24757, 24548, 24549, 24748
		},
		max = 9
	},
	{
		name_save = "Warlock_GreenFire",
		name_quest = L["Green Fire"],
		reset = "Once",
		expansion = "MoP",
		place = "",
		desc = "",
		questID = {
			32295, 32307, 32309, 32310, 32317, 32324, 32325
		}, -- 32340
		max = 7
	},
	{
		name_save = "Warlock_SomeWickedThings",
		name_quest = L["Some Wicked Things"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75538, 75539, 75540, 75541, 75542, 75639, 75543, 75544, 76427, 76430, 76410, 76155,
		},
		max = 12
	},
	{
		name_save = "PatternsWithinPatterns",
		name_quest = "Закономерности в закономерностях",
		reset = "Weekly",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			66042
		},
		max = 1
	},
	{
		name_save = "Rares",
		name_quest = "Рарки",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65557, 65547, 65581, 65579, 63988, 65552, 65582, 64668, 64716, 64719, 65548, 65550, 65239, 65585, 65586, 65587, 65583, 65580, 65553, 65544, 65240, 65241, 65556, 65584, 65551, 65251, 65257, 65272, 65574, 65273, 65555, 65549
		},
		max = 25
	},
	{
		name_save = "RaresDuneDominance",
		name_quest = "Рарки (Дюны)",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65585, 65586, 65587
		},
		max = 3
	},
	{
		name_save = "worldQuests",
		name_quest = "worldQuests",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			64960, 64974, 65081, 65089, 65102, 65115, 65117, 65119, 65230, 65232, 65234, 65244, 65252, 65262, 65402, 65403, 65404, 65405, 65406, 65407, 65408, 65410, 65411, 65412, 65413, 65414, 65415, 65416, 65417, 65231
		},
		max = 3
	},
	{
		name_save = "TREASURES",
		name_quest = "TREASURES",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65520, 65573, 65489, 64667, 65465, 65523, 65487, 65503, 65178, 65480, 65545, 65173, 65441, 65522, 65537, 65536, 65542, 65546, 65540, 65566, 65447, 65543, 64545, 65270, 65565, 65175
		},
		max = 36
	},
	{
		name_save = "GetLockStatus",
		name_quest = "GetLockStatus",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65589, 65590, 65591, 65592
		},
		max = 4
	},
	{
		name_save = "UndulatingFoliage",
		name_quest = "UndulatingFoliage",
		reset = "Once",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65572
		},
		max = 1
	},
	{
		name_save = "CatchingUp",
		name_quest = "Наверстываем!",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			67100, 67137, 67295, 67564, 69946, 69979,
		},
		max = 6
	},
	{
		name_save = "PryingEyeDiscovery",
		name_quest = "ZM_PryingEyeDiscovery",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65184, 65501, 65611
		},
		max = 1
	},
	{
		name_save = "PUZZLECACHES",
		name_quest = "PUZZLECACHES",
		reset = "Daily",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65094, 65323, 65318, 65322, 65317, 65093, 65321, 65092, 65316, 65412, 65315, 65091, 65320, 64972, 65314, 65319
		},
		max = 50
	},
	{
		name_save = "Concordance",
		name_quest = "Concordance",
		reset = "Once",
		expansion = "SL",
		place = "ZM",
		desc = "",
		questID = {
			65179, 65213, 65216, 65210, 65180, 65214, 65211, 65217, 64940, 65212, 65209, 65215,
		},
		max = 12
	},
	{
		name_save = "coinsQuests",
		name_quest = "coinsQuests WoD",
		reset = "Weekly",
		expansion = "WoD",
		place = "",
		desc = "",
		questID = {
			36058, 36055, 37452, 37453, 36056, 37457, 37456, 36054, 37455, 37454, 36057, 37458, 37459
		},
		max = 3,
	},
	{
		name_save = "coinsQuests",
		name_quest = "coinsQuests Legion",
		reset = "Weekly",
		expansion = "Legion",
		place = "",
		desc = "",
		questID = {
			43895, 43897, 43896, 43892, 43893, 43894, 47851, 47864, 47865, 43510
		},
		max = 3,
	},
	{
		name_save = "coinsQuests",
		name_quest = "coinsQuests BfA",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			52835, 52834, 52837, 52840, 52838, 52839
		},
		max = 2,
	},
	{
		name_save = "miniVision",
		name_quest = "miniVision",
		reset = "Daily",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			58168, 58155, 58151, 58167, 58156
		},
		max = 1,
	},
	{
		name_save = "AssaultTheBlackEmpire",
		name_quest = "Assault: The Black Empire",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			56064, 57728, 55350, 57157
		},
		max = 2,
	},
	{
		name_save = "Warfront1",
		name_quest = "Warfront1",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			53416, 53414
		},
		max = 1,
	},
	{
		name_save = "Warfront2",
		name_quest = "Warfront2",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			53955, 53992
		},
		max = 1,
	},
	{
		name_save = "WarfrontHC",
		name_quest = "WarfrontHC",
		reset = "Weekly",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			56137, 56136, 57959, 57960
		},
		max = 1,
	},
	{
		name_save = "BalanceofPower",
		name_quest = "Balance of Power",
		reset = "Once",
		expansion = "Legion",
		place = "",
		desc = "",
		questID = {
			43496, 43503, 43501, 43505, 40668, 43514, 43517, 43518, 43519, 43581, 43520, 43521, 43522, 43938, 43527, 43937, 43523, 40673, 43524, 40675, 43525, 40678, 43526, 40603, 40608, 40613, 40614, 40672, 40615, 43898, 43528, 43530, 43531, 43532, 43533,
		},
		max = 33,
	},
	{
		name_save = "InvasionQuests",
		name_quest = "Invasion Quests",
		reset = "Daily",
		expansion = "BfA",
		place = "",
		desc = "",
		questID = {
			54134, 54136, 53711, 53701, 54138, 51982,
			53883, 54137, 53885, 53939, 54135, 54132,
		},
		max = 1,
	},
	{
		name_save = "InvasionQuests",
		name_quest = "Invasion Quests",
		reset = "Daily",
		expansion = "Legion",
		place = "",
		desc = "",
		questID = {
			45838, 45812, 45840, 45839
		},
		max = 1,
	},
	{
		name_save = "ArmiesofLegionfall",
		name_quest = "Broken Shore - Armies of Legionfall",
		reset = "Once",
		expansion = "Legion",
		place = "BrokenShore",
		desc = "",
		questID = {
			46730, 46734, 46286, 46832, 46845, 46245, 46244, 46247, 47137, 46251, 47139, 46248, 46252, 46769, 46250, 46249, 46246,
		},
		max = 17,
	},
	{
		name_save = "AberrustheShadowedCrucibleSarkareth",
		name_quest = "Aberrus, the Shadowed Crucible: Sarkareth",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75694,
		},
		max = 1,
	},
	{
		name_save = "VaultoftheIncarnatesFuryoftheStormEater",
		name_quest = "Vault of the Incarnates: Fury of the Storm-Eater",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			66847,
		},
		max = 1,
	},
	{
		name_save = "Excavations",
		name_quest = "Broken Shore - Excavations",
		reset = "Once",
		expansion = "Legion",
		place = "BrokenShore",
		desc = "",
		questID = {
			46499, 46501, 46509, 46510, 46511, 46666
		},
		max = 6,
	},
	--------------------------------
	{
		name_save = "ToArgus",
		name_quest = "Broken Shore - To Argus!",
		reset = "Once",
		expansion = "Legion",
		place = "Argus",
		desc = "",
		questID = {
			46734, 48507,
			47221, 47835, 47222, 47867, 47223, 47224, 48440, 46938, 47589, 46297, 48483, 47627, 47641, 46732, 46816, 46839, 46840, 46841, 46842, 46843, 48500, 47431, 46213, 40238, 47541, 47508, 47771, 47526, 47754, 47653, 47743, 49143, 47287, 48559, 48199, 48200, 48201, 48202, 47473, 47889, 47890, 47891, 47892, 47986, 47987, 47988, 47991, 47990, 47989, 47992, 47993, 47994, 48081, 46815, 46818, 46834, 47066, 46941, 47686, 47882, 47688, 47883, 47689, 47685, 47687, 47690, 48107, 48461, 48344, 47691, 47854, 47995, 47853, 48345, 47855, 47856, 47416, 47238, 40761, 47101, 47180, 47100, 47183, 47184, 47203, 47217, 47218, 47219, 47220, 48560, 47654,
		},
		max = 93,
	},
	{
		name_save = "blingtron",
		name_quest = "blingtron",
		reset = "Daily",
		expansion = "",
		place = "",
		desc = "",
		questID = {
			31752, 34774, 40753, 56042
		},
		max = 1,
	},
	{
		name_save = "TimeRift",
		name_quest = L["TimeRift"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77836,
		},
		max = 1,
	},
	{
		name_save = "DreamsurgeInvestigation",
		name_quest = L["Dreamsurge Investigation"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77414,
		},
		max = 1,
	},
	{
		name_save = "ShapingtheDreamsurge",
		name_quest = L["Shaping the Dreamsurge"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77251,
		},
		max = 1,
	},
	{
		name_save = "WhenTimeNeedsMending", -- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(77236), E.Octo_Func.CheckCompletedByQuestID(77236)} -- 1 на аккаунт
		name_quest = L["When Time Needs Mending"],
		reset = "Weekly",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77236,
		},
		max = 1,
	},
	{
		name_save = "Rares",
		name_quest = "Darkshore - Rares",
		reset = "Daily",
		expansion = "BfA",
		place = "Darkshore",
		desc = "",
		questID = {
			54695, 54696, -- id = 148787
			54405, 54406, -- id = 147966,
			54285, 54286, -- id = 147744,
			54278, 54279, -- id = 147708,
			54426, 54427, -- id = 148025,
			54232, 54233, -- id = 147260,
			54229, 54230, -- id = 147241,
			54884, 54885, -- id = 149654,
			54234, 54235, -- id = 147261,
			54428, 54429, -- id = 148031,
			54227, 54228, -- id = 147240,
			54887, 54888, -- id = 149657,
			54408, 54409, -- id = 147970,
			54893, 54894, -- id = 149665,
			54289, 54290, -- id = 147751,
			54320, 54321, -- id = 147897,
			54247, 54248, -- id = 147332,
			54397, 54398, -- id = 147942,
			--------------------HORDE --------------------
			54431, -- id = 148037,
			54890, -- id = 149651,
			54891, -- id = 149656,
			54291, -- id = 147758,
			54452, -- id = 148103,
			54892, -- id = 149658,
			54252, -- id = 147435,
			------------------ ALLIANCE ------------------ -
			54883, -- id = 149652,
			54768, -- id = 149141,
			54309, -- id = 147845,
			54886, -- id = 149661,
			54277, -- id = 147701,
			54889, -- id = 149664,
			54274, -- id = 147664,
		},
		max = 25,
	},
	{
		name_save = "SummerFestival",
		name_quest = "Summer Festival",
		reset = "Month",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			9324, 9325, 9326, 9330, 9331, 9332, 11580, 11581, 11583, 11584, 11732, 11734, 11735, 11736, 11737, 11738, 11739, 11740, 11741, 11742, 11743, 11744, 11745, 11746, 11747, 11749, 11750, 11751, 11752, 11753, 11754, 11755, 11756, 11757, 11758, 11759, 11760, 11761, 11762, 11763, 11764, 11765, 11766, 11767, 11768, 11769, 11770, 11771, 11772, 11773, 11774, 11775, 11776, 11777, 11778, 11779, 11780, 11781, 11782, 11783, 11784, 11786, 11787, 11799, 11800, 11801, 11802, 11803, 11804, 11805, 11806, 11807, 11808, 11809, 11810, 11811, 11812, 11813, 11814, 11815, 11816, 11817, 11818, 11820, 11821, 11822, 11823, 11824, 11825, 11826, 11827, 11828, 11829, 11830, 11831, 11832, 11833, 11834, 11835, 11836, 11837, 11838, 11839, 11840, 11841, 11842, 11843, 11844, 11845, 11846, 11847, 11848, 11849, 11850, 11851, 11852, 11853, 11854, 11855, 11856, 11857, 11858, 11859, 11860, 11862, 11863, 11933, 11935, 13440, 13441, 13442, 13443, 13444, 13445, 13446, 13447, 13449, 13450, 13451, 13453, 13454, 13455, 13457, 13458, 13485, 13486, 13487, 13488, 13489, 13490, 13491, 13492, 13493, 13494, 13495, 13496, 13497, 13498, 13499, 13500, 28910, 28911, 28912, 28913, 28914, 28915, 28916, 28917, 28918, 28919, 28920, 28921, 28922, 28923, 28924, 28925, 28926, 28927, 28928, 28929, 28930, 28931, 28932, 28933, 28943, 28944, 28945, 28946, 28947, 28948, 28949, 28950, 29030, 29031, 29036, 32496, 32497, 32498, 32499, 32500, 32501, 32502, 32503, 32509, 32510, 44570, 44571, 44572, 44573, 44574, 44575, 44576, 44577, 44579, 44580, 44582, 44583, 44613, 44614, 44624, 44627, 54736, 54737, 54739, 54741, 54742, 54743, 54744, 54745, 54746, 54747, 54749, 54750, 75398, 75617, 75640, 75645, 75647, 75650,
		},
		max = 131,
	},
	{
		name_save = "TheEasternKingdomsCupBegins",
		name_quest = "The Eastern Kingdoms Cup Begins",
		reset = "Month",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77839,
		},
		max = 1,
	},
	{
		name_save = "Brewfest",
		name_quest = "Brewfest",
		reset = "Month",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77155, 77152, 77153, 77747, 76531, 77099, 77745, 77095, 77746, 77096, 77744, 77097,
		},
		max = 12,
	},
	{
		name_save = "Brewfest_BarrelingDown", --Делай бочку https://ru.wowhead.com/quest=77208 D
		name_quest = "Barreling Down",
		reset = "Daily",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			-- Alliance
			77208, -- Horde
		},
		max = 1,
	},
	{
		name_save = "Brewfest_BubblingBrews", --Пузырящийся напиток https://ru.wowhead.com/quest=76591 D
		name_quest = "Bubbling Brews",
		reset = "Daily",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			76591, -- Alliance -- Horde
		},
		max = 1,
	},
	{
		name_save = "Brewfest_DirebrewsDireBrew", --Худое варево Худовара https://www.wowhead.com/ru/quest=12492/
		name_quest = "Direbrew's Dire Brew",
		reset = "Month",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			12491,
			12492, -- Alliance -- Horde
		},
		max = 1,
	},
	{
		name_save = "TemporalAcquisitionsSpecialist", -- https://www.wowhead.com/ru/achievement = 18554/
		name_quest = "Temporal Acquisitions Specialist",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			-- Azmourne - Scourge:
			76406, -- https://www.wowhead.com/quest = 76406/the-sins-of-the-ashbringer
			76547, -- https://www.wowhead.com/quest = 76547/all-that-glitters
			-- A.Z.E.R.O.T.H. - Mecha:
			76521, -- https://www.wowhead.com/quest = 76521/buzzing-boffins
			76404, -- https://www.wowhead.com/quest = 76404/cogs-in-a-machine
			-- Azmerloth - Murlocs:
			76548, -- https://www.wowhead.com/quest = 76548/a-fishy-gift
			76379, -- https://www.wowhead.com/quest = 76379/a-murloc-and-a-dragon-walk-into-a-time-rift
			-- Azewrath - Fel/Demons:
			76459, -- https://www.wowhead.com/quest = 76459/the-resistance
			76362, -- https://www.wowhead.com/quest = 76362/an-antlered-skull
			-- Azq'roth - Void/Black Empire:
			76546, -- https://www.wowhead.com/quest = 76546/mantid-methodology
			76453, -- https://www.wowhead.com/quest = 76453/a-stony-reception
			-- Warlands - Alliance/Horde:
			76544, -- https://www.wowhead.com/quest = 76544/wasteland-warriors
			76449, -- https://www.wowhead.com/quest = 76449/the-endless-conflict
			-- Ulderoth - Titans:
			76351, -- https://www.wowhead.com/quest = 76351/titanic-beasts
			76533, -- https://www.wowhead.com/quest = 76533/dangerous-documentation
		},
		max = 14,
	},
	{
		name_save = "TheVeiledOssuary",
		name_quest = L["The Veiled Ossuary"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			-- The Veiled Ossuary (Тайных склеп)
			72900, 72921, 72933, 72934, 73069, 75023, 72935,
			72936, 72937, 72938, -- Нексус
			-- 72940, 73399, 73404, 73405, 73406, -- НЕ УЧИТЫВАТЬ
			-- Лес хрусталльной песни
			73091,
			73090, 72670, 72674, 72679, 74783,
			-- Пиратская бухта
			73026,
			72988, 72527, 72529, 72530, 72532, 72533, 72534, 73181,
			-- Нефритовый лес
			73227,
			72650, 72651, 72653, 72654, 72652, 72655, 74291,
			-- Терамор
			72939,
			73188, 72831, 72832, 72833, 74335,
			-- Зимние Ключи
			72656,
			72657, 74354, 72659, 72660, 72661, 74356,
			-- United Again
			75244, 72942, 72946, 72947, 72948, 72949, 72950, 72951,
		},
		max = 54,
	},
	{
		name_save = "TyrsFall",
		name_quest = L["Tyr's Fall"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			72440, 72441, 72442, 72526, 72443, 72444, -- Tyr's Fall
		},
		max = 6,
	},
	{
		name_save = "ReforgingtheTyrsGuard",
		name_quest = L["Reforging the Tyr's Guard"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75632, 75633, 75634, 76171, 75950, 75951, 75952, 75953, 75635, 76176, 75636, 75637, 75638, -- Reforging the Tyr's Guard
		},
		max = 13,
	},
	{
		name_save = "TheCoalitionofFlames",
		name_quest = L["The Coalition of Flames"],
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			76982, 75918, 75919, 75920, 75921, 75922, 75923,
		},
		max = 7,
	},
	{
		name_save = "DarkmoonFaire",
		name_quest = "Darkmoon Faire",
		reset = "Daily",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
	-- { name="1. Большая Крутая Гонка", id=37911},
	-- { name="2. В яблочко!", id=29438},
	-- { name="3. Вызов огнекрыла", id=36481},
	-- { name="4. Гноллобой", id=29463},
	-- { name="5. Искусство быть пушечным ядром", id=29436},
	-- { name="6. Командир танка", id=29434},
	-- { name="7. Крутая Гонка", id=37910},
	-- { name="8. Цель: черепаха", id=29455},
	-- { name="9. Танцы Новой Луны", id=64783},
	--{ name="Боец арены", id=29760},
	--{ name="Великий стратег", id=29451},
	--{ name="Вражеский знак различия", id=29457},
	--{ name="Гибель матери стаи", id=33354},
	--{ name="Джокер из колоды Железа", id=35504},
	--{ name="Загадочный гримуар", id=29445},
	--{ name="Захваченное знамя", id=29456},
	--{ name="Захваченный дневник", id=29458},
	--{ name="Изготовление призов", id=29517},
	--{ name="Изумительное оружие", id=29446},
	--{ name="Инструменты ворожбы", id=29464},
	--{ name="Интересный кристалл", id=29443},
	--{ name="Испытай свою силу", id=29433},
	--{ name="Коктейль с пузырьками", id=29506},
	--{ name="Колода карт Новолуния: Аристократы", id=13326},
	--{ name="Колода карт Новолуния: Безумие", id=10941},
	--{ name="Колода карт Новолуния: Благословения", id=10938},
	--{ name="Колода карт Новолуния: Бык", id=30450},
	--{ name="Колода карт Новолуния: Вихри", id=10939},
	--{ name="Колода карт Новолуния: Вулканы", id=27664},
	--{ name="Колода карт Новолуния: Журавль", id=30449},
	--{ name="Колода карт Новолуния: Звери", id=7907},
	--{ name="Колода карт Новолуния: Землетрясения", id=27667},
	--{ name="Колода карт Новолуния: Змея", id=30451},
	--{ name="Колода карт Новолуния: Нежить", id=13327},
	--{ name="Колода карт Новолуния: Полководцы", id=7928},
	--{ name="Колода карт Новолуния: Порталы", id=7927},
	--{ name="Колода карт Новолуния: Призмы", id=13324},
	--{ name="Колода карт Новолуния: Тигр", id=30452},
	--{ name="Колода карт Новолуния: Ураганы", id=27665},
	--{ name="Колода карт Новолуния: Хаос", id=13325},
	--{ name="Колода карт Новолуния: Цунами", id=27666},
	--{ name="Колода карт Новолуния: Элементали", id=7929},
	--{ name="Колода карт Новолуния: Ярость", id=10940},
	--{ name="Кстати, о танках", id=29511},
	--{ name="Лягушки с хрустящей корочкой", id=29509},
	--{ name="Малышке нужны новые подковы", id=29508},
	--{ name="Мастер-боец арены", id=29761},
	--{ name="Морской хот-дог", id=29513},
	--{ name="Необычное яйцо", id=29444},
	--{ name="Отскоблить шкуры", id=29519},
	--{ name="Повторное использование и переработка", id=29518},
	--{ name="Потомство Жабжаб", id=7946},
	--{ name="Предсказание будущего", id=29515},
	--{ name="Пусть ярмарка сверкает", id=29516},
	--{ name="Развлечения для самых маленьких", id=29507},
	--{ name="Справочник ярмарки Новолуния", id=29601},
	--{ name="Ты найдешь свою удачу...", id=7937},
	--{ name="Ты найдешь свою удачу...", id=7944},
	--{ name="Ты найдешь свою удачу...", id=7945},
	--{ name="Утилизация хлама", id=29510},
	--{ name="Флаги, флаги повсюду!", id=29520},
	--{ name="Целебные травы", id=29514},
			37911,29438,36481,29463,29436,29434,37910,29455,64783,
		},
		max = 9,
	},
	{
		name_save = "WarcraftRumble",
		name_quest = "Warcraft Rumble",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			73182,
			75039,
			74850,
			74851,
			75036,
			73928,
			75040,
			73936,
			75041,
			75037,
			74852,
			74843,
			75038,
			73180,
			74849,
			74287,
			74845,
			74848,
			73952,
			74286,
			74844,
		},
		max = 21,
	},
}
local function FUNC_PROF_TEST()
	-- https://wowpedia.fandom.com/wiki/API_GetProfessions
	-- https://wowpedia.fandom.com/wiki/API_GetProfessionInfo
	-- https://wowpedia.fandom.com/wiki/API_C_TradeSkillUI.GetProfessionSkillLineID
	for k, v in pairs(Enum.Profession) do
		print (C_TradeSkillUI.GetProfessionSkillLineID(v))
	end
	-- local ProfTable = {}
	-- local prof1, prof2, archaeology, fishing, cooking = GetProfessions()
	-- if prof1 then tinsert(ProfTable, prof1) end
	-- if prof2 then tinsert(ProfTable, prof2) end
	-- if archaeology then tinsert(ProfTable, archaeology) end
	-- if fishing then tinsert(ProfTable, fishing) end
	-- if cooking then tinsert(ProfTable, cooking) end
	-- for k, v in pairs(ProfTable) do
	-- 	local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(v)
	-- 	print (tostringall(name, E.Octo_Func.func_texturefromIcon(icon), skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset))
	-- end
end
-- for e, r in pairs(E.Octo_Table.ALL_Professions) do
-- 	if r == skillLine or r == skillModifier then
-- 		print (e, r, name)
-- 	end
-- end
local function Central_Frame_Mouse_OnEnter(self)
	local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
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
	GameTooltip:Hide()
end
local function CheckReputationByRepID(self)
	local vivod = ""
	local friendshipRank, friendshipMaxRank
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched, isChild, _, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(self)
	local color = E.Octo_Globals.White_Color
	local r = "|r"
	local standingTEXT = ""
	if standingID == 1 then
		color = E.Octo_Globals.Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL1..")"
	elseif standingID == 2 then
		color = E.Octo_Globals.Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL2..")"
	elseif standingID == 3 then
		color = E.Octo_Globals.Orange_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL3..")"
	elseif standingID == 4 then
		color = E.Octo_Globals.Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL4..")"
	elseif standingID == 5 then
		color = E.Octo_Globals.Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL5..")"
	elseif standingID == 6 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL6..")"
	elseif standingID == 7 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL7..")"
	elseif standingID == 8 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL8..")"
	elseif standingID == 9 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL9..")"
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(self or 0)
	if C_Reputation.IsFactionParagon(self) then
		local currentValue = C_Reputation.GetFactionParagonInfo(self) or 0
		local threshold = 1
		local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(self)
		if threshold then
			local value = currentValue % threshold
			vivod = E.Octo_Globals.Blue_Color..(value).."/"..(threshold)..r
			if hasRewardPending then
				vivod = E.Octo_Func.CheckCompletedByQuestID(rewardQuestID)
			end
		end
	elseif C_Reputation.IsMajorFaction(self) then
		local data = C_MajorFactions.GetMajorFactionData(self)
		local currentValue = data.renownReputationEarned
		local totalValue = data.renownLevelThreshold
		local standing = data.renownLevel
		vivod = (currentValue).."/"..(totalValue)..E.Octo_Globals.Green_Color.."("..(standing)..")|r"
		if standing == 0 then vivod = 0 end
	elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
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
		standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
		vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
		if currentLevel == maxLevel then vivod = E.Octo_Globals.Green_Color.."Done|r" end
	else
		if barValue then
			local currentValue = barValue-barMin
			local totalValue = barMax-barMin
			vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
			if currentValue == totalValue or nextThreshold == 0 then vivod = E.Octo_Globals.Green_Color.."Done|r" end
		end
	end
	return vivod
end
local function checkCharInfo(self)
	--------------------------------
	-- УДАЛЕНИЕ ------------------------------
	--------------------------------
	--------------------------------
	self.AberrusTransmog = {}
	if self.needResetWeekly == true then
		self.journalInstance = {}
		self.RIO_weeklyBest = 0
		self.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count = E.Octo_Globals.NONE
	end
	if self.journalInstance == nil or self.journalInstance == 0 then
		self.journalInstance = {}
	end
	local ServerTime = GetServerTime()
	for k, v in pairs(self.journalInstance) do
		if k then
			for q, w in pairs(v) do
				for e, r in pairs(w) do
					if e == "instanceReset" then
						-- print (k, q, e, r, GetServerTime())
						if ServerTime >= r then
							self.journalInstance[k] = {}
							-- k это ИД инста
							-- Q это ИД сложности
						end
					end
				end
			end
		end
	end
	----if self.needResetDaily then self.journalInstance = {} end -- ДЕЙЛИ РЕСЕТ
	-- setmetatable(self.journalInstance[v][w], Meta_Table_Empty)
	-- setmetatable(self.journalInstance[v], Meta_Table_Empty)
	for k, v in pairs(OctoTable_UniversalQuest) do
		for q, w in pairs(v) do
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] or E.Octo_Globals.NONE
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] or E.Octo_Globals.NONE
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] or E.Octo_Globals.NONE
		end
	end
	self.LFGInstance = self.LFGInstance or {}
	for dungeonID, name in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
		self.LFGInstance[dungeonID] = self.LFGInstance[dungeonID] or {}
		self.LFGInstance[dungeonID].D_name = self.LFGInstance[dungeonID].D_name or name
		self.LFGInstance[dungeonID].donetoday = self.LFGInstance[dungeonID].donetoday or E.Octo_Globals.NONE
	end
	self.LFGInstance = self.LFGInstance or {}
	self.professions = self.professions or {}
	self.avgItemLevel = self.avgItemLevel or 0
	self.avgItemLevelEquipped = self.avgItemLevelEquipped or 0
	self.avgItemLevelPvp = self.avgItemLevelPvp or 0
	self.className = self.className or 0
	self.classFilename = self.classFilename or 0
	self.classId = self.classId or 0
	self.classColor = self.classColor or {r = 0.5, g = 0.5, b = 0.5}
	self.curCovID = self.curCovID or 0
	self.CurrencyID = self.CurrencyID or {}
	self.CurrencyID_maxQuantity = self.CurrencyID_maxQuantity or {}
	self.CurrencyID_Total = self.CurrencyID_Total or {}
	self.curServer = self.curServer or "HZ"
	self.azeriteLVL = self.azeriteLVL or 0
	self.azeriteEXP = self.azeriteEXP or 0
	self.cloak_lvl = self.cloak_lvl or 0
	self.cloak_res = self.cloak_res or 0
	self.curServerShort = self.curServerShort or 0
	self.Faction = self.Faction or 0
	self.ItemsInBag = self.ItemsInBag or {}
	self.KnownSpell = self.KnownSpell or {}
	self.maxNumQuestsCanAccept = self.maxNumQuestsCanAccept or 0
	self.Name = self.Name or 0
	self.needResetDaily = self.needResetDaily or false
	self.needResetWeekly = self.needResetWeekly or false
	self.needResetMonth = self.needResetMonth or false
	self.numQuests = self.numQuests or 0
	self.numShownEntries = self.numShownEntries or 0
	self.Possible_Anima = self.Possible_Anima or 0
	self.Possible_CatalogedResearch = self.Possible_CatalogedResearch or 0
	self.loginDate = self.loginDate or 0
	self.loginDay = self.loginDay or 0
	self.loginHour = self.loginHour or 0
	self.PVP = self.PVP or {}
	self.OctoTable_QuestID = self.OctoTable_QuestID or {}
	self.reputationID = self.reputationID or {}
	self.Shadowland = self.Shadowland or {}
	self.totalSlots = self.totalSlots or 0
	self.UnitLevel = self.UnitLevel or 0
	self.Money = self.Money or 0
	self.MoneyOnLogin = self.MoneyOnLogin or 0
	self.usedSlots = self.usedSlots or 0
	self.canUseMountEquipment = self.canUseMountEquipment or false
	self.currentMountItemID = self.currentMountItemID or 0
	self.HasAvailableRewards = self.HasAvailableRewards or false
	self.BindLocation = self.BindLocation or 0
	self.CurrentLocation = self.CurrentLocation or 0
	self.islandBfA = self.islandBfA or 0
	self.bounty_BfA1 = self.bounty_BfA1 or 0
	self.bounty_BfA2 = self.bounty_BfA2 or 0
	self.bounty_BfA3 = self.bounty_BfA3 or 0
	self.bounty_BfA1_end = self.bounty_BfA1_end or 0
	self.bounty_BfA2_end = self.bounty_BfA2_end or 0
	self.bounty_BfA3_end = self.bounty_BfA3_end or 0
	self.bounty_BfA1_questID = self.bounty_BfA1_questID or 0
	self.bounty_BfA2_questID = self.bounty_BfA2_questID or 0
	self.bounty_BfA3_questID = self.bounty_BfA3_questID or 0
	self.bounty_BfA1_icon = self.bounty_BfA1_icon or 0
	self.bounty_BfA2_icon = self.bounty_BfA2_icon or 0
	self.bounty_BfA3_icon = self.bounty_BfA3_icon or 0
	self.bounty_Legion1 = self.bounty_Legion1 or 0
	self.bounty_Legion2 = self.bounty_Legion2 or 0
	self.bounty_Legion3 = self.bounty_Legion3 or 0
	self.bounty_Legion1_end = self.bounty_Legion1_end or 0
	self.bounty_Legion2_end = self.bounty_Legion2_end or 0
	self.bounty_Legion3_end = self.bounty_Legion3_end or 0
	self.bounty_Legion1_questID = self.bounty_Legion1_questID or 0
	self.bounty_Legion2_questID = self.bounty_Legion2_questID or 0
	self.bounty_Legion3_questID = self.bounty_Legion3_questID or 0
	self.bounty_Legion1_icon = self.bounty_Legion1_icon or 0
	self.bounty_Legion2_icon = self.bounty_Legion2_icon or 0
	self.bounty_Legion3_icon = self.bounty_Legion3_icon or 0
	self.hasMail = self.hasMail or false
	self.MoneyOnLogin = self.Money
	self.RIO_Score = self.RIO_Score or 0
	self.RIO_weeklyBest = self.RIO_weeklyBest or 0
	self.PlayerGear = {}
	self.PlayerGear = self.PlayerGear or {}
	for k, v in pairs(Enum.InventoryType) do
		self.PlayerGear[k] = self.PlayerGear[k] or E.Octo_Globals.NONE
	end
	self.GreatVault = self.GreatVault or {}
	for i = 1, 3 do
		self.GreatVault[i] = self.GreatVault[i] or {}
		self.GreatVault[i].progress = self.GreatVault[i].progress or 0
		self.GreatVault[i].threshold = self.GreatVault[i].threshold or 0
		self.GreatVault[i].hyperlink = self.GreatVault[i].hyperlink or {}
		self.GreatVault[i].hyperlink_STRING = self.GreatVault[i].hyperlink_STRING or 0
		self.GreatVault[i].hyperlink[1] = self.GreatVault[i].hyperlink[1] or 0
		self.GreatVault[i].hyperlink[2] = self.GreatVault[i].hyperlink[2] or 0
		self.GreatVault[i].hyperlink[3] = self.GreatVault[i].hyperlink[3] or 0
		if i == 1 then
			self.GreatVault[i].type = self.GreatVault[i].type or MYTHIC_DUNGEONS
		elseif i == 2 then
			self.GreatVault[i].type = self.GreatVault[i].type or CALENDAR_TYPE_PVP
		elseif i == 3 then
			self.GreatVault[i].type = self.GreatVault[i].type or RAIDS
		end
		-- setmetatable(self.GreatVault[i].hyperlink, Meta_Table_0)
	end
	setmetatable(self, Meta_Table_0)
	setmetatable(self.CurrencyID_maxQuantity, Meta_Table_0)
	setmetatable(self.CurrencyID_Total, Meta_Table_0)
	setmetatable(self.CurrencyID, Meta_Table_0)
	setmetatable(self.ItemsInBag, Meta_Table_0)
	setmetatable(self.KnownSpell, Meta_Table_false)
	setmetatable(self.PVP, Meta_Table_0)
	setmetatable(self.OctoTable_QuestID, Meta_Table_NONE)
	setmetatable(self.reputationID, Meta_Table_0)
	setmetatable(self.Shadowland, Meta_Table_0)
	if (self.tmstp_Weekly or 0) < GetServerTime() and (self.GreatVault[1].hyperlink_STRING ~= 0 or self.GreatVault[2].hyperlink_STRING ~= 0 or self.GreatVault[3].hyperlink_STRING ~= 0) then
		self.HasAvailableRewards = true
		self.GreatVault = {}
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() and self.Octopussy_DF_Weekly_CommunityFeast_count == E.Octo_Globals.DONE then
		self.Octopussy_DF_Weekly_CommunityFeast_count = E.Octo_Globals.NONE
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() then
		self.tmstp_Weekly = E.Octo_Func.tmstpDayReset(7)
		self.needResetWeekly = true
		self.CurrentKey = 0
		self.CurrentKeyFULL = 0
		self.CurrentKeyLevel = 0
		for k, v in pairs(OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
	end
	if (self.tmstp_Daily or 0) < GetServerTime() then
		self.tmstp_Daily = E.Octo_Func.tmstpDayReset(1)
		self.needResetDaily = true
		Octo_ToDo_SmartCollectNEW.Holiday.Active = {}
		Octo_ToDoVars.config.AnotherAddonsCasual = false
		Octo_ToDoVars.config.AnotherAddonsRAID = false
		for k, v in pairs(OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
		for dungeonID, v in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
			self.LFGInstance[dungeonID].donetoday = E.Octo_Globals.NONE
		end
		self.bounty_BfA1 = 0
		self.bounty_BfA2 = 0
		self.bounty_BfA3 = 0
		self.bounty_BfA1_end = 0
		self.bounty_BfA2_end = 0
		self.bounty_BfA3_end = 0
		self.bounty_BfA1_questID = 0
		self.bounty_BfA2_questID = 0
		self.bounty_BfA3_questID = 0
		self.bounty_BfA1_icon = 0
		self.bounty_BfA2_icon = 0
		self.bounty_BfA3_icon = 0
		self.bounty_Legion1 = 0
		self.bounty_Legion2 = 0
		self.bounty_Legion3 = 0
		self.bounty_Legion1_end = 0
		self.bounty_Legion2_end = 0
		self.bounty_Legion3_end = 0
		self.bounty_Legion1_questID = 0
		self.bounty_Legion2_questID = 0
		self.bounty_Legion3_questID = 0
		self.bounty_Legion1_icon = 0
		self.bounty_Legion2_icon = 0
		self.bounty_Legion3_icon = 0
	end
	if (self.tmstp_Month or 0) < GetServerTime() then
		self.tmstp_Month = E.Octo_Func.tmstpDayReset(30)
		self.needResetMonth = true
		-- self.ItemsInBag[23247] = 0
		for k, v in pairs(OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
	end
end
local function CreateFrameUsableItems_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 10)
	-------------------------- -
	local startTime, duration = C_Container.GetItemCooldown(self.itemID)
	if startTime ~= nil and startTime ~= 0 then
		GameTooltip:ClearLines()
		GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemID).." ".. E.Octo_Func.SecondsToClock(duration-(GetTime()-startTime)))
		GameTooltip:Show()
		self.icon:SetDesaturated(true)
		self.icon:SetAlpha(.5)
	else
		GameTooltip:ClearLines()
		GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemID))
		GameTooltip:Show()
		self.icon:SetDesaturated(false)
		self.icon:SetAlpha(1)
	end
	-------------------------- -
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == false then
		self.icon:SetVertexColor(1, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnLeave(self)
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) < self.count
	if hasToy == true and hasItem == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, 1, 1, .2)
	end
	-------------------------- -
	local startTime, duration = C_Container.GetItemCooldown(self.itemID)
	if startTime ~= nil and startTime ~= 0 then
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		self.icon:SetDesaturated(true)
		self.icon:SetAlpha(.5)
	else
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		self.icon:SetDesaturated(false)
		self.icon:SetAlpha(1)
	end
	-------------------------- -
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == false then
		self.icon:SetVertexColor(1, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnEvent(self, event)
	if event == "TOYS_UPDATED" or event == "ACTIONBAR_UPDATE_COOLDOWN" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE" then
		local startTime, duration = C_Container.GetItemCooldown(self.itemID)
		local hasToy = PlayerHasToy(self.itemID)
		local hasItem = GetItemCount(self.itemID, true, true, true) < self.count
		if hasToy == true and hasItem == true then
			self.icon:SetDesaturated(false)
			self.icon:SetAlpha(1)
		else
			self.icon:SetDesaturated(true)
			self.icon:SetAlpha(.5)
		end
		if startTime ~= 0 or duration ~= 0 then
			self.icon:SetDesaturated(true)
			self.icon:SetAlpha(.5)
		else
			self.icon:SetDesaturated(false)
			self.icon:SetAlpha(1)
		end
		-------------------------- -
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == false then
			self.icon:SetVertexColor(1, 0, 0, 1)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(OctoFrame_Main_Frame)
		self:SetPoint("BOTTOMLEFT", OctoFrame_Main_Frame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableItems_OnMouseDown(self)
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) < self.count
	if hasToy == true and hasItem == true then
		self.icon:SetVertexColor(1, 0, 0, .1)
	else
		self.icon:SetVertexColor(1, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnMouseUp(self)
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) < self.count
	if hasToy == true and hasItem == true then
		self.icon:SetVertexColor(1, 1, 1, .1)
	else
		self.icon:SetVertexColor(1, 1, 1, 1)
	end
end
local function CreateFrameUsableItems(itemID, Texture, count, Xpos, Ypos, r, g, b, spellID)
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.itemID = itemID
	Button.Texture = Texture
	Button.count = count
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	Button:SetPoint("TOPRIGHT", OctoFrame_Main_Frame, "TOPLEFT", Xpos-1, Ypos)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- Button:SetBackdropBorderColor(r, g, b, 1)
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	-- Button:RegisterEvent("TOYS_UPDATED")
	-- Button:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	-- Button:RegisterEvent("SPELLS_CHANGED")
	-- Button:RegisterEvent("SPELL_UPDATE_CHARGES")
	-- Button:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	-- Button:RegisterEvent("TRAINER_UPDATE")
	Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	-- t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
----------------------------------------------------------------------------------------------
local function CreateFrameUsableSpells_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 10)
	-------------------------- -
	local startTime, duration = GetSpellCooldown(self.spellID)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, 0, 0, .2)
	end
	if startTime ~= nil and startTime ~= 0 then
		GameTooltip:ClearLines()
		GameTooltip:AddLine(E.Octo_Func.func_spellName(self.spellID).." ".. E.Octo_Func.SecondsToClock(duration-(GetTime()-startTime)))
		GameTooltip:Show()
		-- self.icon:SetDesaturated(true)
		-- self.icon:SetAlpha(.5)
	else
		GameTooltip:ClearLines()
		GameTooltip:AddLine(E.Octo_Func.func_spellName(self.spellID))
		GameTooltip:Show()
		-- self.icon:SetDesaturated(false)
		-- self.icon:SetAlpha(1)
	end
end
local function CreateFrameUsableSpells_OnLeave(self)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, 0, 0, .2)
	end
	---------------------------
	local startTime, duration = GetSpellCooldown(self.spellID)
	if startTime ~= nil and startTime ~= 0 then
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		-- self.icon:SetDesaturated(true)
		-- self.icon:SetAlpha(.5)
	else
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		-- self.icon:SetDesaturated(false)
		-- self.icon:SetAlpha(1)
	end
	---------------------------
end
local function CreateFrameUsableSpells_OnEvent(self, event)
	if event == "TOYS_UPDATED" or event == "ACTIONBAR_UPDATE_COOLDOWN" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE" then
		local startTime, duration = GetSpellCooldown(self.spellID)
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == true then
			self.icon:SetVertexColor(1, 1, 1, 1)
			-- self.icon:SetDesaturated(false)
			-- self.icon:SetAlpha(1)
		else
			self.icon:SetVertexColor(1, 0, 0, .2)
			-- self.icon:SetDesaturated(true)
			-- self.icon:SetAlpha(.5)
		end
	---------------------------
		-- if startTime ~= 0 or duration ~= 0 then
		-- 	self.icon:SetDesaturated(true)
		-- 	self.icon:SetAlpha(.5)
		-- else
		-- 	self.icon:SetDesaturated(false)
		-- 	self.icon:SetAlpha(1)
		-- end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(OctoFrame_Main_Frame)
		self:SetPoint("BOTTOMLEFT", OctoFrame_Main_Frame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableSpells_OnMouseDown(self)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, 0, 0, .2)
	end
end
local function CreateFrameUsableSpells_OnMouseUp(self)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, 0, 0, .2)
	end
end
local function CreateFrameUsableSpells(spellID, Texture, Xpos, Ypos, r, g, b)
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.spellID = spellID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	Button:SetPoint("BOTTOMLEFT", OctoFrame_Main_Frame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- Button:SetBackdropBorderColor(r, g, b, 1)
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	-- Button:RegisterEvent("TOYS_UPDATED")
	-- Button:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	-- Button:RegisterEvent("SPELLS_CHANGED")
	-- Button:RegisterEvent("SPELL_UPDATE_CHARGES")
	-- Button:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	-- Button:RegisterEvent("TRAINER_UPDATE")
	Button:HookScript("OnEvent", CreateFrameUsableSpells_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableSpells_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableSpells_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableSpells_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableSpells_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/cast "..GetSpellInfo(spellID))
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	-- t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
function Collect_ALL_PlayerInfo()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_PlayerInfo")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	----------------------------------------------------------------
	local UnitLevel = UnitLevel("PLAYER") or 0
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	local curServerShort = GetRealmName()
	local text = (curServerShort):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		curServerShort = E.Octo_Func.WA_Utf8Sub(a, 1)..E.Octo_Func.WA_Utf8Sub(b, 1):upper() else curServerShort = E.Octo_Func.WA_Utf8Sub(a, 3):lower()
	end
	if collect and not InCombatLockdown() then
		collect.curServerShort = curServerShort
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
		collect.warmode = C_PvP.IsWarModeDesired()
		collect.classColorHex = E.Octo_Func.func_rgb2hex(classColor.r, classColor.g, classColor.b)
	end
end
function Collect_ALL_PlayerGear()
	-- if Octo_DEV_FUNC == true then
	-- 	print ("Collect_ALL_PlayerGear")
	-- end
	-- local curGUID = UnitGUID("PLAYER")
	-- local collect = Octo_ToDoLevels[curGUID]
	-- local invSlotId, textureName, checkRelic = GetInventorySlotInfo("HEADSLOT")
	-- local function getLocationsForInspect()
	--     local locations = {}
	--     -- for inventorySlot=18, 34 do
	--     for inventorySlot = 1, 18 do
	--         locations[#locations+1] = ItemLocation:CreateFromEquipmentSlot(inventorySlot)
	--     end
	--     return locations
	-- end
	-- for k, v in pairs(getLocationsForInspect()) do
	-- 	for e, r in pairs (v) do
	-- 		print (k, e, r)
	-- 	end
	-- end
	-- local inventoryType = C_Item.GetItemInventoryType(itemLocation)
	-- -- print (invSlotId, textureName, checkRelic)
	-- ----------------------------------------------------------------
	-- for k, v in pairs(Enum.InventoryType) do
	-- 	collect.PlayerGear[k] = v
	-- end
end
function Collect_ALL_Mail()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_Mail")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local hasMail = HasNewMail()
	if collect and not InCombatLockdown() then
		collect.hasMail = hasMail
	end
end
function Collect_ALL_KnownSpell()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_KnownSpell")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	for k, v in ipairs(E.Octo_Table.OctoTable_SpellID) do
		local isKnown = IsSpellKnown(v)
		if collect and not InCombatLockdown() then
			collect.KnownSpell[v] = isKnown
		end
	end
	-- for k, v in ipairs(E.Octo_Table.OctoTable_Portals) do
	-- 	local isKnown = IsSpellKnown(v)
	-- 	if collect and not InCombatLockdown() then
	-- 		collect.KnownSpell[v] = isKnown
	-- 	end
	-- end
end
function Collect_BfA_Azerite()
	if Octo_DEV_FUNC == true then
		print ("Collect_BfA_Azerite")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		if totalLevelXP and totalLevelXP ~= 0 then
			if collect and not InCombatLockdown() then
				collect.azeriteLVL = currentLevel
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E.Octo_Func.CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
function Collect_BfA_Cloaklvl()
	if Octo_DEV_FUNC == true then
		print ("Collect_BfA_Cloaklvl")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local hasItem = GetItemCount(169223, true, true, true)
	if hasItem ~= 0 then
		local itemLink = GetInventoryItemLink("player", 15)
		if itemLink then
			local itemID = itemLink:match("item:(%d+)")
			if itemID == "169223" then
				local itemLevel = select(4, GetItemInfo(itemLink))
				if itemLevel then
					if collect and not InCombatLockdown() then
						collect.cloak_lvl = min(15, max((itemLevel - 125) / 2 + 1, 1))
					end
				end
			end
		end
		if itemLink and itemLink:find("item:169223:") then
			inspectScantip:SetInventoryItem("player", 15)
			if inspectScantip:NumLines() > 0 then
				for j = 2, inspectScantip:NumLines() do
					local text = _G["OctoToDoScanningTooltipTextLeft"..j]:GetText()
					if text and text ~= "" then
						local res = text:gsub("[, ]", ""):gsub("(%d+)[ ]+(%d+)", "%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")
						if res then
							if collect and not InCombatLockdown() then
								collect.cloak_res = res
								break
							end
						end
					end
				end
			end
			inspectScantip:ClearLines()
		end
	else
		collect.cloak_lvl = 0
		collect.cloak_res = 0
	end
end
function Collect_Legion_Artifact()
	if Octo_DEV_FUNC == true then
		print ("Collect_Legion_Artifact")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local _, _, _, quantity1, reqQuantity1 = GetAchievementCriteriaInfo(11152, 1)
	local _, _, _, quantity2, reqQuantity2 = GetAchievementCriteriaInfo(11153, 1)
	local _, _, _, quantity3, reqQuantity3 = GetAchievementCriteriaInfo(11154, 1)
end
function Collect_ALL_LoginTime()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_LoginTime")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	collect.loginDate = date("%d.%m.%Y %H:%M:%S")
	collect.loginDay = date("%d.%m.%Y")
	collect.loginHour = date("%H:%M")
	collect.needResetWeekly = false
	collect.needResetDaily = false
	collect.needResetMonth = false
end
function Collect_SL_CovenantAnima()
	if Octo_DEV_FUNC == true then
		print ("Collect_SL_CovenantAnima")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local CovenantNames = {
		[1] = "Kyrian",
		[2] = "Venthyr",
		[3] = "NightFae",
		[4] = "Necrolord",
	}
	local curCovID = C_Covenants.GetActiveCovenantID()
	local curCovName = CovenantNames[curCovID]
	local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
	local curAnimaAmount = currencyInfo.quantity
	if curCovID == 0 then return end
	if curCovID == 1 then
		collect.Shadowland[1] = curCovLevel or 0
		collect.Shadowland[2] = curAnimaAmount or 0
	elseif curCovID == 2 then
		collect.Shadowland[3] = curCovLevel or 0
		collect.Shadowland[4] = curAnimaAmount or 0
	elseif curCovID == 3 then
		collect.Shadowland[5] = curCovLevel or 0
		collect.Shadowland[6] = curAnimaAmount or 0
	elseif curCovID == 4 then
		collect.Shadowland[7] = curCovLevel or 0
		collect.Shadowland[8] = curAnimaAmount or 0
	end
	collect.curCovID = curCovID
end
function Collect_ALL_PVPRaitings()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_PVPRaitings")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if not IsAddOnLoaded("Blizzard_PVPUI") then
		LoadAddOn("Blizzard_PVPUI")
		return
	end
	local rating2v2, seasonBest2v2, weeklyBest2v2, seasonPlayed2v2, seasonWon2v2, weeklyPlayed2v2, weeklyWon2v2, cap2v2 = GetPersonalRatedInfo(1)
	local rating3v3, seasonBest3v3, weeklyBest3v3, seasonPlayed3v3, seasonWon3v3, weeklyPlayed3v3, weeklyWon3v3, cap3v3 = GetPersonalRatedInfo(2)
	local ratingRBG, seasonBestRBG, weeklyBestRBG, seasonPlayedRBG, seasonWonRBG, weeklyPlayedRBG, weeklyWonRBG, capRBG = GetPersonalRatedInfo(4)
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
	Octo_ToDoLevels[curGUID].PVP.rating2v2 = rating2v2
	Octo_ToDoLevels[curGUID].PVP.seasonBest2v2 = seasonBest2v2
	Octo_ToDoLevels[curGUID].PVP.winrate2v2 = winrate2v2
	Octo_ToDoLevels[curGUID].PVP.rating3v3 = rating3v3
	Octo_ToDoLevels[curGUID].PVP.seasonBest3v3 = seasonBest3v3
	Octo_ToDoLevels[curGUID].PVP.winrate3v3 = winrate3v3
	Octo_ToDoLevels[curGUID].PVP.ratingRBG = ratingRBG
	Octo_ToDoLevels[curGUID].PVP.seasonBestRBG = seasonBestRBG
	Octo_ToDoLevels[curGUID].PVP.winrateRBG = winrateRBG
end
function Collect_All_Professions()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Professions")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if collect then
		collect.professions = {}
		-- collect.professions = collect.professions or {}
		--------------------------------
		local chest_count = 0
		local craftOrder_count = 0
		local drops_count = 0
		local profQuest_count = 0
		local treatise_count = 0
		--------------------------------
		local ProfTable = {}
		local prof1, prof2, archaeology, fishing, cooking = GetProfessions()
		if prof1 then tinsert(ProfTable, prof1) end
		if prof2 then tinsert(ProfTable, prof2) end
		if archaeology then tinsert(ProfTable, archaeology) end
		if fishing then tinsert(ProfTable, fishing) end
		if cooking then tinsert(ProfTable, cooking) end
		for k, v in pairs(ProfTable) do
			local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(v)
			if skillLine then
				collect.professions[skillLine] = collect.professions[skillLine] or {}
				collect.professions[skillLine].name = name
				collect.professions[skillLine].icon = E.Octo_Func.func_texturefromIcon(icon)
				collect.professions[skillLine].skillLevel = skillLevel
				collect.professions[skillLine].maxSkillLevel = maxSkillLevel
				collect.professions[skillLine].numAbilities = numAbilities
				collect.professions[skillLine].spelloffset = spelloffset
				collect.professions[skillLine].skillLine = skillLine
				collect.professions[skillLine].skillModifier = skillModifier
				collect.professions[skillLine].specializationIndex = specializationIndex
				collect.professions[skillLine].specializationOffset = specializationOffset
			end
			table[171] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66373, 66374}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 2, questID = {70511, 70504}},
				profQuest = {questReq = 2, questID = {70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937}},
				treatise = {questReq = 1, questID = {74108}},
			}
			table[164] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66381, 66382}},
				craftOrder = {questReq = 1, questID = {70589}},
				drops = {questReq = 2, questID = {70513, 70512}},
				profQuest = {questReq = 2, questID = {66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211}},
				treatise = {questReq = 1, questID = {74109}},
			}
			table[333] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66377, 66378}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 2, questID = {70515, 70514}},
				profQuest = {questReq = 2, questID = {66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423}},
				treatise = {questReq = 1, questID = {74110}},
			}
			table[202] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66379, 66380}},
				craftOrder = {questReq = 1, questID = {70591}},
				drops = {questReq = 2, questID = {70517, 70516}},
				profQuest = {questReq = 2, questID = {72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539}},
				treatise = {questReq = 1, questID = {74111}},
			}
			table[182] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {71857, 71858, 71859, 71860, 71861, 71864}},
				profQuest = {questReq = 1, questID = {70614, 70613, 70616, 70615}},
				treatise = {questReq = 1, questID = {74107}},
			}
			table[773] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66375, 66376}},
				craftOrder = {questReq = 1, questID = {70592}},
				drops = {questReq = 2, questID = {70519, 70518}},
				profQuest = {questReq = 2, questID = {66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438}},
				treatise = {questReq = 1, questID = {74105}},
			}
			table[755] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66388, 66389}},
				craftOrder = {questReq = 1, questID = {70593}},
				drops = {questReq = 2, questID = {70521, 70520}},
				profQuest = {questReq = 2, questID = {66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562}},
				treatise = {questReq = 1, questID = {74112}},
			}
			table[165] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66384, 66385}},
				craftOrder = {questReq = 1, questID = {70594}},
				drops = {questReq = 2, questID = {70523, 70522}},
				profQuest = {questReq = 2, questID = {66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363}},
				treatise = {questReq = 1, questID = {74113}},
			}
			table[186] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {72160, 72161, 72162, 72163, 72164, 72165}},
				profQuest = {questReq = 1, questID = {70617, 70618, 72157, 72156}},
				treatise = {questReq = 1, questID = {74106}},
			}
			table[393] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {70381, 70383, 70384, 70385, 70386, 70389}},
				profQuest = {questReq = 4, questID = {70620, 72159, 70619, 72158}},
				treatise = {questReq = 1, questID = {74114}},
			}
			table[197] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66386, 66387}},
				craftOrder = {questReq = 1, questID = {70595}},
				drops = {questReq = 2, questID = {70524, 70525}},
				profQuest = {questReq = 2, questID = {72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899}},
				treatise = {questReq = 1, questID = {74115}},
			}
			if E.Octo_Table.Octo_ProfessionsskillLine[skillLine] then
				for _, v in ipairs(table[skillLine].chest.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						chest_count = chest_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].craftOrder.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						craftOrder_count = craftOrder_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].drops.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						drops_count = drops_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].profQuest.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						profQuest_count = profQuest_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].treatise.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						treatise_count = treatise_count + 1
					end
				end
				collect.professions[skillLine].chest = {questReq = table[skillLine].chest.questReq, chest_count = chest_count}
				collect.professions[skillLine].craftOrder = {questReq = table[skillLine].craftOrder.questReq, craftOrder_count = craftOrder_count}
				collect.professions[skillLine].drops = {questReq = table[skillLine].drops.questReq, drops_count = drops_count}
				collect.professions[skillLine].profQuest = {questReq = table[skillLine].profQuest.questReq, profQuest_count = profQuest_count}
				collect.professions[skillLine].treatise = {questReq = table[skillLine].treatise.questReq, treatise_count = treatise_count}
			end
		end
	end
	return
end
function Collect_ALL_GreatVault()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	----------------------------------------------------------------
	local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
	C_MythicPlus.RequestRewards()
	local currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
	C_MythicPlus.RequestMapInfo()
	for i = 1, #mapChallengeModeIDs do
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	collect.RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
	collect.RIO_weeklyBest = currentWeekBestLevel
	----------------------------------------------------------------
	for _, i in pairs(Enum.WeeklyRewardChestThresholdType) do
		local test
		local hyperlink_STRING
		local activities = C_WeeklyRewards.GetActivities(i)
		for k = 1, 3 do
			local activityInfo = activities[k]
			if activityInfo then
				local type = activityInfo.type
				if collect and type ~= 0 and type ~= nil then
					collect.GreatVault[type] = collect.GreatVault[type] or {}
					collect.GreatVault[type].progress = activityInfo.progress
					collect.GreatVault[type].threshold = activityInfo.threshold
					local hyperlink = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					if hyperlink then
						collect.GreatVault[type].hyperlink[k] = hyperlink
					end
					if type == 1 then collect.GreatVault[type].type = MYTHIC_DUNGEONS end
					if type == 2 then collect.GreatVault[type].type = CALENDAR_TYPE_PVP end
					if type == 3 then collect.GreatVault[type].type = RAIDS end
					--------------------------------
					hyperlink_STRING = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					if hyperlink and type == 1 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
					if hyperlink and type == 2 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
					if hyperlink and type == 3 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
				end
			end
		end
	end
	----------------------------------------------------------------
end
local function func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text then return nil end
	local textR, textG, textB, textAlpha = fontstring:GetTextColor()
	return string.format("|c%02x%02x%02x%02x"..text.."|r", textAlpha*255, textR*255, textG*255, textB*255)
end
function GetItemFromTooltip(tooltip)
	if (TooltipUtil) then
		if (tooltip:IsTooltipType(Enum.TooltipDataType.Toy)) then -- see TooltipUtil.GetDisplayedItem() in "TooltipUtil.lua"
			local tooltipData = tooltip:GetTooltipData()
			local itemLink = C_ToyBox.GetToyLink(tooltipData.id)
			if (itemLink) then
				local name = GetItemInfo(itemLink)
				return name, itemLink, tooltipData.id
			end
		end
		return TooltipUtil.GetDisplayedItem(tooltip)
	end
	return tooltip:GetItem()
end
function TEST_FUNC()
	local itemID = 48933
	-- local itemLink = (GetItemFromTooltip(itemID))
	local _, itemLink = GetItemInfo(itemID)
	inspectScantip:SetHyperlink(itemLink)
	if inspectScantip:NumLines() > 0 then
		for i = 1, inspectScantip:NumLines() do
			local text = _G["OctoToDoScanningTooltipTextLeft"..i]:GetText()
			local r, g, b, a = _G["OctoToDoScanningTooltipTextLeft"..i]:GetTextColor()
			local QWE = func_coloredText(_G["OctoToDoScanningTooltipTextLeft"..i])
			if text and text ~= "" then
					--print (i, QWE)
				-- SPELL_FAILED_CUSTOM_ERROR_77
			end
		end
	end
	inspectScantip:ClearLines()
end
function Collect_All_Currency()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Currency")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	for k, v in ipairs(E.Octo_Table.OctoTable_currencyID_ALL) do
		local data = C_CurrencyInfo.GetCurrencyInfo(v)
		local quantity = data.quantity
		local maxQuantity = data.maxQuantity
		if v == 2167 and maxQuantity > 6 then maxQuantity = 6 end
		if collect and not InCombatLockdown() then
			collect.CurrencyID[v] = quantity
			collect.CurrencyID_maxQuantity[v] = maxQuantity
			if maxQuantity ~= 0 then
				if quantity ~= maxQuantity then
					if quantity ~= 0 then
						collect.CurrencyID_Total[v] = quantity.."/"..maxQuantity
					else
						collect.CurrencyID_Total[v] = E.Octo_Globals.Gray_Color..quantity.."/"..maxQuantity.."|r"
					end
				else
					collect.CurrencyID_Total[v] = E.Octo_Globals.Green_Color..quantity.."/"..maxQuantity.."|r"
				end
			else
				if quantity ~= 0 then
					collect.CurrencyID_Total[v] = quantity
				else
					collect.CurrencyID_Total[v] = E.Octo_Globals.Gray_Color..quantity.."|r"
				end
			end
		end
	end
end
function Collect_ALL_MountEquipmentID()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_MountEquipmentID")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local canUseMountEquipment = C_PlayerInfo.CanPlayerUseMountEquipment()
	local itemID = C_MountJournal.GetAppliedMountEquipmentID()
	if collect and not InCombatLockdown() then
		collect.canUseMountEquipment = canUseMountEquipment
		collect.currentMountItemID = itemID
	end
end
function Collect_ALL_ItemsInBag()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_ItemsInBag")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	----------------------------------------------------------------
	local PlayerReagentnumSlots = C_Container.GetContainerNumSlots(BACKPACK_CONTAINER+NUM_BAG_SLOTS+1)
	local usedSlots = 0
	local totalSlots = 0
	local Possible_Anima = 0
	local Possible_CatalogedResearch = 0
	local Abbr_En_Name = E.Octo_Globals.NONE
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local numSlots = C_Container.GetContainerNumSlots(bag)
		totalSlots = totalSlots + numSlots
		local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if BagType == 0 then
			usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
		end
		for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				-- KeyLevel
				local stackCount = containerInfo.stackCount
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				local hyperlink = containerInfo.hyperlink
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(hyperlink)
				if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") then
					-- if hyperlink:find("Каражан") then
					-- 	hyperlink = hyperlink:gsub("^[^:]+: ", "Кара: ")
					-- elseif hyperlink:find("Мехагон") then
					-- 	hyperlink = hyperlink:gsub("^[^ ]+ ", "")
					-- end
					local dungeonID = select(3, strsplit(":", hyperlink)) -- COLLECT ИД ключа
					local lvl = select(4, strsplit(":", hyperlink)) -- COLLECT уровень ключа CurrentKeyLevel
					collect.CurrentKeyLevel = tonumber(lvl)
					collect.CurrentKeyFULL = C_ChallengeMode.GetMapUIInfo(dungeonID) -- COLLECT название ключа CurrentKeyFULL
					for k, v in ipairs(E.Octo_Table.OctoTable_KeystoneAbbr) do
						if v.mapChallengeModeID == tonumber(dungeonID) then
							collect.CurrentKey = E.Octo_Globals.Purple_Color..lvl.." " ..v.abbreviation.."|r"
						end
					end
				end
				-- Cataloged Research
				for k, v in pairs(E.Octo_Table.OctoTable_itemID_Cataloged_Research) do
					if itemID == v.itemiD then
						Possible_CatalogedResearch = Possible_CatalogedResearch + v.count
					end
				end
				-- Possible Anima
				local isAnima = C_Item.IsAnimaItemByID(itemID)
				if stackCount and isAnima and itemID ~= nil then
					if (quality == 2) and (itemID ~= 183727) then
						Possible_Anima = Possible_Anima + (5 * stackCount)
					end
					if quality == 3 then
						Possible_Anima = Possible_Anima + (35 * stackCount)
					end
					if quality == 4 then
						Possible_Anima = Possible_Anima + (250 * stackCount)
					end
					if itemID == 183727 then
						Possible_Anima = Possible_Anima + (3 * stackCount)
					end
				end
				-- subclassID
				-- 5 ЕДА
				if itemID then
					if itemQuality == 0 and sellPrice ~= 0 and classID ~= 2 and classID ~= 4 then
						Octo_ToDo_SmartCollectNEW.Items.GrayItemsTrash[itemID] = Octo_ToDo_SmartCollectNEW.Items.GrayItemsTrash[itemID] or {}
						Octo_ToDo_SmartCollectNEW.Items.GrayItemsTrash[itemID] = true
					end
					if itemQuality == 0 and sellPrice ~= 0 and (classID == 2 or classID == 4) then
						Octo_ToDo_SmartCollectNEW.Items.GrayItemsArmor[itemID] = Octo_ToDo_SmartCollectNEW.Items.GrayItemsArmor[itemID] or {}
						Octo_ToDo_SmartCollectNEW.Items.GrayItemsArmor[itemID] = true
					end
					if bindType == 0 and expacID >= 9 then
						if classID == 0 and itemQuality < 3 and subclassID ~= 0 then
							Octo_ToDo_SmartCollectNEW.Items.Consumables[itemID] = Octo_ToDo_SmartCollectNEW.Items.Consumables[itemID] or {}
							Octo_ToDo_SmartCollectNEW.Items.Consumables[itemID] = true
						end
						if classID == 7 then
							if subclassID == 1 then
								Octo_ToDo_SmartCollectNEW.Items.Parts[itemID] = Octo_ToDo_SmartCollectNEW.Items.Parts[itemID] or {}
								Octo_ToDo_SmartCollectNEW.Items.Parts[itemID] = true
							end
							if subclassID == 10 then
								Octo_ToDo_SmartCollectNEW.Items.Elemental[itemID] = Octo_ToDo_SmartCollectNEW.Items.Elemental[itemID] or {}
								Octo_ToDo_SmartCollectNEW.Items.Elemental[itemID] = true
							end
							if subclassID == 18 then
								Octo_ToDo_SmartCollectNEW.Items.OptionalReagents[itemID] = Octo_ToDo_SmartCollectNEW.Items.OptionalReagents[itemID] or {}
								Octo_ToDo_SmartCollectNEW.Items.OptionalReagents[itemID] = true
							end
							if subclassID == 11 then
								Octo_ToDo_SmartCollectNEW.Items.Other[itemID] = Octo_ToDo_SmartCollectNEW.Items.Other[itemID] or {}
								Octo_ToDo_SmartCollectNEW.Items.Other[itemID] = true
							end
							if subclassID == -1 then
								Octo_ToDo_SmartCollectNEW.Items.TradeGoods[itemID] = Octo_ToDo_SmartCollectNEW.Items.TradeGoods[itemID] or {}
								Octo_ToDo_SmartCollectNEW.Items.TradeGoods[itemID] = true
							end
						end
					end
					-- TOYS?
					-- MISCELLANEOUS Разное
					-- MOUNTS Транспорт
					if itemType == MISCELLANEOUS and itemSubType == MOUNTS then
						Octo_ToDo_SmartCollectNEW.Items.Mounts = Octo_ToDo_SmartCollectNEW.Items.Mounts or {}
						Octo_ToDo_SmartCollectNEW.Items.Mounts[itemID] = true
					end
					if itemType == MISCELLANEOUS and itemSubType == "Питомцы" or itemSubType == "Pets" then
						Octo_ToDo_SmartCollectNEW.Items.Pets = Octo_ToDo_SmartCollectNEW.Items.Pets or {}
						Octo_ToDo_SmartCollectNEW.Items.Pets[itemID] = true
					end
				end




			end
		end
	end
	if collect and not InCombatLockdown() then
		for q, w in pairs(Octo_ToDo_SmartCollectNEW.Items) do
			for k, v in pairs(w) do
				if k then
					-- print (E.Octo_Func.func_itemName(k))
					local count = GetItemCount(k, true, true, true)
					collect.ItemsInBag[k] = count
				end
			end
		end
	end
	if collect and not InCombatLockdown() then
		for k, v in ipairs(E.Octo_Table.OctoTable_itemID_ALL) do
			local count = GetItemCount(v, true, true, true)
			collect.ItemsInBag[v] = count
		end
		collect.Possible_Anima = Possible_Anima
		collect.Possible_CatalogedResearch = Possible_CatalogedResearch
		collect.PlayerReagentnumSlots = PlayerReagentnumSlots
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
		collect.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	end
	----------------------------------------------------------------
end
function Collect_ALL_Locations()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_Locations")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local mapID = C_Map.GetBestMapForUnit("player")
	if mapID then
		local BindLocation = GetBindLocation()
		local info = C_Map.GetMapInfo(mapID)
		if info and collect and not InCombatLockdown() then
			collect.BindLocation = BindLocation
			collect.CurrentLocation = info.name or "no CurrentLocation"
		end
	end
end
function Collect_All_Reputations()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Reputations")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if collect and not InCombatLockdown() then
		for k, v in pairs(E.Octo_Table.OctoTable_reputation_ALL) do
			local rep = CheckReputationByRepID(v)
			collect.reputationID[v] = rep or 0
		end
	end
end
function Collect_All_Quests()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Quests")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for k, v in ipairs(E.Octo_Table.OctoTable_QuestID) do
		local questID = E.Octo_Func.CheckCompletedByQuestID(v)
		collect.OctoTable_QuestID[v] = questID or 0
	end
	if collect and not InCombatLockdown() then
		collect.numShownEntries = numShownEntries
		collect.numQuests = numQuests
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept
	end
end
function Collect_BfA_Island()
	if Octo_DEV_FUNC == true then
		print ("Collect_BfA_Island")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	if questID then
		if collect and not InCombatLockdown() then
			collect.islandBfA = E.Octo_Func.CheckCompletedByQuestID(questID)
		end
	end
end
function Collect_BfA_QuestsBounties()
	if Octo_DEV_FUNC == true then
		print ("Collect_BfA_QuestsBounties")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	collect["bounty_Legion1"] = 0
	collect["bounty_Legion1_icon"] = 0
	collect["bounty_Legion1_questID"] = 0
	collect["bounty_Legion1_end"] = 0
	collect["bounty_Legion2"] = 0
	collect["bounty_Legion2_icon"] = 0
	collect["bounty_Legion2_questID"] = 0
	collect["bounty_Legion2_end"] = 0
	collect["bounty_Legion3"] = 0
	collect["bounty_Legion3_icon"] = 0
	collect["bounty_Legion3_questID"] = 0
	collect["bounty_Legion3_end"] = 0
	local bounties_Legion = C_QuestLog.GetBountiesForMapID(619)
	if bounties_Legion then
		for i = 1, #bounties_Legion do
			local d = bounties_Legion[i]
			local factionName = GetFactionInfoByID(d.factionID)
			local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			if questIndex > 0 then
				local questData = C_QuestLog.GetInfo(questIndex)
				if questData and questData.title then
					factionName = questData.title
				end
			end
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
			end
			local faction_icon = "|T"..d.icon..":0|t "
			if collect and not InCombatLockdown() then
				collect["bounty_Legion"..i] = E.Octo_Func.CheckCompletedByQuestID(d.questID)
				collect["bounty_Legion"..i.."_icon"] = faction_icon
				collect["bounty_Legion"..i.."_questID"] = d.questID
				collect["bounty_Legion"..i.."_end"] = time() + secondsLeft * 60
			end
		end
	end
	local bounties_BfA = C_QuestLog.GetBountiesForMapID(875)
	collect["bounty_BfA1"] = 0
	collect["bounty_BfA1_icon"] = 0
	collect["bounty_BfA1_questID"] = 0
	collect["bounty_BfA1_end"] = 0
	collect["bounty_BfA2"] = 0
	collect["bounty_BfA2_icon"] = 0
	collect["bounty_BfA2_questID"] = 0
	collect["bounty_BfA2_end"] = 0
	collect["bounty_BfA3"] = 0
	collect["bounty_BfA3_icon"] = 0
	collect["bounty_BfA3_questID"] = 0
	collect["bounty_BfA3_end"] = 0
	if bounties_BfA then
		for i = 1, #bounties_BfA do
			local d = bounties_BfA[i]
			local factionName = GetFactionInfoByID(d.factionID)
			local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			if questIndex then
				if questIndex > 0 then
					local questData = C_QuestLog.GetInfo(questIndex)
					if questData and questData.title then
						factionName = questData.title
					end
				end
			end
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
				local faction_icon = "|T"..d.icon..":0|t "
				if collect and not InCombatLockdown() then
					collect["bounty_BfA"..i] = E.Octo_Func.CheckCompletedByQuestID(d.questID)
					collect["bounty_BfA"..i.."_icon"] = faction_icon
					collect["bounty_BfA"..i.."_questID"] = d.questID
					collect["bounty_BfA"..i.."_end"] = time() + secondsLeft * 60
				end
			end
		end
	end
end
function Collect_ALL_ItemLevel()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_ItemLevel")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	if collect and not InCombatLockdown() then
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function Collect_ALL_UNIVERSALQuestUpdate()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_UNIVERSALQuestUpdate")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local IsOnQuest = false
	for k, v in pairs(OctoTable_UniversalQuest) do
		for q, w in pairs(v) do
			local count = 0
			local vivod = ""
			for z, x in pairs(v.questID) do
				IsOnQuest = C_QuestLog.IsOnQuest(x)
				if v.max > 1 then
					if C_QuestLog.IsQuestFlaggedCompleted(x) == true then
						count = count + 1
					end
					vivod = count
				else
					local IsComplete = E.Octo_Func.CheckCompletedByQuestID(x)
					if IsComplete ~= E.Octo_Globals.NONE then
						vivod = IsComplete
					end
				end
				if IsOnQuest == true then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] = x or E.Octo_Globals.NONE
				end
			end
			if collect and not InCombatLockdown() then
				collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] = v.name_quest or E.Octo_Globals.NONE
				if v.max == 1 then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = vivod
				elseif v.max > 1 then
					if vivod == v.max and v.max > 1 then
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.DONE
					else
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = vivod.."/"..v.max
					end
				end
			end
		end
	end
end
function Collect_ALL_MoneyUpdate()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_MoneyUpdate")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.Money = Money
	end
end
function Collect_ALL_MoneyOnLogin()
	if Octo_DEV_FUNC == true then
		print ("Collect_ALL_MoneyOnLogin")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.MoneyOnLogin = Money
	end
end
function Collect_All_Legion_Transmoge()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Legion_Transmoge")
	end
	-- local curGUID = UnitGUID("PLAYER")
	-- local collect = Octo_ToDoLevels[curGUID]
	--------
	local _, playerClass, classID = UnitClass("player")
	for classFilename, v in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA) do -- classList
		for itemID in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename]) do -- artifactList
			local artifactData = E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename][itemID]
			local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
			for index, data in pairs(artifactData.sets) do
				local sourceID = data.sourceID
				local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
				if sourceInfo then
					if (itemID == 128860 or itemID == 128821) and data.shapeshiftID then
						sourceInfo.visualID = data.shapeshiftID
					end
					local visualID = sourceInfo.visualID
					local isCollected = sourceInfo.isCollected
					local sourceID = sourceInfo.sourceID
					local useError = sourceInfo.useError
					local isHideVisual = sourceInfo.isHideVisual
					local useErrorType = sourceInfo.useErrorType
					local itemID = sourceInfo.itemID
					local categoryID = sourceInfo.categoryID
					local itemModID = sourceInfo.itemModID
					local ArtifactNameLocale = sourceInfo.name
					local quality = sourceInfo.quality
					local vivod = E.Octo_Globals.NONE
					if isCollected == true then
						vivod = E.Octo_Globals.DONE
					else
						vivod = E.Octo_Globals.Red_Color.."None|r"
					end
					if classFilename and itemID and visualID then
						if Octo_ToDoArtifact == nil then
							Octo_ToDoArtifact = {}
						end
						if Octo_ToDoArtifact[classFilename] == nil then
							Octo_ToDoArtifact[classFilename] = {}
						end
						if Octo_ToDoArtifact[classFilename][itemID] == nil then
							Octo_ToDoArtifact[classFilename][itemID] = {}
						end
						if Octo_ToDoArtifact[classFilename][itemID][visualID] == nil then
							Octo_ToDoArtifact[classFilename][itemID][visualID] = {}
						end
						setmetatable(Octo_ToDoArtifact[classFilename][itemID][visualID], Meta_Table_0)
						if Octo_ToDoArtifact[classFilename][itemID][visualID] then
							local collect_Artifact = Octo_ToDoArtifact[classFilename][itemID][visualID]
							collect_Artifact.isCollected = isCollected
							collect_Artifact.vivod = vivod
							collect_Artifact.name = data.name
							collect_Artifact.classFilename = classFilename
							collect_Artifact.specNameLocale = specNameLocale or ""
							collect_Artifact.specID = artifactData.specID
							collect_Artifact.specIDnumber = artifactData.specIDnumber
							collect_Artifact.ArtifactNameLocale = ArtifactNameLocale
							collect_Artifact.specIcon = specIcon
							collect_Artifact.index = index
							if E.Octo_Globals.UNLOCK_DATA[data.unlock] then
								local unlock = E.Octo_Globals.UNLOCK_DATA[data.unlock].unlock
								local unlockOCto = E.Octo_Globals.UNLOCK_DATA[data.unlock].unlockOCto
								local unlockAchievementID = E.Octo_Globals.UNLOCK_DATA[data.unlock].AchievementID
								collect_Artifact.unlock = unlock
								collect_Artifact.unlockOCto = unlockOCto
								collect_Artifact.unlockAchievementID = unlockAchievementID
							end
						end
					end
				end
			end
		end
	end
end
function Collect_All_Holiday()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_Holiday")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_SmartCollectNEW.Holiday
	if not IsAddOnLoaded("Blizzard_Calendar") then
		LoadAddOn("Blizzard_Calendar")
		ShowUIPanel(CalendarFrame, true)
		HideUIPanel(CalendarFrame)
		-- Calendar_Toggle()
		-- CalendarFrame:Hide()
	end
	----------------
	local ShowALL = true
	local vivod = ""
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local month = 0
	local minute = currentCalendarTime.minute -- The current time in minutes [0-59]
	local hour = currentCalendarTime.hour -- The current time in hours [0-23]
	local weekday = currentCalendarTime.weekday -- The current day of the week (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
	local monthDay = currentCalendarTime.monthDay -- The current day of the month [1-31]
	-- local month = currentCalendarTime.month -- The current month [1-12]
	local year = currentCalendarTime.year -- The current year (e.g. 2019)
	local numDayEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	for i = 1, numDayEvents do
		local event = C_Calendar.GetDayEvent(month, monthDay, i)
		local id = event.eventID
		local title = event.title
		local sequenceType = event.sequenceType
		collect.Collect[id] = title
		-- collect.Collect[id] = collect.Collect[id] or {}
		-- collect.Collect[id].title = title
		-- collect.Collect[id].sequenceType = sequenceType or E.Octo_Globals.NONE
		local startTime = event.startTime
		local endTime = event.endTime
		if startTime and endTime and id and title then
			local startTime_year = startTime.year
			local startTime_month = startTime.month
			local startTime_monthDay = startTime.monthDay
			local startTime_weekday = startTime.weekday
			local startTime_hour = startTime.hour
			local startTime_minute = startTime.minute
			local endTime_year = endTime.year
			local endTime_month = endTime.month
			local endTime_monthDay = endTime.monthDay
			local endTime_weekday = endTime.weekday
			local endTime_hour = endTime.hour
			local endTime_minute = endTime.minute
			if sequenceType ~= "END" then
				-- if E.Octo_Table.OctoTable_EventsIDs[title] then
				if title and E.Octo_Table.OctoTable_EventsIDs[id] then
					if collect.Active[id] == nil then
						collect.Active[id] = {}
					end
					collect.Active[id].id = id
					collect.Active[id].title = title
					collect.Active[id].sequenceType = sequenceType
					collect.Active[id].vivod = E.Octo_Globals.Yellow_Color..title.."|r до: "..endTime_monthDay.."/"..endTime_month.."/"..endTime_year
					collect.Active[id].startTime = startTime_monthDay.."/"..startTime_month.."/"..startTime_year
					collect.Active[id].endTime = endTime_monthDay.."/"..endTime_month.."/"..endTime_year
					if vivod ~= "" then
						vivod = vivod.."\n"
					end
					vivod = vivod..E.Octo_Globals.Yellow_Color..title.."|r до: "..endTime_monthDay.."/"..endTime_month.."/"..endTime_year
				end
			end
		end
	end
	return vivod
end
local function IsInArray(arr, subj)
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end
function Collect_All_journalInstance()
	if Octo_DEV_FUNC == true then
		print ("Collect_All_journalInstance")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	--------------------------------
	if ((GetNumSavedInstances() + GetNumSavedWorldBosses() > 0) and not RaidInfoFrame:IsVisible()) then
		ToggleRaidFrame()
		RaidInfoFrame:Show()
	end
	if (not RaidFrame:IsVisible()) then
		ToggleRaidFrame()
	end
	if RaidFrame:IsVisible() then
		HideUIPanel(RaidFrame)
	end
	if FriendsFrame:IsVisible() then
		HideUIPanel(FriendsFrame)
	end
	if RaidInfoFrame:IsVisible() then
		HideUIPanel(RaidInfoFrame)
	end
	--------------------------------
	local numsaved = GetNumSavedInstances()
	local DiffAbbr = ""
	local instancesLastBoss = {}
	local ServerTime = GetServerTime()
	-- collect.journalInstance = {}
	-- local res = {}
	if collect.journalInstance == 0 then
		collect.journalInstance = {}
	end
	collect.journalInstance = collect.journalInstance or {}
	if numsaved > 0 then
		--------------------------------
		for i = 1, numsaved do
			local instanceName, lockoutId, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, instanceId = GetSavedInstanceInfo(i)
			collect.journalInstance[instanceId] = collect.journalInstance[instanceId] or {}
			collect.journalInstance[instanceId][instanceDifficulty] = collect.journalInstance[instanceId][instanceDifficulty] or {}
			if locked then
				--------------------------------
				for k, v in ipairs(E.Octo_Table.OctoTable_journalInstanceID) do
					if instanceId == v then
						local _, _, lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
						if defeatedBosses == 0 and lastBossDefeated then
							lastBossDefeated = false
						end
						local color = E.Octo_Globals.Red_Color
						if lastBossDefeated then color = E.Octo_Globals.Yellow_Color end
						if defeatedBosses == totalBosses then color = E.Octo_Globals.Green_Color end
						--------------------------------
						if instanceReset and instanceReset > 0 then
							instanceReset = instanceReset + time()
						else
							instanceReset = 0
						end
						--------------------------------
						if instanceDifficulty == 17 then
							DiffAbbr = "LFR"
						elseif instanceDifficulty == 1 or instanceDifficulty == 14 then
							DiffAbbr = "N"
						elseif instanceDifficulty == 2 or instanceDifficulty == 15 then
							DiffAbbr = "H"
						elseif instanceDifficulty == 23 or instanceDifficulty == 16 then
							DiffAbbr = "M"
						else
							DiffAbbr = "HZ"
						end
						--------------------------------
						--------------------------------
						vivod = color..defeatedBosses.."/"..totalBosses.."|r"
						-- print (instanceName, vivod)
						-- print (i, instanceId, instanceDifficulty, instanceName, difficultyName, vivod, GetTime(), instanceReset, Time)
						collect.journalInstance[instanceId][instanceDifficulty].instanceName = instanceName
						collect.journalInstance[instanceId][instanceDifficulty].vivod = vivod
						collect.journalInstance[instanceId][instanceDifficulty].instanceReset = instanceReset
						collect.journalInstance[instanceId][instanceDifficulty].difficultyName = difficultyName
						collect.journalInstance[instanceId][instanceDifficulty].instanceDifficulty = instanceDifficulty
						collect.journalInstance[instanceId][instanceDifficulty].extended = extended
						collect.journalInstance[instanceId][instanceDifficulty].instanceIDMostSig = instanceIDMostSig
						collect.journalInstance[instanceId][instanceDifficulty].isRaid = isRaid
						collect.journalInstance[instanceId][instanceDifficulty].maxPlayers = maxPlayers
						collect.journalInstance[instanceId][instanceDifficulty].totalBosses = totalBosses
						collect.journalInstance[instanceId][instanceDifficulty].defeatedBosses = defeatedBosses
						collect.journalInstance[instanceId][instanceDifficulty].extendDisabled = extendDisabled
						collect.journalInstance[instanceId][instanceDifficulty].DiffAbbr = DiffAbbr
						collect.journalInstance[instanceId][instanceDifficulty].Time = E.Octo_Func.SecondsToClock(instanceReset-ServerTime)
						-- collect.journalInstance[instanceId][instanceDifficulty].link = GetSavedInstanceChatLink(i)
					end
				end
			end
		end
		--------------------------------
	end
	--------------------------------
	-- collect.LFGInstance = {} -- УДАЛЕНИЕ
	-- collect.LFGInstance = collect.LFGInstance or {}
	----------------------------------------------------------------
	for i=1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID then
			Octo_ToDo_SmartCollectNEW.LFGInstance[dungeonID] = name
		end
	end
	for dungeonID, name in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
		-- local D_name, D_typeID, D_subtypeID, D_minLevel, D_maxLevel, D_recLevel, D_minRecLevel, D_maxRecLevel, D_expansionLevel, D_groupID, D_textureFilename, D_difficulty, D_maxPlayers, D_description, D_isHoliday, D_bonusRepAmount, D_minPlayers, D_isTimeWalker, D_name2, D_minGearLevel, D_isScalingDungeon, D_lfgMapID = GetLFGDungeonInfo(dungeonID)
		-- local donetoday, money = GetLFGDungeonRewards(dungeonID)
		local D_name = GetLFGDungeonInfo(dungeonID)
		local donetoday = GetLFGDungeonRewards(dungeonID)
		collect.LFGInstance[dungeonID] = collect.LFGInstance[dungeonID] or {}
		collect.LFGInstance[dungeonID].D_name = D_name
		-- collect.LFGInstance[dungeonID].D_typeID = D_typeID
		-- collect.LFGInstance[dungeonID].D_subtypeID = D_subtypeID
		-- collect.LFGInstance[dungeonID].D_minLevel = D_minLevel
		-- collect.LFGInstance[dungeonID].D_maxLevel = D_maxLevel
		-- collect.LFGInstance[dungeonID].D_recLevel = D_recLevel
		-- collect.LFGInstance[dungeonID].D_minRecLevel = D_minRecLevel
		-- collect.LFGInstance[dungeonID].D_maxRecLevel = D_maxRecLevel
		-- collect.LFGInstance[dungeonID].D_expansionLevel = D_expansionLevel
		-- collect.LFGInstance[dungeonID].D_groupID = D_groupID
		-- collect.LFGInstance[dungeonID].D_textureFilename = D_textureFilename
		-- collect.LFGInstance[dungeonID].D_difficulty = D_difficulty
		-- collect.LFGInstance[dungeonID].D_maxPlayers = D_maxPlayers
		-- collect.LFGInstance[dungeonID].D_description = D_description
		-- collect.LFGInstance[dungeonID].D_isHoliday = D_isHoliday
		-- collect.LFGInstance[dungeonID].D_bonusRepAmount = D_bonusRepAmount
		-- collect.LFGInstance[dungeonID].D_minPlayers = D_minPlayers
		-- collect.LFGInstance[dungeonID].D_isTimeWalker = D_isTimeWalker
		-- collect.LFGInstance[dungeonID].D_name2 = D_name2
		-- collect.LFGInstance[dungeonID].D_minGearLevel = D_minGearLevel
		-- collect.LFGInstance[dungeonID].D_isScalingDungeon = D_isScalingDungeon
		-- collect.LFGInstance[dungeonID].D_lfgMapID = D_lfgMapID
		if donetoday == true then
			collect.LFGInstance[dungeonID].donetoday = E.Octo_Globals.DONE
			-- else
			--     collect.LFGInstance[dungeonID].donetoday = E.Octo_Globals.NONE
		end
		-- print (dungeonID, name, donetoday, collect.LFGInstance[dungeonID].donetoday)
		-- collect.LFGInstance[dungeonID].money = money
	end
end
function Collect_AberrusTransmog()
	-- print ("Collect_AberrusTransmog")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if Octo_ToDoTransmog == nil then
		Octo_ToDoTransmog = {}
	end
	--------------------------------
	local englishClass = select(2, UnitClass("PLAYER"))
	local color = E.Octo_Globals.White_Color
	for itemType, v in pairs(E.Octo_Globals.Aberrus_the_Shadowed_Crucible_DATA[englishClass]) do
		for difficultyName, sourceID in pairs(v) do
			if sourceID then
				local isCollected = select(5, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
				if Octo_ToDoTransmog[englishClass] == nil then
					Octo_ToDoTransmog[englishClass] = {}
				end
				if Octo_ToDoTransmog[englishClass][itemType] == nil then
					Octo_ToDoTransmog[englishClass][itemType] = {}
				end
				setmetatable(Octo_ToDoTransmog[englishClass][itemType], Meta_Table_0)
				if isCollected == true then
					color = E.Octo_Globals.Green_Color
					Octo_ToDoTransmog[englishClass][itemType][difficultyName] = color.."done|r"
					-- collect.AberrusTransmog[itemType][difficultyName] = color.."done|r"
				else
					color = E.Octo_Globals.Red_Color
					Octo_ToDoTransmog[englishClass][itemType][difficultyName] = color.."done|r"
					-- collect.AberrusTransmog[itemType][difficultyName] = color.."nope|r"
				end
			end
		end
	end
end
function Collect_All_Quest_Tooltip()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local qwid = 77414
	--------------------------------
	collect.DreamsurgeInvestigation = E.Octo_Func.All_objectives(qwid)
end
function Collect_Token_Price()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoOther
	--------------------------------
	-- PLAYER_LOGIN, PLAYER_ENTERING_WORLD, PLAYER_MONEY, TOKEN_MARKET_PRICE_UPDATED
	-- TOKEN_FILTER_LABEL
	-- ITEM_QUALITY8_DESC
	--------------------------------
	if not IsAddOnLoaded("Blizzard_WowTokenUI") then
		LoadAddOn("Blizzard_WowTokenUI")
		-- return
	end
	if not IsAddOnLoaded("Blizzard_AuctionHouseShared") then
		LoadAddOn("Blizzard_AuctionHouseShared")
		-- return
	end
	if not IsAddOnLoaded("Blizzard_AuctionHouseUI") then
		LoadAddOn("Blizzard_AuctionHouseUI")
		-- return
	end
	if not IsAddOnLoaded("Blizzard_TokenUI") then
		LoadAddOn("Blizzard_TokenUI")
		-- return
	end
	if not IsAddOnLoaded("Blizzard_StoreUI") then
		LoadAddOn("Blizzard_StoreUI")
		return
	end
	--------------------------------
	local TokenPrice = C_WowTokenPublic.GetCurrentMarketPrice()
	--------------------------------
	if TokenPrice then
		collect.TokenPrice = TokenPrice or 0
	end
end
function Timer_Legion_Invasion()
	local TIMER = (1547586000-10800)
	local interval = 66600
	local duration = 21600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_Legion_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_Legion_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_Legion_Invasion
end
function Timer_BfA_Invasion()
	local TIMER = (1547586000+3600)
	local interval = 68400
	local duration = 25200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_BfA_Invasion
end
function Timer_BfA_Assault()
	local TIMER = (1547586000+3600+3600+3600+3600+3600+3600+3600)
	local interval = 86400
	local duration = 86400
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_BfA_Assault
end
function Timer_DF_ToDragonbaneKeep()
	local TIMER = 1670342460
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_ToDragonbaneKeep
end
function Timer_DF_GrandHunts()
	local TIMER = 1671307200
	local interval = 7200
	local duration = 7199
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_GrandHunts = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_GrandHunts = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_GrandHunts
end
function Timer_DF_CommunityFeast()
	local TIMER = 1677168000
	local interval = 5400
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_CommunityFeast = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_CommunityFeast = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_CommunityFeast
end
function Timer_DF_PrimalStorms()
	local TIMER = 1683804640
	local interval = 18000
	local duration = 7200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_PrimalStorms = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_PrimalStorms = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_PrimalStorms
end
function Timer_DF_ResearchersUnderFire()
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ResearchersUnderFire = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ResearchersUnderFire = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_ResearchersUnderFire
end
function Timer_DF_TimeRift()
	local TIMER = 1689159620 -- начало в 16:00
	local interval = 60*60 -- каждый час
	local duration = 10*60 -- 10 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_TimeRift = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_TimeRift = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_TimeRift
end
function Timer_DF_Dreamsurges()
	local TIMER = 1689159620 -- начало в 16:00
	local interval = 30*60 -- каждые пол часа
	local duration = 5*60 -- 5 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_Dreamsurges = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_Dreamsurges = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_DF_Dreamsurges
end
function Timer_SL_Maw_Assault()
	local TIMER = 3780
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_SL_Maw_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_SL_Maw_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
	end
	return Timer_SL_Maw_Assault
end
function Timer_Daily_Reset()
	local TIMER = 1687579264
	local interval = 86400
	local duration = 1
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Daily_Reset = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Daily_Reset = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn) .."|r "
		end
		return Timer_Daily_Reset..E.Octo_Globals.Gray_Color.."Daily Reset|r"
	else
		return " "
	end
end
function Octo_ToDoOnLoad()
	if not OctoFrame_EventFrame then
		OctoFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	OctoFrame_EventFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	OctoFrame_EventFrame:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("CALENDAR_CLOSE_EVENT")
	OctoFrame_EventFrame:RegisterEvent("CALENDAR_NEW_EVENT")
	OctoFrame_EventFrame:RegisterEvent("CALENDAR_OPEN_EVENT")
	OctoFrame_EventFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	OctoFrame_EventFrame:RegisterEvent("CALENDAR_UPDATE_EVENT")
	OctoFrame_EventFrame:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
	-- OctoFrame_EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	OctoFrame_EventFrame:RegisterEvent("COVENANT_CHOSEN")
	OctoFrame_EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("HEARTHSTONE_BOUND")
	OctoFrame_EventFrame:RegisterEvent("LFG_COMPLETION_REWARD")
	OctoFrame_EventFrame:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	OctoFrame_EventFrame:RegisterEvent("MAIL_INBOX_UPDATE")
	OctoFrame_EventFrame:RegisterEvent("MAIL_SHOW")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	-- OctoFrame_EventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	OctoFrame_EventFrame:RegisterEvent("TOKEN_MARKET_PRICE_UPDATED")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_LOGOUT")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_MONEY")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
	OctoFrame_EventFrame:RegisterEvent("QUEST_COMPLETE")
	OctoFrame_EventFrame:RegisterEvent("QUEST_FINISHED")
	OctoFrame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	OctoFrame_EventFrame:RegisterEvent("QUEST_REMOVED")
	OctoFrame_EventFrame:RegisterEvent("QUEST_TURNED_IN")
	OctoFrame_EventFrame:RegisterEvent("SPELLS_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("TOYS_UPDATED")
	OctoFrame_EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("UPDATE_PENDING_MAIL")
	OctoFrame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	OctoFrame_EventFrame:RegisterEvent("TRAINER_UPDATE")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_SKILL")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
	OctoFrame_EventFrame:RegisterEvent("READY_CHECK")
	OctoFrame_EventFrame:RegisterEvent("UI_INFO_MESSAGE")
	OctoFrame_EventFrame:RegisterEvent("ENCOUNTER_END")
	OctoFrame_EventFrame:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	OctoFrame_EventFrame:RegisterEvent("CHAT_MSG_LOOT")
	OctoFrame_EventFrame:RegisterEvent("ITEM_PUSH")
	OctoFrame_EventFrame:RegisterEvent("ITEM_COUNT_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("MAIL_SEND_SUCCESS")
	OctoFrame_EventFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
	OctoFrame_EventFrame:RegisterEvent("NEW_TOY_ADDED")
	OctoFrame_EventFrame:RegisterEvent("ITEM_LOCKED")
	OctoFrame_EventFrame:RegisterEvent("ITEM_CHANGED")
	OctoFrame_EventFrame:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED")
	-- OctoFrame_EventFrame:RegisterEvent("RECEIVED_ACHIEVEMENT_LIST")
	-- OctoFrame_EventFrame:RegisterEvent("CRITERIA_UPDATE")
	OctoFrame_EventFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	-- local group = OctoFrame_EventFrame:CreateAnimationGroup()
	OctoFrame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDoOnEvent(...)
	end)
	if not inspectScantip then
		inspectScantip = CreateFrame("GameTooltip", "OctoToDoScanningTooltip", nil, "GameTooltipTemplate")
		inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function O_otrisovka()
	-- ИМЯ
	tinsert(OctoTable_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			CL:SetFontObject(OctoFont12)
			vivodCent = CharInfo.classColorHex..CharInfo.Name
			if CharInfo.Faction == "Horde" then
				BG:SetColorTexture(.5, 0, 0, .2)
			else
				BG:SetColorTexture(0, 0, .5, .2)
			end
			if CharInfo.hasMail then
				BG:SetColorTexture(1, 1, 1, .2)
				vivodCent = MailBox_Icon..vivodCent
			end
			if Octo_ToDoVars.config.ShowOnlyCurrentRealm == false then
				CL:SetFontObject(OctoFont9)
				vivodCent = vivodCent.."|n"..CharInfo.curServer
			end
			----------------------------------------------------------------
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			if CharInfo.className ~= 0 then
				tooltip[#tooltip+1] = {classcolor:WrapTextInColorCode(CharInfo.className), classcolor:WrapTextInColorCode(E.Octo_Func.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName)}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tooltip[#tooltip+1] = {QUESTS_LABEL, CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept}
			end
			if CharInfo.totalSlots ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(133634)..L["Bags"], CharInfo.usedSlots.."/"..CharInfo.totalSlots}
			end
			if CharInfo.PlayerReagentnumSlots == 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(4549254)..E.Octo_Globals.Red_Color..L["No Reagent Bag"].."|r", " "}
			end
			if CharInfo.warmode ~= 0 then
				if CharInfo.warmode == false then
					tooltip[#tooltip+1] = {L["Warmode"], E.Octo_Globals.Red_Color..L["OFF"].."|r"}
				else
					tooltip[#tooltip+1] = {L["Warmode"], E.Octo_Globals.Green_Color..L["ON"].."|r"}
				end
			end
			if CharInfo.currentMountItemID ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(CharInfo.currentMountItemID)..E.Octo_Func.func_itemName(CharInfo.currentMountItemID)}
			end
			----------------------------------------------------------------
			vivodLeft = Timer_Daily_Reset()
			return vivodCent.."|r", vivodLeft
	end)
	-- ЭПОХАЛЬНЫЙ КЛЮЧ
	tinsert(OctoTable_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			vivodLeft = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.Purple_Color..L["Mythic Keystone"].."|r"
			if CharInfo.CurrentKeyFULL ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Globals.Purple_Color..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
			end
			if CharInfo.RIO_Score ~= 0 then
				tooltip[#tooltip+1] = {DUNGEON_SCORE, E.Octo_Globals.Orange_Color..CharInfo.RIO_Score.."|r"}
			end
			if CharInfo.RIO_weeklyBest ~= 0 then
				tooltip[#tooltip+1] = {"Weekly Best", E.Octo_Globals.Orange_Color..CharInfo.RIO_weeklyBest.."|r"}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
			end
			for i = 1, 3 do
				CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
				CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
				CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
				CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
				if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.Octo_Globals.Purple_Color..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
				elseif CharInfo.GreatVault[i].progress ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
				end
			end
			if CharInfo.CurrentKey ~= 0 then
				vivodCent = CharInfo.CurrentKey
			end
			if CharInfo.HasAvailableRewards then
				vivodCent = vivodCent..E.Octo_Globals.Blue_Color..">Vault<|r"
			end
			if CharInfo.ItemsInBag[205225] ~= 0 or CharInfo.ItemsInBag[205999] ~= 0 or CharInfo.ItemsInBag[206046] ~= 0 or CharInfo.ItemsInBag[204843] ~= 0 then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
			end
			if CharInfo.ItemsInBag[206046] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Purple_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(206046)..E.Octo_Globals.Purple_Color..E.Octo_Func.func_itemName_NOCOLOR(206046).."|r", CharInfo.ItemsInBag[206046]}
			end
			if CharInfo.ItemsInBag[204843] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Pink_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204843)..E.Octo_Globals.Pink_Color..E.Octo_Func.func_itemName_NOCOLOR(204843).."|r", CharInfo.ItemsInBag[204843]}
			end
			if CharInfo.ItemsInBag[205999] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Orange_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(205999)..E.Octo_Globals.Orange_Color..E.Octo_Func.func_itemName_NOCOLOR(205999).."|r", CharInfo.ItemsInBag[205999]}
			end
			if CharInfo.ItemsInBag[205225] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.LightGray_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(205225)..E.Octo_Globals.LightGray_Color..E.Octo_Func.func_itemName_NOCOLOR(205225).."|r", CharInfo.ItemsInBag[205225]}
			end
			return vivodCent, vivodLeft
	end)
	-- tinsert(OctoTable_func_otrisovka,
	-- function(CharInfo, tooltip, CL, BG)
	-- local vivodCent, vivodLeft = "", ""
	-- if CharInfo.RIO_Score ~= 0 then
	-- vivodCent = E.Octo_Globals.WOW_Artifact_Color..CharInfo.RIO_Score.."|r"
	-- end
	-- vivodLeft = DUNGEON_SCORE
	-- return vivodCent, vivodLeft
	-- end)
	-- tinsert(OctoTable_func_otrisovka,
	-- function(CharInfo, tooltip, CL, BG)
	-- local vivodCent, vivodLeft = "", ""
	-- local test = 0
	-- for i = 1, 3 do
	-- if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
	-- tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.Octo_Globals.Purple_Color..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
	-- elseif CharInfo.GreatVault[i].progress ~= 0 then
	-- tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
	-- end
	-- end
	-- for i = 1, 3 do
	-- if CharInfo.GreatVault[i].hyperlink[1] ~= 0 then
	-- test = test + 1
	-- end
	-- if CharInfo.GreatVault[i].hyperlink[2] ~= 0 then
	-- test = test + 1
	-- end
	-- if CharInfo.GreatVault[i].hyperlink[3] ~= 0 then
	-- test = test + 1
	-- end
	-- end
	-- if test ~= 0 then
	-- vivodCent = E.Octo_Globals.Orange_Color..test.."/9|r"
	-- end
	-- vivodLeft = GREAT_VAULT_REWARDS
	-- return vivodCent, vivodLeft
	-- end)
	if Octo_ToDoVars.config.ExpansionToShow == 1 then
	end
	if Octo_ToDoVars.config.ExpansionToShow == 2 then
	end
	if Octo_ToDoVars.config.ExpansionToShow == 3 then
	end
	if Octo_ToDoVars.config.ExpansionToShow == 4 then
	end
	if Octo_ToDoVars.config.ExpansionToShow == 5 then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[697] then
					vivodCent = CharInfo.CurrencyID_Total[697]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(697)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(697)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[776] then
					vivodCent = CharInfo.CurrencyID_Total[776]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(776)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(776)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 6 then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1129] then
					vivodCent = CharInfo.CurrencyID_Total[1129].."(+"..CharInfo.Octopussy_WoD_Weekly_coinsQuests_count..")"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1129)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1129)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1129] then
					vivodCent = CharInfo.CurrencyID_Total[994]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(994)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(994)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[823] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[823]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(823)..E.Octo_Func.func_currencyName(823)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1101] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1101]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1101)..E.Octo_Func.func_currencyName(1101)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[824] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[824]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(824)..E.Octo_Func.func_currencyName(824)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[34378] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[34378]
				end
				vivodLeft = E.Octo_Func.func_questName(34378)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetFontObject(OctoFont1)
				if CharInfo.UnitLevel > 40 then
					if CharInfo.CurrencyID[824] < 2000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..CharInfo.CurrencyID[824]..E.Octo_Func.func_currencyicon(824)
					else
						vivodCent = vivodCent..CharInfo.CurrencyID[824]..E.Octo_Func.func_currencyicon(824).."|r"
					end
					if CharInfo.Money/10000 < 5000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000)
					else
						vivodCent = vivodCent..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000).."|r"
					end
					if CharInfo.OctoTable_QuestID[36614] ~= E.Octo_Globals.NONE then
						CL:SetFontObject(OctoFont10)
						vivodCent = CharInfo.OctoTable_QuestID[36614]
					end
				else
					vivodCent = E.Octo_Func.func_texturefromIcon(894556)..E.Octo_Globals.Red_Color..CharInfo.UnitLevel.."/40|r"
				end
				vivodLeft = L["Garrison 3 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[38242] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[38242]
				end
				if CharInfo.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.. "+"..CharInfo.ItemsInBag[122457]..E.Octo_Func.func_itemTexture(122457)
				end
				vivodLeft = E.Octo_Func.func_questName(38242).." (ап пета)"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[39246] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[39246]
				end
				vivodLeft = E.Octo_Func.func_questName(39246)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 7 then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Daily_InvasionQuests_count
					vivodLeft = Timer_Legion_Invasion()..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID)}
				else
					vivodLeft = (Timer_Legion_Invasion().."Timer_Legion_Invasion")
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Weekly_WBALL_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Weekly_WBALL_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Weekly_WBALL_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB"
				end
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID)
				else
					vivodLeft = ("Broken Shore - Armies of Legionfall")
				end
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
				end
				if CharInfo.OctoTable_QuestID[46246] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID)
				else
					vivodLeft = ("Broken Shore - Excavations")
				end
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
				end
				if CharInfo.OctoTable_QuestID[46666] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID)
				else
					vivodLeft = ("Broken Shore - ToArgus")
				end
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
				end
				-- if CharInfo.OctoTable_QuestID[46666] == E.Octo_Globals.DONE then
				-- vivodCent = E.Octo_Globals.DONE
				-- end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_questID ~= E.Octo_Globals.NONE then
					vivodLeft = E.Octo_Func.func_questName(43533)..": "..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BalanceofPower_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BalanceofPower_questID)}
				else
					vivodLeft = E.Octo_Func.func_questName(43533)
				end
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
				end
				if CharInfo.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1273] then
					vivodCent = CharInfo.CurrencyID_Total[1273].."(+"..CharInfo.Octopussy_Legion_Weekly_coinsQuests_count..")"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1273)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1273)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.CurrencyID_Total[1508]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1508)..E.Octo_Func.func_currencyName(1508)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1342] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1342]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1342)..E.Octo_Func.func_currencyName(1342)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1220] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1220]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1220)..E.Octo_Func.func_currencyName(1220)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1226] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1226]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1226)..E.Octo_Func.func_currencyName(1226)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1533] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1533]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1533)..E.Octo_Func.func_currencyName(1533)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1155] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1155]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1155)..E.Octo_Func.func_currencyName(1155)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[124124]
				end
				vivodLeft = E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemTexture(124124)..E.Octo_Func.func_itemName_NOCOLOR(124124).."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				vivodLeft = "bounty_Legion1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				vivodLeft = "bounty_Legion2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				vivodLeft = "bounty_Legion3"
				return vivodCent, vivodLeft
		end)
		-- 1
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 2
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 3
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 4
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 8 then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = (Timer_BfA_Invasion().."Timer_BfA_Invasion (PVP)")
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
				end
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_InvasionQuests_questID)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID ~= E.Octo_Globals.NONE then
					vivodLeft = Timer_BfA_Assault()..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID)}
				else
					vivodLeft = (Timer_BfA_Assault().."Timer_BfA_Assault (N'zoth)")
				end
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
				end
				if CharInfo.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174765]..E.Octo_Func.func_itemTexture(174765)
				end
				if CharInfo.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174761]..E.Octo_Func.func_itemTexture(174761)
				end
				if CharInfo.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174767]..E.Octo_Func.func_itemTexture(174767)
				end
				if CharInfo.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174766]..E.Octo_Func.func_itemTexture(174766)
				end
				if CharInfo.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174768]..E.Octo_Func.func_itemTexture(174768)
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174764)..CharInfo.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.ItemsInBag[174765]..E.Octo_Func.func_itemTexture(174765)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174756)..CharInfo.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.ItemsInBag[174761]..E.Octo_Func.func_itemTexture(174761)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174759)..CharInfo.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174767]..E.Octo_Func.func_itemTexture(174767)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174760)..CharInfo.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174766]..E.Octo_Func.func_itemTexture(174766)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174758)..CharInfo.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.ItemsInBag[174768]..E.Octo_Func.func_itemTexture(174768)}
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Daily_miniVision_count)
				end
				vivodLeft = E.Octo_Globals.Purple_Color.."Mini Vision".."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBALL_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBALL_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBALL_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBALL_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB: Nazjatar"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBAssault_count)
				end
				vivodLeft = WorldBoss_Icon.."World Boss: Assault"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB: PVP"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID ~= E.Octo_Globals.NONE then
					vivodLeft = Rares_Icon.."Rares: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID)}
				else
					vivodLeft = Rares_Icon.."Rares: Darkshore"
				end
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1560] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1560]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1560)..E.Octo_Func.func_currencyName(1560)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1721] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1721]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1721)..E.Octo_Func.func_currencyName(1721)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1803] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1803]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1803)..E.Octo_Func.func_currencyName(1803)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1755] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1755]
				end
				if CharInfo.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent .." +"..CharInfo.ItemsInBag[173363]..E.Octo_Func.func_itemTexture(173363)
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1755)..E.Octo_Func.func_currencyName(1755)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1719] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1719]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1719)..E.Octo_Func.func_currencyName(1719)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1710] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1710]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1710)..E.Octo_Func.func_currencyName(1710)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1716] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1716]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1716)..E.Octo_Func.func_currencyName(1716)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1718] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1718]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1718)..E.Octo_Func.func_currencyName(1718)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[158075] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no neck|r"
				end
				if CharInfo.ItemsInBag[158075] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.. "neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = E.Octo_Func.Empty_Zero(E.Octo_Globals.Green_Color..CharInfo.azeriteLVL.."|r").."|n"..E.Octo_Globals.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				vivodLeft = E.Octo_Func.func_itemTexture(158075)..E.Octo_Func.func_itemName(158075)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[169223] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no cloak|r"
				end
				if CharInfo.ItemsInBag[169223] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.. "neeed to equip|r"
					if CharInfo.cloak_lvl ~= 0 then
						vivodCent = CharInfo.cloak_lvl.." lvl"
						if CharInfo.cloak_lvl == 15 then
							vivodCent = E.Octo_Globals.Green_Color..vivodCent.."|r"
						end
					end
					if CharInfo.cloak_res ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = vivodCent.."|n"..CharInfo.cloak_res
					end
				end
				vivodLeft = E.Octo_Func.func_itemTexture(169223)..E.Octo_Func.func_itemName(169223)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.islandBfA then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.islandBfA)
				end
				vivodLeft = "Collect_BfA_Island"
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					vivodLeft = E.Octo_Func.func_questName(questID)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront1_count)
				end
				vivodLeft = "Warfront: Stromgarde"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront2_count)
				end
				vivodLeft = "Warfront: Darkshore"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count)
				end
				vivodLeft = "Warfront: Heroic"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				vivodLeft = "bounty_BfA1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				vivodLeft = "bounty_BfA2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				vivodLeft = "bounty_BfA3"
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 9 then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Maw: Covenant Assault "..Timer_SL_Maw_Assault()
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[1] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[1])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[7] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[7])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[5] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[5])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[3] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[3])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[2] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[2])
				end
				if CharInfo.Shadowland[2] and CharInfo.Shadowland[2] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 1 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[8] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[8])
				end
				if CharInfo.Shadowland[8] and CharInfo.Shadowland[8] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 4 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[6] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[6])
				end
				if CharInfo.Shadowland[6] and CharInfo.Shadowland[6] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 3 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, .2)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[4] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[4])
				end
				if CharInfo.Shadowland[4] and CharInfo.Shadowland[4] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 2 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[2009])
				vivodLeft = E.Octo_Func.func_currencyicon(2009)..E.Octo_Func.func_currencyName(2009)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1906])
				vivodLeft = E.Octo_Func.func_currencyicon(1906)..E.Octo_Func.func_currencyName(1906)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1828])
				vivodLeft = E.Octo_Func.func_currencyicon(1828)..E.Octo_Func.func_currencyName(1828)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1979])
				vivodLeft = E.Octo_Func.func_currencyicon(1979)..E.Octo_Func.func_currencyName(1979)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1931])
				vivodLeft = E.Octo_Func.func_currencyicon(1931)..E.Octo_Func.func_currencyName(1931)
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent .. E.Octo_Globals.Purple_Color.." +".. CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				vivodLeft = E.Octo_Func.func_texturefromIcon(4074774)..E.Octo_Func.func_questName(66042)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				vivodLeft = E.Octo_Func.func_texturefromIcon(4066373)..E.Octo_Func.func_questName(63949)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..E.Octo_Func.func_questName(65143)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..E.Octo_Func.func_questName(64531)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1813)..E.Octo_Func.func_questName(61981)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 10 then
		-- Помощь союзу
		if Octo_ToDoVars.config.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = E.Octo_Func.func_texturefromIcon(1603189)..L["Aiding the Accord"]
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
						if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_questID ~= E.Octo_Globals.NONE then
							tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_DF_Weekly_AidingtheAccord_questID), CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
						end
					end
					-- BG:SetColorTexture(.31, 1, .47, .1)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.CommunityFeast == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(629056).. Timer_DF_CommunityFeast()..L["Community Feast"])
					if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
					end
					if CharInfo.ItemsInBag[200652] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200652]..E.Octo_Func.func_itemTexture(200652)
					end
					if CharInfo.ItemsInBag[200095] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200095]..E.Octo_Func.func_itemTexture(200095)
					end
					if CharInfo.UnitLevel >= 58 and (CharInfo.KnownSpell[366253] == false or CharInfo.KnownSpell[366253] == 0) then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color.."-|r"
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.ResearchersUnderFire == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(236469)..Timer_DF_ResearchersUnderFire()..L["Researchers Under Fire"])
					if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.OctoTable_QuestID[75630]} -- MAW_BUFF_QUALITY_STRING_EPIC Epic
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.OctoTable_QuestID[75629]} -- MAW_BUFF_QUALITY_STRING_RARE Rare
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.OctoTable_QuestID[75628]} -- MAW_BUFF_QUALITY_STRING_UNCOMMON Uncommon
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.OctoTable_QuestID[75627]} -- MAW_BUFF_QUALITY_STRING_COMMON Common
					end
					return vivodCent, vivodLeft
			end)
		end
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.ItemsInBag[204193] ~= 0 or CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.CurrencyID[2409] ~= 0 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204075)..E.Octo_Globals.Green_Color..E.Octo_Func.func_itemName_NOCOLOR(204075).."|r"..E.Octo_Globals.Gray_Color.." LFR, M+1-5".."|r", CharInfo.ItemsInBag[204075]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]..")|r"}
				end
				if CharInfo.ItemsInBag[204076] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204076)..E.Octo_Globals.Blue_Color..E.Octo_Func.func_itemName_NOCOLOR(204076).."|r"..E.Octo_Globals.Gray_Color.." Normal, M+6-10".."|r", CharInfo.ItemsInBag[204076]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]..")|r"}
				end
				if CharInfo.ItemsInBag[204077] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204077)..E.Octo_Globals.Purple_Color..E.Octo_Func.func_itemName_NOCOLOR(204077).."|r"..E.Octo_Globals.Gray_Color.." Heroic, M+11-15".."|r", CharInfo.ItemsInBag[204077]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]..")|r"}
				end
				if CharInfo.ItemsInBag[204078] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204078)..E.Octo_Globals.Orange_Color..E.Octo_Func.func_itemName_NOCOLOR(204078).."|r"..E.Octo_Globals.Gray_Color.." Mythic, M+16+".."|r", CharInfo.ItemsInBag[204078]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]..")|r"}
				end
				if CharInfo.ItemsInBag[204193] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Green_Color..CharInfo.ItemsInBag[204193].." |r"
				end
				if CharInfo.ItemsInBag[204195] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color..CharInfo.ItemsInBag[204195].." |r"
				end
				if CharInfo.ItemsInBag[204196] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Purple_Color..CharInfo.ItemsInBag[204196].." |r"
				end
				if CharInfo.ItemsInBag[204194] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Orange_Color..CharInfo.ItemsInBag[204194].." |r"
				end
				if CharInfo.CurrencyID[2409] ~= 0 and (CharInfo.CurrencyID[2409] == CharInfo.CurrencyID_maxQuantity[2409]) then
					vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[2245] ~= 0 then
					vivodCent = CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]
				end
				if CharInfo.CurrencyID[2245] == CharInfo.CurrencyID_maxQuantity[2245] then
					vivodCent = E.Octo_Globals.Green_Color..vivodCent.."|r"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(2533)..E.Octo_Func.func_currencyName(2533)
				if CharInfo.CurrencyID[2533] ~= 0 then
					vivodCent = E.Octo_Globals.WOW_Legendary_Color..CharInfo.CurrencyID[2533].."|r"
				end
				-- if CharInfo.CurrencyID[2533] < (CharInfo.CurrencyID_maxQuantity[2533] or 8) and CharInfo.needResetWeekly == true then
				-- 	vivodCent = E.Octo_Globals.Red_Color..CharInfo.CurrencyID[2533].."|r"
				-- end
				return vivodCent, vivodLeft
		end)
		-- ТРАНСМОГ
		if Octo_ToDoVars.config.ShowTransmogrification == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(1673939).."Аберрий"
					-- vivodCent = CharInfo.classColorHex..CharInfo.classFilename.."|r"
					vivodCent = E.Octo_Func.func_texturefromIcon(1673939)
					if CharInfo.classFilename == "WARRIOR"
					or CharInfo.classFilename == "PALADIN"
					-- or CharInfo.classFilename == "HUNTER"
					or CharInfo.classFilename == "ROGUE"
					or CharInfo.classFilename == "PRIEST"
					-- or CharInfo.classFilename == "SHAMAN"
					-- or CharInfo.classFilename == "MAGE"
					-- or CharInfo.classFilename == "WARLOCK"
					or CharInfo.classFilename == "MONK"
					or CharInfo.classFilename == "DRUID"
					or CharInfo.classFilename == "DEMONHUNTER"
					-- or CharInfo.classFilename == "DEATHKNIGHT"
					-- or CharInfo.classFilename == "EVOKER"
					then
						tooltip[#tooltip+1] = {E.Octo_Globals.DONE, CharInfo.classColorHex.."LFR/Norm/Hero/Myth".."|r"}
					else
						tooltip[#tooltip+1] = {"|cffFF0000".."Нет".."|r", CharInfo.classColorHex.."LFR/Norm/Hero/Myth".."|r"}
						vivodCent = vivodCent.."|cffFF0000".."*".."|r"
					end
					for _, classFilename in pairs(E.Octo_Table.OctoTable_EnglishClasses) do
						if classFilename == CharInfo.classFilename then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Head"].."|r", Octo_ToDoTransmog[classFilename].Head.LFR.."/"..Octo_ToDoTransmog[classFilename].Head.Normal.."/"..Octo_ToDoTransmog[classFilename].Head.Heroic.."/"..Octo_ToDoTransmog[classFilename].Head.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Shoulder"].."|r", Octo_ToDoTransmog[classFilename].Shoulder.LFR.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Normal.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Heroic.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Back"].."|r", Octo_ToDoTransmog[classFilename].Back.LFR.."/"..Octo_ToDoTransmog[classFilename].Back.Normal.."/"..Octo_ToDoTransmog[classFilename].Back.Heroic.."/"..Octo_ToDoTransmog[classFilename].Back.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Chest"].."|r", Octo_ToDoTransmog[classFilename].Chest.LFR.."/"..Octo_ToDoTransmog[classFilename].Chest.Normal.."/"..Octo_ToDoTransmog[classFilename].Chest.Heroic.."/"..Octo_ToDoTransmog[classFilename].Chest.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Wrist"].."|r", Octo_ToDoTransmog[classFilename].Wrist.LFR.."/"..Octo_ToDoTransmog[classFilename].Wrist.Normal.."/"..Octo_ToDoTransmog[classFilename].Wrist.Heroic.."/"..Octo_ToDoTransmog[classFilename].Wrist.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Hands"].."|r", Octo_ToDoTransmog[classFilename].Hands.LFR.."/"..Octo_ToDoTransmog[classFilename].Hands.Normal.."/"..Octo_ToDoTransmog[classFilename].Hands.Heroic.."/"..Octo_ToDoTransmog[classFilename].Hands.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Waist"].."|r", Octo_ToDoTransmog[classFilename].Waist.LFR.."/"..Octo_ToDoTransmog[classFilename].Waist.Normal.."/"..Octo_ToDoTransmog[classFilename].Waist.Heroic.."/"..Octo_ToDoTransmog[classFilename].Waist.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Legs"].."|r", Octo_ToDoTransmog[classFilename].Legs.LFR.."/"..Octo_ToDoTransmog[classFilename].Legs.Normal.."/"..Octo_ToDoTransmog[classFilename].Legs.Heroic.."/"..Octo_ToDoTransmog[classFilename].Legs.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Feet"].."|r", Octo_ToDoTransmog[classFilename].Feet.LFR.."/"..Octo_ToDoTransmog[classFilename].Feet.Normal.."/"..Octo_ToDoTransmog[classFilename].Feet.Heroic.."/"..Octo_ToDoTransmog[classFilename].Feet.Mythic}
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		-- tinsert(OctoTable_func_otrisovka,
		-- 	function(CharInfo, tooltip, CL, BG)
		-- 		local vivodCent, vivodLeft = "", ""
		-- 		vivodLeft = E.Octo_Func.func_texturefromIcon(2065622)..E.Octo_Func.func_texturefromIcon(237245)..E.Octo_Func.func_questName(77236)
		-- 		if CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count ~= E.Octo_Globals.NONE then
		-- 			vivodCent = vivodCent..CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count
		-- 		end
		-- 		if CharInfo.ItemsInBag[208951] ~= 0 then
		-- 			vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.."+|r"
		-- 			tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2065622)..E.Octo_Func.func_itemName(208951), CharInfo.ItemsInBag[208951]}
		-- 		end
		-- 		if CharInfo.ItemsInBag[208952] ~= 0 then
		-- 			vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.."+|r"
		-- 			tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(237245)..E.Octo_Func.func_itemName(208952), CharInfo.ItemsInBag[208952]}
		-- 		end
		-- 		BG:SetColorTexture(.64, .21, .93, .1)
		-- 		return vivodCent, vivodLeft
		-- end)
		if Octo_ToDoVars.config.TimeRift == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(628677)..Timer_DF_TimeRift()..L["TimeRift"])
					if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
					end
					BG:SetColorTexture(.64, .21, .93, BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(2026009)..E.Octo_Func.func_itemName(207030)
					if CharInfo.ItemsInBag[207030] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[207030].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(1391676)..E.Octo_Func.func_itemName(207002)
					if CharInfo.ItemsInBag[207002] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.ItemsInBag[207002].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.CurrencyID[2594] ~= 0 then
						if CharInfo.CurrencyID[2594] < 500 then
							vivodCent = E.Octo_Globals.Gray_Color..CharInfo.CurrencyID[2594].."|r"
						else
							vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.CurrencyID[2594].."|r"
						end
					end
					if CharInfo.ItemsInBag[208945] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.." +"..CharInfo.ItemsInBag[208945].."|r"..E.Octo_Func.func_itemTexture(208945)
					end
					vivodLeft = E.Octo_Func.func_currencyicon(2594)..E.Octo_Globals.WOW_Rare_Color..L["Transferable Flakes"]..":|r "..E.Octo_Globals.White_Color..TotalTransParacausalFlakes.."|r"
					BG:SetColorTexture(.64, .21, .93, BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.Dreamsurges == true then
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(134206)..Timer_DF_Dreamsurges()..L["Dreamsurges"])
					if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
					end
					if CharInfo.ItemsInBag[209419] ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1044087)..E.Octo_Globals.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.ItemsInBag[209419]}
					end
					BG:SetColorTexture(.31, 1, .47, BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(77414)
					vivodCent = CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count
					if CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= E.Octo_Globals.DONE and CharInfo.DreamsurgeInvestigation ~= 0 and CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= "" then
						tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..E.Octo_Func.func_questName(77414).."|r", CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
						tooltip[#tooltip+1] = {CharInfo.DreamsurgeInvestigation, " "}
					end
					BG:SetColorTexture(.31, 1, .47, BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(4643985)..E.Octo_Globals.WOW_Epic_Color..L["Dreamsurge Chrysalis"].."|r"
					if CharInfo.ItemsInBag[208153] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[208153].."|r"
					end
					BG:SetColorTexture(.31, 1, .47, BGALPHA)
					return vivodCent, vivodLeft
			end)
			-- tinsert(OctoTable_func_otrisovka,
			-- 	function(CharInfo, tooltip, CL, BG)
			-- 		local vivodCent, vivodLeft = "", ""
			-- 		vivodLeft = E.Octo_Func.func_texturefromIcon(1044087)..E.Octo_Globals.WOW_Rare_Color..L["Charred Elemental Remains"].."|r"
			-- 		if CharInfo.ItemsInBag[209419] ~= 0 then
			-- 			vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.ItemsInBag[209419].."|r"
			-- 		end
			-- 		BG:SetColorTexture(.31, 1, .47, BGALPHA)
			-- 		return vivodCent, vivodLeft
			-- end)
			tinsert(OctoTable_func_otrisovka,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(132858)..E.Octo_Globals.WOW_Common_Color..L["Dreamsurge Coalescence"].."|r"
					if CharInfo.ItemsInBag[207026] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Common_Color..CharInfo.ItemsInBag[207026].."|r"
					end
					BG:SetColorTexture(.31, 1, .47, BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		-- События
		if Octo_ToDoVars.config.ShowEvents == true then
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[628] then -- Путешествие во времени по подземельям (Катазклизм)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(514016).."Cataclysm"
							if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
							if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(1542852)..L["Firelands"]
							if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
							if CharInfo.CurrencyID[1166] ~= 0 then
								vivodCent = CharInfo.CurrencyID[1166]
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
				end -- for 628
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[622] then -- Путешествие во времени по подземельям (Burning Crusade)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(514016).."Burning Crusade"
							if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
							if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(1542852)..L["Black Temple"]
							if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
							if CharInfo.CurrencyID[1166] ~= 0 then
								vivodCent = CharInfo.CurrencyID[1166]
							end
							BG:SetColorTexture(0, .65, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
				end -- for 622
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[1400] then -- Кубок Восточных королевств
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = Octo_ToDo_SmartCollectNEW.Holiday.Collect[1400]
							if CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count
							end
							BG:SetColorTexture(1, .79, .54, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(4638724)..E.Octo_Func.func_currencyName(2588)
							if CharInfo.CurrencyID[2588] ~= 0 then
								vivodCent = CharInfo.CurrencyID[2588]
							end
							BG:SetColorTexture(1, .79, .54, BGALPHA)
							return vivodCent, vivodLeft
					end)
				end -- for 1400
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[479] then -- Ярмарка Новолуния (Darkmoon Faire)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(354435)..E.Octo_Globals.Blue_Color.."Daily |r"..Octo_ToDo_SmartCollectNEW.Holiday.Collect[479]
							if CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= "0/9" then
								vivodCent = CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count
							end
							BG:SetColorTexture(.54, .12, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(134481)..E.Octo_Func.func_currencyName(515)
							if CharInfo.CurrencyID[515] ~= 0 then
								vivodCent = CharInfo.CurrencyID[515]
							end
							BG:SetColorTexture(.54, .12, 1, BGALPHA)
							return vivodCent, vivodLeft
					end)
					-- -- БИЛЕТЫ
					-- tinsert(OctoTable_func_otrisovka,
					-- 	function(CharInfo, tooltip, CL, BG)
					-- 		local vivodCent, vivodLeft = "", ""
					-- 		vivodLeft = E.Octo_Func.func_texturefromIcon(134481)..E.Octo_Func.func_itemName(81055)
					-- 		if CharInfo.ItemsInBag[81055] ~= 0 then
					-- 			vivodCent = CharInfo.ItemsInBag[81055]
					-- 		end
					-- 		BG:SetColorTexture(.54, .12, 1, BGALPHA)
					-- 		return vivodCent, vivodLeft
					-- end)
				end -- for 479
		end
		-- События (PvP)
		if Octo_ToDoVars.config.ShowPVPEvents == true then
			if Octo_ToDo_SmartCollectNEW.Holiday.Active[602] then -- "Бонус на полях боя",
				tinsert(OctoTable_func_otrisovka,
					function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if englishFaction == "Horde" then
						vivodLeft = Horde_Icon
					else
						vivodLeft = Alliance_Icon
					end
					if CharInfo.Faction == "Horde" then
						BG:SetColorTexture(1, .3, .31, BGALPHA)
					else
						BG:SetColorTexture(0, .65, 1, BGALPHA)
					end
					if CharInfo.Octopussy_DF_Weekly_ACalltoBattle_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ACalltoBattle_count
					end
					vivodLeft = vivodLeft.. Octo_ToDo_SmartCollectNEW.Holiday.Collect[602]
					return vivodCent, vivodLeft
				end)
			end
			if Octo_ToDo_SmartCollectNEW.Holiday.Active[1049] or Octo_ToDo_SmartCollectNEW.Holiday.Active[671] or Octo_ToDo_SmartCollectNEW.Holiday.Active[1244] then
				tinsert(OctoTable_func_otrisovka,
					function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if englishFaction == "Horde" then
						vivodLeft = Horde_Icon
					else
						vivodLeft = Alliance_Icon
					end
					if CharInfo.Faction == "Horde" then
						BG:SetColorTexture(1, .3, .31, BGALPHA)
					else
						BG:SetColorTexture(0, .65, 1, BGALPHA)
					end
					if CharInfo.Octopussy_DF_Weekly_SomethingDifferent_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_SomethingDifferent_count
					end
					vivodLeft = vivodLeft.."PvP-потасовка"
					return vivodCent, vivodLeft
				end)
			end
			if Octo_ToDo_SmartCollectNEW.Holiday.Active[610] then -- "Бонус за стычки на арене",
				tinsert(OctoTable_func_otrisovka,
					function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if englishFaction == "Horde" then
						vivodLeft = Horde_Icon
					else
						vivodLeft = Alliance_Icon
					end
					if CharInfo.Faction == "Horde" then
						BG:SetColorTexture(1, .3, .31, BGALPHA)
					else
						BG:SetColorTexture(0, .65, 1, BGALPHA)
					end
					if CharInfo.Octopussy_DF_Weekly_TheArenaCalls_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_TheArenaCalls_count
					end
					vivodLeft = vivodLeft.. Octo_ToDo_SmartCollectNEW.Holiday.Collect[610]
					return vivodCent, vivodLeft
				end)
			end
		end
		-- Праздники
		if Octo_ToDoVars.config.ShowHoliday == true then
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[341] then -- Summer Festival
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = "SummerFestival"
							if CharInfo.Octopussy_DF_Month_SummerFestival_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Month_SummerFestival_count.." ("..CharInfo.ItemsInBag[23247]..E.Octo_Func.func_itemTexture(23247)..")"
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
				end -- for 341
				if Octo_ToDo_SmartCollectNEW.Holiday.Active[372] then -- BREWFEST
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							if CharInfo.LFGInstance[287].D_name ~= E.Octo_Globals.NONE then
								vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..CharInfo.LFGInstance[287].D_name
							end
							if CharInfo.LFGInstance[287].donetoday ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.LFGInstance[287].donetoday
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka, -- EVENT ID 372 (Brewfest)
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Func.func_texturefromIcon(133784)..E.Octo_Func.func_itemName(37829)
							-- vivodLeft = E.Octo_Func.func_texturefromIcon(236701).."Brewfest"
							if CharInfo.ItemsInBag[37829] ~= 0 then
								vivodCent = CharInfo.ItemsInBag[37829] --..Money_Icon
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701).. E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(77155)
							if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
								vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_count
							end
							-- 77155, 77152, 77153, 77747, 76531, 77099, 77745, 77095, 77746, 77096, 77744, 77097,
							if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.DONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
								tooltip[#tooltip+1] = {E.Octo_Globals.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
								tooltip[#tooltip+1] = {"/way #2022 58.26 67.58", CharInfo.OctoTable_QuestID[76531]} -- /way #2022 58.26 67.58
								tooltip[#tooltip+1] = {"/way #2022 76.35 35.43", CharInfo.OctoTable_QuestID[77095]} -- /way #2022 76.35 35.43
								tooltip[#tooltip+1] = {"/way #2022 47.67 83.27", CharInfo.OctoTable_QuestID[77744]} -- /way #2022 47.67 83.27
								tooltip[#tooltip+1] = {" ", " "}
								tooltip[#tooltip+1] = {E.Octo_Globals.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
								tooltip[#tooltip+1] = {"/way #2023 59.77 38.73", CharInfo.OctoTable_QuestID[77152]} -- /way #2023 59.77 38.73
								tooltip[#tooltip+1] = {"/way #2023 28.61 60.45", CharInfo.OctoTable_QuestID[77099]} -- /way #2023 28.61 60.45
								tooltip[#tooltip+1] = {"/way #2023 85.81 35.34", CharInfo.OctoTable_QuestID[77745]} -- /way #2023 85.81 35.34
								tooltip[#tooltip+1] = {" ", " "}
								tooltip[#tooltip+1] = {E.Octo_Globals.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
								tooltip[#tooltip+1] = {"/way #2024 62.79 57.74", CharInfo.OctoTable_QuestID[77746]} -- /way #2024 62.79 57.74
								tooltip[#tooltip+1] = {"/way #2024 46.92 40.23", CharInfo.OctoTable_QuestID[77096]} -- /way #2024 46.92 40.23
								tooltip[#tooltip+1] = {"/way #2024 12.39 49.33", CharInfo.OctoTable_QuestID[77097]} -- /way #2024 12.39 49.33
								tooltip[#tooltip+1] = {" ", " "}
								tooltip[#tooltip+1] = {E.Octo_Globals.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
								tooltip[#tooltip+1] = {"/way #2025 50.1 42.71", CharInfo.OctoTable_QuestID[77747]} -- верх -- /way #2025 50.1 42.71
								tooltip[#tooltip+1] = {"/way #2025 52.2 81.5", CharInfo.OctoTable_QuestID[77155]} -- низ -- /way #2025 52.2 81.5
								tooltip[#tooltip+1] = {"/way #2112 47.87 47.74", CharInfo.OctoTable_QuestID[77153]} -- таверна -- /way #2112 47.87 47.74
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701).. E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(12492)
							if CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701).. E.Octo_Globals.Blue_Color.."Daily |r"..E.Octo_Func.func_questName(76591)
							if CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
					tinsert(OctoTable_func_otrisovka,
						function(CharInfo, tooltip, CL, BG)
							local vivodCent, vivodLeft = "", ""
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701).. E.Octo_Globals.Blue_Color.."Daily |r"..E.Octo_Func.func_questName(77208)
							if CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count ~= E.Octo_Globals.NONE then
								vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count
							end
							BG:SetColorTexture(1, .95, .44, BGALPHA)
							return vivodCent, vivodLeft
					end)
				end -- for 372
		end
	end
	-- Рейды тест Инсты
	if Octo_ToDoVars.config.InstanceTracker == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				-- if Octo_ToDoVars.config.ExpansionToShow == 10 then
				-- end
				local ServerTime = GetServerTime()
				for _, v in pairs(E.Octo_Table.OctoTable_journalInstanceID) do
					if CharInfo.journalInstance[v] ~= nil then
						for _, w in pairs(E.Octo_Table.OctoTable_instanceDifficulty) do
							if CharInfo.journalInstance[v][w] ~= nil then
								if CharInfo.journalInstance[v][w].vivod ~= nil and CharInfo.journalInstance[v][w].Time ~= nil then
									tooltip[#tooltip+1] = {CharInfo.journalInstance[v][w].instanceName.."("..CharInfo.journalInstance[v][w].difficultyName..") "..E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(CharInfo.journalInstance[v][w].instanceReset-ServerTime).."|r", CharInfo.journalInstance[v][w].vivod}
								end
							end
						end
					end
				end
				if #tooltip ~= 0 then
					-- vivodCent = E.Octo_Globals.Yellow_Color.."КД|r"
					vivodCent = E.Octo_Globals.Gray_Color..RAID_INFORMATION.."|r"
				end
				vivodLeft = "InstanceTracker"
				return vivodCent, vivodLeft
		end)
	end
	-- Валюта
	if Octo_ToDoVars.config.ShowCurrency == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245), CharInfo.CurrencyID_Total[2245]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2594)..E.Octo_Func.func_currencyName(2594), CharInfo.CurrencyID_Total[2594]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2122)..E.Octo_Func.func_currencyName(2122), CharInfo.CurrencyID_Total[2122]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2118)..E.Octo_Func.func_currencyName(2118), CharInfo.CurrencyID_Total[2118]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2003)..E.Octo_Func.func_currencyName(2003), CharInfo.CurrencyID_Total[2003]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2009)..E.Octo_Func.func_currencyName(2009), CharInfo.CurrencyID_Total[2009]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1906)..E.Octo_Func.func_currencyName(1906), CharInfo.CurrencyID_Total[1906]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1828)..E.Octo_Func.func_currencyName(1828), CharInfo.CurrencyID_Total[1828]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1977)..E.Octo_Func.func_currencyName(1977), CharInfo.CurrencyID_Total[1977]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1813)..E.Octo_Func.func_currencyName(1813), CharInfo.CurrencyID_Total[1813]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1979)..E.Octo_Func.func_currencyName(1979), CharInfo.CurrencyID_Total[1979]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1904)..E.Octo_Func.func_currencyName(1904), CharInfo.CurrencyID_Total[1904]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1819)..E.Octo_Func.func_currencyName(1819), CharInfo.CurrencyID_Total[1819]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1931)..E.Octo_Func.func_currencyName(1931), CharInfo.CurrencyID_Total[1931]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1767)..E.Octo_Func.func_currencyName(1767), CharInfo.CurrencyID_Total[1767]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1885)..E.Octo_Func.func_currencyName(1885), CharInfo.CurrencyID_Total[1885]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1820)..E.Octo_Func.func_currencyName(1820), CharInfo.CurrencyID_Total[1820]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1816)..E.Octo_Func.func_currencyName(1816), CharInfo.CurrencyID_Total[1816]}
					if CharInfo.Possible_Anima == 0 and CharInfo.Possible_CatalogedResearch == 0 then
						vivodCent = E.Octo_Globals.Gray_Color..CURRENCY.."|r"
					end
					if CharInfo.Possible_Anima ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.Blue_Color..CharInfo.Possible_Anima.."|r"
					end
					if CharInfo.Possible_CatalogedResearch ~= 0 then
						vivodCent = vivodCent.." "..E.Octo_Globals.Rift_Color..CharInfo.Possible_CatalogedResearch.."|r"
					end
					if CharInfo.OctoTable_QuestID[64367] ~= E.Octo_Globals.Green_Color.."Done|r" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(187136)..E.Octo_Func.func_itemName(187136), E.Octo_Globals.Rift_Color.."(Korthia)|r".."Нужно купить +50%".. E.Octo_Func.func_currencyicon(1931)}
						vivodCent = vivodCent..E.Octo_Globals.Rift_Color.."-".."|r"
					end
					if CharInfo.OctoTable_QuestID[65282] ~= E.Octo_Globals.Green_Color.."Done|r" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(188793)..E.Octo_Func.func_itemName(188793), E.Octo_Globals.Cyan_Color.."(ZerethMortis)|r".."Нужно купить +50%".. E.Octo_Func.func_currencyicon(1979)}
						vivodCent = vivodCent..E.Octo_Globals.Cyan_Color.."-".."|r"
					end
					vivodLeft = L["Transferable Anima"]..": "..E.Octo_Globals.Blue_Color..TotalTransAnima.."|r"
				end
				if Octo_ToDoVars.config.ExpansionToShow == 8 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1580)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1580), CharInfo.CurrencyID_Total[1580].."(+"..CharInfo.Octopussy_BfA_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1803)..E.Octo_Func.func_currencyName(1803), CharInfo.CurrencyID_Total[1803]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1721)..E.Octo_Func.func_currencyName(1721), CharInfo.CurrencyID_Total[1721]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1587)..E.Octo_Func.func_currencyName(1587), CharInfo.CurrencyID_Total[1587]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1299)..E.Octo_Func.func_currencyName(1299), CharInfo.CurrencyID_Total[1299]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1565)..E.Octo_Func.func_currencyName(1565), CharInfo.CurrencyID_Total[1565]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1715)..E.Octo_Func.func_currencyName(1715), CharInfo.CurrencyID_Total[1715]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1755)..E.Octo_Func.func_currencyName(1755), CharInfo.CurrencyID_Total[1755]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1710)..E.Octo_Func.func_currencyName(1710), CharInfo.CurrencyID_Total[1710]}
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1716)..E.Octo_Func.func_currencyName(1716), CharInfo.CurrencyID_Total[1716]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1717)..E.Octo_Func.func_currencyName(1717), CharInfo.CurrencyID_Total[1717]}
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1560)..E.Octo_Func.func_currencyName(1560), CharInfo.CurrencyID_Total[1560]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1719)..E.Octo_Func.func_currencyName(1719), CharInfo.CurrencyID_Total[1719]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1718)..E.Octo_Func.func_currencyName(1718), CharInfo.CurrencyID_Total[1718]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 7 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1273)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1273), CharInfo.CurrencyID_Total[1273].."(+"..CharInfo.Octopussy_Legion_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1356)..E.Octo_Func.func_currencyName(1356), CharInfo.CurrencyID_Total[1356]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1275)..E.Octo_Func.func_currencyName(1275), CharInfo.CurrencyID_Total[1275]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1357)..E.Octo_Func.func_currencyName(1357), CharInfo.CurrencyID_Total[1357]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1508)..E.Octo_Func.func_currencyName(1508), CharInfo.CurrencyID_Total[1508]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1416)..E.Octo_Func.func_currencyName(1416), CharInfo.CurrencyID_Total[1416]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1342)..E.Octo_Func.func_currencyName(1342), CharInfo.CurrencyID_Total[1342]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1355)..E.Octo_Func.func_currencyName(1355), CharInfo.CurrencyID_Total[1355]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1154)..E.Octo_Func.func_currencyName(1154), CharInfo.CurrencyID_Total[1154]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1314)..E.Octo_Func.func_currencyName(1314), CharInfo.CurrencyID_Total[1314]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1149)..E.Octo_Func.func_currencyName(1149), CharInfo.CurrencyID_Total[1149]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1533)..E.Octo_Func.func_currencyName(1533), CharInfo.CurrencyID_Total[1533]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1226)..E.Octo_Func.func_currencyName(1226), CharInfo.CurrencyID_Total[1226]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1155)..E.Octo_Func.func_currencyName(1155), CharInfo.CurrencyID_Total[1155]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1220)..E.Octo_Func.func_currencyName(1220), CharInfo.CurrencyID_Total[1220]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1268)..E.Octo_Func.func_currencyName(1268), CharInfo.CurrencyID_Total[1268]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 6 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1129)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1129), CharInfo.CurrencyID_Total[1129].."(+"..CharInfo.Octopussy_WoD_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(994)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(994), CharInfo.CurrencyID_Total[994]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(823)..E.Octo_Func.func_currencyName(823), CharInfo.CurrencyID_Total[823]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(824)..E.Octo_Func.func_currencyName(824), CharInfo.CurrencyID_Total[824]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1101)..E.Octo_Func.func_currencyName(1101), CharInfo.CurrencyID_Total[1101]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(980)..E.Octo_Func.func_currencyName(980), CharInfo.CurrencyID_Total[980]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1017)..E.Octo_Func.func_currencyName(1017), CharInfo.CurrencyID_Total[1017]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(910)..E.Octo_Func.func_currencyName(910), CharInfo.CurrencyID_Total[910]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(944)..E.Octo_Func.func_currencyName(944), CharInfo.CurrencyID_Total[944]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1008)..E.Octo_Func.func_currencyName(1008), CharInfo.CurrencyID_Total[1008]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1020)..E.Octo_Func.func_currencyName(1020), CharInfo.CurrencyID_Total[1020]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(999)..E.Octo_Func.func_currencyName(999), CharInfo.CurrencyID_Total[999]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Mists of Pandaria".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(697)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(697), CharInfo.CurrencyID_Total[697]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(776)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(776), CharInfo.CurrencyID_Total[776]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(777)..E.Octo_Func.func_currencyName(777), CharInfo.CurrencyID_Total[777]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(738)..E.Octo_Func.func_currencyName(738), CharInfo.CurrencyID_Total[738]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(752)..E.Octo_Func.func_currencyName(752), CharInfo.CurrencyID_Total[752]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(789)..E.Octo_Func.func_currencyName(789), CharInfo.CurrencyID_Total[789]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Cataclysm".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(416)..E.Octo_Func.func_currencyName(416), CharInfo.CurrencyID_Total[416]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(361)..E.Octo_Func.func_currencyName(361), CharInfo.CurrencyID_Total[361]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(615)..E.Octo_Func.func_currencyName(615), CharInfo.CurrencyID_Total[615]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(614)..E.Octo_Func.func_currencyName(614), CharInfo.CurrencyID_Total[614]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Wrath of the Lich King".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(241)..E.Octo_Func.func_currencyName(241), CharInfo.CurrencyID_Total[241]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(61)..E.Octo_Func.func_currencyName(61), CharInfo.CurrencyID_Total[61]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 2 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."The Burning Crusade".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1704)..E.Octo_Func.func_currencyName(1704), CharInfo.CurrencyID_Total[1704]}
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(GROUP_FINDER, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), ""}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1166)..E.Octo_Func.func_currencyName(1166), CharInfo.CurrencyID_Total[1166]}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."PvP".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1602)..E.Octo_Func.func_currencyName(1602), CharInfo.CurrencyID_Total[1602]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1792)..E.Octo_Func.func_currencyName(1792), CharInfo.CurrencyID_Total[1792]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2123)..E.Octo_Func.func_currencyName(2123), CharInfo.CurrencyID_Total[2123]}
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(391)..E.Octo_Func.func_currencyName(391), CharInfo.CurrencyID_Total[391]}
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Other"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2032)..E.Octo_Func.func_currencyName(2032), E.Octo_Func.func_currencyquantity(2032)} -- все персы
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2588)..E.Octo_Func.func_currencyName(2588), CharInfo.CurrencyID_Total[2588]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1379)..E.Octo_Func.func_currencyName(1379), CharInfo.CurrencyID_Total[1379]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(515)..E.Octo_Func.func_currencyName(515), CharInfo.CurrencyID_Total[515]}
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(402)..E.Octo_Func.func_currencyName(402), CharInfo.CurrencyID_Total[402]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(81)..E.Octo_Func.func_currencyName(81), CharInfo.CurrencyID_Total[81]}
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..CURRENCY.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- РЕПУТАЦИЯ
	if Octo_ToDoVars.config.ShowReputation == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for k, v in ipairs (E.Octo_Table.OctoTable_itemID_Reputation) do
					if CharInfo.ItemsInBag[v] ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v), CharInfo.ItemsInBag[v]}
					end
				end
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2507), CharInfo.reputationID[2507]} -- Драконья экспедиция
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2503), CharInfo.reputationID[2503]} -- Кентавры Маруук
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2511), CharInfo.reputationID[2511]} -- Искарские клыкарры
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2510), CharInfo.reputationID[2510]} -- Союз Вальдраккена
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2553), CharInfo.reputationID[2553]} -- Соридорми
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zaralek Cavern"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2564), CharInfo.reputationID[2564]} -- Лоаммские ниффы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2568), CharInfo.reputationID[2568]} -- Гонщик Мерцающего Огга
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["The Forbidden Reach"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2523), CharInfo.reputationID[2523]}
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2524), CharInfo.reputationID[2524]}
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Other"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2517), CharInfo.reputationID[2517]} -- Гневион
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2518), CharInfo.reputationID[2518]} -- Сабеллиан
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2550), CharInfo.reputationID[2550]} -- Кобальтовая ассамблея
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2544), CharInfo.reputationID[2544]} -- Консорциум ремесленников – филиал на Драконьих островах
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2526), CharInfo.reputationID[2526]} -- Фурболги из клана Зимней Шкуры
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2478), CharInfo.reputationID[2478]} -- Просветленные
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2470), CharInfo.reputationID[2470]} -- Легион Смерти
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2472), CharInfo.reputationID[2472]} -- Кодекс архивариуса
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2432), CharInfo.reputationID[2432]} -- Ве'нари
					tooltip[#tooltip+1] = {Kyrian_Icon..E.Octo_Func.func_reputationName(2407), CharInfo.reputationID[2407]} -- Перерожденные
					tooltip[#tooltip+1] = {Necrolord_Icon..E.Octo_Func.func_reputationName(2410), CharInfo.reputationID[2410]} -- Неумирающая армия
					tooltip[#tooltip+1] = {NightFae_Icon..E.Octo_Func.func_reputationName(2465), CharInfo.reputationID[2465]} -- Дикая Охота
					tooltip[#tooltip+1] = {Venthyr_Icon..E.Octo_Func.func_reputationName(2413), CharInfo.reputationID[2413]} -- Двор Жнецов
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2439), CharInfo.reputationID[2439]} -- Нераскаявшиеся
					if CharInfo.curCovID == 4 then -- 4Necrolord
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2462), CharInfo.reputationID[2462]} -- Штопальщики
					end
					if CharInfo.curCovID == 3 then -- 3NightFae
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2464), CharInfo.reputationID[2464]} -- Двор Ночи
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2463), CharInfo.reputationID[2463]} -- Чесночник
					end
					if CharInfo.curCovID == 2 then -- 2Venthyr
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2445), CharInfo.reputationID[2445]} -- Пепельный двор
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2449), CharInfo.reputationID[2449]} -- Графиня
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2455), CharInfo.reputationID[2455]} -- Хранитель склепа Каззир
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2457), CharInfo.reputationID[2457]} -- Великий мастер Воул
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2450), CharInfo.reputationID[2450]} -- Александрос Могрейн
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2456), CharInfo.reputationID[2456]} -- Дроман Алиот
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2446), CharInfo.reputationID[2446]} -- Баронесса Вайш
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2469), CharInfo.reputationID[2469]} -- Понимание фракталов
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2460), CharInfo.reputationID[2460]} -- Камнелоб
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2458), CharInfo.reputationID[2458]} -- Клейя и Пелагий
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2447), CharInfo.reputationID[2447]} -- Леди Лунная Ягода
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2454), CharInfo.reputationID[2454]} -- Чуфа
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2459), CharInfo.reputationID[2459]} -- Сика
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2448), CharInfo.reputationID[2448]} -- Миканикос
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2461), CharInfo.reputationID[2461]} -- Изобретатель чумы Марилет
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2451), CharInfo.reputationID[2451]} -- Капитан-егерь Корейн
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2452), CharInfo.reputationID[2452]} -- Полемарх Адрест
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2453), CharInfo.reputationID[2453]} -- Рендл и Дуборыл
					end
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2422), CharInfo.reputationID[2422]} -- Ночной народец
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2479), CharInfo.reputationID[2479]} -- Просветленные (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2442), CharInfo.reputationID[2442]} -- Двор Жнецов (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2471), CharInfo.reputationID[2471]} -- Легион Смерти (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2441), CharInfo.reputationID[2441]} -- Перерожденные (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2444), CharInfo.reputationID[2444]} -- Дикая Охота (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2474), CharInfo.reputationID[2474]} -- Ве'нари (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2473), CharInfo.reputationID[2473]} -- Кодекс архивариуса (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2440), CharInfo.reputationID[2440]} -- Неумирающая армия (Идеал)
				end
				if Octo_ToDoVars.config.ExpansionToShow == 8 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2024073)..Horde_Icon..E.Octo_Func.func_reputationName(2157), CharInfo.reputationID[2157]} -- Армия Чести
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2015853)..Horde_Icon..E.Octo_Func.func_reputationName(2103), CharInfo.reputationID[2103]} -- Империя Зандалари
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2057295)..Horde_Icon..E.Octo_Func.func_reputationName(2158), CharInfo.reputationID[2158]} -- Жители Вол'дуна
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2821776)..Horde_Icon..E.Octo_Func.func_reputationName(2373), CharInfo.reputationID[2373]} -- Освобожденные
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2043330)..Horde_Icon..E.Octo_Func.func_reputationName(2156), CharInfo.reputationID[2156]} -- Экспедиция Таланджи
						-- tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2111), CharInfo.reputationID[2111]} -- Зандаларские динозавры
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2024072)..Alliance_Icon..E.Octo_Func.func_reputationName(2159), CharInfo.reputationID[2159]} -- 7-й легион
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2921024)..Alliance_Icon..E.Octo_Func.func_reputationName(2400), CharInfo.reputationID[2400]} -- Клинки Волн
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2012312)..Alliance_Icon..E.Octo_Func.func_reputationName(2161), CharInfo.reputationID[2161]} -- Орден Пылающих Углей
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2027009)..Alliance_Icon..E.Octo_Func.func_reputationName(2162), CharInfo.reputationID[2162]} -- Орден Возрождения Шторма
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2395), CharInfo.reputationID[2395]} -- Улей Медокрылов
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2160), CharInfo.reputationID[2160]} -- Адмиралтейство Праудмуров
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2120), CharInfo.reputationID[2120]} -- Кул-Тирас - Тирагард
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2264), CharInfo.reputationID[2264]} -- Кул-Тирас - Друствар
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2265), CharInfo.reputationID[2265]} -- Кул-Тирас - долина Штормов
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(3204478)..E.Octo_Func.func_reputationName(2417), CharInfo.reputationID[2417]} -- Ульдумский союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(3204479)..E.Octo_Func.func_reputationName(2415), CharInfo.reputationID[2415]} -- Раджани
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2921023)..E.Octo_Func.func_reputationName(2391), CharInfo.reputationID[2391]} -- Ржавоболтское сопротивление
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2029406)..E.Octo_Func.func_reputationName(2164), CharInfo.reputationID[2164]} -- Защитники Азерот
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2065717)..E.Octo_Func.func_reputationName(2163), CharInfo.reputationID[2163]} -- Тортолланские искатели
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Bodyguards"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2389), CharInfo.reputationID[2389]} -- Нери Остроерш
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2388), CharInfo.reputationID[2388]} -- Поэн Солежабрик
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2390), CharInfo.reputationID[2390]} -- Вим Соленодух
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2375), CharInfo.reputationID[2375]} -- Мастер охоты Акана
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2376), CharInfo.reputationID[2376]} -- Оракул Ори
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2377), CharInfo.reputationID[2377]} -- Мастер клинка Иновари
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Pet".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2427), CharInfo.reputationID[2427]} -- Молодой акир
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2370), CharInfo.reputationID[2370]} -- Обучение динозавров – Дикорог
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2233), CharInfo.reputationID[2233]} -- Dino Training - Pterrodax
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2416), CharInfo.reputationID[2416]} -- Раджани (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2392), CharInfo.reputationID[2392]} -- Ржавоболтское сопротивление (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2385), CharInfo.reputationID[2385]} -- Армия Чести (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2384), CharInfo.reputationID[2384]} -- 7-й легион (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2381), CharInfo.reputationID[2381]} -- Орден Возрождения Шторма (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2379), CharInfo.reputationID[2379]} -- Адмиралтейство Праудмуров (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2378), CharInfo.reputationID[2378]} -- Империя Зандалари (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2382), CharInfo.reputationID[2382]} -- Жители Вол'дуна (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2383), CharInfo.reputationID[2383]} -- Орден Пылающих Углей (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2387), CharInfo.reputationID[2387]} -- Тортолланские искатели (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2386), CharInfo.reputationID[2386]} -- Защитники Азерот (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2380), CharInfo.reputationID[2380]} -- Экспедиция Таланджи (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2418), CharInfo.reputationID[2418]} -- Ульдумский союз (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2374), CharInfo.reputationID[2374]} -- Освобожденные (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2401), CharInfo.reputationID[2401]} -- Анкоа из клана Клинков Волн (идеал)
				end
				if Octo_ToDoVars.config.ExpansionToShow == 7 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1585245)..E.Octo_Func.func_reputationName(2045), CharInfo.reputationID[2045]} -- Армия погибели Легиона
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1608729)..E.Octo_Func.func_reputationName(2165), CharInfo.reputationID[2165]} -- Армия Света
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447608)..E.Octo_Func.func_reputationName(1859), CharInfo.reputationID[1859]} -- Помраченные
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447611)..E.Octo_Func.func_reputationName(1948), CharInfo.reputationID[1948]} -- Валарьяры
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447607)..E.Octo_Func.func_reputationName(1900), CharInfo.reputationID[1900]} -- Двор Фарондиса
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1708511)..E.Octo_Func.func_reputationName(2170), CharInfo.reputationID[2170]} -- Защитники Аргуса
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447612)..E.Octo_Func.func_reputationName(1828), CharInfo.reputationID[1828]} -- Племена Крутогорья
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447613)..E.Octo_Func.func_reputationName(1894), CharInfo.reputationID[1894]} -- Стражи
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447610)..E.Octo_Func.func_reputationName(1883), CharInfo.reputationID[1883]} -- Ткачи Снов
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1975), CharInfo.reputationID[1975]} -- Кудесник Маргосс
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2135), CharInfo.reputationID[2135]} -- Хроми
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2018), CharInfo.reputationID[2018]} -- Отмщение Когтя
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1899), CharInfo.reputationID[1899]} -- Лунные стражи
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2097), CharInfo.reputationID[2097]} -- Илиссия Водная
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2098), CharInfo.reputationID[2098]} -- Хранительница Рейна
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2102), CharInfo.reputationID[2102]} -- Бесс
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2101), CharInfo.reputationID[2101]} -- Ша'лет
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2099), CharInfo.reputationID[2099]} -- Акуле Речной Рог
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2100), CharInfo.reputationID[2100]} -- Корбин
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1984), CharInfo.reputationID[1984]} -- Спасатели
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1862), CharInfo.reputationID[1862]} -- Жажда магии Окулета
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1919), CharInfo.reputationID[1919]} -- Жажда магии Вальтруа
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1860), CharInfo.reputationID[1860]} -- Жажда магии Талисры
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1815), CharInfo.reputationID[1815]} -- Выжившие из Гилнеаса
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1947), CharInfo.reputationID[1947]} -- Иллидари
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1989), CharInfo.reputationID[1989]} -- Лунные стражи
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1888), CharInfo.reputationID[1888]} -- Яндвикские врайкулы
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2089), CharInfo.reputationID[2089]} -- Помраченные (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2086), CharInfo.reputationID[2086]} -- Валарьяры (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2085), CharInfo.reputationID[2085]} -- Племена Крутогорья (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2090), CharInfo.reputationID[2090]} -- Стражи (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2087), CharInfo.reputationID[2087]} -- Двор Фарондиса (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2091), CharInfo.reputationID[2091]} -- Армия погибели Легиона (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2166), CharInfo.reputationID[2166]} -- Армия Света (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2088), CharInfo.reputationID[2088]} -- Ткачи Снов (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1861), CharInfo.reputationID[1861]} -- Arcane Thirst (Silgryn) DEPRECATED
				end
				if Octo_ToDoVars.config.ExpansionToShow == 6 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1052654)..E.Octo_Func.func_reputationName(1711), CharInfo.reputationID[1711]} -- Археологическое общество Хитрой Шестеренки
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1240656)..E.Octo_Func.func_reputationName(1849), CharInfo.reputationID[1849]} -- Орден Пробудившихся
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1042646)..E.Octo_Func.func_reputationName(1515), CharInfo.reputationID[1515]} -- Араккоа-изгои
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1240657)..E.Octo_Func.func_reputationName(1850), CharInfo.reputationID[1850]} -- Охотники за саблеронами
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1044164)..Horde_Icon..E.Octo_Func.func_reputationName(1445), CharInfo.reputationID[1445]} -- Клан Северного Волка
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1043559)..Horde_Icon..E.Octo_Func.func_reputationName(1708), CharInfo.reputationID[1708]} -- Клан Веселого Черепа
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1848), CharInfo.reputationID[1848]} -- Охотники за головами
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1042739)..Alliance_Icon..E.Octo_Func.func_reputationName(1710), CharInfo.reputationID[1710]} -- Защитники Ша'тар
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1048727)..Alliance_Icon..E.Octo_Func.func_reputationName(1731), CharInfo.reputationID[1731]} -- Совет экзархов
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1847), CharInfo.reputationID[1847]} -- Длань Пророка
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Bodyguards"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1735), CharInfo.reputationID[1735]} -- Телохранители из казарм
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1737), CharInfo.reputationID[1737]} -- Жрец Когтя Ишааль
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1741), CharInfo.reputationID[1741]} -- Леорадж
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1736), CharInfo.reputationID[1736]} -- Тормок
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1740), CharInfo.reputationID[1740]} -- Аеда Ясная Заря
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1739), CharInfo.reputationID[1739]} -- Вивианна
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1738), CharInfo.reputationID[1738]} -- Защитница Иллона
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1733), CharInfo.reputationID[1733]} -- Делвар Железный Кулак
					end
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1520), CharInfo.reputationID[1520]} -- Изгнанники клана Призрачной Луны
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1732), CharInfo.reputationID[1732]} -- Дренорcкая Экспедиция Хитрой Шестеренки
				end
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Mists of Pandaria".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(838811)..E.Octo_Func.func_reputationName(1435), CharInfo.reputationID[1435]} -- Натиск Шадо-Пан
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645203)..E.Octo_Func.func_reputationName(1341), CharInfo.reputationID[1341]} -- Небожители
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(643874)..E.Octo_Func.func_reputationName(1302), CharInfo.reputationID[1302]} -- Рыболовы
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(643910)..E.Octo_Func.func_reputationName(1269), CharInfo.reputationID[1269]} -- Золотой Лотос
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645198)..E.Octo_Func.func_reputationName(1272), CharInfo.reputationID[1272]} -- Земледельцы
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645204)..E.Octo_Func.func_reputationName(1270), CharInfo.reputationID[1270]} -- Шадо-Пан
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(646324)..E.Octo_Func.func_reputationName(1271), CharInfo.reputationID[1271]} -- Орден Облачного Змея
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(646377)..E.Octo_Func.func_reputationName(1337), CharInfo.reputationID[1337]} -- Клакси
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(617219)..E.Octo_Func.func_reputationName(1345), CharInfo.reputationID[1345]} -- Хранители истории
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(838819)..Horde_Icon..E.Octo_Func.func_reputationName(1388), CharInfo.reputationID[1388]} -- Войска Похитителей Солнца
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1228), CharInfo.reputationID[1228]} -- Лесные хозены
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1375), CharInfo.reputationID[1375]} -- Армия Покорителей
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(801132)..Alliance_Icon..E.Octo_Func.func_reputationName(1387), CharInfo.reputationID[1387]} -- Армия Кирин-Тора
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1242), CharInfo.reputationID[1242]} -- Цзинь-юй Жемчужного Плавника
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1376), CharInfo.reputationID[1376]} -- Операция "Заслон"
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1492), CharInfo.reputationID[1492]} -- Император Шаохао
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1359), CharInfo.reputationID[1359]} -- Черный принц
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1358), CharInfo.reputationID[1358]} -- Нат Пэгл
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1278), CharInfo.reputationID[1278]} -- Шо
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1277), CharInfo.reputationID[1277]} -- Чи-Чи
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1216), CharInfo.reputationID[1216]} -- Академия Шан Си
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1283), CharInfo.reputationID[1283]} -- Фермер Фун
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1276), CharInfo.reputationID[1276]} -- Старик Горная Лапа
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1273), CharInfo.reputationID[1273]} -- Йогу Пьяный
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1275), CharInfo.reputationID[1275]} -- Элла
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1279), CharInfo.reputationID[1279]} -- Хаохань Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1281), CharInfo.reputationID[1281]} -- Джина Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1282), CharInfo.reputationID[1282]} -- Рыба Тростниковая Шкура
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1280), CharInfo.reputationID[1280]} -- Тина Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1440), CharInfo.reputationID[1440]} -- Восстание Черного Копья
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1351), CharInfo.reputationID[1351]} -- Хмелевары
				end
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Cataclysm".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456567)..E.Octo_Func.func_reputationName(1135), CharInfo.reputationID[1135]} -- Служители Земли
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456570)..E.Octo_Func.func_reputationName(1158), CharInfo.reputationID[1158]} -- Стражи Хиджала
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456574)..E.Octo_Func.func_reputationName(1173), CharInfo.reputationID[1173]} -- Рамкахены
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456572)..E.Octo_Func.func_reputationName(1171), CharInfo.reputationID[1171]} -- Теразан
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456571)..Horde_Icon..E.Octo_Func.func_reputationName(1178), CharInfo.reputationID[1178]} -- Батальон Адского Крика
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456565)..Horde_Icon..E.Octo_Func.func_reputationName(1172), CharInfo.reputationID[1172]} -- Клан Драконьей Пасти
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456575)..Alliance_Icon..E.Octo_Func.func_reputationName(1174), CharInfo.reputationID[1174]} -- Клан Громового Молота
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456564)..Alliance_Icon..E.Octo_Func.func_reputationName(1177), CharInfo.reputationID[1177]} -- Защитники Тол Барада
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1204), CharInfo.reputationID[1204]} -- Хиджальские мстители
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Wrath of the Lich King".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1073), CharInfo.reputationID[1073]} -- Калу'ак
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1098), CharInfo.reputationID[1098]} -- Рыцари Черного Клинка
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1156), CharInfo.reputationID[1156]} -- Пепельный союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1106), CharInfo.reputationID[1106]} -- Серебряный Авангард
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1091), CharInfo.reputationID[1091]} -- Драконий союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1090), CharInfo.reputationID[1090]} -- Кирин-Тор
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1104), CharInfo.reputationID[1104]} -- Племя Бешеного Сердца
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1105), CharInfo.reputationID[1105]} -- Оракулы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1119), CharInfo.reputationID[1119]} -- Сыны Ходира
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1052), CharInfo.reputationID[1052]} -- Экспедиция Орды
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1067), CharInfo.reputationID[1067]} -- Карающая Длань
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1124), CharInfo.reputationID[1124]} -- Похитители Солнца
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1085), CharInfo.reputationID[1085]} -- Армия Песни Войны
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1117), CharInfo.reputationID[1117]} -- Низина Шолазар
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1064), CharInfo.reputationID[1064]} -- Таунка
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1126), CharInfo.reputationID[1126]} -- Зиморожденные
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1094), CharInfo.reputationID[1094]} -- Серебряный Союз
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1050), CharInfo.reputationID[1050]} -- Экспедиция Отважных
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1037), CharInfo.reputationID[1037]} -- Авангард Альянса
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1068), CharInfo.reputationID[1068]} -- Лига исследователей
					end
				end
				if Octo_ToDoVars.config.ExpansionToShow == 2 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."The Burning Crusade".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(936), CharInfo.reputationID[936]} -- Город Шаттрат
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1031), CharInfo.reputationID[1031]} -- Стражи небес Ша'тар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1077), CharInfo.reputationID[1077]} -- Армия Расколотого Солнца
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(935), CharInfo.reputationID[935]} -- Ша'тар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1011), CharInfo.reputationID[1011]} -- Нижний Город
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(934), CharInfo.reputationID[934]} -- Провидцы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(932), CharInfo.reputationID[932]} -- Алдоры
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(947), CharInfo.reputationID[947]} -- Траллмар
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(941), CharInfo.reputationID[941]} -- Маг'хары
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(978), CharInfo.reputationID[978]} -- Куренай
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(946), CharInfo.reputationID[946]} -- Оплот Чести
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(922), CharInfo.reputationID[922]} -- Транквиллион
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(942), CharInfo.reputationID[942]} -- Кенарийская экспедиция
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(970), CharInfo.reputationID[970]} -- Спореггар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(933), CharInfo.reputationID[933]} -- Консорциум
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(989), CharInfo.reputationID[989]} -- Хранители Времени
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1038), CharInfo.reputationID[1038]} -- Огри'ла
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(967), CharInfo.reputationID[967]} -- Аметистовое Око
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1012), CharInfo.reputationID[1012]} -- Пеплоусты-служители
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(990), CharInfo.reputationID[990]} -- Песчаная Чешуя
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1015), CharInfo.reputationID[1015]} -- Крылья Пустоты
				end
				if Octo_ToDoVars.config.ExpansionToShow == 1 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Classic".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.Faction == "Alliance" then
						-- Alliance
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(469), CharInfo.reputationID[469]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(891), CharInfo.reputationID[891]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1353), CharInfo.reputationID[1353]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(72), CharInfo.reputationID[72]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(69), CharInfo.reputationID[69]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(47), CharInfo.reputationID[47]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(54), CharInfo.reputationID[54]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1134), CharInfo.reputationID[1134]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(930), CharInfo.reputationID[930]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(509), CharInfo.reputationID[509]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1682), CharInfo.reputationID[1682]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(890), CharInfo.reputationID[890]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(730), CharInfo.reputationID[730]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1419), CharInfo.reputationID[1419]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1691), CharInfo.reputationID[1691]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2011), CharInfo.reputationID[2011]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2371), CharInfo.reputationID[2371]}
					end
					if CharInfo.Faction == "Horde" then
						-- Horde
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(67), CharInfo.reputationID[67]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(892), CharInfo.reputationID[892]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1352), CharInfo.reputationID[1352]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(911), CharInfo.reputationID[911]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(76), CharInfo.reputationID[76]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(530), CharInfo.reputationID[530]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1133), CharInfo.reputationID[1133]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(81), CharInfo.reputationID[81]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(68), CharInfo.reputationID[68]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(510), CharInfo.reputationID[510]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1681), CharInfo.reputationID[1681]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(889), CharInfo.reputationID[889]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(729), CharInfo.reputationID[729]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1374), CharInfo.reputationID[1374]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1690), CharInfo.reputationID[1690]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2010), CharInfo.reputationID[2010]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2372), CharInfo.reputationID[2372]}
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(349), CharInfo.reputationID[349]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(87), CharInfo.reputationID[87]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(749), CharInfo.reputationID[749]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(529), CharInfo.reputationID[529]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(21), CharInfo.reputationID[21]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(169), CharInfo.reputationID[169]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(70), CharInfo.reputationID[70]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(369), CharInfo.reputationID[369]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(609), CharInfo.reputationID[609]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(576), CharInfo.reputationID[576]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(577), CharInfo.reputationID[577]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(59), CharInfo.reputationID[59]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(470), CharInfo.reputationID[470]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(910), CharInfo.reputationID[910]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(270), CharInfo.reputationID[270]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(809), CharInfo.reputationID[809]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(92), CharInfo.reputationID[92]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(909), CharInfo.reputationID[909]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(93), CharInfo.reputationID[93]}
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(589), CharInfo.reputationID[589]}
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..REPUTATION.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Задания
	if Octo_ToDoVars.config.ShowQuests == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {WorldBoss_Icon..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {Timer_DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {Timer_DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {Timer_DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					-- tooltip[#tooltip+1] = {L["PLAYER_DIFFICULTY_TIMEWALKER"].." (500)", CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count}
					-- tooltip[#tooltip+1] = {L["PLAYER_DIFFICULTY_TIMEWALKER"].." (5 dungeons)", CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.7".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Coalition of Flames"]..")", CharInfo.Octopussy_DF_Once_TheCoalitionofFlames_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {Timer_DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zaralek Cavern"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_ResearchersUnderFire()..L["Researchers Under Fire"], CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {WorldBoss_Icon..E.Octo_Func.func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(5062638)..E.Octo_Func.func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {L["A Worthy Ally: Loamm Niffen"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(4643981)..E.Octo_Func.func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["The Forbidden Reach"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zereth Mortis"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_name, CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBZMAntros_name, CharInfo.Octopussy_SL_Weekly_WBZMAntros_count}
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
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Korthia"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaCollection_name, CharInfo.Octopussy_SL_Daily_KorthiaCollection_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_name, CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaMobs_name, CharInfo.Octopussy_SL_Daily_KorthiaMobs_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_name, CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_RIFTKorthiaStolenAnimaVessel_name, CharInfo.Octopussy_SL_Weekly_RIFTKorthiaStolenAnimaVessel_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaRiftboundCache_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaRiftboundCache_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaSpectralBoundChest_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaSpectralBoundChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaZovaalsVault_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaZovaalsVault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_name, CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaRares_name, CharInfo.Octopussy_SL_Weekly_KorthiaRares_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_name, CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_name, CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Maw"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Class quests"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						local vivod = ""
						if CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count == E.Octo_Globals.DONE then
							if CharInfo.KnownSpell[101508] == true then
								vivod = " ("..E.Octo_Globals.Green_Color..L["ON"].."|r"..")"
							else
								vivod = " ("..E.Octo_Globals.Red_Color..L["OFF"].."|r"..")"
							end
						end
						tooltip[#tooltip+1] = {L["Green Fire"]..vivod, CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..QUESTS_LABEL.." ("..CharInfo.numQuests..")|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- ПРОХОДКИ
	if Octo_ToDoVars.config.ShowSkips == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Globals.Gray_Color..L["ShowSkips"].."|r"
				--ДРЕНОР
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37029]} --NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37030]} --NE NADO
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37031]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39502)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39502]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39504)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39504]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39505)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39505]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39499)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39499]} --NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39500)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39500]} --NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39501)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39501]} --NE NADO
				tooltip[#tooltip+1] = {"", ""}
				--ЛЕГИОН
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44283)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44283]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44284)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44284]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44285)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44285]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45381)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45381]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45382)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45382]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45383)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45383]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47725)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47725]} --NE NADO
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47726)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47726]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47727)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47727]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49133)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49133]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49134)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49134]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49135)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49135]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49032)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49032]} --NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49075)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49075]} --NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49076)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49076]} --NE NADO
				--БФА
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58373)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58373]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58374)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58374]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58375)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58375]}
				--ШЛ
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62054)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62054]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62055)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62055]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62056)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62056]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64597)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64597]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64598)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64598]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64599)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64599]}
				-- ДФ
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71018)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71018]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71019)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71019]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71020)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71020]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76083)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76083]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76085)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76085]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76086)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76086]}
				return vivodCent, vivodLeft
		end)
	end
	-- ПРЕДМЕТЫ
	if Octo_ToDoVars.config.ShowItems == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for k, v in ipairs(E.Octo_Table.OctoTable_itemID_ALL) do
					local count = tonumber(CharInfo.ItemsInBag[v])
					if count ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v), count}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..ITEMS.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Профессии
	if Octo_ToDoVars.config.ShowProfessions == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_DF_Once_CatchingUp_count ~= E.Octo_Globals.DONE then
					tooltip[#tooltip+1] = {E.Octo_Globals.Red_Color.."Нужно сделать квест: |r"..CharInfo.Octopussy_DF_Once_CatchingUp_name.." /way 60, 72", CharInfo.Octopussy_DF_Once_CatchingUp_count}
				end
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(CharInfo.professions[k].icon)..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
						tooltip[#tooltip+1] = {"Сундуки", CharInfo.professions[k].chest.chest_count.."/"..CharInfo.professions[k].chest.questReq}
						tooltip[#tooltip+1] = {"Лут", CharInfo.professions[k].drops.drops_count.."/"..CharInfo.professions[k].drops.questReq}
						tooltip[#tooltip+1] = {"Квест", CharInfo.professions[k].profQuest.profQuest_count.."/"..CharInfo.professions[k].profQuest.questReq}
						tooltip[#tooltip+1] = {"Трактаты", CharInfo.professions[k].treatise.treatise_count.."/"..CharInfo.professions[k].treatise.questReq}
						tooltip[#tooltip+1] = {"Крафт", CharInfo.professions[k].craftOrder.craftOrder_count.."/"..CharInfo.professions[k].craftOrder.questReq}
						tooltip[#tooltip+1] = {" ", " "}
						if CharInfo.professions[k].icon then
							vivodCent = vivodCent..CharInfo.professions[k].icon.." "
						end
					end
				end
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine_Other) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(CharInfo.professions[k].icon)..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
					end
				end
				tooltip[#tooltip+1] = {" ", " "}
				if CharInfo.ItemsInBag[199197] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(199197)..E.Octo_Func.func_itemName(199197), CharInfo.ItemsInBag[199197]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(199197)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(199197).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[199197].."|r"}
				end
				if CharInfo.ItemsInBag[190453] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190453)..E.Octo_Func.func_itemName(190453), CharInfo.ItemsInBag[190453]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190453)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(190453).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[190453].."|r"}
				end
				if CharInfo.ItemsInBag[191784] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(191784)..E.Octo_Func.func_itemName(191784).." /way 52, 33", CharInfo.ItemsInBag[191784]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(191784)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(191784).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[191784].."|r"}
				end
				if CharInfo.ItemsInBag[190456] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190456)..E.Octo_Func.func_itemName(190456), CharInfo.ItemsInBag[190456]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190456)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(190456).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[190456].."|r"}
				end
				tooltip[#tooltip+1] = {" 10.1.0", ""}
				if CharInfo.ItemsInBag[204985] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204985)..E.Octo_Func.func_itemName(204985), CharInfo.ItemsInBag[204985]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204985)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204985).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204985].."|r"}
				end
				if CharInfo.ItemsInBag[204715] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204715)..E.Octo_Func.func_itemName(204715), CharInfo.ItemsInBag[204715]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204715)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204715).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204715].."|r"}
				end
				if CharInfo.ItemsInBag[204681] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204681)..E.Octo_Func.func_itemName(204681), CharInfo.ItemsInBag[204681]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204681)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204681).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204681].."|r"}
				end
				if CharInfo.ItemsInBag[204682] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204682)..E.Octo_Func.func_itemName(204682), CharInfo.ItemsInBag[204682]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204682)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204682).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204682].."|r"}
				end
				if CharInfo.ItemsInBag[204697] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204697)..E.Octo_Func.func_itemName(204697), CharInfo.ItemsInBag[204697]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204697)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204697).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204697].."|r"}
				end
				if CharInfo.ItemsInBag[204717] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204717)..E.Octo_Func.func_itemName(204717), CharInfo.ItemsInBag[204717]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204717)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204717).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204717].."|r"}
				end
				if CharInfo.ItemsInBag[204440] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204440)..E.Octo_Func.func_itemName(204440), CharInfo.ItemsInBag[204440]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204440)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204440).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204440].."|r"}
				end
				tooltip[#tooltip+1] = {" PVP", ""}
				if CharInfo.ItemsInBag[204186] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204186)..E.Octo_Func.func_itemName(204186), CharInfo.ItemsInBag[204186]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204186)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204186).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204186].."|r"}
				end
				if CharInfo.ItemsInBag[204187] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204187)..E.Octo_Func.func_itemName(204187), CharInfo.ItemsInBag[204187]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204187)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204187).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204187].."|r"}
				end
				if CharInfo.ItemsInBag[204188] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204188)..E.Octo_Func.func_itemName(204188), CharInfo.ItemsInBag[204188]}
				else
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204188)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204188).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204188].."|r"}
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Деньги
	if Octo_ToDoVars.config.ShowMoney == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local curServerShort = GetRealmName()
				local text = (curServerShort):gsub("-", " "):gsub("'", " ")
				local a, b = strsplit(" ", text)
				if b then
					curServerShort = E.Octo_Func.WA_Utf8Sub(a, 1)..E.Octo_Func.WA_Utf8Sub(b, 1):upper() else curServerShort = E.Octo_Func.WA_Utf8Sub(a, 3):lower()
				end
				-- CL:SetFontObject(OctoFont10)
				if CharInfo.Money then
					vivodLeft = curServerShort..": "..E.Octo_Globals.Yellow_Color..E.Octo_Func.CompactNumberFormat(TotalMoney/10000).."|r"..Money_Icon
				end
				if CharInfo.Money then
					vivodCent = E.Octo_Func.CompactNumberFormat(CharInfo.Money/10000)..Money_Icon
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Octo_Globals.Red_Color..E.Octo_Func.CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..Money_Icon}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Octo_Globals.Green_Color..E.Octo_Func.CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..Money_Icon}
					end
				end
				return E.Octo_Globals.Yellow_Color..vivodCent.."|r", vivodLeft
		end)
	end
	-- Уровень предметов
	if Octo_ToDoVars.config.ShowItemLevel == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if TotalMoneyAllServer ~= TotalMoney then
					vivodLeft = vivodLeft..L["Total: "]..E.Octo_Globals.Yellow_Color..E.Octo_Func.CompactNumberFormat(TotalMoneyAllServer/10000)..Money_Icon.."|r"
				end
				-- vivodLeft = LFG_LIST_ITEM_LEVEL_INSTR_SHORT
				local pvpcolor = E.Octo_Globals.Red_Color
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					if CharInfo.avgItemLevelEquipped >= 440 then
						pvpcolor = E.Octo_Globals.Green_Color
					elseif CharInfo.avgItemLevelEquipped >= 400 then
						pvpcolor = E.Octo_Globals.Yellow_Color
					end
				end
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					vivodCent = pvpcolor..CharInfo.avgItemLevelEquipped
					if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
						vivodCent = vivodCent.."/"..CharInfo.avgItemLevel.."|r"
					end
					if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
						vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
						tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Дата выхода
	if Octo_ToDoVars.config.ShowLogoutTime == true then
		tinsert(OctoTable_func_otrisovka,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoOther.TokenPrice and Octo_ToDoOther.TokenPrice ~= 0 then
					vivodLeft = Token_Icon..TOKEN_FILTER_LABEL.." "..E.Octo_Globals.Yellow_Color..E.Octo_Func.CompactNumberFormat(Octo_ToDoOther.TokenPrice/10000)..Money_Icon.."|r"
				end
				-- tooltip[#tooltip+1] = {CharInfo.classColorHex.."TEST HEX CLASS COLOR|r", " "}
				if CharInfo.loginDay ~= 0 and CharInfo.loginDay ~= 0 then
					CL:SetFontObject(OctoFont10)
					vivodCent = CharInfo.loginHour.."\n"..CharInfo.loginDay
					if CharInfo.needResetWeekly == true then
						vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
					elseif CharInfo.needResetDaily == true then
						vivodCent = E.Octo_Globals.Red_Color..vivodCent.."|r"
					end
					-- vivodCent = (CharInfo.needResetDaily and E.Octo_Globals.Red_Color or E.Octo_Globals.White_Color)..CharInfo.loginHour.."\n"..CharInfo.loginDay
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Rumble Crossover Event (Account)
	tinsert(OctoTable_func_otrisovka,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			local curGUID = UnitGUID("PLAYER")
			vivodLeft = "Rumble Crossover Event (Account)"
				if Octo_ToDoLevels[curGUID].Octopussy_DF_Once_WarcraftRumble_count ~= E.Octo_Globals.DONE then
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(73182) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2022 56.4 19.2 (Монетка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75039) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2022 56.4 19.2 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74850) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2022 63.1 78.6 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74851) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2022 34.6 63.7 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75036) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2023 81.8 77.9 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(73928) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2023 19.1 81.9 (Монетка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75040) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2023 19.1 81.9 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(73936) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2024 7.4 47.5 (Монетка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75041) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2024 7.4 47.5 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75037) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2024 57.3 37.7 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74852) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2025 57.0 66.8 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74843) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2025 49.2 58.4 (Монетка AND Обёртка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(75038) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2025 49.2 58.4 (Монетка AND Обёртка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."Вальдраккен".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(73180) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2112 45.5 47.1 (Монетка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74849) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #2112 46.1 46.7 (Обёртка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Red_Color.."Оргриммар".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74287) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #1 56.0 12.0 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74845) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #85 54.3 77.5 (Монетка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74848) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #85 54.1 75.4 (Обёртка)".."|r")} -- ХЗ
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."Штормград".."|r", " "}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(73952) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #84 75.1 86.0 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74286) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #84 38.7 46.1 (Обёртка)".."|r")}
					tooltip[#tooltip+1] = {(C_QuestLog.IsQuestFlaggedCompleted(74844) and E.Octo_Globals.DONE or E.Octo_Globals.NONE.."/way #84 31.2 37.4 (Монетка)".."|r")}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #2022 56.4 19.2 (Монетка", (C_QuestLog.IsQuestFlaggedCompleted(73182) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2022 56.4 19.2 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75039) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2022 63.1 78.6 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74850) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2022 34.6 63.7 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74851) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {" ", " "}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #2023 81.8 77.9 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75036) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2023 19.1 81.9 (Монетка)", (C_QuestLog.IsQuestFlaggedCompleted(73928) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2023 19.1 81.9 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75040) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {" ", " "}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #2024 7.4 47.5 (Монетка)", (C_QuestLog.IsQuestFlaggedCompleted(73936) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2024 7.4 47.5 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75041) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2024 57.3 37.7 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75037) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {" ", " "}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #2025 57.0 66.8 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74852) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #2025 49.2 58.4 (Монетка AND Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74843) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {"/way #2025 49.2 58.4 (Монетка AND Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(75038) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."Вальдраккен".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #2112 45.5 47.1 (Монетка)", (C_QuestLog.IsQuestFlaggedCompleted(73180) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {"/way #2112 46.1 46.7 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74849) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {" ", " "}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Red_Color.."Оргриммар".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #1 56.0 12.0 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74287) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #85 54.3 77.5 (Монетка)", (C_QuestLog.IsQuestFlaggedCompleted(74845) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {"/way #85 54.1 75.4 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74848) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)} -- ХЗ
					-- tooltip[#tooltip+1] = {" ", " "}
					-- tooltip[#tooltip+1] = {"    "..E.Octo_Globals.Blue_Color.."Штормград".."|r", " "}
					-- tooltip[#tooltip+1] = {"/way #84 75.1 86.0 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(73952) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #84 38.7 46.1 (Обёртка)", (C_QuestLog.IsQuestFlaggedCompleted(74286) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
					-- tooltip[#tooltip+1] = {"/way #84 31.2 37.4 (Монетка)", (C_QuestLog.IsQuestFlaggedCompleted(74844) and E.Octo_Globals.DONE or E.Octo_Globals.NONE)}
				else
					vivodCent = E.Octo_Globals.DONE
				end
			return vivodCent, vivodLeft
	end)
end
local function func_OctoFrame_TEST_Button()
	for k, CharInfo in pairs(Octo_ToDoLevels) do
		local curGUID = UnitGUID("PLAYER")
		if k == curGUID then
			if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.DONE then
				if CharInfo.OctoTable_QuestID[76531] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2022, 58.26/100, 67.58/100) end
				if CharInfo.OctoTable_QuestID[77095] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2022, 76.35/100, 35.43/100) end
				if CharInfo.OctoTable_QuestID[77744] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2022, 47.67/100, 83.27/100) end
				if CharInfo.OctoTable_QuestID[77152] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2023, 59.77/100, 38.73/100) end
				if CharInfo.OctoTable_QuestID[77099] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2023, 28.61/100, 60.45/100) end
				if CharInfo.OctoTable_QuestID[77745] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2023, 85.81/100, 35.34/100) end
				if CharInfo.OctoTable_QuestID[77746] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2024, 62.79/100, 57.74/100) end
				if CharInfo.OctoTable_QuestID[77096] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2024, 46.92/100, 40.23/100) end
				if CharInfo.OctoTable_QuestID[77097] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2024, 12.39/100, 49.33/100) end
				if CharInfo.OctoTable_QuestID[77747] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2025, 50.10/100, 42.71/100) end
				if CharInfo.OctoTable_QuestID[77155] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2025, 50.10/100, 42.71/100) end
				if CharInfo.OctoTable_QuestID[77155] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2025, 52.20/100, 81.50/100) end
				if CharInfo.OctoTable_QuestID[77153] ~= E.Octo_Globals.DONE then TomTom:AddWaypoint(2112, 47.87/100, 47.74/100) end
			else
				print (E.Octo_Func.func_Gradient("ALL DONE", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
			end
		end
	end
end
function Octo_ToDoCreateAltFrame()
	if not OctoFrame_Main_Frame then
		OctoFrame_Main_Frame = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID().."OctoFrame_Main_FrameПИЗДА", UIParent, "BackdropTemplate")
		OctoFrame_Main_Frame:Hide()
	end
	OctoFrame_Main_Frame:SetClampedToScreen(false)
	OctoFrame_Main_Frame:SetFrameStrata("HIGH")
	OctoFrame_Main_Frame:SetPoint("TOP", 0, -257*E.Octo_Globals.scale)
	OctoFrame_Main_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	OctoFrame_Main_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	OctoFrame_Main_Frame:SetBackdropBorderColor(0, 0, 0, 1) -- бордер
	OctoFrame_Main_Frame:SetScript("OnShow", function()
		Octo_ToDoAddDataToAltFrame()
	end)
	OctoFrame_Main_Frame:EnableMouse(true)
	OctoFrame_Main_Frame:SetMovable(true)
	OctoFrame_Main_Frame:RegisterForDrag("LeftButton")
	OctoFrame_Main_Frame:SetScript("OnDragStart", OctoFrame_Main_Frame.StartMoving)
	OctoFrame_Main_Frame:SetScript("OnDragStop", function() OctoFrame_Main_Frame:StopMovingOrSizing() end)
	OctoFrame_Main_Frame:RegisterForClicks("RightButtonUp")
	OctoFrame_Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	OctoFrame_Close_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
	OctoFrame_Close_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	OctoFrame_Close_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, 0)
	OctoFrame_Close_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	OctoFrame_Close_Button:SetBackdropBorderColor(1, 0, 0, 0)
	OctoFrame_Close_Button:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1, 0, 0, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(CLOSE)
			GameTooltip:Show()
	end)
	OctoFrame_Close_Button:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoFrame_Close_Button:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, .5)
			self.icon:SetVertexColor(1, 0, 0, .5)
	end)
	OctoFrame_Close_Button:SetScript("OnClick", function()
			OctoFrame_Main_Frame:Hide()
	end)
	local t = OctoFrame_Close_Button:CreateTexture(nil, "BACKGROUND")
	OctoFrame_Close_Button.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
	----t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(OctoFrame_Close_Button)
	OctoFrame_Close_Button:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:GetParent():Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	if not OctoFrame_Options_Button then
		OctoFrame_Options_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_Options_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_Options_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -30)
		OctoFrame_Options_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_Options_Button:SetBackdropBorderColor(1, 0, 0, 0)
		OctoFrame_Options_Button:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:AddLine(OPTIONS)
				GameTooltip:Show()
		end)
		OctoFrame_Options_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:Hide()
		end)
		OctoFrame_Options_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_Options_Button:SetScript("OnClick", function()
				if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then
					OctoFrame_Main_Frame:Hide()
				end
				if SettingsPanel:IsVisible() and self:IsVisible() then
					HideUIPanel(SettingsPanel)
				else
					Settings.OpenToCategory(AddonTitle, true)
				end
		end)
		local t = OctoFrame_Options_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_Options_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture.tga")
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_Options_Button)
	end
	if not OctoFrame_MarkOfHonor_Button then
		OctoFrame_MarkOfHonor_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_MarkOfHonor_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_MarkOfHonor_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -60)
		OctoFrame_MarkOfHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_MarkOfHonor_Button:SetBackdropBorderColor(0, .44, .98, 1)
		OctoFrame_MarkOfHonor_Button:SetScript("OnEnter", function(self)
				local i = 0
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(" ", " ")
				for k, CharInfo in pairs(Octo_ToDoLevels) do
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					if (CharInfo.ItemsInBag[137642] ~= 0) then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(1322720)..CharInfo.ItemsInBag[137642], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[202196] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(4909720)..CharInfo.ItemsInBag[202196], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[86547] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(237230)..CharInfo.ItemsInBag[86547], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[183616] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(133291)..CharInfo.ItemsInBag[183616], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[166751] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(967526)..CharInfo.ItemsInBag[166751], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[122457] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(667491)..CharInfo.ItemsInBag[122457], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[190189] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(519378)..CharInfo.ItemsInBag[190189], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[204464] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(5009042)..CharInfo.ItemsInBag[204464], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[201325] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(4644002)..CharInfo.ItemsInBag[201325], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[12811] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(134122)..CharInfo.ItemsInBag[12811], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
					if CharInfo.ItemsInBag[200652] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_itemTexture(200652)..CharInfo.ItemsInBag[200652], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
				end
				if i == 0 then
					GameTooltip:AddLine("No Data")
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoFrame_MarkOfHonor_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(0, .44, .98, 1)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_MarkOfHonor_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_MarkOfHonor_Button:SetScript("OnClick", function()
				OctoFrame_Main_Frame:Hide()
		end)
		local t = OctoFrame_MarkOfHonor_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_MarkOfHonor_Button.icon = t
		t:SetTexture(133784)
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_MarkOfHonor_Button)
	end
	----------------------------------------------------------------
	if not OctoFrame_QuestFeast_Button then
		OctoFrame_QuestFeast_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_QuestFeast_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_QuestFeast_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -90)
		OctoFrame_QuestFeast_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_QuestFeast_Button:SetBackdropBorderColor(.64, .21, .93, 1)
		OctoFrame_QuestFeast_Button:SetScript("OnEnter", function(self)
				local i = 0
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(" ", " ")
				for k, CharInfo in pairs(Octo_ToDoLevels) do
					local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
					if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.Octo_Globals.DONE and CharInfo.UnitLevel >= 60 then
						i = i +1
						GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"), CharInfo.Octopussy_DF_Weekly_CommunityFeast_count)
					end
					if CharInfo.ItemsInBag[200652] ~= 0 then
						i = i + 1
						GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_itemTexture(200652)..CharInfo.ItemsInBag[200652], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
					end
				end
				if i == 0 then
					GameTooltip:AddLine(E.Octo_Globals.Green_Color.."All done|r")
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoFrame_QuestFeast_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(0, .44, .98, 1)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_QuestFeast_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_QuestFeast_Button:SetScript("OnClick", function()
				OctoFrame_Main_Frame:Hide()
		end)
		local t = OctoFrame_QuestFeast_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_QuestFeast_Button.icon = t
		t:SetTexture(629056)
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_QuestFeast_Button)
	end
	----------------------------------------------------------------
	if not OctoFrame_Events_Button then
		OctoFrame_Events_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_Events_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_Events_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -120)
		OctoFrame_Events_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_Events_Button:SetBackdropBorderColor(0, 0, 0, 1)
		OctoFrame_Events_Button:SetScript("OnEnter", function(self)
				local countLines = 0
				self:SetBackdropBorderColor(0, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(" ", " ")
				-- local currentDay = date("%d.%m.%Y")
				local classFilename = UnitClassBase("PLAYER")
				local rPerc, gPerc, bPerc = GetClassColor(classFilename)
				local classcolor = CreateColor(rPerc, gPerc, bPerc)
				GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(L["Current Date"]), classcolor:WrapTextInColorCode(date("%d/%m/%Y")))
				GameTooltip:AddDoubleLine(" ", " ")
				for eventID, v in pairs(Octo_ToDo_SmartCollectNEW.Holiday.Active) do
					GameTooltip:AddDoubleLine(E.Octo_Globals.Yellow_Color..Octo_ToDo_SmartCollectNEW.Holiday.Active[eventID].title.."|r"..E.Octo_Globals.Gray_Color.." (id: "..Octo_ToDo_SmartCollectNEW.Holiday.Active[eventID].id..")|r", Octo_ToDo_SmartCollectNEW.Holiday.Active[eventID].startTime.." - "..Octo_ToDo_SmartCollectNEW.Holiday.Active[eventID].endTime)
				end
				if i == 0 then
					GameTooltip:AddLine("No Data")
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoFrame_Events_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(0, 0, 0, 1)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_Events_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_Events_Button:SetScript("OnClick", function()
				OctoFrame_Main_Frame:Hide()
		end)
		local t = OctoFrame_Events_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_Events_Button.icon = t
		t:SetTexture(237579) -- 298591)
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_Events_Button)
	end
	----------------------------------------------------------------
	if not OctoFrame_consumables_Button then
		OctoFrame_consumables_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_consumables_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_consumables_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -150)
		OctoFrame_consumables_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_consumables_Button:SetBackdropBorderColor(0, .44, .98, 1)
		OctoFrame_consumables_Button:SetScript("OnEnter", function(self)
				local i = 0
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(L["Consumables"], " ")
				GameTooltip:AddDoubleLine((Octo_ToDoVars.config.ShowOnlyCurrentRealm and E.Octo_Globals.Green_Color or E.Octo_Globals.Red_Color)..L["Only Current Realm"], " ")
				GameTooltip:AddDoubleLine(" ", " ")
				----------------
				for v, q in pairs(Octo_ToDo_SmartCollectNEW.Items.Consumables) do
					for k, CharInfo in pairs(Octo_ToDoLevels) do
						local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
						if curServer == CharInfo.curServer and Octo_ToDoVars.config.ShowOnlyCurrentRealm == true then
							if (CharInfo.ItemsInBag[v] ~= 0) then
								i = i + 1
								if v ~= nil then
									GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name))
								end
							end
						elseif Octo_ToDoVars.config.ShowOnlyCurrentRealm == false then
							if (CharInfo.ItemsInBag[v] ~= 0) then
								i = i + 1
								GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
							end
						end
					end
				end
				----------------
				if i == 0 then
					GameTooltip:AddLine("No Data")
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoFrame_consumables_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(0, .44, .98, 1)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_consumables_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_consumables_Button:SetScript("OnClick", function()
				OctoFrame_Main_Frame:Hide()
		end)
		local t = OctoFrame_consumables_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_consumables_Button.icon = t
		t:SetTexture(967534)
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_consumables_Button)
	end
	----------------------------------------------------------------
	-- if not OctoFrame_Phylacterweave_Button then
	-- 	OctoFrame_Phylacterweave_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
	-- 	OctoFrame_Phylacterweave_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	-- 	OctoFrame_Phylacterweave_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -150)
	-- 	OctoFrame_Phylacterweave_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- 	OctoFrame_Phylacterweave_Button:SetBackdropBorderColor(0, .44, .98, 1)
	-- 	OctoFrame_Phylacterweave_Button:SetScript("OnEnter", function(self)
	-- 			local i = 0
	-- 			self:SetBackdropBorderColor(1, 0, 0, 1)
	-- 			self.icon:SetVertexColor(1, 0, 0, 1)
	-- 			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			for k, CharInfo in pairs(Octo_ToDoLevels) do
	-- 				local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
	-- 				for _, v in pairs(E.Octo_Table.T3Items) do
	-- 					if (CharInfo.ItemsInBag[v] ~= 0) then
	-- 						i = i + 1
	-- 						GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
	-- 					end
	-- 				end
	-- 			end
	-- 			if i == 0 then
	-- 				GameTooltip:AddLine("No Data")
	-- 			end
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			GameTooltip:Show()
	-- 	end)
	-- 	OctoFrame_Phylacterweave_Button:SetScript("OnLeave", function(self)
	-- 			self:SetBackdropBorderColor(0, .44, .98, 1)
	-- 			self.icon:SetVertexColor(1, 1, 1, 1)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:Hide()
	-- 	end)
	-- 	OctoFrame_Phylacterweave_Button:SetScript("OnMouseDown", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, .5)
	-- 			self.icon:SetVertexColor(1, 0, 0, .5)
	-- 	end)
	-- 	OctoFrame_Phylacterweave_Button:SetScript("OnClick", function()
	-- 			OctoFrame_Main_Frame:Hide()
	-- 	end)
	-- 	local t = OctoFrame_Phylacterweave_Button:CreateTexture(nil, "BACKGROUND")
	-- 	OctoFrame_Phylacterweave_Button.icon = t
	-- 	t:SetTexture(135331)
	-- 	----t:SetVertexColor(1, 1, 1, 1)
	-- 	t:SetAllPoints(OctoFrame_Phylacterweave_Button)
	-- end
	----------------------------------------------------------------
	-- if not OctoFrame_Dreamsurges_Button then
	-- 	OctoFrame_Dreamsurges_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
	-- 	OctoFrame_Dreamsurges_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	-- 	OctoFrame_Dreamsurges_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -180)
	-- 	OctoFrame_Dreamsurges_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- 	OctoFrame_Dreamsurges_Button:SetBackdropBorderColor(0, .44, .98, 1)
	-- 	OctoFrame_Dreamsurges_Button:SetScript("OnEnter", function(self)
	-- 			local i = 0
	-- 			self:SetBackdropBorderColor(1, 0, 0, 1)
	-- 			self.icon:SetVertexColor(1, 0, 0, 1)
	-- 			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			for k, CharInfo in pairs(Octo_ToDoLevels) do
	-- 				local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
	-- 				for _, v in ipairs(E.Octo_Table.Dreamsurges_Items) do
	-- 					if (CharInfo.ItemsInBag[v] ~= 0) then
	-- 						i = i + 1
	-- 						GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
	-- 					end
	-- 				end
	-- 			end
	-- 			if i == 0 then
	-- 				GameTooltip:AddLine("No Data")
	-- 			end
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			GameTooltip:Show()
	-- 	end)
	-- 	OctoFrame_Dreamsurges_Button:SetScript("OnLeave", function(self)
	-- 			self:SetBackdropBorderColor(0, .44, .98, 1)
	-- 			self.icon:SetVertexColor(1, 1, 1, 1)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:Hide()
	-- 	end)
	-- 	OctoFrame_Dreamsurges_Button:SetScript("OnMouseDown", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, .5)
	-- 			self.icon:SetVertexColor(1, 0, 0, .5)
	-- 	end)
	-- 	OctoFrame_Dreamsurges_Button:SetScript("OnClick", function()
	-- 			OctoFrame_Main_Frame:Hide()
	-- 	end)
	-- 	local t = OctoFrame_Dreamsurges_Button:CreateTexture(nil, "BACKGROUND")
	-- 	OctoFrame_Dreamsurges_Button.icon = t
	-- 	t:SetTexture(134206)
	-- 	----t:SetVertexColor(1, 1, 1, 1)
	-- 	t:SetAllPoints(OctoFrame_Dreamsurges_Button)
	-- end
	----------------------------------------------------------------
	-- if not OctoFrame_WeeklyRewardsFrame_Button then
	-- 	OctoFrame_WeeklyRewardsFrame_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPRIGHT", 1, -210)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetBackdropBorderColor(0, .44, .98, 1)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetScript("OnEnter", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, 1)
	-- 			self.icon:SetVertexColor(1, 0, 0, 1)
	-- 			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			GameTooltip:AddDoubleLine(GREAT_VAULT_REWARDS)
	-- 			GameTooltip:AddDoubleLine(" ", " ")
	-- 			GameTooltip:Show()
	-- 	end)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetScript("OnLeave", function(self)
	-- 			self:SetBackdropBorderColor(0, .44, .98, 1)
	-- 			self.icon:SetVertexColor(1, 1, 1, 1)
	-- 			GameTooltip:ClearLines()
	-- 			GameTooltip:Hide()
	-- 	end)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetScript("OnMouseDown", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, .5)
	-- 			self.icon:SetVertexColor(1, 0, 0, .5)
	-- 	end)
	-- 	OctoFrame_WeeklyRewardsFrame_Button:SetScript("OnClick", function()
	-- 			OctoFrame_Main_Frame:Hide()
	-- 			if not WeeklyRewardsFrame then
	-- 				WeeklyRewards_LoadUI()
	-- 			end
	-- 			if not WeeklyRewardsFrame:IsVisible() then
	-- 				ShowUIPanel(WeeklyRewardsFrame, true)
	-- 				WeeklyRewardsFrame:SetScale(0.9)
	-- 			end
	-- 	end)
	-- 	local t = OctoFrame_WeeklyRewardsFrame_Button:CreateTexture(nil, "BACKGROUND")
	-- 	OctoFrame_WeeklyRewardsFrame_Button.icon = t
	-- 	for k, CharInfo in pairs(Octo_ToDoLevels) do
	-- 		local curGUID = UnitGUID("PLAYER")
	-- 		if k == curGUID then
	-- 			for i = 1, 3 do
	-- 				if CharInfo.GreatVault[i].hyperlink[i] ~= 0 then
	-- 					t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\WeeklyRewardsFrame_ON.tga")
	-- 				else
	-- 					t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\WeeklyRewardsFrame_OFF.tga")
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- 	----t:SetVertexColor(1, 1, 1, 1)
	-- 	t:SetAllPoints(OctoFrame_WeeklyRewardsFrame_Button)
	-- end
	----------------------------------------------------------------
	if not OctoFrame_TEST_Button then
		OctoFrame_TEST_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_TEST_Button:Hide()
		OctoFrame_TEST_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_TEST_Button:SetPoint("BOTTOMLEFT", OctoFrame_Main_Frame, "BOTTOMRIGHT", 1, 30)
		OctoFrame_TEST_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_TEST_Button:SetBackdropBorderColor(1, 0, 0, 0)
		OctoFrame_TEST_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_TEST_Button:SetScript("OnMouseDown", function(self)
				TomTom.waydb:ResetProfile()
				TomTom:ReloadWaypoints()
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_TEST_Button:SetScript("OnMouseDown", function(self)
				func_OctoFrame_TEST_Button()
		end)
	end
	local t = OctoFrame_TEST_Button:CreateTexture(nil, "BACKGROUND")
	OctoFrame_TEST_Button.icon = t
	-- t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture.tga")
	t:SetTexture(236701)
	if select(4, GetAddOnInfo("TomTom")) == true then
		t:SetTexture("Interface\\AddOns\\TomTom\\Images\\StaticArrow.tga")
	end
	t:SetAllPoints(OctoFrame_TEST_Button)
	for eventID, v in pairs(Octo_ToDo_SmartCollectNEW.Holiday.Active) do
		if eventID == 372 then -- BREWFEST
			OctoFrame_TEST_Button:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
					GameTooltip:ClearLines()
					GameTooltip:AddLine("TomTom: "..E.Octo_Func.func_questName(77155))
					GameTooltip:Show()
			end)
		end
	end
	if E.Octo_Globals.isTomTom == true then
			OctoFrame_TEST_Button:Show()
	end
	----------------------------------------------------------------
	if not OctoFrame_AbandonAllQuests_Button then
		local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
		StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
			text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Отменить все ("..numQuests..") задания?",
			button1 = YES,
			button2 = NO,
			hideOnEscape = 1,
			whileDead = 1,
			OnAccept = function()
				C_Timer.After(1, function()
						for i = 1, numShownEntries do
							if numQuests ~= 0 then
								local questInfo = C_QuestLog.GetInfo(i)
								if questInfo then
									if (not questInfo.isHeader and not questInfo.isHidden) then
										print (E.Octo_Func.func_Gradient(L["Abandon"], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..questInfo.title)
										C_QuestLog.SetSelectedQuest(questInfo.questID)
										C_QuestLog.SetAbandonQuest()
										C_QuestLog.AbandonQuest()
									end
								end
							end
						end
						print (E.Octo_Globals.DONE)
				end)
			end,
		}
		OctoFrame_AbandonAllQuests_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoFrame_Main_Frame, "BackDropTemplate")
		OctoFrame_AbandonAllQuests_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoFrame_AbandonAllQuests_Button:SetPoint("BOTTOMLEFT", OctoFrame_Main_Frame, "BOTTOMRIGHT", 1, 0)
		OctoFrame_AbandonAllQuests_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		OctoFrame_AbandonAllQuests_Button:SetBackdropBorderColor(1, 0, 0, 0)
		OctoFrame_AbandonAllQuests_Button:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(L["Abandon All Quests"].." ("..numQuests..")")
				GameTooltip:Show()
		end)
		OctoFrame_AbandonAllQuests_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoFrame_AbandonAllQuests_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoFrame_AbandonAllQuests_Button:SetScript("OnClick", function()
				StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
		end)
		local t = OctoFrame_AbandonAllQuests_Button:CreateTexture(nil, "BACKGROUND")
		OctoFrame_AbandonAllQuests_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\SadKitty.tga")
		-- t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(OctoFrame_AbandonAllQuests_Button)
	end
	----------------------------
	if Octo_ToDoVars.config.Portals == true then
		local Xpos = 0
		local Ypos = -21
		local prof1, prof2 = GetProfessions()
		local prof1 = prof1 and select(7, GetProfessionInfo(prof1))
		local prof2 = prof2 and select(7, GetProfessionInfo(prof2))
		local className, classFilename, classId = UnitClass("PLAYER")
		local Faction = UnitFactionGroup("PLAYER")
		if prof1 == 202 or prof2 == 202 then
		-- (itemID, Texture, count, Xpos, Ypos, r, g, b, spellID)
			CreateFrameUsableItems(198156, 4548860, 1, Xpos*0, Ypos*0, 0, .43, .86, 366254) -- Генератор червоточин: Драконьи острова
			CreateFrameUsableItems(172924, 3610528, 1, Xpos*1, Ypos*1, 0, .43, .86, 310542) -- Генератор червоточин: Темные Земли
			if Faction == "Horde" then
				CreateFrameUsableItems(168808, 2000840, 1, Xpos*2, Ypos*2, 0, .43, .86, 265807) -- Генератор червоточин: Зандалар
				CreateFrameUsableItems(168807, 2000841, 1, Xpos*3, Ypos*3, 0, .43, .86, 265807) -- Генератор червоточин: Кул-Тирас
			else
				CreateFrameUsableItems(168808, 2000840, 1, Xpos*2, Ypos*2, 0, .43, .86, 264492) -- Генератор червоточин: Зандалар
				CreateFrameUsableItems(168807, 2000841, 1, Xpos*3, Ypos*3, 0, .43, .86, 264492) -- Генератор червоточин: Кул-Тирас
			end
			CreateFrameUsableItems(151652, 237560, 1, Xpos*4, Ypos*4, 0, .43, .86, 264490) -- Генератор червоточин: Аргус
			CreateFrameUsableItems(112059, 892831, 1, Xpos*5, Ypos*5, 0, .43, .86, 264487) -- Центрифуга червоточины
			CreateFrameUsableItems(87215, 651094, 1, Xpos*6, Ypos*6, 0, .43, .86, 264485) -- Генератор червоточин: Пандария
			CreateFrameUsableItems(48933, 135778, 1, Xpos*7, Ypos*7, 0, .43, .86, 264481) -- Генератор червоточин: Нордскол
			--ЕСТЬ ИНЖА
			CreateFrameUsableItems(110560, 1041860, 1, Xpos*8, Ypos*8, 0, .43, .86, 6603) -- Камень возвращения в гарнизон
			CreateFrameUsableItems(6948, 134414, 1, Xpos*9, Ypos*9, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			CreateFrameUsableItems(140192, 1444943, 1, Xpos*10, Ypos*10, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, select(3,GetSpellInfo(193753)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Сноходец
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, select(3,GetSpellInfo(50977)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Врата смерти
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, select(3,GetSpellInfo(556)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Астральное возвращение
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, select(3,GetSpellInfo(126892)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Духовное путешествие
			end
		else
			-- НЕТ ИНЖИ
			CreateFrameUsableItems(110560, 1041860, 1, Xpos*0, Ypos*0, 0, .43, .86, 6603) -- Камень возвращения в гарнизон
			CreateFrameUsableItems(6948, 134414, 1, Xpos*1, Ypos*1, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			CreateFrameUsableItems(140192, 1444943, 1, Xpos*2, Ypos*2, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, select(3,GetSpellInfo(193753)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Сноходец
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, select(3,GetSpellInfo(50977)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Врата смерти
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, select(3,GetSpellInfo(556)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Астральное возвращение
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, select(3,GetSpellInfo(126892)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Духовное путешествие
			end
		end
		-- (spellID, Texture, Xpos, Ypos, r, g, b)
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_MoP) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
		end
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_WoD) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*3, (Ypos*k), 0, .43, .86)
		end
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_Legion) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*4, (Ypos*k), 0, .43, .86)
		end
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_BfA) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*5, (Ypos*k), 0, .43, .86)
		end
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_SL) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*6, (Ypos*k), 0, .43, .86)
		end
		for k, v in pairs(E.Octo_Table.OctoTable_Portals_DF) do
			CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*7, (Ypos*k), 0, .43, .86)
		end
		if classFilename == "MAGE" and Faction == "Horde" then
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde) do
				CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Horde) do
				CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
			end
		end
		if classFilename == "MAGE" and Faction == "Alliance" then
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance) do
				CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance) do
				CreateFrameUsableSpells(v, select(3,GetSpellInfo(v)), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
			end
		end
	end
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, 0.2)
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 1, #OctoTable_func_otrisovka do -- БЭКГРАУНД
		local fname, f
		fname = "FrameLine"..i
		OctoFrame_Main_Frame[fname] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."FrameLine"..i, OctoFrame_Main_Frame, "BackdropTemplate")
		f = OctoFrame_Main_Frame[fname]
		f:SetHeight(E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPLEFT", 0, -E.Octo_Globals.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.Octo_Globals.curHeight)
		f.BG:SetAllPoints()
		fname = "TextLeft"..i
		OctoFrame_Main_Frame[fname] = OctoFrame_Main_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = OctoFrame_Main_Frame[fname]
		f:SetSize(E.Octo_Globals.curWidthTitle, E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", OctoFrame_Main_Frame, "TOPLEFT", 6, -E.Octo_Globals.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDoAddDataToAltFrame()
	OctoFrame_Main_Frame:Hide()
end
function Octo_ToDoAddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDoVars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDoVars.config.LevelToShow
	local itemLevelToShow = Octo_ToDoVars.config.itemLevelToShow
	OctoFrame_Main_Frame.AllCharFrames = {}
	local sorted = {}
	TotalMoney = 0
	TotalMoneyAllServer = 0
	TotalKills = 0
	TotalTransAnima = 0
	TotalTransParacausalFlakes = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
		sorted[#sorted+1] = CharInfo
		TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then
			TotalMoney = TotalMoney + CharInfo.Money
		end
		if CharInfo.Shadowland[2] >= 1000 or CharInfo.Shadowland[4] >= 1000 or CharInfo.Shadowland[6] >= 1000 or CharInfo.Shadowland[8] >= 1000 then
			TotalTransAnima = TotalTransAnima +
			math.floor(CharInfo.Shadowland[2]/1000)*1000 +
			math.floor(CharInfo.Shadowland[4]/1000)*1000 +
			math.floor(CharInfo.Shadowland[6]/1000)*1000 +
			math.floor(CharInfo.Shadowland[8]/1000)*1000
		end
		if CharInfo.CurrencyID[2594] >= 500 then
			TotalTransParacausalFlakes = TotalTransParacausalFlakes + math.floor(CharInfo.CurrencyID[2594]/500)*500
		end
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.curServer < b.curServer or a.curServer == b.curServer
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				b.Name < a.Name
			end
	end)
	for i, CharInfo in pairs(sorted) do
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= LevelToShow)) or (ShowOnlyCurrentRealm == false and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= LevelToShow)) or (curGUID == CharInfo.GUID) then
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			local curCharGUID = CharInfo.GUID
			if not OctoFrame_Main_Frame[curCharGUID] then
				OctoFrame_Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."OctoFrame_Main_Frame[curCharGUID]", OctoFrame_Main_Frame, "BackdropTemplate")
				OctoFrame_Char_Frame = OctoFrame_Main_Frame[curCharGUID]
				OctoFrame_Char_Frame:SetPoint("BOTTOM", 0, 0)
				OctoFrame_Char_Frame.BG = OctoFrame_Char_Frame:CreateTexture(nil, "BACKGROUND")
				OctoFrame_Char_Frame.BG:Hide()
				OctoFrame_Char_Frame.BG:SetPoint("TOPLEFT", 0, -E.Octo_Globals.curHeight) -- ФОН ЗАЛОГИНЕНОГО ПЕРСОНАЖА (рога - желтый)
				OctoFrame_Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
				OctoFrame_Char_Frame.BG:SetColorTexture(r, g, b, 1)
				for i = 1, #OctoTable_func_otrisovka do
					CharInfo.GUID = curCharGUID
					CF = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, OctoFrame_Char_Frame)
					OctoFrame_Char_Frame["CenterLines"..i] = CF
					CF.index = i
					CF:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
					CF:SetPoint("TOP", OctoFrame_Char_Frame, "TOP", 0, -E.Octo_Globals.curHeight*(i-1))
					CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
					CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
					CF:SetMouseClickEnabled(false)
					local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					CL:SetAllPoints()
					CL:SetFontObject(OctoFont11)
					CL:SetJustifyV("MIDDLE")
					CL:SetJustifyH("CENTER")
					CL:SetTextColor(1, 1, 1, 1)
					OctoFrame_Char_Frame["CenterLines"..i.."BG"] = OctoFrame_Char_Frame:CreateTexture(nil, "BACKGROUND")
					OctoFrame_Char_Frame["CenterLines"..i.."BG"]:SetAllPoints(OctoFrame_Char_Frame["CenterLines"..i])
					OctoFrame_Char_Frame["CenterLines"..i.."BG"]:SetColorTexture(r, g, b, 0)
					CF.CL = CL
					-- OctoFrame_Char_Frame.CharName = OctoFrame_Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
					OctoFrame_Char_Frame.curServer = OctoFrame_Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
					-- OctoFrame_Char_Frame.CharNameBG = OctoFrame_Char_Frame:CreateTexture(nil, "BACKGROUND")
					-- OctoFrame_Char_Frame.CharNameBG:SetAllPoints(OctoFrame_Char_Frame.CharName)
					OctoFrame_Char_Frame.UnitLevel = OctoFrame_Char_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
					OctoFrame_Char_Frame.UnitLevel:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight/2)
					OctoFrame_Char_Frame.UnitLevel:SetJustifyV("CENTER")
					OctoFrame_Char_Frame.UnitLevel:SetWordWrap(true)
					OctoFrame_Char_Frame.UnitLevel:SetFontObject(OctoFont11)
					OctoFrame_Char_Frame.UnitLevel:SetPoint("BOTTOM", OctoFrame_Char_Frame, "TOP", 0, 0)
					OctoFrame_Char_Frame.UnitLevelBG = OctoFrame_Char_Frame:CreateTexture(nil, "BACKGROUND")
					OctoFrame_Char_Frame.UnitLevelBG:Hide()
					OctoFrame_Char_Frame.UnitLevelBG:SetAllPoints(OctoFrame_Char_Frame.UnitLevel)
					OctoFrame_Char_Frame.UnitLevelBG:SetColorTexture(bgCr, bgCg, bgCb, bgCa)
					OctoFrame_Char_Frame.experience = OctoFrame_Char_Frame:CreateTexture(nil, "ARTWORK")
					OctoFrame_Char_Frame.experience:Hide()
					OctoFrame_Char_Frame.experience:SetHeight(E.Octo_Globals.curHeight/2)
					OctoFrame_Char_Frame.experience:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\O_03.tga")
				end
			else
				OctoFrame_Char_Frame = OctoFrame_Main_Frame[curCharGUID]
			end
			OctoFrame_Char_Frame:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
			if #OctoFrame_Main_Frame.AllCharFrames == 0 then
				OctoFrame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				OctoFrame_Char_Frame:SetPoint("TOPRIGHT", OctoFrame_Main_Frame.AllCharFrames[#OctoFrame_Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			OctoFrame_Main_Frame.AllCharFrames[#OctoFrame_Main_Frame.AllCharFrames + 1] = OctoFrame_Char_Frame
			if CharInfo.UnitLevel ~= E.Octo_Globals.curExpansionMaxLevel then
				if CharInfo.currentXP == 0 then
					OctoFrame_Char_Frame.experience:SetWidth(0.1)
				else
					OctoFrame_Char_Frame.experience:SetWidth(CharInfo.currentXP/CharInfo.UnitXPMax*E.Octo_Globals.curWidth)
				end
				OctoFrame_Char_Frame.experience:SetPoint("BOTTOMLEFT", OctoFrame_Char_Frame, "TOPLEFT")
				OctoFrame_Char_Frame.experience:SetColorTexture(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b, .2)
				OctoFrame_Char_Frame.experience:Show()
				OctoFrame_Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel))
				OctoFrame_Char_Frame.UnitLevel:Show()
				OctoFrame_Char_Frame.UnitLevelBG:Show()
			else
				OctoFrame_Char_Frame.experience:Hide()
				OctoFrame_Char_Frame.UnitLevel:SetText(classcolor:WrapTextInColorCode(" "))
				OctoFrame_Char_Frame.UnitLevel:Hide()
				OctoFrame_Char_Frame.UnitLevelBG:Hide()
			end
			if curGUID == curCharGUID then
				OctoFrame_Char_Frame.BG:Show()
				OctoFrame_Char_Frame.BG:SetAlpha(.2)
			end
			for i = 1, #OctoTable_func_otrisovka do
				local TEXTLEFT = OctoFrame_Main_Frame["TextLeft"..i]
				local TEXTCENT = OctoFrame_Char_Frame["CenterLines"..i]
				local BG = OctoFrame_Char_Frame["CenterLines"..i.."BG"]
				TEXTCENT.tooltip = {}
				local vivodCent = " "
				local vivodLeft = " "
				vivodCent, vivodLeft = OctoTable_func_otrisovka[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
				TEXTLEFT:SetText(vivodLeft or "leftText")
				TEXTCENT.CL:SetText(vivodCent or "centText")
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
			-- OctoFrame_Char_Frame.DeleteButton = CreateFrame("BUTTON", "OctoFrame_Char_Frame.DeleteButton"..i, OctoFrame_Char_Frame, "BackDropTemplate")
			-- OctoFrame_Char_Frame.DeleteButton:SetSize(16, 10)
			-- OctoFrame_Char_Frame.DeleteButton:SetPoint("TOP", OctoFrame_Char_Frame, "BOTTOM", 0, -4)
			-- OctoFrame_Char_Frame.DeleteButton:SetBackdrop({
			-- 		edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			-- 		edgeSize = 1,
			-- })
			-- OctoFrame_Char_Frame.DeleteButton:SetBackdropBorderColor(1, 0, 0, 0)
			-- OctoFrame_Char_Frame.DeleteButton:SetScript("OnEnter", function(self)
			-- 		self:SetBackdropBorderColor(1, 0, 0, 1)
			-- 		self.icon:SetVertexColor(1, 0, 0, 1)
			-- 		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			-- 		GameTooltip:ClearLines()
			-- 		GameTooltip:SetText(DELETE)
			-- 		GameTooltip:Show()
			-- end)
			-- OctoFrame_Char_Frame.DeleteButton:SetScript("OnLeave", function(self)
			-- 		self:SetBackdropBorderColor(1, 0, 0, 0)
			-- 		self.icon:SetVertexColor(1, 1, 1, 1)
			-- 		GameTooltip:ClearLines()
			-- 		GameTooltip:Hide()
			-- end)
			-- OctoFrame_Char_Frame.DeleteButton:SetScript("OnMouseDown", function(self)
			-- 		self:SetBackdropBorderColor(1, 0, 0, .5)
			-- 		self.icon:SetVertexColor(1, 0, 0, .5)
			-- end)
			-- OctoFrame_Char_Frame.DeleteButton:SetScript("OnClick", function()
			-- 		Octo_ToDoDeleteChar(curCharGUID)
			-- end)
			-- local t = OctoFrame_Char_Frame.DeleteButton:CreateTexture(nil, "BACKGROUND")
			-- OctoFrame_Char_Frame.DeleteButton.icon = t
			-- t:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\closeWHITE.tga")
			-- t:SetAllPoints(OctoFrame_Char_Frame.DeleteButton)
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		end -- if
		local curAltFrameWidth = #OctoFrame_Main_Frame.AllCharFrames * E.Octo_Globals.curWidth/2
		OctoFrame_Main_Frame:SetSize(curAltFrameWidth*2+E.Octo_Globals.curWidthTitle, E.Octo_Globals.curHeight*(#OctoTable_func_otrisovka)) -- ТУТ БЫЛА ЗАЛУПА
	end -- for
end
function Octo_ToDoDeleteChar(curGUID)
	Octo_ToDoLevels[curGUID] = nil
	for X, Y in pairs(OctoFrame_Main_Frame.AllCharFrames) do
		if Y == OctoFrame_Main_Frame[curGUID] then
			OctoFrame_Main_Frame.AllCharFrames[X].parent = nil
			OctoFrame_Main_Frame.AllCharFrames[X]:Hide()
			OctoFrame_Main_Frame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDoAddDataToAltFrame()
end
function Octo_ToDoOnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" and not InCombatLockdown() then
		Octo_ToDoLevels = Octo_ToDoLevels or {}
		Octo_ToDoVars = Octo_ToDoVars or {}
		Octo_ToDoArtifact = Octo_ToDoArtifact or {}
		Octo_ToDoOther = Octo_ToDoOther or {}
		Octo_ToDoTransmog = Octo_ToDoTransmog or {}
		Octo_ToDo_SmartCollectNEW = Octo_ToDo_SmartCollectNEW or {}
		Octo_ToDo_SmartCollectNEW.Items = Octo_ToDo_SmartCollectNEW.Items or {}
		if Octo_ToDoLevels == nil then Octo_ToDoLevels = {} end
		if Octo_ToDoVars == nil then Octo_ToDoVars = {} end
		if Octo_ToDoArtifact == nil then Octo_ToDoArtifact = {} end
		if Octo_ToDoOther == nil then Octo_ToDoOther = {} end
		if Octo_ToDoTransmog == nil then Octo_ToDoTransmog = {} end
		if Octo_ToDo_SmartCollectNEW == nil then Octo_ToDo_SmartCollectNEW = {} end
		if Octo_ToDo_SmartCollectNEW.LFGInstance == nil then Octo_ToDo_SmartCollectNEW.LFGInstance = {} end
		if Octo_ToDo_SmartCollectNEW.Holiday == nil then Octo_ToDo_SmartCollectNEW.Holiday = {} end
		if Octo_ToDo_SmartCollectNEW.Holiday.Active == nil then Octo_ToDo_SmartCollectNEW.Holiday.Active = {} end
		if Octo_ToDo_SmartCollectNEW.Holiday.Collect == nil then Octo_ToDo_SmartCollectNEW.Holiday.Collect = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Consumables == nil then Octo_ToDo_SmartCollectNEW.Items.Consumables = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Toys == nil then Octo_ToDo_SmartCollectNEW.Items.Toys = {} end
		if Octo_ToDo_SmartCollectNEW.Items.GrayItemsTrash == nil then Octo_ToDo_SmartCollectNEW.Items.GrayItemsTrash = {} end
		if Octo_ToDo_SmartCollectNEW.Items.GrayItemsArmor == nil then Octo_ToDo_SmartCollectNEW.Items.GrayItemsArmor = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Mounts == nil then Octo_ToDo_SmartCollectNEW.Items.Mounts = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Pets == nil then Octo_ToDo_SmartCollectNEW.Items.Pets = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Parts == nil then Octo_ToDo_SmartCollectNEW.Items.Parts = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Elemental == nil then Octo_ToDo_SmartCollectNEW.Items.Elemental = {} end
		if Octo_ToDo_SmartCollectNEW.Items.OptionalReagents == nil then Octo_ToDo_SmartCollectNEW.Items.OptionalReagents = {} end
		if Octo_ToDo_SmartCollectNEW.Items.Other == nil then Octo_ToDo_SmartCollectNEW.Items.Other = {} end
		if Octo_ToDo_SmartCollectNEW.Items.TradeGoods == nil then Octo_ToDo_SmartCollectNEW.Items.TradeGoods = {} end
		if Octo_ToDoOther.prefix == nil then Octo_ToDoOther.prefix = "Русский" end
		if Octo_ToDoOther.TokenPrice == nil then Octo_ToDoOther.TokenPrice = 0 end
		for _, classFilename in pairs(E.Octo_Table.OctoTable_EnglishClasses) do
			Octo_ToDoTransmog[classFilename] = Octo_ToDoTransmog[classFilename] or {}
			for _, itemType in pairs (E.Octo_Globals.TransmogCollectionType) do
				Octo_ToDoTransmog[classFilename][itemType] = Octo_ToDoTransmog[classFilename][itemType] or {}
				for _, difficultyName in pairs(E.Octo_Globals.difficultyName) do
					Octo_ToDoTransmog[classFilename][itemType][difficultyName] = Octo_ToDoTransmog[classFilename][itemType][difficultyName] or "-"
				end
			end
		end
		for classFilename, v in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA) do
			for itemID in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename]) do
				local artifactData = E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename][itemID]
				local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
				for index, data in pairs(artifactData.sets) do
					local appearanceID = data.appearanceID
					local sourceID = data.sourceID
					local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
					local visualID = sourceInfo.visualID
					if Octo_ToDoArtifact == nil then
						Octo_ToDoArtifact = {}
					end
					if Octo_ToDoArtifact[classFilename] == nil then
						Octo_ToDoArtifact[classFilename] = {}
					end
					if Octo_ToDoArtifact[classFilename][itemID] == nil then
						Octo_ToDoArtifact[classFilename][itemID] = {}
					end
					if Octo_ToDoArtifact[classFilename][itemID][visualID] == nil then
						Octo_ToDoArtifact[classFilename][itemID][visualID] = {}
					end
					setmetatable(Octo_ToDoArtifact[classFilename][itemID][visualID], Meta_Table_0)
				end
			end
		end
		-- for k, v in pairs(E.Octo_Globals.TransmogCollectionType) do
		-- end
		if Octo_ToDoVars.config == nil then Octo_ToDoVars.config = {} end
		if Octo_ToDoVars.config.CVar == nil then Octo_ToDoVars.config.CVar = false end
		if Octo_ToDoVars.config.SORTING == nil then Octo_ToDoVars.config.SORTING = false end
		if Octo_ToDoVars.config.InputDelete == nil then Octo_ToDoVars.config.InputDelete = true end
		if Octo_ToDoVars.config.UsableItems == nil then Octo_ToDoVars.config.UsableItems = true end
		if Octo_ToDoVars.config.AutoOpen == nil then Octo_ToDoVars.config.AutoOpen = true end
		if Octo_ToDoVars.config.AutoGossip == nil then Octo_ToDoVars.config.AutoGossip = true end
		if Octo_ToDoVars.config.TalkingHeadFrame == nil then Octo_ToDoVars.config.TalkingHeadFrame = true end
		if Octo_ToDoVars.config.LootFrame == nil then Octo_ToDoVars.config.LootFrame = false end
		if Octo_ToDoVars.config.HideZoneText == nil then Octo_ToDoVars.config.HideZoneText = true end
		if Octo_ToDoVars.config.Covenant == nil then Octo_ToDoVars.config.Covenant = true end
		if Octo_ToDoVars.config.UIErrorsFramePosition == nil then Octo_ToDoVars.config.UIErrorsFramePosition = true end
		if Octo_ToDoVars.config.RaidBossEmoteFrame == nil then Octo_ToDoVars.config.RaidBossEmoteFrame = true end
		if Octo_ToDoVars.config.CinematicCanceler == nil then Octo_ToDoVars.config.CinematicCanceler = true end
		if Octo_ToDoVars.config.BossBanner == nil then Octo_ToDoVars.config.BossBanner = true end
		if Octo_ToDoVars.config.AnotherAddonsCasual == nil then Octo_ToDoVars.config.AnotherAddonsCasual = false end
		if Octo_ToDoVars.config.StaticPopup1Button1 == nil then Octo_ToDoVars.config.StaticPopup1Button1 = false end
		if Octo_ToDoVars.config.AnotherAddonsRAID == nil then Octo_ToDoVars.config.AnotherAddonsRAID = false end
		if Octo_ToDoVars.config.ClearChat == nil then Octo_ToDoVars.config.ClearChat = false end
		if Octo_ToDoVars.config.ShowOnlyCurrentRealm == nil then Octo_ToDoVars.config.ShowOnlyCurrentRealm = true end
		if Octo_ToDoVars.config.AutoSellGrey == nil then Octo_ToDoVars.config.AutoSellGrey = true end
		if Octo_ToDoVars.config.AutoRepair == nil then Octo_ToDoVars.config.AutoRepair = true end
		if Octo_ToDoVars.config.Auto_Screenshot == nil then Octo_ToDoVars.config.Auto_Screenshot = false end
		if Octo_ToDoVars.config.HideErrorMessages == nil then Octo_ToDoVars.config.HideErrorMessages = true end
		if Octo_ToDoVars.config.SellFrame == nil then Octo_ToDoVars.config.SellFrame = false end
		if Octo_ToDoVars.config.AutoTurnQuests == nil then Octo_ToDoVars.config.AutoTurnQuests = false end
		if Octo_ToDoVars.config.TrivialQuests == nil then Octo_ToDoVars.config.TrivialQuests = false end
		if Octo_ToDoVars.config.RepeatableQuests == nil then Octo_ToDoVars.config.RepeatableQuests = false end
		if Octo_ToDoVars.config.GlobalFadePersist == nil then Octo_ToDoVars.config.GlobalFadePersist = false end
		if Octo_ToDoVars.config.LevelToShow == nil then Octo_ToDoVars.config.LevelToShow = 60 end
		if Octo_ToDoVars.config.itemLevelToShow == nil then Octo_ToDoVars.config.itemLevelToShow = 100 end
		if Octo_ToDoVars.config.ExpansionToShow == nil then Octo_ToDoVars.config.ExpansionToShow = tonumber(GetBuildInfo():match("(.-)%.")) or 1 end
		if Octo_ToDoVars.config.ShowHoliday == nil then Octo_ToDoVars.config.ShowHoliday = false end
		if Octo_ToDoVars.config.ShowEvents == nil then Octo_ToDoVars.config.ShowEvents = false end
		if Octo_ToDoVars.config.ShowPVPEvents == nil then Octo_ToDoVars.config.ShowPVPEvents = false end
		if Octo_ToDoVars.config.ShowTransmogrification == nil then Octo_ToDoVars.config.ShowTransmogrification = false end
		if Octo_ToDoVars.config.ShowSkips == nil then Octo_ToDoVars.config.ShowSkips = false end
		if Octo_ToDoVars.config.InstanceTracker == nil then Octo_ToDoVars.config.InstanceTracker = true end
		if Octo_ToDoVars.config.ShowCurrency == nil then Octo_ToDoVars.config.ShowCurrency = true end
		if Octo_ToDoVars.config.ShowReputation == nil then Octo_ToDoVars.config.ShowReputation = false end
		if Octo_ToDoVars.config.ShowQuests == nil then Octo_ToDoVars.config.ShowQuests = true end
		if Octo_ToDoVars.config.ShowItems == nil then Octo_ToDoVars.config.ShowItems = false end
		if Octo_ToDoVars.config.ShowProfessions == nil then Octo_ToDoVars.config.ShowProfessions = false end
		if Octo_ToDoVars.config.ShowMoney == nil then Octo_ToDoVars.config.ShowMoney = true end
		if Octo_ToDoVars.config.ShowItemLevel == nil then Octo_ToDoVars.config.ShowItemLevel = true end
		if Octo_ToDoVars.config.ShowLogoutTime == nil then Octo_ToDoVars.config.ShowLogoutTime = true end
		if Octo_ToDoVars.config.AidingtheAccord == nil then Octo_ToDoVars.config.AidingtheAccord = false end
		if Octo_ToDoVars.config.CommunityFeast == nil then Octo_ToDoVars.config.CommunityFeast = true end
		if Octo_ToDoVars.config.ResearchersUnderFire == nil then Octo_ToDoVars.config.ResearchersUnderFire = true end
		if Octo_ToDoVars.config.Dreamsurges == nil then Octo_ToDoVars.config.Dreamsurges = false end
		if Octo_ToDoVars.config.TimeRift == nil then Octo_ToDoVars.config.TimeRift = false end
		if Octo_ToDoVars.config.Portals == nil then Octo_ToDoVars.config.Portals = false end
		if Octo_ToDoVars.config.curWidth == nil then Octo_ToDoVars.config.curWidth = 96 end
		if Octo_ToDoVars.config.curWidth ~= nil then E.Octo_Globals.curWidth = Octo_ToDoVars.config.curWidth end
		if Octo_ToDoVars.config.curWidthTitle == nil then Octo_ToDoVars.config.curWidthTitle = 200 end
		if Octo_ToDoVars.config.curWidthTitle ~= nil then E.Octo_Globals.curWidthTitle = Octo_ToDoVars.config.curWidthTitle end
		O_otrisovka()
		for i, func in ipairs(E.Octo_Globals.modules) do
			func()
		end
		local MinimapName = GlobalAddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = AddonTexture,
				OnClick = function(_, button)
					if not InCombatLockdown() then
						OctoFrame_Main_Frame:SetShown(not OctoFrame_Main_Frame:IsShown())
						Collect_ALL_PlayerInfo()
						Collect_All_Currency()
						Collect_ALL_GreatVault()
						Collect_All_Holiday()
						Collect_ALL_ItemLevel()
						Collect_ALL_ItemsInBag()
						Collect_ALL_KnownSpell()
						Collect_ALL_Locations()
						Collect_ALL_LoginTime()
						Collect_ALL_Mail()
						-- Collect_ALL_MoneyOnLogin()
						Collect_ALL_MoneyUpdate()
						Collect_ALL_MountEquipmentID()
						Collect_All_Professions()
						Collect_ALL_PVPRaitings()
						Collect_All_Quests()
						Collect_All_Quest_Tooltip()
						Collect_All_Reputations()
						Collect_All_Legion_Transmoge()
						Collect_ALL_UNIVERSALQuestUpdate()
						Collect_BfA_Azerite()
						Collect_BfA_Cloaklvl()
						Collect_BfA_Island()
						Collect_BfA_QuestsBounties()
						Collect_Legion_Artifact()
						Collect_SL_CovenantAnima()
						Collect_All_journalInstance()
						Collect_AberrusTransmog()
						Collect_ALL_PlayerGear()
						TEST_FUNC()
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle.." "..E.Octo_Globals.LightGray_Color..AddonVersion.."|r")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDoVars.config = Octo_ToDoVars.config or {}
		Octo_ToDoVars.config.minimapPos = Octo_ToDoVars.config.minimapPos or 244
		Octo_ToDoVars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDoVars.config)
		ldbi:Show(MinimapName)
	end
	if event == "PLAYER_LOGIN" and not InCombatLockdown() then
		local curGUID = UnitGUID("PLAYER")
		if Octo_ToDoOther.default_bindings_set == nil then
			E.Octo_Func.HandleDefaultBindings("Quick Link (wowhead.com)", "CTRL-C")
			E.Octo_Func.HandleDefaultBindings("Quick Link (raider.io)", "CTRL-SHIFT-C")
			SaveBindings(GetCurrentBindingSet())
			Octo_ToDoOther.default_bindings_set = true
		end
		Octo_ToDoLevels[curGUID] = Octo_ToDoLevels[curGUID] or {}
		for k, CharInfo in pairs(Octo_ToDoLevels) do
			checkCharInfo(CharInfo)
		end
		-- Collect_Token_Price()
		Collect_AberrusTransmog()
		Collect_ALL_PlayerInfo()
		Collect_All_Currency()
		Collect_ALL_GreatVault()
		Collect_All_Holiday()
		Collect_ALL_ItemLevel()
		Collect_ALL_ItemsInBag()
		Collect_ALL_KnownSpell()
		Collect_ALL_Locations()
		Collect_ALL_LoginTime()
		Collect_ALL_Mail()
		Collect_ALL_MoneyOnLogin()
		Collect_ALL_MoneyUpdate()
		Collect_ALL_MountEquipmentID()
		Collect_All_Professions()
		Collect_ALL_PVPRaitings()
		Collect_All_Quests()
		Collect_All_Quest_Tooltip()
		Collect_All_Reputations()
		Collect_All_Legion_Transmoge()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		Collect_BfA_Island()
		Collect_BfA_QuestsBounties()
		Collect_Legion_Artifact()
		Collect_SL_CovenantAnima()
		Collect_All_journalInstance()
		Octo_ToDoCreateAltFrame()
		Octo_ToDoAddDataToAltFrame()
		Collect_ALL_PlayerGear()
		C_Timer.After(5, function()
				if Octo_ToDoVars.config.AnotherAddonsRAID then
					Octo_ToDoVars.config.AnotherAddonsRAID = false
				end
		end)
	end
	if event == "TOKEN_MARKET_PRICE_UPDATED" then
		Collect_Token_Price()
	end
	if (event == "CHAT_MSG_SKILL" or event == "CHAT_MSG_SYSTEM") and not InCombatLockdown() then -- event == "TRAINER_UPDATE" or
		Collect_All_Professions()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "UI_INFO_MESSAGE" then
		Collect_ALL_PlayerInfo()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "ACTIONBAR_UPDATE_COOLDOWN" and not InCombatLockdown() then
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then
			Timer_Legion_Invasion()
			Timer_BfA_Invasion()
			Timer_BfA_Assault()
			Timer_DF_ToDragonbaneKeep()
			Timer_DF_GrandHunts()
			Timer_DF_CommunityFeast()
			Timer_DF_PrimalStorms()
			Timer_DF_ResearchersUnderFire()
			Timer_DF_TimeRift()
			Timer_DF_Dreamsurges()
			Timer_SL_Maw_Assault()
			Timer_Daily_Reset()
			Octo_ToDoAddDataToAltFrame()
		else
			return
		end
	end
	if (event == "COVENANT_CHOSEN" or event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED") and not InCombatLockdown()  then
		C_Timer.After(1, function()
				Collect_SL_CovenantAnima()
		end)
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "QUEST_LOG_UPDATE" and not InCombatLockdown() then
		-- print ("|cff00FF00"..event.."|r")
		Collect_All_Quests()
		Collect_All_Quest_Tooltip()
		Collect_BfA_QuestsBounties()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_BfA_Island()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_MONEY" and not InCombatLockdown() then
		Collect_ALL_MoneyUpdate()
		Collect_Token_Price()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "CURRENCY_DISPLAY_UPDATE" and not InCombatLockdown() then
		Collect_All_Currency()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if (--[[event == "UNIT_INVENTORY_CHANGED" or]] event == "PLAYER_EQUIPMENT_CHANGED" --[[or event == "PLAYER_AVG_ITEM_LEVEL_UPDATE"]]) and not InCombatLockdown() then
		-- print ("|cff505050"..event.."|r")
		Collect_ALL_ItemLevel()
		Collect_BfA_Cloaklvl()
		Collect_BfA_Azerite()
		Collect_ALL_PlayerGear()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_LOGOUT" and not InCombatLockdown() then
		Collect_ALL_PVPRaitings()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_LEAVING_WORLD" and not InCombatLockdown() then
		Collect_ALL_GreatVault()
		Collect_ALL_LoginTime()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_ENTERING_WORLD" and not InCombatLockdown() then
		-- print ("|cff000000"..event.."|r")
		Collect_Token_Price()
		Collect_ALL_PVPRaitings()
		Collect_ALL_LoginTime()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_ALL_MountEquipmentID()
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		Collect_Legion_Artifact()
		Collect_All_journalInstance()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	 --[[event == "CHAT_MSG_LOOT" or]]
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "ITEM_COUNT_CHANGED" or event == "MAIL_SEND_SUCCESS") and not InCombatLockdown() then
		-- or event == "NEW_TOY_ADDED"
		-- or event == "PLAYER_REGEN_ENABLED"
		-- or event == "PLAYER_MONEY"
		-- or event == "MERCHANT_SHOW"
		-- or event == "MERCHANT_CLOSED"
		-- or event == "MAIL_INBOX_UPDATE"
		-- or event == "MAIL_SHOW"
		-- or event == "UPDATE_PENDING_MAIL"
		-- or event == "UI_INFO_MESSAGE"
		-- or event == "HEARTHSTONE_BOUND"
		-- or event == "SPELLS_CHANGED"
		-- or event == "ENCOUNTER_END"
		-- or event == "COVENANT_CHOSEN"
		-- or event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED"
		-- or event == "ITEM_PUSH"
		-- or event == "BAG_NEW_ITEMS_UPDATED"
		-- or event == "ITEM_LOCKED"
		Collect_ALL_ItemsInBag()
		-- print ("|cffFF00FF"..event.."|r".."Collect_ALL_ItemsInBag")
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if (event == "ITEM_CHANGED" or event == "TRANSMOG_COLLECTION_SOURCE_ADDED") and not InCombatLockdown() then
		Collect_AberrusTransmog()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "HEARTHSTONE_BOUND" or event == "ZONE_CHANGED_NEW_AREA" and not InCombatLockdown() then
		Collect_ALL_Locations()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "SPELLS_CHANGED" and not InCombatLockdown() then
		-- print ("|cffFFFF00"..event.."|r")
		Collect_ALL_KnownSpell()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_MOUNT_DISPLAY_CHANGED" and not InCombatLockdown() then
		Collect_ALL_MountEquipmentID()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "AZERITE_ITEM_EXPERIENCE_CHANGED" and not InCombatLockdown() then
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "MAIL_INBOX_UPDATE" or event == "MAIL_SHOW" or event == "UPDATE_PENDING_MAIL" then
		Collect_ALL_Mail()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if (event == "PLAYER_ENTERING_WORLD"
		or event == "CALENDAR_OPEN_EVENT")
		-- or event == "LFG_COMPLETION_REWARD"
		-- or event == "LFG_UPDATE_RANDOM_INFO"
		-- or event == "CALENDAR_UPDATE_EVENT_LIST"
		-- or event == "CALENDAR_UPDATE_EVENT"
		-- or event == "CALENDAR_CLOSE_EVENT"
		-- or event == "CALENDAR_NEW_EVENT"
		then
		Collect_All_Holiday()
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
	end
	if event == "PLAYER_REGEN_DISABLED" or InCombatLockdown() then
		if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then
			OctoFrame_Main_Frame:Hide()
		end
	end
	if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM") and not InCombatLockdown() then
		E.Octo_Func.PlaySoundFile_whisper(...)
	end
	if event == "READY_CHECK" then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
	if event == "ENCOUNTER_END" then
		-- print ("|cff0000FF"..event.."|r")
		-- RequestRaidInfo()
		C_Timer.After(1, function()
				Collect_All_journalInstance()
				if OctoFrame_Main_Frame and OctoFrame_Main_Frame:IsShown() then Octo_ToDoAddDataToAltFrame() end
		end)
	end
end
Octo_ToDoOnLoad()
SLASH_Octo1, SLASH_Octo2 = "/Octo", "/OctoDF"
function SlashCmdList.Octo(msg, editBox)
	if not InCombatLockdown() then
		OctoFrame_Main_Frame:SetShown(not OctoFrame_Main_Frame:IsShown())
		Octo_ToDoAddDataToAltFrame()
	end
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
SlashCmdList["RELOAD"] = ReloadUI
SLASH_RELOAD1 = "/rl"
