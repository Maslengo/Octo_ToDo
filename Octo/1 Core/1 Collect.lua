local GlobalAddonName, E = ...
local Octo_EventFrame_Collect = CreateFrame("FRAME")
Octo_EventFrame_Collect:Hide()
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local frame = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		frame:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		frame:SetPoint("TOPLEFT", 8, -2)
		frame:SetPoint("BOTTOMRIGHT", -8, 2)
		frame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		frame:SetBackdropBorderColor(0, 0, 0, 1)
		return frame
end)
local locale = GetLocale()
----------------------------------------------------------------
function E.LoadOctoUIforAddons()
	if not Octo_DEBUG then return end
	Octo_DEBUG.profileKeys = Octo_DEBUG.profileKeys or {}
	local currentKey = E.curCharName.." - "..E.curServer
	Octo_DEBUG.profileKeys[currentKey] = Octo_DEBUG.profileKeys[currentKey] or "OctoUI"
	if ElvDB then
		for name, v in next, (ElvDB.profileKeys) do
			Octo_DEBUG.profileKeys[name] = "OctoUI"
		end
	end
	local AddonsAndDB = {
		{database = AddonCpuUsageDB, profileName = "OctoUI"}, -- ACU
		{database = AddOnSkinsDB, profileName = "OctoUI"}, -- AddOnSkins
		{database = Bartender4DB, profileName = "OctoUI"}, -- Bartender4
		{database = ElvDB, profileName = "OctoUI"}, -- ElvUI
		{database = ElvPrivateDB, profileName = "PRIVATEPROFILE"}, -- ElvUI
		{database = MythicDungeonToolsDB, profileName = "OctoUI"}, -- MythicDungeonTools
		{database = OmniCCDB, profileName = "OctoUI"}, -- OmniCC
		{database = OmniCDDB, profileName = "OctoUI"}, -- OmniCD
		{database = ParrotDB, profileName = "OctoUI"}, -- Parrot
		{database = PlaterDB, profileName = "OctoUI"}, -- Plater
		{database = RareScannerDB, profileName = "OctoUI"}, -- RareScanner
		{database = RCLootCouncilDB, profileName = "OctoUI"}, -- RCLootCouncil
		{database = RCLootCouncilLootDB, profileName = "OctoUI"}, -- RCLootCouncil
		{database = SilverDragon3DB, profileName = "OctoUI"}, -- SilverDragon
		{database = TomTomDB, profileName = "OctoUI"}, -- TomTom
		{database = TomTomWaypointsM, profileName = "OctoUI"}, -- TomTom
		{database = VMRT, profileName = "OctoUI"}, -- MRT
		{database = WarpDepleteDB, profileName = "OctoUI"}, -- WarpDeplete
		{database = GreatVaultList2DB, profileName = "OctoUI"}, -- GreatVaultList
	}
	for k, v in ipairs(AddonsAndDB) do
		local addonName = v.addonName
		local database = v.database
		local profileName = v.profileName
		if database then
			database.profileKeys = database.profileKeys or {}
			for name, OctoUI in next, Octo_DEBUG.profileKeys do
				if database == VMRT then
					local nameWithoutSpace = name:gsub(" ", "")
					VMRT.ProfileKeys[nameWithoutSpace] = profileName
				else
					database.profileKeys[name] = profileName
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_All_PlayerInfo()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local curServerShort = E.func_CurServerShort(E.curServer)
		local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
		local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
		----
		collectPlayerData.curServerShort = curServerShort
		collectPlayerData.Name = E.curCharName
		collectPlayerData.curServer = E.curServer
		collectPlayerData.className = E.className
		collectPlayerData.classFilename = E.classFilename
		collectPlayerData.classId = E.classId
		collectPlayerData.GUID = E.curGUID
		collectPlayerData.Faction = E.curFaction
		collectPlayerData.specId = specId or 0
		collectPlayerData.specName = specName or ""
		collectPlayerData.specIcon = specIcon or 0
		collectPlayerData.classColor = E.classColor
		collectPlayerData.RaceLocal = RaceLocal
		collectPlayerData.RaceEnglish = RaceEnglish
		collectPlayerData.raceID = raceID
		collectPlayerData.classColorHex = E.classColorHexCurrent
		collectPlayerData.guildName = guildName
		collectPlayerData.guildRankName = guildRankName
		if guildRankIndex and guildRankIndex ~= 0 then
			collectPlayerData.guildRankIndex = guildRankIndex
		end
		collectPlayerData.BattleTag = E.BattleTag
		collectPlayerData.BattleTagLocal = E.BattleTagLocal
		collectPlayerData.buildVersion = E.buildVersion
		collectPlayerData.buildNumber = E.buildNumber
		collectPlayerData.buildDate = E.buildDate
		collectPlayerData.interfaceVersion = E.interfaceVersion
		collectPlayerData.currentTier = E.currentTier
		if E.IsPublicBuild then
			collectPlayerData.IsPublicBuild = E.IsPublicBuild
		else
			collectPlayerData.IsPublicBuild = nil
		end
		collectPlayerData.GetRestrictedAccountData_rLevel = E.GetRestrictedAccountData_rLevel
		collectPlayerData.GetRestrictedAccountData_rMoney = E.GetRestrictedAccountData_rMoney
		if E.IsAccountSecured then
			collectPlayerData.IsAccountSecured = E.IsAccountSecured
		else
			collectPlayerData.IsAccountSecured = nil
		end
		if E.IsRestrictedAccount then
			collectPlayerData.IsRestrictedAccount = E.IsRestrictedAccount
		else
			collectPlayerData.IsRestrictedAccount = nil
		end
		if E.IsTrialAccount then
			collectPlayerData.IsTrialAccount = E.IsTrialAccount
		else
			collectPlayerData.IsTrialAccount = nil
		end
		if E.IsVeteranTrialAccount then
			collectPlayerData.IsVeteranTrialAccount = E.IsVeteranTrialAccount
		else
			collectPlayerData.IsVeteranTrialAccount = nil
		end
		collectPlayerData.DBVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
	end
end
function E.Collect_All_ReloadCount()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.ReloadCount = collectPlayerData.ReloadCount or 0
		collectPlayerData.ReloadCount = collectPlayerData.ReloadCount + 1
	end
