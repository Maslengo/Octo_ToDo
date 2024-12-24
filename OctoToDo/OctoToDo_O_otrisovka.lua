local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------
function E:O_otrisovka()
	local OctoTable_func_otrisovkaCENT = {}
	local OctoTable_func_otrisovkaLEFT = {}
	----------------------------------------------------------------
	tinsert(OctoTable_func_otrisovkaCENT,
		function(CharInfo)
			local vivodCent = " "
			local tooltip = {}
			vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			if CharInfo.Faction == "Horde" then
				vivodCent = vivodCent.."|cffFF0000(H)|r"
			else
				vivodCent = vivodCent.."|cff0000FF(A)|r"
			end
			if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerCanEarnExperience == true then
				vivodCent = vivodCent.." "..E.Yellow_Color..CharInfo.UnitLevel.."|r"
			end
			if OctoToDo_DB_Vars.ShowOnlyCurrentServer == false then
				vivodCent = vivodCent.."|n"..CharInfo.curServer
			end
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
			return vivodCent, tooltip
	end)
	tinsert(OctoTable_func_otrisovkaLEFT,
		function(CharInfo)
			return E.Timers.Daily_Reset()
	end)
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
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_WorldBoss.."WB"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
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
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
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
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
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
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
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
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
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
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
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
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_miniVision_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Purple_Color.."Mini Vision".."|r"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBALL_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_WorldBoss.."WB"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_WorldBoss.."WB: Nazjatar"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBAssault_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_WorldBoss.."World Boss: Assault"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Icon_WorldBoss.."WB: PVP"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count
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
						vivodCent = E.Green_Color..CharInfo.azeriteLVL.."|r".."|n"..E.Gray_Color..CharInfo.azeriteEXP.."|r"
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
						vivodCent = vivodCent.."|n"..CharInfo.cloak_res
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
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront1_count
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
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront2_count
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
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count
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
								vivodCent = vivodCent .. E.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
							end
						end
						if k == 1 then
							vivodCent = CharInfo.CovenantAndAnima[i][k]
						else
							vivodCent = CharInfo.CovenantAndAnima[i][k]
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
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
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
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
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
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_texturefromIcon(4066373)..E.func_questName(63949)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.Icon_WorldBoss.."World Boss"
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.Icon_WorldBoss.."World Boss: "..E.func_questName(65143)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.Icon_WorldBoss.."World Boss: "..E.func_questName(64531)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  E.func_currencyIcon(1813)..E.func_questName(61981)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				tooltip[#tooltip+1] = {E.func_itemTexture(188957)..E.func_itemName(188957), CharInfo.MASLENGO.ItemsInBag[188957]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(187634)..E.func_itemName(187634), CharInfo.MASLENGO.ItemsInBag[187634]}
				tooltip[#tooltip+1] = {E.func_itemTexture(187636)..E.func_itemName(187636), CharInfo.MASLENGO.ItemsInBag[187636]}
				tooltip[#tooltip+1] = {E.func_itemTexture(187633)..E.func_itemName(187633), CharInfo.MASLENGO.ItemsInBag[187633]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189146)..E.func_itemName(189146), CharInfo.MASLENGO.ItemsInBag[189146]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189145)..E.func_itemName(189145), CharInfo.MASLENGO.ItemsInBag[189145]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189147)..E.func_itemName(189147), CharInfo.MASLENGO.ItemsInBag[189147]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189148)..E.func_itemName(189148), CharInfo.MASLENGO.ItemsInBag[189148]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189149)..E.func_itemName(189149), CharInfo.MASLENGO.ItemsInBag[189149]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189151)..E.func_itemName(189151), CharInfo.MASLENGO.ItemsInBag[189151]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189152)..E.func_itemName(189152), CharInfo.MASLENGO.ItemsInBag[189152]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189153)..E.func_itemName(189153), CharInfo.MASLENGO.ItemsInBag[189153]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189154)..E.func_itemName(189154), CharInfo.MASLENGO.ItemsInBag[189154]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189155)..E.func_itemName(189155), CharInfo.MASLENGO.ItemsInBag[189155]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189156)..E.func_itemName(189156), CharInfo.MASLENGO.ItemsInBag[189156]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(189157)..E.func_itemName(189157), CharInfo.MASLENGO.ItemsInBag[189157]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189158)..E.func_itemName(189158), CharInfo.MASLENGO.ItemsInBag[189158]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189159)..E.func_itemName(189159), CharInfo.MASLENGO.ItemsInBag[189159]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189160)..E.func_itemName(189160), CharInfo.MASLENGO.ItemsInBag[189160]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189161)..E.func_itemName(189161), CharInfo.MASLENGO.ItemsInBag[189161]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189162)..E.func_itemName(189162), CharInfo.MASLENGO.ItemsInBag[189162]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189163)..E.func_itemName(189163), CharInfo.MASLENGO.ItemsInBag[189163]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189164)..E.func_itemName(189164), CharInfo.MASLENGO.ItemsInBag[189164]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189165)..E.func_itemName(189165), CharInfo.MASLENGO.ItemsInBag[189165]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189166)..E.func_itemName(189166), CharInfo.MASLENGO.ItemsInBag[189166]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189167)..E.func_itemName(189167), CharInfo.MASLENGO.ItemsInBag[189167]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189168)..E.func_itemName(189168), CharInfo.MASLENGO.ItemsInBag[189168]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189169)..E.func_itemName(189169), CharInfo.MASLENGO.ItemsInBag[189169]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189170)..E.func_itemName(189170), CharInfo.MASLENGO.ItemsInBag[189170]}
				local count = 0
				if CharInfo.MASLENGO.ItemsInBag[188957] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187634] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187636] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187633] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189146] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189145] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189147] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189148] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189149] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189151] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189152] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189153] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189154] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189155] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189156] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189157] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189158] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189159] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189160] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189161] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189162] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189163] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189164] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189165] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189166] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189167] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189168] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189169] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189170] >= 1 then
					count = count + 1
				end
				vivodCent = count.."/".."29"
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return  "Кузня творения"
		end)
		--------------------------------
	end
	----------------------------------------------------------------
	if OctoToDo_DB_Vars.ExpansionToShow[10] then
		--------------------------------
		if OctoToDo_DB_Vars.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= "" and CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
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
				if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
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
				if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
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
				if CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count
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
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count
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
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count
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
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count
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
				if CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count
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
				if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
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
				if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
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
		if OctoToDo_DB_Vars.MP_MythicKeystone == true then
			--------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.UnitLevel == E.currentMaxLevel then
						if CharInfo.CurrentKeyFULL ~= 0 then
							tooltip[#tooltip+1] = {E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
							tooltip[#tooltip+1] = {" ", " "}
						end
					end
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
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.GreatVault[i].progress ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
							end
						end
					end
					if CharInfo.RIO_Score_TWW_S1 ~= 0 then
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_Score_TWW_S1.."|r"}
						tooltip[#tooltip+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_weeklyBest_TWW_S1.."|r"}
					end
					if CharInfo.CurrentKey ~= 0 then
						vivodCent = E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKey.."|r"
					end
					if CharInfo.HasAvailableRewards then
						vivodCent = vivodCent..E.Blue_Color..">Vault<|r"
					end
					if CharInfo.Chromie_inChromieTime == true then
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
					return  E.Timers.TWW_BeledarCycle() .. E.func_questName(83240)
			end)
		end
		--------------------------------
		--------------------------------
		if OctoToDo_DB_Vars.TWW_WorldBoss_Weekly == true then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return  E.Icon_WorldBoss..L["World Boss"]
			end)
		end
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
					return  E.func_texturefromIcon(132863) .. L["Major Keyflames"]
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
					return  E.func_texturefromIcon(135619) .. L["Minor Keyflames"]
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
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(1166)..E.func_questName(43323)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Daily ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Daily
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(3100)..E.func_questName(84616)
		end)
		--------------------------------
		--------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyIcon(3100)..E.func_questName(82783)
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
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {E.Timers.DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {E.Timers.DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.2.5".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Gilneas Reclamation"]..")", CharInfo.Octopussy_DF_Once_TheGilneasReclamationStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Azerothian Archives"]..")", CharInfo.Octopussy_DF_Once_AzerothianArchivesStorylines_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.2.0".."«"), " "}
					tooltip[#tooltip+1] ={E.Timers.DF_Flower()..E.func_questName(78319), CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Emerald Dream"]..")", CharInfo.Octopussy_DF_Once_ALLEmeraldDreamStorylines_count}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.func_questName(78821), CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.func_questName(78381), CharInfo.Octopussy_DF_Weekly_EmeraldDreamDreamsUnified_count}
					tooltip[#tooltip+1] ={L["Rares"], CharInfo.Octopussy_DF_Daily_EmeraldDreamRares_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.5".."«"), " "}
					tooltip[#tooltip+1] = {E.func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {E.Timers.DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zaralek Cavern"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_ResearchersUnderFire()..E.func_questName(74906), CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..E.func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {E.func_texturefromIcon(5062638)..E.func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {E.func_questName(75665), CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_texturefromIcon(4643981)..E.func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["The Forbidden Reach"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
				end
				if OctoToDo_DB_Vars.ExpansionToShow[9] then
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."Shadowlands".."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					-- tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_return vivodCent, tooltip
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zereth Mortis"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_name, CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBZMAntros_name, CharInfo.Octopussy_SL_Weekly_WBZMAntros_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_name, CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_name, CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRares_name, CharInfo.Octopussy_SL_Daily_ZMRares_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_name, CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMTREASURES_name, CharInfo.Octopussy_SL_Daily_ZMTREASURES_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMworldQuests_name, CharInfo.Octopussy_SL_Daily_ZMworldQuests_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMConcordance_name, CharInfo.Octopussy_SL_Once_ZMConcordance_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_name, CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Korthia"].."«"), " "}
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
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Maw"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Class quests"].."«"), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
						if CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.NONE and CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.DONE then
							tooltip[#tooltip+1] = {E.func_questName(24547), CharInfo.MASLENGO.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						tooltip[#tooltip+1] = {L["Green Fire"], CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"] ~= 0 then
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Race quests"].."«"), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"] ~= 0 then
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Allied Races Quests"] .."«"), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"]}
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
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r", w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (E.OctoTable_LFGDungeons) do
					if CharInfo.LFGInstance[dungeonID].donetoday ~= E.NONE then
						tooltip[#tooltip+1] = {CharInfo.LFGInstance[dungeonID].D_name, CharInfo.LFGInstance[dungeonID].donetoday}
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