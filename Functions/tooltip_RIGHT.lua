local GlobalAddonName, E = ...
local L = E.L

function E.func_KeyTooltip_RIGHT(GUID, SettingsType)
	if not GUID or not SettingsType then return end
	local ServerTime = GetServerTime()
	local tooltip = {}
	local CharInfo = Octo_ToDo_DB_Levels[GUID]
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local dataType, id = ("#"):split(SettingsType)
	if dataType == "Currencies" or dataType == "Items" or dataType == "Reputations" or dataType == "RaidsOrDungeons" then
		id = tonumber(id)
	end
	if dataType == "Items" then
		local itemID = id
		local result = ""
		local total = 0
		local itemCount_Bags = 0
		local itemCount_Bank = 0
		if type(itemID) == "number" then
			if cm.Items.Bags[itemID] then
				itemCount_Bags = itemCount_Bags+cm.Items.Bags[itemID]
			end
			if cm.Items.Bank[itemID] then
				itemCount_Bank = itemCount_Bank+cm.Items.Bank[itemID]
			end
			total = itemCount_Bags+itemCount_Bank
		end
		if total > 0 and total ~= itemCount_Bags then
			tooltip[#tooltip+1] = {" ",TOTAL..": "..E.func_CompactFormatNumber(total)}
			tooltip[#tooltip+1] = {" "," "}
			tooltip[#tooltip+1] = {BAG_NAME_BACKPACK, E.func_CompactFormatNumber(itemCount_Bags)}
			if itemCount_Bank > 0 then
				tooltip[#tooltip+1] = {BANK, E.func_CompactFormatNumber(itemCount_Bank)}
			end
		end
	end
	if dataType == "Currencies" and id == 1822 then
		local curCovID = pd.SL_covenantID or 0
		for covenant = 1, 4 do
			local cov = E.OctoTable_Covenant[covenant]
			if cov then
				local color = (curCovID == covenant) and cov.color or E.COLOR_GRAY
				local leftText = color..E.func_texturefromIcon(cov.icon)..cov.name.."|r"
				local value = pd[cov.prefix.."_Renown"] or 0
				local rightText = color..value.."|r"
				tooltip[#tooltip+1] = { leftText, "", rightText }
			end
		end
	end
	if dataType == "Currencies" and id == 1813 then
		local curCovID = pd.SL_covenantID or 0
		for covenant = 1, 4 do
			local cov = E.OctoTable_Covenant[covenant]
			if cov then
				local color = (curCovID == covenant) and cov.color or E.COLOR_GRAY
				local leftText = color..E.func_texturefromIcon(cov.icon)..cov.name.."|r"
				local value = pd[cov.prefix.."_Anima"] or 0
				local rightText = color..value.."|r"
				local centText = ""
				if curCovID == covenant and pd.SL_Possible_Anima then
					centText = E.COLOR_BLUE.."+"..pd.SL_Possible_Anima.."|r"
				end
				tooltip[#tooltip+1] = { leftText, centText, rightText }
			end
		end
		E.func_AddTooltipSeparator(tooltip)
	end
	if dataType == "Currencies" and id == 824 then
		local GARRISON_RESOURCE_ID = 824
		local RESOURCE_GENERATION_INTERVAL = 600
		local RESOURCES_PER_INTERVAL = 1
		local MAX_CACHE_SIZE = 500
		if cm.GARRISON.lastCacheTime and cm.GARRISON.lastCacheTime ~= 0 then
			local color = E.COLOR_GRAY
			local cacheSize = cm.GARRISON.cacheSize or MAX_CACHE_SIZE
			local lastCacheTime = cm.GARRISON.lastCacheTime
			local timeUnitsSinceLastCollect = lastCacheTime and (ServerTime-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
			local earnedSinceLastCollect = min(cacheSize, math.floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
			local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
			local timeUntilFull = (lastCacheTime+secondsToMax) - ServerTime
			if earnedSinceLastCollect > 0 then
				if earnedSinceLastCollect >= 5 then
					color = (earnedSinceLastCollect == cacheSize) and E.COLOR_PURPLE or E.COLOR_YELLOW
				end
			end
			tooltip[#tooltip+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			if earnedSinceLastCollect ~= cacheSize then
				tooltip[#tooltip+1] = {"Time to full: ", E.func_SecondsToClock(timeUntilFull)}
			end
			tooltip[#tooltip+1] = {"Was earned: ", E.func_SecondsToClock(ServerTime-(cm.GARRISON.lastCacheTime or time()))}
		end
	end
	if dataType == "Currencies" and id == 1166 then
		local icon = E.func_texturefromIcon(E.func_GetCurrencyIcon(1166))
		local cache_1166 = E.func_Mounts_1166()
		for i, v in ipairs(cache_1166) do
			local mountID = v.mountID
			local source = v.source
			local price = v.price
			tooltip[#tooltip+1] = {E.func_FormatMountInfo(mountID), {source, "LEFT"}, E.func_CompactFormatNumber(price)..icon}
		end
	end
	if id == "GreatVault" then
		for j = 1, #E.Enum_Activities_table do
			local ID = E.Enum_Activities_table[j]
			local vaultData = cm.GreatVault and cm.GreatVault[ID]
			local rewards = vaultData and vaultData.rewards or {}
			local activities = C_WeeklyRewards.GetActivities(ID)
			local max = activities and activities[3] and activities[3].threshold or 0
			local vaultMin = vaultData and vaultData.min or 0
			tooltip[#tooltip+1] = {
				E.name_activities[ID] or "?",
				" ",
				" ",
				(vaultMin >= max and E.COLOR_GREEN or vaultMin > 0 and E.COLOR_YELLOW or E.COLOR_GRAY)..vaultMin.."/"..max.."|r",
				" ",
				" ",
				rewards[1] and E.COLOR_GREEN..rewards[1].."|r" or E.COLOR_GRAY.."-|r",
				rewards[2] and E.COLOR_GREEN..rewards[2].."|r" or E.COLOR_GRAY.."-|r",
				rewards[3] and E.COLOR_GREEN..rewards[3].."|r" or E.COLOR_GRAY.."-|r"
			}
		end
	end
	if id == "CurrentKey" then
		if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
			local keyName = E.func_formatMplusKey(pd.OwnedKeystoneLevel, pd.OwnedKeystoneChallengeMapID, true, true)
			tooltip[#tooltip+1] = {keyName}
		end
		local seasonData = pd.MythicPlus and pd.MythicPlus[E.MythicPlus_seasonID]
		if seasonData then
			local RIO_Score = tonumber(seasonData.RIO_Score)
			local RIO_weeklyBest = tonumber(seasonData.RIO_weeklyBest)
			if RIO_Score and RIO_weeklyBest then
				if pd.OwnedKeystoneLevel and pd.OwnedKeystoneChallengeMapID then
					tooltip[#tooltip+1] = {" ", " "}
				end
				tooltip[#tooltip+1] = {"Weekly Best:", RIO_weeklyBest}
				tooltip[#tooltip+1] = {"MythicPlus Score:", RIO_Score}
			end
		end
	end
	if id == "LegionRemixResearch" then
		for questID in next, (E.OctoTable_RemixInfinityResearch) do
			if cm.ListOfQuests[questID] then
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	if dataType == "Currencies" then
		for currencyID, dataTBL in pairs(E.OctoTable_ALL_Mounts) do
			if id == tonumber(currencyID) and id ~= 1166 then
				local mounts = {}
				for mountID, price in pairs(dataTBL) do
					local mountIconNumber = E.func_GetMountTexture(mountID)
					local mountIcon = E.func_texturefromIcon(mountIconNumber)
					local mountName = E.func_GetMountName(mountID)
					local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
					local color = isCollected and E.COLOR_WHITE or E.COLOR_RED
					local mountLeftText = mountIcon..color..mountName.."|r"
					table.insert(mounts, {
							id = mountID,
							price = price,
							name = mountName,
							leftText = mountLeftText,
							collected = isCollected
					})
				end
				table.sort(mounts, function(a, b)
						if a.name ~= b.name then
							return a.name < b.name
						end
						return a.id < b.id
				end)
				for _, mount in ipairs(mounts) do
					tooltip[#tooltip+1] = {
						mount.leftText,
						" ",
						E.func_CompactFormatNumber(mount.price)..
						E.func_texturefromIcon(E.func_GetCurrencyIcon(currencyID))
					}
				end
			end
		end
	end
	if SettingsType == "BfA_mechagonItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_MECHAGON, true)
	end
	if dataType == "Reputations" then
		if cm.Reputation and cm.Reputation[id] and type(cm.Reputation[id]) == "table" then
			-- local FIRST, SECOND, ParagonCount, color, standingTEXT, repType = ("#"):split(cm.Reputation[id])
			-- local fir, sec, ParagonCount, col, standingTEXT, typ = ("#"):split(cm.Reputation[id])

			local FIRST = cm.Reputation[id].FIRST or 0
			local SECOND = cm.Reputation[id].SECOND or 0
			local ParagonCount = cm.Reputation[id].ParagonCount
			-- local color = cm.Reputation[id].color or E.COLOR_WHITE
			-- local standingTEXT = cm.Reputation[id].standingTEXT or ""
			local repType = cm.Reputation[id].repType
			local reaction = cm.Reputation[id].reaction or 0
			local rankInfocurrentLevel = cm.Reputation[id].rankInfocurrentLevel
			local rankInfomaxLevel = cm.Reputation[id].rankInfomaxLevel
			local renownLevel = cm.Reputation[id].renownLevel
			local renownMaxLevel = cm.Reputation[id].renownMaxLevel
			local gender = pd.UnitSex or 1

			-- local color = E.COLOR_BLACK
			local color = E.func_DB_REP_COLOR(repType, reaction)

			local standingTEXT = ""

			if repType == 2 then -- FRIENDSHIP
				if rankInfocurrentLevel and rankInfomaxLevel then
					standingTEXT = rankInfocurrentLevel .. "/"..rankInfomaxLevel
				end
			elseif repType == 3 then
				if renownLevel and renownMaxLevel then
					standingTEXT = renownLevel .. "/" .. renownMaxLevel
				end
			elseif repType == 1 then
				if reaction and gender then
					standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, gender)
				end
			elseif repType == 4 then
				standingTEXT = L["Paragon"]
			end


			local percent = (SECOND > 0) and math.floor(FIRST / SECOND * 100) or 0
			local percentResult = color..percent.."%|r"
			local firstTEXT = ""
			local ICON_TABARD = E.ICON_TABARD
			if ICON_TABARD then
				firstTEXT = firstTEXT..E.func_texturefromIcon(ICON_TABARD)
			end
			local AdditionalIcon = E.func_GetReputationIcon(id)
			if AdditionalIcon then
				firstTEXT = firstTEXT..E.func_texturefromIcon(AdditionalIcon)
			end
			local ReputationAtlas = E.func_GetReputationAtlas(id)
			if ReputationAtlas then
				firstTEXT = firstTEXT..E.func_texturefromIcon(ReputationAtlas, nil, nil, true)
			end
			local IsAccountWideReputation = C_Reputation.IsAccountWideReputation(id)
			if IsAccountWideReputation then
				firstTEXT = firstTEXT..E.func_texturefromIcon(E.ATLAS_ACCOUNT_WIDE, nil, nil, true)
			end
			firstTEXT = firstTEXT..E.func_GetReputationName(id)
			local secondTEXT = FIRST.."/"..SECOND
			if secondTEXT == "1/1" then
				secondTEXT = " "
				-- secondTEXT = E.DONE
				-- secondTEXT = color..standingTEXT.."|r"
			end
			local thirdTEXT = standingTEXT


			local paragonQuest = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].paragonQuest or false
			if paragonQuest and cm.ListOfParagonQuests[paragonQuest] then
				secondTEXT = E.COLOR_PURPLE..">"..FIRST.."/"..SECOND.."<".."|r"
			end


			if secondTEXT ~= "0/0" then
				tooltip[#tooltip+1] = {firstTEXT, color..thirdTEXT.."|r"}
				tooltip[#tooltip+1] = {"", secondTEXT.." "..percentResult}
				if ParagonCount and ParagonCount ~= "" then
					local itemCache = E.OctoTable_Reputations_DB[id] and E.OctoTable_Reputations_DB[id].itemCache or false
					if itemCache then
						local itemCacheIcon = E.func_texturefromIcon(E.func_GetItemIcon(itemCache))
						tooltip[#tooltip+1] = {" "}
						tooltip[#tooltip+1] = {itemCacheIcon..L["Turned in:"].."", color..ParagonCount.."|r"}
					end
				end
			end


			if E.DebugReputationInfo then
				tooltip[#tooltip+1] = {" "}
				tooltip[#tooltip+1] = {E.COLOR_DEBUG.."~~~ DEBUG ~~~|r"}
				tooltip[#tooltip+1] = {"FIRST", FIRST} -- число
				tooltip[#tooltip+1] = {"SECOND", SECOND} -- число
				tooltip[#tooltip+1] = {"ParagonCount", ParagonCount} -- число
				tooltip[#tooltip+1] = {"color", color..color:gsub("|cff", "").."|r"} -- строка или таблица цветов
				tooltip[#tooltip+1] = {"standingTEXT", standingTEXT} -- строка
				tooltip[#tooltip+1] = {"repType", repType} -- число
				tooltip[#tooltip+1] = {"reaction", reaction} -- число
				tooltip[#tooltip+1] = {"renownLevel", cm.Reputation[id].renownLevel}
				tooltip[#tooltip+1] = {"renownMaxLevel", cm.Reputation[id].renownMaxLevel}
				tooltip[#tooltip+1] = {"rankInfocurrentLevel", cm.Reputation[id].rankInfocurrentLevel}
				tooltip[#tooltip+1] = {"rankInfomaxLevel", cm.Reputation[id].rankInfomaxLevel}
				local new_reaction = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
				tooltip[#tooltip+1] = {"new_reaction", new_reaction}
			end






		end
	end
	if SettingsType == "Additionally#AllItems" then
		tooltip = E.func_BuildItemTooltip(CharInfo, E.OctoTable_itemID_ALL, false)
	end
	if SettingsType == "Additionally#Professions" then
		local charProf = cm.professions
		for i = 1, 5 do
			if charProf[i] and charProf[i].skillLine then
				local leftText = E.func_ProfessionIcon(charProf[i].skillLine).." "..E.func_GetProfessionName(charProf[i].skillLine)
				local rightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
				if charProf[i].skillModifier then
					rightText = charProf[i].skillLevel..E.COLOR_GREEN.."+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
				end
				tooltip[#tooltip+1] = {leftText, rightText}
				if charProf[i].child then
					for expIndex = #charProf[i].child, 1, -1 do
						local v = charProf[i].child[expIndex]
						if v.QWEskillLevel and v.QWEprofessionName then
							local j = E.OctoTable_Expansions[expIndex]
							tooltip[#tooltip+1] = {E.func_FormatExpansion(expIndex), v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
						end
					end
				end
			end
		end
	end
	if SettingsType == "Additionally#ItemLevel" then
		if pd.avgItemLevelEquipped and pd.avgItemLevel then
			if pd.avgItemLevelPvp and pd.avgItemLevelPvp > pd.avgItemLevel then
				tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, pd.avgItemLevelPvp)}
			end
		end
	end
	if SettingsType == "Additionally#Money" then
		if pd.Money then
			local function addMoneyDiff(label, oldValue)
				if not oldValue then return end
				local diff = pd.Money - oldValue
				if diff == 0 then return end
				local color = diff > 0 and E.COLOR_GREEN or E.COLOR_RED
				local result = E.func_FormatMoney(math.abs(diff))
				tooltip[#tooltip+1] = {label, color..result.."|r"}
			end
			addMoneyDiff("SESSION", pd.MoneyOnLogin)
			addMoneyDiff("DAILY", pd.MoneyOnDaily)
			addMoneyDiff("WEEKLY", pd.MoneyOnWeekly)
		end
	end
	if SettingsType == "Additionally#LastOnline" then
		local color = "|cffFFFFFF"
		if pd.loginHour and pd.loginDay then
			if pd.GUID == E.curGUID then
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, pd.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r" ), " "}
			else
				if pd.needResetWeekly then
					color = E.COLOR_GRAY
				elseif pd.needResetDaily then
					color = E.COLOR_RED
				end
				tooltip[#tooltip+1] = {color..E.func_FormatLastSeen(pd.time, pd.classColorHex).."|r", ""}
				tooltip[#tooltip+1] = {"", ""}
				tooltip[#tooltip+1] = {color..pd.loginDay.."|r", ""}
				tooltip[#tooltip+1] = {color..pd.loginHour.."|r", ""}
			end
		end
	end
	if SettingsType == "Additionally#ListOfQuests" then
		if pd.numQuests_Paragon and cm.ListOfParagonQuests then
			tooltip[#tooltip+1] = {E.COLOR_BLUE..L["Paragon"]..":|r"}
			local questIDs = {}
			for questID in next, (cm.ListOfParagonQuests) do
				questIDs[#questIDs+1] = questID
			end
			table.sort(questIDs, E.func_ReversSort)
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), cm.ListOfParagonQuests[questID]}
			end
		end
		if pd.numQuests and cm.ListOfQuests then
			local questIDs = {}
			for questID in next, (cm.ListOfQuests) do
				questIDs[#questIDs+1] = questID
			end
			table.sort(questIDs, E.func_ReversSort)
			if pd.numQuests_Paragon then
				tooltip[#tooltip+1] = {" "}
			end
			for i = 1, #questIDs do
				local questID = questIDs[i]
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), cm.ListOfQuests[questID]}
			end
		end
	end
	if SettingsType == "Additionally#LFGInstance" then
		local combinedTooltip = {}
		for EJ_ID, v in next, (cm.journalInstance) do
			for difficultyID, w in next, (v) do
				local instanceReset = w.instanceReset
				if instanceReset then
					local defeatedBosses = w.defeatedBosses
					local totalBosses = w.totalBosses
					local lastBossDefeated = w.lastBossDefeated
					local color = defeatedBosses == totalBosses and E.COLOR_GREEN or (lastBossDefeated and E.COLOR_YELLOW or E.COLOR_WHITE)
					local difficultyName = E.func_GetDifficultyName(difficultyID)
					-- local name = w.name
					-- local EJ_ID = w.EJ_ID
					local name = E.func_GetDungeonName(EJ_ID)
					local _, _, _, _, _, buttonImage2, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(EJ_ID)
					local icon
					if isRaid then
						icon = E.func_texturefromIcon(buttonImage2)..E.func_texturefromIcon(E.ATLAS_RAID, nil, nil, true)
					else
						icon = E.func_texturefromIcon(buttonImage2)..E.func_texturefromIcon(E.ATLAS_DUNGEON, nil, nil, true)
					end
					local LeftText = icon..name
					local status = color..defeatedBosses.."/"..totalBosses.."|r"
					table.insert(combinedTooltip, {
							LeftText = LeftText,
							difficultyID = difficultyID,
							status = status,
							time = E.func_SecondsToClock(instanceReset-ServerTime)
					})
				end
			end
		end
		for dungeonID, v in next, (cm.LFGInstance) do
			if cm.LFGInstance[dungeonID] then
				local instanceReset = v.instanceReset
				if instanceReset then
					local name = cm.LFGInstance[dungeonID].name..E.debugInfo(dungeonID)
					local icon = E.func_texturefromIcon(E.ATLAS_DUNGEON, nil, nil, true)
					local textureFilename = v.textureFilename
					if textureFilename then
						icon = E.func_texturefromIcon(textureFilename)..icon
					end
					local LeftText = icon..name
					table.insert(combinedTooltip, {
							LeftText = LeftText,
							difficultyID = v.difficultyID,
							status = " ",
							time = E.func_SecondsToClock(instanceReset-ServerTime),
					})
				end
			end
		end
		for worldBossID, v in next, (cm.SavedWorldBoss) do
			local instanceReset = v.instanceReset
			if instanceReset then
				local name = v.name..E.debugInfo(worldBossID)
				local icon = E.func_texturefromIcon(E.ATLAS_WORLDBOSS, nil, nil, true)
				local LeftText = icon..name
				table.insert(combinedTooltip, {
						LeftText = LeftText,
						difficultyID = 172, -- RAID_INFO_WORLD_BOSS, -- L["World Boss"]
						status = " ",
						time = E.func_SecondsToClock(instanceReset-ServerTime),
				})
			end
		end
		table.sort(combinedTooltip, function(a, b)
				local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
				local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
				return pa > pb
		end)
		for _, v in ipairs(combinedTooltip) do
			tooltip[#tooltip+1] = {
				v.LeftText,
				E.func_GetDifficultyName(v.difficultyID),
				v.status,
				E.COLOR_TIME..v.time.."|r",
			}
		end
	end
	if dataType == "UniversalQuests" then
		for _, data in next, (E.ALL_UniversalQuests) do
			if data.quests then
				local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
				local showTooltip = data.showTooltip or false
				if showTooltip and id == questKey then
					local totalQuest = 0
					local forcedMaxQuest = data.forcedMaxQuest
					for _, questData in ipairs(data.quests) do
						if type(questData[1]) == "number" then
							local FactionOrClass = questData.FactionOrClass
							local class = questData.class
							if not FactionOrClass or (FactionOrClass[pd.Faction] or FactionOrClass[pd.classFilename]) then
								if forcedMaxQuest and type(forcedMaxQuest) == "string" and forcedMaxQuest == "all" then
									totalQuest = totalQuest+1
								elseif forcedMaxQuest and type(forcedMaxQuest) == "number" then
									totalQuest = forcedMaxQuest
									break
								else
									totalQuest = totalQuest+1
								end
							end
						end
					end
					forcedMaxQuest = totalQuest
					if E.DebugUniversal then
						tooltip[#tooltip+1] = {questKey, "forcedMaxQuest: "..totalQuest}
					end
					if totalQuest >= 1 then
						local output
						if type(data.TextLeft) == "function" then
							output = data.TextLeft()
						else
							output = data.TextLeft
						end
						local TextLeft = tostringall(E.func_FormatResetType(data.reset).." "..output)
						tooltip[#tooltip+1] = {" ", " ", TOTAL..": "..totalQuest}
					end
					local questsToShow = {}
					for _, questData in ipairs(data.quests) do
						-- if type(questData[1]) == "number" then
						local FactionOrClass = questData.FactionOrClass
						if not FactionOrClass or (FactionOrClass[pd.Faction] or FactionOrClass[pd.classFilename]) then
							table.insert(questsToShow, questData)
						end
						-- end
					end
					if data.sorted ~= false then
						table.sort(questsToShow, function(a, b)
								local function getName(entry)
									if entry.forcedText then
										if entry.forcedText.npcID then
											return E.func_GetNPCName(entry.forcedText.npcID) or ""
										elseif entry.forcedText.text then
											return entry.forcedText.text or ""
										end
									end
									return E.func_GetQuestName(entry[1]) or ""
								end
								return getName(a) < getName(b)
						end)
					end
					for _, questData in ipairs(questsToShow) do
						local questID = questData[1]
						local FactionOrClass = questData.FactionOrClass
						local forcedText = questData.forcedText
						local forcedIcon = questData.forcedIcon
						local addText = questData.addText
						local Output_LEFT = ""
						local Output_CENT = ""
						local Output_RIGHT = ""
						if questID then
							local status = cm.UniversalQuest and cm.UniversalQuest[questKey] and cm.UniversalQuest[questKey][questID] or E.COLOR_GRAY..NONE.."|r"
							if status and type(status) == "boolean" then
								status = E.DONE
							end
							Output_RIGHT = status
						end
						if forcedText then
							if forcedText.text then
								Output_LEFT = Output_LEFT..forcedText.text.." "
							end
							if forcedText.npcID then
								Output_LEFT = Output_LEFT..E.func_GetNPCName(forcedText.npcID).." "
							end
							if forcedText.achievementID then
								Output_LEFT = Output_LEFT..E.func_GetAchievementName(forcedText.achievementID).." "
							end
							if forcedText.itemID then
								Output_LEFT = Output_LEFT..E.func_texturefromIcon(E.func_GetItemIcon(forcedText.itemID))..E.func_GetItemName(forcedText.itemID).." "
							end
							if forcedText.Icon then
								Output_LEFT = E.func_texturefromIcon(forcedText.Icon)..Output_LEFT
							end
							Output_LEFT = Output_LEFT:match("^(.-)%s*$")
						else
							if questID then
								Output_LEFT = Output_LEFT..E.func_GetQuestName(questID)
							end
						end
						if addText then
							if addText.IconVignette then
								Output_LEFT = E.func_texturefromIcon(addText.IconVignette, nil, nil, true)..Output_LEFT
							end
							if addText.Icon then
								Output_LEFT = E.func_texturefromIcon(addText.Icon)..Output_LEFT
							end
							if addText.mount then
								Output_CENT = Output_CENT..E.COLOR_PURPLE.." +"..string.format(RENOWN_REWARD_MOUNT_NAME_FORMAT, E.func_FormatMountInfo(addText.mount)).."|r"
							end
							if addText.expansionText then
								Output_CENT = Output_CENT..addText.expansionText
							end
							if addText.notes then
								Output_LEFT = Output_LEFT..addText.notes
							end
							if addText.mapID then
								Output_LEFT = Output_LEFT..E.COLOR_GRAY.." ("..E.func_GetMapName(addText.mapID)..")|r"
							end
							if addText.spellID then
								Output_LEFT = Output_LEFT..E.COLOR_PINK..E.func_GetSpellName(addText.spellID).."|r"
							end
							if addText.text then
								Output_LEFT = Output_LEFT..addText.text
							end
							if addText.itemID then
								Output_LEFT = Output_LEFT..E.func_texturefromIcon(E.func_GetItemIcon(addText.itemID))..E.func_GetItemName(addText.itemID)
							end
							if addText.coords then
								local x, y = E.func_UnpackCoordinates(addText.coords)
								local coordsText = E.func_FormatCoordinates(x, y)
								Output_CENT = Output_CENT..coordsText
							end
						end
						if FactionOrClass and FactionOrClass[pd.Faction] then
							Output_LEFT = E.func_texturefromIcon(E.func_GetFactionIcon(pd.Faction))..Output_LEFT
						elseif FactionOrClass and FactionOrClass[pd.classFilename] then
							Output_LEFT = E.func_texturefromIcon(pd.specIcon)..Output_LEFT
						end
						-- if Output_CENT ~= "" then
							tooltip[#tooltip+1] = {Output_LEFT, {Output_CENT, "LEFT"}, Output_RIGHT}
						-- else
						-- 	tooltip[#tooltip+1] = {Output_LEFT, " ", Output_RIGHT}
						-- end
					end
				end
			end
		end
	end
	if dataType == "RaidsOrDungeons" then
		local EJ_ID = tonumber(id)
		local SI_ID = E.func_EJ_to_SI(EJ_ID)
		local instanceData = cm.journalInstance and cm.journalInstance[EJ_ID] or {}
		local completedDiffs = {}
		local bosses = {}
		local resetTime
		-- 1. получаем список всех сложностей для инстанса
		local difficulties
		for _, v in next, E.Octo_Table_SI_IDS do
			if SI_ID == v.SI_ID then
				difficulties = v.difficulties
				break
			end
		end
		if not difficulties then return end
		-- 2. собираем сложности в зависимости от конфига
		if E.Config_ShowAllDifficulties then
			for difficultyID, totalBosses in next, difficulties do
				local ji = instanceData[difficultyID] or {}
				completedDiffs[#completedDiffs+1] = {
					difficultyID = difficultyID,
					defeatedBosses = ji.defeatedBosses or 0,
					totalBosses = totalBosses,
					lastBossDefeated = ji.lastBossDefeated or false,
					Bosses = ji.Bosses
				}
				if not resetTime and ji.instanceReset and ji.instanceReset > 0 then
					resetTime = ji.instanceReset
				end
			end
		else
			for difficultyID, ji in next, instanceData do
				if ji.defeatedBosses and ji.defeatedBosses > 0 then
					completedDiffs[#completedDiffs+1] = {
						difficultyID = difficultyID,
						defeatedBosses = ji.defeatedBosses,
						totalBosses = ji.totalBosses,
						lastBossDefeated = ji.lastBossDefeated,
						Bosses = ji.Bosses
					}
					if not resetTime and ji.instanceReset and ji.instanceReset > 0 then
						resetTime = ji.instanceReset
					end
				end
			end
		end
		if #completedDiffs == 0 then return end
		-- 3. сортировка по приоритету из OctoTable_Difficulties
		table.sort(completedDiffs, function(a, b)
				local pa = E.OctoTable_Difficulties[a.difficultyID] and E.OctoTable_Difficulties[a.difficultyID].prior or 999
				local pb = E.OctoTable_Difficulties[b.difficultyID] and E.OctoTable_Difficulties[b.difficultyID].prior or 999
				return pa < pb
		end)
		-- 4. фиксируем порядок боссов по первой доступной сложности
		for _, diff in ipairs(completedDiffs) do
			local ji = diff.Bosses
			if ji and #ji > 0 then
				for i = 1, #ji do
					local b = ji[i]
					bosses[i] = { name = b.bossName, kills = {} }
				end
				break
			end
		end
		-- 5. заполняем киллы по сложностям
		for _, diff in ipairs(completedDiffs) do
			local ji = diff.Bosses
			if ji and #ji > 0 then
				for i = 1, #ji do
					bosses[i].kills[diff.difficultyID] = ji[i].bossKilled
				end
			end
		end
		-- 6. шапка: reset+сложности
		local header = {}
		if resetTime then
			header[1] = {E.COLOR_TIME..E.func_SecondsToClock(resetTime-ServerTime).."|r", "LEFT"}
		else
			header[1] = {" ", "LEFT"}
		end
		for _, diff in ipairs(completedDiffs) do
			header[#header+1] = {E.func_GetDifficultyName(diff.difficultyID), "CENTER"}
		end
		tooltip[#tooltip+1] = header
		-- 8. итоговая строка TOTAL
		local totalRow = {{E.COLOR_GRAY..TOTAL.."|r", "LEFT"}}
		for _, diff in ipairs(completedDiffs) do
			local color
			if diff.defeatedBosses == diff.totalBosses then
				color = E.COLOR_GREEN
			elseif diff.lastBossDefeated then
				color = E.COLOR_YELLOW
			else
				color = E.COLOR_WHITE
			end
			totalRow[#totalRow+1] = {color..diff.defeatedBosses.."/"..diff.totalBosses.."|r", "CENTER"}
		end
		tooltip[#tooltip+1] = totalRow
		-- 7. строки боссов
		if bosses and #bosses > 0 then
			tooltip[#tooltip+1] = {""}
		end
		for i = 1, #bosses do
			local boss = bosses[i]
			local row = {{boss.name, "LEFT"}}
			for _, diff in ipairs(completedDiffs) do
				if boss.kills[diff.difficultyID] then
					row[#row+1] = {E.DONE, "CENTER"}
				else
					row[#row+1] = {E.COLOR_GRAY.."-|r", "CENTER"}
				end
			end
			tooltip[#tooltip+1] = row
		end
	end
	return tooltip
end
function E.func_BuildItemTooltip(CharInfo, TBL, needShowAllItems)
	local pd = CharInfo.PlayerData
	local cm = CharInfo.MASLENGO
	local tooltip = {}
	local sorted_itemList = {}
	local Items_BAGS = CharInfo.MASLENGO.Items.Bags
	local Items_BANK = CharInfo.MASLENGO.Items.Bank
	local total_BAGS = 0
	local total_BANK = 0
	for itemID in next, (TBL) do
		local count_BAGS = Items_BAGS[itemID] or 0
		local count_BANK = Items_BANK[itemID] or 0
		local hasData = needShowAllItems or (count_BAGS > 0 or count_BANK > 0)
		if hasData then
			if count_BANK > 0 then
				total_BANK = total_BANK+count_BANK
			end
			table.insert(sorted_itemList, {
					itemID = itemID,
					quality = E.func_GetItemQualityLevel(itemID),
					count_BAGS = count_BAGS,
					count_BANK = count_BANK,
			})
		end
	end
	table.sort(sorted_itemList, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality
			elseif a.count_BAGS ~= b.count_BAGS then
				return a.count_BAGS > b.count_BAGS
			elseif a.count_BANK ~= b.count_BANK then
				return a.count_BANK > b.count_BANK
			end
			return a.itemID > b.itemID
	end)
	if total_BANK > 0 then
		tooltip[#tooltip+1] = {"", {BAG_NAME_BACKPACK, "RIGHT"}, {E.COLOR_GRAY..BANK.."|r", "LEFT"}}
	end
	for _, v in ipairs(sorted_itemList) do
		local itemID = v.itemID
		local count_BAGS = v.count_BAGS
		local count_BANK = v.count_BANK
		local row2Text = count_BAGS > 0 and E.func_CompactFormatNumber(count_BAGS) or ""
		local row3Text = count_BANK > 0 and E.COLOR_GRAY.."+"..E.func_CompactFormatNumber(count_BANK).."|r" or ""
		local icon = E.func_texturefromIcon(E.func_GetItemIcon(itemID))
		local name = E.func_GetItemName(itemID)
		tooltip[#tooltip+1] = {
			icon..name,
			{row2Text, "RIGHT"},
			{row3Text, "LEFT"}
		}
	end
	return tooltip
end