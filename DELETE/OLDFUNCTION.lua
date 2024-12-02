local function OLD_Collect_All_Holiday()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Holiday()".."|r")
	end

	local collect = Octo_ToDo_DB_Other.Holiday
	if not LibOctopussy:IsAddOnLoaded("Blizzard_Calendar") then
		LibOctopussy:LoadAddOn("Blizzard_Calendar")
		ShowUIPanel(CalendarFrame, true)
		HideUIPanel(CalendarFrame)
	end
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local minute = currentCalendarTime.minute
	local hour = currentCalendarTime.hour
	local weekday = currentCalendarTime.weekday
	local monthDay = currentCalendarTime.monthDay
	local month = 0
	local year = currentCalendarTime.year
	local numEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	for i = 1, numEvents do
		local e = C_Calendar.GetDayEvent(month, monthDay, i)
		local id = e.eventID
		local title = e.title
		local sequenceType = e.sequenceType
		collect.Collect[id] = title
		local startTime = e.startTime
		local endTime = e.endTime
		if startTime and endTime and id and title then
			local startTime_year = startTime.year
			local startTime_month = startTime.month
			local startTime_monthDay = startTime.monthDay
			local startTime_weekday = startTime.weekday
			local startTime_hour = startTime.hour
			local startTime_minute = startTime.minute
			local endTime_year = endTime.year
			local endTime_month = endTime.month
			local endTime_monthDay = endTime.monthDay
			local endTime_weekday = endTime.weekday
			local endTime_hour = endTime.hour
			local endTime_minute = endTime.minute
			if collect.Active[id] == nil then
				collect.Active[id] = {}
			end
			collect.Active[id].id = id
			collect.Active[id].title = title
			collect.Active[id].sequenceType = sequenceType
			collect.Active[id].vivod = E.Yellow_Color..title.."|r до: "..endTime_monthDay.."/"..endTime_month.."/"..endTime_year
			collect.Active[id].startTime = startTime_monthDay.."/"..startTime_month.."/"..startTime_year
			collect.Active[id].endTime = endTime_monthDay.."/"..endTime_month.."/"..endTime_year
		end
	end
end 
local function OLD_Collect_BfA_Azerite()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_BfA_Azerite()".."|r")
	end

	local collect = Octo_ToDo_DB_Players[curGUID]
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		if totalLevelXP and totalLevelXP ~= 0 then
			if collect and not InCombatLockdown() then
				collect.azeriteLVL = currentLevel
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..LibOctopussy:CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
local function OLD_Collect_BfA_Cloaklvl()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_BfA_Cloaklvl()".."|r")
	end

	local collect = Octo_ToDo_DB_Players[curGUID]
	local hasItem = GetItemCount(169223, true, true, true)
	if hasItem ~= 0 then
		local itemLink = GetInventoryItemLink("player", 15)
		if itemLink then
			local itemID = itemLink:match("item:(%d+)")
			if itemID == "169223" then
				local itemLevel = select(4, GetItemInfo(itemLink))
				if itemLevel then
					if collect and not InCombatLockdown() then
						collect.cloak_lvl = min(15, max((itemLevel - 125) / 2 + 1, 1))
					end
				end
			end
		end
		if itemLink and itemLink:find("item:169223:") then
			inspectScantipFIRST:SetInventoryItem("player", 15)
			if inspectScantipFIRST:NumLines() > 0 then
				for j = 2, inspectScantipFIRST:NumLines() do
					local text = _G["OctoToDoScanningTooltipFIRSTTextLeft"..j]:GetText()
					if text and text ~= "" then
						local res = text:gsub("[, ]", ""):gsub("(%d+)[ ]+(%d+)", "%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")
						if res then
							if collect and not InCombatLockdown() then
								collect.cloak_res = res
								break
							end
						end
					end
				end
			end
			inspectScantipFIRST:ClearLines()
		end
	else
		collect.cloak_lvl = 0
		collect.cloak_res = 0
	end
