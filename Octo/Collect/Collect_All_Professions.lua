local GlobalAddonName, E = ...


function E.Collect_All_Professions()
	local archaeology = {
		--ID,Name_lang,ResearchFieldID,CurrencyID,TextureFileID,BigTextureFileID,ItemID
		1, -- Дворфы,1,384,461831,461832,52843
		2, -- Дренеи,1,398,461829,461830,64394
		3, -- Окаменелости,1,393,461833,461834,0
		4, -- "Ночные эльфы",1,394,461837,461838,63127
		5, -- Нерубы,1,400,461835,461836,64396
		6, -- Орки,1,397,462321,462322,64392
		7, -- Тол'виры,1,401,461839,461840,64397
		8, -- Тролли,1,385,461841,461842,63128
		27, -- Врайкулы,1,399,461843,461844,64395
		29, -- Богомолы,1,754,839111,839112,95373
		229, -- Пандарены,1,676,633002,633003,79868
		231, -- Могу,1,677,633000,633001,79869
		315, -- Араккоа,1,829,1030616,1030821,109585
		350, -- "Дренорские кланы",1,821,1030617,1030822,108439
		382, -- Огры,1,828,1030618,1030823,109584
		404, -- Высокорожденные,1,1172,1445575,1445576,130903
		406, -- "Таурены Крутогорья",1,1173,1445577,1445578,130904
		408, -- Демоны,1,1174,1445573,1445574,130905
		423, -- Зандалари,1,1534,2060051,2060052,154989
		424, -- Друсты,1,1535,2060049,2060050,154990
	}
	-- 4
	local prof34 = {
		--fishing
		2876, --"Рыбная ловля Каз Алгара",
		2826, --"Рыбная ловля Драконьих островов",
		2754, --"Рыбная ловля Темных Земель",
		2585, --"Кул-тирасская рыбная ловля",
		2586, --"Рыбная ловля Legion",
		2587, --"Рыбная ловля Дренора",
		2588, --"Рыбная ловля Пандарии",
		2589, --"Рыбная ловля времен Катаклизма",
		2590, --"Рыбная ловля Нордскола",
		2591, --"Рыбная ловля в Запределье",
		-- 356, --"Рыбная ловля", -- МЕЙН?
		2592, --"Классическая рыбная ловля",
		--cooking
		2873,-- "Кулинария Каз Алгара",
		2824,-- "Кулинария Драконьих островов",
		2752,-- "Кулинария Темных Земель",
		2541,-- "Кул-тирасская кулинария",
		2542,-- "Кулинария Легиона",
		2543,-- "Кулинария Дренора",
		2544,-- "Кулинария Пандарии",
		2545,-- "Кулинария времен Катаклизма",
		2546,-- "Кулинария Нордскола",
		2547,-- "Кулинария Запределья",
		-- 185,-- "Кулинария", -- МЕЙН?
		2548,-- "Классическая кулинария",
		-- 981,-- "Кулинария для новичков", -- WTF?
		-- 982,-- "Кулинария для подмастерьев", -- WTF?
	}
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectENABLEmoreprof = false
	if collectMASLENGO and not InCombatLockdown() then
		-- collectMASLENGO.professions = collectMASLENGO.professions or {}
		collectMASLENGO.professions = {}
		for i, id in next, ({GetProfessions()}) do
			collectMASLENGO.professions[i] = collectMASLENGO.professions[i] or {}
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
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
					for index, skillLineID in ipairs(C_TradeSkillUI.GetAllProfessionTradeSkillLines()) do -- СОБИРАТЬ ТОЛЬКО ОСНОВНЫЕ
						-- for skillLineID, j in next, (Octo_ToDo_DB_Other.professions.DEBUG) do -- СОБИРАТЬ ВСЁ
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
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				if i == 3 then
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				if i == 4 or i == 5 then
					-- local _, _, skillLevel, maxSkillLevel, _, _, skillLine, skillModifier = GetProfessionInfo(id)
					for index, skillLineID in next, (prof34) do -- СОБИРАТЬ ВСЁ
						local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
						local QWEprofessionName = info.professionName
						local QWEskillLevel = info.skillLevel
						local QWEmaxSkillLevel = info.maxSkillLevel
						local QWEprofessionID = info.professionID
						local QWEexpansionName = info.expansionName
						local QWEparentProfessionID = info.parentProfessionID
						-- local QWEsourceCounter = info.sourceCounter
						-- local QWEskillModifier = info.skillModifier
						-- local QWEisPrimaryProfession = info.isPrimaryProfession
						-- local QWEparentProfessionName = info.parentProfessionName
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
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		end
	end
	-- for _, branchID in ipairs(ArchaeologyTBL) do
	-- local raceName, raceTextureID, raceItemID, numFragmentsCollected, numFragmentsRequired, maxFragments = GetArchaeologyRaceInfoByID(branchID)
	-- end
	-- for raceIndex = 1, GetNumArchaeologyRaces() do
	-- local numProjects = GetNumArtifactsByRace(raceIndex)
	-- end
end