local GlobalAddonName, E = ...
----------------------------------------------------------------
local dataDisplayOrder = E.dataDisplayOrder
function E.func_GetData_profileKeys(key)
	local tbl = Octo_profileKeys.profiles[Octo_profileKeys.Current_profile][key] or {}
	return tbl
end
local function func_ProcessComponents_profileKeys()
	E.DataProvider_Otrisovka = {}
	E.ALL_UniversalQuests = {}
	E.ALL_AdditionallyTOP = {}
	E.ALL_RaidsOrDungeons = {}
	E.OctoTables_Vibor = {}
	E.OctoTables_DataOtrisovka = {}
	for i, componentFunc in next, (E.Components) do
		local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()
		for key, value in next, (OctoTables_Vibor) do
			if E.OctoTables_Vibor[key] == nil then
				E.OctoTables_Vibor[key] = value
			end
		end
		for key, value in next, (OctoTables_DataOtrisovka) do
			if E.OctoTables_DataOtrisovka[key] == nil then
				E.OctoTables_DataOtrisovka[key] = value
			end
		end
	end
end
local function func_InitializeProfileStructure_profileKeys(profileName)
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	E.func_InitField(db, "Current_profile", profileName)
	E.func_InitSubTable(db, "profileKeys")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, profileName)
	local profile = db.profiles[profileName]
	E.func_InitField(profile, "ExpansionToShow", {
		[12] = true, -- MIDNIGHT
		[96] = true, -- MPLUS
		-- [97] = false, -- PVP
		[99] = true -- OTHER
	})
	for _, section in ipairs(dataDisplayOrder) do
		E.func_InitSubTable(profile, section)
	end
	E.func_InitSubTable(db.profiles, "Default")
	local defaultProfile = db.profiles.Default
	for _, section in ipairs(dataDisplayOrder) do
		E.func_InitSubTable(defaultProfile, section)
	end
	return db
end
local function func_ProcessUniversalQuests_profileKeys(categoryKey, questEntries, Current_profile, defaultProfile)
	for _, questData in next, (questEntries) do
		table.insert(E.DataProvider_Otrisovka[categoryKey]["UniversalQuests"], questData)
		table.insert(E.ALL_UniversalQuests, questData)
		local questKey = E.UNIVERSAL..questData.desc.."_"..questData.name_save.."_"..questData.reset
		Current_profile.UniversalQuests[questKey] = Current_profile.UniversalQuests[questKey] or questData.defS
		defaultProfile.UniversalQuests[questKey] = defaultProfile.UniversalQuests[questKey] or questData.defS
		for _, questEntry in ipairs(questData.quests) do
			local questID = questEntry[1]
			if type(questID) == "number" then
				E.ALL_Quests[questID] = true
			end
		end
	end
end
local function func_ProcessStandardData_profileKeys(categoryKey, dataType, dataEntries, Current_profile, defaultProfile)
	for _, entry in next, (dataEntries) do
		table.insert(E.DataProvider_Otrisovka[categoryKey][dataType], entry.id)
		Current_profile = Current_profile or {}
		Current_profile[dataType] = Current_profile[dataType] or {}
		if Current_profile[dataType][entry.id] == nil then Current_profile[dataType][entry.id] = entry.defS end
		if defaultProfile[dataType][entry.id] == nil then defaultProfile[dataType][entry.id] = entry.defS end
		if dataType == "Currencies" then
			E.ALL_Currencies[entry.id] = true
		elseif dataType == "Items" then
			E.ALL_Items[entry.id] = true
		elseif dataType == "AdditionallyTOP" then
			E.ALL_AdditionallyTOP[entry.id] = true
		elseif dataType == "RaidsOrDungeons" then
			E.ALL_RaidsOrDungeons[entry.id] = true
		end
	end
end
local function func_PopulateData_profileKeys(db, profileName)
	local Current_profile = db.profiles[profileName]
	local defaultProfile = db.profiles.Default
	for categoryKey, categoryData in next, (E.OctoTables_DataOtrisovka) do
		for dataType, dataEntries in next, (categoryData) do
			E.DataProvider_Otrisovka[categoryKey] = E.DataProvider_Otrisovka[categoryKey] or {}
			E.DataProvider_Otrisovka[categoryKey][dataType] = E.DataProvider_Otrisovka[categoryKey][dataType] or {}
			if dataType ~= "UniversalQuests" then
				func_ProcessStandardData_profileKeys(categoryKey, dataType, dataEntries, Current_profile, defaultProfile)
			else
				func_ProcessUniversalQuests_profileKeys(categoryKey, dataEntries, Current_profile, defaultProfile)
			end
		end
	end
end
function E.func_CreateNew_profileKeys(profileName)
	func_ProcessComponents_profileKeys()
	local db = func_InitializeProfileStructure_profileKeys(profileName)
	func_PopulateData_profileKeys(db, profileName)
end
