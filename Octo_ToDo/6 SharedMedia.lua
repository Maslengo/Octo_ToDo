local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local function RegisterMyTables(dataType, value, number, index, path)
	local leftText = E.Addon_Right_Color..tostring(number).."|r"
	if dataType == "sound" then
		LibSharedMedia:Register(dataType, leftText.." "..E.func_Gradient(value), path..value..[[.ogg]])
	elseif dataType == "font" then
		LibSharedMedia:Register(dataType, E.func_Gradient(value), path..value..[[.TTF]], LibSharedMedia.LOCALE_BIT_ruRU+LibSharedMedia.LOCALE_BIT_western)
	elseif dataType == "border" then
		LibSharedMedia:Register(dataType, E.func_Gradient(value), path..value..[[.tga]])
	elseif dataType == "statusbar" then
		LibSharedMedia:Register(dataType, E.func_Gradient(dataType.." "..value), path..value..[[.tga]])
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
do
	local Anime_tbl = {
		"Ayaya",
		"Fuck You",
		"Hadouken",
		"Jojo - The Hand",
		"Jojo - Timestop teleport",
		"Nyaa",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\01_Anime\]]
	for index, value in ipairs(Anime_tbl) do
		RegisterMyTables("sound", value, 1, index, path)
	end
end
----------------------------------------------------------------
do
	local CS_tbl = {
		"Awp",
		"Usp",
		"Zoom",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\02_CS\]]
	for index, value in ipairs(CS_tbl) do
		RegisterMyTables("sound", value, 2, index, path)
	end
end
----------------------------------------------------------------
do
	local Hostik_tbl = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"Female 1",
		"Female 2",
		"Female 3",
		"Female 4",
		"Female 5",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\03_Hostik\]]
	for index, value in ipairs(Hostik_tbl) do
		RegisterMyTables("sound", value, 3, index, path)
	end
end
----------------------------------------------------------------
do
	local Memes_tbl = {
		"Batida de porta troll",
		"Directed by Robert B Weide",
		"Dramatic",
		"Dry fart",
		"EAR RAPE Moaning",
		"Ephey",
		"ERA RAPE BLYAT",
		"Gnome Woo",
		"Hehe Boy",
		"Hey thats pretty good",
		"Its a trap",
		"katongoukamekkyaku",
		"MEME_ispanci",
		"MEME_kabanchik",
		"O_Allahu_akbar",
		"O_AnnihilationGun",
		"O_Dun_dun_dun",
		"O_eeee_ep",
		"O_fbi_open_up",
		"O_gta_san_andreas_mission_complete",
		"O_gta_v_death_sound_effect",
		"O_John_Cena",
		"O_Loh_pidr",
		"O_Murloc",
		"O_Nemesis",
		"O_Noo",
		"O_O_kurwa",
		"O_Ou_eee",
		"O_Raspishy_Full",
		"O_Raspishy_Short",
		"O_Risitaskekw",
		"O_Savage_fap",
		"O_The_rap_battle_parody_oh",
		"O_Triggered",
		"O_Ultimate_respect",
		"O_Vestige_elephant",
		"O_Zoidberg_whoop",
		"Omae Wa Mou Shindeiru",
		"Peanut Butter Kid",
		"Porn Hub",
		"Rat",
		"Really Nigga",
		"Ricefields",
		"Roblox Death",
		"Surprise motherfucker",
		"WeNeedMoreGold_ENG",
		"WeNeedMoreGold_RU",
		"Why are you running",
		"YameteKudasai",
		"YameteKudasaiFULL",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\04_Memes\]]
	for index, value in ipairs(Memes_tbl) do
		RegisterMyTables("sound", value, 4, index, path)
	end
end
----------------------------------------------------------------
do
	local Naruto_tbl = {
		"Chidori Kouken2",
		"Hand Sign",
		"Jutsu",
		"Jutsu2",
		"Kunai Throw1",
		"Kunai Throw2",
		"Kunai1",
		"Kunai2",
		"Kunai3",
		"Kunai4",
		"Shadow Clone",
		"Shadow SMS",
		"Teleport",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\05_Naruto\]]
	for index, value in ipairs(Naruto_tbl) do
		RegisterMyTables("sound", value, 5, index, path)
	end
end
----------------------------------------------------------------
do
	local Other_tbl = {
		"Bokudan",
		"Dark Souls - You died",
		"Ding",
		"EAR RAPE Skullsound",
		"Error",
		"Failsafe",
		"Fatality",
		"Finish Him",
		"Magic immune",
		"MGS Alert",
		"Nope",
		"Portal gun - ice",
		"Quack",
		"Readycheck",
		"Record scratch",
		"Sonic",
		"Teleport valorant",
		"Teleport1",
		"Teleport2",
		"TS3",
		"Windows XP",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\06_Other\]]
	for index, value in ipairs(Other_tbl) do
		RegisterMyTables("sound", value, 6, index, path)
	end
