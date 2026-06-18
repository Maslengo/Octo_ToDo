local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
-- Вспомогательная функция проверки принадлежности персонажа к текущему аккаунту
function E.func_IsSameAccount(pd)
	return pd and pd.REGION_NAME == E.CURRENT_REGION_NAME and pd.BattleTag == E.BattleTag
end
----------------------------------------------------------------
local function Collect_Currencies()
	if not E.func_CanCollectData() then return end
	local currencyCache = {}
	for currencyID in next, (E.ALL_Currencies) do
		local info = E.func_GetCurrencyInfo(currencyID)
		if not info then
			E.cm.Currency[currencyID] = nil
		else
			local quantity = info.quantity
			local maxQuantity = info.maxQuantity
			local canEarnPerWeek = info.canEarnPerWeek
			local quantityEarnedThisWeek = info.quantityEarnedThisWeek
			local totalEarned = info.totalEarned
			local maxWeeklyQuantity = info.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = info.useTotalEarnedForMaxQty

			-- Кэш аккаунт-трансферабельных валют
			if not currencyCache[currencyID] then
				currencyCache[currencyID] = E.func_FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					local cm = CharInfo.MASLENGO
					if E.func_IsSameAccount(pd) and cm then
						cm.Currency = cm.Currency or {}
						cm.Currency[currencyID] = cm.Currency[currencyID] or {}
						E.func_SetOrNil(cm.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(cm.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end

			if E.func_IsAccountWideCurrency(currencyID) then
				-- Аккаунтная валюта: одинаковые значения всем персонажам той же учётки
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					local cm = CharInfo.MASLENGO
					if E.func_IsSameAccount(pd) and cm then
						cm.Currency = cm.Currency or {}
						local shared = cm.Currency[currencyID] or {}
						cm.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "canEarnPerWeek", canEarnPerWeek)
						E.func_SetOrNil(shared, "quantityEarnedThisWeek", quantityEarnedThisWeek)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			else
				-- Обычная валюта: только текущему
				E.cm.Currency = E.cm.Currency or {}
				E.cm.Currency[currencyID] = E.cm.Currency[currencyID] or {}
				local charCurrency = E.cm.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "canEarnPerWeek", canEarnPerWeek)
				E.func_SetOrNil(charCurrency, "quantityEarnedThisWeek", quantityEarnedThisWeek)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			end
		end
	end
end
----------------------------------------------------------------
local function Collect_Currencies_Account()
	if not E.cm then return end
	local currencyCache = {}
	for currencyID in next, (E.ALL_Currencies) do
		local info = E.func_GetCurrencyInfo(currencyID)
		if not info then
			E.cm.Currency[currencyID] = nil
		else
			local quantity = info.quantity
			local maxQuantity = info.maxQuantity
			local canEarnPerWeek = info.canEarnPerWeek
			local quantityEarnedThisWeek = info.quantityEarnedThisWeek
			local maxWeeklyQuantity = info.maxWeeklyQuantity
			local totalEarned = info.totalEarned
			local useTotalEarnedForMaxQty = info.useTotalEarnedForMaxQty

			if not currencyCache[currencyID] then
				currencyCache[currencyID] = E.func_FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					local cm = CharInfo.MASLENGO
					if E.func_IsSameAccount(pd) and cm then
						cm.Currency = cm.Currency or {}
						cm.Currency[currencyID] = cm.Currency[currencyID] or {}
						E.func_SetOrNil(cm.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(cm.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end

			if E.func_IsAccountWideCurrency(currencyID) then
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					local cm = CharInfo.MASLENGO
					if E.func_IsSameAccount(pd) and cm then
						cm.Currency = cm.Currency or {}
						local shared = cm.Currency[currencyID] or {}
						cm.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "canEarnPerWeek", canEarnPerWeek)
						E.func_SetOrNil(shared, "quantityEarnedThisWeek", quantityEarnedThisWeek)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			else
				local charCurrency = E.cm.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "canEarnPerWeek", canEarnPerWeek)
				E.func_SetOrNil(charCurrency, "quantityEarnedThisWeek", quantityEarnedThisWeek)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_TARGET_Currency(currencyID)
	if not E.cm then return end
	E.cm.Currency = E.cm.Currency or {}
	local info = E.func_GetCurrencyInfo(currencyID)
	if not info then
		E.cm.Currency[currencyID] = nil
	end
	E.cm.Currency[currencyID] = E.cm.Currency[currencyID] or {}
	local charCurrency = E.cm.Currency[currencyID]
	local quantity = info.quantity
	local maxQuantity = info.maxQuantity
	local totalEarned = info.totalEarned
	local maxWeeklyQuantity = info.maxWeeklyQuantity
	local useTotalEarnedForMaxQty = info.useTotalEarnedForMaxQty
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
----------------------------------------------------------------
function E.Collect_Currencies_Account()
	E.func_SpamBlock(Collect_Currencies_Account, true)
