local GlobalAddonName, E = ...
local OctoToDo_EventFrame_Collect = CreateFrame("FRAME")
OctoToDo_EventFrame_Collect:Hide()
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
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
----------------------------------------------------------------
function E.Collect_ALL_PlayerInfo()
	if OctoToDo_TrashCan then
		OctoToDo_TrashCan.profileKeys = OctoToDo_TrashCan.profileKeys or {}
		OctoToDo_TrashCan.profileKeys[E.curCharName.." - ".. E.curServer] = OctoToDo_TrashCan.profileKeys[E.curCharName.." - ".. E.curServer] or "OctoUI"
	end
	if E.isElvUI and ElvDB and ElvPrivateDB then
		if ElvDB.profileKeys[E.curCharName.." - ".. E.curServer] ~= "OctoUI" then
			ElvDB.profileKeys[E.curCharName.." - ".. E.curServer] = "OctoUI"
			DEFAULT_CHAT_FRAME:AddMessage("ElvDB: "..E.Green_Color.."done|r")
		end
		if ElvPrivateDB.profileKeys[E.curCharName.." - ".. E.curServer] ~= "PRIVATEPROFILE" then
			ElvPrivateDB.profileKeys[E.curCharName.." - ".. E.curServer] = "PRIVATEPROFILE"
			DEFAULT_CHAT_FRAME:AddMessage("ElvPrivateDB: "..E.Green_Color.."done|r")
		end
	end
	if E.isPlater and PlaterDB then
		if PlaterDB.profileKeys[E.curCharName.." - ".. E.curServer] ~= "OctoUI" then
			PlaterDB.profileKeys[E.curCharName.." - ".. E.curServer] = "OctoUI"
			DEFAULT_CHAT_FRAME:AddMessage("PlaterDB: "..E.Green_Color.."done|r")
		end
	end
	if E.isOmniCD and OmniCDDB then
		if OmniCDDB.profileKeys[E.curCharName.." - ".. E.curServer] ~= "OctoUI" then
			OmniCDDB.profileKeys[E.curCharName.." - ".. E.curServer] = "OctoUI"
			DEFAULT_CHAT_FRAME:AddMessage("OmniCDDB: "..E.Green_Color.."done|r")
		end
	end
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local curServerShort = E.func_CurServerShort(E.curServer)
		local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
		local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
		---- 
		collect.curServerShort = curServerShort
		collect.Name = E.curCharName
		collect.curServer = E.curServer
		collect.className = E.className
		collect.classFilename = E.classFilename
		collect.classId = E.classId
		collect.GUID = E.curGUID
		collect.Faction = E.func_UnitFaction("PLAYER")
		collect.specId = specId or 0
		collect.specName = specName or ""
		collect.specIcon = specIcon or 0
		collect.classColor = E.classColor
		collect.RaceLocal = RaceLocal
		collect.RaceEnglish = RaceEnglish
		collect.raceID = raceID
		collect.classColorHex = E.classColorHexCurrent
		collect.guildName = guildName
		collect.guildRankName = guildRankName
		collect.guildRankIndex = guildRankIndex
		collect.BattleTag = E.BattleTag
		collect.BattleTagLocal = E.BattleTagLocal
		collect.buildVersion = E.buildVersion
		collect.buildNumber = E.buildNumber
		collect.buildDate = E.buildDate
		collect.interfaceVersion = E.interfaceVersion
		collect.currentTier = E.currentTier
		collect.IsPublicBuild = E.IsPublicBuild
		collect.GetRestrictedAccountData_rLevel = E.GetRestrictedAccountData_rLevel
		collect.GetRestrictedAccountData_rMoney = E.GetRestrictedAccountData_rMoney
		collect.GetRestrictedAccountData_profCap = E.GetRestrictedAccountData_profCap
		collect.IsAccountSecured = E.IsAccountSecured
		collect.IsRestrictedAccount = E.IsRestrictedAccount
		collect.IsTrialAccount = E.IsTrialAccount
		collect.IsVeteranTrialAccount = E.IsVeteranTrialAccount
	end
end
function E.Collect_All_ReloadCount()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect then
		collect.ReloadCount = collect.ReloadCount+1
	end
end
function E.Collect_All_Covenant()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local curCovID = C_Covenants.GetActiveCovenantID() or 0
		if curCovID > 0 then
			local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
			local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
			local curAnimaAmount = currencyInfo.quantity
			collect.CovenantAndAnima.curCovID = curCovID
			collect.CovenantAndAnima = collect.CovenantAndAnima or {}
			collect.CovenantAndAnima[curCovID][1] = curCovLevel
			collect.CovenantAndAnima[curCovID][2] = curAnimaAmount
		end
	end
end
function E.Collect_All_PlayerDurability()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
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
		collect.PlayerDurability = E.func_CompactNumberSimple(totalDurability)
	end
end
function E.Collect_ALL_Player_Level()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local UnitLevel = UnitLevel("PLAYER") or 0
		local currentXP = UnitXP("PLAYER") or 0
		local UnitXPMax = UnitXPMax("PLAYER") or 0
		local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
		collect.UnitLevel = UnitLevel
		collect.currentXP = currentXP
		collect.UnitXPMax = UnitXPMax
		collect.UnitXPPercent = UnitXPPercent
		if UnitLevel == E.currentMaxLevel then
			collect.PlayerCanEarnExperience = false
		else
			if E.GameLimitedMode_IsActive == true then
				if UnitLevel >= E.GetRestrictedAccountData_rLevel then
					-- if MainStatusTrackingBarContainer and MainStatusTrackingBarContainer:IsShown() then
					--     tinsert(E.OctoTable_MustBeHiddenFrames_table, {name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer})
					-- end
					collect.levelCapped20 = true
					collect.PlayerCanEarnExperience = false
				else
					collect.levelCapped20 = false
					collect.PlayerCanEarnExperience = true
				end
			end
		end
	end
