local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Hide_ObjectivesInInstance
tinsert(E.Octo_Globals.modules, function()
				if E.Octo_Func.Octo_IsRetail() == true then
		if Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance then
			local className, classFilename, classId = UnitClass("PLAYER")
			local classColor = C_ClassColor.GetClassColor(classFilename)
			local r, g, b = classColor:GetRGB()
			local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
			local classColorHexCurrent = E.Octo_Func.func_rgb2hex(r, g, b)
			function Hide_ObjectivesInInstanceOnLoad()
				local EventFrame = nil
				if not EventFrame then
					EventFrame = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID())
					EventFrame:Hide()
				end
				EventFrame:RegisterEvent("PLAYER_LOGIN")
				EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
				EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
				EventFrame:RegisterEvent("ZONE_CHANGED")
				EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				EventFrame:SetScript("OnEvent", function(...)
						Hide_ObjectivesInInstanceOnEvent(...)
				end)
			end
			function Hide_ObjectivesInInstanceOnEvent(self, event, ...)
				if (event == "PLAYER_LOGIN" or event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
					myfunction()
				end
			end
			function myfunction()
				local name, instanceType, difficultyID = GetInstanceInfo()
				if instanceType == "party" or instanceType == "raid" or instanceType == "arena" or instanceType == "pvp" then
					-- if difficultyID == 1 -- Normal party (DRAENOR)
					if difficultyID == 2 -- Heroic party isHeroic
					or difficultyID == 8 -- Mythic Keystone party isHeroic, isChallengeMode
					-- or difficultyID == 19 -- Event party
					or difficultyID == 23 -- Mythic party isHeroic, displayMythic
					-- or difficultyID == 24 -- Timewalking party
					or difficultyID == 150 -- Normal party
					-- PVP
					or difficultyID == 29 -- PvEvP Scenario pvp
					or difficultyID == 34 -- PvP pvp
					-- raid
					-- or difficultyID == 3 -- 10 Player raid toggleDifficultyID: 5
					-- or difficultyID == 4 -- 25 Player raid toggleDifficultyID: 6
					-- or difficultyID == 5 -- 10 Player (Heroic) raid isHeroic, toggleDifficultyID: 3
					-- or difficultyID == 6 -- 25 Player (Heroic) raid isHeroic, toggleDifficultyID: 4
					or difficultyID == 7 -- Looking For Raid raid Legacy LFRs prior to SoO
					-- or difficultyID == 9 -- 40 Player raid
					or difficultyID == 14 -- Normal raid
					or difficultyID == 15 -- Heroic raid displayHeroic
					or difficultyID == 16 -- Mythic raid isHeroic, displayMythic
					or difficultyID == 17 -- Looking For Raid raid
					-- or difficultyID == 18 -- Event raid
					-- or difficultyID == 33 -- Timewalking raid
					-- or difficultyID == 151 -- Looking For Raid raid Timewalking
					-- scenario
					-- or difficultyID == 11 -- Heroic Scenario	scenario isHeroic
					-- or difficultyID == 12 -- Normal Scenario scenario
					-- or difficultyID == 20 -- Event Scenario scenario
					-- or difficultyID == 25 -- World PvP Scenario scenario
					-- or difficultyID == 30 -- Event scenario
					-- or difficultyID == 32 -- World PvP Scenario scenario
					-- or difficultyID == 38 -- Normal scenario
					-- or difficultyID == 39 -- Heroic scenario displayHeroic
					-- or difficultyID == 40 -- Mythic scenario displayMythic
					-- or difficultyID == 45 -- PvP scenario displayHeroic
					-- or difficultyID == 147 -- Normal scenario Warfronts
					-- or difficultyID == 149 -- Heroic scenario displayHeroic Warfronts
					-- or difficultyID == 152 -- Visions of N'Zoth scenario
					-- or difficultyID == 153 -- Teeming Island scenario displayHeroic
					-- or difficultyID == 167 -- Torghast scenario
					-- or difficultyID == 168 -- Path of Ascension: Courage scenario
					-- or difficultyID == 169 -- Path of Ascension: Loyalty scenario
					-- or difficultyID == 170 -- Path of Ascension: Wisdom scenario
					-- or difficultyID == 171 -- Path of Ascension: Humility scenario
					then
						ObjectiveTrackerFrame:Hide()
					end
				else
					ObjectiveTrackerFrame:Show()
				end
			end
			-- Dump: value=GetInstanceInfo()
			-- [1]="Драконьи острова",
			-- [2]="none",
			-- [3]=0,
			-- [4]="",
			-- [5]=5,
			-- [6]=0,
			-- [7]=false,
			-- [8]=2444,
			-- [9]=0
			-- [21:00] Dump: value=GetInstanceInfo()
			-- [21:00] [1]="Лощина Бурошкуров",
			-- [21:00] [2]="party",
			-- [21:00] [3]=23,
			-- [21:00] [4]="Эпохальный",
			-- [21:00] [5]=5,
			-- [21:00] [6]=0,
			-- [21:00] [7]=false,
			-- [21:00] [8]=2520,
			-- [21:00] [9]=5
			Hide_ObjectivesInInstanceOnLoad()
if E.Octo_Globals.isElvUI == true or E.Octo_Globals.isElvUI == false then
	if ObjectiveTrackerFrame then
		local className, classFilename, classId = UnitClass("PLAYER")
		local classColor = C_ClassColor.GetClassColor(classFilename)
		local r, g, b = classColor:GetRGB()
		local function Current_numQuests()
				local _, numQuests = C_QuestLog.GetNumQuestLogEntries()
				local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
				--return E.Octo_Func.func_Gradient(numQuests.." / "..maxNumQuestsCanAccept, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
				return numQuests.." / "..maxNumQuestsCanAccept
		end
		-- TRACKER_HEADER_OBJECTIVE = "QWE1"
		-- OBJECTIVES_LABEL = "QWE2"
		-- OBJECTIVES_TRACKER_LABEL = "QWE3"
		-- TASKS_COLON = "QWE4"
		-- TRACKER_HEADER_QUESTS = E.Octo_Globals.func_Gradient(TRACKER_HEADER_QUESTS, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
		ObjectiveTrackerFrame.NineSlice.BottomEdge:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.BottomLeftCorner:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.BottomRightCorner:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.Center:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.LeftEdge:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.RightEdge:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.TopEdge:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.TopLeftCorner:Hide()--SetAlpha(0)
		ObjectiveTrackerFrame.NineSlice.TopRightCorner:Hide()--SetAlpha(0)
		Octo_ToDo_Objective = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_Objective", ObjectiveTrackerFrame.NineSlice, "BackDropTemplate")
		-- Octo_ToDo_Objective:RegisterEvent("QUEST_ACCEPTED")
		-- Octo_ToDo_Objective:RegisterEvent("QUEST_COMPLETE")
		-- Octo_ToDo_Objective:RegisterEvent("QUEST_FINISHED")
		Octo_ToDo_Objective:RegisterEvent("QUEST_LOG_UPDATE")
		-- Octo_ToDo_Objective:RegisterEvent("QUEST_REMOVED")
		-- Octo_ToDo_Objective:RegisterEvent("QUEST_TURNED_IN")
		-- PLAYER_ENTERING_WORLD,
		-- QUEST_LOG_UPDATE,
		-- UNIT_QUEST_LOG_CHANGED,
		-- QUEST_DATA_LOAD_RESULT
		Octo_ToDo_Objective:SetAllPoints()
		Octo_ToDo_Objective:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_Objective:SetBackdropBorderColor(0, 0, 0, 1)
		local t = Octo_ToDo_Objective:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_Objective.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		t:SetAllPoints(Octo_ToDo_Objective)
		t:SetColorTexture(0, 0, 0, 0.6)
		local vivod = classColorHexCurrent..TRACKER_HEADER_QUESTS.."|r"
		Octo_ToDo_Objective:SetScript("OnEvent", function(self)
			-- TRACKER_HEADER_QUESTS = vivod.." "..E.Octo_Func.func_Gradient(Current_numQuests(), E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
			TRACKER_HEADER_QUESTS = vivod.." "..Current_numQuests()


		end)
		-- ObjectiveTrackerFrame.NineSlice.MEME = ObjectiveTrackerFrame.NineSlice:CreateTexture(nil, "ARTWORK")
		-- ObjectiveTrackerFrame.NineSlice.MEME:SetPoint("TOPLEFT", 0, 0)
		-- ObjectiveTrackerFrame.NineSlice.MEME:SetPoint("BOTTOMRIGHT", 0, 0)
		-- ObjectiveTrackerFrame.NineSlice.MEME:SetTexture("Interface/AddOns/"..GlobalAddonName.."/Media/MEME/1.tga")
		-- ObjectiveTrackerFrame.NineSlice.MEME:SetColorTexture(1, 1, 1, 1)
		-- ObjectiveTrackerFrame.NineSlice.BottomEdge:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.BottomLeftCorner:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.BottomRightCorner:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.Center:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.LeftEdge:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.RightEdge:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.TopEdge:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.TopLeftCorner:SetColorTexture(0, 0, 0, 1)
		-- ObjectiveTrackerFrame.NineSlice.TopRightCorner:SetColorTexture(0, 0, 0, 1)
		end
		end
	end
end
end)