local function WQEQWE()

	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 2 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(23572)..LibOctopussy:func_itemName(23572)
				if CharInfo.ItemsInBag[23572] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[23572]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(30183)..LibOctopussy:func_itemName(30183)
				if CharInfo.ItemsInBag[30183] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[30183]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(32428)..LibOctopussy:func_itemName(32428)
				if CharInfo.ItemsInBag[32428] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[32428]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(34664)..LibOctopussy:func_itemName(34664)
				if CharInfo.ItemsInBag[34664] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[34664]
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 3 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(52019)..LibOctopussy:func_itemName(52019)
				if CharInfo.ItemsInBag[52019] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[52019]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(43102)..LibOctopussy:func_itemName(43102)
				if CharInfo.ItemsInBag[43102] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[43102]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(45087)..LibOctopussy:func_itemName(45087)
				if CharInfo.ItemsInBag[45087] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[45087]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(47556)..LibOctopussy:func_itemName(47556)
				if CharInfo.ItemsInBag[47556] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[47556]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(49908)..LibOctopussy:func_itemName(49908)
				if CharInfo.ItemsInBag[49908] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[49908]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_reputationName(1156)
				vivodCent = CharInfo.reputationID[1156]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24545)
				vivodCent = CharInfo.OctoTable_QuestID[24545]
				if C_QuestLog.IsOnQuest(24545) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24545)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24743)
				vivodCent = CharInfo.OctoTable_QuestID[24743]
				if C_QuestLog.IsOnQuest(24743) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24743)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24547)
				vivodCent = CharInfo.OctoTable_QuestID[24547]
				if C_QuestLog.IsOnQuest(24547) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24547)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24749)
				vivodCent = CharInfo.OctoTable_QuestID[24749]
				if C_QuestLog.IsOnQuest(24749) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24749)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24756)
				vivodCent = CharInfo.OctoTable_QuestID[24756]
				if C_QuestLog.IsOnQuest(24756) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24756)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24757)
				vivodCent = CharInfo.OctoTable_QuestID[24757]
				if C_QuestLog.IsOnQuest(24757) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24757)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24548)
				vivodCent = CharInfo.OctoTable_QuestID[24548]
				if C_QuestLog.IsOnQuest(24548) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24548)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24549)
				vivodCent = CharInfo.OctoTable_QuestID[24549]
				if C_QuestLog.IsOnQuest(24549) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24549)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(24748)
				vivodCent = CharInfo.OctoTable_QuestID[24748]
				if C_QuestLog.IsOnQuest(24748) then
					tooltip[#tooltip+1] = {LibOctopussy:All_objectives(24748)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(49888)..LibOctopussy:func_itemName(49888)
				if CharInfo.ItemsInBag[49888] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[49888]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(49623)..LibOctopussy:func_itemName(49623)
				if CharInfo.ItemsInBag[49623] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[49623]
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 4 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(52078)..LibOctopussy:func_itemName(52078)
				if CharInfo.ItemsInBag[52078] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[52078]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(69237)..LibOctopussy:func_itemName(69237)
				if CharInfo.ItemsInBag[69237] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[69237]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_itemTexture(71998)..LibOctopussy:func_itemName(71998)
				if CharInfo.ItemsInBag[71998] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[71998]
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 5 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[697]
				vivodLeft = LibOctopussy:func_currencyicon(697)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(697)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[776]
				vivodLeft = LibOctopussy:func_currencyicon(776)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(776)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 6 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1129].."(+"..CharInfo.Octopussy_WoD_Weekly_coinsQuests_count..")"
				vivodLeft = LibOctopussy:func_currencyicon(1129)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(1129)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[994]
				vivodLeft = LibOctopussy:func_currencyicon(994)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(994)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[823]
				vivodLeft = LibOctopussy:func_currencyicon(823)..LibOctopussy:func_currencyName(823)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1101]
				vivodLeft = LibOctopussy:func_currencyicon(1101)..LibOctopussy:func_currencyName(1101)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[824]
				vivodLeft = LibOctopussy:func_currencyicon(824)..LibOctopussy:func_currencyName(824)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Draenor_Once_Garrison1_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison1_count
				end
				vivodLeft = L["Garrison 1 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Draenor_Once_Garrison2_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison2_count
				end
				vivodLeft = L["Garrison 2 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetFontObject(OctoFont1)
				if CharInfo.UnitLevel > 40 then
					if CharInfo.CurrencyID[824] < 2000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..CharInfo.CurrencyID[824]..LibOctopussy:func_currencyicon(824)
					else
						vivodCent = vivodCent..CharInfo.CurrencyID[824]..LibOctopussy:func_currencyicon(824).."|r"
					end
					if CharInfo.Money/10000 < 5000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000)
					else
						vivodCent = vivodCent..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000).."|r"
					end
					if CharInfo.Octopussy_Draenor_Once_Garrison3_count ~= E.Octo_Globals.NONE then
						CL:SetFontObject(OctoFont10)
						vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison3_count
					end
				else
					vivodCent = LibOctopussy:func_texturefromIcon(894556)..E.Octo_Globals.Red_Color..CharInfo.UnitLevel.."/40|r"
				end
				vivodLeft = L["Garrison 3 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[38242] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[38242]
				end
				if CharInfo.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.."+"..CharInfo.ItemsInBag[122457]..LibOctopussy:func_itemTexture(122457)
				end
				vivodLeft = LibOctopussy:func_questName(38242).." (ап пета)"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[39246] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[39246]
				end
				vivodLeft = LibOctopussy:func_questName(39246)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 7 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = (E.Octo_Timer.Legion_Invasion().."Timer_Legion_Invasion")
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = WorldBoss_Icon.."WB"
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Broken Shore - Armies of Legionfall"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
				end
				if CharInfo.OctoTable_QuestID[46246] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Broken Shore - Excavations"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
				end
				if CharInfo.OctoTable_QuestID[46666] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Broken Shore - ToArgus"
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = LibOctopussy:func_questName(43533)
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
				end
				if CharInfo.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1273] then
					vivodCent = CharInfo.CurrencyID_Total[1273].."(+"..CharInfo.Octopussy_Legion_Weekly_coinsQuests_count..")"
				end
				vivodLeft = LibOctopussy:func_currencyicon(1273)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(1273)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.CurrencyID_Total[1508]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1508)..LibOctopussy:func_currencyName(1508)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1342]
				vivodLeft = LibOctopussy:func_currencyicon(1342)..LibOctopussy:func_currencyName(1342)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1220]
				vivodLeft = LibOctopussy:func_currencyicon(1220)..LibOctopussy:func_currencyName(1220)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1226]
				vivodLeft = LibOctopussy:func_currencyicon(1226)..LibOctopussy:func_currencyName(1226)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1533]
				vivodLeft = LibOctopussy:func_currencyicon(1533)..LibOctopussy:func_currencyName(1533)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1155]
				vivodLeft = LibOctopussy:func_currencyicon(1155)..LibOctopussy:func_currencyName(1155)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[124124]
				end
				vivodLeft = E.Octo_Globals.Gray_Color..LibOctopussy:func_itemTexture(124124)..LibOctopussy:func_itemName_NOCOLOR(124124).."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				vivodLeft = "bounty_Legion1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				vivodLeft = "bounty_Legion2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				vivodLeft = "bounty_Legion3"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
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
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for className, classTable in pairs(E.Octo_Globals.OctoTable_LegionArtifacts) do
					for specName, specTable in pairs(classTable) do
						vivodLeft = className
						vivodCent = specName
						for number, sourceID in pairs(specTable) do
							if number == 1 or number == 2 or number == 3 or number == 4 then
								tooltip[#tooltip+1] = {number, sourceID}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 8 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = (E.Octo_Timer.BfA_Invasion().."Timer_BfA_Invasion (PVP)")
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Timer.BfA_Assault().."Timer_BfA_Assault (N'zoth)"
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
				end
				if CharInfo.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174765]..LibOctopussy:func_itemTexture(174765)
				end
				if CharInfo.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174761]..LibOctopussy:func_itemTexture(174761)
				end
				if CharInfo.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174767]..LibOctopussy:func_itemTexture(174767)
				end
				if CharInfo.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174766]..LibOctopussy:func_itemTexture(174766)
				end
				if CharInfo.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174768]..LibOctopussy:func_itemTexture(174768)
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174764)..CharInfo.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.ItemsInBag[174765]..LibOctopussy:func_itemTexture(174765)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174756)..CharInfo.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.ItemsInBag[174761]..LibOctopussy:func_itemTexture(174761)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174759)..CharInfo.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174767]..LibOctopussy:func_itemTexture(174767)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174760)..CharInfo.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174766]..LibOctopussy:func_itemTexture(174766)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174758)..CharInfo.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.ItemsInBag[174768]..LibOctopussy:func_itemTexture(174768)}
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Daily_miniVision_count)
				end
				vivodLeft = E.Octo_Globals.Purple_Color.."Mini Vision".."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = WorldBoss_Icon.."WB"
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBALL_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = WorldBoss_Icon.."WB: Nazjatar"
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBAssault_count)
				end
				vivodLeft = WorldBoss_Icon.."World Boss: Assault"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = WorldBoss_Icon.."WB: PVP"
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = Rares_Icon.."Rares: Darkshore"
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1560]
				vivodLeft = LibOctopussy:func_currencyicon(1560)..LibOctopussy:func_currencyName(1560)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1721]
				vivodLeft = LibOctopussy:func_currencyicon(1721)..LibOctopussy:func_currencyName(1721)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1803]
				vivodLeft = LibOctopussy:func_currencyicon(1803)..LibOctopussy:func_currencyName(1803)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1755]
				if CharInfo.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[173363]..LibOctopussy:func_itemTexture(173363)
				end
				vivodLeft = LibOctopussy:func_currencyicon(1755)..LibOctopussy:func_currencyName(1755)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1719]
				vivodLeft = LibOctopussy:func_currencyicon(1719)..LibOctopussy:func_currencyName(1719)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1710]
				vivodLeft = LibOctopussy:func_currencyicon(1710)..LibOctopussy:func_currencyName(1710)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1716]
				vivodLeft = LibOctopussy:func_currencyicon(1716)..LibOctopussy:func_currencyName(1716)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = CharInfo.CurrencyID_Total[1718]
				vivodLeft = LibOctopussy:func_currencyicon(1718)..LibOctopussy:func_currencyName(1718)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[158075] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no neck|r"
				end
				if CharInfo.ItemsInBag[158075] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = LibOctopussy:Empty_Zero(E.Octo_Globals.Green_Color..CharInfo.azeriteLVL.."|r").."|n"..E.Octo_Globals.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				vivodLeft = LibOctopussy:func_itemTexture(158075)..LibOctopussy:func_itemName(158075)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[169223] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no cloak|r"
				end
				if CharInfo.ItemsInBag[169223] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.."neeed to equip|r"
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
				vivodLeft = LibOctopussy:func_itemTexture(169223)..LibOctopussy:func_itemName(169223)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.islandBfA then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.islandBfA)
				end
				vivodLeft = "Collect_BfA_Island"
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					vivodLeft = LibOctopussy:func_questName(questID)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront1_count)
				end
				vivodLeft = "Warfront: Stromgarde"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront2_count)
				end
				vivodLeft = "Warfront: Darkshore"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.Octo_Globals.NONE then
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count)
				end
				vivodLeft = "Warfront: Heroic"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				vivodLeft = "bounty_BfA1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				vivodLeft = "bounty_BfA2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				vivodLeft = "bounty_BfA3"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[166846] ~= 0 or CharInfo.ItemsInBag[169610] ~= 0 or CharInfo.ItemsInBag[166970] ~= 0 or CharInfo.ItemsInBag[168327] ~= 0 or CharInfo.ItemsInBag[168832] ~= 0 or CharInfo.ItemsInBag[166971] ~= 0 or CharInfo.ItemsInBag[168946] ~= 0 or CharInfo.ItemsInBag[168215] ~= 0 or CharInfo.ItemsInBag[168216] ~= 0 or CharInfo.ItemsInBag[168217] ~= 0 then
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166846)..LibOctopussy:func_itemName(166846), CharInfo.ItemsInBag[166846]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(169610)..LibOctopussy:func_itemName(169610), CharInfo.ItemsInBag[169610]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166970)..LibOctopussy:func_itemName(166970), CharInfo.ItemsInBag[166970]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168327)..LibOctopussy:func_itemName(168327), CharInfo.ItemsInBag[168327]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168832)..LibOctopussy:func_itemName(168832), CharInfo.ItemsInBag[168832]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166971)..LibOctopussy:func_itemName(166971), CharInfo.ItemsInBag[166971]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168946)..LibOctopussy:func_itemName(168946), CharInfo.ItemsInBag[168946]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168215)..LibOctopussy:func_itemName(168215), CharInfo.ItemsInBag[168215]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168216)..LibOctopussy:func_itemName(168216), CharInfo.ItemsInBag[168216]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168217)..LibOctopussy:func_itemName(168217), CharInfo.ItemsInBag[168217]}
					vivodCent = "МЕХАГОН"
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Maw: Covenant Assault "..E.Octo_Timer.SL_Maw_Assault()
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[1] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[1])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[7] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[7])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[5] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[5])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[3] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[3])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[2] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[2])
				end
				if CharInfo.Shadowland[2] and CharInfo.Shadowland[2] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 1 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[8] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[8])
				end
				if CharInfo.Shadowland[8] and CharInfo.Shadowland[8] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 4 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[6] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[6])
				end
				if CharInfo.Shadowland[6] and CharInfo.Shadowland[6] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 3 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[4] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = LibOctopussy:Empty_Zero(CharInfo.Shadowland[4])
				end
				if CharInfo.Shadowland[4] and CharInfo.Shadowland[4] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 2 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID[2009])
				vivodLeft = LibOctopussy:func_currencyicon(2009)..LibOctopussy:func_currencyName(2009)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID[1906])
				vivodLeft = LibOctopussy:func_currencyicon(1906)..LibOctopussy:func_currencyName(1906)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID[1828])
				vivodLeft = LibOctopussy:func_currencyicon(1828)..LibOctopussy:func_currencyName(1828)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID[1979])
				vivodLeft = LibOctopussy:func_currencyicon(1979)..LibOctopussy:func_currencyName(1979)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID[1931])
				vivodLeft = LibOctopussy:func_currencyicon(1931)..LibOctopussy:func_currencyName(1931)
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				vivodLeft = LibOctopussy:func_texturefromIcon(4074774)..LibOctopussy:func_questName(66042)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				vivodLeft = LibOctopussy:func_texturefromIcon(4066373)..LibOctopussy:func_questName(63949)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..LibOctopussy:func_questName(65143)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..LibOctopussy:func_questName(64531)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				vivodLeft = LibOctopussy:func_currencyicon(1813)..LibOctopussy:func_questName(61981)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Кузня творения"
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(188957)..LibOctopussy:func_itemName(188957), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[188957])}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187634)..LibOctopussy:func_itemName(187634), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[187634])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187636)..LibOctopussy:func_itemName(187636), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[187636])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187633)..LibOctopussy:func_itemName(187633), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[187633])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189146)..LibOctopussy:func_itemName(189146), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189146])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189145)..LibOctopussy:func_itemName(189145), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189145])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189147)..LibOctopussy:func_itemName(189147), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189147])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189148)..LibOctopussy:func_itemName(189148), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189148])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189149)..LibOctopussy:func_itemName(189149), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189149])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189151)..LibOctopussy:func_itemName(189151), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189151])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189152)..LibOctopussy:func_itemName(189152), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189152])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189153)..LibOctopussy:func_itemName(189153), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189153])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189154)..LibOctopussy:func_itemName(189154), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189154])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189155)..LibOctopussy:func_itemName(189155), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189155])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189156)..LibOctopussy:func_itemName(189156), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189156])}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189157)..LibOctopussy:func_itemName(189157), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189157])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189158)..LibOctopussy:func_itemName(189158), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189158])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189159)..LibOctopussy:func_itemName(189159), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189159])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189160)..LibOctopussy:func_itemName(189160), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189160])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189161)..LibOctopussy:func_itemName(189161), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189161])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189162)..LibOctopussy:func_itemName(189162), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189162])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189163)..LibOctopussy:func_itemName(189163), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189163])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189164)..LibOctopussy:func_itemName(189164), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189164])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189165)..LibOctopussy:func_itemName(189165), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189165])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189166)..LibOctopussy:func_itemName(189166), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189166])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189167)..LibOctopussy:func_itemName(189167), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189167])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189168)..LibOctopussy:func_itemName(189168), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189168])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189169)..LibOctopussy:func_itemName(189169), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189169])}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189170)..LibOctopussy:func_itemName(189170), LibOctopussy:Empty_Zero(CharInfo.ItemsInBag[189170])}
				local count = 0
				if CharInfo.ItemsInBag[188957] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[187634] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[187636] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[187633] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189146] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189145] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189147] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189148] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189149] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189151] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189152] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189153] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189154] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189155] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189156] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189157] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189158] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189159] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189160] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189161] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189162] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189163] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189164] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189165] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189166] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189167] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189168] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189169] >= 1 then count = count + 1 end
				if CharInfo.ItemsInBag[189170] >= 1 then count = count + 1 end
				vivodCent = count.."/".."29"
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r"
					if CharInfo.CurrentKeyFULL ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:RIO_Color(CharInfo.RIO_Score_S3)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
						tooltip[#tooltip+1] = {" ", " "}
					end
					for i = 1, 3 do
						CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
						CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
						CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
						CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
						if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
							tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..LibOctopussy:RIO_Color(CharInfo.RIO_Score_S3)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
						elseif CharInfo.GreatVault[i].progress ~= 0 then
							tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
						end
					end
					if CharInfo.CurrentKey ~= 0 then
						vivodCent = LibOctopussy:RIO_Color(CharInfo.RIO_Score_S3)..CharInfo.CurrentKey.."|r"
					end
					if CharInfo.ItemsInBag[217409] ~= 0 or CharInfo.ItemsInBag[218114] ~= 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					if CharInfo.ItemsInBag[217409] ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(217409)..E.Octo_Globals.LightGray_Color..LibOctopussy:func_itemName_NOCOLOR(217409).."|r", CharInfo.ItemsInBag[217409]}
						vivodCent = vivodCent..E.Octo_Globals.LightGray_Color.."+".."|r"
					end
					if CharInfo.ItemsInBag[218114] ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(218114)..E.Octo_Globals.Orange_Color..LibOctopussy:func_itemName_NOCOLOR(218114).."|r", CharInfo.ItemsInBag[218114]}
						vivodCent = vivodCent..E.Octo_Globals.Orange_Color.."+".."|r"
					end
					if CharInfo.HasAvailableRewards then
						vivodCent = vivodCent..E.Octo_Globals.Blue_Color..">Vault<|r"
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(1603189)..L["Aiding the Accord"]
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= "" and CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.CommunityFeast == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(629056)..E.Octo_Timer.DF_CommunityFeast()..L["Community Feast"]
					if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
					end
					if CharInfo.ItemsInBag[200652] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200652]..LibOctopussy:func_itemTexture(200652)
					end
					if CharInfo.ItemsInBag[200095] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200095]..LibOctopussy:func_itemTexture(200095)
					end
					BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.ResearchersUnderFire == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(236469)..E.Octo_Timer.DF_ResearchersUnderFire()..LibOctopussy:func_questName(74906)
					if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.OctoTable_QuestID[75630]}
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.OctoTable_QuestID[75629]}
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.OctoTable_QuestID[75628]}
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.OctoTable_QuestID[75627]}
					end
					BG:SetColorTexture(.2, .58, .50, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.ResearchersUnderFire_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_questName(75665)
					if CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count
					end
					BG:SetColorTexture(.2, .58, .50, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Superbloom == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(134206)..E.Octo_Timer.DF_Flower()..LibOctopussy:func_questName(78319)
					if CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count
					end
					BG:SetColorTexture(1, 0, .28, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamBloomingDreamseeds == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_questName(78821)
					if CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count
					end
					BG:SetColorTexture(1, 0, .28, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamAWorthyAllyDreamWardens == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_questName(78444)
					if CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count
					end
					BG:SetColorTexture(1, 0, .28, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDreamDreamsUnified == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Once..LibOctopussy:func_questName(78381)
					if CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count
					end
					BG:SetColorTexture(1, 0, .28, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_DreamWardens == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_reputationName(2574)
					if CharInfo.reputationID[2574] ~= "" and CharInfo.reputationID[2574] ~= 0 and CharInfo.reputationID[2574] ~= E.Octo_Globals.DONE then
						vivodCent = CharInfo.reputationID[2574]
					end
					BG:SetColorTexture(1, 0, .28, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.TimeRift == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..(LibOctopussy:func_texturefromIcon(628677)..E.Octo_Timer.DF_TimeRift()..L["TimeRift"])
					if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.DilatedTimePod == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(209856)..LibOctopussy:func_itemName(209856)
					if CharInfo.ItemsInBag[209856] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[209856].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.EncapsulatedDestiny == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(207002)..LibOctopussy:func_itemName(207002)
					if CharInfo.ItemsInBag[207002] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.ItemsInBag[207002].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.ParacausalFlakes == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.CurrencyID[2594] ~= 0 then
						if CharInfo.CurrencyID[2594] < 500 then
							vivodCent = E.Octo_Globals.Gray_Color..CharInfo.CurrencyID[2594].."|r"
						else
							vivodCent = CharInfo.CurrencyID[2594]
						end
					end
					if CharInfo.ItemsInBag[208945] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.." +"..CharInfo.ItemsInBag[208945].."|r"..LibOctopussy:func_itemTexture(208945)
					end
					vivodLeft = LibOctopussy:func_currencyicon(2594)..E.Octo_Globals.WOW_Rare_Color..L["Transferable Flakes"]..":|r "..E.Octo_Globals.White_Color..TotalTransParacausalFlakes.."|r"
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Dreamsurges == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..(LibOctopussy:func_texturefromIcon(134206)..E.Octo_Timer.DF_Dreamsurges()..L["Dreamsurges"])
					if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
					end
					if CharInfo.ItemsInBag[209419] ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(1044087)..E.Octo_Globals.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.ItemsInBag[209419]}
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.DreamsurgeCocoon == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(210254)..E.Octo_Globals.WOW_Epic_Color..LibOctopussy:func_itemName_NOCOLOR(210254).."|r"
					if CharInfo.ItemsInBag[210254] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[210254].."|r"
					end
					if CharInfo.ItemsInBag[208153] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.Gray_Color.." +"..CharInfo.ItemsInBag[208153].."(old)|r"
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.DreamsurgeCoalescence == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(207026)..E.Octo_Globals.WOW_Common_Color..LibOctopussy:func_itemName_NOCOLOR(207026).."|r"
					if CharInfo.ItemsInBag[207026] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Common_Color..CharInfo.ItemsInBag[207026].."|r"
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.CatalystCharges == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.CurrencyID[2912] ~= 0 then
						vivodCent = LibOctopussy:Empty_Zero(CharInfo.CurrencyID_Total[2912])
					end
					vivodLeft = LibOctopussy:func_currencyicon(2912)..LibOctopussy:func_currencyName(2912)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Flightstones == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local color = "|cffFFFFFF"
					if CharInfo.CurrencyID[2245] ~= 0 then
						vivodCent = color..LibOctopussy:Empty_Zero(CharInfo.CurrencyID_Total[2245]).."|r"
					end
					vivodLeft = LibOctopussy:func_currencyicon(2245)..LibOctopussy:func_currencyName(2245)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.AntiqueBronzeBullion == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(213089)..LibOctopussy:func_itemName(213089)
					if CharInfo.ItemsInBag[213089] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[213089]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.SparkofAwakening == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(211516)..LibOctopussy:func_itemName(211516)
					if CharInfo.ItemsInBag[211516] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[211516]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.SplinteredSparkofAwakening == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(211515)..LibOctopussy:func_itemName(211515)
					if CharInfo.ItemsInBag[211515] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[211515]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Crests_Mythic == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local currencyID = 2812
					local text = "Mythic, M+6"
					local color = E.Octo_Globals.WOW_Legendary_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
					tooltip[#tooltip+1] = {" ", color..text.."|r"}
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Crests_Heroic == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local currencyID = 2809
					local text = "Heroic, M+2/+5"
					local color = E.Octo_Globals.WOW_Epic_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
					tooltip[#tooltip+1] = {" ", color..text.."|r"}
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Crests_Normal == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local currencyID = 2807
					local text = "Normal, M+0"
					local color = E.Octo_Globals.WOW_Rare_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
					tooltip[#tooltip+1] = {" ", color..text.."|r"}
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Vars.config.Crests_LFR == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local currencyID = 2806
					local text = "LFR, Heroic dung"
					local color = E.Octo_Globals.WOW_Uncommon_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
					tooltip[#tooltip+1] = {" ", color..text.."|r"}
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
			end)
		end
	end
	if Octo_ToDo_DB_Vars.config.Event == true then
		if Octo_ToDo_DB_Other.Holiday.Active[628] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(514016)..E.Octo_Globals.Weekly.."Cataclysm"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(514016)..E.Octo_Globals.Weekly..L["Firelands"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if (Octo_ToDo_DB_Other.Holiday.Active[622] or Octo_ToDo_DB_Other.Holiday.Active[559]) then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(514016)..E.Octo_Globals.Weekly.."Burning Crusade"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(237385)..E.Octo_Globals.Weekly..L["Black Temple"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1265] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1379226)..E.Octo_Globals.Weekly.."Legion"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[652] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1416740)..E.Octo_Globals.Weekly.."Mists of Pandaria"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[616] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(466283)..E.Octo_Globals.Weekly.."Wrath of the Lich King"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(237445)..E.Octo_Globals.Weekly..L["Ulduar"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1063] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(133594).."Warlords of Draenor"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Weekly..LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.CurrencyID[1166]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1352] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..E.Octo_Globals.Weekly..DUNGEONS.." Dragonfly"
					if CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1400] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = Octo_ToDo_DB_Other.Holiday.Collect[1400]
					if CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(4638724)..LibOctopussy:func_currencyName(2588)
					if CharInfo.CurrencyID[2588] ~= 0 then
						vivodCent = CharInfo.CurrencyID[2588]
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[479] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(354435)..E.Octo_Globals.Daily..Octo_ToDo_DB_Other.Holiday.Collect[479]
					if CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= "0/9" then
						vivodCent = CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count
					end
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[599] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(667491)..Octo_ToDo_DB_Other.Holiday.Collect[599]
					vivodCent = CharInfo.OctoTable_QuestID[72721]
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[613] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236683)..Octo_ToDo_DB_Other.Holiday.Collect[613]
					vivodCent = CharInfo.OctoTable_QuestID[72728]
					BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
	end
	if Octo_ToDo_DB_Vars.config.Holiday == true then
		if Octo_ToDo_DB_Other.Holiday.Active[341] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = "SummerFestival"
					if CharInfo.Octopussy_DF_Month_SummerFestival_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_SummerFestival_count.." ("..CharInfo.ItemsInBag[23247]..LibOctopussy:func_itemTexture(23247)..")"
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[372] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.LFGInstance[287].D_name ~= E.Octo_Globals.NONE then
						vivodLeft = LibOctopussy:func_texturefromIcon(236701)..CharInfo.LFGInstance[287].D_name
					end
					if CharInfo.LFGInstance[287].donetoday ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.LFGInstance[287].donetoday
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_texturefromIcon(133784)..LibOctopussy:func_itemName(37829)
					if CharInfo.ItemsInBag[37829] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[37829]
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..E.Octo_Globals.Once..LibOctopussy:func_questName(77155)
					if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
						vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_count
					end
					if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.DONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
						tooltip[#tooltip+1] = {E.Octo_Globals.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2022 58.26 67.58", CharInfo.OctoTable_QuestID[76531]}
						tooltip[#tooltip+1] = {"/way #2022 76.35 35.43", CharInfo.OctoTable_QuestID[77095]}
						tooltip[#tooltip+1] = {"/way #2022 47.67 83.27", CharInfo.OctoTable_QuestID[77744]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Octo_Globals.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2023 59.77 38.73", CharInfo.OctoTable_QuestID[77152]}
						tooltip[#tooltip+1] = {"/way #2023 28.61 60.45", CharInfo.OctoTable_QuestID[77099]}
						tooltip[#tooltip+1] = {"/way #2023 85.81 35.34", CharInfo.OctoTable_QuestID[77745]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Octo_Globals.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2024 62.79 57.74", CharInfo.OctoTable_QuestID[77746]}
						tooltip[#tooltip+1] = {"/way #2024 46.92 40.23", CharInfo.OctoTable_QuestID[77096]}
						tooltip[#tooltip+1] = {"/way #2024 12.39 49.33", CharInfo.OctoTable_QuestID[77097]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Octo_Globals.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2025 50.1 42.71", CharInfo.OctoTable_QuestID[77747]}
						tooltip[#tooltip+1] = {"/way #2025 52.2 81.5", CharInfo.OctoTable_QuestID[77155]}
						tooltip[#tooltip+1] = {"/way #2112 47.87 47.74", CharInfo.OctoTable_QuestID[77153]}
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..E.Octo_Globals.Once..LibOctopussy:func_questName(12492)
					if CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..E.Octo_Globals.Daily..LibOctopussy:func_questName(76591)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..E.Octo_Globals.Daily..LibOctopussy:func_questName(77208)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[324] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.LFGInstance[285].D_name ~= E.Octo_Globals.NONE then
						vivodLeft = LibOctopussy:func_texturefromIcon(133661)..CharInfo.LFGInstance[285].D_name
					end
					if CharInfo.LFGInstance[285].donetoday ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.LFGInstance[285].donetoday
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.ItemsInBag[33226] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[33226]
					end
					vivodLeft = LibOctopussy:func_texturefromIcon(236546)..LibOctopussy:func_itemName(33226)
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[409] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(307568)..E.Octo_Globals.Once..Octo_ToDo_DB_Other.Holiday.Collect[409]
					if CharInfo.Octopussy_DF_Once_DayoftheDead_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Once_DayoftheDead_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1397] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(136235)..E.Octo_Globals.Weekly..LibOctopussy:func_questName(60215)
					if CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(136235)..E.Octo_Globals.Weekly..LibOctopussy:func_questName(57300)
					if CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[404] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_texturefromIcon(236571)..E.Octo_Globals.Daily..Octo_ToDo_DB_Other.Holiday.Collect[404]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14053)..E.Octo_Globals.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.OctoTable_QuestID[14053]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14055)..E.Octo_Globals.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.OctoTable_QuestID[14055]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14048)..E.Octo_Globals.Gray_Color.." (Дун Морог)".."|r", CharInfo.OctoTable_QuestID[14048]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14051)..E.Octo_Globals.Gray_Color.." (Дун Морог)".."|r", CharInfo.OctoTable_QuestID[14051]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14054)..E.Octo_Globals.Gray_Color.." (Дарнас)".."|r", CharInfo.OctoTable_QuestID[14054]}
						end
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_HordePilgrimsBounty_count
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14059)..E.Octo_Globals.Gray_Color.." (Подгород)".."|r", CharInfo.OctoTable_QuestID[14059]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14058)..E.Octo_Globals.Gray_Color.." (Подгород)".."|r", CharInfo.OctoTable_QuestID[14058]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14061)..E.Octo_Globals.Gray_Color.." (Дуротар)".."|r", CharInfo.OctoTable_QuestID[14061]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14062)..E.Octo_Globals.Gray_Color.." (Дуротар)".."|r", CharInfo.OctoTable_QuestID[14062]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14060)..E.Octo_Globals.Gray_Color.." (Громовой Утес)".."|r", CharInfo.OctoTable_QuestID[14060]}
						end
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = LibOctopussy:func_itemTexture(44812)..LibOctopussy:func_itemName(44812)
					if CharInfo.ItemsInBag[44812] ~= 0 then
						vivodCent = CharInfo.ItemsInBag[44812]
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[141] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Daily..LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(7043)
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_questName(7043), CharInfo.OctoTable_QuestID[7043]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_questName(6983), CharInfo.OctoTable_QuestID[6983]}
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Once..LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(7045)
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count ~= "0/7" then
							vivodCent = CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count
						end
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count ~= "0/7" then
							vivodCent = CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count
						end
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Globals.Once..LibOctopussy:func_texturefromIcon(133202)..L["Gifts"]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_AllianceWinterVeil_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8744), CharInfo.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8768), CharInfo.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8769), CharInfo.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8803), CharInfo.OctoTable_QuestID[8803]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78131), CharInfo.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78504), CharInfo.OctoTable_QuestID[78504]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Once_HordeWinterVeil_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy__Once_HordeWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_HordeWinterVeil_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8768), CharInfo.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8744), CharInfo.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78504), CharInfo.OctoTable_QuestID[78504]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8769), CharInfo.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78131), CharInfo.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8803), CharInfo.OctoTable_QuestID[8803]}
					end
					BG:SetColorTexture(1, .4, .1, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
	end
	if Octo_ToDo_DB_Vars.config.Quests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Globals.Gray_Color..QUESTS_LABEL.."|r"
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {WorldBoss_Icon..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.2.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Gilneas Reclamation"]..")", CharInfo.Octopussy_DF_Once_TheGilneasReclamationStorylines_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Azerothian Archives"]..")", CharInfo.Octopussy_DF_Once_AzerothianArchivesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.2.0".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] ={E.Octo_Timer.DF_Flower()..LibOctopussy:func_questName(78319), CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Emerald Dream"]..")", CharInfo.Octopussy_DF_Once_ALLEmeraldDreamStorylines_count}
					tooltip[#tooltip+1] ={E.Octo_Globals.Weekly..LibOctopussy:func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.Octo_Globals.Daily..LibOctopussy:func_questName(78821), CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count}
					tooltip[#tooltip+1] ={E.Octo_Globals.Daily..LibOctopussy:func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.Octo_Globals.Daily..LibOctopussy:func_questName(78381), CharInfo.Octopussy_DF_Weekly_EmeraldDreamDreamsUnified_count}
					tooltip[#tooltip+1] ={E.Octo_Globals.Daily..L["Rares"], CharInfo.Octopussy_DF_Daily_EmeraldDreamRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.7".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Zaralek Cavern"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_ResearchersUnderFire()..LibOctopussy:func_questName(74906), CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {WorldBoss_Icon..LibOctopussy:func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(5062638)..LibOctopussy:func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(75665), CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(4643981)..LibOctopussy:func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["The Forbidden Reach"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Timer.DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
				end
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Zereth Mortis"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
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
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Korthia"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
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
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Maw"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 7 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.7".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Class quests"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
						if CharInfo.OctoTable_QuestID[24547] ~= E.Octo_Globals.NONE and CharInfo.OctoTable_QuestID[24547] ~= E.Octo_Globals.DONE then
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(24547), CharInfo.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						tooltip[#tooltip+1] = {L["Green Fire"], CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				for k, v in ipairs(E.Octo_Table.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Race quests"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
					end
				end
				for k, v in ipairs(E.Octo_Table.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Allied Races Quests"] .."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				else
					vivodCent = ""
				end
				return vivodCent, vivodLeft
		end)
	end




end