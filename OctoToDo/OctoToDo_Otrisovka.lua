local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------
function E:func_Otrisovka()
	local OctoTable_func_otrisovkaCENT = {}
	local OctoTable_func_otrisovkaLEFT = {}
	----------------------------------------------------------------
	tinsert(OctoTable_func_otrisovkaCENT,
		function(CharInfo)
			local vivodCent = " "
			local tooltip = {}
			local BGcolor
			vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			if CharInfo.Faction == "Horde" then
				BGcolor = "f01e38" -- RED
			else
				BGcolor = "0070DD" -- BLUE
			end
			if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerCanEarnExperience == true then
				vivodCent = vivodCent.." "..E.Yellow_Color..CharInfo.UnitLevel.."|r"
			end
			-- if OctoToDo_DB_Vars.ShowOnlyCurrentServer == false then
			-- 	vivodCent = vivodCent.."+"..CharInfo.curServerShort
			-- end
			local classColor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal then
				if CharInfo.guildRankIndex ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", "<"..E.Green_Color..CharInfo.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.guildRankName.."|r".."]"}
				else
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", " "}
				end
				if CharInfo.WarMode == true then
					tooltip[#tooltip+1] = {CharInfo.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or "", ""}
				end
				if CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.UnitXPPercent then
					tooltip[#tooltip+1] = {CharInfo.RaceLocal.." "..CharInfo.classColorHex..CharInfo.UnitLevel.."-го|r уровня "..CharInfo.classColorHex..CharInfo.UnitXPPercent.."%|r", " "}
				else
					tooltip[#tooltip+1] = {CharInfo.RaceLocal, " "}
				end
				if CharInfo.specName ~= 0 or CharInfo.specName ~= 0 then
					tooltip[#tooltip+1] = {E.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className, " "}
				end
				tooltip[#tooltip+1] = {" ", " "}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			if CharInfo.totalSlots ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(133634)..L["Bags"], CharInfo.classColorHex..(CharInfo.usedSlots.."/"..CharInfo.totalSlots).."|r"}
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(236664)..QUESTS_LABEL, CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"}
			end
			if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..(E.func_SecondsToClock(CharInfo.realTotalTime)).."|r")}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..(E.func_SecondsToClock(CharInfo.realLevelTime)).."|r")}
			end
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"hasMail", CharInfo.hasMail and E.Icon_MailBox..CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {E.Purple_Color.."GUID".."|r", E.Purple_Color..CharInfo.GUID.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Chromie_canEnter", CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {"Chromie_UnitChromieTimeID", CharInfo.Chromie_UnitChromieTimeID.."|r"}
			tooltip[#tooltip+1] = {"Chromie_name", CharInfo.classColorHex..CharInfo.Chromie_name.."|r"}
			tooltip[#tooltip+1] = {"BattleTag", E.Blue_Color..CharInfo.BattleTag.."|r"}
			tooltip[#tooltip+1] = {"BattleTagLocal", E.Blue_Color..CharInfo.BattleTagLocal.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"GameLimitedMode_IsActive", CharInfo.GameLimitedMode_IsActive and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {"levelCapped20", CharInfo.levelCapped20 and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {"PlayerCanEarnExperience", CharInfo.PlayerCanEarnExperience and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"buildVersion", CharInfo.classColorHex..CharInfo.buildVersion.."|r"}
			tooltip[#tooltip+1] = {"buildNumber", CharInfo.classColorHex..CharInfo.buildNumber.."|r"}
			tooltip[#tooltip+1] = {"buildDate", CharInfo.classColorHex..CharInfo.buildDate.."|r"}
			tooltip[#tooltip+1] = {"interfaceVersion", CharInfo.classColorHex..CharInfo.interfaceVersion.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"currentTier", CharInfo.classColorHex..CharInfo.currentTier.."|r"}
			tooltip[#tooltip+1] = {"IsPublicBuild", CharInfo.IsPublicBuild and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {"isBeta", CharInfo.isBeta and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"max LVL", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rLevel).."|r"}
			tooltip[#tooltip+1] = {"max Money", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rMoney).."|r"}
			tooltip[#tooltip+1] = {"max Prof", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_profCap).."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Authenticator", CharInfo.classColorHex..tostringall(CharInfo.IsAccountSecured).."|r"}
			tooltip[#tooltip+1] = {"УЗ имеет ограничения пробной УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsRestrictedAccount).."|r"}
			tooltip[#tooltip+1] = {"Использует ли игрок пробную УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsTrialAccount).."|r"}
			tooltip[#tooltip+1] = {"Нет игрового времени", CharInfo.classColorHex..tostringall(CharInfo.IsVeteranTrialAccount).."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"PlayerDurability", CharInfo.PlayerDurability.."%"}
			if CharInfo.MASLENGO.ItemsInBag[122284] ~= 0 then
				tooltip[#tooltip+1] = {E.func_itemTexture(122284)..E.func_itemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
			end
			return vivodCent, tooltip, BGcolor
	end)
	tinsert(OctoTable_func_otrisovkaLEFT,
		function(CharInfo)
			return E.Timers.Daily_Reset()
	end)
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.MP_MythicKeystone == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Chromie_inChromieTime == false then
					if CharInfo.CurrentKeyName and CharInfo.CurrentKeyName ~= 0 then
						tooltip[#tooltip+1] = {E.func_RIOColor(CharInfo.RIO_Score_TWW_S2)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyName.."|r", ""}
					end
					if CharInfo.RIO_Score_TWW_S2 ~= 0 then
						tooltip[#tooltip+1] = {" ", " "}
						local Enum_Activities_table = {}
						for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
							Enum_Activities_table[#Enum_Activities_table+1] = i
						end
						sort(Enum_Activities_table)
						for j = 1, #Enum_Activities_table do
							local i = Enum_Activities_table[j]
							if CharInfo.GreatVault[i] and CharInfo.GreatVault[i].type ~= "" then
								CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
								CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
								CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
								CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
								if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
									tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score_TWW_S2)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
								elseif CharInfo.GreatVault[i].progress ~= 0 then
									tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
								end
							end
						end
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S2)..CharInfo.RIO_weeklyBest_TWW_S1.."|r"}
						tooltip[#tooltip+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S2)..CharInfo.RIO_Score_TWW_S2.."|r"}
					end
					if CharInfo.CurrentKey ~= 0 then
						vivodCent = E.func_RIOColor(CharInfo.RIO_Score_TWW_S2)..CharInfo.CurrentKey.."|r"
					end
					if CharInfo.HasAvailableRewards then
						vivodCent = vivodCent..E.Blue_Color..">Vault<|r"
					end
				else
					vivodCent = vivodCent..E.Red_Color..CharInfo.Chromie_name.."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_texturefromIcon(4352494)..E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
		end)
		--------------------------------
	end



	--------------------------------
	if OctoToDo_DB_Vars.WorldBoss_Weekly == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if OctoToDo_DB_Vars.ExpansionToShow[11] then -- The War Within
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TheWarWithin_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[10] then -- Dragonflight
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[9] then -- Shadowlands
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[8] then -- Battle for Azeroth
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[7] then -- Legion
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[6] then -- Warlords of Draenor
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_WorldBoss_Weekly
				end
				if OctoToDo_DB_Vars.ExpansionToShow[5] then -- Mists of Pandaria
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_MistsofPandaria_WorldBoss_Weekly
				end
				-- if OctoToDo_DB_Vars.ExpansionToShow[4] then -- Cataclysm
				-- 	vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Cataclysm_WorldBoss_Weekly
				-- end
				-- if OctoToDo_DB_Vars.ExpansionToShow[3] then -- Wrath of the Lich King
				-- 	vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_WorldBoss_Weekly
				-- end
				-- if OctoToDo_DB_Vars.ExpansionToShow[2] then -- The Burning Crusade
				-- 	vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TheBurningCrusade_WorldBoss_Weekly
				-- end
				-- if OctoToDo_DB_Vars.ExpansionToShow[1] then -- Classic
				-- 	vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Classic_WorldBoss_Weekly
				-- end
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[11].color..E.OctoTable_Expansions_Table[11].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_TheWarWithin_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[10].color..E.OctoTable_Expansions_Table[10].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[9].color..E.OctoTable_Expansions_Table[9].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[8].color..E.OctoTable_Expansions_Table[8].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[7].color..E.OctoTable_Expansions_Table[7].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[6].color..E.OctoTable_Expansions_Table[6].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_WorldBoss_Weekly}
				tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[5].color..E.OctoTable_Expansions_Table[5].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_MistsofPandaria_WorldBoss_Weekly}
				-- tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[4].color..E.OctoTable_Expansions_Table[4].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_Cataclysm_WorldBoss_Weekly}
				-- tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[3].color..E.OctoTable_Expansions_Table[3].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_WorldBoss_Weekly}
				-- tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[2].color..E.OctoTable_Expansions_Table[2].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_TheBurningCrusade_WorldBoss_Weekly}
				-- tooltip[#tooltip+1] = {E.OctoTable_Expansions_Table[1].color..E.OctoTable_Expansions_Table[1].name.."|r", CharInfo.MASLENGO.UniversalQuest.Octopussy_Classic_WorldBoss_Weekly}




				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.Icon_WorldBoss..L["World Boss"]
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------


	if OctoToDo_DB_Vars.ExpansionToShow[2] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(23572)..E.func_itemName(23572)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(30183)..E.func_itemName(30183)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(32428)..E.func_itemName(32428)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(34664)..E.func_itemName(34664)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[3] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[52019] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52019]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(52019)..E.func_itemName(52019)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(45087)..E.func_itemName(45087)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(47556)..E.func_itemName(47556)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(49908)..E.func_itemName(49908)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[4] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(52078)..E.func_itemName(52078)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(69237)..E.func_itemName(69237)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(71998)..E.func_itemName(71998)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[5] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[697] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[697]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(697)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[776] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[776]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(776)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[6] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1129] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1129]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1129)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[994] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[994]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(994)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[823] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[823]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(823)..E.func_currencyName(823)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1101] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1101]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1101)..E.func_currencyName(1101)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[824] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[824]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(824)..E.func_currencyName(824)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Faction == "Alliance" then
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Alliance_Once ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Alliance_Once
					end
				else
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Horde_Once ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Horde_Once
					end
				end
				if vivodCent ~= "0/3" and vivodCent ~= "" then
					vivodCent = E.func_itemTexture(110560)..vivodCent
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return GARRISON_LOCATION_TOOLTIP
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[38242]
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_itemTexture(122457)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(38242).." (ап пета)"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[39246]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(39246)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[7] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return (E.Timers.Legion_Invasion().."Timer_Legion_Invasion")
		end)
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BrokenShoreArmiesofLegionfall_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BrokenShoreArmiesofLegionfall_Once
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46246] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Broken Shore - Armies of Legionfall"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BrokenShoreExcavations_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BrokenShoreExcavations_Once
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46666] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Broken Shore - Excavations"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_ArgusToArgus_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_ArgusToArgus_Once
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Broken Shore - ToArgus"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BalanceofPower_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Legion_BalanceofPower_Once
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.DONE
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(43533)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1273] then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1273]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1273)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1508)..E.func_currencyName(1508)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1342]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1342)..E.func_currencyName(1342)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1220]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1220)..E.func_currencyName(1220)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1226]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1226)..E.func_currencyName(1226)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1533]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1533)..E.func_currencyName(1533)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1155]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1155)..E.func_currencyName(1155)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(124124)..E.func_itemName(124124)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_Legion1"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_Legion2"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_Legion3"
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[8] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_InvasionQuests_Daily ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_InvasionQuests_Daily
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return (E.Timers.BfA_Invasion().."Timer_BfA_Invasion (PVP)")
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_AssaultTheBlackEmpire_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_AssaultTheBlackEmpire_Weekly
				end
				if CharInfo.MASLENGO.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174765]..E.func_itemTexture(174765)
				end
				if CharInfo.MASLENGO.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174761]..E.func_itemTexture(174761)
				end
				if CharInfo.MASLENGO.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174767]..E.func_itemTexture(174767)
				end
				if CharInfo.MASLENGO.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174766]..E.func_itemTexture(174766)
				end
				if CharInfo.MASLENGO.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174768]..E.func_itemTexture(174768)
				end
				if #tooltip > 0 then
					tooltip[#tooltip+1] = {" ", " "}
				end
				tooltip[#tooltip+1] = {E.func_itemTexture(174764)..CharInfo.MASLENGO.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174765]..E.func_itemTexture(174765)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174756)..CharInfo.MASLENGO.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174761]..E.func_itemTexture(174761)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174759)..CharInfo.MASLENGO.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174767]..E.func_itemTexture(174767)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174760)..CharInfo.MASLENGO.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174766]..E.func_itemTexture(174766)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174758)..CharInfo.MASLENGO.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.MASLENGO.ItemsInBag[174768]..E.func_itemTexture(174768)}
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Timers.BfA_Assault().."Timer_BfA_Assault (N'zoth)"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_miniVision_Daily ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_miniVision_Daily
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Purple_Color.."Mini Vision".."|r"
		end)
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_DarkshoreRares_Daily ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_DarkshoreRares_Daily
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_Rares.."Rares: Darkshore"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1560] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1560]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1560)..E.func_currencyName(1560)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1721] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1721]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1721)..E.func_currencyName(1721)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1803] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1803]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1803)..E.func_currencyName(1803)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1755] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_itemTexture(173363)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1755)..E.func_currencyName(1755)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1719] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1719]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1719)..E.func_currencyName(1719)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1710] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1710]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1710)..E.func_currencyName(1710)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1716] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1716]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1716)..E.func_currencyName(1716)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1718]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1718)..E.func_currencyName(1718)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[158075] == 0 then
					vivodCent = E.Red_Color.."no neck|r"
				else
					vivodCent = E.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						vivodCent = E.Green_Color..CharInfo.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(158075)..E.func_itemName(158075)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[169223] == 0 then
					vivodCent = E.Red_Color.."no cloak|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[169223] ~= 0 then
					vivodCent = E.Orange_Color.."neeed to equip|r"
					if CharInfo.cloak_lvl ~= 0 then
						vivodCent = CharInfo.cloak_lvl.." lvl"
						if CharInfo.cloak_lvl == 15 then
							vivodCent = E.Green_Color..vivodCent.."|r"
						end
					end
					if CharInfo.cloak_res ~= 0 then
						vivodCent = vivodCent.."+"..CharInfo.cloak_res
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(169223)..E.func_itemName(169223)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.islandBfA
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					return E.func_questName(questID)
				else
					return "All_BfA_Island"
				end
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_Warfront1_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_Warfront1_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Warfront: Stromgarde"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_Warfront2_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_Warfront2_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Warfront: Darkshore"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_WarfrontHC_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_BattleforAzeroth_WarfrontHC_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "Warfront: Heroic"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_BfA1"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_BfA2"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "bounty_BfA3"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				tooltip[#tooltip+1] = {E.func_itemTexture(166846)..E.func_itemName(166846), CharInfo.MASLENGO.ItemsInBag[166846]}
				tooltip[#tooltip+1] = {E.func_itemTexture(169610)..E.func_itemName(169610), CharInfo.MASLENGO.ItemsInBag[169610]}
				tooltip[#tooltip+1] = {E.func_itemTexture(166970)..E.func_itemName(166970), CharInfo.MASLENGO.ItemsInBag[166970]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168327)..E.func_itemName(168327), CharInfo.MASLENGO.ItemsInBag[168327]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168832)..E.func_itemName(168832), CharInfo.MASLENGO.ItemsInBag[168832]}
				tooltip[#tooltip+1] = {E.func_itemTexture(166971)..E.func_itemName(166971), CharInfo.MASLENGO.ItemsInBag[166971]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168946)..E.func_itemName(168946), CharInfo.MASLENGO.ItemsInBag[168946]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168215)..E.func_itemName(168215), CharInfo.MASLENGO.ItemsInBag[168215]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168216)..E.func_itemName(168216), CharInfo.MASLENGO.ItemsInBag[168216]}
				tooltip[#tooltip+1] = {E.func_itemTexture(168217)..E.func_itemName(168217), CharInfo.MASLENGO.ItemsInBag[168217]}
				vivodCent = "МЕХАГОН"
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "МЕХАГОН"
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[9] then
		----------------------------------------------------------------
		for k = 1, 2 do
			for i = 1, 4 do
				--------------------------------
				tinsert(OctoTable_func_otrisovkaCENT,
					function(CharInfo)
						local vivodCent, tooltip = " ", {}
						vivodCent = E.OctoTable_Covenant[i].color..vivodCent.."|r"
						if i == CharInfo.CovenantAndAnima.curCovID then
							if CharInfo.Possible_Anima ~= 0 and k == 2 then
								vivodCent = vivodCent..E.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
							end
						end
						if k == 1 then
							vivodCent = E.func_EmptyZero(CharInfo.CovenantAndAnima[i][k])
						else
							vivodCent = E.func_EmptyZero(CharInfo.CovenantAndAnima[i][k])
						end
						return vivodCent, tooltip
				end)
				tinsert(OctoTable_func_otrisovkaLEFT,
					function(CharInfo)
						local vivodLeft = E.func_texturefromIcon(E.OctoTable_Covenant[i].icon)..E.OctoTable_Covenant[i].color..E.OctoTable_Covenant[i].name.."|r"
						if k == 2 then
							vivodLeft = vivodLeft..E.func_currencyIcon(1813)
						end
						return vivodLeft
				end)
				--------------------------------
			end
		end
		----------------------------------------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawCovenantAssault_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawCovenantAssault_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  "Maw: Covenant Assault "..E.Timers.SL_Maw_Assault()
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2009] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2009]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(2009)..E.func_currencyName(2009)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1906] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1906]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1906)..E.func_currencyName(1906)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1828] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1828]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1828)..E.func_currencyName(1828)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1979] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1979]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1979)..E.func_currencyName(1979)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1931] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1931]
				end
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1931)..E.func_currencyName(1931)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMPatternsWithinPatterns_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMPatternsWithinPatterns_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_texturefromIcon(4074774)..E.func_questName(66042)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaShapingFate_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaShapingFate_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_texturefromIcon(4066373)..E.func_questName(63949)
		end)
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ReplenishtheReservoir_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ReplenishtheReservoir_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1813)..E.func_questName(61981)
		end)
		--------------------------------
		--------------------------------
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[10] then
		--------------------------------
		if OctoToDo_DB_Vars.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_AidingtheAccord_Weekly ~= "" and CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_AidingtheAccord_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_AidingtheAccord_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return E.func_texturefromIcon(1603189)..L["Aiding the Accord"]
			end)
		end
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_CommunityFeast_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_CommunityFeast_Weekly
				end
				if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200652]..E.func_itemTexture(200652)
				end
				if CharInfo.MASLENGO.ItemsInBag[200095] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200095]..E.func_itemTexture(200095)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_texturefromIcon(629056)..E.Timers.DF_CommunityFeast()..L["Community Feast"]
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ResearchersUnderFire_Weekly ~= E.NONE and CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ResearchersUnderFire_Weekly ~= "0/4" then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ResearchersUnderFire_Weekly
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.MASLENGO.OctoTable_QuestID[75630]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.MASLENGO.OctoTable_QuestID[75629]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.MASLENGO.OctoTable_QuestID[75628]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.MASLENGO.OctoTable_QuestID[75627]}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_texturefromIcon(236469)..E.Timers.DF_ResearchersUnderFire()..E.func_questName(74906)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernAWorthyAllyLoammNiffen_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernAWorthyAllyLoammNiffen_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(75665)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_TheSuperbloom_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_TheSuperbloom_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_texturefromIcon(134206)..E.Timers.DF_Flower()..E.func_questName(78319)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_BloomingDreamseeds_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_BloomingDreamseeds_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(78821)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_AWorthyAllyDreamWardens_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_AWorthyAllyDreamWardens_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(78444)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_DreamsUnified_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_DreamsUnified_Once
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(78381)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TimeRift_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TimeRift_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return (E.func_texturefromIcon(628677)..E.Timers.DF_TimeRift()..L["TimeRift"])
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(209856)..E.func_itemName(209856)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= 0 then
					vivodCent = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(207002)..E.func_itemName(207002)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2594] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= 0 then
					vivodCent = vivodCent..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_itemTexture(208945)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(2594)..E.func_currencyName(2594)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ShapingtheDreamsurge_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ShapingtheDreamsurge_Weekly
				end
				if CharInfo.MASLENGO.ItemsInBag[209419] ~= 0 then
					tooltip[#tooltip+1] = {E.func_texturefromIcon(1044087)..E.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.MASLENGO.ItemsInBag[209419]}
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return (E.func_texturefromIcon(134206)..E.Timers.DF_Dreamsurges()..L["Dreamsurges"])
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= 0 then
					vivodCent = vivodCent..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(210254)..E.WOW_Epic_Color..E.func_itemName_NOCOLOR(210254).."|r"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2245] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2245]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(2245)..E.func_currencyName(2245)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(213089)..E.func_itemName(213089)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(211516)..E.func_itemName(211516)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemTexture(211515)..E.func_itemName(211515)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[11] then
		--------------------------------
		if OctoToDo_DB_Vars.BeledarCycle == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  E.Timers.TWW_BeledarCycle()..E.func_questName(83240)
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.TWW_DungeonQuest_Weekly == true then
			--------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  L["Weekly Dungeon Quest"]
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.TWW_Delve_Weekly == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  "TWW_Delve_Weekly"
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.MajorKeyflames == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  E.func_texturefromIcon(132863)..L["Major Keyflames"]
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.MinorKeyflames == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  E.func_texturefromIcon(135619)..L["Minor Keyflames"]
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.GildedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					return  E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.RunedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					return  E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.CarvedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					return  E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.WeatheredHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					return  E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
			end)
		end
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[12] then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				for _, v in next, (E.OctoTable_UniversalQuest) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] == E.DONE then
						tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Green_Color.."Octopussy|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."ALL|r"
		end)
		--------------------------------
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		E.func_TableRemoveDuplicates(list)
		sort(list)
		for i, value in ipairs(list) do
			--------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							vivodCent = value
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return i
			end)
			--------------------------------
		end
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Timewalk == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1166)..DUNGEONS
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1166).."500 "..E.func_currencyName(1166)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1166)..RAIDS
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(3100)..E.func_texturefromIcon(1322720)..E.func_questName(57300)
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Quests == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if OctoToDo_DB_Vars.ExpansionToShow[10] then
					tooltip[#tooltip+1] = {E.func_Gradient("»".."Dragonflight".."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_DragonbaneKeep_Weekly}
					tooltip[#tooltip+1] = {E.Timers.DF_GrandHunts()..L["Grand Hunt"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TheGrandHunt_Weekly}
					tooltip[#tooltip+1] = {E.Timers.DF_CommunityFeast()..L["Community Feast"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_CommunityFeast_Weekly}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_AidingtheAccord_Weekly}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_KeysofLoyalty_Weekly}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_PVP_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.2.0".."«"), " "}
					tooltip[#tooltip+1] ={E.Timers.DF_Flower()..E.func_questName(78319), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_TheSuperbloom_Weekly}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_AWorthyAllyDreamWardens_Weekly}
					tooltip[#tooltip+1] ={E.func_questName(78821), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_BloomingDreamseeds_Weekly}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_AWorthyAllyDreamWardens_Weekly}
					tooltip[#tooltip+1] ={E.func_questName(78381), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_EmeraldDream_DreamsUnified_Once}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_Dreamsurges()..L["Dreamsurges"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_DreamsurgeInvestigation_Once}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ShapingtheDreamsurge_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.5".."«"), " "}
					tooltip[#tooltip+1] = {E.func_questName(77236), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_WhenTimeNeedsMending_Weekly}
					tooltip[#tooltip+1] = {E.Timers.DF_TimeRift()..L["TimeRift"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TimeRift_Weekly}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TemporalAcquisitionsSpecialist_Once}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zaralek Cavern"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_ResearchersUnderFire()..E.func_questName(74906), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ResearchersUnderFire_Weekly}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..E.func_questName(74892), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_WBZaqaliElders_Weekly}
					tooltip[#tooltip+1] = {E.func_texturefromIcon(5062638)..E.func_questName(75694), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_AberrustheShadowedCrucibleSarkareth_Once}
					tooltip[#tooltip+1] = {E.func_questName(75665), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernAWorthyAllyLoammNiffen_Weekly}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernSniffenseeking_Weekly}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernSniffenseekingItems_Weekly}
					tooltip[#tooltip+1] = {"Events", CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernEvents_Daily}
					tooltip[#tooltip+1] = {"Rares", CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_ZaralekCavernRares_Daily}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_FightingisItsOwnReward_Weekly}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_FyrakkAssaults_Weekly}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_DiscipleofFyrakk_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_texturefromIcon(4643981)..E.func_questName(66847), CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_VaultoftheIncarnatesFuryoftheStormEater_Once}
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["The Forbidden Reach"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_StormsFury_Weekly}
					tooltip[#tooltip+1] = {"Rares", CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_TheForbiddenReachRares_Daily}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_StormBoundChest_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
				end
				if OctoToDo_DB_Vars.ExpansionToShow[9] then
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."Shadowlands".."«"), " "}
					tooltip[#tooltip+1] = {"ReplenishtheReservoir", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ReplenishtheReservoir_Weekly}
					tooltip[#tooltip+1] = {"TradingFavors", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_TradingFavors_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zereth Mortis"].."«"), " "}
					tooltip[#tooltip+1] = {"Patterns Within Patterns", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMPatternsWithinPatterns_Weekly}
					tooltip[#tooltip+1] = {"Prying Eye Discovery", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMPryingEyeDiscovery_Daily}
					tooltip[#tooltip+1] = {"PUZZLECACHES", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMPUZZLECACHES_Daily}
					tooltip[#tooltip+1] = {"Rares", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMRares_Daily}
					tooltip[#tooltip+1] = {"Rares Dune Dominance", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMRaresDuneDominance_Daily}
					tooltip[#tooltip+1] = {"TREASURES", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMTREASURES_Daily}
					tooltip[#tooltip+1] = {"World Quests", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMWorldQuests_Daily}
					tooltip[#tooltip+1] = {"Concordance", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMConcordance_Once}
					tooltip[#tooltip+1] = {"Undulating Foliage", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_ZMUndulatingFoliage_Once}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Korthia"].."«"), " "}
					tooltip[#tooltip+1] = {"Collection", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaCollection_Daily}
					tooltip[#tooltip+1] = {"Korthian Anima Vessel", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaKorthianAnimaVessel_Daily}
					tooltip[#tooltip+1] = {"Mobs", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaMobs_Daily}
					tooltip[#tooltip+1] = {"Relic Gorger", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRelicGorger_Daily}
					tooltip[#tooltip+1] = {"RIFT Stolen Anima Vessel", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRIFTStolenAnimaVessel_Weekly}
					tooltip[#tooltip+1] = {"RIFT Riftbound Cache", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRIFTRiftboundCache_Daily}
					tooltip[#tooltip+1] = {"RIFT Spectral Bound Chest", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRIFTSpectralBoundChest_Daily}
					tooltip[#tooltip+1] = {"RIFT Zovaals Vault", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRIFTZovaalsVault_Daily}
					tooltip[#tooltip+1] = {"Lost Research", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaLostResearch_Weekly}
					tooltip[#tooltip+1] = {"Rares", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaRares_Weekly}
					tooltip[#tooltip+1] = {"Shaping Fate", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaShapingFate_Weekly}
					tooltip[#tooltip+1] = {"Stolen Korthian Supplies", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_KorthiaStolenKorthianSupplies_Weekly}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Maw"].."«"), " "}
					tooltip[#tooltip+1] = {"MawContainingtheHelsworn", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawContainingtheHelsworn_Weekly}
					tooltip[#tooltip+1] = {"MawQuest", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawQuest_Daily}
					tooltip[#tooltip+1] = {"MawHelswornChest", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawHelswornChest_Daily}
					tooltip[#tooltip+1] = {"MawCovenantAssault", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawCovenantAssault_Weekly}
					tooltip[#tooltip+1] = {"MawTorghast", CharInfo.MASLENGO.UniversalQuest.Octopussy_Shadowlands_MawTorghast_Weekly}
				end
				if #tooltip > 0 then
					tooltip[#tooltip+1] = {" ", " "}
				end
				tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Another quests"].."«"), " "}
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.MASLENGO.UniversalQuest.Octopussy_WotLK_Shadowmourne_Once}
						if CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.NONE and CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.DONE then
							tooltip[#tooltip+1] = {E.func_questName(24547), CharInfo.MASLENGO.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.MASLENGO.UniversalQuest.Octopussy_Dragonflight_Warlock_SomeWickedThings_Once}
						tooltip[#tooltip+1] = {L["Green Fire"], CharInfo.MASLENGO.UniversalQuest.Octopussy_MistsofPandaria_Warlock_GreenFire_Once}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmor_Once"] and CharInfo.RaceEnglish == v.RaceEnglish and CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmor_Once"] ~= 0 then
						tooltip[#tooltip+1] = {L["Races"].." - "..v.RaceEnglish, CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmor_Once"]}
					end
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmorAllied_Once"] and CharInfo.RaceEnglish == v.RaceEnglish and CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmorAllied_Once"] ~= 0 then
						tooltip[#tooltip+1] = {L["Allied Races"] .." - "..v.RaceEnglish, CharInfo.MASLENGO.UniversalQuest["Octopussy_Another_"..v.RaceEnglish.."HeritageArmorAllied_Once"]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..vivodCent.."|r"
				else
					vivodCent = ""
				end
				if CharInfo.maxNumQuestsCanAccept ~= 0 then
					vivodCent = CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return QUESTS_LABEL.." OLD"
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Dungeons == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..instanceID.."|r" or ""), w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (E.OctoTable_LFGDungeons) do
					if CharInfo.LFGInstance[dungeonID].donetoday ~= E.NONE then
						tooltip[#tooltip+1] = {CharInfo.LFGInstance[dungeonID].D_name..(E.DebugIDs and E.Gray_Color.. " id:"..dungeonID.."|r" or ""), CharInfo.LFGInstance[dungeonID].donetoday}
					end
				end





				for worldBossID, v in next, (CharInfo.SavedWorldBoss) do
					if v then
						tooltip[#tooltip+1] = {E.Icon_WorldBoss.. v.name .." ".. E.Red_Color..E.func_SecondsToClock(v.reset).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..worldBossID.."|r" or ""), " "}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..DUNGEONS.."|r"
				else
					vivodCent = ""
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return DUNGEONS
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Currency == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
					for CurrencyID, config in next, (tbl) do
						if OctoToDo_DB_Vars.CurrencyShowAllways == false and config == true and CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
							tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
						elseif OctoToDo_DB_Vars.CurrencyShowAllways == true and config == true then
							if CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
								tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
							else
								tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.Gray_Color..E.func_currencyName_NOCOLOR(CurrencyID), E.Gray_Color..CharInfo.MASLENGO.CurrencyID_Total[CurrencyID].."|r"}
							end
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..CURRENCY.."|r"
				else
					vivodCent = ""
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return CURRENCY
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Reputations == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = E.Gray_Color..REPUTATION.."|r"
				for reputationHEADER, tbl in next, (OCTO_DB_reputations_test) do
					for reputationID, config in next, (tbl) do
						if config == true and CharInfo.MASLENGO.reputationID[reputationID] ~= 0 and CharInfo.MASLENGO.reputationID[reputationID] ~= "" then
							tooltip[#tooltip+1] = {E.func_reputationName(reputationID).."|r", CharInfo.MASLENGO.reputationID[reputationID]}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..REPUTATION.."|r"
				else
					vivodCent = ""
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return REPUTATION
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Items == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				for index, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if OctoToDo_DB_Vars.ItemsShowAllways == false  and CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
						tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
					elseif OctoToDo_DB_Vars.ItemsShowAllways == true then
						if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
							tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
						else
							tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.Gray_Color..E.func_itemName_NOCOLOR(itemID).."|r", E.Gray_Color..CharInfo.MASLENGO.ItemsInBag[itemID].."|r"}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..ITEMS.."|r"
				else
					vivodCent = ""
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return ITEMS
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Professions == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.professions[1].skillLine ~= 0 then
					vivodCent = vivodCent..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine)
					if CharInfo.MASLENGO.professions[2].skillLine ~= 0 then
						vivodCent = vivodCent.." "..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[2].skillLine)
					end
				end
				for i = 1, 5 do
					if CharInfo.MASLENGO.professions[i].skillLine ~= 0 then
						tooltip[#tooltip+1] = {E.func_ProfessionIcon(CharInfo.MASLENGO.professions[i].skillLine)..E.func_ProfessionName(CharInfo.MASLENGO.professions[i].skillLine), CharInfo.MASLENGO.professions[i].skillLevel.."/"..CharInfo.MASLENGO.professions[i].maxSkillLevel}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return PROFESSIONS_BUTTON
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.Gold == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Money then
					vivodCent = E.func_CompactNumberFormat(CharInfo.Money/10000)..E.Icon_Money
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Red_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Green_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return BONUS_ROLL_REWARD_MONEY
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ItemLevel == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				local color = E.Red_Color
				local ItemLevelGreen = 625
				local ItemLevelOrange = 610
				local ItemLevelRed = 580
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					if CharInfo.avgItemLevelEquipped >= ItemLevelGreen then
						color = E.Green_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelOrange then
						color = E.Yellow_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelRed then
						color = E.Orange_Color
					end
				end
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					vivodCent = color..CharInfo.avgItemLevelEquipped
					if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
						vivodCent = vivodCent.."/"..CharInfo.avgItemLevel.."|r"
					end
					if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return STAT_AVERAGE_ITEM_LEVEL
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.WasOnline == true then
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				local color = "|cffFFFFFF"
				if CharInfo.loginHour and CharInfo.loginDay then
					if CharInfo.Name == UnitName("Player") then
						vivodCent = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
					else
						if CharInfo.needResetWeekly == true then
							color = E.Gray_Color
						elseif CharInfo.needResetDaily == true then
							color = E.Red_Color
						end
						vivodCent = color..E.FriendsFrame_GetLastOnline(CharInfo.time).."|r"
						tooltip[#tooltip+1] = {color..E.FriendsFrame_GetLastOnlineText(CharInfo.time, CharInfo.classColorHex).."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginDay.."|r"}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginHour.."|r"}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return L["Was online"]
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	--[[
--------------------------------
tinsert(OctoTable_func_otrisovkaCENT,
function(CharInfo)
local vivodCent, tooltip = " ", {}
ТУТ
return vivodCent, tooltip
end)
tinsert(OctoTable_func_otrisovkaLEFT,
function(CharInfo)
return ВЫВОДЛЭФТ
end)
--------------------------------
]]
	return OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT
end