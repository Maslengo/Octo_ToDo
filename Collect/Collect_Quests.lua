local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Quests()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO


	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	wipe(collectMASLENGO.ListOfQuests)
	wipe(collectMASLENGO.ListOfParagonQuests)
	-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.ListOfQuests)
	wipe(collectMASLENGO.OctoTable_QuestID)


	for questID in next,(E.OctoTable_QuestID) do
	-- for questID in next,(E.ALL_Quests) do
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			collectMASLENGO.OctoTable_QuestID[questID] = true
		end
	end
	local numShownEntries = E.func_GetNumQuestLogEntries()
	local numQuests = 0
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i)
		-- if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
		if info and info.frequency and info.questID ~= 0 and not info.isHeader and not info.isHidden then
			numQuests = numQuests + 1
			collectMASLENGO.ListOfQuests[info.questID] = E.func_GetQuestStatus(info.questID)
		end
	end
	local maxNumQuestsCanAccept = E.func_GetMaxNumQuestsCanAccept() -- UNUSED
	collectPlayerData.numQuests = E.func_Save(numQuests)
	collectPlayerData.numShownEntries = E.func_Save(numShownEntries)
	collectPlayerData.maxNumQuestsCanAccept = E.func_Save(maxNumQuestsCanAccept) -- UNUSED



	local numQuests_Paragon = 0
	for questID, v in next, (E.OctoTable_Reputations_Paragon_Data) do
		if E.func_IsOnQuest(questID) then
			numQuests_Paragon = numQuests_Paragon + 1
			-- collectMASLENGO.ListOfQuests[questID] = E.func_GetQuestStatus(questID)
			collectMASLENGO.ListOfParagonQuests[questID] = E.func_GetQuestStatus(questID)
		end
	end
	collectPlayerData.numQuests_Paragon = E.func_Save(numQuests_Paragon)

	if E.func_SafeUpdate_AbandonButton then
		E.func_SafeUpdate_AbandonButton()
	end
end
-- function E.func_GetCountedQuests()
--     local counted = 0
--     local total = C_QuestLog.GetNumQuestLogEntries()
--     for i = 1, total do
--         local info = C_QuestLog.GetInfo(i)
--         if info and not info.isHeader then
--             if not info.isCampaign
--                and not info.isHidden
--                and not info.isTask
--                and not info.isBounty
--                and not info.isLegendaryQuest
--                and not info.isCalling
--                and not info.isImportant then
--                 counted = counted + 1
--             end
--         end
--     end
--     return counted
-- end
local function Collect_Quests_Universal()
	--------------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	--------------------------------------------------------------------
	if not collectMASLENGO then return end
	local hasDataToSave = false
	local tempUniversalQuest = {}
	local reset = ""
	for _, data in ipairs(E.ALL_UniversalQuests) do
		if not data.quests then break end
		local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
		reset = data.reset
		local questDataTable = {}
		local count = 0
		local totalQUEST = 0
		local forcedMaxQuest = data.forcedMaxQuest
		local hasSingleQuestOutput = false
		for _, questData in ipairs(data.quests) do
			if type(questData[1]) == "number" then
				local questID = questData[1]
				local FactionOrClass = questData.FactionOrClass
				if not FactionOrClass or (FactionOrClass[collectPlayerData.Faction] or FactionOrClass[collectPlayerData.classFilename]) then
					local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
					local status = E.func_GetQuestStatus(questID, true)
					totalQUEST = totalQUEST + 1
					questDataTable[questID] = status
					if isCompleted then
						count = count + 1
					end
					-- Для одиночных квестов
					if (forcedMaxQuest == 1 or #data.quests == 1) and E.func_IsOnQuest(questID) then
						questDataTable.TextCenter = status
						hasSingleQuestOutput = true
					end
				end
			end
		end
		-- Если не нашли одиночный активный квест
		if not hasSingleQuestOutput then
			-- Определяем максимальное количество квестов для отображения
			local maxToShow = forcedMaxQuest ~= nil and forcedMaxQuest or totalQUEST
			if maxToShow == 0 then
				-- Нет квестов с ID в группе, не записываем TextCenter
				questDataTable.TextCenter = nil
			elseif count >= maxToShow then
				-- Все необходимые квесты выполнены, показываем DONE/Готово
				questDataTable.TextCenter = true -- if type(TextCenter) == "boolean" then TextCenter = E.DONE end
			elseif count > 0 then
				-- Часть квестов выполнена, показываем X/Y
				questDataTable.TextCenter = count.."/"..maxToShow
			elseif count == 0 then
				-- Квесты есть, но ни один не выполнен, не показываем TextCenter
				questDataTable.TextCenter = nil
			end
		end
		if next(questDataTable) ~= nil then
			tempUniversalQuest[questKey] = questDataTable
			hasDataToSave = true
		end
	end
	if reset == "Regular" or reset == "Daily" or reset == "Weekly" or reset == "Month" then
		if hasDataToSave then
			collectMASLENGO.UniversalQuest = tempUniversalQuest
		elseif collectMASLENGO.UniversalQuest then
			collectMASLENGO.UniversalQuest = nil
		end
	end
end
----------------------------------------------------------------
function E.Collect_Quests()
	E.func_SpamBlock(Collect_Quests, true)
	E.func_SpamBlock(Collect_Quests_Universal, true)
end