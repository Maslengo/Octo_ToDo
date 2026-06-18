local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_Dispatcher(categoryKey, CharInfo, dataType, id)
	local funcNames = {
		"func_Otrisovka_Center_" .. dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	return "", nil, nil, nil
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	TextCenter = E.func_TextCenter_Currency(CharInfo, id)
	local SL_Possible_CatalogedResearch = pd.SL_Possible_CatalogedResearch or 0
	if id == 1931 and SL_Possible_CatalogedResearch > 0 then
		-- TextCenter = string.format("%s%s +%d|r", TextCenter, E.COLOR_PURPLE, SL_Possible_CatalogedResearch)
		TextCenter = TextCenter .. E.COLOR_PURPLE .. " +" .. E.func_CompactFormatNumber(SL_Possible_CatalogedResearch) .. "|r"
	end
	if id == 824 then -- GARRISON RESOURCE
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (E.TIME_SERVER() - lastCacheTime) / RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect) * RESOURCES_PER_INTERVAL)
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
				TextCenter = TextCenter .. color .. " +" .. earnedSinceLastCollect .. "|r"
			end
		end
	elseif id == 1822 then -- RENOWN
		local SL_covenantID = pd.SL_covenantID
		if SL_covenantID then
			local prefix = E.OctoTable_Covenant[SL_covenantID].prefix
			-- local color = E.OctoTable_Covenant[SL_covenantID].color
			local color = E.func_DB_COV_COLOR(SL_covenantID)
			-- local color = (curCovID == covenant) and cov.color or E.COLOR_GRAY
			local renown = pd[prefix .. "_Renown"]
			-- local anima = pd[prefix .. "_Anima"]
			if renown then
				TextCenter = color .. E.func_CompactFormatNumber(renown) .. "|r"
			end
		end
	elseif id == 1813 then -- ANIMA
		local SL_covenantID = pd.SL_covenantID
		if SL_covenantID then
			local prefix = E.OctoTable_Covenant[SL_covenantID].prefix
			-- local color = E.OctoTable_Covenant[SL_covenantID].color
			local color = E.func_DB_COV_COLOR(SL_covenantID)
			-- local renown = pd[prefix .. "_Renown"]
			local anima = pd[prefix .. "_Anima"] or 0
			if anima > 0 then
				TextCenter = color .. E.func_CompactFormatNumber(anima) .. "|r"
			end
		end
		if pd.SL_Possible_Anima and type(pd.SL_Possible_Anima) == "number" and pd.SL_Possible_Anima > 0 then
			TextCenter = TextCenter .. E.COLOR_BLUE .. " +" .. E.func_CompactFormatNumber(pd.SL_Possible_Anima) .. "|r"
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	TextCenter = E.func_TextCenter_Items(CharInfo, id)
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_RaidsOrDungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local cm = CharInfo.MASLENGO
	local JI_ID = tonumber(id)
	local instanceData = cm.journalInstance[JI_ID]
	if instanceData then
		-- Собираем все сложности в массив для сортировки
		local difficulties = {}
		for difficultyID, v in next, (instanceData) do
			difficulties[#difficulties+1] = {
				difficultyID = difficultyID,
				defeatedBosses = v.defeatedBosses or 0,
				totalBosses = v.totalBosses or 0,
				lastBossDefeated = v.lastBossDefeated or false
			}
		end
		-- Сортировка по приоритету из OctoTable_Difficulties
		E.func_SortRecords(difficulties, function(a, b)
				local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
				local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
				return pa < pb
		end)
		-- Формируем текст
		for _, diff in ipairs(difficulties) do
			if diff.defeatedBosses > 0 then
				local color = diff.defeatedBosses == diff.totalBosses and E.COLOR_GREEN or (diff.lastBossDefeated and E.COLOR_YELLOW or E.COLOR_WHITE)
				TextCenter = TextCenter .. color .. diff.defeatedBosses .. "/" .. diff.totalBosses .. "|r "
				-- if diff.defeatedBosses == diff.totalBosses then
				-- local diffABBR = E.OctoTable_Difficulties and E.OctoTable_Difficulties[diff.difficultyID] and E.OctoTable_Difficulties[diff.difficultyID].abbr
				-- TextCenter = TextCenter .. color .. diffABBR .. "|r "
				-- else
				-- TextCenter = TextCenter .. color .. diff.defeatedBosses .. "/" .. diff.totalBosses .. "|r "
				-- end
				-- if diff.defeatedBosses == diff.totalBosses then
				-- local diffABBR = E.OctoTable_Difficulties and E.OctoTable_Difficulties[diff.difficultyID] and E.OctoTable_Difficulties[diff.difficultyID].abbr
				-- TextCenter = TextCenter .. E.DONE .. " "
				-- else
				-- TextCenter = TextCenter .. color .. diff.defeatedBosses .. "/" .. diff.totalBosses .. "|r "
				-- end
			end
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_UniversalQuests(categoryKey, CharInfo, dataType, data)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	-- local questKey = E.UNIVERSAL .. data.desc .. "_" .. data.name_save .. "_" .. data.reset
	local questKey = data.questKey
	-- local showTooltip = data.showTooltip or false
	if cm.UniversalQuest and cm.UniversalQuest[questKey] and cm.UniversalQuest[questKey].TextCenter then
		TextCenter = cm.UniversalQuest[questKey].TextCenter
		if type(TextCenter) == "boolean" then
			TextCenter = E.DONE
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- local GetText = GetText
local _G = _G
local standingCache = {}
local math_floor = math.floor
function E.func_Otrisovka_Center_Reputations(categoryKey, CharInfo, dataType, id)
	-- local pd = CharInfo.PlayerData
	local cm = CharInfo and CharInfo.MASLENGO
	if not categoryKey or not cm then return end
	local rep = cm.Reputation
	if rep and type(rep) == "table" and rep[id] and rep[id].FIRST and rep[id].SECOND then
		local func_CompactFormatNumber = E.func_CompactFormatNumber
		local FIRST = rep[id].FIRST
		local SECOND = rep[id].SECOND
		-- local ParagonCount = rep[id].ParagonCount or 0
		local repType = rep[id].repType or 0
		local reaction = rep[id].reaction or 0
		local rankInfocurrentLevel = rep[id].rankInfocurrentLevel
		local rankInfomaxLevel = rep[id].rankInfomaxLevel
		local renownLevel = rep[id].renownLevel
		local renownMaxLevel = rep[id].renownMaxLevel
		----------------------------------------------------------------
		local showValue
		local showPercentage
		local showReaction
		local showStandings
		local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
		if repType == 1 then -- SIMPLE
			showValue = settingsProfile.CONFIG_REPUTATION_VALUE_SIMPLE
			showPercentage = settingsProfile.CONFIG_REPUTATION_PERCENTAGE_SIMPLE
			showReaction = settingsProfile.CONFIG_REPUTATION_REACTION_SIMPLE
			showStandings = settingsProfile.CONFIG_REPUTATION_STANDINGS_SIMPLE
		elseif repType == 2 then -- FRIENDSHIP
			showValue = settingsProfile.CONFIG_REPUTATION_VALUE_FRIEND
			showPercentage = settingsProfile.CONFIG_REPUTATION_PERCENTAGE_FRIEND
			showReaction = settingsProfile.CONFIG_REPUTATION_REACTION_FRIEND
			showStandings = settingsProfile.CONFIG_REPUTATION_STANDINGS_FRIEND
		elseif repType == 3 then -- MAJOR (Renown)
			showValue = settingsProfile.CONFIG_REPUTATION_VALUE_MAJOR
			showPercentage = settingsProfile.CONFIG_REPUTATION_PERCENTAGE_MAJOR
			showReaction = settingsProfile.CONFIG_REPUTATION_REACTION_MAJOR
			showStandings = settingsProfile.CONFIG_REPUTATION_STANDINGS_MAJOR
		elseif repType == 4 then -- PARAGON
			showValue = settingsProfile.CONFIG_REPUTATION_VALUE_PARAGON
			showPercentage = settingsProfile.CONFIG_REPUTATION_PERCENTAGE_PARAGON
			showReaction = settingsProfile.CONFIG_REPUTATION_REACTION_PARAGON
			showStandings = settingsProfile.CONFIG_REPUTATION_STANDINGS_PARAGON
		end
		----------------------------------------------------------------
		local parts = {}
		----------------------------------------------------------------
		-- parts[#parts+1] = E.COLOR_GRAY..repType.."|r"
		----------------------------------------------------------------
		-- CONFIG_VALUE ------------------------------------------------
		----------------------------------------------------------------
		-- if showValue_OLD then
		-- 	local TEXT_VALUE = func_CompactFormatNumber(FIRST) .. "/" .. func_CompactFormatNumber(SECOND)
		-- 	if TEXT_VALUE == "1/1" then
		-- 		-- TEXT_VALUE = L["DONE"]
		-- 		TEXT_VALUE = L["AUCTION_HOUSE_MAX_QUANTITY_BUTTON"]
		-- 	elseif TEXT_VALUE == "0/0" then
		-- 		-- TEXT_VALUE = ""
		-- 		TEXT_VALUE = nil
		-- 	end
		-- 	if TEXT_VALUE then
		-- 		parts[#parts+1] = TEXT_VALUE
		-- 	end
		-- end
		----------------------------------------------------------------
		-- ColorCenter -------------------------------------------------
		----------------------------------------------------------------
		local ColorCenter = E.func_DB_REP_COLOR(repType, reaction)
		----------------------------------------------------------------
		-- CONFIG_PERCENTAGE -------------------------------------------
		----------------------------------------------------------------
		-- if showPercentage_OLD then
		-- 	-- if repType == 2 or repType == 3 then -- 2
		-- 	-- if FIRST ~= SECOND then
		-- 	local percent = (SECOND > 0) and math_floor(FIRST / SECOND * 100) or 0
		-- 	-- local TEXT_PERCENT = (percent > 0 and percent < 100) and (percent .. "%")
		-- 	local TEXT_PERCENT = (percent > 0) and (percent .. "%")
		-- 	-- local TEXT_PERCENT = percent .. "%"
		-- 	if TEXT_PERCENT then
		-- 		parts[#parts+1] = TEXT_PERCENT
		-- 	end
		-- 	-- end
		-- end
		----------------------------------------------------------------
		-- CONFIG_STANDINGS --------------------------------------------
		----------------------------------------------------------------
		-- if showStandings_OLD then
		-- 	local TEXT_STANDINGS
		-- 	if repType == 2 then -- FRIENDSHIP
		-- 		if rankInfocurrentLevel and rankInfomaxLevel then
		-- 			TEXT_STANDINGS = rankInfocurrentLevel .. "/" .. rankInfomaxLevel
		-- 		end
		-- 	elseif repType == 3 then
		-- 		if renownLevel and renownMaxLevel then
		-- 			TEXT_STANDINGS = renownLevel .. "/" .. renownMaxLevel
		-- 		end
		-- 	elseif repType == 1 then
		-- 		if reaction and reaction > 0 then
		-- 			local gender = E.cur_gender or 3
		-- 			standingCache[reaction] = standingCache[reaction] or {}
		-- 			local cached = standingCache[reaction][gender]
		-- 			if not cached then
		-- 				-- cached = GetText("FACTION_STANDING_LABEL" .. reaction, gender)
		-- 				cached = _G["FACTION_STANDING_LABEL"..reaction]
		-- 				standingCache[reaction][gender] = cached
		-- 			end
		-- 			TEXT_STANDINGS = cached
		-- 		end
		-- 	elseif repType == 4 then
		-- 		TEXT_STANDINGS = L["Paragon"]
		-- 	end
		-- 	if TEXT_STANDINGS then
		-- 		parts[#parts+1] = TEXT_STANDINGS
		-- 	end
		-- end
		----------------------------------------------------------------
		-- reaction LOCAL_LANGUAGE >:( ---------------------------------
		----------------------------------------------------------------
		-- if reaction and type(reaction) == "string" then
		--     local TEXT_REACTION = "(" .. reaction .. ")"
		--     parts[#parts+1] = TEXT_REACTION
		-- end
		----------------------------------------------------------------
		-- TEXT_RENOWN
		----------------------------------------------------------------
		-- local TEXT_RENOWN
		-- if renownLevel and renownLevel > 0 then
		--     TEXT_RENOWN = string.format(RENOWN_LEVEL_LABEL, renownLevel)
		-- end
		-- if TEXT_RENOWN then
		--     parts[#parts+1] = ColorCenter..TEXT_RENOWN.."|r"
		-- end
		----------------------------------------------------------------
		-- TEXT_MAXREACTION_SIMPLE -------------------------------------
		----------------------------------------------------------------
		-- local TEXT_MAXREACTION_SIMPLE
		-- if repType == 1 then
		--     TEXT_MAXREACTION_SIMPLE = reaction .. "/8"
		-- end
		-- if TEXT_MAXREACTION_SIMPLE then
		--     parts[#parts+1] = TEXT_MAXREACTION_SIMPLE
		-- end
		----------------------------------------------------------------
		-- CURRENT VALUE -----------------------------------------------
		----------------------------------------------------------------
		local test_1
		if showValue then -- FIRST/SECOND
			test_1 = func_CompactFormatNumber(FIRST) .. "/" .. func_CompactFormatNumber(SECOND)
		end
		----------------------------------------------------------------
		-- PERCENTAGE --------------------------------------------------
		----------------------------------------------------------------
		local test_2
		if showPercentage then
			local percent = (SECOND > 0) and math_floor(FIRST / SECOND * 100) or 0
			-- local test_2 = (percent > 0 and percent < 100) and (percent .. "%")
			test_2 = (percent > 0) and (percent .. "%")
			-- local test_2 = percent .. "%"
		end
		----------------------------------------------------------------
		-- RANK --------------------------------------------------------
		----------------------------------------------------------------
		local test_3
		if showReaction then
			if repType == 1 then
				test_3 = reaction .. "/8"
			elseif repType == 2 then
				test_3 = rankInfocurrentLevel .. "/" .. rankInfomaxLevel
			elseif repType == 3 or repType == 4 then
				if renownLevel and renownLevel >= 0 then
					test_3 = renownLevel .. "/" .. renownMaxLevel
				end
				if rankInfocurrentLevel then
					test_3 = rankInfocurrentLevel .. "/" .. rankInfomaxLevel
				end
				if not renownLevel and not rankInfocurrentLevel then
					if reaction and type(reaction) == "number" then
						test_3 = reaction .. "/8"
					end
				end
			end
		end
		----------------------------------------------------------------
		-- REACTION ----------------------------------------------------
		----------------------------------------------------------------
		local test_4
		if showStandings then
			if repType == 1 and reaction and type(reaction) == "number" then
				test_4 = _G["FACTION_STANDING_LABEL"..reaction]
			elseif repType == 2 and reaction and type(reaction) == "string"  then
				test_4 = reaction
			elseif repType == 3 then
				if renownLevel then
					test_4 = format(RENOWN_LEVEL_LABEL, renownLevel)
				end
			end
			if repType == 4 then
				test_4 = L["Paragon"]
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		if FIRST > 0 and FIRST == SECOND then
			test_1 = L["AUCTION_HOUSE_MAX_QUANTITY_BUTTON"]
			test_2 = nil
			test_3 = nil
			test_4 = nil
		end
		-- ЦИФРЫ (currentValue/threshold)
		-- ПРОЦЕНТ (Percentage)
		-- УРОВЕНЬ
		-- ТЕКСТ_ОТНОШЕНИЕ
		if test_1 then
			parts[#parts+1] = test_1
		end
		if test_2 then
			parts[#parts+1] = ColorCenter..test_2.."|r"
		end
		if test_3 then
			parts[#parts+1] = ColorCenter..test_3.."|r"
		end
		if test_4 then
			parts[#parts+1] = ColorCenter..test_4.."|r"
		end
		-- local FIRST/SECOND
		-- local renownlevel(rep3, rep4) + reaction(rep1 + FORCED/8) + rankInfocurrentlevel(rep2)
		-- local TEXT_STANDING(rep1), (fromat:renown(rep3)), reaction(type"string"(rep2)),
		----------------------------------------------------------------
		local TextCenter = table.concat(parts, " - ")
		----------------------------------------------------------------
		local paragonQuest = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].paragonQuest or false
		if paragonQuest and cm.ListOfParagonQuests[paragonQuest] then
			TextCenter = E.COLOR_PURPLE .. ">" .. TextCenter .. "<|r"
		end
		return TextCenter, ColorCenter, FIRST, SECOND
	else
		return "", nil, nil, nil
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_AdditionallyTOP(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	if id == "GreatVault" then
		-- if pd.HasAvailableRewards then
		-- -- L["REWARD"]
		-- TextCenter = E.COLOR_BLUE .. ">|r" .. TextCenter .. E.COLOR_BLUE .. "<|r"
		-- end
		local hasData = false
		TextCenter = "" -- обнуляем перед циклом
		for j = 1, #E.Enum_Activities_table do
			local ID = E.Enum_Activities_table[j]
			local activities = E.func_GetActivities(ID)
			local max = activities and activities[3] and activities[3].threshold or 0
			local vaultData = cm.GreatVault and cm.GreatVault[ID]
			local vaultMin = vaultData and vaultData.min or 0
			local result = ""
			if max == 0 then
				result = E.COLOR_GRAY .. "-|r"
			elseif vaultMin >= max then
				hasData = true
				result = E.COLOR_GREEN .. vaultMin .. "/" .. max .. "|r"
				-- result = E.DONE
			elseif vaultMin > 0 then
				hasData = true
				result = E.COLOR_YELLOW .. vaultMin .. "/" .. max .. "|r"
			else
				result = E.COLOR_GRAY .. "-|r"
				-- result = E.COLOR_GRAY .. "0/" .. max .. "|r"
			end
			TextCenter = TextCenter .. " " .. result
		end
		if pd.HasAvailableRewards and hasData then
			-- L["REWARD"]
			TextCenter = TextCenter .. E.COLOR_BLUE .. "*|r"
		elseif pd.HasAvailableRewards then
			-- L["REWARD"]
			TextCenter = E.COLOR_BLUE .. ">" .. L["REWARD"] .. "<|r"
		elseif not pd.HasAvailableRewards and not hasData then
			TextCenter = ""
		end
	end
	----------------------------------------------------------------
	for index, activityID in ipairs(E.Enum_Activities_table) do
		if id == "GreatVault" .. index then
			local vaultData = cm.GreatVault and cm.GreatVault[activityID]
			-- RAID
			if activityID == 3 then
				local activities = vaultData and vaultData.activities or {}
				local parts, hasData = {}, false
				for slot = 1, 3 do -- #activities
					local levelID = activities[slot] and activities[slot].level
					local text, color
					if not levelID or levelID == 0 then
						text, color = "-", E.COLOR_GRAY
					else
						local info = E.OctoTable_Difficulties[levelID]
						text = info and info.abbr or "?"
						color = info and info.color or E.COLOR_GRAY
					end
					if text ~= "-" then
						hasData = true
					end
					parts[slot] = color .. text .. "|r"
				end
				TextCenter = hasData and table.concat(parts, " ") or ""
			end
			-- DUNGEON
			if activityID == 1 then
				local activities = vaultData and vaultData.activities or {}
				local parts, hasData = {}, false
				for slot = 1, 3 do
					local level = activities[slot] and activities[slot].level
					local text, color
					if not level or level == 0 then
						text, color = "-", E.COLOR_GRAY
					else
						text = tostring(level)
						-- цвет в зависимости от того, открыт ли слот (есть ли награда)
						local rewards = vaultData and vaultData.rewards or {}
						color = rewards[slot] and E.COLOR_WHITE or E.COLOR_GRAY
					end
					if text ~= "-" then
						hasData = true
					end
					parts[slot] = color .. text .. "|r"
				end
				TextCenter = hasData and table.concat(parts, " ") or ""
			end
			-- WORLD
			if activityID == 6 then
				local activities = E.func_GetActivities(activityID)
				local current = vaultData and vaultData.min or 0
				local required = activities and activities[3] and activities[3].threshold or 0
				if current > 0 and required > 0 then
					local color = (current >= required) and E.COLOR_WHITE or E.COLOR_YELLOW
					TextCenter = color .. current .. "/" .. required .. "|r"
				else
					TextCenter = ""
				end
			end
			-- else
			-- DUNGEON / WORLD
			-- local activities = E.func_GetActivities(activityID)
			-- local current = vaultData and vaultData.min or 0
			-- local required = activities and activities[3] and activities[3].threshold or 0
			-- if current > 0 and required > 0 then
			--     local color = (current >= required) and E.COLOR_GREEN or E.COLOR_YELLOW
			--     TextCenter = color .. current .. "/" .. required .. "|r"
			-- else
			--     TextCenter = ""
			-- end
			-- end
			break
		end
	end
	----------------------------------------------------------------
	if id == "CurrentKey" then
		if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
			local seasonData = pd.MythicPlus and pd.MythicPlus[E.MythicPlus_seasonID]
			if seasonData then
				-- local color = E.func_RioColor(seasonData.RIO_Score)
				local rioColor = E.COLOR_PURPLE -- E.func_RioColor(seasonData.RIO_Score)
				-- local color = E.COLOR_PURPLE
				local keyName = E.func_formatMplusKey(pd.OwnedKeystoneLevel, pd.OwnedKeystoneChallengeMapID, false, false, rioColor)
				TextCenter = keyName
			end
		end
	end
	if id == "PlayerInventory" then
		TextCenter = "TextCenter_PlayerInventory"
		local bags = cm.Items and cm.Items.Bags_FULL
		local totalPrice = 0
		if bags then
			for k, v in next, (bags) do
				local itemID = v.itemID
				local count = cm.Items and cm.Items.Bags and cm.Items.Bags[itemID] or 0
				if count> 0 then
					local price = E.func_auctionator_price(itemID)
					if price > 0 then
						totalPrice = totalPrice + (price * count)
					end
				end
			end
		end
		if totalPrice > 0 then
			TextCenter = E.func_FormatMoney(totalPrice)
		end
	end
	if id == "PlayerBANK" then
		TextCenter = "TextCenter_PlayerBANK"
	end
	if id == "HeartofAzeroth" then
		local azerite_lvl = pd.azerite_lvl
		local azerite_xp = pd.azerite_xp
		local azerite_totalLevelXP = pd.azerite_totalLevelXP
		if azerite_lvl and azerite_xp and azerite_totalLevelXP then
			local percent = floor(azerite_xp / azerite_totalLevelXP * 100)
			local missing = azerite_totalLevelXP - azerite_xp

			-- local azeriteEXP = ("%d%%, -%s"):format(
			-- 	floor(azerite_xp / azerite_totalLevelXP * 100),
			-- 	E.func_CompactFormatNumber(azerite_totalLevelXP - azerite_xp)
			-- )
			TextCenter = E.COLOR_GREEN .. azerite_lvl .. "|r" .. E.COLOR_GRAY .. " +" .. E.func_CompactFormatNumber(percent) .. "%, -" .. E.func_CompactFormatNumber(missing) .. "|r"
		else
			if cm.Items.Bank[158075] then
				TextCenter = E.COLOR_ORANGE .. "in bank|r"
			end
		end
	end
	if id == "Ashjrakamas" then
		if pd.cloak_lvl then
			TextCenter = E.COLOR_CYAN .. L["AZERITE_ESSENCE_RANK"]:format(pd.cloak_lvl) .. "|r"
		else
			if cm.Items.Bank[169223] then
				TextCenter = E.COLOR_ORANGE .. "in bank|r"
				-- elseif cm.Items.Bags[169223] then
			end
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_AdditionallyCENTER(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	-- local pd.REGION_NAME = E.pd.REGION_NAME
	-- local pd.FACTION = E.pd.FACTION
	if id == "Callings" then
		local SL_covenantID = pd.SL_covenantID
		if SL_covenantID then
			local covenantData = E.OctoTable_Covenant and E.OctoTable_Covenant[SL_covenantID]
			if covenantData then
				local unlockKey = covenantData.prefix .. "_AreCallingsUnlocked"
				local currentUnlocked = pd[unlockKey]

				-- Проверяем состояние всех ковенантов
				local anyTrue = false
				local allNil = true
				for covID, covInfo in pairs(E.OctoTable_Covenant) do
					local key = covInfo.prefix .. "_AreCallingsUnlocked"
					local val = pd[key]
					if val == true then
						anyTrue = true
						allNil = false
					elseif val == false then
						allNil = false
					end
				end

				if currentUnlocked == true then
					local cacheData = Octo_ToDo_DB_AccountData.Callings and Octo_ToDo_DB_AccountData.Callings[pd.REGION_NAME] and Octo_ToDo_DB_AccountData.Callings[pd.REGION_NAME][SL_covenantID]
					local Data = cm.Callings and cm.Callings[pd.REGION_NAME] and cm.Callings[pd.REGION_NAME][SL_covenantID]

					-- Собираем уникальные квесты из Data и кеша
					local playerQuests = {}
					local callings = {}

					-- Сначала из Data (все записи, включая завершённые)
					if Data then
						for questID, v in pairs(Data) do
							playerQuests[questID] = true
							table.insert(callings, {
								isPlayer = true,
								isCompleted = v.isCompleted,
							})
						end
					end

					-- Добавляем из кеша недостающие (не более 3)
					if cacheData then
						for questID, v in pairs(cacheData) do
							if not playerQuests[questID] and #callings < 3 then
								table.insert(callings, {
									isPlayer = false,
									isCompleted = false,
								})
							end
						end
					end

					-- Добиваем до 3 фиктивными слотами (если нужно)
					while #callings < 3 do
						table.insert(callings, {
							isPlayer = false,
							isCompleted = false,
						})
					end

					-- Сортируем: сначала записи персонажа, затем по endTime, затем по ID
					E.func_SortRecords(callings,
						{"isPlayer", false},
						{"endTime", false},
						{"questID", true}
					)

					local completedCount = 0
					local hasActive = false
					for _, v in ipairs(callings) do
						if v.isCompleted then
							completedCount = completedCount + 1
						elseif v.isPlayer then
							hasActive = true
						end
					end

					local total = 3   -- всегда 3
					local display
					if completedCount == total then
						display = E.DONE
					else
						local color = (hasActive or completedCount > 0) and E.COLOR_WHITE or E.COLOR_GRAY
						display = color .. completedCount .. "/" .. total .. "|r"
					end

					local covenantICON = E.func_GetIcon("covenant", SL_covenantID)
					TextCenter = E.func_texturefromIcon(covenantICON) .. display
				elseif anyTrue then
					local covenantICON = E.func_GetIcon("covenant", SL_covenantID)
					TextCenter = E.COLOR_RED .. L["LOCKED"] .. "|r" -- E.func_texturefromIcon(covenantICON) ..
				elseif allNil then
					local covenantICON = E.func_GetIcon("covenant", SL_covenantID)
					TextCenter = E.COLOR_GRAY .. "-" .. "|r" -- E.func_texturefromIcon(covenantICON) .. L["UNKNOWN"]
				else
					local covenantICON = E.func_GetIcon("covenant", SL_covenantID)
					TextCenter = E.COLOR_RED .. L["LOCKED"] .. "|r" -- E.func_texturefromIcon(covenantICON) ..
				end
			else
				TextCenter = ""
			end
		else
			TextCenter = ""
		end
	end
	if id == "BountiesLegion" or id == "BountiesBattleforAzeroth" then
		local mapID = (id == "BountiesLegion") and E.MapID_Dalaran or E.MapID_Zandalar
		local cmKey = "Bounties" .. mapID
		local cacheKey = "Bounties" .. mapID

		local cacheData = Octo_ToDo_DB_AccountData[cacheKey] and Octo_ToDo_DB_AccountData[cacheKey][pd.REGION_NAME] and Octo_ToDo_DB_AccountData[cacheKey][pd.REGION_NAME][pd.FACTION]
		local Data = cm[cmKey] and cm[cmKey][pd.REGION_NAME] and cm[cmKey][pd.REGION_NAME][pd.FACTION]

		if not (cacheData or Data) then
			TextCenter = ""
		else
			local playerQuests = {}
			local callings = {}

			if Data then
				for questID, v in pairs(Data) do
					playerQuests[questID] = true
					local cacheEntry = cacheData and cacheData[questID]
					table.insert(callings, {
						isPlayer = true,
						isCompleted = v.isCompleted,
						endTime = cacheEntry and cacheEntry.endTime or 0,   -- для сортировки
					})
				end
			end

			if cacheData then
				for questID, v in pairs(cacheData) do
					if not playerQuests[questID] and #callings < 10 then   -- ограничение по желанию, можно убрать
						table.insert(callings, {
							isPlayer = false,
							isCompleted = false,
							endTime = v.endTime or 0,
						})
					end
				end
			end

			if #callings == 0 then
				TextCenter = ""
			else
				E.func_SortRecords(callings,
					{"isPlayer", false},
					{"endTime", false},
					{"questID", true}
				)

				local total = #callings
				local completedCount = 0
				local hasActive = false
				for _, v in ipairs(callings) do
					if v.isCompleted then
						completedCount = completedCount + 1
					elseif v.isPlayer then
						hasActive = true
					end
				end

				local display
				if completedCount == total then
					display = E.DONE
				else
					local color = (hasActive or completedCount > 0) and E.COLOR_WHITE or E.COLOR_GRAY
					display = color .. completedCount .. "/" .. total .. "|r"
				end

				-- local icon = E.func_GetIcon("map", mapID)   -- или E.func_texturefromIcon(...)
				TextCenter = display -- E.func_texturefromIcon(icon) ..
			end
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_Center_AdditionallyBOTTOM(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	if id == "MythicZero" then
		local countMZ = 0
		local totalInstances = 0
		local mythicDifID = 23
		local selectedSeasons = {}
		local ExpansionToShowTBL = E.func_GetData_profileKeys("ExpansionToShow")
		for SI_ID, v in next,(E.Octo_Table_SI_IDS) do
			local tier = v.tier
			if ExpansionToShowTBL[tier] then
				selectedSeasons[tier] = true
			end
		end
		-- Считаем общее количество инстансов в E.Octo_Table_SI_IDS
		for SI_ID, v in next,(E.Octo_Table_SI_IDS) do
			local tier = v.tier
			local isRaid = v.isRaid
			local difficulties = v.difficulties
			if difficulties and difficulties[mythicDifID] and not isRaid and selectedSeasons[tier] then
				totalInstances = totalInstances + 1
			end
		end
		-- Проверяем каждый инстанс из E.Octo_Table_SI_IDS
		for SI_ID, v in next,(E.Octo_Table_SI_IDS) do
			local tier = v.tier
			local isRaid = v.isRaid
			local difficulties = v.difficulties
			if difficulties and difficulties[mythicDifID] and not isRaid and selectedSeasons[tier] then
				if cm.journalInstance and cm.journalInstance[SI_ID] then
					local instanceData = cm.journalInstance[SI_ID]
					-- Проверяем сложность 23 (Mythic)
					if instanceData[mythicDifID] and type(instanceData[mythicDifID]) == "table" then
						local mythicData = instanceData[mythicDifID]
						-- Считаем инстанс пройденным, если убиты все боссы
						if mythicData.defeatedBosses and mythicData.totalBosses
						and mythicData.defeatedBosses == mythicData.totalBosses
						and mythicData.totalBosses > 0 then
							countMZ = countMZ + 1
						end
					end
				end
			end
		end
		-- Формируем текст с цветом
		if totalInstances == 0 then
			TextCenter = E.COLOR_GRAY.."-|r"
		elseif totalInstances > 0 and countMZ == totalInstances then
			TextCenter = E.DONE
			-- TextCenter = E.COLOR_GREEN .. countMZ .. "/" .. totalInstances .. "|r" -- Все пройдены
		elseif countMZ > 0 then
			TextCenter = E.COLOR_YELLOW .. countMZ .. "/" .. totalInstances .. "|r" -- Частично
		else
			TextCenter = E.COLOR_RED .. countMZ .. "/" .. totalInstances .. "|r" -- Ни одного
		end
	end
	if id == "ListOfQuests" then
		if pd.numQuests then
			-- TextCenter = pd.classColorHex .. pd.numQuests .. "/" .. pd.maxNumQuestsCanAccept .. "|r"
			TextCenter = pd.classColorHex .. pd.numQuests .. "|r"
		end
		if pd.numQuests_Paragon then
			TextCenter = TextCenter .. E.COLOR_BLUE .. " +" .. pd.numQuests_Paragon .. "|r"
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
		-- if v then
		-- if cm.LFGInstance[dungeonID].donetoday then
		-- count = count+1
		-- end
		-- end
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
			-- if tonumber(itemID) == 249400 then
			-- end
			if cm.Items.Bags[itemID] or cm.Items.Bank[itemID] then
				count = count+1
				break
			end
		end
		if count > 0 then
			TextCenter = E.COLOR_GRAY .. L["ITEMS"] .. "|r"
		end
	end
	if id == "Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			local skillLineID = charProf[i] and charProf[i].skillLine
			if skillLineID then
				if i == 1 or i == 2 then
					local icon = E.func_GetIcon("profession", skillLineID)
					TextCenter = TextCenter .. E.func_texturefromIcon(icon) -- .. " "
				end
			end
		end
	end
	if id == "ItemLevel" then
		TextCenter = E.func_CharInfo_ItemLevel(CharInfo)
		-- .. " " .. E.func_CharInfo_Durability(CharInfo, true, 41)
	end
	if id == "Money" then
		if pd.Money then
			TextCenter = E.func_GetColorGradient(pd.Money, E.minValue_Money, E.maxValue_Money) .. E.func_FormatMoney(pd.Money)
		end
	end
	if id == "LastOnline" then
		local color = E.COLOR_WHITE
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				TextCenter = E.COLOR_GREEN .. L["FRIENDS_LIST_ONLINE"] .. "|r"
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				TextCenter = color .. E.func_FormatTimeAgo(pd.time) .. "|r"
			end
		end
	end
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_TextCenter_Items(CharInfo, itemID)
	if not itemID then return "" end
	local result = ""
	local cm = CharInfo.MASLENGO
	if not cm or not cm.Items or not cm.Items.Bags or not cm.Items.Bank then return "" end
	local Bags = cm.Items.Bags[itemID]
	local Bank = cm.Items.Bank[itemID]
	if Bags and Bags > 0 then
		result = result .. E.func_CompactFormatNumber(Bags)
	end
	if Bank and Bank > 0 then
		result = result .. E.COLOR_GRAY .. "+" .. E.func_CompactFormatNumber(Bank) .. "|r"
	end
	return result
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_TextCenter_Currency(CharInfo, id, itemID)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local data = cm.Currency
	if not data[id] then data[id] = {} end
	local parts = {}
	local quantity = data[id].quantity or 0
	local totalEarned = data[id].totalEarned
	local maxQuantity = data[id].maxQuantity
	local quantityEarnedThisWeek = data[id].quantityEarnedThisWeek or 0
	local maxWeeklyQuantity = data[id].maxWeeklyQuantity or 0
	local useTotalEarnedForMaxQty = data[id].useTotalEarnedForMaxQty
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()


	local CONFIG_CURRENCY_SHOW_BRACKETS = settingsProfile.CONFIG_CURRENCY_SHOW_BRACKETS or false
	local CONFIG_CURRENCY_SHOW_REMAINING = settingsProfile.CONFIG_CURRENCY_SHOW_REMAINING or false

	local COLOR_BRACKETS = E.func_RGB2Hex(settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_R, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_G, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_B, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_A)
	local COLOR_REMAINING = E.func_RGB2Hex(settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_R, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_G, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_B, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_A)

	-- local COLOR_BRACKETS = "|c" .. settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS or E.COLOR_BLUE
	-- local COLOR_REMAINING = "|c" .. settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING or E.COLOR_YELLOW


	local CONFIG_CURRENCY_SHOW_ZERO = settingsProfile.CONFIG_CURRENCY_SHOW_ZERO or false
	-- Main quantity display
	if quantity > 0 or CONFIG_CURRENCY_SHOW_ZERO then
		if useTotalEarnedForMaxQty then
			parts[#parts+1] = E.func_CompactFormatNumber(quantity)
		else
			if maxQuantity then
				local color = E.COLOR_WHITE
				if quantity == maxQuantity then
					color = E.COLOR_GREEN
				end
				parts[#parts+1] = color .. E.func_CompactFormatNumber(quantity) .. "/" .. E.func_CompactFormatNumber(maxQuantity) .. "|r"
			else
				parts[#parts+1] = E.func_CompactFormatNumber(quantity)
			end
		end
	end
	-- Season-based brackets (totalEarned/maxQuantity)
	if useTotalEarnedForMaxQty and maxQuantity and totalEarned and totalEarned ~= 0 then
		if CONFIG_CURRENCY_SHOW_BRACKETS then
			parts[#parts+1] = COLOR_BRACKETS .. "(" .. E.func_CompactFormatNumber(totalEarned) .. "/" .. E.func_CompactFormatNumber(maxQuantity) .. ")|r"
		end
		if CONFIG_CURRENCY_SHOW_REMAINING then
			if maxQuantity ~= totalEarned then
				local canEarn = maxQuantity - totalEarned
				parts[#parts+1] = COLOR_REMAINING .. "+" .. canEarn .. "|r"
			end
		end
	end
	-- Weekly cap for regular currencies
	if not useTotalEarnedForMaxQty and (quantity > 0 or CONFIG_CURRENCY_SHOW_ZERO) then
		if CONFIG_CURRENCY_SHOW_BRACKETS and maxWeeklyQuantity ~= 0 then
			parts[#parts+1] = COLOR_BRACKETS .. "(" .. E.func_CompactFormatNumber(quantityEarnedThisWeek) .. "/" .. E.func_CompactFormatNumber(maxWeeklyQuantity) .. ")|r"
		end
		if CONFIG_CURRENCY_SHOW_REMAINING and maxWeeklyQuantity ~= 0 and maxWeeklyQuantity ~= quantityEarnedThisWeek then
			local canEarn = maxWeeklyQuantity - quantityEarnedThisWeek
			parts[#parts+1] = COLOR_REMAINING .. "+" .. canEarn .. "|r"
		end
	end
	local result = table.concat(parts, " ")
	if itemID then
		result = result .. E.COLOR_GREEN .. E.func_TextCenter_Items(CharInfo, itemID) .. "|r"
	end
	return result
end
----------------------------------------------------------------
function E.func_Otrisovka_Center_Maps(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextCenter, ColorCenter, FirstReputation, SecondReputation = "", nil, nil, nil
	local info = E.func_GetMapInfo(id)
	if info then
		local mapType = info.mapType
		for k, v in next, (Enum.UIMapType) do
			if v == mapType then
				TextCenter = k
			end
		end
	end

	-- [1] = {
	--     ["Dungeon"] = 4,
	--     ["Orphan"] = 6,
	--     ["Zone"] = 3,
	--     ["Continent"] = 2,
	--     ["Cosmic"] = 0,
	--     ["Micro"] = 5,
	--     ["World"] = 1,
	-- },
	return TextCenter, ColorCenter, FirstReputation, SecondReputation
end
----------------------------------------------------------------