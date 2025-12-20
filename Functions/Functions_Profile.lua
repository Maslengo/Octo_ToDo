local GlobalAddonName, E = ...
----------------------------------------------------------------
function E.func_GetProfileData(key)
	local tbl = Octo_profileKeys.profiles[E.CurrentProfile][key] or {}
	return tbl
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateNewProfile(profileName)
	-- Инициализация провайдера данных
	E.DataProvider_Otrisovka = {}
	E.ALL_UniversalQuests = {}
	E.ALL_Additionally = {}
	E.ALL_RaidsOrDungeons = {}
	E.OctoTables_Vibor = {}
	E.OctoTables_DataOtrisovka = {}
	-- 1. Обработка компонентов
	E.func_ProcessComponents()
	-- 2. Инициализация структуры профиля
	local db = E.func_InitializeProfileStructure(profileName)
	-- 3. Заполнение данных профиля
	E.func_PopulateProfileData(db, profileName)
end
----------------------------------------------------------------
-- Вспомогательные функции
function E.func_ProcessComponents()
	-- Обработка компонентов
	for _, componentFunc in pairs(E.Components) do
		local OctoTables_Vibor, OctoTables_DataOtrisovka = componentFunc()
		-- Объединение данных Vibor
		for key, value in pairs(OctoTables_Vibor) do
			if E.OctoTables_Vibor[key] == nil then
				E.OctoTables_Vibor[key] = value
			end
		end
		-- Объединение данных DataOtrisovka
		for key, value in pairs(OctoTables_DataOtrisovka) do
			if E.OctoTables_DataOtrisovka[key] == nil then
				E.OctoTables_DataOtrisovka[key] = value
			end
		end
	end
end
----------------------------------------------------------------
function E.func_InitializeProfileStructure(profileName)
	-- Инициализация основной структуры
	Octo_profileKeys = Octo_profileKeys or {}
	local db = Octo_profileKeys
	-- Базовые настройки
	E.func_InitField(db, "CurrentProfile", profileName)
	E.func_InitField(db, "useGlobalProfile", false)
	E.func_InitField(db, "isSettingsEnabled", false)
	-- Инициализация подтаблиц
	E.func_InitSubTable(db, "profileKeys")
	E.func_InitSubTable(db, "profiles")
	E.func_InitSubTable(db.profiles, profileName)
	----------------------------------------------------------------
	-- Инициализация секций профиля
	local profile = db.profiles[profileName]
	local profileSections = {
		"Currencies",
		"Items",
		"RaidsOrDungeons",
		"Reputations",
		"UniversalQuests",
		"Additionally"
	}
	-- Настройки расширений по умолчанию
	E.func_InitField(profile, "ExpansionToShow", {
			-- [7] = true, -- 07_Legion
			[11] = true, -- 11_TheWarWithin
			-- [98] = true, -- Holidays
			[99] = true
	})
	----------------------------------------------------------------
	for _, section in pairs(profileSections) do
		E.func_InitSubTable(profile, section)
	end
	-- Создание профиля Default если не существует
	E.func_InitSubTable(db.profiles, "Default")
	-- Инициализация секций для Default
	local defaultProfile = db.profiles.Default
	for _, section in pairs(profileSections) do
		E.func_InitSubTable(defaultProfile, section)
	end
	return db
end
----------------------------------------------------------------
function E.func_PopulateProfileData(db, profileName)
	local currentProfile = db.profiles[profileName]
	local defaultProfile = db.profiles.Default
	for categoryKey, categoryData in pairs(E.OctoTables_DataOtrisovka) do
		for dataType, dataEntries in pairs(categoryData) do
			-- Инициализация структуры данных
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
----------------------------------------------------------------
function E.func_ProcessStandardData(categoryKey, dataType, dataEntries, currentProfile, defaultProfile)
	for _, entry in pairs(dataEntries) do
		-- Добавление ID в DataProvider
		table.insert(E.DataProvider_Otrisovka[categoryKey][dataType], entry.id)
		-- Установка значения по умолчанию для текущего профиля
		currentProfile = currentProfile or {}
		currentProfile[dataType] = currentProfile[dataType] or {}
		if currentProfile[dataType][entry.id] == nil then currentProfile[dataType][entry.id] = entry.defS end
		-- Установка значения по умолчанию для Default профиля
		if defaultProfile[dataType][entry.id] == nil then defaultProfile[dataType][entry.id] = entry.defS end
		-- Регистрация в глобальных таблицах
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
----------------------------------------------------------------
function E.func_ProcessUniversalQuests(categoryKey, questEntries, currentProfile, defaultProfile)
	for _, questData in pairs(questEntries) do
		-- Добавление данных квеста
		table.insert(E.DataProvider_Otrisovka[categoryKey]["UniversalQuests"], questData)
		table.insert(E.ALL_UniversalQuests, questData)
		-- Создание уникального ключа для квеста
		local questKey = E.UNIVERSAL..questData.desc.."_"..questData.name_save.."_"..questData.reset
		-- Установка значений по умолчанию
		currentProfile.UniversalQuests[questKey] = currentProfile.UniversalQuests[questKey] or questData.defS
		defaultProfile.UniversalQuests[questKey] = defaultProfile.UniversalQuests[questKey] or questData.defS
		-- Регистрация ID квестов
		for _, questEntry in ipairs(questData.quests) do
			local questID = questEntry[1]
			if type(questID) == "number" then
				E.ALL_Quests[questID] = true
			end
		end
	end
end
----------------------------------------------------------------
function E.func_UpdateCurrentProfile(name)
	if name then
		Octo_profileKeys.CurrentProfile = name
	end
	E.CurrentProfile = Octo_profileKeys.CurrentProfile
end
