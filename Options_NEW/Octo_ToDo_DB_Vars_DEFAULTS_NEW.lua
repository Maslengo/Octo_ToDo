local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------

E.Octo_ToDo_DB_Vars_DEFAULTS_NEW = { -- Octo_DevTool_DB
	["PLAYERS"] = {
		{
			name = L["Config_LevelToShow"],
			variableKey = "Config_LevelToShow",
			defaultValue = 1,
			minValue = 1,
			maxValue = 90,
			step = 1,
		},
		{
			name = L["Config_LevelToShowMAX"],
			variableKey = "Config_LevelToShowMAX",
			defaultValue = 1,
			minValue = 1,
			maxValue = 90,
			step = 1,
		},
		{
			name = L["isOnlyCurrentBtag"],
			variableKey = "isOnlyCurrentBtag",
			defaultValue = false,
		},
		{
			name = L["ShowOnlyCurrentRegion"],
			variableKey = "ShowOnlyCurrentRegion",
			defaultValue = false,
		},
		{
			name = L["isOnlyCurrentServer"],
			variableKey = "isOnlyCurrentServer",
			defaultValue = false,
		},
		{
			name = L["isOnlyCurrentFaction"],
			variableKey = "isOnlyCurrentFaction",
			defaultValue = false,
		},
	},
	["OTHER"] = {
		{
			name = L["Config_DebugID_ALL"],
			variableKey = "Config_DebugID_ALL",
			defaultValue = false,
		},
		{
			name = L["Config_ADDON_HEIGHT"],
			variableKey = "Config_ADDON_HEIGHT",
			defaultValue = 20,
			minValue = 10,
			maxValue = 30,
			step = 1,
		},
		{
			name = L["Config_ClampedToScreen"],
			variableKey = "Config_ClampedToScreen",
			defaultValue = false,
		},
		{
			name = L["CONFIG_RAIDS_DIFFICULTIES_ALL"],
			variableKey = "CONFIG_RAIDS_DIFFICULTIES_ALL",
			defaultValue = true,
		},
		{
			name = L["CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS"],
			variableKey = "CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS",
			defaultValue = true,
		},
		{
			name = L["Config_MountsInTooltip"],
			variableKey = "Config_MountsInTooltip",
			defaultValue = false,
		},
		{
			name = L["CONFIG_SPAM_TIME"],
			variableKey = "CONFIG_SPAM_TIME",
			defaultValue = 2,
			minValue = 1,
			maxValue = 10,
			step = 1,
		},
		{
			name = L["CONFIG_ACHIEVEMENT_SHOW_COMPLETED"],
			variableKey = "CONFIG_ACHIEVEMENT_SHOW_COMPLETED",
			defaultValue = true,
		},
		{
			name = L["Currencies"],
			variableKey = "Currencies",
			defaultValue = false,
		},
	},
	["ITEMS"] = {
		{
			name = L["CONFIG_ITEMS_COLOREDNAME"],
			variableKey = "CONFIG_ITEMS_COLOREDNAME",
			defaultValue = true,
		},
		{
			name = L["CONFIG_ITEMS_ICON"],
			variableKey = "CONFIG_ITEMS_ICON",
			defaultValue = true,
		},
	},
	["CURRENCY"] = {
		{
			name = L["CONFIG_CURRENCY_ICON"],
			variableKey = "CONFIG_CURRENCY_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_CURRENCY_WARBAND_ICON"],
			variableKey = "CONFIG_CURRENCY_WARBAND_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_CURRENCY_COLOREDNAME"],
			variableKey = "CONFIG_CURRENCY_COLOREDNAME",
			defaultValue = true,
		},
		{
			name = L["CONFIG_CURRENCY_SHOW_BRACKETS"],
			variableKey = "CONFIG_CURRENCY_SHOW_BRACKETS",
			defaultValue = false,
		},
		{
			name = L["CONFIG_CURRENCY_COLOR_BRACKETS"],
			variableKey = "CONFIG_CURRENCY_COLOR_BRACKETS",
			defaultValue = E.COLOR_ADDON_LEFT:gsub("^|cff", ""),
			TYPE = "colorPicker",
		},
		{
			name = L["CONFIG_CURRENCY_SHOW_REMAINING"],
			variableKey = "CONFIG_CURRENCY_SHOW_REMAINING",
			defaultValue = false,
		},
		{
			name = L["CONFIG_CURRENCY_COLOR_REMAINING"],
			variableKey = "CONFIG_CURRENCY_COLOR_REMAINING",
			defaultValue = E.COLOR_ADDON_RIGHT:gsub("^|c", ""),
			TYPE = "colorPicker",
		},
		{
			name = L["CONFIG_CURRENCY_SHOW_ZERO"],
			variableKey = "CONFIG_CURRENCY_SHOW_ZERO",
			defaultValue = false,
		},
		{
			name = L["CONFIG_CURRENCY_COLOR_ZERO"],
			variableKey = "CONFIG_CURRENCY_COLOR_ZERO",
			defaultValue = E.COLOR_GRAY:gsub("^|c", ""),
			TYPE = "colorPicker",
		},
	},
	["REPUTATIONS"] = {
		{
			name = L["CONFIG_REPUTATION_ICON"],
			variableKey = "CONFIG_REPUTATION_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_EXTRA_ICON"],
			variableKey = "CONFIG_REPUTATION_EXTRA_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_FACTION_ICON"],
			variableKey = "CONFIG_REPUTATION_FACTION_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_WARBAND_ICON"],
			variableKey = "CONFIG_REPUTATION_WARBAND_ICON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_ZERO"],
			variableKey = "CONFIG_REPUTATION_ZERO",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_COLOREDNAME"],
			variableKey = "CONFIG_REPUTATION_COLOREDNAME",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_VALUE_SIMPLE"],
			variableKey = "CONFIG_REPUTATION_VALUE_SIMPLE",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_PERCENTAGE_SIMPLE"],
			variableKey = "CONFIG_REPUTATION_PERCENTAGE_SIMPLE",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_REACTION_SIMPLE"],
			variableKey = "CONFIG_REPUTATION_REACTION_SIMPLE",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_STANDINGS_SIMPLE"],
			variableKey = "CONFIG_REPUTATION_STANDINGS_SIMPLE",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_VALUE_FRIEND"],
			variableKey = "CONFIG_REPUTATION_VALUE_FRIEND",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_PERCENTAGE_FRIEND"],
			variableKey = "CONFIG_REPUTATION_PERCENTAGE_FRIEND",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_REACTION_FRIEND"],
			variableKey = "CONFIG_REPUTATION_REACTION_FRIEND",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_STANDINGS_FRIEND"],
			variableKey = "CONFIG_REPUTATION_STANDINGS_FRIEND",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_VALUE_MAJOR"],
			variableKey = "CONFIG_REPUTATION_VALUE_MAJOR",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_PERCENTAGE_MAJOR"],
			variableKey = "CONFIG_REPUTATION_PERCENTAGE_MAJOR",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_REACTION_MAJOR"],
			variableKey = "CONFIG_REPUTATION_REACTION_MAJOR",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_STANDINGS_MAJOR"],
			variableKey = "CONFIG_REPUTATION_STANDINGS_MAJOR",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_VALUE_PARAGON"],
			variableKey = "CONFIG_REPUTATION_VALUE_PARAGON",
			defaultValue = true,
		},
		{
			name = L["CONFIG_REPUTATION_PERCENTAGE_PARAGON"],
			variableKey = "CONFIG_REPUTATION_PERCENTAGE_PARAGON",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_REACTION_PARAGON"],
			variableKey = "CONFIG_REPUTATION_REACTION_PARAGON",
			defaultValue = false,
		},
		{
			name = L["CONFIG_REPUTATION_STANDINGS_PARAGON"],
			variableKey = "CONFIG_REPUTATION_STANDINGS_PARAGON",
			defaultValue = false,
		},
	},
	["CENTER"] = {
		{
			name = L["EB_FONTSIZE"],
			variableKey = "CONFIG_DEBUG_EB_FONTSIZE",
			defaultValue = 12,
			minValue = 10,
			maxValue = 16,
			step = 1,
		},
		{
			name = L["ReloadUI"],
			func = function()
				return ReloadUI()
			end,
			TYPE = "button",
		},
	},
}