end
----------------------------------------------------------------
local result = {}
----------------------------------------------------------------
local function GetClassColorData(englishClass)
	if not englishClass then return "|cffffffff", "ffffff" end
	local c = C_ClassColor.GetClassColor(englishClass)
	if not c then return "|cffffffff", "ffffff" end
	local hex = c:GenerateHexColor()
	local rgb = hex:sub(3)
	return rgb, "|cff" .. rgb
end
----------------------------------------------------------------
local function GetRaceIDByEnglishRace(englishRace)
	for RaceID = 1, 100 do
		local info = C_CreatureInfo.GetRaceInfo(RaceID)
		if info and info.clientFileString == englishRace then
			return RaceID
		end
	end
end
----------------------------------------------------------------
function E.func_DEBUG_CURRENCY_TRANSFER()
	if not E.DEBUG then return end
	local foundNewCharacter = false
	for currencyID in next, (E.ALL_Currencies) do
		if E.func_IsAccountTransferableCurrency(currencyID) then
			local accountCurrencyData = E.func_FetchCurrencyDataFromAccountCharacters(currencyID)
			if accountCurrencyData then
				for _, v in ipairs(accountCurrencyData) do
					local characterGUID = v.characterGUID or L["NONE"]
					local fullCharacterName = v.fullCharacterName or E.TEXT_UNKNOWN
					if characterGUID and not Octo_ToDo_DB_Levels[characterGUID] then
						Octo_ToDo_DB_Levels[characterGUID] = Octo_ToDo_DB_Levels[characterGUID] or {}
						Octo_ToDo_DB_Levels[characterGUID].PlayerData = Octo_ToDo_DB_Levels[characterGUID].PlayerData or {}
						Octo_ToDo_DB_Levels[characterGUID].MASLENGO = Octo_ToDo_DB_Levels[characterGUID].MASLENGO or {}
						local pd = Octo_ToDo_DB_Levels[characterGUID].PlayerData
						local cm = Octo_ToDo_DB_Levels[characterGUID].MASLENGO
						local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName = GetPlayerInfoByGUID(characterGUID)
						if realmName == "" then realmName = E.func_GetPlayerRealm() end
						pd.Name = name
						pd.curServer = realmName
						pd.className = localizedClass
						pd.classFilename = englishClass
						pd.RaceEnglish = englishRace
						pd.UnitSex = sex
						local classColor, classColorHex = GetClassColorData(englishClass)
						pd.classColor = classColor
						pd.classColorHex = classColorHex
						pd.GUID = characterGUID
						pd.realTotalTime = 0
						pd.RaceID = GetRaceIDByEnglishRace(englishRace)
						pd.curServerShort = E.func_GetRealmShortName(realmName)
						E.func_PrintMessage("ADD NEW CHARACTER: " .. classColorHex .. fullCharacterName .. "|r")
						foundNewCharacter = true
						result[characterGUID] = fullCharacterName
					end
				end
			end
		end
	end
	if foundNewCharacter then E.WTF_func_CheckAll() end
end
----------------------------------------------------------------