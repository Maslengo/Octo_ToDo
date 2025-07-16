local GlobalAddonName, E = ...
local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion

local function compareVersion(v1, v2)
	if v1 > v2 then return true end
	if v1 < v2 then return false end
	return v1 > v2
end

local function updateGlobal(db)
	-- IF < v95.6 GLOBAL
	-- if compareVersion(95.6, db.DBVersion) then
	-- 	db.DBVersion = currentVersion
	-- end
end

local function CrTABLES()
	-- E.isAccountWideCurrencyTABLE = {}
	E.isAccountTransferableCurrencyTABLE = {}
	for _, currencyID in ipairs(E.TESTCURR) do
		-- if C_CurrencyInfo.IsAccountWideCurrency(currencyID) then
		-- 	E.isAccountWideCurrencyTABLE[currencyID] = true --C_AccountStore.GetCurrencyInfo(currencyID).name
		-- end

		if C_CurrencyInfo.IsAccountTransferableCurrency(currencyID) then
			E.isAccountTransferableCurrencyTABLE[currencyID] = true --C_AccountStore.GetCurrencyInfo(currencyID).name
		end
	end
end


local function updateChar(CharInfo)




	-- IF < v95.6 CHAR
	-- if compareVersion(95.6, CharInfo.PlayerData.DBVersion) then
	if compareVersion(96.5, Octo_ToDo_DB_Vars.DBVersion) then
		print ("CLEAR?")
		-- wipe(CharInfo.MASLENGO.UniversalQuest)

		-- Чистка старой валюты (АККАУНТ ТРАНСФЕРС)
		for currencyID in next, (E.isAccountTransferableCurrencyTABLE) do
			if CharInfo.MASLENGO.CurrencyID[currencyID] then
				CharInfo.MASLENGO.CurrencyID[currencyID] = nil
				print (currencyID, CharInfo.MASLENGO.CurrencyID[currencyID])
			end
		end

		-- if CharInfo.MASLENGO.CurrencyID_totalEarned then
		-- 	print ("CharInfo.MASLENGO.CurrencyID_totalEarned")
		-- 	CharInfo.MASLENGO.CurrencyID_totalEarned = nil
		-- end
	end
end



function E:setOldChanges()
	CrTABLES()
	if not Octo_ToDo_DB_Vars.DBVersion then
		Octo_ToDo_DB_Vars.DBVersion = 1
	end

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		CharInfo.PlayerData = CharInfo.PlayerData or {}
		if not CharInfo.PlayerData.DBVersion then
			CharInfo.PlayerData.DBVersion = 1
		end
		updateChar(CharInfo)
	end
	if compareVersion(currentVersion, Octo_ToDo_DB_Vars.DBVersion) then
		updateGlobal(Octo_ToDo_DB_Vars)
		Octo_ToDo_DB_Vars.DBVersion = currentVersion
	end
end