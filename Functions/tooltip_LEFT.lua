local GlobalAddonName, E =  ...
local L = E.L
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
	local pd = CharInfo.PlayerData
	local isVisible = visible_GUID[GUID]
	local CustomColor
	if not isVisible then
		CustomColor = E.COLOR_GRAY
	end
	local CharName = E.func_CharInfo_NickName(CharInfo, false, true, CustomColor, true)
	local curServerShort = pd.curServerShort ~= E.curServerShort and "-" .. E.func_CharInfo_Server(CharInfo, nil, true, CustomColor) or ""
	local specId = pd.specId or 72 -- FURY WARRIOR
	local specIcon = E.func_GetIcon("specialization", specId)
	local leftText =
	E.func_texturefromIcon(specIcon) ..
	CharName ..
	curServerShort
	return leftText
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_CovenantCurrencyTooltip(tbl, visible_GUID, id, typeSL)
	local tooltip = {}
	local isRenown = (typeSL == 1)
	local characterData = {}
	local grandTotal = 0
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local SL_covenantID = pd.SL_covenantID
		if SL_covenantID then
			local values = {}
			local charTotal = 0
			local activeValue = 0
			for covenantID, covenant in next, (E.OctoTable_Covenant) do
				local key = covenant.prefix  ..  (isRenown and "_Renown" or "_Anima")
				local value = pd[key] or 0
				values[covenantID] = value
				charTotal = charTotal + value
				if covenantID == SL_covenantID then
					activeValue = value
				end
			end
			local hasData
			if isRenown then
				hasData = activeValue > 0
			else
				hasData = charTotal > 0 or (pd.SL_Possible_Anima or 0) > 0
			end
			if hasData then
				if not isRenown then
					grandTotal = grandTotal + charTotal
				end
				local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
				local row = { leftText }
				for covenantID, covenant in next, (E.OctoTable_Covenant) do
					local value = values[covenantID]
					if value > 0 then
						local c = covenantID == SL_covenantID and E.func_DB_COV_COLOR(covenantID) or E.COLOR_GRAY
						row[covenantID + 1] = c  ..  E.func_CompactFormatNumber(value)  ..  "|r"
					else
						row[covenantID + 1] = "-"
					end
				end
				local sortValue
				local totalAnimaText
				local SL_Possible_Anima
				if isRenown then
					sortValue = activeValue
				else
					sortValue = charTotal
					totalAnimaText = charTotal > 0 and E.func_CompactFormatNumber(charTotal) or "-"
					if pd.SL_Possible_Anima and pd.SL_Possible_Anima > 0 then
						SL_Possible_Anima = E.COLOR_BLUE  ..  " +"  ..  E.func_CompactFormatNumber(pd.SL_Possible_Anima)  ..  "|r"
					end
				end
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = sortValue,
						SL_Possible_Anima = SL_Possible_Anima or " ",
						totalAnimaText = totalAnimaText,
				})
			end
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		local minValue, maxValue
		if not isRenown then
			minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		end
		for _, d in ipairs(characterData) do
			if not isRenown then
				local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
				d.row[6] = d.SL_Possible_Anima
				d.row[7] = color  ..  d.totalAnimaText  ..  "|r"
			end
			table.insert(tooltip, d.row)
		end
		local header = { "" }
		for _, covenant in next, (E.OctoTable_Covenant) do
			header[#header + 1] = E.func_texturefromIcon(covenant.icon)
		end
		header[#header + 1] = ""
		if not isRenown then
			header[#header + 1] = E.func_CompactFormatNumber(grandTotal)
		end
		table.insert(tooltip, 1, header)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_CatalogedResearchTooltip(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	local grandTotal = 0
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		local quantity = cm.Currency[id] and cm.Currency[id].quantity or 0
		local possible = pd.SL_Possible_CatalogedResearch or 0
		local hasData = quantity > 0 or possible > 0
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
			local row = { leftText }
			row[2] = possible > 0 and (E.COLOR_PURPLE .. " +" .. E.func_CompactFormatNumber(possible) .. "|r") or " "
			row[3] = quantity  -- будет заменено ниже после сортировки
			grandTotal = grandTotal + quantity
			table.insert(characterData, {
				row = row,
				name = pd.Name,
				sortValue = quantity,
				quantity = quantity,
			})
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
		end)
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		for _, d in ipairs(characterData) do
			if d.quantity > 0 then
				local color = E.func_GetColorGradient(d.quantity, minValue, maxValue)
				d.row[3] = color .. E.func_CompactFormatNumber(d.quantity) .. "|r"
			else
				d.row[3] = E.COLOR_GRAY .. "-|r"
			end
			table.insert(tooltip, d.row)
		end
		if #characterData > 1 then
			local header = {
				"",
				"",
				L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(grandTotal),
			}
			table.insert(tooltip, 1, header)
		end
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ItemLevelTooltipLeft(tbl, visible_GUID)
	local tooltip = {}
	local characterData = {}
	local avgILVL = 0
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local avgItemLevelEquipped = pd.avgItemLevelEquipped or 0
		local avgItemLevel = pd.avgItemLevel or 0
		local avgItemLevelPvp = pd.avgItemLevelPvp or 0
		local hasData = avgItemLevelEquipped > 0 or avgItemLevel > 0 or avgItemLevelPvp > 0
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
			local row = { leftText }
			local row2Text = E.func_CharInfo_Durability(CharInfo, true)
			local row3Text = E.func_CharInfo_ItemLevel(CharInfo)
			avgILVL = avgILVL + pd.avgItemLevel
			table.insert(characterData, {
					row = row,
					name = pd.Name,
					sortValue = avgItemLevelEquipped,
					row2Text = row2Text,
					row3Text = row3Text,
			})
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		for _, d in ipairs(characterData) do
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = {color .. d.row2Text .. "|r", "RIGHT"}
			d.row[3] = color .. d.row3Text .. "|r"
			table.insert(tooltip, d.row)
		end
		if #characterData > 1 then
			local header = {
				"",
				"",
				"avg" .. ": " .. E.func_CompactFormatNumber(avgILVL/#characterData),
			}
			table.insert(tooltip, 1, header)
		end
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ProfessionsTooltipLeft(tbl, visible_GUID)
	local tooltip = {}
	local characterData = {}
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local cmP = CharInfo.MASLENGO.professions
		local hasData = cmP[1] and cmP[1].skillLine
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
			local row = { leftText }
			local prof = {}
			for i = 1, 2 do
				prof[i] = prof[i] or {}
				prof[i].Icon = ""
				prof[i].Text = ""
				if cmP[i] and cmP[i].skillLevel and cmP[i].maxSkillLevel then
					prof[i].Icon = E.func_GetIcon("profession", cmP[i].skillLine)
					prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel) .. "/" .. E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
					if cmP[i].skillModifier then
						prof[i].Text = E.func_CompactFormatNumber(cmP[i].skillLevel) .. E.COLOR_GREEN .. "+" .. E.func_CompactFormatNumber(cmP[i].skillModifier) .. "|r" .. "/" .. E.func_CompactFormatNumber(cmP[i].maxSkillLevel)
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
	E.func_SortRecords(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			elseif a.sortValue2 ~= b.sortValue2 then
				return a.sortValue2 > b.sortValue2
			end
			return a.name < b.name
	end)
	for _, d in ipairs(characterData) do
		d.row[2] = {d.prof1Text .. E.func_texturefromIcon(d.prof1Icon), "RIGHT"}
		d.row[3] = {d.prof2Text .. E.func_texturefromIcon(d.prof2Icon), "RIGHT"}
		table.insert(tooltip, d.row)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_CurrenciesTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	local total = 0
	local IsAccountWideCurrency = E.func_IsAccountWideCurrency(id) -- ACCOUNT_LEVEL_CURRENCY
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		local curquantity = cm.Currency[id] and cm.Currency[id].quantity or 0
		local curmaxQuantity = cm.Currency[id] and cm.Currency[id].maxQuantity or 0
		local hasData = curquantity > 0
		if hasData then
			if IsAccountWideCurrency and GUID == E.curGUID then
				tooltip[#tooltip+1] = {E.COLOR_CYAN .. L["ACCOUNT_LEVEL_CURRENCY"] .. "|r"}
				tooltip[#tooltip+1] = {L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(curquantity)}
				return tooltip
			else
				local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
				local row = { leftText }
				local row2Text = E.func_CompactFormatNumber(curquantity)
				if curmaxQuantity > 0 then
					row2Text = row2Text .. "/" .. E.func_CompactFormatNumber(curmaxQuantity)
				end
				total = total + curquantity
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = curquantity,
						row2Text = row2Text,
				})
			end
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		for _, d in ipairs(characterData) do
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = color .. d.row2Text .. "|r"
			table.insert(tooltip, d.row)
		end
		if #characterData > 1 then
			local header = {
				"",
				L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(total),
			}
			table.insert(tooltip, 1, header)
		end
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_MoneyTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	local total = 0

	for GUID, CharInfo in next, (tbl) do
		-- дополнительные фильтры, специфичные для Money
		local pd = CharInfo.PlayerData
		local curMoney = pd.Money or 0
		local hasData = curMoney > 0
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
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
	E.func_SortRecords(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
	end)
	local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
	if #characterData > 0 then
		if C_WowTokenPublic and C_WowTokenPublic.GetCurrentMarketPrice then
			C_WowTokenPublic.UpdateMarketPrice()
			local price = C_WowTokenPublic.GetCurrentMarketPrice()
			if price and price > 0 then
				table.insert(tooltip, {
						L["TOKEN_FILTER_LABEL"],
						E.func_FormatMoney(C_WowTokenPublic.GetCurrentMarketPrice())
				})
			end
		end
		if C_Bank and C_Bank.FetchDepositedMoney then
			local accountMoney = C_Bank.FetchDepositedMoney(Enum.BankType.Account)
			if accountMoney and accountMoney > 0 then
				table.insert(tooltip, {
					L["ACCOUNT_BANK_PANEL_TITLE"],
					E.func_FormatMoney(accountMoney)
				})
			end
		end
		table.insert(tooltip, {
				L["TOTAL"],
				E.func_FormatMoney(total)
		})
	end
	for _, d in ipairs(characterData) do
		local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
		d.row[2] = color .. d.row2Text .. "|r"
		table.insert(tooltip, d.row)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_LastOnlineTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	local total = 0
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local curTime = pd.realTotalTime or 0
		local hasData = curTime > 0
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
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
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		local minValue, maxValue = E.func_GetMinMaxValue(characterData, "sortValue")
		for _, d in ipairs(characterData) do
			local color = E.func_GetColorGradient(d.sortValue, minValue, maxValue)
			d.row[2] = color .. d.row2Text .. "|r"
			table.insert(tooltip, d.row)
		end
		local header1 = {
			L["TOTAL"],
			E.func_SecondsToClock(total)
		}
		table.insert(tooltip, 1, header1)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_CurrentKeyTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local seasonData = pd.MythicPlus and pd.MythicPlus[E.MythicPlus_seasonID]
		if seasonData then
			local OwnedKeystoneLevel = pd.OwnedKeystoneLevel or 0
			local OwnedKeystoneChallengeMapID = pd.OwnedKeystoneChallengeMapID or 0
			local rioColor = E.func_RioColor(seasonData.RIO_Score)
			local RIO_Score = seasonData and tonumber(seasonData.RIO_Score) or 0
			local RIO_weeklyBest = seasonData and tonumber(seasonData.RIO_weeklyBest) or E.COLOR_GRAY .. "-|r"
			local keyName = E.func_formatMplusKey(pd.OwnedKeystoneLevel, pd.OwnedKeystoneChallengeMapID, true, false)
			local hasData = (RIO_Score > 0) or (OwnedKeystoneLevel > 0 and OwnedKeystoneChallengeMapID > 0)

			if hasData then
				local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
				local row = { leftText }
				local row2Text = keyName
				local row3Text = RIO_weeklyBest or 0
				local row4Text = RIO_Score or 0
				table.insert(characterData, {
						row = row,
						name = pd.Name,
						sortValue = RIO_Score,
						row2Text = row2Text,
						row3Text = row3Text,
						row4Text = row4Text,
						rioColor = rioColor,
				})
			end
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue ~= b.sortValue then
					return a.sortValue > b.sortValue
				end
				return a.name < b.name
		end)
		for _, d in ipairs(characterData) do
			local rioColor = d.rioColor
			d.row[2] = {d.row2Text, "LEFT"}
			d.row[3] = d.row3Text
			d.row[4] = rioColor .. d.row4Text .. "|r"
			table.insert(tooltip, d.row)
		end
		local header1 = {
			"",
			"",
			L["BEST"],
			L["RATING"], -- "MythicPlus",
		}
		table.insert(tooltip, 1, header1)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_GreatVaultTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}

	-- header активности
	local header_ids_tbl = {}
	for j = 1, #E.Enum_Activities_table do
		header_ids_tbl[j] = E.Enum_Activities_table[j]
	end

	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.PlayerData
		local HasAvailableRewards = pd.HasAvailableRewards and 1 or 0
		local hasData = (HasAvailableRewards > 0)

		local progress = {}
		local rewards = {}

		for j = 1, #E.Enum_Activities_table do
			local ID = E.Enum_Activities_table[j]

			local vaultData = cm.GreatVault and cm.GreatVault[ID]
			local rewardData = vaultData and vaultData.rewards or {}
			local activities = E.func_GetActivities(ID)

			local max = activities and activities[3] and activities[3].threshold or 0
			local vaultMin = vaultData and vaultData.min or 0

			if rewardData[1] or rewardData[2] or rewardData[3] then
				hasData = true
			end

			-- прогресс
			if max == 0 then
				progress[j] = E.COLOR_GRAY  ..  "-|r"
			else
				local color
				if vaultMin >= max then
					color = E.COLOR_GREEN
				elseif vaultMin > 0 then
					color = E.COLOR_YELLOW
				else
					color = E.COLOR_GRAY
				end

				progress[j] = color  ..  vaultMin  ..  "/"  ..  max  ..  "|r"
			end

			-- 3 награды отдельно
			rewards[j] = {
				rewardData[1] and E.COLOR_WHITE  ..  rewardData[1]  ..  "|r" or E.COLOR_GRAY  ..  "-|r",
				rewardData[2] and E.COLOR_WHITE  ..  rewardData[2]  ..  "|r" or E.COLOR_GRAY  ..  "-|r",
				rewardData[3] and E.COLOR_WHITE  ..  rewardData[3]  ..  "|r" or E.COLOR_GRAY  ..  "-|r",
			}
		end

		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)

			table.insert(characterData, {
				name = pd.Name,
				sortValue = HasAvailableRewards,
				row = {
					leftText,
					HasAvailableRewards > 0 and E.COLOR_BLUE .. ">" .. L["REWARD"] .. "<|r" or "",

					-- activity 1
					progress[1],

					-- activity 2
					progress[2],

					-- activity 3
					progress[3],
				}
			})
		end
	end

	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
		end)

		for _, d in ipairs(characterData) do
			table.insert(tooltip, d.row)
		end

		local header = {
			"",
			"",

			E.name_activities[header_ids_tbl[1]],
			E.name_activities[header_ids_tbl[2]],
			E.name_activities[header_ids_tbl[3]],
		}

		table.insert(tooltip, 1, header)
	end

	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_GreatVaultSingleTooltipLeft(tbl, visible_GUID, index)
	local tooltip = {}
	local characterData = {}

	local ID = E.Enum_Activities_table[index]

	for GUID, CharInfo in next, (tbl) do
		local cm = CharInfo.MASLENGO
		local vaultData = cm.GreatVault and cm.GreatVault[ID]
		local rewardData = vaultData and vaultData.rewards or {}
		local activities = E.func_GetActivities(ID)

		local max = activities and activities[3] and activities[3].threshold or 0
		local vaultMin = vaultData and vaultData.min or 0

		-- прогресс
		local progressText
		if max == 0 then
			progressText = E.COLOR_GRAY .. "-|r"
		else
			local color
			if vaultMin >= max then
				color = E.COLOR_GREEN
			elseif vaultMin > 0 then
				color = E.COLOR_YELLOW
			else
				color = E.COLOR_GRAY
			end
			progressText = color .. vaultMin .. "/" .. max .. "|r"
		end

		-- проверка есть ли данные
		local hasData = rewardData[1] or rewardData[2] or rewardData[3]

		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
			local pd = CharInfo.PlayerData

			table.insert(characterData, {
				row = {leftText, progressText,
					rewardData[1] and E.COLOR_WHITE .. rewardData[1] .. "|r" or E.COLOR_GRAY .. "-|r",
					rewardData[2] and E.COLOR_WHITE .. rewardData[2] .. "|r" or E.COLOR_GRAY .. "-|r",
					rewardData[3] and E.COLOR_WHITE .. rewardData[3] .. "|r" or E.COLOR_GRAY .. "-|r",
				},
				name = pd.Name,
				sortValue = vaultMin,
			})
		end
	end

	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
			if a.sortValue ~= b.sortValue then
				return a.sortValue > b.sortValue
			end
			return a.name < b.name
		end)

		for _, d in ipairs(characterData) do
			table.insert(tooltip, d.row)
		end
	end

	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ReputationsTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local paragonQuest = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].paragonQuest or false
	if not paragonQuest then return end
	local characterData = {}
	local IsAccountWideReputation = E.func_IsAccountWideReputation(id)

	if IsAccountWideReputation then

		local currentHasData = false
		local pd = E.pd
		local cm = E.cm
		local DONEPERS = cm.ListOfParagonQuests and cm.ListOfParagonQuests[paragonQuest] and 1 or 0
		currentHasData = (DONEPERS > 0)
		if currentHasData then
			local leftText = pd.classColorHex .. pd.Name .. "|r"
			local row = { leftText }
			table.insert(characterData, {
				row = row,
				name = leftText,
				sortValue = pd.Name,
				row2Text = E.COLOR_PURPLE .. ">" .. L["QUEST_WATCH_QUEST_READY"] .. "<|r",
			})
		end

		-- Если текущий не выполнил квест, ищем по другим персонажам
		if not currentHasData then
			for GUID, CharInfo in next, (tbl) do
				if GUID ~= E.curGUID then  -- исключаем текущего, его уже проверили
					local pd = CharInfo.PlayerData
					local cm = CharInfo.MASLENGO
					local DONEPERS = cm.ListOfParagonQuests and cm.ListOfParagonQuests[paragonQuest] and 1 or 0
					local hasData = (DONEPERS > 0)
					if hasData then
						local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
						local row = { leftText }
						local row2Text = E.COLOR_PURPLE .. ">" .. L["QUEST_WATCH_QUEST_READY"] .. "<|r"
						table.insert(characterData, {
							row = row,
							name = pd.Name,
							sortValue = pd.Name,
							row2Text = row2Text,
						})
					end
				end
			end
		end
	else
		-- Оригинальная ветка для не-account-wide репутаций
		for GUID, CharInfo in next, (tbl) do
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			local DONEPERS = cm.ListOfParagonQuests and cm.ListOfParagonQuests[paragonQuest] and 1 or 0
			local hasData = (DONEPERS > 0)
			if hasData then
				local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
				local row = { leftText }
				local row2Text = DONEPERS > 0 and E.COLOR_PURPLE .. ">" .. L["QUEST_WATCH_QUEST_READY"] .. "<|r" or ""
				table.insert(characterData, {
					row = row,
					name = pd.Name,
					sortValue = pd.Name,
					row2Text = row2Text,
				})
			end
		end
	end

	-- Сортировка и финальная сборка tooltip
	E.func_SortRecords(characterData, function(a, b)
		if a.sortValue ~= b.sortValue then
			return a.sortValue > b.sortValue
		end
		return a.name < b.name
	end)
	for _, d in ipairs(characterData) do
		d.row[2] = d.row2Text
		table.insert(tooltip, d.row)
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ItemsTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	local characterData = {}
	local total = 0
	local total_BAGS = 0
	local total_BANK = 0
	local total_AccountBank = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank[id] or 0
	for GUID, CharInfo in next, (tbl) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		local itemCount_Bags = cm.Items.Bags[id] or 0
		local itemCount_Bank = cm.Items.Bank[id] or 0
		local hasData = itemCount_Bags > 0 or itemCount_Bank > 0
		if hasData then
			local leftText = func_GetLeftTextForTooltip(GUID, CharInfo, visible_GUID)
			local row = { leftText }
			local row2Text = itemCount_Bags > 0 and E.func_CompactFormatNumber(itemCount_Bags) or ""
			local row3Text = itemCount_Bank > 0 and E.COLOR_GRAY .. "+" .. E.func_CompactFormatNumber(itemCount_Bank) .. "|r" or ""
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
			})
		end
	end
	if #characterData > 0 then
		E.func_SortRecords(characterData, function(a, b)
				if a.sortValue1 ~= b.sortValue1 then
					return a.sortValue1 > b.sortValue1
				end
				return a.name < b.name
		end)
		for _, d in ipairs(characterData) do
			d.row[2] = {d.row2Text, "RIGHT"}
			d.row[3] = {d.row3Text, "LEFT"}
			table.insert(tooltip, d.row)
		end
		if #characterData == 1 and total_BANK ~= 0 then
			local header = {
				"",
				{L["BAG_NAME_BACKPACK"], "RIGHT"},
				{E.COLOR_GRAY .. L["BANK"] .. "|r", "LEFT"},
			}
			table.insert(tooltip, 1, header)
		elseif #characterData > 1 then
			if total_BANK ~= 0 then
				local header = {
					"",
					"",
					L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(total),
				}
				table.insert(tooltip, 1, header)
				local header = {
					"",
					{L["BAG_NAME_BACKPACK"], "RIGHT"},
					{E.COLOR_GRAY .. L["BANK"] .. "|r", "LEFT"},
				}
				table.insert(tooltip, 2, header)
			else
				local header = {
					"",
					L["TOTAL"] .. ": " .. E.func_CompactFormatNumber(total),
					"",
				}
				table.insert(tooltip, 1, header)
			end
		end
	end
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_UniversalQuestsTooltipLeft(tbl, visible_GUID, id)
	local tooltip = {}
	----------------------------------------------------------------
	for _, data in next, (E.ALL_UniversalQuests) do
		if data.reset then
			local questKey = data.questKey
			local reset = data.reset
			if id == questKey then
				----------------
				local  result = E.RESET_INFO[reset].string
				if data.isAccount then
					result = E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE) .. result  ..  " "  ..  L["REPUTATION_STATUS_BAR_LABEL_ACCOUNT_WIDE"]
				end
				tooltip[#tooltip+1] = {result}
				----------------
				local rewards = data.rewards or 0
				if rewards ~= 0 then
					tooltip[#tooltip+1] = {" "}
					tooltip[#tooltip+1] = {L["REWARDS"] .. ": ", " "}
					for _, rews in next,(rewards) do
						local rewID = rews.rewID
						local rewTYPE = rews.rewTYPE
						if rewID and rewTYPE then
							local rewSIZE = rews.rewSIZE or ""
							local addText = rews.addText or ""
							if rewID then
								tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetIcon(rewTYPE, rewID)) .. E.func_GetName(rewTYPE, rewID), {addText, "LEFT"}, rewSIZE}
							end
						end
					end
				end
			end
		end
	end
	----------------------------------------------------------------
	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_KeyTooltip_LEFT(SettingsType)
	if not SettingsType then return end
	local tooltip = {}
	local dataType, old_id = ("#"):split(SettingsType)
	local id = E.func_SetType(old_id, dataType)

	-- Формируем единую таблицу персонажей с учётом фильтров
	local tbl = {}
	local CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = E.func_CONFIG_SHOW_ONLY_CURRENT_BATTLETAG()
	local CONFIG_SHOW_ONLY_CURRENT_REGION = E.func_CONFIG_SHOW_ONLY_CURRENT_REGION()
	local CONFIG_SORTING_CUSTOM = E.func_CONFIG_SORTING_CUSTOM()

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if CONFIG_SORTING_CUSTOM then
			tbl[GUID] = CharInfo
		else
			if (not CONFIG_SHOW_ONLY_CURRENT_BATTLETAG) or (pd.BattleTag == E.BattleTag) then
				if (not CONFIG_SHOW_ONLY_CURRENT_REGION) or (pd.REGION_NAME == E.CURRENT_REGION_NAME) then
					tbl[GUID] = CharInfo
				end
			end
		end
	end

	local visible, hidden, filtered, visible_GUID, hidden_GUID, filtered_GUID = E.func_SortCharacters()

	if dataType == "UniversalQuests" then
		tooltip = func_UniversalQuestsTooltipLeft(tbl, visible_GUID, id)
	elseif dataType == "Currencies" and id == 1822 then -- Renown
		tooltip = func_CovenantCurrencyTooltip(tbl, visible_GUID, 1822, 1)
	elseif dataType == "Currencies" and id == 1813 then -- Reservoir Anima
		tooltip = func_CovenantCurrencyTooltip(tbl, visible_GUID, 1813, 2)
	elseif dataType == "Currencies" and id == 1931 then -- Cataloged Research
		tooltip = func_CatalogedResearchTooltip(tbl, visible_GUID, 1931)
	elseif SettingsType == "AdditionallyBOTTOM#Professions" then
		tooltip = func_ProfessionsTooltipLeft(tbl, visible_GUID)
	elseif SettingsType == "AdditionallyBOTTOM#ItemLevel" then
		tooltip = func_ItemLevelTooltipLeft(tbl, visible_GUID)
	elseif dataType == "Currencies" then
		tooltip = func_CurrenciesTooltipLeft(tbl, visible_GUID, id)
	elseif SettingsType == "AdditionallyBOTTOM#Money" then
		tooltip = func_MoneyTooltipLeft(tbl, visible_GUID)
	elseif SettingsType == "AdditionallyBOTTOM#LastOnline" then
		tooltip = func_LastOnlineTooltipLeft(tbl, visible_GUID)
	elseif SettingsType == "AdditionallyTOP#GreatVault" then
		tooltip = func_GreatVaultTooltipLeft(tbl, visible_GUID)
	elseif SettingsType == "AdditionallyTOP#CurrentKey" then
		tooltip = func_CurrentKeyTooltipLeft(tbl, visible_GUID)
	elseif dataType == "Reputations" then
		tooltip = func_ReputationsTooltipLeft(tbl, visible_GUID, id)
	elseif dataType == "Items" then
		tooltip = func_ItemsTooltipLeft(tbl, visible_GUID, id)
	end

	for i = 1, 3 do
		if SettingsType == "AdditionallyTOP#GreatVault" .. i then
			tooltip = func_GreatVaultSingleTooltipLeft(tbl, visible_GUID, i)
			break
		end
	end

	return tooltip
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------