end
function E.Collect_All_Covenant()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectMASLENGO and not InCombatLockdown() then
		local curCovID = C_Covenants.GetActiveCovenantID() or 0
		if curCovID > 0 then
			local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
			local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
			local curAnimaAmount = currencyInfo.quantity
			collectMASLENGO.CovenantAndAnima = collectMASLENGO.CovenantAndAnima or {}
			collectMASLENGO.CovenantAndAnima.curCovID = curCovID
			collectMASLENGO.CovenantAndAnima[curCovID][1] = curCovLevel
			collectMASLENGO.CovenantAndAnima[curCovID][2] = curAnimaAmount
		end
	end
end
function E.Collect_All_PlayerDurability()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local totalDurability = 100
		local slots = {
			[1] = _G.INVTYPE_HEAD,
			[3] = _G.INVTYPE_SHOULDER,
			[5] = _G.INVTYPE_CHEST,
			[6] = _G.INVTYPE_WAIST,
			[7] = _G.INVTYPE_LEGS,
			[8] = _G.INVTYPE_FEET,
			[9] = _G.INVTYPE_WRIST,
			[10] = _G.INVTYPE_HAND,
			[16] = _G.INVTYPE_WEAPONMAINHAND,
			[17] = _G.INVTYPE_WEAPONOFFHAND,
			[18] = _G.INVTYPE_RANGED,
		}
		for index in next, (slots) do
			local currentDura, maxDura = GetInventoryItemDurability(index)
			if currentDura and maxDura > 0 then
				local perc = (currentDura/maxDura)*100
				if perc < totalDurability then
					totalDurability = perc
				end
			end
		end
		collectPlayerData.PlayerDurability = E.func_CompactNumberSimple(totalDurability)
	end
end
function E.Collect_All_PlayerLevel()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local UnitLevel = UnitLevel("PLAYER") or 0
		local currentXP = UnitXP("PLAYER") or 0
		local UnitXPMax = UnitXPMax("PLAYER") or 0
		local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
		collectPlayerData.UnitLevel = UnitLevel
		collectPlayerData.currentXP = currentXP
		collectPlayerData.UnitXPMax = UnitXPMax
		collectPlayerData.UnitXPPercent = UnitXPPercent
		if UnitLevel == E.currentMaxLevel then
			collectPlayerData.PlayerCanEarnExperience = nil
		else
			if E.GameLimitedMode_IsActive == true then
				if UnitLevel >= E.GetRestrictedAccountData_rLevel then
					-- if MainStatusTrackingBarContainer and MainStatusTrackingBarContainer:IsShown() then
					-- tinsert(E.OctoTable_MustBeHiddenFrames_table, {name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer})
					-- end
					collectPlayerData.levelCapped20 = true
					collectPlayerData.PlayerCanEarnExperience = nil
				else
					collectPlayerData.levelCapped20 = nil
					collectPlayerData.PlayerCanEarnExperience = true
				end
			end
		end
	end
end
function E.Collect_All_Played(totalTime, currentLevelTime)
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.realTotalTime = totalTime
		collectPlayerData.realLevelTime = currentLevelTime
	end
end
function E.Collect_All_WarMode()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		local WarMode = C_PvP.IsWarModeDesired()
		if WarMode then
			collectPlayerData.WarMode = WarMode
		else
			collectPlayerData.WarMode = nil
		end
	end
end
function E.Collect_All_Mail()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local hasMail = HasNewMail()
		if hasMail then
			collectPlayerData.hasMail = hasMail
		else
			collectPlayerData.hasMail = nil
		end
	end
end
function E.Collect_All_LoginTime()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData then
		collectPlayerData.loginDate = date("%d.%m.%Y %H:%M:%S")
		collectPlayerData.loginDay = date("%d.%m.%Y")
		collectPlayerData.loginHour = date("%H:%M")
		collectPlayerData.needResetWeekly = nil
		collectPlayerData.needResetDaily = nil
		collectPlayerData.needResetMonth = nil
		collectPlayerData.time = time()
	end
end
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
			if  collectENABLEmoreprof  then
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
	--         local raceName, raceTextureID, raceItemID, numFragmentsCollected, numFragmentsRequired, maxFragments = GetArchaeologyRaceInfoByID(branchID)
	--     end
	-- for raceIndex = 1, GetNumArchaeologyRaces() do
	--     local numProjects = GetNumArtifactsByRace(raceIndex)
	-- end
end
function E.Collect_All_GreatVault()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
		C_MythicPlus.RequestRewards()
		local currentWeekBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
		C_MythicPlus.RequestMapInfo()
		for i = 1, #mapChallengeModeIDs do
			local _, level = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeIDs[i])
			if level and level > currentWeekBestLevel then
				currentWeekBestLevel = level
			end
		end
		if C_ChallengeMode.GetOverallDungeonScore("PLAYER") and C_ChallengeMode.GetOverallDungeonScore("PLAYER") ~= 0 then
			collectPlayerData.RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
		else
			collectPlayerData.RIO_Score = nil
		end
		if currentWeekBestLevel and currentWeekBestLevel ~= 0 then
			collectPlayerData.RIO_weeklyBest = currentWeekBestLevel
		else
			collectPlayerData.RIO_weeklyBest = nil
		end
		local name_activities = setmetatable({
				[0] = "None",
				[1] = DUNGEONS,
				[2] = "PvP",
				[3] = RAIDS,
				[4] = "AlsoReceive",
				[5] = "Concession",
				[6] = WORLD,
			}, {__index = function(self, k)
					for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
						if i == k then
							self[k] = name
							break
						end
					end
					return self[k]
				end
		})
		for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
			local vivod
			local hyperlink_STRING = ""
			local activities = C_WeeklyRewards.GetActivities(i)
			local activity_name = name_activities[i] or name
			for k = 1, #activities do
				local activityInfo = activities[k]
				if activityInfo then
					local tip = activityInfo.type
					if collectPlayerData and tip ~= nil then
						collectMASLENGO.GreatVault[tip] = collectMASLENGO.GreatVault[tip] or {}
						collectMASLENGO.GreatVault[tip].type = activity_name
						if activityInfo.progress ~= 0 then
							collectMASLENGO.GreatVault[tip].progress = activityInfo.progress
						end
						if activityInfo.threshold ~= 0 then
							collectMASLENGO.GreatVault[tip].threshold = activityInfo.threshold
						end
						local hyperlink = E.func_GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						hyperlink_STRING = E.func_GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						if hyperlink_STRING then
							vivod = vivod and vivod..", "..hyperlink_STRING or hyperlink_STRING
							if vivod ~= nil and vivod ~= 0 then
								collectMASLENGO.GreatVault[tip].hyperlink_STRING = vivod
							end
						end
					end
				end
			end
		end
	end