end
local function OLD_Collect_ALL_PVPRaitings()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_PVPRaitings()".."|r")
	end

	local collect = Octo_ToDo_DB_Players[curGUID]
	if not IsAddOnLoaded("Blizzard_PVPUI") then
		LoadAddOn("Blizzard_PVPUI")
		return
	end
	local rating2v2, seasonBest2v2, weeklyBest2v2, seasonPlayed2v2, seasonWon2v2, weeklyPlayed2v2, weeklyWon2v2, cap2v2 = GetPersonalRatedInfo(1)
	local rating3v3, seasonBest3v3, weeklyBest3v3, seasonPlayed3v3, seasonWon3v3, weeklyPlayed3v3, weeklyWon3v3, cap3v3 = GetPersonalRatedInfo(2)
	local ratingRBG, seasonBestRBG, weeklyBestRBG, seasonPlayedRBG, seasonWonRBG, weeklyPlayedRBG, weeklyWonRBG, capRBG = GetPersonalRatedInfo(4)
	local winrate2v2 = 0
	if seasonWon2v2 ~= 0 and seasonPlayed2v2 ~= 0 then
		winrate2v2 = math.floor(seasonWon2v2 / seasonPlayed2v2 * 100).."%"
	end
	local winrate3v3 = 0
	if seasonWon3v3 ~= 0 and seasonPlayed3v3 ~= 0 then
		winrate3v3 = math.floor(seasonWon3v3 / seasonPlayed3v3 * 100).."%"
	end
	local winrateRBG = 0
	if seasonWonRBG ~= 0 and seasonPlayedRBG ~= 0 then
		winrateRBG = math.floor(seasonWonRBG / seasonPlayedRBG * 100).."%"
	end
	Octo_ToDo_DB_Players[curGUID].PVP.rating2v2 = rating2v2
	Octo_ToDo_DB_Players[curGUID].PVP.seasonBest2v2 = seasonBest2v2
	Octo_ToDo_DB_Players[curGUID].PVP.winrate2v2 = winrate2v2
	Octo_ToDo_DB_Players[curGUID].PVP.rating3v3 = rating3v3
	Octo_ToDo_DB_Players[curGUID].PVP.seasonBest3v3 = seasonBest3v3
	Octo_ToDo_DB_Players[curGUID].PVP.winrate3v3 = winrate3v3
	Octo_ToDo_DB_Players[curGUID].PVP.ratingRBG = ratingRBG
	Octo_ToDo_DB_Players[curGUID].PVP.seasonBestRBG = seasonBestRBG
	Octo_ToDo_DB_Players[curGUID].PVP.winrateRBG = winrateRBG
end
local function OLD_Collect_All_Legion_Transmoge()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Legion_Transmoge()".."|r")
	end
	local _, playerClass, classID = UnitClass("player")
	for classFilename, v in pairs(E.Octo_Table.CLASS_ARTIFACT_DATA) do
		for itemID in pairs(E.Octo_Table.CLASS_ARTIFACT_DATA[classFilename]) do
			local artifactData = E.Octo_Table.CLASS_ARTIFACT_DATA[classFilename][itemID]
			local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
			for index, data in pairs(artifactData.sets) do
				local sourceID = data.sourceID
				local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
				if sourceInfo then
					if (itemID == 128860 or itemID == 128821) and data.shapeshiftID then
						sourceInfo.visualID = data.shapeshiftID
					end
					local visualID = sourceInfo.visualID
					local isCollected = sourceInfo.isCollected
					local sourceID = sourceInfo.sourceID
					local useError = sourceInfo.useError
					local isHideVisual = sourceInfo.isHideVisual
					local useErrorType = sourceInfo.useErrorType
					local itemID = sourceInfo.itemID
					local categoryID = sourceInfo.categoryID
					local itemModID = sourceInfo.itemModID
					local ArtifactNameLocale = sourceInfo.name
					local quality = sourceInfo.quality
					local vivod = E.NONE
					if isCollected == true then
						vivod = E.DONE
					else
						vivod = E.Red_Color.."None|r"
					end
					if classFilename and itemID and visualID then
						if Octo_ToDo_DB_Artifact == nil then
							Octo_ToDo_DB_Artifact = {}
						end
						if Octo_ToDo_DB_Artifact[classFilename] == nil then
							Octo_ToDo_DB_Artifact[classFilename] = {}
						end
						if Octo_ToDo_DB_Artifact[classFilename][itemID] == nil then
							Octo_ToDo_DB_Artifact[classFilename][itemID] = {}
						end
						if Octo_ToDo_DB_Artifact[classFilename][itemID][visualID] == nil then
							Octo_ToDo_DB_Artifact[classFilename][itemID][visualID] = {}
						end
						setmetatable(Octo_ToDo_DB_Artifact[classFilename][itemID][visualID], Meta_Table_0)
						if Octo_ToDo_DB_Artifact[classFilename][itemID][visualID] then
							local collect_Artifact = Octo_ToDo_DB_Artifact[classFilename][itemID][visualID]
							collect_Artifact.isCollected = isCollected
							collect_Artifact.vivod = vivod
							collect_Artifact.name = data.name
							collect_Artifact.classFilename = classFilename
							collect_Artifact.specNameLocale = specNameLocale or ""
							collect_Artifact.specID = artifactData.specID
							collect_Artifact.specIDnumber = artifactData.specIDnumber
							collect_Artifact.ArtifactNameLocale = ArtifactNameLocale
							collect_Artifact.specIcon = specIcon
							collect_Artifact.index = index
							if E.UNLOCK_DATA[data.unlock] then
								local unlock = E.UNLOCK_DATA[data.unlock].unlock
								local unlockOCto = E.UNLOCK_DATA[data.unlock].unlockOCto
								collect_Artifact.unlock = unlock
								collect_Artifact.unlockOCto = unlockOCto
							end
						end
					end
				end
			end
		end
	end