end
function E.Collect_ALL_Played(totalTime, currentLevelTime)
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		collect.realTotalTime = totalTime
		collect.realLevelTime = currentLevelTime
	end
end
function E.Collect_ALL_WarMode()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local WarMode = C_PvP.IsWarModeDesired()
		collect.WarMode = WarMode
	end
end
function E.Collect_ALL_Mail()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local hasMail = HasNewMail()
		collect.hasMail = hasMail
	end
end
function E.Collect_ALL_LoginTime()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		collect.loginDate = date("%d.%m.%Y %H:%M:%S")
		collect.loginDay = date("%d.%m.%Y")
		collect.loginHour = date("%H:%M")
		collect.needResetWeekly = false
		collect.needResetDaily = false
		collect.needResetMonth = false
		collect.time = time()
	end
end
function E.Collect_All_Professions()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		collect.MASLENGO = collect.MASLENGO or {}
		collect.MASLENGO.professions = collect.MASLENGO.professions or {}
		for i, id in ipairs({GetProfessions()}) do
			collect.MASLENGO.professions[i] = collect.MASLENGO.professions[i] or {}
			local _, _, skillLevel, maxSkillLevel, _, _, skillLine = GetProfessionInfo(id)
			collect.MASLENGO.professions[i].name = E.func_ProfessionName(skillLine)
			collect.MASLENGO.professions[i].skillLine = skillLine
			collect.MASLENGO.professions[i].skillLevel = skillLevel
			collect.MASLENGO.professions[i].maxSkillLevel = maxSkillLevel
			-- collect.MASLENGO.professions[i].ALT = nil
			-- /dump C_TradeSkillUI.GetProfessionInfoBySkillLineID(2548).parentProfessionID
			for index, skillLineID in ipairs(C_TradeSkillUI.GetAllProfessionTradeSkillLines()) do
				collect.MASLENGO.professions.ALL = collect.MASLENGO.professions.ALL or {}
				collect.MASLENGO.professions.ALL[skillLineID] = E.func_ProfessionName(skillLineID)
				local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
				local QWEprofessionID = info.professionID
				local QWEsourceCounter = info.sourceCounter
				local QWEprofessionName = info.professionName
				local QWEexpansionName = info.expansionName
				local QWEskillLevel = info.skillLevel
				local QWEmaxSkillLevel = info.maxSkillLevel
				local QWEskillModifier = info.skillModifier
				local QWEisPrimaryProfession = info.isPrimaryProfession
				local QWEparentProfessionID = info.parentProfessionID
				local QWEparentProfessionName = info.parentProfessionName
				if skillLine == QWEparentProfessionID then
					collect.MASLENGO.professions[i][QWEprofessionID] = nil
					collect.MASLENGO.professions[i].ALT = collect.MASLENGO.professions[i].ALT or {}
					collect.MASLENGO.professions[i].ALT[QWEprofessionID] = collect.MASLENGO.professions[i].ALT[QWEprofessionID] or {}
					collect.MASLENGO.professions[i].ALT[QWEprofessionID].name = E.func_ProfessionName(QWEprofessionID)
					collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEexpansionName = QWEexpansionName
					collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEskillLevel = QWEskillLevel
					collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEmaxSkillLevel = QWEmaxSkillLevel
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEprofessionID = QWEprofessionID
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEsourceCounter = QWEsourceCounter
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEprofessionName = QWEprofessionName
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEskillModifier = QWEskillModifier
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEisPrimaryProfession = QWEisPrimaryProfession
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEparentProfessionID = QWEparentProfessionID
					-- collect.MASLENGO.professions[i].ALT[QWEprofessionID].QWEparentProfessionName = QWEparentProfessionName
				end
			end
			-- if i ~= 2 then
			-- 	collect.MASLENGO.professions[2] = {}
			-- 	collect.MASLENGO.professions[2] = collect.MASLENGO.professions[2] or {}
			-- 	print ("АЙ РАВНО НИЛ")
			-- end
		end
	end
