local GlobalAddonName, E = ...
----------------------------------------------------------------
local function func_SetQuestProgress(questDataTable, completedCount, totalCount)
	if totalCount == 0 then
		questDataTable.TextCenter = nil
	elseif completedCount >= totalCount then
		questDataTable.TextCenter = true
	elseif completedCount > 0 then
		questDataTable.TextCenter = completedCount .. "/" .. totalCount
	else
		questDataTable.TextCenter = nil
	end
end

----------------------------------------------------------------
-- Вспомогательная функция для обработки одной записи квеста
local function func_ProcessQuestEntry(questData, questDataTable)
	if type(questData[1]) == "number" then
		local questID = questData[1]
		local FactionOrClass = questData.FactionOrClass
		local prof = questData.prof
		-- Проверка профессии (если указана)
		local skipThisQuest = false
		if prof then
			if not (E.pd.professions and E.pd.professions[prof]) then
				skipThisQuest = true
			end
		end
		if not skipThisQuest then
			if not FactionOrClass or (FactionOrClass[E.pd.FACTION] or FactionOrClass[E.pd.classFilename]) then
				local isCompleted = E.func_IsQuestFlaggedCompleted(questID)
				local status = E.func_GetQuestStatus(questID, true)
				questDataTable[questID] = status
				return isCompleted
			end
		end
	end
	return nil
end
----------------------------------------------------------------
local function Collect_Quests()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	E.cm.ListOfQuests = nil
	E.cm.ListOfParagonQuests = nil
	E.cm.OctoTable_QuestID = nil
	E.cm.ListOfQuests = E.cm.ListOfQuests or {}
	E.cm.ListOfParagonQuests = E.cm.ListOfParagonQuests or {}
	E.cm.OctoTable_QuestID = E.cm.OctoTable_QuestID or {}
	-- wipe(E.cm.ListOfQuests)
	-- wipe(E.cm.ListOfParagonQuests)
	-- wipe(E.cm.OctoTable_QuestID)
	for questID in next, (E.OctoTable_QuestID) do
		-- for questID in next, (E.ALL_Quests) do
		if E.func_IsQuestFlaggedCompleted(questID) then
			E.cm.OctoTable_QuestID[questID] = true
		end
	end
	local numShownEntries = E.func_GetNumQuestLogEntries()
	local numQuests = 0
	for i = 1, numShownEntries do
		local info = E.func_GetInfo(i)
		local questID = info and info.questID or 0
		-- if info and not info.isHeader and not info.isHidden and questID ~= 0 then
		if info.frequency and questID ~= 0 and not info.isHeader and not info.isHidden then
			numQuests = numQuests + 1
			E.cm.ListOfQuests[questID] = E.func_GetQuestStatus(questID)
		end
	end
	local maxNumQuestsCanAccept = E.func_GetMaxNumQuestsCanAccept() -- UNUSED
	E.pd.numQuests = E.func_Save(numQuests)
	E.pd.numShownEntries = E.func_Save(numShownEntries)
	E.pd.maxNumQuestsCanAccept = E.func_Save(maxNumQuestsCanAccept) -- UNUSED
	local numQuests_Paragon = 0
	for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
		if E.func_IsOnQuest(questID) then
			numQuests_Paragon = numQuests_Paragon + 1
			-- E.cm.ListOfQuests[questID] = E.func_GetQuestStatus(questID)
			E.cm.ListOfParagonQuests[questID] = true --  E.func_GetQuestStatus(questID)
		end
	end
	E.pd.numQuests_Paragon = E.func_Save(numQuests_Paragon)
	if E.func_SafeUpdate_AbandonButton then
		E.func_SafeUpdate_AbandonButton()
	end