end
function E.Collect_All_Currency()
	-- local list = Octo_DB_Config.CurrencyDB
	local list = {}
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		-- local listSize = C_CurrencyInfo.GetCurrencyListSize()
		-- local headerIndex
		-- for i = 1, listSize do
		--     local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		--     if info and info.isHeader then
		--         C_CurrencyInfo.ExpandCurrencyList(i, true)
		--         listSize = C_CurrencyInfo.GetCurrencyListSize()
		--         headerIndex = i
		--     elseif info and info.name then
		--         local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
		--         local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
		--         if currencyID then
		--             list[currencyID] = list[currencyID] or false
		--         end
		--     end
		-- end
		-- for CurrencyID, v in next, (list) do
		for _, CurrencyID in ipairs(E.TESTCURR) do
			local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(CurrencyID) or false
			local data = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
			if data then
				local quantity = data.quantity
				local maxQuantity = data.maxQuantity
				local totalEarned = data.totalEarned
				if isAccountWideCurrency == false then
					if collectMASLENGO and not InCombatLockdown() then
						collectMASLENGO.CurrencyID = collectMASLENGO.CurrencyID or {}
						collectMASLENGO.CurrencyID_totalEarned = collectMASLENGO.CurrencyID_totalEarned or {}
						collectMASLENGO.CurrencyID_Total = collectMASLENGO.CurrencyID_Total or {}
						if quantity ~= nil and quantity ~= 0 then
							collectMASLENGO.CurrencyID[CurrencyID] = quantity
						end
						if totalEarned ~= nil and totalEarned ~= 0 then
							collectMASLENGO.CurrencyID_totalEarned[CurrencyID] = totalEarned
						end
						if maxQuantity ~= nil and maxQuantity ~= 0 then
							if quantity ~= maxQuantity then
								collectMASLENGO.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
							else
								collectMASLENGO.CurrencyID_Total[CurrencyID] = E.Green_Color..quantity.."/"..maxQuantity.."|r"
							end
						else
							if quantity ~= nil and quantity ~= 0 then
								collectMASLENGO.CurrencyID_Total[CurrencyID] = quantity
							end
						end
					end
				else
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						collectMASLENGO.CurrencyID = collectMASLENGO.CurrencyID or {}
						collectMASLENGO.CurrencyID_totalEarned = collectMASLENGO.CurrencyID_totalEarned or {}
						collectMASLENGO.CurrencyID_Total = collectMASLENGO.CurrencyID_Total or {}
						if CharInfo and not InCombatLockdown() then
							if quantity ~= nil and quantity ~= 0 then
								collectMASLENGO.CurrencyID[CurrencyID] = quantity
							end
							if totalEarned ~= nil and totalEarned ~= 0 then
								collectMASLENGO.CurrencyID_totalEarned[CurrencyID] = totalEarned
							end
							if maxQuantity ~= nil and maxQuantity ~= 0 then
								if quantity ~= maxQuantity then
									collectMASLENGO.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
								else
									collectMASLENGO.CurrencyID_Total[CurrencyID] = E.Green_Color..quantity.."/"..maxQuantity.."|r"
								end
							end
						end
					end
				end
			else
				collectMASLENGO.CurrencyID[CurrencyID] = nil
				collectMASLENGO.CurrencyID_Total[CurrencyID] = nil
				collectMASLENGO.CurrencyID_totalEarned[CurrencyID] = nil
			end
		end
	end
end
function E.Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	C_Reputation.ExpandAllFactionHeaders()
	if collectMASLENGO and not InCombatLockdown() then
		----------------------------------------------------------------
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			for i, v in ipairs(tbl) do
				local reputationID = v.id
				if C_Reputation.IsAccountWideReputation(reputationID) then
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						collectMASLENGO.reputationNEW[reputationID] = E.func_CheckReputationNEW(reputationID)
					end
				else
					collectMASLENGO.reputationNEW[reputationID] = E.func_CheckReputationNEW(reputationID)
				end
			end
		end
		----------------------------------------------------------------
	end
end
function E.Collect_All_ItemsInBag()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local usedSlots = 0
		local totalSlots = 0
		local Possible_Anima = 0
		local Possible_CatalogedResearch = 0
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			local numSlots = C_Container.GetContainerNumSlots(bag)
			totalSlots = totalSlots + numSlots
			local numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
			if BagType == 0 then
				usedSlots = usedSlots + (numSlots - numberOfFreeSlots)
			end
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local stackCount = containerInfo.stackCount
					local itemID = containerInfo.itemID
					local quality = containerInfo.quality
					local hyperlink = containerInfo.hyperlink
					if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") or hyperlink:find("keystone:151086") then
						local dungeonID = select(4, strsplit(":", hyperlink)) -- БЫЛО 3
						local lvl = select(5, strsplit(":", hyperlink)) -- БЫЛО 4
						collectPlayerData.CurrentKeyLevel = tonumber(lvl)
						collectPlayerData.CurrentKeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
						for k, v in next, (E.OctoTable_KeystoneAbbr) do
							if v.mapChallengeModeID == tonumber(dungeonID) then
								collectPlayerData.CurrentKey = lvl.." "..v.abbreviation
							end
						end
					end
					for _, tbl in next, (E.OctoTable_itemID_Cataloged_Research) do
						if itemID == tbl.itemiD then
							Possible_CatalogedResearch = Possible_CatalogedResearch + (tbl.count*E.func_GetItemCount(itemID))
						end
					end
					local isAnima = E.func_IsAnimaItemByID(itemID)
					if stackCount and isAnima and itemID ~= nil then
						if (quality == 2) and (itemID ~= 183727) then
							Possible_Anima = Possible_Anima + (5 * stackCount)
						end
						if quality == 3 then
							Possible_Anima = Possible_Anima + (35 * stackCount)
						end
						if quality == 4 then
							Possible_Anima = Possible_Anima + (250 * stackCount)
						end
						if itemID == 183727 then
							Possible_Anima = Possible_Anima + (3 * stackCount)
						end
					end
				end
			end
		end
		collectMASLENGO.ItemsInBag = collectMASLENGO.ItemsInBag or {}
		for _, itemID in next, (E.OctoTable_itemID_ALL) do
			local count = E.func_GetItemCount(itemID, true, true, true, false)
			if count ~= 0 then
				collectMASLENGO.ItemsInBag[itemID] = count
			else
				collectMASLENGO.ItemsInBag[itemID] = nil
			end
		end
		if Possible_Anima ~= 0 then
			collectPlayerData.Possible_Anima = Possible_Anima
		end
		if Possible_CatalogedResearch ~= 0 then
			collectPlayerData.Possible_CatalogedResearch = Possible_CatalogedResearch
		end
		if usedSlots ~= 0 then
			collectPlayerData.usedSlots = usedSlots
		end
		if totalSlots ~= 0 then
			collectPlayerData.totalSlots = totalSlots
		end
		if C_WeeklyRewards.HasAvailableRewards() then
			collectPlayerData.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
		else
			collectPlayerData.HasAvailableRewards = nil
		end
	end