end
function E.Collect_ALL_GreatVault()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
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
		collect.RIO_Score_TWW_S2 = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
		collect.RIO_weeklyBest_TWW_S1 = currentWeekBestLevel
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
					if collect and tip ~= nil then
						collect.GreatVault[tip] = collect.GreatVault[tip] or {}
						collect.GreatVault[tip].type = activity_name
						collect.GreatVault[tip].progress = activityInfo.progress
						collect.GreatVault[tip].threshold = activityInfo.threshold
						local hyperlink = E.func_GetItemCurrentLevel(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						hyperlink_STRING = E.func_GetItemCurrentLevel(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
						if hyperlink_STRING then
							vivod = vivod and vivod..", "..hyperlink_STRING or hyperlink_STRING
							if vivod ~= nil then
								collect.GreatVault[tip].hyperlink_STRING = vivod
							end
						end
					end
				end
			end
		end
	end
end
function E.Collect_All_Currency_TEST2()
	OCTO_DB_currencies_test = OCTO_DB_currencies_test or {}
	local expanded = {}
	for index = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader and not info.isHeaderExpanded and ExpandCurrencyList then
			ExpandCurrencyList(index, true)
			expanded[info.name] = true
		end
	end
	local tblHeader
	for index = 1, C_CurrencyInfo.GetCurrencyListSize() do
		local link = C_CurrencyInfo.GetCurrencyListLink(index)
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader then
			OCTO_DB_currencies_test[info.name] = OCTO_DB_currencies_test[info.name] or {}
			tblHeader = OCTO_DB_currencies_test[info.name]
		elseif link then
			local currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(link)
			tblHeader[currencyID] = tblHeader[currencyID] or false
		end
	end
	for index = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader and expanded[info.name] and ExpandCurrencyList then
			ExpandCurrencyList(index, false)
		end
	end
end
function E.Collect_All_Currency()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local listSize = C_CurrencyInfo.GetCurrencyListSize()
		local headerIndex
		for i = 1, listSize do
			local info = C_CurrencyInfo.GetCurrencyListInfo(i)
			if info and info.isHeader then
				C_CurrencyInfo.ExpandCurrencyList(i, true)
				listSize = C_CurrencyInfo.GetCurrencyListSize()
				headerIndex = i
			elseif info and info.name then
				local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
				local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
				if currencyID then
					OctoToDo_DB_Config.CurrencyDB[currencyID] = OctoToDo_DB_Config.CurrencyDB[currencyID] or false
				end
			end
		end
		for CurrencyID, v in next, (OctoToDo_DB_Config.CurrencyDB) do
			local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(CurrencyID) or false
			local data = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
			if data then
				local quantity = data.quantity
				local maxQuantity = data.maxQuantity
				local totalEarned = data.totalEarned
				if isAccountWideCurrency == false then
					if collect.MASLENGO and not InCombatLockdown() then
						if type(collect.MASLENGO.CurrencyID) == "number" then
							collect.MASLENGO.CurrencyID = {}
						end
						collect.MASLENGO.CurrencyID = collect.MASLENGO.CurrencyID or {}
						if type(collect.MASLENGO.CurrencyID_totalEarned) == "number" then
							collect.MASLENGO.CurrencyID_totalEarned = {}
						end
						collect.MASLENGO.CurrencyID_totalEarned = collect.MASLENGO.CurrencyID_totalEarned or {}
						if type(collect.MASLENGO.CurrencyID_Total) == "number" then
							collect.MASLENGO.CurrencyID_Total = {}
						end
						collect.MASLENGO.CurrencyID_Total = collect.MASLENGO.CurrencyID_Total or {}
						if quantity then
							collect.MASLENGO.CurrencyID[CurrencyID] = quantity
						end
						if totalEarned then
							collect.MASLENGO.CurrencyID_totalEarned[CurrencyID] = totalEarned
						end
						if maxQuantity ~= 0 then
							if quantity ~= maxQuantity then
								collect.MASLENGO.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
							else
								collect.MASLENGO.CurrencyID_Total[CurrencyID] = E.Green_Color..quantity.."/"..maxQuantity.."|r"
							end
						else
							collect.MASLENGO.CurrencyID_Total[CurrencyID] = quantity
						end
					end
				else
					for GUID, tbl in next, (OctoToDo_DB_Levels) do
						tbl.MASLENGO = tbl.MASLENGO or {}
						tbl.MASLENGO.CurrencyID = tbl.MASLENGO.CurrencyID or {}
						tbl.MASLENGO.CurrencyID_totalEarned = tbl.MASLENGO.CurrencyID_totalEarned or {}
						tbl.MASLENGO.CurrencyID_Total = tbl.MASLENGO.CurrencyID_Total or {}
						if tbl and not InCombatLockdown() then
							if type(tbl.MASLENGO.CurrencyID) == "number" then
								tbl.MASLENGO.CurrencyID = {}
							end
							tbl.MASLENGO.CurrencyID = tbl.MASLENGO.CurrencyID or {}
							if type(tbl.MASLENGO.CurrencyID_totalEarned) == "number" then
								tbl.MASLENGO.CurrencyID_totalEarned = {}
							end
							tbl.MASLENGO.CurrencyID_totalEarned = tbl.MASLENGO.CurrencyID_totalEarned or {}
							if type(tbl.MASLENGO.CurrencyID_Total) == "number" then
								tbl.MASLENGO.CurrencyID_Total = {}
							end
							tbl.MASLENGO.CurrencyID_Total = tbl.MASLENGO.CurrencyID_Total or {}
							if quantity then
								tbl.MASLENGO.CurrencyID[CurrencyID] = quantity
							end
							if totalEarned then
								tbl.MASLENGO.CurrencyID_totalEarned[CurrencyID] = totalEarned
							end
							if maxQuantity ~= 0 then
								if quantity ~= maxQuantity then
									tbl.MASLENGO.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
								else
									tbl.MASLENGO.CurrencyID_Total[CurrencyID] = E.Green_Color..quantity.."/"..maxQuantity.."|r"
								end
							else
								tbl.MASLENGO.CurrencyID_Total[CurrencyID] = quantity
							end
						end
					end
				end
			else
				collect.MASLENGO.CurrencyID[CurrencyID] = 0
				collect.MASLENGO.CurrencyID_Total[CurrencyID] = 0
				collect.MASLENGO.CurrencyID_totalEarned[CurrencyID] = 0
			end
		end
	end
end

function E.Collect_All_Reputations()
	OCTO_DB_reputations_test = OCTO_DB_reputations_test or {}
	local collect = OctoToDo_DB_Levels[E.curGUID]
	C_Reputation.ExpandAllFactionHeaders()
	if collect and not InCombatLockdown() then
		local tblHeader
		for i = 1, C_Reputation.GetNumFactions() do
			local factionData = C_Reputation.GetFactionDataByIndex(i)
			if factionData then
				local currentStanding = factionData.currentStanding
				local reputationID = factionData.factionID
				local description = factionData.description or ""
				if reputationID and description ~= "" then
					OctoToDo_DB_Config.ReputationDB[reputationID] = OctoToDo_DB_Config.ReputationDB[reputationID] or false
				end
				if factionData.isHeader and currentStanding == 0 then
					OCTO_DB_reputations_test[reputationID] = OCTO_DB_reputations_test[reputationID] or {}
					tblHeader = OCTO_DB_reputations_test[reputationID]
				else
					tblHeader[reputationID] = tblHeader[reputationID] or false
				end
			end
		end
		for reputationID, v in next, (OctoToDo_DB_Config.ReputationDB) do
			if reputationID then
				if C_Reputation.IsAccountWideReputation(reputationID) then
					for GUID, tbl in next, (OctoToDo_DB_Levels) do
						tbl.MASLENGO.reputationID[reputationID] = E.func_CheckReputationByRepID(reputationID)
					end
				else
					collect.MASLENGO.reputationID[reputationID] = E.func_CheckReputationByRepID(reputationID)
				end


			end
		end
	end
end

function E.Collect_ALL_ItemsInBag()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
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
						collect.CurrentKeyLevel = tonumber(lvl)
						collect.CurrentKeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
						for k, v in next, (E.OctoTable_KeystoneAbbr) do
							if v.mapChallengeModeID == tonumber(dungeonID) then
								collect.CurrentKey = lvl.." "..v.abbreviation
							end
						end
					end
					for _, tbl in next, (E.OctoTable_itemID_Cataloged_Research) do
						if itemID == tbl.itemiD then
							Possible_CatalogedResearch = Possible_CatalogedResearch + tbl.count
						end
					end
					local isAnima = E.IsAnimaItemByID(itemID)
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
		OctoToDo_DB_Config = OctoToDo_DB_Config or {}
		collect.MASLENGO = collect.MASLENGO or {}
		collect.MASLENGO.ItemsInBag = collect.MASLENGO.ItemsInBag or {}
		for _, itemID in next, (E.OctoTable_itemID_ALL) do
			local count = E.func_GetItemCount(itemID, true, true, true)
			collect.MASLENGO.ItemsInBag[itemID] = count
		end
		collect.Possible_Anima = Possible_Anima
		collect.Possible_CatalogedResearch = Possible_CatalogedResearch
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
		collect.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	end
end
function E.Collect_ALL_TRASH_EncounterAndZoneLists()
	if OctoToDo_TrashCan then
		local clear = false
		if clear == true then
			OctoToDo_TrashCan.EncounterAndZoneLists = {}
		else
			OctoToDo_TrashCan.EncounterAndZoneLists = OctoToDo_TrashCan.EncounterAndZoneLists or {}
			for tier = 1, EJ_GetNumTiers() do
				EJ_SelectTier(tier)
				local tierName = EJ_GetTierInfo(tier)
				OctoToDo_TrashCan.EncounterAndZoneLists[tierName] = OctoToDo_TrashCan.EncounterAndZoneLists[tierName] or {}
				for _, inRaid in next, ({false, true}) do
					local instance_index = 1
					local instance_id = EJ_GetInstanceByIndex(instance_index, inRaid)
					local title = ("%s"):format(inRaid and RAIDS or DUNGEONS)
					OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title] = OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title] or {}
					while instance_id do
						EJ_SelectInstance(instance_id)
						local instance_name, _, _, _, _, icon, dungeonAreaMapID = EJ_GetInstanceInfo(instance_id)
						OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name] = OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name] or {}
						if dungeonAreaMapID and dungeonAreaMapID ~= 0 then
							local mapGroupId = C_Map.GetMapGroupID(dungeonAreaMapID)
							if mapGroupId then
								OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name].ZoneID = tostringall("g"..mapGroupId)
							else
								OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name].ZoneID = dungeonAreaMapID
							end
							OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name].instance_id = instance_id
							OctoToDo_TrashCan.EncounterAndZoneLists[tierName][title][instance_name].icon = icon
						end
						instance_index = instance_index + 1
						instance_id = EJ_GetInstanceByIndex(instance_index, inRaid)
					end
				end
			end
		end
	end
