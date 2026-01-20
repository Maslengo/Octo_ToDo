local GlobalAddonName, E = ...
local L = E.L
function E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
	local funcNames = {
		"func_Otrisovka_Center_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	return "", nil, nil, nil
end
function E.func_Otrisovka_Center_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end


	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO






	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	TextCenter = E.func_TextCenter_Currency(CharInfo, id)
	if id == 1931 and pd.SL_Possible_CatalogedResearch then
		TextCenter = string.format("%s%s +%d|r", TextCenter, E.COLOR_PURPLE, pd.SL_Possible_CatalogedResearch)
	end
	if id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
				TextCenter = TextCenter..color.." +"..earnedSinceLastCollect.."|r"
			end
		end
	elseif id == 1822 then -- RENOWN
		local covenantID = pd.SL_covenantID
		if covenantID then
			local prefix = E.OctoTable_Covenant[covenantID].prefix
			-- local color = E.OctoTable_Covenant[covenantID].color
			local color = E.func_DB_COV_COLOR(covenantID)


		    local renown  = pd[prefix .. "_Renown"]
		    -- local anima   = pd[prefix .. "_Anima"]
		    if renown then
			    TextCenter = color..renown.."|r"
			end
		end
	elseif id == 1813 then -- ANIMA
		local covenantID = pd.SL_covenantID
		if covenantID then
			local prefix = E.OctoTable_Covenant[covenantID].prefix
			-- local color = E.OctoTable_Covenant[covenantID].color
			local color = E.func_DB_COV_COLOR(covenantID)
		    -- local renown  = pd[prefix .. "_Renown"]
		   	local anima = pd[prefix .. "_Anima"]
		   	if anima then
			    TextCenter = color..anima.."|r"
			end
		end

		if pd.SL_Possible_Anima then
			TextCenter = TextCenter..E.COLOR_BLUE.." +"..pd.SL_Possible_Anima.."|r"
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
function E.func_Otrisovka_Center_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
function E.func_Otrisovka_Center_RaidsOrDungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local cm = CharInfo.MASLENGO
	local JI_ID = tonumber(id)
	-- local SI_ID = E.func_EJ_to_SI(JI_ID)

	local instanceData = cm.journalInstance[JI_ID]
	if instanceData then
		-- Собираем все сложности в массив для сортировки
		local difficulties = {}
		for difficultyID, v in next, instanceData do
			difficulties[#difficulties+1] = {
				difficultyID = difficultyID,
				defeatedBosses = v.defeatedBosses or 0,
				totalBosses = v.totalBosses or 0,
				lastBossDefeated = v.lastBossDefeated or false
			}
		end

		-- Сортировка по приоритету из OctoTable_Difficulties
		table.sort(difficulties, function(a, b)
			local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
			local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
			return pa < pb
		end)

		-- Формируем текст
		for _, diff in ipairs(difficulties) do
			if diff.defeatedBosses > 0 then
				local color = diff.defeatedBosses == diff.totalBosses and E.COLOR_GREEN or (diff.lastBossDefeated and E.COLOR_YELLOW or E.COLOR_WHITE)
				TextCenter = TextCenter .. color .. diff.defeatedBosses .. "/" .. diff.totalBosses .. "|r "
			end
		end
	end

	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end

function E.func_Otrisovka_Center_UniversalQuests(categoryKey, CharInfo, dataType, data)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	if data.quests then
		local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		-- local showTooltip = data.showTooltip or false
		if CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] and CharInfo.MASLENGO.UniversalQuest[questKey].TextCenter then
			TextCenter = CharInfo.MASLENGO.UniversalQuest[questKey].TextCenter
			if type(TextCenter) == "boolean" then
				TextCenter = E.DONE
			end
		end
		return TextCenter, ColorCenter, FirstReputation, SecondReputation
	end
