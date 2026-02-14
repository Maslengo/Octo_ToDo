local GlobalAddonName, E = ...



----------------------------------------------------------------
local function Collect_Currencies()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local currencyCache = {}
	for currencyID in next, (E.ALL_Currencies) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID)



		local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if not data then
			collectMASLENGO.Currency[currencyID] = nil
		else
			collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
			local quantity = data.quantity
			local maxQuantity = data.maxQuantity
			local totalEarned = data.totalEarned
			local maxWeeklyQuantity = data.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
			-- Получаем кэш данных аккаунтных валют
			if not currencyCache[currencyID] then
				currencyCache[currencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						CharInfo.MASLENGO.Currency[currencyID] = CharInfo.MASLENGO.Currency[currencyID] or {}
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end
			if not isAccountWideCurrency then
				-- Только для текущего персонажа
				local charCurrency = collectMASLENGO.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			else
				-- Валюта аккаунтная, нужно всем персонажам сохранить одни и те же значения
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						local shared = CharInfo.MASLENGO.Currency[currencyID] or {}
						CharInfo.MASLENGO.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
local function Collect_Currencies_Account()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	local currencyCache = {}
	for currencyID in next, (E.ALL_Currencies) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID)
		local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if not data then
			collectMASLENGO.Currency[currencyID] = nil
		else
			collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
			local quantity = data.quantity
			local maxQuantity = data.maxQuantity
			local totalEarned = data.totalEarned
			local maxWeeklyQuantity = data.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
			-- Получаем кэш данных аккаунтных валют
			if not currencyCache[currencyID] then
				currencyCache[currencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						CharInfo.MASLENGO.Currency[currencyID] = CharInfo.MASLENGO.Currency[currencyID] or {}
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end
			if not isAccountWideCurrency then
				-- Только для текущего персонажа
				local charCurrency = collectMASLENGO.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			else
				-- Валюта аккаунтная, нужно всем персонажам сохранить одни и те же значения
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						local shared = CharInfo.MASLENGO.Currency[currencyID] or {}
						CharInfo.MASLENGO.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_TARGET_Currency(currencyID)
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	collectMASLENGO.Currency = collectMASLENGO.Currency or {}
	local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if not data then
		collectMASLENGO.Currency[currencyID] = nil
	end
	collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
	local charCurrency = collectMASLENGO.Currency[currencyID]
	local quantity = data.quantity
	local maxQuantity = data.maxQuantity
	local totalEarned = data.totalEarned
	local maxWeeklyQuantity = data.maxWeeklyQuantity
	local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
	E.func_SetOrNil(charCurrency, "quantity", quantity)
	E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
	E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
	E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
	E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
end
----------------------------------------------------------------
function E.Collect_Currencies()
	E.func_SpamBlock(Collect_Currencies, true)
end
function E.Collect_Currencies_Account()
	E.func_SpamBlock(Collect_Currencies_Account, true)
end

local result = {}



local function GetClassColorData(englishClass)
	if not englishClass then
		return "|cffffffff", "ffffff"
	end
	local c = C_ClassColor.GetClassColor(englishClass)
	if not c then
		return "|cffffffff", "ffffff"
	end
	local hex = c:GenerateHexColor()      -- AARRGGBB
	local rgb = hex:sub(3)                -- RRGGBB

	return rgb, "|cff" .. rgb
end



local function GetRaceIDByEnglishRace(englishRace)
	for raceID = 1, 100 do
		local info = C_CreatureInfo.GetRaceInfo(raceID)
		if info and info.clientFileString == englishRace then
			return raceID
		end
	end
end


-- ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED
function E.func_DEBUG_CURRENCY_TRANSFER()
	if not E.DEBUG then return end
	local foundNewCharacter = false
	-- local numTokenTypes = C_CurrencyInfo.GetCurrencyListSize();
	-- local currencyDataReady = not C_CurrencyInfo.DoesCurrentFilterRequireAccountCurrencyData() or C_CurrencyInfo.IsAccountCharacterCurrencyDataReady();
	-- if not currencyDataReady then
	-- 	return;
	-- end

	for currencyID in next, (E.ALL_Currencies) do
		local IsAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID)
		if IsAccountTransferableCurrency then
			local accountCurrencyData = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
			if accountCurrencyData then

				for q, v in ipairs(accountCurrencyData) do
					local characterGUID = v.characterGUID or "NONE"
					-- local characterName = v.characterName or "NONE"
					local fullCharacterName = v.fullCharacterName or "NONE-PIZDA"
					local quantity = v.quantity or 0
					-- local Server = fullCharacterName:gsub("-", "")
					-- local part1, Server = fullCharacterName:match("([^-]+)-([^-]+)")

					if characterGUID and not Octo_ToDo_DB_Levels[characterGUID] then
					-- if characterGUID then
						Octo_ToDo_DB_Levels[characterGUID] = Octo_ToDo_DB_Levels[characterGUID] or {}
						Octo_ToDo_DB_Levels[characterGUID].PlayerData = Octo_ToDo_DB_Levels[characterGUID].PlayerData or {}
						Octo_ToDo_DB_Levels[characterGUID].MASLENGO = Octo_ToDo_DB_Levels[characterGUID].MASLENGO or {}
						local pd = Octo_ToDo_DB_Levels[characterGUID].PlayerData
						local cm = Octo_ToDo_DB_Levels[characterGUID].MASLENGO
						local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName = GetPlayerInfoByGUID(characterGUID)
						if realmName == "" then
							realmName = E.func_GetPlayerRealm()
						end

						pd.Name = name -- characterName
						-- pd.curServer = Server
						pd.curServer = realmName
						pd.className = localizedClass
						pd.classFilename = englishClass
						pd.RaceLocal = localizedRace -- эльфийка крови
						pd.RaceEnglish = englishRace -- BloodElf
						pd.UnitSex = sex -- 3
						local classColor, classColorHex = GetClassColorData(englishClass)
						pd.classColor = classColor
						pd.classColorHex = classColorHex
						pd.GUID = characterGUID
						pd.realTotalTime = 0
						pd.RaceID = GetRaceIDByEnglishRace(englishRace)

						pd.curServerShort = E.func_GetRealmShortName(realmName)

						E.func_PrintMessage("ADD NEW CHARACTER: "..classColorHex..fullCharacterName.."|r")
						foundNewCharacter = true
						result[characterGUID] = fullCharacterName
					end
				end
			end
		end
	end
	if foundNewCharacter then
		E.WTF_func_CheckAll()
	end
	-- opde(result)
end