end
function E.Collect_ALL_Locations()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local curSubZone = GetSubZoneText()
		local curRealZone = GetRealZoneText()
		local curBindLocation = GetBindLocation()
		if curSubZone ~= 0 and curSubZone ~= "" and curRealZone ~= curSubZone then
			curRealZone = curRealZone .. " (".. curSubZone .. ")"
		end
		collect.CurrentLocation = curRealZone
		collect.BindLocation = curBindLocation
	end
end
function E.Collect_All_Quests()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		-- E:func_checkCharInfo()
		local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
		local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
		for questID, v in next, (OctoToDo_DB_Config.QuestsDB) do
			local vivod = E.func_CheckCompletedByQuestID(questID)
			collect.MASLENGO.OctoTable_QuestID[questID] = vivod
		end
		collect.numShownEntries = numShownEntries or 0
		collect.numQuests = E.func_CurrentNumQuests()
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept or 0
	end
	-- local tblHeader
	-- collect.MASLENGO.Quests = {}
	-- for i = 1, numShownEntries do
	--     if E.func_CurrentNumQuests() ~= 0 then
	--         local info = C_QuestLog.GetInfo(i)
	--         if info then
	--             if info.isHeader then
	--                 collect.MASLENGO.Quests[info.title] = collect.MASLENGO.Quests[info.title] or {}
	--                 tblHeader = collect.MASLENGO.Quests[info.title]
	--             else
	--                 tblHeader[info.title] = tblHeader[info.title] or E.func_CheckCompletedByQuestID(info.questID)
	--             end
	--         end
	--     end
	-- end
	-- fpde(collect.MASLENGO.Quests)
