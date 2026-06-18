local GlobalAddonName, E = ...
----------------------------------------------------------------
local archaeology = {1, 2, 3, 4, 5, 6, 7, 8, 27, 29, 229, 231, 315, 350, 382, 404, 406, 408, 423, 424, }
----------------------------------------------------------------
local prof34 = {2876, 2826, 2754, 2585, 2586, 2587, 2588, 2589, 2590, 2591, 2592, 2873, 2824, 2752, 2541, 2542, 2543, 2544, 2545, 2546, 2547, 2548, }
----------------------------------------------------------------
local function Collect_Professions()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	local collectENABLEmoreprof = false
	E.cm.professions = {}
	E.pd.professions = {}
	for i, id in next, ({GetProfessions()}) do
		E.cm.professions[i] = E.cm.professions[i] or {}
		local _, _, skillLevel, maxSkillLevel, _, _, skillLine, skillModifier = E.func_GetProfessionInfo(id)
		if skillLine and skillLine ~= 0 then
			E.cm.professions[i].skillLine = skillLine
			E.pd.professions[skillLine] = true
		end
		if skillLevel and skillLevel ~= 0 then
			E.cm.professions[i].skillLevel = skillLevel
		end
		if maxSkillLevel and maxSkillLevel ~= 0 then
			E.cm.professions[i].maxSkillLevel = maxSkillLevel
		end
		if skillModifier and skillModifier ~= 0 then
			E.cm.professions[i].skillModifier = skillModifier
		end
		if collectENABLEmoreprof then
			if i == 1 or i == 2 then
				for index, skillLineID in ipairs(E.func_GetAllProfessionTradeSkillLines()) do
					local info = E.func_GetProfessionInfoBySkillLineID(skillLineID)
					local QWEparentProfessionID = info.parentProfessionID
					if skillLine == QWEparentProfessionID then
						local QWEprofessionName = info.professionName
						local QWEskillLevel = info.skillLevel
						local QWEmaxSkillLevel = info.maxSkillLevel
						local QWEprofessionID = info.professionID
						local QWEexpansionName = info.expansionName
						local QWEsourceCounter = info.sourceCounter
						local QWEskillModifier = info.skillModifier
						local QWEisPrimaryProfession = info.isPrimaryProfession
						local QWEparentProfessionName = info.parentProfessionName
						E.cm.professions[i].child = E.cm.professions[i].child or {}
						tinsert(E.cm.professions[i].child, {
								QWEprofessionName = QWEprofessionName,
								QWEskillLevel = QWEskillLevel,
								QWEmaxSkillLevel = QWEmaxSkillLevel,
								QWEprofessionID = QWEprofessionID,
								QWEexpansionName = QWEexpansionName,
								QWEsourceCounter = QWEsourceCounter,
								QWEskillModifier = QWEskillModifier,
								QWEisPrimaryProfession = QWEisPrimaryProfession,
								QWEparentProfessionName = QWEparentProfessionName,
						})
					end
				end
			end
			if i == 3 then
			end
			if i == 4 or i == 5 then
				for index, skillLineID in next, (prof34) do
					local info = E.func_GetProfessionInfoBySkillLineID(skillLineID)
					local QWEparentProfessionID = info.parentProfessionID
					if skillLine == QWEparentProfessionID then
						local QWEprofessionName = info.professionName
						local QWEskillLevel = info.skillLevel
						local QWEmaxSkillLevel = info.maxSkillLevel
						local QWEprofessionID = info.professionID
						local QWEexpansionName = info.expansionName
						E.cm.professions[i].child = E.cm.professions[i].child or {}
						tinsert(E.cm.professions[i].child, {
								QWEprofessionName = QWEprofessionName,
								QWEskillLevel = QWEskillLevel,
								QWEmaxSkillLevel = QWEmaxSkillLevel,
								QWEprofessionID = QWEprofessionID,
								QWEexpansionName = QWEexpansionName,
						})
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_Professions()
	E.func_SpamBlock(Collect_Professions, false)
end
----------------------------------------------------------------