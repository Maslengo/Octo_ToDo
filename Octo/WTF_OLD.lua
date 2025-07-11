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

local function replaceFalseWithNil(tbl)
	if type(tbl) ~= "table" then return tbl end
	for k, value in pairs(tbl) do
		if value == false then
			print (k, value)
			tbl[k] = nil
		elseif type(value) == "table" then
			replaceFalseWithNil(value)
		end
	end
	return tbl
end


local function replaceZeroWithNil(tbl)
	if type(tbl) ~= "table" then return tbl end
	for k, value in pairs(tbl) do
		if value == 0 then
			print (k, value)
			tbl[k] = nil
		elseif type(value) == "table" then
			replaceZeroWithNil(value)
		end
	end
	return tbl
end


local function updateChar(CharInfo)
	-- IF < v95.6 CHAR
	if compareVersion(95.6, CharInfo.DBVersion) then
		-- wipe(CharInfo.MASLENGO.UniversalQuest)
	end

	-- IF < v95.7 CHAR
	if compareVersion(100000, CharInfo.DBVersion) then
		CharInfo.STARTTODAY = nil
		CharInfo.STARTMONTH = nil
		for k, value in pairs(CharInfo) do
			if type(value) ~= "table" then
				CharInfo.PlayerData[k] = value
				CharInfo[k] = nil

			end
			-- replaceFalseWithNil(CharInfo.PlayerData)
		end


		replaceFalseWithNil(Octo_ToDo_DB_Levels)
		replaceFalseWithNil(Octo_ToDo_DB_Vars)
		replaceFalseWithNil(Octo_ToDo_DB_Other)
		replaceFalseWithNil(Octo_ToDo_DB_Minecraft)
		replaceFalseWithNil(Octo_Achievements_DB)
		replaceFalseWithNil(Octo_AddonsTable)
		replaceFalseWithNil(Octo_AddonsManager_DB)
		replaceFalseWithNil(Octo_DEBUG)
		replaceFalseWithNil(Octo_QuestsChangedDB)

		replaceZeroWithNil(Octo_ToDo_DB_Levels)
	end

	-- CharInfo.DBVersion = currentVersion
end



function E:setOldChanges()
	if not Octo_ToDo_DB_Vars.DBVersion then
		Octo_ToDo_DB_Vars.DBVersion = 1
	end

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if not CharInfo.DBVersion then
			CharInfo.DBVersion = 1
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