E.OctoTable_DEBUG_NEW = {
	["LEFT"] = {
		{
			name = "Class_Warrior_Color",
			color = "C69B6D",
			TYPE = "color",
		},
		{
			name = "Class_Paladin_Color",
			color = "F48CBA",
			TYPE = "color",
		},
		{
			name = "Class_Hunter_Color",
			color = "AAD372",
			TYPE = "color",
		},
		{
			name = "Class_Rogue_Color",
			color = "FFF468",
			TYPE = "color",
		},
		{
			name = "Class_Priest_Color",
			color = "FFFFFF",
			TYPE = "color",
		},
		{
			name = "Class_Shaman_Color",
			color = "0070DD",
			TYPE = "color",
		},
		{
			name = "Class_Mage_Color",
			color = "3FC7EB",
			TYPE = "color",
		},
		{
			name = "Class_Warlock_Color",
			color = "8788EE",
			TYPE = "color",
		},
		{
			name = "Class_Monk_Color",
			color = "00FF98",
			TYPE = "color",
		},
		{
			name = "Class_Druid_Color",
			color = "FF7C0A",
			TYPE = "color",
		},
		{
			name = "Class_DemonHunter_Color",
			color = "A330C9",
			TYPE = "color",
		},
		{
			name = "Class_DeathKnight_Color",
			color = "C41E3A",
			TYPE = "color",
		},
		{
			name = "Class_Evoker_Color",
			color = "33937F",
			TYPE = "color",
		},
		{
			name = "Classic_Color",
			color = "68CCEF",
			TYPE = "color",
		},
		{
			name = "TheBurningCrusade_Color",
			color = "4FFF79",
			TYPE = "color",
		},
		{
			name = "WrathoftheLichKing_Color",
			color = "00A3FF",
			TYPE = "color",
		},
		{
			name = "Cataclysm_Color",
			color = "FFB300",
			TYPE = "color",
		},
		{
			name = "MistsofPandaria_Color",
			color = "00FFBA",
			TYPE = "color",
		},
		{
			name = "WarlordsofDraenor_Color",
			color = "C86400",
			TYPE = "color",
		},
		{
			name = "Legion_Color",
			color = "1EFF00",
			TYPE = "color",
		},
		{
			name = "BattleforAzeroth_Color",
			color = "6464FF",
			TYPE = "color",
		},
		{
			name = "Shadowlands_Color",
			color = "C9C3AA",
			TYPE = "color",
		},
		{
			name = "Dragonflight_Color",
			color = "E8E379",
			TYPE = "color",
		},
		{
			name = "WOW_Poor_Color",
			color = "9D9D9D",
			TYPE = "color",
		},
		{
			name = "WOW_Common_Color",
			color = "FFFFFF",
			TYPE = "color",
		},
		{
			name = "WOW_Uncommon_Color",
			color = "1EFF00",
			TYPE = "color",
		},
		{
			name = "WOW_Rare_Color",
			color = "0070DD",
			TYPE = "color",
		},
		{
			name = "WOW_Epic_Color",
			color = "A335EE",
			TYPE = "color",
		},
		{
			name = "WOW_Legendary_Color",
			color = "FF8000",
			TYPE = "color",
		},
		{
			name = "WOW_Artifact_Color",
			color = "D9CC80",
			TYPE = "color",
		},
		{
			name = "WOW_Heirloom_Color",
			color = "00CCFF",
			TYPE = "color",
		},
		{
			name = "WOW_WoWToken_Color",
			color = "00CCFF",
			TYPE = "color",
		},
		{
			name = "Kyrian_Color",
			color = "6FA8DC",
			TYPE = "color",
		},
		{
			name = "Necrolord_Color",
			color = "93C47D",
			TYPE = "color",
		},
		{
			name = "NightFae_Color",
			color = "B4A7D6",
			TYPE = "color",
		},
		{
			name = "Venthyr_Color",
			color = "EA9999",
			TYPE = "color",
		},
		{
			name = "Black_Color",
			color = "000000",
			TYPE = "color",
		},
		{
			name = "DarkGray_Color",
			color = "252525",
			TYPE = "color",
		},
		{
			name = "Gray_Color",
			color = "505050",
			TYPE = "color",
		},
		{
			name = "LightGray_Color",
			color = "757575",
			TYPE = "color",
		},
		{
			name = "White_Color",
			color = "FFFFFF",
			TYPE = "color",
		},
		{
			name = "Addon_Left_Color",
			color = "D177FF",
			TYPE = "color",
		},
		{
			name = "Addon_Right_Color",
			color = "63A4E0",
			TYPE = "color",
		},
		{
			name = "Red_Color",
			color = "FF4C4F",
			TYPE = "color",
		},
		{
			name = "Orange_Color",
			color = "FF661A",
			TYPE = "color",
		},
		{
			name = "Darkorange_Color",
			color = "FF8C00",
			TYPE = "color",
		},
		{
			name = "Gold_Color",
			color = "FFD600",
			TYPE = "color",
		},
		{
			name = "Yellow_Color",
			color = "FFF371",
			TYPE = "color",
		},
		-- "FFFF00"
		{
			name = "Greenyellow_Color",
			color = "ACFF2F",
			TYPE = "color",
		},
		{
			name = "Green_Color",
			color = "4FFF79",
			TYPE = "color",
		},
		{
			name = "Cyan_Color",
			color = "00FFFF",
			TYPE = "color",
		},
		{
			name = "Blue_Color",
			color = "00A3FF",
			TYPE = "color",
		},
		{
			name = "Purple_Color",
			color = "AF61FF",
			TYPE = "color",
		},
		{
			name = "Indigo_Color",
			color = "4B0082",
			TYPE = "color",
		},
		{
			name = "Magenta_Color",
			color = "FF00FF",
			TYPE = "color",
		},
		{
			name = "Pink_Color",
			color = "FF69B3",
			TYPE = "color",
		},
		{
			name = "Skyblue_Color",
			color = "87CDEB",
			TYPE = "color",
		},
		{
			name = "Steelblue_Color",
			color = "4682B3",
			TYPE = "color",
		},
		{
			name = "Slategray_Color",
			color = "708090",
			TYPE = "color",
		},
		{
			name = "Brown_Color",
			color = "964B00",
			TYPE = "color",
		},
	},
}