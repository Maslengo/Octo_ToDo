local GlobalAddonName, E = ...
local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion

local function compareVersion(v1, v2)
	if v1 > v2 then return true end
	if v1 < v2 then return false end
	return v1 > v2
end

local function updateGlobal(db)
	-- IF < v95.6 GLOBAL
	if compareVersion(95.6, db.DBVersion) then
		db.DBVersion = currentVersion
	end
end



local function updateChar(CharInfo)
	-- IF < v95.6 CHAR
	if compareVersion(95.6, CharInfo.PlayerData.DBVersion) then
		-- wipe(CharInfo.MASLENGO.UniversalQuest)
	end

	-- IF < v100000 CHAR
	if compareVersion(100000, CharInfo.PlayerData.DBVersion) then
		CharInfo.STARTTODAY = nil
		CharInfo.STARTMONTH = nil
	end
end



function E:setOldChanges()
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






		-- -- Clear old version tables
		-- if not Octo_ToDo_DB_Vars.DBVersion or Octo_ToDo_DB_Vars.DBVersion < E.DBVersion then
		-- 	wipe(CharInfo.MASLENGO.OctoTable_QuestID)
		-- end

		-- Octo_ToDo_DB_Vars.DBVersion = E.DBVersion


		-- DBVersion = E.DBVersion,