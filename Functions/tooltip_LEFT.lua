local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
function E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
	local pd = CharInfo.PlayerData
	local isVisible = visiblePlayers[GUID]
	local colorPlayer = isVisible and pd.classColorHex or E.COLOR_GRAY
	local colorServer = isVisible and "|cffFFFFFF" or E.COLOR_GRAY
	local curPers = pd.GUID == E.curGUID and E.COLOR_GREEN.."*|r" or ""
	-- local curServer = pd.curServer ~= currentRealm and "-"..pd.curServer or ""
	local curServerShort = pd.curServerShort ~= E.curServerShort and "-"..pd.curServerShort or ""
	local leftText =
	E.func_texturefromIcon(pd.specIcon)..
	colorPlayer..pd.Name..
	colorServer..curServerShort.."|r"..
	curPers
	return leftText
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CovenantCurrencyTooltip(id, visiblePlayers, typeSL)
	-- typeSL: 1 = Renown, 2 = Anima
	local tooltip = {}
	local isRenown = (typeSL == 1)
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local grandTotal = 0
	local totalPossible = 0
	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		local covData = CharInfo.MASLENGO.CovenantAndAnima
		local curCovID = covData and covData.curCovID
		if curCovID then
			local pd = CharInfo.PlayerData
			local values = {}
			local charTotal = 0
			local activeValue = 0
			for covenant = 1, 4 do
				local value = covData[covenant] and covData[covenant][typeSL] or 0
				values[covenant] = value
				charTotal = charTotal + value
				if covenant == curCovID then
					activeValue = value
				end
			end
			-- Фильтр пустоты
			local hasData
			if isRenown then
				hasData = activeValue > 0
			else
				hasData = charTotal > 0 or (pd.Possible_Anima or 0) > 0
			end
			if hasData then
				if not isRenown then
					grandTotal = grandTotal + charTotal
					totalPossible = totalPossible + (pd.Possible_Anima or 0)
				end
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				for covenant = 1, 4 do
					local value = values[covenant]
					if value > 0 then
						local c = covenant == curCovID
						and E.OctoTable_Covenant[covenant].color
						or E.COLOR_GRAY
						row[covenant + 1] = c..E.func_CompactFormatNumber(value).."|r"
					else
						row[covenant + 1] = "-"
					end
				end
				local totalAnimaText
				local sortValue
				local Possible_Anima
				if isRenown then
					sortValue = activeValue
				else
					sortValue = charTotal -- + (pd.Possible_Anima or 0)
					if charTotal ~= 0 then
						totalAnimaText = E.func_CompactFormatNumber(charTotal)
					else
						totalAnimaText = "-"
					end
					if pd.Possible_Anima and pd.Possible_Anima > 0 then
						Possible_Anima = E.COLOR_BLUE.." +"..E.func_CompactFormatNumber(pd.Possible_Anima).."|r"
					end
				end
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = sortValue,
						-- charValue = isRenown and activeValue or charTotal,
						Possible_Anima = Possible_Anima or " ",
						totalAnimaText = totalAnimaText,
				})
			end
		end
	end
	if #characterData > 0 then
		--------------------------------------------------------
		-- 2. Сортировка
		--------------------------------------------------------
		table.sort(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		--------------------------------------------------------
		-- 3. Градиент (только для Anima)
		--------------------------------------------------------
		local minValue, maxValue
		if not isRenown then
			minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		end
		--------------------------------------------------------
		-- 4. Вывод персонажей
		--------------------------------------------------------
		for _, d in ipairs(characterData) do
			if not isRenown then
				local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
				d.row[6] = d.Possible_Anima
				d.row[7] = color..d.totalAnimaText.."|r"
			end
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData >= 1 then
			local header = {
				"",
				E.func_texturefromIcon(E.ICON_KYRIAN),
				E.func_texturefromIcon(E.ICON_VENTHYR),
				E.func_texturefromIcon(E.ICON_NIGHTFAE),
				E.func_texturefromIcon(E.ICON_NECROLORD),
				""
			}
			if not isRenown then
				header[#header+1] = TOTAL..": "..E.func_CompactFormatNumber(grandTotal)
			end
			table.insert(tooltip, 1, header)
		end
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_ItemLevelTooltipLeft(visiblePlayers)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local avgILVL = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
			local avgItemLevel = pd.avgItemLevel or 0
			local avgItemLevelPvp = pd.avgItemLevelPvp or 0
			-- Фильтр пустоты
			local hasData = pd.avgItemLevelEquipped > 0 or pd.avgItemLevel > 0 or pd.avgItemLevelPvp > 0
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = ""
				local row3Text = ""
				if pd.avgItemLevelEquipped and pd.avgItemLevel then
					row2Text = pd.avgItemLevelEquipped
					if pd.avgItemLevel > pd.avgItemLevelEquipped then
						row3Text = " +"..pd.avgItemLevel-pd.avgItemLevelEquipped
					end
					if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
						row2Text = row2Text..E.COLOR_BLUE.."+|r"
					end
				end
				avgILVL = avgILVL + pd.avgItemLevel
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = avgItemLevelEquipped,
						-- charValue = avgItemLevelEquipped,
						row2Text = row2Text,
						row3Text = row3Text,
				})
			end
		end
	end
	if #characterData > 0 then
		--------------------------------------------------------
		-- 2. Сортировка
		--------------------------------------------------------
		table.sort(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		--------------------------------------------------------
		-- 3. Градиент
		--------------------------------------------------------
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		--------------------------------------------------------
		-- 4. Вывод персонажей
		--------------------------------------------------------
		for _, d in ipairs(characterData) do
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = color..d.row2Text.."|r"
			d.row[3] = color..d.row3Text.."|r"
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData > 1 then
			local header = {
				"",
				"avg"..": "..E.func_CompactFormatNumber(avgILVL/#characterData),
				"",
			}
			table.insert(tooltip, 1, header)
		end
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_ProfessionsTooltipLeft(visiblePlayers)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cmP = CharInfo.MASLENGO.professions
			-- Фильтр пустоты
			local hasData = cmP[1] and cmP[1].skillLine
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local prof = {}
				for i = 1, 2 do
					prof[i] = prof[i] or {}
					prof[i].Icon = ""
					prof[i].Text = ""
					if cmP[i] and cmP[i].skillLevel and cmP[i].maxSkillLevel then
						prof[i].Icon = E.func_ProfessionIcon(cmP[i].skillLine)
						prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel).."/"..E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
						if cmP[i].skillModifier then
							prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel)..E.COLOR_GREEN.."+"..E.func_CompactFormatNumber(cmP[i].skillModifier).."|r".."/"..E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
						end
					end
				end
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = cmP[1].skillLine,
						sortValue2 = cmP[1].skillLevel,
						prof1Icon = prof[1].Icon,
						prof1Text = prof[1].Text,
						prof2Icon = prof[2].Icon,
						prof2Text = prof[2].Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			elseif a.sortValue2 ~= b.sortValue2 then
				return a.sortValue2 > b.sortValue2
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	-- local minValue, maxValue
	-- local MinMaxValues = E.func_GetMinMaxValue(characterData, "charValue")
	-- minValue = math.min(unpack(MinMaxValues))
	-- maxValue = math.max(unpack(MinMaxValues))
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		-- local color = E.func_GetColorGradient(d.charValue, minValue, maxValue)
		-- d.row[2] = ""
		d.row[2] = {d.prof1Text..d.prof1Icon, "RIGHT"}
		-- d.row[4] = ""
		-- d.row[5] = ""
		d.row[3] = {d.prof2Text..d.prof2Icon, "RIGHT"}
		-- d.row[4] = ""
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	-- if #characterData > 1 then
	-- local header = {
	-- "1",
	-- "2",
	-- "3",
	-- "4",
	-- "5",
	-- "6",
	-- "7",
	-- }
	-- table.insert(tooltip, 1, header)
	-- end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CurrenciesTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			local curquantity = cm.Currency[id] and cm.Currency[id].quantity or 0
			local curmaxQuantity = cm.Currency[id] and cm.Currency[id].maxQuantity or 0
			-- Фильтр пустоты
			local hasData = curquantity > 0
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = E.func_CompactFormatNumber(curquantity)
				if curmaxQuantity > 0 then
					row2Text = row2Text.."/"..E.func_CompactFormatNumber(curmaxQuantity)
				end
				total = total + curquantity
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curquantity,
						-- charValue = curquantity,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	if #characterData > 0 then
		table.sort(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		--------------------------------------------------------
		-- 3. Градиент
		--------------------------------------------------------
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		--------------------------------------------------------
		-- 4. Вывод персонажей
		--------------------------------------------------------
		for _, d in ipairs(characterData) do
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = color..d.row2Text.."|r"
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData > 1 then
			local header = {
				"",
				TOTAL..": "..E.func_CompactFormatNumber(total),
			}
			table.insert(tooltip, 1, header)
		end
		--------------------------------------------------------
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- CharInfo.PlayerData.Money
function E.func_MoneyTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local curMoney = pd.Money
			-- Фильтр пустоты
			local hasData = curMoney > 0
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = E.func_FormatMoney(curMoney)
				total = total + curMoney
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curMoney,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 0 then
		C_WowTokenPublic.UpdateMarketPrice()
		if C_WowTokenPublic.GetCurrentMarketPrice() then
			local price, hz = C_WowTokenPublic.GetCurrentMarketPrice()
			local header1 = {
				"",
				E.func_GetItemName(122284)..": "..E.func_FormatMoney(C_WowTokenPublic.GetCurrentMarketPrice())
			}
			table.insert(tooltip, 1, header1)
		end
		if C_Bank.FetchDepositedMoney(Enum.BankType.Account) then
			local heade2 = {
				"",
				ACCOUNT_BANK_PANEL_TITLE..": "..E.func_FormatMoney(C_Bank.FetchDepositedMoney(Enum.BankType.Account)),
			}
			table.insert(tooltip, 2, heade2)
		end
		local heade3 = {
			"",
			TOTAL..": "..E.func_FormatMoney(total),
		}
		table.insert(tooltip, 3, heade3)
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_WasOnlineTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local curTime = pd.realTotalTime
			-- Фильтр пустоты
			local hasData = curTime > 0
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = E.func_SecondsToClock(curTime)
				total = total + curTime
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curTime,
						row2Text = row2Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = color..d.row2Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			TOTAL..": "..E.func_SecondsToClock(total),
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CurrentKeyTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local CurrentKeyName = pd.CurrentKeyName or ""
			local CurrentKeyLevel = pd.CurrentKeyLevel or 0
			local RIO_weeklyBest = pd.RIO_weeklyBest or E.COLOR_GRAY.."-|r"
			local RIO_Score = pd.RIO_Score or 0
			local keyABBR = pd.CurrentKey or ""
			-- Фильтр пустоты
			local hasData = (RIO_Score > 0) or (CurrentKeyLevel > 0)
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = keyABBR -- ..E.COLOR_ORANGE..CurrentKeyLevel.."|r "..E.COLOR_PURPLE..CurrentKeyName.."|r"
				local row3Text = RIO_weeklyBest
				local row4Text = RIO_Score
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = RIO_Score,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = {d.row2Text, "LEFT"}
		d.row[3] = d.row3Text
		d.row[4] = color..d.row4Text.."|r"
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			"",
			"Weekly Best",
			"RIO",
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GreatVaultTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	local ids_tbl = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			local HasAvailableRewards = pd.HasAvailableRewards and 1 or 0
			local RIO_Score = pd.RIO_Score or 0
			local reward1 = E.COLOR_GRAY.."-|r"
			local reward2 = E.COLOR_GRAY.."-|r"
			local reward3 = E.COLOR_GRAY.."-|r"
			-- Фильтр пустоты
			local hasData = (HasAvailableRewards > 0)
			for j = 1, #E.Enum_Activities_table do
				local ID = E.Enum_Activities_table[j]
				table.insert(ids_tbl, ID)
				local vaultData = cm.GreatVault and cm.GreatVault[ID]
				local rewards = vaultData and vaultData.rewards or {}
				local activities = C_WeeklyRewards.GetActivities(ID)
				local max = activities and activities[3] and activities[3].threshold or 0
				local vaultMin = vaultData and vaultData.min or 0
				if rewards[1] then
					hasData = true
					reward1 = E.COLOR_GREEN..rewards[1].."|r"
				end
				if rewards[2] then
					hasData = true
					reward2 = E.COLOR_GREEN..rewards[2].."|r"
				end
				if rewards[3] then
					hasData = true
					reward3 = E.COLOR_GREEN..rewards[3].."|r"
				end
			end
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = HasAvailableRewards > 0 and E.COLOR_BLUE..">"..REWARD.."<|r" or ""
				local row3Text = reward1
				local row4Text = reward2
				local row5Text = reward3
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = HasAvailableRewards,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
						row5Text = row5Text,
						ids_tbl = ids_tbl,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = d.row2Text
		d.row[3] = d.row3Text
		d.row[4] = d.row4Text
		d.row[5] = d.row5Text
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"",
			"",
			E.name_activities[ids_tbl[1]],
			E.name_activities[ids_tbl[2]],
			E.name_activities[ids_tbl[3]],
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_ReputationsTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	if not E.OctoTable_Reputations_Paragon_Data_NEW[id] then return end
	local questID = E.OctoTable_Reputations_Paragon_Data_NEW[id].paragonQuest
	-- local itemID = E.OctoTable_Reputations_Paragon_Data_NEW[id].itemCache
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local IsAccountWideReputation = C_Reputation.IsAccountWideReputation(id)
	if IsAccountWideReputation then
		local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		local DONEPERS = cm.ListOfParagonQuests and cm.ListOfParagonQuests[questID] and 1 or 0
		local hasData = (DONEPERS > 0)
		if hasData then
			local leftText = pd.classColorHex..pd.Name.."|r"
			local row = { leftText }
			table.insert(characterData, {
					row = row,
					name = leftText,
					sortValue = 1,
					row2Text = E.COLOR_PURPLE..">"..QUEST_WATCH_QUEST_READY.."<|r",
			})
		end
	else
		local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
				local pd = CharInfo.PlayerData
				local cm = CharInfo.MASLENGO
				local DONEPERS = cm.ListOfParagonQuests and cm.ListOfParagonQuests[questID] and 1 or 0
				-- Фильтр пустоты
				local hasData = (DONEPERS > 0)
				if hasData then
					local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
					local row = { leftText }
					-- local row2Text = DONEPERS > 0 and E.COLOR_BLUE..">"..REWARD.."<|r" or ""
					local row2Text = DONEPERS > 0 and E.COLOR_PURPLE..">"..QUEST_WATCH_QUEST_READY.."<|r" or ""
					table.insert(characterData, {
							row = row,
							name = pd.Name,
							sortValue = DONEPERS,
							row2Text = row2Text,
					})
				end
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	table.sort(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	--------------------------------------------------------
	-- 3. Градиент
	--------------------------------------------------------
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	--------------------------------------------------------
	-- 4. Вывод персонажей
	--------------------------------------------------------
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = d.row2Text
		table.insert(tooltip, d.row)
	end
	--------------------------------------------------------
	-- 5. Итоги сверху
	--------------------------------------------------------
	if #characterData > 1 then
		local heade1 = {
			"имя",
			"",
			"итемнейм",
			"квест",
		}
		table.insert(tooltip, 1, heade1)
	end
	--------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_ItemsTooltipLeft(visiblePlayers, id)
	local tooltip = {}
	--------------------------------------------------------
	-- 1. Сбор данных
	--------------------------------------------------------
	local characterData = {}
	local total = 0
	local total_BAGS = 0
	local total_BANK = 0
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if (not ShowOnlyCurrentRegion) or CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			local itemCount_Bags = cm.Items.Bags[id] or 0
			local itemCount_Bank = cm.Items.Bank[id] or 0
			-- Фильтр пустоты
			local hasData = itemCount_Bags > 0 or itemCount_Bank > 0
			if hasData then
				local leftText = E.func_GetLeftTextForTooltip(GUID, CharInfo, visiblePlayers)
				local row = { leftText }
				local row2Text = itemCount_Bags > 0 and E.func_CompactFormatNumber(itemCount_Bags) or ""
				local row3Text = itemCount_Bank > 0 and E.COLOR_GRAY.."+"..E.func_CompactFormatNumber(itemCount_Bank).."|r" or ""
				total = total + itemCount_Bags + itemCount_Bank
				total_BAGS = total_BAGS + itemCount_Bags
				total_BANK = total_BANK + itemCount_Bank
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue1 = itemCount_Bags,
						sortValue2 = itemCount_Bank,
						row2Text = row2Text,
						row3Text = row3Text,
						-- total_BAGS = total_BAGS,
						-- total_BANK = total_BANK,
				})
			end
		end
	end
	--------------------------------------------------------
	-- 2. Сортировка
	--------------------------------------------------------
	if #characterData > 0 then
		table.sort(characterData, function(a, b)
				if a.sortValue1 ~= b.sortValue1 then
					return a.sortValue1 > b.sortValue1
				end
				return a.name < b.name
		end)
		--------------------------------------------------------
		-- 3. Градиент
		--------------------------------------------------------
		-- local minValue1, maxValue1 = E.func_GetMinMaxValue(characterData, "sortValue1")
		-- local minValue2, maxValue2 = E.func_GetMinMaxValue(characterData, "sortValue2")
		--------------------------------------------------------
		-- 4. Вывод персонажей
		--------------------------------------------------------
		for _, d in ipairs(characterData) do
			-- local color1 = E.func_GetColorGradient(d.sortValue1, minValue1, maxValue1)
			-- local color2 = E.func_GetColorGradient(d.sortValue2, minValue2, maxValue2)
			-- d.row[2] = color1..d.row2Text.."|r"
			-- d.row[3] = color2..d.row3Text.."|r"
			d.row[2] = {d.row2Text, "RIGHT"}
			d.row[3] = {d.row3Text, "LEFT"}
			table.insert(tooltip, d.row)
		end
		--------------------------------------------------------
		-- 5. Итоги сверху
		--------------------------------------------------------
		if #characterData == 1 and total_BANK ~= 0 then
			local header = {
				"",
				{BAG_NAME_BACKPACK, "RIGHT"},
				{E.COLOR_GRAY..BANK.."|r", "LEFT"},
			}
			table.insert(tooltip, 1, header)
		elseif #characterData > 1 then
			if total_BANK ~= 0 then
				local header = {
					"",
					"",
					TOTAL..": "..E.func_CompactFormatNumber(total),
				}
				table.insert(tooltip, 1, header)
				local header = {
					"",
					{BAG_NAME_BACKPACK, "RIGHT"},
					{E.COLOR_GRAY..BANK.."|r", "LEFT"},
				}
				table.insert(tooltip, 2, header)
			else
				local header = {
					"",
					TOTAL..": "..E.func_CompactFormatNumber(total),
					"",
				}
				table.insert(tooltip, 1, header)
			end
		end
		--------------------------------------------------------
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_KeyTooltip_LEFT(SettingsType)
	if not SettingsType then return end
	local tooltip = {}
	local dataType, id = ("#"):split(SettingsType)
	-- local CharInfo = Octo_ToDo_DB_Levels[GUID]
	----------------------------------------------------------------
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
		id = tonumber(id)
	end
	----------------------------------------------------------------
	local sortedPlayersTBL = E.func_SortCharacters()
	local visiblePlayers = {}
	for _, charInfo in ipairs(sortedPlayersTBL) do
		visiblePlayers[charInfo.PlayerData.GUID] = true
	end
	if dataType == "UniversalQuests" then
		local reset = id:match("_([^_]+)$")
		tooltip[#tooltip+1] = {reset}
	elseif dataType == "Currencies" and id == 1822 then
		tooltip = E.func_CovenantCurrencyTooltip(1822, visiblePlayers, 1) -- Для renown (typeSL = 1)
	elseif dataType == "Currencies" and id == 1813 then
		tooltip = E.func_CovenantCurrencyTooltip(1813, visiblePlayers, 2) -- Для анимы (typeSL = 2)
	elseif SettingsType == "Additionally#Professions" then
		tooltip = E.func_ProfessionsTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#ItemLevel" then
		tooltip = E.func_ItemLevelTooltipLeft(visiblePlayers)
	elseif dataType == "Currencies" then
		tooltip = E.func_CurrenciesTooltipLeft(visiblePlayers, id)
	elseif SettingsType == "Additionally#Money" then
		tooltip = E.func_MoneyTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#WasOnline" then
		tooltip = E.func_WasOnlineTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#CurrentKey" then
		tooltip = E.func_CurrentKeyTooltipLeft(visiblePlayers)
	elseif SettingsType == "Additionally#GreatVault" then
		tooltip = E.func_GreatVaultTooltipLeft(visiblePlayers)
	elseif dataType == "Reputations" then
		tooltip = E.func_ReputationsTooltipLeft(visiblePlayers, id)
	elseif dataType == "Items" then
		tooltip = E.func_ItemsTooltipLeft(visiblePlayers, id)
	end
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------