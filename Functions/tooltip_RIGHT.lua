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
function E.func_KeyTooltip_RIGHT(GUID, SettingsType)
	if not GUID or not SettingsType then return end
	local tooltip = {}
	local CharInfo = Octo_ToDo_DB_Levels[GUID]
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local dataType, id = ("#"):split(SettingsType)
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "Raids" or dataType == "Dungeons" then
		id = tonumber(id)
	end
	if dataType == "Items" then
		local itemID = id
		local result = ""
		local total = 0
		if type(itemID) == "number" then
			if cm.Items.Bags[itemID] and cm.Items.Bank[itemID] then
				total = total + cm.Items.Bags[itemID] + cm.Items.Bank[itemID]
			end
		elseif type(itemID) == "table" then
			for _, v in ipairs(itemID) do
				if cm.Items.Bags[itemID] and cm.Items.Bank[itemID] then
					total = total + cm.Items.Bags[itemID] + cm.Items.Bank[itemID]
				end
			end
		end
		if total > 0 then
			tooltip[#tooltip+1] = {TOTAL..": "..E.func_CompactFormatNumber(total)}
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if dataType == "Currencies" and id == 1822 then
		local typeSL = 1 -- Renown
		for covenant = 1, 4 do
			local curCovID = cm.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = cm.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.COLOR_GRAY
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
	end
	if dataType == "Currencies" and id == 1813 then
		local typeSL = 2 -- Anima
		for covenant = 1, 4 do
			local curCovID = cm.CovenantAndAnima.curCovID or 0
			local icon = E.OctoTable_Covenant[covenant].icon
			local name = E.OctoTable_Covenant[covenant].name
			local color = E.OctoTable_Covenant[covenant].color
			local leftText = E.func_texturefromIcon(icon)..name
			local rightText = cm.CovenantAndAnima[covenant][typeSL] or 0
			local centText = ""
			if curCovID ~= covenant then
				color = E.COLOR_GRAY
			end
			leftText = color..leftText.."|r"
			rightText = color..rightText.."|r"
			if pd.Possible_Anima and curCovID == covenant then
				centText = centText..E.COLOR_BLUE.."+"..pd.Possible_Anima.."|r"
			end
			tooltip[#tooltip+1] = {leftText, centText, rightText}
		end
		E.func_AddTooltipSeparator(tooltip)
	end
	if dataType == "Currencies" and id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600 -- 10 minutes in seconds
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, math.floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
			local timeUntilFull = (lastCacheTime + secondsToMax) - GetServerTime()
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
			end
			tooltip[#tooltip+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
			tooltip[#tooltip+1] = {" ", " "} -- Empty separator
			if earnedSinceLastCollect ~= cacheSize then
				tooltip[#tooltip+1] = {"Time to full: ", E.func_SecondsToClock(timeUntilFull)}
			end
			tooltip[#tooltip+1] = {"Was earned: ", E.func_SecondsToClock(GetServerTime()-(cm.GARRISON.lastCacheTime or time()))}
		end
	end
	----------------------------------------------------------------
	if dataType == "Currencies" and id == 1166 then -- ТАЙМВОЛК КАРРЕНСИ ТУЛТИП
		local icon = E.func_texturefromIcon(E.func_GetCurrencyIcon(1166))
		for i, v in ipairs(E.func_Mounts_1166()) do
			local mountID = v.mountID
			local source = v.source
			local price = v.price
			tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), {source, "LEFT"}, E.func_CompactFormatNumber(price)..icon}
		end
	end
	-- if dataType == "Currencies" and id == 3252 then
	-- for i, v in ipairs(E.func_Mounts_3252()) do
	-- local mountID = v.mountID
	-- local source = v.source
	-- tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), E.func_texturefromIcon(E.func_GetCurrencyIcon(id))..v.price, source}
	-- end
	-- end
	if id == "GreatVault" then
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local rewards = vaultData and vaultData.rewards or {}
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				local vaultMin = vaultData and vaultData.min or 0
				tooltip[#tooltip+1] = {
					E.name_activities[ID] or "?",
					" ",
					" ",
					(vaultMin >= max and E.COLOR_GREEN or vaultMin > 0 and E.COLOR_YELLOW or E.COLOR_GRAY)..vaultMin.."/"..max.."|r",
					" ",
					" ",
					rewards[1] and E.COLOR_GREEN..rewards[1].."|r" or E.COLOR_GRAY.."-|r",
					rewards[2] and E.COLOR_GREEN..rewards[2].."|r" or E.COLOR_GRAY.."-|r",
					rewards[3] and E.COLOR_GREEN..rewards[3].."|r" or E.COLOR_GRAY.."-|r"
				}
			end
	end
	if id == "CurrentKey" then
		if pd.CurrentKeyName then
			tooltip[#tooltip+1] = {E.COLOR_ORANGE..pd.CurrentKeyLevel.."|r "..E.COLOR_PURPLE..pd.CurrentKeyName.."|r", ""}
		end
		if pd.RIO_Score and pd.RIO_weeklyBest then
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Weekly Best:", pd.RIO_weeklyBest or 0}
			tooltip[#tooltip+1] = {"RIO Score:", pd.RIO_Score or 0}
		end
	end
	if id == "LegionRemixResearch" then
		for questID in next,(E.OctoTable_RemixInfinityResearch) do
			if cm.ListOfQuests[questID] then
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	if dataType == "Currencies" then
		for currencyID, dataTBL in pairs(E.OctoTable_ALL_Mounts) do
			if id == tonumber(currencyID) and id ~= 1166 then -- ТАЙМВОЛК КАРРЕНСИ ТУЛТИП
				-- Создаем таблицу для сортировки
				local mounts = {}
				for mountID, price in pairs(dataTBL) do
					local mountIconNumber = E.func_GetMountTexture(mountID)
					local mountIcon = E.func_texturefromIcon(mountIconNumber)
					local mountName = E.func_GetMountName(mountID)
					local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
					local color = isCollected and E.COLOR_WHITE or E.COLOR_RED
					local mountLeftText = mountIcon..color..mountName.."|r"
					table.insert(mounts, {
							id = mountID,
							price = price,
							name = mountName,
							leftText = mountLeftText,
							collected = isCollected
					})
				end
				-- Сортировка: собранные сверху, потом цена, потом имя
				table.sort(mounts, function(a, b)
						-- 1. Собранные маунты сверху
						-- if a.collected ~= b.collected then
						-- return b.collected
						-- end
						-- 2. По цене (дорогие сверху)
						-- if a.price ~= b.price then
						-- return a.price > b.price
						-- end
						-- 2. По имени
						if a.name ~= b.name then
							return a.name < b.name
						end
						-- 4. По id
						return a.id < b.id
				end)
				-- Добавляем в tooltip
				for _, mount in ipairs(mounts) do
					tooltip[#tooltip + 1] = {
						mount.leftText,
						" ",
						E.func_CompactFormatNumber(mount.price)..
						E.func_texturefromIcon(E.func_GetCurrencyIcon(currencyID))
					}
				end
			end
		end
	end
	if SettingsType == "BfA_mechagonItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_MECHAGON, true)
	end
	----------------------------------------------------------------
	if dataType == "Reputations" then
		if cm.Reputation[id] and type(cm.Reputation[id]) == "string" then
			local FIRST, SECOND, output, ColorCenter, standing = ("#"):split(cm.Reputation[id])
			local icon1texture = E.func_texturefromIcon(E.ICON_TABARD)
			local icon2texture = E.func_GetReputationIcon(id) and E.func_texturefromIcon(E.func_GetReputationIcon(id)) or ""
			local firstTEXT = icon1texture..icon2texture..E.func_GetReputationName(id)
			local secondTEXT = FIRST.."/"..SECOND
			if secondTEXT == "1/1" then
				secondTEXT = E.DONE
			end
			local thirdTEXT = ColorCenter..standing.."|r"
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and cm.ListOfParagonQuests[questID] then
					isParagonRewardEnable = E.COLOR_PURPLE..">>"..CONTRIBUTION_REWARD_TOOLTIP_TITLE.."<<|r"
				end
			end
			for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
				if id == v.factionID and cm.ListOfParagonQuests[questID] then
					secondTEXT = E.COLOR_PURPLE..">"..FIRST.."/"..SECOND.."<".."|r"
				end
			end
			if secondTEXT ~= "0/0" then
				tooltip[#tooltip+1] = {firstTEXT}
				tooltip[#tooltip+1] = {secondTEXT, thirdTEXT}
			end
			-- else
			-- opde(cm.Reputation[id])
		end
	end
	if SettingsType == "Additionally#AllItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.ALL_Items, false)
		-- tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_ALL, false)
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				local leftText = E.func_ProfessionIcon(charProf[i].skillLine).." "..E.func_GetProfessionName(charProf[i].skillLine)
				local rightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
				if charProf[i].skillModifier then
					rightText = charProf[i].skillLevel..E.COLOR_GREEN.."+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
				end
				tooltip[#tooltip+1] = {leftText, rightText}
				if charProf[i].child then
					-- for expIndex, v in ipairs(charProf[i].child) do
					for expIndex = #charProf[i].child, 1, -1 do
						local v = charProf[i].child[expIndex]
						if v.QWEskillLevel and v.QWEprofessionName then
							-- for expI, j in ipairs(E.OctoTable_Expansions) do
							-- for expI = #E.OctoTable_Expansions, 1, -1 do
							-- local j = E.OctoTable_Expansions[expI]
							local j = E.OctoTable_Expansions[expIndex]
							tooltip[#tooltip+1] = {E.func_FormatExpansion(expIndex), v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
							-- end
							-- end
						end
					end
				end
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#ItemLevel" then
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, pd.avgItemLevelPvp)}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#Money" then
		if pd.Money then
			local function addMoneyDiff(label, oldValue)
				if not oldValue then return end
				local diff = pd.Money - oldValue
				if diff == 0 then return end
				local sign = diff > 0 and "+" or "-"
				local color = diff > 0 and E.COLOR_GREEN or E.COLOR_RED
				local result = sign..E.func_FormatMoney(math.abs(diff))
				tooltip[#tooltip + 1] = {label, color..result.."|r"}
			end
			addMoneyDiff("SESSION", pd.MoneyOnLogin)
			addMoneyDiff("DAILY", pd.MoneyOnDaily)
			addMoneyDiff("WEEKLY", pd.MoneyOnWeekly)
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#WasOnline" then
		local color = "|cffFFFFFF"
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				-- tooltip[#tooltip+1] = {"Время после релоуда: "..pd.classColorHex..E.func_SecondsToClock(GetServerTime() - pd.time).."|r", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, pd.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r" ), " "}
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				tooltip[#tooltip+1] = {color..E.func_FormatLastSeen(pd.time, pd.classColorHex).."|r", ""}
				tooltip[#tooltip+1] = {"", ""}
				tooltip[#tooltip+1] = {color..pd.loginDay.."|r", ""}
				tooltip[#tooltip+1] = {color..pd.loginHour.."|r", ""}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#ListOfQuests" then
		if pd.numQuests then
			local questIDs = {}
			for questID in next, cm.ListOfQuests do
				questIDs[#questIDs+1] = questID
			end
			table.sort(questIDs, E.func_ReversSort)
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[i] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	----------------------------------------------------------------
	if SettingsType == "Additionally#LFGInstance" then
		local combinedTooltip = {}
		local ServerTime = GetServerTime()
		for instanceID, v in next, (cm.journalInstance) do
			for difficultyID, w in next, (v) do
				if w.instanceReset then
					local instanceReset = w.instanceReset
					local defeatedBosses = w.defeatedBosses
					local totalBosses = w.totalBosses
					local lastBossDefeated = w.lastBossDefeated
					local color = defeatedBosses == totalBosses and E.COLOR_GREEN or (lastBossDefeated and E.COLOR_YELLOW or E.COLOR_RED)
					local difficultyName = GetDifficultyInfo(difficultyID)
					local name = w.instanceName -- GetLFGDungeonInfo(instanceID) -- НЕ ТОТ ID (GetLFGDungeonInfo(2870) -- instanceID = 1477)
					local output = name.." ("..difficultyName..") "..E.debugInfo(instanceID)
					local status = color..defeatedBosses.."/"..totalBosses.."|r"
					-- local isRaid = w.isRaid
					-- local bosses = ""
					-- for i = 1, totalBosses do
					-- local bossName = w.Bosses[i].bossName
					-- local bossKilled = w.Bosses[i].bossKilled
					-- bosses = bosses..i..") "..(bossKilled and E.COLOR_GREEN..bossName.."|r" or E.COLOR_GRAY..bossName.."|r")
					-- end
					table.insert(combinedTooltip, {
							name = output .. "id: "..instanceID,
							status = status, -- bosses
							time = E.func_SecondsToClock(w.instanceReset-ServerTime)
					})
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if cm.LFGInstance[dungeonID].donetoday then
				table.insert(combinedTooltip, {
						name = cm.LFGInstance[dungeonID].D_name..E.debugInfo(dungeonID),
						status = " ",
						time = cm.LFGInstance[dungeonID].donetoday
				})
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			table.insert(combinedTooltip, {
					-- name = E.func_texturefromIcon(E.ICON_WORLDBOSS)..v.name..E.debugInfo(worldBossID),
					name = v.name..E.debugInfo(worldBossID),
					status = " ",
					time = E.func_SecondsToClock(v.reset)
			})
		end
		-- Сортировка по name
		table.sort(combinedTooltip, function(a, b)
				return a.name < b.name
		end)
		-- Выводим отсортированные данные
		for _, v in ipairs(combinedTooltip) do
			tooltip[#tooltip+1] = {
				v.name,
				"|cff9999ff"..v.time.."|r",
				v.status
			}
		end
		-- if #tooltip ~= 0 then
		-- TextCenter = E.COLOR_GRAY..DUNGEONS.."|r"
		-- end
		----------------------------------------------------------------
		-- elseif SettingsType:find(E.UNIVERSAL) then
	end
	if dataType == "UniversalQuests" then
		for _, data in next,(E.ALL_UniversalQuests) do
			if not data.quests then
				break -- Пропускаем записи без квестов
			end
			local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
			local showTooltip = data.showTooltip or false
			-- id eto questKey
			if showTooltip and id == questKey then
				-- Подсчет общего числа квестов
				local totalQuest = 0
				local forcedMaxQuest = data.forcedMaxQuest
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == pd.Faction then
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
				-- Заголовок тултипа (если квестов больше одного)
				if E.DebugUniversal then
					tooltip[#tooltip+1] = {questKey, "forcedMaxQuest: "..totalQuest}
				end
				if totalQuest >= 1 then
					local output
					if type(data.TextLeft) == "function" then
						output = data.TextLeft() -- ← Вызываем функцию!
					else
						output = data.TextLeft
					end
					local TextLeft = tostringall(E.func_FormatResetType(data.reset).." "..output)
					tooltip[#tooltip+1] = {" ", TOTAL..": "..totalQuest}
					-- tooltip[#tooltip+1] = {" "}
				end
				-- Список квестов в тултипе
				local questsToShow = {}
				for _, questData in ipairs(data.quests) do
					local faction = questData.faction
					if not faction or faction == pd.Faction then
						table.insert(questsToShow, questData)
					end
				end
				if data.sorted ~= false then
					table.sort(questsToShow, function(a, b)
							local function getName(entry)
								if entry.forcedText then
									if entry.forcedText.npcID then
										return E.func_GetNPCName(entry.forcedText.npcID) or ""
									elseif entry.forcedText.text then
										return entry.forcedText.text or ""
									end
								end
								return E.func_GetQuestName(entry[1]) or ""
							end
							return getName(a) < getName(b)
					end)
				end
				-- Формирование строк тултипа
				for _, questData in ipairs(questsToShow) do
					local questID = questData[1]
					local faction = questData.faction
					local forcedText = questData.forcedText
					local forcedIcon = questData.forcedIcon
					local addText = questData.addText
					local Output_LEFT = ""
					local Output_CENT = ""
					local Output_RIGHT = ""
					if questID then
						Output_RIGHT = cm.UniversalQuest and cm.UniversalQuest[questKey] and cm.UniversalQuest[questKey][questID] or E.COLOR_GRAY..NONE.."|r"
					end
					if forcedText then
						-- Добавляем текст
						if forcedText.text then
							Output_LEFT = Output_LEFT..forcedText.text.." "
						end
						-- Добавляем имя NPC
						if forcedText.npcID then
							Output_LEFT = Output_LEFT..E.func_GetNPCName(forcedText.npcID).." "
						end
						-- Добавляем название достижения
						if forcedText.achievementID then
							Output_LEFT = Output_LEFT..E.func_GetAchievementName(forcedText.achievementID).." "
						end
						-- Добавляем название предмета
						if forcedText.itemID then
							Output_LEFT = Output_LEFT..E.func_GetItemName(forcedText.itemID).." "
						end
						if forcedText.Icon then
							Output_LEFT = E.func_texturefromIcon(forcedText.Icon)..Output_LEFT
						end
						-- Удаляем лишний пробел в конце
						Output_LEFT = Output_LEFT:match("^(.-)%s*$")
					else
						if questID then
							Output_LEFT = Output_LEFT..E.func_GetQuestName(questID)
						end
					end
					if addText then
						-- Добавляем иконку Vignette
						if addText.IconVignette then
							Output_LEFT = E.func_texturefromIcon(addText.IconVignette, nil, nil, true)..Output_LEFT
						end
						if addText.Icon then
							Output_LEFT = E.func_texturefromIcon(addText.Icon)..Output_LEFT
						end
						if addText.mount then
							-- local mountIconNumber = E.func_GetMountTexture(addText.mount)
							-- local mountIcon = E.func_texturefromIcon(mountIconNumber)
							-- local mountName = mountIcon..E.func_GetMountCollectedColor(addText.mount)..E.func_GetMountName(addText.mount).."|r"
							Output_CENT = Output_CENT..E.COLOR_PURPLE.." +"..string.format(RENOWN_REWARD_MOUNT_NAME_FORMAT, E.func_FormatMountInfo(addText.mount)).."|r"
						end
						if addText.expansionText then
							Output_CENT = Output_CENT..addText.expansionText
						end
						if addText.notes then
							Output_LEFT = Output_LEFT..addText.notes
						end
						if addText.mapID then
							Output_LEFT = Output_LEFT..E.COLOR_GRAY.." ("..E.func_GetMapName(addText.mapID)..")|r"
						end
						if addText.spellID then
							Output_LEFT = Output_LEFT..E.COLOR_PINK..E.func_GetSpellName(addText.spellID).."|r"
						end
						if addText.text then
							Output_LEFT = Output_LEFT..addText.text
						end
					end
					if faction == pd.Faction then
						Output_LEFT = E.func_texturefromIcon(E.func_GetFactionIcon(faction))..Output_LEFT
					end
					-- tooltip[#tooltip+1] = {Output_LEFT, Output_CENT, Output_RIGHT}
					if Output_CENT ~= "" then
						tooltip[#tooltip+1] = {Output_LEFT, {Output_CENT, "LEFT"}, Output_RIGHT}
					else
						tooltip[#tooltip+1] = {Output_LEFT, Output_RIGHT}
						-- tooltip[#tooltip+1] = {Output_LEFT, Output_CENT ~= "" and {Output_CENT, "LEFT"} or nil, Output_RIGHT}
					end
				end
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		--elseif SettingsType == "ЙЦУЙЦУ" then
		----------------------------------------------------------------
		--elseif SettingsType == "ЙЦУЙЦУ" then
		----------------------------------------------------------------
		----------------------------------------------------------------
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return tooltip
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
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
function E.func_BuildItemTooltip(CharInfo, TBL, needShowAllItems)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local tooltip = {}
	local sorted_itemList = {}
	local Items_BAGS = CharInfo.MASLENGO.Items.Bags
	local Items_BANK = CharInfo.MASLENGO.Items.Bank
	local total_BAGS = 0
	local total_BANK = 0
	for itemID in next,(TBL) do
		local count_BAGS = Items_BAGS[itemID] or 0
		local count_BANK = Items_BANK[itemID] or 0
		local hasData = needShowAllItems or (count_BAGS > 0 or count_BANK > 0)
		if hasData then
			if count_BANK > 0 then
				total_BANK = total_BANK + count_BANK
			end
			table.insert(sorted_itemList, {
					itemID = itemID,
					quality = E.func_GetItemQualityLevel(itemID),
					count_BAGS = count_BAGS,
					count_BANK = count_BANK,
			})
		end
	end
	table.sort(sorted_itemList, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality
			elseif a.count_BAGS ~= b.count_BAGS then
				return a.count_BAGS > b.count_BAGS
			elseif a.count_BANK ~= b.count_BANK then
				return a.count_BANK > b.count_BANK
			end
			return a.itemID > b.itemID
	end)
	if total_BANK > 0 then
		tooltip[#tooltip+1] = {"", {BAG_NAME_BACKPACK, "RIGHT"}, {E.COLOR_GRAY..BANK.."|r", "LEFT"}}
	end
	for _, v in ipairs(sorted_itemList) do
		local itemID = v.itemID
		local count_BAGS = v.count_BAGS
		local count_BANK = v.count_BANK
		local row2Text = count_BAGS > 0 and E.func_CompactFormatNumber(count_BAGS) or ""
		-- local row3Text = count_BANK or ""
		local row3Text = count_BANK > 0 and E.COLOR_GRAY.."+"..E.func_CompactFormatNumber(count_BANK).."|r" or ""
		local icon = E.func_texturefromIcon(E.func_GetItemIcon(itemID))
		local name = E.func_GetItemName(itemID)
		tooltip[#tooltip + 1] = {
			icon..name,
			{row2Text, "RIGHT"},
			{row3Text, "LEFT"}
		}
	end
	return tooltip
end