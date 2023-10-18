local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_UniversalQuest = {
	{
		name_save = "ALL",
		name_quest = "ALL",-- = WorldBoss_Icon.."WB",
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
		name_quest = "ZaqaliElders",-- = WorldBoss_Icon.."WB: Старейшины закали",
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
		name_quest = "ALL",-- = WorldBoss_Icon.."WB",
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
		name_quest = "Antros",-- = WorldBoss_Icon.."WB: Антрос",
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
		name_quest = "Morgeth",-- = WorldBoss_Icon.."WB: Мор'гет",
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
		name_quest = "ALL",-- = WorldBoss_Icon.."WB",
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
		name_quest = "Nazjatar",-- = WorldBoss_Icon.."WB: Nazjatar",
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
		name_quest = "Darkshore",-- = WorldBoss_Icon.."WB: PVP",
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
		name_quest = "Assault",-- = WorldBoss_Icon.."WB: Assault",
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
		name_quest = "ALL",-- = WorldBoss_Icon.."WB",
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
		name_quest = "ShapingFate",-- = "Определяя судьбу",
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
		name_quest = "ReplenishtheReservoir",-- = "Наполнение резервуара",
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
		name_quest = "Torghast",-- = "Торгаст",
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
		name_quest = "CovenantAssault",-- = "Атака ковенантов",
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
		name_quest = "ContainingtheHelsworn",-- = "Сдержать Верных Хелии",
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
		name_quest = "ReturnLostSouls",-- = "Возвращение потерянных душ",
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
		name_quest = "TradingFavors",-- = "Обмен услугами или Ценная находка",
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
		name_quest = "TheWorldAwaits",-- = "The World Awaits",
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
		name_quest = "TheArenaCalls",-- = "The Arena Calls",
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
		name_quest = "EmissaryofWar",-- = "Emissary of War",
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
		name_quest = "ACalltoBattle",-- = "A Call to Battle",
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
		name_quest = "SomethingDifferent",-- = "Something Different",
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
		name_quest = "PVP",-- = "ПВП",
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
		name_quest = "StolenKorthianSupplies",-- = "Украденные кортийские припасы (ДРОПАЕТСЯ)",
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
		name_quest = "LostResearch",-- = "Пропавшие исследования",
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
		name_quest = "KorthianAnimaVessel",-- = "Кортийский сосуд с анимой",
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
		name_quest = "StolenAnimaVessel",-- = "Сосуд с украденной анимой",
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
		name_quest = "RiftboundCache",-- = "Тайник Разлома",
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
		name_quest = "ZovaalsVault",-- = "Хранилище Зоваала",
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
		name_quest = "SpectralBoundChest",-- = "Сундук с призрачным замком",
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
		name_quest = "HelswornChest",-- = "Сундук Верных Хелии",
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
		name_quest = "Mobs",-- = "Мобы",
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
		name_quest = "RelicGorger",-- = "Поглотитель реликвий",
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
		name_quest = "Collection",-- = "Сбор",
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
		name_quest = "Quest",-- = "Утроба",
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
		name_quest = "Rares",-- = "Рарки",
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
		name_quest = "ResearchReportRelicExaminationTechniques",-- = "Отчет об исследованиях: методика изучения реликвий",
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
		name_quest = "VaultAnimaTracker",-- = "Детектор украденной анимы",
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
		name_quest = "ResearchReportAllSeeingCrystal",-- = "Отчет об исследованиях: всевидящий кристалл",
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
		name_quest = "TreatiseRecognizingStygiaanditsUses",-- = "Исследование: распознавание стигии и ее применение",
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
		name_quest = "TreatiseBondsofStygiainMortals",-- = "Исследование: узы стигии в смертных",
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
		name_quest = "ResearchReportAncientShrines",-- = "Отчет об исследованиях: древние святилища",
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
		name_quest = "TreatiseTheStudyofAnimaandHarnessingEveryDrop",-- = "Исследование: свойства и эффективное использование анимы",
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
		name_quest = "TreatiseRelicsAboundintheShadowlands",-- = "Исследование: поиски реликвий в Темных Землях",
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
		name_quest = "ResearchReportAdaptiveAlloys",-- = "Отчет об исследованиях: адаптивные сплавы",
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
		name_quest = "ResearchReportFirstAlloys",-- = "Отчет об исследованиях: первые сплавы",
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
		name_quest = "Events",-- = "Пещера Заралек (события)",
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
		name_quest = "Rares",-- = "Рарки",
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
		name_quest = "AWorthyAllyLoammNiffen",-- = L["A Worthy Ally: Loamm Niffen"],
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
		name_quest = "Sniffenseeking",-- = "нюхорысканье",
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
		name_quest = "SniffenseekingItems",-- = "нюхорысканье (Items)",
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
		name_quest = "Storylines",-- = "Storylines: ".. L["Zaralek Cavern"],
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
		name_quest = "Storylines",-- = "Storylines: ".. L["Dawn of the Infinites"],
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
		name_quest = "Rares",-- = "Рарки",
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
		name_quest = "CommunityFeast",-- = L["Community Feast"],
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
		name_quest = "DragonbaneKeep",-- = L["Siege on Dragonbane Keep"],
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
		name_quest = "TheGrandHunt",-- = L["Grand Hunt"],
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
		name_quest = "StormsFury",-- = L["The Storm's Fury"],
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
		name_quest = "KeysofLoyalty",-- = L["Keys of Loyalty"],
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
		name_quest = "StormBoundChest",-- = L["Storm-Bound Chest"],
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
		name_quest = "ResearchersUnderFire",-- = L["Researchers Under Fire"],
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
		name_quest = "FyrakkAssaults",-- = L["Fyrakk Asssaults"],
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
		name_quest = "DiscipleofFyrakk",-- = L["Disciple of Fyrakk"],
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
		name_quest = "Timewalk_500CURRENCY",-- = PLAYER_DIFFICULTY_TIMEWALKER.."(500 cur)",
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
		name_quest = "Timewalk_RAIDS_Cataclysm",  -- Cataclysm-- = "Timewalk_RAIDS_Cataclysm",
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
		name_quest = "Timewalk_RAIDS_BurningCrusade", -- Burning Crusade-- = "Timewalk_RAIDS_BurningCrusade",
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
		name_quest = "Timewalk5DUNGEONS",-- = PLAYER_DIFFICULTY_TIMEWALKER.."Timewalk5DUNGEONS",
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
		name_quest = "AidingtheAccord",-- = L["Aiding the Accord"], -- "Помощь союзу",
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
		name_quest = "FightingisItsOwnReward",-- = L["Fighting is Its Own Reward"],
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
		name_quest = "Shadowmourne",-- = "Темная Скорбь",
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
		name_quest = "Warlock_GreenFire",-- = L["Green Fire"],
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
		name_quest = "Warlock_SomeWickedThings",-- = L["Some Wicked Things"],
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
		name_quest = "PatternsWithinPatterns",-- = "Закономерности в закономерностях",
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
		name_quest = "Rares",-- = "Рарки",
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
		name_quest = "RaresDuneDominance",-- = "Рарки (Дюны)",
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
		name_quest = "worldQuests",-- = "worldQuests",
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
		name_quest = "TREASURES",-- = "TREASURES",
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
		name_quest = "GetLockStatus",-- = "GetLockStatus",
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
		name_quest = "UndulatingFoliage",-- = "UndulatingFoliage",
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
		name_quest = "CatchingUp",-- = "Наверстываем!",
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
		name_quest = "PryingEyeDiscovery",-- = "ZM_PryingEyeDiscovery",
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
		name_quest = "PUZZLECACHES",-- = "PUZZLECACHES",
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
		name_quest = "Concordance",-- = "Concordance",
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
		name_quest = "coinsQuests",-- = "coinsQuests WoD",
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
		name_quest = "coinsQuests",-- = "coinsQuests Legion",
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
		name_quest = "coinsQuests",-- = "coinsQuests BfA",
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
		name_quest = "miniVision",-- = "miniVision",
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
		name_quest = "AssaultTheBlackEmpire",-- = "Assault: The Black Empire",
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
		name_quest = "Warfront1",-- = "Warfront1",
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
		name_quest = "Warfront2",-- = "Warfront2",
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
		name_quest = "WarfrontHC",-- = "WarfrontHC",
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
		name_quest = "BalanceofPower",-- = "Balance of Power",
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
		name_quest = "InvasionQuests",-- = "Invasion Quests",
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
		name_quest = "InvasionQuests",-- = "Invasion Quests",
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
		name_quest = "ArmiesofLegionfall",-- = "Broken Shore - Armies of Legionfall",
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
		name_quest = "AberrustheShadowedCrucibleSarkareth",-- = "Aberrus, the Shadowed Crucible: Sarkareth",
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
		name_quest = "VaultoftheIncarnatesFuryoftheStormEater",-- = "Vault of the Incarnates: Fury of the Storm-Eater",
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
		name_quest = "Excavations",-- = "Broken Shore - Excavations",
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
		name_quest = "ToArgus",-- = "Broken Shore - To Argus!",
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
		name_quest = "blingtron",-- = "blingtron",
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
		name_quest = "TimeRift",-- = L["TimeRift"],
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
		name_quest = "DreamsurgeInvestigation",-- = L["Dreamsurge Investigation"],
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
		name_quest = "ShapingtheDreamsurge",-- = L["Shaping the Dreamsurge"],
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
		name_quest = "WhenTimeNeedsMending", -- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(77236), E.Octo_Func.CheckCompletedByQuestID(77236)} -- 1 на аккаунт-- = L["When Time Needs Mending"],
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
		name_quest = "Rares",-- = "Darkshore - Rares",
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
		name_quest = "SummerFestival",-- = "Summer Festival",
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
		name_quest = "TheEasternKingdomsCupBegins",-- = "The Eastern Kingdoms Cup Begins",
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
		name_quest = "Brewfest",-- = "Brewfest",
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
		name_quest = "Brewfest_BarrelingDown", --Делай бочку https://ru.wowhead.com/quest=77208 D-- = "Barreling Down",
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
		name_quest = "Brewfest_BubblingBrews", --Пузырящийся напиток https://ru.wowhead.com/quest=76591 D-- = "Bubbling Brews",
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
		name_quest = "Brewfest_DirebrewsDireBrew", --Худое варево Худовара https://www.wowhead.com/ru/quest=12492/-- = "Direbrew's Dire Brew",
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
		name_quest = "TemporalAcquisitionsSpecialist", -- https://www.wowhead.com/ru/achievement = 18554/-- = "Temporal Acquisitions Specialist",
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
		name_quest = "TheVeiledOssuary",-- = L["The Veiled Ossuary"],
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
		name_quest = "TyrsFall",-- = L["Tyr's Fall"],
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
		name_quest = "ReforgingtheTyrsGuard",-- = L["Reforging the Tyr's Guard"],
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
		name_quest = "TheCoalitionofFlames",-- = L["The Coalition of Flames"],
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
		name_quest = "DarkmoonFaire",-- = "Darkmoon Faire",
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
		name_quest = "WarcraftRumble",-- = "Warcraft Rumble",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			73182,75039,74850,74851,75036,73928,75040,73936,75041,75037,74852,74843,75038,73180,74849,74287,74845,74848,73952,74286,74844,
		},
		max = 21,
	},

	{
		name_save = "SeeingRed",
		name_quest = "SeeingRed",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			77408,77409,77410,77411,77789,77412,77795,
		},
		max = 7,
	},
	-- {
	-- 	name_save = "Rumiastrasza",
	-- 	name_quest = "Rumiastrasza",
	-- 	reset = "Once",
	-- 	expansion = "DF",
	-- 	place = "",
	-- 	desc = "",
	-- 	questID = {
	-- 		70930, -- all-tea-no-shadeleaf
	-- 		70958, -- finest-fungi-at-the-feast
	-- 		70987, -- hearts-of-starch
	-- 		70981, -- savory-seas
	-- 		70988, -- the-eggs-the-thing
	-- 		70932, -- the-life-of-spice
	-- 		70957, -- the-sea-out-west
	-- 		67071, -- what-a-long-sweet-trip-its-been
	-- 	},
	-- 	max = 8,
	-- },

	{
		name_save = "Garrison1",
		name_quest = "Garrison1",
		reset = "Once",
		expansion = "Draenor",
		place = "",
		desc = "",
		questID = {
			34378, -- Horde
			34586, -- Alliance
		},
		max = 1,
	},
	{
		name_save = "Garrison2",
		name_quest = "Garrison2",
		reset = "Once",
		expansion = "Draenor",
		place = "",
		desc = "",
		questID = {
			36567, -- Horde
			36592, -- Alliance
		},
		max = 1,
	},
	{
		name_save = "Garrison3",
		name_quest = "Garrison3",
		reset = "Once",
		expansion = "Draenor",
		place = "",
		desc = "",
		questID = {
			36614, -- Horde
			 -- Alliance
		},
		max = 1,
	},



	-- ARMOR
	{
		name_save = "WorgenHeritageArmor",
		name_quest = "WorgenHeritageArmor",-- = Alliance_Icon.."Worgen Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			54976,54977,54980,54981,54982,54983,54984,54990,
		},
		max = 8,
	},
	{
		name_save = "ForsakenHeritageArmor",
		name_quest = "ForsakenHeritageArmor",-- = Horde_Icon.."Forsaken Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			76530,72854,72855,72856,72857,72858,72859,72860,72861,72862,72863,72864,72865,72866,72867,
		},
		max = 15,
	},
	{
		name_save = "GoblinHeritageArmor",
		name_quest = "GoblinHeritageArmor",-- = Horde_Icon.."Goblin Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			57043,57045,57047,57048,57051,57052,57053,57058,57059,57077,57078,57079,57080,
		},
		max = 13,
	},
	{
		name_save = "NightElfHeritageArmor",
		name_quest = "NightElfHeritageArmor",-- = Alliance_Icon.."Night Elf Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75890,75891,76194,76195,76196,76203,76197,76205,76206,76207,76212,76213,
		},
		max = 12,
	},
	{
		name_save = "HumanHeritageArmor",
		name_quest = "HumanHeritageArmor",-- = Alliance_Icon.."Human Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			75265,72644,72405,72408,72409,72424,72426,72430,72431,72432,72453,72445,72446,72449,72450,72451,72452,
		},
		max = 17,
	},
	{
		name_save = "DwarvenHeritageArmor",
		name_quest = "DwarvenHeritageArmor",-- = Alliance_Icon.."Dwarven Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			53838,53835,53836,53837,53839,53841,53840,53844,53842,53845,53846,
		},
		max = 11,
	},
	{
		name_save = "OrcHeritageArmor", -- https://ru.wowhead.com/spell=399753
		name_quest = "OrcHeritageArmor", -- https://ru.wowhead.com/spell=399753-- = Horde_Icon.."Orc Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			73703,72462,72464,72465,72466,72467,72474,74581,72475,72476,74374,72477,74415,72478,72479,
		},
		max = 15,
	},
	{
		name_save = "BloodElfHeritageArmor",
		name_quest = "BloodElfHeritageArmor",-- = Horde_Icon.."Blood Elf Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			53791,53734,53882,53735,53736,53737,53738,53853,53725,54096,
		},
		max = 10,
	},
	{
		name_save = "GnomeHeritageArmor",
		name_quest = "GnomeHeritageArmor",-- = Alliance_Icon.."Gnome Heritage Armor",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			54402,54576,54577,54580,54581,54582,54639,54640,54850,54641,54642,
		},
		max = 11,
	},
	-- Allied Races Quests

	{
		name_save = "DarkIronDwarfHeritageArmorAllied",
		name_quest = "DarkIronDwarfHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			51483,
		},
		max = 1,
	},
	{
		name_save = "ZandalariTrollHeritageArmorAllied",
		name_quest = "ZandalariTrollHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			53721,
		},
		max = 1,
	},
	{
		name_save = "VulperaHeritageArmorAllied",
		name_quest = "VulperaHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			58435,
		},
		max = 1,
	},
	{
		name_save = "LightforgedDraeneiHeritageArmorAllied",
		name_quest = "LightforgedDraeneiHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			49782,
		},
		max = 1,
	},
	{
		name_save = "NightborneHeritageArmorAllied",
		name_quest = "NightborneHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			49784,
		},
		max = 1,
	},
	{
		name_save = "VoidElfHeritageArmorAllied",
		name_quest = "VoidElfHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			49928,
		},
		max = 1,
	},
	{
		name_save = "MechagnomeHeritageArmorAllied",
		name_quest = "MechagnomeHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			58436,
		},
		max = 1,
	},
	{
		name_save = "KulTiranHeritageArmorAllied",
		name_quest = "KulTiranHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			53722,
		},
		max = 1,
	},
	{
		name_save = "MagharOrcHeritageArmorAllied",
		name_quest = "MagharOrcHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			51484,
		},
		max = 1,
	},
	{
		name_save = "HighmountainTaurenHeritageArmorAllied",
		name_quest = "HighmountainTaurenHeritageArmorAllied",
		reset = "Once",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			49783,
		},
		max = 1,
	},




	{
		name_save = "HallowsEnd",
		name_quest = "HallowsEnd",
		reset = "Month",
		expansion = "DF",
		place = "",
		desc = "",
		questID = {
			12286,12331,12332,12333,12334,12335,12336,12337,12339,12340,12341,12342,12343,12344,12345,12347,12348,12349,12350,12351,12352,12353,12354,12355,12356,12357,12358,12359,12360,12361,12362,12363,12364,12365,12366,12367,12368,12369,12370,12371,12373,12374,12376,12377,12378,12380,12381,12382,12383,12384,12386,12387,12388,12389,12390,12391,12392,12393,12394,12395,12396,12397,12398,12399,12400,12401,12402,12403,12404,12406,12407,12408,12409,12940,12941,12944,12945,12946,12947,12950,13433,13434,13435,13436,13437,13438,13439,13448,13452,13456,13459,13460,13461,13462,13463,13464,13465,13466,13467,13468,13469,13470,13471,13472,13473,13474,13501,13548,28951,28952,28953,28954,28955,28956,28957,28958,28959,28960,28961,28962,28963,28964,28965,28966,28967,28968,28969,28970,28971,28972,28973,28974,28975,28976,28977,28978,28979,28980,28981,28982,28983,28984,28985,28986,28987,28988,28989,28990,28991,28992,28993,28994,28995,28996,28998,28999,29000,29001,29002,29003,29004,29005,29006,29007,29008,29009,29010,29011,29012,29013,29014,29016,29017,29018,29019,29020,29054,29144,29371,29374,29375,29377,32020,32021,32022,32023,32024,32026,32027,32028,32029,32031,32032,32033,32034,32036,32037,32039,32040,32041,32042,32043,32044,32046,32047,32048,32049,32050,32051,32052,39657,39719,43055,43056,43057,43259,54709,54710,75667,75668,75669,75670,75671,75672,75673,75674,75675,75676,75677,75678,75679,75681,75682,75683,75685,75686,75687,75688,75689,75690,75691,75692,75693,75695,75696,75697,75698,75699,75700,75701,75702,75703,75704,77698,
			75684,
		},
		max = 255,
	},









}