end
function E.Collect_All_Locations()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local curRealZone = GetRealZoneText()
		local curBindLocation = GetBindLocation()
		collectPlayerData.curLocation = E.func_GetCurrentLocation()
		if curRealZone and curBindLocation then
			collectPlayerData.BindLocation = curRealZone.." ("..curBindLocation..")"
		end
	end
end
function E.Collect_All_Quests()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectPlayerData or InCombatLockdown() then return end
	-- Очищаем таблицы
	wipe(collectMASLENGO.ListOfQuests)
	wipe(collectMASLENGO.OctoTable_QuestID)
	-- Обрабатываем OctoTable_QuestID
	for _, questID in ipairs(E.OctoTable_QuestID) do
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			collectMASLENGO.OctoTable_QuestID[questID] = true
		end
		-- local status = E.func_CheckCompletedByQuestID(questID)
		-- if status ~= E.NONE then
		--     collectMASLENGO.OctoTable_QuestID[questID] = status
		-- end
	end
	-- Собираем информацию о квестах
	local numQuests = 0
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and not info.isHidden and info.questID ~= 0 then
			numQuests = numQuests + 1
			collectMASLENGO.ListOfQuests[info.questID] = E.func_CheckCompletedByQuestID(info.questID)
		end
	end
	-- Сохраняем статистику
	if numShownEntries then
		collectPlayerData.numShownEntries = numShownEntries
	end
	if numQuests ~= 0 then
		collectPlayerData.numQuests = numQuests
	end
	if C_QuestLog.GetMaxNumQuestsCanAccept() then
		collectPlayerData.maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	end
end
function E.Collect_All_UNIVERSALQuestUpdateQWEQWE()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO or InCombatLockdown() then return end
	collectMASLENGO.UniversalQuest = collectMASLENGO.UniversalQuest or {}
	for i, v in ipairs(E.OctoTable_UniversalQuest) do
		local count = 0
		local questKey = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
		for _, questID in next, (v.questID) do

			-- /dump C_QuestLog.IsQuestFlaggedCompleted(76215)
			if C_QuestLog.IsQuestFlaggedCompleted(questID) then
				count = count + 1
			end
			if v.max == 1 and E.func_IsOnQuest(questID) then
				collectMASLENGO.UniversalQuest[questKey] = E.func_CheckCompletedByQuestID(questID)
			end
		end
		if count > 0 then
			collectMASLENGO.UniversalQuest[questKey] = count
		end
	end
end



function E.Collect_All_UNIVERSALQuestUpdate()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO or InCombatLockdown() then return end
	-- collectMASLENGO.UniversalQuest = collectMASLENGO.UniversalQuest or {}
	for i, v in next, (E.OctoTable_UniversalQuest) do
		local count = 0
		local questKey = "Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset
		for _, questID in next, (v.questID) do
			if C_QuestLog.IsQuestFlaggedCompleted(questID) then
				count = count + 1
			end
			if v.max == 1 and E.func_IsOnQuest(questID) then
				collectMASLENGO.UniversalQuest[questKey] = E.func_CheckCompletedByQuestID(questID)
			end
		end
		-- if Octo_DEBUG then
			-- Octo_DEBUG.UniversalQuest[v.desc] = Octo_DEBUG.UniversalQuest[v.desc] or {}
			-- Octo_DEBUG.UniversalQuest[v.desc][i] = Octo_DEBUG.UniversalQuest[v.desc][i] or tostringall("CharInfo.MASLENGO.UniversalQuest."..questKey)
		-- end
		if count > 0 then
			collectMASLENGO.UniversalQuest[questKey] = count
		end
	end
end










function E.Collect_All_ItemLevel()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
		collectPlayerData.avgItemLevel = math.floor(avgItemLevel)
		collectPlayerData.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collectPlayerData.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function E.Collect_All_MoneyUpdate()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		collectPlayerData.Money = GetMoney() or 0
		Octo_ToDo_DB_Other.AccountMoney[E.BattleTagLocal] = C_Bank.FetchDepositedMoney(2)
	end
end
function E.Collect_All_MoneyOnLogin()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local Money = GetMoney()
		collectPlayerData.MoneyOnLogin = Money
	end
