local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_09_Shadowlands()
	local OctoTable_Universal = {

	{

		showTooltip = true,
		textleft = L["World Boss"],
		name_save = "WorldBoss",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{65143},
			{64531},
			{61813},
			{61816},
			{61815},
			{61814},
		},
		forcedMaxQuest = 3,
	},

	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	{

		showTooltip = true,
		textleft = "Maw: Wrath of the Jailer",
		name_save = "wrathofthejailer",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{63414},
		},
		forcedMaxQuest = 1,
	},
	{

		showTooltip = true,
		textleft = "Maw: The Hunt",
		name_save = "mawhunt",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{63180},
			{63194},
			{63198},
			{63196},
			{63199},
		},
		forcedMaxQuest = 1,
	},
	{

		showTooltip = true,
		textleft = "Maw: Tormentors",
		name_save = "mawtormentor",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{63854},
		},
		forcedMaxQuest = 1,
	},

	{

		showTooltip = true,
		textleft = E.Timers.SL_Maw_Assault().."Maw: Covenant Assault",
		name_save = "mawassault",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{63822},
			{63823},
			{63824},
			{63543},
		},
		forcedMaxQuest = 1,
	},

	{

		showTooltip = true,
		textleft = "Korthia: Weekly", --E:func_questName(63949),
		name_save = "kortiaweekly",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{63949},
		},
		forcedMaxQuest = 1,
	},

	{

		showTooltip = true,
		textleft = "1000 anima", -- E:func_questName(61981),
		name_save = "anima1k",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{61981},
			{61982},
			{61983},
			{61984},
		},
		forcedMaxQuest = 1,
	},
	{

		showTooltip = true,
		textleft = "Maw: World Boss",
		name_save = "mawworldboss",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{64531},
		},
		forcedMaxQuest = 1,
	},



	{

		showTooltip = true,
		textleft = "Korthia: Lost Research", -- E:func_questName(65266),
		name_save = "korthialostresearch",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{65266},
		},
		forcedMaxQuest = 1,
	},


	{

		showTooltip = true,
		textleft = "Korthia: anima table mission",
		name_save = "korthiaanimatablemission",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{64551},
			{64549},
			{64552},
			{64553},
		},
		forcedMaxQuest = 4,
	},


	{

		showTooltip = true,
		textleft = "Zerith Mortis: World Boss",
		name_save = "zerthworldboss",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{65143},
		},
		forcedMaxQuest = 1,
	},


	{

		showTooltip = true,
		textleft = "Zerith Mortis: Weekly", -- E:func_questName(66042),
		name_save = "patternswithinpatterns",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{66042},
		},
		forcedMaxQuest = 1,
	},




	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------

	{

		showTooltip = true,
		textleft = "Torghast: Adamant Vaults",
		name_save = "torghastav",
		reset = "Weekly",
		desc = "Shadowlands",
		quests = {
			{64347},
		},
		forcedMaxQuest = 1,
	},






	-- {

-- 	showTooltip = true,
	-- textleft = E:func_questName(62858),
	-- 	name_save = "ReturnLostSouls",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		62858,
	-- 		62859,
	-- 		62860,
	-- 		62861,
	-- 		62862,
	-- 		62863,
	-- 		62864,
	-- 		62865,
	-- 		62866,
	-- 		62867,
	-- 		62868,
	-- 		62869,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "TradingFavors",
	-- 	name_save = "TradingFavors",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		60242,
	-- 		60243,
	-- 		60244,
	-- 		60245,
	-- 		60246,
	-- 		60247,
	-- 		60248,
	-- 		60249,
	-- 		60250,
	-- 		60251,
	-- 		60252,
	-- 		60253,
	-- 		60254,
	-- 		60255,
	-- 		60256,
	-- 		60257,
	-- 	},
	-- 	forcedMaxQuest = 2,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = E:func_currencyName(1880),
	-- 	name_save = "MawQuest",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		60646,
	-- 		60762,
	-- 		60775,
	-- 		61075,
	-- 		61079,
	-- 		61088,
	-- 		61103,
	-- 		61104,
	-- 		61765,
	-- 		62214,
	-- 		62234,
	-- 	},
	-- 	forcedMaxQuest = 3,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Daily quests"],
	-- 	name_save = "KorthiaDailyQuest",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		63787,
	-- 		64103,
	-- 		63788,
	-- 		63793,
	-- 	},
	-- 	forcedMaxQuest = 4,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = E:func_questName(64522),
	-- 	name_save = "KorthiaStolenKorthianSupplies",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64522,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "KorthiaRares",
	-- 	name_save = "KorthiaRares",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64457,
	-- 		64338,
	-- 		64442,
	-- 		64278,
	-- 		64245,
	-- 		64246,
	-- 		64263,
	-- 		64428,
	-- 		64258,
	-- 		64233,
	-- 		64349,
	-- 		63830,
	-- 		64243,
	-- 		64291,
	-- 		64455,
	-- 		64320,
	-- 		64313,
	-- 		64284,
	-- 		64285,
	-- 		64257,
	-- 		64440,
	-- 		64276,
	-- 		64272,
	-- 		64232,
	-- 		64251,
	-- 		64152,
	-- 		64439,
	-- 	},
	-- 	forcedMaxQuest = 23,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Purple Mobs"],
	-- 	name_save = "KorthiaPurpleMobs",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64341,
	-- 		64342,
	-- 		64343,
	-- 		64344,
	-- 		64747,
	-- 		64748,
	-- 		64749,
	-- 		64750,
	-- 		64751,
	-- 		64752,
	-- 		64753,
	-- 		64754,
	-- 		64755,
	-- 		64756,
	-- 		64757,
	-- 	},
	-- 	forcedMaxQuest = 15, -- 3?
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Relic Gorgers"],
	-- 	name_save = "KorthiaRelicGorgers",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64433,
	-- 		64434,
	-- 		64435,
	-- 		64436,
	-- 	},
	-- 	forcedMaxQuest = 4,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Mushrooms"],
	-- 	name_save = "KorthiaCollectionMushrooms",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64351,
	-- 		64354,
	-- 		64355,
	-- 		64356,
	-- 		64357,
	-- 	},
	-- 	forcedMaxQuest = 5,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Nests"],
	-- 	name_save = "KorthiaCollectionNests",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64358,
	-- 		64359,
	-- 		64360,
	-- 		64361,
	-- 		64362,
	-- 	},
	-- 	forcedMaxQuest = 5,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Mawsworn Caches"],
	-- 	name_save = "KorthiaCollectionMawswornCaches",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64021,
	-- 		64363,
	-- 		64364,
	-- 	},
	-- 	forcedMaxQuest = 3,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Bones/Stones/Relics"],
	-- 	name_save = "KorthiaCollectionBonesStonesRelics",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64787,
	-- 		64788,
	-- 		64789,
	-- 		64790,
	-- 		64791,
	-- 	},
	-- 	forcedMaxQuest = 5,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Spectral Bound Chest"],
	-- 	name_save = "KorthiaRIFTSpectralBoundChest",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64247, -- Chest with 3 keys
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Helsworn Chest"],
	-- 	name_save = "MawHelswornChest",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64256, -- Maw chest in Desmotaeron
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = L["Anima Vessel"],
	-- -- name_save = "KorthiaKorthianAnimaVessel",
	-- -- reset = "Daily",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64575,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Stolen Anima Vessel"],
	-- 	name_save = "KorthiaRIFTStolenAnimaVessel",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64265,
	-- 		64269,
	-- 		64270,
	-- 	},
	-- 	forcedMaxQuest = 3,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Riftbound Caches"],
	-- 	name_save = "KorthiaRIFTRiftboundCaches",
	-- 	reset = "Weekly",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64456,
	-- 		64470,
	-- 		64471,
	-- 		64472,
	-- 	},
	-- 	forcedMaxQuest = 4,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = L["Zovaal's Vault"],
	-- 	name_save = "KorthiaRIFTZovaalsVault",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64283,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = E:func_GetItemNameByID(187216),
	-- 	name_save = "KorthiaSoultwiningCrescent",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64572,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMResearchReportRelicExaminationTechniques",
	-- -- name_save = "KorthiaITEMResearchReportRelicExaminationTechniques",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64367,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMVaultAnimaTracker",
	-- -- name_save = "KorthiaITEMVaultAnimaTracker",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64061,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMTreatiseRecognizingStygiaanditsUses",
	-- -- name_save = "KorthiaITEMTreatiseRecognizingStygiaanditsUses",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64307,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMTreatiseBondsofStygiainMortals",
	-- -- name_save = "KorthiaITEMTreatiseBondsofStygiainMortals",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64828,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMTreatiseTheStudyofAnimaandHarnessingEveryDrop",
	-- -- name_save = "KorthiaITEMTreatiseTheStudyofAnimaandHarnessingEveryDrop",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64027,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMTreatiseRelicsAboundintheShadowlands",
	-- -- name_save = "KorthiaITEMTreatiseRelicsAboundintheShadowlands",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64366,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMResearchReportAdaptiveAlloys",
	-- -- name_save = "KorthiaITEMResearchReportAdaptiveAlloys",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64300,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- -- {

	-- showTooltip = true,--
	-- textleft = "KorthiaITEMResearchReportFirstAlloys",
	-- -- name_save = "KorthiaITEMResearchReportFirstAlloys",
	-- -- reset = "Once",
	-- -- desc = "Shadowlands",
	-- -- quests = {
	-- -- 64303,
	-- -- },
	-- -- forcedMaxQuest = 1,
	-- -- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMRares",
	-- 	name_save = "ZMRares",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65557,
	-- 		65547,
	-- 		65581,
	-- 		65579,
	-- 		63988,
	-- 		65552,
	-- 		65582,
	-- 		64668,
	-- 		64716,
	-- 		64719,
	-- 		65548,
	-- 		65550,
	-- 		65239,
	-- 		65585,
	-- 		65586,
	-- 		65587,
	-- 		65583,
	-- 		65580,
	-- 		65553,
	-- 		65544,
	-- 		65240,
	-- 		65241,
	-- 		65556,
	-- 		65584,
	-- 		65551,
	-- 		65251,
	-- 		65257,
	-- 		65272,
	-- 		65574,
	-- 		65273,
	-- 		65555,
	-- 		65549,
	-- 	},
	-- 	forcedMaxQuest = 25,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMDuneDominanceRares",
	-- 	name_save = "ZMDuneDominanceRares",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65585,
	-- 		65586,
	-- 		65587,
	-- 	},
	-- 	forcedMaxQuest = 3,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMWorldQuests",
	-- 	name_save = "ZMWorldQuests",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		64960,
	-- 		64974,
	-- 		65081,
	-- 		65089,
	-- 		65102,
	-- 		65115,
	-- 		65117,
	-- 		65119,
	-- 		65230,
	-- 		65232,
	-- 		65234,
	-- 		65244,
	-- 		65252,
	-- 		65262,
	-- 		65402,
	-- 		65403,
	-- 		65404,
	-- 		65405,
	-- 		65406,
	-- 		65407,
	-- 		65408,
	-- 		65410,
	-- 		65411,
	-- 		65412,
	-- 		65413,
	-- 		65414,
	-- 		65415,
	-- 		65416,
	-- 		65417,
	-- 		65231,
	-- 	},
	-- 	forcedMaxQuest = 3,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMTREASURES",
	-- 	name_save = "ZMTREASURES",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65520,
	-- 		65573,
	-- 		65489,
	-- 		64667,
	-- 		65465,
	-- 		65523,
	-- 		65487,
	-- 		65503,
	-- 		65178,
	-- 		65480,
	-- 		65545,
	-- 		65173,
	-- 		65441,
	-- 		65522,
	-- 		65537,
	-- 		65536,
	-- 		65542,
	-- 		65546,
	-- 		65540,
	-- 		65566,
	-- 		65447,
	-- 		65543,
	-- 		64545,
	-- 		65270,
	-- 		65565,
	-- 		65175,
	-- 	},
	-- 	forcedMaxQuest = 26,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMUndulatingFoliage",
	-- 	name_save = "ZMUndulatingFoliage",
	-- 	reset = "Once",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65572,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMPryingEyeDiscovery",
	-- 	name_save = "ZMPryingEyeDiscovery",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65184,
	-- 		65501,
	-- 		65611,
	-- 	},
	-- 	forcedMaxQuest = 1,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMPUZZLECACHES",
	-- 	name_save = "ZMPUZZLECACHES",
	-- 	reset = "Daily",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65094,
	-- 		65323,
	-- 		65318,
	-- 		65322,
	-- 		65317,
	-- 		65093,
	-- 		65321,
	-- 		65092,
	-- 		65316,
	-- 		65412,
	-- 		65315,
	-- 		65091,
	-- 		65320,
	-- 		64972,
	-- 		65314,
	-- 		65319,
	-- 	},
	-- 	forcedMaxQuest = 50,
	-- },
	-- {

	-- showTooltip = true,
	-- textleft = "ZMConcordance",
	-- 	name_save = "ZMConcordance",
	-- 	reset = "Once",
	-- 	desc = "Shadowlands",
	-- 	quests = {
	-- 		65179,
	-- 		65213,
	-- 		65216,
	-- 		65210,
	-- 		65180,
	-- 		65214,
	-- 		65211,
	-- 		65217,
	-- 		64940,
	-- 		65212,
	-- 		65209,
	-- 		65215,
	-- 	},
	-- 	forcedMaxQuest = 12,
	-- },









	}
	return OctoTable_Universal
end