local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
function E:func_Universal_08_BattleforAzeroth()
	local OctoTable_Universal = {
		{

			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "BattleforAzeroth",
			quests = {
				{52196},
				{52169},
				{52181},
				{52166},
				{52163},
				{52157},
				{52848},
				{52847},
				{54895},
				{54896},
				{58705},
				{55466},
				{56057},
				{56056},
			},
			forcedMaxQuest = 4,
		},
		{

			showTooltip = true,
			textleft = E.Timers.BfA_Invasion(),
			name_save = "InvasionQuests",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{54134},
				{54136},
				{53711},
				{53701},
				{54138},
				{51982},
				{53883},
				{54137},
				{53885},
				{53939},
				{54135},
				{54132},
			},
			forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = E.Timers.BfA_Assault().."AssaultTheBlackEmpire",
			name_save = "AssaultTheBlackEmpire",
			reset = "Weekly",
			desc = "BattleforAzeroth",
			quests = {
				{56064},
				{57728},
				{55350},
				{57157},
			},
			forcedMaxQuest = 2,
		},
		{

			showTooltip = true,
			textleft = "miniVision",
			name_save = "miniVision",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{58168},
				{58155},
				{58151},
				{58167},
				{58156},
			},
			forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "Warfront: Stromgarde",
			name_save = "WarfrontStromgarde",
			reset = "Weekly",
			desc = "BattleforAzeroth",
			quests = {
				{53416, faction = "Horde"},
				{53414, faction = "Alliance"},
			},
			 -- forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "Warfront: Darkshore",
			name_save = "WarfrontDarkshore",
			reset = "Weekly",
			desc = "BattleforAzeroth",
			quests = {
				{53955, faction = "Horde"},
				{53992, faction = "Alliance"},
			},
			 -- forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "Warfront: Heroic",
			name_save = "WarfrontHeroic",
			reset = "Weekly",
			desc = "BattleforAzeroth",
			quests = {
				{56137, faction = "Horde"},
				{57959, faction = "Horde"},
				{56136, faction = "Alliance"},
				{57960, faction = "Alliance"},
			},
			forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "DarkshoreRares",
			name_save = "DarkshoreRares",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				-- Alash'anir
				{54695, faction = "Alliance", forcedText = {npcID = 148787},},
				{54696, faction = "Horde", forcedText = {npcID = 148787},},

				-- Aman
				{54405, faction = "Alliance",forcedText = {npcID = 147966},},
				{54406, faction = "Horde", forcedText = {npcID = 147966},},

				-- Amberclaw
				{54285, faction = "Alliance",forcedText = {npcID = 147744},},
				{54286, faction = "Horde", forcedText = {npcID = 147744},},

				-- Athrikus Narassin
				{54278, faction = "Alliance",forcedText = {npcID = 147708},},
				{54279, faction = "Horde", forcedText = {npcID = 147708},},

				-- Commander Ral'esh
				{54426, faction = "Alliance",forcedText = {npcID = 148025},},
				{54427, faction = "Horde", forcedText = {npcID = 148025},},

				-- Conflagros
				{54232, faction = "Alliance",forcedText = {npcID = 147260},},
				{54233, faction = "Horde", forcedText = {npcID = 147260},},

				-- Cyclarus
				{54229, faction = "Alliance",forcedText = {npcID = 147241},},
				{54230, faction = "Horde", forcedText = {npcID = 147241},},

				-- Glimmerspine
				{54884, faction = "Alliance", forcedText = {npcID = 149654},},
				{54885, faction = "Horde", forcedText = {npcID = 149654},},


				-- Granokk
				{54234, faction = "Alliance",forcedText = {npcID = 147261},},
				{54235, faction = "Horde", forcedText = {npcID = 147261},},

				-- Gren Tornfur
				{54428, faction = "Alliance",forcedText = {npcID = 148031},},
				{54429, faction = "Horde", forcedText = {npcID = 148031},},

				-- Hydrath
				{54227, faction = "Alliance",forcedText = {npcID = 147240},},
				{54228, faction = "Horde", forcedText = {npcID = 147240},},

				-- Madfeather
				{54887, faction = "Alliance",forcedText = {npcID = 149657},},
				{54888, faction = "Horde", forcedText = {npcID = 149657},},

				-- Mrggr'marr
				{54408, faction = "Alliance",forcedText = {npcID = 147970},},
				{54409, faction = "Horde", forcedText = {npcID = 147970},},

				-- Scalefiend
				{54893, faction = "Alliance",forcedText = {npcID = 149665},},
				{54894, faction = "Horde", forcedText = {npcID = 149665},},

				-- Shattershard
				{54289, faction = "Alliance", forcedText = {npcID = 147751},},
				{54290, faction = "Horde", forcedText = {npcID = 147751},},

				-- Soggoth the Slitherer
				{54320, faction = "Alliance",forcedText = {npcID = 147897},},
				{54321, faction = "Horde", forcedText = {npcID = 147897},},

				-- Stonebinder Ssra'vess
				{54247, faction = "Alliance",forcedText = {npcID = 147332},},
				{54248, faction = "Horde", forcedText = {npcID = 147332},},

				-- Twilight Prophet Graemeа
				{54397, faction = "Alliance",forcedText = {npcID = 147942},},
				{54398, faction = "Horde", forcedText = {npcID = 147942},},

				-- Athil Dewfire
				{54431, faction = "Horde", forcedText = {npcID = 148037},},  -- УБИЛ ОРДОЙ 54892
				-- Blackpaw
				{54890, faction = "Horde", forcedText = {npcID = 149660},}, -- УБИЛ ОРДОЙ
				-- Grimhorn
				{54891, faction = "Horde", forcedText = {npcID = 149662},},
				-- Onu
				{54291, faction = "Horde", forcedText = {npcID = 147758},},  -- УБИЛ ОРДОЙ 54892
				-- Sapper Odette
				{54452, faction = "Horde", forcedText = {npcID = 148103},},  -- УБИЛ ОРДОЙ 54892
				-- Shadowclaw
				{54892, faction = "Horde", forcedText = {npcID = 149663},}, -- УБИЛ ОРДОЙ 54892
				-- Thelar Moonstrike
				{54252, faction = "Horde", forcedText = {npcID = 147435},},




				-- Agathe Wyrmwood
				{54883, faction = "Alliance", forcedText = {npcID = 149517},},
				-- Burninator Mark V
				{54768, faction = "Alliance", forcedText = {npcID = 149141},},
				-- Commander Drald
				{54309, faction = "Alliance", forcedText = {npcID = 147845},},
				-- Croz Bloodrage
				{54886, faction = "Alliance", forcedText = {npcID = 149655},},
				-- Moxo the Beheader
				{54277, faction = "Alliance", forcedText = {npcID = 147701},},
				-- Orwell Stevenson
				{54889, faction = "Alliance", forcedText = {npcID = 149659},},  -- 149664
				-- Zim'kaga
				{54274, faction = "Alliance", forcedText = {npcID = 147664},},
			},
			-- forcedMaxQuest = 25,
		},
		{

			showTooltip = true,
			textleft = "MechagonRares",
			name_save = "MechagonRares",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{55512}, -- MOUNT
				{55539},
				{55857},
				{55537},
				{56368},
				{55812},
				{55514},
				{55814},
				{56207},
				{55513},
				{55367},
				{55852},
				{55855},
				{56367},
				{55399},
				{55369},
				{55544},
				{55207},
				{55386},
				{55859},
				{55853},
				{55515},
				{55856},
				{55405},
				{55368},
				{55811}, -- MOUNT
				{56737},
				{55545},
				{55810},
				{55854},
				{56419},
				{55858},
				{56182},
				{55364},
				{55538},
				{55546},
				{56298}, -- MOUNT NEW???? https://wago.io/G7SoF6Zix
			},
			forcedMaxQuest = 36+1,
		},
		{

			showTooltip = true,
			textleft = "MechagonTREASURE",
			name_save = "MechagonTREASURE",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{55547},
				{55548},
				{55549},
				{55550},
				{55551},
				{55552},
				{55553},
				{55554},
				{55555},
				{55556},
			},
			forcedMaxQuest = 10,
		},
		{

			showTooltip = true,
			textleft = "MechagonTREASURE_MISCELLANEOUS",
			name_save = "MechagonTREASURE_MISCELLANEOUS",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{55743},
				{56117},
				{57134},
			},
			forcedMaxQuest = 3,
		},
		{

			showTooltip = true,
			textleft = "MechagonLOCKED_CHESTS1",
			name_save = "MechagonLOCKED_CHESTS1",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{56907},
			},
			forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "MechagonLOCKED_CHESTS2",
			name_save = "MechagonLOCKED_CHESTS2",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{57133},
			},
			forcedMaxQuest = 1,
		},
		{

			showTooltip = true,
			textleft = "UNLOCKING MECHAGON PART 1 ALLIANCE",
			name_save = "UNLOCKING MECHAGON PART 1 ALLIANCE",
			reset = "Once",
			desc = "BattleforAzeroth",
			 -- forcedMaxQuest = "all",
			quests = {
				{56031, faction = "Alliance"},
				{56043, faction = "Alliance"},
				{55095, faction = "Alliance"},
				{54969, faction = "Alliance"},
				{56640, faction = "Alliance"},
				{56641, faction = "Alliance"},
				{56642, faction = "Alliance"},
				{56643, faction = "Alliance"},
				{56644, faction = "Alliance"},
				{55175, faction = "Alliance"},
				{54972, faction = "Alliance"},

				{56030, faction = "Horde"},
				{56044, faction = "Horde"},
				{55054, faction = "Horde"},
				{54018, faction = "Horde"},
				{54021, faction = "Horde"},
				{54012, faction = "Horde"},
				{55092, faction = "Horde"},
				{56063, faction = "Horde"},
				{54015, faction = "Horde"},
				{56429, faction = "Horde"},
				{55094, faction = "Horde"},
				{55053, faction = "Horde"},
			},
		},
		{
			showTooltip = true,
			textleft = "UNLOCKING MECHAGON PART 2",
			name_save = "UNLOCKING MECHAGON PART 2",
			reset = "Once",
			desc = "BattleforAzeroth",
			 -- forcedMaxQuest = "all",
			quests = {
				{55851},
				{55533},
				{55374},
				{55400},
				{55407},
				{55425},
				{55497},
				{55618},
				{57010},
				{56162, faction = "Alliance"},
				{56350, faction = "Alliance"},
				{55361, faction = "Alliance"},
				{55363, faction = "Alliance"},
				{56156, faction = "Alliance"},

				{56161, faction = "Horde"},
				{55481, faction = "Horde"},
				{55384, faction = "Horde"},
				{55385, faction = "Horde"},
				{55500, faction = "Horde"},
			},
			 -- forcedMaxQuest = "all",
		},

		{

			showTooltip = true,
			textleft = "THE MECHAGONIAN THREAT",
			name_save = "THE MECHAGONIAN THREAT",
			reset = "Once",
			desc = "BattleforAzeroth",
			quests = {
				 -- Только для Альянса
				{54088, faction = "Alliance"},
				{55040, faction = "Alliance"},
				{54945, faction = "Alliance"},
				{54087, faction = "Alliance"},
				{54946, faction = "Alliance"},
				{54947, faction = "Alliance"},
				{54992, faction = "Alliance"},
				{55645, faction = "Alliance"},
				 -- Только для Орды
				{55646, faction = "Horde"},
				{55647, faction = "Horde"},
				{55648, faction = "Horde"},
				{55630, faction = "Horde"},
				{55632, faction = "Horde"},
				{55649, faction = "Horde"},
				{55650, faction = "Horde"},
				{55651, faction = "Horde"},
				{55652, faction = "Horde"},
				{55685, faction = "Horde"},
				 -- Общие квесты
				{55730},
				{55731},
				{55995},
				{55734},
				{55096},
				{55736},
				{55609},
			},
		},





		{

			showTooltip = true,
			textleft = "DAILY_VISITOR_QUESTS",
			name_save = "DAILY_VISITOR_QUESTS",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{56493},
				{56558, faction = "Alliance",},
				{56552, faction = "Horde"},
				{55688},
				{55575},
				{55672},
				{56184},
				{55905},
				{56469},
				{56142},
				{55528},
				{55463},
				{55885},
				{55813},
				{55718},
				{56355},
				{56501},
				{56365},
				{55717},
				{55765},
				{56306},
				{55658},
				{56053},
				{56405},
				{55816},
				{56049},
				{54090},
				{56410},
				{56572},
				{56301},
				{56471},
				{56523},
				{56508},
			},
			 -- forcedMaxQuest = 32,
		},
		{

			showTooltip = true,
			textleft = "MechagonDAILYQUESTS",
			name_save = "MechagonDAILYQUESTS",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				 -- 56326,
				 -- 56334,
				{56328},
				 -- 54090,
				 -- 55905,
				 -- 55463,
				 -- 56405,
				{56139}, -- WQ
				{56405},
				{56410},
				{56419},
				{55816},
				{55463},
				{55658},
				{55743},
				{55765},
				{55213},
				{54090},
				{56572},
				{56523},
				{55299},
				{56746},
				{55575},
				{56532},
				{56469},
				{56306},
				{56552},
				{55378},
				{56621},
				{56365},
				{56326},
				{56557},
				{57327},
				{56083},
				{55717},
				{56501},
				{56301},
				{55672},
				{56362},
				{55718},
				{56558},
				{55305},
				{56142},
				{55310},
				{55994},
				{56559},
				{56184},
				{55307},
				{56763},
				{56761},
				{56508},
				{55311},
				{55880},
				{56573},
				{55382},
				{55849},
				{55813},
				{55688},
				{56434},
				{55528},
				{56758},
				{56471},
				{56765},
				{57326},
				{56751},
				{56762},
				{56380},
				{56363},
				{55309},
				{56327},
				{56053},
				{56760},
				{56759},
				{56373},
				{55695},
				{56749},
				{56361},
				{56757},
				{55383},
				{55905},
				{56754},
				{55380},
				{56334},
				{55308},
				{56755},
				{56082},
				{55381},
				{56493},
				{54082},
				{56752},
				{55306},
				{55379},
				{56049},
				{56753},
				{55312},
				{55885},
				{56747},
				{56355},
				{56750},
				{55313},
				{56364},
				{55742},
			},
			forcedMaxQuest = 7,
		},
		{

			showTooltip = true,
			textleft = "MechagonSecretFish",
			name_save = "MechagonSecretFish",
			reset = "Daily",
			desc = "BattleforAzeroth",
			quests = {
				{55309},
				{55299},
				{55310},
				{55306},
				{55307},
				{55313},
				{55308},
				{55312},
				{55305},
				{55311},
			},
			forcedMaxQuest = 10,
		},
	}
	return OctoTable_Universal
end