end
local function OLD_Collect_All_Legion_TransmogeNEW()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Legion_TransmogeNEW()".."|r")
	end
	for className, classTable in pairs(E.OctoTable_LegionArtifacts) do
		for specName, specTable in pairs(classTable) do
			for number, sourceID in pairs(specTable) do
				local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
				if sourceInfo then
					local visualID = sourceInfo.visualID
					local isCollected = sourceInfo.isCollected
					Octo_ToDo_DB_LegionArtifacts[className][specName][number] = isCollected
				end
			end
		end
	end
end
local function OLD_Collect_BfA_QuestsBounties()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_BfA_QuestsBounties()".."|r")
	end

	local collect = Octo_ToDo_DB_Players[curGUID]
	collect["bounty_Legion1"] = 0
	collect["bounty_Legion1_icon"] = 0
	collect["bounty_Legion1_questID"] = 0
	collect["bounty_Legion1_end"] = 0
	collect["bounty_Legion2"] = 0
	collect["bounty_Legion2_icon"] = 0
	collect["bounty_Legion2_questID"] = 0
	collect["bounty_Legion2_end"] = 0
	collect["bounty_Legion3"] = 0
	collect["bounty_Legion3_icon"] = 0
	collect["bounty_Legion3_questID"] = 0
	collect["bounty_Legion3_end"] = 0
	local bounties_Legion = C_QuestLog.GetBountiesForMapID(619)
	if bounties_Legion then
		for i = 1, #bounties_Legion do
			local d = bounties_Legion[i]
			local factionName = GetFactionInfoByID(d.factionID)
			local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			if questIndex > 0 then
				local questData = C_QuestLog.GetInfo(questIndex)
				if questData and questData.title then
					factionName = questData.title
				end
			end
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
			end
			local faction_icon = "|T"..d.icon..":0|t "
			if collect and not InCombatLockdown() then
				collect["bounty_Legion"..i] = LibOctopussy:CheckCompletedByQuestID(d.questID)
				collect["bounty_Legion"..i.."_icon"] = faction_icon
				collect["bounty_Legion"..i.."_questID"] = d.questID
				collect["bounty_Legion"..i.."_end"] = time() + secondsLeft * 60
			end
		end
	end
	local bounties_BfA = C_QuestLog.GetBountiesForMapID(875)
	collect["bounty_BfA1"] = 0
	collect["bounty_BfA1_icon"] = 0
	collect["bounty_BfA1_questID"] = 0
	collect["bounty_BfA1_end"] = 0
	collect["bounty_BfA2"] = 0
	collect["bounty_BfA2_icon"] = 0
	collect["bounty_BfA2_questID"] = 0
	collect["bounty_BfA2_end"] = 0
	collect["bounty_BfA3"] = 0
	collect["bounty_BfA3_icon"] = 0
	collect["bounty_BfA3_questID"] = 0
	collect["bounty_BfA3_end"] = 0
	if bounties_BfA then
		for i = 1, #bounties_BfA do
			local d = bounties_BfA[i]
			local factionName = GetFactionInfoByID(d.factionID)
			local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			if questIndex then
				if questIndex > 0 then
					local questData = C_QuestLog.GetInfo(questIndex)
					if questData and questData.title then
						factionName = questData.title
					end
				end
			end
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
				local faction_icon = "|T"..d.icon..":0|t "
				if collect and not InCombatLockdown() then
					collect["bounty_BfA"..i] = LibOctopussy:CheckCompletedByQuestID(d.questID)
					collect["bounty_BfA"..i.."_icon"] = faction_icon
					collect["bounty_BfA"..i.."_questID"] = d.questID
					collect["bounty_BfA"..i.."_end"] = time() + secondsLeft * 60
				end
			end
		end
	end
end
local function OLD_Collect_BfA_Island()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_BfA_Island()".."|r")
	end

	local collect = Octo_ToDo_DB_Players[curGUID]
	local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	if questID then
		if collect and not InCombatLockdown() then
			collect.islandBfA = LibOctopussy:CheckCompletedByQuestID(questID)
		end
	end
end