end
function E.Collect_All_JournalInstance()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local NumSavedInstances = GetNumSavedInstances()
		local NumSavedWorldBosses = GetNumSavedWorldBosses()
		local DiffAbbr = ""
		local instancesLastBoss = {}
		local ServerTime = GetServerTime()
		if NumSavedInstances > 0 then
			for i = 1, NumSavedInstances do
				local instanceName, lockoutId, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, instanceId = GetSavedInstanceInfo(i)
				collectMASLENGO.journalInstance[instanceId] = collectMASLENGO.journalInstance[instanceId] or {}
				collectMASLENGO.journalInstance[instanceId][instanceDifficulty] = collectMASLENGO.journalInstance[instanceId][instanceDifficulty] or {}
				if locked then
					local _, _, lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
					if defeatedBosses == 0 and lastBossDefeated then
						lastBossDefeated = false
					end
					local color = E.Red_Color
					if lastBossDefeated then
						color = E.Yellow_Color
					end
					if defeatedBosses == totalBosses then
						color = E.Green_Color
					end
					if instanceReset and instanceReset > 0 then
						instanceReset = instanceReset + time()
					else
						instanceReset = 0
					end
					if instanceDifficulty == 17 then
						DiffAbbr = "LFR"
					elseif instanceDifficulty == 1 or instanceDifficulty == 14 then
						DiffAbbr = "N"
					elseif instanceDifficulty == 2 or instanceDifficulty == 15 then
						DiffAbbr = "H"
					elseif instanceDifficulty == 23 or instanceDifficulty == 16 then
						DiffAbbr = "M"
					else
						DiffAbbr = "HZ"
					end
					local vivod = color..defeatedBosses.."/"..totalBosses.."|r"
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceName = instanceName
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].vivod = vivod
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceReset = instanceReset
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].difficultyName = difficultyName
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceDifficulty = instanceDifficulty
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].extended = extended
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].instanceIDMostSig = instanceIDMostSig
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].isRaid = isRaid
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].maxPlayers = maxPlayers
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].totalBosses = totalBosses
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].defeatedBosses = defeatedBosses
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].extendDisabled = extendDisabled
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].DiffAbbr = DiffAbbr
					collectMASLENGO.journalInstance[instanceId][instanceDifficulty].Time = E.func_SecondsToClock(instanceReset-ServerTime)
				end
			end
		end
		if NumSavedWorldBosses > 0 then
			for i = 1, NumSavedWorldBosses do
				local name, worldBossID, reset = GetSavedWorldBossInfo(i)
				collectMASLENGO.SavedWorldBoss[worldBossID] = collectMASLENGO.SavedWorldBoss[worldBossID] or {}
				collectMASLENGO.SavedWorldBoss[worldBossID].name = name
				collectMASLENGO.SavedWorldBoss[worldBossID].reset = reset
			end
		end
		-- local qweLIST = {}
		for i=1, GetNumRandomDungeons() do
			local dungeonID, name = GetLFGRandomDungeonInfo(i)
			-- tinsert(qweLIST, "["..dungeonID.."] = "..name)
			if dungeonID and E.OctoTable_LFGDungeons[dungeonID] then
				local D_name = GetLFGDungeonInfo(dungeonID)
				local donetoday = GetLFGDungeonRewards(dungeonID)
				collectMASLENGO.LFGInstance[dungeonID] = collectMASLENGO.LFGInstance[dungeonID] or {}
				collectMASLENGO.LFGInstance[dungeonID].D_name = D_name
				if donetoday == true then
					collectMASLENGO.LFGInstance[dungeonID].donetoday = E.DONE
				else
					collectMASLENGO.LFGInstance[dungeonID].donetoday = nil
				end
			end
		end
		-- fpde (qweLIST)
	end
end
function E.Collect_All_Holiday()
	Octo_ToDo_DB_Other.Holiday = Octo_ToDo_DB_Other.Holiday or {}
	-- wipe(Octo_ToDo_DB_Other.Holiday)
	Octo_ToDo_DB_Other.ActiveHoliday = {}
	wipe(Octo_ToDo_DB_Other.ActiveHoliday)
	if Octo_ToDo_DB_Other.Holiday and not InCombatLockdown() then
		local backup = Octo_ToDo_DB_Other.CVar
		local function function_setBackup()
			if CalendarFrame then
				CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
				CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
			end
			backup.calendarShowHolidays = GetCVarBool("calendarShowHolidays")
			backup.calendarShowDarkmoon = GetCVarBool("calendarShowDarkmoon")
			backup.calendarShowLockouts = GetCVarBool("calendarShowLockouts")
			backup.calendarShowWeeklyHolidays = GetCVarBool("calendarShowWeeklyHolidays")
			backup.calendarShowBattlegrounds = GetCVarBool("calendarShowBattlegrounds")
			if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "1") end
			if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "1") end
			if not backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "1") end
			if not backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "1") end
			if not backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "1") end
			backup.dateBackup = C_Calendar.GetMonthInfo()
		end
		local function function_restoreBackup()
			if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "0") end
			if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "0") end
			if not backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "0") end
			if not backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "0") end
			if not backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "0") end
			C_Calendar.SetAbsMonth(backup.dateBackup.month, backup.dateBackup.year)
			if CalendarFrame then
				CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
				CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
			end
		end
		function_setBackup()
		local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
		local minute = currentCalendarTime.minute
		local hour = currentCalendarTime.hour
		local monthDay = currentCalendarTime.monthDay
		local month = currentCalendarTime.month
		local offsetMonths = 0
		local year = currentCalendarTime.year
		local monthInfo = C_Calendar.GetMonthInfo()
		local priority = 0
		C_Calendar.SetAbsMonth(month, year)
		for day = 1, monthInfo.numDays do
			local numEvents = C_Calendar.GetNumDayEvents(offsetMonths, day)
			for i = 1, numEvents do
				local eInfo = C_Calendar.GetHolidayInfo(0, day, i)
				local event = C_Calendar.GetDayEvent(offsetMonths, day, i)
				local id = event.eventID
				Octo_ToDo_DB_Other.Holiday[id] = Octo_ToDo_DB_Other.Holiday[id] or {}
				Octo_ToDo_DB_Other.Holiday[id].title = event.title -- E.func_EventName(id)
				local startTime = event.startTime
				local endTime = event.endTime
				local startTime_year = startTime.year
				local startTime_month = startTime.month
				local startTime_monthDay = startTime.monthDay
				local endTime_year = endTime.year
				local endTime_month = endTime.month
				local endTime_monthDay = endTime.monthDay
				local dateTbl_startTime = {
					year = startTime.year,
					month = startTime.month,
					day = startTime.monthDay,
					hour = startTime.hour,
					min = startTime.minute,
					-- sec = 0,
				}
				local dateTbl_endTime = {
					year = endTime.year,
					month = endTime.month,
					day = endTime.monthDay,
					hour = endTime.hour,
					min = endTime.minute,
					-- sec = 0,
				}
				local event_duration = E.FriendsFrame_GetLastOnline(time(dateTbl_endTime)-time(dateTbl_startTime), true)
				Octo_ToDo_DB_Other.Holiday[id].event_duration = event_duration
				Octo_ToDo_DB_Other.Holiday[id].startTime = E:func_fixdate(startTime_monthDay).."/"..E:func_fixdate(startTime_month) -- .."/"..startTime_year
				Octo_ToDo_DB_Other.Holiday[id].endTime = E:func_fixdate(endTime_monthDay).."/"..E:func_fixdate(endTime_month) -- .."/"..endTime_year
				-- Octo_ToDo_DB_Other.Holiday[id].Active = Octo_ToDo_DB_Other.Holiday[id].Active or nil
				-- Octo_ToDo_DB_Other.Holiday[id].Possible = Octo_ToDo_DB_Other.Holiday[id].Possible or nil
				-- Octo_ToDo_DB_Other.Holiday[id].iconTexture = event.iconTexture or ""
				Octo_ToDo_DB_Other.Holiday[id].ENDS = E.func_SecondsToClock(time(dateTbl_endTime)-GetServerTime(), true)
				if eInfo then
					Octo_ToDo_DB_Other.Holiday[id].iconTexture = eInfo.texture or E.Icon_QuestionMark
				else
					Octo_ToDo_DB_Other.Holiday[id].iconTexture = event.iconTexture or E.Icon_QuestionMark
					Octo_ToDo_DB_Other.Holiday[id].ENDS = event_duration
				end
				Octo_ToDo_DB_Other.Holiday[id].invitedBy = event.invitedBy
				if not Octo_ToDo_DB_Other.Holiday[id].priority then
					Octo_ToDo_DB_Other.Holiday[id].priority = priority
					priority = priority + 1
				end
				if day == monthDay then
					if event.sequenceType == "START" then
						local secondsToEvent = ((event.startTime.hour - hour) * 60 + event.startTime.minute - minute) * 60
						if secondsToEvent <= 0 then
							Octo_ToDo_DB_Other.ActiveHoliday[id] = true
							Octo_ToDo_DB_Other.Holiday[id].Active = true
						else
							Octo_ToDo_DB_Other.Holiday[id].Possible = true
						end
					elseif event.sequenceType == "END" then
						local secondsToEvent = ((event.endTime.hour - hour) * 60 + event.endTime.minute - minute) * 60
						if secondsToEvent > 0 then
							Octo_ToDo_DB_Other.ActiveHoliday[id] = true
							Octo_ToDo_DB_Other.Holiday[id].Active = true
						end
					else
						Octo_ToDo_DB_Other.ActiveHoliday[id] = true
						Octo_ToDo_DB_Other.Holiday[id].Active = true
					end
				elseif monthDay < day then
					Octo_ToDo_DB_Other.Holiday[id].Possible = true
				end
			end
		end
		function_restoreBackup()
	end
