local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
function E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
	-- Пробуем разные варианты названий функций
	local funcNames = {
		"func_Otrisovka_Center_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] --[[and dataType ~= "UniversalQuests"]] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	-- Если функция не найдена, возвращаем значения по умолчанию
	-- TextCenter, ColorCenter, FirstReputation, SecondReputation
	return "", nil, nil, nil
end
function E.func_Otrisovka_Center_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	TextCenter = E.func_TextCenter_Currency(CharInfo, id)
	if id == 1931 and CharInfo.PlayerData.Possible_CatalogedResearch then
		TextCenter = string.format("%s%s +%d|r", TextCenter, E.COLOR_PURPLE, CharInfo.PlayerData.Possible_CatalogedResearch)
	end
	if id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
				TextCenter = TextCenter..color.." +"..earnedSinceLastCollect.."|r"
			end
		end
	elseif id == 1822 then
		local typeSL = 1 -- Renown
		if CharInfo.MASLENGO.CovenantAndAnima.curCovID then
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
			if CharInfo.MASLENGO.CovenantAndAnima[curCovID] then
				local color = E.OctoTable_Covenant[curCovID].color
				ColorCenter = color
				if CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL] then
					TextCenter = color..CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL].."|r"
				end
			end
		end
	elseif id == 1813 then
		local typeSL = 2 -- Anima
		if CharInfo.MASLENGO.CovenantAndAnima.curCovID then
			local curCovID = CharInfo.MASLENGO.CovenantAndAnima.curCovID
			if CharInfo.MASLENGO.CovenantAndAnima[curCovID] then
				local color = E.OctoTable_Covenant[curCovID].color
				ColorCenter = color
				if CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL] then
					TextCenter = color..CharInfo.MASLENGO.CovenantAndAnima[curCovID][typeSL].."|r"
				end
			end
		end
		if CharInfo.PlayerData.Possible_Anima then
			TextCenter = TextCenter..E.COLOR_BLUE.." +"..CharInfo.PlayerData.Possible_Anima.."|r"
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_RaidsOrDungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local JI_ID = tonumber(id)
	local SI_ID = E.func_EJ_to_SI(JI_ID)

	if cm.journalInstance[SI_ID] then
		for difficultyID, v in next,(cm.journalInstance[SI_ID]) do
			local defeatedBosses = cm.journalInstance[SI_ID][difficultyID].defeatedBosses or 0
			local totalBosses = cm.journalInstance[SI_ID][difficultyID].totalBosses or 0
			local difficultyName = GetDifficultyInfo(difficultyID)
			local lastBossDefeated = cm.journalInstance[SI_ID][difficultyID].lastBossDefeated or false
			local color = defeatedBosses == totalBosses and E.COLOR_GREEN or (lastBossDefeated and E.COLOR_YELLOW or E.COLOR_RED)
			if defeatedBosses > 0 then
				TextCenter = TextCenter..color..defeatedBosses .. "/" .. totalBosses.."|r "
			end
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	----------------------------------------------------------------
end
-- function E.func_Otrisovka_Center_UniversalQuests(tbl, DESCRIPT)
function E.func_Otrisovka_Center_UniversalQuests(categoryKey, CharInfo, dataType, data)
	----------------------------------------------------------------
	if data.quests then
		----------------------------------------------------------------
		local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
		----------------------------------------------------------------
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		----------------------------------------------------------------
		local showTooltip = data.showTooltip or false
		if CharInfo.MASLENGO.UniversalQuest and CharInfo.MASLENGO.UniversalQuest[questKey] then
			local LeftData = CharInfo.MASLENGO.UniversalQuest[questKey].TextCenter
			if LeftData then
				local totalQuest = 0
				local forcedMaxQuest = data.forcedMaxQuest
				-- Подсчет общего числа квестов
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == CharInfo.PlayerData.Faction then
						if forcedMaxQuest and type(forcedMaxQuest) == "string" and forcedMaxQuest == "all" then
							totalQuest = totalQuest + 1
						elseif forcedMaxQuest and type(forcedMaxQuest) == "number" then
							totalQuest = forcedMaxQuest
							break
						else
							totalQuest = totalQuest + 1
						end
					end
				end
				forcedMaxQuest = totalQuest
				-- Формирование текста в центре
				if type(LeftData) == "number" and forcedMaxQuest then
					TextCenter = LeftData >= forcedMaxQuest and E.DONE or LeftData.."/"..forcedMaxQuest
				elseif forcedMaxQuest ~= 1 then
					TextCenter = "0/"..forcedMaxQuest
				elseif type(LeftData) == "string" then
					TextCenter = LeftData
				end
			end
		end
		----------------------------------------------------------------
		return TextCenter, ColorCenter, FirstReputation, SecondReputation
		----------------------------------------------------------------
	end -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Reputations(categoryKey, CharInfo, dataType, id) -- func_Otrisovka_LEFT_Dispatcher
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local STANDINGSREP = {
		[1] = "SIMPLE",
		[2] = "Friend",
		[3] = "major",
		[4] = "paragon",
	}
	 -- 1 simple, 2 Friend, 3 major, 4 paragon
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	if cm.Reputation and cm.Reputation[id] and type(cm.Reputation[id]) == "string" then
		local fir, sec, ParagonCount, col, standingTEXT, typ = ("#"):split(cm.Reputation[id])
		FirstReputation = tonumber(fir)
		SecondReputation = tonumber(sec)
		ColorCenter = col
		local repType = tonumber(typ or 0)
		-- local percent = (SecondReputation > 0) and math.floor(FirstReputation / SecondReputation * 100) or 0
		-- local percentResult = percent and percent > 0 and percent < 100 and " |cff888888"..percent.."%|r" or ""
		TextCenter = E.func_CompactFormatNumber(FirstReputation).."/"..E.func_CompactFormatNumber(SecondReputation)

		-- local newStandingTEXT = ""
		-- if string.find(standingTEXT, "/") then
		-- 	newStandingTEXT = standingTEXT
		-- end
		-- TextCenter = TextCenter..col..newStandingTEXT.."|r"


		if TextCenter == "1/1" then
			TextCenter = E.DONE
		elseif TextCenter == "0/0" then
			TextCenter = ""
		end


		for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
			if id == v.factionID and cm.ListOfParagonQuests[questID] then
				TextCenter = E.COLOR_PURPLE..">"..TextCenter.."<".."|r"
			end
		end
	end
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	----------------------------------------------------------------
end
function E.func_Otrisovka_Center_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	----------------------------------------------------------------
	if id == "GreatVault" then
		if pd.HasAvailableRewards then
			TextCenter = E.COLOR_BLUE..">"..REWARD.."<|r"
		else
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local name = E.name_activities[ID]
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				-- Безопасное получение данных из cm.GreatVault
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local vaultMin = vaultData and vaultData.min or 0
				local rewards = vaultData and vaultData.rewards or {}
				-- TextCenter = TextCenter..(rewards[1] or "-")..(rewards[1] or "-")..(rewards[1] or "-")
				if vaultMin ~= 0 then
					TextCenter = TextCenter..(" "..vaultMin.."/"..max)
				end
				-- tooltip[#tooltip+1] = {
				-- 	name,
				-- 	" ",
				-- 	" ",
				-- 	vaultMin.."/"..max,
				-- 	" ",
				-- 	" ",
				-- 	rewards[1] or "-",
				-- 	rewards[2] or "-",
				-- 	rewards[3] or "-"
				-- }
			end
		end
	end
	if id == "CurrentKey" then -- ПОФИКСИТЬ
		if pd.CurrentKey then
			TextCenter = pd.CurrentKey
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
			TextCenter = pd.classColorHex..pd.numQuests.."/"..pd.maxNumQuestsCanAccept.."|r"
		end
	end
	if id == "LFGInstance" then
		local count = 0
		for instanceID, v in next, (cm.journalInstance) do
			if v then
				for difficultyID, w in next, (v) do
					if w.instanceReset then
						count = count + 1
					end
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if v then
				if cm.LFGInstance[dungeonID].donetoday then
					count = count + 1
				end
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			if v then
				count = count + 1
			end
		end
		if count ~= 0 then
			TextCenter = tostring(count)
			-- TextCenter = E.COLOR_GRAY..DUNGEONS.."|r"
		end
	end
	if id == "AllItems" then
		local count = 0
		for _, itemID in ipairs(E.OctoTable_itemID_ALL) do
			if cm.Items.Bags[itemID] or cm.Items.Bank[itemID] then
				count = count + 1
				break
			end
		end
		if count ~= 0 then
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
		----------------------------------------------------------------
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			-- TextCenter = color..pd.avgItemLevelEquipped
			TextCenter = E.func_GetColorGradient(pd.avgItemLevelEquipped, E.minValue_ItemLevel, E.maxValue_ItemLevel)..pd.avgItemLevelEquipped
			if pd.avgItemLevel > pd.avgItemLevelEquipped then
				TextCenter = TextCenter.."/"..pd.avgItemLevel.."|r"
			end
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				TextCenter = TextCenter..E.COLOR_GREEN.."+|r"
			end
		end
	end
	----------------------------------------------------------------
	if id == "Money" then
		if pd.Money then
			TextCenter = E.func_GetColorGradient(pd.Money, E.minValue_Money, E.maxValue_Money)..E.func_FormatMoney(pd.Money)
			-- TextCenter = E.func_FormatMoney(pd.Money)
			-- if pd.MoneyOnLogin then
			-- if pd.Money < pd.MoneyOnLogin then
			-- TextCenter = TextCenter..E.COLOR_RED.."-|r"
			-- elseif pd.Money > pd.MoneyOnLogin then
			-- TextCenter = TextCenter..E.COLOR_GREEN.."+|r"
			-- end
			-- end
		end
	end
	if id == "WasOnline" then
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
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_TextCenter_Items(CharInfo, itemID, showIcon)
	if not itemID then return "" end
	showIcon = showIcon or false
	local result = ""
	local cm = CharInfo.MASLENGO
	if type(itemID) == "number" then
		if cm.Items.Bags[itemID] then
			result = result .. cm.Items.Bags[itemID]
		end
		if cm.Items.Bank[itemID] then
			result = result .. E.COLOR_GRAY.."+"..cm.Items.Bank[itemID].."|r"
		end
	elseif type(itemID) == "table" then
		for _, v in ipairs(itemID) do
			if cm.Items.Bags[itemID] then
				result = result .. cm.Items.Bags[itemID]
			end
			if cm.Items.Bank[itemID] then
				result = result .. E.COLOR_GRAY.."+"..cm.Items.Bank[itemID].."|r"
			end
		end
	end
	-- if showIcon and result ~= "" then
	-- 	result = " +"..result..E.func_texturefromIcon(E.func_GetItemIcon(itemID))
	-- end
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
