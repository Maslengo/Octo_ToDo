local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Professions()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	local archaeology = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		27,
		29,
		229,
		231,
		315,
		350,
		382,
		404,
		406,
		408,
		423,
		424,
	}
	local prof34 = {
		2876,
		2826,
		2754,
		2585,
		2586,
		2587,
		2588,
		2589,
		2590,
		2591,
		2592,
		2873,
		2824,
		2752,
		2541,
		2542,
		2543,
		2544,
		2545,
		2546,
		2547,
		2548,
	}
	local collectENABLEmoreprof = false
		collectMASLENGO.professions = {}
		for i, id in next, ({GetProfessions()}) do
			collectMASLENGO.professions[i] = collectMASLENGO.professions[i] or {}
			local _, _, skillLevel, maxSkillLevel, _, _, skillLine, skillModifier = GetProfessionInfo(id)
			if skillLine and skillLine ~= 0 then
				collectMASLENGO.professions[i].skillLine = skillLine
			end
			if skillLevel and skillLevel ~= 0 then
				collectMASLENGO.professions[i].skillLevel = skillLevel
			end
			if maxSkillLevel and maxSkillLevel ~= 0 then
				collectMASLENGO.professions[i].maxSkillLevel = maxSkillLevel
			end
			if skillModifier and skillModifier ~= 0 then
				collectMASLENGO.professions[i].skillModifier = skillModifier
			end
			if collectENABLEmoreprof then
				if i == 1 or i == 2 then
					for index, skillLineID in ipairs(C_TradeSkillUI.GetAllProfessionTradeSkillLines()) do
						local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
						local QWEprofessionName = info.professionName
						local QWEskillLevel = info.skillLevel
						local QWEmaxSkillLevel = info.maxSkillLevel
						local QWEprofessionID = info.professionID
						local QWEexpansionName = info.expansionName
						local QWEparentProfessionID = info.parentProfessionID
						local QWEsourceCounter = info.sourceCounter
						local QWEskillModifier = info.skillModifier
						local QWEisPrimaryProfession = info.isPrimaryProfession
						local QWEparentProfessionName = info.parentProfessionName
						if skillLine == QWEparentProfessionID then
							collectMASLENGO.professions[i].child = collectMASLENGO.professions[i].child or {}
							tinsert(collectMASLENGO.professions[i].child, {
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
						local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
						local QWEprofessionName = info.professionName
						local QWEskillLevel = info.skillLevel
						local QWEmaxSkillLevel = info.maxSkillLevel
						local QWEprofessionID = info.professionID
						local QWEexpansionName = info.expansionName
						local QWEparentProfessionID = info.parentProfessionID
						if skillLine == QWEparentProfessionID then
							collectMASLENGO.professions[i].child = collectMASLENGO.professions[i].child or {}
							tinsert(collectMASLENGO.professions[i].child, {
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
function E.Collect_All_Professions()
	E.func_SpamBlock(Collect_All_Professions, false)
end