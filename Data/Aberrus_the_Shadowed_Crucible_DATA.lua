local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Globals.TransmogCollectionType = {
	"Head", -- 1 Голова
	"Shoulder", -- 2 Плечи
	"Back", -- 3 Спина
	"Chest", -- 4 Грудь
	 -- "Shirt",
	 -- "Tabard",
	"Wrist", -- 7 Запястья
	"Hands", -- 8 Кисти рук
	"Waist", -- 9 Пояс
	"Legs", -- 10 Ноги
	"Feet", -- 11 Ботинки
}
E.Octo_Globals.difficultyName = {
	"LFR",
	"Normal",
	"Heroic",
	"Mythic",
}
-- TRANSMOG_COLLECTION_SOURCE_ADDED
-- TRANSMOG_SEARCH_UPDATE
-- TRANSMOG_COLLECTION_UPDATED
E.Octo_Globals.Aberrus_the_Shadowed_Crucible_DATA = {
	WARRIOR = {
		["Head"] = { -- Голова
			["LFR"] = 185918,
			["Normal"] = 186315,
			["Heroic"] = 185920,
			["Mythic"] = 185919,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186298,
			["Normal"] = 186306,
			["Heroic"] = 186299,
			["Mythic"] = 186300,
		},
		["Back"] = { -- Спина
			["LFR"] = 186327,
			["Normal"] = 184412,
			["Heroic"] = 186325,
			["Mythic"] = 186326,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186324,
			["Normal"] = 184420,
			["Heroic"] = 186322,
			["Mythic"] = 186323,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186667,
			["Normal"] = 185555,
			["Heroic"] = 186665,
			["Mythic"] = 186666,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186318,
			["Normal"] = 184418,
			["Heroic"] = 186316,
			["Mythic"] = 186317,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186673,
			["Normal"] = 184414,
			["Heroic"] = 186671,
			["Mythic"] = 186672,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186309,
			["Normal"] = 184570,
			["Heroic"] = 186307,
			["Mythic"] = 186308,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186321,
			["Normal"] = 184419,
			["Heroic"] = 186319,
			["Mythic"] = 186657,
		},
	},
	PALADIN = {
		["Head"] = { -- Голова
			["LFR"] = 185994,
			["Normal"] = 184426,
			["Heroic"] = 185995,
			["Mythic"] = 185996,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 185982,
			["Normal"] = 184424,
			["Heroic"] = 185983,
			["Mythic"] = 185984,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186011,
			["Normal"] = 184429,
			["Heroic"] = 186009,
			["Mythic"] = 186010,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 185981,
			["Normal"] = 184423,
			["Heroic"] = 186674,
			["Mythic"] = 186675,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 185993,
			["Normal"] = 184425,
			["Heroic"] = 185991,
			["Mythic"] = 185992,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186008,
			["Normal"] = 184428,
			["Heroic"] = 186006,
			["Mythic"] = 186007,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186670,
			["Normal"] = 184555,
			["Heroic"] = 186668,
			["Mythic"] = 185977,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186005,
			["Normal"] = 184427,
			["Heroic"] = 186003,
			["Mythic"] = 186004,
		},
		["Back"] = { -- Спина
			["LFR"] = 186014,
			["Normal"] = 184421,
			["Heroic"] = 186012,
			["Mythic"] = 186013,
		},
	},
	HUNTER = {
		["Head"] = { -- Голова
			["LFR"] = 186081,
			["Normal"] = 184563,
			["Heroic"] = 186082,
			["Mythic"] = 186083,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186069,
			["Normal"] = 186077,
			["Heroic"] = 186070,
			["Mythic"] = 186071,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186098,
			["Normal"] = 184456,
			["Heroic"] = 186096,
			["Mythic"] = 186097,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186540,
			["Normal"] = 185560,
			["Heroic"] = 186538,
			["Mythic"] = 186539,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186080,
			["Normal"] = 184452,
			["Heroic"] = 186078,
			["Mythic"] = 186079,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186095,
			["Normal"] = 184455,
			["Heroic"] = 186093,
			["Mythic"] = 186094,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186065,
			["Normal"] = 184449,
			["Heroic"] = 186063,
			["Mythic"] = 186064,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186092,
			["Normal"] = 184454,
			["Heroic"] = 186090,
			["Mythic"] = 186091,
		},
		["Back"] = { -- Спина
			["LFR"] = 186098,
			["Normal"] = 184456,
			["Heroic"] = 186096,
			["Mythic"] = 186097,
		},
	},
	ROGUE = {
		["Head"] = { -- Голова
			["LFR"] = 186122,
			["Normal"] = 184575, -- 186650 186651
			["Heroic"] = 186650, -- 186120
			["Mythic"] = 186121,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186108,
			["Normal"] = 184469,
			["Heroic"] = 186109,
			["Mythic"] = 186110,
		},
		["Back"] = { -- Спина
			["LFR"] = 186134,
			["Normal"] = 184466,
			["Heroic"] = 186132,
			["Mythic"] = 186133,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186131,
			["Normal"] = 184474,
			["Heroic"] = 186129,
			["Mythic"] = 186130,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186104,
			["Normal"] = 184567,
			["Heroic"] = 186611,
			["Mythic"] = 186612,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186125,
			["Normal"] = 184472,
			["Heroic"] = 186123,
			["Mythic"] = 186124,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186107,
			["Normal"] = 184472,
			["Heroic"] = 186105,
			["Mythic"] = 186106,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186119,
			["Normal"] = 184470,
			["Heroic"] = 186117,
			["Mythic"] = 186118,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186128,
			["Normal"] = 184473,
			["Heroic"] = 186608,
			["Mythic"] = 186127,
		},
	},
	PRIEST = {
		["Head"] = { -- Голова
			["LFR"] = 186244,
			["Normal"] = 184516,
			["Heroic"] = 186245,
			["Mythic"] = 186246,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186228,
			["Normal"] = 184514,
			["Heroic"] = 186229,
			["Mythic"] = 186230,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186233,
			["Normal"] = 184519,
			["Heroic"] = 186231,
			["Mythic"] = 186232,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186227,
			["Normal"] = 184513,
			["Heroic"] = 186225,
			["Mythic"] = 186226,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186243,
			["Normal"] = 184515,
			["Heroic"] = 186502,
			["Mythic"] = 186503,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186258,
			["Normal"] = 184518,
			["Heroic"] = 186256,
			["Mythic"] = 186257,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186224, -- 186474
			["Normal"] = 185558,
			["Heroic"] = 186472,
			["Mythic"] = 186473,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186255,
			["Normal"] = 184517,
			["Heroic"] = 186253,
			["Mythic"] = 186254,
		},
		["Back"] = { -- Спина
			["LFR"] = 186221,
			["Normal"] = 184511, -- 185606
			["Heroic"] = 186219, -- 186699
			["Mythic"] = 186700, -- 186220 -- ПИЗДА
		},
	},
	SHAMAN = {
		["Head"] = { -- Голова
			["LFR"] = 186042,
			["Normal"] = 186050,
			["Heroic"] = 186043,
			["Mythic"] = 186044,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186030,
			["Normal"] = 186038,
			["Heroic"] = 186031,
			["Mythic"] = 186032,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186059,
			["Normal"] = 184447,
			["Heroic"] = 186057,
			["Mythic"] = 186058,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186023,
			["Normal"] = 184441,
			["Heroic"] = 186021,
			["Mythic"] = 186022,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186041,
			["Normal"] = 184443,
			["Heroic"] = 186039,
			["Mythic"] = 186040,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186555,
			["Normal"] = 184561,
			["Heroic"] = 186553,
			["Mythic"] = 186554,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186020,
			["Normal"] = 184440,
			["Heroic"] = 186018,
			["Mythic"] = 186019,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186525,
			["Normal"] = 186556,
			["Heroic"] = 186523,
			["Mythic"] = 186524,
		},
		["Back"] = { -- Спина
			["LFR"] = 186062,
			["Normal"] = 184439,
			["Heroic"] = 186060,
			["Mythic"] = 186061,
		},
	},
	MAGE = {
		["Head"] = { -- Голова
			["LFR"] = 186354,
			["Normal"] = 184525,
			["Heroic"] = 186352,
			["Mythic"] = 186353,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186340,
			["Normal"] = 186348,
			["Heroic"] = 186341,
			["Mythic"] = 186342,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186363,
			["Normal"] = 184528,
			["Heroic"] = 186361,
			["Mythic"] = 186362,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186331,
			["Normal"] = 184522,
			["Heroic"] = 186332,
			["Mythic"] = 186333,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186351,
			["Normal"] = 184524,
			["Heroic"] = 186349,
			["Mythic"] = 186350,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186360,
			["Normal"] = 184527,
			["Heroic"] = 186358,
			["Mythic"] = 186359,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186330,
			["Normal"] = 184521,
			["Heroic"] = 186328,
			["Mythic"] = 186329,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186357,
			["Normal"] = 184526,
			["Heroic"] = 186355,
			["Mythic"] = 186356,
		},
		["Back"] = { -- Спина
			["LFR"] = 187865,
			["Normal"] = 184520,
			["Heroic"] = 187863,
			["Mythic"] = 187864,
		},
	},
	WARLOCK = {
		["Head"] = { -- Голова
			["LFR"] = 186204,
			["Normal"] = 186212,
			["Heroic"] = 186205,
			["Mythic"] = 186206,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186189,
			["Normal"] = 186197,
			["Heroic"] = 186190,
			["Mythic"] = 186191,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186200,
			["Normal"] = 184510,
			["Heroic"] = 186198,
			["Mythic"] = 186199,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186465,
			["Normal"] = 184562,
			["Heroic"] = 186463,
			["Mythic"] = 186464,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186203,
			["Normal"] = 184506,
			["Heroic"] = 186201,
			["Mythic"] = 186202,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186218,
			["Normal"] = 184509,
			["Heroic"] = 186216,
			["Mythic"] = 186217,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186185,
			["Normal"] = 184503,
			["Heroic"] = 186183,
			["Mythic"] = 186184,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186215,
			["Normal"] = 184508,
			["Heroic"] = 186213,
			["Mythic"] = 186214,
		},
		["Back"] = { -- Спина
			["LFR"] = 186182,
			["Normal"] = 184502,
			["Heroic"] = 186180,
			["Mythic"] = 186181,
		},
	},
	MONK = {
		["Head"] = { -- Голова
			["LFR"] = 185777,
			["Normal"] = 184480,
			["Heroic"] = 185778,
			["Mythic"] = 185779,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 185771,
			["Normal"] = 184478,
			["Heroic"] = 185772,
			["Mythic"] = 185773,
		},
		["Back"] = { -- Спина
			["LFR"] = 186017,
			["Normal"] = 184475,
			["Heroic"] = 186015,
			["Mythic"] = 186016,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 185786,
			["Normal"] = 184483,
			["Heroic"] = 185787,
			["Mythic"] = 185788,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 185765,
			["Normal"] = 184476,
			["Heroic"] = 185766,
			["Mythic"] = 185767,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 185780,
			["Normal"] = 184560,
			["Heroic"] = 185781,
			["Mythic"] = 185782, -- 186627
		},
		["Waist"] = { -- Пояс
			["LFR"] = 185768,
			["Normal"] = 184477,
			["Heroic"] = 185769,
			["Mythic"] = 185770,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 185774,
			["Normal"] = 184479,
			["Heroic"] = 185775,
			["Mythic"] = 185776,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 185783,
			["Normal"] = 184482,
			["Heroic"] = 185784,
			["Mythic"] = 185785,
		},
	},
	DRUID = {
		["Head"] = { -- Голова
			["LFR"] = 186159,
			["Normal"] = 186167, -- 184489 186162 186163 186164 186165 186166 186167
			["Heroic"] = 186160,
			["Mythic"] = 186161,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186147,
			["Normal"] = 186155, -- 184487 186150 186151 186152 186153 186154 186155
			["Heroic"] = 186148,
			["Mythic"] = 186149,
		},
		["Back"] = { -- Спина
			["LFR"] = 186179,
			["Normal"] = 184484,
			["Heroic"] = 186177,
			["Mythic"] = 186178,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186176,
			["Normal"] = 184492,
			["Heroic"] = 186174,
			["Mythic"] = 186175,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186137,
			["Normal"] = 184485,
			["Heroic"] = 186135,
			["Mythic"] = 186136,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186170,
			["Normal"] = 184490,
			["Heroic"] = 186168,
			["Mythic"] = 186169,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186138,
			["Normal"] = 184486,
			["Heroic"] = 186139,
			["Mythic"] = 186140,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186158,
			["Normal"] = 184488,
			["Heroic"] = 186156,
			["Mythic"] = 186157,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186173, -- 186607
			["Normal"] = 184547,
			["Heroic"] = 186171,
			["Mythic"] = 186172,
		},
	},
	DEMONHUNTER = {
		["Head"] = { -- Голова
			["LFR"] = 186427,
			["Normal"] = 186435, -- 186430 186431 186432 186433 186434 186435
			["Heroic"] = 186428,
			["Mythic"] = 186429,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186415,
			["Normal"] = 186423, -- 186418 186419 186420 186421 186422
			["Heroic"] = 186416,
			["Mythic"] = 186417,
		},
		["Back"] = { -- Спина
			["LFR"] = 186447,
			["Normal"] = 184493,
			["Heroic"] = 186445,
			["Mythic"] = 186446,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186444,
			["Normal"] = 184501,
			["Heroic"] = 186442,
			["Mythic"] = 186443,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186411,
			["Normal"] = 184494,
			["Heroic"] = 186409,
			["Mythic"] = 186410,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186438,
			["Normal"] = 184499,
			["Heroic"] = 186436,
			["Mythic"] = 186437,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186414,
			["Normal"] = 185562,
			["Heroic"] = 186412, -- 186623
			["Mythic"] = 186413, -- 186624
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186426,
			["Normal"] = 184497,
			["Heroic"] = 186424,
			["Mythic"] = 186425,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186441,
			["Normal"] = 184500,
			["Heroic"] = 186439,
			["Mythic"] = 186440,
		},
	},
	DEATHKNIGHT = {
		["Head"] = { -- Голова
			["LFR"] = 186279,
			["Normal"] = 187672,
			["Heroic"] = 186277,
			["Mythic"] = 186278,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186285, --186285,
			["Normal"] = 187684,
			["Heroic"] = 186283,
			["Mythic"] = 186284,
		},
		["Back"] = { -- Спина
			["LFR"] = 186264,
			["Normal"] = 184430,
			["Heroic"] = 186262,
			["Mythic"] = 186263,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186685, --?
			["Normal"] = 184572,
			["Heroic"] = 186683, --?
			["Mythic"] = 186684,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186261,
			["Normal"] = 184431,
			["Heroic"] = 186259,
			["Mythic"] = 1862260,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186276,
			["Normal"] = 184436,
			["Heroic"] = 186274,
			["Mythic"] = 186275,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186273,
			["Normal"] = 185590,
			["Heroic"] = 186271,
			["Mythic"] = 186272,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186282,
			["Normal"] = 184434,
			["Heroic"] = 186280,
			["Mythic"] = 186281,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186270,
			["Normal"] = 184437,
			["Heroic"] = 186653,
			["Mythic"] = 186654,
		},
	},
	EVOKER = {
		["Head"] = { -- Голова
			["LFR"] = 186388,
			["Normal"] = 186396,
			["Heroic"] = 186389,
			["Mythic"] = 186390,
		},
		["Shoulder"] = { -- Плечи
			["LFR"] = 186376,
			["Normal"] = 186384,
			["Heroic"] = 186377,
			["Mythic"] = 186378,
		},
		["Chest"] = { -- Грудь
			["LFR"] = 186405,
			["Normal"] = 184465,
			["Heroic"] = 186403,
			["Mythic"] = 186404,
		},
		["Waist"] = { -- Пояс
			["LFR"] = 186367,
			["Normal"] = 186375,
			["Heroic"] = 186368,
			["Mythic"] = 186369,
		},
		["Legs"] = { -- Ноги
			["LFR"] = 186522,
			["Normal"] = 184557,
			["Heroic"] = 186520,
			["Mythic"] = 186521,
		},
		["Feet"] = { -- Ботинки
			["LFR"] = 186558,
			["Normal"] = 185582,
			["Heroic"] = 186556,
			["Mythic"] = 186557,
		},
		["Wrist"] = { -- Запястья
			["LFR"] = 186366,
			["Normal"] = 184458,
			["Heroic"] = 186364,
			["Mythic"] = 186365,
		},
		["Hands"] = { -- Кисти рук
			["LFR"] = 186399,
			["Normal"] = 184463,
			["Heroic"] = 186397,
			["Mythic"] = 186398,
		},
		["Back"] = { -- Спина
			["LFR"] = 186408,
			["Normal"] = 184457,
			["Heroic"] = 186406,
			["Mythic"] = 186407,
		},
	},
}
E.Octo_Globals.Aberrus_the_Shadowed_Crucible_DATA_ITEMID = {
    WARRIOR = {
        ["LFR"] = {
            ["Head"] = 202443, -- Голова
            ["Shoulder"] = 202441, -- Плечи
            ["Back"] = 202438, -- Спина
            ["Chest"] = 202446, -- Грудь
            ["Wrist"] = 204390, -- Запястья
            ["Hands"] = 202444, -- Кисти рук
            ["Waist"] = 202577, -- пояс
            ["Legs"] = 202442, -- Ноги
            ["Feet"] = 202445, -- Ботинки
        },
        ["Normal"] = {
            ["Head"] = 202443,
            ["Shoulder"] = 204431,
            ["Back"] = 202438,
            ["Chest"] = 202446,
            ["Wrist"] = 204390,
            ["Hands"] = 202444,
            ["Waist"] = 202440,
            ["Legs"] = 202597,
            ["Feet"] = 202445,
        },
        ["Heroic"] = {
            ["Head"] = 202443,
            ["Shoulder"] = 202441,
            ["Back"] = 202438,
            ["Chest"] = 202446,
            ["Wrist"] = 202439,
            ["Hands"] = 202444,
            ["Waist"] = 202577,
            ["Legs"] = 202442,
            ["Feet"] = 202445,
        },
        ["Mythic"] = {
            ["Head"] = 202443,
            ["Shoulder"] = 202441,
            ["Back"] = 202438,
            ["Chest"] = 202446,
            ["Wrist"] = 202439,
            ["Hands"] = 202444,
            ["Waist"] = 202577,
            ["Legs"] = 202442,
            ["Feet"] = 204396,
        },
    },
}

