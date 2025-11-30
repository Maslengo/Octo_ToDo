local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 91

E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[9].icon
E.OctoTables_Vibor[currentSTATE].name = "91_Other"
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Items = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {

}
----------------------------------------------------------------
function E.func_Otrisovka_91_Other()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Quests then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				tooltipKey = "ListOfQuests"
				----------------------------------------------------------------
				if CharInfo.PlayerData.numQuests then
					textCENT = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.numQuests.."/"..CharInfo.PlayerData.maxNumQuestsCanAccept.."|r"
				end
				----------------------------------------------------------------
				textLEFT = QUESTS_LABEL
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Dungeons then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				----------------------------------------------------------------
				tooltipKey = "Other_LFGInstance"
				local count = 0
					for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
						if v then
							for difficultyID, w in next, (v) do
								if w.vivod then
									count = count + 1
								end
							end
						end
					end
					for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
						if v then
							if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday then
								count = count + 1
							end
						end
					end
					for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
						if v then
							count = count + 1
						end
					end
				if count ~= 0 then
					textCENT = count
					-- textCENT = E.Gray_Color..DUNGEONS.."|r"
				end
				----------------------------------------------------------------
				textLEFT = DUNGEONS
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Items then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				----------------------------------------------------------------
				tooltipKey = "Other_Items"
				local count = 0
				for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if CharInfo.MASLENGO.ItemsInBag[itemID] then
						count = count + 1
						break
					end
				end
				if count ~= 0 then
					textCENT = E.Gray_Color..ITEMS.."|r"
				end
				----------------------------------------------------------------
				textLEFT = ITEMS
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Professions then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				tooltipKey = "Other_professions"
				----------------------------------------------------------------
				local charProf = CharInfo.MASLENGO.professions
				for i = 1, 5 do
					if charProf[i] and charProf[i].skillLine then
						if i == 1 or i == 2 then
							textCENT = textCENT..E.func_ProfessionIcon(charProf[i].skillLine).." "
						end
					end
				end
				----------------------------------------------------------------
				textLEFT = PROFESSIONS_BUTTON
				myType = {"professions"}
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ItemLevel then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				tooltipKey = "Other_ItemLevel"
				----------------------------------------------------------------
				local color = E.Red_Color
				local ItemLevelGreen = 625
				local ItemLevelOrange = 610
				local ItemLevelRed = 580
				if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
					if CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelGreen then
						color = E.Green_Color
					elseif CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelOrange then
						color = E.Yellow_Color
					elseif CharInfo.PlayerData.avgItemLevelEquipped >= ItemLevelRed then
						color = E.Orange_Color
					end
				end
				if CharInfo.PlayerData.avgItemLevelEquipped and CharInfo.PlayerData.avgItemLevel then
					textCENT = color..CharInfo.PlayerData.avgItemLevelEquipped
					if CharInfo.PlayerData.avgItemLevel > CharInfo.PlayerData.avgItemLevelEquipped then
						textCENT = textCENT.."/"..CharInfo.PlayerData.avgItemLevel.."|r"
					end
					if CharInfo.PlayerData.avgItemLevelPvp and CharInfo.PlayerData.avgItemLevelPvp > CharInfo.PlayerData.avgItemLevel then
						textCENT = textCENT..E.Green_Color.."+|r"
					end
				end
				----------------------------------------------------------------
				textLEFT = STAT_AVERAGE_ITEM_LEVEL
				myType = {"ItemLevel"}
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Gold then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				tooltipKey = "Other_Money"
				----------------------------------------------------------------
				if CharInfo.PlayerData.Money then
					textCENT = E.func_MoneyString(CharInfo.PlayerData.Money)
					if CharInfo.PlayerData.MoneyOnLogin then
						if CharInfo.PlayerData.Money < CharInfo.PlayerData.MoneyOnLogin then
							textCENT = textCENT..E.Red_Color.."-|r"
						elseif CharInfo.PlayerData.Money > CharInfo.PlayerData.MoneyOnLogin then
							textCENT = textCENT..E.Green_Color.."+|r"
						end
					end
				end
				----------------------------------------------------------------
				textLEFT = BONUS_ROLL_REWARD_MONEY
				myType = {"Money"}
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Config_WasOnline then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", {}, nil, {}, nil,  false, nil, nil
				tooltipKey = "Other_WasOnline"
				----------------------------------------------------------------
				local color = "|cffFFFFFF"
				if CharInfo.PlayerData.loginHour and CharInfo.PlayerData.loginDay then
					if CharInfo.PlayerData.GUID == E.curGUID then
						textCENT = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
					else
						if CharInfo.PlayerData.needResetWeekly then
							color = E.Gray_Color
						elseif CharInfo.PlayerData.needResetDaily then
							color = E.Red_Color
						end
						textCENT = color..E.func_FriendsFrame_GetLastOnline(CharInfo.PlayerData.time).."|r"
					end
				end
				textLEFT = L["Was online"]
				myType = {"Online"}
				----------------------------------------------------------------
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end