local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")




function E.func_vivodCent(CharInfo)

		local vivod = CharInfo.classColorHex..CharInfo.Name.."|r"
		if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerCanEarnExperience == true then
			vivod = vivod.." "..E.Yellow_Color..CharInfo.UnitLevel.."|r"
		end
		return vivod
end

function E.CreateTooltipPlayers(CharInfo)
	local tooltip = {}
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
			if CharInfo.MASLENGO.ItemsInBag[122284] ~= nil then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(122284)..E.func_itemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
			end
			if CharInfo.ReloadCount ~= 0 then
				tooltip[#tooltip+1] = {"Reload Count: "..CharInfo.classColorHex..CharInfo.ReloadCount.."|r"}
			end
			if E.DebugInfo then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.DEVTEXT, " "}
				tooltip[#tooltip+1] = {E.Purple_Color.."GUID".."|r", E.Purple_Color..CharInfo.GUID.."|r"}
				if CharInfo.hasMail ~= false then
					tooltip[#tooltip+1] = {"hasMail", E.func_texturefromIcon(E.Icon_MailBox)..CharInfo.classColorHex.."true|r"}
				end
				tooltip[#tooltip+1] = {"Chromie_canEnter", CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
				tooltip[#tooltip+1] = {"Chromie_UnitChromieTimeID", CharInfo.Chromie_UnitChromieTimeID.."|r"}
				if CharInfo.Chromie_name ~= nil then
					tooltip[#tooltip+1] = {"Chromie_name", CharInfo.classColorHex..CharInfo.Chromie_name.."|r"}
				end
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
			end
	return tooltip
end











function E:func_Otrisovka()
	local OctoTable_func_otrisovkaCENT = {}
	local OctoTable_func_otrisovkaLEFT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	for expID, expDATA in ipairs(E.OctoTable_Expansions) do
		if Octo_ToDo_DB_Vars.ExpansionToShow[expID] then
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if expDATA.nameShort == v.desc then
					----------------------------------------------------------------
					tinsert(OctoTable_func_otrisovkaCENT,
						function(CharInfo)
							local vivodCent, tooltip = " ", {}
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								vivodCent = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							end
							return vivodCent, tooltip
					end)
					tinsert(OctoTable_func_otrisovkaLEFT,
						function()
							return tostringall(v.textleft).."|r", v.icon, expDATA.color
					end)
				end
			end
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	for _, v in ipairs(E.OctoTable_UniversalQuest) do
		if v.desc == "Another" or v.desc == "Timewalk" then
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
						vivodCent = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function()
					return tostringall(v.textleft).."|r", v.icon, E.Blue_Color
			end)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	tinsert(OctoTable_func_otrisovkaCENT,
		function(CharInfo)
			local vivodCent, tooltip = " ", {}
			if CharInfo.Chromie_inChromieTime == false then
				if CharInfo.CurrentKeyName and CharInfo.CurrentKeyName ~= 0 then
					tooltip[#tooltip+1] = {E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyName.."|r", ""}
				end
				if CharInfo.RIO_Score ~= 0 then
					tooltip[#tooltip+1] = {" ", " "}
					local Enum_Activities_table = {}
					for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
						Enum_Activities_table[#Enum_Activities_table+1] = i
					end
					sort(Enum_Activities_table)
					for j = 1, #Enum_Activities_table do
						local i = Enum_Activities_table[j]
						if CharInfo.PIZDALISHE.GreatVault[i] and CharInfo.PIZDALISHE.GreatVault[i].type ~= "" then
							CharInfo.PIZDALISHE.GreatVault[i] = CharInfo.PIZDALISHE.GreatVault[i] or {}
							CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING = CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING or 0
							CharInfo.PIZDALISHE.GreatVault[i].progress = CharInfo.PIZDALISHE.GreatVault[i].progress or 0
							CharInfo.PIZDALISHE.GreatVault[i].threshold = CharInfo.PIZDALISHE.GreatVault[i].threshold or 0
							if CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.PIZDALISHE.GreatVault[i].type, CharInfo.PIZDALISHE.GreatVault[i].progress.."/"..CharInfo.PIZDALISHE.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.PIZDALISHE.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.PIZDALISHE.GreatVault[i].progress ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.PIZDALISHE.GreatVault[i].type, CharInfo.PIZDALISHE.GreatVault[i].progress.."/"..CharInfo.PIZDALISHE.GreatVault[i].threshold}
							end
						end
					end
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_weeklyBest.."|r"}
					tooltip[#tooltip+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_Score.."|r"}
				end
				if CharInfo.CurrentKey ~= 0 then
					vivodCent = E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKey.."|r"
				end
				if CharInfo.HasAvailableRewards then
					vivodCent = vivodCent..E.Blue_Color..">Vault<|r"
				end
			else
				if CharInfo.Chromie_name ~= nil then
					vivodCent = vivodCent..E.Red_Color..CharInfo.Chromie_name.."|r"
				end
			end
			return vivodCent, tooltip
	end)
	tinsert(OctoTable_func_otrisovkaLEFT,
		function(CharInfo)
			return E.WOW_Epic_Color..L["Mythic Keystone"].."|r", 4352494
	end)
	if Octo_ToDo_DB_Vars.ExpansionToShow[2] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(23572), E.func_GetItemIcon(23572)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(30183), E.func_GetItemIcon(30183)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(32428), E.func_GetItemIcon(32428)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(34664), E.func_GetItemIcon(34664)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT, -- 24581(Horde) 24579(Alliance)
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[24581] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[24581]
				elseif CharInfo.MASLENGO.ItemsInBag[24579] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[24579]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				-- if CharInfo.Faction == "Horde" then
					return E.func_itemName(24581), E.func_GetItemIcon(24581)
				-- else
				-- 	return E.func_itemName(24579), E.func_GetItemIcon(24579)
				-- end
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[3] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(45087), E.func_GetItemIcon(45087)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(47556), E.func_GetItemIcon(47556)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(49908), E.func_GetItemIcon(49908)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[4] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(52078), E.func_GetItemIcon(52078)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(69237), E.func_GetItemIcon(69237)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(71998), E.func_GetItemIcon(71998)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[5] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[697] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[697]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697), E.func_GetCurrencyIcon(697)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[776] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[776]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776), E.func_GetCurrencyIcon(776)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[6] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1129] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1129]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129), E.func_GetCurrencyIcon(1129)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[994] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[994]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994), E.func_GetCurrencyIcon(994)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[823] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[823]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(823), E.func_GetCurrencyIcon(823)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1101] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1101]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1101), E.func_GetCurrencyIcon(1101)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[824] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[824]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(824), E.func_GetCurrencyIcon(824)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				tooltip[#tooltip+1] = {E.func_itemTexture(114128)..E.func_itemName(114128), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114128])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114129)..E.func_itemName(114129), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114129])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114131)..E.func_itemName(114131), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114131])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114616)..E.func_itemName(114616), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114616])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114081)..E.func_itemName(114081), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114081])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114622)..E.func_itemName(114622), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114622])}
				tooltip[#tooltip+1] = {E.func_itemTexture(128307)..E.func_itemName(128307), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128307])}
				tooltip[#tooltip+1] = {E.func_itemTexture(120313)..E.func_itemName(120313), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[120313])}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(114745)..E.func_itemName(114745), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114745])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114808)..E.func_itemName(114808), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114808])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114822)..E.func_itemName(114822), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114822])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114807)..E.func_itemName(114807), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114807])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114806)..E.func_itemName(114806), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114806])}
				tooltip[#tooltip+1] = {E.func_itemTexture(114746)..E.func_itemName(114746), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114746])}
				tooltip[#tooltip+1] = {E.func_itemTexture(128308)..E.func_itemName(128308), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128308])}
				vivodCent = SPELL_UPGRADE
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return GARRISON_FOLLOWERS_TITLE
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] ~= nil then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[38242]
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= nil then
					vivodCent = vivodCent.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_itemTexture(122457)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(38242).." (ап пета)"
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] ~= nil then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[39246]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(39246)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[7] then
		----------------------------------------------------------------
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
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273), E.func_GetCurrencyIcon(1273)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1508] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1508), E.func_GetCurrencyIcon(1508)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1342]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1342), E.func_GetCurrencyIcon(1342)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1220]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1220), E.func_GetCurrencyIcon(1220)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1226]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1226), E.func_GetCurrencyIcon(1226)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1533]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1533), E.func_GetCurrencyIcon(1533)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1155]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1155), E.func_GetCurrencyIcon(1155)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(124124), E.func_GetItemIcon(124124)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[8] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1560] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1560]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1560), E.func_GetCurrencyIcon(1560)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1721] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1721]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1721), E.func_GetCurrencyIcon(1721)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1803] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1803]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1803), E.func_GetCurrencyIcon(1803)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1755] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= nil then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_itemTexture(173363)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1755), E.func_GetCurrencyIcon(1755)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1719] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1719]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1719), E.func_GetCurrencyIcon(1719)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1710] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1710]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1710), E.func_GetCurrencyIcon(1710)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1716] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1716]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1716), E.func_GetCurrencyIcon(1716)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1718]
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1718), E.func_GetCurrencyIcon(1718)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}



				if CharInfo.MASLENGO.ItemsInBag[158075] == nil then
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
				return E.func_itemName(158075), E.func_GetItemIcon(158075)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[169223] == nil then
					vivodCent = E.Red_Color.."no cloak|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[169223] ~= nil then
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
				return E.func_itemName(169223), E.func_GetItemIcon(169223)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.PIZDALISHE.islandBfA ~= nil then
					vivodCent = CharInfo.PIZDALISHE.islandBfA
				end
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
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				tooltip[#tooltip+1] = {E.func_itemTexture(166846)..E.func_itemName(166846), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166846])}
				tooltip[#tooltip+1] = {E.func_itemTexture(169610)..E.func_itemName(169610), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[169610])}
				tooltip[#tooltip+1] = {E.func_itemTexture(166970)..E.func_itemName(166970), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166970])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168327)..E.func_itemName(168327), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168327])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168832)..E.func_itemName(168832), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168832])}
				tooltip[#tooltip+1] = {E.func_itemTexture(166971)..E.func_itemName(166971), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166971])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168946)..E.func_itemName(168946), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168946])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168215)..E.func_itemName(168215), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168215])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168216)..E.func_itemName(168216), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168216])}
				tooltip[#tooltip+1] = {E.func_itemTexture(168217)..E.func_itemName(168217), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168217])}
				vivodCent = "МЕХАГОН"
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "МЕХАГОН"
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[9] then
		local BGcolor
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				----------------------------------------------------------------
				tinsert(OctoTable_func_otrisovkaCENT,
					function(CharInfo)
						local vivodCent, tooltip = " ", {}
						if kCovenant == 1 then
							vivodCent = vivodCent..E.func_EmptyZero(CharInfo.PIZDALISHE.CovenantAndAnima[iANIMA][kCovenant])
						else
							vivodCent = vivodCent..E.func_EmptyZero(CharInfo.PIZDALISHE.CovenantAndAnima[iANIMA][kCovenant])
						end
						vivodCent = E.OctoTable_Covenant[iANIMA].color..vivodCent.."|r"
						if iANIMA == CharInfo.PIZDALISHE.CovenantAndAnima.curCovID then
							if CharInfo.Possible_Anima ~= 0 and kCovenant == 2 then
								vivodCent = vivodCent..E.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
							end
							BGcolor = E.OctoTable_Covenant[iANIMA].color
						else
							BGcolor = nil
						end
						return vivodCent, tooltip, BGcolor
				end)
				tinsert(OctoTable_func_otrisovkaLEFT,
					function(CharInfo)
						local vivodLeft = E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r"
						if kCovenant == 2 then
							vivodLeft = vivodLeft.. E.func_texturefromIcon(E.func_GetCurrencyIcon(1813))
						end
						return vivodLeft, E.OctoTable_Covenant[iANIMA].icon
				end)
			end
		end
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2009] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2009]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2009), E.func_GetCurrencyIcon(2009)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1906] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1906]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1906), E.func_GetCurrencyIcon(1906)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1828] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1828]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1828), E.func_GetCurrencyIcon(1828)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1979] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1979]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1979), E.func_GetCurrencyIcon(1979)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1931] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1931]
				end
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1931), E.func_GetCurrencyIcon(1931)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[10] then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= nil then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(209856), E.func_GetItemIcon(209856)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= nil then
					vivodCent = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(207002), E.func_GetItemIcon(207002)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2594] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= nil then
					vivodCent = vivodCent..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_itemTexture(208945)
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2594), E.func_GetCurrencyIcon(2594)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= nil then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= nil then
					vivodCent = vivodCent..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.WOW_Epic_Color..E.func_GetItemName(210254).."|r", E.func_GetItemIcon(210254)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[2245] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2245]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2245), E.func_GetCurrencyIcon(2245)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(213089), E.func_GetItemIcon(213089)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(211516), E.func_GetItemIcon(211516)
		end)
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= nil then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_itemName(211515), E.func_GetItemIcon(211515)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[11] then
		if Octo_ToDo_DB_Vars.GildedHarbingerCrest == true then
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					return color..E.func_currencyName(currencyID).."|r", E.func_GetCurrencyIcon(currencyID)
			end)
		end
		if Octo_ToDo_DB_Vars.RunedHarbingerCrest == true then
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					return color..E.func_currencyName(currencyID).."|r", E.func_GetCurrencyIcon(currencyID)
			end)
		end
		if Octo_ToDo_DB_Vars.CarvedHarbingerCrest == true then
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					return color..E.func_currencyName(currencyID).."|r", E.func_GetCurrencyIcon(currencyID)
			end)
		end
		if Octo_ToDo_DB_Vars.WeatheredHarbingerCrest == true then
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= nil then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, tooltip
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					return color..E.func_currencyName(currencyID).."|r", E.func_GetCurrencyIcon(currencyID)
			end)
		end
	end
	if Octo_ToDo_DB_Vars.DebugInfo == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				tooltip[#tooltip+1] = {E.DEVTEXT, ""}
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
				return E.DEVTEXT..E.Blue_Color.."ALL|r"
		end)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		E.func_TableRemoveDuplicates(list)
		sort(list)
		for i, value in ipairs(list) do
			----------------------------------------------------------------
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local vivodCent, tooltip = " ", {}
					tooltip[#tooltip+1] = {E.DEVTEXT, ""}
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
					return E.DEVTEXT..i
			end)
		end
	end
	if Octo_ToDo_DB_Vars.Timewalk == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.CurrencyID[1166] ~= nil then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1166), E.func_GetCurrencyIcon(1166)
		end)
	end



	if Octo_ToDo_DB_Vars.Quests == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.maxNumQuestsCanAccept ~= 0 then
					vivodCent = CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return QUESTS_LABEL
		end)
	end
	if Octo_ToDo_DB_Vars.Dungeons == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.PIZDALISHE.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..instanceID.."|r" or ""), w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (CharInfo.PIZDALISHE.LFGInstance) do
					if v then
						if CharInfo.PIZDALISHE.LFGInstance[dungeonID].donetoday ~= nil then
							tooltip[#tooltip+1] = {CharInfo.PIZDALISHE.LFGInstance[dungeonID].D_name..(E.DebugIDs and E.Gray_Color.. " id:"..dungeonID.."|r" or ""), CharInfo.PIZDALISHE.LFGInstance[dungeonID].donetoday}
						end
					end
				end
				for worldBossID, v in next, (CharInfo.PIZDALISHE.SavedWorldBoss) do
					if v then
						tooltip[#tooltip+1] = {E.func_texturefromIcon(E.Icon_WorldBoss).. v.name .." ".. E.Red_Color..E.func_SecondsToClock(v.reset).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..worldBossID.."|r" or ""), " "}
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
	end
	if Octo_ToDo_DB_Vars.Currency == true then
		----------------------------------------------------------------
		-- tinsert(OctoTable_func_otrisovkaCENT,
		-- 	function(CharInfo)
		-- 		local vivodCent, tooltip = " ", {}
		-- 		for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
		-- 			for CurrencyID, config in next, (tbl) do
		-- 				if Octo_ToDo_DB_Vars.CurrencyShowAllways == false and config == true and CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= nil then
		-- 					tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
		-- 				elseif Octo_ToDo_DB_Vars.CurrencyShowAllways == true and config == true then
		-- 					if CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= nil then
		-- 						tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
		-- 					else
		-- 						tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.Gray_Color..E.func_currencyName_NOCOLOR(CurrencyID), E.Gray_Color..CharInfo.MASLENGO.CurrencyID_Total[CurrencyID].."|r"}
		-- 					end
		-- 				end
		-- 			end
		-- 		end
		-- 		if #tooltip ~= 0 then
		-- 			vivodCent = E.Gray_Color..CURRENCY.."|r"
		-- 		else
		-- 			vivodCent = ""
		-- 		end
		-- 		return vivodCent, tooltip
		-- end)
		-- tinsert(OctoTable_func_otrisovkaLEFT,
		-- 	function(CharInfo)
		-- 		return CURRENCY
		-- end)
	end
	-- if Octo_ToDo_DB_Vars.Reputations == true then
	-- end
	if Octo_ToDo_DB_Vars.Items == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				for index, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if CharInfo.MASLENGO.ItemsInBag[itemID] ~= nil then
						tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
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
	end
	if Octo_ToDo_DB_Vars.Professions == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.MASLENGO.professions[1].skillLine ~= nil and CharInfo.MASLENGO.professions[1].skillLine ~= 0 then
					vivodCent = vivodCent..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine)
					if CharInfo.MASLENGO.professions[2].skillLine ~= nil and CharInfo.MASLENGO.professions[2].skillLine ~= 0 then
						vivodCent = vivodCent.." "..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[2].skillLine)
					end
				end
				for i = 1, 5 do
					if CharInfo.MASLENGO.professions[i].skillLine ~= nil and CharInfo.MASLENGO.professions[i].skillLine ~= 0 then
						tooltip[#tooltip+1] = {E.func_ProfessionIcon(CharInfo.MASLENGO.professions[i].skillLine)..E.func_ProfessionName(CharInfo.MASLENGO.professions[i].skillLine), CharInfo.MASLENGO.professions[i].skillLevel.."/"..CharInfo.MASLENGO.professions[i].maxSkillLevel}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return PROFESSIONS_BUTTON
		end)
	end
	if Octo_ToDo_DB_Vars.Gold == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				if CharInfo.Money then
					vivodCent = E.func_CompactNumberFormat(CharInfo.Money/10000)
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Red_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Green_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					end
				end
				return vivodCent, tooltip
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return BONUS_ROLL_REWARD_MONEY, E.Icon_Money
		end)
	end
	if Octo_ToDo_DB_Vars.ItemLevel == true then
		----------------------------------------------------------------
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
	end
	if Octo_ToDo_DB_Vars.WasOnline == true then
		----------------------------------------------------------------
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local vivodCent, tooltip = " ", {}
				local color = "|cffFFFFFF"
				-- tooltip[#tooltip+1] = {E.Timers.Daily_Reset()}
				-- tooltip[#tooltip+1] = {" ", " "}
				if CharInfo.loginHour and CharInfo.loginDay then
					if CharInfo.GUID == E.curGUID then
						vivodCent = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
						tooltip[#tooltip+1] = {"Время после релоуда: "..CharInfo.classColorHex.. E.func_SecondsToClock(GetServerTime() - CharInfo.time).."|r"}
						tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, CharInfo.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r"      )}
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
	end
	return OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT
end