end
function E.Collect_All_BfA_Azerite()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if azeriteItemLocation then
			local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
			local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
			if totalLevelXP and totalLevelXP ~= 0 then
				collectPlayerData.azeriteLVL = currentLevel
				collectPlayerData.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E.func_CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
function E.Collect_All_BfA_Cloaklvl()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local hasItem = E.func_GetItemCount(169223, true, true, true, false)
		if hasItem ~= 0 then
			local itemLink = GetInventoryItemLink("player", 15)
			if itemLink then
				local itemID = itemLink:match("item:(%d+)")
				if itemID == "169223" then
					local itemLevel = select(4, E.func_GetItemInfo(itemLink))
					if itemLevel then
						collectPlayerData.cloak_lvl = min(15, max((itemLevel - 125) / 2 + 1, 1))
					end
				end
			end
			if itemLink and itemLink:find("item:169223:") then
				OctpToDo_inspectScantip:SetInventoryItem("player", 15)
				if OctpToDo_inspectScantip:NumLines() > 0 then
					for j = 2, OctpToDo_inspectScantip:NumLines() do
						local text = _G["OctoScanningTooltipFIRSTTextLeft"..j]:GetText()
						if text and text ~= "" then
							local res = text:gsub("[, ]", ""):gsub("(%d+)[ ]+(%d+)", "%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")
							if res then
								collectPlayerData.cloak_res = res
								break
							end
						end
					end
				end
				OctpToDo_inspectScantip:ClearLines()
			end
		else
			collectPlayerData.cloak_lvl = nil
			collectPlayerData.cloak_res = nil
		end
	end
end
function E.Collect_All_BfA_Island()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if collectPlayerData and not InCombatLockdown() then
		local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
		if questID then
			if E.func_CheckCompletedByQuestID(questID) ~= E.NONE then
				collectMASLENGO.islandBfA = E.func_CheckCompletedByQuestID(questID)
			end
		end
	end
end
function E.Collect_All_Chromie()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
		if C_PlayerInfo.IsPlayerInChromieTime() then
			collectPlayerData.Chromie_inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
		else
			collectPlayerData.Chromie_inChromieTime = nil
		end
		if C_PlayerInfo.CanPlayerEnterChromieTime() then
			collectPlayerData.Chromie_canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
		else
			collectPlayerData.Chromie_canEnter = nil
		end
		if E.GameLimitedMode_IsActive then
			collectPlayerData.GameLimitedMode_IsActive = E.GameLimitedMode_IsActive
		else
			collectPlayerData.GameLimitedMode_IsActive = nil
		end


		local UnitChromieTimeID = UnitChromieTimeID("player")
		if UnitChromieTimeID ~= 0 then
			collectPlayerData.Chromie_UnitChromieTimeID = UnitChromieTimeID
			for i = 1, #expansionOptions do
				if expansionOptions[i].id == UnitChromieTimeID then
					local expansionChromie = expansionOptions[i].name
					collectPlayerData.Chromie_name = tostring(expansionChromie)
				end
			end
		else
			collectPlayerData.Chromie_UnitChromieTimeID = nil
			collectPlayerData.Chromie_name = nil
		end


	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"TIME_PLAYED_MSG",
	"PLAYER_LEAVING_WORLD",
	"ACCOUNT_MONEY",
	"AZERITE_ITEM_EXPERIENCE_CHANGED",
	"BAG_UPDATE",
	"COVENANT_CHOSEN",
	"COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED",
	"CURRENCY_DISPLAY_UPDATE",
	"CURRENCY_TRANSFER_LOG_UPDATE",
	"ENCOUNTER_END",
	"HEARTHSTONE_BOUND",
	"MAIL_INBOX_UPDATE",
	"MAIL_SHOW",
	"PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
	"PLAYER_DEAD",
	-- "PLAYER_ENTERING_WORLD",
	"PLAYER_EQUIPMENT_CHANGED",
	"PLAYER_LEVEL_UP",
	"PLAYER_MONEY",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_SPECIALIZATION_CHANGED",
	"PLAYER_XP_UPDATE",
	"QUEST_LOG_UPDATE",
	"QUEST_POI_UPDATE",
	"SKILL_LINES_CHANGED",
	"SPELLS_CHANGED",
	"TRADE_SKILL_SHOW",
	"UPDATE_INSTANCE_INFO",
	"UPDATE_INVENTORY_DURABILITY",
	"UPDATE_PENDING_MAIL",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA"
}
function E.Collect_All_Table(event)
	E.Collect_All_PlayerLevel()
	E.Collect_All_ItemLevel()
	E.Collect_All_PlayerDurability()
	E.Collect_All_Holiday()