end
function E.Collect_ALL_ItemLevel()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function E.Collect_ALL_UNIVERSALQuestUpdate()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		collect.MASLENGO.UniversalQuest = collect.MASLENGO.UniversalQuest or {}
		for i, v in next, (E.OctoTable_UniversalQuest) do
			for _, w in next, (v) do
				local count = 0
				local vivod = E.NONE
				for _, questID in next, (v.questID) do
					if v.max > 1 then
						if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
							count = count + 1
						end
						vivod = count
					else
						local IsComplete = E.func_CheckCompletedByQuestID(questID)
						if IsComplete ~= E.NONE then
							vivod = IsComplete
						end
					end
				end
				if OctoToDo_TrashCan then
					OctoToDo_TrashCan.UniversalQuest[v.desc] = OctoToDo_TrashCan.UniversalQuest[v.desc] or {}
					OctoToDo_TrashCan.UniversalQuest[v.desc][i] = OctoToDo_TrashCan.UniversalQuest[v.desc][i] or tostringall("CharInfo.MASLENGO.UniversalQuest.".."Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset)
				end
				if v.max == 1 then
					collect.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = vivod
				elseif v.max > 1 then
					if vivod == v.max and v.max > 1 then
						collect.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = E.DONE
					else
						collect.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = vivod.."/"..v.max
					end
				end
			end
		end
	end
end
function E.Collect_ALL_MoneyUpdate()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		collect.Money = GetMoney() or 0
		OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] = C_Bank.FetchDepositedMoney(2)
	end
end
function E.Collect_ALL_MoneyOnLogin()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local Money = GetMoney()
		collect.MoneyOnLogin = Money
	end
end
function E.Collect_All_journalInstance()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		-- if ((GetNumSavedInstances() + GetNumSavedWorldBosses() > 0) and not RaidInfoFrame:IsVisible()) then
		-- 	ToggleRaidFrame()
		-- 	RaidInfoFrame:Show()
		-- end
		-- if (not RaidFrame:IsVisible()) then
		-- 	ToggleRaidFrame()
		-- end
		-- if RaidFrame:IsVisible() then
		-- 	HideUIPanel(RaidFrame)
		-- end
		-- if FriendsFrame:IsVisible() then
		-- 	HideUIPanel(FriendsFrame)
		-- end
		-- if RaidInfoFrame:IsVisible() then
		-- 	HideUIPanel(RaidInfoFrame)
		-- end
		local NumSavedInstances = GetNumSavedInstances()
		local NumSavedWorldBosses = GetNumSavedWorldBosses()
		local DiffAbbr = ""
		local instancesLastBoss = {}
		local ServerTime = GetServerTime()
		if collect.journalInstance == 0 then
			collect.journalInstance = {}
		end
		collect.journalInstance = collect.journalInstance or {}
		if NumSavedInstances > 0 then
			for i = 1, NumSavedInstances do
				local instanceName, lockoutId, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, instanceId = GetSavedInstanceInfo(i)
				collect.journalInstance[instanceId] = collect.journalInstance[instanceId] or {}
				collect.journalInstance[instanceId][instanceDifficulty] = collect.journalInstance[instanceId][instanceDifficulty] or {}
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
					collect.journalInstance[instanceId][instanceDifficulty].instanceName = instanceName
					collect.journalInstance[instanceId][instanceDifficulty].vivod = vivod
					collect.journalInstance[instanceId][instanceDifficulty].instanceReset = instanceReset
					collect.journalInstance[instanceId][instanceDifficulty].difficultyName = difficultyName
					collect.journalInstance[instanceId][instanceDifficulty].instanceDifficulty = instanceDifficulty
					collect.journalInstance[instanceId][instanceDifficulty].extended = extended
					collect.journalInstance[instanceId][instanceDifficulty].instanceIDMostSig = instanceIDMostSig
					collect.journalInstance[instanceId][instanceDifficulty].isRaid = isRaid
					collect.journalInstance[instanceId][instanceDifficulty].maxPlayers = maxPlayers
					collect.journalInstance[instanceId][instanceDifficulty].totalBosses = totalBosses
					collect.journalInstance[instanceId][instanceDifficulty].defeatedBosses = defeatedBosses
					collect.journalInstance[instanceId][instanceDifficulty].extendDisabled = extendDisabled
					collect.journalInstance[instanceId][instanceDifficulty].DiffAbbr = DiffAbbr
					collect.journalInstance[instanceId][instanceDifficulty].Time = E.func_SecondsToClock(instanceReset-ServerTime)
				end
			end
		end
		collect.SavedWorldBoss = collect.SavedWorldBoss or {}
		if NumSavedWorldBosses > 0 then
			for i = 1, NumSavedWorldBosses do
				local name, worldBossID, reset = GetSavedWorldBossInfo(i)
				collect.SavedWorldBoss[worldBossID] = collect.SavedWorldBoss[worldBossID] or {}
				collect.SavedWorldBoss[worldBossID].name = name
				collect.SavedWorldBoss[worldBossID].reset = reset
			end
		end
		for i=1, GetNumRandomDungeons() do
			local dungeonID, name = GetLFGRandomDungeonInfo(i)
			if dungeonID and E.OctoTable_LFGDungeons[dungeonID] then
				local D_name = GetLFGDungeonInfo(dungeonID)
				local donetoday = GetLFGDungeonRewards(dungeonID)
				collect.LFGInstance[dungeonID] = collect.LFGInstance[dungeonID] or {}
				collect.LFGInstance[dungeonID].D_name = D_name
				if donetoday == true then
					collect.LFGInstance[dungeonID].donetoday = E.DONE
				else
					collect.LFGInstance[dungeonID].donetoday = E.NONE
				end
			end
		end
	end
