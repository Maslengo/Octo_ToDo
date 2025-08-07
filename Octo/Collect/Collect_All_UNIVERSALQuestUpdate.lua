local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_91_Concat()
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_01_WorldofWarcraft())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_02_TheBurningCrusade())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_03_WrathoftheLichKing())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_04_Cataclysm())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_05_MistsofPandaria())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_06_WarlordsofDraenor())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_07_Legion())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_08_BattleforAzeroth())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_09_Shadowlands())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_10_Dragonflight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_11_TheWarWithin())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_12_Midnight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_13_TheLastTitan())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_90_Other())
end


function E:func_Collect_All_UNIVERSALQuestUpdate()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end

	if not E.func_ConcatAtStart_UniversalQuestQWE then
		print ("func_ConcatAtStart_UniversalQuestQWE")
		E.func_ConcatAtStart_UniversalQuestQWE = true
		E:func_Universal_91_Concat()
	end


	-- Создаем таблицу только если есть данные для сохранения
	local hasDataToSave = false
	local tempUniversalQuest = {}

	for _, data in ipairs(E.OctoTable_UniversalQuest) do
		if not data.quests then
			break -- Пропускаем записи без квестов
		end

		local questKey = data.desc.."_"..data.name_save.."_"..data.reset
		local questDataTable = {}
		local count = 0
		local forcedMaxQuest = data.forcedMaxQuest
		local hasSingleQuestOutput = false

		-- Обработка квестов
		for _, questData in ipairs(data.quests) do
			if type(questData[1]) == "number" then
				local questID = questData[1]
				local faction = questData.faction

				if not faction or faction == E.curFaction then
					local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
					local status = E:func_CheckCompletedByQuestID(questID)

					questDataTable[questID] = status

					if isCompleted then
						count = count + 1
					end

					if (forcedMaxQuest == 1 or #data.quests == 1) and E:func_IsOnQuest(questID) then
						questDataTable.textCENT = status
						hasSingleQuestOutput = true
					end
				end
			end
		end

		-- Добавляем счетчик только если есть завершенные квесты или особый случай
		if not hasSingleQuestOutput and count ~= 0 then
			questDataTable.textCENT = count
		end

		-- Сохраняем данные только если есть хотя бы один квест
		if next(questDataTable) ~= nil then
			tempUniversalQuest[questKey] = questDataTable
			hasDataToSave = true
		end
	end

	-- Обновляем SavedVariables только если есть данные
	if hasDataToSave then
		collectMASLENGO.UniversalQuest = tempUniversalQuest
	elseif collectMASLENGO.UniversalQuest then
		-- Очищаем если ранее были данные, но теперь их нет
		collectMASLENGO.UniversalQuest = nil
	end
end