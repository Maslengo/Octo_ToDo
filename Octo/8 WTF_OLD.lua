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
	-- db.DBVersion = currentVersion
	-- end
end
local function updateChar(CharInfo)
	-- IF < v95.7 CHAR
	-- if compareVersion(95.7, CharInfo.PlayerData.DBVersion) then
	if compareVersion(96.7, Octo_ToDo_DB_Vars.DBVersion) then
		-- wipe(CharInfo.MASLENGO.UniversalQuest)
		if CharInfo.MASLENGO.CurrencyID then
			CharInfo.MASLENGO.CurrencyID = nil
		end
		if CharInfo.MASLENGO.CurrencyID_Total then
			CharInfo.MASLENGO.CurrencyID_Total = nil
		end
		if CharInfo.MASLENGO.CurrencyID_totalEarned then
			CharInfo.MASLENGO.CurrencyID_totalEarned = nil
		end
	end
end
function E.func_setOldChanges()
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