E.Octo_Globals.InventoryType = {
	"Non-equippable", -- 0 IndexNonEquipType INVTYPE_NON_EQUIP
	"Head", -- 1 IndexHeadType INVTYPE_HEAD
	"Neck", -- 2 IndexNeckType INVTYPE_NECK
	"Shoulder", -- 3 IndexShoulderType INVTYPE_SHOULDER
	"Shirt", -- 4 IndexBodyType INVTYPE_BODY
	"Chest", -- 5 IndexChestType INVTYPE_CHEST
	"Waist", -- 6 IndexWaistType INVTYPE_WAIST
	"Legs", -- 7 IndexLegsType INVTYPE_LEGS
	"Feet", -- 8 IndexFeetType INVTYPE_FEET
	"Wrist", -- 9 IndexWristType INVTYPE_WRIST
	"Hands", -- 10 IndexHandType INVTYPE_HAND
	"Finger", -- 11 IndexFingerType INVTYPE_FINGER
	"Trinket", -- 12 IndexTrinketType INVTYPE_TRINKET
	"One-Hand", -- 13 IndexWeaponType INVTYPE_WEAPON
	"Off Hand", -- 14 IndexShieldType INVTYPE_SHIELD
	"Ranged", -- 15 IndexRangedType INVTYPE_RANGED
	"Back", -- 16 IndexCloakType INVTYPE_CLOAK
	"Two-Hand", -- 17 Index2HweaponType INVTYPE_2HWEAPON
	"Bag", -- 18 IndexBagType INVTYPE_BAG
	"Tabard", -- 19 IndexTabardType INVTYPE_TABARD
	"Chest", -- 20 IndexRobeType INVTYPE_ROBE
	"Main Hand", -- 21 IndexWeaponmainhandType INVTYPE_WEAPONMAINHAND
	"Off Hand", -- 22 IndexWeaponoffhandType INVTYPE_WEAPONOFFHAND
	"Held In Off-hand", -- 23 IndexHoldableType INVTYPE_HOLDABLE
	"Ammo", -- 24 IndexAmmoType INVTYPE_AMMO
	"Thrown", -- 25 IndexThrownType INVTYPE_THROWN
	"Ranged", -- 26 IndexRangedrightType INVTYPE_RANGEDRIGHT
	"Quiver", -- 27 IndexQuiverType INVTYPE_QUIVER
	"Relic", -- 28 IndexRelicType INVTYPE_RELIC
	"Profession Tool", -- 29 IndexProfessionToolType INVTYPE_PROFESSION_TOOL
	"Profession Equipment", -- 30 IndexProfessionGearType INVTYPE_PROFESSION_GEAR
	"Equipable Spell - Offensive", -- 31 IndexEquipablespellOffensiveType INVTYPE_EQUIPABLESPELL_OFFENSIVE
	"Equipable Spell - Utility", -- 32 IndexEquipablespellUtilityType INVTYPE_EQUIPABLESPELL_UTILITY
	"Equipable Spell - Defensive", -- 33 IndexEquipablespellDefensiveType INVTYPE_EQUIPABLESPELL_DEFENSIVE
	"Equipable Spell - Weapon", -- 34 IndexEquipablespellWeaponType INVTYPE_EQUIPABLESPELL_WEAPON
}