end
function E.Collect_All_Holiday()
	E.HolidayForButton = {}
	wipe(E.HolidayForButton)
	if E.HolidayForButton and not InCombatLockdown() then
		local backup = OctoToDo_DB_Other.CVar
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
				E.HolidayForButton[id] = E.HolidayForButton[id] or {}
				E.HolidayForButton[id].title = event.title -- E.func_EventName(id)
				if OctoToDo_TrashCan then
					OctoToDo_TrashCan.HolidayCollectID = OctoToDo_TrashCan.HolidayCollectID or {}
					-- wipe(OctoToDo_TrashCan.HolidayCollectID)
					OctoToDo_TrashCan.HolidayCollectID[id] = OctoToDo_TrashCan.HolidayCollectID[id] or {}
					OctoToDo_TrashCan.HolidayCollectID[id][locale] = OctoToDo_TrashCan.HolidayCollectID[id][locale] or {}
					OctoToDo_TrashCan.HolidayCollectID[id][locale] = event.title
					OctoToDo_TrashCan.HolidayCollectName = OctoToDo_TrashCan.HolidayCollectName or {}
					-- wipe(OctoToDo_TrashCan.HolidayCollectName)
					OctoToDo_TrashCan.HolidayCollectName[locale] = OctoToDo_TrashCan.HolidayCollectName[locale] or {}
					OctoToDo_TrashCan.HolidayCollectName[locale][event.title] = OctoToDo_TrashCan.HolidayCollectName[locale][event.title] or {}
					OctoToDo_TrashCan.HolidayCollectName[locale][event.title][id] = OctoToDo_TrashCan.HolidayCollectName[locale][event.title][id] or true
				end
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
				E.HolidayForButton[id].event_duration = event_duration
				E.HolidayForButton[id].startTime = E:func_fixdate(startTime_monthDay).."/"..E:func_fixdate(startTime_month) -- .."/"..startTime_year
				E.HolidayForButton[id].endTime = E:func_fixdate(endTime_monthDay).."/"..E:func_fixdate(endTime_month) -- .."/"..endTime_year
				E.HolidayForButton[id].Active = E.HolidayForButton[id].Active or false
				E.HolidayForButton[id].Possible = E.HolidayForButton[id].Possible or false
				-- E.HolidayForButton[id].iconTexture = event.iconTexture or ""
				E.HolidayForButton[id].ENDS = E.func_SecondsToClock(time(dateTbl_endTime)-GetServerTime(), true)
				if eInfo then
					E.HolidayForButton[id].iconTexture = eInfo.texture or E.Icon_QuestionMark
				else
					E.HolidayForButton[id].iconTexture = event.iconTexture or E.Icon_QuestionMark
					E.HolidayForButton[id].ENDS = event_duration
				end
				E.HolidayForButton[id].invitedBy = event.invitedBy
				-- if id == 244009 then
				--     print (event.title, startTime, startTime_monthDay, event_duration)
				-- end
				if not E.HolidayForButton[id].priority then
					E.HolidayForButton[id].priority = priority
					priority = priority + 1
				end
				if day == monthDay then
					if event.sequenceType == "START" then
						local secondsToEvent = ((event.startTime.hour - hour) * 60 + event.startTime.minute - minute) * 60
						if secondsToEvent <= 0 then
							E.HolidayForButton[id].Active = true
						else
							E.HolidayForButton[id].Possible = true
						end
					elseif event.sequenceType == "END" then
						local secondsToEvent = ((event.endTime.hour - hour) * 60 + event.endTime.minute - minute) * 60
						if secondsToEvent > 0 then
							E.HolidayForButton[id].Active = true
						end
					else
						E.HolidayForButton[id].Active = true
					end
				elseif monthDay < day then
					E.HolidayForButton[id].Possible = true
				end
			end
		end
		function_restoreBackup()
	end
end
function E.Collect_All_BfA_Azerite()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if azeriteItemLocation then
			local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
			local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
			if totalLevelXP and totalLevelXP ~= 0 then
				collect.azeriteLVL = currentLevel
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E.func_CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
function E.Collect_All_BfA_Cloaklvl()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local hasItem = E.func_GetItemCount(169223, true, true, true)
		if hasItem ~= 0 then
			local itemLink = GetInventoryItemLink("player", 15)
			if itemLink then
				local itemID = itemLink:match("item:(%d+)")
				if itemID == "169223" then
					local itemLevel = select(4, E.func_GetItemInfo(itemLink))
					if itemLevel then
						if collect and not InCombatLockdown() then
							collect.cloak_lvl = min(15, max((itemLevel - 125) / 2 + 1, 1))
						end
					end
				end
			end
			if itemLink and itemLink:find("item:169223:") then
				OctpToDo_inspectScantip:SetInventoryItem("player", 15)
				if OctpToDo_inspectScantip:NumLines() > 0 then
					for j = 2, OctpToDo_inspectScantip:NumLines() do
						local text = _G["OctoToDoScanningTooltipFIRSTTextLeft"..j]:GetText()
						if text and text ~= "" then
							local res = text:gsub("[, ]", ""):gsub("(%d+)[ ]+(%d+)", "%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")
							if res then
								collect.cloak_res = res
								break
							end
						end
					end
				end
				OctpToDo_inspectScantip:ClearLines()
			end
		else
			collect.cloak_lvl = 0
			collect.cloak_res = 0
		end
	end
