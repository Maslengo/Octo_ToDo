local GlobalAddonName, E =...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local strsplit = strsplit
local GetClassColor = GetClassColor or C_ClassColor.GetClassColor
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
local IsSpellKnown = IsSpellKnown
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
local IsComplete = IsComplete or C_QuestLog.IsComplete
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
local GetInfo = GetInfo or C_QuestLog.GetInfo
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
local IsFailed = IsFailed or C_QuestLog.IsFailed
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
local GetSecondsUntilWeeklyReset = GetSecondsUntilWeeklyReset or C_DateAndTime.GetSecondsUntilWeeklyReset
local GetWeeklyResetStartTime = GetWeeklyResetStartTime or C_DateAndTime.GetWeeklyResetStartTime
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
local IsFollowerOnCompletedMission = IsFollowerOnCompletedMission or C_Garrison.IsFollowerOnCompletedMission
local GetFollowerNameByID = GetFollowerNameByID or C_Garrison.GetFollowerNameByID -- (garrFollowerID)
local GetPlayerAuraBySpellID = GetPlayerAuraBySpellID or C_UnitAuras.GetPlayerAuraBySpellID
-- local GetFollowerName = GetFollowerName or C_Garrison.GetFollowerName -- (followerID)
local GetMountIDs = C_MountJournal.GetMountIDs
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
local GetMountFromItem = C_MountJournal.GetMountFromItem
local classR, classG, classB = GetClassColor(E.classFilename)
----------------------------------------------------------------
----------------------------------------------------------------
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
	ColorLeft = E.COLOR_THEBURNINGCRUSADE or expansionData.color
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Raids(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	ColorLeft = E.COLOR_THEBURNINGCRUSADE or expansionData.color
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_Center_Dungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	----------------------------------------------------------------
	ColorLeft = E.COLOR_THEBURNINGCRUSADE or expansionData.color
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	----------------------------------------------------------------
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
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
	if CharInfo.MASLENGO.Reputation and CharInfo.MASLENGO.Reputation[id] and type(CharInfo.MASLENGO.Reputation[id]) == "string" then
		local FIRST, SECOND, repType, colorC, standing = ("#"):split(CharInfo.MASLENGO.Reputation[id])
		FirstReputation = tonumber(FIRST)
		SecondReputation = tonumber(SECOND)
		ColorCenter = colorC
		local isParagonRewardEnableLEFT = ""
		local isParagonRewardEnableRIGHT = ""
		TextCenter = E.func_CompactFormatNumber(FirstReputation).."/"..E.func_CompactFormatNumber(SecondReputation)
		if TextCenter == "1/1" then
			TextCenter = E.DONE
		elseif TextCenter == "0/0" then
			TextCenter = ""
		end
		repType = tonumber(repType)
		-- if repType and repType < 5 and repType ~= 2 then
		-- 	local stText = GetText("FACTION_STANDING_LABEL"..repType, UnitSex("player"))
		-- 	TextCenter = TextCenter .. ColorCenter..STANDINGSREP[repType]..stText.." ("..repType..")|r" -- ПОФИКСИТЬ РЕПА
		-- end
		for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
			if id == v.factionID and CharInfo.MASLENGO.ListOfParagonQuests[questID] then
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
			TextCenter = count
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