end
local function Collect_Quests_Universal()
	if not E.func_CanCollectData() then return end
	-- Два пула
	local tempUniversalChar = {}
	local tempUniversalAccount = {}
	for _, data in ipairs(E.ALL_UniversalQuests) do
		local questKey = data.questKey
		local questDataTable = {}
		if questKey then
			if data.questpools and #data.questpools > 0 then
				local totalPools = #data.questpools
				local completedPools = 0
				for _, pool in ipairs(data.questpools) do
					local poolCompleted = false
					for _, questData in ipairs(pool) do
						local done = func_ProcessQuestEntry(questData, questDataTable)
						if done ~= nil and done then
							poolCompleted = true
						end
					end
					if poolCompleted then
						completedPools = completedPools + 1
					end
				end
				func_SetQuestProgress(questDataTable, completedPools, totalPools)
			elseif data.quests then
				local forcedMaxQuest = data.forcedMaxQuest
				local count = 0
				local totalQUEST = 0
				local hasSingleQuestOutput = false
				for _, questData in ipairs(data.quests) do
					local done = func_ProcessQuestEntry(questData, questDataTable)
					if done ~= nil then
						totalQUEST = totalQUEST + 1
						if done then count = count + 1 end
						if (forcedMaxQuest == 1 or #data.quests == 1) and E.func_IsOnQuest(questData[1]) then
							questDataTable.TextCenter = questDataTable[questData[1]]
							hasSingleQuestOutput = true
						end
					end
				end
				if not hasSingleQuestOutput then
					local maxToShow = forcedMaxQuest ~= nil and forcedMaxQuest or totalQUEST
					func_SetQuestProgress(questDataTable, count, maxToShow)
				end
			end
			if data.isAccount then
				tempUniversalAccount[questKey] = questDataTable
			else
				tempUniversalChar[questKey] = questDataTable
			end
		end
	end
	-- Распространение по базе
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd and cm then
			if cm.UniversalQuest == nil then
				cm.UniversalQuest = {}
			end
			if GUID == E.curGUID then
				for questKey, v in next, tempUniversalChar do
					cm.UniversalQuest[questKey] = v
				end
			end
			if E.func_IsSameAccount(pd) then
				for questKey, v in next, tempUniversalAccount do
					cm.UniversalQuest[questKey] = v
				end
			end
		end
	end
end
----------------------------------------------------------------
local mapTable = {
	[E.MapID_ZerethMortis] = { -- 1970
		65265,
		64977,
		65445,
		65362,
		65269,
		65256,
		65326,
		64785,
		65244,
		65411,
		65252,
		65268,
		65089,
		65416,
		65262,
		65255,
		65115,
	},
	[E.MapID_Korthia] = { -- 1961
		63959,
		63783,
		64432,
		63780,
		64070,
		63935,
		64240,
		64040,
		63776,
		63775,
		64271,
		63934,
		63781,
		63793, -- Задание брокеров: Энсидий Осквернитель
		63964, -- Задание брокеров: Мрачный Коготь
		63794, -- Задание брокеров: голодающее чудище
		63790, -- Задание брокеров: лорд Аззорак
		63792, -- Задание брокеров: Ноктюрнус Развоплотитель
		63963, -- Задание брокеров: Железная Лапа
		63791, -- Задание брокеров: Валдинар Окаянный
		63789, -- Неустанная борьба: Обитель ученых
		63788, -- Неустанная борьба: Святилище наставлений
		63787, -- Неустанная борьба: Площадка терзателей
		63785, -- Неустанная борьба: Форум Искателей
		64103, -- Проверенный трюк
		64101, -- Соблюдение процедур
		64089, -- Чаи и настои
		64430, -- Пролитый чай
		64065, -- Местные реагенты
		63989, -- Скользим со стилем
		64016, -- Скользим со стилем
		64017, -- Скользим со стилем
		63936, -- Поглощенная анима
		63784, -- Золото не вопрос
		63777, -- Запечатанные секреты
		63954, -- Запечатанные секреты
		63955, -- Запечатанные секреты
		63956, -- Запечатанные секреты
		63961, -- Запечатанные секреты
	},
	-- [E.MapID_TheMaw] = {
	-- },
	-- [E.MapID_Shadowlands] = {
	-- 61814,
	-- },
	-- [101] = {
	-- },
	-- [572] = {
	-- },
	-- [619] = {
	-- },
}
local function Collect_QuestsOnMap()
	Octo_Cache_DB.QuestsOnMap = Octo_Cache_DB.QuestsOnMap or {}
	for uiMapID, staticQuests in next, (mapTable) do
		Octo_Cache_DB.QuestsOnMap[uiMapID] = Octo_Cache_DB.QuestsOnMap[uiMapID] or {}
		local saved = Octo_Cache_DB.QuestsOnMap[uiMapID]
		local exists = {}
		-- Уже сохранённые квесты
		for i = 1, #saved do
			local qID = saved[i] and saved[i][1]
			if qID then
				exists[qID] = true
			end
		end
		-- Статические квесты
		for i = 1, #staticQuests do
			local qID = staticQuests[i]
			if not exists[qID] then
				exists[qID] = true
				saved[#saved + 1] = { qID }
			end
		end
		-- Динамические квесты
		local info = E.func_GetQuestsOnMap_INFO(uiMapID)
		if #info > 0 then
			for i = 1, #info do
				local quest = info[i]
				local questID = quest.questID
				if not exists[questID] then
					-- if quest.isDaily and not exists[questID] then
					local timestamp = E.func_GetQuestTimeLeftSeconds(questID)
					exists[questID] = true
					saved[#saved + 1] = {
						questID,
						addText = {timestamp = timestamp,},
					}
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_Quests()
	E.func_SpamBlock(Collect_Quests, true)
	E.func_SpamBlock(Collect_Quests_Universal, true)
end
function E.Collect_QuestsOnMap()
	E.func_SpamBlock(Collect_QuestsOnMap, true)
end
----------------------------------------------------------------