end
function E.Collect_All_BfA_Island()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
		if questID then
			collect.islandBfA = E.func_CheckCompletedByQuestID(questID)
		end
	end
end
function E.Collect_All_Chromie()
	local collect = OctoToDo_DB_Levels[E.curGUID]
	if collect and not InCombatLockdown() then
		local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
		collect.Chromie_inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
		collect.Chromie_canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
		collect.Chromie_UnitChromieTimeID = UnitChromieTimeID("player")
		collect.Chromie_name = E.NONE
		collect.GameLimitedMode_IsActive = E.GameLimitedMode_IsActive
		for i = 1, #expansionOptions do
			if expansionOptions[i].id == UnitChromieTimeID("player") then
				local expansionChromie = expansionOptions[i].name
				collect.Chromie_name = tostring(expansionChromie)
			end
		end
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"SKILL_LINES_CHANGED",
	"PLAYER_XP_UPDATE",
	"QUEST_LOG_UPDATE",
	"PLAYER_MONEY",
	"ACCOUNT_MONEY",
	"CURRENCY_DISPLAY_UPDATE",
	"CURRENCY_TRANSFER_LOG_UPDATE",
	"PLAYER_EQUIPMENT_CHANGED",
	"PLAYER_LEAVING_WORLD",
	"AZERITE_ITEM_EXPERIENCE_CHANGED",
	"COVENANT_CHOSEN",
	"COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED",
	"PLAYER_DEAD",
	"UPDATE_INVENTORY_DURABILITY",
	"PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
	"BAG_UPDATE",
	"PLAYER_SPECIALIZATION_CHANGED",
	"HEARTHSTONE_BOUND",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	"SPELLS_CHANGED",
	-- "CALENDAR_UPDATE_EVENT_LIST",
	"MAIL_INBOX_UPDATE",
	"MAIL_SHOW",
	"UPDATE_PENDING_MAIL",
	"PLAYER_REGEN_ENABLED",
	"ENCOUNTER_END",
	"UPDATE_INSTANCE_INFO",
	"TIME_PLAYED_MSG",
	-- "LFG_UPDATE_RANDOM_INFO",
	-- "LFG_COMPLETION_REWARD",
	-- "ENCOUNTER_LOOT_RECEIVED",
	-- "INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	-- "RECEIVED_ACHIEVEMENT_LIST",
	"PLAYER_LEVEL_UP",
	"QUEST_POI_UPDATE",
}
----------------------------------------------------------------
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_Collect, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_Collect:ADDON_LOADED()
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_LOGIN()
	E:func_checkCharInfo()
	RequestTimePlayed()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	E.Collect_All_ReloadCount()
	E.Collect_ALL_PlayerInfo()
	E.Collect_All_Chromie()
	E.Collect_All_Currency()
	E.Collect_All_Currency_TEST2()
	E.Collect_All_Reputations()
	E.Collect_ALL_GreatVault()
	E.Collect_ALL_ItemLevel()
	E.Collect_ALL_ItemsInBag()
	E.Collect_ALL_Locations()
	E.Collect_ALL_LoginTime()
	E.Collect_ALL_Mail()
	E.Collect_ALL_MoneyOnLogin()
	E.Collect_ALL_MoneyUpdate()
	E.Collect_All_Professions()
	E.Collect_All_Quests()
	E.Collect_All_Covenant()
	E.Collect_All_PlayerDurability()
	E.Collect_ALL_UNIVERSALQuestUpdate()
	E.Collect_All_journalInstance()
	E.Collect_ALL_Player_Level()
	E.Collect_ALL_WarMode()
	E.Collect_All_Holiday()
	E.Collect_All_BfA_Azerite()
	E.Collect_All_BfA_Cloaklvl()
	E.Collect_All_BfA_Island()
	E.Collect_ALL_TRASH_EncounterAndZoneLists()
	RequestRaidInfo()
	E.Update("ADDON_LOADED")
