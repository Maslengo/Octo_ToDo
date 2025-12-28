local GlobalAddonName, E = ...
function E.func_GetProfileData(key)
	local tbl = Octo_profileKeys.profiles[E.CurrentProfile][key] or {}
	return tbl
end
function E.func_CreateNewProfile(profileName)
	E.DataProvider_Otrisovka = {}
	E.ALL_UniversalQuests = {}
	E.ALL_Additionally = {}
	E.ALL_RaidsOrDungeons = {}
	E.OctoTables_Vibor = {}
	E.OctoTables_DataOtrisovka = {}
	E.func_ProcessComponents()
	local db = E.func_InitializeProfileStructure(profileName)
	E.func_PopulateProfileData(db, profileName)
end
function E.func_ProcessComponents()
	for _, componentFunc in pairs(E.Components) do
		local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()
		for key, value in pairs(OctoTables_Vibor) do
			if E.OctoTables_Vibor[key] == nil then
				E.OctoTables_Vibor[key] = value
			end
		end
		for key, value in pairs(OctoTables_DataOtrisovka) do
			if E.OctoTables_DataOtrisovka[key] == nil then
				E.OctoTables_DataOtrisovka[key] = value
			end
		end
	end
end
function E.func_InitializeProfileStructure(profileName)
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	E.func_InitField(db, "CurrentProfile", profileName)
	E.func_InitField(db, "useGlobalProfile", false)
	E.func_InitField(db, "isSettingsEnabled", false)
	E.func_InitSubTable(db, "profileKeys")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, profileName)
	local profile = db.profiles[profileName]
	local profileSections = {
		"Currencies",
		"Items",
		"RaidsOrDungeons",
		"Reputations",
		"UniversalQuests",
		"Additionally"
	}
	E.func_InitField(profile, "ExpansionToShow", {
			[11] = true,
			[99] = true
	})
	for _, section in pairs(profileSections) do
		E.func_InitSubTable(profile, section)
	end
	E.func_InitSubTable(db.profiles, "Default")
	local defaultProfile = db.profiles.Default
	for _, section in pairs(profileSections) do
		E.func_InitSubTable(defaultProfile, section)
	end
	return db
end
function E.func_PopulateProfileData(db, profileName)
	local currentProfile = db.profiles[profileName]
	local defaultProfile = db.profiles.Default
	for categoryKey, categoryData in pairs(E.OctoTables_DataOtrisovka) do
		for dataType, dataEntries in pairs(categoryData) do
			E.DataProvider_Otrisovka[categoryKey] = E.DataProvider_Otrisovka[categoryKey] or {}
			E.DataProvider_Otrisovka[categoryKey][dataType] = E.DataProvider_Otrisovka[categoryKey][dataType] or {}
			if dataType ~= "UniversalQuests" then
				E.func_ProcessStandardData(categoryKey, dataType, dataEntries, currentProfile, defaultProfile)
			else
				E.func_ProcessUniversalQuests(categoryKey, dataEntries, currentProfile, defaultProfile)
			end
		end
	end
end
function E.func_ProcessStandardData(categoryKey, dataType, dataEntries, currentProfile, defaultProfile)
	for _, entry in pairs(dataEntries) do
		table.insert(E.DataProvider_Otrisovka[categoryKey][dataType], entry.id)
		currentProfile = currentProfile or {}
		currentProfile[dataType] = currentProfile[dataType] or {}
		if currentProfile[dataType][entry.id] == nil then currentProfile[dataType][entry.id] = entry.defS end
		if defaultProfile[dataType][entry.id] == nil then defaultProfile[dataType][entry.id] = entry.defS end
		if dataType == "Currencies" then
			E.ALL_Currencies[entry.id] = true
		elseif dataType == "Items" then
			E.ALL_Items[entry.id] = true
		elseif dataType == "Reputations" then
			E.ALL_Reputations[entry.id] = true
		elseif dataType == "Additionally" then
			E.ALL_Additionally[entry.id] = true
		elseif dataType == "RaidsOrDungeons" then
			E.ALL_RaidsOrDungeons[entry.id] = true
		end
	end
end
function E.func_ProcessUniversalQuests(categoryKey, questEntries, currentProfile, defaultProfile)
	for _, questData in pairs(questEntries) do
		table.insert(E.DataProvider_Otrisovka[categoryKey]["UniversalQuests"], questData)
		table.insert(E.ALL_UniversalQuests, questData)
		local questKey = E.UNIVERSAL..questData.desc.."_"..questData.name_save.."_"..questData.reset
		currentProfile.UniversalQuests[questKey] = currentProfile.UniversalQuests[questKey] or questData.defS
		defaultProfile.UniversalQuests[questKey] = defaultProfile.UniversalQuests[questKey] or questData.defS
		for _, questEntry in ipairs(questData.quests) do
			local questID = questEntry[1]
			if type(questID) == "number" then
				E.ALL_Quests[questID] = true
			end
		end
	end
end
function E.func_UpdateCurrentProfile(name)
	if name then
		Octo_profileKeys.CurrentProfile = name
	end
	E.CurrentProfile = Octo_profileKeys.CurrentProfile
end