end
----------------------------------------------------------------
E.RegisterMyEventsToFrames(Octo_EventFrame_Collect, MyEventsTable, E.func_DebugPath())
function Octo_EventFrame_Collect:ADDON_LOADED()
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function Octo_EventFrame_Collect:PLAYER_LOGIN()
	RequestTimePlayed()
	RequestRaidInfo()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	E.LoadOctoUIforAddons()
	E.Collect_All_MoneyOnLogin()
	-- Персонаж и прогресс
	E.Collect_All_PlayerInfo() -- общая информация о персонаже
	E.Collect_All_PlayerLevel() -- уровень персонажа
	E.Collect_All_ItemLevel() -- уровень предметов
	E.Collect_All_PlayerDurability() -- прочность экипировки
	E.Collect_All_Professions() -- профессии
	E.Collect_All_Reputations() -- репутации
	E.Collect_All_Quests() -- квесты
	E.Collect_All_UNIVERSALQuestUpdate() -- обновления квестов
	-- Предметы и валюта
	E.Collect_All_ItemsInBag() -- предметы в сумках
	E.Collect_All_Currency() -- валюта
	E.Collect_All_MoneyOnLogin() -- деньги при входе
	E.Collect_All_MoneyUpdate() -- обновление денег
	E.Collect_All_Mail() -- почта
	-- Локации и активность
	E.Collect_All_Locations() -- местоположение
	E.Collect_All_JournalInstance() -- информация о подземельях/рейдах
	E.Collect_All_WarMode() -- режим войны
	E.Collect_All_Chromie() -- хроми
	E.Collect_All_BfA_Island() -- острова Battle for Azeroth
	-- Системные и служебные данные
	E.Collect_All_LoginTime() -- время входа (УБРАТЬ?)
	E.Collect_All_ReloadCount() -- счётчик перезагрузок UI
	E.Collect_All_Holiday() -- праздничные события
	-- Особые системы (BfA, Shadowlands и др.)
	E.Collect_All_BfA_Azerite() -- азерит, Battle for Azeroth
	E.Collect_All_BfA_Cloaklvl() -- уровень плаща, BfA
	E.Collect_All_Covenant() -- ковенанты, Shadowlands
	E.Collect_All_GreatVault() -- Великое Хранилище
	E.Update("PLAYER_LOGIN")
end
function Octo_EventFrame_Collect:SKILL_LINES_CHANGED()
	if InCombatLockdown() or self.SKILL_LINES_CHANGED_pause then return end
	self.SKILL_LINES_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Professions()
			E.Update("SKILL_LINES_CHANGED")
			self.SKILL_LINES_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:TRADE_SKILL_SHOW()
	if InCombatLockdown() or self.TRADE_SKILL_SHOW_Pause then return end
	self.TRADE_SKILL_SHOW_Pause = true
	C_Timer.After(1, function()
			E.Collect_All_Professions()
			E.Update("TRADE_SKILL_SHOW")
			self.SKILL_LINES_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_XP_UPDATE()
	if InCombatLockdown() or UnitLevel("player") == MAX_PLAYER_LEVEL or self.PLAYER_XP_UPDATE_pause then return end
	self.PLAYER_XP_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerLevel()
			E.Update("PLAYER_XP_UPDATE")
			self.PLAYER_XP_UPDATE_pause = nil
	end)