end
function E.func_Otrisovka_Center_Reputations(categoryKey, CharInfo, dataType, id)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	if cm.Reputation and cm.Reputation[id] and type(cm.Reputation[id]) == "table" then
		local OctoTable_reactionColors = E.OctoTable_reactionColors
		-- local FIRST, SECOND, ParagonCount, color, standingTEXT, repType = ("#"):split(cm.Reputation[id])
		-- local fir, sec, ParagonCount, col, standingTEXT, typ = ("#"):split(cm.Reputation[id])

		FirstReputation = cm.Reputation[id].FIRST or 0
		SecondReputation = cm.Reputation[id].SECOND or 0
		local ParagonCount = cm.Reputation[id].ParagonCount or 0
		local standingTEXT = cm.Reputation[id].standingTEXT or ""
		local repType = cm.Reputation[id].repType or 0
		local reaction = cm.Reputation[id].reaction or 0
		local rankInfocurrentLevel = cm.Reputation[id].rankInfocurrentLevel
		local rankInfomaxLevel = cm.Reputation[id].rankInfomaxLevel
		local renownLevel = cm.Reputation[id].renownLevel
		local renownMaxLevel = cm.Reputation[id].renownMaxLevel




		-- ColorCenter = cm.Reputation[id].color or E.COLOR_WHITE
		-- ColorCenter = E.COLOR_BLACK
		ColorCenter = E.func_DB_REP_COLOR(repType, reaction)
		local standingTEXT = ""


		if repType == 2 then -- FRIENDSHIP
			if rankInfocurrentLevel and rankInfomaxLevel then
				standingTEXT = rankInfocurrentLevel .. "/"..rankInfomaxLevel
			end
			-- ColorCenter = OctoTable_reactionColors[repType] or E.COLOR_PINK
		elseif repType == 3 then
			if renownLevel and renownMaxLevel then
				standingTEXT = renownLevel .. "/" .. renownMaxLevel
			end
			-- ColorCenter = OctoTable_reactionColors[repType] or E.COLOR_BLUE
		elseif repType == 1 then
			if reaction and gender then
				standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, gender)
			end
			if reaction then
				-- ColorCenter = OctoTable_reactionColors[repType][reaction] or E.COLOR_WHITE
			end
		elseif repType == 4 then
			standingTEXT = L["Paragon"]
			-- ColorCenter = OctoTable_reactionColors[repType] or E.COLOR_BLUE
		end


		-- FirstReputation = tonumber(FIRST)
		-- SecondReputation = tonumber(SECOND)
		-- ColorCenter = color
		-- local repType = tonumber(repType or 0)
		TextCenter = E.func_CompactFormatNumber(FirstReputation).."/"..E.func_CompactFormatNumber(SecondReputation)
		if TextCenter == "1/1" then
			TextCenter = ColorCenter..DONE.."|r"
			-- TextCenter = ColorCenter..standingTEXT.."|r"
		elseif TextCenter == "0/0" then
			TextCenter = ""
		end
		local paragonQuest = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].paragonQuest or false
		if paragonQuest and cm.ListOfParagonQuests[paragonQuest] then
			TextCenter = E.COLOR_PURPLE..">"..TextCenter.."<".."|r"
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
function E.func_Otrisovka_Center_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	if id == "GreatVault" then
		if pd.HasAvailableRewards then
			TextCenter = E.COLOR_BLUE..">"..REWARD.."<|r"
		else
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local name = E.name_activities[ID]
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local vaultMin = vaultData and vaultData.min or 0
				local rewards = vaultData and vaultData.rewards or {}
				if vaultMin ~= 0 then
					TextCenter = TextCenter..(" "..vaultMin.."/"..max)
				end
			end
		end
	end
	if id == "CurrentKey" then
		if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
			local keyName = E.func_formatMplusKey(pd.OwnedKeystoneLevel, pd.OwnedKeystoneChallengeMapID, false, false)
			TextCenter = keyName
		end
	end
	if id == "HeartofAzeroth" then
		if cm.Items.Bags[158075] or cm.Items.Bank[158075] then
			TextCenter = pd.azeriteLVL and E.COLOR_GREEN..pd.azeriteLVL.."|r".."+"..E.COLOR_GRAY..pd.azeriteEXP.."|r" or E.COLOR_ORANGE.."in bank|r"
		end
	end
	if id == "Ashjrakamas" then
		if cm.Items.Bags[169223] or cm.Items.Bank[169223] then
			if pd.cloak_lvl then
				TextCenter = E.COLOR_CYAN..AZERITE_ESSENCE_RANK:format(pd.cloak_lvl).."|r"
			else
				TextCenter = E.COLOR_ORANGE.."in bank|r"
			end
		end
	end
	if id == "LegionRemixResearch" then
		if cm.LegionRemixData and cm.LegionRemixData.barValue and cm.LegionRemixData.barMax then
			local barValue = cm.LegionRemixData.barValue
			local barMax = cm.LegionRemixData.barMax
			TextCenter = barValue.."/"..barMax
			if cm.LegionRemixData.TotalInfinityResearchQuests then
				TextCenter = barValue..E.COLOR_BLUE.."("..cm.LegionRemixData.TotalInfinityResearchQuests..")|r".."/"..barMax
			end
		end
	end
	if id == "ListOfQuests" then
		if pd.numQuests then
			-- TextCenter = pd.classColorHex..pd.numQuests.."/"..pd.maxNumQuestsCanAccept.."|r"
			TextCenter = pd.classColorHex..pd.numQuests.."|r"
		end
		if pd.numQuests_Paragon then
			TextCenter = TextCenter ..E.COLOR_BLUE.." +"..pd.numQuests_Paragon.."|r"
		end
	end
	if id == "LFGInstance" then
		local count = 0
		for instanceID, v in next, (cm.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w.instanceReset then
						count = count+1
					end
				end
			end
		end


		if cm.LFGInstance then
			for k, v in next, (cm.LFGInstance) do
				count = count+1
			end
		end

		-- for dungeonID, v in next, (cm.LFGInstance) do
		-- 	if v then
		-- 		if cm.LFGInstance[dungeonID].donetoday then
		-- 			count = count+1
		-- 		end
		-- 	end
		-- end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			if v then
				count = count+1
			end
		end
		if count ~= 0 then
			TextCenter = tostring(count)
		end
	end
	if id == "AllItems" then
		local count = 0
		for itemID in next, (E.OctoTable_itemID_ALL) do
			if tonumber(itemID) == 249400 then
			end
			if cm.Items.Bags[itemID] or cm.Items.Bank[itemID] then
				count = count+1
				break
			end
		end
		if count > 0 then
			TextCenter = E.COLOR_GRAY..ITEMS.."|r"
		end
	end
	if id == "Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				if i == 1 or i == 2 then
					TextCenter = TextCenter..E.func_ProfessionIcon(charProf[i].skillLine).." "
				end
			end
		end
	end
	if id == "ItemLevel" then
		TextCenter = E.func_CharInfo_ItemLevel(CharInfo)
		-- .." ".. E.func_CharInfo_Durability(CharInfo, true, 41)
	end
	if id == "Money" then
		if pd.Money then
			TextCenter = E.func_GetColorGradient(pd.Money, E.minValue_Money, E.maxValue_Money)..E.func_FormatMoney(pd.Money)
		end
	end
	if id == "LastOnline" then
		local color = E.COLOR_WHITE
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				TextCenter = E.COLOR_GREEN..FRIENDS_LIST_ONLINE.."|r"
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				TextCenter = color..E.func_FormatTimeAgo(pd.time).."|r"
			end
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
function E.func_TextCenter_Items(CharInfo, itemID)
	if not itemID then return "" end
	local result = ""
	local cm = CharInfo.MASLENGO
	local Bags = cm.Items.Bags[itemID] or 0
	local Bank = cm.Items.Bank[itemID] or 0
	if Bags > 0 then
		result = result .. E.func_CompactFormatNumber(Bags)
	end
	if Bank > 0 then
		result = result .. E.COLOR_GRAY.."+"..E.func_CompactFormatNumber(Bank).."|r"
	end
	return result
end
function E.func_TextCenter_Currency(CharInfo, currencyID, itemID)
	local data = CharInfo.MASLENGO.Currency
	if not data[currencyID] then return "" end
	local result = ""
	local color = E.COLOR_WHITE
	if data[currencyID].quantity then
		result = result..E.func_CompactFormatNumber(data[currencyID].quantity)
		if data[currencyID].maxQuantity and data[currencyID].maxQuantity ~= 0 then
			if data[currencyID].quantity == data[currencyID].maxQuantity then
				color = E.COLOR_GREEN
			end
			result = color..result.."/"..E.func_CompactFormatNumber(data[currencyID].maxQuantity).."|r"
		end
	end
	if data[currencyID].totalEarned and data[currencyID].maxQuantity then
		local curQuantity = E.func_CompactFormatNumber(data[currencyID].quantity or 0)
		result = E.func_CompactFormatNumber(data[currencyID].totalEarned)
		result = " ("..result.."/"..E.func_CompactFormatNumber(data[currencyID].maxQuantity)..")"
		result = color..curQuantity..result.."|r"
	end
	if itemID then
		result = result..E.COLOR_GREEN..E.func_TextCenter_Items(CharInfo, itemID, true).."|r"
	end
	return result
end