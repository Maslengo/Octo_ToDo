local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_textCENT_Chars(CharInfo)
	local namePart = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r"
	local levelPart = ""
	local serverPart = ""
	if CharInfo.PlayerData.UnitLevel and CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerData.PlayerCanEarnExperience then
		levelPart = " "..E.Yellow_Color..CharInfo.PlayerData.UnitLevel.."|r"
	end
	if not Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and
	E:func_CurServerShort(E.curServer) ~= CharInfo.PlayerData.curServer then
		serverPart = E.Skyblue_Color..CharInfo.PlayerData.curServer.."|r"
	end
	return namePart..levelPart.."|n"..serverPart
end
----------------------------------------------------------------
local function AddDoubleLine(left, right, tooltip)
	tooltip[#tooltip+1] = {left, right or ""}
end
----------------------------------------------------------------
function E:func_Tooltip_Chars(CharInfo)
	local tooltip_Chars = {}
	-- Basic character information
	if CharInfo.PlayerData.classColorHex then
		-- Name and guild info
		if CharInfo.PlayerData.Name and CharInfo.PlayerData.curServer then
			tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r ("..CharInfo.PlayerData.curServer..")"}
		end
		if CharInfo.PlayerData.guildRankName and CharInfo.PlayerData.guildRankIndex then
			tooltip_Chars[#tooltip_Chars+1] = {"<"..E.Green_Color..CharInfo.PlayerData.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.PlayerData.guildRankName.."|r".."]"}
		end
		-- War mode status
		if CharInfo.PlayerData.WarMode == true then
			tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""}
		end
		-- Level and race info
		if CharInfo.PlayerData.RaceLocal then
			if CharInfo.PlayerData.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerData.UnitXPPercent then
				tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.RaceLocal.." "..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.UnitLevel.."-го|r уровня "..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.UnitXPPercent.."%|r", ""}
			else
				tooltip_Chars[#tooltip_Chars+1] = {CharInfo.PlayerData.RaceLocal, ""}
			end
		end
		-- Spec and class info
		if CharInfo.PlayerData.specName and CharInfo.PlayerData.specIcon then
			tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(CharInfo.PlayerData.specIcon)..CharInfo.PlayerData.specName.." "..CharInfo.PlayerData.className, ""}
		end
	end
	-- Chromie time info
	if CharInfo.PlayerData.Chromie_name and CharInfo.PlayerData.Chromie_name ~= "" then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {L["Chromie"]..": "..E.Red_Color..CharInfo.PlayerData.Chromie_name.."|r", ""}
	end
	-- Location info
	if CharInfo.PlayerData.BindLocation then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(134414)..string.format(BIND_ZONE_DISPLAY, CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.BindLocation.."|r"), ""}
	end
	if CharInfo.PlayerData.curLocation then
		tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(132319)..FRIENDS_LIST_ZONE..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.curLocation.."|r", ""}


	end
	-- Inventory info
	if CharInfo.PlayerData.usedSlots and CharInfo.PlayerData.totalSlots then
		tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(133634)..L["Bags"]..": "..CharInfo.PlayerData.classColorHex..(CharInfo.PlayerData.usedSlots.."/"..CharInfo.PlayerData.totalSlots).."|r", ""}
	end
	-- Quests info
	if CharInfo.PlayerData.numQuests and CharInfo.PlayerData.maxNumQuestsCanAccept then
		tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(236664)..QUESTS_LABEL..": "..CharInfo.PlayerData.classColorHex..(CharInfo.PlayerData.numQuests.."/"..CharInfo.PlayerData.maxNumQuestsCanAccept).."|r", ""}
	end
	-- Play time info
	if CharInfo.PlayerData.realTotalTime then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.PlayerData.classColorHex..E:func_SecondsToClock(CharInfo.PlayerData.realTotalTime)).."|r", ""}
		tooltip_Chars[#tooltip_Chars+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.PlayerData.classColorHex..E:func_SecondsToClock(CharInfo.PlayerData.realLevelTime)).."|r", ""}
	end
	-- Special item info
	if CharInfo.MASLENGO.ItemsInBag[122284] then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {E:func_texturefromIcon(E:func_GetItemIconByID(122284))..E:func_GetItemNameByID(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
	end




	-- Debug information
	if E.DebugInfo then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {E.DEVTEXT, ""}




		if CharInfo.PlayerData.tmstp_Daily then
			tooltip_Chars[#tooltip_Chars+1] = {"tmstp_Daily: "..CharInfo.PlayerData.classColorHex..E:func_SecondsToClock(CharInfo.PlayerData.tmstp_Daily-GetServerTime()).."|r", ""}
		end
		if CharInfo.PlayerData.tmstp_Weekly then
			tooltip_Chars[#tooltip_Chars+1] = {"tmstp_Weekly: "..CharInfo.PlayerData.classColorHex..E:func_SecondsToClock(CharInfo.PlayerData.tmstp_Weekly-GetServerTime()).."|r", ""}
		end



		-- Character identification
		tooltip_Chars[#tooltip_Chars+1] = {E.Purple_Color.."GUID".."|r", E.Purple_Color..CharInfo.PlayerData.GUID.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"hasMail", CharInfo.PlayerData.hasMail and E:func_texturefromIcon(E.Icon_MailBox)..CharInfo.PlayerData.classColorHex.."true|r" or E.NIL}
		-- Chromie time debug info
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_canEnter", CharInfo.PlayerData.Chromie_canEnter and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"Chromie_UnitChromieTimeID", CharInfo.PlayerData.Chromie_UnitChromieTimeID or E.NIL.."|r"}
		if CharInfo.PlayerData.Chromie_name then
			tooltip_Chars[#tooltip_Chars+1] = {"Chromie_name", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Chromie_name.."|r"}
		end
		-- BattleTag info
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTag", E.Blue_Color..CharInfo.PlayerData.BattleTag.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"BattleTagLocal", E.Blue_Color..CharInfo.PlayerData.BattleTagLocal.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account restrictions
		tooltip_Chars[#tooltip_Chars+1] = {"GameLimitedMode_IsActive", CharInfo.PlayerData.GameLimitedMode_IsActive and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"levelCapped20", CharInfo.PlayerData.levelCapped20 and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"PlayerCanEarnExperience", CharInfo.PlayerData.PlayerCanEarnExperience and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Build info
		tooltip_Chars[#tooltip_Chars+1] = {"buildVersion", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"buildNumber", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildNumber.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"buildDate", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.buildDate.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"interfaceVersion", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.interfaceVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Version info
		tooltip_Chars[#tooltip_Chars+1] = {"currentTier", CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.currentTier.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {"IsPublicBuild", CharInfo.PlayerData.IsPublicBuild and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account limits
		tooltip_Chars[#tooltip_Chars+1] = {"max LVL", CharInfo.PlayerData.GetRestrictedAccountData_rLevel and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"max Money", CharInfo.PlayerData.GetRestrictedAccountData_rMoney and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account security
		tooltip_Chars[#tooltip_Chars+1] = {"Authenticator", CharInfo.PlayerData.IsAccountSecured and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"УЗ имеет ограничения пробной УЗ", CharInfo.PlayerData.IsRestrictedAccount and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"Использует ли игрок пробную УЗ", CharInfo.PlayerData.IsTrialAccount and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {"Нет игрового времени", CharInfo.PlayerData.IsVeteranTrialAccount and E.TRUE or E.NIL}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Durability
		tooltip_Chars[#tooltip_Chars+1] = {"PlayerDurability", CharInfo.PlayerData.PlayerDurability and E.TRUE or E.NIL}
		-- DBVersion
		tooltip_Chars[#tooltip_Chars+1] = {"DBVersion", CharInfo.PlayerData.DBVersion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegion", CharInfo.PlayerData.CurrentRegion}
		tooltip_Chars[#tooltip_Chars+1] = {"CurrentRegionName", CharInfo.PlayerData.CurrentRegionName}
	end
	return tooltip_Chars
end
----------------------------------------------------------------
function E:func_Otrisovka_91_Other()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.DebugInfo == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				for _, v in next, (E.OctoTable_UniversalQuest) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] == E.DONE then
						tooltipRIGHT[#tooltipRIGHT+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Green_Color.."Выполненные|r"
				end
				----------------------------------------------------------------
				iconLEFT = E.IconTexture
				textLEFT = E.DEVTEXT..E.Blue_Color.."ALL|r"
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			table.insert(list, v.desc)
		end
		E:func_TableRemoveDuplicates(list)
		table.sort(list)
		for i, value in ipairs(list) do
			table.insert(OctoTable_Otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
					----------------------------------------------------------------
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltipRIGHT[#tooltipRIGHT+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							textCENT = value
						end
					end
					----------------------------------------------------------------
					iconLEFT = E.IconTexture
					textLEFT = E.DEVTEXT..i
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
					----------------------------------------------------------------
			end)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Quests == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.PlayerData.numQuests then
					textCENT = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.numQuests.."/"..CharInfo.PlayerData.maxNumQuestsCanAccept.."|r"
					local questIDs = {}
					for questID in next, CharInfo.MASLENGO.ListOfQuests do
						questIDs[#questIDs+1] = questID
					end
					table.sort(questIDs, E.func_Reverse_order)
					for i = 1, #questIDs do
						local questID = questIDs[i]
						tooltipRIGHT[i] = {E:func_questName(questID), CharInfo.MASLENGO.ListOfQuests[questID]}
					end
				end
				----------------------------------------------------------------
				textLEFT = QUESTS_LABEL
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		E:func_Universal_Holiday(OctoTable_Otrisovka, "Storyline", E.Holiday_Color)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Dungeons == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod then
								tooltipRIGHT[#tooltipRIGHT+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E:func_SecondsToClock(w.instanceReset-ServerTime).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..instanceID.."|r" or ""), w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
					if v then
						if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday then
							tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.LFGInstance[dungeonID].D_name..(E.DebugIDs and E.Gray_Color.. " id:"..dungeonID.."|r" or ""), CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday}
						end
					end
				end
				for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
					if v then
						tooltipRIGHT[#tooltipRIGHT+1] = {E:func_texturefromIcon(E.Icon_WorldBoss).. v.name .." ".. E.Red_Color..E:func_SecondsToClock(v.reset).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..worldBossID.."|r" or ""), ""}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Gray_Color..DUNGEONS.."|r"
				end
				----------------------------------------------------------------
				textLEFT = DUNGEONS
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Items == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				for index, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if CharInfo.MASLENGO.ItemsInBag[itemID] then
						tooltipRIGHT[#tooltipRIGHT+1] = {E:func_texturefromIcon(E:func_GetItemIconByID(itemID))..E:func_GetItemNameByID(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Gray_Color..ITEMS.."|r"
				end
				----------------------------------------------------------------
				textLEFT = ITEMS
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Professions == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				local charProf = CharInfo.MASLENGO.professions
				for i = 1, 5 do
					if charProf[i] and charProf[i].skillLine then
						if i == 1 or i == 2 then
							textCENT = textCENT..E:func_ProfessionIcon(charProf[i].skillLine).." "
						end
						local leftText = E:func_ProfessionIcon(charProf[i].skillLine).." "..E:func_ProfessionName(charProf[i].skillLine)
						local RightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
						if charProf[i].skillModifier then
							RightText = charProf[i].skillLevel.."|cff00FF00+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
						end
						tooltipRIGHT[#tooltipRIGHT+1] = {leftText, RightText}
						if charProf[i].child then
							-- for expIndex, v in ipairs(charProf[i].child) do
							for expIndex = #charProf[i].child, 1, -1 do
								local v = charProf[i].child[expIndex]
								if v.QWEskillLevel and v.QWEprofessionName then
									-- for expI, j in ipairs(E.OctoTable_Expansions) do
									-- for expI = #E.OctoTable_Expansions, 1, -1 do
									-- local j = E.OctoTable_Expansions[expI]
									local j = E.OctoTable_Expansions[expIndex]
									tooltipRIGHT[#tooltipRIGHT+1] = {" "..E:func_texturefromIcon(j.icon, 16, 32).." "..j.color..j.nameVeryShort.."|r ", v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
									-- end
									-- end
								end
							end
						end
					end
				end

				----------------------------------------------------------------
				textLEFT = PROFESSIONS_BUTTON
				myType = {"professions"}
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ItemLevel == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
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
						tooltipRIGHT[#tooltipRIGHT+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.PlayerData.avgItemLevelPvp)}
					end
				end
				----------------------------------------------------------------
				textLEFT = STAT_AVERAGE_ITEM_LEVEL
				myType = {"ItemLevel"}
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Gold == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.PlayerData.Money then
					textCENT = E:func_CompactNumberFormat(CharInfo.PlayerData.Money/10000)
					if CharInfo.PlayerData.MoneyOnLogin then
						if CharInfo.PlayerData.Money < CharInfo.PlayerData.MoneyOnLogin then
							textCENT = textCENT..E.Red_Color.."-|r"
							tooltipRIGHT[#tooltipRIGHT+1] = {"lost: ", E.Red_Color..E:func_CompactNumberFormat((CharInfo.PlayerData.Money - CharInfo.PlayerData.MoneyOnLogin)/10000).."|r "..E:func_texturefromIcon(E.Icon_Money)}
						elseif CharInfo.PlayerData.Money > CharInfo.PlayerData.MoneyOnLogin then
							textCENT = textCENT..E.Green_Color.."+|r"
							tooltipRIGHT[#tooltipRIGHT+1] = {"received: ", E.Green_Color..E:func_CompactNumberFormat((CharInfo.PlayerData.Money - CharInfo.PlayerData.MoneyOnLogin)/10000).."|r "..E:func_texturefromIcon(E.Icon_Money)}
						end
					end
				end
				----------------------------------------------------------------
				textLEFT = BONUS_ROLL_REWARD_MONEY
				-- iconLEFT = E.Icon_Money
				-- iconLEFT = "coin-gold"
				myType = {"Money"}
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.WasOnline == true then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, nil, "", {}, nil, {}
				----------------------------------------------------------------
				local color = "|cffFFFFFF"
				if CharInfo.PlayerData.loginHour and CharInfo.PlayerData.loginDay then
					if CharInfo.PlayerData.GUID == E.curGUID then
						textCENT = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
						-- tooltipRIGHT[#tooltipRIGHT+1] = {"Время после релоуда: "..CharInfo.PlayerData.classColorHex.. E:func_SecondsToClock(GetServerTime() - CharInfo.PlayerData.time).."|r"}
						-- tooltipRIGHT[#tooltipRIGHT+1] = {string.format(TIME_PLAYED_ALERT, CharInfo.PlayerData.classColorHex..E:func_SecondsToClock(GetSessionTime()).."|r" )}
					else
						if CharInfo.PlayerData.needResetWeekly == true then
							color = E.Gray_Color
						elseif CharInfo.PlayerData.needResetDaily == true then
							color = E.Red_Color
						end
						textCENT = color..E.func_FriendsFrame_GetLastOnline(CharInfo.PlayerData.time).."|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {color..E:func_FriendsFrame_GetLastOnlineText(CharInfo.PlayerData.time, CharInfo.PlayerData.classColorHex).."|r", ""}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", ""}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", color..CharInfo.PlayerData.loginDay.."|r"}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", color..CharInfo.PlayerData.loginHour.."|r"}
					end
				end
				textLEFT = L["Was online"]
				myType = {"Online"}
				----------------------------------------------------------------
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end
----------------------------------------------------------------