end
function Octo_EventFrame_Collect:PLAYER_LEVEL_UP()
	if InCombatLockdown() or self.PLAYER_LEVEL_UP_Pause then return end
	self.PLAYER_LEVEL_UP_Pause = true
	C_Timer.After(1, function()
			RequestTimePlayed()
			E.Collect_All_PlayerLevel()
			E.Update("PLAYER_LEVEL_UP")
			self.PLAYER_LEVEL_UP_Pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:QUEST_LOG_UPDATE()
	if InCombatLockdown() or self.QUEST_LOG_UPDATE_Pause then return end
	self.QUEST_LOG_UPDATE_Pause = true
	C_Timer.After(1, function()
			E.Collect_All_Quests()
			E.Collect_All_UNIVERSALQuestUpdate()
			E.Collect_All_BfA_Island()
			E.Collect_All_Chromie()
			E.Update("QUEST_LOG_UPDATE")
			self.QUEST_LOG_UPDATE_Pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:BAG_UPDATE()
	if InCombatLockdown() or self.BAG_UPDATE_pause then return end
	self.BAG_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemsInBag()
			E.Update("BAG_UPDATE")
			self.BAG_UPDATE_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if InCombatLockdown() or self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause then return end
	self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemsInBag()
			E.Update("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
			self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_MONEY()
	if InCombatLockdown() or self.PLAYER_MONEY_pause then return end
	self.PLAYER_MONEY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_MoneyUpdate()
			E.Update("PLAYER_MONEY")
			self.PLAYER_MONEY_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ACCOUNT_MONEY()
	if InCombatLockdown() or self.ACCOUNT_MONEY_pause then return end
	self.ACCOUNT_MONEY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_MoneyUpdate()
			E.Update("ACCOUNT_MONEY")
			self.ACCOUNT_MONEY_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:CURRENCY_DISPLAY_UPDATE()
	if InCombatLockdown() or self.CURRENCY_DISPLAY_UPDATE_pause then return end
	self.CURRENCY_DISPLAY_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Currency()
			E.Collect_All_Covenant()
			E.Update("CURRENCY_DISPLAY_UPDATE")
			self.CURRENCY_DISPLAY_UPDATE_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:CURRENCY_TRANSFER_LOG_UPDATE()
	if InCombatLockdown() or self.CURRENCY_TRANSFER_LOG_UPDATE_pause then return end
	self.CURRENCY_TRANSFER_LOG_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Currency()
			E.Collect_All_Covenant()
			E.Update("CURRENCY_TRANSFER_LOG_UPDATE")
			self.CURRENCY_TRANSFER_LOG_UPDATE_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_EQUIPMENT_CHANGED()
	if InCombatLockdown() or self.PLAYER_EQUIPMENT_CHANGED_pause then return end
	self.PLAYER_EQUIPMENT_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemLevel()
			E.Update("PLAYER_EQUIPMENT_CHANGED")
			self.PLAYER_EQUIPMENT_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_LEAVING_WORLD()
	if not InCombatLockdown() then return end
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	self.PLAYER_LEAVING_WORLD = nil
	E.Collect_All_GreatVault()
	E.Collect_All_LoginTime()
end
function Octo_EventFrame_Collect:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if InCombatLockdown() or self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause then return end
	self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_BfA_Azerite()
			E.Collect_All_BfA_Cloaklvl()
			E.Update("AZERITE_ITEM_EXPERIENCE_CHANGED")
			self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:COVENANT_CHOSEN()
	if InCombatLockdown() or self.COVENANT_CHOSEN_pause then return end
	self.COVENANT_CHOSEN_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Covenant()
			E.Update("COVENANT_CHOSEN")
			self.COVENANT_CHOSEN_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	if InCombatLockdown() or self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause then return end
	self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Covenant()
			E.Update("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
			self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_DEAD()
	if InCombatLockdown() or self.PLAYER_DEAD_pause then return end
	self.PLAYER_DEAD_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerDurability()
			E.Update("PLAYER_DEAD")
			self.PLAYER_DEAD_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_INVENTORY_DURABILITY()
	if InCombatLockdown() or self.UPDATE_INVENTORY_DURABILITY_pause then return end
	self.UPDATE_INVENTORY_DURABILITY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerDurability()
			E.Update("UPDATE_INVENTORY_DURABILITY")
			self.UPDATE_INVENTORY_DURABILITY_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_SPECIALIZATION_CHANGED()
	if InCombatLockdown() or self.PLAYER_SPECIALIZATION_CHANGED_pause then return end
	self.PLAYER_SPECIALIZATION_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerInfo()
			E.Update("PLAYER_SPECIALIZATION_CHANGED")
			self.PLAYER_SPECIALIZATION_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:HEARTHSTONE_BOUND()
	if InCombatLockdown() or self.HEARTHSTONE_BOUND_pause then return end
	self.HEARTHSTONE_BOUND_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E.Update("HEARTHSTONE_BOUND")
			self.HEARTHSTONE_BOUND_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ZONE_CHANGED()
	if InCombatLockdown() or self.ZONE_CHANGED_pause then return end
	self.ZONE_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E.Update("ZONE_CHANGED")
			self.ZONE_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ZONE_CHANGED_NEW_AREA()
	if InCombatLockdown() or self.ZONE_CHANGED_NEW_AREA_pause then return end
	self.ZONE_CHANGED_NEW_AREA_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E.Update("ZONE_CHANGED_NEW_AREA")
			self.ZONE_CHANGED_NEW_AREA_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:SPELLS_CHANGED()
	if InCombatLockdown() or self.SPELLS_CHANGED_pause then return end
	self.SPELLS_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_WarMode()
			E.Update("SPELLS_CHANGED")
			self.SPELLS_CHANGED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:MAIL_INBOX_UPDATE()
	if InCombatLockdown() or self.MAIL_INBOX_UPDATE_pause then return end
	self.MAIL_INBOX_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E.Update("MAIL_INBOX_UPDATE")
			self.MAIL_INBOX_UPDATE_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:MAIL_SHOW()
	if InCombatLockdown() or self.MAIL_SHOW_pause then return end
	self.MAIL_SHOW_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E.Update("MAIL_SHOW")
			self.MAIL_SHOW_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_PENDING_MAIL()
	if InCombatLockdown() or self.UPDATE_PENDING_MAIL_pause then return end
	self.UPDATE_PENDING_MAIL_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E.Update("UPDATE_PENDING_MAIL")
			self.UPDATE_PENDING_MAIL_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_REGEN_ENABLED()
	if InCombatLockdown() or self.PLAYER_REGEN_ENABLED_pause then return end
	self.PLAYER_REGEN_ENABLED_pause = true
	C_Timer.After(5, function()
			E.Collect_All_Quests()
			E.Collect_All_UNIVERSALQuestUpdate()
			E.Collect_All_BfA_Island()
			E.Collect_All_Reputations()
			E.Collect_All_Currency()
			E.Update("PLAYER_REGEN_ENABLED")
			self.PLAYER_REGEN_ENABLED_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ENCOUNTER_END()
	if InCombatLockdown() or self.ENCOUNTER_END_pause then return end
	self.ENCOUNTER_END_pause = true
	C_Timer.After(1, function()
			E.Collect_All_JournalInstance()
			E.Update("ENCOUNTER_END")
			self.ENCOUNTER_END_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_INSTANCE_INFO()
	if InCombatLockdown() or self.UPDATE_INSTANCE_INFO_pause then return end
	self.UPDATE_INSTANCE_INFO_pause = true
	C_Timer.After(1, function()
			E.Collect_All_JournalInstance()
			E.Update("UPDATE_INSTANCE_INFO")
			self.UPDATE_INSTANCE_INFO_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:TIME_PLAYED_MSG(...)
	if InCombatLockdown() then return end
	E.Collect_All_Played(...)
	E.Update("TIME_PLAYED_MSG")
end
function Octo_EventFrame_Collect:QUEST_POI_UPDATE()
	if InCombatLockdown() or self.QUEST_POI_UPDATE_pause then return end
	self.QUEST_POI_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Chromie()
			E.Update("QUEST_POI_UPDATE")
			self.QUEST_POI_UPDATE_pause = nil  -- Используем nil вместо false для экономии памяти
	end)
end