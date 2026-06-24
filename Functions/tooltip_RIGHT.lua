local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function GetVaultProgress(vaultMin, max3)
	if max3 == 0 then
		return E.COLOR_GRAY, vaultMin .. "/" .. max3
	end

	if vaultMin >= max3 then
		return E.COLOR_GREEN, vaultMin .. "/" .. max3
	end

	if vaultMin > 0 then
		return E.COLOR_YELLOW, vaultMin .. "/" .. max3
	end

	return E.COLOR_GRAY, vaultMin .. "/" .. max3
end
----------------------------------------------------------------
local function GetRewardText(rewards, index, max)
	if rewards and rewards[index] then
		return E.COLOR_WHITE .. rewards[index] .. "|r"
	end
	return E.COLOR_GRAY .. "0/" .. max .. "|r"
end
----------------------------------------------------------------
local function Safe(v)
	return v or 0
end
----------------------------------------------------------------
function E.func_KeyTooltip_RIGHT(GUID, SettingsType)
	if not GUID or not SettingsType then return end

	local ServerTime = E.TIME_SERVER()
	local tooltip = {}
	local CharInfo = Octo_ToDo_DB_Levels[GUID]
	if not CharInfo then
		E.WTF_func_CheckAll()
		return
	end
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local dataType, old_id = ("#"):split(SettingsType)
	local id = E.func_SetType(old_id, dataType)
	-- local pd.REGION_NAME = E.pd.REGION_NAME
	-- local pd.FACTION = E.pd.FACTION
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()

	if dataType == "Items" then
		local itemID = id
		local result = ""
		local total = 0
		local itemCount_Bags = 0
		local itemCount_Bank = 0
		if type(itemID) == "number" then
			if cm.Items.Bags[itemID] then
				itemCount_Bags = itemCount_Bags+cm.Items.Bags[itemID]
			end
			if cm.Items.Bank[itemID] then
				itemCount_Bank = itemCount_Bank+cm.Items.Bank[itemID]
			end
			total = itemCount_Bags+itemCount_Bank
		end
		if total > 0 and total ~= itemCount_Bags then
			tooltip[#tooltip+1] = {" ",L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(total)}
			tooltip[#tooltip+1] = {" "," "}
			tooltip[#tooltip+1] = {L["BAG_NAME_BACKPACK"], E.func_CompactFormatNumber(itemCount_Bags)}
			if itemCount_Bank > 0 then
				tooltip[#tooltip+1] = {L["BANK"], E.func_CompactFormatNumber(itemCount_Bank)}
			end
		end
	end
	if dataType == "Currencies" and id ~= 1822 and id ~= 1813 then -- OTHER
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		local data = cm.Currency
		if not data[id] then
			tooltip[#tooltip+1] = {{L["TOTAL"] .. ": 0", "LEFT"}}
		else
			-- L["CURRENCY_SEASON_TOTAL_MAXIMUM"] - Максимум за сезон: %s%s/%s
			-- L["CURRENCY_WEEKLY_CAP"] - Максимум за неделю: %s%s/%s
			-- L["CURRENCY_SEASON_TOTAL"] - В этом сезоне заработано: %s%s
			-- CURRENCY_TOTAL_CAP - Total Maximum: %s%s/%s
			local quantity = data[id].quantity or 0
			local totalEarned = data[id].totalEarned
			local maxQuantity = data[id].maxQuantity
			local quantityEarnedThisWeek = data[id].quantityEarnedThisWeek or 0
			local maxWeeklyQuantity = data[id].maxWeeklyQuantity or 0
			local useTotalEarnedForMaxQty = data[id].useTotalEarnedForMaxQty
			local COLOR_BRACKETS = E.func_RGB2Hex(settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_R, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_G, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_B, settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS_A)
			local COLOR_REMAINING = E.func_RGB2Hex(settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_R, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_G, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_B, settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING_A)

			-- local COLOR_BRACKETS = "|c" .. settingsProfile.CONFIG_CURRENCY_COLOR_BRACKETS or E.COLOR_BLUE
			-- local COLOR_REMAINING = "|c" .. settingsProfile.CONFIG_CURRENCY_COLOR_REMAINING or E.COLOR_YELLOW

			-- local CONFIG_CURRENCY_SHOW_BRACKETS = settingsProfile.CONFIG_CURRENCY_SHOW_BRACKETS or false -- Показывать прогресс в скобках (заработано/максимум)
			-- local CONFIG_CURRENCY_SHOW_REMAINING = settingsProfile.CONFIG_CURRENCY_SHOW_REMAINING or false -- Показывать сколько осталось заработать (+123)
			-- local CONFIG_CURRENCY_SHOW_ZERO = settingsProfile.CONFIG_CURRENCY_SHOW_ZERO or false

			-- Main currency display logic
			if useTotalEarnedForMaxQty then
				-- Season-based currency
				if maxQuantity then
					tooltip[#tooltip+1] = {{L["TOTAL"] .. ": " .. quantity, "LEFT"}}
					if totalEarned and totalEarned ~= 0 then
						tooltip[#tooltip+1] = {{string.format(L["CURRENCY_SEASON_TOTAL_MAXIMUM"], COLOR_BRACKETS, totalEarned, maxQuantity), "LEFT"}}
						if maxQuantity ~= totalEarned then
							local canEarn = maxQuantity - totalEarned
							tooltip[#tooltip+1] = {" "}
							tooltip[#tooltip+1] = {{L["To Earn"]..": " .. COLOR_REMAINING .. canEarn .. "|r", "LEFT"}}
						end
					end
				else
					tooltip[#tooltip+1] = {{L["TOTAL"] .. ": " .. quantity, "LEFT"}}
					tooltip[#tooltip+1] = {{string.format(L["CURRENCY_SEASON_TOTAL"], COLOR_BRACKETS, quantityEarnedThisWeek), "LEFT"}}
				end
			else
				-- Regular currency
				if maxQuantity then
					-- Has maximum limit
					local color = E.COLOR_WHITE
					if quantity == maxQuantity then
						color = E.COLOR_GREEN
					end
					tooltip[#tooltip+1] = {{L["TOTAL"] .. ": " .. color .. quantity .. "/" .. maxQuantity .. "|r", "LEFT"}}
				else
					-- Simple display: just "Total: 123"
					tooltip[#tooltip+1] = {{L["TOTAL"] .. ": " .. quantity, "LEFT"}}
				end
			end
			-- Weekly cap display (always show if exists)
			if maxWeeklyQuantity ~= 0 then
				tooltip[#tooltip+1] = {string.format(L["CURRENCY_WEEKLY_CAP"], COLOR_BRACKETS, quantityEarnedThisWeek, maxWeeklyQuantity)}
				if maxWeeklyQuantity ~= quantityEarnedThisWeek then
					local canEarn = maxWeeklyQuantity - quantityEarnedThisWeek
					tooltip[#tooltip+1] = {" "}
					tooltip[#tooltip+1] = {{L["To Earn"]..": " .. COLOR_REMAINING .. canEarn .. "|r", "LEFT"}}
				end
			end
			if E.DEBUG_CURRENCY_TOOLTIP then
				tooltip[#tooltip+1] = {" "}
				tooltip[#tooltip+1] = {"E.DEBUG = true", " -> Init.lua"}
				tooltip[#tooltip+1] = {"quantity", quantity}
				tooltip[#tooltip+1] = {"totalEarned", totalEarned}
				tooltip[#tooltip+1] = {"maxQuantity", maxQuantity}
				tooltip[#tooltip+1] = {"quantityEarnedThisWeek", quantityEarnedThisWeek}
				tooltip[#tooltip+1] = {"maxWeeklyQuantity", maxWeeklyQuantity}
				tooltip[#tooltip+1] = {"useTotalEarnedForMaxQty", useTotalEarnedForMaxQty}
			end
		end
	end
	if dataType == "Currencies" and id == 1822 then -- Известность
		local SL_covenantID = pd.SL_covenantID or 0
		for covenantID = 1, 4 do
			local cov = E.OctoTable_Covenant[covenantID]
			if cov then
				local name = E.func_GetName("covenant", covenantID)
				-- local color = (SL_covenantID == covenantID) and cov.color or E.COLOR_GRAY
				local color = (SL_covenantID == covenantID) and E.func_DB_COV_COLOR(SL_covenantID) or E.COLOR_GRAY
				local leftText = color .. E.func_texturefromIcon(cov.icon) .. name .. "|r"
				local value = pd[cov.prefix .. "_Renown"] or 0
				local rightText = color .. value .. "|r"
				tooltip[#tooltip+1] = { leftText, "", rightText }
			end
		end
	end
	if dataType == "Currencies" and id == 1813 then -- Запасенная анима
		local SL_covenantID = pd.SL_covenantID or 0
		for covenantID = 1, 4 do
			local cov = E.OctoTable_Covenant[covenantID]
			if cov then
				local name = E.func_GetName("covenant", covenantID)
				local color = (SL_covenantID == covenantID) and cov.color or E.COLOR_GRAY
				local leftText = color .. E.func_texturefromIcon(cov.icon) .. name .. "|r"
				local value = pd[cov.prefix .. "_Anima"] or 0
				local rightText = color .. value .. "|r"
				local centText = ""
				if SL_covenantID == covenantID and pd.SL_Possible_Anima then
					centText = E.COLOR_BLUE .. "+" .. pd.SL_Possible_Anima .. "|r"
				end
				tooltip[#tooltip+1] = { leftText, centText, rightText }
			end
		end
		if settingsProfile.Config_MountsInTooltip then
			E.func_AddTooltipSeparator(tooltip)
		end
	end
	if dataType == "Currencies" and id == 824 then -- Ресурсы гарнизона
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (ServerTime-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, math.floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
			local timeUntilFull = (lastCacheTime+secondsToMax) - ServerTime
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
			end
			tooltip[#tooltip+1] = {L["GARRISON_CACHE"], color .. earnedSinceLastCollect .. "/" .. cacheSize .. "|r"}
			tooltip[#tooltip+1] = {" ", " "}
			if earnedSinceLastCollect ~= cacheSize then
				tooltip[#tooltip+1] = {"Time to full: ", E.func_SecondsToClock(timeUntilFull)}
			end
			tooltip[#tooltip+1] = {"Was earned: ", E.func_SecondsToClock(ServerTime-(cm.GARRISON.lastCacheTime or time()))}
		end
	end
	if dataType == "Currencies" and id == 1166 and settingsProfile.Config_MountsInTooltip then -- Искаженный временем знак
		local icon = E.func_texturefromIcon(E.func_GetIcon("currency", 1166))
		local cache_1166 = E.func_Mounts_1166()
		for i, v in ipairs(cache_1166) do
			local mountID = v.mountID
			local source = v.source
			local price = v.price
			tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), {source, "LEFT"}, E.func_CompactFormatNumber(price) .. icon}
		end
	end
	if id == "CurrentKey" then
		local rioColor
		local seasonData = pd.MythicPlus and pd.MythicPlus[E.MythicPlus_seasonID]
		if seasonData then
			rioColor = E.func_RioColor(seasonData.RIO_Score)
		end
		if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
			local keyName = E.func_formatMplusKey(pd.OwnedKeystoneLevel, pd.OwnedKeystoneChallengeMapID, true, true)
			tooltip[#tooltip+1] = {keyName}
		end
		if seasonData then
			local RIO_Score = tonumber(seasonData.RIO_Score or 0)
			local RIO_weeklyBest = tonumber(seasonData.RIO_weeklyBest or 0)
			if RIO_Score > 0 or RIO_weeklyBest > 0 then
				-- if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
				--     tooltip[#tooltip+1] = {" ", " "}
				-- end
				-- if RIO_weeklyBest > 0 then
				tooltip[#tooltip+1] = {L["BEST"], rioColor..RIO_weeklyBest.."|r"}
				-- end
				if RIO_Score > 0 then
					tooltip[#tooltip+1] = {L["RATING"], rioColor..RIO_Score.."|r"}
				end
			end
		end



		if settingsProfile and settingsProfile.CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE then


			local runHistory = cm.RunHistory
			if runHistory then
				local totalRuns = #runHistory
				if totalRuns > 0 then
					local runsByDungeon = {}
					tooltip[#tooltip+1] = {E.SEPARATOR_KEY}
					tooltip[#tooltip+1] = {L["TOTAL"]..":", totalRuns}
					for index = 1, totalRuns do
						local run = runHistory[index]
						local mapChallengeModeID = run.mapChallengeModeID -- 402,
						local name = E.func_GetName("challenge", mapChallengeModeID)
						local completed = run.completed -- "false",
						local level = run.level -- 22,
						local vaultRewardLevel = math.min(level, 20)

						local thisWeek = run.thisWeek -- "true",
						local runScore = run.runScore -- 165,

						if runsByDungeon[name] == nil then
							runsByDungeon[name] = {run}
						else
							tinsert(runsByDungeon[name], run)
						end
					end
					-- for name, v in pairs(runsByDungeon) do
					-- for index, run in ipairs(runsByDungeon[name]) do
					-- dungeonRuns = dungeonRuns .. name
					-- end
					-- tooltip[#tooltip+1] = {name, colorByCompleted(v[1].level, v[1].completed)}

					-- -- for index, run in ipairs(runsByDungeon[name]) do
					-- -- tooltip[#tooltip+1] = {name, colorByCompleted(run.level, run.completed)}
					-- -- end
					-- end

					-- Populate runs by dungeon text section
					for name, _ in pairs(runsByDungeon) do
						local dungeonRuns = ""
						local mapChallengeModeID
						for index, run in ipairs(runsByDungeon[name]) do
							mapChallengeModeID = run.mapChallengeModeID -- 402,
							dungeonRuns = dungeonRuns .. (run.completed and E.COLOR_GREEN or E.COLOR_RED) .. "+" .. run.level .. "|r"
							if index ~= #runsByDungeon[name] then
								dungeonRuns = dungeonRuns .. ", "
							end
						end
						if mapChallengeModeID then
							local icon = E.func_GetIcon("challenge", mapChallengeModeID)
							name = E.func_texturefromIcon(icon) .. name
						end
						tooltip[#tooltip+1] = {name, dungeonRuns}
					end


				end
			end
		end
	end

	if id == "GreatVault" then
		if pd.HasAvailableRewards then
			-- L["REWARD"]
			tooltip[#tooltip+1] = {E.COLOR_BLUE .. ">" .. L["REWARD"] .."<|r"} -- L["WEEKLY_REWARDS_RETURN_TO_CLAIM"]
		end
		for j = 1, #E.Enum_Activities_table do
			local ID = E.Enum_Activities_table[j]
			local vaultData = cm.GreatVault and cm.GreatVault[ID]
			local rewards = vaultData and vaultData.rewards or {}
			local activities = E.func_GetActivities(ID)
			local max1 = activities and activities[1] and activities[1].threshold or 0
			local max2 = activities and activities[2] and activities[2].threshold or 0
			local max3 = activities and activities[3] and activities[3].threshold or 0
			local vaultMin = vaultData and vaultData.min or 0

			-- прогресс с цветами: зелёный, жёлтый, серый
			local progressColor
			if max3 == 0 then
				progressColor = E.COLOR_GRAY
			elseif vaultMin >= max3 then
				progressColor = E.COLOR_GREEN
			elseif vaultMin > 0 then
				progressColor = E.COLOR_YELLOW
			else
				progressColor = E.COLOR_GRAY
			end

			local progressText = progressColor .. vaultMin .. "/" .. max3 .. "|r"

			tooltip[#tooltip+1] = {
				E.name_activities[ID] or "?",
				" ",
				" ",
				progressText,
				" ",
				" ",
				rewards[1] and E.COLOR_WHITE .. rewards[1] .. "|r" or E.COLOR_GRAY .. vaultMin .. "/" .. max1 .. "|r",
				rewards[2] and E.COLOR_WHITE .. rewards[2] .. "|r" or E.COLOR_GRAY .. vaultMin .. "/" .. max2 .. "|r",
				rewards[3] and E.COLOR_WHITE .. rewards[3] .. "|r" or E.COLOR_GRAY .. vaultMin .. "/" .. max3 .. "|r"
			}
		end

	end

	-- Новый блок для GreatVault1, GreatVault2, GreatVault3
	for i = 1, 3 do
		if id == "GreatVault" .. i then

			local ID = E.Enum_Activities_table[i]
			local vaultData = cm.GreatVault and cm.GreatVault[ID] or {}
			local rewards = vaultData.rewards or {}

			local activities = E.func_GetActivities(ID)

			local max1 = Safe(activities and activities[1] and activities[1].threshold)
			local max2 = Safe(activities and activities[2] and activities[2].threshold)
			local max3 = Safe(activities and activities[3] and activities[3].threshold)

			local vaultMin = Safe(vaultData.min)

			local color, progressText = GetVaultProgress(vaultMin, max3)
			progressText = color .. progressText .. "|r"

			local reward1 = rewards[1] and (E.COLOR_WHITE .. rewards[1] .. "|r") or (E.COLOR_GRAY .. vaultMin .. "/" .. max1 .. "|r")
			local reward2 = rewards[2] and (E.COLOR_WHITE .. rewards[2] .. "|r") or (E.COLOR_GRAY .. vaultMin .. "/" .. max2 .. "|r")
			local reward3 = rewards[3] and (E.COLOR_WHITE .. rewards[3] .. "|r") or (E.COLOR_GRAY .. vaultMin .. "/" .. max3 .. "|r")

			tooltip[#tooltip+1] = {
				E.name_activities[ID] or "?",
				progressText,
				reward1 .. " " .. reward2 .. " " .. reward3
			}


			-- tooltip[#tooltip+1] = {
			--     E.name_activities[ID] or "?",
			--     progressText,
			--     GetRewardText(rewards, 1, max1) .. " " .. GetRewardText(rewards, 2, max2) .. " " .. GetRewardText(rewards, 3, max3)
			-- }


			-- tooltip[#tooltip+1] = {
			--     E.name_activities[ID] or "?",
			--     " ", " ",
			--     progressText,
			--     " ", " ",
			--     GetRewardText(rewards, 1, max1),
			--     GetRewardText(rewards, 2, max2),
			--     GetRewardText(rewards, 3, max3)
			-- }

			-- RAID block (оставлен, но структурирован)
			if ID == 3 and settingsProfile and settingsProfile.CONFIG_ADVANCED_TOOLTIP_GREATVAULT and cm.GreatVaultbossDifficulties  then
				tooltip[#tooltip+1] = {E.SEPARATOR_KEY}
				for instanceID, bosses in pairs(cm.GreatVaultbossDifficulties) do
					local sorted = {}

					for encounterID, data in pairs(bosses) do
						sorted[#sorted+1] = {
							id = encounterID,
							order = data.order,
							difficulty = data.difficulty
						}
					end

					E.func_SortRecords(sorted, function(a, b)
							return a.order < b.order
					end)

					local SI_ID = E.func_EJ_to_SI(instanceID)
					local instanceName = E.func_GetName("dungeon", SI_ID)
					local instanceIcon = E.func_GetIcon("dungeon", SI_ID)

					tooltip[#tooltip+1] = {
						E.func_texturefromIcon(instanceIcon)
						.. E.COLOR_GOLD .. instanceName .. "|r"
					}

					for _, boss in ipairs(sorted) do
						local encounterName = E.func_GetName("encounter", boss.id)

						local diffColor = E.COLOR_GRAY
						local diffName = "-"
						local nameColor = E.COLOR_GRAY

						if boss.difficulty > 0 then
							nameColor = E.COLOR_WHITE
							local diffInfo = E.OctoTable_Difficulties[boss.difficulty]
							diffColor = diffInfo and diffInfo.color or E.COLOR_WHITE
							diffName = E.func_GetName("difficulty", boss.difficulty, nil, true)
						end

						tooltip[#tooltip+1] = {
							nameColor .. encounterName .. "|r",
							"",
							diffColor .. diffName .. "|r"
						}
					end
				end
			end

			-- MYTHIC+ block (чуть чище, без логики в каше)


			-- if ID == 1 and settingsProfile and settingsProfile.CONFIG_ADVANCED_TOOLTIP_MYTHICKEYSTONE then
			--     local runHistory = cm.RunHistory
			--     local vaultDataAll = cm.GreatVault and cm.GreatVault[1]
			--     local rewards = vaultDataAll and vaultDataAll.rewards or {}

			--     local activities = E.func_GetActivities(1)
			--     local thresholds = {
			--         Safe(activities and activities[1] and activities[1].threshold),
			--         Safe(activities and activities[2] and activities[2].threshold),
			--         Safe(activities and activities[3] and activities[3].threshold),
			--     }

			--     local limit = thresholds[3] > 0 and thresholds[3] or 8

			--     -- Всегда показываем заголовок
			--     tooltip[#tooltip+1] = {E.SEPARATOR_KEY}

			--     -- Создаём массив результатов
			--     local results = {}

			--     -- Заполняем топ раны если есть
			--     if runHistory and #runHistory > 0 then
			--         local thisWeekRuns = {}
			--         for _, run in ipairs(runHistory) do
			--             if run.thisWeek then
			--                 thisWeekRuns[#thisWeekRuns + 1] = run
			--             end
			--         end

			--         E.func_SortRecords(thisWeekRuns, function(a, b)
			--             return a.level > b.level
			--         end)

			--         for i = 1, math.min(limit, #thisWeekRuns) do
			--             results[i] = thisWeekRuns[i]
			--         end
			--     end

			--     -- Всегда выводим limit строк
			--     local highlight = {}
			--     if thresholds[1] > 0 then highlight[thresholds[1]] = color end
			--     if thresholds[2] > 0 then highlight[thresholds[2]] = color end
			--     if thresholds[3] > 0 then highlight[thresholds[3]] = color end

			--     for pos = 1, limit do
			--         local run = results[pos]
			--         local NEWcolor = highlight[pos] or E.COLOR_GRAY

			--         if run then
			--             local name = E.func_GetName("challenge", run.mapChallengeModeID)
			--             local rewardIlvl = ""
			--             if highlight[pos] then
			--                 local ilvl = 0
			--                 if pos == thresholds[3] then
			--                     ilvl = rewards[3] or 0
			--                 elseif pos == thresholds[2] then
			--                     ilvl = rewards[2] or 0
			--                 elseif pos == thresholds[1] then
			--                     ilvl = rewards[1] or 0
			--                 end
			--                 rewardIlvl = "(".. ilvl .. ") "
			--             end
			--             tooltip[#tooltip+1] = {
			--                 {NEWcolor .. run.level .. " - " .. name .. "|r" .. rewardIlvl, "LEFT"}
			--             }
			--         else
			--             -- Пустая строка
			--             tooltip[#tooltip+1] = {
			--                 {NEWcolor .. "-|r", "LEFT"}
			--             }
			--         end
			--     end
			-- end




		end
	end



	if id == "PlayerInventory" then
		local bags = cm.Items and cm.Items.Bags_FULL
		if bags then
			local inventoryData = {}

			for k, v in next, (bags) do
				local count = cm.Items and cm.Items.Bags and cm.Items.Bags[v.itemID] or 0
				local row = {}
				table.insert(inventoryData, {
						row = row,
						ItemLink = v.ItemLink,
						itemID = v.itemID,
						Quality = v.Quality,
						Icon = v.Icon,
						inBank = false,
						count = count,
						price = E.func_auctionator_price(v.itemID)
				})
			end
			if #inventoryData > 0 then
				E.func_SortRecords( inventoryData, function(a, b)
						if a.price ~= b.price then
							return a.price > b.price
						end
						if a.Quality ~= b.Quality then
							return a.Quality > b.Quality
						end
						if a.count ~= b.count then
							return a.count > b.count
						end
						return a.itemID < b.itemID
				end)
				local totalPrice = 0
				for _, d in ipairs(inventoryData) do
					local itemID = d.itemID
					local price = d.price
					local row3Text = d.price > 0 and d.count ~= 1 and E.func_FormatMoney(d.price) or ""
					local row5Text = d.price > 0 and d.count > 1 and E.COLOR_YELLOW .. E.func_FormatMoney(d.price * d.count) .. "|r" or ""

					if d.price > 0 and d.count == 1 then
						row5Text = E.func_FormatMoney(d.price)
					end

					if d.price > 0 then
						totalPrice = totalPrice + (d.price * d.count)
					end
					d.row[1] = E.func_texturefromIcon(d.Icon)
					-- d.row[2] = {d.ItemLink, "LEFT"}
					d.row[2] = {E.func_GetName("item", d.itemID, d.Quality), "LEFT"}
					d.row[3] = {row3Text, "LEFT"}
					d.row[4] = {d.count > 1 and "x"..d.count or "", "LEFT"}
					d.row[5] = {row5Text, "LEFT"}
					table.insert(tooltip, d.row)
				end
				local header1 = {
					"",
					"",
					"",
					"",
					TOTAL .. ": " .. E.func_FormatMoney(totalPrice),
				}
				table.insert(tooltip, 1, header1)
			end





		end
	end
	if id == "PlayerBANK" then
		local bank = cm.Items and cm.Items.Bank_FULL


	end
	if dataType == "Currencies" and settingsProfile.Config_MountsInTooltip then
		for currencyID, dataTBL in next, (E.OctoTable_ALL_Mounts) do
			if id == tonumber(currencyID) and id ~= 1166 then
				local mounts = {}
				for mountID, price in next, (dataTBL) do
					local mountIconNumber = E.func_GetIcon("mount", mountID)
					local mountIcon = E.func_texturefromIcon(mountIconNumber)
					local mountName = E.func_GetName("mount", mountID)
					local isCollected = select(11, E.func_GetMountInfoByID(mountID))
					local color = isCollected and E.COLOR_WHITE or E.COLOR_RED
					local mountLeftText = mountIcon .. color .. mountName .. "|r"
					table.insert(mounts, {
							id = mountID,
							price = price,
							name = mountName,
							leftText = mountLeftText,
							collected = isCollected
					})
				end
				E.func_SortRecords(mounts, function(a, b)
						if a.name ~= b.name then
							return a.name < b.name
						end
						return a.id < b.id
				end)
				for _, mount in ipairs(mounts) do
					tooltip[#tooltip+1] = {
						mount.leftText,
						" ",
						E.func_CompactFormatNumber(mount.price) ..
						E.func_texturefromIcon(E.func_GetIcon("currency", currencyID))
					}
				end
			end
		end
	end
	if SettingsType == "BfA_mechagonItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_MECHAGON, true)
	end
	if dataType == "Reputations" then
		if cm.Reputation and cm.Reputation[id] and type(cm.Reputation[id]) == "table" then
			local FIRST = cm.Reputation[id].FIRST or 0
			local SECOND = cm.Reputation[id].SECOND or 0
			local ParagonCount = cm.Reputation[id].ParagonCount
			local repType = cm.Reputation[id].repType
			local reaction = cm.Reputation[id].reaction or 0
			local rankInfocurrentLevel = cm.Reputation[id].rankInfocurrentLevel
			local rankInfomaxLevel = cm.Reputation[id].rankInfomaxLevel
			local renownLevel = cm.Reputation[id].renownLevel
			local renownMaxLevel = cm.Reputation[id].renownMaxLevel
			local gender = pd.UnitSex or 1
			-- local color = E.COLOR_BLACK
			local color = E.func_DB_REP_COLOR(repType, reaction) or E.COLOR_GRAY
			local TEXT_STANDINGS = ""
			if repType == 2 then -- FRIENDSHIP
				if rankInfocurrentLevel and rankInfomaxLevel then
					TEXT_STANDINGS = rankInfocurrentLevel .. "/" .. rankInfomaxLevel
				end
			elseif repType == 3 then
				if renownLevel and renownMaxLevel then
					TEXT_STANDINGS = renownLevel .. "/" .. renownMaxLevel
				end
			elseif repType == 1 then
				if reaction and gender then
					TEXT_STANDINGS = GetText("FACTION_STANDING_LABEL" .. reaction, gender, false)
				end
			elseif repType == 4 then
				TEXT_STANDINGS = L["Paragon"]
			end
			local percent = (SECOND > 0) and math.floor(FIRST / SECOND * 100) or 0
			local percentResult = color .. percent .. "%|r"
			local firstTEXT = ""
			local ICON_TABARD = E.ICON_TABARD
			if ICON_TABARD then
				firstTEXT = firstTEXT .. E.func_texturefromIcon(ICON_TABARD)
			end
			local AdditionalIcon = E.func_GetReputationIcon(id)
			if AdditionalIcon then
				firstTEXT = firstTEXT .. E.func_texturefromIcon(AdditionalIcon)
			end

			local ReputationSide = E.func_GetReputationSide(id)
			if ReputationSide then
				if ReputationSide == "Horde" then
					local icon = E.ICON_HORDE
					firstTEXT = firstTEXT .. E.func_texturefromIcon(icon)
				elseif ReputationSide == "Alliance" then
					local icon = E.ICON_ALLIANCE
					firstTEXT = firstTEXT .. E.func_texturefromIcon(icon)
				elseif ReputationSide == "Neutral" then
					local icon = E.ICON_NEUTRAL
					firstTEXT = firstTEXT .. E.func_texturefromIcon(icon)
				end
			end





			local IsAccountWideReputation = E.func_IsAccountWideReputation(id)
			if IsAccountWideReputation then
				firstTEXT = firstTEXT .. E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE)
			end
			firstTEXT = firstTEXT .. E.func_GetName("reputation", id)
			local secondTEXT = FIRST .. "/" .. SECOND
			if secondTEXT == "1/1" then
				secondTEXT = " "
			end
			local thirdTEXT = E.func_translit(TEXT_STANDINGS)
			local paragonQuest = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].paragonQuest or false
			if paragonQuest and cm.ListOfParagonQuests[paragonQuest] then
				secondTEXT = E.COLOR_PURPLE .. ">" .. FIRST .. "/" .. SECOND .. "<" .. "|r"
			end
			if secondTEXT ~= "0/0" then
				tooltip[#tooltip+1] = {firstTEXT, color .. thirdTEXT .. "|r"}
				tooltip[#tooltip+1] = {"", secondTEXT .. " " .. percentResult}
				if ParagonCount and ParagonCount ~= "" then
					local itemCache = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].itemCache or false
					if itemCache then
						local itemCacheIcon = E.func_texturefromIcon(E.func_GetIcon("item", itemCache))
						tooltip[#tooltip+1] = {" "}
						tooltip[#tooltip+1] = {itemCacheIcon .. L["Turned in:"] .. "", color .. ParagonCount .. "|r"}
					end
				end
			end
			if Octo_ToDo_DB_Variables.CONFIG.CONFIG_DEBUG_REPUTATIONTOOLTIP then
				tooltip[#tooltip+1] = {" "}
				tooltip[#tooltip+1] = {E.COLOR_DEBUG .. "~~~ DEBUG ~~~|r"}
				tooltip[#tooltip+1] = {"FIRST", FIRST} -- число
				tooltip[#tooltip+1] = {"SECOND", SECOND} -- число
				tooltip[#tooltip+1] = {"ParagonCount", ParagonCount} -- число
				tooltip[#tooltip+1] = {"color", color .. color:gsub("|cff", "") .. "|r"} -- строка или таблица цветов
				tooltip[#tooltip+1] = {"repType", repType} -- число
				tooltip[#tooltip+1] = {"reaction", reaction} -- число
				tooltip[#tooltip+1] = {"renownLevel", cm.Reputation[id].renownLevel}
				tooltip[#tooltip+1] = {"renownMaxLevel", cm.Reputation[id].renownMaxLevel}
				tooltip[#tooltip+1] = {"rankInfocurrentLevel", cm.Reputation[id].rankInfocurrentLevel}
				tooltip[#tooltip+1] = {"rankInfomaxLevel", cm.Reputation[id].rankInfomaxLevel}
				local new_reaction = GetText("FACTION_STANDING_LABEL" .. reaction, UnitSex("player"), false)
				tooltip[#tooltip+1] = {"TEXT_STANDINGS", TEXT_STANDINGS} -- строка
				tooltip[#tooltip+1] = {"new_reaction", new_reaction}
			end
		end
	end
	if SettingsType == "AdditionallyBOTTOM#AllItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_ALL, false)
	end
	if SettingsType == "AdditionallyBOTTOM#Professions" then
		local charProf = cm.professions
		local profData = {}
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				local skillLineID = charProf[i].skillLine
				local skillModifier = charProf[i].skillModifier
				local icon = E.func_GetIcon("profession", skillLineID)

				local row1Text = E.func_texturefromIcon(icon)
				local row2Text = E.func_GetName("profession", skillLineID)

				local row3Text = charProf[i].skillLevel
				if skillModifier then
					row3Text = row3Text .. E.COLOR_GREEN .. "+" .. skillModifier .. "|r"
				end

				local row4Text = "/"

				local row5Text = charProf[i].maxSkillLevel


				-- local DFCURRENCY = E.Octo_Table_ProfCurr[skillLineID].DRAGONFLIGHT
				-- local row6Text = ""
				-- if DFCURRENCY then
				-- local count = cm.Currency[DFCURRENCY] and cm.Currency[DFCURRENCY].quantity
				-- if count then
				-- row6Text = E.func_texturefromIcon(E.func_GetIcon("currency", DFCURRENCY)) .. E.func_GetName("currency", DFCURRENCY) .. count
				-- end
				-- end
				local row = { row1Text }

				table.insert(profData, {
						row = row,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
						row5Text = row5Text,
						-- row6Text = row6Text,
						sortValue = i,
				})
			end
		end



		if #profData > 0 then
			E.func_SortRecords(profData, function(a, b)
					if a.sortValue ~= b.sortValue then
						return a.sortValue < b.sortValue
					end
					return a.row2Text < b.row2Text
			end)
			for _, d in ipairs(profData) do
				d.row[2] = {d.row2Text, "LEFT"}
				d.row[3] = {d.row3Text, "RIGHT"}
				d.row[4] = d.row4Text
				d.row[5] = {d.row5Text, "LEFT"}
				-- d.row[6] = d.row6Text
				table.insert(tooltip, d.row)
			end
			-- local header1 = {
			-- "1",
			-- "2",
			-- "3",
			-- "4",
			-- "5",
			-- "6",
			-- }
			-- table.insert(tooltip, 1, header1)
		end



	end
	if SettingsType == "AdditionallyBOTTOM#ItemLevel" then
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				tooltip[#tooltip+1] = {string.format(L["LFG_LIST_ITEM_LEVEL_CURRENT_PVP"], pd.avgItemLevelPvp)}
			end
		end
	end
	if SettingsType == "AdditionallyBOTTOM#Money" then
		if pd.Money then
			local function addMoneyDiff(label, oldValue)
				if not oldValue then return end
				local diff = pd.Money - oldValue
				if diff == 0 then return end
				local color = diff > 0 and E.COLOR_GREEN or E.COLOR_RED
				local result = E.func_FormatMoney(math.abs(diff))
				tooltip[#tooltip+1] = {label, color .. result .. "|r"}
			end
			addMoneyDiff(L["Per Session"], pd.MoneyOnLogin)
			addMoneyDiff(L["Per Day"], pd.MoneyOnDaily)
			addMoneyDiff(L["Per Week"], pd.MoneyOnWeekly)
		end
	end
	if SettingsType == "AdditionallyBOTTOM#LastOnline" then
		local color = "|cffFFFFFF"
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				tooltip[#tooltip+1] = {string.format(L["TIME_PLAYED_ALERT"], pd.classColorHex .. E.func_SecondsToClock(GetSessionTime()) .. "|r" ), " "}
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				tooltip[#tooltip+1] = {color .. E.func_FormatLastSeen(pd.time, pd.classColorHex) .. "|r", ""}
				tooltip[#tooltip+1] = {"", ""}
				tooltip[#tooltip+1] = {color .. pd.loginDay .. "|r", ""}
				tooltip[#tooltip+1] = {color .. pd.loginHour .. "|r", ""}
			end
		end
	end
	if SettingsType == "AdditionallyBOTTOM#MythicZero" then
		-- Создаем временную таблицу для сбора данных
		local tempData = {}
		local mythicDifID = 23

		local selectedSeasons = {}
		local ExpansionToShowTBL = E.func_GetData_profileKeys("ExpansionToShow")
		for SI_ID, v in next,(E.Octo_Table_SI_IDS) do
			local tier = v.tier
			if ExpansionToShowTBL[tier] then
				selectedSeasons[tier] = true
			end
		end

		-- Сначала собираем все данные
		for SI_ID, v in next,(E.Octo_Table_SI_IDS) do
			local tier = v.tier
			local isRaid = E.func_DungeonOrRaid(SI_ID)
			local difficulties = v.difficulties

			if difficulties and difficulties[mythicDifID] and not isRaid and selectedSeasons[tier] then
				local name = E.func_GetName("dungeon", SI_ID)
				local texture = E.func_GetIcon("dungeon", SI_ID)

				local defeatedBosses = 0
				local totalBosses = difficulties and difficulties[mythicDifID] or 0
				local hasData = false
				local icon = E.func_texturefromIcon(texture)
				if cm.journalInstance and cm.journalInstance[SI_ID] then
					local v = cm.journalInstance[SI_ID]
					if v[mythicDifID] and type(v[mythicDifID]) == "table" then
						local difficultyData = v[mythicDifID]
						defeatedBosses = difficultyData.defeatedBosses or 0
						if difficultyData.totalBosses then
							totalBosses = difficultyData.totalBosses
						end
						hasData = true
					end
				end
				local color
				if not hasData then
					color = E.COLOR_GRAY
				elseif defeatedBosses == totalBosses and totalBosses > 0 then
					color = E.COLOR_GREEN
				elseif defeatedBosses > 0 then
					color = E.COLOR_YELLOW
				else
					color = E.COLOR_RED
				end
				local bossProgress = color .. defeatedBosses .. "/" .. totalBosses .. "|r"
				local tier = v.tier
				local CurrentExpansion = E.func_GetCurrentExpansion()
				local source = E.func_FormatExpansion(tier, "LEFT")
				-- Сохраняем данные вместе с tier для сортировки
				table.insert(tempData, {
						tier = tier,
						icon = icon,
						name = name,
						source = source,
						progress = bossProgress,
						color = color,
				})
			end
		end
		E.func_SortRecords(tempData, function(a, b)
				if a.tier == b.tier then
					return a.name < b.name -- Если tier одинаковый, сортируем по имени
				end
				return a.tier > b.tier
				-- return a.name < b.name
		end)
		-- Добавляем отсортированные данные в тултип
		for _, data in ipairs(tempData) do
			tooltip[#tooltip+1] = {data.icon .. data.name, {data.source, "LEFT"}, data.progress}
		end
	end
	if SettingsType == "AdditionallyBOTTOM#ListOfQuests" then
		if pd.numQuests_Paragon and cm.ListOfParagonQuests then
			tooltip[#tooltip+1] = {E.COLOR_BLUE .. L["Paragon"] .. ":|r"}
			local questIDs = {}
			for questID in next, (cm.ListOfParagonQuests) do
				questIDs[#questIDs+1] = questID
			end
			E.func_SortRecords(questIDs, true)
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[#tooltip+1] = {E.func_GetName("quest", questID), cm.ListOfParagonQuests[questID]}
			end
		end
		if pd.numQuests and cm.ListOfQuests then
			local questIDs = {}
			for questID in next, (cm.ListOfQuests) do
				questIDs[#questIDs+1] = questID
			end
			E.func_SortRecords(questIDs, true)
			if pd.numQuests_Paragon then
				tooltip[#tooltip+1] = {" "}
			end
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[#tooltip+1] = {E.func_GetName("quest", questID), cm.ListOfQuests[questID]}
			end
		end
	end
	if SettingsType == "AdditionallyBOTTOM#LFGInstance" then
		local combinedTooltip = {}
		for SI_ID, v in next, (cm.journalInstance) do
			for difficultyID, w in next, (v) do
				local instanceReset = w.instanceReset
				if instanceReset then
					local defeatedBosses = w.defeatedBosses or 0
					local totalBosses = w.totalBosses or 1
					local lastBossDefeated = w.lastBossDefeated or false
					local color = defeatedBosses == totalBosses and E.COLOR_GREEN or (lastBossDefeated and E.COLOR_YELLOW or E.COLOR_WHITE)
					local difficultyName = E.func_GetName("difficulty", difficultyID)
					-- local name = w.name
					local LeftText = E.func_GetName("dungeon", SI_ID)
					local Image = E.func_GetIcon("dungeon", SI_ID)
					local icon
					local isRaid = E.func_DungeonOrRaid(SI_ID)
					if isRaid == true then
						icon = E.func_texturefromIcon(Image) .. E.func_texturefromIcon(E.ATLAS_RAID)
					elseif isRaid == false then
						icon = E.func_texturefromIcon(Image) .. E.func_texturefromIcon(E.ATLAS_DUNGEON)
					end
					if icon then
						LeftText = icon .. LeftText
					end
					local status = color .. defeatedBosses .. "/" .. totalBosses .. "|r"
					table.insert(combinedTooltip, {
							LeftText = LeftText,
							difficultyID = difficultyID,
							status = status,
							time = E.func_SecondsToClock(instanceReset-ServerTime)
					})
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if cm.LFGInstance[dungeonID] then
				local instanceReset = v.instanceReset
				if instanceReset then
					local name = cm.LFGInstance[dungeonID].name .. E.debugInfo(dungeonID)
					local icon = E.func_texturefromIcon(E.ATLAS_DUNGEON)
					local textureFilename = v.textureFilename
					if textureFilename then
						icon = E.func_texturefromIcon(textureFilename) .. icon
					end
					local LeftText = icon .. name
					table.insert(combinedTooltip, {
							LeftText = LeftText,
							difficultyID = v.difficultyID,
							status = " ",
							time = E.func_SecondsToClock(instanceReset-ServerTime),
					})
				end
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			local instanceReset = v.instanceReset
			if instanceReset then
				local name = v.name .. E.debugInfo(worldBossID)
				local icon = E.func_texturefromIcon(E.ATLAS_WORLDBOSS)
				local LeftText = icon .. name
				table.insert(combinedTooltip, {
						LeftText = LeftText,
						difficultyID = 172, -- L["RAID_INFO_WORLD_BOSS"], -- L["World Boss"]
						status = " ",
						time = E.func_SecondsToClock(instanceReset-ServerTime),
				})
			end
		end
		E.func_SortRecords(combinedTooltip, function(a, b)
				local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
				local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
				return pa > pb
		end)
		for _, v in ipairs(combinedTooltip) do
			tooltip[#tooltip+1] = {
				v.LeftText,
				E.func_GetName("difficulty", v.difficultyID),
				v.status,
				E.COLOR_TIME .. v.time .. "|r",
			}
		end
	end


	if id == "Callings" then
		local SL_covenantID = pd.SL_covenantID
		if not SL_covenantID then return end

		local covenantData = E.OctoTable_Covenant and E.OctoTable_Covenant[SL_covenantID]
		if not covenantData then return end

		local unlockKey = covenantData.prefix .. "_AreCallingsUnlocked"
		if not pd[unlockKey] then
			-- tooltip[#tooltip+1] = {L["COVENANT_MISSIONS_EMPTY_LIST"]}

			for covenantID, covInfo in pairs(E.OctoTable_Covenant) do
				local name = E.func_GetName("covenant", covenantID)
				local covUnlockKey = covInfo.prefix .. "_AreCallingsUnlocked"
				local isUnlocked = pd[covUnlockKey]
				local color = covenantID == SL_covenantID and E.func_DB_COV_COLOR(covenantID) or E.COLOR_GRAY
				-- local result = E.COLOR_GRAY .. L["UNKNOWN"] .. "|r"
				-- if isUnlocked then
				--     result = E.COLOR_GREEN .. L["AVAILABLE"] .. "|r"
				-- elseif isUnlocked == false then
				--     result = E.COLOR_RED .. L["LOCKED"] .. "|r"
				-- end
				local result = isUnlocked and (E.COLOR_GREEN .. L["AVAILABLE"] .. "|r") or (isUnlocked == false and (E.COLOR_RED .. L["LOCKED"] .. "|r") or (E.COLOR_GRAY .. L["UNKNOWN"] .. "|r"))

				local covenantICON = E.func_GetIcon("covenant", covenantID)
				tooltip[#tooltip+1] = {E.func_texturefromIcon(covenantICON) .. color .. name .. "|r", result}
			end
			return tooltip
		end


		local cacheData = Octo_ToDo_DB_AccountData.Callings and Octo_ToDo_DB_AccountData.Callings[pd.REGION_NAME] and Octo_ToDo_DB_AccountData.Callings[pd.REGION_NAME][SL_covenantID]
		if not cacheData then return end   -- базовая информация должна быть в кеше

		local Data = cm.Callings and cm.Callings[pd.REGION_NAME] and cm.Callings[pd.REGION_NAME][SL_covenantID]

		local ServerTime = E.TIME_SERVER()
		local callings = {}

		-- Основной источник — кеш (до 3 записей)
		for questID, cacheEntry in pairs(cacheData) do
			if #callings >= 3 then break end
			local dataEntry = Data and Data[questID]
			table.insert(callings, {
					questID = questID,
					name = E.func_GetName("quest", questID),
					-- состояние от персонажа
					isCompleted = dataEntry and dataEntry.isCompleted,
					isPlayer = dataEntry ~= nil,   -- true, если есть хоть какая-то запись в Data
					bountyStr = (dataEntry and not dataEntry.isCompleted) and dataEntry.bountyStr or cacheEntry.bountyStr,
					-- время всегда из кеша
					haveTime = cacheEntry.haveTime,
					endTime = cacheEntry.endTime or 0,
			})
		end

		if #callings == 0 then return end

		-- Сортировка: сначала активные/завершённые персонажа, потом по времени
		E.func_SortRecords(callings,
			-- {"isPlayer", false},
			{"endTime", false},
			{"questID", true}
		)

		local count = math.min(#callings, 3)
		for i = 1, count do
			local v = callings[i]
			local t = ""
			if v.haveTime and v.endTime and v.endTime > ServerTime then   -- всегда показываем, если время ещё не вышло
				t = E.func_SecondsToClock(v.endTime - ServerTime)
			else
				t = L["UNKNOWN"]
			end
			local nameColor, bountyDisplay
			if v.isCompleted then
				nameColor = E.COLOR_GRAY
				bountyDisplay = E.DONE
			elseif v.isPlayer then
				nameColor = E.COLOR_WHITE
				bountyDisplay = v.bountyStr
			else
				nameColor = E.COLOR_GRAY
				bountyDisplay = v.bountyStr
			end

			local timeStr = (t ~= "") and (E.COLOR_TIME .. t .. "|r") or ""
			if v.isCompleted and t ~= "" then
				timeStr = E.COLOR_GRAY .. t .. "|r"   -- серое время для завершённых
			end
			if t == L["UNKNOWN"] then
				timeStr = E.COLOR_GRAY .. L["UNKNOWN"] .. "|r"
			end

			tooltip[#tooltip+1] = {
				nameColor .. v.name .. "|r",
				bountyDisplay,
				timeStr,
			}
		end
	end

	if id == "BountiesLegion" or id == "BountiesBattleforAzeroth" then
		local mapID = (id == "BountiesLegion") and E.MapID_Dalaran or E.MapID_Zandalar
		local cmKey = "Bounties" .. mapID
		local cacheKey = "Bounties" .. mapID

		local cacheData = Octo_ToDo_DB_AccountData[cacheKey] and Octo_ToDo_DB_AccountData[cacheKey][pd.REGION_NAME] and Octo_ToDo_DB_AccountData[cacheKey][pd.REGION_NAME][pd.FACTION]
		local Data = cm[cmKey] and cm[cmKey][pd.REGION_NAME] and cm[cmKey][pd.REGION_NAME][pd.FACTION]

		if not cacheData then return end   -- основа – кеш

		local ServerTime = E.TIME_SERVER()
		local callings = {}

		for questID, cacheEntry in pairs(cacheData) do
			local dataEntry = Data and Data[questID]
			table.insert(callings, {
					questID = questID,
					name = cacheEntry.name or E.func_GetName("quest", questID),
					isCompleted = dataEntry and dataEntry.isCompleted,
					isPlayer = dataEntry ~= nil,
					bountyStr = (dataEntry and not dataEntry.isCompleted) and dataEntry.bountyStr or cacheEntry.bountyStr,
					haveTime = cacheEntry.haveTime,
					endTime = cacheEntry.endTime or 0,
					icon = cacheEntry.icon,
			})
		end

		if #callings == 0 then return end

		E.func_SortRecords(callings,
			-- {"isPlayer", false},
			{"endTime", false},
			{"questID", true}
		)

		for _, v in ipairs(callings) do
			local t = ""
			if v.haveTime and v.endTime and v.endTime > ServerTime then
				t = E.func_SecondsToClock(v.endTime - ServerTime)
			end
			local nameColor, bountyDisplay
			if v.isCompleted then
				nameColor = E.COLOR_GRAY
				bountyDisplay = E.DONE
			elseif v.isPlayer then
				nameColor = E.COLOR_WHITE
				bountyDisplay = v.bountyStr
			else
				nameColor = E.COLOR_GRAY
				bountyDisplay = v.bountyStr
			end

			local timeStr = (t ~= "") and (E.COLOR_TIME .. t .. "|r") or ""
			if v.isCompleted and t ~= "" then
				timeStr = E.COLOR_GRAY .. t .. "|r"
			end

			tooltip[#tooltip+1] = {
				E.func_texturefromIcon(v.icon) .. nameColor .. v.name .. "|r",
				bountyDisplay,
				timeStr,
			}
		end
	end



	if dataType == "UniversalQuests" then
		local function BuildQuestLine(questData, questKey, currentHeader)
			local questID = questData[1]
			local FactionOrClass = questData.FactionOrClass
			local forcedText = questData.forcedText
			local addText = questData.addText   -- теперь только это поле
			local prof = questData.prof
			local header = questData.HEADER

			local Output_LEFT = ""
			local Output_CENT = ""
			local Output_RIGHT = ""

			-- Профессия
			if prof then
				if not (pd.professions and pd.professions[prof]) then
					return nil, currentHeader
				end
				Output_LEFT = Output_LEFT .. E.func_texturefromIcon(E.func_GetIcon("profession", prof))
			end

			-- Заголовок
			if header and header ~= currentHeader then
				currentHeader = header
				tooltip[#tooltip+1] = {E.COLOR_SKYBLUE .. header .. "|r", " ", " "}
			end

			-- Статус квеста (правая колонка)
			if questID then
				local status = cm.UniversalQuest and cm.UniversalQuest[questKey] and cm.UniversalQuest[questKey][questID]
				if not status then
					status = E.COLOR_GRAY .. L["NONE"] .. "|r"
				elseif status == true then
					status = E.DONE
				end
				Output_RIGHT = status
			end

			-- forcedText (левая колонка)
			if forcedText then
				if forcedText.text then
					Output_LEFT = Output_LEFT .. forcedText.text .. " "
				end
				if forcedText.npcID then
					Output_LEFT = Output_LEFT .. E.func_GetName("npc", forcedText.npcID) .. " "
				end
				if forcedText.achievementID then
					Output_LEFT = Output_LEFT .. E.func_GetName("achievement", forcedText.achievementID) .. " "
				end
				if forcedText.itemID then
					Output_LEFT = Output_LEFT
						.. E.func_texturefromIcon(E.func_GetIcon("item", forcedText.itemID))
						.. E.func_GetName("item", forcedText.itemID)
						.. " "
				end
				if forcedText.Icon then
					Output_LEFT = E.func_texturefromIcon(forcedText.Icon) .. Output_LEFT
				end
				Output_LEFT = Output_LEFT:match("^(.-)%s*$")
			elseif questID then
				Output_LEFT = Output_LEFT
					-- .. E.func_GetIcon("quest", questID)
					.. E.func_GetName("quest", questID)
			end

			if addText then
				local targets = {
					LEFT = Output_LEFT,
					CENT = Output_CENT,
					RIGHT = Output_RIGHT
				}
				local align = addText.align or "LEFT"

				-- Иконки (всегда в выбранную колонку)
				if addText.IconVignette then
					targets[align] = E.func_texturefromIcon(addText.IconVignette) .. targets[align]
				end
				if addText.Icon then
					targets[align] = E.func_texturefromIcon(addText.Icon) .. targets[align]
				end

				-- Текстовые поля
				if addText.notes then
					targets[align] = targets[align] .. addText.notes
				end

				if addText.mapID then
					targets[align] = targets[align]
						.. E.COLOR_GRAY
						.. " ("
						.. E.func_GetName("map", addText.mapID)
						.. ")|r"
				end
				if addText.spellID then
					targets[align] = targets[align]
						.. E.COLOR_PINK
						.. E.func_GetName("spell", addText.spellID)
						.. "|r"
				end
				if addText.text then
					targets[align] = targets[align] .. addText.text
				end
				if addText.itemID then
					targets[align] = targets[align]
						.. E.func_texturefromIcon(E.func_GetIcon("item", addText.itemID))
						.. E.func_GetName("item", addText.itemID)
				end

				-- Временные/центральные поля
				if addText.timestamp then
					targets[align] = targets[align] .. E.func_SecondsToClock(addText.timestamp)
				end
				if addText.mount then
					targets[align] = targets[align]
						.. E.COLOR_PURPLE
						.. " +"
						.. string.format(RENOWN_REWARD_MOUNT_NAME_FORMAT, E.func_FormatMountInfo(addText.mount))
						.. "|r"
				end
				if addText.expansionText then
					targets[align] = targets[align] .. addText.expansionText
				end
				if addText.coords then
					local x, y = E.func_UnpackCoordinates(addText.coords)
					targets[align] = targets[align] .. E.func_FormatCoordinates(x, y)
				end

				-- Записываем обратно
				Output_LEFT = targets.LEFT
				Output_CENT = targets.CENT
				Output_RIGHT = targets.RIGHT
			end

			-- Иконка фракции/класса (слева)
			if FactionOrClass then
				if FactionOrClass[pd.FACTION] then
					Output_LEFT = E.func_texturefromIcon(E.func_GetFactionIcon(pd.FACTION)) .. Output_LEFT
				elseif FactionOrClass[pd.classFilename] then
					Output_LEFT = E.func_texturefromIcon(pd.specIcon) .. Output_LEFT
				end
			end

			return {Output_LEFT, {Output_CENT, "LEFT"}, Output_RIGHT}, currentHeader
		end

		for _, data in next, (E.ALL_UniversalQuests) do
			local questKey = data.questKey
			local showTooltip = data.showTooltip or false
			if showTooltip and id == questKey then
				local totalQuest = 0
				if data.questpools then
					totalQuest = #data.questpools
				elseif data.quests then
					local forcedMaxQuest = data.forcedMaxQuest
					for _, questData in ipairs(data.quests) do
						if type(questData[1]) == "number" then
							local FactionOrClass = questData.FactionOrClass
							local prof = questData.prof
							if not FactionOrClass or (FactionOrClass[pd.FACTION] or FactionOrClass[pd.classFilename]) then
								local hasProf = true
								if prof then
									hasProf = pd.professions and pd.professions[prof]
								end
								if hasProf then
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
						end
					end
				end

				if Octo_ToDo_DB_Variables.CONFIG.CONFIG_DEBUG_UNIVERSAL then
					tooltip[#tooltip+1] = {questKey, "total: " .. totalQuest}
				end

				if totalQuest >= 1 then
					local output = ""
					if type(data.TextLeft) == "function" then
						output = data.TextLeft()
						if output == nil then
							output = E.TEXT_ERROR
						end
					elseif type(data.TextLeft) == "string" then
						output = data.TextLeft
					end
					local TextLeft = tostringall(E.func_FormatResetType(data.reset) .. " " .. output)
					tooltip[#tooltip+1] = {" ", " ", L["TOTAL"] .. ": " .. totalQuest}
				end

				if data.questpools then
					local numPools = #data.questpools
					local anyPoolHasMultiple = false
					for _, p in ipairs(data.questpools) do
						if #p > 1 then
							anyPoolHasMultiple = true
							break
						end
					end
					for poolIndex, pool in ipairs(data.questpools) do
						local sortedPool = {}
						for _, questData in ipairs(pool) do
							if type(questData[1]) == "number" then
								local FactionOrClass = questData.FactionOrClass
								if not FactionOrClass or (FactionOrClass[pd.FACTION] or FactionOrClass[pd.classFilename]) then
									table.insert(sortedPool, questData)
								end
							end
						end
						if data.sorted ~= false then
							E.func_SortRecords(sortedPool, function(a, b)
								local function getName(entry)
									if not entry then return "" end
									if entry.forcedText then
										if entry.forcedText.npcID then
											return E.func_GetName("npc", entry.forcedText.npcID) or ""
										elseif entry.forcedText.text then
											return entry.forcedText.text or ""
										end
									end
									return E.func_GetName("quest", entry[1]) or ""
								end
								return getName(a) < getName(b)
							end)
						end
						local currentHeader = nil
						for _, questData in ipairs(sortedPool) do
							if type(questData[1]) == "number" then
								local row, newHeader = BuildQuestLine(questData, questKey, currentHeader)
								if row then
									tooltip[#tooltip+1] = row
									currentHeader = newHeader
								end
							end
						end
						if anyPoolHasMultiple and numPools > 1 and poolIndex < numPools then
							tooltip[#tooltip+1] = {" " or E.SEPARATOR_KEY}
						end
					end
				else
					local entriesToShow = {}
					for _, questData in ipairs(data.quests) do
						local FactionOrClass = questData.FactionOrClass
						if not FactionOrClass or (FactionOrClass[pd.FACTION] or FactionOrClass[pd.classFilename]) then
							table.insert(entriesToShow, questData)
						end
					end

					if data.sorted ~= false then
						E.func_SortRecords(entriesToShow, function(a, b)
							local function getName(entry)
								if not entry then return "" end
								if entry.forcedText then
									if entry.forcedText.npcID then
										return E.func_GetName("npc", entry.forcedText.npcID) or ""
									elseif entry.forcedText.text then
										return entry.forcedText.text or ""
									end
								end
								return E.func_GetName("quest", entry[1]) or ""
							end
							return getName(a) < getName(b)
						end)
					end

					local currentHeader = nil
					for _, questData in ipairs(entriesToShow) do
						local row, newHeader = BuildQuestLine(questData, questKey, currentHeader)
						if row then
							tooltip[#tooltip+1] = row
							currentHeader = newHeader
						end
					end
				end
			end
		end
	end

	if dataType == "RaidsOrDungeons" then
		if type(id) ~= "number" then return end
		local instanceData = cm.journalInstance and cm.journalInstance[id] or {}
		local completedDiffs = {}
		local bosses = {}
		local resetTime
		-- 1. получаем список всех сложностей для инстанса
		local difficulties
		for SI_ID, v in next, (E.Octo_Table_SI_IDS) do -- E.Octo_Table_SI_IDS
			if SI_ID == id then
				difficulties = v.difficulties
				break
			end
		end
		if not difficulties then return end
		-- 2. собираем сложности в зависимости от конфига
		if settingsProfile.CONFIG_RAIDS_DIFFICULTIES_ALL then
			for difficultyID, totalBosses in next, difficulties do
				local ji = instanceData[difficultyID] or {}
				completedDiffs[#completedDiffs+1] = {
					difficultyID = difficultyID,
					defeatedBosses = ji.defeatedBosses or 0,
					totalBosses = totalBosses,
					lastBossDefeated = ji.lastBossDefeated or false,
					Bosses = ji.Bosses
				}
				if not resetTime and ji.instanceReset and ji.instanceReset > 0 then
					resetTime = ji.instanceReset
				end
			end
		else
			for difficultyID, ji in next, instanceData do
				if ji.defeatedBosses and ji.defeatedBosses > 0 then
					completedDiffs[#completedDiffs+1] = {
						difficultyID = difficultyID,
						defeatedBosses = ji.defeatedBosses,
						totalBosses = ji.totalBosses,
						lastBossDefeated = ji.lastBossDefeated,
						Bosses = ji.Bosses
					}
					if not resetTime and ji.instanceReset and ji.instanceReset > 0 then
						resetTime = ji.instanceReset
					end
				end
			end
		end
		if #completedDiffs == 0 then return end
		-- 3. сортировка по приоритету из OctoTable_Difficulties
		E.func_SortRecords(completedDiffs, function(a, b)
				local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
				local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
				return pa < pb
		end)
		-- 4. фиксируем порядок боссов по первой доступной сложности
		for _, diff in ipairs(completedDiffs) do
			local ji = diff.Bosses
			if ji and #ji > 0 then
				for i = 1, #ji do
					local b = ji[i]
					bosses[i] = { name = b.bossName, kills = {} }
				end
				break
			end
		end
		-- 5. заполняем киллы по сложностям
		for _, diff in ipairs(completedDiffs) do
			local ji = diff.Bosses
			if ji and #ji > 0 then
				for i = 1, #ji do
					bosses[i].kills[diff.difficultyID] = ji[i].bossKilled
				end
			end
		end
		-- 6. шапка: reset+сложности
		local header = {}
		if resetTime then
			header[1] = {E.COLOR_TIME .. E.func_SecondsToClock(resetTime-ServerTime) .. "|r", "LEFT"}
		else
			header[1] = {" ", "LEFT"}
		end
		for _, diff in ipairs(completedDiffs) do
			header[#header+1] = {E.func_GetName("difficulty", diff.difficultyID), "CENTER"}
		end
		tooltip[#tooltip+1] = header
		-- 8. итоговая строка L["TOTAL"]
		local totalRow = {{E.COLOR_GRAY .. L["TOTAL"] .. "|r", "LEFT"}}
		for _, diff in ipairs(completedDiffs) do
			local color
			if diff.defeatedBosses == diff.totalBosses then
				color = E.COLOR_GREEN
			elseif diff.lastBossDefeated then
				color = E.COLOR_YELLOW
			else
				color = E.COLOR_WHITE
			end
			totalRow[#totalRow+1] = {color .. diff.defeatedBosses .. "/" .. diff.totalBosses .. "|r", "CENTER"}
		end
		tooltip[#tooltip+1] = totalRow
		-- 7. строки боссов
		if bosses and #bosses > 0 then
			tooltip[#tooltip+1] = {""}
		end
		for i = 1, #bosses do
			local boss = bosses[i]
			local row = {{boss.name, "LEFT"}}
			for _, diff in ipairs(completedDiffs) do
				if boss.kills[diff.difficultyID] then
					row[#row+1] = {E.DONE, "CENTER"}
				else
					row[#row+1] = {E.COLOR_GRAY .. "-|r", "CENTER"}
				end
			end
			tooltip[#tooltip+1] = row
		end
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_BuildItemTooltip(CharInfo, TBL, needShowAllItems)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local tooltip = {}
	local sorted_itemList = {}
	local Items_BAGS = cm.Items.Bags
	local Items_BANK = cm.Items.Bank
	local total_BAGS = 0
	local total_BANK = 0
	for itemID in next, (TBL) do
		local count_BAGS = Items_BAGS[itemID] or 0
		local count_BANK = Items_BANK[itemID] or 0
		local hasData = needShowAllItems or (count_BAGS > 0 or count_BANK > 0)
		if hasData then
			if count_BANK > 0 then
				total_BANK = total_BANK+count_BANK
			end
			local quality = E.func_GetItemQualityByID(itemID)
			if cm and cm.Items and cm.Items.Bags_FULL and cm.Items.Bags_FULL[itemID] and cm.Items.Bags_FULL[itemID].Quality then
				quality = cm.Items.Bags_FULL[itemID].Quality
			end
			if cm and cm.Items and cm.Items.Bank_FULL and cm.Items.Bank_FULL[itemID] and cm.Items.Bank_FULL[itemID].Quality then
				quality = cm.Items.Bank_FULL[itemID].Quality
			end
			table.insert(sorted_itemList, {
					itemID = itemID,
					quality = quality,
					count_BAGS = count_BAGS,
					count_BANK = count_BANK,
			})
		end
	end
	E.func_SortRecords(sorted_itemList, function(a, b)
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
		tooltip[#tooltip+1] = {"", {L["BAG_NAME_BACKPACK"], "RIGHT"}, {E.COLOR_GRAY .. L["BANK"] .. "|r", "LEFT"}}
	end
	for _, v in ipairs(sorted_itemList) do
		local itemID = v.itemID
		local quality = v.quality
		local count_BAGS = v.count_BAGS
		local count_BANK = v.count_BANK
		local row2Text = count_BAGS > 0 and E.func_CompactFormatNumber(count_BAGS) or ""
		local row3Text = count_BANK > 0 and E.COLOR_GRAY .. "+" .. E.func_CompactFormatNumber(count_BANK) .. "|r" or ""
		local icon = E.func_texturefromIcon(E.func_GetIcon("item", itemID))
		local name = E.func_GetName("item", itemID, quality)
		-- local quality = 1
		-- if cm.Items and cm.Items.Bags_FULL and cm.Items.Bags_FULL[itemID] then
		-- -- name = cm.Items.Bags_FULL[itemID].ItemLink
		-- quality = cm.Items.Bags_FULL[itemID].Quality
		-- elseif cm.Items and cm.Items.Bank_FULL and cm.Items.Bank_FULL[itemID] then
		-- -- name = cm.Items.Bank_FULL[itemID].ItemLink
		-- quality = cm.Items.Bank_FULL[itemID].Quality
		-- else
		-- name = E.func_GetName("item", itemID)
		-- end
		tooltip[#tooltip+1] = {
			icon .. name,
			{row2Text, "RIGHT"},
			{row3Text, "LEFT"}
		}
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------