end
function OctoToDo_EventFrame_Collect:SKILL_LINES_CHANGED(...)
	if not InCombatLockdown() then
		E.Collect_All_Professions()
		E.Update("SKILL_LINES_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_XP_UPDATE()
	if not InCombatLockdown() then
		E.Collect_ALL_Player_Level()
		E.Update("PLAYER_XP_UPDATE")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_LEVEL_UP()
	C_Timer.After(1, function()
			RequestTimePlayed()
			if not InCombatLockdown() then
				E.Collect_ALL_Player_Level()
				E.Update("PLAYER_LEVEL_UP")
			end
		end
	)
end
function OctoToDo_EventFrame_Collect:QUEST_LOG_UPDATE()
	if not InCombatLockdown() and not self.questUpdatePause then
		self.questUpdatePause = true
		C_Timer.After(3, function()
				E.Collect_All_Quests()
				E.Collect_ALL_UNIVERSALQuestUpdate()
				E.Collect_All_BfA_Island()
				E.Collect_All_Chromie()
				E.Update("QUEST_LOG_UPDATE")
				self.questUpdatePause = false
		end)
	end
end
function OctoToDo_EventFrame_Collect:BAG_UPDATE()
	if not InCombatLockdown() and not self.bagUpdatePause then
		self.bagUpdatePause = true
		C_Timer.After(3, function()
				E.Collect_ALL_ItemsInBag()
				E.Update("BAG_UPDATE")
				self.bagUpdatePause = false
		end)
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if not InCombatLockdown() then
		E.Collect_ALL_ItemsInBag()
		E.Update("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_MONEY()
	if not InCombatLockdown() then
		E.Collect_ALL_MoneyUpdate()
		E.Update("PLAYER_MONEY")
	end
end
function OctoToDo_EventFrame_Collect:ACCOUNT_MONEY()
	if not InCombatLockdown() then
		E.Collect_ALL_MoneyUpdate()
		E.Update("ACCOUNT_MONEY")
	end
end
function OctoToDo_EventFrame_Collect:CURRENCY_DISPLAY_UPDATE()
	if not InCombatLockdown() and not self.currencyUpdatePause then
		self.currencyUpdatePause = true
		C_Timer.After(3, function()
				E.Collect_All_Currency()
				E.Collect_All_Currency_TEST2()
				E.Collect_All_Covenant()
				E.Update("CURRENCY_DISPLAY_UPDATE")
				self.currencyUpdatePause = false
		end)
	end
end
function OctoToDo_EventFrame_Collect:CURRENCY_TRANSFER_LOG_UPDATE()
	if not InCombatLockdown() then
		E.Collect_All_Currency()
		E.Collect_All_Currency_TEST2()
		E.Update("CURRENCY_TRANSFER_LOG_UPDATE")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_EQUIPMENT_CHANGED()
	if not InCombatLockdown() then
		E.Collect_ALL_ItemLevel()
		E.Update("PLAYER_EQUIPMENT_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_LEAVING_WORLD()
	if not InCombatLockdown() then
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
		self.PLAYER_LEAVING_WORLD = nil
		E.Collect_ALL_GreatVault()
		E.Collect_ALL_LoginTime()
	end
end
function OctoToDo_EventFrame_Collect:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if not InCombatLockdown() then
		E.Collect_All_BfA_Azerite()
		E.Collect_All_BfA_Cloaklvl()
		E.Update("AZERITE_ITEM_EXPERIENCE_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:COVENANT_CHOSEN()
	if not InCombatLockdown() then
		E.Collect_All_Covenant()
		E.Update("COVENANT_CHOSEN")
	end
end
function OctoToDo_EventFrame_Collect:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	if not InCombatLockdown() then
		E.Collect_All_Covenant()
		E.Update("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_DEAD()
	if not InCombatLockdown() then
		E.Collect_All_PlayerDurability()
		E.Update("PLAYER_DEAD")
	end
end
function OctoToDo_EventFrame_Collect:UPDATE_INVENTORY_DURABILITY()
	if not InCombatLockdown() then
		E.Collect_All_PlayerDurability()
		E.Update("UPDATE_INVENTORY_DURABILITY")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_SPECIALIZATION_CHANGED()
	if not InCombatLockdown() then
		E.Collect_ALL_PlayerInfo()
		E.Update("PLAYER_SPECIALIZATION_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:HEARTHSTONE_BOUND()
	if not InCombatLockdown() then
		E.Collect_ALL_Locations()
		E.Update("HEARTHSTONE_BOUND")
	end
end
function OctoToDo_EventFrame_Collect:ZONE_CHANGED()
	if not InCombatLockdown() then
		E.Collect_ALL_Locations()
		E.Update("ZONE_CHANGED")
	end
end
function OctoToDo_EventFrame_Collect:ZONE_CHANGED_NEW_AREA()
	if not InCombatLockdown() then
		E.Collect_ALL_Locations()
		E.Update("ZONE_CHANGED_NEW_AREA")
	end
end
function OctoToDo_EventFrame_Collect:SPELLS_CHANGED()
	if not InCombatLockdown() then
		C_Timer.After(2, function()
				E.Collect_ALL_WarMode()
				E.Update("SPELLS_CHANGED")
			end
		)
	end
end
function OctoToDo_EventFrame_Collect:MAIL_INBOX_UPDATE()
	if not InCombatLockdown() then
		E.Collect_ALL_Mail()
		E.Update("MAIL_INBOX_UPDATE")
	end
end
function OctoToDo_EventFrame_Collect:MAIL_SHOW()
	if not InCombatLockdown() then
		E.Collect_ALL_Mail()
		E.Update("MAIL_SHOW")
	end
end
function OctoToDo_EventFrame_Collect:UPDATE_PENDING_MAIL()
	if not InCombatLockdown() then
		E.Collect_ALL_Mail()
		E.Update("UPDATE_PENDING_MAIL")
	end
end
function OctoToDo_EventFrame_Collect:PLAYER_REGEN_ENABLED()
	if not InCombatLockdown() then
		C_Timer.After(5, function()
				if not InCombatLockdown() then
					E.Collect_All_Quests()
					E.Collect_ALL_UNIVERSALQuestUpdate()
					E.Collect_All_BfA_Island()
					E.Collect_All_Reputations()
					E.Collect_All_Currency()
					E.Collect_All_Currency_TEST2()
					-- E.Collect_All_journalInstance()
					E.Update("PLAYER_REGEN_ENABLED")
				end
			end
		)
	end
end
function OctoToDo_EventFrame_Collect:ENCOUNTER_END()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				E.Collect_All_journalInstance()
				E.Update("ENCOUNTER_END")
			end
		)
	end
end
function OctoToDo_EventFrame_Collect:UPDATE_INSTANCE_INFO()
	if not InCombatLockdown() then
		E.Collect_All_journalInstance()
		E.Update("UPDATE_INSTANCE_INFO")
	end
end
function OctoToDo_EventFrame_Collect:TIME_PLAYED_MSG(...)
	if not InCombatLockdown() then
		E.Collect_ALL_Played(...)
		E.Update("TIME_PLAYED_MSG")
	end
end
function OctoToDo_EventFrame_Collect:QUEST_POI_UPDATE()
	if not InCombatLockdown() then
		E.Collect_All_Chromie()
		E.Update("QUEST_POI_UPDATE")
	end
end