end
----------------------------------------------------------------
do
	local ut4_tbl = {
		"01",
		"02",
		"03",
		"04",
		"05",
		"06",
		"07",
		"08",
		"09",
		"10",
		"Averted",
		"Combowhore",
		"Dominating",
		"GodLike",
		"HolyShit",
		"Killing_Spree",
		"MegaKill",
		"Monster_kill",
		"Ownage",
		"Rampage",
		"Retribution",
		"Unstoppable",
		"WhickedSick",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\07_ut4\]]
	for index, value in ipairs(ut4_tbl) do
		RegisterMyTables("sound", value, 7, index, path)
	end
end
----------------------------------------------------------------
do
	local DevilMayCry_tbl = {
		"Anarchic",
		"Brutal",
		"Can Not Hide",
		"Cruel",
		"Crush Him",
		"Devil May Cry",
		"Dirty",
		"ENSATIONAL",
		"KILL THEM ALL",
		"Kill Yourself",
		"KillingMaxRank",
		"MultiKillingMaxRank",
		"Really Hate You",
		"Sadistic",
		"Savage",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\08_DevilMayCry\]]
	for index, value in ipairs(DevilMayCry_tbl) do
		RegisterMyTables("sound", value, 8, index, path)
	end
end
----------------------------------------------------------------
do
	local PathOfExile_tbl = {
		"1",
		"1Ah",
		"1Good",
		"2",
		"2Essence",
		"2Mm_delicious",
		"2Mmm_such_strange_pleasure",
		"2Multibase uniques",
		"2Special_mine",
		"2Uh unusual",
		"2Uu_brutal",
		"3",
		"3Ahh_beautiful",
		"3Ahh_fascinating",
		"3Exalted",
		"3Oh amazing",
		"4",
		"4Divine",
		"4Exalted",
		"5",
		"5Ahh_that_was_worthaw",
		"5Ahh_worth_await",
		"5You did well",
		"map high t",
		"map low t",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\09_PathOfExile\]]
	for index, value in ipairs(PathOfExile_tbl) do
		RegisterMyTables("sound", value, 9, index, path)
	end
end
----------------------------------------------------------------
do
	local PathOfExile_tbl = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"Ah",
		"Ahh_beautiful",
		"Ahh_fascinating",
		"Ahh_that_was_worthaw",
		"Ahh_worth_await",
		"Divine",
		"Essence",
		"Exalted 1",
		"Exalted 2",
		"Good",
		"map high t",
		"map low t",
		"Mm_delicious",
		"Mmm_such_strange_pleasure",
		"Multibase uniques",
		"Oh amazing",
		"Special_mine",
		"Uh unusual",
		"Uu_brutal",
		"You did well",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\01_Sounds\09_PathOfExile\]]
	for index, value in ipairs(PathOfExile_tbl) do
		RegisterMyTables("sound", value, 9, index, path)
	end
end
----------------------------------------------------------------
do
	local font_tbl = {
		"Arial",
		"BigNoodleTitlingCyr",
		"BitcrusherCdRg-Bold",
		"Consolas",
		"Expressway Rg Bold",
		"Expressway",
		"Fira Code Regular",
		"FortniteBattlefest",
		"Georgia",
		"GothamPro-Bold",
		"GothamPro-Medium",
		"Homespun TT BRK",
		"Lineage 2",
		"MagistralTT Bold",
		"Monsterrat Black",
		"Montserrat Bold",
		"Naowh",
		"Octo (dooztr_0)",
		"Octo (naowh)",
		"Octo (Octo main)",
		"Octo",
		"Octo-Bold",
		"PT Sans Narrow Bold",
		"RobotoBlack",
		"RobotoCondensedBold",
		"Segoe UI",
		"Tahoma",
		"Times New Roman",
		"Verdana",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\02_Fonts\]]
	for index, value in ipairs(font_tbl) do
		RegisterMyTables("font", value, 1, index, path)
	end
end
----------------------------------------------------------------
do
	local border_tbl = {
		"Octo",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\03_Borders\]]
	for index, value in ipairs(border_tbl) do
		RegisterMyTables("border", value, 1, index, path)
	end
end
----------------------------------------------------------------
do
	local statusbar_tbl = {
		"Atrocity",
		"Blank",
		"Kait",
		"Naowh",
		"Octo",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"11",
		"12",
		"13",
		"14",
		"15",
		"16",
		"17",
		"18",
		"19",
		"20",
		"21",
		"22",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\04_Statusbars\]]
	for index, value in ipairs(statusbar_tbl) do
		RegisterMyTables("statusbar", value, 1, index, path)
	end
end